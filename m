Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EC6C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 06:54:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95D974014F;
	Thu, 17 Jul 2025 08:54:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1BF4B400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 08:54:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752735290; x=1784271290;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1gNQQtTV6+ZvVykg7ECI+jg6zA9/nJ24LMAS46DURU0=;
 b=gT1KkeokohQL3EqkMZOd0k8AURftzqCjooCZYV+9mVOvrFQoITnq4Mx+
 auEqUofobkCerp2vYHWUGkvuK6Q8cvQ5rBg0zviEQxS1iQ/z9d3rxzyOA
 01VE03njttLCA2bJ7w1faBXeDUxM+1ah2gnxzzjLveAVwJoBEbqKeG9SC
 Ne4eBDn/udF6HT+5551vBSi27AAglAjzHbXO72xfBIKBfsbYt1T6sX7nh
 4KZYCufHZ9eQmpzGurdxmJl/cEwfzq7zQS9fUZV4i3xqkkiDl4DhQC7Bp
 3zUPZchF/4CUn5jOOHydbnzI5acMvExv3vI/dkKRL4J0iLVvIN32FVeFI Q==;
X-CSE-ConnectionGUID: +i7W9Z18RPOob5ziN2B+pg==
X-CSE-MsgGUID: Aee95BTvT96RtK3k7jgiqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54970986"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="54970986"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 23:54:49 -0700
X-CSE-ConnectionGUID: uzUmDdPVSAmWcUdm2pRotQ==
X-CSE-MsgGUID: mRyqx8u/S2ehNw1qL+Sfyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="194848776"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 23:54:47 -0700
From: hailinx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com,
 john.mcnamara@intel.com, hailinx <hailinx.xu@intel.com>
Subject: [PATCH v1] net/ice: updated latest recommended matching list
Date: Thu, 17 Jul 2025 14:16:02 +0800
Message-Id: <20250717061604.3288049-1-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.25.1
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

Signed-off-by: hailinx <hailinx.xu@intel.com>
---
 doc/guides/nics/ice.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index c6531d5684..90dc3220c7 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -85,6 +85,8 @@ are listed in the Tested Platforms section of the Release Notes for each release
    +-----------+---------------+-----------------+-----------+--------------+-----------+
    |    25.03  |     1.16.3    |      1.3.39     |  1.3.53   |    1.3.14    |    4.7    |
    +-----------+---------------+-----------------+-----------+--------------+-----------+
+   |    25.07  |     2.2.8     |      1.3.43     |  1.3.55   |    1.3.23    |    4.8    |
+   +-----------+---------------+-----------------+-----------+--------------+-----------+
 
 Dynamic Device Personalization (DDP) package loading
 ----------------------------------------------------
-- 
2.25.1

