Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A48C282D2
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 16:07:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EA62402E7;
	Tue,  4 Mar 2025 17:07:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4439840395
 for <dev@dpdk.org>; Tue,  4 Mar 2025 17:07:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741104420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=073OGjUdqEb9uVnDuayPamWfOM5l6gHKQexUiR7uIn0=;
 b=H2G2rrdx2/okCKlo+L1VPyriUoZiE8KBZ3yGosMTKgFe4YJxbqohHIICJEgvCT5gkFuV26
 vyDoBOfpyB/g2WdUe9yNi63HhWVujUjevhq7vVWLSCA2lggH3CdMka6NUqLtk00BSShby+
 Zg7GDNAfpbD7pQkh+Hm8rfvjZIzLE4s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-i2Yv13B_NeyTVf7vE8h1TQ-1; Tue,
 04 Mar 2025 11:06:50 -0500
X-MC-Unique: i2Yv13B_NeyTVf7vE8h1TQ-1
X-Mimecast-MFC-AGG-ID: i2Yv13B_NeyTVf7vE8h1TQ_1741104409
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48DF3180098F; Tue,  4 Mar 2025 16:06:49 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.74])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5BB819560AB; Tue,  4 Mar 2025 16:06:46 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 2/5] dmadev: avoid copies in tracepoints
Date: Tue,  4 Mar 2025 17:06:30 +0100
Message-ID: <20250304160633.385185-3-david.marchand@redhat.com>
In-Reply-To: <20250304160633.385185-1-david.marchand@redhat.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250304160633.385185-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bXs610VZN40XIe2Xejcx4ve8B65DAEt7pRsNQ_gnfd8_1741104409
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
Use the right trace point emitters.
Update the pcie struct to avoid aliasing warning.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v3:
- added anonymous union around pcie struct (which triggered an abidiff
  warning that needs waiving) and kept original call to
  rte_trace_point_emit_u64,

Changes since v2:
- split this change into multiple changes,
  only kept trivial parts in this patch,

---
 devtools/libabigail.abignore  |  5 +++++
 lib/dmadev/rte_dmadev.h       | 29 ++++++++++++++++-------------
 lib/dmadev/rte_dmadev_trace.h | 20 ++++++--------------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore
index ce501632b3..88aa1ec981 100644
--- a/devtools/libabigail.abignore
+++ b/devtools/libabigail.abignore
@@ -36,3 +36,8 @@
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ; Temporary exceptions till next major ABI version ;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+[suppress_type]
+        name = rte_dma_port_param
+        type_kind = struct
+        has_size_change = no
+        has_data_member = {pcie}
diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 2f9304a9db..26f9d4b095 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -523,19 +523,22 @@ struct rte_dma_port_param {
 		 * and capabilities.
 		 */
 		__extension__
-		struct {
-			uint64_t coreid : 4; /**< PCIe core id used. */
-			uint64_t pfid : 8; /**< PF id used. */
-			uint64_t vfen : 1; /**< VF enable bit. */
-			uint64_t vfid : 16; /**< VF id used. */
-			/** The pasid filed in TLP packet. */
-			uint64_t pasid : 20;
-			/** The attributes filed in TLP packet. */
-			uint64_t attr : 3;
-			/** The processing hint filed in TLP packet. */
-			uint64_t ph : 2;
-			/** The steering tag filed in TLP packet. */
-			uint64_t st : 16;
+		union {
+			struct {
+				uint64_t coreid : 4; /**< PCIe core id used. */
+				uint64_t pfid : 8; /**< PF id used. */
+				uint64_t vfen : 1; /**< VF enable bit. */
+				uint64_t vfid : 16; /**< VF id used. */
+				/** The pasid filed in TLP packet. */
+				uint64_t pasid : 20;
+				/** The attributes filed in TLP packet. */
+				uint64_t attr : 3;
+				/** The processing hint filed in TLP packet. */
+				uint64_t ph : 2;
+				/** The steering tag filed in TLP packet. */
+				uint64_t st : 16;
+			};
+			uint64_t val;
 		} pcie;
 	};
 	uint64_t reserved[2]; /**< Reserved for future fields. */
diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
index be089c065c..1beb938168 100644
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
 
@@ -83,21 +82,14 @@ RTE_TRACE_POINT(
 	const struct rte_dma_vchan_conf __conf = {0};
 	conf = &__conf;
 #endif /* _RTE_TRACE_POINT_REGISTER_H_ */
-	int src_port_type = conf->src_port.port_type;
-	int dst_port_type = conf->dst_port.port_type;
-	int direction = conf->direction;
-	uint64_t src_pcie_cfg;
-	uint64_t dst_pcie_cfg;
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(vchan);
-	rte_trace_point_emit_int(direction);
+	rte_trace_point_emit_int(conf->direction);
 	rte_trace_point_emit_u16(conf->nb_desc);
-	rte_trace_point_emit_int(src_port_type);
-	memcpy(&src_pcie_cfg, &conf->src_port.pcie, sizeof(uint64_t));
-	rte_trace_point_emit_u64(src_pcie_cfg);
-	memcpy(&dst_pcie_cfg, &conf->dst_port.pcie, sizeof(uint64_t));
-	rte_trace_point_emit_int(dst_port_type);
-	rte_trace_point_emit_u64(dst_pcie_cfg);
+	rte_trace_point_emit_int(conf->src_port.port_type);
+	rte_trace_point_emit_u64(conf->src_port.pcie.val);
+	rte_trace_point_emit_int(conf->dst_port.port_type);
+	rte_trace_point_emit_u64(conf->dst_port.pcie.val);
 	rte_trace_point_emit_ptr(conf->auto_free.m2d.pool);
 	rte_trace_point_emit_int(ret);
 )
-- 
2.48.1

