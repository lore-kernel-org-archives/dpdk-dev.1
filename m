Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C219CCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:33:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 708BD40670;
	Tue, 19 Aug 2025 01:32:48 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id C9E284065B
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:32:46 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3b9d41bea3cso5039397f8f.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559966;
 x=1756164766; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZgscBR5d2uWwO3lPExFnXmZCWoH6LpUG8KTP6ATkSlo=;
 b=NhRdC+DUlXKTzJo4xeAN9xzbvYYaYkAvl6eXWIC3s4Nb0jhHaXHWur3Hm2r0NqdZIK
 uoW/pQGFlpgweXaLLgr7cAtXyHwXlC4+BAIuTTeh/1zsx9+JgqVuTngL9awMZ0ASn/4o
 vwfB6ABDrSsDlETFvZlKxCdhIiDnwMltd066zkEZqKiivKabCJpz/ZnHniMyxpYwopHt
 LMXpVP2e58CWqczD1836s7gYVRE3uWN4B/atzwINsGoCepVA9D9es6rvcTB/NIH6b30g
 52+s8OKtu5ARQJ/piJnS8X7P7J022tVezwAZCyY2fJHyw4vPLsLglM98IcBHeg+MPpzF
 eSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559966; x=1756164766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgscBR5d2uWwO3lPExFnXmZCWoH6LpUG8KTP6ATkSlo=;
 b=dq0drmQBV2JOnPnpVN1EgVChfRkx85mfsXP8q34bG+cGljOgQZv4s0XOnJqO4v6XzU
 1jq1HaCc4TJHQd0B9Dow/5lBk1loDeYsnYCnKTxi30W3By2RuGNgKq0yfyHCZLqYrRNg
 GR5NOCruZ60jXzZP/lL1/8oti3KeoZyNnfS2ffxhZ0q4gMzmj2uB2MUzKKE9EXENVjz0
 jPVZPMloFuKsaOUkk4o5Dvv66qdGQ0ucEOUakQp+XdxFr57F9iSccdcyUCzLHmnXpHtJ
 9xx+Zqrkq/zlDUBCEOkaCeQ9QJsixtz+hMLafNBlCOVF1T2//kjLdKZOFEYF2p8ePcMo
 jJqg==
X-Gm-Message-State: AOJu0YwZSSXnrg7gZWOoSqTWmUBJsY196hMJ71fuk6BaIypJAtcBKCxY
 kahV8DaID85yDRwHD54d0KyTN9SqzSLSuTLpubvIlVe/e3McdmubzHO97mHoPEHH1eDLj5566aS
 SYsOF
X-Gm-Gg: ASbGncupNRYzOtjzMxjgaC3Pt6GCBisBCG8yTybm6TmFN3ijYINRFoEQ0xKvF7HAqXP
 3ub9hbY0qXMfAtybwhOM4LUEJf8gQcxDx7AYNhOw/Xh7q13tzi/wCFaYdhaMnYa0qexlzLNfJ7u
 lTcDqEC7c+ySRj/lDiiXINDDNDzMx56wO9c4bHAoVUYn27dgMiB6K+YTQoE5mGLaCqJzI7WjD6X
 VXLLqIIXBGq7ux9dRTdG3+sd6ztfsPgj2rfsbSbQB1sEeV1G5Td44QxGEfJw26EB5FZ1G5B7UgV
 ugMabgmyCKOl7lzH44w61cX2HcA0C6UJdg8TTRKWkoexqtoTIUaovgqBtMe++Y5tHoWeIKKLio7
 4oGt/qw1/s+4J80YodkY5SiuF959EplTvXMVMQB3cLwx5R0EMbmKGxbWdEIsQvgmK3rzXQiDX
X-Google-Smtp-Source: AGHT+IELY7a9lrKuuiNrkOCPEUnnjjQ31nKQVZ5DKIWmoIIUHWhkbwpe1z7GP62vnLsdZM9iAYm+5w==
X-Received: by 2002:a05:6000:178a:b0:3b9:1d32:cf4a with SMTP id
 ffacd0b85a97d-3c0ed1f4912mr279954f8f.44.1755559966305; 
 Mon, 18 Aug 2025 16:32:46 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:32:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [RFC 05/47] testpmd: use bsd_queue.h
Date: Mon, 18 Aug 2025 16:27:16 -0700
Message-ID: <20250818233102.180207-6-stephen@networkplumber.org>
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

Only include the definition of LIST, TAILQ, etc where needed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/5tswap.c     | 2 --
 app/test-pmd/cmdline.c    | 2 +-
 app/test-pmd/config.c     | 2 +-
 app/test-pmd/csumonly.c   | 1 -
 app/test-pmd/flowgen.c    | 1 -
 app/test-pmd/hairpin.c    | 1 -
 app/test-pmd/icmpecho.c   | 1 -
 app/test-pmd/iofwd.c      | 1 -
 app/test-pmd/macfwd.c     | 1 -
 app/test-pmd/macswap.c    | 1 -
 app/test-pmd/noisy_vnf.c  | 1 -
 app/test-pmd/parameters.c | 1 -
 app/test-pmd/rxonly.c     | 1 -
 app/test-pmd/testpmd.c    | 1 -
 app/test-pmd/testpmd.h    | 2 +-
 app/test-pmd/txonly.c     | 1 -
 16 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/app/test-pmd/5tswap.c b/app/test-pmd/5tswap.c
index 8e8de2557a..2671fdcd9f 100644
--- a/app/test-pmd/5tswap.c
+++ b/app/test-pmd/5tswap.c
@@ -7,8 +7,6 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <inttypes.h>
-
-#include <sys/queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 7b4e27eddf..cf1bfe658b 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -13,8 +13,8 @@
 #include <string.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
 #include <rte_common.h>
 #include <rte_byteorder.h>
 #include <rte_log.h>
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 0fda8e99f8..3b21c7e994 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -13,7 +13,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index d355dbd8c0..babf4e1881 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -10,7 +10,6 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/flowgen.c b/app/test-pmd/flowgen.c
index 53b5f24f11..dc50f8c94f 100644
--- a/app/test-pmd/flowgen.c
+++ b/app/test-pmd/flowgen.c
@@ -10,7 +10,6 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/hairpin.c b/app/test-pmd/hairpin.c
index 5e6b37974e..35d5c06047 100644
--- a/app/test-pmd/hairpin.c
+++ b/app/test-pmd/hairpin.c
@@ -8,7 +8,6 @@
 #include <stdbool.h>
 #include <stdint.h>
 
-#include <sys/queue.h>
 
 #include "testpmd.h"
 
diff --git a/app/test-pmd/icmpecho.c b/app/test-pmd/icmpecho.c
index c87b7a80df..7b51513070 100644
--- a/app/test-pmd/icmpecho.c
+++ b/app/test-pmd/icmpecho.c
@@ -10,7 +10,6 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/iofwd.c b/app/test-pmd/iofwd.c
index ba06fae4a6..26dd787ca1 100644
--- a/app/test-pmd/iofwd.c
+++ b/app/test-pmd/iofwd.c
@@ -10,7 +10,6 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/macfwd.c b/app/test-pmd/macfwd.c
index d19ace7395..5ba3549270 100644
--- a/app/test-pmd/macfwd.c
+++ b/app/test-pmd/macfwd.c
@@ -10,7 +10,6 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/macswap.c b/app/test-pmd/macswap.c
index 57f77003fe..cc171aed4c 100644
--- a/app/test-pmd/macswap.c
+++ b/app/test-pmd/macswap.c
@@ -10,7 +10,6 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/noisy_vnf.c b/app/test-pmd/noisy_vnf.c
index 81d1187cfe..edf1f62b55 100644
--- a/app/test-pmd/noisy_vnf.c
+++ b/app/test-pmd/noisy_vnf.c
@@ -12,7 +12,6 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 1132972913..c3e46f97b9 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -13,7 +13,6 @@
 #include <fcntl.h>
 #include <sys/types.h>
 
-#include <sys/queue.h>
 #include <sys/stat.h>
 
 #include <stdint.h>
diff --git a/app/test-pmd/rxonly.c b/app/test-pmd/rxonly.c
index 315f9286cd..c73282e991 100644
--- a/app/test-pmd/rxonly.c
+++ b/app/test-pmd/rxonly.c
@@ -10,7 +10,6 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..b8ad6b6f73 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -16,7 +16,6 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <sys/queue.h>
 #include <sys/stat.h>
 
 #include <stdint.h>
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index e629edaa02..59e3620f0f 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -21,7 +21,7 @@
 #include <cmdline.h>
 #include <cmdline_parse.h>
 
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #ifdef RTE_HAS_JANSSON
 #include <jansson.h>
 #endif
diff --git a/app/test-pmd/txonly.c b/app/test-pmd/txonly.c
index bdcf6ea660..2aa8aaa4c5 100644
--- a/app/test-pmd/txonly.c
+++ b/app/test-pmd/txonly.c
@@ -10,7 +10,6 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
-- 
2.47.2

