Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BFFC369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 10:50:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3363402A9;
	Wed, 23 Apr 2025 12:50:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3A8ED4029D
 for <dev@dpdk.org>; Wed, 23 Apr 2025 12:50:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745405414; x=1776941414;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=++WeXJR0SBCRXhwo3kEIEosA3ijuwCQQlDu/VUu9O80=;
 b=gO85G4Pus+bt05GWo57ubjomE4RatoZL4fmXtW+4y4C4qcpfA3E8SF5l
 Q6dygmuvIWhRJePolH5IKc82qsjUE1oYUL9sNkgD1XU7XPcDhtIhEuI7t
 eZB1gIlGff9vLIzmGSBlYs7ve4PUUK+xc8YMStuOVxa1p2hLNi9LJBDM7
 YRwjmhEEwAzIHpfbr+7lTlCtX/By93T3Y6WCF+vsc8qUI7GHxXWGcv8sy
 zJkboCW02Avng3vRYKO/EKz3ANlElgy+vjG6RToLHlFICx+/j4S3Fmdqm
 KOl0QNcuNOw27Khqdc0ynrPpRI7ImjBWvrYXHpWq8vIpJNFSbDsjznoHG Q==;
X-CSE-ConnectionGUID: bFI3COnQRDWdrhhY5fr2wA==
X-CSE-MsgGUID: bN6qYgD0RZG067fyp2ccrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46901217"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="46901217"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 03:50:13 -0700
X-CSE-ConnectionGUID: fAg5i95aSfuPCYsSnysBHw==
X-CSE-MsgGUID: pEbpQ5kzQ4SPTNme4gBbDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="136353213"
Received: from silpixa00400884.ir.intel.com ([10.243.22.90])
 by fmviesa003.fm.intel.com with ESMTP; 23 Apr 2025 03:50:12 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH] crypto/qat: disable ZUC 256 on selected devices
Date: Wed, 23 Apr 2025 11:50:06 +0100
Message-ID: <20250423105007.3285717-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.43.0
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

Disable ZUC 256 cipher on selected devices.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/common/qat/qat_common.h              | 2 ++
 drivers/common/qat/qat_device.c              | 9 +++++++++
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c | 5 ++++-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c | 9 +++++++++
 drivers/crypto/qat/qat_sym_session.c         | 6 ++++++
 5 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/common/qat/qat_common.h b/drivers/common/qat/qat_common.h
index 51d20267bd..8476021e01 100644
--- a/drivers/common/qat/qat_common.h
+++ b/drivers/common/qat/qat_common.h
@@ -26,6 +26,8 @@ struct qat_options {
 	/**< Wireless Slices supported */
 	uint8_t legacy_alg;
 	/**< are legacy algorithm supported */
+	uint8_t zuc_256_disabled;
+	/**< is ZUC 256 algorithm disabled */
 };
 
 enum qat_device_gen {
diff --git a/drivers/common/qat/qat_device.c b/drivers/common/qat/qat_device.c
index b582e3bf8b..35c664e529 100644
--- a/drivers/common/qat/qat_device.c
+++ b/drivers/common/qat/qat_device.c
@@ -169,6 +169,13 @@ wireless_slice_support(uint16_t pci_dev_id)
 			pci_dev_id == 0x4947;
 }
 
+static int
+zuc_256_disabled(uint16_t pci_dev_id)
+{
+	return pci_dev_id == 0x578b ||
+			pci_dev_id == 0x4947;
+}
+
 /* This function base on the atoi function peculiarity, non integral part
  * other than the equals sign is ignored. It will not work with other conversion
  * functions like strt*.
@@ -332,6 +339,8 @@ qat_pci_device_allocate(struct rte_pci_device *pci_dev)
 
 	if (wireless_slice_support(pci_dev->id.device_id))
 		qat_dev->options.has_wireless_slice = 1;
+	if (zuc_256_disabled(pci_dev->id.device_id))
+		qat_dev->options.zuc_256_disabled = 1;
 
 	ops_hw = qat_dev_hw_spec[qat_dev->qat_dev_gen];
 	NOT_NULL(ops_hw->qat_dev_get_misc_bar, goto error,
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
index af664fb9b9..11541ee51d 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
@@ -295,7 +295,10 @@ qat_sym_crypto_cap_get_gen3(struct qat_cryptodev_private *internals,
 			check_cipher_capa(&capabilities[iter],
 				RTE_CRYPTO_CIPHER_ZUC_EEA3))) {
 			cap = addr + curr_capa;
-			cap->sym.cipher.key_size.max = 32;
+			if (internals->qat_dev->options.zuc_256_disabled)
+				cap->sym.cipher.key_size.max = 16;
+			else
+				cap->sym.cipher.key_size.max = 32;
 			cap->sym.cipher.key_size.increment = 16;
 			cap->sym.cipher.iv_size.max = 25;
 			cap->sym.cipher.iv_size.increment = 1;
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
index e1302e9b36..70ede22042 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
@@ -205,6 +205,15 @@ qat_sym_crypto_cap_get_gen5(struct qat_cryptodev_private *internals,
 
 		memcpy(addr + curr_capa, capabilities + iter,
 			sizeof(struct rte_cryptodev_capabilities));
+
+		if (check_cipher_capa(&capabilities[iter],
+				RTE_CRYPTO_CIPHER_ZUC_EEA3)) {
+			struct rte_cryptodev_capabilities *cap =
+				addr + curr_capa;
+			if (internals->qat_dev->options.zuc_256_disabled)
+				cap->sym.cipher.key_size.max = 16;
+		}
+
 		curr_capa++;
 	}
 	internals->qat_dev_capabilities = internals->capa_mz->addr;
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index 7f370f03fb..2481ed7ce5 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -526,6 +526,12 @@ qat_sym_session_configure_cipher(struct rte_cryptodev *dev,
 		session->qat_mode = ICP_QAT_HW_CIPHER_CBC_MODE;
 		break;
 	case RTE_CRYPTO_CIPHER_ZUC_EEA3:
+		if (internals->qat_dev->options.zuc_256_disabled &&
+			cipher_xform->key.length == ICP_QAT_HW_ZUC_256_KEY_SZ) {
+			QAT_LOG(ERR, "ZUC 256 disabled on this device");
+			ret = -ENOTSUP;
+			goto error_out;
+		}
 		if (!qat_is_cipher_alg_supported(
 			cipher_xform->algo, internals)) {
 			QAT_LOG(ERR, "%s not supported on this device",
-- 
2.43.0

