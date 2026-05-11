Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC28CCD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 07:57:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFEE240B90;
	Tue, 12 May 2026 09:56:07 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id E330F40278
 for <dev@dpdk.org>; Tue, 12 May 2026 01:33:55 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2b788a98557so36256365ad.2
 for <dev@dpdk.org>; Mon, 11 May 2026 16:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778542435; x=1779147235; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aXZcaNZFpaszow8M0Dh3K9NjWlVtnMe7Mg660+zY4o4=;
 b=sA07YtCuAqvXmHCnWJgdeoRd4GaRqlbHa2pXIs2pFbubuKmUw77MVYQtHrxtRxvcYk
 p8Vj9+6nDj7G0MzE4ZOhaRBWjP36qIba+wklMegJq5ur+gtwSjbbelsUQvyyYGBFK8hi
 pWkSvJ4TLFqKlMckGbZ8xs89yd87Ts4xBzxKyT2Qg5jCkbmPJHFmhNwSgCLaIA44qWN4
 gAxX/Sx21xzSq4BF0kd7s/nSARw/G088Vckdx14/iHZHo/B97mrUsWUCw65ExZjPw7lm
 qdDhCX3B71A1wzZIj6OLEoDYCf9iVBb1NQdObMVLNMevA35QXb/sM7uyy2vutcdiHk+Q
 xryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778542435; x=1779147235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXZcaNZFpaszow8M0Dh3K9NjWlVtnMe7Mg660+zY4o4=;
 b=ccuDpnfPHN18oomVMxzG/kF5NkyceCdgYQvC1WdzPWzNdXcy69/nF2dhzVLMxNcN13
 xHrVuuVL6EMm3adW9CKW3apO7fYAKK83+RwXmAbdkzAij24DY3Fegr6BuAZWK9XDP47t
 RhXsDOKyEXEVZs5+w7D5nKGuXGicFfjW2b4QuVLKXrTSO53w2J4Eb0QohiLc+g9s7LBv
 CnEFXT15/HMmoLmbmVyjUNMFQeWPww/9lATFMcrzRESmzXq1yXwoZWcHEUx392MnVESf
 ytvAlrLP9PJJEznLLyV5pxl/tz4bB7hCsBI+jKhyLg3cWZXEbC/ZGlhQ39lXIZYk0KeS
 0Rqw==
X-Gm-Message-State: AOJu0Yzi/M/Gz9+7mpbLvN27g6qSsoH6RvhzI6pypAVsU3ZEkBN6k0RF
 nyeUqAL/fyYm/hJit2/Gu4o++TFuepPg0xPMbfhrvmi7icUrFotKlAy5DSnVsw==
X-Gm-Gg: Acq92OEtjywtV8Mh2D7Di/W15Xf6WeqVSO+s1Zw+u06eCkeKELM09RY4Tx9T2xcDfJX
 awUvzUBqH3H7ulFAlXR3TOSSXqvuqGMy+2huKIYVHTrDYkj/uiSiC4bBDC5TeOzT6m4w4ewOpWJ
 O5bfw7URoI2N/nmWsxPNNOZsMwLF7dWm6c764zBA/xCc37qHq4K6zlW0R82441LKdnYiolEC9DU
 L0FojlwpJXZ2DpdXZG6T2Ycacf2I1Lwkn3R84Lg1T3bijTe2grRF19RzwXFHWJah0/4j2xsW6MJ
 MOl3EujEWOCwtORQ8ECVIA+gFj0UMu4QsvYlkAnk2jKUgtXGxDlj+JX2CBf3STsShJNAaCuxuGK
 Gw3tf+07lucOHorH07prfFL8UO01b7H8XX7rLKR3L6rsc8rTOzWSUG9c9nIUdoMuqeQAI6pL/xj
 fbpomIxfYH6p0qLjW5RpUjKIRfDSS3ajLSFOP01mcApRzLIzmiWaAkRuzZDyTROoiS8Jun/Bml8
 lQ7BOxkTizPIw==
X-Received: by 2002:a17:903:390f:b0:2b7:88d8:efee with SMTP id
 d9443c01a7336-2baf0e045c2mr178271995ad.28.1778542434627; 
 Mon, 11 May 2026 16:33:54 -0700 (PDT)
Received: from arin-Desktop.dhcp4.washington.edu ([205.175.106.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e35632sm121020255ad.53.2026.05.11.16.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 16:33:54 -0700 (PDT)
From: Arin Kharkar <arinkharkar@gmail.com>
To: dev@dpdk.org
Cc: Arin Kharkar <arinkharkar@gmail.com>
Subject: [PATCH] Fixed outdated documentation on the hello world doc,
 which incorrectly stated an easier way to launch the lcore_hello
 function. The example program uses the simpler version and the documentation
 stating it as an "equivalent and simpler" alternative is moot. It is now the
 default.
Date: Mon, 11 May 2026 16:33:50 -0700
Message-ID: <20260511233350.79402-1-arinkharkar@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 May 2026 09:55:49 +0200
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

Signed-off-by: Arin Kharkar <arinkharkar@gmail.com>
---
 doc/guides/sample_app_ug/hello_world.rst | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/doc/guides/sample_app_ug/hello_world.rst b/doc/guides/sample_app_ug/hello_world.rst
index 5bfd4b3fda..b7167aa345 100644
--- a/doc/guides/sample_app_ug/hello_world.rst
+++ b/doc/guides/sample_app_ug/hello_world.rst
@@ -70,12 +70,4 @@ The code that launches the function on each lcore is as follows:
     :end-before: >8 End of launching the function on each lcore.
     :dedent: 1
 
-The following code is equivalent and simpler:
-
-.. literalinclude:: ../../../examples/helloworld/main.c
-    :language: c
-    :start-after: Simpler equivalent. 8<
-    :end-before: >8 End of simpler equivalent.
-    :dedent: 2
-
 Refer to the *DPDK API Reference* for detailed information on the rte_eal_mp_remote_launch() function.
-- 
2.43.0

