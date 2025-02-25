Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDA6C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 15:34:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 125D440608;
	Tue, 25 Feb 2025 16:34:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 52CA6402D8
 for <dev@dpdk.org>; Tue, 25 Feb 2025 16:34:16 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19DC5292B;
 Tue, 25 Feb 2025 07:34:32 -0800 (PST)
Received: from e132991.cambridge.arm.com (unknown [10.1.195.24])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A42F33F5A1;
 Tue, 25 Feb 2025 07:34:14 -0800 (PST)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Alex Chapman <alex.chapman@arm.com>, Thomas Wilks <thomas.wilks@arm.com>
Subject: [PATCH v2 4/6] dts: add PMD RSS RETA testsuite
Date: Tue, 25 Feb 2025 15:33:43 +0000
Message-ID: <20250225153345.331216-5-thomas.wilks@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225153345.331216-1-thomas.wilks@arm.com>
References: <20240829125020.34341-1-alex.chapman@arm.com>
 <20250225153345.331216-1-thomas.wilks@arm.com>
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

From: Alex Chapman <alex.chapman@arm.com>

Port over the pmd_rss_reta test suite from old DTS. This
suite verifies that Redirection Tables (RETAs) of different
sizes function correctly in Receive Side Scaling (RSS).
This test suite also verifies that the reported reta size
of the NIC is correct.

Signed-off-by: Alex Chapman <alex.chapman@arm.com>
Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>

Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/tests/TestSuite_pmd_rss_reta.py | 101 ++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 dts/tests/TestSuite_pmd_rss_reta.py

diff --git a/dts/tests/TestSuite_pmd_rss_reta.py b/dts/tests/TestSuite_pmd_rss_reta.py
new file mode 100644
index 0000000000..31df817e75
--- /dev/null
+++ b/dts/tests/TestSuite_pmd_rss_reta.py
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Arm Limited
+
+"""RSS RETA (redirection table) Test Suite.
+
+The RETA is used in RSS to redirect packets to different queues based on the
+least significant bits of the packets hash.
+This suite tests updating the size of the RETA and verifying the reported RETA size.
+"""
+
+from framework.remote_session.testpmd_shell import TestPmdShell
+from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import requires
+from framework.testbed_model.topology import TopologyType
+
+from .pmd_rss_utils import (  # type: ignore[import-untyped]
+    SendTestPackets,
+    SetupRssEnvironment,
+    VerifyHashQueue,
+)
+
+ACTUAL_RETA_SIZE = 512
+
+
+@requires(topology_type=TopologyType.one_link)
+class TestPmdRssReta(TestSuite):
+    """PMD RSS Reta test suite.
+
+    Verifies the redirection table when updating the size.
+    The suite contains four tests, three for different RETA sizes
+    and one for verifying the reported RETA size.
+    """
+
+    def CheckRetaNQueues(self, num_queues: int) -> None:
+        """Create RETA of size n, send packets, verify packets end up in correct queue.
+
+        Args:
+            num_queues: Number of rx/tx queues.
+        """
+        with TestPmdShell(
+            rx_queues=num_queues,
+            tx_queues=num_queues,
+        ) as testpmd:
+            # Setup testpmd for RSS, create RETA table, return RETA table and key_size
+            reta, _ = SetupRssEnvironment(self, testpmd, num_queues, None)
+
+            # Send UDP packets and ensure hash corresponds with queue
+            parsed_output = SendTestPackets(self, testpmd, False)
+            VerifyHashQueue(self, reta, parsed_output, False)
+
+    @func_test
+    def TestReta2Queues(self) -> None:
+        """RETA rx/tx queues 2 test.
+
+        Steps:
+            Setup RSS environment and send Test packets.
+        Verify:
+            Packet hash corresponds to hash queue.
+        """
+        self.CheckRetaNQueues(2)
+
+    @func_test
+    def TestReta9Queues(self) -> None:
+        """RETA rx/tx queues 9 test.
+
+        Steps:
+            Setup RSS environment and send Test packets.
+        Verify:
+            Packet hash corresponds to hash queue.
+        """
+        self.CheckRetaNQueues(9)
+
+    @func_test
+    def TestReta16Queues(self) -> None:
+        """RETA rx/tx queues 16 test.
+
+        Steps:
+            Setup RSS environment and send Test packets.
+        Verify:
+            Packet hash corresponds to hash queue.
+        """
+        self.CheckRetaNQueues(16)
+
+    @func_test
+    def TestReportedRetaSize(self) -> None:
+        """Reported RETA size test.
+
+        Steps:
+            Fetch reported reta size.
+        Verify:
+            Reported RETA size is equal to the actual RETA size.
+        """
+        with TestPmdShell() as testpmd:
+            self.topology.sut_port_egress.config
+            # Get RETA table size
+            port_info = testpmd.show_port_info(0)
+            reported_reta_size = port_info.redirection_table_size
+            self.verify(
+                reported_reta_size == ACTUAL_RETA_SIZE,
+                "Reported RETA size is not the same as the config file.",
+            )
-- 
2.43.0

