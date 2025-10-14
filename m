Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CB7CCD192
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 14:39:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 149234065C;
	Tue, 14 Oct 2025 16:39:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id AA2B7402CE
 for <dev@dpdk.org>; Tue, 14 Oct 2025 16:39:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760452758; x=1791988758;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jtCg8sBfND/gD8JvByQ0MazYa7gIAXhAomCodO+/7/E=;
 b=MuBrIDIfAUrfaBwPwGfSHW1MbszCGe/vrKBTls+TGfWjR4TKam27WPWa
 d6Gafpg2DqLVhG7jWelrUzjFja+vRSojcv+jLQbkGv4fVNl46Vvxb6Isn
 4UTW0+eNrat6c0VUpsbYS0qsI1vxInhSAXQ+FWWstJnQNVkBKjOnYDWlv
 /Qd3VBl89dJBsxvdkHCt8sieOu/PI1wZRa8IAjx6qypfDjLLeHksVH+jv
 dthyfS7ao20UiRMIYYVtI5LwxuWgs+IPuNJwz9x5ab5wGBkzPPR8J5kTi
 1HYT2/M86JCKhd/0X42CxlQz6dCVa9RS5avC0a93aOxfJRzmpEoZ4Tsas Q==;
X-CSE-ConnectionGUID: Ql5V9RZtQhy9G2r9h77Ulg==
X-CSE-MsgGUID: /dkjNWlSSxmjf07CRHPUrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62656807"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="62656807"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:39:17 -0700
X-CSE-ConnectionGUID: 5arqI9KMTcKEzq4bNbPdqQ==
X-CSE-MsgGUID: tYVszB7CSOq3T49jyPpcXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="181453079"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:39:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:39:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 07:39:16 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:39:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxwgLE/nq6RFLyzgqZGr2qGDLicGvF0ieJY2DKjAv4XTloB/PaZXtgth83h7tuHQICmudZzf/YHKkztq0pf5DpYXL+KtIYZ4DlqL79Lr9itqQE7455Ka8lSUkgPqeE4jx8aUi5xuJKVv1oo+j1mnXptbsTMo7cR1SHRozr+4e2lLHEWSpqqaSGKPLcaG7i/6ZeikCP+8K37mqvdvdCZ035qY4RJ0Z7QVEbacdoqabaIwWZQkvpADCRz9MMfUh0/h2QrJMXwoinsqpZu6FrD4eN4LtfKwS2+y3ca1/5IxWg2ArlTu00xoyl5kaoWmneicGozDTyWVjBQlNqgShw9Vlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk3nh4H2BHa1NmcyA+cMyrgfjo57FJJ+AqDDS3XqeXY=;
 b=d9w7FX0Wfrsn8T8YLR0oQmijqn8zXBfHSRXhOpAUNo3mUC0S4MEojI51D+zAHikvyDuKSsY0Lmd7zEJcqqXnKSQc12lxdSZ0oUoUZUZbkYvssc6OLacKg+ugDQ78dp6Llt2QEUjBYuF1QDaEHWjWaJP4gdCkn7ujTUfHDti/JWVcxH8EidOo0MHhnYM2ztGMsrzDpKvjhmBJEMyaSrTak6KaVn2tj04rzRlg5r+9HfGs/5dfJHN8Z7/W5MiG7eMrniC8/WOocjWSK44r+fastKX2h7w1xY/9X3/sK+IpXTmYH4gi+gaxNTyqP1mRyhfIeDhtqNbk1irvechMJxweRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6457.namprd11.prod.outlook.com (2603:10b6:208:3bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 14:39:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 14:39:13 +0000
Date: Tue, 14 Oct 2025 15:39:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 6/6] net/ice: reformat the Rx path infos array
Message-ID: <aO5gjfKL4J_2kY90@bricha3-mobl1.ger.corp.intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
 <20251014084517.1407407-7-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251014084517.1407407-7-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZP191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 95abd47f-3c9b-4899-d02a-08de0b2f71b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hbLkUlcMiwktKCDurNdWEsSKE0WdE8M/HTddgZ43694epQABZihbK0/72MXq?=
 =?us-ascii?Q?AxArf8kcs65nR19UQI2yUyWdeL37aTf+J4MoSrcd0cwDi7iAWAfrdsN6p0aK?=
 =?us-ascii?Q?0ECMmeK1o1QwsCsXGV2jeGH6zacHmvwE+YF2kanzWXi1lUVMoGwfqOlxVwiW?=
 =?us-ascii?Q?J/GMWzAdtyOsax3H5CllkULaLwiDzsnE6IyLoBBzGbJ04ZPLokjeWpm+jNWQ?=
 =?us-ascii?Q?EX/cydHmkUaMRHzEQ11Nz5z+mEfsE8rbRxV+DEiw54HtNQAm5oBSTz8N9bNe?=
 =?us-ascii?Q?R0killgE5WS2ZFXuaMJSxtVVd6x9mBhEz2y0fSJv+h96uoC8oNRhx8NVeach?=
 =?us-ascii?Q?3jUqjjUcC3Xp0pSHZX4XYWCkw8PmNbP1tMvOSt8ED+CCf+ctT2buUck5BGvb?=
 =?us-ascii?Q?Q6FmkaoqFT/K2GTe4SPIFwp3lUrrxx3pF98H8DF1DTjPsVuHXluL84MVnemV?=
 =?us-ascii?Q?g91yoppOO5Dh6gsPf0X/pLU1clmX0tlXOT39JKfXBU2eWj6LeErdUARYtC/x?=
 =?us-ascii?Q?wHCJHNJPTBwQr/ucZkQ2m1KipIzZjhTr2WtYYKDmPcbqLfA12QFJBnPOEJCJ?=
 =?us-ascii?Q?Vo+7amuyICkwHTjWsSAHA7MpmuFJOACRXUiZnGMIyBcIrwG5bGJ5WiUNeU/Z?=
 =?us-ascii?Q?VJ5KKW5dvPCIbc5WHljuu4uzFa+zFpcHzEuI7icSOrAl0ZCuHOoSpR3PcDMC?=
 =?us-ascii?Q?DzSHaJIafCRZk1/0ZWh6/wgx/o0QuaiDPIAo/oJ9tZU8Xmlvo1p20/h+jMVP?=
 =?us-ascii?Q?NbAjf03HY9RgnDQM+nLJMkhQkZyLArVB7/V8oqhdExnm/qp9uUCxvhaj/FIw?=
 =?us-ascii?Q?+6UsDsEhzziNWipyK9fWugeUdl7Q5aznbVxlNmB02Si6Q5L3uP5kOFLudO5v?=
 =?us-ascii?Q?WF97GLy43ze058olAQ5uPmTVfHhUnShF0Kr5JCIE916Nn0XD5iwvB506KEjl?=
 =?us-ascii?Q?oMh0ZzEJC1FspD9Y2EwQZMRMkkylSjYcDDOJqTeUQuUvhnS5wuiHXA9QjaEE?=
 =?us-ascii?Q?8CCITiRvpX7hdNuvWcmwGy+OYqNSp5X816KhjWIq2S+EnkqJBS4NLYIFouzc?=
 =?us-ascii?Q?IXtT47GiSArn0TKTNjIzCAUgw6JDWnMCmbIEteqMGrAtJTX6MesA3wlojRND?=
 =?us-ascii?Q?wFnAkf7+c/h+BYao4eCSlVgExuyLLThjDgVFuDrwhQYrHojtw+aLNO38N/1b?=
 =?us-ascii?Q?DLyXvNc8A6BPWNVWqI8EvIFuUpQGbJMYiYkEjr6whw9LxQYUmpRuLc5Ktwhb?=
 =?us-ascii?Q?IiVUjIKEQcmM4j//aMFcVPxo7p4L8yk0NLs6OX63Llk0a/uu/t9jpmNoIEn4?=
 =?us-ascii?Q?D9JbQ8zPK5A0hHoxpM92Mc9uukT0wAkY9TZNkp5CROfn4fHNIjgD22gSp9a0?=
 =?us-ascii?Q?9IuxHS36wA2la02HJ0WU8cdPHVkd5SxpJBGiWoZ2PbHlVB/rvr1Ej3YArAAQ?=
 =?us-ascii?Q?aEcSJPqF2pIhcyGrpVplQZhuh9+rmqPR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bsgek9yuHeGbgh+f+VyVJ42/5KQkwA+ywwuPsVZQmlqR9KLdia41uPmDoTNt?=
 =?us-ascii?Q?Myg4pGl8iX2LEP1FObH2EcXih/GTz8hg7/TGR3wSUUFihTK0YZfoAVEQpR/y?=
 =?us-ascii?Q?XofY8JkU8go8WrLRkUNza31ynTX4wvRPe1ZSUlyVT1j4FZ5unHa5/EoQwB2J?=
 =?us-ascii?Q?fXNlXVDfaR3a1n6mlk+ydLhfDGSpiJ+TncqCDtIix+ePm0SRJlGfL6rmywBV?=
 =?us-ascii?Q?p786UvTLq1KN3R08UgxtQ8xf1K+eIDKCnudrnh3J7JDve74nG8eXOsYrpbmI?=
 =?us-ascii?Q?DbzJ0ksrogrOQx+hJIuRMmKAmp3aH1JW3CI3goji8qntvvld2fPRIQ0hZtQe?=
 =?us-ascii?Q?xoJUyBWjZvv2UAS9sCzk0L7USMqS+Lhnlrw+6YbdZzaCc2sQ6AOvZd352+CP?=
 =?us-ascii?Q?i1sfvdLmAjZyVdGrUuL/O/fAkQxDj2H7ZeEo6wBuo48o7+y3dXpPFYqvsbX0?=
 =?us-ascii?Q?daM9K84/L8ZPE4Y6G6AySXxjlbt0medb0LmpEikMf9FS/NYkkZ+MPFCriORw?=
 =?us-ascii?Q?DmL7SiVJU5bxmCwYMtMbybd7GVw4dMQf/qTVGDJmK7Td8haxItLBDy1atrU7?=
 =?us-ascii?Q?5pDBwrbls1mMr1CZrNG2EKz/ivk3wuYLcNUo7BiUv7/H8uz9lsnC4qtwWBrG?=
 =?us-ascii?Q?hzKKrQUfjBJP3EYhLzvWUXLaEN9sNKpLp0a99Y1LfrStTTR5w4UuRp0nrm9g?=
 =?us-ascii?Q?E66mXL9Tdk1th2kK1JPj9XU9bnkgBQy0C5k2lKVu5GKWlWKe/5T5+YqTNMpF?=
 =?us-ascii?Q?JDqSyeiQRSPPQtquUL3I450IS+1fYmhA9cIsh0VYoHEk+wwFhHeLaxuR0sA/?=
 =?us-ascii?Q?NLXSAcfDaHc4CVw2BHStQF+kh+vH3cQWsUIj2CESujyN2nAKcPZde8htw9TN?=
 =?us-ascii?Q?kMoKdU29bmebvfyaafno5Zq2vygpSJywxcymRLW2RIdNA0cWfFQbq38B7pQb?=
 =?us-ascii?Q?RAe7E6kKEWd73nfnxZ23UmOfK/D6FgWd0yFDwxiTmK/T124teuX1WtPvDW+Z?=
 =?us-ascii?Q?QpTvZkNiIRCBR6+X/FfVS1lFk4NkKch9P3iOZUz8I6+GjWdDhwlYN18eo8Nd?=
 =?us-ascii?Q?82+V+4QC+2l1QBDRM2IyozXOZ6ILigKzkNbKNcn/rIpg08T4gAlzEmDAj275?=
 =?us-ascii?Q?/zkAsAMSulOPuOKWfd4tIPu1WnLFHqOGhe9NzHmEulAdF3su5ZGscoeLIZIF?=
 =?us-ascii?Q?Qmtr2Un+i1WerAaxko2E8c051cA2u3v87hctghPgxSnSsynkJ+fa0kGjAwYu?=
 =?us-ascii?Q?CCVS+QmDuKAb9YDOhcIZCLnaSijcH2tujVsQfra/tnBfajELfr5NZJ7U/M01?=
 =?us-ascii?Q?khP/Ea+fjN95KE/FpNqplfIJT1W36UIZ7ToXoRkwkyftJ6Ivo/tka+E+Uxsu?=
 =?us-ascii?Q?T5Iq5AOzeo66+Naqz4U7NnCnPwj6VUxfp8ICf4l/jocBteIAX+99lHywIrze?=
 =?us-ascii?Q?DdP8SI09wSbSWb575sZpthjXnXUQgrV/xyuskil5eMdvTYQOEMbGd7P03ZNc?=
 =?us-ascii?Q?hIRBeX3ihs3c7WcUwv0qPulX0VX+zB/TiSN7GfbQg69hpbeUidBUwh17knZm?=
 =?us-ascii?Q?qGPBp2a6FEDtUgvTBG6m8/sJHTvOPFOIEJBUj99GDPdAiSxF202wNkI+RwjU?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95abd47f-3c9b-4899-d02a-08de0b2f71b0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:39:13.4802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOcI9Ljom2O6EIeDhJY36bR/BbfdmTr0VmWZEAaZp8EHdflB/cJBf98U7q2nY37bexs30PprdBuECd64G1bZbCcYgvqBonWvKpI+C699lBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6457
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

On Tue, Oct 14, 2025 at 08:45:17AM +0000, Ciara Loftus wrote:
> In order to improve readability, reformat the rx path infos array.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/ice/ice_rxtx.c | 124 +++++++++++++++++++++++--------
>  1 file changed, 93 insertions(+), 31 deletions(-)

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
