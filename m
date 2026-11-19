Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8283606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 05:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EBNLi+Xe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20713402E5;
	Thu, 19 Nov 2026 06:15:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 971FB402DA
 for <dev@dpdk.org>; Thu, 19 Nov 2026 06:14:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795065294; x=1826601294;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=egaBmy01B66yJC6yiSQqWN49/MTMjPDcUOvrYffjsvs=;
 b=EBNLi+Xe6dHV0KHw1eTJNG82ooGl7FNS67j0FGHaHcqxMjw2lTDrUc6Y
 VdZ28pO420xgPmJFZoBf+5Rm/120PxjUed2QYAEIlvJpioykyWidzVKMt
 XlFtI4nXE5qpQpDvrVozyfEKxEw0BpMEeDqPuJxZqLF7vTrS/NtJAiV/l
 jSzrPnjnKNsHO3QKyTA3bCNhKyZrNXVhM+jLbGhkGwLOAcLEU4RvuBgsr
 D5E9Z6qkzoemiMEfNPOfDADe0ZO8dSK5q0PDOIDeE0YLbB1KDCKkT3Y4E
 V1AATD8GAVfkqjQE8YI/pkUmpJ/w1FWq31K0Q4vaQT142Km7/CfAadWC4 w==;
X-CSE-ConnectionGUID: TSC7oNX5T2Kh4VRRpH2BqQ==
X-CSE-MsgGUID: qPOVP/dQTUCEy7y9xe31nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3929077"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3929077"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 21:14:52 -0800
X-CSE-ConnectionGUID: Ah+IMk+1TrOBdfZlOq54Uw==
X-CSE-MsgGUID: 1n4JcunfSp+QObyAZYatsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10328872"
Received: from gnrd03.iind.intel.com ([10.190.213.135])
 by fmviesa004.fm.intel.com with ESMTP; 18 Nov 2026 21:14:50 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, rajesh3.kumar@intel.com,
 aman.deep.singh@intel.com
Cc: manoj.kumar.subbarao@intel.com
Subject: [PATCH v1 0/2] Enabling Rx Vector Timestamping
Date: Thu, 19 Nov 2026 10:43:58 +0530
Message-ID: <20261119051418.2852033-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: root <root@gnrd03.(none)>

Enabling Rx vector timestamping for ice with working ptpclient.

Soumyadeep Hore (2):
  net/ice: fix Rx timestamp and PTP on vector path
  examples/ptpclient: support vector Rx paths

 doc/guides/sample_app_ug/ptpclient.rst      |  7 ++-
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 57 +++----------------
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 57 +++----------------
 drivers/net/intel/ice/ice_rxtx_vec_common.h | 61 +++++++++++++++++++++
 examples/ptpclient/ptpclient.c              | 52 +++++++++++++-----
 5 files changed, 123 insertions(+), 111 deletions(-)

-- 
2.43.0

