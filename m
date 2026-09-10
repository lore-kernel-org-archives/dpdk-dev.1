Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6383C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:06:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8CCF4067A;
	Thu, 10 Sep 2026 15:06:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 31D0740274
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:06:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789045572; x=1820581572;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6eOFt9QKw8QBwfjW+ufGH6/ZNVeW7RGR9h1C9wWpvEc=;
 b=ZsQNjxmvUZ8bMS3329mNNgv27WCrYC9sX4nOp//5MQ8+c46UOgqpBDqF
 qDAcxbJ/jN05k2wKGwJBlE51mblekBiu+SC40tx4mobxzwxBsP8LwCwOm
 ev+CeR2pKdzqI0cQ5Mhn3aJBAiDSSJVzQdqzga+P3Lm6ddQBwBMdiPY6P
 +i8Do3UnFHC72SvnOZ+QA0hImETmW3yzYhR6+yYhLMtUSWu5Lv+ol45cZ
 3I+XYKO6sumbQ1kHUE845S66IQJG/1drdEk77hyJxfYNtbTpXTETKW1ji
 Aganh6SQbTLF4E1nl6kaZjr+ayLFocs1dGU0aXXdN+j0X66LTYrkjHZB6 g==;
X-CSE-ConnectionGUID: BOWENQd3RNm2sTfHd374RA==
X-CSE-MsgGUID: yOlDgUI2RNC9q0KKUYr/ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100156259"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="100156259"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 06:06:11 -0700
X-CSE-ConnectionGUID: CwMIKZbIRyWJkoRm4nZbWA==
X-CSE-MsgGUID: /KdWzCiyS2SexTQ7WPsTkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="309891479"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 06:06:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 06:06:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 06:06:10 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 06:06:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHsT+Kqmyezisk5TuPOusaoSw/TY8ZOOgKfQ90Us+6wIG3jN0VXyJVu/gsv0FPGhlLVCOSrjN0FswBH56VGz+gIXdD7QQDX1Wp8vJ7aWAEewkXT9HDhSlvxomuP9bcQgZwaa0witOws1Dt1Pc1qATm+LYo+F3jElZhB7vSIEMxTLu8CqJie9L+wiZ/Hy9wCt0dvYu2vwvAWYeAdgy0DxTyenBYCIHjuxjmHgOOdnN641nxq75F1aLTH5z78yDaRA2qzdFIzJOq/SKzNyXKCkQ8NVAhWhtA4ekJkIYc5CR8uOZxAfGlAD1jbvI6OIOqXovks1gIvcob3sDnHNxecnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFpSnqzPF7h8+Q3/XDiaKZfV2FYgzVL3bbBwS6QRo4Y=;
 b=YKwQ2g+0sciH3Qg87QdcnJCuKaLRGONJjl5rpRu5EVY12U2MWT6BegCv60AQKSaI/jSVs9tj/aV3Eep6S1HXsK59y1DeK6PT1zjBhZseOE+N81D4QfPXnK/ik+VSb8chKqAi49RdVmaPhCQdu2GjuvkSSVB3OyiiBGHZnyqKZY+9yLcc4cKD95KZ00ivCQLrSLKDRdUPyuTyuN0965i22Vnaw2VZyQEMJPaxKdnAxJKIekgIBmBNWaZ203cFVg/i7r7OuybeAiUMuzTi+jAJxZB/2hPT2jPFFP2e8woMGi0+p/Q9tNvp2USD1zxaLV1e/Ye5yfpn6X3Sd6bTyf9NUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA1PR11MB7062.namprd11.prod.outlook.com (2603:10b6:806:2b3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 13:06:04 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 13:06:03 +0000
Date: Thu, 10 Sep 2026 14:05:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Atul Patel <atul.patel@intel.com>
CC: <aman.deep.singh@intel.com>, <dev@dpdk.org>, <praveen.shetty@intel.com>,
 <dhananjay.shukla@intel.com>
Subject: Re: [PATCH] net/cpfl: fix VF ID calculation for vCPF
Message-ID: <aqKrNuyNM4xbGVy4@bricha3-mobl1.ger.corp.intel.com>
References: <20260827212216.765057-1-atul.patel@intel.com>
 <aqJgsdqDhe2u1QW0@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqJgsdqDhe2u1QW0@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::22) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA1PR11MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6768ca-7cff-44b1-8ae1-08df0f3c44e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MFWyoGMmPjdsE3tX4rPzK885512WruoYP+0x4iSNtqoBcfHWNETYb3QcQ79lninkcF3sL5RgtjGYdR4wvSf1hodH0E3fwwoXwu5sLTqDKTrHm8RTPwEkc8gs2kAxl2FGGCSbTEXBLP1NL4Wm9VOicqdulE+eV5nrsW+Q03jLP+lPiPDidWYioD6enMl+FkMN+sOzhNQJ5bvjPFjpoeW+c4xA2fVrhLE6b9gNWH5p+T6sNDwIMbmU654MLoC1q/v9Gor3MusELBMMbf8UaL12OiMwGpmjR/63Am76aA7FAxc4u2F/9Zdljptr6n00qmim6OVygfw6A2ChGfKOazkRBQm2Vb+HlCcRcekqMbRr6frYeTqbrSbflavoeXTQXLzhB9Zb/gnPtx3SlwHCteuGMHpvxznHzR9g7M87nB5uhJAOe5gssEWhqWRuyNDiQ/yoFmqNeupi1xJCixSfHnzUvdOoXEilSesqG3X2GYnkbQvkNeyb1g0moOBZjJL/AJ6lzEbJ55GV9XUVwNVfJICRh6tRsL7GzWaWP6AdNng2Plh0ZPAl8IAP3JOY5HNxPmKq4bQJ5f5xlbpHR4X+vu2G4kCZO6upH62haBGiXn2JcvKtmMhlRn4K6JYVKtUjRAtW+e+wXPEdgdqqGH2lOiHUXNjcSl94FBv6TLl4V1kJzDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?thnl/142na8qX+FqOF8N1fJ5r65eUXTM0xQ25iLZRfnj9Fd4aMWw+/xTRwcP?=
 =?us-ascii?Q?pEonO6bHw5iyidPvqmhJCkxHw7J/UH9Qny7rK92IFNc3/A8pnDWWhuUgl9LW?=
 =?us-ascii?Q?gVbES1ahkJodvJUUzxDrns7mmzE0y502rhmnjtE1n+dIEFxsRbwgXr3YogZ6?=
 =?us-ascii?Q?W48ScDsAxDAYE0nYZw+dCqu3cMO1Na2QSmxaAo9V7vgjGMZTfcrnJ6DfArbX?=
 =?us-ascii?Q?yz3I53I1t3pvpTOdd6kFbMYhWFz6H4rmzvpaqnNOCV2DgI2aI00SOU9xw10j?=
 =?us-ascii?Q?9WsYMnBKWWdupSV2bYTET9T4ba007BIZCTc8WXQDcI7zl+kVjQtkAh46xp7/?=
 =?us-ascii?Q?xx4bEpnKdg40XPT8O/K8vH9P9Qp98I2h9N97pfi2stWOlGOWzkRiCemr3oRq?=
 =?us-ascii?Q?SdkXx+fwFyUv/vqC/718YtuMa6hOJaqmqzXu1aSeLbD5qbFX/+bHdj46rMt7?=
 =?us-ascii?Q?vBotmwpR+ikDrsOzoN3tTugXW6ouyDkrc6/cK9h3MHw9X8YWh5SLLeoBQbZh?=
 =?us-ascii?Q?kQ7FMR1Bl4INA+KUhEALyAV/JVtMZnEeS+LW4v/kLxYU3zuEnfAAgnGD+1d1?=
 =?us-ascii?Q?2b4HUDGWaJjmx0Hh4TW7LNG6FnEEeJfvMAoKkiQS8tMfo9VO61E+pgOuN5x5?=
 =?us-ascii?Q?MK3vOJIOqDq72NAqFfTWi31+qv4nYbyUrferLSm8KlGU/4tfzBFuRYP8Y4HV?=
 =?us-ascii?Q?bq+kADhoXsKu7hvxcjUaZ1O7qRbve1FO8VNHJUNCriebhLDr1eUuFBWUNAGy?=
 =?us-ascii?Q?me1jdAQgvKodqjexC2RYmQFOc1pRypoZmSgQxAJzXuQizAss2QMZtGXtGTcI?=
 =?us-ascii?Q?iV84VY6NK2NfWPUI8eV+Vdsz2sY8XhUpW6CwXvCPi1rk8gWG/r8Yim0TRrFe?=
 =?us-ascii?Q?Vd7CQLbGjYvUktIXICmEOA7vvH1HCbpPH+7kBeB8P8JZgEOhcEa1iGOZr3MF?=
 =?us-ascii?Q?U01CogaxyS5qd+P6HGjZooBhL5PEPr8WCon+exHK91NatVqoXoFldBpUiHUq?=
 =?us-ascii?Q?EcFGtuTdnUCa6cvTVYZOOpQV6dwC82GLdwgRlkZB0hT0+as+42Kj/cVQyNIf?=
 =?us-ascii?Q?SZCMkfiAPSDRl4DYhUvI2l98za0xCh5a5LwS7KwIreywblbv/v4yeBplOZ3y?=
 =?us-ascii?Q?GmZnTNupXnYJ3v+GzCyT4Ah5+6Ln5I2Nq2zm5vBZ6xRdTDlI+Uu/MS2gMMOj?=
 =?us-ascii?Q?zs6QKV8IUDFFQyf5RMoood5P1rotwpSBDqR1PtIK4Xc3SsYtaNq4fSDnzvhC?=
 =?us-ascii?Q?nk62P8a4yz/PbVG7ucMRCSjKNu8CQiaEGUW6PfYZuyt0L67G1uonih0Zt1hJ?=
 =?us-ascii?Q?I//HcjhCts7+HU6GYTBNUmyTj5OzLGelNg2uNdzYD6QZMXJ1zZoLSGwv6AQN?=
 =?us-ascii?Q?P2QBO1DCg5baUtVmDIflg7vzAMzTTM1+NclqESxji80gX9wsKAleskkzNmvy?=
 =?us-ascii?Q?Ihlzi/c/lqMMIVfLgeD6WAj4S+dCfvZXEZUyiIWRkqxc8mO2Vz2pOFbxALfT?=
 =?us-ascii?Q?esJo3eTFFSqD0CQh0mCnB4YPwJ98J+9q/vWiAsq7ZWXVu6AEyBrDo587zh4D?=
 =?us-ascii?Q?E2OVwyu0fOn9ZVUdy5MK+2K018wGDH2Anywx0I1BvVzE0dQ2CL9y6aW6iYio?=
 =?us-ascii?Q?8+unTVHsCvLwkYh3HOyCP+UgBxugdMcOHCZ8rFTjEzCdTTcopanN7JIqwq0o?=
 =?us-ascii?Q?r4XfFBhlNLyoaaP4KJJ4F77bqrcsLZpLVWgXpdqHawjAW/G9DUe2banUpoFk?=
 =?us-ascii?Q?Sui2YkQU2Y9GGeosL+B9jsF2aZXqmz0=3D?=
X-Exchange-RoutingPolicyChecked: BZi8NWLj7xCxtkqVEZgG2i0+5HC5ZkNP/g8LGdhJ6/0rl0vpExmoJCeO3jmw52F9y9tG078Z9hl/bol6kGJSH3GuFrWT7LONrFbf43PrORHCFRoZSKjw9lQRiXyoTlJ8k20mBhw8U+C87j083/a4cVyysqW5/IopjjnvvCxqb9EI5Xuzmeqez/hJotRcX0SoxHwIzwuZceRT1M8eWCdToKaG2HR2mQY1UbKW7yGlLch3rgBdnGwtc+dorxDf5OxU82+dM+S+YobnkQitx2w0fG8oorChrhxKVg4ogZ6ybKfgGMoYXSG/WJDztbmnpxBhpVnPM5guwtoh8KK45ZoqMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6768ca-7cff-44b1-8ae1-08df0f3c44e1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 13:06:03.9303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HA1yBVcY4l7EkjVZ2i+RQHtawf9mcl9ogxE2OpYw1MBO62rb6d4YC+dacmyc4Z+MMrbVwPM/3x7bCfOf2pHM/A93Zkl2dsCWhhgh/BYj2/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7062
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

On Thu, Sep 10, 2026 at 08:48:01AM +0100, Bruce Richardson wrote:
> On Fri, Aug 28, 2026 at 02:52:16AM +0530, Atul Patel wrote:
> > The VF ID was incorrectly set to only the PCI function number,
> > which fails when VFs span multiple PCI devices (device IDs > 0).
> > Calculate the VF ID as (device_id * 8) + function to correctly
> > map VFs across devices.
> > 
> > Fixes: f1ab44fb0ebf ("net/cpfl: add vCPF port info")
> > 
> > Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> > Signed-off-by: Atul Patel <atul.patel@intel.com>
> > Signed-off-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
