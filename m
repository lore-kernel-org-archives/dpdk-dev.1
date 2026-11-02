Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC6F606A327
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eq92N/UI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A590240E36;
	Mon,  2 Nov 2026 09:15:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 8AE2140E6E;
 Mon,  2 Nov 2026 09:15:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793607347; x=1825143347;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nXhiIiuZByXR/6JMT2E1LIwpMx1HPZr6insxqTECqXU=;
 b=eq92N/UIpmclzFKYzaiquH1TQVSI6XhBKx6n3/PnHJeL+7C873t/ndKh
 0orZK2JOAOfRWs7kUjB1tRnFq3Xd+A+DxLhDifaZwPIzgWH6YSFTUhSpo
 U3lf9/dKbZdH6ECTuEkCT4MtjU9ZVdAZ3iXPlm61BFENrRkD+03j1Iv/Z
 UB5Jxh+DNSXFjiWMSZ3vgPwkxqbCv6ov/KygiWxMh8WkO/gs3JLXfiM7T
 aYT8MVtjUF7Kjn+uIF3oVLw36pefnIyBBGOTXSke5dvisM58g3jTwb/j0
 LG8bNQL68Dugnvh37BXmB8h3s1mfLVyeoMFQUk9pgstvKF5u7NYtUh/5N w==;
X-CSE-ConnectionGUID: ywuorESYRvy8z3qmAO0hiw==
X-CSE-MsgGUID: bKMDDKpSTmuD9TMTZcb4fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2283637"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2283637"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 00:15:47 -0800
X-CSE-ConnectionGUID: 2+mdb+aLT6S+mC+ULPAGrw==
X-CSE-MsgGUID: bV7gJz1yTuupJ+YDSZRNJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7818689"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa012.fm.intel.com with ESMTP; 02 Nov 2026 00:15:46 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 5/7] net/ice: fix MAC and VLAN filter leak on VSI release
Date: Mon,  2 Nov 2026 08:10:35 +0000
Message-Id: <48f180037fc82390448ec8fe17291e10aab820ce.1793605752.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793605751.git.anurag.mandal@intel.com>
References: <cover.1793605751.git.anurag.mandal@intel.com>
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

ice_release_vsi() relies on ice_remove_all_mac_vlan_filters() to free
the MAC and VLAN filter entries. That function returns early when the
VSI has no MAC filter, or when removing a filter from hardware fails,
leaving entries in the lists. The VSI is then freed with them still
allocated.

Free any entries left in the lists before freeing the VSI.

Fixes: e0dcf94a0d7f ("net/ice: support VLAN ops")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 53a14dfd2b..457c955b2e 100644
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

