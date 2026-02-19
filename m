Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BFCE9A02C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 01:44:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FD98402E4;
	Thu, 19 Feb 2026 02:44:51 +0100 (CET)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by mails.dpdk.org (Postfix) with ESMTP id 36F16402D5
 for <dev@dpdk.org>; Thu, 19 Feb 2026 02:44:49 +0100 (CET)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-463960df4f9so273448b6e.0
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771465488;
 x=1772070288; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=THUCtBRZW/cH83EDS4zLiqJT4lAFGQ/G/yAG+P0mbkM=;
 b=LMCbU50MbFziPYFai8wO8d1ZoheB/qC77AHlnhUf33yC+ZOXz/6I4CnpUs2Ug2R41b
 97KJ4g57YL/ir0UAWDp0Kh+Ouiga7/tctdaW7PXDT/A3kvdk/sXxONPxSC95vtT7Kpg5
 WS+aiZ0ZBZxrvWkKfrq7ftm56cRN+l+atqZJ4UsGT0MDmgUMyYtcWlQbV41Ku9oGeDD7
 Tr0taqTj1V/OIp3VzNfjr9LbLmCJ13eUYSaOitJqEuftUtLvgHhVdXZZc+hlPHFUfZ9L
 Jyov0rfKI5MPawbSvNAA1ALFqJq3JcQy2y8SC3K32WW4VtYOJjtSLyz+YEFeGT1ACbX0
 7Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771465488; x=1772070288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THUCtBRZW/cH83EDS4zLiqJT4lAFGQ/G/yAG+P0mbkM=;
 b=LeMpHekTRre5GEtDDX0GCPVKlrdM0uEc7UGoGYrT+qZxCjIGAZIeLig4bAAYmzomnb
 9ohRnEzOySC67Ik7SLdNyES1D23dWdVQSD4UpRiqcRSTVFEq7M9nrlmWuihqgeIuAHTL
 fXin3F+IBr12rkhnkdgiFKzOW6olWV0vnp425NwJ9y6Mo9wkPkZqv+LGhjoB/7HhFy3i
 ULvM44B7qD/dT7ilXYfgox5obBzp6qzbtGW4kPf0PCuTmNi67yTwb1DoU7t42chukmTh
 rwlKHTX+RtVoA6NrAX7DQhwmLKZ/GZBKV5NRv4lAkwwAphugWX4fnDeteNtOYxsu7yzp
 RCjg==
X-Gm-Message-State: AOJu0YznKe0Q7SW1PPIqplzLfBK52nGS+aemH59qOcg8oo7WBHgk/Wuz
 8iYiZNxadvkw4PdbSXx76vm/lL2Oh9T9FJ5q7xDMYrr4A7yhQZoYiYNrgaBzurTY1Q4X/PyqtQE
 TTDSy
X-Gm-Gg: AZuq6aIHFdGXTLy95g0PGPFWiXHJHmC77LMTE4pVYsk2V4aM1WqnbwRleT+okxZE1gu
 /Xtm/LuDSUg+0g8z6Y8CYqFggtG6CJbRlQwvEXjZ9HYCk0ui/L+ThL3N4k/tKPRyKz5+RBeJ5fw
 PSRLbscyRwuk1YK+tI1xRHUIw6fbjI53UK/ZVxDiXEsH1rtlfaeuLMOdNgck0EN64O7TKtQAZmZ
 I27MqU7tN0nSWWbFfV7QtW7i2wP9OaaWhSVvqOmQBf/hBtOIoL00JjBTFFJ//Y1ks6/7/mW89kG
 oRGLeomIKWDz2WiA3d0rQtQgc3YPhcqXBioizSpvzs1tO8RJ8DGzM7dv1ZIgUbwm+1fS0ckEYZZ
 HhwSyi8oDBoY4+aiXsVnOjlHZnbNhT5LUfTgRPy0n/OqhgnMHEepCnrrPQgEegXuQ2Fe3YA9+rl
 hGiVoah9kk8q7pXtghaI0yWGEYIWE03t8I9WpuLGAgfmd/xvnQo1f7Ykbr3wpLDw==
X-Received: by 2002:a05:6808:168b:b0:45e:fd68:3de4 with SMTP id
 5614622812f47-463b3ce7e7fmr8952622b6e.0.1771465488351; 
 Wed, 18 Feb 2026 17:44:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-46404bf9283sm3746576b6e.16.2026.02.18.17.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 17:44:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>
Subject: [RFT] net/netvsc: fix txd leak on chimney buffer alloc failure
Date: Wed, 18 Feb 2026 17:44:44 -0800
Message-ID: <20260219014444.175203-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

Audit of tx_pkt_burst() code path in drivers found this related bug.

When hn_try_txagg() fails because hn_chim_alloc() cannot allocate a
chimney buffer slot, it returns NULL without freeing the txd descriptor
that was obtained earlier from the txd pool. The caller then breaks
out of the transmit loop without returning the txd either.

Each occurrence leaks one txd descriptor. Under sustained chimney
buffer pressure this eventually exhausts the txd pool and blocks
all transmit on the queue.

Add hn_txd_put() before the break to return the txd to the pool.

Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/netvsc/hn_rxtx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netvsc/hn_rxtx.c b/drivers/net/netvsc/hn_rxtx.c
index 72dab26ede..3fc54e76b9 100644
--- a/drivers/net/netvsc/hn_rxtx.c
+++ b/drivers/net/netvsc/hn_rxtx.c
@@ -1595,8 +1595,10 @@ hn_xmit_pkts(void *ptxq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 
 			pkt = hn_try_txagg(hv, txq, txd, pkt_size);
-			if (unlikely(!pkt))
+			if (unlikely(!pkt)) {
+				hn_txd_put(txq, txd);
 				break;
+			}
 
 			hn_encap(pkt, queue_id, m);
 			hn_append_to_chim(txq, pkt, m);
-- 
2.51.0

