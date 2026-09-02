Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6661C61DD6
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 18:14:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 520C942791;
	Wed,  2 Sep 2026 20:14:02 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id C0F75410F2
 for <dev@dpdk.org>; Wed,  2 Sep 2026 20:14:00 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-53016020b2fso20242531cf.0
 for <dev@dpdk.org>; Wed, 02 Sep 2026 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1788372840; x=1788977640; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vOy101n3cQNnuYJWEFjcqIYCJ1a7xhO3uA6CKeqg+pA=;
 b=gT/EdqITuI1Fwl+UBybj7i443yW7YRnb6pAiNoc0xrfWxKlNfO+M9J3+TNr9zoSMEZ
 uBWIwdnZC7JyuoAj5HFfkDhNbQMMlPSE50StNd+dbUG8Vh/ObaLK4AXSmkf+8CGUJqxK
 uaq6X1HmSrS2IL+Lzz4Qc1PRiomjhkrdL1+DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788372840; x=1788977640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vOy101n3cQNnuYJWEFjcqIYCJ1a7xhO3uA6CKeqg+pA=;
 b=DHMoEoLvlS+yGcqZ6wMcVJdGiTaEEVUJ2B05vvLkA19mSbxhxL+ER3xSCFheDbU3Gx
 D4UPEgFGWxrGUt4b3n0cxvHJXk9hMOjh6M5hQ52vKsdtl0C57XgJVlgV3T8f3ToQduRt
 Pr4Pr0k1rZvhM88HgOKrx5H7LxOF5UdPHeLRCnAJjU6dRM4lymyUcGBCKN3CZORdogMn
 LHGkpbDSJoGIq1fab+6+Dq6lPdENjZu+RqqvTBjF2Ke5K2LH52WxHxXc43r2xyoKPzCW
 whJfqUYEuEAXC8A5uI2C+Sby+XMu0SYciVSmdBynZpMzDMAyDRg7nPhQTmlBwmnLuarp
 taow==
X-Gm-Message-State: AFuF++mXU/CrF05LzS3jPeu9i27OPlH2a8CccNaK17B0Q8V6BvcADy3z
 leqeKZ7eIEvS9al8Y4uHPDBQSfpw5/HTRF+hmdLciQkEDITXvLW+2D4IbjYzAyBpULeUZztffEz
 gxMfvNtmT1kZIjcrSVGieNkxoak5Z5mUeC2QsJAPRA8rXxhEPFb1a8aTKbJH04VGOrmuaYQ4D5w
 d2bmRKc/KVIwchU+xxauD/1SA4Y2U=
X-Gm-Gg: AYBFou0KhX7Iyu5uVcBqBrZHkwn8C7tjeAHfO/xh4ABjzSkzrjcugIQ6n8mXIPmTztF
 BeQviSmRCFTPCkDEK4bixqE2vogl5JxSZFxMSLakj2YqdH9/24ZKvFv2l7fWIiYd2TM25+TIzvz
 QwPPiaJQABIu/waau4rOpl+lCJlNh+h0A5LUbOAUbuTpZtZbHgQ5ziu9u5veaMcGUtB1STLXvQt
 EvO50mjNHORJ0y4ELjo7P2Mi44V3vrp5nAaDblqUn9Ri1JSp1VJhyOMBpngn8JqbenswlBtCrDT
 QsPUi7UziVD6ALj71cGoXekvHanL1MqzGKn74dXD1iFE2bbQrKNpI1W3a9ZZol+JNg3IgS0pu2D
 U30LSkcABAtFOt1FeGddTiApWO1jPdUj+7QqlqgSpU6sTyhx1vjlwVyxRPkQgHJA/x8dAp8Iwwb
 rTCZWR6yisCH0frFv51RnN+XZrMDDeNoG/WSzwM/YoVJwkt4ShIePsoWegbW3mGOFPJcSK9mXw2
 0aLpnO012Q=
X-Received: by 2002:ac8:5a04:0:b0:52d:844c:b176 with SMTP id
 d75a77b69052e-53036bf3a61mr78394101cf.11.1788372839830; 
 Wed, 02 Sep 2026 11:13:59 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530331d9cbcsm24660101cf.16.2026.09.02.11.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:13:59 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 7/8] dts: move test suite module from framework to API
Date: Wed,  2 Sep 2026 14:13:31 -0400
Message-ID: <20260902181333.461556-8-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902181333.461556-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260902181333.461556-1-abailey@iol.unh.edu>
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

Currently, each test suite imports the TestSuite class
from the DTS framework to use as a base class.
However, the goal for 26.07 is to move all test suite
imports to the API module. Moves and updates the test_suite
file to the API directory, and updates all files that import
test_suite to reflect this change.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 .../dts/{framework.test_suite.rst => api.test_suite.rst}  | 2 +-
 doc/api/dts/index.rst                                     | 2 +-
 dts/api/capabilities.py                                   | 2 +-
 dts/api/packet.py                                         | 2 +-
 dts/{framework => api}/test_suite.py                      | 3 +--
 dts/api/testbed_model/capability.py                       | 2 +-
 dts/framework/config/__init__.py                          | 4 ++--
 dts/framework/config/test_run.py                          | 8 ++++----
 dts/framework/context.py                                  | 2 +-
 dts/framework/test_run.py                                 | 2 +-
 dts/tests/TestSuite_blocklist.py                          | 2 +-
 dts/tests/TestSuite_buffer_scatter.py                     | 2 +-
 dts/tests/TestSuite_checksum_offload.py                   | 2 +-
 dts/tests/TestSuite_cryptodev_latency.py                  | 2 +-
 dts/tests/TestSuite_cryptodev_throughput.py               | 2 +-
 dts/tests/TestSuite_dual_vlan.py                          | 2 +-
 dts/tests/TestSuite_dynamic_config.py                     | 2 +-
 dts/tests/TestSuite_dynamic_queue_conf.py                 | 2 +-
 dts/tests/TestSuite_flow_offload.py                       | 2 +-
 dts/tests/TestSuite_hello_world.py                        | 2 +-
 dts/tests/TestSuite_l2fwd.py                              | 2 +-
 dts/tests/TestSuite_mac_filter.py                         | 2 +-
 dts/tests/TestSuite_mtu.py                                | 2 +-
 dts/tests/TestSuite_packet_capture.py                     | 2 +-
 dts/tests/TestSuite_port_control.py                       | 2 +-
 dts/tests/TestSuite_port_restart_config_persistency.py    | 2 +-
 dts/tests/TestSuite_port_stats.py                         | 2 +-
 dts/tests/TestSuite_promisc_support.py                    | 2 +-
 dts/tests/TestSuite_qinq.py                               | 2 +-
 dts/tests/TestSuite_queue_toggle.py                       | 2 +-
 dts/tests/TestSuite_rss.py                                | 2 +-
 dts/tests/TestSuite_rx_split.py                           | 2 +-
 dts/tests/TestSuite_rx_tx_offload.py                      | 2 +-
 dts/tests/TestSuite_single_core_forward_perf.py           | 2 +-
 dts/tests/TestSuite_smoke_tests.py                        | 2 +-
 dts/tests/TestSuite_softnic.py                            | 2 +-
 dts/tests/TestSuite_speed_capabilities.py                 | 2 +-
 dts/tests/TestSuite_unified_packet.py                     | 2 +-
 dts/tests/TestSuite_virtio_forward.py                     | 2 +-
 dts/tests/TestSuite_vlan.py                               | 2 +-
 40 files changed, 44 insertions(+), 45 deletions(-)
 rename doc/api/dts/{framework.test_suite.rst => api.test_suite.rst} (81%)
 rename dts/{framework => api}/test_suite.py (99%)

diff --git a/doc/api/dts/framework.test_suite.rst b/doc/api/dts/api.test_suite.rst
similarity index 81%
rename from doc/api/dts/framework.test_suite.rst
rename to doc/api/dts/api.test_suite.rst
index 9517f51a4a..4acb7b103a 100644
--- a/doc/api/dts/framework.test_suite.rst
+++ b/doc/api/dts/api.test_suite.rst
@@ -3,6 +3,6 @@
 test\_suite - Common Test Suite Features
 ========================================
 
-.. automodule:: framework.test_suite
+.. automodule:: api.test_suite
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
index d02bc59d2b..408946683d 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -30,7 +30,7 @@ Modules
 
    framework.runner
    framework.test_run
-   framework.test_suite
+   api.test_suite
    framework.test_result
    framework.settings
    api.context
diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
index 8ed832a588..9e09a16246 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -47,7 +47,7 @@ def test_scatter_mbuf_2048(self):
 from typing import TYPE_CHECKING, Callable
 
 if TYPE_CHECKING:
-    from framework.test_suite import TestProtocol
+    from api.test_suite import TestProtocol
 
 
 class LinkTopology(IntEnum):
diff --git a/dts/api/packet.py b/dts/api/packet.py
index c6d014765f..0bf171ed09 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -173,7 +173,7 @@ def adjust_addresses(packets: list[Packet], expected: bool = False) -> list[Pack
     Raises:
         InternalError: If no tests are running.
     """
-    from framework.test_suite import TestSuite
+    from api.test_suite import TestSuite
 
     if get_ctx().local.current_test_suite is None:
         raise InternalError("No current test suite, tests aren't running?")
diff --git a/dts/framework/test_suite.py b/dts/api/test_suite.py
similarity index 99%
rename from dts/framework/test_suite.py
rename to dts/api/test_suite.py
index ac30d57ac9..c30d447135 100644
--- a/dts/framework/test_suite.py
+++ b/dts/api/test_suite.py
@@ -33,10 +33,9 @@
 from api.testbed_model.capability import TestProtocol
 from api.utils import to_pascal_case
 from framework.config.common import FrozenModel
+from framework.logger import DTSLogger, get_dts_logger
 from framework.testbed_model.topology import Topology
 
-from .logger import DTSLogger, get_dts_logger
-
 if TYPE_CHECKING:
     from api.context import Context
 
diff --git a/dts/api/testbed_model/capability.py b/dts/api/testbed_model/capability.py
index 06ffda673f..3d3ca1bab7 100644
--- a/dts/api/testbed_model/capability.py
+++ b/dts/api/testbed_model/capability.py
@@ -71,8 +71,8 @@ def test_scatter_mbuf_2048(self):
 from framework.testbed_model.topology import Topology
 
 if TYPE_CHECKING:
+    from api.test_suite import TestCase
     from api.testpmd import TestPmd
-    from framework.test_suite import TestCase
 
 P = ParamSpec("P")
 TestPmdMethod = Callable[Concatenate["TestPmd", P], Any]
diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__init__.py
index e24a351ecf..c8edf340bd 100644
--- a/dts/framework/config/__init__.py
+++ b/dts/framework/config/__init__.py
@@ -43,7 +43,7 @@
 
 # Import only if type checking or building docs, to prevent circular imports.
 if TYPE_CHECKING:
-    from framework.test_suite import BaseConfig
+    from api.test_suite import BaseConfig
 
 NodesConfig = Annotated[list[NodeConfiguration], Field(min_length=1)]
 
@@ -184,7 +184,7 @@ def load_config(ctx: ValidationContext) -> Configuration:
     nodes = _load_and_parse_model(ctx["settings"].nodes_config_path, NodesConfig, ctx)
 
     try:
-        from framework.test_suite import BaseConfig as BaseConfig
+        from api.test_suite import BaseConfig as BaseConfig
 
         Configuration.model_rebuild()
         return Configuration.model_validate(
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index ec3d65ecf9..97c9a7417a 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -33,7 +33,7 @@
 from .common import FrozenModel, load_fields_from_settings
 
 if TYPE_CHECKING:
-    from framework.test_suite import BaseConfig, TestCase, TestSuite, TestSuiteSpec
+    from api.test_suite import BaseConfig, TestCase, TestSuite, TestSuiteSpec
 
 
 @unique
@@ -232,7 +232,7 @@ class TestSuiteConfig(FrozenModel):
     @cached_property
     def test_suite_spec(self) -> "TestSuiteSpec":
         """The specification of the requested test suite."""
-        from framework.test_suite import find_by_name
+        from api.test_suite import find_by_name
 
         test_suite_spec = find_by_name(self.test_suite_name)
         assert test_suite_spec is not None, (
@@ -282,7 +282,7 @@ def fetch_all_test_suites() -> list[TestSuiteConfig]:
 
     This function does not include the smoke tests.
     """
-    from framework.test_suite import AVAILABLE_TEST_SUITES
+    from api.test_suite import AVAILABLE_TEST_SUITES
 
     return [
         TestSuiteConfig(test_suite=test_suite.name)
@@ -508,7 +508,7 @@ def filter_tests(
         self, tests_config: dict[str, "BaseConfig"]
     ) -> Iterable[tuple[type["TestSuite"], "BaseConfig", deque[type["TestCase"]]]]:
         """Filter test suites and cases selected for execution."""
-        from framework.test_suite import TestCaseType
+        from api.test_suite import TestCaseType
 
         test_suites = [TestSuiteConfig(test_suite="smoke_tests")]
 
diff --git a/dts/framework/context.py b/dts/framework/context.py
index 7ec8ac4857..ee210c3607 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -16,10 +16,10 @@
 from framework.testbed_model.topology import Topology
 
 if TYPE_CHECKING:
+    from api.test_suite import TestCase, TestSuite
     from api.testbed_model.capability import TestProtocol
     from api.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
     from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
-    from framework.test_suite import TestCase, TestSuite
 
 P = ParamSpec("P")
 
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 63f1145fe3..210ff25af7 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -110,6 +110,7 @@
 from api.capabilities import LinkTopology
 from api.context import Context, init_ctx
 from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
+from api.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
 from api.testbed_model.capability import (
     Capability,
     get_supported_capabilities,
@@ -120,7 +121,6 @@
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
 from framework.test_result import Result, ResultNode, TestRunResult
-from framework.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
 from framework.testbed_model.node import Node
 from framework.testbed_model.topology import PortLink, Topology
 from framework.testbed_model.traffic_generator import create_traffic_generator
diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index 97e03b8fb7..31e69c0de9 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -11,9 +11,9 @@
     requires_link_topology,
 )
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testbed_model.port import Port
 from api.testpmd import TestPmd
-from framework.test_suite import TestSuite, func_test
 
 
 class TestBlocklist(TestSuite):
diff --git a/dts/tests/TestSuite_buffer_scatter.py b/dts/tests/TestSuite_buffer_scatter.py
index 539082f2e4..cd1a52ad5e 100644
--- a/dts/tests/TestSuite_buffer_scatter.py
+++ b/dts/tests/TestSuite_buffer_scatter.py
@@ -28,9 +28,9 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index 90ca798e56..a2ea13991b 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -25,10 +25,10 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import ChecksumOffloadOptions, PacketOffloadFlag
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM)
diff --git a/dts/tests/TestSuite_cryptodev_latency.py b/dts/tests/TestSuite_cryptodev_latency.py
index 981c483a14..444a5b282c 100644
--- a/dts/tests/TestSuite_cryptodev_latency.py
+++ b/dts/tests/TestSuite_cryptodev_latency.py
@@ -31,8 +31,8 @@
     CryptodevResults,
 )
 from api.test import skip, verify
+from api.test_suite import BaseConfig, TestSuite, crypto_test
 from api.testbed_model.virtual_device import VirtualDevice
-from framework.test_suite import BaseConfig, TestSuite, crypto_test
 
 config_list: list[dict[str, int | float | str]] = [
     {"buff_size": 64, "avg_cycles": 99_999.00, "avg_time_us": 9999.0},
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index b861c52bae..59f64f2cd7 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -31,8 +31,8 @@
     CryptodevResults,
 )
 from api.test import skip, verify
+from api.test_suite import BaseConfig, TestSuite, crypto_test
 from api.testbed_model.virtual_device import VirtualDevice
-from framework.test_suite import BaseConfig, TestSuite, crypto_test
 
 config_list: list[dict[str, int | float | str]] = [
     {"buff_size": 64, "Gbps": 1.00},
diff --git a/dts/tests/TestSuite_dual_vlan.py b/dts/tests/TestSuite_dual_vlan.py
index 1b77dd2b47..f3347a6d52 100644
--- a/dts/tests/TestSuite_dual_vlan.py
+++ b/dts/tests/TestSuite_dual_vlan.py
@@ -21,9 +21,9 @@
 from api.capabilities import LinkTopology, requires_link_topology
 from api.packet import send_packet_and_capture
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
 
 
 class TestDualVlan(TestSuite):
diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dynamic_config.py
index 7204ec4f73..b9e2c30da1 100644
--- a/dts/tests/TestSuite_dynamic_config.py
+++ b/dts/tests/TestSuite_dynamic_config.py
@@ -27,9 +27,9 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index b62efa2b42..24584c7d60 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -38,9 +38,9 @@
 from api.exception import InteractiveCommandExecutionError
 from api.packet import send_packets
 from api.test import fail, verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
 
 
 def setup_and_teardown_test(
diff --git a/dts/tests/TestSuite_flow_offload.py b/dts/tests/TestSuite_flow_offload.py
index 5902406a8e..09384b1983 100644
--- a/dts/tests/TestSuite_flow_offload.py
+++ b/dts/tests/TestSuite_flow_offload.py
@@ -28,9 +28,9 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import fail, log, verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.types import FlowRule
-from framework.test_suite import TestSuite, func_test
 
 
 @dataclass
diff --git a/dts/tests/TestSuite_hello_world.py b/dts/tests/TestSuite_hello_world.py
index bf1a93c782..cd62eb8f3e 100644
--- a/dts/tests/TestSuite_hello_world.py
+++ b/dts/tests/TestSuite_hello_world.py
@@ -9,8 +9,8 @@
 """
 
 from api.test import log
+from api.test_suite import BaseConfig, TestSuite, func_test
 from api.testpmd import TestPmd
-from framework.test_suite import BaseConfig, TestSuite, func_test
 
 
 class Config(BaseConfig):
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index 5650366c36..f237821a04 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -19,11 +19,11 @@
     match_all_packets,
     send_packets_and_capture,
 )
+from api.test_suite import TestSuite, func_test
 from api.testbed_model.cpu import LogicalCoreCount
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer, SimpleForwardingModes
 from api.utils import generate_random_packets
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_filter.py
index b44822d31c..eb1413f336 100644
--- a/dts/tests/TestSuite_mac_filter.py
+++ b/dts/tests/TestSuite_mac_filter.py
@@ -26,8 +26,8 @@
 from api.exception import InteractiveCommandExecutionError
 from api.packet import send_packet_and_capture
 from api.test import fail, verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
index 8355495d33..c264db299e 100644
--- a/dts/tests/TestSuite_mtu.py
+++ b/dts/tests/TestSuite_mtu.py
@@ -23,8 +23,8 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
-from framework.test_suite import TestSuite, func_test
 
 STANDARD_FRAME = 1518  # --max-pkt-len will subtract l2 information at a minimum of 18 bytes.
 JUMBO_FRAME = 9018
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index 041c0333ab..b994c7cc74 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -36,13 +36,13 @@
     send_packets_and_capture,
 )
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testbed_model.cpu import LogicalCoreList
 from api.testbed_model.traffic_generator.capturing_traffic_generator import PacketFilteringConfig
 from api.testpmd import TestPmd
 from framework.params import Params
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.dpdk_shell import compute_eal_params
-from framework.test_suite import TestSuite, func_test
 
 
 @dataclass(kw_only=True)
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port_control.py
index b51fdc2959..c2f2de3493 100644
--- a/dts/tests/TestSuite_port_control.py
+++ b/dts/tests/TestSuite_port_control.py
@@ -18,9 +18,9 @@
 )
 from api.packet import send_packets_and_capture
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_port_restart_config_persistency.py b/dts/tests/TestSuite_port_restart_config_persistency.py
index 4ea22b6d70..88df35d33c 100644
--- a/dts/tests/TestSuite_port_restart_config_persistency.py
+++ b/dts/tests/TestSuite_port_restart_config_persistency.py
@@ -14,9 +14,9 @@
     requires_nic_capability,
 )
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.types import TestPmdPortFlowCtrl
-from framework.test_suite import TestSuite, func_test
 
 ALTERNATIVE_MTU: int = 800
 STANDARD_MTU: int = 1500
diff --git a/dts/tests/TestSuite_port_stats.py b/dts/tests/TestSuite_port_stats.py
index 3dc045f847..0328c6718c 100644
--- a/dts/tests/TestSuite_port_stats.py
+++ b/dts/tests/TestSuite_port_stats.py
@@ -25,10 +25,10 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_promisc_support.py b/dts/tests/TestSuite_promisc_support.py
index a0c65dc662..c59c8c6078 100644
--- a/dts/tests/TestSuite_promisc_support.py
+++ b/dts/tests/TestSuite_promisc_support.py
@@ -21,8 +21,8 @@
     send_packets_and_capture,
 )
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_qinq.py b/dts/tests/TestSuite_qinq.py
index 505d71dbc8..5dde37d4db 100644
--- a/dts/tests/TestSuite_qinq.py
+++ b/dts/tests/TestSuite_qinq.py
@@ -18,8 +18,8 @@
 from api.capabilities import NicCapability, requires_nic_capability
 from api.packet import send_packet_and_capture
 from api.test import log, verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
-from framework.test_suite import TestSuite, func_test
 
 
 class TestQinq(TestSuite):
diff --git a/dts/tests/TestSuite_queue_toggle.py b/dts/tests/TestSuite_queue_toggle.py
index e4edc89123..a9ea356b22 100644
--- a/dts/tests/TestSuite_queue_toggle.py
+++ b/dts/tests/TestSuite_queue_toggle.py
@@ -24,9 +24,9 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_link_topology(LinkTopology.TWO_LINKS)
diff --git a/dts/tests/TestSuite_rss.py b/dts/tests/TestSuite_rss.py
index 1e60bdba07..b538e93af9 100644
--- a/dts/tests/TestSuite_rss.py
+++ b/dts/tests/TestSuite_rss.py
@@ -23,6 +23,7 @@
 from api.exception import InteractiveCommandExecutionError
 from api.packet import send_packets_and_capture
 from api.test import verify
+from api.test_suite import BaseConfig, TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import (
@@ -31,7 +32,6 @@
     TestPmdVerbosePacket,
 )
 from api.utils import StrEnum
-from framework.test_suite import BaseConfig, TestSuite, func_test
 
 
 class Config(BaseConfig):
diff --git a/dts/tests/TestSuite_rx_split.py b/dts/tests/TestSuite_rx_split.py
index 470e48d0d3..3b3e4cd620 100644
--- a/dts/tests/TestSuite_rx_split.py
+++ b/dts/tests/TestSuite_rx_split.py
@@ -21,10 +21,10 @@
 from api.exception import InteractiveCommandExecutionError
 from api.packet import adjust_addresses, send_packet_and_capture
 from api.test import fail, verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import RxOffloadCapability, TxOffloadCapability
-from framework.test_suite import TestSuite, func_test
 
 PAYLOAD = bytes(range(256))
 ETHER_HDR_LEN = len(Ether(dst="00:00:00:00:00:00"))
diff --git a/dts/tests/TestSuite_rx_tx_offload.py b/dts/tests/TestSuite_rx_tx_offload.py
index b0da627d3c..c8d24baaae 100644
--- a/dts/tests/TestSuite_rx_tx_offload.py
+++ b/dts/tests/TestSuite_rx_tx_offload.py
@@ -13,12 +13,12 @@
     requires_nic_capability,
 )
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.types import (
     OffloadConfiguration,
     RxTxLiteralSwitch,
 )
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_link_topology(LinkTopology.ONE_LINK)
diff --git a/dts/tests/TestSuite_single_core_forward_perf.py b/dts/tests/TestSuite_single_core_forward_perf.py
index 57aecdf7a4..f51ff76c4c 100644
--- a/dts/tests/TestSuite_single_core_forward_perf.py
+++ b/dts/tests/TestSuite_single_core_forward_perf.py
@@ -22,10 +22,10 @@
 )
 from api.packet import assess_performance_by_packet
 from api.test import verify, write_performance_json
+from api.test_suite import BaseConfig, TestSuite, perf_test
 from api.testpmd import TestPmd
 from api.testpmd.config import RXRingParams, TXRingParams
 from framework.params.types import TestPmdParamsDict
-from framework.test_suite import BaseConfig, TestSuite, perf_test
 
 
 class Config(BaseConfig):
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index 656e2e4bb7..b3eb325fc0 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -19,12 +19,12 @@
     requires_link_topology,
 )
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testbed_model.linux_session import LinuxSession
 from api.testpmd import TestPmd
 from api.utils import REGEX_FOR_PCI_ADDRESS
 from framework.config.node import PortConfig
 from framework.settings import SETTINGS
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_link_topology(LinkTopology.NO_LINK)
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index 91a6d4eb9f..05a6d3aa18 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -18,11 +18,11 @@
     match_all_packets,
     send_packets_and_capture,
 )
+from api.test_suite import TestSuite, func_test
 from api.testbed_model.virtual_device import VirtualDevice
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer
 from api.utils import generate_random_packets
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_speed_capabilities.py b/dts/tests/TestSuite_speed_capabilities.py
index 9cbd6f1ef7..c9b0f74feb 100644
--- a/dts/tests/TestSuite_speed_capabilities.py
+++ b/dts/tests/TestSuite_speed_capabilities.py
@@ -13,8 +13,8 @@
     requires_link_topology,
 )
 from api.test import verify
+from api.test_suite import BaseConfig, TestSuite, func_test
 from api.testpmd import TestPmd
-from framework.test_suite import BaseConfig, TestSuite, func_test
 
 
 class Config(BaseConfig):
diff --git a/dts/tests/TestSuite_unified_packet.py b/dts/tests/TestSuite_unified_packet.py
index fcc7f7fbbb..bf3654f0d7 100644
--- a/dts/tests/TestSuite_unified_packet.py
+++ b/dts/tests/TestSuite_unified_packet.py
@@ -25,10 +25,10 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
-from framework.test_suite import TestSuite, func_test
 
 
 class TestUnifiedPacket(TestSuite):
diff --git a/dts/tests/TestSuite_virtio_forward.py b/dts/tests/TestSuite_virtio_forward.py
index ef6c2d407c..12cba17b7c 100644
--- a/dts/tests/TestSuite_virtio_forward.py
+++ b/dts/tests/TestSuite_virtio_forward.py
@@ -12,11 +12,11 @@
 from api.capabilities import LinkTopology, requires_link_topology
 from api.packet import send_packets_and_capture
 from api.test import log, verify
+from api.test_suite import TestSuite, func_test
 from api.testbed_model.linux_session import LinuxSession
 from api.testbed_model.virtual_device import VirtualDevice
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
 
 
 class TestVirtioForward(TestSuite):
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index 898673fc86..975e87b128 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -23,9 +23,9 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)
-- 
2.55.0

