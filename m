Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB9ACA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:35:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C54140C35;
	Tue, 19 Aug 2025 01:33:49 +0200 (CEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 490CD40658
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:46 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3b9d41c1964so3195996f8f.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560026;
 x=1756164826; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAOWm3PjowMSvBqyMP8SpnFUiVY+b4TjoTd23X3UJpk=;
 b=afrslH/TkcxRFXqhzN1F12n+1qsooDCMI49mHImA1nQx9hHE1U2RFou9gta+2OOgwh
 FsRsGX6Sm/fAlIDl9VHKNrlFutoyDGvBwQB3gXPF1vmO5hvXyNSeEIzsH5IXS3aDQMjn
 W7++bHaECfKhm+JH7MCw/NNbjkxBRZIc399nmZRJZrLOkQ3Lbjr+rgo8UNDsU4HLbCc8
 YMpk2wHUyNJBMYAfzMvDRKrbNdKblMMNtQEkdvDxJFlia9qWwr8JvboswqNgDd36yj+V
 +nqcaNyD3AOBUf8pMZtl1+wYGkGtwlN0HPzvlL+0P9FwTeTkBeoXOX3X9kAE1m7twgkJ
 47yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560026; x=1756164826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAOWm3PjowMSvBqyMP8SpnFUiVY+b4TjoTd23X3UJpk=;
 b=vqqmpprH1k0F23EbkxssrnM/s8eGZxugGEXcWaEr1TkT0gJha8idEcHfaa3rqbMhn5
 PWnnv77cNWSAk1DsrbeOYEFwtptu3di48gSmvo5WgKA4GUmbHmTqGyRN5Q5YzwIcHcgx
 AZVAKMzlH5T0zkgLmVOZCw4d+PhI+chQzGzRlKzPrNu6+fPHIwAvB/ql9sslMCfi34RZ
 j4sPYiH1uAmOsA2GlgBlKX6H4ZNYotkOBOlS74iSi3GpzPrujc8ivyVPqkw/8F4Xk9L0
 6u6zgYUVDrLaHtKCNqVcvMvk5L6zC0rgfERKAI3Pt/tiD0sC4hKYntNB888WwyRDahUg
 vaDw==
X-Gm-Message-State: AOJu0YzgWSJD3Ph3k+yeD9k89J1qvYKkMa824DboiaaAUpPht8XuEiLf
 swlwz1+HkuY830KGWUfEvJc7FR0PiSipTVFaSpmkuRbjmE6MH+uUbeT2JS3XBUlv+J7TfF3vzTt
 QOeK0
X-Gm-Gg: ASbGnctA31ftqK4fyJn3zp5YeIMEtlNwqgXbnBY/yM2Qv46ofDDzKYmZorkZ+UJJ5Y2
 c0RuWXzC19K4RcJvOQCy9z8noLJoMDYu1MXHQCIz7IVnWWR816IrbYgE+QsFkQ44+wJfF6WYSmq
 CrHzXaZHG4ZBvwwdZerVXCjt4fsNJfgAIx8erSuXwPdQ8GKXDdyM4uQYZW3qcsqTKDTmbgmT7ux
 fjCjTIbGOQ0c314knpuPwLyw5qcEZE+D8UNdXRXJmknrWQ0bjdlRIvlvAF2KhNSXt0ZidkgFyg2
 z8tbhfqNCLh7ufAB/0QDTRDqLX4YO9W81PA1xAYMpr3nJGlSXqjc0Kfrl8NWXnqNP4u3DZLuqWT
 vzH9scEOhyr6JwzDxwPdHYys6bqrfv/iEstRQ4rFriD7iGBrV8pyIC64udQBJL9/iKwuaX83/
X-Google-Smtp-Source: AGHT+IEh8p3pLIQVQnDCWdDWOweuNU4ClxosNp/2aocCSoCCskH546Wc6aBar3RfROyNCd3uP81tYw==
X-Received: by 2002:a05:6000:144a:b0:3b8:fb9d:249d with SMTP id
 ffacd0b85a97d-3c0eac6dcd8mr291732f8f.21.1755560026059; 
 Mon, 18 Aug 2025 16:33:46 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 26/47] net/tap: remove unnecessary include of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:37 -0700
Message-ID: <20250818233102.180207-27-stephen@networkplumber.org>
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

The macros in sys/queue.h are not used here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.h | 1 -
 drivers/net/tap/tap_flow.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index ce4322ad04..055a9e9b23 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -6,7 +6,6 @@
 #ifndef _RTE_ETH_TAP_H_
 #define _RTE_ETH_TAP_H_
 
-#include <sys/queue.h>
 #include <sys/uio.h>
 #include <inttypes.h>
 #include <net/if.h>
diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index 373b773e2d..99e0bcf218 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -6,7 +6,6 @@
 #include <errno.h>
 #include <string.h>
 #include <unistd.h>
-#include <sys/queue.h>
 #include <sys/resource.h>
 
 #include <rte_byteorder.h>
-- 
2.47.2

