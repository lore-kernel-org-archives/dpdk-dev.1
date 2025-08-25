Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25F6CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:42:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9F6140652;
	Mon, 25 Aug 2025 05:42:19 +0200 (CEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 08D1B40616
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:41:55 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3c7aa4ce85dso643427f8f.3
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093314;
 x=1756698114; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpW/L3/6NfQ9jw0MOsbiXUD2VFoNp5GgOXXwBtwnJC8=;
 b=DNCk827V15Ku9wYuC9NjszMRiNJ0uJcz/9HLf7NEEZzf8oGQ4bUENoY2r2cgN9JMR5
 iIVxi5wy2nMqME/fV3sOVz+6DQCwKSRpqHbmWBOGGr8mLukBB1TM8b0aVCxl2ehMkc4i
 OLO1JfuKWxpKQ/9+Q6DNhaIwKe71pOfBgxgRbtG2V9HPscN5rRlmgRZRRNgWpP9FIsLf
 ioN1YEp90BpPxNzuAbpOTlA4Ikg3EmOC8doVGAnADAWdExDn8YezIi0vp5xnHPy6tvKW
 bj4qG5thrAlvvKN95rNM3J8x12s+DwbY0VbgIPqLqG61M59U2YMADCDmkcgf8aEaaTfQ
 53Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093314; x=1756698114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpW/L3/6NfQ9jw0MOsbiXUD2VFoNp5GgOXXwBtwnJC8=;
 b=jxNNl9Nsrn97k/6qwlKGaQltFXQrzCF8TY2NSIGR2+hISHwMoq1D0otGD7PmSseS/a
 +kSkrXsTTPkLWmZVTelCQiSt2obmaDnnQL5swfV4V7anxtc3THby7EgJKa9gF2YUPVne
 B/a1tEH8pVaEg/KOB/djD7BuwOA619S1DZpngMRNg9I/iEUcc10NJTMT8Z9XqpgBmTov
 0dcNLQKK3NXuDaHtFi0uCY2hDC6BETABETSmqLu6c3U6IHELZf2TNpLDrfw836MR8yFv
 ZoXGD+BXWIhyyuyneFwUdKqNh41uI9zDUr4Yo/sqBvZTMRgGJPl44YU1f8Ei78swry8r
 AzKw==
X-Gm-Message-State: AOJu0YzPnthqdt5004oTOMH2B1fRm1gtTMBXU/5eYwDwSBUs+UntYihx
 7msbSIEghLB2Skxd8uTKaaLAczhcsaHLMEEkUVa2A3Eb11q8jOHGFlMpVSrrBEq13UVkOIAkZvM
 cA3qW
X-Gm-Gg: ASbGncvnqNcy4bZFG62a3kfCzh88FI8LzaW/plCMdaMZblIavPqO6wrSCBiQgAFFtwm
 rsAvniwxLmCMc2zISJiS/D3GcwSPdASHhs6Ry1VquOCWFhz9WAkFvz+ESzseOS5jmvG46K1LR71
 Ka9xuSbJjBg9kfeVGNG25EtTUfnzq5V6N6h4klvIQ5ce1KR588zG1dA095WKWy7Rtc3Lu1Yrhlm
 PawS0XRtJBRBYUV5/AIk7fWKdqdu/tt0SPhuzhdLedEqmhZcq61WtEMaXww6qFuo2AJXmXYByYV
 lADEmBMWUTitcFV4RIUCUqfsUSs3n5ahEsWeukCe1fL0qlrAiDUkeUPAbtKdrzHSIQ7K5HPAOcT
 HXnCPKoV5LyzWjQzH5GHBwWL5royhMyvu2oY6crsYm7nbBLKnJ2pTrkkxM9BxxaP4weSnvWHy3H
 +NEVkkdU8=
X-Google-Smtp-Source: AGHT+IHtVXrQmHsor+TYHCInvtNuRAdwyEBcPGV7+fQEUPIAgnoHBxgT2F5PjfST7ncaezT42BKhlA==
X-Received: by 2002:a05:6000:2f82:b0:3c5:adc6:dc67 with SMTP id
 ffacd0b85a97d-3c5daa276c9mr7239338f8f.8.1756093314628; 
 Sun, 24 Aug 2025 20:41:54 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:41:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 08/43] apps: use rte_bsd_queue.h
Date: Sun, 24 Aug 2025 20:38:21 -0700
Message-ID: <20250825034126.12046-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

Use DPDK not system version.
Not really a requirement but better to avoid any possible conflict.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c   | 2 +-
 app/proc-info/main.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3d3c0dbc66..9cc1f17093 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -17,12 +17,12 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <sys/types.h>
 #include <sys/utsname.h>
 #include <time.h>
 #include <unistd.h>
 
+#include <rte_bsd_queue.h>
 #include <rte_alarm.h>
 #include <rte_bitops.h>
 #include <rte_bpf.h>
diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index be67386658..2feecbca78 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -9,7 +9,6 @@
 #include <errno.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include <sys/queue.h>
 #include <stdlib.h>
 #include <getopt.h>
 #include <unistd.h>
-- 
2.47.2

