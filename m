Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D98CA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:33:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2676F4066F;
	Tue, 19 Aug 2025 01:33:03 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 087CC40689
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:02 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-45a1b0b2d21so22940035e9.2
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559981;
 x=1756164781; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/mJKJk3fu5DPJYgYw953wgZhl21dyAKOFZQMmvJXVc=;
 b=Ob3X5r3NSk4UBqeEtciqJpduVsbkZfi4Iv2tNzhl7kZVf63Sf7G29t4zhco4o3mILn
 H6AAqRonKovn+BYZhhrW0uFBgnxUye0d1dRoAMHGx4JYTBPq6UMCzmhV9fOn440ExHw5
 NhUJgVhVXwakqy1v5TlsWJ4kSAqky9vkrQ8R7l9oR6qXWuxouqrbW8Lx3Gk3nIdPizWu
 4+WlUt4NbSEuiDAkxRm9fNLxE1iZ2a8NkSWqwCdLucX6jslsQSe5ElKZMn8bZAvSadV+
 26n4YI3R8bSAlY7Aji6+2ISM1F0yBMK5Tm50CGJge17gpZ2iD7S9kPf7Luh7NYig6zvB
 mlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559981; x=1756164781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/mJKJk3fu5DPJYgYw953wgZhl21dyAKOFZQMmvJXVc=;
 b=SHpbGGXMsaw7+q3z35/VCzBNqi9o7ZGBoJ1KnJbI21yX+D3DvbauRcPb1n+8djQrQJ
 ZxjFIbooczqg/a+lU6F7Ymg+vkW0A4UxteoNrJAqj+dev2Qh2hCUeox85EIy7/3c/iTy
 J86BeMKa9FFoB7RXqZ70SgSScssvGeGNJKFDWYWyUqnATMlX8glbf8KEwXGA0+NoFFi+
 aQih12TAQ5w1ERkH+mG3my1+Du0aNfpyDhv9kxWLBdmm6URhmPYqHRYBwZVUnN1n/8Dz
 XhmA1d6hEERwWvdF1jznhJLqpEgvmWlDudV8KoyS/WQfVf6xfQSogo+kMS4f5lwMLmoj
 rLkg==
X-Gm-Message-State: AOJu0YzZa7irvKims8EzRCB0cLeOkSZfX/3SheoycIfAWNK2l/DLLyQZ
 00XENdI4UADbsD2AcbVMP8BMLfvDWw5WU5DmyCEyTpx7mIuz6d4HEDLyPVxBE6i6sZu0NkU9yXb
 EWsfi
X-Gm-Gg: ASbGncuVfHvlQt9Qf8ZT3pH2SyYL2Fqxq6kzXu1T1lY4a2H0uszNEuSvO4Plo6GdTpl
 q8QfSTL+slSm/tbds8+9UGQR6W2kWGhPmgMDoltXSjYSheqQVskxxfntD6wWRts9thh2rOLVbmC
 IHAPdcD8eIorfTmNKWQ+6Lihx1pv/ymBITFQ5cCHP5Te6avF038HvDXIUgk+wzebE26H7DvjXTS
 i4VEwuk8+jjhfop6PxBp6dgPoLwDZjDoXZRIUjZWlUZz/7nGl248BdBKINSud8Ee1/mLePpoKrn
 0XgIJ6TPhgInvqYAO7aVcdivXw0wB3PiOYittws09cYB5bKTBXWEf4+sU6fP98TAlkEQ7/fteFx
 a0+iRWTuQ+4oYOvFaJc73eimPJArzL4zEmv1Eu1Rr0mCDt6CoODuhwSjqxzBgbwHRKAeuaB/f
X-Google-Smtp-Source: AGHT+IF5RGRO+LOlUxG4j44lOkw16oJXK1ZTnfGFZq+5gGw5gK5iB5GDuRNh4zyGuXiG5WvfT7FGxg==
X-Received: by 2002:a05:600c:1908:b0:456:1846:6566 with SMTP id
 5b1f17b1804b1-45b43e104cbmr2210505e9.29.1755559981592; 
 Mon, 18 Aug 2025 16:33:01 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [RFC 11/47] test-bbdev, test-cmdline,
 test-mldev: don't use sys/queue.h
Date: Mon, 18 Aug 2025 16:27:22 -0700
Message-ID: <20250818233102.180207-12-stephen@networkplumber.org>
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

No need for direct inclusion here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-bbdev/main.h           | 1 -
 app/test-cmdline/cmdline_test.c | 1 -
 app/test-mldev/ml_test.h        | 1 -
 3 files changed, 3 deletions(-)

diff --git a/app/test-bbdev/main.h b/app/test-bbdev/main.h
index dc10a505d1..67a10e7a9c 100644
--- a/app/test-bbdev/main.h
+++ b/app/test-bbdev/main.h
@@ -6,7 +6,6 @@
 #define _MAIN_H_
 
 #include <stddef.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 #include <rte_hexdump.h>
diff --git a/app/test-cmdline/cmdline_test.c b/app/test-cmdline/cmdline_test.c
index 89f4260cbf..3927381f81 100644
--- a/app/test-cmdline/cmdline_test.c
+++ b/app/test-cmdline/cmdline_test.c
@@ -10,7 +10,6 @@
 #include <errno.h>
 #include <termios.h>
 #include <ctype.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 
diff --git a/app/test-mldev/ml_test.h b/app/test-mldev/ml_test.h
index f35fa8aadb..a2de5b3a31 100644
--- a/app/test-mldev/ml_test.h
+++ b/app/test-mldev/ml_test.h
@@ -8,7 +8,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 
-- 
2.47.2

