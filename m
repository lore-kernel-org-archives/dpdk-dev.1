Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E170C7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 15:28:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EBB140663;
	Thu, 26 Jun 2025 17:28:08 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id B46F140655
 for <dev@dpdk.org>; Thu, 26 Jun 2025 17:28:04 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7d20451c016so67634185a.1
 for <dev@dpdk.org>; Thu, 26 Jun 2025 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750951684; x=1751556484; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kp5nMr5wHfaWzaAAfAf0v7UHuiUp5cW8cTa46MbYFMk=;
 b=JhFOn2YoXuH2xfBq4eyN+chgZkKbpWOi6dVsr/7qtmPwHvtwl6PyyA3gfP+czkn9st
 tUuDkzCBM8YPwa1CJJ3QmBYBnWeVOoic0HUA6HYSLoyEOv9j9f56THN45u27nEMwV+80
 Z2Dh2la52xgzNVp4Y5SeWHUvxu0ffnCW3r+sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750951684; x=1751556484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kp5nMr5wHfaWzaAAfAf0v7UHuiUp5cW8cTa46MbYFMk=;
 b=Vnu7Biw731N2BMtKXm0ZHJSNMD9r7sw/V5osfWGURboaU0sBCowvUkOrDIQx9PXhDG
 gjM1Me5tzQfvG6whm8TxoSvu3xNCdBvFj/BP5XzBhii+QOYVJlsOs3zD8hMnfIDiCYcL
 /lNO5eQo/KtQJyiNxLjHs1efREg7ZcqeJsAnliq5mYJg2QY/TapIKm4bHE8jgnLgIjOH
 WFqT/fqnjhnLfuE1D8J8rFFJmJeQbJ8ESrvNKMtK+JGQqXBaZFIY4hSlI2WtgJtP6Ub+
 J18RX/JBsIm/vhElQBs8EaF7h+Qr8auddDRJjS6J4jZcSpa/c29waKCk0C/SPLhNLYo5
 F8og==
X-Gm-Message-State: AOJu0YyXdYAWxYxSOMYceO4vgbdQfLaqV65xx6NQFCtsaf0LnLYIZoay
 9HSgrpaezKfm0H0qvnbrEwrPq26Qe4mW6gVnwz7bNJf2kDKN2TREcpVJq/cINDSes7M=
X-Gm-Gg: ASbGncuMOlv5HRMcC3oLlVGooP5S0g5T09CGpIjrdlu2S2Xff/8gNnSqSMiisBr1X32
 sTuMTPSaEZs9WRVZgStHmxAy3s01Mslaq3v2NCDglpR9DgYTi7VkCzKIJF7QLR7TCbD/rwwS56P
 h7ydUL+z+ALYHISP3r5wqjR+KwRVSmdhJWTz1iR7zjKyAD8qz+rvyZMx8nOw9Pa0sVEAJ3r0iCC
 5fMn8YE6rJJ7MVrG7yDnuJ1KUF2PhcwjRiy860/YgZScvmC7GO1zIL7aOPWyfTYKqhzpjkrroyp
 3LrvNoygxQqGYHDmidMlc3VK3kuRLRFN2OsqWIrxdj61/vGZoglD5S7CyuzsHTmIxtQpMTJWtUm
 kkt0d07A=
X-Google-Smtp-Source: AGHT+IE99kE8LvuIC8dfHjAmOkgSITHBk8FqYq+M9+l1oL07zQU4/EzRuZE7kOO2sjl1D7ZSKloYDw==
X-Received: by 2002:a05:620a:4728:b0:7d0:4615:1ffb with SMTP id
 af79cd13be357-7d429740582mr1146631285a.23.1750951683930; 
 Thu, 26 Jun 2025 08:28:03 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443219fb7sm12287085a.80.2025.06.26.08.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 08:28:03 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 4/4] dts: add physical function capability check
Date: Thu, 26 Jun 2025 11:27:55 -0400
Message-ID: <20250626152755.197560-4-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626152755.197560-1-dmarx@iol.unh.edu>
References: <20250617201358.708638-1-dmarx@iol.unh.edu>
 <20250626152755.197560-1-dmarx@iol.unh.edu>
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
 dts/tests/TestSuite_pmd_buffer_scatter.py     |  1 +
 dts/tests/TestSuite_port_control.py           |  3 ++-
 dts/tests/TestSuite_port_stats.py             |  2 ++
 dts/tests/TestSuite_promisc_support.py        |  4 +++-
 dts/tests/TestSuite_softnic.py                |  3 ++-
 dts/tests/TestSuite_uni_pkt.py                |  2 ++
 11 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index a035452bcf..4156a289a1 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -2640,6 +2640,23 @@ def get_capabilities_flow_ctrl(
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
@@ -2788,6 +2805,11 @@ class NicCapability(NoAliasEnum):
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
index 62da208c45..cd35e73087 100644
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

