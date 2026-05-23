Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BEECD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 20:00:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C11840A87;
	Sat, 23 May 2026 21:59:02 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 45D8140A6B
 for <dev@dpdk.org>; Sat, 23 May 2026 21:58:56 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-3044857f09aso3352165eec.1
 for <dev@dpdk.org>; Sat, 23 May 2026 12:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566335;
 x=1780171135; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMlcGnSZx5EiIzcBNAG9ysoM5RpgN6KoG1NhJToEetg=;
 b=Njya46et4zS1RUtT6c+3lb6MzLoCG/VVzfIrx347mG393gpFXnANOHFFibtK4gNEhu
 PBc3DsuRPa2I+NIg3vP8QtquHLDefCHu+H4JQ1PEaEKAbg9KV97GhaIFRdvAHy519luf
 5LwHMiV8tvfnFHgDYYF9t+Y3FYnBoLM9rMTfvwN5LWTC9gNLtqz7BYZTA43zapuo9bcY
 Xoc+ECGtEm9rclWvp+bhMOgMQKQeRmt96FAHsHI5NWbWGsP9epKKTvFW89rgIjEaSnBd
 SEIVWr+BlFLYnkES2RUqPQDH84QmvVERX0CaOwpygRYpVz3ObDU7PhrbFYHW//CoN4fE
 ZXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566335; x=1780171135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UMlcGnSZx5EiIzcBNAG9ysoM5RpgN6KoG1NhJToEetg=;
 b=b+ejPcxojgCT3IROn1W2nQXzOZSE6NkzBkxXXXDAn4q8azMuqjVQSu7yXFCDamw62B
 MzH1rwUxldfEU7JCfMO6cXc6Iwm7YMU8KxAzWMgIJ0FEPfSuWcKggKt3TGRFXVg1+35v
 CAPGTJ4joFmSj5EFbdgQbMAgqEhp6k5l7PJvgLb8sVzrxGeJCPwgykSxXliokkjqjTle
 HNFdWYTmhcSRH1Xwn1IYGkOfrzItiPumNnVjlfHK7bmdOKaTcFC6BBIs6q2lqlV3w6P4
 cyN03UVxHs5g5RHcKEXZyq3b77luaCbASyUfMGk3Bxt9TUmQzor8b3wj6HTpTZ1Dc6U9
 q2Jg==
X-Gm-Message-State: AOJu0YxxIBFX6dkJA1oAD+/JJHAP/7UIG2c9GtaawgfkQ6dj1BHLGy8n
 G7lAcW4b+c0SJFG+lxCv9YRdpVfVe1UMfOmmb+G5nGdIezcmjKUFwP9RG41pytWU/epAyWKxV65
 9pU7J
X-Gm-Gg: Acq92OEy9o9CACBP8S+USdSlkwQibw2+7EccegVxuNwDLQQFSXRvOlraRWi6U754KZL
 0VZueMp8zofZRUKAKN6uSaP6eChPOyKHSMEYEYORPBlApbl91DoRUHRo4/3a7B8qes4WHISarVP
 yLbB1Jd46g99ZdEiVUQacswh0i9carrqCIi7NUV1QOuk7ecrLPocp6eo59XKcrPU992Tzj7vVKD
 SukdjWc70vtBadthkHxOlTmUl982DY0+QAWwe/PM8TldBTVp/LQIjwvFn6zCLWg9rPmi45GvSY0
 qiA9PYIGsYHDvNgnyW2RGwBfwO++akcf5UfTCXZq/ANyNPAfXZGoDBnbHl39o3vh82SjxscJ+Q3
 P3JlAEAjhSrBeXzX+KDlaH/C8PV2AXCW+E76Jk52n8eZvXsFL2AA1sFj0FOvRBnfIpyzbWoE7cY
 JBJyP4RL20+3BAhfuzDSLhr/Jxh9v+MTApNF2X3CKPmigSy2j51d8llPmrGsSivmFtNST6ktJz4
 Qp2HBQ0vUo=
X-Received: by 2002:a05:7301:10c2:b0:2e1:e3e6:2909 with SMTP id
 5a478bee46e88-30448f4aaaemr4077848eec.9.1779566335328; 
 Sat, 23 May 2026 12:58:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:58:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v3 13/27] bus/dpaa: replace rte_atomic16 with stdatomic
Date: Sat, 23 May 2026 12:56:27 -0700
Message-ID: <20260523195839.454952-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

