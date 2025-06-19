Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A57CC7115A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 10:21:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 355B140275;
	Thu, 19 Jun 2025 12:21:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 87D534025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 12:21:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750328496; x=1781864496;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HNrkN1B0V6iNHgNUA/qt1K3QJsOLH+1HkrqXgmoQpJk=;
 b=J4017EE3ECM+GuO4OrLE+Ef6bxfpLQvHF9qxzGQcQ9dshD79wK5UoxRQ
 jvQEHTJrwZK9RgycjWZJSgjiBtABm0dEf/vsUmMwXRKqBu7l95RzG2HL0
 VJ6z2J4gGr2S2SGDqq9GzVh/YBO4d1nyZnDtwNK5pLS7hNAq1ukdY/QNs
 qKunEK13iTStCNCuwuglb8qBEiRznxGZ4eK47hbdykG1OoYD3hwp2duJW
 3nFhW2kigtzi24n0m9tkv0VDbCP8vqevFL464A3aprAulZ/T/SPbzCUIl
 diVF03jZAiG2qj/DketG8I3Pfp8AdwBDkEp6oGHsrt7OcutQ8l5RLUfd4 A==;
X-CSE-ConnectionGUID: UVmVfA7ZSwqvn/ejQNPM7Q==
X-CSE-MsgGUID: fZvQMPpLROa84H8aq4L0dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52278136"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="52278136"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 03:21:35 -0700
X-CSE-ConnectionGUID: i7CKyBijTse46227f3PT3Q==
X-CSE-MsgGUID: Qi9ym3rvRhyNVUsBRNijPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="150816431"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 03:21:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 03:21:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 03:21:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.76)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 03:21:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmyFuXRxsPpYpu8FaTIo7WahAQsPXe46Xqyq5+OL1BoqKkKH90ta3spoUGpcX8lcYp12gKmpc1+JyJNT8tzW4FN8ku7IogIeqL0M0ZDYr2ccQEP3g8dL/o60zda/mFdNX9cqh6nidnJ3q5jx/qAoYXpSqKVFV+Hr0qxqZtBwwuBmg5J1J7np6t9ffC60IkqUdnSC92bZneh+5glJ8mXDu8IzyzWj0aMKatzTmd71/fXymgblyN/UmXPrMU0rHy1jU5AW9TF09KVrz1BvHf1dQTiAruhCnyugOtCjv6sGyKDrRYtRvMVDGSS3TfGizF+672kH5B/V1DQ0LBVJCvCB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk9ziqd7ZrTG1roDjGe8ZKtTPxn7QUmrx++0Kcn2F/w=;
 b=xTWKgzqng48YpVZv7lJZpbFgHkOGI8IJXM12Sl9ADZwVkszJMIyCul7q1IG+Xvvd9IG48MOO7dio9E9afURZwIK1X5G0VYao5+g0wFsx6Hzbl3748oemFBE3jgac0O2JF5LSeqF65lPhsjshEOEPE+ls6QH+/zC+M8hW/tZ/q2Hwbp3cMNv23lqvWzAZNxhOWVdjxm2NeEtWSKpd+/Spw7BAJWXRsr62p/uU011AfXXkCKu9T5IFj28B37e7+i2ZME98g8ON1XV1FRQ1OL57OvjHMynsdCfr3HmoH4sEOeVDqa1ycBw4WpxDrH+qsVOCMjWV3rNFIU75wZf9TnoAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 10:21:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 10:21:31 +0000
Date: Thu, 19 Jun 2025 11:21:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v2 0/2] doc: update recommended matching list
Message-ID: <aFPkprUeYocpwRhD@bricha3-mobl1.ger.corp.intel.com>
References: <20250612121322.146355-1-shaiq.wani@intel.com>
 <20250619071502.442214-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619071502.442214-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU7P195CA0017.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV2PR11MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 0314c30a-bc07-48ce-087d-08ddaf1b0fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xRH/TN1PG7N3vq4IhCWAmMcPqOdL2LbKU9ZTe+0w6BOmnn0dzOJsg1hmsY2P?=
 =?us-ascii?Q?rsFdE2L6/GNZgPi8gx/MNvZNGzC2XVg4fa/aNMZhH3t4P8P4mXh9yAs/Y028?=
 =?us-ascii?Q?QX6xLXQXLbJL7wMHGLh/q+yfx8JVuCiGf9MooovzEJ27Vtu/M+asDgxw+HsL?=
 =?us-ascii?Q?BfSYRmPwfOsxPoqrHH81wNPOvE3b+Gg3W7w9M9q/N0PpNQjkoPd0cP2IyLmf?=
 =?us-ascii?Q?GKgJdLGmzQ7rygkP346BtU8jTew85PPEsHR2lH0n6bVX+glWC+JEET2a+nLf?=
 =?us-ascii?Q?AAfKqj/Oalz5QB8h12o4FxLdD19DjL3eVarcw/FhiEfXPEJ5aGqW96rjJAz1?=
 =?us-ascii?Q?rrTo5vAizNqMef9BBE1cy5ltzK61GkyhWQcoc1aB2ufH+q0V0mtyRHmr4bxt?=
 =?us-ascii?Q?WzZTZEK3687NnouIhfq+s+4NP6LG6DXnIn3QqrU3xs04ZG0ITbXWhWTLWXce?=
 =?us-ascii?Q?PFz2fEiWcuNnBEp0ofQ32OQtEYIRvpjeYuuaXQDzgPRqFtqfnvc8AK8ESzPR?=
 =?us-ascii?Q?/0BY0wSF/qXGiHadBjScDcSbrorKpqrRRkuKibQLL1rSxnVy7Gh3hmbKJ9SA?=
 =?us-ascii?Q?PInStJVvcAb8kXbRRI8tYhsu/P+6VY0c1vmL2t03qR6BCMLlbRLroRi5Ydwd?=
 =?us-ascii?Q?vehBVaAlSVSnfZUNm19ygy71a/NfWfuhRdGeeRhoYbDJq8QyWquK5bZDlKkj?=
 =?us-ascii?Q?cjApZkDQLbl4K/aY32Wi5ZdKZ7PbdBEROKwhkBAXGpWH+HeiODets/GOUcfY?=
 =?us-ascii?Q?ARfTLmSSaP0yMrMcE+4zyoxm/BafoU5KgBMnTjZmWgVAQ0Gb+zF8kYtTh5fc?=
 =?us-ascii?Q?fPNr0WXlurgin0C2qpvP7mdy0oHomhAZDQrF6PIcd/3jokmLTk3Sk7an9t2F?=
 =?us-ascii?Q?1Cu1EVo9vOhUwo/5WRgKaoQZB1Gcer7mK5ndYfQIYlhN1LIZq634VruKzYLq?=
 =?us-ascii?Q?k0FMmEMolkMoUt/ElwVQgEYpd53l8GEqUq3ULaj4I7gT0X96YvMGIBodldTk?=
 =?us-ascii?Q?/5POVR4zyA55L4egkMTOCDb5cJKZEndATVtWYVb3KIwyySYkFaaeNT1HKI9J?=
 =?us-ascii?Q?yXHIdKIzCPoN5NWHVOvlir9ykxn16HCNDRe/MlWvvHcn+sfHoJ9thoeCCFQN?=
 =?us-ascii?Q?9oNXLUz5XkH06azED6YsDVrmjeUPNWTaTz6BCu8R7rkPJlFVWF8ycvrqoKpg?=
 =?us-ascii?Q?GF2kAV/jnkbhh9FnYAde0j1Z3XkjpnhVsh5qUjVJ7ns9tS1MrhvKIhuyLXoi?=
 =?us-ascii?Q?Psfj4li4OjB/7dN2xgvzUEhMk5Jh67YltGwilHN6mNyrH+Jc0JXtARqTt3bi?=
 =?us-ascii?Q?c2+bM1+JLsq7uZoaMVgtk3hlwme95llw60cFSiczrJfpI9VnINm/iOpp4IIS?=
 =?us-ascii?Q?r3PaRCflZQYB24OCUyht0hZz6RSNzAhdiDCOgSWWwlmBmr7AEYjTh4tzJFnu?=
 =?us-ascii?Q?LPDDCbw8qAo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Orl4Oc1CiexpasvN4O5vb55hKdqo/CmRcdRWe+VIMwzWOu5KFEnabFZltNa+?=
 =?us-ascii?Q?prcMZ2CNckQEmmGfuKpLSXmr9CeDyYNbpnZMwqXFDv6yGRaza1RMPsDRqoLQ?=
 =?us-ascii?Q?lZl2i3NbJ4r1FOCHCGv8RO8N1xuwDjqF4GVI3UXECJv3LJMWeupwFOLltyA9?=
 =?us-ascii?Q?ygEaByZpLewdgQiOnqDeYSWT6POhlicrJ0K85PUGC2DVLvNbwqCI8NVnJCA/?=
 =?us-ascii?Q?ZIiLJ18C3OTKyZyw4MUu82q+1/KUT8sctx/NNV4g224lAKDiQgSq6SuX5cbA?=
 =?us-ascii?Q?5DVdyB7mjMekrbPW5G0anzxZPIdwWHxMRuOQ31Ncrpfm5aJuJPfWHIerVNI7?=
 =?us-ascii?Q?0S7uyF7wOHWarehH2OXANcE4R0E/g4+1snXsCIB8rFWncpSKa6JCkN/XAzpR?=
 =?us-ascii?Q?A5cECalr+fv3zCqeZGU9+JiYL86m6LCgJFX1u3O6B65PZNA7oP0ldV/hNy39?=
 =?us-ascii?Q?357QNBc6exQx9N0+/cRIRiELJ4l8hzqbTrvZy+bW8UhtOlujs/Rys5y4lqB8?=
 =?us-ascii?Q?m9IA1aIrnYAfzY0yMAaXj83soqj3rnw0PuN1cIBQZpVUgO4P3g5xfJ2oGUcL?=
 =?us-ascii?Q?HJD+c5LUuOpIyD87sbVwVuIv/BswQa/1vQU9er9q1eTld2Kn9A36noEiW3VE?=
 =?us-ascii?Q?SNvs4v0EGNNyCc38YuxatOmrMEKAYN07Wq+Sp1x7IJWRAJTx28QsVduWTEUu?=
 =?us-ascii?Q?klaHaH0dPutxn6WYtJk3zToKTFNXr9Bf4F1oDqL4F+PaSXxvESNtwPrJVbUF?=
 =?us-ascii?Q?WC8LL5oZ0FCR5+h5as8LD392YkdC59q2ocxp9Sx6dqVFBmCXSOrFaEbi+GlK?=
 =?us-ascii?Q?S88sdg++yoKYR8+V3WH2RA1/0Fy5YpvJtTx/kBcIjek/qAUTmNKSHUHf0PKB?=
 =?us-ascii?Q?rziqueA4iEZJ/MHnamfHjURqzXKixr2YlyQjn1WxPMxZVXV8nrzD1YJCGFqU?=
 =?us-ascii?Q?pdtEMeXQltfuXQlgvyBjvrTkTT4IKJ7+f+Xow9GMxliXSpozURCQlMrvJNPl?=
 =?us-ascii?Q?UQA6wD7eotD0E6CvPwfzCAc8ngPkpel2ej3vSO9LEVYgO8s7qcUxvICxl8wz?=
 =?us-ascii?Q?sFVbWCgXYLEpwTOyQrb/QhYHNophVwQmvhMQbJF7+XQqrnn67fBoaVnhaoz0?=
 =?us-ascii?Q?uwOv3MlAa1W4T05Rmti2WC8lVmn8ne0A+JgUKmhPUogARRrIqUxniRLetuqi?=
 =?us-ascii?Q?FWyS5EFjfMo7er712U1ZkXbAH+fIKE6X4ZQdJf9T9KTQVx2afi6/+H2kfYc5?=
 =?us-ascii?Q?JfZQ2t4Lj0y2/TDcqVDQBTSJSWM62E4eoc6DHpW6gxUdquhUv7dlgLFnaqDL?=
 =?us-ascii?Q?9At/H3rCbXftjOJOuvfKZvJ2124DnXF+OUE6/ncbitNDy+ox4k5+cdjiPUWt?=
 =?us-ascii?Q?mA4JiDYcfZ4I3sw+mYzzsTrisfMcx3TYS0vzS6VMNBQoNL3O6lwL6oVNEZfy?=
 =?us-ascii?Q?Jl7TTu5jiQQVfJ16F+vxMR7Qxe6k7rxxdUlbl6M305nkS5dfyPS8XDqgsf7y?=
 =?us-ascii?Q?opELV9/wfOpN9I6BAyT4MitPxNhriXy6+d+W+uIO/fMvERrMZ4NAV3ZUPQnH?=
 =?us-ascii?Q?rd5xpO/c+Q3DlfaHdl80B+fu1euwLICN2bAwkq51uIQw7eZBiTyVlTGIip5O?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0314c30a-bc07-48ce-087d-08ddaf1b0fa2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 10:21:31.9000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrYrruhn3Mnppo7fCyZYYuzESEQ6Pd2fOAhDaH1pUQshXfdMEoLvCDGALgLAU+Jjsbe1hwQ/ch6hiRSq81XersSzgpFLBs0dteZGoSPuEEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
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

On Thu, Jun 19, 2025 at 12:45:00PM +0530, Shaiq Wani wrote:
> v1 - fixed the series name.
> v2 - Addressed review comments,fixed idpf kernel driver version.
> 
> 
> 
> Shaiq Wani (2):
>   doc: update recommended matching list for cpfl PMD
>   doc: update recommended matching list for idpf PMD
> 
>  doc/guides/nics/cpfl.rst | 2 ++
>  doc/guides/nics/idpf.rst | 4 ++++
>  2 files changed, 6 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Series applied to dpdk-next-net-intel.
thanks,
/Bruce

