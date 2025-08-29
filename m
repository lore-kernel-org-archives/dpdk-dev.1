Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2E4CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 14:02:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D885F40263;
	Fri, 29 Aug 2025 16:02:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id C25DC4025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 16:02:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756476163; x=1788012163;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nTaYaJK7QlOHrxk8ZNhDnMSen3CFq/ohOzTB3gBf5Ug=;
 b=Vjg0RUN02HxkAjLLi+lQ/GamukBRoCzs9BJAeV2YDUBXia1h8v0CuiIy
 KzGubwu0H9q95J+PBMwhYGKQPBRDYjCTxu/3N40lLXyxrggzDstB43O4q
 Ny3AfUiVQGr5EtK6g1a/dG1/P2hjonlgimgDtaxU/E/vKnX+G7OW4djj0
 nV9YfBuKgDZs4E2l10G0FcjmT7oykBf9+BdVhyEXLCoO2dRP9w4oiK7Nk
 l6aeub/0WP0F6QqhDceS09GtE1q7jLKf8Agv2kVMslNrYB1Xp9kzo2Eov
 Vrq+zZRPwSD63WN4mX5LeDbIwxgcss+EgdkqA00o1NHpoeRuaUxq92K0m w==;
X-CSE-ConnectionGUID: vo1GlI87TsaBiRCN3/buRA==
X-CSE-MsgGUID: x6aWzFvxT+adbVDPg+Vp6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="84166911"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="84166911"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 07:02:40 -0700
X-CSE-ConnectionGUID: cbqcwiwrQ52gkPPboGllFA==
X-CSE-MsgGUID: 9g6lGjIwScWYAsll/rnuSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="170295665"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa006.fm.intel.com with ESMTP; 29 Aug 2025 07:02:39 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC PATCH 0/3] Make Link Status on Close Configurable
Date: Fri, 29 Aug 2025 14:02:21 +0000
Message-Id: <20250829140224.1748255-1-ciara.loftus@intel.com>
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

Most drivers bring the port link down on device close (eg. intel i40e), however
some others restore the link to its original state when the device was started
(eg. intel ice). It may be useful to be able to configure this behaviour which
is the motivation for this RFC.

This RFC proposes a way to make the link status of a port configurable
when the port is closed or stopped. Three configuration options are available:
1. down: bring (or keep) the link down
2. up: bring (or keep) the link up
3. initial: restore the link to the state it was in when the device was
started.

Ciara Loftus (3):
  ethdev: add set link state on close API
  net/ice: implement the link state on close device op
  app/testpmd: support link state on close ethdev API

 app/test-pmd/cmdline.c                      | 56 +++++++++++++++++++++
 app/test-pmd/config.c                       | 17 +++++++
 app/test-pmd/parameters.c                   | 26 ++++++++++
 app/test-pmd/testpmd.c                      | 16 ++++++
 app/test-pmd/testpmd.h                      |  3 ++
 doc/guides/rel_notes/release_25_11.rst      |  4 ++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  7 +++
 drivers/net/intel/ice/ice_ethdev.c          | 20 +++++++-
 drivers/net/intel/ice/ice_ethdev.h          |  1 +
 lib/ethdev/ethdev_driver.h                  | 18 +++++++
 lib/ethdev/ethdev_trace.h                   |  8 +++
 lib/ethdev/ethdev_trace_points.c            |  3 ++
 lib/ethdev/rte_ethdev.c                     | 19 +++++++
 lib/ethdev/rte_ethdev.h                     | 32 ++++++++++++
 14 files changed, 229 insertions(+), 1 deletion(-)

-- 
2.34.1

