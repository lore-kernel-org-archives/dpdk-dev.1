Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854AF606A31F
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k63iITji
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DA5F40B8C;
	Fri, 23 Oct 2026 15:51:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 016BA40276
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:51:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792763504; x=1824299504;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lDvuLiB+ipses+Fl96CVScAjWYmbKkEH8POB5fTdTyQ=;
 b=k63iITji2HtIp4A2pvu1+ejIV5SwHUA6ULx9mEgXcx8Qjxb6Fv6hFJmf
 Xu1HIwOfkWln4HK08wxJQDXXg2R1K+mcSflw3k11VeucJe90yyg6KBnDT
 4dk8g+oZLeH6OEqBXtXHEfhhGrw++XKsawf6pvp0r0doiBxBtF8wVDYA/
 4PHuJrazu5D9WcUFMMX1EJmEPJy1arAwJc8tQZ8OwOZK+ZZAjF4J2vnCj
 6giC3pwvNwXfBVhp6BIdqG3xB2a3gQaaxEfXTdgfLadDFZA+Oh1oouyR/
 stXllcbiwTypEEDNxFxAKs5qBmssLIZMaVERI98qclx6DHmJimfr/GX2j w==;
X-CSE-ConnectionGUID: ZwyReYckRMGLPParwanIDA==
X-CSE-MsgGUID: hTBENX+4SVyL780kBQS+8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1408340"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1408340"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:51:44 -0700
X-CSE-ConnectionGUID: z+452R7VRA680kkR/iIYzw==
X-CSE-MsgGUID: zMRIj4kBQ0eVlF4tfwR+iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4139845"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 23 Oct 2026 06:51:43 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Ray Kinsella <mdr@ashroe.eu>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v4 2/8] interrupts: fix event arrays copy on instance
 duplication
Date: Fri, 23 Oct 2026 14:51:32 +0100
Message-ID: <8e863c1aa5d265fa27560dd27ba61858c217ff3d.1792763492.git.anatoly.burakov@intel.com>
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

