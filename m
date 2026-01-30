Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACA5E6BF10
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 20:23:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 818224060C;
	Fri, 30 Jan 2026 21:23:36 +0100 (CET)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67]) by mails.dpdk.org (Postfix) with ESMTP id 700D1402E0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 21:23:34 +0100 (CET)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-480142406b3so19127375e9.1
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769804614;
 x=1770409414; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruI3t6YflyASiwFxzpzXXOMKdvUphBuZjBQv2KMeRLw=;
 b=prvBedm6h4b6Zfjl8KmLU/7/fdwU6y30cvvllRidH7QIMSfrE8YR2RY/Tz+9EaYvXI
 pGcklmzIQkD1Rs8jYPOotJXzrYWo5bOZ9EKtbsvfhTc+Q780+7Dr1qc9UrAW47un781E
 Clyq2/A53PCRQp3kOA0Er3B+iJ1HcKRMZNVU9UbsXxXyMR78gKMYsVXjkleyGjwDAj1g
 n98UNdzodEAx3x+RpZ+/fwyboPaMMECoIIKYXGHtQbvtKPj4JZad0z8eKfRnA9SPTG5X
 MXbSInwm1d9P7u3qaUQve7yXC4bv/jvEzHZfxFJDnEBSCMNsd/URKxWOn/UIWLRoeJTV
 RrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769804614; x=1770409414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ruI3t6YflyASiwFxzpzXXOMKdvUphBuZjBQv2KMeRLw=;
 b=Ty3Ehnm6/Bpc89cHacSJnAS3xPo2b4DGkARN6CMIbVChsIPABF53sE983H4SeAJlrj
 1KLxvL3ersKtn/VGHReJuKdC5mHiigLeVZ+a3sFfeIuN6KIg20UwZQtPuT3BIrFrA1Gl
 Hf4GBCaR2oZK/s7lAg774aL1m/4e0Ahcqc/wc8Ik+ITXneOhpkf5d47T8ajqpnD8h+Ll
 Dr/KBGyHtuUvs50OcSq3XO2qVz7P9dURDrvhaUEjYNz1UI+q/CwMWw+6xzLjXKea+qon
 bGa+mU6P9LCfnKGpKV2XY4BwgjW+aZ75lcXwAi7bP3e5b7VvrAQwQjNvLKvC7QPw4PGE
 6GWA==
X-Gm-Message-State: AOJu0YwMl572Gng0vLU4mhytZP5wZ2ygUk1UZuWTrfSftDcO+4yM3pZY
 yrDgcJIzvx7nNZhvx9ivfE5m9v0wYEdlxJx+lxTLESK97QHGIi/F+cSopLS32DXACrVJ6Dwrlhi
 L2Rw7y5I=
X-Gm-Gg: AZuq6aJtCD5SsdzdUvQfE3up+KT+z2kNxN2jAyQpdDA5zRA2Tsj5S9iMxRXjkE8Iuog
 aT0txvXASPcjO2CJFDpVP8ykiFekVPKREO5+14NvoCc0gOhxplyg7OSXc2d9aJzO8GATpOEvR6u
 yTsA2aaoOnpIv1TEDCQBHG65spt6jMeKatkE1GArWnZSt7YGntKAIsWgfbnq4JpTIg1qQ1/K+/0
 vBrTJFYcEs/8kFd7OQhfT2Kx7j0oCInV0vF9hDF1NCjYIvh35+cmlFLo2CqHNmPdjs9NSHwxSBC
 AwbediTTzmVNI7cfW/U7v8L0R4WbznIr0Rx4lWjWh9FJcJwIrwQ3B4lXU+N7fNmy1HQXq55kOEw
 XHQ7Tye4M6wowxs1Rrrk0ZYxJqOEzxjdxsEWdbc3MqIjMUkhZYGtMuTVJiwHHmTaiMztT3mPG2u
 fFL8hOsTy/Z8jIaPv/a7A3+5AHPeLzVJ1kugrRRCTtXSVoCZ3hvw==
X-Received: by 2002:a05:600c:34c1:b0:47e:e2ec:9947 with SMTP id
 5b1f17b1804b1-482db491eecmr53756005e9.33.1769804614008; 
 Fri, 30 Jan 2026 12:23:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e04c13a2sm23799065e9.5.2026.01.30.12.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 12:23:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v5 2/7] hash: use static_assert
Date: Fri, 30 Jan 2026 12:21:52 -0800
Message-ID: <20260130202324.37485-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130202324.37485-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20260130202324.37485-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Now that static_assert is available, better than pre-processor
use of #if condition.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/hash/rte_cuckoo_hash.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/hash/rte_cuckoo_hash.h b/lib/hash/rte_cuckoo_hash.h
index 5b3c51348e..919140ac1c 100644
--- a/lib/hash/rte_cuckoo_hash.h
+++ b/lib/hash/rte_cuckoo_hash.h
@@ -24,9 +24,8 @@
  */
 #define RTE_HASH_BUCKET_ENTRIES		8
 
-#if !RTE_IS_POWER_OF_2(RTE_HASH_BUCKET_ENTRIES)
-#error RTE_HASH_BUCKET_ENTRIES must be a power of 2
-#endif
+static_assert(RTE_IS_POWER_OF_2(RTE_HASH_BUCKET_ENTRIES),
+	      "RTE_HASH_BUCKET_ENTRIES must be a power of 2");
 
 #define NULL_SIGNATURE			0
 
-- 
2.51.0

