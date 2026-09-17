Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91322C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:12:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E4D942FF9;
	Thu, 17 Sep 2026 22:11:38 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 707A842FF5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:33 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d91ede8035so353075ad.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675892;
 x=1790280692; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+SIrIH1gWKlQ+cXdw+QSW5UiNBaNm2rGrMTXtus/zFE=;
 b=dOHmB38an4FRmIvm4LgsNiAa00UWMMGIuTqQGBHeoTWkJ343/is+A8PlX2dTBNSFpP
 dKn2rhigXQFehbMJmCjoT5/YySa5Kq/8Kwpi8TNVAA7tmWyGOUPttZAmSDDdEMGe4zxb
 5RISYDBb6HLNda/f/qR6Xkh7K4b1nE0E6ARN2cHWKNDBytpTUup9ZRYE9IGFApNCJb/L
 2/j/vedfWeu9ilwAKt4rLlgMJj/MnyI5zkr9oKbZAIm/PVE6mV9XITuEZ3mzCTBgaItU
 D8eYJQ9F/OPW2A/TabiUn56sGGk44rHFMVqoNWKriN25oPaRC76v1mwbAdXfHggue0/v
 zPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675892; x=1790280692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+SIrIH1gWKlQ+cXdw+QSW5UiNBaNm2rGrMTXtus/zFE=;
 b=tYgxA4TF13kENhZV0TsKNgpaTET3FB9mskM3tPEO9wbAJuwM/GQ0ObJQWmshEX829u
 3JDgAdscr2JKnjPQuZb3FPOTsw5q7iI2GCSRUY+SJDysrS8GkaViRGBBLlUgIzmukaFo
 kvycgl2qrE79ZLYvwf1WjJpotgBCusfFlYE+7J6i41/GcYrnSCKmJog5Wsm4Sru4XpvE
 HeeN+8Mhfj9ghiZz7/msSprY2rzSgjOk24BOZ/aLXbeNOujSnlfxSHmcVYSjV6AJAl+4
 YjCQ5nnbBcJ+Hl1Bzy7l0aOWo37DCKm6OkqvfjZfdxGu6akhGscmnpcL25Jfa2lq//lC
 tNpw==
X-Gm-Message-State: AFuF++lwwxT24TJUI2krzy44meemGeYdJOIhw7BecvrxL1SzUq9pTLNe
 fhBHq12YwMkRxg/RMMHQhor9ycoNWWbq9yYgF35b26+N/+2WtnlOkCseEyMxlPdu4U4XrznR76J
 lcmIZ
X-Gm-Gg: AYBFou0OWh4zzncRLsNiodB4XHUjjUgUqja2K2znKV1dNVM42vnL5bsOLF81ch2mHtB
 uSHNOQJPZMtyDs9ItPWqAKIJrlieRKGiIMprj9+KnaoBdXQLnR3HbLatMnVfijI7aseXq0g/KY7
 02cTbhiwuUu5U0L8R+JVDXuNZEOmQqL/awh4lJdL+j7EtP6sSU1YqiK+QbMt0jpDPbmkWwm8XPH
 WIx/OLnW1jzZLRhhVVh32+xVLvHdu3uBce0uefHxMXER5tyLkpGfC1mTfw+G+I6kjN4XZawtruU
 0aDdXpMRLkfFafyxFEGtcYvVmqLdymW3ut14aJEOFyq++bavg0NRXvVL3jut0DbTccBmMio3Vj7
 kvXcgAo2iBzsSISxldGdpplOhpPYRbmyJJ2LBJYClytzBFvex29WvBT8cbQd7J/zt+G84tMUaX3
 f1qdsLsaL4KgkUn3VztI3rVlxLySAPqQyC3M5PU9KjMd/l5SE/JumM/3Koc171GA1BdfIaHDWJ3
 IiLuwewtF7HYz2x8r6JfOp2t4M6V/VS9zuEYrE=
X-Received: by 2002:a17:902:f792:b0:2dd:ad74:ac80 with SMTP id
 d9443c01a7336-2ddb1bbf3f4mr5983115ad.27.1789675892646; 
 Thu, 17 Sep 2026 13:11:32 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v8 11/25] bus/dpaa: replace rte_atomic16 with stdatomic
Date: Thu, 17 Sep 2026 13:10:15 -0700
Message-ID: <20260917201119.2168234-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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

