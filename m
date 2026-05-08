Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91C2CD3445
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 19:11:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BD8F4067B;
	Fri,  8 May 2026 21:11:19 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id B7D2E40665
 for <dev@dpdk.org>; Fri,  8 May 2026 21:11:16 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12c8ccc7755so3706308c88.0
 for <dev@dpdk.org>; Fri, 08 May 2026 12:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778267476;
 x=1778872276; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKGLn2ORT0jWA7KVMkQn75W2XqDrUDze6YZnyScZQIY=;
 b=y7nEozw9NgfE6Dq5VIlTj3rRcbOg1HQ3PYagpgM1z+m/J30nAeQ0cZ63ke//puXx0D
 KVaja1P820JxefVPjz6BFdJLk7P+wIbwz40fFWOJb2U9VlNhk7g9+BK/VXXeR9jO/1AF
 BEVg9EvCpAIbVsrD2zlXdvyesNxELgu3Aaxt6k5EqIVoKi826xFKLw1VVYfSYMAydTo0
 mjOcEWiD3uasmFNeAeJmGmBOr8TdOWaM5kDwqXyAkRgHJMyIiyScNo/xghX1cB7a4eRb
 cml+ojSbsbrx1kx1Au3bhm2S+IANPs9cKOJhQrA3z+3KGoTfiJRzjJbKb5mW+fdVv1UB
 Fvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778267476; x=1778872276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oKGLn2ORT0jWA7KVMkQn75W2XqDrUDze6YZnyScZQIY=;
 b=GQ2fVCEAgv2mRRRVjOmrALM6/ZggQK7/yGaZtxWlvp5eJ5mxfsNrpQu5WG5YxWBg82
 esguMSmssbDs3/lyTAjjkp2/oRyycl3A/Zt8Rw7WQQ45rNjVLRPeS0o42rxiB0BI1PXR
 /nKI2WUSLjt85iLQCBGlEFz77tVMEpVTzqKKg3r6e0W7yURhIPeTOe2OaYw9jMlhGIzh
 6Bk82lTobCWpK67nX8cnHBoTTaSnUeLtRKUjhTFKeIICoHILQeeuuJITtim5U9xLNyMA
 qkBF9fjf3NVj+QeBo/2N3AU1mgC5seDvQ5/28mtLNZdF1kYlRUiQcDo4ZdOu5YFNV3r6
 bDcw==
X-Gm-Message-State: AOJu0YzPgq+dH++1Y0Sm/UYwmtHX6q4qZPk00UHtOnM3Bh43ZAq2q4Af
 cdlbTpNRnRJtsiyMcPJamGN8cewvB/0Qcs9zY4dUN6idiCB9acNg38gove6MgpkfqzW5PHNJIP2
 FB+3E
X-Gm-Gg: AeBDievGJllvV7TxcmD03Vj508iO4yKQ+4+Q2aBUAQs+/RQsOnHFLXOJmGjOkM7qEZj
 Rjn7GUVgVjA+ChuKq8bQ191SqFt1G8WxTxHOkXeamLmbH/fvNLH5KEXXspiqhgT3IZl7mlER81+
 7DsVwDhw51bbjXAboTX4sc+UQTaJ7tS0j5Pm2APv+CAMxfYX9wNgQk91yLiCAlxiS+DXjaN2H0k
 8PL0A8nzsm15uJlxhYi7D+ZQ0Llg9/o3CIUXi1jw7urhdQVXwMfuDLxnyf5gO4Eq69m88THIpNZ
 Afsl0edIB1KDIfXLT6Jz+gcp5h6xAOOdaAw31zvWjVLT+Pw6QL7vv6hoWdn7Q3VgJmOxEyRwanK
 Sq8Zr2/B9AKfH55QPM5wss8iAdoqJ0dUOgBQyF6HmWedIGQ//BYBx7cbFvBhHU48f4pd+d7AxRs
 I5scDJxTRxB45Y9F2R1aVURF/gpEtrdJGT
X-Received: by 2002:a05:7022:6609:b0:119:e56c:18ab with SMTP id
 a92af1059eb24-131853e9c33mr7397215c88.19.1778267475681; 
 Fri, 08 May 2026 12:11:15 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1329fc4bf3fsm212796c88.5.2026.05.08.12.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 12:11:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Ravi Kumar <ravi1.kumar@amd.com>, Amaranath Somalapuram <asomalap@amd.com>
Subject: [PATCH v2 4/4] net/axgbe: fix descriptor status out-of-bounds access
Date: Fri,  8 May 2026 12:10:52 -0700
Message-ID: <20260508191109.734377-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508191109.734377-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
 <20260508191109.734377-1-stephen@networkplumber.org>
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

Both axgbe_dev_rx_descriptor_status() and
axgbe_dev_tx_descriptor_status() compute the descriptor address as
desc[idx + offset] where idx is the masked ring position. When
idx + offset >= nb_desc, this reads past the end of the
descriptor ring buffer.

Fix by incorporating the offset into the index before masking,
using AXGBE_GET_DESC_IDX() which wraps with (nb_desc - 1).

Fixes: 0962b6055c08 ("net/axgbe: support descriptor status")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/axgbe/axgbe_rxtx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_rxtx.c b/drivers/net/axgbe/axgbe_rxtx.c
index 51a1aeb0b9..6f750d6ede 100644
--- a/drivers/net/axgbe/axgbe_rxtx.c
+++ b/drivers/net/axgbe/axgbe_rxtx.c
@@ -1205,8 +1205,8 @@ axgbe_dev_rx_descriptor_status(void *rx_queue, uint16_t offset)
 	if (offset >= rxq->nb_desc - rxq->dirty)
 		return RTE_ETH_RX_DESC_UNAVAIL;
 
-	idx = AXGBE_GET_DESC_IDX(rxq, rxq->cur);
-	desc = &rxq->desc[idx + offset];
+	idx = AXGBE_GET_DESC_IDX(rxq, rxq->cur + offset);
+	desc = &rxq->desc[idx];
 
 	if (!AXGMAC_GET_BITS_LE(desc->write.desc3, RX_NORMAL_DESC3, OWN))
 		return RTE_ETH_RX_DESC_DONE;
@@ -1228,8 +1228,8 @@ axgbe_dev_tx_descriptor_status(void *tx_queue, uint16_t offset)
 	if (offset >= txq->nb_desc - txq->dirty)
 		return RTE_ETH_TX_DESC_UNAVAIL;
 
-	idx = AXGBE_GET_DESC_IDX(txq, txq->dirty + txq->free_batch_cnt - 1);
-	desc = &txq->desc[idx + offset];
+	idx = AXGBE_GET_DESC_IDX(txq, txq->dirty + txq->free_batch_cnt - 1 + offset);
+	desc = &txq->desc[idx];
 
 	if (!AXGMAC_GET_BITS_LE(desc->desc3, TX_NORMAL_DESC3, OWN))
 		return RTE_ETH_TX_DESC_DONE;
-- 
2.53.0

