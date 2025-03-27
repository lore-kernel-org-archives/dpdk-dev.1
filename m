Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CFAC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 18:06:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3C5D406BB;
	Thu, 27 Mar 2025 19:06:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 7FB0640654;
 Thu, 27 Mar 2025 19:06:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743098812; x=1774634812;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=hKeQnXqtqpcEseei23zV2iDQuf4DP+zUMJIIupHcaao=;
 b=hVErwv/HwJHkSDGGLb1Lss0s2V8v2b9O3HsPlK5hWkFF1fBk4XiQgr0+
 tq1NTAu2dtCjKPHqTKRlxFPvJ92Uw0FjNVNWV7l1aiGn4QWsfO2UgMwS6
 OhkGX/5w/qFM3iEcFQ2wVSg6mGafJggnBUbu/ZfO8O/704EKMSTc51JEC
 l2jhhqkOaNwmKiZkt8y+R/z1BmvMXJujc7aeLA6UEDhe4CkeGOsnYwdv9
 8q5aGx7JgzZLSugNKSBYo+TVHDNMGAVeofaU59BW0/H9GPMWCYrFSGO+f
 DumzOLQsv2BJWgquFMWuA1asLkzLznFVoI3uzkZDgPCRCTn1Rh6DDtr+P A==;
X-CSE-ConnectionGUID: C8ks6qgnTbWsnsBC9ylsoQ==
X-CSE-MsgGUID: ierSyxb1RDmtL8BVCclHQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44573498"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; d="scan'208";a="44573498"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 11:06:50 -0700
X-CSE-ConnectionGUID: AKp5Dvz1Qi2j6JE5ThtX+g==
X-CSE-MsgGUID: XUZ0nPcNT6+1nSGZ4oeJTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; d="scan'208";a="129932238"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Mar 2025 11:06:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 11:06:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 11:06:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 11:06:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kq5qGhLmev17VJQAKWuMakiyneH9eKo1YNCmqNnw5JDR6Uf8oIZqeNp61M7CqdtWojAbR6oqDyshNhIYLdO+xamSX5hLUXlKBhukg2V5WLKdX+6HH90QQOi+n566SCrixk/m59gnJ1MEMJmcMEPTlbZOEC8/hc9PKbcYy7PQMwH+kZbfCzj1VgyUN36DTZByUSkPK/QTWrzKD3Wzqbl9JWy3cv0lGWC+Tg/oWbMrXeH6IVmsOkxBN/lQfpPpbhhZpjYkN/kDPqT43YIaCDZVS1qArAMzESZks/on8VB4z8BmihlEsh1Sz7UiZN6mXFia1Ap+ZTnVP+zdwRt4xhetnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIZVCKNZ4nk237vygpKGQWY5iigIbhscpEyF07QQypI=;
 b=MxgN54mAFDLeqzgOViVrCTqzMfTrf75C0lAjcKOtjrXrek9Ive/CrO+TpB/03fvhhCq+KLljFSLKloyeJVHjObpSWbg/JyzR+SYvp8YlTpWL3Y5s0IVYG+igDdSD6xhZNe9JtfVlpxC98iAd4rV6gcUebCmEFD7k/lC2rTJA8MaZReHD33DFqlrGoAKGlzy+cUXojNNgmtKsuUcohS78Vn+LSRAyCQJ1YTUmQCjbRU1Wu518xrYtwwoTeJ+nkNynCYqMka6KOIFqqS90jQxFLBOyspgg2/wNs2xVYMbUcwqJAXG40WSmU9VeLwjEBkVI33iUW+wVyEm+EMsviY1fFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB7833.namprd11.prod.outlook.com (2603:10b6:8:ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 18:06:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 18:06:47 +0000
Date: Thu, 27 Mar 2025 18:06:41 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <bluca@debian.org>, <stable@dpdk.org>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, David Christensen <drc@linux.ibm.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH] acl: fix build with GCC 15 on aarch64
Message-ID: <Z-WTsS31MSnmXMU4@bricha3-mobl1.ger.corp.intel.com>
References: <20250326103928.1189243-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326103928.1189243-1-david.marchand@redhat.com>
X-ClientProxiedBy: DU7PR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecfe3e5-f8c5-4f86-6564-08dd6d5a239d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2NjYkJ5OHU3bzJRNlZLNHB0ZDBFTVdGM2o0NzVsRkIwaS9vbFFVWmxsY0sw?=
 =?utf-8?B?eG51UndZeFZnczU4MXN5VmFkMU1kMENZa0h4YUhTVEtTZFBjS0p6aGt2cmVP?=
 =?utf-8?B?endCQUo0aUhlc1pNcGNhblJCckNqSFE1QWx2bEE5aWEwSW13K1hBY0Q1Rklo?=
 =?utf-8?B?V0dOckYvdlZYcDJSQkpGTDV6RGJRdFZ6NEhhL0RZL2F1c1hGRzhjNWIzNFNN?=
 =?utf-8?B?dXB2Qmlhc0ErMGJhd1o0aUcxR2xQWVM2bzVndUx0QUYxdzRqczZPRURDVHZ4?=
 =?utf-8?B?VmRwU3VRTjl5UTlOUjNmWG9yVFE2M3F1M3JWanM0RHZoMXJ2aDg2WUovRWNt?=
 =?utf-8?B?NzYwTEQrYkxWWk1LWVVmOW5ybm85c1BLSHZWVm1SRm11eWIyL1o2bklMSXhD?=
 =?utf-8?B?NFlYSitJcCtzNUR0YkhIRGtEb2RoN3F4L2dGUW1oMm94Wm1idk4wa3hUdVUr?=
 =?utf-8?B?bVpaQTRXc29YdGY0ajlyMHZSbE1kdHhyTUJnUW1HYkM2OWdiSHN0c3JUTng2?=
 =?utf-8?B?TVdCdEVibmhGNHZCLythNGNDbGh1L01wME1RSGcvNnVqZTNKa0N5bmpKUlVQ?=
 =?utf-8?B?TU9iblB2ZGdCUWgvbFlyeCtodXJodWJEaEJLT2ZYWjFqbVlQN2s1WW94UjJQ?=
 =?utf-8?B?SFIrdGFzNlFGMVgrY0pGZ2pvUXdSL0RLS3EvR3pKQXY5UWtQNldEbGE4Rzd6?=
 =?utf-8?B?T1lla3NQWmlOdVI5LzViNEE5VmVNb2xMaTlpTVhSYmFmckpyTThLcGUrS3Rn?=
 =?utf-8?B?eUMrem5jOGlQaTljZDdnS25aVEhRaGhJZGl0eEliMEF1ZG5sTDU4Y0JnckJB?=
 =?utf-8?B?QStmUzViSzNoSzlKOE02MVUwUHUyUGxaK1IyVUtRVWNaTm5yZWFnWURFT0xI?=
 =?utf-8?B?Z3U0Y2E0ODBEOWY4ZmFyMFNHc3A1MndtdVorc2h0Skhhd0lnRUZkLzM5b0ZL?=
 =?utf-8?B?Q2VNVlkxcllhei80cjUwY29WQi9VbituNUhYMWo3VldlcVNCNzduUzlqV2Nv?=
 =?utf-8?B?a3AzT29mWHpkN0ZjYnBYRWl5b0oxcFN4Uy9NVnhXOGpKNVVta2JwbU1SR0hM?=
 =?utf-8?B?T2ZzTExrQXBDWjExY1N5QXhUMGtXcUlCRmlVc1dNaWF4UzdCUmh1aVhwUHRw?=
 =?utf-8?B?YklzMUxXdk5sTm5EYVpCeEJ4NjgweVQvRTh2emhwQXYzN0FBSDNjeTNIZ1d0?=
 =?utf-8?B?alRYS1dRUC9jU1FDNXFUVnNwMEhnS3EyWXRPNjk5enFOU2V6YnpUVThGekpy?=
 =?utf-8?B?Um5JQXcyeFd1bTdqcEY0M29QU21lNjJhdUVOZ1hibjhPbC9DYjNZbVhUTDVJ?=
 =?utf-8?B?TVU3eGsyVERlN0FhK3prRkI5S3A4cVdOVHlKRjgvNXJ6QzFIQ0NnWEtCNkIz?=
 =?utf-8?B?Zzd3VERzblpuU1YwQWRIUSs2VEsrN1dVckx1bmRBSDBOYmZTdVNXR1hvQTAy?=
 =?utf-8?B?Z0pZNGRxVXkrODVNOTcrL3JrWURGQ2UxaXlkbXJoeUQwNGJaL29SbHhRVmZq?=
 =?utf-8?B?Wld5aWNtdjBINUUvSUVuQkZVOHJsMDgramUxRTlyVWszbFR6WWpmRzM1bDBX?=
 =?utf-8?B?L3EvRE1MNlNscTQxaTBCSU52cjJpQkYyS0lMYkIxbmxNMGh6eDZ5YXQ0Nmpr?=
 =?utf-8?B?OVNTNDdRM1dHV1J1S1Y0TXR2SDVaM0w4K2JTZzQyamNHY1RvWld3bVF6VjRT?=
 =?utf-8?B?ZmpxbEZWcmt3MVV1MytHTThoSmUveHNpVXQ4SWYzS3hFNEhWcERpZWVyclNS?=
 =?utf-8?B?Mmdhd3RuQ1c3SWRsb0lZdlNPWDhFWjBIbDlnZWFaSU1BZEp3RUgrak1JZ1lr?=
 =?utf-8?B?V1poemlRM0w0enMyYmF6WXFrNElPejZqbTkvemlBeFJJNXJCN1Jrc1lLQUgx?=
 =?utf-8?Q?yRiMHIQHfGd1M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhkcFE4eTFlcC9JbVdaeDdSOTZDMVBIVWU2NXdiekw2cnI2U1JDUUVNeTM5?=
 =?utf-8?B?dW55WHErTUM1UGZUUjZtUzdmRDNteXV3cEZVeFpLNWt1UU1qak1vbjlhUzFw?=
 =?utf-8?B?QjZGd2Y4bGw5czNBZW54QnNYR1JJY3ZBU2FQT0hmcHNRTjBJcDNvcXROK1Nx?=
 =?utf-8?B?QllIYUdyVERuVVBzMC9QeldUSGdlZEY5QUpsUk9jVWpXeDNmcnBmL2kyRURU?=
 =?utf-8?B?K2lvT25kcndTZCtPVHh6UTBYQ0drQmV4OFlBdVR2eGZ2Mm5zWStLQlUvQTJJ?=
 =?utf-8?B?THo2alRQOTJlTkY3bmxaSzFTS3R1TnZDS2piZ3BSOGladDE3RWJYUmdjUWlR?=
 =?utf-8?B?Z3pHcVRoZTJkWWd5bmpzbThsQzJWNzBGSU12RkJxOTJ2R3NIYVd3cENXVWsr?=
 =?utf-8?B?Z0JCakY2aHY3VGJGZkxibVdYV1ZTUStta2s0MG9URnFDYklYOXpiTXpmbWVu?=
 =?utf-8?B?VDdaR1VoWlBaU2tXRWMwOHJVYldwY3pGWmxWa3h5MTBzY2RSTzZlZk14aURy?=
 =?utf-8?B?aStYdnBINlYvLzhhYWZPY0xkM20vZXI0N2lmRmloOHQ2blRsZ3BOcGowTTZn?=
 =?utf-8?B?KzhWaTk1bEo0bHNYNHVsNWdLNExpZXRBOE05bnpiTzd0QWxTYnlkQmtsVEx5?=
 =?utf-8?B?MzFzRUpVeTVjVTMzZ2hQRTRFeGJMamc2VU92TUFiU29KNlFTQk80Y0gveE95?=
 =?utf-8?B?MDdETDF5RGZGYUprMjZJSmpGUlRXVmxkaGNBbk5zMXh4UkNGSXY1ZWlVOFFh?=
 =?utf-8?B?SE1rVkZMaGVFVmh3ZkVwVUpPZS9KUEM0M0xKQmpHekxVck4wbVZrZ3lQVHNV?=
 =?utf-8?B?NTA2Y1k3TlVZUlM5ZGx0eWVRWkR0ZWVJNzRVb013ZVJGV1BQNXZHVlo1aTRD?=
 =?utf-8?B?Z3lIUEhUZUt0NDdsTm9xWXErZk54OTdnYmdYbmZsT3BmaXJBMEM0RXdWRXg3?=
 =?utf-8?B?dzVLbFg4Qi9UZTNkVncyMVc1aHB1N2RYUXNMRnhpQ1V4STYyV0t6VVp2dlNw?=
 =?utf-8?B?Yi9LS2JVS2ptOHpFQ1pvM1paNGlDUFEzT01STmt6TjI1V0pQT2hmU2xZUUhQ?=
 =?utf-8?B?ZnVraVdFaUc4Q0FyV3UrWFRsY0pDajVtSkpReml1aDdHRlJpZ042Uk5PRFFI?=
 =?utf-8?B?NFl4ZDZjZmQybXNwM3VmQzRSYjF0eXFkRlBKbDA5QTF5QVN0Rk9taFcyaGIy?=
 =?utf-8?B?REE2V2pMQVU3YXpzWkpZSEdCc3llQnBRM1lYNG9vWjVjTHlxOXNmelZ6Smcx?=
 =?utf-8?B?MERDL1B6QmlmdmpsSzVkN3VuL3Y1VVQwSVlPWnpWSThZcC9xTjFjRXhoaEZF?=
 =?utf-8?B?VzhsZ1F6WUJPR0x1cSt5NUlGVWxNdTN1TVE2VDZhN3htdHBJSm5NUjYwMHgv?=
 =?utf-8?B?VVNFS0xoNmsrQ1RVb1dKYmppa21EUzcwZVBRUHFYSGI3MkRycXRkQnNWcVRP?=
 =?utf-8?B?VTFhVzlqaGVvWmFGS3BLWmlKbncxUnJvR3JNT3RTZ3Y4OGpkclhFNG9MT3Zi?=
 =?utf-8?B?dHJrNDRPVGNPeVhuc1BrZEptTkU0N0N0TldHSlhhejFmN2lJMkwyQlUrQVlP?=
 =?utf-8?B?UEhQS2I0eFdSYy96d1A5ZXlKcnFBZ2hRY0h1SzRjelIxY3JDb1B0L20xY3ZL?=
 =?utf-8?B?bldsZ3p1OW1abkgvSkZDR01jNlZCa0lHekdCSWJpUnhHbmVzTkhhT0RQbGpZ?=
 =?utf-8?B?dGgxR3gwRXg5Vkd1Qm9HSWErb2tRN0VHdk5yWnZ3cFhDMmNHbFlObXB0SFV2?=
 =?utf-8?B?Z1VCR3VXbkZKSmE1KytKRWM4aEp2TjhFQ0JzME9qL3VNaWkyaHk0T0pBajl5?=
 =?utf-8?B?eWFBZWVwOHpZZERxclpLeDV1NEVsV3A4aC9OeW4xcm8rU25qRXVGNlFGaGNu?=
 =?utf-8?B?Sm9objVSNlpjVzBaOEtWU200c2ZuV2hxSU50dU8yRVBwenBwbzhJeUJnWEZT?=
 =?utf-8?B?UWFKQzlaRkJHUnB3cC80OWV4a3ZIZDFCRy9LT2JiWlExT1VtSFBLN1BnSHJE?=
 =?utf-8?B?b0MzRXVJVmE2Qm1vZ090T1N4NkxqYnlQUmdSczJiOS9GTFNIWHM1dEhSTzhM?=
 =?utf-8?B?Uk5Gc1lVN3pnQURDUnh4K09rSjVrdU4rWnBCQUczdlVBeDQzKzNJR0xJMEEx?=
 =?utf-8?B?N1Bud29LaE8vMU13L0o0R0dtVmZ0K1Y0bDQ2MjlXZ0JmMVJadGNqa05TNER1?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecfe3e5-f8c5-4f86-6564-08dd6d5a239d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 18:06:47.1882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNQ5XuKhdQfoJk1GXPBheOlTOl5sGBaTu3493VGSGTKEb/ynsUxEwmrgj8DPU+l7D8zWU2OX1ZkicSevIIlJCRCldEfxgf9xthrhqIaZ2GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7833
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

On Wed, Mar 26, 2025 at 11:39:28AM +0100, David Marchand wrote:
> Caught in OBS for Fedora Rawhide on aarch64:
> 
> [  198s] In file included from ../lib/acl/acl_run_neon.h:7,
> [  198s]                  from ../lib/acl/acl_run_neon.c:5:
> [  198s] In function ‘alloc_completion’,
> [  198s]     inlined from ‘acl_start_next_trie’ at
> 	../lib/acl/acl_run.h:140:24,
> [  198s]     inlined from ‘search_neon_4.isra’ at
> 	../lib/acl/acl_run_neon.h:239:20:
> [  198s] ../lib/acl/acl_run.h:93:25: error: ‘cmplt’ may be used
> 	uninitialized [-Werror=maybe-uninitialized]
> [  198s]    93 |                 if (p[n].count == 0) {
> [  198s]       |                     ~~~~^~~~~~
> [  198s] ../lib/acl/acl_run_neon.h: In function ‘search_neon_4.isra’:
> [  198s] ../lib/acl/acl_run_neon.h:230:27: note: ‘cmplt’ declared here
> [  198s]   230 |         struct completion cmplt[4];
> [  198s]       |                           ^~~~~
> 
> The code was resetting sequentially cmpl[].count at the exact index that
> later call to alloc_completion uses.
> While this code seems correct, GCC 15 does not understand this (probably
> when applying some optimisations).
> 
> Instead, reset cmpl[].count all at once in acl_set_flow, and cleanup the
> various vectorized implementations accordingly.
> 
> Bugzilla ID: 1678
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
