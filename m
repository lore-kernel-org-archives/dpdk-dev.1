Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C66606A896
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Nov 2026 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ATWuHQww
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD129402A4;
	Sat, 14 Nov 2026 02:44:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTPS id 4FA684025F
 for <dev@dpdk.org>; Sat, 14 Nov 2026 02:44:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794620651; x=1826156651;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ExAV1sfO6+0lJlHj5HOvuKbCZ+gRRncR19KS8luRFTQ=;
 b=ATWuHQww189jvTVjhOzgfhXsbdATNz94W45o7Fu1sRa1AxPSD7i+XQIV
 xq/x8C0D9vShEqPTEcuujHr/EreAC9eReqeQsj4Yvx0eXMm2vzJew4iaB
 lNBOXleljeTAIG0ePWFi49/IKcD6l6VQz8qlGObqx4ISfhjBA7GXCq4F+
 yWmUjiFzPvhPuO6Y/ZesDSBifdVOXzd4EaTKrTqSJ/qGUWVouv2Bwl6FP
 SRzYYYS6HJBcxmIkJYvW+hSx5X6//rXcfmrPhARjB4csx9NH6W3NPQhwp
 DxMC2CJQcm8WPjJ341VePxgJ8zKRW/lt2IYpGcd/CCyT0JdvHzB/KIvxw Q==;
X-CSE-ConnectionGUID: /f5Zr8H7QhCBmoX6IVW+fw==
X-CSE-MsgGUID: SL++CzrjSoyeQK9YFBMi8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3325919"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3325919"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 17:44:10 -0800
X-CSE-ConnectionGUID: ZyeLDFUGQgOIyBr7YiTkAg==
X-CSE-MsgGUID: gnVR5tfbRhuGVA/T9mCiqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="10969967"
Received: from pae-31.iind.intel.com ([10.49.105.68])
 by fmviesa013.fm.intel.com with ESMTP; 13 Nov 2026 17:44:08 -0800
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 vladimir.medvedkin@intel.com, brian.johnson@intel.com,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v3 0/4] doc: fix Intel NIC driver guides
Date: Sat, 14 Nov 2026 08:46:15 +0000
Message-Id: <20261114084619.190251-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114075732.183996-1-sandeep.penigalapati@intel.com>
References: <20261114075732.183996-1-sandeep.penigalapati@intel.com>
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series corrects a number of documentation errors found while
reviewing the Intel NIC driver guides: wrong feature and attribute
names, stale macro names, broken or incomplete command examples, and
assorted grammar and spacing issues.

Each patch is self-contained and touches only its own driver guide.

v3:
- ixgbe: drop the "none" option from the "set bypass event"
  documentation; it is a parser-only sentinel that the driver rejects
  (EINVAL), not a usable event.

v2:
- add the full set of Fixes: tags to each patch.
- i40e: fix remaining grammar in the queue region flush description.
- intel VF: remove a stray double space before "Qemu".


Sandeep Penigalapati (4):
  doc: fix ice guide
  doc: fix i40e guide
  doc: fix ixgbe guide
  doc: fix intel VF guide

 doc/guides/nics/i40e.rst     | 20 ++++++++++----------
 doc/guides/nics/ice.rst      | 26 +++++++++++++++-----------
 doc/guides/nics/intel_vf.rst | 18 +++++++++---------
 doc/guides/nics/ixgbe.rst    | 20 ++++++++++----------
 4 files changed, 44 insertions(+), 40 deletions(-)

-- 
2.34.1

