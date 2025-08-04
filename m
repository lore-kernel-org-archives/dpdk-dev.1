Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0972C87FCF
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 17:13:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87CBA40653;
	Mon,  4 Aug 2025 19:13:30 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
 by mails.dpdk.org (Postfix) with ESMTP id 258244028C
 for <dev@dpdk.org>; Mon,  4 Aug 2025 19:13:29 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=et/owVcD2DLgoeG9QZse7UDxEFHvkJhJc1deJNbH3/Y118i1Sr//A5LOQSqV+1MaEW15de4p3k9rxD4sQ6fEOR6Jr1pKqa5dnul++dY1vWpfYunvLEwMyyahXo+npePwrBKQ8OfPfOQr/FSMC5sQttY3wrIl/x3wLv8GYKZXDEip1zih3I2QkPbAPDvaZcPD6qSz7aX103eWmD0Mev9KWugAakdykwrYSuxmibR+X5Cw2hOSR3sway92eiRaLk95X3AqTXga69HfZgfxyu2Dv+MUyOghzkvfOzADRdpwl4STNy6Mwf5vR7ZJR/gDtt2S26KrMITDBhzs/IpQjdi9Pw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdN9axQ434030MjFF76mbU2f52q9moGzqb/oyeNrnsA=;
 b=kCsapd4XcqyLsDZbgMg9Ry9Isw3oE9a/OQy90HDFV1btInFzkUZJzCLN41JZqtYz5AAdW5jA8sFNM3F8FLbD9Yh4/hqO/+lUlg7LRUMUOTJRbxnmhMxkU0+IjDKAa/h/WC4v+JfAk5hWdKsPLleBV2Gbbmws4jS9Mr6lpcdxxuO8harD+0p3l8wD52lr8uVTuT0KtKJKodxWfUfdR6vyasi09JOgpjuhyaKKWtI9Fd+ubC0Ociq/05lBUAZQcKTlxSMs+rOwuL/EAUCRtksKlq4L1xs28yURa3syZ52dt9ayS/t5BovilrZYH2GeZvFZldwtpCyHwtlPLbQxQcvhMw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=marvell.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdN9axQ434030MjFF76mbU2f52q9moGzqb/oyeNrnsA=;
 b=L3qw434X7m7KYB8FbvxLTBXoErV48Kt/A606jcuXtWKw5O31s+ICr/ItRKYgzIind3N5a7iSYQoY/KfI0Iqxk1hDX04ftjXE3aR8V0eHw7zzy6GvfTmZ/bmsg6pmTCtcHJrliOH8rgjPd/ukVfbszKoCOVDE5npYN2ppP0H2jWA=
Received: from DU2P251CA0008.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::10)
 by VI1PR08MB5486.eurprd08.prod.outlook.com (2603:10a6:803:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 17:13:24 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::e2) by DU2P251CA0008.outlook.office365.com
 (2603:10a6:10:230::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 17:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Mon, 4 Aug 2025 17:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZC70mDauUw2CnBbpwC2kFLDfyLqYIK68UWoNQeKJluxjLKeqOgUl/FiQi4TYfUjaPzla4pu6mIfX4S19D1hl5az5aYH8csI2prSI6P6YOkj0eq6faQr7YK3IfWgRh7Z6Ic+5EW28NJUcFlQrvaKEGJiufM58xNIpLSZDiPs++jSXuNTrYdmNDmBeIm4TAqPkvUHegWM7mseQp3uW9UGhUctShlgk9HKjFHloBtG8BW0ILNuYrOSMXigaLBV6EH1IdqQ6ZJUCh8pk1lURaIkYgfPzx7SqrIeyNiaLJD/6WlQ1mfAXcNII1UK4WDQEeL0ABwxzA41+caZim6EnsWfOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdN9axQ434030MjFF76mbU2f52q9moGzqb/oyeNrnsA=;
 b=FB55SP9aW8bBkcX5mhcdtoBmfApT9LQbDIIL27+MF/19+mQm0g5kz+iztxBvl4XH9o3FoO/ehV1h3KQNnmyuEX6SlK7kLDa2XSRdr23KvzjhWpp5kSbJoRqEIlaK1WnGHIn60207z2+dcgDpmQY0vtLSGAq5HgqsEuEuUYE5ZnJD13+lZULiMdJwAZHs66PYIK2cefsJRGRHTvfcVUTrLI+A3y1y8H5swoCrAesdIQL7IF3uBxwE3OxhqUWCznqP+sWp2frKhKz4xi9Lq82fkS0yOR/nW9ZYYmRXq3xGuHP5tBCLcdae7oaFBgCcpNZUonmmPxaEYBBxqmfbYyF1LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdN9axQ434030MjFF76mbU2f52q9moGzqb/oyeNrnsA=;
 b=L3qw434X7m7KYB8FbvxLTBXoErV48Kt/A606jcuXtWKw5O31s+ICr/ItRKYgzIind3N5a7iSYQoY/KfI0Iqxk1hDX04ftjXE3aR8V0eHw7zzy6GvfTmZ/bmsg6pmTCtcHJrliOH8rgjPd/ukVfbszKoCOVDE5npYN2ppP0H2jWA=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by AS8PR08MB8224.eurprd08.prod.outlook.com (2603:10a6:20b:52b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.19; Mon, 4 Aug
 2025 17:12:50 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%6]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 17:12:50 +0000
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Tomasz Duszynski <tduszynski@marvell.com>
CC: "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "jerinj@marvell.com" <jerinj@marvell.com>,
 "mb@smartsharesystems.com" <mb@smartsharesystems.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, nd <nd@arm.com>
Subject: RE: [PATCH v10 06/10] lib/pmu: do not try enabling perf counter
 access on arm64
Thread-Topic: [PATCH v10 06/10] lib/pmu: do not try enabling perf counter
 access on arm64
Thread-Index: AQHcAs4S25otN9HmFkquuN4foS9LR7RSvqWg
Date: Mon, 4 Aug 2025 17:12:50 +0000
Message-ID: <PAWPR08MB8909ED3F729BD92BD2904F2D9F23A@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20250723044118.2962318-1-tduszynski@marvell.com>
 <20250801102109.3544901-1-tduszynski@marvell.com>
 <20250801102109.3544901-7-tduszynski@marvell.com>
In-Reply-To: <20250801102109.3544901-7-tduszynski@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|AS8PR08MB8224:EE_|DB1PEPF000509F0:EE_|VI1PR08MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db3ac25-dc47-412a-7f6b-08ddd37a3815
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?yVe8fqVZsrwtoCRf+CKE0r/rc3Qjz1WGEp+r5R6JsmJc3+puBYy66lVEvqCH?=
 =?us-ascii?Q?2ivmwoO68oRMk4Z0QvB35rFsaGOQ4XDkJ1aR7h3PmPRr16j+fn4CAEUJG+1t?=
 =?us-ascii?Q?FIPqsSKddQMNtAxyxVgDLlLLHwepNn14lX9Pul5dVNyhDEfqV3YkcvBxPxPh?=
 =?us-ascii?Q?owUnawgevnkN2bbjNZs4mY3OkStf0L6/L9ajng9xSPsF1d8GkqQ5sh6ngA72?=
 =?us-ascii?Q?GwoE4TqOClMiPoJMaMtYdVOlhfM1PfR5wNmqnzv4F7s0IWe4hfBnZTBfT+Q/?=
 =?us-ascii?Q?DIF+sqPeJln8lWxv+tzdiKgm1AGRDMTPKXbLLQcXU/2ZffGkf/hffC7xPhL4?=
 =?us-ascii?Q?hIFDKBVC2ipHQKSpYZiZ7TozFRJMgjULUkz0u2FYL7CRXQAbF8wQghghmOkn?=
 =?us-ascii?Q?C0bwUvjklFDnKPBReCR0PIzkdqXnYzwflMpZk+QY0OuefUT+YySjyoTJA2oZ?=
 =?us-ascii?Q?s+NaMth+qbRItAaPI/zqMBoR9bxLxp00xjexZVKYsi4SPLdyKh6Ka21W2O1h?=
 =?us-ascii?Q?K+7fV71oVV85KF/KL8fAzVwCclQnI9LIa0R6dgZBIb7XoIyE3m14K5oaUeq4?=
 =?us-ascii?Q?qpSGEbncF9U8KQdxviNSaYtAvx4rsEHRoryVQo2CTAfmJ7/D1+tpAtX2VOLg?=
 =?us-ascii?Q?ZVVUWLqYaXY+8IHBKpe7dzRCUSIYicpZbQXaMBb/BMfPWhYzZ0+cl9FzqmPs?=
 =?us-ascii?Q?DDCLbq7LoekS9TV8xuH78emWQ/4q8PkXXRrAzkbJHalSHIf5As/2kKt/PvWd?=
 =?us-ascii?Q?xEJwXjeUeQwwDeOacPRVqzTdabH+grTMlK26vd9nbPqSzg8jMKwnnBYwa2lT?=
 =?us-ascii?Q?oX78D7vMLolyLOxNfNjMn4VCJMLeQ25zyxCErt9lKphjPeU5XAkUR9wFvA9j?=
 =?us-ascii?Q?zKXKufIrH4lzDLsEliHQvYYtczVtClFJo7ByiB9CFu7c+BW7iU52OtRBJhVw?=
 =?us-ascii?Q?6/FKISytxr59/U0jQvIX1fytvjw9EAR7nnSGEaHTm16pq0nVflHlfY0+3T2O?=
 =?us-ascii?Q?w+6s3wQRYUqgm03jdX4GP66UvPsW8U2e3GNGjGWH/zfuNwHt0AidEM5K4b2T?=
 =?us-ascii?Q?4tUrS5YAmYS409u5Td/Gyq3zKys+Sp4yN9KQva70YZrflkBquhVTxBReqmWA?=
 =?us-ascii?Q?9f86IZbW8vassGc7EsHFCSUxmgr4gUFEK4/iJTUxrG5ya34aHMVy3eS7xWKK?=
 =?us-ascii?Q?D5uFsCm2x7yL5qsBmZtB4Sl9miAb0ECBe/owO4RBq5Jel5jx6cor4V5wCpRH?=
 =?us-ascii?Q?hIhig9fgfl/E4ObBgZBOXpWloVM1GpbyYB/GLRIgMUfBSJtzRYSfgMVP3OLP?=
 =?us-ascii?Q?He7Vt7y2jOICZhQOyg1W8MEp2WKM8zInE1pEXy4XllPPWg4tw0HfXQTpepu7?=
 =?us-ascii?Q?4A3ip5J8AM3YUitAblcYDpXqmdUU5xek9wVj9th+yIhTEkzTAN9YBGmwbcKl?=
 =?us-ascii?Q?Ca/YHXsn5C/x3RgmMQ2XR1Eq4RKfiJJM8Nb5FPIrGt0/boxV2CnG7Q=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8224
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7389b057-d514-46ab-b42e-08ddd37a2442
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|35042699022|14060799003|1800799024|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UUI2tBDxhovvdbc+EyFxPMarI50nnpVb/w6WCMUKXtwGojGvMJJ9RfstW5BS?=
 =?us-ascii?Q?/XRPA1tQVblx/hDmXUUuLOZMoK1uATeY1kp/4l4eTwtfW+9vLQ1d4UbWAV3Q?=
 =?us-ascii?Q?GsBMh1FVfC3S22OrPuya7V4xpbQoOzOwhsq9wh2WTGL0Mh7yKN7UlqWdt+lP?=
 =?us-ascii?Q?7iINVQPA+oLvZNy3qBr8FM/lkroXZE177sSDYzUL6W0WujlJjg942xqS9WVc?=
 =?us-ascii?Q?oVGcI3tgsT1Jl5bnAYenRUcpebXZpQUDpOOjJiUSUc7P/zcvIfszwDUHt+Nf?=
 =?us-ascii?Q?nb7bIDhiq05wH8uSB7/BYDZruBXKBLR4ILHkhdk98/lfINPV+eJ2BMQFgAWX?=
 =?us-ascii?Q?YNyZRq7P4sUQG4h+bKcmZxMCBazzWf+GaRSJOmF8Jj/K8hUgFIZYpxbhfDpU?=
 =?us-ascii?Q?y1QzGsY7WlodrGQn/m51aZa1y0sMFpnHULHN+MbJ8OFCVLwV8hAFnmcHZmm8?=
 =?us-ascii?Q?z2aF/S5EP5Pah2v3sH87Wutf/59KZ6PrzTcnsS3HMUT4WAOJ0QuPk1m6S0KA?=
 =?us-ascii?Q?ci/wv6IwBcmOorr1Re1qdIycVcktgBuvl1Bf71a50hQZ0BKDTtHRxtZYMPQF?=
 =?us-ascii?Q?4mZ9E6Tjlros9TA/AqKxRyBOYU+eoyp6GH/maoHuEVbR6sluoZ3zzCaevPya?=
 =?us-ascii?Q?oJRMFU67hHBI7FyPx3TQhdzGqG/DBEmaHEnxRxSomPMKu73IqStPV1AVm7x/?=
 =?us-ascii?Q?fA5JKRqDDHA9qleHO4fzXGTtZpQ+MHFITVFmfs9VTqneHiUn18EiHfyvRWCU?=
 =?us-ascii?Q?a+BKUVajg8YwcYkRU2KZHogN1HriI3p/yZ47oOJr5yyVrpAyAOBdDhTRWKAX?=
 =?us-ascii?Q?rFS9+rwzhvzu/hzyLAIi3I5Kzs6xFi0XdhsbYcPcSuNwWSINt+s2znjVQaLq?=
 =?us-ascii?Q?nYyAT0dL7C9Vl1imMNJRGCK1+OKWf4toPLeWoTfNHlnkTm8qbmaxPr4OClIN?=
 =?us-ascii?Q?D+b31o8CG6cxsk9fzj+7DNtvGBm0a+ugL+Bl1NniHMTkPXFBTHbVLHPTn5II?=
 =?us-ascii?Q?3nMN7wDiFOT0nRjtfm6PRpt+CSi/RVcfvAnomti864Het+XSZuk25P0hXu3U?=
 =?us-ascii?Q?DeyKw9ufpbbhuplwMRnIAaytCrCmP9WFplhMnKo3c83FZapFpQM5+DPJEiqA?=
 =?us-ascii?Q?QZVF8NbT7geL7pMOEdY1pEVr9IyXzLBv/uzqPdF25NfD2hrVG912SiKZGGmZ?=
 =?us-ascii?Q?htVy7vYlsxNO4hLlawlR+foP6aRMyULqSBoED4lnQ19ISX5RnEOmOEBs0zsp?=
 =?us-ascii?Q?1BF4hXnQ/1IZGnZ6RTYOUHYpu1Zj5UUqvVBLIyBdEgHXHTw9J5LRQcYMJFaj?=
 =?us-ascii?Q?jnxEmR62fTSWjSgcqVvFXQ9bGGV9B/2MSQCC3JOz1X49p2C2Re8BPIKXJH4Q?=
 =?us-ascii?Q?0JYqA0wDdcneHiKQfRYnBuLGAIITeJv155pRk7TyFGZx451tuRDdTHSJgYzM?=
 =?us-ascii?Q?8Md3RjpUx5fo4kLL64anATCYz2LWTR6/sKcIRJeX9wQwjd//7bIn64sLpVQz?=
 =?us-ascii?Q?3niEVwHippJ8GCRxhvyAX87ayMvAZrW2TLBb?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(35042699022)(14060799003)(1800799024)(36860700013)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 17:13:23.5879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db3ac25-dc47-412a-7f6b-08ddd37a3815
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5486
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

> Subject: [PATCH v10 06/10] lib/pmu: do not try enabling perf counter acce=
ss on
> arm64
>=20
> /proc/sys/kernel/perf_user_access attribute allow user process to access =
perf
> counters. Though in order to change it binary requires elevated capabilit=
ies or
> must be run as root. If that's not the case counter access remains disabl=
ed. Hence
> to avoid confusion log message that that warns user about that.
>=20
> Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>

Acked-by: Wathsala Vithanage <wathsala.vithanage@arm.com>

> ---
>  lib/pmu/pmu.c         |  4 ----
>  lib/pmu/pmu_arm64.c   | 39 +++++++--------------------------------
>  lib/pmu/pmu_private.h |  8 ++++++++
>  3 files changed, 15 insertions(+), 36 deletions(-)
>=20
> diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c index 8cf2e89c69..97bab80368
> 100644
> --- a/lib/pmu/pmu.c
> +++ b/lib/pmu/pmu.c
> @@ -25,10 +25,6 @@
>  #define FIELD_PREP(m, v) (((uint64_t)(v) << (rte_ffs64(m) - 1)) & (m))
>=20
>  RTE_LOG_REGISTER_DEFAULT(rte_pmu_logtype, INFO) -#define
> RTE_LOGTYPE_PMU rte_pmu_logtype
> -
> -#define PMU_LOG(level, ...) \
> -	RTE_LOG_LINE(level, PMU, ## __VA_ARGS__)
>=20
>  /* A structure describing an event */
>  struct rte_pmu_event {
> diff --git a/lib/pmu/pmu_arm64.c b/lib/pmu/pmu_arm64.c index
> 3f4f5fa297..2c40b5f702 100644
> --- a/lib/pmu/pmu_arm64.c
> +++ b/lib/pmu/pmu_arm64.c
> @@ -14,8 +14,6 @@
>=20
>  #define PERF_USER_ACCESS_PATH "/proc/sys/kernel/perf_user_access"
>=20
> -static int restore_uaccess;
> -
>  static int
>  read_attr_int(const char *path, int *val)  { @@ -39,49 +37,26 @@
> read_attr_int(const char *path, int *val)
>  	return 0;
>  }
>=20
> -static int
> -write_attr_int(const char *path, int val) -{
> -	char buf[BUFSIZ];
> -	int num, ret, fd;
> -
> -	fd =3D open(path, O_WRONLY);
> -	if (fd =3D=3D -1)
> -		return -errno;
> -
> -	num =3D snprintf(buf, sizeof(buf), "%d", val);
> -	ret =3D write(fd, buf, num);
> -	if (ret =3D=3D -1) {
> -		close(fd);
> -
> -		return -errno;
> -	}
> -
> -	close(fd);
> -
> -	return 0;
> -}
> -
>  static int
>  pmu_arm64_init(void)
>  {
> -	int ret;
> +	int uaccess, ret;
>=20
> -	ret =3D read_attr_int(PERF_USER_ACCESS_PATH, &restore_uaccess);
> +	ret =3D read_attr_int(PERF_USER_ACCESS_PATH, &uaccess);
>  	if (ret)
>  		return ret;
>=20
> -	/* user access already enabled */
> -	if (restore_uaccess =3D=3D 1)
> -		return 0;
> +	if (uaccess !=3D 1)
> +		PMU_LOG(WARNING, "access to perf counters disabled, "
> +			"run 'echo 1 > %s' to enable",
> +			PERF_USER_ACCESS_PATH);
>=20
> -	return write_attr_int(PERF_USER_ACCESS_PATH, 1);
> +	return ret;
>  }
>=20
>  static void
>  pmu_arm64_fini(void)
>  {
> -	write_attr_int(PERF_USER_ACCESS_PATH, restore_uaccess);
>  }
>=20
>  static void
> diff --git a/lib/pmu/pmu_private.h b/lib/pmu/pmu_private.h index
> d74f7f4092..82118df8b3 100644
> --- a/lib/pmu/pmu_private.h
> +++ b/lib/pmu/pmu_private.h
> @@ -5,6 +5,14 @@
>  #ifndef PMU_PRIVATE_H
>  #define PMU_PRIVATE_H
>=20
> +#include <rte_log.h>
> +
> +extern int rte_pmu_logtype;
> +#define RTE_LOGTYPE_PMU rte_pmu_logtype
> +
> +#define PMU_LOG(level, ...) \
> +	RTE_LOG_LINE(level, PMU, ## __VA_ARGS__)
> +
>  /**
>   * Structure describing architecture specific PMU operations.
>   */
> --
> 2.34.1

