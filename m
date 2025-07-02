Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5421C83F04
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 16:23:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F7A140E68;
	Wed,  2 Jul 2025 18:23:39 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 10EF4406B8
 for <dev@dpdk.org>; Wed,  2 Jul 2025 18:23:37 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7d20f799fe9so776835185a.2
 for <dev@dpdk.org>; Wed, 02 Jul 2025 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751473416; x=1752078216; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ia7IUL0WeV9i5WNYbO10ajn3CpkmZCRTYn4n6VeAwT4=;
 b=XayxsWriMKAEqNHcHdqT8yn7+WLRNsKNW+5GcFLvMbUloZEU50kPn7v9BnxFlKYXm/
 VnufgMGt+m9oopTSehuUarboraNb1nwcfZaoBTjwmebthnYREjC/+7H0rbo19Uk36UM9
 ViU5AGFy+QYi9gnYceEerathit+Y+iUPTmhBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751473416; x=1752078216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ia7IUL0WeV9i5WNYbO10ajn3CpkmZCRTYn4n6VeAwT4=;
 b=hRLCCUU/0AvUh8PYN6mHnEzvVRkZh2+mqMzKIehIBcHhDKzO37sNcKqJfiLO85/Wyh
 07eAsPamHzJ1KfWa36hs9MYFbzNYOB7yeBmdzMmCVodQN0Ch48ce/QYr/vJXRUZYuHHU
 aBwfGUo3uZZ8syjTikhx90GrfvZXDifEZZaBbjMTkK9L+qWeE7kMDBfGmuFoTfFN8kyF
 SxZ7NmejDdNRxP6I9CNsAtYXBzXmSoeZt6NYZ9XGy/T3n5jNee+7nrdwT/UO2fJosxGq
 g3QCbnzvc2VsrX8XxXD+NfHzgk8uFUn3JfSYyevxrvIBqzJXLk1wpDBI1OEUcjG4kWpk
 IrZw==
X-Gm-Message-State: AOJu0YwfrmKHQmnAd0HsMH4N0Y0GxDjqmaNESl2f8l+gjfKs96RA43re
 B6ELYcDWx52te2JxCIFNrejGsm4pEsNOYGtKtMFWIwew7KiT50a1yDufnsvjjTK/gBM=
X-Gm-Gg: ASbGncvA4hEmKyyYKyvfXAIY1B/Q0dYKgph/ndfryCmVjIyQX34yVGvKpnd18VdtjCn
 W/ZJde5k0YIV6pmhuT5N5mrTEXrjoSNZOY64zrWzmG2oODxxOP3o1SoaicmR0705mq8Blp5hZ3A
 v7IBUKmlrjF6ZPEJJWMEw26n3iT+BeCPIL58Shr+QrmzjOlHklhoTAceLJ41MiR+NZrYcPeNxjn
 7oVhD57H3DoqkjuXk+6oT2j0Xj7ZrCBh7ueCDE9urOuEinuigI0CCht2phLbwDj6RQx2ivaJew1
 KRuqjKno5DG350bjF2uiDl3prZHkVtGj3/8GaO3X0/OXPrt5CjcocKmGbnvzZe77zkrTB5JR
X-Google-Smtp-Source: AGHT+IH+FA0cEPNgf3jTzYK3jtW9RHG3cUPdSz8U6Y1ky2PgNPiSmGRsDyXGFY7Fv3kTBTgkBGkGRg==
X-Received: by 2002:a05:620a:6190:b0:7d4:4ce0:4e7b with SMTP id
 af79cd13be357-7d5c472d458mr418021885a.13.1751473416231; 
 Wed, 02 Jul 2025 09:23:36 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44316585dsm966947785a.28.2025.07.02.09.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 09:23:35 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 3/4] dts: add physical function capability check
Date: Wed,  2 Jul 2025 12:23:30 -0400
Message-ID: <20250702162331.352313-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702162331.352313-1-dmarx@iol.unh.edu>
References: <20250626152755.197560-3-dmarx@iol.unh.edu>
 <20250702162331.352313-1-dmarx@iol.unh.edu>
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

Add a physical function NIC capability that checks
if the test run is using PFs. Add PF capability
requirement to all suites/cases that do not
run without error on virtual functions.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 22 +++++++++++++++++++
 dts/tests/TestSuite_dynamic_config.py         |  3 ++-
 dts/tests/TestSuite_dynamic_queue_conf.py     |  1 +
 dts/tests/TestSuite_l2fwd.py                  |  3 ++-
 dts/tests/TestSuite_mac_filter.py             |  1 +
 dts/tests/TestSuite_mtu.py                    |  4 +++-
 dts/tests/TestSuite_pmd_buffer_scatter.py     |  1 +
 dts/tests/TestSuite_port_control.py           |  3 ++-
 dts/tests/TestSuite_port_stats.py             |  2 ++
 dts/tests/TestSuite_promisc_support.py        |  4 +++-
 dts/tests/TestSuite_rte_flow.py               |  1 +
 dts/tests/TestSuite_softnic.py                |  3 ++-
 dts/tests/TestSuite_uni_pkt.py                |  2 ++
 13 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 6d75f89969..ad8cb273dc 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -2655,6 +2655,23 @@ def get_capabilities_flow_ctrl(
         else:
             unsupported_capabilities.add(NicCapability.FLOW_CTRL)
 
+    def get_capabilities_physical_function(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ) -> None:
+        """Store capability representing a physical function test run.
+
+        Args:
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+        """
+        ctx = get_ctx()
+        if ctx.topology.vf_ports == []:
+            supported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
+        else:
+            unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
+
 
 class NicCapability(NoAliasEnum):
     """A mapping between capability names and the associated :class:`TestPmdShell` methods.
@@ -2803,6 +2820,11 @@ class NicCapability(NoAliasEnum):
     )
     #: Device supports flow ctrl.
     FLOW_CTRL: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_flow_ctrl, None)
+    #: Device is running on a physical function.
+    PHYSICAL_FUNCTION: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_physical_function,
+        None,
+    )
 
     def __call__(
         self,
diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dynamic_config.py
index 1fce31a0b5..49f295a39a 100644
--- a/dts/tests/TestSuite_dynamic_config.py
+++ b/dts/tests/TestSuite_dynamic_config.py
@@ -20,11 +20,12 @@
 from scapy.packet import Raw
 
 from framework.params.testpmd import SimpleForwardingModes
-from framework.remote_session.testpmd_shell import TestPmdShell
+from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
 from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.capability import TopologyType, requires
 
 
+@requires(NicCapability.PHYSICAL_FUNCTION)
 @requires(topology_type=TopologyType.two_links)
 class TestDynamicConfig(TestSuite):
     """Dynamic config suite.
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index 344dd540eb..f8c7dbfb71 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -117,6 +117,7 @@ def wrap(self: "TestDynamicQueueConf", is_rx_testing: bool) -> None:
     return wrap
 
 
+@requires(NicCapability.PHYSICAL_FUNCTION)
 class TestDynamicQueueConf(TestSuite):
     """DPDK dynamic queue configuration test suite.
 
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index 0555d75ed8..5ffa2dcd19 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -9,7 +9,7 @@
 
 from framework.context import filter_cores
 from framework.params.testpmd import EthPeer, SimpleForwardingModes
-from framework.remote_session.testpmd_shell import TestPmdShell
+from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
 from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.capability import requires
 from framework.testbed_model.cpu import LogicalCoreCount
@@ -17,6 +17,7 @@
 from framework.utils import generate_random_packets
 
 
+@requires(NicCapability.PHYSICAL_FUNCTION)
 @requires(topology_type=TopologyType.two_links)
 class TestL2fwd(TestSuite):
     """L2 forwarding test suite."""
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_filter.py
index 9dbfec5da2..2387fdfac2 100644
--- a/dts/tests/TestSuite_mac_filter.py
+++ b/dts/tests/TestSuite_mac_filter.py
@@ -25,6 +25,7 @@
 from framework.testbed_model.capability import requires
 
 
+@requires(NicCapability.PHYSICAL_FUNCTION)
 class TestMacFilter(TestSuite):
     """Mac address allowlist filtering test suite.
 
diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
index af6ab88501..d5b3fe02af 100644
--- a/dts/tests/TestSuite_mtu.py
+++ b/dts/tests/TestSuite_mtu.py
@@ -17,8 +17,9 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Raw
 
-from framework.remote_session.testpmd_shell import TestPmdShell
+from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
 from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import requires
 
 STANDARD_FRAME = 1518  # --max-pkt-len will subtract l2 information at a minimum of 18 bytes.
 JUMBO_FRAME = 9018
@@ -30,6 +31,7 @@
 VENDOR_AGNOSTIC_PADDING = 9  # Used as a work around for varying MTU definitions between vendors.
 
 
+@requires(NicCapability.PHYSICAL_FUNCTION)
 class TestMtu(TestSuite):
     """DPDK PMD jumbo frames and MTU update test suite.
 
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuite_pmd_buffer_scatter.py
index 5e23f28bc6..015163dd11 100644
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py
+++ b/dts/tests/TestSuite_pmd_buffer_scatter.py
@@ -28,6 +28,7 @@
 from framework.testbed_model.capability import NicCapability, requires
 
 
+@requires(NicCapability.PHYSICAL_FUNCTION)
 @requires(NicCapability.RX_OFFLOAD_SCATTER)
 class TestPmdBufferScatter(TestSuite):
     """DPDK PMD packet scattering test suite.
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port_control.py
index ad5a09c58e..58783f1d18 100644
--- a/dts/tests/TestSuite_port_control.py
+++ b/dts/tests/TestSuite_port_control.py
@@ -13,11 +13,12 @@
 from scapy.packet import Packet, Raw
 
 from framework.params.testpmd import SimpleForwardingModes
-from framework.remote_session.testpmd_shell import TestPmdShell
+from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
 from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.capability import TopologyType, requires
 
 
+@requires(NicCapability.PHYSICAL_FUNCTION)
 @requires(topology_type=TopologyType.two_links)
 class TestPortControl(TestSuite):
     """DPDK Port Control Testing Suite."""
diff --git a/dts/tests/TestSuite_port_stats.py b/dts/tests/TestSuite_port_stats.py
index 2bb8747399..ddd28623b3 100644
--- a/dts/tests/TestSuite_port_stats.py
+++ b/dts/tests/TestSuite_port_stats.py
@@ -19,6 +19,7 @@
 
 from framework.params.testpmd import SimpleForwardingModes
 from framework.remote_session.testpmd_shell import (
+    NicCapability,
     RtePTypes,
     TestPmdShell,
     TestPmdVerbosePacket,
@@ -27,6 +28,7 @@
 from framework.testbed_model.capability import TopologyType, requires
 
 
+@requires(NicCapability.PHYSICAL_FUNCTION)
 @requires(topology_type=TopologyType.two_links)
 class TestPortStats(TestSuite):
     """DPDK Port statistics testing suite.
diff --git a/dts/tests/TestSuite_promisc_support.py b/dts/tests/TestSuite_promisc_support.py
index 445f6e1d69..8a7a7efb57 100644
--- a/dts/tests/TestSuite_promisc_support.py
+++ b/dts/tests/TestSuite_promisc_support.py
@@ -11,10 +11,12 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Raw
 
-from framework.remote_session.testpmd_shell import TestPmdShell
+from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
 from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import requires
 
 
+@requires(NicCapability.PHYSICAL_FUNCTION)
 class TestPromiscSupport(TestSuite):
     """Promiscuous mode support test suite."""
 
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow.py
index e70f7ea8d1..4855e4261d 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_rte_flow.py
@@ -316,6 +316,7 @@ def test_queue_action_IP(self) -> None:
             test_queue=2,
         )
 
+    @requires(NicCapability.PHYSICAL_FUNCTION)
     @func_test
     def test_queue_action_L4(self) -> None:
         """Validate flow rules with queue actions and TCP/UDP patterns.
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index c1873dca4c..27754c08e7 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -9,7 +9,7 @@
 from pathlib import Path, PurePath
 
 from framework.params.testpmd import EthPeer
-from framework.remote_session.testpmd_shell import TestPmdShell
+from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
 from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.capability import requires
 from framework.testbed_model.topology import TopologyType
@@ -17,6 +17,7 @@
 from framework.utils import generate_random_packets
 
 
+@requires(NicCapability.PHYSICAL_FUNCTION)
 @requires(topology_type=TopologyType.two_links)
 class TestSoftnic(TestSuite):
     """Softnic test suite."""
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt.py
index fdb9c29059..690c5d4fd1 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_uni_pkt.py
@@ -20,6 +20,7 @@
 from scapy.packet import Packet, Raw
 
 from framework.remote_session.testpmd_shell import (
+    NicCapability,
     RtePTypes,
     SimpleForwardingModes,
     TestPmdShell,
@@ -258,6 +259,7 @@ def test_nsh_packet_detect(self) -> None:
         with TestPmdShell() as testpmd:
             self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
 
+    @requires(NicCapability.PHYSICAL_FUNCTION)
     @func_test
     def test_vxlan_tunnel_packet_detect(self) -> None:
         """Ensure the correct flags are shown in the verbose output when sending VXLAN packets.
-- 
2.49.0

