Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC94606A321
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NKS55dLh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AE5A4060B;
	Fri, 23 Oct 2026 15:39:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 1EFD440268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792762765; x=1824298765;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lDvuLiB+ipses+Fl96CVScAjWYmbKkEH8POB5fTdTyQ=;
 b=NKS55dLh+D/4d7f/plZVhPoif6lyAUxSkc8GG4kz0KYsAMzjTdT+QQFP
 fRkGzSRFj2w6D4nrxwU50JHUcrg4KRJfaqGblhuxJaE1YbrOGA4eDSOex
 gbQoEX+OhGcLj4pVe9YW7pwpKpQaHIg8vsRz0Isux+JeoUWYduGqiPAqe
 hvQcWLA3SdFMYsBtDkHzh2bIGQ45QjMjKEDqtDT6pMxUudJ39XqpLP5sB
 AM0wcmVv4OPku3P0icDoDUoKVLmHt0R6eqCTppYx8YeiSqzHcydoSjHFj
 8EWZdZw+PbF4m5jx4lrbCHidYM0bgHg0UJQhQuLgF9nZjuteN7asPwvG7 w==;
X-CSE-ConnectionGUID: 2TqJlmjUR4SWXvRidiiaxw==
X-CSE-MsgGUID: tv6QpMZUTq2u8Swp8+GxcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1537423"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1537423"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:39:24 -0700
X-CSE-ConnectionGUID: axgZxYAhRkS6FSIg22GBeA==
X-CSE-MsgGUID: 73gNARy8R9GwJkxn15JXUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3586578"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 23 Oct 2026 06:39:22 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Ray Kinsella <mdr@ashroe.eu>, David Marchand <david.marchand@redhat.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v3 2/8] interrupts: fix event arrays copy on instance
 duplication
Date: Fri, 23 Oct 2026 14:39:09 +0100
Message-ID: <3dbf6def031f8266a795f10a384acf2edd0c7a0e.1792762746.git.anatoly.burakov@intel.com>
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

The event FD and epoll event arrays are copied using the number of
entries as a byte count, so only a fraction of the entries make it
into the duplicate.

Copy the arrays by element size.

Fixes: b7c984291611 ("interrupts: add allocator and accessors")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_interrupts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
index 4520ff59bd7..cf56f967218 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -131,8 +131,8 @@ struct rte_intr_handle *rte_intr_instance_dup(const struct rte_intr_handle *src)
 	intr_handle->max_intr = src->max_intr;
 	intr_handle->nb_efd = src->nb_efd;
 	intr_handle->efd_counter_size = src->efd_counter_size;
-	memcpy(intr_handle->efds, src->efds, src->nb_intr);
-	memcpy(intr_handle->elist, src->elist, src->nb_intr);
+	memcpy(intr_handle->efds, src->efds, src->nb_intr * sizeof(*src->efds));
+	memcpy(intr_handle->elist, src->elist, src->nb_intr * sizeof(*src->elist));
 
 	return intr_handle;
 }
-- 
2.52.0

