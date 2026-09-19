Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175B6C982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:13:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AE2B40647;
	Sat, 19 Sep 2026 18:13:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id A39B740272
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:13:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834412; x=1821370412;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=0+TWLhVp08vUq95ose5QJLWXTty3xXtLF5jPVd4ok5g=;
 b=MypH6pdEJDxRbm+l673GxybpO2D2wPTE+z+Kd35EES02Q7p4SEdtwSrk
 bfLHjxjQRyTPqvtxuPTIhfuiro7mMDQJhBoKD7NG/pG9SsGNTeHeG24Oh
 9+Gsz7sYu9x7YNmWPkKpjP00ZYyK30odxV1ZaTyKJW+QSiZelNMfcSkNb
 z3kBB+vw3HQ6PlwEwM20jvSCAW658YHNf2avPP/+1px/cF3JxdzUmxHye
 0VEgHMnZz2N1znvBlFoXvAnOPH+XU3B7jx+Jhip5LleyPJbqT6KkDQNLB
 Oz+rnBQ2mQxKPhuoKvGFZBok8EDF42/mVvgr+tAm59pATS7ZfidKzkYtv w==;
X-CSE-ConnectionGUID: NoW1PEfCSoGwGYo1expBOQ==
X-CSE-MsgGUID: u63SZjS6SvSujYWR3Jie1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="89490955"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="89490955"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:13:21 -0700
X-CSE-ConnectionGUID: 777BKWudTY+l8n2RkIHiHQ==
X-CSE-MsgGUID: lArW4+VfT9u8EeDTqiYOuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="268545739"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:13:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:13:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:13:20 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:13:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EN8+kNHcm2v1GbL40w8XS1OEQEwMsSeuPirblJ+9HH7fH4b+ABauL2udxAF4N0cyZAL+yaJEkPITtjkOFJo1bPrvUZReldBEh18QuXoNS0f1KfDekTU3y+K5Zvmay29TJgXBmyRtNpo0MIaDrOndkl9oKSLugElBDgYoiX2GJTG8UwcfyWZY8KiKJPI7scCF1OUKjzFRZeB9dGYiqdtLaGrM6aaucyhw2r4n6lZAYJ16XsnCYbNZ9is4WWY2qDJgG5nuIEPsSZtTi/WtFFMj2PjxMDHsXOpRml2jcLfYmncD3axLR6MU7NDD64B3UobPVNwN15xLRNpf0grdfwozaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVeVKY9gP2rTeIrD3k8Ps3FSg/Yu/fF2/K6YNQG0/K8=;
 b=arLRPdocoL0qbLYC9YOwEVkDNQ1Zmli65bsUAz6azVbn88H3diCKNpPmMn2bhWOb9vQA4kOW2bKc+dhYC5ZU/oEmSC9iYz2K447xtNSW3NfEzwD7L+oZm1SvtNaoH97wCQkiw/2NRYhwx9c/bebpzWRRL5trTbGrn2+32mw5KSUbgzJfWlV25v+M3Omkt6XSMHAuZWYcixI7Yam3tHT8OAkPafuIx0lYsBkXXI5F0LdOix2+6Zwlwnwp5zEhLr1r1LFCy0iISxCUyhoj/W4+R6MS88dR7lSAq4Yui9AZbfwphIvIvULK2ixWnXB5l5Lf3mFBVa4x5j/FPb0vCC06Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:13:18 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:13:18 +0000
Message-ID: <d4eb9962-2eb3-424f-b5d4-a286e0e6593f@intel.com>
Date: Sat, 19 Sep 2026 17:13:16 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 14/19] net/i40e: reimplement ethertype parser
To: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <71d3f10b3f5301c8f0609794b352f6aa249e457a.1789560946.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <71d3f10b3f5301c8f0609794b352f6aa249e457a.1789560946.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0185.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::11) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 6702f4d0-6beb-4bb7-375a-08df1668eae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VAvsSDP/sDpoxFUFg9LbB4SHPGqN6XApvGyp+cKftq/uH4GnJxgtWWo/5m/qgCQIHWnOPlPo/bdkoNsXRmTxv+u6CJ1RPbeBA6jPdeuZwonWpfRsO4MoasxHFrDOGIz9Yv4o+1CSYgrWdwRLnsEblh43eFJcL2CdjzjW8+ZY3t2iS5rqvk62QMuJtiswGWWS+On6da1Q2n99HMrDhgEheFyeVh0EsnPrdQ3CJIH3hsfQuEuI+52xbiEM7JRG5s7H4k6gShXDQhUxK/NxvjP2eKg8A+Apy8+4BcqhI4b7mD0h4I8lch8b+LcOj/GuiHdCJtfGxke39oZ2s6mFyYVaF7n6Am2PRtZeOKmRXKJJPXLK19dWFiYx7ZvqPn/yKIBBgW2bm65PhZEIVgfFjky/swP0ieEOwmjnTisZTr0KfZpgAfZ12ovoFafAQoeyUIezt6FWDKOzJ7aLfxYQHxUz1ydSAT3Xz98On3MoeDkGYyjmUwkAVimYmCMRmcHpa1NBLy48cE+/IW1vrtHcfmkMk32il31Rboa1jDaOx7HoYm6CUynLf15uP4porFYZhf9qDvY0WBoXD3NslsKze/RIjyPx9QyvjFNaS+9ubEYyA5GiQ0UV9kuKINCWL4yVFjOwcoQcaBjb3BzAcP7AI6CSTM5iFSiHExx57u1BUpzSHOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3dhNlFXRThLUmVpblZrUWdOTEUrTGM5bjNqblBqZXBuUzRDekpiS0p3VTNV?=
 =?utf-8?B?dnNMOTlaTzFDTHNkT0NieURFT28rYTkvRWg2TVFPaDlzZFVzS3RRbTUyTHJH?=
 =?utf-8?B?SE9sMUVxY3o0WWF6ZzhHWnZLVUF4dEQ3dWFPT21qMSt1dm9pYk94cUJJZGhL?=
 =?utf-8?B?RXZEOFN4NWxzRUhWSHRLWVQ2V2xmemFLUlF4d1BIMXpHY2JkNThVVTE2ZmJy?=
 =?utf-8?B?SS80anVWR2VoYlZwVTdMMlRGbTNvbEN5V3dBZm5LeHhGYXVMdG14ZWRjbDJp?=
 =?utf-8?B?d2pnckhWNE9icEZyQnBiK2JIbkVzbTljNk54c2xKTlVZL1BmMWNzaWRsR3Rm?=
 =?utf-8?B?cUNnemFmT1BMeHlSMmthRzNwN1NrNTVkWDlHUVFyY3FhU1BOdzhzOTlsN1cy?=
 =?utf-8?B?WWNIVnJSWVZWK3QvcXZYTWVHQjR5K3htaGNySms0Mytkbmc1SytTWi80NnAy?=
 =?utf-8?B?ZURTcUxFem5RTGpRMjhHbDVobDRJWk51YnMyNVpvcWU4YlhKNlg3TjhjUi9a?=
 =?utf-8?B?MGNIM0x1TTQ2dk4rWEJjTG8zNmM1ekg4OXhyVFp1T2ZZYWQrU2pTUkxXa1Fv?=
 =?utf-8?B?d0o3Z05nNFI3ejNFWCtWNGlKN01wMFZzQ0R3Mmw1aVRjZXAvd21YV3puaFpr?=
 =?utf-8?B?c2xTQjJVa1JEbjQxMGVqdHdZZzdxcGZFQlVqbkJmUDZJeVpWQlA5S0JGL2hN?=
 =?utf-8?B?cnBycXJEMHZXL0NGZmo2UHZLMU00Z2ljRUR5UDE2OUt0UzhuT3BSdlpqcGJK?=
 =?utf-8?B?RlZmNTYxNFFkR2UxK2EzN3dvaS9weVVRSTFsNzVzNFY3QUtQL2FsaXdxNjRa?=
 =?utf-8?B?WldCWnRVTnc4eElNYUg0N1pERHptaW81QTBwM2laSzROSVI5dDFENHNlY2pO?=
 =?utf-8?B?RXBLWndzN2JWbXdHYVVjS1FwVlozY1hxcERySnQvd2pubjlrcjhMVzVJVXVV?=
 =?utf-8?B?d1hmN0pvN1ZRQ0xSY2RLTE5UdHRtTzBRQ0d0VFZScC9ndmR2b3JkV1pSR0lp?=
 =?utf-8?B?eStCL0o5bEdMOVZTVnhqdmF1R1JvT0lHbXg2MGUyTG1ZV3B4SFdCbENSMnFt?=
 =?utf-8?B?a3Zubm9wbFNIalQ0eEgzUTBYQXozSStxZkNucW9ubVU5RERwbjk4QXROZGt2?=
 =?utf-8?B?WWQvckxva1dNN1lVRGJxbjlsRTIySHVlR1ByMHVWWFMrZkNWQnA4R3FiNmsz?=
 =?utf-8?B?WUFpVk14NjkzS1M4c0RiVGlkS1pPK3V6c0dScEJNbzdOQlF6ZkxlcDVjanZ2?=
 =?utf-8?B?MjdJMDlwL09UM091VnlNQW9KTmtGODlxOTNvOEJ6aWQzdmtOUVA0TUw5UVpD?=
 =?utf-8?B?VjNXSkh3UHYwaG5jSzdtbjF4ajlBZE00UGtiNVhHTkh1L295Y1ZwYnZxYVFG?=
 =?utf-8?B?UWhzSG1pVWEzQ1BZUVZCWndBdVpPN2VuR0Y5OWY5eGhiR0MzaFhBSmxXR3A2?=
 =?utf-8?B?VDYreFZDYmx6aEVrYjBmYUpMMCtybCt0S29yUXpQQW80TkMzMmtISjdnK3pp?=
 =?utf-8?B?YkVNWEFIbkhRYktZeE55Mjh3Z0x1eXFseFQ3QVAvT2d0UEs4OUhrUjZtNC9t?=
 =?utf-8?B?MFlvNzlGRzBpUjJUblJjcE5CT08vOEJIQUJLUVJDaFhFbVJXcWhkWEJFK3hV?=
 =?utf-8?B?eWF1QUhEa3YxT2ZQSDRKTFFjQW4zeDhBcFhBNi9OTUdQOU9Ea2RqSUF4YUNM?=
 =?utf-8?B?M29pclJrV0pOZ3Nxdm1rOUZUUjFFVGxWVnVDMktwamJ2ZGFSczlzMnh3TTNw?=
 =?utf-8?B?SFFZdmN2cUF0OVhMMnVpdWZrc0NnRURaZ0srNU16T2RpdllIU01vZjNsajE3?=
 =?utf-8?B?Z3oxdXVoSmxySDNSM0k0cTZtTk40M2JTTzNSQ3NSM1hVbjdWQ3o0aDVQWUZ6?=
 =?utf-8?B?OWpZQzFoSXNvazQ1ditwNE9CbEFsTlQwdTNGUUh6Z1JyaDZIWEtTR2hwbkdw?=
 =?utf-8?B?cjFKNEt4YjVqYUZUN0piZjd6QktvYzZud3ZhQVF2L0cwelRJa3BadDRHQlRB?=
 =?utf-8?B?TlNwVUM1bGJiZWhrMU05SFl0YVZvY1laZkk3TVFVNTJxU0s5RFhWa0w4MEcv?=
 =?utf-8?B?OU5FVytqbE5xVUd3UlZPU3ZzSVB6VzBEZmFBQ015NHlrM1VIMFBRNXlkcHhT?=
 =?utf-8?B?YlI0Wm9BVVlPZy8rZWVKbTBMSGdqcXNUZE56ejdtM2Mzb05VY1RWd0JabzJw?=
 =?utf-8?B?ZkhIRzhiNFJsSW9KbDh5c2J2SllhNUdkLzFwcEUzeUFFc1J2VHBEQ2tSSGNx?=
 =?utf-8?B?dHJCakdGdWtKR2JFa2JDWDZubHRhRm92R3FSVjdISzFLZmxhek1YdHAwTmR1?=
 =?utf-8?B?Tyt5UjNYUk1DSFJrM1Z5Q3l3UEp0ajRPWkcwamtqMHAzMnpNbytvbzhiU08v?=
 =?utf-8?Q?IGcPgYCwn49ioKtU=3D?=
X-Exchange-RoutingPolicyChecked: fFy+/k1rbSvN+feSvk1KwfxpS6gPKonoJ1HXFFgl9Ko/rXjHFHR6aNczvv9LXEP86rwxxHV8HcYIX6Qf0LlvGGEG3YsqcTvKrBRauPNyQmzfbne6EZsFxiA/U9k9sNXYINy1Yg7h479lEdxJS2X2LtMNupod4kAXj0afdbdIx5CScU15J+ZjHLxGavMTY4/rUZxsdyYQCurdLBSxBCIGE9AbRQ8qBEezA1Kehv/jyEi1cjGzOJjM1j/JKw70TECIGMuuon4lcN8acr/A1roHsuuijyrx8x8B/1773G9lC/g+FXhojiM64lbAgsomlL/Xv0vZT7kYirTXu2KXQyRuWg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6702f4d0-6beb-4bb7-375a-08df1668eae2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:13:18.5875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8M1h8u4uHMEtZyy2oVBXXvNLz3XJHRZm9sORsoBxKPlhtEm0KycL6tQJ3Brm62JzsiMt/5ok9jcPTcU+oj8kxscxxLVHpDu4L0JmXCtb3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
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

On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for Ethertype.
>
> The ethertype filter tracking has been moved completely inside the new
> engine, and the ethertype code is refactored to enabled that use case by
> decoupling hardware writes from software tracking.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
<snip>

-- 
Regards,
Vladimir

