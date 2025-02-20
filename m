Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7989EC021B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 07:07:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1F6C402CE;
	Thu, 20 Feb 2025 08:07:09 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 7985940041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:07:06 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Yz44K3p6lzHr9q;
 Thu, 20 Feb 2025 15:04:01 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 0FC6F140257;
 Thu, 20 Feb 2025 15:07:03 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 15:07:02 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>
Subject: [PATCH 2/2] app/testpmd: fix segment fault when config DCB
Date: Thu, 20 Feb 2025 15:06:51 +0800
Message-ID: <20250220070651.42123-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220070651.42123-1-fengchengwen@huawei.com>
References: <20250220070651.42123-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

The "port config dcb ..." command will segment fault when input with
invalid port id, this patch fixes it.

Fixes: 9b53e542e9e1 ("app/testpmd: add priority flow control")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 86d763b66a..56031fbd4e 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -3462,6 +3462,9 @@ cmd_config_dcb_parsed(void *parsed_result,
 	uint8_t pfc_en;
 	int ret;
 
+	if (port_id_is_invalid(port_id, ENABLED_WARN))
+		return;
+
 	port = &ports[port_id];
 	/** Check if the port is not started **/
 	if (port->port_status != RTE_PORT_STOPPED) {
@@ -6664,6 +6667,9 @@ cmd_priority_flow_ctrl_set_parsed(void *parsed_result,
 	int rx_fc_enable, tx_fc_enable;
 	int ret;
 
+	if (port_id_is_invalid(res->port_id, ENABLED_WARN))
+		return;
+
 	/*
 	 * Rx on/off, flow control is enabled/disabled on RX side. This can indicate
 	 * the RTE_ETH_FC_TX_PAUSE, Transmit pause frame at the Rx side.
-- 
2.17.1

