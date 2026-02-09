Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5558E94623
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 23:19:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 136B040611;
	Tue, 10 Feb 2026 00:19:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5A431400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 00:19:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770679158; x=1802215158;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=GPnK6+hQrZDerHtvNNlX0UuX+8KuLY3k0eWvONqSQis=;
 b=BhF28JAhRXTwiRx+Cc60Zxd21nd+zAdoLczH1ixae3tYlIwCzUz79WII
 BDTYBVS4FUTQnatzcCF6fGoN/AQnmYEHBYmFXM39dihaQcc0qt+rzLLjA
 d8vcGRtIjyNGasQlUoyW0al+6z0GUEh4JrucCU8SB4KGk/XTbF/MFE18D
 i0uiGhfKXtqPx/2j0PG3VUrnBJcthieQbImA8VVKIwGjpRfkEE8mWk0SB
 6xxkkQHzbYyLPd/OcnehzVktf8OM3Ezld/tsZE2/mNKSK/wdwWfiiiebD
 1YiYQuUGnPUWTupUslQAlKwd7Enb8LjAgu2aUNI3ttDyN5kl47abORpCz w==;
X-CSE-ConnectionGUID: xpgc8S7LSyy3X0jaAk1rjA==
X-CSE-MsgGUID: nhoBkpdDTjKrH0+SpAx1ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71840308"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208,217";a="71840308"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:19:17 -0800
X-CSE-ConnectionGUID: n8XFzT/3QEaEtAgVLaA6QA==
X-CSE-MsgGUID: z3o/FTPWRLynlTtU5UAXWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
 d="scan'208,217";a="211749832"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:19:17 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:19:15 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 15:19:15 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.23)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:19:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yif0ffs+2DoNFn7cECZt+g6xwJmWnh/ZmLPuSj99ytY4USFi93CQw8qsug5t6dlFcE7tsbsb7mI95BJTfRnWE3+kJ4CE84z06IWlX9olLgiKwl9wtWYj9Caoco5PaFZMwobNFRNQNsTyKUmkv+a16V5OK0MVCR91ZlkPGOLFNj/xFHVNb+QoiS8q74f9R8B3hSpKuY9cojn46cItrcDYvb9Pyt7Ulz6HqfEgx2hU5HxUWS8EUamdDaazYnYtUwpPsIGHQwAOkxcRlUc99Nm9QDSfN+XEDxEwoO8s4i71y3AlPFXOSyDncuca/NEV3bCsfAm8aH14jmIHoVrSfR+8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ytCGLpJyxaaBFnOswEma1O6gI4v7UCcPLiiDiupc/E=;
 b=GPccC5CnEBnoBbxMr11XSwvr16pw+pzDshkbOoCmvVWVvD9vEyomryn1RbOySf9V6nxYvltcPVXT2uwmKlOJxd+o3aenZhChPEJW9U8REq1l43nlECdH906kvfP0bvPU9vBNItnqqcVKQ0jHsrISr39fHQKUzAlAt+9dFDlX0rGQCEezIQ1CIZpD2bmZibm1MZWQ472ysaetrQ0gLb1kQSKD6BwWoGlWBB9lzRFT3YsKMZuGR3SK0cHXlw6rySlF/PwMXJQ9fiv0amfIsoC9i3e6qVNtqwakyt9ZEBNued+XIuDjAREK3a/xRRURBTVuCIZyRvG3o/xqIX/tVA5wWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 23:19:13 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Mon, 9 Feb 2026
 23:19:12 +0000
Content-Type: multipart/alternative;
 boundary="------------7pLuHPAn5puUuGZVrgIekZKX"
Message-ID: <fafaa8db-e741-404b-b62b-2f70d7c166fd@intel.com>
Date: Mon, 9 Feb 2026 23:19:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/35] net/intel: consolidate ice and i40e buffer free
 function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Anatoly Burakov <anatoly.burakov@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-30-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260209164538.1428499-30-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0031.eurprd04.prod.outlook.com
 (2603:10a6:10:234::6) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CO1PR11MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: c02dc46b-2b10-4f2f-6b1e-08de6831a246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2Z1YkhNSnE5cGwvSkVPcHIrK3JFQzVEVWMwb0M1VVRRMng3Vkx2WldVMEZQ?=
 =?utf-8?B?WjVLbFdHV1hTTEd6UmJLSlpjNURFN3ZJM3ZjNzhJVHYwNjdERVpzSUIxNE54?=
 =?utf-8?B?TG5USVNXWlh4UWhJR2ppNXpSajh1eUpVb0p5aW9SZXhSdGVVc1IzYU54M3pN?=
 =?utf-8?B?a2NLbkg1RVRjK1U3Zy9Qcy9EbFJubU1EbXNUc3dFNmFUR0U2YlBtZ3Zkcmpj?=
 =?utf-8?B?UVRTUEI2MzJmODdpQlJ3Wm1RaHpkQ3cvbG4zczVyV3dBaURzdkVaWEpOVm1T?=
 =?utf-8?B?UGx6Y0YzRE1yTUpEcnNLMG5wL0dxaTJIOVg3VEd0dWdrSGx2LzNHSW1zM2oz?=
 =?utf-8?B?RkFtNXNReVVyRy9CeFhXVXBYVlI2SEpIaEdBbzl1L1VVVTBzK01nOW5nYlZ2?=
 =?utf-8?B?Z1l6d3VSa3QrQ29Ibk0veTJQQk04NzExY3dPRVRybnYxc1ppTVQxQ21GaVVr?=
 =?utf-8?B?RmVSakY3RG1Vc0VkVDFZbUpTd2ExOXZsOGJ2SW02Z0hDT3BsZ2w4MjBIRmdi?=
 =?utf-8?B?VzRob1diaFM2UHduWlVIMEIxV25udUtCMDBFMncrYktuTU5wUE5sQ1RaTWVM?=
 =?utf-8?B?WnB5RkVqcHNRSWVTamNHN2w2RHZJa28yeEtMWEg4U2trQ2g5c0czNWxXSFNT?=
 =?utf-8?B?TDhHa1ZnUHVTc0RZWkdFWU5XaXBNeFpGUHZzZUN2b2MrWU83Ui9tTWw1Q0NK?=
 =?utf-8?B?T2hRdFRjajhTSk1JS3R5LzRpcWp2UXg0WlgrRXdpeGNlUGM2UmZEc3p0cWZn?=
 =?utf-8?B?OFBNUTVTSHVDeTdiZ2NjOVNIZWl5MU1ueEllZ3UzOHpVUkVyZUI2VjUwTFNn?=
 =?utf-8?B?cmM4Q2gvOXFIZnZKWkFtNFhjUUI2ZGRxdGtwMEFXK0ZVRkx6QUJwQWk2SDZN?=
 =?utf-8?B?dEFzd2JLdlhFSFdVeW9qV3ZFQ1BCa2phS1RtVHNac2I5bWJic1NQOWlJeWJS?=
 =?utf-8?B?WkR3WE9yQkxuTGF2c1dMd0Q1czhTU3BUV3pRNXlXbVZkRG90YWhyYkcxbnBF?=
 =?utf-8?B?M01aZFgwUGRUZk1TcnFPSG9XQVY5L0RpQ0pzTVp3WFlEeXRURnU4YnBMSHVE?=
 =?utf-8?B?eHlKNWkyd1U4bkdybDFQSWJJV0M3WFZSbzMyR3VxU1cyMVdSSzc1cDNWL1N6?=
 =?utf-8?B?bk1QNk9hdHVWd05OZEUrK3lsTG80WVZ0aVA5RlM2eW9Faml5UmlWN2E3dk04?=
 =?utf-8?B?bWM4U1c5UmVrSXBKc1ZTOFo2UWNlK1p6a3RVZmVycThzY2QvM3JQN2t4Y0M1?=
 =?utf-8?B?enBKdDNTUzFrVmRjaHM2QmVDWkozMEZYSnFOb25WTVdLbEl4VXgvcXBYREZu?=
 =?utf-8?B?YWltRE1FdXBnaXFRZkIrbkJPRG5Ncy9zUHlUVkVwbWFmaUFGNk1UZWU3YmJ3?=
 =?utf-8?B?cXBMZDNVUHAvTWkzNUZMQXJkeFU3dFVmK0puZTNuTHp1Wkp3UUR5OXZZUGRP?=
 =?utf-8?B?MXpmbjlUcTRTVFU1VHl5T09vTGNwVmk2U2xraXZQQlAxOUwyMlV1RjNPZWRI?=
 =?utf-8?B?ZkNXam54VUpzcnlOaE1IRHpyUE1vUEFCeHJjcmRsd1d4T1hPT3pWYmpkakw3?=
 =?utf-8?B?eUU4Mkl0ek1ZdmtVeFJCKzI5b0hKbWVLeDJWNm9yUEdTWGNsM3VRNUxiUGlo?=
 =?utf-8?B?RTcwNDNDK1c3OEJJQzcyUmdvaWVrMGM5YmVCMzBXbExyWUxLaEpja2tPeENo?=
 =?utf-8?B?UG56SmhxYmdQbzdIcVBNNTl0QTNsWDVuMDNPWkhwbE9TNVVJbndibVpWMWY5?=
 =?utf-8?B?T1ZOVWVNNmg3YWt4S0pTZ05SMm1uK1Q3a3NrL09ZMTNXNzdWUWNKbVZSOEZq?=
 =?utf-8?B?amhLT21nNjBtUFkzYnVxZnBXVzgwWFBBbDhpN1ZGelRKZHhLZm5pVTlMeDh3?=
 =?utf-8?B?OGFYNFR5R0NPdDRWZmZtNkMxMFNCVEZ5eG5KUGJ0aDdFaWxBNE5mdDhNWU5a?=
 =?utf-8?B?b1hwV0M2djZVbHVaZWc1bHU3emtHMjR4amRtN3JUd0ovcm9iTE5VajZsTDlH?=
 =?utf-8?B?MzNsRkRBdHc2bEUwNHNFSUw3d1RtaVZrSXBNdEtnVktNR3p2WnozS3dhQVJO?=
 =?utf-8?B?V3NVR01IQjU0Nk1OSVF5USsyWVd0NWRJdHR1ODdIeEw2b1o2Z2tINEk1OC9S?=
 =?utf-8?Q?yITs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2NjTHpEUU81WDg0eWYvaGhvUS9VTWduWHljTGp5ekZNWmFrN1BCK1V1RmZp?=
 =?utf-8?B?aWY5OE8wWXFTaTA5Yjl1UFROc3Zya0s1bWVMTnByQ05KWjBPWURrMWpsaFE4?=
 =?utf-8?B?T3VsS0xSditQeWF0QzlUcGZRcVFsK0tIRnNMdGdxRFFVTUJZUXJBbk5WUkxG?=
 =?utf-8?B?N3E4akcvZGV5V0FSMHdTS0w5U21yY0g5cVZVbjRqVUpuREJTQXBkZllJYlIz?=
 =?utf-8?B?eHpsNVdhQi9ZSUxwQ1BTeG1zSytEa01DK0xWRUlWWnpJSXRYaTEzNkdlTXd1?=
 =?utf-8?B?cCt6SEFjNCtxVjZRMzhNYWRiTjJncEwzeFlxZmg5MERFTHU3d25tdVd3ZUFr?=
 =?utf-8?B?ck1saWUzMVQwZUFteEFZRVRDajFBYUdsQ2JvbFcyRHZ5ZzFiaU5YaFc5a2h1?=
 =?utf-8?B?eDh0N1NzTVB3dVgwZzB6ajA5T0FSS1dsWmJwZGdhdlFXcDJpZ1UwRGlnZlJZ?=
 =?utf-8?B?Q3dFL0Y1YjFPZUZqT2JTT0VSa3dPemlZNUtnNlcyVWJsd2RjN0ZWTWorL2U0?=
 =?utf-8?B?ck11MjVmK2dpZFVPZGQ1eFBpaXluRHNTVXowVXdEck1aLzdlMU9aeGdUTFlE?=
 =?utf-8?B?VVhjWFdSV0F5SEN3cDJwTE9SaE94dkJ0Zko0M200WmRmRkhPaXNtamQwRDFT?=
 =?utf-8?B?RGE4c0F6YzZjQ3BydDZSRXZWaE95KzdaT1pKRmxFcytacXp0V1lNUEJSbGZa?=
 =?utf-8?B?d1VYMFBIYlNJYVRNRnJ3UnNkckk0WTQ5MlcvZFVKN001TWozNWdONHV6VlBI?=
 =?utf-8?B?d212WFM3OG1FSG1lZUtpdmFrdjJNdE8zMzJYd2hTbkVsbWtaNnFWS01BWmlW?=
 =?utf-8?B?ZVNnQm5mSjE4Z2FqcHEvQVF6MTJlOGNiWTJjcGs0eVllUWFIWkRsb2VNcVNB?=
 =?utf-8?B?NXlIQzZCYTZtRVM5N2VRODJyUlc5WE5pajlsYzc4bDl6KzYveVBhakF6YUNo?=
 =?utf-8?B?cUlFNm16NWFZYWVSdi9BMm0xMFlFdWVjOWdVam1WQUNSK0FJTmhmZjR0K2ZK?=
 =?utf-8?B?MG1kSzNNTkJlVGtzMUw1aVNqMzZYQS96YXNNYnZRblNxem9MUFp2SzdmTGpq?=
 =?utf-8?B?MmVoUkZjR1A1dkNCUzJQSlF4aGc5WU5hUWlGRkgvNW13cmhnSjhyN0tSUnNR?=
 =?utf-8?B?dHp0akFPRWRoby9OZjYrVCt1WXdrKzNUT0R1dmlpbjMyclVkN0s4d2tRdmk5?=
 =?utf-8?B?QWVsUnBEOUtxWW8rdUVIenNaUFk4NFR5L24wQWkrcjF1aFJRZUQzdXZ1QSt0?=
 =?utf-8?B?Ym8zQUpsTmhsK2VWSy85UWowKzdwdldGdFF5QjNLSmxlRFBBcU82TUlRTDJZ?=
 =?utf-8?B?Z2Y2eVhhWU1XNW9PUWhlWnFBQjM2Z3lGY2pUakRiMGJSbXE1eG14czFMR3ZL?=
 =?utf-8?B?a0tXZnkwZW1TMGhGdXpZTmU4MHA1dkdlaFBnSks5L1ZDUXJlNDVjWm53eHFT?=
 =?utf-8?B?R01ZWENFNFQyYkx1RUQzTHNTc1h1UHlBQmVKZ21KK2MvTlZuT3psanRBL2JP?=
 =?utf-8?B?QmF5Tk4rdGlZcjI4dk9sb3MzU2VIQ1pJRmhXVDZuOVNodk00MEhaa3d5ZTRS?=
 =?utf-8?B?dEd2bm1SK0VmbnpHTllUeFhDM2UyWGFDR3N5TFA5azNYSzZRZGNMOXkranFO?=
 =?utf-8?B?d0F1d0Y0cWRud1hYWDJUYjNSYkdackRWd2dvUVBlV2Zaa1FhNklVZDB1KzJE?=
 =?utf-8?B?TEpqNTJIa1M3VUhRTjIxeXZ3d013SE40a2dQbkJ1NHpOQUFhWVJ6UzVmSFl2?=
 =?utf-8?B?ZXk3SElxUVVtdVR2dzJqWHI3dmxGS0pFS0orVDNZV3BGZ2t2Ui9sSjNrcFl0?=
 =?utf-8?B?WUh4dklXWm5xNXJrVlNCZzBXclhpZnZ6NFdiRHhPNmNMOXN0NE82UFo5akFv?=
 =?utf-8?B?b0ovQndEWDBGQ2o5LzNSVXltbDV2Sm5UbVB6eFlDako1aE5NWWZJcGxSNWZi?=
 =?utf-8?B?QW9SdlhkV3NWb1hnS0FPQ2Fqc1VobmlvcWxaYkxwcEErSmwzVlE5THJ0WER4?=
 =?utf-8?B?aVNoMzBaMmdLeGVIL0RWaFZHMk9mbmpLU0w5K0pnaytCZmVEbzR6NHdua3ND?=
 =?utf-8?B?eHI4dHZqd0RuelZDNFJFdFNyYmhSRC9ESjlBZUNZNUFLTHZvQ1hSMUk1VFlE?=
 =?utf-8?B?U2VIOEJ6Vi8wSTRSRGtDNU4wRk8zRGt1Ymp2NTVnZlFpZHJtb0Y0NktxOVJs?=
 =?utf-8?B?TCtPTlFkd0hrYlUwVDVCK0lQcmw4dG1IQ3d1Qy9OTWtJZyt0VXQzY0VlYzBo?=
 =?utf-8?B?czR5QmZwSmgwcHZKeXVaRE81VkV6QkRoV0oyUDNQOXZ0b0VkS3NzbXFDb1dB?=
 =?utf-8?B?QjR4M3FGTjFUMGF1R3ErTThDYnh6UTlMTEtyVUQwN3doQXlsWFBUT2lrdTdJ?=
 =?utf-8?Q?WgUd8+0r4eQ8oFOk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c02dc46b-2b10-4f2f-6b1e-08de6831a246
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:19:12.0031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FqIg/JXD5PhfKPvu99NCkkLSwL0PKmX9WYIL0nVaR+mRDZmDnj8A5Dp8FifGTo1+ciDXMIoKLYzPb9X/uRogpi9dWWDVTKT36ibMCBmZRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4898
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

--------------7pLuHPAn5puUuGZVrgIekZKX
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 2/9/2026 4:45 PM, Bruce Richardson wrote:
> The buffer freeing function for the simple scalar Tx path is almost
> identical in both ice and i40e drivers, except that the i40e has
> batching for the FAST_FREE case. Consolidate both functions into a
> common one based off the better i40e version.
>
> Signed-off-by: Bruce Richardson<bruce.richardson@intel.com>
> ---
>   drivers/net/intel/common/tx.h        |  3 ++
>   drivers/net/intel/common/tx_scalar.h | 58 +++++++++++++++++++++++++
>   drivers/net/intel/i40e/i40e_rxtx.c   | 63 +---------------------------
>   drivers/net/intel/ice/ice_rxtx.c     | 45 +-------------------
>   4 files changed, 65 insertions(+), 104 deletions(-)
>
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index ef6d543e7a..67378a0803 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -66,6 +66,9 @@ enum ci_tx_l2tag1_field {
>   /* Common TX maximum burst size for chunked transmission in simple paths */
>   #define CI_TX_MAX_BURST 32
>   
> +/* Common TX maximum free buffer size for batched bulk freeing */
> +#define CI_TX_MAX_FREE_BUF_SZ 64
> +
same here, eventually it would be good to replace all the rest {IXGBE, 
I40E, ICE, RTE_FM10K}_TX_MAX_FREE_BUF_SZ  with this
<snip>
>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

-- 
Regards,
Vladimir

--------------7pLuHPAn5puUuGZVrgIekZKX
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/9/2026 4:45 PM, Bruce Richardson
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260209164538.1428499-30-bruce.richardson@intel.com">
      <pre wrap="" class="moz-quote-pre">The buffer freeing function for the simple scalar Tx path is almost
identical in both ice and i40e drivers, except that the i40e has
batching for the FAST_FREE case. Consolidate both functions into a
common one based off the better i40e version.

Signed-off-by: Bruce Richardson <a class="moz-txt-link-rfc2396E" href="mailto:bruce.richardson@intel.com">&lt;bruce.richardson@intel.com&gt;</a>
---
 drivers/net/intel/common/tx.h        |  3 ++
 drivers/net/intel/common/tx_scalar.h | 58 +++++++++++++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c   | 63 +---------------------------
 drivers/net/intel/ice/ice_rxtx.c     | 45 +-------------------
 4 files changed, 65 insertions(+), 104 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index ef6d543e7a..67378a0803 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -66,6 +66,9 @@ enum ci_tx_l2tag1_field {
 /* Common TX maximum burst size for chunked transmission in simple paths */
 #define CI_TX_MAX_BURST 32
 
+/* Common TX maximum free buffer size for batched bulk freeing */
+#define CI_TX_MAX_FREE_BUF_SZ 64
+</pre>
    </blockquote>
    same here, eventually it would be good to replace all the rest
    {IXGBE, I40E, ICE, RTE_FM10K}<span style="white-space: pre-wrap">_TX_MAX_FREE_BUF_SZ</span>
    &nbsp;with this
    <blockquote type="cite" cite="mid:20260209164538.1428499-30-bruce.richardson@intel.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
    &lt;snip&gt;
    <blockquote type="cite" cite="mid:20260209164538.1428499-30-bruce.richardson@intel.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
    </blockquote>
    Acked-by: Vladimir Medvedkin <a class="moz-txt-link-rfc2396E" href="mailto:vladimir.medvedkin@intel.com">&lt;vladimir.medvedkin@intel.com&gt;</a>
    <blockquote type="cite" cite="mid:20260209164538.1428499-30-bruce.richardson@intel.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
    <pre class="moz-signature" cols="72">-- 
Regards,
Vladimir</pre>
  </body>
</html>

--------------7pLuHPAn5puUuGZVrgIekZKX--
