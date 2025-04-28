Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04D3C3ABA4
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 15:14:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4117402A9;
	Mon, 28 Apr 2025 17:14:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id B2C274021F;
 Mon, 28 Apr 2025 17:14:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745853279; x=1777389279;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+K9Q5oGfnRvfGEUo5YTVJD1sU18oda1tIpdC5xBGt7Y=;
 b=Fm4MjyBbvBP3U+BnZAZMOVacWTAEpR9aN8Ce7UHEWInNnbXqYcrai3Zv
 /5JM7Rq7HcCQYmbc62NC16EAAvsZhlAYKSZqAb8zEOBsn2bDnZaqnGysk
 VhQtwQoFHwln0nX7ze+G/I1vUPxWWOebQ1LoiF8HPrBUMwv0CTZFy5OSh
 /khNnooElDMs6OnMezsa1EcIhYtTYwxaxw9JdohpUBlq5A0XbLkvlBEPA
 W3UCXS8nfggKtIR3XE4vBm7Jz2uo8mARlV22uFH/wSsFeg0Vy8CN3E1/l
 2XxvSOpx4SsONu1VrdLYDWPgS04viVKPc6/d/YH7uYs1zAPo4jp5rjRQb w==;
X-CSE-ConnectionGUID: DiQ2NgR0QAaE32am8gb/gQ==
X-CSE-MsgGUID: lkuTt9SpSYWZA1dotcwYSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="47609084"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="47609084"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 08:14:36 -0700
X-CSE-ConnectionGUID: MBE8JEYqRNifCpjRktMHMQ==
X-CSE-MsgGUID: O1pAkZuoQWymCdstn6zXsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="138548508"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 08:14:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 08:14:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 08:14:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 08:14:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUxTjZXhsklMw9Yce+JPfdw9LEytHUAIwdamUPhod+D7bKipzvAlkr7meONTt1dTsfwCVv2DI/HlgEt69PK6L/cPXbYVHZhgzLXJP/ZQaTMXj56QyjDv6nAis5Br7y+2ZEK/rerFyd58gsmWQ1X6Gutm4yO87vDpfuqLWtyN1y9if7MKDpChr44WC9IaLJoh3DbCL3+G6roV6zjyA+fwHAFoCopyagkbTx/dLmvxz94XF0k9GmwwxT4m4CpmgOfr8DONl3GrakBYDPVwDlRdrOEA5fsslQG+qsXR4+nmKjjAzcWqrZi4bAZ8LdNrvC0rTBera4tWXitm5Km3o24IPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4q+JOFcW8p0AlR69Fzr/9ocrlJZOfuMT1i9ghhSweY=;
 b=NBDUJVNm03JAX1kkvpAkOqvOZPRP+bPlQXVzsPpgFWCWoDEwID/DDEwqQdo72hJNAHeTo9EKqnee5HuRuVlVX7PYzJol3NNh6kE1m+U9EHfecoPl+IyEfQ+ajq9ktgK1BdF1xgIBndxCNlChdyqpFRvSxsc9OGfMCL/qPjJbgEqXthRWTBOToo2C2TM8RndZJxIVf/HTKaA+/x5343wmWtNxOWflg+Pn04AIZPrnO7KEX6/V/zHTcnMeZNJnrVdB/CVLc0EYXnBWydI65LKiRvcQ4RHoaLkhpjmgf92eWQRT6iKetznV9rXgRlKiU5jZneghdJwPWIS6reH9ExW7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8830.namprd11.prod.outlook.com (2603:10b6:208:599::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Mon, 28 Apr
 2025 15:14:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 15:14:30 +0000
Date: Mon, 28 Apr 2025 16:14:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kaiwen Deng <kaiwenx.deng@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Harry van Haaren
 <harry.van.haaren@intel.com>, Maryam Tahhan <mtahhan@redhat.com>, Alvin Zhang
 <alvinx.zhang@intel.com>, Ferruh Yigit <ferruh.yigit@intel.com>
Subject: Re: [PATCH] net/intel: fix xstats name
Message-ID: <aA-bUO2AvgE_M2_6@bricha3-mobl1.ger.corp.intel.com>
References: <20250410055246.809646-1-kaiwenx.deng@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250410055246.809646-1-kaiwenx.deng@intel.com>
X-ClientProxiedBy: DUZPR01CA0166.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: e4eb1eee-cac0-4920-35f9-08dd86675fce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IncnqLw/bt56vezjd4Ej77dCMoUPUylzu+UICthP0epI/a3wzAM3JmADuO/r?=
 =?us-ascii?Q?8bqhKzkybIkZDXtGFxYMIDuGnSMRDzD9OiZ3oaRMs9NSiFbBVhoC+56CQQs5?=
 =?us-ascii?Q?p4atIisFiy8hdtsqjsla2L0tnwBu7aHwy401opfNJm/eW5X0G+DwSOqtEHFT?=
 =?us-ascii?Q?tjKoVnfF1bvRDrfYZ7uhCqG5DRNNNF7EoD6b36PLpIi0YhC5wYcUsUBE80ij?=
 =?us-ascii?Q?R6Xera7GoDHk2X61LrVJGpdIAWMinbjP9a+1Atjd2dup1dZutADupvN41Vi/?=
 =?us-ascii?Q?IrrHDE/lPmUNTz86lcOVd2CFDsjGplzo51MxE4JAwSZulmV+Mc6PbERrV4K7?=
 =?us-ascii?Q?NmSDoH04vEgEvFfNNJihyb0eV+k7+ZeviCd3R5Lvd938aU5iglI/D+2NBVdB?=
 =?us-ascii?Q?CpDhEXAzUt6ewO1+0j2YgHhfE9Ac9/BQ5TdBI2CsWVwOA57xiZFO4hG8t/m0?=
 =?us-ascii?Q?eC/cRBPH2hx8C65kSbAXMwkrU/UbjHVDNDnDA+5mtJFHQp3v8CVvyMLazsl7?=
 =?us-ascii?Q?lOF/x3AlJvYXm9Ho3mxK4NLgKpZxNVDmIMeyUhj6rbrrM6Ng8CT/sqdL/6cV?=
 =?us-ascii?Q?xvNR0Ao7jGxtBv6ZN0EFvOqYTG4ZpD4aQJtDGiw65ScWqRIZizugdyaZPkLa?=
 =?us-ascii?Q?H9/4liNMxBVZSooCtHmmXUwbLoBCoUA+PD+sx7etehyDwBoV/dCeyo2T85PB?=
 =?us-ascii?Q?frDpebEi+mT008PP7kzKo3FriT/BTmSS+ZlfO9EiQ5PjyK4MLYjn+TK8cF7k?=
 =?us-ascii?Q?YxJejbTXyToSr1SdqHjfJNwkj0WE7JPwvmVZNEXYuJPiPGcAxxlxvp4cdY7i?=
 =?us-ascii?Q?BZ7O6Y8T1Q3YC8kSPoYpz8jafSMw4H2rvVVeVv7fGq3Ap+K3Fs/D+FFGtL4k?=
 =?us-ascii?Q?GQNg5TZvWGYrPTZVpp1QZYS9sqpRiedV1BvR3CkVp2Ar5fSWPjLhWmD8yd6v?=
 =?us-ascii?Q?wetkNoiveTIBoi2oAP0ZjvhoIcKk0BIUO3KVa+5JfTAGnyF2S1GGO+b0HPzm?=
 =?us-ascii?Q?oO5XjlT9U/O+boYwVsDKnCj5yKgUQgsRLRtebLXrOZSB/1r4UZ4B+0ALUu0C?=
 =?us-ascii?Q?m9p8UjS3T+NYfFcs8sZkU/kWDHAv9FVncOzfZ8w8gr3vLaEoYqXm02nFpd11?=
 =?us-ascii?Q?9s6JllFnD7sF88Huu6ON+P0JN4NtQ+Dvj1hsE2yvrfzRdnK7KbpRVkcUbgHb?=
 =?us-ascii?Q?rN1cDi2Lveejr4oalloOx3LiN/CYYC0CAyP7AMKYVes0MEYFGAPlNJ0rLh/j?=
 =?us-ascii?Q?vnXTykGJwdm4LDQ50EWcGupRgX8zXFwQkgO3deHJJGByJmjfseJ9SIy7x9Kw?=
 =?us-ascii?Q?ZuwiXO0t7OKYZ8PMySm/9YYvyDmt9v1dxX/3RaE7k1noWjaqfcMSo+Ps2sWZ?=
 =?us-ascii?Q?K6444P5BUkawhusMFQtfOkOCw2qyqIintYp5R9DYz3gQT7IRawKlm7sIrCZZ?=
 =?us-ascii?Q?e3THhwITn0w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T2vDarDhlFU11trEm9On19FhIQi0kp71cUM9ADAblpPJZSoR8aDuQHGLhIgT?=
 =?us-ascii?Q?J5Oj9d5TnZ9PvmB94NvYk0zOgF9fpyjl1cZ8ayNzAnKLqoCBRfTZZPwxwLHP?=
 =?us-ascii?Q?WrEHogOiCuz+11BsXMR3UaybKD7MJJnqJlffwyoXG+GydwAe4JE2SzMLFbVc?=
 =?us-ascii?Q?jILW13fuORs1RRAaCbzbtQXSgkuZAwvGicfcKxxPjoD3cFjphX5XKqT9lSCK?=
 =?us-ascii?Q?11tHtYVSgQhtDNSUouGioKNPcaUNqMeC2Pa0Bm6ojW2pZ3JDDATYpzc8iwBn?=
 =?us-ascii?Q?hBo/dDWZVNWqW2ZQN21/TqTl8VvB0CinfiClQEl9Rri1/hJg3Qd78BJwn58G?=
 =?us-ascii?Q?uuXXAvqZlplLrfiGdpdzQzvuVRRcPXTQvLY2WNayrrYJ3L7hBDMFM0WLlutg?=
 =?us-ascii?Q?9Z1vZ5X7/pQUk0NDejy4R6kmVl6N1TWmlIAhp+ttrvBZJRv6UkU/BbSyex23?=
 =?us-ascii?Q?pEvTytzI0yyMdN6pLgOsgpjhcADCo1p2D+dJEjOCISTJTUcDmfZi0yMb0XV5?=
 =?us-ascii?Q?FXFK6v9L9e4vGl31Kit8HNKxHLXUYbflAxJ35Tt4S1EtzVB6hkBqkii8ViTu?=
 =?us-ascii?Q?FuEcy1/9D+CxT8vxA88MiGyvrRh89m8lI1CtQMqFFq6+zz2Zwa52+YoldUvf?=
 =?us-ascii?Q?TGbE5TejzgmupTiJh2EPtBVSDZyGABsjsJ5UCNSCKW89p7SptgiPp82iCcqV?=
 =?us-ascii?Q?sohs0Lbb5MJ4TlnFMbFLRHia9kp3TNGqeyogeUVQH2j+c/Da1osE3OQtl+he?=
 =?us-ascii?Q?odRWeaHVkwH0oFMs6hu0bOmYfkBO1EyvTI3ooL9O1g7acUdPiRPpdBm8nA6I?=
 =?us-ascii?Q?wU13FFvIa9ly2w1sA1KB2bCMnI/T4Hprvjb/vBhwCWAyiT/5arvfUUSQd8WJ?=
 =?us-ascii?Q?BtukQxyTUxPqCiirPBTCG6VAO5nOvG8cmkTawWXvybgP0QSpZtTK4s44kVeR?=
 =?us-ascii?Q?KOeiM9+/buw6v/QkkLVGHbPihzTfCGwncO2GNmlzd6ojPaji5/CI1yDtLFMm?=
 =?us-ascii?Q?LVzeZuLUXRDBs8HtcJsaaD9dEedt8VHkFRTAeYBpUGrCUIBFMNmuLzxZ/Zr/?=
 =?us-ascii?Q?CUi7hZkQMejRpjruDSNsAijXPwk7Wgja+sgZT13Nkd4CJ1IU63KnHsYtOuOK?=
 =?us-ascii?Q?ykC02dEu/heCpMyJVRcLc3EOWXJUP7wQHekGbVHdou12iwJwreSELxyNRN5E?=
 =?us-ascii?Q?dMxvlHCHqqOnGOtmtf5rYlyNpN7CgzYnidAsWRHOYCBcBykZQMMyYnEzVnVB?=
 =?us-ascii?Q?8bYkVHQ2/vC35RWBlT80Eh4Mvb4CzIOsDJXc6NO6nx6GN7/aYwLLLAo/fRF5?=
 =?us-ascii?Q?QkEjX/2TPGTzE2cvWjxiSSg6kf5aB7x1gBNPHAz8CMmE9UyfK1BhmrcoY8lP?=
 =?us-ascii?Q?yYYMilSkxV2nGYABh4DZ7xx0TXWVhx6uYtEbDiTjA2GPHKr7a3Imz6atFBb+?=
 =?us-ascii?Q?bZubspyQW5LdTB6tmfmmbJgc0Co/zHFDd4F1NwhsEloYSPeSwHFz6a6RB38X?=
 =?us-ascii?Q?CiPkc8Y+A/UanlQINGNRXSkUQdnaGwfOaNWV2pePtVjA5M14bDirgrk2+YQ3?=
 =?us-ascii?Q?eorBG9rcarUolnWDl8JwYDR1L3RoOHoYmX5aeTaodwFKTW4wMUQquymB/e3r?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4eb1eee-cac0-4920-35f9-08dd86675fce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:14:30.5322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+a6ISvjKjx+FsAUWFvqXNQR2tH8CYcZf8zA0XYXEjpwKWMgt51aGb+JMUP+koa+shvpgY6u8kWflZfhYgx8AUSWOcoRUBaUpbjG6EHiZYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8830
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

On Thu, Apr 10, 2025 at 01:52:46PM +0800, Kaiwen Deng wrote:
> The igb and igc xstats name need to be changed correctly.
> tx_size_1023_to_max_packets should be tx_size_1024_to_max_packets.
> 
> Fixes: 38552317dcef ("igb: add extended stats")
> Fixes: e6defdfddc3b ("net/igc: enable statistics")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce

