Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1887DCA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 19:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AE254060B;
	Tue, 26 Aug 2025 21:43:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 465D14029E
 for <dev@dpdk.org>; Tue, 26 Aug 2025 21:43:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756237397; x=1787773397;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eRmMB9i+qKIv06GyameahWwc2w3haPomGDxZRHhb29Q=;
 b=mUV+3UFn9BBMgd1notGqq5QOk7fzSuMXOw9RBRgYFunMXBxJg7HTUWAE
 jtgNATPgOuOzjzo9GygxIDmAnTgCrKjD+0BaF2hArScyfdmz5RepzD281
 ROp0JYHuMoQIVBCGYfnBL33loaeGDPnPzDPH3i4EHBwR3FpRnjHhnO0+x
 WwnKXAsTj978gk6girGzpqxcFDf0WrIfN7reEDay+Ce9ftqfhCN8LXN3Q
 VTpMcp63ztOGYihzVSS5af8nHoyRrVaCu7AKHPemfik0F4/iH31u1Jlnn
 Moa2aregjbmDPFmgRGzRvJf1mJRjzGOorLGI9omYGjue0kGHzzJG/7HjR Q==;
X-CSE-ConnectionGUID: zdndk2qxTS2dj9cFi3ZYAg==
X-CSE-MsgGUID: WLD4upt7QaiL+lc+YHzv9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62300032"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="62300032"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 12:43:15 -0700
X-CSE-ConnectionGUID: VmCYJt+vRs2uBBgDtX6CmA==
X-CSE-MsgGUID: dv/RNEMURKOvx08tcUenEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169592170"
Received: from unknown (HELO spr-npg-bds1-eec2..) ([10.233.181.123])
 by fmviesa006.fm.intel.com with ESMTP; 26 Aug 2025 12:43:15 -0700
From: Nicolas Chautru <nicolas.chautru@intel.com>
To: dev@dpdk.org,
	maxime.coquelin@redhat.com
Cc: hemant.agrawal@nxp.com, hernan.vargas@intel.com,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v1 0/2] doc: bbdev clarifications
Date: Tue, 26 Aug 2025 12:43:22 -0700
Message-Id: <20250826194324.95284-1-nicolas.chautru@intel.com>
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

Hi, 
Some minor clarifications to document based on 
feedback from users.
Thanks
Nic

Nicolas Chautru (2):
  doc: clarify CB vs TB level device support
  doc: clarify the window index usage in bbdev

 doc/guides/bbdevs/acc100.rst        | 1 +
 doc/guides/bbdevs/fpga_5gnr_fec.rst | 1 +
 doc/guides/bbdevs/fpga_lte_fec.rst  | 1 +
 doc/guides/bbdevs/vrb1.rst          | 1 +
 doc/guides/bbdevs/vrb2.rst          | 2 ++
 doc/guides/prog_guide/bbdev.rst     | 7 +++++--
 6 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.34.1

