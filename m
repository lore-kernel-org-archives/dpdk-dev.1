Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B45C369A1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 11:20:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39BF540EE3;
	Tue,  8 Apr 2025 13:20:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id A01D44027F
 for <dev@dpdk.org>; Tue,  8 Apr 2025 13:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744111200; x=1775647200;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gQloSVK3d8dkfCQCSOht9/AEIjdi8Va7CtVqDMxnWck=;
 b=gpb++iR7d/T1QyvlbIDFCoR7RCsc253cU9u437Vz9u0Tl6c477Oty8x3
 DL44hXocO/pgHyDypWPQkTSYylnqmuNjXJw438d+yJeTQhFIy991AqOOM
 +kHw0abYwC1/HmB7PgWHKutJjCVFB5sNasLNywyw3O+bWlEkBLXD+Hrh9
 dge4SozYW7TMaAANwZ2LaPzmHcFIQsUCL6wcuB9PUAHNOIyaRcp38Jswp
 kelJc7byBsMVLXbUk/UyFTMmLiRUTQRkhn8axmABvGMtAr5v36Z9Ckt6h
 V1JUsKcsM8FLIid18++HX1VLTea3vrLhfiovxmJQbAeFPcrvA1jgHNR2h w==;
X-CSE-ConnectionGUID: CI/RWC5CRiiPLyr48PZvHQ==
X-CSE-MsgGUID: ObnA4OD+TFW9ZBnnhsc93w==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="62939004"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="62939004"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 04:19:59 -0700
X-CSE-ConnectionGUID: Tpq0Ta8WQtOjeoY+synnCw==
X-CSE-MsgGUID: 50DPIsZ6Qxm3SK5ypl0AlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="128219428"
Received: from silpixa00400884.ir.intel.com ([10.243.22.90])
 by orviesa006.jf.intel.com with ESMTP; 08 Apr 2025 04:19:58 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: Akhil Goyal <gakhil@marvell.com>,
	Fan Zhang <fanzhang.oss@gmail.com>
Cc: dev@dpdk.org,
	kai.ji@intel.com,
	Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH 2/5] examples/l2fwd-crypto: add support for SNOW-V
Date: Tue,  8 Apr 2025 12:19:47 +0100
Message-ID: <20250408111952.2953492-2-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408111952.2953492-1-radu.nicolau@intel.com>
References: <20250408111952.2953492-1-radu.nicolau@intel.com>
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

Update l2fwd-crypto to be able to correctly handle SNOW-V

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 examples/l2fwd-crypto/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/examples/l2fwd-crypto/main.c b/examples/l2fwd-crypto/main.c
index a441312f55..f1a6ca8899 100644
--- a/examples/l2fwd-crypto/main.c
+++ b/examples/l2fwd-crypto/main.c
@@ -508,7 +508,8 @@ l2fwd_simple_crypto_enqueue(struct rte_mbuf *m,
 		/* For wireless algorithms, offset/length must be in bits */
 		if (cparams->cipher_algo == RTE_CRYPTO_CIPHER_SNOW3G_UEA2 ||
 				cparams->cipher_algo == RTE_CRYPTO_CIPHER_KASUMI_F8 ||
-				cparams->cipher_algo == RTE_CRYPTO_CIPHER_ZUC_EEA3) {
+				cparams->cipher_algo == RTE_CRYPTO_CIPHER_ZUC_EEA3 ||
+				cparams->cipher_algo == RTE_CRYPTO_CIPHER_SNOW_V) {
 			op->sym->cipher.data.offset = ipdata_offset << 3;
 			op->sym->cipher.data.length = data_len << 3;
 		} else {
-- 
2.43.0

