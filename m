Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2D1606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CAenm7Q5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69A1E40288;
	Fri, 30 Oct 2026 15:58:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTPS id D34BD40285
 for <dev@dpdk.org>; Fri, 30 Oct 2026 15:58:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793372332; x=1824908332;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zSPX3XXhUQE9vR3Nk+6L3T5HvpkNsSTSp6IejRqM538=;
 b=CAenm7Q5uD1yslsLLT9mC07QFCS0e2lrOpV0jHu4S1q14ZeFsD0rJqkG
 ebWbSHbeDSnEEPiw404U8nBNVWfUiIHe/zQ20XQs1fuOofL2ZIhg7U5Z+
 4m9RFRJLiDmqZ6TqWyjcxdczddxC2C3SVSxt3BoMTrLx+Gdr+nE/7Vzrg
 IW2qrqMPJwqNTp+atQdhKVATlEV5KrvyL5OVa4DVP5B5q9tQuoN6CNUgr
 LXCJN28nqUKilipaWbfCo3odgbs/ghZxEmYYQOvSqj6qXV+f7vqxknu2D
 92pQ4smuZF+Tc+6zo54tfXchTdSiwHHqC2iCngSzE+PZtMXolv146dyMO w==;
X-CSE-ConnectionGUID: vmVhvHkSTDy8H2DkYra2bA==
X-CSE-MsgGUID: wdFgI/VtTSGdzIk1w9Yecw==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2152266"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2152266"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 07:58:50 -0700
X-CSE-ConnectionGUID: vVGojlPfTLGZUOJ4vYhFFA==
X-CSE-MsgGUID: raqO0sDrR/eYUmHyvAeu1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5422791"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 07:58:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 07:58:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 07:58:49 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 07:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bhw6bFrkrfgENdj/THtYgeYm+eYjJkDnam1MiA2fUpubbAX30JxRznkCGoIn2cFv2u3znTUid0zCiCPRPyvaR+ywazWH6N43rKuE1rNXXhmVN5L4M5s63RDeZH18Hy05oVCyzunmphpZ+8QJQCmf2YhxWibJ6PVpUpOazjvGSjPtogYjzHxhcvh1WLCtnd5le072rQ4yanl3+N2XHmclK0ksFQjBhIqbT9WveD6jlBBBTaYWLoTdAoWeWxPSSSgfTBghfhxE05OLaLqsFmOWEzYVGxmFm9SVClOj05+yw/yx7zc1K/VU4MfU4nZjrFMJldXMFxYwjC4HbftF9P1ToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIsWPkkxxeELTXd8OFCxRRU1LXsVZCgLAonW2qKVVVk=;
 b=oKYmqNgX7uBr7qx5owASyMqBm9IUh7xM8VNWanVRKEbIWyK6EGzLBM/LMyUxaANWFNsQSKQ3A9A32lng6d03Mp5d3S5lacR6x9LxPnUxj3yGm27GZ2vcuVD9j9sxe04f+nq+2TldsMXYZS9Plj3OfAv7xjt18f9g7/WgZG5/4sLk01JLmBonZ8mYGow+GZggZYQrOdh/SomZRlCYi4lsug517BMHHhWb3ol8sthrVPdwFn5PtyVYhl/KOOTtKVeynlPGvR257A8rB4DMid4ctQldDdw8dZDTgdWmNdR02Kh3AmMKWmeJV5FmkT2XKL2AX9C/aODIiJvWPJXHnLaHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA3PR11MB7554.namprd11.prod.outlook.com (2603:10b6:806:315::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 14:58:44 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Fri, 30 Oct 2026
 14:58:44 +0000
Date: Fri, 30 Oct 2026 14:58:39 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v1 1/4] net/ixgbe: fix FDIR reconfiguration after port
 start
Message-ID: <auSwn45aaTvlCCnw@bricha3-mobl1.ger.corp.intel.com>
References: <9c545ac681db1bd835a88516322c1441951e3ed6.1793292050.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9c545ac681db1bd835a88516322c1441951e3ed6.1793292050.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB9PR02CA0020.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::25) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA3PR11MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: f7dfcfa4-d3f9-473e-e9a8-08df36964ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|6133799003|56012099006|11063799006|261022075727099003|10067099003|261028144727099003|261021121427099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: W2PbtboNWcVhjO/rMC7DnGGLU6dotQWEBY1/5Iu6js9Wtn86ugv40Q4czt4R5NvdcskawE4NZ6mrXL58JH1Da5cTVwzKQYPsBcWxQ99TlL+Urkcjl31Ok2kOPfTTMbGSkT8OUpm/vz1cFO5W60Ts8JPbz/gtzSl7cYo8Vf15EuElUQQ0XEuZGhTqhf5iH0IMKYmJ2XvV5yEqoFIJ0c8I/fqLma64nU8OcD2TCGnk5rhN21V6Il/wr0eXtLgaj/NW+YtAtVym9m6cf8ePHTJCwFXKIg2j7rF+vT3B2syU+5ha/tETbZ0tkgCMd1iQq2DeZ1rn/RgPe2WyTCjcyFwy9mC9cEDuk4Djh6bejDtGCS0Zr7gOGTYLXvx/AL8c9eHhy2piWVyIvi73xqbvqqdgjCtluqL36VbvagUWSOz7uADn47svrf8hnWg5zGgEAStX3N3paKjAGXTYU0hFkMc6Hh4Rjeiy98noDIBy1dZOQL0hA0POREeARGetfpWWQdlQbst57o/XrxHxKExNt3A3Sw0Y16HTnKKLQOpsg3Mbxxs/+fTfJeZLWYvrUKOPN/ZXfAHpXM7p0cfCstro9AfbEE/qguzl1xwcZizX+QwYQU2CsdE7hc3FoJR4CfN53r+J4/XyWANPeEKZ7bpQjMFTb9izeh+yDqgCrWx6dTnf5qU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(261022075727099003)(10067099003)(261028144727099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FZSCBdS20BzQOp/uuwqsEilo8Zk36pmdcx+a6uU7fbrWySYE7LXgMgC63pB4?=
 =?us-ascii?Q?iJtFgBz+6Y0x4xBvelrzurKWNE3EyHkkQjM6jjk3fxJlPS55qY1cZVQsekIi?=
 =?us-ascii?Q?LL+s9x/UjxUJdNne8YI/qbXnSBeMbrTfsm9HqKgzVs6OdKncrTn2X5/Yk0WF?=
 =?us-ascii?Q?ZDQJn/xKTJ4Bw2xQkRSX2IrfrHtoocemraFHkmfEWAO9UJvId76/jFf5UVbf?=
 =?us-ascii?Q?q7TZsUYVByHyCPYA3JZw/3fhEuXQ71Hw1Hqlf2m6U9GYCM/TpaZpvIdmb53D?=
 =?us-ascii?Q?huQyUa++fa8KIK3O4W1RQgeP0qNK57U0cPLi5SLymdXAAppfHRdErqHY9Mfp?=
 =?us-ascii?Q?xgvu9TeEbcIoPT3RTBrDVU8we5t20wWsN6etpBHh8m+OJvqr8Fnh8k51XUGG?=
 =?us-ascii?Q?U0jHT84W4DwMHhHhYwkzXjzLDymxk5RbkpS41cJ6Jry+clIvHaf27Jg9/I88?=
 =?us-ascii?Q?ow8ruL/szmLYWtdi5OlsqM7kYTGz0uzosOMJYDNC+0qTTPPS7/e+MNb7ofDb?=
 =?us-ascii?Q?u9sodhD78sINJGX6uPUMSLfNAyIrcWY5SID3AeIKcADU1FQvcLqSu4EGA2hl?=
 =?us-ascii?Q?YYQKF+DgaOSr1j218uRSJ04f6JEO4/oI5WCe36gZo2Y8zKUJPOh+wLFF9PQt?=
 =?us-ascii?Q?/iZQYV6K2DflD5CBQnjcLX5Ux8EdneUexAebmyshycj7RK02AdNw84hfFyBI?=
 =?us-ascii?Q?mu7KrNiyKNkNa4bAmyfVopgZhAsEJ/DuKL3UwsJmwr5+sGF6GyOfpmrV/qeB?=
 =?us-ascii?Q?zJU6SiNAF7+80uisUczpvZ6Ot6DkyXAculAQtFiTFwgz17VgwYPRD/ZREhrX?=
 =?us-ascii?Q?/VC/u5vrMv0BE6XuC+PxiTtpfBQ5IJ66cYHr2A8gKMn/jjYQTCZvr1yC6MQ/?=
 =?us-ascii?Q?urTotc3hKkzJ1KyJziil3CjRFDjKffTP9ERMuWSTXkCHH6aPB4G2YUUNTVvm?=
 =?us-ascii?Q?Jb1wJe85SDDRcdjfETI68sIxoc1Uq6a294RqndhIROdTpqnd2HAkLfjDcEtX?=
 =?us-ascii?Q?EOy34OV+nlPvl0ZbVaajypfWW9uqILcyboGTX7pe3Pi0HUD3GkluiFoDo4v2?=
 =?us-ascii?Q?CBRviQ4TTvVKC6yQ14TRxcNQ2jbxclyCDMe6MRLBTOs/qEVclPlY3GLvgmuw?=
 =?us-ascii?Q?JtBB6S78ViXSWV5M3pGReieItO03ThYTTrWGX/VXn6IcPMPoSe5D83IVMj0W?=
 =?us-ascii?Q?wjAxflD83+rn1PWWvjlBbtZYehAi7SdnrTt7cv5Z6ZY/nKGpZKhwoalDdMz2?=
 =?us-ascii?Q?RqBbq3IsLbnwjcC57pgqL9qVVURlzVva3lQD7CEtT5U/sA3pVKQGO07TsVVB?=
 =?us-ascii?Q?rr0ktHM4xkdMeZ4R8Zds/HWvoVur7W7m5h8oQIJwmxHBS+fNhycNmKKQ7b0e?=
 =?us-ascii?Q?RFSTfMnZDQ/0hGt4ZSVoyXz9jiiQyd3xqQD3j3Dq1GMdU4Lc/u1nONrUSUyC?=
 =?us-ascii?Q?viPfsO2WGXMy+ItQSg1bjBGP4oT0SDjNhCztFeo4sVzjQmQZ1hUZb2tHxtXf?=
 =?us-ascii?Q?5qBxgdSIyYcORLmoB/KBBrb/AhECGv8jO5dfIVhJJ8e5tLo+punQqwcgch2I?=
 =?us-ascii?Q?q/sqwzbvBQuo7vTOjX/oWFDiCb+muQe33gX6RnL0uSwgflg8Yg10T0VVolhM?=
 =?us-ascii?Q?ZZAISYb+lwcyqUalPfe9pbySsPj6l15Xw41LeJM4cTjNi1it2e+q6sQ9MGYM?=
 =?us-ascii?Q?5qJjsDtaqHag7t0Pl3b+Aohi2ha0C+PEVg7CVR2ASFlZCR777pnD/lWTLpMC?=
 =?us-ascii?Q?tuBjU72ma5pM5SJ1Ci9BNg0/6RjfXOY=3D?=
X-Exchange-RoutingPolicyChecked: Arq6mWWSxV9D6NmRfOs0E9btZxcdT3EoGyJHg5IGRPktt+an3hZveX9l66g2ZOW2zVQ8KA1JTOncTaqyCuAORHLdg+YQDzRB85Dq39Q57PO7uKHXvSNeGa6R3eo2wgCKO1UIeuzy/0XFoNZGBfNy3h/4h2Qps76s8lkV8GIv+F+Jox+Xg3go0zZd0wd6fHcqRyCGj0EkNKMD3CW/h6KOGhdALjiB8akbluyhU0Eg4ssZajwQzrgpN4OHIgYjDVGEKt+oxhT4HQB1v1w5rhoSmdUHLWoBhwYT4ycC7McJ1+MLYAEj4679XIOOomqlWppJcUjLCXwhJUk8rIM9ORvYCw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dfcfa4-d3f9-473e-e9a8-08df36964ad2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:58:43.9897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNg4KuENQkiFyVX4nFvqxmFxYuWPRuUPfCLNZeHdAvFXCNn07OK1vW8hd1mGoih3KFYT74tJilV4Fk0pn3nSHLQBo1Tl97G8alNxP3hnyfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7554
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

On Thu, Oct 29, 2026 at 04:40:55PM +0000, Anatoly Burakov wrote:
> The flow director configuration is invalidated in dev_stop after the
> hardware reset, but dev_start resets the hardware again. A flow created
> while the port is stopped configures flow director and marks it as
> configured, so the flow replay in dev_start does not reprogram it after
> the reset.
> 
> Invalidate the flow director configuration after the reset in dev_start
> as well.
> 
> Fixes: ea0f9067b2cf ("net/ixgbe: reimplement FDIR parser")
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Since the offending commit has not been pulled to main yet, squashed all
these fixes into original commit on next-net-intel.

/Bruce
