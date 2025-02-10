Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC47C0219B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 17:45:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF88040DD2;
	Mon, 10 Feb 2025 18:45:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9454340A6F
 for <dev@dpdk.org>; Mon, 10 Feb 2025 18:45:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739209503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKWLufDFl8Uywks6cSxaakNz6KKCqI5vcyU2zp65xbU=;
 b=OJJkM1lX1cElZ1LVYrrziAjVqlYF/YLHro/6T3YJfxDhX0YFuRROo4HroVa+nukjFfesmH
 ppRs+2yTPxd+zpy7n13eiDOCX//lB65F85nvSg4dFG6jAp/Pbd791gI0bSB8MXAvUjshYK
 ZVBvH8M5MYJKyHzrOExjlXsQlkAUYqU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-v8Y2nYraMwi4rMerxWzNAw-1; Mon,
 10 Feb 2025 12:45:01 -0500
X-MC-Unique: v8Y2nYraMwi4rMerxWzNAw-1
X-Mimecast-MFC-AGG-ID: v8Y2nYraMwi4rMerxWzNAw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24BE21955D7C; Mon, 10 Feb 2025 17:45:00 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B32B19560A3; Mon, 10 Feb 2025 17:44:57 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, fengchengwen@huawei.com,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 5/6] dmadev: avoid copies in tracepoints
Date: Mon, 10 Feb 2025 18:44:21 +0100
Message-ID: <20250210174424.3364021-6-david.marchand@redhat.com>
In-Reply-To: <20250210174424.3364021-1-david.marchand@redhat.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y8sZ90UuJ3EkrHfwEZFzqJyx7D7F7u_xLV1H_-adJsA_1739209500
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

No need to copy values in intermediate variables.
Just use the right trace point emitters.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- split this change into multiple changes,
  only kept trivial parts in this patch,

---
 lib/dmadev/rte_dmadev_trace.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
index c5e4babe15..ddf60b9649 100644
--- a/lib/dmadev/rte_dmadev_trace.h
+++ b/lib/dmadev/rte_dmadev_trace.h
@@ -46,11 +46,10 @@ RTE_TRACE_POINT(
 	const struct rte_dma_conf __dev_conf = {0};
 	dev_conf = &__dev_conf;
 #endif /* _RTE_TRACE_POINT_REGISTER_H_ */
-	int enable_silent = (int)dev_conf->enable_silent;
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(dev_conf->nb_vchans);
 	rte_trace_point_emit_u16(dev_conf->priority);
-	rte_trace_point_emit_int(enable_silent);
+	rte_trace_point_emit_u8(dev_conf->enable_silent);
 	rte_trace_point_emit_int(ret);
 )
 
@@ -83,16 +82,13 @@ RTE_TRACE_POINT(
 	const struct rte_dma_vchan_conf __conf = {0};
 	conf = &__conf;
 #endif /* _RTE_TRACE_POINT_REGISTER_H_ */
-	int src_port_type = conf->src_port.port_type;
-	int dst_port_type = conf->dst_port.port_type;
-	int direction = conf->direction;
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(vchan);
-	rte_trace_point_emit_int(direction);
+	rte_trace_point_emit_int(conf->direction);
 	rte_trace_point_emit_u16(conf->nb_desc);
-	rte_trace_point_emit_int(src_port_type);
+	rte_trace_point_emit_int(conf->src_port.port_type);
 	rte_trace_point_emit_blob(&conf->src_port.pcie, sizeof(uint64_t));
-	rte_trace_point_emit_int(dst_port_type);
+	rte_trace_point_emit_int(conf->dst_port.port_type);
 	rte_trace_point_emit_blob(&conf->dst_port.pcie, sizeof(uint64_t));
 	rte_trace_point_emit_ptr(conf->auto_free.m2d.pool);
 	rte_trace_point_emit_int(ret);
-- 
2.48.1

