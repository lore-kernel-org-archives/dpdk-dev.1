Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5268EB271F
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 15:56:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D937D40431;
	Wed, 11 Feb 2026 16:56:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 6A61340297
 for <dev@dpdk.org>; Wed, 11 Feb 2026 16:56:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770825406; x=1802361406;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=AaA6bk+wC36qroH86y+cMx1MCqUi/Mf4q3Px3dlX0Qs=;
 b=P7p28A7/qLK8qgSGhi2H8Cg22ql+Nk0yFxfY3qjsfKusnjgl+7QnpHu8
 c9lpwXOl9QZm7/U6x45+21VXj6OpM/fYIfTVB72+jU/fGR6yAlCVI66QP
 hDTlVpLBpEYbwQ8tcn2rb5A5d5buOp6PX4gpBgaFUV+hVdcphCrihaGCo
 H5g6AafeA2DDjFs7iIo5u71FOViTqYgP3GAxIvZ6RQDpP8+FldW0d3K71
 68EGQOgP6HpM5JzGMxpRC3ADnG6Sezyt6J0Z+O0KYucuXL2iVyxmHa9Ig
 rupT5OUBRnYXNgBbYtSFui8LewXcmTu8H/+gXzZ+SbVG8niWLkK2pohg8 A==;
X-CSE-ConnectionGUID: KaXw7JJXQ+urkadfuzuSsg==
X-CSE-MsgGUID: +NFJ3Q9vQmusKsL1Bbg4yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83419313"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="83419313"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:56:45 -0800
X-CSE-ConnectionGUID: 0Tk04HeHSueH1X7e1rbfyA==
X-CSE-MsgGUID: RT3FalVIRkqJdlgOxT3UrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="216792291"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:56:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:56:43 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 07:56:43 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:56:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axa6YFXaHGUZbynMZdeQfke+Xb/TfYtM+47O8Bwzha8yfqTMK1ixYVMpzZYdZFnTTxKo9Aql5rWEIlq1f8r6XH0isAVCQyQwJ0H+e3DkJMtr+S4etkn1/neGyHl6PEJrNy2CXvAPkwsvgA0b2ASWiBLl415MBu82C/ldZQZQBCb37ymQz44oJ5uIQTuOq1h7KVzbazzYPD75My8Yr+J90159z1C0LWPqSCXW4gf9LYyDdWK38zEdi+cE2P4kFtqSE8M0Qoc4JkWPyUAtEF5PotwQWRd/GNTYX3X/1HaWFT2/naatNd8WmyLJdRq8sSr052CK7is7pDD2UStpBgrmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWcjmberbpE5SJxqF1b1M1B8wficYdWcC4Kzx7Ad0v8=;
 b=aSm8gEsJobQh1USt+Pzh/JXVkPZwCV1HF1iCdszimiO7+wGdFFydWA8PuShTtaE/QC+i90NwCbW6zQ1XsT7dhdZ+hjX0FIeOmR6Q0Jqb1SljHCo19T85KkO0RdBKg9+dH/QlpifdCVb6oAFZbLPnqpZy+nbMtPgsBbju45+aG5ybKZxV0h9mOy+ez/0zNW3PZae/dP6J2ZV2fxRXwgX+p6247df9kVVi3f+h5wk2mZgtq9mkowHILz9vb0Tbb5S+fY5QsYNkpwUY5vZsGsqlWeZlrAbCh03UnKaM7da5+Lkoe2BLmFNf0zHz8uD9nKXiNt1ykCivHGtBEmKqpHiq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by DS0PR11MB7357.namprd11.prod.outlook.com (2603:10b6:8:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 15:56:41 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Wed, 11 Feb 2026
 15:56:41 +0000
Message-ID: <e4b47bb7-2863-450e-8f90-78782bb54b30@intel.com>
Date: Wed, 11 Feb 2026 15:56:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] net/ice: fix memory leak in DCF QoS bandwidth
 config
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Ting Xu <ting.xu@intel.com>, Qiming Yang <qiming.yang@intel.com>
References: <3e0063a306042e649f5c090013896595eabff878.1770817694.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <3e0063a306042e649f5c090013896595eabff878.1770817694.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0053.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::21) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|DS0PR11MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 2583be7f-1e61-4aff-cb62-08de698625a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmlFK05pKzhuYjlORWZsRXVMaHorT25UU2lNUGhPaUIyZDlacG1TT1hBcXNJ?=
 =?utf-8?B?am1uNUJSRloyOXlsUnNIWWtkVWhIdEwrdXZwUXp1a0cwM1BaM2dPckgxb1RD?=
 =?utf-8?B?dE1vaUt1UHBPMWFnSlNsSjdSOEc4UThxaGhsVmpIR2d0ZjRsVnduUjdmemxX?=
 =?utf-8?B?UGR6aExKb3p3RXg2NGY2dk9kaFVYTE1iSXhvSFg2aFdaUTJRSFJHVkpGeXQ3?=
 =?utf-8?B?K3YzallkWXVLSElnVVRMSUQ0WnA0L0NCMVZhV3BMbFQ2bnNOV29ZaVJIR1Vm?=
 =?utf-8?B?WWlxZlNhTWh1T0p4Zk9zZ0NybzJjN2hKMUxkNy9QYmpjendyWEtPczliMTJJ?=
 =?utf-8?B?QzN6emdxZTlPc0pqMUh4WFVuN1g3T1V5SjdTVGdrREpXb0ljb1dUY1lXemk5?=
 =?utf-8?B?WTYxblBQSkJsNDR0bFBWTTVBdzFoZU1RTTl3OWZYcXRrNFF2N1NYMDFmS3lE?=
 =?utf-8?B?VXpaVi82TkZtanhQcXJnNU1YUTd5azg3Nm9DQWFrVEowUkdjVzg1dERIQXRK?=
 =?utf-8?B?Q09EdU52WEtycXYwM3RPdzRQWWY1MkFjdmwrMjBFTnJ1QnFxQi9zajduWGZ0?=
 =?utf-8?B?T0NUa1ZVY3N2dStablpEdW5BbHFEblRsbExPR1VyTlRXVFJRZ1lYeG9NWEQ3?=
 =?utf-8?B?ZThoVHpOY0JJVU9FWVVGS3Vadkh1eGc3aFYyKy80ZWFhaGdVbWdFQkpjU2di?=
 =?utf-8?B?YkFKMW9YQWRqYkNDRVdsT3dOZkVzeFZYZldpbm45WmlTU0lrNU9xNytWczV3?=
 =?utf-8?B?K2p2OUZEK3d1cTFOdEFOd2N2VjdsY21NeTl6bFBXck9keE04LzFPVW9vZE5U?=
 =?utf-8?B?dDZOYy92UUdaQWtMSWdCaWJIVW5GZjlMN3F2SitEK2RhcStDMGdqRjVGOGpj?=
 =?utf-8?B?eGt4UlhHMUFhM0dMNkJHRldYS2JFNGJOM01jUFFXMTVCWjJlS2ovNkpSRWNM?=
 =?utf-8?B?ZG5SYld2M0V4Y0NXZU1LQzJSSjFlMG9uMGNGUUd1SGY1L2E4K1poZUFRb25q?=
 =?utf-8?B?RVBqeXhRNThmQVp4UmtYc0lmb3UwMkpZajJvTkdDWllwTzEyYTlaWGRvRzlQ?=
 =?utf-8?B?SDMvcm1MeG9VTEFHa28ycDJBcGtJWkVXYjZTK01MeEpMdW5FcWF5MHR1SkFa?=
 =?utf-8?B?RUpsSWdOYUZHcFkyMDJBRU9ZNVZPRnYyQU5QTHd6c3daRWs2Z3pJelBVWXlM?=
 =?utf-8?B?K3V2ald5MmRYVzBFbVhnaWhTL3plMFMzSXRvOVhXQ1RoZUFGMkxJaUpoZjJL?=
 =?utf-8?B?cGRQYmhKblBQdFNwSEh6a21FVVQ5SElqZk1oOEQ0RlYxaGs5dERkZFFjeDVu?=
 =?utf-8?B?bEpkUVIwVVV3dmlwZWsrYU85UC80aWZBT1dSTC9DVnRqMzl6TVkyQTVHeFl4?=
 =?utf-8?B?Y201eXZ3WDdkODVRZ3RsZkJabkdWWk8vOE5yUU1lNVVNMmZaZnZybS9ZRzdy?=
 =?utf-8?B?ck9kbnlMd0RBRTk4WjQySkFlbTZwVnZmNHBBbDVkQlVuT05MN3RTL1hGanVQ?=
 =?utf-8?B?VmNBLzI3aDI1ZjhiQ3BSc01PN0EyeTN2L2xoYTY0MTdwL3hCYXJNbTBLVWJa?=
 =?utf-8?B?eWNzaHdic2ZQL2h3NERkb2M2ZVhGMWlJK1BOWmQzek9uQkFQK3BxRXRFODJB?=
 =?utf-8?B?U0lFaW5YeWhjNnhUUk5iR3VnVXFnVXo0cm9KTGhGNWRNMDM4a1RieklEa2h2?=
 =?utf-8?B?aUFHU0MvS3Y0Y052bFZSNUtIWEZIY2RmL0swU1ZURXRrbURNNG5nYW1SUHNT?=
 =?utf-8?B?TE1WOWtLaThQR2YzZGJJYk1uNStkbFdxc200WDYzeVpCZHFlWkl6QkZFdFBk?=
 =?utf-8?B?VEowbS83Q2lxNFZ5NUZVdVlJanUwU3pJRVFMaTFVdzJQSCtqT3JTR2NRRmln?=
 =?utf-8?B?NVcyckUwZUZuVWxybnhUWjdTdDhyTlZJcUxUU2dYcWxiWkY1V0xXYXdIWTlm?=
 =?utf-8?B?TndmZmxzR1J6UHNVNWRDb0J4NGdFRkowUHVicmdIVjhzWlFmMW1mZGNFUDQ1?=
 =?utf-8?B?cVBqK0pXdkNFWmMrZFBsTFgralcyL2ZTajRGZ0xaaHh0VVEvUDFmVm5Bc1kx?=
 =?utf-8?B?eDM4eSswTWlYTUlmTDc3TnhYeUhaMnFNb290UzloQjVlM1kzTHBQWHkwK0F6?=
 =?utf-8?Q?gQTc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDdrWjB3NjdPSWJISkcxQ0FPcjVXZ0xObFVZd0N4RzRrTjYyZUhaV1l5RWs2?=
 =?utf-8?B?eU9JOHptWTNDWXgyTzRHWUUzZ0tlZ2s0NmZIcVNSd0JSSVp3Qk9ZMUNpYmE1?=
 =?utf-8?B?VnJ3Um1SeUNhOHBPTjJ1K0I0TXdyRUd5TENZc1FRTjArblF5OUtwU21sVlAr?=
 =?utf-8?B?R1BYVmJCckxDdjdTbkxIOFJFQXFXMEo5YitCY1hWYmRSTk05MDNVMW55Rmkv?=
 =?utf-8?B?enJpQTU2azVCRUJlVWVLbTBuejZXcEtZTjNkV2EyMUtjYnRPYnh3UnB2K0xR?=
 =?utf-8?B?T0s5RjFXdjd6TnFZMWZiSnV1YllHNm1UekN0bmdLL1VUemVWbTVnckpMbWF0?=
 =?utf-8?B?bEY5aUlmN1VGOW80Uk9tV3VwS0ZrQWNzckdPbzBXbTZIdm9EOERlUDZrQmNx?=
 =?utf-8?B?WXpMYXRUdUNITjB5OEN0VExPV25CaFp5ZnJ4TlNTdjdDZitRK1dJaVQxSS9r?=
 =?utf-8?B?Sm5pV0R6dnNrb0VvOFpKTDMwSW52RC9KTWdEeCtubkszQmduYkpJZi9WLzlw?=
 =?utf-8?B?a0RaTmczUkozQVJXYVNCL1FPZDVTdkFzMzdybFVzdFljR25ZZ2dJS2JqcUdr?=
 =?utf-8?B?OFJvdDQ4R1YwNW84VlVad1lLNXZsaTBsbjRWalovaG5uZ29sZWkrVFk3V3Fz?=
 =?utf-8?B?R0syR3o5SjNrNjRhNWZEbzN2NGFlNEdjVzQ2cWh6MlUxbHZZYTFkQjRRNzdh?=
 =?utf-8?B?U3hpVGNIRHNIeUNTRVNJZEF6YnpVZTBoMGFxdVhta3Z4aVRxcnNPMDhNamFL?=
 =?utf-8?B?WTg1VXJkLzYxcFdoeitsbVFLalkwMlRPRnZCdnVucVNERGpEOUF4blB0cloy?=
 =?utf-8?B?c1J6Y01ZY3hWU2ZVSlRacnBaV05YdW5TRXFVOG5ISVlQU3VYUGI5eUx2RldC?=
 =?utf-8?B?RGNRaXR0V20rSGMxSHUzVzZQTGNDSU8xZ1JRak1xMVRGbmNEUnQyV0kwT1E3?=
 =?utf-8?B?QUUwbkUxYXNYYU5jYk1PcmRUdW1sY3BVUnZPZERlOG9iaU9rdHNudmtReFNK?=
 =?utf-8?B?WlZWeHZoUnZJMXlpSWtnMmcva0c5MjZFTVlxL2l6bjUxdFFRTE1VOVJOaWg5?=
 =?utf-8?B?YnluYXNRZnUza1p5UjVVYVkvUk5iSGRtSjQ0M3dBcmw2RWNQcXlhdnV3bEpw?=
 =?utf-8?B?ZDhGZURwYnJqcGJxNHR2TGU1T2xwcVZtYlcwME4ybGVrRk8wei9ZOUtsTmxX?=
 =?utf-8?B?c1B5T0dhcXl6cGlsanIvR0JxTkxXRmJ3U2Q0Y3I4dDN5ZkwvOEJFaTRUc2F0?=
 =?utf-8?B?QXR0YlF1bWhqTWpyelhsaGVVMGt4ZG83YnpYbmJEMmViVTlXT1NYMXcxeTFO?=
 =?utf-8?B?Vzk2VEJLN0JFWlFqTUR4U3JQazdHbUgzeXhvMWlqQzBVQll5OUpZLzFEWlp4?=
 =?utf-8?B?aHNldjdZSjdtdkxmUkJkbUliV3ZobUQ0ME0vN3hJSnJlNlpjQ3ZlUlR5YnZm?=
 =?utf-8?B?ajkxSWhrVmtCS2laNnRBZVB5ZUNENndlMHlPTGE1Zk9BdGF4bjQ3Zkg5bXBo?=
 =?utf-8?B?bm90RUx1U241aHpoS1pDVGZLTW9YeVhsbllBKyszVlJnYkhibUcwZmpIclFH?=
 =?utf-8?B?SWo0eFVkVWFxbExVdThqLzc4NU1UbmNMUDMrYVNhb25KYTlwcEdXSiszb1hG?=
 =?utf-8?B?NUl1MUN3YXZiYkxLUjkyVXFMSnpVSDVJRXJrc0tSakd1ZVFhTVFoaXN3aTZp?=
 =?utf-8?B?ZEVHWlRRNkxUMEJpTTBmNXhFekpuWS8vZjkvaVFaTzNrYjhZamlZUmJLRVY4?=
 =?utf-8?B?VUVOaUE2cEdTeFh1c0Fwektrb2MvNjZ6SU91WHRVM1VKQmY0SjF5ZUpQUGV5?=
 =?utf-8?B?YlQzMS9jQ0kwVVNSZ3B1Z0t4QmV1U2tlNEdCRHdQSHdXem03bnVMV0U3bnJQ?=
 =?utf-8?B?TnNmeUxyTG45NkFqMnRGQ1lBUDF5bXZYc2ViNDhyL1lHUGZvWmFhendhWmVv?=
 =?utf-8?B?V2VrbVAzcERJQkxCaXg0OUpsU203NzY0M0paa01HQW1HM2NjRDFHZ3gweVFR?=
 =?utf-8?B?N2NUdFpkR3Bhc08wdFpSd0RITmNDZC9jenVMMWtRS01XejdReFU0NGtBZWQ5?=
 =?utf-8?B?U2t1QjhGMVlWaHlxVUtYcGdJUWlMaFp3ZDhwUWFOZjlmTDgrZFo1cVFqdTNS?=
 =?utf-8?B?U2dVeFd3cTg0R25pcVNsSkdLRk9DVFNSNTR1ZjB3RmJFTkd6NUpSTCt5VzY0?=
 =?utf-8?B?WDBhTkZoQTk4b0QvOUVncUJOenVqczZEMnR2a1ZsWTB4RmJyNUZTeVFvU013?=
 =?utf-8?B?OXBaYm83VUg1RS9mY3N1UjdTVTJqZUo3YUxKOHVOemM3VWcrRFFXTzQrUFhI?=
 =?utf-8?B?RnJPVXpYeW5ldDM4blB5VjRYVW9DQy90T1ZDVll2UDB1VmlPb1RJYTJXWk5a?=
 =?utf-8?Q?gdSWL+lLMADR5f8Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2583be7f-1e61-4aff-cb62-08de698625a3
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:56:41.3369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwJqF2EaSeRIPYHl1MmC6ylyMZFvYOBECS+5JjUxEtCdt9v/5zy6/YVj/jCTdVAaYSqiXCIYGW75hl18k4sIWjSIrmRhgBNd5NpIMQZlBrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7357
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

On 2/11/2026 1:49 PM, Anatoly Burakov wrote:
> Currently, when committing DCF QoS bandwidth configuration for VFs and TCs,
> we are using rte_zmalloc followed by copying the data to persistent storage
> and then discarding the temporary buffers. This is not needed as these
> temporary buffers are not being stored anywhere, so replace them with
> regular calloc. However, because the original code was missing a
> corresponding `rte_free()` call for these temporary allocations, this
> also fixes a memory leak.
>
> Fixes: 3a6bfc37eaf4 ("net/ice: support QoS config VF bandwidth in DCF")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ice/ice_dcf_sched.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
> index 2832d223d1..645f1373f4 100644
> --- a/drivers/net/intel/ice/ice_dcf_sched.c
> +++ b/drivers/net/intel/ice/ice_dcf_sched.c
> @@ -746,8 +746,8 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
>   {
>   	struct ice_dcf_adapter *adapter = dev->data->dev_private;
>   	struct ice_dcf_hw *hw = &adapter->real_hw;
> -	struct virtchnl_dcf_bw_cfg_list *vf_bw;
> -	struct virtchnl_dcf_bw_cfg_list *tc_bw;
> +	struct virtchnl_dcf_bw_cfg_list *vf_bw = NULL;
> +	struct virtchnl_dcf_bw_cfg_list *tc_bw = NULL;
>   	struct ice_dcf_tm_node_list *vsi_list = &hw->tm_conf.vsi_list;
>   	struct rte_tm_shaper_params *profile;
>   	struct ice_dcf_tm_node *tm_node;
> @@ -770,12 +770,12 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
>   	size = sizeof(struct virtchnl_dcf_bw_cfg_list) +
>   		sizeof(struct virtchnl_dcf_bw_cfg) *
>   		(hw->tm_conf.nb_tc_node - 1);
> -	vf_bw = rte_zmalloc("vf_bw", size, 0);
> +	vf_bw = calloc(1, size);
>   	if (!vf_bw) {
>   		ret_val = ICE_ERR_NO_MEMORY;
>   		goto fail_clear;
>   	}
> -	tc_bw = rte_zmalloc("tc_bw", size, 0);
> +	tc_bw = calloc(1, size);
>   	if (!tc_bw) {
>   		ret_val = ICE_ERR_NO_MEMORY;
>   		goto fail_clear;
> @@ -875,6 +875,11 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
>   	return ret_val;
>   
>   fail_clear:
> +	if (vf_bw != NULL)
> +		free(vf_bw);
> +	if (tc_bw != NULL)
> +		free(tc_bw);
> +
>   	/* clear all the traffic manager configuration */
>   	if (clear_on_fail) {
>   		ice_dcf_tm_conf_uninit(dev);

-- 
Regards,
Vladimir

