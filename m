Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2586CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:44:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FA9E40DDD;
	Mon, 25 Aug 2025 05:43:00 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 2F1F840BA0
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:55 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3c980bd5f48so381366f8f.0
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093375;
 x=1756698175; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbGLUoGSz7jJZyW3DqcRLjykVrABw3vHiavVC9GRl60=;
 b=JXzCLY2Gn8WK2+suGmG9/gJOafLbTCX/rrKeI448rP1ygHfbF858mfu03ihKu302JI
 M77woVve26AzC6YDU9dUwkSrNkTpStG9T6XC+Vvl934H732xjcv44uL1ZGUUXFb4AE95
 XKqXf9OQ7hotJmRC2Y2Se6+Ex5dVO6FW9kLuoRXEW39MxpD82Yk4cjGDcWjv3leBwoTp
 w9JL3W1V9Kr9C6EFc7MA41AmK5v987BujyhqKOpWXKMYFFAsiIFp4kqYmvGiX2HqeDd1
 /KU1UQRVFhu+v7i6oPo4Qlky7nHhV+ZViwVJWlh4mSeN/y+pqg6xPy7hpJtU4mlqxx1N
 XDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093375; x=1756698175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbGLUoGSz7jJZyW3DqcRLjykVrABw3vHiavVC9GRl60=;
 b=G5ly81uF0cV4K9HQBIR6EoswSlfMqYu8kCfN1vOIK33PsvbThFEQlwvVQmRUdvly6w
 rTpDVwb6C2+CtnVged1oeYbdj+l3Wj02MS5DT52VZl0E/KSMNIjR0P2v2WkLm8XfkRHe
 Ddn8H3vgpY4WIGRRMPzXUIEFpzbIj/uAMcVVOrXsVs1CXKjJXMUgDekWlP3XwmUFd1QY
 gsmOiZDEyWz3sLTML5eRbkojhm/vbu/iVkM9ZOM17MwdU4Zy0JiBL5FIyTQMbdEcXTOw
 v8mFQIAdBUpLp5z7/XJoPvD/D94z4v77WoAU/JtwBg+vfa/R91I4+xBEgvAt/7CjyD69
 ECIg==
X-Gm-Message-State: AOJu0Yx+WOn3UtH++xvcQ8Hj+xWqcpPFgtUFmPs0cAyY4ZG4E31qYbH7
 aeS9UHpn9FHBXUNomfwbcDsPZXRzsybrZ4SnfhtY3+BYHd78io9TVpx4sl9/F68+k5XEWv4Rwji
 FFi+a
X-Gm-Gg: ASbGncsOqYkm0Z0U3O9y5hqtRO5rEQFFC3hrQtUqyWZbHPqt4QaGOCfozIQEsk24MGk
 oDMExfID44yqOhxmk1IOcl5AIw7JPY9VJY1oTkqfPgS+OE2fX0w6wQ+HFeEiolP79tSgNUDJ80W
 rc0TkC/yT9VXT6kgpK4U5Zz7UbX/XqdKtKeo2l9s9Eser7zueBn2jwLETpa7xgUAZ/L6l2Kv8cT
 PfjRga6q9wko1jpLCQ8QMePcqA/vEDZMNlQykxnfu7m8Bx5vlTpO7L9ekL8tb4wHN8OSOh90fx3
 foyTgioQ+Qh8OWGSJLm1NOXwNYuFae0okDy6KBw6Tw7MY8Afm6OtNPYhvX7Im61P/ufX4ig678z
 HEQwFLVP/Cw6EwFyJ/dyHJ1rPX1MQbxUzYSiV9cJAhcJ2KEAEuYta+SAaLNe4KYuiqzMDSlXUmy
 u3ggP9pQA=
X-Google-Smtp-Source: AGHT+IE9d8gKEFibvIiXh+oWLgmzLnCkGe+otYK9t6p57MC7z3cVMHpwmwbySJx/Pj2Ty5sJlJ87mQ==
X-Received: by 2002:a05:6000:188e:b0:3b9:14f2:7eed with SMTP id
 ffacd0b85a97d-3c5dce03f34mr7730428f8f.56.1756093374541; 
 Sun, 24 Aug 2025 20:42:54 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Jian Wang <jianwang@trustnetic.com>,
 Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v2 32/43] net/txgbe: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:45 -0700
Message-ID: <20250825034126.12046-33-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

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
index 0efd43b59a..c1c6e3625f 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -7,7 +7,7 @@
 #include <stdint.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <rte_malloc.h>
 
 #include "txgbe_logs.h"
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 99a76daca0..a329dc7564 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3,7 +3,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
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

