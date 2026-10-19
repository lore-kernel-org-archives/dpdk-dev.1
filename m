Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDF0607886F
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XP5/zycl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AC8B406B7;
	Mon, 19 Oct 2026 17:06:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 432FD4066C
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:06:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792422399; x=1823958399;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7Beqy2VlbLDk4yioEt6Codl4hcCiXJ+nMD7Q0gR8Jyo=;
 b=XP5/zyclh5FhJcx6pSn2EdPMSl+IKsqYGWb/FMxGVHIHsMjLvt6xEVi9
 JB71FJ3zVCvBXf4tDs1yvY4HJECVbycXLCEXO8vTOA5pOJK0i6aoJKJUw
 JeTh6eke23llHaLPHGR9cxjymeybcXiUm03Y1QztmnUcMQwZEMqQPxw8n
 9ERLMPnmYeHpPrtKl6/Tku7tTqkuqj00+6VFa3Gmunxn9WXBF8bAZl7Cg
 5M4YHG5YsPp7Nwzxmj195XsmvxPc9Ht7JvhTDOFkqM4eAbppcaYjY/7Z0
 JNRe0DtIB9J1nZm3U0DXB3/SVWefd8GUpWDjlzwZ6XnKKkpUVmhzDcFbK Q==;
X-CSE-ConnectionGUID: bOKTn+Q3TYmrcqdt0EOzDA==
X-CSE-MsgGUID: JxMNF6jFThuscTVCc+ujuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1132169"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1132169"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:06:38 -0700
X-CSE-ConnectionGUID: Qmumw+9sR6e71HY2CNh41g==
X-CSE-MsgGUID: OW2BT6L3R8GEbn8GnY2HSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4319738"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 19 Oct 2026 08:06:37 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Ting Xu <ting.xu@intel.com>
Subject: [PATCH v2 4/9] net/iavf: fix memory leak in raw pattern parsing
Date: Mon, 19 Oct 2026 16:06:23 +0100
Message-ID: <188036eb92e560f7960d8038233dc04ee40a6092.1792422213.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792422213.git.anatoly.burakov@intel.com>
 <cover.1792422213.git.anatoly.burakov@intel.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Anurag Mandal <anurag.mandal@intel.com>

If mask buffer allocation fails in `iavf_hash_parse_raw_pattern()`,
the previously allocated packet buffer is leaked.

Free the packet buffer before returning the allocation error.

Fixes: bc0e85586eaf ("net/iavf: support VF RSS flow rule with raw pattern")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    The API was removed in 92ef4b8f1688 ("ethdev: remove deprecated shared counter attribute")
    
    However, it may not be reasonable to pin a Fixline on that commit because that
    would imply that it *should have* updated ice driver's plubmbing to not support
    shared counters any more, which I do not believe is reasonable. I'm leaving
    this note for posterity and in case it is determined that the Fixline is needed
    after all.

 drivers/net/intel/iavf/iavf_hash.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index 9515094402..a240c73614 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -918,8 +918,10 @@ iavf_hash_parse_raw_pattern(const struct rte_flow_item *item,
 		return -ENOMEM;
 
 	msk_buf = rte_zmalloc(NULL, pkt_len, 0);
-	if (!msk_buf)
+	if (!msk_buf) {
+		rte_free(pkt_buf);
 		return -ENOMEM;
+	}
 
 	/* convert string to int array */
 	for (i = 0, j = 0; i < spec_len; i += 2, j++) {
-- 
2.52.0

