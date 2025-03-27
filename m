Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180E1C3600C
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 09:00:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51AEA40672;
	Thu, 27 Mar 2025 10:00:50 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by mails.dpdk.org (Postfix) with ESMTP id 2F0D940275;
 Thu, 27 Mar 2025 10:00:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Geg82k28ftVHFJGAl3n6S5PnNsojnb2sqCeIpiCWh4CKipP39KK/iewYmrdGpTCaQzkdMoiOzi428S9i5P3LQ3JvzAkKglD6j5RSkQLfmcM/oFe0hhFy9Mu8DfYlc4B6GOhuyLQMGMNGoinNRMh1WyKOUBWLopkEJv01OUOgMKxhLp1DBKiUPa4vVRy/tta7YoI03kvNpVSIAlidFq/6Wf5Pa8xfLJxqaeFnndYsEO9KQc23apPhHuGReIfGR3AyaVaJGt9aEjONO2HfgnOQGwqgeTIEMkxqWPtJ1/7ghqpNOI1CD7CuUf/hAUG/pg4GjgyRkRgKNXn2qBytSXGpDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfo3ZgslSbtuX+w3pQIWSPmWY4QpiHrBd5BMEGTd8ec=;
 b=o21KT21fIyq2HcrecvO8HbvutUBX1HcuIZmCtOSMaNOYRX5mVMDccxPoDiq9bCE0rIOQBaSCh3wGdBDdiY/PjQrYd7FTjbJXpJHbT3o/HIdBRdGJv842BSaqM7xQ6JTTJZT6dEdkehhjrX2/4kSXukMxJSqG8+NZOvSHm7ETt+wKIu4Ii0nHED8imieAT0yB7/Z3Qn21WdKpt0fqUc7piOdu9xq2NxJDs4kJaXc+RLWr3jRO/1+ZVxE7gVcg6EqmwX3xHSyMa5MQrzEZIRF/9f/7olgrM8PUMplEKaZBU7drT7IScCUKHk6raiCT4RKvbwWcR2quGrXnvx7odMSISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfo3ZgslSbtuX+w3pQIWSPmWY4QpiHrBd5BMEGTd8ec=;
 b=kstq1GhVyf3sRV7zAFvGQwiRDtLa7XDkRL/Gn/xZs8mtxmxfVH4Uz7ZL1eXZ0c0YxcOZXHBG6reeh0Y1NSqCLASVrWM9zX1bnS+/XLbfLWmu6sWtnPsrdkN2KLFTKwhK18eBbdTB2MvSqDFuuQFjZc1qS9LTy6DkEJ/pfXsnP1u0TcgTvSdaLt5D8ayH1HR+qSYVi7F84PsEQREB4GS1+HOP/WvpTjrLuJFj/g3huh+VSreuQQiMo0uSGmMWJ3xeSHq0zMKYpzac7wlPNLQ2Pk3ytCQ+RM6E2fcwzru7g/NiYEnc0PEW5OKniH6D5jd1z1lwrMTIScWfvEdm12x3qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:00:47 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:00:46 +0000
Date: Thu, 27 Mar 2025 11:00:40 +0200 (IST)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: =?ISO-8859-15?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
cc: dev@dpdk.org, techboard@dpdk.org, thomas@monjalon.net, mkashani@nvidia.com,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: DPDK for rust
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB79@smartserver.smartshare.dk>
Message-ID: <461725d-3c36-9b7f-c02d-f630dc8bc725@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB79@smartserver.smartshare.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To IA1PR12MB6330.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6330:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: a6730c9a-b743-4ca5-7c3a-08dd6d0ddc8e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7+B/FLtWoElEnwZ/4sDNyxP62leWWquEhdrgFnQ6dyVELlhjdU377CwNEREf?=
 =?us-ascii?Q?11mO4Z9zd0cRfj25S0tldEda3INmTw4eU9hlX6uBP1Tu75upNY8ar0S6R7CK?=
 =?us-ascii?Q?qipC4Izv4aCzaxiTb5zLUKg+mxTQvV1C5SnBcSSfWTkR/Xc1Ib8a5JCdeFvt?=
 =?us-ascii?Q?hfzjR0/FADyGFAVW0vy+HIBpymufSop1jaXfrGRXEVwi3v/M0ETwJimoB4RC?=
 =?us-ascii?Q?h56fmZQvGhzfmYh6MUPOKuxf7KAmzYuEsVr0whpolZz0AUWUfyVG4jNpEBxX?=
 =?us-ascii?Q?YYnv462dvYJp88adx8VuTXqEWqT0FQVIu+qXk1nblsJmf3sKnw/8HDdEWWPa?=
 =?us-ascii?Q?OUtnjKwkWm0Xcm9ruU+SnAjQPt9W5G0CMLMUrdXKwGeiNAcmpiHvN7t0OHOg?=
 =?us-ascii?Q?qtOEN3VxPRhUuC9g+L8Vpz1SBA4ioVJUponSZlYWMaOslfQbc8NmewKAu/UL?=
 =?us-ascii?Q?vhEJZU31sA8KRKmUo96ePe8SRVDilcdlDjRWZHB09EkJMWEmlvIhdtVdQABQ?=
 =?us-ascii?Q?zyyn8MYd+/2hS2OukgaNVGSObZN/8EQoyc+rGUkbX94FRCp42cieSE9IqROJ?=
 =?us-ascii?Q?Lh3yDgMRFvobZWn2q+/OGKd5qYPQN48Byedk6rRpDpvJs12YnGxJpXGJNNf8?=
 =?us-ascii?Q?SamMUm1+Mp+4MqV08Ym1J79AzbFu2Vk3XDOiKEnBF50ApXcezb+yYNNGeJQ9?=
 =?us-ascii?Q?kU7qSyOm4ro0WPh/D1XYcXHRdHO7Sg+1S2X50TNQvgbebVxvFVdDucSPE/BZ?=
 =?us-ascii?Q?30DnXz/zjGo+0MfMMuKGwQw4R3DFBYvdq9qx5SfZ6VgHOsuMYrHUTLv2x+9Y?=
 =?us-ascii?Q?L+PuKrwzP77vBxUDqlQ2+fJbg/CBYP15jJxio7s/zxrgKeTV92CuT8HcALBL?=
 =?us-ascii?Q?EhtdOMQ5PhakECvWNqkZoOYTJUg/QRXz0Xq/1OQZZQcf+ylTG4NeRBPKUc1m?=
 =?us-ascii?Q?U+HPSTs0Y+7WBuCcdrBB90qbeTNoiLHAO7ihdN+SXHzkug5QEfeBP9q9C1Df?=
 =?us-ascii?Q?lto5gt3WbUtydOX8oZIKGLGNHfxJCK3/eUUp8ZLpM9moqKf3ENhOY+jpheT5?=
 =?us-ascii?Q?R74McsiYIXWIE/bMmivCIF/nEXDISt31FqvVMQ4ZIDxoj13NRociARuJ0dCQ?=
 =?us-ascii?Q?vsYT2ahX0W3zjYs4Tnt83QIGg9vavbVA3vpnmjZIUR/yf4KrdRsfmiO61DBQ?=
 =?us-ascii?Q?iK1cNDSoXhvZoXcailIn5DOQH0y+1WpY2J5i86SbtshTg9Ix3arszaQ7anGs?=
 =?us-ascii?Q?r9TaWl+ueFSE1olSaBW2jHxs5K+e7N3EsfSQDhYtLYU3WmsSOvxl7c4oWI8M?=
 =?us-ascii?Q?fROz0Z7x0Yw7MqL5MoJ4XURLaor0DNFoWpIBNkIKaONZ9TcSZeKtyOQseirw?=
 =?us-ascii?Q?TWyFd2zOg3oPFF7twdJf9bGS0dh4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l6z9nATQE9lBnC2iQ61QjUTirozUAcuSr86XsrgncwDpc/VBPXWmBJL0mrQQ?=
 =?us-ascii?Q?PCh/QkNOXGEE/CaEynJGN6BCmuBrNJ4yBBGB2skn5v4QrOOi70xE7b4slzRc?=
 =?us-ascii?Q?FRBYAqh6hynsPcgWH+03NchkV2PK49pmrq30pbYj6yPJmTM2G2xGjfRzPzF6?=
 =?us-ascii?Q?vgI+k1QULfTQa9QUG0gQ2m+2Ap9sOtP+RtRukzs3plMTwYUyxtFwfB/yCMib?=
 =?us-ascii?Q?XV5VbzNRZXUQIAEgAC2x6bHcAfqP1jVguGKtV5/frqUPZo6g+K5NgUsEtwfD?=
 =?us-ascii?Q?WIrg0S++I2eehAGvCf2Wenb4ngjvw6l5Xxve/WqJ/f88lqiJgRlByGIQsWL8?=
 =?us-ascii?Q?90Ed2+ROoJ4Jb17lHMfJmwGKCLC6urOzowycht+X/hwGIoPdIGozq7ndfqCO?=
 =?us-ascii?Q?dPgWavwaQ9ZcIF6F5Q8QFpn0sYXfbLua73o8NAUDPdM+o3AngBwWm4Nq8YH0?=
 =?us-ascii?Q?Av/GAXGoTBBodwIkGWE7qzYIpIe/FNiW0h10hzrf5Tuk7xCDNgWCq7ESPXHL?=
 =?us-ascii?Q?QHuEGVehgaP0o9LWWK2q7R5LdB/P7FVdTImG+DYNf0Ww8Oc/Pb6jyBUIEsvy?=
 =?us-ascii?Q?PndSE8wjflLPlFAiORoBdNJrWrDPfse2j75L/vpZ6slIrNmZdoQ8rVogS8t1?=
 =?us-ascii?Q?17OwdrZm0p0VAj92gLFkDRyBULkO0g6gwpuMQ5odBrDFOObe3QIxQegPtOOL?=
 =?us-ascii?Q?HzCVKhhLVoNg3y/Kcgw0oCUPpd+ZkXgMphF1alsdSayD9n/CaifCTRv0pPmA?=
 =?us-ascii?Q?9iU2oe8b2KbOZHPUULwk/D+R4uoaJWL6qDWtSDC783hjrvSBY5HkmWSMKlUs?=
 =?us-ascii?Q?AOF3ENKgfCTrg7AU6OaTYkMOFwsXLX4idY1w6ghOJOJjgAvkfYFOeaEyuANT?=
 =?us-ascii?Q?W3I5HvVo8QMVKb+px7GhBnHWxGxmopJYtYfI2I9U6fc5ONo4/WGg3lmYvnaK?=
 =?us-ascii?Q?DxlngS5rCqp1oePUz/1jTbjTlAJMMvTJT1vy5vcFBEvQIWsogY81Yrw7nyFS?=
 =?us-ascii?Q?9umcMhWBDbgynWgkiCwWMfKM/KrW43fzfNBtcSRRysxk0gVyJKlzqO8YTC+j?=
 =?us-ascii?Q?Tvdhp5/JMCzzmLgGU1pfeCg3KiagYS0mwk2xFy3Ro1GyaDNHDnXPkd+Z6Or0?=
 =?us-ascii?Q?WHGxagQEt/y9875bA4/aSQDP4J0/SCpM5su6KLtOpsP3nJF8Jq8F5g4oaLpD?=
 =?us-ascii?Q?GkjmEc2xa/zSjQcHw9jC3MqBn5eConV3kq/I0xiwVHVBFq1Ni3+tUb8EckpI?=
 =?us-ascii?Q?LlgwxlznrCm2XuxD1sXEA/QuAkUDI7r4uhiD6ZYuwV7XJxQhAXeYusBh739G?=
 =?us-ascii?Q?GuNxUbZnJkay54YPGLDOa945IuEaK5KAKPoij6LjAf8ZQ2pyMfKITWOJoe6Z?=
 =?us-ascii?Q?w6yP2d08Xm5REhop71uepmGTNevRrQSQ3Xr0uBAmfpPVIQvv3aJb0dZJDxwO?=
 =?us-ascii?Q?F33a8StjBB3mPHx6E38+Ovk6kEbXuPRGYgzkhGAxYwF/JZf1ckYXOaEl3Avt?=
 =?us-ascii?Q?msZYM8VlFnoJJQy7xl17HB9MzrkBg4KIXs0nzXKxufc05OyUXoF8SZzQCngq?=
 =?us-ascii?Q?Rc7AjIokDpHGg45/IGnMBOXgb6wIkco5rZa1jIps?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6730c9a-b743-4ca5-7c3a-08dd6d0ddc8e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 09:00:46.0625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybVhwJ+rfnlE+eU4vnrjUCxNPy4p+OV/AldNz9FCeZFjTFvnZJSVbOUW8wdSUZ8EWiPtcnef21Ltf4CvLQM4tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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

Hello Morten,

Thank you for raising these questions !

>
> Do we want the DPDK project itself to support rust?
> Or should parts of this be a DPDK hosted project, like grout?

Rust packages management is different.
Also DPDK Rust code will eventually provide a different API.
At this stage, DPDK hosted project looks like a good idea.

>
> I don't object to supporting rust, quite the opposite. I'm only trying to think ahead...
>
> I would hate to see a DPDK patch being rejected because it doesn't support rust, or needs additional work to not break DPDK for rust.
>
> And how about the CI - do we want it to test "DPDK for rust", and how many resources are we going to put into this?


Regards,
Gregory
