Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6AAD2FEC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:22:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8ECE42793;
	Tue, 27 Jan 2026 18:22:11 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 77E6F41144
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:21:59 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso388645e9.1
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769534519;
 x=1770139319; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ts/vdTcC9KoV/xjiSpJf7Iy3eDbR6JU3InLRRr5kG1A=;
 b=eleXm6wFKAhqPDmc3V0bvs6C52ZP4xT558tZqn3jmhHPwUo4LR+XHuN4pjhNDSDkt8
 gzLc2EeDG6yfZVCngFeHSsaNeJb41EkbMnl//xPQxLJrr4DeQ4t/vdSDgggVkhL67fT5
 zvgMnRrM4YViRJ4azZO0aiNehbFlDTSQNAuSPhZO5ngeX7gBdkqyW/5lYL5Z+LTREZR0
 0F9yuYQPjBiPetLeSrAztYKHpiF1/+KUZrU0moKXmWDXnXWV3GVZ6LKIs2rkdUgkCnYT
 iI0E8xwHbga5hIukFa1pjucyLlnSb0U0R65bOw8UlVSVO+4KOOqml4/ALHHAwHR8lYWs
 5z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769534519; x=1770139319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ts/vdTcC9KoV/xjiSpJf7Iy3eDbR6JU3InLRRr5kG1A=;
 b=jtaMO3XowJ56+wefZ4+P43NMWca4a3GMODqKVONp5jkOyr5kcNSKesRuEDshh4UzAn
 pSkFc5ZrEGdLm0dvmEAvZF3VphonxLT+j996r8eTSmFQxgRLvzaJTr2Y/GoIhqK/daft
 s79MmZWablW1icmtB3TKTeig37aDwRW9po4eLkblHWAv1ssEq7t1Komvokbltivw+VBO
 OdF92Wf7kgy36eiaDEYdvQsKa6k9tH8KtVoWTn+940xURN9a4FQ9LnMgtgY2kkwZBD1z
 tRohNbzq0Sn1gL2/axeKhLB73BoUdy+tyqVjWi7SjPmLr9S+44rA0EUx4fXndpNYLr1j
 5bjg==
X-Gm-Message-State: AOJu0YxRHlxEdU5MbioJpyrQ7WB39AfJ7MsDcrs181xrKHcb4apSAALw
 53Y0JPzzjDxe0+pNb3F0UJFn5h/0yv2FiMj2XpbbmpK1yd7GLngkHl8mTGkO5eSDGGT8Tpnh8+H
 2cwaj
X-Gm-Gg: AZuq6aLWCh+i4CT4sEkcbEL7ZKPAV8uJxvW2ZkqEvm3zLwPRvFELy2m7JJuUQsg0mKp
 wdALi0/mLp0YgJ3ACJwmSh6A+ipTrqdePd1uytDeIsdrTfc5Azx5zZ55RyYU6qs9J8lqqCl//9d
 M9QGZcRwWywduJZc4SBrYKHWMy9imlwiuslXG3mbtmmlFh2uXbhO0zglTBOCBzzzaRJFdbfSylu
 y35riOKqnVKeqXBDaayPVUruzYrhytYt6MAVxWck7pGTbTMOIDGcUBFLlJ/TrTT0yYljGzSdAat
 oFVasaxJ/HCmrRgavNEQd9PtN1fhJ1PzjihJkmJlXgBu75GI06jBZDndBJpVF72Eggn123l99Ey
 nz6e9JyHqCwUSIL7uJOD+3hsT+ke2UeYkDKV1EkWmxZm7FdM4jdU5VSpSXGpjdGXjbWnqEF9Rfs
 T3ssy1A/vyTHyd3OPn6/bttCBAO6/9PeyvuH4TJJO8F1ABBdsmtMZ7LZs5lc9t
X-Received: by 2002:a05:600c:5297:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-48069e33b00mr32604715e9.5.1769534519030; 
 Tue, 27 Jan 2026 09:21:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm4769395e9.12.2026.01.27.09.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 09:21:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 13/14] net/pcap: clarify maximum received packet
Date: Tue, 27 Jan 2026 09:18:54 -0800
Message-ID: <20260127172128.124473-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127172128.124473-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260127172128.124473-1-stephen@networkplumber.org>
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

The driver has constant RTE_ETH_PCAP_SNAPSHOT_LEN with is set
to the largest value the pcap library will return, so that should
also be the largest receive buffer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 6380d76110..a8e8a3e241 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -821,7 +821,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 
 	dev_info->if_index = internals->if_index;
 	dev_info->max_mac_addrs = 1;
-	dev_info->max_rx_pktlen = (uint32_t) -1;
+	dev_info->max_rx_pktlen = RTE_ETH_PCAP_SNAPSHOT_LEN;
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
-- 
2.51.0

