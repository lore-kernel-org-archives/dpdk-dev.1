Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A981CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 10:07:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 496B640E64;
	Wed, 15 Oct 2025 12:07:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A8F1940DFB;
 Wed, 15 Oct 2025 12:07:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760522855; x=1792058855;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Sq9RnvTZw4CUdpApOn5PeKfwde2/NbWd622z6P+FNe4=;
 b=W0Wt12ZPVFPZOIXDLPCyXrNqCamdJbl39CwAmew1k4rWhlArU9vqIHPM
 g0/eN5uz2l167cxmnbD1AJy0MkL41sZd191+oFCIkmht6a00YZP++dmti
 hRrIdG2jyByjmXM3gu+/jd8xl9HlsC5AbChachwyqLu8Fds5eyIPbLnl8
 XFC4Fl+zA/RSom3+ckJxTErJ4+SHOM2qiqHvpuQ0DxJe7iiDYxQCvCNsq
 tngyRNYBOsgF+upTamcx4NAuu2eJmmeVXHUhgucsYy+5sxvVHdAh/XgRQ
 y2TJNMdlNk4MS8xJDBRIeM890TWbpFkFranjyqEJXMOOItbXM7hD7tn69 g==;
X-CSE-ConnectionGUID: 5UX2l1+GTJGqXgXnoF5B6w==
X-CSE-MsgGUID: JiC4wb6fRWaO8WSrNz2ITQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73371798"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="73371798"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 03:07:34 -0700
X-CSE-ConnectionGUID: SeNGyuT7RvW4tyH7fn81dQ==
X-CSE-MsgGUID: 5HYkaA9MQmuXW0LjOlTksw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="181262620"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 15 Oct 2025 03:07:33 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 4/7] net/iavf: fix Rx path selection for scalar flex bulk
 alloc
Date: Wed, 15 Oct 2025 10:07:20 +0000
Message-Id: <20251015100723.1603296-5-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015100723.1603296-1-ciara.loftus@intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
 <20251015100723.1603296-1-ciara.loftus@intel.com>
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
index d3bf062619..e217328823 100644
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

