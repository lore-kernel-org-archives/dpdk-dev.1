Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19505CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:10:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABFAB40A80;
	Wed, 14 Oct 2026 17:09:51 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id EA0604064E;
 Wed, 14 Oct 2026 17:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=YFxMbWStH29X1v9WFsFbI3iJsMTV19SE+ZQqJw6SXSE=;
 b=cSD0/YUcXzZE+e8F1TVX6Ll7nnniy06KP5EADC9Uux5UqjYIqMwy4lsdPOkCK+
 QS0Su+4e3uEvp4DFQC41pTQN0BT5Cz2Gv4ouNiBT43L8WhtR5K6EFcLlAkw4qYIp
 sqffTwtjjRnG7h8dSCQ8SFjIu2OLG3JW7gCW8gF0HWYGI=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH v2 01/26] net/hinic3: fix SP230 VF PCI device ID
Date: Wed, 14 Oct 2026 23:08:57 +0800
Message-ID: <20261014150923.838-2-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyxJr1UWrW8AFy7JF1rCrg_yoW8GF1xpr
 47GrWj9FWvga12v3WDG3yqvFyUXa48C34UWw4kZ3ZI9FyDXry5Z340gayFvryYvr4Iqa4a
 vFnF93yIgw12v37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5_-PUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNhSCjGrPmzQfYwAA3a
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

The SP230 VF PCI device ID is 0x022a, but the driver table used 0x3750,
which prevented the VF from being probed. Correct the constant to the
actual hardware value.

Fixes: 8843a7a6bca5 ("net/hinic3: support new SPx series NIC")
Cc: stable@dpdk.org

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 .mailmap                             | 1 +
 drivers/net/hinic3/base/hinic3_csr.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 6fd5b6f716..8a2e0ff33f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -755,6 +755,7 @@ Jesse Bruni <jesse.bruni@intel.com>
 Jia He <justin.he@arm.com> <jia.he@hxt-semitech.com>
 Jia Jia <physicalmtea@gmail.com>
 Jia Yu <jyu@vmware.com>
+Jiacheng Ye <yejiacheng4@h-partners.com>
 Jian Wang <jianwang@trustnetic.com>
 Jianbo Liu <jianbo.liu@arm.com> <jianbo.liu@linaro.org>
 Jianfeng Tan <jianfeng.tan@intel.com>
diff --git a/drivers/net/hinic3/base/hinic3_csr.h b/drivers/net/hinic3/base/hinic3_csr.h
index eceb34e9fd..7cae2419c0 100644
--- a/drivers/net/hinic3/base/hinic3_csr.h
+++ b/drivers/net/hinic3/base/hinic3_csr.h
@@ -11,7 +11,7 @@
 #define HINIC3_DEV_ID_VF_SP620	0x375F
 
 #define HINIC3_DEV_ID_SP230	0x0229
-#define HINIC3_DEV_ID_VF_SP230	0x3750
+#define HINIC3_DEV_ID_VF_SP230	0x022a
 
 #define HINIC3_DEV_ID_SP920	0x0224
 
-- 
2.33.0

