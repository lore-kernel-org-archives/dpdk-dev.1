Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9E4606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=EuBDmz28
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0E6D40264;
	Thu, 22 Oct 2026 20:00:14 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id BFB154003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 20:00:12 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-93efc0452b5so3741085a.0
 for <dev@dpdk.org>; Thu, 22 Oct 2026 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792692012; x=1793296812; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bZYsPxv1/hjCdOtkuJ/PVmgJvAHgunJHhzRO4JzL6U8=;
 b=EuBDmz28JSIgwvfxk6yy1zycInQslqZjpfa9ikuVQgsoJTyLUFt5sxxp7Ccnrh2gvf
 hSKZlHO9/+Nf18lQSDAVusgsvrqGrtA74uYAZxAaBvultBKRjL5+j/lnpmW51jP3bDrt
 PhHVpmAWszDuSsvzWIP/yxVXFcU8HiYVlBmHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792692012; x=1793296812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bZYsPxv1/hjCdOtkuJ/PVmgJvAHgunJHhzRO4JzL6U8=;
 b=RdAQcXDUxg9RxNx6PxxW62my9ljynqgY7MgNr4uXK30qw7qYpH6KqSPilDkw9ob8qg
 jbcnmXnLDUxNvLf2O8XMiwTbrCIP2wZI1jXj/tT/VYUlGM8Jv9HHVo/UZAfqEbDt2mhO
 YJ5wEr98Tchv2CC9fHQ6oyG7lHf3ZDHjCWbnjpagQFd3leUG2ZZnSrUGZGpLXtirHX8c
 bha5/7OOvuRq99e11742eTxMtEtOLcHI6GsVGjh0roQdqBfI6l2vvWTq6ri2j7NhXMF7
 Ur6Vei/rrF7Yhx0vKSxlesqK/oPUbO30uzuR2+72IA8wtju91ECy28xSgc5oMv8I/LXL
 W0BQ==
X-Gm-Message-State: AFq9FYIW/Dqlq60vVB4qfYgG0dNuoUm+o7UKjUdQyGjQuXdatEIweUKa
 G9K35UOXz3O7dRNybgOlky9m3ToXw5AcfgOQfuecULpC79A3wsZ3Q30rwvTVnMvBxhg=
X-Gm-Gg: AYBFou04La50giWcsdrf2Xb1q1sw9+2YErRbIKY4gaCNCe/vQ9M1qKN1CCYR6NgdgXD
 3LZYYGh9uNZ7a+MTctL17Y9lCRf+nSB4nKmaZh0klTH4QN/MLgGZR93/gScIL7SB9avOAlKKQaM
 ylilyp64qdmeSjTXQyNf4k7IdPJSk0DOHC8uTBSHoen42qdqZQAgA36Mqtq/2Q1tQGoeFyFhdNk
 vpkgcEDvg+erSzTQlvPQjR3PEneTIRUuBxH4KyaPS9AuK3KwXSAy68YRdo6ZRv81T5H7j7rwNGM
 PVHXwZN+f440wfSLwvcr7lkFwcSmhTlEPJ6xOf6NOYC8UFP1ywjhAWxKujiwfJ/qhWgj2QLMvPB
 Fm9DAe8QyMGSdaDA37pnE9EJKLuu4B9wiN8AmykKA//COnk3u/IlBWdKpd+ikC5o6eMnp8g99L+
 GSrLw36ZCw2A/PIYGKGZ+tFUfWqAoM/D85XnL7DReXJwq39U+uZhNaERFNiTF878Eizk40zVnHo
 mDw73zxuIR7+McQ9pmxvI5XzQ0m5LCyDdNKE/g5v7kxUVbIp5CxOV3KGhbp7ZTTy9HI/LryBkCp
 OKEbldl9G6JWIAIMF2Lq45t6ZDstyY+tijj/DFQNop1Agzwscst3K080zGUDIiBOXor24+mqOrp
 +n/lmxbARytcT+CNkXOY9w5KprUIFobpqnL5vnl0RgiVIW6XPaA==
X-Received: by 2002:a05:620a:8013:b0:93e:ad16:9590 with SMTP id
 af79cd13be357-93f6f953154mr33835285a.36.1792692011027; 
 Thu, 22 Oct 2026 11:00:11 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:79a6:f2bd:f6a:842d])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f6fba8ea4sm10243885a.17.2026.10.22.11.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 11:00:10 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v2] dts: resolve trex driver binding issue
Date: Thu, 22 Oct 2026 14:00:02 -0400
Message-ID: <20261022180002.438113-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260811185509.1650102-1-knimoji@iol.unh.edu>
References: <20260811185509.1650102-1-knimoji@iol.unh.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Previously, users were unable to run both functional and performance
test suites in a single DTS run due to driver binding conflicts.
This patch separates traffic generator setup by test suite, in
order to allow running functional and performance test suites in
the same DTS run.

Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
v2:
     *Added TRex TG teardown to re-bind ports
      to kernel driver
---
 dts/api/test_suite.py                         | 40 +++++++++++++++++++
 dts/framework/test_run.py                     | 24 ++++++++---
 dts/framework/testbed_model/linux_session.py  |  6 ++-
 .../testbed_model/traffic_generator/trex.py   | 10 +++++
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
 34 files changed, 132 insertions(+), 38 deletions(-)

diff --git a/dts/api/test_suite.py b/dts/api/test_suite.py
index c30d447135..11027344d0 100644
--- a/dts/api/test_suite.py
+++ b/dts/api/test_suite.py
@@ -44,6 +44,17 @@ class BaseConfig(FrozenModel):
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
 
@@ -84,6 +95,30 @@ class TestSuite(TestProtocol):
     _sut_ip_address_egress: Union[IPv4Interface, IPv6Interface]
     _tg_ip_address_ingress: Union[IPv4Interface, IPv6Interface]
     _tg_ip_address_egress: Union[IPv4Interface, IPv6Interface]
+    test_suite_type: ClassVar[TestSuiteType]
+
+    @classmethod
+    def make_decorator(
+        cls, test_suite_type: TestSuiteType
+    ) -> Callable[[TestSuiteClassType], TestSuiteClassType]:
+        """Creates a decorator for test suites.
+
+        The decorator casts the decorated function as :class:`TestSuite`,
+        sets it as `testsuite_type` and initializes a variable to
+        determine the type of test suite.
+
+        Args:
+            test_suite_type: A functional, performance, or cryptodev test suite.
+
+        Returns:
+            The decorator of a functional, performance, or cryptodev test suite.
+        """
+
+        def _decorator(test_suite_cls: TestSuiteClassType) -> TestSuiteClassType:
+            test_suite_cls.test_suite_type = test_suite_type
+            return test_suite_cls
+
+        return _decorator
 
     def __init__(self, config: BaseConfig) -> None:
         """Initialize the test suite testbed information and basic configuration.
@@ -269,6 +304,11 @@ def _adjust_addresses(self, packets: list[Packet], expected: bool = False) -> li
         return ret_packets
 
 
+#: Test suite type decorators
+func_suite: Callable[[Any], type["TestSuite"]] = TestSuite.make_decorator(TestSuiteType.FUNC)
+perf_suite: Callable[[Any], type["TestSuite"]] = TestSuite.make_decorator(TestSuiteType.PERF)
+crypto_suite: Callable[[Any], type["TestSuite"]] = TestSuite.make_decorator(TestSuiteType.CRYPTO)
+
 #: The generic type for a method of an instance of TestSuite
 TestSuiteMethodType = TypeVar("TestSuiteMethodType", bound=Callable[[TestSuite], None])
 
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 210ff25af7..3890606512 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -110,7 +110,7 @@
 from api.capabilities import LinkTopology
 from api.context import Context, init_ctx
 from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
-from api.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
+from api.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite, TestSuiteType
 from api.testbed_model.capability import (
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
@@ -512,6 +507,23 @@ def before(self) -> None:
         super().before()
         self.logger.set_custom_log_file(self.test_suite.name)
 
+        ctx = self.test_run.ctx
+        test_suite_type = self.test_suite.test_suite_type
+        if (
+            ctx.topology.type is not LinkTopology.NO_LINK
+            and test_suite_type is not TestSuiteType.CRYPTO
+        ):
+            if test_suite_type == TestSuiteType.FUNC:
+                required_tg, other_tg = ctx.func_tg, ctx.perf_tg
+            else:
+                required_tg, other_tg = ctx.perf_tg, ctx.func_tg
+
+            if other_tg and other_tg.is_setup:
+                other_tg.teardown()
+
+            if required_tg and not required_tg.is_setup:
+                required_tg.setup(ctx.topology)
+
     @property
     def description(self) -> str:
         """State description."""
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 8cc0d09d01..fe3f1a8fc3 100644
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
diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
index 7ce1d40d79..98f28db183 100644
--- a/dts/framework/testbed_model/traffic_generator/trex.py
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -314,3 +314,13 @@ def close(self) -> None:
         """
         self._trex_app.close()
         self._shell.close()
+
+    def teardown(self):
+        """Overrides :meth:`.traffic_generator.TrafficGenerator.teardown`.
+
+        Teardown the TRex traffic generator.
+        """
+        super().teardown()
+        if self._tg_node and self._topology:
+            for port in self._topology.tg_ports:
+                self._tg_node.main_session.bind_ports_to_driver([port], port.config.os_driver)
diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index 31e69c0de9..e32f31b383 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -11,11 +11,12 @@
     requires_link_topology,
 )
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testbed_model.port import Port
 from api.testpmd import TestPmd
 
 
+@func_suite
 class TestBlocklist(TestSuite):
     """DPDK device blocklisting test suite."""
 
diff --git a/dts/tests/TestSuite_buffer_scatter.py b/dts/tests/TestSuite_buffer_scatter.py
index cd1a52ad5e..adc8e41700 100644
--- a/dts/tests/TestSuite_buffer_scatter.py
+++ b/dts/tests/TestSuite_buffer_scatter.py
@@ -28,13 +28,14 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATTER)
+@func_suite
 class TestBufferScatter(TestSuite):
     """DPDK PMD packet scattering test suite.
 
diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index a2ea13991b..8c16706f1b 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -25,7 +25,7 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import ChecksumOffloadOptions, PacketOffloadFlag
@@ -34,6 +34,7 @@
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_UDP_CKSUM)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_TCP_CKSUM)
+@func_suite
 class TestChecksumOffload(TestSuite):
     """Checksum offload test suite.
 
diff --git a/dts/tests/TestSuite_cryptodev_latency.py b/dts/tests/TestSuite_cryptodev_latency.py
index 444a5b282c..bf3b9b5761 100644
--- a/dts/tests/TestSuite_cryptodev_latency.py
+++ b/dts/tests/TestSuite_cryptodev_latency.py
@@ -31,7 +31,7 @@
     CryptodevResults,
 )
 from api.test import skip, verify
-from api.test_suite import BaseConfig, TestSuite, crypto_test
+from api.test_suite import BaseConfig, TestSuite, crypto_suite, crypto_test
 from api.testbed_model.virtual_device import VirtualDevice
 
 config_list: list[dict[str, int | float | str]] = [
@@ -73,6 +73,7 @@ class Config(BaseConfig):
 
 
 @requires_link_topology(LinkTopology.NO_LINK)
+@crypto_suite
 class TestCryptodevLatency(TestSuite):
     """DPDK Crypto Device Testing Suite."""
 
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index 59f64f2cd7..7a364a1dc4 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -31,7 +31,7 @@
     CryptodevResults,
 )
 from api.test import skip, verify
-from api.test_suite import BaseConfig, TestSuite, crypto_test
+from api.test_suite import BaseConfig, TestSuite, crypto_suite, crypto_test
 from api.testbed_model.virtual_device import VirtualDevice
 
 config_list: list[dict[str, int | float | str]] = [
@@ -74,6 +74,7 @@ class Config(BaseConfig):
 
 
 @requires_link_topology(LinkTopology.NO_LINK)
+@crypto_suite
 class TestCryptodevThroughput(TestSuite):
     """DPDK Crypto Device Testing Suite."""
 
diff --git a/dts/tests/TestSuite_dual_vlan.py b/dts/tests/TestSuite_dual_vlan.py
index f3347a6d52..6038899c5c 100644
--- a/dts/tests/TestSuite_dual_vlan.py
+++ b/dts/tests/TestSuite_dual_vlan.py
@@ -21,11 +21,12 @@
 from api.capabilities import LinkTopology, requires_link_topology
 from api.packet import send_packet_and_capture
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 
 
+@func_suite
 class TestDualVlan(TestSuite):
     """DPDK Dual VLAN test suite.
 
diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dynamic_config.py
index b9e2c30da1..e071e63a6d 100644
--- a/dts/tests/TestSuite_dynamic_config.py
+++ b/dts/tests/TestSuite_dynamic_config.py
@@ -27,13 +27,14 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_link_topology(LinkTopology.TWO_LINKS)
+@func_suite
 class TestDynamicConfig(TestSuite):
     """Dynamic config suite.
 
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index 24584c7d60..bc11d1ce1f 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -38,7 +38,7 @@
 from api.exception import InteractiveCommandExecutionError
 from api.packet import send_packets
 from api.test import fail, verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
 
@@ -121,6 +121,7 @@ def _wrap(self: "TestDynamicQueueConf", is_rx_testing: bool) -> None:
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@func_suite
 class TestDynamicQueueConf(TestSuite):
     """DPDK dynamic queue configuration test suite.
 
diff --git a/dts/tests/TestSuite_flow_offload.py b/dts/tests/TestSuite_flow_offload.py
index 09384b1983..624ff93b17 100644
--- a/dts/tests/TestSuite_flow_offload.py
+++ b/dts/tests/TestSuite_flow_offload.py
@@ -28,7 +28,7 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import fail, log, verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.types import FlowRule
 
@@ -402,6 +402,7 @@ def generate(
 
 
 @requires_nic_capability(NicCapability.FLOW_CTRL)
+@func_suite
 class TestFlowOffload(TestSuite):
     """Flow offload test suite.
 
diff --git a/dts/tests/TestSuite_hello_world.py b/dts/tests/TestSuite_hello_world.py
index cd62eb8f3e..9bc555aa08 100644
--- a/dts/tests/TestSuite_hello_world.py
+++ b/dts/tests/TestSuite_hello_world.py
@@ -9,7 +9,7 @@
 """
 
 from api.test import log
-from api.test_suite import BaseConfig, TestSuite, func_test
+from api.test_suite import BaseConfig, TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 
 
@@ -20,6 +20,7 @@ class Config(BaseConfig):
     msg: str = "Hello World!"
 
 
+@func_suite
 class TestHelloWorld(TestSuite):
     """Hello World test suite. One test case, which starts and stops a testpmd session."""
 
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index f237821a04..b987efbebf 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -19,7 +19,7 @@
     match_all_packets,
     send_packets_and_capture,
 )
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testbed_model.cpu import LogicalCoreCount
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer, SimpleForwardingModes
@@ -28,6 +28,7 @@
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_link_topology(LinkTopology.TWO_LINKS)
+@func_suite
 class TestL2fwd(TestSuite):
     """L2 forwarding test suite."""
 
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_filter.py
index eb1413f336..f244203593 100644
--- a/dts/tests/TestSuite_mac_filter.py
+++ b/dts/tests/TestSuite_mac_filter.py
@@ -26,11 +26,12 @@
 from api.exception import InteractiveCommandExecutionError
 from api.packet import send_packet_and_capture
 from api.test import fail, verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@func_suite
 class TestMacFilter(TestSuite):
     """Mac address allowlist filtering test suite.
 
diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
index c264db299e..f834be1818 100644
--- a/dts/tests/TestSuite_mtu.py
+++ b/dts/tests/TestSuite_mtu.py
@@ -23,7 +23,7 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 
 STANDARD_FRAME = 1518  # --max-pkt-len will subtract l2 information at a minimum of 18 bytes.
@@ -37,6 +37,7 @@
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@func_suite
 class TestMtu(TestSuite):
     """DPDK PMD jumbo frames and MTU update test suite.
 
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index 07bfabb30b..f319d99ede 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -37,7 +37,7 @@
 )
 from api.params import Params
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testbed_model.cpu import LogicalCoreList
 from api.testbed_model.traffic_generator.capturing_traffic_generator import PacketFilteringConfig
 from api.testpmd import TestPmd
@@ -65,6 +65,7 @@ class DumpcapParams(Params):
 
 
 @requires_link_topology(LinkTopology.TWO_LINKS)
+@func_suite
 class TestPacketCapture(TestSuite):
     """Packet Capture TestSuite.
 
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port_control.py
index c2f2de3493..2aa613bc25 100644
--- a/dts/tests/TestSuite_port_control.py
+++ b/dts/tests/TestSuite_port_control.py
@@ -18,12 +18,13 @@
 )
 from api.packet import send_packets_and_capture
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@func_suite
 class TestPortControl(TestSuite):
     """DPDK Port Control Testing Suite."""
 
diff --git a/dts/tests/TestSuite_port_restart_config_persistency.py b/dts/tests/TestSuite_port_restart_config_persistency.py
index 88df35d33c..626baa2097 100644
--- a/dts/tests/TestSuite_port_restart_config_persistency.py
+++ b/dts/tests/TestSuite_port_restart_config_persistency.py
@@ -14,7 +14,7 @@
     requires_nic_capability,
 )
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.types import TestPmdPortFlowCtrl
 
@@ -23,6 +23,7 @@
 ALTERNATIVE_MAC_ADDRESS: str = "42:A6:B7:9E:B4:81"
 
 
+@func_suite
 class TestPortRestartConfigPersistency(TestSuite):
     """Port config persistency test suite."""
 
diff --git a/dts/tests/TestSuite_port_stats.py b/dts/tests/TestSuite_port_stats.py
index 0328c6718c..e2980d8d61 100644
--- a/dts/tests/TestSuite_port_stats.py
+++ b/dts/tests/TestSuite_port_stats.py
@@ -25,7 +25,7 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
@@ -33,6 +33,7 @@
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_link_topology(LinkTopology.TWO_LINKS)
+@func_suite
 class TestPortStats(TestSuite):
     """DPDK Port statistics testing suite.
 
diff --git a/dts/tests/TestSuite_promisc_support.py b/dts/tests/TestSuite_promisc_support.py
index c59c8c6078..adbdf77631 100644
--- a/dts/tests/TestSuite_promisc_support.py
+++ b/dts/tests/TestSuite_promisc_support.py
@@ -21,11 +21,12 @@
     send_packets_and_capture,
 )
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
+@func_suite
 class TestPromiscSupport(TestSuite):
     """Promiscuous mode support test suite."""
 
diff --git a/dts/tests/TestSuite_qinq.py b/dts/tests/TestSuite_qinq.py
index 5dde37d4db..67884a113c 100644
--- a/dts/tests/TestSuite_qinq.py
+++ b/dts/tests/TestSuite_qinq.py
@@ -18,10 +18,11 @@
 from api.capabilities import NicCapability, requires_nic_capability
 from api.packet import send_packet_and_capture
 from api.test import log, verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 
 
+@func_suite
 class TestQinq(TestSuite):
     """QinQ test suite.
 
diff --git a/dts/tests/TestSuite_queue_toggle.py b/dts/tests/TestSuite_queue_toggle.py
index a9ea356b22..0ad362d233 100644
--- a/dts/tests/TestSuite_queue_toggle.py
+++ b/dts/tests/TestSuite_queue_toggle.py
@@ -24,7 +24,7 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 
@@ -32,6 +32,7 @@
 @requires_link_topology(LinkTopology.TWO_LINKS)
 @requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)
 @requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)
+@func_suite
 class TestQueueToggle(TestSuite):
     """DPDK Queue start/stop test suite.
 
diff --git a/dts/tests/TestSuite_rss.py b/dts/tests/TestSuite_rss.py
index b538e93af9..289c69d225 100644
--- a/dts/tests/TestSuite_rss.py
+++ b/dts/tests/TestSuite_rss.py
@@ -23,7 +23,7 @@
 from api.exception import InteractiveCommandExecutionError
 from api.packet import send_packets_and_capture
 from api.test import verify
-from api.test_suite import BaseConfig, TestSuite, func_test
+from api.test_suite import BaseConfig, TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import (
@@ -55,6 +55,7 @@ class HashAlgorithm(StrEnum):
 
 @requires_link_topology(LinkTopology.ONE_LINK)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_RSS_HASH)
+@func_suite
 class TestRss(TestSuite):
     """RSS test suite."""
 
diff --git a/dts/tests/TestSuite_rx_split.py b/dts/tests/TestSuite_rx_split.py
index 3b3e4cd620..eac377e93e 100644
--- a/dts/tests/TestSuite_rx_split.py
+++ b/dts/tests/TestSuite_rx_split.py
@@ -21,7 +21,7 @@
 from api.exception import InteractiveCommandExecutionError
 from api.packet import adjust_addresses, send_packet_and_capture
 from api.test import fail, verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import RxOffloadCapability, TxOffloadCapability
@@ -35,6 +35,7 @@
 
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_BUFFER_SPLIT)
 @requires_nic_capability(NicCapability.SELECTIVE_RX)
+@func_suite
 class TestRxSplit(TestSuite):
     """Rx split test suite.
 
diff --git a/dts/tests/TestSuite_rx_tx_offload.py b/dts/tests/TestSuite_rx_tx_offload.py
index c8d24baaae..cbf9a249b4 100644
--- a/dts/tests/TestSuite_rx_tx_offload.py
+++ b/dts/tests/TestSuite_rx_tx_offload.py
@@ -13,7 +13,7 @@
     requires_nic_capability,
 )
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.types import (
     OffloadConfiguration,
@@ -22,6 +22,7 @@
 
 
 @requires_link_topology(LinkTopology.ONE_LINK)
+@func_suite
 class TestRxTxOffload(TestSuite):
     """RX/TX offload test suite."""
 
diff --git a/dts/tests/TestSuite_single_core_forward_perf.py b/dts/tests/TestSuite_single_core_forward_perf.py
index 4b22c5d091..c96411cf18 100644
--- a/dts/tests/TestSuite_single_core_forward_perf.py
+++ b/dts/tests/TestSuite_single_core_forward_perf.py
@@ -23,7 +23,7 @@
 from api.packet import assess_performance_by_packet
 from api.params.types import TestPmdParamsDict
 from api.test import verify, write_performance_json
-from api.test_suite import BaseConfig, TestSuite, perf_test
+from api.test_suite import BaseConfig, TestSuite, perf_suite, perf_test
 from api.testpmd import TestPmd
 from api.testpmd.config import RXRingParams, TXRingParams
 
@@ -42,6 +42,7 @@ class Config(BaseConfig):
     delta_tolerance: float = 0.05
 
 
+@perf_suite
 @requires_link_topology(LinkTopology.TWO_LINKS)
 class TestSingleCoreForwardPerf(TestSuite):
     """Single core forwarding performance test suite."""
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index b3eb325fc0..993620641c 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -19,7 +19,7 @@
     requires_link_topology,
 )
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testbed_model.linux_session import LinuxSession
 from api.testpmd import TestPmd
 from api.utils import REGEX_FOR_PCI_ADDRESS
@@ -28,6 +28,7 @@
 
 
 @requires_link_topology(LinkTopology.NO_LINK)
+@func_suite
 class TestSmokeTests(TestSuite):
     """DPDK and infrastructure smoke test suite.
 
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index 05a6d3aa18..f601130d56 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -18,7 +18,7 @@
     match_all_packets,
     send_packets_and_capture,
 )
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testbed_model.virtual_device import VirtualDevice
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer
@@ -27,6 +27,7 @@
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_link_topology(LinkTopology.TWO_LINKS)
+@func_suite
 class TestSoftnic(TestSuite):
     """Softnic test suite."""
 
diff --git a/dts/tests/TestSuite_speed_capabilities.py b/dts/tests/TestSuite_speed_capabilities.py
index c9b0f74feb..56c0d0a51a 100644
--- a/dts/tests/TestSuite_speed_capabilities.py
+++ b/dts/tests/TestSuite_speed_capabilities.py
@@ -13,7 +13,7 @@
     requires_link_topology,
 )
 from api.test import verify
-from api.test_suite import BaseConfig, TestSuite, func_test
+from api.test_suite import BaseConfig, TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 
 
@@ -39,6 +39,7 @@ class Config(BaseConfig):
 
 
 @requires_link_topology(LinkTopology.ONE_LINK)
+@func_suite
 class TestSpeedCapabilities(TestSuite):
     """Speed capabilities test suite."""
 
diff --git a/dts/tests/TestSuite_unified_packet.py b/dts/tests/TestSuite_unified_packet.py
index bf3654f0d7..006f124d19 100644
--- a/dts/tests/TestSuite_unified_packet.py
+++ b/dts/tests/TestSuite_unified_packet.py
@@ -25,12 +25,13 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
 
 
+@func_suite
 class TestUnifiedPacket(TestSuite):
     """DPDK Unified packet test suite.
 
diff --git a/dts/tests/TestSuite_virtio_forward.py b/dts/tests/TestSuite_virtio_forward.py
index a52c1a4402..52889a844b 100644
--- a/dts/tests/TestSuite_virtio_forward.py
+++ b/dts/tests/TestSuite_virtio_forward.py
@@ -12,13 +12,14 @@
 from api.capabilities import LinkTopology, requires_link_topology
 from api.packet import send_packets_and_capture
 from api.test import log, verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testbed_model.linux_session import LinuxSession
 from api.testbed_model.virtual_device import VirtualDevice
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
 
 
+@func_suite
 class TestVirtioForward(TestSuite):
     """Virtio forwarding test suite."""
 
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index 975e87b128..edd93e3487 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -23,12 +23,13 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
-from api.test_suite import TestSuite, func_test
+from api.test_suite import TestSuite, func_suite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 
 
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)
+@func_suite
 class TestVlan(TestSuite):
     """DPDK VLAN test suite.
 
-- 
2.56.0

