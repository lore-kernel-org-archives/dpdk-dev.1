Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A976AC98304
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 14:38:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56FCF42EED;
	Wed, 23 Sep 2026 16:38:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id ED3024027C;
 Wed, 23 Sep 2026 16:38:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790174288; x=1821710288;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3yLLi5oJsplYJi6LtPzRbl54gfeBMgkUBWF7gAfnWGU=;
 b=nhqqVFy40gvx3vm5n4KYMz6RqNMmkTAC+aBxArQHCNeRALMT19vd/gR+
 HT4+t2zZ+gc5Z3x+ntjwdjx+nVdU2yJPOY2lT59cokPA8JH/EPM/mx410
 neyIUN+qkCDS54Ih4z3mtCqhKeLMAu0H9RmCNLjYAdQLNasr8ZrF6lW/U
 6o1X5hqAzSYyuOKpN1rh0aVCYGWE7lU/fHbnk66iSTEFupY4Ymby8ekbQ
 x2BEx/VXYx/HnQory/AntSFKfG0ITS8BVNfXQiNFvM3fRRyAjqmtcuAG/
 rFjzGzeY/0Pig9qp8vqPx/tV2cBs+egTFdTCnRDEsOQ3QWFBD1/qOV7k/ g==;
X-CSE-ConnectionGUID: 1tKfZ8JVQkCrQDPc+v55nQ==
X-CSE-MsgGUID: HUsgjklpSe2WE2nGEaEGeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90992226"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="90992226"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 07:38:07 -0700
X-CSE-ConnectionGUID: 84tS9X7QSMKL8aKAofVyVA==
X-CSE-MsgGUID: YpceEK5ySa6WlmVo7h4Qvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4722603"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 07:38:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 07:38:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 07:38:06 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 07:38:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CalaFnLhLxl1GMbkUymIoY36LfktjKsnCHkFV8kPTYE8FrMPz6y+PMNQjbZuhmrLaUCS0n1qw10AgNFBKQaOJDZJvaesRJAUgzETB7fKePFt0BvIoFRP/mCzu9Xvto/dr16M9B1IrKPR8JqacQUDaqYmbfgkh0Fy9RnLTdqR8fBgIQ17VhOpHqLBFG8t1Z4FpOEi9X1gJ1HFVVwrte4pWQUDFmCFpJnXscMOiFfr9zWMBlcmm8DWapKnbKWaTFGuyI+dAF+EbB9ZzMVbTNyxvhYIzkgtWjwk5jOxln2Me3CcaFO6Og2oUXSlPbjAYzykbOAw0RQvw4oSCBMdKtJeFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcTLKDEXz9ZmrQFMGmIvqT9TbBiCe7IyLCP33w69zmw=;
 b=tG4l6Cv5ooKtGKGEZO6Z27k4Ou6/O4ZYzZ1ooRGoLsnpfXWcQPwuebrKK+7LAIWLlRWcJdBjz7KZj0XsvFWtMaL3em4sWdIxHi2RFOl6kCXd0TdC7o7nazB1jpwJXSdFoqrOhtea8BJhtEAtSC0vACzVHqbWhJt+y7gU7Aa2JmlZK/1aPoGE2BnoaT2QstO+KWUNkoiiB0K4kMRCGvhfoPVrfBX/nRnyZRWqtKR/4Wu2KyKtWVEMBUwXLRj+C6y5MAlUfQRVEFgdN2mA7u5mth78cTyp04mA8bXmBtqkKsEKeUipHcBqiY7xMKfHpYamUwBo5AVkW0a9KBwBjjR13Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DSVPR11MB9915.namprd11.prod.outlook.com (2603:10b6:8:45d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 14:37:59 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 14:37:59 +0000
Date: Wed, 23 Sep 2026 15:37:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>,
 <ciara.loftus@intel.com>, <rjarry@redhat.com>, <cfontain@redhat.com>,
 <stable@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 "Lunyuan Cui" <lunyuanx.cui@intel.com>, Jingjing Wu <jingjing.wu@intel.com>,
 "Xiaolong Ye" <xiaolong.ye@intel.com>
Subject: Re: [PATCH v7 1/4] net/iavf: fix MAC addresses leak on reset
Message-ID: <arPkQKS5LBS1dl6f@bricha3-mobl1.ger.corp.intel.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
 <6dcbfe2b-1daa-46b4-840f-419b637369b9@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6dcbfe2b-1daa-46b4-840f-419b637369b9@intel.com>
X-ClientProxiedBy: DUZPR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::6) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DSVPR11MB9915:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb3ae44-beee-4ace-0ce5-08df19804387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6VRlORszqLnyDQyI+e4qCG2Z+X9vkSyMgZO/HpY+hnaVhJKpsChtj3JviHeL2EdAHaccBPUnrZlqw7KHtpNN7u2s5EI8LA2pScwWcfHoKsO+1JKxS2boxQ1sriZuO7FQiIiP/E37l9Kx3TFyeZ9f6IEPUTDrTvRBqfC+RBtvml2c0Aunsyptdsl8zUswNxPV7S6SIRRbu6xftid+JhfmiwhKt3wQRvYVUt4+fhgftRB1TdydVO/ctgiXYMlRCJg5tnzNsGcvdj7A3mZoChV7UcqxrS9m5RXevi3J4yWdFafYY2CHX+P9KD130geHcOPAgmKvp0eQIyggzSXV0f72G1JEXQ68xIhV05m1itK4qFvHVzqUX+BT/j75IyCqRznM1QIgyPx+IriPNouZSPzxQto1T3BSHQzY8Ix5WOR0CMQfMJuIGUgdnbDQHZxlXZjAjBkF7UCq+gIYGajMaSE2FGZ5SJ3OkuBgrQVrrNBRLm0KQx1GMDOdGW6X/rTmT2g55yEwaQC5FpeOT3XvpTBca6BHreEnMiXpIUyw5S6zAML41pIZWOjs75Tue5ZezyYBhn2PEwOxF0DmHHfEAqdlecxEP0ax0gvSz7h/VpgZpK6K5aWOdRJ3yNX6juPQxEfs1wr7hKxt0HpYdRYGK22Cp27EYj6Tlxur3K5qCDxfxl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uqNIkjDui2Q5Hx06SQfMoAi2YbGdSPH3/6oeVuUv1H5Hd+6lPEhlU2ruY1p8?=
 =?us-ascii?Q?05AmEDfIi+uzD5i1Ggak8hPOO5TmI2GKOnTJQ/vuYGEkbGzPldPX7qUhP/at?=
 =?us-ascii?Q?ZHaSVQGlgjD5AhLxfvxs/uaWC15CByE+6sRn5SR5PI23hIJFSfWHtunmzrwz?=
 =?us-ascii?Q?kwxsVPZ8k/JCoQxGjs8tOMD18WB6Us2Z+GXMAXw0cj4xtWCAGvePjkvV8A8E?=
 =?us-ascii?Q?afeXvN8IuJ3o03IXPLix/t8FDrPQsAKKDuHm8p+aX9SfXTTalAR5Il0lqBm3?=
 =?us-ascii?Q?Z+IhrryJKoWh2U66NYvG/0DAUsqrSq8AczRIhpqMO3FbzN9wmLdPlBzeZCWA?=
 =?us-ascii?Q?KHdAhdV8/r+NA6Je2xgYwnoiFZPjFWxQs3XPRZ1l0s+JyZ/uvWTMUC67rnFM?=
 =?us-ascii?Q?GJlaYGcVQoZwEqzCc3hjnMNLOl4yXb0Fq2j0MPZO9fNI+ra2ZXJTmvPCUaQT?=
 =?us-ascii?Q?ND4UNDds5tCBZPZp60bU3DbbNWCr/VDqE92d9ZjcwBpObkO/GWkkeIpJ6WUi?=
 =?us-ascii?Q?BbInapqncVTr7KHGduBWb1Fe5y1ngd0pLjwvkSfwu39GWhuypDqf5BI3MJIs?=
 =?us-ascii?Q?l9y7YFYlgstM2Rss7SRdVc+Hm6qplXzfKuxhXi9TqVuL541xf9rqcdjrDCdQ?=
 =?us-ascii?Q?a9ULWktKKFIXVTpuK6k52OV8AYGDzN7PKnP9rvnT9bOfm4LwWsWur4+krrnp?=
 =?us-ascii?Q?HY+fL6v1B5ukERR7Zr+qK7cXGko98udmj7lnWA5czSbse/b32An62Cw2NqxS?=
 =?us-ascii?Q?k7trh5FkbeucgHB8C06BmpHaWKCvXNN79YGVp29+x7oaZ82G6ePWCFmm+HGV?=
 =?us-ascii?Q?ZSxrxjbpJXXCXrGF5aZIFKq+x9Kn5/Z3W8c6y+rn3XL5fKxIeV5oW2CgR9y6?=
 =?us-ascii?Q?5tWhhBUwnWeXcha9jDRjOMEM3kg45gWE+dFaTaex7bXoEaU6/wIByzmnyZk/?=
 =?us-ascii?Q?qYOrEtOFNNJkXk1vSrYZcVB12b7eRUxGqEhEodZzzVpQNUrBBQE2t8koEKvV?=
 =?us-ascii?Q?/qh7X9vfWpvde1ze6f7j+AM66cGx0MwRS3fp1jPucZ+1hc7+7XAirC6OXgMt?=
 =?us-ascii?Q?FWAz3ASV33PZ+QXhgg+RcjXVfItGsFIxiWEmOIoFZ4XWqK30z3MdAUrsjTxH?=
 =?us-ascii?Q?UzumEbluVe/2CiMMaIaNRmF8Oj9ivrT8FuCMFnAFgL+k6aubHgpQ/nX74Q9D?=
 =?us-ascii?Q?DS+YE9fNVic5Jp1R+tiuArHM+eeAXP05coXGSP1J7MiG5ogNK87037fpFtGP?=
 =?us-ascii?Q?LxtX3DYPDhXkALsld2lPIiykR7IT0qfxtV2A0uZPlnWLACbm+1CTSNGXFy1c?=
 =?us-ascii?Q?b7Bt7wgli6MGPT+eP1yrDW/L5ZtAUVjGlk7wHRk5Ujb08/G1Tu46Tww6oFqI?=
 =?us-ascii?Q?kV9nLfmEpx1Z6cjhmWz4nn7PgnUpi15oW+uX7y/zTWFh3UeEdwQ1hssuil6P?=
 =?us-ascii?Q?LnHidWWAUbzXXi3g4qha/pxnUqUpQl+dEBnKHpI8/79umanSwaAYg7uhZv4F?=
 =?us-ascii?Q?92O+9QQM61DzSYpk41/qTlJw0g4VkCl6OIffzkWq2Th8WIzdJza9+6/yUKBW?=
 =?us-ascii?Q?Vbq9Ng/VwyrW7/zuLcaEkakS2m+6Ap6U+xekhjKguBLm0yUohA00a9V78+6X?=
 =?us-ascii?Q?SCF402JASKvznMXKSxoBd5+vhmzHa3pY7+oFTWfG90w2/IqMrcaw+FWIUyur?=
 =?us-ascii?Q?2Kl09WSQcUP5w3Gok5vfD24r9gmjqmrQXF3FQEpMo5MfqyB4DxaGJYQiwRWM?=
 =?us-ascii?Q?B40GjBjK4lmWGjS0g+excWWhtFcd4/0=3D?=
X-Exchange-RoutingPolicyChecked: XMj9r+FPeOhO+d2q7/4YnrtXZeWxAkdzUQ8f6GJQY5QZdstK/M3t4PLiBU5/GJCtZSwZ4MOF7zl9mLRAi6CpXFsEspS7K4EV28lGLHHKII9FKQObXweoe1Y7tHT4FNZOTFYYdBifJAvPF8c4oeD3Znda57VaDm/P+AYW1sPNtFvHrFNyo5UC5GzDzbbv4T0dTliQIw9OuZLJEDcoUk+CC9x/5TmH3jbC282NmNlNSwp/u62/rqS7zgIsSVP/5HZZbJ3QsGvVSvlvXlSirBGRPmn5gJEFzORA0jYmgGZIfmvZCGr6Bpj9VKrOaB3AvIoCAk6LdlK+qSC41Mq+NLrsfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb3ae44-beee-4ace-0ce5-08df19804387
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 14:37:59.2712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpNN8fuhssLOUwimh2960BD0aiuMGyf3wcNMsCxK8R/xwtueaib3pxf3KLhnXxxQuGF5I74x+VT7aagjEyPZq57KGaUi1GvEXI3VswU4zts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9915
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

On Wed, Sep 23, 2026 at 01:47:25PM +0200, Burakov, Anatoly wrote:
> On 9/14/2026 10:17 AM, David Marchand wrote:
> > When resetting, calling iavf_dev_uninit + iavf_dev_init results in
> > leaking the previous dev->data->mac_addrs array.
> > As a consequence, secondary MAC addresses are lost during a VF reset.
> > 
> > Move the MAC addresses array in the private iavf_info structure, along
> > the multicast MAC addresses.
> > Set/clear dev->data->mac_addrs in iavf_dev_init/iavf_dev_uninit.
> > 
> > Consistently use RTE_DIM() to avoid mixing with the multicast addresses
> > array.
> > 
> > Fixes: e74e1bb6280d ("net/iavf: enable port reset")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 

Series appled to dpdk-next-net-intel.
Thanks,
/Bruce
