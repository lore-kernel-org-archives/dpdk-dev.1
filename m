Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0355EC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 21:32:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C68D40669;
	Mon, 10 Feb 2025 22:32:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B1CC840667
 for <dev@dpdk.org>; Mon, 10 Feb 2025 22:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739223156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/kmHv6mGYUsePSM/iyEKUMEP15GzKk4E3KPaJGGjnkQ=;
 b=hSWXX26zNB+qem0lZWiceybQOmpqPDgWZ4F2faMNPnqm6rH3ILKhaeTmIqZhFne61wTQVD
 pzd+yx2w8t9ykrXMci2XSYkfIKbtarn2ZXfxtaty4m3A3Oeqa2QnkhoOHjH+q2xuPvQYxe
 R++CebkwykQzwbGSGj+S8vgBNkUws4A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-f2aYpLcCObmqLUMFWVMGug-1; Mon,
 10 Feb 2025 16:32:35 -0500
X-MC-Unique: f2aYpLcCObmqLUMFWVMGug-1
X-Mimecast-MFC-AGG-ID: f2aYpLcCObmqLUMFWVMGug
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E2631800980; Mon, 10 Feb 2025 21:32:33 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56D24180035E; Mon, 10 Feb 2025 21:32:29 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, frode.nordahl@canonical.com,
 mattias.ronnblom@ericsson.com, anatoly.burakov@intel.com,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 4/5] power: reduce memory footprint of per-lcore state
Date: Mon, 10 Feb 2025 22:31:57 +0100
Message-ID: <20250210213158.4165701-5-david.marchand@redhat.com>
In-Reply-To: <20250210213158.4165701-1-david.marchand@redhat.com>
References: <20241205175754.1673888-1-david.marchand@redhat.com>
 <20250210213158.4165701-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w8K6t_ZKrgxuc0H34WArnJ0vJsNnR5cMnVdoOx0NiKM_1739223153
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

Now that the per-lcore state was moved into a lcore variable,
there is no reason to align a per-lcore state on a cache line to avoid
false sharing.
Remove this alignment and save a few bytes.

Fixes: 130643319579 ("power: keep per-lcore state in lcore variable")

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Frode Nordahl <frode.nordahl@canonical.com>
---
 lib/power/rte_power_pmd_mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/power/rte_power_pmd_mgmt.c b/lib/power/rte_power_pmd_mgmt.c
index 369ce3c354..8ec925bd65 100644
--- a/lib/power/rte_power_pmd_mgmt.c
+++ b/lib/power/rte_power_pmd_mgmt.c
@@ -56,7 +56,7 @@ struct queue_list_entry {
 	const struct rte_eth_rxtx_callback *cb;
 };
 
-struct __rte_cache_aligned pmd_core_cfg {
+struct pmd_core_cfg {
 	TAILQ_HEAD(queue_list_head, queue_list_entry) head;
 	/**< List of queues associated with this lcore */
 	size_t n_queues;
-- 
2.48.1

