Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DB9CCD18E
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 08:46:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C12B340676;
	Tue, 14 Oct 2025 10:45:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id ED1E84060B;
 Tue, 14 Oct 2025 10:45:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760431539; x=1791967539;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uMa25gK2hIG8cgBzL3n+AWroPyi92K4ywrUJs5GwJdg=;
 b=W1PwBYYa5hL9l1qc+eR1oBqEVK0rErIJ9QdRJT63zBFYkB0qyjvRgdOL
 lE2s4jz+RQWDBBRBt358+UJMKY0ZJGlTQh4ZltkPn3nHAp8NOrpyWvnYE
 6XNCWXPMzKwfPBkqx29m8bjMc3U1K8uwDRBpzNA2HwBJ1w7V3pVG/vLdC
 FEcI0MIRtgrrVVl7gi/+0wy+u8D79FYLHubWR/XCGvriPmkEEk6AgjpTs
 QvOIvanCfVeUZCxP2kUEcqE+zLPnntgTlQgE8HjAN80MAo6/8Ml8fAi2n
 OXQe19RxDhgfCxqPzD0eyD7IhgzUmmC/hCR9SGK465AOUaTPC+1EDSjNJ g==;
X-CSE-ConnectionGUID: +6pNeiz6RzutCEzlcuSJsQ==
X-CSE-MsgGUID: gqU6cUzrSEy97rp13Wzuaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="61796257"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="61796257"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 01:45:39 -0700
X-CSE-ConnectionGUID: eaQFmWF1QJ6HbvQH5zJt+w==
X-CSE-MsgGUID: MLKzWpMKSx+ZQcz7ugxpMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181630661"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 14 Oct 2025 01:45:38 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 3/6] net/iavf: fix Rx path selection for scalar flex bulk alloc
Date: Tue, 14 Oct 2025 08:45:14 +0000
Message-Id: <20251014084517.1407407-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014084517.1407407-1-ciara.loftus@intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
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

The scalar bulk alloc rx burst function supports both legacy and
flexible rx descriptors. The rx path selection infrastructure introduced
in commit 91e3205d72d8 ("net/iavf: use common Rx path selection
infrastructure") cannot define a path that supports both descriptor
formats. To solve this problem, have two rx path definitions which both
point to the same rx burst function but report different descriptor
formats. This allows the rx path selection function to choose the
correct path.

Fixes: 91e3205d72d8 ("net/iavf: use common Rx path selection infrastructure")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf.h      | 1 +
 drivers/net/intel/iavf/iavf_rxtx.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 435902fbc2..4e76162337 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -327,6 +327,7 @@ enum iavf_rx_func_type {
 	IAVF_RX_FLEX_RXD,
 	IAVF_RX_SCATTERED_FLEX_RXD,
 	IAVF_RX_BULK_ALLOC,
+	IAVF_RX_BULK_ALLOC_FLEX_RXD,
 	IAVF_RX_SSE,
 	IAVF_RX_SSE_SCATTERED,
 	IAVF_RX_SSE_FLEX_RXD,
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 67c73f9ad6..bbf3a1737e 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3734,6 +3734,9 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 				{.scattered = true, .flex_desc = true}}},
 	[IAVF_RX_BULK_ALLOC] = {iavf_recv_pkts_bulk_alloc, "Scalar Bulk Alloc",
 		{IAVF_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, {.bulk_alloc = true}}},
+	[IAVF_RX_BULK_ALLOC_FLEX_RXD] = {iavf_recv_pkts_bulk_alloc, "Scalar Bulk Alloc Flex",
+			{IAVF_RX_SCALAR_FLEX_OFFLOADS, RTE_VECT_SIMD_DISABLED,
+			{.flex_desc = true, .bulk_alloc = true}}},
 #ifdef RTE_ARCH_X86
 	[IAVF_RX_SSE] = {iavf_recv_pkts_vec, "Vector SSE",
 		{IAVF_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_128, {.bulk_alloc = true}}},
-- 
2.34.1

