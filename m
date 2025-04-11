Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB045C369A8
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 10:14:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 324A740DCD;
	Fri, 11 Apr 2025 12:14:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id D0F5C40B9F
 for <dev@dpdk.org>; Fri, 11 Apr 2025 12:14:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744366477; x=1775902477;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CNaThTZlBLQ13zq5IRDowXy8KaUx8JxFRPs63AQobE8=;
 b=QiUuiBZJmJU/G4eeab2P0vSy9aUfRGFMlbTv06SHusPlMxR7/xiz9ELy
 Dviz2Tp0DfPQUBg26WhBXV6LEnVgPaDicFrjYeKAEV2QINTTjSG93gALP
 ldF+Gzfqd38B3IQt1we4+qQxARGdqiOEIHuA7IqbLBvM70Y/ALefKpiA3
 4qKUKHLKwGHiJqJthipydVZZvmE31xgI41zK9lkDgDiD5x3BhQMcTtIvA
 C7FgQRchygLD8KFTaO/vIr6sNZYVBa26n8CZQXumoKTASx2xfG/A+sQph
 tHmqyi7HD4TDNj9pHuZ/H464Yv31NxogU2weXlxzwhxNJfUpARFawg4+w A==;
X-CSE-ConnectionGUID: NzELT9YhS5u5mQu5LgSdQA==
X-CSE-MsgGUID: 4NlT09SpSXa8RZwBpT4Ang==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56896786"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="56896786"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:14:36 -0700
X-CSE-ConnectionGUID: /HXOm87IRpiz1Z7YjihGSA==
X-CSE-MsgGUID: +TXGZx0iTZa27jqIh8Uwfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="160130603"
Received: from silpixa00400884.ir.intel.com ([10.243.22.90])
 by orviesa002.jf.intel.com with ESMTP; 11 Apr 2025 03:14:36 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v2 4/5] app/crypto-perf: add support for SNOW-V
Date: Fri, 11 Apr 2025 11:09:40 +0100
Message-ID: <20250411101425.3041736-5-radu.nicolau@intel.com>
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

Add support for SNOW-V and SNOW-V AEAD algorithms.

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

