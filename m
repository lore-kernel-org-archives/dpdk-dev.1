Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7FED49238
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 15:30:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5D254028E;
	Fri, 12 Dec 2025 16:30:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id C1A5640268
 for <dev@dpdk.org>; Fri, 12 Dec 2025 16:30:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765553442; x=1797089442;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WnFuMkyW9H/+w2M5noeYgWR9LiYVR/MALUgc1FWbWCs=;
 b=j3mvS2kUnl88mWTkY43wl6oUcuIN1gw2w0OA4B3bSZivbiUQaJBlQedJ
 lgGdltw9Ofz50PwmWsQr/RNVVnPIL6Rdcd+YZCL6WzdvSJYieRzeK2drU
 RxiAGIAfiWXdGxdI/eg3pC3etzfTrV07zqyci9Dx5/ltFCo2+k4Cez/AA
 0SdlOkypAO/1fBd2U12GZc2Uqv/aDwmG6cVEUtp+bU+fv/MglcpPvCF5j
 s+O6FN5+EVZyfFBSHezHhKu5kQNCYTd7j+xuMtAhSEpfh0x6az5G4Wjo7
 7xrUw/HA7IKuNQSCfq5H170G2wPM9Nn1igXxws2XgyKZiQLF+WD6ImJYP g==;
X-CSE-ConnectionGUID: j9bw0bGLRgOoSXVYQhKNPw==
X-CSE-MsgGUID: kyjpTUTVR6uZPdbLZp7T4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="67440430"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; d="scan'208";a="67440430"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 07:30:41 -0800
X-CSE-ConnectionGUID: jT5DfkRDTpC4hmluXUzmUQ==
X-CSE-MsgGUID: 26/yBeqDTOSsmJJaYddLbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; d="scan'208";a="201590683"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 07:30:40 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 07:30:39 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 07:30:39 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 07:30:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvDAc2Gvopu8yV/BovhCHWSayHNBTBE6SnRmuhjXnvVVnbJ6iktuWuQJ2X8aeLjsAs/AifXVQve+0LQI8jpoclLE+KEmwkZEogoCtbC1xeFmLzu7NiC3BHWocGKk8jaCfVgkp1v9Xx5g2rkFtWCdTNutS7EXaUFu5pHnzUUL6iBu8SZ7EwFykY/p0ZsFVxYYBLMJpF7ygtXYA1HRrkcebd20ByAhQvo3RySQ7cTWpqhKWBDQnvAninagIvUN9LPQCukeUZey6Cgeeni40qLxha2WbD89ifEkbRImKF122Q7KZIy4OfRv9qY4JlPfrrGlU9D+8kNP/YjDwsmRlWO7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyX+n8X69hS2qltylMW645Nl+tkdalcyBQF5Wd286dQ=;
 b=k+wRgMf+4rOVRuFON3AIH1kewSn8imRlfALRvo8x9TBMnPsjsUX8KvQOLCxt5GRlUbKKOmqVvGPmh03Iaw62HN6Vjx8VYDLDW9uv6HqDkR3rJ51xQpR34g0VsKkDL4DSJsub58NPCs4oLH26UmJXvNqQ/XGZq9aGmvO6xUKESVbs0pkt5uzQJuWoBmsEnq5we0cC+1zUhj3AaP/8Nj4Izf6YdtquD/WvXJSRiiLEq/TTN7sMbNrucvYOxygkjFP9hOIOpIBQZmhG+srvTqyCjxOoGZprrzwQ+PbFsgEnazXt2bs1JnfO+bISWyHezosMeh13J8JX8MwdL52NIwxD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7076.namprd11.prod.outlook.com (2603:10b6:510:20f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 15:30:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 15:30:30 +0000
Date: Fri, 12 Dec 2025 15:30:25 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 06/10] net/cpfl: use common Tx path selection
 infrastructure
Message-ID: <aTw1EWfi_tB_AMkf@bricha3-mobl1.ger.corp.intel.com>
References: <20251212103323.1481307-1-ciara.loftus@intel.com>
 <20251212110628.1634703-1-ciara.loftus@intel.com>
 <20251212110628.1634703-7-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251212110628.1634703-7-ciara.loftus@intel.com>
X-ClientProxiedBy: LO2P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 2536bbc4-c24e-46bc-b861-08de39936238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xOdpKRBuoCGw1ndpqrxNCD5NDA16kOKDgYrNLBmCEcWbStz9aFKrNgyLCqDK?=
 =?us-ascii?Q?lS2CQ15Q76SBoogSG9LQmjug2W3Wzs/jFyHGV/lkx+OWFq9Ma6iu4J4nKJxe?=
 =?us-ascii?Q?XwXEpgG65hZ6BSv0ZpCOHh7XwxgyYq8whTOfAAepTwmN5rht4S/eRJ1iu1um?=
 =?us-ascii?Q?lR4gXNe9cnMs0D3U0LMOkM1PPftEOGqloa/WSneL8tTuJeauqCDxHVF9YR+4?=
 =?us-ascii?Q?36r3EzXh6aMBqrDYcZS1kChGqZ5jggJ/gONAOl4RY6Mv5FY3hsOeh507iiFZ?=
 =?us-ascii?Q?pCcrobv13J5naN1Uw12bCThf4uR87CtMRlKW81+TyH2hEkYxcxtn6rfkBUGV?=
 =?us-ascii?Q?cYB0KMr7QNEfRYiCCcE03X5vxdKtRs31OgUxY1OE7X7nlwWqb5kSlw+N54WJ?=
 =?us-ascii?Q?lx9B9hJW+hK7YEo3DLJ6np3P/LrVSnsQ5F3ou2y24ZuPIoVh56TDOs/6YVVX?=
 =?us-ascii?Q?EJDH/dGji9L+oGQad3yMLmfzjm+9Mt79azifeEzJ+KNMn/2R9twa07qcG/GH?=
 =?us-ascii?Q?LiUx/KMPqXh2Ak/qtvaTQFckN7a4McSDK+bCvhqdNZETLPLk8JbmQEzXy4tz?=
 =?us-ascii?Q?4dN2DZCFHZsze0wUaPdiRL7odBfpUiU6QWriBs8+UEHcLL7AzMqM2X0rbXi9?=
 =?us-ascii?Q?oKDCPK6r/iuk0Waaj0kjMfFZKPWzelZX3bFz+lbeGCyWDQ0kLaCXxdCDMnx3?=
 =?us-ascii?Q?/LJI5l8vF0lDiwGRiNcFEoDmVYnCM+PEfEW2dFLbi1K0UQQ+yKN0qq0Skjky?=
 =?us-ascii?Q?fES5HHfgZuZo1KJP3Z7k8nKMKD3PDXl+eN7UmMXIhEzw/HMDubdHXqPrhmcF?=
 =?us-ascii?Q?pXedmIhbdi5jZiIM7xQf/HYkucQQotk7xf1wHwq+f0AqT4eSgoDOR6xjq3Oq?=
 =?us-ascii?Q?S+akG88KPzrH3Rc1tcvjUKWBjlKnvE+CzcNSWSSSHp0Agcx7lDLz8w98Kgy7?=
 =?us-ascii?Q?c9VhsnMGaOD6lH3jXsxZbPNIw5iVowHRMMg/BDV5O5EeDaaGvLcLtzv3GeFk?=
 =?us-ascii?Q?uxofq117eBOaDZx2tBDIKNwFLfFkvRIj1J1DQhHUtFUCeix1cVcKhmgifbgC?=
 =?us-ascii?Q?ijvZL2/gcnBVdVHZtsVbLwX6M6U92u7pobjrnBdImCydK+oFkY9sEbe755RK?=
 =?us-ascii?Q?ST+a2PY8vjtkVAemDi0P0OZ8PY7HU0lpf97GHJrnH2WN8VcFp8OlkofIqPsX?=
 =?us-ascii?Q?OzFA7l7s59YBD5TP1XyMV59+m0gg6unyGUZ72pqgP0UsE2pmD9vSk/cK/PkB?=
 =?us-ascii?Q?YLLspynivvYstsYYzVdhAXDinUTYz0Kg0GWQ0GZFHIlfeOCbFpkDF5ic7XCH?=
 =?us-ascii?Q?JoetQv32H7cZanlOE9LlowelIZLZWmbVqDd+W0KX3ee9ZWAJyx0pYoj8WtPV?=
 =?us-ascii?Q?Kcdqc6usyI7S6ZMuF7fCSMUeeYMuz1cSUXXtree5HGMH1Kt4+gpVRe1GHJqT?=
 =?us-ascii?Q?j9Hn/oXzu5Xy7LnDHG68zQsdHPkh+0IJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EMobItqAxddX7Nc8hh9yxAi6GGGpTHY3z7dBKgNUOgK8Tu9TJa3qjjmyMUfZ?=
 =?us-ascii?Q?Gx30RdL55yMl+ilHoMcGiu6Pmmu7YAWlFmu60mq4QSi994mFcgLUs5PZLnjz?=
 =?us-ascii?Q?T6ZA7AeAhK3FXHOzjqbw2d/7Xl00tNNy2cH05R/KZ/NbHnh0J67mVBUoBOJr?=
 =?us-ascii?Q?QPxh3a+9yOYDoilmMz4n49TuDiVTXf4s/mzQoT7u+CpXkIS2LlImuIU0LlJ7?=
 =?us-ascii?Q?zeRH7jWMOmpqdEINaNRPMi1LG+yt+yNG1BDBpwScWUqqYayed+g/I9B+Xaoq?=
 =?us-ascii?Q?RxmtikR2UputejFXSSExSBiNaxF+1Cdz7K5coxTYM/jY0sMEwbv7rKq3f1ES?=
 =?us-ascii?Q?pzpI1JeUg2yEKcKEZW/Jl/rP7s6yP4LGhoUiAuTffYJxa1BBNt7GQ5DzUbSf?=
 =?us-ascii?Q?9nfq8QXrG26Br0KNXHk54dCmkGOmlHX7BBKeEtWyeRllEbR7GUI4beYTYTqs?=
 =?us-ascii?Q?/KsW1Ior9KMnv0iRByg1ZOuXg7YzjCVolrMt9Qi5JLKzarw/h6EYjc1VwowS?=
 =?us-ascii?Q?udAVOZ5JEbOOGtbrG127I3CcDoXApQdcUMB/377svkjxCIbTkrXjdLkWVuth?=
 =?us-ascii?Q?VWLGYGiBqZN7I/Gzo2tZN9p/eE2heT5GgtKdHd+QBeDfHdUkz99knHxsHpZ5?=
 =?us-ascii?Q?DWlTOKJOr/f8wWgl+SQVC8PB/prEj9cuWcz1rnvLEDnBiT5MqBcOnVF0o0m+?=
 =?us-ascii?Q?SOi1EhcGwK8t0KJgy7O9Brc3rGOuF/uWn/ljf1TBk0r0MaSjVIhX4hpuhd5q?=
 =?us-ascii?Q?YvXK6MLggpSMshfKbmRiL2/hcnfyIQ9yU81Aq/X6KS2dlMT1ipSvohIzp1HR?=
 =?us-ascii?Q?weTgHiPQFhdAlZm7qdZOB5myb+J33WzpMVIoWxpYv+MEFMYwYfFftF+Lue+I?=
 =?us-ascii?Q?clgIPmB1nEOeZm6PNZGNfTyN09Y7rOMNL+XZF6YMdjQSs9ZNatJzTKm1HL+B?=
 =?us-ascii?Q?udp248VWT4TZyjurYrIgdfcaBALqHP/hgJBw5T6n/xRdW5TOKOu8xJqM5PQl?=
 =?us-ascii?Q?1voop209lJk9dJmphsyqU0HpkzuDaib2KFV6RQYMhTQv1NRjEdp9Igq2kfZ9?=
 =?us-ascii?Q?wmg2bwRN1nH28AyUWLSrJOgA5tH6NnSAuKDM+s6JldBIntNBCtVvBp5buWcs?=
 =?us-ascii?Q?0a0ngN/c+3e4lAPu74euSRdgE156E/0s6gZ8M0YXsKNPtIkoat9VWuXIRD6l?=
 =?us-ascii?Q?Aj9ZBJkTm1LaXpg72chRdrfbprlqGsbDxa7zOE/qkuTyOdIcc/uAIbiATUR5?=
 =?us-ascii?Q?Dw8aTjNJiSAgjY5uwcGIZAMDs1GgvvzmSGY2GNfbne9kwz1kFFxyojn3z1sZ?=
 =?us-ascii?Q?j6QQJk9ZdNQdlR3emEoLWv9vJOEf7I3j8BpUJeDlltsIQo342cQynEDTQVHS?=
 =?us-ascii?Q?Agoysfxmxz/b7Sy1NSvNEUGLsHSe/yyVNHoYzJL1hrZDS7AHrOnO1Wtf4tSA?=
 =?us-ascii?Q?d8LOSkwxZMnWdJOCG2UYnht/DvkI3k32/bUJtNF/9if1OiFyYFmbb4KGqres?=
 =?us-ascii?Q?C4/EbUagoMnDl1WUHuvN72RwgP//B6sxXSbE3DAubZyddGnnmUG3d1d7UD2Q?=
 =?us-ascii?Q?RC2l9hWh+cd/9gXQP0fX/+TfreFkqY46xrnZBfwIImyQfROu9KzxCzYEQRdo?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2536bbc4-c24e-46bc-b861-08de39936238
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 15:30:30.5927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhTFhLIzbY2KGE/66dk1qrrUIWmL6sxDZ79PC9vWsH2UOfYoELw/O8D5cBvPdyEzBoOM9HNtXC6QQx3T7FuDc636y3jYWpo9XnieddmcwP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7076
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

On Fri, Dec 12, 2025 at 11:06:24AM +0000, Ciara Loftus wrote:
> Replace the existing complicated logic with the use of the common
> function. Let the primary process select the Tx path to be used by all
> processes using the given device.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
> v2:
> * removed unnecessary tx_vec_allowed
> ---
>  drivers/net/intel/cpfl/cpfl_rxtx.c            | 120 ++++++------------
>  drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  10 --
>  drivers/net/intel/idpf/idpf_common_device.h   |   2 -
>  3 files changed, 37 insertions(+), 95 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

