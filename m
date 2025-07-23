Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28562C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 16:50:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 771EE40F1A;
	Wed, 23 Jul 2025 18:50:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B4E7A40F16
 for <dev@dpdk.org>; Wed, 23 Jul 2025 18:50:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753289432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2CgBSS+N1PSITRJGKERDCWzjY7jc9UA8sJ/meHbb1CI=;
 b=U5GrOBw3VxYeqeY25a6Ku9CsRD5z5pqQkmIb0uR/OkSBZhj1baVWh4t9Pkq7Rs9mYNMGvK
 GGErpXLd46dcShJ9quWngMXLoK908OnCDuJ93KXawprSI1SL0QFmNIznvTlRdsDhonbmWK
 z7/4vMpAK1+tMqp9NWRO98Td5BmhGok=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-K_ATO4FkPDaBRLk_95w4pg-1; Wed,
 23 Jul 2025 12:50:29 -0400
X-MC-Unique: K_ATO4FkPDaBRLk_95w4pg-1
X-Mimecast-MFC-AGG-ID: K_ATO4FkPDaBRLk_95w4pg_1753289428
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EE27180034E; Wed, 23 Jul 2025 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.165])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E21BF18004AD; Wed, 23 Jul 2025 16:50:25 +0000 (UTC)
From: Christophe Fontaine <cfontain@redhat.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Cc: dev@dpdk.org,
	Christophe Fontaine <cfontain@redhat.com>
Subject: [PATCH 1/2] graph: allow non EAL Thread for pipeline mode
Date: Wed, 23 Jul 2025 18:50:00 +0200
Message-ID: <20250723165001.11162-2-cfontain@redhat.com>
In-Reply-To: <20250723165001.11162-1-cfontain@redhat.com>
References: <20250723165001.11162-1-cfontain@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u5p4Hc9eLyWQOXK8UZtF9ppN3SXw_IpGBkgTq6LTEzM_1753289428
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

rte_graph_model_mcore_dispatch_core_bind relied on
rte_lcore_is_enabled.
Yet, "rte_lcore_is_enabled" only checks for EAL threads, which forbids
external threads (NON EAL) to run a part of the graph.

Verify if the lcore role is not "ROLE_OFF", and return relevant
error code otherwise.

Signed-off-by: Christophe Fontaine <cfontain@redhat.com>
---
 lib/graph/graph.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/graph/graph.c b/lib/graph/graph.c
index 0975bd8d49..146d0a12b4 100644
--- a/lib/graph/graph.c
+++ b/lib/graph/graph.c
@@ -340,17 +340,22 @@ rte_graph_model_mcore_dispatch_core_bind(rte_graph_t id, int lcore)
 {
 	struct graph *graph;
 
-	if (graph_from_id(id) == NULL)
+	if (graph_from_id(id) == NULL) {
+		rte_errno = ENOENT;
 		goto fail;
-	if (!rte_lcore_is_enabled(lcore))
-		SET_ERR_JMP(ENOLINK, fail, "lcore %d not enabled", lcore);
+	}
+
+	if (rte_lcore_has_role(lcore, ROLE_OFF))
+		SET_ERR_JMP(ENOLINK, fail, "lcore %d is invalid", lcore);
 
 	STAILQ_FOREACH(graph, &graph_list, next)
 		if (graph->id == id)
 			break;
 
-	if (graph->graph->model != RTE_GRAPH_MODEL_MCORE_DISPATCH)
+	if (graph->graph->model != RTE_GRAPH_MODEL_MCORE_DISPATCH) {
+		rte_errno = EPERM;
 		goto fail;
+	}
 
 	graph->lcore_id = lcore;
 	graph->graph->dispatch.lcore_id = graph->lcore_id;
-- 
2.43.5

