Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA9CCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:05:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83A8B42E48;
	Tue, 29 Sep 2026 16:04:31 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id E2C6742DFA
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:23 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-8692a8568e9so1854912b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690663;
 x=1791295463; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+SIrIH1gWKlQ+cXdw+QSW5UiNBaNm2rGrMTXtus/zFE=;
 b=BZUoHbfwstkoPZUYZBKTVQd7hPqzY6RYYCnSD7ijGGdFQim3bBfbrrkrJv2uR0MouP
 cD6/EQ2Kl3nCtGn6QnhawCXxOvys9m9v7ht4kzj2+be4s8gY890kLBiDPyrStOCcgGIX
 CCm7AgWLVwsg5aAxm7BNIYUwPIj8UG+UvnPam64pFzTl6jM86NBrjHmYZR2hJ7h9ASBi
 /+AwHJNRthFDLMU9CzbrALToLse554OuGzT2xXgnumhPzO56HZ58kjLcyArrTaborg40
 4f2hmSag942Zm9jYYVaI1O31/4KjBUuT2SV1crhSVR6tLdnI77NFaLIzfF5w1HBMDZWZ
 a2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690663; x=1791295463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+SIrIH1gWKlQ+cXdw+QSW5UiNBaNm2rGrMTXtus/zFE=;
 b=UnflFyRmtTuXbMCTOWTmub+Lb+CIK0ubsI31o6V+9XvnRYdmmZsYofNRFYNEcoqnfD
 WnrwztPBoKxaaZNZ0TAUg0BJMxVhpPufEe2H4h+zLoibdH3ZGpGYN6pHfRJS8NUxFSaH
 z62pVQZLqfPiVye4pmJ80qZMbyEjsvKRalLiA2qqs6+mEklsCn2Uv7rgFXCGkFshuEGK
 WKmJmjQGUVv7EsVOLDM0vXs6RxVRzERd56GZzgJzn2p90jJljDwLURHiF2Qsfy0mRe/V
 eBVcJCJQZkCBQusZJwndczpv95hfhaF3/aFcJK7VSphEG3KzgQoWkW67cmJP445B0wit
 +CyQ==
X-Gm-Message-State: AFuF++nsQO+KNwaGrBaK113Xaei4L4CfxNeUmJIsv53kfw02hhkjQ79F
 +IDvcMuE9toCxMUFzuahPybLroIA83aVHlQqhwU9WePAAn8puOzp88oF29XjEo6vuCnYNYLm16b
 07iXiHYE=
X-Gm-Gg: AYBFou3Y5QWN834eZz2ps99TcdJ5X8zsg9jT+ZCQ8Tdcxkh5zhpfgkrBhWhtCXnv+RC
 3Rm/sjGFB/Mkl6hJgnCZDlu7ilXY7/5iUPf3HD1EcgggUwir4gIdWRGU+0JT1BMCzUbkhRl9AGI
 2NfciA4mIIeU25vC22bitSRe2OHlWDdHtEye18mMlEATVLx9jwtIwmLK6isLjH5ishB/jfHILtw
 VC9sPEQaehQcWvaHWEynXT7Um+b5wQXG34SmFXsAYDlz6YNweP1BeAR78gq4pGpt9YpoDWxsUm+
 k5GCq0ugD5oAI+3bW9B9zkJ2cj5PT3iEVgLFQZ1oLfhGvFS39plnCrRx+PIOzzxNcWLnxSnTbdZ
 88BNgWymfnBZa9AP+/BpNaWPqsnDUx9rHx2IlCod7QGRbaK0VlZr0EZx0k16gx2+8k9o41Bb9TX
 JnR8Gid/2y6T0jRhecEhTTCnxihy1mEjS+kMUhCbEuhlIVBDr7DW2QuLjbfpLzYf0WWSfYiXK5K
 M2IiW14SFp78p5h6NAXKFLoKPsmGnUHlcqh5Lg=
X-Received: by 2002:a05:6a00:21c7:b0:878:3538:8f79 with SMTP id
 d2e1a72fcca58-87e9f0550e0mr13441929b3a.39.1790690663080; 
 Tue, 29 Sep 2026 07:04:23 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v9 11/25] bus/dpaa: replace rte_atomic16 with stdatomic
Date: Tue, 29 Sep 2026 07:01:57 -0700
Message-ID: <20260929140409.234453-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index d289df2d33..ff56f7b1ab 100644
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

