Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5D9CCF2C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 13:12:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 992C240291;
	Fri, 16 Oct 2026 15:11:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 77071400D7
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792156317; x=1823692317;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FvljCw5RZc8CXkyZOAmUAtHJZiB1xVmfZZjcnuT3ZKQ=;
 b=TDaqGRwldohLJWo8ACBJBqe+zW8rGEwOC1Il+wiPX+YF9ryJNpa8okri
 GWIKGhp0mvTOdrUBb+DG5weY8Al1gb9vc1tvopjmI9AXI5sjDr9RH/z3Z
 lZcObNMSNm2jX6LIda87qDZo5z1YzHduvtd6ERScGBtI5eJZy36YP2R61
 bpRZJhqhtLeGAsG1ibmenQr3Y1aff090y6Urz/i1hFkcFX6XvUYcQJm5W
 xVP3zuGiioBIHmEcKiK1A0Dw8Rs7nPuTSM3G0Ib9D7pzIrVRyd5cHNJ7L
 vb3Jd8YMx5z/cXpGn9qax10xd/SDhFNVZYzrucBlkVSBoCpmgUp6eLzY+ g==;
X-CSE-ConnectionGUID: f9j3upu+Tiu6V+4TXkvxQQ==
X-CSE-MsgGUID: 1BpK5+cSQ3evgQ5xJkaSmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="841356"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="841356"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 06:11:56 -0700
X-CSE-ConnectionGUID: Fny20+LzRoC1fmrreDtsJg==
X-CSE-MsgGUID: C6pSqY35RPOCqNMG5wrP3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2296611"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa007.fm.intel.com with ESMTP; 16 Oct 2026 06:11:55 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] crypto/qat: add Gen 6 support
Date: Fri, 16 Oct 2026 13:11:52 +0000
Message-ID: <20261016131152.2298192-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
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

Add support for Gen 6 QAT devices

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 doc/guides/cryptodevs/qat.rst                |   5 +
 doc/guides/rel_notes/release_26_11.rst       |   4 +
 drivers/common/qat/dev/qat_dev_gen6.c        |  63 ++++
 drivers/common/qat/meson.build               |   2 +
 drivers/common/qat/qat_adf/icp_qat_fw_la.h   |   7 +-
 drivers/common/qat/qat_common.h              |   1 +
 drivers/common/qat/qat_device.c              |   5 +
 drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c | 337 +++++++++++++++++++
 drivers/crypto/qat/qat_sym_session.c         |  53 +--
 drivers/crypto/qat/qat_sym_session.h         |   8 +
 10 files changed, 465 insertions(+), 20 deletions(-)
 create mode 100644 drivers/common/qat/dev/qat_dev_gen6.c
 create mode 100644 drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c

diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst
index 6c96c5f88d..27713913ae 100644
--- a/doc/guides/cryptodevs/qat.rst
+++ b/doc/guides/cryptodevs/qat.rst
@@ -28,6 +28,7 @@ poll mode crypto driver support for the following hardware accelerator devices:
 * ``Intel QuickAssist Technology 4xxx``
 * ``Intel QuickAssist Technology 300xx``
 * ``Intel QuickAssist Technology 420xx``
+* ``Intel QuickAssist Technology 6xxx``
 * ``Intel QuickAssist Technology apfxx``
 
 
@@ -142,6 +143,7 @@ Limitations
   generations in the same process if planning to use for GCM.
 * The mixed algo feature on GEN2 is not supported by all kernel drivers. Check
   the notes under the Available Kernel Drivers table below for specific details.
+* Chained cipher and hash operations are not supported on GEN6 devices.
 * Out-of-place is not supported for combined Crypto-CRC DOCSIS security
   protocol.
 * ``RTE_CRYPTO_CIPHER_DES_DOCSISBPI`` is not supported for combined Crypto-CRC
@@ -182,6 +184,7 @@ poll mode crypto driver support for the following hardware accelerator devices:
 * ``Intel QuickAssist Technology 401xxx``
 * ``Intel QuickAssist Technology 300xx``
 * ``Intel QuickAssist Technology 420xx``
+* ``Intel QuickAssist Technology 6xxx``
 
 The QAT ASYM PMD has support for:
 
@@ -483,6 +486,8 @@ to see the full table)
    +-----+-----+-----+-----+----------+---------------+---------------+------------+--------+------+--------+--------+
    | Yes | Yes | Yes | 5   | 420xx    | linux/6.8+    | qat_420xx     | 420xx      | 4946   | 2    | 4947   | 16     |
    +-----+-----+-----+-----+----------+---------------+---------------+------------+--------+------+--------+--------+
+   | Yes | Yes | No  | 6   | 6xxx     | linux/6.16+   | qat_6xxx      | 6xxx       | 4948   | 1    | 4949   | 16     |
+   +-----+-----+-----+-----+----------+---------------+---------------+------------+--------+------+--------+--------+
 
 * Note: Symmetric mixed crypto algorithms feature on Gen 2 works only with IDZ driver version 4.9.0+
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..fdcf155e07 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Intel QuickAssist Technology (QAT) crypto driver.**
+
+  * Added support for Gen 6 QAT devices.
+
 
 Removed Items
 -------------
diff --git a/drivers/common/qat/dev/qat_dev_gen6.c b/drivers/common/qat/dev/qat_dev_gen6.c
new file mode 100644
index 0000000000..e8b9201c04
--- /dev/null
+++ b/drivers/common/qat/dev/qat_dev_gen6.c
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Intel Corporation
+ */
+
+#include <dev_driver.h>
+#include <rte_pci.h>
+
+#include "qat_device.h"
+#include "qat_qp.h"
+#include "adf_pf2vf_msg.h"
+#include "qat_dev_gens.h"
+
+#include <stdint.h>
+
+static struct qat_pf2vf_dev qat_pf2vf_gen6 = {
+	.pf2vf_offset = ADF_4XXXIOV_PF2VM_OFFSET,
+	.vf2pf_offset = ADF_4XXXIOV_VM2PF_OFFSET,
+	.pf2vf_type_shift = ADF_PFVF_2X_MSGTYPE_SHIFT,
+	.pf2vf_type_mask = ADF_PFVF_2X_MSGTYPE_MASK,
+	.pf2vf_data_shift = ADF_PFVF_2X_MSGDATA_SHIFT,
+	.pf2vf_data_mask = ADF_PFVF_2X_MSGDATA_MASK,
+};
+
+static struct qat_qp_hw_spec_funcs qat_qp_hw_spec_gen6 = {
+	.qat_qp_rings_per_service = qat_qp_rings_per_service_gen4,
+	.qat_qp_build_ring_base = qat_qp_build_ring_base_gen4,
+	.qat_qp_adf_arb_enable = qat_qp_adf_arb_enable_gen4,
+	.qat_qp_adf_arb_disable = qat_qp_adf_arb_disable_gen4,
+	.qat_qp_adf_configure_queues = qat_qp_adf_configure_queues_gen4,
+	.qat_qp_csr_write_tail = qat_qp_csr_write_tail_gen4,
+	.qat_qp_csr_write_head = qat_qp_csr_write_head_gen4,
+	.qat_qp_csr_setup = qat_qp_csr_setup_gen4,
+	.qat_qp_get_hw_data = qat_qp_get_hw_data_gen4,
+};
+
+static int
+qat_dev_get_slice_map_gen6(uint32_t *map,
+	const struct rte_pci_device *pci_dev)
+{
+	if (rte_pci_read_config(pci_dev, map,
+			ADF1_C4XXXIOV_VFLEGFUSES_LEN,
+			ADF_C4XXXIOV_VFLEGFUSES_OFFSET) < 0) {
+		return -1;
+	}
+	return 0;
+}
+
+static struct qat_dev_hw_spec_funcs qat_dev_hw_spec_gen6 = {
+	.qat_dev_reset_ring_pairs = qat_reset_ring_pairs_gen4,
+	.qat_dev_get_transport_bar = qat_dev_get_transport_bar_gen4,
+	.qat_dev_get_misc_bar = qat_dev_get_misc_bar_gen4,
+	.qat_dev_read_config = qat_dev_read_config_gen4,
+	.qat_dev_get_extra_size = qat_dev_get_extra_size_gen4,
+	.qat_dev_get_slice_map = qat_dev_get_slice_map_gen6,
+};
+
+RTE_INIT(qat_dev_gen_6_init)
+{
+	qat_qp_hw_spec[QAT_GEN6] = &qat_qp_hw_spec_gen6;
+	qat_dev_hw_spec[QAT_GEN6] = &qat_dev_hw_spec_gen6;
+	qat_gen_config[QAT_GEN6].dev_gen = QAT_GEN6;
+	qat_gen_config[QAT_GEN6].pf2vf_dev = &qat_pf2vf_gen6;
+}
diff --git a/drivers/common/qat/meson.build b/drivers/common/qat/meson.build
index b946354a42..db792864a2 100644
--- a/drivers/common/qat/meson.build
+++ b/drivers/common/qat/meson.build
@@ -106,6 +106,7 @@ sources += files(
         'dev/qat_dev_gen3.c',
         'dev/qat_dev_gen4.c',
         'dev/qat_dev_gen5.c',
+        'dev/qat_dev_gen6.c',
         'dev/qat_dev_gen_lce.c',
 )
 includes += include_directories(
@@ -138,6 +139,7 @@ if qat_crypto
             'dev/qat_crypto_pmd_gen3.c',
             'dev/qat_crypto_pmd_gen4.c',
             'dev/qat_crypto_pmd_gen5.c',
+            'dev/qat_crypto_pmd_gen6.c',
             'dev/qat_crypto_pmd_gen_lce.c',
         ]
         sources += files(join_paths(qat_crypto_relpath, f))
diff --git a/drivers/common/qat/qat_adf/icp_qat_fw_la.h b/drivers/common/qat/qat_adf/icp_qat_fw_la.h
index 735dfb5103..366e1f2252 100644
--- a/drivers/common/qat/qat_adf/icp_qat_fw_la.h
+++ b/drivers/common/qat/qat_adf/icp_qat_fw_la.h
@@ -473,7 +473,12 @@ struct icp_qat_fw_la_cipher_20_req_params {
 	uint32_t   spc_aad_sz;
 	uint64_t   spc_aad_addr;
 	uint64_t   spc_auth_res_addr;
-	uint8_t    reserved[3];
+	union {
+		uint8_t    reserved[3];
+		struct {
+			uint8_t hmac_sz;
+		};
+	};
 	uint8_t    spc_auth_res_sz;
 };
 
diff --git a/drivers/common/qat/qat_common.h b/drivers/common/qat/qat_common.h
index 51d20267bd..133a81c856 100644
--- a/drivers/common/qat/qat_common.h
+++ b/drivers/common/qat/qat_common.h
@@ -34,6 +34,7 @@ enum qat_device_gen {
 	QAT_GEN3,
 	QAT_GEN4,
 	QAT_GEN5,
+	QAT_GEN6,
 	QAT_GEN_LCE,
 	QAT_VQAT,
 	QAT_N_GENS
diff --git a/drivers/common/qat/qat_device.c b/drivers/common/qat/qat_device.c
index 07a8b19583..f0ed115b30 100644
--- a/drivers/common/qat/qat_device.c
+++ b/drivers/common/qat/qat_device.c
@@ -70,6 +70,9 @@ static const struct rte_pci_id pci_id_qat_map[] = {
 		{
 			RTE_PCI_DEVICE(0x8086, 0x4947),
 		},
+		{
+			RTE_PCI_DEVICE(0x8086, 0x4949),
+		},
 		{
 			RTE_PCI_DEVICE(0x8086, 0x1454),
 		},
@@ -152,6 +155,8 @@ pick_gen(const struct rte_pci_device *pci_dev)
 		return QAT_GEN4;
 	case 0x4947:
 		return QAT_GEN5;
+	case 0x4949:
+		return QAT_GEN6;
 	case 0x1454:
 		return QAT_GEN_LCE;
 	case 0x0da5:
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c
new file mode 100644
index 0000000000..a8da8cba29
--- /dev/null
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c
@@ -0,0 +1,337 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Intel Corporation
+ */
+
+#include <rte_cryptodev.h>
+#include <cryptodev_pmd.h>
+#include "qat_sym_session.h"
+#include "qat_sym.h"
+#include "qat_asym.h"
+#include "qat_crypto.h"
+#include "qat_crypto_pmd_gens.h"
+
+
+static struct rte_cryptodev_capabilities qat_sym_crypto_legacy_caps_gen6[] = {
+	QAT_SYM_PLAIN_AUTH_CAP(SHA1,
+		CAP_SET(block_size, 64),
+		CAP_RNG(digest_size, 1, 20, 1)),
+	QAT_SYM_AUTH_CAP(SHA224,
+		CAP_SET(block_size, 64),
+		CAP_RNG_ZERO(key_size), CAP_RNG(digest_size, 1, 28, 1),
+		CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+};
+
+static struct rte_cryptodev_capabilities qat_sym_crypto_caps_gen6[] = {
+	QAT_SYM_AUTH_CAP(SHA256_HMAC,
+		CAP_SET(block_size, 64),
+		CAP_RNG(key_size, 1, 64, 1), CAP_RNG(digest_size, 1, 32, 1),
+		CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+	QAT_SYM_AUTH_CAP(SHA384_HMAC,
+		CAP_SET(block_size, 128),
+		CAP_RNG(key_size, 1, 128, 1), CAP_RNG(digest_size, 1, 48, 1),
+		CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+	QAT_SYM_AUTH_CAP(SHA512_HMAC,
+		CAP_SET(block_size, 128),
+		CAP_RNG(key_size, 1, 128, 1), CAP_RNG(digest_size, 1, 64, 1),
+		CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+	QAT_SYM_AUTH_CAP(NULL,
+		CAP_SET(block_size, 1),
+		CAP_RNG_ZERO(key_size), CAP_RNG_ZERO(digest_size),
+		CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+	QAT_SYM_CIPHER_CAP(NULL,
+		CAP_SET(block_size, 1),
+		CAP_RNG_ZERO(key_size), CAP_RNG_ZERO(iv_size)),
+	QAT_SYM_AUTH_CAP(SHA256,
+		CAP_SET(block_size, 64),
+		CAP_RNG_ZERO(key_size), CAP_RNG(digest_size, 1, 32, 1),
+		CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+	QAT_SYM_AUTH_CAP(SHA384,
+		CAP_SET(block_size, 128),
+		CAP_RNG_ZERO(key_size), CAP_RNG(digest_size, 1, 48, 1),
+		CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+	QAT_SYM_AUTH_CAP(SHA512,
+		CAP_SET(block_size, 128),
+		CAP_RNG_ZERO(key_size), CAP_RNG(digest_size, 1, 64, 1),
+		CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+	QAT_SYM_CIPHER_CAP(AES_CTR,
+		CAP_SET(block_size, 16),
+		CAP_RNG(key_size, 16, 32, 16), CAP_RNG(iv_size, 16, 16, 0)),
+	QAT_SYM_AEAD_CAP(AES_GCM,
+		CAP_SET(block_size, 16),
+		CAP_RNG(key_size, 16, 32, 16), CAP_RNG(digest_size, 8, 16, 4),
+		CAP_RNG(aad_size, 0, 240, 1), CAP_RNG(iv_size, 12, 12, 12)),
+	QAT_SYM_AEAD_CAP(CHACHA20_POLY1305,
+		CAP_SET(block_size, 64),
+		CAP_RNG(key_size, 32, 32, 0),
+		CAP_RNG(digest_size, 16, 16, 0),
+		CAP_RNG(aad_size, 0, 240, 1), CAP_RNG(iv_size, 12, 12, 0)),
+	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
+};
+
+static int
+qat_sym_crypto_cap_get_gen6(struct qat_cryptodev_private *internals,
+			const char *capa_memz_name,
+			const uint16_t __rte_unused slice_map)
+{
+	uint32_t caps_size = sizeof(qat_sym_crypto_caps_gen6);
+	uint32_t legacy_caps_size = sizeof(qat_sym_crypto_legacy_caps_gen6);
+	uint32_t size = caps_size;
+	uintptr_t cp_addr;
+
+	if (internals->qat_dev->options.legacy_alg)
+		size = size + legacy_caps_size;
+
+	internals->capa_mz = rte_memzone_lookup(capa_memz_name);
+	if (internals->capa_mz == NULL) {
+		internals->capa_mz = rte_memzone_reserve(capa_memz_name,
+				size, rte_socket_id(), 0);
+		if (internals->capa_mz == NULL) {
+			QAT_LOG(DEBUG,
+				"Error allocating memzone for capabilities");
+			return -1;
+		}
+	}
+	cp_addr = (uintptr_t)(internals->capa_mz->addr);
+
+	if (internals->qat_dev->options.legacy_alg) {
+		memcpy((void *)cp_addr, qat_sym_crypto_legacy_caps_gen6, legacy_caps_size);
+		cp_addr += legacy_caps_size;
+	}
+
+	memcpy((void *)cp_addr, qat_sym_crypto_caps_gen6, caps_size);
+	internals->qat_dev_capabilities = internals->capa_mz->addr;
+
+	return 0;
+}
+
+static int get_block_size(enum icp_qat_hw_auth_algo qat_hash_alg)
+{
+	switch (qat_hash_alg) {
+	case ICP_QAT_HW_AUTH_ALGO_SHA1:
+	case ICP_QAT_HW_AUTH_ALGO_SHA224:
+	case ICP_QAT_HW_AUTH_ALGO_SHA256:
+		return QAT_SHA_CBLOCK;
+	case ICP_QAT_HW_AUTH_ALGO_SHA384:
+	case ICP_QAT_HW_AUTH_ALGO_SHA512:
+		return QAT_SHA512_CBLOCK;
+	default:
+		return -EFAULT;
+	};
+	return -EFAULT;
+}
+
+int
+qat_sym_cd_auth_set_gen6(struct qat_sym_session *cdesc,
+		const uint8_t *authkey,
+		uint32_t authkeylen,
+		uint32_t aad_length __rte_unused,
+		uint32_t digestsize,
+		unsigned int operation)
+{
+	struct icp_qat_hw_auth_setup *hash = NULL;
+	struct icp_qat_fw_la_bulk_req *req_tmpl = &cdesc->fw_req;
+	struct icp_qat_fw_comn_req_hdr_cd_pars *cd_pars = &req_tmpl->cd_pars;
+	void *ptr = &req_tmpl->cd_ctrl;
+	struct icp_qat_fw_auth_cd_ctrl_hdr *hash_cd_ctrl = ptr;
+	struct icp_qat_fw_la_auth_req_params *auth_param =
+		(struct icp_qat_fw_la_auth_req_params *)
+		((char *)&req_tmpl->serv_specif_rqpars +
+		ICP_QAT_FW_HASH_REQUEST_PARAMETERS_OFFSET);
+	enum icp_qat_hw_auth_mode auth_mode =
+			(cdesc->auth_mode == ICP_QAT_HW_AUTH_MODE0) ?
+			ICP_QAT_HW_AUTH_MODE0 : ICP_QAT_HW_AUTH_MODE2;
+	uint16_t state1_size = 0, state2_size = 0, cd_extra_size = 0;
+	uint16_t hash_offset;
+
+	if (cdesc->qat_cmd == ICP_QAT_FW_LA_CMD_AUTH) {
+		ICP_QAT_FW_COMN_CURR_ID_SET(hash_cd_ctrl,
+					ICP_QAT_FW_SLICE_AUTH);
+		cdesc->cd_cur_ptr = (uint8_t *)&cdesc->cd;
+	} else if (cdesc->qat_cmd != ICP_QAT_FW_LA_CMD_CIPHER_HASH) {
+		QAT_LOG(ERR, "Invalid param, must be a hash command.");
+		return -EFAULT;
+	}
+
+	if (operation == RTE_CRYPTO_AUTH_OP_VERIFY)
+		cdesc->auth_op = ICP_QAT_HW_AUTH_VERIFY;
+	else
+		cdesc->auth_op = ICP_QAT_HW_AUTH_GENERATE;
+
+	/*
+	 * Setup the inner hash config
+	 */
+	hash_offset = cdesc->cd_cur_ptr-((uint8_t *)&cdesc->cd);
+	hash = (struct icp_qat_hw_auth_setup *)cdesc->cd_cur_ptr;
+	hash->auth_config.reserved = 0;
+	if (cdesc->qat_hash_alg == ICP_QAT_HW_AUTH_ALGO_NULL)
+		hash->auth_config.config =
+			ICP_QAT_HW_AUTH_CONFIG_BUILD(auth_mode,
+				cdesc->qat_hash_alg, 4);
+	else
+		hash->auth_config.config =
+			ICP_QAT_HW_AUTH_CONFIG_BUILD(auth_mode,
+				cdesc->qat_hash_alg, digestsize);
+
+	if (cdesc->auth_mode == ICP_QAT_HW_AUTH_MODE0) {
+		hash->auth_counter.counter = 0;
+	} else {
+		int block_size = get_block_size(cdesc->qat_hash_alg);
+		if (block_size < 0)
+			return block_size;
+		hash->auth_counter.counter = rte_bswap32(block_size);
+	}
+
+	hash_cd_ctrl->hash_cfg_offset = hash_offset >> 3;
+	cdesc->cd_cur_ptr += sizeof(struct icp_qat_hw_auth_setup);
+	switch (cdesc->qat_hash_alg) {
+	case ICP_QAT_HW_AUTH_ALGO_SHA1:
+	case ICP_QAT_HW_AUTH_ALGO_SHA224:
+		break;
+	case ICP_QAT_HW_AUTH_ALGO_SHA256:
+		/* HMAC */
+		if (cdesc->auth_mode != ICP_QAT_HW_AUTH_MODE0) {
+			struct icp_qat_fw_la_cipher_20_req_params *cipher_param_20 =
+				(void *)&req_tmpl->serv_specif_rqpars;
+			rte_memcpy(cdesc->cd_cur_ptr, authkey, authkeylen);
+			state2_size = 0;
+			state1_size = authkeylen;
+			ICP_QAT_FW_HASH_FLAG_MODE2_SET(
+				hash_cd_ctrl->hash_flags, QAT_FW_LA_MODE2);
+			cipher_param_20->spc_aad_addr = cdesc->cd_paddr +
+				(cdesc->cd_cur_ptr - (uint8_t *)&cdesc->cd);
+			cipher_param_20->hmac_sz = ICP_QAT_HW_SHA256_STATE2_SZ * 2;
+		}
+		break;
+	case ICP_QAT_HW_AUTH_ALGO_SHA384:
+		/* HMAC */
+		if (cdesc->auth_mode != ICP_QAT_HW_AUTH_MODE0) {
+			struct icp_qat_fw_la_cipher_20_req_params *cipher_param_20 =
+				(void *)&req_tmpl->serv_specif_rqpars;
+			rte_memcpy(cdesc->cd_cur_ptr, authkey, authkeylen);
+			state2_size = 0;
+			state1_size = authkeylen;
+			ICP_QAT_FW_HASH_FLAG_MODE2_SET(
+				hash_cd_ctrl->hash_flags, QAT_FW_LA_MODE2);
+			cipher_param_20->spc_aad_addr = cdesc->cd_paddr +
+				(cdesc->cd_cur_ptr - (uint8_t *)&cdesc->cd);
+			cipher_param_20->hmac_sz = ICP_QAT_HW_SHA384_STATE2_SZ * 2;
+		}
+		break;
+	case ICP_QAT_HW_AUTH_ALGO_SHA512:
+		/* HMAC */
+		if (cdesc->auth_mode != ICP_QAT_HW_AUTH_MODE0) {
+			struct icp_qat_fw_la_cipher_20_req_params *cipher_param_20 =
+				(void *)&req_tmpl->serv_specif_rqpars;
+			rte_memcpy(cdesc->cd_cur_ptr, authkey, authkeylen);
+			state2_size = 0;
+			state1_size = authkeylen;
+			ICP_QAT_FW_HASH_FLAG_MODE2_SET(
+				hash_cd_ctrl->hash_flags, QAT_FW_LA_MODE2);
+			cipher_param_20->spc_aad_addr = cdesc->cd_paddr +
+				(cdesc->cd_cur_ptr - (uint8_t *)&cdesc->cd);
+			cipher_param_20->hmac_sz = ICP_QAT_HW_SHA512_STATE2_SZ * 2;
+		}
+		break;
+	case ICP_QAT_HW_AUTH_ALGO_NULL:
+		break;
+	default:
+		QAT_LOG(ERR, "Invalid HASH alg %u", cdesc->qat_hash_alg);
+		return -EFAULT;
+	}
+
+	/* Auth CD config setup */
+	hash_cd_ctrl->hash_flags |= ICP_QAT_FW_AUTH_HDR_FLAG_NO_NESTED;
+	hash_cd_ctrl->inner_state1_sz = state1_size;
+	if (cdesc->qat_hash_alg == ICP_QAT_HW_AUTH_ALGO_NULL) {
+		hash_cd_ctrl->inner_res_sz = 4;
+		hash_cd_ctrl->final_sz = 4;
+		auth_param->auth_res_sz = 4;
+	} else {
+		hash_cd_ctrl->inner_res_sz = digestsize;
+		hash_cd_ctrl->final_sz = digestsize;
+		auth_param->auth_res_sz = digestsize;
+	}
+
+	hash_cd_ctrl->inner_state2_sz  = state2_size;
+	hash_cd_ctrl->inner_state2_offset = hash_cd_ctrl->hash_cfg_offset +
+			((sizeof(struct icp_qat_hw_auth_setup) +
+			 RTE_ALIGN_CEIL(hash_cd_ctrl->inner_state1_sz, 8))
+					>> 3);
+	cdesc->cd_cur_ptr += state1_size + state2_size + cd_extra_size;
+	cd_pars->u.s.content_desc_addr = cdesc->cd_paddr;
+	cd_pars->u.s.content_desc_params_sz = 1;
+	return 0;
+}
+
+static int
+qat_sym_crypto_set_session_gen6(void *cdev, void *session)
+{
+	struct qat_sym_session *ctx = session;
+	enum rte_proc_type_t proc_type = rte_eal_process_type();
+	int ret;
+
+	if (proc_type == RTE_PROC_AUTO || proc_type == RTE_PROC_INVALID)
+		return -EINVAL;
+
+	ret = qat_sym_crypto_set_session_gen4(cdev, session);
+
+	if (ret == -ENOTSUP) {
+		/* GEN4 returning -ENOTSUP as it cannot handle some mixed algo,
+		 * this is addressed by GEN5
+		 */
+		if ((ctx->aes_cmac ||
+				ctx->qat_hash_alg == ICP_QAT_HW_AUTH_ALGO_NULL) &&
+				(ctx->qat_cipher_alg ==
+				ICP_QAT_HW_CIPHER_ALGO_SNOW_3G_UEA2 ||
+				ctx->qat_cipher_alg ==
+				ICP_QAT_HW_CIPHER_ALGO_ZUC_3G_128_EEA3)) {
+			qat_sym_session_set_ext_hash_flags_gen2(ctx, 0);
+		}
+
+		ret = 0;
+	}
+
+	/* Gen 6 does not support chaining of symmetric crypto ops. */
+	if (ret == 0 && ctx->build_request[proc_type] ==
+			qat_sym_build_op_chain_gen1) {
+		QAT_LOG(ERR, "Chained cipher and hash ops not supported");
+		return -ENOTSUP;
+	}
+
+	return ret;
+}
+
+static uint64_t
+qat_sym_crypto_feature_flags_get_gen6(struct qat_pci_device *qat_dev)
+{
+	/* Gen 6 does not support chaining of symmetric crypto ops. */
+	return qat_sym_crypto_feature_flags_get_gen1(qat_dev) &
+				~RTE_CRYPTODEV_FF_SYM_OPERATION_CHAINING;
+}
+
+RTE_INIT(qat_sym_crypto_gen6_init)
+{
+	qat_sym_gen_dev_ops[QAT_GEN6].cryptodev_ops = &qat_sym_crypto_ops_gen1;
+	qat_sym_gen_dev_ops[QAT_GEN6].get_capabilities =
+			qat_sym_crypto_cap_get_gen6;
+	qat_sym_gen_dev_ops[QAT_GEN6].set_session =
+			qat_sym_crypto_set_session_gen6;
+	qat_sym_gen_dev_ops[QAT_GEN6].set_raw_dp_ctx =
+			qat_sym_configure_raw_dp_ctx_gen4;
+	qat_sym_gen_dev_ops[QAT_GEN6].get_feature_flags =
+			qat_sym_crypto_feature_flags_get_gen6;
+	qat_sym_gen_dev_ops[QAT_GEN6].create_security_ctx =
+			qat_sym_create_security_gen1;
+}
+
+RTE_INIT(qat_asym_crypto_gen6_init)
+{
+	qat_asym_gen_dev_ops[QAT_GEN6].cryptodev_ops =
+			&qat_asym_crypto_ops_gen1;
+	qat_asym_gen_dev_ops[QAT_GEN6].get_capabilities =
+			qat_asym_crypto_cap_get_gen1;
+	qat_asym_gen_dev_ops[QAT_GEN6].get_feature_flags =
+			qat_asym_crypto_feature_flags_get_gen1;
+	qat_asym_gen_dev_ops[QAT_GEN6].set_session =
+			qat_asym_crypto_set_session_gen1;
+}
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index d89c20cad6..e6d158f777 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -378,6 +378,15 @@ qat_get_cipher_xform(struct rte_crypto_sym_xform *xform)
 	return NULL;
 }
 
+static inline uint8_t qat_check_ucs(enum qat_device_gen qat_dev_gen)
+{
+	return (qat_dev_gen == QAT_GEN4 ||
+			qat_dev_gen == QAT_GEN5 ||
+			qat_dev_gen == QAT_GEN6 ||
+			qat_dev_gen == QAT_VQAT);
+}
+
+
 int
 qat_sym_session_configure_cipher(struct rte_cryptodev *dev,
 		struct rte_crypto_sym_xform *xform,
@@ -416,9 +425,7 @@ qat_sym_session_configure_cipher(struct rte_cryptodev *dev,
 			goto error_out;
 		}
 		session->qat_mode = ICP_QAT_HW_CIPHER_CTR_MODE;
-		if (qat_dev_gen == QAT_GEN4 || qat_dev_gen == QAT_GEN5 ||
-				qat_dev_gen == QAT_VQAT)
-			session->is_ucs = 1;
+		session->is_ucs = qat_check_ucs(qat_dev_gen);
 		break;
 	case RTE_CRYPTO_CIPHER_SNOW3G_UEA2:
 		if (qat_sym_validate_snow3g_key(cipher_xform->key.length,
@@ -968,8 +975,7 @@ qat_sym_session_configure_auth(struct rte_cryptodev *dev,
 			session->auth_iv.length = AES_GCM_J0_LEN;
 		else
 			session->is_iv12B = 1;
-		if (qat_dev_gen == QAT_GEN4 || qat_dev_gen == QAT_GEN5 ||
-				qat_dev_gen == QAT_VQAT) {
+		if (qat_check_ucs(qat_dev_gen)) {
 			session->is_cnt_zero = 1;
 			session->is_ucs = 1;
 		}
@@ -1133,10 +1139,7 @@ qat_sym_session_configure_aead(struct rte_cryptodev *dev,
 		}
 		session->qat_mode = ICP_QAT_HW_CIPHER_CTR_MODE;
 		session->qat_hash_alg = ICP_QAT_HW_AUTH_ALGO_GALOIS_128;
-
-		if (qat_dev_gen == QAT_GEN4 || qat_dev_gen == QAT_GEN5 ||
-				qat_dev_gen == QAT_VQAT)
-			session->is_ucs = 1;
+		session->is_ucs = qat_check_ucs(qat_dev_gen);
 		if (session->cipher_iv.length == 0) {
 			session->cipher_iv.length = AES_GCM_J0_LEN;
 			break;
@@ -1155,16 +1158,12 @@ qat_sym_session_configure_aead(struct rte_cryptodev *dev,
 		}
 		session->qat_mode = ICP_QAT_HW_CIPHER_CTR_MODE;
 		session->qat_hash_alg = ICP_QAT_HW_AUTH_ALGO_AES_CBC_MAC;
-		if (qat_dev_gen == QAT_GEN4 || qat_dev_gen == QAT_GEN5 ||
-				qat_dev_gen == QAT_VQAT)
-			session->is_ucs = 1;
+		session->is_ucs = qat_check_ucs(qat_dev_gen);
 		break;
 	case RTE_CRYPTO_AEAD_CHACHA20_POLY1305:
 		if (aead_xform->key.length != ICP_QAT_HW_CHACHAPOLY_KEY_SZ)
 			return -EINVAL;
-		if (qat_dev_gen == QAT_GEN4 || qat_dev_gen == QAT_GEN5 ||
-				qat_dev_gen == QAT_VQAT)
-			session->is_ucs = 1;
+		session->is_ucs = qat_check_ucs(qat_dev_gen);
 		session->qat_cipher_alg =
 				ICP_QAT_HW_CIPHER_ALGO_CHACHA20_POLY1305;
 		qat_sym_session_handle_single_pass(session,
@@ -2006,7 +2005,7 @@ int qat_sym_cd_cipher_set(struct qat_sym_session *cdesc,
 	return 0;
 }
 
-static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
+static int qat_sym_cd_auth_set_gen1(struct qat_sym_session *cdesc,
 		const uint8_t *authkey,
 		uint32_t authkeylen,
 		uint32_t aad_length,
@@ -2037,7 +2036,7 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 		ICP_QAT_FW_COMN_CURR_ID_SET(hash_cd_ctrl,
 					ICP_QAT_FW_SLICE_AUTH);
 		ICP_QAT_FW_COMN_NEXT_ID_SET(hash_cd_ctrl,
-					ICP_QAT_FW_SLICE_DRAM_WR);
+				ICP_QAT_FW_SLICE_DRAM_WR);
 		cdesc->cd_cur_ptr = (uint8_t *)&cdesc->cd;
 	} else if (cdesc->qat_cmd == ICP_QAT_FW_LA_CMD_HASH_CIPHER) {
 		ICP_QAT_FW_COMN_CURR_ID_SET(hash_cd_ctrl,
@@ -2135,8 +2134,7 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 			qat_hash_get_block_size(cdesc->qat_hash_alg);
 		auth_param->hash_state_sz = (hash_cd_ctrl->outer_prefix_sz +
 			auth_param->u2.inner_prefix_sz) >> 3;
-		if (qat_dev_gen == QAT_GEN4 || qat_dev_gen == QAT_GEN5 ||
-				qat_dev_gen == QAT_VQAT) {
+		if (qat_check_ucs(qat_dev_gen)) {
 			ICP_QAT_FW_HASH_FLAG_MODE2_SET(
 				hash_cd_ctrl->hash_flags,
 				QAT_FW_LA_MODE2);
@@ -2459,6 +2457,22 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 	return 0;
 }
 
+static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
+		const uint8_t *authkey,
+		uint32_t authkeylen,
+		uint32_t aad_length,
+		uint32_t digestsize,
+		unsigned int operation,
+		enum qat_device_gen qat_dev_gen)
+{
+	if (qat_dev_gen == QAT_GEN6)
+		return qat_sym_cd_auth_set_gen6(cdesc, authkey, authkeylen,
+				aad_length, digestsize, operation);
+
+	return qat_sym_cd_auth_set_gen1(cdesc, authkey, authkeylen,
+			aad_length, digestsize, operation, qat_dev_gen);
+}
+
 int qat_sym_validate_aes_key(int key_len, enum icp_qat_hw_cipher_algo *alg)
 {
 	switch (key_len) {
@@ -2653,6 +2667,7 @@ qat_sym_cd_crc_set(struct qat_sym_session *cdesc,
 		break;
 	case QAT_GEN4:
 	case QAT_GEN5:
+	case QAT_GEN6:
 		crc_cfg.mode = ICP_QAT_HW_CIPHER_ECB_MODE;
 		crc_cfg.algo = ICP_QAT_HW_CIPHER_ALGO_NULL;
 		crc_cfg.hash_cmp_val = 0;
diff --git a/drivers/crypto/qat/qat_sym_session.h b/drivers/crypto/qat/qat_sym_session.h
index b18673a1f7..e4fb5cacc6 100644
--- a/drivers/crypto/qat/qat_sym_session.h
+++ b/drivers/crypto/qat/qat_sym_session.h
@@ -204,6 +204,14 @@ qat_sym_sesssion_init_common_hdr(struct qat_sym_session *session,
 					struct icp_qat_fw_comn_req_hdr *header,
 					enum qat_sym_proto_flag proto_flags);
 
+int
+qat_sym_cd_auth_set_gen6(struct qat_sym_session *cdesc,
+		const uint8_t *authkey,
+		uint32_t authkeylen,
+		uint32_t aad_length,
+		uint32_t digestsize,
+		unsigned int operation);
+
 int
 qat_sym_validate_aes_key(int key_len, enum icp_qat_hw_cipher_algo *alg);
 int
-- 
2.52.0

