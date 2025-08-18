Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3082CA0EF2
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:37:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5176140696;
	Tue, 19 Aug 2025 01:34:31 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 2084440B9D
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:34:30 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3b9d41cd38dso3672643f8f.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560070;
 x=1756164870; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/6cvwORRx7KUvl2otsNEaP70fBEbZ6fhNv+FJZmzwQ=;
 b=yAwQYVR78JIhPaKH/vSEVpNfLjO3/Pc1tiam58lqKWMDR9J75Os2za8xAFqxv1ZYtA
 xf3ehFGtURJHpD0LzNzf7NVlEjIrpM3PzmyoGKsFH8KxMtFHnv9y4ntV164oywkNvncy
 flCNYOySis9k9Eg2Lf1zm7o9GF4X99cRYO3gRpmmgJm1s9TreLxW4RQp79Pf5oH4XRbN
 otG0GRYtWCgKY21OOY4u/1m2gpyyvybMkHRBQZzY27y5taP//MnSzMrEESDt00UsiN4N
 hM4kLxhzqsfGR5xlJlUONISmK8DF6YUw1xx36Q650UXHvrV+oC2Fwp0xQonHg7ZibWQa
 0EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560070; x=1756164870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/6cvwORRx7KUvl2otsNEaP70fBEbZ6fhNv+FJZmzwQ=;
 b=e8kcAGhFZARzEYKfhbMV1GjT3qNtN46uX4dImM9E2TDdIDaxNKm7REzHAS1REjKTAl
 0cVatUAO9d63ambTmIHmWayE0CY49tbjkWPHfs4QOI2U77WsRhOzAKhnykxZImmp57zx
 8Wol23viUqVh2eqTYnNkPUP7UMhYZtapgYoBADKoL3Bbi2Ioy3Ydu6VJ3HvIz3e75pyA
 dz06gLvlr+t2/1CSqmbvdX3cnAwLcMxpzeHTP5yKbi5BNPvhiQavc9uDiGAeucWf5U9e
 is6Y/0HlvFtcZHMt4wdUjRm+qjTEds50txXICSZP1YnoexFUET29VoCEqds3Wj3FNxdP
 Hcig==
X-Gm-Message-State: AOJu0Yw73d9JkyESoZwFEHqJyn6wtP/nPPIA4JE4QOu/wn39FlsQTa4D
 KM3pby1l2DMd2qVu83jCQLE8YRe81E/r4cJW1ZFn3JidhcjoYmIPVbXZP8Asdeewrj7Yy0ax7xx
 zaDvR
X-Gm-Gg: ASbGncuEiZYpEHdhTaYqJXqa2N8dB7OW8RmbK2/iiuMoXghrxHGvxCC/qOrJeZfo8QN
 hMDHSiBbYiiJ0RvrBIgrX8xWURZ7UupmtwYT557oC0k5C4DBJhnBGJU8ll2f/fizjw6OnlFxntk
 UIedSIPw8tHM+fksQNi9ZUPTwXcTb8FpIWbplQW+1pxuMfsi1BR3erBs9exy3cL2DvgU6OhqU/L
 Hal+B4gwPEvQ0CdmXddHYVvF+vtqDP3Ved6RBd2T6GBqBc4WcJKMeLwlzH/pQm5bn0rtOCZhzjn
 QFQSWTxlpA0vTNHyxH84vccu8T1qtWIiWbxdd+InKkc/s1geNMem7F451zzOouESvE5Glyh5znx
 Vnlg0k5FW7xpCZjvwEXuVF3VvQRsVJ5iyXpNMhRbPRGLbmdKOzVNCJcuaYkROCzyCElp0qJJLml
 rqqtZwmxo=
X-Google-Smtp-Source: AGHT+IFUUFIjT0qBMOT3bFzOTefjG07rhMdkNsBnCkF6k4DI2GAD8oPK650bfRJxG+f8owYwd7Jo/g==
X-Received: by 2002:a05:6000:2502:b0:3b7:dd87:d730 with SMTP id
 ffacd0b85a97d-3c0ec756f42mr311057f8f.52.1755560069677; 
 Mon, 18 Aug 2025 16:34:29 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:34:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Rosen Xu <rosen.xu@altera.com>
Subject: [RFC 47/47] drivers/raw: replace with TAILQ_FOREACH_SAFE
Date: Mon, 18 Aug 2025 16:27:58 -0700
Message-ID: <20250818233102.180207-48-stephen@networkplumber.org>
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

There is now a standard macro to safely walk tailq.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/raw/ifpga/base/ifpga_enumerate.c  | 6 +++---
 drivers/raw/ifpga/base/opae_intel_max10.c | 8 +-------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/raw/ifpga/base/ifpga_enumerate.c b/drivers/raw/ifpga/base/ifpga_enumerate.c
index 61eb6601ea..ff0790038c 100644
--- a/drivers/raw/ifpga/base/ifpga_enumerate.c
+++ b/drivers/raw/ifpga/base/ifpga_enumerate.c
@@ -6,6 +6,8 @@
 #include <inttypes.h>
 #include <unistd.h>
 
+#include <bsd_queue.h>
+
 #include "opae_hw_api.h"
 #include "ifpga_api.h"
 
@@ -725,9 +727,7 @@ static void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info)
 		return;
 
 	/* remove all device feature lists in the list. */
-	for (dfl = TAILQ_FIRST(&info->dfls);
-		dfl && (tmp = TAILQ_NEXT(dfl, node), 1);
-		dfl = tmp) {
+	TAILQ_FOREACH_SAFE(dfl, &info->dfls, node, tmp) {
 		TAILQ_REMOVE(&info->dfls, dfl, node);
 		opae_free(dfl);
 	}
diff --git a/drivers/raw/ifpga/base/opae_intel_max10.c b/drivers/raw/ifpga/base/opae_intel_max10.c
index 58c884a8d8..84e0767b3a 100644
--- a/drivers/raw/ifpga/base/opae_intel_max10.c
+++ b/drivers/raw/ifpga/base/opae_intel_max10.c
@@ -4,14 +4,8 @@
 
 #include "opae_intel_max10.h"
 #include <libfdt.h>
-#include "opae_osdep.h"
 
-#ifndef TAILQ_FOREACH_SAFE
-#define TAILQ_FOREACH_SAFE(var, head, field, tvar) \
-	for ((var) = TAILQ_FIRST((head)); \
-		(var) && ((tvar) = TAILQ_NEXT((var), field), 1); \
-	(var) = (tvar))
-#endif
+#include "opae_osdep.h"
 
 int max10_sys_read(struct intel_max10_device *dev,
 	unsigned int offset, unsigned int *val)
-- 
2.47.2

