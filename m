Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A6BF364A1
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 16:41:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD6434028D;
	Thu,  9 Apr 2026 18:41:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id BFC9C40276
 for <dev@dpdk.org>; Thu,  9 Apr 2026 18:41:44 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E0E11682;
 Thu,  9 Apr 2026 09:41:38 -0700 (PDT)
Received: from cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com
 (cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com [10.7.10.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8AC9E3F641;
 Thu,  9 Apr 2026 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775752904; bh=6RQZyxYhHCEw8JEmgckYmYqv6nc+saS5kIQTKqNPrsU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hRzzA5XRezTuIVq3UjR0mALenJCI//jWEonlj2p6U5JfZrYjT6Xm+tdC6fXbLKEO1
 4Q6yrwOecMWh+N+0H+xwFiqpM0+ckAC0R4knQiAfU3Za2fpiMe5GrE2UbEeVpf6pjB
 Z05WjW1xDj/qQuUXkvyHlvSIJVcV1iNRk8LkhDwY=
From: Jay Wang <jay.wang2@arm.com>
To: 
Cc: dev@dpdk.org,
	nd@arm.com,
	Jay Wang <jay.wang2@arm.com>
Subject: [PATCH v4 0/1] net/ice: add NEON-optimised Rx/Tx vector paths
Date: Thu,  9 Apr 2026 16:41:28 +0000
Message-ID: <20260409164133.1692748-1-jay.wang2@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407151225.1416270-4-jay.wang2@arm.com>
References: <20260407151225.1416270-4-jay.wang2@arm.com>
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
ICE driver on AArch64.

The implementation mirrors the existing x86 vector paths while
leveraging Arm NEON intrinsics to achieve comparable performance

Tested on:
- Arm Neoverse (Ampere One)
- DPDK testpmd/l3fwd function validataion

---
v4:
* Fixed incorrect Rx vector DD bit extraction
* Added the check for AArch64 128-bit SIMD in selecting Tx funcs

v3:
* Restricted the compilation of ice_rxtx_vec_neon.c to AArch64
* Fixed the compiling errors when cross build AArch32 on AArch64

v2:
* Fixed the coding style issues in the comments

Jay Wang (1):
  net/ice: add NEON-optimised Rx/Tx vector paths

 .mailmap                                  |   1 +
 drivers/net/intel/ice/ice_ethdev.h        |   3 +
 drivers/net/intel/ice/ice_rxtx.c          |  58 +-
 drivers/net/intel/ice/ice_rxtx.h          |   6 +
 drivers/net/intel/ice/ice_rxtx_vec_neon.c | 745 ++++++++++++++++++++++
 drivers/net/intel/ice/meson.build         |   2 +
 6 files changed, 813 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/intel/ice/ice_rxtx_vec_neon.c

-- 
2.43.0

