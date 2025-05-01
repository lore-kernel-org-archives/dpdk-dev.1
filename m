Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEBAC3ABA9
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 May 2025 22:10:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E3A6402A8;
	Fri,  2 May 2025 00:10:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id B1361402A4
 for <dev@dpdk.org>; Fri,  2 May 2025 00:10:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746137437; x=1777673437;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NFSaMDDJyIimcam/eyde3t5/RtH/dSOyZdUweyRdmhw=;
 b=ICttQkVDy7yJYiknliUAjDfLnu5X1J98Hi1n6tvVZa8bFTDXE2zhayQN
 KUkKIDiH2XDmy3D1OahnUxVOoC4iQ21YPhBdDfZulW/Mq6kJ7HlsNDG3k
 JguxbLwuxxd26DJem+XCP7O/vqr0d0WhnBLqCyot6nQ5maP9L8X8AQDP3
 X0uj4sb5CsG4Pxs+tCBn4H53JBiwKQpGGLkRzhvlAHgjczDM7LJAboGHL
 Fx6t6F1ep5PUuzBRuemazZLHf2L0nOqEUicTW4n3pZOV9LwSMc3n9AdQM
 YqKo7xk4/5PYxsJKqaR5bavG1NuZzjg4c3cDlNKE70fcCsimxPIgCYAAN A==;
X-CSE-ConnectionGUID: W4WE3wSFQLqPM3+Xsv2taw==
X-CSE-MsgGUID: l/PUL05iRQe/9xnwvpgNcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="46930666"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="46930666"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 15:10:35 -0700
X-CSE-ConnectionGUID: iNrgT3nXRE2e5NL7UgMFHg==
X-CSE-MsgGUID: V3IflbHHSuWZXUeF41Nz3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="134998126"
Received: from spr-npg-bds1-eec2.sn.intel.com (HELO spr-npg-bds1-eec2..)
 ([10.233.181.123])
 by orviesa007.jf.intel.com with ESMTP; 01 May 2025 15:10:34 -0700
From: Nicolas Chautru <nicolas.chautru@intel.com>
To: dev@dpdk.org,
	maxime.coquelin@redhat.com
Cc: hemant.agrawal@nxp.com, hernan.vargas@intel.com,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v1 0/1] bbdev: fix possible null pointer dereferencing
Date: Thu,  1 May 2025 15:10:30 -0700
Message-Id: <20250501221031.4569-1-nicolas.chautru@intel.com>
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

Hi Maxime, 
Minor fix for warning reported by coverity.
Thanks
Nic

Nicolas Chautru (1):
  bbdev: fix possible null pointer dereference

 lib/bbdev/rte_bbdev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.34.1

