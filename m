Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B4BC61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:16:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31FE740661;
	Mon,  9 Jun 2025 12:16:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id B8EE840658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749464213; x=1781000213;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=O4B2vHdEyPOnJ8sYJScQePu3Bogxn+ZIKM0+sv/z1jU=;
 b=cJh9AM0K1LheOEr1LPCf+atFZWxFBe393P+R+3Es7WvkeDjqSOuRiURJ
 MRIWW2rt5nzAHd5DlNcqKYEm8O3XMLw5aBgizcGrab3wyxerjnWCAHgyD
 wWgWlx31sD/9dDMdId5/sbdKc0mmDsH/bEHEXPqjPNi2jMg3nMlcGKttk
 yE2ocwG12MIlgM8uLggiuwNeIMC8kiqzbht46a2zk31ZYcCyGIRpKUDaD
 Eyi2I9Gx1wA8HEP/RD1ClTooUBkZ+kJ+sX+epo6lpWYKuptGVk6w1R//X
 I0zPodQjG3jidZJmPZ7GWRiwPoT4JS0vz/zmC7yKmZhXjrq+YVzp6Utc7 Q==;
X-CSE-ConnectionGUID: gkDpz4+CSIiUoMo+Pegw2w==
X-CSE-MsgGUID: L1Mx8pNLQledlrREwWL6jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="74067647"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="74067647"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:16:51 -0700
X-CSE-ConnectionGUID: 8MHEHvECSV69HRmY7AWsrw==
X-CSE-MsgGUID: qCrKJTn/QSeoIOblG5z+Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151345656"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2025 03:16:51 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 0/2] e1000 base code update
Date: Mon,  9 Jun 2025 11:16:40 +0100
Message-ID: <cover.1749464159.git.anatoly.burakov@intel.com>
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

Update e1000 base code version to 2025-06-04-14.40

Anatoly Burakov (1):
  net/e1000: update README

Vitaly Lifshits (1):
  net/e1000: better clock synchronization workaround

 drivers/net/intel/e1000/base/README          |  4 +-
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 82 +++++++++++++++++---
 drivers/net/intel/e1000/base/e1000_ich8lan.h |  4 +
 3 files changed, 76 insertions(+), 14 deletions(-)

-- 
2.47.1

