Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3887CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:10:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB437406BB;
	Wed, 14 Oct 2026 17:09:49 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 7A70E402A4;
 Wed, 14 Oct 2026 17:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=/Jp/qNjmNdWGe1vmrDFnwDLCkzrHUkbIZknsC9dQLyA=;
 b=fP1/7Ln16gom/3rcFSGRKwfjhQgLIEriPv5VtQfM80vQxc4UVXDk9f6s+5QYNQ
 cDW5n62knMJUNEK/cVNLGH+leS6/3GHDcna51NUeAsGiy7sgvPnF67Venr8aC9fk
 sST7xq3UaolhD23pL5XN2kQBF5dHnKfTwiNxFgzvavwJ0=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH v2 04/26] net/hinic3: fix vport enable null dereference
Date: Wed, 14 Oct 2026 23:09:00 +0800
Message-ID: <20261014150923.838-5-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Gr45Xr47Xr1UJF4kurWxJFb_yoW8Jr4DpF
 W7Ka92kr98KF4xtw1DJw18Aa4Y9w1xCa48Ka45A3WYvFn5XF1Yy3y7trZ2vr1avrWxAFW2
 9F4I9a1qvryDt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7SdgUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMxaCjGrPmzYePAAA3B
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

hinic3_set_vport_enable() dereferences hwdev->dev_handle before checking
hwdev, and then uses nic_dev without validating it. Guard both pointers to
avoid a NULL dereference during early PF initialization.

Fixes: de490215f74a ("net/hinic3: add NIC configuration module")
Cc: stable@dpdk.org

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/base/hinic3_nic_cfg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index 5387626b98..d64a123c56 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -443,12 +443,15 @@ int
 hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, bool enable)
 {
 	struct hinic3_vport_state en_state;
-	struct hinic3_nic_dev *nic_dev = hwdev->dev_handle;
+	struct hinic3_nic_dev *nic_dev;
 	uint16_t out_size = sizeof(en_state);
 	int err;
 
 	if (!hwdev)
 		return -EINVAL;
+	nic_dev = hwdev->dev_handle;
+	if (!nic_dev)
+		return -EINVAL;
 
 	memset(&en_state, 0, sizeof(en_state));
 	en_state.func_id = hinic3_global_func_id(hwdev);
-- 
2.33.0

