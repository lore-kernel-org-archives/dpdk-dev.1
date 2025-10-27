Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78B5CCF9EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 10:17:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93A50402D2;
	Mon, 27 Oct 2025 11:17:05 +0100 (CET)
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com
 [115.124.28.171])
 by mails.dpdk.org (Postfix) with ESMTP id 8BCDE4026F
 for <dev@dpdk.org>; Mon, 27 Oct 2025 11:17:03 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.f8MxqGZ_1761560216 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 27 Oct 2025 18:17:00 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Subject: [PATCH v1 0/9] Address NBL Coverity issues
Date: Mon, 27 Oct 2025 03:16:39 -0700
Message-Id: <20251027101649.3337618-1-dimon.zhao@nebula-matrix.com>
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

Dimon Zhao (9):
  net/nbl: address nbl channel integer handling issues 490942
  net/nbl: address nbl channel integer handling issues 490943
  net/nbl: address nbl userdev error handling issues 490947
  net/nbl: address nbl channel Integer handling issues 490949
  net/nbl: address nbl dev null pointer issues 490950
  net/nbl: address nbl userdev Error handling issues 490951
  net/nbl: address nbl channel integer handling issues 490952
  net/nbl: address nbl channel integer handling issues 490954
  net/nbl: address channel Incorrect expression issues 490958

 drivers/net/nbl/nbl_common/nbl_userdev.c | 11 +++++++++--
 drivers/net/nbl/nbl_dev/nbl_dev.c        |  4 ++--
 drivers/net/nbl/nbl_hw/nbl_channel.c     | 18 +++++++++++-------
 3 files changed, 22 insertions(+), 11 deletions(-)

-- 
2.34.1

