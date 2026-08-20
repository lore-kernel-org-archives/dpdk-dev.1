Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5F1C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:24:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2931940B9E;
	Thu, 20 Aug 2026 07:24:21 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id B77CB40BA5
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:19 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2d53197d8b5so18072395ad.3
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203459;
 x=1787808259; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oDPKC4FHSc847OTB50yjxZcVp93fT+TS13N1GyvDggs=;
 b=iiAWU6+oQ/qmRkkRn5pVqWJFhZemHJon5zS3XZUTxyeTaoy+iRxT3EQtUUdxEEDehe
 3pUrk8sWeos6A+kAL7ugoE/GnxPsSUbqSLkeFnjHOVTxV6VswQNMK37ig3mSX2bA6CoU
 AZgqByyZCs2y5EsR5EHt3LFyu/R9O24IXiCZG53qH/yNHA0EerQ3+pO/mzYH4WBDcR52
 Mo4O2DeZvj0q6YBMO+aepLsHHpYSNDaVsWX8qsTv8tcgzmhvFfGdfzQ5WCvYIKYnVjZz
 /U58k8eReWYUQbcQLlU+vLK1FgnNpb+f8041gvOqNsdv6cwkO75BOQTS6BU6H0AYSWjU
 ohGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203459; x=1787808259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oDPKC4FHSc847OTB50yjxZcVp93fT+TS13N1GyvDggs=;
 b=p1aMDLjAZK6l/IPT1f/31YsHuxoEl9886EjMTtlhQMC8Y+7tbKHIyjd33PACPjfrBR
 avxBhItPJAfwFOi30ewOpe29LTkJDeabS1ZHKDuEP+nW1P5YrL2ffFlqqsAwdBvhC9tE
 VcUIqVhg519RA70VfXY0LersR0iBA2bsJpkY5da3jV0V7t+zUeJ4gLD4wxXa1HbeEzDx
 C0FYn1tarw6XxT4DL1n+cc7kuJYnqnKr/zMbn6+QaMCkVd92+I0c2ywt2Jun56zgmbAp
 jNQbsaMMNpr5ofuPM13Swk9IBBtmIh9vIMtmE9b6Vz8N65kw29tn/Vt3Db4eCuAipH/G
 js+w==
X-Gm-Message-State: AFuF++lGiLBEnY9sojXKAWhsDjgcV7KYo7cVH9ejmDb5phx+VSEPVxEe
 gqaiHNNkLV2hg6FS+ZKpTGARL4tmuczXnwnJVhO9ujF7OqgbLYxBU9ZhMc9yMZh4bUpDnAHJ7lL
 MzI3x
X-Gm-Gg: AR+sD12I/6bKhJDT05By0qUV4d1DfLCXt/Fjktf5mRqZDQiHaqi2hAnxH+b45O4pp6/
 kESbAeQzvZbeHr+uQyAFySpEhCbWE7YpqzdTIIzD0y9YUDkEoFdzaM17BldQg479q/7f2tLZTSw
 lvPRekV9AYtZrylqgnqLMMQndh7vjXoGfqpp0QBynj0/AiV1d5DbMk8MXwibQd18sh+XIDChKte
 ZXOSLEsCGcTVcREar/jFBRCeHVfAwmiFWiGBLtRAdS/j7VrmQ++lU+9+U/QuvqaHY7j6VcrSRCT
 cvQdN8cvUsb06DOyIVHyq/EoUnUvwEjHOEhSWdhsK6ZUKhPdsTo9/YpcbhssOOzeAQl7gwAYnyl
 ZEwJF2CfDjjSoxVVe+6RQH/mml5BwXc91eduP3lxi72G9/5kWA6IkbUn9rQFBY7xbPn5Q+bmfXY
 b5N141lbOT6NEUqfFjlEIeb4wk6ANO5IV3yBRyc04ExsdPcBE+ab1nF3VpIFyFucWEQbgw00ahv
 rO0uwk2c6NhhrSOIfUeb/OguyM=
X-Received: by 2002:a17:902:e949:b0:2cc:f5b8:4c2e with SMTP id
 d9443c01a7336-2d601468c49mr204829195ad.9.1787203458870; 
 Wed, 19 Aug 2026 22:24:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH 20/61] net/bnx2x: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:10 -0700
Message-ID: <20260820052251.1453273-21-stephen@networkplumber.org>
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
 drivers/net/bnx2x/bnx2x.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/net/bnx2x/bnx2x.c b/drivers/net/bnx2x/bnx2x.c
index 8790c858d5..ecba62119c 100644
--- a/drivers/net/bnx2x/bnx2x.c
+++ b/drivers/net/bnx2x/bnx2x.c
@@ -2238,18 +2238,18 @@ int bnx2x_tx_encap(struct bnx2x_tx_queue *txq, struct rte_mbuf *m0)
 		tx_parse_bd->parsing_data =
 		    (mac_type << ETH_TX_PARSE_BD_E2_ETH_ADDR_TYPE_SHIFT);
 
-		rte_memcpy(&tx_parse_bd->data.mac_addr.dst_hi,
-			   &eh->dst_addr.addr_bytes[0], 2);
-		rte_memcpy(&tx_parse_bd->data.mac_addr.dst_mid,
-			   &eh->dst_addr.addr_bytes[2], 2);
-		rte_memcpy(&tx_parse_bd->data.mac_addr.dst_lo,
-			   &eh->dst_addr.addr_bytes[4], 2);
-		rte_memcpy(&tx_parse_bd->data.mac_addr.src_hi,
-			   &eh->src_addr.addr_bytes[0], 2);
-		rte_memcpy(&tx_parse_bd->data.mac_addr.src_mid,
-			   &eh->src_addr.addr_bytes[2], 2);
-		rte_memcpy(&tx_parse_bd->data.mac_addr.src_lo,
-			   &eh->src_addr.addr_bytes[4], 2);
+		memcpy(&tx_parse_bd->data.mac_addr.dst_hi,
+		       &eh->dst_addr.addr_bytes[0], 2);
+		memcpy(&tx_parse_bd->data.mac_addr.dst_mid,
+		       &eh->dst_addr.addr_bytes[2], 2);
+		memcpy(&tx_parse_bd->data.mac_addr.dst_lo,
+		       &eh->dst_addr.addr_bytes[4], 2);
+		memcpy(&tx_parse_bd->data.mac_addr.src_hi,
+		       &eh->src_addr.addr_bytes[0], 2);
+		memcpy(&tx_parse_bd->data.mac_addr.src_mid,
+		       &eh->src_addr.addr_bytes[2], 2);
+		memcpy(&tx_parse_bd->data.mac_addr.src_lo,
+		       &eh->src_addr.addr_bytes[4], 2);
 
 		tx_parse_bd->data.mac_addr.dst_hi =
 		    rte_cpu_to_be_16(tx_parse_bd->data.mac_addr.dst_hi);
@@ -6671,8 +6671,7 @@ bnx2x_config_rss_pf(struct bnx2x_softc *sc, struct ecore_rss_config_obj *rss_obj
 	/* Hash bits */
 	params.rss_result_mask = MULTI_MASK;
 
-	rte_memcpy(params.ind_table, rss_obj->ind_table,
-			 sizeof(params.ind_table));
+	memcpy(params.ind_table, rss_obj->ind_table, sizeof(params.ind_table));
 
 	if (config_hash) {
 /* RSS keys */
@@ -6738,8 +6737,7 @@ bnx2x_set_mac_one(struct bnx2x_softc *sc, uint8_t * mac,
 
 	/* fill a user request section if needed */
 	if (!rte_bit_relaxed_get32(RAMROD_CONT, ramrod_flags)) {
-		rte_memcpy(ramrod_param.user_req.u.mac.mac, mac,
-				 ETH_ALEN);
+		memcpy(ramrod_param.user_req.u.mac.mac, mac, ETH_ALEN);
 
 		rte_bit_relaxed_set32(mac_type,
 				      &ramrod_param.user_req.vlan_mac_flags);
@@ -6954,7 +6952,7 @@ static void bnx2x_link_report_locked(struct bnx2x_softc *sc)
 
 	ELINK_DEBUG_P1(sc, "link status change count = %x", sc->link_cnt);
 	/* report new link params and remember the state for the next time */
-	rte_memcpy(&sc->last_reported_link, &cur_data, sizeof(cur_data));
+	memcpy(&sc->last_reported_link, &cur_data, sizeof(cur_data));
 
 	if (rte_bit_relaxed_get32(BNX2X_LINK_REPORT_LINK_DOWN,
 			 &cur_data.link_report_flags)) {
-- 
2.53.0

