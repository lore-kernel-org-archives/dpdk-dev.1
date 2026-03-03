Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A32EDA693
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:22:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B979A402B0;
	Tue,  3 Mar 2026 17:22:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id E8300402AA
 for <dev@dpdk.org>; Tue,  3 Mar 2026 17:22:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772554927; x=1804090927;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tS6gw/R1I76UTcpUSnXtTjM8KR3+TkSux75OhGP5j3w=;
 b=FbBdtThzIybm9jqU/Jy2ZfB0maOTSE5kay100Rf4RANDQRlFd5rFvCmt
 zfqkz4AlzIr3e0b40dK36uUFvrBFqQe2AFocRsddkHoRRkVsnXw5r2pF1
 frMpv6a3M38CmNVK+DMzR2prX4uVHpUeho2hvX02YnRehDrUj52MRXPId
 Kh3Noj38wNYHvTsMdQWdmtTqxSXvA0zYkNtztpJ3bEZkyEBVQo1K6aK/K
 ZG6rWhrtoKuNC6F5ofvCNebvPAop5SfHeRk230br+m2ykYdWvewVjfT+N
 nheSHpHiWvCViIzZsxygghj2NEYDxxP7MjT8xHxFL1AsM+LWesjZPhHqX g==;
X-CSE-ConnectionGUID: wLZQQ39BTJyHszhY7snq2g==
X-CSE-MsgGUID: QyTf5yC3TTabxGqBxUtlIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="76198951"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; d="scan'208";a="76198951"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 08:22:04 -0800
X-CSE-ConnectionGUID: sBQEFbc5RBCOdJIWvqH8Qg==
X-CSE-MsgGUID: tn+sHik/R1i1b0J1bChWZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; d="scan'208";a="223049298"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 03 Mar 2026 08:22:03 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 0/2] net/ice: get link status updates via adminq message
Date: Tue,  3 Mar 2026 16:21:55 +0000
Message-ID: <20260303162157.1634379-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227110205.4099981-1-bruce.richardson@intel.com>
References: <20260227110205.4099981-1-bruce.richardson@intel.com>
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

As explained in patch 2, change the link status tracking to be via receipt
of an adminq message rather than directly querying the link status on
interrupt. As part of this change, we can reduce the cost of using the
adminq by removing the need to allocate and free memory but instead just
use the stack to store any received adminq messages.

V4: resubmit to recheck in CI, now that next-net-intel tree is clean

V3: added patch 1 to reduce cost of querying the adminq.

v2: rebase on next-net-intel

Bruce Richardson (2):
  net/ice: remove malloc call for admin queue msg
  net/ice: get link status updates via adminq message

 drivers/net/intel/ice/ice_ethdev.c | 62 ++++++++++--------------------
 1 file changed, 21 insertions(+), 41 deletions(-)

--
2.51.0

