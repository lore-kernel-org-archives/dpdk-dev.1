Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427C0D31A02
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 01:52:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20F0D4065F;
	Wed, 14 Jan 2026 02:52:03 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 219FE4065F
 for <dev@dpdk.org>; Wed, 14 Jan 2026 02:52:01 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so4274279f8f.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 17:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768355521;
 x=1768960321; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60TsemZeUH0wgbiQpawR4ldImOIf4QniqaVe6C0MBvI=;
 b=ZJWSVwJSVnA/yO4N7aSL2J2QCT5m6c/P8dBXISITwONcIWI+BmNVa2RnGDeXNrDWvy
 5Eg168qcrO0fmVX51m1q2p/Ykw7mBg2MmevI83/bDqppcGmMvLZJMLuONw+nAXzV93Me
 bNDgeigEqEnfbWsYoirMhcw63kKMPqM4R4DadFVURN2yqjJxpESaj1k8T30U6nIPYZ95
 swYdSIVwGvAOfTmTfXhID8lfQ1Ce/0V+UdGv3MxfQRd4CnkwVQkTto7Lcgs41unUFgtL
 Kq4BjBEFB/5iVwAiV/d67FkhIdTCNJMm7SRFw7Ninj8rizkZi597rI/JN+aTBrYC1rGF
 Mk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768355521; x=1768960321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=60TsemZeUH0wgbiQpawR4ldImOIf4QniqaVe6C0MBvI=;
 b=M3YIN9sRSSICJaSRsQPNYPiGqgzccIJ6pQa6q6AjujK6+HBZkW4NYdYC2XSv8JtoSL
 t6vI/oLB36RbUeRmpwK/6J5nJGKJyCCLKusXS/egRK7ZxvxQ+ZDg+Or0GwmjyWJriJ8W
 Dnwo7++M68CPoYMVde5DnR1AQVGzGTH/HihNM8uQTSYtMQGdjjNTtz+qSaIQD+Q7rFU+
 iYutlZKtH9Y0Nbn4A5xB9yLqYz8Toz95b+0/6MlsUQgCh/qmqZipXRXbUrKcWCujVBTy
 sCwxFQ9P4v0c0d0unHqcAqDqcJ+EKzTfSSkFMxpFQN65g66WozJNdXAn+HyUXx+jgBk/
 j6Lg==
X-Gm-Message-State: AOJu0YxHp8X7UMXXRs5Z726PpM612hCrzDFifH1a24iUCBFaJaTf5VhV
 cwz6ExN3gQ8V5Zn3Ev4Ou0T3AhV8kr1/gQIQa/97Hq2GIVS5xIsh18TyoHGDsYQQsnY8c03Xzz5
 XbhWi
X-Gm-Gg: AY/fxX7J/n5IP6plv5q7oIgprPN9GYl61ddP8b9XJWGCvk89s26C4f4Vnak/UDo9RQf
 gxyuE8i3tiGgcTRpBa0F9r0cANtTW1+I8VZAx3CDUWnPMdByJMHP+KIqJMxMEafffVvvY8VRU67
 AfRqLf2UEET8ZBEmP81g4roucJOvDDYu6+zWUwSYMYOQkHDLgy1yymlCGwc301EqPSTMCw410qM
 s2Ga5J+bePil4X9bll258e0Lb3kdhJ9PTx8cWaSEZ1vVckKbzppAvwBl2i2tg6WAJRkqTk92j4X
 D7EZskTk2r9uz6VmEW8mXHXcfmZC1rYE6un/J7GgXKVJ3DgMs8BTwa2CccydIVVA/2uidqkRyUj
 2NnBxQDAw8kmuezZJL9Mwdi2eeXcm6xhexK7hdL0o19Eq7iUgriuq5/hViVCDW014YKh42UBkYd
 lbsiK786JawaaVACNYhxng4Co4yS2y7mfZkjOU340NkcCWX6pC5A==
X-Received: by 2002:a05:6000:2893:b0:42f:bc61:d1e5 with SMTP id
 ffacd0b85a97d-4342c4f9c8bmr1045506f8f.15.1768355520742; 
 Tue, 13 Jan 2026 17:52:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e1adbsm47619810f8f.17.2026.01.13.17.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 17:51:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v2 2/3] common/cnxk: replace variable length array
Date: Tue, 13 Jan 2026 17:50:00 -0800
Message-ID: <20260114015149.70983-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114015149.70983-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260114015149.70983-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This fixes errors when compiled with LTO about large VLA.
../drivers/common/cnxk/roc_platform.c: In function ‘irq_init’:
../drivers/common/cnxk/roc_platform.c:92:14: warning: argument to variable-length array is too large [-Wvla-larger-than=]
   92 |         char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
      |              ^

Since the number of IRQ is limited by EAL max interrupt vectors
use that define that already exists rather than a function call
hidden in a macro.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/roc_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_platform.c b/drivers/common/cnxk/roc_platform.c
index e13cb42285..1fdbf8f051 100644
--- a/drivers/common/cnxk/roc_platform.c
+++ b/drivers/common/cnxk/roc_platform.c
@@ -17,8 +17,8 @@
 #include <sys/ioctl.h>
 #include <unistd.h>
 
-#define MSIX_IRQ_SET_BUF_LEN                                                                       \
-	(sizeof(struct vfio_irq_set) + sizeof(int) * (plt_intr_max_intr_get(intr_handle)))
+#define MSIX_IRQ_SET_BUF_LEN							\
+	(sizeof(struct vfio_irq_set) + sizeof(int) * PLT_MAX_RXTX_INTR_VEC_ID)
 
 static int
 irq_get_info(struct plt_intr_handle *intr_handle)
-- 
2.51.0

