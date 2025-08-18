Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32DECA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:35:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A4F640BA6;
	Tue, 19 Aug 2025 01:33:57 +0200 (CEST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 95C604066D
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:54 +0200 (CEST)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-45a1b0cd668so24892415e9.3
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560034;
 x=1756164834; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFPn98A3GsF5yBBhq+krOqJh2cqLxoJZKBFSBI8CxzQ=;
 b=nmApSFB2GiWSD6xgivwar//QHGlmmln7zxqIb/9Pc1VWAGiK8Y3hIPjTNc7wm8cwCX
 jLNRIP4y7vBV0IKa7FzN9eawbslOQ6yKUHp9ND0lOqijINlqhxOiompPge/EEpGsD9J6
 21St5sJiUmochmKONRvJQX5bLLBvmjp4zJiIStT3jmyYt4ouyjUikFQe7LzafFRef3Uj
 BTMwSxSsU62urmj+P4UhSml5KLaVOtGv/mAw6L0jYp0HeNjVjxoMJOyv6lVi1J5f4WgX
 NsvflOKxThjMM2uT/oVDb63Gfz0RLHb0soiJTL87UcmpLG1IW/O48n5Nj8Op9lAxzsXG
 F7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560034; x=1756164834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFPn98A3GsF5yBBhq+krOqJh2cqLxoJZKBFSBI8CxzQ=;
 b=oq7IjmNCOb7nlOoaKQ9OiUyWCZ4Yq2JTqa2gCfckArzT+vFdTCeW8+1Li4FxjovXvV
 NCxlHgo35uVk/CqBSeIP6RcVIVjPaLdA4gKda1/hayY08t3E+VrYd8oVi7/Z+pvJ1Xu8
 f8HTso1jWo9UswY4nGD3hiEiF3rGwFmnga88AtVT8bL84VYBpCL93YIo0nXnDAQAXPSe
 WyQAGVSoEp6mHvedFyZcccue5f4FIJPI1wBygVddZkTn23cRLSkt5Kbwcie5RRrBeEik
 xEcKotB9dBbpMnxHVCITEGMRpuoTjyA2L4c5SxEdz1ZN2nhWkOBcRPdJLebzQRmW0LCr
 5uwQ==
X-Gm-Message-State: AOJu0YwKy6pS8KHU9jt3M2FJ1Or4nYY3dOMv1VImzQd/YSe25xREiGtl
 VXPpmy2QqnYqRgbWjHGbMtpHOvowbgEBPLtMsvnxTC6EJ5MTYSUtcbDE+8Z5EcHDyyG/q6HgMvu
 cOP/y
X-Gm-Gg: ASbGncsAc8XsNpIIWE0GQJg4Gkpr8mkJrd1T461n2yfH9v2qI2sAolb9Z0WjwFo/ATz
 vWFHb1m+7uVyR7skiPGxd+kLgwT5L5NJCyapETjfsjdwR/NuFexWo0v/Hmbui7JNsJaBiRjR2jQ
 u/Rz8O27CcXOreW2UeWNTpYgm2Kn2MlGHiUqQOl9Og5Aq626DdTMsJ9Iu1vriDnlGwXRjFCHCQY
 bu1CoKoQwB5oOb1UP0czbBH+2G+qW+1HBTRNCRnt4LNR7bVJPsGIHCBBL/WPfgqkAsrTuKgdSFa
 8RVk09IBrBY0RgLJkbU6q3Svy0K/I/YKRXo3DKkHnPukQtrDwMv6S302bmbUkpYFPPAgoiOx8Kq
 MYIWOKb9ZWy78BKxOPmZL56ttQYYC/3xmNmABSi0bO65CckERlcDkUaEL6chYqyPRaskyq8KK
X-Google-Smtp-Source: AGHT+IHGwOXFeFEYQD+/C9Sl9mmGAq2II12iYhqHLaoLtwWfUVs51haOclzWKPC80b3qyYHHnsv6mg==
X-Received: by 2002:a5d:588b:0:b0:3b7:9c79:32bb with SMTP id
 ffacd0b85a97d-3c0ed1f3106mr297662f8f.44.1755560034136; 
 Mon, 18 Aug 2025 16:33:54 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [RFC 30/47] net/cxgbe: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:41 -0700
Message-ID: <20250818233102.180207-31-stephen@networkplumber.org>
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
 drivers/net/cxgbe/cxgbe_ethdev.c | 2 +-
 drivers/net/cxgbe/cxgbe_main.c   | 1 -
 drivers/net/cxgbe/sge.c          | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/cxgbe/cxgbe_ethdev.c b/drivers/net/cxgbe/cxgbe_ethdev.c
index 9b6a3651f9..3d4a333a27 100644
--- a/drivers/net/cxgbe/cxgbe_ethdev.c
+++ b/drivers/net/cxgbe/cxgbe_ethdev.c
@@ -3,7 +3,7 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
+#include <bsd_queue.h>
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
2.47.2

