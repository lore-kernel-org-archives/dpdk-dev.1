Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B116AFF495E
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 14:18:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8941540650;
	Mon, 30 Mar 2026 16:18:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 1F7FD40616
 for <dev@dpdk.org>; Mon, 30 Mar 2026 16:18:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774880318; x=1806416318;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Hh1pzIrDNWn22Jm2fGdEiyBu3iBx16S5FFXuyKUx5zo=;
 b=hoB3juf1hf9mFxKV06xin4ZWUZHqX4LGOLVCgya4dfGqZHFQ5qQ/AB8y
 PAbt1SZPfi674a5F+oQLIWRPPSyMyPZ6g2tGTSowsEhdNSE4cBke82l6N
 WjCWtJ0vS+32OO8hYxppG6Y5f/pkLcTlq1vuikF/5YsaFDu7MyTstKusI
 2V18j16C0+9FvVVr/8M8xrAl6ioUXQuH9GTC9uaBSJuyj/ozlPRyFYtzN
 ZuBZoTviXSOflH6c1ldFs5HlezduonHLMe/bfX1vXW7+29fr/sClUhTLi
 7Lly6wtNKPCgBrC/uhIsv07jTUCnISmXM5/LYYxmEhiAp8p6aboL/Zj1W w==;
X-CSE-ConnectionGUID: qAV4fik9TuyfUErZN8mekg==
X-CSE-MsgGUID: 1B5Pe5BTS72UKI23mWrMNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="86565273"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="86565273"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:18:37 -0700
X-CSE-ConnectionGUID: BOr6zkjrT3agbF1kzwdTyA==
X-CSE-MsgGUID: lveD5SHhRZCsk07eLy6Ytg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="249123521"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:18:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 07:18:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 07:18:36 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 07:18:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARkeysdr1qXbemGlhZ06K4TfSzMJvo95mlWnS6V1XQrqgyK/SZspxBTAPnxxXqpebkxHhTScH4oriy0h9Ju/jCOIkvA9zUJUpK9drBA1sr2gizDauz87TxcLs362Jrg+nPl2WrKFUfj1BN99Q28Twg7emzZVyjmtf1eIc/jF++ua9NsKaBFPl/GtlAXfqowKmB184EVxoAz0cNTb43/SkGmqH22nqQ81I56X0WTwwQmPl729l/hTDQAhQ9DEJwGk3EyhM/5sFQGkZQybf5nZTffhDHlK4/x9hjq5yJSTgt1XsqzFQW6Xidu60XjUGriyQkXh4DwEbPHN2W6GzAQgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWXpGwlmm5ZUhSi26/t7jJa0XPjif7ZyYqarUJVZS8E=;
 b=Kg71x6bBdxQP/7cgg4B+c6MhW9LLiX/6ddjwze1/cpIn6DgkC6yUvnBcflv2AHf6Un6mf5VZKSxO+J6uWceY+gBFzwr4Xhnopd7NGEpaU9BVCkTQzXs7T1UGdKteBWezMPyA8uFO68PM6PoHoLNI2Yb/IiExiCPbjEQ4sS0aGi3vGJkp7zdNKQkIsjI0TNIR9bh60wN+YXTrQwgmlf+lb5YBwUnukigCZiUWb8NZCszCVi9nQbP3wDKZblyY0c+938GboPy57kntcOw3X83GYehdNAHP7GMUFl+hlursJSJayJGz42+7f3voEfygAVICbLTKZW9WDFLc6spYkThgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL4PR11MB8822.namprd11.prod.outlook.com (2603:10b6:208:5aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:18:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 14:18:30 +0000
Date: Mon, 30 Mar 2026 15:18:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: hailinxx <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <john.mcnamara@intel.com>
Subject: Re: [PATCH v1 0/3] nics: update intel nic latest recommended
 matching list
Message-ID: <acqGMcZAwj-lNdAf@bricha3-mobl1.ger.corp.intel.com>
References: <20260326005407.623302-1-hailinx.xu@intel.com>
 <acaBHl8ozKryn7zE@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <acaBHl8ozKryn7zE@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB8PR04CA0012.eurprd04.prod.outlook.com
 (2603:10a6:10:110::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL4PR11MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed89dde-bff8-48e4-2d4d-08de8e6737c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: cablaIfGTgAStbAjpMqUy5ezuM26eQKHjgNCkOUSS3712LAtwX49VhR13HepEVeWdDWNC+xWSkf52LW+17kNGnFube+KnfT+Wtdpzljx1Lr/GfUtATSlJlfWhb8Sap3HeYmIE67Bw6MEWVbj7t23KQR3E7S9HvYlwBPdmXwe2BDRVqfIBx2QnegmrRKnTeG1joYgVShmYtId3YVlxH5gBM/7Z+kqUH5HRf+OHrxYCrpI9ya+nKntPfwdKdBqvpLPC0pM0DdlDs6e1zqWye2mXQHR8ou9kXfa+LEgou1zvyFL98HYoL30ElKUGPZyi/kRjqY+VCoanH/cuNk7YZ64fSOCCVrF4ep5Ce63+obTwKxSquS2QoC31aHxQuVd2i8s03aa4+V/XvtKkHTL4K8QI2h6bOu3ENFvldYyzvz9xBPUJgKITH2pnNbDC0Off2b9WqxOs6NHTqmsp2QFL6/VgDvFJQR5s+nFuIFEUHmutuzmaF/cCX4DxuJsbKHfC1FLf92CRes6zIgRRGtjIlzs7ura8F9Do1yjhucTuLtJed2BuKyKc+pmwbLrKA0COAKSFopAgcHPMC4S0cfVCGF1SSaXlA7FYd5IoQdc/gfkko1GCpTjPGLLP4Rv64uZcwN/aT6o6AUZPrR8I/60mDxxVc7rjz+E6s2errVV2NFOBzvbckQwZ6sffY0OSxsi3bdg1xrsg6uZYeULot4bmY9aSg3kIZt5athQEI/sT6tGZgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i7AH5OhOuS3ixZFkdboffrHYygZA7I7aLCR4AgSUFyCRbECE/HSOBoDVhHMX?=
 =?us-ascii?Q?achpF0imxsrpKIBPdg0uEywbTYsfGcHWF/NxvgKlDfhlEwBpYifNLcCJND09?=
 =?us-ascii?Q?Xv281F6F/u26BkZxM0fP8HdomlBlIPKz3CZXHIzv3nT/o5WQonQXNvecsckP?=
 =?us-ascii?Q?PcCA2gkSRrbVJsd0YGErXq/wVg8KbOkh/mT89QHEuzLPnsmTsHXURF8bVqIb?=
 =?us-ascii?Q?uaAknXqNHKbBkENVlb2ZVXsi8bSZEYy9vH9GpTHmMcBvwkhCkK/+k6wtMFeQ?=
 =?us-ascii?Q?y1HeBRJj4FDw53TrUYq0TZ+m2o8EAXpCrmk3n4+82yyAN3/jLXwC3z7538o2?=
 =?us-ascii?Q?VhoDWewEQGPLk0QF0CsVfIJznCsV1uYhE6ss9oZDI5rsCP3KU4dWyliymPxx?=
 =?us-ascii?Q?VXn6RQz9G2QFahta492QOtoPFvRdo3Ye4NWQlTc4bPK8pt8e1RkRweiudK1t?=
 =?us-ascii?Q?WaNe+A/fV7o4MJcbyUURLpoTnOwvq5Bhpu1b8j8GlbD7Pzb7ga4kkQy63Nqv?=
 =?us-ascii?Q?tYErwWrNBK4ejBejftKAyIYV2bnj6u1tHNwnLalnBPD+O1tOd0oyJpJyW+UQ?=
 =?us-ascii?Q?F2AyCno41EC2AQ6hjTefPg2gTjsJkWb6AZnZzoeXLOtQXtovAuw1d622ev9H?=
 =?us-ascii?Q?c4SK8UsszVxDVchrjduETuyUnN4WIUfaI1bjd4jgZtnzjsLm/1UZ41nfldDM?=
 =?us-ascii?Q?qcyFDrUgD7/SYrGHrDB1N7/SvLZOKpFq+I+zRc2wjDETTahEvbFoiCJTRAk0?=
 =?us-ascii?Q?RiqbzSyKeNM8UmGpspLdshZkroLI7UdUvm+oMagLS0AlLvc7NWTI54wsBiyD?=
 =?us-ascii?Q?b5MPlGfOZbsEDQUzhNobacP2Mk7unbR3RMP1I+Hj3/THRbXizTFZgkFBVd5v?=
 =?us-ascii?Q?0BThLbXeSTu/601ZXyDA/uObcBT8HPgYv0hv1w9fgnVkMt8FdVtS7gx6pQdA?=
 =?us-ascii?Q?lcYQmnZJhLx1XDpr3PQwqmSsNlAOGxICzLR0bmlItVcMws++RiZH++sepzgD?=
 =?us-ascii?Q?2hZe54rSNOrA6hjV9b7OenAsdb3tQdYzXUyeypAW1MUqIb0czA4fuVGhcRbh?=
 =?us-ascii?Q?KNQbjDrkm37xl1J+GxGGKXD6lsKftRgVMPGfwtMY1RaWF0TLLOkak9UTSIjK?=
 =?us-ascii?Q?SrJpllUlpyr5bc5FcxF64XfPZ7WfPHZdh0gcmAsDy+2ve1B3+h47gNsMGj5M?=
 =?us-ascii?Q?T74JQDnHfgsLf9wKRUTUoOhK/M/7hT6I/jGkEzVGPZ9WAkyFEpaWz2jmzGq1?=
 =?us-ascii?Q?OVNJsBa2himUtIPWi1a3oevdF6q3fV43JPM/bRxJ5cIR8lwHEu8icT3dylUj?=
 =?us-ascii?Q?atU2tmfqgyRkMzsU9KjLPHLX/sr7NJAR6BFpX/DefgYP2bk5mlWDw36UQSqW?=
 =?us-ascii?Q?5XL0Yh6dWpBb37lziFgP1s1TKBWLYgbIViCuR8evBwiE37oO7b3H/IGK4/oO?=
 =?us-ascii?Q?LnYpr+4zFYhKAdSMhmlteQTkJV9Dbx+F55uZhC6F5SHR2K5dn8qRb2lwByVx?=
 =?us-ascii?Q?Bm1ZsL02laaVThebM8l99hXDlXkwBXz3ytvT9Lld99+Nsz/luGrzYBANpl7d?=
 =?us-ascii?Q?8lYeWVmuN/qZwXDqA1nzR4ENGDruBnyOGxKybr7gScZPs7x9HtZ/E0RPNcvc?=
 =?us-ascii?Q?8Z7d7FPaW0nsU2hqQum0MNh7dI5RUPofkVx2Gp0C56Q9aQU31i7v5qG8Nhg7?=
 =?us-ascii?Q?W23dcILsoyqhfiruAzYG1v9DV2MLzn6Cm9Ua8grlaESd48E1Qn2dC1kczoEX?=
 =?us-ascii?Q?756SO11WZvzaxdaX9Z8yGSWGndijbUk=3D?=
X-Exchange-RoutingPolicyChecked: bOhT7boq46OwnvFOxF0wB47UN68sF+iJcy0LaD9vfcLsRo7sSw1Naf/Ptdob/sGAfC7o0AY0dAokjyaPMz+emIqkk5iYFKylte7m5rzA2m+hXztYxJq9xCH6Vd6G4TokobcogFFylmO0SDuQ42EaCr7OPez00q8YEG4RFbhEf2N4DhOUMaX6+Ino04IJeYHYiPdY9e4xLWP/MeSumFJJQYK+ylLl2YE1NcD/H1W/gjmcjl7gkzoMuHXkgywWH/6GV4PkdWx6YrO4BFLi3QEEult/x5NSwitgQX/zGh7LVs6rQ5fy9N6vWFnY3J1CBrjoRmYZFw6Ulewtqw77EjamSw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed89dde-bff8-48e4-2d4d-08de8e6737c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:18:30.3513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hG++pL3Q4HBnKY8oZW/y+TTTUTWwip30UFZXma2914uKAa7ovaDjkoC9iaFMp00dI85G2FkKkQCLvpQ9XQdRSC/u+6NmOyVz0BPbEg/lf8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8822
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

On Fri, Mar 27, 2026 at 01:07:42PM +0000, Bruce Richardson wrote:
> On Thu, Mar 26, 2026 at 12:54:04AM +0000, hailinxx wrote:
> > 1. Updated ice latest recommended matching list
> > 2. Updated i40e latest recommended matching list
> > 3. Add ixgbe(E610,X550) latest recommended matching list
> > 
> > *** SUBJECT HERE ***
> > 
> > Hailin Xu (3):
> >   net/ice: updated ice latest recommended matching list
> >   net/i40e: updated i40e latest recommended matching list
> >   net/ixgbe: updated ixgbe latest recommended matching list
> > 
> >  doc/guides/nics/i40e.rst  | 52 +++++++++++++++++++++------------------
> >  doc/guides/nics/ice.rst   |  4 +++
> >  doc/guides/nics/ixgbe.rst | 28 +++++++++++++++++++++
> >  3 files changed, 60 insertions(+), 24 deletions(-)
> > 
> Please review patchset [1] and see if you think it's worth taking and then
> rebasing this set on top of that?
> 
> /Bruce
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=37782

I see a new version of patch 3 has been already submitted, thanks. For
Patches 1 & 2, I've rebased them on top of my set and included them in a v2
there. Marking these all as superceded because of that.

Regards,
/Bruce
