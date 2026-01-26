Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D685BC88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 07:58:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C623402CC;
	Mon, 26 Jan 2026 08:58:36 +0100 (CET)
Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com
 [115.124.28.101])
 by mails.dpdk.org (Postfix) with ESMTP id 22CD8402B6
 for <dev@dpdk.org>; Mon, 26 Jan 2026 08:58:34 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gFyU4Lk_1769414309 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 26 Jan 2026 15:58:32 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v2 0/4] improve NBL memory safety and mailbox reliability
Date: Sun, 25 Jan 2026 23:58:11 -0800
Message-Id: <20260126075815.178216-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123031627.151341-1-dimon.zhao@nebula-matrix.com>
References: <20260123031627.151341-1-dimon.zhao@nebula-matrix.com>
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
  net/nbl: optimize mbuf headroom usage in packet Tx
  net/nbl: fix mbuf double-free in queue cleanup
  net/nbl: improve exception handling for the mailbox

 drivers/net/nbl/nbl_dev/nbl_dev.c     |   2 +-
 drivers/net/nbl/nbl_hw/nbl_channel.c  |  94 +++++++++++++++++----
 drivers/net/nbl/nbl_hw/nbl_channel.h  |  11 ++-
 drivers/net/nbl/nbl_hw/nbl_resource.h |   2 +
 drivers/net/nbl/nbl_hw/nbl_txrx.c     | 115 ++++++++++++++++++--------
 drivers/net/nbl/nbl_hw/nbl_txrx_ops.h |   2 +-
 6 files changed, 171 insertions(+), 55 deletions(-)

-- 
2.34.1

