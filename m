Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521A4C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:26:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F16FE40BA2;
	Thu, 20 Aug 2026 07:25:30 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 9A2F840E32
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:27 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2d53197d8b5so18079485ad.3
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203527;
 x=1787808327; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d8Uf/EHzpGQhl/Z3O0/LGDOEBhEJNZBLZg8mwzExdzU=;
 b=plj8FY2my0zHsX7WkGCoUL5qsFlx3iLKRiF9eU36tdlkK2UPmE/iMxcJgiMKaBzkAK
 Y1WPG0bbuoF/3VhHmYFp9/1HZ/Mxn+GYuQOFt1DMdkwYn6LmrSXZs0d2cCpqIzsFEwX7
 UeytIf/cbY9EdXef4Ww7Cv5JaaB81Yq2WvV7ALHe3DPKoh3y7eDqzlyclx8Gv8rWbaaa
 9qayEqM3hNh8S4xbT7lGVHaKmzH6zSVZ9B8YgwXyj9UqY+m4/LyZZ0pRsQrycJSi3PbB
 OhP0/J6roB4kTZiTQvpLXhW8S8ftddwOAilLqvP0x20uVXGS4LZpH5M7Q91xFDZzYX0+
 zrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203527; x=1787808327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d8Uf/EHzpGQhl/Z3O0/LGDOEBhEJNZBLZg8mwzExdzU=;
 b=UX6NzggS0iIIPTGvAFVSgOAdOd499L5dc5AMa3QtX8rff6w6zJQWKhcrYxpcHYCSmi
 mADZ2V9vR4CPUB02vxD5BkX5YMZnbWg0mykE5lXunB66vPBHZwllwkocZhJzWDyNbcR6
 w41p+nhzXhS2xUwEDLV/lDfLehQcxP6OVc8pC8RhR0wP/zY5lDJLA9L1tDVFyML0kNDa
 dAkpzZA6haUoqWsu8UZAJGZ7345Do0YsL4z9l4DxYmhTiHjkbON8T/DdJpb04NjHEjHT
 T1kFapdOZA8erkx3/QyMFysA61vAiuKWWbbUAde3KYRotf5coddhKJ5mw3f2EZrHU2ug
 aIRQ==
X-Gm-Message-State: AFuF++kOBGhAmkkcPBMx5mer32bnwAp8fR9sPrLk9wEMiGaif/yIs88C
 +GTd7cGU33Jz5BwXllpl6IG+p8skz4lVEB6XT6hg+tyFo/PfjFZkC/VJFq3qrt6gnEoIkLMZ2Qj
 V3RGL
X-Gm-Gg: AR+sD12VB/lKkXOE69Me3XbalrS6aPmtjCssTEoQuE0cSOF7GhFYgCNMd1jNonYzFgO
 1gApRe5bkf6QrIUV3lwxavimZ205Wm5iT7ufjbyADcWopJ10oH8navglVRchHI1nURvcbwOHVBB
 yG1ohEKSdUQ2iVizkiejutDI+UA5fjsfWJrAshNEX9iHpq+gnv68cerr1Ymr6Z/IWsgRWxK09ca
 kyi7vyhAsa9VfWP72oFEGynkm8AULRVphfVyOjbb4gbRwPN5l6jszv/KoHnXM8vSo5Gy3BZz5n7
 c5oYzSdcmW00g2SsQYBoSu7gzHPf+GWcc+XgWEVuokgt0v4ueR5ViLKeTis8vRCJV/UxQWMG4qm
 3YyfIxkH2TycWPw9OulDPLS6C43DQzf25aRTlxMCSWXPIsQ9Oaj+UiWbBCqNG6TCwUqlGjYC0yT
 FNyxJpHu4cVV5ezlH5Tj/FA+6VYzoBKJgqnfXPdh7bAN7RJwFBv9A6cmPq36vfOCBukRUqYM8Li
 zAgArmrpOH/xbaDnYZ5pIl8L54RJbue+5aSaw==
X-Received: by 2002:a17:902:e949:b0:2cc:f5b8:4c2e with SMTP id
 d9443c01a7336-2d601468c49mr204926295ad.9.1787203526713; 
 Wed, 19 Aug 2026 22:25:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 40/61] net/sfc: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:30 -0700
Message-ID: <20260820052251.1453273-41-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sfc/sfc.c          |  2 +-
 drivers/net/sfc/sfc_ef10_tx.c  |  2 +-
 drivers/net/sfc/sfc_ethdev.c   | 11 +++++------
 drivers/net/sfc/sfc_flow.c     | 20 ++++++++++----------
 drivers/net/sfc/sfc_flow_rss.c |  2 +-
 drivers/net/sfc/sfc_mae.c      |  2 +-
 drivers/net/sfc/sfc_rx.c       |  2 +-
 drivers/net/sfc/sfc_tso.c      |  2 +-
 drivers/net/sfc/sfc_tso.h      |  9 ++++-----
 9 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/net/sfc/sfc.c b/drivers/net/sfc/sfc.c
index 39cd8d519a..6a136926f6 100644
--- a/drivers/net/sfc/sfc.c
+++ b/drivers/net/sfc/sfc.c
@@ -853,7 +853,7 @@ sfc_rss_attach(struct sfc_adapter *sa)
 	efx_ev_fini(sa->nic);
 	efx_intr_fini(sa->nic);
 
-	rte_memcpy(rss->key, default_rss_key, sizeof(rss->key));
+	memcpy(rss->key, default_rss_key, sizeof(rss->key));
 	memset(&rss->dummy_ctx, 0, sizeof(rss->dummy_ctx));
 	rss->dummy_ctx.conf.qid_span = 1;
 	rss->dummy_ctx.dummy = true;
diff --git a/drivers/net/sfc/sfc_ef10_tx.c b/drivers/net/sfc/sfc_ef10_tx.c
index 5543dc495f..dd4745a90a 100644
--- a/drivers/net/sfc/sfc_ef10_tx.c
+++ b/drivers/net/sfc/sfc_ef10_tx.c
@@ -514,7 +514,7 @@ sfc_ef10_xmit_tso_pkt(struct sfc_ef10_txq * const txq, struct rte_mbuf *m_seg,
 						first_m_seg->outer_l2_len);
 
 	th = (const struct rte_tcp_hdr *)(hdr_addr + tcph_off);
-	rte_memcpy(&sent_seq, &th->sent_seq, sizeof(uint32_t));
+	memcpy(&sent_seq, &th->sent_seq, sizeof(uint32_t));
 	sent_seq = rte_be_to_cpu_32(sent_seq);
 
 	sfc_ef10_tx_qdesc_tso2_create(txq, *added, packet_id, outer_packet_id,
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 6be91789cf..a4fb9b2cff 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -1438,8 +1438,7 @@ sfc_set_mc_addr_list(struct rte_eth_dev *dev,
 	}
 
 	for (i = 0; i < nb_mc_addr; ++i) {
-		rte_memcpy(mc_addrs, mc_addr_set[i].addr_bytes,
-				 EFX_MAC_ADDR_LEN);
+		memcpy(mc_addrs, mc_addr_set[i].addr_bytes, EFX_MAC_ADDR_LEN);
 		mc_addrs += EFX_MAC_ADDR_LEN;
 	}
 
@@ -1823,7 +1822,7 @@ sfc_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 	rss_conf->rss_hf = sfc_rx_hf_efx_to_rte(rss, rss->hash_types);
 	rss_conf->rss_key_len = EFX_RSS_KEY_SIZE;
 	if (rss_conf->rss_key != NULL)
-		rte_memcpy(rss_conf->rss_key, rss->key, EFX_RSS_KEY_SIZE);
+		memcpy(rss_conf->rss_key, rss->key, EFX_RSS_KEY_SIZE);
 
 	return 0;
 }
@@ -1892,7 +1891,7 @@ sfc_dev_rss_hash_update(struct rte_eth_dev *dev,
 			}
 		}
 
-		rte_memcpy(rss->key, rss_conf->rss_key, sizeof(rss->key));
+		memcpy(rss->key, rss_conf->rss_key, sizeof(rss->key));
 	}
 
 	rss->hash_types = efx_hash_types;
@@ -1991,7 +1990,7 @@ sfc_dev_rss_reta_update(struct rte_eth_dev *dev,
 
 	sfc_adapter_lock(sa);
 
-	rte_memcpy(rss_tbl_new, rss->tbl, sizeof(rss->tbl));
+	memcpy(rss_tbl_new, rss->tbl, sizeof(rss->tbl));
 
 	for (entry = 0; entry < reta_size; entry++) {
 		int grp_idx = entry % RTE_ETH_RETA_GROUP_SIZE;
@@ -2015,7 +2014,7 @@ sfc_dev_rss_reta_update(struct rte_eth_dev *dev,
 			goto fail_scale_tbl_set;
 	}
 
-	rte_memcpy(rss->tbl, rss_tbl_new, sizeof(rss->tbl));
+	memcpy(rss->tbl, rss_tbl_new, sizeof(rss->tbl));
 
 fail_scale_tbl_set:
 bad_reta_entry:
diff --git a/drivers/net/sfc/sfc_flow.c b/drivers/net/sfc/sfc_flow.c
index 1006243539..66158bdff7 100644
--- a/drivers/net/sfc/sfc_flow.c
+++ b/drivers/net/sfc/sfc_flow.c
@@ -325,8 +325,8 @@ sfc_flow_parse_eth(const struct rte_flow_item *item,
 		efx_spec->efs_match_flags |= is_ifrm ?
 			EFX_FILTER_MATCH_IFRM_LOC_MAC :
 			EFX_FILTER_MATCH_LOC_MAC;
-		rte_memcpy(loc_mac, spec->hdr.dst_addr.addr_bytes,
-			   EFX_MAC_ADDR_LEN);
+		memcpy(loc_mac, spec->hdr.dst_addr.addr_bytes,
+		       EFX_MAC_ADDR_LEN);
 	} else if (memcmp(mask->hdr.dst_addr.addr_bytes, ig_mask,
 			  EFX_MAC_ADDR_LEN) == 0) {
 		if (rte_is_unicast_ether_addr(&spec->hdr.dst_addr))
@@ -348,8 +348,8 @@ sfc_flow_parse_eth(const struct rte_flow_item *item,
 	 */
 	if (rte_is_same_ether_addr(&mask->hdr.src_addr, &supp_mask.hdr.src_addr)) {
 		efx_spec->efs_match_flags |= EFX_FILTER_MATCH_REM_MAC;
-		rte_memcpy(efx_spec->efs_rem_mac, spec->hdr.src_addr.addr_bytes,
-			   EFX_MAC_ADDR_LEN);
+		memcpy(efx_spec->efs_rem_mac, spec->hdr.src_addr.addr_bytes,
+		       EFX_MAC_ADDR_LEN);
 	} else if (!rte_is_zero_ether_addr(&mask->hdr.src_addr)) {
 		goto fail_bad_mask;
 	}
@@ -618,8 +618,8 @@ sfc_flow_parse_ipv6(const struct rte_flow_item *item,
 
 		RTE_BUILD_BUG_ON(sizeof(efx_spec->efs_rem_host) !=
 				 sizeof(spec->hdr.src_addr));
-		rte_memcpy(&efx_spec->efs_rem_host, &spec->hdr.src_addr,
-			   sizeof(efx_spec->efs_rem_host));
+		memcpy(&efx_spec->efs_rem_host, &spec->hdr.src_addr,
+		       sizeof(efx_spec->efs_rem_host));
 	} else if (!sfc_flow_is_zero(mask->hdr.src_addr.a,
 				     sizeof(mask->hdr.src_addr))) {
 		goto fail_bad_mask;
@@ -631,8 +631,8 @@ sfc_flow_parse_ipv6(const struct rte_flow_item *item,
 
 		RTE_BUILD_BUG_ON(sizeof(efx_spec->efs_loc_host) !=
 				 sizeof(spec->hdr.dst_addr));
-		rte_memcpy(&efx_spec->efs_loc_host, &spec->hdr.dst_addr,
-			   sizeof(efx_spec->efs_loc_host));
+		memcpy(&efx_spec->efs_loc_host, &spec->hdr.dst_addr,
+		       sizeof(efx_spec->efs_loc_host));
 	} else if (!sfc_flow_is_zero(mask->hdr.dst_addr.a,
 				     sizeof(mask->hdr.dst_addr))) {
 		goto fail_bad_mask;
@@ -883,8 +883,8 @@ sfc_flow_set_efx_spec_vni_or_vsid(efx_filter_spec_t *efx_spec,
 	if (memcmp(vni_or_vsid_mask, vni_or_vsid_full_mask,
 		   EFX_VNI_OR_VSID_LEN) == 0) {
 		efx_spec->efs_match_flags |= EFX_FILTER_MATCH_VNI_OR_VSID;
-		rte_memcpy(efx_spec->efs_vni_or_vsid, vni_or_vsid_val,
-			   EFX_VNI_OR_VSID_LEN);
+		memcpy(efx_spec->efs_vni_or_vsid, vni_or_vsid_val,
+		       EFX_VNI_OR_VSID_LEN);
 	} else if (!sfc_flow_is_zero(vni_or_vsid_mask, EFX_VNI_OR_VSID_LEN)) {
 		rte_flow_error_set(error, EINVAL,
 				   RTE_FLOW_ERROR_TYPE_ITEM, item,
diff --git a/drivers/net/sfc/sfc_flow_rss.c b/drivers/net/sfc/sfc_flow_rss.c
index 8e2749833b..7656ffb9f8 100644
--- a/drivers/net/sfc/sfc_flow_rss.c
+++ b/drivers/net/sfc/sfc_flow_rss.c
@@ -119,7 +119,7 @@ sfc_flow_rss_parse_conf(struct sfc_adapter *sa,
 		key = ethdev_rss->key;
 	}
 
-	rte_memcpy(out->key, key, sizeof(out->key));
+	memcpy(out->key, key, sizeof(out->key));
 
 	switch (in->func) {
 	case RTE_ETH_HASH_FUNCTION_DEFAULT:
diff --git a/drivers/net/sfc/sfc_mae.c b/drivers/net/sfc/sfc_mae.c
index b0e8b02b41..d9aa47e52e 100644
--- a/drivers/net/sfc/sfc_mae.c
+++ b/drivers/net/sfc/sfc_mae.c
@@ -546,7 +546,7 @@ sfc_mae_mac_addr_add(struct sfc_adapter *sa,
 	if (mac_addr == NULL)
 		return ENOMEM;
 
-	rte_memcpy(mac_addr->addr_bytes, addr_bytes, EFX_MAC_ADDR_LEN);
+	memcpy(mac_addr->addr_bytes, addr_bytes, EFX_MAC_ADDR_LEN);
 
 	mac_addr->refcnt = 1;
 	mac_addr->fw_rsrc.mac_id.id = EFX_MAE_RSRC_ID_INVALID;
diff --git a/drivers/net/sfc/sfc_rx.c b/drivers/net/sfc/sfc_rx.c
index d8b961ff7e..1b1176925b 100644
--- a/drivers/net/sfc/sfc_rx.c
+++ b/drivers/net/sfc/sfc_rx.c
@@ -1527,7 +1527,7 @@ sfc_rx_process_adv_conf_rss(struct sfc_adapter *sa,
 				sizeof(rss->key));
 			return EINVAL;
 		}
-		rte_memcpy(rss->key, conf->rss_key, sizeof(rss->key));
+		memcpy(rss->key, conf->rss_key, sizeof(rss->key));
 	}
 
 	rss->hash_types = efx_hash_types;
diff --git a/drivers/net/sfc/sfc_tso.c b/drivers/net/sfc/sfc_tso.c
index a0827d1c0d..5da2de3c3d 100644
--- a/drivers/net/sfc/sfc_tso.c
+++ b/drivers/net/sfc/sfc_tso.c
@@ -159,7 +159,7 @@ sfc_efx_tso_do(struct sfc_efx_txq *txq, unsigned int idx,
 	/* Handle TCP header */
 	th = (const struct rte_tcp_hdr *)(tsoh + tcph_off);
 
-	rte_memcpy(&sent_seq, &th->sent_seq, sizeof(uint32_t));
+	memcpy(&sent_seq, &th->sent_seq, sizeof(uint32_t));
 	sent_seq = rte_be_to_cpu_32(sent_seq);
 
 	efx_tx_qdesc_tso2_create(txq->common, packet_id, 0, sent_seq,
diff --git a/drivers/net/sfc/sfc_tso.h b/drivers/net/sfc/sfc_tso.h
index 9029ad1590..e914eae77e 100644
--- a/drivers/net/sfc/sfc_tso.h
+++ b/drivers/net/sfc/sfc_tso.h
@@ -35,7 +35,7 @@ sfc_tso_ip4_get_ipid(const uint8_t *pkt_hdrp, size_t ip_hdr_off)
 	uint16_t ipid;
 
 	ip_hdrp = (const struct rte_ipv4_hdr *)(pkt_hdrp + ip_hdr_off);
-	rte_memcpy(&ipid, &ip_hdrp->packet_id, sizeof(ipid));
+	memcpy(&ipid, &ip_hdrp->packet_id, sizeof(ipid));
 
 	return rte_be_to_cpu_16(ipid);
 }
@@ -46,9 +46,8 @@ sfc_tso_outer_udp_fix_len(const struct rte_mbuf *m, uint8_t *tsoh)
 	rte_be16_t len = rte_cpu_to_be_16(m->l2_len + m->l3_len + m->l4_len +
 					  m->tso_segsz);
 
-	rte_memcpy(tsoh + m->outer_l2_len + m->outer_l3_len +
-		   offsetof(struct rte_udp_hdr, dgram_len),
-		   &len, sizeof(len));
+	memcpy(tsoh + m->outer_l2_len + m->outer_l3_len + offsetof(struct rte_udp_hdr, dgram_len),
+	       &len, sizeof(len));
 }
 
 static inline void
@@ -67,7 +66,7 @@ sfc_tso_innermost_ip_fix_len(const struct rte_mbuf *m, uint8_t *tsoh,
 		len = rte_cpu_to_be_16(ip_payload_len);
 	}
 
-	rte_memcpy(tsoh + iph_ofst + field_ofst, &len, sizeof(len));
+	memcpy(tsoh + iph_ofst + field_ofst, &len, sizeof(len));
 }
 
 unsigned int sfc_tso_prepare_header(uint8_t *tsoh, size_t header_len,
-- 
2.53.0

