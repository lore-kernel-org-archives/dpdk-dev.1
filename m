Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64DECD5BDE
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:27:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0274E40A71;
	Wed, 27 May 2026 01:26:07 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id BD53D40689
 for <dev@dpdk.org>; Wed, 27 May 2026 01:26:00 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-304997cdb21so3021613eec.0
 for <dev@dpdk.org>; Tue, 26 May 2026 16:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837960;
 x=1780442760; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMlcGnSZx5EiIzcBNAG9ysoM5RpgN6KoG1NhJToEetg=;
 b=O9EbuUO0pz3heaSfF/R1Qdz/CRRTWw/sPIwQFP9mkPG2zo4AHras1qHonKuEkcjh3v
 0ubuM6rgKb1KH1XwrdpezbDp8eNd9XM8RTg3VWns3QPQGFSxI4jiNlglytsh4h97zPVq
 Jh+r5KH7SRa+0x2VLG0g8XXJwS0lhSk7KSaxPbd6bAU7Ym8kmi1PVgrXZI8xf5LUEPta
 Zc8OyaNPsyPZ0A5WIlNZ+bkCVMI0/VIN5as3OgkTiIMLcMMZxrsMtVFpCnXHTvROv4/V
 JVlRAshOg11ARRb7g/0HhIn7BmcvVZHIwB4m8kW7frogHgr8K8r+ujO/wYSz9RnVsinR
 E34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837960; x=1780442760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UMlcGnSZx5EiIzcBNAG9ysoM5RpgN6KoG1NhJToEetg=;
 b=EGW4vhlnpQ9dNAHcMpQYVWfp0yzdrCABOvSj6w4H0PcZjm/TbE4ae2pE6hXH6BcRmk
 u4q+jIuqnGgtTlnIf47mTqvSdO3mCrngNXlqzGTIUzJBYKFuIXKK4lIdiCLDXEAWQ4Sl
 ssJ1BYMghs+zpUWR1FC5TSwRpUS1piQA1JMmIMeNxMZl6Aq/pg/t/Hddgq18vCRuNGGO
 OognEUE7iaq1j3nacH1L9QjayWs/zqmlD6PV9AtUQwe/nJksjtVdDC72eVKF+grQ7Vdd
 cliipTD70SZsN8N4bJaV0g48rvgmJVACXkZK3Kb2fqzZXBC/sE3tO2v7e+Fa49+SehfS
 6xJQ==
X-Gm-Message-State: AOJu0YyUj9Zh9THo8x4YUqoWPoVh2t030GNXZYjhObCL4iccf2qJAV5a
 qNp1UA+8/bnEfh9/4isAX8WLydjwNNY6CDoB6RXAcAAq/M1PXwleAY7hiZMlJFBh8ylpX8qQ6Tf
 iFFoQ
X-Gm-Gg: Acq92OHtdRFajebIfPWesxrwo4dj38iHhkAa4S2k5cAx/SiXHeIoz10wr1iTT9OuFD+
 coyeR6eapnBNWDHv6vAR0c2sx6wSiAHov1px8sHAUWCR69rP06Of8mxn18RuEuRHghD5pqs2Myq
 BvrqOHuP5O/vcFkGay9ASO3f20QnIP02eo66ts/uow7ossMoYI3fRhKKCtulVV9YMs9opKjSgB1
 bwm90NemnCI7wtOu9p9PaRB6urIVh6dpt/EwjOBHG7awgwSecjolXK6ZvRIq/iKME13sntGSAzk
 R1bgOE0SC/osPivX5j6VauAorzdfycDluZ9lYavoVBOIfd0CjZ3A3GYTQbytq4OZOC/yXTmtuoR
 ANYYhBzrlwajiEPW1llF8grUSjMOhgds7TOADfQC488tS5//E17JB4feezhJNjpRZ2BKp39i5WL
 K5qT2Nc+9wLZjtFQ0Zbj3dPdaZkEOA2G8AUHJGgKJ0v9P5eEdilMYtUi/bvJlkxaRbB/0MDUhgi
 0eQdHoMLEU=
X-Received: by 2002:a05:7300:72cd:b0:2fc:9aa8:83da with SMTP id
 5a478bee46e88-304491db909mr10446971eec.29.1779837959777; 
 Tue, 26 May 2026 16:25:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:25:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v4 13/27] bus/dpaa: replace rte_atomic16 with stdatomic
Date: Tue, 26 May 2026 16:24:03 -0700
Message-ID: <20260526232542.620966-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

