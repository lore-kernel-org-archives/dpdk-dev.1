Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26604FF495E
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 14:14:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C25A140616;
	Mon, 30 Mar 2026 16:14:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id DF478402D3
 for <dev@dpdk.org>; Mon, 30 Mar 2026 16:14:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774880064; x=1806416064;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sYtRSyW64c9npMkxB/642wO6CiG+XuUS4LngL+f9DaE=;
 b=IL3scUI8CuqqX2u2j8cDQl8Ykd/fE1uJlnkIlqaBENDZ+TqEJxyl2OQe
 jNvPCLr0dhEeMVRjvugCL2MKgbYDo9pxeNSDXq8605Ltk+475/91gp10s
 uzssJmVow3wiw2HtFUzxqvBISWEILsnj08Q7Ee7YqY13EW8Cdk+YhnwIT
 VYkVFAEnRzFqx/Kmwb/iKS/pzGTaVyzkKmyvz7WQXQxzXTNpWbcsg67gd
 EwlFcYe7fDmktB8rhaapCD4tq163lPXBUTUuZBSgzMChKE3RRsmlu2uKN
 zA7rHVkvYMKYemQ9Qr7IVoefSiNBBSISPKszj/srC2P8bHytVCsDhqy4b g==;
X-CSE-ConnectionGUID: 2JFrEQi7R7WMKUdYy6Unrw==
X-CSE-MsgGUID: hgGrd9zUS1GPIWP/Op4L0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75761655"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="75761655"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:14:22 -0700
X-CSE-ConnectionGUID: YWEAVKqFRSCh7ylb/bNj4g==
X-CSE-MsgGUID: q2Kr6y8KQguLrLHlpv2G+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="249123021"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 30 Mar 2026 07:14:21 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org,
	john.mcnamara@intel.com
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/6] Consolidate, shrink and update version tables
Date: Mon, 30 Mar 2026 15:11:01 +0100
Message-ID: <20260330141415.1267233-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327130448.1033651-1-bruce.richardson@intel.com>
References: <20260327130448.1033651-1-bruce.richardson@intel.com>
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

The version tables in i40e and ice were overly long, having details
about long-unsupported releases, as well as containing duplicate info
in separate tables for different NIC variants. Merge and shrink these
tables to make them more manageable, then update with latest info for
26.03 release

V2:
* include reworked copies of patches from [1] into set to make a single
  update patchset.

[1] https://patches.dpdk.org/project/dpdk/list/?state=*&series=37766

Bruce Richardson (4):
  net/ice: merge version tables for E810 and E830
  net/ice: remove non-LTS releases from version table
  net/i40e: drop unsupported releases from version table
  net/i40e: merge version tables

Hailin Xu (2):
  net/ice: update version matching table
  net/i40e: update version matching table

 doc/guides/nics/i40e.rst | 79 ++++++++--------------------------------
 doc/guides/nics/ice.rst  | 55 +++++++---------------------
 2 files changed, 29 insertions(+), 105 deletions(-)

-- 
2.51.0

