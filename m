Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDBECD5BAC
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 09:46:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C40DF4029F;
	Fri, 22 May 2026 11:46:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id A90FC4028D
 for <dev@dpdk.org>; Fri, 22 May 2026 11:46:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779443171; x=1810979171;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Qd1p0NWtW8pB/lxSr5+O/HbMOs4H1p9kkd6XeeeOkPo=;
 b=OdPCD0Dx0ATL8DZ25k0iGbRNMYFg8PJZDLVC0IY0JgFGivYS6+8n3I5z
 w+PgPhzmGyrmT160g/tuqEGctw52Ik6wnuQsVADeLyX9BE26xIdqTLp65
 880zR/2ajrecdE1Xf4kB9l3Mj+VQ7H3/1h1rzjZOxyqzaKRO/Dfol0fbq
 cxSJObPRrFJ0ACE6PdvDswOiok+B4RmrADppYKvkMd4Nq56CvSZt693DM
 FiipYuYQB/W8Yz+srX2DNVg+ExZ2HLKtpK4RrHUls6fg7AmLqXhGX5PSD
 l6dhcrwSu+pBy1bxvnaYJyaUMHK0wcFrnBZurm4RThTA+XiOJ8tuIGax6 A==;
X-CSE-ConnectionGUID: izS3Aa/vSd6ex42ipbA5aA==
X-CSE-MsgGUID: OJjhW3wLSIK38GRwEb2K5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="90670031"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="90670031"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:46:09 -0700
X-CSE-ConnectionGUID: V3sOGCSFS2eNpszzaktb2A==
X-CSE-MsgGUID: GQ/tM3OwQTKtIJYc6BhqXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="238267013"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:46:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:46:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 02:46:08 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.37)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZGiWvhavZt0j7Cp7wFUmC8Vp2j+aPgOO0K15o8q2T/u+mIGEnSmiiAJo8Qdjm9Z6F1uFFVVxCsa4xVKKJ/LdbaRgDlo/r524AIwcHXw5ufVxC8GgaKmhCb2deTNrakcvYOaZSISm+gYBztCR1bm/YVXFNhvtlbHR1btmaZApypCNpA608e+YQmKvPRJgvKN5aa6a/O9k3UqVQzcbcmMscPQ0vLoaJDo3FbT3JawalvAq8XpZEglRM1vVOfkKacPbnVS+OPFqlTRldElSQomk4zw2OEXereX49L/7vzlALTfoT0FAiuqD1jV6KjmREo/nF0srRZ/W54jMN7LqZlofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DizXJ9yniPqbZQbK2fa6O8i600M7lnYF399mvhn4S2E=;
 b=ZfiwaqiTgZs8JhsHKQg5S0uDZmShFTMKPYOyn8bpwd+b4uL6E+Q1FknhPg+lDEo8RKAcDhJzZzHrxY1ywp6hQlKPdo4VFxY9i25Uox4KzqMiUjI9iUx9nbV+4FKtxiqSQ1xSlK4MGO96i4G6oxThVWLRJzsanjyUyQq58ZtosZnU7A9QxKdWCldlShsbzn1D5p2RKIA7+9x7VTKZxiPCn7NKctoFshrtwPrSG3d5AW9mKZVsGpNeaa6hxJoqdSE0sG689Rnkug2mchKpJRPxrKoTQrsM+NVRRKXIbeCv34rt7tuC5phAqAWmYtUW3R+xVH87eBITXdILrhU3VO21Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW5PR11MB5908.namprd11.prod.outlook.com (2603:10b6:303:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:46:03 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:46:02 +0000
Message-ID: <8b0e6d7f-c7c1-4d0d-8b76-ea2f1fd6655c@intel.com>
Date: Fri, 22 May 2026 11:45:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] net/iavf: fix large VF IRQ mapping
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, David Marchand <david.marchand@redhat.com>
References: <c50ef6c3d4ecaa7902d325d5e8a7fd4c92c8eeb6.1778076415.git.anatoly.burakov@intel.com>
 <CAJFAV8yNKxSXjmjQ0sM21-6hZDTVrGT9cpZ6aQU_FNTepTP4nw@mail.gmail.com>
 <3b9ba191-f086-4264-8382-653c06772e17@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65860@smartserver.smartshare.dk>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65860@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::33) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW5PR11MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5f75a4-30aa-443d-a088-08deb7e6ef9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|4143699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: OmpxCe4tcT0Wa/9fD3RL8W0XGczV0TsIK1WC/k3da6p4Z783WQZIZMUr9aJncWjyIFYRpiGI8iez2NVVkD7ABidP1teL1VZks03MG+r9H7Bim28qns+te/AWDQpxVCjWew5MqqE5VM0oRdmULlZpyj7LrKOlHmhUouYOcrJmk593OA0bAw768DxCAEJijYvgUOMUIwlvCCimMV2KNJ5Y4cs3Acq8poBFE32x2B5iSb962yPgbmLEe04wVuaFXyru22y38U+WnqlCKFY0Voy5x9ZzYh55aZxrZ58+SBysWLWYir6HkFQRZbrRHrWm4oFj26bx3oH9WjaLxhorG8QRZsMNMesZnFvzXvhMDymGQlTA1H18ChVvF19G3EaMTlerhXXCqFr0zPOIRrnQ6DZBR3iMyI5uGVPBH52GJUOJq20+fZ/u9rbUjaI7QRZ1Lg8etVWH+Y1dvBqsQEagrTdtFjKAlVwvcDvG5mBBThEcTg24B9QZBawHgIMqcEhWuAeIOEr9foTlxVdojW4A7iRrPLcH+EcK8UyQGoqsGqp2OWQ3VIXzcK/pFjuyr7nUNQqH4QX36YYPCV/m/DxxBuKZRvFoz4Fi1O861RKCMJkkuW3dl2qfoObZEKp+zLQuschsvQ98VVzziStYma2YbC/HwN0Dr7WBon3ayZWK0zEkRIuU1ocV02Ow11u0HhRMjPKL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(4143699003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZENEFHb2ZkMHpSeGdPd0hldTlGUEt5NDRIbnNOMWFqL3BxQk1XN2xUNFhM?=
 =?utf-8?B?YmZMRVNSTWZnT3Q1bzlabjZPL05CNDkxWE5SMThBNTBvRSthcW1jQVFXSVFw?=
 =?utf-8?B?TzRRem0yQkwwVVdVRjdhblhQSVdvM0hVMk9BbUNBb3MxU2dUcGViN0g2ME4v?=
 =?utf-8?B?Si90SEE0YWtiZDd1RTZoNzkySWMrSmpxYWRxOWZRZEs4Y1RCeXFlSVJnSlpT?=
 =?utf-8?B?ZnJCaGJxZDdBWmM3QXYvOEE2Mkt1L2NFamgxWFE2RHU1L2ZvK3NKRVBoL0NX?=
 =?utf-8?B?ZzFZalVIMnR3TGVjTDZXN3NaRFppQjN0bWdBczI1RFV1TFF5Tm05ZTJ3ejJJ?=
 =?utf-8?B?bTd1aHd3dllrc0gvMmxWNWwxR1czL0hsNTRjRndtM2hHOUtFV0tiZEhLd3NE?=
 =?utf-8?B?R2Rybk9yaXg1NVF2MzFOWnN5UWlCTUNEblFaRjQ1cjBOMWw3dWVLNzdoUHhZ?=
 =?utf-8?B?NXNnMWlwKyswbG4wQ2l3bkVIeE1QNmlEMmlFQUIzckFqSTZqcm9EdVNQQkVZ?=
 =?utf-8?B?cm0zaGtvaWs4QnF0bmRkK1pkTlhmSlpzLzhZK2M0SUtCeDN1SE1sOUNHOXYr?=
 =?utf-8?B?a0dFOTRKdGdIODlPeTFXMFlFWGs1eW93Q0xnaE9zVjNXRnQzRVg5S3pETVly?=
 =?utf-8?B?NXUwRDZWYmtCNjZ6aEJpR0ZVYTNHV0xDRUQ0ZFJFc2dlNzdEbDVXclBLRW9k?=
 =?utf-8?B?OHU3TkROMmRxMmVpbWQ0b2Vwb0c0OFkrKzlnT2NQNXI2VUVCaFo0R2pJbVJX?=
 =?utf-8?B?cWlHNXg5d00yUm9jN2d6MzNLbFpvejEwWFAybCs4cjcwZTRMYzUzcnUxei9w?=
 =?utf-8?B?RGpDd2oyNzJ1eDZ6eE8wWmN2MERhS0gzN0grM1VFd0RTalJiSDFnN1d1b3Z2?=
 =?utf-8?B?T2p0RGxVek1uYlk0ZDI2Tko0M0tSZnVTMmt0RVF2TjRVbWJKb2NZcmsrbDdt?=
 =?utf-8?B?VFlGaU55STllSGlWcFlLaWlpZmtRZEMzOVpYaVFmcE9xOExWcnltQ291cjBE?=
 =?utf-8?B?UWhhSDJiOGFERUdzVDVNZDA4aEp4VGZvS1J6cWd3RWt6TGNuYnU2ZDBYTkVz?=
 =?utf-8?B?SE1Wa1FCMHo5Mjc5MDVrQU16VndvaHpXQnRZRUt5YUZ4N1ZyNHRmNjZKc3ZN?=
 =?utf-8?B?bllqMldxSXA0Zm1rbVgzN2V1TzFodTJOWnNJWnhleG1tLzJBQk5FTDNjOHB6?=
 =?utf-8?B?bkVvQkxnbXg3YU5jTUx1RTUvWUU2YzJmVFRVNWF3ZEwrckFjWElmcTJoSjVE?=
 =?utf-8?B?ZmR2WmxxRnNVMnVSRmkrRHpjOHJUbVBtVUNYWG9hVXpHYnhwMEhkSWFNQkdO?=
 =?utf-8?B?M1F6ZUQ3czZKeXpjYkVkTHJQdWpBOWQzTCtTN01uTThjM09tM2VISDVwakNP?=
 =?utf-8?B?TmVMd1RjbHdQbzBOU1ZIbTBpUDRFSVJFbDNRckJtQ1Bwd3BGL2FYalRIdmpF?=
 =?utf-8?B?UE10anRXU2llaHB1bEZQVzdmT1pSc3ByUzBHbTREQm0zZFpVU2tGSTlXZWJF?=
 =?utf-8?B?SjlkeXZGeURZVFNFUk9VTExmWERQVjdyczVnR3NnNStRWlNlTko5ZndhbU1n?=
 =?utf-8?B?U3hFc25qN3J6Qlo0U3FKdmFLM3NYZGpIZzkrRGlzRENkZURZdEorRFhvTjdh?=
 =?utf-8?B?ZldPaFhOSjBUTmNkNUlhOU5HN2huTFpLZ0JhS2EwSi90WlVYenRqQXhkQTZD?=
 =?utf-8?B?MTVKelFRWVNLYWZpUDROSnRMK09jaEZIcTJaYTFqRS92Z1g2RXVDK0pVRHov?=
 =?utf-8?B?VDdadkhOOFJreUl0UVlFcUlsMmdzUURmYTNMWEZkSWVReGFPTmZ1R1QzMDR6?=
 =?utf-8?B?K3RnblBzU2IvbGNwZk1USVVSc1FYNG5VL1hnVEZ3bzRHZmdtU2t4OWIrM0ZZ?=
 =?utf-8?B?WnlUb3lNZFZlTlRwVDgyS3RuSHlmSUk0TTNmbFBiNE41UzFzcG9jNkhtQzlo?=
 =?utf-8?B?TkF3VnI5NEVnc3JoMTE5akVET3ZNeWFRNHUzWjdKaXppUDVCenVXQlJPUEp5?=
 =?utf-8?B?cG4xY3pOcG9Qa0xVZFlNaFpZajVQRXlTRE92amNkVFZneWFtaXlYNkFjVEp2?=
 =?utf-8?B?b0d3QXhjektGUUJRNW1DMnVNUi9NcnBObytvZUFJaEw0dVE1amZjQnVqVTMz?=
 =?utf-8?B?N0dxNml5UUhoenAvRktteHUvdFpQa0dPc0RjU2Z3Y1FGWlBzbU9RT05ja1FO?=
 =?utf-8?B?OXV6cW5kUGFEaERiZm9GbXBCQndoL0cxR1RESFZzenVkU25BZjNYeXNLcDB3?=
 =?utf-8?B?c0xPUlVqREVMVFgxczB1UDFlL1VMWG1iVGk4ZW4wL2FnbmpLcjdqbmhNZmpQ?=
 =?utf-8?B?SS8xVzZaR01tdGUzVzhMQ2dUNTEvTzc0emc0a1VSLzM4NFEwWGo4SnNnZm1G?=
 =?utf-8?Q?FQoWf1G7+IWvmkQU=3D?=
X-Exchange-RoutingPolicyChecked: Zgvjav3o8t3o7iogLpXDZwuGileI5ahC+hWtDOPLZ6tCWIW4kbi62rPxYVLJ/XaSyXC2JFhFPVKnzwnDTc7F9gX6HQjEqZryvj7wsNAMusNA6fkYmn/VBFNG9IntjUnqtKenptoOvqUyChUbU8TNjkdAyYRJuNAW/vAVkKLsWQjus1HulmENrkwwXUCUYaTfPeDeErofs3FJqDS5amvJKYHPsT4CpqEnqj6kXzCTx2DfYQ2xQPgLvPWKZhCDuug85u/CRy7z0031eTpR3jhXzw8QyKp1VPQkBA34o0HUaavWYxdcjRI+DYIChIAAlr0XFJhiCeFgM4t7JHeq2oLstw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5f75a4-30aa-443d-a088-08deb7e6ef9e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:46:02.6206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpciLB5VXvlM5q44c8AceF09FBQ/HaZp0M1lE8qgCU2bmESHNIjIq/F9TzgpXgHFrr/wJ+AzdYW4QS/dylaTQoqxhgZeW3ml8cwutzV83S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5908
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

On 5/8/2026 11:16 AM, Morten Brørup wrote:
>> From: Burakov, Anatoly [mailto:anatoly.burakov@intel.com]
>> Sent: Thursday, 7 May 2026 10.09
>>
>> On 5/6/2026 5:58 PM, David Marchand wrote:
>>> On Wed, 6 May 2026 at 16:07, Anatoly Burakov
>> <anatoly.burakov@intel.com> wrote:
>>>>
>>>> The PF will check buffer size for being too big, and the chunk
>> sizing code
>>>> correctly calls that out. However, the size was actually still too
>> big
>>>> because `struct virtchnl_queue_vector_maps` already had one queue
>> vector
>>>> as part of its definition, so `chunk_sz` was too big by 1.
>>>>
>>>> Fixes: 292d3b781ac4 ("net/iavf: replace unnecessary hugepage memory
>> allocations")
>>>>
>>>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>>>> ---
>>>>    drivers/net/intel/iavf/iavf_vchnl.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
>> b/drivers/net/intel/iavf/iavf_vchnl.c
>>>> index c2f340db81..dd09b0fa61 100644
>>>> --- a/drivers/net/intel/iavf/iavf_vchnl.c
>>>> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
>>>> @@ -1528,7 +1528,7 @@ iavf_config_irq_map_lv_chunk(struct
>> iavf_adapter *adapter,
>>>>
>>>>           /* for some reason PF side checks for buffer being too big,
>> so adjust it down */
>>>
>>> The comment above can be removed?
>>
>> No, it's still relevant, because it refers to the fact that we're
>> adjusting the total length downwards as opposed to leaving it at max
>> size.
>>
>>>
>>>>           buf_len = sizeof(struct virtchnl_queue_vector_maps) +
>>>> -                 sizeof(struct virtchnl_queue_vector) * chunk_sz;
>>>> +                 sizeof(struct virtchnl_queue_vector) * (chunk_sz -
>> 1);
>>>
>>> - did you make sure you did not break compat with previous version of
>>> Intel out of tree PF driver (since this concerns configuring "Large
>>> VF")?
>>
>> The commit in question *did* break things with previous out of tree PF
>> driver. This commit fixes the breakage introduced in that commit. The
>> commit being fixed was a refactor, which specified size as N-1.
>>
>>>
>>> - all those virtchnl list struct have the same elems[1] issue.
>>> Kernel side did some cleanups some time ago, maybe time for DPDK to
>> do
>>> the same...?
>>>
>>
>> Yes, it is indeed time to do the same, but not as part of this
>> patchset,
>> and not before the base driver code is updated to do the same. There is
>> some background work happening on that front already, but there are a
>> lot of dependencies and moving parts, so we can't just change this
>> willy
>> nilly.
> 
> Is there a timeline for this fix?
> 

No specific timeline, unfortunately.

-- 
Thanks,
Anatoly
