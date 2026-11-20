Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A33606A33F
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 03:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BZCRBw0N
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30FDB40284;
	Fri, 20 Nov 2026 04:23:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 393FE40151
 for <dev@dpdk.org>; Fri, 20 Nov 2026 04:22:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795144979; x=1826680979;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DkzTiXnBT0P9A6WCVWGFb9h69gjxFpF2NsDnC3KdNLg=;
 b=BZCRBw0N7xFu46ykTx+jw6oiI/7NE5j9DgjUiPUm3ES7wRu6Q5rKj+Mm
 w8iLAKpnu5w/ZcG4VBDJh/3qxWzUl31c6L/N7tuSglfvW8ItODvm6sfKK
 066MsDunilD0fLhmOcAkf7Vep5+YSMUiDkOxtO2hK7G33OB18bV0RsE3W
 sRSfopjhfOgTGw/2cTYVYDz12mWF+/T+NKsju+Pi3qdHGl4pY0NZ3A5z2
 iim5RF8nE/xLKFrmO3hyA0CYVWisC8vfkxOQdNcftFjGAhxCs0emcNY1Z
 1kAncCXvYW0w3/aBkBb+nvEXBa2/Q1EzYjcZDODo+j7NFxlwuYHiix3+O Q==;
X-CSE-ConnectionGUID: QNEZ7Dp8RTiMwcNUqwKYyw==
X-CSE-MsgGUID: MF4vOjw/St+/KPWdZ0Jahw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3902109"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3902109"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 19:22:57 -0800
X-CSE-ConnectionGUID: NlvNFJ5bQCWnini3QBHt2g==
X-CSE-MsgGUID: f+caOb+xSLe25//PnD18OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10883239"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 19:22:54 -0800
From: Hailin Xu <hailinx.xu@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: manjunathgouda.hosamani@intel.com,
	Hailin Xu <hailinx.xu@intel.com>
Subject: [PATCH v1 0/3] update latest recommended matching list for intel nic
Date: Fri, 20 Nov 2026 11:15:22 +0800
Message-ID: <20261120031525.300632-1-hailinx.xu@intel.com>
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

1. update latest recommended matching list for intel nic.
2. remove recommended non LTS versions

Hailin Xu (3):
  nics/ice: update ice latest recommended matching list
  nics/i40e: update i40e latest recommended matching list
  nics/ixgbe: update ixgbe latest recommended matching list

 doc/guides/nics/i40e.rst  | 3 +--
 doc/guides/nics/ice.rst   | 3 +--
 doc/guides/nics/ixgbe.rst | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.43.0

