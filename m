Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8151BC02193
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 18:34:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C14384060A;
	Fri, 31 Jan 2025 19:34:48 +0100 (CET)
Received: from mail-wr1-f99.google.com (mail-wr1-f99.google.com
 [209.85.221.99]) by mails.dpdk.org (Postfix) with ESMTP id 9DAF74026B
 for <dev@dpdk.org>; Fri, 31 Jan 2025 19:34:46 +0100 (CET)
Received: by mail-wr1-f99.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso1362688f8f.0
 for <dev@dpdk.org>; Fri, 31 Jan 2025 10:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738348486; x=1738953286; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goNQLdxV8GPZKjJhQxNbRZ11lznIXp+Qg3b9P4fWxQw=;
 b=YUJ4z2ULrT6IZ2sPz1sC9/uZKGMIrl8GQTjEl3LzEphZMWfhcgzag1Qg94KWS1LZGS
 OmaLas/W8H0EyLGTXBd9YN53HQ9W5sXiigeb1HEZk3GsisCS6iNt0EA5f6IGzKavM1Fx
 JCeJog9hdaU3iHxtpvJbjbPI/FHPwKkLL42aX0GlBg9cTZj/sVEY/yQOyb5mIaaouHYT
 hH7pZuj0ZJ8GUGsyvZbBhqSfqR/CRn8ozcjuZY6C0VM9GyhGQHwd3+Bz0c8UUM5T/FVU
 2xXrDOyOEpHtt/M++HmXPPLyMm8HyY8Lcq8WlnYuGtExE5DDF/eKfKq/ChqALTs2vnZV
 hzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738348486; x=1738953286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=goNQLdxV8GPZKjJhQxNbRZ11lznIXp+Qg3b9P4fWxQw=;
 b=Kgoamq+gsgZPEhobWzMNiiGBZ9IR0LFzHmT+lBADTSitG/Udp1CuL2Br0XULWgMrOi
 dKf+L/KzVdg4aKRckOOX7JFkG3HiaNRHOBAm/kPEqZTMrr7xd9NxY8Zqoh8+LIPOkIiG
 MoTa0zemywdsppN/bXq3iQHv3QrPkkq8xFS8RHS642i2zBsXiIO71ujLJ7/qsebV+ieY
 EkAhSrCuu4arBBzQo45a2OYlQ30B/1+d+fYwscYGF0jSumsGgU3CQgljwi+rccKaaQ/L
 V4n1PY5eJ5zZvaAsVh2cZ/AyhnLJ1rYXiIka2tQjqQRRCTXcS863qyDrfNFgqu4Hq72J
 cKMQ==
X-Gm-Message-State: AOJu0Yya7JZAHSK6V91wQuJIBRC8jWh421txBnrQZPV0/M9PpGH2GCt1
 z7pNFsGMjHmgmDfGqpwutjX+merUlyT167LNgODD30LDcPilY+tZLUij0wUvK0YXFz471usN0bv
 H6WQVWygo0tuzoV5iAwP8UC0Fj6bm71b4cZtduiRY
X-Gm-Gg: ASbGnctmKOjov2vHGoaoLSvK6zjgSRbRKYC1twF1UDREpAdbWgFrbR+0La8HVFg+HCu
 mvLjeaqt8gPOsWv1UQZrD+IJ2Jrl74alJ7AsO3S8AHViFdqF9HXvrEcAFmeh/LT3yZ6mqxXzg2Q
 Z0zPB6qc/G37KzyRGlu1fWrFxdQ8WVhpTEZgBkzc/oP5G2vfalUcJSGHTpetmliMb9uBLqbM4gE
 rLmTlAC13kGDdwHBpZM65P8FYsvhpCI2O3tB+ypjpdQk9UZJHqrhx0Tr0eXsXUxCcyeD74+qc2X
 JtfDCjcWP6paFofgAeycqr4fgiyIl6rU7G7uMH2UY8wQtDWyHw==
X-Google-Smtp-Source: AGHT+IG7TjGyk71TMDAXX0qJm3pvLWUAlW2UFCX+OclXdgMkn1PQyJrMd2jNPfzjgMQcymFECkbDVw6YGPHn
X-Received: by 2002:a5d:47a4:0:b0:387:86cf:4e87 with SMTP id
 ffacd0b85a97d-38c5195e5c4mr10759838f8f.15.1738348486305; 
 Fri, 31 Jan 2025 10:34:46 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 5b1f17b1804b1-438e23deebdsm4881365e9.13.2025.01.31.10.34.46; 
 Fri, 31 Jan 2025 10:34:46 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 35A7919C94;
 Fri, 31 Jan 2025 19:34:46 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 1/2] net/af_xdp: Fix use after free in af_xdp_tx_zc
Date: Fri, 31 Jan 2025 19:34:38 +0100
Message-Id: <20250131183439.909831-2-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250131183439.909831-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250131183439.909831-1-ariel.otilibili@6wind.com>
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

