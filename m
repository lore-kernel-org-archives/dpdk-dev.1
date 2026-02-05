Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41208EC1E91
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 10:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 260E840E2B;
	Thu,  5 Feb 2026 11:30:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id A78CF40264
 for <dev@dpdk.org>; Thu,  5 Feb 2026 11:30:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770287427; x=1801823427;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WZQchWTavzYLYoyo80ESNYlxLyz2ODPD6R0W8Hk0ISc=;
 b=E+SDqvN6blI7sMjsqnMQSsc7JkgCMk3LtAWdJktzyi+8ZVTWEBBIUVkg
 jdLvHMT7Fh4AFunC/yyG+Pf0iiohzYu1SDAsl4TDfNhVefQLi22M4T1N4
 sFhqGDV/pVUa/xrvhZmlOrKEzdjYHQ7sTUd30iK36YUKuRtVqiK43tYNK
 8qdfyGQc4mH6yiswJfhvSH5vocBxz3H40Rl5CqfDKvqiSkRvMo6InbAJI
 ErutE2ngw9+MqqCq7mGT0ssd8HmWQkYX3NUHrK2+5Yng6NTwY6K60V13G
 F2okV+3Sg9PjE+oNdIHUrydsETwexlaAJljBC5BjdSq4+3oEdjWn3PLTy g==;
X-CSE-ConnectionGUID: deJFPlfJRYqjXoXS26krFg==
X-CSE-MsgGUID: x0unK+RNRVyGgdGdreS9Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="89064762"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="89064762"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 02:30:25 -0800
X-CSE-ConnectionGUID: etzlssTZRdaR5NJpJ9i5Vw==
X-CSE-MsgGUID: H1mrw5VqTfKAYa2RBd55gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="210447550"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2026 02:30:25 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 00/10] Fix multi process path selection in Intel drivers
Date: Thu,  5 Feb 2026 10:29:58 +0000
Message-ID: <20260205103008.190493-1-ciara.loftus@intel.com>
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

This series fixes and makes consistent the approach to selecting Rx and
Tx paths in a multi process scenario across the Intel drivers that use
the common path selection framework.

In v25.11 the i40e, iavf and ice drivers prevented Rx path selection by
secondary processes, in favour of simply selecting the path chosen by
the primary process. However, this model does not work if the primary
process hasn't started the device before the secondary process
encounters the path selection logic. To address this, permit path
selection by any process, so long as the device has not yet been
started. This allows for the use case where the secondary process is the
process that starts the device.
The idpf and cpfl drivers are updated to follow this model as well.

The same issue exists for the Tx path selection for i40e, iavf, ice,
idpf and cpfl, so implement the same logic when selecting a Tx path as
well ie. permit path selection if the device has not been started.

I kept the patches for fixing the Rx and Tx path selection separate, as
the patches that target the Rx side will need to be backported to v25.11
whereas the patches for the Tx side do not as that logic was introduced
post v25.11.

Ciara Loftus (10):
  net/i40e: permit secondary process Rx path selection
  net/iavf: permit secondary process Rx path selection
  net/ice: permit secondary process Rx path selection
  net/idpf: prevent Rx path selection after device start
  net/cpfl: prevent Rx path selection after device start
  net/i40e: permit secondary process Tx path selection
  net/iavf: permit secondary process Tx path selection
  net/ice: permit secondary process Tx path selection
  net/idpf: permit secondary process Tx path selection
  net/cpfl: permit secondary process Tx path selection

 drivers/net/intel/cpfl/cpfl_rxtx.c | 9 +++++++--
 drivers/net/intel/i40e/i40e_rxtx.c | 8 ++++----
 drivers/net/intel/iavf/iavf_rxtx.c | 8 ++++----
 drivers/net/intel/ice/ice_rxtx.c   | 8 ++++----
 drivers/net/intel/idpf/idpf_rxtx.c | 9 +++++++--
 5 files changed, 26 insertions(+), 16 deletions(-)

-- 
2.43.0

