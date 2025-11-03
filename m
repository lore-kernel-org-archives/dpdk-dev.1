Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6176CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:50:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB03B4067C;
	Mon,  3 Nov 2025 17:49:31 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 189674065E
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:29 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-33ff5149ae8so3568303a91.3
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188568;
 x=1762793368; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mymq9ZrntRXlyuScIE9U72rLH0fsKOypx6OxSE4jbzY=;
 b=qpm4ttBxiPvFzDwHAUixVDoAwF+PY4oepGsGdtKmr98zi252TfnzCJAbs/D0c5YASb
 2KC259svy82WvZZRGkZN+rrERTC849YgL6/Il7eyzGJzixUtQOAzic7axeDJvEDV0x4+
 bcuslzASMqTg9RdtWpsKcE7ve5noVOMy0/t2RNwoDWWf1EdrCC7o4DlWBkJbFDYuJ2t+
 Xr6ig0iPylP5BqDCmbOZOqqGxyqWBKuutVbfcMFmP3ARuzT4Le9RPKgYC8XOA1rDfG/c
 nFnmgnTGdjnq2kigAobAV87bj2mUXgiIjUskWO/aPsw9124PMEr+qT41BYHO3CyReY0I
 U49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188568; x=1762793368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mymq9ZrntRXlyuScIE9U72rLH0fsKOypx6OxSE4jbzY=;
 b=xRyzinKGd5osh8BKwftGAkiX/S7K3mP+GnFe2KNdv75bGbT+R1KRKeROw+R+EYqfIU
 EfXF3X56V5Z6gvdOo5vRIpZbXOrcVh6eV0z/yK+Ck65kou2RKzQz9vCXJJ1oHxLWNb95
 UZCzNczuvRWB4/0bsz40Z0jmpEfjGLtxlSHaFbypvuPDOyedpNjmgeMtg0rhk/T9aQ6c
 W78MkSUvDvo+FDav/k3Uxwwiz4OSn/aMtCYDKWTFJ9Kj4SDzSwdvcZAkRL1xweHQmtds
 PCXCKzz6J3pkFxtYz68GcPcTGc8tLo7Zlmhx/ZiNm3nBr9CByXJqqAWnEgzWSOOVbYtO
 eYLg==
X-Gm-Message-State: AOJu0YzKMCDbmgQjWNHlAeKKT7Q8ayvIcFUmuJvRb3JTYTOKV4M7VHIO
 kKjhMd1rjeWEqxablFLBaz3YlAgHq09MySnacU01oys/KXRaOQHBzxiuO9TI3lRHqii293b0Dbe
 fdYDm
X-Gm-Gg: ASbGnctudIsC9sR5WYCfTSkthaLQJXWgtrWSBr6XzlMi8bsXfAlnjFeaiQkGFTTSCMs
 ar53ZQW2Gd9H2lOu8ipfBO57nYTnLeSKyHixzA2oMR94O740HQTnWf3er6pjxhmvnUx/8u+4fdg
 yo/IvQ12ko3K5z0jRXbAe7KFCsENoONwiEMy2jwWvhiYEFAsJiHaTxzrRuYRvuUGAfR3YgLad/d
 Z8C62OHt5PLa1j9Sv5yMJeuZouDJBLN5kzfgFvuWOAdgUN3gxX7406muLl+ynTpEhNbUSPB9tgm
 O4ZnQf68HG+H3OT/Qfnw4vfT5ip2fLK7p5mCGmC704bAD46GVLgg0eHb8xl2I1cZek3B5n6L9J2
 5IJ5DYR//FExxJMoIEh3shmRl9p37IjqjQ3s95XJdfGSuqNid11tQAL9W6AzJdD6Ktj03xo7YFj
 zas8PPPzLt1VZ+9q0sLnCzvrSPHAcyG+0FaGMvSI0=
X-Google-Smtp-Source: AGHT+IETmUMUVMMAwBwvC6ls272Y+Bw//4jN/JAXXKlg1Avkjtuz+fCYryr/36Da45aPMy0Ewt/bcg==
X-Received: by 2002:a17:90b:350d:b0:32e:87fa:d975 with SMTP id
 98e67ed59e1d1-3408309d625mr16471539a91.34.1762188568159; 
 Mon, 03 Nov 2025 08:49:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v3 07/44] app/testpmd: use rte_bsd_queue.h
Date: Mon,  3 Nov 2025 08:47:12 -0800
Message-ID: <20251103164915.101713-8-stephen@networkplumber.org>
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
index 22afbdbad3..5296de21da 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -13,8 +13,8 @@
 #include <string.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <sys/queue.h>
 
+#include <rte_bsd_queue.h>
 #include <rte_common.h>
 #include <rte_byteorder.h>
 #include <rte_log.h>
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 3ce2a14a1b..965b4ab9f7 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -13,7 +13,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index a6e872e5a4..a239434d1a 100644
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
index 96973906fd..8a290a7f44 100644
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
index 2360da3a48..981a4ca9b9 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -16,7 +16,6 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <sys/queue.h>
 #include <sys/stat.h>
 
 #include <stdint.h>
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index fa46865c67..72a5d8eac1 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -21,7 +21,7 @@
 #include <cmdline.h>
 #include <cmdline_parse.h>
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
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
2.51.0

