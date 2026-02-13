Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65444EDF148
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:35:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C991F40651;
	Fri, 13 Feb 2026 11:35:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5AD95402F1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:35:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770978899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWSVl2qFwQn4ZdamUZ3wVIraNBS57dm+HcYw0L19l/4=;
 b=NRrblEg0wgBY1pg/hJlOrXbcJcvlGAKL5TqtwesG/RIck01GS3fONBDdSpy8Oz+Vh0vZBP
 df712vzOm+lg/BBcdg3SgVCkRlyzCbz/dDn3Vxg7EUJ0ZGEZ2MkTJJB0usi2Me11WL1nxC
 aqlJko3GnBpLIARoqmz/HtlG3G/XBs4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-Jchsc5xhOtmEGteTGQ_BRw-1; Fri,
 13 Feb 2026 05:34:56 -0500
X-MC-Unique: Jchsc5xhOtmEGteTGQ_BRw-1
X-Mimecast-MFC-AGG-ID: Jchsc5xhOtmEGteTGQ_BRw_1770978895
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FC201956089; Fri, 13 Feb 2026 10:34:55 +0000 (UTC)
Received: from ringo.home (unknown [10.45.224.207])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83C3F19560B9; Fri, 13 Feb 2026 10:34:52 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH dpdk v2 1/3] hash: avoid leaking entries on RCU defer queue
 failure
Date: Fri, 13 Feb 2026 11:34:39 +0100
Message-ID: <20260213103441.1505659-2-rjarry@redhat.com>
In-Reply-To: <20260213103441.1505659-1-rjarry@redhat.com>
References: <20260212213313.1376294-5-rjarry@redhat.com>
 <20260213103441.1505659-1-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QdTEcTn0edj2b0WmVSGkO22lM5tJyAgZU94zupYVwtA_1770978895
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

When rte_rcu_qsbr_dq_enqueue() fails in DQ mode, the deleted key slot
is never freed and becomes permanently leaked. Fall back to synchronous
reclamation instead of only logging an error.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 lib/hash/rte_cuckoo_hash.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index da12825c6ed2..8189bde024be 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -1870,18 +1870,15 @@ __rte_hash_del_key_with_hash(const struct rte_hash *h, const void *key,
 		/* Key index where key is stored, adding the first dummy index */
 		rcu_dq_entry.key_idx = ret + 1;
 		rcu_dq_entry.ext_bkt_idx = index;
-		if (h->dq == NULL) {
+		if (h->dq == NULL || rte_rcu_qsbr_dq_enqueue(h->dq, &rcu_dq_entry) != 0) {
 			/* Wait for quiescent state change if using
-			 * RTE_HASH_QSBR_MODE_SYNC
+			 * RTE_HASH_QSBR_MODE_SYNC or if RCU enqueue failed.
 			 */
 			rte_rcu_qsbr_synchronize(h->hash_rcu_cfg->v,
 						 RTE_QSBR_THRID_INVALID);
 			__hash_rcu_qsbr_free_resource((void *)((uintptr_t)h),
 						      &rcu_dq_entry, 1);
-		} else if (h->dq)
-			/* Push into QSBR FIFO if using RTE_HASH_QSBR_MODE_DQ */
-			if (rte_rcu_qsbr_dq_enqueue(h->dq, &rcu_dq_entry) != 0)
-				HASH_LOG(ERR, "Failed to push QSBR FIFO");
+		}
 	}
 	__hash_rw_writer_unlock(h);
 	return ret;
-- 
2.53.0

