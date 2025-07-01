Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60016C8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 10:20:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1816E40269;
	Tue,  1 Jul 2025 12:20:34 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id CA3C0400D7
 for <dev@dpdk.org>; Tue,  1 Jul 2025 12:20:32 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021138.outbound.protection.outlook.com
 [40.107.130.138]) by mx-outbound20-123.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 01 Jul 2025 10:20:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thng30NPdCMkHS3UFWOimdkPszyIUiE1PTaKhSqw1LjiJUCecbZf5i1cY4XHEM84DjAl5HN6nom/OZ/u7ooNSUOBpYkhcRj5S+GVEU3p3B8tNjDSfLRZC7dvupplN5Ejq8ZEL1ncwyT0GaBZmPIAfMMJMfXnQXCSqNpLv+2OPU/LHbhS779PjLO6O4qcqomwpLVciQ6KVyjPbbs2FdJzt7Eq84bDzuEyRxMkV7BXxJcPRPCrHjvgh5+UTMmR8qSmcsx7kbeWeQkZoGAC1L0+EfXpLk67lBQFI0h4oGOA+UJ4G15QYGLrMiOv1IJzd0L2/Zjeb7X9cYymaOMI0zb1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqzzGpN2jw0rz8ohiqB5PRUbkMVaoEVttZTn1NFe/vQ=;
 b=U6FlfgOVWqEL4iAqFQ1VOxN3Qkko+sDevcuMgFBMUJKJePhuiuGs52jxrK+AyhgnPYB4ytSBgY2BdOECElt6ONfIuJ9jorxH3Pik5/sdWfXpPaVoRmmQgcBGmxkMcUr01DV+atIBvyoQ31TAwYGjEa2FkoYpsNmlEcwNUGAX1lIfa6VzPhIWSmlD1TsBxOg5DpFhpfgExyHfe8JUu4H1EQU6+B7rqwbkqjCGT+JPzNrF361CZRCo21Eb5tP/bKfw9Gi3h3/dzZVOBGGThhX4OM91DNh79rfhgGZf+EvJ0VnlvAa7B466/PxIBx9W0+aAfSsvzBeySOr1mk4kKYu9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqzzGpN2jw0rz8ohiqB5PRUbkMVaoEVttZTn1NFe/vQ=;
 b=GsvmCfGewCaj7l5uENc/0/i5p8f9fENI8NyLnOnEvuthjcscdpJR2eyCyBNm2FP0ELT4GRZ6bXMQdT3d6ojTxcHfU18bdSBTDHKEiDaPjSBXQqrFS0E/W5HuY6+5bCPQbIf3zAgcu93pzUWOjx586sejMc7zmi0hXHw2sPB5E2I=
Received: from DU2P251CA0025.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::23)
 by DU0P190MB2445.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:5a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 10:20:30 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::42) by DU2P251CA0025.outlook.office365.com
 (2603:10a6:10:230::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 10:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server id 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 10:20:29
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 0/3] net/ntnic: implement start,
 stop and deferred start for Rx/Tx queues
Date: Tue,  1 Jul 2025 12:20:24 +0200
Message-ID: <20250701102027.3525524-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250620112707.294596-1-okl-plv@napatech.com>
References: <20250620112707.294596-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61B:EE_|DU0P190MB2445:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 72d642de-db84-4df9-1345-08ddb888e7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MURsZI+E74SEdtllPWmbaHh3yyhgbQHtHtVO5P0lMB+B8qIPMief9ZObrJtZ?=
 =?us-ascii?Q?Z6lIkZF7zvLX/dHxuceviD9kaYuVy+luECyOGa31EWjyoL/VLfB9aGA3sC+p?=
 =?us-ascii?Q?Ko9/KgDbLyMaTfUcbKVx8xJYLSaR3w3nGWS9Uz+HC/06qdqg6FIM+/xYYkW9?=
 =?us-ascii?Q?C1I82aVFgXYzt/Q03qrmBAcGnXnEtxfX2pzvuIHv3XSP9O9ugF+mdopqROPl?=
 =?us-ascii?Q?lGbw+gZo+EB+PsaEalEpecxf8FjqqBaJZA0egXKpQCfS++OaO+vaQ+OTSvLc?=
 =?us-ascii?Q?mSV0MY/IetB+qAS79I/vnx/R6PwMH9qzp818T6pJOmB07nCEz44vY3C1/vX8?=
 =?us-ascii?Q?UaBimGjhZjuOnJDiQVlSYbJm/zJ4gj+NukxLckt1TkedTHNhzo5TqlEF4e6q?=
 =?us-ascii?Q?xCbyXNNb1wKFMMwk3vnAx5Cu/LTDTpUocovUdnYtWh14L3jxnxcIPyx4EwOn?=
 =?us-ascii?Q?iXuXqWKz38j32nzQ3dOsvsc0lpMAbz22U1csqHOKDTyV43FD94X1KGZkik6r?=
 =?us-ascii?Q?yL01XcVhqqdPglPy/jKIw7Zy0ODGJJ3h5ygGg1zWhDfiyuodxT3cwjxeeu24?=
 =?us-ascii?Q?4FrHrmxuZi3jS13ONZKLsO0VYhfWcZVF91O6HkDeoVZRomoeqlYRA0g1d6lJ?=
 =?us-ascii?Q?edULF8oUp1YL4usO3BTau1eA8XeuSw+JCwy2om5Fbh1x0RtKnRqPxrzg6Z2O?=
 =?us-ascii?Q?7dGgB/unrC7CTMQTpvETveO0aNbcPKzJWHCN/+AiFrkRxfKEqzgPE6rCLATw?=
 =?us-ascii?Q?nQ70YWOWjbVy9axBmPqG3xqZRD5Zk48NJ1cxbU75PJvXGq9qtCfyV/gsucWU?=
 =?us-ascii?Q?DN/leX8P8VINEYK5VyZOHAbS9NZ57gxmRx2TVobgUkHmwk1/caRl2nwaiLUx?=
 =?us-ascii?Q?QdAvrINzU8Pfs4pw1i09hfgX5rN6VWEEGImE+iJ1DPMhPZPy8OXNt16jXU6B?=
 =?us-ascii?Q?xJU0BJ3Fwe8IvGI3JB1TA8mGCjTBFIm9WCQWtWtXZLYDq5RWYBiwQ+rB5B+f?=
 =?us-ascii?Q?4259d1GbPEkorOZRdiuM3Sw3FFJUmBXCibL7NQinoDIhwUZJ2QmN14oky6Cw?=
 =?us-ascii?Q?2YCHJKiVWJjvd3BLWOSUe9be3Z2MYRjlA2HNAQG3Pje5yr41vHzLMFzF8hXB?=
 =?us-ascii?Q?QE/73HuRbSUVy0yvBUol7NCZUBqT+Ukt10kn0ndCwTuwjAX8H5iEfXspgKwR?=
 =?us-ascii?Q?yHSY+rbVYM/ibPevWCVOfwO6CDueO5QV/Y7FWv7TsmkQq2wVflWkuSo+Ig8N?=
 =?us-ascii?Q?GhLDWVnPiSYwgyMczrftIIKUt0KJX1oPovgmAbdhe9mrAnpsoGcWUpaGBKO+?=
 =?us-ascii?Q?6aJMAwuVuo9TqAfkXIhNPtUFstUtnLGqWtDO2D6md8HVLYV1KC/hEjDk6LcZ?=
 =?us-ascii?Q?7IK4SZFaqTOUkBTYbSAcoMHDiKoDcFk2TjJSGBV+3WgQA9VZ1UGxwG/oAgpn?=
 =?us-ascii?Q?GmqKBZGayOBSYtuNi3WvhFPrwlWmE4TA0a/RselJPA74OO4vsbqyqGLsK69C?=
 =?us-ascii?Q?xloy58V2AFA+a8BvQZv8MTNHXLC1v4hsUNij?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pwP9FwaJEgEB5wxvAF8CZt1pUIgmCDMBtBdbgeDn14NOVXh8a3AU3k2BPiCPWDciSuu/Ybkls4Jc0LdwPNkb8nAqR7kh8bgMU/ureRu8NaD/CrwMWGxodpNxfaChT2B7Ug/e1Crk+IYVfD1vIYCveybgSa5E+BeZ4mupQSB3HmmxNmlEW1GCxEdpbpISHSHgaNc7Sk/L51ammNMzHAxWkK3P+IKzP8L7YCMlm3Ei/IwZIlztsIvddkyo8tBYfIRXX4i/MjXh5xoAOQAwHUx7Vh2xnR8x8+mcucoIENe+h54pz23OOqEithzREfXo1V/wlOMxtYjaut7QIQ9O52nKt+myhefCb+xLWgYzgmlmJBoK1OaPjKcyP8RHz3X5iN83sAUxixQWT6FvfI83MlmO5S3mZ3Y8gXaAGuE9NmuQUzbC2WyMu6a8uo4YPa3+JsmTrCjLnWp6Tjm9uVDzbGSJh0rCAtv6ObQ8/TkGVRwUtANb6qeugYgmqaQA0AFBmJ9hyGm8g4v3R5QCbugAUp20lvqS/EEDZD8viaIA6cojZmG26JenS9n+z9PnWL5F9UI+GGfLaN8HasylBY/mfBooCmLrY8Db74M1qb+UC8xUUo5Vpv/Yg2YIzIvP2CEiLIpLsMO5T5zsZWLUgHoEsReFVg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 10:20:29.4940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d642de-db84-4df9-1345-08ddb888e7a5
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB2445
X-BESS-ID: 1751365231-305243-7629-6798-1
X-BESS-VER: 2019.1_20250616.1856
X-BESS-Apparent-Source-IP: 40.107.130.138
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhaWZkBGBlDMJNk02dTcMs3EIj
 HFIsXSwNTQwiQlLcnM0szENC0x1UypNhYAYWL+qEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265646 [from 
 cloudscan13-221.eu-central-1a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

This patchset includes:
  * feature start/stop queues on HW layer.
  * feature deferred start for queues.
  * Improvement for memory mappings when IOMMU is unoptimized.

v2 removes unnecessary log and adds fixed tag to the commit message.

Oleksandr Kolomeiets (3):
  net/ntnic: implement start/stop for Rx/Tx queues
  net/ntnic: implement deferred start for Rx/Tx queues
  net/ntnic: unmap DMA during queue release

 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  58 +++++---
 drivers/net/ntnic/include/ntnic_dbs.h         |   2 +
 drivers/net/ntnic/include/ntos_drv.h          |   4 +-
 drivers/net/ntnic/nthw/dbs/nthw_dbs.c         |  20 +++
 drivers/net/ntnic/ntnic_ethdev.c              | 128 ++++++++++++++++--
 drivers/net/ntnic/ntnic_mod_reg.h             |  14 +-
 drivers/net/ntnic/ntnic_vfio.c                |   3 -
 7 files changed, 189 insertions(+), 40 deletions(-)

-- 
2.45.0

