Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1F1CA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:33:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1AE440698;
	Sat, 10 Oct 2026 20:33:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id D9AA04067B
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:33:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657232; x=1823193232;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=QJRo2U+mMqTSB1EofX8Nvy2P/vwKDzHxvs1AQFfmyqc=;
 b=UExC/IWGQFsXKP1gQehFYjYCSu1X3TJsOdNaDi4mhKGhUk7N+ebxwnjt
 8JSxPHaFm/IBY0qIVFiSw1BaPUJbbsxSaZacvVXkQ6wHyz3sl50pbHUyx
 2EWlidh62dOlxhV6wUSm/o8DBhr/43MducfDgfRGcGYcXMj9UawLMNjxW
 4alfjGf1eFbwEvw3tRMWNgbw21+R2yXq+rW6bUVLvBqOChimNJLHf539v
 VUtQjuC+o75dYLZ2Rnc7C+CEElkkY3dWchs1pK+jNTDPFUV59IELyPO+B
 F72ytourscwfoQnlJmmoDH8oLMMIj4STt7f/rc/7MeTANhkqg7gmGp/o0 Q==;
X-CSE-ConnectionGUID: zF/HS9qVSMyvt9GlGwBzqA==
X-CSE-MsgGUID: Hj+NudQ2SGe9gcaSUDWxDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="521460"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="521460"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:33:51 -0700
X-CSE-ConnectionGUID: HzZrWZRLTJ2lW5GWlIcyEw==
X-CSE-MsgGUID: dOI0+OtNR8OHgOJZfaSAkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="2357820"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:33:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:33:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:33:49 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:33:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYyvc4QJsk65yVmjGw+gwGwlrWr64bp7XkwxLcdtAS6Q/7pPFZySwPK4guflCi/NlBtJcvelog/oSMXkdWmxZEAu8nFa9iI9FS3RHAqAoGqT/OUl1f1Km5ezlsxjMlSv5qYYa2g1p2YjmtVVcLMsZNwWi9CW5xV4d6E1WguxG0vpuR5K1p+Emo8n/ItaX36Lix7trGPQ4GE8MPDeAaQ5hf78+pDuYqMmCiP921W1BEUbZNEb46E9hSp9uQpUie/+O94oyzNGUaIzMhZycnQC4FkZK5DKZf1ffTfwfMz8kSOkdrlOCuxXKFtNCN3UmYJOA8COmrCRH9/l+HzLOvvPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVsiwhchrFnNhiIMfD3gklwfahDbeMYbmj1WXTDLJQI=;
 b=LMF60eRECiZKHD88VckBwi5a1gxKNPqlz19ZIA0aAyac+hEG4qWhNsD9ciN/g6dNU8lKXXAEIGp4oaK/9geXyimRWea30/C0K4gKXGSuEBl5BsZfGRQNtmy9MRlqb3p5fMDPdxWL5dk8KyZ2HtECBSL5dDmfrU72XPIEXzvye+LBpXnKYd+UgylB7vwyrzDiUo64fwjViGuNrh2tcaPHP0gC3qCQtouw3oTuaLj7uxtTu8i2DgKBXcUMK4Uh/ntW5pnF6bjC8IAkc8XdgTsvaBKtiKobw5BWm+b/mM+JEr8Su0mPU8W/DACZPONSd7ViMzwBbklOnA0J1aXIt/xrtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA2PR11MB5049.namprd11.prod.outlook.com (2603:10b6:806:11b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sat, 10 Oct
 2026 18:33:46 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:33:46 +0000
Message-ID: <20194c6c-1b07-4f0d-8bd1-6eb07cb11724@intel.com>
Date: Sat, 10 Oct 2026 19:33:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/25] net/ixgbe: reimplement ntuple parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <5f70ae75c2d9078fff433d686ccdd45f3aad1a7d.1791543155.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <5f70ae75c2d9078fff433d686ccdd45f3aad1a7d.1791543155.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0011.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::16) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA2PR11MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bad8a70-7202-4b54-4341-08df26fd0507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: g5hRYrzpNix75SS8+aic+sampk3xhW/V7n3Vty1DQ1cBei4XLoOnNImRZVQFlL7tFV3TtrN7jHku5FLaqL5jXu3P1BSRIinf0/lgb6NOL4YFl1PSNcNGoN0AP45HU1PP6Sqe+pMca2DRXUy6I3LVv9RxDfDB79Zf+Q1yVdpjR5Hw5mV5UNSmHnzizvTOulDcstA6A+pWWA56EQXCjn02/w3nOficfN26H1Bi9PyqydDK5pYrpnwG49Zfhjke1AOByj0HyV/z6GJ1r0uWzBMI5nURdWwHJw9GYXO7lXx24a4galaVTC80wuIclEw/n4nOL/Zr+I/+P4CB0f6ED5OmCfvQPycQ6axBvwkQYlhvlzVQmOEMDT/B53tMwAthyPd3KzHwNI064cx2NRQt2K3DU8UpWFqmpj0zshT6Z69VPrxkrOgtqQmlCV5Q3CirnG5ij/LgFUH05jQFN2oK+eKd6flTkA5fH1YPcLOf9ZXrjTzT8uE+z/pGWHaKlzPLi0EbjwNfnpgERmeYBaPuvAMpakgVCNn1VBS6/vVick/dYqEBC3ReU0orthhIaFJa9k58Z99kHvYVBFMC4rZjfE76xfa3HW9dmPoFnvkKnccbMJF19avyUKNxy3pEW7iSWi69q52Z3tKyCh/XHNbsBgwosLGyX+7j8F9OXmn72VHKaVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1J2eFRjY3lUbEJEai9BRXZGWmlSSG9ybno2b0JpczJoSWxhVjdINmZqb2xs?=
 =?utf-8?B?NmNBdGs2cEZCdlJmZmlVSW1jQmRscTQxTUlxa2FnNGFJbXlUamh0eDg4amVu?=
 =?utf-8?B?UDFXQlV1bldjbDZteFFoUDk3ZXZPTHFLYVdOQUdhSW00WFI4YzlnYXJ2dWJ4?=
 =?utf-8?B?WlQ1RURwcXJFbUhibzBwak9pcm1QQk9vK2hVOERNZ0lYREZOQXoybEM0eDd3?=
 =?utf-8?B?MnJZTnBIbEc5M0xrOFBFcCtqVVNGc2xaMmlZYnh6eW8rTTdxcnZISnpMcTFI?=
 =?utf-8?B?WndXSTdmNFQ5RWtKQjk0VHBOR2x2TjR5cG4zTjhDOVdqbGdtYWRKcDlyaDdk?=
 =?utf-8?B?blpadEFqVUZmTXI0T0V0ZGV1ZFdBb2dCekRZbEg4aU1pTTFrWDg3eG5UQlov?=
 =?utf-8?B?N0hvV1JMWWhZL1dxWTVFUGNpZnhZd3lUdmtqTGR4eWJiYWwwMDJVR2k4TG0v?=
 =?utf-8?B?Zk9NYm84SjFhM1hkUmFXbVUyMzRLQ1ZGaExtUTRhL0NEK2QzbzRFSmlTVDVN?=
 =?utf-8?B?bC9QeERmSmVSMi9mS1NpWG9KeEpSaGkxSG9CbXpNNHFKa0NhSUJJelZaUnI1?=
 =?utf-8?B?SkxIN3ZBNzRwMFc3ck9EaUxVZWNrbWxWdWRXT1FBbEs2MW5iZXJHRjlsbTlv?=
 =?utf-8?B?YVhCNzBJazV2RkIzMTl4cXNWTlQ5SWpVRUVZVU96aVF4M2J4Q1FidG5ZNVAy?=
 =?utf-8?B?N2xlRUJTZ0RZSVFjaWpoNUtJY2M2SUs2b2RLSk83bHhpbTh5MEhxWUh6VHI3?=
 =?utf-8?B?Szd3Ujltc25IVmE2emYwZzFhVElnQUQzbjkyVzBjMXFyUlFrYk5hZTRVbWJz?=
 =?utf-8?B?SDVUV2JyRlJDbFFWSmN0cE81SGFOMCtpcGI2OWNEclFudElnZzRZMjM5VTU5?=
 =?utf-8?B?Q1lCMUhrdTFvU2pSa0gydVBtTkwvOTlCSHRwaytzeVJIK0NnYmVHVXVNNFFK?=
 =?utf-8?B?WG16RFdMYml2RjRFbjJHeUtTUDQvU0MrbTBsdDRaYzJONCtFREtkVStPenM5?=
 =?utf-8?B?TWdyZ2tLUmN0Ukg2TDFUMmpJa2FFeThIclVTakV5YkNIa25adzdrV0p1TmNF?=
 =?utf-8?B?U2VhazhFeFNPOCtJTkc4WGVON1hSZHFSNlJwWnhZRm5OZkExZ2JIblQxYUVM?=
 =?utf-8?B?SmZzTTFNN3pPbjJrZFQ2U0cvYS9ibjVET2NPYnNWbWUvL1QvRnR5bmprZTA3?=
 =?utf-8?B?L0lKc2p2YjdvTkpmV1pCWjQwbG41eWVNNVZDVkxKa3QrcWM5cEQrRU9acUkz?=
 =?utf-8?B?cTlFMDVqZU5NZ3Z4TUhYM1pLdStXTmFXZnBhSHNyWDZoWURGRkFhVjdZMlhp?=
 =?utf-8?B?QmpXQ0JVcFhaTFJJdzNkbXZaS0RPRWdEdk43bTFRUFJWVlJJUUtVSmVQTWJB?=
 =?utf-8?B?R3RWdXlBRnBVSHdOU29OTnlzWDBaSEhsMjlWSHJNUUR6ZkZrVWtBbEZwbjZi?=
 =?utf-8?B?ZEJmT0dJNHJLN1FDVUZlZ3V2dmdsZW55OERoT0w1K01lbjUwRkNkVVFnQS9Q?=
 =?utf-8?B?cDRoczFXVmlkekZaei9KVUVoOHVkc0wyb1FyK3dUd29CdlVvcnRKQjY5S3pz?=
 =?utf-8?B?ZlhEcEZUVzRRVHptdUlYb2UvUndpUDVHc1FLcTEyTTU2TmJyWkRVQjRVdmk4?=
 =?utf-8?B?cjk3K3IwZnpjSXUycnlDamh5YjNRZUx3STkwRURRaXlQdjZBQzhPNXh2NnI3?=
 =?utf-8?B?dGFCbXorSzdqUEJOUXp3MXZSRW5SNHFxb2hyTUhBNDFCRDhxK1VLQmtpbkp4?=
 =?utf-8?B?Y2NSa1JiMUZzVmppS1VxQXBpR1JUZGptZUtSNjNCZ0VTOTdFSGV6ejlyTGp4?=
 =?utf-8?B?SEpWUW80Ymo5OEo0bVUxY0dxUmJESTdaaXVLa3JvTmxuaGJSb1B2YWRYZDN2?=
 =?utf-8?B?YXpsRFc1blRXbnlJMkVEcUkrRS9LODZaRUE2WnpzWnJsTzN1LzBnbjMwbU94?=
 =?utf-8?B?cDNGRXV5K1FjYW9aN00yYTJWSHNhU0JVRm5HNFhUdGxtTnl3Tll6bnA1RnlS?=
 =?utf-8?B?bTg5QXJnWTVMMzlGQ3hBQWd6bXNNMG1sTFNIaDd3R2I5Q1hxbWlZVHFOYmxJ?=
 =?utf-8?B?NktKVVZiNG92ZE5BOEFMSEJiL3d2WWdSOFJUdjVza05BUmRSelFHZnNpL2dM?=
 =?utf-8?B?VXpCZVNVUXd4bDlNb3Z3R1lZeTdscyswYytvQ0JtbWNPclR3SlFtVjBNdnQz?=
 =?utf-8?B?a2pMOW1ORWJxNDVNRnRlN21WQ01zc0lQVnp2bGNEMDkxejZjYXdoalJXVU53?=
 =?utf-8?B?cGNocE9wejVXL2VCaVRRZkZSbjdHVUNFQlhQSU9oZXZRTHk3QVY3V3p3cHZz?=
 =?utf-8?B?Q1FsT2RqY3pORXZ1WFJham1ROW16NEZYL3lJUUlsYThLN2M2YU1kK1FEWmJK?=
 =?utf-8?Q?zEzWB0Rba0sSPsvM=3D?=
X-Exchange-RoutingPolicyChecked: aLv5EBZygkRX0ZkJtX+Dc5KDj9hRS7nFXQjXEhTFGCjDpOPdUkmigjpU8VkOjVcoebcqXPUPQBGxQrMr37Q5ZMoJDGleCqFFo9fePSKpIaaMAK9VupKqKkFLEgNMK6hnE6YvDI/IYaznwwRe/d5fDNFjimK+cpVLUGZhjjsjBPPX6+sJGxfhvYcdCJKvacj3GgzZs/C8V5Nm5mf1J1dqLlV2ND9CehnwI9SEZKNulauxi9KOP7Hq3XFMSOOBsFrD09Fz8fq7d/FvqwQksxU9/C9JEPJtVlhOLVulZgnBeEXwCyObZfLyJ8n5RbGhjfXMqf5xb9N80TOTDM1oOpHTeA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bad8a70-7202-4b54-4341-08df26fd0507
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:33:46.5204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vQMmMBBEJXjqBIoabx/VC5p4tJZVxOM3hmzJWEqSAxuZKll0XP3dSE6/GqpMS0SYswqBKYOpH4Xir1vv55kRMzKAb3oPi+OW5G7nQnBVaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5049
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

On 10/9/2026 11:59 AM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for ntuple.
>
> The 5tuple filter tracking infrastructure is moved completely inside the
> new engine and is removed from the rest of the driver.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   

-- 
Regards,
Vladimir

