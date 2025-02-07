Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01DDC0219C
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 10:46:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3481242D45;
	Fri,  7 Feb 2025 11:46:06 +0100 (CET)
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com
 [209.85.128.97]) by mails.dpdk.org (Postfix) with ESMTP id 1BF7442C24
 for <dev@dpdk.org>; Fri,  7 Feb 2025 11:46:04 +0100 (CET)
Received: by mail-wm1-f97.google.com with SMTP id
 5b1f17b1804b1-436341f575fso22201475e9.1
 for <dev@dpdk.org>; Fri, 07 Feb 2025 02:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738925164; x=1739529964; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3I7jCrKETSj3/L0HlS4YyY1/dtNd2JFp3mVOspgfB0=;
 b=NJa8BJco9kSJb38Fvt/H/ZV8GhUkkY1PT3h8Q4wRw28oe5cTWHyZvK3rHV/HK1qigN
 lIRO4t3dKtzPS+rGLHajfIxsbvuPw0X3d2+F5TaKvR24mv1g8fUHL3f9sm8u/SP2cfdy
 d2c/EHZA1ZEy2fFFH0eZH4VmNSyiFnTe2WBuYeLSeERHbWoi8dUwls9FPG4Mg52CXybv
 edOpRS6x4JP61sIYmMfcdysQ2TlfeVm4X6eYyQ1FUjKKdDGNcGcX6+W8Gkczw7M+Rpuy
 uDd9eZfZOUbdMNpuix1qBYR2bpUtM+5Ufqq7Nua72ZODk7EXdpF4vdckFwdBspxXQu6H
 0UOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738925164; x=1739529964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v3I7jCrKETSj3/L0HlS4YyY1/dtNd2JFp3mVOspgfB0=;
 b=M2xzF5u08aA2p5b3z5uPC5Iyz3xe5dC6LgPl+Z4YOBmkFCogCAV5yZxQstrBSp/Er/
 +Rr9EXADrN8fEYOgys7sDweUmszivQqo8cowvWrM6pDYtUqEJVn9zDdIvnX5V7Q6V+re
 GTP/nU9ItaQIFeciUaad6FjW9RbGPXIVVxnOEE24fjFwm2C7kqB/orwEZ8INlJRHbrBY
 o1Uys3Spct+0I8oWcM2ngKtm8AhsglFSs2b9Iq7Lxw65OX3ZvX3Gi9GasdtNVvSwwXd9
 5rpMjugdEoSi75STePWilRi3Byq3cCCmueGP8K+QVGsH3xFhQwVZRdTemIX+zhFXU+ig
 oJqg==
X-Gm-Message-State: AOJu0YzCtSLF9fx5JL9IAV8EXeBysu4Fq7b/lbxmhd71sfEI8lh4XTYQ
 J6OZxoWsfUTonIFZqRmF0BReIg29Uxl+ifhz7+Ct2ObDpkLdJPrjkYwacB9WE/xVx1PSArwIvo4
 Bo6EVWYIPHMqmue6oLrv8dhuNjG/kn0tBoVbKKjVR
X-Gm-Gg: ASbGncvWquJ+rijaQ05TvZ4T0yyh+XJ/h38OL89gnB9/tWdKAZdkAHJdW+MV7wrx6M6
 1J3LRrES4ZLyLLnHQ+KreqkVVHouw9tAmno+ytm6eDiwNRUNfM1Ui7VgHZrHJ8M3Sg3EK3EV8xv
 Kkn6/uMfun8jloRYFNBZHJYCA3cdIaosvOotOiC2U044GfmQ9FYc3k24Smn+GbBBb8DdkympyLr
 DmbzFY2tjY5TIxtNGq8FVaEn6Q47XkBiVBZ80jywLXyRUdx3evojdQAmLhTu7n2SeRwbvF7fyfy
 /S+WpKbQKPMEhhSpo/aENs+RH6IZSODwy9+Cv0ZPkOyVbQyYqA==
X-Google-Smtp-Source: AGHT+IFysAxDQDDBJOMFpR7kY6KoX5UVaWn1gnkQVKS78fdftzW8gnwKmefz/FqH1wVjkC/GKPM5i/ua/PX9
X-Received: by 2002:a5d:47ce:0:b0:38d:c037:9352 with SMTP id
 ffacd0b85a97d-38dc8fe6a75mr2340474f8f.25.1738925163713; 
 Fri, 07 Feb 2025 02:46:03 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 a640c23a62f3a-ab7732e28a5sm11750266b.134.2025.02.07.02.46.03; 
 Fri, 07 Feb 2025 02:46:03 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 790901D386;
 Fri,  7 Feb 2025 11:46:03 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Maryam Tahhan <mtahhan@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v9 1/2] net/af_xdp: Fix use after free in af_xdp_tx_zc
Date: Fri,  7 Feb 2025 11:45:51 +0100
Message-Id: <20250207104552.1663519-2-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250207104552.1663519-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250207104552.1663519-1-ariel.otilibili@6wind.com>
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

