Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBDCC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:19:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B94E240294;
	Tue, 18 Aug 2026 15:19:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 193C340269
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:19:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787059178; x=1818595178;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wvX1vD2yGgi/mSbIL0c79Cwzn872wBuE/9wGUltfcLc=;
 b=dybY8yQtJNlqSK9ysOQGnXhXJP2xCROJLAC8wsYhS6owNa7yZgbMgfzL
 35G71kAnggfAeZl4iUAjS9/ijT41fJY9oCLn6UXBFJ1msk4baYZvn6BjF
 O6QUnPDsBN1o+2w2lI+FomNmLl1B7Ubq34RZG75NcORxy+beUQqaGVoug
 l1kf5SRnXsuh4rYqCvyi0TwzE6KRc8Ebrv0iW7YPxVOU0NkPP305KyEZm
 r7Fxq84IeyuCTC7NvXCukQP3lhX71G1eYS45r/As12BhY4RI9qQyQ1w2i
 74MsQMJz5iv6Y9SNGhXSZvE2/8uWD6nN1YuFBC844wUbEoQqnVuJwVsHy A==;
X-CSE-ConnectionGUID: VeyLgxXhRQ6oZxoNPnn08A==
X-CSE-MsgGUID: HCNcpWbgR8SUBXsW+diWHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="86669412"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="86669412"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:19:36 -0700
X-CSE-ConnectionGUID: E3/cUh1hRHSG+PKXNqpz/w==
X-CSE-MsgGUID: sbyIF6r3QA6FfkhGp3GPuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="261015675"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 18 Aug 2026 06:19:36 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 0/6] IXGBE IPsec fixes
Date: Tue, 18 Aug 2026 14:19:26 +0100
Message-ID: <cover.1787059137.git.anatoly.burakov@intel.com>
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

Small array of fixes and refactors for IXGBE IPsec implementation.

Anatoly Burakov (6):
  net/ixgbe: add key length check in IPsec
  net/ixgbe: remove unnecessary dev pointer
  net/ixgbe: harmonize return values in IPsec
  net/ixgbe: get rid of unnecessary malloc in IPsec
  net/ixgbe: fix missing HW write in IPsec
  net/ixgbe: refactor IPsec code

 drivers/net/intel/ixgbe/ixgbe_ipsec.c | 355 ++++++++++++--------------
 drivers/net/intel/ixgbe/ixgbe_ipsec.h |   1 +
 2 files changed, 161 insertions(+), 195 deletions(-)

-- 
2.52.0

