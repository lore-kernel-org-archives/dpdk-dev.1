Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8B1E8B393
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 03:07:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 037E540430;
	Wed,  4 Feb 2026 04:07:45 +0100 (CET)
Received: from out198-4.us.a.mail.aliyun.com (out198-4.us.a.mail.aliyun.com
 [47.90.198.4]) by mails.dpdk.org (Postfix) with ESMTP id EEDB14027F
 for <dev@dpdk.org>; Wed,  4 Feb 2026 04:07:42 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gOD5rKO_1770174446 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 04 Feb 2026 11:07:30 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v4 0/3] Address NBL Coverity issues
Date: Tue,  3 Feb 2026 19:07:19 -0800
Message-Id: <20260204030722.11716-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115032744.62449-1-dimon.zhao@nebula-matrix.com>
References: <20260115032744.62449-1-dimon.zhao@nebula-matrix.com>
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

Address multiple issues reported by Coverity static analysis:

Check return values of ioctl() calls for NBL_DEV_USER_GET_BAR_SIZE
and NBL_DEV_USER_CLEAR_EVENTFD. The original code tested the return
value without capturing it from the ioctl call.

Move debug log statement after NULL pointer validation in
nbl_dev_configure() to prevent dereference of adapter before the
check.

Cast u16 operands to u64 before multiplication when calculating
buffer sizes and offsets to prevent potential integer overflow.
The num_txq_entries, num_rxq_entries, txq_buf_size, and rxq_buf_size
fields are all u16 types, and their product could overflow before
assignment to size_t or u64 destination variables.

Dimon Zhao (3):
  net/nbl: fix integer handling issues
  net/nbl: fix null pointer dereferences issues
  net/nbl: fix error handling issues

 drivers/net/nbl/nbl_common/nbl_userdev.c | 25 ++++++++++++++----------
 drivers/net/nbl/nbl_dev/nbl_dev.c        |  4 ++--
 drivers/net/nbl/nbl_hw/nbl_channel.c     | 17 ++++++++--------
 3 files changed, 26 insertions(+), 20 deletions(-)

-- 
2.34.1

