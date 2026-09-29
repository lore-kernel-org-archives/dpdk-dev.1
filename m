Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA5FCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 03:52:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7441440697;
	Tue, 29 Sep 2026 05:52:49 +0200 (CEST)
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com
 [115.124.28.125])
 by mails.dpdk.org (Postfix) with ESMTP id EF9A740285
 for <dev@dpdk.org>; Tue, 29 Sep 2026 05:52:47 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2070967|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00681427-0.00390991-0.989276;
 FP=9491005054426554072|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037031241;
 MF=dimon.zhao@nebula-matrix.com; NM=1; PH=DS; RN=2; RT=2; SR=0;
 TI=SMTPD_---.jQwErbc_1790653958; 
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.jQwErbc_1790653958 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 29 Sep 2026 11:52:44 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v2 0/1] fix incorrect MTU stored in rxmode
Date: Mon, 28 Sep 2026 20:52:34 -0700
Message-Id: <20260929035236.126778-1-dimon.zhao@nebula-matrix.com>
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

The ethdev layer already updates dev->data->mtu on success.
After rte_eth_dev_configure(), dev_conf.rxmode.mtu becomes stale
and should not be modified by mtu_set.

Additionally, the original code assigned frame_size (MTU + overhead)
instead of MTU, confusing frame length with MTU.

Dimon Zhao (1):
  net/nbl: fix incorrect MTU stored in rxmode

 drivers/net/nbl/nbl_dev/nbl_dev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.34.1

