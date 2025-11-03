Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A15BCCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:52:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7663B4066E;
	Mon,  3 Nov 2025 17:50:08 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 13D3540E2C
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:50:04 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-295548467c7so20432815ad.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188603;
 x=1762793403; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oaXsRGIMlXFk/UA8FxtjJA7FY+5LM8CX3WmU2xgf6TY=;
 b=U9nglyoXvmf47b/BUmodMjuaEKUNp5UJO0rw/AQ9ECVx67ftM5Dc9tIiSWvDen0QT8
 QxOgYzq6eMS5kbs7wapG2z2nJj880Bbp6A7ZIbvpUp9O1s1uWH9BQYTXHhO5tg+wvnpW
 hKwn3WG/O3vSjpvTTIeVXanB+X0wNzr4tlVvBPm+Ma8CwflS7uO9J7KYjz9jlKvw79T/
 InS5ns/Jlkd5h0kzFIK1sPhZ//INH2I2tPx0d7HIq5qr7FBKjxfUu8RpqzZxc8zYoYVT
 VZx/t09TkE4JO1rmbzY1HusCOiQNN3hQCgjOuFs9wW1wthSufPl7r/YVkzN1RyiTCkez
 +LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188603; x=1762793403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oaXsRGIMlXFk/UA8FxtjJA7FY+5LM8CX3WmU2xgf6TY=;
 b=uVe78JAYpAEjwuAi9sYNP0G/SdYxuwy50BIxwDW82vtr3ChgM3v22oSm5IDcpcTyCm
 ZgXH9X21Z1nzds2F//ElucbUc+cwPoSloseyxxiW+JrWNkn8k+Zcnmetw6B/pSz54YoK
 3qBOe0hwQFN2wigKdJQKW8Rf5Xg+ONGSYfwxVUU6FGBKc5G9ByhBJHAbnlVWStNCIoNA
 +SsW1UzFxOc15K7OudOXTYDiSpeH01bacRpqd7WXto/eIMCocMqYBDse3m4PMvmPXXxl
 FwpVEwoZKByANHa9lhpzELzIqPlqNEHSfXAZe1CANfyzTm/ILUhVPDwDonc+rLIrTquu
 THkw==
X-Gm-Message-State: AOJu0Ywy20t9M/36gTZbcDhaZ5j3AwxyWY9HKG+iDT6KN0yqmW3dLpq3
 pM/LjDuR4mm4vVIDc9TftBf483Tt7YYH7HI7Bl73/XnrMDYyql3p66AYarvXuoH9aNPPOFCXbks
 OLQEA
X-Gm-Gg: ASbGncsS6jWgPDe9JdKZS2siqGex0JaW5m/ylAAYbiS/0MwdTaTO8cDKlrIqB2kgY3m
 s81cbsHolEKqjpnRr+FKobRQadS7I1JsgtZNKTNwSEt9JSGymTypNNmSxhwEf8o6YSFFx9Md289
 RF3tRlUIwUdONjhbgV9zaK+miCA7M3YAfeVin4rKopVWwvPQ06tXKa+c/3IgWNwrqmmhQ/clg9D
 Jd4an4fgHtGs1oSpkb39bieLBZAJZLrZPWfe3c8yCeFJ4o7VrRtxLIqrRHyv6Seetxt07H2Ze5p
 i545PJU0zqqITTHpCoDBDs7dtsRWqjHnGhmCb0lAPWGPuqnETFgkaUd3qWnXsgOlnzCBPHbn23A
 N7FjoGDE283TgJ4crUv0gmGxJsBZW68h3kO8IKcLliYwYH9TrtKXSRKl2CW0cDw0q9Xe97qU8mr
 J/JwjtMTGESlAd9dWBx8UPanucIg4qIX5nzg8kwxeTXe78U9GNKQ==
X-Google-Smtp-Source: AGHT+IEPAQ2wDQjLWGi9qCK0xCl2VafWmgI4/3qfMpEaPNrEDs41CzexmNxpB4prmhAVChlKN+kRSw==
X-Received: by 2002:a17:902:ce90:b0:295:5668:2f23 with SMTP id
 d9443c01a7336-29556683020mr101533415ad.50.1762188603090; 
 Mon, 03 Nov 2025 08:50:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:50:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jochen Behrens <jochen.behrens@broadcom.com>
Subject: [PATCH v3 34/44] net/vmxnet3: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:39 -0800
Message-ID: <20251103164915.101713-35-stephen@networkplumber.org>
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
 drivers/net/vmxnet3/vmxnet3_ethdev.c | 1 -
 drivers/net/vmxnet3/vmxnet3_rxtx.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index b0c19c5c7c..df200247e0 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2010-2015 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdalign.h>
 #include <stdio.h>
 #include <errno.h>
diff --git a/drivers/net/vmxnet3/vmxnet3_rxtx.c b/drivers/net/vmxnet3/vmxnet3_rxtx.c
index 552b8a9823..daddf0a0d4 100644
--- a/drivers/net/vmxnet3/vmxnet3_rxtx.c
+++ b/drivers/net/vmxnet3/vmxnet3_rxtx.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2010-2015 Intel Corporation
  */
 
-#include <sys/queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.51.0

