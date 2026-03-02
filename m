Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0115FEB3622
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 17:11:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BB7040E3B;
	Mon,  2 Mar 2026 18:11:42 +0100 (CET)
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com
 [209.85.215.225])
 by mails.dpdk.org (Postfix) with ESMTP id E3BD940E26
 for <dev@dpdk.org>; Mon,  2 Mar 2026 18:11:39 +0100 (CET)
Received: by mail-pg1-f225.google.com with SMTP id
 41be03b00d2f7-c70bb8ffb24so1706230a12.1
 for <dev@dpdk.org>; Mon, 02 Mar 2026 09:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772471499; x=1773076299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DNqog7/c6k383A8xaah7UlmoO2xhAdysH7Mt/VX6hXk=;
 b=NWO1TOCquZXlZ3y1vM0RjjRgrnmT+R/YyKxkk/ZhEgsSLkRQyixATvEsa6EbKlOIQw
 McuK4ZcBX6CSulBDv3knxa0vQ0cGnEhvnCmx+BZQKtfZubAGkZ5hKbwgzTIRyZCoJUts
 PLe2Ud2Q+2D7ob+CFDdF9a+IzJYTiaIXqXsKEZnr9hzwzA5CPV7qp4E2wTfAISPJ/qmN
 ogp20+/UYFHLwN3jcQSfWpaXCbaCa/UJvH21jmIdmBJWvq8WgF4Hz9WepbWZ66ckOXq+
 gr4UNvwNH+mxLrU0xTkXE8CocBevFqd+Fe3IofmsHaLe4/oLe0s9/Cf8DJQsTgJP1qgD
 PI4g==
X-Gm-Message-State: AOJu0YwAknwmQP5UFmwHRJ2OPPC8KTqRTwDhMMKRaAffets8m8pc9ooF
 qz7rpsaz405eoFMs2zDdPkMMiW0rUSHA2m0aLvkpkq1SIxOGqn73migbpy3PlURNmSIR2s5f54x
 hFkgHlTHvunEa0Emm3Hvd7NllvmVc6wRNt7QlafEVKs6qE9OK07tPohcx4d/Gmt5eYeNN84I+yA
 eeDOTXfyAqtqC5VqTJ9pPW27PXXI9S26WzXm0aAEVxjGCsKP1pJNqltt99WcXguY7sg5XpxpDR5
 6qYdsCQ4GzN
X-Gm-Gg: ATEYQzxhFgwgdk7gFylXQ/aTh35fR59tq5ov40w6/KCUFu6bYelZTGSWUWvN8YhAXKk
 gK2FFojBZby70bLIVIHTqJnv6ZUGxluCp3ef9PQbcFuCxi3Crj9+e1R0YePLkgEckhWsHL/QsVD
 /fEvjXjrnbuxUHwd4fLUlJuKITmIEQUyznTNzpMBfe+QuPniyz1h1w4iZMMqj33qEwf6lv1st7T
 +iTxzlXxhiCd+HBux+SJAtg8Wfz0hFpb0TQy6V2UqR2RyEUGcOMt7uSrnkvD0yhuiwW1tLQMtQx
 mW6oOLg/9xCHDH9nhliwsGyK82g4XlZeb7msUmvbH8dpbVMPRvawdZAwOUidLkFHCSHSZn+tmKM
 fxBGu/CfH/qJEEx3YtrqjDCiKDNHc6dX1FZ6N8zpX4gDaWUkvPDVDXCaQ/XkD1Z6LdUm3k/2Qgz
 FmR+M/wosRAcI5t8BmrP8Qe4ASI+mOJRgwKqV9GfrzZMH5XzMOCZbikP+JA4kca14TkJgA
X-Received: by 2002:a17:90b:3c88:b0:359:7e05:cc8d with SMTP id
 98e67ed59e1d1-3597e05ccb3mr6198851a91.8.1772471498927; 
 Mon, 02 Mar 2026 09:11:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3598c04a8basm586208a91.6.2026.03.02.09.11.38
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:11:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1275c6fc58aso9731551c88.0
 for <dev@dpdk.org>; Mon, 02 Mar 2026 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772471497; x=1773076297; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNqog7/c6k383A8xaah7UlmoO2xhAdysH7Mt/VX6hXk=;
 b=PXhGstQ3EU2Hc8I8Fhvcc0l3WKlpHwufhZDiUZtzKqzLnwx4LobGLzk92AvrgWTik4
 wlrpMK72+cvSrGAddvaAKHwLezEYzkXedADtBtbyrAUUJWpEKusOT7oM3tEX68OJN67N
 3SYop65joKAKTYLI8VQ6n0IYqb9/ofcw+EXH4=
X-Received: by 2002:a05:7022:6624:b0:11b:b3a1:714a with SMTP id
 a92af1059eb24-1278fb78dd9mr4186884c88.12.1772471496706; 
 Mon, 02 Mar 2026 09:11:36 -0800 (PST)
X-Received: by 2002:a05:7022:6624:b0:11b:b3a1:714a with SMTP id
 a92af1059eb24-1278fb78dd9mr4186868c88.12.1772471495949; 
 Mon, 02 Mar 2026 09:11:35 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789962f89sm13910511c88.0.2026.03.02.09.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 09:11:35 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 1/4] net/bnxt: support handling PTP frames in Rx
Date: Mon,  2 Mar 2026 10:12:33 -0700
Message-ID: <20260302171236.98625-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302171236.98625-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260302171236.98625-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Ajit Khaparde <ajit.khaparde@broadcom.com>

Support handling of PTP frames in the Rx path.
This feature is available in scalar mode data path.
If the Rx completion indicates a PTP timesync packet,
update the mbuf ol_flags accordingly.

This feature is not available in the compressed Rx CQE mode.

Cc: stable@dpdk.org

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxr.c | 11 ++++++++++-
 drivers/net/bnxt/bnxt_rxr.h |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index c94abefa01..ac4c61b850 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -724,7 +724,7 @@ bnxt_set_ol_flags(struct bnxt_rx_ring_info *rxr, struct rx_pkt_cmpl *rxcmp,
 		     RX_PKT_CMPL_FLAGS_ITYPE_PTP_W_TIMESTAMP))
 		ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP | RTE_MBUF_F_RX_IEEE1588_TMST;
 
-	mbuf->ol_flags = ol_flags;
+	mbuf->ol_flags |= ol_flags;
 }
 
 static void
@@ -1182,6 +1182,7 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 	if (mbuf == NULL)
 		return -EBUSY;
 
+	mbuf->ol_flags = 0;
 	mbuf->data_off = RTE_PKTMBUF_HEADROOM;
 	mbuf->nb_segs = 1;
 	mbuf->next = NULL;
@@ -1199,6 +1200,14 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 		bnxt_parse_csum_v3(mbuf, rxcmp1);
 		bnxt_parse_pkt_type_v3(mbuf, rxcmp, rxcmp1);
 		bnxt_rx_vlan_v3(mbuf, rxcmp, rxcmp1);
+		/* Packet cannot be a PTP ethertype if it is detected as L4 */
+		if (mbuf->ol_flags & RTE_MBUF_F_RX_L4_CKSUM_GOOD)
+			mbuf->ol_flags &= ~RTE_MBUF_F_RX_IEEE1588_PTP;
+
+		/* If its a PTP frame, ptype cannot be L2_ETHER */
+		if (mbuf->ol_flags & RTE_MBUF_F_RX_IEEE1588_PTP)
+			mbuf->packet_type = RTE_PTYPE_L2_ETHER_TIMESYNC;
+
 		if (BNXT_TRUFLOW_EN(bp))
 			mark_id = bnxt_ulp_set_mark_in_mbuf_v3(rxq->bp, rxcmp1,
 							       mbuf, &vfr_flag);
diff --git a/drivers/net/bnxt/bnxt_rxr.h b/drivers/net/bnxt/bnxt_rxr.h
index 7357ca4427..5e5496964f 100644
--- a/drivers/net/bnxt/bnxt_rxr.h
+++ b/drivers/net/bnxt/bnxt_rxr.h
@@ -535,6 +535,6 @@ bnxt_parse_csum_v3(struct rte_mbuf *mbuf, struct rx_pkt_cmpl_hi *rxcmp1)
 	uint16_t error_v2 = rte_le_to_cpu_16(v3_cmp->errors_v2);
 	uint32_t flags2 = rte_le_to_cpu_32(v3_cmp->flags2);
 
-	mbuf->ol_flags = bnxt_parse_csum_fields_v3(flags2, error_v2);
+	mbuf->ol_flags |= bnxt_parse_csum_fields_v3(flags2, error_v2);
 }
 #endif /*  _BNXT_RXR_H_ */
-- 
2.47.3

