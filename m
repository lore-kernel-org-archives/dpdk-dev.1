Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5383F606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DlkbMYkL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9E5240DF8;
	Fri,  6 Nov 2026 07:44:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTPS id CE00440297;
 Fri,  6 Nov 2026 07:44:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793947483; x=1825483483;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LzRzkIvWcfimKQySUDU8JgZfH4A+UyDDXugBOEBufY0=;
 b=DlkbMYkLyqKpouPcqX9L1+A02KBPcfRjGWvrfC9Op5hcUfxymQwKYT7/
 QgOwFTly751XiQH2EGYtl0He69gUfQMAW+qjzoiwBhw0NGy71LsPImhoU
 cATJjLHoIFe1zRJlLU65sQV6f0YtKptcF1WmZRqoB5BmWy9gBse6jli5c
 HFc7dQ3YRwXcgDzW46LdjkPPk8oh1TNj1IXs/7e+qx6wc35F9xGKAH9Fu
 rUwD3T+pgi0A3n6kqu3N9dpua4+PFrVSimPcLAr9dM/sVBjTNzQPE9edj
 ogkc6X3m43I6qcwies3EAGhxA100AQVvEEUUmYWQ4y8r8/AwiGxSjwX3Y w==;
X-CSE-ConnectionGUID: YSmOURLSRHyg+aS67HjRGg==
X-CSE-MsgGUID: 1xWqCRoBTOyAx7rer8RV+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2657017"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2657017"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 22:44:41 -0800
X-CSE-ConnectionGUID: lx1NSSx4TXCP0M4VP81O4A==
X-CSE-MsgGUID: 8N946ojeTUq5bPpWmuxXMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7106994"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa005.jf.intel.com with ESMTP; 05 Nov 2026 22:44:39 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH] net/ice: fix NULL dereference on ACL init failure
Date: Fri,  6 Nov 2026 06:39:49 +0000
Message-Id: <20261106063949.654513-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If ice_acl_init() fails to allocate the ACL profile array,
it leaves hw->acl_prof NULL.
ice_flow_init() then fails and ice_dev_init() calls
ice_flow_uninit(), where ice_acl_prof_free() dereferences
the NULL array.

Return early from ice_acl_prof_free() when the array was
never allocated.

Fixes: 40d466fa9f76 ("net/ice: support ACL filter in DCF")
Fixes: 96b25c496aad ("net/ice: fix memzone leak after device init failure")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 6cf8c83738..94c9ea89fd 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -1065,6 +1065,9 @@ ice_acl_prof_free(struct ice_hw *hw)
 {
 	enum ice_fltr_ptype ptype;
 
+	if (hw->acl_prof == NULL)
+		return;
+
 	for (ptype = ICE_FLTR_PTYPE_NONF_NONE + 1;
 	     ptype < ICE_FLTR_PTYPE_MAX; ptype++) {
 		ice_free(hw, hw->acl_prof[ptype]);
-- 
2.25.1

