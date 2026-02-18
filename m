Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C70E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EF434066F;
	Wed, 18 Feb 2026 17:43:36 +0100 (CET)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46]) by mails.dpdk.org (Postfix) with ESMTP id 80F3940666
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:43:32 +0100 (CET)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7d1890f7ee4so50437a34.0
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771433012;
 x=1772037812; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NuAOQy5v8jZU0dvsa7iHuayfC2DKQRE6iOV8jx252CM=;
 b=O6kdb/qA91YHOIPUk+EEF9a8/msLtmdi9yjtvp5eM5QqOGI45CfTKaSM4A5/Po5SeG
 1IH9icvnvCEfUftvqQmzSGJSjipQy7d1Y6qR1v21t53soxM/a/pkYkiy9YqY8Nbj4Wjp
 xIpe8R8H7I1IGESACqCkZOt+MkX3V3lBE0Wzt4IRlQiQVyHl27LK4iVk1IW+ktD2XByQ
 qj7bfQfyY1t4rA9V3cYz6//Eb6VU707esyrvMiIrW/ag1FxMPPwxcT+5esWItnzBq+wy
 nm4R/N1Kv3oHO8Tkk1jy6NL9DR3YIlifz22LLM+gAO31h7VbJ+lV43Ofm0QZP0JfQrBJ
 Pysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771433012; x=1772037812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NuAOQy5v8jZU0dvsa7iHuayfC2DKQRE6iOV8jx252CM=;
 b=koCIQrseymKAa2p3h5v7WT5iyRJUeRrCAsfsfyHmAZ78dkrXkUYNWMpPfm69kUzvWX
 JjvDXAnj++QHap//z92KqSNgbMHExdfeHAsKzqb+zo+tI/8K3XOPesxy6ZekAyrgGP+8
 AIpnIDxS7vIIt623HG/YdJM5dCFCKeoxxA3jdtNSY6UkdSL6nY1zJK3SV+PYbeBDDtW+
 EsfsFXoJrwyeV1ifdezSl+5OwRawvBYuIf2hXZvWh49TzwMNE+8JLu7J39Hm/VfUheiN
 W9ffC4RI0Onz7UT2BQy7aq5zjaFSNQHfQxJRoW/g/Jk0xbSISuHmFi9nth/7kPzi10dG
 nxTA==
X-Gm-Message-State: AOJu0YyHzcr+p4dT/j8rqMDg6QZB3DVPTH0QkwjLEcgNSRXXQbLnObq0
 u2Q+Nm0kV66AXsunf+njkwYbYZDeAwqxU1J/zRXwO6Fd5bI4L6ojNHdh370NznXwKIEDnsd1Ar9
 jDtMd
X-Gm-Gg: AZuq6aKsPJH+9Ev8Te1WZ/4imrR5I6qdhoMV/gNfFOeBKBbolJo6lJ6R15vOwfch/EH
 0Nsgr7dGtFA2EBlarSjeswd+4xg3LhFKhVbjD0wNWkBznoojXSlbNN/BmhTlbplN+5WniL4I23l
 V4oVBf2xznR1mwaThGiw7q8LyXjKF7kz0gFZ3aDxOpT1kUNcj8F1zIxKRkT9+7ruDhlL0YmImaF
 ktgIiKTzN5qXVqPF+bwEMJsrPmtW9j8v2z58s2svivAiXT7Ew5/dDaDt571vgrAwFwYdfAPvjew
 P5H3Pm8R5XyetquptzFsoOSEYCgn72QBKXNPjdv+R2YxrBwphixD53Mcwz7KuoXxB35+WkVzxXn
 p0F9/kVgayq6j3gc0hvEZoZHBic/AOdKDY07yO65yJSOU2M4SbHTQLGxLE4227t2dDOp0FYFNlR
 Ebd+TcPY6jS7rACl2fAYmMHS2FZgLtAhmNseQgETs6a/kZm2TAecMyOcxbGKMVkA==
X-Received: by 2002:a05:6830:3152:b0:7d1:95f3:8aa6 with SMTP id
 46e09a7af769-7d4c301bf6emr10082329a34.13.1771433011769; 
 Wed, 18 Feb 2026 08:43:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4c6727752sm12878313a34.23.2026.02.18.08.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:43:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Selwin Sebastian <selwin.sebastian@amd.com>
Subject: [PATCH 4/4] net/axgbe: fix descriptor status out-of-bounds access
Date: Wed, 18 Feb 2026 08:41:02 -0800
Message-ID: <20260218164324.915065-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218164324.915065-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
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
2.51.0

