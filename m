Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9E1CA0FE9
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 10:50:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C72B4021E;
	Tue, 26 Aug 2025 12:50:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id C543C40156
 for <dev@dpdk.org>; Tue, 26 Aug 2025 12:50:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756205429; x=1787741429;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=j2m7Az8cVyLEt1ST8uKzdYBvbKJ8HCUrs3mFeiQHIvA=;
 b=AYM73nDwSf1JVH6g7aQ0yinHHr3ajkM7oZqUJ8gyyOTI9s51hpLQnmvQ
 C6LwCtNyXCN4h5RloyDjfWOXNKeyyBLU6x2NGp6P4DUBi0ZdT0YHxZP2A
 ZwC35WExMdENnZNYcFntjhTDxm/sP48D97SYL1Zv7pN+YfGUVnbvkJ+2O
 8LQ6CWn8888sGLR3/LCgG1L2+C292ljQw6B0bcCIbT0PewWUd6HS0ey8N
 o8owM7d6U2hfwVmLiT+MQPxw2mjNHo0faEf8N9m6n88V27BrUubSc/GM/
 6F/qvSZ8tftgqchudkD18gWL+mmsl088jyKUnlX13iv0gXJBxy4a6Ob8f A==;
X-CSE-ConnectionGUID: +47TW2JtTVKsjihJk5yDZA==
X-CSE-MsgGUID: /tnGOaSnQnGDQe2DBenPmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="62252006"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="62252006"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 03:50:27 -0700
X-CSE-ConnectionGUID: MRhbe3+fTMicDdA2U7LN2Q==
X-CSE-MsgGUID: OLHzQNPUSEahRbZN2K+gYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169046435"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 03:50:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 03:50:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 03:50:26 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.46)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 03:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlNEFh8Ei7IxEXJPKmllK3GacKTNFa0n2aPo3UsUYcFpJv/nwmE6AJIMqDCfN6A3MCZ9o5dwi83e7hFa3SRvWkgznle4ttLS+rFGczY1qtDh2JYjS0mTbgkR0v8Es4AlprJipzrp7fQZfCn4nptkLLkX11hbWCQRqLPlAdHz/oyFz/2zBq3Vurcgoaqqa1qsyiT8vZGOrcXweQ21WL24SBB7RDMp1lSw25j/kBfO+zQOJB+re4Uo8Dd2/gdo+GIhrNp/1eLidRnu71KQJc4Bc17sOzbAlXCd6Ts3i/RIkDoGRwhHIczdK0xVXBUPgavOmVnEpoD8CDB1miMj/jwTyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQf8aAN077I6TUVuwrfS+Qw0hah/g0KrVl9LhckAbMg=;
 b=xlTTbfiqk+kjZMCYbFrq4Y7Gts6DPAYuVFZ3ILPrubPme+PwAva3DqTPEhWLjMSQSM/1WEeIvDiyOytNiuv8VibHQtVBcxOg+7yWmfReDALSlo7ScxoIz9acbpk3HwEruls6RAx965Ea+Lu+D/g32/66qe8E9FhOZScQnrWmZOjNitradzyIXniE4UYiX+orb9kogbI857/V34RYQO8QvceJstHdCUiSbcLJGyHH1wUZO6vwc9Ae4mc1+voFh4XCb5WFaGpKbIswFiOrtTJIfYefkPnm6Z1xEDcS5v8OzacUWiWBmtTCEEbn4wUP9sEGoPXNWNnOwvTJMSETcnDCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8495.namprd11.prod.outlook.com (2603:10b6:610:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 10:50:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 10:50:24 +0000
Date: Tue, 26 Aug 2025 11:50:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: Ciara Loftus <ciara.loftus@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH 3/4] net/ice: remove SSE vector path
Message-ID: <aK2Rajd8rypPr7lT@bricha3-mobl1.ger.corp.intel.com>
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
 <20250825123548.1177090-4-ciara.loftus@intel.com>
 <CA++2-x4mGrxvu7vxRgvQLbtGkS3bMBnLt+1NLpqa9P-GQobsAA@mail.gmail.com>
 <aK1oNgPbHGeJdgUp@bricha3-mobl1.ger.corp.intel.com>
 <CA++2-x5j0hH3XweLL+=O7-GJOnGSuN8zoFURs13mgFiVh1MD3Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA++2-x5j0hH3XweLL+=O7-GJOnGSuN8zoFURs13mgFiVh1MD3Q@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0319.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 0141da89-792a-4e11-3370-08dde48e5c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXJ2UzgreDd1WjRGNkRQb2x2UDhlajg3SFlmT3I2blNma01HSUp5TTVxbldU?=
 =?utf-8?B?ajVmcThUV1NWaVJhaEV4MGVpOUNwUVpWMnRzQkJUakNuTCtVOXBleURJV1U2?=
 =?utf-8?B?Q1l3TWZhbFE3SFF6bWhvWHloUm1sZTg0L2VkTUZkaFJIeER3OUFLcEhqLzRS?=
 =?utf-8?B?dWhhNlJDMzdZVUNiZThCSkRTNUdBVk96ZXMxbDdXQWhoUU5TUXovV05JSU9C?=
 =?utf-8?B?Y1dWVFpzb0trWlRoL3dMS2puY0ZpZ0lyVGZZOVFhWmN2ZWhzTVdsd2x6U3ZW?=
 =?utf-8?B?NUU2Nm5BRS9GY2JSS3BEM281VjB1Wjhnc0cxZXNrNkIzZ3RDUXdGK1dMQjd5?=
 =?utf-8?B?NlVsVHFFVVlmUm1pV0wvS2x1ODlQdVArRnU5QXpTK0dWOXl3ZHJLd0dEa3lR?=
 =?utf-8?B?cHdNdHl2Q1Z1Ky8xaElFKzluMEdrQ2R5dDBTaytDbUsxUjU0ZUNCUTVLejNp?=
 =?utf-8?B?YU5zVEUrdTNGM1ZyUThBbUhsbmQ2TGlxM29CVXh4Lzkvbk9rNE84a09SV3pD?=
 =?utf-8?B?ODlMOG91Y2czNFYxQWlQTDYydkd2MnpPT1hRUEZKSFFWejdYbTU4NW1BSDRj?=
 =?utf-8?B?QnJlTHhuTU1jSUoya0hSb2lCdGxhRzhXUVlQUVVodDNmcTljUStFUWh3eXRY?=
 =?utf-8?B?YnUzRlJkdmc1UkVPQTZNaDhJU0ZzT1FWSFgwMXIwZEt5bXk0TkFKOW40UlZs?=
 =?utf-8?B?TEp6MUtyWTJ3dXZVeFN4S2VOU2lrVlZlODNRNGlGTXliQVFLZ28vcis1L1A1?=
 =?utf-8?B?VDNwcGRva3J1MG9aUkMwZDNYSEY1RDdzMkdYMUxXU0pXam90UEJ0OVpNNlJ5?=
 =?utf-8?B?dGsvWVdKa2l5bDNBc3dZMW0vVDY1U2lTSjdtRldQNTZhTzAxTzNkd21LNXBI?=
 =?utf-8?B?SDJzT1l6eVBmYmdxWnlPUkZkaXp3TUhKbS93NzBqUktPdWdlRFpGUzFpUkl0?=
 =?utf-8?B?ZlIyUGw4UC8zemdQcmlZTDRyTy9TeWQ5MDR3TjdXS2I1YkZhZXlXU09NRUtX?=
 =?utf-8?B?RzZZTlZtbzRxNERzYTBRbnN2YklrR3NDY2NQZHE4QWhhN1pzK1habkNrMFRQ?=
 =?utf-8?B?VEN1bzB5cDl3NnFUdi9sL01SVlUyY2xvd3ZiWUN1V0JTWU8zdUxTOW9UV0Rm?=
 =?utf-8?B?SEgyTTlHbWVIRW12RzF4Z3ZPMzhQM0JINUJ2UDRaYjVKbWFJRzhTMnV5NTZO?=
 =?utf-8?B?dHdCU1hBY1VUUHBPbTR2K0k4RGlGdEJ2UDdsSXJjbWFWTFNnWC9lUzlZT1ZS?=
 =?utf-8?B?U0ErWVJZSnRJUlVvdnUrVzNFa1gzYWowOWx3a041ZDJ2STZaNFNpQ1VJcGds?=
 =?utf-8?B?ZW5IOGMyRXRxMzdEVGFyUkdNUG9CT0NHalBicXY2bVZZbnFPbkpBRGNENEhp?=
 =?utf-8?B?aU12ZjhuNTFzL2pJdmtRMWoyaDBqT21mNmRZalY5RmlUSEtGT1FEaHNHN2pB?=
 =?utf-8?B?OTlHbjdJWXpPTEpGKzRRV3MyZU04ckpHOFlpVXo3YkowdjkzTVRWWFZJOE51?=
 =?utf-8?B?VTEzYUlqMmZyVHNUbmNRVkxsUEdYQ3BnTW1xY0NvK1lyMm42eWUzY2h2UDkw?=
 =?utf-8?B?emxUSnZNQ1Z5WnNIVytUZTc2MkdyczZLdm9TYUdMUlFybWJxTWxvTzlBZWM1?=
 =?utf-8?B?MzNTam5GZUo2V2xhS0pxRnk4enFpaUdvTkFyVTVxZk5LK0d3NWFIQ0dsYUp4?=
 =?utf-8?B?QlgzQ2VwVmMwWGJ6NmhvQUthOS9FUzVZWnUrd0ZEU3QxL1AxV0ZzMzEyOTRR?=
 =?utf-8?B?elhvTksyb3F3Q2R2UWdUTDBIMjJkWlllamNqN3NzRzY2OEtsaWpqcFR5UUJV?=
 =?utf-8?B?S2c3TzR5bzJ1VHBtRjJzSUc4amdNQmsvV3E0S1BmM2xvczRxZ1BKeEkrNFNT?=
 =?utf-8?B?UXNCbkk2SkF5dHFtNXQyeTdLRWJSQzlHeTh1Q3d0dzU4YmR4STRXam1EckV2?=
 =?utf-8?Q?8hPJS/5td+Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmUrQmgrVFAwbUFoVWozUVR2ZGZkY0R0TDdLTStxT2REWWZ5UktQZ0s0Vk1G?=
 =?utf-8?B?QjZ3cmFXSENmaTFQeGVycFBIK2lRT05Gcm5NeGVOVUFDMXVZQ1NzYnFkRTU3?=
 =?utf-8?B?blNFc25DMGJINkVpZHloT2c3R2k2QmoxWlNnQ3FYdmdyM21LMjUzci9VWHg5?=
 =?utf-8?B?UHF0QnRTVnRaR3BkNWNnV2ExKzdzUWV1WGNNeXBVdUJNclVJaDZ2dUUzMjRT?=
 =?utf-8?B?ZjRrVEtwRzVwbkR6MTFaSUY4SEc3amlxUk0vWnRsUzJEd1FzVGN2cDkyeXF5?=
 =?utf-8?B?KzNMaStQL2lsOFBvYlNlb2RSUWIycTVibU9qUm5wS0owNnhVYWVTYkZQNkQz?=
 =?utf-8?B?ekRPeDVId2d0QjdlU3J0N25MOXBoWUFLVnFNelVkM2MyVE9XQ3NtUFh4eHVp?=
 =?utf-8?B?STBYcXdDVFQzWUUzMk5UVVZGZmx4RUR0Y1JhY1E3cW5xWlFidnZiNUhySVV2?=
 =?utf-8?B?M2Jud2Jib2JXRExxRVIxUzBMZTUrU2htMFhBa0xRQnpDbnIzbG9JZlJ2d1Zt?=
 =?utf-8?B?dTJqVlBWbjVFeHdZa0pTcjRQWGpoRy9pcHBxNGxTODdQK3c1TE5jaFpmL0x4?=
 =?utf-8?B?TUhmRUIxeGFNMzc0NWRRdWgxOHd4TTluTjVXb24wNGNiNVJHQVJPcWtZVGNt?=
 =?utf-8?B?NFlWT2J4NDlQSWx6QUNDb01CYUsrZEhTbXFlKzVoK3pISGxYVkRwVE9Gc0V4?=
 =?utf-8?B?WnVncy83dGZRdVNxOWRjcUxMaC9NUit5MGZGMUpiMktaQmM4d2ZZTFhRVysy?=
 =?utf-8?B?eXdHRmphRTBLR2p2MjdwOXR6MGN3UnduREJvc2lFYjd5R0x3NHNCajdaeHBl?=
 =?utf-8?B?Q0c2QVRwNzRTU3JRa0tIMFBuNkdEbm1Jb3BOd0NYUG5iSm44Y3JFdzVlZjJK?=
 =?utf-8?B?cS91ZkJqOTB5cmlPQzVUUzZpMWt5aW1ubFJ1d3ZRY0tVbzZGMU9XVFFpL3pL?=
 =?utf-8?B?d0xCemd0NDFqcjltYjg1a3k4K0p6Uzcxc1dteUYxRWdUK3ZQUzFXbzMvZjRU?=
 =?utf-8?B?ZXRvQjhYQkhMa05ZdG9FaGpFRHFwUTZSbjZQRHpjaE1WSEU2cC9LN2pUUHJo?=
 =?utf-8?B?QlZHcWVSRlpxL3lHNHBwV0syam1HbkJBS2VtR3VteXFLb3QxMVlmSjNRQjUr?=
 =?utf-8?B?elBrRDFzdFdqOVNZajB3SVRmSzRBVVlqVFd1OGF5ejUrRnErK04rOU9WU3J0?=
 =?utf-8?B?TFhZNmJkM2M1cjFaYkZUSzh3V1Rra0hPTUhTdm9xa3VnVUVpRUNaS21Na3lS?=
 =?utf-8?B?WEM4R2p0djY5UWg4Tm5DOWhkZGdhVkJxVWV2UWdCaXhnekNMZmNPd0pHdnFm?=
 =?utf-8?B?NXh3bDd5UjFOR0c0cWhJNmYwMkUra0RxVEc1TGVhZEVobVl3cTZLeUdkT1Yx?=
 =?utf-8?B?b0duVjE3b0U3c0J6dkkvSGxvSGRsVitGVUxFQWNhV3RsZmpUQW9uQ1h3WjFO?=
 =?utf-8?B?Tk9rQkZyVm5tT1N4RWE2SHp2VXpBdm41UmpyZUEwUE1nRG5veDJ3SEtTNjky?=
 =?utf-8?B?MUtlNER2SFFxYXZRSHkvOEdyajJxdDhJKzBCNUNubmh6bHBLNGgvcHBZMlRy?=
 =?utf-8?B?Yk53ejlXMXQ4RnFsVVBvSWtzUEF1eWpwVU9hSVI0REUzd3FhWFpFREdGL2JQ?=
 =?utf-8?B?U3I2ai9WTGtvWStISkloSGR4ZlpjYUZYK0dOZFpMNExCUHErTUhrSnNDWFNv?=
 =?utf-8?B?Y1A5NGVnUnV5Tyt1blk0NFRXMDJ2dWMzR1V3THVmTW03dGVCSm9yWFJZRWpO?=
 =?utf-8?B?aFpZNmlGSC9IVlpZcW9sTmtlazlVZEMxanBMMXBQejQ3ajR6QVpvWkRhekR6?=
 =?utf-8?B?ODJWa0xwRWxlaXZqU3ZtcjQzaG1XQ1U1d20wYXJBR2ZQWGIreW5qMkZrcGp2?=
 =?utf-8?B?MWVnNWZqNG1oYXplQW9NeUM4MGwrQXpWL3VlTFZVSWhpNDdaSXprMWFvL25B?=
 =?utf-8?B?N3p4Z1hpZFhSbTJjcjNOeHV3SmFSbGl0a0toMDNtWjR5aHlDd2dEejZkMHVC?=
 =?utf-8?B?ZlpSajVZSSt4WEJZMkpYV2szNzlIMmhpalFRbEFPZmJoV2VzMmd1WGlqaXln?=
 =?utf-8?B?S1RGZGIvd2poQWVvMzhUdk9UbWpKRSt5U25FbUo3VzJKYW1MTDVkWlVuN3dX?=
 =?utf-8?B?QWdwU3NiOHhPekVBalBvWXdIeCtYU252eWRwQURXeFd1ZmZGWGNqdko1UnM1?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0141da89-792a-4e11-3370-08dde48e5c10
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 10:50:24.0011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKTf6AzOM2rKq9v8+8JUc0RaQQCAmcxYUtslQi4sSRTc4xa0NirzMll/vd3c+Lb91MvtTkPK0rE6gNcqTCb17xGu+Jf8ifwErn6Dg+7F9Bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8495
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

On Tue, Aug 26, 2025 at 02:29:28PM +0500, Khadem Ullah wrote:
>    Hi Bruce,
>    Thanks for the feedback!

No problem. 
BTW: Please don't top-post in replying - it's best practice to put
the reply below the text you are replying to. Thanks.

>    I have checked at my end, most of our systems (Intel(R) Xeon(R), AMD
>    EPYC)
>    do support sse, avx, and avx2. I was talking about general
>    availability.

AVX2 was first available in systems starting in 2013, (and AMD systems
since 2015), so at this point it's been around a long time. The SSE code
paths in the drivers will only be used by systems which do not have AVX2 on
them - which should be relatively rare, I hope, at this point. There are no
features in the SSE driver that are not available in the AVX2 one, so, I'm
not aware of any reason why one would need to use the SSE code path in a
deployment of DPDK.

>    It means, newer features will not be added to the SSE path and as
>    you mentioned that LTS 24.11 will provide support till the end of 2027.
>    Applications that use ice SSE paths can benefit from it.

Even without this patch, there will be no features added to the SSE code
paths in the drivers. Any new additions would just be to the AVX2 and
AVX-512 code paths. Even for systems without AVX2, if the SSE path is
removed the driver will fall-back to the scalar paths, which have far more
features available in them than the SSE codepaths, which were simplified for
performance reasons.

/Bruce

>    Best Regards,
>    Khadem
>    On Tue, Aug 26, 2025 at 12:54 PM Bruce Richardson
>    <[1]bruce.richardson@intel.com> wrote:
> 
>      Hi Kadem,
>      can you perhaps share what systems you are using that do not have
>      AVX2
>      support? Do you do new deployments with latest DPDK on those
>      systems?
>      However, if it helps, we can defer this patch till after 25.11
>      release, so that we have one more LTS with SSE support still in it.
>      That
>      would mean that we have a supported DPDK release with SSE in it
>      until
>      potentially end of 2028. As it stands, even if this patch goes into
>      the
>      release, 24.11 will be supported till end of 2027.
>      /Bruce
> 
> References
> 
>    1. mailto:bruce.richardson@intel.com
