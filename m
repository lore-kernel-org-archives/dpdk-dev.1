Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4522DCA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:42:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22BD440608;
	Mon, 25 Aug 2025 05:42:21 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 8B096402E7
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:41:52 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45b5c12dd87so9251165e9.2
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093312;
 x=1756698112; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6Bh7c2gyCKmkOZqD7al1VXeuns54zex9zJ4WUiUmqI=;
 b=mvzv/+4+A46wjtCv2BPkuPlOgVx+4bpI2OH49jlyDRGrBhRDGhiGa9+4SVUSewphZx
 pDrstexudwayolDBkYPNmrKZvd5OU9ab7SttIvzE2/S/Pq1W44KVzpeMIn8TDdkH+saX
 k1H2DbBXa1Q4/ze9k3zEo9YAbTA+FwWrwzaI7Nd0Y/gr2vhBeRXRrpg0KFOhkjLltGvX
 FX8fN+nTudTcCO41BkmZsXQwKtYTGJiPUz2UF8HONdfRENq0GnX7UYBZalhPqOPFK+QM
 /CRX3F6Y3Q9AMk42qDYOIitArFCB7Inqt5C3Zgg4iuF4TI2brlc1LHdXDomNFNndazN1
 gwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093312; x=1756698112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6Bh7c2gyCKmkOZqD7al1VXeuns54zex9zJ4WUiUmqI=;
 b=ewzvXusMXl2RdSTeQV4Zp19+V3iluNszsbjJ/bt5d2zZsmS2GYzWkUXqnNsZN9WnEd
 LVOYO+kYtXToj8mIFbQK20BE0hz3rQcfsxuCCA4Owj9Z5UpS45QGdUIbJgIyYEuhxvsM
 NaIymVDdO4FB7VWNFgZA1QyOVMBA2f63Jv6OxGQd2Alm1W87+6ufxzFkk0l1g2E9ja7Q
 pcJ6iobwmFwS2E/iMQt43qHCmc484VN9l6fY5HXISAi1+CwEfd1RmzFNCnT5F47+0Xc1
 VUiBpb4x5RiZcaALt8+u36Aavu0kFt0YEDybCIEu+2UudKscTGohskTCQkFChhh/99EB
 y60w==
X-Gm-Message-State: AOJu0YzIba+k+vDQhfviYqccHNlL8Jmzj9DQ3qfYPzCmoBM9BO/wmZkD
 JsTIfX0Q9pjCY0+nug+Wx0kWscxIC3oh4aWS2xjhzwc1l1+XS2NSN4/ALldJM3uO70hmsyJoCoi
 Ivrjh
X-Gm-Gg: ASbGnctSXQXTCLaEmmCtPRg0XyVP+EH7r6XFcPMFE0v6dZPYds1FHTEXi5uKjKYvtzp
 5evZmi4cl+QNps4aAGSMcs2e63NmsRDyB+FTir5wwYoouQ7tzc+R08dUA3odt/9GMDQO5bZE8py
 SRrEm1yT7IvqIDsXCk+5MjBAOj4H+NcpZ9HUpSIlDfdAeniQ393sUzHOKfd/k+QpL1ro7OsoFtD
 NaQVrmUWncPHIAoPVQkGxPfXOmZERny9KwILgtPcDgX142dIbh4V0H5ePdF/4sb9HwoHRvow7sV
 uTWrs8CX3xd7gAV6JScHcsyZ2U83tCCt8Ur/p7yMVfkexbfbu4fX/AidQrDrYLQAlzvCWGtNr8+
 EkcDUoAGoxvePCh8Do2So1VQvaduIX13HMGY+/yk+VqKNLegZHduyv9Rv/gqOcL86oxUsSgGD
X-Google-Smtp-Source: AGHT+IFVO9N8eE7IH0FpilC2ViSY/bxW6STe0dWLxrX9nxyFbu5GOGbtJ0AFZ0QvQbk5jCDFDaCWDA==
X-Received: by 2002:a05:6000:2407:b0:3c8:9cfa:c178 with SMTP id
 ffacd0b85a97d-3c89cfac400mr2878298f8f.25.1756093312089; 
 Sun, 24 Aug 2025 20:41:52 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:41:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v2 07/43] app/testpmd: use rte_bsd_queue.h
Date: Sun, 24 Aug 2025 20:38:20 -0700
Message-ID: <20250825034126.12046-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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
index 7b4e27eddf..3cfec19407 100644
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
index 0fda8e99f8..fe2e870bd4 100644
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
index e629edaa02..838b9ba291 100644
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
2.47.2

