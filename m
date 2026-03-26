Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506C6109E530
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 01:37:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43F6B40E1E;
	Thu, 26 Mar 2026 02:37:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id B1E09402C4
 for <dev@dpdk.org>; Thu, 26 Mar 2026 02:37:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774489057; x=1806025057;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=s4cKv8V9lxpMNlVYta8UBOdfLQRCgr7PXnlMgs/RcBU=;
 b=G4J+DriTa53hjhfsZTZ4/82hLWxJZ+/b1hrjpKrNKTtdl+2J8XEnyQfj
 xeY+Sn2mHpIovNxJRqeR6UXHJayMpwak8vnlTVOSGG0VmwTeLnUybO+Ti
 vurIfIfar5KGi597X+3B1QMY8rYXtBk1AV0kUZciM4Y1SCddARUmQKZ4g
 NGYKEYD4z/2gtBJLHodlI4LqzCL4tQdUBFYoaLoGX3ncoPBeqKXlxsy+7
 bj+Zk5Ian3uwpVb4JZVX+NDgSHKFpMRA/bDpeoJPsG85RxiC5FlXJ+8S/
 8JCjRsIxGWvfev1I6oDBslr0mL6/0/PVGe8hWzABPNFqB3cprG9w3h6Sd g==;
X-CSE-ConnectionGUID: f9YmdMsTQYiWZJ19nAcgnw==
X-CSE-MsgGUID: IzERcuGuT7+hkJJt7SfJXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75442390"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="75442390"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 18:37:35 -0700
X-CSE-ConnectionGUID: WKpz2+M4RbCfR7wpAGpRpw==
X-CSE-MsgGUID: s8IAvt5DQ9mroEwOllingQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="255347294"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 18:37:33 -0700
From: hailinxx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, john.mcnamara@intel.com,
 hailinxx <hailinx.xu@intel.com>
Subject: [PATCH v1 0/3] nics: update intel nic latest recommended matching
 list 
Date: Thu, 26 Mar 2026 00:54:04 +0000
Message-Id: <20260326005407.623302-1-hailinx.xu@intel.com>
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

1. Updated ice latest recommended matching list
2. Updated i40e latest recommended matching list
3. Add ixgbe(E610,X550) latest recommended matching list

*** SUBJECT HERE ***

Hailin Xu (3):
  net/ice: updated ice latest recommended matching list
  net/i40e: updated i40e latest recommended matching list
  net/ixgbe: updated ixgbe latest recommended matching list

 doc/guides/nics/i40e.rst  | 52 +++++++++++++++++++++------------------
 doc/guides/nics/ice.rst   |  4 +++
 doc/guides/nics/ixgbe.rst | 28 +++++++++++++++++++++
 3 files changed, 60 insertions(+), 24 deletions(-)

-- 
2.34.1

