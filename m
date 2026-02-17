Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6884FE909C1
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 15:32:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FC2640261;
	Tue, 17 Feb 2026 16:32:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 88131400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 16:32:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771342336; x=1802878336;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tISzRzv/eV6G/u0bx+KPQR6wYxLvQ5q+TNsBoVUMSi0=;
 b=Pghq08ylNfrwrxzklvHvxcC36Zpd8STbuvSMPUfFf1KL2YZtYIP9rVSY
 Nwc33um+ZzdypfbX4G07yPEA14rSrAhUnaim83N24oCXBrWj5Ax5Ek3Lg
 mCAW1sBjwABMmzC3IrOhhNjh4E/jP53dMEYOrEDQwDbz42kMjHRGTBFus
 n0PZqq5DEPeRKdcJEJ5v66Bf7/vchX3DuQGlaPhIFSgUsLzlCH72+4Db+
 ZPBsWS2vKgNZ1g0noFItQ03sdCXW5zYUSTU3Iq8+C5MShzYuovx/QDjsW
 y0GUNtM8zkI+ez6MuBQFCAi5PiBLCrzujqo3yCL1Adz2qZCc1hIp4kQtB g==;
X-CSE-ConnectionGUID: q2STBeIITTOf07W3MXzr2Q==
X-CSE-MsgGUID: iaYkH+TdSweY1R4294a1+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83133621"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="83133621"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 07:32:15 -0800
X-CSE-ConnectionGUID: OosDtuxoTOiLMmfoPsI/cA==
X-CSE-MsgGUID: JLCxNgZ6RjSs1Uh2zxS/CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="242881449"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 07:32:16 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 07:32:15 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 07:32:15 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 07:32:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOYQE8WbD9c0v/uSp9hyfgUVeyMc2Eqf9Cvqx4RgMr4G2FKef1uBbztWu3MW4QjwriPI7/mlBrKwdkgqWVF4GHBmnGPRYMe/z+VOcnAOhk+HI1YXrTiAU8Kyogl5yrBtsRSezJg/DX/d5RrDkEWzv+vOtbDg9lQ+WCKmNQKalTFiptjIwQ+A4yWBbV4CQt2ayKtIC0C8mv/s6STH5lWybgaI5XaCFm2IZ2rHDH1jKvRDnoGpqMmaNCxZjiXVFgyCB7aW8FD014EybB40JpGBmlZPl+iV5tiiDlegJSOlcDad685uuaxMaPOLcdU4hsCIXSjFHY7CrkaW29gWqs88hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lUxwmdLJOO2XZAcS8maP6Nux/LxdZn27ZxE0eXRvA4=;
 b=ap9oC0fMIxzYF2qawxrPTrsW2grrCKomrp9SSwIhRz0UfY/JFEmAArr81K6Ifyu4ZfiKzqXrIb3OTbiZysVX++F6ElY6IZXUFrc5XARMotPG8px8AJjNdYdRlKku2hOZP9rc4WWFbgnYIRHtQtrDAfF8c6+pij/T+xYfUzg2DymXGM4H1vce5ObK4+HLrx93QFrc2LJ9jKR1HhlY5sHR9I+Zhe6ywDMBOZEJoyg+VoGOBUJJcDP8CwDOfUXxS9Qw5rHMqvQgVCEJjhD5HFD7qXGZbMsKVc7pxhP5I+nAAgSHyYr6+GY/pCBpiNrcvdeV04mwJ3K6MzMEfu0RJIKP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6840.namprd11.prod.outlook.com (2603:10b6:303:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Tue, 17 Feb
 2026 15:32:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 15:32:11 +0000
Date: Tue, 17 Feb 2026 15:32:05 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 01/27] net/ixgbe: remove MAC type check macros
Message-ID: <aZSJ9aC2HBV0bCm8@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <f0047b363fea648bf7b6815889c0b26b883f56c5.1770978324.git.anatoly.burakov@intel.com>
 <aZNMy_1oOKYn-AZ2@bricha3-mobl1.ger.corp.intel.com>
 <d4d45144-01ec-4c6f-86d1-1ce65930e06d@intel.com>
 <aZRmDeO1AUlXE63L@bricha3-mobl1.ger.corp.intel.com>
 <0398b195-9597-4dfa-88ff-8c6eddc73b49@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0398b195-9597-4dfa-88ff-8c6eddc73b49@intel.com>
X-ClientProxiedBy: DB8P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 768e3f0a-875d-4544-3b09-08de6e39b7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TlyjX71tnkYIK0pgTVGuVm1XXoCnS4Zp0z0lNwTmSMC+qAmiND2qlBJ9BYh1?=
 =?us-ascii?Q?UvTTQVTWt1uVlvYIWth5zV9QXb0uAMK4nCAsc3oKmPhsFfeOvAihHjmmjfzQ?=
 =?us-ascii?Q?MsFllrdunOs78qCXkbpGQ1F3NVTqb8AW4s63Q7uvzBV9v7a+Cknw//TxKE4c?=
 =?us-ascii?Q?PqYBOI123FDHBD1oVfLvln+hMVFgZlmOtGB4WBErR+IarnWz417p5A2WZjEE?=
 =?us-ascii?Q?7MdfU2bIZO9Tfgbt5wMFHSxfuUQ5i8Y/LYY6xQ0l1ycmeKs4VrZs0pfLc+pe?=
 =?us-ascii?Q?pxqKbhjbDxqC3UGXZl2zCBnayhYUmCN990roXCjFsNwHOR4Nwp6Vyt06tVG9?=
 =?us-ascii?Q?vWK8/eufs5xnmnUsuXeg/NAd7UH1/UWsMb7ua5YEQycwMnixaE2b4F4AAZrB?=
 =?us-ascii?Q?FkeUc8giDJDkj7V/AhGVIqqb0gqQnMzaKM0JOmlnQ5io/KBhyxB4X0cUGlav?=
 =?us-ascii?Q?hZAfYcJ4W9fmIe1osVmdl9qdcutLpMBOtOZ786XoPoCpzLc2pT+lzIqVwPtG?=
 =?us-ascii?Q?xY0XXJBg3Kk61i2rIbtVLA6+PVsiO51lS2BUHzf+1dax9SqlwHXk9hI6UfHc?=
 =?us-ascii?Q?sSCfX8JdCKyzYbO8+ko9+zSwYjByjXBxZdhpmZz71aP+XY8+jOJq77fl8hna?=
 =?us-ascii?Q?jfh4l0AuM+VmyQib0YYLuayAq9jAElilFur2y2sv7ppn91ZcbhHL+xWJnWwO?=
 =?us-ascii?Q?aYAc549b5Ak7aPyH9Mf+CFjjckLZKlTQHNzID/BLc7/N8k8ob/b1pyEbG1Ts?=
 =?us-ascii?Q?bZP3gDmiaW+QeiTrYWmawXx77M/IIQCX6A/2pC6V4slcNumxYZhkjP8TOhgJ?=
 =?us-ascii?Q?+20hMTPp6jzolDvbq2VjilqBXqxMYgcqP5N27wWC2xdkhCqhQFBCpEaWbt08?=
 =?us-ascii?Q?/VAPVejhmSlG6w61ppAGwCpAZ2aWUO3NwyE4VwnxkaOK28BVfhD5X4srU6Cy?=
 =?us-ascii?Q?VgirOlWqrQ9GHcjOoQnjZjriCqfsyRabURkdpN1JgyGykBBvS+QN2YR7afWv?=
 =?us-ascii?Q?9X4aq6rnX3SlypskoE7+qEqRpBserCHXZRXSqyICgumHmunCWJLdGIY0iFPr?=
 =?us-ascii?Q?R1w5px6JMUiP4D0P/s2JBWrWNYnjsfG1Q3d+dse2O9qeGGAscIv6r94/yNp0?=
 =?us-ascii?Q?sjNVS9imXcaA3hnPI3JLabrjtKb9B/fqlcKIw0Tx+ed9RbUb9QZlrKyJmOYN?=
 =?us-ascii?Q?azC3AIMSkIke/Q4Ew/cvaWqHPnB2Yv1mWNknvltcigkNAzvkiKi7q3SM0D5T?=
 =?us-ascii?Q?8BVTuWwazbDEAgziRg/OgwHFYtFBjZIFXXqq4V1E9TbOJQCtZWQN6cCXeL9/?=
 =?us-ascii?Q?5r2m3Tk2Z1gg5bX06gm3/MJc4q6s7MWJXIQXf0l22ZdLLCsNYPxGC7Iur8m4?=
 =?us-ascii?Q?LhRMTQLoVzInq6pc+hQ0X3w0V1LaCszR4VrEPtspZLsBszggos75xY947piw?=
 =?us-ascii?Q?3KhBZxrHHqu6nwlhT1U3GjoSU0Ld34aXttiPFVLDJD6Ua/UXRK4ednFIzPS4?=
 =?us-ascii?Q?K+rXGHJ4q0MSKpjLES2YSWKXEMRBz1FfvSFSFUancKj9sixBEKs8FBGDgGqe?=
 =?us-ascii?Q?LXe3dN+oQOtk/PICqiQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p6V+J/Imc37PfWbNUl8/73HEv8YxnRYDL+hBeTivgo7PiqZdlvAomXJZaSzd?=
 =?us-ascii?Q?7UNd9aaQBUgPIL12VCK3ghZRYMr1HSfUZ0SggjxFjlhXhvPjOcmqJaMaApgx?=
 =?us-ascii?Q?PsSRxIyjgrEfjs+VCRoN7Fel5TL1V3rIa/2rvWwFf8kjygc+meI3TWRS47N1?=
 =?us-ascii?Q?GjksdP6iTdnJp3GWBFobBmuO3R4QSNzC1igRAtxCb++ZRuLfKHQCvRkFDI0W?=
 =?us-ascii?Q?77ZsLCUdhI6UYWwdiH7jQdp+tTcPlzZ3OkB6XUl/Hr1JUtUmnso63LwaGjVo?=
 =?us-ascii?Q?JmaSpKkCWsIWW/u9GcQ63OUMnrhnybAOLGMPk55zDm2GkGzl20nUBJukblRY?=
 =?us-ascii?Q?QAYnVxJJycq+EMM56RwMaLcbs5yNTKCKCODBL3GPmkSoPjIAFEAEGdEb8KJN?=
 =?us-ascii?Q?H70P8/aJm0F4VxntDWJ1xMCou/N0tw3TOn9WY45eSILJlOC/5NQMZSf5TmhE?=
 =?us-ascii?Q?5SSSC7Vs3Moo6RjrybXb371j34Wc0Cszp8pRuh9bau/jqoGdTwtXNmxq9gog?=
 =?us-ascii?Q?rHjSqW1ZDagV1TAZ3c0b4tMrWjsqt2QufIIaQz1pZT2Qs+t1cC0N2244HKiY?=
 =?us-ascii?Q?gRagKRfiCph49xT4VtMFAPjXINXqaX+U5owSDqCNd/GcB00SYzYZ3GYgQCaT?=
 =?us-ascii?Q?z6RwOcGRMNtOUbrE9gna62O6Hdtvr1wNx7gj9tuo2YpyGpa162/P3WVOOj2s?=
 =?us-ascii?Q?r9evfqou8I/Wm2TjrRDl/IKm97Zol/cX6+qtxxLm0KScK6GenY3HYpErFi0Y?=
 =?us-ascii?Q?97DJugj3I9EdzgdHHRqYLb3zshcbc41zuJRYoHp9eruq+x0hZZnyjyIERmUY?=
 =?us-ascii?Q?PYlIn0xT++g/iaEAsqpA5Y7/3q4n/hXOScCf30BNodygydmxxJcaNkZsDAbh?=
 =?us-ascii?Q?5bNa3aOKF84obW5w9IZ2cIhTB7cRKafHyIxW63fRmtx7HoZKi5CPQfW4znat?=
 =?us-ascii?Q?89ARKp6kLXmamr2aAhAlZg3BjoejawuYqB1bGfiHRBLUE0s5v5hOmbr+0ugO?=
 =?us-ascii?Q?AEtRfSgIHKOOwdmgKDW909lCJR9LpepB9j5KJZZnnABb++FJQJoIhMLCNmWy?=
 =?us-ascii?Q?NvlQ4aA8gQhmvO9RNoh7b2ohr7tz7ibbVeh+eGCbF6HZZVeLWtAN6nAQ1DKa?=
 =?us-ascii?Q?WaQ9+uK73xFEOUSemP6noNOf5rWeQKx292HLp/fFaT8AC/YIvNiDBHwHbN7z?=
 =?us-ascii?Q?UOr7Eur0c6DfpK0Xnq7RGStWK8PiiaAb1IiFrTHA9LyJm5XBqKNHGbyvIWPb?=
 =?us-ascii?Q?aV52FcShxh9wC+29rOrdTjiL7dXuYnzsmGr9jUNAGX7a32i8rGHUjrzTZ4wA?=
 =?us-ascii?Q?YXa7vdep011E40glPJfc6MjFyXAFs4e/b92H8IG4u598p8OOoR0FeOE1dyDk?=
 =?us-ascii?Q?0CcANyAt+RXM1srJ0k42eoGdxSMq0OeNB7iqIxUS27WOmr6k8sOK8xqxK7NT?=
 =?us-ascii?Q?kHs8Km+7tnzqVVxPqpsLVx58DXr9C9mit2OgCOUP02Wz8PqEY2yG3M1Bo+Y6?=
 =?us-ascii?Q?7x8JLLz6yMHv8Izzp20OSwfkp+pjfAZI/jaXwC1cTIXZqynB1c1WOXV7exiK?=
 =?us-ascii?Q?W2Lo1pIdu1Lm36aQ/FplU/u5ww48Bzj6y6/pCl4EQqfruh3n3L0qBzVhShvR?=
 =?us-ascii?Q?YhyTmGUggt4PLa2zZV6TI+l4GUgzlMWIp4eFl4FYJh7dnTMWU1JdU5qsCNj9?=
 =?us-ascii?Q?A6iKCC40R5bXZdBbZwybhgT9DLQUKZ7n+L3WuzSM49ne2kZamkgsnCuX+Dp2?=
 =?us-ascii?Q?Ut10xXB3dlXWHwlvk7K1VFga3BSC4dA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 768e3f0a-875d-4544-3b09-08de6e39b7d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 15:32:11.1238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMqyY3kCcDVFjYn52p7SE37K6tc8uXYrrRsGlt9Dffx8znYrMxxmE0Njx0G6K5sQHAP/7fsdpj35iCSdVd0I6zfYosNINTuQULDpYCDO6zQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6840
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

On Tue, Feb 17, 2026 at 03:23:00PM +0100, Burakov, Anatoly wrote:
> On 2/17/2026 1:58 PM, Bruce Richardson wrote:
> > On Tue, Feb 17, 2026 at 01:50:36PM +0100, Burakov, Anatoly wrote:
> > > On 2/16/2026 5:58 PM, Bruce Richardson wrote:
> > > > On Fri, Feb 13, 2026 at 10:26:12AM +0000, Anatoly Burakov wrote:
> > > > > The macros used were not informative and did not add any value beyond code
> > > > > golf, so remove them and make MAC type checks explicit.
> > > > > 
> > > > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > > > ---
> > > > >    drivers/net/intel/ixgbe/ixgbe_ethdev.h | 12 ------------
> > > > >    drivers/net/intel/ixgbe/ixgbe_flow.c   | 20 +++++++++++++++++---
> > > > >    2 files changed, 17 insertions(+), 15 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> > > > > index 5dbd659941..7dc02a472b 100644
> > > > > --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> > > > > +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> > > > > @@ -137,18 +137,6 @@
> > > > >    #define IXGBE_MAX_FDIR_FILTER_NUM       (1024 * 32)
> > > > >    #define IXGBE_MAX_L2_TN_FILTER_NUM      128
> > > > > -#define MAC_TYPE_FILTER_SUP_EXT(type)    do {\
> > > > > -	if ((type) != ixgbe_mac_82599EB && (type) != ixgbe_mac_X540)\
> > > > > -		return -ENOTSUP;\
> > > > > -} while (0)
> > > > > -
> > > > > -#define MAC_TYPE_FILTER_SUP(type)    do {\
> > > > > -	if ((type) != ixgbe_mac_82599EB && (type) != ixgbe_mac_X540 &&\
> > > > > -		(type) != ixgbe_mac_X550 && (type) != ixgbe_mac_X550EM_x &&\
> > > > > -		(type) != ixgbe_mac_X550EM_a && (type) != ixgbe_mac_E610)\
> > > > > -		return -ENOTSUP;\
> > > > > -} while (0)
> > > > > -
> > > > 
> > > > Ack for removing the former. For the latter, since the list is longer and
> > > > the code is used twice, I'd be tempted to convert to an inline function
> > > > taking in struct hw and returning type bool. WDYT?
> > > > 
> > > 
> > > I don't want to use a macro/inline function just to save on code, it has to
> > > have some semantic meaning. Do you have any suggestions on what it is that
> > > we'd be checking in these cases?
> > > 
> >  From the title of the macro I assumed it was whether mac filters are
> > supported or not? However, if that's not really the case and this is an
> > arbitrary set of MAC types for some particular use case, then yes, agree
> > that it's best to remove the macro completely and inline.
> > 
> 
> My reading of the name of the macros are that they are "filtering supported
> features by mac type" (MAC_TYPE_FILTER), and there are two varieties -
> "supported" and "supported extended" (SUP and SUP_EXT), but with no actual
> semantic meaning.
> 
Ack, then inlining as you suggest seems reasonable.
