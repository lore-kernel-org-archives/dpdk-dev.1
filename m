Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388E3D2ECFE
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 01:56:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 341AD4066D;
	Tue, 20 Jan 2026 02:56:55 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011018.outbound.protection.outlook.com
 [40.107.130.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1594D4026D;
 Tue, 20 Jan 2026 02:56:52 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=czKQIg0XIA/ZYIB/cy5d3DfctQJA6XmeBnz7P06h6AaGEq3i7jJclnuoEIG71Qz2qB+5AHhh7sZDOCG2GvHe1WRMIqErg2YseCKHMfY9FleovxNTN0N+nuUIsf5XUBROU7R4UVEnPhRtW8wshToVLMbc4JtX1WzsBchsghq7TnM5HpPI3XUTITISfwMHs04UwS3TzugJj6JPikdTuajbhRFYsVpb/JckYTkcYy6bd30NHq83Ig3emeWV2jtkuz0YUV93e+wPS5lFAHM+JJQGck1fl+dj8Io6S/SeiBZuiZsuIqVlefNreURdPNB8SDJy86RSVV5IL2+zC9GlVbVMuw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D528ZYYX4k3NwlQMM4KqZnFWxxOcbqdIawhMy2Ek3Fc=;
 b=K39Yyrm6ha9aroUqFqdgIuFleY/DM5uwvCuMQqtOA48LdS+WjNY6MVTgm2iNpUybq2LY1aUPJMDZ+y7/8EZk4ZMfOnzJIdvTHgz2KYasrOKG01EuNi27DU9b6Fr9p6i7Nf1JS0I96Lly7zwyTnbd3DmHK1AOP9M1/KKecUkT/mq9w8ix4h4I+1zYa0Ofcq9zHLo0IymTBHFxDJa2zZDn9snyjvOU+ygB2/XJtgMRiX2gV2NZ3TUVKSpLFvQz8J2IEy+LPiOTh9UyNxiS14/sDSTLdlWTi54tU2EzPBkO4q9z/pEz3DvjI9RSWE99f5aAu2UpxidUavghROY6R+RXDA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=monjalon.net smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D528ZYYX4k3NwlQMM4KqZnFWxxOcbqdIawhMy2Ek3Fc=;
 b=KCYJvyTZr+VpgOPzP3LAN9aAMfubDEDUpZqfsKk98EjDRvccWq/UPeEDyD/sffS7hyu2U/FD8nEBOLo03EbdSciOmrSdJEO+g83Tofx6YoWKACqiFZKwco7zVVbo7AwcvGVo1FdI/6Qj1QUigbv0X/3AG9q0rl+VQVQe6wEZn3Y=
Received: from CWLP123CA0031.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:58::19)
 by VI0PR08MB10632.eurprd08.prod.outlook.com (2603:10a6:800:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 20 Jan
 2026 01:56:49 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:401:58:cafe::90) by CWLP123CA0031.outlook.office365.com
 (2603:10a6:401:58::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 01:56:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Tue, 20 Jan 2026 01:56:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuPg0zDo1gkM7Llh2vl0f7L1aq5WZpObJmcVidxKTqW6QKEyDrOGMzX4UmYxQudAB79I2cxZE9PTdqMDMBWUwFlWcDAxrrZ0XcRm0eEL8AKsZ0dvwVo0UrszTWE4Br6QW1IzzlAfm5//7iDaYQh8JisQM6Iy2tOm30YsNX18vEw1he54FKuf7vXMLlzjFmgjLPXlz37uU85p/ZZyV4dAhxqdIkfdNoJhvuEEYTXUsKet/4NPbdeuEcegKbtKxb4c4VhHwKFGAtJaV2pAa66myYDYDqYT0ltsdEyEAwarLMSAOuKH/kIakaKK7Z7ZtTx5RfamI3vq9P6NAjEgLstKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D528ZYYX4k3NwlQMM4KqZnFWxxOcbqdIawhMy2Ek3Fc=;
 b=t+OUaH6Tip8Vdrdl7e+Cw89xn176UOFXS9feD9I/UkxW2bDIpTxdi4SMTHnoPofCR/ZEBjAOb2Wn39eA6foIm3mWt5yCg/8SPdIZRfDPlUdyiDX4KK4s/cBzVCLvMIY6qzE1u+OZ3D+5L48aV8bsSc0CTXPKrouADrhY7DWaxa1qoPgY33dMGcZYijHN+MlQZ+yWKYT+QtiL5XnVnQqWBJHR5zmuSEfv4LAIai17l9pLqInvXtsY7onYCjATkgJc4NITzRbLT2hdllEuExJUPDuVXWdQGOpUQye/rFSHxiUjkATIBBM3E/h6e0iRm7gF0mM71e8A8tZ+NDqk7aSWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D528ZYYX4k3NwlQMM4KqZnFWxxOcbqdIawhMy2Ek3Fc=;
 b=KCYJvyTZr+VpgOPzP3LAN9aAMfubDEDUpZqfsKk98EjDRvccWq/UPeEDyD/sffS7hyu2U/FD8nEBOLo03EbdSciOmrSdJEO+g83Tofx6YoWKACqiFZKwco7zVVbo7AwcvGVo1FdI/6Qj1QUigbv0X/3AG9q0rl+VQVQe6wEZn3Y=
Received: from DU0PR08MB7662.eurprd08.prod.outlook.com (2603:10a6:10:318::10)
 by DB9PR08MB8505.eurprd08.prod.outlook.com (2603:10a6:10:3d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 01:55:43 +0000
Received: from DU0PR08MB7662.eurprd08.prod.outlook.com
 ([fe80::1dcc:82f7:7ae1:eb7d]) by DU0PR08MB7662.eurprd08.prod.outlook.com
 ([fe80::1dcc:82f7:7ae1:eb7d%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 01:55:43 +0000
From: Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org"
 <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>, nd <nd@arm.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: ring queue: update maintainer
Thread-Topic: [PATCH 1/2] MAINTAINERS: ring queue: update maintainer
Thread-Index: AQHchz0/5+zA+eAYV0asbEQzGnU/hrVaUT0A
Date: Tue, 20 Jan 2026 01:55:43 +0000
Message-ID: <D6798C6D-8746-46D4-9729-A54BE4E0E286@arm.com>
References: <20260116230945.1536106-1-wathsala.vithanage@arm.com>
In-Reply-To: <20260116230945.1536106-1-wathsala.vithanage@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.300.41.1.7)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DU0PR08MB7662:EE_|DB9PR08MB8505:EE_|AM2PEPF0001C70F:EE_|VI0PR08MB10632:EE_
X-MS-Office365-Filtering-Correlation-Id: 2125cc7a-f4b4-4562-578e-08de57c72c11
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?NVNDRGlDUjZ2ZTVGTEFzYk9uMlhsNjRGRk1nS0t2MnpNYWxXKzJNOFloRmI4?=
 =?utf-8?B?OEVyOC9NUitaeEZCeVZrVTI0aXZmWWtxY3I4dUZLNlFMeFFZRTBBbGxVeHN2?=
 =?utf-8?B?U0I2ckJSMVZBZXhUMGZsbXVvY1BBaXJMMjNuTkx6NHNIOVJYQjlJbXdiY3Yw?=
 =?utf-8?B?Sk5Sa0d5REhnbFdhSnc2Qjg0UnFWdVpmVWRXenlDU0hHT2pzN3NlalMwRUFY?=
 =?utf-8?B?MHpTUXVCZlVpSzV2UHN1SzQzOStWTC9WMDVLR2hEcXEwdVBTUU9yYk1EVEVZ?=
 =?utf-8?B?Y29CQy9zVFRSUVcvM2dHV2R3Q1pVak85bFVSWmlNLzJjVlBIT01HdktpeUhY?=
 =?utf-8?B?WTJvUmgvaVd3WGlyY2VQdUJpcytnY011YWR2QnFNTVRYVlZLZWdoblJuOCtL?=
 =?utf-8?B?NTRTa0t4UmdxUFFYL3VDZytnUmJ0Wkt0QmdHY240NkgzY1RoVStUbEtianJI?=
 =?utf-8?B?L0REUTFZdlg2bFA0K2NxMmwwQTNtcnNNTHVqdEpoMjBsa2poVnBLd0ZnVDVB?=
 =?utf-8?B?WHFHejQrd25Uck1jSGRQMDQrYjZhUWMzcXhoei9rbkIzMUpJc1pSWHZyMVNB?=
 =?utf-8?B?dkFBaWV5UW1odGUzZmV2YVFHSEdLc25NRDJTOWQ5U3M2SENFTGZDSS9oakU2?=
 =?utf-8?B?akZKVUVSTFVtME0zZnpjaUMxWmZLcGdHUVQrY0lrTS9YUWVwRXZsZXU3UVB1?=
 =?utf-8?B?eHFaT294SnBySDY1S1F4aXRVNkpyeU9UUWovanAyL3RpR1BqVUlyaWpQamVH?=
 =?utf-8?B?Zkd1REZYeUtoMFBQRUxzS0gxRzVRL0ZvTHhYY3A5dFRCcFZtQ2pPeDExYmVN?=
 =?utf-8?B?Z2RQNzExdGxWcElOV1FjL0Y3eEtnSmJnVzE1RUhGOTl6bWlzYUwyR05OSG1Q?=
 =?utf-8?B?RkhZbGMrVkJWakJqSEZic2dUV084YWFpdGI1dVByWUN6QWg3RkdlUmZYTTJZ?=
 =?utf-8?B?Yk80SHJ4eU5vcjR6eHVVUm5DK05KQmJjOC9XRER0MEY0RGErZDl0clRhTmZl?=
 =?utf-8?B?TGxEenVQTjZnSmZjdGFNQXNHcHlBZFBXUXJMWGprcVNFUkpLYzYrVDRZZjNI?=
 =?utf-8?B?WklFQUZrL2F5eVNTSkRRcFBieEhkL1Btb3dEajVqYnYwNnJlL0Y5ZnUrUU1z?=
 =?utf-8?B?TG1qYVdXZGROSS95REZvdlpDQy9FL0ZnbnppSnNiT3htaVZWR3M3czFZcmtM?=
 =?utf-8?B?azFrSWhGMnJ5MUMvMklFWjJESitERVAyT3lYbmM1OUU2aFUzbncyQlFCT0RI?=
 =?utf-8?B?ZEppUCsyRFBOeWU2WXVqR0FiWkdmajNuK2Z0dDlHUjJxZmZEMHdPTlF3T2F4?=
 =?utf-8?B?eE5QYmkyd2xLNEZnSjIrK0tiOHZ5WEtJY1RrRzY0ZkJ6TU9BcVBMZC9wVEpF?=
 =?utf-8?B?c2c4OHZDcTVRUDhhem5zblQxWjFWZHdQVjVza0p3R0FtTWF5VDVxUkF5bFlS?=
 =?utf-8?B?SXpKaVBmVlV5TU0xbXV0SFBlU3gvZG1hYUpnZzczRzJ2cE94MHAyQi83NjA3?=
 =?utf-8?B?SmRZTEhXVlZvS0JLbFh6RjVhT1NaQkFiMWtGK092SWFGWTJ1aHp2aGJ3cjN4?=
 =?utf-8?B?S2ZHSHVhYXFiR3k4bkxUZ211RnJOem1jTDZoQkhmcGFKUzJIdnd2WWI1ekZo?=
 =?utf-8?B?VU1qQ3V3MFVwUjdoeTdIa0dQSjNwOWYxWW1aaUFSNHRwSkk1YlFIN0N4dVZh?=
 =?utf-8?B?dkR3WXAvSHRsVWxGL1MvZE1PTmQ0alk4c0ZpVzJaYlRsT0ZjOWhhVk1nd1Ry?=
 =?utf-8?B?UGcvS29CZ3ZTd2VZdXFwSXpZWmxoM040T2tqRnNLa0JES0FacDdXZXJac0ps?=
 =?utf-8?B?T3kwWlB3czRFcVNoVFRBNDAzOWMzVDF5SVB0VFNwY3RNZTJGYWFVSjIyb3dC?=
 =?utf-8?B?VTVwdXoxRU1rRWFraVJQNmRzK2tHQkNkUnA2MEdFVUYrQnhQc1VXZk01bHRK?=
 =?utf-8?B?TlJSTmNvVWRlZDhCMnVqME1Jckd0cG1jTStqY3F2VER2UlVUYzNkZ2swaGpM?=
 =?utf-8?B?SVBmNzJWWXFsZUNWL293dDdwZmNhU0ZvcHJVajFGNXZyYmFFMHRkTkZhZWZI?=
 =?utf-8?B?TENnNUlKS2JFcFQ1eGFMUHBxdDRVa2FHb2RLMGxZOEVkcUdRMzQvQXFGU2dO?=
 =?utf-8?B?aTE2cStyRXY5M2VnTStaSGFGUHdFQ013dkpwaFRUbm81bmRsZUdVbTAwRHBN?=
 =?utf-8?Q?oaEueHZNKl0FFoxJReVksKM=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU0PR08MB7662.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-ID: <7455FC4A49A6D4459CF572199C59DD8C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8505
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bac29ba6-b020-41ec-a212-08de57c70536
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700013|376014|82310400026|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0lEZUgvazN3bWhScVVFOWxjZkFuelE4ZzFNeFJIc1IyZExyWmdoU3FrZXBU?=
 =?utf-8?B?VlJmUWxCdDA3QXBlT1dHZWxzancxaFBnV0luajhERUdMdzI5YnJaTUdKaWhi?=
 =?utf-8?B?Uzl0blhLeUZkNUFHejM0L3NTUjNYOFg5R1lXTUpnaFBFaDFYeG53aE1ZZ0VO?=
 =?utf-8?B?UUM2Um1Xd0Z4bEVhbU4wS0ZueTUrbjYwV1llb3YxZVpxTjRFN1dZWnlBakVR?=
 =?utf-8?B?NVdjam4rMEZmUkExK3ZRTFFQdU9mMjlhWjIrMHY3RGU1R3g5TzFiU0NSSmsv?=
 =?utf-8?B?WTdrUCt4OHlpbXI5eUdpRkNVdDhKYitNSERnc1EzUmh6T0JCS1RLUDMrblhQ?=
 =?utf-8?B?cll2RDZwNWFjTjFQUktEclpmbmp2MjcwY1BMZTBZSkYvdEFrL1Y3NDZPNUxk?=
 =?utf-8?B?RFRnKzJRWUg5RXhRemc0YmJnWE9qRmwxUnpIaDcwQXIvR09yVWcvaENDeXl6?=
 =?utf-8?B?OTZxNTVWajZOS1lVb3ZHNXhDNHljUTdGTlhyNE44aTJDQ0l5ejJEaTdRcWdR?=
 =?utf-8?B?NVpVaUdsRXNOdTNGN0VuTkFJL20zSENBWmFXbnozbExRdXp5UHoyT3ZLNmFp?=
 =?utf-8?B?dHNGaFF5bzJBMjBBaTJSSDhtOVJ5VzNodHA2NHJWOGNOQmpMSzcrcmdRUzFG?=
 =?utf-8?B?SXRROEJnNmMxSjc0Z0tlVlNhajZxTnl4RE8ycnUzSFF6cUQ5MXBOZG83cXlF?=
 =?utf-8?B?aDNjWjMyZERPM3d6TDVsandOb3RqKzFDWGg2Y244VjA5RFMzUVFUQndzYnQ3?=
 =?utf-8?B?VEJuRVhJejRIY2lkOFMzZzBQVFJ5L0t4bWlUYUlCUit6UkxMenhNZmFFNXFi?=
 =?utf-8?B?MGhMd2JlMDlxLzJhKzF4WXZwTVhJcWZaUGsrdngweDl3T3FvQ1cwSWtjc09h?=
 =?utf-8?B?WGdHSk8ycHY1VFRieko1UXRjMUY1Z095aUlCZEw0aGc3T2VZVnNqWDBGSFZV?=
 =?utf-8?B?NVF3R1FJTlV6UDJrakdLYlZWaHNrOVR2MUtMMkpVbHBrTDBJbUpPMVhObHps?=
 =?utf-8?B?ZXNoSFhEUXJQVThoWk5CRzVBQ0hBc1V6OE4yd2hZVkNPQUliSklFdXE5WW9C?=
 =?utf-8?B?b3p4alpQOWRzYmt6K3A0MldUR0ZiZHBsMXlFVmhCMW1odGZSQmczVTlsWFgv?=
 =?utf-8?B?VXZGUm84cFZjaXdyalA0SjRzSGdUK3JkR05IdS9KZ0U5RWY5NFJlUExoUTEx?=
 =?utf-8?B?bnJpazk2bWZRUjRRUktYUnk2c05XckpkQWVJdTlZVkdtbFFIODVlTmUzNGpI?=
 =?utf-8?B?THVySC9wUVBuVjdvcE5pUVgyejBQTWtPQkllTDhEMGV1ZGhKUWU0RHpUUCt3?=
 =?utf-8?B?QkIrNUI4M0gvUHEvTk5DZ1k3ZXF5bmpKbjdnVGhseUduYk9nZlo5ZDBtbkNz?=
 =?utf-8?B?MXJNY0dZemJQa3V5cjhOT2NmblB4ekhoV3YvS0ZEd3J2eHVOdS9tcHR4K2hJ?=
 =?utf-8?B?UzlBQWQ2NkFOa3RMNjF4RlJXVkxaQm1YQWszUDExblB0U3Q3Y2RLdytNU0li?=
 =?utf-8?B?RjFYeTd1dUM3Q2dqWlVkeEgwa0h3cHV6SkpWVmFncE9oa1FHOE1KZnB1TzE1?=
 =?utf-8?B?UFpCQ1JmYmQ0eHk1V2EzaEhzeHhJbTE4Qlh6MzdxY3Z5SmJVQk1GbFJSUUNO?=
 =?utf-8?B?bytZK1pia0FjTmRJT0R5TjdVRDBrTlJiZjN3SlpsU3EwZDFqSnVKQXd1cTBL?=
 =?utf-8?B?eEh5QzFudEdmeE5hbXRPUm9DazBsL0FMN2RLNDR3MU9WTkdGejQ0NjcrNzNP?=
 =?utf-8?B?OC94bUMxMWtmeWVXZllhTE5rNkV3bnlyRzFtMTJZbHlnVWxyUUY0OE1hbzgz?=
 =?utf-8?B?N0RFK2JFSGNSU0tBOHEwU2wrQnRQVjN5dUlwbjYvN3dqZUNZV1ljRmZjMFRG?=
 =?utf-8?B?Rm1zeUZwTVJsbVF4K2szZVRTL1ZaWlI3a05iT2k4b1I0dGNOK2lUcVdyT1p1?=
 =?utf-8?B?dnFNdVBoU0FCWE5LV2FrT2o3YXlDV09BZHdad3pzZEw0M0FoS3FJTkg5TVJw?=
 =?utf-8?B?cDVyMFdoVDBTaHQ3NFVyeU5pbzhoRzdRNkg4MXJuUDJVQWhWN0RYZHBZbjZ0?=
 =?utf-8?B?YVNVNVZqbEoydzREdHQrQmdEK0ZIcEVuMmdXMkJocWt5bFFvUDhFRElqUEhr?=
 =?utf-8?B?RThITFpIZUFFeE1yemhmYzcvRy9GMUgyS3hjdkdvUVJJTjBPaXhvanVxUGQ0?=
 =?utf-8?B?STdQaFl6dlZnMlYyYUZRaVJoQWdtY204WXJrWnFMT0xNSmkvMmxaSHVkWVBY?=
 =?utf-8?B?cTFTNHY5UW1uQjlQN294YTRJYU9BPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700013)(376014)(82310400026)(35042699022)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 01:56:48.1771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2125cc7a-f4b4-4562-578e-08de57c72c11
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10632
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
b3IgdGhlIFJpbmcgUXVldWUgbW9kdWxlLg0KPiANCj4gSSBoYXZlIGNvbnRyaWJ1dGVkIG11bHRp
cGxlIGJ1ZyBmaXhlcyBjcml0aWNhbCBmb3IgY29ycmVjdG5lc3MNCj4gdW5kZXIgdGhlIEMxMSBt
ZW1vcnkgbW9kZWwgYW5kIGhhdmUgYmVlbiBhY3RpdmVseSByZXZpZXdpbmcgY29kZQ0KPiBmb3Ig
dGhpcyBtb2R1bGUgb3ZlciB0aGUgcGFzdCB5ZWFyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2F0
aHNhbGEgVml0aGFuYWdlIDx3YXRoc2FsYS52aXRoYW5hZ2VAYXJtLmNvbT4NCg0KPiBBY2tlZC1i
eTogSG9ubmFwcGEgTmFnYXJhaGFsbGkgPGhvbm5hcHBhLm5hZ2FyYWhhbGxpQGFybS5jb20+DQoN
Cj4gLS0tDQo+IE1BSU5UQUlORVJTIHwgMiArLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01B
SU5UQUlORVJTDQo+IGluZGV4IGQ3ZDhkYmRiMjUuLjQ1ZmJlYmQzYzggMTAwNjQ0DQo+IC0tLSBh
L01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC00MTIsOCArNDEyLDggQEAg
RjogYXBwL3Rlc3QvdGVzdF9tZW1wb29sKg0KPiBGOiBhcHAvdGVzdC90ZXN0X2Z1bmNfcmVlbnRy
YW5jeS5jDQo+IA0KPiBSaW5nIHF1ZXVlDQo+IC1NOiBIb25uYXBwYSBOYWdhcmFoYWxsaSA8aG9u
bmFwcGEubmFnYXJhaGFsbGlAYXJtLmNvbT4NCj4gTTogS29uc3RhbnRpbiBBbmFueWV2IDxrb25z
dGFudGluLnYuYW5hbnlldkB5YW5kZXgucnU+DQo+ICtNOiBXYXRoc2FsYSBWaXRoYW5hZ2UgPHdh
dGhzYWxhLnZpdGhhbmFnZUBhcm0uY29tPg0KPiBGOiBsaWIvcmluZy8NCj4gRjogZG9jL2d1aWRl
cy9wcm9nX2d1aWRlL3JpbmdfbGliLnJzdA0KPiBGOiBhcHAvdGVzdC90ZXN0X3JpbmcqDQo+IC0t
IA0KPiAyLjQzLjANCj4gDQoNCg==
