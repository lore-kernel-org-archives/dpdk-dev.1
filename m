Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68065E7FDF2
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 22:18:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DBF440648;
	Mon,  2 Feb 2026 23:18:29 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 883A4402CC
 for <dev@dpdk.org>; Mon,  2 Feb 2026 23:18:27 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so1060205e9.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 14:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770070707;
 x=1770675507; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dShM9mz1LDLr7WNu/7z1v37nf4QY4MJXKxbCTRaTits=;
 b=GFWCliLTFu04+ZTbhYUGm9Oa3l6qbmFTrIW1Xo3yD/7KSr3j6W+WxC3OrT/kkkUoij
 m/Nk0+u7m693YIakLOEZ8ZQmIHRr/+nhwIA4N50qiwf0RJ94HNZ6B/UgpHNwVjloq3mB
 AT/NR2dWJcrlh4jkqMVk8QegFrhg18gDV2x05cqjBZhuPurrk5xU/vHxiXBIbta7qYHU
 ZIHcT1DarxDrXgDy46RGIYLJXEN5RZJYIbpumDe1rLL5MFddK6xSwAGFex3mOtBtFJwY
 mPjelORY0CGOdbGrPtLpCD42kHwncQJBhV/2ETzh/3ScxmL2+bGjbrUZAtWHpu6sG+lo
 zSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770070707; x=1770675507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dShM9mz1LDLr7WNu/7z1v37nf4QY4MJXKxbCTRaTits=;
 b=l9Px+WZomJWB4dVRrNFeCpDVjbXEup1jSsai4CIml12158kJNHghxf3ScZmCX+FPay
 DIacRRDmh7bdZG/OzrzhoeyBLdnr5lnaNjsyE07XApGjdGl//drfCTMG7zwKALyaPyN7
 yQshEq8nT8BC3jxvMnm6u9ChsCyj1GwxLICXM2suvltccKRP89c+sUb++xmpknBn5P1c
 QRdYg4xiUgx7y69tMCnharLH/MSLEVdS6KL+mL+38Gaxt7BgokEHQRW9QhtkSV7No6Lp
 9C9PZbUMr9IVUc4vjKD51C97uGg9KP8MLwKDfk9r+LUMPm7QUL1LaH1lE4whMrHtdb7K
 7Vgg==
X-Gm-Message-State: AOJu0Yw6hJT+HZKfaEha9FhAaAJvhcy7VMLsQ46xqOT+iHT7ARRZGX2U
 zag/FdUS0MMuumG5ICeDu2u5fXO0g32ZZvu8uTcivY/PLe0ivN4OAa3crF8FOI/g54EIPr5TQRO
 opqpv
X-Gm-Gg: AZuq6aLTSWGzjkKfvHfCNuVvfVX1aFdBaptlw5w9/SsgCCqeT3MgcBqOA6c1+RjLzbh
 uC5jhp60iP5jj8UIqv4QObxFfdXVwzoq+6U51B6J8RM/X/NgRlpsXg8sO4f9AOav5PoXSBw6Ar7
 LPV+oKHJFFPlNgkI1+hFcyBVo9naTfUPmL/Kgs46b46T87qWIHKTJYBa9xD5T2cFFweibCr4o93
 vZTcWlAnTHgygn+5nHz1tdBztgS35JQ4m93bzZFvtbEBAfi7cWiuSnb3GU1O+mVj+gvihxpyYek
 Iu2KYp/KUP7T9ISYoAM57svLz58nJgr9pjWfFN/X7IUXPxD4kVUuMYSw+OxFREtV1XHsBo7scCS
 jfhWa1FCdjxs/yvdX6h4ZGqFRhUKD3CSD266e748x4U0GjLkBYpIXnNGnHG1wlHPFTjvkm1BSBm
 gdxmrp6CevYRK4HdGfHSoi7CWD77WeXTySaFwf7eSxw8k0Epnsgg==
X-Received: by 2002:a05:600c:4f4f:b0:47d:6c36:a125 with SMTP id
 5b1f17b1804b1-483051553a4mr14874015e9.17.1770070706957; 
 Mon, 02 Feb 2026 14:18:26 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee04csm47109336f8f.12.2026.02.02.14.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 14:18:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v11 1/7] net/null: fix missing mbuf leakage in the copy
 transmit
Date: Mon,  2 Feb 2026 14:16:46 -0800
Message-ID: <20260202221820.204680-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202221820.204680-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260202221820.204680-1-stephen@networkplumber.org>
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

The transmit variant that copies the data into the dummy packet
is missing calling free. Looks like a regression got introduced
when optimizing the transmit logic to do bulk free.

Fixes: 9946ba548bf8 ("net/null: optimize Tx")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 46e7e7bd8c..0931dac12e 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -172,6 +172,7 @@ eth_null_copy_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 		rte_memcpy(h->dummy_packet, rte_pktmbuf_mtod(m, void *), len);
 		bytes += m->pkt_len;
 	}
+	rte_pktmbuf_free_bulk(bufs, nb_bufs);
 
 	rte_atomic_fetch_add_explicit(&h->tx_pkts, nb_bufs, rte_memory_order_relaxed);
 	rte_atomic_fetch_add_explicit(&h->tx_bytes, bytes, rte_memory_order_relaxed);
-- 
2.51.0

