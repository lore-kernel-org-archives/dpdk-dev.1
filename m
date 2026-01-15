Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F427D3CCB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 06:18:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04BD840A7F;
	Thu, 15 Jan 2026 07:18:30 +0100 (CET)
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com
 [115.124.28.51]) by mails.dpdk.org (Postfix) with ESMTP id A508B402F0
 for <dev@dpdk.org>; Thu, 15 Jan 2026 07:18:27 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.g6s1wp0_1768457898 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 15 Jan 2026 14:18:25 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v2 0/1] fix hardware stats interrupt nesting issue
Date: Wed, 14 Jan 2026 22:18:06 -0800
Message-Id: <20260115061807.65832-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114081558.50370-2-dimon.zhao@nebula-matrix.com>
References: <20260114081558.50370-2-dimon.zhao@nebula-matrix.com>
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

 drivers/net/nbl/nbl_dev/nbl_dev.c | 56 ++++++++++++++++++++++++++++++-
 drivers/net/nbl/nbl_dev/nbl_dev.h |  2 ++
 2 files changed, 57 insertions(+), 1 deletion(-)

-- 
2.34.1

