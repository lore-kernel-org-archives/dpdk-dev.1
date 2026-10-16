Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716E7CCF2C4
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 19:59:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C89A40A75;
	Fri, 16 Oct 2026 21:59:11 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013066.outbound.protection.outlook.com
 [40.107.162.66])
 by mails.dpdk.org (Postfix) with ESMTP id AE5494026C;
 Fri, 16 Oct 2026 21:59:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIQiv4MY1yWJ2qQvJleR2Jrt4c6jIBcz4BPfL7/KeVI0JEL10tKOnDQ93hK65Z3nseyddhc7ZMB4VTDiXXao+i0X0Md1O5V2W09a7IKLqiX5lJGVbFrhPPOH0xqTJp4fiYbtVXO/RufHhYVOojPJrsw/eJlq6u87fFyHkEpKwJFwceWWFIY25wkkQjZjKl4qF9iC/zEbpkAKTaMDxNmxwUfNpgpDGz7Tut7tcHPrHvbzFa9i/lpCm2kxcXhRMjoHDuzd0eTmTDxUCf8zAoAHXEPAPfK17Pg95h3L6LUEtV+iYs9sJaXLoJLlZUJDcz1/MwmJx3UHo2dcncceyMmI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YF0G212VsC4DgkqvawLZVHWs/s5HvgZFNw1J5818Gqs=;
 b=FtXZ2jqKsBTtUXHmvSpOc+aOQJePtyuiGefLd83IlQdlnB5QWZz/AaNlpIpavh8jIhcJhpgfgG3AOzOztX47EPcB9gHC7zu0AD30jJ37Jj6Vr9Vo3sUjnYPDAD54QGu3VvVURtlbj3OLTYXxQL0UXr9oU7LXJt/z0i7c6IK/mjiBBbJdCom3Jv7imz2P4Buoam27iZAJNcpVrV5xYNPXDcF1escrmCZL9L/EgE0vnLKDGDKXyYpqwYnGsbXbyuIsWwjhkHEeXBIQoIFM+26J1nleeh9+K2Ndz06cUkf0ALf5jmb0Kb/oQj0EXdvBg0zl+a/n1Xe3mvKtIuhXvIWPrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF0G212VsC4DgkqvawLZVHWs/s5HvgZFNw1J5818Gqs=;
 b=gkzsEBcvrbSzP112ebRukicbjXA6g4WyGRR95FhSp+H2KDWs5TIyFtCbpeM+tvhQdEw9ukxXwL6DhO4YpB7zmNeRUPyNMxvefQms9Wgv0nfCJJ0xVEBzRZv6/Qt7WKZNcwyCO7KE0aPHhcXjcb4ZItiAyJLf4jDiKWFq/jBVYNtrzsn+pamQVYePKUpD72fzsTPbKAbgpp1TGFrpHcYgGqE1qWv3yjeYDvfQycRhJTMFMwCUTErL2i+2AKWzola+e5GTL6Bv4YDzbNN9G8qw3eg42vSSc31v9pSlskTEiQ8ITbIvoBRkhkGmG3DDAqpVzcsml3B2plzCp9/FmDdTXw==
Received: from DUZP191CA0049.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::24)
 by MRWPR07MB12130.eurprd07.prod.outlook.com (2603:10a6:501:7f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 19:59:00 +0000
Received: from MAD0EPF000008A8.eurprd04.prod.outlook.com
 (2603:10a6:10:4fa:cafe::39) by DUZP191CA0049.outlook.office365.com
 (2603:10a6:10:4fa::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 19:59:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MAD0EPF000008A8.mail.protection.outlook.com (10.167.241.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 19:58:59 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 21:58:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id E392D4020B41;
 Fri, 16 Oct 2026 21:58:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id AC91D6254BAA; Fri, 16 Oct 2026 21:58:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v4 0/9] net/memif: lifecycle fixes and unit test
Date: Fri, 16 Oct 2026 21:58:48 +0200
Message-ID: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008A8:EE_|MRWPR07MB12130:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e47280-78ac-44b8-f1d0-08df2bbfeb66
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Dj6SebOcctCgTjehdHmvfA+nxNL+yJ3gzPwbKrRcHVvdpA0MHRcJX64CfW3SsdEW3gZCGPrYc1ylkjNG01hFftevHoehmQRQI35ovitFjJI0cmTOx0iedRwL1p0tZI34sznp3Gt7FmfUvk7mKoihmC3u8r46hzgL8oVb9k9lpK5Vtt72k+6azmPMXSC2RcL0e7pnUNKqnv04CzeOWM5Lgb1eyVPXCQimaCifb7ScmZHNpVbY9A24P7LzAEtEFcFY3lBqi1A+XCFffmtEb4W51YgC5iWwgnNq74BUX2PeU/EhVLIithMA+bJ7KPXdlzWyvXgfRZN3STzqwXI+f8RG9B2t+RR3L+rXixUti5jLQUqks3OHDlI7LiGbb5Q8coqyPT86I35cK5mxmPLS101ytMffBgIuLZ1S7p0U8/0zo0yp4/39E1s9BLMDhp3QekexMtUPOpPZLgewcsXibzZ3vxbm8nO+VadwDmqNEvivYxy/6LrlaqPQjboQIfBpMe6vWrLtHQdPaiS3ve4NXbQwROUupg6I1JuT8NRKv9fFuxqvUdYwocpPwrU/Z1UhhYNb6PbLOhnnrLaYXeQIfJnIPJ3DP/B3F7dlpsId7hWzE0LrabIdjsTGIvhx1LRaxWis4DWMor+iKWisxiFBa4G8xayVVF9Ed0swenPLrEBfbFTAxX7/6zSQoJOUKCu1OdnqU5tUKIkwuwFB0OOGaeY/IQ==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MiMBGZy8sK6iXE0X8NatfC+2sgyLR/I23rn2XITrIBlMLU5jCQ80htKqbO5Eg95HOWIlTVqkv9IdYhmt5g8VlrK4yy+kS7k8tiK5q61v5P0d6XOAhQMxAQpF6aXbnX2pbnuE40OfTU1LDzg1P2k8xlSyc/dvC0I5WWr2F2AaU5UyUB47Xe4NJi756BHClE/a3d0g/0a83hTpOj86uVbzrXxL8HQ+BuZGb4zBpOiQvJMJOuqtQyfp0gVd7/LD+XgLnLUNekV/O98IL8KCqROvNtsLCLedNRWNocGtbng74VtQJILfIcCHGTzs+OgQPwSdltz/PRUT561FSYidaMOYoOni0cBMJLeAtnJcmAXDw3A0aYG7tPOG0O9egtLjt7LbjCwNLnikVuV02jLza3mUePEQfvnB9z5KItmcK2IYEriOLh9J8u5OmAB1oiSyIm1i
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:58:59.6816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e47280-78ac-44b8-f1d0-08df2bbfeb66
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008A8.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR07MB12130
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

Verified: memif_pmd_autotest passes 11/11 (~1.4s); devtools/test-memif.sh
two-process forwarding OK; each commit builds with -Dwerror=true;
check-git-log and checkpatch are clean.

Thanks to Stephen Hemminger and the ai-code-review bot for the reviews
that shaped this series.

v4:
 - Patch 7 (disconnect on close): reword the commit message so it no
   longer describes the tree relative to patch 6 ordering; state the
   started-then-stopped condition directly and frame the close-time call
   as a backstop.
 - Test: bound the stopped-server negative check to a short window
   (REJECT_TRIES, ~1s) instead of the full 5s connect timeout, so the
   fast test stays well under its budget; NULL-check rte_pktmbuf_append()
   in create_big_packet(); list the fast-path and stopped-server cases
   in the commit message.

v3:
 - Rebase on main, picking up rte_intr_fd_close() from
   d9191f684c ("interrupts: add helpers to close FD"): patch 2 keeps
   only the owned-fd ">= 0" fixes not superseded by that helper, and
   patch 7 keeps the NULL-queue guards above the rte_intr_fd_close()
   calls.
 - New patch 6: refuse connections on a stopped server. The started-
   then-stopped case is the actual trigger for the control-channel
   leak; dev_stop now sets ETH_MEMIF_FLAG_DISABLED.
 - Patch 3 (memseg fd): also stop closing the EAL-owned fd in
   memif_connect(), not only memif_free_regions().
 - Test: new test_memif_stopped_server_rejects_peer covering patch 6
   (fails without it); reword close-without-stop to what it actually
   covers; verify the full fast-path payload.

v2:
 - P1: correct Fixes tag (Tx fast path); move the empty-burst check
   after the ring == NULL block.
 - P2: split the memseg-fd change into its own patch.
 - P4 (MAC leak): document the secondary -1 -> -ENOMEM change.
 - P5 (unwind): add Fixes: multi-process support.
 - New patch: fix eth_memif_tx_zc() bogus Tx count on invalid fd.
 - Test: add to MAINTAINERS; TEST_FAILED (not SKIPPED) on probe failure;
   add a default-bsize pair for the Tx fast path; set ring size via
   rsize.

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
 app/test/test_pmd_memif.c         | 764 ++++++++++++++++++++++++++++++
 drivers/net/memif/memif_socket.c  |  10 +-
 drivers/net/memif/rte_eth_memif.c |  76 ++-
 5 files changed, 825 insertions(+), 27 deletions(-)
 create mode 100644 app/test/test_pmd_memif.c

-- 
2.43.7

