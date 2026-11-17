Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21FE606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=Kc9TrYKt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A86D2402F2;
	Tue, 17 Nov 2026 16:57:43 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTPS id 9DE434029E
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:57:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=/mq+9kpaWHIbCYxr4wkkpB1vCA3T/dGSu184htMereY=;
 b=Kc9TrYKtS82jTZLNnHBRlvC+277Wqghc3CkIRJvKUsOY3hSCOzB5utkx6CTsj8
 KAVYwPj2qbDQ1XiIw4otcr+1BiS7mL0qDrA1Hn24rn/0+EJ97U+wHj1e9BXiRI8R
 CBGcY2i7BCKK6aHYDL0jNgYxvIEbYCXzyA5WahGzNVeqE=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 05/29] net/hinic3: fix vport enable null dereference
Date: Tue, 17 Nov 2026 23:56:46 +0800
Message-ID: <20261117155711.1048-6-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261117155711.1048-1-yejiacheng4@h-partners.com>
References: <20261109162033.1144-1-yejiacheng4@h-partners.com>
 <20261117155711.1048-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgC3S5drefxqC7WJBQ--.4821S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7Gr45XFy5XFW8CFyDZrW7twb_yoW8Jr15pF
 WUWa92kr98KFW8tw1DJw1xAas0vw1xC34UKa45A3WYvFn8XFs0y3y7trZFvFyayrW3AF47
 uF4I9FWqvryDt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8YFAUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMw5TXWr8eW42cwAA33
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

hinic3_set_vport_enable() dereferences hwdev->dev_handle in the
declaration block, before checking hwdev. Move the dereference below the
hwdev check so a NULL hwdev returns an error instead of crashing during
early PF initialization.

Fixes: 9204b6b7bb1a ("net/hinic3: split new/old command queue operations")

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/base/hinic3_nic_cfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index 5387626b98..1520f88a1b 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -443,12 +443,13 @@ int
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
 
 	memset(&en_state, 0, sizeof(en_state));
 	en_state.func_id = hinic3_global_func_id(hwdev);
-- 
2.33.0

