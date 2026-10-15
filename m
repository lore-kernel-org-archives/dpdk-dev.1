Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E7ECC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:39:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D21EA402DF;
	Thu, 15 Oct 2026 16:39:50 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 69CC74027C;
 Thu, 15 Oct 2026 16:39:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+CeBDWbzn4MElTBmTFV1j8zhuwSgh6VFk57U8TkXIyuZTrUQFB9PekmyqqwiFxdhBoAXoktvcBUeOfkNQqz/X0LkWGoFYsV4B9u2tczlxil9riLHJfZpLeFmJTaoEXrweNpm8Oe2GiXj8IkXQTUqBsT74Su7KBEanUEqRqowUVERYtNkbZCvo+Gt3E3e5FgnsWYFmCHjZ9qG+d6RqNvgCeVuGaIIAuSTAJTt+auMNHnYLsfZNiZ00nNYarr786ZtGGSM6ADx7HqniW4o/Gb4/pvLF1TwsH7BiMB924mHTlH1qGmYTos7bXbf8tpbaMY3zxCxSqRgyAxvTebV9AK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmiWMsjqUJ0IGme7S++VwaMGA2oT3L3/2UcMZIJIOA8=;
 b=HHKU7xgA7yEcU2aSD5I2ZERSOt2OmMqVIm3FhXuhwLlFdyQjpajVKS4jH23VYy6/0ojygM528IMq+0bS+FY4M6Vptv7+yW23hpmVi0U5E6JvTnseQI6WBHdUplIdOxf6abe9GfQsqOtc5mLgwLSlLf7Pls2hgvWrknWwhuRdPfbgWNBEjE0De1820osHxOCmWzoncAXAUqdg0s0Mx4szHwaUTHmCbbIzWgkUBaMQLja9NiQU1NGtXDbU8rHqf57tp8d67AzXQfgS7g++KOLMkdsN9qdu5EPiRdx8tJ/sQiA0F1Ap/Py04T9AsAoF5mGCsLuG6/7OKAhgZovRy2Gtmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmiWMsjqUJ0IGme7S++VwaMGA2oT3L3/2UcMZIJIOA8=;
 b=DLpMKljRo5hnzbch3DnfXxlTg++IUvTBpJQcucxS8YSZaclFk6G1UNT2my7tGFTthNsJ/8qJbvIUumWObl5Bop0LbdWeDyDfryy/XecZ4ocLpNt1dQedeVrPBwcwggn4KP+8zM8RaHC8TPcc6rb2iGkDcmwF/tzwWYy3bT0AFY2tCbWKxkA2MIjnk8O5T6rj5hOgVkPi1CoIl9DUsQsA87m2l7IZFawHkfY0z/JJKlJ47uysFdCYbLlSj+Emb/I00mVyQBy5Iafu1+E3oVbHl4DJ7VjmqYy5GPYwD+rtCgPExeeTCFab6rEgjQ+P/PY0ba3OfbbyjT29Qdyko7ldeA==
Received: from PR1P264CA0150.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:346::9)
 by AMBPR07MB997971.eurprd07.prod.outlook.com (2603:10a6:20b:72a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:39:47 +0000
Received: from MAD0EPF000008C3.eurprd05.prod.outlook.com
 (2603:10a6:102:346:cafe::89) by PR1P264CA0150.outlook.office365.com
 (2603:10a6:102:346::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 14:39:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MAD0EPF000008C3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 14:39:46 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 15 Oct 2026 16:39:46 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id 75B474020B67;
 Thu, 15 Oct 2026 16:39:45 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 308726096AA2; Thu, 15 Oct 2026 16:39:45 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH v2 0/8] net/memif: lifecycle fixes and unit test
Date: Thu, 15 Oct 2026 16:39:37 +0200
Message-ID: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C3:EE_|AMBPR07MB997971:EE_
X-MS-Office365-Filtering-Correlation-Id: 07503593-4e21-45fe-24a5-08df2aca2912
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 3N4Pnq8Lnqx5UCzhacVDF3BXZqlQdeBhwy6FJqwk5ke1MM0Lzy8SqVUKl+3NtnilFNx6cvj37g8JnWTl8saoj7B/fqRbVYKBj7cVP3NPUPWAI/tfJlYNt2wwoSOvo04oBrwCdS6lJ5pJBv3Del2Vcoc++X3iTSchtNOBwaKyDj/2O6DvN7CVtUYLdR1Un7yiVa3Mji2CrFvMnlqKQOZ2waXHQUmrszFGv//i4p3uNe/fFxDngkOsxhSJNM48AxmmsY/31g+3Cm+PMx0cdp3xieInj7Gxh9tHnzWylooIIutSyxRJlNPsuiQDTENUo2muX5khHT8fOpYzM/SrNjbBF0HdblmGimHQEZbd1CiC0jwCSOpxP4uLPIHInmwGrqJez7jg7RPE63qI9Z7dOreCfAf1fP977pgn1dMdVY3TfJ2abx/gleIcJBGJXAaNoNX7+xxikzDFqpgPydp0XERwMOqf2JoartFXBdO2v4h20+LyErPGomu0qKjugFNOn6bcrdd+s5EyfRhwOvsox4YMRZWHDgvgaHw6xla9niKwfgs4OGCDuPoKSUNawsViZe1XZft+jKR6W/Qq/jeJepLaZeJuR98tHcDjPGyjp+yivde+vUdd686oZg02GCZTYPfdWukOwP2jjQDo5kMbD4zAQSqWic3/SbckSlnGl0pTC+nLC6GlsaLn+jjqSRUL54Dzwc2guw7upPrb44gTI3akyg==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RIZYAN+u8Bsqbc8L1uzuRsvQI+QNcRA2ksK3yYTVWPWreB3dwcgABaheHUAwUKuV0m33sSP8UUtieLsBsvI3yiTQOXYAGJj9JISbx/wup7gQFqcbm7fkBCJaBDhVF3Qmfag/O6xyJ8WTzBdcYKm2DG/Pu5kwqnSaWaA4GkaBfXEbC6YJdvLREPoDaWGdl4y8ISTAewIfgWgv1jqChG6jsc4ITSdE3SH6Poum9HU/bm4OHewqWyBaIsP0zVY68CInxJ8K9/fV6sK24Ze/ZXnvscxTy8p6qUPCYnK+PUdd2ZcOt10DVceA2alzRkq/KnXMznwG497icAn1k87qzguO8WPiuCGt1mT30PXmbraDRHtiHRofH5rBIsVHmQ5/a1B8i1cArc4gBX6+b9aRc3TGNoIWpaZzN8YshAzHzCEd75SmmVHqu85IE0HwT9V4p+sz
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:39:46.9548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07503593-4e21-45fe-24a5-08df2aca2912
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB997971
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

The first seven patches are fixes:

 - guard eth_memif_tx() against an empty burst (nb_pkts == 0);
 - close file descriptor 0 instead of leaking it;
 - do not close the EAL-owned memseg fd in zero-copy mode;
 - free the MAC address allocated during probe on failure;
 - unwind a partially-created device on create failure;
 - disconnect on close so a stopped server's control channel is not
   leaked, and make memif_disconnect() safe on a never-started device;
 - fix eth_memif_tx_zc() returning 65535 on an invalid interrupt fd.

The last patch adds a memif PMD unit test (app/test, memif_pmd_autotest):
a server/client vdev pair over a loopback socket covering dev_info, link
state, stats, single-segment loopback (slow and fast path), multi-segment
loopback across a ring wrap, stop/start reconnect, empty Tx burst, and
close without stop.

Verified: memif_pmd_autotest passes 10/10; each commit builds with
-Dwerror=true; check-git-log and checkpatch are clean.

Thanks to Stephen Hemminger and the ai-code-review bot for the v1 review
that prompted all of the v2 changes below.

v2:
 - P1: correct Fixes tag (Tx fast path, not original driver); move the
   empty-burst check after the ring == NULL block.
 - P2: drop the memseg-fd change from this patch; split it out as a
   separate fix (new patch 3) that stops closing the EAL-owned fd
   rather than widening the check to ">= 0".
 - P3 (new): do not close the EAL-owned memseg fd in either
   memif_connect() or memif_free_regions().
 - P4 (MAC leak): document the secondary -1 -> -ENOMEM change.
 - P5 (unwind): add Fixes: multi-process support.
 - P6 (disconnect): rewrite the commit message to name the real
   trigger (server binds pmd->cc without a dev_started check).
 - New patch 7: fix eth_memif_tx_zc() bogus Tx count on invalid fd.
 - Test: add the file to MAINTAINERS; make close-without-stop actually
   connect a peer so the cc leak is exercised; return TEST_FAILED (not
   SKIPPED) on probe failure; add a default-bsize pair to cover the Tx
   fast path; set ring size via rsize and fix the stale comments; verify
   the full payload instead of the first byte.

Sriram Yagnaraman (8):
  net/memif: guard against empty Tx burst
  net/memif: close file descriptor zero
  net/memif: do not close EAL-owned memseg file descriptor
  net/memif: fix MAC address leak on probe failure
  net/memif: unwind partial device on create failure
  net/memif: disconnect on device close
  net/memif: fix bogus Tx count on invalid interrupt FD
  test/memif: add memif PMD unit test

 MAINTAINERS                       |   1 +
 app/test/meson.build              |   1 +
 app/test/test_pmd_memif.c         | 693 ++++++++++++++++++++++++++++++
 drivers/net/memif/memif_socket.c  |  14 +-
 drivers/net/memif/rte_eth_memif.c |  70 +--
 5 files changed, 750 insertions(+), 29 deletions(-)
 create mode 100644 app/test/test_pmd_memif.c

-- 
2.43.7

