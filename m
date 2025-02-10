Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA6FC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 17:45:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4D11427BF;
	Mon, 10 Feb 2025 18:45:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B142340FB5
 for <dev@dpdk.org>; Mon, 10 Feb 2025 18:45:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739209506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BYGOtZk5gInNo94eDZdmSXUrCSOJXqovcrGk73RYl8U=;
 b=F/qvvNvXlTwL3ZKX57NHL/NKjHcWHNR9UCmKzSXQkW/5xtJPcuhEqU4O1TWC/ffkDbeBsy
 tE7xViP8hRLDO3+1UEL3+6/Zox4vQRQVXJ04c6jzmhGE1tl42jyw1LPvReh5x4jy6C7PQK
 t6AtQn0Ji53oELXS5/6lJa1mp/yZkIU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-99Efgqh_N6mhh75jc-eMCg-1; Mon,
 10 Feb 2025 12:45:00 -0500
X-MC-Unique: 99Efgqh_N6mhh75jc-eMCg-1
X-Mimecast-MFC-AGG-ID: 99Efgqh_N6mhh75jc-eMCg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02CA41AB1F1E; Mon, 10 Feb 2025 17:44:55 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53A1A19560A3; Mon, 10 Feb 2025 17:44:52 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, fengchengwen@huawei.com,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 4/6] trace: support dumping binary inside a struct
Date: Mon, 10 Feb 2025 18:44:20 +0100
Message-ID: <20250210174424.3364021-5-david.marchand@redhat.com>
In-Reply-To: <20250210174424.3364021-1-david.marchand@redhat.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mjIf8l1SxL-3wGxxz7gQEvsz-aHNY4B_xg2Eg0Nfe9Q_1739209499
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

Make it possible to dump any point of a structure by accepting & and ()
in the CTF metadata.
Update dmadev traces accordingly.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- split this change out of patch 2, as it required updating CTF metadata
  fixup,

---
 lib/dmadev/rte_dmadev_trace.h         | 8 ++------
 lib/eal/common/eal_common_trace_ctf.c | 3 +++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
index be089c065c..c5e4babe15 100644
--- a/lib/dmadev/rte_dmadev_trace.h
+++ b/lib/dmadev/rte_dmadev_trace.h
@@ -86,18 +86,14 @@ RTE_TRACE_POINT(
 	int src_port_type = conf->src_port.port_type;
 	int dst_port_type = conf->dst_port.port_type;
 	int direction = conf->direction;
-	uint64_t src_pcie_cfg;
-	uint64_t dst_pcie_cfg;
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(vchan);
 	rte_trace_point_emit_int(direction);
 	rte_trace_point_emit_u16(conf->nb_desc);
 	rte_trace_point_emit_int(src_port_type);
-	memcpy(&src_pcie_cfg, &conf->src_port.pcie, sizeof(uint64_t));
-	rte_trace_point_emit_u64(src_pcie_cfg);
-	memcpy(&dst_pcie_cfg, &conf->dst_port.pcie, sizeof(uint64_t));
+	rte_trace_point_emit_blob(&conf->src_port.pcie, sizeof(uint64_t));
 	rte_trace_point_emit_int(dst_port_type);
-	rte_trace_point_emit_u64(dst_pcie_cfg);
+	rte_trace_point_emit_blob(&conf->dst_port.pcie, sizeof(uint64_t));
 	rte_trace_point_emit_ptr(conf->auto_free.m2d.pool);
 	rte_trace_point_emit_int(ret);
 )
diff --git a/lib/eal/common/eal_common_trace_ctf.c b/lib/eal/common/eal_common_trace_ctf.c
index 6bc8bb9036..d9b307e076 100644
--- a/lib/eal/common/eal_common_trace_ctf.c
+++ b/lib/eal/common/eal_common_trace_ctf.c
@@ -378,6 +378,9 @@ char *trace_metadata_fixup_field(const char *field)
 		"->",
 		"*",
 		" ",
+		"&",
+		"(",
+		")",
 	};
 	const char *ctf_reserved_words[] = {
 		"align",
-- 
2.48.1

