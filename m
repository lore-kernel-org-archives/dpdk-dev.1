Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE151C54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 12:27:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D70E4111C;
	Thu, 29 May 2025 14:27:57 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010059.outbound.protection.outlook.com [52.101.84.59])
 by mails.dpdk.org (Postfix) with ESMTP id 9E5014021F
 for <dev@dpdk.org>; Thu, 29 May 2025 14:27:55 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JRBARTSxhlAJcAWzPapbQY5eDYokf9lhy5xfJhjBkj9jH0Hm8tPW/QSE8b2u/SVzrIyKuz++k6EePaji/ksADIY61bclcicmhA7gAvN+1Qz7miDcSVjSjZ1BTtG0PPX1jRslTYERV8MG8DP5Ulln0CoqCrVul+EaVZPS2pH6nmEcGWO3oCdrBMS2FEsvHl127uO6774KG79Ci+fYtWW73PBju0scGc168y1/rVawl9d9Qnj1WV6J64tETWPJwpnh9oMBKT9D9WWdrk70ilmNXMUomi+5PohJZQtC8fQAfj/fyy7vVqITedv6bNwDEUgVdlM9bjeD6AlRlhteFeec9w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwJh9vK45h5xYQBejYGgpuFwvh71XFQjWYc8BwEzya4=;
 b=nXjhjfyH3Y7F0AgUFyInFXBLGKMRZJnbD8tPm2VvadR7SphiN1qWaMZ5oM6rgzHf9cF9ssw6OudEF5sxjJvfesvfNpUr8C2gX/5sjiieMkTb9TH3sPzjl4mGnF/yXqiczS/rxXu9MKT0Mc6BJKHUaHfk22S/8CACDbwx+vZO0PHWB6VKREKkxfxJpBRMACgZlGgsjFq32voO0MDz20Sm0rqwTukQJ02pveJm+XK1JBSh2NUoZzoz85WJLBlVT2tXcCot1ugXZ6xc8pQTlsn21l4/RZwkuM8x3ew5077vRahJoCWme3yP0+gRyXm6ETaWxuIDgKi8a/4TxYILQgD+fQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iol.unh.edu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwJh9vK45h5xYQBejYGgpuFwvh71XFQjWYc8BwEzya4=;
 b=nwtxHqWFSKsFAM3pYM87AtfdvNy8bnyrBbqVDzVTa8YaOPIdfEattW+gOt9zImsNNSVJipX+VcfuKWsadocTwdZ6u1C2w4pFiQR0FueJGFyUHsSbxpYCIRWF+6kRg2N+CqwFtrW4FSNLCdFj8hrafLrQu+Ww2Um4EG15wrx5KAo=
Received: from DU2PR04CA0175.eurprd04.prod.outlook.com (2603:10a6:10:2b0::30)
 by DU0PR08MB9534.eurprd08.prod.outlook.com (2603:10a6:10:44e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 29 May
 2025 12:27:54 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::e) by DU2PR04CA0175.outlook.office365.com
 (2603:10a6:10:2b0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Thu,
 29 May 2025 12:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Thu, 29 May 2025 12:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOnaT0iWURZnTpQBV1eJwlPXklIKLj7HBuGcXsu7goS9ytGI9UR9MbaFrv9bRhIbk95HFCFUqfbrynozWSJU8lwsfN7FuKqTerNLrwC8nXtomDZfQhFhmto2kBkg+/ZShIUemlhzfGxRsW0A83dst1XUl/WBaqfAsyHFksaZSi9NyCyoeMi7LnmwSyYRU+gB9rHWOPlyoxPnMzL+pumW7I5i4wH+tvfNFjs8mnN7So2roCynP7KoYapgkU9In+CMXRJs8vN/DBHxtJJ7DPMbo55aXz+waaHCIBNnJ4xoOR8+yT7v6dHiy/A5AaDVkIotUwTgghFvLAnASo2+QjfFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwJh9vK45h5xYQBejYGgpuFwvh71XFQjWYc8BwEzya4=;
 b=E5ws4RM2Zwknn4wh2SOK9Y88DT1xq1fvqd4/G1Gpq9R+Aq75tstdKWbH0hTjjDa6THB+Jw3jLKob2YKEuQdObExs39ENGwJhyGbRib/EXE7PGojGLd737hvLrDSgy/EKOhg3x5sPVkYkYVjY1UgUubyfyeU2JGcQgUOgnPV5fd2YZAI7mD7y6g6u9h5uf/RENDnqdcbn9XyKDCqO9wqWwGwbrE/tU0zuWqGOsFAwzIdu0NGX9uwBIAOP7QqrNfvo22g8TBa+2U/PU8Ic2PKxHr7n+022dzRZ23JDp3dpdTE/5O4/mf5h3PZko9DJMEFjLuxZiNaaH6q+8fgW0kbkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwJh9vK45h5xYQBejYGgpuFwvh71XFQjWYc8BwEzya4=;
 b=nwtxHqWFSKsFAM3pYM87AtfdvNy8bnyrBbqVDzVTa8YaOPIdfEattW+gOt9zImsNNSVJipX+VcfuKWsadocTwdZ6u1C2w4pFiQR0FueJGFyUHsSbxpYCIRWF+6kRg2N+CqwFtrW4FSNLCdFj8hrafLrQu+Ww2Um4EG15wrx5KAo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com (2603:10a6:10:381::16)
 by DB8PR08MB5467.eurprd08.prod.outlook.com (2603:10a6:10:11b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Thu, 29 May
 2025 12:27:21 +0000
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733]) by DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733%3]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 12:27:21 +0000
Message-ID: <fcd86956-c124-46f6-ad56-9cbe08a06915@arm.com>
Date: Thu, 29 May 2025 13:27:20 +0100
User-Agent: Mozilla Thunderbird
Cc: nd@arm.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, dev@dpdk.org
Subject: Re: [PATCH v1 1/3] dts: rewrite README
To: Patrick Robb <probb@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
References: <20250527153734.368235-1-dmarx@iol.unh.edu>
 <CAJvnSUCjgSje4Tt870WtHk4+qAxDjpoQXWOnJF6y2bVLv32X2A@mail.gmail.com>
Content-Language: en-US
From: Paul Szczepanek <paul.szczepanek@arm.com>
In-Reply-To: <CAJvnSUCjgSje4Tt870WtHk4+qAxDjpoQXWOnJF6y2bVLv32X2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0037.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::9) To DB4PR08MB8151.eurprd08.prod.outlook.com
 (2603:10a6:10:381::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB4PR08MB8151:EE_|DB8PR08MB5467:EE_|DB1PEPF000509E3:EE_|DU0PR08MB9534:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2decb0-5b0d-4653-c9de-08dd9eac3c06
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?YXdqZkxuV0JkeUtOMlhmS2E0M05wb3lPMDUrOWtTK1pIS1dmT2ZnNHIyeVhS?=
 =?utf-8?B?WnltRW13K2tXK3hKaDM4L2J3SmllMHdpTW1HTTN4SGRlTmxsdUFZbXB4b056?=
 =?utf-8?B?cEpGK1hsWlNNNDBCMFlHWmI5RUhWSVY4eDA1bWdFR1JPWkZNdEsyUnlKdlhT?=
 =?utf-8?B?NEJaYVltVmJBeUl0OU5GaWUzTHhaTlhuV1pLaHdwRDlnbkZJRU5MTUE0UThF?=
 =?utf-8?B?LzhpS0R5enRlaGhkc0J1bHpFSWowUUoxWVl5ZXYxQUtpdUxuV1BHbFphUEkr?=
 =?utf-8?B?SkNwVWQzM3F2WFI4OUpMZmxsdXZ4WkZBYmZmM2JaVnVFYnRYTXEvTWViUTAr?=
 =?utf-8?B?eSsrZVhOL09kaWFlU0Q3aUkrVTlzeVlwQysyd1h3QkVyR1k5aHBwdkVxdmxK?=
 =?utf-8?B?YmdtT1NaUm1PTDJyNzJjLzVKMHV5UnJLcm9aL0pDWDY2WjEwZS9wVUtyTUJL?=
 =?utf-8?B?SnVzRkt3OEtub0NBbWc1d3I1V3hQVWE2RVBESFE4SU94enpsbXZyb1pFeFJk?=
 =?utf-8?B?M2VvUlJWYldhVVF3RE1TcnovUHQ1U2pmemp1Q2YzMktURk91aVVRMmRtQWN4?=
 =?utf-8?B?RC96MzR5N3NIRmhmWkxPd1hucTlBVTBvdFVGNG00UVdmS29SNzRSMkUxd2pq?=
 =?utf-8?B?amFnRGlPSVRkL1hpbnUydGxHMXFUVVMzK2VUUWxudlB1aFRJRi9qdTZmcThz?=
 =?utf-8?B?QjgxczRyTk55Uml3TWdBUk9zVEhpR2phMVNXYW9tcUdQR3ZGMXVKdjdxbmFh?=
 =?utf-8?B?dTRISXg1aUM0NDY1Z2IyYVozNThWQzU1R1duaDVTODJiSnVnNEhGQ2Q2MU5X?=
 =?utf-8?B?SWJHekFXVTN6aXBsNi9XQmN2S0Q0WXROaUp1bkR0bFh5K3I0NVQwY3gzblU3?=
 =?utf-8?B?MUc2M0grU3g3cmJWY2tBZkhza1RKRXpiVUU0RktKVXAySGM4RTQ1dk1tYzNn?=
 =?utf-8?B?aVpyeTJBa2Y0dzl2Y2sxbERuTW1wWmFIYXZYMjcrSmJuQ24vZXY4R3JRQTZ6?=
 =?utf-8?B?cjYxWCtlOHNaaGh3aUtzTWYwZTBRRHBMemEyUTBUVllZa01OZUp1QXpQSHRC?=
 =?utf-8?B?YTk2WmhOVFFMb2pwU2wzVnlkZHNWS3lMT1oyb0dxVTRaTVZOamxSOTMxaGZj?=
 =?utf-8?B?MThxYWJkZEE4dnh2T2M4elE5Y0l4K3BTcnIvejJxMWlmZjZhd3JnMVRTY1V1?=
 =?utf-8?B?c3ZUdnlWOEorSVZWSlRVa1VWM0VoNmdIT2hvZnRDeElpT3hLTFdjTFo3UXIv?=
 =?utf-8?B?dGk3Y3l4NHY1THJjTEorZHJkNzhXSTdoQ0Nja1RqSmdWVURnQnFXVDBnYmoz?=
 =?utf-8?B?SXluSTJUbDk0TGJWaS80eWNZQ0NVNEhBaFQvWTJWTUZ1d2gxNlFoZG9zc2M2?=
 =?utf-8?B?N3F4MFFEbUJLNkNVMU50b3dTQXFCaE9FTUJqMVVSK2dQSUQrZnBTdTlYVlgw?=
 =?utf-8?B?VGpRczhvZVRMdlRvNmgwVWxMQnprM3FrOXJ1eklxbExCUUpMOXhSY00vcEEw?=
 =?utf-8?B?STRMSFh1WEJyUFpudDZhMEQwR1VwVlhkMUZiNjhRcm55a05EeE9tMUZ3Slc5?=
 =?utf-8?B?YXlwa1QyZnlNTmNtR3h1SUlkUVBtQ2RGTFJ3SWcwOTBLaWdEcFRGY2V4dFRD?=
 =?utf-8?B?MXB2d1NnZDdBTjB5Rkt1aTJ3d0ozUnNmRXNTUTZPQ2hNNTdJNmtsK21BK29u?=
 =?utf-8?B?WnlyU2loM2dzNCtPTWF6dzNZdmFvS2xaMW8rV2g2ZnMyQ2x3TkR0ZVRZUnhx?=
 =?utf-8?B?K3hTWWpvUVFWT2hTdmxkK3F1Tzh6NjJ1eUdxNnp2YXRBajNoVDFjYzN6TUNH?=
 =?utf-8?B?U3dZcXluMlRVTmNqMzFQU29IRVh0RGtodHJJQmdLWUR5c1QxL2ZGbUE4OEtY?=
 =?utf-8?Q?PZFaXDZxwFAME?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB4PR08MB8151.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5467
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 53563584-60e1-4f4b-8140-08dd9eac28b2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|1800799024|35042699022|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDBGTXVZcVdNb1laMGdrTytFbGRaSlJyZk0zSk1ieGdOUE5HdWR4Um5NaWh4?=
 =?utf-8?B?U1d6M3JhTi9zMC9jTEFsNkJvc1FKUGZIMjFiQ0dUKzRwdTBjZUM5M0pFd3kx?=
 =?utf-8?B?aVR4VDhrSU1ZaU1EN3R2c2w5UW9xQW5ZcHpvZFBNNXR3c0Y1OGUwaXZKV3Vv?=
 =?utf-8?B?NFhUWGErdURERm43blNGRHc0c2xMbWd0UFJ2YWVpaWpFa29HL3JxSVZEcVpK?=
 =?utf-8?B?Z25SdVk2ZDNQeVh1RmNBdnNyZlVFS0dORjBXMFZRS01yOUZ1bnM3MXhKYUlp?=
 =?utf-8?B?byswRlV5SjJ0TnVaRmk1YXNNZ0dEYnVNcCs4L0I4TE9kK1dPcUhUc3c0RThz?=
 =?utf-8?B?c1hRZFdwTVFHMnZqOGtPc3p5dzYra0FoazB3VkJVR1BsOFY5N3JFNjFpUmFO?=
 =?utf-8?B?RWtKVWwrbkpQcFhoOEVKa21IVEcvb3FiQm9YSlRUQVdEZlp3L0hkeWwrM2JJ?=
 =?utf-8?B?NFJvdUFaNUluUzh1RDlhMVVtQW5xejRSWVhUNnV1TTVFUkpRYkdpWE5wR0ZN?=
 =?utf-8?B?SVZ1NmR5MXFmZGxsbzJHZzRnTTRqb25CL3I1NHo5YnI0ZlNCdENoRFRPSndm?=
 =?utf-8?B?d1lmbm5vWjd1N3B1MDY1VkVmQ3RYZE9UTWluekVjcUdBbkdMeFVkdmxtY0JF?=
 =?utf-8?B?MElhb25ReFdHelg5cEk4T2dIeUprVENSMDFPaG16akxWdXd5SHZMOEJ2V25W?=
 =?utf-8?B?RHVpbTFEZ0ZRY3VmcFpiVTJxdm43NmlzUUZ0bzdXRWtOTjMxTTRQdVpwajRM?=
 =?utf-8?B?L1R2LzZzRHdXeUkyN2pVdEhVYWtQeXJPbTdzdkZ6QVlia3V6WURkVVJpdk93?=
 =?utf-8?B?ZVNaN1pTNzFjUFhyWExqUjZYTmFNSnBybkhJYnVCaWtaMnYzbGtRd2owaHhR?=
 =?utf-8?B?K2kwUGFoaW5GVERQd21tT3Y4RHBvcjhVSzllOXFpVGZndVhuUWRLZXVIbnkx?=
 =?utf-8?B?VXg0SHgyNEZ0Q1VBd2RYY09HcWszMytIZGh0S1NsUkpSTnBBT29BeFd6NFZu?=
 =?utf-8?B?OC9KZVI4YW1XdjRic2dWR1lpWDVVZWx1ZVBzaVhFbVI5cFQwWFU4ZlBQQ3Rr?=
 =?utf-8?B?UEYwSHRFc09zUTdlTkpsMUsxdEJSZFJKenpUa1p3TnRvWDlwNzFCTS9JT0NK?=
 =?utf-8?B?TUx3U2FoV29yRTRleDNMOVEydy94Y3Iwdk5JVDl2c2FST3BoRFAxN0xKNHpY?=
 =?utf-8?B?dS82VytKaUVBYXcySUVHWk5WdXMyL0tMN0t5OWhRN2Y3V3ZORDVnTVZEeTBm?=
 =?utf-8?B?ZGk1b0crbk1qUWJuUTVlZDBrbmJZcHZ1NDF6UGwrTnNEVEpQVkgzOUkyYVhZ?=
 =?utf-8?B?MzROb0FjQ0ZBalo4ZkI3MHJWVEVKZnZKeE1Bbjd6bkFhVHBjcXNEYjdMSE5x?=
 =?utf-8?B?OWJBODdtNUVDbytjOW5iRmRaZFNSSkxsMmI0OGV2cjVHbGZ3R0o4M25lQ1BT?=
 =?utf-8?B?dEc1enU2dmhqMC9QelBzRllVeE5tM3c4STcxMllycDg2aDRhbUVLL1h2QzVs?=
 =?utf-8?B?bys3T21DM3lUT0hLK3JvZXNFSVg5Q25HY0swd29YNWs3TEZqVDJKZjlqOGZN?=
 =?utf-8?B?dWczeXA1clYyamRJdjBQd3RCZXhLNGFVVzV5NG9FOENCSGtYOElmWnlqMGNF?=
 =?utf-8?B?WVNBRmMzTTBWdEJTRHZ3MlQxZElENzRFQkNtdllON0VZOEx0Y0NFV3kzWC82?=
 =?utf-8?B?M0RVWks1ZmFHN0RHbVhCd2I1S1YycGJlbldPUTVpNFdKQTdhcERGaFV6VklK?=
 =?utf-8?B?di9QMmNlRlNOckNieEY2SGx0VlNLamJDYkRLVkJWNXdXMDFVQzlrc3ExNGpR?=
 =?utf-8?B?YzhQb05kWGN6QUpyTHlBVVkrWWdZblEvV0tsTFNhMGREMkdQa01kckErWGp2?=
 =?utf-8?B?RFUzbVh2UDV5VVJkbUd5bGUzT2hEN3pyN2cza1dPYkNxSTBwK0xkdGk0UmtK?=
 =?utf-8?B?MG5nSFptbEl3S0M0dkhFRmN2UmRFTUptSWJ3SlNaT0wrRUlwbDh3UlE0SUtq?=
 =?utf-8?B?R2l2M0hlU2JnPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(1800799024)(35042699022)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:27:53.4037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2decb0-5b0d-4653-c9de-08dd9eac3c06
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9534
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

Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>

On 28/05/2025 21:40, Patrick Robb wrote:
> 
> 
> On Tue, May 27, 2025 at 11:37 AM Dean Marx <dmarx@iol.unh.edu
> <mailto:dmarx@iol.unh.edu>> wrote:
> 
>     Remove unnecessary information from README.md, and add new sections
>     to clarify
>     the purpose/use of DTS along with clear setup instructions.
> 
>     Signed-off-by: Dean Marx <dmarx@iol.unh.edu <mailto:dmarx@iol.unh.edu>>
>     ---
>      dts/README.md | 104 +++++++++++++++++++-------------------------------
>      1 file changed, 39 insertions(+), 65 deletions(-)
> 
>     diff --git a/dts/README.md b/dts/README.md
>     index 2b3a7f89c5..879cf65abc 100644
>     --- a/dts/README.md
>     +++ b/dts/README.md
>     @@ -1,81 +1,55 @@
>     -# DTS Environment
>     +# Description
> 
>     -The execution and development environments for DTS are the same,
>     -a [Docker](https://docs.docker.com/ <https://docs.docker.com/>)
>     container defined by our [Dockerfile](./Dockerfile).
>     -Using a container for the development environment helps with a few
>     things.
>     +DTS is a testing framework and set of testsuites for end to end
>     testing of DPDK and DPDK
>     +enabled hardware. Unlike the DPDK unit test application, DTS is
>     intended to be used to
> 
> 
> Maybe change to "unlike DPDK's dpdk-test application, which is used for
> running unit tests, DTS is intended to be used to evaluate real DPDK
> workloads run over supported hardware."
>  
> 
> 
>     +evaluate real DPDK workloads run over supported hardware. For
>     instance, DTS will control
>     +a traffic generator node which will send packets to a system under
>     test node which is
>     +running a DPDK application, and evaluate those results.
> 
> 
> Change to "evaluate the resulting DPDK application behavior."
>  
> 
>     -1. It helps enforce the boundary between the DTS environment and
>     the TG/SUT,
>     -   something which caused issues in the past.
>     -2. It makes creating containers to run DTS inside automated tooling
>     much easier, since
>     -   they can be based off of a known-working environment that will
>     be updated as DTS is.
>     -3. It abstracts DTS from the server it is running on. This means
>     that the bare-metal OS
>     -   can be whatever corporate policy or your personal preferences
>     dictate,
>     -   and DTS does not have to try to support all distros that are
>     supported by DPDK CI.
>     -4. It makes automated testing for DTS easier,
>     -   since new dependencies can be sent in with the patches.
>     -5. It fixes the issue of undocumented dependencies,
>     -   where some test suites require Python libraries that are not
>     installed.
>     -6. Allows everyone to use the same Python version easily,
>     -   even if they are using a distribution or Windows with out-of-
>     date packages.
>     -7. Allows you to run the tester on Windows while developing via
>     Docker for Windows.
>     +# Supported Test Node Topologies
> 
>     -## Tips for setting up a development environment
>     +DTS is a python application which will control a traffic generator
>     node (TG) and system
>     +under test node (SUT). The nodes represent a DPDK device (usually a
>     NIC) located on a
>     +host. The devices/NICs can be located on two separate servers, or
>     on the same server. If you use
>     +the same server for both NICs, install them on separate NUMA
>     domains if possible (this is ideal
>     +for performance testing.)
> 
>     -### Getting a docker shell
>     +1. 2 link: Represents a topology in which the TG node and SUT node
>     both have two network interfaces
> 
> 
> 2 links topology
>  
> 
>     +which form the TG <-> SUT connection. An example of this would be a
>     dual interface NIC which is the
>     +TG node connected to a dual interface NIC which is the SUT node.
>     Interface 0 on TG <-> interface 0
>     +on SUT, interface 1 on TG <-> interface 1 on SUT.
>     +2. 1 link: Works, but may result in skips for testsuites which are
>     explicitly decorated with a
> 
> 
> 1 links topology
>  
> 
>     +2 link requirement. Represents a topology in which the TG node and
>     SUT node are both located on one
>     +network interface. An example of this would be a dual interface NIC
>     with a connection between
>     +its own ports.
> 
> 
> I wonder whether it makes sense to provide an ascii drawing of the
> various topologies?
> 
> I google an online ascii art tool and got these 2 showing the 2 links
> topology for 2 servers and 1 server: 
> 
> +------------------------------+                 +------------------------------+                      
> |                              |                 |                              |                      
> |                              | --------------- |                              |                      
> |                              |                 |                              |                      
> |  Tester (Traffic Generator)  |                 |     System Under Test        |                      
> |                              |                 |                              |                      
> |                              | --------------- |                              |                      
> |                              |                 |                              |                      
> +------------------------------+                 +------------------------------+                      
>                                                                                                        
>                                                                                                        
>                                                                                                        
>                                                                                                        
>                                                                                                        
>                        -----------------------------------                                             
>                       |                                   |                                            
>                       |     -------------------------     |                                            
>                       |    |                        |     |                                            
>                       |    |                        |     |                                            
>                       |    |                        |     |                                            
>                       |    |                        |     |                                            
>                       |    |                        |     |                                            
>                       |    |                        |     |                                            
>                       |    |                        |     |                                            
>                       |    |                        |     |                                            
>                 +--------------------------------------------------+                                   
>                 |                                                  |                                   
>                 |                                                  |                                   
>                 |                                                  |                                   
>                 |                                                  |                                   
>                 |          Combined Tester & SUT system            |                                   
>                 |                                                  |                                   
>                 |                                                  |                                  -
>                 |                                                  |                                   
>                 |                                                  |                                   
>                 +--------------------------------------------------+  
> 
> 
> 
> If you wanted to do this you might have to use triple tilde to put it in
> a code block so it renders with a monospaced font for readers.
> 
> 
> 
>     -These commands will give you a bash shell inside the container
>     -with all the Python dependencies installed.
>     -This will place you inside a Python virtual environment.
>     -DTS is mounted via a volume, which is essentially a symlink from
>     the host to the container.
>     -This enables you to edit and run inside the container
>     -and then delete the container when you are done, keeping your work.
>     -It is also strongly recommended that you mount your SSH keys into
>     the container
>     -to allow you to connect to hosts without specifying a password.
>     +# Simple linux setup
> 
> 
> capitalize linux and setup
>  
> 
> 
>     -#### Start docker container with SSH keys
>     +1. On your TG and SUT nodes, add a dedicated user. In this example
>     I will name the user "dts."
>     +2. Grant passwordless sudo to the dts user, like so:
>     +    2a: enter 'visudo' in your terminal
>     +    2b: In the visudo text editor, add:
>     +        dts   ALL=(ALL:ALL) NOPASSWD:ALL
>     +3. DTS uses ssh key auth to control the nodes. Copy your ssh keys
>     to the TG and SUT:
>     +    ssh-copy-id dts@{your host}.
> 
>     -```shell
>     -docker build --target dev -t dpdk-dts .
>     -docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/root/.ssh:ro -
>     it dpdk-dts bash
>     -$ poetry install
>     -$ poetry shell
>     -```
>     +For additional detail, please refer to [dts.rst](doc/guides/tools/
>     dts.rst)
>     +
>     +# DTS Configuration
> 
>     -#### Start docker container without SSH keys
>     +DTS requires two yaml files to be filled out with information about
>     your environment,
>     +test_run.yaml and nodes.yaml, which follow the format illustrated
>     in the example files.
> 
>      ```shell
>      docker build --target dev -t dpdk-dts .
>     -docker run -v $(pwd)/..:/dpdk -it dpdk-dts bash
>     +docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/root/.ssh:ro -
>     it dpdk-dts bash
> 
> 
> Instead of dtsuser maybe we can more explicitly say {insert your dts ssh
> user}/ or similar.
>  
> 
>      $ poetry install
>     -$ poetry shell
>     +$ poetry run ./main.py
>      ```
> 
> 
> This information looks good, but I think it needs to be tied together
> more cohesively. I would make a step 4 like: 
> 
> 4. Create and fill out a test_run.yaml and nodes.yaml file within your
> dts directory, based on the structure from the example config files.
> 
> And a step 5 like:
> 
> 5. Run the bash terminal commands below in order to run the DTS
> container and start the DTS execution.
>  
> ```shell
> docker build --target dev -t dpdk-dts .
> docker run -v $(pwd)/..:/dpdk -v /home/{insert your dts ssh user}/.ssh:/
> root/.ssh:ro -it dpdk-dts bash
> $ poetry install
> $ poetry run ./main.py
> ```
> 
> 
> I also think we may have to call out some of the project dependencies
> (this is outside of the python dependencies that poetry handles for the
> DTS execution). So that would include Docker on the execution host,
> Scapy on the TG host.
> 
> 
>     -### Vim/Emacs
>     -
>     -Any editor in the Ubuntu repos should be easy to use,
>     -with Vim and Emacs already installed.
>     -You can add your normal config files as a volume,
>     -enabling you to use your preferred settings.
>     -
>     -```shell
>     -docker run -v ${HOME}/.vimrc:/root/.vimrc -v $(pwd)/..:/dpdk -it
>     dpdk-dts bash
>     -```
> 
> 
> I agree we can remove this.
>  
> 
>     -
>     -### Visual Studio Code
>     -
>     -VSCode has first-class support for developing with containers.
>     -You may need to run the non-Docker setup commands in the integrated
>     terminal.
>     -DTS contains a .devcontainer config,
>     -so if you open the folder in VSCode it should prompt you to use the
>     dev container
>     -assuming you have the plugin installed.
>     -Please refer to
>     -[VS Development Containers Docs](https://code.visualstudio.com/
>     docs/remote/containers <https://code.visualstudio.com/docs/remote/
>     containers>)
>     -to set it all up.
>     -Additionally, there is a line in `.devcontainer/devcontainer.json`
>     that, when included,
>     -will mount the SSH keys of the user currently running VSCode into
>     the container for you.
>     -The `source` on this line can be altered to mount any SSH keys
>     -on the local machine into the container at the correct location.
>     +These commands will give you a bash shell inside a docker container
>     +with all DTS Python dependencies installed.
> 
> 
> Well... I know I was saying the devcontainers aren't so useful, but upon
> reflection, it's kind of nice to not have to manage the 2nd terminal for
> driving the container, and of course it means python intellisense will
> work without having to poetry install on your base system. I would leave
> this part in, but stick a sentence in at the start saying  "usage of
> vscode devcontainers is NOT required for developing on DTS and running
> DTS, but provide some small quality of life improvements for the
> developer. If you want to develop from a devcontainer, see the
> instructions here" or somethign like that.
>  
> 
>     -### Other
>     +## Other
> 
>     -Searching for '$IDE dev containers' will probably lead you in the
>     right direction.
>     +Searching for '$IDE dev containers' will probably lead you in the
>     right direction.
>     \ No newline at end of file
>     -- 
>     2.49.0
> 
> 
> Reviewed-by: Patrick Robb <probb@iol.unh.edu <mailto:probb@iol.unh.edu>> 

