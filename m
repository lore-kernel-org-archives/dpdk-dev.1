Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0951CD8CAD
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 07:52:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20553402BE;
	Tue,  9 Jun 2026 09:52:09 +0200 (CEST)
Received: from out28-130.mail.aliyun.com (out28-130.mail.aliyun.com
 [115.124.28.130])
 by mails.dpdk.org (Postfix) with ESMTP id 7FFA0402AD
 for <dev@dpdk.org>; Tue,  9 Jun 2026 09:52:04 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08613982|-1;
 BR=01201311R181S37rulernew998_84748_2000303; CH=blue; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.0103588-0.0023232-0.987318;
 FP=7518723051586873024|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033068016216;
 MF=dimon.zhao@nebula-matrix.com; NM=1; PH=DS; RN=2; RT=2; SR=0;
 TI=SMTPD_---.htFolPX_1780991515; 
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.htFolPX_1780991515 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 09 Jun 2026 15:52:01 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v1 0/1] fix NBL PMD multicast reception in promiscuous mode
Date: Tue,  9 Jun 2026 00:51:42 -0700
Message-Id: <20260609075143.32695-1-dimon.zhao@nebula-matrix.com>
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

When promiscuous mode is enabled on NBL PMD,
the hardware does not forward multicast frames to the host,
causing the driver to fail receiving multicast packets.
This patch fixes the issue.

Dimon Zhao (1):
  net/nbl: fix multicast reception in promiscuous mode

 drivers/net/nbl/nbl_dev/nbl_dev.c             |  5 +++
 drivers/net/nbl/nbl_dispatch.c                | 45 +++++++++++++++++++
 drivers/net/nbl/nbl_include/nbl_def_channel.h |  5 +++
 .../net/nbl/nbl_include/nbl_def_resource.h    |  2 +
 4 files changed, 57 insertions(+)

-- 
2.34.1

