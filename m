Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC18C83F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 16:17:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44B1140658;
	Tue, 15 Jul 2025 18:17:09 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 496B640651
 for <dev@dpdk.org>; Tue, 15 Jul 2025 18:17:08 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-704cb8b1314so14595396d6.3
 for <dev@dpdk.org>; Tue, 15 Jul 2025 09:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752596227;
 x=1753201027; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nd5IbD1gfu3uxsi19HXLY82ZUVsISET2Jssfh5uVVjo=;
 b=S+KPLKHa7aMA8Np3fgEddfZlaT8jaU5b0aVIO/f8+nAZwjaHePLdEz2cYZNZuHKnKT
 Ys+eIyPmqpX9WUY+fKXElRC+Trox6k6dCySQlgrbIypLPMkTi5kybEX2BH52NxD2ko8G
 GLmGFeEPPHPqToBN1HU+0LPrNYhMTIVToEpL6jWMuPLxRzOyR5TJRsTzN2XyWCxKuB02
 edClb4t0BQL1W6aaM0D310OROafcBTObVU41aKyg1zcRabwsLDE12PiCNJLJSaxrY7+F
 KSYAE2qBEdrD0etT89sqRsPSaIjbGQ2J2ssL48zRVFia1p9DMbNIeKWIzyFjPc0EwsTX
 vtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752596227; x=1753201027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nd5IbD1gfu3uxsi19HXLY82ZUVsISET2Jssfh5uVVjo=;
 b=OgBKIVm/PxaN+6cdIhJUBm56+7LMfWX9wEQDQvU3ySM+L+fXL3exrhcOwWw/ZCZJyO
 EbcCy5X/gImktCx0RAirsqEZTmfp5Hqr4F8M3xaQjho2T9+xPM8F6pguYXbr1rEUuPjw
 KC8DEjYfQKH0dZccvwGrhL5iljZrIQ19KRqpudflfdnC/UldfcHiuBuZCvH+q+CvNFaq
 Oc+QinnmhzsO2gRoG7A8skoe7kmO8CEuAmocH4gcQI6BpxMk5pKStTMObgNpKGkJiZwH
 ck0pYnuvUipm6EofB2iIkLtT1dbYPKa9bk1wrrxzHbBXtddwuxMgAjE4ksYXAkgeHEAQ
 yJMA==
X-Gm-Message-State: AOJu0YyQQ/B5Qq4QVKWKI7DyP34VnJRFjzlYx1umVGLy+irLePD5qvy3
 wSqLshlXvQybnIYpilEHLWDYNYhGFvbupC4VsvxJhm6Er1TdUy7otvx6Ey9L4JxAjtlTUQUvcCp
 jliDt
X-Gm-Gg: ASbGnctOuLaKdBrjPh9hfj5m/dXtpRjgWmVJpoGjY6QcTL06IWg9Jhc+EXqVoKKDCIv
 oXWw2j8E4UCjx77/LzkJ5dr1RMIp7WCSRbiDryEoAVhJIgwp+p+olTUG8TyYSM7FNUGbFk98DMr
 MaT+0H8mMqnPuQuEkHhQMJ15n7TBU/WyArcSbK5Nquj4rOQsE44JHsoD0mjMsoBm5U3Zie6C91j
 PTpWTgzeeu5kTJkdb9O6RIQbB1/j3onBh0h1OrEQqDu/EJVxbJDf0qwjWNr9PgJ8nzLNyyYDmTi
 kjo2cXnbPHcu29p5IvH4Nj9IzhdNO1XA+lD/2P1dAzivGbjQC4sxmC+HfzgAWbGbv5AKVhwhITZ
 0BuD+ziIWNLNv+V4se/qM/QH/rKgwgUGUUHLTo68IEzzsQscLE2DL1BYZEKqUz27PMTO6kJFB
X-Google-Smtp-Source: AGHT+IGbzxb4TrQSS/HVOdQ7CjqHhu1ZbSy7ixmiY7q+5OgzxWI78k1Ot8rvifER6zCXQgwn6XDaKw==
X-Received: by 2002:a05:6214:2247:b0:702:d655:f4e9 with SMTP id
 6a1803df08f44-704f483ef46mr1384586d6.18.1752596227316; 
 Tue, 15 Jul 2025 09:17:07 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979a8857sm59985106d6.9.2025.07.15.09.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 09:17:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v4 02/13] ethdev: make sure all necessary headers included
Date: Tue, 15 Jul 2025 09:15:40 -0700
Message-ID: <20250715161700.103209-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250715161700.103209-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250715161700.103209-1-stephen@networkplumber.org>
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

Best not to depend on other EAL headers to include stuff.
Some of the later changes had build failures on some platforms.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_private.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index 184cf33f99..fffffe2625 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -3,9 +3,18 @@
  */
 
 #include <assert.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
 
 #include <eal_export.h>
 #include <rte_debug.h>
+#include <rte_eal.h>
+#include <rte_lcore.h>
+#include <rte_stdatomic.h>
 
 #include "rte_ethdev.h"
 #include "rte_ethdev_trace_fp.h"
-- 
2.47.2

