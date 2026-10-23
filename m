Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D436606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nPUBVdYl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAB9940B95;
	Fri, 23 Oct 2026 15:51:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 10AFC406B6
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792763505; x=1824299505;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=EgAoCFJUJvPxPhDqJW0j/MdttX3bEoGzK7+mvbvdKfo=;
 b=nPUBVdYlWrcORPWxBNAPt1lRzdMs1+HF9fz4amk9G2WXZlyQk1lPRsZ8
 rJCW2kI4rc0PH4PgmNDBcysVAgRa5tko4rNbxnC6FMypZTGUrwCZOt6Sb
 s/dbsG+6J43N8gzaqhCShRKyE0xySz6zItJQRMwknt1z9GmqVeFc88FcV
 2eCWlHqvgHzUdWakA6LrmtA6iSqegKpDv0YTXUAZ7xuZxR0EuViAGWeZW
 B8ngYyVsSk8bnVGIsQh3J/d0E8mY+/cG2VfXl2mr4/B67HmWkA3Rz3Kpz
 k2GiuN6g1JoUAtEBs1TWH1rvY1585xCY/LckIbzlEFdgZRrVtYtDVAll/ w==;
X-CSE-ConnectionGUID: yaqz8SyZRACss2Xutoy+ow==
X-CSE-MsgGUID: KsbTYywaT8q3gme8T9uvTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1408346"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1408346"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:51:45 -0700
X-CSE-ConnectionGUID: 67kM5XwHSMSlDoYYOA7BQQ==
X-CSE-MsgGUID: Aurdv2W+TlmgZeV4j/EO6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4139857"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 23 Oct 2026 06:51:44 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Cunming Liang <cunming.liang@intel.com>
Subject: [PATCH v4 3/8] eal/linux: fix closing of event FDs not owned by EAL
Date: Fri, 23 Oct 2026 14:51:33 +0100
Message-ID: <61924e76b67043fb4b19c09bc60acd00ad26681d.1792763492.git.anatoly.burakov@intel.com>
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

rte_intr_efd_disable() decides whether to close the event FDs based on
max_intr being greater than nb_efd. This is a side effect of how
rte_intr_efd_enable() fills the handle for VFIO MSI-X, where an extra
slot is reserved for the misc interrupt, and only indirectly identifies
the eventfds that EAL created itself.

Any driver filling the event FD array for a VDEV or EXT handle and
setting max_intr the same way gets its descriptors closed by EAL even
though it owns them. The virtio-user driver does exactly this, so its
callfds are closed by rte_intr_efd_disable() and then closed again by
the driver on uninit.

Check the interrupt handle type instead, so that only the eventfds
created by rte_intr_efd_enable() for VFIO MSI-X are closed.

Fixes: b9e0662a931d ("eal/linux: add interrupt API for drivers")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/linux/eal_interrupts.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 4cfaeba7fe0..bdee1dd9777 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -1620,7 +1620,11 @@ rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
 	uint32_t i;
 
 	rte_intr_free_epoll_fd(intr_handle);
-	if (rte_intr_max_intr_get(intr_handle) > rte_intr_nb_efd_get(intr_handle)) {
+	/* Only eventfds created by rte_intr_efd_enable() for MSI-X are owned
+	 * by the handle. In other modes the entries reference fds owned by
+	 * the device or the driver and must not be closed here.
+	 */
+	if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX) {
 		for (i = 0; i < (uint32_t)rte_intr_nb_efd_get(intr_handle); i++)
 			close(rte_intr_efds_index_get(intr_handle, i));
 	}
-- 
2.52.0

