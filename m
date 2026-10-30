Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB0E606A32E
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=getBlvse
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF92F40DD2;
	Fri, 30 Oct 2026 18:58:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTPS id B126540288;
 Fri, 30 Oct 2026 18:58:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793383131; x=1824919131;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ZBIp949kMNQ9HPSPqYlxmy2StWF3KejFJXPsU1kjQIY=;
 b=getBlvseWnHYKQ7dhYTMIv2RjKU2rbjnPVnXUlh8kW+PN9ssJMGO2i4o
 k1lkcVRs+sCEDqY1CchkX5p4ovEvKQwr4TC/7i+Spy8q1ColMyRh00EHb
 SFHndXs9Sl7MB+vvfO2jHpdOAxsrpKz+/9Y36gkjXenDYRJL3UvBcra72
 u08b9jRDd16Bp/1bI5JJMZkDWIPGFzhGLgLiXGIi9C1/FQc0wDtNME5ir
 WU4d43ECmTlE5Ttz5aUTBWIh3EhT77M88ysFxvQMMrZP5ROXPUiqI+rD2
 iIglkOBU+V5mwtOhp/C79YfZsShO/QlWU/1MSmYH5/FkA0TOpFzacXcLY w==;
X-CSE-ConnectionGUID: ItahCzRiR7i/NzrSjTkrUQ==
X-CSE-MsgGUID: 5Dk5/ZjGRv6Bn1mA9bShhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2156739"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2156739"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 10:58:48 -0700
X-CSE-ConnectionGUID: 8nCiCUMyRqigzHIVXmgXbg==
X-CSE-MsgGUID: 43zYPE2MQIuf/y+M3dqc3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5376332"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 10:58:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:58:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 10:58:47 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:58:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrlXL0DWdKsGQlcl1IBwYKCJ16uM6QaZ8VOo+quqTFPBRz7l2BfBLds3nHtdLN9JkevVuw+MDzpT7+vlYZ6jEOORe6lLSyEpsJySfWrBFe1+wWKq1oDF71xgD+LrWL5bUZh0sem4qL+sWarWN4bjPjrk5X7K0rUg13FtvYfEV1E3msppMX4nGZB7o5EuVFKBXnRV4+KjYE66DtN0Jy0AqSx6JEH5gQqhuGh83Wwg71RiViFF87wzqFjcThPlh2MXQLzIZbAjuK0rwKCX4lNq8ZjnIGWUHCIipiFbK/x4Y+wtHgRxB+C+b1xs6VRjTQ4L46PV+9VQ3OuOHuZc/rL1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtmEdHiu7RlMZaafssDaTi5TOa1nHswSfoUNoGk4HlY=;
 b=oVRHlhSjiDI09jbjqrMPqFXbQzo74PJBDFyLbgzQP59EozxhyraZ3rSU0XcoqXqAMjDK/luKMeZ/jsVsTRyOY7d+19zc+6d1dSr5ltQlEj/PQLY6w8TAHeNSietzqM7Q0tfnKjShOHyYJRUjAvtwNhQurL4wv3AAT+CLlp3RwW2Mw51hrrxLMH/HhiDaEMCiL+nRGAexBxLvsx1nu0gYAe8UeUQDL6iqfyfOCgTjjfuS7iC6XqQao8prX+QUnZ+1FoOYKPc1+QYAKbmdejZ0JUnyHdKjt2zqaGnyGje2Yjdw/PERUeelyXTxg6f5FHZVQckXXu25OQvkLfbLRYx6LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA3PR11MB953716.namprd11.prod.outlook.com (2603:10b6:806:536::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:56:44 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Fri, 30 Oct 2026
 17:56:44 +0000
Date: Fri, 30 Oct 2026 17:56:38 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <rajesh3.kumar@intel.com>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>, <dawid.wesierski@intel.com>,
 <marek.kasiewicz@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v1] net/ice: fix read clock to use PHC hardware time
Message-ID: <auTaVrYucWhWC14M@bricha3-mobl1.ger.corp.intel.com>
References: <20261030143842.2745225-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261030143842.2745225-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DB9PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::19) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA3PR11MB953716:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fbf759-a98f-4698-b3fb-08df36af289a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|56012099006|11063799006|261009223027099003|261021135927099003|261022075727099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: KmjAFV9CCgah38Ny31j4nCoMQxkYtUJyHwYam1+m5zG1xO9ORxajpttpd3M+1lWIsaU7lECTZwZStRPx2qxH4r0nta6Ih8JYYCqtiAwWcYBdA8G9XgP/WESnXwiWGpi9NiTA8Ax1vm6lWkOB+js7r5yKLE9IPSId9Z3GmlgCJyjFyPHdSHqOfQxyGu26NBZSbCzrnaV3LvrJeshhf8ZsK4+162nSzbW7ehSjg9c3oY4A39x76Id0cNeN2J5xW89uIaD9YL0m6FewAoYGRLKOQhqucDedPbGNP1yRNjlncAv+Q7lNmVh8Vx2QHukvIAOru1w6NXnLvR+HE8tf+y+8CXCiV3U9bEQSUkbFic4i06M6dswm02Z+AjRIrX0VvD5s4CGy9w8qQP4ugIQWfaMz84SUT+uo0wbYlS39Qq+QZdjSFTzW4rd4pgfflWxftZQBr5AlIMVXveAZavtJzcld6aHwkGZILRvHWzLQOd5qG1W10Ltyk6KetffY2Rq/T84bIgIUa4Bn0/MXTSJPOvNSGKF+zO3i8203xW+8YXS4Ot4ZCpMa4Y0BvZKttzX5FMQSzEjir7D0S4f/qg3FC59NgZjJGktMqGYdJ8mtE51JW5huV/maSYc7HHalkRJ0/iVvc7HQWREUawf5gr7i6UtNNDIJja9eU8Chu64F+6CfMLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(261009223027099003)(261021135927099003)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RKdBugRIoCzILFW5DrEUuIsehZCsEZxPq9gdZ5AR6cz0JHTMU5ikLGlgNxfS?=
 =?us-ascii?Q?1XANzXpXt/e6wvkkpPnWdsYcwFugC7fPfcI1LIcO1a1UC6TureiZxNf1tL22?=
 =?us-ascii?Q?z1O4UDNVn3AsC5Sio0pDjsB+rEzD7zkHs81CiqedytlfJ5UW2BHQe2m2keoO?=
 =?us-ascii?Q?CFIZkK1UyGjk+iUUToy8UThxzz6FgZDYij8HEw6/YzWEAaBKIYuliJkuanrm?=
 =?us-ascii?Q?g+pbvaot3OsmaQdvLgeJ8gCQC6tiPETiCQJfXlt5opL+AO1cd56eoCDA4pFN?=
 =?us-ascii?Q?dG2JfTYsTt/P9zysNkalL4Eywb82N6kglfxRQX7up7h1hDkZks8mJdj8sTfW?=
 =?us-ascii?Q?br9u9fWBKaKn3cNZfnLmJVORdCO2QQ+ziOqAB+ExfGSDC0H2IFlS69q6z+Vm?=
 =?us-ascii?Q?W7d9py7Tp2TSZGDWs+okEBlT29684yn15cfVF5GC3j4gaOlWKD8HxaO0Ok9Z?=
 =?us-ascii?Q?gRk6Ouif2X9PNBpurKuESClCr7v7edeLE5KpRqAm9D8k+JcHHygkEv6HZ3b/?=
 =?us-ascii?Q?DnEqyuBHWJx/zA2Ksn06JKuxEO8/gwvTW4L8LxZaxFDKCN7LEzba6eAdaudH?=
 =?us-ascii?Q?QcmBd+3DgCll4K33LZQQFHPGPqy4B2LxrQVgSOqAEBo++L//BO44cs5nx3B3?=
 =?us-ascii?Q?xmc5IqqNJUsw2uilrgnY7GmkaBWdNRn/LRs+Og9jNvoUDRy1ahpxadCjddak?=
 =?us-ascii?Q?Dvpcwf+XeN+Aaxe0QBfpz6D4sPku9FlLX1eIITBI0x9nSt+cb8EmXmhBlakp?=
 =?us-ascii?Q?+1n9cjkRvf/Tm6W7P3mC1t+et3LrRBV7woS6i8mbalsWyqdE4RgSqxF+SsQv?=
 =?us-ascii?Q?mtVEVIr+hG27l678CeDMm0uydDY2VpS0RM9XQcwRX/snUubpbDk5ZZzJyGAm?=
 =?us-ascii?Q?xOe+05k5dYiirnd3b09VAH/JeNi7I6j6PCH29Ei441ntcx5XLnh/1YJ9PR3W?=
 =?us-ascii?Q?PU2BIw5d14dpDwH3u0AT9rWrX9ekFucExTN7xgoUM9woHEElVPzPEpsm1pNP?=
 =?us-ascii?Q?UGHJaFsVopD4Qav5AZN5CesPfKg4PAclvdhI0NSAG4hdZGZcLfsh4t8T/qZ8?=
 =?us-ascii?Q?Nz1tA0E21Awqz+anQjl1goGRqKJYhPDv6Ocgznv3VgORpZ/dUTQ67VS6LiAF?=
 =?us-ascii?Q?fSHsf0UYVww6hzyjMoZoyeKhbV9xvdI1r+Tghzff7VX2NG2HAEhZT77x4ceR?=
 =?us-ascii?Q?Ln8e15PbBOPnnCOOyurhPb2usmF4kfkS+vg60vualjU8kezpr+tAlhYO6qkK?=
 =?us-ascii?Q?sVCbyY7JH5mZ0vyLDimt2a6U7T23hLbzMYjhEEDNW2NKXM1bOyydjWe4SGF8?=
 =?us-ascii?Q?BhbT6X/Zk3RKuB0zC/yfggQOvBmyjvh+Erih0myuUnZ9exSPf63AGPcm6SNN?=
 =?us-ascii?Q?inFfFSolaDs2COEtlLSJYAOTAljhJTWivc/F7YTmvXIj63AgVZ81Bm8CVv1g?=
 =?us-ascii?Q?xYqQj4Dn1h+D4JTAPRKpYVb7ZdoVgaUIntj+BRAHbiq9GX/NtK0z0MK+KRM2?=
 =?us-ascii?Q?DjFhFxDy871DdIjOAG7/vG5JMOnCHPlJf/wqXgpC3xrSlrsTT8UPVBRFEZIj?=
 =?us-ascii?Q?eoaJF7BC2w727e8e+Zvnw43JbdX3qFx4LLaOKxh7nXwbHT/0AnO+g9DuuXik?=
 =?us-ascii?Q?VwQjIol7VZyPKnWuXbyNMXI7SwQ5ee/yXXT53L24p2OotNc9PyN8i//HZZa3?=
 =?us-ascii?Q?QPpRk8A5gWvRepOR0Pz73MmBcEELXNIg+bkWdXTKo72irMzE5XeqS6mee4KI?=
 =?us-ascii?Q?VwJ+cNMnmZc304fDRJsbBtnLOgI8PvA=3D?=
X-Exchange-RoutingPolicyChecked: CqYTZ3pxe5sHM6RqI2+C51kkr9BIT7hSBZ3xVpFh3lmimaxDOnfMPaYKkBNFcpjigJpjMp62oo//H0b8tPmcX7hxjAfZs/2oMAtf/Wq0ijCW11iVonl6f94c1zoiMLGjxG/3XHROFRfGWudAQQQJ+WhzpYZ1nMGLup42Pr+k7ZqX1oLTZ8KECpA0JMgbiKoAef9KPej4nOnacu9EcDtxd5LVUIDBsNP03PmCSNT8ZwM/5J5Wg2jy//DCMjYKCMuVNF8MlSCOIUz2jzbRIkDrmK+mt/adjf4nEgAo/YZsYEYqmkksf3pyCz/qtLCIILWIqt78lf2uCWD2ZBvpCN4fsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fbf759-a98f-4698-b3fb-08df36af289a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:56:43.9378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxAt+4xRETmwrvM2hoESHWFYsRrOBDvf4UQ31md/9UUJ5Y9urq+M9oDP7MWY6d5qR28w/9i7ADXnmLAw1Pkk70BPYaWzdh7VEd3UUJcxEUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB953716
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 08:08:42PM +0530, Soumyadeep Hore wrote:
> The ice_read_clock() function was incorrectly using clock_gettime()
> with CLOCK_MONOTONIC_RAW to return system time instead of the actual
> hardware PHC time. This caused txtime scheduling to use a completely
> different time base than the PHC, resulting in all scheduled timestamps
> being interpreted as past time by the hardware.
> 
> Replace the system clock read with ice_timesync_read_time() which reads
> the actual PHC register value, ensuring the application can compute
> correct future timestamps relative to the hardware clock.
> 
> Fixes: 327fe144ca39 ("net/ice: support clock read")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Patch applied to dpdk-next-net-intel
Thanks,
/Bruce
