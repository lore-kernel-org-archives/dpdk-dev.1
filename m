Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F36DFD45FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 22:59:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 638B44064F;
	Wed, 25 Feb 2026 23:59:24 +0100 (CET)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 3080040608
 for <dev@dpdk.org>; Wed, 25 Feb 2026 23:59:22 +0100 (CET)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2bdbd13ca01so337365eec.0
 for <dev@dpdk.org>; Wed, 25 Feb 2026 14:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772060361;
 x=1772665161; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XpAImIqdiKI3ORDfVNUbCgEJX96HHNq/Se4eWcZHQmo=;
 b=TuYt7VpekAGvyEx5NTuJEQ1VlWxOAbvpQ3ilQImF0CXWDW0QiIOTGEV6zjdoLCTUhd
 QSSD2i4ZFjcEJuZZIryjc38iKq8Oof/N8ziK9E6ii4T+4sMha4wbWIc+H6tu33Ci5WCM
 YCYCYKbCfjQpjKTivLOoHOKbGeG3U29iyhVbFBFRSlFKGtZMLrMhUyISYk8I5OelSLYD
 r/0pyIWUTOSym84bGTWyyS1hB9hXW1LBXWsv+GbhacGxP5AZtIrT309YtuJ0Hz98Itv6
 IQrJ76Jk9VGUQLKGnBRPxt/qo/boGF56DWvw3dT6kJRFm3U8JWF/FdeCNx+2ix4c+Hry
 NL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772060361; x=1772665161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XpAImIqdiKI3ORDfVNUbCgEJX96HHNq/Se4eWcZHQmo=;
 b=jm4hYyOi87gUfp5hTN6znIavf5X4h5NlzcK6QBTXqh0xFnUaH1+Q77iRwZLqPt3Als
 QYykzkVAa7IX0a9SvlHZ/y4k6+KjxHazJU6dK0PF27+tnMOQ1P9bG1XpXyLfnqS9TOma
 8QpHixXEXAa2DULaZA1fYOvWt8ROYEWAUrijggoxMkIq6mHVfpMlXQgrSesDot6i6yH0
 amAWvjM/h5ADGwUOXzJ6k2uGdZy9tRT7gk/ZobXBURIuVQ/kt3Tkg6lj32NBGfQR7Ubc
 5EY0g80ZoF81DlzVD3scMUYy8GlZ25S+8RBhgVNtMH6TuAMCRy3PGceviBkQeNSn00TU
 vcow==
X-Gm-Message-State: AOJu0YwHAG1BttrzlX+xBMdvyl8N3UWgzatIb0E+I91YjDOg4b26ID7g
 6Yf/61L78lX6dOVdNBt+nE2zZYN+3bNcr6k7lqCIHMYc9T77f4ceJ7P4bm1kcKQt6b9qv7cQAAW
 0ODyqlU8=
X-Gm-Gg: ATEYQzxj120n4I5LJDvGOGSdNl+wu/aHHukPMAcFLMkIbH3GPFrNyT5S3QOMTLacWUN
 eZ2hldCkl6+o7B9bxCQReZ8+tUQPp+Ok00ExGFEItjTng9e6TZZvuRvXxMZuRrt9U1LAiCwWg0o
 Z6ffAPuOojdxoT5RLSFKC/2ZuJ9dQgVt9sV65XiFSrtLF0JA1F4zfuKgQVzrG3lOgS2xM9JRBm5
 auHs4/vwle+ecVy4rjknNZdU09EXieisG/JJJaC8Mo066aX4T0eJTHOx0t4ye8nG1hqGSHD3qtC
 atMfHfp2AigooR30pUWVHzw+SsyltEbW8ieSC7q9Ovx03ptOdWrf22Z7jCCV5NO55JzolCI1vhl
 eEs2qTEyOPRmikBk+QHxHkJm7i4siymzLBbvsAeFvai0koHUOeRJM2nKbyCjFJkRvC/xDinaglv
 d5jkZrfxGaMCnfMl/hpAdKgG33T8V0a9DCe6O6MAjhlFsuyHMlJm10cZBduHHvLBTSS76zrKkZ
X-Received: by 2002:a05:7300:5728:b0:2b7:97a:75fb with SMTP id
 5a478bee46e88-2bdcbf7c1f2mr1081962eec.11.1772060361223; 
 Wed, 25 Feb 2026 14:59:21 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f23c47sm411104eec.19.2026.02.25.14.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:59:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v3 3/4] pcapng: handle packets copied before file open
Date: Wed, 25 Feb 2026 14:57:18 -0800
Message-ID: <20260225225916.518790-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225225916.518790-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260225225916.518790-1-stephen@networkplumber.org>
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

Either through misuse of the API, or races it might happen
that rte_pcapng_copy() is called before rte_pcapng_fdopen().

Simplest solution to handle this is to modify the logic for
TSC to nanosecond epoch conversion to handle the case where
the difference is negative.

Bugzilla ID: 1291
Fixes: 166591931b72 ("pcapng: modify timestamp calculation")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index b93af418aa..b5d1026891 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -157,11 +157,15 @@ tsc_to_ns_epoch(const struct tsc_clock *clk, uint64_t tsc)
 {
 	uint64_t delta, ns;
 
+	if (unlikely(tsc < clk->tsc_base)) {
+		delta = clk->tsc_base - tsc;
+		ns = (delta >> clk->shift) * NSEC_PER_SEC;
+		return clk->ns_base - rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
+	}
+
 	delta = tsc - clk->tsc_base;
 	ns = (delta >> clk->shift) * NSEC_PER_SEC;
-	ns = rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
-
-	return clk->ns_base + ns;
+	return clk->ns_base + rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
 }
 
 /* length of option including padding */
-- 
2.51.0

