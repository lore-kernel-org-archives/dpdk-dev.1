Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCC606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kydiwyQa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4BD24028F;
	Mon,  9 Nov 2026 18:53:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 4A40D40270;
 Mon,  9 Nov 2026 18:53:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794246785; x=1825782785;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2nGH+xuaLT5RpGo2PLWIpqMe2cMQcJagU4l0OEpeI9Y=;
 b=kydiwyQaA+iOpE+RrZvexwluH8VnMCTkv8M6r2mVr+aPynwnvpkCaIaC
 RmmFh6opnHpZzm64Pep4wtnTQHt2zEQMjGlqF81NfrcngmHqpLFcZKUDQ
 rwQSKdL3GN+yg1M9TBvGpv9zj5iNpOR7rIkz5VtllkcbQnDOTTqeDwtqY
 mKU4I1YILekfcdezaSKHfG08whVynuVVuHTZ/iDL/YaLE5ktG2CFy8rme
 U2126tpwNUsrt0RWhzPEY1ZBUTdCXlSLGwUouFoDowTMGX6QpRn9sqL/I
 pE/no2PIpCnWzMwVpcoCLWS6R2XX1XEgBQxQyaqkKoHmH6sJxc+mE7KD5 Q==;
X-CSE-ConnectionGUID: SF4VlUmuRMOw1H3KPkMnTQ==
X-CSE-MsgGUID: dkQgEmA6QYyi7d7VWE+hzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3011836"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3011836"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 09:53:02 -0800
X-CSE-ConnectionGUID: x/MWsZ5eQaGgLqcKOXNcww==
X-CSE-MsgGUID: jcTvPPnNSvmj28TnonchfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9784480"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 09:53:01 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 09:53:00 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 09:53:00 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 09:53:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm06JWzS4nPDs8Sqc1i9eLNA7lvXqO8x0e89Af6a5F+FxQ+jE0mvTUnF4usGlnVxkgdCilOGfTMueGhV7fdz40G/srfTnKNMAEre3XgA2T/tUoHpBGX1DycKT91nZAso9wMilgyFHSjDRg2irU2ga4Wm0NKim8uAZPuA0fHvK/I/CTmT6ojiAiBSbq4GkgSNX7U/wCt38+cp5ms3mzefbY8aqHHeacPrpgU9ePLplnpsBBeVdxDwgL4FG+gpTRr+C7xd8XZ54WsslmTaaZ+FYMDMEX4YPCnEBq2NcfqnfLss622TBtWnkKvsqqETa+ABAt/1OoSX1OyZFTU4czdt3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVE26BgkrnO90pxZsl71QRq6lgsV9vpFaaJkVsQBNFA=;
 b=pb4iCHdshZamFFxXqZP6rKwHMU9temAMRySt6QKOe8gyR7Y8x0a6vSgpdPzT3dbhAje0FzJEAHBdagj77mKj79GWFuu73jz0TC8G63I64EnKCxmrLBLeJPL76qZNhZWlDmb9yN5Bz+yeCKEGTTNM2rkMBSHxVLidS+exXdWduhr8vGEImQTQOiTaHqWfYqw4Qt+5B4fz7Oeoxt1pqIWTdyF6vzOx03BU3jEOohcg/zWDzPOkEVBoYQ62tsIyaIx9TUHFXi7w/+NnVUI4TTEt4Zf4rcSF+jGOHU977cm+ybTkNxhAjEUltqyTuRB8FOKhlxIYLteZWGcsfIeLE40f3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LY0PR11MB909828.namprd11.prod.outlook.com (2603:10b6:404:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 17:52:58 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 17:52:58 +0000
Date: Mon, 9 Nov 2026 17:52:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH 1/2] net/iavf: fix minimum API version log
Message-ID: <avIIdlC0ukTjz5kN@bricha3-mobl1.ger.corp.intel.com>
References: <20261109124524.115656-1-sandeep.penigalapati@intel.com>
 <20261109124524.115656-2-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261109124524.115656-2-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DU2PR04CA0159.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::14) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LY0PR11MB909828:EE_
X-MS-Office365-Filtering-Correlation-Id: a4de9b64-2645-42fa-294d-08df3e8a4a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|10067099003|4143699003|11063799006|261009223027099003|261028144727099003|261102123227099003|56012099006|261022105027099003|261021123027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: mDckQVGnpxmrQ/wePDib4g43KmYmF4PJv52J9i5RC/CjMqUIbxQZfbQx3Bai8CgDq1xl/c2IPQW1dhtnJ+6+gGuNT3dpAMrY2HzVI9vCxP3JTMAj9bjLhX+KNexV9NzSWgSpGyh49iatVXeP7EkwyeId+PrWx9nCOxMseX904nSRHE5BHRbzm+Qnx9WA42nVTKe77NgBPjZahIXDUaRmmb8CBdBnIPHt0c8i8cdUAGCoLDU0z+j1vjnDWr1JYM6BKVGJ1gMPDoZRwYpgrCbOUl8d5KP1j5MgYAfci45pPJvLQ8rpua19Djg2rme5tc2drrVP5a6CXVVa6BAa/jOSNAymgPNZZ5kIPv9zoKcmxZDvKFL81z1PysuLogUM3rKrYjhx2C2Esu2orVY0eLFSuIAD98TrcJi+X8ov28vIvxxCmsuZmhQiqW3zt20t5rorSK5LvU+bcSmc2RCnBBa7bMewDrNXKyj9JepeTe24VvHNsiXsN6iFaUBgxGY7l5XX3fdwVtg7hixuMGxzc9cmuk2doTfQHz3E7YDkmEAfY625GYjlXmZCgWuA1Bs9lkWimZEY9a04ng02XJzmV+TFf+M19tw/9dT89CVBm3r7EG4Zl1Ffr5eW+9bL+LGpfgW/h4RgRT0HRPM39IaHYV/Zq09RcHNuiuzIb/VGnQbGpYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261009223027099003)(261028144727099003)(261102123227099003)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pVuPqmSUrE/lsErBwbhAkOb4YzpjXcI86PHDfMlbRhYxLL7XxrRHqjkOOir1?=
 =?us-ascii?Q?YFcGqCCTLvfY/8ur7ZtMq5zMDf8ezz8xJ+dP1ALfqGmF7oqfJH0rtV6tA1jC?=
 =?us-ascii?Q?r8oxfSErAlhpsszDtxXkEWKNMxk5472Xn/PkZ7fUiCF5uaobXz/PjlbFc/Da?=
 =?us-ascii?Q?zuqS51DhFJwpcoWvTLs0y4CoG2X5fdis55huPdDofRugwnATWyT100qg9cDI?=
 =?us-ascii?Q?14lLxfKygMAcEevWsBpssNpJjXc5VFthPx15Xlh3W4pdCczC3veRT0esUFBY?=
 =?us-ascii?Q?dZQ0HpJh4AKX+c5obtUNq799Es0qB0f0CR8oBpQcgankHos85uACLo6N8gxd?=
 =?us-ascii?Q?tZQsOoPUVNE+QcsvBm38U+CIuHVAjywn7WMyo31Z5IrxkQvqK1hyGc7kyx7G?=
 =?us-ascii?Q?YfykCPym9O1qQRVhH7qj0gDzctBSUQJW5LmQNFJeU5VgKzCuul3Gggub9tkr?=
 =?us-ascii?Q?LnDEfWmzc2lhJi9IZBeDSpVzoCm8sRpOwAwBUrQpDaCE5/2r/0DYRjsV3LMn?=
 =?us-ascii?Q?aherXpHU60OAWtaOpTI0cdRQ+q8eX+DVUyH/UmjKMJtanYoMNKwsdzUiLFis?=
 =?us-ascii?Q?sQI2SZzjcIgu3rzxkz5zAhBHh1MVHySdpjR0LDFEwv/7O1gwq9Vs/MwwXu6Q?=
 =?us-ascii?Q?prYeJMmGiP4vNL20V38Io9YGs6mASNcxMzp9+EKj+OYECKBzKF6icfTGXFiM?=
 =?us-ascii?Q?TFvDls25K04jJvNbK477muiE2ZUp2xai23CwFgsyFxk+8o3ZZTVCIYpMwwAv?=
 =?us-ascii?Q?avE2cp6fMWLlNr0BYh3/V+tNt+NCxxR8G6PBAuFlX0M9+tPaKopjIxdMo4Sw?=
 =?us-ascii?Q?K4fmBfYqxprNTJP5IcR7UZRMcedkJUoEUOY1OwYInHqkVXYVIxcVMEs27Eyj?=
 =?us-ascii?Q?VDep0GV6wuhESXESUcciO/xKmJNOg5uOE6Zb2JITOUSd/dv5zriduxQIvncm?=
 =?us-ascii?Q?Y3+RwrWvT1XLGOhNbBgmY4PDfldblof+C0zz/LLgUHmO/ygUSggvm1erA6pG?=
 =?us-ascii?Q?rdv8+fMNhahixhn+/iqLXHdNpeBO+v6lRf+1ITckITnHjYm6WcezYcrrgj9N?=
 =?us-ascii?Q?xrK84wu1geFN5KFLM4WwfO5ixG6K4haLPzSYkvgC3DtQGZ+TR7pPoU4L42Or?=
 =?us-ascii?Q?N1FojmiAHuKjgtn47k4CWKp7VgHJFlnBufMpsF7KpmiI89Ll6DEgqhvmfDUv?=
 =?us-ascii?Q?chH1DpXW8kC5A6DPCy2KEs0lyhR+zbuTG1afXQY5KOnWcGgzl7VEuxlhTEuP?=
 =?us-ascii?Q?AxgCtORa88r9zfoOFT3gQwQeocF9Y2I2gtRhvER4PfiWaYXWhSrfUiolSkXf?=
 =?us-ascii?Q?6XrdrQADSEHlhEciGUt0cD8KhUZ0G2TBSxV1uj+8a/g7bYU17Vhx25QO60vk?=
 =?us-ascii?Q?XGtUiDfCUI+qegegNjfe7vW3eFfoU7Yy6L9doH7+9eLSzy65gMJah0RLliRB?=
 =?us-ascii?Q?SQqtEPZFTevI6mrdcGxkKBiZE2OoJeP9P0/ME1vmwrEtbPJj8dpu/m1iivnP?=
 =?us-ascii?Q?bGr0cldnDBPNfD4Ty6l1eg+rJMHhVipIvp9u1gVvUj7EPrLgFyLirmxJtCIL?=
 =?us-ascii?Q?t37Zoai25L7EMcKPKIO3c3vvQEmhzRZ5WJf1yNhYDVmfs3wasMT2DCIAjWNe?=
 =?us-ascii?Q?ntWpc/oIc7hNCTjaYFWs55fCS82MATTmZS2DxKjXPZyjpROTv0v/qqTg+Mcf?=
 =?us-ascii?Q?kVW+BJW842YsM4z8Mf3Z5a8+p8kcur3UO1BWoWmVf+LzWTGEpNC2jA59pcby?=
 =?us-ascii?Q?tftWLvzk+A=3D=3D?=
X-Exchange-RoutingPolicyChecked: XuVc06EKpvnbV1ItZ4yroT24HmNlw1cIWIh1vGrvw98Tf8KvdLyIZgWHKGJzTKV1AsgW9tplajxanSO/fWrWe3Yf+T4pxic3NnnSUu2YwDYeG6JU9VFEzpuS9p1jVOy2NYiTpG9KdwGyXDbHufY4uqpyGIrQmyqz5OkeW+AsdTephsbcHi5GYZQqLjBt/rBLzT8M4UoIRtuyQYlZchw9amg7OxKh2d0FNHn4CFJbdrDSUwsf/I0pHhqiI1EpkWbRit3NathTo2epLnldaBXxxbl7uoVlWZlRnQQEsaBfwZAghaVLQSO8vHjUtQlchoXe+mCgTmItOx81h3FTaSiZ6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: a4de9b64-2645-42fa-294d-08df3e8a4a58
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:52:58.4848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJfPkfqbtUmYe0QM3+48mIuUr4TkpyNZ3cuemJPMggEGReh3sNeclBGOXLXRxjNSaXXD1CCMwPn+wi5KEWuWlY5W/CEAxxTwdvehHj8zupg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR11MB909828
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

On Mon, Nov 09, 2026 at 12:45:23PM +0000, Sandeep Penigalapati wrote:
> The error path that rejects a VIRTCHNL API version below the
> minimum supported by Adaptive VF passes
> VIRTCHNL_VERSION_MAJOR_START for both the major and the minor
> format arguments. The logged minimum therefore repeats the
> major number. Pass VIRTCHNL_VERSION_MINOR_START as the minor
> version.
> 
> Fixes: 22b123a36d07 ("net/avf: initialize PMD")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
