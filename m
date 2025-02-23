Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAF1C021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 21:53:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEB74402DE;
	Sun, 23 Feb 2025 22:53:06 +0100 (CET)
Received: from mail-ed1-f98.google.com (mail-ed1-f98.google.com
 [209.85.208.98]) by mails.dpdk.org (Postfix) with ESMTP id 23986402D1
 for <dev@dpdk.org>; Sun, 23 Feb 2025 22:53:04 +0100 (CET)
Received: by mail-ed1-f98.google.com with SMTP id
 4fb4d7f45d1cf-5dca468c5e4so6806695a12.1
 for <dev@dpdk.org>; Sun, 23 Feb 2025 13:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740347584; x=1740952384; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gjWwstkPyJjBBCYsBY0uVtHQOjQfzbSuqE7Eb2knZ4=;
 b=BXQhuuY3qnf5PfmReuLG6OfliVABqFlU39540IEPL1EQ5TpziopEM2TW3pjcdnJ5Ht
 N5vFj/FXxhyS2MyTFPV3XA+Ikb5amwkmloBcEXRODp44AH19e8N2vsjWlgw+D+K45wHJ
 cqxRzp5mrl7lde2M3+Yw/JBXMAXqk8BN7TeAe5WhyidLj1dADa/j69CzbBcHTXFkl9KZ
 nh4RN41kGhpPtliBfP7Ex+aSvhEVdIyOMnYcbS2C8R+E6486wmDroUqQ9U7svolDdFZu
 QW954rraXlUQkEyD69EMo8ARw5amfoC6qOb6uvMxRcrqnbud+JxmEdJ0WLV37ByKPq6I
 RBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740347584; x=1740952384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gjWwstkPyJjBBCYsBY0uVtHQOjQfzbSuqE7Eb2knZ4=;
 b=wactGPgmo8RT/Fv/H+AAVZjiI5kFlKBk1gFWnxfgqj92NIl8FMlrKNX8xT3wfggB2L
 6Hc7LYefVGOKTo1EcsJUK+ec30qFCkCcQzSY+WX2+VhTEgvCWPvZLqFRudisBXpuWp66
 DSAxvMd7HscTad9yBzRiUO9Zgei7Gw/7m+4+5edJEDYkni9Kr6z9r9dcEPcE/Vw1zlEc
 H3x0Em1Xr1NExSYlMM9CnKCKl0X2qniIFW/3IIuGFB2iREmjFC4LmzhCtZdxLOiXIVdl
 MOGTaUHE7o+x1iejTm/SLAHluigpFuOiPVYmWpX7M3cCoWW4Z9obWwQg1d8cUYV9WWPI
 ZC1w==
X-Gm-Message-State: AOJu0YwClwvCiL6ff05ffupxTQCq0Cp7+mOOoL/F6KYN9AjEsV9U0I4m
 QNBDppOBZ5DZ+YHa19Jk4dUVcC934L0J1UtvRPA0qy0Ro/KuY7PpKS4evGNruojchnW937WUrZi
 iEvUNpm2Z88cqixJgfK57RZXy4z/vnDO89JGQjhDp
X-Gm-Gg: ASbGncuyeXhictL4NAApoYTe9ZWzdw7dukk3RCqQ/vWu8LPzk5hjIldXldjp+Gbb51h
 PP2daDDxgO5gou8ulHa5jfEPoYOSp1gawVBdnpW0vfvlB5g5Mc+cjs5bII+goTDCkCFPTZl6LRp
 bOpBuZVoo0zPj1ZHsfZEdUz+DDG80gHr5qH4eFQ8j3lLASKr2Fb0a9heUVDxWuFl/fKXs7cOgnR
 l8HkSDoiXawqV5eNbFqwi+VIMTf2OP3IMBPSWRUdvBcBR/y1YAYHGWfJuy/OGxVHMinQDZ+xTGe
 5mng7ZQtwJ4fT48EzyIMz1vFCenzqhEVfbg8BidISwjf/y8Lu3qfopKdiP6d
X-Google-Smtp-Source: AGHT+IFt+vD9DTpksJDmrbUFOLaufU4OcMUvDAc5f7xQ9VHvhZqbKenBIIG4fjkZEpR/jmcvsyfLKV5g39ee
X-Received: by 2002:a17:907:2d06:b0:ab6:ed9e:9739 with SMTP id
 a640c23a62f3a-abc09c0aa77mr1232698866b.42.1740347583766; 
 Sun, 23 Feb 2025 13:53:03 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 a640c23a62f3a-abb9de4ad49sm103390866b.2.2025.02.23.13.53.03; 
 Sun, 23 Feb 2025 13:53:03 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 9A3D314F04;
 Sun, 23 Feb 2025 22:53:03 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v10 1/2] net/af_xdp: Fix use after free in af_xdp_tx_zc
Date: Sun, 23 Feb 2025 22:52:58 +0100
Message-Id: <20250223215259.448723-2-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250223215259.448723-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250223215259.448723-1-ariel.otilibili@6wind.com>
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

