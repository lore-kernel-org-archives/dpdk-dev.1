Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEE2606A331
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aIA0GPT4;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=XsI/gNuq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2C4B40151;
	Thu, 19 Nov 2026 16:02:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 7BAE1400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 16:02:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795100567; x=1826636567;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4sbM0bLPE85LXvkjTFzYib6TyQylBlrhhbIvBGWdOL8=;
 b=aIA0GPT4AGeRihi1ujIqrLCnbOKOgr8Zb5whjZQUFpDuusCgeKpbpi3r
 9LYvWkLii6YEjhQ0H1L48s+VMPWymDgXp7j6MFUttFLSNZob+q4CpGkL4
 MmQHjiyUtehy6IsVDbRZxd97sK5pv7sjbC463Ult1dkN18KxHFLmpHb/9
 BMyWvAcc05tqp0v4oh5VeI9xyJBuz/Zmi5Ns88dk27rFYEzVBg8Nz2Xm5
 FT2zuF6msn0rLpNNYP5SbCtWBiifodxBtSf6yV5NX9s0iajk1FAHRPkn/
 bFjAf+uVs7Ubdr1dsvpqGEmMQGANchYuYN4h8CZ93YGWDmhlim8gfQDgL w==;
X-CSE-ConnectionGUID: XPTU1qeBRDqTYtzsLKVDmA==
X-CSE-MsgGUID: yOp3pzUkTxm3YWqIY4tDtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4051203"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4051203"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 07:02:44 -0800
X-CSE-ConnectionGUID: jh654Wg4S+O3qPtOEm/TAA==
X-CSE-MsgGUID: tppRmMX8TNyibg4KYaOyRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10254509"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 07:02:42 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 07:02:40 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 07:02:40 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.44)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 07:02:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WE6mVW92eOTjdkm9b3iI1fHx31iUDuhcCvxXzOjIKZCJkqlmYXZOjG+e/m0q8pJjpPwpVTJJZ877sh8oPndQ3ES+izVBp8s3QG66uXkse9yKKXAB7L1mNTYIx7CkMVpeoDBSt8gMarIVJgcik52E7ORu2YZsDy4gc0AFNi7Q33pZWNEy6BpJmOowJhhUTJhUEIuBPCKMT90/dGHUO+euus1UqIeVhO3TE8A0E97CWoGooiYJ+XhVLUapf279XI4kjYm9b7+jGrYS6ryBvkFk+Z6U4aJ25FlCTjbaDh7xM84FoCov+ErsKTRm6Q1XQL7j2fYxKHMW9b65InM9zKcvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Amv0Mzqsf3SDBKXs1fUQay6zn7tX32JKVBMjXVWaRnQ=;
 b=XIOYce9NCopTjk0/t0Oe77iyrZrO7IPNe6aFqjCSsgTYf7pDFujSPfXrY5vGv2GFM2N295i8nxYcnvpU65ri856KLDvxZNkxv0EQ4tcMp4oy0iSlVUIcdUaBBNvgtuKptKzsR+meBqt5c0ykvrMG7M3XmNT0aEDGIVlRKgt46gCbgQRKDIai9VYKHo86m6n2jnJCB/23UzHhcFSJXX2yTc2WFkk4neXwPPAL1vbdVOXv6M0UI6xxPBYJYko3FkG1xHlfa0OH+LeVo19EAvYaJ/H+0Z/C48FVpxk7UMTsNqQIgHiB9lEs6AulZaLl5lqGI0cQaYFeQtvzByGTEotd+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Amv0Mzqsf3SDBKXs1fUQay6zn7tX32JKVBMjXVWaRnQ=;
 b=XsI/gNuqqX4Y+Eh03ji+DlsOMOOBKSnwRE9YqxXehZyxSc7EissMLbnO2iRNK+Z2RO4QZIOhrjOJc8aVAHw7T3zFYAiwwBpzEPoUAFv9vEkrmrbL6Tk2K/Abo2Q7OvdzBcO6I3elbDzAtEopsQAGq043CURVxgEzlsIRNk6HcXA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS6PR11MB9920.namprd11.prod.outlook.com (2603:10b6:8:464::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 15:02:39 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 15:02:38 +0000
Date: Thu, 19 Nov 2026 15:02:34 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Hailin Xu <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <manjunathgouda.hosamani@intel.com>
Subject: Re: [PATACH v1 0/3] Update latest recommended matching list for
 intel NIC
Message-ID: <av8PipYOuZ0ML1SS@bricha3-mobl1.ger.corp.intel.com>
References: <20261119103408.289005-1-hailinx.xu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119103408.289005-1-hailinx.xu@intel.com>
X-ClientProxiedBy: DU2P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::10) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS6PR11MB9920:EE_
X-MS-Office365-Filtering-Correlation-Id: 73765c61-8814-4dda-fb23-08df464e2720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|261021121427099003|261021135927099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 24fBRoPQjhhK5yEvupspcuCdq6pua4NPTKr5SnLFSUxJ6buvRW2Rsb0YtwbTh0Q223+a3BnBuwTeMmmt3+jcK1hFC6X3UJ5gCL13qdRq+40ij23ZJfyd0B4b2fOAK9HkX7BsgmbYQIePWILrK7tlEfptT28pSkM8ZhWqDtj9LcQJglokJbzNit1feBkm+D6cqLEozM2ZhEcpUnK4yCEgVi9pjMDGCf7dRFfF/eCX43xzZkrg5yppExA4UoCvPxeib+kh+NP8xyivog+46o3pqMr/wbZ6JkOm61rah/aOA5mqQVQYKFQ2v226KZpi1p+p23M7sKmFspQF7gJHZ0x/WUZhG6vRICvMG61tgjJJ8oUgqEbGyccqpBPGGkWI1njkur/+DFZQ5Q1Hl+jhwWA9A48lxoQTW+dyT4tSCp2XuZ1bWmzAkqogCM+Srl3HKGIuDg4w5VLjKFUMX78pj7HfXLJbfqRoA1snMA9HYz7S/i1NhUP/7NXs5aWHrPy7Ka2lQpGNX6mhXpK3d50/Af87pQkAFqSCH5aAzC8GeJDXca8Xkyuw+NF5T6z8QRGzEwjpUtkOj+30s3TYryn08PeWLaQxVm2t4Cvddsak2GYS0o7W3frJYE1VEK64J2ny9pK1wEh80WXz9qSvfbbGsGDnmeplj6EA+QHzMAcPk7DhnSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261021135927099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T3+wQ3HQl7uqOgovlU65dPJqnd1eNteO0Cl3L+EKdspAOPfwzIZSMz131JBa?=
 =?us-ascii?Q?uBdF4Zk7SVd9tEtTgyAsqUVZbBP7giWBgkyqYK+P1mFu+C4MvuTektvQMW7H?=
 =?us-ascii?Q?t0Z6mbyEEyDKV/MR9sXVgNlS237L2qnkW0clCSuWMPLP6UMJKQgzoAcW9mv3?=
 =?us-ascii?Q?DMd9v9qGqqgFO4WsLvrp1ztIU0fDlWgKH7r/j2KNplNydDNmQkgdtZsnhPgr?=
 =?us-ascii?Q?tWDnpfl2P1nQUirO6ezRDwOS5xtzAgMEcMJsMJg08xy4Clyk2HzB4yudMDuI?=
 =?us-ascii?Q?v8vNHk9SrGFs+GLaxbR/Y3c4twL720vjX7xWA/m551+qNshvCI84eLZcqjGC?=
 =?us-ascii?Q?PbxmMsqzfVu3m4MPjy22M0Us2dabEPZsA9l3HXoP8bYplhXXnJxDQ/fTBqvB?=
 =?us-ascii?Q?2ZMHPesg0Z9Qrv+ymn1jj8CxEiKVV6x+oJKeAAds9xbxzJQpuBCJUTPQisiS?=
 =?us-ascii?Q?RTfHS8CMz6gt8dUTFXdthNhhIrmttiOrOfvA9dcACa48IVgGuo59IYyfUWRx?=
 =?us-ascii?Q?+4Iq59LD0gHeXhKvuPqefBvygMnbR0+T3euHZZ4kWkq0F1vYNNmY+bqz1d1D?=
 =?us-ascii?Q?I9/oXKRQeITInwXuwQz4PJr5LKzwUEIrBYY1ejNwRCTERm7U71OC/7euVo5a?=
 =?us-ascii?Q?y9x7F3bG6SCtWAmOlWu4FH+vxpqlaiz99mDYUmUO+Q99xMhLJGg5X4Onxdrr?=
 =?us-ascii?Q?rgsexrqfMNI6fXZ2/BbprYSDBcZkj9AuTAn3Jqbpe7xt0YU5suGqvGdirjef?=
 =?us-ascii?Q?ua2/Bl9AEc6+JOMFv6dfIOwjwBi7zUFfx2xJEnR1ADjq76gv0J8gwAcdvbXx?=
 =?us-ascii?Q?liPV1282+L9WK0Sm8y6klIizT4yEw40xVAiDXJNt23QyyjjcbVF6ud5w97cV?=
 =?us-ascii?Q?4gvTwFBEaxPG9mKAZQo0su71qanNUh2xaEuDSAm9Bx74qzsD27T4v579hGEf?=
 =?us-ascii?Q?tD7Aw9awtfEITzgpq9z3Lf23jNlvayze4Xhtqnn08W8hVrS94CF0dwOEnEN5?=
 =?us-ascii?Q?b47aaxZCfyB5bOLBW0OhoJwxnKZYH1/orWHulrgGoYl/v+MJVJ7WjumyvMAH?=
 =?us-ascii?Q?RuewPmQEJRo8nZsXlNG49H1wA0mdlfRtXPw8jUQWK8TCz86p/zllixzgKU2x?=
 =?us-ascii?Q?2rIzcT7f8pC8jHzNn/9CXsOfDE2LBAHwdiWMhJG/afGA3k8gF+6Oia3dzg9T?=
 =?us-ascii?Q?sZi8tyx226LvhSgcMYLUPliCkodEMJ6Xb5DSrD0PLF3ssaC3TSi6bWxBwdvJ?=
 =?us-ascii?Q?7aVOOcAC8rgg/tbdTzTS6NAPc0iHlgNnXuAImAegjXjBWgwjW15Kuxvec2NE?=
 =?us-ascii?Q?gJRBUZGbR5YC7cfK10IH8bh+rAk2OvXJsUzIJGlYpxTFZw8DDZjDEDmjZlgF?=
 =?us-ascii?Q?pb+LhfXjaoP/xP52gUq/IwV6SxzxWO/Txl4IS1rpjhdx0EhLbP+V3Skbkwuo?=
 =?us-ascii?Q?uPWHBJ9+YA4KIxJLPvzSmxQR+yw4lBUtQ0wGrqbqFDuMXqlBqd99NdTXcDmf?=
 =?us-ascii?Q?UJCszzPLfajF95qCedJ084ShITeatmSkypEBNGcJlDWTsM+JsVslz1IU6ASb?=
 =?us-ascii?Q?TteuwDEezlNputKVLlFOliBhb76mnYxKhlKKcowS7C+9nbsWTrcakU0iExUQ?=
 =?us-ascii?Q?NaZt/AqE30TGFX48aBBS9ph0b31KWLoJiBOq8VMka5U4/5ydkBv+drobE1SN?=
 =?us-ascii?Q?KLTXFtszZg0Vatut04yyiFtC+Mb5LDY2l0/ri4+g+yxQmGrQHfUg4VkaFwzh?=
 =?us-ascii?Q?E0LzoCy4qHLcokRgz1AAGx93EC1d89c=3D?=
X-Exchange-RoutingPolicyChecked: TB3MLLuiM0HbXUBR7dioivWrFd7YSeFM1I8ARQCSzy3DiisRP1zo5hIy0nQ4yzu78x/nZNqPy4DZjz5QRUd+k/gI+V2nJ8VCYE9foGPFmrwsl23kOxr5E/2wXDgin3MldE36mfdBTTs5qjlpOLQR6dDhf/KPyy8tOZAzRKMKLKgF6TmdIclVAOFmbGda3GJccTy3jTMea7KSm1NihypdH5G5zmXmbDFeq3FoEZPBco5MLJlekCOLyH08043hPoFphdVUtC2YZAEdh6FyxWmJnnTtsZ9tYT4rDLr4b1uZGwL0zeU915yrkig5Rj9cNgmlGC7fOK1boPCpm1FBawfa3Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 73765c61-8814-4dda-fb23-08df464e2720
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:02:38.9067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRRPL6Qex3DWv6t1Z0WpJ53WMNhz9NK8kuOASPapavTeGbEfcfOK1/0oKEw62OVsHJDyOWfdIxeaxfQttctmpIfLFissFpLBxa24ypaOV7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB9920
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 06:34:05PM +0800, Hailin Xu wrote:
> Update latest recommended matching list for intel NIC
> 
> Hailin Xu (3):
>   nics/ice: update ice latest recommended matching list
>   nics/i40e: update i40e latest recommended matching list
>   nics/ixgbe: update ixgbe latest recommended matching list
> 
>  doc/guides/nics/i40e.rst  | 1 +
>  doc/guides/nics/ice.rst   | 1 +
>  doc/guides/nics/ixgbe.rst | 1 +
>  3 files changed, 3 insertions(+)
> 
Two suggestions for this set:
* Since validation on 26.11 RC1 and RC2 has already been done, at this
  stage can we not provide the matching versions being tested for 26.11 rather
  than for last (26.07) release?
* Version 26.03 is not LTS so is unmaintained and should not be used for
  new deployments. Therefore, I think we should replace the 26.03 entry
  with the new ones added by this patch.

Thanks,
/Bruce
