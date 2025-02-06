Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BA3C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 20:47:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B1DE41141;
	Thu,  6 Feb 2025 21:47:11 +0100 (CET)
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com
 [209.85.167.100])
 by mails.dpdk.org (Postfix) with ESMTP id D61FD41133
 for <dev@dpdk.org>; Thu,  6 Feb 2025 21:47:09 +0100 (CET)
Received: by mail-lf1-f100.google.com with SMTP id
 2adb3069b0e04-5401c52000dso1403724e87.3
 for <dev@dpdk.org>; Thu, 06 Feb 2025 12:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738874829; x=1739479629; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3I7jCrKETSj3/L0HlS4YyY1/dtNd2JFp3mVOspgfB0=;
 b=NACMaUTnktqC2Y87qSP5x+M4YnIXiaEuBZFGV5JymWMIgOLbb8mKUvN8qN24Vso0AU
 w/Xq5KPQbwTE2qvfqhVKylYolBt0rHCfWrn5EZP3LCiyVI+Yhc/vI+StvQqEhzYq0wv5
 MgufOoqGzBv80keqS0sKKEwlsgu2TGNA1xcKEGvHDEe3/XirNOHIgCTUt275C3eaQCRn
 P9X6QBKSCArTV3KKopBPEVOOhnUaANRU656o5YZD5qkuh7ql58wPjlgt4qNMXQE0p79b
 I/Kzes9pR9/UAe6l04gSq6rMt9vhQcFzsxnSXLaqMLCDaRuD3kJ6iYuYPu+uFl20akAf
 OkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738874829; x=1739479629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v3I7jCrKETSj3/L0HlS4YyY1/dtNd2JFp3mVOspgfB0=;
 b=KU9X4SwQXrMWj31gHwUw69rgaS7kQ9D6ET3bhtlwcRL80XJenc1+Mcl19d1nQUZ/m1
 5b5StwVgQAprbdIeKIVPHMcebjj3MkkQHI5vmk1CZb3YaTTaKDc20jjtdsz3aPGN6NFh
 UI9OkDc6t8f6V6d0+4XdHmcNnKy89/ExzVztSV3DfXhxPIXXrtqvAWlDhz+/W6Yqahk2
 wgIbki+RYQkPqONOqWf1cho/O6gxIpA+1SEYJiiuRkESaSAtFhShxgkYfy//aYOvG0nW
 5K4i5aLnokJnW4JFQWip79A+cu/stwXnwFzhkzZIxaLe4a6lKwXXrckffAtmzhQBungh
 ANJQ==
X-Gm-Message-State: AOJu0YxDV77TKKM6flMg0yBR8Tg4h9YnTmSD7U+u8fUrt5FeYgUB687X
 vs1ap52zOdSaIbq7rizxvrKWa6Rne+jdEkP9Ge2c2X/xYvbsPMK2EUQzLB7SrDY2Derh6UceRWm
 h/rG0WRLX/fjbmy/03TUpEtJwD0LlScn5Dke6mhFE
X-Gm-Gg: ASbGncsRX+zZgW6iyo7oIWG0i8vniJMts2w0X+v8P5YPKTl1331HC9iomorZiJxSZ0w
 dqpqOXU8juWZJ6/V19sJIsvBRa0RbY1LqWO4fVzT7bV+9P4LEhlv/q7bnZkVUAw+bQmQGtGI1/u
 aNNnX7QH1qapO8bgLFOIcUiBr65UrZ8ge6RyCbHLBlCCmzRvcSMdWtmsTEniig/1sD7UFqmPB9p
 b3LLjuMdz8LvzO+6rFTr3izV5X3/whbVzcAVjdHfyTjkOvTXbTXflVW5ImZk1AvEd9mPfE6oCC0
 Xm1V/TxsLA548aq5QKPE6A2jnzb8WOmkJigWGv2D8vrdeB/nmQ==
X-Google-Smtp-Source: AGHT+IHeRL9mLaPwleCBR0fknsd3PWmOGMS4/G42NqMn9kbpVVKOXwtoXjlq+tzzFe1Y4J5voDRacFc50Rav
X-Received: by 2002:a05:6512:39d1:b0:542:8cb0:8892 with SMTP id
 2adb3069b0e04-54414b0847amr74612e87.53.1738874829054; 
 Thu, 06 Feb 2025 12:47:09 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 2adb3069b0e04-54410539068sm90208e87.4.2025.02.06.12.47.08; 
 Thu, 06 Feb 2025 12:47:09 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 9E9951CE63;
 Thu,  6 Feb 2025 21:47:08 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Maryam Tahhan <mtahhan@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v8 1/2] net/af_xdp: Fix use after free in af_xdp_tx_zc
Date: Thu,  6 Feb 2025 21:46:44 +0100
Message-Id: <20250206204645.1564535-2-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250206204645.1564535-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250206204645.1564535-1-ariel.otilibili@6wind.com>
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

tx_bytes is computed after both legs are tested. This might
produce a use after memory free.

The computation is now moved into each leg.

Bugzilla ID: 1440
Fixes: d8a210774e1d ("net/af_xdp: support unaligned umem chunks")
Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .mailmap                            | 2 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 9209a716e047..dbc6b9bdda30 100644
--- a/.mailmap
+++ b/.mailmap
@@ -134,7 +134,7 @@ Anupam Kapoor <anupam.kapoor@gmail.com>
 Apeksha Gupta <apeksha.gupta@nxp.com>
 Archana Muniganti <marchana@marvell.com> <muniganti.archana@caviumnetworks.com>
 Archit Pandey <architpandeynitk@gmail.com>
-Ariel Otilibili <otilibil@eurecom.fr> <ariel.otilibili@6wind.com>
+Ariel Otilibili <ariel.otilibili@6wind.com> <otilibil@eurecom.fr>
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
 Arnaud Fiorini <arnaud.fiorini@polymtl.ca>
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 814398ba4b44..092bcb73aa0a 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -574,6 +574,7 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 					umem->mb_pool->header_size;
 			offset = offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
 			desc->addr = addr | offset;
+			tx_bytes += desc->len;
 			count++;
 		} else {
 			struct rte_mbuf *local_mbuf =
@@ -601,11 +602,10 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			desc->addr = addr | offset;
 			rte_memcpy(pkt, rte_pktmbuf_mtod(mbuf, void *),
 					desc->len);
+			tx_bytes += desc->len;
 			rte_pktmbuf_free(mbuf);
 			count++;
 		}
-
-		tx_bytes += mbuf->pkt_len;
 	}
 
 out:
-- 
2.30.2

