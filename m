Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B62EC01CB
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 11:16:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4385440268;
	Mon, 23 Mar 2026 12:16:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id C5F074025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 12:16:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774264572; x=1805800572;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=c8DPVgplt9l2jH9/IBltqSBU8wkZ/cc5UM0EYaJf4jE=;
 b=OVe9Z2sC6xl5kzBpPxZxQj3BD6rgRHWTgD4BT8rZ/NlgrcuxiJzMCwch
 lSeomOrgBpEQ8LaxADpmQs1nZZ6P3na97McujutoCvrYj7VdSMKi7R6Ik
 8Gaw9Btp4J9J2roHDGbPUyz4zaiCeCYxBXtzxU3MQ9M2g5UrDShdxkOKv
 re7aGgzlK1Qv38kw3fso4cGLZoPyYkUwzmKqnChNs/BPOipRytFw9vjuf
 WVy5ZkqFGD3vXLoBw3NxKtKtTIJ+TgrouH564Hv3u0O3EFQIi/svA8KuS
 tZczSGsV3PJaGO+ya7pt/4R7rfoguztlqbqqWjZPqpigU9/JEkGC2Kspp Q==;
X-CSE-ConnectionGUID: 4ZwyymtEQ16P+OPXHhb+pg==
X-CSE-MsgGUID: 8iKAXRmNRVSD11wPaK/hXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75229167"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="75229167"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 04:16:11 -0700
X-CSE-ConnectionGUID: G87J4ADkT2e0nXjA2ay4Iw==
X-CSE-MsgGUID: zxVblhE8StOQsjrEGhXiAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="228072078"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 04:16:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 04:16:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 04:16:10 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 04:16:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtzVulN3VVE6vBqLjKILToPXI0ZCq16/2J8ctBnMZ0EH25S5c+LDyevWCLRG7/h9HUTUq+cgDxjnXNODxxRwQfH8tl/mk2zQcHaYn/PoT4Aw7Q5hxZ5nnqH9AtzuxEOqstx3mKhUtCtZzKkjPA/QjpcCG1M0q7dZqV4woTEUXKdE7zRBTZXxsc/DmV0GGY7PGQ/KNPDSMVFQ7P4UJbKE8vi5wWp7P0cG5ZJOobVWzOr8EHA3JP32y0Wp4tDmlS+cE7OSM8SAN9Cjo4WVEW5QhgKV9OkI0q0hS8oi/sG7Q52Xgt+/Gxnes39RVz2sZ2AXvrA35dXYp+J5qwTGZqmF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56N0wpDwS0ARKqvTagEcJVjUffBU/DfQKr8dJJ0FcCM=;
 b=gnhtdC13IWjvbnO8HmDllqAChgkXK3yGdY5+MwgP4kokcNOUwOeWYeCtIORkGfuTe50aTMdnrVox3JM+W+CtdbQlfmNxtTfORiLlv8bzHPbCPuKnersYe6rcFcrES3emgq+ZPh+0YXrFIF1+eiC4DJQ22k4TLh0RF2Kzhrp7tFoDJqeqO6IDU2gRAKWY2BfEjJ+NRPSOMXHfJLOOv4jyvLsyCJ1awX0yJBkmegy+mY8FlinwAOCxoKxU577ljd71Ll/F6f54TbkBUM6/ZSfmwY1LAf+AOOJOBDRxjY0TNScoQ4rNC2VcheXc/Z/E4vN/0AE6HsqaQI6HhJBXRduziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CO1PR11MB4948.namprd11.prod.outlook.com (2603:10b6:303:9b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:16:03 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 11:16:03 +0000
Message-ID: <b16f1460-626c-44ba-8d26-226ac9d8f76a@intel.com>
Date: Mon, 23 Mar 2026 11:16:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] VRF support in FIB library
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, <nsaxena16@gmail.com>,
 <mb@smartsharesystems.com>, <adwivedi@marvell.com>, <jerinjacobk@gmail.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20260322094346.52a87b29@phoenix.local>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260322094346.52a87b29@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0035.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::23) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CO1PR11MB4948:EE_
X-MS-Office365-Filtering-Correlation-Id: 6683bd41-5cef-4d34-6da0-08de88cd91dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: ssdOD4K/QCzRe8r+0usdGsZhN/mdMFRnavSBBT2qzD8xrFzI64auGOkfW9quin+y41MeWe/6Ihdi2q0qtjhUUedpkNs7U0xR3Hoz4uBzNBfbpifUYSs1ziaxlPnRXFIzBYz2ilRFN8MLm+9Ax6bn7Y3q2thhEw+2H3xGcBq6w04uZECwHFSIHB35QYjiofolpV9+P+MbVqIUO/+QDry3RWC3T4qa1IinVTy5HLFaQw5UVgpSBob5Qp90mVrBc52KprR1DFeC1C9Pp2Qp/6v1yTWpNLRqhdEqVRi76TJIb02/CBg6HloURpiIRzpNjLFOKgGBNiCM2VNTUtQt0kh4SkKgoNeL5jaBTAvAyQPli7YJkvC0XCLcoJtZVD2jR26KHHj+TjKysgYGWuEwUzTd7qLz0GEU++UG0QcH1MRKndmqc1Jgp74QlLFrhVwuT5XB76fhBfnNenO58kn8k2jzqFBz5PL8KHgSRBt4vNBr2W55+ZhJNPfvyURvXnh2AANv+tt3U/9535cbFMvNcisqxTxivJFwoUnyxRgdAMEEV23FWyOCJIl5pvw7Ef3MksIZ+E9N3p11kOYTJqj/DhFxhptMjTJU+WNkhOIDiHYuEmy8Nz+t6fr0uJC+8SjdChsNTztIZT4rkvepVwjV1ybkSqmc4JPzwxDUC0MfgKk8Q88usF3JPA8ICt5uk6F8f7ho
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUFNLzlCZ3VUWHlnUmFhT0lyVUZRTFJQMXFmVzAyMHdFeXRGY0hqelJxM2kz?=
 =?utf-8?B?cVlOWmF3WUlIWmZaSE8yd3pDREpnY2Y2UDRvMzJybmVUd3dvYVltTTNBaCs1?=
 =?utf-8?B?TWRUVmJPV09YTXhtWll3QitjcjZvUEpQL0VSVFZvc01rUVlqMnZJNjdnVXFD?=
 =?utf-8?B?S0d5dEF2T09PL3pnWWFwME8rWVlHSG1XSUY1WGczWEVmbG1hdFo3U1FTcTBu?=
 =?utf-8?B?dnJVcVhxNlhFZGkyZlcyMUhYc2R5elZRR2NLWXd3Mnk4aW41QVZWaGpJNkoy?=
 =?utf-8?B?SHM4TmJ5QkNYeXdrYnVMcSsvcjlaSm5uc1RkUU0vK3I2aTFBSHRCZ05zWVBS?=
 =?utf-8?B?VG5oZVRzaDlxVWFnWGZjaTQzY2J5Z0JGRndxOXcyN2E2WEptVnBVcTZ6K2hR?=
 =?utf-8?B?b2JCdTZmVm1BZnprSlRxcUhqWDNIL0ZmSENyQWN5UmdZVWh0WWkvYnN5NlYz?=
 =?utf-8?B?RVptMXBtMVpFSFNQeitva3ZKcVNOUGQ0T082anJHamhJUGpvMmtoT1VvMDhN?=
 =?utf-8?B?UEdVcHg4RTNPMHBVaVYvNXdNdWJRWCtGM2U2bnVQTWN5ZE91YUF1WGlNYXJV?=
 =?utf-8?B?aUtKZkozS2tPY2hNSktoR1oyZ1pSY25QcVJIajhsaHp2c2ZKU1pWWmdqUTR5?=
 =?utf-8?B?ZFJpNzdKME5KSlRnTHE2ZXZuMlVlV3ExSTdKQ3ZrNWVIVElCS2Q1MkRUZ3dv?=
 =?utf-8?B?MHFmZzlEbjRad01hSUphZlpUeFFSSnQ1dEdSSEJmS1pjeWM5L05kcHRJK0NN?=
 =?utf-8?B?M1QwN3pqNm83Zm1ibndYVXFZK0RuTHFqWXNxaUNST2VsaVludDh0NUdLSkJl?=
 =?utf-8?B?dG85dThtZnY1RUpENVZZTnhaME9GbVNsbkFZNkhDSjN0R2tIbDFhYWh4a0to?=
 =?utf-8?B?RDluSzl1R3NIclBBeVIxa1JIVU1rdVlNcy9xcmZ4cjBCVndOdDZMNEFEVkh4?=
 =?utf-8?B?MHFQeUFEaGdPaWxtbDA2dFdDSWdIUk9HaWttWnRIcjVBNTQ5d1NiM056dTJO?=
 =?utf-8?B?UWpJdEpad2J3UWF4VWxEYUp2RzgvMFdzUEE0Mi9PSHpXanJVbFBPTjV1TWFT?=
 =?utf-8?B?U0ZlUHpkY3RMbWJSV2NucVlxeUM0WVZkbkFaZzZvTmp0MW9wUStqWXlGck1i?=
 =?utf-8?B?NGhBSGhhdU1LR3hSUnNYTG1uZHRNbFpqSjIzSWovUW5Zd09oaDNYWFNUaGUw?=
 =?utf-8?B?ZFoxeW54cVBwbGJZL0NNWjExS29DZjdFRlR6dWNuR3dNcFlBUncyQlBqMm0w?=
 =?utf-8?B?VExmdkJieFpKWXhHblIzcU1nR3g1UElBVWpPZGUvKzQ5cG1pSlhieDJKSWVE?=
 =?utf-8?B?MVkvNENEMnhueVp2SkpPY0tnR3NOYzJKR25YU2JrQlowWExmQTE0WGljd0wr?=
 =?utf-8?B?RVJNQWhmVnVhVDA0NEw2eXZweFZyNHBLcmlnTkJEZTVLR0MvaE9tY2tqZFdY?=
 =?utf-8?B?bGRjS1ZUQXExdzNWbUxiOVRZRVUzZU0zdjB3UG5DWUZjRStUSmVQRG40L2pm?=
 =?utf-8?B?dVA4c2puSlFSSkk5UHNHTzVWNWV4eEJCWVdxekovdCs5bGc2U0UrKzEwWURL?=
 =?utf-8?B?bHJwdVBST1FQQ0tkd3BrTUNJZmE3MU0zRVVpbzRUdnY5YXE2VVNzb3JMYks4?=
 =?utf-8?B?eUxBdnpUVjZva3lmRGEyaUdJU3cxWFVDVC8yWTR2YS95em50TFM3MVJ0TWh6?=
 =?utf-8?B?ZkJOTFZVN01nbkd4YkFXWVlmQ041U21pWFlHUENsOUdlVER1VG1uSGJXa0xi?=
 =?utf-8?B?RVd2TDI4aVBQME1MMmdCeldNSXk2Ri9zQms4TVFWcmV6NWlneVZZQTZ2Mkpm?=
 =?utf-8?B?elJQekR6ajdaTHhOUy9KYStFTFRZNnNvRmxtZkd6cTMzalpCWXpqVUdvdXl0?=
 =?utf-8?B?MnhtbXVYOHY4SEwrUVFoeFdpdzh1ak5neWUxNXlYQ3FSMWgrVjF0aEoyaXlu?=
 =?utf-8?B?OU1wcUVLUUo3WTFzWVI5MnVuWWpSQytodUQ5czZyWDdTV0s3SStpcUtway9k?=
 =?utf-8?B?dzdGN0RZTGhoMGc0cTQ1cHhkdkMzaWJLK3hJYmVuUnlvRG5ReStrY3VPeWJz?=
 =?utf-8?B?Z0RQTFcyT0llakVyNU9rK3JLTmFOVjFNeDJQUmpjL1l2SjA2YklmVGVQMm1D?=
 =?utf-8?B?aDErMlFHQ3FnNnFlaCtOTCtzNzJwcTEyZGxhV1pZVUF3ekRNUnVVRWxEam9l?=
 =?utf-8?B?OVozdXlaOVhaR1NOSHp1Q3BwTmJ6TGFITFM0TjNBZ0d1Y0F3cHdqamRHUFRO?=
 =?utf-8?B?WmhZeWVtM2prYUNWN3pxczBYK1BmTVplM3BnNHFNQ2tGbnNBQkN1Nnl5blNM?=
 =?utf-8?B?YVNFdjFSaUl4Z3A0bFRVcm8zajE5dTNkbWNvY3pTU21yU1lkQmtLTGxXYm1W?=
 =?utf-8?Q?cwKNx85EBPhhh1U4=3D?=
X-Exchange-RoutingPolicyChecked: dk1L8Ep3WLj1FdZlbpnpBvOWzHf9tH+VglGHAD2HDoOfaQNjmIPr56xvorgZkFeIVnMiP4LNUB1yzCXGXOh0ezzx0gMjd+eLYKy3YnfxZm60KFygPdso86ZkP1wC8/PGutk6K6tyUAOKWCi1kZ/RmjyuTRd2OmMb/oV2BoIagts6gVcsu61ZtL/d0nxGx1L+KNXnyFiiXf749+FOfjuIxqCM0iPKqFZkDSMAqXe/Q6y+5mJ0LS/grIIzer2qJBtwR/pGhu7FBgSChbFG8NEFB8ELiWHjWdX7uQdcOaCM2Rs0o2fZyMIoTKOlpKa4EAcQs1bvBGdUJ9q+uyiObJOuQQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6683bd41-5cef-4d34-6da0-08de88cd91dc
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:16:03.1669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWmLcuDhUDmcZfXtWTDrdkHPxCcs+PffOmBunvQMpTF+Zs8r561o3tWLklC+PRhN6m4bOHV7TUPMznWXSUGUe/6jtYRs3RV8yb4nTYGDoac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4948
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

Hi Stephen,

On 3/22/2026 4:43 PM, Stephen Hemminger wrote:
> On Sun, 22 Mar 2026 15:42:11 +0000
> Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:
>
>> This series adds multi-VRF support to both IPv4 and IPv6 FIB paths by
>> allowing a single FIB instance to host multiple isolated routing domains.
>>
>> Currently FIB instance represents one routing instance. For workloads that
>> need multiple VRFs, the only option is to create multiple FIB objects. In a
>> burst oriented datapath, packets in the same batch can belong to different VRFs, so
>> the application either does per-packet lookup in different FIB instances or
>> regroups packets by VRF before lookup. Both approaches are expensive.
>>
>> To remove that cost, this series keeps all VRFs inside one FIB instance and
>> extends lookup input with per-packet VRF IDs.
>>
>> The design follows the existing fast-path structure for both families. IPv4 and
>> IPv6 use multi-ary trees with a 2^24 associativity on a first level (tbl24). The
>> first-level table scales per configured VRF. This increases memory usage, but
>> keeps performance and lookup complexity on par with non-VRF implementation.
>>
>> Vladimir Medvedkin (4):
>>    fib: add multi-VRF support
>>    fib: add VRF functional and unit tests
>>    fib6: add multi-VRF support
>>    fib6: add VRF functional and unit tests
>>
>>   app/test-fib/main.c      | 257 ++++++++++++++++++++++--
>>   app/test/test_fib.c      | 298 +++++++++++++++++++++++++++
>>   app/test/test_fib6.c     | 319 ++++++++++++++++++++++++++++-
>>   lib/fib/dir24_8.c        | 241 ++++++++++++++++------
>>   lib/fib/dir24_8.h        | 255 ++++++++++++++++--------
>>   lib/fib/dir24_8_avx512.c | 420 +++++++++++++++++++++++++++++++--------
>>   lib/fib/dir24_8_avx512.h |  80 +++++++-
>>   lib/fib/rte_fib.c        | 158 ++++++++++++---
>>   lib/fib/rte_fib.h        |  94 ++++++++-
>>   lib/fib/rte_fib6.c       | 166 +++++++++++++---
>>   lib/fib/rte_fib6.h       |  88 +++++++-
>>   lib/fib/trie.c           | 158 +++++++++++----
>>   lib/fib/trie.h           |  51 +++--
>>   lib/fib/trie_avx512.c    | 225 +++++++++++++++++++--
>>   lib/fib/trie_avx512.h    |  39 +++-
>>   15 files changed, 2453 insertions(+), 396 deletions(-)
>
> Not sure at all if this the right way to do VRF.
I'd like to hear the reason why this is not the right way, what is the 
right way and why
> There are multiple ways to do VRF, the Linux way, the Cisco way, ...

I'm not 100% sure what defines a "way", but looking at VPP (since Cisco 
was mentioned) their way is pretty much the same as Linux - i.e. it has 
a separate handle per VRF(fib_index):

https://github.com/FDio/vpp/blob/c2f6a88b43d6175730d5d19364cb446e128065da/src/vnet/fib/ip4_fib.h#L128

In grout with the current FIB design the situation is the same - FIB 
instance per VRF(vrf_id):

https://github.com/DPDK/grout/blob/0f7b91c287f7f54cd75a1b64da7ade505b346bf5/modules/ip/control/route.c#L147

I wrote about the problems of this approach in the cover letter, 
different options were considered, and this is the design I have arrived at.

After all, why should we have to follow someone else's way? I'm 
proposing our own "DPDK way" :)

>
>
>
> This needs way more documentation and also an example.
> Like an option to l3fwd. And also an implementation in testpmd.

-- 
Regards,
Vladimir

