Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271AFCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 02:49:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB82740B98;
	Tue, 29 Sep 2026 04:49:23 +0200 (CEST)
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com
 [115.124.28.195])
 by mails.dpdk.org (Postfix) with ESMTP id B315240285
 for <dev@dpdk.org>; Tue, 29 Sep 2026 04:49:18 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.3126221|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0091537-0.00100552-0.989841;
 FP=12391587096707210984|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033032053168; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=2; RT=2; SR=0; TI=SMTPD_---.jQov998_1790650152; 
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.jQov998_1790650152 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 29 Sep 2026 10:49:15 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v1 0/1] fix incorrect MTU stored in rxmode
Date: Mon, 28 Sep 2026 19:48:59 -0700
Message-Id: <20260929024901.125398-1-dimon.zhao@nebula-matrix.com>
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

The ethdev layer already updates data->mtu on success, so the
assignment is unnecessary. Remove it.

Dimon Zhao (1):
  net/nbl: fix incorrect MTU stored in rxmode

 drivers/net/nbl/nbl_dev/nbl_dev.c | 3 ---
 1 file changed, 3 deletions(-)

-- 
2.34.1

