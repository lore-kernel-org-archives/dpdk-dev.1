Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC0C021BB
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 15:34:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA74940654;
	Tue, 25 Feb 2025 16:34:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 727DD40608
 for <dev@dpdk.org>; Tue, 25 Feb 2025 16:34:19 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B0FB1BCB;
 Tue, 25 Feb 2025 07:34:35 -0800 (PST)
Received: from e132991.cambridge.arm.com (unknown [10.1.195.24])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 936903F5A1;
 Tue, 25 Feb 2025 07:34:17 -0800 (PST)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Thomas Wilks <thomas.wilks@arm.com>
Subject: [PATCH v2 6/6] dts: add NIC capabilities for hash algorithms
Date: Tue, 25 Feb 2025 15:33:45 +0000
Message-ID: <20250225153345.331216-7-thomas.wilks@arm.com>
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

Added checks for if a nic supports the simple_xor,
symmetric_toeplitz, symmetric_toeplitz_sort,
toeplitz, and default hashing algorithms.

Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>

Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/remote_session/testpmd_shell.py | 146 ++++++++++++++++++
 dts/tests/TestSuite_pmd_rss_hash.py           |   5 +-
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 0e1f29f2f3..4a5b31574c 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -2678,6 +2678,127 @@ def get_capabilities_flow_ctrl(
         else:
             unsupported_capabilities.add(NicCapability.FLOW_CTRL)
 
+    def get_capabilities_xor_rss_hash_algorithms(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ) -> None:
+        """Get simple_xor rss hash algorithm capability and check for testpmd failure.
+
+        Args:
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+        """
+        self.get_capabilities_rss_hash_algorithms(
+            "simple_xor",
+            NicCapability.RSS_HASH_XOR,
+            supported_capabilities,
+            unsupported_capabilities,
+        )
+
+    def get_capabilities_symmetric_toeplitz_rss_hash_algorithms(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ) -> None:
+        """Get symmetric_toeplitz rss hash algorithm capability and check for testpmd failure.
+
+        Args:
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+        """
+        self.get_capabilities_rss_hash_algorithms(
+            "symmetric Toeplitz",
+            NicCapability.RSS_HASH_SYMMETRIC_TOEPLITZ,
+            supported_capabilities,
+            unsupported_capabilities,
+        )
+
+    def get_capabilities_toeplitz_rss_hash_algorithms(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ) -> None:
+        """Get toeplitz rss hash algorithm capability and check for testpmd failure.
+
+        Args:
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+        """
+        self.get_capabilities_rss_hash_algorithms(
+            "toeplitz",
+            NicCapability.RSS_HASH_TOEPLITZ,
+            supported_capabilities,
+            unsupported_capabilities,
+        )
+
+    def get_capabilities_default_rss_hash_algorithms(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ) -> None:
+        """Get default rss hash algorithm capability and check for testpmd failure.
+
+        Args:
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+        """
+        self.get_capabilities_rss_hash_algorithms(
+            "default",
+            NicCapability.RSS_HASH_DEFAULT,
+            supported_capabilities,
+            unsupported_capabilities,
+        )
+
+    def get_capabilities_symmetric_toeplitz_sort_rss_hash_algorithms(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ) -> None:
+        """Get symmetric_toeplitz_sort rss hash algorithm capability and check for testpmd failure.
+
+        Args:
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+        """
+        self.get_capabilities_rss_hash_algorithms(
+            "symmetric_toeplitz_sort",
+            NicCapability.RSS_HASH_SYMMETRIC_TOEPLITZ_SORT,
+            supported_capabilities,
+            unsupported_capabilities,
+        )
+
+    def get_capabilities_rss_hash_algorithms(
+        self,
+        algorithm: str,
+        NicCapability,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ):
+        """Get algorithm and check for capability.
+
+        Args:
+            algorithm: The rss algorithm that is being tested.
+            NicCapability: The nic capability constant to be added to one of the MutableSets.
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+
+        """
+        self._logger.debug(f"Getting hash capabilities for {algorithm} algorithm.")
+        self.send_command("port stop all")
+        self.send_command("port config all rxq 16")
+        self.send_command("port config all txq 16")
+        self.send_command("port start all")
+        command = f"show port {self.ports[0].id} rss-hash algorithm"
+        output = self.send_command(command)
+        if algorithm in output:
+            supported_capabilities.add(NicCapability)
+        else:
+            unsupported_capabilities.add(NicCapability)
+        self.send_command("port stop all")
+        self.send_command("port config all rxq 0")
+        self.send_command("port config all txq 0")
+
 
 class NicCapability(NoAliasEnum):
     """A mapping between capability names and the associated :class:`TestPmdShell` methods.
@@ -2844,6 +2965,31 @@ class NicCapability(NoAliasEnum):
         TestPmdShell.get_capabilities_flow_ctrl,
         None,
     )
+    #: Device supports simple_xor algorithm.
+    RSS_HASH_XOR: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_xor_rss_hash_algorithms,
+        None,
+    )
+    #: Device supports symmetric_toeplitz algorithm.
+    RSS_HASH_SYMMETRIC_TOEPLITZ: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_symmetric_toeplitz_rss_hash_algorithms,
+        None,
+    )
+    #: Device supports toeplitz algorithm.
+    RSS_HASH_TOEPLITZ: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_toeplitz_rss_hash_algorithms,
+        None,
+    )
+    #: Device supports default algorithm.
+    RSS_HASH_DEFAULT: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_default_rss_hash_algorithms,
+        None,
+    )
+    #: Device supports symmetric_toeplitz_sort algorithm.
+    RSS_HASH_SYMMETRIC_TOEPLITZ_SORT: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_symmetric_toeplitz_sort_rss_hash_algorithms,
+        None,
+    )
 
     def __call__(
         self,
diff --git a/dts/tests/TestSuite_pmd_rss_hash.py b/dts/tests/TestSuite_pmd_rss_hash.py
index d21e33456e..93aad80d50 100644
--- a/dts/tests/TestSuite_pmd_rss_hash.py
+++ b/dts/tests/TestSuite_pmd_rss_hash.py
@@ -69,6 +69,7 @@ def VerifyHashFunction(self, hash_algorithm: HashAlgorithm) -> None:
             parsed_output = SendTestPackets(self, testpmd, is_symmetric)
             VerifyHashQueue(self, reta, parsed_output, is_symmetric)
 
+    @requires(NicCapability.RSS_HASH_DEFAULT)
     @func_test
     def TestDefaultHashAlgorithm(self) -> None:
         """Default hashing algorithm test.
@@ -81,6 +82,7 @@ def TestDefaultHashAlgorithm(self) -> None:
         """
         self.VerifyHashFunction(HashAlgorithm.DEFAULT)
 
+    @requires(NicCapability.RSS_HASH_TOEPLITZ)
     @func_test
     def TestToeplitzHashAlgorithm(self) -> None:
         """Toeplitz hashing algorithm test.
@@ -92,6 +94,7 @@ def TestToeplitzHashAlgorithm(self) -> None:
         """
         self.VerifyHashFunction(HashAlgorithm.TOEPLITZ)
 
+    @requires(NicCapability.RSS_HASH_SYMMETRIC_TOEPLITZ)
     @func_test
     def TestSymmetricToeplitzHashAlgorithm(self) -> None:
         """Symmetric toeplitz hashing algorithm test.
@@ -104,7 +107,7 @@ def TestSymmetricToeplitzHashAlgorithm(self) -> None:
         """
         self.VerifyHashFunction(HashAlgorithm.SYMMETRIC_TOEPLITZ)
 
-    @requires(NicCapability.XOR_SUPPORT)
+    @requires(NicCapability.RSS_HASH_XOR)
     @func_test
     def TestSimpleXorHashAlgorithm(self) -> None:
         """Simple xor hashing algorithm test.
-- 
2.43.0

