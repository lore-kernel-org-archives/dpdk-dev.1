Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6ACCA0FE7
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 12:51:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19D10402DC;
	Mon, 25 Aug 2025 14:51:38 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013015.outbound.protection.outlook.com
 [52.101.83.15]) by mails.dpdk.org (Postfix) with ESMTP id A668A40156;
 Mon, 25 Aug 2025 14:51:36 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=T3xwEfkl1WFMBV3d5xpleI0L/hrLu/IcBsyuBy6pfw3KFQWfh4/hf/i5AMxtt9gZ5ySQxcE1u1Itpo06uUUK87lXzV0rRsmwD4oClXUqGww6oTuc6yCV1WRkm8Aq68NeH3T3yAGBgekHYfbw8u0PNUjw4X9jJbTIPC7wnowQF0Cp8dGzZlsFD41PGTdWK2rbzkhnZeIC1G+4fvP/ew79pr+3bZtkCZgZ0IPaysUfExp0Z7fUTsGjUDLm9HLwpNeX8K5poijOpTnD8prYPohHFyxGKAM41vE2ZpTzu4ejnCsBzyX0558WRw7ozmaFKyZD6KcaYGKP5cjV4BzVAiuU5g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1ictRsp3hRPHkISZFOcTzp+VhZv+5Ci4OtMAWGQ6Uo=;
 b=yaXnEhN5obghsQef9Kl9aBMwU4Fhnp/WC0zOSiYk6oW4uPbzyxVvi+mb5wdf38Vi+/K2L8H5m/LaqUKYYt6xLuxVNgB7f5da64yWhgxwR3NGhLObLY98y7hdRej0QoD/zqMoT+tMH1jl28pY8EDWkR8uW5/HoLMSucB9KlNCcT+5YuQ6UJ8l0spnASMt/QEejQv5/J4Dm0u3ZscqsYdSFwfs6B2VU1Yh3+2XIYt9yCFOGSSutigBuGmdFQoLGbKFGk84EFjn1k04cfZKpsDK+LJPrcRXQybLxAYjklTBk0ocsmQNe61P+3B/gdR43rrOVm6t2QwgKqpeolGqPa6FFQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1ictRsp3hRPHkISZFOcTzp+VhZv+5Ci4OtMAWGQ6Uo=;
 b=bxbrweeHcobWzFQ3dvtio21Rn+4Lf6jdT4eYNXjWOFQQiVCoNowNIppwFLtprdSyKABikG/3odBkX9b5Q27hMmJZji6kYcvcAFGxgOHpZ7YCMCYXpAPvi5XKrcKbjwGZ565B6uo7YKYZO2tHaHZqw7vY7Lkf1lkwAYO7kmCPvF0=
Received: from CWLP123CA0020.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:56::32)
 by GV1PR08MB10599.eurprd08.prod.outlook.com (2603:10a6:150:16c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 12:51:34 +0000
Received: from AMS0EPF000001A1.eurprd05.prod.outlook.com
 (2603:10a6:401:56:cafe::70) by CWLP123CA0020.outlook.office365.com
 (2603:10a6:401:56::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Mon,
 25 Aug 2025 12:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A1.mail.protection.outlook.com (10.167.16.231) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Mon, 25 Aug 2025 12:51:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4ZXI3KWGI1LjrMpqgPEgBWXDBb8S92jlIJr99dVBVv9VohGdRVlI2I5GFRh6eqgfbpRGXYlmd/Q5xc7Nf/8+bxJ5zhsNScoUqjLbDqXGLJ+NTmnbMM04w3a+6waCJFSaKpT9nMmx1upqXnLZTqYp1KpGvtHB9rSv0iV2iMgygOyTEreVKKWToktjOUe3JnHFFdmDemJztHR8CoH//JyU4by/IghicSJduoyKBW/GX4gQrAAhvl5fs6+jvVk9ACFx2W26Q9oqsfgB284Zs3JeC4UOqN5YIqP9+6WZXIxQn7A1aBZ9L9L84W2A49drtX5woaelX4bOmFtWuaugo6FRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1ictRsp3hRPHkISZFOcTzp+VhZv+5Ci4OtMAWGQ6Uo=;
 b=HHEE8KH1QsDwdZemTVetKPKqffasmIQ+yT3K5QAneNMk/FXBd3nMDUpU7+goXzcVzFMWS7hqzGFfEmGIgGxD/o0PKPsvxzrr5dBgeLHyJLSB13MTqLGHZeaSEuNqB8jM9+hXujm8wweFDCPHy+1XMcnJiAujnJmI3cG8+4w0aOG7Qhc2d2MLH+ihiSobDvHWXEL7f5u7lwJNFYbrCdBaQkiHBoI5rPyHasMG0uihh/6NmviBuaFhEGHOjff//rMjAN2PwWM92hHcP5dIBR8tlEzDQzOhdUzQdEOcrEtqquc7UGI6rlLEFTZvVrKLqSD80hRFBR6ZeHwT4XGodh9rsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1ictRsp3hRPHkISZFOcTzp+VhZv+5Ci4OtMAWGQ6Uo=;
 b=bxbrweeHcobWzFQ3dvtio21Rn+4Lf6jdT4eYNXjWOFQQiVCoNowNIppwFLtprdSyKABikG/3odBkX9b5Q27hMmJZji6kYcvcAFGxgOHpZ7YCMCYXpAPvi5XKrcKbjwGZ565B6uo7YKYZO2tHaHZqw7vY7Lkf1lkwAYO7kmCPvF0=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by AS4PR08MB7630.eurprd08.prod.outlook.com (2603:10a6:20b:4cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 12:50:58 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%6]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 12:50:57 +0000
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Shani Peretz <shperetz@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "getelson@nvidia.com" <getelson@nvidia.com>, "bingz@nvidia.com"
 <bingz@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>, nd
 <nd@arm.com>
Subject: RE: [PATCH] config/arm: support crypto in cortex-a78ae mcpu
Thread-Topic: [PATCH] config/arm: support crypto in cortex-a78ae mcpu
Thread-Index: AQHcBdFyNZdoBpH8bkqbeb+za00DP7RzcV3Q
Date: Mon, 25 Aug 2025 12:50:57 +0000
Message-ID: <PAWPR08MB8909F6D501EA994F2EBE38549F3EA@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20250805062233.222260-1-shperetz@nvidia.com>
In-Reply-To: <20250805062233.222260-1-shperetz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|AS4PR08MB7630:EE_|AMS0EPF000001A1:EE_|GV1PR08MB10599:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d841be-4448-4d29-56c5-08dde3d61d9e
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?L/keVjrlsetYfnPYRLDiRUOCfzIrY///GJIC/RqugujCV/diIlQp1smBq3/P?=
 =?us-ascii?Q?B+8wthf0/5vxML88mtNtouzF5f7ww5I6s4SPz7vRlTeukiRDNGCD0cYgBCv3?=
 =?us-ascii?Q?waQB8VAy9t1ok6zJxUsDEUwenwDQqGwaC7SCk5BgmBo3RMqzQmnILeNGGAWf?=
 =?us-ascii?Q?YZs8DCeAN9qpfzK5W3wHOaaniEb1mV4TJ5RSsJ3BZuY60hoLXQevyvVBrEWT?=
 =?us-ascii?Q?FnIy/awklyOzDdhY2ATFxCTvjojZFPeP4EaQ0wfjCdOQMcHq+rZkbXko751T?=
 =?us-ascii?Q?w6P8fhk7dL2JPFcLZJVoplzHgibLCz3Og515kwAb0692+2Z07FfvHVhOD5em?=
 =?us-ascii?Q?NfRGbr4iU88qpLbzES8W3NV5M4MiYA1/m+GV0g+xTDHEOXNIvZUaQl+N3xTw?=
 =?us-ascii?Q?JUjbgFzofXyZXeymfbUE+D9VcBsvWuTtQMA7PrOovwPGUvpvEsLtPO6yVbRj?=
 =?us-ascii?Q?kN7bhq/pzgwYpDfHOrNRouNdBiyWaPFQdXX73Jn/Ok8NsP4Z77YEqUgHfQUA?=
 =?us-ascii?Q?20KN77q2796GY7xS9iTArtbYuP/Vz1NpgpSlWZ0PH5m6yQJpjlH36KrCVtWd?=
 =?us-ascii?Q?9D6Lhs5b0cS2Ihz6KdZZhqXPKv1aNh8jLu99VMTLv1t/1BChqzAUCRQu1IjU?=
 =?us-ascii?Q?ph+T84uZ1yPqXK+Sc2s4utUItgJD7Ljiuo9wqhChdE5S2YJNsEgPpw/ZeXaz?=
 =?us-ascii?Q?wXRKr/PXcBoD63LFxOQytnfUTNp+nQUU6cVaLSi2J4KT9WB1j1YgffTWpnR8?=
 =?us-ascii?Q?p6XmotgykM3EEpWh8rttIkYTik6zmAn88pi6bbCTDtNdBnxjPzmTJcxf2Jgy?=
 =?us-ascii?Q?ZeQGNNb+oiRIqHESz+v5U14xNIFaBoWXMBLDTCd9OvL1dRKqrD/TiQgK1q49?=
 =?us-ascii?Q?EFGzI5YNLZg8O2XVBmNywXR8IdWrWqj9udwxFUQX3f0eTSS7lV2HWtQETu35?=
 =?us-ascii?Q?xeZ6Pbpa/qbO0HZ+VXBvJn35DvM2Ur3svakyW0cFtqYxCnDoTJUuJbM8ySjt?=
 =?us-ascii?Q?wFt1mX6a/aup+7abhwOwKfRPgDc5kgS2AxpVLK/k2MSkc+pLslwcN71jJOQb?=
 =?us-ascii?Q?4EOtpW7xXGH/c7NSKzeyI0q09ZZRy5kiA0kSuX3MeXCZfhxAbMrWHAzv8dLi?=
 =?us-ascii?Q?oZ4nUvetz7+OhBg33SqJ18n3E9zIx5rD74wLZTHiGXkY2cGoEiKRn2CttUVQ?=
 =?us-ascii?Q?14oJkfZhQiIBBfh1GugorlBdpFQOyak2/CpV4rGn0aaIZ3tOz4c6z30FPIJZ?=
 =?us-ascii?Q?VV6nY36QqXrwXFogP/3UJx2807scwgpGDKFY8aw6pwm9Z0p8RlaWeEv5XszV?=
 =?us-ascii?Q?zNWf6KAxNUQpiyB7apCY/Ri82ULKCQiPqOLKkFwkXjprawNTewYWEw4ENlOo?=
 =?us-ascii?Q?UXyE+aLtqq2Xna9aQ9/dkuiXitvvMghsmdyBDtGWMY43sB6LPd3OCbq66h+p?=
 =?us-ascii?Q?01NBm1cVi6ZY8ix8w1Gd/QOPiOWdP+Oc9g9pgDml/BZDaPI/zoxaTg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7630
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e0e4f8fa-9329-44db-cd7b-08dde3d60945
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|35042699022|14060799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7gJfEfglZLglci7RY7KUDMrW8H/O2aAy5h8FC5KIOjld4wECiOyjBWsx/GV6?=
 =?us-ascii?Q?4kCrilt8Y6xUXFyQ5MmIab9qbypaz1vXiNO58qlgLQYxMGOsZhbKGqSmZ3TF?=
 =?us-ascii?Q?mJYOWKDqyczR3TxV/+5hydBivjG3tVChV3UIJYdwn0CwGNGRS2iRr8j0p9hG?=
 =?us-ascii?Q?VchpFvWyyMTqhLTOpIOMXBHG7pXI5YwKtHgZRBbYJm2WXyCFm57Hp94qYcES?=
 =?us-ascii?Q?icIH6OIi1FjEpbLBEip5CNrERDkBX1uPIhE2ts/qJqOvaMD2IOAIP/AgYOY4?=
 =?us-ascii?Q?VlNZ0oPfUPWBb6D3HCO9N9EcyMC0EY+4SbYHAo832EzfRk75znZctjmK3yS7?=
 =?us-ascii?Q?F51vEE508ty+nyYQ39TKxoNlgJAKfFJINkxcHYDXuubmCFPuYB5E0L7wiVJq?=
 =?us-ascii?Q?OCv1iU8Uw/ktf8ChA9s17sAwEBwbaUlG4+4Poo5/QBAIKXb0KUrh2+6UWaCq?=
 =?us-ascii?Q?ul810Av8+p5WAJ9k0c4kYvZvNyBhzL5SoAqb/mcIkqnF2pJ6mMDroe7xghd1?=
 =?us-ascii?Q?SZLnqsFX3Kf1pjpMxUJTbD90q1aQi1PUB+zbquEeWl5oPGOOmUgwryRYVv50?=
 =?us-ascii?Q?nd0rCwG5rVZ0wzaQ06MRROL5Ff6F62hgsdlRd78NEL27hl5VapsJA79Oo9M1?=
 =?us-ascii?Q?cnJooD872V+Hxjt1WXy1Db4S1hS7TOhvprD4WQAxoK1HmSSyDoGzQ/Gtbsy9?=
 =?us-ascii?Q?yv/qLHW/Jmgor1nGewomc+K6LCggFWdArMIC0JrEvEI8Fyay22r0i+RE4Ur+?=
 =?us-ascii?Q?v6GqptylOOsIHXmZA/qv/yY0o/cVKxEy+JjiXQaApbsrE6Of7TiZQdgcZTGY?=
 =?us-ascii?Q?C1uk0k/cMNi0uoTQIqkTKrm1kSVShUgrIcghKffzGGKCl91tVOablMDnkr8r?=
 =?us-ascii?Q?J+r6tmQ26Gi6s86YREZiCoMWg1klnz3ooxs+qj8DxiI8vyAdmkeg4ERLrnD/?=
 =?us-ascii?Q?wLndQQpt4hEVCQA9DWzk72tTVAJSHYBQTByOedpisWHVwfqP6sRo8/9ofHWM?=
 =?us-ascii?Q?evjwe8lchSRWK1VPizGX13JwUmSJoYKGBNfne5TyckxE2wREoSunluW6bmDY?=
 =?us-ascii?Q?JfxwwZKbX9k5RT3PUyYxp+O41Q/k7tAiHI7FlrzwXbaoiPNjenz9e/MO5K+a?=
 =?us-ascii?Q?qAo/M+Ub6qh6gVB/CxcK6rA9kRsK23+95I+vQln96QfFX+EP59+gNpJawIb7?=
 =?us-ascii?Q?mveLtEuWXYY8/QfgAneXK2Om2pyJc2qRvaQ8tjZdCrmZRzTmBf8Sg4DUsK85?=
 =?us-ascii?Q?de9qnWQ08HcRlFuoEQqgvt07kPo+CZjU5uhbQ8La7pLfnxOvsxe4fwlU4md3?=
 =?us-ascii?Q?NKJo4lLcZI2/XvSpov0MuMKDT5teeOHS0Kpz4j5h2Q+rn1uKiImKWUbhuwdc?=
 =?us-ascii?Q?X7qwzdUgqx2FjC78NN63+r/BWg99nleRz7M6g1/apxmpWdp2KofQDkW4a3v8?=
 =?us-ascii?Q?96Gt75tbQKNrH6mDTu7uhY8KAWtAMoA82xOfyndtiaWL79O27HhQiNL5HVfR?=
 =?us-ascii?Q?9ZUsRO8mUrr+5dg6KZI04Yf3AjdNhACTo2sL?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(35042699022)(14060799003)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 12:51:31.4934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d841be-4448-4d29-56c5-08dde3d61d9e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10599
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

Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>

> -----Original Message-----
> From: Shani Peretz <shperetz@nvidia.com>
> Sent: Tuesday, August 5, 2025 1:23 AM
> To: dev@dpdk.org
> Cc: getelson@nvidia.com; bingz@nvidia.com; Shani Peretz
> <shperetz@nvidia.com>; Wathsala Vithanage <wathsala.vithanage@arm.com>;
> stable@dpdk.org; Bruce Richardson <bruce.richardson@intel.com>; Dhruv
> Tripathi <Dhruv.Tripathi@arm.com>
> Subject: [PATCH] config/arm: support crypto in cortex-a78ae mcpu
>=20
> ARM cortex-a78ae configuration (part number 0xd42) is being built without=
 the
> necessary crypto extensions. This results in infinite loops in the crypto
> performance tests applications because the hardware crypto features are n=
ot
> properly enabled.
> This fix enables the crypto extension in the mcpu definition.
>=20
> Fixes: c02c01dbf907 ("config/arm: prefer strict use of -mcpu if supported=
")
> Cc: wathsala.vithanage@arm.com
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---
>  config/arm/meson.build | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/config/arm/meson.build b/config/arm/meson.build index
> 35b7553e74..82661b7cfe 100644
> --- a/config/arm/meson.build
> +++ b/config/arm/meson.build
> @@ -84,8 +84,7 @@ part_number_config_arm =3D {
>          ]
>      },
>      '0xd42': {
> -        'march': 'armv8.4-a',
> -        'mcpu' : 'cortex-a78ae',
> +        'mcpu' : 'mcpu_cortex-a78ae',
>          'flags': [
>              ['RTE_MAX_LCORE', 16],
>              ['RTE_MAX_NUMA_NODES', 1]
> @@ -689,6 +688,10 @@ mcpu_defs =3D {
>          'march': 'armv8-a',
>          'march_extensions': ['simd'],
>      },
> +    'mcpu_cortex-a78ae': {
> +        'march': 'armv8.4-a',
> +        'march_extensions': ['crypto']
> +    }
>  }
>=20
>  '''
> --
> 2.34.1

