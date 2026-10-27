Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB80606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OGeiqa1X
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8B81406A2;
	Tue, 27 Oct 2026 11:56:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 8A37840431
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:56:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793098601; x=1824634601;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XTnj151dfeBFEwgUj17LT52UbZKfyRrNYfMD16dksfg=;
 b=OGeiqa1XjojDmnogL0GQAMXl31Gp7li1sq9Kn9zhbCTp5wEPn3aq21fB
 Wre4I1fQXHd2u25lk2Zn8eQb7XSojWsZ5E/+wh97Uhx0TxWgwYySza0N+
 VqMUIlSaW+y+sJKhBnpl9zfypaSQp+6tuq2WKpcUaYihl4tjYUcwAqkTJ
 Zwqor77UMQubIs53FzHX1ElKQDN1+Mgv6v95xZod4DfRh9mDvh+CgmDmP
 ZXCjiDksxf1o0KF6ZwKC5k1F3Q40PFJoyBViwk4Um2UHZ/3r6osFlWc1O
 4p4s9JpjB1j1oo9wU3IM29zUSn4ZFh+aJ/tNXfHULOAPJ8p8BNF8cq3/F w==;
X-CSE-ConnectionGUID: a2QY9rOHTiOMfEOccyFisQ==
X-CSE-MsgGUID: A8SleghvQY2zmK+WvnHRlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1679308"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1679308"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 03:56:41 -0700
X-CSE-ConnectionGUID: KBwr5hz1TJO8X9XGhrdgQA==
X-CSE-MsgGUID: wcHRUdzxTgi2tcCVUirw8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4901477"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa009.fm.intel.com with ESMTP; 27 Oct 2026 03:56:40 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 7/7] net/ice: fix ACL profile segment leak
Date: Tue, 27 Oct 2026 10:51:37 +0000
Message-Id: <5254238a89b9e0f9ed6a4c9740dc34fb02a69b19.1793097896.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793097896.git.anurag.mandal@intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
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

ice_acl_prof_init() allocates a flow segment to add the ACL profiles,
but only frees it on the error path. ice_flow_add_prof() copies the
segments, so the buffer is no longer needed once the profiles are
added, and it leaks on every ACL engine init.

Free it on success as well.

Fixes: 40d466fa9f76 ("net/ice: support ACL filter in DCF")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 21b48e1009..d49e514d69 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -308,6 +308,7 @@ ice_acl_prof_init(struct ice_pf *pf)
 				goto err_assoc_prof;
 		}
 	}
+	ice_free(hw, seg);
 	return 0;
 
 err_assoc_prof:
-- 
2.25.1

