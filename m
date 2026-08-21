Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C51C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:30:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2185540E03;
	Fri, 21 Aug 2026 21:29:36 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id F3C3140DF5
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:34 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8518d5ddaabso1058417b3a.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340574;
 x=1787945374; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oDPKC4FHSc847OTB50yjxZcVp93fT+TS13N1GyvDggs=;
 b=T4yAzeG9tBY/9JMtbjG15H4yaQf/YnQgNqwWBYivlAqoAdMdsqnZdrY6lDjEHOs8as
 qdAtzAAvvCBHz8670wWubNAUtt8dTMyRJYTLYrsB2vciY4CUfOduMKp9oo5uE5Mn3ooW
 iIGns5DoZRfoMIEZJ83HnR4W3+tIq11JrP0fI7SnK+wQfTDGbbDGjIH7QK7IJzXj+/ci
 Wgser7SWMM6Ge8nPhSnV6fzhS24g3lF/F337wPGUdOswnL2syZgHFOsKYKfvdUwaE5IX
 wjIS8iAHZUqVHPi+cWjG/SG31rHa6vv460LxQL2e95n2tTvHCHE7s8iqP/TJJBoC9MF7
 0rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340574; x=1787945374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oDPKC4FHSc847OTB50yjxZcVp93fT+TS13N1GyvDggs=;
 b=KXpQZtCKmc3ozPc570eL6F8Wm67rZJgeG8dipq0f15yCUcFhCOgPd+s8JGRnKYmfZI
 9Dcl8ujB0UI97s/QosM9hr1VZSOAv0KXwN+rLRQ9kP7g+VtNWEXK3gf9wSgtTLpEj9cd
 5LovQbomGGbqVNJvyuinHMSX8jo4W6dTLfIpEAJmVjT1cKjhUv+JtZbcfk2qdr0nG5qB
 dbAJM0LSYUgcdTy34bky5GLeS+jZo88IftYJCqQYFiWz9NjJZ7meEDFhI2sYCosD+oik
 zWR+Gnk1kmwj5G7EmldieH5g2gcmxQso4MI9OF0npLXFCBtsURNH7P6J5jc6h7NGA/d7
 id7A==
X-Gm-Message-State: AFuF++nnq8P2r/gJqblSJFIk7UAT9WNitQ4fdsQgxcOjBVto+KlXqnAn
 MikEjtxjf9pqY0fi8V8XafpOc1xBGjK3kHv2WLCdcUVYImvRDbS4HJMhoHhbEO9jrbfRYxGu4bw
 lE09c
X-Gm-Gg: AR+sD11n63AuNjKiQt5UuE4pbai/4TmenzzKZAf2UjR6/zdS+HWZrV88jY1F0up8hqX
 JzUwJm9NSeCFdFjVw2kAMLvFIRvK7OCDVqrD6HB/bbwSJ6/DOp4q21Hcg6toIoFpIJeoDfxjH86
 d83SPBX5CHY/Ts0M4Yszpvy7hqauxuCwtxQEFM91sEm+r3Q73dv0oGwV2D56/Yo5Su8Hh5Q7A8T
 UW7wD80WL01QHG7cCvJHuzR+LGeqMTEs8WBhxKW1X7xJbrbNb3m21sTNDlNRfe5k041RYdANtBA
 igcN10YE1I9fFO/zWHcka6T34tkPdU6QxwHM89Pd3ZB8CruONsQlJ2okB/q0JZnhuYU4ujZRFZ2
 rau2MczKbWuk0OeO9Mo+JmBvArs19H7KPoiAhKw+1zNejoNQNch/0IOA9mnGe8RvOTPmYG0wPRy
 nxC+6n7jVDPY2jxq8plSFwoix8qWW/F6pRvekFY0YrIJ/B1SKaBWDS+a234o7eoDIOinuON92gl
 lYH25O/nHQXtpSYrMuYr6Zl9oM=
X-Received: by 2002:a05:6a00:3cd1:b0:848:5f4f:289d with SMTP id
 d2e1a72fcca58-851f99a9153mr13582218b3a.4.1787340574097; 
 Fri, 21 Aug 2026 12:29:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH v2 27/68] net/bnx2x: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:22 -0700
Message-ID: <20260821192646.146382-28-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

