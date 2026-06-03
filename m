Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC448CD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 21:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADA8E40664;
	Wed,  3 Jun 2026 23:12:00 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id D0C1B402BC
 for <dev@dpdk.org>; Wed,  3 Jun 2026 23:11:58 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2c0c379e8ffso24035ad.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780521118; x=1781125918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pam5H9U+43PNlj5OJLQV1Uzu6CHHcN6qYcpRucGBGPc=;
 b=gY5xiAbdnKvmgmNkInTyABjdS4DOWigAtsL6nZdWQNxthkmkTJdaEprSQdxlQzuP9y
 XiHIqRkw/U3Gv5tWJfJAY6ZIPVVz3A9+qQxd1LWuTdlj2AeFndv2l62VGMc0W/IYjIEX
 hlWnv/xYNjRIT82EyG3sTRGXRx/F+DoslC6gKnDJhRZFciQKATn46hplW7Z+MAICvIfa
 ZT/HF/HQ3j3mNzkiA2PwF05a+rZMG8US/ykGTchF8AmHKnjlg2srju+6B4mzbJ+CVAtl
 qjV4syAXs0EczpYOU5rgF5GYtaPIXNigQTfsEiKKsM1x8qbuMlRPtEha14cdycNQ0r8e
 ECvA==
X-Gm-Message-State: AOJu0YyeN1uq1UVLefWZmirfJXaKLG1bT5arRFSmBUK+fBLvTCAycL/v
 aOJW+KtVohc6+uEoo5CZxL3APoQsSnwZo6mWAJwHbT8ZEZ5MjbeQKGmXCJfkmxE1+AI+YSP58mX
 AybqwMiO8KtdQO8Icm9XVSxyVX1l9MlJpFvovzIhoxTfexkV5kzJh0MM0AQlsLsSI6BjXA4u0d+
 /8KaQAlwkpWDzOTxKmNALJRiYCovD/xrt8FPFKPCUH25iNmW9B+KX2ov64VUeHmOIEYZAJnvVZR
 0IceGvocMpd
X-Gm-Gg: Acq92OEf0wl72ZEinDZq2uPuLIV9RM/k0rk/CYMXEVwwzWmXwbfZWPc/rJAAAzkBhAY
 nQ0LDuUx+CkAceG9oo1gf5pYeTU1iJJfDQgbCkJS3nhCczOxlbRkDS4oZquTWzb517tuX/je9au
 /E4dw2OIhlKniE1KqFypw54S+fvwodA0usZtIXCvJDaJ6YyEAEsGvDsfcvrOVaHz26X2EtImjKZ
 ird/cExGwbfC755rS1UN0Qmp5X3UEtyNEgZtK12D8xRo+kTWu25m6ntcSqxODOYUJgf3T8gUtXp
 FNmp4gb4UY6MY5VFsIHfTIc8C7VXY2cV9tUgjRHFI0oMPz7y6bgBWGjGO7a5HKs6Nf+cxtCX+rg
 qfHOxcpPnY9sS0N1pE8EmC+4S827jeFuYOekdYAZFmBhVJnGPK3Ihvnha7Is5MRDaWEZflf17if
 qQbBg+NOO83D8fF7DT5AvxrT93HX0u2ICKIRm1T6xUTM7zscPcZNFbcDV7iC8Ohna4kv0zYzfSK
 9shL6mSNQ==
X-Received: by 2002:a17:902:ea0d:b0:2bf:1486:e6bc with SMTP id
 d9443c01a7336-2c163db5c10mr54450725ad.29.1780521117792; 
 Wed, 03 Jun 2026 14:11:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c1664a48e6sm3333255ad.49.2026.06.03.14.11.57
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 14:11:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8cce2b4c290so136116446d6.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780521116; x=1781125916; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pam5H9U+43PNlj5OJLQV1Uzu6CHHcN6qYcpRucGBGPc=;
 b=GcIl1d2T2M0ImxKX6bqIdas+C4fXB2PG5c5/uTQ+rImw6FqIxTqGI88CYtwCjR1hAI
 22FWIAa5qdY0NmwveBBctRB3C/Bh8TU8nea9t2fEjVTkyLjaRqJXW0NUGOreu+bVYMPB
 g+3f4AH7wpYAeMrC0V3iOxkg1wEM5jxGdz54A=
X-Received: by 2002:a05:6214:e48:b0:8ce:abea:4735 with SMTP id
 6a1803df08f44-8cecdd13b69mr73895006d6.39.1780521116309; 
 Wed, 03 Jun 2026 14:11:56 -0700 (PDT)
X-Received: by 2002:a05:6214:e48:b0:8ce:abea:4735 with SMTP id
 6a1803df08f44-8cecdd13b69mr73894436d6.39.1780521115700; 
 Wed, 03 Jun 2026 14:11:55 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd0520d3sm31665416d6.27.2026.06.03.14.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 14:11:55 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 2/5] net/bnxt: use buf address for external mbuf
Date: Wed,  3 Jun 2026 15:13:38 -0600
Message-ID: <20260603211341.2112344-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
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
addresses. An inline helper bnxt_mbuf_buf_addr() computes the
buffer address as buf_addr + data_off and is used for both the
first segment and subsequent segments when the mbuf is marked
as RTE_MBUF_F_EXTERNAL.

Fixes: 42b883535804 ("net/bnxt: use new API to get IOVA address")
Cc: stable@dpdk.org
Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_txr.c | 10 ++++++++--
 drivers/net/bnxt/bnxt_txr.h |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

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
+		txbd->address = rte_cpu_to_le_64(bnxt_mbuf_buf_addr(tx_pkt));
+	else
+		txbd->address = rte_cpu_to_le_64(rte_mbuf_data_iova(tx_pkt));
 	*last_txbd = txbd;
 
 	if (long_bd) {
@@ -482,7 +485,10 @@ static int bnxt_start_xmit(struct rte_mbuf *tx_pkt,
 		*tx_buf = m_seg;
 
 		txbd = &txr->tx_desc_ring[prod];
-		txbd->address = rte_cpu_to_le_64(rte_mbuf_data_iova(m_seg));
+		if (m_seg->ol_flags & RTE_MBUF_F_EXTERNAL)
+			txbd->address = rte_cpu_to_le_64(bnxt_mbuf_buf_addr(m_seg));
+		else
+			txbd->address = rte_cpu_to_le_64(rte_mbuf_data_iova(m_seg));
 		txbd->flags_type = TX_BD_SHORT_TYPE_TX_BD_SHORT;
 		txbd->len = m_seg->data_len;
 
diff --git a/drivers/net/bnxt/bnxt_txr.h b/drivers/net/bnxt/bnxt_txr.h
index fd92a242c3..43c104c9eb 100644
--- a/drivers/net/bnxt/bnxt_txr.h
+++ b/drivers/net/bnxt/bnxt_txr.h
@@ -44,6 +44,12 @@ static inline uint32_t bnxt_tx_avail(struct bnxt_tx_queue *txq)
 		 bnxt_tx_bds_in_hw(txq)) - 1);
 }
 
+static inline uint64_t
+bnxt_mbuf_buf_addr(const struct rte_mbuf *mb)
+{
+	return (uint64_t)mb->buf_addr + mb->data_off;
+}
+
 void bnxt_free_tx_rings(struct bnxt *bp);
 int bnxt_init_one_tx_ring(struct bnxt_tx_queue *txq);
 int bnxt_init_tx_ring_struct(struct bnxt_tx_queue *txq, unsigned int socket_id);
-- 
2.47.3

