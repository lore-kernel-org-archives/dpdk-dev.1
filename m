Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D27FCA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:36:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F7F340E01;
	Tue, 19 Aug 2025 01:34:17 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 2787E40E01
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:34:16 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-3b9ba300cb9so2930127f8f.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560056;
 x=1756164856; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JA2RF5sf1ZfFMULsiFhZrdGWT6HxNxpCYSY/mLk1so8=;
 b=PyjhZQXbNqamc2y06UrjEycLoHpSJ8PYEUuQLFjsib7ZPRni28U+/MG8DS0k2ugc7n
 2v+19YzIv5emkVk4+hPXSZKJp9npgOXAAdqiaoqGe8bFKtT81v5ydHrBMHNf+Ngu4jtt
 5IWdmEnNDmQDUM4Q8PWkjDDZP//rkX1pKOgZ1QiZuBjG3QKJAb29IwEdmEHiPqQ3DOg7
 QbyKKl16vB9TPcyRduBSIYnXMAKMnHAQoID/xAu6Qc0z9ZphwmYyjUs9MtRTuABkAAk3
 tEybAgEx9moNXkDd+wJNILqAPQVIkWV5CmUYaLDsawDD/pdTzrmtbc+7mLBVjdQ63pdT
 DP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560056; x=1756164856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JA2RF5sf1ZfFMULsiFhZrdGWT6HxNxpCYSY/mLk1so8=;
 b=LaR6rIeiTFyAa/eDwRFEWIcGzL2Ddf9oNiLTw/dPHJ4372OsgPY5rvI/5I3H8bql62
 px+j3yl/jyr7C0aIrnf5bni5CFvMtnQD2Wsi5ctOjeS3cF3rh7vVIoSFNz1ZB8G/QZxB
 /Gnolo3k6d3WzqbjjZHQK4Dc76mpY5jV/j82b0OGtXP1mEJIJ68PxT5yO1hk9wdQWqq4
 MI6Odu+Wk2AlDb2YVnAZl78Ga5b5/KxhgMzS70A1Xmn3nPa0MTFFHep5x78jSZqaZnz5
 rWT7ErGvpC92Rn6rOd0oxux8iy4PsSsXd2ao8wTusj0rqg5HdrfZ487kvVNH1IXRLz3I
 jAxw==
X-Gm-Message-State: AOJu0YyvyVOg0rmwwONrx/iMRud6za2E5FLjK/TPsWB5vC4ATJ6HW1Z6
 q9DBDRZNDDPS9cSygvnL90y/I51OKdy8NlqyiCQVbXurJ0EGW9aSdXZBeGdFHdEx2Yz2l+XfGja
 uGujp
X-Gm-Gg: ASbGncsv0TWaUz1QeVYn/Z1l9yONI5h5C4mJ0SwATd6p68NRFxH+sERc61nZq65zCSK
 2BoyWmV7oUIGqD2S5M+u0nVu9rtdO7RSWgGNeHLDULBYinV9mo7RE1a8ePdU12lXx6uA3JfA2fq
 AELwrpwSvm5aZ+WuYY+PQ8mutKtGx2ixVlu1b3Lnhh4+CZSC93wn22oEMEyijydtiO9lyARUIiv
 BMoRr54u2Z4ercdrmFrziDdtRV+yBY/mSZDU+4X2PATTQDdRclkYH196xYH/RM45q9/mzQZyNDz
 9hEXuHzceFIVAOSCpFyz/yjZvGOMkGelJDdJ2gHYoiSXTzOFPxkFsMzgSfO/Vxbq7YBKEIOE0OC
 jCOkTSgSDX4oxxVtUoCAL7UFcoS6nxTezrnGmCadejro15W0tZjZREtFDlYIb4f3vCcEac+87
X-Google-Smtp-Source: AGHT+IHPQ3/3qdKPTELnyJup6mWgejy1p2GctuJqDldlO0n/Gsr4GS09SEqFHEyeKkwk/RICTRouaA==
X-Received: by 2002:a05:6000:18a5:b0:3b8:d8d1:1e72 with SMTP id
 ffacd0b85a97d-3c147fbe074mr139778f8f.19.1755560055692; 
 Mon, 18 Aug 2025 16:34:15 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:34:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Jian Wang <jianwang@trustnetic.com>,
 Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [RFC 40/47] net/txgbe: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:51 -0700
Message-ID: <20250818233102.180207-41-stephen@networkplumber.org>
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
 drivers/net/txgbe/txgbe_ethdev_vf.c | 1 -
 drivers/net/txgbe/txgbe_fdir.c      | 2 +-
 drivers/net/txgbe/txgbe_flow.c      | 2 +-
 drivers/net/txgbe/txgbe_rxtx.c      | 1 -
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index 847febf8c3..61e62e9015 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index 0efd43b59a..8a35f07d88 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -7,7 +7,7 @@
 #include <stdint.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <rte_malloc.h>
 
 #include "txgbe_logs.h"
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 99a76daca0..ba1154c1df 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3,7 +3,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <bus_pci_driver.h>
 #include <rte_malloc.h>
 #include <rte_flow.h>
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index e6f33739c4..38fe981997 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.47.2

