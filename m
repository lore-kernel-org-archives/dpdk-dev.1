Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58882606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lBqFrLVr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E352C4067B;
	Fri, 23 Oct 2026 15:39:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3281440268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:39:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792762766; x=1824298766;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=EgAoCFJUJvPxPhDqJW0j/MdttX3bEoGzK7+mvbvdKfo=;
 b=lBqFrLVrnOQLxQQAaUaPmT+K+JuDkw4aRgnVHiafoFC+jwbB7hdGaqCK
 OaJCFm5AGFC55TGp4e7pvbWraC/7uwOEsZCL+aCCdWQ62AIVfUr54/D4O
 dgH+ypJMUf21TLLUYMPiZBjbU8MSrCuAotlQhb5sprYhLJdub2C6cWl5h
 /vqmhbLNMNZaW40Ezn7onoQrMxYnffNaFC+VRxUqi42TTOuOA/vu7hAJq
 frloM0zcxDdz1kzMtaZ0ZUM2fWS5tlBU8ILffFmTp6SnTPpzl/GDrDE/V
 WULDQ3fQHaZdBilMy0SWlRHCNmuPb3WPwiD3k5UHJNCRM8TILYWJf1gaG A==;
X-CSE-ConnectionGUID: txv9PbZMQEWwaa2EKNRVlA==
X-CSE-MsgGUID: E8sBX36eQOinxMTd4i5+zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1537427"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1537427"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:39:25 -0700
X-CSE-ConnectionGUID: 1HbNCe01Rmq8FgHSlLBbBQ==
X-CSE-MsgGUID: ioKj0pPySbKJc6Ybd8+aLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3586586"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 23 Oct 2026 06:39:24 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Cunming Liang <cunming.liang@intel.com>
Subject: [PATCH v3 3/8] eal/linux: fix closing of event FDs not owned by EAL
Date: Fri, 23 Oct 2026 14:39:10 +0100
Message-ID: <114fb88b2991c0e88b11d46b671d858c9e6cefdd.1792762746.git.anatoly.burakov@intel.com>
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

