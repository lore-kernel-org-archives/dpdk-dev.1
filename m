Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AB0CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 00:29:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01FEB4021F;
	Thu,  6 Nov 2025 01:29:33 +0100 (CET)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id 475B44013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 01:29:31 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=U5W17Pkl306ZR22GsZD/LJnPQaO75RZpOS+y/4EiUk8=;
 b=BxqrxfKlSWr/nsAht5/6x2QRkdTEyNtVBim+5z/z4ZGZ+NsqqDsuqVSfhynU3TQ7FAYUqqes0
 5BpV44xuMRyGE0BnMqodFxuowZtlDJjT5eJqAFkwtmdSVjJU3pVF22XJLxDhnldbHY7NDEMpC1X
 EElVOXWpKwNDK93+LHMIviM=
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4d231j3FXZzmV6g;
 Thu,  6 Nov 2025 08:27:53 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 36A1D1A016C;
 Thu,  6 Nov 2025 08:29:29 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Nov 2025 08:29:28 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <liuyonglong@huawei.com>,
 <yangxingui@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 1/2] app/testpmd: fix invalid txp when setup DCB forward
Date: Thu, 6 Nov 2025 08:29:19 +0800
Message-ID: <20251106002920.6162-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251106002920.6162-1-fengchengwen@huawei.com>
References: <20251106002920.6162-1-fengchengwen@huawei.com>
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

The txp maybe invalid (e.g. start with only one port but set with 1),
this commit fix it by get txp from fwd_topology_tx_port_get() function.

An added benefit is that the DCB test also supports '--port-topology'
parameter.

Fixes: 1a572499beb6 ("app/testpmd: setup DCB forwarding based on traffic class")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/config.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 3ce2a14a1b..0f687018c7 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -5187,7 +5187,7 @@ dcb_fwd_config_setup(void)
 	/* reinitialize forwarding streams */
 	init_fwd_streams();
 	sm_id = 0;
-	txp = 1;
+	txp = fwd_topology_tx_port_get(rxp);
 	/* get the dcb info on the first RX and TX ports */
 	(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[rxp], &rxp_dcb_info);
 	(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[txp], &txp_dcb_info);
@@ -5235,11 +5235,8 @@ dcb_fwd_config_setup(void)
 			rxp++;
 		if (rxp >= nb_fwd_ports)
 			return;
+		txp = fwd_topology_tx_port_get(rxp);
 		/* get the dcb information on next RX and TX ports */
-		if ((rxp & 0x1) == 0)
-			txp = (portid_t) (rxp + 1);
-		else
-			txp = (portid_t) (rxp - 1);
 		rte_eth_dev_get_dcb_info(fwd_ports_ids[rxp], &rxp_dcb_info);
 		rte_eth_dev_get_dcb_info(fwd_ports_ids[txp], &txp_dcb_info);
 	}
-- 
2.17.1

