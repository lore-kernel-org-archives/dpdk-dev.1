Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCB3F89251
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 10:49:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 396C34029D;
	Tue, 21 Apr 2026 12:49:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4B7654027C
 for <dev@dpdk.org>; Tue, 21 Apr 2026 12:49:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776768573; x=1808304573;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tc/cFO9tAeA7f1LAhPHxEQ/xmcuwj/FI9OAyMxlVLHs=;
 b=FJD29gzyakfFSb9mquZI9nKpfAVS2vMDJLCGozI2synCHwumvcSJrZ2Z
 L4vWvz6U30VSe9M/3qomgXVtRhHs8GXKqRmCB9sCN5q9lGFtApzw9SQpO
 0OUbpiCy4q68Neo7oV4Dh4zFPfRarrOUFiv6WZKlXb9sqdDm0yB21pU4z
 SC/vvATGE9oJoJ6khBz3UGKFBgk4200aanD5j5S4ZVTo1HNItjPCccdHu
 DOu1r6dabBl6YY4WUliwSh0kcGeC6WbSiQpev0Xtn2M+TdocYfs8VakOM
 d6C8Hi6VaHR3MOV4jXNcXH3sYeXS8qZiMMEI03v36sygJLZ13WLFHEkAm A==;
X-CSE-ConnectionGUID: lhZx8zVYQRyw2fIfJLCA6w==
X-CSE-MsgGUID: dZsxEC92SE20f85SNKEd3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77768121"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="77768121"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 03:49:32 -0700
X-CSE-ConnectionGUID: ZTolyaqBSiK0G03vOzuKOg==
X-CSE-MsgGUID: IwIxrAD/REyS9QT/yZGdJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="227368475"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 03:49:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 03:49:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 03:49:32 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.17)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 03:49:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOW7TmTzQiHgB6659tmzKTqVybDZh9FyxVWgSnCrvtqqREzASBkjKwnWJqfjPhoFYyr53G9A1wGTpuvbZIjXaqufU2/CI1ICOaQ6qkvGprcrWwQj7F1a6UnXMYDTxakVTZvxl3XlZnqcrAwpohNE2+0MGvzJgRnnEgkGeuH3gMqZd9fH4ySHlW3pbYUq/SfIqcFvvXHrvWePVyw1NKTml4Ta7v+jJUVt3TuB9Z6pI2tFHGxfnoIWC1wWSebPtDzGiS92XFOLoiDiBoPSV1YhRTyT2Im9l7KfSmadlze4yIjQjM+SswwDllb2rBcKm+qV4O0lt6GYxjr0GyY1+tm7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpxVSerwAO/q23bAaBWmYqP8TnYluZ4kAJoWmxZqto0=;
 b=k96aNSMZq3yf8q0fKTlvRKHcOUml/LbV6Jo+qitvk9JzUnLvpswuXxkXOATZqEQJ7cOHdORYDvxoqEKIfdMdQDlmM068jSZCo/kbApI/zwT9wvKLpLCXLbPrkha1OMzkEitrg36EKsjonzRjaSAVbkCEHEGtCr1bZRe4kB5+N8OKPCvH4DO9g7n9tzqRf1opt8GgG1BwoJ6Cw73UQzXC9+3i5ELmYHo3vKG9P3zsWhtnkhpXldrcbZRlbRPm/xODSYaqB0GUiKO1GCO5JVhsVx3byyYWrPciG1PVRXM3lX8wd9K24kRVP5/JoFH4gsnvGQHJPAxyRhuvGuc40xKBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7214.namprd11.prod.outlook.com (2603:10b6:8:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:49:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 10:49:28 +0000
Date: Tue, 21 Apr 2026 11:49:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <manoj.kumar.subbarao@intel.com>, <aman.deep.singh@intel.com>,
 <dev@dpdk.org>, <rajesh3.kumar@intel.com>
Subject: Re: [PATCH v2] net/idpf: harden PTP frequency adjustment
Message-ID: <aedWMyQzJ7As4YL5@bricha3-mobl1.ger.corp.intel.com>
References: <20260312184344.1475052-1-soumyadeep.hore@intel.com>
 <20260407200405.1568940-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260407200405.1568940-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DB3PR06CA0028.eurprd06.prod.outlook.com (2603:10a6:8:1::41)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: b8484afb-0956-41bd-bd2f-08de9f93a958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: JCCr7W7YoAisiD2ectqEzbdHpSFVnVb10ktNHLQB5K0QFZ4pT9m9aNnD/P20W/ayx+If6296lK8oKIstZ+JHy86ldpQN8F/jEm+y4+Dm5Ru5R9/qX/bwDMpxPVXgqNvNKwfLDczcv8nhScTjSN7hrJmtKxFLfgl952ii+VEehk/HLXaqp+/BvP9KwOt1KXmKMyGIBapwB1tf8IFsKcw9GrsEia3kSh1SHw3Zm5WsbUpDMMIlIg951Nm3B1yPjLTKktYxue6dyQncglrJ1mynNdnUY2fMi+K+gJ6BPdvnV+0mPYQkot6mHeUkwff4FPLtp1jwNFsx2T3YGQB18XmhW94Fr1T9EP+FJZMFF1kZqAFH2W1PB2iZzxuxiThr5N4Qv27U3eEVoXVFh26nCAFL37VOXs8g+Fpq8OybGmzOCPlF3j3a/FIpAZ7JTQ51Y2Dht9M0fwXXlhZTM8h+DuJmVuwVFm02bETbzTKnoIlaV/4C9y1BWhrtLJQuQGJGBIQI+b39dKkydnLols/85hkOXIji56aY6B06IFJOCC/6lfQOH/ZqWdpNQQWrvTdFoOo+fz1kvYFOMg8Q8GrZeqyzOkBk6ZSYOf12gl6N2m4XzYYOlaXYqs48UEJCGPB9ZvRLqFYucOT4TBVmYlPm+NM1JY2+F15suAeutcFDjb++P7qIdqcEH9nmg5ebBhd5bgFpYOC+55v1DsUC1NrRROW/xzO2GVOeHySh0JGaWnlm9sw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EGRtA7LeVMo/N3+wkzEh3G3wBZlI2No+Z7DQkzty7UlNUKiIXu67Ni7CMCo2?=
 =?us-ascii?Q?OXkh0Qs6RqneBk+6EazJnl00oKgD2yvzULcoW+XnU47Id002Eznp3+pmPaxC?=
 =?us-ascii?Q?kOXIMODZBt7e9DuMGnmm7QcoWfdzd1XsHMwwSg1BFQdwb3mXno0Cdxbwm8W1?=
 =?us-ascii?Q?v95OnD5ni2pUFZjcJVoj1yzZlg9UDM3mjPPErC/oo4/SaYoFX8e3veOiX4s2?=
 =?us-ascii?Q?D2LTiiWywnBeS/i3xnmnnzCJLX7fSwKh4kuWDWI8KkF6qbegDD4/Fnvmif7b?=
 =?us-ascii?Q?IDMe5PYJFzu6TXc5L8rPzHXEIEw9qdpazYXkSRVbWCoSwH6qxiA5ZQZFUvYI?=
 =?us-ascii?Q?wOGwqM3PNdnA1hqtt+zEUHVq8wfnB4vufJgmQUF9uT4JjktiSRqI76s8hrjE?=
 =?us-ascii?Q?Ub60LCYvN0a08LP8gQ+zHCyKfIJIy4Ob/Zg578XlLDTpmYbLVytMLffSjVam?=
 =?us-ascii?Q?K+2Tf7L4aXRGvrnbeZcdTTxc057C9Ngaf0N1nS08flx+xub8/npXQqm1T0jT?=
 =?us-ascii?Q?dHzMTTtPVDOASC4ezt57K3xKiXnyOYyOQgmc1zS4Vm95cuNyBgyKLClAsyRX?=
 =?us-ascii?Q?1n3lpjDEM3iN/lVzyq6RkB8PNXYrSXJrd0+LneVnM3DTTlLMzTC35cCVJ9Uf?=
 =?us-ascii?Q?+6LFuSSNyoFdy+Z30gzC3a0TZW1L4/UjSdqq2rb4foN6Q0kIs+kTn94gWRsj?=
 =?us-ascii?Q?3kVFK15OA/MNp4ybIzH5LyKjj8icv/WbDbs1NgYlvf5b8qJW4EOwVlV6vALT?=
 =?us-ascii?Q?LSTFxH+3cjScpq2s5NdANs/B2PZoD+BXOj2TMlxbr1//p+UpQZBeiPigrZFq?=
 =?us-ascii?Q?XjenlpeiietWCD5FJWf7iJMuIL0ef8aYtVRYMslj5rOo95cUJL6VErlOnluS?=
 =?us-ascii?Q?5urJVfXsYrytGwD1P1mUYrGQhIdKZWXOFs0RA8vNWLp6Dxt3Ap3sDiJOnmxh?=
 =?us-ascii?Q?zDN2rdhLtQoheB4lygDOae5yMRmVzWyHbWIATqZH8e7hJdD2ImD6sHiKIEn2?=
 =?us-ascii?Q?/TQV93+BdEc4G/FMy95eUFmFguBJtc9jJoLnmQEK+CY+Gr7kOftMeHV62YiL?=
 =?us-ascii?Q?D8y1qSsvpBjPkvIDJ0M9/pUVMHvhso/SwryLtyeq4u69J+HOZMgj0VKuAzym?=
 =?us-ascii?Q?+ClcxDw28shVOWEc5rR15FvrjtZN5D0pJzGJDpECa/La/K5zGOStMiuvVyuS?=
 =?us-ascii?Q?rw2S5hYBlfUGrGVRqLgnHlhCRAB9ur+vj8poIYtso6eVugnjorUykeLzXcln?=
 =?us-ascii?Q?lClQ1V4Q7k0g62VXS5XGeWmpwWFlKOf4QCIH6iQADBr260dOyBAEvRmWct/+?=
 =?us-ascii?Q?UKozGyfG2/43XwhOp2hp7KXPiwk5muoJ1WwEQvSKcELS5F0F1N3CdV3w7NPo?=
 =?us-ascii?Q?aSJRpbDYxEjGYV94t+f28uPKDbz1gX2qi4sdE2zJ3EFd7HSa1O6cSr5n5H8p?=
 =?us-ascii?Q?27v6hGNfS3FObMkteS6h0CS9s+0rwQhmUnLn+0g23JYaDmIchbEYgIwi1gGK?=
 =?us-ascii?Q?LbSzpgFElr+E79vidji84SEEHEgUAJu3Q/rRiUMMnZ9zC3zBMvFBcDG1EqTI?=
 =?us-ascii?Q?YLIGCYRH2HCujHKcysj6KCXrzbDn9oCAR8xyZ36eXl9eXdCE6Y/Vo5Bu4Rew?=
 =?us-ascii?Q?PTOAMqA19w8w3RhllSRpeZWBrhF1gMvgRaVvyY0N2mT1AGsapXeQYSKFWmaG?=
 =?us-ascii?Q?tZtMg87Y6M6FXlWSyCZD+lS6G+sZdE/1WgaaukQ/eIXpUPqMxvjjUnJqX7JE?=
 =?us-ascii?Q?CAqvdty0P0+h+JawGYkJ6thd2m/TlDY=3D?=
X-Exchange-RoutingPolicyChecked: tVs3KIVzcBpiU9O6SSfWv1r8ps/xlNEb7LR/47I91+uEllzzEptz6uX0ACZPjG7CDpUIwIig+qNs/xpQKgpS2JrecAJQCcMlPBTY2J/Q83l6zg+5S+OyzV1lFNvOjzH1RsNURbYSHBSTMMxnAacGvP5Wsv4R+tUohgG0MufDpJsGAh1a+RV1grwNOGv3yK+i8JKiJ3y66sboj6BScEUsH4w15DYGjYc8qiyi19tZ79s2u/7RzF8PnsCJft+E90UhvyfoZebS+ow2DZw4K+k4L+mo2Zc9rhBudRyp3kN6kOTvDzsRv0kBj7VWllxv8iv0U33XguVrBSP6HLc1C7INrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b8484afb-0956-41bd-bd2f-08de9f93a958
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:49:28.6090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLlIvlq3wNSAlWeH3JTYo4VOyuc6HAMDguveEE2ZCTpjVx//zB1j3n6W5uGWWTscgCdqKr6IBzinCG38eDZniziefOptyljVl1ke14c+20I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7214
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

On Tue, Apr 07, 2026 at 04:04:05PM -0400, Soumyadeep Hore wrote:
> Normalize ppm to an unsigned magnitude before using it in the
> increment value scaling path.
> 
> This avoids negating INT64_MIN and also prevents subtracting 62
> from the reduced log sum unless the sum is still above the
> overflow threshold reported by Coverity.
> 
> Coverity issue: 501832
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
> v2:
> -Addressed Bruce's comments
> ---

The code is a lot cleaner, but unfortunately the 32-bit builds are failing
due to a lack of 128-bit type. I'd suggest keeping thge 128-bit calculation
for simplicity on 64-bit platforms, and maybe adding back your original
calculation for 32-bit systems.

/Bruce

>  drivers/net/intel/idpf/idpf_ethdev.c | 38 ++++------------------------
>  1 file changed, 5 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
> index 5e57a45775..23a2af6332 100644
> --- a/drivers/net/intel/idpf/idpf_ethdev.c
> +++ b/drivers/net/intel/idpf/idpf_ethdev.c
> @@ -1005,42 +1005,14 @@ idpf_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm)
>  	struct idpf_vport *vport = dev->data->dev_private;
>  	struct idpf_adapter *adapter = vport->adapter;
>  	struct idpf_ptp *ptp = adapter->ptp;
> -	int64_t incval, diff = 0;
> -	bool negative = false;
> -	uint64_t div, rem;
> -	uint64_t divisor = 1000000ULL << 16;
> -	int shift;
> +	uint64_t incval;
> +	__int128 diff;
>  	int ret;
>  
> +	/* ppm is scaled by 2^16 to match Linux adjfine. */
>  	incval = ptp->base_incval;
> -
> -	if (ppm < 0) {
> -		negative = true;
> -		ppm = -ppm;
> -	}
> -
> -	/* can incval * ppm overflow ? */
> -	if (rte_log2_u64(incval) + rte_log2_u64(ppm) > 62) {
> -		rem = ppm % divisor;
> -		div = ppm / divisor;
> -		diff = div * incval;
> -		ppm = rem;
> -
> -		shift = rte_log2_u64(incval) + rte_log2_u64(ppm) - 62;
> -		if (shift > 0) {
> -			/* drop precision */
> -			ppm >>= shift;
> -			divisor >>= shift;
> -		}
> -	}
> -
> -	if (divisor)
> -		diff = diff + incval * ppm / divisor;
> -
> -	if (negative)
> -		incval -= diff;
> -	else
> -		incval += diff;
> +	diff = ((__int128)incval * ppm) / (1000000LL << 16);
> +	incval += (int64_t)diff;
>  
>  	ret = idpf_ptp_adj_dev_clk_fine(adapter, incval);
>  	if (ret) {
> -- 
> 2.47.1
> 
