Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A667C55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:19:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAF7740616;
	Sun,  2 Aug 2026 20:18:49 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 3D033402D2
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:43 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38e347638adso3108348a91.0
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694722;
 x=1786299522; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T0X2dyER+inL3cyVQ9o0HewOFzlQGmv+yzyMC13S/7g=;
 b=LXbcZ8zIjpuNUw6xEQhXThPb0AYUhDxSaWQ1swG9vSnkdJgBfy1ylwvHG45YdyIPBH
 xphvwB/hOEdv3r2jvHim7LUsBhoDXAmVtKIgdAzeZfmazBXXipRQePKoorAQ6ZIHjzTD
 C/P8wLZwIuit8A0pA5k58RxO3qq4WlBozyLGUcJ1PXHyuNSrUp/ovTDSNHti746/N47e
 oFBiFMxXGSLXqWbTlikWLrRwvvs73eHbGO4fK2aTnecJNNgYtNJ3Urm42GJHaSugDgw1
 Ru/YcNH2thOJZDKHQ7Pmq2IvkTOap4hJIXGwCC7mXW0Lvmlf6lVbQmlWx7Nk9W+uBlpR
 Pe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694722; x=1786299522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T0X2dyER+inL3cyVQ9o0HewOFzlQGmv+yzyMC13S/7g=;
 b=ejYoCbX5KHut1/lfFMzf6JzWwCh6m3i5TjCyQd2K+sC2GKe9iig5UVnqViPJH5jtY5
 Wb1y5qElqc+KhyB3tNc/mJLpThAi3hX9S7mBX2k7MOPITYVacDNn5yb51ZMwhTFTUSwq
 uAZO9M23OzEpYOiHYqcXKQJc7eorhi8GpUhVCpXIFKAw7KEaG+TbycktEQpVZwci9mEG
 dyGdoOsWYh1BSoErd5NpBPKEjBVNxWZterLZgps3gguExOaJKhfxZIGaZvAm6d9DO5P7
 yJbNpfX0QKBz2xOI/22MjyWWW7FCAlBT1zq2V9w5g8XMbdU+hWiofrxvVMfMScE46h+D
 DPtw==
X-Gm-Message-State: AOJu0YxwdmoIj0jOMs2BFiSw6Y1tXbVPbvBGU546JVVZjew5Kq2zMY51
 JilF4ZUA/Gnqt9+AmCkWanLlMlm6ynlc0nekAlduE9OPdW8SwDYxS33ZJfBKjK7zUTEdCYy1QlR
 bUn4y
X-Gm-Gg: AR+sD10b1YKXj/a9CONbI9lAxUKiK/RRu2MBvssyujGpNGTx92aSrijQm5dwYYDGBBV
 3BV77JNhZp4fEUrAnmiERo/qP0re40n0vxHcftcgZPWrA1Ey/TGUNcY18d7PkSuVKu1TyCZBT/H
 ASEd5JRu5GwYqocYTBd8Zd5dEvMsnQHYlu7FUXQl3Eiiee6z1xTxKtdEXmA76dtVP5rQ1LHeqEo
 JTvKkxV4ZN9INK2McBPiorDm/4nyFpg1sNbtfJum+teh2P1WIjzWk/2dsSQGzcupFp9FkuTV4KL
 n8YzYG5aKcQdeVZYepht1KStcIP+RLJIIo6vKtNh1Njy5YldExk0ENM6CeGyyTiG4hrIBTvh+yF
 3a0QyTvsgeg5GkKXj4lKTg0vKnr+oNHOdzUqGA8iyNPKZ4lmsYQrmGrelL/0GpgEMKvDGA+/13J
 OZJnMyKu3ANE0O8xs45VWgR4tjyznB2ERGocYXecuNYrtQNLq4gf6a+mCuCvgLEAtapBTC5xyCR
 yAG2OZgHV92G2dKBMMRB2PsO1A=
X-Received: by 2002:a17:90b:17c7:b0:38f:1dc:672f with SMTP id
 98e67ed59e1d1-38fbc497f62mr6587888a91.18.1785694722282; 
 Sun, 02 Aug 2026 11:18:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC 04/21] net/i40e: remove experimental FDIR API
Date: Sun,  2 Aug 2026 11:15:09 -0700
Message-ID: <20260802181835.476887-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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
index b6b2d291ee..5cbdfe9db2 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -9335,8 +9335,8 @@ i40e_get_valid_input_set(enum i40e_filter_pctype pctype,
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
index 9d9bde6aeb..3968bfd267 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1369,10 +1369,6 @@ enum i40e_filter_pctype
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
index 8a233f8a97..f36eceab3a 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -1800,146 +1800,6 @@ i40e_fdir_flush(struct rte_eth_dev *dev)
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
index 6eb85a7d0d..e9993db6dd 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -2391,8 +2391,7 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 
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
index 5af7e2330f..34900f9bec 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.h
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.h
@@ -1067,39 +1067,6 @@ rte_pmd_i40e_inset_field_clear(uint64_t *inset, uint8_t field_idx)
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

