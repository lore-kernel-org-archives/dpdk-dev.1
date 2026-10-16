Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E856CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:17:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E72EA40BA4;
	Fri, 16 Oct 2026 16:16:13 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
 by mails.dpdk.org (Postfix) with ESMTP id 92D2940659;
 Fri, 16 Oct 2026 16:16:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3rWKA5XzweobQOkKnq8mCGgI6rUabQODZGsGBIpCS3x1yKHjiHydFg4ToV0uz6jzUL5TTj6gLnRT71eIs5MJ0UuK9YCeME+Wq2otyot4IR+4SFsxHjlOux7L3BJZhh2QHyPA/4Iwcl0sOi1J3xOq7vN6U38dwpyoKupnryTGwi3f/cAo3Bb0TPRfY5tanwwGabnmhm9mLd479v/A6slPVrBT5I3evMxGoalAOevSgEbF9KZv/ymH0UR0FEv9Qc7PQCIs9B1tMPNK2xHqStVaSdij6AljKZa9ufMOi0daoejyV82gSLRjh+DzC57UL+pBZ/hTzz2WTU9Q8xzrMFUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VM1cA7gqRcdWBHoK/GujaTiQ63GoGygpQL3/x77hpHE=;
 b=pdPylHaaeGhyR7kIliE0b4X4A7VCrZgP3+hvBvCO0qEp5i0gA9HIPw/jJBRqxRHxrJ1clwNIvLnqvP+CajUZ5DHYjvGlcTSwon2xCQfOVPk5mxtUOIkpPeNtIy+nhdyYYpGoDotbULcfs4+uqJwczQwJy7GJ9qkOpX/XFc5/09M2uBfhgbsYmu0z5lWZ4ASbmCOdVzrOxtTB7bd+zKlvmLdMk6NPFNmbuU94Z4OppohvCz61UlbIqfuv8uxE6Fr+6Ykz/hXOVydaq2TNWScHjhdQ2AEhrbK9Brr3jj1pVRZjny3WkrpNqDxah92W6WSxMVrT4HEZWGmHJuRj/0aAvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VM1cA7gqRcdWBHoK/GujaTiQ63GoGygpQL3/x77hpHE=;
 b=NwIgACu/mUKP69HtNPwcHNyRqvDiaBggO6x0kXJmI+tB40DwKSvc4OvZqXXNAJpSMteZH/sqyXlNXufAUMQLsUI/dotnEwjsNT4lPd1AIEr3RAOQTy/OHn8P6a/TXmcaU2A5CZcoB106aLywVx9UnGc89a4Nsi9j4hTRNZPE8g4Z/mvpx0M6CHCHff24jiIIKHzb4qo3UNFyzQsJbOgd+eObX6Fs1ULCO9ZTWhAy/wgD5Ew7EpsuId46kxmwg2DTq7EO2sqF0kSbtgYyv1LxrPTIuHXe+BTzq84YpBdc6oZfJymsTjobLWtAhAhLP2K6ewFyu8YGDs3oxYelGLD7Kw==
Received: from DUZPR01CA0231.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::12) by DU4PR07MB10465.eurprd07.prod.outlook.com
 (2603:10a6:10:5ed::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 14:16:04 +0000
Received: from MAD0EPF000008AB.eurprd04.prod.outlook.com
 (2603:10a6:10:4b4:cafe::4e) by DUZPR01CA0231.outlook.office365.com
 (2603:10a6:10:4b4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 14:16:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MAD0EPF000008AB.mail.protection.outlook.com (10.167.241.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 14:16:04 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 16:15:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 56E624020A9D;
 Fri, 16 Oct 2026 16:15:58 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 9E0C962858A4; Fri, 16 Oct 2026 16:15:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v3 7/9] net/memif: disconnect on device close
Date: Fri, 16 Oct 2026 16:15:55 +0200
Message-ID: <20261016141557.3081522-8-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
References: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AB:EE_|DU4PR07MB10465:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8d7a08-df5c-4b97-dc2d-08df2b900377
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7JUW5sWPpGB8pSSWiLkvRx3hC6jwhkKH3injN+Ym69gpltFofTSPKpIX0qR/AIf9Aheq5mVvSdc0vyq9jWeRZyWLWYgh+/6vjKKFTzhXeu856qMPNCYQ6P6I2U09iMytFDDZf0eZH5h2wGBJeZmFaHNuBfcjR+pbwA9ZPo4uzdhpvRYNXNuKGZBJ7Sn0KVLajnwiu7oGqWooMiRUKVZOI2JX4GXIF19qRl/SyfRLI5NPJ7J3lV3nOBZR/Z6wdpbRa+4HSw/bgewofKU/mTulZIjKUjhEGuc38b2TWp5QsTXXb+uC0RmametenAe6ZzgSoW7Um31mXtMhhl8p3OBLvRJiIrlCVx/51IYo9ZWny9ARoEL73230MSs8W6FkraM1he9R5S8fAtfofvNifYBVhqGZVjKy1HlA9uGxS59QIVt5qH9LvZxkQvTRqWDz8OKBRSxslT/knbmVmYv2SuaIQl/4iGsETXhW/qlF1JO4QluvLNMoa1k7NLsAkT1aghvy/u5jTWa+P8bDfz54yM0peKA3AR7W3k3UbSh8E23uqJIgi8+c3H72gmuHcRmB8QqP7OAMDTPu8Art0dG0Ep8si6QJ7oTbj8kjI/D/I37JRvELh5GssXNp/ZoWLuy3xLtn9OmDYStDuWDWkUALBz3pDTDVZ0/k5AzhiRALQYpws7J7uJ4E+4EORvE2l2ClVycXLyuDcynsoOtGJLk85kDDMQ==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hMRMyl6tMaOkTdFn2lktFD7Hik18fJYSRIH8ZZrtDDMIDOrVFs7s6uB2KYM9lZhc9u1j5eUVwNspjhaGwlC0OSJsYTW/F/YWNCnRdrtEaAxWMg7HswR1o7ZGd6VWtEuFQ5E2yEDa3b6+ETbUUrmq7SzvnNUwu8r9deSgC4SX9FnpH74BUkz5WLpypTbWHHqW6SrRuUdWQc8ePtBwe1AtPXOoKTqSLOrFlf2zmvLFbmy5yj1pEFPCuSyAm+GXWsoIXlu/0+h3rkzKSRiwhbol/0SLlyO1rZUDnedgkwIzIgSISH5LWM9PjCC+KVUohgJASBojXGxntl7HtMr8pzQE/nGKBUUSK27T4uySEBgMHrH/od2oXjLzXWjr6Ok1mC18xvN7e8MXiEYEktDkQRw9yWUUyFOBhXgseK9Jog7++GBTyhK5KoxzG/FuMoXdnmtE
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:16:04.2162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8d7a08-df5c-4b97-dc2d-08df2b900377
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008AB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10465
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

memif_dev_close() enqueued a disconnect message but never flushed it and
never tore down the control channel, leaking the control-channel
interrupt callback, its file descriptor and the pmd->cc allocation.

The leak is reachable on a server that was started and then stopped.
memif_create() sets ETH_MEMIF_FLAG_DISABLED and memif_connect_server()
clears it at dev_start, but dev_stop does not set it again, so after a
stop memif_msg_receive_init() still accepts a peer: pmd->cc is bound and
the port is left with a live control channel at close. (A never-started
server keeps the flag set and rejects the peer, so pmd->cc stays NULL.)
Call memif_disconnect() from close to flush the queued disconnect and
release the control channel; it is guarded on pmd->cc and clears it, so
it is safe when dev_stop already ran. The companion dev_stop fix that
refuses peers while stopped is a separate patch; this call remains as a
backstop for an init racing with stop.

memif_disconnect() also walked the per-queue interrupt handles indexed
by the configured ring count without checking that the queue pointer was
set. Closing a device that was configured but never started (so queues
were never allocated) then dereferenced a NULL queue; skip NULL queue
entries.

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/memif_socket.c  | 6 ++++++
 drivers/net/memif/rte_eth_memif.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 550e2e468a..cdf85e09a1 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -663,6 +663,9 @@ memif_disconnect(struct rte_eth_dev *dev)
 				continue;
 		}
 
+		if (mq == NULL)
+			continue;
+
 		rte_intr_fd_close(mq->intr_handle);
 	}
 	for (i = 0; i < pmd->cfg.num_s2c_rings; i++) {
@@ -678,6 +681,9 @@ memif_disconnect(struct rte_eth_dev *dev)
 				continue;
 		}
 
+		if (mq == NULL)
+			continue;
+
 		rte_intr_fd_close(mq->intr_handle);
 	}
 
diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 852a7e2e8e..cdf77d77b0 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1723,6 +1723,10 @@ memif_dev_close(struct rte_eth_dev *dev)
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		memif_msg_enq_disconnect(pmd->cc, "Device closed", 0);
+		/* Flush the disconnect and tear down the control channel;
+		 * memif_disconnect() is idempotent if dev_stop already ran.
+		 */
+		memif_disconnect(dev);
 
 		for (i = 0; i < dev->data->nb_rx_queues; i++)
 			memif_rx_queue_release(dev, i);
-- 
2.43.7

