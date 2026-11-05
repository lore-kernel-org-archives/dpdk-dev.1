Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D0606EE99
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U2DIE2rt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9587140F1A;
	Thu,  5 Nov 2026 10:53:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id E0CF5402F2;
 Thu,  5 Nov 2026 10:53:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793872391; x=1825408391;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8CgmCBctyO+7CavH0+p2JxoMEmhYIl6/m5PjEU+DR18=;
 b=U2DIE2rt4904ldTC1QZhv9x55D3JgRuTwXBblwsil2NFT0Yk2mXKLXbx
 +ECUdYt9IwNa9cD1KP1yzbdGArVOc/PEFJMSmPLWxoSRPcUIhQQNpCita
 tGkLI4LC3YaFXVw8fHE8ABwDbjdrO02PlOr5l2oSweY/qFp5mnduLnoNZ
 K52lE0c+s6dQRK0VGY0t8Vyb2ebbdIx9zuMjdg7O6Z0nSp7d2OsTpDboC
 +T9L/Irq9hacJrpcm88qJwjeNfaSo4aCIX2amgsCTmr8CclGZPY10oCla
 rWBGpfmO8MLZOX7gMxNzt9EbDjuz67DObujtzIygpBy18yuA7CTrQbSva w==;
X-CSE-ConnectionGUID: VQ276x+5SP6v2//j0Esxng==
X-CSE-MsgGUID: k4ErO22fRLqJaMn98kSyUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2683967"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2683967"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 01:53:10 -0800
X-CSE-ConnectionGUID: /YbJ8TpkRKWj9tcY6eighw==
X-CSE-MsgGUID: veeAWvz6QXeoGRAABLMs+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7034291"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa006.jf.intel.com with ESMTP; 05 Nov 2026 01:53:08 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH 4/8] net/ice: fix DCF QoS buffer leak on commit
Date: Thu,  5 Nov 2026 09:47:21 +0000
Message-Id: <60f664e30d258546613eb746fb81f67e897a852c.1793871697.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793871697.git.anurag.mandal@intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
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

ice_dcf_hierarchy_commit() frees its temporary VF
and TC bandwidth buffers only on the error path,
so every successful commit still leaks them.

Free them on success as well.

Fixes: efd5d15a886b ("net/ice: fix memory leak in DCF QoS bandwidth config")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_dcf_sched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
index 84342241aa..de28019c5b 100644
--- a/drivers/net/intel/ice/ice_dcf_sched.c
+++ b/drivers/net/intel/ice/ice_dcf_sched.c
@@ -849,6 +849,8 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
 		   ICE_NONDMA_TO_NONDMA);
 
 	hw->tm_conf.committed = true;
+	free(vf_bw);
+	free(tc_bw);
 	return ret_val;
 
 fail_clear:
-- 
2.25.1

