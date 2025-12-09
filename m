Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBD5D1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 08:50:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5B3D40689;
	Tue,  9 Dec 2025 09:50:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A5C5140674
 for <dev@dpdk.org>; Tue,  9 Dec 2025 09:50:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765270245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=owIq6nWfXXWoNHnNFUP04kMSqWmatAJzVIVLWe9/X/A=;
 b=VwXTY47EiF3mJGBdyYiFEI7MxaFPkk162qI3LD1EL0GQic27cCoA8C4CoSN8sJ9Xz0CTbJ
 zap4lpWpxTGjF5hE/GkuTXOT5iWH6wdWM4PDMSEpYaFOR3AVdO1Sfw04m1LSdze6fvS6g4
 3qF4EUdkE3stONeqboJepkKcXEGZ+i8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-fwZBcBlzNYms4-ElnvXqqA-1; Tue,
 09 Dec 2025 03:50:42 -0500
X-MC-Unique: fwZBcBlzNYms4-ElnvXqqA-1
X-Mimecast-MFC-AGG-ID: fwZBcBlzNYms4-ElnvXqqA_1765270240
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4A3B180065F; Tue,  9 Dec 2025 08:50:40 +0000 (UTC)
Received: from ringo.home (unknown [10.45.225.153])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D62471800451; Tue,  9 Dec 2025 08:50:38 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH dpdk 1/2] graph: always count objects and calls
Date: Tue,  9 Dec 2025 09:50:30 +0100
Message-ID: <20251209085028.115203-5-rjarry@redhat.com>
In-Reply-To: <20251209085028.115203-4-rjarry@redhat.com>
References: <20251209085028.115203-4-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: grj6oMraX0WSKKkqrDbYG_9AzCw7UY3YB020Cw2r_os_1765270240
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

Accumulate the number of processed objects and the number of times each
node is visited regardless of the compile time value of
RTE_LIBRTE_GRAPH_STATS.

Accumulating these numbers do not bring much overhead when rte_rdtsc()
isn't called.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 lib/graph/rte_graph_worker_common.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_worker_common.h
index 4ab53a533e4c..c87a6796a96e 100644
--- a/lib/graph/rte_graph_worker_common.h
+++ b/lib/graph/rte_graph_worker_common.h
@@ -209,11 +209,11 @@ __rte_node_process(struct rte_graph *graph, struct rte_node *node)
 		start = rte_rdtsc();
 		rc = node->process(graph, node, objs, node->idx);
 		node->total_cycles += rte_rdtsc() - start;
-		node->total_calls++;
-		node->total_objs += rc;
 	} else {
-		node->process(graph, node, objs, node->idx);
+		rc = node->process(graph, node, objs, node->idx);
 	}
+	node->total_calls++;
+	node->total_objs += rc;
 	node->idx = 0;
 }
 
-- 
2.52.0

