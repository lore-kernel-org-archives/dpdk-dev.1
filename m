Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E2EC369A8
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 10:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 518C740DD2;
	Fri, 11 Apr 2025 12:14:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4D9A440BA4
 for <dev@dpdk.org>; Fri, 11 Apr 2025 12:14:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744366478; x=1775902478;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iXQSlLIXNIwwmfygIdUvf+q7Vn6CdPw5MORMNvrTG6c=;
 b=MpY8lIxmTAiTkdnHDnoUIiiHsxAQ6eJucSkn05sCrVyZRVPNbGU22Dw8
 ll5jr60WF7rjkJluWu/7cD5Bhw8A1R0VaQ6Gkikyv2tZWxJE9W5AUkC2L
 6vTNP2chv0SlZSHv9vBfiQ2OwKCaCmw4MBdUT8qfuJmkgyM7A7hCpE2+b
 W9hiwWCUDHjU/p7A8p35t7B5Nt6XKoaOWrouEpLG21XNHTgCc82h/O2VB
 41BbnwkVnmRQUGaBRQw90T7jPt6wdcF2XOpnKGYHQoaJTKdxrfUc8l53v
 MM56OCVC53Hzw+SQbx9abMN/9KtCEJXBn+W4G8IFX5o9HqEGrG8mc64Yk Q==;
X-CSE-ConnectionGUID: tU+LdVrDSu+B3FdVhL6j6g==
X-CSE-MsgGUID: XSuwsegNRDaNhyRWK6+XGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56896788"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="56896788"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:14:38 -0700
X-CSE-ConnectionGUID: RjhpOmJwT5SrRblMe/onkA==
X-CSE-MsgGUID: KDSBGACpQvmExNR+79o5VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="160130610"
Received: from silpixa00400884.ir.intel.com ([10.243.22.90])
 by orviesa002.jf.intel.com with ESMTP; 11 Apr 2025 03:14:37 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: Jerin Jacob <jerinj@marvell.com>
Cc: dev@dpdk.org,
	kai.ji@intel.com,
	Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v2 5/5] app/eventdev: update eventdev app for SNOW-V
Date: Fri, 11 Apr 2025 11:09:41 +0100
Message-ID: <20250411101425.3041736-6-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411101425.3041736-1-radu.nicolau@intel.com>
References: <20250411101425.3041736-1-radu.nicolau@intel.com>
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

Update eventdev app to handle SNOW-V correctly.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 app/test-eventdev/evt_options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/app/test-eventdev/evt_options.c b/app/test-eventdev/evt_options.c
index 323d1e724d..7903b5959c 100644
--- a/app/test-eventdev/evt_options.c
+++ b/app/test-eventdev/evt_options.c
@@ -224,7 +224,8 @@ cipher_alg_is_bit_mode(enum rte_crypto_cipher_algorithm alg)
 {
 	return (alg == RTE_CRYPTO_CIPHER_SNOW3G_UEA2 ||
 		alg == RTE_CRYPTO_CIPHER_ZUC_EEA3 ||
-		alg == RTE_CRYPTO_CIPHER_KASUMI_F8);
+		alg == RTE_CRYPTO_CIPHER_KASUMI_F8 ||
+		alg == RTE_CRYPTO_CIPHER_SNOW_V);
 }
 
 static int
-- 
2.43.0

