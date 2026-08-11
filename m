Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827F7C5AC67
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 18:55:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A34A40E18;
	Tue, 11 Aug 2026 20:55:15 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id 83FC140298
 for <dev@dpdk.org>; Tue, 11 Aug 2026 20:55:13 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-9061a795d76so1962886d6.3
 for <dev@dpdk.org>; Tue, 11 Aug 2026 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786474513; x=1787079313; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cCh7TzpVIhEDEFue5Zy54y0b/yOHTDb1jhaNUg7Bo4I=;
 b=CFXxlOgm5hg0kLZ7HG7nn7JYX7Q6MwjL1+epviTvAXOX75mOK/Vxpg5jysvrZBWIQE
 JNxSbvEr8Mnf5qr8MX70Z2W8nueeBs0gVsS9MDjCC5Bj5Bg4SEUW6J0hb4xKBqfPklyu
 +eslEyWQ/qwyslMgjELZ3nf6teeHNEKi8+cAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786474513; x=1787079313;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cCh7TzpVIhEDEFue5Zy54y0b/yOHTDb1jhaNUg7Bo4I=;
 b=AlDxuHQIsLsAoVS1V7xCLnKjJKlU/oNPZXeATiTQx+X6kRRb8m6VsA0RJHELHL7E/P
 Ozsm7cpMOTHAkw8IFXwU2YQZZz2Jt3U8CYrCx6gfrQ3E9gDK6WZOwS0T3FFLVlNLHZuu
 XBSQFd1ywgUJO211i7YX2JsCnAFdek6/OAlVPhTLMkS8Z6iimtN8JW/XJaxTQAP5rJpC
 +L75+zmSyi87JPWphIffuZw+yTvEdWX3mIYLSNDZJtoGGtVvGAaxZ5cYpgKKL6w70TKQ
 KM5XnQsQMBbSYtlA1AC2pn2CQpRWORE12XPxceyWTWi+QqiwMPa+pyGpbQnsTW0TGKe9
 pOQA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrtQ9uomFITcfWpEaPbJk09eKf3rohQ9WR6Kc5+vsfxizIDtlzF0rOOOw1fxe/dXX6eeMo=@dpdk.org
X-Gm-Message-State: AOJu0YyEwBxlWO8QEZ70LF8s5w8L9rtz8nbrZcFvqNv9uB22UT8ooZ/Z
 hBBMFFVrATJlUL1rKyUFGFql12dq296ApXwDllYIeOxSduFPPumKizHGcHj0JKNYTs4=
X-Gm-Gg: AR+sD11QXWV59/xuXVVPKx13td9FfVqi3bNk3KE7W/luQjMXdiSShP61Q5FXsMDJzg1
 8MeRYh8FC0sB8TR+977GNZtGY1OBd2ZtraKiV/AsGoe7izpxIrdrNTtx8YEVJJmYls79Yt8VrDn
 w2rKBHWop23srmtm0GbLxNC+tEjsHnXF229E6OYCdA7RynuJc4U9y7VGjCobcbAF2vH4HevZzKi
 SQuohEIV/ku8VcbnNa0GCw/qPoOLCfNjG6aAimmvas92ZrGTk5wB5dKsgYbdCmFDzqEAlP50zzh
 l8sNZDf+QDjK/OBx1uhNRtvgXKgCMO6knsA74iWAYGooaqjp0aZxhczm6ncdcQ06UdgdpQq/FPK
 qIkGRvPO80OKCOt8XXlSnVKF4hNCkNlGkx5EbhvRvCDRzoZAJz+BwlOBvKjhiHs7bWZBhI455I3
 5k5vm0TYMYZ4QloKmLOeTfhZRWBTpspsT5IdRLBm9UBA13DUPvR7bz4Mqsmn+dXFUi/xdOjOR1f
 NScoNmiVbFNjFSzQJKxhI0poyMSTXD+VExj2cKyBOFBZhFoJqB1zZF34jhaH8LCAjOnWVSYHQnT
 ZNoGTDrSjZv3ewIUzv6afToOz9WLesJkDleFmCWAfy+ssW/FemoniQyq/dcI
X-Received: by 2002:a05:6214:3283:b0:8ec:cdb2:5e11 with SMTP id
 6a1803df08f44-90a6679059bmr55101556d6.2.1786474512472; 
 Tue, 11 Aug 2026 11:55:12 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:af2f:903c:2ca9:975f])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c29a1f3sm5489806d6.17.2026.08.11.11.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 11:55:12 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com,
	dev@dpdk.org
Cc: dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [RFC PATCH] dts: resolve trex driver binding issue
Date: Tue, 11 Aug 2026 14:55:09 -0400
Message-ID: <20260811185509.1650102-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Previously, users were unable to run both functional and performance
test suites in a single DTS run due to driver binding conflicts.
This patch separates traffic generator setup by test suite, in
order to allow running functional and performance test suites in
the same DTS run.

Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
 dts/framework/test_result.py                  |  1 +
 dts/framework/test_run.py                     | 29 +++++++++++---
 dts/framework/test_suite.py                   | 40 +++++++++++++++++++
 dts/framework/testbed_model/linux_session.py  |  6 ++-
 dts/tests/TestSuite_blocklist.py              |  3 +-
 dts/tests/TestSuite_buffer_scatter.py         |  3 +-
 dts/tests/TestSuite_checksum_offload.py       |  3 +-
 dts/tests/TestSuite_cryptodev_latency.py      |  3 +-
 dts/tests/TestSuite_cryptodev_throughput.py   |  3 +-
 dts/tests/TestSuite_dual_vlan.py              |  3 +-
 dts/tests/TestSuite_dynamic_config.py         |  3 +-
 dts/tests/TestSuite_dynamic_queue_conf.py     |  3 +-
 dts/tests/TestSuite_flow_offload.py           |  3 +-
 dts/tests/TestSuite_hello_world.py            |  3 +-
 dts/tests/TestSuite_l2fwd.py                  |  3 +-
 dts/tests/TestSuite_mac_filter.py             |  3 +-
 dts/tests/TestSuite_mtu.py                    |  3 +-
 dts/tests/TestSuite_packet_capture.py         |  3 +-
 dts/tests/TestSuite_port_control.py           |  3 +-
 ...stSuite_port_restart_config_persistency.py |  3 +-
 dts/tests/TestSuite_port_stats.py             |  3 +-
 dts/tests/TestSuite_promisc_support.py        |  3 +-
 dts/tests/TestSuite_qinq.py                   |  3 +-
 dts/tests/TestSuite_queue_toggle.py           |  3 +-
 dts/tests/TestSuite_rss.py                    |  3 +-
 dts/tests/TestSuite_rx_split.py               |  3 +-
 dts/tests/TestSuite_rx_tx_offload.py          |  3 +-
 .../TestSuite_single_core_forward_perf.py     |  3 +-
 dts/tests/TestSuite_smoke_tests.py            |  3 +-
 dts/tests/TestSuite_softnic.py                |  3 +-
 dts/tests/TestSuite_speed_capabilities.py     |  3 +-
 dts/tests/TestSuite_unified_packet.py         |  3 +-
 dts/tests/TestSuite_virtio_forward.py         |  3 +-
 dts/tests/TestSuite_vlan.py                   |  3 +-
 34 files changed, 128 insertions(+), 38 deletions(-)

diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
index 21faa55dc1..13ed8f671c 100644
--- a/dts/framework/test_result.py
+++ b/dts/framework/test_result.py
@@ -117,6 +117,7 @@ class ResultNode(BaseModel):
     label: str
     children: list[Union["ResultNode", ResultLeaf]] = Field(default_factory=list)
     parent: Union["ResultNode", None] = None
+    ports: list[dict[str, str]] | None = None
 
     def add_child(self, label: str) -> "ResultNode":
         """Creates and append a child node to the model.
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index c20a0fa885..b23930b953 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -115,7 +115,7 @@
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
 from framework.test_result import Result, ResultNode, TestRunResult
-from framework.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
+from framework.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite, TestSuiteType
 from framework.testbed_model.capability import (
     Capability,
     get_supported_capabilities,
@@ -375,11 +375,6 @@ def next(self) -> State | None:
             ctx.topology.bind_cryptodevs("dpdk")
 
         ctx.topology.configure_ports("sut", "dpdk")
-        if ctx.func_tg and ctx.topology.type is not LinkTopology.NO_LINK:
-            ctx.func_tg.setup(ctx.topology)
-        if ctx.perf_tg and ctx.topology.type is not LinkTopology.NO_LINK:
-            ctx.perf_tg.setup(ctx.topology)
-
         self.result.ports = [
             port.to_dict() for port in ctx.topology.sut_ports + ctx.topology.tg_ports
         ]
@@ -506,12 +501,34 @@ class TestSuiteSetup(TestSuiteState):
     """Test suite setup."""
 
     logger_name: ClassVar[str] = "test_suite_setup"
+    test_run: TestRun
 
     def before(self) -> None:
         """Hook before the state is processed."""
         super().before()
         self.logger.set_custom_log_file(self.test_suite.name)
 
+        ctx = self.test_run.ctx
+        testsuite_type = self.test_suite.testsuite_type
+        if (
+            ctx.topology.type is not LinkTopology.NO_LINK
+            and testsuite_type is not TestSuiteType.CRYPTO
+        ):
+            if testsuite_type == TestSuiteType.FUNC:
+                required_tg, other_tg = ctx.func_tg, ctx.perf_tg
+            else:
+                required_tg, other_tg = ctx.perf_tg, ctx.func_tg
+
+            if other_tg and other_tg.is_setup:
+                other_tg.teardown()
+
+                if testsuite_type == TestSuiteType.FUNC and ctx.tg_node:
+                    for port in ctx.topology.tg_ports:
+                        ctx.tg_node.main_session.bind_ports_to_driver([port], port.config.os_driver)
+
+            if required_tg and not required_tg.is_setup:
+                required_tg.setup(ctx.topology)
+
     @property
     def description(self) -> str:
         """State description."""
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 69ce26040a..554fe3a475 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -45,6 +45,17 @@ class BaseConfig(FrozenModel):
     """Base for a custom test suite configuration."""
 
 
+class TestSuiteType(Enum):
+    """Enum to specify test suite type."""
+
+    FUNC = auto()
+    PERF = auto()
+    CRYPTO = auto()
+
+
+TestSuiteClassType = TypeVar("TestSuiteClassType", bound=type["TestSuite"])
+
+
 class TestSuite(TestProtocol):
     """The base class with building blocks needed by most test cases.
 
@@ -85,6 +96,30 @@ class TestSuite(TestProtocol):
     _sut_ip_address_egress: Union[IPv4Interface, IPv6Interface]
     _tg_ip_address_ingress: Union[IPv4Interface, IPv6Interface]
     _tg_ip_address_egress: Union[IPv4Interface, IPv6Interface]
+    testsuite_type: ClassVar[TestSuiteType]
+
+    @classmethod
+    def make_decorator(
+        cls, testsuite_type: TestSuiteType
+    ) -> Callable[[TestSuiteClassType], TestSuiteClassType]:
+        """Creates a decorator for test suites.
+
+        The decorator casts the decorated function as :class:`TestSuite`,
+        sets it as `testsuite_type` and initializes a variable to
+        determine the type of test suite.
+
+        Args:
+            testsuite_type: A functional, performance, or cryptodev test suite.
+
+        Returns:
+            The decorator of a functional, performance, or cryptodev test suite.
+        """
+
+        def _decorator(testsuite_cls: TestSuiteClassType) -> TestSuiteClassType:
+            testsuite_cls.testsuite_type = testsuite_type
+            return testsuite_cls
+
+        return _decorator
 
     def __init__(self, config: BaseConfig) -> None:
         """Initialize the test suite testbed information and basic configuration.
@@ -270,6 +305,11 @@ def _adjust_addresses(self, packets: list[Packet], expected: bool = False) -> li
         return ret_packets
 
 
+#: Test suite type decorators
+func_suite: Callable[[Any], type["TestSuite"]] = TestSuite.make_decorator(TestSuiteType.FUNC)
+perf_suite: Callable[[Any], type["TestSuite"]] = TestSuite.make_decorator(TestSuiteType.PERF)
+crypto_suite: Callable[[Any], type["TestSuite"]] = TestSuite.make_decorator(TestSuiteType.CRYPTO)
+
 #: The generic type for a method of an instance of TestSuite
 TestSuiteMethodType = TypeVar("TestSuiteMethodType", bound=Callable[[TestSuite], None])
 
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index c118f803b6..861b09e413 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -278,7 +278,8 @@ def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
             verify=True,
         )
 
-        del self._lshw_net_info
+        if self._lshw_net_info:
+            del self._lshw_net_info
 
     def bring_up_link(self, ports: Iterable[Port]) -> None:
         """Overrides :meth:`~.os_session.OSSession.bring_up_link`."""
@@ -287,7 +288,8 @@ def bring_up_link(self, ports: Iterable[Port]) -> None:
                 f"ip link set dev {port.logical_name} up", privileged=True, verify=True
             )
 
-        del self._lshw_net_info
+        if self._lshw_net_info:
+            del self._lshw_net_info
 
     def set_interface_link_up(self, name: str) -> None:
         """Overrides :meth:`~.os_session.OSSession.set_interface_link_up`."""
diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index c57231de22..46c5ff57cb 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -12,10 +12,11 @@
 )
 from api.test import verify
 from api.testpmd import TestPmd
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 from framework.testbed_model.port import Port
 
 
+@func_suite
 class TestBlocklist(TestSuite):
     """DPDK device blocklisting test suite."""
 
diff --git a/dts/tests/TestSuite_buffer_scatter.py b/dts/tests/TestSuite_buffer_scatter.py
index 539082f2e4..b9064e8022 100644
--- a/dts/tests/TestSuite_buffer_scatter.py
+++ b/dts/tests/TestSuite_buffer_scatter.py
@@ -30,11 +30,12 @@
 from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATTER)
+@func_suite
 class TestBufferScatter(TestSuite):
     """DPDK PMD packet scattering test suite.
 
diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index 90ca798e56..2a9d4ef631 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -28,12 +28,13 @@
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import ChecksumOffloadOptions, PacketOffloadFlag
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_UDP_CKSUM)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_TCP_CKSUM)
+@func_suite
 class TestChecksumOffload(TestSuite):
     """Checksum offload test suite.
 
diff --git a/dts/tests/TestSuite_cryptodev_latency.py b/dts/tests/TestSuite_cryptodev_latency.py
index 4e7d814faa..e63c43a12b 100644
--- a/dts/tests/TestSuite_cryptodev_latency.py
+++ b/dts/tests/TestSuite_cryptodev_latency.py
@@ -31,7 +31,7 @@
 )
 from api.test import skip, verify
 from framework.context import get_ctx
-from framework.test_suite import BaseConfig, TestSuite, crypto_test
+from framework.test_suite import BaseConfig, TestSuite, crypto_suite, crypto_test
 from framework.testbed_model.virtual_device import VirtualDevice
 
 config_list: list[dict[str, int | float | str]] = [
@@ -73,6 +73,7 @@ class Config(BaseConfig):
 
 
 @requires_link_topology(LinkTopology.NO_LINK)
+@crypto_suite
 class TestCryptodevLatency(TestSuite):
     """DPDK Crypto Device Testing Suite."""
 
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index 2fc0d8779a..93727d90d4 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -32,7 +32,7 @@
 from api.test import verify
 from framework.context import get_ctx
 from framework.exception import SkippedTestException
-from framework.test_suite import BaseConfig, TestSuite, crypto_test
+from framework.test_suite import BaseConfig, TestSuite, crypto_suite, crypto_test
 from framework.testbed_model.virtual_device import VirtualDevice
 
 config_list: list[dict[str, int | float | str]] = [
@@ -75,6 +75,7 @@ class Config(BaseConfig):
 
 
 @requires_link_topology(LinkTopology.NO_LINK)
+@crypto_suite
 class TestCryptodevThroughput(TestSuite):
     """DPDK Crypto Device Testing Suite."""
 
diff --git a/dts/tests/TestSuite_dual_vlan.py b/dts/tests/TestSuite_dual_vlan.py
index 1b77dd2b47..8676a65c80 100644
--- a/dts/tests/TestSuite_dual_vlan.py
+++ b/dts/tests/TestSuite_dual_vlan.py
@@ -23,9 +23,10 @@
 from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
+@func_suite
 class TestDualVlan(TestSuite):
     """DPDK Dual VLAN test suite.
 
diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dynamic_config.py
index 7204ec4f73..94554a735e 100644
--- a/dts/tests/TestSuite_dynamic_config.py
+++ b/dts/tests/TestSuite_dynamic_config.py
@@ -29,11 +29,12 @@
 from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_link_topology(LinkTopology.TWO_LINKS)
+@func_suite
 class TestDynamicConfig(TestSuite):
     """Dynamic config suite.
 
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index 5ac85bee7d..c92edc7306 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -40,7 +40,7 @@
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
 from framework.exception import InteractiveCommandExecutionError
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
 def setup_and_teardown_test(
@@ -121,6 +121,7 @@ def _wrap(self: "TestDynamicQueueConf", is_rx_testing: bool) -> None:
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@func_suite
 class TestDynamicQueueConf(TestSuite):
     """DPDK dynamic queue configuration test suite.
 
diff --git a/dts/tests/TestSuite_flow_offload.py b/dts/tests/TestSuite_flow_offload.py
index be11d09875..d955eb7d7d 100644
--- a/dts/tests/TestSuite_flow_offload.py
+++ b/dts/tests/TestSuite_flow_offload.py
@@ -30,7 +30,7 @@
     SkippedTestException,
     TestCaseVerifyError,
 )
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
 @dataclass
@@ -402,6 +402,7 @@ def generate(
 
 
 @requires_nic_capability(NicCapability.FLOW_CTRL)
+@func_suite
 class TestFlowOffload(TestSuite):
     """Flow offload test suite.
 
diff --git a/dts/tests/TestSuite_hello_world.py b/dts/tests/TestSuite_hello_world.py
index bf1a93c782..0beb144644 100644
--- a/dts/tests/TestSuite_hello_world.py
+++ b/dts/tests/TestSuite_hello_world.py
@@ -10,7 +10,7 @@
 
 from api.test import log
 from api.testpmd import TestPmd
-from framework.test_suite import BaseConfig, TestSuite, func_test
+from framework.test_suite import BaseConfig, TestSuite, func_suite, func_test
 
 
 class Config(BaseConfig):
@@ -20,6 +20,7 @@ class Config(BaseConfig):
     msg: str = "Hello World!"
 
 
+@func_suite
 class TestHelloWorld(TestSuite):
     """Hello World test suite. One test case, which starts and stops a testpmd session."""
 
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index 596b892730..3f9f1dd12d 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -21,13 +21,14 @@
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer, SimpleForwardingModes
 from framework.context import filter_cores
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 from framework.testbed_model.cpu import LogicalCoreCount
 from framework.utils import generate_random_packets
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_link_topology(LinkTopology.TWO_LINKS)
+@func_suite
 class TestL2fwd(TestSuite):
     """L2 forwarding test suite."""
 
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_filter.py
index a7e24b37d5..def0b97856 100644
--- a/dts/tests/TestSuite_mac_filter.py
+++ b/dts/tests/TestSuite_mac_filter.py
@@ -27,10 +27,11 @@
 from api.test import fail, verify
 from api.testpmd import TestPmd
 from framework.exception import InteractiveCommandExecutionError
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@func_suite
 class TestMacFilter(TestSuite):
     """Mac address allowlist filtering test suite.
 
diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
index 8355495d33..06de6c9c1a 100644
--- a/dts/tests/TestSuite_mtu.py
+++ b/dts/tests/TestSuite_mtu.py
@@ -24,7 +24,7 @@
 from api.packet import send_packet_and_capture
 from api.test import verify
 from api.testpmd import TestPmd
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 STANDARD_FRAME = 1518  # --max-pkt-len will subtract l2 information at a minimum of 18 bytes.
 JUMBO_FRAME = 9018
@@ -37,6 +37,7 @@
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@func_suite
 class TestMtu(TestSuite):
     """DPDK PMD jumbo frames and MTU update test suite.
 
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index 4bd15e2401..f26b03f46f 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -40,7 +40,7 @@
 from framework.params import Params
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.dpdk_shell import compute_eal_params
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 from framework.testbed_model.cpu import LogicalCoreList
 from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
@@ -67,6 +67,7 @@ class DumpcapParams(Params):
 
 
 @requires_link_topology(LinkTopology.TWO_LINKS)
+@func_suite
 class TestPacketCapture(TestSuite):
     """Packet Capture TestSuite.
 
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port_control.py
index b51fdc2959..858ab3af8b 100644
--- a/dts/tests/TestSuite_port_control.py
+++ b/dts/tests/TestSuite_port_control.py
@@ -20,10 +20,11 @@
 from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@func_suite
 class TestPortControl(TestSuite):
     """DPDK Port Control Testing Suite."""
 
diff --git a/dts/tests/TestSuite_port_restart_config_persistency.py b/dts/tests/TestSuite_port_restart_config_persistency.py
index 4ea22b6d70..646e80651b 100644
--- a/dts/tests/TestSuite_port_restart_config_persistency.py
+++ b/dts/tests/TestSuite_port_restart_config_persistency.py
@@ -16,13 +16,14 @@
 from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.types import TestPmdPortFlowCtrl
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 ALTERNATIVE_MTU: int = 800
 STANDARD_MTU: int = 1500
 ALTERNATIVE_MAC_ADDRESS: str = "42:A6:B7:9E:B4:81"
 
 
+@func_suite
 class TestPortRestartConfigPersistency(TestSuite):
     """Port config persistency test suite."""
 
diff --git a/dts/tests/TestSuite_port_stats.py b/dts/tests/TestSuite_port_stats.py
index 3dc045f847..a737c17fb0 100644
--- a/dts/tests/TestSuite_port_stats.py
+++ b/dts/tests/TestSuite_port_stats.py
@@ -28,11 +28,12 @@
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_link_topology(LinkTopology.TWO_LINKS)
+@func_suite
 class TestPortStats(TestSuite):
     """DPDK Port statistics testing suite.
 
diff --git a/dts/tests/TestSuite_promisc_support.py b/dts/tests/TestSuite_promisc_support.py
index a0c65dc662..1907e779f8 100644
--- a/dts/tests/TestSuite_promisc_support.py
+++ b/dts/tests/TestSuite_promisc_support.py
@@ -22,10 +22,11 @@
 )
 from api.test import verify
 from api.testpmd import TestPmd
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@func_suite
 class TestPromiscSupport(TestSuite):
     """Promiscuous mode support test suite."""
 
diff --git a/dts/tests/TestSuite_qinq.py b/dts/tests/TestSuite_qinq.py
index 505d71dbc8..8fa4db2ab6 100644
--- a/dts/tests/TestSuite_qinq.py
+++ b/dts/tests/TestSuite_qinq.py
@@ -19,9 +19,10 @@
 from api.packet import send_packet_and_capture
 from api.test import log, verify
 from api.testpmd import TestPmd
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
+@func_suite
 class TestQinq(TestSuite):
     """QinQ test suite.
 
diff --git a/dts/tests/TestSuite_queue_toggle.py b/dts/tests/TestSuite_queue_toggle.py
index e4edc89123..97e80965d8 100644
--- a/dts/tests/TestSuite_queue_toggle.py
+++ b/dts/tests/TestSuite_queue_toggle.py
@@ -26,12 +26,13 @@
 from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
 @requires_link_topology(LinkTopology.TWO_LINKS)
 @requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)
 @requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)
+@func_suite
 class TestQueueToggle(TestSuite):
     """DPDK Queue start/stop test suite.
 
diff --git a/dts/tests/TestSuite_rss.py b/dts/tests/TestSuite_rss.py
index 2747c8a36c..062b2d8891 100644
--- a/dts/tests/TestSuite_rss.py
+++ b/dts/tests/TestSuite_rss.py
@@ -30,7 +30,7 @@
     TestPmdVerbosePacket,
 )
 from framework.exception import InteractiveCommandExecutionError
-from framework.test_suite import BaseConfig, TestSuite, func_test
+from framework.test_suite import BaseConfig, TestSuite, func_suite, func_test
 from framework.utils import StrEnum
 
 
@@ -55,6 +55,7 @@ class HashAlgorithm(StrEnum):
 
 @requires_link_topology(LinkTopology.ONE_LINK)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_RSS_HASH)
+@func_suite
 class TestRss(TestSuite):
     """RSS test suite."""
 
diff --git a/dts/tests/TestSuite_rx_split.py b/dts/tests/TestSuite_rx_split.py
index 5117a569e2..8b9cf38095 100644
--- a/dts/tests/TestSuite_rx_split.py
+++ b/dts/tests/TestSuite_rx_split.py
@@ -24,7 +24,7 @@
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import RxOffloadCapability, TxOffloadCapability
 from framework.exception import InteractiveCommandExecutionError
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 PAYLOAD = bytes(range(256))
 ETHER_HDR_LEN = len(Ether(dst="00:00:00:00:00:00"))
@@ -35,6 +35,7 @@
 
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_BUFFER_SPLIT)
 @requires_nic_capability(NicCapability.SELECTIVE_RX)
+@func_suite
 class TestRxSplit(TestSuite):
     """Rx split test suite.
 
diff --git a/dts/tests/TestSuite_rx_tx_offload.py b/dts/tests/TestSuite_rx_tx_offload.py
index b0da627d3c..4a4607c685 100644
--- a/dts/tests/TestSuite_rx_tx_offload.py
+++ b/dts/tests/TestSuite_rx_tx_offload.py
@@ -18,10 +18,11 @@
     OffloadConfiguration,
     RxTxLiteralSwitch,
 )
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
 @requires_link_topology(LinkTopology.ONE_LINK)
+@func_suite
 class TestRxTxOffload(TestSuite):
     """RX/TX offload test suite."""
 
diff --git a/dts/tests/TestSuite_single_core_forward_perf.py b/dts/tests/TestSuite_single_core_forward_perf.py
index 57aecdf7a4..f30a5322a0 100644
--- a/dts/tests/TestSuite_single_core_forward_perf.py
+++ b/dts/tests/TestSuite_single_core_forward_perf.py
@@ -25,7 +25,7 @@
 from api.testpmd import TestPmd
 from api.testpmd.config import RXRingParams, TXRingParams
 from framework.params.types import TestPmdParamsDict
-from framework.test_suite import BaseConfig, TestSuite, perf_test
+from framework.test_suite import BaseConfig, TestSuite, perf_suite, perf_test
 
 
 class Config(BaseConfig):
@@ -42,6 +42,7 @@ class Config(BaseConfig):
     delta_tolerance: float = 0.05
 
 
+@perf_suite
 @requires_link_topology(LinkTopology.TWO_LINKS)
 class TestSingleCoreForwardPerf(TestSuite):
     """Single core forwarding performance test suite."""
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index 271ad4301c..368614e7ed 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -22,12 +22,13 @@
 from api.testpmd import TestPmd
 from framework.config.node import PortConfig
 from framework.settings import SETTINGS
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 from framework.testbed_model.linux_session import LinuxSession
 from framework.utils import REGEX_FOR_PCI_ADDRESS
 
 
 @requires_link_topology(LinkTopology.NO_LINK)
+@func_suite
 class TestSmokeTests(TestSuite):
     """DPDK and infrastructure smoke test suite.
 
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index fa91f7ee2f..07da406a2d 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -20,13 +20,14 @@
 )
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 from framework.testbed_model.virtual_device import VirtualDevice
 from framework.utils import generate_random_packets
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_link_topology(LinkTopology.TWO_LINKS)
+@func_suite
 class TestSoftnic(TestSuite):
     """Softnic test suite."""
 
diff --git a/dts/tests/TestSuite_speed_capabilities.py b/dts/tests/TestSuite_speed_capabilities.py
index 9cbd6f1ef7..5fbe1fe5c3 100644
--- a/dts/tests/TestSuite_speed_capabilities.py
+++ b/dts/tests/TestSuite_speed_capabilities.py
@@ -14,7 +14,7 @@
 )
 from api.test import verify
 from api.testpmd import TestPmd
-from framework.test_suite import BaseConfig, TestSuite, func_test
+from framework.test_suite import BaseConfig, TestSuite, func_suite, func_test
 
 
 class Config(BaseConfig):
@@ -39,6 +39,7 @@ class Config(BaseConfig):
 
 
 @requires_link_topology(LinkTopology.ONE_LINK)
+@func_suite
 class TestSpeedCapabilities(TestSuite):
     """Speed capabilities test suite."""
 
diff --git a/dts/tests/TestSuite_unified_packet.py b/dts/tests/TestSuite_unified_packet.py
index fcc7f7fbbb..05f52d5690 100644
--- a/dts/tests/TestSuite_unified_packet.py
+++ b/dts/tests/TestSuite_unified_packet.py
@@ -28,9 +28,10 @@
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
+@func_suite
 class TestUnifiedPacket(TestSuite):
     """DPDK Unified packet test suite.
 
diff --git a/dts/tests/TestSuite_virtio_forward.py b/dts/tests/TestSuite_virtio_forward.py
index 6efaa4e156..c2a4a4612e 100644
--- a/dts/tests/TestSuite_virtio_forward.py
+++ b/dts/tests/TestSuite_virtio_forward.py
@@ -14,12 +14,13 @@
 from api.test import log, verify
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 from framework.testbed_model.capability import requires
 from framework.testbed_model.linux_session import LinuxSession
 from framework.testbed_model.virtual_device import VirtualDevice
 
 
+@func_suite
 class TestVirtioForward(TestSuite):
     """Virtio forwarding test suite."""
 
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index 898673fc86..14011da087 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -25,10 +25,11 @@
 from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
+from framework.test_suite import TestSuite, func_suite, func_test
 
 
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)
+@func_suite
 class TestVlan(TestSuite):
     """DPDK VLAN test suite.
 
-- 
2.55.0

