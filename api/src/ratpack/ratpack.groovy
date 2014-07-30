import org.apache.curator.framework.CuratorFramework
import org.apache.curator.framework.CuratorFrameworkFactory
import org.apache.curator.retry.ExponentialBackoffRetry
import org.apache.curator.x.discovery.ServiceDiscoveryBuilder
import org.apache.curator.x.discovery.ServiceInstance
import org.slf4j.LoggerFactory

import static ratpack.groovy.Groovy.ratpack

ratpack {
  bindings {
    def zkConnection = System.getenv()['ZOO']
    if (!zkConnection) {
      LoggerFactory.getLogger('Service Initialization').error('Environment variable ZOO not set!')
      System.exit(-1)
    }
    def curator = CuratorFrameworkFactory.newClient(zkConnection, new ExponentialBackoffRetry(1000, 3))
    curator.start()
    bind(CuratorFramework, curator)
    def discoveryBuilder = ServiceDiscoveryBuilder.builder(Void)
    def serviceDiscovery = discoveryBuilder.basePath('apis').client(curator).build()

    def addresses = NetworkInterface.getByName('eth0').inetAddresses
    def serviceIp = (addresses.find { it instanceof Inet4Address } as Inet4Address).hostAddress

    def serviceInstance = ServiceInstance.builder().address(serviceIp).name('myLittleApi').port(5050).build()

    serviceDiscovery.start()
    serviceDiscovery.registerService serviceInstance
  }
  handlers {
    get {
      def hostname = System.getenv()['HOSTNAME']
      if (hostname) {
        response.headers.set('Via', hostname)
      }
      response.status 200
      response.send 'Hi there! Dude!'
    }
  }
}
