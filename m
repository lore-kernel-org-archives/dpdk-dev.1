Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E5D606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 04:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Op10+S8F
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28FD7402B2;
	Wed, 25 Nov 2026 05:54:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTPS id 63CD84027A
 for <dev@dpdk.org>; Wed, 25 Nov 2026 05:54:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795582494; x=1827118494;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GerYwE3uhNFDed1HEsho6U8SO6ZDB6pb6LisqUSg0PA=;
 b=Op10+S8F37EfnjDfuXoljuPINK1tPuG15fSre/do2BybGGfkGdTIwLg1
 ymLKP4d56iMP9ZsKBwZ1tV6Nj7zwGMtwFWT63YYD9WcUryNp+PdTh7UKY
 LZuuUpaPfZDUrAclGOC1WtNSKU7nsb8jkTvzJDoDZCLuzrrBYyMviTFe3
 466yQIFmeSde+qmAATYQ0MbEeRC267U6cLQCBTlWnCxFzx7Jkuo35/YwE
 VPgmI4+hAqoHBUIyrc1OmVcLFts2rfys9VvwSmmS8iDSPlhfC7H5CjcWj
 o3uZbp9xjx1A4SeTSbDJ7bHriMC86akovC8MqhzXoV0aIvp2GLjH0InHR A==;
X-CSE-ConnectionGUID: Ez0B9ypnSrOF2zFcW5WTSA==
X-CSE-MsgGUID: Sg+ugrIUTVW/BRDFTgRbAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4372042"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4372042"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 20:54:52 -0800
X-CSE-ConnectionGUID: RQIbR3v5RFmXTWmrUYBC+A==
X-CSE-MsgGUID: ehiSbzLIT/2bPsNCWKkGbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; d="scan'208";a="13550436"
Received: from txandevlnx321.an.intel.com ([10.123.117.43])
 by fmviesa011.fm.intel.com with ESMTP; 24 Nov 2026 20:54:52 -0800
From: Naga Harish K S V <s.v.naga.harish.k@intel.com>
To: dev@dpdk.org
Cc: s.v.naga.harish.k@intel.com, abhinandan.gujjar@intel.com,
 thomas@monjalon.net, jerinj@marvell.com
Subject: [PATCH] maintainers: update eth adpaters maintainer
Date: Tue, 24 Nov 2026 22:54:37 -0600
Message-Id: <20261125045437.3486804-1-s.v.naga.harish.k@intel.com>
X-Mailer: git-send-email 2.39.1
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

update ethernet rx/tx adapters maintainer

Signed-off-by: Naga Harish K S V <s.v.naga.harish.k@intel.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c4f35e7e82..096232e5d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -550,14 +550,14 @@ F: app/test/test_event_ring.c
 F: examples/l3fwd/l3fwd_event*
 
 Eventdev Ethdev Rx Adapter API
-M: Naga Harish K S V <s.v.naga.harish.k@intel.com>
+M: Abhinandan Gujjar <abhinandan.gujjar@intel.com>
 T: git://dpdk.org/next/dpdk-next-eventdev
 F: lib/eventdev/*eth_rx_adapter*
 F: app/test/test_event_eth_rx_adapter.c
 F: doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
 
 Eventdev Ethdev Tx Adapter API
-M: Naga Harish K S V <s.v.naga.harish.k@intel.com>
+M: Abhinandan Gujjar <abhinandan.gujjar@intel.com>
 T: git://dpdk.org/next/dpdk-next-eventdev
 F: lib/eventdev/*eth_tx_adapter*
 F: app/test/test_event_eth_tx_adapter.c
-- 
2.39.1

