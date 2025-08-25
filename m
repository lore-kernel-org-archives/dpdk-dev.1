Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3C3CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:43:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCB60402DA;
	Mon, 25 Aug 2025 05:42:35 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 883D1402AE
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:19 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3c79f0a606fso831829f8f.0
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093339;
 x=1756698139; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeGvipj2j3MLRt4ioFWxlnqL8Zsq2mc+cZNeqlh7NQM=;
 b=ErDo7HWXfKtQ00k917zG1c/nDzHVSt2QR2HYNOHmupc6qVsdECteVn2KSQ4uSZySM8
 oW/9stxwB/qYlGwY53rVloF7vLloyhjU2CD0qpruK3m5N2iW+XJ08nCHmp3COpV27cZ2
 QrH5kV9eSWUlY/imM1fKN1RCz5W8orCGzp5Ol1DBgmMO3mDG1RQM1faGdh0RuyAvo/nG
 jYy7xoVdzYTc6S6H2p3hA7byisyFEXPob16bB2kMrelLFOsVNLnoE7xSpiQI8uegd9yF
 gwCIjWqt0Dl8YTo4n1UY8vZGocOq3xw6nDIti/ENex1kIHaPYGzLFX3GbGqzuBejvrDy
 0uWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093339; x=1756698139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeGvipj2j3MLRt4ioFWxlnqL8Zsq2mc+cZNeqlh7NQM=;
 b=VGFfImQdGop2uEieZEqqWKY5fikcKksc4/U37p+8ou+oXWNHfUZcRPY69XgOyffrIb
 DWo0Nb4jBpevYdPdwUa4YzSIm17L60w8AEqngC96rHZ5jespmdLynJolE/sxfvaY3JaK
 wIwvE1TKH5XY1MH5gNt+bVPvP9pXCA8g5ucM+GCZDj8gAct8G6CI0eOuyublu3Yovxbv
 Q6BvnzdENduR7gly2QC0/eaQ8qyjNxgJQvdt7SwEDTPbQz5efSBOf1bh7jfW4daYbtv6
 gi3esxHHOb/UplUt9jEUjnbn+QNJkFE1nG811vDm/Ay8RNI29ScEeib40eD88jx7jCN8
 A8CQ==
X-Gm-Message-State: AOJu0YyWZp51yhPNFzcWe0qqp9qRur+NEas73OOGs00F52v4IPHI8Z9Z
 pNKsSYG8jyP4KVQGrSyGfOiEheYToI30D9MlM9o4QY01xKZbKjokpmN2QVCa0cZrTtvIJoGFTUF
 QuKhk
X-Gm-Gg: ASbGncsnxuui4NVsI9uqgIss64PM5ZxnoR5Mm/cj1RywKQychLroR39TvqxBNDhXYhk
 wd8fSVbMB6KLUnnBjw9SeeN5LH8bw204z8nOveM0ovfNBR2bYXVCDT16jeUs3Wr1cTNM728sfMx
 Br4PNoMlk0lX/g6E+fTwy8djGYmc90uhfXqxnMR4+CS2uBqA82oPcVOIgvcr0hRCG0lkjO4IiuQ
 71GTEAGUMeH9krtEaR1mW+Z+9DeVEzPX5QNuAa1M17ukjmIDcGg5JY4+8G1MrlgHd90PgyfleZA
 RIMcqApwkAuH8dYNhyhatDgf4C1Rcqf4z1v6XTDNlSCgbjUJxJFT55iSIfEDgLCe6O49VDyV65Y
 6z6avlUN6NFht4SNFPaktQQT2TYTUwYDOlkNMi8OsehObvMgUQmiyhZB9McOFuJpOF6cbNYYL
X-Google-Smtp-Source: AGHT+IF09Ou9ykqDg32vuK9tdlJOf+Jk4w9CME7o3Qgk/GeN30W62//hwaPsEoG/rF2hCd2tg5hcGQ==
X-Received: by 2002:a05:6000:2f86:b0:3c7:2c9c:ae83 with SMTP id
 ffacd0b85a97d-3c72c9cb003mr5104304f8f.15.1756093339140; 
 Sun, 24 Aug 2025 20:42:19 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, ajit.khaparde@broadcom.com,
 stable@dpdk.org, Somnath Kotur <somnath.kotur@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v2 15/43] net/bnxt: remove use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:28 -0700
Message-ID: <20250825034126.12046-16-stephen@networkplumber.org>
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
index 7b90ba651f..0176b9f7cf 100644
--- a/drivers/net/bnxt/bnxt_filter.c
+++ b/drivers/net/bnxt/bnxt_filter.c
@@ -3,8 +3,7 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
-
+#include <rte_bsd_queue.h>
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

