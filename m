Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4716BF483E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 18:32:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6659440268;
	Mon, 23 Mar 2026 19:32:48 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id CBE7F4025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 19:32:46 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CEAA1477;
 Mon, 23 Mar 2026 11:32:40 -0700 (PDT)
Received: from cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com
 (cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com [10.7.10.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8AF623F73B;
 Mon, 23 Mar 2026 11:32:45 -0700 (PDT)
From: Jay Wang <jay.wang2@arm.com>
To: 
Cc: dev@dpdk.org,
	nd@arm.com,
	Jay Wang <jay.wang2@arm.com>
Subject: [PATCH v1 0/1] net/ice: add Neon-optimised Rx/Tx vector paths
Date: Mon, 23 Mar 2026 18:32:30 +0000
Message-ID: <20260323183231.3988257-1-jay.wang2@arm.com>
X-Mailer: git-send-email 2.43.0
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

This patch introduces Neon-optimised Rx/Tx vector paths for the Intel
ICE driver on AArch64 platforms.

The implementation mirrors the existing x86 vector paths while
leveraging Arm Neon intrinsics to achieve comparable performance.

Tested on:
- Arm Neoverse (Ampere One)
- DPDK testpmd/l3fwd functional validation

Jay Wang (1):
  net/ice: add Neon-optimised Rx/Tx vector paths

 .mailmap                                  |   1 +
 drivers/net/intel/ice/ice_ethdev.h        |   3 +
 drivers/net/intel/ice/ice_rxtx.c          |  53 +-
 drivers/net/intel/ice/ice_rxtx.h          |   6 +
 drivers/net/intel/ice/ice_rxtx_vec_neon.c | 747 ++++++++++++++++++++++
 drivers/net/intel/ice/meson.build         |   2 +
 6 files changed, 810 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/intel/ice/ice_rxtx_vec_neon.c

-- 
2.43.0

