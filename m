Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A29C0218D
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jan 2025 22:19:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4422440ED3;
	Thu, 30 Jan 2025 23:19:19 +0100 (CET)
Received: from mail-ej1-f100.google.com (mail-ej1-f100.google.com
 [209.85.218.100])
 by mails.dpdk.org (Postfix) with ESMTP id D2B0240ED3
 for <dev@dpdk.org>; Thu, 30 Jan 2025 23:19:17 +0100 (CET)
Received: by mail-ej1-f100.google.com with SMTP id
 a640c23a62f3a-ab6fb2940d4so24809566b.1
 for <dev@dpdk.org>; Thu, 30 Jan 2025 14:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738275557; x=1738880357; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cv7c9/eOguN9kJnm7synzeIb60EZD6j6PvROBCFhLZY=;
 b=hnFRWEW68CnfsuxjczGOiJZO7Cs3Ti14Pnfq05xULVk0b6siILZto+fCAF9T97+B8t
 hxLeCxBsQGyeGqSGnS+5jy3zfadAbV/TwK5VTKkrJusi8eecCPsGJ8ih5IUAB1j6TVT2
 08kfylKVd2KlBJomsLIIJwCkAAthYZGKT1ojP+7dpS14uSVTTx2WFkf22h8XS77gNwGS
 NGuPbmYbiSnFn8VhIUuH9zmyf5DGltAtGFaiZ2El6s1OTgndwdmMw+xpC43W/hSx0FGu
 mPkcAYT4vQue+7wNVWiYkXmvSAYWtz+11ylTluX0aHGChT8oS3PpMum+9DPNWxh9mL9a
 jv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738275557; x=1738880357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cv7c9/eOguN9kJnm7synzeIb60EZD6j6PvROBCFhLZY=;
 b=i36tFXw3Wvojela6mbnbHf2eN+ihXXg3ZJJUXpUe2fI3Fn7JnQWW2ql8142c8sAJn7
 r5k/avaeGu9tAku4NneVcviGNG7248x4jjHaAPXASQMLJW4iTGbZUsouht2xjQb8Zrr9
 aH5f473+3Dhh1PNpHJRJ9zwevmRHuNng7pg1qrVepIoENV8icpWfXSNsTrdm9vIuISyX
 tVoBzuOl0JQkwxuvKQFC4KGPGRuyOmfeJqJ/Hy5W2K/GXKsVgiCLhfRfYOtuenw7SuRM
 HtHJnflg7Ie8faq882oCqo0qhW8M71zGHYyahOgPtHAilUj/egetMs7gXvcldSATIlZt
 dbKQ==
X-Gm-Message-State: AOJu0YxBry8wjOwRnNtafsmF6/K8udq2zZmMnVGDJWy4zEQtCR+WqkJP
 trlcRI4lgqoU8+0dmsm/Eo3E7iDw6lp7zliFzlTT3SO2z025KLBxIXCVDoPTfG5IN/q5/mabxUz
 0IYDsGGGIg3MST2evzqemW5Y4HyC5EJzF8ACN0vgO
X-Gm-Gg: ASbGncv8x3JRiqlt4Ks7KJiDL4LxLCXER31eN+q5rKOrLLXk+pYLfmlKMCSlDZ+9/0H
 gnPMz3pDoAc0qHaeyNVoPkBWfsTKkinHWrYgA4aFmD4Da1XXqJdYqqBFvq1QOT2x6/jn2xge0hi
 +r8cmU0xFjF6I3nZDYEwiAv9F1xDfkzOMGhYkDtbwrdY7tQq4uyl8LN54DHxPuay1kJyJdhde7R
 0TIqT1q0/vKaMvx417X179lpYknGsT5YHdKfSjU6j/kqb5pm4DGhCo6uA73m2incQ6Jk3gu9X4c
 ifYzj43oHbREQNkIuCBBetkwc6EM8asg8B2PYTcSUEwn2lIaEw==
X-Google-Smtp-Source: AGHT+IFMJMFERxCULE2W+bm3AZzQPO3FMUxPf4mEX/g90o+JHKA3meFgTOwZBlrg09WKsh447bYxLL0J9bFn
X-Received: by 2002:a17:906:7c4e:b0:ab6:ed8a:3c14 with SMTP id
 a640c23a62f3a-ab6ed8a3f31mr262047666b.27.1738275557442; 
 Thu, 30 Jan 2025 14:19:17 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 a640c23a62f3a-ab6e49cfcccsm8375066b.175.2025.01.30.14.19.17; 
 Thu, 30 Jan 2025 14:19:17 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 49FA0194F5;
 Thu, 30 Jan 2025 23:19:17 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 1/2] net/af_xdp: Fix use after free in af_xdp_tx_zc
Date: Thu, 30 Jan 2025 23:18:52 +0100
Message-Id: <20250130221853.789366-2-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250130221853.789366-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250130221853.789366-1-ariel.otilibili@6wind.com>
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
index 8524952d2480..69e485deac55 100644
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

