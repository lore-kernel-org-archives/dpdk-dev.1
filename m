Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71665606A326
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 05:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mqM6UzA6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBB1C402DE;
	Thu, 19 Nov 2026 06:53:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTPS id 72BAA402DA
 for <dev@dpdk.org>; Thu, 19 Nov 2026 06:53:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795067581; x=1826603581;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=h0m+o03TxEwVAPWBi0e7NVQxI3DtnVFpRvE6I/v2i1Q=;
 b=mqM6UzA613LWsBV28BgwphjUNaaG5cRqqaa94f6I7CH7leP/SWW/SxMp
 r8/rpxDzD5tQ0y/6bd6o9xVoLj+Ummxs5Wt3Xbck32U8zDm+qV1RTnpMA
 vHGYNSUD9AbjAsKEa0iHa0IYbzDoKP9WHRJCdnRfVBb/yeHAcuF2m4c0M
 GxLkQgqdnMRmB5CREa5kO0lhSCIX9sFbvsNTyf8eSWZTffE4gURsAUdAy
 nooSnHJRJ7i1/P9P9bCae6NalEkoVdbbaCzlwXTLzEL/zcgpHIOjkhDoH
 hgC6s+MZWkI3j+iof7Vg+aneSY2mz9hT9fp9HcMoIkjvO1aRp8kDMkr4B w==;
X-CSE-ConnectionGUID: QnCUTsZFQA21EeFxE2LOQw==
X-CSE-MsgGUID: 4tzNI48YRzC5/G2H981sPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3803733"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3803733"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 21:52:59 -0800
X-CSE-ConnectionGUID: t8qLQlnlSgm0Auqx4JMKCA==
X-CSE-MsgGUID: guDM14/pSjSQgwqYZISMRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10146900"
Received: from npg-npf-wlpr-srv19.iind.intel.com ([10.190.212.201])
 by orviesa008.jf.intel.com with ESMTP; 18 Nov 2026 21:52:57 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH] net/cpfl: use MMG function type for VSI lookup
Date: Thu, 19 Nov 2026 11:22:53 +0530
Message-Id: <20261119055253.3457200-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
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

MMG PF vports use the VCPF function-type namespace. MEV uses
CPCHNL2_FTYPE_LAN_PF (2), while MMG uses VCPF_CPCHNL2_FTYPE_LAN_PF (0).

cpfl_get_vsi_id() currently uses the MEV function type for every PF.
On MMG, this creates a vport-map key that does not match the key received
from the control plane. The lookup fails, and flow validation cannot
obtain the VSI needed to build flow metadata.

Select the function type based on the device ID.

Fixes: 5a329d2844a9 ("net/cpfl: make device checks more generic")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/cpfl/cpfl_ethdev.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
index 49a0979f2c..966647c8d9 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -354,7 +354,10 @@ cpfl_get_vsi_id(struct cpfl_itf *itf)
 		if (!idpf_is_vf_device(&itf->adapter->base.hw)) {
 			vport_id = ((struct cpfl_vport *)itf)->base.vport_id;
 
-			vport_identity.func_type = CPCHNL2_FTYPE_LAN_PF;
+			if (itf->adapter->base.hw.device_id == CPFL_DEV_ID_MEV)
+				vport_identity.func_type = CPCHNL2_FTYPE_LAN_PF;
+			else
+				vport_identity.func_type = VCPF_CPCHNL2_FTYPE_LAN_PF;
 			/* host: CPFL_HOST0_CPF_ID, acc: CPFL_ACC_CPF_ID */
 			vport_identity.pf_id = (itf->adapter->host_id == CPFL_HOST_ID_ACC) ?
 							CPFL_ACC_CPF_ID : CPFL_HOST0_CPF_ID;
-- 
2.34.1

