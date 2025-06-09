Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E2EC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 09:13:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F1B240661;
	Mon,  9 Jun 2025 11:13:27 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
 by mails.dpdk.org (Postfix) with ESMTP id DA70440658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 11:13:26 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=FF8WIzESkQuIXEO671I9NsvuGMbJjDqtp0vKDvf8vgvX8PJMs0AS2PuQaZih08VPwqhEjYzYxvHhLH5kw271cgBB1VGTCJC4w/lipmRXZneIyhy3Xnn5n4t+xdE9PME0rBuRrYXvaVtqVIJ5J7DouFTg/C0LT73g7XV9bAOR1XSkWcRn21sH/vMtonzVPu42oNpc30sWuMa/HluCAIIdBE1CjQjkN2QvE5CaI+dZZ0xXfUA4wQ2V5Xy6bUUisKXN8jsF+4zXgKFOiTlDdNbSnDwAWiTmUcI4YnUK9xarBgvsUQS4BKSIjYgimuQdz+nQ+oW9gy/H8DBsN/GWKuYwqQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU3HXFDkKIYDK7sS2RNDPXG7Yf9djks6L07HL7rdVwI=;
 b=vM6fva4UaH2nAYhL2N+z2Ey7zB7W3xgk2JzQC2MrddpRdZZJ2xJ1izfyUrLrZ8uH0INwz10rviifdu8DSypY2ue+kaNNAaXaZp5K2pQC/tUt3ytaUEDvuYkennyrZiE8KCXRVUUQZ5eE94ZDZTsbOYOUlEI5M8Cf52/Sj+vSKBLuVZTcB7qlwYifzgKuvGBrt1nsiS0t4hGuNfMrNh25FScxgCEIagC72q5Bm2BDMxoSM5yv5wONH3E7h59CH360dzYyxRlDREhqhiPr71f3mqqQs2TDxRpjbo32pCCMxTErK8Z2T9JCZCbgeZ2HxhjLaP3bSguVUdHj00Fbvkwt7Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=suse.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU3HXFDkKIYDK7sS2RNDPXG7Yf9djks6L07HL7rdVwI=;
 b=DhAguuTJcwlBGDs56dQbG/RYKgmA5cBmAtiseUTpoOx7bDVgI1yIG5iBphw03jAYEaxpkBNwWj0NMUNdw0DlNdKIZkpjyLyg2cqBbSp/O1U8eeY7DUrbUri6Uq4OxAqvCVdGlxICdSFKl9s6KHMzzsPcblOMayppj6MNbzX4PH8=
Received: from AM0PR04CA0106.eurprd04.prod.outlook.com (2603:10a6:208:be::47)
 by AS4PR08MB7432.eurprd08.prod.outlook.com (2603:10a6:20b:4e4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 09:13:25 +0000
Received: from AM3PEPF0000A799.eurprd04.prod.outlook.com
 (2603:10a6:208:be:cafe::d3) by AM0PR04CA0106.outlook.office365.com
 (2603:10a6:208:be::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 09:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A799.mail.protection.outlook.com (10.167.16.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Mon, 9 Jun 2025 09:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uo5Nk8HN2sjRXs/D8RiT7Gz8UPXgtbaAcRa9Xr0r2kj0KTcSyc5aaGY/qHsHXxOhDy+nroJys6gseIsePcfFiTB9pYFd2+j2rnq6/aY+KBzeXS0MDIvHwYnD0nI8cxUvTQ5nWFKcA6gD/lZuXcBwzagHj72VgcYSflYcE0kDM4p/JuBlv6+hc5/lRTp5si4mZquy6DmArtbKDb5tHThwJfLzN6an1GlPidN3ggg6Wo9+VWyL8HbjQby9pBfcmuPH4ycyB0DNj7ofhjMX1ZKKFXKqLfiyN0GGgfOJnO/KZDASN5LUnTuzgyjlZVGBYydyO1GKz/kXnBIrsmh9K6XREg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU3HXFDkKIYDK7sS2RNDPXG7Yf9djks6L07HL7rdVwI=;
 b=mIBmQWy5ejQQwSZvQDakOW/mfqwaWxlXjGRJnw1eLiZgzajDxuQTkqygZQpGNIg/JhY99MhDP8Qj/wBI2MjcZ07TvOD0A0NoE0l9t/WQSGslOYq0TbPOdqKSxn+jnneBc8/qX+mQX0VCesUozrV6eu0t/7+X4NLeT+5PBt40TvMag43Bxay9rXvJCPQSvSYbDvDiCh5xfP8Mtk9emybFwLiynyvqltyBLYboGDZlS74pI4AhpfFIThz7rqLYC4pXXCn4nDwChQmuiu+YofcO3iFENIlTbP2vFZTNUwyf5mFGojjMNZaDm4RPy7W39+slNviMx+AZuwtIckIoi1ABgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU3HXFDkKIYDK7sS2RNDPXG7Yf9djks6L07HL7rdVwI=;
 b=DhAguuTJcwlBGDs56dQbG/RYKgmA5cBmAtiseUTpoOx7bDVgI1yIG5iBphw03jAYEaxpkBNwWj0NMUNdw0DlNdKIZkpjyLyg2cqBbSp/O1U8eeY7DUrbUri6Uq4OxAqvCVdGlxICdSFKl9s6KHMzzsPcblOMayppj6MNbzX4PH8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com (2603:10a6:10:381::16)
 by AS1PR08MB7513.eurprd08.prod.outlook.com (2603:10a6:20b:480::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Mon, 9 Jun
 2025 09:12:48 +0000
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733]) by DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733%6]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 09:12:48 +0000
Message-ID: <804d43cf-ff73-421b-a3a8-4b3dd3c3add5@arm.com>
Date: Mon, 9 Jun 2025 10:12:47 +0100
User-Agent: Mozilla Thunderbird
Cc: nd@arm.com, dev@dpdk.org
Subject: Re: [PATCH 1/1] dts: fix deterministic doc
To: Clemens Famulla-Conrad <cfamullaconrad@suse.com>
References: <20250606093502.31767-1-cfamullaconrad@suse.com>
Content-Language: en-US
From: Paul Szczepanek <paul.szczepanek@arm.com>
In-Reply-To: <20250606093502.31767-1-cfamullaconrad@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::11) To DB4PR08MB8151.eurprd08.prod.outlook.com
 (2603:10a6:10:381::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB4PR08MB8151:EE_|AS1PR08MB7513:EE_|AM3PEPF0000A799:EE_|AS4PR08MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 936ea97c-3fb8-4d97-8da0-08dda735e2bd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?OGtUeDBiMEh2VnRqU3QzeC9VMTVzU1I1SFB1YU8ySVBHTzJwWXEyeEpWQnZ3?=
 =?utf-8?B?LzhWenpRUzE4dzRpd01sK0JwZEdiMjgxUVBPbkNyenhSMVgwWnBtbW15ZkE5?=
 =?utf-8?B?UVVIK2JDWXBhdkpjRUgyRjhIYjl2OXl3M0lYTmV5U0xVS1kwdUdOZklDN3Ru?=
 =?utf-8?B?QVQrMisyZkxVeVJQdHIzSTFFQ2RXWFNsMlJxOE9tamFLbVV6RnNGQmo4aHdS?=
 =?utf-8?B?UElETFBEYkpNWERvbnJtUThVRVZXTTQ0ZTVqVEpkcVBzNjAvT3Z2b3ZkdENI?=
 =?utf-8?B?OWdGMnNSaUllNm9PU1N4YS8zZ085UzMxR25mZ0J1UVdLd1UyODBTVEN2bDVr?=
 =?utf-8?B?bnZFRjJ6VCt5NW04NDJJSVdkaHM1NERhUERjMUtwaW1QNndVVFpaMDB0S3dX?=
 =?utf-8?B?MG9SNVQ5TnJtUzUzQVFqRzE3d3htZk1HV254QktsZk1GczJ3RFJ6Q2ZEcDdy?=
 =?utf-8?B?citGU3pjMitoNlgyaGxXQW9FYjBLaUc3aEkzWDRSclpMU0FEMHg4Sm1vK1ha?=
 =?utf-8?B?UEM2ZGhCNW5ZVzN3TmYvNXNGK2RBTDZiMXJ4N05DZ1ZCVmFMMTlRZFFBcnFS?=
 =?utf-8?B?VWZZbUNETTI1SC8xN1psSnJCR1Vya21RZGdpYnA4TE5hRmpQa240Q0JZM0g2?=
 =?utf-8?B?U3dIaGpXMXdpT0FRT1ljdW5udVQwd3N3eDFNNmRjSUJ2bXdzWjZHQWV3b1hC?=
 =?utf-8?B?UWpKQXJlcXkzcEV3YS9GZXVFZERlRSt3M0dkdnhoVVBSd0xuVW9vcXFHYkE4?=
 =?utf-8?B?c1BXZ3phYzMyY1RkdncrYUNJemFlNlpiRTZZL0h2OC80cXhGY1hQS3ZqR1Vv?=
 =?utf-8?B?eEhtVXhOa0t6UWY5MDFGajBYa0s2VHI0ZHJMaWdFa0FlQXhxSHBjYy9DL0ox?=
 =?utf-8?B?SENBWmlYU3hIMFBKYnQraTZ5NlJoNE1KTkZqTnJqbTNNOXhkLzlHbXQ5ZUtZ?=
 =?utf-8?B?eno2Ykp2ZlE4c0ZNakQyNWQ5TkRFVjkwT3NGWEZDZzQzUnMvTzVJeUJjdFlk?=
 =?utf-8?B?LzBaZ3VsTXlXWWNNZG9NTlo5Rk9jQ3A2c3pOMGdOVjNmYmR3c3pzYmVVOTNp?=
 =?utf-8?B?ZFpQZVVuSER0UCs2MHViTVhEQWRPT1oreHBPVFZQaWdXcXdKbGphN1ZkZjF3?=
 =?utf-8?B?SHVlUUhtSXpHaHZzRGhwQm9PMmtVaDI2MnFGT05TTFMvbVJhRFlJaStVY0xG?=
 =?utf-8?B?eFVnWlc2ZjdnZEFlblc5N0lXN2xwSmNoQW1aVSt4UENNVlNJUGpWVnkzNXJC?=
 =?utf-8?B?QmVYT1J5WGl3bnVQN2RlZFgvdkVzUjhFZENFL3luTVBFdGc3Y3YrV2RHMzRU?=
 =?utf-8?B?NDFvTzNLTU9RL0JLU3JPSkZjbjdwRWpzWDNMZWJqbDlTNXIzZHhoTVk5aHZE?=
 =?utf-8?B?dXNCeUEwVWFhY0k0dUd1aFZacTNyYUFPd0tJSUpYVldaOGRncEVUWWwyc3c2?=
 =?utf-8?B?dzRwVTlVM3ZGelNOZzV2d20vTk0vQTFQYUJlN0hIZVVaeDdoN21PUVFCdERp?=
 =?utf-8?B?UnRxdGlrRm95bTh5WlA1UTRzUWR6VzVVVkRtdkVpUTFrNWVodE51NWdXNXl6?=
 =?utf-8?B?aTZqM0M5TWpCNWxqdStRczJBZEN5ZlZZNmJ3RkU5bTBiVUc3N1lXUVZOK1VY?=
 =?utf-8?B?VjlEZmsyRlhzd29kUkVtM0ZFZEp3VkNoMUJOd0RrZUl0WGxtT0FpUWRkRXM5?=
 =?utf-8?B?VnRWV0psNWd1L2pzMUhSYkJ5ekxpMCt2ei9qZVBqQVBYTXYvS2pCMUwzdkpF?=
 =?utf-8?B?MmNrYmdCdDc0UkYyL043eGU1MXhJV214NFhkaEJwZ2lVbDZPb1hKQmEwbGJs?=
 =?utf-8?B?QjVDempOcjdYUlhQNVpFTlJIeG1ENDBjMWhSUnd0SHZMdDJlVHRtcDNTRi9E?=
 =?utf-8?B?cHpuYm1IVUZ3QVNpa1JNVmdhSWI2aDhzdzBUOEdDN1hMR0xkNmwyYWVmSDVw?=
 =?utf-8?Q?g2S357FJjNk=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB4PR08MB8151.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7513
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f247e76d-3a61-4565-aab7-08dda735cd97
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|14060799003|376014|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmdsaUtWQzVzaWQ2UnNueXN4bVN5K1JJRE5OMTJIUnQ2T2ljaVJqMG13ci9D?=
 =?utf-8?B?cHZHYldQclU4VGd6YlliSDVUSzRNUk5xQi9pZHhwQ2ZIdnYxLzNncURsVWp4?=
 =?utf-8?B?Z0JEaEFjQW93SnRJRGdKbWs1SmJSSjBiWldNZ1k4YTMySUlGZ1VWWk5KTlE2?=
 =?utf-8?B?NG91S1hXSHc0alJSdlB3V05HTWhrRkFqTmtnRFh4YjkrT25mL1JRWTl6Wmg5?=
 =?utf-8?B?L2MxcERPV3JKaUlEdEx0a1pZWDUzb3NWUGVVUk5KTXJqbjMvOXFsWDlXSlI3?=
 =?utf-8?B?NnpRb1NZNmJQVTRPdE95bzI3TTFQVFEzajJqdyt6dzFzdkdIVHAybXdybG8y?=
 =?utf-8?B?SnAvNXVFdTNHZXN6dDJ1VWNWdDk2K0dtZlhqRUk3alkzczdlOEtyMDNFUmhp?=
 =?utf-8?B?RmVxNkhBL3JYMXZ4dVZUdzh4T1ZzM0dydWNTSEVxcThTcHF2Z2VTcXZxNTNL?=
 =?utf-8?B?ZlV6czRad3VmcXQyVGpIQmdnNUl6VjZYczdaZ1BCZTQwL0wyazVnak11VFVq?=
 =?utf-8?B?eUtXbmt5L1NBT3h1NHhzY0prRmpPOWNrK1EwUHBtZXBHdk5LTFFRUE1qQklI?=
 =?utf-8?B?WVpDeVQrS090L09KSlowYTI1a1FoOUZPLzU1RnlqUFFjRWZ1Q0Zjb0V5dkd2?=
 =?utf-8?B?cTA2R2VMcHpuOEdpSFVSQzZSOFhYbm1NYzZEb3BuWC9jTldkaEV3NWdRZG9z?=
 =?utf-8?B?aWdXbnc4K3dOR05HMnIzKy9NYzk5aGgwcStTV0VmQUhKOTluQ1J6R0dnTUpR?=
 =?utf-8?B?OWR1cWs2VVVRQzJacXpDV0JocHhMaFlDZEtMVElYcEwxdEdJeUNmWGR5Rms5?=
 =?utf-8?B?SE9nYzBBbGN4aHh3cFo3eHhFcy9vT2swQ3cra3JTZXR0emlKMFF5Q2JMV1lo?=
 =?utf-8?B?Mmh3c0ttQ3Z0S3JZV21BdmZSdkl4Zml1Tkw0NGY2ZmpoQmpUL0hzOTNwckUw?=
 =?utf-8?B?UlpzbElvUnN0Si96cWtEMmlTRkNrY0NQV0FHRVVCc1l4RkRKYmlUc05tajVM?=
 =?utf-8?B?bTFLZXJpL01UMG9jRWxKUUNFSWdCTjhCTHVmak1JUlhhUHNLYTk5R2tHMUtI?=
 =?utf-8?B?ejFJODFZOXYzSzdFT2dmWWt3a3p6NWI5Z252S0dsYnVYbUhSblBEQjltNW9t?=
 =?utf-8?B?b3pNZi9ocUJBc2RQdllYQnBFWUJjdURVTVE3c0RSOU8zT3hWa1prWnczQnBS?=
 =?utf-8?B?RWNIUVFSOGtDZVFwZEwyTHFoc3pPcEQvNTdlNzZqZmV1RzNQM1NaMll5WUUx?=
 =?utf-8?B?YjdIcWRjQlFoNDYvN3F1SDA4a0k2WFZTL2JxOFp6U3F5TkpZcVZYMDBkRFFL?=
 =?utf-8?B?UyszYWx1UC85R2NzSGdkVmRsbVRpRzBwUnpFdzQ5eDBCMU1CU3Z5eGpEc000?=
 =?utf-8?B?VXc4cUw5M0JuU0pndmNVd3BGTGRibldndjVYbEtZUGI1TENLRW81MGRCbThz?=
 =?utf-8?B?U3BsM1JzUFFTdTVyVjRpT1JjSkQ3V1BmbDg0MUc4OVlWdnQxUTQ0dlhRMXdB?=
 =?utf-8?B?b3R6TWMvekVLbXlIb0hpZHBmbmpuYVBnTnMzN2Y2K3FqWENQeGVPSjlOemR4?=
 =?utf-8?B?aHB2b2VBVDNpZDljN0czdDNJY05aQWh2K3NrVnR6ODF6QVZnRGNaN20rMVc5?=
 =?utf-8?B?YS9aWllrejMwb2JVTlVlck5Wd0U5WHdqbkc4RHB5MGJPWWxNNFhxTVpCemtF?=
 =?utf-8?B?elhCdjlqNFZmczZmOVprZzJxdG54R0pCRndhT2pqMTNBcVdvU0hmbXNLZ2lC?=
 =?utf-8?B?cHg4NDkra0xOck51ZkpnMTVyZU5VeTVFdytpMDFJV3J1Nk9pUXcvVkxlQ29z?=
 =?utf-8?B?TGMyMW5FSVVMV3BEck9pMXhrYkdlZXhxQUFrQ1FYVi9HdEViQlZVc2R1UXll?=
 =?utf-8?B?N2dvaWozMTJCMng3MHlRYU1YMlB5d3d3ZmJYRVFVSEUweTdodlh6RUdpRzkz?=
 =?utf-8?B?aGVFc29FQ2dVN25JSFhIVmwyamI0bTNJUDJWbTAzWEhPWjFzOUVOQjJXdno1?=
 =?utf-8?B?RmRBWVQzbjkwUzhVdE5sUlpaT1duYlorMUthaGRDSHJ3ZDJXR0dZWjczVk1q?=
 =?utf-8?Q?qvvMlw?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(14060799003)(376014)(82310400026)(35042699022);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 09:13:23.5297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 936ea97c-3fb8-4d97-8da0-08dda735e2bd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7432
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

Thanks. This needs to pass the linter, see my suggestions below.

On 06/06/2025 10:35, Clemens Famulla-Conrad wrote:
> +        capture_name: str = None,

+        capture_name: str = "",

> +        if capture_name is None:
> +            capture_name = _get_default_capture_name()
> +

+        if not capture_name:
+            capture_name = _get_default_capture_name()
