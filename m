Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46F2C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 04:42:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A86E4026A;
	Thu, 31 Jul 2025 06:42:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 97C104025A
 for <dev@dpdk.org>; Thu, 31 Jul 2025 06:42:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753936935; x=1785472935;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=D2kHzF5Ci5AyK3ls2VYuCgm/T30QzOdgmkmG8J5swPw=;
 b=cu7qtx2J0lLR+PiIhjwK56wPLvitP3u06u201U9/yOdhMMuPOKZA4Kxq
 Vb3nEvtYTQdo4GOXF1ecAWx8gTilCMOkiQjd1OYus2LlrzeGmxr50hDPj
 gYWL+ZBbzVn9M8TJ5fVzwpaL0We6ZzAVW7YMcdCssqEfk/C0wPPM+EiDB
 xgt3w5F8/QcFc8KZEQ84YQEJLyLUUYpb2/0Z7nFOS7gf51OQrsPLxdU7V
 q7o4n7utYPXhsJoqwXqnv8XC0GODGjjkSkNn1F60CwH4iy+RfECs/fWfi
 JEbrv2Lr/q0S+EgofQjbbA/fQeL2a7F+up/pI4g3gArZPxAXIIJKSqFyy Q==;
X-CSE-ConnectionGUID: qT9+26v2SkCp3NOwkQ09TQ==
X-CSE-MsgGUID: j3EdubW6RJa1Kyk0Ut0log==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="81702731"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="81702731"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 21:42:14 -0700
X-CSE-ConnectionGUID: +2QJNbDsShqB+ZXOS6vSTw==
X-CSE-MsgGUID: RsUo1Wd8T/2gCMnY+1T2Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="163614035"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 30 Jul 2025 21:42:13 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 0/2] net/ice: fix drop rule handling and stats
Date: Thu, 31 Jul 2025 10:11:30 +0530
Message-Id: <20250731044132.110174-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Patch 1.Tx packets were dropped when a drop-any rule was applied
        only on ingress. A direction lookup flag is added to resolve this.
Patch 2.Added accounting for Rx drop packets in ipackets and ibytes.

Shaiq Wani (2):
  net/ice: add flag for direction lookup to occur
  net/ice: count drop- all filter stats in Rx stats

 drivers/net/intel/ice/base/ice_switch.c   | 8 ++++----
 drivers/net/intel/ice/ice_ethdev.c        | 3 ++-
 drivers/net/intel/ice/ice_switch_filter.c | 2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.34.1

