Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9D0C9830E
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 12:42:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61DD7402D9;
	Fri, 25 Sep 2026 14:42:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id C5DE740294;
 Fri, 25 Sep 2026 14:42:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790340173; x=1821876173;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ffra2HoFJP1HwAh6KJlKkAgppfTIjQhQN7jJeVdFd6I=;
 b=PKTHhqelESs+bssBCCFDp/raVA0wKD8u9sKfA7vCDWW3JVm2XVwAYGyc
 k3XsoUoEY7QOeXbVP21JJIqh6HKISIp8k+Grzy8BeNoR12ad29XJ207eW
 31VbYHeXNAOHoKbmtE/mToSSsTqdfo8IKKTTeeYGhCMzR7r8WKYLuS9mI
 35VBScOiIdyFZT8NxWnHKbcZmmUfUMGswNznJmP3Y8NlgyD4NoacOO6Wv
 9KvWFREgp81lM1l2gz5rF4DXkIV92zcVcvljR5R2A3D0TVE75Como0m71
 qVg1jxLUFgvavzqeKdtUmE1PLyseaFeThp6jUfkkeWY3KHgpT611PnRNV g==;
X-CSE-ConnectionGUID: xYO/D3uITG2ZSJyq+8662Q==
X-CSE-MsgGUID: uxUMUFe7RLalFM26It82HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101297014"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="101297014"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:42:51 -0700
X-CSE-ConnectionGUID: Leiwm6M6SA6L9pvE97ti1g==
X-CSE-MsgGUID: CkAUiIH1Tla+TorH3zKlZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="300597398"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:42:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 05:42:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 05:42:50 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 05:42:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/1ITuu5Rwh7VbfmMQ3To8iF7a6X9m8BhTymDIgj8e2vCDIKOs7VEh1B73hU8ZN6d2SfqT1ewwzOIYTiOA1Fr7c4Y9sV6LBAZCi+bcRXeeqwn9QNLLDKqn78U2Eg2vyDvuhKg4b4yjEDFweK5Fd5BDTGZUloOcA46xOMQv57b44Ek6ObXNzbVOqYsEipEUPu06yxhSWQWvY9qzonP2FwP1ybinMNd7ID8rlKFexToeEm+qNfc4MA4tQsj+I0QR537gqlv38DC/5qSFcUTp+T2FsOnltJG/DT1RgjV3cvWZqZF3N57ahUKP7gaLBuSieLHwktb658Qm/nbYxvlrI+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVCGCxnEDArQ5oKYdUFyVyir4qANNvdv2njvyxkltCs=;
 b=GYClpjSTfg8P/KGCgGCK0GADyl80CxZ6lcrX+5VzlO6zYIrFi9fPpt25OuFNM4Tpos+tCPTz7zEpjUflpBBzoRDw9wYKksdrMpM2WeJVrOBRgs7bxstSlk0Ocep0zE9ulOX18gTBOSuCavGdpe5i4k+3edirkebieGX36fVtypBqOW9Vg/Ci0dLWfZmpeYvHCLvqQcENeu86i7VnxbE9VFKJGDtTD3CJDNEvkNCgWYbzi4bt7LFM12SwP6hmllyH0ekelLQMvTENxqUJuzpg7+XQMiyDbjP40/y6+hLPN3eg4OR0w6O5rt544DyxNv69XOxMIPt+iefPuWVQPZ64Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM4PR11MB6215.namprd11.prod.outlook.com (2603:10b6:8:a9::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.16; Fri, 25 Sep 2026 12:42:45 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 12:42:45 +0000
Message-ID: <2f2f7272-5ade-4410-a8b7-05a035a06842@intel.com>
Date: Fri, 25 Sep 2026 14:42:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] removing the next_type enum
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <simei.su@intel.com>
References: <20260915104617.467149-1-Evgeny.Sokolov@infotecs.ru>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260915104617.467149-1-Evgeny.Sokolov@infotecs.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0129.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::12) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM4PR11MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c11773e-0c39-494a-e3e9-08df1b027f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: RsRr3qaJmev6wRZfNWZTwPDXGZfE83iZ90sy6pSO8YM1jLt+pzZMbPubSj6qFZaTicIVqRkQP7A2WB1m5QkhLF4BS6IZn4YJtWX5jbChcNFDGXMA6r6JMuCxpLuPz6v7fWu8Nx2JxcNQgVao/OxhVrcAOGWH/I74DyaZYrKwKgWEkLVHs51CDfiK/y8sIeydWCRWdt23yIQioSNdASAdUEDXcyGC/HgRH08gBNPeXuTSHjOWr9ukCPb6f1Pd9DWrARt0H6lDxSGy5I0J+RB/BMAQQQQaNQL06iUdr7XTaUnqaw/g6huKt9kSbaZUMyiG1gEwZr4ORyybj94m3aTv2iVkmjZe0/QRyGEMu8qBnoKceQdkCbMKVyZQz5TW38zU4I+LjPSO82wBdQd/DPMLW7kIu0Tpa06rgsWbHzs9Gs5KuMgeIe637tU0UaD1tYMzllwFxzs+FJcTM+Ju6AM0ugjJjEs2aoth59Hou7FOqhhYhNqs+zP7gb/nKRrIs/ohWcFrgD9XhwCG3wxsGlfJXVhwVqdTd2nRuMqPFzE1s1xXmmnXCG28r06APhRelSkRCAkP0oD4lGDTC3PXSXamDNdpDnIggN7Mwv1Mgjs2nEfWVULRIwMVYEb8Qgxx70b6KTI4H7p0FO7LxJtXh0B664hjpeW6iMzf3CgW3PxChd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm5ibFhMZ05ZRHNyanBrVmtNdGN3Q2ZDVi9ha2lkcWErdy9iRUlVM2pSaEg3?=
 =?utf-8?B?eEltZS9xcHJPYmFiRnlhUlJaeFNEcW03c0xDN3hKeThoTFZ3RWJLK2FmVnNi?=
 =?utf-8?B?WHJkWkVIaFFJcjBBM1gvU2k2N094cXZxbjgzVDRwQlQzV0VIbFVnUVMxVDk1?=
 =?utf-8?B?RGttS0ZrMi91ZWpVVngrU2dkaS9tTUdEN2tHKzh3WFlvZnVuTUpJa080ekNQ?=
 =?utf-8?B?R2tYWW1haG5Ja05ROUpWVXVnTUlqUzJHMk9iOGk1elJBOE9Hb29YVjdiM0dU?=
 =?utf-8?B?MmJFU09nRVYzbWZwZHM5dEk2TUgwRzR0eFZ2VXZUallYMDV4cGVHOGFaRlhP?=
 =?utf-8?B?aFlhdGlTZ1RVYTYra2s2Yjl3MUZiNXJpMmdBOUJsY1B1L0JjOHhyTGxHOHNt?=
 =?utf-8?B?RXRqdEovQU1ZRlh6b29yY0k1YXA3RHQwZmNyREMvdkFSc1puVm1LZFlFZHhJ?=
 =?utf-8?B?ZlV3cjJYWjV4RzBQd0c3UDExTXVQNW1ubjgzQjVTWFNCZm0wSjc2UkxlbWVz?=
 =?utf-8?B?Q2dBbFRQc2hieWQyek1YTEsraXorZmYvSDkvWFI4SWpQbGtmclNkcG9raVZI?=
 =?utf-8?B?YndRMklMRVhXV1IvYkZpOTdJTzFaaXRXQnJ2UzlMNjhjTWxGSWlhdTRNMS8r?=
 =?utf-8?B?MmhFQWpUVDFsU1pSbWtPcTBtWXJzNXVIQ2ZUcy9rOVlZOFUrbFpVR0dEQmE2?=
 =?utf-8?B?QVdWbEt2OUlhQUkzUDRjd1BzZWJZODM0UThTZC9FNDQySDVvOHE3R0NRZ28v?=
 =?utf-8?B?ZFdubC9PL3VQSmFqWUE4Mk1SRGpQNVZKd0tDVEZRR2k3UXExUFozenVobUl5?=
 =?utf-8?B?RHliWG1IT0hnYXljV0JhdkN0TllYV0xSUm9uZ0FGVkVNeXZEcEVHdVBXNnNQ?=
 =?utf-8?B?UmlEeFZMa3FtbVhZTUlDSXU4d3kzV29tbXljQzEvNUNJZXRubDJ4YU9ERnBh?=
 =?utf-8?B?MGJ0ekpGb0JZTHpUUDJnRTcyY003K0dDa2M0NGNUbVFMMC9wb01kZlJIMnhZ?=
 =?utf-8?B?VzBRVmxaZjJwVkdCQjY1Ty9peDJldGdQK2JTT2dyeEQ5NFFBUGw5QXNxV01y?=
 =?utf-8?B?RFpKUlBVUVF3Z3R1WFJHMXI2U1luelVjUnc4ZElKMWlqYVUvV0hNc09UVUt5?=
 =?utf-8?B?cXVoL0VWcUJVVWpBVlZBN0RlbEpka0pRazhGN0hCZDFwbVlnVmlXUTcrZ0F6?=
 =?utf-8?B?MWxNSEowL1NUbTk3VGJjaXhtbk1YV0xyei8yRkZoeE13aFNHcm9HMCtzUHNN?=
 =?utf-8?B?MlFxNncwN0VYR2tac3NpRWVyUEgwMzBWVVlLMkJNOHRQZ1ZlaW5YZFRoZk1k?=
 =?utf-8?B?bS9QVFVtR1ZIeHVGSEpwVExtdFk5TGloa2NJVjYxek8rYi9oeDJkMmJBNlcy?=
 =?utf-8?B?T3NxK3JXSE1hVUdwR2wrY0xuQjN2UFJ6bXJpaGRpeXdFdHN3aWtvdzNMa1VX?=
 =?utf-8?B?Z1I5d2R5VzZ1UWVlMlpWdkFYcFRZWWpHRVgrR3FSSWFrMi8xN2N6N3FQRHY3?=
 =?utf-8?B?TGxhTFJsTEtaNEt3TUtMekpTTnA2YTA4Q2hFMXBJQUNjL1QvRkVjMVFPTFQr?=
 =?utf-8?B?VUlCYTBwcVJSN1ZmZHVVMllCby9zaE5jMXNuL2NDQTJ1SWIwQ255TksrMGw0?=
 =?utf-8?B?eENpODZNR0krWStvK05FamNuNjc1aU95aWprOC9FT3J3b3IyRUZ2b2V3TDd3?=
 =?utf-8?B?R3VrSm4yQmtiS3E2QU91Tm8rWkNOK1VYK1IxS01KUnN3RldxT0tpTnduMldn?=
 =?utf-8?B?V3QxT0p3Rm9WSXY0MmQyQVB6UUJra21JYW4vSWJobFE0MDR0L3NrZ24wSGIw?=
 =?utf-8?B?eVA1YjV2UXMzRFhUSU5rQWhFSUVOTDNLM3E5L1MzMTg3TXpEL3FZZUNUS3Fs?=
 =?utf-8?B?NEgyNDh1ZkI5K3VGS1hNN1V0Q3pkNURnUlY5SW5zUzVxM2dpQlA4N0F2SGMz?=
 =?utf-8?B?QjFQNERKaktBWlg4L3FhSDdkVHZ3VjE1TkllSzVzYjhUUDlVd2V6bEg2OTlW?=
 =?utf-8?B?YUk1eW9ValhYa0s0dVRmSGVZNWtFMVBpWm4yWjRBZURseUYybEEwb3lZL3o5?=
 =?utf-8?B?Wmo3ZU9pSkxhRGxWaUlsTjBUaWRvWkY2QU1MUGIzOUZDS0hDblF5U0Q2dDV0?=
 =?utf-8?B?NDljRkVadHJOTktCMGhIZFA3TGpnQnBjWFNoM1V2c01JVVFQZnpZNXlTbFlX?=
 =?utf-8?B?dGtPQUwrZkw5S2NoRzNYQnYwb09kVEcrVDROcEJ3YzcvaWt4OU5iK0QzUFhn?=
 =?utf-8?B?TXkvSUFaVDNqbGVvV0RiMWlmUi9NOHdtVVlPZ0FiREpXK3ZWRGdRS25PS1NV?=
 =?utf-8?B?MEpidlRIcDh3eGR1NkdZMGp6ZDZzWjR6VUlPQkp4dUdWc05LQnF3TGdIRXl1?=
 =?utf-8?Q?shOPEu13JURf6KY4=3D?=
X-Exchange-RoutingPolicyChecked: SNs9Pq/X/xA39Q4uXQDvgP8EdQ74snJlESY8cjyaWbybhS+BSQoqlGQc2KaIz/Bt5giX9SXVsYkWm6xv9x5PQbuXn9xkfc+lzO4aB/3QbjtfUEVs8+VHkNkr0MM4z4md+JOmm4PnBJ01PJIJpavtfRgctbpxmy6FUfQTaY4ZSJyGgg4ATwQrrI6x5GgtNtqgYe5Ao46eFqmw0Vdd5MqjN/l0S1rGTHP3oYORV5IdMC3/Iz8/lLRStHVCh2S19gJ2w03MSfY/oL8lxfR2dJk4ZhTft7IhkDQhi8IK7tXxlF7MsFiTUwUZO3iOR5yswiN1ziTWt9gNaSeHsbsmgjTjcQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c11773e-0c39-494a-e3e9-08df1b027f75
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:42:45.4129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUy+006XGpZ7ve3lXMLxB8BJndPILQK2+SV8PHJlhhQaISipnMkWawtjXuO51v1ud4D2r8WwszyqlQgBJBIAHOg9ORzCRD0n42FNTAXv6wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6215
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

On 9/15/2026 12:46 PM, Evgeny Sokolov wrote:
> From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> 
> ---

This patch is odd.

First of all, the patch headline says it's the third patch of the 
series, but there is no "series" here, it's just a standalone patch. 
Please use appropriate git format-patch/send-email command line 
parameters to send patches with proper threading if this is indeed part 
of a series and not a standalone patch.

Moreover, there's no commit message.

Aside from general commit formatting issues, I'm of two opinions on this 
particular change. Specifically, I think this:


	if (next_type == RTE_FLOW_ITEM_END && ...)

actually looks better than this:

	if (((item + 1)->type == RTE_FLOW_ITEM_TYPE_END) && ...

because there's way less visual noise. So, I would keep next_type as 
local variable.

However, if the intention of this patch was to get rid of the three 
places where we set next_type, then I agree with that direction: we 
should only be setting it once. Perhaps we could set it before the 
switch statement?

-- 
Thanks,
Anatoly
