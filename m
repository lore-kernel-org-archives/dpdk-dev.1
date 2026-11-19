Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A35606A32C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Agcz3915
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CDCF402D8;
	Thu, 19 Nov 2026 11:41:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 7B9B6400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 11:41:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795084903; x=1826620903;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8pHSHeD7EJS+++vd9D3F7V5RTe7upl5CSG7f3AUSxj0=;
 b=Agcz3915aeIeZGwSjo50n2sivm8ibb2p2/oJdBWttIeItsu1Y+ktDIcc
 iIo+RisfMcCaHU3uOSJ8fPomTSBniOw+KtunhITIn2bQifi7c24eu0YBo
 dg2drM5t8vFdxk18nx8ay3XCkCEbtiOdvi5/4V/NxtZgC38ytnSuk1v4u
 Zteb9T2Z+yl3nqWVoSqKsfb1uIaoACjzLaMALFTIbyxc5M2hG2ejcwiFQ
 3ltxux+9kjKzO59xjN4S2jdxhtRBIfTZbHy+Rd84wOL03GbHqC2kCuU7U
 0Wi1RC39YhOdtuhkZT0gfXksk+1a1ZCR5pvFZOrYjG4XJy0TVva+h0i1n Q==;
X-CSE-ConnectionGUID: lWZXSBmnSbammfJFg7YsoA==
X-CSE-MsgGUID: HgXBJJ71SYyJREYT8Z/BEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3825083"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3825083"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 02:41:40 -0800
X-CSE-ConnectionGUID: Ip2kaezETHmSf1aaEr74iQ==
X-CSE-MsgGUID: d+ueQ6AFQEOk5TvDNP9hKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10208823"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 02:41:39 -0800
From: Hailin Xu <hailinx.xu@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: manjunathgouda.hosamani@intel.com,
	Hailin Xu <hailinx.xu@intel.com>
Subject: [PATACH v1 0/3] Update latest recommended matching list for intel NIC
Date: Thu, 19 Nov 2026 18:34:05 +0800
Message-ID: <20261119103408.289005-1-hailinx.xu@intel.com>
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

Update latest recommended matching list for intel NIC

Hailin Xu (3):
  nics/ice: update ice latest recommended matching list
  nics/i40e: update i40e latest recommended matching list
  nics/ixgbe: update ixgbe latest recommended matching list

 doc/guides/nics/i40e.rst  | 1 +
 doc/guides/nics/ice.rst   | 1 +
 doc/guides/nics/ixgbe.rst | 1 +
 3 files changed, 3 insertions(+)

-- 
2.43.0

