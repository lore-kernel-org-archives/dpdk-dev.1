Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F44E606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jhbLv1oz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CB54406BB;
	Fri, 23 Oct 2026 15:39:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3E4D640693
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792762770; x=1824298770;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=aNalLhSET1AdkQPrwZh5t1OUvNJZzjbQpuIKTKZylno=;
 b=jhbLv1ozSz3HxfmCWPUTezB7RM2MxBs4ne9LpR+QMqGPCcwx+p+HVN4j
 8xbaIcod8K6ngs6lm3/nwBz/tQS4Di1C90ePsfbzqpg0C93b5q/KVoMmW
 4CjNb4uKU3uM5StYZCA9xb3kVHQDXs+17IVAe6zJlbt/ZbAc/28Av566e
 /3pA2S8jrkLip997/ecdmqU0eRtVQY7nAvrZbJ2YcSeGUyigOu8HtGVEl
 21ugjrjJwEPtnhPgRH8V99Rg71pb1vNXvrQDdD7lIGATFhIVNLffjudEU
 Epp0KirzXZl2Q9EyB89ucAMRkRqyHrATZAHchQc7V+qEkuK88978uwLfz g==;
X-CSE-ConnectionGUID: 9FgBHVxoSoiZcM3oPlfXAg==
X-CSE-MsgGUID: V8osJBoBQAqUmWhrthWiJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1537441"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1537441"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:39:29 -0700
X-CSE-ConnectionGUID: 7NP2OfH2Scqa2sHNSnkm3Q==
X-CSE-MsgGUID: 1Wv/X7w7QRmOkwJhM9focA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3586615"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 23 Oct 2026 06:39:28 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v3 6/8] eal/freebsd: fix interrupt source handle leak
Date: Fri, 23 Oct 2026 14:39:13 +0100
Message-ID: <629b6b3e2202d9314972a40aaa633c126aa1fb2f.1792762746.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <e9eba9cd731a90f6e487a76bfe3bee84b1cdc3de.1792762746.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Each interrupt source keeps a private copy of the interrupt handle it was
registered with, but the copy is never freed when the source is removed,
leaking the handle and its event arrays.

Free the copy with the source. The copy owns none of the file
descriptors it references, so clear them first.

Fixes: bbbac4cd6ed2 ("interrupts: remove direct access to interrupt handle")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/freebsd/eal_interrupts.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/lib/eal/freebsd/eal_interrupts.c b/lib/eal/freebsd/eal_interrupts.c
index bb2bc529f2e..09ba76b378f 100644
--- a/lib/eal/freebsd/eal_interrupts.c
+++ b/lib/eal/freebsd/eal_interrupts.c
@@ -57,6 +57,25 @@ static rte_thread_t intr_thread;
 
 static volatile int kq = -1;
 
+/*
+ * An interrupt source holds a copy of the handle it was registered with
+ * and owns none of the file descriptors. Clear the references before
+ * freeing the copy so they are not reported as leaks.
+ */
+static void
+eal_intr_source_free(struct rte_intr_source *src)
+{
+	struct rte_intr_handle *intr_handle = src->intr_handle;
+	int i;
+
+	rte_intr_fd_set(intr_handle, -1);
+	rte_intr_dev_fd_set(intr_handle, -1);
+	for (i = 0; i < rte_intr_nb_intr_get(intr_handle); i++)
+		rte_intr_efds_index_set(intr_handle, i, -1);
+	rte_intr_instance_free(intr_handle);
+	free(src);
+}
+
 static int
 intr_source_to_kevent(const struct rte_intr_handle *ih, struct kevent *ke)
 {
@@ -204,7 +223,7 @@ rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 			TAILQ_REMOVE(&(src->callbacks), callback, next);
 		if (TAILQ_EMPTY(&(src->callbacks))) {
 			TAILQ_REMOVE(&intr_sources, src, next);
-			free(src);
+			eal_intr_source_free(src);
 		}
 	}
 	free(callback);
@@ -347,7 +366,7 @@ rte_intr_callback_unregister(const struct rte_intr_handle *intr_handle,
 		/* all callbacks for that source are removed. */
 		if (TAILQ_EMPTY(&src->callbacks)) {
 			TAILQ_REMOVE(&intr_sources, src, next);
-			free(src);
+			eal_intr_source_free(src);
 		}
 	}
 out:
@@ -592,7 +611,7 @@ eal_intr_process_interrupts(struct kevent *events, int nfds)
 		/* all callbacks for that source are removed. */
 		if (TAILQ_EMPTY(&src->callbacks)) {
 			TAILQ_REMOVE(&intr_sources, src, next);
-			free(src);
+			eal_intr_source_free(src);
 		}
 
 		rte_spinlock_unlock(&intr_lock);
-- 
2.52.0

