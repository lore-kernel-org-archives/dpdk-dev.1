Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D222C3ABA3
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 12:46:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEDC9402A0;
	Fri,  2 May 2025 14:46:17 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by mails.dpdk.org (Postfix) with ESMTP id C58E84029E
 for <dev@dpdk.org>; Fri,  2 May 2025 14:46:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBYNYdB9IuvS5DgLzIojM5IO85RrhKXT8TL3bRjono01FI6i5rKCX1sXxg6VBkameOXgOeN8ClPW40g1VQiJ7ms5ZyrgJvsoD9jlo1t4g8KesoL1+cDx89avj6JcdW4PULQAx41rQrr/BYjL0ROrPs7kQKIgG8nmUhR2bdAk77bJyTuuJ2183iQ97QtdKQNL1eVtjmrYdP+Tzxj26yLX0czI99wi6cEylqs2Ivr+SdQnjDtggB534sSIKHqbRIV22WZYQJATm9zDStdtJ0r9wC/loaUj93z43PpxiX0oHP0wUUf+IvdcVzhJDRJQYFcpd/h3GY+mreH+PKOi5lMvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnkDQYMudIvK9msDrjlME5CGXbs0dDPNi6kU33dHbJk=;
 b=r/ikJMr+3nRkVLW03eOzfxBVNRzxlj+AC2TeMlIW2g165CyiA1l1I4WwPVspON2LcrM6oPhahRIe85HGP0D6vNBnV2Ki6KQ8Btv50NsozXx9r/OLem8R6DGEQuxfviv5obKWS9mFVdHkgD66TVj/5PtAYq75Hgj/VQptV3CEhrf3FOsImSV7Nmzl/iureNPg/F51Pf0JSrxm3hAKe/Hyhudygb5zy5ziR9LMlqXoX9w+7d9gk6R4AT+wZ2YiuZBS2LwKePBzqH9episeCcZLj+alEqoqEZcRpCM8iWvHy85XRVIBRr/7Sk9+iz3QK6250BUS/fmbDrXYei8tSMc/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnkDQYMudIvK9msDrjlME5CGXbs0dDPNi6kU33dHbJk=;
 b=YaB6R0RM2E8kCDeRhNEbSMpjfXbsceHxS4eUGDXtb05yaqxwMKJkcbyvybsaEvsLC+ljXnwD2QWQ5AUX58bORMZe0PbqTH0Btaqkj2mXn+6okody8LFrA+z928FG4ai1ekgCSBSR+KJ+nfZyyMqwdxXk+eWdJsjIT9db4VUZ8lvwpcgfEE11ywVx7hfcmvCT2QJqnVOqwC1NAR4Mswx3CQ8IYRe0xLkibc5Lfvfat2QVrx782Uur4plEwjGhwYcsF2+Yx5R4ELiPAE/9n9IMrWOc2LtogXznlHuMxxswTjc/L270Lj5Fmi6kFz93Wykl3pXIJHH6WOwGYS8xvPY/AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 12:46:13 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 12:46:13 +0000
Date: Fri, 2 May 2025 15:46:09 +0300 (IDT)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Bruce Richardson <bruce.richardson@intel.com>
cc: Gregory Etelson <getelson@nvidia.com>, 
 "Van Haaren, Harry" <harry.van.haaren@intel.com>, 
 "dev@dpdk.org" <dev@dpdk.org>, 
 "owen.hilyard@unh.edu" <owen.hilyard@unh.edu>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
In-Reply-To: <aBMmUZ2RDSXQOHXg@bricha3-mobl1.ger.corp.intel.com>
Message-ID: <a1161f7d-1a55-6200-7440-d615d5a41a6c@nvidia.com>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
 <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
 <PH8PR11MB6803458E6348B4D167C47C91D7BF2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <IA1PR12MB63308A2F69036E3ACCC605D0A5B92@IA1PR12MB6330.namprd12.prod.outlook.com>
 <PH8PR11MB680363E200616CBB39DDDCB6D7852@PH8PR11MB6803.namprd11.prod.outlook.com>
 <c5387a8c-b560-3fde-3453-c2478d8e6969@nvidia.com>
 <IA1PR12MB6330872DB96BB9D83EF7EFF2A5832@IA1PR12MB6330.namprd12.prod.outlook.com>
 <aBMmUZ2RDSXQOHXg@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To IA1PR12MB6330.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6330:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a5e2c4-2c07-4dba-aec0-08dd89775230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qGseT0CyLh3uqTZMnvlTdNF01RRs7Dh9h2yDeLJ+UKXPLSx8vIyAJEk5h3bR?=
 =?us-ascii?Q?380Eb4bz2gFqmqRxqJl1M/pNMTgqtaprbSkuYMYKEs+hKmVq6TubEEP6PhGS?=
 =?us-ascii?Q?7+e48oU++nUclymQzcnzRgTGuwTr+BTJM2X0ZPmzHE992wjqmXYKM+TpHy8e?=
 =?us-ascii?Q?MYOq4o7XMV31fYtvv+LgDk2fOPjsZKJpnESjrcCkS0AMmt+CxUn+YSXIzxtV?=
 =?us-ascii?Q?THDP4V9lfzXYdxaqb7yrJV8wMgyAWQdwcGUNOGKYjTvJof9pMFsbaqXsJZLJ?=
 =?us-ascii?Q?UmDGA2n3P8cjnXyWoPitVAZhKD6OtdooM7yR46BpTrW2WNuL7TN2Yeb0bw8u?=
 =?us-ascii?Q?a83GzFhOnz9NuELimwsM7xa4es/hpIRRgcuiJW9bNOZULJ5GR1WVYUfLllZs?=
 =?us-ascii?Q?x5v/zGCt7mQlJ/vOmT9sr80IqsxTugyqGk0U8XR88GeXbzhau3T1LYOHeVpq?=
 =?us-ascii?Q?Ag4CZQiqFElvQWG01+EHH2Jbo7GpfinILK7Do1gYjSC+ZIyJyRQSv6RmkaMG?=
 =?us-ascii?Q?pDrmNAsmlFSnZh+M3+DTWIFxHuajsJNs3uy93vck3AGXpBk0up7Mh/FMv2Ju?=
 =?us-ascii?Q?jcWsfrGip/DNg5TCHIoYm+Q1jCZSHycwUikH0iD6H58s4QdawB557DGhp1a4?=
 =?us-ascii?Q?QbGVphg3j0rud8GpMAGZEs8HB5dhSmEMJD5TPlKApj+h/Xfcg+D6xJB2q3Kg?=
 =?us-ascii?Q?yZfsyXVeEbznMlPHM8WbiQZHAfLDxUlwmIBNGXXZjcajOS//QBh6unpCnQaD?=
 =?us-ascii?Q?Konicq3J4jTjgpgFo70yQq/Ugfzt0aqDqZpQQqKxcsaTs8UZHbC02oHLTaKP?=
 =?us-ascii?Q?FIVbG2v2YglB8P5q8K4PItoQU8cngn5wixLkWPfVz2pZ6HwSY0JopX+dcVi7?=
 =?us-ascii?Q?9iVkM9hHO4Y5+fFI44FnHXDw4+7DYHRNPQ7kQ7b1/d5SS0nwclwrAAxGv89p?=
 =?us-ascii?Q?vj5ftkj+rwYf7QS81sL02cnqlAc5ZHfDO7P2SAnTeX1mEXrkJXNwlQCiX9FN?=
 =?us-ascii?Q?vBwK0TP9ut8/XB2UUGt/xWCb+J6LmClt9lUaK8BhFajFsHoaOTAR+WDXpWxj?=
 =?us-ascii?Q?teWc9Usl1Gl4+GSeieKjGRylophX98hJhi4BaZO+UY6Ayz2KcqpuTauuSgSS?=
 =?us-ascii?Q?E7bWcNEqHNHwxbeJxFPRqRSxP0of8jpA4yWsTC/qeD+7oWCpGL+kF6H/exEK?=
 =?us-ascii?Q?oV+5B3MzW/QjxAqGmv+AzzsUuhRhYwj8W4oh6ivqsUg99eL7l40/FzmqM8bC?=
 =?us-ascii?Q?+Jp+NgMf0Pjjqqtmb3Rb5NpfMQ6vJa5sHa2UXqvwB7y5jqsREJiU0cED/Dh3?=
 =?us-ascii?Q?Gf+CAMKiljhpsqbiAqejqucu98tLKtfvnJiqToUuXxMsfhAcYHokWxXXIDQD?=
 =?us-ascii?Q?jp1WUmmy+QngM3mCO3CdDwHQK9I5agZ1fE/retKkWDUV3w+s+WkuBLdYbA0b?=
 =?us-ascii?Q?vCxFOGxzOys=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CPhto/cSrpeyhKJMcW5PTRyTktlu9R9jPA4POGrUgifH0q0h0Rj9Opl2Imie?=
 =?us-ascii?Q?qJBoZGSjN2QvVk1rZq/Ym6SdDOf/p+UHMFuKKgIXLu4zd4uGjaP1J5hqr4FU?=
 =?us-ascii?Q?nIhssTBYDgfal/9teMh1tvX+Q0XT0vi9vUy6xwcV66AyDgboJIU1WlmzVyaW?=
 =?us-ascii?Q?Xv6CJMh3QJn939LiNNqaZfILbDYxHQAlwsIbG0BNEvevh4WuIrqbEyvq/Mum?=
 =?us-ascii?Q?MOT2nWYORRKy7wzVWk0wp3AQVXHG+Z0VIjv8hLRheVHj+v1YcifpIbH0ilCc?=
 =?us-ascii?Q?GE3J7tqbddPHIpMQkHuq5TI5WckfSHIKWNVmgzqpNwg1MRwLq9DzjwD8jjWg?=
 =?us-ascii?Q?iX1OhpkelpcjcmIDZGH85eKGzV7kxt3NS/WEXrYUdIeY7ITZPUJVRfSHqCnY?=
 =?us-ascii?Q?ZRg/RR6q17VTfRV8Y8Go+nDO6D3sQM9a4rdummePq5YE/RbVshHOb7fcy64n?=
 =?us-ascii?Q?pAxkSGHLSBk7TnQkhwRI+TmDJv6Hmy9Y9PIQkMLnc1YawZwYS14P1h3y7kKh?=
 =?us-ascii?Q?z2BX2A5NUYbliRmrXKLMHq/kBmn6Q0/wJUeqcxQAuk0K4PZUuAmKYva6ztUf?=
 =?us-ascii?Q?KVyQnCvRywu7BbVT9kuz/wbA9cyWpjJmTMamIDTs2ta1Oas2aGNxTJorhnXE?=
 =?us-ascii?Q?Q4e46lHgx5QVPSsWeYFF1TH1M4fMYibeY6moU5eBdW4u5ZJwc2QwHaEE6gi7?=
 =?us-ascii?Q?/LGEy3kqm02swv5BA321A7Et2EWjWjsXioV4AzVLE9N3buhHQZgDAZ7MiLX6?=
 =?us-ascii?Q?QFEQoMOpV2MERUR99B86/IVZqKgNeKYP/cxaYk0P78jMUASh9vnXgvkGBsuS?=
 =?us-ascii?Q?zGGSPpY5B3K7sN2VTHpTVf6PnIz5tiZfxy/7H7c1+A1XkHHU2wAN7C0RGLWc?=
 =?us-ascii?Q?pn1f4+wTsRYdcFU6z0zALDhV0xx2zRLy9LKMDEfYEhoYVgpOGlbBNxz3DsOa?=
 =?us-ascii?Q?Y3w2AzfS+N9NROlSUhfjW4zxGRRWopskpuoWmksxHqEEYUoIaCR+tuuPeOlZ?=
 =?us-ascii?Q?dmIA2JJBl9hltQuSRwmUN/y5Y6B7s7EADRxdv+P3GpGH6HaoO3eWGnPEgYQT?=
 =?us-ascii?Q?JVrB/o9oqwaDTsQ5jK4EG40uf/4w1XY6OzE9H4BVv6gynNW4I4Ro4tl6t0cK?=
 =?us-ascii?Q?Wa02/tBy6qtTywCdgq34COCDLUVbVrGHza5KYa07eXg0GXCMwKmU2X5mVvER?=
 =?us-ascii?Q?bhoy8NxcJLsXtQVbe1TcQkI92cLz4svyOeugPMUBS6PzitRljQA68Uk94o4c?=
 =?us-ascii?Q?mq2TvK+xFADqGt+jMCkqHmBJweO+D2Ot/DAFIzW5QxC1aD2YUOA0mMLzlZFw?=
 =?us-ascii?Q?97vFRv21gRzrAFENvdphm2E67ynzk1ucLdBs4VD1nRaha7yZr/M37R3RG+Mo?=
 =?us-ascii?Q?/M6gFrvVC696EWr5S7Q2v9fxE3V7mo2hkWTJpbZmhuAUhYLv7pramg960Yjb?=
 =?us-ascii?Q?kCcwHXqCiP5FTp8s41DIWfzM1e+bahAR+l49x1CSnONC44La+ohmvnMlMF9P?=
 =?us-ascii?Q?sUf0Gn2u9OP7WPvK7oMoHE05hlHFAY0demTuQP5+/Kl+V30xCYgydh12G1Mv?=
 =?us-ascii?Q?5HNnLtHKMtfs0Qd7RBSt+jXYkfw6JY9tkAi6iuTjhKC7aGZQAuoy1Er92Fmd?=
 =?us-ascii?Q?giykEwTpajPmfTIgZHpgBODtQn46WkX1ZInj0q7pQq09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a5e2c4-2c07-4dba-aec0-08dd89775230
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 12:46:13.0891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eTkWbH8bJgL1yx24oP2t2VMco1NFviqFSF8v+9hg9+4qZyEj2FWewUB0o+Wu9MBQo921Ch6nh2EWoFOuDs8ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871
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

Hello Bruce,

> Thanks for sharing. However, IMHO using EAL for thread management in rust
> is the wrong interface to expose.

EAL is a singleton object in DPDK architecture.
I see it as a hub for other resources.
Following that idea, the EAL structure can be divided to hold the 
"original" resources inherited from librte_eal and new resources
introduced in Rust EAL.

> Instead, I believe we should be
> encouraging native rust thread management, and not exposing any DPDK
> threading APIs except those necessary to have rust threads work with DPDK,
> i.e. with an lcore ID. Many years ago when DPDK started, and in the C
> world, having DPDK as a runtime environment made sense, but times have
> changed and for Rust, there is a whole ecosystem out there already that we
> need to "play nice with", so having Rust (not DPDK) do all thread
> management is the way to go (again IMHO).
>

I'm not sure what exposed DPDK API you refer to.

Regards,
Gregory


