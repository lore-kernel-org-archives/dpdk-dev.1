Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78503CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:52:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6153140E19;
	Mon,  3 Nov 2025 17:50:01 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id DAD7740DD6
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:55 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-33db8fde85cso4566690a91.0
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188595;
 x=1762793395; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzGZtuJRPAHs9+CSXP5QfKfyxgUlNRovkHAaCLLRCJs=;
 b=vwzKzBW9zcM+2cuDzqYky/Lrk7Ps32mpOKUYuG1V9Bh6ZcI55Z49qcciZjQirumMaV
 8VGchp1ZkCEMANc/AXnQGKuFfsOCTrhItaygnYrXqBVf3i4vuftQ2a37o6gIcJI8NLA2
 CI2LnYag3Kv2/4yu2GslQbaL/yerES5e4aCjOw9/fZ5WGThZ9H7AKrY4L47Bu9cu+tyy
 vb7qLU6P8EtbTml8ReYCLKRzOzssZ+2cXohM8jZMI2nNVT9VyZZOVikgo5a12xDxXFbL
 HXtodrIm9Wy6NWZwc1SHiVxCAhjTGyV06MHoTu7sp9AEM2XRXdmDF2YLZlk6L5ahlFPv
 K+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188595; x=1762793395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzGZtuJRPAHs9+CSXP5QfKfyxgUlNRovkHAaCLLRCJs=;
 b=W0/XeXBtR0ZHE+Mk9HIQtJESOjBlPqg5BHNvjxIEc2+ZDBhPn+kHeMyH4vguCLAKaj
 u0rv2heBKn/JyYEm2dl3i+J8VhH/CWy4m73m6WOM4/TUb4naIdV0kuNX1MgiI+KpREJk
 ssHCblImJYawnnjsBWfuWBOr33k6ZeDe0UDqsurS19TkkU+dbN8tB/BRMGW6s2EOrFb3
 9ZaYwg2Idv40KA1tGHKYtPskfGVHxgZQLq6erxStQ/sp8vLT+WjJPy4baDOIfM+gjKsR
 A6kzKwlGv5NivL2+8rcUIJHa6V9kj9Ygu5TkNIeSgHO2C+33isMexhvWUT7k5n2+PYQ7
 nqxg==
X-Gm-Message-State: AOJu0YyypH0jRDw8oh+YkSGCv2X0aiUL3yQa/VEZoe0Nh9R/x4TiKCcm
 MdPdlNEke84ErmM8zj/xbhr+A3G5YTEgHAKE+hEfaGe2xj6893suSdzKzoENK+WoR19ooRdXamA
 RsfPB
X-Gm-Gg: ASbGncuSy4yGvZgEQeVerY6zzKWqVtHqLOjmVwPqIqyc8E21SpA9oeRmjda5qqVpoyy
 442dRr7i42sV7lznNHHdZvF7kj4FcwaPL93+5wLkqMhBIpIAzD3UvUiXST0oqLjcRm8c+AaSnmA
 /rwrg9hCTqWItPgFUvyxmeDnuwTBfVmw51fu9btuLQPga1NNyZWQpNqOj5ZenGDzjvhLg7oIh98
 xLSpBnTKxzVZmuUpoLm7H8g7DZ/0KhImIEMMRnukInhyFvg0CxWQRl/3FBD9l/M88nA7T5oPOMx
 nXyAHQ23nFgUqghfc9khb5KuNA/f3XsPb/DcQKurSnzF0AvxKF7GJMqWSnHvXA59vmCwzpeQWRo
 UtMuMaBJwvmh9M0mVu+JURR46NGobdsP94B7szpoZ1UDHfmqa1mLImY0i165U6KrNkZbAXRR9dh
 Nb+b1Jq+Vq4hG7J81RtXcNbsjwi37GpMWCWpuqxQzg05SWwyTSEeB7UIFKoHPz
X-Google-Smtp-Source: AGHT+IGw+U2HsS2rxRGwvSBc8ovZh46P3nLPUke7UkaO/5RZljmJx3jAKWgAVZDvISHnEdHnvfvaow==
X-Received: by 2002:a17:90a:e70b:b0:340:2a3a:71b7 with SMTP id
 98e67ed59e1d1-34082fc3919mr16455895a91.12.1762188595025; 
 Mon, 03 Nov 2025 08:49:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v3 27/44] net/ngbe: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:32 -0800
Message-ID: <20251103164915.101713-28-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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
 drivers/net/ngbe/ngbe_ethdev_vf.c | 1 -
 drivers/net/ngbe/ngbe_rxtx.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethdev_vf.c
index e575c47049..62ec1dc2e2 100644
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/ngbe/ngbe_rxtx.c b/drivers/net/ngbe/ngbe_rxtx.c
index 95e2172ee4..0f9ec153cc 100644
--- a/drivers/net/ngbe/ngbe_rxtx.c
+++ b/drivers/net/ngbe/ngbe_rxtx.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
 
 #include <stdint.h>
 #include <rte_ethdev.h>
-- 
2.51.0

