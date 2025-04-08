Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6879C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 11:20:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9548C410DF;
	Tue,  8 Apr 2025 13:20:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id CC3284027F
 for <dev@dpdk.org>; Tue,  8 Apr 2025 13:20:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744111204; x=1775647204;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3XVLW7niPt/1RugrYagOKgpq6b2SD9B0ys7Kyw7skQ4=;
 b=hfLUtcAjvaiGSk2kqCWg3RMPmKhG+Nb2qxg17JOM/5tlfgADKr600nN6
 0yX1W5CLcMRKO2lAYFTpJJi+8AijkonV3eOESCOcypIVRZUh0j5g0/Ukn
 wx0JjKTyrvzg3764z8oZL/unq2ODNBxq0FygRSY/k04cvKusCBgg8fTNI
 r3uWl0PgQOBoHeXHO9dueBxhiygRgE7jKj40ThygBEumjuD6pc5NI8SDe
 3k2rJNfkQ1UILBWqZzwwPGSpts+v3l366dG7HKTIfQrz7lERRlIccBZ4N
 tcaZKzNdcEr6Cg/An+fesUY6s+zCzZlQ+3tYfy7ogYRmuI+gx3rNNVNvN w==;
X-CSE-ConnectionGUID: Eczuar04R927sLtHb4yfrA==
X-CSE-MsgGUID: CzEuPaFwS4iNSBtDWocrMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="62939027"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="62939027"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 04:20:03 -0700
X-CSE-ConnectionGUID: FmljHEPzQsyQMcwKNBFrew==
X-CSE-MsgGUID: Y0WQANpmR5WzUXaBQGGA+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="128219470"
Received: from silpixa00400884.ir.intel.com ([10.243.22.90])
 by orviesa006.jf.intel.com with ESMTP; 08 Apr 2025 04:20:02 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH 4/5] app/crypto-perf: add support for SNOW-V
Date: Tue,  8 Apr 2025 12:19:49 +0100
Message-ID: <20250408111952.2953492-4-radu.nicolau@intel.com>
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

Add suport for SNOW-V and SNOW-V AEAD algorithms.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 app/test-crypto-perf/cperf_ops.c | 6 ++++--
 doc/guides/tools/cryptoperf.rst  | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/app/test-crypto-perf/cperf_ops.c b/app/test-crypto-perf/cperf_ops.c
index 37d06f1dea..f8c5bd6a4e 100644
--- a/app/test-crypto-perf/cperf_ops.c
+++ b/app/test-crypto-perf/cperf_ops.c
@@ -474,7 +474,8 @@ cperf_set_ops_cipher(struct rte_crypto_op **ops,
 
 		if (options->cipher_algo == RTE_CRYPTO_CIPHER_SNOW3G_UEA2 ||
 				options->cipher_algo == RTE_CRYPTO_CIPHER_KASUMI_F8 ||
-				options->cipher_algo == RTE_CRYPTO_CIPHER_ZUC_EEA3)
+				options->cipher_algo == RTE_CRYPTO_CIPHER_ZUC_EEA3 ||
+				options->cipher_algo == RTE_CRYPTO_CIPHER_SNOW_V)
 			sym_op->cipher.data.length <<= 3;
 
 		sym_op->cipher.data.offset = 0;
@@ -633,7 +634,8 @@ cperf_set_ops_cipher_auth(struct rte_crypto_op **ops,
 
 		if (options->cipher_algo == RTE_CRYPTO_CIPHER_SNOW3G_UEA2 ||
 				options->cipher_algo == RTE_CRYPTO_CIPHER_KASUMI_F8 ||
-				options->cipher_algo == RTE_CRYPTO_CIPHER_ZUC_EEA3)
+				options->cipher_algo == RTE_CRYPTO_CIPHER_ZUC_EEA3 ||
+				options->cipher_algo == RTE_CRYPTO_CIPHER_SNOW_V)
 			sym_op->cipher.data.length <<= 3;
 
 		sym_op->cipher.data.offset = 0;
diff --git a/doc/guides/tools/cryptoperf.rst b/doc/guides/tools/cryptoperf.rst
index 017e8ef934..72774e04cd 100644
--- a/doc/guides/tools/cryptoperf.rst
+++ b/doc/guides/tools/cryptoperf.rst
@@ -223,6 +223,7 @@ The following are the application command-line options:
            kasumi-f8
            snow3g-uea2
            zuc-eea3
+           snow-v
 
 * ``--cipher-op <mode>``
 
@@ -287,6 +288,7 @@ The following are the application command-line options:
 
            aes-ccm
            aes-gcm
+           snow-v-aead
 
 * ``--aead-op <mode>``
 
-- 
2.43.0

