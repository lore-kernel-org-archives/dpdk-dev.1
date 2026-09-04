Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090BEC624D3
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 10:52:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24F3B42EE7;
	Fri,  4 Sep 2026 12:52:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 74BDD42EDC
 for <dev@dpdk.org>; Fri,  4 Sep 2026 12:52:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788519148; x=1820055148;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DNIzikxNx74++QD3AimunkJMKw8i5cq9W7RJmVDZ6ac=;
 b=WOLIzPoiae2kJL3z3wZ1eiOQ2jNsDG0Ce37BXP082R6RjA9EDhnMif0c
 CLOBtcYSL1xJa1FMQUm7c0OUcFAY5X7EH0Jo8iaffcIgedfiIfL9UKo1G
 IOR/OmBIr7sFxLkOyPWb9AmIBiWsbX/Twdk2f2ILol21HPBCvEU4CnO7h
 7jQTRNGSlWEP1PhrtH5vOyo+28QBI/ScJ63T20C7ELLoAw0N/tBzJocpI
 mTeFXhOKKZIM0bMH0FRlJk/1B8v5kH97Dy4fIIMXK+uh9IB/ntRIkaMYp
 +B9ynuhfFFOyU7WMyal4YKxUZjpze9eZ3vGxPqurtGOgQp+2HOJfPtWjM A==;
X-CSE-ConnectionGUID: Pm4JfrjBSBaNfLnhMzMtig==
X-CSE-MsgGUID: OUa+QIdpSbm7ogjnhcg56g==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76573768"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="76573768"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 03:52:27 -0700
X-CSE-ConnectionGUID: trY0bcJJQPyNrg6zlzM4Xw==
X-CSE-MsgGUID: Bhjz8wf6Rxm24qlpWoH2jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="308223629"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa001.jf.intel.com with ESMTP; 04 Sep 2026 03:52:25 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/3] net/ice: fix Tx scheduler hierarchy queue accounting
Date: Fri,  4 Sep 2026 10:51:36 +0000
Message-ID: <20260904105139.3117640-1-ciara.loftus@intel.com>
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

Committing a Tx scheduler (rte_tm) hierarchy on ice can grow the port's
usable Tx queue count beyond what was available when the port was first
probed. This series fixes three bugs related to this.

Ciara Loftus (3):
  net/ice: fix Tx queue capacity sizing after TM commit
  net/ice: skip TC validation if hierarchy committed
  net/ice: fix Rx queue count reporting after TM commit

 drivers/net/intel/ice/ice_ethdev.c |  9 ++++++--
 drivers/net/intel/ice/ice_ethdev.h |  3 +++
 drivers/net/intel/ice/ice_rxtx.c   | 33 ++++++++++++++++++------------
 drivers/net/intel/ice/ice_tm.c     | 10 ++++-----
 4 files changed, 35 insertions(+), 20 deletions(-)

-- 
2.43.0

