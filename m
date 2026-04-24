Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C815FED3F0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 17:02:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 149B540671;
	Fri, 24 Apr 2026 19:01:54 +0200 (CEST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mails.dpdk.org (Postfix) with ESMTP id E214B40662
 for <dev@dpdk.org>; Fri, 24 Apr 2026 19:01:51 +0200 (CEST)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-479e6bc357eso2075558b6e.2
 for <dev@dpdk.org>; Fri, 24 Apr 2026 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1777050111; x=1777654911; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bpM7LhH0/cOY1id6ET14PG7NHNjSy7fyqGuW9FqiIgc=;
 b=Ql8N2/3RHQOiWockXkstNLVr72ppB++bIZ1KONK7zfvt2pYFGvOBQA52dUlASUJRco
 OEsBIRAEkmcYlhhesEJGhhavFaEebHlbooc4ZvvtFc1PONFQZcPeh5CVwg67CyFKSHCs
 sSdZJQIfqh9EVnlKcXufGoODT8yVf6vFqwU3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777050111; x=1777654911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bpM7LhH0/cOY1id6ET14PG7NHNjSy7fyqGuW9FqiIgc=;
 b=VvETaAKoJzNpBgDugWWjq2pIQQx8sz4xBaU3El0SQRPB+mcNLK+cbQlm8aQervFIK/
 4qUcY5kQa73ngtPp/C1fpAlmDuvbCrrqqx0lzrHWNua40jj1q6HcfRpmqDYVgBVdOdaE
 RfniKe4dernJoU5NH7fETOFvHavR/9QBR3zydK1GNL561WzpQFcrs5rjsILRS4mHFfNt
 yzO6O5EGqKn3PGn6xxGRpxqrj8LDrXVSXyeD3NjDjEMTb35ucmh8IPGiozIKdxhmnvHl
 8mmQuSRufIoom9rMIUGCU15/iUi+Z2bY/Hl6IFTsx0NcmFef+xEvsF5aEEvN6VzJm2zn
 rmwg==
X-Gm-Message-State: AOJu0Yyd14F+dkahhxCPD+uGZCmVdlM4bwla/N/Y9bnwIv7Zu22uHZbD
 XuJ/G5vBl7TYnY/b7ZTaBTrWaWRbJI9MGgltw7E/BmRtxnOApWY9KQwCF59Cisc1PP0=
X-Gm-Gg: AeBDieuERzrWAj6GlGS66KTt6IYsgbDMXgcb9vjAqhMjO+L05lDzFfI3XDhG09Dh+9g
 gqCgokISpyJz5ZOjYkKbwPfpRQEONvKZ5WK3RcboKR9G69GxtIrznKyrwXTa291GUgN7Wc/GhHH
 c1SiKPeb5UHl8eHfWwHYF6SbdbtapjV3WjFW1naAfnt2Mi9BaNJAShUcyZktaRE4IwAO9w4btGg
 BQvFoaTPv/9rPaifmleaFyCfqdaTqFGaeXrs+UYAOqUrFRDZVksVB1wLxjFWgSZRTbojOp1LksO
 BXiBdr9XvemkeaSjLTikKqGMTdyfBiwUcSoqQpttF4lymNnytgIraeV/9eKNT/ptnyU7/UL9U7J
 ynHVakegH8+mKUhSrrRCNhycGXGOReVh61FDcNCbkefGcNhEHFolu1cQdMC+6DS2hIBf4J+Ml1C
 xYkO3OBiefxtWHNa1o0dWJsMkx0No9uyia+VnWYgqvZVeTf6iU4NGPIG1BOQQ7OU+zWqG6T+G4
X-Received: by 2002:a05:6808:2519:b0:47b:c2a2:1c89 with SMTP id
 5614622812f47-47bc2a2442amr4545415b6e.21.1777050110401; 
 Fri, 24 Apr 2026 10:01:50 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b031f65a27sm184065416d6.16.2026.04.24.10.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 10:01:49 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 5/7] dts: move test suite module from framework to API
Date: Fri, 24 Apr 2026 13:01:37 -0400
Message-ID: <20260424170139.20592-6-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260424170139.20592-1-dmarx@iol.unh.edu>
References: <20260423190424.41619-1-dmarx@iol.unh.edu>
 <20260424170139.20592-1-dmarx@iol.unh.edu>
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
 dts/api/context.py                                        | 2 +-
 dts/api/packet.py                                         | 2 +-
 dts/{framework => api}/test_suite.py                      | 3 +--
 dts/api/testbed_model/capability.py                       | 6 +++---
 dts/framework/config/__init__.py                          | 4 ++--
 dts/framework/config/test_run.py                          | 8 ++++----
 dts/framework/test_run.py                                 | 2 +-
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
 37 files changed, 45 insertions(+), 46 deletions(-)
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
index f47e4af3f2..7c282bbba1 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -29,7 +29,7 @@ Modules
 
    framework.runner
    framework.test_run
-   framework.test_suite
+   api.test_suite
    framework.test_result
    framework.settings
    api.context
diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
index 04fc20738b..a4d6b2b424 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -22,7 +22,7 @@
 Examples:
     .. code:: python
 
-        from framework.test_suite import TestSuite, func_test
+        from api.test_suite import TestSuite, func_test
         from api.testbed_model.capability import LinkTopology, requires_link_topology
         # The whole test suite (each test case within) doesn't require any links.
         @requires_link_topology(LinkTopology.NO_LINK)
@@ -33,7 +33,7 @@ def hello_world_single_core(self):
 
     .. code:: python
 
-        from framework.test_suite import TestSuite, func_test
+        from api.test_suite import TestSuite, func_test
         from api.testbed_model.capability import NicCapability, requires_nic_capability
         class TestPmdBufferScatter(TestSuite):
             # only the test case requires the SCATTERED_RX_ENABLED capability
@@ -47,7 +47,7 @@ def test_scatter_mbuf_2048(self):
 from typing import TYPE_CHECKING, Callable
 
 if TYPE_CHECKING:
-    from framework.test_suite import TestProtocol
+    from api.test_suite import TestProtocol
 
 
 class LinkTopology(IntEnum):
diff --git a/dts/api/context.py b/dts/api/context.py
index 13a2ad6c39..7ed4cc5665 100644
--- a/dts/api/context.py
+++ b/dts/api/context.py
@@ -16,10 +16,10 @@
 from framework.settings import SETTINGS
 
 if TYPE_CHECKING:
+    from api.test_suite import TestCase, TestSuite
     from api.testbed_model.capability import TestProtocol
     from api.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
     from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
-    from framework.test_suite import TestCase, TestSuite
 
 P = ParamSpec("P")
 
diff --git a/dts/api/packet.py b/dts/api/packet.py
index bf90961c26..873b8f0324 100644
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
index 786cfc7bff..0822f9bfe5 100644
--- a/dts/framework/test_suite.py
+++ b/dts/api/test_suite.py
@@ -34,8 +34,7 @@
 from api.testbed_model.topology import Topology
 from api.utils import to_pascal_case
 from framework.config.common import FrozenModel
-
-from .logger import DTSLogger, get_dts_logger
+from framework.logger import DTSLogger, get_dts_logger
 
 if TYPE_CHECKING:
     from api.context import Context
diff --git a/dts/api/testbed_model/capability.py b/dts/api/testbed_model/capability.py
index 4e4e976be5..95583261d8 100644
--- a/dts/api/testbed_model/capability.py
+++ b/dts/api/testbed_model/capability.py
@@ -25,7 +25,7 @@
 Examples:
     .. code:: python
 
-        from framework.test_suite import TestSuite, func_test
+        from api.test_suite import TestSuite, func_test
         from api.testbed_model.capability import LinkTopology, requires
         # The whole test suite (each test case within) doesn't require any links.
         @requires_link_topology(LinkTopology.NO_LINK)
@@ -36,7 +36,7 @@ def hello_world_single_core(self):
 
     .. code:: python
 
-        from framework.test_suite import TestSuite, func_test
+        from api.test_suite import TestSuite, func_test
         from api.testbed_model.capability import NicCapability, requires
         class TestPmdBufferScatter(TestSuite):
             # only the test case requires the SCATTERED_RX_ENABLED capability
@@ -71,8 +71,8 @@ def test_scatter_mbuf_2048(self):
 from framework.logger import get_dts_logger
 
 if TYPE_CHECKING:
+    from api.test_suite import TestCase
     from api.testpmd import TestPmd
-    from framework.test_suite import TestCase
 
 P = ParamSpec("P")
 TestPmdMethod = Callable[Concatenate["TestPmd", P], Any]
diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__init__.py
index 566dc7c4a2..3a3580aaf7 100644
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
index 977067f42a..81e3dba79b 100644
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
 
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 790fbf997d..c133fbecb0 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -108,6 +108,7 @@
 
 from api.context import Context, init_ctx
 from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
+from api.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
 from api.testbed_model.capability import (
     Capability,
     get_supported_capabilities,
@@ -121,7 +122,6 @@
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
 from framework.test_result import Result, ResultNode, TestRunResult
-from framework.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
 
 TestScenario = tuple[type[TestSuite], BaseConfig, deque[type[TestCase]]]
 
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
index fc4b3cb308..d2a6cbab94 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -32,8 +32,8 @@
 )
 from api.exception import SkippedTestException
 from api.test import verify
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
index 042b7019aa..fd5cef5268 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -36,6 +36,7 @@
     send_packets_and_capture,
 )
 from api.test import verify
+from api.test_suite import TestSuite, func_test
 from api.testbed_model.cpu import LogicalCoreList
 from api.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
@@ -44,7 +45,6 @@
 from framework.params import Params
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.dpdk_shell import compute_eal_params
-from framework.test_suite import TestSuite, func_test
 
 
 @dataclass(kw_only=True)
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
index 4df273e3e1..162e08ccbc 100644
--- a/dts/tests/TestSuite_pmd_rss.py
+++ b/dts/tests/TestSuite_pmd_rss.py
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
index 7e50a075ac..8c5c59edec 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_rte_flow.py
@@ -28,9 +28,9 @@
 )
 from api.packet import send_packet_and_capture
 from api.test import fail, log, verify
+from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.types import FlowRule
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
index c649aac197..2c10478df3 100644
--- a/dts/tests/TestSuite_virtio_fwd.py
+++ b/dts/tests/TestSuite_virtio_fwd.py
@@ -12,12 +12,12 @@
 from api.capabilities import LinkTopology
 from api.packet import send_packets_and_capture
 from api.test import log, verify
+from api.test_suite import TestSuite, func_test
 from api.testbed_model.capability import requires
 from api.testbed_model.linux_session import LinuxSession
 from api.testbed_model.virtual_device import VirtualDevice
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
-from framework.test_suite import TestSuite, func_test
 
 
 class TestVirtioFwd(TestSuite):
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

