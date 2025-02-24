Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB08C021BB
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 16:40:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5458142792;
	Mon, 24 Feb 2025 17:40:38 +0100 (CET)
Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com
 [209.85.218.98]) by mails.dpdk.org (Postfix) with ESMTP id 43E724278F
 for <dev@dpdk.org>; Mon, 24 Feb 2025 17:40:36 +0100 (CET)
Received: by mail-ej1-f98.google.com with SMTP id
 a640c23a62f3a-aaf3c3c104fso791612966b.1
 for <dev@dpdk.org>; Mon, 24 Feb 2025 08:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740415236; x=1741020036; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Nvep2WNgRbUDKX7MzcNlEBEG6FEczlJDJ2/NQe8A14=;
 b=cdKqHGSJ2mXN16NObmeumvZLSDBIPMh+2p/pImL+dDNd+o8mP40CnWii1B98wZRT+e
 g7AYKiz5DhYz37nGPM09rYLiggWsBadtHUD0aUN+5m9AxkIZ0wIiMQ6E9GKmqgiGTxcK
 cpjRjMwpXiy7x6kkAuIquH6K8sjMPe4cpbBAUJj2Mzx6L5hwmXB3SP11BrUEpRBTpBlo
 WgIShe5lv0WBI9+MuPh2BlBuT7Oes4eZcX8cc5X7CM+lyfTn9Az4Lxwd++pRW/Qc+hkf
 I5FvVq/+Yymk/ZGEQc8Hst4Z0UHhXX+tBQmVG4bpF9hCuFUyfFYQiaoeHYF2kjl4jwQm
 wI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740415236; x=1741020036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Nvep2WNgRbUDKX7MzcNlEBEG6FEczlJDJ2/NQe8A14=;
 b=sJgg7kLG/KnG1brhbg7MP3ORPzni48DC91UboJLPrOSfmPMOWrBpyMz8w8GA3X9w2B
 tEZ77ZzLcbzFatgufR1KnuMpk7p2QCY2einTHqcKxO29YkQ0/n/2yL8r9ikfGmOK/+/g
 gHppjCBUHLbMDIb2LMcztcBkySi1X/AOpd5mR/hkvRQJdAafGzttQvczW+creyi+xfDT
 F7+Zs6jyoZgXnd5NM+RXP9FwmvrnIQh3A3pRBvWIiUtvJzQLGpZLVRakaLAYqs1MvKUO
 SrQ7GwbQodU+8MHby3fVABsvoa95aucp+v16zP6Gqe+KcFS1PzT1bWYlLE+lSe+uChI7
 w8Kw==
X-Gm-Message-State: AOJu0Yy+kHG+7g9foWAWm4n77OSfms8CPDXT9M7aqXHuyeeYO3JCiz1g
 ZES5lPR5DLJ4SNGEq8tRPBGzGG2VjAeYqm3QkHIGjl10LhNXx1pULe4/exeOCxFYXLWOMMR/EHT
 VJ4jNjuELeVEip9pPIwrKHbL48HBfYioZImLTVAu9
X-Gm-Gg: ASbGncve4bSqsjMAMftScWiQL7zygncpNlnvyzFRTxUHRDkR9ElshTEN3N9Cvc2oWjy
 oKd2VsTT/+OUv6SnudL340MFjGBFjFbc3och3C1wqp5K9jbS4y/ET97JGjOYty4g414en4dSCg8
 s4m//bwaInVCSWORG3yyvBFjDs21unlLEc0znKdQ3BRaJpRta15CEMAOGUTRSfY06g20TlFOg5u
 cFdoLXchouOLlcNbeo8MJClhJosT0fr4WR+BPpCjxWcVJJK6yYzvA8WuMJZBMZAvzVJaBuM7VTw
 s7gnSQOb0zoVuWqlMZWZpwPNqy5dQ2bcE4dK1GntIlK8xZQjhA10+7E3ELgn
X-Google-Smtp-Source: AGHT+IHYAsO5dXYqCvrdpLVR1BO2pwkGmMk2lBiGn4DsLA1o9RdGuCe2B96axKSUJXkHJtCuEeduYJwAOQR4
X-Received: by 2002:a17:907:7285:b0:ab6:ef94:6054 with SMTP id
 a640c23a62f3a-abc0db35708mr1582201566b.33.1740415235898; 
 Mon, 24 Feb 2025 08:40:35 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 a640c23a62f3a-abbdcc720f3sm76171866b.71.2025.02.24.08.40.35; 
 Mon, 24 Feb 2025 08:40:35 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id AC13715753;
 Mon, 24 Feb 2025 17:40:35 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v3 0/1] pcapng: fix null dereference in rte_pcapng_close
Date: Mon, 24 Feb 2025 17:40:30 +0100
Message-Id: <20250224164031.587829-1-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
References: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
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

Hello,

This patch addresses a warning found by static analysis; courtesy of Stephen Hemminger.

Thank you,
---
v3
* silently ignores NULL pointers (Stephen Hemminger)
* changed commit title

v2 (https://inbox.dpdk.org/dev/20250223214123.447579-1-ariel.otilibili@6wind.com/)
* rather change documentation than work around the bug (Stephen Hemminger)
* changed cover letter and commit message

v1 (https://inbox.dpdk.org/dev/20250216160833.3216001-1-ariel.otilibili@6wind.com/)

Ariel Otilibili (1):
  pcapng: fix null dereference in rte_pcapng_close

 .mailmap                | 2 +-
 lib/pcapng/rte_pcapng.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.30.2

