Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E732CD98F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:32:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40B1F40B9D;
	Sat, 20 Jun 2026 04:31:55 +0200 (CEST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by mails.dpdk.org (Postfix) with ESMTP id BAEB440DD1
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:31:52 +0200 (CEST)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-80260a90522so4344487b3.0
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922712;
 x=1782527512; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMlcGnSZx5EiIzcBNAG9ysoM5RpgN6KoG1NhJToEetg=;
 b=h+JFf4AeFyN47eoanLDDD43kzVy40yw//EHOKoLtNX110io5VrLwgf1WNYj+SCbN18
 t14F9GA/F2Mu0nFXkWsoqO6hBNUzStZYu+zkhh2LP+zia1SigMXMEM7SS1/cBsvggDv9
 8D5XuIiQ2O7RgciSpifdz7nBiCAa64xAFhtcrNp5jz5naARrA2VCNQM9hkwebWXb/iG5
 +15Ty4KZg/AXgN1zCRDlChUqnusLqCO9yYeWn3mJ3taN3x9F++Tg5StBTR/sTDhjIHrm
 y96IKUcGpxOtVVG5fj0y1c6v20nSoOjQmEJ9UTxGyDZLM0wl4tPwe6y32bIE1/Cjh+wN
 3qdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922712; x=1782527512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UMlcGnSZx5EiIzcBNAG9ysoM5RpgN6KoG1NhJToEetg=;
 b=ayH2/ix8CnFRN18Iha5znB5oyfOfBCpXo6Fg3JVNE2NHuhPVXSt75UrhaRtW57tw0X
 HfMVKFy1hExdMC2LhZbHttcrM/8uUa3sGtfvxgWX5JuAxZ6h2dRhUdS5lM6wHmr9MLFl
 2ly4Z8BhP/WwpYGVdGiS6dEOok9ucoovGGQjZvfff67z8vFyFhBww/YLUMQwO6c3gQjM
 c+Y/kYz4YlN/Kk9P7srF5S4Abf5G4gOg0/buo3o9LX9+XDfTpOp69RcYX6Mmxa+SUPyO
 GnVYss1C9AL+g/0sZyhge7tB2Yc/raF9gJgePmCc5S5s3OJRzIc4NWE9aqvjwOrKPHtp
 Zlfw==
X-Gm-Message-State: AOJu0Yyor5HjCHuEIZt0JT5/JuRkkfxW6qpi75JjbzT8Uzj36g8heA3t
 ESftxYSPpigspgZFOtRUO6HVFRkZUXnzDRY7lm49r3kLN19NCf+mZ6K5gKUKij8/zwsVUO39Mde
 TDSGR
X-Gm-Gg: AfdE7clrLz6ogFuDywgYePDG6FVlnxYBwYR1M8AwWuj5a84kcJ0bqhBzT5WF/ZD+ihj
 fL6rsMmc+zWJ3BAn0yPwTpYDEtjsNrW1w3/UsL8SRo7ALEtVfoTaWyoV+4YAbxAccfsSq6ytE6J
 /U0RzIYZHSNJupZz9g4WNXl8Ou3jWvxtHMjnd7glSxNRr1J/Ta83qzeT9JSMIvFfPtEpJ0LkqlE
 HWvSr94mQ13lp9vBM2BUyewN8zH3pWJhs/n2yJaE8KhTrS7yxcGn/eTdNPrL7cC8OpfEO9trxQe
 og3QQs9oo3ImAPyXthm2qHEHWtSTLdw3NSOA6heGtfSqs777usW2sXZXdUBHoPwbHBcH7npftC1
 tSAWWnIwiodiXwQml0WXnYwXotHzBekU7ww8dJKbdk4cZta38X8daCBsSIYZNfwfpGSM7SJG1No
 MVA70RBL1s7vkFGQVb8+hUwGNhsDbD/qG+ivSQhFjcGVYeEw2y4r4=
X-Received: by 2002:a05:690c:4805:b0:7ba:ef98:9720 with SMTP id
 00721157ae682-801765bdcbamr54142967b3.4.1781922711951; 
 Fri, 19 Jun 2026 19:31:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:31:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v5 10/24] bus/dpaa: replace rte_atomic16 with stdatomic
Date: Fri, 19 Jun 2026 19:28:35 -0700
Message-ID: <20260620023134.42877-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

This is simple inuse flag which can be done with stdatomic
exchange logic.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/dpaa/base/qbman/qman.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 5534e1846c..82a976141a 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -11,6 +11,7 @@
 #include <rte_eventdev.h>
 #include <rte_byteorder.h>
 #include <rte_dpaa_logs.h>
+#include <rte_stdatomic.h>
 #include <eal_export.h>
 #include <dpaa_bits.h>
 
@@ -683,7 +684,7 @@ qman_init_portal(struct qman_portal *portal,
 
 #define MAX_GLOBAL_PORTALS 8
 static struct qman_portal global_portals[MAX_GLOBAL_PORTALS];
-static rte_atomic16_t global_portals_used[MAX_GLOBAL_PORTALS];
+static RTE_ATOMIC(bool) global_portals_used[MAX_GLOBAL_PORTALS];
 
 struct qman_portal *
 qman_alloc_global_portal(struct qm_portal_config *q_pcfg)
@@ -691,7 +692,8 @@ qman_alloc_global_portal(struct qm_portal_config *q_pcfg)
 	unsigned int i;
 
 	for (i = 0; i < MAX_GLOBAL_PORTALS; i++) {
-		if (rte_atomic16_test_and_set(&global_portals_used[i])) {
+		if (!rte_atomic_exchange_explicit(&global_portals_used[i], true,
+						  rte_memory_order_acquire)) {
 			global_portals[i].config = q_pcfg;
 			return &global_portals[i];
 		}
@@ -708,7 +710,8 @@ qman_free_global_portal(struct qman_portal *portal)
 
 	for (i = 0; i < MAX_GLOBAL_PORTALS; i++) {
 		if (&global_portals[i] == portal) {
-			rte_atomic16_clear(&global_portals_used[i]);
+			rte_atomic_store_explicit(&global_portals_used[i], false,
+						  rte_memory_order_release);
 			return 0;
 		}
 	}
-- 
2.53.0

