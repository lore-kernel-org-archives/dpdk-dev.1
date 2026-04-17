Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B966F4369A
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 13:08:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52E90402A7;
	Fri, 17 Apr 2026 15:08:47 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 77726402A3
 for <dev@dpdk.org>; Fri, 17 Apr 2026 15:08:44 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 352DB1C2B;
 Fri, 17 Apr 2026 06:08:38 -0700 (PDT)
Received: from cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com
 (cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com [10.7.10.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 38CEF3F7D8;
 Fri, 17 Apr 2026 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776431323; bh=6cw52Tpa0llQ6CgtyyaAuFyxxEANC8U2aeMP6fHUQRY=;
 h=From:To:Cc:Subject:Date:From;
 b=XVA9kG5ZX0fAxTuZYjl65FCVDMh1Z9ATxY1j8ZJmaY1K8g3QW7COXbMdgkromQkPP
 o+WeaAMP/BUOAQNNth6ysbheXy8EMT/WtfZd3KBN/sKowaQmk2DpzxEyauzYWFpiGT
 gkbmUj197N+u1vSZLO4HgW0mt8VubNEC9HpkA6wg=
From: Jay Wang <jay.wang2@arm.com>
To: 
Cc: dev@dpdk.org,
	nd@arm.com,
	Jay Wang <jay.wang2@arm.com>
Subject: [PATCH v1 0/3] net/iavf: add NEON support for Rx/Tx paths
Date: Fri, 17 Apr 2026 13:08:28 +0000
Message-ID: <20260417130833.2503592-1-jay.wang2@arm.com>
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

- Add the scattered Rx burst function for 32B legacy descriptor
- Add the NEON-optimised Tx burst function
- Add the NEON-optimised RX burst functions for flexible descriptor

Jay Wang (3):
  net/iavf: add Rx scattered function for 32B desc
  net/iavf: add NEON-optimised Tx burst function
  net/iavf: add NEON support for Rx flex desc

 drivers/net/intel/iavf/iavf.h               |   4 +
 drivers/net/intel/iavf/iavf_rxtx.c          |  52 +-
 drivers/net/intel/iavf/iavf_rxtx.h          |   2 -
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c | 751 +++++++++++++++++++-
 drivers/net/intel/iavf/meson.build          |   2 +-
 5 files changed, 795 insertions(+), 16 deletions(-)

-- 
2.43.0

