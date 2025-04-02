Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F35C36018
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 23:26:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DA6340669;
	Thu,  3 Apr 2025 01:25:09 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 1D0614065B
 for <dev@dpdk.org>; Thu,  3 Apr 2025 01:25:08 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-6e1b11859a7so1650446d6.1
 for <dev@dpdk.org>; Wed, 02 Apr 2025 16:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743636307;
 x=1744241107; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aw2XQfGXY2tajUUeRGGA5Q8BLnCp/nr7d59BqLcZ8lw=;
 b=PyPR7hNxMt3hfo2lzsd86fEr74O3W3B0DeV9qXmKjbxtCGbyGKGC8YzlffgUs8jhrg
 9DdgCeIHAn5KdyzfHIFcxGN77RcwJYz8hwMQNsG36N7ZwIJ2/aXGl7oOt05iyJZ50ASw
 XpPWBnaw8aIbQZ1MBAQFdXBFMF+hybQh1KGIvipv6nBvQwY/i1YT0VqXHu5zxQ0bBZav
 GSfsFjmymAr6shUf3OMLgQJCd0Z8NO2SuY2VUa9AvIMxbNuEXHCfNQSoOv8pLXTL2EQP
 C4c4jPInmpbegjTt3QadJlIwBin4HfmJuvicfwI4xHAR/T91yP1U9jbjhr6MqToKkWue
 SOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743636307; x=1744241107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aw2XQfGXY2tajUUeRGGA5Q8BLnCp/nr7d59BqLcZ8lw=;
 b=cGQWg7tCI0PLf0WUEW8tUK0Nm12mArIshLA8CycAFkD7kNaYkHQO13TBfLwx09fKOT
 6sp0i/thgiDIiprw51fhFlqbgyrnHlHgoIQsQ0g2lzGDBSbEE7N7j9SqaAhTv37cVsO+
 ARE2sXxw5IjXPULW9Ffa01sKpiL4AeEmq3gieeUrgSBpanFxC30CSzMvWtxj4XjYDOGy
 gK7kWYEKsXo3u5eCAVUHi43KhSuBvIpEtTwGpzGp1lQ/nMd+/KziMHy7AUu5XvBn0OXw
 4dlrTwZDJp0Ib6F6JmdJhj91w36CbjpKpu9vrvbm2mmd3agF7+B4Q/NekzxDKhhggHyH
 mU7w==
X-Gm-Message-State: AOJu0Yx2QRyfXCtAb5J+5KoKxss3OostGhjZQ7Cx4YgPoVZUPOWXx3w4
 Sd4/b3s+yR5Kammnjuiq43OT6Jm/yFsKcqoPVctHIXGcWcdCH7WQEknJfU+YWDu5O+RgOT3yMkT
 qx4s=
X-Gm-Gg: ASbGncsOwhHDKVg4rqBk2bMkFZDZaPVpdpykemktYJ1WyIzaoF5+FzWsSTInY8uY/g0
 8SyLaCpAeV1esyJp6T3e+AMJyelUPVJB4IPtFhivVyl6ELXEDpkr3I9fA42UmosK1GoZtIWlQW8
 wsZVfHzs9n329+XieU5KoMxIMm2y2kvP+Xipp2gvli2uBoJN3RALv/9d8iZxDzBFeXfuXQ5Ov2j
 IFX00H1GheOtbe73vRPwl3wlH8Su5ZSW76k0FRMz2ecvnsbS+tzMYFjDWUvTb6RYmKmccG/+qj2
 QdJWqTmbaJoQBhSAIY2cYk7WOvUPjVMSlR8ooXWPFSz3J8BOfiG11/uRNFYAxSGDGdgiVLNu1yx
 iFQdkYC7T/svteofqqQ==
X-Google-Smtp-Source: AGHT+IE2NpLsUplpDFZoDyV8haCmPv7pS+XFCxGd+WQySnG7Rhl+Lea/M1jf2UB/Ev9aCMBJTkCeDg==
X-Received: by 2002:a05:6214:2aa5:b0:6e8:98c0:e546 with SMTP id
 6a1803df08f44-6eed61dc5ddmr280354836d6.29.1743636307214; 
 Wed, 02 Apr 2025 16:25:07 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ef0f14e993sm672826d6.112.2025.04.02.16.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 16:25:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Liang Ma <liangma@liangbit.com>,
 Peter Mccarthy <peter.mccarthy@intel.com>,
 Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>,
 Julien Aube <julien_dpdk@jaube.fr>,
 Somnath Kotur <somnath.kotur@broadcom.com>, Chas Williams <chas3@att.com>,
 "Min Hu (Connor)" <humin29@huawei.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Liron Himi <lironh@marvell.com>, Chaoyong He <chaoyong.he@corigine.com>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v12 10/10] drivers: remove use of term sanity check
Date: Wed,  2 Apr 2025 16:23:20 -0700
Message-ID: <20250402232441.440346-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402232441.440346-1-stephen@networkplumber.org>
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
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

Don't use term "sanity" because it is considered derogatory.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/qbman/qbman_sys_decl.h   |  2 +-
 drivers/common/cnxk/roc_nix_tm_ops.c       |  2 +-
 drivers/common/cnxk/roc_npa.c              |  6 +++---
 drivers/common/dpaax/caamflib/desc.h       |  2 +-
 drivers/common/mlx5/linux/mlx5_common_os.c |  2 +-
 drivers/common/sfc_efx/base/ef10_nvram.c   |  4 ++--
 drivers/common/sfc_efx/base/efx_rx.c       |  2 +-
 drivers/crypto/bcmfs/hw/bcmfs4_rm.c        |  6 +++---
 drivers/crypto/bcmfs/hw/bcmfs5_rm.c        |  6 +++---
 drivers/dma/idxd/idxd_pci.c                |  2 +-
 drivers/event/opdl/opdl_evdev.c            |  2 +-
 drivers/event/opdl/opdl_evdev_init.c       |  2 +-
 drivers/net/ark/ark_ethdev.c               |  8 ++++----
 drivers/net/ark/ark_ethdev_rx.c            |  2 +-
 drivers/net/bnx2x/bnx2x.c                  |  2 +-
 drivers/net/bnx2x/bnx2x_stats.c            |  8 ++++----
 drivers/net/bnx2x/ecore_sp.c               |  2 +-
 drivers/net/bnx2x/elink.c                  |  4 ++--
 drivers/net/bnxt/bnxt_hwrm.c               |  2 +-
 drivers/net/bnxt/hsi_struct_def_dpdk.h     |  2 +-
 drivers/net/bonding/rte_eth_bond_8023ad.c  |  2 +-
 drivers/net/cnxk/cnxk_ethdev.c             |  4 ++--
 drivers/net/cxgbe/cxgbe_ethdev.c           | 10 ++--------
 drivers/net/cxgbe/cxgbevf_main.c           |  4 ++--
 drivers/net/intel/fm10k/fm10k_ethdev.c     |  2 +-
 drivers/net/intel/fm10k/fm10k_rxtx.c       |  2 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c       |  2 +-
 drivers/net/intel/ixgbe/ixgbe_ipsec.c      |  2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c       |  2 +-
 drivers/net/mlx4/mlx4.c                    |  2 +-
 drivers/net/mlx4/mlx4_flow.c               |  6 +++---
 drivers/net/mlx5/mlx5_flow_dv.c            |  2 +-
 drivers/net/mlx5/mlx5_flow_hw.c            |  6 ++----
 drivers/net/mlx5/mlx5_rxq.c                |  2 +-
 drivers/net/mlx5/mlx5_rxtx_vec.h           |  2 +-
 drivers/net/mvpp2/mrvl_qos.c               |  2 +-
 drivers/net/nfp/flower/nfp_flower_flow.c   |  2 +-
 drivers/net/nfp/nfp_net_flow.c             |  2 +-
 drivers/net/ntnic/nthw/nthw_rac.c          |  2 +-
 drivers/net/qede/qede_rxtx.c               |  6 +++---
 drivers/net/ring/rte_eth_ring.c            |  7 ++-----
 drivers/net/sfc/sfc_dp_rx.h                |  2 +-
 drivers/net/txgbe/txgbe_ipsec.c            |  2 +-
 drivers/net/txgbe/txgbe_rxtx.c             |  2 +-
 44 files changed, 67 insertions(+), 78 deletions(-)

diff --git a/drivers/bus/fslmc/qbman/qbman_sys_decl.h b/drivers/bus/fslmc/qbman/qbman_sys_decl.h
index caaae41777..2b6162d0ce 100644
--- a/drivers/bus/fslmc/qbman/qbman_sys_decl.h
+++ b/drivers/bus/fslmc/qbman/qbman_sys_decl.h
@@ -9,7 +9,7 @@
 #include <compat.h>
 #include <fsl_qbman_base.h>
 
-/* Sanity check */
+/* Byte order check */
 #if (__BYTE_ORDER__ != __ORDER_BIG_ENDIAN__) && \
 	(__BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__)
 #error "Unknown endianness!"
diff --git a/drivers/common/cnxk/roc_nix_tm_ops.c b/drivers/common/cnxk/roc_nix_tm_ops.c
index b89f08ac66..9206aeafdf 100644
--- a/drivers/common/cnxk/roc_nix_tm_ops.c
+++ b/drivers/common/cnxk/roc_nix_tm_ops.c
@@ -539,7 +539,7 @@ roc_nix_tm_hierarchy_disable(struct roc_nix *roc_nix)
 		node->flags &= ~NIX_TM_NODE_ENABLED;
 	}
 
-	/* Verify sanity of all tx queues */
+	/* Verify all tx queues */
 	for (i = 0; i < sq_cnt; i++) {
 		sq = nix->sqs[i];
 		if (!sq)
diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c
index a33f9a8499..2a5dd9a3a2 100644
--- a/drivers/common/cnxk/roc_npa.c
+++ b/drivers/common/cnxk/roc_npa.c
@@ -527,7 +527,7 @@ npa_aura_pool_pair_alloc(struct npa_lf *lf, const uint32_t block_size,
 	char name[PLT_MEMZONE_NAMESIZE];
 	const struct plt_memzone *mz;
 
-	/* Sanity check */
+	/* argument checks */
 	if (!lf || !block_size || !block_count || !pool || !aura ||
 	    !aura_handle)
 		return NPA_ERR_PARAM;
@@ -691,7 +691,7 @@ npa_aura_alloc(struct npa_lf *lf, const uint32_t block_count, int pool_id,
 {
 	int rc, aura_id;
 
-	/* Sanity check */
+	/* parameter check */
 	if (!lf || !aura || !aura_handle)
 		return NPA_ERR_PARAM;
 
@@ -1178,7 +1178,7 @@ npa_dev_init(struct npa_lf *lf, uintptr_t base, struct mbox *mbox)
 	uint8_t aura_sz;
 	int rc;
 
-	/* Sanity checks */
+	/* Input checks */
 	if (!lf || !base || !mbox)
 		return NPA_ERR_PARAM;
 
diff --git a/drivers/common/dpaax/caamflib/desc.h b/drivers/common/dpaax/caamflib/desc.h
index 4a1285c4d4..37c87eebd5 100644
--- a/drivers/common/dpaax/caamflib/desc.h
+++ b/drivers/common/dpaax/caamflib/desc.h
@@ -107,7 +107,7 @@ extern enum rta_sec_era rta_sec_era;
 
 /*
  * ONE - should always be set. Combination of ONE (always
- * set) and ZRO (always clear) forms an endianness sanity check
+ * set) and ZRO (always clear) forms an endianness check
  */
 #define HDR_ONE			BIT(23)
 #define HDR_ZRO			BIT(15)
diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index 2f5032f0da..fe5d51cf4c 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -235,7 +235,7 @@ mlx5_get_ifname_sysfs(const char *ibdev_path, char *ifname)
 /**
  * Suffix RTE_EAL_PMD_PATH with "-glue".
  *
- * This function performs a sanity check on RTE_EAL_PMD_PATH before
+ * This function performs a check on RTE_EAL_PMD_PATH before
  * suffixing its last component.
  *
  * @param buf[out]
diff --git a/drivers/common/sfc_efx/base/ef10_nvram.c b/drivers/common/sfc_efx/base/ef10_nvram.c
index ce8357fa94..fad9f0f507 100644
--- a/drivers/common/sfc_efx/base/ef10_nvram.c
+++ b/drivers/common/sfc_efx/base/ef10_nvram.c
@@ -595,13 +595,13 @@ tlv_update_partition_len_and_cks(
 
 	/*
 	 * We just modified the partition, so the total length may not be
-	 * valid. Don't use tlv_find(), which performs some sanity checks
+	 * valid. Don't use tlv_find(), which performs some checks
 	 * that may fail here.
 	 */
 	partition.data = cursor->block;
 	memcpy(&partition.tlv_cursor, cursor, sizeof (*cursor));
 	header = (struct tlv_partition_header *)partition.data;
-	/* Sanity check. */
+	/* Header check */
 	if (__LE_TO_CPU_32(header->tag) != TLV_TAG_PARTITION_HEADER) {
 		rc = EFAULT;
 		goto fail1;
diff --git a/drivers/common/sfc_efx/base/efx_rx.c b/drivers/common/sfc_efx/base/efx_rx.c
index dce9ada55d..28676c5a5b 100644
--- a/drivers/common/sfc_efx/base/efx_rx.c
+++ b/drivers/common/sfc_efx/base/efx_rx.c
@@ -930,7 +930,7 @@ efx_rx_qcreate_internal(
 	    ndescs, id, flags, eep, erp)) != 0)
 		goto fail4;
 
-	/* Sanity check queue creation result */
+	/* Check queue creation result */
 	if (flags & EFX_RXQ_FLAG_RSS_HASH) {
 		const efx_rx_prefix_layout_t *erplp = &erp->er_prefix_layout;
 		const efx_rx_prefix_field_info_t *rss_hash_field;
diff --git a/drivers/crypto/bcmfs/hw/bcmfs4_rm.c b/drivers/crypto/bcmfs/hw/bcmfs4_rm.c
index 9a30c654da..051bbea9cc 100644
--- a/drivers/crypto/bcmfs/hw/bcmfs4_rm.c
+++ b/drivers/crypto/bcmfs/hw/bcmfs4_rm.c
@@ -317,7 +317,7 @@ bcmfs4_mdst_desc(uint64_t addr, unsigned int length_div_16)
 }
 
 static bool
-bcmfs4_sanity_check(struct bcmfs_qp_message *msg)
+bcmfs4_message_check(struct bcmfs_qp_message *msg)
 {
 	unsigned int i = 0;
 
@@ -458,8 +458,8 @@ bcmfs4_enqueue_single_request_qp(struct bcmfs_qp *qp, void *op)
 	struct bcmfs_queue *txq = &qp->tx_q;
 	struct bcmfs_qp_message *msg = (struct bcmfs_qp_message *)op;
 
-	/* Do sanity check on message */
-	if (!bcmfs4_sanity_check(msg)) {
+	/* Do check on message */
+	if (!bcmfs4_message_check(msg)) {
 		BCMFS_DP_LOG(ERR, "Invalid msg on queue %d", qp->qpair_id);
 		return -EIO;
 	}
diff --git a/drivers/crypto/bcmfs/hw/bcmfs5_rm.c b/drivers/crypto/bcmfs/hw/bcmfs5_rm.c
index cbfe42cb47..2df10a3028 100644
--- a/drivers/crypto/bcmfs/hw/bcmfs5_rm.c
+++ b/drivers/crypto/bcmfs/hw/bcmfs5_rm.c
@@ -293,7 +293,7 @@ bcmfs5_mdst_desc(uint64_t addr, unsigned int len_div_16)
 }
 
 static bool
-bcmfs5_sanity_check(struct bcmfs_qp_message *msg)
+bcmfs5_message_check(struct bcmfs_qp_message *msg)
 {
 	unsigned int i = 0;
 
@@ -389,8 +389,8 @@ bcmfs5_enqueue_single_request_qp(struct bcmfs_qp *qp, void *op)
 	struct bcmfs_queue *txq = &qp->tx_q;
 	struct bcmfs_qp_message *msg = (struct bcmfs_qp_message *)op;
 
-	/* Do sanity check on message */
-	if (!bcmfs5_sanity_check(msg)) {
+	/* Do check on message */
+	if (!bcmfs5_message_check(msg)) {
 		BCMFS_DP_LOG(ERR, "Invalid msg on queue %d", qp->qpair_id);
 		return -EIO;
 	}
diff --git a/drivers/dma/idxd/idxd_pci.c b/drivers/dma/idxd/idxd_pci.c
index 214f6f22d5..a14907dc20 100644
--- a/drivers/dma/idxd/idxd_pci.c
+++ b/drivers/dma/idxd/idxd_pci.c
@@ -219,7 +219,7 @@ init_pci_device(struct rte_pci_device *dev, struct idxd_dmadev *idxd,
 		goto err;
 	}
 
-	/* sanity check device status */
+	/* check device status */
 	if (pci->regs->gensts & GENSTS_DEV_STATE_MASK) {
 		/* need function-level-reset (FLR) or is enabled */
 		IDXD_PMD_ERR("Device status is not disabled, cannot init");
diff --git a/drivers/event/opdl/opdl_evdev.c b/drivers/event/opdl/opdl_evdev.c
index ffa65ef930..08605d9878 100644
--- a/drivers/event/opdl/opdl_evdev.c
+++ b/drivers/event/opdl/opdl_evdev.c
@@ -241,7 +241,7 @@ opdl_queue_setup(struct rte_eventdev *dev,
 
 	struct opdl_evdev *device = opdl_pmd_priv(dev);
 
-	/* Extra sanity check, probably not needed */
+	/* Extra check, probably not needed */
 	if (queue_id == OPDL_INVALID_QID) {
 		PMD_DRV_LOG(ERR, "DEV_ID:[%02d] : "
 			     "Invalid queue id %u requested",
diff --git a/drivers/event/opdl/opdl_evdev_init.c b/drivers/event/opdl/opdl_evdev_init.c
index be3437fc2f..12eb2695f5 100644
--- a/drivers/event/opdl/opdl_evdev_init.c
+++ b/drivers/event/opdl/opdl_evdev_init.c
@@ -300,7 +300,7 @@ static int opdl_add_deps(struct opdl_evdev *device,
 	struct opdl_queue *queue_deps = &device->queue[deps_q_id];
 	struct opdl_stage *dep_stages[OPDL_PORTS_MAX];
 
-	/* sanity check that all stages are for same opdl ring */
+	/* check that all stages are for same opdl ring */
 	for (i = 0; i < queue->nb_ports; i++) {
 		struct opdl_ring *r =
 			opdl_stage_get_opdl_ring(stage_for_port(queue, i));
diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index c029dc46b3..36b3e2b8e6 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -349,10 +349,10 @@ eth_ark_dev_init(struct rte_eth_dev *dev)
 	ARK_PMD_LOG(NOTICE, "Arkville HW Commit_ID: %08x\n",
 		    rte_be_to_cpu_32(ark->sysctrl.t32[0x20 / 4]));
 
-	/* If HW sanity test fails, return an error */
+	/* If HW test fails, return an error */
 	if (ark->sysctrl.t32[4] != 0xcafef00d) {
 		ARK_PMD_LOG(ERR,
-			    "HW Sanity test has failed, expected constant"
+			    "HW test has failed, expected constant"
 			    " 0x%x, read 0x%x (%s)\n",
 			    0xcafef00d,
 			    ark->sysctrl.t32[4], __func__);
@@ -360,7 +360,7 @@ eth_ark_dev_init(struct rte_eth_dev *dev)
 	}
 
 	ARK_PMD_LOG(DEBUG,
-		    "HW Sanity test has PASSED, expected constant"
+		    "HW test has PASSED, expected constant"
 		    " 0x%x, read 0x%x (%s)\n",
 		    0xcafef00d, ark->sysctrl.t32[4], __func__);
 
@@ -590,7 +590,7 @@ eth_ark_dev_start(struct rte_eth_dev *dev)
 		rte_thread_t thread;
 
 		/* Delay packet generator start allow the hardware to be ready
-		 * This is only used for sanity checking with internal generator
+		 * This is only used for checking with internal generator
 		 */
 		char tname[RTE_THREAD_INTERNAL_NAME_SIZE];
 		snprintf(tname, sizeof(tname), "ark-pg%d", dev->data->port_id);
diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_rx.c
index 80e431f1ae..e7683c9175 100644
--- a/drivers/net/ark/ark_ethdev_rx.c
+++ b/drivers/net/ark/ark_ethdev_rx.c
@@ -283,7 +283,7 @@ eth_ark_recv_pkts(void *rx_queue,
 		mbuf->pkt_len = meta->pkt_len;
 		mbuf->data_len = meta->pkt_len;
 
-		if (ARK_DEBUG_CORE) {	/* debug sanity checks */
+		if (ARK_DEBUG_CORE) {	/* debug checks */
 
 			if ((meta->pkt_len > (1024 * 16)) ||
 			    (meta->pkt_len == 0)) {
diff --git a/drivers/net/bnx2x/bnx2x.c b/drivers/net/bnx2x/bnx2x.c
index 51e5cabf7b..0391c92125 100644
--- a/drivers/net/bnx2x/bnx2x.c
+++ b/drivers/net/bnx2x/bnx2x.c
@@ -7816,7 +7816,7 @@ static int bnx2x_check_valid_mf_cfg(struct bnx2x_softc *sc)
 	uint32_t ovlan2;
 	uint8_t i, j;
 
-	/* various MF mode sanity checks... */
+	/* various MF mode checks... */
 
 	if (mf_info->mf_config[SC_VN(sc)] & FUNC_MF_CFG_FUNC_HIDE) {
 		PMD_DRV_LOG(NOTICE, sc,
diff --git a/drivers/net/bnx2x/bnx2x_stats.c b/drivers/net/bnx2x/bnx2x_stats.c
index 8adbe7e381..b9d7582d24 100644
--- a/drivers/net/bnx2x/bnx2x_stats.c
+++ b/drivers/net/bnx2x/bnx2x_stats.c
@@ -178,7 +178,7 @@ bnx2x_stats_pmf_update(struct bnx2x_softc *sc)
 		 */
 		return;
 	}
-	/* sanity */
+	/* input validation */
 	if (!sc->port.pmf || !sc->port.port_stx) {
 		PMD_DRV_LOG(ERR, sc, "BUG!");
 		return;
@@ -228,7 +228,7 @@ bnx2x_port_stats_init(struct bnx2x_softc *sc)
 	uint32_t mac_addr;
 	uint32_t *stats_comp = BNX2X_SP(sc, stats_comp);
 
-	/* sanity */
+	/* input validation */
 	if (!sc->link_vars.link_up || !sc->port.pmf) {
 		PMD_DRV_LOG(ERR, sc, "BUG!");
 		return;
@@ -454,7 +454,7 @@ bnx2x_func_stats_init(struct bnx2x_softc *sc)
 	struct dmae_command *dmae = &sc->stats_dmae;
 	uint32_t *stats_comp = BNX2X_SP(sc, stats_comp);
 
-	/* sanity */
+	/* input validation */
 	if (!sc->func_stx) {
 		PMD_DRV_LOG(ERR, sc, "BUG!");
 		return;
@@ -1277,7 +1277,7 @@ bnx2x_port_stats_base_init(struct bnx2x_softc *sc)
 	struct dmae_command *dmae;
 	uint32_t *stats_comp = BNX2X_SP(sc, stats_comp);
 
-	/* sanity */
+	/* input validation */
 	if (!sc->port.pmf || !sc->port.port_stx) {
 		PMD_DRV_LOG(ERR, sc, "BUG!");
 		return;
diff --git a/drivers/net/bnx2x/ecore_sp.c b/drivers/net/bnx2x/ecore_sp.c
index c6c3857778..158205266f 100644
--- a/drivers/net/bnx2x/ecore_sp.c
+++ b/drivers/net/bnx2x/ecore_sp.c
@@ -207,7 +207,7 @@ static int ecore_exe_queue_step(struct bnx2x_softc *sc,
 			break;
 	}
 
-	/* Sanity check */
+	/* Argument check */
 	if (!cur_len)
 		return ECORE_SUCCESS;
 
diff --git a/drivers/net/bnx2x/elink.c b/drivers/net/bnx2x/elink.c
index 2c81f85b96..6ebd47d927 100644
--- a/drivers/net/bnx2x/elink.c
+++ b/drivers/net/bnx2x/elink.c
@@ -1088,7 +1088,7 @@ static void elink_get_epio(struct bnx2x_softc *sc, uint32_t epio_pin,
 {
 	uint32_t epio_mask, gp_oenable;
 	*en = 0;
-	/* Sanity check */
+	/* Input check */
 	if (epio_pin > 31) {
 		ELINK_DEBUG_P1(sc, "Invalid EPIO pin %d to get", epio_pin);
 		return;
@@ -1105,7 +1105,7 @@ static void elink_set_epio(struct bnx2x_softc *sc, uint32_t epio_pin, uint32_t e
 {
 	uint32_t epio_mask, gp_output, gp_oenable;
 
-	/* Sanity check */
+	/* Input check */
 	if (epio_pin > 31) {
 		ELINK_DEBUG_P1(sc, "Invalid EPIO pin %d to set", epio_pin);
 		return;
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 305c419051..b0159d0a57 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -585,7 +585,7 @@ static int bnxt_hwrm_send_message(struct bnxt *bp, void *msg,
 
 		done = bnxt_check_cq_hwrm_done(cpr, is_tx, is_rx,
 					       i == timeout - 1);
-		/* Sanity check on the resp->resp_len */
+		/* Input check on the resp->resp_len */
 		rte_io_rmb();
 		if (resp->resp_len && resp->resp_len <= bp->max_resp_len) {
 			/* Last byte of resp contains the valid key */
diff --git a/drivers/net/bnxt/hsi_struct_def_dpdk.h b/drivers/net/bnxt/hsi_struct_def_dpdk.h
index f089813a68..f2a8a774b2 100644
--- a/drivers/net/bnxt/hsi_struct_def_dpdk.h
+++ b/drivers/net/bnxt/hsi_struct_def_dpdk.h
@@ -60454,7 +60454,7 @@ struct __rte_packed_begin hwrm_tfc_ident_alloc_output {
  * Requests the firmware to free a TFC resource identifier.
  * A resource subtype and session id are passed in.
  * An identifier (previously allocated) corresponding to all these is
- * freed, only after various sanity checks are completed.
+ * freed, only after various checks are completed.
  */
 /* hwrm_tfc_ident_free_input (size:192b/24B) */
 struct __rte_packed_begin hwrm_tfc_ident_free_input {
diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index 7f885ab521..eaa0b94e63 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -1473,7 +1473,7 @@ bond_8023ad_setup_validate(uint16_t port_id,
 		return -EINVAL;
 
 	if (conf != NULL) {
-		/* Basic sanity check */
+		/* Basic input check */
 		if (conf->slow_periodic_ms == 0 ||
 				conf->fast_periodic_ms >= conf->slow_periodic_ms ||
 				conf->long_timeout_ms == 0 ||
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 289ae96afa..6ca6019878 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -659,7 +659,7 @@ cnxk_nix_rx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t qid,
 	struct rte_mempool *lpb_pool = mp;
 	struct rte_mempool *spb_pool = NULL;
 
-	/* Sanity checks */
+	/* input checks */
 	if (rx_conf->rx_deferred_start == 1) {
 		plt_err("Deferred Rx start is not supported");
 		goto fail;
@@ -1228,7 +1228,7 @@ cnxk_nix_configure(struct rte_eth_dev *eth_dev)
 
 	rc = -EINVAL;
 
-	/* Sanity checks */
+	/* baseline checks */
 	if (rte_eal_has_hugepages() == 0) {
 		plt_err("Huge page is not configured");
 		goto fail_configure;
diff --git a/drivers/net/cxgbe/cxgbe_ethdev.c b/drivers/net/cxgbe/cxgbe_ethdev.c
index 9b6a3651f9..b87e548ebc 100644
--- a/drivers/net/cxgbe/cxgbe_ethdev.c
+++ b/drivers/net/cxgbe/cxgbe_ethdev.c
@@ -525,10 +525,7 @@ int cxgbe_dev_tx_queue_setup(struct rte_eth_dev *eth_dev,
 
 	eth_dev->data->tx_queues[queue_idx] = (void *)txq;
 
-	/* Sanity Checking
-	 *
-	 * nb_desc should be > 1023 and <= CXGBE_MAX_RING_DESC_SIZE
-	 */
+	/* nb_desc should be > 1023 and <= CXGBE_MAX_RING_DESC_SIZE */
 	temp_nb_desc = nb_desc;
 	if (nb_desc < CXGBE_MIN_RING_DESC_SIZE) {
 		dev_warn(adapter, "%s: number of descriptors must be >= %d. Using default [%d]\n",
@@ -649,10 +646,7 @@ int cxgbe_dev_rx_queue_setup(struct rte_eth_dev *eth_dev,
 
 	eth_dev->data->rx_queues[queue_idx] = (void *)rxq;
 
-	/* Sanity Checking
-	 *
-	 * nb_desc should be > 0 and <= CXGBE_MAX_RING_DESC_SIZE
-	 */
+	/* nb_desc should be > 0 and <= CXGBE_MAX_RING_DESC_SIZE */
 	temp_nb_desc = nb_desc;
 	if (nb_desc < CXGBE_MIN_RING_DESC_SIZE) {
 		dev_warn(adapter, "%s: number of descriptors must be >= %d. Using default [%d]\n",
diff --git a/drivers/net/cxgbe/cxgbevf_main.c b/drivers/net/cxgbe/cxgbevf_main.c
index d0c93f8ac3..dfb12b4ed5 100644
--- a/drivers/net/cxgbe/cxgbevf_main.c
+++ b/drivers/net/cxgbe/cxgbevf_main.c
@@ -137,7 +137,7 @@ static int adap_init0vf(struct adapter *adapter)
 
 	/*
 	 * Grab our Virtual Interface resource allocation, extract the
-	 * features that we're interested in and do a bit of sanity testing on
+	 * features that we're interested in and do a bit of testing on
 	 * what we discover.
 	 */
 	err = t4vf_get_vfres(adapter);
@@ -148,7 +148,7 @@ static int adap_init0vf(struct adapter *adapter)
 	}
 
 	/*
-	 * Check for various parameter sanity issues.
+	 * Check for various parameter issues.
 	 */
 	if (adapter->params.vfres.pmask == 0) {
 		dev_err(adapter->pdev_dev, "no port access configured\n"
diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
index 75ce2e19cf..6b9fef78fe 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -1760,7 +1760,7 @@ mempool_element_size_valid(struct rte_mempool *mp)
 	/* account for up to 512B of alignment */
 	min_size -= FM10K_RX_DATABUF_ALIGN;
 
-	/* sanity check for overflow */
+	/* check for overflow */
 	if (min_size > mp->elt_size)
 		return 0;
 
diff --git a/drivers/net/intel/fm10k/fm10k_rxtx.c b/drivers/net/intel/fm10k/fm10k_rxtx.c
index 690142b357..c2940901fe 100644
--- a/drivers/net/intel/fm10k/fm10k_rxtx.c
+++ b/drivers/net/intel/fm10k/fm10k_rxtx.c
@@ -646,7 +646,7 @@ fm10k_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		if (q->nb_free < mb->nb_segs)
 			break;
 
-		/* sanity check to make sure the mbuf is valid */
+		/* check to make sure the mbuf is valid */
 		if ((mb->nb_segs == 0) ||
 		    ((mb->nb_segs > 1) && (mb->next == NULL)))
 			break;
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index b6351bc2cf..f31542b2b0 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -1131,7 +1131,7 @@ ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
 		return -ENOTSUP;
 
 	/*
-	 * Sanity check for x550.
+	 * Check for x550.
 	 * When adding a new filter with flow type set to IPv4,
 	 * the flow director mask should be configed before,
 	 * and the L4 protocol and ports are masked.
diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index 778004cbe4..7bdc9336bf 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -615,7 +615,7 @@ ixgbe_crypto_enable_ipsec(struct rte_eth_dev *dev)
 	rx_offloads = dev->data->dev_conf.rxmode.offloads;
 	tx_offloads = dev->data->dev_conf.txmode.offloads;
 
-	/* sanity checks */
+	/* input validation */
 	if (rx_offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO) {
 		PMD_DRV_LOG(ERR, "RSC and IPsec not supported");
 		return -1;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 0c8a9ec763..d3cbb7922e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -4971,7 +4971,7 @@ ixgbe_set_rsc(struct rte_eth_dev *dev)
 	uint32_t rdrxctl;
 	uint32_t rfctl;
 
-	/* Sanity check */
+	/* Offload check */
 	dev->dev_ops->dev_infos_get(dev, &dev_info);
 	if (dev_info.rx_offload_capa & RTE_ETH_RX_OFFLOAD_TCP_LRO)
 		rsc_capable = true;
diff --git a/drivers/net/mlx4/mlx4.c b/drivers/net/mlx4/mlx4.c
index 9c2872429f..0c25d501f1 100644
--- a/drivers/net/mlx4/mlx4.c
+++ b/drivers/net/mlx4/mlx4.c
@@ -1216,7 +1216,7 @@ static struct rte_pci_driver mlx4_driver = {
 /**
  * Suffix RTE_EAL_PMD_PATH with "-glue".
  *
- * This function performs a sanity check on RTE_EAL_PMD_PATH before
+ * This function performs a check on RTE_EAL_PMD_PATH before
  * suffixing its last component.
  *
  * @param buf[out]
diff --git a/drivers/net/mlx4/mlx4_flow.c b/drivers/net/mlx4/mlx4_flow.c
index b520664d95..7650d57597 100644
--- a/drivers/net/mlx4/mlx4_flow.c
+++ b/drivers/net/mlx4/mlx4_flow.c
@@ -514,7 +514,7 @@ mlx4_flow_merge_tcp(struct rte_flow *flow,
 }
 
 /**
- * Perform basic sanity checks on a pattern item.
+ * Perform basic checks on a pattern item.
  *
  * @param[in] item
  *   Item specification.
@@ -730,7 +730,7 @@ mlx4_flow_prepare(struct mlx4_priv *priv,
 			goto exit_item_not_supported;
 		proc = next;
 		/*
-		 * Perform basic sanity checks only once, while handle is
+		 * Perform basic checks only once, while handle is
 		 * not allocated.
 		 */
 		if (flow == &temp) {
@@ -799,7 +799,7 @@ mlx4_flow_prepare(struct mlx4_priv *priv,
 				rss_key = mlx4_rss_hash_key_default;
 				rss_key_len = MLX4_RSS_HASH_KEY_SIZE;
 			}
-			/* Sanity checks. */
+			/* Input checks. */
 			for (i = 0; i < rss->queue_num; ++i)
 				if (rss->queue[i] >=
 				    ETH_DEV(priv)->data->nb_rx_queues)
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 608c42db1d..b0177e2bcd 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -9227,7 +9227,7 @@ flow_dv_prepare(struct rte_eth_dev *dev,
 
 #ifdef RTE_LIBRTE_MLX5_DEBUG
 /**
- * Sanity check for match mask and value. Similar to check_valid_spec() in
+ * Check for match mask and value. Similar to check_valid_spec() in
  * kernel driver. If unmasked bit is present in value, it returns failure.
  *
  * @param match_mask
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 20d38ce414..cfbd037a33 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -9797,11 +9797,10 @@ flow_hw_tx_tag_regc_mask(struct rte_eth_dev *dev)
 	struct mlx5_priv *priv = dev->data->dev_private;
 	uint32_t mask = priv->sh->dv_regc0_mask;
 
-	/* Mask is verified during device initialization. Sanity checking here. */
+	/* Mask is verified during device initialization. */
 	MLX5_ASSERT(mask != 0);
 	/*
 	 * Availability of sufficient number of bits in REG_C_0 is verified on initialization.
-	 * Sanity checking here.
 	 */
 	MLX5_ASSERT(rte_popcount32(mask) >= rte_popcount32(priv->vport_meta_mask));
 	return mask;
@@ -9813,12 +9812,11 @@ flow_hw_tx_tag_regc_value(struct rte_eth_dev *dev)
 	struct mlx5_priv *priv = dev->data->dev_private;
 	uint32_t tag;
 
-	/* Mask is verified during device initialization. Sanity checking here. */
+	/* Mask is verified during device initialization. */
 	MLX5_ASSERT(priv->vport_meta_mask != 0);
 	tag = priv->vport_meta_tag >> (rte_bsf32(priv->vport_meta_mask));
 	/*
 	 * Availability of sufficient number of bits in REG_C_0 is verified on initialization.
-	 * Sanity checking here.
 	 */
 	MLX5_ASSERT((tag & priv->sh->dv_regc0_mask) == tag);
 	return tag;
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 5cf7d4971b..7268dda67b 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -1488,7 +1488,7 @@ mlx5_mprq_alloc_mp(struct rte_eth_dev *dev)
 	desc *= 4;
 	obj_num = desc + MLX5_MPRQ_MP_CACHE_SZ * n_ibv;
 	/*
-	 * rte_mempool_create_empty() has sanity check to refuse large cache
+	 * rte_mempool_create_empty() has basic check to refuse large cache
 	 * size compared to the number of elements.
 	 * CALC_CACHE_FLUSHTHRESH() is defined in a C file, so using a
 	 * constant number 2 instead.
diff --git a/drivers/net/mlx5/mlx5_rxtx_vec.h b/drivers/net/mlx5/mlx5_rxtx_vec.h
index 77c3f4efa0..f8376f2b55 100644
--- a/drivers/net/mlx5/mlx5_rxtx_vec.h
+++ b/drivers/net/mlx5/mlx5_rxtx_vec.h
@@ -21,7 +21,7 @@
 	 RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM)
 
 /*
- * Compile time sanity check for vectorized functions.
+ * Compile time checks for vectorized functions.
  */
 
 #define S_ASSERT_RTE_MBUF(s) \
diff --git a/drivers/net/mvpp2/mrvl_qos.c b/drivers/net/mvpp2/mrvl_qos.c
index e298da2724..ba611943cb 100644
--- a/drivers/net/mvpp2/mrvl_qos.c
+++ b/drivers/net/mvpp2/mrvl_qos.c
@@ -260,7 +260,7 @@ get_entry_values(const char *entry, uint8_t *tab,
 			if (nb_rng_tokens != 2)
 				return -3;
 
-			/* Range and sanity checks. */
+			/* Range and input checks. */
 			if (get_val_securely(rng_tokens[0], &token_val) < 0)
 				return -4;
 			beg = (char)token_val;
diff --git a/drivers/net/nfp/flower/nfp_flower_flow.c b/drivers/net/nfp/flower/nfp_flower_flow.c
index ad0fe9a8ef..d4eb54753e 100644
--- a/drivers/net/nfp/flower/nfp_flower_flow.c
+++ b/drivers/net/nfp/flower/nfp_flower_flow.c
@@ -2769,7 +2769,7 @@ nfp_flow_compile_item_proc(struct nfp_flower_representor *repr,
 			break;
 		}
 
-		/* Perform basic sanity checks */
+		/* Perform basic checks */
 		ret = nfp_flow_item_check(item, proc);
 		if (ret != 0) {
 			PMD_DRV_LOG(ERR, "NFP flow item %d check failed.", item->type);
diff --git a/drivers/net/nfp/nfp_net_flow.c b/drivers/net/nfp/nfp_net_flow.c
index 7f3fff2186..552ce7594c 100644
--- a/drivers/net/nfp/nfp_net_flow.c
+++ b/drivers/net/nfp/nfp_net_flow.c
@@ -528,7 +528,7 @@ nfp_net_flow_compile_items(const struct rte_flow_item items[],
 			break;
 		}
 
-		/* Perform basic sanity checks */
+		/* Perform basic checks */
 		ret = nfp_net_flow_item_check(item, proc);
 		if (ret != 0) {
 			PMD_DRV_LOG(ERR, "NFP flow item %d check failed.", item->type);
diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index 2257dfb7dc..14aa4320ad 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -76,7 +76,7 @@ int nthw_rac_init(nthw_rac_t *p, nthw_fpga_t *p_fpga, struct fpga_info_s *p_fpga
 	p->mn_fld_rab_init_bw = nthw_field_get_bit_width(p->mp_fld_rab_init);
 	p->mn_fld_rab_init_mask = nthw_field_get_mask(p->mp_fld_rab_init);
 
-	/* RAC_RAB_INIT_RAB reg/field sanity checks: */
+	/* make sure RAC_RAB_INIT_RAB reg/field is valid */
 	RTE_ASSERT(p->mn_fld_rab_init_mask == ((1UL << p->mn_fld_rab_init_bw) - 1));
 	RTE_ASSERT(p->mn_fld_rab_init_bw == p->mn_param_rac_rab_interfaces);
 
diff --git a/drivers/net/qede/qede_rxtx.c b/drivers/net/qede/qede_rxtx.c
index 25e28fd9f6..86d7451aa7 100644
--- a/drivers/net/qede/qede_rxtx.c
+++ b/drivers/net/qede/qede_rxtx.c
@@ -1383,7 +1383,7 @@ qede_rx_process_tpa_end_cqe(struct qede_dev *qdev,
 					     cqe->len_list[0]);
 	/* Update total length and frags based on end TPA */
 	rx_mb = rxq->tpa_info[cqe->tpa_agg_index].tpa_head;
-	/* TODO:  Add Sanity Checks */
+	/* TODO:  Add more checks */
 	rx_mb->nb_segs = cqe->num_of_bds;
 	rx_mb->pkt_len = cqe->total_packet_len;
 
@@ -2211,7 +2211,7 @@ qede_xmit_prep_pkts(__rte_unused void *p_txq, struct rte_mbuf **tx_pkts,
 
 #ifdef RTE_LIBRTE_QEDE_DEBUG_TX
 static inline void
-qede_mpls_tunn_tx_sanity_check(struct rte_mbuf *mbuf,
+qede_mpls_tunn_tx_basic_check(struct rte_mbuf *mbuf,
 			       struct qede_tx_queue *txq)
 {
 	if (((mbuf->outer_l2_len + mbuf->outer_l3_len) / 2) > 0xff)
@@ -2473,7 +2473,7 @@ qede_xmit_pkts(void *p_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 						RTE_MBUF_F_TX_TUNNEL_MPLSINUDP) {
 				mplsoudp_flg = true;
 #ifdef RTE_LIBRTE_QEDE_DEBUG_TX
-				qede_mpls_tunn_tx_sanity_check(mbuf, txq);
+				qede_mpls_tunn_tx_basic_check(mbuf, txq);
 #endif
 				/* Outer L4 offset in two byte words */
 				tunn_l4_hdr_start_offset =
diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index 146bdc8e02..84ec45d3c7 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -34,7 +34,7 @@ struct ring_internal_args {
 	struct rte_ring * const *tx_queues;
 	const unsigned int nb_tx_queues;
 	const unsigned int numa_node;
-	void *addr; /* self addr for sanity check */
+	void *addr; /* self addr for verification */
 };
 
 enum dev_action {
@@ -612,10 +612,7 @@ static int parse_kvlist(const char *key __rte_unused,
 	*action = '\0';
 	action++;
 
-	/*
-	 * Need to do some sanity checking here
-	 */
-
+	/* Check the command argument is valid action */
 	if (strcmp(action, ETH_RING_ACTION_ATTACH) == 0)
 		info->list[info->count].action = DEV_ATTACH;
 	else if (strcmp(action, ETH_RING_ACTION_CREATE) == 0)
diff --git a/drivers/net/sfc/sfc_dp_rx.h b/drivers/net/sfc/sfc_dp_rx.h
index ed667c68d1..17ab10616b 100644
--- a/drivers/net/sfc/sfc_dp_rx.h
+++ b/drivers/net/sfc/sfc_dp_rx.h
@@ -59,7 +59,7 @@ struct sfc_dp_rx_qcreate_info {
 
 	/**
 	 * Maximum number of Rx descriptors completed in one Rx event.
-	 * Just for sanity checks if datapath would like to do.
+	 * Checks if datapath would like to do.
 	 */
 	unsigned int		batch_max;
 
diff --git a/drivers/net/txgbe/txgbe_ipsec.c b/drivers/net/txgbe/txgbe_ipsec.c
index 65b6c251c6..67ebfe317c 100644
--- a/drivers/net/txgbe/txgbe_ipsec.c
+++ b/drivers/net/txgbe/txgbe_ipsec.c
@@ -595,7 +595,7 @@ txgbe_crypto_enable_ipsec(struct rte_eth_dev *dev)
 	rx_offloads = dev->data->dev_conf.rxmode.offloads;
 	tx_offloads = dev->data->dev_conf.txmode.offloads;
 
-	/* sanity checks */
+	/* offload checks */
 	if (rx_offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO) {
 		PMD_DRV_LOG(ERR, "RSC and IPsec not supported");
 		return -1;
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 4e4b78fb43..2460739fee 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4280,7 +4280,7 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
 	uint32_t rdrxctl;
 	uint32_t rfctl;
 
-	/* Sanity check */
+	/* Offload check */
 	dev->dev_ops->dev_infos_get(dev, &dev_info);
 	if (dev_info.rx_offload_capa & RTE_ETH_RX_OFFLOAD_TCP_LRO)
 		rsc_capable = true;
-- 
2.47.2

