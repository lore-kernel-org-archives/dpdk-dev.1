Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8C8CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:51:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F324740666;
	Mon,  3 Nov 2025 17:49:56 +0100 (CET)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 93C9540A7D
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:51 +0100 (CET)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-7833765433cso6096865b3a.0
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188591;
 x=1762793391; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bow7VWqCYPwp003SSThQHjTaoRSLKoXDnC2GTa3kMd8=;
 b=y/PN+a5sptKiilagrLtIFJb7aYlSIshHJLpjlfzHQ6wh19QLkaHKgbVOoOdOb7GN4l
 Slc0qqRNdbF9NuoNMqY2Hx6Iq2Tt2/Tprvo6572b0ByvYtMpEm8GUtJBHh6RsnlFJJfl
 jVcXmuK5/5vM7HYxkdVQoaANzdOHanhgmKJ7sg3VHP/lhDbPZI90AXeRsG15oVxkTR5P
 2tm1N0BkFslgw9sjiZMhzjwlDUKgq5O/u7mrkS7O9KHHKk8xcy74xcd3agRBSgoQl+LC
 G1wEf80xItmoG9FD2CCY0vBr9gTeodOWBxbavIMLWrEMYOqhexCGjdjyawrCs+/f9Otr
 FcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188591; x=1762793391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bow7VWqCYPwp003SSThQHjTaoRSLKoXDnC2GTa3kMd8=;
 b=mQxEB1hvBCENj9y+CCvF7MXotYSzGLXPJOVcSzMXdiaJI+591WfVm0Lyl5HrhGiSV0
 Il9pZDTVqoPDWO1XTZ3YSn7PlELHjs5vbdHfJJN4ubII4/ujlOQC70VXHHn4r4G3Spn2
 ZVNIuYm6vpBluyzRkuQTK5+OVKcyJITMJQjKfaltJeNDza0QW7ugzUqJOffYrjlcUPHT
 17kkLJe+46T15WQBrJUQRNcl8Nt5zRfuMwXIguy550M7o+eDlgcSWt7MKrsycG5IVxHq
 pOsH8rfTlYDOKBhpx1p8NEtKvVMyAYbd4c90KfKPsraahXTV74uiyTqc8e9krpAPUNX8
 sY8Q==
X-Gm-Message-State: AOJu0Yy9SRDe0P53jWFWqPW/z3gtOPSwHj9Fc4FysKHKaZwlAuv11/G/
 1t6SWfXbqBWJPzwRjmS3o1v+I2XQp4wFrrrs4Ouq6Fz3EE8Mc/6E2mG45GLkSS06FP2YNxF72cL
 P+ril
X-Gm-Gg: ASbGnctCOpKg6//Hd646sVsyhS197CqkZRSri7UQQqzl35BWKtsU6hv+s+6ZiLhoRMB
 PMqCPCViohy0TOko9WdsiDmcvLKEId87JXQqWrc74gDSa/hN8Yr/q5onnnKv0WVEqa8Foj+zN6a
 4xTxqDb/wDvJOqCf77uA7cWBf+ZF/uBZTXewXqcpUaZ/V3yDIVxqW7o9Z5+smsMRUqME2Sxramn
 qoqnmhIvj5kA2ywVu1l9k6A/9qQaIPdeB36acmaIrw2r61QbvIct5xMjjOHzKBUg++B66fbnEMy
 NukITdO5c4tKkVee2DPoqKLgUMxDIlg6Y9UzfcGpWSbXxFfNqjYYNwkg1orp1vl+mt7CH2wAUo5
 0YOX7jG6wLSe/dpYH2MIVJN4ZHQ9Zho+7PkJS5Ldv0wSGkTg5aehtwiMbo+l5z7BcMiFPNyzoCO
 MBUBXJ8wBVwJi7knL0lPcvWvKk2/j4NLZbt3lwAvxsI66uGiLKYA==
X-Google-Smtp-Source: AGHT+IEKgw9aTb5ymiTMMyEipBPJ8+6T9CwiDSy/KXzxn9N/YJXQ1UCr1e3aGWcFc4UhAc9AwHtF4w==
X-Received: by 2002:a17:90b:4f4d:b0:340:82c4:bdc7 with SMTP id
 98e67ed59e1d1-340830553f7mr17454508a91.23.1762188590724; 
 Mon, 03 Nov 2025 08:49:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH v3 23/44] net/cxgbe: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:28 -0800
Message-ID: <20251103164915.101713-24-stephen@networkplumber.org>
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
 drivers/net/cxgbe/cxgbe_ethdev.c | 2 +-
 drivers/net/cxgbe/cxgbe_main.c   | 1 -
 drivers/net/cxgbe/sge.c          | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/cxgbe/cxgbe_ethdev.c b/drivers/net/cxgbe/cxgbe_ethdev.c
index 0c337a6cc8..f354e2638f 100644
--- a/drivers/net/cxgbe/cxgbe_ethdev.c
+++ b/drivers/net/cxgbe/cxgbe_ethdev.c
@@ -3,7 +3,7 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/cxgbe/cxgbe_main.c b/drivers/net/cxgbe/cxgbe_main.c
index 2ed21f2d66..b3d7e1c012 100644
--- a/drivers/net/cxgbe/cxgbe_main.c
+++ b/drivers/net/cxgbe/cxgbe_main.c
@@ -3,7 +3,6 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
 #include <sys/stat.h>
 #include <stdio.h>
 #include <errno.h>
diff --git a/drivers/net/cxgbe/sge.c b/drivers/net/cxgbe/sge.c
index e9d45f24c4..3fa296b1bd 100644
--- a/drivers/net/cxgbe/sge.c
+++ b/drivers/net/cxgbe/sge.c
@@ -3,7 +3,6 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
-- 
2.51.0

