Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E807CA0EF2
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:36:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09FD040DFD;
	Tue, 19 Aug 2025 01:34:25 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 42C6440DFD
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:34:24 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-45a1b004a31so32914915e9.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560064;
 x=1756164864; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVOF7rEBPK8zt745jWNMPNkfPB5aS7Hg+V7GMdlT6/Q=;
 b=z/p1Llgx9VAo72HdiZ/vP9J8Al+hhosS6eLCpOum2mm+E2weBI95ohYVMIhdGhWfv2
 Ws+61Fc3fH2kv4fDwwXkfUGi9BEd7AxewKGcwx5LvpGpvHr2OKgvI8whp487zlyTDhea
 6JPZqpxj9MaTqFuf4A4jMqM3LKKLcBcPZ8JtRJrlth9GiZBTW+OKyxC+kQPzpVqt0N41
 0LIreqktmj9rDOyfFpqCzQMlCZHs1IMZDUou58glimWNtMNM64Chhq0W5eSakVezqlF+
 yGecc7vk2mLs7tUXv6/leB/1+3y9nhuzwMbsYO79r4O9xG6JR3Hu36gEEIL/mkqJH+th
 KGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560064; x=1756164864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IVOF7rEBPK8zt745jWNMPNkfPB5aS7Hg+V7GMdlT6/Q=;
 b=f0Nl17kn11PRLmYW6vZRdzwbC5ljtMxdtJxUEoD2HbZfG3gchwsLVkIMAqxPIqgpqy
 1N1DohKZ8CAViA5YF2sDe1SExpwHfPFsOhXMZZKInSZByyT/tS4f9N0LFLNk1BMt8Yi6
 lEB5gvSk3b6SWcdSVgaW+KJItIQtW1V/pROVznZBMHBu1fn9YfvJIDFMMMh1yIQxTe5n
 SnDva917770Lz44/TCF7tRP4Zbj9DZUcizMMiGXOVu51loILPhS60Chf1F+ukcCUVu8x
 5Afme6DtgyQs5ofIzCNy+80JSYWxIaOoiqDanpI3QuADPraQY04ZTRgmn3dj1ChxYZfK
 meFw==
X-Gm-Message-State: AOJu0YwnI6P+Z7LXY2HPdyKHkQK3RnnYSVGy0jRGewt2OYE3eBrBjRaY
 6edmeti669YJBMnE0Q95kYkkXqcUB1YSnG68m4GbwKOoqSTdJxwiVHwKZyxH2yzlDHXsFzhyXoj
 srl2U
X-Gm-Gg: ASbGnctTHpbSuzAroEy7pik2HLqXdQ0QrxO/vdekB1JIQK0rpT2iXccJZKQ3ngzF6Ez
 VJNAKwq0HDDMu1xPfMFAlGAVjmrHNcpwOG05EmCzK0/llh6TF/Cc4YfX7wb90+T7xo1bSTJ6+2s
 8jxEiGA0+T+nMZ2GXtBouM6YGCd/Izgct7Kyiv3zcXkCjMf+rHNE+qrtEriEGpeobyomioA4UuG
 7nAXdSJbN+m5zjxPZ14JX2SIhG8srgPloIUlL0YuMcYUXXPSSCyQodIhMvvVwMWbqHeQ5nZoIo8
 rskvk2YPKRvFw5dEOgLNUndTVD4rDigDgGI9ELWsV1Ls2Tdajr/4hjZ7kqqwlL5EngedjUoItBG
 Jxrg+jpU0pNhTROiNFC8Ug7zbCmqfCc/uF+/igRDiwm+t+1u9/jSUBT3hOH/oVRBM5EfkDstj
X-Google-Smtp-Source: AGHT+IGUyfPIDnoomngBT7hbvO6JUxUBnSjktV0D7oOjwQ4ljQf1qp3/qgdPQL7D0wpJZqFkJ0aWLQ==
X-Received: by 2002:a05:600c:3551:b0:456:302:6dc3 with SMTP id
 5b1f17b1804b1-45b43e0d61emr2015355e9.26.1755560063856; 
 Mon, 18 Aug 2025 16:34:23 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:34:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC 44/47] net/dpaa2: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:55 -0700
Message-ID: <20250818233102.180207-45-stephen@networkplumber.org>
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
 drivers/net/dpaa2/dpaa2_flow.c | 1 -
 drivers/net/dpaa2/dpaa2_mux.c  | 1 -
 drivers/net/dpaa2/dpaa2_ptp.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 299c50dcdf..96e58b85fe 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -2,7 +2,6 @@
  * Copyright 2018-2022 NXP
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/dpaa2/dpaa2_mux.c b/drivers/net/dpaa2/dpaa2_mux.c
index 1908d1e865..f956d5d5b2 100644
--- a/drivers/net/dpaa2/dpaa2_mux.c
+++ b/drivers/net/dpaa2/dpaa2_mux.c
@@ -2,7 +2,6 @@
  * Copyright 2018-2021,2023 NXP
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/dpaa2/dpaa2_ptp.c b/drivers/net/dpaa2/dpaa2_ptp.c
index 751e558c73..b55aa195ea 100644
--- a/drivers/net/dpaa2/dpaa2_ptp.c
+++ b/drivers/net/dpaa2/dpaa2_ptp.c
@@ -2,7 +2,6 @@
  * Copyright 2019, 2023 NXP
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
-- 
2.47.2

