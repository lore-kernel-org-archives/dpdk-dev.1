Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CC4C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 15:08:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB39840274;
	Thu, 10 Sep 2026 17:08:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 941E14025F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 17:08:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789052908; x=1820588908;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CPABrnxWe90Qyl1S3VEszRTumkIgpfajuAd+dzKQjkU=;
 b=Vu9ZhECefbi/ZODzGPajZcpbmdV9FLcoRw5hqdRcxh+lGXCvwIe+jZjz
 o5joN+aqh5rjQxMT403zNZCsET5SeyPvjFA08eRfTEEZUVcBcEB93X9f9
 J9BNsva3YcO8whQZVzSry04TAB0B7UQ3Ye4fnVs9A0japxsBomgyCO+sx
 cPTQSoSRMzCwqGOhV74nYZ8bRey4n2CC8NXTu6T5L7t/yuKpXsk03M8Nx
 5iJLtokIYKi6a1F+Kofw0sGJ/NaMDanxLXIoWT8hDuJ+lDrE1aBiwUaJ9
 KJ/Yf3n5te6Mg7t/kmuadPoG3/yrFEHzkMy7plwVLokXd5oLWqYLlnFUF Q==;
X-CSE-ConnectionGUID: DpIfKzGwR9OR/l35xeY41A==
X-CSE-MsgGUID: QCBgjmKwTY6uETtQWtTzMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89438648"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89438648"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 08:08:27 -0700
X-CSE-ConnectionGUID: RjadO1IAS+Kej7LbX5wtXA==
X-CSE-MsgGUID: +1lhAg7xSFeZYKyLwkPDaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="270312401"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by orviesa010.jf.intel.com with ESMTP; 10 Sep 2026 08:08:25 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/2] net/ice: updates for link speed setting
Date: Thu, 10 Sep 2026 16:08:15 +0100
Message-ID: <20260910150817.1521317-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

A pair of patches to improve the setting of link speeds for ice

Bruce Richardson (2):
  net/ice: check for missing fixed speed setting
  net/ice: disable link negotiation for fixed speed selection

 drivers/net/intel/ice/ice_ethdev.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--
2.53.0

