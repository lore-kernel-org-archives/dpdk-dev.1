Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57268CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 11:09:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E43E40262;
	Tue, 28 Oct 2025 12:09:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8C83E4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 12:09:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761649772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qk0wFARpXqz3nEhdHYTnasM/I8OcvHaIIqZL290l4ZY=;
 b=NEiZOnw5gkZ7scJVfRdEUeKQU1maN14GgVm9r4Cb/K5uGlYtwARKStz392ulnQKLxh4PmD
 +E5M3jHKHMJZBXIToJZ+qdIPHDnr5LikbMJyK/3ov+LeUJE/2apbaKtL49Ue+YzE0KBgQb
 UARl0BFb25qz7qyyvl1gVs+sZC0uweU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-4rJxkt9dNoGHTi7Dz2hHpQ-1; Tue,
 28 Oct 2025 07:09:29 -0400
X-MC-Unique: 4rJxkt9dNoGHTi7Dz2hHpQ-1
X-Mimecast-MFC-AGG-ID: 4rJxkt9dNoGHTi7Dz2hHpQ_1761649767
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8841018001E2; Tue, 28 Oct 2025 11:09:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.228])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 615231955F1B; Tue, 28 Oct 2025 11:09:24 +0000 (UTC)
From: Christophe Fontaine <cfontain@redhat.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Christophe Fontaine <cfontain@redhat.com>
Subject: [PATCH v2] graph: fix xstats description allocation
Date: Tue, 28 Oct 2025 12:09:20 +0100
Message-ID: <20251028110920.16353-1-cfontain@redhat.com>
In-Reply-To: <20251028101333.14776-1-cfontain@redhat.com>
References: <20251028101333.14776-1-cfontain@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sKp0ZpRz-fbXZkxhyjMZMb2gdiEpg0pKjMquWWd_WvU_1761649767
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

Fix the extended stats name allocation size: instead of allocating
RTE_NODE_XSTAT_DESC_SIZE (64 bytes), only sizeof(RTE_NODE_XSTAT_DESC_SIZE)
were allocated for each xstat name.

Fixes: 070db97e017b ("graph: support node xstats")
Signed-off-by: Christophe Fontaine <cfontain@redhat.com>
Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---

Notes:
    v2: add acked-by
        fix sha length

 lib/graph/graph_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
index e0fc8fd25c..b87b5707f7 100644
--- a/lib/graph/graph_stats.c
+++ b/lib/graph/graph_stats.c
@@ -302,7 +302,7 @@ stats_mem_populate(struct rte_graph_cluster_stats *stats,
 				    graph_node->node->name, graph->name);
 
 		cluster->stat.xstat_desc = rte_zmalloc_socket(NULL,
-			sizeof(RTE_NODE_XSTAT_DESC_SIZE) * graph_node->node->xstats->nb_xstats,
+			RTE_NODE_XSTAT_DESC_SIZE * graph_node->node->xstats->nb_xstats,
 			RTE_CACHE_LINE_SIZE, stats->socket_id);
 		if (cluster->stat.xstat_desc == NULL) {
 			rte_free(cluster->stat.xstat_count);
-- 
2.51.0

