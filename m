Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825E606A31D
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VQC+S2mv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72677402DC;
	Wed, 28 Oct 2026 11:44:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTPS id 4A9D4400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 11:43:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793184238; x=1824720238;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0R0vtXpskDzL58ccUtxRHMiHqwxBgQRNDajN0TImruo=;
 b=VQC+S2mv1AuKyhZdbmjKWntErhwsbTKJFys1NIPytIqQAoDutNZnFr0f
 gp0ir8d8LwVsFAbR0/U1qQPM96E1Mr7UcNVfrnOORgldcZ+dHWrG8Z8HW
 speUlnH3EkLkmdqVbvwBw/Ki2ZjTTCt1kobwVW73p5Y4CSTyMmbb6ymcw
 GYwFS+iVJzWIrXhZFYqpuAFl1IpJGW7lMWpGHT+11bffyWw1eq/MFLPD9
 WM7C31Ic/Twv+K9SNrAb+oYcAYKnWMBqD3NP0QaCX88f7raUvUBMnysmG
 vY63l5TRYXvRRjtgsV1NEvoZfjsJF7R0V7/R80TLOXBLiPYSUWw6b9s6o w==;
X-CSE-ConnectionGUID: jz3UmgIkS8S1k816CPguAA==
X-CSE-MsgGUID: Grb4nN87TiK4/XZUPftSGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1786282"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1786282"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 03:43:56 -0700
X-CSE-ConnectionGUID: 5NbdxSinRI+Hz5Nj6O9iOA==
X-CSE-MsgGUID: M4vZoidTTc+4U3D4w2fQ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4773138"
Received: from npg-npf-wlpr-srv19.iind.intel.com ([10.190.212.201])
 by orviesa001.jf.intel.com with ESMTP; 28 Oct 2026 03:43:55 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v2] net/intel: add 400G link speed support
Date: Wed, 28 Oct 2026 16:13:51 +0530
Message-Id: <20261028104351.1116648-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028095132.1110128-1-shaiq.wani@intel.com>
References: <20261028095132.1110128-1-shaiq.wani@intel.com>
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

The idpf and cpfl PMDs map the device-reported link speed (in Mbps)
against a fixed table of supported speeds. That table stopped at 200G,
so ports operating at 400G reported their link speed as "Unknown":
the advertised 400000 Mbps had no matching entry in the driver's
supported-speeds table and the link update fell back to
RTE_ETH_SPEED_NUM_UNKNOWN.

Add RTE_ETH_SPEED_NUM_400G to the supported-speeds table of both the
idpf and cpfl drivers so the correct 400 Gbps link speed is reported.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
v2:
 - add trailing comma after the last array entry making later additions easier.
 - also add the 400G entry to the cpfl driver.

 drivers/net/intel/cpfl/cpfl_ethdev.c | 3 ++-
 drivers/net/intel/idpf/idpf_ethdev.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 32e0f81d99..789bfd08f9 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -67,7 +67,8 @@ uint32_t cpfl_supported_speeds[] = {
 	RTE_ETH_SPEED_NUM_50G,
 	RTE_ETH_SPEED_NUM_56G,
 	RTE_ETH_SPEED_NUM_100G,
-	RTE_ETH_SPEED_NUM_200G
+	RTE_ETH_SPEED_NUM_200G,
+	RTE_ETH_SPEED_NUM_400G,
 };
 
 static const uint64_t cpfl_map_hena_rss[] = {
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index e9e9781fdd..0a0bcdf48d 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -46,7 +46,8 @@ uint32_t idpf_supported_speeds[] = {
 	RTE_ETH_SPEED_NUM_50G,
 	RTE_ETH_SPEED_NUM_56G,
 	RTE_ETH_SPEED_NUM_100G,
-	RTE_ETH_SPEED_NUM_200G
+	RTE_ETH_SPEED_NUM_200G,
+	RTE_ETH_SPEED_NUM_400G,
 };
 
 static const uint64_t idpf_map_hena_rss[] = {
-- 
2.34.1

