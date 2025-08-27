Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DEAC8303F
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 09:24:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B99440298;
	Wed, 27 Aug 2025 11:24:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5B7BB4028E
 for <dev@dpdk.org>; Wed, 27 Aug 2025 11:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756286645; x=1787822645;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=U3IGvMrPHQG2jOSMmlqTx7rD+HKcl+zd16jXaZRiFT0=;
 b=lgOakJLS+mLsXDtvw5Fix+/gPLIpk1/35tpkIiL4K4v/lOmnLcWP7N81
 UKQurdWqeYoaa6HLTqS4v4qIMs715S564GxveWI2IvQHkE2qs+UC6VMFD
 M/2dOW7V/lla2EKYCHmVLsnJC8wI0PQ9izuJ0hcxVxh3Fe3heZWCIl2bc
 M/W7EWNuuuFKA5ZD/nbVxDjOMW4IwtM1BRhKPx33/fn0BuNEsy8FXr7Pk
 zCezAndQgbprRYIzLzqERCAFCB8D8u4w6k0/kSrif3RT6Ss8oPEJX2Hja
 TwrKka8PLkC/oZK7VAO6gapDEPNdKhzRH9iWw+AmUCkNrtUcSrvRrzahq g==;
X-CSE-ConnectionGUID: x5lWQkCSSB2dqYZnbpZi2Q==
X-CSE-MsgGUID: WdgKyTgnR26P4kMooTyHZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58468876"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="58468876"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 02:24:04 -0700
X-CSE-ConnectionGUID: KhSmPTDrQjeiFuHHiehEag==
X-CSE-MsgGUID: 8yjHNZAzTbuXN6d+JenBTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169400201"
Received: from silpixa00401749.ir.intel.com (HELO
 silpixa00401749.ger.corp.intel.com) ([10.237.222.190])
 by orviesa009.jf.intel.com with ESMTP; 27 Aug 2025 02:24:02 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>,
	Kai Ji <kai.ji@intel.com>
Subject: [PATCH 1/3] crypto/qat: Add ECDH, ECDSA and ECPM capabilities
Date: Wed, 27 Aug 2025 09:23:56 +0000
Message-ID: <20250827092358.765222-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.50.1
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

Add missing eliptic curves capabilities.
Small fixes on ECDH implementation.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/qat/dev/qat_asym_pmd_gen1.c | 13 +++++++++++++
 drivers/crypto/qat/qat_asym.c              |  9 +++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c b/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
index 67b1892c32..20001bd1cc 100644
--- a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
+++ b/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
@@ -38,6 +38,19 @@ static struct rte_cryptodev_capabilities qat_asym_crypto_caps_gen1[] = {
 			(1 << RTE_CRYPTO_ASYM_OP_ENCRYPT) |
 			(1 << RTE_CRYPTO_ASYM_OP_DECRYPT)),
 			64, 512, 64),
+	QAT_ASYM_CAP(ECDH,
+			((1 << RTE_CRYPTO_ASYM_KE_PUB_KEY_GENERATE) |
+			(1 << RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE) |
+			(1 << RTE_CRYPTO_ASYM_KE_PUB_KEY_VERIFY)),
+			64, 512, 64),
+	QAT_ASYM_CAP(ECDSA,
+			((1 << RTE_CRYPTO_ASYM_OP_SIGN) |
+			(1 << RTE_CRYPTO_ASYM_OP_VERIFY)),
+			64, 512, 64),
+	QAT_ASYM_CAP(ECPM,
+			((1 << RTE_CRYPTO_ASYM_OP_SIGN) |
+			(1 << RTE_CRYPTO_ASYM_OP_VERIFY)),
+			64, 512, 64),
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
 
diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c
index d8a1406819..bd22fc0a6f 100644
--- a/drivers/crypto/qat/qat_asym.c
+++ b/drivers/crypto/qat/qat_asym.c
@@ -801,11 +801,14 @@ ecdh_set_input(struct icp_qat_fw_pke_request *qat_req,
 		SET_PKE_LN(asym_op->ecdh.priv_key, qat_func_alignsize, 0);
 		SET_PKE_LN_EC(curve[curve_id], x, 1);
 		SET_PKE_LN_EC(curve[curve_id], y, 2);
-	} else {
+	} else if (asym_op->ecdh.ke_type == RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE) {
 		SET_PKE_LN(asym_op->ecdh.priv_key, qat_func_alignsize, 0);
 		SET_PKE_LN(asym_op->ecdh.pub_key.x, qat_func_alignsize, 1);
 		SET_PKE_LN(asym_op->ecdh.pub_key.y, qat_func_alignsize, 2);
+	} else {
+		return -EINVAL;
 	}
+
 	SET_PKE_LN_EC(curve[curve_id], a, 3);
 	SET_PKE_LN_EC(curve[curve_id], b, 4);
 	SET_PKE_LN_EC(curve[curve_id], p, 5);
@@ -894,11 +897,13 @@ ecdh_collect(struct rte_crypto_asym_op *asym_op,
 		asym_op->ecdh.pub_key.y.length = alg_bytesize;
 		x = asym_op->ecdh.pub_key.x.data;
 		y = asym_op->ecdh.pub_key.y.data;
-	} else {
+	} else if (asym_op->ecdh.ke_type == RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE) {
 		asym_op->ecdh.shared_secret.x.length = alg_bytesize;
 		asym_op->ecdh.shared_secret.y.length = alg_bytesize;
 		x = asym_op->ecdh.shared_secret.x.data;
 		y = asym_op->ecdh.shared_secret.y.data;
+	} else {
+		return -EINVAL;
 	}
 
 	rte_memcpy(x, &cookie->output_array[0][ltrim], alg_bytesize);
-- 
2.50.1

