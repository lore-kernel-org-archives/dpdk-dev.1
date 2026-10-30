Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E323606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L2lUjqqK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E15440E1E;
	Fri, 30 Oct 2026 19:43:13 +0100 (CET)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mails.dpdk.org (Postfix) with ESMTPS id 7590340DD1
 for <dev@dpdk.org>; Fri, 30 Oct 2026 19:43:11 +0100 (CET)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e987ec84afso9407375ad.3
 for <dev@dpdk.org>; Fri, 30 Oct 2026 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793385790; x=1793990590; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sru5Zsjh98rLg6AlVqZjG+A/iWi8eQw0d80JZzVNkuc=;
 b=L2lUjqqKLdb/6D41krXilgsdvhumhkG1ixCgxaP+lhVFcZTInaKm0GYQiJYcJxuUw4
 QCx077bFR/g3uc+P2winvc+obiRjNW7EFoJcoiE8YqYsMQbd8PjtXa+viOuf3QszlH52
 mmZ+zdXLvnFv0wqZ4T3og2vfAbBkh99V6vzt3jxovrXox0wbwqd4csIO6QqNeklyycSb
 zCzwCF3lozZTbo0XrR4n0NIuU1XwkPcn/UINj6UzuTfdKXAiZFLVf9TdtGI4uWHfxyU9
 fDMITDppQKa95l6AEiou1/W2Eq9nElnWBUlGpwIPTT3SI/TzDjH6EDHxeyovFRffrgyY
 Ec4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793385790; x=1793990590;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sru5Zsjh98rLg6AlVqZjG+A/iWi8eQw0d80JZzVNkuc=;
 b=L3BYYLBNcHh4aPLVsgA6j/zXuhO/hBW+4ogWEFWX3DCsOUMFKHUpfdTXJpLhnDDHZJ
 pV7SzwJYP4dzz8RGcq6sJlhLQqsVkDk/yEDTj7/v+NcHPXpzfNSfziDQHIcoHkOxV3w9
 45V49RnQzNGhJpttaMa2u2sRgCyhg65VmvzpNEdeYcTA9qL0OjCkwJKiHXYcz+x6DqpI
 zUz9dGQhtEyxSFR3AwsNcYk6dUyT0zrkn0kO99KyHsneYWhtuBwZZLZJXK2A+D41t5Z2
 F3090bDY3DaeQWHf9bNKfkeq8s3pnt/hha0/7F51UqDS/x+914ODHBHUxPQqMdbX+w2Q
 zp1Q==
X-Gm-Message-State: AFq9FYKvby27r8MsNct1qRyRHrLmiwO26ieD3OKa+d3JdlecqjBS74UL
 6IQL1sPvqxQTipSX39kPppnImlfQKFors+d6hnwil+2pnyZmJCh6GIrMqmyZBAoimTiodb38JKZ
 hRPjOwa39dGGAaA==
X-Received: from plha18.prod.google.com ([2002:a17:902:ecd2:b0:2e8:8642:f035])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f691:b0:2e2:d39f:182f with SMTP id
 d9443c01a7336-2eb3643d489mr33291055ad.28.1793385789787; 
 Fri, 30 Oct 2026 11:43:09 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:43:01 -0700
In-Reply-To: <20261030184304.508282-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030184304.508282-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030184304.508282-3-joshwash@google.com>
Subject: [PATCH v2 2/4] net/gve: account for multi-mbuf headers when
 validating TSO
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>, Ankit Garg <nktgrg@google.com>, 
 Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DQ queue format allows TSO headers to span up to 3 descriptors.
Before this patch, the TSO descriptor limit check logic assumed that
headers would only be in a single descriptor. This can cause under
counting when processing descriptors, which can lead to hardware
failures.

As an example: suppose a header spans 3 mbufs. In that case, 3
descriptors will need to be reserved per TSO segment. Now imagine that
there is a TSO segment whose payload spans 8 buffers. The previous logic
would add one for the headers, making a total of 9, which would be
considered valid. In actuality, since the header spans 3 descriptors
themselves, there are actually 11 descriptors for the one wire segment,
which is invalid.

Compute the number of descriptors needed for the TSO header, reject
mbufs in which the headers span more than 3 buffers, and count the
number of descriptors needed against the descriptor budget per wire
packet/TSO segment.

Also, relax the strong restriction that all headers be in the same
buffer, as this is not a requirement by the hardware.

Fixes: be8f0eb81f98 ("net/gve: fix DQO TSO descriptor limit")
Fixes: 6b0452f76bf0 ("net/gve: enforce DQO Tx packet length limits")
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
---
Depends-on: series-39707 ("net/gve: fix DQO Tx queue stalls")
---
 drivers/net/gve/base/gve_desc_dqo.h |  1 +
 drivers/net/gve/gve_tx_dqo.c        | 38 ++++++++++++++++++++++-------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base/gve_desc_dqo.h
index 53e394f01c..b7d8b27d68 100644
--- a/drivers/net/gve/base/gve_desc_dqo.h
+++ b/drivers/net/gve/base/gve_desc_dqo.h
@@ -45,6 +45,7 @@ GVE_CHECK_STRUCT_LEN(16, gve_tx_pkt_desc_dqo);
 
 /* Maximum number of data descriptors allowed per packet, or per-TSO segment. */
 #define GVE_TX_MAX_DATA_DESCS 10
+#define GVE_TX_MAX_HEADER_DESCS_TSO 3
 
 /* Min gap between tail and head to avoid cacheline overlap */
 #define GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP 4
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 3a20109a5d..00a4ea9d27 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -138,7 +138,7 @@ gve_tx_validate_pkt(const struct rte_mbuf *tx_pkt, bool is_tso)
 	 */
 	headlen = tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_len;
 	if (tx_pkt->l4_len == 0 || headlen > GVE_TX_MAX_HDR_SIZE_DQO ||
-	    tx_pkt->data_len < headlen || tx_pkt->pkt_len <= headlen)
+	    tx_pkt->pkt_len <= headlen)
 		return false;
 
 	return tx_pkt->pkt_len - headlen <= GVE_TX_MAX_TSO_LEN_DQO &&
@@ -167,20 +167,41 @@ static inline bool
 gve_tx_validate_descs(const struct gve_tx_queue *txq, struct rte_mbuf *tx_pkt,
 		      uint16_t nb_descs, bool is_tso)
 {
+	int headlen = tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_len;
+	int num_descs, seg_offset, mbuf_len;
+	int tso_segsz = tx_pkt->tso_segsz;
+	int header_remain = headlen;
+	uint16_t num_header_descs;
+
 	if (nb_descs > gve_tx_max_pkt_descs(txq))
 		return false;
 
 	if (!is_tso)
 		return nb_descs <= GVE_TX_MAX_DATA_DESCS;
 
-	int tso_segsz = tx_pkt->tso_segsz;
-	int num_descs, seg_offset, mbuf_len;
-	int headlen = tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_len;
+	/* Process headers. Headers can span up to 3 descriptors. */
+	if (headlen == 0)
+		return false;
+
+	num_header_descs = 1;
+	while (tx_pkt != NULL) {
+		if (header_remain <= tx_pkt->data_len)
+			break;
+
+		if (likely(tx_pkt->data_len > 0)) {
+			header_remain -= tx_pkt->data_len;
+			num_header_descs++;
+		}
 
-	/* Headers will be split into their own buffer. */
-	num_descs = 1;
+		tx_pkt = tx_pkt->next;
+	}
+
+	if (tx_pkt == NULL || num_header_descs > GVE_TX_MAX_HEADER_DESCS_TSO)
+		return false;
+
+	num_descs = num_header_descs;
 	seg_offset = 0;
-	mbuf_len = tx_pkt->data_len - headlen;
+	mbuf_len = tx_pkt->data_len - header_remain;
 
 	while (tx_pkt) {
 		if (!mbuf_len)
@@ -207,7 +228,7 @@ gve_tx_validate_descs(const struct gve_tx_queue *txq, struct rte_mbuf *tx_pkt,
 			 * segment in this mbuf is divided between two
 			 * descriptors, both must be counted.
 			 */
-			num_descs = 1 + !!(seg_offset) +
+			num_descs = num_header_descs + !!(seg_offset) +
 				(mbuf_remain < seg_offset && mbuf_remain);
 		} else {
 			seg_offset += mbuf_len;
@@ -220,7 +241,6 @@ gve_tx_validate_descs(const struct gve_tx_queue *txq, struct rte_mbuf *tx_pkt,
 			mbuf_len = tx_pkt->data_len;
 	}
 
-
 	return true;
 }
 
-- 
2.56.0.317.g454f8302e1-goog

