Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14A8C0219B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 17:44:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD18D40A75;
	Mon, 10 Feb 2025 18:44:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CA87040A79
 for <dev@dpdk.org>; Mon, 10 Feb 2025 18:44:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739209485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zOIfx0Xg6g/W3Mx/zWjowXGnDFauk6ggnSXUhFeHTsA=;
 b=eTyrV4tiN5c6Yt/43gcFlx7x9wcFzZUF6sPKrkNx3t9Sy2rnU/pnQTqUNLBmoRA8Kxspmh
 v+3Ur/mYI9wpv7uS4Z6ICfhkODVK1hmhq08kf07Bn4OX7VIx8LcM0GlDux8KzyLapZ6gQT
 KEUlWk41vhNngOhJfThx1zOfGrKl3js=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-Rr1Dtm2lOriLmcxPh7RH3w-1; Mon,
 10 Feb 2025 12:44:44 -0500
X-MC-Unique: Rr1Dtm2lOriLmcxPh7RH3w-1
X-Mimecast-MFC-AGG-ID: Rr1Dtm2lOriLmcxPh7RH3w
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D8D81800876; Mon, 10 Feb 2025 17:44:42 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAD171800365; Mon, 10 Feb 2025 17:44:39 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, fengchengwen@huawei.com,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 2/6] trace: support dereferencing arguments
Date: Mon, 10 Feb 2025 18:44:18 +0100
Message-ID: <20250210174424.3364021-3-david.marchand@redhat.com>
In-Reply-To: <20250210174424.3364021-1-david.marchand@redhat.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4vexbFd-Ke3a3ezd03Kz8KKKti0Dbu9c0JMMqCHEcqc_1739209482
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

Rather than use an intermediate variable, allow use of * to dereference
a trace point argument.
Update dmadev traces accordingly (and adjust the emitter type).

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- split this change out of patch 2, as it required updating CTF metadata
  fixup,

---
 lib/dmadev/rte_dmadev_trace_fp.h      | 12 +++------
 lib/eal/common/eal_common_trace_ctf.c | 35 ++++++++++++++++++---------
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/lib/dmadev/rte_dmadev_trace_fp.h b/lib/dmadev/rte_dmadev_trace_fp.h
index f5b96838bc..4950f58cd2 100644
--- a/lib/dmadev/rte_dmadev_trace_fp.h
+++ b/lib/dmadev/rte_dmadev_trace_fp.h
@@ -37,10 +37,9 @@ RTE_TRACE_POINT_FP(
 	enum rte_dma_vchan_status __status = 0;
 	status = &__status;
 #endif /* _RTE_TRACE_POINT_REGISTER_H_ */
-	int vchan_status = *status;
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(vchan);
-	rte_trace_point_emit_int(vchan_status);
+	rte_trace_point_emit_int(*status);
 	rte_trace_point_emit_int(ret);
 )
 
@@ -107,13 +106,11 @@ RTE_TRACE_POINT_FP(
 	last_idx = &__last_idx;
 	has_error = &__has_error;
 #endif /* _RTE_TRACE_POINT_REGISTER_H_ */
-	int has_error_val = *has_error;
-	int last_idx_val = *last_idx;
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(vchan);
 	rte_trace_point_emit_u16(nb_cpls);
-	rte_trace_point_emit_int(last_idx_val);
-	rte_trace_point_emit_int(has_error_val);
+	rte_trace_point_emit_u16(*last_idx);
+	rte_trace_point_emit_u8(*has_error);
 	rte_trace_point_emit_u16(ret);
 )
 
@@ -126,11 +123,10 @@ RTE_TRACE_POINT_FP(
 	uint16_t __last_idx = 0;
 	last_idx = &__last_idx;
 #endif /* _RTE_TRACE_POINT_REGISTER_H_ */
-	int last_idx_val = *last_idx;
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(vchan);
 	rte_trace_point_emit_u16(nb_cpls);
-	rte_trace_point_emit_int(last_idx_val);
+	rte_trace_point_emit_u16(*last_idx);
 	rte_trace_point_emit_ptr(status);
 	rte_trace_point_emit_u16(ret);
 )
diff --git a/lib/eal/common/eal_common_trace_ctf.c b/lib/eal/common/eal_common_trace_ctf.c
index 04c4f71462..3e4228ee7f 100644
--- a/lib/eal/common/eal_common_trace_ctf.c
+++ b/lib/eal/common/eal_common_trace_ctf.c
@@ -373,6 +373,11 @@ rte_trace_metadata_dump(FILE *f)
 
 char *trace_metadata_fixup_field(const char *field)
 {
+	static const char * const tokens[] = {
+		".",
+		"->",
+		"*",
+	};
 	const char *ctf_reserved_words[] = {
 		"align",
 		"event",
@@ -390,23 +395,29 @@ char *trace_metadata_fixup_field(const char *field)
 		return out;
 	}
 
+	for (i = 0; i < RTE_DIM(tokens); i++) {
+		if (strstr(field, tokens[i]) == NULL)
+			continue;
+		goto fixup;
+	}
+
 	/* nothing to replace, return early */
-	if (strstr(field, ".") == NULL && strstr(field, "->") == NULL)
-		return NULL;
+	return NULL;
 
+fixup:
 	out = strdup(field);
 	if (out == NULL)
 		return NULL;
-	p = out;
-	while ((p = strstr(p, ".")) != NULL) {
-		p[0] = '_';
-		p++;
-	}
-	p = out;
-	while ((p = strstr(p, "->")) != NULL) {
-		p[0] = '_';
-		p++;
-		memmove(p, p + 1, strlen(p));
+	for (i = 0; i < RTE_DIM(tokens); i++) {
+		p = out;
+		while ((p = strstr(p, tokens[i])) != NULL) {
+			p[0] = '_';
+			p++;
+			if (strlen(tokens[i]) != 1) {
+				memmove(p, p + (strlen(tokens[i]) - 1),
+					strlen(p) - (strlen(tokens[i]) - 2));
+			}
+		}
 	}
 	return out;
 }
-- 
2.48.1

