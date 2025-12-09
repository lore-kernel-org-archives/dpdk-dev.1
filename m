Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82840D3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 08:55:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A815B40270;
	Tue,  9 Dec 2025 09:55:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id B2A464025F;
 Tue,  9 Dec 2025 09:55:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765270553; x=1796806553;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+DGKAH1kAHQV/IQ/IqGAt0ohrKXVdPSeZUObEMk4LKY=;
 b=BHmzrTWzhqsuQDpAV7M03rqV3yrth50ahfg+nkE3jSw9JEz8PexkLYlt
 x0hkXoOJM4HVlfHZDft6/QvGL1M7he3vID2vFq/x4qfUCX13pz7YAj8hv
 /+ZIOGYhJirn5IdnPMaHq+slni/L+3FR0aQnPiLW0CsdY0gvv0EKLOi2Q
 V1DeCbRysKEZg6Gywtm+cZE+a3vUOCi9LuaxAFG+bU1x6raWpG3CjCvr8
 uNuNhzh03zpsS4Rye9wo53eWkGxsGwpJQJzE2PvKG5fkQTv5iFhlrkp2n
 OLD7MGsNc9+GUju3S/MXf3UJo3D55TnUkdQDOBWu9blcr0IX8UaCpcPYk g==;
X-CSE-ConnectionGUID: mo6k+/vOR7yIuUyXKD7kUw==
X-CSE-MsgGUID: vINjcJouTI2TjDUR89godQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="92698252"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="92698252"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 00:55:51 -0800
X-CSE-ConnectionGUID: VdTECCZGRauCWi6arePRaA==
X-CSE-MsgGUID: tVDtmFLlRYu1Vnyq/RhHCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="196188693"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 00:55:50 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 00:55:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 9 Dec 2025 00:55:50 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 00:55:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljzPedhbNVbDvhX6mjThw356BjC7vwpw1gZtNncfL3+r/ig9FaD23766vxOsLLWnbYuZVMqlodDLDQWmJq/VBQ123xLAl8DXk8zj39WKDYJTeUEySCzF8Q+rtxu7p9rL5U9ur39ESmAcs4Mf7pSGPgSKvMoqW7F0tQUUy+r0LRi+BMCtMMfyvqir82sDv0tWZIrsiEA7g5ewyy9J54VFW+9loPAgco9YeVQB1ynvdQNMA8OeGY1414FDIMjV4V13JBBJyDPuZ+5+p3Y/V5mCgi6SYgw2UUT/XfTL32W+SlOXR6MBCskp8yH/KGt1iDi7aLHMXh7Gz9bGg01tuPBd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMOjbAzoUjuXz50yztlYGO7ANkQl+9d/hcOtVwTncgg=;
 b=IKSfhLaFQrpNn3CguWTJmgWPSGSyPLNlySDLCk78TXyPkWq8+YQGJK8g9tPLrCTNz+eveLH4PUMFBr6oibPjVquHPOj+4mD1MmXLDNZj/Ltp91jSuLE/Y8WKbnDHpyN0BeRnFIGvhc2U/1hVRGMHgRjovIrYI0hVvQXB8xTLxWPedlairrVWBkOVaR1p29ZEpu1/CwPas/POnS+CHOvzfAsHdNptzCzzMAOrDtQiv4dtxZUBfADUUBSrs/6UlbV3IumVJrj0eCBY0TlKDw7DM8w8Zp4YnL8IaQ8piu23MUgzC93SNGS1LJxFwT9vVAYf3VY8svXqVSR4FRwbWjyMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:55:43 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%6]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 08:55:43 +0000
Date: Tue, 9 Dec 2025 08:55:38 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Matt Goralka <mgoralka4@gmail.com>
CC: <users@dpdk.org>, <dev@dpdk.org>
Subject: Re: contributing to dpdk
Message-ID: <aTfkCg8pU0OKYTDS@bricha3-mobl1.ger.corp.intel.com>
References: <CAMf-ZCH+EuZxuUyvrJCJacC1JO15FccXNkg2+nuC4+nMGpJDSg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMf-ZCH+EuZxuUyvrJCJacC1JO15FccXNkg2+nuC4+nMGpJDSg@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0124.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::7) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb2cfa4-31ca-42ad-18a4-08de3700bc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VEBDA0YnE9a36iApnPdt8L+3fLRvXte3HKu7n7ss7LKGvKaRcrjoavjnwRpa?=
 =?us-ascii?Q?gegI+P5AaucycisWRRFO1/lkIf1gz2sDe60JAJ3520Tu3s5WqamPbcKQs22J?=
 =?us-ascii?Q?GC0TGyNYn5Q384EVO3jyVV3jiEl06TZrwDQBL8n2884tmZdv0NqacUu4sfl4?=
 =?us-ascii?Q?NWS3ncZ4StXW0HyWK3fD1Yc+Lo8PaMI8G2cbgkNjZHAKdSbZuJbjrZaKZtOw?=
 =?us-ascii?Q?DbVsGBejkS+z3tQ/Umg6n/eNPaeYE2v34mMMVBMlClV5aQi1qAv4OWKWOp1L?=
 =?us-ascii?Q?AP65zYbp3KhqWW48aN/p+lsQnVwMW2l7U+/rauswMHsDWHniHu4dbW2cVVHI?=
 =?us-ascii?Q?WQL1qsSCneManIc/PyXELp93xPHBfSez7/hqqoH0tl+HEydW6SAnhB/Uh7q2?=
 =?us-ascii?Q?9IdX4RGE1thuwpnYYhQewymr7ZQ+wUzpiGqfJZ+yOttYAotbE/yviD/8c+SJ?=
 =?us-ascii?Q?g3anMa08ajfU10zJ5GfARG28vjZZhsfOTQ0yTY2l2rWih1Acjs8sCqsIDlJB?=
 =?us-ascii?Q?0ZPUoP5aF+2jIF7bv3KjVJNevXb3EqQoqSGwec3+xXquDC7orIEh3ZNYXyJW?=
 =?us-ascii?Q?pSqqxPu6a4Hg6BlZO30AY+cpNSpfSevQ6Zn2D6Fv14PT11/6dX2IzsUn/NXV?=
 =?us-ascii?Q?NY9vmYP1dEICVvNIj/zqYW1spBhH64VuNHCT16k/m7m4APz4VTxIFeSQd5zu?=
 =?us-ascii?Q?ji4tYEyB9wy5me6SjW8k1sgSIPcfLKh0ngOIHU2YrZNRh96318l5Ig//CX4h?=
 =?us-ascii?Q?Eesgd3pWaueJAUplnw5ZkPNkO/vNTJXhLGktitwJ9BAbyZJg8Wrj2T/1Z4Tn?=
 =?us-ascii?Q?GnYd5/XHBC1V09FgVOpQsTV36QjxvwwrBbJm023biQucOYg0EknYea5IS59n?=
 =?us-ascii?Q?AqMEz51zxrArKIUsKVLIB9AjCCX8rD5gZX+7/RJlO1nPLCffNJUZ5UyTZU1t?=
 =?us-ascii?Q?liyOiEB2ScQmX2TvMKVd6dS1c6HnV2tNL6c7nuiVl528fDelG41NNWjltIr4?=
 =?us-ascii?Q?32fKVwSNix/UfS5Qsq6PED3eECYmGdEU7sHi1qylQwv34xKLxeRT0R+L7ZZk?=
 =?us-ascii?Q?g8otRKVsADWxbDJcqs0S+NkyQ8hiv+cyUp6yig+DRx3NVksExwZ+/yRMvT53?=
 =?us-ascii?Q?15dOk2yuRKojdU4VAIBXLuXv+0noawjjjL8vumxfNeKL+mSTdu/jS6biQBjx?=
 =?us-ascii?Q?DagVUivDdpMXu4YOaEujqucL5fVM71CflVsXXAePrO4u1VcnRQ13/yzkv61k?=
 =?us-ascii?Q?4dZR922l8acdrRn7k4/67GOm40KNhxA+HF9tHCuKFVcReEBA0hDQaA/tOHPE?=
 =?us-ascii?Q?froWue/WIhbVhGZEcUZWUtMrFd50rgW3BTdbEJnSravfMpdALcQs7kPSkwKU?=
 =?us-ascii?Q?QcS8rz/0S9KBCn3QkBCJ263YQflg4c1avhV+N3LvBKsD5rCvhZkmXuqM+ayR?=
 =?us-ascii?Q?V7Wvlo3ftQKlSmouxM+7CN0aEWuo9Xi7RFWeinYCaju9sreVcD3FYw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n/IqYDWFNXEzCdI3+IPk68pAyIb1l6TZtEGet+V8M4udUMzLxu3Xy73OLIYL?=
 =?us-ascii?Q?aGs3wcHDITYM23tXgtaxGPe4lj3/SH5oKB5hHXctEWyWIV81AbukWdJ/70hD?=
 =?us-ascii?Q?iNbeiQPDALgtwTwuK0yc+lcCL1NKovIWMgai9j9epKU39FAJHzHye0fh/coD?=
 =?us-ascii?Q?aP/gBh4K9Dm8z+tnYUzm0+gQ8NTNSug/8xACsOVTHGapLjR9MBZ7WRWw9QhB?=
 =?us-ascii?Q?CLFYrvShUXejmZWs5ZIPO5iAVVW44fvvgS60lNOEXgN6F5wgj4frfAgqKiAH?=
 =?us-ascii?Q?O0gktLVUbQy1kMFYNkfJLu0NsVmOhELxuas86HkTZ774LWQwbp6UrcyY8FOf?=
 =?us-ascii?Q?T/O9k71tQbZUo2QKCl8wwXkHRuXQTJNpGye043JAPdwxNkLc8cPZyyduwmb+?=
 =?us-ascii?Q?xBurXYYQdS1oHpv2K1JcHBQafjxoiSJY0dop5dK9mDeCbdwcjAs2Sc/K1Jnt?=
 =?us-ascii?Q?HzTqatO5nEGk6pPh1Do7qqy46mW5GAPN1omd03J1lnUgTOK33h6TbNSDS6N4?=
 =?us-ascii?Q?oE9bp2/TgCszlnja2YmE+AFb47lpAInZ3DmVGXTGyIUjeRPfKr12SHnm3EH9?=
 =?us-ascii?Q?7qAIMSC3x08Pxehs9GzoWzd349ysh21adY8JLHxbKSqEYjKYTheIzn9muPq9?=
 =?us-ascii?Q?B6/BociRLcVt6rhCzzWbl1Fg2OQSs7VNDb4Z8H/n10Fctn3eyPUe+Tt394nv?=
 =?us-ascii?Q?F4PlD9yEe/T2ylzeBzrZE8Q4SSsuznyb/mCWH504hcwNW8U7mOyjmCrummCz?=
 =?us-ascii?Q?vbA6+eh9k4rOjqRLKJOlxsjbPX7buELZu4aF1Bf/wdDdzfUI2KceNShbi6qJ?=
 =?us-ascii?Q?ckgBkUDFqLrfW9+sIH1sbx4DQmOv1CwoupzgZAmagM8eCG7PuEFzbcX0mb5p?=
 =?us-ascii?Q?tcjVZG9yiMOxi/A4cZbz8/EsyTWY/DzzYQpHfLrin6uqHDVcnvf+mLBRO3gD?=
 =?us-ascii?Q?1FQ2wDLTJbutifMzjsCJu+SIyk0gGBkjhk95QTxpGGSAQ1krREcwpD3L0Hkd?=
 =?us-ascii?Q?pMmNRuJD/cpYAqLWvATHJUs7wCq0LzZ0xlya9tbw07mrlR3z7/yA6TAuiajQ?=
 =?us-ascii?Q?2FTqh3EkwmW+3oLrQ9qKtqXqmIZvwR+RwGrMDm7abWNW3P0kD7byAaPR5ekG?=
 =?us-ascii?Q?mvwDk1fl1rKoxSFRFiMRAOkbQT72vRY0uSZVkw/OqDb2YlKuiODwOeM7tYLH?=
 =?us-ascii?Q?DJzRFddvUMCAfsNz+gf9KXgD8/BiisoSbL9Q/BxQtmBJS/qSRrUUhRXUu6YP?=
 =?us-ascii?Q?SXt4WS0KI3H69h2ppjAjM0V7kjhQz/Uq0I1jkUTQc75sjR3rcl9XoY8+icm+?=
 =?us-ascii?Q?WjX76voGzv9KOz5YOBGI74QaM6FZlGfOArsMx8PhwLo+ufeIrCJVE3FG3w7s?=
 =?us-ascii?Q?S70Eyw9AsZDQ+tFgFD2IT8pRPFM3ry4k9qKys8FdQZ1Vs3CSbWlpA9Z0pGj0?=
 =?us-ascii?Q?dDtebqRZlAEPOKN8nc0CNOfo2gr7bgcs/SkrPAapfNsFT9W8j5Z5+MdYoAWi?=
 =?us-ascii?Q?zrdkgu1EtjDUgijGa3u9KdY5bAxo1H81TNuXPk5tkuuqiqiI19iaQXs6mmAm?=
 =?us-ascii?Q?caf+Y7/+9GMN3spJeZqDiD93JcvwpvuEOMr+M9LwvQfC8g9oC3A1OTcG9X/O?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb2cfa4-31ca-42ad-18a4-08de3700bc38
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:55:43.1436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZjryhb9jouVV8h13CY6U+xbygZ6wcZmeShHBN3PxO12Zsu0KEVbGondvTu2QyQrC+pAFKoKByOGicp/82jZOX9y8WoeC5u78vAASAqJZws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
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

On Sun, Dec 07, 2025 at 02:11:15AM -0600, Matt Goralka wrote:
>    Hi,
>    My name is Matt Goralka.  I'm interested in contributing to dpdk and am
>    wondering if you are taking people and have a few questions if someone
>    can help get me started.  I have a computer hardware engineering degree
>    and experience in web dev so not totally starting from scratch.
>    -How do you guys get newbies started?  Can you kind of get me going?
>    -I have a gaming laptop with a Ryzen 7 chip and NVIDIA GEFORCE RTX 5060
>    chip.  Would it be enough to virtualize linux?
>    Thanks guys, looking forward to hopefully working with you!
>    -Matt

Hi Matt,

new contributions and contributors always welcome! To get started, I'd
suggest getting linux up and running on whatever hardware you have and then
build DPDK as described in our linux getting-started-guide doc[1]. Beyond
that, for questions I'd recommend joining the DPDK slack channel as linked
on our contribute page [2].

Regards,
/Bruce

[1] http://doc.dpdk.org/guides/linux_gsg/index.html
[2] https://core.dpdk.org/contribute/
