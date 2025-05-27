Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A01BC54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 22:36:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F16C64028F;
	Wed, 28 May 2025 00:36:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id BF0EC4027A
 for <dev@dpdk.org>; Wed, 28 May 2025 00:36:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748385393; x=1779921393;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=j7EDBLcmhDhsf+CrHo8tMYyEyIIzVimzsn+m0/QK+5I=;
 b=lR+BOsPJP9u+hQWUgkKbJcPR+Oztygy/5w03DIFv+X1iqQFdf9SusXqb
 Rq/1V7e4hKYPwxmmPXp8LChyweL7i4OGMcsfNEFwilZXYs2YOW4PG4GuS
 HDD0ILPyfrAAeunfrpn91ra2D1jJ3cmRv6LmJJV7BE+qVL3ZmetWvfDcp
 6JCa4H6x5/DSXXR3yjPxfWQUmszvlZIoChiA6s34775yufHMBEtxkzkX9
 bfyPERpOwKho8vEJ9Z4ZRqy54dEO3vLXQEs9SRor+f8N6Ov42SrOZBqbu
 uHCwofRJrqLI69323+OWiFWDdX+Ph5wUaxbSdYOTa9NkUslAnLnUMgxJx w==;
X-CSE-ConnectionGUID: d2n5f9H+SfqXH/tQF6GajA==
X-CSE-MsgGUID: vqcP0DSDTVmN8VaWLSHvoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50322735"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="50322735"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 15:36:32 -0700
X-CSE-ConnectionGUID: a5jd+UVRREK+XHQOyF+LZA==
X-CSE-MsgGUID: +GcThH8RSBaj6lu+khjdDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="143973149"
Received: from spr-npg-bds1-eec2.sn.intel.com (HELO spr-npg-bds1-eec2..)
 ([10.233.181.123])
 by fmviesa009.fm.intel.com with ESMTP; 27 May 2025 15:36:31 -0700
From: Nicolas Chautru <nicolas.chautru@intel.com>
To: dev@dpdk.org,
	maxime.coquelin@redhat.com
Cc: hemant.agrawal@nxp.com, hernan.vargas@intel.com,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v1 0/2] bbdev: add trace point per operations
Date: Tue, 27 May 2025 15:36:40 -0700
Message-Id: <20250527223642.31577-1-nicolas.chautru@intel.com>
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
Follow up on previous discussion on trace point for failed operation.
Add a trace point per operation type, so that we can add into
existing tracepoint framework the details of the set of parameters
for an operation rejected by the driver.

Thanks
Nic

Nicolas Chautru (2):
  bbdev: add trace points per operation
  baseband/acc: add trace points per operation

 drivers/baseband/acc/acc_common.h |   1 +
 drivers/baseband/acc/vrb_trace.h  |   4 +-
 lib/bbdev/bbdev_trace.h           | 113 ++++++++++++++++++++++++++++++
 lib/bbdev/bbdev_trace_points.c    |  12 ++++
 lib/bbdev/rte_bbdev.c             |  24 +++++++
 lib/bbdev/rte_bbdev.h             |  14 ++++
 6 files changed, 166 insertions(+), 2 deletions(-)

-- 
2.34.1

