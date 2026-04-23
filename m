Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2743DFDEE45
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 19:04:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F23C140648;
	Thu, 23 Apr 2026 21:04:29 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3DE5F40270
 for <dev@dpdk.org>; Thu, 23 Apr 2026 21:04:28 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-50fb18c55beso36121031cf.2
 for <dev@dpdk.org>; Thu, 23 Apr 2026 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1776971067; x=1777575867; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnmTTokaaEaPII9JRpSBNM6CiF0ndEOsvGNyHq3P3gA=;
 b=QHB15K0TdwU0Wc/30AnQ07fIqJ3EkLXf6nLH7q8ZF5swQuazAaV5v32YuE2q6EozF7
 VV++QuAvK/P9DSLOkaT4hNEKQuSwIiri1Aw1w7IlshWCLXCbZaxsqN4mj4wbBk5Rl2XM
 Q3Iv2pwMp72xrJgt+0D4cXPCpvKWZYL6uDHsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971067; x=1777575867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VnmTTokaaEaPII9JRpSBNM6CiF0ndEOsvGNyHq3P3gA=;
 b=oEtcBn9DYkDSS4XvEKBSJuZ6z1Hh6Iq7YeeGEIVNC/TGQTOLT4k8YSQfJVphaaJGp9
 gD6MiRh1C0gKFpjM06GYcCA/wSB2tL6GKa8R57UtC5KaFdqePkZVztmMwHZEE2FHE44g
 NUTAsLVmbjRvX31iYL67xsK7X4Ra4j3guPTPeqrCb1CVWfajtIRTUm3b7GNFpEH8WmD8
 08pp4/juuuAGK7kL98towsg+P8J/tqDxO81Nno9pnqnQ07zO4McZfVUAE+PbWHpvuWXo
 6O3as2K4NHX1QwKjDNpTKire/wtwOUSEMrEZgcaa120OtMd6Lm15R4j95xxEjVH1kiA0
 u8tw==
X-Gm-Message-State: AOJu0YxpupnnQsaGQlD2QF5wzczlfjMNMwjag+DUX5r0kjSHrK/ZpkF4
 EP/RXaAe6LAvnFvJaVrBE4rSiI1LxEuR7Ek57H9/3aupKVjArI7jJcuo/ws3q6g9Fyk=
X-Gm-Gg: AeBDieuPDxuWNahPjAtdyI/AbB75/PfdH61euvQIAsPYBwEfF305AZ+dvZxOlNouWO1
 0RgkclIev7Z1d69oeekdstfb9czhNEKZVuFz8xMBZ4IeM0AC5Mjb3J7kj1cet7lXvVFmGStPGbr
 IsuYtqjTdW5Pr4BxQ7ddKDRr/jEZwQEAvXuTuDdjK0Vn0XaURixNoSISawsZlw4NpEWhenpO9uO
 7TPFLUKb0748UyhYc+p06bFqYoZmLwl3fhO3YTOC4sPHthXVuWtz2YnBfiVmiriX769JNSBh4ZY
 k1DX0M6QF+oQWelXXU11S8BLwXCBeiJIsmcRy6L3JdPmwU6ZTev5rV+Hfh1t2+UhZM1sPO0tytw
 wnrDSNUyclvs6F/kM0lxBPq0v56TH1Ofod12ov2pAL+3tpp9tc4tU7BqJNRpKpEUXKmoOB+0fVA
 2riJ37squJuYzA7JXOaRzr224IPeQowSwzqkcgG+hOCK+8D77An6eG/+37OBH0kEUGNWT6up67
X-Received: by 2002:ac8:6f0c:0:b0:50f:c2f8:4075 with SMTP id
 d75a77b69052e-50fc2f8480emr123575581cf.1.1776971067420; 
 Thu, 23 Apr 2026 12:04:27 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50fc9715610sm34624441cf.10.2026.04.23.12.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:04:26 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 1/7] dts: move test suite module from framework to API
Date: Thu, 23 Apr 2026 15:04:16 -0400
Message-ID: <20260423190424.41619-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423190424.41619-1-dmarx@iol.unh.edu>
References: <20260423170331.33193-1-dmarx@iol.unh.edu>
 <20260423190424.41619-1-dmarx@iol.unh.edu>
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

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 .../dts/{framework.test_suite.rst => api.test_suite.rst}  | 2 +-
 doc/api/dts/index.rst                                     | 2 +-
 dts/api/capabilities.py                                   | 6 +++---
 dts/api/packet.py                                         | 2 +-
 dts/{framework => api}/test_suite.py                      | 7 +++----
 dts/framework/config/__init__.py                          | 4 ++--
 dts/framework/config/test_run.py                          | 8 ++++----
 dts/framework/context.py                                  | 2 +-
 dts/framework/test_run.py                                 | 2 +-
 dts/framework/testbed_model/capability.py                 | 6 +++---
 dts/tests/TestSuite_blocklist.py                          | 2 +-
 dts/tests/TestSuite_checksum_offload.py                   | 2 +-
 dts/tests/TestSuite_cryptodev_throughput.py               | 2 +-
 dts/tests/TestSuite_dual_vlan.py                          | 2 +-
 dts/tests/TestSuite_dynamic_config.py                     | 2 +-
 dts/tests/TestSuite_dynamic_queue_conf.py                 | 2 +-
 dts/tests/TestSuite_hello_world.py                        | 2 +-
 dts/tests/TestSuite_l2fwd.py                              | 2 +-
 dts/tests/TestSuite_mac_filter.py                         | 2 +-
 dts/tests/TestSuite_mtu.py                                | 2 +-
 dts/tests/TestSuite_packet_capture.py                     | 2 +-
 dts/tests/TestSuite_pmd_buffer_scatter.py                 | 2 +-
 dts/tests/TestSuite_pmd_rss.py                            | 2 +-
 dts/tests/TestSuite_port_control.py                       | 2 +-
 dts/tests/TestSuite_port_restart_config_persistency.py    | 2 +-
 dts/tests/TestSuite_port_stats.py                         | 2 +-
 dts/tests/TestSuite_promisc_support.py                    | 2 +-
 dts/tests/TestSuite_qinq.py                               | 2 +-
 dts/tests/TestSuite_queue_start_stop.py                   | 2 +-
 dts/tests/TestSuite_rte_flow.py                           | 2 +-
 dts/tests/TestSuite_rx_tx_offload.py                      | 2 +-
 dts/tests/TestSuite_single_core_forward_perf.py           | 2 +-
 dts/tests/TestSuite_smoke_tests.py                        | 2 +-
 dts/tests/TestSuite_softnic.py                            | 2 +-
 dts/tests/TestSuite_uni_pkt.py                            | 2 +-
 dts/tests/TestSuite_virtio_fwd.py                         | 2 +-
 dts/tests/TestSuite_vlan.py                               | 2 +-
 37 files changed, 47 insertions(+), 48 deletions(-)
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
index c719297c11..b9338d6b11 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -29,7 +29,7 @@ Modules
 
    framework.runner
    framework.test_run
-   framework.test_suite
+   api.test_suite
    framework.test_result
    framework.settings
    framework.context
diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
index 09bc538523..8569cacbd2 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -22,7 +22,7 @@
 Examples:
     .. code:: python
 
-        from framework.test_suite import TestSuite, func_test
+        from api.test_suite import TestSuite, func_test
         from framework.testbed_model.capability import LinkTopology, requires_link_topology
         # The whole test suite (each test case within) doesn't require any links.
         @requires_link_topology(LinkTopology.NO_LINK)
@@ -33,7 +33,7 @@ def hello_world_single_core(self):
 
     .. code:: python
 
-        from framework.test_suite import TestSuite, func_test
+        from api.test_suite import TestSuite, func_test
         from framework.testbed_model.capability import NicCapability, requires_nic_capability
         class TestPmdBufferScatter(TestSuite):
             # only the test case requires the SCATTERED_RX_ENABLED capability
@@ -47,7 +47,7 @@ def test_scatter_mbuf_2048(self):
 from typing import TYPE_CHECKING, Callable
 
 if TYPE_CHECKING:
-    from framework.test_suite import TestProtocol
+    from api.test_suite import TestProtocol
 
 
 class LinkTopology(IntEnum):
diff --git a/dts/api/packet.py b/dts/api/packet.py
index 094a1b7a9d..fc2be931fe 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -175,7 +175,7 @@ def adjust_addresses(packets: list[Packet], expected: bool = False) -> list[Pack
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
index 69ce26040a..f107b1cd2c 100644
--- a/dts/framework/test_suite.py
+++ b/dts/api/test_suite.py
@@ -30,12 +30,11 @@
 from typing_extensions import Self
 
 from framework.config.common import FrozenModel
+from framework.exception import ConfigurationError, InternalError
+from framework.logger import DTSLogger, get_dts_logger
 from framework.testbed_model.capability import TestProtocol
 from framework.testbed_model.topology import Topology
-
-from .exception import ConfigurationError, InternalError
-from .logger import DTSLogger, get_dts_logger
-from .utils import to_pascal_case
+from framework.utils import to_pascal_case
 
 if TYPE_CHECKING:
     from framework.context import Context
diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__init__.py
index d2f0138e4a..6f4f9d82f8 100644
--- a/dts/framework/config/__init__.py
+++ b/dts/framework/config/__init__.py
@@ -43,7 +43,7 @@
 
 # Import only if type checking or building docs, to prevent circular imports.
 if TYPE_CHECKING:
-    from framework.test_suite import BaseConfig
+    from api.test_suite import BaseConfig
 
 NodesConfig = Annotated[list[NodeConfiguration], Field(min_length=1)]
 
@@ -182,7 +182,7 @@ def load_config(ctx: ValidationContext) -> Configuration:
     nodes = _load_and_parse_model(ctx["settings"].nodes_config_path, NodesConfig, ctx)
 
     try:
-        from framework.test_suite import BaseConfig as BaseConfig
+        from api.test_suite import BaseConfig as BaseConfig
 
         Configuration.model_rebuild()
         return Configuration.model_validate(
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 76e24d1785..75737418a8 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -33,7 +33,7 @@
 from .common import FrozenModel, load_fields_from_settings
 
 if TYPE_CHECKING:
-    from framework.test_suite import BaseConfig, TestCase, TestSuite, TestSuiteSpec
+    from api.test_suite import BaseConfig, TestCase, TestSuite, TestSuiteSpec
 
 
 @unique
@@ -230,7 +230,7 @@ class TestSuiteConfig(FrozenModel):
     @cached_property
     def test_suite_spec(self) -> "TestSuiteSpec":
         """The specification of the requested test suite."""
-        from framework.test_suite import find_by_name
+        from api.test_suite import find_by_name
 
         test_suite_spec = find_by_name(self.test_suite_name)
         assert (
@@ -280,7 +280,7 @@ def fetch_all_test_suites() -> list[TestSuiteConfig]:
 
     This function does not include the smoke tests.
     """
-    from framework.test_suite import AVAILABLE_TEST_SUITES
+    from api.test_suite import AVAILABLE_TEST_SUITES
 
     return [
         TestSuiteConfig(test_suite=test_suite.name)
@@ -506,7 +506,7 @@ def filter_tests(
         self, tests_config: dict[str, "BaseConfig"]
     ) -> Iterable[tuple[type["TestSuite"], "BaseConfig", deque[type["TestCase"]]]]:
         """Filter test suites and cases selected for execution."""
-        from framework.test_suite import TestCaseType
+        from api.test_suite import TestCaseType
 
         test_suites = [TestSuiteConfig(test_suite="smoke_tests")]
 
diff --git a/dts/framework/context.py b/dts/framework/context.py
index 8f1021dc96..86745ab56b 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -16,8 +16,8 @@
 from framework.testbed_model.topology import Topology
 
 if TYPE_CHECKING:
+    from api.test_suite import TestCase, TestSuite
     from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
-    from framework.test_suite import TestCase, TestSuite
     from framework.testbed_model.capability import TestProtocol
     from framework.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
 
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 94dc6023a7..037ae6c9fb 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -106,6 +106,7 @@
 from types import MethodType
 from typing import ClassVar, Protocol, Union
 
+from api.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
 from framework.config.test_run import TestRunConfiguration
 from framework.context import Context, init_ctx
 from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
@@ -113,7 +114,6 @@
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
 from framework.test_result import Result, ResultNode, TestRunResult
-from framework.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
 from framework.testbed_model.capability import (
     Capability,
     get_supported_capabilities,
diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/testbed_model/capability.py
index 960370fc72..39f6f3c0df 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/framework/testbed_model/capability.py
@@ -25,7 +25,7 @@
 Examples:
     .. code:: python
 
-        from framework.test_suite import TestSuite, func_test
+        from api.test_suite import TestSuite, func_test
         from framework.testbed_model.capability import LinkTopology, requires
         # The whole test suite (each test case within) doesn't require any links.
         @requires_link_topology(LinkTopology.NO_LINK)
@@ -36,7 +36,7 @@ def hello_world_single_core(self):
 
     .. code:: python
 
-        from framework.test_suite import TestSuite, func_test
+        from api.test_suite import TestSuite, func_test
         from framework.testbed_model.capability import NicCapability, requires
         class TestPmdBufferScatter(TestSuite):
             # only the test case requires the SCATTERED_RX_ENABLED capability
@@ -71,8 +71,8 @@ def test_scatter_mbuf_2048(self):
 from framework.testbed_model.topology import Topology
 
 if TYPE_CHECKING:
+    from api.test_suite import TestCase
     from api.testpmd import TestPmd
-    from framework.test_suite import TestCase
 
 P = ParamSpec("P")
 TestPmdMethod = Callable[Concatenate["TestPmd", P], Any]
diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index c57231de22..05bfe951fd 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -11,8 +11,8 @@
     requires_link_topology,
 )
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
-from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.port import Port
 
 
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
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index af0a5680ab..3f046ad87e 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -30,9 +30,9 @@
     CryptodevResults,
 )
 from api.test import verify
+from api.test_suite import BaseConfig, TestSuite, crypto_test
 from framework.context import get_ctx
 from framework.exception import SkippedTestException
-from framework.test_suite import BaseConfig, TestSuite, crypto_test
 from framework.testbed_model.virtual_device import VirtualDevice
 
 config_list: list[dict[str, int | float | str]] = [
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
index 5ac85bee7d..e0ef1f447a 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -37,10 +37,10 @@
 )
 from api.packet import send_packets
 from api.test import fail, verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
 from framework.exception import InteractiveCommandExecutionError
-from framework.test_suite import TestSuite, func_test
 
 
 def setup_and_teardown_test(
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
index 596b892730..44fee58775 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -18,10 +18,10 @@
     match_all_packets,
     send_packets_and_capture,
 )
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer, SimpleForwardingModes
 from framework.context import filter_cores
-from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.cpu import LogicalCoreCount
 from framework.utils import generate_random_packets
 
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_filter.py
index a7e24b37d5..98c12459f6 100644
--- a/dts/tests/TestSuite_mac_filter.py
+++ b/dts/tests/TestSuite_mac_filter.py
@@ -25,9 +25,9 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import fail, verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from framework.exception import InteractiveCommandExecutionError
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
index 4bd15e2401..d37796954d 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -36,11 +36,11 @@
     send_packets_and_capture,
 )
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from framework.params import Params
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.dpdk_shell import compute_eal_params
-from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.cpu import LogicalCoreList
 from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuite_pmd_buffer_scatter.py
index 96da67ee7d..6c7f6d79fe 100644
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py
+++ b/dts/tests/TestSuite_pmd_buffer_scatter.py
@@ -28,9 +28,9 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_pmd_rss.py b/dts/tests/TestSuite_pmd_rss.py
index f6adf262c3..8777d446cd 100644
--- a/dts/tests/TestSuite_pmd_rss.py
+++ b/dts/tests/TestSuite_pmd_rss.py
@@ -22,6 +22,7 @@
 )
 from api.packet import send_packets_and_capture
 from api.test import verify
+from api.test_suite import BaseConfig, TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import (
@@ -30,7 +31,6 @@
     TestPmdVerbosePacket,
 )
 from framework.exception import InteractiveCommandExecutionError
-from framework.test_suite import BaseConfig, TestSuite, func_test
 from framework.utils import StrEnum
 
 
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port_control.py
index 6be47838d0..5b960cb3a3 100644
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
diff --git a/dts/tests/TestSuite_queue_start_stop.py b/dts/tests/TestSuite_queue_start_stop.py
index e9048d4245..6935f395c1 100644
--- a/dts/tests/TestSuite_queue_start_stop.py
+++ b/dts/tests/TestSuite_queue_start_stop.py
@@ -24,9 +24,9 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
 
 
 @requires_link_topology(LinkTopology.TWO_LINKS)
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow.py
index 6255e4c36d..3d74decb11 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_rte_flow.py
@@ -23,6 +23,7 @@
 from api.capabilities import NicCapability, requires_nic_capability
 from api.packet import send_packet_and_capture
 from api.test import fail, log, verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.types import FlowRule
 from framework.exception import (
@@ -30,7 +31,6 @@
     SkippedTestException,
     TestCaseVerifyError,
 )
-from framework.test_suite import TestSuite, func_test
 
 
 @dataclass
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
index 1e7ab7b036..f1eb435759 100644
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
index 271ad4301c..38ed2234cd 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -19,10 +19,10 @@
     requires_link_topology,
 )
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from framework.config.node import PortConfig
 from framework.settings import SETTINGS
-from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.linux_session import LinuxSession
 from framework.utils import REGEX_FOR_PCI_ADDRESS
 
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index fa91f7ee2f..263a915745 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -18,9 +18,9 @@
     match_all_packets,
     send_packets_and_capture,
 )
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer
-from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.virtual_device import VirtualDevice
 from framework.utils import generate_random_packets
 
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt.py
index 222276ce67..d83185d1b2 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_uni_pkt.py
@@ -25,10 +25,10 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
-from framework.test_suite import TestSuite, func_test
 
 
 class TestUniPkt(TestSuite):
diff --git a/dts/tests/TestSuite_virtio_fwd.py b/dts/tests/TestSuite_virtio_fwd.py
index bdecdb76fd..fd1fc476cc 100644
--- a/dts/tests/TestSuite_virtio_fwd.py
+++ b/dts/tests/TestSuite_virtio_fwd.py
@@ -12,9 +12,9 @@
 from api.capabilities import LinkTopology
 from api.packet import send_packets_and_capture
 from api.test import log, verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.capability import requires
 from framework.testbed_model.linux_session import LinuxSession
 from framework.testbed_model.virtual_device import VirtualDevice
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
2.52.0

