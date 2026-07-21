Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F4EC44533
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 15:13:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 768A040A6B;
	Tue, 21 Jul 2026 17:13:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id A0DA040294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 17:13:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784646812; x=1816182812;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pBvrvonsy4vZ37/7tOL8KHh/5tmx7yGjvJv3OwWmddc=;
 b=V42LB1EIN2owouBSwf8gRVr1/AqrV69819mHcIyv1Iv3XGnv08ZEucYJ
 Ud8sT4+t7jdd4qySPhs/8wmfScibmXsYizsVJNGs69fO29cuvDAMhoRRe
 kfvigE1kJGb5rl41tt23DdzIrE0gM2G5TinOn/e04SEK9zSA2kqTg+1Ui
 MFLXfay49PAhY8H3C5WJv54OaeKzSQJKMt9lKAFuOKELcRcneB4CbocjS
 Hw/8xCIJTxrztWHTYNW44ss7YLmulumQ83MegK70OilVp4bFbu8Y1SMs4
 CVEh/SoKhLECZSnAUe0KnN7B5fkEaAB+OkLUQ/PdbwZen4BotLK91xCYB Q==;
X-CSE-ConnectionGUID: CancCbknTmG4ymCWn9IoFA==
X-CSE-MsgGUID: 63VHrGynRjGdRV7ZKRz5bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85107717"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="85107717"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 08:13:31 -0700
X-CSE-ConnectionGUID: x1mDWILDTdWDZDqWznst4g==
X-CSE-MsgGUID: iWtmiAAuTrKFh1RLMHNUwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="281070945"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 21 Jul 2026 08:13:30 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 3/6] doc/rel_notes: keep library updates together
Date: Tue, 21 Jul 2026 16:13:22 +0100
Message-ID: <20260721151325.2698283-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721151325.2698283-1-bruce.richardson@intel.com>
References: <20260721151325.2698283-1-bruce.richardson@intel.com>
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

Group all library updates and enhancements together before driver
updates in the release notes.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/rel_notes/release_26_07.rst | 64 +++++++++++++-------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f301a8444c..63693159fd 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -97,6 +97,38 @@ New Features
   This allows the user to inspect objects in the ring without removing them
   (aka MT safe peek).
 
+* **Updated lcore validation in power library.**
+
+  Lcore ID validation was moved into the cpufreq framework before driver dispatch.
+  Power QoS API was updated to accept service lcores.
+
+* **Extended BPF API.**
+
+  * Added an extensible BPF loading API comprising the function
+    ``rte_bpf_load_ex`` and struct ``rte_bpf_prm_ex``.
+    This enables new features such as loading classic BPF (cBPF),
+    loading ELF images directly from memory buffers,
+    and executing multi-argument programs, while avoiding future ABI breakages.
+  * Added support for loading and executing BPF programs with up to 5 arguments.
+    This introduces new API functions ``rte_bpf_exec_ex``,
+    ``rte_bpf_exec_burst_ex``, and ``rte_bpf_get_jit_ex``.
+  * Added API functions ``rte_bpf_eth_rx_install`` and ``rte_bpf_eth_tx_install``
+    for installing already loaded BPF programs as port callbacks
+    (as opposed to loading them directly from ELF files).
+
+* **Added BPF validation debugging API and hardened BPF validator.**
+
+  * Introduced a new API (prefixed with ``rte_bpf_validate_debug_``)
+    to introspect the BPF validator.
+    This provides a mechanism to set breakpoints or catchpoints during validation
+    and inspect the verifier's internal state (such as tracked register bounds).
+    This API is crucial primarily for writing comprehensive tests for the validator,
+    but also serves as a foundation for a future interactive eBPF validation debugger.
+  * Fixed numerous bugs in the BPF validator's abstract interpretation logic,
+    including incorrect bounds tracking for jumps and arithmetic operations,
+    as well as fixing several instances of undefined behavior (UB)
+    when verifying malicious or corrupt programs.
+
 * **Added PTP protocol definitions.**
 
   Added IEEE 1588 Precision Time Protocol header structures, constants,
@@ -224,38 +256,6 @@ New Features
 
   On ARM, both IPsec MB and OpenSSL are required for full functionality.
 
-* **Updated lcore validation in power library.**
-
-  Lcore ID validation was moved into the cpufreq framework before driver dispatch.
-  Power QoS API was updated to accept service lcores.
-
-* **Extended BPF API.**
-
-  * Added an extensible BPF loading API comprising the function
-    ``rte_bpf_load_ex`` and struct ``rte_bpf_prm_ex``.
-    This enables new features such as loading classic BPF (cBPF),
-    loading ELF images directly from memory buffers,
-    and executing multi-argument programs, while avoiding future ABI breakages.
-  * Added support for loading and executing BPF programs with up to 5 arguments.
-    This introduces new API functions ``rte_bpf_exec_ex``,
-    ``rte_bpf_exec_burst_ex``, and ``rte_bpf_get_jit_ex``.
-  * Added API functions ``rte_bpf_eth_rx_install`` and ``rte_bpf_eth_tx_install``
-    for installing already loaded BPF programs as port callbacks
-    (as opposed to loading them directly from ELF files).
-
-* **Added BPF validation debugging API and hardened BPF validator.**
-
-  * Introduced a new API (prefixed with ``rte_bpf_validate_debug_``)
-    to introspect the BPF validator.
-    This provides a mechanism to set breakpoints or catchpoints during validation
-    and inspect the verifier's internal state (such as tracked register bounds).
-    This API is crucial primarily for writing comprehensive tests for the validator,
-    but also serves as a foundation for a future interactive eBPF validation debugger.
-  * Fixed numerous bugs in the BPF validator's abstract interpretation logic,
-    including incorrect bounds tracking for jumps and arithmetic operations,
-    as well as fixing several instances of undefined behavior (UB)
-    when verifying malicious or corrupt programs.
-
 * **Updated testpmd application.**
 
   Added support for setting VLAN priority and CFI/DEI bits
-- 
2.53.0

