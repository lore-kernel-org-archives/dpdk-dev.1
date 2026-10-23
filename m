Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2285606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FPQxSHKj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF72240658;
	Fri, 23 Oct 2026 12:36:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3ED8B40658
 for <dev@dpdk.org>; Fri, 23 Oct 2026 12:36:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792751775; x=1824287775;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PBfwQ7ODG6cn/XHyVxP/i/AjJmiTTzR+ALDbzZwtNJY=;
 b=FPQxSHKj+suYMTI7+CQDFi9b7O7ndMiaqzDQwmBLTAJeh4pldwYFv+56
 llZtxNtn5QuWTvG0tjBnCNKWVi1PCi4BxqNzxm9kgbyp66AuAJdjSkBwX
 UFnnMVnA5jnJzs//DcEjmZpTFrhzUx8U54FeTQQkSJCjWIsJZbUWGkgwm
 Cbr6nFfQ9cYUjCysGdhU4iIASUgWemSpd7otJYtXMeNwpWYN2fEKC+FjA
 yPd/vDUJnvR+mouyMI6iTCOLX+5Xd9Rwl7wH1QBUqrzP1BlqNqiAOqQDt
 DeNsDqSEWLyn33GeFgAV26YXwObN4jiCuJjOWViP7L8luiOwPJPnLWjxX w==;
X-CSE-ConnectionGUID: cXRTlRDPSLi5TLlwHfJQdw==
X-CSE-MsgGUID: 8u+m4A6tRDGQLvlXtNrvBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1522864"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1522864"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 03:36:15 -0700
X-CSE-ConnectionGUID: iW/QK+QPS/6A76m48am+1A==
X-CSE-MsgGUID: sR9l8034QFO8qVQjLPwP3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4098943"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa010.fm.intel.com with ESMTP; 23 Oct 2026 03:36:14 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 1/2] net/i40e: fix floating VEB leak
Date: Fri, 23 Oct 2026 10:31:29 +0000
Message-Id: <01b44debc0c280fe654d78aebeffd528abb42261.1792750212.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1792750212.git.anurag.mandal@intel.com>
References: <cover.1792750212.git.anurag.mandal@intel.com>
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

With floating VEB enabled, i40e_vsi_release() releases the VSIs
attached to the floating VEB of the main VSI but not the floating
VEB itself, leaking the VEB structure and its switch element.

Release it once its VSIs are gone, as is already done for the
regular VEB.

Fixes: 440499cf5376 ("net/i40e: support floating VEB")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index e26a849764..9ca01ecd34 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -5329,6 +5329,7 @@ i40e_vsi_release(struct i40e_vsi *vsi)
 			if (i40e_vsi_release(vsi_list->vsi) != I40E_SUCCESS)
 				return -1;
 		}
+		i40e_veb_release(vsi->floating_veb);
 	}
 
 	/* Remove all macvlan filters of the VSI */
-- 
2.25.1

