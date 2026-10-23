Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CDC606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c3IH0Sn6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EAFD40DCA;
	Fri, 23 Oct 2026 15:51:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9018A40B90
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:51:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792763508; x=1824299508;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JHEiERNdoVIdFpsMzJFuWWBoQXywHLh+PiSl31tLUy0=;
 b=c3IH0Sn6YfGgZ6UxXqshi4F1izIwv0qXC/9+N69rUvyiG1D2ddnLPLIP
 zdhVuhg7C5JRerquLlJC3ou2SGZBaJtoPT8EpXY8a4oayqeSIEgmUcTuk
 h7ZVDignasBnsHRqazG2FvutMf8PcReCxLELPqmHVaAONJki+/myVmOmj
 g2TIZ3pHW3uq6/OB4A3VRpTk1lq+wg+6AtkDLbDOm+b8sqgWMv4UrlUpn
 aIAjdxRgAiY7lJdPT2ttPkFtyAC9837afL4CwlyJIbSYAV1G3hXKknBuR
 L+1crLS+DGqsLmEsZL4WNjvvjyh0xX9zxDfeODShZkEsCeZsE3K4Gs6Ey A==;
X-CSE-ConnectionGUID: iX9WQ8W6QH2ste29CPkZWw==
X-CSE-MsgGUID: e2r8si7VTQ+m2+uJDLCDlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1408351"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1408351"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:51:47 -0700
X-CSE-ConnectionGUID: CI69MUquSu6nbmQbXunbiA==
X-CSE-MsgGUID: fDGxCJgxSM668xbrxFumAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4139865"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 23 Oct 2026 06:51:46 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v4 5/8] eal/linux: fix leaked FD warnings for interrupt sources
Date: Fri, 23 Oct 2026 14:51:35 +0100
Message-ID: <2c54767b62d9e59f2f2111efc437af7cf040742e.1792763492.git.anatoly.burakov@intel.com>
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

An interrupt source keeps a private copy of the interrupt handle it was
registered with. The copy inherits the handle FD, the device FD and the
event FDs but owns none of them: they are closed by whoever set up the
original handle.

Since the leaked FD warning was added, freeing a source after its last
callback is unregistered reports the handle FD and device FD as leaked,
for every device on close and again for every VFIO device at EAL cleanup.

Clear all FD references in the copy before freeing it.

Fixes: d770ee9caed0 ("interrupts: warn on leaked FDs")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/linux/eal_interrupts.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 410b6d66c45..aadb7b84a22 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -95,6 +95,25 @@ static struct rte_intr_source_list intr_sources;
 /* interrupt handling thread */
 static rte_thread_t intr_thread;
 
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
 /* VFIO interrupts */
 #define IRQ_SET_BUF_LEN  (sizeof(struct vfio_irq_set) + sizeof(int))
 /* irq set buffer length for queue interrupts and LSC interrupt */
@@ -666,8 +685,7 @@ rte_intr_callback_unregister(const struct rte_intr_handle *intr_handle,
 		/* all callbacks for that source are removed. */
 		if (TAILQ_EMPTY(&src->callbacks)) {
 			TAILQ_REMOVE(&intr_sources, src, next);
-			rte_intr_instance_free(src->intr_handle);
-			free(src);
+			eal_intr_source_free(src);
 		}
 	}
 
@@ -922,8 +940,7 @@ eal_intr_source_remove_and_free(struct rte_intr_source *src)
 	}
 
 	/* Free the interrupt source */
-	rte_intr_instance_free(src->intr_handle);
-	free(src);
+	eal_intr_source_free(src);
 }
 
 static int
@@ -1067,8 +1084,7 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 		/* all callbacks for that source are removed. */
 		if (TAILQ_EMPTY(&src->callbacks)) {
 			TAILQ_REMOVE(&intr_sources, src, next);
-			rte_intr_instance_free(src->intr_handle);
-			free(src);
+			eal_intr_source_free(src);
 		}
 
 		/* notify the pipe fd waited by epoll_wait to rebuild the wait list */
-- 
2.52.0

