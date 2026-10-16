Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F42CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:16:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E7E540A76;
	Fri, 16 Oct 2026 16:16:09 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011064.outbound.protection.outlook.com
 [40.107.130.64])
 by mails.dpdk.org (Postfix) with ESMTP id AD2CC40291;
 Fri, 16 Oct 2026 16:16:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuWwqbqe5YMtVmFclYVf6DBxAmamo5byKoC9bj/x1Sp1p13prvAZ79SYM4Lh+ljaa4AuTdA8gpxeufg5Eu8Cr276I+H0fuHIFCoo/MDuN4cwCbp+wIA9lisms6t8Kqhoc1XMRvtXTX+huaO6f0sHYmgLHnWV9jlt+VihgAQSc8FI6imNcLNpNmOXY1pOZfmEu5I5L//QK/EzZG+VcwLflGg4z0TcqhK8uNiBDd7AkRVglTMjW1TQjVWd9iGyIGl6Y0dX9PHajeEikf/w5FvXP6LTL3mBfGGRrH8EMDewafVc+N3IJNiPP0OpeTVsKKheoFAKQvsJlz7Vjk05+ckltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUJZIutKWePI9IOoUveyrupG9TfSQNi4o0csfqqLCxg=;
 b=yX9tcVeBhoStiVddOBC3dQeuSIUQsPLoL7K1n6sEXfpTBzBO4pnpHLDSP36Tcf2LXi2br8HFj3PqKj3J39ntjVD2nQ2jraSD7sNblY8lwhXQyheYsKYmOKCh5NZEqLLZoPy7PBJ/BKbugMpSONDello1aXPZd2EGDxBAD54xNFQ5ShaG+Ra+4FZnyjg2t3vw+hHjzBqO2+al3FLM3OOQvgjA8N7dB3Iv3R/aHPs8bYNd23rEYrAopHylNv2IYGntXiRLnCsqjsuc9XR287fiRnl3SP1HZr0tmoxOy2wpgug+zIJuRpRsmgr+iF0xOscfYnEaxj2BKBGWJizMaPPv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUJZIutKWePI9IOoUveyrupG9TfSQNi4o0csfqqLCxg=;
 b=TmU/ozTc8oXXF/ewd5K+pOuFzsjB5xnSyyFXfeh5zOWrNNT8tnTo2zQC24uUAYUG+He3jHBO8Lkb2XPHXpUQWYo/Nzo6xR1M6bsTOXqFwy/alOHX4kAkRKGdaXb9+VKYaEIhTuD3v5Mtt5ZucFFYsn+E53H9yzVzBSndP1/LmOttVTGF+zxYwCNgpUi0xEXBZmwdjTOHV3VB13ppWcz9oyv88UfvgZ2x5GCy7d2Ioa1jjRxGSTmPJIuvhAneXAEy8jQiirI48jXmX6Ha4VOHKqGwu/Rh2XxRBU7ssv36DpVepbecTzik1V+V6nVlwaR2+5aq12x6vKQNkJd2xl9wXA==
Received: from PAZP264CA0026.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:122::13)
 by DB9PR07MB8896.eurprd07.prod.outlook.com (2603:10a6:10:2ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 14:16:00 +0000
Received: from MI3PEPF0000848A.eurprd02.prod.outlook.com
 (2603:10a6:102:122:cafe::63) by PAZP264CA0026.outlook.office365.com
 (2603:10a6:102:122::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 14:15:59 +0000
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
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 14:15:59 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 16:15:58 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id AB52B4020B41;
 Fri, 16 Oct 2026 16:15:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 6D12461B473F; Fri, 16 Oct 2026 16:15:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v3 0/9] net/memif: lifecycle fixes and unit test
Date: Fri, 16 Oct 2026 16:15:48 +0200
Message-ID: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000848A:EE_|DB9PR07MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6e4e23-be00-4197-4737-08df2b9000d4
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: U6NBxY7Jpq1djTR6qXJaSS+4763njTIlGcVlQBaksycko5/fgaUz+ZliMcXigqTIlKmPDycgA3nJApKXGZAm0yshtx1E1mInX4sPhmVCFGnskHxOsKPqR+Hy+H3yicXjM08Va3W3LbRVYB9C56/EiQuL5HLj3WGn9+RG/5Er7bF6m1kkXCgqjMgizhtCnHq3TKy7+7nqp4DVdgEM3q/1Xxs2K2oIjvrRv3ZCzHndu5e9yLcox635TW0FFRe6wNsm0vLn2gEg8caiC6S+2djcRTuePoSC8SgjHPpoNwrodhyAq/9iNuArFQxRo7VdsFwRbFwoVbdHvswIx6yvOOKk6bI1G1vxKR2+wtszkV7HMA1y3plYQQxfP2lQYYyTcicm8Rg4gLrYNERVvzso1LK00nIrWWeWTCREo9CiW0hUZEJ/KZ2z/4G4mlQ6IdBIXwpVfP1fhomE4BeJejgHYyCqkgAG/K9M5VZxCCWBDDTUJmo2QjS5XSI17dUZY7iEnwjG5/hEHEp7u6Nptbhx5SPqWAqOBJuRWuZGzRiJB5RwSgMyG0di/Uv+NhibaUt6Xhqn3LagkUn8n0UGTqh+amwGtiXYJZC5gc8O4wfHXFi3eSbpuK/z2PvK9V6Gt5Ob7IH2e3IPeKEX19VSvlD1Bi54wKt0HDJyfK50ZymNuvvGu3FRRBoJORg8AUMp2eNIAVnuNMpE+9hqvS3RgUmFSVlVvw==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6Wa5tuMACpa1G/EtUI74p7xpLpzGnCnIYtjXYysFmiztYgfuFib2JEo8wUTBMRnOC2CGxMomo6Zezw7BUs7Fqho7U2uhXMFqGcqm0J3zSnXIHaEB+9aQQ6c56jj7CwtbLw0EbjBCIhJ04Fv4fbDldSoAb3EPmXmuZt55GeM7AnsZMt4Ld3NmiYaPYcjE+oN1wG6XmKeR5pMsUym63c87kdEyjqEz2+g5d85/GsngrBhPikNXnCzWl9qkK8lA7pqNA+RhKS/4Foyo86eS+X0k2+QSQHDIIX/681fw1/LQzvo8xtuCP7PEl3d8s2wW2meHGZRwulgMc6Fo5KubfDfz6Wb770bXNMH56wNUo3A3jZv4iWvv3OUOLIDpPVV7AMOYdU6bE3FXth0wOzoRIRzcuobqoyf5IJHhs0M3hxIILZ2vvc6XjcsWgRk3aMx1XJY5
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:15:59.8268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6e4e23-be00-4197-4737-08df2b9000d4
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000848A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8896
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

This series fixes a set of error-path and lifecycle bugs in the memif
PMD and adds a unit test for the driver.

The first eight patches are fixes:

 - guard eth_memif_tx() against an empty burst (nb_pkts == 0);
 - close file descriptor 0 instead of leaking it;
 - do not close the EAL-owned memseg fd in zero-copy mode;
 - free the MAC address allocated during probe on failure;
 - unwind a partially-created device on create failure;
 - refuse connections on a stopped server so it does not come up on a
   stopped port;
 - disconnect on close so a stopped server's control channel is not
   leaked, and make memif_disconnect() safe on a never-started device;
 - fix eth_memif_tx_zc() returning 65535 on an invalid interrupt fd.

The last patch adds a memif PMD unit test (app/test, memif_pmd_autotest):
a server/client vdev pair over a loopback socket covering dev_info, link
state, stats, single-segment loopback (slow and fast path), multi-segment
loopback across a ring wrap, stop/start reconnect, empty Tx burst, close
without stop, and a stopped server refusing a peer.

Verified: memif_pmd_autotest passes 11/11; each commit builds with
-Dwerror=true; check-git-log and checkpatch are clean.

Thanks to Stephen Hemminger and the ai-code-review bot for the reviews
that shaped this series.

v3:
 - Rebase on main, picking up rte_intr_fd_close() from
   d9191f684c ("interrupts: add helpers to close FD"): patch 2 keeps
   only the owned-fd ">= 0" fixes not superseded by that helper, and
   patch 7 keeps the NULL-queue guards above the rte_intr_fd_close()
   calls.
 - New patch 6: refuse connections on a stopped server. The started-
   then-stopped case is the actual trigger for the control-channel
   leak; dev_stop now sets ETH_MEMIF_FLAG_DISABLED. (v2 patch 6/7
   described this as never-started, which was wrong.)
 - Patch 7 (disconnect on close): reword to the real trigger and keep
   the close-time disconnect as a backstop.
 - Patch 3 (memseg fd): also stop closing the EAL-owned fd in
   memif_connect(), not only memif_free_regions().
 - Test: new test_memif_stopped_server_rejects_peer covering patch 6
   (fails without it); reword close-without-stop to what it actually
   covers (the NULL-queue skip); verify the full fast-path payload.

v2:
 - P1: correct Fixes tag (Tx fast path, not original driver); move the
   empty-burst check after the ring == NULL block.
 - P2: split the memseg-fd change into its own patch rather than
   widening the check to ">= 0".
 - P4 (MAC leak): document the secondary -1 -> -ENOMEM change.
 - P5 (unwind): add Fixes: multi-process support.
 - New patch: fix eth_memif_tx_zc() bogus Tx count on invalid fd.
 - Test: add to MAINTAINERS; return TEST_FAILED (not SKIPPED) on probe
   failure; add a default-bsize pair to cover the Tx fast path; set
   ring size via rsize and fix the stale comments.

Sriram Yagnaraman (9):
  net/memif: guard against empty Tx burst
  net/memif: close file descriptor zero
  net/memif: do not close EAL-owned memseg file descriptor
  net/memif: fix MAC address leak on probe failure
  net/memif: unwind partial device on create failure
  net/memif: refuse connection on stopped device
  net/memif: disconnect on device close
  net/memif: fix bogus Tx count on invalid interrupt FD
  test/memif: add memif PMD unit test

 MAINTAINERS                       |   1 +
 app/test/meson.build              |   1 +
 app/test/test_pmd_memif.c         | 751 ++++++++++++++++++++++++++++++
 drivers/net/memif/memif_socket.c  |  10 +-
 drivers/net/memif/rte_eth_memif.c |  76 ++-
 5 files changed, 812 insertions(+), 27 deletions(-)
 create mode 100644 app/test/test_pmd_memif.c

-- 
2.43.7

