Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85198C0219D
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 21:32:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BA8640654;
	Mon, 10 Feb 2025 22:32:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2D9BA40651
 for <dev@dpdk.org>; Mon, 10 Feb 2025 22:32:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739223166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QlGqv3WBgMF3m/HFtRlKy0KSuSIxhUqyTVElmXY/0Sg=;
 b=X8SWOHUOOEhkQf3ZqL9/IOtBPybh2XzscK+2BL2K/PyYiLEvKRxOKlzZ10nfdxrVM/Esv6
 QFQYplNzrRQxbsYiCCBdmsgT1X9QgeFNQ1KW/dayiwZ090eZ6EAW0Q+RsClTDIlzDzzCTH
 BqCqVpfixojsp1S/Vk+tmtovbSFJyvY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-0pZoq-ZYNv-3yaMEDzFwAQ-1; Mon,
 10 Feb 2025 16:32:41 -0500
X-MC-Unique: 0pZoq-ZYNv-3yaMEDzFwAQ-1
X-Mimecast-MFC-AGG-ID: 0pZoq-ZYNv-3yaMEDzFwAQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A00E61800980; Mon, 10 Feb 2025 21:32:39 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1C611800360; Mon, 10 Feb 2025 21:32:35 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, frode.nordahl@canonical.com,
 mattias.ronnblom@ericsson.com, anatoly.burakov@intel.com, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 5/5] eal/x86: defer power intrinsics variable allocation
Date: Mon, 10 Feb 2025 22:31:58 +0100
Message-ID: <20250210213158.4165701-6-david.marchand@redhat.com>
In-Reply-To: <20250210213158.4165701-1-david.marchand@redhat.com>
References: <20241205175754.1673888-1-david.marchand@redhat.com>
 <20250210213158.4165701-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P7RyN6is2SQ7GVLPupNH__O9CK3nCYLYZ-OK9aXlWDI_1739223159
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The lcore variable in this code unit is only used through
rte_power_monitor*() public symbols.

Defer the unconditional lcore variable allocation in those symbols.

Fixes: 18b5049ab4fe ("eal/x86: keep power intrinsics state in lcore variable")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Frode Nordahl <frode.nordahl@canonical.com>
---
Changes since v1:
- added an initialiser helper,

---
 lib/eal/x86/rte_power_intrinsics.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/lib/eal/x86/rte_power_intrinsics.c b/lib/eal/x86/rte_power_intrinsics.c
index e4cb913590..f7d558153e 100644
--- a/lib/eal/x86/rte_power_intrinsics.c
+++ b/lib/eal/x86/rte_power_intrinsics.c
@@ -22,7 +22,13 @@ struct power_wait_status {
 
 RTE_LCORE_VAR_HANDLE(struct power_wait_status, wait_status);
 
-RTE_LCORE_VAR_INIT(wait_status);
+static void
+init_wait_status(void)
+{
+	if (wait_status != NULL)
+		return;
+	RTE_LCORE_VAR_ALLOC(wait_status);
+}
 
 /*
  * This function uses UMONITOR/UMWAIT instructions and will enter C0.2 state.
@@ -177,6 +183,7 @@ rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 	if (pmc->fn == NULL)
 		return -EINVAL;
 
+	init_wait_status();
 	s = RTE_LCORE_VAR_LCORE(lcore_id, wait_status);
 
 	/* update sleep address */
@@ -269,6 +276,7 @@ rte_power_monitor_wakeup(const unsigned int lcore_id)
 	if (lcore_id >= RTE_MAX_LCORE)
 		return -EINVAL;
 
+	init_wait_status();
 	s = RTE_LCORE_VAR_LCORE(lcore_id, wait_status);
 
 	/*
@@ -308,7 +316,7 @@ int
 rte_power_monitor_multi(const struct rte_power_monitor_cond pmc[],
 		const uint32_t num, const uint64_t tsc_timestamp)
 {
-	struct power_wait_status *s = RTE_LCORE_VAR(wait_status);
+	struct power_wait_status *s;
 	uint32_t i, rc;
 
 	/* check if supported */
@@ -318,6 +326,9 @@ rte_power_monitor_multi(const struct rte_power_monitor_cond pmc[],
 	if (pmc == NULL || num == 0)
 		return -EINVAL;
 
+	init_wait_status();
+	s = RTE_LCORE_VAR(wait_status);
+
 	/* we are already inside transaction region, return */
 	if (rte_xtest() != 0)
 		return 0;
-- 
2.48.1

