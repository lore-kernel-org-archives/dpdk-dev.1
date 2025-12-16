Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D23D5CCBF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 10:35:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1B2D402AC;
	Tue, 16 Dec 2025 11:35:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 03FFD4026C
 for <dev@dpdk.org>; Tue, 16 Dec 2025 11:35:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765881312; x=1797417312;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ybx6Iqlc/ia+NDxhoPx0Wcgbck9a2QkROMj/bkd59YI=;
 b=Gtag63xU2/OoMVyObMOHBAlQGattT58Djtda4SoYHEmh5i4W9zpk2/x8
 qbxksbHHap2Rt0sLJjFpQrkGu8AdtZ99sljumiLM6U6SGpAloiu0y6k3N
 Rtuu0EU9nbX9U/q5MIAKCelyACSCnk2qCXcQfPUUQRE0JWbCgHuj9IpwK
 uBpgAtVWQ0gSJKr0JC5KNdH2VXX42UmalJ5kR24Pp/KlkrKuBhrbajW1t
 ozE80oVt+fzzDrGjC7k5lFgc7C2S4SI5UzTWZXgjR8wBzW2BqFfD9Ag/7
 fsprImKM7g8V41MQFMze+IYv1CU7HVNroodhIxOUML//dxVX9Em5j1sm9 Q==;
X-CSE-ConnectionGUID: 45juTEo4SMmWhoAg1Ipswg==
X-CSE-MsgGUID: PDOBL2V6Sz6OPtRFJZghFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79250829"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="79250829"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 02:35:11 -0800
X-CSE-ConnectionGUID: +F+kB7NzRRe2qqMs7XICMQ==
X-CSE-MsgGUID: W3faHZEXRZSb6YyWKtVS9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="197259822"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 16 Dec 2025 02:35:10 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 0/3] Fixes for Intel common rx/tx path selection
Date: Tue, 16 Dec 2025 10:35:01 +0000
Message-ID: <20251216103504.2624535-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215140553.2283531-1-ciara.loftus@intel.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
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

Depending on the underlying architecture and CPU flags available, a
different set of Rx/Tx paths may be defined by a driver using the common
path selection infrastructure. However the path selection function
iterates through the entire array of potential paths, regardless of
whether they are available for selection by that platform. This could
result in a null burst function being selected. Fix this by discarding
paths with a null burst function from selection.

The fix for the Tx paths can be squashed into the next-net-intel tree
as the commit that it targets has not yet made it into the main branch.

I added a third commit which addresses some minor inconsistencies in the
Rx path selection code and brings it in line with the Tx path selection
code. Functionally it remains the same.

Ciara Loftus (3):
  net/intel: prevent selection of a null Tx burst function
  net/intel: prevent selection of a null Rx burst function
  net/intel: bring common Rx path selection in line with Tx

 drivers/net/intel/common/rx.h             |  42 ++++-----
 drivers/net/intel/common/tx.h             |   4 +
 drivers/net/intel/cpfl/cpfl_rxtx.c        |   8 +-
 drivers/net/intel/i40e/i40e_rxtx.c        |  40 ++++----
 drivers/net/intel/iavf/iavf_rxtx.c        | 106 +++++++++++-----------
 drivers/net/intel/ice/ice_rxtx.c          |  40 ++++----
 drivers/net/intel/idpf/idpf_common_rxtx.c |  10 +-
 drivers/net/intel/idpf/idpf_rxtx.c        |   8 +-
 8 files changed, 131 insertions(+), 127 deletions(-)

-- 
2.43.0

