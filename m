Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A12CD2F33E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 16:29:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E187D40657;
	Tue, 13 Jan 2026 17:29:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 72819402D8;
 Tue, 13 Jan 2026 17:29:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768321790; x=1799857790;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Co1xOwKIORxNPJC7MvYSTa/uM9e3YSsxb4hEYhGKySo=;
 b=F6cSyU+jd1+qosy/XVEyh9Pc5n7u2REmCDblsOttOC/XLBeQ+OX8+KLc
 YOn4ywCOcjt0IzmWLgC3kzzQgP621Ma2FRdGbF5npcx4ti2Fthp7q8Y1w
 1VLRpw30Fx3o+/Rv+ysmNYCYREetPiA0IhuAgdLW7RNegH46ngf97B/V8
 Dn4DO96MwDp2j/R1fpP1yOElgT4/kLGLnQ2IeAGm2skj//AuCqzM7fNB+
 /PAvntLp0F4bRqX1oRHlKSIdmCeJu9xY9xTrfF0J5OD9/F/1rEx7rhoBo
 TOu/XhG/vJV3ph7HM8B3iwsS2F7S5gxzb/tbdLRC8WZguhMu8+vrLXIL2 Q==;
X-CSE-ConnectionGUID: ffdMIDqCSwOI/PygHqi48Q==
X-CSE-MsgGUID: T640eJqnTAqioeCh94gufA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="73467430"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="73467430"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 08:29:45 -0800
X-CSE-ConnectionGUID: Z+3yqpLBTuydF/Dw27ohfQ==
X-CSE-MsgGUID: ubLfDnnaRyCgtZDMDVjbxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="204315318"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 08:29:44 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 08:29:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 08:29:43 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 08:29:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qN6lDSazlOPnPbDaD4Ls2XjxuuqMIrTXkANseCqJKSkw+pvSPu2Dvxps+/CbIfpcUYukyBt6TEylojQJvMWuWZOFkC9z4uVltnv/twPCOfrCCkIBC4fKg+BqyIugyL7vWhzgNTi/sBg3l+SQOraUSVLn4BQZm2fc49AHjmMnychBRNreRZ4GKvua958qEDuxK3m+N2VmvfZ0Mjp0AvSrTUnrIRgMhBHpBLmh2wk2/Dl0ySZ/LdJ2WMfPPfsfRoRMsUtSQEKrSL+njfqleD9IJoBxO62yq9oC9RehGAGZSOiWLFKk2j4GHZpldzLvpEnbGw/dvWN7bDW8xsoy7mfJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXLi9hD4nFil98bw+0H9vXqFzgWbyTvjnUaiCItN/jc=;
 b=DOvpvHz+L0xjy8X3Eg3cS6Ir03jMk+qMeelsFMb4ZvXYqxar6nZ8Wv+np8vwHI4sgFfJLJqiwIopyT5K1UrPU1gk84o+uTnrwXFKDRK+m6oXTXLeSRT2bDihNdPXhkqh7HVEdLqVi1o437dPpaqo5rn4vZnd8te0+psfQnTl0nX3PG+lqEB46zwu4lCxCmty86iTvSyTV5tNxfwsjcFuiNbTgMyKTIDL08hJqFxgeMmO2mG8ri5xfxG1gTH+CnvxSmMJyggR53pZFfT8VRzhi1LsbZ3hsK2pZ3cRoRIu5WFhhvt5O3b2Q6Xang/ulbXmAV6hN9u4toTib13rv92h7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Tue, 13 Jan
 2026 16:29:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Tue, 13 Jan 2026
 16:29:41 +0000
Date: Tue, 13 Jan 2026 16:29:36 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Beilei
 Xing" <beilei.xing@intel.com>, Ting Xu <ting.xu@intel.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH dpdk] iavf: fix reported max TX and RX queues in ethdev
 info
Message-ID: <aWZy8KoVNj_owN1B@bricha3-mobl1.ger.corp.intel.com>
References: <20260109142129.1550058-2-rjarry@redhat.com>
 <aWEP8FqWsDVvwzK6@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aWEP8FqWsDVvwzK6@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0294.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: c423a038-a39b-4ef7-0939-08de52c0f3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tDjo3vTxVoZa8ZKDEBOZ35k8gJ820P7i5ZuXi4DaOP9KR4dM6OmqIqzR1+YQ?=
 =?us-ascii?Q?mwflItiFeEkz3Cnj5o5tsF8VnHHRe3w6mDsRgdegScGI/HdAQAwxyIAF7SEy?=
 =?us-ascii?Q?SYw1/o7c0IBzSWQEafGVwSBy5r0fsAt7z+tgRDcXq3I6ptS5t3OoiEdE88lR?=
 =?us-ascii?Q?R7fontUYLCHha331hmtrCcbZTm3S2jDdmD+/qw0Kc/JTQFWDSGqsMRQqcQpi?=
 =?us-ascii?Q?UfgPfsXa/t7B0zAZiVJO9Zo1e+8uTRETFTXFKR/DVgQhU6u+QRfzVaOAMCCY?=
 =?us-ascii?Q?pFCJBtmEsikuLb+3mje0/YCy9AVIn7z1T2kGEAsA7s5mq0e42MmSL2+rDRsN?=
 =?us-ascii?Q?cIto+eEl86CZmv8HVGm3w3fOOPm5LN0l1A79jtrxrQm3jWcwiOyWOOiiBk46?=
 =?us-ascii?Q?1Tly8+uwgOWnY/vHf0folKn5Lj4I8GsZ4t8FOsszmbcqR8s+MD9Q17sW1fb4?=
 =?us-ascii?Q?Gozfyp7IbITcmiFHiKSaOVvYD4lD0eryLQ45bnImIBuIibeOqREIZfGpqKhD?=
 =?us-ascii?Q?VGXXUpZBj+clsLv5jI4xiT8aBWzHyiQ2Kj7AlZHjZZ1eyENPIWYyn0oGAUpv?=
 =?us-ascii?Q?SU66F3YCtXn/IB82vR8u7g21WFwcuuiLwbwZzXcAFVEzQqFe+YSmREZgLoQQ?=
 =?us-ascii?Q?iCb3ZeMsAc+nUgsGufmrfD7UfSbNq5cTT0ampWWmeygeOaWxDQ6Pbiw7WkXZ?=
 =?us-ascii?Q?SpOyeOJUyKPUSzKg8uF5s9wyTG1C2yP2tMkAhErBbYK+xL8NEtMJGpuPufex?=
 =?us-ascii?Q?WefS027gGUhSqZ60kzCbz0cMi/lgoXm0LPOspbXUG6J2/4wbszskS6461jKf?=
 =?us-ascii?Q?nvYim9Uy3IDkg6p+WQJ/9yKjCPxI5afByKQ18gkiMMxH7iOA/jZ1DLPoYI5s?=
 =?us-ascii?Q?gsgiaVP0gRn50UiMvXCTnDx7Y+vYm6fpVOWyVYMqSi2v9LhK3LnSRTWrCiSA?=
 =?us-ascii?Q?9Q/4gG2fNhnVLE8gXFzAYgFSEu4wifFBkA2Oyja9vCPV0Hb+WQArFU5zKp0P?=
 =?us-ascii?Q?HGfP2Pt7ac3w7mV6bLgOX4letiKwdQn9pC7vHUKNgODyE3u1xpPuuBW0NpHI?=
 =?us-ascii?Q?5MpmU3G+eSHnL7rlrwKEnjHj3OkOGoTBb8PjeAsY7rCwzlI/F5WxZ5aMYpeT?=
 =?us-ascii?Q?IYHNtYHMT29k9jSCv0aV1DgoEzJZVMlL0FKbbA4K7xDGI72CWaVtEhS4q0+i?=
 =?us-ascii?Q?0xq2K8A+jBgBk5h/M0WzJx+IjsN9HphRNh9I6oA5Vs11oPAfd0KQ1IU/jGYG?=
 =?us-ascii?Q?YBFskZeV/NnZBIOu9+7q5krQTPsY5qsWpiUDmijyWvkYKmbuLPAyIr3xyZ/W?=
 =?us-ascii?Q?/Vt+XB5Zq5mnwBWfrzDae2metlIotCWnoQljuVoQVC0OgMrOudAFAYZCuX9m?=
 =?us-ascii?Q?e84HrxW3aqE2ExBZ0H/V9kNw87xj7Kz1VzXTolQ9uuw5MuaisWf8vLWrsAr8?=
 =?us-ascii?Q?CrAr/bfHCIcMh8TMaWR0xslfDLEGsT0V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oYRrBurtIWSU9iZY9pXMYB3Y7fMYoVk9Grxn+Yc0i+NdIczP00u6YRQPke3o?=
 =?us-ascii?Q?03MeMeusHLX7Szaqcj5d8sv9NENbszGoUCxAVZ9L7OkGD0zQAMAqnPW13mvv?=
 =?us-ascii?Q?bOWldlCgKVC6a4niq9u9hov3cZYyHO72AXqVLGdOP9YAETWKHFpQMYORRHSV?=
 =?us-ascii?Q?K+lmFNo6TFnKKyq5BsKZ3nCJCpybPw6TdwTER7QjCoYkkkGCZysYIVF6J9qj?=
 =?us-ascii?Q?KdTXlKen3ZSMt78jZYs9jdiXHvItf2zFyZePwnd0ABOe3Snqlqo6iD9k8efN?=
 =?us-ascii?Q?nN1pIKqVMitSKNwyY2dmGi1Cj/V7VkRHcYtmppwBKPPc3PXEjVCaneJp7INC?=
 =?us-ascii?Q?oVDSXfkNtTnSEVsIdjlIuFn/oCNMcna/D1AAjJniuTGyitvGx5NnX7dX5mi/?=
 =?us-ascii?Q?Lzx47hvFIaTBLF66xtvnScVpWzEoPHfNQLJ61PQgXwxAEVENNb2rdvwYxDIx?=
 =?us-ascii?Q?5NNzr9xSSviH7UF9sZy5FzGN5yVLblxZylUlBZ5wMQpDWGJ3h3hYrXK+wM2a?=
 =?us-ascii?Q?cdls9f1bd2bvK7ZYXk+ASxQ+/1/+nVOISKB8vjyJrNJxHrrZBdffbAWulgI0?=
 =?us-ascii?Q?HvvnuVBISYbAQhUxoqJOyUe+QFujxct9vpSnZ1B0oOPTElxcFg2d31vaIkLM?=
 =?us-ascii?Q?HWr8kX3Zs/9wkagSqRUIav1b2TTFb/25GPiDRs8LzPbr1qnphUs5a2c/bCxF?=
 =?us-ascii?Q?hi+qMPO3FMJFrsxsJgfMQ031vFGWyit2hYM3YrjwKRJo/am0nKSCvI/eEngp?=
 =?us-ascii?Q?qcd8ND6WlyZHnKc3WoV7xmrdt6Bx8ex/P+OqNSxcN44RHtKC68YvH8ln/ur0?=
 =?us-ascii?Q?0z32FgP12FiOMgRw6Tan6+KG/kJnP4+rNTTQP0iaBZ5ltgbGi0JDtBSjvB6b?=
 =?us-ascii?Q?VfL6Ci6cRFrcmsmJEr29gfQSvTyvah1/mvtq6ddMmUI3OqQu2AfjXNlMK7/X?=
 =?us-ascii?Q?iH7YJLziJKdwX3mPRFNhI0/tz2GSISDlSWiu+PRr4IfdWpgeBoTyNL9vsxqh?=
 =?us-ascii?Q?DkUVdYNHieSL2hlzpaU92FfHlFtYVdG/fYLJ/H5HLStr4umEQcMeerYcbZOn?=
 =?us-ascii?Q?MLNK69RGRmicS9jWyeUCzcqU4UEsTzvkNUIYizA4p/kXh4jExb88Zlyuj6oS?=
 =?us-ascii?Q?LoHZek+wVziMMV1TEcnZiqSKWVIL9+CctFW+U7wts0LHna4JMCvYwMiT9fZf?=
 =?us-ascii?Q?Z1smO356tdpV+YY1rUyrGCHE5gbs5G0Y/q3KCr5zj+bBicuSVlVs0WZRgo1E?=
 =?us-ascii?Q?EmyTWmdS/Yi/ZFVOkiddyfdkCn9KXQmfG7lpjC2McSZ0gbWUWScuyzV4H10u?=
 =?us-ascii?Q?lwPIsBG9iyGEu2RnjdCWAF5dFnhWMyXM/2urV53U+LaaGmhrxZi8tsy0KmQl?=
 =?us-ascii?Q?QgwQOocl50CR5HDGnDnJCpG5kjd0yuKRfpZGMkkPq466b9YX/5yLw2pysSn9?=
 =?us-ascii?Q?O8en/vRGIA0ju81el/Yvc+qEUbYChKfm9cpguYqX+k+CxUqQereALfrJ2W+r?=
 =?us-ascii?Q?kGlc4jlZUUKH/IEZZjePOkemrK8CIvFjkzgkevrMP5BRXC4ODkB3Or5F3j9u?=
 =?us-ascii?Q?n1Cv2JV3sv/+uIl+S8K7p0x4HxIcLyoNL929eNimwjhSrXVx/7PMKOEM1AFy?=
 =?us-ascii?Q?9fjDT8GwMIQrNL71xTx9qwEWzsZXPPJGg7ShdmrQSMBWtmNSlLYJE/nMqo2J?=
 =?us-ascii?Q?x69dZ4baWWBJo4CrNg2Fmu9++lu+LILDQK05QrWN8OEhS9g6hj+gZ0oDL/Lr?=
 =?us-ascii?Q?oc606DRwMIblcNFLlokdLnE9rFiCRrM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c423a038-a39b-4ef7-0939-08de52c0f3e1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 16:29:41.4673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyPZkUsrZa2kpG1kf7e/kU5UApvVZUyzxPMWtKRLFKLs2RbIf4wO4EsseUKNCy18LiJiSR9Djp9cclCXxHxn88i9yjJvPB3u7nf8QX4lAmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
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

On Fri, Jan 09, 2026 at 02:25:52PM +0000, Bruce Richardson wrote:
> On Fri, Jan 09, 2026 at 03:21:30PM +0100, Robin Jarry wrote:
> > With a regular iavf device, rte_eth_dev_info_get reports 256 maximum TX
> > and RX queues. Trying to configure a port with 20 queues returns an
> > error:
> > 
> >   ERR: IAVF_DRIVER: iavf_dev_configure(): large VF is not supported
> > 
> > When the large VF feature isn't supported by the PF kernel driver,
> > ethdev info must not report 256 supported queues but 16.
> > 
> > Fixes: e436cd43835b ("net/iavf: negotiate large VF and request more queues")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Robin Jarry <rjarry@redhat.com>
> > ---
> >  drivers/net/intel/iavf/iavf_ethdev.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> > index 15e49fe24814..59328ebc5ad2 100644
> > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > @@ -1126,12 +1126,18 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
> >  	struct iavf_adapter *adapter =
> >  		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> >  	struct iavf_info *vf = &adapter->vf;
> > +	uint16_t max_queue_pairs;
> >  
> >  	if (adapter->closed)
> >  		return -EIO;
> >  
> > -	dev_info->max_rx_queues = IAVF_MAX_NUM_QUEUES_LV;
> > -	dev_info->max_tx_queues = IAVF_MAX_NUM_QUEUES_LV;
> > +	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_LARGE_NUM_QPAIRS)
> > +		max_queue_pairs = IAVF_MAX_NUM_QUEUES_LV;
> > +	else
> > +		max_queue_pairs = IAVF_MAX_NUM_QUEUES_DFLT;
> > +
> > +	dev_info->max_rx_queues = max_queue_pairs;
> > +	dev_info->max_tx_queues = max_queue_pairs;
> >  	dev_info->min_rx_bufsize = IAVF_BUF_SIZE_MIN;
> >  	dev_info->max_rx_pktlen = IAVF_FRAME_SIZE_MAX;
> >  	dev_info->max_mtu = dev_info->max_rx_pktlen - IAVF_ETH_OVERHEAD;
> > -- 
> Makes sense.
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to dpdk-next-net-intel.

/Bruce
