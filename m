Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F87CCF2E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DB85409FA;
	Mon, 19 Oct 2026 13:47:06 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 6E3334026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 19:46:06 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so173137c88.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 10:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792172765; x=1792777565; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qJED7CPz0nYfBVNHD/0RgF+visOEWKBcmB291nRhY8M=;
 b=lp/cGl/ZFxvYwKgbJ0yb12pjHsCpsH2imlq2DMEyi2/PTR17XdaYDXnr245qi5kopH
 j5JxRBovT92bKeRP1JjUyEQMwsgQ3epd5Je2bUchd2D6hX3A5fKusMQbb8uUvkebfnbh
 WaS5dh1YeJf8pyQJMHnodAy5XtA01F2P4krz2+yLCCfUVGRB5dRjvRgrmZms5CCWn7xe
 hFRcP/+0AyM5uFMN8LBzSassHU8s14K4Qy9VoF+zNhs1erPXbfg52PzHsFHmxCMm1zb0
 DFY+uD07x6AV4pdP2Zm+gsNlJoC2+QYr2xi0Gesr51LmSRSOtuN1dBcWxUlK5RbDa9IW
 tauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792172765; x=1792777565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qJED7CPz0nYfBVNHD/0RgF+visOEWKBcmB291nRhY8M=;
 b=AjwLa6hk/A1yfGktkswGkDLpviHj62ErSRbVXWnYF2keoKV9JuAXeEEv4tW3oTA0d3
 7SnwtWPPdauFLpIft3NPb6ytZVdj1EmWqLbg6jM5UP4CCfuUhJ1zfe6sAU9KXJLQCjB6
 mS5+TMKNdAVO43+LCfinYGrDvquRqC3C8asJkx0YO/IURAyqW6U3abqGIzsM5ZFhMME/
 wJdXJM85ufugAvl1Qslq6sENKY7PpT0t+KzMjIF+jw0rh0tNda17B/zY2mppX9LAXimw
 0hMcK1S6UoLTAEpCC/7zUxco1Z1C4/GFo19eRAYSnNEvuYBl7uJPCUL/HmTFcVdOj1Zr
 C8jw==
X-Gm-Message-State: AFq9FYKvwVHMKF51H5nRZ+31tLfJBMsBnxb0XmdjvoMiyq7mOjImn1PU
 q3US0C702tzuErwVD4fZGEIk+b5UTQpHpBmmJq7wv/RSMgBEIfhSxqu3dT3ojA==
X-Gm-Gg: AYBFou2X6K7qqgrHQHfLslMHYtpHEWEO6Na9Cs20gDzA5MvgvGG/aD7AccfySGirLIy
 cNk09s/52BBGutiQz+yMQ3ybqc+WaG0FeB5DwtnwHt8/fPcyfSL8oXvOMOn1+fOqO9+dw4WkjnK
 i77z3Oe/sa2Bft/Tll1I+EfrrmDKccePQbD8bf63m9UVTbuvyuP059mD86emGqC3a00LOVmLLc2
 Qh/Rx8tb5VkMfllwYZG6NiOwhYM9pQiPwjPpyUJubKEqpIoojBimepqrA2Rp14x3L//gDxM+Zzj
 x/Q0JBXH3uVNmIJefAZIqhJI9/YLzDCskqJfb87fyLRJrl0oSYC8fZEaa1Axc7dz2NB4YGTBTTt
 qlhXRZVgULPMnagH9WjdO7kP/44X+4DbYmtk3xbJK9twbZ+2BBUfQ1nyEDnnHMY9CBQ9xCiGBqh
 pl0Kq+Q8AAcBwm7RjuHgbWfiXeSjO6Kn0SNhVKnkqXsOMIRhz9Re6TVQO12LQYwfiZvSTwEcdmG
 dOvH+ah19YW
X-Received: by 2002:a05:701b:2610:b0:14a:8cff:fbb8 with SMTP id
 a92af1059eb24-185138b58ebmr681215c88.28.1792172765429; 
 Fri, 16 Oct 2026 10:46:05 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314ef8ed8sm7099936c88.3.2026.10.16.10.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:46:05 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: Joshua Washington <joshwash@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ankit Garg <nktgrg@google.com>
Subject: [PATCH v4 04/10] net/gve: fix stray TSO context descriptor on tag
 exhaustion
Date: Fri, 16 Oct 2026 17:45:39 +0000
Message-ID: <e0461395d6fe143146d47e2c2b7c363f577e386a.1792170902.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792170902.git.tathagat.dpdk@gmail.com>
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:47:02 +0200
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

For TSO packets, the context descriptor is written and tx_id advanced
before a completion tag is allocated. If no tag is available, the
burst stops, but when earlier packets in the burst were sent, the
tail written at the end of the burst still covers the context
descriptor. The device then receives it with no data descriptors
behind it, and the slot is never deducted from nb_free.

Allocate the completion tag before writing any descriptor.

Fixes: 5fd289ff3a00 ("net/gve: support out-of-order completions on DQ Tx")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/gve_tx_dqo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 6cca968122..55187fec71 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -305,15 +305,15 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			break;
 		}
 
+		if (!gve_free_compl_tags_pop(txq, &compl_tag))
+			break;
+
 		if (tso) {
 			txd = &txr[tx_id];
 			gve_tx_fill_seg_desc_dqo(txd, tx_pkt);
 			tx_id = (tx_id + 1) & mask;
 		}
 
-		if (!gve_free_compl_tags_pop(txq, &compl_tag))
-			break;
-
 		pkts[compl_tag].mbuf = tx_pkt;
 		while (tx_pkt) {
 			/* Skip writing descriptors if mbuf has no data. */
-- 
2.43.0

