Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E68606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UPlXlMIo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CCF340DD3;
	Fri, 23 Oct 2026 15:51:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id C56BA40BA2
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:51:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792763509; x=1824299509;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=aNalLhSET1AdkQPrwZh5t1OUvNJZzjbQpuIKTKZylno=;
 b=UPlXlMIo4tCUCmzgi8k4SJka6UAfgiCyOREkZuHQEf6a9MjEPoddxYf2
 Fd/AqtpyitxXbrxqmx397REqJfx4cC9jnGtI3bi5WOJgSvhjrys6+gtuD
 fo1+4QtD1tYJMPOofnUrpp5yyz/7hOZNVz9c08CDQN3cFkOQR8zNKCV/t
 6mT/yswUeQSUiycJnwHS9BcnpG+JQb+z9jay2baikm4IVGjYidNnIavXp
 i2BHjJcn0uCKcs6vSWZtm6eR3evmdn763Ysk1ylppZ24eezNnOty577uP
 xeW4BBEnL0Vhyhi/HJIbLEjABGwJ+0AWfldjvhjtmCI0C7jdGp+1qd3nF w==;
X-CSE-ConnectionGUID: yJn7v2D2RweiNFxUzI1cVw==
X-CSE-MsgGUID: mEwkni4jRmWupEo6jT0i3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1408354"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1408354"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:51:48 -0700
X-CSE-ConnectionGUID: eIK2yTGmSJyU30iwEUAu5A==
X-CSE-MsgGUID: k30NrRueSa2ihPcfV+fIUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4139872"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 23 Oct 2026 06:51:48 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v4 6/8] eal/freebsd: fix interrupt source handle leak
Date: Fri, 23 Oct 2026 14:51:36 +0100
Message-ID: <66da1e2c1da8af4ac1653b2677b542a43bff7375.1792763492.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5766e02ea3243de1f63eb68efc210719f11815b6.1792763492.git.anatoly.burakov@intel.com>
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

