Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F02606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mrfmrvfv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=LCKooEq1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D852A40150;
	Mon, 16 Nov 2026 11:51:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 7CB93400EF;
 Mon, 16 Nov 2026 11:51:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794826269; x=1826362269;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=8eLMTFx63rdaeq4GjucXzZQsPbGRy7RVm+LWPCES2XI=;
 b=Mrfmrvfvv2nMdY6VknpkoKk0xDmOHJH16ayYGbQsA2WQDXYKLayQwFuH
 iXiKbidqYsfYy/wkE6/0wPYr+CJT2JcEAdZ6xcO/4EsIrXx39mD4cMO7N
 lCUv3w3W6pr8WT3mCUxa5cHdLoVz8mMnlWqj9WEsvHYZcjQ68JOx9sBTa
 XWgUMKSKmf46TR9NRr/3D2k4F6eWlc1riTEIdM7P2yl8erL5DwVtbCsRK
 6PSnct/JXc3Scn9/p+JXaLm5/NznltRpgCd0DGwDz3WTIyDWjdp4isPvs
 qVwZPB1LOcqY2bU9YXyfeI+k515E3JSFt20hPNNCWQyg6wEqJf0z7gcrG A==;
X-CSE-ConnectionGUID: AulJCk6ZQXq9rcBeR8v/rA==
X-CSE-MsgGUID: s/jWqGbXSA+eWjmrNws1hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3411468"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3411468"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 02:51:07 -0800
X-CSE-ConnectionGUID: IrFESv/CRma1Jzpvqvw6fQ==
X-CSE-MsgGUID: P5Iznl2wT/S9wZazw5CXxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9450678"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 02:51:07 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 02:51:06 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 02:51:06 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 02:51:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1WgEXXZwUXs0Qaqs21P/QgsRy3KQSEd2cWpcGZz3PXkfY0suaTSyGiZD2Zt44nfqq8ES3DygtlVRjlxj9JWeTK5isKu6MP01YsiZ1AI6FE13jpbYCWOvZbEWf5V/YGXxRO5XI1Gi4E2ks1Me8eWt+WJTOlb7c/9i9s94CXmrvwVgBL1JIDWWgzpTiu9yMPg26fVUCXkMAF2NgqyoAto5/ANELxq7D3TX0W9htoGx5gcpD2nwHWUY1PVSG+1QkxgNS9WvoRdpFi7Ev8VgwaNsXZWJryLOHH6YNEgGxYUTdhtYtJ5gVObF88uwk+YEthTKU5Gd/2AfqGgV21HNZbWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LiC7vL1iRFT+vWvTC6Ua07BmFFIB/j5oMy66QjqHfk=;
 b=vA6HLKbE+ouMnTJRCtpY/NJ+uWt/iDfzWhsyf+xASsPi2SSIUGQQvH+KeLNfJ+uOqtJAvTECTBeW/3RA95PXO/rMkMKaxsHqlH9+Z+ZRq2lJZePSJ09sIJT+vPBAYFJz0NDo+Oj7BueWmZTTuxzD5tvvrdzxct8m028KYc+8cvMZMYOVQk/P9/wgQZJ+ZmFZe0ixa0UKcTYGrfsYoA75wZ9K/LV/X1B2NkUhDBWouXilL7I1WdIGbi8kO0cUc8mcYhS61mNg9Gq5lJWB3CR2iWQHvKXKkHKNP0nFmk1Q/IQlymWJSD2/DIZxmtOsze5EVC37yLzgLXpbOGzd5QuVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LiC7vL1iRFT+vWvTC6Ua07BmFFIB/j5oMy66QjqHfk=;
 b=LCKooEq1xL7YcN+i1mrpNdbCmZg5Dd95vYZGoYu2CGHjtr5Wk+nAAX6pZ3GaT+ZFrVTdTsYnl/BepUZSday2A+oXXqyfleMHLSb0qvZe74W8n4OAdsCIAxN+lobvDhePCU9qJr9wqx323MSLIUHoz/aXmL7WuarSqzGjj0QlDGs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PR11MB331194.namprd11.prod.outlook.com (2603:10b6:8:53e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 10:51:04 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 10:51:03 +0000
Date: Mon, 16 Nov 2026 10:50:58 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>,
 <vladimir.medvedkin@intel.com>, <brian.johnson@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v3 1/4] doc: fix ice guide
Message-ID: <avrgEqCL7-29C7Cz@bricha3-mobl1.ger.corp.intel.com>
References: <20261114075732.183996-1-sandeep.penigalapati@intel.com>
 <20261114084619.190251-1-sandeep.penigalapati@intel.com>
 <20261114084619.190251-2-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261114084619.190251-2-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DU2PR04CA0217.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PR11MB331194:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4bc4c4-23ed-4441-75cb-08df43cf8265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261021135927099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|18002099003|22082099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: sPtKZJNR8vN03vFOXx4Ci5z1N6I+aaXDXi6ycXMqzGjdB7e2MKHF8v92leUL5JDgUVE9OzNApFnRwiLDkdghKlNgYJHX/2/Mvp+MXe/npp7H2rxU/yKGxsJOlZZgt8kiAcHWQBLZdOkaRXSdIeF5U0gb5LEOr0nPSIs60B7nIUCEWOX0kuL6V4zMAVcXKXP0aB9du5Ow/LlNUHSX5JdbEadX8M4/3cwwZrWL+nz9dq7b42BWULZsSbb+emXhZpbnQKe20xtwC6O11vzo/31R28I4mTD9BXXKr2V2GKswoIwghXPjpUQCsZ18pSjww12AOxj7MrPRrIaNrT9igb3k5gxu5Lwn1JOYitH4aZJDeKfY3NpDcVzUp2Q1h43NyTrVrhH02LlJytDkZyJRx+JwnfnZuZ7CRcpGZk0upqxylCYb844h3qbNJbwLGyHyKQEqmkiDKLk6LntV3Omw3r5vCm1kPT/5m7f+DwULiEozQE8qQSXmfIRBl2+8wQIEkobGVqpLFXFMpJ4BlWBzDarJ5y0xKVKepWoTUMYQTdarJzKNxXZNhQldQpIZYFht/Eg/K3Y8XPCPScQxe8cpb8lDeNJow3fTNtL/lt15jpDpWms/szsVCS8bUNRiVIZSdgnPhFcUjEkU1F1rdxGWiJuOeJAOUTDkesYpJrRsDWwJR+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021135927099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?89VByQ1RRFWIJeGuVw4bklhzHP/bePMRExNv+8mKEIbcJCAqydDk/fNr67?=
 =?iso-8859-1?Q?cyelDEC1wEJy9rc9q5h2OoWrB51pDkWNUK21Rp7EPqN3RpGWvbKLe5mH8b?=
 =?iso-8859-1?Q?wHskx6lcq5kHFL3xvFGlF7SJI++VrvAWgBrorGki5K151lC38QcQvv3acg?=
 =?iso-8859-1?Q?sLvbraoweT/X7Ww8p8nJhs+vxxQsMPKTDBChbw6PhRol58ParnunD1ocNO?=
 =?iso-8859-1?Q?xFsmPsT1nNR3m5dLXFksGR2oGRWsbmgOOoSPgragZpk5cAzEZtqoiA2Ywd?=
 =?iso-8859-1?Q?jeaEqtIkrs0UQQ0Gtdq+3ac1HTLM/yx8d9FNDZyarTWjTBgRaC+GBhXED2?=
 =?iso-8859-1?Q?hmuOuauYDasSzMDSuUZEs9XaIhv6lxHajlsqpdrZE5zB9KAWiFHlR0057f?=
 =?iso-8859-1?Q?Nfu33bnEu1UPTxTZMscExVU5YohS8shTdQP5Sk3i169+MeJ9JGqLD067vN?=
 =?iso-8859-1?Q?ElQABSCmpK6R6VdZ7d2MuDeLfZOZU6WGI1x2Y5VxxMNiCBWf66CrS60Kt/?=
 =?iso-8859-1?Q?hP2cUOvUOQ+yDIHpo7fFTegZV5GDSyQQVJfuMIx1+NXuHonHLbhBxDrzy0?=
 =?iso-8859-1?Q?JfRT0qySZTn1dzje7Gn08mlmfhRKoRoUqJmFgD/a/uVqJdWbZHn7UbQo+o?=
 =?iso-8859-1?Q?JTKFywmxXRv5+mAtdq7EM6lQc5pSLEEx029LTAi/fV/5iadSfZxGrniEUE?=
 =?iso-8859-1?Q?Knsj5t6hoPJ5W+uetxMxrr8gIFVTT5wyRGAK+eSuIC2ccouW1MqqHJ0Lq9?=
 =?iso-8859-1?Q?rg61Ogv6P4m781bkbQ26332S+w2e4EohjD9tphic1kcaeWTS6mJwN0ewQr?=
 =?iso-8859-1?Q?nDtT3gU9AiffB9DDLtI2izfvzm4oL0M/AXWgeKJoR+oaHpb6vSXsY9yFyq?=
 =?iso-8859-1?Q?d+aFCZc8+4d16vI8Iorq/NyxA4fByrIgWuTC4VmcsJJeHZL/mC4CfrESiZ?=
 =?iso-8859-1?Q?GJvB1QMSV9IWJ3JTYwBViyFNb0j98chb8jC9eIiboVHJQtlpF9oshDQiis?=
 =?iso-8859-1?Q?Xf+DeTULTuF3jBtM9pAFZ9bbbwa6frQfzxxGHJCcl/XMcNdSZgFL53Pn/u?=
 =?iso-8859-1?Q?hwfWhGJRYwcfHb1pPhOckkgAdAhba5HCJU4VqZ98SEeNLkrrgruItqPqjP?=
 =?iso-8859-1?Q?QEJR6VwP1orpwvGPxn9WO/O1pJ/aJCJbGgFDt3AgliEG16xIyDjWeMj8ze?=
 =?iso-8859-1?Q?KeMg4hkDnaHzpOFc/zkm+Qo81tFGHVQBFTh3Dvc4qJzHItaogU6steFtAS?=
 =?iso-8859-1?Q?Wj9VcN0Kk4R4gbie9aeT5bmRcm7XetG19LKDQTsF/7p1MXR6ts52nX+Hcs?=
 =?iso-8859-1?Q?QGK1ltidn+Pr22Ck+7oZbQsphRpHObp1ATIsiv38n21u7ME2eY8wTAtAxW?=
 =?iso-8859-1?Q?Ok6NeHAFZRO8bFp7BsNsntbxvHG+nQtVcydASWEDKiscbJQ9R5Tc1LOOfu?=
 =?iso-8859-1?Q?b+5MBLZpJbQi6GWpDywQCq/RMZs8L/GCJqgQM8DQV9MlUTDVLutWvChIHU?=
 =?iso-8859-1?Q?5oKm9ZljnLsZ0qMsZ9M0nquI3I/l1zcodiJ9IVxbgEWXsmTgIm4Z1g+uDC?=
 =?iso-8859-1?Q?GKt9xGTVss3M4OcJ7jqHWJtvGvZjDhbutC6zJwTyiJcjVZIntg1WBpV+Wx?=
 =?iso-8859-1?Q?L0V+sxmNZ4h66aLbVhwfY4nq77ZqnS5XmqynsdRZBm1bkP+0xbOvVF4xCi?=
 =?iso-8859-1?Q?r0gAU/jtoJlVx+L5hKEYphD1RFCwqO+rQQtooefsPe8jXTHypm+WY74Wwu?=
 =?iso-8859-1?Q?RnXajbmpENiqWOslo41wnQ8/NTeL/2UPYBOIZsWxLXa+2ZC8mqoFBRmSPo?=
 =?iso-8859-1?Q?GbzuFkZeA/EiroOLguwjQNGVmrV1Or0=3D?=
X-Exchange-RoutingPolicyChecked: c3poOuxp2AIK8UdQPIRP6H8TpFz366mGGPF4W8xu9pjHzVE6C1gvEsTS8KuuyfNHLprktaOQnyddPQE7Vy28hBkBOQ8zFbDeSzkVWsRKrDoRxtdKKs+LT3rE0b57sUVY43bGXv7ABDcjS/RoIr7OUcsikw9Tas0l/qwQ1ZweVZSxGwvBJIT2FDySbG5hL+tOVg/FialRuWw/Aqp3D8YFEr93NMTT8qQ6tcXv48cMcO80gsNAbE6TTc2gEd9zcPEp1C4E/rhQXVruRhJAZKzbVaWHUqvqZRVsb2NAp01EszixvxWrv6N4SMGMVHUDEbdHqlX1+hPL+eeQjxLF6VBVKw==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4bc4c4-23ed-4441-75cb-08df43cf8265
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:51:03.6199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VBSaz1li3eijg5ed75yzFXCVTGGrKvOyp2pB5i0Xbet6XblfEbylHGI0Msuw3G2Hh1vgYdcWdfYhdU2PpfwfIbOgjsxOMt0QgonGVaGIpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB331194
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

On Sat, Nov 14, 2026 at 08:46:16AM +0000, Sandeep Penigalapati wrote:
> Correct several errors in the ice guide:
> 
> - correct the DDP Technology Guide title (617015 is the generic guide,
>   not a telecommunications one) and add the missing Wireless Edge DDP
>   reference (637554).
> - rename the Comms guide reference from "Package" to the actual
>   "Technology Guide" title.
> - use "proto_xtr" (the actual devarg name) instead of "proto_ext".
> - drop a duplicate assignment in the raw-flow C example.
> - add a missing literal-block marker for the "acl=off" example.
> - remove a stray space inside the IP address in the scapy example.
> - minor grammar and spacing fixes.
> 
> Fixes: 7564d5509611 ("net/ice: add DCF hardware initialization")
> Fixes: e89aebf3b597 ("doc: update ice user guide")
> Fixes: c2e129698dd6 ("doc: fix some statements for ice vector PMD")
> Fixes: 9e984bc53bc9 ("net/ice: add option to disable ACL engine in DCF")
> Fixes: df539aaf35cb ("net/ice: refactor flex descriptor protocol field extraction")
> Fixes: e6ef76212b28 ("doc: add generic flow in ice guide")
> Fixes: b060d3157751 ("doc: explain protocol agnostic filtering in ice guide")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---
>  doc/guides/nics/ice.rst | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index faebfdcb63..a8ec27e745 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -26,11 +26,14 @@ Linux Prerequisites
>  - Please follow the matching list to download specific kernel driver, firmware and DDP package from
>    `https://www.intel.com/content/www/us/en/search.html?ws=text#q=e810&t=Downloads&layout=table`.
>  
> -- To understand what is DDP package and how it works, please review `Intel® Ethernet Controller E810 Dynamic
> -  Device Personalization (DDP) for Telecommunications Technology Guide <https://cdrdv2.intel.com/v1/dl/getContent/617015>`_.
> +- To understand what is DDP package and how it works, please review `Intel® Ethernet 800 Series Dynamic

s/what is DDP package/what a DDP package is/


> +  Device Personalization (DDP) Technology Guide <https://cdrdv2.intel.com/v1/dl/getContent/617015>`_.
>  
> -- To understand DDP for COMMs usage with DPDK, please review `Intel® Ethernet 800 Series Telecommunication (Comms)
> -  Dynamic Device Personalization (DDP) Package <https://cdrdv2.intel.com/v1/dl/getContent/618651>`_.
> +- To understand DDP for Comms usage with DPDK, please review `Intel® Ethernet 800 Series
> +  DDP for Comms Technology Guide <https://cdrdv2.intel.com/v1/dl/getContent/618651>`_.
> +
> +- To understand DDP for Wireless Edge usage with DPDK, please review `Intel® Ethernet 800 Series
> +  DDP for Wireless Edge Technology Guide <https://cdrdv2.intel.com/v1/dl/getContent/637554>`_.
>  
<snip>
