Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C77CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:50:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F83440691;
	Mon,  3 Nov 2025 17:49:35 +0100 (CET)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 187034067A
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:30 +0100 (CET)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7811a02316bso3672401b3a.3
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188569;
 x=1762793369; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r1buuRHfIdfjMAmd5VX3QAujVr0XMLK1XGmE6wXWDjU=;
 b=M1nDlEtd/R5ko375OKsEEoXjulg6cef/IiYRFO333Zu1lWPtdWbRLt6fmDC1i7aOl2
 LRFU2Mt5HgddIcK1EpWJi+0F47Uf2a0IGHMnRGZdqyQpfOz/1iN8slX1BCzVZyeGtLAf
 tq+KjZAIJy4miL64TVr0zbfs7VZgch/O2UCo+0Z3+tDtOAJ5q1cLSLTLHyBBf9Bcuv3K
 pfxDInN+8ubNrpm6cN13jzNyaM91L+p4z6E7so33Tj//OGAre2Zi03R81DoYJTrOOKbD
 Y7sE6rwpRYqUD+41/bhJQA3B31lE8iOrwZ6uIW0E+P6XNfOS0TmfIAhB5l6QL9jmWcDk
 MiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188569; x=1762793369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1buuRHfIdfjMAmd5VX3QAujVr0XMLK1XGmE6wXWDjU=;
 b=kbHLwvUXID44BDGpHPlhQeBOGd/wPUObhFZyKPLfIum3D9OwXEPWdhVym+Nfog1wlL
 YpoQ6pWrwU6kY2FydOF1hWZMiZDSy/xf+KbdzrGkhXkJTHgsnG9odXXTwUsMQKGud9Zh
 gpMY6Ma3JNuN2zlRcyYLCJA8l1blbKUrGAH2n1kJZaxBYLMYxy/SidUC7q7NG0UIw79j
 ZXBfPaNQr/1esxMA99YPxxSdFigiyUoi60EFzu/S5AOBYqSGX0hcIhCIUmrFEdIzoGz1
 v7Up+kiXj+mhNCgZMwflkbmH9LMeSM2+sAFJzT79D13lNP55+076c2LIjetAqyV5/NVA
 fMOg==
X-Gm-Message-State: AOJu0YxWnlDPG5Wd3+7K6gjrcbea3exywbZknNBbejm3KyqmjMScLX8l
 rYyOOBZWIvz81FSsJpYWozOcOfXbur6wZs/En5bMpyBZDwZCVjd8CIaBhjbexJlfCLFPFv24oSR
 Xznk6
X-Gm-Gg: ASbGnct+5EzDx2dEOJQzOrVIYO60rBrWGqzEd73nZ+2EPSTZ584g51eNHVUECuWJnva
 Wd6xP7qbMXJLwIZsf4qfhhbqBRxtdvmHeP2Fbc8TIxuYFiO118tcEe3q9jWBSR8FLhPh07mLs+B
 PIy4RrkYHUx8ekVyqfnwda4xKH0UikCNyzVAVtTS1LVFNXuPeejAqnG1IqkDMfhn/GsvSuO6DMO
 2v/0jbcqVjs956aMz1KBA8NEWp8ZFO20Jma2pHII2MrXHXsYN7n5zfjn+kysEyKa38gT2Sn65/L
 vV0w0w926oY5YKjucLyC+ZuoI2TiFeJB4bV7xrw+6KMNddnVUAQGi1fuUs2zLHMpf10Xy4okqPd
 T2cEiZ/gkjQBvhLZlf5EBBoJTHjRPKaifPBcu7LcS4DNAUUQ9jzb4zny/x5T2GN2rqNtZDF1G0a
 WzwRb4xyMla6cJjkrWv14ExLM84BuAn6bIA8bAZaY=
X-Google-Smtp-Source: AGHT+IGNcROyotChVq6NWNA36BhVEluL6awsSnQcTXvT0YABtEZmn0f81sDI9uuJINVkhnq1RKSXUg==
X-Received: by 2002:a05:6a20:6a08:b0:334:8d0b:6640 with SMTP id
 adf61e73a8af0-348c9f667d4mr17671888637.8.1762188569223; 
 Mon, 03 Nov 2025 08:49:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v3 08/44] apps: use rte_bsd_queue.h
Date: Mon,  3 Nov 2025 08:47:13 -0800
Message-ID: <20251103164915.101713-9-stephen@networkplumber.org>
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

Use DPDK not system version.
Not really a requirement but better to avoid any possible conflict.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c   | 2 +-
 app/proc-info/main.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index e5ba36350b..506b4a5358 100644
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
index 1b9979b7c8..0826b934fc 100644
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
2.51.0

