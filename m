Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D44C19776
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 19:55:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC23B40649;
	Wed, 26 Feb 2025 20:55:49 +0100 (CET)
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com
 [209.85.167.100])
 by mails.dpdk.org (Postfix) with ESMTP id F1A0C402AE
 for <dev@dpdk.org>; Wed, 26 Feb 2025 20:55:48 +0100 (CET)
Received: by mail-lf1-f100.google.com with SMTP id
 2adb3069b0e04-5461cb12e39so131112e87.2
 for <dev@dpdk.org>; Wed, 26 Feb 2025 11:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740599748; x=1741204548; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gjWwstkPyJjBBCYsBY0uVtHQOjQfzbSuqE7Eb2knZ4=;
 b=aJTENAIP8At9KgUHoe5fDXXjPHtsJA+US3WhiVaYlOTDbhhdMktXBLqNUTQPbPV34a
 CUYmc31rjzVrXZGNzlh17q0AlHIHdXy5S7R4ivKXBBM6YuTcHdPbz7wYV72OMEWBnMzE
 WsYp3RktmlPENLd5OGx28wohrsyOR+qccBpTS35VArzThAnU73Z/Ne4bKa0bRdTKEmVb
 iZbSLNohlHjXb+5sGsnJ0y9RLDtJ0Ypoe5jqYcql/Pqmnvgj466d0lFqwL4ciaVQG9ie
 W08yO0xS7t8CuypVeqoPpYvfRBck/cwcAW26D2pdQEO197AtSnuaZ4yZe80al/U4kfAd
 23VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740599748; x=1741204548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gjWwstkPyJjBBCYsBY0uVtHQOjQfzbSuqE7Eb2knZ4=;
 b=C3XnfckzRAio2ik28vzvqGAUzgjRvnO7h1S35bq2/x9l3wTFY94TkS01gI4RTb7+7t
 xZygsxitmM7BwhgfERkOJv+nd59H0aJ4diELbr50/vhQCUt3F6817NxXmds2DR/K+G/W
 kazeMgOb0KK89CYKP61iPFD54P41iEEfASadkM1Vo5U1xWNQLMlrylykm9H47IoQstSW
 UtMR31k/gtWB8pALoS5mofTw09XI4NimtaR52+Hy7FITUZgxbr8cALVUQPqH3FzWSFHx
 bf9GHxAzEf5Bk6TuOUc0TCgn28hEgrvKUSS2GvdvpEF77X88ppWRO6ywnZ2b3nYWB9bx
 UzCg==
X-Gm-Message-State: AOJu0YwaU5jIkaepD0X13zG+d5x3PXb953Buq7mAspTGsZOeQjFaBCOA
 o97zGBU9PKyhth7AHDpFYRS+K4lQmvdnj7RAF9GAyp+RbrqnroW7MWu3vQ9kE57aViP6OviLdUf
 eOKLELTbGKUPxMeH6zhVmAdcEdgTXAFddJWI4UHXe
X-Gm-Gg: ASbGncs3J0adezT5Ff00aTq+ue0rOzMcDKkmMdgf9uMoJFUKLp+Dpa9pq5987FMYLfW
 Sor4ges1Zi17Kz5B16hlrSloXEQo0E7T3KuAoPutbsDY4CiLuWVdTBSp8DGuJOY+GFQuveeV1HM
 SEYbCkIhUM/Xi9YEGAartkH7zMvL+J7IsnVljVtSGgZI3TeinVTYu3j3Rqp1d01oKkJ7UCcD2rR
 xnzTYUl8DLfdcfRQCOx8x5ixKO3IfHXMXrOVEiHfjrx6qLxhbs8wGtxpJvDcpcYuGxc4u+7xlWJ
 pR32e4kum6snHapNCKdK/RnTS2r59ATBmvXVkR51NXDHSFzJrHaPFcBrTcPb
X-Google-Smtp-Source: AGHT+IE96vTwebHSrCVfVItNb6vtXxCP5bKyLb8kEXs6drPWJNnZuCylkOdslcavkBX+b7iwIpQPvhh8mWQ4
X-Received: by 2002:a05:6512:3183:b0:542:29b6:9c26 with SMTP id
 2adb3069b0e04-54838f5b6f6mr11059449e87.47.1740599748361; 
 Wed, 26 Feb 2025 11:55:48 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 2adb3069b0e04-548514f161csm168553e87.84.2025.02.26.11.55.48; 
 Wed, 26 Feb 2025 11:55:48 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id F3455175F0;
 Wed, 26 Feb 2025 20:55:47 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v11 1/2] net/af_xdp: Fix use after free in af_xdp_tx_zc
Date: Wed, 26 Feb 2025 20:55:03 +0100
Message-Id: <20250226195504.2340737-2-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250226195504.2340737-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250226195504.2340737-1-ariel.otilibili@6wind.com>
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

