Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8E6CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 08:10:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 069FD40DD6;
	Thu,  2 Oct 2025 10:10:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id E0609400D6
 for <dev@dpdk.org>; Thu,  2 Oct 2025 10:10:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759392606; x=1790928606;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=P7OtLf+cVXjUWcreKn1uWQ8f66PZHFWptYjyop7OT+8=;
 b=YHvOiVOiHdQO41Y5YMmjRH3PUi32W4yF5t6o9QhoQbBOC09YOS1UnJaC
 56vcGUBz1nPvmcDRHOw4lggrs3T7wRH0YXvdbE30JOi0Hd+eCaWVl4Kta
 u731DetJBQv0h7ClWhK/E/ge1LxOOP3Wlflh4Poe3YTTxYPOUw5zLKkZ4
 dQvgHbHmKtsk32PnUh15XZ9UuFmz/59wDLMnJibbZdB3cs9pmiIKXMbhg
 zGShSsRWektrimd6eY2n5ZuHy2z9hseVuOqfXDCUUS3MpLLLNcXqTzeJc
 TBIPL/H39A7c/9aA35JoixNjDbhVNdmXHn/TrXV6tQk4n54tQgsJRrIwT w==;
X-CSE-ConnectionGUID: +qhz5UecT3qMFo0Y/vmVBQ==
X-CSE-MsgGUID: 3zdCVxzwQvSOsoVoVogNMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="64292190"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="64292190"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 01:10:04 -0700
X-CSE-ConnectionGUID: AZimUKlURUOOKBdgAxMyEA==
X-CSE-MsgGUID: 1q/kwyzaRGW1K9WuZ6nDhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="178103896"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 01:10:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 01:10:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 01:10:04 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.56)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 01:10:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaHsiY2QuakyJzcpc5IbxMIop1+nW3Qtb0/obUesCEYuYv6jfuGFDUYz2gPy9eLXbu9EmO5FCKVpxJuYVMmUN8SVxjzeUAZYXsq3hQ7cTIitcE4Bz4Qx9aVKj3149PGZ/B7xZg1Xk7qwyZl4s18GwSQNXFbkTI3rWigHI6GyOqoOYhtnV3HIL8KBlma45rtnvt3LjsZ/29KUOLVxdNp+d5dfPheIPYwaAoeFdptlgR+RiMO4qFy7jY/3RrQpCRfzTqBJL+lgMTnU2ZiD1nd7muiqgVm9dct1eqr1cVYQoF8lkGRnNxDyEWPX20k762p9dJFDfqmKq/PrA1lzfs6cfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrzD+08PVcWSD//GVw5vr5oOfbESxYgGMo8IfxCQYs8=;
 b=gE2aGNsFtrlNOiY5H0O3lAmjNqn8COe/YagSTtfU+WYWMDImOSrjXfay5wCNM6bYRVJGnbpL1fAxYJVpheXxgG8V7UXnZT8NM/7KFRHYMSpgleNEyA4haGsed4+nYioze4VFpY5LLutsme4RSgEZVBMrvroLH9p9Hs7R9NZ87UGHHhuL8SFxKqxDLr2EHKKzALKTyE73FeT9xDdCh21SSt1RkeizBuie9iXR1sYVuVrXaC5WuPxUPjZ1KzA7pKe008XoExsiL/UPE7uXPjHkDYfpdAbwWjgjmBRxg2lhrsVfGnvc119X5qF8JZRv3EsifyBlQtxMj3KRQNf9HqLj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8659.namprd11.prod.outlook.com (2603:10b6:610:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 08:10:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 08:10:01 +0000
Date: Thu, 2 Oct 2025 09:09:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Kai Ji <kai.ji@intel.com>, <dev@dpdk.org>, <stephen@networkplumber.org>,
 <gakhil@marvell.com>, <konstantin.ananyev@huawei.com>, <thomas@monjalon.net>
Subject: Re: [dpdk-dev v5 1/2] eal: introduce rte_timingsafe_memcmp() based
 on OpenBSD API
Message-ID: <aN4zVGzxTDI5Ch8g@bricha3-mobl1.ger.corp.intel.com>
References: <20250929145049.153078-1-kai.ji@intel.com>
 <20251001153242.55987-1-kai.ji@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6548B@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6548B@smartserver.smartshare.dk>
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b411e75-62e1-4d13-7bca-08de018b15db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?5dmfjRapuqYvSGpV5I1HAi0XRLeFJp98YGsvm3GEAXzYPUkAQa3eIet/iC?=
 =?iso-8859-1?Q?fh+yC3APGSm09KtvALRRWt1FXQ8xUBxPGA1v1jVV8xaxvariVJfm5xVSOz?=
 =?iso-8859-1?Q?XWpnAVLGmoNCcS+qNapp+trINBHLrnLSMAXHPjpFPIDP7Stcv6W97nVVTU?=
 =?iso-8859-1?Q?LnZ5IWbCkPqiuWOmHcfXatcy9/0xzu+rcQRqlH7ANczS4ZPJIk4wf0XPnu?=
 =?iso-8859-1?Q?gROFnuCS/WfFZht3e3l3fJuy0VYSBxbGPKMxwQwpRAFtqeRVnKzYc9lL75?=
 =?iso-8859-1?Q?LcbolQS7P6ydBsK1u8QWzkR1K8ahebm/drTztHsD7QHSywfOvNAq9TOO5L?=
 =?iso-8859-1?Q?aYCq85+PYTyXpjBplzaiwNVh11RtSp/stpcif8uGEzpNpj41UK8dH+AooJ?=
 =?iso-8859-1?Q?ZwnisE15hpeNvTrm4ZF0GvVJWKQEJfGAUdhQ4M8UlEH+FQfczdZrTkB26A?=
 =?iso-8859-1?Q?B85B4yUdnzpHEOZnm6k1KOzNIKbyEc82Un+7GvlOCgm9GZSCM6ut5oia1X?=
 =?iso-8859-1?Q?O9sxozJIWTxr1SGKRw5pe2YLJ7EA9chQQHNgsOmUbia2Ftcemvh20rWKLo?=
 =?iso-8859-1?Q?5hoW3wMsjecsKBmDXbwqyD6silLl5C2FIMIHBgzxBnv5Dl3LEUdI/aOpB4?=
 =?iso-8859-1?Q?1TCaW3oRfuqJDuTQ3HN5G8p5B1jkiGWHcAnW6F6H+FYWZ0Iq+9m4qucoLu?=
 =?iso-8859-1?Q?Krl4t5z2NwcON9HTlhqr7c+aTDSvgq5LU0ay166S4QjZ5jhylNOZalCMRX?=
 =?iso-8859-1?Q?c/EqKqlm7WpE+m7lSsCXTp4/vjGEjv/Yi18oelFmZ56IijjCkm4X4CI9OF?=
 =?iso-8859-1?Q?1yiFc7RlgXHrXrqt+MBO5Jwf+3ZfRhkaglJi60NhA2Lb7zDY0okpzm4Ra6?=
 =?iso-8859-1?Q?fET/XCGN08Jd1OWM0A6BYuG29lQSVqN1VOjrlINWqIB7+nU4hhrAyY0kAx?=
 =?iso-8859-1?Q?5zaUyIAIU0Lb6/GfvoljW+mTMPGuIVBJH871jJGXHBfKCjBdyOipW3/jGR?=
 =?iso-8859-1?Q?cBCXMLF/vWQaR3IPnhOxAArWwDbvp1SPmKHH3WuHc0dCZkv81QtCZ8a/Oy?=
 =?iso-8859-1?Q?D9T7muYcbyoaf4ct+xoZN7b5w3Q8gZO7pZRSbODV+TL6rLTS6nPImMgSey?=
 =?iso-8859-1?Q?fb6BYMatYEcWNWClzj7HhTBOI2wXxtzYnj1M9fwm1VugDi48ZD4KVtNGvT?=
 =?iso-8859-1?Q?mMJ1/PvRtDK2XACHOdkepWab1LFroiZMmS6VuJDRzjJSsfaUGIUE8n+Qic?=
 =?iso-8859-1?Q?2ZcRu9yJf7mgCb19uJ6Xl/7FgjCARM8t2efr6B4IJ7PBh/kxlR5Y+45lus?=
 =?iso-8859-1?Q?cpOebWCdXCO8nv8HwOahA1xDM8tWOeqDJeHz1DpmiUm1Je+yYxtAdtRbs5?=
 =?iso-8859-1?Q?9OkeNT4JxIAFt7gWSzlu01jpgiJ8X/dNTUZbtAiUQ17cbcOv0/rK0wtEYI?=
 =?iso-8859-1?Q?8nGn6DRClZG6KNoBE17cNKXorTFRQVoaGNBtYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CQBP3P27jALpfmHFtjyupjq3U2GnwUGeWNzjT8hdfsyuebS8btwGYS8qDY?=
 =?iso-8859-1?Q?MdYGABYlUXqAvjAGz3rIuSx2xEOHbR9PGKXAzWhALzeti57rg1fTmtkD3G?=
 =?iso-8859-1?Q?Edk2BIAxuHgY4RHZQtvl6sbdujmy5ft8E0+CuVGiLmKSYBnvP3+jacxZB3?=
 =?iso-8859-1?Q?RHZG3gvqKNlmQoekFcmWhzJjSvDS+TkhktaDaOyuhi8MaNygMCnwFMjfga?=
 =?iso-8859-1?Q?0jqjyTCg8OEqqkCkrGLGRbbePRUpE7sX2huI2ib6KzKR6oeaxkhNCdoVzL?=
 =?iso-8859-1?Q?jW7iS8+YN9NJhDRZZbB76hBRCh4778fL3cKd5Ug582yKBdBHQ/wiF9qomj?=
 =?iso-8859-1?Q?YXlk2raZrDxQXOCPG5FhkwGOAWpw8Qt3r+Fwg+zTwhXIprX1JlrcZUVY8C?=
 =?iso-8859-1?Q?MjN0GQIRzRB22awr6cYxNs/co5AX2WP1Xf9Fb0R6RN6uCFujJrDlEnCaDv?=
 =?iso-8859-1?Q?IjqzfTPJzzxx8L7wNN4TCKF3+VwdvNdzIZ2QsfVAq59VqW33YfqiiPkKmC?=
 =?iso-8859-1?Q?CPmNJ1fETeuoTX+cIySSBT8LOo8/7MqeZnpGkixSnzn485w4TsKvkkNX00?=
 =?iso-8859-1?Q?rEJQl0uvpHRUmPcFtTVaQzjuNCHbrp2Zkb1tu4cg57H36uz2BtgOKq0ymw?=
 =?iso-8859-1?Q?VtakVfmdMt8KinmIvyTXBqcNb31I63DwzU6bpqyDa9ezlXHWpd/B0CxAHV?=
 =?iso-8859-1?Q?xf/GUp6I7ad/5QjM1wFZ7AzgiH6lklfoxGVd6KD+ciW8rPazoon/c23MQ1?=
 =?iso-8859-1?Q?P5y55qjshyUS1u2/aVyQcsQILNU8nYuRsYiJOixNUvwssDPyV34gV4x7mi?=
 =?iso-8859-1?Q?OOlLhEq82YhOSimnEVMxGKt9qUajaoCULpt33M0M/4QTq8L9lhOUUxCWh6?=
 =?iso-8859-1?Q?PfC9vGQ/cEzG80AmDNrk9eIcSgyRVYue9CPD01IIC/wHQ/wqbnST0vDskj?=
 =?iso-8859-1?Q?jRA4AmWPvTdw7VQP0Wh/wjrPnK2ddYXTH0IXkSKsMC9kS+mu1UT6HMrbWn?=
 =?iso-8859-1?Q?FSHfYzDQVQWi/vYdalnWENABc4dF9AHf067nFhejQpyd2J5bfO6DDnB6bo?=
 =?iso-8859-1?Q?zQ6tibD0zOZeqRpZfAS6QWZH8PwgDWzxRBE+friEFoHD60aT/anc6Lw/Zz?=
 =?iso-8859-1?Q?0igTIlWTui8wSLWwpEFymoomN46ZKRqEjIfcFzPmPln4FWOHbKSaWYBcez?=
 =?iso-8859-1?Q?U5ZBqQvlNI5L2bHokIadHwnE82eeh+B5ZWVt/LNh/0eDSytH0UmiqTuiI7?=
 =?iso-8859-1?Q?pjV+64McBGs2P+uuOoxuE2YgV7Y0sVBAEX3LODJ+ydYp3WLT+OIULpke0W?=
 =?iso-8859-1?Q?2IqEp9yOIljpstEaFrL1m0Q2MsiWfOEDJAVrTYKWze+hk+QxVQkBJaBEVu?=
 =?iso-8859-1?Q?wRrfIuDz1BT0v1uvt11KtKNF+8IWnG++Ktsyfc9x3BSjrUrjrWNC50+AHH?=
 =?iso-8859-1?Q?zdGrzFEcDmuMTdUXZ8TWjDGKGsNxvy/997PnMunHUDdfiYEsS67hkKv1Ax?=
 =?iso-8859-1?Q?0Qwi3jhXiJzfCWyADKcf/YJRBzMH21+5sc21jC+AdIp2Npxn3+JXrPpCM/?=
 =?iso-8859-1?Q?zFkS16peCBhW2zMAft4qYrRMVYrnoE8GzOHzTojBFprq4yNh5ynaaV43Gf?=
 =?iso-8859-1?Q?W8ejWpMWhwsQbH2so1HmNc1NrEa0oEL6jgeryIDyaWjqs54Di4uFaPtQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b411e75-62e1-4d13-7bca-08de018b15db
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 08:10:01.4011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBxiHdBeZ29ageuqrL1BnUXsZC4lWvxKEIYxE+hrIO1rKGYgiqtDUFZXl1Rei0VFh1GfnTyUdIKhZ/V8/h3+1usQIM3FD9X8HPT5WZqROxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8659
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

On Wed, Oct 01, 2025 at 08:57:02PM +0200, Morten Brørup wrote:
> > From: Kai Ji [mailto:kai.ji@intel.com]
> > Sent: Wednesday, 1 October 2025 17.33
> > 
> > Bugzilla ID: 1773
> > https://bugs.dpdk.org/show_bug.cgi?id=1773
> > 
> > Signed-off-by: Kai Ji <kai.ji@intel.com>
> > ---
> >  lib/eal/include/rte_memory.h | 38 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> > 
> > diff --git a/lib/eal/include/rte_memory.h
> > b/lib/eal/include/rte_memory.h
> > index dcc0e69cfe..6939c1caad 100644
> > --- a/lib/eal/include/rte_memory.h
> > +++ b/lib/eal/include/rte_memory.h
> > @@ -746,6 +746,44 @@ __rte_experimental
> >  void
> >  rte_memzero_explicit(void *dst, size_t sz);
> > 
> > +/**
> > + * @warning
> > + * @b EXPERIMENTAL: this API may change without prior notice.
> > + *
> > + * Constant-time memory comparison.
> > + *
> > + * This function compares two memory regions in constant time, making
> > it
> > + * resistant to timing side-channel attacks. The execution time
> > depends only
> > + * on the length parameter, not on the actual data values being
> > compared.
> > + *
> > + * This is particularly important for cryptographic operations where
> > timing
> > + * differences could leak information about secret keys, passwords, or
> > other
> > + * sensitive data.
> > + *
> > + * @param a
> > + *   Pointer to the first memory region to compare
> > + * @param b
> > + *   Pointer to the second memory region to compare
> > + * @param n
> > + *   Number of bytes to compare
> > + * @return
> > + *   0 if the memory regions are identical, non-zero if they differ
> > + */
> > +__rte_experimental
> > +static inline int
> > +rte_timingsafe_memcmp(const void *a, const void *b, size_t n)
> > +{
> > +	const volatile uint8_t *pa = (const volatile uint8_t *)a;
> > +	const volatile uint8_t *pb = (const volatile uint8_t *)b;
> > +	uint8_t result = 0;
> > +	size_t i;
> > +
> > +	for (i = 0; i < n; i++)
> > +		result |= pa[i] ^ pb[i];
> > +
> > +	return result;
> > +}
> > +
> >  #ifdef __cplusplus
> >  }
> >  #endif
> > --
> > 2.34.1
> 
> NAK.
> This returns (binary) non-equality only. It does not return (tri-state) <0, 0, or >0, so it's not like memcmp or FreeBSD timingsafe_memcmp.
> 
> Also, please put the function ("memeq") first in the name, and then the extra property ("timingsafe") last, like rte_memzero_explicit.
> Like this:
> __rte_experimental
> static inline bool
> rte_memeq_timingsafe(const void *a, const void *b, size_t n)
> {
> 	const volatile uint8_t *pa = (const volatile uint8_t *)a;
> 	const volatile uint8_t *pb = (const volatile uint8_t *)b;
> 	uint8_t result = 0;
> 	size_t i;
> 
> 	for (i = 0; i < n; i++)
> 		result |= pa[i] ^ pb[i];
> 
> 	return result == UINT8_C(0);
> }
> 
> Stephen, agree?
> 

Not sure I agree with you on the naming. I'd rather see us adopt the BSD
function (present on multiple BSDs) rather than rolling our own completely
new function with new behaviour.

/Bruce
