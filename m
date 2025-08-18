Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E66CA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:34:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ED0540A87;
	Tue, 19 Aug 2025 01:33:39 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id E0DCF40B8F
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:37 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3b9e4106460so3767584f8f.2
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560017;
 x=1756164817; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbP/WkFn0Ld1PuEY5G7hzTzKk0Or7Qefix8v3+E6pRA=;
 b=OtXRyICZIcsj1dtdW/ohmIlviV03OFzI+RbZf8sDkg8zBc031F30V8Lf/TdGFPtJD3
 j2I2BA4GNaaLqhgGvEP2orbLuLYu3dDDt819ES1O0+bFCxu9/16ZEvEhbf8Z8+7lJeZy
 gW9EmLu070N1RaLenXyvZF/sNB1epxGvsKQVC7o011ZAxGAPdDzh1JswX8jAJ5vn8OOH
 2KFmgByw39pObRjZRNkVPBlmqqlfpJbUzgOn1ZEg8fpgu2FHK1k9Z+xBYtU4Vhv6aXZ9
 xJvs7/ZuKYQoAuCA+b8PogUee7dQb8Lan0ecNh0GrTT+QqxXSwsz6ckL/cPKpwY6sfyO
 6Fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560017; x=1756164817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbP/WkFn0Ld1PuEY5G7hzTzKk0Or7Qefix8v3+E6pRA=;
 b=Kwm4qmiWMvKYfnG1fl825t6Ds+9+YPoWl9V6rGro5uNs0tEVVB4FaxyyKa1BbDUvgS
 qFvB5Jd+IuYyiX3m/wDhm3Y+QEifpyqCaXHlw4TBIY7/wtp7MssQlhHIsOth+GW+dxx2
 ODW7P+R1A0ye7gdq+gz7R9CP8fBuNg9VGsfIh91tQHDBMsnjWOd8EqfBKYBWaoDYw5hg
 SP+cLDPd/ZZ7Ubs6Qoioad1QtPR9NefGtSRoEv9q/UZLJGD1Dfx/9IfWkDV2G2D6Ysie
 v8PxYje4wMGqkczGELM2N+9uHh82vPdENQHSBfc9b1eoBrSLNM/kWhECSM2TrB40S5oL
 lJmA==
X-Gm-Message-State: AOJu0YzmLEwfW9uACBNvfpjzZ5QwmfFoRjOG0SRYgzRPKkIA3Zjr354I
 PudNNkNDWomDLEE/vPwyuunDFZHWfkwUxS/Fz8MybYm8jgLZAJSQLsdPcbq9ywmzirtoPM0XUhb
 W0tou
X-Gm-Gg: ASbGncu+kA8Xhd4cKxNsrlviddpYfNGXzeSut+D0YNVPF8IqQWd5zsSQg7rF11nPASq
 YTzyvdU4BD0A8v+wvw2AxkMOlhUI1ggeu6p7hCNkfGR/Lcl0MSLgJZ7tOzV9SJJmzR5CLbaNBsc
 b8z+UXfwxWvno9NXhsKCWhHnG5agfRkxnrw3xqqf8ycFTQ6BHTX0HTiQOvjo9hFjCM/+xM6lA4y
 3jbFO/PWChGJEjRMWMiBkHwb6VbOevXQ4PmbyhCgRF/fs5aimEu4ZMfsRa1eChX/naTUoZ2zLfA
 /Eeqgceiq4iurRyVeU6EqrF8rpdS1JXs4vGSnyF+4p2wJZQOOvJRK5mVIAafc+jNNCv+WFh6ePW
 KB6+iWQwFMW29G5+RBr7/yYsa5FXHTCv21m3H37smUIDCXePrAGGFsk6SNzNNWWyH8a2MjOgl0Q
 oehJiEyBM=
X-Google-Smtp-Source: AGHT+IErlRq6TuPSJz7UBNDajbUOhAD0bb+oKXirJDfNqbBgBtVg5YGMZf2IhcCtpXXH7hjNoxNkkQ==
X-Received: by 2002:a05:6000:1a8a:b0:3b5:f0af:4bb0 with SMTP id
 ffacd0b85a97d-3c0eae59585mr251360f8f.23.1755560017454; 
 Mon, 18 Aug 2025 16:33:37 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, ajit.khaparde@broadcom.com,
 stable@dpdk.org, Somnath Kotur <somnath.kotur@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [RFC 23/47] net/bnxt: remove use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:34 -0700
Message-ID: <20250818233102.180207-24-stephen@networkplumber.org>
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

Fix unsafe use after free by using STAILQ_FOREACH_SAFE.

Fixes: e8fe0e067b68 ("net/bnxt: fix allocation of PF info struct")
Cc: ajit.khaparde@broadcom.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/bnxt.h                  | 1 -
 drivers/net/bnxt/bnxt_filter.c           | 7 +++----
 drivers/net/bnxt/bnxt_flow.c             | 1 -
 drivers/net/bnxt/bnxt_vnic.h             | 1 -
 drivers/net/bnxt/tf_ulp/bnxt_ulp.h       | 1 -
 drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c | 1 -
 6 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index c9fdd36d3e..e9099a3ff2 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -9,7 +9,6 @@
 #include <inttypes.h>
 #include <stdbool.h>
 #include <pthread.h>
-#include <sys/queue.h>
 
 #include <rte_pci.h>
 #include <bus_pci_driver.h>
diff --git a/drivers/net/bnxt/bnxt_filter.c b/drivers/net/bnxt/bnxt_filter.c
index 7b90ba651f..4c44506daa 100644
--- a/drivers/net/bnxt/bnxt_filter.c
+++ b/drivers/net/bnxt/bnxt_filter.c
@@ -3,8 +3,7 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
-
+#include <bsd_queue.h>
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
@@ -110,7 +109,7 @@ void bnxt_free_all_filters(struct bnxt *bp)
 
 void bnxt_free_filter_mem(struct bnxt *bp)
 {
-	struct bnxt_filter_info *filter;
+	struct bnxt_filter_info *filter, *tmp;
 	uint16_t max_filters, i;
 	int rc = 0;
 
@@ -151,7 +150,7 @@ void bnxt_free_filter_mem(struct bnxt *bp)
 	bp->filter_info = NULL;
 
 	for (i = 0; i < bp->pf->max_vfs; i++) {
-		STAILQ_FOREACH(filter, &bp->pf->vf_info[i].filter, next) {
+		STAILQ_FOREACH_SAFE(filter, &bp->pf->vf_info[i].filter, next, tmp) {
 			rte_free(filter);
 			STAILQ_REMOVE(&bp->pf->vf_info[i].filter, filter,
 				      bnxt_filter_info, next);
diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
index a2e590540b..d3da309254 100644
--- a/drivers/net/bnxt/bnxt_flow.c
+++ b/drivers/net/bnxt/bnxt_flow.c
@@ -3,7 +3,6 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
 
 #include <rte_log.h>
 #include <rte_malloc.h>
diff --git a/drivers/net/bnxt/bnxt_vnic.h b/drivers/net/bnxt/bnxt_vnic.h
index 5a4fd4ecb7..be232df2e7 100644
--- a/drivers/net/bnxt/bnxt_vnic.h
+++ b/drivers/net/bnxt/bnxt_vnic.h
@@ -6,7 +6,6 @@
 #ifndef _BNXT_VNIC_H_
 #define _BNXT_VNIC_H_
 
-#include <sys/queue.h>
 #include <stdbool.h>
 #include <rte_hash.h>
 
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
index e0e31532fd..f8c46186fe 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
@@ -8,7 +8,6 @@
 
 #include <inttypes.h>
 #include <stdbool.h>
-#include <sys/queue.h>
 
 #include "rte_version.h"
 #include "rte_ethdev.h"
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
index 591bde96e8..cd97bc6635 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
@@ -4,7 +4,6 @@
  */
 
 #include <math.h>
-#include <sys/queue.h>
 
 #include <rte_log.h>
 #include <rte_malloc.h>
-- 
2.47.2

