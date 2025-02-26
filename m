Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCBAC19F2E
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 20:08:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 396C24065E;
	Wed, 26 Feb 2025 21:08:50 +0100 (CET)
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com
 [209.85.167.97]) by mails.dpdk.org (Postfix) with ESMTP id BD35A4029F
 for <dev@dpdk.org>; Wed, 26 Feb 2025 21:08:46 +0100 (CET)
Received: by mail-lf1-f97.google.com with SMTP id
 2adb3069b0e04-54622940ef7so140501e87.3
 for <dev@dpdk.org>; Wed, 26 Feb 2025 12:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740600526; x=1741205326; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gjWwstkPyJjBBCYsBY0uVtHQOjQfzbSuqE7Eb2knZ4=;
 b=H1W34bIPtz5C0iIXUErERrxW23O/H7WjAF6KIzJ1Y6/85MpoyEPj4E3rfv5NXgTEhs
 q21q3bvlY/C4gELuxAnmnFjRFfEFd9ivAyKnTI8VJ+hdYJXg0MEMaKE/MTGWXjUH2Zei
 3SPT0VT54TKIzEoahwWFoF7CAFzHIgyy8asekTHeltqRB3IL9+fGzfWKGGccPnQFdH0Z
 62RgFG/DeskubdeSLAK/z1WACja9zzIGvebrVP8jaSrNwzqWNrBFiCWxxq1RA9ZXLMxr
 U97BqD8e2FEXyMKuweWEh8BGR1E4CKPXsp7ZEt5B8IObqRkNRSs9gKXcE1XSTDDZus5j
 MCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740600526; x=1741205326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gjWwstkPyJjBBCYsBY0uVtHQOjQfzbSuqE7Eb2knZ4=;
 b=tskRMvYV9U1Fzjglg5IBShx4BTneA96nGtLV0/u2h3M9IfaeH1qINbAIWvXeHPpeFw
 THhih9iK8YBabaAw63AuG2PtvP8laeeqppF8uUJstp9dbtZQ7LOteAz9xT+uRMF3bSXN
 aCqn+svYPr1WPqM/qR53YxsSWMtC67Hr6ar+V0Ew3+aOdgdck5C2y1jWIvPRS0Lv/k2O
 g05pJYq4f81n1i3OjIotbENGXFg+ZBFvbHknEignX9vyf5y6v8Sp4vfeZ0zijpnMQfDh
 /CzdXZsaB2Z0+Kfc789fYiT7Fsq3M2hC+UANgx3ENcjZm7BVN5Xh4pGxNk6fi/5jxghd
 mr1g==
X-Gm-Message-State: AOJu0YxW/LgMWOSuy3pkWbYAr4BAXu8d/4UoMUlR5aX0X68TI56kGjiV
 Rbcf1dfo0lQUB6Rt+VIlTQbigbRea9s8/JM2OgcNxKpuHWPo4H67J+6yXLlHxY53CuXkPqt6azp
 8KJgeXUUMUmxCq33hJcorAVqdFlMUMu09FzX1rWfZ
X-Gm-Gg: ASbGnctn4HeweQX0td8WcgAyUtWPb0voNCehKTl4pmZmLaZUkjzCoL9ZQhZZeOGufXD
 rG2sqY2qtrkTOacQ0TUYrg2erAdDYdpkOeco62fm0BeGq7bVlgI3WtuKokBaYvEnFL9HTcE9Fiy
 ODSzr3fWTi/4RiXtTNFunLbWNdTW+M6KUdNIO0jUVAItdMPLe5q4IIoxflN/E/Xv8naC6kzXE85
 mX0wBOgoIjfYAQmLz2NIe2T2GdnielksnDnO5LiIrqEs4fftvWqOnbLImumkBP/pwEXSwafhmK5
 Khun0TCLtQOHUfPjtvJNLSCF0XPutfmrjHSTbrnZ8ACQxce4TzxM1QULTIIq
X-Google-Smtp-Source: AGHT+IF8TNu9tZTw8SQ/fMF+ZX+Fj6dSpHTL5UKiOalCdZI/BVhbf2yMmmcO9aSsfIgqKugOkmN9o+OKHpaq
X-Received: by 2002:a05:6512:3e08:b0:545:2ed9:5048 with SMTP id
 2adb3069b0e04-5493c5c5c34mr3979621e87.45.1740600526036; 
 Wed, 26 Feb 2025 12:08:46 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 2adb3069b0e04-548514f1768sm172055e87.90.2025.02.26.12.08.45; 
 Wed, 26 Feb 2025 12:08:46 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id A610C17600;
 Wed, 26 Feb 2025 21:08:45 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v12 1/2] net/af_xdp: Fix use after free in af_xdp_tx_zc
Date: Wed, 26 Feb 2025 21:08:40 +0100
Message-Id: <20250226200841.2342632-2-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250226200841.2342632-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250226200841.2342632-1-ariel.otilibili@6wind.com>
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
index a03d3cfb591b..ea68d6180ccc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -135,7 +135,7 @@ Anupam Kapoor <anupam.kapoor@gmail.com>
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

