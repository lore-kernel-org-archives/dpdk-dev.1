Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B22AD6CFBB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 03:17:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49F4A4042F;
	Fri, 23 Jan 2026 04:16:55 +0100 (CET)
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com
 [115.124.28.219])
 by mails.dpdk.org (Postfix) with ESMTP id E711D400D5
 for <dev@dpdk.org>; Fri, 23 Jan 2026 04:16:48 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gDV2mkr_1769138201 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 23 Jan 2026 11:16:44 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v1 0/4] improve NBL memory safety and mailbox reliability
Date: Thu, 22 Jan 2026 19:16:23 -0800
Message-Id: <20260123031627.151341-1-dimon.zhao@nebula-matrix.com>
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

Includes fixes for mbuf/memzone leaks and mailbox state handling.

Dimon Zhao (4):
  net/nbl: fix memzone leak in queue release
  net/nbl: optimize mbuf headroom usage in packet transmission
  net/nbl: fix mbuf double-free in queue cleanup
  net/nbl: improve exception handling for the mailbox

 drivers/net/nbl/nbl_dev/nbl_dev.c     |   2 +-
 drivers/net/nbl/nbl_hw/nbl_channel.c  |  94 ++++++++++++++++----
 drivers/net/nbl/nbl_hw/nbl_channel.h  |  11 ++-
 drivers/net/nbl/nbl_hw/nbl_resource.h |   2 +
 drivers/net/nbl/nbl_hw/nbl_txrx.c     | 122 +++++++++++++++++++-------
 drivers/net/nbl/nbl_hw/nbl_txrx_ops.h |   2 +-
 6 files changed, 179 insertions(+), 54 deletions(-)

-- 
2.34.1

