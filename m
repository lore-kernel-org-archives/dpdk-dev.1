Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BED7C5B572
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:20:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F24940613;
	Fri, 14 Aug 2026 22:20:21 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id DDB3A4013F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:20:20 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so1505029a91.1
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738820;
 x=1787343620; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kIETiDZmYfNKOnqQt18UTuCxXQxMEc3jkmjwXnWpa6g=;
 b=tVVDVD9rfSVnePEtGYZj9ShQzfwy/Z/1pv2vWGZmIgaPwR920PO/rMCXc5fvPK6b4S
 SwMtrWH9RlcFLXeXrchhQWCSYfq1VrrrMNSOVMP0ovLnOOeS1qXJ1cQRheo1JbCwzMOv
 idRUx28JS/LvwOvs3LPbQ0HFl3+wIv3/VJgAEKDmmi+bBkarUcbYG7D699ZLFReOGv/Q
 8zWqEoWRuwW+9OBCaZaYW0OhFKOqvFRHPkR5uZC4GuiloJT9vt9aqmRMf+ra66A4f6Mw
 L7b+EiuZYY7bQw1p2SfH6y0s5ggaehNruMqgJMc9hhccOfhHOiAT0bZnZ1aOXG5IF5sG
 6GbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738820; x=1787343620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kIETiDZmYfNKOnqQt18UTuCxXQxMEc3jkmjwXnWpa6g=;
 b=YjgkmKXXrJrOfGo9DtgrvXWgkXKBFAjIBLvZmuyHb93frlfSF4IqDGYhjdyZ9KgRN1
 MQgD09m+40iPMPYjWKTjLjuFkF1rI7oD9Fxhi8qCHFsxW6fmpsZCDGScObHhKXq6jMVZ
 nefJrEuwtThTSwnMdroOaHYYQUuIBs2L56HDG28lB09Xui1Ak9CL5K08FeQ3sYOn5+ic
 hNq0FUuDC610oxHuMqxRb89l4Hnmnu1F2gtg+OQ0sfiWuwLCiDoGb9jt4G776ktjU2MZ
 Rjt0xfA9QqZ7vkZsaUGbxbuQNzqtcnfjxEE5obA5ihaB3xd1bRZm5Az9n/wucRJWaoKp
 pJOw==
X-Gm-Message-State: AOJu0Yxkx/jPr+Q7ZrHLoogFxEnFpgl9q1WnHptP1UR/F9E+kFOx2k1M
 iWsPshRMkNaNsVIKuYCq7eTfaCERQNE2015a0zUC9kHN0UYcfQB/Vw8InA7i4/4hlgjI+Iw18/A
 Wfwu6
X-Gm-Gg: AR+sD11BN2FTJU7Ecuzpi6rBVFF6j2mDIIaL6etl05ij+SOVlnjHu4uEBPSkS6m+gi4
 vaTfmXtEIhxLbzfsD8+o1Eiq6930JjADxPaxj8tWh0pwGK4WoGxwHz+Elk+zFQAO/Q5mgt3Sg6U
 zJZkV/Xj2oTKGHtQkRgWN/FZYP77eKgaRjY+PYrO8i0vjjB84QTTA2vL2bySYeUCSICtd9eFtDa
 XhR+zObDzTnqnlQKF0VWFbIj2N1VsYZ5CPnaUO5nY8VgMMwvKRyXT7SEnX4c7vQ6Pojjf5GlVbh
 ULbzgiEpIlsv0t2DPMB7wHQ/kP20bDKD5v4wuwTRVE8sjL7m5pyWkqtJqa2S0vK/dQrjQsR27XM
 MINIub6A9sJH2QeNHMe1gB7dhGyX64e7Pmgc4SaHH6CtlVpJKX93jX6+01Sr3ik5moXdMReIL/Q
 B52FrHPFcbfccP27mpfxhGJpD/xuZVyRwkePIUBYdeLyC4USIc+v8yX8DgoaFP3d3azcHM2Bp3M
 Uv0JKwcwNdOqijw574mL7VQpf8=
X-Received: by 2002:a17:90b:3904:b0:380:9f17:6df3 with SMTP id
 98e67ed59e1d1-3933b785b36mr8980429a91.4.1786738819890; 
 Fri, 14 Aug 2026 13:20:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:20:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 07/16] net/ixgbe: remove queue stats mapping
Date: Fri, 14 Aug 2026 12:46:03 -0700
Message-ID: <20260814194757.329424-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814194757.329424-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260814194757.329424-1-stephen@networkplumber.org>
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

The support for queue_stats_map has been deprecated since 25.11.
Remove support for queue mapping in ixgbe driver.

Keep the existing queue stats mapping that happens on device
initialization.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 98 +-------------------------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  9 ---
 2 files changed, 2 insertions(+), 105 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index c5010f623c..5945dd047d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -182,10 +182,6 @@ static int ixgbe_dev_xstats_get_names_by_id(
 	const uint64_t *ids,
 	struct rte_eth_xstat_name *xstats_names,
 	unsigned int limit);
-static int ixgbe_dev_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
-					     uint16_t queue_id,
-					     uint8_t stat_idx,
-					     uint8_t is_rx);
 static int ixgbe_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
 				 size_t fw_size);
 static int ixgbe_dev_info_get(struct rte_eth_dev *dev,
@@ -511,7 +507,6 @@ static const struct eth_dev_ops ixgbe_eth_dev_ops = {
 	.xstats_reset         = ixgbe_dev_xstats_reset,
 	.xstats_get_names     = ixgbe_dev_xstats_get_names,
 	.xstats_get_names_by_id = ixgbe_dev_xstats_get_names_by_id,
-	.queue_stats_mapping_set = ixgbe_dev_queue_stats_mapping_set,
 	.fw_version_get       = ixgbe_fw_version_get,
 	.dev_infos_get        = ixgbe_dev_info_get,
 	.dev_supported_ptypes_get = ixgbe_dev_supported_ptypes_get,
@@ -886,96 +881,6 @@ ixgbe_reset_qstat_mappings(struct ixgbe_hw *hw)
 	}
 }
 
-
-static int
-ixgbe_dev_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
-				  uint16_t queue_id,
-				  uint8_t stat_idx,
-				  uint8_t is_rx)
-{
-#define QSM_REG_NB_BITS_PER_QMAP_FIELD 8
-#define NB_QMAP_FIELDS_PER_QSM_REG 4
-#define QMAP_FIELD_RESERVED_BITS_MASK 0x0f
-
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
-	struct ixgbe_stat_mapping_registers *stat_mappings =
-		IXGBE_DEV_PRIVATE_TO_STAT_MAPPINGS(eth_dev->data->dev_private);
-	uint32_t qsmr_mask = 0;
-	uint32_t clearing_mask = QMAP_FIELD_RESERVED_BITS_MASK;
-	uint32_t q_map;
-	uint8_t n, offset;
-
-	if ((hw->mac.type != ixgbe_mac_82599EB) &&
-		(hw->mac.type != ixgbe_mac_X540) &&
-		(hw->mac.type != ixgbe_mac_X550) &&
-		(hw->mac.type != ixgbe_mac_X550EM_x) &&
-		(hw->mac.type != ixgbe_mac_X550EM_a) &&
-		(hw->mac.type != ixgbe_mac_E610))
-		return -ENOSYS;
-
-	PMD_INIT_LOG(DEBUG, "Setting port %d, %s queue_id %d to stat index %d",
-		     (int)(eth_dev->data->port_id), is_rx ? "RX" : "TX",
-		     queue_id, stat_idx);
-
-	n = (uint8_t)(queue_id / NB_QMAP_FIELDS_PER_QSM_REG);
-	if (n >= IXGBE_NB_STAT_MAPPING_REGS) {
-		PMD_INIT_LOG(ERR, "Nb of stat mapping registers exceeded");
-		return -EIO;
-	}
-	offset = (uint8_t)(queue_id % NB_QMAP_FIELDS_PER_QSM_REG);
-
-	/* Now clear any previous stat_idx set */
-	clearing_mask <<= (QSM_REG_NB_BITS_PER_QMAP_FIELD * offset);
-	if (!is_rx)
-		stat_mappings->tqsm[n] &= ~clearing_mask;
-	else
-		stat_mappings->rqsmr[n] &= ~clearing_mask;
-
-	q_map = (uint32_t)stat_idx;
-	q_map &= QMAP_FIELD_RESERVED_BITS_MASK;
-	qsmr_mask = q_map << (QSM_REG_NB_BITS_PER_QMAP_FIELD * offset);
-	if (!is_rx)
-		stat_mappings->tqsm[n] |= qsmr_mask;
-	else
-		stat_mappings->rqsmr[n] |= qsmr_mask;
-
-	PMD_INIT_LOG(DEBUG, "Set port %d, %s queue_id %d to stat index %d",
-		     (int)(eth_dev->data->port_id), is_rx ? "RX" : "TX",
-		     queue_id, stat_idx);
-	PMD_INIT_LOG(DEBUG, "%s[%d] = 0x%08x", is_rx ? "RQSMR" : "TQSM", n,
-		     is_rx ? stat_mappings->rqsmr[n] : stat_mappings->tqsm[n]);
-
-	/* Now write the mapping in the appropriate register */
-	if (is_rx) {
-		PMD_INIT_LOG(DEBUG, "Write 0x%x to RX IXGBE stat mapping reg:%d",
-			     stat_mappings->rqsmr[n], n);
-		IXGBE_WRITE_REG(hw, IXGBE_RQSMR(n), stat_mappings->rqsmr[n]);
-	} else {
-		PMD_INIT_LOG(DEBUG, "Write 0x%x to TX IXGBE stat mapping reg:%d",
-			     stat_mappings->tqsm[n], n);
-		IXGBE_WRITE_REG(hw, IXGBE_TQSM(n), stat_mappings->tqsm[n]);
-	}
-	return 0;
-}
-
-static void
-ixgbe_restore_statistics_mapping(struct rte_eth_dev *dev)
-{
-	struct ixgbe_stat_mapping_registers *stat_mappings =
-		IXGBE_DEV_PRIVATE_TO_STAT_MAPPINGS(dev->data->dev_private);
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	int i;
-
-	/* write whatever was in stat mapping table to the NIC */
-	for (i = 0; i < IXGBE_NB_STAT_MAPPING_REGS; i++) {
-		/* rx */
-		IXGBE_WRITE_REG(hw, IXGBE_RQSMR(i), stat_mappings->rqsmr[i]);
-
-		/* tx */
-		IXGBE_WRITE_REG(hw, IXGBE_TQSM(i), stat_mappings->tqsm[i]);
-	}
-}
-
 static void
 ixgbe_dcb_init(struct ixgbe_hw *hw, struct ixgbe_dcb_config *dcb_config)
 {
@@ -2742,7 +2647,8 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 						RTE_BIT64(idx));
 	}
 
-	ixgbe_restore_statistics_mapping(dev);
+	/* reprogram queue stats mapping, which are cleared on reset */
+	ixgbe_reset_qstat_mappings(hw);
 
 	err = ixgbe_flow_ctrl_enable(dev, hw);
 	if (err < 0) {
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 5d3243cb4d..ba826b6d8d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -216,11 +216,6 @@ struct ixgbe_interrupt {
 	uint32_t mask_original;
 };
 
-struct ixgbe_stat_mapping_registers {
-	uint32_t tqsm[IXGBE_NB_STAT_MAPPING_REGS];
-	uint32_t rqsmr[IXGBE_NB_STAT_MAPPING_REGS];
-};
-
 struct ixgbe_vfta {
 	uint32_t vfta[IXGBE_VFTA_SIZE];
 };
@@ -471,7 +466,6 @@ struct ixgbe_adapter {
 	struct rte_eth_fdir_conf    fdir_conf;
 	struct ixgbe_hw_fdir_info   fdir;
 	struct ixgbe_interrupt      intr;
-	struct ixgbe_stat_mapping_registers stat_mappings;
 	struct ixgbe_vfta           shadow_vfta;
 	struct ixgbe_hwstrip		hwstrip;
 	struct ixgbe_dcb_config     dcb_config;
@@ -546,9 +540,6 @@ uint16_t ixgbe_vf_representor_tx_burst(void *tx_queue, struct rte_mbuf **tx_pkts
 #define IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter) \
 	(&((struct ixgbe_adapter *)adapter)->fdir)
 
-#define IXGBE_DEV_PRIVATE_TO_STAT_MAPPINGS(adapter) \
-	(&((struct ixgbe_adapter *)adapter)->stat_mappings)
-
 #define IXGBE_DEV_PRIVATE_TO_VFTA(adapter) \
 	(&((struct ixgbe_adapter *)adapter)->shadow_vfta)
 
-- 
2.53.0

