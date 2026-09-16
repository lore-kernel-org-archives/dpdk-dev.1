Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7C2C88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 11:20:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B296442DF0;
	Wed, 16 Sep 2026 13:20:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 66051427BA
 for <dev@dpdk.org>; Wed, 16 Sep 2026 13:20:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789557636; x=1821093636;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YnAHRu3lzpQP2w+Z/r/5DFz3V1uVmd4K8RVWiyU+PTs=;
 b=kvCLtMfCz3MeQm7UNByBY0kJqTXc+dMAWEQgaZ6dEtP73aoTedm4IZXx
 1nmsai0h+FDJz6SQbqyb5XALkTRXbtxDQPFeoD+c4l1ADR5PcgN7wzHRM
 fLMpNmfdQnAFFBcpZQSwkUMw0ThpsZk2JK7+qswr/jZzEndwApXm0IpGe
 Zmq8Fk9IhE16Bu0R8reHt0wfQAN+X6chz2ePIa/+7ZP45jG6wYfvoh+nv
 op/TzfG6MzNELC/LjF1uAMLwl3zNEy21y3D5/JyvLnJS2Yu6PSgd4rrik
 11aW9dxzr6PNYdfAioJfSA1fyS/bdR63jQn3JghlGscpwH0dSkJ/6ubPA g==;
X-CSE-ConnectionGUID: L+qTBStNRcK5Js6WnnPPaw==
X-CSE-MsgGUID: pK8WFQPUSBiO2FiPJo+EJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100528801"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100528801"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 04:20:35 -0700
X-CSE-ConnectionGUID: QeVc4VRXQFytVeeBvjNcaw==
X-CSE-MsgGUID: lYQrAsyCR2K9wSf0Gk32bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277062261"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 04:20:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 04:20:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 04:20:34 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 04:20:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IijAuuuRWGLukUWrc+AkAJFnCpC1xt62oPFsvXSenB28u3Uuj97bNEVlE/ckG97pEiebfLNIDhVOGZ/WDaH1dBbuvUnAbmkNyNL/Hd1c70bZmD5TmBQl27ma7udolR1/+TCk0AjThfn2PJe1kfZrsibdBaT9hs4MJAA4KtE/Qrlrxj9yP10ZBuzK7EGC2dCGQbfMGWIyaEu//LMipKyPx8IToxYVEk0Jk0jVY2LJV21ZbJCbERhBjMhwHjO8Ga06HyHxhKLGlFsiv8al071TPklGLcvnlkgT/JCxA7EN9pvF/6L46m90wg7BWNLlUtvk5W3L0wXO6YKBBQNCjWn5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYpwiXIHPwv0bKWcQ2KPE+vYy1TCVmRWVSCBtan+2G8=;
 b=YdBapLDJSeZBbEhu0lUJHEn4qmNNDv2KN/5jaBltdWcqsv+GOyyVFWuG0fQzHvZiYtwZ39vlc0ZaPxVm1QYBguYv3vvgNUm5Td+4w+CtygW4OWPobPQqWvXDQscyZr/L28epwt2NuA0meI5qchMKDPSYC3El8+zhgkEJGOj788tPh46H93ON2b3aEllpG4jYqnwxknM5Zb0M/Qoh7vS3UsKsj3NKcfcNffZOljzMPyJD+zEk/WiYJsrFMzbulQOZ2x2j5/erGsGuAUATa1Ccq2abCyose/Br+3X0nplYjsNy7+xv6e0ExjT7vYgFhUWQZWheWIjKyeBPotYx+Fq8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PHXPR11MB9687.namprd11.prod.outlook.com (2603:10b6:510:3ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 11:20:25 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 11:20:25 +0000
Message-ID: <65876118-d48f-409d-ada5-911784d671eb@intel.com>
Date: Wed, 16 Sep 2026 13:20:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 22/26] bus/fslmc: use the new VFIO IOMMU mode API
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>
References: <cover.1789044746.git.anatoly.burakov@intel.com>
 <f9eb863a0ce981615476a97f9ac14d1e3db4aea0.1789044748.git.anatoly.burakov@intel.com>
 <CAJFAV8xB1Wg8jZM+znxaeW6dWr64LQfVqW0gkARTJNnB9djgcg@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8xB1Wg8jZM+znxaeW6dWr64LQfVqW0gkARTJNnB9djgcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0084.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345::6) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PHXPR11MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 23558721-0053-4c5f-9f2b-08df13e4818a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|4143699003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 8yfhi+iXwyuQbcEywLZXbGJgNpYL3Z0Ih4asJ5bxFb+I3NBxpXUEtWrNRDEPxOsZprAjoYCJiquOwr/gWkkvAF3mT0ob2UydX9TRP/xn+voaIPn514gJ/+X4WYXNysyRJ3IeAuBnw4BcXHXN1ZRUKcsT30IFnonMO4f8SLHXiusm7E53f09XK+0BW9AyKFZ9mO4RPNBDFv3hfkKJ5HqexdrsIRGc6d1yH+wY7G31ZSoDomzfvTGJuJNQ3ag8aKqEeiyzbSLpO0wWsS9ACCOuhbbP9zqQxmcCEfKFDN03qO+/Nny1QvILkZDqQTgnqFc+sxIzU2wASS2IwS8yl9SGL9N3UbK33AsDYi+36lShetVkYPEEVBCJuORlvqu3yI2STRrYIu1cqKCAXbQPkaQ3suSfUciRUe1qhybg07TRylrL6U7WjZR2h0WC3T4jKHCp23KhLMDcX+iIKTq8alLK5G2yF4UMyko5rc0Ur/ckBBoYt+/y+g6y1S3QaHj5A4korr61kYb9yAcDe+EBEkYQizxtuMpz1K1EW5x28pjq+A/qklvd1oqyOZVYtYXzBy5VLErzuxCHAf/RE33mk1qCxnV8nYtB6MbLREv8GylRz1hYLtnQf9KM2kI8N3FwskQhR7cE07pS9sd5kujytlyh59XLDyb485C2BuDU829nlDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0tWdUVuVUFDenRBcFhQV1pTdjA5QWtxelpaSHJzMHIwcFJ6Q0o0VHNFNHVt?=
 =?utf-8?B?d3FMZ1JEMGJnalhWYmZRZmxFWjhjWkNhYktFTko2R25rQisvUDgxdHcrK25r?=
 =?utf-8?B?WWNrUVhCdk8zeU1yVmRKMmoybTQ1M0dDa3BoQXdpUDRpOUQwTCtCTjZMTzFO?=
 =?utf-8?B?eGFzSXdBUmUxS1B1eTNKWFdycnJ2cEJIbGl5aTFWWjkxc3BMTTE4WWlDd0M2?=
 =?utf-8?B?dGsxb1pIa0xLU3lsMWoyOExYc3l3RU8vTEFaMzNkMzlTSS9BM3NObENlaXJN?=
 =?utf-8?B?ZlJweUZNV3ZIY2d0NUN4YittbC9ndFE4UHR0SW5jdFhjQmU0K3B1NmdMUGRp?=
 =?utf-8?B?UlA0UXZya3lBVEpMczhaVFJGaGduWFl1bWp6WitBWWc0ZENJWWdOTmhuQm4w?=
 =?utf-8?B?OFFqTG1zMGhZNTFTNngzSHMrbG9aMWhEeUlYeFBsN0RIY1V6N3BZYi9CK0VG?=
 =?utf-8?B?eGFYYXQzUStpV0VXMThCVTVQY0VOc09RRmdmWlpzWThwSTNaaUFHY2lONUcr?=
 =?utf-8?B?dWRwemlXNW5Zc3hrZTBlOXBhdzFKUjV6QS9FckVOZWFLTFZKczVSZTJ6YjBl?=
 =?utf-8?B?eE9yS0lWZW1STkFCNnljYlk4SmZraE9LVWR3ZTVQclU0MnczUFIzRTJYWWVW?=
 =?utf-8?B?d2dZaHdxZDZUcXdPNHQwZVoxQzB5OCsyTjFlVk9vdUVBNGQ2SFZxWWFaZ2I1?=
 =?utf-8?B?TTJ3U1FkSmtlMXlvNXA0L3NUTFh2Y1RTdDYxbWI5Y2o3Z3U5VFFVVm5WUjZx?=
 =?utf-8?B?NERybVFRbklDS2wrUjdUVFZadVNBTWtjWitRdElZbjYzQ25ReVJ3UzVoQ0Yr?=
 =?utf-8?B?NE9rMHpZb0NBbmRCM1EwQ2hmK2NDNXZwUUtLUStuemhqcS9OUTBoUElUNGxm?=
 =?utf-8?B?OGxJQ2FjVWpheWZWeGIvMW9JUGxPQjVTdmI4Q3I5TmFuSFFVUVVtOFptSWx0?=
 =?utf-8?B?bFp1TmRqbjZVY2dTSFdlYXRZQjJybzBzNWlDWFpubEdySlh6VTdnZHZCLy9Y?=
 =?utf-8?B?emtia1FlMmdtejNBZHhNR0NYa3U2eURCUm1kSWhEUHFTZXlIVWtxSXpzUHVI?=
 =?utf-8?B?L1dLT01uOENsQWpXVU9OdVRaZ1lHMUNQV2dxczRyWmptTndHaW9oaml4ekVu?=
 =?utf-8?B?eEUrTENUWFZPV09VbGN3dzRJNkJVYkprK25iNThleEZoNmNaSXIyVGYzRlNo?=
 =?utf-8?B?MDVwdEFTYVk0bDF0bGhLUW9teUtTZ0UxNzlnUnB4Ny9MVlZmbE9waE95SXZF?=
 =?utf-8?B?MlJxRjdIUDFZNnZ0S2Iwd0NLNzVVd0tHblhqMEdrR0pWTms2b2djaW10cFRT?=
 =?utf-8?B?a0tvSTFWOFl0c0p2RVduMXpHSVM0NDEyb2RQSllqSENWOHJCNTlvcnFHcWVp?=
 =?utf-8?B?QjlCUDJtMzhWUENhbk9Belk0WFJ3L3h5Um5zNUZBUk5pTjUvY01aV0Y5RmZk?=
 =?utf-8?B?WWFXV1FNY0wvWmVjZUlqenp5OE4zcUxxRzVvNklzdE5vanVRYmVUbjBnUWV2?=
 =?utf-8?B?eUFJa0plZVd0akFJWjNwTUJKRFJ0UVBRSUdpMFBheFppOWhLNEt0RFNnNGVq?=
 =?utf-8?B?UDRLdEFZUjgyUW96Tlh5VG5tL2tkT3dOSTVqQzNWQitqbWlRdkVUU1MzaDJj?=
 =?utf-8?B?SDJMd3JsdGN1NjlZSXJ5eUVNNEdpR3dtSmNCcisvbzhJVEZrbFBXSGFENEYz?=
 =?utf-8?B?UVRML3JRWTRaS3JIVnhoM0piZEZhMllMdURLT3VQQm5VT3o4dm9RZmhXYzI5?=
 =?utf-8?B?M05Jb2tGbUFEenc0Y0F5Nmgzc2ZxSjIwV2dhZWk3QWRQbXVlbG5yWm1PMmNN?=
 =?utf-8?B?b0hBdHYvbzhCb3EwZzZTSE0zeDN6QWFOcTZtVWFEVXo3YUpiVmVPbDVWSElC?=
 =?utf-8?B?amFtTjRQc0NFS2dXendld3FVNXpGWm0xejlXNTE4SE1pQmM1VXZQd2pBTkRM?=
 =?utf-8?B?bkJJa21KbytnT2NtQmxkVE9XU2xaTHZkNzl4STNybzMrTzFaZFNDOUZyb3pI?=
 =?utf-8?B?ZzI5TktYd1dkNUhYM0gxTXVxUmpLVjhwZ1BIQzlmSjJlZzhnM29YWVY0Wklp?=
 =?utf-8?B?NUFmVEVYczZGeWovZWsxUlVQOHc2OWk2a2laOVI2NVlhditMaDczd3VmQk82?=
 =?utf-8?B?S2pOL0EyWmlnam00NDZWbGNJSW56aWREYS8wMFhWOWhHRHFlNmtXNWNhczhw?=
 =?utf-8?B?RUZXWnp2Y3Yyb3ZOaWJYVWdSVFdocGV1T0tldFoyQU9USUZRWHFFMmE3VFNz?=
 =?utf-8?B?SldRSlk2c2hQVDJxbUxZWVFKL1hSbmJXNGdQTitKaGk2MUw4MTJlcVB2eDQw?=
 =?utf-8?B?Q3NSbW4xOUpIZDN5Tk42blhjaXliODE4bHhpbXpGUE9CRHFVQ2hsT0xkcTRz?=
 =?utf-8?Q?kUSTrMEPWu2ps5Fs=3D?=
X-Exchange-RoutingPolicyChecked: vrXRiHG/Seqlnx49PU9pe8HxX9igXekOoo4UUrukbxgQyIbyk3L7ljj3PAfbwdaVhkfpAiUsKwEYqg2lyjNuZvByAI1fFCrVCvkAu/aHV4Vm0ndDU86AOY9bmbEIejRLnnUM8lOMJ9Cs+qmFzox1u/UV3lf3fOoK8IV8VtTW0fdK79e3/oJJDYP7ggaS/H4O/UUIGr4smvFRuFkOJGz4cMJVreC2iEKeUSfAVxYwDDOnrGkbTeKYInjCm7RQETT68RNLydVMyxrOQsN4hG3fZvBThC8oLKsNipKP7/qIqk2WhEHzZe7NtorxfMaly7YCJm7Nk8KQ4W73iaIrBFpmtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 23558721-0053-4c5f-9f2b-08df13e4818a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 11:20:25.7684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RwlleHcly3CNNb1BdVjB4JAmB+eweCqMNkm/AUWns1Wmvye8PLsfR62sQXhzZVqYedpkUbmPFWgkO2jWMdn5miFJZ7W7Y+C/Lo8v2KPEp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9687
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

On 9/16/2026 9:44 AM, David Marchand wrote:
> On Thu, 10 Sept 2026 at 14:56, Anatoly Burakov
> <anatoly.burakov@intel.com> wrote:
>> @@ -500,7 +507,8 @@ rte_dpaa2_get_iommu_class(void)
>>                  return RTE_IOVA_DC;
>>
>>          /* check if all devices on the bus support Virtual addressing or not */
>> -       if (fslmc_all_device_support_iova() != 0 && dev_vfio_noiommu_is_enabled() == 0)
>> +       if (fslmc_all_device_support_iova() != 0 &&
>> +                       dev_vfio_get_iommu_mode() == DEV_VFIO_IOMMU_MODE_UNSAFE)
>>                  return RTE_IOVA_VA;
>>
>>          return RTE_IOVA_PA;
> 
> IA flagged this part:
> 
> In `fslmc_bus.c`, the condition changed from:
> ```c
> /* Old */
> if (fslmc_all_device_support_iova() != 0 && dev_vfio_noiommu_is_enabled() == 0)
>      return RTE_IOVA_VA;
> 
> /* New */
> if (fslmc_all_device_support_iova() != 0 &&
>          dev_vfio_get_iommu_mode() == DEV_VFIO_IOMMU_MODE_UNSAFE)
>      return RTE_IOVA_VA;
> ```
> 
> The old code returned `RTE_IOVA_VA` when NOIOMMU was **disabled** (==
> 0), but the new code returns `RTE_IOVA_VA` when IOMMU mode is
> **UNSAFE** (i.e., NOIOMMU is enabled).
> 
> Looking at `dev_vfio_noiommu_is_enabled()`:
> ```c
> int
> dev_vfio_noiommu_is_enabled(void)
> {
>      return vfio_global_cfg.iommu_mode == DEV_VFIO_IOMMU_MODE_UNSAFE;
> }
> ```
> 
> So:
> - Old: `dev_vfio_noiommu_is_enabled() == 0` → NOIOMMU is NOT enabled →
> IOMMU is SAFE
> - New: `dev_vfio_get_iommu_mode() == DEV_VFIO_IOMMU_MODE_UNSAFE` →
> NOIOMMU IS enabled
> 
> **This is an inverted condition.** The old code returned `RTE_IOVA_VA`
> when IOMMU was safe (NOIOMMU disabled), but the new code returns
> `RTE_IOVA_VA` when IOMMU is unsafe (NOIOMMU enabled). This appears to
> be a correctness bug that will change the IOVA mode selection
> behavior.
> 
> **Suggested fix:** The new condition should likely be:
> ```c
> if (fslmc_all_device_support_iova() != 0 &&
>          dev_vfio_get_iommu_mode() != DEV_VFIO_IOMMU_MODE_UNSAFE)
>      return RTE_IOVA_VA;
> ```
> 
> Or if the intent was to check for safe mode:
> ```c
> if (fslmc_all_device_support_iova() != 0 &&
>          dev_vfio_get_iommu_mode() == DEV_VFIO_IOMMU_MODE_SAFE)
>      return RTE_IOVA_VA;
> ```
> 

Yep, a typo.

-- 
Thanks,
Anatoly
