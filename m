Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B617606D907
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eqxiiTgh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89F3B40E34;
	Fri, 13 Nov 2026 09:49:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTPS id C030B4029D
 for <dev@dpdk.org>; Fri, 13 Nov 2026 09:49:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794559759; x=1826095759;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=abcpmRzUSn/SLZ0ZVssoA5fn1x+4mRuGMrRYNYNFaqU=;
 b=eqxiiTghycAouzfjuXUhBOwV/JZfFbDHK0gvdh/c3C5LJRTQt2qbk9Is
 AOxemy731L4Bfoh6Xy/AoF/N6vjrqbHTqMoVZ0xh/NXVnWE3z4JLlM+16
 OGozDf8DHL8X74eHypkxHCTaf5Bn98wj0TaaSZkCpx16dVGQiaCcjefCL
 n4l5LbGZbV/5EalDTkj9P/VsidWc+hOgAqWI4oPZIPaq+avzfTwSxztYR
 faQ349wWOIl71w3MDijMf0AoczPCEbwMM7pZBi+8LfRkTM4hJbVhPX+Mj
 CeBihsHQzeLk0Iy8bc7mLFI98iEL/8RsMDMl6MXGbZ9A/ad8yVh+pAqAp w==;
X-CSE-ConnectionGUID: +mdjHcpYSoqVkVo/k/mdxg==
X-CSE-MsgGUID: YJRKJ6inS2eG6HCdOThfLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3278021"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3278021"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 00:49:17 -0800
X-CSE-ConnectionGUID: mjTXopfnTBqBf4dl4naufw==
X-CSE-MsgGUID: y2oXccDYTuajGwn4MTuIoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8795301"
Received: from icx008-fc43.iind.intel.com ([10.190.212.196])
 by fmviesa004.fm.intel.com with ESMTP; 13 Nov 2026 00:49:17 -0800
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v1 0/1] net/e1000: limit 2.5G inter-packet gap workaround to
 I225
Date: Fri, 13 Nov 2026 14:17:25 +0530
Message-ID: <20261113084726.4059806-1-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.55.0
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

The igc link update path unconditionally widens the transmit
inter-packet gap (TIPG.IPGT 0x08 -> 0x0b, 12 -> 15 byte times)
whenever the link comes up at 2.5 Gb/s.

This is a workaround for an erratum in early I225 steppings, where
a back-to-back I225 receiver can drop packets arriving with an IPG
below 8 bytes. Applying it to every 2.5G-capable device costs about
0.2% of small-frame transmit rate on I226 and fixed I225 steppings,
which do not need it.

This patch gates the workaround on I225 device IDs with revision_id
below E1000_REVISION_2, and restores the default gap at other speeds
so a renegotiated link does not keep the widened value.

The igc driver has since been merged into net/e1000; this series is
based on that layout and uses the shared e1000 base definitions.

Rajesh Kumar (1):
  net/e1000: limit 2.5G inter-packet gap workaround to I225

 drivers/net/intel/e1000/igc_ethdev.c | 39 +++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

-- 
2.43.0

