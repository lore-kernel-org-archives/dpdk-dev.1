Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7C4D31A0E
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 06:44:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 824D94064C;
	Wed, 14 Jan 2026 07:44:48 +0100 (CET)
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com
 [115.124.28.196])
 by mails.dpdk.org (Postfix) with ESMTP id E9FAE4064C
 for <dev@dpdk.org>; Wed, 14 Jan 2026 07:44:46 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.g67FHBH_1768373067 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 14 Jan 2026 14:44:43 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v2 0/1] Address NBL Coverity issues
Date: Tue, 13 Jan 2026 22:44:24 -0800
Message-Id: <20260114064425.45681-1-dimon.zhao@nebula-matrix.com>
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
 drivers/net/nbl/nbl_hw/nbl_channel.c     | 13 ++++++------
 3 files changed, 24 insertions(+), 18 deletions(-)

-- 
2.34.1

