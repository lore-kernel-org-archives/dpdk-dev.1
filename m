Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D8ACA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:28:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84B1A402D5;
	Sat, 10 Oct 2026 20:28:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5354E4026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:28:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791656915; x=1823192915;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=EgzaToEDv4KsL6xQ8zFp6+X/QRGathoZ+HWETu20EKU=;
 b=LLSHeb1jboDJqFmsOPadyy/S55XoLQ9Qj+KC6Pz4VkvdibHDdl3lTSPA
 5K9Y+AxVHXVSZ3Cl0W7tcroPR5RZgnYdlBSjBEuuy7cO802T9WA5+uj05
 zoQbMsegw7ac9keRNz6xKFdw2db3+el5KTgYkQRhjeR7oVA174jwCcxS8
 hJyhcDT5zgTl+IYUl3cHH8SQqjh/CmwsIvUYt2mLf+C7JquX0Jc7QQdKH
 zZExPqxeNXTuOo4U+1TysVSo1ytlbpt8ST56T4Zm8n4FWBxDGqBT3kBrF
 TvYu7kgBkn802bJHJN0F9ruIM7rSlSo6c3Ligd0qkY/8DVa5OFQMQT6FK Q==;
X-CSE-ConnectionGUID: M6/clM6WRne//aJnyyG4ew==
X-CSE-MsgGUID: Uk8ixGEbRZeEIxfw9pOTzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="312144"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="312144"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:28:34 -0700
X-CSE-ConnectionGUID: mQA7gdDlS0aitO5uVLm1QQ==
X-CSE-MsgGUID: A+ebVUWyQPKpFKu9F2JDzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="652149"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:28:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:28:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:28:32 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:28:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVV/hEqjk02Mx3/cYPY64Pn9RiVl7JKRv7LKwkrUkRH3xW0Xewk8q9v0+wSlCBCOGLMoKAPu2J7rbY+tCeo58L5OEtev/FS5s3M3Pf6f2abE9SW7QzzpJgn6opelG3FPQX23gw8iVUoD427UsqitjdDBWmVNYa/1F0Z9UqQcIPGJOxk11szKtdoUpRYfzj9snn+quFFrZYJln+yJdhQW8f7p2616InNEQGIX37BRg+1qEMuqaxDg2UoYxyIExu6RXLSGBr7K/gAdrUdQ2S9V/B6VF4GeziMbTjkwqEPZZi2/2cBd9zFBZ4a4T8OpMyqbVWmEN016mE4MOokjjkA4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVWtRdPZY4UjJrQpAbLfT6uOmWfw5XUI0JzpoL882p4=;
 b=ckhWAQLpzBY1fR3uRQBSqMmDCMn53HkZt94t+Bo6R6B3Lc7g8JZ5nN9OzKxuZTsk05JvE4+G8NohASDcSUEyTdxwBMUuj5+xtSnAwzx4EUTSOXV+3HReXgo06kjpHtEF+4ug8oWEUo2DtE6v55h4AVX7CamumWbHO1BKC+LBMumdiM1gn3oH8y1KxQc+wrOP0RK35UtMw224qDpf2JfUfD9CCNWpMbNBKDiHe7Kv5bagAApxi9x2/h6Mbi9xbvr42OcluZy+8/SCdheWciVm00mlki+GvRpq/reLLX2LGhzCwgFTWbrQolnQiMCmMqlNtODjKDVmK/Gk+tMle2LKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SJ5PPF524F3F9FA.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::829) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 18:28:16 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:28:16 +0000
Message-ID: <167a15d7-3331-4314-bf5f-94dd76e1cdcb@intel.com>
Date: Sat, 10 Oct 2026 19:28:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/25] net/intel/common: add flow engines infrastructure
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <aa7332562067ea5a4d016176f6975f5812468c9c.1791543154.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <aa7332562067ea5a4d016176f6975f5812468c9c.1791543154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::11) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SJ5PPF524F3F9FA:EE_
X-MS-Office365-Filtering-Correlation-Id: a461aeda-59b2-45e8-523f-08df26fc4076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LX2m7yfyaD7vraaNwLG8oHYrypFsxmGipknZ/6EniU5IhediEQbVj6nJx6skhq6lv4LOPRwMxReVj5Ta0y+ZdpN5RJsviT3C3EOzGwr6Bh/VTw5kk7j/qlXjfyqISecFFlEzaLeHqZirScpre4/mz8SSvek65/C46BRtWfLcllA5T6BfxvQEYw8yfc1iHV6TqX9tpiQslS20luMLloPc4frRrPpLbhSMiQ39UG/g0FcK/EfWEpyOfPr4OiulpvDG0tMy6/HlBiM2Y0XeKykEUN8nHqIkSji9+haa2x/051gHuff2v3vEr7rUhsfE6Mug9CR6qBrXE37JAfWHnA/pS1cXJo7CzT3CVlipIAKXX4XT/0KcS7yZvyCKyzObegjDHrWOrMzB1EkRmTqAXxbCrRTt2a+jFLg/Ln1EzwGxAidRv/0fLZbwFD8YZNFfQ7/+gUootrBg0Zj+ChRjqdYm+N+VDwipvpT5/RneJ0kYHNf1ywd9AkfiSPOgjOV/O9wLA9TkLGuWFwmfxOAbw1WvvzkKSx1q/4CzI5URQy4Q5lEzKHptkgjqzcsOQu0F57zdthxfT5s9qhjfB2SIcwizAvJsDtI/9/ar0aXbsYRCwDRBmoVPyy5cZvHjNyoTw3qkij80Yo+LBd2GyfY/m7ojxhpLXlzKvW6y610HdUuZCso=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEpLTG5scXV1RllkYk9tZ2d2VzdwWjZONzY3ZCs0T2hvNXFEOUpIR1ZTVVNl?=
 =?utf-8?B?V2ozcWFGMzhVbjcvSkNRbEtUM21WdkNzL1VQNEpjWVZWMmc2MittaHlvVnB4?=
 =?utf-8?B?VHRuZkJBRW52c2tYMzRCY2g2bmxjNnowSW5TVmhTTHVJUHc3QW5yaWlXeG10?=
 =?utf-8?B?SVl4WCszZFZqMlJPc1pXa1JHclZTUW9uWklBVzlPOW5tTjVWTlAxYTRxbFRt?=
 =?utf-8?B?QzN5U2N6blM4OGFkcDExczZZYkJ2cDJ3Q1RSZVdsQW1xVEJxMGpnVXoxNkta?=
 =?utf-8?B?ODNrSGNqaEdoYzl6VTQybXdOMFhvOHZzMVV6QkFiS1hKcHc1aTVrRy9jMTBD?=
 =?utf-8?B?NkFNMk9lZFM0SWQ3MkdLNmlMVlZucExjR3ViRjBoRmxiK3Y3MElVcFV5SEFa?=
 =?utf-8?B?RE9QbTZKT1N2cGErTEc3SVNUM2xVaGVhSWRyRlR6TVc0b2tZcW9UbVl2K3BN?=
 =?utf-8?B?TnFsVzV1QUNsWGtQVk1yOFdnMW00YWtBVDc1MnYyWmc1RmhPZnFDV3VtbVdv?=
 =?utf-8?B?dGxUMDFtZU5lL2xBWm5vbUxidTIzYlp1eUhhSEhCajBqVXRmZnVUdWRiV3pW?=
 =?utf-8?B?VTdTSkg1VHY2M0FJQWZDV1Q3ZmF2NjA2ZDUvRnFtZVhvTzRqV0dhZFNGZVB0?=
 =?utf-8?B?UTFuV3NNRnNnMkJ6L21CejVKWWtnMUI1YndoM0g4bjJKeGIxNXpJbmhKZ0o0?=
 =?utf-8?B?bHc1WTQ3K0ZNcE0wYjZ6aDZxSFVUVWRTcmFlZ0ZtMWZLeWRnMW9KVjdsRXox?=
 =?utf-8?B?ejhXY3YrSE5DS092UnRteDlFWFIvVnpuaTcrSEtUWTFxVmtVSVludjVNcjYw?=
 =?utf-8?B?anptQTh0UExxZVdkbmIvQzNteUtiTzhhMVlmUXVaWWNWUCt3ZTF0VVdNc2JY?=
 =?utf-8?B?VEdkeVZYVllsLzkwWDdiRjUyaTFOcyttY2FTTGcyYXJZMDU0djJIT1d0ZUM5?=
 =?utf-8?B?TjZUVVoySm5rMWtSWHgvZnFFRDVldlo3NXVIS1hLWFEwR0RMNUNYWGs0dk1O?=
 =?utf-8?B?djdoRE1hZm51RWg2TWxiSkpPKzRyYll5bk10UTJzZHRtQVNZb25MUXpyNDQz?=
 =?utf-8?B?MEVBblU1cnB1eDB3aXlSSGlmTEh6WGFScndwMlNNRW02bnZCZmpVWUpyakxP?=
 =?utf-8?B?SXQxL0RiVG5YRHNuQU9YZnVsMHNwOVY0dndvRys3dlIzUWVZQ1NGYnFBMXJz?=
 =?utf-8?B?ZjEvcngzanJPOUhlazRNOEFCalEwc0tGTDZ4aXhPNHBRLzdrRCtkSG91WU0w?=
 =?utf-8?B?VnpRMjhON2VGSEJ6aG9jcDRDZ2FnNm1DM1BhR2FLT2RwVlJ6MHJoTXJ3MEU3?=
 =?utf-8?B?ZXFiVXVON2x6ZUh6QU9panhWVHlGK2FzYnVEenNJNHppcjJRQXJ4Rk9aMFZk?=
 =?utf-8?B?ZU9mejYzQUM3NTBMc0V6ckFKVUlRRi9kTUFFQmdXVk1lREpISFNmS3lJMnZs?=
 =?utf-8?B?YjRGOXhQWi90WEpZTGVyUjY1RGF1WitoY25LdzRKbmJxM2lVZ3FSOENYakoy?=
 =?utf-8?B?MTltVENRdFQzV0ZjdDU2S2lqanNZNSswN1FIYkV1TXk4bW1XYkNwMEpHcUJB?=
 =?utf-8?B?Y2Rmc01sYzZZYzRsZDVyUy93WFFST3pvRTlEVmNvWWpXWUwyZ3ErcUF4SHR2?=
 =?utf-8?B?ckI4czFXS3pOdWFwQVVxZnNRVWI2ejJvNm91bmNRdUw0WGZsT2g3T3A5ZktO?=
 =?utf-8?B?dEEvTEFsTVcxV1g0Qk45UStwc1dyTHhWZXh3MW9wSWg0bE9YYldyMEFYRHNO?=
 =?utf-8?B?cVJpTy8xdDV5WFpXbDZuZWNyVVBOK0taR0JyMVlFTHpvcy9Vby9vbmxGb0xh?=
 =?utf-8?B?MEVPeFNyckJ1b3JCcW9IRENRTEtYckhoY0hTRDhyT2NLdDE1bWN3LzJjWlRG?=
 =?utf-8?B?YlRURUYvSkNWMWszbnZaSU5vNW5hWUl0Sk9zd3czcFJMT25TM0NYYmNTc2tZ?=
 =?utf-8?B?VnJkUzBlRkJrWHNzY2ZDd3ErVTVBQWxKRE9zdVZQdU1sYXJVMDNHbzEvY291?=
 =?utf-8?B?MVMyN3YxUkdnbmU3ditqbndlbE5CVGpYTUpXQUpYUDFNTFBFSllVZDYxdzFv?=
 =?utf-8?B?VytmQXRqdzA5UmlWUi9WVEZLbEZhei9yeUQwZTVQQncwQVJJMng0NGY5R0RZ?=
 =?utf-8?B?b1BVZDdUa1VzQWFjRUxiZ0NsbTI4TmVyUm5hajBUY2hMV21Kb3dIdWZLdGpW?=
 =?utf-8?B?ODBYb3NIcXZOdGUyUjBiKzNVZXRZclNNaVFTTWg0WHd2NkJpY3ltb2x4QklP?=
 =?utf-8?B?UlVYV0xkYktmVnNTTWs0cmtaZEJvK2s4U1JQbzd0WUJoNGszWllQUThUNjJM?=
 =?utf-8?B?Z1daUWZYVUkvUUdIWnZkcTVYSXFCUlpyK01mWG1nOFZPL0MrNTBzSnFibStO?=
 =?utf-8?Q?XUtsQrorSsw7VDRs=3D?=
X-Exchange-RoutingPolicyChecked: MumHSFLJ5F5fNFz9yOwhsHtkp5bnuwlLLNBAEymct1G0kwgibX4JIUFeQYkAfbPQy8rBzHW1PbFk16SXh0NsMxkIIqVKet9jflxjAA0kttSoFYdJrdT7lHcb9PA4rrc4DX3Sw6cyUQcs2tGdlhsHli5Fc1BCPGJsSxN6K5aB17OdJJ35KZgFd9tnngUdOa6ZWZH8WV3WAFTkL3vEdtkRySq+wkhZFRWDqEK8EUEXLdWbVhig5QsNfNDve+xh42+/+Ju38XfJuZ1CJi2l5ZYYvZUuaC1kjxnH5dtbcwHTUrH0P0CVtjrGZqeXnbF3ByC2SqOjMAo9r/721WZ8Dr4d/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: a461aeda-59b2-45e8-523f-08df26fc4076
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:28:16.5902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1jFlQ7fuDV7GK0VrX23cmorg1xQqO8v+66URSR7jrjPymIutBJuzwVSLo3Le4rb9/kxGAYabX9x8bu0LaXaPBYtBTBY+DICyRZGY/DmNoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF524F3F9FA
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/9/2026 11:58 AM, Anatoly Burakov wrote:
> Current implementation of flow engines in various drivers have a few issues
> that need to be corrected.
>
> For one, some of them are fundamentally incompatible with secondary
> processes, because the flow engine registration and creation will
> allocate structures in shared memory but use process-local pointers to
> point to flow engines and pattern tables.
>
> For another, a lot of them are needlessly complicated and rely on a
> separation between patterns and parsing that is hard to reason about and
> maintain: they do not define memory ownership model, they do not define the
> way in which we approach parameter and pattern parsing, and they
> occasionally do weird things like passing around pointers-to-void-pointers
> or even using pointers as integer values.
>
> Another common problem is extremely convoluted internal tracking, flow
> installation, flow replay, and cleanup code. This infrastructure is usually
> done in an ad-hoc manner that has a lot of boilerplate.
>
> These issues can be corrected, but because of how much code there is to the
> current infrastructure and how tightly coupled it is, it would be easier to
> just build new one from scratch, and gradually migrate all engines to use
> it. This patch is intended as a first step towards that goal, and defines
> both common data types to be used by all rte_flow parsers, as well as the
> interaction model that is to be followed by all drivers.
>
> We define a set of structures that will represent:
>
> - Defined rte_flow parsing interaction model and code flow (ops struct)
> - Defined memory allocation and ownership model for all engines
> - Scratch space format for all engines (variably allocated typed struct)
> - Flow rule format for all engines (variably allocated typed struct)
> - Engine definitions that are compatible with secondary process model
> - Implementations of common rte_flow operations
> - Various supporting infrastructure for parser customization, e.g. hooks
> - Support for using custom allocation (e.g. for mempool-based alloc)
> - Support for replaying all flows to restore HW state
> - Support for removing all flows without modifying HW state
>
> The design intent is heavily documented right inside the header and is to
> be considered authoritative design document for how to build rte_flow
> parsers for Intel Ethernet drivers going forward.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>
-- 
Regards,
Vladimir

