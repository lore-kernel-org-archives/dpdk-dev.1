Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FEBE9B366
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:02:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B160F4028C;
	Mon,  2 Mar 2026 12:02:16 +0100 (CET)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 95DA14028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:02:14 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=S++xGi0ERdKcpqM1iePGfvdB7gx+GFklm5Uwv78MLHU=;
 b=ZTKYS510g+jhHTN+eIaHpIGIcjS4F2NEFWahxGGho6Cum6BGha1ozypyC20U2FSKHsOuVi5iv
 O2Nm6esotHOt6V7RbG9VAy/kvtez4LqrwFb/h/A8xwdEeP54ieUQN8WaakjZzvSd8YJHaUeEQ/N
 ypG0yDWde15gSRg1KspDAag=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fPbVV4NBjzLlSV;
 Mon,  2 Mar 2026 18:57:22 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 553B14056C;
 Mon,  2 Mar 2026 19:02:12 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Mar 2026 19:02:11 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <qianweili@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 0/2] support driver forward compatibility
Date: Mon, 2 Mar 2026 19:02:04 +0800
Message-ID: <20260302110206.49670-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

This patchset supports driver forward compatibility.

Chengwen Feng (2):
  bus/uacce: support driver forward compatibility
  dma/hisi_acc: support driver forward compatibility

 drivers/bus/uacce/bus_uacce_driver.h   |  5 +++
 drivers/bus/uacce/uacce.c              | 51 ++++++++++++++++++++++++--
 drivers/dma/hisi_acc/hisi_acc_dmadev.c |  7 ++--
 3 files changed, 57 insertions(+), 6 deletions(-)

-- 
2.17.1

