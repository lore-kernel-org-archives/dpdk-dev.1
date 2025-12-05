Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EF7D2E038
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 08:32:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB4F440156;
	Fri,  5 Dec 2025 09:32:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0B2DF40144
 for <dev@dpdk.org>; Fri,  5 Dec 2025 09:32:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764923564; x=1796459564;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ua/nQug6oQ0ZMgq0ExeVebFzXQmTI102YoVQW9/4wXE=;
 b=RtBemYjXMRl6+4Xb6QhIvJO1G9tJet7hdHzW/GrYvfmz4iH2axcsmb8f
 xiG607+P390hN6EqPWjw9EuLbTYpPoUYPqUazV6UWFJw5g18O2P1UyUNg
 5TnHBDXAtxzn4QPfJ7DtyqN95sqEUaolk0VZNCMcLI19Gp7lssr9c82PZ
 wSLjSaO08UA2jJ405W+7DTAGWTHAR238xgGzMG7fb51Jick79mEvipxDj
 EigjirWXf3gY/ms04VSIdTqrdHILUTv5bZFkIvTfoo14luVMx1U7DSoPI
 S+msVpneEp5SYE7+SP21W5F9zt3uh9IZFhIx7sIyNvpJoz8MGAwapZ4QA Q==;
X-CSE-ConnectionGUID: XHjLFVr1TiCTfl9jzPDNNQ==
X-CSE-MsgGUID: mlZEEHzpRGWOPAGkoCXbcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="77278968"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="77278968"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 00:32:43 -0800
X-CSE-ConnectionGUID: ebXXXFAaQk6ieimB8M4lUQ==
X-CSE-MsgGUID: GNNIqS5eSzCRHLpGQC/RzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="199434875"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 00:32:43 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 00:32:42 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 00:32:42 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 00:32:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1tzZSCNnKcZtL3YGdIJZNQZZFVZbHA6b1wNlc/Eop1qVpbhjioNFbW7y7c4iXcnLSgyEU2q5bdG04MzaQRgLp78uYPRl+nJIL/BYzh/0flkSllio6RFiSacM0vw1x+esJmYWM4EK+5mNxqD3XKUcMmZMUSm7iSRaYJGmxveCP6eDbirrgeDvdas6rOEXHEKs+oTiGEyH9thXxrN/Z3QsYrJ1/5XMbYvBF6kR5EMWASHCPJhu3pX43QLwd9coYRE6oG523nQXwLyoIWjrHEoBzr7DEfKmazQcWEC3pOGqtSpAvA1rgn9goOm9Pu8d6+KuOjkaqLNt8KqvpL5K2dGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLou+ZacGbr7ojXPnFX4X1c/wefsogPys8RTGWoWzDw=;
 b=OJZd4z08kt4OrANBkaZf0HI+pE9oJTxacg3yckX6eZnfsc2jaJqyBTBiACBVVKyE/njIxCKdtz5ANl27hnBaUUrcvo4Buz/iEGjPx+fYJ//AtrBmShR9TAqKLU3G29wntmdz6o0cGr26/VF+bhpcHffLNn+i6VXEcI4kyDqRUza6eAVvl/ZevGAj7AWFOwAtw+86MkwwKvvHGGiap+pO7i/F6j/W119GaviDBEwv7XkJFNfZ7GuhaZAm41EeCR6uJRZxcCO5hlyAiH92L2FfScSEGxLUASlF3WSTOK/3Wt+HJXCBdMZa3uH1nfJ2QbH/2lcaorGqVUCAWRK5xLdtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9232.namprd11.prod.outlook.com (2603:10b6:208:56e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 08:32:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 08:32:40 +0000
Date: Fri, 5 Dec 2025 08:32:36 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC v2 06/14] eal: warn if thread name is truncated
Message-ID: <aTKYpCOVy1wueeWp@bricha3-mobl1.ger.corp.intel.com>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205022948.327743-7-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251205022948.327743-7-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0065.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 8304e551-b5b0-41ca-7e20-08de33d8da8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ttekP50iVgC/Gpv6dfiW0b02D0t8tY/vEyixxu7Qt8dz0F0Is649qmA/ONjH?=
 =?us-ascii?Q?wUAvrgkYeOnRVL/a4T/zibfRm49+kDMqmiGkSyShOipDpCj8M41yXATIcw/S?=
 =?us-ascii?Q?Sy8aSCQlur5kttUfliZGzbIotfl15AwBBHI835C1KyIYW8+JevpjzFg5ddH0?=
 =?us-ascii?Q?PoJjgX9qDpRso9IdTekeNbacWxByPyMJjFO79Jm6Bzj/jd4jjUHzBoSrHbrm?=
 =?us-ascii?Q?FodHC5OAVYSDH7eVIzJs+NKCXihCrWQK34TK0/CsdSdmsCQLYtGnwBpm6ujJ?=
 =?us-ascii?Q?iD/52tDzk1nn09BHZ9U5sCDYfxIU4joTSbyyIKxtwuxAJsZt9iaFYqLk6w4y?=
 =?us-ascii?Q?FLfHvF+UwzaEOn+9KYiB1q+M3dga6nfT/yTR3Rgyh49hMk+MDFZsiNGH4NtD?=
 =?us-ascii?Q?mFx9hq+aMaCaaFKKhCCNVxxV7U+GK2DlX9T1Occaj64umT1B3V+uZww1d3g4?=
 =?us-ascii?Q?mc6nK3fWlK+/MTaLK4DGw1+jRr/FKc13tQg/eYwWDYVMkOJI3ISOOmKKkPus?=
 =?us-ascii?Q?BRoz+6n1VNu248W05v2R/xQftC/F/UHKp1QsNDr0i5iFSTyGgxN8Jv2hzAPn?=
 =?us-ascii?Q?cO4yIV99JSmnnNqpEzqr2sGdXxMmp5xUBpMV8Gmfs7QOvH5JwJPWLGRyqXxd?=
 =?us-ascii?Q?7A+uc/D4XNIMZnyRjwp2RozMs2tQ2vlOnkJZNFYuzGKzjuGxbKkSH7DKcXht?=
 =?us-ascii?Q?usMTIemSHhWQnHANAwMNZziuAN6pJOjGD/yI6awwYKEkTlH6F967PpR84q/q?=
 =?us-ascii?Q?DHi+bqyfGeHUcHnpMHjWN5eJOw1KbywFftKdp3lpw7EMa251UUNYbvr+gvUD?=
 =?us-ascii?Q?17ijAOZdTNht8ueE0L4GIdtcpOjirtFAWmRZWNug0lChBUiWXLiHAvUbRcfU?=
 =?us-ascii?Q?BjtP8VudB8lWFvciEFqiG3YbzdtEdmJ8X6flDGr53j9FdB4wGIJ9ugiusl2o?=
 =?us-ascii?Q?i440epioLAnMfv8uU2ZczcfJdpyiBZb1zn2LZWBFcFoy2hd3YMm4EKR66OB5?=
 =?us-ascii?Q?31rdNU5/j4zi4iXkp0f4nBTh7tU5ucPlfLtLwLAUZZQVzTku5gs2DVDdMKj4?=
 =?us-ascii?Q?f5ym9AwwVU+Pk8Z4C/0rdg3lgailApMLk9sKogIxiVxwaXzQy8oOBxWyPFbt?=
 =?us-ascii?Q?oIaAxWKXWF2TSJ0sZKSul1lEc1hsXivLTcyoCjFi/FTz2r9KoCX5SkylTZSg?=
 =?us-ascii?Q?ekUrd9qTut+eeirF+I2ARJHXpaFIk4KS4BCyt0LF9jNZJ4Z788Y+/GxpYEu0?=
 =?us-ascii?Q?QyrxlSDiBtD3j3cfXPrJlRhP0SzkJob9hRVm4MPaYxRnO+ZU5sEjycRxY0t4?=
 =?us-ascii?Q?4+eXOpo4GD3aWMX4QX02PGy5b9cNnAPVYItDEzHJW/gKKdWWXVPDu3TwW0AO?=
 =?us-ascii?Q?YPimsGCWZGhQLCEMiPKrJg90gobib6hviXw4ZOU4CJHih9c1yL3K6RE1Jr3o?=
 =?us-ascii?Q?i1dNqHLBgsPGiTa2ZeQtArUJohQkN60c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PI3RJOZT/kK600xZOGR5fq5b3bOWVMlN51t/CTXLy1yuQm1nxNfiBV0LFjM2?=
 =?us-ascii?Q?otkzt2/rd6lyFgsyVyD0gwsxJPNb6/n5jDqN39+WJR7tLppgs+J1R7Ol+LAX?=
 =?us-ascii?Q?nsv24odUwWe42Sd4cwesRbwWT4ERrBwAIMN3uKXRDvr5oISoZdiT+HAwl1s9?=
 =?us-ascii?Q?FOY98ZY2/l++9gsMpc2Exo+oSPFj/zc+jR2OT3pseAAcN1xsfJ2SubKIty3J?=
 =?us-ascii?Q?OPsV8yuHZICPrEjtawR/RzWh1uquMUPbWmvWYyiZVjGctphAgrg7t+qsjQLr?=
 =?us-ascii?Q?oABFI2cK9fcC0WzCQbuMHjyiDvGKORCUSfDfSI75CfAJhwYsM1zXI1LmrOUf?=
 =?us-ascii?Q?w1J+aF91i4mFyV5fJLyjvJ5FWSyZG9V2VM0CDOiUpitaaZM6KPlHlDHs2MxR?=
 =?us-ascii?Q?Dzv8tRCf4bc0ZoWaAazUBihS+TUpjr9v0etzu+F+G4429f3wZbjYfytg3CS3?=
 =?us-ascii?Q?AiydgDcwABOKyxRW474dBc8UvCwwelVvIauhf/MgFET6xBgXfWwmshub5x01?=
 =?us-ascii?Q?KSUX82dg+t8F6O6DePpWYu3WWxtEP9zapU/DxrELZmkCXuyLxoLtHR+8DIe0?=
 =?us-ascii?Q?6fPXzhd7V5csilafoD4yzookzFyc+TdjWT7R2csFOQ3QAiSIDlXdV6/UH/d2?=
 =?us-ascii?Q?uwY6EjnNQhiofg7kGnh9y3PUnk4eo+ic84+v8nsXQ/8zbmz/JtzUHooJxqfj?=
 =?us-ascii?Q?xLGs6OPoHP6NHFHHAo2sVwQrrmyT/riBFW7n+MT80SmSNd+43I/T4rnOQ8cb?=
 =?us-ascii?Q?hxK/UMJg4maGhJ5d+BgHYxqBabcl5DaaD6mN1IznACNmqhRXNre4jO7jUloN?=
 =?us-ascii?Q?VHGdP77NPe89nZDD4PkptvTUd76kDKkl3fExhl6Fcmi/wX4oPnI69noDzz6D?=
 =?us-ascii?Q?x7MY5F2Nd4XeZRvuHFU0yDlUDXPUM9oryCZzn/20JFWAKJ1nsqQXkNZnnTGY?=
 =?us-ascii?Q?oBOeN+pVQnmQYOT1SdLXSUyeAIDYyhFk5mWDDTwY7cTEMNcdSwrAPh24k55/?=
 =?us-ascii?Q?6pHIXxVFJsB9wcvMM4RGwaQGClmipiWUMTnOonfauIuCNCJwf41YxD5Hb0TB?=
 =?us-ascii?Q?JEXk5LL4jwZGnUmvkQQZFEZhZkn4bUWW6b1aHBd2urAjTSzwmEGSB3dBmbRB?=
 =?us-ascii?Q?Gy0rxuzV9bXH9KZfgQXAgoH5CkkF7pqCjy33MkZrcqCad1DNhQjhvkbewEus?=
 =?us-ascii?Q?IboYf0uSpjsDNXkL661F/kLudOvNr3ORWR+MsX0j3ATI1YfhLvO8Bq3XCVC7?=
 =?us-ascii?Q?jSWm8cqGOaM3rIW+VJozU9CuTyP72+TKI0ijZXbzlDROe6CYd+a+KXDrmPia?=
 =?us-ascii?Q?4/aki5Q0cjDCs2Ay+d9D5GLJ/9M2nbObZGk0XmMHGEw73kEc+vdyK585YxzE?=
 =?us-ascii?Q?e/6SE7rFKFMQJDC82tvpGEf1TRlM9oZdTPvaPw0VIkhKMHhewiNtaW7/neZ/?=
 =?us-ascii?Q?l04pvGVX44Wp2zyjxkf/5sXqmn+uMNv07yTVUVgiQ4IjWJ0FLN6tz3TkmnZG?=
 =?us-ascii?Q?kVZsjNidiUz0QdxfW8hxJCLBr1yTwHzfGekX42DtMU548/ttPT3TiS6Nbnro?=
 =?us-ascii?Q?RlR/j2QiTzE+tk56ZSyQKzZ5+OrZcBSBD9wO6ijnoSUKtfzY2hQ0e6DruiVm?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8304e551-b5b0-41ca-7e20-08de33d8da8e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 08:32:40.7584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K03TfGa3MH84GtIz7pBQK1/0zjYh2TS4QRiAVrco7rMDNpb8a0QUWREAdf6qUno9FIJ/p9kBTpR74lJf4sWz3GldXBdhcL0T8XwSMbDgtKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9232
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

On Thu, Dec 04, 2025 at 06:28:15PM -0800, Stephen Hemminger wrote:
> Thread name is very short 16 characters and therefore the name
> dpdk-worker-%d will overflow with more than 9999 worker cores.
> Error should be non-fatal since name only matters for debug.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Can't see this issue being hit any time soon, but no harm.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  lib/eal/linux/eal.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
> index b12f325ddd..d848de03d8 100644
> --- a/lib/eal/linux/eal.c
> +++ b/lib/eal/linux/eal.c
> @@ -863,8 +863,10 @@ rte_eal_init(int argc, char **argv)
>  			rte_panic("Cannot create thread\n");
>  
>  		/* Set thread_name for aid in debugging. */
> -		snprintf(thread_name, sizeof(thread_name),
> -			"dpdk-worker%d", i);
> +		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
> +		if (ret >= RTE_THREAD_NAME_SIZE)
> +			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
> +
>  		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
>  
>  		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
> -- 
> 2.51.0
> 
