Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E85D10372
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 02:54:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF3D440A8A;
	Wed, 26 Nov 2025 03:54:47 +0100 (CET)
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com
 [115.124.28.77]) by mails.dpdk.org (Postfix) with ESMTP id C9F904029A
 for <dev@dpdk.org>; Wed, 26 Nov 2025 03:54:45 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fW.b7WV_1764125680 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 26 Nov 2025 10:54:43 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Subject: [PATCH v1 0/1] fix NBL issues in DPDK 25.11-rc4
Date: Tue, 25 Nov 2025 18:54:35 -0800
Message-Id: <20251126025436.3714568-1-dimon.zhao@nebula-matrix.com>
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

fix Rx/Tx stats concurrency

Dimon Zhao (1):
  net/nbl: fix Rx/Tx stats concurrency

 drivers/net/nbl/nbl_hw/nbl_resource.h |  2 ++
 drivers/net/nbl/nbl_hw/nbl_txrx.c     | 38 +++++++++++++--------------
 2 files changed, 21 insertions(+), 19 deletions(-)

-- 
2.34.1

