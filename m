Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E5DD3CCA8
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 03:28:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21A4540E50;
	Thu, 15 Jan 2026 04:28:06 +0100 (CET)
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
 by mails.dpdk.org (Postfix) with ESMTP id 18746402F0
 for <dev@dpdk.org>; Thu, 15 Jan 2026 04:28:03 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.g6rJMNd_1768447666 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 15 Jan 2026 11:27:49 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v3 0/1] Address NBL Coverity issues
Date: Wed, 14 Jan 2026 19:27:43 -0800
Message-Id: <20260115032744.62449-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030033619.3386064-1-dimon.zhao@nebula-matrix.com>
References: <20251030033619.3386064-1-dimon.zhao@nebula-matrix.com>
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

Address all Coverity issues in the NBL driver from the recent scan.

Dimon Zhao (1):
  net/nbl: fix issues reported by Coverity

 drivers/net/nbl/nbl_common/nbl_userdev.c | 25 ++++++++++++++----------
 drivers/net/nbl/nbl_dev/nbl_dev.c        |  4 ++--
 drivers/net/nbl/nbl_hw/nbl_channel.c     | 17 ++++++++--------
 3 files changed, 26 insertions(+), 20 deletions(-)

-- 
2.34.1

