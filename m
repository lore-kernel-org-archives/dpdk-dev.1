Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C47CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 17:26:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B102440DDB;
	Thu, 18 Jun 2026 19:25:56 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id D110F406FF
 for <dev@dpdk.org>; Thu, 18 Jun 2026 19:25:53 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-304f590dd91so1452580eec.0
 for <dev@dpdk.org>; Thu, 18 Jun 2026 10:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781803553;
 x=1782408353; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKGLn2ORT0jWA7KVMkQn75W2XqDrUDze6YZnyScZQIY=;
 b=I5BPGQjrdLLu/zRQXPFyzcZOjZSXDLSQOtuogJhF/tbLCqLkLIhMrBGNrDFFGXuTCW
 t4zrOWGC3peEr58VMdRvrLJUdEMxEpbbNHobj71HA0rjZkClo0M6nuTuVk1soMfmGFhQ
 4vxjP+CMDC/r1FQ8iEs3/T9rX4/onIIyyBr2Adxn8z1V61s4/yeZsBoB72CjPYcR+F0R
 CyNGbpBoS9TLaHntYOoj7rOoC8dRMWTwa08boxj9YFDgPTKD931Tx0uZzu5wuPvrimuk
 cgFy8igLwI3lN+s3PSKiUfgM3kL+Ts7pBnicfuyi7W6fQFOc+rhCeA72Iq3vE1+SU7/g
 OPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781803553; x=1782408353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oKGLn2ORT0jWA7KVMkQn75W2XqDrUDze6YZnyScZQIY=;
 b=TE9HaGvQLEcivEAVm4IKGx/Qb1vygJDK1B5VcEtq5nsZfFbdf5rdkjAIHzD8y58er2
 fCEsQi1jiYUneKsVefehPfHtksSNsNDHCw1hwj5VrbF0wXpLG0V0PfvuXkPSI0QvIMd3
 ZBx4mG3kRzGcmuQLPi1UJe/LIHJnJc9+Bp0gSQE75WDccAb8gWxZTVtgCUC1zLccjNW1
 RsfoflsQi3i6SIiMh5b+vgsX0E6S5LCVvbX7b3dj+lE1OUFSdNKqiZGovVXK7Z47Mbxo
 BOqRtGYqH6JtLbSeP5wshXlh7bWaHltoK/UDii9z2WzWmAX9Fp1XNf0lk1Ao2UnDBJV9
 2A4Q==
X-Gm-Message-State: AOJu0YzKLU/PGw3/V9S6YmJZC5hOK8BOfZbb6xGkAh4nW7nozcGktCpQ
 idIF8jIYdXAJFrqJi45bagXSFVW+HAeDBaNp5e5P1FUiaz5Jg5MYpFHZSsAA5VQcGXrkHo5Do2E
 a8J/i
X-Gm-Gg: AfdE7ckCYijyvG+65Rfmq8D5gphYC6/i06EkHf08DsyQvDMmXwZ3m6O9OXiNNq0P94p
 B7ZFywsKVsf3M68hb1vYALt8mfJtFgJKBLSjU6z1YrSRRnP1yCLKN58nB2o09DYMO7vLeeQTUc2
 55c9yUvhNKBdSFIAabo/EUB4p4Nsd4iE7+P9paFra72anceb3+dDhal7mBNzsV5qpA09BQD4Y9q
 SGgPS4dKs9mXcKUaq6aU1LZWPDwA4aZTyD3dmFeLMQ4ttDiBGiZ24+yQM/701P5mLFNNKdhbaHF
 gbJDKEHyyYKEbmDewJM6jRN4jSP4UKzaGlrmZ4cd3+I8NQPE0DPEblYVDy/RVNlaT/zWKTBKtyU
 4D4CvPgzHgwnlED/Hs2HpaT+qHiDsGAK3A1xzZ9LxuPUrwyP1q/ENnwao6QpD1lqWMgs8HHWr/V
 +3i1vLJhRsAS+er6JLofVOlNG9BIKZM9b91xTGFMwqNpiWtVeNcaw=
X-Received: by 2002:a05:7300:7683:b0:307:91f9:c1d9 with SMTP id
 5a478bee46e88-30c07076638mr122775eec.29.1781803552898; 
 Thu, 18 Jun 2026 10:25:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c0670a1b4sm122443eec.8.2026.06.18.10.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 10:25:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Amaranath Somalapuram <asomalap@amd.com>, Ravi Kumar <ravi1.kumar@amd.com>
Subject: [PATCH v3 4/4] net/axgbe: fix descriptor status out-of-bounds access
Date: Thu, 18 Jun 2026 10:21:59 -0700
Message-ID: <20260618172544.338758-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618172544.338758-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
 <20260618172544.338758-1-stephen@networkplumber.org>
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

