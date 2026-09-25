Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D37C98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 10:50:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D02D340608;
	Fri, 25 Sep 2026 12:50:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id C1492402D9
 for <dev@dpdk.org>; Fri, 25 Sep 2026 12:50:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790333428; x=1821869428;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=UXMByTvO4FoSkQFNcb74TT8Wz/UGYbANCRuREeTM6NM=;
 b=Bi2BH2J/dFjShKiI0P2+t2Z4Mc4DNb7hxXM3Punvi//BpfivMHRd3I9i
 fAS592VIfx1sGCm7Ga6ByBJAWVrnBqcXF7Z0UfNfRpFrkwAE77P22CVKt
 xQDUrCtiDjlwwnqfgeb75o3U2LO6uWMoJ33LBwby3VlyOVr/4rQGeGQn3
 7wRtqg6txZn1t9gyq1VUO+u2pIduRjQu5UmoW/dICH9XmT3oe41kI1952
 309FUqO01euZRNLR0yh3X1AvusdMY8QYcL2UDlsFbGlsIv8aaLqPM1Hrt
 mC/j/ikVf0+3Ah2xhKKsqncu7xkPir7S8paWD5iGbnCj+1P3dIJSQtdqO A==;
X-CSE-ConnectionGUID: LM9QnaL8QcyL0rTXE/dB4w==
X-CSE-MsgGUID: JBK5nt8YQvqJjSiuyjexYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="94935178"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="94935178"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:50:27 -0700
X-CSE-ConnectionGUID: HGYx8yb/TPCi3JkfPqGJdA==
X-CSE-MsgGUID: DOjlvqS1R8iazgl96/3ECA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="312227363"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:50:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:50:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 03:50:26 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t322UvDbqmkV7iThHdpqqgRj/bx7stjnNi4C1anj1eWDhiLFdR92HBIjolguxz5ep/93oL9mgYYbWWFq3IsQLCjP8h7pPQJy0wN5Z0znAzLACiWKRt949lS8z4aNbRHJC5Oeq7SBg+LaxUcNxK1IZaStkE7D7Zh0/sfB9nXtccm99kUVfdGIrtjUsHRDhBc1nqcuMT03nuaugE90Eppq6BOqBadtDb/gw0rN1TCJ251bvInLakPW7+GW4Fk45mOFxPZ7o8FY6Lxy+d9sem+gzXncHXJREl/tUpk/OBBqdayncyFNig9CLi2adffenih4KyLqh4xlPP9rffUN7wlvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FD7App6H9Q1zd8kXtqXVXbBozaCI44JAPSw23vmz40=;
 b=rWvIY9wkUCi6wr/TeuLua6zDNuXc4xoHbGy1m+4QZRiCVlBv+JhcxWD9/zPco1h3LpHIs9H63D6u2jWv1zmpGvqAad/FhBhTXGXoT3c3gzIfQIF3lIYX3PsKj0zOXqxvo/lcph0Zakn2uKeHol4QLQE6vHR1sSWoOvhvZwLT6nv316in8FST15zYlYaK8fmtbCfvd382lA8gPy4SHPGCNecwygBZvMA2V/DR65wRPqu1HTdCZAfwoomEEFXIjY3k0yUX0DvLKXOzYShx+VUDONNdn5Fa1pUWBBxLX86xrjIGqdxugH+p8rYjpcwrEvm9YA4CHSAjVHyjAaBSHGhoMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA1PR11MB6467.namprd11.prod.outlook.com (2603:10b6:208:3a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 10:50:19 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 10:50:19 +0000
Message-ID: <7453e71e-877b-4446-9122-80d6ac609d86@intel.com>
Date: Fri, 25 Sep 2026 12:50:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Fix inconsistencies in offload masks
To: Ciara Loftus <ciara.loftus@intel.com>, <dev@dpdk.org>
References: <20260924131346.100156-1-ciara.loftus@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260924131346.100156-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::19) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA1PR11MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 39879f73-d03d-46e0-0054-08df1af2ca69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|6133799003|10067099003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: WLeX9wyn39HZzP7+yCFvbgGoneDShYYcK6SOctwJQ7Pm0g7cuI41u3UYxObLZ8f+XRjnXBMkw2Yu9u5j7NiIKSXDArSNzvVJ/XSyD4YKZkkrnhmOhOZhYp1UdsbYmjC/nulrtghL+6HyJk4jN2+oNZuX+dED9RyYZS74kOHXnzBJMa0I2srZPMd/1K5Ms86B4L4fRLt35Eah5wlHHlYGvL78wxoaTdMqbGs0FMIaRaS4v6s8TS3Sb7OTkxemxRDZK4KqZe3WOk2pqUZE6cZDYeuG1Tb8hJzFcTVLupaBKnNsA7mRouaDqrXd6+fo6tgDV23nnZq3XH/4cXsm0iZNkaFYCYin/rDGpu5FH6y9Ks1YJitrNR+s94+ZDZiNx2Dxmpt4KGMAAb33XBIX7pMnSUDqtcFq3itAH1hHU5GhPmJQImPWWMCiEYwV8PjEyXGPqAyz+4cM+XBgUzCL8vYXWm07bzVgMrpiHfU+UTx8ADn74DCzdzfTq0jv72mr/fonF5F0uxpg/SoGV7MrNNx8z9xIp4NH1j7oOWvXars1qtHVEbn5st64fW66bBbByztJNLfyCeAYYLYq24i23PAbzP/AqpcXDa83x8M2J3HqVRTBT+UHv6AMTQxw5it7aUOT6h9F9ks8JQE4LOoi8/tskhSPz7zy8N8d94EbnsGkJkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(6133799003)(10067099003)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjlSWmdCTG8zVDhRaE5keGcvRm93YnpJMERXWnFZSnhhQzU3aUE1eFhoOUF0?=
 =?utf-8?B?c3o2bVprMUpES3BSOGY3T0U4VklWSDR1VHNPOEcrd2NQRXRpZFdiL0VKakV1?=
 =?utf-8?B?VFF4WElTclB2Q1MvKzNRQ2o0bndpZlh2WkF6cTFESlNsZk1JNTVCTjNOMWRn?=
 =?utf-8?B?d0RsZ1pncC9XQVpEdHJQT3pXVCtSQUdSaDVneGVVSjFBbnRXaUxKNjArQWIy?=
 =?utf-8?B?b3YvTTR1bVZhZ3dVRzZZbXlYY2ZIS3hUOFN2dVhjNVNMUmpzeDlGQytZRVlP?=
 =?utf-8?B?YkZXTmdFdEExeTdVVG9VdzJVcGt0cFBWNW92N0d1ejlSSzQ0U3duODlhSVBB?=
 =?utf-8?B?Y2FheCtSbEdxczJxVGkrbnVjRWhjNEpuNlAwVjYyZ29aNlpCeDZIaVhPQXkv?=
 =?utf-8?B?aVFuMnRpQkl3Z1UwVlNoby9ZdnloV0trcXlxWFNOVVI1eVF2a1E3SnhSL1V0?=
 =?utf-8?B?bUVwV3pKK2V6VjBoaUZtZzFxTzB6bTcvOXE5UXRDQVFDRllnN2RPL1QzcXNJ?=
 =?utf-8?B?VTZlRmUrNERHOVhoY0xJZVVqWnhIQThZNzJGK2lycVI4R20vZWlEbVVJOWx3?=
 =?utf-8?B?a3ZxdjAvNWlCcE9VWnhBVXVXYk9jb2dtTW9OL1dBZ2V6V3ByVzhzMzZxelVF?=
 =?utf-8?B?MFFRVEJhb2FxdkZsb2pBTVMvbEZqeStHb29DaHNtUjNVYm1EL1pNajA2bmtC?=
 =?utf-8?B?bWhvclFLUHpqTlJTcklyMFJrYjdZd3BsSlQxOG1JcDJGaFUvVHo1S3ZyK3BW?=
 =?utf-8?B?TUlLTFN3U3YzNTE0dHNIV0ZOdlZMZVZvMlVzdVlHejRQcEVWYmZ2L1Byblh2?=
 =?utf-8?B?MHFqOWg2bzlJSEdRd0FwcklZaDc0cExOaWNKVWRWYlBMUXBiTzRjWEVnMC9o?=
 =?utf-8?B?RzdPMnAvM3IxSXd4Sk54SFhKWjBDVUdrMlV6VlFta25EL05zUENnQmtLOVBJ?=
 =?utf-8?B?VFlsWWxkc0pTTWpucFhlWlR1OEdtbGpRZkkvUitBZ0EyaUY1SWVQbkErMU9x?=
 =?utf-8?B?SzlLZjBmbFIwK1k2bFh3R2xvY3JKNDBNdTZCelZlMFF1T3kxMC9ObWJHczho?=
 =?utf-8?B?dSt3Ky9Bak1JWnBIVjBXNFF0R1dtQnZFSUhwUGNDNnhWUW9uWng2akpoR3l4?=
 =?utf-8?B?UUNRYVM4bEl3aXlGQXBrMHZqQUNHa0dBL0RUM1Q5UnRTMlp5cnRweTAvTFN0?=
 =?utf-8?B?VUVjcDZZVEtCU0JLUWtxQ2ZBSWdrRzA5YWVqcmx6VkVtTGFBejFjVCtLQldz?=
 =?utf-8?B?MEZ6UVJXeUxwTkJoQTdSSUJGM2FVSFpGLzJ5eG1MVGtQWXUrUUJ4bFU1dmlm?=
 =?utf-8?B?MFJrQ2hlRGJVZmFCNGlBZHRmS2FyRFdsaU56MzJ1VG9kb0V2Skw1d0FqOFk2?=
 =?utf-8?B?YlgxRUtaYlJQaE5HNGJjc29udnh5d0hhakFkSWE1RC9meXdaRFVOQXo3RDdO?=
 =?utf-8?B?R01lNjNaYlROTmY4MEd5RysyRXBjUWJ2cEZlc2xDcTBKSnBKQzFnUTA1anVF?=
 =?utf-8?B?MnJDK3pWb2pwYmh0NHRicG52YllrRDhxQVRmeWRPUGtzZUVCK1hWQURqd2Vz?=
 =?utf-8?B?SlpvOEpjN1RyZTI0Uk5sMHc4R3NvZ0hCeDNXanUyZUNrK1dvenc2T05ldzZM?=
 =?utf-8?B?emcyY1FhanRWTWNrZWJkaDR5aXlDT0NWVnZVdTgrVWo5Z2Z0MzR5MGM2eDJ1?=
 =?utf-8?B?SG0vZGdrc1paMUZxMDV0Y1N0dW5yUGU5WldYbHNtWjBVdjRrNEJra1NTc1hX?=
 =?utf-8?B?bjdlVC82WTJFL2lpMEhSekpNZG1tYlVTM0NhdE5vcXlmUk40N1VmcFRTVVhY?=
 =?utf-8?B?ZUs1emdObzVIZGJwUmI5dUVyTXhZeEdGMmNOYllDYUZQMTNTVE8veEF4Z2VH?=
 =?utf-8?B?UkJISnl1eWovOFBIOEZHZGFOR1A1SHJSQmxnYUFHVTgwY1BMTTdrVC8yZ3FL?=
 =?utf-8?B?ZmxVOXJkdFUwTkVoeUhqUEVEMUlqT3lkRDJ6YTJWUm9aZURiL3lGOWhIVWcz?=
 =?utf-8?B?WjQ2RUJCWVFhNWlnbjh0eEh3R0N5b21pT3BjME5rOW85b3Y0TmNDTGpPR1BN?=
 =?utf-8?B?Uldqc2FwQ1RRVnowUHBZNGdwVW1wZEY1dDZ3WWtTR21yQ3liK3I2ZVpkbkJT?=
 =?utf-8?B?TUlZdzVJQUY5cHQrdlNYajBpVTNYWTZoRlg5UFhWSllQRklRSXhvdWVrbk5Q?=
 =?utf-8?B?MnY3eDVMVlBjb3NkcnVuYjY1bjJDdDFjVTltNGpueGx0eDVIUUY5OTZzV1ZT?=
 =?utf-8?B?YnNZYWFhOEpDaHphWC9haUZwdXUxbkNIWlBiZkVVMHRJTTBJcnFPQ004TUIz?=
 =?utf-8?B?QjA2NE1aQVhnaVhTWkZRZFhjOFY1R09oSFMrOTNHQW90Z0lCbEdkMFd4eTVX?=
 =?utf-8?Q?07qyDrb1/tecPohM=3D?=
X-Exchange-RoutingPolicyChecked: BreGysBeRsffSfCsUjiXLtEH5ILkcd4cegaA7yP/lHZx1KQUpN9NIxmPmy5MQbjz32AEnS0I3LDo21+uFlsRU9XRLSuFncFkF+PrsyX7iiGi4vpKXNNWIoyywLl1tfXDmRWP/GmX2Bg0vUkeJsW66locs0Emsy7b1150Tq+mPSf7ttGgwx7eUPd/0LXeRJ1mCtM6J1iQQ7l9X9rKiqH0DjgybX/wRd9UW/rEiSDxljGtaiUld3+kNMmhuWuuANCsXYicRhFKOvJ8AT4zbXv5lOplEvXiJ7dNfczNrjp+zZoEpkd1mX9pmJGKKIvfItkgjILYupmVSlLHetKnKVLqSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 39879f73-d03d-46e0-0054-08df1af2ca69
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 10:50:19.1527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28Ybs1blKdRsFinLvRDy0IA+xFoTC/ekzhGqC8LDnOUo43XcqzkKmBOWVrPP0R0qxYjsYEHOyBA2cu1n44CGbb4jVMjdqCbjCW+OY1L/Ets=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6467
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

On 9/24/2026 3:13 PM, Ciara Loftus wrote:
> This series fixes some inconsistencies in the path offload masks and
> dev_info offload capabilities for the ice, iavf and i40e drivers.
> The first 3 patches are concerned with fixing the path offload masks.
> The last 3 patches change how offloads are derived for the dev_info offload
> capabilities. Instead of defining an explicit list of offloads, reuse the
> information that is already available in the path offload masks. It should
> help prevent further inconsistencies in the future.
> 

Series-acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
