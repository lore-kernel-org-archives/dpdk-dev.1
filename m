Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB6DFEFB51
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 20:19:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FBA140A77;
	Fri, 27 Feb 2026 21:19:21 +0100 (CET)
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com
 [209.85.161.97]) by mails.dpdk.org (Postfix) with ESMTP id CE46F402C6
 for <dev@dpdk.org>; Fri, 27 Feb 2026 21:19:19 +0100 (CET)
Received: by mail-oo1-f97.google.com with SMTP id
 006d021491bc7-66f747175d8so1200023eaf.0
 for <dev@dpdk.org>; Fri, 27 Feb 2026 12:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772223559; x=1772828359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMSY7IYpjEjSxAX+kdBvJz098v6fdtxY5MBStss4zrM=;
 b=ailNo+jRIk6FKvht2bpHNJ2I9a+PWKAumVcv+HpXuPLzazoPrWrOuUUc5sos9cx9Uw
 w6xk5WP8MpuirX1oSqr80egTQZMql++tQu0kprLazAsX5Vu93n6Qi02EeVJcQCMCnLcg
 nXIxcrhCKuq9DRX8Ns09Bd2LahUweRAAadq5yA2Zv0HRSpWBHQV9qvyxvdEfGS4HxrkV
 S3+yaoW1UIIQGtEinMLrqUw0ofYV90Bg/Y2HRwbTLQIiLKQ7IxAcoRCwb5LNFvMKGGKf
 kC1MSf/gIsjRUZysCXrfViTkkDnL+3CPByA82MwUQgBhB1GJ1Z6LvFzUtqBRGINYfW4p
 M+Dw==
X-Gm-Message-State: AOJu0Yz/juWqg6CnQbp82pIs/BRsApxQc6Y7RlqKsB9vSBQzeUixkHdn
 fyKozz1y1H85ohIueyCrq2KHSDh4+3/tOiGXXoKJYxvKJKwJLyRrCIDbwpyZU1eGmVkJmH8kVzl
 zLgEdhmQIKqp8iuay+CrVUZBNG9DKvuZLM+APq4JRB4SceeiocPcZZYCdP65JFQS5SQIBxrRKkG
 8cwmd6Qa/vhVhjM9lrrR1GWmuph6w/4eA79VIhQ20A0PMlou85uIy5w24rkkCsnswZd+6Fz1R54
 Mro11OIS91Z
X-Gm-Gg: ATEYQzwkzsrjgJP+WMelkBY5gkvdEJOLjec2vRBdbMKaOdVEUCrnSKB1Ndo1XpYTZey
 JF3jc/OQC3G7PDs6Xcm9ZLLmpRpChE3nZ1yMIDDaRD/3WFJW5TsBrlIh5yZx33lFpfTlP0P2+0M
 sB4hNoJj0z/g6cYIwfb8v4oxti8ir49UPO6pnY3sUwDAdU6mSYj4ExXHD8ouJ/bJf0WuDDWAp7Y
 LbDG9/wuiiox+Xcd2cL4xxhJCCzqMnsBV7VMqXVVsxxP8tBwsXbQMCUdpuhwqgtTCac8s2dEmqu
 d65RINFmw7BT4uBoYj5nhwbWHTLCRImLQCa9ub7kXfq/vnhGNidB3hD8tp2WCp37RsZTJC8psB4
 uYxpQd3BsFoKmhE747Ikorce4CaQhPheAWp6ogTLt8NzlZzsnsYTOs5BG6KhutusUsLDsutQi5T
 jwa103StKh5ndJzQUGikis4q8up9sCotGF7NYI+j08dQPfrcVk3xDb7yT16kIEzPA3fdUESJLf2
 Q==
X-Received: by 2002:a05:6820:2089:b0:678:7fa2:aa6 with SMTP id
 006d021491bc7-679faf41696mr2641824eaf.57.1772223558729; 
 Fri, 27 Feb 2026 12:19:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-4160d21f7aesm800537fac.9.2026.02.27.12.19.18
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Feb 2026 12:19:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-896fae40578so278275706d6.0
 for <dev@dpdk.org>; Fri, 27 Feb 2026 12:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772223557; x=1772828357; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OMSY7IYpjEjSxAX+kdBvJz098v6fdtxY5MBStss4zrM=;
 b=EmBLqfBCOq2sI3rdoA0V1cZf8OqbfFdzbbpe4RMhVyzJX+xL0zWKoSjmcBbm3GLtjg
 /4b1vpDeFt4XHpBIF6WIqgmO8BclNA93rU/qOp9F0vXacI17L+NGY0pWSyxtrRUZ0x+q
 07QEiPHMs4WIHHdHWtXBoEJJhz1yTogESU7MQ=
X-Received: by 2002:a05:6214:21e8:b0:899:bd86:4ff9 with SMTP id
 6a1803df08f44-899d1d56d0cmr63873296d6.5.1772223557710; 
 Fri, 27 Feb 2026 12:19:17 -0800 (PST)
X-Received: by 2002:a05:6214:21e8:b0:899:bd86:4ff9 with SMTP id
 6a1803df08f44-899d1d56d0cmr63872846d6.5.1772223557190; 
 Fri, 27 Feb 2026 12:19:17 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6f9261sm544113485a.26.2026.02.27.12.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:19:16 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH] net/bnxt: fix reported VLAN stripped flag for Thor 2
Date: Fri, 27 Feb 2026 13:20:29 -0700
Message-ID: <20260227202042.71404-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

Modified the way that the scalar path reports VLAN TCI
and the RTE_MBUF_F_RX_VLAN_STRIPPED flag.

Bugzilla ID: 1868
Fixes: 65d2b0557ba3 ("net/bnxt: support Rx completion v3")
Fixes: daa02b5cddbb ("mbuf: add namespace to offload flags")
Cc: stable@dpdk.org

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxr.c | 3 ++-
 drivers/net/bnxt/bnxt_rxr.h | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index c94abefa01..eb01132f48 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -1115,6 +1115,7 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 	uint16_t cmp_type;
 	uint32_t vfr_flag = 0, mark_id = 0;
 	struct bnxt *bp = rxq->bp;
+	struct bnxt_vnic_info *vnic = rxq->vnic;
 
 	rxcmp = (struct rx_pkt_cmpl *)
 	    &cpr->cp_desc_ring[cp_cons];
@@ -1198,7 +1199,7 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 	if (cmp_type == CMPL_BASE_TYPE_RX_L2_V3) {
 		bnxt_parse_csum_v3(mbuf, rxcmp1);
 		bnxt_parse_pkt_type_v3(mbuf, rxcmp, rxcmp1);
-		bnxt_rx_vlan_v3(mbuf, rxcmp, rxcmp1);
+		bnxt_rx_vlan_v3(mbuf, rxcmp, rxcmp1, vnic->vlan_strip);
 		if (BNXT_TRUFLOW_EN(bp))
 			mark_id = bnxt_ulp_set_mark_in_mbuf_v3(rxq->bp, rxcmp1,
 							       mbuf, &vfr_flag);
diff --git a/drivers/net/bnxt/bnxt_rxr.h b/drivers/net/bnxt/bnxt_rxr.h
index 7357ca4427..f6d1e3ddfb 100644
--- a/drivers/net/bnxt/bnxt_rxr.h
+++ b/drivers/net/bnxt/bnxt_rxr.h
@@ -474,11 +474,14 @@ bnxt_parse_pkt_type_v2(struct rte_mbuf *mbuf,
 
 static inline void bnxt_rx_vlan_v3(struct rte_mbuf *mbuf,
 	struct rx_pkt_cmpl *rxcmp,
-	struct rx_pkt_cmpl_hi *rxcmp1)
+	struct rx_pkt_cmpl_hi *rxcmp1,
+	bool stripped)
 {
 	if (RX_CMP_V3_VLAN_VALID(rxcmp)) {
 		mbuf->vlan_tci = RX_CMP_V3_METADATA0_VID(rxcmp1);
-		mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
+		mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN;
+		if (stripped)
+			mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
 	}
 }
 
-- 
2.47.3

