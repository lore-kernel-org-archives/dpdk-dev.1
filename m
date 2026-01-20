Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B2ED2ED14
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 08:00:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACFB940A80;
	Tue, 20 Jan 2026 09:00:36 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011050.outbound.protection.outlook.com
 [40.93.194.50]) by mails.dpdk.org (Postfix) with ESMTP id 31B2F40273;
 Tue, 20 Jan 2026 09:00:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1IRemBmcb9vj1il5EkFOv3QgRRiaVX7Siz4yLRIa4iKJ13OG8T7I590bEWvAQlMsJ8cCZgr85ZcSOCS62f/1JX1VWr1QTlKT449cuIaLSG1f6T+xdy6VccCSFg47PD++b1zM/HcuQViGVHdZ4egXUZfyXojyuhSmuy4Y0on+cTeU+rdjBWVKRb4Acdp8mc74nxnwRk+WwmYPAmfuKaEzryUGKH5G94LZyJXHoc6v1NC4Ez+tCdYlqYNPgGcUsZTTAkfOMV8HqURsbBwNAc364xmdu3zM8utg9EA9PcVbUJHkxy6Br3KMdkV5kF/lMtGd5ZOkRTZoKU4MHubrh5eBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6WieTpHyyN5ijiZC20heAqrSY9JKofjf5e8x+KPJAk=;
 b=eda5NWe0KYzQZAJ9ab3o16xifM5ZXGiWFm900/F3tqMdKPe460durY4XLSiuKcpkF+vWW/Yy0MoB0Il0d6MR5IrBYPZO4f0z1rf9P40jhqVe+jSAVwPQu6XgrgYGTqaKFhTy5YJqEcpQAix1XzhKlanX28Wv9ZA+xPg69c7BLDi1tWiUJXB6LZ/WwlDQnqyBxc56Y8HM6UBNC8X1KA1opYdm5RjTL9voybLPQcFa1fGbNCU0fIvbkfcerpX/9aniFQHBvxuZxt74blnuhFb8WOUUKIwuTLhGiWW5Gf2OI1Yp8l5b3GPgDC3QxJVyAh0Y6eDKDSFJlribweMWMn60Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6WieTpHyyN5ijiZC20heAqrSY9JKofjf5e8x+KPJAk=;
 b=tpzmE1SiZck7fIVTWPjw9mjMZ69zFKkXhHvAaB6zCNpdf/jIo+mAMnlB0bico+7uOKZIqMHRzHafA2app2n1DgTfLnycJnZ7eQPWRT7bHO7EYnujaXmQWDTdgXWFaZtJ8X54TREe2b21npaGIITrklhnjT54tGc35DYmywibnNdsLU7Y8gyhITy3aCRNn9r1aX7iqwbkvCT3fb9YJ3iSz+Xwf+ASmagozPwIXICvs14lreDk+EzRGxhsJYBXPanwLMhohkHIzvXMA+SqF+E5yJ4LZp7mQ3US3XpZ/rrDzOkpzBJGpuQhuUpCCvGRS7ez4zWpmrGvCy3MGJ5VGmNWrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 08:00:31 +0000
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::5b03:7719:6811:86a3]) by SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::5b03:7719:6811:86a3%7]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 08:00:31 +0000
Message-ID: <e19c844b-122d-487c-9752-5c2faffc140b@nvidia.com>
Date: Tue, 20 Jan 2026 10:00:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: 23.11.6 patches review and test
To: Shani Peretz <shperetz@nvidia.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 benjamin.walker@intel.com, David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 qian.q.xu@intel.com, Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 yuan.peng@intel.com, zhaoyan.chen@intel.com
References: <20260107100017.158232-1-shperetz@nvidia.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20260107100017.158232-1-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To SJ2PR12MB9212.namprd12.prod.outlook.com
 (2603:10b6:a03:563::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9212:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: b900119a-821f-4c41-5294-08de57f9fbae
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elhnbkZqRFVjaDRLR01MTGptaEZ2U29XSkVocGdESEo0VEFPQzJ4WDh5ZlJN?=
 =?utf-8?B?WVNIOFUvQWhtNU9ldER6bkRYeEo3aVdDL3BZT0d5UHJEaUF3dXdPaTNvcDQx?=
 =?utf-8?B?YXV3eGZTbmx4S0ptZE1Kb1l1TVMwRmZZSGl4am04ZU9UNEt3aHVPVEt4alBx?=
 =?utf-8?B?eUl6YkxTTm5FbUJtMmtWM0k1cGxTRXI2ZUw0MDJ4c2ttcHFjN3RuUzRnTUE2?=
 =?utf-8?B?akI4c3V0WmV4SlBlVUlQS2xSN3h5ejVRMFB4emM3clhiK2U5Tk41ck5URmJr?=
 =?utf-8?B?M2ZJYXlKUnVtV0VFYzJISk9UQVc1N0h5aVRKaTRFVXVabFF1TGVBRUdHaGdk?=
 =?utf-8?B?NXBMVENhMjVIZ2owMGtZSVpMV0hPRHdCd1U1UlBlUGRzRmMyY1Mxb3R4T0Ni?=
 =?utf-8?B?emF6OVBITUhMbTNMR2Z3aFZ3VW5mZTM3K2RmajZpTjFmdzlrc2haNWF2WEJX?=
 =?utf-8?B?YXpONnZBVzlUaGlYd1dzRGY1UWxiMDM3aFlES2dHeSt0SkplemNhckpsTGdR?=
 =?utf-8?B?Y29GckdjZDdqMTJrUmRVVE00d2FsaDZwcFUxNllOWjkwSHRneEdvQUkzbEZC?=
 =?utf-8?B?clBYMEZWSWlyaHZMUTJNRWNXSVNMcWlkYWNOczVWaTdvZ2pBMmlUcURpbUdu?=
 =?utf-8?B?SUZkSzY5R01ONklkUyt4L3BwWE9KZjhIVDRaQzVVYWsydUU1d1hVMzF2emJw?=
 =?utf-8?B?ajhIRkJid0k4dk1TbUQyWjdEdFYvZDljT0RjZGdCbGFjVGVMM1pTN2VvWm5M?=
 =?utf-8?B?bjR6WVBndXdWajdvRUV0dWh0Z2pTdDZkZ2NMa0ptTUgwMzd3VTQyOWFmazhI?=
 =?utf-8?B?cC9Db20xdGVkSWxqVGhVaWc5RlYzUmJZQmZDaW5aSkpCQnAzWXRoQWNQVlU5?=
 =?utf-8?B?blQ4Und1TkhwaTYwdmtxTDNwY1ZzVS9oVG93MVZxR05DUzZJSUJpa2liRk5z?=
 =?utf-8?B?dzZKVW0rOE5oSEdCdzlZSk9xdWV0UHozQ3FwcXliK3V0NDRMTG9xU0dBRzlN?=
 =?utf-8?B?WXRaV1M1dmg2MDhkZzhtbmJBYlpLYTlkZXN3bTBZSUlzZW94RGV3aUh4ZUsz?=
 =?utf-8?B?VzIzTk5Cd1lrNkQrelZZdEhXQ0RlRmlzVzJNOUJ6SVlxY3hQZDNua0tFV2ty?=
 =?utf-8?B?U3ZKamZZc25lcUZmSTlwMzNRYkMvZTY5MHhnU2FFTzNidzQ1bS9tKzdFMGRF?=
 =?utf-8?B?ay9PWXEzYTZOOUxSN0JGMWFja1N0RWgyWUJvRG56U1JCNnlWY1R4WCtTako4?=
 =?utf-8?B?QXhMMlBYNVpLa2wvdDVNNnMrcWhCQjFNcUI3Ri9WOXN0aTNVeHFLcDBSR00z?=
 =?utf-8?B?REN1V3VIYjUzVDBaY2ZEMWx4T3ZVNU1lR0VWTjVYdFh4bDU2bENoVmlkaWpm?=
 =?utf-8?B?OUhJd2w4SnpzK0R0VHBIcVRkVE82ZGVqMDByeGhhMXJtd3RFM09XbWN5K2ZF?=
 =?utf-8?B?L2kxcHQzeVN2aEJCR1g0VXJNWEQ3ZHFRRlpsN2JNS0xsWjAzbFdFeHVYOXg3?=
 =?utf-8?B?YU1lOEJFYlBGemRyT0s5NHVWdEx0M21RR2tLbTZPRXBPVVIwN3ZqelBWcVIx?=
 =?utf-8?B?ZFJpUE1EakVNanVtQUtQaWFpdGF5QWFYaDE5S1paNS9UWjhrWnpOa0szWnh3?=
 =?utf-8?B?MGYzQ1AxU1NMUk5wNW9yb29LZ3I3bjhrWjR2MVZNWjNZcG1aQjVlTTkyaG5s?=
 =?utf-8?B?L2cwd2duUnVJbW1mQ2RPWWYwbVRWWWFnNzBhNTZ0c2kzcUMvUk11SzIwdmho?=
 =?utf-8?B?bE9TaWNCWGlZWjRkbmtPNGp5bVpVSGJJNGNRbDBUNlNHRFdTWWNHOXJOYUIv?=
 =?utf-8?B?K0x4YjcwS0wzS2QzSm05MHl2amhjUnQybWVyNU84RThWMlF1eW1EL1ArRUdU?=
 =?utf-8?B?aXpWbE5PbEZWOGNOQmovV0RxT1FGTGhaK09Qak1UaHI4QkUzd0ZsQUpTb3RN?=
 =?utf-8?B?YkYrOVBDTCsyVEVaWm8wcVNWc2k0M2NmQ1JvZlFvMnhzUjA1R1JoV2lnWWpT?=
 =?utf-8?B?MmQ1UnYxMytuSzNVVHlWREVJV1NOMW9NaXZmZG1mL1diNnZ2Zmx0bXh5REVa?=
 =?utf-8?B?TnVCbEdZa1JCWEtPTzFxVWFXeVhHYTVHaE4wcFd4YzJPc1pmT2Z4M0IyOXBG?=
 =?utf-8?Q?ptT4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9212.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE5vdU44Z0RYTk5mWm5hQ2MrbmVsSy9HcGd2VWVnYkNQcmNJeS9idXkzY0Vm?=
 =?utf-8?B?MzdJdGZWMWRmS1NZcHFGVVN3eFVIdUdLZ3VaN1hXME05VE4wWXFZMy9NNjBS?=
 =?utf-8?B?QktuV3I2MHNFQzVaRUxKelhQeEFvQkEzTDI0R1pPdkN6Mm1lQkhLU2lTRG8r?=
 =?utf-8?B?QVlWcy94MFNmZ1FhV0I1enYzZy90bHlsWjZjVHdzQ295ZVpnQVU0bmt1cW16?=
 =?utf-8?B?cEZnaEpRdi9lMm9NOG0xUkRteEVqTG5CRHVRU2VwTkkyUU5UV2Z3a1A1YmZ5?=
 =?utf-8?B?alQ5VS83VWJlK1ZvT2k4SGxGa3dYMTRGT2I2b2pndW5Xa0VRNWdaRkpzeUg5?=
 =?utf-8?B?alB3enJaZmdzNFVRTGZhcUxNajY3Z3Z1V0JZMUZ3N3FVY1pwZW4rNFpZWWpS?=
 =?utf-8?B?aWd6WFRtWEtham40Ym15SHBNUTViRzBrYjJ6VzFFWHV2MTFuQ3RXRWJSSy81?=
 =?utf-8?B?b1ArSkpZVlkxYllVRFgyNy8vK3kwcVF6UUg3a3lSYXJQcEdHamNxY3FIR2ls?=
 =?utf-8?B?aUtka0x5YjFaelJiMGgrVXRLVUkvK2xwbWIvZ1E3elIvamlkYklZQ21aL005?=
 =?utf-8?B?UWZUMFRHbDZzYmE1ZzdRdlR5TFg0RW55dHphdWNUWnNnQXF3U3gyTWovSjEr?=
 =?utf-8?B?dWlUQS9DR0Fvc0hLTHY4OTF2VVRiSHAwS3dHOVZkREpmKzlMd2VERzIvUDZB?=
 =?utf-8?B?Q3RzZTAzZ3J2Uis4TjBsdUkwREF4VDI4NUVKVEhnRzBSVWdOc0d5WGpoR3VJ?=
 =?utf-8?B?cFY4VEowbnNYd3ZVUFJ4TXQ2WWQxajRFdStDMTZBSTVWQUhnVUoyNkhYcmV1?=
 =?utf-8?B?dXBZVnhUc2pPMDBkUFNNQnRFVW1JczFKRGtpanpjMndSNUZQOEI5WHhUVmVk?=
 =?utf-8?B?Q1ZyeXY5QUhNd0Fqb242RndDK1ArNlkxeW9OSmwwaXBIbnhJRjN6Zm5JUXFq?=
 =?utf-8?B?K0lXVzVINGNPQm5VVE5XL3BDR0d3RE9ZNXY1UjNSaU9vN3JzUmx0RDVVVExZ?=
 =?utf-8?B?MXo1ZWt4OCtTZWxhRzJsKzJueGdRbkZHU2VXTVR1bkpEejNHY2xXUEl0STlz?=
 =?utf-8?B?VkZ0Rk1qcVo2ZHk4emFLOG5VM0FPOGNZb0ZWcVVYZk5VUDBWYWs2dEdoODhv?=
 =?utf-8?B?SHp1T1F0YkluMUdUMG0remdaa1g4cUVsU2ZYUlVOTjAvOVMzNHFlajZrYldK?=
 =?utf-8?B?UkltQ2tjM25SZ2dJbkp0NUozOFlteGZvdnR2MGFrU1Q3UHhjM0FqVjl6RVZD?=
 =?utf-8?B?R2ZlSzlBa25jbERuMFlFYTVZV2ZkWU1YUUx5Uld6SUtvQk5QbWcxYVVBZk1s?=
 =?utf-8?B?ZFV5b0k4VXdJVVFmVWRodVAxblA1Z1ViTmE1V21TQ1pJTHVXTUdEc1M2WXMz?=
 =?utf-8?B?bS9EWDlRWEMyaTVXdkVVV0huWW9pZFdkK0xTUzc0dEVqY3Y4M1FwdGdZNVJn?=
 =?utf-8?B?UmpJa3NNK0xpZ0FGNEtiU2c1V0dvS2IydGxGNVdjd3pnMC9tRUhlRGNTZmhk?=
 =?utf-8?B?Q1J1MnFuQlVJNndJaWROZEN2aUV6K2FwbmJYdkM5NEZoRjRjb2RwWlFublRG?=
 =?utf-8?B?aXc0dUJrYSs1REgwZW9Fc3Q5VCs1THpJYTcyNSsrbDV1S1dGeGIweXFZaVY4?=
 =?utf-8?B?endadkJjQmVOR1BKdDZKUlFwRTgzZ0liZCtZZHVtREtRSlRVVDRjNWZOaGJK?=
 =?utf-8?B?VWJHc2c0WUZBWGZQNHJhOTRCVWI1Z3FTUC9MT2xJSUxNWXMyR1B6THRXNHNk?=
 =?utf-8?B?NFRKNzU2TjYwUmJ5N0lYUy8yVFlsQk1xZE1scFJQRTZuZWVrcjZrMUhFZmNN?=
 =?utf-8?B?SVFLN01vMXFaSDhsL0JycnVHUmhSU2RmNHkrYkJ3K3JjeHlkSWIwZkEwR1ky?=
 =?utf-8?B?YlJXVU9rVTY0c1gwaTVNVTZ4MU4yM3hjcGxCZGFOK2VUaUluaVNWSWladnR3?=
 =?utf-8?B?b211YUpjY0tIUVpyN0xHVnN6eDZvakpFUmVkcmFDZ05ScU5sTzA5ME5VTWdi?=
 =?utf-8?B?U05qcVVkcUVsR0h3REc2OVZWeVQ4YkF2anhwUlZuTEN3TFFDTVhTT3YwZGpu?=
 =?utf-8?B?Rnl1NTNLcDFDbkFaaHJzZUhoZWFiZi9OMVd3TGxkNkhFUEtXTy81dDIzN2dE?=
 =?utf-8?B?eTl2VW96MlNmQlJWNEVNWEdsc25Ta3NXdUQzbXE5Y1JxYUdqVE92eGlBdWRF?=
 =?utf-8?B?Vm1LZUdJbCtRSmU2elBGeU56MXVIU1BUVTlHemRvdjd0OWlxTGs5QTlpbmc5?=
 =?utf-8?B?ZUdNNWxkSFZGaDdNTlp6K1dDdGc3VWQvTGx3NzFGSnVJQ1pMQWlDYUFmMm91?=
 =?utf-8?B?T091ZUk3VC9wc2FFNHRhcyszaHpVbnNpa2xrZ3g5S3A2S2dYL2U2dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b900119a-821f-4c41-5294-08de57f9fbae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:00:31.6321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNU7lUgR2jNE/ZoNDrP7feN3OtS3ZPMvX2tU+TJwMZNSiIFmw69KwU3ANIsg7Ha7GprpeOVVEICJJP4bHsdIog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245
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

On 1/7/26 12:00 PM, Shani Peretz wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 23.11.6.
>
> The planned date for the final release is January 22th.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v23.11.6-rc1
>
> These patches are located at branch 23.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Shani
>
> ---


Hello,

We ran the following functional tests with Nvidia hardware on v23.11.6-rc1:
- Basic functionality:
   Send and receive multiple types of traffic.
- testpmd xstats counter test.
- testpmd timestamp test.
- Changing/checking link status through testpmd.
- rte_flow tests 
(https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
- RSS tests.
- VLAN filtering, stripping, and insertion tests.
- Checksum and TSO tests.
- ptype tests.
- link_status_interrupt example application tests.
- l3fwd-power example application tests.
- Multi-process example applications tests.
- Hardware LRO tests.
- Buffer Split tests.
- Tx scheduling tests.

Functional tests ran on:
- NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-23.10-6.1.6.1 / Firmware: 22.39.5124
- NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-23.10-6.1.6.1 / Firmware: 28.39.5124
- DPU: BlueField-2 / DOCA SW version: 2.5.5 / Firmware: 24.39.5124

Additionally, our build tests passed on Linux and Windows.

We don't see new issues caused by the changes in this release.

Thanks,
Ali

