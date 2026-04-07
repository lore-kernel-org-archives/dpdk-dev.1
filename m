Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9496BFF5105
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:12:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEEF4402CE;
	Tue,  7 Apr 2026 17:12:40 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 597B54025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:12:39 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C28951BB2;
 Tue,  7 Apr 2026 08:12:32 -0700 (PDT)
Received: from cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com
 (cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com [10.7.10.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D28F23FC07;
 Tue,  7 Apr 2026 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775574758; bh=O/V/W2evOdyE/kqGAdcedGSQOylHOQNmmcuHcpwiGrw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VFWDCS1r3KA7DJ0MNDahvhLpMuoOtIOlH4sEvyVVh7iIhQvQolScLDnIF6YmdYCig
 letqVGOb864e+ohMouN5TEojyZPKJkT/E4bQ/guJbzz2ZuPQXZD55g1grCV6lsnTYa
 oUZJoeskFcb6XVKXwt2u2qHlt/rjV8tF2KrlBJxg=
From: Jay Wang <jay.wang2@arm.com>
To: 
Cc: dev@dpdk.org,
	nd@arm.com,
	Jay Wang <jay.wang2@arm.com>
Subject: [PATCH v1 0/1] net/ice: add NEON-optimised Rx/Tx vector paths
Date: Tue,  7 Apr 2026 15:12:21 +0000
Message-ID: <20260407151225.1416270-1-jay.wang2@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324162525.4083381-3-jay.wang2@arm.com>
References: <20260324162525.4083381-3-jay.wang2@arm.com>
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

This patch introduces NEON-optimised Rx/Tx vector paths for the Intel
ICE driver on AArch64 platforms.

The implementation mirrors the existing x86 vector paths while
leveraging Arm NEON intrinsics to achieve comparable performance.

Tested on:
- Arm Neoverse (Ampere One)
- DPDK testpmd/l3fwd functional validation

Jay Wang (1):
  net/ice: add NEON-optimised Rx/Tx vector paths

---
v3:
* Restricted the compilation of ice_rxtx_vec_neon.c to AArch64
* Fixed the compiling errors when cross build AArch32 on AArch64

v2:
* Fixed the coding style issues in the comments

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

