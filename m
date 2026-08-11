Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AA7C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:49:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB09E427A1;
	Tue, 11 Aug 2026 19:48:38 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id E83E541141;
 Tue, 11 Aug 2026 19:48:33 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 2B6FAE0F09;
 Tue, 11 Aug 2026 21:48:33 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 2B6FAE0F09
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470513;
 bh=1byUx7AfSjXHWvlP4J34di+n6CtmZ0ipZ5YoqIEdkIQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OlGTQ75abje/l0YvVtFNGYs0kOS6xFzSNZsl+Cw/QHNrbZrwa9IKG68qLZQOi7loI
 KDRdpE/jHMOw7DT+4CU0rk6tSwMVcOVDRUloL5OmqLw/sznx3c0v1Ohr0+NDPQhRDl
 dwscnh56ohPoPkp6hEZaJEW3VGkkQXm011IKFbVORfEtoGywtGDSOhmKNPSGq3RuEI
 +sp4D5SMvmVl7qrs/T7v51exwGziqWPiK5o6Ltqs3cUcpu2oLW6rfPFRKqqHPiQU5A
 BnDre8/B7aA6UYE91eiI2OEbWoTvxlRKTzsCS2jYewktwC1Bk8kQmnE5JL2epaDaBH
 Tp/kqjMQzL5Rw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH 05/14] common/sfc_efx/base: fix filter saved spec handling
Date: Tue, 11 Aug 2026 21:48:12 +0400
Message-ID: <20260811174821.8930-6-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811174821.8930-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
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

From: Andy Moreton <andy.moreton@amd.com>

Code Analysis notes that saved_spec can be NULL when passed into
ef10_filter_add_select_action and ef10_filter_add_execute_action
from ef10_filter_add_internal.

Fix the annotations to show that the saved_spec is optional, and
add NULL checks before dereferencing it.

Fixes: 585c22edb29c ("net/sfc/base: handle manual and auto filter clashes in EF10")
Cc: stable@dpdk.org

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/ef10_filter.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/common/sfc_efx/base/ef10_filter.c b/drivers/common/sfc_efx/base/ef10_filter.c
index 2a10720122..0d69ec5ba8 100644
--- a/drivers/common/sfc_efx/base/ef10_filter.c
+++ b/drivers/common/sfc_efx/base/ef10_filter.c
@@ -690,7 +690,7 @@ ef10_filter_add_lookup_equal_spec(
 
 static			void
 ef10_filter_add_select_action(
-	__in		efx_filter_spec_t *saved_spec,
+	__in_opt	efx_filter_spec_t *saved_spec,
 	__in		efx_filter_spec_t *spec,
 	__out		enum ef10_filter_add_action_e *action,
 	__out		efx_filter_spec_t **overridden_spec)
@@ -752,7 +752,7 @@ ef10_filter_add_select_action(
 static	__checkReturn	efx_rc_t
 ef10_filter_add_execute_action(
 	__in		efx_nic_t *enp,
-	__in		efx_filter_spec_t *saved_spec,
+	__in_opt	efx_filter_spec_t *saved_spec,
 	__in		efx_filter_spec_t *spec,
 	__in		efx_filter_spec_t *overridden_spec,
 	__in		enum ef10_filter_add_action_e action,
@@ -769,7 +769,8 @@ ef10_filter_add_execute_action(
 		goto out_unlock;
 	} else if (action == EF10_FILTER_ADD_STORE) {
 		EFSYS_ASSERT(overridden_spec != NULL);
-		saved_spec->efs_overridden_spec = overridden_spec;
+		if (saved_spec != NULL)
+			saved_spec->efs_overridden_spec = overridden_spec;
 		goto out_unlock;
 	}
 
@@ -806,7 +807,7 @@ ef10_filter_add_execute_action(
 
 	EFSYS_LOCK(enp->en_eslp, state);
 
-	if (action == EF10_FILTER_ADD_REPLACE) {
+	if ((action == EF10_FILTER_ADD_REPLACE) && (saved_spec != NULL)) {
 		/* Update the fields that may differ */
 		saved_spec->efs_priority = spec->efs_priority;
 		saved_spec->efs_flags = spec->efs_flags;
-- 
2.47.3

