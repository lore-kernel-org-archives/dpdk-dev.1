Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2E606A325
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nT+BbnV1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48EF140283;
	Tue, 10 Nov 2026 09:58:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 4D3394027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 09:58:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794301097; x=1825837097;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=n/BtVRAMQ+Dfb5iGqZ7+pYtulnJ9ZseCB4on3h+4uAM=;
 b=nT+BbnV1wGn168lMPfKKQKx8mp1AHOBZmUAfAeIcp8ANtxGGR7IPepd8
 AztaLuqZG2fKImfKKblGDDkSeS0mKrUppeMtyFzVRkgskqsHQ1SgSEUIV
 CDaq0FESp6qupVq/a//AawQ2HbfGpUQIe++o1XZjj8NhqVWGxqpZ9TRxl
 Bfw82v/8ECUe8tr7SFEg5NSJsi4JvoRqtk4UFW6m6Xu1aYBzjp0kPb6Kh
 sgFCdy1tJl34BSsLzC/+kp1m7J88hNszFZ72V0juiIhNjEmmlMyMGOIcl
 s5HGnpXIRqoE2vQPdaHJ13hRVk9OeC0coqZAGm6Taz1o79ko+powf8AtH A==;
X-CSE-ConnectionGUID: 0dZzprxWQZ+QV8YR59V4hw==
X-CSE-MsgGUID: g3qv0cEhTzCbqUiQ0E+rHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2919058"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2919058"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 00:58:14 -0800
X-CSE-ConnectionGUID: 2uxJcn4eQYmj24q7o8wQOQ==
X-CSE-MsgGUID: L5N0KFRCS3KGoV2uRpGhwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8426471"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 00:58:14 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 00:58:13 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 00:58:13 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 00:58:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylo0nZxOhboY5H14lV0A0RAGhZbh1y/NoWKQvV165UQ10icy4JydNQgg+QrezIGU+/B9F5bYJyfk9xYJJSFnRJ3GgO9BoaUnzaviwC4rFGzfs4qoTlZ1cka7TO6e4IzrE62DLudhP2H1HoAbZju2upaVJ407a6NWngrewRuOO2eh8XllvlkF6Jam+4AvucF1TW7iHlkm4JnLiqSLoVVkafIYf9eSul0m6NPDO5ysDcO/mmXN/jg7TYfq+9Mipf4eVrIhC35ISKaiyhOWPRwkyG70DOLrXh7pQWt+d+2i5vjAogHL4+QatPqzCX1MGE9kMvH6k17g3VeIaMAHLu/CbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQ9Fpw5OYZJXEBIgkU2fBhCk77RlkzYklrOhm+9PBSw=;
 b=oA1PQVOKU0tis+FPvg8u1XrIiiKxXfD0wcjOrCC1i4tc5+vQ5Cbi/qRib+lzrUCXt1YhpbT5oP6psFbLJCt31SHqJQWtGecTa1ra7YyzZaDR8+MJgqnsVZVogCgjp/JHuBba+/K0egUpsOvGoL2T43kjfJ366Bm30NJkynzgFWlKest8iX3lE00fmgmJH78T5Sa2H70fNdFSRNZuR90FuxXa5jHLQ/0e4p8wpi6vYPHdGADR47HYpwN4WtytTVFBpqc/RnSjIo9MJoBjTbH1Vlf+9ecPyLee9XtZEEX21F7ttOw6BzZQTIztdsvcreSUluYGXaZX98JHSyniflYbwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV2PR11MB573934.namprd11.prod.outlook.com (2603:10b6:408:412::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:58:06 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 08:58:05 +0000
Date: Tue, 10 Nov 2026 08:58:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jerome Tollet <jtollet@cisco.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/intel/common: track all RS buckets used by a Tx packet
Message-ID: <avLcmBR67AnZx1Qg@bricha3-mobl1.ger.corp.intel.com>
References: <20261106092514.76289-1-jtollet@cisco.com>
 <avH640eh50oIW3ev@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <avH640eh50oIW3ev@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::15) To BY1PR11MB8080.namprd11.prod.outlook.com
 (2603:10b6:a03:528::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV2PR11MB573934:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3676bc-575c-4fb7-411a-08df3f08bb76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003|261102123227099003|261026140227099003|261022075727099003|261022113327099003|261022105027099003|261021121427099003|261021123027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: PVTpkZPnqe8McHMn1EmxqGeqHlRivXwmKcC8Qg6n1C5a7OXFzV8IIwLR66VHYdQkuXYzQ9Q9tm0WRjIBkGZJZ9exdI5uNPK9C7ntnyeY/m6OxBnoaa7RDkZ7tV1hPKZqqDYBKLnWdHRCTjjWnUAo4i8I6cJQ4kgCq6pxDd7TnVPzaSd9BnBXjUhjk03poSwmsg6HetXzK5CloH7BXGiePHPSA1KlTGFNSnsM//n/savFG552MLxkBJqcABMk6/4S4nO2+9m/t72KOThCz0Gvxkx0YVJgRjPH3wCkCVPfeYCLm0EaKbipZk7T34uKoYa4XYsXRTwm1srWPF7MPc7ProXJXMwFd7qe7wryFX3gkkWnTskI88ze6Tuv2nGE+lEbMGb7gFQdd38MbWbQHVzNnOxMWH+k1uSa4XFnAAh09jPfTeaKmIeYn9TKFAn87SgrwwqBP/1zW1lt96zvGc6g++yDI/V/09/s5bNFAw8Gp+VdIFnX8OAJoT+ajV80pd2vxvDgt/vXxpSGrTmUxWmzYmeDDoPMKVzKvAMQi6Gi2mOaG4LBl/maZIS+7/R01XD1GFJsABvcej9vSataKGS0XtmD3eWRVRDP0r2q7hp/CvBSVh7ZftFXT2jP5geAK4pEEki7XzZJJ5R6rcggfmdQnOBpiyXPy0ZcwwOJZ07MTPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003)(261102123227099003)(261026140227099003)(261022075727099003)(261022113327099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CXItr5UjkwwQBOzrQeUCIL/ehcSU40cX+p+WNVbqsijRqlPa7LxhPPe6HRdq?=
 =?us-ascii?Q?XeCsuTrAT3jW3ebabxVl9Gaf1aRw7V1a5/q+D3M5Mj2m0wtcn6VW5wv+vDlt?=
 =?us-ascii?Q?+1G6kW89QRqIHh5IFEu4T5AhJshaxhCOq/av0l28VRtszTKtiT5OF2UZN63F?=
 =?us-ascii?Q?E8rnXO/iu+Dik1xzTs5E1eINL4GTH1plBGUr9LY2DtbEbOEBneM8SJZNWsKE?=
 =?us-ascii?Q?9Owbr2rFyIlKLDKlNqOFtKtijWkgvFZqfT/FKj7LhNDDuxEfFTpDCaKIDp8C?=
 =?us-ascii?Q?iRa2OKZ+yeB91Mh8RnbHK7fi3ovolx6wy+NFNVCSojRa4n2TD61cnclPfP+n?=
 =?us-ascii?Q?SNXzhVguKrS0Vpf8QkGpFwE0rywSvp2E7lb6KzL1akdnzVWe47WS3Tw9NMlT?=
 =?us-ascii?Q?zyucoVUflqF1KQxQJw3gPwCyqS3DHC0swl28w5BpMlINHBUGEyXfRN+630J3?=
 =?us-ascii?Q?i1J6wrOxXMJT49+GwEdntKVRqoBl6h1Ro38turz4MsfdAQUzjFH+qqtOi7hK?=
 =?us-ascii?Q?A3/57AryQQU66HdQ+tZjXEsleZI/YSwCYMqjoch0vSrbAbJrzjyVyBCmlOY0?=
 =?us-ascii?Q?FqfBURu5SEdNtiajC9BL9u16TNHkHQAXLfTWWX7Oh/uj6yv3meFZe8iCATyM?=
 =?us-ascii?Q?weOs1cHwX/O+l5n6RvWc/cgorBnd7vxLpCz9MQ/cHOVjr09VH9SOAxUxsD9+?=
 =?us-ascii?Q?AlIIqn0PsiRqTouvlSCnFVXzNrzPU1If9P2uLzQh3z3qCXz4aHBuejjiSMFq?=
 =?us-ascii?Q?96BA3NnWH3l7ohWUHxb0dr+xwVxmv/BUM/z2NXhYy5DTQZszpctWVmXJF9Vq?=
 =?us-ascii?Q?67O6291s0CfHjNfwtj5qzLpdpsLFGLL+TJKh2Ve3q23GDGAURtND6Rdceeyb?=
 =?us-ascii?Q?4iKsAiGquNaF84DvUtf5rUlUVtTt6fvdcDIIMAMb82VKemD1NS1UsVMKBkwD?=
 =?us-ascii?Q?/EEcXzU9ehPmxnTfSZ6mEIZGJqu17wAvDFAoZw4dSSNHOQMrq68pyPBbS5bl?=
 =?us-ascii?Q?S2Gj9Ana6AIRLN5fVW9Ci00VPzXg/Efeb3IIAsLhhMtKxoKH5TgUaj8FR35D?=
 =?us-ascii?Q?cCoechlG2YD1bAVeIBHBV0dfinTSQh90vgUkgfjgWMv0Ree1RvHabsy+XDVm?=
 =?us-ascii?Q?4MLORK6jqrEzr8MdbtduFj265e61CWJlmoaBeubDjzbhKAKKQOs3FCZxj8FX?=
 =?us-ascii?Q?3be8B1/pxa6YE1Bfrleaa/tMB0GX+c15MiY+oEgpwAH5hQLcqb7iZ9xMrT0j?=
 =?us-ascii?Q?RzsUTUW+xlT0yar10mEp7fNn2eICZux4chDZrIh00S0YIwjAWpXAJYhnCDAy?=
 =?us-ascii?Q?ET5bj+1CzWUZrFnR156mMGsTIa30wmvqdrkUFYX2jrj+r25UHRXR3B44JaYJ?=
 =?us-ascii?Q?xJ3Lhfr9O8CZ+I2En6cCYbwbxAzro7Mh5W6+vT/q6plegadzBN9zw7Nwf8OF?=
 =?us-ascii?Q?5A2w3KDPErUq31z7Ukr/ZRibKJMjaFUmav6912zU3NZqPFitOaTsTrgn79Ev?=
 =?us-ascii?Q?z/Aq4hbxYrvUtywagK7Uu2vL47cO/+uw8H7sCK5nnoixIA3zFdcdtoHpQ5VB?=
 =?us-ascii?Q?QqmUX+fe1BwBwx/+UnI83Mf+sol/C0gWF91dy2PJ0rzNxrJMblYXgu+jYH8C?=
 =?us-ascii?Q?I9HzEp7FdffIuWFcodaraKGM7pECq3GVF0ap/HuWb2xbd8CxX/Q8irfoo1g8?=
 =?us-ascii?Q?t8RJsVrkNbZPWKHdU8gJGmdUsbZLu8AkgIkzqvp7OGyD4Z+gEttddoOdPze3?=
 =?us-ascii?Q?zw+J0gQkz1Vkib5x+i/jBw2UxQ8qsfs=3D?=
X-Exchange-RoutingPolicyChecked: mTJ83zI0azY+9H7/38/kMeAUSYM/FYm7TksFCmNMQlkWoO8GrHlrpgc3jI5w9pSXfJ/4MVO19LnFxxGrxKbGiBq2KJAMkwfNOKGsnF/jPjRBySlA+mC7MvaZfhh0vCWg3jRFhYJp50uH5JmBCSAAi8Dsu1M41VnCOWzxw4qvFOryHJbMWUO8SjlzOQ/IwQAjQO05bo3uGRztpeQ23X/YYUe19zze2tyo60SPbVctn5vT8B0SSnhcPD12WoO1bKKyhoXa8223i1MOTWc8Z7zSFqyoeHZP8HJO3vGbKBL/zij7446BLa5LMrTTsLelmgofhZ/IF+pARtN0g1Axhj2QqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3676bc-575c-4fb7-411a-08df3f08bb76
X-MS-Exchange-CrossTenant-AuthSource: BY1PR11MB8080.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:58:05.8219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mDMkY3T6c9muZe3Q4OK2Zj9ds6lJY+EeMSJEsV4fb4iiTSvOh2snLpQwXDaNwJfBu6Ft0VhPp4bBkLHfMOHdrHrOA1smNgXP29gnuxQckw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB573934
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

On Mon, Nov 09, 2026 at 04:54:59PM +0000, Bruce Richardson wrote:
> On Fri, Nov 06, 2026 at 10:25:14AM +0100, Jerome Tollet wrote:
> > A TSO packet can use more descriptors than tx_rs_thresh. The scalar Tx
> > path records the completion descriptor only for the bucket containing
> > the packet's first descriptor. If the packet fills the next bucket,
> > that bucket has no completion entry. Cleanup then stops reclaiming
> > descriptors and the Tx ring stalls.
> > 
> > Record the packet's last descriptor for every bucket it crosses, and
> > wrap the bucket index at the end of the ring.
> > 
> > On E810 PF (ice) and VF (iavf) with 2K buffers and tx_rs_thresh=32,
> > 65K GSO NVMe/TCP traffic reproduced the stall. With this change,
> > 4K and 128K CRC tests passed with TSO enabled on both.
> > 
> > A standalone DPDK iavf reproducer, with no VPP, sends a 31-descriptor
> > TSO packet followed by a 33-descriptor TSO packet. Both pass
> > rte_eth_tx_prepare(). The original PMD leaves rs_last_id[1] pointing
> > to descriptor 0 and stalls after 991 further packets. With this fix,
> > it records descriptor 63 and transmits all 2048 further packets.
> > 
> > Fixes: 8f4396b9f63c ("net/intel: use separate array for desc status tracking")
> > Cc: stable@dpdk.org
> > Signed-off-by: Jerome Tollet <jtollet@cisco.com>
> > ---
> >  .mailmap                             |  1 +
> >  drivers/net/intel/common/tx_scalar.h | 23 +++++++++++++----------
> >  2 files changed, 14 insertions(+), 10 deletions(-)
> > 
> 
> Thanks, fix looks correct to me, and AI agrees. However, I have a few
> stylistic comments inline below. If you're ok with it, I can make the
> couple of suggested changes on apply. (Otherwise, please send a v2)
> 
> /Bruce
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Patch applied to dpdk-next-net-intel tree with suggested changes applied.
Please review in case of any issues when adjusting on apply.

Thanks,
/Bruce
