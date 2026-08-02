Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300B4C55162
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:18:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43AF44064F;
	Sun,  2 Aug 2026 20:18:47 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 176A7402D2
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:42 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cbe431467e6so741542a12.1
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694721;
 x=1786299521; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q0NnmNfDyygJVYE3yMXSqR1/51lL3n20fFyqA8YDGl4=;
 b=ba1dt5JF3hWn9+MbUgx8XaXBVfwhRY8uBvopy2BpCACb1TL3VeRqdfyej1hMGS5giy
 k3UJLSyWQGCHufUSndmWRhA5JibOuxnBnSt/IzzE/2Rbp/rhgESW9tuDpWIT0VS1oUvv
 Jql6AkrWDoThPeYaZ76yT/WkulvPQRSsl4DET+MO/Et+LAM9nO496ytF1sGotNO4lZUo
 0jbLEM0Z9lNJnZY/kzuSsr2Njr1MC4uuJJ0i+ol0kmBH9hWvfchLiq9CL9K9jpcZMDP/
 pwpEF4mlgQwCJkL6t6ql0WmzCU2QcS1myOPWzodIDGjItC1UFwwFun57la12DZUWyeQT
 OyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694721; x=1786299521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q0NnmNfDyygJVYE3yMXSqR1/51lL3n20fFyqA8YDGl4=;
 b=glm2PzhYZ98PSoR2k0X5cH52s/iFbyZpl7uPY7Ex+SCc10wXu67YfaJhtqsYCwam8D
 +cdhKpMgZz+ea6/c7X3ht4zijFWQa3E3tNQpGliyRFfwBtSlAuzpqroKaOeUCM627lqf
 iv4rGhuo56FU8mZMZt9Wk56rT2glH25f6Uw2CZi+QpnNarLwzudWxmh32VJpbEhdJNDu
 FHXhnAVYzJy4QhhNBbThqW+lFYm6ZCj9LAfN4NJM+hhBoRt9ckmdtdshITp6brdqHh/1
 jYxBL8q6Us9SRrMVzS53MGysE8zDR49b6DvrPN/j8Jev93G3zJd5v+SpxGSGx1OmMquN
 /N8Q==
X-Gm-Message-State: AOJu0YzaC2iVNqvE7PzGjtxccPg5FZIHscC91x2AWI8R9Raileavb8Lq
 0gvCArgmD7SyykUPIUXAj7Sr+XDRaMqeeDGpV65NfuOypT1Xk+Y/prJ0F68owe7DlTdIwEqkr5n
 ZoIxs
X-Gm-Gg: AR+sD103HWwPb3kADRPBrs6M54qG47zBE0oaGTgi0UNS3KJVklzAjeXZBgBJuIJAbSg
 My61W12HnvbYXwd1XOCiALT3Q7Xxq5/WJa5uA7Bv4sYOgbynULw+Bg+GPLagvGyX8KOhFir6NZq
 RxMLR0/mHcc4maOWchwwW5ZShnMjBhEGOQHLK2HVzZWEWWsvDoDB7MQlgqi/J1Anx3G3H+ay9aU
 kdwrr5Wj/vGFo8mAdXdc7TV5AIbigBiZ13TIExxeg1wDJDOTUH5wWGFPO3HzSO/+fTSQbHTtEcs
 YoA/Oppj3JZ4XucBwEojx16kbs+xJA+w1rgmCbpJdDP9V95XsVCjNfO7175hxEUcqRZxC+76kSJ
 yCXyyOQCndb/pJAreGd0jUZCzvGfOqrRXgv7rLnoG0dS8fttOH5DbwFbnBcTuWHuUWRiSW/dZ1i
 udZz3OOTx7kIhu6J7ylJAWiQWk+1QsWDjLh+RN3uoKA8zGRsBmH74cqBF5zvlCpeGCnjSR13iSt
 sYz2Pa3BbsNxPDp5MtwoRP9k/U=
X-Received: by 2002:a05:6a20:d510:b0:3c6:61c6:8971 with SMTP id
 adf61e73a8af0-3c91aa16314mr11043224637.39.1785694721180; 
 Sun, 02 Aug 2026 11:18:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC 03/21] net/ixgbe: remove experimental FDIR API
Date: Sun,  2 Aug 2026 11:15:08 -0700
Message-ID: <20260802181835.476887-4-stephen@networkplumber.org>
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

Remove the flow director related private APIs in ixgbe.

These APIs are experimental therefore they can be removed
without deprecation warning.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.h  |   5 -
 drivers/net/intel/ixgbe/ixgbe_fdir.c    | 117 ------------------------
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c |  34 -------
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.h |  32 -------
 4 files changed, 188 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 5d3243cb4d..c290f04611 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -717,11 +717,6 @@ int ixgbe_fdir_filter_program(struct ixgbe_adapter *adapter,
 		struct rte_eth_fdir_conf *fdir_conf,
 		struct ixgbe_fdir_rule *rule,
 		bool del, bool update);
-void ixgbe_fdir_info_get(struct rte_eth_dev *dev,
-			 struct rte_eth_fdir_info *fdir_info);
-void ixgbe_fdir_stats_get(struct rte_eth_dev *dev,
-			  struct rte_eth_fdir_stats *fdir_stats);
-
 void ixgbe_configure_dcb(struct rte_eth_dev *dev);
 
 int
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index b32dc54287..20cc72ffcd 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -1202,123 +1202,6 @@ ixgbe_fdir_flush(struct rte_eth_dev *dev)
 	return ret;
 }
 
-#define FDIRENTRIES_NUM_SHIFT 10
-void
-ixgbe_fdir_info_get(struct rte_eth_dev *dev, struct rte_eth_fdir_info *fdir_info)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-	struct ixgbe_hw_fdir_info *info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-	uint32_t fdirctrl, max_num;
-	uint8_t offset;
-
-	fdirctrl = IXGBE_READ_REG(hw, IXGBE_FDIRCTRL);
-	offset = ((fdirctrl & IXGBE_FDIRCTRL_FLEX_MASK) >>
-			IXGBE_FDIRCTRL_FLEX_SHIFT) * sizeof(uint16_t);
-
-	fdir_info->mode = fdir_conf->mode;
-	max_num = (1 << (FDIRENTRIES_NUM_SHIFT +
-			(fdirctrl & FDIRCTRL_PBALLOC_MASK)));
-	if (fdir_info->mode >= RTE_FDIR_MODE_PERFECT &&
-	    fdir_info->mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
-		fdir_info->guarant_spc = max_num;
-	else if (fdir_info->mode == RTE_FDIR_MODE_SIGNATURE)
-		fdir_info->guarant_spc = max_num * 4;
-
-	fdir_info->mask.vlan_tci_mask = info->mask.vlan_tci_mask;
-	fdir_info->mask.ipv4_mask.src_ip = info->mask.src_ipv4_mask;
-	fdir_info->mask.ipv4_mask.dst_ip = info->mask.dst_ipv4_mask;
-	IPV6_MASK_TO_ADDR(info->mask.src_ipv6_mask,
-			fdir_info->mask.ipv6_mask.src_ip);
-	IPV6_MASK_TO_ADDR(info->mask.dst_ipv6_mask,
-			fdir_info->mask.ipv6_mask.dst_ip);
-	fdir_info->mask.src_port_mask = info->mask.src_port_mask;
-	fdir_info->mask.dst_port_mask = info->mask.dst_port_mask;
-	fdir_info->mask.mac_addr_byte_mask = info->mask.mac_addr_byte_mask;
-	fdir_info->mask.tunnel_id_mask = info->mask.tunnel_id_mask;
-	fdir_info->mask.tunnel_type_mask = info->mask.tunnel_type_mask;
-	fdir_info->max_flexpayload = IXGBE_FDIR_MAX_FLEX_LEN;
-
-	if (fdir_info->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN ||
-	    fdir_info->mode == RTE_FDIR_MODE_PERFECT_TUNNEL)
-		fdir_info->flow_types_mask[0] = 0ULL;
-	else
-		fdir_info->flow_types_mask[0] = IXGBE_FDIR_FLOW_TYPES;
-	for (uint32_t i = 1; i < RTE_FLOW_MASK_ARRAY_SIZE; i++)
-		fdir_info->flow_types_mask[i] = 0ULL;
-
-	fdir_info->flex_payload_unit = sizeof(uint16_t);
-	fdir_info->max_flex_payload_segment_num = 1;
-	fdir_info->flex_payload_limit = IXGBE_MAX_FLX_SOURCE_OFF;
-	fdir_info->flex_conf.nb_payloads = 1;
-	fdir_info->flex_conf.flex_set[0].type = RTE_ETH_RAW_PAYLOAD;
-	fdir_info->flex_conf.flex_set[0].src_offset[0] = offset;
-	fdir_info->flex_conf.flex_set[0].src_offset[1] = offset + 1;
-	fdir_info->flex_conf.nb_flexmasks = 1;
-	fdir_info->flex_conf.flex_mask[0].flow_type = RTE_ETH_FLOW_UNKNOWN;
-	fdir_info->flex_conf.flex_mask[0].mask[0] =
-			(uint8_t)(info->mask.flex_bytes_mask & 0x00FF);
-	fdir_info->flex_conf.flex_mask[0].mask[1] =
-			(uint8_t)((info->mask.flex_bytes_mask & 0xFF00) >> 8);
-}
-
-void
-ixgbe_fdir_stats_get(struct rte_eth_dev *dev, struct rte_eth_fdir_stats *fdir_stats)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-	struct ixgbe_hw_fdir_info *info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-	uint32_t reg, max_num;
-	enum rte_fdir_mode fdir_mode = fdir_conf->mode;
-
-	/* Get the information from registers */
-	reg = IXGBE_READ_REG(hw, IXGBE_FDIRFREE);
-	info->collision = (uint16_t)((reg & IXGBE_FDIRFREE_COLL_MASK) >>
-				     IXGBE_FDIRFREE_COLL_SHIFT);
-	info->free = (uint16_t)((reg & IXGBE_FDIRFREE_FREE_MASK) >>
-				IXGBE_FDIRFREE_FREE_SHIFT);
-
-	reg = IXGBE_READ_REG(hw, IXGBE_FDIRLEN);
-	info->maxhash = (uint16_t)((reg & IXGBE_FDIRLEN_MAXHASH_MASK) >>
-				   IXGBE_FDIRLEN_MAXHASH_SHIFT);
-	info->maxlen  = (uint8_t)((reg & IXGBE_FDIRLEN_MAXLEN_MASK) >>
-				  IXGBE_FDIRLEN_MAXLEN_SHIFT);
-
-	reg = IXGBE_READ_REG(hw, IXGBE_FDIRUSTAT);
-	info->remove += (reg & IXGBE_FDIRUSTAT_REMOVE_MASK) >>
-		IXGBE_FDIRUSTAT_REMOVE_SHIFT;
-	info->add += (reg & IXGBE_FDIRUSTAT_ADD_MASK) >>
-		IXGBE_FDIRUSTAT_ADD_SHIFT;
-
-	reg = IXGBE_READ_REG(hw, IXGBE_FDIRFSTAT) & 0xFFFF;
-	info->f_remove += (reg & IXGBE_FDIRFSTAT_FREMOVE_MASK) >>
-		IXGBE_FDIRFSTAT_FREMOVE_SHIFT;
-	info->f_add += (reg & IXGBE_FDIRFSTAT_FADD_MASK) >>
-		IXGBE_FDIRFSTAT_FADD_SHIFT;
-
-	/*  Copy the new information in the fdir parameter */
-	fdir_stats->collision = info->collision;
-	fdir_stats->free = info->free;
-	fdir_stats->maxhash = info->maxhash;
-	fdir_stats->maxlen = info->maxlen;
-	fdir_stats->remove = info->remove;
-	fdir_stats->add = info->add;
-	fdir_stats->f_remove = info->f_remove;
-	fdir_stats->f_add = info->f_add;
-
-	reg = IXGBE_READ_REG(hw, IXGBE_FDIRCTRL);
-	max_num = (1 << (FDIRENTRIES_NUM_SHIFT +
-			 (reg & FDIRCTRL_PBALLOC_MASK)));
-	if (fdir_mode >= RTE_FDIR_MODE_PERFECT &&
-	    fdir_mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
-		fdir_stats->guarant_cnt = max_num - fdir_stats->free;
-	else if (fdir_mode == RTE_FDIR_MODE_SIGNATURE)
-		fdir_stats->guarant_cnt = max_num * 4 - fdir_stats->free;
-
-}
-
 /* restore flow director filter */
 void
 ixgbe_fdir_filter_restore(struct rte_eth_dev *dev)
diff --git a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
index f816fa3173..e0dff9cd73 100644
--- a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
+++ b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
@@ -1176,37 +1176,3 @@ rte_pmd_ixgbe_mdio_unlocked_write(uint16_t port, uint32_t reg_addr,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ixgbe_get_fdir_info, 20.08)
-int
-rte_pmd_ixgbe_get_fdir_info(uint16_t port, struct rte_eth_fdir_info *fdir_info)
-{
-	struct rte_eth_dev *dev;
-
-	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
-
-	dev = &rte_eth_devices[port];
-	if (!is_ixgbe_supported(dev))
-		return -ENOTSUP;
-
-	ixgbe_fdir_info_get(dev, fdir_info);
-
-	return 0;
-}
-
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ixgbe_get_fdir_stats, 20.08)
-int
-rte_pmd_ixgbe_get_fdir_stats(uint16_t port,
-			     struct rte_eth_fdir_stats *fdir_stats)
-{
-	struct rte_eth_dev *dev;
-
-	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
-
-	dev = &rte_eth_devices[port];
-	if (!is_ixgbe_supported(dev))
-		return -ENOTSUP;
-
-	ixgbe_fdir_stats_get(dev, fdir_stats);
-
-	return 0;
-}
diff --git a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.h b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.h
index 7ca1126cfb..74bb5aa140 100644
--- a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.h
+++ b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.h
@@ -724,36 +724,4 @@ enum {
 int
 rte_pmd_ixgbe_upd_fctrl_sbp(uint16_t port, int enable);
 
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
-rte_pmd_ixgbe_get_fdir_info(uint16_t port, struct rte_eth_fdir_info *fdir_info);
-
-/**
- * Get port fdir status
- *
- * @param port
- *   The port identifier of the Ethernet device.
- * @param fdir_stats
- *   The fdir status of the port
- * @return
- *   - (0) if successful.
- *   - (-ENODEV) if *port* invalid.
- *   - (-ENOTSUP) if operation not supported.
- */
-__rte_experimental
-int
-rte_pmd_ixgbe_get_fdir_stats(uint16_t port,
-			     struct rte_eth_fdir_stats *fdir_stats);
 #endif /* _PMD_IXGBE_H_ */
-- 
2.53.0

