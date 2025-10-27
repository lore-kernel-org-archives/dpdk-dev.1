Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F24CCF9EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 10:17:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A2B54064F;
	Mon, 27 Oct 2025 11:17:13 +0100 (CET)
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com
 [115.124.28.219])
 by mails.dpdk.org (Postfix) with ESMTP id B083B402E7
 for <dev@dpdk.org>; Mon, 27 Oct 2025 11:17:07 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.f8MxqSG_1761560225 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 27 Oct 2025 18:17:05 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 6/9] net/nbl: address nbl userdev Error handling issues
 490951
Date: Mon, 27 Oct 2025 03:16:45 -0700
Message-Id: <20251027101649.3337618-7-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027101649.3337618-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251027101649.3337618-1-dimon.zhao@nebula-matrix.com>
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

Coverity issue: 490951

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_common/nbl_userdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index acae57020c..c0bc995b64 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -715,7 +715,11 @@ int nbl_pci_map_device(struct nbl_adapter *adapter)
 	}
 
 	common->eventfd = fd;
-	ioctl(common->devfd, NBL_DEV_USER_GET_BAR_SIZE, &bar_size);
+	ret = ioctl(common->devfd, NBL_DEV_USER_GET_BAR_SIZE, &bar_size);
+	if (ret) {
+		NBL_LOG(ERR, "nbl userdev get bar size failed");
+		goto close_eventfd;
+	}
 
 	if (!ret) {
 		pci_dev->mem_resource[0].addr = nbl_userdev_mmap(common->devfd, 0, bar_size);
-- 
2.34.1

