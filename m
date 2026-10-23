Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA64606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dkOTbIc5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25F2540659;
	Fri, 23 Oct 2026 15:51:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3884F40276
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:51:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792763503; x=1824299503;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=W7ICZOqDyutN+8RImVnjVaLlfQn0R4dXofWc5JO7jfw=;
 b=dkOTbIc5oAjdsD1SDgplqSVIafnSl3l7Vcg9r9pP8vtrdMKIn/pWJzAE
 OuxyzBa3hDB3VakWdXGxezp9S9MjwrsFGxl9WZAvS4PvXUwnXzDtsSimy
 RGNor1rtwWnG39W/XpBTiPdQnNTGb+EsS1nRGBo7mSU2j+fvfES73AQkW
 0ncCF9Pgeewpim19ZCNeJ9auk1GYELWg0fea5T3lBZsBJTrgI5Xam73q+
 u4b/WHe12+SQoECUb/Fd37KUSExa6rTlJscygzrBh6Jj98isZzciop+nF
 Wjr9lXUjENUulD3B1LXQK6mlWG0pavI0b/YTaxDukMK3M1EPMkJPQjYn4 Q==;
X-CSE-ConnectionGUID: +9xNX2+7TV2geQZ5sVXV6g==
X-CSE-MsgGUID: fclu+QakRvWczKq7oMzbDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1408335"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1408335"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:51:42 -0700
X-CSE-ConnectionGUID: jpcTKR7aRuObEfHqR4Sysw==
X-CSE-MsgGUID: Rsi2VhOIS5+TtECLOVzTjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4139840"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 23 Oct 2026 06:51:41 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Ray Kinsella <mdr@ashroe.eu>, David Marchand <david.marchand@redhat.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v4 1/8] interrupts: fix size of duplicated instance
Date: Fri, 23 Oct 2026 14:51:31 +0100
Message-ID: <5766e02ea3243de1f63eb68efc210719f11815b6.1792763492.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <af76b0050fa71836d9663515f5efd66c8c910061.1792748199.git.anatoly.burakov@intel.com>
References: <af76b0050fa71836d9663515f5efd66c8c910061.1792748199.git.anatoly.burakov@intel.com>
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

A duplicated interrupt handle is allocated with the default event array
size, but the source may have been grown with rte_intr_event_list_update()
when the device has more vectors than the default. The duplicate then
reports the default nb_intr and its arrays are too small for the source
contents.

Grow the duplicate to the size of the source before copying.

Fixes: b7c984291611 ("interrupts: add allocator and accessors")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_interrupts.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
index 6368ef17714..4520ff59bd7 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -115,17 +115,25 @@ struct rte_intr_handle *rte_intr_instance_dup(const struct rte_intr_handle *src)
 	}
 
 	intr_handle = rte_intr_instance_alloc(src->alloc_flags);
-	if (intr_handle != NULL) {
-		intr_handle->fd = src->fd;
-		intr_handle->dev_fd = src->dev_fd;
-		intr_handle->type = src->type;
-		intr_handle->max_intr = src->max_intr;
-		intr_handle->nb_efd = src->nb_efd;
-		intr_handle->efd_counter_size = src->efd_counter_size;
-		memcpy(intr_handle->efds, src->efds, src->nb_intr);
-		memcpy(intr_handle->elist, src->elist, src->nb_intr);
+	if (intr_handle == NULL)
+		return NULL;
+
+	/* The source may have been grown beyond the default array size. */
+	if (src->nb_intr > intr_handle->nb_intr &&
+			rte_intr_event_list_update(intr_handle, src->nb_intr) != 0) {
+		rte_intr_instance_free(intr_handle);
+		return NULL;
 	}
 
+	intr_handle->fd = src->fd;
+	intr_handle->dev_fd = src->dev_fd;
+	intr_handle->type = src->type;
+	intr_handle->max_intr = src->max_intr;
+	intr_handle->nb_efd = src->nb_efd;
+	intr_handle->efd_counter_size = src->efd_counter_size;
+	memcpy(intr_handle->efds, src->efds, src->nb_intr);
+	memcpy(intr_handle->elist, src->elist, src->nb_intr);
+
 	return intr_handle;
 }
 
-- 
2.52.0

