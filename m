Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5877EC87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:41:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFD0E406BA;
	Thu,  7 Aug 2025 14:40:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C1CB840695
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:40:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570407; x=1786106407;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LdT6pniTzq9SFZ9xp6hRp3twT4611aH6L97d/jXiHG4=;
 b=aSZj4HMowi8ZMdcPDvO05nvkQPl00FAVJGiCmSfEzUTpXOzAXa7Libtl
 fLC3PbAj+u98lKYJ3fPZdYwrrbveh0GZFxyxN+nPDcAC0QkeBtxesPESE
 b5ZlldGDZrI3ScG5SJWJEHh9usF0WQ3GUY+MfumqTlPKP9WPny0q0OGsB
 R//IMPkPMNZMhvtOtUbUyDxKJXtl9x5khPt6dXpVu3wMcjhBA8nLtSkZ8
 wte5sEvImbsHMOaiceGPrWVKNq5RXbwiZHAQWNGE7jluGu+vpj2tFv5CH
 pZMUSq6VQarHnkPJ3ZMhH8Ixjay0UnJYViAD25Euj1oEUwXuZQghCSSSP w==;
X-CSE-ConnectionGUID: nejt8z5JT5aemN6mYGkjLQ==
X-CSE-MsgGUID: VwLOSp+pRk2hPsn1sKpkcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56981132"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56981132"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:40:06 -0700
X-CSE-ConnectionGUID: HSY4hV5iQOuTZlAlllHX7g==
X-CSE-MsgGUID: jMI/VfBDRAOD/K1TcSHbrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195886766"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 05:40:05 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 11/15] net/iavf: reorder enum of Rx function types
Date: Thu,  7 Aug 2025 12:39:45 +0000
Message-Id: <20250807123949.4063416-12-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123949.4063416-1-ciara.loftus@intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
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

Order the elements in the enum of Rx function types starting from
smallest SIMD width to largest, similar to the order in the i40e and
ice drivers.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 69f9abbef3..435902fbc2 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -323,29 +323,29 @@ struct iavf_security_ctx;
 enum iavf_rx_func_type {
 	IAVF_RX_DISABLED,
 	IAVF_RX_DEFAULT,
-	IAVF_RX_FLEX_RXD,
-	IAVF_RX_BULK_ALLOC,
 	IAVF_RX_SCATTERED,
+	IAVF_RX_FLEX_RXD,
 	IAVF_RX_SCATTERED_FLEX_RXD,
+	IAVF_RX_BULK_ALLOC,
 	IAVF_RX_SSE,
-	IAVF_RX_AVX2,
-	IAVF_RX_AVX2_OFFLOAD,
-	IAVF_RX_SSE_FLEX_RXD,
-	IAVF_RX_AVX2_FLEX_RXD,
-	IAVF_RX_AVX2_FLEX_RXD_OFFLOAD,
 	IAVF_RX_SSE_SCATTERED,
+	IAVF_RX_SSE_FLEX_RXD,
+	IAVF_RX_SSE_SCATTERED_FLEX_RXD,
+	IAVF_RX_AVX2,
 	IAVF_RX_AVX2_SCATTERED,
+	IAVF_RX_AVX2_OFFLOAD,
 	IAVF_RX_AVX2_SCATTERED_OFFLOAD,
-	IAVF_RX_SSE_SCATTERED_FLEX_RXD,
+	IAVF_RX_AVX2_FLEX_RXD,
 	IAVF_RX_AVX2_SCATTERED_FLEX_RXD,
+	IAVF_RX_AVX2_FLEX_RXD_OFFLOAD,
 	IAVF_RX_AVX2_SCATTERED_FLEX_RXD_OFFLOAD,
 	IAVF_RX_AVX512,
-	IAVF_RX_AVX512_OFFLOAD,
-	IAVF_RX_AVX512_FLEX_RXD,
-	IAVF_RX_AVX512_FLEX_RXD_OFFLOAD,
 	IAVF_RX_AVX512_SCATTERED,
+	IAVF_RX_AVX512_OFFLOAD,
 	IAVF_RX_AVX512_SCATTERED_OFFLOAD,
+	IAVF_RX_AVX512_FLEX_RXD,
 	IAVF_RX_AVX512_SCATTERED_FLEX_RXD,
+	IAVF_RX_AVX512_FLEX_RXD_OFFLOAD,
 	IAVF_RX_AVX512_SCATTERED_FLEX_RXD_OFFLOAD,
 };
 
-- 
2.34.1

