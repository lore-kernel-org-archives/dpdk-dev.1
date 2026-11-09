Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56947606A331
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LzcWf7TI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 281ED406B6;
	Mon,  9 Nov 2026 19:08:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 157824028F;
 Mon,  9 Nov 2026 19:08:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794247697; x=1825783697;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xGCYpMSgG82FhxpSnUK+prr8BMNeqMSPzGXU812Na3M=;
 b=LzcWf7TIkRaJVy16ruXtFhonLWJMQ68ggAi8OZ/s74sFrEyiAP2viKXX
 3caS5vQqW5a0QpDUOMjR7oCH0Y8JuPnqpU/Q9l6/5WFp9aZbfKa/X5tlU
 xEH+wxF9t4OMDnLk0MgzAY1WJCbAkzYmkPgB39sXgOcpcszC4Ka7jgaVi
 t/gxaGZRxREralVomh1QNYRRH3Lpo53hKRJ5Pe2MRK6SGc8dvcSa56sj4
 hv2Za3zEDz+RgifBNgnE5ozAIp8SXyUr4gs08Egsh2FYCeGN2hNKuL4pZ
 vkL477KzJkh1RMInQMW+DNw6rxUiQlIVsu5rplxgYKY7K8jcnaLAGsKVu w==;
X-CSE-ConnectionGUID: 2ojdzS8SRViBtgpx5Mu3Xw==
X-CSE-MsgGUID: pQOzo/4LRx+AGsGeQ+ltzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3020119"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3020119"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 10:08:15 -0800
X-CSE-ConnectionGUID: ndaW2Dp3SVuSA8L0vDiWMw==
X-CSE-MsgGUID: 0iYYkVSaQ4yRqta748zebg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8358219"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 10:08:15 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 10:08:15 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 10:08:15 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 10:08:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkUROrqdfdOzsW0kRj0nYnC1Pj0aOjCM/e1/+9xPl2WFz1sZuj9iTRv3nDivX7UBAZbEuK9gJNKR+BOj5GehIlZ2ODERlFBXLwtx/aFrqv3iKVlBHR/l755hgMXMcWL93RrVdIuKXkv7wbCTgv2ICh2mGjBad9yGQ/ddUc9jIVlt00UNYrEedRV1s0g4SPGH6qHvOjo8WAeRCpJM4gM8OiLYJa3XusXN2+Wh7Y3s35Zkqyn8JJ/mmP33F7xmkRBpjoxRcBL6AFCBj2n0ABJJVCrOjDEVDuwBYqY0d8tMkWRmeZJtFCimNCgLSsCxbSmJyXvNBTrfSTU8aOoR92rbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m5BUANcxLx0ayBg+eLqEwElQn2/JjqFSlA0aAhmtQM=;
 b=Cb1/ji3d5ZBEA2I9wIA3IvQ4jZgryJfiHTcYbp5U2GHZl121M6UMJSTA1rYrvqaoske2U+ROzGXjSNbilyf2JsrGoLHTI1gyYHlZNHDfwwfwO89J3g9LUPosaTv8m+VuqqvQKaGnBna1rd6h+/ZCsRLF/tlhPjyY+NlPJXd+BFguDPaHp7ghbUesE6il9i7wL4OTNAZYMiWTQjgwUbWXbiUCQny1/6VUK90Uzil94zjhziaoweFkJduT0c5XVUPx6jFHuyZpBHl3EkBvAQXSKMV9ztCU1JWLYCjdMNn+fshz+op1qpv/6m+ObfNMlNz1nDqA/hQeMS2uuHmo6eqktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by FT1PR11MB755572.namprd11.prod.outlook.com (2603:10b6:170:c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 18:08:12 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 18:08:12 +0000
Date: Mon, 9 Nov 2026 18:08:08 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix ACL entry limit on devices with 8 ports
Message-ID: <avIMCO7OsfV1Yu9d@bricha3-mobl1.ger.corp.intel.com>
References: <20261109153245.53360-1-ciara.loftus@intel.com>
 <avIK7iqm2W0hr2h9@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <avIK7iqm2W0hr2h9@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU6P191CA0032.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::19) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|FT1PR11MB755572:EE_
X-MS-Office365-Filtering-Correlation-Id: 1651ad4f-8e9a-447e-1c52-08df3e8c6b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|6133799003|10067099003|4143699003|11063799006|261102123227099003|261028144727099003|261022105027099003|56012099006|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: HVX+34nVl4NnX+p6+vNC8si0Fli3krAGZC9HZLMpGiEwS6yFRaGmkmXjVd/H5ghS7Z4Uhv2D1NmQ0rPMf5lymqZE7QnGR3SB0JpqpXyy2nmEwxHZC7/PV6+/JDw0aaB3+miIuQGr/UBNIKGNeO5uQ/jNDlGdPgoY1e2FBmOM5G0Ax/KkOWg088IEvsEVH9u+/T9yJyWJ/Xtklpf498ZSNW/KhrzX7lnAQ3O1kmMVf9Bc3mS8dKwsep+LREgggpLZ+5+c2+n2O/ly8nqHgsb08iNYLVny3kFLYJbJrJ5MqyZDr0iKLzTsatiNhRks8h6FM45gpaTVRj67Xq4BaP6aYIL2PvUt6iEm0tTT3TbUixkIdXViRf4v7d7M8lVmOdBAe8StS7Vht7wBdH9RdhU2jt9ElJN2U0JErn1igf4CEmgzCL1Vdd30bjK/t8H0wAryqbl8b0sZPlIY75TrYGpKlA8CmBzwa2WKQKx8n6J+6Cvk29aDiIDjob3N1tSKr3eNpOccGraCfEeLJDBGlkWz2tm3Vob47mX1dp/OBBu/t+KuXjBqB6tEh20ypb5qat0x2CKJHYMH8VNfMTeFlwwtKhF5OHR6YoQc/EL1YDihI7HXe4X1k161QjNax1wXoLxf2qgxpNfxihtT4gmwRqC3mNhzy89U690/XngajgW8Sb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9W2hH7jWRXqpJK357DdHqFA5jAN2BbSQFK4FaI87zz9DZT7zCnZ+Rs4G8erP?=
 =?us-ascii?Q?JHrKOv/BmbftD/lT80ybJL6p2Uhz4oyBSxwxn591r/7Hk3RiJrHPPC0qfbHS?=
 =?us-ascii?Q?EZMsKlD8P2vT40X5hVXIBqzCPcyXZh6cucihs21jbrbVweqSnvCUvpQoJgnz?=
 =?us-ascii?Q?1r50GDj73Sqr0wcbzr/rB6LMoKNyDuLTy0bQFSvlLhgkYO1RsiWA5fu12Lsj?=
 =?us-ascii?Q?4DxgkpNNKuCJg6sybE5NBf9y053HyKRP8CUlBMXkhnE7Ky1INpYmFy+DhYJp?=
 =?us-ascii?Q?VGg3YzyTPNukiuqH3n2QldPfk33rNBEKQWh2SsayQmRimJJrm7eYFmwQLU4g?=
 =?us-ascii?Q?iUxj84wz+TEQir2jpRhtNdCnCtSfze3Iqsp/kn5ooawhOTXBOFfFsJE1jvpd?=
 =?us-ascii?Q?wcBPQgKmy53VHisLz5PzGnHRjgLvBjzG+Ivd2ouah6t4GtQ225MEjWqtOfWS?=
 =?us-ascii?Q?Wn209SQf8LtlQsa5x3C2yLF977w//W3jR5oH54uX4J9wKPDb8xJ20QWlp3L9?=
 =?us-ascii?Q?6xW4yuzo5V2MeshJUWbor2VIKOcCypnxVoVQ4NCnH4Dh3NXNAC0pdZkCRn5f?=
 =?us-ascii?Q?1ICA/Rn44Cfnf60YfyWT5pcx7qdbkBYqXRdzFkBpKoy2Zg+wkwDuObip+uzl?=
 =?us-ascii?Q?8bpj4mFavxdUG++LH/jPvcG4TbeK/ewry/pXx+eWjvBzGZAHUkgItMVKwjkb?=
 =?us-ascii?Q?Ae4hT/Omvn3+1yRGAKjD8T1ytcLotSY+N5vueGi3xvrQsYCaQrowhfw5qSQ8?=
 =?us-ascii?Q?R8+uYRv718UkIIEFL5R9lAVDaRVIqZjAHX38apWoN3WkcOwKpl03Pc7oAKh1?=
 =?us-ascii?Q?xSPANDOXuzVw6YYU6/QBq98wcS0SAAL/M+DKkwscqhwPFOVVkCXvUZn6taf1?=
 =?us-ascii?Q?3wHEAr7rJtjP8P4cu5wDiZDNxevDQQaOfuqHMfidWV/Vb2JAQFh9WioNV2RN?=
 =?us-ascii?Q?MaZD+v84ce/oFKExk/kWYF0a8oBy3kfOyvO93kDBVpr9H4nSOyDujdQc0mkI?=
 =?us-ascii?Q?lezBAPaGeRaF546ZGW9jNLjHxOj9X4MrBR8rlKrhbBnFoUrJ34RFaBP7VT1X?=
 =?us-ascii?Q?m8epWg1Xc6/FFnJkKlQ0Oghh6EosEeXFIWShMcqJ3eM6DtYEknl/Ovf8d3gh?=
 =?us-ascii?Q?KIAx2B5vJkLQMbk2mog/oPn+l6l2LCf4ZxIqae4Ii/cltbpuxk/kK3zw7Cfd?=
 =?us-ascii?Q?oq3wguy9U+dWx4w0VKQrFFSL12bzkv4Z8+5SWv0f/c15Np6uoygYj+9t+x1W?=
 =?us-ascii?Q?2YX6aOtI35+L+bKoEU9v9KYFVUOgMa3/odKqAF4ffbliF/njMgRCvONR7j+y?=
 =?us-ascii?Q?LgNWb2xxI6M2h4hS3jFUBB9yWGWKb4RCAGOB8kVSbLaCfi44L0i4c6BYrn8I?=
 =?us-ascii?Q?P41e4gmS5lVGCprQDrzfWv9wUdW+60m1V0jcx1qfOuOKNlcp/SexVvDmiA8T?=
 =?us-ascii?Q?ItEyYQyg2c9IrtezbiLSDmexnMz7Xa2BtvqwjQOQLHN7DxKRzxqq2Kv95LYR?=
 =?us-ascii?Q?xPmjXW+LhFnBUHlbb17xEEajoCt05aEBcqXxWwogRPwyq2rhAuJkZXb7dA73?=
 =?us-ascii?Q?U/f5RUizVqXD7AjvTMWp+EeqtC6Zm4SlFFVv7shYquSSNqz9a6TvTaDz/xYU?=
 =?us-ascii?Q?IJwrd3XoL46l974AjeJqkXYiHIq2/4zAouPnbbtTxXdaQYGRMlgCYrPL3Ltz?=
 =?us-ascii?Q?6ahgi+hpoFzAN+Mb/p/VlTdlwIUF86ArqxRhOX9rF3+epYE0VpXCY6ii8REf?=
 =?us-ascii?Q?+SuO6Yyvow=3D=3D?=
X-Exchange-RoutingPolicyChecked: SCAlsussnUMQI3OCaNLbkvqC4jxUuQddkV1dJp+sG9VbxRwgPeIHBA5KNO5BFjB1zLzFe08veIyFsa8v5XgfV4jx+b9HR26pndM19MCz7C2hwtbvh6OyVRS7YgOH9yHRAJYaVsDgUGhNVZ1ClJkrF7i6Ipo1oqvNa1UeFBlypPjF4udvwWB2s41H+9SuNvpzH9LP4xKtnpl4aTOn2MSVanEeSiRuE9baEG2jxIZeCKvt8PVqktFSEn1qEh9eesc3YpdUaveon5sj8OT6AE2exay2gHQHGADNPRex1DEr9ICCfX/mjMklFiN1TfQsePDOZbZV3ZFpcgFLJ/UTRkloBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1651ad4f-8e9a-447e-1c52-08df3e8c6b1f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:08:12.4351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zP48Xkv1WjWDvDW4oJwl/tUg01yHvK1zgCQPZeCJYoLR3T7PIrxEunalgYQAr7pT/2jpBOQznY9PVJ5P2HmE17Jb5HjMMuluG6d9SHWrz5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR11MB755572
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 06:03:26PM +0000, Bruce Richardson wrote:
> On Mon, Nov 09, 2026 at 03:32:45PM +0000, Ciara Loftus wrote:
> > Currently, the ACL table depth is halved on devices with more than 4
> > PFs, but the driver still assumes 256 entries are available. The base
> > code reserves only 50% of the scenario for the NORMAL priority band,
> > so on an 8-port device adding the 129th rule fails and the flow silently
> > falls back to the switch engine.
> > 
> > Fix it by deriving the entry limit from the configured depth so the
> > driver rejects rules beyond the NORMAL band with an explicit error.
> > 
> > Fixes: 17a8fc206178 ("net/ice: fix initialization with 8 ports")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  drivers/net/intel/ice/ice_acl_filter.c | 9 ++++++---
> >  drivers/net/intel/ice/ice_ethdev.h     | 1 +
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel
Thanks,
/Bruce
