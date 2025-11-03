Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C191BCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:52:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AF2340E26;
	Mon,  3 Nov 2025 17:50:03 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 21D3740E0A
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:58 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-29524abfba3so31930495ad.1
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188597;
 x=1762793397; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlFmfPvWAreXLnrebV0RJK4QH1QsRkJs0XQrelnk53c=;
 b=ytTYLzRHJqf/p2Mu1lZmyANYss0ugTlMJl8qhNbt6l+vODBy8kUslLgzNugY1aNCW5
 un4RyDJO+YYHbIabzvogdeP0KSF4dmMsFg8ADxjQgcUURU8mIo9omdYNkxJhpip6VbO5
 pOtiH+a5acOHoUb+NDMXh0v3KA4x8+VTzZI23hm1lCS0Kvb5F0K29l0/M5zT2j/ydtgY
 l5dG7iygJtjzzv3YcZ+fn4omL9mydvovO/2GQ/x8at1hqqWRHbixh56776J0W1KMSrP5
 fMb9JHWa9cCtWTSxtVeY5eImMnK5o5MkZ+cETWSvBrkgYWY958MOdza8gG/liQjPjmFT
 kpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188597; x=1762793397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlFmfPvWAreXLnrebV0RJK4QH1QsRkJs0XQrelnk53c=;
 b=kXDI3czKN4vNFPaA+GG+ELtgBtFvKqozCqke3a9IrsZBsc77VmytIWNZ//9oNjjVtp
 2Xfeu84Hh6IlPW55SNxZmr/nEC94Lre72VfpaiDe/cfSbeRNnSdKoaajrQAwEreS1itw
 KLG4Z+J0VaEMq0LlEdWC/gx+wjVyh3sLsYWeg7bEAPIN0p7Mkzu3XZ1R65QW/OefcJe2
 E31SCiGD8eKIJnYZAxWQm11yd9nnwkBfEv3T6wSNdx0jcMNzAgF0KQeK4tR9diHTg7pV
 tSwIRALm4MIgN/fGfST8WMpN6rgYd72kZMY1piaZPR6Sc4fMwoU71MSTKyxRTQymuA6G
 O4LQ==
X-Gm-Message-State: AOJu0Yw1+lRmAh9f3CL8p5twHNSmb5SaaDfs93oXk/Po8yrIMRoTeZT/
 ujmvV7oZatNJoGEQwRXBtOms5ygGHAmbezq3HOQvOl0hrNrxPH28mwoEGQ3AW+6fR6qNri2G7Bb
 rVhPs
X-Gm-Gg: ASbGncu7CA58xWZCmpMAxZeTE2xWmTHQO2PcRnsDRnRIcWv6t6+iOAKjPyZDHVcHVjx
 mx3iN/6kRShHptdHhnl+ypC26ZAtpu8PPtaDSPTIcsDp+KRJi3nXAXZLaOZIRvwVsvkdxrSLFKJ
 bKujsrKOhITFc/CTix7Wq5HHQIn6A/SVfDyc+PusTF5OBeBlj7S4urQN7V+KPvDsHASl7TgjF8m
 A6YxUgtLmGJDhzEBiWBRHuEeq4MvGh7sEq9ENCZ6QgwF0N8EoA7i2uCqH5d3ltkxM2wHSLoDKg4
 FdY0Y7p2Bml0im5S7pRP+RQ09G3m7j/XARI7LBzpUr8CKWIrnjLUhaC106DpA9k4ydX2+7ryvaN
 dQb59lLeBVuNlx3iKumf5eXu7TihW4mRsRN8JI0ydeFnCgasAhNzGPiVVxTQLRkWZaxWDJDeTBz
 +Ygu5VWxL7XHbHz3iMXnaVuDZYGZSWikJhxwBmWTo=
X-Google-Smtp-Source: AGHT+IFG6+wY4O2sdMKxH6brlOboXTJlan4DaH6Wf/FY9uWzduumCOqIeA/5n21fvve9sQhHhFD8kA==
X-Received: by 2002:a17:903:41c7:b0:290:c317:a34e with SMTP id
 d9443c01a7336-2951a3f3a49mr174422575ad.25.1762188597239; 
 Mon, 03 Nov 2025 08:49:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 29/44] net/sfc: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:34 -0800
Message-ID: <20251103164915.101713-30-stephen@networkplumber.org>
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
 drivers/net/sfc/sfc_dp.c | 2 +-
 drivers/net/sfc/sfc_dp.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/sfc/sfc_dp.c b/drivers/net/sfc/sfc_dp.c
index 7e2a20e4dc..66ff2ed789 100644
--- a/drivers/net/sfc/sfc_dp.c
+++ b/drivers/net/sfc/sfc_dp.c
@@ -7,7 +7,7 @@
  * for Solarflare) and Solarflare Communications, Inc.
  */
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdalign.h>
 #include <string.h>
 #include <errno.h>
diff --git a/drivers/net/sfc/sfc_dp.h b/drivers/net/sfc/sfc_dp.h
index 545f0f32bf..6f61b20a0f 100644
--- a/drivers/net/sfc/sfc_dp.h
+++ b/drivers/net/sfc/sfc_dp.h
@@ -11,7 +11,6 @@
 #define _SFC_DP_H
 
 #include <stdbool.h>
-#include <sys/queue.h>
 
 #include <rte_pci.h>
 
-- 
2.51.0

