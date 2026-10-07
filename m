Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91DCCA6004
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:41:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAD6541144;
	Wed,  7 Oct 2026 23:41:21 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 809BD40268
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:20 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d71d1cc8b2so13372625ad.1
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409279;
 x=1792014079; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7OQ89L/AgkEcY5CcYBN171eTiwEvMsE1N6BjSUIAuRA=;
 b=sb7FTlQmb9jq3xTZCYDWo4IhxKctOZNvJhLQpY+/Z4H7JjzvYLJaQ/yQ3Tr6UMrZtz
 Ro423/S0Tl+oqWSa+cpOInjerTGe3zyGO2ED8xELLkOikDzT22wGgRRGdfYFY38k7asm
 FK00Sqsv/BPZR4f6vY1XyhO/L/5BH3u5aT1feJV4Ihp0KdtDDVJissa0i0rcuYhPMLcs
 8kg5YjL80juUr6EjAoO74XZAf7ldHmB03Qtf98y7NuSHEPt6vNHWt/PrpwPFJ/nLaBBa
 8PjLeyEH9rh9O+HKBy8g8FfV3I4YhbkpKf0xw1b3iGs0p+99E9w5WDJaFbkmi7AhflsU
 tfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409279; x=1792014079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7OQ89L/AgkEcY5CcYBN171eTiwEvMsE1N6BjSUIAuRA=;
 b=uOK1lDNuZQsEXmh7sqa6SH/8dyE2qoDu0fYeoSUi4GZ8P8Yt8wPkvd6kF3hYh492ef
 gdf9dD77BrmiDWm7h/fXtzp9RXY+zaWvgNA3zME76s/OrLiB3NK6azN+3xomSehNJVQF
 iVKjaZ1bDCkCXGVEMO40VAkJuaMV45KT4YC+PuR/h+ZaA6zywM0SkZNAE9z0qeKCKoDx
 FKr5Ot+F0t6jAJAJ1PGmh9Nu2oiJBQb0FU7vPMQaXX/iE8T1a8LYVHB6ebg7mQ11FpCt
 sMAq9HidbydK3Ba5EByDEyYUFYRkJALh2xKGYEBwkC0LB1cBa2ov+nv7PecOMWPMP/Ol
 E86Q==
X-Gm-Message-State: AFq9FYKMkzbmHer3/U3K2czNPp0uaZfHLbufHqSf703KqMOMrP2u50t4
 pjlHvcftC5RAFsHTrwigYyVbruR9aGutzCIrtOu8xQkkLjo9TnZio37SaksEo6zkbZL0AHSpdIa
 Tl85AC1Y=
X-Gm-Gg: AYBFou2yzD5XqnZIWJBClgUjDSUwQjCaXEdyP2ZLD15PG3XUkMAL6vp+ZcQADdetQMQ
 rlHfZlNqH1q/o1VKIee3cpZsJZySGNbKNXUAfxpjlbV3EXQ8gJiHCPGFafSX3z0N13R+ieXH2L3
 3P4hZfrl7hzm9SgC32c9T57M8T3ZQy9IrrVWgr6iy4zn76hzPiRvrXgn/wikYUZnwm+fXo2Amen
 jIWwce9S+2fg29N3BQCGl/XyrFkFRt6z8Ync4Mv+VA1GPk82X4zxcr5038hw/6hz3z1qCYCvr2a
 GHJm0gXRIgyehVyJYEFB2HfK2FkvZR9FstJsIY9axRXmOCgyDARXpwwPcOFvGtKffnda5vG+0nw
 HsKHB+giCwi4PHiYgzVhoGQKc1R7vzJHYZKBUmo4icvBGj5WVhIh9G3WwN6ooigwMMiDEUzWHij
 tiSS9oZUIA6suiyxAvpxrirO74ESnNGhlyFpVlNMl2+S9q6BZ3EeIUCatPhmdh3mDGgu6kpruAh
 NuaAj6DbOSXxAfLfnlHDIHLgYBQAdmPbY7Duw==
X-Received: by 2002:a17:903:1ac8:b0:2e2:c602:2072 with SMTP id
 d9443c01a7336-2e6004ecef0mr30623685ad.36.1791409279274; 
 Wed, 07 Oct 2026 14:41:19 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 01/20] eal: add missing export for rte_basename
Date: Wed,  7 Oct 2026 14:39:31 -0700
Message-ID: <20261007214115.3092715-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

The export for rte_basename was missed on the Windows version.
If it is a public API it needs to be on all OS's supported.

Fixes: b8a75ece45fe ("eal: add basename function for common path manipulation")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/windows/rte_basename.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/eal/windows/rte_basename.c b/lib/eal/windows/rte_basename.c
index f4dfc08a0a..ede913e6c1 100644
--- a/lib/eal/windows/rte_basename.c
+++ b/lib/eal/windows/rte_basename.c
@@ -4,8 +4,10 @@
 
 #include <string.h>
 #include <stdlib.h>
+#include <eal_export.h>
 #include <rte_string_fns.h>
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_basename, 25.11)
 size_t
 rte_basename(const char *path, char *buf, size_t buflen)
 {
-- 
2.53.0

