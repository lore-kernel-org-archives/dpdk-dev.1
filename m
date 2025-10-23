Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56608CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 00:28:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A01A3402CC;
	Thu, 23 Oct 2025 02:28:42 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
 by mails.dpdk.org (Postfix) with ESMTP id 0CCBF4025E;
 Thu, 23 Oct 2025 02:28:40 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pnXHtFvhAfcqHLhTiQ6As8Ro6kBWTUh+biLEFqTKfc4dnICP8w+Szn64x/AWp0PjBY37EDhUmR9WQT2Asl0zQ/MxSma5LAEchPWNzxow9+g/2IYh4PCThwLPgpk1W/GPKj4F/q9HyhMpD0qx1VINBAdjqTAYeO1cjV0blM/OKNZA/MdR3nlDiuF2D3V3/gYu4/BaPFeDTV7fOV3/Mv6vAahonKAN123DDboR3mFbLfIex5ij5nNBNROlVPjOx3nMrxk4Esofbp76SSujasRC8E08o6MwilgPy/TKpuOzCqaHShQ6Q94f9fCydlrTTD3e1R8B/09so2vHj00VZAXM7A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6H5x1M0f9/g2N4OhFEegYsqd+gHqv9ukUarMGTkhj8=;
 b=fCIEqwM5xI9FqEJzQAiAMwPK4SytH0Iiy0JHGXQOzxbVZx04QL0QWgczyMxnlCb87tgCZ9EG0kUEj/noBFDbx60YSC11Qzf+cY6XQAz2EUZ8tbdwONtMIMks1xQH1cPiPfJqaEiwOht04CG1r2WJuhE8CPiZNdV2iuKvS2kaZroNqjNQMt6OHBmoHIX1pFQIbo48RBsLh+D+pbUVlk6D/LW1j8mkFv8LelXnYu4ONydi5W0TTqLi/3ikTIPLjZWVl8Py4w5BEQAUSKzNpGrdX8TiOOHBZ2xsSVgLRjmY0bMBd2kR4tcADyvhJkcyS7jGrxWuzvI/eL59sCi6RP3Nwg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=6wind.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6H5x1M0f9/g2N4OhFEegYsqd+gHqv9ukUarMGTkhj8=;
 b=M98OQ4VoGU8fk840uZpcEaw/zty4HrQ9FFazy1FSxNb2SZRUNoCFA7hMZ3uf0BnikYy2wIxqFhmKfikeOQnCfWRVJjdjp8fDAW9aHuRNeFxMGBAmIwXRHXHjS2PGHXNipLGZO5wucztOC4otHbv03/vZmcHsHf50LZFiLtGbm/8=
Received: from DU2PR04CA0044.eurprd04.prod.outlook.com (2603:10a6:10:234::19)
 by AM9PR08MB6707.eurprd08.prod.outlook.com (2603:10a6:20b:305::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 00:28:37 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::28) by DU2PR04CA0044.outlook.office365.com
 (2603:10a6:10:234::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 00:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 00:28:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCr+sTmfcN4zckq5ucV3YOCa+3efd3KQHck3hla8UcS39N5Jy6qO/YWPOfihti72O12e5ai9c1+byfzFLg5dca2u2XXTIPCcSjWgzdIrm3lMh359vFdfWE4wxXDDxJndlzO69P1ht57jo+oMvFI505RSgnjLteYTnaKc6rxEgl+2YBwKaOk911nCR+9FGmZcHahc8ma2hDU09eg0ty0pvIjNW1LXpPG1jLLVvCnpnIwTrIb6mgRqc/iTlIv7M0mo1U1JTiT7FTegpV9YQJ54N013LSWDxQCwpRxD1GqTE+hzMG+s5hBE7l6PiYPQ6pgAJJ/udX5CBUw+tIVjmIL6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6H5x1M0f9/g2N4OhFEegYsqd+gHqv9ukUarMGTkhj8=;
 b=EL1BEk/KZYF0pXdqHastWFfkHu9W37av/vc0min6AMwnbHCz1wSTfy03OSeOc8jr6uIhfZml2PYnNhIkAWj3zQX8heofHQbfcDeE3EOGkOoWSH21EEglvqLvh4xV2kCkWqEImGhYdnNV29b3jtXiyL98j0w0sPLio6KTIeDx3hZLBFh5NuIFwoOOy9U/jFni8YBDqasWlhsUIivjWDcUZQ6hQDUdxHlHjAFlium6Vz28xP3SJnD9VgcBCUmFLVipGSEevyd+qaBT9pXjPPndMuhiZJx/ZcCuztNCKKUGpLv+Gvit5FKGCCPnaShI6talQCz3fGT/yzS1EnlRxXS6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6H5x1M0f9/g2N4OhFEegYsqd+gHqv9ukUarMGTkhj8=;
 b=M98OQ4VoGU8fk840uZpcEaw/zty4HrQ9FFazy1FSxNb2SZRUNoCFA7hMZ3uf0BnikYy2wIxqFhmKfikeOQnCfWRVJjdjp8fDAW9aHuRNeFxMGBAmIwXRHXHjS2PGHXNipLGZO5wucztOC4otHbv03/vZmcHsHf50LZFiLtGbm/8=
Received: from AS8PR08MB7339.eurprd08.prod.outlook.com (2603:10a6:20b:446::11)
 by DBBPR08MB6028.eurprd08.prod.outlook.com (2603:10a6:10:208::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 00:28:04 +0000
Received: from AS8PR08MB7339.eurprd08.prod.outlook.com
 ([fe80::98e5:ae7d:ccb9:beb8]) by AS8PR08MB7339.eurprd08.prod.outlook.com
 ([fe80::98e5:ae7d:ccb9:beb8%3]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 00:28:03 +0000
From: Doug Foster <Doug.Foster@arm.com>
To: Thierry Herbelot <thierry.herbelot@6wind.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, Bruce Richardson
 <bruce.richardson@intel.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, "stable@dpdk.org" <stable@dpdk.org>, Olivier
 Matz <olivier.matz@6wind.com>
Subject: RE: [PATCH] config/arm: fix inconsistency for Neoverse N2
Thread-Topic: [PATCH] config/arm: fix inconsistency for Neoverse N2
Thread-Index: AQHcPnOrEkCvvgq3e0mQ2CzmYouVobTO6n/A
Date: Thu, 23 Oct 2025 00:28:03 +0000
Message-ID: <AS8PR08MB7339DA678541942C52F92D3AE5F0A@AS8PR08MB7339.eurprd08.prod.outlook.com>
References: <20251016080533.535266-1-thierry.herbelot@6wind.com>
In-Reply-To: <20251016080533.535266-1-thierry.herbelot@6wind.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AS8PR08MB7339:EE_|DBBPR08MB6028:EE_|DB5PEPF00014B8C:EE_|AM9PR08MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: cbce90a2-a7e3-4ace-3461-08de11cb1b94
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?4Rm8Cllk236OJuW+LGjVqVgSS4tnH0lRsCF/MUkigdWI/+xBHLQrT6gBUAP2?=
 =?us-ascii?Q?dmXwlnb7EIuPnwD+FZuacEKGPDJyDEgSimMsVv02ZTTsfYC5AEKfC50Ahkwz?=
 =?us-ascii?Q?TyyqTc2ZmGJJKVSrmqCtNk0lHe+5eTz7kie9dejz71m4ntvrMcpIY0zU8Lr7?=
 =?us-ascii?Q?WbaS+4tN6tLQ2sWABd7B6w6x9fpGAl1r4dl1BcDmdNKHeHV+sGmarXhgTMlP?=
 =?us-ascii?Q?VuIR3vr2XsEF4h11mmuBKIRRmGV3OP4nAhOcO1TvOswWPG6PvQKVH8pEqWn6?=
 =?us-ascii?Q?pCakVimi3zoOKNZxGsWRGAs0wb+4LWEyecXWIvDUsqXbZ8gJ7Nv5bbOIVXHz?=
 =?us-ascii?Q?VoxjSqiWua4jVC65He5Cqp1mqnQzVeZCAT4FGT5sr9lkhCkF1hfmNHf6YZbz?=
 =?us-ascii?Q?Vr44riTc1PNGSg7mBAhjuPqYo9lMUCAM4suH4bsM3k0dW2/Qx5Z/Cy30gc3W?=
 =?us-ascii?Q?xCxfJ8pBDfWrcnwbkP4O7jqqE8G06jqoTHCkDxw+n/2YtGlz+uJvE5ax2HuF?=
 =?us-ascii?Q?uccxH1M5yaNA3CsE/fqfXICcSyS/OXQCeUaJN/M3l1WWPjMlAr9H9vk+TB1g?=
 =?us-ascii?Q?AaRKaABV85pWzuQE4DF+qD5mxTMyGDLlEnBWu5lj8/WFapvdni5aqbIwFTPP?=
 =?us-ascii?Q?+3dBAhe9vUSWMIkZvU+feajsqbmgshEnEY0eUApjpZffJGZH1sSlWxMtIOFM?=
 =?us-ascii?Q?SVX/Lj3QbhP57zDqx9m2Aw/g17UKE5Q4zS3xDaM3aJ25W0WP6HUGVS81g1bj?=
 =?us-ascii?Q?AV8xsREYU6ObIS9i6NcfnQyaug2g7XwqbvoUXUB4InH5XPFsTlSnW8Luw98A?=
 =?us-ascii?Q?8KG+SFmM5+D0SNWpcgNHS70/At2eqwd4QdOoTYY808DsIdfsSojwFRKDh8KG?=
 =?us-ascii?Q?lKaXDXoDV/799mTt3vyaMotybAN30Dg+ylYDoX/gx3DWnq0WsmCSZSuZiZdH?=
 =?us-ascii?Q?Hx5ke5no4NEBihJ0qhV/YHDJvgL0ramhBOZKztTlPZJ57OSLcXzkxGkENYtm?=
 =?us-ascii?Q?2moHvzrFgJKelNXcGzCd66kg8dYLFsbcc/Tboo12DvlI5vOZhqfDiiaBvcEX?=
 =?us-ascii?Q?mSPAWdnjHILF5MX6w1FCjr6AhboojuP07wP4SXo+Utkc/1dHyh9y0NV3Ul2a?=
 =?us-ascii?Q?LxhJXm63DywLbezG667S/PlByJ8pLrLpP6s64zjcNRH6KuSKGFvsugIe4uQy?=
 =?us-ascii?Q?ni32VxNfDuUaVRxgg/c2KAAZR6dzmRD9n46nbj5BGujm1dIlloypR+vTQqIR?=
 =?us-ascii?Q?fmQrefNXsFLphflg0HY5Tq9FqJwQOu877P0idjEZ0cDJlRXdffUppOtHi64q?=
 =?us-ascii?Q?jQR3nfguO4rV86xB9Svu6PEpRz5NR5mz/Lteufs3sLTU+T6We5coXL5q4rxW?=
 =?us-ascii?Q?7PztKQJ+VFTgAIG8NxYGoqrbDpCHVGLsLu3GC0FjRjFM9CaMUxBYzpG7uc4c?=
 =?us-ascii?Q?GnCCxl8xANgV4HkQAHeiJ03iVRsWUTBPj1bFN8lKPyWDjzNygKHz1HIHnKLI?=
 =?us-ascii?Q?Dd2fI6x4eATu5/GKGfmnftjEpeF625JOfZkL?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR08MB7339.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6028
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c0134e75-1ec6-4063-8284-08de11cb079e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|376014|35042699022|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Npdfxb9N3fakKl+wnDU9Exh9mplqwtk3sNjtE8pGGHXkmqfic4M51O4BAMO?=
 =?us-ascii?Q?EZT6+fE/Y2temESqbvOMlfsKaK8mgozNMyOfpeE9eUkP+Km6U2C3UlDJ/Q4t?=
 =?us-ascii?Q?sJUPh9RHoChJtU09rGLXbqqjFaaSdlsMbBEQvH7P5GU75K4la62sa8J1dhzO?=
 =?us-ascii?Q?xTRHPRuMZESiEySanACTbDW0OujJ6P/j2HCKMA6/6pbDk7udqvkTFq+HFGxs?=
 =?us-ascii?Q?9ZWf6x50nkA/PMHoMerrV5NBmi0I/kFp8zAn15HkHzkpUUfc4Ez/Bg5zd6Pn?=
 =?us-ascii?Q?SdeBbeaL4l8nQCqpQk53I0pxreL/zswj7ZwqNVLf9cF31mbKncVDUxcqKH44?=
 =?us-ascii?Q?SQiDjr8m27wY+AZvgtAwla8NlzvzbzA59T6PFvqonQV4+e3k2kiMprYcEBFO?=
 =?us-ascii?Q?FlKgYZf5T8TE6kqZphl7vH9lbWhdkFbFjlzsGfKgloKVSoy8m2jJmqa/8w5Q?=
 =?us-ascii?Q?fodlzJX9F7NyrRVlqbtfI4pQTOj/Qqtp0rNeYbmxZra9fQ9xlgLYMeMMo8If?=
 =?us-ascii?Q?LY337oa3pke1lljyNm8JxhwYz3aK/bP5gS++Yzh6zojLqpb4uvM0xCCi5WvO?=
 =?us-ascii?Q?HqmCeLGgAx3GLw3nXBY33ldsviSYcK0Bb7Pair2tzFgjMcIUpiyF6iukk8oR?=
 =?us-ascii?Q?gDQGES7BieR2hCe1C5nIV+TadiAuzzpbW1ruu0bgovo8it9Vmz+hxRE0ZiIB?=
 =?us-ascii?Q?YzB+byvzxiHg/8wtNCyjXckc3jPXyxy0bKlYN1U6AaCS0xPmS6ZTMkFt5eH8?=
 =?us-ascii?Q?O8g8yN9lXpIUtFp+/e+zuZczb2h9YhKrJ4XzCH9ri88m2HyPDPYsT0/U/zzM?=
 =?us-ascii?Q?UU5nSjULyuIA/xUvgkXQYma8D88bJvZqaZhs9nehW65rSl78lMQdx8reO9ux?=
 =?us-ascii?Q?XLt/eowo8U3OwVUq/LmsiHGaAR1+J1R+HgDp+VoFPdPC1rRLQskpxgDCOgFL?=
 =?us-ascii?Q?GGVmwWXUcdTBUZtCtevXlm/ThrXfeDJOKnIT3xwDO+ln7fn8I8bCAVwnaUCm?=
 =?us-ascii?Q?D/rqSI8vHqkMCLwE11kIQrOgABtyWnEBI71iSozRMM1mCjgsxvXiIcTBg1mj?=
 =?us-ascii?Q?RSGLc/tp8dM8xPzoT9iEFSrK31/vUKaNRVmvTr4LZtAyNatYov3+h228bOo5?=
 =?us-ascii?Q?GwB923oXfRpuruIOQ1lNCai5KGdB3wjEAbRcJReXYVbOBoWki2CgwKivLMKT?=
 =?us-ascii?Q?9WimeedYiGzh5Z4HyYA73/ugGcQ1fExoDDqoOOj3HVKR0Ys9jFIdbWw/Bomk?=
 =?us-ascii?Q?OJNtg/gwDR1LFMdz0cO3ur1EW658sMyp8mfsGpMBRUMOt7kYrSntALbW0JtV?=
 =?us-ascii?Q?ImuUF9vg9B58kaHEI7410Mt6/49U/eQWReNL5QX8dnBuxdLNI2ko84VF7eZL?=
 =?us-ascii?Q?8Ha6NiW8k7CI09Ir67tkfZcgwzOc2U/8XBOyQzxUWTJTdD4r7lTu5hlH+wJU?=
 =?us-ascii?Q?KdOuFdlLjufFXvcCl6wCGe1pwr/t9z52jTqXU9kxSOtUvhBy310IqOW+hMYL?=
 =?us-ascii?Q?76DBtbtQg8r4jQTR7JD+vUtYVzxukv4J0B2IipR8lKwNvEhxowQPKmpE0340?=
 =?us-ascii?Q?YPorrVXpuqzb20KOf7w=3D?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(376014)(35042699022)(82310400026)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 00:28:37.0890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbce90a2-a7e3-4ace-3461-08de11cb1b94
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6707
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

Acked-by: Doug Foster <doug.foster@arm.com>

>-----Original Message-----
>From: Thierry Herbelot <thierry.herbelot@6wind.com>
>Sent: Thursday, October 16, 2025 3:06 AM
>To: dev@dpdk.org
>Cc: Thierry Herbelot <thierry.herbelot@6wind.com>; thomas@monjalon.net;
>Bruce Richardson <bruce.richardson@intel.com>; Wathsala Vithanage
><wathsala.vithanage@arm.com>; stable@dpdk.org; Olivier Matz
><olivier.matz@6wind.com>
>Subject: [PATCH] config/arm: fix inconsistency for Neoverse N2
>
>Configuration for hex code '0xd49' enables two NUMA nodes.
>Then, the corresponding 'soc_n2' should allow 'numa'.
>
>Fixes: ea85ed1f6882 ("config/arm: increase nodes and cores for Neoverse N2=
")
>Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
>---
> config/arm/meson.build | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/config/arm/meson.build b/config/arm/meson.build index
>665f3fa38fcf..316f23941996 100644
>--- a/config/arm/meson.build
>+++ b/config/arm/meson.build
>@@ -590,7 +590,7 @@ soc_n2 =3D {
>     'description': 'Arm Neoverse N2',
>     'implementer': '0x41',
>     'part_number': '0xd49',
>-    'numa': false
>+    'numa': true
> }
>
> soc_n3 =3D {
>--
>2.39.2

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
