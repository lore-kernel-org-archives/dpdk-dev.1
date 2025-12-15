Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F42D5B16E
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 14:08:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F8594064C;
	Mon, 15 Dec 2025 15:07:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id F423D402DB;
 Mon, 15 Dec 2025 15:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765807673; x=1797343673;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1gXHb/eGK0mj4QWTRyvD7ypX1V6qCQHK5GfmaWdr3R0=;
 b=i1//yEddQiUNYx8Jehcosv2qQ/JLPxs4IpSDmmD3t8HFdjgbION1QKaa
 kwysQ0ixausDWgBAwy1wgkEn4QfwDhQD3LpO8xKT/peB6WHV3cHSmnXVu
 AjlhoETkh2Q18C5dI1z4ZRdlznxsr2HKgrUx+ZxjIGqvE4FXMTLkBNfGf
 7855lOuBjf2eyuQlkYRuy0qBKtzh6Ok633s3350XG7CjZ7eJ9CBYVd+88
 BY5I/GwGT7cM60xowdGWVpSN9rwUKm5X+mb0Z6hlfaKqgYH4s9GyK2/1U
 5vN9jV7+QsFoVPlO5+jgs7a/OI7v5GmaVjdPq9JO3vzVLlLE5bNEWIbap g==;
X-CSE-ConnectionGUID: mX0JhkSkTsCtMfRXHV3Cew==
X-CSE-MsgGUID: qP+KX1ksT02j2inMI8OoIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79078693"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="79078693"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 06:07:52 -0800
X-CSE-ConnectionGUID: mdSApk0/SJSNRiSs16oi0Q==
X-CSE-MsgGUID: pvwRaXObQ1Wk562z42n8lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="196996410"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 15 Dec 2025 06:07:51 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 6/8] net/iavf: ensure all Rx paths are selectable
Date: Mon, 15 Dec 2025 14:05:51 +0000
Message-ID: <20251215140553.2283531-7-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215140553.2283531-1-ciara.loftus@intel.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
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

Depending on the underlying architecture and CPU flags available, a
different set of Rx paths are defined. The Rx path selection function
iterates sequentially from zero to num_paths where num_paths is the size
of the array as determined by the RTE_DIM macro. However, depending on
the platform, some of these entries may be empty, and valid entries at
the end of the array may never be considered in the selection function.
Fix this by editing the iavf_rx_func_type enum and only defining a value
for the Rx path if it is implemented in the iavf_rx_path_infos array.

Fixes: 91e3205d72d8 ("net/iavf: use common Rx path selection infrastructure")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 35d3bd5671..53c036c0e8 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -328,7 +328,10 @@ enum iavf_rx_func_type {
 	IAVF_RX_SCATTERED_FLEX_RXD,
 	IAVF_RX_BULK_ALLOC,
 	IAVF_RX_BULK_ALLOC_FLEX_RXD,
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 	IAVF_RX_SSE,
+#endif
+#ifdef RTE_ARCH_X86
 	IAVF_RX_SSE_SCATTERED,
 	IAVF_RX_SSE_FLEX_RXD,
 	IAVF_RX_SSE_SCATTERED_FLEX_RXD,
@@ -340,6 +343,7 @@ enum iavf_rx_func_type {
 	IAVF_RX_AVX2_SCATTERED_FLEX_RXD,
 	IAVF_RX_AVX2_FLEX_RXD_OFFLOAD,
 	IAVF_RX_AVX2_SCATTERED_FLEX_RXD_OFFLOAD,
+#ifdef CC_AVX512_SUPPORT
 	IAVF_RX_AVX512,
 	IAVF_RX_AVX512_SCATTERED,
 	IAVF_RX_AVX512_OFFLOAD,
@@ -348,6 +352,8 @@ enum iavf_rx_func_type {
 	IAVF_RX_AVX512_SCATTERED_FLEX_RXD,
 	IAVF_RX_AVX512_FLEX_RXD_OFFLOAD,
 	IAVF_RX_AVX512_SCATTERED_FLEX_RXD_OFFLOAD,
+#endif /* CC_AVX512_SUPPORT */
+#endif /* RTE_ARCH_X86 */
 };
 
 enum iavf_tx_func_type {
-- 
2.43.0

