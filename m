Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4C9FCA18E
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 21:17:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C480840269;
	Mon,  9 Mar 2026 22:17:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 7632240261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 22:17:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773091058; x=1804627058;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XfxsBB7Bq+k6smMR5+Q3Dzf6iXlxcBSbf/dg6S6Kx2M=;
 b=efW2o2k6Cvky6RfIvPHuNV79UqL2hiCiyIZuX3Wb6qkJ/3mlONtOLZUG
 5CvWN0N70DWdUVKF/AM/Lx2Cyy01NFwKXDxXRMy9MlXI7Hyr3KdMFay9s
 dw/5fNbbmDw48ZZi9l/AjnOzZ7YJMsTiJ6RmILWPmlGKf9YnNf1fXwuD5
 n4R6Sh+3Wq4i/L6+Iz9z5ezJ86Jt1igBtpTNuLEB2WLhP+K73HkKyZj57
 k2OgY2rrocCpKkLxObx55Ii1e4tdBr9FLxhlUvD0bDQ9P2SSMDsg4x4Dn
 pa5slVdV0DNl8CkddZBNoDnMDBVWd07WbHl6x6DOE/vU07znmPibpiYMx w==;
X-CSE-ConnectionGUID: wKiWQvdsTLmpiAt8/vA65w==
X-CSE-MsgGUID: X319AAlkR+uVzqs+XidrOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74240879"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74240879"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 14:17:37 -0700
X-CSE-ConnectionGUID: aMIhWWp0QqKP4aAOW/EXrg==
X-CSE-MsgGUID: dBls39AkT6i3NQN/anbUqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="219015753"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa006.jf.intel.com with ESMTP; 09 Mar 2026 14:17:35 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Subject: [PATCH v1 0/6] Update ICE Base Driver
Date: Tue, 10 Mar 2026 05:52:03 -0400
Message-ID: <20260310095218.703423-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
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

This series updates shared code of ICE PMD.

Aleksandr Loktionov (1):
  net/ice/base: enable LLDP filter control for E830

Grzegorz Nitka (1):
  net/ice/base: fix 'adjust' timer programming for E830

Maciej Paczkowski (1):
  net/ice/base: resolve comparison-with-wider-type violations

Paul Greenwalt (2):
  net/ice/base: update crash on invalid topology
  net/ice/base: support RDMA on 4+ ports of E830

Pawel Sobczyk (1):
  net/ice/base: add pending admin queue events API

 drivers/net/intel/ice/base/ice_acl_ctrl.c |  6 +++---
 drivers/net/intel/ice/base/ice_bitops.h   | 14 +++++++-------
 drivers/net/intel/ice/base/ice_common.c   | 22 ++++++++++++++++------
 drivers/net/intel/ice/base/ice_common.h   |  1 +
 drivers/net/intel/ice/base/ice_controlq.c | 16 ++++++++++++++++
 drivers/net/intel/ice/base/ice_dcb.c      |  8 ++++----
 drivers/net/intel/ice/base/ice_ptp_hw.c   |  6 +++---
 drivers/net/intel/ice/base/ice_sched.c    | 13 ++++++++++++-
 drivers/net/intel/ice/base/ice_switch.c   |  2 +-
 drivers/net/intel/ice/base/ice_type.h     |  7 ++++++-
 10 files changed, 69 insertions(+), 26 deletions(-)

-- 
2.47.1

