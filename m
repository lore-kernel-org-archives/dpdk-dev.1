Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5C8D2ECFD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 01:57:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BB8040666;
	Tue, 20 Jan 2026 02:57:09 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013055.outbound.protection.outlook.com [52.101.72.55])
 by mails.dpdk.org (Postfix) with ESMTP id 1C7794026D;
 Tue, 20 Jan 2026 02:57:07 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=li2UR8Y+cI9QYidCkDQTo7mZJcnaDFpLph1SMLoCn55evGSY1Pkk6EINjpkaLIl58JVTd4Uf/pNgu9mOBcIHKBS3GLf7FlX2X6ftK3jp8GXJsbzWMWn5InCNxzxxyZfhLBQjPlG2dKHB2scRD2/4CQYJixKeYkwiKivpJ84DFa3LDANQRs/5nzmecz/sRfNnc/xxAbn5EB43QDJWzF2Ne50QZ5TtvARAp53kdxcwIJAfvcgczMOGZgazmtzpHI8JCsPeZeoZAZQdISR8u3Rsjk59Pqv6lMq18DGikggK24cDTESG6swFv9LrCbY0AD0ZmpB64BRy6PODdZwgDHui8w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucAnU5prqslir25DbLSc+Ge9F2t912P6yvot5UxKQ9Q=;
 b=bXEwMOV839STAzslH0snYNMgROw7SnhEKWAZs3G0fiVySzc7gPaedW58aOh0PyFnx3KH/p1hwlWCa/qCSg3Y5FFqTKxsqEmEEla4vnZg33csf94dLfowZD/HWiXrOmoij6tLDBP0r+WqxMzo/qj7JeY5y3D1Mw/vt3cBARDDL6iRMigMru1VsvsSYuXvpcODCXmxVBWkCmJKQgE1t2i4AlEW6m/z03EWbpxUK2I37Mq7SJjkHPA2VfIEBciTwQpkuCNCBwmty/MLHbkDHm5uW4c/i3KRuqGj2TnPufAD0RwSQc3AGwLvXn5J0WHztd5FwpJgo9fRwGfxUMqvRuEzOg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=monjalon.net smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucAnU5prqslir25DbLSc+Ge9F2t912P6yvot5UxKQ9Q=;
 b=FdcUcPrbCo2Iqp20q5MO9VV4duySPdmuMUUjVhWBLk3mrmw5dNHfe2c9Bp3qCl1bRAGhVUT8HymCgU3z/Ipx+p7SEFVS4lBV3fr1EpywB5J5BdVGBjSU9r4Oz2OTZw1ZHMd4iK17YQnYyxndjQCvWjivDJw1bl2w+rr0jsBkkjc=
Received: from DU2P251CA0009.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::22)
 by AS8PR08MB9290.eurprd08.prod.outlook.com (2603:10a6:20b:5a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 01:57:04 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::ba) by DU2P251CA0009.outlook.office365.com
 (2603:10a6:10:230::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 01:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Tue, 20 Jan 2026 01:57:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PucZiLu3J2uCto9X8NBtHVtgf6LzS4kYwGz27SvEo7hVFU89yBl5q5yg0wRzEY59E4ppmV84lBkK+KHAAmPGkcMTNB0l7qi1qURej9FHp0qXmF7D4tNeHnAY+VBzFFWWWXDb1Efz2G13fLaMV7RSxZT4JbXAiZMyJxMFX9UAcE9keAOFJkhxkEh670RcxZ+fnhhAXhqrG15+1GN0eQUlxbJfjprzBrveAlhLeZd3P3II164y9bvFXngpm4bNsPTDWl5DAhAm37v59aMf8mBcD0kwU1m584nbw9DMP8veTBYSjlQr8KHAeGDlkpLfsuHYoTLZkzmmAJ3oIbBmkBC0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucAnU5prqslir25DbLSc+Ge9F2t912P6yvot5UxKQ9Q=;
 b=q0mH5gAsCMRY+lsRXeEB+6VNhvR54WUewBO6TkQgcrM0riXcvkT/pZ5gsaWF6wnb6KJapCIFOEQ97uyDOp6hww2adqM0WEzzigp2kVwB4vsqodw58zSK18E2BJqrH8LTp2kQt/MsHDwe6rvKPGWhtWuj1nzMGPqYacV80RBRN3fqlGsRuSZ1hjaAbOx6BZlVLyIxgKr5i3hh8rd3JJWE088hZ63RsDfRY4Zjfj5Ws0OpGQHava752ej0vLkQwnwV12seev2YSVaNFpeJ9UOTcQWtzbTGniPY5lQF9ar5Vw+qFx+z4/Se4PqpkDuDh3ZyeNwhmjbPs+IvFFR9l5StYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucAnU5prqslir25DbLSc+Ge9F2t912P6yvot5UxKQ9Q=;
 b=FdcUcPrbCo2Iqp20q5MO9VV4duySPdmuMUUjVhWBLk3mrmw5dNHfe2c9Bp3qCl1bRAGhVUT8HymCgU3z/Ipx+p7SEFVS4lBV3fr1EpywB5J5BdVGBjSU9r4Oz2OTZw1ZHMd4iK17YQnYyxndjQCvWjivDJw1bl2w+rr0jsBkkjc=
Received: from DU0PR08MB7662.eurprd08.prod.outlook.com (2603:10a6:10:318::10)
 by DB9PR08MB8505.eurprd08.prod.outlook.com (2603:10a6:10:3d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 01:56:02 +0000
Received: from DU0PR08MB7662.eurprd08.prod.outlook.com
 ([fe80::1dcc:82f7:7ae1:eb7d]) by DU0PR08MB7662.eurprd08.prod.outlook.com
 ([fe80::1dcc:82f7:7ae1:eb7d%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 01:56:02 +0000
From: Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org"
 <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>, nd <nd@arm.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: MCSlock: update maintainer
Thread-Topic: [PATCH 2/2] MAINTAINERS: MCSlock: update maintainer
Thread-Index: AQHchz1B5lKZP9yJ9EaD0gNMIa9bwLVaUVSA
Date: Tue, 20 Jan 2026 01:56:02 +0000
Message-ID: <D58A1F12-DC65-4198-A5FE-10D05F51584A@arm.com>
References: <20260116230945.1536106-1-wathsala.vithanage@arm.com>
 <20260116230945.1536106-2-wathsala.vithanage@arm.com>
In-Reply-To: <20260116230945.1536106-2-wathsala.vithanage@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.300.41.1.7)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DU0PR08MB7662:EE_|DB9PR08MB8505:EE_|DU2PEPF00028D0A:EE_|AS8PR08MB9290:EE_
X-MS-Office365-Filtering-Correlation-Id: 3537d7bd-2fc4-4f89-b444-08de57c735bc
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?U1V0U2hTbUVVaXUwakZ6bGdwdU9wUC9Id3VsdW1yWExDb25UQU1Xem1TZmpQ?=
 =?utf-8?B?RmlFV1lnT3g5SWpzcEJSVDYwd0puencwWUhHUmw0ZWdZd1BlTnJzckNLYnlQ?=
 =?utf-8?B?djhhbVBvQ0VUU1FIV3RRQk5FcmlQbjAycW1va2cveDQxMTFlT1RBYmxpZS9I?=
 =?utf-8?B?U2NzNGp0eStqZFVBaThqcXpjaXZjV2tnQ0wwQisydHI4UGJGQ0c4T1RHZnMv?=
 =?utf-8?B?cHFUQTFFc0lueUp3cVVlVmVuQ2UvRURKeW5lbmg4V1g2Z2syVVk5bGFpTE9i?=
 =?utf-8?B?MzZ4V2FKc3kzNHUyb1UrNU9jNGtJV3N2YTZmSGdiN1JLeUw3L1RTZE1McklX?=
 =?utf-8?B?SUtYSFpuZUFlR0NESEVsVXAvemQyOFZTZHpEbEFLelhiOUNqZGxXWHF6Z3h3?=
 =?utf-8?B?VVdVM293T0l6d0YvT21SS2J0d0s3ZENsU0V2YWlzUktGbE50cndZTGN5Y0xP?=
 =?utf-8?B?WGp6b1FZSXNEYWpUWDJ4cnpsYmRvRjhUcXpLZGxnTEQ1YTRrc1V0bEpkTm4r?=
 =?utf-8?B?eENVSVFXMTJSWGJ4SnRKNWJHL1oxUVY0M1MxekpYWXI2WmlZMVMzdWpOMTJo?=
 =?utf-8?B?YWZHdkZuakRKSWFvR0VEeWxDVkJrTGpGY2JmL25LU0VJM2duUEYwQWpxNVEy?=
 =?utf-8?B?Zi9iR0oyOEd4WDlmUkJxa09NajkrdHh2QkxnT2wxKytMVUxSNitmZkNxN2dk?=
 =?utf-8?B?RTVwK2V2NDMrbUpCT25Fa1cyNFBMaXdIWU1iZmRXczJhVlc2em1BK1h4TjhD?=
 =?utf-8?B?SUZhbFd4NUJqNmxNR3JJbkNnNU5jQXJuVm96M2p6LzZRRE1iQm9BYWxZZmRE?=
 =?utf-8?B?OVFBR1BNMWZ5Ry9nWVVoVzNUczhENXNrdnc1Wm5Zc2UvdXZFbHM1WUlzYnUz?=
 =?utf-8?B?SDI3OCt3aDBDaXN2cldoOU5HbHZVT1U3K2ZGTThFQk8wdkJtcE5aR3lvMC9J?=
 =?utf-8?B?eVNGcll1VE8xcWxyOXgrUVZRUHh3R0dxdHgyTlFuT2liUUZJb1p5Q2kvTUsv?=
 =?utf-8?B?a3hBb1JSUG5KdHRpeGVDTmF6YjJFa2d1QlRmQkNWNkt6S25EcEhZZzU2VWY1?=
 =?utf-8?B?Zm42K09qTjZpTmtBMTVCTUJzdCs5VkFmVjZvZ0lTVDJEYmY5SS9JRU9zMlZC?=
 =?utf-8?B?ZzhJUWM3NmVVd0RZNEswUkdYY0lLTEl0RUZ3NG11SlFiK1pTZ0VWZHh2dGp3?=
 =?utf-8?B?RzZ1eFJSbEhiQjNQa2F4UHRQY2QrSEp2UEtKTEo4Zm00eUZ4OCtIem9TOFhl?=
 =?utf-8?B?OFEyLzBiOEtDVzkrVi8vUU9XSS9DWjMwM051S0dIbUtORis5Zk5XK0JScWRV?=
 =?utf-8?B?b0wzMnoyaTVkbDlId0JLb0liczIxOWRzZHN2M3NHaFJSMUcrbks2QUJlZ3lS?=
 =?utf-8?B?clJ3dmhMbHhKMTJROW02aGt6Q0JnU1BESTJlUzVZRnp2b1dQNGdjTjRhOXNN?=
 =?utf-8?B?U2VoaG9hN003WEhKSmhleldFUFJ2UERxQ1dKV3MrMUs5OFhJQ0oyeCt1dDZR?=
 =?utf-8?B?ais2VW5UR0hhTnV0bDVlS0xWRndta3owL3FkbkVQMkhRaTd3bG1aR1RHZ2pL?=
 =?utf-8?B?bUx5TkZuWjZBVEVwM0xuMmNlc3VQM3BhYWpEakNoUDFkNzdpVDIxcGI0SHQ4?=
 =?utf-8?B?YkVWL0U4TFEycnpMWTk2SGovMEtjSElZY2VsNEJ1RWJmQ1ZwYTEyNmZza2ZZ?=
 =?utf-8?B?RGcvOThyMm1ldUN0R3c3N2FOZExnWGJ0SnZTMXU4dzFGWndrb053dHNKb0hX?=
 =?utf-8?B?K2dqcEZLTlUyQmNYZ2JoMkVGZklFQ051ZXVSVkQ0aFl2c1J0TjJ5L3NmZlRa?=
 =?utf-8?B?ZnRtSTg4WVo4TE81aFg0b3pQQ0pTTG9xc2pvT2FLUzdULzhWanN4UmkwcGVs?=
 =?utf-8?B?YlJDa2p3V0c5L24xbmZsckM3YjdPSW80bjBCRWxCSFZCbTFQWXlMcWdJcXU4?=
 =?utf-8?B?WHpjTm9BVGNRNXFIdVA3SGRVOHp5czBZb0FicVcvUXF2STUyQk0yeFgwWEJV?=
 =?utf-8?B?Z0c2VFY5TXZ2TU8vQW5JdjdYdURiaERPbjdlU25ITXpwOVVKa01NWTFVTmFV?=
 =?utf-8?B?a3FidTNVTC9XbEEvZUhmYUtaWkpzWm5KVlk0dGFybUtUcElaWWtUeUw2a3hy?=
 =?utf-8?B?YndxWWRLMGcvUng2Qm5GMDlWakJFRnc2K1BvMHM5NG5MekNBZy9CN1JxSFVU?=
 =?utf-8?Q?H2SQvB2cER88z+eNn19KfDQ=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU0PR08MB7662.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-ID: <6312113BD18F2C49A32524E187B98A81@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8505
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3c86e08b-6a5f-4973-38a1-08de57c7109f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|36860700013|14060799003|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEZUMnZwbkVmQlIwV0dScHVwOTBIZmkrL2drVmtLVUZidW9VWE5DUUtkazhy?=
 =?utf-8?B?MGczL05vUTVUY0xxYUF5R0Fvb2dVMU9EZm1NaTI1RmtPY1NWUXZJREhCUXcw?=
 =?utf-8?B?QmhYNGs0TUluWU5iTkMzS1Z3dThxYTF0ZGRsM2diejY4c0hrdmNWUlNDTHJR?=
 =?utf-8?B?amIybnFMS1dCcVlSd2lNS1dycUVKeTFjV2VidlVueUc2aGFLWGEwMGsySmpn?=
 =?utf-8?B?TUxXckg4a3hiK3pseSsyVVhDZ2d0aVhHOEtxeU5vamlmWm04amxXUTdhaGU1?=
 =?utf-8?B?Y1M3a25zVmNWTDMvR3lOZUE3eFdKVXQwNzVyRWttMGZrSG9JSU9PeDhOcncr?=
 =?utf-8?B?VTlQaVhiMkxBMFV1TE1CT3BHNVlxbHljYWl0NUNhT1VLNzgzcnZmZzhqY1B5?=
 =?utf-8?B?Q2RrcWNQNnRsbVR5N2RGVFk1b3l5N2ZhY1M5a2FSNFdkM3NmSmZER0hzQXlK?=
 =?utf-8?B?THZic1ZObGE4OHZZd3pEdVoxdlF0aGUrN1dOSEJjVFVvWVg3K2x6Nzd1Mlhi?=
 =?utf-8?B?Z2ZWczF4aGpOUzhPdmxKWE1XOFRMNG9CRWRVay9GK1E0bzFtWXlHVTVMeE9t?=
 =?utf-8?B?WnZsY2VhTDU5RE41OFQxWlVzL3d2MnNidndNdUpiN1RYL2FJVEtrbWJZN0pa?=
 =?utf-8?B?cHhnbjl5VldLZXVEMTNEMGVUVVFvZjNKVDluRmNCTkdSTHRucDN2VnZkaFF3?=
 =?utf-8?B?TWpDTjVGVU94bVFaSTZpT0l0SXF5RzNhRlE1RkU4M050a0Z4emVFMERwWHY1?=
 =?utf-8?B?dnhMYU9mTStFWnd4Y2JUdWQxRWZ1UlVNakw2dE10bGhBejVzSG56U0JWM3dZ?=
 =?utf-8?B?QWZTRndpaS85S3hVSjZtaG9EMzZWb09tQ2Zsa251aGlyZEFRQ0RSU2ZjQnNW?=
 =?utf-8?B?TTB2VmNsNnRlMzJZamt6VHlGZ3hJdDVmSXdPaENkM2FBclJlYkcyZzh3M3Yx?=
 =?utf-8?B?Y2VuQ2IraUFkcENKSHd1RzZDckhJQ0p4b0tQS2kvaE0wcGFzYUNhdGl2L3Z2?=
 =?utf-8?B?cFhNTEhaQ1g3TmFlbUpHa2dldFF2dHVyell4NHNWV0NrbGp3TWpobjYwdnlG?=
 =?utf-8?B?a0p3MDZvRTE5THV5b2FTOGlKTVQyWnh1dUNIUnVZQWZ6N1MwSVQydEx1YVA4?=
 =?utf-8?B?ajRGeXNFNUM0NVl6NVM5TytGTm53ZWk1L1RhcEhoeVduRWxaanFzSXBXUWNM?=
 =?utf-8?B?WDFsWllZR1Uwa3YvNk1kemZPZWt6TjRZRzVmQ29nNlBWb0ZUZzEwcmtxUGFh?=
 =?utf-8?B?bVV1NFhha2FwdkxTWHIvR3FZMDU0UnlLOEFOM213eHhFWEVrc0RRZFFYUyti?=
 =?utf-8?B?NGk3dW8xcG5FZmFkTzJRSEZ3LytpNldQd0Y0azhzeDhUR3VTMXRrbFlZaFF2?=
 =?utf-8?B?b3Q5dHUwR0JSUW53eXEvOXpaVWFKMWVRK3E0VjBGbmo0YmJZYktkbTlOdDVZ?=
 =?utf-8?B?d3VNRy9BWEJPNVNSSE1zOVYrTHlGazcyZDAwZkdBSlZKYWxkeDlUMXZYNnND?=
 =?utf-8?B?eGI1aEhrcGlsS2JmbWpJdi9EemFEVThTekNyNy94aWRuODV2U0hOVFByVWNm?=
 =?utf-8?B?VGRGTWxxa0lOZFMzNTdSaHZJVFVHMTFyaHZzeFRKY2lTWGJySnluMTI2N1Z6?=
 =?utf-8?B?U2JYR2hmc01CVGRrRTdNaVFuR2pzWDN0d3RwOTJpeEswVHdaaVQ4QWQvbXZV?=
 =?utf-8?B?eVFvcFptTktrb1YydFhCdURzdythU2NGU2tZVlc1bVExa1FVS1JiTGgxWVdz?=
 =?utf-8?B?a0dQVVdaU21PZFpaanRzTFNsbnJBR2NrUkZ3Zzh5Ni84Snc4YlA2RFRwdWdi?=
 =?utf-8?B?bHp1VUErMFpPeS91UzdMY0JTM3FYc2Z5K0VuMzlHMDNBKzJhb1A5QnZ0T3BV?=
 =?utf-8?B?TXJrUWNEcXBkY3pmZGRxakxabE9KZmcxMFphSFUzOVpQcHVrLzFmK2xXbkI1?=
 =?utf-8?B?SThGWks5b0MwcExscmJlRUZLSFF0NTBCSFRtdjk1OStKc1ZPdWpMOTNWdXlH?=
 =?utf-8?B?SGV5TmJvR1JVOE9OUzBrUEpGcmQ3UXR0bjZMeW95R3FOdUk3QkxPN1ZHL2x5?=
 =?utf-8?B?ell2VEtiMUUrcVZIaGFaSmYzSm5XOUt1UU9aelkvWUhGS0JQUlNtZnN0K1NL?=
 =?utf-8?B?ZTN0RGl5dUlXVmlZRS96REtCcnl6bVBCVVBuSDcyVDhzMzNvL09KSDQvSlRG?=
 =?utf-8?B?bVBoNTBrdG9zS0VSU2FkNS9XWTFIR0hoT1UrcXU0MEQ3SlFTVVN2dWhCc1V3?=
 =?utf-8?B?MU5lM1ZLTW5yd1JuRWdmVFpSVmNnPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(36860700013)(14060799003)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 01:57:04.3877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3537d7bd-2fc4-4f89-b444-08de57c735bc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9290
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

DQoNCj4gT24gSmFuIDE2LCAyMDI2LCBhdCA1OjA54oCvUE0sIFdhdGhzYWxhIFZpdGhhbmFnZSA8
d2F0aHNhbGEudml0aGFuYWdlQGFybS5jb20+IHdyb3RlOg0KPiANCj4gUmVwbGFjZSBIb25uYXBh
IE5hZ2FyYWhhbGxpIHdpdGggV2F0aHNhbGEgVml0aGFuYWdlIGFzIGEgbWFpbnRhaW5lcg0KPiBm
b3IgdGhlIFJpbmcgUXVldWUgbW9kdWxlLg0KPiANCj4gSSBoYXZlIGNvbnRyaWJ1dGVkIGNyaXRp
Y2FsIGNvcnJlY3RuZXNzIGZpeGVzIHVuZGVyIHRoZSBDMTEgbWVtb3J5DQo+IG1vZGVsIGFuZCBh
ZGRlZCBkZXRhaWxlZCBkb2N1bWVudGF0aW9uIGV4cGxhaW5pbmcgdGhlIHJhdGlvbmFsZQ0KPiBi
ZWhpbmQgdGhlIHJlbGF4ZWQgbWVtb3J5IG9yZGVyaW5nIGFuZCBzeW5jaHJvbml6YXRpb24gcHJp
bWl0aXZlcw0KPiB1c2VkIGluIHRoZSBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2F0aHNh
bGEgVml0aGFuYWdlIDx3YXRoc2FsYS52aXRoYW5hZ2VAYXJtLmNvbT4NCg0KPiBBY2tlZC1ieTog
SG9ubmFwcGEgTmFnYXJhaGFsbGkgPGhvbm5hcHBhLm5hZ2FyYWhhbGxpQGFybS5jb20+DQoNCj4g
LS0tDQo+IE1BSU5UQUlORVJTIHwgMiArLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5U
QUlORVJTDQo+IGluZGV4IDQ1ZmJlYmQzYzguLmMxNTdjYzlhOTcgMTAwNjQ0DQo+IC0tLSBhL01B
SU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0yNzcsNyArMjc3LDcgQEAgRjog
bGliL2VhbC9pbmNsdWRlL3J0ZV9iaXRtYXAuaA0KPiBGOiBhcHAvdGVzdC90ZXN0X2JpdG1hcC5j
DQo+IA0KPiBNQ1Nsb2NrDQo+IC1NOiBIb25uYXBwYSBOYWdhcmFoYWxsaSA8aG9ubmFwcGEubmFn
YXJhaGFsbGlAYXJtLmNvbT4NCj4gK006IFdhdGhzYWxhIFZpdGhhbmFnZSA8d2F0aHNhbGEudml0
aGFuYWdlQGFybS5jb20+DQo+IEY6IGxpYi9lYWwvaW5jbHVkZS9ydGVfbWNzbG9jay5oDQo+IEY6
IGFwcC90ZXN0L3Rlc3RfbWNzbG9jay5jDQo+IA0KPiAtLSANCj4gMi40My4wDQo+IA0KDQo=
