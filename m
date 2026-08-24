Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B29C5DF94
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 10:23:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C7DD4028B;
	Mon, 24 Aug 2026 12:23:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7B1F740270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 12:23:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787566984; x=1819102984;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GTydv5UW7SxV4lTbxMeltVAAp1N+5SFk80P/xisimH8=;
 b=hDgchFTGUG9g1xR/k3u9y0iw+84dHXmoJTortq7ehWkrNdWS5dxhhLtD
 JSXcqyYolMTaq8B7K2fkalo34vljkPbKQR69v9n1i6yccMcua/Y1bf8MX
 zgltnWNu/j5BU7EinvBp1FSdbfmJm+Ff871VxSErBB+aHOCIangte+PWt
 wkcU6EP+Iy2DodxmmnARZk5/o1A2KxxKc8Haummrj75GmAfpdSMwAaIwv
 ih79mEZjw4ws0YFauE8Pl73NI7vrKo9C0Xk3qHAffgAPIfj+Tysiewl69
 O9wksXjpbey+BDiKln7OnMqA36yhSqF/Q1O17GDTqyfe4LuX0ROZGJ3aX g==;
X-CSE-ConnectionGUID: nxQ56rLxSq+Pd+LIV01nHQ==
X-CSE-MsgGUID: JAfp8NasQ1CugQhrZZZJbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87884920"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="87884920"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 03:23:00 -0700
X-CSE-ConnectionGUID: R+r8eR5QRmWL0s6+lFvoDQ==
X-CSE-MsgGUID: HCgy3rZdQSuzT7zKFINVaw==
X-ExtLoop1: 1
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa003.fm.intel.com with ESMTP; 24 Aug 2026 03:22:59 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 0/4] net/ice: support outer checksum in vector Tx
Date: Mon, 24 Aug 2026 10:21:50 +0000
Message-Id: <cover.1787566677.git.anurag.mandal@intel.com>
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

Added AVX2 and AVX-512 context descriptor Tx paths 
for outer IPv4 and UDP checksum offloads, 
avoiding scalar Tx fallback.

Anurag Mandal (4):
  net/common: share Tx context descriptor flag
  net/ice: add vector tunnel context encoding
  net/ice: add AVX2 context descriptor Tx path
  net/ice: add AVX-512 context descriptor Tx path

 doc/guides/rel_notes/release_26_11.rst      |   6 +
 drivers/net/intel/common/tx.h               |   2 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c      |   4 +-
 drivers/net/intel/ice/ice_ethdev.h          |   2 +
 drivers/net/intel/ice/ice_rxtx.c            |  41 +++++-
 drivers/net/intel/ice/ice_rxtx.h            |  11 ++
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 119 +++++++++++++++++
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 141 ++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx_vec_common.h |  53 +++++++-
 9 files changed, 371 insertions(+), 8 deletions(-)

-- 
2.34.1

