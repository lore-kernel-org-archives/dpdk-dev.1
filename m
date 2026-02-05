Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF28E9129A
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 09:27:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ABF440E2B;
	Thu,  5 Feb 2026 10:27:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B5F4940E28
 for <dev@dpdk.org>; Thu,  5 Feb 2026 10:27:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770283633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2fgsMwu2cIGKK0LjensJaBo2oTn+/sn1oouTj+wj04=;
 b=ivEkpn8mg7wFVYkGB4APg1R7K4NSavI/PkNJf0ezoTYinUjWH6vKjg1eysbYFJMZidDtml
 L4c9ijRGYZvBXtsZO0X8ogo86T6CiGRRYtNadDrgBHcdtDuConyiJ6yOuGu1TeMvJeC2l/
 QTUt3iCt52/0SZy2Nqv1GTOSSJ67T0Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-9Z8mTClCMReNIkGX4IZTXw-1; Thu,
 05 Feb 2026 04:27:11 -0500
X-MC-Unique: 9Z8mTClCMReNIkGX4IZTXw-1
X-Mimecast-MFC-AGG-ID: 9Z8mTClCMReNIkGX4IZTXw_1770283630
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8C4119560AD; Thu,  5 Feb 2026 09:27:10 +0000 (UTC)
Received: from ringo.home (unknown [10.44.33.219])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF510300DDA1; Thu,  5 Feb 2026 09:27:08 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [RFC PATCH dpdk 1/3] graph: optimize rte_node_enqueue_next to batch
 by edge
Date: Thu,  5 Feb 2026 10:26:34 +0100
Message-ID: <20260205092630.100488-8-rjarry@redhat.com>
In-Reply-To: <20260205092630.100488-6-rjarry@redhat.com>
References: <20260205092630.100488-6-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tZIlGv5gHVLh-pIy9cTkwxyUhtChn2OfZhOe5oII8hk_1770283630
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

Replace the per-object rte_node_enqueue_x1() calls with batched
rte_node_enqueue() calls. The function now tracks runs of consecutive
objects going to the same edge and flushes them in bulk.

When all objects go to the same edge and come from the node's own
buffer (objs == node->objs), use rte_node_next_stream_move() which
swaps pointers instead of copying.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 lib/graph/rte_graph_worker_common.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_worker_common.h
index 4ab53a533e4c..7fda67c07169 100644
--- a/lib/graph/rte_graph_worker_common.h
+++ b/lib/graph/rte_graph_worker_common.h
@@ -432,10 +432,21 @@ static inline void
 rte_node_enqueue_next(struct rte_graph *graph, struct rte_node *node,
 		      rte_edge_t *nexts, void **objs, uint16_t nb_objs)
 {
+	rte_edge_t last = nexts[0];
+	uint16_t run_start = 0;
 	uint16_t i;
 
-	for (i = 0; i < nb_objs; i++)
-		rte_node_enqueue_x1(graph, node, nexts[i], objs[i]);
+	for (i = 1; i < nb_objs; i++) {
+		if (nexts[i] != last) {
+			rte_node_enqueue(graph, node, last, &objs[run_start], i - run_start);
+			run_start = i;
+			last = nexts[i];
+		}
+	}
+	if (run_start == 0 && objs == node->objs)
+		rte_node_next_stream_move(graph, node, last);
+	else
+		rte_node_enqueue(graph, node, last, &objs[run_start], nb_objs - run_start);
 }
 
 /**
-- 
2.52.0

