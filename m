Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D83CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:16:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 253B240A84;
	Fri, 16 Oct 2026 16:16:13 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
 by mails.dpdk.org (Postfix) with ESMTP id B3DE44065A;
 Fri, 16 Oct 2026 16:16:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNPjwVORhYNumwSzrl6Q4+KEpRyRYHXxM9lBbnqXWGw4ajtAdoTCcm8mwc11uXWZg6BZoBN6iHeqXdissVybOT/kHezVPK+wM4ctFC2J1uthVO1ww4M3fO3TbaG1e84N3BskbmLl46BXiOgoXi325XJxLAKCekgFHpK85DQq9n5hpTF8NmJkM7JRw66zhBJcUPLp2PKrDZCe/K+KhG2svwlvEE6fRpiGt94RiKrcVJoDl3YAWpkaujJQD8yZSNVXa0m8nGr7nm6uw/b9t7sTQeWjUPjtUoe8p9284Aqi0kexa6Czwlprmw4soINhkeo5Paof8LaldPG9AL6i6KKTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wP6RfPfyC10W7VcCJSKKPPFvcLrBn6ZrpPIdf1iwDc=;
 b=DogUy7gMJ+0dr6FIfupIrhrKLENahmC2bQHEmnbrd/P7WFnogqeXWSxURaVOHUb0HyExlim4PgO3190zHexQmpU9JXQ3XnA7WLW1PurZSmcQom8SJLGcz493YaXQa6v3HfhkHRKLiLx8tmcW+WN8NnbCQHdxeNmDvh8ADjBMUcLr5jazpDQ+w9bjdRhLJunQ/mTPrtmp9Pw6Bwv97Yg1p0hqeTGNsKEX85T8RgrPjYTRc7s6+T1NRTvkwwHkXk6F3yIjTl+jgPllHJxU30UZd0rqdk/+npanB2ovFrJ0hCRToncPrlSc8paFCuuXZojlebNa7W79g4EoOQvJbA8XeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wP6RfPfyC10W7VcCJSKKPPFvcLrBn6ZrpPIdf1iwDc=;
 b=KuESiTkAAdcfPbncqacnOTFO4Qz3SXuwGqXVpblsz3tiz4X8vcz1kVwucE279RkQFNuqiZtvdH8Ec2txuJ2FKl/Nw87Lb+NY/1YvTRiz0wUzlRtfnnAlQ9Hhazzx2UsmtjorXpfgpBNAu9NYmGQfiapJZ/RcMYtdBxztfoabmk/AQlrnCoXaf8kp9eiI+Gjm5bWJqILw2ERHTmyj8S+HSWx/4/Xs6ISIoEmejLf8IOCPOeRzxBkGxZrCcLa5FFU/Oet50InvgF/wuFTPMK9JcDLHzsd/6c75GncpIgZgohJwDn+QLXMmyyeJSivjPK4GXgKPqt4u8UsV7NPz3qOtlw==
Received: from PAZP264CA0035.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:122::22)
 by AM0PR07MB11586.eurprd07.prod.outlook.com (2603:10a6:20b:6f8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 14:16:02 +0000
Received: from MI3PEPF0000848A.eurprd02.prod.outlook.com
 (2603:10a6:102:122:cafe::64) by PAZP264CA0035.outlook.office365.com
 (2603:10a6:102:122::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 14:16:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MI3PEPF0000848A.mail.protection.outlook.com (10.167.240.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 14:16:01 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 16:16:00 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 5C2BD4020A9E;
 Fri, 16 Oct 2026 16:15:58 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 98A0962858A3; Fri, 16 Oct 2026 16:15:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v3 6/9] net/memif: refuse connection on stopped device
Date: Fri, 16 Oct 2026 16:15:54 +0200
Message-ID: <20261016141557.3081522-7-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
References: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000848A:EE_|AM0PR07MB11586:EE_
X-MS-Office365-Filtering-Correlation-Id: f6111a30-bf5c-44af-54ab-08df2b9001fe
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|18002099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1zAxe9zABGzxlJXhEvdWRyD6flqBxoUpGYpomQYwsQrxwhDgi4SnF0bCzTyoZV/nVX/9Cw6vsfUQ0tL8UiIkhXE/BZN64i+GxS//tEuvIaXlb+ooPGTBAcumCdDpeV6/fnYII4x/7GJWcbf990BmQ5IZyK5pWWH+GCS1j/cY3RYpN5PpIFD4RSf0tpo7UxleI/yDJWsTtyHsOR/wzyV+3CK4gXWlkZqNhzQwheg05M7WfLJwj6i/T94GnigEwZQfLBMWhMLb1ekzPrQfANYIG7+Phl/kjNNrk1Uaw0yHjuvz16YEokIYKYe0M5wsD+lHgnebPxcrYU7WSLgKlq7wnPCeLbZaYt8cfe5IwVlkGm1EOmtZSB8q13UQPh8CQsI/RMHcDeePpg+uMFw7MCtXurs3yxyWymSNW5wxjVqw5Y3UswBp9JddSlncOdEX0uEyddd8HXIRu5fRJj7aSESqeBn2epycS2+1CSmjJzNYw5KKrxhWrKTdVcnfJyziPFsnVX13wiiy0XF4JJYFALYGsvMAmRqm69QRyA5amPgsJWnkT9VWEeGwAUlpJfwyJZYhnZP9VYVCeEL9SzkWxDDh0Fc9Gnoa3ihRPxL8cJfF1teX+rk5r0b3dmo4DOLnQcLl1plCf005lD1yJrY3Pwzlb53qRJ6oDg5Pjb8xtf7QrWRkPccGp749UMRrIzwcAJqy0ljspJlPOY1LfQek+D18ag==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vY9cTSRIlIn0X+3SOFhZwFyKAdz9/yV+H8ynPTNIq15dlP511TuvY/SRQAKeigPWRjNsvSp2apGbWpAFtzNq5WY8eaa5oM8nYYOJDzbr1AzRJLraFeqmwz/gtMajnrKrJW8WFztLEEE12t/nstv/VGHZe8/cVNT9yNULEKqTSk2/gLGdcuL9n8OZVHxP0P6AGEOi2S4yRKVWNXXcJdonpc6P8LDzsRwrUx9DPzV/T4SRK6R+5a5ZQNDDqCjznnZMLo0cYuxbRX7LvttX5ZMQyClo2bmNvsuqCt/Wql9lgYXg1/jTikanw876agnKDeFFipqbHm4eqguluP8jjR0FzzUSx11dy/JvK69qK7uo/zCF+s7pIWrLHQ0BPegaTqt0zyvhv0BqNkcdfK2zXJvpME6Rkg1dXjYV5vRyxPyIMnC77JEQBIv2fNjcqa0Dnw4c
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:16:01.7802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6111a30-bf5c-44af-54ab-08df2b9001fe
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000848A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB11586
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

A memif server cleared ETH_MEMIF_FLAG_DISABLED at dev_start (in
memif_connect_server()) but dev_stop never set it again. memif_create()
sets it, so a never-started server rejects peers, but once started and
then stopped the flag stayed clear and memif_msg_receive_init() kept
accepting connections. A peer connecting to a stopped server bound
pmd->cc and, on the CONNECT message, memif_connect() set
ETH_MEMIF_FLAG_CONNECTED and reported link up on a stopped port.

Set ETH_MEMIF_FLAG_DISABLED in memif_dev_stop() before disconnecting so
a stopped server refuses peers.

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index e70443976d..852a7e2e8e 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1699,6 +1699,12 @@ memif_dev_stop(struct rte_eth_dev *dev)
 	rte_eal_alarm_cancel(memif_bad_desc_disconnect, dev);
 	rte_atomic_store_explicit(&pmd->bad_desc, false, rte_memory_order_relaxed);
 
+	/* Refuse peers while stopped: a server must not accept a connection
+	 * after dev_stop, which would leave a live control channel on a
+	 * stopped port.
+	 */
+	pmd->flags |= ETH_MEMIF_FLAG_DISABLED;
+
 	memif_disconnect(dev);
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
-- 
2.43.7

