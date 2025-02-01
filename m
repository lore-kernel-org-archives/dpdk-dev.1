Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD73C02190
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Feb 2025 10:03:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95C4C402DB;
	Sat,  1 Feb 2025 11:03:13 +0100 (CET)
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com
 [209.85.128.98]) by mails.dpdk.org (Postfix) with ESMTP id 1D474402D9
 for <dev@dpdk.org>; Sat,  1 Feb 2025 11:03:12 +0100 (CET)
Received: by mail-wm1-f98.google.com with SMTP id
 5b1f17b1804b1-4361c705434so20915645e9.3
 for <dev@dpdk.org>; Sat, 01 Feb 2025 02:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738404192; x=1739008992; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goNQLdxV8GPZKjJhQxNbRZ11lznIXp+Qg3b9P4fWxQw=;
 b=biLRMl+pnXSd+csdWV3s2e5kYUWHWHKoe8++MpTIGBQCBV/UDtEBNpwpIX7ogIp9rB
 lG/SupGPxl/7GjSU7CGlrIsVI9Zu05b1H9UFOxTRepv49TOkRHHmLw80396ObDAs6Tlr
 EHdecMwZwe5VN42GQXRlFNBNdWB7CtbiwP/ITIDNBQRuZMqgI32FtJr/moBsLS27hcdb
 exn3kAg1TViPy8PGPPLr0mF+EUZZ+MaGp5vxP8R49On1yg79s1PDZs7GqlO2zeIf3nr0
 z0pPb06HUb9sJarwo1ArYBsW5MT+LZ1qNlQArVAoJvsVq7ymUOZ97qOTw27sVTxAeufX
 jUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738404192; x=1739008992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=goNQLdxV8GPZKjJhQxNbRZ11lznIXp+Qg3b9P4fWxQw=;
 b=HtQNZKZZWfkurki4bLQXjNPOvm0lX4IHeSxW+8HVoPjiiXvPQZiibgb61PFH5e/PoO
 sXvxSh3CaKB9NphtFcFP758aG+9PMv8dX8ly9OVQpHiGoUeO+/d2gOWBdon0E+cs+RNh
 WQWoWpmoY05VSmmbhtKwHw6j7j/kwTP3a81JZ4s/ghcMpJgV0F7qvpsTpT6eLfVZnx1T
 Cf/Xs1KIuLlly5VO34reOnhGCuwdEpBcEkosDpxPrmfcgwWo+YIzQsb16bu6+M6QC8Uo
 lsYC0r9kRmKBlM5FE1zBRMJ1HtYLqudShbhP9qn0b0Pq3DSv5wzuqYoZrhrDL26a32aC
 JF7A==
X-Gm-Message-State: AOJu0Yx/xTBDjpY6ehAeYLf+75Az1N4yCfBy/JE4QKlVZ+Q0wPwbbqqM
 Y5SOK3o5/jlmE5A0W42kXfSW/IJxJKRFaoki1PNDxR/9tAoU1nlT0TSnMtapNm+ZxuM2Cm/sDK9
 cGHldp2I8W1z4G6Jy+C6QkIo/zXGqibnEQlPKSr9f
X-Gm-Gg: ASbGnctkSZ7RuK79ilc5WJ0vdx6MEeCDrlKOggcCtIS1KqzLToOKOGoU652qF4uAxyA
 StzMIBDWwcwAnkTb1PGeAUmqc9ygLKHSBp2jbhBMFzbn8VhW08GLkF9rvI+9Yck7mEhrRQZmaHV
 B46N9vTyAoc1jTYlinho6/1lMHzfp4j5+BYnYJrIFhtk0Y5LK9uVK5r8ups/4CT96zUGSpPWHzH
 JfvH2jc8Ju/QUavkJCjjCiJ91qjcS/1g1b22zMkf10EyYRtO2BA87pwdAX5KTpM3WoWY8s7D7ky
 1+J3qht9YuKsOT1CEP8jPkI0hdyclFqnUW+YPPTAXwMhJijlNQ==
X-Google-Smtp-Source: AGHT+IE2e8zh/n9gj91ycmfz6HS8MxkMYjzUwzRqHhc1C5ue4paolyuwtLbBwsPXfXCyXjok8DsDl4ngmIxT
X-Received: by 2002:a05:600c:310f:b0:434:fdbc:5cf7 with SMTP id
 5b1f17b1804b1-438dc41e96emr114504575e9.27.1738404191681; 
 Sat, 01 Feb 2025 02:03:11 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 5b1f17b1804b1-438dcc12c2esm8699235e9.10.2025.02.01.02.03.11; 
 Sat, 01 Feb 2025 02:03:11 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 914301A106;
 Sat,  1 Feb 2025 11:03:11 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Maryam Tahhan <mtahhan@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v7 1/2] net/af_xdp: Fix use after free in af_xdp_tx_zc
Date: Sat,  1 Feb 2025 11:02:59 +0100
Message-Id: <20250201100300.2194018-2-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250201100300.2194018-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250201100300.2194018-1-ariel.otilibili@6wind.com>
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

