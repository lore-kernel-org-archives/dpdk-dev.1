Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B24C88E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:54:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3776F40269;
	Fri, 11 Sep 2026 11:54:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 603A940264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789120448; x=1820656448;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=R20PUjjK3c8VTL577+5EnoWX4h9OeGOYRlt15CQkTgs=;
 b=c1iZsujKPUzhE6h8LWWQem6xUFuOzs6QYndC+Io7V8GNcBuVr7R7mZDg
 W8eBgk2Q4wbjlmtXxj2FtON9dSrzMqIgN+95RFIVqY9+KhyTcvqPrBumd
 GfCVvsRtAxrVP80JucduOmYWAZLhruALEl2E+bLAwhdkknvt9ahSka8r8
 GRC0eg5/wyktNRK2xVipIlUveXa0epMeETiFsQs96Ug00PAhusW4eZqBK
 qO7dGQ8GqF61T+SJyyxwX+7TnmE3Rc3W8/ntlxq/e660mTeh6DSRJT326
 nkTC7Zq77fwKW8abU35w6xxEPXEps7+XKKdmGbD0QBQa4nvWkviF3nYYQ Q==;
X-CSE-ConnectionGUID: qNJ4wT0yTBiCTKYE/GDgKg==
X-CSE-MsgGUID: feVNphTBQe6bpvk71Y+SLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100933992"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="100933992"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:54:07 -0700
X-CSE-ConnectionGUID: Ygjkd7rHTpqxTV2+UIdk3Q==
X-CSE-MsgGUID: qxFReaDKQUW69XiEwWx27A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="296862219"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:54:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:54:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 02:54:07 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:54:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXDOTjHUtLbWMbSwgu3TWcCVaLWmm6YuGuMklF1UDfyVCS2QoU4M+9K2jHplgpfiV74gTAAgg5Ml3I6T1fLugNbOi+++NlAtv5kZeYEL2f1oyuQQFRSaj2/7lnpKyGVUSd++/DFbNXzlIMizYTjkor2CO5nVoZt+sWI/E51M6S0Z1BZCeuMlupMn2+c/hEjbSe8QVbSZKvBzXdawq0dW/OshBSApSw1Vaw8hSK8y8PkFp9lU4YMJNULTfdZYnxP6yDuVOtpcaRByS/bsnrWcZIiQrn1k/OBrxAKJT4XnW+D+c2fVS8/M1CtxZgAJYnBFSsC/v8TURVOVIfdddjDlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ML4VPmi8BANkgvB9yNgew/Mj8HoPss3oK7HgsWNB1M=;
 b=yZ7nz8O+6S07hCHaqVoOmiukRLAl50YuKbB72zD52qVJWePukFayYmbr0H2bgEHg9jrQmKZ4AlTmhVDcjTi0tPoXcLtLfCSGwWL7QGYm+DNLvjHyhoeo93nankUiiICEXp6KrbAu4gOg+ewZrASKn7MB9+NBhvVno+I1IpsTWesIzbqVDRkGnfrmLCrhXTKoaBdZ4qqxxSAE7NBunIJEkhG4RhRk/nDtA34w8Z29FcOex4VBpNL6jwpzIFsGiKoN+8KihjpOaDj55ywViDdBrQPXzdLz7WCZ4wpAHkTSJkSvlhtBRA084jQDyM+DZDQLZHx805vIvK8LbGwwu6ysyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB7118.namprd11.prod.outlook.com (2603:10b6:510:216::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:54:05 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 09:54:05 +0000
Date: Fri, 11 Sep 2026 10:54:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Jakub Grajciar <jgrajcia@cisco.com>
Subject: Re: [PATCH v2 53/68] net/memif: use memcpy for fixed size data
Message-ID: <aqPPuNPBIlFhpTXJ@bricha3-mobl1.ger.corp.intel.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-54-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-54-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0349.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::6) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 33162be8-3c0c-41af-9e94-08df0fea9d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 1I+S9380fntrbe+3LpX6zPUOyQ2F8gIWK+avRUP3xNdwGZ1OZlpkbnrYODgxq1J3lcOIayMGvtZuiJvj+nwlPY4Rh8wjc70ngCOzI8y00nuKTjwthOTKXg7geOuL0XqjIGzlBTd+Mj9RrDYd+nh+5G4g0xirYq/2Dlekrz1P9RpNeRDazD49kqCczApjSyGw+qGRmgM8+sEo61tjHoDYDyUIu7RJasGR8+DqaQc/VYoF/ftFSW0sUFIv/PI9wRe4e4uUl1MWG1MInZYZtETKdKzqlGMlwBlYnj9/yveuiTpcN9i9gN5YIqNngNxtPG0As5/YIhoyHEvBBa0ibXdUUMXHUrB7TbaS/2nXCnF/yTsV/gIT/WCp1fc4UV5H8ckaSgE/jZEhgC1krFDWHOf0F6uE6botXdvayJXcpkPget36frIiqchXyfZ1D5GWykCQ0LCldyTQHG5X5OT4+TK5UUS12WOfrsyUPJEqq4nrDNzY/LQPawatc1l2Oelwno1vhilNjEYsL8kpfI+vuE926/8GQIZdGXP5PZSMhqy+hfba/sH6LtrQqPYj/4blBmo1wV3JYc/Zb6s8zk8I4qu3TmF4czucYlyfXrsP9hkIjjO+tfeCzm8SeJUF5Zv6ZppAuo8jelPcrciIqst85B6HGb0zon633jTN7pfTLTN1KDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RNJPbTe66j2qwtBSi6WfxJdxBbwaIVqxQ/0O3cSx+W+ppTJNV4wfEkXNoXSD?=
 =?us-ascii?Q?46pD03LPUXW+LUUkMYr0NqxseddZJylYwI2yil3S0zahoQhmXsbg8GHayhAh?=
 =?us-ascii?Q?Bxwld3jrVUkJI3URygLVgQszXcIMUkUL/rkbTq7vIBzuQ26dRy7OUdafSafy?=
 =?us-ascii?Q?2FKXfRf2h3zG3xKqytPLcR1aiCqOE8QkXaZmAJ3FJtDj8SMuyWTHuVTKSkF+?=
 =?us-ascii?Q?GTdpuLgpwYRtpeQihLUQ6efXOf0rvlp0Nj7fxgPujr9efNQzz4kSDFDQMFkh?=
 =?us-ascii?Q?i0rIUnEhOY5uq5VTcmBv1IVy5Pvp4w6NI4mXrVybyKmOFY164UYKs/xSggKm?=
 =?us-ascii?Q?8R9PxxZ3R1bVD+uPSCenExB/0vQUrk23ivIW4mxlbLV697qnLPYSh6p3k7Fa?=
 =?us-ascii?Q?v832LNrLhkrD9nNJZ5Svx0Ctpl0o/WOdXYvF4Y2rNe6QZXsX2tJcjy+UUxrG?=
 =?us-ascii?Q?Aee/H+bIfEtfSHVNz59PzAfIN9MCv7yRpemME2D01Vtrr5Ziagupb5q6t9qI?=
 =?us-ascii?Q?AYLYPs2vyXkOw/axIqPXdAbnkAz03t/e4H5VK0I/1Ssk/VMFJ/edWbmf0H1V?=
 =?us-ascii?Q?54Fv51d28WjFPA3L6uq125/RcW1OYFPJzQ0l4XaxrcPsEyVVX3ksy/OKev5v?=
 =?us-ascii?Q?YCnBVB+d8Rekle//8Zv/fsbjliP4gVCJqn99HLas3QqfMJIL9RXe5pFeW7fa?=
 =?us-ascii?Q?tt+PDKPcBxZ6cyVbLMTje5LCoEWsixd/5gJWWeDgYuTJc+sO+bMmrjlhXszQ?=
 =?us-ascii?Q?DKx6eA/0nxK/Q43tTnBGf99kWF1yBpVM2fhelxJDqvJHH/S1PtVaQ6DC3AMt?=
 =?us-ascii?Q?zz9pdovaLUYPjnYPHJ4Dv8CPHoNFqf/gK1hJybACuAkUhyHKhKRzhuvWwG2Q?=
 =?us-ascii?Q?wIVLMHdUHGqELnftryWAqJ9dcam2Op4h0ocio2Kb7+SKaQz2cbnskxpwih/F?=
 =?us-ascii?Q?/G9rLUDVDEu0W4MEDtKMT/mSVr06GBWfScob7fNXqWksLtwfB1yNiPMWp+1x?=
 =?us-ascii?Q?eqFndBFPgQAgnpnS8354Vwq416gd5CICPacwFtIOBqyB0hZOP66XhCOr4wb4?=
 =?us-ascii?Q?r++wpMny0+f5IMBaNyE3Sgumtmz2/m49+PXvnzvYJafUqT7hYvpdZ4Sad7IA?=
 =?us-ascii?Q?bkE6jnLo7Am+KEF8p0vS+J46xUcm0QvFajkwgR44MHV0AQakusFkFFWDee/N?=
 =?us-ascii?Q?0WCTuWu0WLDk8Iepnr3Ppj3f/bz+GShKKfdfn3bv8YGJhXhDmIxq1FTH1Zjm?=
 =?us-ascii?Q?GGoO5FbKLfq6h0vfdi9RAIbnz78aTpmic8Ve8Gbte90l/Xu2NfDqKJQgYS3y?=
 =?us-ascii?Q?fnOBu0QBDe64BOLThN1CbyQl72EfnIJ3/k6cGDH8+sdKq4w9E1doX8rvXdRK?=
 =?us-ascii?Q?oZSgkTgqKdMlDNQw2he+40PHmHZtIW1NZp/U4HYY8Mp5Iw3H/3EfHaMG8kHl?=
 =?us-ascii?Q?ZKfAiBJPUi6yjfs6Gi2irHIzYselxEVAv8/qukdO82PVTIH9KQKBcUjCLzY0?=
 =?us-ascii?Q?hWLKVcMMtt9mmaPaaACeEaCpA7BAkoR/kwyAAyFj3erABLoRWEhCnONGixPo?=
 =?us-ascii?Q?1x425zQo58TBvD7WOUjxfLhnsMFCIvdIxJc4bbHh9V18GorJGBILZ7/nRY1Z?=
 =?us-ascii?Q?GOAHQyO4XVdFXxiFGixSWNDOPjfxL+nDqJOqHqfeUGOoci45bwfpKrloS4K/?=
 =?us-ascii?Q?v16p4tq+46XUeA1PX0ziOoaKgXbjyypUpJoBFbrCpfmOcyviPNjLZ0/sjXGU?=
 =?us-ascii?Q?nxlz8Cvr1ggJ47n1PtviYWOLWhDLrjQ=3D?=
X-Exchange-RoutingPolicyChecked: aRQsh3Fx/dFHBWEsJuvWaYWREhJH+YTtmmbV9CM9MvleV7xMwOhnDezG1RpQPrer2UCD/7F7SZ0ZuMhknVUPvlh3btJw1+fy62GAQSUO6K0tbw21z/nwKUAjiPxlHFFY5jOzTWgH/iymHf4rpFbiQhTZW+21BaKRveVo8PRJAd9yjsX44JIw/D1MyW7lRb9d6N4eMQDFzfvc9r+kJj02OLWYk8h7u7+PyLukF4AW2ARXjQL73RrYNi0aqFwLIyOg5WjDk142TJ4l1/fTC8U9ATuxKYG+0KgOgIECWkLDd6afD7OKo14ZBY4hDUc5S83+2bbjCHGPRT2hNJ1pyA80ww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 33162be8-3c0c-41af-9e94-08df0fea9d69
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:54:05.0470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCEfT173trRwWt5Z2Pe0/jTv946DmybnvAHzJ/JWeBovrMl1hB3lIn5RuQt6JL+PEGTr7FiMDbTQQrrJYeDYGD4Cyg9l0wYi7G/SMbEIUOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7118
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

On Fri, Aug 21, 2026 at 12:24:48PM -0700, Stephen Hemminger wrote:
> The regular libc memcpy is inline for fix sizes and has
> better analysis coverage.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/memif/memif_socket.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
> index 649f8d0e61..f5a3354c46 100644
> --- a/drivers/net/memif/memif_socket.c
> +++ b/drivers/net/memif/memif_socket.c
> @@ -48,7 +48,7 @@ memif_msg_send(int fd, memif_msg_t *msg, int afd)
>  		cmsg->cmsg_len = CMSG_LEN(sizeof(int));
>  		cmsg->cmsg_level = SOL_SOCKET;
>  		cmsg->cmsg_type = SCM_RIGHTS;
> -		rte_memcpy(CMSG_DATA(cmsg), &afd, sizeof(int));
> +		memcpy(CMSG_DATA(cmsg), &afd, sizeof(int));
>  	}
>  
>  	return sendmsg(fd, &mh, 0);
> @@ -675,7 +675,7 @@ memif_msg_receive(struct memif_control_channel *cc)
>  			if (cmsg->cmsg_type == SCM_CREDENTIALS)
>  				cr = (struct ucred *)CMSG_DATA(cmsg);
>  			else if (cmsg->cmsg_type == SCM_RIGHTS)
> -				rte_memcpy(&afd, CMSG_DATA(cmsg), sizeof(int));
> +				memcpy(&afd, CMSG_DATA(cmsg), sizeof(int));
>  		}
>  		cmsg = CMSG_NXTHDR(&mh, cmsg);
>  	}
> -- 
> 2.53.0
> 
