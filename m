Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3A3C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 23:11:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91C1A402E6;
	Sat,  1 Feb 2025 00:11:28 +0100 (CET)
Received: from mail-wr1-f100.google.com (mail-wr1-f100.google.com
 [209.85.221.100])
 by mails.dpdk.org (Postfix) with ESMTP id 04E2340291
 for <dev@dpdk.org>; Sat,  1 Feb 2025 00:11:26 +0100 (CET)
Received: by mail-wr1-f100.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so2479448f8f.0
 for <dev@dpdk.org>; Fri, 31 Jan 2025 15:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738365086; x=1738969886; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goNQLdxV8GPZKjJhQxNbRZ11lznIXp+Qg3b9P4fWxQw=;
 b=iek6VHuaCBxoPPy0W7VwQODFnxeXcyI5kbAyGJQCIC/wEFt6HD6stEU0dSqgdJ1gTh
 tQdR04yN6LpWGutbAP5HVMq7qrp4oV70b9kczt5OLC08kImIIxr0oQI9zCk0EpsJuYaS
 YqbNLBD84YlcbqPddlYimMx/qLw2jDkr7W532t0EbPX8dTzUj8gCYLm1UyUpObitIPik
 KZX+LP+YwFQa/F7kJPgTNy3CtpIA/sGvQpF3jEj0W4PMk7lyL+PEZ6xZwF4AQfck25B+
 FqDiDiaZOw2xtAl6F1zvLBXxBQcEZaSguPGFFWEBN5lJUmr5AVyZgYxyGCYhCUNfo0yb
 4Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738365086; x=1738969886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=goNQLdxV8GPZKjJhQxNbRZ11lznIXp+Qg3b9P4fWxQw=;
 b=HwObmvGdusxcBIrV7UGPNDQFai6mMEjdDNwfBHornM26quxQfPChrCtzvyZE1S+EWG
 TdqOaHZge6iWYELxr+ujI4c4hraOiO7NlfN8Ds9DD8+1IbAhwX6U+LmTWo/n0m2369Xi
 KW8sM76oJoRRQIevDY2tLGJS+NjEYykjJBeA4NNdKXx8VCgklxmzehpQa6ht9VPcZOZ6
 E5I3L89O8tN1A+b4XJsuqxScW6hizkWElaHWokqHN0JjlZLuc6nqRP/DH05fpFFCNVXA
 3wHTu/XTvb7U/ATHxUpzsphjkCyi8lPYau+NFB9mVaQdk8uUovzqDMofAjroABXFXl47
 9uUw==
X-Gm-Message-State: AOJu0Yxo7kiKB7PjJFgD7ukbKHP6pbX3n2JvnRvhbMDyqJjwlL7pI81t
 JG4n8gY0FrWRl8cEj9lIQ+rbKDfgoEytvxAshefAwAzRdwKlOxe0A1ly7U7wporZi9g8QVf95ZX
 TS7q57gR6m/WQAejjOmqCPGXl5KQf4HblHOQrHH1f
X-Gm-Gg: ASbGnctKs7FvB8L+0kxWM5hglNLx9dFj0uTwOdBrdz4Ugg8u/scUDL0MYKJBk0RYqLm
 0pUkYo7J/CP6LS5DQV/J/Zyj08H1D0o1LcIafnqdI2n0AjcSkNr+RcLE3PPmmcxZ2KNXFVsNX/O
 TODDrUGXshePc5HZ3H6CRyi52PS0FuppzdQQ3YlnmeUrVNAm0/+NBRB34rXDFLZ3dNcnj15JkzD
 4k+OPCYSMSURf7+vzFLP2n2v0FoESOkBko9JjGKS0A7VnmOps0IP7V4QcB1wSEpAQoPJYMn93x6
 x7OCxBR1uOeBNtDxjf1Myy1XAd/nMvyHrV1aWy6rHuVzoaaiRA==
X-Google-Smtp-Source: AGHT+IFJjAFJ7LlgnnpN9DSdIZy2V0AeNWExxLLi0P7rVox5vVhfbC1VHvlBHGcXEuCXC94Swj75m7efYd8b
X-Received: by 2002:a05:6000:1f8e:b0:38a:49c1:8345 with SMTP id
 ffacd0b85a97d-38c60f65868mr4332442f8f.18.1738365086469; 
 Fri, 31 Jan 2025 15:11:26 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 5b1f17b1804b1-438e23e6e09sm5737185e9.26.2025.01.31.15.11.26; 
 Fri, 31 Jan 2025 15:11:26 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 601F819E12;
 Sat,  1 Feb 2025 00:11:26 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Maryam Tahhan <mtahhan@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v6 1/2] net/af_xdp: Fix use after free in af_xdp_tx_zc
Date: Sat,  1 Feb 2025 00:10:19 +0100
Message-Id: <20250131231018.2163893-2-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250116195640.68885-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
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
index 76f65e5114d4..42fcefacf573 100644
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

