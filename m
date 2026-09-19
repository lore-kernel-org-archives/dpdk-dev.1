Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F94C982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:09:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A26C140272;
	Sat, 19 Sep 2026 18:09:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by mails.dpdk.org (Postfix) with ESMTP id 90E414026A
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:09:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834165; x=1821370165;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Fsv/5s/JXR79gkFpwFTzYHVxNfX6HgI7Jt46OhL3YJw=;
 b=NqSU52ynyGHGI8ZVVavG4ZMQisuFbo0GBjeyE83QZqlEjQK1Nz3QN6dX
 cKNPoL2y/wEC/hV+Z5X6dkkIrRo7ggUvTgZcDdg5mG67oK+UTC0qoJ6we
 mQLDgV5P0bfdYsE05JrbeUu8qT+T1ZzXcDaOoXaQechQh7cawb02yTYYM
 HjuGhqPjbV60FHtyXcNxKY12SHyJ8HfsH4oKGt5wHpPC1F+AR6vGs3WFd
 va+B8f2Ge13Ii5JtV8D1Si9K3nEzR2+TzZ32ZKuYUhRsg+0pz48a30PXC
 7YVlZCdh8hUPoPIdoRiiY/pUf30gbjupjnbNIuSAaUiov7ybVQ9ZXHfUU Q==;
X-CSE-ConnectionGUID: GkT3a6wqRzy61Nc7x3V55Q==
X-CSE-MsgGUID: UZEWgCV4R3mTWtCVv1mOaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="861469"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="861469"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:09:24 -0700
X-CSE-ConnectionGUID: 4KFH274kQ/a/zIbSh2nCTg==
X-CSE-MsgGUID: 9T+W8V7VQ3i+TXKri9poRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="3061967"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:09:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:09:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:09:22 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:09:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVnxYuO/VWPRWJtlnqyyhLZ4N5CJGNoHuwp7SR2xbCGUqU5iortHZnkW0RLQI17jlY6WQxKUEw0o4evhvoFvC00d3njX0et8NuCYdzjKBIpt5Juki26v/JoCMCWLySehE38dirh9/Y24/eWupqx45E4m2dI2cH4qXV7A4mTq/lTl+CoQj9FxORBrsd5WY3UiiiTSPUNm9JNcRsoU8Yg2rpkVDj69plC+2/l3OnNNUYc/Ed/HqrZjvnZ2418FRDps67W6/D/TReX5dSgbzH6OpTyglINLDwaUP1BIKUBm6OegaDivrrCx1zLdwv+1gsbyOtt+o2SEn5LBJgMEBp4djA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sS2YdHugf78MNT0Km8LGeQKoOL6etTqxsxeNiAU+N6I=;
 b=cBz1+sIP9gN927z0LJuerSBwF4iVxXtgBiqGf9dGzgf00Wbzsx1dORA5GvPpKtd1Z6xmkxVfxceEb3GUfoP2/y49j8BVl6UEOZDuZGXCr7MwSjnq+kNC9qJc+M1LNs2r2RlBMvAOw5jgfNtqjoDE8egoJK0n9MAJ90LldAzxWNCU57qEjV/wymur6D379U3BQlZMSnwakFNPa8keD2izSnkaTt4zbdtyNAoJs87zNN1ZCjfatpr+7BBvOrgT8ukrXZGq0RUvQ9iWc95Fga0j+tNztMlh79NrbEcQPlyq0mQmtj21hoBhiUWHCmvrRtypNOTQ9O5pbFKicx1tgchzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:09:13 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:09:06 +0000
Message-ID: <5806dee4-31a0-4cac-9271-252e79b24a76@intel.com>
Date: Sat, 19 Sep 2026 17:09:03 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 01/19] ethdev: add flow graph API
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Thomas
 Monjalon" <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
References: <b1982ff795e9db6f7fa34992573f7bad0294f77a.1789560944.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <b1982ff795e9db6f7fa34992573f7bad0294f77a.1789560944.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::19) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 2585bc0e-4c0a-4641-9293-08df16685484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: DQ1Rr6lm9muonDqnzUe3s+Sh/0wHle0wAP1XQ0Y/HRM/rbuLTuPpwHhWgxZGH5+2+JoOV6pQR6j89tOdPfG0gbnm+RBdU4WHPPqxDWeMbQYxR2zNmC7AjIuqJdj9Ur11ImhnSF6gCvziSpA0RKP0pC6fG6QgdX51OcUFi7acsXcZUMvV7KJl0eV4BsBevN6HxoCFkLP+7wwsZafCd9hI7KI+73sZ63/9t2QHJefpaG5tW+kexdhrjemQJrcbLhGFcUeBaqJbLv6SGjBrruNjgYsJAjBUEcumbK3vAi4BDxTWgKntw/F5kgEyb0yQuKa50kJUAfaQoD0GH7SzOca0iCke20odg9//8Qp6Fxq1V8A88MmsLzhPpZzYzjqp42ppaW/2witZclVejopwBB90c619B5vu2djVU6xvvgjsBASFhror6Mx4LBn3KeUiGMYIz3DcFsunSFLJ9ZOv8kZA5ApbKPpYZ+odtN6vs7MKSSdanGk2pqLBuNnRIB0WLmosmekuTnxDv9Wl1zq9W7t3wZQuUCw5/83+07C8FkKO4QcBC2axcwslcp39/8L0sn+p8HRpjKfhU0/Qrg52eIL/pno0Sv7Tox/ktuujy8KDsV6U294wSm4KVbdvr6LdIBG2E4b25tW6EyoZplNEx1e0w0ouX/1tKdH1b/DQEltgJzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmlGa2c0VW9kbnhVanphTGVPQ3RkY3Q0aHpwMEYyUTVxb25kTTk2MzVTOGhT?=
 =?utf-8?B?RWhpSzR6UkdYanNZTU1GM29BalZGNlE4eW14dVBFc2poZ29DSHJvcmhzKzdr?=
 =?utf-8?B?YVFHR0R6Nm53SmE2aGcvK0RzaHJHdHl2YVdIS2QwQ0ptRllVd09jVTVWVzN2?=
 =?utf-8?B?SGMvVEkvTWdRR0dkN3pmUFFHc0dZSW9mcjQzNTVJbm51OEwyM3hSYTZrYlpl?=
 =?utf-8?B?VWErVXFrOTJoS1dkNnBsRGprU0Q2a3V0dmM2TStvSUdFWC9rSVVtSXJxdDZS?=
 =?utf-8?B?TWZOaGhsRG4zNHA5MnBFZXFvZkZZdWgraHlCTVB2dFB0VTVCemc4Q3ZwUGNY?=
 =?utf-8?B?Z2Q5UEU2b3lSakFMY2RpN1dsMFJHYmlRcVN6TUZ2ZWIwZzh6Qi9sREc1dmVp?=
 =?utf-8?B?OUhlb2JJUFhCRHlFd2xDOUpuRnVSaTA4KzVJRXBvdENTdno2aHIxcXRBc2ll?=
 =?utf-8?B?dG9oVFRFTm9QelVUZGhRSzZhbE5XdmNHS2d2SHRhc3dBUElJelAyRzBDekpu?=
 =?utf-8?B?QXBGaW5vdVNJRG9Wd0NLNi9sd3pZUVVOTkM4dUpic1hFM0dkcEhlWTFURGpN?=
 =?utf-8?B?TUVsM2VrMU52QUtnaUxpQVBGRkt4eVJlQk05bitTa1JqejVrN0dXS01WYTQ0?=
 =?utf-8?B?UjBXZDNNYUxCa015Uk5XQUdOaE1MQ2dqZjRwL1FnTW1XZUZNZG5ZeHJObG85?=
 =?utf-8?B?YUpnMTlEZVFQRjFpNTVxOEZuNkdXWFVhTURXY2pCWEhTSVpLczlGc2tFWElm?=
 =?utf-8?B?SGwwK2phd0gyYW9VM3ZLQkxlMWtER2NObjhaZkF4SW1ITmhNb1dCZjN5eXBq?=
 =?utf-8?B?UTN5cnJjQVhKTnhiUm5CRHFGeUNGcWc4NEtPTC9FNmxwTFR0TVdEV1UwaHhz?=
 =?utf-8?B?UXBEKzVraGhsZWxiZVpGV0FKdTZiR3krVEU3bUMvY1ZTellFQ2p2S2FDZDhk?=
 =?utf-8?B?UTNNU010d3p0NUNXNzU4U1NUd2trUEZvMk5QYmNJS1RkeWV1cVIrc1ROZWJm?=
 =?utf-8?B?TnduUTZ2a1BpNWd3NXBPelNGc3VxSXhLakl3UnJ0QTA1N1MwMjNlYmhWbHlD?=
 =?utf-8?B?TXNYVG1kSHNWTmE0dlpFeDZ3MkN0UFpiSVpJQXZjMlFkU0xXV1d6VkVhbEVB?=
 =?utf-8?B?UkhWZG5DaEhrYXc4Sk1EN2xNUEppQldSbmg3MVBlVStFN2IyNkR6Tk56dGxq?=
 =?utf-8?B?L1U3cU14VDdFTW0wM2dMTkYwWGt4cHNYWDhSOW56WlkyTEVnajkrc25pL2o0?=
 =?utf-8?B?VC8xeEVMZjVQamxuS1J6bFNTNk9BbkRGM2g5N1JtNTREeWY2K25ZWXVFZWVz?=
 =?utf-8?B?SzJzWGJnd3pnMVJlcWVRY3J2K3NlT3p2bXlrMlRqUWZFV2FNK3loQ0IwOXNY?=
 =?utf-8?B?VGYvT2VjNXBQY2d1MXZHVU50ZjM1dDRZSWtCWkMyVUUyNHBpZld4MklWSTZ3?=
 =?utf-8?B?a3NKQVdjYlgyV1BqRDZ3VzJIRzNMbHpkejRNVkpMQ0hvazdlN0JjTFBJZEJE?=
 =?utf-8?B?MllLM0tpU1UrQUw4dDl2cmRLNWxML2JOMlowNTArWmxkeWZ3Q0J1YXRhQ1dR?=
 =?utf-8?B?MldpcUFlNmIxa1BYNjRIL1p0WDhxbWtvWkxobWZ0NFBiYkZGZU8zN3F0bWRL?=
 =?utf-8?B?Uk54M1dzdkp5bWI4bFg1MVpieEczckc2dzhobElCWDhFWlF0MlZ3ei9DTXg5?=
 =?utf-8?B?YzhESUxDcXhyR3c2R3NHam9yMHlHL0lVd1AwUXN1SVc1QVZWZkxPbUgyNmZo?=
 =?utf-8?B?SklhS1ZNR0FlTWh4R0R4Mmh1eUwvdGlJWjlTQU52QVppSzk0dTZ6MEdFMDZo?=
 =?utf-8?B?bUJTbGtRSGtPUTZaYnBPcVNLUStBY3pCSkZpblFOa2tRTUMyM1hnWU1oUWFi?=
 =?utf-8?B?enpwU0lYc3VhcDY4TlhVSmszMndEcUdjMThLdGwra3QwcVdqMEU5VnhVRlBN?=
 =?utf-8?B?N1k5c0djV0w2WXIySEt2RzZ6akM1QTJ5NUZwUStnVGJNSGdqZ012YzB3SFND?=
 =?utf-8?B?OG4xVG1NK25JQm4rcUFxNkJZYnphdVFqVWZ5a2lIckk0VWtXd0JTaVI0MUpX?=
 =?utf-8?B?enRveWxaWDRTV0NaZTBUeVU3dkdTbFU0L00zb0JmTFlwVlZDc1ErR0tYNHAx?=
 =?utf-8?B?MlpFWWxOdFErbEU1TlQzVm5icE1UM2lZSHcrdTVmSlNjUDFUZ3Riand3d1c2?=
 =?utf-8?B?dHpQWitUSmlCT0lwSit2M01MSTl4L3JDaDhPaUR5TzVzem9Xb0FrSzU0bXVh?=
 =?utf-8?B?NnRjS1NyNUZZMHdrRmZVSTAvS21pY0Vudjdib3FHY2RMdmRNb2ErRFpFcUtq?=
 =?utf-8?B?WWtrSnpCTU9NV1Avb21PdG1ITlNKY3pPQnZ5ZG1HejVtWFV5bk1QOCtsTm1V?=
 =?utf-8?Q?HkcT+eufNXx0EJfc=3D?=
X-Exchange-RoutingPolicyChecked: Zh44B0vlxorr49HpLHP9BiP2+1t62W9C3dang++u5TLMJCW/ntKDqdSUmLsvsABj7mSB9zhogphIMnvlg12f2BCEuY0nuLG23sbx0KYXZ641ZkIZbRYaDWKbTJjZgUovM7lrDmvFgbyTblLVMyv+a9XqynN+MTSOiXHO/ew7SQIayOVaYyyRHcNyyhe2OR+AGcPmYCOyce04MX3rHvHEhFjhx+Vax6NRmnevrKfGxfOMc4p+kXS3YsMhZMuPnVTi2a52xrY7OjoFMbUhjbRzkuuAht/dPENELmzcnA4bVVMxa2C7kuMHZ5IgEuAX3gqAJ32R/Pc/dDqAFUMP1yY9Kg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2585bc0e-4c0a-4641-9293-08df16685484
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:09:06.8477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7O3T/Qr/UCi0K6OCOCtiGpf7k3i8h0vt/kz3KfddLe8oabbgKhMT+UtZDVL+xD6KVHW6ZJE5QdUGjNv9ILY+s0E5pSr/y8g78YfHGDv+jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
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

Hi Anatoly,

On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> This commit adds a flow graph parsing API. This is a helper API intended to
> help ethdev drivers implement rte_flow parsers, as common usages map to
> graph traversal problem very well.
>
> Features provided by the API:
> - Flow graph, edge, and node definitions
> - Graph traversal logic
> - Declarative validation against common flow item types
> - Per-node validation and state processing callbacks
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
>   doc/guides/prog_guide/ethdev/flow_graph.rst | 749 ++++++++++++++++++++
>   doc/guides/prog_guide/ethdev/index.rst      |   1 +
>   doc/guides/rel_notes/release_26_11.rst      |   5 +
>   lib/ethdev/flow_graph.h                     | 507 +++++++++++++
>   lib/ethdev/meson.build                      |   1 +
>   5 files changed, 1263 insertions(+)
>   create mode 100644 doc/guides/prog_guide/ethdev/flow_graph.rst
>   create mode 100644 lib/ethdev/flow_graph.h
>
<snip>
> +/**
> + * Graph node definition.
> + *
> + * Node validity rules:
> + * - all nodes must define a name,
> + * - all non-END nodes must define an edge list,
> + * - start node must not define validation/processing callbacks.
> + */
> +struct flow_graph_node {
> +	const char *name;                    /**< Node name. */
> +	enum rte_flow_item_type type;        /**< Flow item type to match. */
> +	enum flow_graph_node_expect constraints; /**< Common validation constraints (ORed). */
since this field behaves as a bitmask, it's better to change the type to 
uint32_t
> +	flow_graph_node_validate_fn validate;  /**< Validation callback (NULL if unsupported). */
> +	flow_graph_node_process_fn process;    /**< Processing callback (NULL if no extraction needed). */
> +};
> +
<snip>
> +static inline bool
> +_flow_graph_node_is_valid(const struct flow_graph *graph,
> +			   const struct flow_graph_node *node,
> +			   struct rte_flow_error *error)
> +{
> +	size_t node_idx;
> +
> +	if (node == NULL) {
> +		rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +				"Flow graph node pointer is NULL");
> +		return false;
> +	}
> +
> +	if (node->name == NULL) {
> +		rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, node,
> +				"Flow graph node name is not defined");
> +		return false;
> +	}
> +
> +	node_idx = _flow_graph_get_node_index(graph, node);
> +
> +	/* first node can't have callbacks because there's no item */
> +	if (node_idx == FLOW_GRAPH_NODE_FIRST &&
> +			(node->validate != NULL || node->process != NULL)) {
> +		rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, node,
> +				"Flow graph start node callbacks are not allowed");
> +		return false;
> +	}
> +
> +	/* all non-END nodes must have edges */
> +	if (node->type != RTE_FLOW_ITEM_TYPE_END &&
this statement does not check edges for FLOW_GRAPH_NODE_FIRST node since 
it's type is 0 (thus RTE_FLOW_ITEM_TYPE_END)
> +			graph->edges[node_idx].next == NULL) {
> +		rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, node,
> +				"Flow graph edge list is not defined for non-END node");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
<snip>
> +	/* Traverse pattern items */
> +	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
> +
> +		/* Skip items in the graph's ignore list */
> +		if (_flow_graph_node_is_ignored(graph, item->type)) {
> +			FLOW_GRAPH_LOG(DEBUG, "ignored item %s",
> +					flow_graph_item_type_to_str(item->type));
> +			continue;
> +		}
> +
> +		/* Find the next graph node for this item type */
> +		cur_node = _flow_graph_find_next_node(graph, cur_node,
> +				item->type, error);
> +		if (cur_node == NULL) {
> +			FLOW_GRAPH_LOG(DEBUG, "cannot traverse to item %s",
> +					flow_graph_item_type_to_str(item->type));
> +			return rte_flow_error_set(error, ENOTSUP,
> +					RTE_FLOW_ERROR_TYPE_ITEM,
> +					item, "Pattern item not supported");
if _flow_graph_node_is_valid() fails this rewrites the reason why it failed
> +		}
> +		FLOW_GRAPH_LOG(DEBUG, "processing %s", cur_node->name);
> +		/* Validate and process the current item at this node */
> +		ret = _flow_graph_visit_node(cur_node, ctx, item, error);
> +		if (ret != 0) {
> +			/* error may be NULL */
> +			if (error != NULL)
> +				FLOW_GRAPH_LOG(DEBUG, "%s", error->message);
> +			return ret;
> +		}
> +	}
> +
> +	/* Pattern items have ended but we still need to process the end */
why not have this tail processing of the RTE_FLOW_ITEM_TYPE_END item 
inside the loop?
> +	cur_node = _flow_graph_find_next_node(graph, cur_node, item->type, error);
> +	if (cur_node == NULL) {
> +		FLOW_GRAPH_LOG(DEBUG, "cannot traverse to item %s",
> +				flow_graph_item_type_to_str(item->type));
> +		return rte_flow_error_set(error, ENOTSUP,
> +				RTE_FLOW_ERROR_TYPE_ITEM,
> +				item, "Pattern item not supported");
> +	}
> +	ret = _flow_graph_visit_node(cur_node, ctx, item, error);
> +	if (ret != 0) {
> +		/* error may be NULL */
> +		if (error != NULL)
> +			FLOW_GRAPH_LOG(DEBUG, "%s", error->message);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* _FLOW_GRAPH_H_ */
> diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
> index 8ba6c708a24..99ff3c990c1 100644
> --- a/lib/ethdev/meson.build
> +++ b/lib/ethdev/meson.build
> @@ -40,6 +40,7 @@ driver_sdk_headers += files(
>           'ethdev_pci.h',
>           'ethdev_vdev.h',
>           'rte_flow_driver.h',
> +        'flow_graph.h',
>           'rte_mtr_driver.h',
>           'rte_tm_driver.h',
>   )

-- 
Regards,
Vladimir

