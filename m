Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD92DCD6E6E
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 00:48:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78D1740668;
	Fri,  5 Jun 2026 02:48:34 +0200 (CEST)
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com
 [209.85.219.97]) by mails.dpdk.org (Postfix) with ESMTP id 7E32F402E0
 for <dev@dpdk.org>; Fri,  5 Jun 2026 02:48:31 +0200 (CEST)
Received: by mail-qv1-f97.google.com with SMTP id
 6a1803df08f44-8cceaacd07bso13538066d6.3
 for <dev@dpdk.org>; Thu, 04 Jun 2026 17:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780620511; x=1781225311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6iFTipU5v8FbncuG49GPuTtcQs1KC/81ExKL+XI0ogo=;
 b=Y6HJInYCDFuViD1ZfwtiKftYVR9BFUpb5KOyuVKZKaw7RpKIpqs9VURDpDDqhucJF5
 PihDYsFBuHLmQcvT01N9qTYJw3f0F76auXyxAKg/zPIQ9ddw6/dXweM3p1MSqjiqyvMT
 X4sF8qOp/VLbVBreSsuzYMHpTMkTrB5tDiE28Kx9HXwYEBBd6J/CP+/I214gWoJGW4S0
 vm5bdxs6zhpE3xv6FQFfqf5tlu1K9NacEiXj7eX+wh+qScz7xrfAt/WCu85+kYtXtb2U
 2f1HXQsySxKj2YTrG/Sk8nt7R1xmh9uXmfdYQQEh8fGQ6SSG61Q8+vbhhMFUIQ7utUO6
 QQ1Q==
X-Gm-Message-State: AOJu0YxmRhebV+WW/mXGy/5V3buGRZahPFgATEBLEmgUjnd3MUaIeTk8
 aK/6PAa68fjeMqhS58r6EWrj5W02qpPxto+zO9QOLrOcswq77+hmdRv5tmg47NIjaz1MJeoTs27
 o+/pyrAGtyPzFZ20YulPBXPwwnXJxZCKw+O+y3N6HNcKBBig1J3pVTsbEAuNFAwnHqIzkwmdTK6
 jf2tXJcWVUSpMEO5gUDTPsysovaWPhk2G4Xj2j3c/ISEy/wUz9JLHruh9cwSaEfdJlW5d2Ryc1z
 L/4+OJrh8vj
X-Gm-Gg: Acq92OFMohsUxIDALuKDowlHphlD45w1AO11MscxViFD/9cLgEJ1lmvfgNBVM3NqA6m
 +cdNmYaSmVm1pLQuWb8Q9eyXOHz5RBrFDjTrn0UxA+BqOyqQ4DMO5hBKw06dwu02EMlBUzcTgCz
 ifSzgIdaS4XimPocQ3o7XrHpz5F6iXyn56AZq2iM4AqchC7jmtsPPbdy5wWMcr3CgCXXS0NpIUT
 w/AoGST2YCuxSjJ4doNcLetvSGwuYBQBsIJC/N+I3qP2sV8jXRXH9jGzbmCPdO/sVQk+1XGOfUc
 yv7F21WNJLs0Ij7ekYYdjWmmMQr+F8PsRQlAg9soKqRl1NDylEnJUxiQ09IuupT1lgFveOLr+a/
 gmsy9ZQUmoFxqrZqNUmcj3+xyw78nVG1qHlH06pMP57Hc6I7Fr1NjFl3gz04uhBf6gE6s9Wf5bm
 JeBILN5N7M3dEoF5lKiX45uEunTad5WWIZSP+7eU6XltaChToJMZHv9KqedRs2YY+tQ6SCVsD8G
 4rBV0BTTYLs
X-Received: by 2002:a05:6214:16d0:b0:8ce:f1b:74e7 with SMTP id
 6a1803df08f44-8cee6135e46mr19092356d6.25.1780620510568; 
 Thu, 04 Jun 2026 17:48:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-8ceccbaa13dsm3494146d6.7.2026.06.04.17.48.30
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 17:48:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8cced2dabc1so5256626d6.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 17:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780620510; x=1781225310; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6iFTipU5v8FbncuG49GPuTtcQs1KC/81ExKL+XI0ogo=;
 b=Q53dSMDc85hHpaG5Z+BEOHKwDe5j9dA7sSxDTmanEaBacqiSjJoj2UVdH0eDEPGrvi
 rbW+MdS46DpHPAoiw1qleZQTO1CNz2EcNIYHEPQLZjDM5w/TTkOL0pQuG73h52GQNaep
 YbicJd49sNWSiUyz260+5quAF3q8CHX5ua98A=
X-Received: by 2002:a05:622a:480d:b0:517:8da1:4d5 with SMTP id
 d75a77b69052e-51795a256c5mr20543601cf.27.1780620509779; 
 Thu, 04 Jun 2026 17:48:29 -0700 (PDT)
X-Received: by 2002:a05:622a:480d:b0:517:8da1:4d5 with SMTP id
 d75a77b69052e-51795a256c5mr20543261cf.27.1780620509295; 
 Thu, 04 Jun 2026 17:48:29 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd0556c0sm67187396d6.25.2026.06.04.17.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 17:48:28 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 2/5] net/bnxt: use buf address for external mbuf
Date: Thu,  4 Jun 2026 18:50:13 -0600
Message-ID: <20260605005016.2290160-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605005016.2290160-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260605005016.2290160-1-Mohammad-Shuab.Siddique@broadcom.com>
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

Use buf_addr for mbufs from external pool instead of using iova
addresses. Uses rte_pktmbuf_mtod_offset() to compute the buffer
address for both the first segment and subsequent segments when
the mbuf is marked as RTE_MBUF_F_EXTERNAL.

Fixes: 42b883535804 ("net/bnxt: use new API to get IOVA address")
Cc: stable@dpdk.org
Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_txr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index fb5be224d9..51b886c1a6 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -325,7 +325,10 @@ static int bnxt_start_xmit(struct rte_mbuf *tx_pkt,
 		txbd->flags_type |= TX_BD_LONG_FLAGS_LHINT_GTE2K;
 	else
 		txbd->flags_type |= lhint_arr[tx_pkt->pkt_len >> 9];
-	txbd->address = rte_cpu_to_le_64(rte_mbuf_data_iova(tx_pkt));
+	if (tx_pkt->ol_flags & RTE_MBUF_F_EXTERNAL)
+		txbd->address = rte_cpu_to_le_64(rte_pktmbuf_mtod_offset(tx_pkt, uint64_t, 0));
+	else
+		txbd->address = rte_cpu_to_le_64(rte_mbuf_data_iova(tx_pkt));
 	*last_txbd = txbd;
 
 	if (long_bd) {
@@ -482,7 +485,11 @@ static int bnxt_start_xmit(struct rte_mbuf *tx_pkt,
 		*tx_buf = m_seg;
 
 		txbd = &txr->tx_desc_ring[prod];
-		txbd->address = rte_cpu_to_le_64(rte_mbuf_data_iova(m_seg));
+		if (m_seg->ol_flags & RTE_MBUF_F_EXTERNAL)
+			txbd->address = rte_cpu_to_le_64(
+				rte_pktmbuf_mtod_offset(m_seg, uint64_t, 0));
+		else
+			txbd->address = rte_cpu_to_le_64(rte_mbuf_data_iova(m_seg));
 		txbd->flags_type = TX_BD_SHORT_TYPE_TX_BD_SHORT;
 		txbd->len = m_seg->data_len;
 
-- 
2.47.3

