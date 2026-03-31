Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5C0109B463
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:02:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1F4E4042F;
	Tue, 31 Mar 2026 15:02:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id EC372402C3
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:02:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774962133; x=1806498133;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=o5IQbrJFvKezdQJ/gkZwpKhochghqghskCMf56tsVVg=;
 b=CG5cdYywBbrkGgRya9+AtCzNbLEuoBxH1UQRo30NStAJ3BPbucMy+5A0
 vJwxbFFN9L43ClhpvtqJEU08BXkA2hRfR9qJlFvFSiviAwx3r3AHGvNrp
 9n8LuS7EDTw7U17VhxjwuKX5psCUs8sCN5UhHdR4g1Agtp1aWk6leKj8h
 U10OSXjlJA48xH5jMUQTjPBAVgG68e9RqCGZKoBNF62E/sHPqPSJxIlty
 2Iqc2V5pqw8Q7Z6oF7W//QY54UlRyL2OoKPXCzi1Rl7WMfN58TW8e09IO
 9j5mbzmeDFQTNgWBiDVmZ3wGq82X4I/cuwzm/LKUh+L1d1qPdAES6zYfS Q==;
X-CSE-ConnectionGUID: KEzrbp4uQuaOWMMyIhvTbw==
X-CSE-MsgGUID: 92g1rTvYRhK4MujpPHx9WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75868400"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="75868400"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 06:02:11 -0700
X-CSE-ConnectionGUID: IHhGWboPTxyMTQ1jt4QY6Q==
X-CSE-MsgGUID: ycZFSc7vSWyOJM0+e2CZVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="223481671"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa008.fm.intel.com with ESMTP; 31 Mar 2026 06:02:10 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/4] net/iavf: improve VF reset resilience
Date: Tue, 31 Mar 2026 13:01:16 +0000
Message-ID: <20260331130120.2471971-1-ciara.loftus@intel.com>
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

Previously, VF recovery from PF-initiated resets required explicit
opt-in via auto_reset, leaving VFs non-functional by default after a
reset unless the application handled it. This series makes transparent
recovery including the restoration of settings the default, and
implements some fixes related to the reset path as well.

Patch 1 fixes a regression which prevented promiscuous mode from being
disabled before sending the RESET_VF message to the PF during device
close.

Patch 2 enables the auto_reset and no-poll-on-link-down devargs
by default so VFs recover from resets without the need to introduce any
reset handling in the application.

Patch 3 introduces a new auto_reconfig devarg (on by default) which
extends the recovery path to restore unicast and multicast promiscuous
state after a reset. Restoration of additional settings such as VLAN
filters could be added under the same mechanism in a follow-up series.

Patch 4 fixes a minor logging issue.

Ciara Loftus (4):
  net/iavf: fix disabling of promiscuous modes on device close
  net/iavf: enable auto reset by default
  net/iavf: enable post-reset restoration of VF settings
  net/iavf: fix reset handling error log

 doc/guides/nics/intel_vf.rst         | 15 ++++--
 drivers/net/intel/iavf/iavf.h        |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c | 75 ++++++++++++++++++++++++----
 3 files changed, 77 insertions(+), 14 deletions(-)

-- 
2.43.0

