Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FEAC369D1
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Apr 2025 18:50:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC3C140263;
	Sun, 27 Apr 2025 20:50:14 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by mails.dpdk.org (Postfix) with ESMTP id 265D64021F
 for <dev@dpdk.org>; Sun, 27 Apr 2025 20:50:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEKKOXbXK+P/0LZPjkrz6L/ES5mSYERHOyytSpIOhV3Xi1R+u7lQM6zPpUxO6/fh6X9EYnaV4uSZjGqbeR3xLSo81DtdtUg4FCseGMPz2bZXMyZMW+MZ8mRbZ+Qf68wq0qLq3dKVA1Rod0ocrVMdUVcPZlbdU8B5wRn7IeEy31iNNV5Zh2AkANUJhmuilPzzxPA4YN/IZ5RFM46Cenq5RGQQ/hvSoN9UyAkMXKz+a9ic9zTwCpn5lokSnsqWwUI48hBOK40M2TKFKUwBMTu9qmJP6yv0la05hEIp2zB+R5KFzSR3OH3vDcK5FV07jPMh0QEo5E4uJPtjsuqjVJTlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l+eH2NzaTrbad3MhgpQtextyNlyv1mgaNK9xhL0Xnw=;
 b=KfRJ+OIX9jJWVeC9T/rkitHKBbANyKeiVf03ypTennvkILONnVIhxPivW9/JJHwp/Ynrv5uEP7k+uGKdra2Mr7LnF04Pj/Db3AW4WuT5mVsGdBDVV1AWyxgz7C9YNa8hpymRecm6++qgR/1BUcpVOccZKR/80MIzT9kxyQSHOiM3tbOcbeoiETgdRKmV+HTY0WObrjG8GZItX6C4/jaUNZ7KHcxw4xq1Lb2ks+RKy9fgYBmR0KZe4QL1P31VR6EIy/he2LWRKR44W7Kz7Q+r6g219ET1xMJituqnwm1W+ER2xgfZo4ss14LQI67peTkmjRgot3uOtbNZErWZ7EYH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l+eH2NzaTrbad3MhgpQtextyNlyv1mgaNK9xhL0Xnw=;
 b=b2DCISva53tMhArbUW1BTMvB+xp316w9GUZHKyZwyGgf0/1tZmn3CAeJrIkVxBeZ+kkb6EDT+srdj/IHu71Pyf0qkjNa+LfW0p5E5V0xkMPVxBm8jW8fIEYZubOgSKRT0ygKu5W9sgx3wJfZyXktxZM1i7Q1/KbEsjVoOpEY7XOlk1LQAbShpZ8k/iFuNZYWbNNP4GboRjaYk8Q4ciovqXSB0u0DaLmDV7NPR/ecnG/wRj93k8XyqKPwioH+DJ6UOZI6PQwi8OC3+Fj3JgwFBvAm3wZ/lDG4VmNZ/IFSEZ6B3VaKKb2T9bxNFb4g1Xcm5L8pfgI6XpwaWCbIKvCGkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by BN7PPF9507C739C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6da) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Sun, 27 Apr
 2025 18:50:10 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8678.028; Sun, 27 Apr 2025
 18:50:09 +0000
Date: Sun, 27 Apr 2025 21:50:06 +0300 (IDT)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>
cc: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Richardson, Bruce" <bruce.richardson@intel.com>, 
 "owen.hilyard@unh.edu" <owen.hilyard@unh.edu>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
In-Reply-To: <PH8PR11MB680363E200616CBB39DDDCB6D7852@PH8PR11MB6803.namprd11.prod.outlook.com>
Message-ID: <c5387a8c-b560-3fde-3453-c2478d8e6969@nvidia.com>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
 <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
 <PH8PR11MB6803458E6348B4D167C47C91D7BF2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <IA1PR12MB63308A2F69036E3ACCC605D0A5B92@IA1PR12MB6330.namprd12.prod.outlook.com>
 <PH8PR11MB680363E200616CBB39DDDCB6D7852@PH8PR11MB6803.namprd11.prod.outlook.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To IA1PR12MB6330.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6330:EE_|BN7PPF9507C739C:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d034f63-4fef-4684-9668-08dd85bc55cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KUpee7vJ0DBiQaXGOoecaxbYd0gKyULzMBLzay9Z7n+Umxs4rTzBBIACOLGu?=
 =?us-ascii?Q?grNJgDBB527M0s0PQ9KFhLjtgSweTB9lPmZ4U22bUeFttMFM/vFKxH2+Awx2?=
 =?us-ascii?Q?o3AnVU8AqgfkxjDHhehtAG9YBOXpSde8Z9cSeZGuBC3EI8m5ylJtJ8rV4Ys7?=
 =?us-ascii?Q?Ei3n8pdXNZYvBXR5unX6Us1cpQItCni2T2Yw6WPCjQDXHOK5wrSHuWm9H+Zj?=
 =?us-ascii?Q?W2OV+cqvvZmG3qEPdOLXPA3+9O9SJwN8EyMDv5DGcBw72JheS0VcQyRJ1QRf?=
 =?us-ascii?Q?onlGwdSskWDsSE8tH2vtlKlDL4COOy8zLRYQSQ2A22rl862NFqF/myqphLdI?=
 =?us-ascii?Q?aKwG7JQROJ+xx1kc6sumYcuK/XLgArGn3vAK0xyAF2qxNt5KhJVCPQwAIEU4?=
 =?us-ascii?Q?Vjk2Ggb8hOmafKU+9ogW/Kl/bJuAH4m20w9OB4kMEOalzUHmGou53Q5Tlg3v?=
 =?us-ascii?Q?SiAmmW/1677u7/95Q2AVFOmZ2EB7WH4IhKewIbpJN83pg+uTGoLCt5SHHTub?=
 =?us-ascii?Q?pIWS9kt0LxODzGYiEV1llbrHFT3ozJAvxmvgO/V0+W/CdFbrJoXWrATqS1Pt?=
 =?us-ascii?Q?bQieY+UAAousJj7uI/k1F7tza50v+ve+DgfbSps7n0gXaI+sDiX+yIs7Tose?=
 =?us-ascii?Q?lxBqRoUIdYUnZKhRUvirDhFqbMDdLqNgonN2z3fr1f8UM6ipZcbQdTS8ShCB?=
 =?us-ascii?Q?c8CtTnh7S2uzFpNF5yD51K6gJDRvfdTl3YtyPOdmAeJjYeCU336rusq/7iqO?=
 =?us-ascii?Q?rJwKP1Y/KqEpnhTPg90SvjyCP+4OrvopQCD60Liq6i4MZoF5N59WUXoXyLQH?=
 =?us-ascii?Q?rWDhou4BQdLCXgQEriSZBP4dxLEhFf1KiP2WrS1vL9anZ+yfAslFC+bFLB8T?=
 =?us-ascii?Q?QHnlYPPiraTrMJC5i8bfNwDfS9J0A4j+DQK1c/eQDYA7auGyf0sVdmQ7qEwm?=
 =?us-ascii?Q?so/3Yztx6O5pQ++lH0dclT5A/7pJ346WArskxmOV0qtT4egffSL7Jw6fjvhX?=
 =?us-ascii?Q?QYL7UKvr/k/hryyPO2jBSraek68ueeNLl1wZOBH60aV75ml6j8LmtAzeydnq?=
 =?us-ascii?Q?kPX8FrDTvL9ocw70IC7NZqJj1X96ByG5M0gV4t2e72vo1pdk77kRcSh96Y7w?=
 =?us-ascii?Q?aWLwQghnsPNPBDpACrlqcQfFCucnyOIh30w5bLMp7mDMvw3/rgfCuWK9Z3Qw?=
 =?us-ascii?Q?xUZvvguLXCdMTR4J1MJdPAlXPj4243tJd3CGAFM0xCYvdusow79izjJxq/Ij?=
 =?us-ascii?Q?7KE4wq8t7DqFZpFKO/cksAaSmjzq0V+hoTMP0Wv/2jCEAiGuy8o+rlD8t3DE?=
 =?us-ascii?Q?+/O4T1Ik9qXmxHgNh3X4swqMOWhsfLRzodcku1EG/4sRg4YvcRB5DcDeWZYC?=
 =?us-ascii?Q?G+7cTTTQm4661qiK1Cb2O2ecHAdyez9IbqMhPHSzpYV2X170pnoiIll1E1hM?=
 =?us-ascii?Q?V7b5RlmKVUU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QwAFM+7cJAkeYyIHBwHeMpJbDJuGaA1R0od8tNO0js3YxW65fgDLvUgkfhe/?=
 =?us-ascii?Q?KP+6Lx1iCtKhdU762OsjgykvAJCD6zAFRelZUqjCxfeL4WK/g6rIvtwGpb8o?=
 =?us-ascii?Q?z8GBYfxwCOMvmM3Ua/iekLQ3TXpSWFf9yh1UpmfojFuWMkxiJFDvnY70LU+q?=
 =?us-ascii?Q?5C3B6L0ci9XtUq4iVgB6D0b9FGkAUhhKUOrU7NvJMZJHp1K1tA1c3tvCN6ve?=
 =?us-ascii?Q?tobDdmIA1VnXgPnDXSx0KkzhldBE5Rk1vu3M2nhM1FfU3ri7ZwfNULrbr26X?=
 =?us-ascii?Q?upVdNLbJeqBHaNOftVxySZS22yPx0kGx+4SsbIx4g0si0dYYz/ffGtZT9Jy3?=
 =?us-ascii?Q?39AbCBouoSb7w5ECbtswvQn65ulsHevG1xAnF849LvcVGHWZBuy/JRxSF45o?=
 =?us-ascii?Q?lcCfuM60mFINcatwhkw77cKq8VrK8t7qgdLZHJBhvHCih/b2Awt7tuZL9Vq1?=
 =?us-ascii?Q?xs/AG5Nv+Fv1M9LOVLC/UZGUndV+CmNiSTFYLmqKWHVKwvtld5Z3JIzlyoJ+?=
 =?us-ascii?Q?3uscvUf+tErPmKY+irhajCxF9QgQMGtyQwRmJo0sj29sFc02VCyzUX2m5yGL?=
 =?us-ascii?Q?pDlJtNjUOYxRWpnXHtHYQaQxuD4syqMT89cUChw2wrB+e+uU8zvTwbngUahe?=
 =?us-ascii?Q?iIv4ipWUU0ZUkUQpmu4MpGbeaS5lTmQJRCyhjMC5nwqOaRWlYYWn1578f5GH?=
 =?us-ascii?Q?yTzAi7QUP94+eLo+LnKwA6mkkSLsnMBbsMnGNh5h2R1SOFO5AEvZADmN0qF/?=
 =?us-ascii?Q?/Nar5zprk/nwox3RutUHc+/qPPi3NEyFACG66VvssC1/xxHSi6ZqvOxI0JXi?=
 =?us-ascii?Q?UwIBMHCjuY+UxsuhFtS4bVR2ptsrA39NREp22y+OC9ShRtPoVcmxWwiN1dC3?=
 =?us-ascii?Q?o6Em1anoAJmUuvcNucjySNQNcC91VIQKhkq6msNPZVUrm66qFT4Aq2gUKlBB?=
 =?us-ascii?Q?1Fu4UrjvBx1xsKAvRa+CZ+OFxUKubGaIInc8QWUto7onvd3RgrhjRBtx6Z0H?=
 =?us-ascii?Q?/Srxa28bl4LySQJyzG8awnPugzbZENHCMXrOBJJLDd1CKOjiDqQvLWTcE/DG?=
 =?us-ascii?Q?pNXCK6prfDd6hQSTdRu5mMqLc/Bm+Vvv26nXU8skRNKr4fx8Pkhy6L/UcTFP?=
 =?us-ascii?Q?nA8mg4zKaO6Ap7N1zlzjr5v/GPiwojtgt8h678SDULQTjZIPlJyX7REefZb7?=
 =?us-ascii?Q?siAX/kmr9b4Q15D8qu6uj0RihxEXq+ur1z2Ckt+ID2vQ5i5u4ivB7wyl5WD+?=
 =?us-ascii?Q?N9g/Zbp8gpmUOh9IOdyovkAbinq0pu1n2QjbXWcenCa7vE739ABny1w9sBep?=
 =?us-ascii?Q?TgA3C7+jW8xkS4f6V3eFjpKLKz2naCZki+q7Hj04zDebu2kohffwCsNduD08?=
 =?us-ascii?Q?XnvYJJuxBC1Ykr54FUERFg6mt5tMN//EickYPdsgkLlK0t7+wWDTrCdTd43I?=
 =?us-ascii?Q?wlfRLDbSm+2IRoNXVCGaKNrWfIZN3AL8SADrHZQWLnrh/JAEbWStnUmLrp2x?=
 =?us-ascii?Q?NRfFw1k0q6l715uVeK6jcg2zUWqnCsIvpt/RgeO7D9CrpodLavCDnQnxTWpo?=
 =?us-ascii?Q?1tvhLeCIp9h/I/XMw+C0OzEUdXx6EjQWCLNp9e5T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d034f63-4fef-4684-9668-08dd85bc55cd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 18:50:09.7581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBzYWyASqLR4gXOpLJXnb/pFKKL1b7/Uq6SHk7G+1F2jbjyZSHbgwU7r6FRPnuYJZZDM+fGTmoYMtHtdfh7nsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9507C739C
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

Hello Harry,

> > I implemented a working echo server with your API.
> > The code is here: https://github.com/getelson-at-mellanox/rdpdk/tree/safe-q
> 
> Ah cool! Great to see the API working.
> 
> Reviewing the "echo.rs" code, the MbuffMempoolHandle ergonomics can perhaps be improved,
> I'll try work on that and have some API suggestions to the mailing list soon.
> 
> I see the echo.rs code uses a normal "std::thread::spawn" (not DPDK lcores), there is
> some design to do here to ensuring that best practices are used;
> - any dataplane threads are registered as lcores (for best performance, mempool caches etc)
> - registered lcores are also unregistered when a thread ends (potentially allowing lcore-id reuse??)
> I haven't thought about this much, but had a brief discussion with Bruce (who is on holidays now).
> 
> Suggesting that mempools & lcores are the two next up API sets to "Rustify" :)
>

I see 2 issues with the DPDK lcore API:

Unsafe "extern" lcore callback is not considered as new thread and compiler 
will not run arguments Send verifications.

Also lcore arguments use generic 'void *' pointer.

Maybe Rust DPDK library needs native lcore implementation.

Differnet thread agrument types can we wrapped with a macro call.
Example is here: 
https://github.com/getelson-at-mellanox/rdpdk/blob/37494bcae1fcf06bb4338519f931c2130105e576/examples/echo.rs#L88

Regards,
Gregory

