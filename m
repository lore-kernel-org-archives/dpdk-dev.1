Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8EDC982EA
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 07:35:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DF0E40262;
	Wed, 23 Sep 2026 09:35:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 4048D40041
 for <dev@dpdk.org>; Wed, 23 Sep 2026 09:35:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790148912; x=1821684912;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9pY/E5Qt1hJrwt24gixb45C7fx2iVvezByrcqf7qCs0=;
 b=UKQReb++EZzSH3D2gGnYuZfHWEyB0v4Ps5BcL9i3i+ecPLgYpAi/Yyfj
 VGL8qCbgP5CGZ6DddiIdmQ9BSOXNx2NtJLSBO4B5KBLKcuDpaGu9YZ9x1
 ylb4IH4ljVHMmy9LODqQrMK+ldGsugwEIWfV2S7fK8VUYtyOSiZSpzAgd
 FfHt62GF7tSbgj/lpzfCH8Ep3GN91W6bYi3d/ZNyX/N9HDsl5h+AxZILs
 aJUSPTuYknJ1o8aNUV0VtPnJHagowLAPqZKnO1lM0G74k6ADYAzmcXoQ5
 3TZEjgEPjsZUVSDJgZzNX7MRsV7FrCebGA4m6JawyfSrSbXaVeUnKtaF9 Q==;
X-CSE-ConnectionGUID: ikca//bsSlKgAyXTDiLIQw==
X-CSE-MsgGUID: YYWt7t7AQPK1jlNFPrlI0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="116343049"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="116343049"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:35:10 -0700
X-CSE-ConnectionGUID: 0b7cSPsxTHieICoKocU2oA==
X-CSE-MsgGUID: 2GpU88xrTd+BrQ58cjGuJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="299730243"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:35:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 00:35:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 00:35:10 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 00:35:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI3xQwEok78ud+3WQLTfFQtHWaYpzIrF5GEPtxODr9f/6LxzOTeRsgVsjFzu0lwqNubR2zTH9rZrdNQcyNr1MYPgO0+uSh1ztGuOLyUCZJFrE1xV/zlCuAg4l04JPO4zNgQ3m8J7PKnEIjjN7ZZOhs7zFf3x3c3cA2aov5CxQIe8vm45hWlu7Xj6XHeXT5UbqkRtS6qvyOAgfnEATBrii1f14pBqKLfKbj4kqpjMTun43Roiy3+MeJoJ3TtkKtuX3uy+7FbpPDpoHLVQldP0o7rtXUMarSY1LeLi8YZfsBS6KcvJizjnIV/9cDEyAMT4I+wVaFxyN7YZo8FQapi16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udZlNbQBAlnmxZR8irJp/XuAENxJSV0pJGGyQPvdJqg=;
 b=TFpbaS6k/zct4090uJxZQEInNzpGHOwlh78UbvvSNInxcywgOWoShOf5yW3AQRI9wgaFe/X0gNvpQ0eNlBm6l/qRxZHZbOurhffQ5rLsQfVD9U4DvK45qozz0QRJV7IqiDhFDyBdua0NJlyq+cBtJJuoe+RovCyQ3hIzovBY9pls7TWbyj6yFxQzMNAC83lgfjsoOIWC9c7/zhjoM1s5Q0wtH1ihEYRmRYEw33T6ZoiSJfhohLi5Faa/KN1qLyg+aI8TpbpzgwpvvHoFTGgwyyXvyhZEP97g/MNx4+YzgbXfxrUfyBIbCUvRkokcRNjL0X9pYm8aJzau0XNDhMP63Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW4PR11MB8292.namprd11.prod.outlook.com (2603:10b6:303:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 07:35:07 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 07:35:07 +0000
Date: Wed, 23 Sep 2026 08:35:02 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Joshua Washington <joshwash@google.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v3 02/16] net/i40e: use common division round up macro
Message-ID: <arOBJjd_dnv1a5E-@bricha3-mobl1.ger.corp.intel.com>
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
 <20260923010742.2468145-3-joshwash@google.com>
 <arOACkkEd71gFm5u@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <arOACkkEd71gFm5u@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB9PR06CA0010.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::15) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW4PR11MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: dc59ff89-ac4e-445c-5fb5-08df194530d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yBa8t+wlcqxVOJno/Yg6OrICxE0Avt+6wJqQ2UKWdMmA0slwh0p56Mtb51PUzSLo2suO9KAVcukQWj48jYqKauRDNbqwXL/RZS9Mx1l45Gjvo7RuDZvLKQhAP9gAkqWBGne9YF2uzZPz8hbEej1CooWTJd9hFhj+nvr8e2zhkCME4tz3/lFeknfQrK7bG3B4gylySkwPFYxV2synVmKWarZvRrUF9g/moNjPBvBbKUqW1QjrtOvFX0felHdJ+FDFS5YlqJ6GbPXBaV+G62ftZSWRq97P+tBqjowF/0CnZBJ1+ktHXlPzsosMH2c3eGKxroLojQryRxXX58DVxGdqaP4DVoBwyIkhTi8c314HrIWDdZYB+9F+36IV2tpfZ1nRvK5tLDK99IG+Wdqq9rrnpfutE1McXRCAW+++g7XiS2qseTsZanjx8wbw+1nKV6BeYo5b9DF7X9Ccqz921NfG4obCtV656outOp8nD6DeG3JReJlKx+UaVwEa6tZ0YtVLEMEu4w0XxMPVI2j/4pq3+nRc5aXfEYtk3ZADY5biCRy/w1CgtkkI79uMOWLaOS6PXnRT5p6wXIH/kjJjGAdKr9QXpfbduBN8NJXxFZ8RmmK1M3w2s+3JdlMATrDAuhwrzAfi0fQepooEA9NnLsBJD07HuQ7RpbygiHS2PCJdGX0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1KVGhKsM6HtPMcMr/czXrE1/VI4w7njgaOPPO4cLtaGaQrz/1S7U8bxtS9Uc?=
 =?us-ascii?Q?Pyze0yl9Et8sCdTjNhvs0PopxdZ39MB8Ezs+hksJzDILsVkT4a/ybrNxFsyQ?=
 =?us-ascii?Q?pOBwbNlQ1epIWJFtfeDhXpiSaFax/jUr9gpVOKntYL+g/cYcwrgwbq9LkjKM?=
 =?us-ascii?Q?RYO9MD9FbFUkJ1qICvNBb/ef2SecwYtzhl4jXnWcTeHx+U4F08SGUnEXQE6L?=
 =?us-ascii?Q?b2aVLZh5E3HgqimUO9nZ129nZ6Lv216l4UOYG3ENdbshNX1BwONnT4MpmcJ1?=
 =?us-ascii?Q?it1FmWKKByVSqEtGnj1oACjPlcjGgnr/JTx/zpxc6PqkIR900k2v2P04e/30?=
 =?us-ascii?Q?VK4Aby/0bnuc1TBf7TkRHU3+NRb119ph9C86PARjbRBCkPrb3ePILC5bfKSm?=
 =?us-ascii?Q?3DAOe8o2VVwOOvmYXmXTBwO47XxR393z6THD7YxZXRH9f6cFGB18BuKkzhSI?=
 =?us-ascii?Q?y6raNUnmNnZRFUkKMhGwnDbe76kw/UNa6OBDSl9I1yxLqnOnCPlbcgwncip1?=
 =?us-ascii?Q?rtZinBp7uXNaqmbo7pjxDEXIjWbeX19fi2dqXpwsOGitGHxiJ1VJk14keaTv?=
 =?us-ascii?Q?io9KuBXUuEtcLYpNOa3+UooiUeTpRWDHYqzyKTJcld4hR6lRKi+T8saBL9Zi?=
 =?us-ascii?Q?IbjZqy/j4EoyhdorZOs8MnG4ni5PL97hijMvz6/xqKjMhsKunFvIw5pdzY2t?=
 =?us-ascii?Q?89JDb8t3pQTYRuakUMJLE0g9scsRcn3hSIIdiVW0pgNIndKdF+xbkCUqfWJC?=
 =?us-ascii?Q?zCaPlEhzl8LA+ql/MaoreexVS8vw8DV06xtWJpl8Ff1ybr6r67Xf7mEnFYFR?=
 =?us-ascii?Q?GRtJhg2VbLFeEXWC80MIazQlJwj7uizWFQUTh+cj8CwVzE35DZTGzXD+cGXT?=
 =?us-ascii?Q?CNMrIXJsHqiy7wlggYcu82RLBKKWB4dxOAIaB+7SoJnJzaNVaKw5B22Eb8KN?=
 =?us-ascii?Q?CJSW8g50YoxJE10EouDesIRdKXjXa+bKypT3YOqj02XBm6sC3boh7zpunvlu?=
 =?us-ascii?Q?acISnU0uI38/CfodcSR63BHFlo1lo/UO7QmgUkeluNd/K9Mk9AHBm20ytvqI?=
 =?us-ascii?Q?5c9/LNbw76kPkMfKlk5RwW1myIlJT+jcNBCkAeZZgLOKtuXsuwFjiPT8Ibre?=
 =?us-ascii?Q?ZTagOJfGt9hkD5P9QjNasLOuPoogPlTe2FDudmPNQbF8obxshe6SgAzXb9zP?=
 =?us-ascii?Q?iJy9mELZdqFWehN64NL1Hgq+eX6KsTJ+Yr5978JY653mdURe334KA1oot5UO?=
 =?us-ascii?Q?XB0no+nBZmR8gW3iCgmX/rm78PPwSks8r5hLRhV5YeP8KhYFr212KfpiDRmb?=
 =?us-ascii?Q?PN6eHRavbufwWqRhrskF6Nq6XrBcyxhL2VTj85gv9bRP8b9ZSzibnEQlKygW?=
 =?us-ascii?Q?fzCn4RewS1XU9Ark7waAtBXlbNaTEiQWEjhja3pGeaCDDUT6tj5Kx68J5Cju?=
 =?us-ascii?Q?TLdn21+BkKIPxz/BE/2U4a/CMYazncwU8cHy+N/TmKeQ6rDq3dQ/EWaywr6T?=
 =?us-ascii?Q?UxAfo1jZSak9XDag96kklSCTBJONNIGTP7pWA0cl0rGoRj38efYAi48UIdKe?=
 =?us-ascii?Q?40+nB9cMkliDSSuA4tNf+F+tpvyYIxRxiWmlta/sTEdOiu7xhtVVne2qc2VF?=
 =?us-ascii?Q?3Zp3S0EiX0rnCH5395WVLL4aQ52m4Js1lUvWRlSFnZfoft+o7c0vBx7N0ToK?=
 =?us-ascii?Q?7Y8ggfgLus9s/Iw0+2TMoM0sJ5LVD5a5V5MbubwTkPqP2HztE2cbeaccxEhU?=
 =?us-ascii?Q?a4IHA3OQQQnYfs+9u6+nN+ZCNHHSNRw=3D?=
X-Exchange-RoutingPolicyChecked: UBoy2T4ukZb5HlyoWfFM9SLXhL2rUMcx4hDWuoTVRrIhT7xUiTbVh4XZbJzOlG7V3UIw/y9Qkl/EsNIv/wCwVcq85ZtuQqaN917q2GK4024YuRzw2xP9vq3M7Ucx3ngBYzjz8VYZYq1ksWdRGEjJn7fwyC4wqaHCdfARLpFPIweGRCUE3WufmczThl6psImI/eftzfO45iv62D5zkg7Zf2+U22d531vJOs6ID1C11vNwRkzI4KkfziuBID9LPN+hV7XaoO/oouNRbKJTNlkQRDa2MO5/tcQtpWapp+YyD9lJc29YO6NGNKP2A9nBuIbeauh8EEc4NT5lUkkQzb/xUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: dc59ff89-ac4e-445c-5fb5-08df194530d4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:35:07.4667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kw+aXWlMtsea69DQ3wimRTXt8NEMYM3G5Z33PqquG7kbcgXDX4i7zQn8eN6YdddY02oCLeU3luxzcTps7OzlFkXuMLoINMnHcpSLED1GLTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8292
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

On Wed, Sep 23, 2026 at 08:30:18AM +0100, Bruce Richardson wrote:
> On Tue, Sep 22, 2026 at 06:07:25PM -0700, Joshua Washington wrote:
> > The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.
> > 
> > Signed-off-by: Joshua Washington <joshwash@google.com>
> > Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/i40e/base/i40e_osdep.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 

FYI: Just a note for i40e and the other intel drivers: the osdep.h files
have moved in the repo in next-net-intel tree, so this patch will conflict
once those changes are merged to main. Therefore, I'd suggest not merging
this till after the pull, and then adjusting the paths in the patch on
apply for simplicity of merge.

Thanks,
/Bruce

> > diff --git a/drivers/net/intel/i40e/base/i40e_osdep.h b/drivers/net/intel/i40e/base/i40e_osdep.h
> > index 9c5a94f055..93620f5c50 100644
> > --- a/drivers/net/intel/i40e/base/i40e_osdep.h
> > +++ b/drivers/net/intel/i40e/base/i40e_osdep.h
> > @@ -227,12 +227,11 @@ struct i40e_spinlock {
> >  #define i40e_memset(a, b, c, d) memset((a), (b), (c))
> >  #define i40e_memcpy(a, b, c, d) memcpy((a), (b), (c))
> >  
> > -#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
> >  #define DELAY(x) rte_delay_us_sleep(x)
> >  #define i40e_usec_delay(x) DELAY(x)
> >  #define i40e_msec_delay(x) DELAY(1000 * (x))
> >  #define udelay(x) DELAY(x)
> >  #define msleep(x) DELAY(1000*(x))
> > -#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
> > +#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
> >  
> >  #endif /* _I40E_OSDEP_H_ */
> > -- 
> > 2.55.0.1082.g2b9226bbc0-goog
> > 
