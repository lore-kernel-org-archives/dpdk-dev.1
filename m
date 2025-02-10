Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53888C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 21:32:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F5974064A;
	Mon, 10 Feb 2025 22:32:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 75BF8402EF
 for <dev@dpdk.org>; Mon, 10 Feb 2025 22:32:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739223151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPTSY6YKBqQViy0TdwKooTmGBB+gbJ2pN/Jp1dQ1ZrA=;
 b=fGZYZU1ZJ5fZgKgKLYvascLjM1WWXCfydj9wC1jMUv2Xm24XF3fGw6m+GnZ+5olqtoIMAZ
 +uS6czyaiLmAuLkH/8tcD+iYWYCnHNeJLeR6xC7C8RsIWNYjl9ikwbSMEyEkjVDr3rX3Ss
 6TiXKAO6WlcW8/PSPzCQWOj0lybGWnI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-eSDDifvlONqW0vJwCcrmDw-1; Mon,
 10 Feb 2025 16:32:28 -0500
X-MC-Unique: eSDDifvlONqW0vJwCcrmDw-1
X-Mimecast-MFC-AGG-ID: eSDDifvlONqW0vJwCcrmDw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 664091800360; Mon, 10 Feb 2025 21:32:26 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97D993001D11; Mon, 10 Feb 2025 21:32:21 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, frode.nordahl@canonical.com,
 mattias.ronnblom@ericsson.com, anatoly.burakov@intel.com, stable@dpdk.org,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 3/5] power: defer lcore variable allocation
Date: Mon, 10 Feb 2025 22:31:56 +0100
Message-ID: <20250210213158.4165701-4-david.marchand@redhat.com>
In-Reply-To: <20250210213158.4165701-1-david.marchand@redhat.com>
References: <20241205175754.1673888-1-david.marchand@redhat.com>
 <20250210213158.4165701-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z-7EC3E7dIzd5WJVNfluORXYcBLtE4rgE_mmZOdQ-Nw_1739223147
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
rte_power_ethdev_pmgmt_queue_*() public symbols.

Defer the unconditional lcore variable allocation in those symbols.

Fixes: 130643319579 ("power: keep per-lcore state in lcore variable")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Frode Nordahl <frode.nordahl@canonical.com>
---
Changes since v1:
- moved some unrelated comment on queue_id,
- renamed initialisation helper,

---
 lib/power/rte_power_pmd_mgmt.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/lib/power/rte_power_pmd_mgmt.c b/lib/power/rte_power_pmd_mgmt.c
index a2fff3b765..369ce3c354 100644
--- a/lib/power/rte_power_pmd_mgmt.c
+++ b/lib/power/rte_power_pmd_mgmt.c
@@ -72,6 +72,22 @@ struct __rte_cache_aligned pmd_core_cfg {
 };
 static RTE_LCORE_VAR_HANDLE(struct pmd_core_cfg, lcore_cfgs);
 
+static void
+init_lcore_cfgs(void)
+{
+	struct pmd_core_cfg *lcore_cfg;
+	unsigned int lcore_id;
+
+	if (lcore_cfgs != NULL)
+		return;
+
+	RTE_LCORE_VAR_ALLOC(lcore_cfgs);
+
+	/* initialize all tailqs */
+	RTE_LCORE_VAR_FOREACH(lcore_id, lcore_cfg, lcore_cfgs)
+		TAILQ_INIT(&lcore_cfg->head);
+}
+
 static inline bool
 queue_equal(const union queue *l, const union queue *r)
 {
@@ -517,6 +533,7 @@ rte_power_ethdev_pmgmt_queue_enable(unsigned int lcore_id, uint16_t port_id,
 		goto end;
 	}
 
+	init_lcore_cfgs();
 	lcore_cfg = RTE_LCORE_VAR_LCORE(lcore_id, lcore_cfgs);
 
 	/* check if other queues are stopped as well */
@@ -618,6 +635,8 @@ rte_power_ethdev_pmgmt_queue_disable(unsigned int lcore_id,
 	}
 
 	/* no need to check queue id as wrong queue id would not be enabled */
+
+	init_lcore_cfgs();
 	lcore_cfg = RTE_LCORE_VAR_LCORE(lcore_id, lcore_cfgs);
 
 	/* check if other queues are stopped as well */
@@ -768,16 +787,8 @@ rte_power_pmd_mgmt_get_scaling_freq_max(unsigned int lcore)
 }
 
 RTE_INIT(rte_power_ethdev_pmgmt_init) {
-	unsigned int lcore_id;
-	struct pmd_core_cfg *lcore_cfg;
 	int i;
 
-	RTE_LCORE_VAR_ALLOC(lcore_cfgs);
-
-	/* initialize all tailqs */
-	RTE_LCORE_VAR_FOREACH(lcore_id, lcore_cfg, lcore_cfgs)
-		TAILQ_INIT(&lcore_cfg->head);
-
 	/* initialize config defaults */
 	emptypoll_max = 512;
 	pause_duration = 1;
-- 
2.48.1

