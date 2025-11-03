Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8018BCCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:51:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 106A640DCE;
	Mon,  3 Nov 2025 17:49:53 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 7ED3940B91
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:48 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-340299fe579so4788584a91.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188588;
 x=1762793388; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbOKcHWp91M3OjFln2QSTPnePlP9p8pGVPkhv43w26g=;
 b=wEzrlpVrAJl1k9PYZwHs8lOBwUc48pncfn86yBp3GV2EXtPI5Mlm0wT5WlU/F/9Fxk
 0EcYCI7Rfute7qaPB9vPrWhHzIceJKc0xZ/ESx3qz6fQ+gaQCE4TvdGgl9yKrfuq1qZj
 Raf8JxpEcFfXWDXt76LXsYQ1fEUWnO0Rx9tipLr4FrQjVM9x4U1qYEibtEjbHOCkdHw9
 rt4yWrr9LhizlJlVPxOHdGfy2nGoFWQakANkoVBUfbtUCiN0lyGOS7NRNqTvYNZ2PPxA
 T0ggD5NRizRZYIluMJp6TTk7omu8nV2rVEUZK6nu529ZIbW0NzlgyzOx5fwPurZUeF/7
 t4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188588; x=1762793388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VbOKcHWp91M3OjFln2QSTPnePlP9p8pGVPkhv43w26g=;
 b=KN1ztiyAKZo9JSKVlnNv09Ep+cxipMdSD7+wVFkU1Ib/cP33N3Uu0EZjYqY2dWEJA+
 kI/e4HmHUQsB+OTxm1edeXqW5u6Y+JqSLP/eBAEEVZcR0a1vLERTzcBhT5bN8egv3fym
 OouZxTH/IG6yr9Zy4EqSUuOtw7UPCZZ46XXmTByhPdTebl4oQyZXwizNu6XFMbE/4NnX
 fT1FFzGYJ91CZmUxDGGxcKwRF3zETBzwQp15R0oeKR993Xr41UJV4W5yWrNGfU0dZr/i
 bN90QOgs71cnud92FMn++AnxKWzFdm0AMsx3sHIAtBjt8lcHNRsKFyidIcmyY8375jPy
 u6dg==
X-Gm-Message-State: AOJu0YxSiE04142CX7Y2Uv7OhyK/2MwrLOxEk/jz12SY88JH/50mIqRZ
 64USmcMtJnAV2BzSoK/EdZfAptSGisuLEYbQxgJ1YfC7FalzchRnh2G45SuYfDPZsyToZLgA6cw
 Kfo0A
X-Gm-Gg: ASbGncuuNB1uSQJcCY0XGVEFIgGn+6yF6LjBVZFKRB9NpyJTYWZcpkT4pSlaElVovke
 Wq5b64XuKQut+/yNgserQA23tl4iyHfy0gIM4F369lWlgNtPA//V7nWjceFv4JJGxAd5ar/qXzf
 8sFQyTfRhS0P9w5jRf+552B9+rdobpMSnadQ1moW0pVqCTPfAZZaZpomA5eW1c+9xZirsPgn+6B
 J13Sps51A1513mp+ZffOc7wgJGnrrC7ro2S3aXXZZ3Itbn3v89k5vRfqtAF2vaXmGw7U1lc6Nh1
 sC1aDTlfem+vg0R0Q9Svhz4HHVOlws6G6fJSi3VrUazctOxBBaA+WDX/NKfat8PfqmPtBuRfu9L
 oic/3rqV0iz7Lis7raAtAmGo+Bjh9CaVx8ISyhU9tYVlCyt9xQ+MlT3sOqPkwhJMdlM/fS3cYa5
 FEWsSARD31/ha46mhhzYjKQIrYuylj00U393T1pLlLcazojp5HIQ==
X-Google-Smtp-Source: AGHT+IHOgwaqbpA/ZaVaxXJgw8Pm8TqE2bwBqZIYpPwoB2MJ+HO5Uio7SnnYtgDDw00QwTzALoARcQ==
X-Received: by 2002:a17:90b:388d:b0:32e:d599:1f66 with SMTP id
 98e67ed59e1d1-34083089300mr16200210a91.30.1762188587548; 
 Mon, 03 Nov 2025 08:49:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Selwin Sebastian <selwin.sebastian@amd.com>
Subject: [PATCH v3 20/44] net/axgbe: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:25 -0800
Message-ID: <20251103164915.101713-21-stephen@networkplumber.org>
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
 drivers/net/axgbe/axgbe_common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/axgbe/axgbe_common.h b/drivers/net/axgbe/axgbe_common.h
index 93e6c177b6..e882842e39 100644
--- a/drivers/net/axgbe/axgbe_common.h
+++ b/drivers/net/axgbe/axgbe_common.h
@@ -10,7 +10,6 @@
 
 #include <stdbool.h>
 #include <limits.h>
-#include <sys/queue.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.51.0

