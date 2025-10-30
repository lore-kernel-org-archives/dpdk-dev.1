Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9A4CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 06:57:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9831B40297;
	Thu, 30 Oct 2025 07:57:25 +0100 (CET)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id BA8764027A
 for <dev@dpdk.org>; Thu, 30 Oct 2025 07:57:23 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=bcLUkFw/1G99RBCw+zbDb4OxaN9sCdXLHto/C0/w5lc=;
 b=DJTq+rQVN7Hg6mzXqaR1tR+42aXi+L+HQ9Mfw2NkRC+nE5tCGxl6Ko5aA1G57Ar8KxyNoEd9i
 twHg9CNhtf7xtifHBrOEkTTnzoW+38F2OyysOVKyy/CXUPWkmT7HATFk+BwP6mvZDFCbEqG3TOh
 0Fm6Vng+b2U+dhG72S5WhVg=
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cxvz40B6Fz1T4Jx;
 Thu, 30 Oct 2025 14:56:16 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 20160180B5A;
 Thu, 30 Oct 2025 14:57:21 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Oct 2025 14:57:20 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: [PATCH] examples/vdpa: support show protocol features
Date: Thu, 30 Oct 2025 14:57:15 +0800
Message-ID: <20251030065715.47304-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

This commit adds show device's protocol features in list command.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 doc/guides/sample_app_ug/vdpa.rst |  8 ++++----
 examples/vdpa/main.c              | 13 ++++++++++---
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/doc/guides/sample_app_ug/vdpa.rst b/doc/guides/sample_app_ug/vdpa.rst
index cd3ec99054..873efbf7c7 100644
--- a/doc/guides/sample_app_ug/vdpa.rst
+++ b/doc/guides/sample_app_ug/vdpa.rst
@@ -70,10 +70,10 @@ Then we can create 2 vdpa ports in interactive cmdline.
 .. code-block:: console
 
         vdpa> list
-        device id       device address  queue num       supported features
-        0               0000:06:00.3    1               0x14c238020
-        1               0000:06:00.4    1               0x14c238020
-        2               0000:06:00.5    1               0x14c238020
+        device id       device address  queue num       supported features      supported protocol features
+        0               0000:06:00.3    1               0x14c238020             0x10c33
+        1               0000:06:00.4    1               0x14c238020             0x10c33
+        2               0000:06:00.5    1               0x14c238020             0x10c33
 
         vdpa> create /tmp/vdpa-socket0 0000:06:00.3
         vdpa> create /tmp/vdpa-socket1 0000:06:00.4
diff --git a/examples/vdpa/main.c b/examples/vdpa/main.c
index 289db26498..505e563a57 100644
--- a/examples/vdpa/main.c
+++ b/examples/vdpa/main.c
@@ -324,11 +324,12 @@ void cmd_list_parsed(
 {
 	uint32_t queue_num;
 	uint64_t features;
+	uint64_t protocol_features;
 	struct rte_vdpa_device *vdev;
 	struct rte_device *dev;
 	struct rte_dev_iterator dev_iter;
 
-	cmdline_printf(cl, "device name\tqueue num\tsupported features\n");
+	cmdline_printf(cl, "device name\tqueue num\tsupported features\tsupported protocol features\n");
 	RTE_DEV_FOREACH(dev, "class=vdpa", &dev_iter) {
 		vdev = rte_vdpa_find_device_by_name(rte_dev_name(dev));
 		if (!vdev)
@@ -345,8 +346,14 @@ void cmd_list_parsed(
 				"for device %s.\n", rte_dev_name(dev));
 			continue;
 		}
-		cmdline_printf(cl, "%s\t\t%" PRIu32 "\t\t0x%" PRIx64 "\n",
-			rte_dev_name(dev), queue_num, features);
+		if (rte_vdpa_get_protocol_features(vdev, &protocol_features) < 0) {
+			RTE_LOG(ERR, VDPA,
+				"failed to get vdpa protocol features "
+				"for device %s.\n", rte_dev_name(dev));
+			continue;
+		}
+		cmdline_printf(cl, "%s\t\t%" PRIu32 "\t\t0x%" PRIx64 "\t\t0x%" PRIx64 "\n",
+			rte_dev_name(dev), queue_num, features, protocol_features);
 	}
 }
 
-- 
2.17.1

