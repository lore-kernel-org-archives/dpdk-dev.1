Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD6FCC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:02:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A10DE40DD3;
	Wed, 14 Oct 2026 17:01:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DB55440B9E
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:01:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UY8B811Kppe09begrYUpM1Tx2f/aCIRDefBOUPjqA/8=;
 b=NtDMAQ9hJI1bjZUPcFsrtIg9j8Qx3L6pQIclmv1A2eFDr9uDIbU9oP9s4GIo5L+RC2w22o
 YmNmKeXSl4QSOw7J76frFso3PX6s6feZhNbCl2Eq2qLkDJLNiNgDLbNDtg4FV80l6U242a
 izw9wCQvX1z+ABHLZuDDiPB0eqi7xcM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-Asa67dN-OhWNWDnE1X3BTQ-1; Wed,
 14 Oct 2026 15:01:12 +0000
X-MC-Unique: Asa67dN-OhWNWDnE1X3BTQ-1
X-Mimecast-MFC-AGG-ID: Asa67dN-OhWNWDnE1X3BTQ_1791990071
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 485331955F6F; Wed, 14 Oct 2026 15:01:11 +0000 (UTC)
Received: from max-p1.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBD0A1800446; Wed, 14 Oct 2026 15:01:09 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, stable@dpdk.org,
 m'te'a physical <physicalmtea@gmail.com>,
 Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH 12/14] vhost: fix inflight descriptor table overflow
Date: Wed, 14 Oct 2026 17:00:47 +0200
Message-ID: <20261014150049.2540538-12-maxime.coquelin@redhat.com>
In-Reply-To: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
References: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Loy7DAARNSIcNhF3oi7Dq1ctKMmT1UmdY4SgnLggtoI_1791990071
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

Add bounds checking against inflight table size in split and packed
ring inflight descriptor APIs. The inflight table is sized from
queue_size received in VHOST_USER_SET_INFLIGHT_FD, but the guest can
later resize the virtqueue larger via SET_VRING_NUM. Existing checks
only validated against vq->size, not the inflight table's desc_num.

A malicious guest could desynchronize these sizes and publish avail
entries with head indices valid for the enlarged virtqueue but out
of bounds for the inflight descriptor table, causing heap corruption.

CVE-2026-86565
Bugzilla ID: 2008

Cc: stable@dpdk.org

Reported-by: m'te'a physical <physicalmtea@gmail.com>
Acked-by: Kevin Traynor <ktraynor@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/vhost.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index 2d694d586e..918e50ed43 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -1149,6 +1149,9 @@ rte_vhost_set_inflight_desc_split(int vid, uint16_t vring_idx,
 	if (unlikely(idx >= vq->size))
 		return -1;
 
+	if (unlikely(idx >= vq->inflight_split->desc_num))
+		return -1;
+
 	vq->inflight_split->desc[idx].counter = vq->global_counter++;
 	vq->inflight_split->desc[idx].inflight = 1;
 	return 0;
@@ -1196,6 +1199,9 @@ rte_vhost_set_inflight_desc_packed(int vid, uint16_t vring_idx,
 	if (unlikely(old_free_head >= vq->size))
 		return -1;
 
+	if (unlikely(old_free_head >= inflight_info->desc_num))
+		return -1;
+
 	free_head = old_free_head;
 
 	/* init header descriptor */
@@ -1255,6 +1261,9 @@ rte_vhost_clr_inflight_desc_split(int vid, uint16_t vring_idx,
 	if (unlikely(idx >= vq->size))
 		return -1;
 
+	if (unlikely(idx >= vq->inflight_split->desc_num))
+		return -1;
+
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
 	vq->inflight_split->desc[idx].inflight = 0;
@@ -1299,6 +1308,9 @@ rte_vhost_clr_inflight_desc_packed(int vid, uint16_t vring_idx,
 	if (unlikely(head >= vq->size))
 		return -1;
 
+	if (unlikely(head >= inflight_info->desc_num))
+		return -1;
+
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
 	inflight_info->desc[head].inflight = 0;
@@ -1383,10 +1395,16 @@ rte_vhost_set_last_inflight_io_packed(int vid, uint16_t vring_idx,
 	if (unlikely(head >= vq->size))
 		return -1;
 
+	if (unlikely(head >= inflight_info->desc_num))
+		return -1;
+
 	last = inflight_info->desc[head].last;
 	if (unlikely(last >= vq->size))
 		return -1;
 
+	if (unlikely(last >= inflight_info->desc_num))
+		return -1;
+
 	inflight_info->desc[last].next = inflight_info->free_head;
 	inflight_info->free_head = head;
 	inflight_info->used_idx += inflight_info->desc[head].num;
-- 
2.56.0

