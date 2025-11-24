Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E354CFA466
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 03:40:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5003A402D0;
	Mon, 24 Nov 2025 04:40:49 +0100 (CET)
Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com
 [115.124.28.122])
 by mails.dpdk.org (Postfix) with ESMTP id 55B62400D7
 for <dev@dpdk.org>; Mon, 24 Nov 2025 04:40:46 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fUE8AnY_1763955639 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 24 Nov 2025 11:40:43 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Subject: [PATCH v1 0/1] fix NBL Rx VLAN issues in DPDK 25.11-rc3
Date: Sun, 23 Nov 2025 19:40:25 -0800
Message-Id: <20251124034026.3680873-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
References: <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
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

add VLAN offload set interface

Dimon Zhao (1):
  net/nbl: add VLAN offload set interface

 drivers/net/nbl/nbl_dev/nbl_dev.c | 5 +++++
 drivers/net/nbl/nbl_dev/nbl_dev.h | 1 +
 drivers/net/nbl/nbl_ethdev.c      | 1 +
 3 files changed, 7 insertions(+)

-- 
2.34.1

