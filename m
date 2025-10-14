Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44832CCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 10:17:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5807C402AE;
	Tue, 14 Oct 2025 12:17:35 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013025.outbound.protection.outlook.com
 [40.107.162.25]) by mails.dpdk.org (Postfix) with ESMTP id 3B816402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 12:17:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nc9DbQouCaOfyT5fFhRXWNti5PZXbUzb5yGHQHKtkuUoMWR2lAlhbdN2OBEK1K9l0r+4lfpspQAWPWmxiVmHxPPio17zeihCIIefn4TK8lJOyOpyZfGEd38npZkyjlsKSJQwmOPfESCzrZEcr9eXSa4blk3zX1T7lTdFQEy/J6jffyYddO2WV9IwQDZEPE2gBlC4EcNk8q6yRRtdJBj4AnhoEsHt85Y5Jd8+kUlVThAGJhLxFoUnOQPhJ/YgKWDzwH+yMqf8gLEPoPzEKjGwzRZCYPs/7W6lthYWSjlCtxJruPZileS9Wt9WxfyXAn7eCEGKqurbPE4w24wIZfQr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J47sxwT8u21MvymfmD66xc7VfEX/Wh+42CbTMFEhf5Q=;
 b=ruUm8E7c7oTyT/nZySEU1wGwCwgQPuJwnOE4YLggo8627xILHFlVz05+Sj7CVqSRM5h/YShv4Fq7DTtknI4TrJLyoYrYm7nVFFgnF2E14t3ywuhoirjhyy5uFwRgMr/JE6LB9hMQ/ev2ss7BtRxm3FC/DT0qrnODLdwoMHTja9Tf+H6QdiEc54fz15UbaszCua4dXhFMfEleK8KgJWYlrLrWtB111MqIYcebNvxy5YEEPN+qCEFe4E8rqtwAoDUIK2DLWxMbOmXbrWmR0li0HFaZCEYqGMP1/SSV3kwdbjtY/tjtU81nBL0CoIp/eMfHeqXx3bMprOH4mJs8ffxAjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J47sxwT8u21MvymfmD66xc7VfEX/Wh+42CbTMFEhf5Q=;
 b=fezvW77irll6LqZT3JV8RV0LKpu1AW5ophZLFQMn2lAvVvCuoHdWx3zkBEt2UPfeI8/Al4Z9C9GggbWsfVBkHRZ+0NiEjEsZsZ9iUS9O1eWkg5bMyUBi0eNMUEmbsvXwhykfS6vrbiBW0fRjC6EnZyL+6YMQnBtY0xL9bvh9ay739H6oKRwoyBKBupkejJENHcg+y9eazfQXLkQ7sasI7M7SLIZAzjQ+PdRii17UQ2iujzEwYyWFa3r4qMzZp1xyDl0A0mSTFdT/n6+DspxqfS0qsdKdxMgM/1FsgzTfEflvR/UJ7MLuVpwtfZhO0aZs0lnPPZ1CN7gKaQ9X9lEcAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by VI0PR04MB11746.eurprd04.prod.outlook.com (2603:10a6:800:2ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 10:17:32 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 10:17:32 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v3 0/5] DPAA specific changes
Date: Tue, 14 Oct 2025 15:47:11 +0530
Message-Id: <20251014101716.2885563-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251008043519.2461707-1-g.singh@nxp.com>
References: <20251008043519.2461707-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|VI0PR04MB11746:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d626c3-f93d-4772-c005-08de0b0ae307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OgJR/Mj2M1ZC3fF8/wWTrJJcncP4J8uGctD3rdDObs6HhF1Qk4mGy9KIWuXs?=
 =?us-ascii?Q?BrI2HixGg6ZmATUj7KqRCAdzz2jZ7bJTItbSd5VLxYg+5JbvJm7eLxZS6YjE?=
 =?us-ascii?Q?jnTLUohvqJMzpZWTmymiaXyu/ub34u59ZVw+aqAT6RjvKnNSZHw3veWQHOno?=
 =?us-ascii?Q?a6kkECCa7fxxLnwGvX9wfIOheEOAnjGm5BPVcULHGtlif2ieolGtlCvn5cWj?=
 =?us-ascii?Q?8IpK+D84bsGy/3ViQGzv/uCWmBPcxHOeO55AJAUtwka4udEYAtiT0bSYQeUQ?=
 =?us-ascii?Q?nm8ujh1Uw3pV5420dRynB7MV0CNGjs52zNLU7LwHo+mAtgcw+HDmzx1a2m7K?=
 =?us-ascii?Q?vrDBGnlLjVfHDE1+Pax4FjQJFNlfcFSfcb/MqZbBFge5WTdm8XHjC3Mum1Sf?=
 =?us-ascii?Q?5WFzcPV5wII5XJtqg0uyPTTkY5up496zJN7nrqAbMms2JGBhOvxNwdlj9JSI?=
 =?us-ascii?Q?8rBPbw4Q/9wnUTOu2oJZNjSaeUthAhtTTup1Ud7r32o07/7q9m0dW3RE+Zrl?=
 =?us-ascii?Q?2vVQbjPFUdg8cR9ESEeLz34VaGbfRVKhXZ0KTIZ+SPgk6nPeGMSUFvA8KYJx?=
 =?us-ascii?Q?1R+G4mP4jLtWM3tI/DwvtMI0E+LTA98lePgoPV0MuHUpVj0+dZW2QvzYAC6i?=
 =?us-ascii?Q?FMC2XOJXm0kLIGL9lEVrSNceiZqemtmQNq+R+SIZ0Lra2Afn268sWUc1O05M?=
 =?us-ascii?Q?FjmhBfNY8TN7Mdt6ULo94h5p/Uw5kP50svIh+0ATQMdSiPLwKZKKp4vE1VSa?=
 =?us-ascii?Q?8HGQkxLbuQh4QQ6+ry4RC4JbMLTQQRj0RUuVq7mrehpqU5QRkZdmEQbz2MZb?=
 =?us-ascii?Q?ELp33U6gFzm672dN4yQqIc10jncpQ2rhW32qRpxpKs31SC6j3k39oTzPldr8?=
 =?us-ascii?Q?8DqRHICUPscVceZ5HnAhdBNYz2cj4YoebdidaBTj11co5kkbCZYp34Qc//99?=
 =?us-ascii?Q?rJOJDFR2I+P6zW7oUR38vuVvtD/N4NGYzP+TSIjzpvIogRpsv1MRrDOpYFiw?=
 =?us-ascii?Q?La5P4NRtG2IE+0PhhrN74+ID+lSnigAagsiYmtqvD5LIjJSvyg5obzU5WE5p?=
 =?us-ascii?Q?oXqUaeNYa+OyRbtQwStS2jokUi6odt/IVT7xbB/2rdNb0nOBUZgxAjpJN5vU?=
 =?us-ascii?Q?WdfBFT8EIb1w+oXVVw2xz2cyIiP6DEnsnN2geWBvMGw/XD3nNPeYwTRQfBFl?=
 =?us-ascii?Q?AEBmHp8H20MATsCxVCHph8B5sZEYKLKxq+avzwr2TNDQnofSRKXJ0T2mkUS6?=
 =?us-ascii?Q?w0ZBdeSfsc3TZflhQ4rzw5rc8+YVqujvokzp33yKbzpjAjeWWopaiUzX1Z0w?=
 =?us-ascii?Q?Fs0OFw4SOf6IBDWcICAN6WijrvAO45EvUMMBRIvJ9V4uyB1KUJMRzRizca8g?=
 =?us-ascii?Q?gGxV8DlR09LMvN3j+e80xyFrNvm523KMjNwtNGPhH9UuiSdPLehMibpyxHJP?=
 =?us-ascii?Q?JatZW/jUJjmL0q3utLA+16m+zwooiUvbw3razK6FAP16nMM2SLVpnRZw5hyY?=
 =?us-ascii?Q?9taChFW7zc8X9PbdeRiHPvTTqajfGlLTEOMg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h2qFPivZGjSiceGfmVKywvftMOM296G+FOWd1bccBUE0x/qnuQdlslYMSP3A?=
 =?us-ascii?Q?yOW9pvEgxSx8EorLgD7JrAudo9MfP4Ihh7bE+sjFYZ9DsZ97VkdOhAw9FT4L?=
 =?us-ascii?Q?ZmybWE2S593VUKe79D2qeKLkVOI8OSopmFGr9LBFkBg/WQa0ihcZV+k06TRe?=
 =?us-ascii?Q?9B2eEZwHw+DElfpGI3NQf0CvcFvzcI6N7IM7jqY4gbPRyn2eraJ/ROXgRwGQ?=
 =?us-ascii?Q?c2qGx6gx1CDpYb6100vyzOOBgnaM6/kG8O6NekzlhH3vT2Vwy/aIEpCOK9xC?=
 =?us-ascii?Q?VHlbFanYVnfl/5HGsFMPZhnqO5GzDXZYM781woeH9zg9Q6j0YZR/SOK5iR1v?=
 =?us-ascii?Q?GZhoTRjD0IAKYpsXt4EBhyQs/j0TInw+IMIaoafH+KKtKtUDQOz1eRTiuqgG?=
 =?us-ascii?Q?OIizHHh1b1fJERiioX5ZQa1UnCQoyuVCvsj2ZajLbkF2MU1JS15NRNct1ztX?=
 =?us-ascii?Q?3ZUU4L7Xz824UZ0kTFF0czxTmN1LtCTqmxdmVjMrY6MyAhoRICjSFfL0NvF/?=
 =?us-ascii?Q?Wc7hQZbQHVsNIPWoeXepurBPqrxGsDXAUBl4lQFqQp5r0tj55jyviciuR0mm?=
 =?us-ascii?Q?XTD8zgxhGEz18aP/zGeW6SMQcwX37dTd6e88Ns6hjbKdDqplrsrOo+IhBUZg?=
 =?us-ascii?Q?jpxJRnSTou+EEllqKoNIGYSuL+l0lRqYQTPI8N4sbIG4/AUVnLRlf/xF/7fP?=
 =?us-ascii?Q?CiyJWDlbwnQAPhPN5t1tdv07rj85Y7Mq2DpWLRJAAueW7vUE1wdq7ujPQdzf?=
 =?us-ascii?Q?tcZXdEUxn/tEmx3PoAmndoi0rkdaZ4JSg5U2muQPI/2Om4VBqt7JsmkxvH25?=
 =?us-ascii?Q?XomdIZOf0BP+8k0x47kXV25lzLdHGodVu1NinfAw01HW/gxazU1VxLWZ831V?=
 =?us-ascii?Q?3VbPf5BKc867QbQ6b5+AxVb8tDLpILykYt7+4uV7ljBblx41sSRzVPxHKUgR?=
 =?us-ascii?Q?bTf/YQA5JAhsqOGkz7sv1hUtINh7Fs4/pkoMXx5BjC0C2nKm9oMbmRyQZiZE?=
 =?us-ascii?Q?Nw3L0G0LnPYb1lE5Zh6BLE2c0JcwEEFAycar0R7vq4LTgG/sppSmvJ6Nd37f?=
 =?us-ascii?Q?Atnp2erAVfzqfse92LXumBsHzVO9tT3Cqb6nSNFRlPaOPhMm665GG79pXPMY?=
 =?us-ascii?Q?m6fozEj97htKs01kajXcwermh9eGYqHVwWru8CMZbORWJszFatCvBGIgJXQx?=
 =?us-ascii?Q?c4+8YypNH22hxOheQS2mS4rRt+/NoooHZl6w0u8S0t5BguXu4FqpdhlbDPS+?=
 =?us-ascii?Q?Ac6s7IQNKJiUaZknZBvl3S4aBmfJRkF7bbaYHlSr8yfjEDWG5SxVGw49vNiX?=
 =?us-ascii?Q?2GZxl7sGy+xrJDjLCh5LhzkodAIjkDlqfqLWjpJlmQTgomQPmWbzFTI/wQWA?=
 =?us-ascii?Q?D3M/mv0obRZgaJ+K05nt0S0b9Nf3hwJpAU24ML7Xr4xj2JaUjEVvX2OqL/7j?=
 =?us-ascii?Q?Hzx3SiCdLegkDKXetQg4yQzfgfyhMzoQSZlktYFBTxQrb2FwTW3+4WzN49PW?=
 =?us-ascii?Q?f+bJwrzmRHtl/k27oXW9pf2+01N7/aBCmcKGTJm4WLB6xHhY40bBYiP431XF?=
 =?us-ascii?Q?ySbt6gTpn5Qv8gOh7hY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d626c3-f93d-4772-c005-08de0b0ae307
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:17:32.3679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEXB977c+3VQwlTJUve221nUrz/993ZnSQZyZKu72iUWUYFnfnZ1RIEIlLds7byb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11746
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

This series support timesync APIs, improves
queue reset logic and include minor fixes.

v2 change log:
 - fix 32 bit compilation

v3 change log:
 - update commit message of coverity fix patch

Gagandeep Singh (1):
  bus/dpaa: add FQ shutdown and improve logging

Jun Yang (3):
  net/dpaa: Support IEEE1588 by timesync API
  bus/dpaa: Disable qman Invalid Enqueue State interrupt
  bus/dpaa: Set max push RXQ number

Vanshika Shukla (1):
  net/dpaa: fix resource leak coverity issue

 doc/guides/nics/dpaa.rst                  |   3 -
 drivers/bus/dpaa/base/qbman/qman.c        | 412 +++++++++++++++++++---
 drivers/bus/dpaa/base/qbman/qman_driver.c |  27 +-
 drivers/bus/dpaa/bus_dpaa_driver.h        |   6 +
 drivers/bus/dpaa/dpaa_bus.c               |  51 +++
 drivers/bus/dpaa/include/fsl_qman.h       |   8 +-
 drivers/common/dpaax/dpaax_ptp.h          |  95 +++++
 drivers/net/dpaa/dpaa_ethdev.c            |  69 ++--
 drivers/net/dpaa/dpaa_ethdev.h            |  13 +-
 drivers/net/dpaa/dpaa_flow.c              |   6 +-
 drivers/net/dpaa/dpaa_ptp.c               |  50 ++-
 drivers/net/dpaa/dpaa_rxtx.c              |  93 +++--
 drivers/net/dpaa/dpaa_rxtx.h              |   2 +-
 13 files changed, 672 insertions(+), 163 deletions(-)
 create mode 100644 drivers/common/dpaax/dpaax_ptp.h

-- 
2.25.1

