Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08A2CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:19:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0220F4064C;
	Wed, 14 Oct 2026 17:19:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id D0FCA402EF
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:19:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791991166; x=1823527166;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=a0OVwzDQXGccCyTyyChdjJwM9v/UFTXFefxB/mtR8ZY=;
 b=ch9B8YqXb/dJjMfEJbkt8/CkDc1QEJUTz2p0QeuJ7zOYSgS0rsT3liTH
 K88JfChsW8xscQ83LxJQpIAdPl3FmWJl+NLp1xbypCVg5adL2nwBS5EGl
 sZIHS3gnTPMLPm74Mn+64S/+KFhs3Hh04SrFJ4MeBz3Vkyw17fDmRAAOT
 8Ka0J5xbsJSeDuRMh3T1WxXTWXn5pfnNF0njC4Vx6RFhTI7ogM2XUmBtL
 bvhH6wlC+idXHHAU+WLbeVN0DMmQ3soGaWPRgUSHLwE4I5tdYWD+n3y/d
 DWqnBh+K0qJbAhTLnPIDb1e2emz4x3+UkX4iTKY9h9EsrWxvK3OE0URkb A==;
X-CSE-ConnectionGUID: 4wqCaTTRR6CrKjsmjfHBRw==
X-CSE-MsgGUID: Gge4w+azS+yb5ndqB//QUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="646284"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="646284"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 08:19:00 -0700
X-CSE-ConnectionGUID: AZCTuc2ZTNegrBZ9WWADJg==
X-CSE-MsgGUID: qjooqJkiTLWYtNmbBLHvnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3294625"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 14 Oct 2026 08:18:58 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 0/7] IAVF Fixes
Date: Wed, 14 Oct 2026 16:18:43 +0100
Message-ID: <cover.1791991100.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

An assortment of IAVF flow-related memory leak fixes and cleanups.

Anatoly Burakov (7):
  net/iavf: fix memory leak in flow teardown
  net/iavf: fix null engine for egress security flows
  net/iavf: fix generic flow error-path leaks
  net/iavf: fix flow subscription metadata leaks
  net/iavf: fix hash flow metadata leaks
  net/iavf: fix IPsec flow metadata leaks
  net/iavf: do not store ethdev pointer

 drivers/net/intel/iavf/iavf.h              |   9 +-
 drivers/net/intel/iavf/iavf_ethdev.c       |  13 +-
 drivers/net/intel/iavf/iavf_fdir.c         |   3 -
 drivers/net/intel/iavf/iavf_fsub.c         |   7 +-
 drivers/net/intel/iavf/iavf_generic_flow.c |  58 +++----
 drivers/net/intel/iavf/iavf_generic_flow.h |   4 +-
 drivers/net/intel/iavf/iavf_hash.c         |  24 ++-
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 191 +++++++++++++++++----
 drivers/net/intel/iavf/iavf_ipsec_crypto.h |   4 +-
 drivers/net/intel/iavf/iavf_vchnl.c        |   7 +-
 10 files changed, 222 insertions(+), 98 deletions(-)

-- 
2.52.0

