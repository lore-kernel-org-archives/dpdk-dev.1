Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4D6CFC269
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 12:04:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3784A402A6;
	Fri, 21 Nov 2025 13:04:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id E91124026F
 for <dev@dpdk.org>; Fri, 21 Nov 2025 13:04:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763726683; x=1795262683;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=9FKi4LQQMD4ZiCci45vYg5P39JBlvfoAFTPK0goWj90=;
 b=Sgoj2F6WyBGFKDSlREklYjuDu1L1NOhydApR1+6JTsBa5xnlg7LpltDk
 pxHTF/8neOFdR5KUA0IfOFyewnNFOl784sTLe3hV4Gpqc6qgVh0Qe+rbV
 6AG9b2pgD1D6MB5wyh2lZkM7Nukuq0igFEMwXoUPWcQ51bGV1gXvM6CC/
 ijd/Ypwj4QiAxC0idt/trZKVwFQ/yPK5yteXdMvt+eU4Rq8TkAYTD+Ghi
 /z6UCLClT7Xwe/tJo/TAN6G4xBzkIxBB6o5YKHs6mChtAmkPiS33X29yU
 4GiP0KiM/O1I71BAyTgvWJj0GBfbXjM5RMt0XRWQsHaqklIlD9Hg2maP8 A==;
X-CSE-ConnectionGUID: 4UnJQUJzQOmNBFCIe8JXjg==
X-CSE-MsgGUID: kDoZ1r+KSr+h0N1bYiu93w==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65849982"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="65849982"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 04:04:41 -0800
X-CSE-ConnectionGUID: zn4iERPcSdmxHq8StcfoIg==
X-CSE-MsgGUID: NbkVcmKsSrSorqnGzeIu8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="191467795"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 04:04:41 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 04:04:40 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 21 Nov 2025 04:04:40 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.15) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 04:04:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjQMl2LyQ/PSDILhS5/ikBpi9gP1dcXzXgaGnVIptFTZNFT0BJNqLTVHDaCrmdUfcuwWu+YwXcM7IrTJ/6PaQu+L6ocKJKtw53BZpKK5F+ykzaR83ucN6uMQv0HnJxYPBJYTptXdAHFEf+deJ8QcjBzLPat2VvbCa9FIGD0xhsbPqIV2O4ggdccvmVnVemqfmskIUUP+jT21doG7OOmZc+RaUTeRImMnWeuBmovkAUmIUZymD59reL8KNN8aAgnkcY/7qPJ8KFbDYMjRx/nQ1jnRxsgEN+RBu8+5/9pij2dORl6xk9GE69zcCGpgB/bh9vUHwWAo2/b+/3chbjvS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zZ5U2e/3gZQ305nBRBgbYwcvYUX69j9B98ArBRPGew=;
 b=KdPgtODXtdC8wPV9AMQfRQEU0+k8Ir7mu6unt4Hkl3HXE/a6LS/T0IJ49kDa1Ccj2WQw+4MY6Aa1olph3vEs2p6o+z8tNJxkrp1N4F0d5Im/LC9f/x8fEKCXRMzoeinyaniJr+MtRxZBm8AgB5UDqrAVNhLDB6W5x9Y+uWUCnpNZzD6PogvDLriNv3GkhsHaAL6m3TTkMpifBtYhukkAFd7+fpyodSrl3F2IXvFQ7WQBSU1w2vjeERHb9JuVP+QLMN3GGF8Ugfc5FfpdGCP/xA/67ud7O44b4fTXUzXn6kLUsWhRshCbGy/ebj4JBpZiO+1kp85ii3EI5Sh1WHpiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH2PR11MB8833.namprd11.prod.outlook.com (2603:10b6:610:282::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.11; Fri, 21 Nov 2025 12:04:35 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 12:04:35 +0000
Message-ID: <b8f91595-3254-489a-86fd-87f755dfc2d5@intel.com>
Date: Fri, 21 Nov 2025 13:04:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] test: avoid overflowing huge directory path
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <0251115193409.99740-1-stephen@networkplumber.org>
 <20251120165713.120238-1-stephen@networkplumber.org>
 <20251120165713.120238-4-stephen@networkplumber.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20251120165713.120238-4-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::10) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH2PR11MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fe422b-783e-4c50-30f9-08de28f6232f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXN6NVFSVU93QXl2WEVpQXlWbG0xKzltTUNUVURDd2JvSWd4L0RpQjkyK2o4?=
 =?utf-8?B?aUM1TjAxN1I2Znk3VWZYTVlERFp1OHRoajlZSXVMVTBCTWlndFNQcEpEK0Rv?=
 =?utf-8?B?eHFFcGlZVHZkclZuMFRMQkErbmlPVEpxdFZKYWxPQWpoTlhWSHlrSEJPMGk1?=
 =?utf-8?B?NG1yWXFiRUg2cXh0VVdneDRySHA3OGM4djZMSGw5OGJJY3ZpSDEzaWdVMjdF?=
 =?utf-8?B?aWVkVDJETVdCV2x3VEJGU1Y3eitNVTh2Z0ovQjZ6andVOHorMnV4dTVPNjhj?=
 =?utf-8?B?N212alBRYUdmeUVvcEhQSFhuZ24xK2pIUjlHNWp4TGpCVWxIdHpYRFF6Q2hq?=
 =?utf-8?B?Yy8wRmNSdnltRWlNOTA0M2JwUU1KRkpzT3hKaTM5SzlzUGxlZERTS0RHU291?=
 =?utf-8?B?UmkwcUtBc3ZEaGJuT1pwK2JxYmFWYWZ6VEtGUHB1RzhjVWlTTnVkdXBoSHpt?=
 =?utf-8?B?aUhSK2NGOFdSbEljS1lKdDV4NDZwcXJJRGJJb1VOeVBOMWdtQVlMTkU5ZDZa?=
 =?utf-8?B?b3VyRjhxaTdKRURWYkdrd1BDRktJUUFMck5lejV4WGJNZ2xzclA0UVpYeG92?=
 =?utf-8?B?OFhJMEpDNGpyL3ZaaElxS3Ayb015TlZ3Y2VpbFlnbXdSbm54L2k4aTUyQ0Fl?=
 =?utf-8?B?WjUzb0l1aWVvemVGeHQ1dzFjTUdxbDBlRlVUSW1DTE9FbzByc2lCRXZKT2pF?=
 =?utf-8?B?ZTdTNmFQTWkwYnhOTmVFZVQ0YXE4UXl6UW1LajczTU5KaHViOHUrWGsweUVx?=
 =?utf-8?B?ejBZMmcrbHFPQUlCRzBvUTgvQlFwb1JHOUpMSFNOZG9jaE9ObHlBak13cEpX?=
 =?utf-8?B?c2FKeWNoeHBYanA5elk2cjl2SFR6U2dPZ1JHaFNQV1ZpSlZ3VTVPNGJYYVp3?=
 =?utf-8?B?TFE3SVlYdzFqcnlRNytVR2hRWE5tVWdWTXhYYVhoaGFtSE5DakRyM0ZHVDVr?=
 =?utf-8?B?d1BiZHRIcnBKZjkweWhZVy8rbUcweEpmM1NrVGJxUXFYanlXZXNKcTZIT3A1?=
 =?utf-8?B?aCt2SEFDdVBiWGw5VVE2RDdpcmxVbGc5cStsMWxWdjhKekFtVU1GK3dHclZs?=
 =?utf-8?B?d0lNSkVQM3hwR1l4UnlsdURxWURqem9TOUtZTzFoVDZLczBGdWJGNEhaQS9z?=
 =?utf-8?B?UnBjMlVFR1hBUUtIK3NkWXgyL25uaWRicHdzZmF0TkpNTGpaRys5YUNUT3hB?=
 =?utf-8?B?MFdNSDhIS2lNa3VxWXVyZzBGRnRtcTZoU0RwVjQxdGxQZkg2bzc4aW5QZU53?=
 =?utf-8?B?Ym84elUzd1QxVWx5KzJQZklMQ1VzSjUrbFN3SHNpM1luL2ZjMEc3bHVHUVh0?=
 =?utf-8?B?QW90UzA5RGpHVkxwYlgxME9BWm5MZWZLY1lOMUhka1lFOGJPbUZNWnBGdkFI?=
 =?utf-8?B?M3NJdDdFY3BpVjFaTEJqNFV2QmxrWkhxL3AzTlQ4aTdMWEVPQVhDaGxQL2Nj?=
 =?utf-8?B?Rkx1Q01SOHZCNkdQYWhDajlxOVVaRENOZzFRVThTRFhVRHNJcGFFQityTitC?=
 =?utf-8?B?TEkyY2IzK3k3WVNMNVFFK1NTOUJZalA1UWorV3BUa0Ftekg4Z2RrM0lVbWsy?=
 =?utf-8?B?ZlRiWXhibzNwUnJmVVZTNE1UTEIzdVpiWnZUdUd0aERnQmUxVU5YZ21VTFFP?=
 =?utf-8?B?b3BZeUhYL3E2ZXNVZEVia2NtMWZ0QmhaYXJZS1oxcGowbGxTczBFbzZIeXhN?=
 =?utf-8?B?N3dHRWZiMnJBMFhUVVVtNC9KVVZvSWNtdmpJRmhkMDlySnZLdEVyZGsrNzJa?=
 =?utf-8?B?V0tsZGpNMjBMbjB2WGxGb1J0UWYwSHdmczJGUmxJQWVyZk14eEQxYzhPWkxN?=
 =?utf-8?B?dVdwSDhVMUhjU0V5RmhTQmYvVVVsbTJSVmdyMzhiZlFhZzQxMFVaM2MzeWMv?=
 =?utf-8?B?akQxYTdGV0dCeHE3VTZOQ1NSQWwzSTgwME5YZllHeEtWenMvZTZxYUFNd1ZQ?=
 =?utf-8?Q?ibB7LYKrNH681AVdYoIaXa0002bKTRCy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWFzYnBmMFhtak5OZXBmMTFvTkQ4RTdDT08zaTRNSlBFWkliRTBIT0UwNkVC?=
 =?utf-8?B?K0VnaUFjNktQUFVuWXpqcENNWUJDUlVKNDBqbEVrQmZ1OGZ2ZlY5WmQ4NnJP?=
 =?utf-8?B?eEg5SVR3VWVwSWhWVi96M3E1OGNNbXRwRjZzZG8zWlpwV3RsWnZUS0xiWUs2?=
 =?utf-8?B?ZkhvcHM5N1E4eG9wYmhUWkhUMVF1cmliZFBoYjVIL2w2RDIzdTBTYmo4RjdJ?=
 =?utf-8?B?VnZCZ3MwQ0c5M0NQNGN1bng4M2NDTkhIWDhoSkx3SkR6M1pKaytkaTJLclRs?=
 =?utf-8?B?V2IyVVZhS25LNEVtMHBhVkZaUVdUNlB6ZWV5R3M0UXNYTnYyVkx1ME5WbnYy?=
 =?utf-8?B?MWFDT3kzMUJBV2ZlT0oweUNGMWNQZnZnbE9heDl4RjZHZkRxUVBJU3hHR1FB?=
 =?utf-8?B?ZCtqMzE4UnZnc2VYTWNkYjVWbjdvNFhTdDAvYTBRZXdmVTgrYXJUcm1BZGZQ?=
 =?utf-8?B?R2xXVUg1bUhTMmhGMklqK0l0K3ZZMDl1QitzVDdadTZJNzhuK2JTNmNrZjFj?=
 =?utf-8?B?b3plU3RhMTNDNTJobWVlNWZHRys5TldDWS9ubWpLWEd0aHQwMVd5dVdUR1l4?=
 =?utf-8?B?Mk5RbEJ2aDlsZlg2L0NxSHV4MklvQUNIcnJIeW4wSnFRUmR1UXEzVmlWZTRG?=
 =?utf-8?B?QWVvYkswbjlOWm8zWSt1Y2toSlg0N2IwMEl4aEhRSHVOYlNncS82VS9YenZW?=
 =?utf-8?B?SHp4YUtDMU4xdUw5NktFWmZpMldnbXhzT05PdEUvZjZQSjhxY2pXWkhNOHVD?=
 =?utf-8?B?MnpSblBxRmxkcld5aE4zTGwzU2JIWENkYUZZRDJDWGpjUFdSRlJxZEJ3QVZj?=
 =?utf-8?B?YTZHVWZ3V3Frb2NGWjh4R3JkbCsweEZMQ2g5MjVpbVFYbEs2WWpsUldXdjFG?=
 =?utf-8?B?dmNzeFhPb3Q5ZEhoOVY5TzIvT3REa2MzcjBvcmkrMTBHZXc5V1BkclplMnNa?=
 =?utf-8?B?bVBjbDJPVVlQeVUydnk4WDczbU9XR0RVZFFRVjNmV1hhOUFlY3VwMGl0QVRM?=
 =?utf-8?B?OGc3bXVGeitOVDRhR09rOXQxOXRudFdqUlh3b2VlVWlEQS8zSWNWdFZQdURz?=
 =?utf-8?B?UUZLVFpBYTRQYUFiZTFOUWFudjZuZmF4YUFDZnBiRlg1dmYrZThPOTJKOGlO?=
 =?utf-8?B?bHIvdURmOUcwNkdTaTFJT21qb0tYbFp4YUlCVC8rRDRWdlFUNXdFZ2RRZUw1?=
 =?utf-8?B?SUdhWlFVdDZkUWJHMkowWGZ2Y1c3ZGk5aGF4NW5ETCttcUw2cjl6dnpGTW5I?=
 =?utf-8?B?eWhhRlJmZktWSG9tYWZtVkt2dE5vbkJjQzlRck1nVm5MZ0V1ZHQrWnUrYmVB?=
 =?utf-8?B?TWkwN0tGOHhLcGxQQnp3dUErcGgwV201YmVRNFEwNkY2VG9zbC84N0U4T2RM?=
 =?utf-8?B?cUY5Q1lvVFBTQTN2cHFSeUlJSEZjVmdwMkoybWJtbmlSOVROa2pPSHJvU1Rm?=
 =?utf-8?B?U1B4WGhWWGNlemRISE5WMGV3eEplSkk2dnJTelg4TUpJWXBmUjJ0djNlL3o5?=
 =?utf-8?B?bzAzWDh3cUcxY1ZmcW9QVGJkSVFaZnc5S09uVDdQamxKWU9xMU92RlJjWUNq?=
 =?utf-8?B?VUJWMGR3RThzU0I5cFk4SzlqNGhRRmhlajFjand6WTY4L0M2NHN0UkNkeVI4?=
 =?utf-8?B?THg2WHluUHc3ODR6WnpVTlh4MmxZbElQaC9ZNUU2c3JOcmNCWUFlWXByN1d0?=
 =?utf-8?B?djR0VmhiYlNCMnFGMWpPOFRycE9vRHkvYVMrdVQ4cmtLMzRkWGpqdGtySm9m?=
 =?utf-8?B?c0JPM2xjVFB2eVhNZ3pMSXpNeFU2QlhZcWE5VmkzaElFQzhtS0FjYzdXTW1u?=
 =?utf-8?B?UFFYemdwdFJWcEF5cHN4bm1DVmFsRXNna1BITWhnamI2dW5NRHdxdzhGakVD?=
 =?utf-8?B?ZlU0OHdnSEFyaEx3K0c2cWlFWCtXdTBuWFdLVFNrRE1VNWR4TmQ1K2tGVGVG?=
 =?utf-8?B?cXhqY1F2NkhmUDh3YjFqVVN2ZVVnZGhsUlJ4Wmd2elFsc3hSMnNiMERvRDRG?=
 =?utf-8?B?L0ozdlJRK1hsck81L3RDbUYyd3oyZkhzcno0eENDNllROXB2TWJXamt0UWQr?=
 =?utf-8?B?V0tZMGRNa3NwUTRCQTNDdStZQ2FIZXdxMTJ5Rm0vRmZ2VHpML0h4R004VzBB?=
 =?utf-8?B?YjZaZlNqR0lXdkZkTXI2RlFqTzFwQi8vL3QwTUc3S1BqQjJSNHlxeDVjZitV?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fe422b-783e-4c50-30f9-08de28f6232f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 12:04:35.4997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DK+x/6M7erTtHwLPUsH3WennghU3qnwIYNSgdUDPV+x8m9SukfkTzSd1+DTi07qUQhamICTwYMmca1UGie4wjNVAHUlha99Z6b0QwzwCSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8833
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

On 11/20/2025 5:55 PM, Stephen Hemminger wrote:
> Since the tests construct a mulit-part path in huge pages directory,
> avoid overflowing the string buffer by limiting the possible
> huge page directory.  Can never happen in real life, but compiler
> gives warnings about string overflow that it could.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
