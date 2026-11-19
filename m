Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E87606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A7ZPwd36
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4985A40431;
	Thu, 19 Nov 2026 08:32:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 74AC8402EA;
 Thu, 19 Nov 2026 08:31:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795073520; x=1826609520;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mEmd8NaV/KvYWhSQpBi9bMWOdTjzyYIrVy/YjHbJ4lw=;
 b=A7ZPwd36egjb6AqzkG2P2lmO05SkEIgsWaBxToCoz/Ych5zDwSCc6dVx
 HVlz1L2ABQTPDDsUXOxbuT5R0BfPah7UDEIb0YR6aiH8V31aoinGzFMP1
 XHGfb6bFkggxAhzjyF1j9zQ8hG7riWhP2jhsd20yqEnYy+rnIquDTjvJM
 yuwIeGqmrEWLxzmBUDD1vl+bWP/HWJrVqwylAB+CWFZ09XbeLkxRZj5Ei
 eKFQ3+arn1fz68Ndoo29V7CZYuBol9sPmGzEXHL6EDFk7eCSx2lLdc8YE
 rfw6DwPw5fMtZTDwgvlhaQx1UKIxtJf701VYBbJekrgDldGwHKxG+A316 w==;
X-CSE-ConnectionGUID: Z2y183GZSdS/wat6aW+V5A==
X-CSE-MsgGUID: oJhE4VuoSnCh8EFzu9QF8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3832035"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3832035"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 23:31:59 -0800
X-CSE-ConnectionGUID: +RuBJBqkRNGwWC3x4KlAGw==
X-CSE-MsgGUID: bQN0nWYjSFCNioed1mV+2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10356347"
Received: from unknown (HELO srv14..) ([10.190.212.243])
 by orviesa006.jf.intel.com with ESMTP; 18 Nov 2026 23:31:58 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: manoj.kumar.subbarao@intel.com,
	stable@dpdk.org
Subject: [PATCH v1 2/2] net/cpfl: fix log flood on empty mailbox
Date: Thu, 19 Nov 2026 13:01:47 +0530
Message-ID: <20261119073147.71820-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119073147.71820-1-soumyadeep.hore@intel.com>
References: <20261119073147.71820-1-soumyadeep.hore@intel.com>
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

The alarm handler polls the mailbox every 50 ms. When the receive
queue is empty, the receive call returns -ENOMSG, which was logged
as a read failure on every poll and flooded the log on an idle
device.

Do not log when the receive queue is empty.

Fixes: 2d823ecd671c ("net/cpfl: support device initialization")
Cc: stable@dpdk.org
Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/cpfl/cpfl_ethdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index fd84d9b21e..26e69514b4 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -1945,7 +1945,11 @@ cpfl_handle_virtchnl_msg(struct cpfl_adapter_ext *adapter)
 	while (pending) {
 		ret = idpf_vc_ctlq_recv(hw->arq, &pending, &ctlq_msg);
 		if (ret) {
-			PMD_DRV_LOG(INFO, "Failed to read msg from virtual channel, ret: %d", ret);
+			/* -ENOMSG only means the receive queue is empty */
+			if (ret != -ENOMSG)
+				PMD_DRV_LOG(INFO,
+					    "Failed to read msg from virtual channel, ret: %d",
+					    ret);
 			return;
 		}
 
-- 
2.43.0

