Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E52C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C10F540E54;
	Fri, 21 Aug 2026 21:30:41 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 811E740E64
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:30:40 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so1010455b3a.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340640;
 x=1787945440; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O0k1EK/r95sW1obABSomt9qjWIbHe/nJuvOEtDtntrA=;
 b=S5ivgbynd8Uojs0AHlXJnKV+IvTfo+XOGHYnMzQETHG1bcv2bfZbljOjy62FuzdBvw
 s9ZsAFGEeHfxex9iYRVoWbDAVxHSihX+FMK+hht4k07oVbvwbPMvyg+83xV04N8Zed0K
 mwKmloDzciMmOxtpkWYt3MkB0jY4kWgk4uMGdhaLFrI0WxZNBZG3hj6Qcfo9J25nmbK3
 nnkg8co/ZJDyGYFVD4saKURMwWRHLUk60SiNxgoS9iqxKi39glzvDJRrUh7aIMbCblj1
 zQhTP2xJNjt7PjCo9bN6OvVVFhlnEkspx+ty5afnDZNIin//AdTI1lFkd6HJh/tWrtc0
 mvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340640; x=1787945440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O0k1EK/r95sW1obABSomt9qjWIbHe/nJuvOEtDtntrA=;
 b=aLD6UwEdqX2n5ZI1rMh6X6KkMthEoXkEuCURkzaSCAxnMS4xmaJQH/UKXePAi6C/8S
 7kIiBOS8zjei6gRZj68R5l6rmYJ63C37P8goDVvluGdm3szEwXduquF68AxKsqpjFVPK
 qmvE1x6ztEUs/1Nkq9y4howK38G7rdtxo9KZIjugqF/pwAkYD701P53xdNfb1BZSwsPG
 chVYeVDf8799WzgsuKoBJW4a0+RoPnrdkX3fIrtlAUjSN25Q2cCGE7Xzrb7nxsgAAS+t
 Is2w/lvEQBl4IHFmoEUJNSDl0MMMcnvXmtDUJbsYxe/ihd8dZJzgWbWXcqmWSQlO1ldt
 jMqA==
X-Gm-Message-State: AFuF++nCyhhE2Ca3P6YtSg8MIPxZstn9a9StVTKCTyJOZp/lkbJR+IdE
 T4+cWJkpEjLoiQBBfx9Wsvls1d+5gI0kMi+l0YxgQ/cVZgXt6lZxFdajJG50UO2eujN4Qmz3GMD
 YGE8Ni+g=
X-Gm-Gg: AR+sD11beKMFtBJXfg668eWvOQ8i/uwWWdpJ6OnqfSqWH+ZKIetUQavdXLcwR3hij54
 oJ3AfSItHBYu0WXk9L+IXafc1LCzHs5AKFw36ciPIzG1JNJBnViEw8GMC0Dm8hsHu/rAuTwgf2W
 6QIGkUJ1HzRxNA4SLkfUEDv2iBubWsbFyXi5I9MxysiPJmr9wjPHp6SJYDEZl1hLF76UQ9CSfdQ
 TJa+SMARe9vgpuahbN5EoBT/+dSeSbUU8SsITlXMSg0w6t7qR3ntk3Fs5CX6kwdFnLjZ0e2jBem
 7DRn8PWZ1VJ/J0j1vh5n8aXIq4cJOsZ5HwyCK2odGCluW4IqNGJ77AEixLsuPkcJezPeyXkxtJr
 wY5FPSihZO0XcfvR0PcYeZCMeloC1aUYGWGL5mzRsYR76mTKmKaatzhFX9V2qBe2mImKk4Dn4T4
 MgA6mnf9H7P9nv0XgfSTFGJ8EoCXSzLXlXYnx2EbDOnHEiiGG4UfL6r+HkLW25Z7TANTjYQSkN8
 J9dhAZb0GTWkWTbJUoy5804E/0=
X-Received: by 2002:a05:6a21:3418:b0:3c2:dcdd:a85a with SMTP id
 adf61e73a8af0-3cd300bdca3mr18313566637.13.1787340639678; 
 Fri, 21 Aug 2026 12:30:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 46/68] net/ring: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:41 -0700
Message-ID: <20260821192646.146382-47-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ring/rte_eth_ring.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index b639544eab..60d41d8c06 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -9,7 +9,6 @@
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_os_shim.h>
 #include <rte_string_fns.h>
 #include <bus_vdev_driver.h>
-- 
2.53.0

