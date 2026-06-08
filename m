Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F930CD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 04:42:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6B7B402AD;
	Mon,  8 Jun 2026 06:42:03 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 7A2B140265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 06:42:02 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490b2b037d2so33331365e9.3
 for <dev@dpdk.org>; Sun, 07 Jun 2026 21:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780893722; x=1781498522; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OdYBwKDJgOWTRUXm2I8Ymp8izTKRvvGzVIoPGF2RF9E=;
 b=IiY+0+NXpLK+ywDeu9A3MkKEM5Wruv2PBHT5URqMVVKiBmyumkhsGzeXH2bKLDgoUz
 UK4PjMUSq+aN/3T/C75ySm0gt80Z1czU9NbjCZVMRA/AqjFeVykzW9oOxirTUsHNlAxq
 UiloRb7+qFwGVaP7qdeZWrsHJ5qrClxeZp19D11DmeE0NofeuvC73QklJLg/ANkb8bSQ
 tPa8WnD3AdYa2wnE4/9CI+X5ycQzJa4lvvL3FlK0TUbKxM5wIdBu4CYZmbfy+YPY0HRY
 XS/C/TESSH8HiAiSYCzOAEDA0cd6S7t0AUOh6dAxgfLg1TPPdSwReqHDwZcW7sayKq4U
 2X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780893722; x=1781498522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OdYBwKDJgOWTRUXm2I8Ymp8izTKRvvGzVIoPGF2RF9E=;
 b=RdGuaHKkJZUwqWWDCJDMV2iaDgDfXAOG485YDwZhTI4m5hqAo35IFmswqapSBttTza
 ZR1pUBt8iGuL/lLv4opnanAcnCspc5Rfyq+lmWcWMnyr3gahfdg5+BFRUDGsWiwrMcI3
 YlLdjbNxbIs/MTVQDqXhWWhZSvtvr1dEwoSdiuIFYz54jym5SokEfimCrtSaDbLKZGTE
 NlAF+SXJGZQClykB3glKWOYzaLb6BYOLJx4Ydrhhzi1jLikx74KG1ryr4FmEdFfZXKLK
 pOsY9QH/k04lTu1I2Gevq9/4SFuHLvMdeEVQJT8N+5VDIIbiNFO+O6On4zPg9AFBERsA
 xWfg==
X-Gm-Message-State: AOJu0YzscwcLG4sfjFbiXZMwNAp1Rg1EmVJ36D1Du+TUty3XKWgNkLN6
 10XMq4PpVYSmmKE/HXNsnr1UoB5fRGX7FlnKkPs2koMutnzCSN+SEH2y6sWgKk8l
X-Gm-Gg: Acq92OFGw4qpGkl7Fke14GeEnlyVkf3DTrkKI+mmsSblkEvAJYb1I+euC84qWD2NGRX
 CNEAjPpuPepcqT9E8y8nh/EqNXcYQ/rRpJPHjnmsVDssCkfeYZHhQYjLpLb7MUCMfVsksn5WznJ
 U9qpWETrrq1EflHNSQEE1PNuQf/nJ5XtIvyrxu68/vVGtbc8KkygI3i9nB9gZ4R4J0vTAcGitMc
 MfHXo5hRsEak/rNZ4eUI2MmeSbTEyvQeyFNqX8DziAKVOHilPDSqtkIrm78QtSOTmMTsTAkbgu1
 cOfwCgvrNrRc59jQf88kKCLhUqNmiUKy1xr2ZttriT/lI0sioT3EmunpP3QTquzUj4i4wZcTa9N
 DacPKHrcoox5zhnTa+gbsl3+Xnx9qtLffCqJfc9LgVqRju1EbfkrS9f9P6GSA5A9QAbYLl7LnoB
 l5dfdVm2P5ZeW3XXLrdianXABUmcm0odmhzpwECZJpZcmIAbjBGzKS3QmSKnc9BMzCyc4=
X-Received: by 2002:a05:600c:348b:b0:490:be78:1861 with SMTP id
 5b1f17b1804b1-490c25af9bbmr229610725e9.4.1780893721848; 
 Sun, 07 Jun 2026 21:42:01 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcb13sm48351539f8f.2.2026.06.07.21.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 21:42:01 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, shepard.siegel@atomicrules.com,
 ed.czeck@atomicrules.com, john.miller@atomicrules.com, stable@dpdk.org,
 Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH v3] net/ark: use standard IPv4 address parser
Date: Mon,  8 Jun 2026 07:41:11 +0300
Message-ID: <20260608044111.21213-1-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260604034837.250221-1-denserg.edu@gmail.com>
References: <20260604034837.250221-1-denserg.edu@gmail.com>
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

The IPv4 parsing helper used by pktgen and pktchkr read each octet with
"%u", which accepts values above 255 from the configuration file and
encodes them into unintended device register values.

Replace the hand-rolled parser in both modules with inet_pton(), which
validates the dotted-quad format and the octet range, and matches the
IPv4 parsing already used by other DPDK drivers. For valid input the
returned value is byte-order identical to the previous helper, so the
register contents are unchanged.

Fixes: 9c7188a68d7b ("net/ark: provide API for hardware modules pktchkr and pktgen")
Cc: stable@dpdk.org

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
v3:
  - include <sys/socket.h> for AF_INET.

v2:
  - Replace the hand-rolled parser with inet_pton() in both modules
    instead of adding explicit octet range checks.
---
 drivers/net/ark/ark_pktchkr.c | 10 ++++++----
 drivers/net/ark/ark_pktgen.c  | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ark/ark_pktchkr.c b/drivers/net/ark/ark_pktchkr.c
index e1f336c73c..e1a2943957 100644
--- a/drivers/net/ark/ark_pktchkr.c
+++ b/drivers/net/ark/ark_pktchkr.c
@@ -4,9 +4,12 @@

 #include <stdlib.h>
 #include <unistd.h>
+#include <sys/socket.h>
+#include <arpa/inet.h>

 #include <rte_string_fns.h>
 #include <rte_malloc.h>
+#include <rte_byteorder.h>

 #include "ark_pktchkr.h"
 #include "ark_logs.h"
@@ -374,12 +377,11 @@ static int32_t parse_ipv4_string(char const *ip_address);
 static int32_t
 parse_ipv4_string(char const *ip_address)
 {
-	unsigned int ip[4];
+	struct in_addr addr;

-	if (sscanf(ip_address, "%u.%u.%u.%u",
-		   &ip[0], &ip[1], &ip[2], &ip[3]) != 4)
+	if (inet_pton(AF_INET, ip_address, &addr) != 1)
 		return 0;
-	return ip[3] + ip[2] * 0x100 + ip[1] * 0x10000ul + ip[0] * 0x1000000ul;
+	return rte_be_to_cpu_32(addr.s_addr);
 }

 void
diff --git a/drivers/net/ark/ark_pktgen.c b/drivers/net/ark/ark_pktgen.c
index 69ff7072b2..17ac33fce6 100644
--- a/drivers/net/ark/ark_pktgen.c
+++ b/drivers/net/ark/ark_pktgen.c
@@ -4,9 +4,12 @@

 #include <stdlib.h>
 #include <unistd.h>
+#include <sys/socket.h>
+#include <arpa/inet.h>

 #include <rte_string_fns.h>
 #include <rte_malloc.h>
+#include <rte_byteorder.h>
 #include <rte_thread.h>

 #include "ark_pktgen.h"
@@ -355,12 +358,11 @@ static int32_t parse_ipv4_string(char const *ip_address);
 static int32_t
 parse_ipv4_string(char const *ip_address)
 {
-	unsigned int ip[4];
+	struct in_addr addr;

-	if (sscanf(ip_address, "%u.%u.%u.%u",
-		   &ip[0], &ip[1], &ip[2], &ip[3]) != 4)
+	if (inet_pton(AF_INET, ip_address, &addr) != 1)
 		return 0;
-	return ip[3] + ip[2] * 0x100 + ip[1] * 0x10000ul + ip[0] * 0x1000000ul;
+	return rte_be_to_cpu_32(addr.s_addr);
 }

 static void
--
2.50.1

