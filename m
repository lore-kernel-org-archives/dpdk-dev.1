Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F7DCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:33:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AED5E40678;
	Tue, 19 Aug 2025 01:32:57 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id D38714067E
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:32:56 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3b9edf504e6so2205973f8f.3
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559976;
 x=1756164776; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfleNHUAX9uYm3Z2nidrTZyWX8Cjkbds8wosyzkFBLE=;
 b=07tJEL964tdJYrJXbbpmMNGuxXv7oq+G4t04Xt7Z/kyQ7ax05scBKYk2gU/rJ+cuDl
 xEDlGZOJvOrBpF6UztF6S5nsduLaprzNlyKtg5Va7a3u9t5qRclr8ceeI8TU6B2zC+kh
 S5f9BofGJHXVftz2+M3cDN/Ui8nLg8LxgMljhaJNjmPgXnPm4HSccT7M3hOXxeu/mWZx
 bVsLfrWYkq8VbfY+a9c607UbATg1bnEmJWVqJaXUoaTfdeMIbEHZuM1/l25b0ZSZiO5z
 UMtF1wY9FLIaR0qVneVDIb9JptSHqrHBbKIN2WXyq1TkL+2Fzfj314tP7wDFJIZSQTq3
 e3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559976; x=1756164776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KfleNHUAX9uYm3Z2nidrTZyWX8Cjkbds8wosyzkFBLE=;
 b=rPrylZ9xPSZW2yHHl/lcB0CNgT66Udz5ps04Ie1b1/dKq57OWVI8ARMhwwfkFU4mLB
 HBbpBaaIBPFZjdiAdnBoCqgPkd9AeLdJWpc6IEqSNPiUhyl+5i6BNnpn08tta4MAlgfx
 iJDxT14TWHo+VUxKiYNxPinsq1yTUA7pxsM8mhjhS1n7nIsBGIe1swoxDFF9iYYNAWeQ
 zZV8iBrp6ZHh9r4Qy3kRxxKFif1Zc1IEBk33VoHy2ILTeGa+lRxpFT7Cg366sX2HHQ75
 eH1R4CKRTwUG5X9fKL+7LDVq/uK+xIcNRmmShOSrEVtz2UV9U2lbr9yb+m9lRjZ3bNmQ
 eouQ==
X-Gm-Message-State: AOJu0YzXWE1HfB0kuAdctJITfGFgKCe5CmDeBSvh/nQS0hlgtpfQZh51
 Gu5Z8ncvRlcZ7lY5WO9WIfGSocjiWGbSQPSx5LZRbB0BwPDowhBZTqqPH4lUvC+HCWOdHxbMRH4
 E8POQ
X-Gm-Gg: ASbGnct1ib+iY1+8N4fGpw0zjXq5XpFepQS1dsBu/D8OiqAiLrnvgfuDFEOrbenueD8
 kED6b46uaMt+2c5OJbopLkwE5mzvHtpOL6KmVhGOXhXficrDkSYLtBbz2SnMJxBgjaxhzNXsWcc
 5EDThR7T1h3JkoBzZhvYAeDw/QLfu0zjigWTDFENIaDm4dme6y3+ohRXri3nUK3uue2tFURaSrs
 ieRpFkhMPYpzHSBSToEevyDFks/6zOg4ZIrkJckit5W0Y3cMXH83I0WrxQ5T8t7pUy0H/DqZWnQ
 If+P4VZsuT1CR1Z9LZ36sGpNubXVvG4aP2+mmZIweHHzhu9ZdZXtr1rEq61osUi2x1RtpySd7d9
 NCH+hux0ZUGSWPEOEQfeMQXDFAs8N722VsHah0CTwvsaQlFWAH9JEpBT1QICHzoRIKy4J9rGf
X-Google-Smtp-Source: AGHT+IGLKn+SuO3nkJwIIvx5q2ZdQ0lQVScRqUiQGrohkVNHz3s6P8h8pxcpWDp/nkB8h5MM1+K9WQ==
X-Received: by 2002:a05:6000:310d:b0:3bf:2c26:eb73 with SMTP id
 ffacd0b85a97d-3c0e3adaaefmr269475f8f.17.1755559976458; 
 Mon, 18 Aug 2025 16:32:56 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:32:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [RFC 09/47] test-pipeline: remove unnecessary use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:20 -0700
Message-ID: <20250818233102.180207-10-stephen@networkplumber.org>
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

Not used directly here

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pipeline/config.c  | 1 -
 app/test-pipeline/init.c    | 1 -
 app/test-pipeline/main.c    | 1 -
 app/test-pipeline/runtime.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/app/test-pipeline/config.c b/app/test-pipeline/config.c
index daf838948b..61cf3a195c 100644
--- a/app/test-pipeline/config.c
+++ b/app/test-pipeline/config.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/app/test-pipeline/init.c b/app/test-pipeline/init.c
index 558f0e428d..2ca32db39d 100644
--- a/app/test-pipeline/init.c
+++ b/app/test-pipeline/init.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/app/test-pipeline/main.c b/app/test-pipeline/main.c
index 4cc098d7ac..dbc1e0d92d 100644
--- a/app/test-pipeline/main.c
+++ b/app/test-pipeline/main.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <stdarg.h>
 #include <signal.h>
 #include <errno.h>
diff --git a/app/test-pipeline/runtime.c b/app/test-pipeline/runtime.c
index 752f783370..e1d9f8174e 100644
--- a/app/test-pipeline/runtime.c
+++ b/app/test-pipeline/runtime.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
-- 
2.47.2

