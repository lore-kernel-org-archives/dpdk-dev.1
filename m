Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADC8CCF9EE
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 03:36:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FF5D402DC;
	Thu, 30 Oct 2025 04:36:32 +0100 (CET)
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com
 [115.124.28.169])
 by mails.dpdk.org (Postfix) with ESMTP id 9592B40297
 for <dev@dpdk.org>; Thu, 30 Oct 2025 04:36:28 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fAfczjH_1761795382 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 30 Oct 2025 11:36:25 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Subject: [PATCH v1 0/1] Address NBL Coverity issues
Date: Wed, 29 Oct 2025 20:36:18 -0700
Message-Id: <20251030033619.3386064-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
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

 drivers/net/nbl/nbl_common/nbl_userdev.c | 11 +++++++++--
 drivers/net/nbl/nbl_dev/nbl_dev.c        |  4 ++--
 drivers/net/nbl/nbl_hw/nbl_channel.c     | 13 +++++++------
 3 files changed, 18 insertions(+), 10 deletions(-)

-- 
2.34.1

