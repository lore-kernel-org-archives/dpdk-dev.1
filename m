Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F8C606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YGQiQef+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 668C240685;
	Tue, 27 Oct 2026 11:56:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 051CD4067C
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:56:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793098597; x=1824634597;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7Z19iOAXuG+JyU8SM9kkUcS2dJEVLS/mw97XOOYY+ls=;
 b=YGQiQef+Deq5VRxi2B9f0etBoTgxFewZ4e6ayFG+duMCh5hs5ASnCwb7
 T4lpXc9Plv7PxMcNkZlYO6MgHcpvCpFBIHTgbo/qm70u6ceVPn8EuTP1D
 X+dxQL3o6uU736Er6yPmpoQ7b6pAc1ndoNMoCyhj4dDlfweLvSjICXMnJ
 UMzPW7pKsbVnIh5/j9nZHxQP13Rb8aGVUZO04UHt1h8ZZvdKWcJDeuywP
 jumtR613G2lmgkuoI6kajYxyaTRz4KGZe0CMsR1bYoUZnLflxETzE6pQo
 xadq5ITVyQ83m4KrTzF3ag6LbPJ1Yk41sOoSlV3+uVF/ZDlWEMxQSNN/c Q==;
X-CSE-ConnectionGUID: 5iN1sZEvQR2PdC2C07SxfQ==
X-CSE-MsgGUID: Gu6FoLSrT4iAiOi0nXN47A==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1679303"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1679303"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 03:56:36 -0700
X-CSE-ConnectionGUID: s39i7FgCS96ejKHw9F0bsg==
X-CSE-MsgGUID: 1nZZOw9MSc2VWkbU6uN9Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4901471"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa009.fm.intel.com with ESMTP; 27 Oct 2026 03:56:35 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 5/7] net/ice: fix MAC and VLAN filter leak on VSI release
Date: Tue, 27 Oct 2026 10:51:35 +0000
Message-Id: <7e0d6afa7e1737e7a9172b3898bc95f0d2e2c718.1793097896.git.anurag.mandal@intel.com>
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

ice_release_vsi() relies on ice_remove_all_mac_vlan_filters() to free
the MAC and VLAN filter entries. That function returns early when the
VSI has no MAC filter, or when removing a filter from hardware fails,
leaving entries in the lists. The VSI is then freed with them still
allocated.

Free any entries left in the lists before freeing the VSI.

Fixes: e0dcf94a0d7f ("net/ice: support VLAN ops")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 73fa016066..90e3663287 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2931,6 +2931,9 @@ ice_release_vsi(struct ice_vsi *vsi)
 {
 	struct ice_hw *hw;
 	struct ice_vsi_ctx vsi_ctx;
+	struct ice_mac_filter *m_f;
+	struct ice_vlan_filter *v_f;
+	void *temp;
 	int ret, error = 0;
 
 	if (!vsi)
@@ -2940,6 +2943,12 @@ ice_release_vsi(struct ice_vsi *vsi)
 
 	ice_remove_all_mac_vlan_filters(vsi);
 
+	/* filters whose HW removal failed or was skipped are still listed */
+	RTE_TAILQ_FOREACH_SAFE(m_f, &vsi->mac_list, next, temp)
+		rte_free(m_f);
+	RTE_TAILQ_FOREACH_SAFE(v_f, &vsi->vlan_list, next, temp)
+		rte_free(v_f);
+
 	memset(&vsi_ctx, 0, sizeof(vsi_ctx));
 
 	vsi_ctx.vsi_num = vsi->vsi_id;
-- 
2.25.1

