Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED8B606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=l+xDYjF6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCE2740289;
	Fri, 30 Oct 2026 15:48:02 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTPS id 527D040299;
 Fri, 30 Oct 2026 15:47:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=/Jp/qNjmNdWGe1vmrDFnwDLCkzrHUkbIZknsC9dQLyA=;
 b=l+xDYjF66zw2rhz479hSu0SkvNrK0QNr5c07Vv5WhOFH6I9EvgZpXkD67Caww1
 kLeno/tCOlpQKKRQAkPbumsiSwXUPfj+3yH+ny/a66neb3Ha7PsEC84oK6OkYga2
 /wctxqGe9iyLDuFagUx3SkRa+IBiOHvxtoXQA/N9+edIg=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH v5 05/28] net/hinic3: fix vport enable null dereference
Date: Fri, 30 Oct 2026 22:47:09 +0800
Message-ID: <20261030144733.2120-6-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261030144733.2120-1-yejiacheng4@h-partners.com>
References: <20261023155809.855-1-yejiacheng4@h-partners.com>
 <20261030144733.2120-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHb_EUruRqpJ41BA--.59781S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7Gr45Xr47Xr1UJF4kurWxJFb_yoW8Jr4DpF
 W7Ka92kr98KF4xtw1DJw18Aa4Y9w1xCa48Ka45A3WYvFn5XF1Yy3y7trZ2vr1avrWxAFW2
 9F4I9a1qvryDt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzrWrUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNReEjmrkrhdggwAA38
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

