Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A988C55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:53:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EDE24064F;
	Mon,  3 Aug 2026 18:53:13 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id D1246402D8
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:10 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cbb662575d3so1999803a12.0
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785775990;
 x=1786380790; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Qd/WMLrMDMnb+CU99ZPFT4HGgNpF25OHKKxFTfFspQ=;
 b=R9wA+mmuu2HkrX/9ABK70tLm54zT0f34G/2xSwUlx5QU1FiengM5r7nCfGdwl5ykXe
 OFdLep8FTEgIo8omw2KlFn5xXVqUWnS/P4jt/gkwjmB7SMhPCIg92Dh/ifwIx/4EEQRy
 g7+beKhI72nEKV6EFcj5mI3pQWlJD4hikHaGq6vl4ZL0KMkRyoFO0+52WSfRrDyzDOBi
 X5ea7jyx9xy0k63ciJuKQNobjQcJN+/YU62ZlxTxQLfo4/uqLgAXozRNjNzBolS5qMRp
 LGR48+rpJDjQpULzzGuY4pEMAjxc3Atu6g+c3hybQQP/GXTgaQl1WBpT6+xbhd86EqZ8
 sjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785775990; x=1786380790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Qd/WMLrMDMnb+CU99ZPFT4HGgNpF25OHKKxFTfFspQ=;
 b=b9C/YIZA0nsT6GGzTvy97z1qcXw/Ba7/fu0iBybYfagTz28JFaQ6D70hROJskvUFPx
 Bff9fE2VsRu/ufrcSCKdHNjHG0w8DZt3OO/etQY/S/0eySRIYQmCOHhPdiyZsnQIo2S2
 mC39g6KRtoAgfRFi3rM6+4NCo+rHI75BBrRlAUIyLaZShNl43JzfjAk6KPHNlvR3btgd
 6KXWmSeRBSQVIuWt4Jd3u0zXD4Bzowr8Ys+aW5/qFK7w5W8mDIpXArsmYmqyxb6gFwpo
 uy8hkJPM6NMXuT/2dnQSPHBjysV60UTll4Qpw6oqh+A3KYq3aiuRPkOjVmCChOH4kkKt
 09xw==
X-Gm-Message-State: AOJu0YwruFviKhawPDNT+xkbGLN49wz/0kRy0ktslv9b1UPtP3jwrQW5
 iroj+1MCSKaTNwOz39QVHm0nUss2OVCsd4Ari5wnXDm5pxWRqErjoHm4gz/7HS+HlAsKah6sqvf
 33Cpw
X-Gm-Gg: AR+sD11cpRIv/1HBXnhhOqbYgsOc/uG8MsrEEVRcw/hBlB6u+5LLk5yObQQg0fo8FVn
 dbkC2MkW45SiyMOwvI7/ETbUXh2L2Oc9hmGQw7VmAeKlCX78awVW9Y5zc/iCOeCywPHiNojoL1t
 sVRkouOdSLC2BFb8+YPSG2Gt1z3dNzPUkgBHDR7t+5cMpEnhPSH1+PX35tbhMAiz44mi8QAWc5C
 GMHwG0Nzg+z0nwfSEJvvAjMBQlPCgPecA9k63iXvMxDQ7p6Gc1YG1SpROFs//CD+2BseqjS5nYV
 hJ43ko2iSLG34Znq7NNythGouQ+pf94A6Vk4fdcZ0Ox0USm7vG+voIWs1/2FyKTRPdj4o2tp19+
 o01VSAvGLIRczx0dWPU05LC1wYQJ7uJXtY1n1WnzcELGMwRG+6/XrYkT4BM5v7TUeJ7W6haqi2H
 wbPOjzG7RkRQmPD+p9hx+J68Xqvl7rPK80Kugf1jeBj0RecxnxW63ZpNxAxhd3C3BdUF+nyz+Ql
 40Iu4+CXft7KFWzTp2LD5Im6Nc=
X-Received: by 2002:a05:6a21:1b84:b0:3c3:a41f:ce83 with SMTP id
 adf61e73a8af0-3c92aace533mr11142267637.61.1785775990010; 
 Mon, 03 Aug 2026 09:53:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 03/22] net/ixgbe: remove experimental FDIR API
Date: Mon,  3 Aug 2026 09:51:49 -0700
Message-ID: <20260803165304.289869-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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

Remove the PMD specific flow director API from ixgbe.
These APIs are experimental, therefore they can be removed
without additional warnings.

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

