Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A67FC44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:01:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45FB84028B;
	Fri, 17 Jul 2026 11:01:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 434614028A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:01:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784278897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HZ6pcZVsBZTqGsU7MfYHflvtATT1v9b1IYhnnKV+dTA=;
 b=XQfiOt72AOYvMIWW1JH3ukccNcd/YrXrDIUttm29WGd4cocP94ld3gWZxXypdkXLquHRW1
 an1hN8QVsiJ4PMEZPzi1zRB25L56M/KF/1FAM1x7dXayPs2MIJcQbiQqHbgnLoeJnReBEE
 Q70at2MA27Njauox37WVn1ZEFMOqmaM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-5_jcyBqGN-WnnUeU2BFHSw-1; Fri,
 17 Jul 2026 05:01:36 -0400
X-MC-Unique: 5_jcyBqGN-WnnUeU2BFHSw-1
X-Mimecast-MFC-AGG-ID: 5_jcyBqGN-WnnUeU2BFHSw_1784278895
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BC0718007F0
 for <dev@dpdk.org>; Fri, 17 Jul 2026 09:01:35 +0000 (UTC)
Received: from ringo.redhat.com (unknown [10.44.33.106])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CDC0D71; Fri, 17 Jul 2026 09:01:34 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk] doc: announce rte_graph ABI changes for 26.11
Date: Fri, 17 Jul 2026 11:01:22 +0200
Message-ID: <20260717090121.1859773-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mtyRFb-ffJudugS8pj02dzgQbbqvJQSFOLRqrpZveNI_1784278895
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

The graph library internal scheduling will change from a circular
buffer to a topological bitmap. This affects struct rte_graph and
struct rte_node layouts.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 doc/guides/rel_notes/deprecation.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index f5c12cc74762..6183f33b893a 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -61,6 +61,13 @@ Deprecation Notices
 * mempool: The object array in ``struct rte_mempool_cache`` is oversize by factor two,
   and will be reduced to ``RTE_MEMPOOL_CACHE_MAX_SIZE`` in DPDK 26.11.
 
+* graph: The internal scheduling mechanism of ``struct rte_graph`` will change
+  in DPDK 26.11. The circular buffer fields (``head``, ``tail``, ``cir_mask``,
+  ``cir_start``) will be replaced with a topological bitmap scheduler.
+  A new field will be added to ``struct rte_node`` for the scheduling order.
+  The graph walk functions will process nodes in topological order using bitmap
+  scanning instead of the circular buffer.
+
 * lib: will fix extending some enum/define breaking the ABI. There are multiple
   samples in DPDK that enum/define terminated with a ``.*MAX.*`` value which is
   used by iterators, and arrays holding these values are sized with this
-- 
2.55.0

