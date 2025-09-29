Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98B8CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 11:36:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B596C40695;
	Mon, 29 Sep 2025 13:36:01 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 1E41D40668
 for <dev@dpdk.org>; Mon, 29 Sep 2025 13:35:58 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=3Clnxf+lnQ0ZyF3F34nV9+NX/hTbyTWJIPk0PbM2hF4=;
 b=Nu56MlF5JtlZUqRHlqYk+SJqNxt7CR6ushHTA5JpV4PtAiXcP71wPHFmq0J6UUOjup21ZsM1T
 wfNLo5V2rQPcUtuXc89A4XZYlnl5ZYOlBUy/XhEQHuZYg/e+V77N8JVJHHtAJgrI/t7wvsbgQVV
 dcb1MkDbkN96Gqfu1YLJYGg=
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cZzds1m1zzLlYr;
 Mon, 29 Sep 2025 19:35:45 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id B739C140143;
 Mon, 29 Sep 2025 19:35:55 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 19:35:55 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <liuyonglong@huawei.com>, <kangfenglong@huawei.com>,
 <fengchengwen@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 0/2] bugfix for hns3
Date: Mon, 29 Sep 2025 19:35:52 +0800
Message-ID: <20250929113554.2443832-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100018.china.huawei.com (7.202.194.12)
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

This patchset fixes some bugs.

Xingui Yang (2):
  net/hns3: fix VLAN tag loss for short tunnel frame
  net/hns3: print invalid MAC address from firmware

 drivers/net/hns3/hns3_common.c |  6 ++---
 drivers/net/hns3/hns3_ethdev.h |  1 +
 drivers/net/hns3/hns3_rxtx.c   | 48 +++++++++++++++++++++++-----------
 3 files changed, 37 insertions(+), 18 deletions(-)

-- 
2.33.0

