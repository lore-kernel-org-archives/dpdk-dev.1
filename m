Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F51CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 14:34:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0402B402DD;
	Wed,  3 Jun 2026 16:34:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6DCFD402A9
 for <dev@dpdk.org>; Wed,  3 Jun 2026 16:34:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780497280; x=1812033280;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wua6o90HDpLuCJXt3ZyyTU1SBgkOnhOu37DGv2XnvXM=;
 b=iSqZQWnGKzRwrCC5XyJhcrdL6ws+bSPsV6JYjm+LDj/3KfFD2vksRGir
 sfY68ncbj3eAw6+FZ9ssERIfl5v281wmCbtNTGU+ecTeccYNSHHZplz0K
 lvS0jFlrZ58c+Kno5GANiMYvc6VxIGsgBSOR5BGcUUtEUsJord3CNmDO3
 O98qqyTjSlYpTHFs207UCR9oLlIZV4tGDGFy17gOtE6Xn/spKyEsRYJGF
 S65jqODq51VnNZh2yROP4o8cnPMkv/24vSmUeKu0O8ioI6h9WiOdyLBwn
 0u6I8s/PAKS2sfoC+0AatpcN2cL87MPQl8pYF7gV4NXhttLL1oL1bAOJz g==;
X-CSE-ConnectionGUID: dUOQRsp/TOiSMccCo28R8A==
X-CSE-MsgGUID: S3B4zntITkWXoJatCq4Kuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91882183"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="91882183"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 07:34:38 -0700
X-CSE-ConnectionGUID: bQ3eAI8NQ3ixiQy5b8AIsQ==
X-CSE-MsgGUID: X3A4TzO0QcqfImRiM7A0lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="244106816"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa008.jf.intel.com with ESMTP; 03 Jun 2026 07:34:37 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/2] net/intel: fix blocking link wait on device start
Date: Wed,  3 Jun 2026 14:34:05 +0000
Message-ID: <20260603143407.1108527-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

Device start in both ice and i40e has historically blocked for up to
two seconds waiting for link to come up before returning. This causes
noticeable startup delay when a link partner is slow to come up or
absent entirely. This series reverts the wait in ice, and removes the
wait in i40e while ensuring that the MAC config is applied when the
link is up which is a requirement for some devices.

Ciara Loftus (2):
  net/ice: revert fix link up when starting device
  net/i40e: fix blocking link wait on device start

 drivers/net/intel/i40e/i40e_ethdev.c | 25 +++++++++++++++++++++----
 drivers/net/intel/i40e/i40e_ethdev.h |  2 ++
 drivers/net/intel/ice/ice_ethdev.c   |  2 +-
 3 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.43.0

