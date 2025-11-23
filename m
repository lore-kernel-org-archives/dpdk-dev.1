Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C5ACFC518
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Nov 2025 17:45:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1290402F1;
	Sun, 23 Nov 2025 18:45:27 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 13B53402E1
 for <dev@dpdk.org>; Sun, 23 Nov 2025 18:45:13 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2953ad5517dso43907815ad.0
 for <dev@dpdk.org>; Sun, 23 Nov 2025 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763919912;
 x=1764524712; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPV8XWN5kzGwUHHfRTMUptVJ50v3Ve49LdHqj0/n6Oo=;
 b=nG7Wx2byaebFrATJy0RXEhBzlTuYdN/kGk5XmMAdHqj5ZehKLYlzLr8DMwvp8DKzYP
 pMFDcwiSXM2P5rV1Nrd55I3tyIgODEJmZv2PS2ngRi8x6O6NLV8pNDfCrONArobKXAcL
 SN03w5F930HS3lBRdCGnTj7swxtmadvGMiP/E4A6QKpKqs4dyXdcBnUxg4rQd/Xozbc+
 SM5jDY2E74QtC68mH4MOkUjOD3cV57uzhagGk9aqwK4DbhQvMWfGacbx9xaskgf/VlG4
 +siiSReEfA7Dr95mJSSjGha+lpXAPe9esa31JqwPI1edCZgXyoI39Q9HwPbr8Tx9DzbD
 y/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763919912; x=1764524712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wPV8XWN5kzGwUHHfRTMUptVJ50v3Ve49LdHqj0/n6Oo=;
 b=TVUCGbE6M4ykfapyydC9EnZDnedNyo5Dyo5OEYnW1l2iuf1xLXF9upL1K2zKzhkd4U
 kvzC5Ez4K/hvXsDrBTkpwswg5LOwV3iCWhoswlTIXgiKrdJM7WDiHaySozwUeiMXzSba
 4AC+PD5Qnho7u2AJg4HVXZ5Rbhn42YCg2Xl/7QqhWc2x9ns0l31tSXIGhjyidsvOejnh
 Bm4uH6bCzXcz2aFdm3lqDP19w8rMjGLbJZmHNN+YK7vV57xWuLS+XDW38YbUZzJCJRbW
 mJ6WUwSvzKUFe4aB/KdWGPr57meAtnx5DC9a1ZYLt0QGLENjraXqVSEhhTflXZ3jUcz1
 Vj8Q==
X-Gm-Message-State: AOJu0YxGZRG7ON/7u/sT1bWVgztAgI+8If44Vlhg0eoWG/sXpS2UMzbO
 KFHsaKKTx+ZRI36x76HJehI75V4ICscGTLI6DwKe6ABjiyZNMJMoWOoNJXktZI6x7mHcUREF8Ja
 D9SdA
X-Gm-Gg: ASbGnctd1ZhUD8QSJfKwhLzr3tavAHToc3l3NWZTH00YV2HOpCgLEG9tF8sFursirji
 6/HyWhKRSh90gYg9xMbsk3MBsI+0bNnzRV9ZGB7HXz53lpA1+OhGB/IB+w50hzIYir6qvkmJF2g
 ihob82Rw+j6GzUTW2gsvxnAZRqtnd/PWOuDl9V1aF/NB5x7onI9Vup4hM/ATYDKO3mlJItit6+4
 e03+ZKGcS/UW6uT88s/ZH2ENQe2otf7ImpcGvOKkAWQJXJaRct3FVzNcRZqh5kp8koSdAJIHd85
 GuAb+gHX+5+6CRXIeM6kESSIM4Bf9Qf/UxbBTwEnFlZH/en01fh10M3MpyBr6yhrUSmPwkggxSI
 Qu1HJ7YrIoC0LF/aOJSr3rInWRt3g4rPmSK8+LvUUrcEio8UWdL6GsuTVd1MpzQhNF2VlilDevK
 kZIWopCpXVUt/fn+hyOk0up2gzkukMI4tfTcElZSdTn09Js536VSUPSTyEfNrw
X-Google-Smtp-Source: AGHT+IHvEIbZjbuHkIpaGR1ulhCnN0ggy5eJsSb7UtMQh7m+ZjWIsD4Mosw1F7t9Y+EB5GQuVAM49Q==
X-Received: by 2002:a17:903:185:b0:295:9b73:b161 with SMTP id
 d9443c01a7336-29b6bf5b9dcmr102432905ad.44.1763919912236; 
 Sun, 23 Nov 2025 09:45:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b13b973sm112585985ad.39.2025.11.23.09.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Nov 2025 09:45:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v6 8/9] test: fix overflow warnings in mp_secondary and pdump
Date: Sun, 23 Nov 2025 09:43:31 -0800
Message-ID: <20251123174503.20880-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123174503.20880-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251123174503.20880-1-stephen@networkplumber.org>
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

Both these tests lookup the current file prefix and
format up a filename argument. Avoid any possible format
overflows by allowing for bigger string.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_mp_secondary.c | 4 ++--
 app/test/test_pdump.c        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index f3694530a8..1b1d8b38f7 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -69,8 +69,8 @@ run_secondary_instances(void)
 	char coremask[10];
 
 #ifdef RTE_EXEC_ENV_LINUX
-	char tmp[PATH_MAX] = {0};
-	char prefix[PATH_MAX] = {0};
+	char tmp[PATH_MAX];
+	char prefix[PATH_MAX + sizeof("--file-prefix=")];
 
 	get_current_prefix(tmp, sizeof(tmp));
 
diff --git a/app/test/test_pdump.c b/app/test/test_pdump.c
index 9f7769707e..c809dd2aca 100644
--- a/app/test/test_pdump.c
+++ b/app/test/test_pdump.c
@@ -176,8 +176,8 @@ run_pdump_server_tests(void)
 	char coremask[10];
 
 #ifdef RTE_EXEC_ENV_LINUX
-	char tmp[PATH_MAX] = { 0 };
-	char prefix[PATH_MAX] = { 0 };
+	char tmp[PATH_MAX];
+	char prefix[PATH_MAX + sizeof("--file-prefix")];
 
 	get_current_prefix(tmp, sizeof(tmp));
 	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-- 
2.51.0

