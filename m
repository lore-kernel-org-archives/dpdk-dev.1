Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC3CCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 03:30:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59392402B7;
	Mon,  3 Nov 2025 04:30:46 +0100 (CET)
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com
 [115.124.28.195])
 by mails.dpdk.org (Postfix) with ESMTP id 1A31F40270
 for <dev@dpdk.org>; Mon,  3 Nov 2025 04:30:44 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fDLDHIz_1762140633 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 03 Nov 2025 11:30:42 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Subject: [PATCH v2 0/1] NBL use hardware MAC addr instead of random one
Date: Sun,  2 Nov 2025 19:30:27 -0800
Message-Id: <20251103033028.3474579-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
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

The previous implementation used random MAC addresses for rte_eth_dev.
This change retrieves and uses the actual hardware MAC address from
the network device.

Dimon Zhao (1):
  net/nbl: use hardware MAC address instead of random one

 drivers/net/nbl/nbl_common/nbl_userdev.c      | 40 +++++++++++++++++++
 drivers/net/nbl/nbl_dev/nbl_dev.c             |  2 +
 drivers/net/nbl/nbl_dispatch.c                | 17 +++++++-
 drivers/net/nbl/nbl_include/nbl_def_channel.h |  1 +
 drivers/net/nbl/nbl_include/nbl_def_common.h  |  1 +
 drivers/net/nbl/nbl_include/nbl_include.h     |  4 ++
 6 files changed, 63 insertions(+), 2 deletions(-)

-- 
2.34.1

