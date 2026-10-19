Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629C3606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SjJoQZCA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C251640609;
	Mon, 19 Oct 2026 18:47:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4309640608
 for <dev@dpdk.org>; Mon, 19 Oct 2026 18:47:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792428451; x=1823964451;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QVu4ksUEDvlPO7tYIRK6RCnwbwzV3MtPA3HkVNnKU9Q=;
 b=SjJoQZCAxP+9eFArKIM/+yf+6GTi4DeskGCqIgxVvHPSg4H5h7WziaTC
 HK5TdxZyDotVmi1Vl//y6uR7/N9GIgC5qnPRxadui5jHgOIV7zoIrGRAS
 N3rp0GF0zlvsVR8hRddhlv+/qE7egbS7H9CvK6mVsLNqwRdzFTFXxZPM4
 XoG0eKeVSQl/3o7YZAb8uweib6NdSIHNaIVYN9hBiL3rDcluJMUUKr7tt
 xnNRrcNFIuKymV6HDDGBWRFb2aDPxn0tK12KET5JTp3NLDoH0EpFpaXRb
 IyGfbmBwSsDZY75LHBwOkQpLRkeYIrk5Wl1/jI0xtUg1ZBQigHdgeEDYs g==;
X-CSE-ConnectionGUID: P6SiOLXwSX6C67KxNZfNIQ==
X-CSE-MsgGUID: trREmM/dT5mK2hvLvl8i0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1135316"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1135316"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 09:47:30 -0700
X-CSE-ConnectionGUID: I/hTb/n7TAePIXSzJelA9A==
X-CSE-MsgGUID: pvkDt8C1SlOeztyMxrJBLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2651397"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 09:47:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:47:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 09:47:30 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:47:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymXkAmR+8Dd/Bb26HZLeaf2InPFvHLmeEFHnsejxdmxfe7RDt6tm9pB8nZeo5q+2WJx0I1XLYnNwF7TW6O0CgPQotieHhdagf8+j4mQ47iK6rOkit0+PaOCHwGUs1eRIQ2GCnxYrBLeaUSYgMYQ6ROSbAYzpji3gJ3ePxhKV+cToYH7bI54szp4BDoMYy/fSMZCZA9goN86VPenWhNVHoVJ3ctqk8JCfvduKWen4Vh+/wIM2co0nw54LE4Q2uMTwoTGGYQ3MKuBWzxirfSVvRD75mA9MuO+TR/ZHVbvwxf4Y2QSFsXNqBiTT3WCBTgyOOU1g2pAST3MOflU7sME4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+uDy2X5ixhd8DScYxQMo1JSJ2R/cZvYOR4stc+w4EE=;
 b=QpZ6KZQfBHWkNyI7dVvN2hYW9BytauXwvgYZvroib56wvAuu5E8YV/zUNUofhntoA9lNGNUZjSVMJQzaDHoLfHBVo8yzPMNGUOCZpo+V60eY6SUS3RjqcFZQmdfmbL7YyWph/YxSfIq2uIu0RBb0tmXJ4MIZv0/Eros8GnOqOYY9jkS7VfelSSukkSqOgjBsVkyAi2kzPxfkFGwC1uaoc+cwOGvPgc64B4MvObGR3ltmKyXhgiKe7NA+e667wRCO5H5al610DdhBUaPnwD2XY2TDYyusuJVvJsqfNjBzEcpC0YLVxCL086DMds9A2bXMSI2UrjeK79SqrlVJc4ct5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 19 Oct
 2026 16:47:21 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:47:21 +0000
Date: Mon, 19 Oct 2026 17:47:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>,
 <anatoly.burakov@intel.com>, <marek.kasiewicz@intel.com>
Subject: Re: [PATCH 1/3] net/iavf: fix invalid free of queue TC map
Message-ID: <atZJlMewvnJu781L@bricha3-mobl1.ger.corp.intel.com>
References: <20261014122419.631288-1-dawid.wesierski@intel.com>
 <20261014122419.631288-2-dawid.wesierski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014122419.631288-2-dawid.wesierski@intel.com>
X-ClientProxiedBy: DU6P191CA0050.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::13) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH0PR11MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e246e2-3f3d-40b9-d609-08df2e00a4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|10067099003|22082099003|56012099006|11063799006|4143699003|261009223027099003;
X-Microsoft-Antispam-Message-Info: rtCEbFDXI6uUDY2mRpQ2Rfm4PVpHgYD5U8/vcn2Su3/kn6nbeRSZfSacQrumdfL2uDEbqXkmWuXiq82yWPnkkxRgbc0X5o9otZ85T1hrekhj3FqaFrD4f7BRm6Nk2fl62+XabmGYHk3RAeruOBnt3NXauIyJ5CNjQN3GpIZGHvtbX8HGw9FtxeJ0UvVg2bf6Tu2FiXi1Z/DMptLlBPaup5zSEfbwh7OPeLe3vtkDAc4QXMSKocIHDxBekHkyd0rTG53C63v0vA6lfrfa5BtKTs28J2JDlXTkPiHQmkBLgk0lkwY6SGkkKx2Ci02woq4gIqY5WW/XFjlXXZgqbAvxawcanRl7TzegykxWzoxOLs9aRtyYfIGBXFd7m28efFv/NFstDQfECVMzSmPtPUpsVbauRHrs7i6JU35Fmd9eCZ6lYBATdoCwyTKsIAMY0vn0VD51xHAv1WvWqw9GSUlkD4pgHiVb+d0dx8OG9AuZbfnczAlZrVzyv3izZkh7srCcPA8EgaRHIo/n9Ux0rWDWRROWi40sb/nmu42+0NXsYY0LXakd8X8flX3hQZFQNTKaKIexdEjiK3emvNPsFLGigg4H4/azKSH/qw9pRzypU3lXEUMlaHUV6ImBYlOQURaQPwpzSp97SXv3y4OAYsNGo3+owJ1j8E8F1HK5zmwl+Us=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006)(4143699003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kQbcLwbV2/0Hb/BRu9hDDblnPv/zuXwt8hsL87QCjFVOhtt+c1iEffX+630z?=
 =?us-ascii?Q?fKp3o1dSXntipynx4CxEz/JBIWTeyLl13oSPfbPC/z90xxaXgZSOSvgFTDBc?=
 =?us-ascii?Q?g63+e+RyRg/Kctk9y5KXDOIOulU4sxllhSzYcUuwLJLBwmNIxSylKIlRCYqZ?=
 =?us-ascii?Q?duartIfZ7QoXnqMo89h65f3dvV4S2P+jjo5XgSrBlf9GgWjS0Vg1cZ5G0qp2?=
 =?us-ascii?Q?Wha8q+Dj3fLNie05dbOZfnYo23JdeCDv2k4nhMb/iNBfvzmsNn/CGehCFpiD?=
 =?us-ascii?Q?A8wXPrSQgXl3EBAPqR04vjiiqYwPhBhXdKQK+hAIDIoo6jywJXov9dvsmzoU?=
 =?us-ascii?Q?6pkN1vgCzU5XRStEpt8TFysATjAZ4GCebZ+mSBE7BKBGZ0omhN9o52hIFW4A?=
 =?us-ascii?Q?45cWedW6EzNMCSCIpvN3ICnBzCu9EvL/f3MDYy+V7B5pMnUgn5+Pku3mR35C?=
 =?us-ascii?Q?Hv8MDbrs7wDy1knVgoLvc7K83LKN7ic3dJpUrThDAIJ//+qCAYFBstRL83i/?=
 =?us-ascii?Q?zJKTB0sUpUc9Zn10KriMa0cBDyMvn7zoXHHHjfbjIXOzm6084rgPSKjIGlvI?=
 =?us-ascii?Q?esB2iMrdqBxkCbCduXhXJmI11tRAMrHBBX46hb1xjgAR5mXFRAk+t+aQmY7/?=
 =?us-ascii?Q?wjxOQi0Tljb4gjANNG4wPWKpJRIzWjbMN5BkCrppCexfpvdxlGVuxdD7/Eyi?=
 =?us-ascii?Q?47WLzdonqq4AJgxiWNR9MD7bIydfld78DmQKnjEa49H5AFz9I+cV4XVP7li6?=
 =?us-ascii?Q?V0dLZT8QoSw6aBy5BzubTphrbpe5Vu2jzi6dNACqYG1Jtx/4ihnUp5qYx3nk?=
 =?us-ascii?Q?4zjpVHj+jTFBvhVf9/Bn80RnOMn1wo+b6ieR8q/aZcXs5o4BRCKVkbccCE7e?=
 =?us-ascii?Q?7U4dIpqQwX1Bbh0jXbXo9wDkskVS03CPrj2BE8HJ3Tyq7v4A5PlTNIJ0vhoV?=
 =?us-ascii?Q?Z+NJGdKzze84AzSCzvDYZipyavrx3J9svXfu53nRAWqbMmeTOUsY8oY4a8Ci?=
 =?us-ascii?Q?G7WZnCD1WaX0jMiPsLWzh7tRAvO7tRG6RDUniMRsQ7O9h2e+HKbBzTT/tVp4?=
 =?us-ascii?Q?2MctH8MNjUw3kZ2L7NoCYTCCRzKPqB/KwHubOHtnioDCQVuljEIOhwHm++LC?=
 =?us-ascii?Q?TgSM6D/w3koV3BgyAyE7Y0xFsaT4gx2xRkqwlQjCA5hpWQrPZmYPNE5cu/6t?=
 =?us-ascii?Q?5SLOEc6pnGjkgYdlwXYHKVLXGUTlICDEkLHcQhl8UNTIECIJNDa9PQ/KlDgx?=
 =?us-ascii?Q?b1MU+3gLgZ1Prfn9lRRI/BDT0mUpxGx0s2H6sVu733vCBSHrFCjSTOQZe6G7?=
 =?us-ascii?Q?SdtYYWScFzjTBMKCVM00tnYuyCr2OJfWk1zZ9QuCkQqvBu6JQmNCxRbmBek7?=
 =?us-ascii?Q?2kQipH327/EaJSPPAGSJ0nd0pBmuS5cQwGIKWC1IwLw/qBinGQwTjvHLrntH?=
 =?us-ascii?Q?ramlx7KStLuuWhHNPn7uQiAHnAMe5J0w6ncRD3aWzVJIaELGMruyh2GS0x7C?=
 =?us-ascii?Q?MLEq1sWOEmo1hCi9q+50wuYmbMKylXvoXQwa0P6rCZ5fT1moZfyB16BDK7Xf?=
 =?us-ascii?Q?w9QfRXOhRC9a6akN6T36SBG0EsU1KriXq9Rl67i+uaA/BP13SjK9zRkWlEBZ?=
 =?us-ascii?Q?RDn+rCgl5bFK5LXicmic/4Mv8Dth8LGO3SgHMg7K+vY/kZKfv+0anplmt1Q8?=
 =?us-ascii?Q?SryDutUnJXt4Wgc9Dhun9/CPb/JMkiXTFc9DfelAXL7o0GeE3oBNb43FCIBy?=
 =?us-ascii?Q?rcIik8SuxBiI+4XVU641hzuNjHFPWts=3D?=
X-Exchange-RoutingPolicyChecked: V4HGSce5BYJVqKLhY5MU7UtzZ7tFawYMxgACV+cT0PxKQcjgh92RyS0SSyYf4rxRzvWtvbSrHbzwgC2evH/VsI3DwqilcY4YWaNEHf47E9jSdJsOOscmCxIbob27no3MU+ItyK8+Z+DIHpBxbJRCk80tBSEtqwPqukEP1E2DM9s3D7AuXwc/Zp5zm4ZSqy3AxEfBh+WH/6p4IQZYc8MG8YqDeezBr+AXklpivvrikmzodosojtH2XL2QyeAN5mO4Fpuzd65LTqkDLEDIOe8f7LgMHq/TAWT/w2DGyubLkWUDygg426XsW37Fc71mKHrIbMNehPCyTeDHsRsqFcztvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e246e2-3f3d-40b9-d609-08df2e00a4f2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:47:21.5371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmqkdXYKPd2bKFCs/+4Yx0OlCZ9tcZt9iltWsYKTMFNbVs3S2doaAQQw4EuEKdMzAx3t9CLFqQdd1vImC0x9OFvoTkzOseZ+A4UZAMw3JVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14, 2026 at 12:24:16PM +0000, Dawid Wesierski wrote:
> iavf_hierarchy_commit() allocates the queue TC map with calloc(), and
> it frees the previous map with free(old_qtc_map) after a successful
> commit. A later change added rte_free(vf->qtc_map) in front of that
> free(), because it was written for a tree that still leaked the map.
> 
> After the first commit, rte_free() gets a pointer from the libc
> heap, and free() then releases the same pointer a second time.
> rte_free() reads a malloc_elem header in the bytes in front of the
> pointer. It usually logs "Invalid memory" and returns, but the result
> depends on the contents of the libc heap.
> 
> Remove the rte_free() call. free(old_qtc_map) releases the old map.
> 
> Fixes: f6e33f09f766 ("net/iavf: disable runtime queue setup when rate limiting")
> 
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>  drivers/net/intel/iavf/iavf_tm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
> index fc84bf7e6b..603da09bb5 100644
> --- a/drivers/net/intel/iavf/iavf_tm.c
> +++ b/drivers/net/intel/iavf/iavf_tm.c
> @@ -913,7 +913,6 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
>  		goto fail_clear;
>  
>  	/* replace the previously committed mapping, if any */
> -	rte_free(vf->qtc_map);
>  	vf->qtc_map = qtc_map;
>  	free(old_qtc_map);
>  	if (adapter->stopped == 1)
> -- 
> 2.43.0
> 
