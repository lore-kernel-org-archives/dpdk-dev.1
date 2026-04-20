Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D334BF55809
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 10:30:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D13934028D;
	Mon, 20 Apr 2026 12:30:56 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id A58FC40278
 for <dev@dpdk.org>; Mon, 20 Apr 2026 12:30:55 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56D411516;
 Mon, 20 Apr 2026 03:30:48 -0700 (PDT)
Received: from cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com
 (cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com [10.7.10.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F9403F915;
 Mon, 20 Apr 2026 03:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776681053; bh=ljaAlPz2OeHlqxrB/uX8AvRtqynJhPPWz0EO5Kk+lW0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WAoa8n3jJFzsMB2BHbbOk78B+3NBR+bwTjyWL0kYbHGYUz0KHbF0If68aI/9wClEk
 C1sCmvmJh2sRKkpO3ElI2NQHDbliQ2K6p3O0NJ0EZ1DwRdSiX82JbqXeaKPzOayHbH
 V8WIjoDekFVKzNVnbS8V9Sk2YbahJ2FoMrFe5Xb0=
From: Jay Wang <jay.wang2@arm.com>
To: 
Cc: dev@dpdk.org,
	nd@arm.com,
	Jay Wang <jay.wang2@arm.com>
Subject: [PATCH v2 0/3] net/iavf: add NEON support for Rx/Tx paths
Date: Mon, 20 Apr 2026 10:30:35 +0000
Message-ID: <20260420103042.2836732-1-jay.wang2@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417130833.2503592-1-jay.wang2@arm.com>
References: <20260417130833.2503592-1-jay.wang2@arm.com>
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

- Add the scattered Rx burst function for 32B legacy descriptor
- Add the NEON-optimised Tx burst function
- Add the NEON-optimised Rx burst functions for flexible descriptor

---
v2:
- Fixed the AArch32 cross-building issue on AArch64 by restricting the
  call of iavf_rxq_vec_setup to AArch64 only

Jay Wang (3):
  net/iavf: add Rx scattered function for 32B desc
  net/iavf: add NEON-optimised Tx burst function
  net/iavf: add NEON support for Rx flex desc

 drivers/net/intel/iavf/iavf.h               |   4 +
 drivers/net/intel/iavf/iavf_rxtx.c          |  54 +-
 drivers/net/intel/iavf/iavf_rxtx.h          |   2 -
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c | 751 +++++++++++++++++++-
 drivers/net/intel/iavf/meson.build          |   2 +-
 5 files changed, 796 insertions(+), 17 deletions(-)

-- 
2.43.0

