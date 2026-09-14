Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6B6C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 16:13:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACE6C40E21;
	Mon, 14 Sep 2026 18:13:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 715B540A75
 for <dev@dpdk.org>; Mon, 14 Sep 2026 18:13:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789402422; x=1820938422;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=3Zhwff0ZK/8GM/caLonvuaRjIEUGM7Vjjfvh27H77TA=;
 b=lNnk4LPTsU1FYlAGqwzOEDQvZOAkcFFmiceXN/Mr1B5O1BPHF71L4DN6
 pVJa9C5z9BkLfJ9IsYuFD8I8rJh6MesaD1fSsOIyNwkvq5PDURzv1xuFY
 a1TrtM6MHu8zcGm5LRfh6oXQfORJ87MxCQdU6qtIUGbBYPHWmD6D0+Anu
 35Admnqwq2Bg666pXPxioYe5LH8KZz0PmKsRE80F6D8cT03rQoSODvNiQ
 5bArrczG/k2tpatbejRcq2IEdbfEBOSgbWsJaJ1LfB89m67xbTW7ycwdx
 Zqx9ZdDrFvJC7x8GTefMqeNpWKxvolGEom9PEI4jBoH0Gj7vf1rXSyYHW A==;
X-CSE-ConnectionGUID: uNOKP8Z+R5C4HNIxVOY4UQ==
X-CSE-MsgGUID: VP4neYkUTKKGZsVvxjMJ2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93623864"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="93623864"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 09:13:34 -0700
X-CSE-ConnectionGUID: Wnb0jltgRbuhDxvszTQxbA==
X-CSE-MsgGUID: 4h3FLSSWSgeL49Fpvqk3RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="302573402"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 09:13:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 09:13:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 09:13:33 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 09:13:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9MWYtWa1XKQUT4XSK2RdCKLaMWy8zdGgpS8b0V3tLAm3z2msdNzTrFZtivg40J8cXu332CLNxke8fl1vLHpRByjH8+7V07iJ+qX/OB4OnUdX2veJKIXB86vX9xva9PuCVVz3M16tfiR1QvvMdxK3JxJggc4fO8J9VYU4cSqHWlPtW126A6CcPxfKaT2H3c5Z5MVIR6uaYsp6IEU6PM4kiKCJIdPxXSj4IbFdTIryRMjymHNIW4kxBB48GtPopyCc0NAMw++MJUZ8XN7wKFeqgNNqwrKXYkoxudBF3Y2x8iJSXqWvfged9/E1DjHvB5OrgmoC0zrWwZf+eZjHMl/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Zhwff0ZK/8GM/caLonvuaRjIEUGM7Vjjfvh27H77TA=;
 b=rmGIQkiI8g0cJWzOjjGKrK4pvETk/a5ZhNKLy4JEppdzQRC0zrWdBXc1Od17tmsR7XH1D9h9OfAvSniKywtg+/6HjW6IRiMC1jTf1kUKQa+2Y/fh4F4cPoR+oqqg+iue0YMFX6zb38Ru+26yncoC0w6fgdsubPyRDqMQBHtCVtT6vn158ku3Db1f0QC68kMFIwqMAIA19it0juULWJCK68pAmNCHLo0vQC9IMAaXT9Mzr/VWzvKc8soqp+GgTP/hSwE5NXKyDR2AZ839Tebpl3X3sNeHkyxrug0ROp9nLqOaTEe8rkJFTtaqVb2ke94P0LimDraRas5wA7hT+A15Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 IA1PR11MB7824.namprd11.prod.outlook.com (2603:10b6:208:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 16:13:29 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 16:13:29 +0000
Message-ID: <8ae87b91-d9ce-41d2-bc17-4abf554d017f@intel.com>
Date: Mon, 14 Sep 2026 17:13:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] net/iavf: fix memory leak on IPsec SP delete
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Declan Doherty <declan.doherty@intel.com>, "Abhijit
 Sinha" <abhijit.sinha@intel.com>
References: <d722699838f742d88098fd31cabac1101b5dc429.1789382934.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <d722699838f742d88098fd31cabac1101b5dc429.1789382934.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0016.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::24) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|IA1PR11MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 189da387-f9ac-4681-4cc1-08df127b1cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: SXS2waKzsal1igHqghi9QRK34OuOIwiqG3iaEhN85SaFSSy8vnLljwyDXDOyjmT3WF+dk+PdAqkMIFVdY1oDaT+ZVMeF1U/ZSnezwsNMVwSH/BYjp4oQvuClEAnbY9axKeTzN0bNtetOp/LwO+WwGvXK3sQgZ9nGErI9P7J3XVfZUUDO+14794aVgkATMq+j9erw8P0euqa3+gmSFVObTYpDwSiOE0Xov0N8XQlwm8V+RqG/slr5SShl6gLcjBz+OJzS3MeLJvt8yYj94FTpKeUqcX8qJ3pB93RIG4LZTFqxxG1lMc8F6eeueXX7goh/jw+ujEK03k+fBM/dgmC/pGjXy49nTKy5J3w9nacIlZcjIYCVE/sAlWVurHvT9gO8E3QXXrVLbdVtCE2INs/JjcbO+DEbiMJsA0wrZmOddkfYpjBLivMOuUW9c0rA6Qmyu8YNHKmSgynKuYWBJ/Ji/hOlwEPo8zgb7ZbmBOq3rJDxACSUeQmJ01NNUd6YCQd8W056AMg2d9H8Ga+kRWZ7FFZsubFUQdGBGXy/H0I7abBqsrWy4+0tFUrpwFeU2qlJTpXvNZ5buXJaBFJNC8n4cbwqPtm0A7lvMFvSi5P+ELKMk1XavjHPkElPYxpdFTzGLNTfp9Bn1DQLArafsFK/5gnTlhMCLbXsfjW5JT9a278=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDZrcVJPN0tXczl2Y0FGVG9wY3B1VlFRbjNuMGZBek1QYVhKQW1OdGhPakJH?=
 =?utf-8?B?ZnhZT2R0cFdNLzVhY0pUNzJUbWpCU2c2SDQ4cXJ6SzZEWUUvaVpGOG9pT2Fk?=
 =?utf-8?B?c2tQbFhOUE1ScHdZS2xOR3Y4QzhNRjBkZnkza3dTcVVDWFkvQytsS1IrbDRK?=
 =?utf-8?B?SVRvenU5QU5OdGgxSGxYL1dHRWd5NVArL2hkclVKak14MHVMdVYyQ2VSYzZS?=
 =?utf-8?B?bzlhR2g4UEswNG1ybm15bkpVcWpFTXVQUnNBNWFPTkoxbFpCcldPUTNJSjk5?=
 =?utf-8?B?YzR2TVo2VEZnWFp6Slo0MC9QYy8rc3IwdE95U0ZYOEFDL3NHREVBbG9neXBE?=
 =?utf-8?B?NnJWUmRXd0drNTVxQzFyQnpuSDlpb21lTmhqRkFhRjExYUxFSlIxU1RicUtw?=
 =?utf-8?B?NjVVdDdNcDE3VFJNdkJhZkUxUCtLenhiajJJc25oZDk2WEhJV3VUVEFJVWx4?=
 =?utf-8?B?b1FkeGZuQWZyVmpSeUlTOGttYUZZM3c1S0IwaTMrRDlLeDZoY2sybFpuODdh?=
 =?utf-8?B?VzJxbVllNXB6ZThDMUdMN09xK1R5RTZXb3l1L216cmJ2cFpycVdPNHJMM1pr?=
 =?utf-8?B?UmtZWFhHOWpiSGltcytZTytyUFY1aDFyeUpVbU0yTzdUbmtYTGFlNnNmSVNo?=
 =?utf-8?B?V1RKU2N5TllWNURqVmVYeFNMRU1FSVNqRmZrMmZPWjEwOTNaeFhHSzdIQWEv?=
 =?utf-8?B?a3lTRG5ndjJxS0dRU2xCd2pMSXJFaHhDNFZ3NWM1NXJxazJnZzFWbDJMT0pv?=
 =?utf-8?B?NlEzaHJjSnB1R2wzQWZCcURHTmphd0hiblFQY1piNGFxa3Fhd1orejMwWUVR?=
 =?utf-8?B?aGYzY28wdks5ZjhzdTNQUThOSHhCR0twb2RjN3VGTFhBK3pNMFFQdHlOdVJa?=
 =?utf-8?B?MkVMVDAyZ2ZTcmhpMmlGOTd6UGZqVENQSUg1bnY2dEdnb3VjT2F6eVdoZXZi?=
 =?utf-8?B?WVo3SVgyeHFoTlRiZXRNSm1uczNXTVdjN3hSQllWdVJxWFFma1U3a1JtMTZy?=
 =?utf-8?B?RHIrcU9wN2hWMTZzREZ2M0JOcUNnS1g3ZEIyZzF4Qmw2U2NvVzNjU1lDQTJr?=
 =?utf-8?B?RXkrcnl6Uzl3bHYwYnlWcFMvQkkzT2JjZ3hFbzlQbEpHWE82KzcwazY4Ymhn?=
 =?utf-8?B?RFJ5UWNnMk5WcWZyUGgwVFQ3cE1qUUFvaWdaMkd4VnI1Z1BXd1hGK2x0a3RK?=
 =?utf-8?B?MnBJU2FyRWpmdmYvbktMR01rSUxjWmRsejl3WWp4L1dRTFR1SVQzM3RyaVZl?=
 =?utf-8?B?VlJ5a2ErMHRFK1gwREJTY0JEb0Fmc3RzSWYxVVR6OXEzQ0xodzFFQzkvUG1k?=
 =?utf-8?B?d09pMzVHa3EyRVR0WXdEOWNUem1SMksrbUdZMzJ4aWNTRWFiZy95ZnNtaC9t?=
 =?utf-8?B?TDJuTEoxUFlhYnpvTGlNRUJML3BGNERZcWhyUHd5R3FscEtPamFmaWVqVjZs?=
 =?utf-8?B?U1lGU1dEWlJGZ1oxZzNOWkNlMVAzb2x6VGVua08yek4zMktKMDVIOW1Lajhy?=
 =?utf-8?B?cWJQUUNxNllmZ3lBQWwwRHJoZEdjeHIxbEZKNEUvUExVa1JlUFRZWTR3YVRm?=
 =?utf-8?B?d25YaW9PeWZ1QzVCbUJITmVCNTBYYXd6RzcvazBHMEFUVEhhbkNnWGZ4bEx5?=
 =?utf-8?B?bWdZaWVqb3N2YmEzUG1hVVczUWZIVHpQbXM1dGtneUc2YVltVEVucUZKQTZZ?=
 =?utf-8?B?Y0RqZEo4clBkR2VQU2dqZ1U4MkY0YWovdWFBbGxxMXN6V1NHREpRK2d4cDl2?=
 =?utf-8?B?VUJKMzludldzeFZMTGVxT2xRc0k4c2crR2h3SUFpOFcydUpLekxHU0JsZG9y?=
 =?utf-8?B?TENxV0htbU53Rmc1aTBBQzBIVzN2S3QvTXcyczlIVkR5S00vVmIzNkNmbFJT?=
 =?utf-8?B?bG9WWHY0R1ZXY1hKcGNmem1Oc1I3RGVub3E4dlZuaUxkQ1JrMmd3bVUyQ0RE?=
 =?utf-8?B?d2VHTThJZkEyTFQrS2JiZUN0ZTA1dEZlWHV0aTY4WCtCZnpmODJKMWpyRm00?=
 =?utf-8?B?aGhIaEQ4eVdQUzRyVmY5Q0ZabVlFNFhlaUloZktGb2x3SUFSbldOQ2w5NTdO?=
 =?utf-8?B?VjFGcTZtNko4alNoNGRQZDNPNXZ3Ylp2VFI5akt1MU5ZSldSRExUd0pKSHp4?=
 =?utf-8?B?WCtZL1BMblRzN0R6YjRVdjU3QTBPY05UN2pOcEJhT2JWeWRRVHVuU3Y1MWxw?=
 =?utf-8?B?S3o3VFRkYTI3WVB5ZmZ0b29QN2hNTHNMbXd4d2FpclJrWDFkYjZ5TndWZDYv?=
 =?utf-8?B?K010ZU1sRTBPY0M1MmpWVlNVSXFjMlU0aTgvVmwwenBRbVNTMGRTV1MxU1Zu?=
 =?utf-8?B?MllacWpNSFl3Y3c5dzJvMTVVeFMxVVpmRVBSNXVsd3pESEtRbmNnZz09?=
X-Exchange-RoutingPolicyChecked: cFPrnJ2l/KIJRMZ13QA26B+kjGEavJ+ISS2h+AJILaa3fQHSjOricYzguMF565D7jvskyHaEd6kcnEcIyHYY2mMortFZrpF8x5WcOrTvmznRwtm2R8dZOKPSmC1pKGPtYfBuuHUz2jLVrUHVuWy+wCu7+5eaFDjnm/XK0dRcXhd9uFsOFasr/FaoLO9DkLO6D7DvkeNo8LzzBWf1JXaGgXyaBe28AL++5MLIMDjjslcc9gydFKN/lYGWzpDmCFrLLdBTZtxty/7keNra0Wb54ANHnaipkQiKR8UB+Obl9xlc2IcnOxw2HCbQIS28KmPoVJR2487exc6C+zbayLCCXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 189da387-f9ac-4681-4cc1-08df127b1cf0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 16:13:28.9373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cj50dQQ2/gu7RrAvu+WaPN6EiNwPXFpKqyqFzFHcpvMqLzfRfeum2y1EisvcRfxaP/Dn7hY5rrC16CZ5AT8WVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7824
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


On 14-Sep-26 11:49 AM, Anatoly Burakov wrote:
> When deleting IPsec SP, we return status response without freeing the
> request/response buffers. Do not return and proceed to freeing instead.
>
> Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
