Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A04CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 09:13:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFB0840609;
	Wed, 14 Oct 2026 11:13:04 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011014.outbound.protection.outlook.com
 [40.107.130.14])
 by mails.dpdk.org (Postfix) with ESMTP id EF6254042F;
 Wed, 14 Oct 2026 11:13:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gO9ts2sL1e1ZiEy7IXy+Y7G2gFCrLq2Kn1HBecC7nWPlxlKTxwQ2VMcllfSJZFWlt+dvZSa0punvpDuEKxRHiUutmRMBzai7u7rsmkQAoSoZ3i0Xd0UYhCEXez2B20HhENZEQ5YOVII8B95/mE7UEECUZGNfmO/K/rXhFpXcAdt5SXHOCW1XKjCmEbLb50LfDki6+aVOCsrJKBzMWHw2X6hmmshd1j6WAClMnxMTvjJnnzZxFZWIBptk74QNex0mAV7NTavDh6cSZ/0ebvHShV/HyuxYW9hSZK49DJ1dXxzMSZrezTmQHi37fAtLyhkAgIxXAMelYjv7hXQqQpKEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQzt3FObhuHm3IBuE2WGyTHVtux1IHUFz6FrVcYLi7Y=;
 b=bo2RIq3dSGEQuj5dAcWchoAQuVNRZO8DNfqlZfdpYkHyRIG7rHWksQFBnwX72DYQG+A759uaPEQKQQpiTHtpkDPx58R2wM21bz/wBlbAGZMer9HDgZRyKHaZQ24xvxhDn6Jm36t7/DapWT509gCXOFbau7Dm33RtCas/qlGSpaZMWR9YBkhr66lHlpOsiiXtNFzgCAlPDgizPQWNhkZ1DvyCwZNten0wW5281pzb3YNJbAOh3gT6QL6iH/pQ6Qk8VpKNl1TI9e6PbDxkkghUPqrm/n94g3NppwNVywv/pCYatPAblwl8aw2Z/IaEl9YyZJSIs/L64tPc1+p2XWzZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQzt3FObhuHm3IBuE2WGyTHVtux1IHUFz6FrVcYLi7Y=;
 b=c6dlVEaGE/ETm32JarcCi3hleo1rT498ROAcS5cW0q6UD7L/hPOt9B6f7B4ovKTeWOmPeEU1ilousekqT9MYlz4KQGERiua79vKF1wyaMyMU1uEQfiRhpZdUe0Z4Mxg0AgtTfQhq81euvj9oG+nrnlW5Svy8szYAv8dlTqIHuCAQ4pKhRyeqo6m890yVDVlNp4sxQGXbs+RQPgHpmHne+DCXCNYf2RONz3OdUBE8fyy3nNgSYwXjbYpSjtu7/uqiCf0ddjv8hU+z54zKPTYqiCDR07YMSZ7lzeC+D7b5f5pmhB8df/Tq8jDqizBJRcN2TJ2q/vROwBV2qe2FwXhcuQ==
Received: from DUZPR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::9) by DB9PR07MB7914.eurprd07.prod.outlook.com
 (2603:10a6:10:2ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 09:13:00 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::18) by DUZPR01CA0049.outlook.office365.com
 (2603:10a6:10:469::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 09:12:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 09:12:59 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 14 Oct 2026 11:12:58 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id CD0FF4020B67;
 Wed, 14 Oct 2026 11:12:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 9EEBD6096A9D; Wed, 14 Oct 2026 11:12:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH 0/6] net/memif: lifecycle fixes and unit test
Date: Wed, 14 Oct 2026 11:12:51 +0200
Message-ID: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|DB9PR07MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da6bb0a-9b34-44e7-d601-08df29d357e8
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: NO/xwZ0t9mFlO2L1wzWwItF7f6c0a2CHjx2kORiTCvwWzxaipUrtcLxITtKy8NVActw31fYeMABVkcMNZGrspUam/HUMeeNDRzxJTJyyBHLEVooFywH62FSv1MbI1w1va7kwwENUmFhgXDJezNBa0rmwTBh7KbdeIJz/Tujz5kD6ubDU46iaZsdjyU6oxddFEOCYUFX1PbhC9xNsttcKN24XBrLw7TGXrHeibDWFPHorCz+oFzfqvTyE5nQtOSnJLmypGAr4BS3v/ynl6SIVEHcev2A8D0bu+nCh8azG/I4mybQ15s1brdnSURld6iR7nUOqDdsMPLxnpB5NdzNE5IpBoIcBGZQ0brgQ4IElegFKTat1He0j+Cv4kjQor/9RDw3PonAakYZqRCai8T80fspI/ZHQMIc7xN/cxnAs7ZoSa3o1Xj+6FqTa5rRmQeE5MX4Hsz9ZsSAlKy/2ydDxsikT7AHyfmGGm/cXkLrbZfNBoy6IMWd9HIWcpMoGGAJq9g/Cgwb6dUl71bpUUdVhDxTx+7D9pPi3BcUv7uXqLJQ5TXQjCQB1XwMxwgWC8iEObaWeVhh16kMGlo+1us1pms3ZgOuPbm+kHw/+Jn1FDEi71i2HJBEIRHGEnhxmfSXTRiGANvVk2b0Xb4JpByeirNm+xWtAg95yDcxavfe/TSMipcAToMkcAW5BpWAQAGpo+yVPw5++b+pgADZ7/6uvkg==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NWHrgUHlncjubmnM4GWz0LvxSNsv7IT1mwvNFjKYza0VqRPTHyXcgR47xn6TRmbbp1UHS6DIbrL8uvUjZ4Gx+0/gvAH+KJRWa/tUpe5L5OnVlpJGqHQU4pE+9q0jc4R3Q5blpYoBMZbi7f986j5yqO+XvCUBFOsZ9rxxRG1L03dSPbys564OVNSLbjAfcqddPTJUmGLVfAqlgds3NK17d5TverWk9Qs+Ha62/90Cmo7MRuEGhwPce/BQ6J9ZW+PDDHu30E5meuuLGyxIuFd/EAliLtfllIRLhQkgJb2j7eV95Z7xITElwGCIo2CX/iFPE734Wz373Pbf7Hg0jUMyBYav6aH7HUckPxnOLMjmrCDHv+js8g8Aw3xrvCvnh5tg1DYD3TwIGWECYgQ1RlPPT5ePw8OzLwjuUKaXz/NkUYdFRctGjLv+R3T/4YkIHrkY
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:12:59.8781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da6bb0a-9b34-44e7-d601-08df29d357e8
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7914
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

The first five patches are fixes:

 - guard eth_memif_tx() against an empty burst so a zero-count call
   returns before touching the burst or the ring;
 - close file descriptor 0 instead of leaking it (the close path
   tested for fd > 0 instead of fd >= 0);
 - free the MAC address allocated during probe when a later step
   fails, instead of leaking it;
 - unwind a partially-created device on failure in memif_create(),
   releasing the port and the process-private data rather than
   returning with them registered and leaked;
 - disconnect the device on close so queues and shared regions are
   torn down, and make memif_disconnect() safe to call on a device
   that was configured but never started.

The last patch adds a memif PMD unit test (app/test, memif_pmd_autotest)
that stands up a server/client vdev pair over a loopback socket and
covers dev_info, link state, stats, single- and multi-segment loopback,
stop/start reconnect, empty Tx burst, and close without stop.

Verified: memif_pmd_autotest passes 9/9; check-git-log and checkpatch
are clean across the series.

Sriram Yagnaraman (6):
  net/memif: guard against empty Tx burst
  net/memif: close file descriptor zero
  net/memif: fix MAC address leak on probe failure
  net/memif: unwind partial device on create failure
  net/memif: disconnect on device close
  test/memif: add memif PMD unit test

 app/test/meson.build              |   1 +
 app/test/test_pmd_memif.c         | 574 ++++++++++++++++++++++++++++++
 drivers/net/memif/memif_socket.c  |  14 +-
 drivers/net/memif/rte_eth_memif.c |  59 ++-
 4 files changed, 626 insertions(+), 22 deletions(-)
 create mode 100644 app/test/test_pmd_memif.c

-- 
2.43.7

