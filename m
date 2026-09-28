Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10191CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 08:36:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 034A540431;
	Mon, 28 Sep 2026 10:36:31 +0200 (CEST)
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com
 [115.124.28.195])
 by mails.dpdk.org (Postfix) with ESMTP id 360CC4028C
 for <dev@dpdk.org>; Mon, 28 Sep 2026 10:36:28 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2845634|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00659716-0.00240431-0.990999;
 FP=10318946105463281324|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033045213054; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=2; RT=2; SR=0; TI=SMTPD_---.jQ-Znux_1790584580; 
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.jQ-Znux_1790584580 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 28 Sep 2026 16:36:25 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v1 0/1] allow MTU change when port is started
Date: Mon, 28 Sep 2026 01:36:15 -0700
Message-Id: <20260928083616.118559-1-dimon.zhao@nebula-matrix.com>
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

Remove the dev_started check in nbl_mtu_set() to allow MTU
configuration while the port is started.

Dimon Zhao (1):
  net/nbl: allow MTU change when port is started

 drivers/net/nbl/nbl_dev/nbl_dev.c | 6 ------
 1 file changed, 6 deletions(-)

-- 
2.34.1

