Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F4D106ACCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 16:57:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 232A2402AC;
	Thu, 12 Mar 2026 17:57:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4833740275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 17:57:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773334676; x=1804870676;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Pmxd8FjUi2T5G7vkZjfAl7RjvBRlGAf+AWXwJwZn2EU=;
 b=Zu91fRWPtyyLWxzDub1ABJg53MeM2u79vb6Jb97bBa1b5md5DzLsYKi+
 /4zM5rpJZI6im7J6XLt6dE+AGfosdLxLzXRoDFB1WE6/Fdxbv6puqUzAG
 y/GmZaMpkg9sytpk7sq3BLChloh7+Rax8i/vnbOFqhqo7r8HGrwypgBDu
 1Ic6dLj2uMsipl3SLufdZTHjkEEMoKb2J+mWxgBPFK1YWEm52qhczE2pP
 fpi3tPDxU0QG4SIdG/NklBVoh1Xe+d6OZBtHMiEPLbp89f14UALWf99ke
 M/Upg10W4MN9F5aSYPQa0BlHiHZPq3602rQhJUu9lJmCikX5AgY+9kuw3 w==;
X-CSE-ConnectionGUID: a7hUC3EeTzWQBFz7D6qKFQ==
X-CSE-MsgGUID: /AMDNpyCTBGeTK/TqZiLFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85789170"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="85789170"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 09:57:55 -0700
X-CSE-ConnectionGUID: qeMSNhM9SgaGqpbMXgCG5w==
X-CSE-MsgGUID: HBpJH6LxR9mGfrLfUEIchA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="225337938"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 09:57:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 09:57:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 09:57:54 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 09:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kP8eOPSB1znQ3+/rP5kQDZjRS+Oi8C1zWOIp15Tjb5I6t+W+tqN+ShCUNjA3jF7T6S8/P4g9NFTjvFJXHMKBLd3/4pDjzcPmyRH8wSfZz3nvWH5nAzFZhwgTvDn+dviV4fD7+TXW0DALiO1Q5I+io+AYqHqScBRlrBh7gNgB47AZd8QqFkS79vlepeeIISbRox40giGZCjYnwpjj+BWLYnegHbwt4U8hbXNxRRhOBhqw0f065Un7g70yxQ2/hsTDHtXcCkaQ5TuorofzAD/A62YkIm29MehThMwjrZ4A3kA9Rpp6b4XXReBYSeLqT3dTWVnnxIkxvGgR0Iok6HTW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYD/VLkmUV2YuRJSOasCCzdjXmi7cP+NSQp6kKQbE+Q=;
 b=CUlg1yoAEAbEsxKPRM4OyvC3Kt9q2TNtdyIz+JbjYfHHtJqEuDvBjlDoe6t72J+/gqk+HDnYyY65q0dRoBGmFs43zOxqbAfGYLtJGqX99OKFT6RoSG0pztY6zDnmRjE6UL7GnGo+fSQy/E0dX5lGlDArVb5gIIMNA8z3g2rPXatfLi+e1i0MPRQ6rffiooj0ie7YA/zEUe2iHAldMGlO/pNhY5zgkUlK1lWaiNwA4wbPrKO6btpehUE0lkue9KP6dXTTd9wY92rgHmV/hSqrmKmno191NeYD0kw5CwDBf/bDB35/JyROdBJVFDqiIgBDF63mxKRr+WpQCr1OGDsAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4689.namprd11.prod.outlook.com (2603:10b6:5:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Thu, 12 Mar
 2026 16:57:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 16:57:50 +0000
Date: Thu, 12 Mar 2026 16:57:46 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Praveen Shetty <praveen.shetty@intel.com>, Shaiq Wani
 <shaiq.wani@intel.com>
Subject: Re: [PATCH] net/idpf: fix comma operator warning
Message-ID: <abLwiikMS-apNzCP@bricha3-mobl1.ger.corp.intel.com>
References: <20260312164344.957967-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260312164344.957967-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0226.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d2b630-a1b6-46ee-796d-08de80587ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: W30evoS2qca7utLQLjmBNOI+09IVLaqvZbNjXJE3BZDdSGdogSCxGju9EXZU3XTiB3gusnyxoko4TNVeDTNBhopmlmukPOJs+1JJT5o4DwWJPBQoehqxlo2rDE/NNgXSFGktjMB6Y9lT0nP9BCXPzcvnENKM2CCkVCOOvLFknXoHxyOdmYKxldLttCFaPpDnxMxFVDHqqbR9zROwsvGlkcWnTuVDWEA00tqR56OD/u1zFNXX+ul2GB5qbHYfJFy8EuM+IMYvBDamlnQAZlG8wxW04fewS/FK3m8oc0R/BZgfHCZwusOeKDHRb7oh4Ccwi9y82e7asezncDzGXAIsYsfL+4oX5nRV0M692MDp4tSxrGiWYvXVHU7UOPk+0NVTq3iazjAO2X3c1vMqyk6+KRTvSr4RXtIWjQ0Arr/ycf0QMM9ZkVq1uV0pwEBp1EfFSU53AxOSiYMFEZUtYK3Htx2CeSNX/hG54Ooav8Mz8ydXEO9ojvsLhWQtSnvTdyqIDq/6ivrA1xLyootT9Nir+O6XCj0a5ZSDtEOinapUsCXQ6jTv3FI/PMn29R7ewaviCTN03GiHcSXi3XxrIMXCuPINb4UmPU5GoWorhedcDvUqquIQ4dSeZ4D75hOYeutrGPWuyDBSptEQPG1gDHyVLoOpH0I+YzWbTFxBH1N16N8dqaGEspQhkQJGZHNkGagVGGO/GoMq99hAPCfE2J8w3TDjpJwgjfL1JoViVbWpo/QVo38DVU0tnN229kBZA4u6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VwWfmVi/bG0HZSTg3YFi6Fx2xwy0o7Qg/aH4MAaVAqE6XuPUehhKHAN9RP3M?=
 =?us-ascii?Q?qZ8g2Ura4t0UJwadG7ulpKnsbXa3SsZVKnOQ0qYD8VdCw5Cg0j0r4ycPENYn?=
 =?us-ascii?Q?sILnbpO9/xmaGCFfI9I9gbaoidvXvPRATDpKqMuEOs3GcFVD+laLoxNCDurN?=
 =?us-ascii?Q?XUlW6uquuswsE2vz74DRm/aOS0VgC/nRRpqJLEJ2IDEHe5Vz9IZd87A+mEeN?=
 =?us-ascii?Q?uIVIiaPuIt3ev/ObxFqdi8SiAt6dHNvB4LUFI0+LKh5O6buvUqgKD9EX1nJT?=
 =?us-ascii?Q?nE3cT+4hlxnziJXJiCYT0Fk7e56BYc2Q1Hri4UZuzR0yIBAVMd7nIE7hzcST?=
 =?us-ascii?Q?wSwa+GpNvsZEpg6mso56oMLqkocO7MUnKKLpKKlkzcqC0U/b2k7JorL0Y4bA?=
 =?us-ascii?Q?sDKtT3LMo5lXBSCi76oQidYehQ2Vm+zHgXrAUarku4keXGOFtSgr0nwnK5Vz?=
 =?us-ascii?Q?eAJvfDUrX2Bile5739AksweRXWLnjpfuQZu3vB4Z+GZ/xccUGBEh3rNGLbz6?=
 =?us-ascii?Q?ODTRw6baJRf2jgKSwW1s2MVRECcwkXP6KUGjnrolDg0B9MqZ/vt3gUoYKb3A?=
 =?us-ascii?Q?GWFR5j2IRBkdlX1cMkhChLk0s9O8HWXEUJP2/N5A2ScCosf8l2xukoyfRYhY?=
 =?us-ascii?Q?y23aYvxo4I/5kvhTbsadB9BIx6tf3067/NlZmuOdrU1dTGFnZGLcr3KaZ/eL?=
 =?us-ascii?Q?M6vGRMg+Bk/+QIPBXTW6JssMvr3QpDZRyYbbkkgpc4NngOwy8FO/OdC3ybuX?=
 =?us-ascii?Q?UWuraDSP3t+yN/XCaU98WH1kmFC0CnEPGVhgDxm0zljQ6HGu97xI8tN6vY1B?=
 =?us-ascii?Q?+t8VLbRSQipUlgJv2Ot2Pmz/tZreUkjr/Em+k4qtJPDHaKlE85AM2UGlVRfu?=
 =?us-ascii?Q?1PJTvfV09PKpUCdl8MeBZ1LZDqhej/fpb4vP/+T7RHRwl1Bsxd0LldYJpFwB?=
 =?us-ascii?Q?joLvQ4cMNruceX7irHz/iBOtarjLKi7KsRCa2YgqiL+HlKzcgVZNasF3Vf5Y?=
 =?us-ascii?Q?781JW8RhneVhUpePEbjel0/WzhiUwv4VRAegvqIxoBE0T64KcfG6LmAVw+x8?=
 =?us-ascii?Q?R1uMoi5Vj6ZZCte5As6c4W1sPYVIElJDhSWhoMKw8WGmoX68+A8ysAcmofBv?=
 =?us-ascii?Q?W1RSxpvOmzJY2of9ZmqlXR8ly9rN3MI9i/IRqRkXAy3zip+oGDp5pMmwiPUb?=
 =?us-ascii?Q?Gu55KQyf5qXs+3BoNPaeTAW4zKHFg78ca7E8pVSxKDjuJUrnjlGVFWncfbN0?=
 =?us-ascii?Q?/HLpHQ42PUbRwLo2LdRasXY+FsFDmE38WdQLfSLulM7l37j840OrQ7MKkFlT?=
 =?us-ascii?Q?6nenrCClVMfBQXP+LaGYD3n89fiYPIcFxg54c2urC958PJl4uQ0AmCXFVDs/?=
 =?us-ascii?Q?BVBviwTvTDeDy9YqkGMdE6xK0DqHLG5f19KdkZZCPLoSvWwPf/daDvz031ke?=
 =?us-ascii?Q?hBikSZnU5PB0Mftn6LwlWV2SDIvvk5AZQcEwHWxbOQ8NoZBwAb6MfnTz9MwO?=
 =?us-ascii?Q?D4VkZ3qTkr9msLu6OE4lLFxqGArKMehTV6mgyVn50a7+pjXiP/LmU/XSFQi0?=
 =?us-ascii?Q?hZDbKgDz377+TC2C5aq8FYx41NR9wLQOBHYcPlmipK9RcizlR5YAZTghxvNy?=
 =?us-ascii?Q?g3M2ZPsnMtuxwK+j3685ZHWFehX284fP+Ay1fg23faNhIr8J3sYCkDNvb3bo?=
 =?us-ascii?Q?A2ceruw0ReRTT0bpDO6A1hU8at25ctg/q0O2l1aVSAb6roqv/qDtH4w07rmI?=
 =?us-ascii?Q?DpuaypVk8xlt5x4XJtp+5m3ViQ6FgJo=3D?=
X-Exchange-RoutingPolicyChecked: k1iBtg0PdoYVIMFER4Nihc2oz1IqlOzDJ3+UPVNU4PdZy8VV7oRnj1P6IOexb7I2OWU2AGYEzg6WOtNEsoLfrIp7fY+wNsjczAsB4cI2UBrPG5Dk4MyagNWvuKCO/Iuzonnh9tldIy5qvaXVGqyUm41XFobnNVWzL7AlBYiVoiVlXmzoQ3YyiQEwoefE5mz/CqLkYC40XYAwjZz7wRneySdpliY+Ce4GFLqo4Q+R4l8VdbsQdQ4VVXge7wbAMpYmEHQ+AqfzMG2qL93lRTcrIMICpXCc7dG6TfIjKiCXjze8PWsaNydXg1nzEJPzvNBfNAanjAFJgNwQjYYrhI7oVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d2b630-a1b6-46ee-796d-08de80587ebe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:57:50.8405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HGBa+DuYSr+pvT5HYbE2JztQ84kgDATV995fG88gWJ8Tw20TJ2uaJ+N3xm+bNkesw3ubFBdd1+hRc5dEyviRWBXo55t4YCFHdNWYEHfeXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4689
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

On Thu, Mar 12, 2026 at 09:43:44AM -0700, Stephen Hemminger wrote:
> Fix comma operator misuse warnings with clang compiler in idpf that
> was missed in previous change. Shows up  when -Wcomma enabled.
> 
> Fixes: 57560a92167a ("net/idpf: add AVX2 Tx path for split queue config")
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Yep, this was missed because the previous commit [1] was on your tree but
not applied to main, so missing in mine. :-(

[1] https://patches.dpdk.org/project/dpdk/patch/20260219152302.2103018-1-bruce.richardson@intel.com/

>  drivers/net/intel/idpf/idpf_common_rxtx_avx2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index 4e1062f22d..db7728afad 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -842,7 +842,7 @@ idpf_splitq_vtx_avx2(struct idpf_flex_tx_sched_desc *txdp,
>  	/* align if needed */
>  	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
>  		idpf_splitq_vtx1_avx2(txdp, *pkt, flags);
> -		txdp++, pkt++, nb_pkts--;
> +		txdp++; pkt++; nb_pkts--;
>  	}
>  
>  	for (; nb_pkts >= IDPF_VPMD_DESCS_PER_LOOP; txdp += IDPF_VPMD_DESCS_PER_LOOP,
> -- 
> 2.51.0
> 
