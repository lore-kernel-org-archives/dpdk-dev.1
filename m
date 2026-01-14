Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF62D31A22
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 08:16:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A08E402BE;
	Wed, 14 Jan 2026 09:16:18 +0100 (CET)
Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
 by mails.dpdk.org (Postfix) with ESMTP id D3AF340289
 for <dev@dpdk.org>; Wed, 14 Jan 2026 09:16:16 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.g6COfTr_1768378570 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 14 Jan 2026 16:16:13 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v1 0/1] fix hardware stats interrupt nesting issue 
Date: Wed, 14 Jan 2026 00:15:57 -0800
Message-Id: <20260114081558.50370-1-dimon.zhao@nebula-matrix.com>
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

fix dropped packets counter issue

Dimon Zhao (1):
  net/nbl: fix hardware stats interrupt nesting issue

 drivers/net/nbl/nbl_dev/nbl_dev.c | 52 ++++++++++++++++++++++++++++++-
 drivers/net/nbl/nbl_dev/nbl_dev.h |  2 ++
 2 files changed, 53 insertions(+), 1 deletion(-)

-- 
2.34.1

