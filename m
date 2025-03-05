Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CF9C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 18:37:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ED3A4060C;
	Wed,  5 Mar 2025 19:37:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id EFB0140275;
 Wed,  5 Mar 2025 19:37:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741199825; x=1772735825;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kgjkAgQ52cpH18lEHq9J7v1rN1GiimqmIIfLKR8Ftak=;
 b=lyrPAQdVT7IieMhSb3v7oe4pkzsA/OpKN2Z661xTKFM3LBRLnaE6DROh
 b/9WdNNQb/OiQREEnmDDUeGAViFhtkyWySTVjuLVHkq2lObH4caGMdaC1
 b5WBLhXUVcbOZC0xYzDZ6Wshb/B9W8V3nK+pyDnTbxI4g7IXLUsiDcm0P
 WdBVhB9rHpBQkJBvWfEgf7rLNquTSJvPu5ppyNOr9lj9+Y05Cc9P6Ez0C
 JKMDlerxom6QubfqH9w+IN8+fExqPWsPr8cuLQ5XjbVzUAv6Y8N409Zyy
 VaiIi4unqPkDm/liCZvykEeZE25o5G8VpWIBZXMAHhx6zlNxx0BsPYUYJ A==;
X-CSE-ConnectionGUID: xsRgGpfwRn2qmahWYV6nqA==
X-CSE-MsgGUID: TpyQwLliT8edLHnI0h4lGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29763254"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="29763254"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 10:37:02 -0800
X-CSE-ConnectionGUID: X8IUFGktQQKWURjz7LblcQ==
X-CSE-MsgGUID: oEqQYdAKTpeRkBdehe8qkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119699889"
Received: from spr-npg-bds1-eec2.sn.intel.com (HELO spr-npg-bds1-eec2..)
 ([10.233.181.123])
 by orviesa008.jf.intel.com with ESMTP; 05 Mar 2025 10:37:02 -0800
From: Nicolas Chautru <nicolas.chautru@intel.com>
To: dev@dpdk.org,
	maxime.coquelin@redhat.com
Cc: hernan.vargas@intel.com, Nicolas Chautru <nicolas.chautru@intel.com>,
 stable@dpdk.org
Subject: [PATCH v1 1/1] baseband/acc: fix queue setup failure clean up
Date: Wed,  5 Mar 2025 10:27:16 -0800
Message-Id: <20250305182716.773937-2-nicolas.chautru@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305182716.773937-1-nicolas.chautru@intel.com>
References: <20250305182716.773937-1-nicolas.chautru@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Incomplete clean up for vrb2 variant when queue setup fails
to complete successfully.

Fixes: fc65d3dcabe01 ("baseband/acc: refactor queue allocation")
Cc: stable@dpdk.org

Signed-off-by: Nicolas Chautru <nicolas.chautru@intel.com>
---
 drivers/baseband/acc/rte_vrb_pmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/baseband/acc/rte_vrb_pmd.c b/drivers/baseband/acc/rte_vrb_pmd.c
index 27620ccc10..2c10ef2c94 100644
--- a/drivers/baseband/acc/rte_vrb_pmd.c
+++ b/drivers/baseband/acc/rte_vrb_pmd.c
@@ -1156,6 +1156,8 @@ vrb_queue_setup(struct rte_bbdev *dev, uint16_t queue_id,
 free_q:
 	rte_free(q);
 	q = NULL;
+	if (d->device_variant == VRB2_VARIANT)
+		d->queue_index[conf->op_type]--;
 
 	return ret;
 }
-- 
2.34.1

