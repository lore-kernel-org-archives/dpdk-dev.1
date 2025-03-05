Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652A2C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 09:13:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FA2A402E8;
	Wed,  5 Mar 2025 10:13:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id E9F8540279
 for <dev@dpdk.org>; Wed,  5 Mar 2025 10:13:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741166001; x=1772702001;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=b6CsPlafhIibC/aQxVKPzpze5b9u5im9cu0IH7oOTlU=;
 b=nlenTuFQ/J6hsyAfOrx5KhHJuFHEDYAoArPjLeXL79GvSf8TUfEfh9R4
 DugAl6VoYTmeD7oD/3mEefh3BWGoU705KsN2SN7vx40JymLgDx9JNzbZY
 aNTk3qkRhWsASRaXm7WHe+1X5ejznok3WBu5NgQA982Bvs+xGAnycUDAn
 +2qeovpuahSuh0/pOoSwpjb5xrjAdRHVaOf1YfriuQM9IUMjG1IJi4vLn
 CPT4FfChky5aCPdeGLt7oC7oV3qESQbPk21CUs1DJvhB9HSBXI2TSeWmA
 fppsoXtGTnLjjO8iVv7WNBkE1LVgf35f5PYFRaXQUOQFTAATLYbyUhHUe g==;
X-CSE-ConnectionGUID: Lm98ReI0SXyiXXgJA0OsIQ==
X-CSE-MsgGUID: Tr6UxzbPSeC0U8pL8W+nhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52757068"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; d="scan'208";a="52757068"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 01:13:20 -0800
X-CSE-ConnectionGUID: KIjvJ+dyRTyVTfiTwQmvJw==
X-CSE-MsgGUID: wwbwWDG8QQiVxTKeDUMLQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="123825170"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Mar 2025 01:13:20 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Mar 2025 01:13:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 01:13:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 01:13:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JC4aBtHihN/1AMffxokcsi2iTP3V2oDmcLkvoMLSJC8lUhUIpgC2NbF3C1/CuN0389UkRdQeGfsmFY8egFfXF2XCr735Paa2oZ1tB2NipukYR1BueBK6SfRJAcIZWWRhZiOwr4gME0wu4TBhvkqD1ADy6jbnueDjBtEzirppeH71YyANSrHsjIHnQ2w//EWmyxa/w3jCSVPnTLog3+iSsQ8B2fSoUaBXz+KqnhHLibVu/uEDjIH4W4gC8gkKEnuWrYJn69BZdS2b1zvA739bHN8aODksgH24Tsklfyp3zlq7AOa2HmyfQYMJZdHNvyL+VfVIpNG1rch3Vr7r7y5MeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buJImkBd1FJk1ukjSpr45YgEVogtDJpd7bmZ2hNaIrw=;
 b=W2Tme1ZEgzRrT2r0cehXDNbERiXqVw3B+7XmEMtmOM0/c3a2wngIhRB0+eP81w7FfEEnUJjvrq+WeDHv6AFlsfsfgRTVJ1bJQPVV55pe+rbxrRkomYTFMKrFTp9xW4RerS6ldopmqiqqkWHmxPj/kLoLVmYyTnLrpQrWUKUgcKRpR/mrdDbUR7gBIL7UqALF5r2birrQ1Y1YNmPC2nUf9WhgvBvSp+cdhJBEAu8eWQPf675SjeEY/0LxiO9J5zSpE0Zjp2eKOpA7KU7YYutmCEw1l2kV8LLG645aK6zmwOK8LbMoyzOO/1oZ69yNQGYBoroksHfvrgop7QDLLbKSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB8855.namprd11.prod.outlook.com (2603:10b6:8:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 09:13:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 09:13:12 +0000
Date: Wed, 5 Mar 2025 09:13:07 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, <sameh.gobriel@intel.com>, <vladimir.medvedkin@intel.com>, 
 <yipeng1.wang@intel.com>
Subject: Re: [PATCH v2 1/2] lib/hash: initialize __m128i data type in a
 portable way
Message-ID: <Z8gVo97PpW2ijyZa@bricha3-mobl1.ger.corp.intel.com>
References: <1732748278-14796-1-git-send-email-andremue@linux.microsoft.com>
 <1741125199-1217-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741125199-1217-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DUZPR01CA0118.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 537774d4-1132-4e1e-c66a-08dd5bc5f435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qr9io1uuWvx4JuBweWAptFPTV67p2Gz26corzUtnmw26IveFrMMh4crfdujH?=
 =?us-ascii?Q?KnVmSOAJ3Il4gZTCIT/3papK8/slJMs20+SB+F7+w9tUCoi3levoFvvKfta4?=
 =?us-ascii?Q?Dm5imypChxfkdr47GxMUoHZLsKcQFFIpvzjmxoPIMbHSSYRfeF79+nUJr+IR?=
 =?us-ascii?Q?VwfSY0yyYJt+KWMF2Y2wqri8edtWGwNV0fXsodWx1/AEgU3HuIvjn3QAWqBj?=
 =?us-ascii?Q?+oKQrU96a6PWILce6BQf2U8PwliD3nd529jNVpk8M22Ukf59GnxBm+sNfmPj?=
 =?us-ascii?Q?eqH5foUqbnPTtP/bd+mcGEXJS7klEqW+d6ykkDY98MuHDPYta4MYakVpmHYU?=
 =?us-ascii?Q?4Xyuemsoj3auhi9z682z495t3hWt7UdIUPmEGb/IRe5EeIxQOoCw4/F/Rwm2?=
 =?us-ascii?Q?T4+cviYgS9IHK26jQLPH4iob2B1CMIE/WgmbccM++sAzXTiTKp93XszQzAo1?=
 =?us-ascii?Q?Z2VSuTnlAwdnxHzE/gZRke2oKtKrleNUzNLZqbAvWDY2JQ8UFoFdvaTAvtEe?=
 =?us-ascii?Q?S+8L2kcwWgH9a7FGQsqdR0gkGkRjx5/GuFB7Wukgjw1t7b94uMqDB79e5kVj?=
 =?us-ascii?Q?39/Srmnw7jV1RTTHg7egUUwVZavmUVIAzzPbhEDt7U7t62DMgrTaUKZSjaYo?=
 =?us-ascii?Q?7mVWvVw6wk5bTeNlehdlUZqEN+HqpZXl9HourQYEz/iHaGMLy6wvDzY6zNzE?=
 =?us-ascii?Q?v4gTgjbLDu4UNgmDHSeK5kzAom60+ByGJZr/Oe/ZEdPVm5nre+8+kpLe0+u8?=
 =?us-ascii?Q?OfeQ8BNscuvDcye9d5V7YI82q+LBwMzq2JjvK9GTkzYq7aldFUPGOg7Cw21t?=
 =?us-ascii?Q?BtcvDgTm87j/fn1Qqjs+0zJK5nYZF498C5/oZZJ4QZEjs4mKfbrBwuhff8LH?=
 =?us-ascii?Q?5NAoCLzTVmNh7gSQUXi1Yf6BjTF7qpSAIP/1innaP3dqSm6mgeXMC0uyVFdJ?=
 =?us-ascii?Q?K1j+yncgRaoij0S2UpxyMJJrI/2glaDTI5WrwsK9ohthP7EPWLh8l2R6QHFD?=
 =?us-ascii?Q?eC8oAy98rwUevor+SXOLepJKWsswpYd2Pn1vZx7hquL4SLgamtEvDmRvnGrD?=
 =?us-ascii?Q?dH1ULeN7ku+iA/I5GZ4vIuXyZQRhvNwEj2jdBeyUgC9x/w8oPOQR7GxT98en?=
 =?us-ascii?Q?MUiRFixoZE6PTUAAsBy4NsD3k0RkHfHHglDBqwGELSRA8f4tWU8//DgJdB8k?=
 =?us-ascii?Q?Q2cWXW/NiRcOCYhU33jBHirU9Nsx//mtLTOUD0pdFi19vcJsKYtVrKBuE+EB?=
 =?us-ascii?Q?BVoQdSHvOPldAgd9Ps0FZSeQHCQ56Bj0qC52+bY7yBYvAoKJ0kRZmZaw9f5l?=
 =?us-ascii?Q?4Ay5qJkvomhcl8dvnTxUFo5zPrpSRKC5bMKDNPATqOPI03DROXWFJYdHYZhx?=
 =?us-ascii?Q?YV7Yad3QMKRBPorTPJC2g4UfQjuz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ilm+yTQQlCCVJDIfGfCIocPb/VyNqPmtti7ex9fA/IQZjCaN4st+EdSqE9C8?=
 =?us-ascii?Q?jebmAyXDBgKaJ1GRch0ehHwcCO9C+7X+K9jEXC9MAwgLoibhafoD+cvahXUX?=
 =?us-ascii?Q?K0P2THqOTmVSZlxCqDvexacOM2qY+wZHMRFGqoDD/Bh8vUdXeoHhAd7X3Od1?=
 =?us-ascii?Q?J0ZrqPGD22GQjJCAneWi6JY6RVTspTeeTZ0VWYNjpXhXVlNkglXGXBiJ6FHT?=
 =?us-ascii?Q?211g7DTLSL5XaYKK5Q3rrwrzbWHBB5FY3Y/6vjvawZAcCn4Gd5/2W9wzJoDu?=
 =?us-ascii?Q?x1J/FTtZNAVpagndfu3ErJbBIcTS5V+Bamc1LTWhpezmCmPMbDdej5xJxSy3?=
 =?us-ascii?Q?MAeiGHm+pPBZSNa62VlZe40KMgGtKuoZVPDQ2uwUwxa56lPtcxzjgzjbpIS0?=
 =?us-ascii?Q?5W+ayVvG9DzCQy2txmrxlmvsIGD/jkyU2krIU23JnQWqOmlrdKi4s8VAJX6m?=
 =?us-ascii?Q?gVzcMqbmFrImQwiCWI+ZRrxC3ukhk12XAQGwlxILBNWZ8FOp4Nt/xI7+UP6b?=
 =?us-ascii?Q?jXdTnhNAuy2xsE4Usq8uvbSrLMKvctvHlhjjDikmCh2dqFUoLqXjdEya10VX?=
 =?us-ascii?Q?vSn3DplKmxXsZrpFU6czxCXBCfe23OulEZZN+/pPZiYX+ubD3kq+Twy8S9O4?=
 =?us-ascii?Q?vzYhsHQy1Fu9JHx0STjl8Jtdi+KcCRejPPHfb+tahbAzM0dbnntcEZlRFf4F?=
 =?us-ascii?Q?nHfcNKhJ7899RYL5oD5JTj9ISLeg5n+SnGvC0qMhziQKXu+igPSkT4+NxYw/?=
 =?us-ascii?Q?NZO+jOPY5Wk1XbbidpZoTz8uUxytnks5UoYsHoRbUFMepCgPV6+fqSZxVEel?=
 =?us-ascii?Q?PQPM+32vXCNI6yWh4Z+0TenG5vSMHoKTIJ24Vjrvhj9evcWGcAGUGPNgmj3Y?=
 =?us-ascii?Q?yfulHJxlPTYYoZfZXbTA+mVMoSmUgORDcxdmsBm9YxIEDxc00KlfuYd3Wodr?=
 =?us-ascii?Q?LR0jJL7R4GZOubT7Sunmi5UX1d+G7qNMPCbZoUEN1zOk+NaDF36qVKaSLiP4?=
 =?us-ascii?Q?g372JLsTqCbniTYwULIfGqF/vdsjosjck2jr/o0ZvPEIlBhv2ysbtDnqCPK4?=
 =?us-ascii?Q?ssfYPRLtEpEhCkSgsve4BiNaOovQriKaoGxsGlhtzpxT4LtvDiBvDl3mIOYg?=
 =?us-ascii?Q?0MuGh860nvJcL8E4151N9qQD+Fypvmvx5QpvgcI6QGZDEhWl6Zg9pqCvRRTy?=
 =?us-ascii?Q?OmrO2k4mzydyDgfUCNIrxz3QKJ80WokO4St4SeSVMjbttF3rNtQyG40O3C3X?=
 =?us-ascii?Q?DCyGwcdKpetqdvYwQh9tbLUdWdf9byiUBtxP1YH/OEUcqrblrb7nJqbWhokd?=
 =?us-ascii?Q?ZFyBq/eYPh9RI3Se4Yxh4F1HDHRdF781OjJLfK3EQICRpsixH59phWzhnc3T?=
 =?us-ascii?Q?y6dXbSs16Qe3ngzfA4kJFG06yBVofCXy6B3y/nV28LgtPFm1hUxEIclFm7eX?=
 =?us-ascii?Q?Ab21ccg+euXTHQRSA8T9PBCxZVWaGqwXtXAaimBL3CvGSPYg0bAxt04p7mUI?=
 =?us-ascii?Q?nHRU8bQ4wA6u1f7dtjFPRl2pLdn6RB7Mli//q0yPG5Usoe8SpdbboY+bdk36?=
 =?us-ascii?Q?5jAjFjqBtlTVqynapsBznj0qjccJLXK9G8Nvn2jm7w0GHNh0F4NhRpRD5j8e?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 537774d4-1132-4e1e-c66a-08dd5bc5f435
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 09:13:12.1563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lz6lDRdteXi3F9IH38Yb5XwAARhcQmhiiDxhxt3tkIVFPYmLW5MitPyfP9uZzITDN6adfkL8Xs9sjp6fHUFMtacw6OvO+yRysEH1zsntGPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8855
X-OriginatorOrg: intel.com
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

On Tue, Mar 04, 2025 at 01:53:18PM -0800, Andre Muezerie wrote:
> The mechanism used to initialize an __m128i data type in rte_thash.h is
> non-portable and MSVC does not like it. It clearly is not doing what
> is desired:
> 
> ..\lib\hash\rte_thash.h(38): warning C4305: 'initializing':
>     truncation from 'unsigned __int64' to 'char'
> ..\lib\hash\rte_thash.h(38): warning C4305: 'initializing':
>     truncation from 'unsigned __int64' to 'char'
> 
> A more portable approach is to use compiler intrinsics to perform the
> initialization. This patch uses a single compiler intrinsic to
> initialize the data.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/hash/rte_thash.h | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
Much simpler fix, thanks.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
