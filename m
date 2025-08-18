Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033BACA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:36:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 101CB40E24;
	Tue, 19 Aug 2025 01:34:14 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 411E440E27
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:34:13 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45a1ac7c066so26747605e9.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560053;
 x=1756164853; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwxP8i/kPJrtjAwCEBiH4/lF/GlQKQYG6S+3LPfw420=;
 b=Ip/BHGEzLL1E436fLmEmiSSXHH4dUQjzZcB9+nB0N3QRlLKy5JDcqRnvlcDU4Yiq3E
 tEC8uiLCMNaxhJGi7h3FxU8MvGERH3hS5V1duuBghpqJd416gsvdgID3zb9apnc4PNNA
 nRJUGQeczE6GLP5uYIXrUZXeuRzVIPtumsvOminuhbZgxAcBEKJvNNg7FTNpRKA8J0ai
 c2WL0fde5kZNZ7MKUc+iAOrEUlFw1MqxO2IQabfJbRS/oLEkwc/CxaJGN4czlgbNfoDT
 lxOL0hl2EZPX12nwQYqNmaY5l9BAkl1SUIsY5UJV3nvuH7pzKA16zjZCOxADoJqX1zV+
 0UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560053; x=1756164853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwxP8i/kPJrtjAwCEBiH4/lF/GlQKQYG6S+3LPfw420=;
 b=JTkN4ve7z8lWrqxomLdl3lMji2MF638O6gMMMqJgGDaU/rAcDIXWShLEwt3g8+LD50
 Y7JUxdiCu7ZmR/PrwchlfMm2Yn4P6+Q/5FLBco+MG/FrVUKP3CoBSSgqlGm/7bxupTYL
 AM+dypRJVKNyMLyY7XLCLH0DOWUn0bbiaHTi1SqOl73Qa8N9o2rmUbqfKmNRtPRtuJjI
 uvwtBBTUaql3O34RPSKPrrhBdkLgbSgGnUMWGPx2r2YezYSdhc09U4mjINGoVahbRwsq
 hYNS9u/FFAWRJL56mjTw94RWo6W+8XO3+teDTd7elUe20BhESBpk8AbBJKdZIkY1By1m
 dCog==
X-Gm-Message-State: AOJu0Yzyd2GewsPkw2z+5m9JPyjH1NCSrtVrcdw9IzXhnxzM3fzDM80D
 Ln05+qJ8wKfUB6QaJgt+o6+mMruN0dTLxPCUjHXBIdLhB8YGqzJ255JJ77uq4BUVWCQklLM0j9q
 ogAd1
X-Gm-Gg: ASbGncsGCja0pcPUwMdAp5Oox0XJ8q4zvDLeHTGjRL/Ve2t1Eju4cWXzCCE93HroVvv
 m4aO3nkoufAZQjNBWmIo4vUpOUi52gv9JLFgSzn5YiD6Te1/mmd//PdiHOxL45i+9X7/juANy2y
 chkEgxld7cgRqtN+tYWQiRsW/+V+ItOvBp7mOtYO6pzvPqaVs56vitdoyxHid4FgSQF1GShaAd5
 8Ltih149X5LiGimSffn9DcmCb+QKE1Q0/sJxArUWB0qo1W77AkgHFcl6iU+BoQwmg4PL2PwVzSd
 +Ey5TLZ9fEIPF03nSN1p5Y6NBVC3hnBwnXNrAmgxf1yqCPJrVaOX/rMzll2NFHNmrBD6ZGEcdf6
 CC+m1qCU0nayGir7EzaFKRhizS9NDaSIb5z7fMNzI0o7PedXyFG7rA+EjXWCO/PMenw9ys4VG
X-Google-Smtp-Source: AGHT+IEv08BEY84aaVamHzbtAOKB77rKKVQJ4tzECL+r0t5bFpioowMpTuKTL0iNgHe6udT1vn9vTw==
X-Received: by 2002:a05:600c:358f:b0:456:1157:59ac with SMTP id
 5b1f17b1804b1-45b43f77da0mr1887605e9.7.1755560052828; 
 Mon, 18 Aug 2025 16:34:12 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:34:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>
Subject: [RFC 39/47] net/thunderx: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:50 -0700
Message-ID: <20250818233102.180207-40-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/thunderx/base/nicvf_bsvf.h | 2 +-
 drivers/net/thunderx/base/nicvf_plat.h | 1 +
 drivers/net/thunderx/nicvf_ethdev.c    | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/thunderx/base/nicvf_bsvf.h b/drivers/net/thunderx/base/nicvf_bsvf.h
index 4c7615ca99..b93201f265 100644
--- a/drivers/net/thunderx/base/nicvf_bsvf.h
+++ b/drivers/net/thunderx/base/nicvf_bsvf.h
@@ -5,7 +5,7 @@
 #ifndef __THUNDERX_NICVF_BSVF_H__
 #define __THUNDERX_NICVF_BSVF_H__
 
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 struct nicvf;
 
diff --git a/drivers/net/thunderx/base/nicvf_plat.h b/drivers/net/thunderx/base/nicvf_plat.h
index 8421f57040..34761000b4 100644
--- a/drivers/net/thunderx/base/nicvf_plat.h
+++ b/drivers/net/thunderx/base/nicvf_plat.h
@@ -6,6 +6,7 @@
 #define _THUNDERX_NICVF_H
 
 /* Platform/OS/arch specific abstractions */
+#include <bsd_queue.h>
 
 /* log */
 #include <rte_log.h>
diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nicvf_ethdev.c
index 4441a90bdf..c7b6252cd6 100644
--- a/drivers/net/thunderx/nicvf_ethdev.c
+++ b/drivers/net/thunderx/nicvf_ethdev.c
@@ -12,7 +12,6 @@
 #include <stdarg.h>
 #include <inttypes.h>
 #include <netinet/in.h>
-#include <sys/queue.h>
 
 #include <rte_alarm.h>
 #include <rte_branch_prediction.h>
-- 
2.47.2

