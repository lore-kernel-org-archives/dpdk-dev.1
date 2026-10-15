Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76897CC6B39
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 17:29:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74657402DF;
	Thu, 15 Oct 2026 19:29:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id A845B4027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 19:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792085369; x=1823621369;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DO+P8feodMCxr5NC6P06t+IJcWVOU37h5aN5C+S7MMw=;
 b=nRiBwZHE4lSctXg5uwGLWSvebOxBRSbEwPkNPcMutjqs0Iala6YG63Hd
 1ybuYBOMCgHbOmOt0qd5JOzgSdWOYszeS2AKe5TAvZKD2NtjUcsjLRMPo
 xo+KdlqU83jhLBSO6nc91cb1T/Gb0TZshmZnrMPiPhEI0dX+DYO8uydbA
 lbg8zacmiRUFEDeFxhs+79nLi5tt5eJSf6GwBcQ+Bt8slsabYZ/rdfni1
 Zv1DVXHLLaxRJn2ayfIMSxuKbh4NguBiN6ouUvVVSrUwr3SBkngnY1Hkl
 y0fw6uEQnrmDCMEfgO4k5eLU5BlFd5JStAzM0/EvSJ7VmXnmX7BLaRrv2 A==;
X-CSE-ConnectionGUID: S540X2seSaKPRrAhdLnEig==
X-CSE-MsgGUID: sYmcVnV3TfyDkX6PPuMnbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="967809"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="967809"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 10:29:27 -0700
X-CSE-ConnectionGUID: gRiCEtgXQtGrmJz1H63p8g==
X-CSE-MsgGUID: +vAwIBH4QI2K8BK8V31ckA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1663900"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 10:29:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 10:29:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 10:29:27 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 10:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciz6S2xRo+t+5H1mHpY31Xcg1HKcsnrfOyr7tqJM1othqLcMqcdMx+6bXfDZCy5dRlzyd5XbH473qEJ+snlT6RnA5fARtCcActqvTdCfn7S/tY6rr/uG0lKPHOlxow4/YhVo7s44RHPFX86zMicOL02/IE7w3VBIbO+TE3GWERsIBeTZTt+0iSwCR+q/Etz0oemApzR23EehMwiYNyIBSTPJfO42H4lLCvP54JbRslNLZ/fAchExo3T22q6P3tU/2H2eezazi2bf0pvCC/ZHT5V7CpZ1Y5XAS57FxA5BKJ0s+Qyjk4mOWo7GjcE5C+12LvAhToXt4HYq3rLfXGrAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sg3uxuL0nc7rW+wXdU6+pE52mIopessu2Cya3cgoTg4=;
 b=T1IoNKQRFATsRj1Wc7jq+GWNF3eMmPO+SrI/wpmJgGF0K+sJ73VikAg+3WSbwQQMrH3OWEuJRyqw5ZF43NTDF1ig/wgq5S6EZ4U+tSQSocnZXijMl59JREeCvzRgt7y1va6koIlx/fKs6xiA5Q9K/7E80d+vwioEZ1P6NPO6kf75+0ZUpHugSgkUyaKxdhmS8MoNhWtfRO7E+qKPYDptCXGNtOtp1DUY6v3e6KfK9/i22ZXnsrwqLiEHUkDsNI46ixap+h5r2JB4WkShRig0/g4HlKYicS+8Ps9NXNUvy3+bs2FQYEWA3M4q0Eg1ytLx9BqzLl7LbKG5vUU0Ephybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW5PR11MB5860.namprd11.prod.outlook.com (2603:10b6:303:19f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 17:27:42 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 17:27:42 +0000
Date: Thu, 15 Oct 2026 18:27:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v1 1/1] net/iavf: remove dead code
Message-ID: <atENCiK1eHgP9MF5@bricha3-mobl1.ger.corp.intel.com>
References: <000a4926363e5be631db4f8209bed02d11369912.1792075372.git.anatoly.burakov@intel.com>
 <8128e56e-6e70-476d-871f-bf6849055f7f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8128e56e-6e70-476d-871f-bf6849055f7f@intel.com>
X-ClientProxiedBy: DUZPR01CA0070.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::9) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW5PR11MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: c27ab1e3-d6f7-4f12-121a-08df2ae19e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|261009223027099003|11063799006|4143699003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: fw6kKeq4bRT+TTIQyYOYaGt6MsRcJaIAY5qTJ3Uv4k+o+wN1/AodenqxsshFoNRajPjUFh0XKmp22P883DLO43BFr1FlqgimzlpAD9VRnV4iXeqbOinJeQ7L7Qf7gWznngkR0O0ZABT8jf+DCDdsc2lWXBIKlflc7WFigKi95LqlQZyCaOuw7wKUwCGFi0Ei594up5L188xc1xYa/G0NrfWu1/AAJ78Dci077bne0fEOah3VN3IaFtUdtAFG+wXZpjWJ/MAQ6pgSdBXsct2BxGXNMdFNoVteViUlQ2sHM9IOdLRed1V5wkO6z+coV57s6CtGO4AF9od8HJMu3X5s2RnBFhDl3WOqkFrO1HWgA6vXe3+vty+XAb2NI7ovPfIlnCu1AJkFNcEckdgePWBARH7HRP5Wwatb80wkpUlxBCVZwNkPbQ9H+3VdnbrH729T+uMckiFJugt8yoZWKAr0VW2dDZQw/0x4A5VQJ558QyVmhq73LDWBFJj8ylDvs9zuR9BHAmAE+gNAgdIj+Vl5IF9gB/XU0HjurN1TFuzBZPd0uSywzOWOG2yBz85zV2zMAoYnxux5U13U7QTCCrIIrHjIsqgFDrMqIN20cTDmFyeVZwxxUulbN0daYm0tfOyjWWs3QSEHqCITXvkKXA367BxJki320QoQogmS+R1w6wA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(261009223027099003)(11063799006)(4143699003)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IIu19F6k0zLHcmrzhJvRNsIun2I1eIX7HgG/tQXPJKo6fJxojVGuIRGk0Q7S?=
 =?us-ascii?Q?37HE7vtQcl2Hrun8OXtDAj6jniFVXRExzRakvZQ9udOdjbOB411oxkohgZZo?=
 =?us-ascii?Q?wpuXr8sUJkWJK0ge3LrfQKBtnADjEsFAmhw9LR5ZBO+fRlQiSz0UEZ7/KJAT?=
 =?us-ascii?Q?nTMB+n3WsLk2O2X4D11VizJKeRjeeB8IRZiYKAIDOxR8hrQR0YwmbCP7+Cgf?=
 =?us-ascii?Q?Du+EPDBWrCg7WyNsNGQxYkDBDeuPcYzXZEhpcGf4kFw/gL3lap3oTIdz7UU5?=
 =?us-ascii?Q?acBTEL8EPLUu8PkbSQ1A5zXEF9HCD+6OlVJ25fl4drjzbyMJRnRUb4P8YvC0?=
 =?us-ascii?Q?TnSXjmSOPg0Abi7EC33fzJkkMQbaJabBC1pZuA7NTJneKQBxOOko7m0VajB/?=
 =?us-ascii?Q?4Xug2EWExcSmigN8Q+EWny/JC+Ww2Ztm2PipKiAiiaslI+zd7YO9B/oOnmhr?=
 =?us-ascii?Q?1ZYBwHvkbdQgwi3kjK+Nv2W6E/Ud5vewq7dMXfeIK7M9ygNFnXRlNluuMZh3?=
 =?us-ascii?Q?k4JDk3uZhUrFZced63+hSfbjNamDVuS8IgtETW+rU9tbPCjdeoa6lKbh8IOs?=
 =?us-ascii?Q?vw7WnrBjdAQ+xaT8fGWompxxttyxiP8v+PXL73BcPWmy31g3i+ZkgxpM1bgs?=
 =?us-ascii?Q?4ZpsIwG3HA3iHjIfY4agOVT71NxEfW64Rv9jnyhtsH9dQFHE4+AfN8Nc8a4z?=
 =?us-ascii?Q?Ox4jFVhmQxKAaYC8ZNxG9vClHWwxi4hOJIXisllhugtzK2Aq3mR4lhfkDbI4?=
 =?us-ascii?Q?Da0wA7pvfA2WqcLl8nTH9UIlrYw/FLVZsAXrcWBlZ61fCIIAMtEv4ekeZhOU?=
 =?us-ascii?Q?KRlGQZYdJW0np/0tKzwljryBrAbzPjQNPK8ntR7IVbI+NF9tZ24bIdIWLhn4?=
 =?us-ascii?Q?7p6tVbmciTcBRYSKVfrYgsgaw5/io6+WRPrw38+fu5YV3BvT3rdWVOgVL5b4?=
 =?us-ascii?Q?Di3IOMcUCpjH7qz+v2epQY2L9Ud1sgPPK/co5/o589QnD5yCgznDHlOCn8GI?=
 =?us-ascii?Q?ZdRcfZjPXPmijj5ImJIaQWOeUieWDbYYF7HM9So/yyVqXF6bG5KKbcvgpEAl?=
 =?us-ascii?Q?dn01wyrPgkUsIEUJTIcEcwdgzdftsSwdCwMwfndeNzDC6TMQ2r6fEfLBVmfD?=
 =?us-ascii?Q?H59p8bfbCnRp2KMQp3ma+PfffjqO3ue/c/1LDPuwVOPrN7pDxQ6WZA/4a85u?=
 =?us-ascii?Q?cmlSU4sjGsa6iSSIvC1RzPtVggke91D1ELX3fkAU90k5iu5dkuRnsDVhwria?=
 =?us-ascii?Q?FAQbv1h9qMu37PQLSrRmx5eTkjo/cyViu2l8f+Zn8FmN10J/EIBSI3OLa0Y1?=
 =?us-ascii?Q?Yrcz8D8JxYdlg1qcfX8GuOc8EcyOqGWmZ1EcguUelk9/IQnnT/aD5RPmbgrU?=
 =?us-ascii?Q?YokTyBiXCpp1SjgRgrdDl72j+TMDwUWndqFxFmusZQgzue4wUT8TRPHcE3+H?=
 =?us-ascii?Q?wE0pUHgTkk1wp3b8T7Flfv54GimNWTBQ6SadMUdr4RUTqMWclRxfTaOYy0/1?=
 =?us-ascii?Q?No7zmTyj9enxCAGdnrAYF9H7b3IT9szY1Bd9bxIrVVVEXv2aeJaao8PBEnjP?=
 =?us-ascii?Q?tPCKXdjwlbgzJwZ8JVMIp/uBhz2RtOkiB22QSvZvvDf28sj17WqeWxKhrJaT?=
 =?us-ascii?Q?9BLMjACIj9J7H3l+wvPd9nF45WZewrb1aeiSNwc+7t2Lq1SMFsfOAMgVfFWU?=
 =?us-ascii?Q?CN+CzbLvMWT2Xq6HUnb7j12jLVmBZ72uHY+V7qdFkY8M83HQk/n07XG4E5oF?=
 =?us-ascii?Q?S3S46baqR/tjRD/K7SNCqBRYGXqE94I=3D?=
X-Exchange-RoutingPolicyChecked: qG/V4/3AlqgRY744cbsXbE+zsGo6NYOcsH1MGgaR2vZaxnLoHMcAGeapYCnG7Rxx+6wveutmiB622T/x6gMYAH+TAkrdNeQBXNCexYIKNMX/TV+guHg8UW3Vnih8KBxRwh7MHFNIsMRYRclGgvIvIN3z1Vya18dMY0Bc0WQ8MQPPPznmMeZZ8jSOE2d4ddyBC5WI1++VDrR1+t1HXg7rBDm0iZ+ow9sLiT4RuyDuH3aM4GsvJNiHkSIjLVPrgqVbam5ANlaluccS3xvaYJYoU5lOQpx0XE2AEJLDcJK/6TVXwI27hBbZ/J1FeaqlCeDgb2v9C5kegdfkmkKkK/Zecg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c27ab1e3-d6f7-4f12-121a-08df2ae19e38
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:27:42.2752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfiGVOId6Z4u+MTMk3aTh3UkR9l0i2/EItRsiO7JkPuWnv+kgh5CBGk6PDoMTSxIbLEWWojP0CuppqaaSBpAVvZ3udZKoAG8Cn7A/NcJzMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5860
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

On Thu, Oct 15, 2026 at 03:56:33PM +0100, Medvedkin, Vladimir wrote:
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> 
> On 10/15/2026 3:42 PM, Anatoly Burakov wrote:
> > When configuring Rx queue interrupts, there is dead code in one of the
> > banches. Remove it.
> > 
> > Suggested-by: David Marchand <david.marchand@redhat.com>
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> >   drivers/net/intel/iavf/iavf_ethdev.c | 4 ----
> >   1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> > index 6abdabfb94..937b1fdad3 100644
> > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > @@ -901,10 +901,6 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
> >   				       (0 << IAVF_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
> >   				       IAVF_VFINT_DYN_CTLN1_WB_ON_ITR_MASK |
> >   				       (2UL << IAVF_VFINT_DYN_CTLN1_INTERVAL_SHIFT));
> > -			/* debug - check for success! the return value
> > -			 * should be 2, offset is 0x2800
> > -			 */
> > -			/* IAVF_READ_REG(hw, IAVF_VFINT_ITRN1(0, 0)); */
> >   		} else {
> >   			/* If no WB_ON_ITR offload flags, need to set
> >   			 * interrupt for descriptor write back.
> 
Patch applied to dpdk-next-net-intel
Thanks,
/Bruce
