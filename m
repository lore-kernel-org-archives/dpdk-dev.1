Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AADCD6E55
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 03:17:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 819524067C;
	Thu,  4 Jun 2026 05:17:14 +0200 (CEST)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id 830A24065D
 for <dev@dpdk.org>; Thu,  4 Jun 2026 05:17:13 +0200 (CEST)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-36bdb11bf8bso99552a91.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780543033; x=1781147833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HBIPbKeJJjl42Y69Wv4BGB6557rqVe7gQmrrB0hbqHk=;
 b=Z+yxwY4W14WlN1jNTO/pPMhH3zTI0xbWKzja46+rXCkAqZ5wJjEHwbhysuNYAJ+2cL
 4akz5BGDQ9kz22uXolZNjRqLUpFQHndM1xL8eYsfQGzzZtbrLatwxDC+bDNEHhw3314X
 AZIco6GHc/JbrAxotR7F7HxjLEQLnCY+6aNu54jipcamtuT6fd744V01tl4/aMpj5bZt
 0Bf0dsk8Lrdxq3cQFxLA82PO3Td5VODcutT0Dv1hIg7H6gIETB5ZenoO9lMysviDvE/B
 N8coX/qj9FmPj/iujHisJtbhuhJCZZA/fdYyAgA6lOaFltA0tQAu6NgFzFzRSjrI1EsX
 6IDg==
X-Gm-Message-State: AOJu0YxKPcageq7NU2j4zL4SjXLfOmjpAtQfoLwrOPfB6RTdbbm5YSlO
 Mwwi/NcEYcftvDtD8OrqJTf5ZoLnXfXIPdFz/83LXO0gOD60vUBjjy5JtpQyTMISYGqGfa00Y7u
 XR3wIYzGHkzir9vWkfnUtQduluu6XIPgAP7qx9s8bGmW3Eswhz/hqS7bWA+0NzDIW/zck8P2bbx
 Cgfx5iFqoB17J/iEWzD45j6YH/iRYPQkx/V0m4IUmR/iZ1wHVY7GjNvu9CQmvxmxPq+cvs0X/DT
 E5PuRKisEy4
X-Gm-Gg: Acq92OHzt8DoLpXQXGlLrEtyNMZqBkIBQjKOyweI+jrEZXY4IaOBAg4lRUB5scrjbgs
 IGrqtHcsfzKfWaK3ar2GoSO7MRrd2hLGxeuhWMBL4kRoT2z+/GWS75aAZPqRNO9Y3iUC9ViqCKR
 h4uS4VzLjAGLkAfHuEHbBR0+iFqTTT1UIVVnF5bPaIQnz116NM8eaXALdq1/Il2S3rCPBVoI/Kx
 rItqmMIQPJ7xsdPO7W38gyTZYUVs1pZg1p7UWyDe2TEI+K45C/gEz8wHGNAcxslHxd+K8TllXgf
 WgAmK+OIZIpy0pseyFlqCKDx9H3H4AdlZWYfn/CJ7EX1OD9ZebQv2a/ealk3ecHpvAN8EmUxHTc
 UA+JZPirvnR1JYn4DJdvvpbO+xb3T8fqw4A0bs1+JLL6TpJrWFDqPHrn8+3fkdVSpu08JScd5Ne
 K604DmfO/fnfOapgAqiAHtK03N8NxpwA==
X-Received: by 2002:a05:6a21:48f:b0:3aa:f9cb:d41a with SMTP id
 adf61e73a8af0-3b497814d43mr6816299637.19.1780543032531; 
 Wed, 03 Jun 2026 20:17:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-84282340cdasm347147b3a.2.2026.06.03.20.17.12
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 20:17:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91550eceb13so55766385a.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780543031; x=1781147831; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBIPbKeJJjl42Y69Wv4BGB6557rqVe7gQmrrB0hbqHk=;
 b=ab1a1iL5Wuf6ot3G6gGq/K/bJSJdJ33g1uSZmKVluCtrhVVX6X0w4cfrVHblxXqNY9
 AnTTB7bizSFFjtcbeMch2PuxNx0Uq+q5D6zS/QOybSYE4sqp8SZ+fXIAxw3mDRfFmtRq
 laV6u4WZbDoWdV8AYaKZL4xxTSUxawtdWqRtg=
X-Received: by 2002:a05:620a:4543:b0:911:ddfd:634a with SMTP id
 af79cd13be357-9158a656541mr1054750785a.4.1780543031360; 
 Wed, 03 Jun 2026 20:17:11 -0700 (PDT)
X-Received: by 2002:a05:620a:4543:b0:911:ddfd:634a with SMTP id
 af79cd13be357-9158a656541mr1054748885a.4.1780543030867; 
 Wed, 03 Jun 2026 20:17:10 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a009fe7sm446421685a.8.2026.06.03.20.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 20:17:10 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Chenna Arnoori <chenna.arnoori@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 05/10] net/bnxt: fix RX timestamping for non-PTP packets
Date: Wed,  3 Jun 2026 21:18:46 -0600
Message-ID: <20260604031851.2267548-6-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Chenna Arnoori <chenna.arnoori@broadcom.com>

When the adapter is configured to timestamp all incoming packets,
timestamps were silently missing for non-PTP traffic (such as IPv6
packets). A previous update incorrectly restricted the timestamp
processing to only recognised PTP packets by changing an OR condition
to an AND condition. This is corrected so that timestamps are properly
extracted for all received packets when promiscuous timestamping is
enabled.

A comment is added to clarify the two conditions under which the
hardware timestamp is extracted from the completion record:
1. The packet is explicitly classified as a PTP packet (with or
   without timestamp).
2. Promiscuous timestamping is enabled (ptp_all_rx_tstamp), which
   instructs the hardware to timestamp all packets, including
   non-PTP traffic (e.g., IPv6).

Cc: stable@dpdk.org
Fixes: 925cd0705836 ("net/bnxt: update PTP support on Thor")

Signed-off-by: Chenna Arnoori <chenna.arnoori@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxr.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 046276f931..ee49d85d43 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -1203,13 +1203,21 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 	mbuf->data_len = mbuf->pkt_len;
 	mbuf->port = rxq->port_id;
 
-	if (unlikely((((rte_le_to_cpu_16(rxcmp->flags_type) &
+	/* Extract the hardware timestamp from the completion record if:
+	 * 1. The packet is explicitly classified as a PTP packet (with or
+	 *    without timestamp), OR
+	 * 2. Promiscuous timestamping is enabled (ptp_all_rx_tstamp), which
+	 *    instructs the hardware to timestamp all packets, including
+	 *    non-PTP traffic (e.g., IPv6).
+	 */
+	if (unlikely(((rte_le_to_cpu_16(rxcmp->flags_type) &
 			RX_PKT_CMPL_FLAGS_MASK) ==
 			RX_PKT_CMPL_FLAGS_ITYPE_PTP_W_TIMESTAMP) ||
 			((rte_le_to_cpu_16(rxcmp->flags_type) &
 			RX_PKT_CMPL_FLAGS_MASK) ==
-			RX_PKT_CMPL_FLAGS_ITYPE_PTP_WO_TIMESTAMP)) &&
-			bp->ptp_all_rx_tstamp) && bp->ieee_1588 &&
+			RX_PKT_CMPL_FLAGS_ITYPE_PTP_WO_TIMESTAMP) ||
+			bp->ptp_all_rx_tstamp) &&
+			bp->ieee_1588 &&
 			bp->ptp_cfg) {
 		mbuf->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP |
 				  RTE_MBUF_F_RX_IEEE1588_TMST;
-- 
2.47.3

