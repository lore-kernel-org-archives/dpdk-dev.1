Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8EACCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 17:56:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B430F402EE;
	Thu,  6 Nov 2025 18:56:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id D369E4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 18:56:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762451818; x=1793987818;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=AlWtYrjvneb5Vx9SD2Tg81OQas75fDjzJ5b8F2GB5Zc=;
 b=e35F9XYQut1g6DzcpDieh/AZQBHWQpIrzY0qRN8c1ja8FrB8laesgGnK
 U29gqpkrwG3k3w8GX4vFR7ZMK+zxIuEAWiDYTCEv7+RyNq+1H3iRG5ouM
 ZnslB50dqw/2TL0fGMnh6f+z6VxFh0VFJejsSWvQ+Ndqziv+rkQmgSeFr
 F7kPKgqt9Xe1cb6mjXWIbteh+hhslulnq5lFrFQDrCYJqYi/kNftqCvo7
 qiudLTXwuAnODRMXHs56wFTVMTG3GU/O9uhhRz8oMOTadb4jPxnPalBEz
 mpmfGkR80ax5HuY7E5fzMVp0Dto4C/UnKjXDrRQjsax7bNfpocIXqaNxz w==;
X-CSE-ConnectionGUID: BsVuZouTShGCIxCbuWy5IQ==
X-CSE-MsgGUID: gjR51qEhRDSkMldbgLOYfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64482281"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="64482281"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 09:56:56 -0800
X-CSE-ConnectionGUID: pXOid9hESVaRHw3wzk70Pw==
X-CSE-MsgGUID: 0DhjOSUITSWIcW/yhdZpbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="225069226"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 09:56:55 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 09:56:55 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 09:56:55 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 09:56:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srW8J4sEcAwqVR45t+oRuGK+pNhA8Eo/lRWmkIOuJI9eTVN2w//Ca/VD35Lo/xNEco9nJDq8w/x4b7fIrJ0kzV7J5eZtuXIajHfuu8SGE7QQYkWAUaYGZJr3BJ+/koiRosoZTtUBgTm9LX32XKMmqL5jyjn+9EuZ+xY4mXcH2wuZ6eSi4q5ScdoD6yI+YCCYsI6OoUN/sZ6doXkcqQzblVyqp2BCXxGs6ALFR7vJ8eELaDNEJErNLxEh5jdaXSnZBBoAprSm2WipwIFM7dz30JWO5X5zPULWDVr5fWPDteayEoMbx4qTA+l8Jlzdy5HIa1qwT09FDHZo/aUdA3Sftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmYfeiEEE098oALA9fAk6/jYl3/kwrGLsKdOKcr+/tI=;
 b=Bx0bEtfjpXrtYPrwvTGUi2n3bRTdnMj6qUeNiVtJlvrU5Wsa1liAInAtJ0Pn72boQRmDDn/IZtHbbV39x/fBtnRXNDTCpiJMKMdhsZVwCBniIwltiTqf4rglJ7QuE0z7cKyjDEvV/F20CQPYAn0m6kAzHpsgMN56gpOqdWdtOddeJtqwBjdw3u9HL1RaVTcviAhBvNgLmZ5hlC0OtnwX1lfo5fyAkkRj/QF2f1jvxK8EKJtWLW2A6HhwkYLSdi0LDuVM7BBdkKlTLjnVFkH4nLa4exQAcC8izvJr7g+9sDXOpb9FtjLl7gy0cmim7caKEfPUcLUHAcg/ZlfgxfmKgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 17:56:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 17:56:47 +0000
Date: Thu, 6 Nov 2025 17:56:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: adjust RSS LUT settings
Message-ID: <aQzhWqsmWqXNaYlu@bricha3-mobl1.ger.corp.intel.com>
References: <20251106171736.163516-1-vladimir.medvedkin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106171736.163516-1-vladimir.medvedkin@intel.com>
X-ClientProxiedBy: DU2P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f43959-d40c-442d-0117-08de1d5ddacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J0ShdcSAOt8mkjabbhmVJHOvkgO6fry0bso8g0MTCKl/UOIq0nFkM6iSVDnR?=
 =?us-ascii?Q?WBMKK/A9TVj/hnbfIhiW5HFIYNS379IiN6hm+LhZWrByfQ8zzonEErICwEgl?=
 =?us-ascii?Q?M9pFGLxQfppJbtgWJ8hQ3My6DLM5ZpQdO8IsCnxhuwl3CUf2hRwJbZ/sOBB3?=
 =?us-ascii?Q?sTdUCyy+MhK2jxJJf+Lgn+X5QLzTRW3bz3MAoTlOao3cy0+77VuRTki1EgcS?=
 =?us-ascii?Q?yWeTcJt5IWfLHMGubbVP0WcEjNiJ2DoNoc8KNAvOxEbSzdyIHaOqE0JA19Yl?=
 =?us-ascii?Q?al6QE/Qj2NiyvCAqCOVVAu/e6Z7IVjurDFoV6IMQv7Klp+J0JfgubNGjWPhr?=
 =?us-ascii?Q?GDD+QixYRkDN0YpqWO7tCgizOBSWAYKfcC9osT6mBglGYptzVx0bQufD5fkh?=
 =?us-ascii?Q?tIYfSeDm2tEzfesko2FRy3BiMBbJtCtQk7h023dolevf1sJlYwiPXGS6ke73?=
 =?us-ascii?Q?cqDgPaMXVfBKQgbaPP4aFwmQiCPC3JEk33f/8sQQpa2z8YMbCHdV6Gc0DMde?=
 =?us-ascii?Q?4ifcnEcgrpE7T+ROqjm0ndkOuVTP4WoTpdUURCzDYmJACEjh3/aL6G+l0R0U?=
 =?us-ascii?Q?9TvQSQ/oPIZblX3DyhfBnkpb1Q8Et6rXN+N2ZzKKJ0+ioq5B4AVYQeKE7swp?=
 =?us-ascii?Q?TzemXfYt6PL7P7Icer2ycXz5y2uQT1w/RhidQijT25MBgWgEo6t6yhgnNd8P?=
 =?us-ascii?Q?/zqOUDn9Z2ZdhY1okghxxdioD4bsGYstvLsstsIbZwSvA4RrMKnuLQfm+l4I?=
 =?us-ascii?Q?73Of7F/I9LwpWjNCJmmFe8S96vFUaTpLh8OI5kT/408odtgRplXsdu4X4lbf?=
 =?us-ascii?Q?77fvWtwjetm9sH1FuENUhYAbRzMlVXU9Lac2lT4ndqxoN2pJ/d5LcC9SWRrf?=
 =?us-ascii?Q?YapsAwWEsbT/IVAXpQUlMEJJ4C2IvUUIDAhMzWYVp5AXtVonWnogZIo5+lhm?=
 =?us-ascii?Q?lUaQdrYSNByRSCso8pyFoIMj78ERRJlSPHfvpMkHzcK62zjuSihZtyCDJQ4B?=
 =?us-ascii?Q?Fj0IlQ9I7xIutau4mOsO5DzzDHDX93Mojf1t5pxYWY2ISTzV82nQEA/5+oli?=
 =?us-ascii?Q?kdCejNNrztU4Me7Qfkg5k/Fix1MMddtKMFkcBj4ACowwn4HI7vkaYU181LsZ?=
 =?us-ascii?Q?fxEYQoyKW1oyJn9prP6nNwLUJgILNRMA4GrSjjS3G9jLiS/orP4fhWF8TuNC?=
 =?us-ascii?Q?E5lTQNeliOdNhO0jSVEMuNtcKYOg9TJ3iZmDYp2xWXddo2lm9tLjUshtJXV4?=
 =?us-ascii?Q?cUic1fg/bjH/uKwL50MyAm3MahKOI7hE0QbxNy5YUK7RcL7hSNRbrK+QRATA?=
 =?us-ascii?Q?jIpPmsNe5AxhSs1p4d8haBzcJjyMa2acQTNQDafSO2rj7hTVDonu9rkx/YjQ?=
 =?us-ascii?Q?23xOzLL4ZPQDOqQ2Abw+zx/paPBnta5JL/2Jglx2sA+xU6Beqnbvl4mG+S2A?=
 =?us-ascii?Q?fdz3kQ9SJTryqsLsR7hEH1S0fp1jT+t9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2qkWChdbhi5qQsy2JtRGwUvDoIspdIpORSpTyiGFeuNA9YVSSdy/sVdEUTkP?=
 =?us-ascii?Q?w3l7udfPpldw4gy0Usw/RZFOclkgeSv376uPeS+buakCbjkmgQ3tHtURgUw1?=
 =?us-ascii?Q?a0ZdVzfcBfIGKkIRtB2CkFx5Vh0choQV2tVes15XDJxZIpjErEIZjyN+N5fX?=
 =?us-ascii?Q?+mL0hyQUPUmgZNBH/0Xlex624GiZ9Q8HIg4isxUttrcRDdzow/HrSLB/3a/F?=
 =?us-ascii?Q?R5THHu64DN7ojdGEIbVicYjuWiWPD+nSTsSwXLHZ0keMwJCPYXQI2ATTdpwC?=
 =?us-ascii?Q?9JdZ41xZ0T39GrQtBuWEGTm5uyPWs8cKTz/rF5PkAop5cc6wKUSljM1NOZY7?=
 =?us-ascii?Q?SUGupg/app8rpz0Sh3TkdNoRoTLo+8xSJ4JOK769ksvKK7gIXS0w1JjP+LGb?=
 =?us-ascii?Q?jtqFJLiOwdPW7SDHuG5fKC4sh3I+2hBXaW7GVfGsxQK2saLaKKcSRte1csaX?=
 =?us-ascii?Q?vanlF0+jxYOoFs6kryH086LXt39lrRKlMlx3KaIy8E9kGzRRUmLmMQ9awH1r?=
 =?us-ascii?Q?0nwHUMzijSiQ+YtGj/Pr14itnwegOEzVEXIxOioUKb8AucgO7qUU4Cif1nnF?=
 =?us-ascii?Q?FmMxzQY0yU9IFWLEQXXn0kovIL2w0/wvCP8xXhjJfjxW9SYFjMsrH9nxdXvH?=
 =?us-ascii?Q?6WuLPB3P1UGmpijSiMOpPA3gT9n65zp9FyuwoHPjoHsLCkwJbBm50iQ2YviL?=
 =?us-ascii?Q?xcqxuUFI6IQPg+XZRolEx2dx4x6XqW0PWUm6LxHnAmEJDWzzhgCwstFTJJUe?=
 =?us-ascii?Q?zkXCW2+b89KVaM3MojSC+VMRf+GMgTaffPM1KoQ70ZCEaPqn88bqrPMY7T8v?=
 =?us-ascii?Q?hsZjrwtZy+3tDlrdDVygMzL0vTSo3wyr2m9whPI37a6S+6CyVFQ0fTc7YvsL?=
 =?us-ascii?Q?Hf79bswnBX0SsQtVAhacjyK71KHycdQ1EsF2ZfVIXdn3S9+stPea9azVdhkw?=
 =?us-ascii?Q?d+Cvk1hHF7HYrmtSD/NJczFy2pteNQw57mbmeW0IYTOkzYbYBZDxkSMqouUb?=
 =?us-ascii?Q?TJM9L5dBVHeecdclcNTQ7IDmSDpIF2MfIjlAJBagdsZoaf+PRtvlOd8U2kQO?=
 =?us-ascii?Q?y6k+g2xwkrXt54hw3N82im4boqYM6SNq7lovXn6lZQiknL2lC+nPZZSOgTc8?=
 =?us-ascii?Q?dmIh6PaM1/CTyTSMjJUGKrCAJu42/IaougebQZpH0CHjRY+IVh3uzN9bpDP6?=
 =?us-ascii?Q?Mqe+V1kMdHYiOWjJfOVGcl70Z9KQeLuqlgrNbmrKCc3go9ibX2JnzFOltSAx?=
 =?us-ascii?Q?ZvUi6vvo3tTjMoKIH8njysXUuEAwqvCTVpPmguqsozoFIteVfnFaNuBAOlux?=
 =?us-ascii?Q?zch47kCrXIxRRbSQVWY6FBfpmlT5gTjex6WTkKKqC5qGf0Xo1pDGfPCoiHR4?=
 =?us-ascii?Q?51k2MdIiyITU9CXOd77MNUZ+xlasrsdbuu7bISw5YuqfSYLb5MC8688Rf4Ie?=
 =?us-ascii?Q?SFLOF9VhNliBo+h7hD18PdcnmFBCBUY4yKxTHLpvkde3zwK2jcxqKh8CKTP+?=
 =?us-ascii?Q?Vh92b73/ljGkyz244QKHzMzcxnNHTqwS9vxyVDGln0AgHX6HHjtRS/QXOEdq?=
 =?us-ascii?Q?gr1hb1bW/xq24vjKQs0zYxm32uG4YsUJBtvRMFrTst8v19Lr+Ux/GkT1jQez?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f43959-d40c-442d-0117-08de1d5ddacc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:56:47.6099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+5bPw5E0vYhUZd8QpUP2Tzapaq6nBCdJDeSxbfgZwL9ZQYZaQudxOiZMeq1nAT7LClwfuL/lZV5Op4FRrYZ4+0IMvZUghWOxdQ/ZS0oOI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6462
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

On Thu, Nov 06, 2025 at 05:17:36PM +0000, Vladimir Medvedkin wrote:
> For E830 using global RSS LUT for PFs with a small number of
> queues shows better performance than using per-PF RSS LUT. This patch
> adds a condition to use global RSS LUT instead of PF LUT if number of
> queues is less than 64.
> 
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 42 ++++++++++++++++++++++++++++--
>  drivers/net/intel/ice/ice_ethdev.h |  2 ++
>  2 files changed, 42 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
