Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5781BCCFA04
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:49:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE45E40673;
	Mon,  3 Nov 2025 17:49:28 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id B84674066D
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:26 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-34003f73a05so5240184a91.1
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188566;
 x=1762793366; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thFpunLwfqTPTeZjfNxIKDtOsd6XRWixWcVBY8gJNDE=;
 b=2Kfvtk/Pcw0cb/s9h2LjwWkvNItqap8LKl/oBKMm9g6dDsXFOb2KTonfnScfEYfzd9
 aYf+fv7uu/CYqXJ59teurf/BI7eb+LdwQHeCRcYQ6IgdJxiyByAFk31wFVCes/SBIbW5
 Dq71tPyG3NhVgqSM8bPoRkSLHVZag/hnEGGxLjPPX2uD+lvbDaeckrss9KcOsoKf+nEO
 IKWxe1qRpokwcQFJTHpWdl63VBgrsB3yTMD5UZ7jl9xXYUvYVXktotYKwM6HiDlnexud
 QZcUlwwKvJC+3n6wqg+oKbGcGs8YK4G5EYMnkq+hccubJCghRTuwZmTP/emh0V3ui51h
 CcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188566; x=1762793366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=thFpunLwfqTPTeZjfNxIKDtOsd6XRWixWcVBY8gJNDE=;
 b=o30pmHbCHXPWEhNoypjZXCz7+/oBMt306vvX0kpj1zHKiAx8+jWxGfeUKNkyz5G/eC
 SKdCETyPQJYfRfVv/Bb4fTvXQdJRrevzZl+iHgqy/YqJhLtD0CRNPW1FLGZ2eGCRJ/AM
 4XWzYICbuNVTVkBtklvK2xDhRURlIu+zju7g7o2MkXWegvPBePmIfnbwT7KKHmjLEFxz
 L+wwRnSybXKjveOu4bGN9dvFtXVAyqIGF3mxgy8YM7OxOnFroS/RqSa3blMqhxnfF/nV
 WNmsKzNUgspQgOIV9XmWVpt/8NABCz6CgQh+n70GTVyb1cqqgUPO+3+3m36WnUpG77nh
 ZZgA==
X-Gm-Message-State: AOJu0YztP76Odbb62oAvxWMZYK7KUWHj5YHwaFRAGcT0cFVwLeNQxwvr
 dJflpu8Y20F2XzKTL34BnHudpRtsoGNOwNqzRkhAZjIoWS5Lf/DK17PGVeakykQTrEtH28tBVJg
 ksnfO
X-Gm-Gg: ASbGncsez/rsCXb/iNARwOKevmWM2sOr4JNiGwTSu8+qP3696SLi35q8Ms7Rm0X+g0U
 6gWNQ9i8cFTE3ffE0fR8f0QO5s88/hhJaudmeIVjeXLqUJXkgoDpvDHkjLvUz8NXJp986Q5KVUY
 C1v31S6atO6TLLrii+g6WVEGfZGmAFBcdDVhXMEgz7BetHH5irFOjausGvurjCY7dr30bp70Umt
 3p1zYDU79t/4dozuEdCt4G6DtihzgF6gGNQCs8hdVhLBBrT7yB1fAcsJOkZKPjThCpF1SNSbxO0
 4CjaLFw+CnrQNiXr2kTHKgKpJhnNTbvUqHo4xlT64vv9WCgIu7xe+3+sye6tXctH4v2AZg1dEe2
 ZyiHStaNrCxaASeLr8kq2W807S8Uh0R8fftNE0gOxFAUVFXnBdlRusERKcsGy4FjQBKskVPkcTh
 vtTRIJg+MKY/w4yNh0GAEKBl9hVf78MKZCKKytXc0=
X-Google-Smtp-Source: AGHT+IG2S/MMtaQmwBQqVkXmDDAoHpBYHtK9oXjBUlTNkEmvj8SCPekT+cXqrN8HpAsI1gYkGo71gg==
X-Received: by 2002:a17:90b:2f4c:b0:33b:b673:1b07 with SMTP id
 98e67ed59e1d1-341718d05cbmr57985a91.9.1762188565820; 
 Mon, 03 Nov 2025 08:49:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v3 05/44] test-eventdev: use rte_bsd_queue.h
Date: Mon,  3 Nov 2025 08:47:10 -0800
Message-ID: <20251103164915.101713-6-stephen@networkplumber.org>
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

Use the replacement rte_bsd_queue.h header instead

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-eventdev/evt_test.c | 2 +-
 app/test-eventdev/evt_test.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/app/test-eventdev/evt_test.c b/app/test-eventdev/evt_test.c
index 72d6228bc3..04681e1e72 100644
--- a/app/test-eventdev/evt_test.c
+++ b/app/test-eventdev/evt_test.c
@@ -4,8 +4,8 @@
 
 #include <stdio.h>
 #include <unistd.h>
-#include <sys/queue.h>
 
+#include <rte_bsd_queue.h>
 #include "evt_test.h"
 
 static STAILQ_HEAD(, evt_test_entry) head = STAILQ_HEAD_INITIALIZER(head);
diff --git a/app/test-eventdev/evt_test.h b/app/test-eventdev/evt_test.h
index ad3f531dcf..30b248d5db 100644
--- a/app/test-eventdev/evt_test.h
+++ b/app/test-eventdev/evt_test.h
@@ -7,7 +7,6 @@
 
 #include <string.h>
 #include <stdbool.h>
-#include <sys/queue.h>
 
 #include <rte_eal.h>
 
-- 
2.51.0

