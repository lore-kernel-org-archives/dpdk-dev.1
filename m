Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D20C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:27:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76FF040E3F;
	Thu, 20 Aug 2026 07:25:45 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id DE3A840E18
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:40 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d5655cc850so21360995ad.3
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203540;
 x=1787808340; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1ox+vjXMJGtspXaTY2JLA6hIxeEcWgdNQtyTPEYhvn0=;
 b=lxq4rXS9WNtwBMcdU8vx973+tMgY6H81acdK8xExQX/UFyL5aksGfm1GfjUWi13yAu
 UvBcoqDI9LfDtX9FoEgZOXPhiaeqvE4wwcdnLY2VwqKs3Fn8dbCE6OFPUbDp4DzKtl0C
 /+5H2YOWnnv54Qht1A12iLblKPq8TiCwQ3NQ0QuPQxUHv6Ud6Rc7sBFFKEOHUemeuESe
 AJvBMnc9rb9X8Xdb3DsyUSzmdxxd1Vg279RAer1Ccm5tnukF42IkIV/OgbD/Il4dCRY9
 5JvT/0ETWCU94r302y72+0P1kwcfQU5QqOmjlvXbOQMWCsRqpg7ezagC++jCQkBWdrSD
 hHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203540; x=1787808340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1ox+vjXMJGtspXaTY2JLA6hIxeEcWgdNQtyTPEYhvn0=;
 b=bSR6rXahUdB2fnWFnLey+dycLLUdI+aIP0h7wUh2p0Tx06zP2Ft4rQ7OHeeiDSdBUN
 MHQXMxtpkJ8/KvNWimB4dgdzSOFVL5stsbjLipk4OFSa9if6sJQnM5GsecxDc3QSiSVF
 KItL9xFm2FoSIxkv/5YGxY0doxqdvGm7FH1phHDOhuDzsvc0ePPgT44z6zQ3Ixc/SB9Y
 jd84C3UKxztsZXJKyuOUC++OU94YotMC9UbBKop4lCIz6jdFhPRvO6/crMi/nwVmqsAo
 q/a8Hj/FZKSzGmORH15BnfVp0mLeWhVGPEHlQ4MWDWqsNGzSLCmpSZZdOfkpQr6N4MdJ
 2pfA==
X-Gm-Message-State: AFuF++nIfA3mYnqzEwvGmu6DAlM18TJgJroUxt1G8zhCjtrKHxG/eQvA
 Z02aaFjUj6/CCf1+El9E54GmpcrKFnKz2kc1lCxk8mijXU+2GT47cDBEs4Tev0oEvu408B9+xrO
 lXbJz
X-Gm-Gg: AR+sD112MQaWsies3rgIzimfYpL4BUD31HgHe34qhrgvcAeSyvkWODC7nTldzJIZxzP
 M6cWrt1k5gYHmsi7DXHs6h4BFMMop+j3JzNGKJZcvG6YhLlxYlLqQO1qF+8rQ6SuNvT0mrS7xFN
 tsHRFTRDrbxdfJC+pw3baIx6X5+zrFV1ZnPzauH/UYdvaNObV3G+N0Icfp20uFH+Aw2RA/6ljQf
 XeJOXmvq7pmxDCLIx+J06skWiAi80iDhyQtqlj+aBHZDN6utg9S893r/cGi/5jRx1SsrqlNfYvd
 yq8tpHIPl4bqClnWKwAIEGWE6I4JNsJuCnT6e9BNE+bK3AVEWlljMPfyJ6qFx95tztbPiv1N4YD
 7mGoClNj8EEP7gA+BrcpqavEvNGK8+b6612PXzxcnzuNRIohA6i5QJ+1OlxeBkjOse1X7bHvMyD
 n5oGvlPobq844hboAJ5sA8oJbs/XtDwQltBni8HgTp+pcQZmw/PyTr+33tD2fa05Gq3LLThxRVi
 1+nkMAvBenc5xy8U0BKG8W3egx1Y7357rDd3A==
X-Received: by 2002:a17:902:ef43:b0:2d5:e9d5:8ae with SMTP id
 d9443c01a7336-2d5fd62ae4fmr195582695ad.5.1787203539963; 
 Wed, 19 Aug 2026 22:25:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH 44/61] net/sxe2: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:34 -0700
Message-ID: <20260820052251.1453273-45-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

The uses of rte_memcpy() in the sxe2 driver are all in the control
path. Regular memcpy() has no performance disadvantage there
and gets more compile time checking of the arguments.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c           |  6 ++--
 drivers/net/sxe2/sxe2_flow.c               | 11 +++----
 drivers/net/sxe2/sxe2_flow_parse_pattern.c | 36 ++++++++++++----------
 drivers/net/sxe2/sxe2_ipsec.c              |  2 +-
 drivers/net/sxe2/sxe2_rss.c                | 10 +++---
 drivers/net/sxe2/sxe2_rx.c                 |  4 +--
 drivers/net/sxe2/sxe2_stats.c              | 25 +++++++--------
 drivers/net/sxe2/sxe2_tm.c                 |  4 +--
 8 files changed, 51 insertions(+), 47 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index b09989fe50..077e4f8c01 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -961,7 +961,7 @@ int32_t sxe2_drv_rss_key_set(struct sxe2_adapter *adapter, uint8_t *key, uint16_
 
 	req->vsi_id = rte_cpu_to_le_16(adapter->vsi_ctxt.dpdk_vsi_id);
 	req->key_size = rte_cpu_to_le_16(key_size);
-	rte_memcpy(req->key, key, key_size);
+	memcpy(req->key, key, key_size);
 
 	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RSS_KEY_SET,
 				 req, buf_size,
@@ -998,7 +998,7 @@ int32_t sxe2_drv_rss_lut_set(struct sxe2_adapter *adapter, uint8_t *lut, uint16_
 
 	req->vsi_id = rte_cpu_to_le_16(adapter->vsi_ctxt.dpdk_vsi_id);
 	req->lut_size = rte_cpu_to_le_16(lut_size);
-	rte_memcpy(req->lut, lut, lut_size);
+	memcpy(req->lut, lut, lut_size);
 
 	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RSS_LUT_SET,
 				 req, buf_size,
@@ -1890,7 +1890,7 @@ int32_t sxe2_drv_sfp_eeprom_read(struct sxe2_adapter *adapter, struct sxe2_sfp_r
 	}
 
 	ret = 0;
-	rte_memcpy(sfp_info->data, resp->data, sfp_info->len);
+	memcpy(sfp_info->data, resp->data, sfp_info->len);
 
 l_end:
 	if (resp) {
diff --git a/drivers/net/sxe2/sxe2_flow.c b/drivers/net/sxe2/sxe2_flow.c
index 63cfc36968..84669478d1 100644
--- a/drivers/net/sxe2/sxe2_flow.c
+++ b/drivers/net/sxe2/sxe2_flow.c
@@ -80,8 +80,8 @@ static int32_t sxe2_flow_check_hdr_duplicate(struct sxe2_flow_item *item_new,
 	uint16_t size = sizeof(struct sxe2_flow_item);
 	union sxe2_flow_item_raw item_raw_new;
 	union sxe2_flow_item_raw item_raw_exist;
-	rte_memcpy(&item_raw_new.item, item_new, size);
-	rte_memcpy(&item_raw_exist.item, item_exist, size);
+	memcpy(&item_raw_new.item, item_new, size);
+	memcpy(&item_raw_exist.item, item_exist, size);
 
 	for (i = 0; i < size; i++) {
 		if (item_raw_new.raw[i] != item_raw_exist.raw[i])
@@ -416,7 +416,7 @@ static int32_t sxe2_flow_src_split_proc(struct rte_eth_dev *dev,
 					ret = -ENOMEM;
 					goto l_end;
 				}
-				rte_memcpy(flow_new, flow, sizeof(struct sxe2_flow));
+				*flow_new = *flow;
 				TAILQ_INSERT_TAIL(sxe2_flow_list, flow_new, next);
 				flow_new->meta.flow_src_vsi =
 						flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][idx];
@@ -437,7 +437,7 @@ static int32_t sxe2_flow_src_split_proc(struct rte_eth_dev *dev,
 					ret = -ENOMEM;
 					goto l_end;
 				}
-				rte_memcpy(flow_new, flow, sizeof(struct sxe2_flow));
+				*flow_new = *flow;
 				TAILQ_INSERT_TAIL(sxe2_flow_list, flow_new, next);
 				flow_new->meta.flow_src_vsi =
 					flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][idx];
@@ -697,8 +697,7 @@ static int32_t sxe2_flow_tunnel_split_proc(struct rte_eth_dev *dev __rte_unused,
 					ret = -ENOMEM;
 					goto l_end;
 				}
-				rte_memcpy(sxe2_flow_new, sxe2_flow_exist,
-					sizeof(struct sxe2_flow));
+				*sxe2_flow_new = *sxe2_flow_exist;
 				pattern = &sxe2_flow_new->pattern_outer;
 				sxe2_flow_new->meta.tunnel_type =
 					SXE2_FLOW_TUNNEL_TYPE_GRE;
diff --git a/drivers/net/sxe2/sxe2_flow_parse_pattern.c b/drivers/net/sxe2/sxe2_flow_parse_pattern.c
index f5bf8922c6..d5a14398a7 100644
--- a/drivers/net/sxe2/sxe2_flow_parse_pattern.c
+++ b/drivers/net/sxe2/sxe2_flow_parse_pattern.c
@@ -787,20 +787,20 @@ static int32_t sxe2_flow_parse_pattern_eth(const struct rte_flow_item *item,
 			sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_DA, pattern->map_mask);
 
 		sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_DA, pattern->map_spec);
-		rte_memcpy(pattern->item_spec.eth.dst_addr, dst_addr_spec,
-			RTE_ETHER_ADDR_LEN);
-		rte_memcpy(pattern->item_mask.eth.dst_addr, dst_addr_mask,
-			RTE_ETHER_ADDR_LEN);
+		memcpy(pattern->item_spec.eth.dst_addr, dst_addr_spec,
+		       RTE_ETHER_ADDR_LEN);
+		memcpy(pattern->item_mask.eth.dst_addr, dst_addr_mask,
+		       RTE_ETHER_ADDR_LEN);
 	}
 	if (!rte_is_zero_ether_addr(src_addr_mask)) {
 		if (!rte_is_broadcast_ether_addr(src_addr_mask))
 			sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_SA, pattern->map_mask);
 
 		sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_SA, pattern->map_spec);
-		rte_memcpy(pattern->item_spec.eth.src_addr, src_addr_spec,
-			RTE_ETHER_ADDR_LEN);
-		rte_memcpy(pattern->item_mask.eth.src_addr, src_addr_mask,
-			RTE_ETHER_ADDR_LEN);
+		memcpy(pattern->item_spec.eth.src_addr, src_addr_spec,
+		       RTE_ETHER_ADDR_LEN);
+		memcpy(pattern->item_mask.eth.src_addr, src_addr_mask,
+		       RTE_ETHER_ADDR_LEN);
 	}
 	if (type_mask != 0) {
 		if (type_mask != UINT16_MAX) {
@@ -1130,10 +1130,12 @@ static int32_t sxe2_flow_parse_pattern_ipv6(const struct rte_flow_item *item,
 			   sizeof(ipv6_addr_mask)) != 0)
 			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_SA, pattern->map_mask);
 		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_SA, pattern->map_spec);
-		rte_memcpy(&pattern->item_spec.ipv6.saddr, &ipv6_spec->hdr.src_addr,
-			   sizeof(ipv6_spec->hdr.src_addr));
-		rte_memcpy(&pattern->item_mask.ipv6.saddr, &ipv6_mask->hdr.src_addr,
-			   sizeof(ipv6_mask->hdr.src_addr));
+		memcpy(&pattern->item_spec.ipv6.saddr,
+		       &ipv6_spec->hdr.src_addr,
+		       sizeof(ipv6_spec->hdr.src_addr));
+		memcpy(&pattern->item_mask.ipv6.saddr,
+		       &ipv6_mask->hdr.src_addr,
+		       sizeof(ipv6_mask->hdr.src_addr));
 	}
 	if (memcmp(&ipv6_mask->hdr.dst_addr, ipv6_addr_empty,
 		    sizeof(ipv6_addr_empty)) != 0) {
@@ -1141,10 +1143,12 @@ static int32_t sxe2_flow_parse_pattern_ipv6(const struct rte_flow_item *item,
 			   sizeof(ipv6_addr_mask)) != 0)
 			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_DA, pattern->map_mask);
 		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_DA, pattern->map_spec);
-		rte_memcpy(&pattern->item_spec.ipv6.daddr, &ipv6_spec->hdr.dst_addr,
-			   sizeof(ipv6_spec->hdr.dst_addr));
-		rte_memcpy(&pattern->item_mask.ipv6.daddr, &ipv6_mask->hdr.dst_addr,
-			   sizeof(ipv6_mask->hdr.dst_addr));
+		memcpy(&pattern->item_spec.ipv6.daddr,
+		       &ipv6_spec->hdr.dst_addr,
+		       sizeof(ipv6_spec->hdr.dst_addr));
+		memcpy(&pattern->item_mask.ipv6.daddr,
+		       &ipv6_mask->hdr.dst_addr,
+		       sizeof(ipv6_mask->hdr.dst_addr));
 	}
 	if (ipv6_mask->hdr.vtc_flow) {
 		vtc_flow_mask = rte_be_to_cpu_32(ipv6_mask->hdr.vtc_flow);
diff --git a/drivers/net/sxe2/sxe2_ipsec.c b/drivers/net/sxe2/sxe2_ipsec.c
index e783a51b85..81cf250fd2 100644
--- a/drivers/net/sxe2/sxe2_ipsec.c
+++ b/drivers/net/sxe2/sxe2_ipsec.c
@@ -1159,7 +1159,7 @@ int sxe2_ipsec_pkt_metadata_set(void *device, struct rte_security_session *sessi
 
 	md = RTE_MBUF_DYNFIELD(m, sxe2_sctx->ipsec_ctx.md_offset, struct sxe2_ipsec_pkt_metadata *);
 
-	memcpy(md, &sxe2_sess->pkt_metadata_template, sizeof(struct sxe2_ipsec_pkt_metadata));
+	*md = sxe2_sess->pkt_metadata_template;
 	md->esp_head_offset = offset;
 
 	PMD_LOG_INFO(DRV, "ipsec metadata set, offset:%u, said:%u, mode:%u, algo:%u.", offset,
diff --git a/drivers/net/sxe2/sxe2_rss.c b/drivers/net/sxe2/sxe2_rss.c
index 1d56613043..6451096561 100644
--- a/drivers/net/sxe2/sxe2_rss.c
+++ b/drivers/net/sxe2/sxe2_rss.c
@@ -35,7 +35,7 @@ int32_t sxe2_rss_hash_key_init(struct rte_eth_dev *dev)
 		for (i = 0; i < rss_ctxt->rss_key_size; i++)
 			rss_ctxt->rss_key[i] = (uint8_t)rte_rand();
 	} else {
-		rte_memcpy(rss_ctxt->rss_key, rss_conf->rss_key,
+		memcpy(rss_ctxt->rss_key, rss_conf->rss_key,
 			   RTE_MIN(rss_conf->rss_key_len, rss_ctxt->rss_key_size));
 	}
 
@@ -421,7 +421,7 @@ int32_t sxe2_dev_rss_reta_update(struct rte_eth_dev *dev,
 		ret = -ENOMEM;
 		goto l_end;
 	}
-	rte_memcpy(lut_tmp, rss_ctxt->rss_lut, reta_size);
+	memcpy(lut_tmp, rss_ctxt->rss_lut, reta_size);
 
 	for (i = 0; i < reta_size; i++) {
 		idx = i / RTE_ETH_RETA_GROUP_SIZE;
@@ -436,7 +436,7 @@ int32_t sxe2_dev_rss_reta_update(struct rte_eth_dev *dev,
 		goto l_end;
 	}
 
-	rte_memcpy(rss_ctxt->rss_lut, lut_tmp, reta_size);
+	memcpy(rss_ctxt->rss_lut, lut_tmp, reta_size);
 
 l_end:
 	if (lut_tmp)
@@ -514,7 +514,7 @@ static int32_t sxe2_rss_hash_key_update(struct rte_eth_dev *dev,
 		goto l_end;
 	}
 
-	rte_memcpy(rss_ctxt->rss_key, rss_conf->rss_key, rss_conf->rss_key_len);
+	memcpy(rss_ctxt->rss_key, rss_conf->rss_key, rss_conf->rss_key_len);
 l_end:
 	return ret;
 }
@@ -575,7 +575,7 @@ int32_t sxe2_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 
 	if (rss_conf->rss_key) {
 		rss_conf->rss_key_len = rss_ctxt->rss_key_size;
-		rte_memcpy(rss_conf->rss_key, rss_ctxt->rss_key, rss_ctxt->rss_key_size);
+		memcpy(rss_conf->rss_key, rss_ctxt->rss_key, rss_ctxt->rss_key_size);
 	}
 	rss_conf->rss_hf = rss_ctxt->rss_hf;
 	rss_conf->algorithm = rss_ctxt->hash_func;
diff --git a/drivers/net/sxe2/sxe2_rx.c b/drivers/net/sxe2/sxe2_rx.c
index d700c60083..c84e767b25 100644
--- a/drivers/net/sxe2/sxe2_rx.c
+++ b/drivers/net/sxe2/sxe2_rx.c
@@ -311,8 +311,8 @@ int32_t __rte_cold sxe2_rx_queue_setup(struct rte_eth_dev *dev,
 
 	if (rx_nseg > 1) {
 		for (i = 0; i < rx_nseg; i++) {
-			rte_memcpy(&rxq->rx_seg[i], &rx_conf->rx_seg[i].split,
-					sizeof(struct rte_eth_rxseg_split));
+			memcpy(&rxq->rx_seg[i], &rx_conf->rx_seg[i].split,
+			       sizeof(struct rte_eth_rxseg_split));
 		}
 		rxq->mb_pool = rxq->rx_seg[0].mp;
 	} else {
diff --git a/drivers/net/sxe2/sxe2_stats.c b/drivers/net/sxe2/sxe2_stats.c
index 3ad8fe2fe9..6dc52ac4ab 100644
--- a/drivers/net/sxe2/sxe2_stats.c
+++ b/drivers/net/sxe2/sxe2_stats.c
@@ -288,18 +288,19 @@ static void sxe2_stats_update(struct sxe2_adapter *adapter)
 		stats->rx_frame_good_bad = hw_stats->rx_frame_good_bad;
 		stats->rx_unicast_good = hw_stats->rx_unicast_good;
 		stats->rx_vlan_packets = hw_stats->rx_vlan_packets;
-		rte_memcpy(stats->rx_prio_buf_discard, hw_stats->rx_prio_buf_discard,
-				sizeof(hw_stats->rx_prio_buf_discard));
-		rte_memcpy(stats->prio_xoff_rx, hw_stats->prio_xoff_rx,
-				sizeof(hw_stats->prio_xoff_rx));
-		rte_memcpy(stats->prio_xon_rx, hw_stats->prio_xon_rx,
-				sizeof(hw_stats->prio_xon_rx));
-		rte_memcpy(stats->prio_xon_tx, hw_stats->prio_xon_tx,
-				sizeof(hw_stats->prio_xon_tx));
-		rte_memcpy(stats->prio_xoff_tx, hw_stats->prio_xoff_tx,
-				sizeof(hw_stats->prio_xoff_tx));
-		rte_memcpy(stats->prio_xon_2_xoff, hw_stats->prio_xon_2_xoff,
-				sizeof(hw_stats->prio_xon_2_xoff));
+		memcpy(stats->rx_prio_buf_discard,
+		       hw_stats->rx_prio_buf_discard,
+		       sizeof(hw_stats->rx_prio_buf_discard));
+		memcpy(stats->prio_xoff_rx, hw_stats->prio_xoff_rx,
+		       sizeof(hw_stats->prio_xoff_rx));
+		memcpy(stats->prio_xon_rx, hw_stats->prio_xon_rx,
+		       sizeof(hw_stats->prio_xon_rx));
+		memcpy(stats->prio_xon_tx, hw_stats->prio_xon_tx,
+		       sizeof(hw_stats->prio_xon_tx));
+		memcpy(stats->prio_xoff_tx, hw_stats->prio_xoff_tx,
+		       sizeof(hw_stats->prio_xoff_tx));
+		memcpy(stats->prio_xon_2_xoff, hw_stats->prio_xon_2_xoff,
+		       sizeof(hw_stats->prio_xon_2_xoff));
 
 		stats->imissed = hw_stats->rx_out_of_buffer +
 				hw_stats->rx_qblock_drop;
diff --git a/drivers/net/sxe2/sxe2_tm.c b/drivers/net/sxe2/sxe2_tm.c
index 4c4f793cd5..893e1afa6d 100644
--- a/drivers/net/sxe2/sxe2_tm.c
+++ b/drivers/net/sxe2/sxe2_tm.c
@@ -421,8 +421,8 @@ static int32_t sxe2_tm_shaper_profile_add(struct rte_eth_dev *dev, uint32_t shap
 		goto l_end;
 	}
 
-	rte_memcpy(&shaper_profile->profile, profile,
-					sizeof(struct rte_tm_shaper_params));
+	memcpy(&shaper_profile->profile, profile,
+	       sizeof(struct rte_tm_shaper_params));
 	shaper_profile->id = shaper_profile_id;
 
 	TAILQ_INSERT_TAIL(&adapter->tm_ctxt.profile_list, shaper_profile, node);
-- 
2.53.0

