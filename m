Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5581CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 21:38:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B277140673;
	Thu, 28 May 2026 23:38:27 +0200 (CEST)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48]) by mails.dpdk.org (Postfix) with ESMTP id B0E1540666
 for <dev@dpdk.org>; Thu, 28 May 2026 23:38:24 +0200 (CEST)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-66039d3efcbso1907652d50.2
 for <dev@dpdk.org>; Thu, 28 May 2026 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780004304;
 x=1780609104; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVGVLG+Qk2+amo/FaMCncxXtXhcTH+EHYDvH5KUvErA=;
 b=eEX1x8JJWvj/lQdjqUMk2FU161lF6fonihj0aAPFU8zBw0yFNs4b9EGXt4b67oa3X+
 thvCjyP70PkfnPT7D0i3J0yIvCPzbupbpbsTNwMTwfrUSo1Bt4kSzPho78bkmJkiqM53
 UjWhrH2I446eq2DPbuoEk135/3TJ2inkfcj+zjx/57+SoYwCgKxuKY5aHO0/hyMocvkT
 KLDIFwDVc+0OInU9D5jfMFMUydedUVhDz6MC3cnw99y+5eQsndxS4HPpP3Jz4gSVX8TJ
 aP7krsBxFduEHEjFXr3Iep7q2jOfoHShkNtnhsFf6L50qYj05WrTSpMKqe5lzKUBFMh0
 itSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780004304; x=1780609104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QVGVLG+Qk2+amo/FaMCncxXtXhcTH+EHYDvH5KUvErA=;
 b=ZNXwW7q/swmoBYfbb0Hp8jlcPCZgsPmFiKmOWquWdU5mAAKAqng0EKwcjPF0B5VTfJ
 rv5FjpgfDdUTmWm1HsQfTcUlKWT8ZXJmrEP6kuWrG6321azjYZf170si+qXqYM9FPcV4
 cn1wOGSP0i48iKtP0Pt6YiwGxDQFyqcz2/wZE4m+ENMTqTUcp2mJ00dG6xVXHo28U23L
 xGLoomBoa+Y8K9YEONw+1D11JNhRxJ0k/EiHZ+Aj7IhiJ/x7jIyzusr4yntqYgq5J8ou
 l8h7Z8loXNpsFtLYLfx+JZSMALN6iNswIMbATKV/9W46Ta+WM/n4u3xGo3vHdDK9+In3
 CG8Q==
X-Gm-Message-State: AOJu0Yxpuw4cAIbjjgzZWDfz8dlQexyQ5odNVtXL52Ne3QPbnjUjLzLi
 2oEhapLP93gKb8pJmKZNXyhtj3srs/XZRq6ZCIohJ7WlqPfUytScZpi8u6QO+MwRRWr51gnn/z4
 A2/JR
X-Gm-Gg: Acq92OEn0EH1ZYUIkFsnKsA6CydSs8+q5xow14WMXPa7HBoevaRr++mAS+uPPl2LR6+
 +AbcxT1psdvlqsvZ2kdDQ9ZsS6sQBKwbJhwSdT/YDFbaYYjEU9HUKgCrJLC9GMwCWi7l50ubYAz
 EUJaLhyG8Af2clMGsidYHem+G664O+/xZbArLpW460uQn1B4kkT64jqn8TK7IYouKIDssXAaoKS
 vXsNdZrsHDvp3Pjz7widUtrdlV/hM8RSS52e9+iar465f9eWKvKfF83HFbIeqc0CFGJyZupChQw
 e89NJ56W4XYUTZOmhpgocycVIe+OQy+Hxvm95/nuqWZpG8D1G2ry/7MNwZuab324NbdtNPLhmK5
 pXyGjgD8+mdi9vvRqPZI62vo/KARdpnefofyijnrC5T2MegTDP33t0WYsFcOd/TCmkuL1xP4NLL
 LKy3p4mCKKr4ElrNUai4VSrM0v1y6NT8F5C3iMK4WvhApCQ4ADeB+zAlNSTmJZcjrO2igIzZqu
X-Received: by 2002:a05:690e:2583:b0:65e:5f1c:e330 with SMTP id
 956f58d0204a3-6604e727690mr488494d50.61.1780004303994; 
 Thu, 28 May 2026 14:38:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6604e12ea23sm208079d50.0.2026.05.28.14.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:38:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC 4/8] net/i40e: remove experimental FDIR API
Date: Thu, 28 May 2026 14:37:16 -0700
Message-ID: <20260528213816.562910-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528213816.562910-1-stephen@networkplumber.org>
References: <20260528213816.562910-1-stephen@networkplumber.org>
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

Remove the flow director related private APIs in i40e.

These APIs are experimental, therefore they can be removed
without deprecation warning.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/i40e/i40e_ethdev.c  |   4 +-
 drivers/net/intel/i40e/i40e_ethdev.h  |   4 -
 drivers/net/intel/i40e/i40e_fdir.c    | 140 --------------------------
 drivers/net/intel/i40e/i40e_flow.c    |   3 +-
 drivers/net/intel/i40e/rte_pmd_i40e.c |  34 -------
 drivers/net/intel/i40e/rte_pmd_i40e.h |  33 ------
 6 files changed, 3 insertions(+), 215 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index e818b6fc7c..207339cc8d 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -9309,8 +9309,8 @@ i40e_get_valid_input_set(enum i40e_filter_pctype pctype,
 	};
 
 	/**
-	 * Flow director supports only fields defined in
-	 * union rte_eth_fdir_flow.
+	 * Flow director supports only fields reachable through
+	 * rte_flow item patterns.
 	 */
 	static const uint64_t valid_fdir_inset_table[] = {
 		[I40E_FILTER_PCTYPE_FRAG_IPV4] =
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index d57c53f661..fecbd67f15 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1366,10 +1366,6 @@ enum i40e_filter_pctype
 uint16_t i40e_pctype_to_flowtype(const struct i40e_adapter *adapter,
 				 enum i40e_filter_pctype pctype);
 int i40e_dev_set_gre_key_len(struct i40e_hw *hw, uint8_t len);
-void i40e_fdir_info_get(struct rte_eth_dev *dev,
-			struct rte_eth_fdir_info *fdir);
-void i40e_fdir_stats_get(struct rte_eth_dev *dev,
-			 struct rte_eth_fdir_stats *stat);
 int i40e_select_filter_input_set(struct i40e_hw *hw,
 				 struct rte_eth_input_set_conf *conf,
 				 enum rte_filter_type filter);
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index ad256a5a11..c1acf389bf 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -1793,146 +1793,6 @@ i40e_fdir_flush(struct rte_eth_dev *dev)
 	return 0;
 }
 
-static inline void
-i40e_fdir_info_get_flex_set(struct i40e_pf *pf,
-			struct rte_eth_flex_payload_cfg *flex_set,
-			uint16_t *num)
-{
-	struct i40e_fdir_flex_pit *flex_pit;
-	struct rte_eth_flex_payload_cfg *ptr = flex_set;
-	uint16_t src, dst, size, j, k;
-	uint8_t i, layer_idx;
-
-	for (layer_idx = I40E_FLXPLD_L2_IDX;
-	     layer_idx <= I40E_FLXPLD_L4_IDX;
-	     layer_idx++) {
-		if (layer_idx == I40E_FLXPLD_L2_IDX)
-			ptr->type = RTE_ETH_L2_PAYLOAD;
-		else if (layer_idx == I40E_FLXPLD_L3_IDX)
-			ptr->type = RTE_ETH_L3_PAYLOAD;
-		else if (layer_idx == I40E_FLXPLD_L4_IDX)
-			ptr->type = RTE_ETH_L4_PAYLOAD;
-
-		for (i = 0; i < I40E_MAX_FLXPLD_FIED; i++) {
-			flex_pit = &pf->fdir.flex_set[layer_idx *
-				I40E_MAX_FLXPLD_FIED + i];
-			if (flex_pit->size == 0)
-				continue;
-			src = flex_pit->src_offset * sizeof(uint16_t);
-			dst = flex_pit->dst_offset * sizeof(uint16_t);
-			size = flex_pit->size * sizeof(uint16_t);
-			for (j = src, k = dst; j < src + size; j++, k++)
-				ptr->src_offset[k] = j;
-		}
-		(*num)++;
-		ptr++;
-	}
-}
-
-static inline void
-i40e_fdir_info_get_flex_mask(struct i40e_pf *pf,
-			struct rte_eth_fdir_flex_mask *flex_mask,
-			uint16_t *num)
-{
-	struct i40e_fdir_flex_mask *mask;
-	struct rte_eth_fdir_flex_mask *ptr = flex_mask;
-	uint16_t flow_type;
-	uint8_t i, j;
-	uint16_t off_bytes, mask_tmp;
-
-	for (i = I40E_FILTER_PCTYPE_NONF_IPV4_UDP;
-	     i <= I40E_FILTER_PCTYPE_L2_PAYLOAD;
-	     i++) {
-		mask =  &pf->fdir.flex_mask[i];
-		flow_type = i40e_pctype_to_flowtype(pf->adapter,
-						    (enum i40e_filter_pctype)i);
-		if (flow_type == RTE_ETH_FLOW_UNKNOWN)
-			continue;
-
-		for (j = 0; j < I40E_FDIR_MAX_FLEXWORD_NUM; j++) {
-			if (mask->word_mask & I40E_FLEX_WORD_MASK(j)) {
-				ptr->mask[j * sizeof(uint16_t)] = UINT8_MAX;
-				ptr->mask[j * sizeof(uint16_t) + 1] = UINT8_MAX;
-			} else {
-				ptr->mask[j * sizeof(uint16_t)] = 0x0;
-				ptr->mask[j * sizeof(uint16_t) + 1] = 0x0;
-			}
-		}
-		for (j = 0; j < I40E_FDIR_BITMASK_NUM_WORD; j++) {
-			off_bytes = mask->bitmask[j].offset * sizeof(uint16_t);
-			mask_tmp = ~mask->bitmask[j].mask;
-			ptr->mask[off_bytes] &= I40E_HI_BYTE(mask_tmp);
-			ptr->mask[off_bytes + 1] &= I40E_LO_BYTE(mask_tmp);
-		}
-		ptr->flow_type = flow_type;
-		ptr++;
-		(*num)++;
-	}
-}
-
-/*
- * i40e_fdir_info_get - get information of Flow Director
- * @pf: ethernet device to get info from
- * @fdir: a pointer to a structure of type *rte_eth_fdir_info* to be filled with
- *    the flow director information.
- */
-void
-i40e_fdir_info_get(struct rte_eth_dev *dev, struct rte_eth_fdir_info *fdir)
-{
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	uint16_t num_flex_set = 0;
-	uint16_t num_flex_mask = 0;
-	uint16_t i;
-
-	fdir->mode = RTE_FDIR_MODE_NONE;
-
-	fdir->guarant_spc =
-		(uint32_t)hw->func_caps.fd_filters_guaranteed;
-	fdir->best_spc =
-		(uint32_t)hw->func_caps.fd_filters_best_effort;
-	fdir->max_flexpayload = I40E_FDIR_MAX_FLEX_LEN;
-	fdir->flow_types_mask[0] = I40E_FDIR_FLOWS;
-	for (i = 1; i < RTE_FLOW_MASK_ARRAY_SIZE; i++)
-		fdir->flow_types_mask[i] = 0ULL;
-	fdir->flex_payload_unit = sizeof(uint16_t);
-	fdir->flex_bitmask_unit = sizeof(uint16_t);
-	fdir->max_flex_payload_segment_num = I40E_MAX_FLXPLD_FIED;
-	fdir->flex_payload_limit = I40E_MAX_FLX_SOURCE_OFF;
-	fdir->max_flex_bitmask_num = I40E_FDIR_BITMASK_NUM_WORD;
-
-	i40e_fdir_info_get_flex_set(pf,
-				fdir->flex_conf.flex_set,
-				&num_flex_set);
-	i40e_fdir_info_get_flex_mask(pf,
-				fdir->flex_conf.flex_mask,
-				&num_flex_mask);
-
-	fdir->flex_conf.nb_payloads = num_flex_set;
-	fdir->flex_conf.nb_flexmasks = num_flex_mask;
-}
-
-/*
- * i40e_fdir_stat_get - get statistics of Flow Director
- * @pf: ethernet device to get info from
- * @stat: a pointer to a structure of type *rte_eth_fdir_stats* to be filled with
- *    the flow director statistics.
- */
-void
-i40e_fdir_stats_get(struct rte_eth_dev *dev, struct rte_eth_fdir_stats *stat)
-{
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	uint32_t fdstat;
-
-	fdstat = I40E_READ_REG(hw, I40E_PFQF_FDSTAT);
-	stat->guarant_cnt =
-		(uint32_t)((fdstat & I40E_PFQF_FDSTAT_GUARANT_CNT_MASK) >>
-			    I40E_PFQF_FDSTAT_GUARANT_CNT_SHIFT);
-	stat->best_cnt =
-		(uint32_t)((fdstat & I40E_PFQF_FDSTAT_BEST_CNT_MASK) >>
-			    I40E_PFQF_FDSTAT_BEST_CNT_SHIFT);
-}
 
 /* Restore flow director filter */
 void
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index c8eaa2b2e5..1ebc3e8fef 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -2461,8 +2461,7 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 
 			for (i = 0; i < raw_spec->length; i++) {
 				j = i + next_dst_off;
-				if (j >= RTE_ETH_FDIR_MAX_FLEXLEN ||
-						j >= I40E_FDIR_MAX_FLEX_LEN)
+				if (j >= I40E_FDIR_MAX_FLEX_LEN)
 					break;
 				filter->input.flow_ext.flexbytes[j] =
 					raw_spec->pattern[i];
diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.c b/drivers/net/intel/i40e/rte_pmd_i40e.c
index 2e7943ef8b..e47c1aa9d7 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.c
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.c
@@ -3219,40 +3219,6 @@ rte_pmd_i40e_inset_set(uint16_t port, uint8_t pctype,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_get_fdir_info, 20.08)
-int
-rte_pmd_i40e_get_fdir_info(uint16_t port, struct rte_eth_fdir_info *fdir_info)
-{
-	struct rte_eth_dev *dev;
-
-	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
-
-	dev = &rte_eth_devices[port];
-	if (!is_i40e_supported(dev))
-		return -ENOTSUP;
-
-	i40e_fdir_info_get(dev, fdir_info);
-
-	return 0;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_get_fdir_stats, 20.08)
-int
-rte_pmd_i40e_get_fdir_stats(uint16_t port, struct rte_eth_fdir_stats *fdir_stat)
-{
-	struct rte_eth_dev *dev;
-
-	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
-
-	dev = &rte_eth_devices[port];
-	if (!is_i40e_supported(dev))
-		return -ENOTSUP;
-
-	i40e_fdir_stats_get(dev, fdir_stat);
-
-	return 0;
-}
-
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_set_gre_key_len, 20.08)
 int
 rte_pmd_i40e_set_gre_key_len(uint16_t port, uint8_t len)
diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.h b/drivers/net/intel/i40e/rte_pmd_i40e.h
index 5dcca91264..097ff4b58d 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.h
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.h
@@ -1145,39 +1145,6 @@ rte_pmd_i40e_inset_field_clear(uint64_t *inset, uint8_t field_idx)
 	return 0;
 }
 
-/**
- * Get port fdir info
- *
- * @param port
- *   The port identifier of the Ethernet device.
- * @param fdir_info
- *   The fdir info of the port
- * @return
- *   - (0) if successful.
- *   - (-ENODEV) if *port* invalid.
- *   - (-ENOTSUP) if operation not supported.
- */
-__rte_experimental
-int
-rte_pmd_i40e_get_fdir_info(uint16_t port, struct rte_eth_fdir_info *fdir_info);
-
-/**
- * Get port fdir status
- *
- * @param port
- *   The port identifier of the Ethernet device.
- * @param fdir_stat
- *   The fdir status of the port
- * @return
- *   - (0) if successful.
- *   - (-ENODEV) if *port* invalid.
- *   - (-ENOTSUP) if operation not supported.
- */
-__rte_experimental
-int
-rte_pmd_i40e_get_fdir_stats(uint16_t port,
-			    struct rte_eth_fdir_stats *fdir_stat);
-
 /**
  * Set GRE key length
  *
-- 
2.53.0

