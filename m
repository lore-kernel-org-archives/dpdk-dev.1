Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C610C531CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 11:12:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4BF340678;
	Thu, 23 Jul 2026 13:12:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 152BB4027C;
 Thu, 23 Jul 2026 13:12:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784805161; x=1816341161;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=S24GDeyw9RiiJ2omqjEDBHUVcwotN7pjmxyyA92Xsps=;
 b=eBR8WFhfIS5BL6OhDJMQ/ER2GTlb2TuU15iR+H5NHBW6IrlYae1NfcyS
 rfPVy4xJgg0uamGTuZH1z+YN2329EzHmtoHakiSAJg5jvjyemLnKlhME4
 20QFs08oNCK7Jno/TuJH3sbKtWIDANp1gsTo4It2lPZUT7tgJyqtLD451
 F2fbTiJ5p/Tf0a1Ng0PyGdc5KriwFSK0N/o+sLHFf0wMNJszYoD2nFr3F
 66i/p29BqIWU7NQ9uqDTd/QOvnZ5vUx7ytUqSkwUqcw5M8DeO7HooiJDI
 vNNL3b40P/akT/VyO8/hym1v+EvyV+D/xzogjcKzbXcVPSQ2dJRm+/vvB A==;
X-CSE-ConnectionGUID: 7q26hk/xSFqnBAQ67bGRNg==
X-CSE-MsgGUID: qMARoRajR7yrYbAsyhW7gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85474035"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85474035"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 04:12:40 -0700
X-CSE-ConnectionGUID: il4GEQ5XTtGKIko3rVzVPg==
X-CSE-MsgGUID: FissISfURMWAmMYBSNcaUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="258446866"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 04:12:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 04:12:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 04:12:39 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.43)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 04:12:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7Pn2zlpq1QRgjAHY5Ik5h4qQiRPlu1HREZLKgNk9jhUUDRbdT4PKp+8+QFz831iiD6IoZ0Fi3f7GYF/mrahamFPuWl1KYs58xHEmP9B4MYWa6KHFpnOiKq+HF7p3jpvuKmFFn2kZI5fUnGo3idcREgn06wsYllT0JIcwvg4VC2IJvKd9DE+yiy8SJ9htvBAIgyfU4qiSNS/50HYGaHqy6k/+Hqy0z/+3JaKPdvAJOxfwzLPw1XUGksPPm4/TZKO8cw284ni04ZWc1Ca6oXz1HbbsQITiEV7eKBJzDO0d5mq8eOfxToTFXkFCL2SMg6aBrHE7Rvauzz2Yre9g064NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+k2eDrVy+PudbmZmMFixo1eyCWA6U0iKby3H0jv9gto=;
 b=ObrUaQzo7qKFuCrG69JcXGDfK/m9181Zq6zZduugIcoj8m5Gi46pM6gabNMJhxIFXg4gWqOFQZqbYaN569uKyprq8R+CGv/bB1eL/5s3udaYtWkK4uGrt72v3Rj3iGKdwHya562xFlt9fAgiPoPtv97wWxMh6QGH5AwHKJUdm5QhCpkyDoS8jWGW3zSXNS1L69vcxdJrHRqd6Spzy0p1vUUNMwi0fvErPLmAhz9b8RCdGbE1scV9l6kJGnsLTMTlKHFyOVfT30WMY+gyVKgAJxuN2oIluuBPc2FkB9xdY3J/jVFK0I9J0RgopckJttHUY372kJWzNE3yMF9Hrm7d9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS6PR11MB9917.namprd11.prod.outlook.com (2603:10b6:8:461::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 11:12:37 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 11:12:37 +0000
Date: Thu, 23 Jul 2026 12:12:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/iavf: fix null pointer dereference in eCPRI FDIR
 pattern
Message-ID: <amH3IZNmnbZCeN1e@bricha3-mobl1.ger.corp.intel.com>
References: <20260720003412.60292-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260720003412.60292-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DUZPR01CA0170.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::28) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS6PR11MB9917:EE_
X-MS-Office365-Filtering-Correlation-Id: a535b8ff-a99d-4287-c470-08dee8ab4d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 6m6yMqDs6qDI1OWUbu6Da7AGKj0PnAZVXlxhSoA0mv8+kmw5Q7JTUmD/9vEJ+ZQYdufXKa9NsWYOTVwGSk2szDCtAouWT163A+B+jTw9Yu8+IKHrq+bPKJfw5JRxKb2luLKGoW43M+v4QhSMCEeJTsbz02n1qQKf5Zwm9n5bBzAYMIuCpjcLQilSNaCj+XhqefptQNKOWiPbCwdptdp/IJc6z/o3sMYWNCfkUHz5Fuzs9Jn7o0P2DQTGhui0ucXaN+iKSFzYCQwk0Hp8eNl8wJT8Tahla/J3usIKIP8mvv05jXspXH5clB4TZUiyrhR+RDAz7y+w/kB5gfyU53D5yYwUe3KWeNJ62JMhuXTmqGpfMx7IDPEEZc5nWyUen1I88SAdjshYA5H2UKQToSrjIknAHvIxON+oesryXKBGikhWtBGoVrJrbKaXV+TNvVwp4IuqSFnIxFHzWbkn8Y/bq5IdU45KLIomLBkzNCB+v6oiAj1bHJKq3g2Y8afjSlQH6hm56Qf44ZfzObr3uVn8XxbgXxpiKXbLKlno0kr1zkdj/21IpNvFN2OoIDbPwZUPVsEiqYzxMSIvOSkZsBOCnVfcbNXc9vHabufPafCOWyVNV9xytb2HzIAk2iCSyJuHJUOIPHPwTyzm5/Xuo8t/1gpqBKyzIwOGcswiJxqswY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gIWFG/XC38v9R2MjzWPnaqE3PJPnlUpk3N3fqZZVYCGuwLbTy7GSEaep99Ia?=
 =?us-ascii?Q?xNGF3h1di/ejBwePYbBfEl4hx5fApzltoaJ+ZORF197nY+pYeWjjpt76eUKH?=
 =?us-ascii?Q?F1E6247YqIeoRiV5k0CrXZc9qpK5pu4XsiA+7Bd7WnAwfAS0kWe/Dz1NzF8d?=
 =?us-ascii?Q?u38vqFBvHtElnEHEsqp8fkGp4hTARFX+NS3wYmK/I7I4l7kiWbbwKFJzs1+G?=
 =?us-ascii?Q?u8Sgo/RG3ElOaOxTWLMK6lQR+YcHgiiTA/B339H4O+dtXQ8uvcFvplXbxUXx?=
 =?us-ascii?Q?7Yn11W16l5CZXSKwnXkFW7Ef1UYBu5c/dXYVJdqKsERElzHrOK9mO/N6gqAc?=
 =?us-ascii?Q?NAtWh5BPpKQApX+fAF810FesS5yPAXLsD8+rm2x8i3u5ooHGdIxaUK8W7Ln1?=
 =?us-ascii?Q?eDWoCIvxjT273I6NGsopWumbwNHHn3GZcLFJ/7i1cjKKmG2PUErBIe5ZYvMA?=
 =?us-ascii?Q?mp2WUlHKgO+RvMVqpS24nYoEC0IDduk4ABsfHQpmS7/D/texDFCjPDdwnHQA?=
 =?us-ascii?Q?dQKpsVCq4sbabvvRlmHqg0G+93/SaioPSTynOWohylbG98PnHlSM9TMxu0lu?=
 =?us-ascii?Q?CJW2zB6m5bg4An2P7cb5gcrOHqwZZ3hrhvcVPTCYCArKAmiRvMSUmC0f3DaS?=
 =?us-ascii?Q?irrIQMWYErg5lR/GBiOeDyj6/trFhc0MZyL1tLaoVL3he4RxuCo6CQy7DBRC?=
 =?us-ascii?Q?i4QZmxyTZixBt8O1co56HCUYSm9XNUOlurOGUhpuhhqlBRy0L+6TUzN+YmN1?=
 =?us-ascii?Q?qXFhtSn8kiWnpytnlh8iu6m1HZ6rTJ+5c6Ai/UXwEQCXjFgzM7UlnPk2poVL?=
 =?us-ascii?Q?nBSwfDT5CEwidr6nUGdEUkEVGFiyqVY/5mANrsPK5ogN2FIRhO+lD5ftC12d?=
 =?us-ascii?Q?g3g6WMD90Yb8jlUE/6ZamQJ41Zm8m5vl4KQ+3uiGDiRQs2ZMKO1jyxukNcV8?=
 =?us-ascii?Q?YJEwYIgOiafPId1EbSwgpFsHqAT5z3JCLfKK1scEbo6FAJ/4RXuhGLF7Dxp1?=
 =?us-ascii?Q?5un53DP0jV+oWL3H9Jg/dvFviKXS/ukI4gOzbPWSfe7eR+9vpBZG4Mx90QNQ?=
 =?us-ascii?Q?ckBLukmA3eb1AmdACfVAdmsyOYzKUO4mtfIBGzmfAvW/dWVdmjNufhSo+oHy?=
 =?us-ascii?Q?IZhElnMlxcShhlWm3uy5ZYms//oBuUTllHnaLvjJcex9mJr0QcpXqoPRedC/?=
 =?us-ascii?Q?5Sc4mHKV3OY4aX9K6Fq342PFyovvQf+OSbvoYpsaixi9aGjVZpiLAHn2LmP5?=
 =?us-ascii?Q?VzyI9ikss5Mica6WCKpIVXl999n+BkiArpy/7yYL/qhg521Hjjzc55DQtowY?=
 =?us-ascii?Q?2AMAcgEvXCahqD04dg2syjtRlYX8UPmngQZlTQExAzZCNKBgcjwlIDl6H4K/?=
 =?us-ascii?Q?u7wnRBG983POG1CxMkhnyX2y6ywncPunCHIp1PFcQYZluXMH5cQ/qmKZqUES?=
 =?us-ascii?Q?Bq4SJGaNMnXE0Z9CjiSy/p4jxuTQGRC5/VnWde+qM0+F2iJ0f7ESUe4f7tWY?=
 =?us-ascii?Q?xZW8lpRWeAwD8qS92EvJq9o1CdpMIv0CC9Eclfcf2/uN27pm1JXct0xKP9Ka?=
 =?us-ascii?Q?+TWG1bDY+q0umE/eoPMkfctWtG2nBZCvuoOP9yLy4Z6Ye5R/qS6SFb+ahREO?=
 =?us-ascii?Q?jpVReQXOarfS7CAT7ox8lat2wVuclwUD0YLJO5sPiij2KQuvIO50eBFHLm6W?=
 =?us-ascii?Q?Ex/tIW/eG6vagrTNjhltsB6LPZNQXZCgbsmiBzIczuN1HrVXRjslotIl+AyG?=
 =?us-ascii?Q?7C8t4jwPv1LkyMsz7kIlnNDSAMrLKcE=3D?=
X-Exchange-RoutingPolicyChecked: Vduvo4yG/wjQUrlq6urDJBx30mbG/v1ekVbbi+YOLcKDbMGV039n3QFigckxPw/6t+MocCjOHVIkCzs9DNT/HbJ32Y8m6PzKUBUpXRnZ28Sc1SrlGbQEWjF3+QE6TEnCkETlNcndZq8awEA54k+XpALwP2gxzOGWbjubp9YkpUEEd7kzGLK8bO9MbP0jM/R75cLnH48MRxbuHrSY3qsI4Us9U46o2eGVJWceoUQPMsyq9sd0MYjsAxHusjeoJ1+eqn9VlFtCjqHXMxWkEzu3ojnxoAHhZfWhCjQ5+cjNhZZTBIiEb+zmle4rkZPsNvbnuN0FN+0Z1xRH12cCOAJllw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a535b8ff-a99d-4287-c470-08dee8ab4d6b
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:12:37.1074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1PyO1sI1Av4z7KnTQiDjZzSjcExbwqQpIOjNXkOu7RzzJuiDJd2jHAt2Z4T7FeezIpmxG5xAKvrCTwxVPU8sJzQoyAVgBCju/UeQ59GNv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB9917
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

On Sun, Jul 19, 2026 at 08:34:12PM -0400, sandeep.penigalapati@intel.com wrote:
> From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> 
> In iavf_fdir_parse_pattern(), the RTE_FLOW_ITEM_TYPE_ECPRI case reads
> ecpri_spec->hdr.common.u32 before checking that ecpri_spec is non-null.
> A wildcard eCPRI flow item (no spec) with a queue or drop action, which
> routes the rule to the FDIR engine, leaves item->spec as null, so the
> unconditional dereference crashes the application at rule creation.
> 
> Move the ecpri_common read inside the existing
> "if (ecpri_spec && ecpri_mask)" guard, mirroring the other pattern items
> and the RSS-hash parser in iavf_hash.c which already handles a null
> eCPRI spec. The rule is then rejected cleanly with -EINVAL.
> 
> Fixes: 6c37927479be ("net/iavf: support eCPRI message type 0 for flow director")
> Cc: stable@dpdk.org
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce

