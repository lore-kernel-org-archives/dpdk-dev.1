Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C0CC021BB
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 15:34:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EC36402F2;
	Tue, 25 Feb 2025 16:34:18 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id D3E85402E0
 for <dev@dpdk.org>; Tue, 25 Feb 2025 16:34:14 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BCFF1BCB;
 Tue, 25 Feb 2025 07:34:30 -0800 (PST)
Received: from e132991.cambridge.arm.com (unknown [10.1.195.24])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31C713F5A1;
 Tue, 25 Feb 2025 07:34:13 -0800 (PST)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Alex Chapman <alex.chapman@arm.com>, Thomas Wilks <thomas.wilks@arm.com>
Subject: [PATCH v2 3/6] dts: add PMD RSS hash testsuite
Date: Tue, 25 Feb 2025 15:33:42 +0000
Message-ID: <20250225153345.331216-4-thomas.wilks@arm.com>
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

Port over the pmd_rss_hash test suite from old DTS. This
suite verifies that the 4 supported types of hashing
algorithm used in Receive Side Scaling (RSS) function
correctly. Them being DEFAULT, TOEPLITZ
SYMMETRIC_TOEPLITZ and SIMPLE_XOR. This test suite also
verifies the supported hashing algorithms reported by
the NIC are correct.

Signed-off-by: Alex Chapman <alex.chapman@arm.com>
Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>

Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/tests/TestSuite_pmd_rss_hash.py | 118 ++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 dts/tests/TestSuite_pmd_rss_hash.py

diff --git a/dts/tests/TestSuite_pmd_rss_hash.py b/dts/tests/TestSuite_pmd_rss_hash.py
new file mode 100644
index 0000000000..d21e33456e
--- /dev/null
+++ b/dts/tests/TestSuite_pmd_rss_hash.py
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Arm Limited
+
+"""RSS Hash testing suite.
+
+Hashing algorithms are used in conjunction with a RSS hash keys to hash packets.
+This test suite verifies that updating the Hashing algorithms will
+continue to correctly hash packets.
+
+Symmetric_toeplitz_sort hasn't been included due to it not being supported by
+the rss func actions in the flow rule.
+"""
+
+from framework.remote_session.testpmd_shell import FlowRule, TestPmdShell
+from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import NicCapability, requires
+from framework.testbed_model.topology import TopologyType
+from framework.utils import StrEnum
+
+from .pmd_rss_utils import (  # type: ignore[import-untyped]
+    SendTestPackets,
+    SetupRssEnvironment,
+    VerifyHashQueue,
+)
+
+NUM_QUEUES = 16
+
+
+class HashAlgorithm(StrEnum):
+    """Enum of hashing algorithms."""
+
+    DEFAULT = "default"
+    SIMPLE_XOR = "simple_xor"
+    TOEPLITZ = "toeplitz"
+    SYMMETRIC_TOEPLITZ = "symmetric_toeplitz"
+
+
+@requires(topology_type=TopologyType.one_link)
+class TestPmdRssHash(TestSuite):
+    """PMD RSS Hash test suite.
+
+    Verifies the redirection table when updating the size.
+    The suite contains four tests, one for each hash algorithms.
+    """
+
+    def VerifyHashFunction(self, hash_algorithm: HashAlgorithm) -> None:
+        """Verifies the hash function is supported by the NIC.
+
+        Args:
+            hash_algorithm: The hash algorithm to be tested.
+        """
+        is_symmetric = hash_algorithm == HashAlgorithm.SYMMETRIC_TOEPLITZ
+        # Build flow rule
+        flow_rule = FlowRule(
+            group_id=0,
+            direction="ingress",
+            pattern=["eth / ipv4 / udp"],
+            actions=[f"rss types ipv4-udp end queues end func {str(hash_algorithm).lower()}"],
+        )
+
+        # Run the key update test suite with an asymmetric hash algorithm
+        with TestPmdShell(
+            rx_queues=NUM_QUEUES,
+            tx_queues=NUM_QUEUES,
+        ) as testpmd:
+            # Setup testpmd environment for RSS, create RETA table, return RETA table and key_size
+            reta, _ = SetupRssEnvironment(self, testpmd, NUM_QUEUES, flow_rule)
+            # Send udp packets and ensure hash corresponds with queue
+            parsed_output = SendTestPackets(self, testpmd, is_symmetric)
+            VerifyHashQueue(self, reta, parsed_output, is_symmetric)
+
+    @func_test
+    def TestDefaultHashAlgorithm(self) -> None:
+        """Default hashing algorithm test.
+
+        Steps:
+            Setup RSS environment using the default RSS hashing algorithm
+            and send test packets.
+        Verify:
+            Packet hash corresponds to the packet queue.
+        """
+        self.VerifyHashFunction(HashAlgorithm.DEFAULT)
+
+    @func_test
+    def TestToeplitzHashAlgorithm(self) -> None:
+        """Toeplitz hashing algorithm test.
+
+        Steps:
+            Setup RSS environment using the toeplitz RSS hashing algorithm and send test packets.
+        Verify:
+            Packet hash corresponds to the packet queue.
+        """
+        self.VerifyHashFunction(HashAlgorithm.TOEPLITZ)
+
+    @func_test
+    def TestSymmetricToeplitzHashAlgorithm(self) -> None:
+        """Symmetric toeplitz hashing algorithm test.
+
+        Steps:
+            Setup RSS environment using the symmetric_toeplitz RSS hashing algorithm
+            and send test packets.
+        Verify:
+            Packet hash corresponds to the packet queue.
+        """
+        self.VerifyHashFunction(HashAlgorithm.SYMMETRIC_TOEPLITZ)
+
+    @requires(NicCapability.XOR_SUPPORT)
+    @func_test
+    def TestSimpleXorHashAlgorithm(self) -> None:
+        """Simple xor hashing algorithm test.
+
+        Steps:
+            Setup RSS environment using the simple xor RSS hashing algorithm
+            and send test packets.
+        Verify:
+            Packet hash corresponds to the packet queue.
+        """
+        self.VerifyHashFunction(HashAlgorithm.SIMPLE_XOR)
-- 
2.43.0

