Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C33AC369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 05:21:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1054402A7;
	Wed, 30 Apr 2025 07:21:18 +0200 (CEST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mails.dpdk.org (Postfix) with ESMTP id BC0DE402A3
 for <dev@dpdk.org>; Wed, 30 Apr 2025 07:21:16 +0200 (CEST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53U4RnU5024093;
 Tue, 29 Apr 2025 22:21:15 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46b6ugrc4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 22:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llmA4xhro3JrI61f1rtGINN7+xxH6CrKggoZnHUl4MlRVAN0+s90nfjeF5bwFPmJdBJGOnhPpWHwdBnejxciU/gpdz7Nrk4IQ8gmud1WGX/n2kguCv+8UtVWbQBPE3/aicvHTj/hMFwhC1hSeYVj5K1YvINravHVzRH/eNtivYEM2SZUvWTrnrFibHJ2IqC9xD3Z/q/HFWux64vCwdHmO/SFCNhr+D8yNn/TyRHD9juIpbPSYYo/aAJ7AY1wpEaZfjbcnao73sd2PmMlHI+ym5vjmRxqbAGdTxEclVZy8RVWhK2PGkRUQdDkX4LGmsWZih0hOo6aVMD0Mv2UtFlmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+web8pnv3GWb+zDjq2AVAZv6Tz2UyrL/gr8c42Wvnw=;
 b=l33SVB+mF7dEXVbIRDXyHyAKwwzZB19+Dnvd30WREtRlSxXeP1RrzMu0fHNpNfBc7NRHMVCQTrXRzD4bmBkVVAPKZxoFgCzfiMKrQQXeDw0rVGq/s5UdfLr2UFemiNJyQ8e1/+ZKizUKGcor1Fzv/nzoN4xDgskUHuGuyC0J9+HS+ecfq68Jurhhnttd5WouwaZfBoWP7OG3Qlqo+3SctZ0lh04HAbEubrzYT6h9ZOtaxcTGYgJtl4yRsA+4RC5f0hv0Jui8TueFZgUjSa+kwF1Z2qHKjOxW0ASn4zBsfyOwA29Ir5wLTHy14z8eAeSIAdOz9C9PiXxovcBLI6fCEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 05:21:11 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%3]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 05:21:10 +0000
Content-Type: multipart/alternative;
 boundary="------------VqkoAaUoyU6moMATSqURHrqH"
Message-ID: <d498a836-e6eb-43b8-9ea3-bdb98ae4aaf8@windriver.com>
Date: Wed, 30 Apr 2025 13:21:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: |FAILURE| pw153190 [PATCH V3] Add new tracepoint function for
 type time_t
To: dev@dpdk.org
References: <20250430013431.2056969-1-changqing.li@windriver.com>
 <20250430024403.2690306-1-robot@bytheb.org>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, thomas@monjalon.net
In-Reply-To: <20250430024403.2690306-1-robot@bytheb.org>
X-ClientProxiedBy: TYCP286CA0231.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::9) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|CH3PR11MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 0456ba26-7060-4702-7f42-08dd87a6d148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG5UV0JBcWNIS2RoRzA0NWRzajU1SHZ4Z0VxVEViK2ZGV1JNTXU3cVlSUUpm?=
 =?utf-8?B?aWtYbGY2UE5IaSs1NnM3VUZzZHdSSElZWEgxcWtOQ1paYkpGclJvcDJPRCtD?=
 =?utf-8?B?WEN4NGVoOHArSTNIWE1Jc01yK2dhY0lCd1UzKzZ2bTRBMEhxZlNyL0x4WUlM?=
 =?utf-8?B?NDV2V1hMa3hxNksrY1E3L0p0a2N5QkV5R05yZmZsaWFqcWt6QzMyWHd3YkNF?=
 =?utf-8?B?TVA2UDY2azRQQmVSTXZacldJUi9GR0xBY1c4M2dyRDd5eXZoZFB6R0NGOWZQ?=
 =?utf-8?B?QzlkYXZrTWtFSFYwQnpaQThWRjJraWcwT0tkQmZIbkFyWUlpUDdlQXlVZEtx?=
 =?utf-8?B?TU9hMEVCYklVUTl1NDhyczltZ3B0akY4a3VMQ3dFT3pUNTdDN0VGemtWcHg4?=
 =?utf-8?B?bXNyRHc3SVdlZGlYSFpVVU1Bb29QODllS1M4dGVZbldJSmVRVzdPU3M2WUZZ?=
 =?utf-8?B?bDZKMGswWHFxVEJycWJSbHJnTFo0NkpYYnhsUXZxZ3pqNnNuMDRMRDhZUUN6?=
 =?utf-8?B?YmNIbVAybk9EY1BqaWZUUUFGR2dUa29sWVIzRWtpUUZ4OXp1c0hlUkQ2dDR3?=
 =?utf-8?B?WWNaVERRNi96T2tMNHNPNnNEaFNCQU9ON2tMODdXc2pNQ09ORURQZVp1Uzcy?=
 =?utf-8?B?NVFMcVlUN2pxTVA0dWhEb3JmRnYxR2tuUFk2WS94SmEwWTA0L25JaXdNK1Nt?=
 =?utf-8?B?enJKUmpKaWlvcG0zUlVrcmZKcFc4WDZHclFpVHA2cEM4Uk5EVlBJNW5aaXBD?=
 =?utf-8?B?dHErSXpiSTRyYmFmVGtMU2w0L1JxWnVvU1VrVHV3QTJGS0lJS2RxSUw2MUt2?=
 =?utf-8?B?RnIyTzdiT3YvZkk5S0lkM05hSXRFK2MxSE5zUWN6ell3ZGlxWTBaYmRrb2tS?=
 =?utf-8?B?SU5xMkFTU1ZzQjNRVUFMMkhaU3RBemFJcEw5dXVJd0lXQWwySGZwdEU5YnNa?=
 =?utf-8?B?eDJvZWo3R0d6cWRjMDlnd3JJRngwUEV6RlEyRDVSTlhScE90cE51OWdkSUZr?=
 =?utf-8?B?SnFYOVR0ZXZxcVg4TVgwOEV4NVM1L05pUmVqN2Q5azYzeW16QXZIb3JDK3JY?=
 =?utf-8?B?ZXhlRU1DM0pmYndPVnNOeXNHdmN5RzRsYnMveWFzSTBEbmo0Lys1OCtNM3VM?=
 =?utf-8?B?bGVyZWsrWXFuNjBIa1RiVlVYZUR4SmhKQ05mYnpjczArbHRyUGs1b3NvNlBn?=
 =?utf-8?B?eXhaaE1taWhjcy8xY3ZnK3JPd29mRHI4eXUzSGVsTHdyNDFZZy96REVXN085?=
 =?utf-8?B?czE2eWtESEFkbjZzeGNmNjNCa1EzSlR2M3NCRzNNNVc5TWU3TU1UQjFFdUlk?=
 =?utf-8?B?dmIvd2J2REQ5WmJURVgydjNqZ2FiWWVmQmw2MUY2bXp2dlpKd2NDdmg4Qm1a?=
 =?utf-8?B?Zlg5V2dpenQ3Ly9DeFNkL2IwblEwdE5Valo2aXI3RythR0FoeTFJRk9hL0V2?=
 =?utf-8?B?Z0lrdzdYSmRWd2NMdHNqMFNWRW1GQ0xJeTMxMmJubHFuRUpCZ2NLaEZKSEFG?=
 =?utf-8?B?WUx3Ykd2Q3ZOMk1jN3lIaDhFM3VNQXlFUXh1WWk1RlQ0QSt4dmp1ZEJLRFl3?=
 =?utf-8?B?THhxTXB5bEhIcmpPa1hSQWY1V1RlTnh1Y0VBaTVhcFA2WUNpYkhKUnpiM1VP?=
 =?utf-8?B?VW9nZElISThVR3JQYnFlSFFmYUo3YzFPS055Z3NwZ2p1OVNXZy9KWGNlMkc1?=
 =?utf-8?B?bjdpbTBzTkkzZGp5V05vUkk4Q1dxdUt0blhtcXNYSVlmMzkrSExFS2xZZzN5?=
 =?utf-8?B?M05jOGVLaTdvWGQ0ZUJzdGhDQlI1ZWRkNFhMMHdTZmhndHAwNE9LQW13djFP?=
 =?utf-8?Q?EkIvXg4pntxbfYtXQay337lr9elzpZEwQGtF8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OExMWFFwSHNrUzE5S2NDOWE2ZjZVK3Y0Z0NHSUtkZ1hOSitHUkRaZytPaFhF?=
 =?utf-8?B?N1p5RDkzOXQrd2wrR0NXTzUvNFdLWm9OOXBISmc5bXJzbUxUdWJSRGx6eGlO?=
 =?utf-8?B?bzZzNU1MVmpidElLUXpQaTEvL1hZdnoybXMvdDFCdVF0QkN1bEo4eWtxVHdM?=
 =?utf-8?B?bWVvZjczMDBYWkEzN3pzWEpWMG1mdFUrWXZiYVduUVIzRldvMHRibjFBZGpr?=
 =?utf-8?B?UThGTmFFOElndkdVY2Y5THcxN29LYkFyR0tkcXU2ckpXZVliTzBqdkN4Wlc1?=
 =?utf-8?B?THpJaDU2djRrRlF2OVBrWHNqeHUwZUVVclZNRFJkUW8xQUdTYlMySnkxZVhn?=
 =?utf-8?B?UTZENE9ZWGJTT013c1p6WG56RU1hamhmemlUZytsc0EwSkk1SnFQR0g1Z3pN?=
 =?utf-8?B?Mi9iMmNwS0g2L3VjTStHK2I3SjNsQjNGUW9JMzI4VzZiV2oxa05jaS9KcnJM?=
 =?utf-8?B?dEtVLy9wenZJZWdBRnpsRC9McCtOaEhSWXZmV1ZGZFJmbGI4OUc3MEI5Mmov?=
 =?utf-8?B?amRuRUt1N2xLdk51RTlhc1FFLzc5a00ra2NUOS80Q0VhMnltdVk2WUU0Wjkx?=
 =?utf-8?B?ZzZHMk9PclZoOG9OaFNxYkp5Ty9QL0pmRFZZU0hISEtLSHVkNXhHQkxtOTVk?=
 =?utf-8?B?ZFQzanJCeHFMak5ubUV5NVlWdDJqdmVmaUJ4dm9KdGIvWFZ0SUQ1YlAwNUcy?=
 =?utf-8?B?VGNQcmdTK3FCT0h5WnBFNDQydnJVT21pTnd0MVhPN051UzNyRkdzcjZUUmhP?=
 =?utf-8?B?TGg2UFd2Q09xVmVOOVBlSVoyL2w3NkVGdXVON1RDZ2ZzV3hPSFRYSW1Pek1h?=
 =?utf-8?B?RG9OWEczN2VDNTJYb2hsZjdoTVY4dEs5VG9IUXJWSUl4aDBFYk1KY3VIM2x5?=
 =?utf-8?B?TmdnMGZnK20xQm12WUJVRjlpaTBjR2FobDNSc0trcW5Payt3R1dRY2FmclM2?=
 =?utf-8?B?UnZpZWtNUThlZytKWXpwcVFwQm1PdTRvcEtVVnNjZ1p3QS9rOFNxRkJmTzBl?=
 =?utf-8?B?OWIzbW95WXZEdVVJWnpTN1EvaE9pU3lVeG9rZnp6ZGR2VTQwYUR3Z0lid1Za?=
 =?utf-8?B?QUd3SURML0pvY01rTDJyUW9IYXBDOU1rcVFJTUJIV1FFNzZLZ0hkb1BuRW9o?=
 =?utf-8?B?QmZOL3RuUlk0QlhPZlJSSE84VjN6TVZ6N3FrTTRxdTk2cGZCT00zNHNObHFR?=
 =?utf-8?B?WklkeDVvZHM3ZjVxMDVMcTMyQ1kybGN3K1ZVTGYxRkRUNlZUb0pKaVZ3djNP?=
 =?utf-8?B?WnBOL2JFTnpaNXh5cENZTW0rV21zQkF3QVFCb1BqN0VGazZqbzRpS2xhSHNB?=
 =?utf-8?B?a3RFdFBIaHFqUWdpeEgxSGMvVmpLZDdLMUtQWk1BNmZlcXBHNi96Q28xbWpR?=
 =?utf-8?B?eVh2L204NzViMzk5RjNCTHNqSWtmdm8rOVBmaytDTEl4aVFJVHJYNURsZ25s?=
 =?utf-8?B?WVRQWFEvaithU1k4UU1mWVF0UDBqUmh0eVVMZ0V1YU5rWndSUHlpUTV1M1JO?=
 =?utf-8?B?bHFXYU1uWVc0QVdFVitNcjBUOUlHa3hlK0I5bk94bURxbU0rR0dLMjVDTi9B?=
 =?utf-8?B?anVMVjVoNnhCUzlLUWdJL3F6dDdZc2JIaGR6NFozS2dKQ2NvUzd5WGtScGhk?=
 =?utf-8?B?eFJXQjI2aXhjZnp5Q1Axd2NYc0Jxa2czL2poSklPd3lIVWRlaVlGU0FoZEJp?=
 =?utf-8?B?WXlwWG1NYmhDVlQvS1dVay9YeEFqaFYxQUtOUGF6SlN4akUzc0doanlRZDc2?=
 =?utf-8?B?R0FZK1FJQnFVd1BKbkZJM05WaFhKZ0ZsY0hmQ1F0R2FNYXQzaExwdDRjb2pm?=
 =?utf-8?B?ZDd0Yzd2MGhRNHVzeExkUGE0cTlmeFVmanBwRUhJVTlRalhlOVJBMVZrcTFv?=
 =?utf-8?B?Rk9ZMThEM1F3aWt2UGVsMDJVRHFuTXpJbHBHUGFQQXI5bmZ2SGF0NzljVVRj?=
 =?utf-8?B?REVPbFZGQlFZdWtrZENvMjJNZ2ZPQ25xL0V5QWtVWVp4UGZVV0ovdmtaQXdD?=
 =?utf-8?B?aDg4cW9wcXBIQmI4TTNnUmc1UmVRb2ZWeFZaQTBNTnpUZXorcnFlSXp1R3Yv?=
 =?utf-8?B?ZGFhTTQ3ZnYzY1NZSGZsSnFFamR1ZzAwU0pqRmZYWTNtOXBiYkNyU2VicTFh?=
 =?utf-8?B?NWtHa0ZkUi8zY2FHRlJYZWtaOXVPOUNNVGkwSlc1bUVCd1MzdTFUUUtLS0E0?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0456ba26-7060-4702-7f42-08dd87a6d148
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 05:21:10.5465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihPTGJC/Bd8v18a1Lyo8Cv5JBJONGx1y573tGlwqVMwDIul35iyydzk9d/9ByYf1DEnZvH9+8lK6ucQywcJcPqSxBXD/JutWvUxM50laAck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8660
X-Proofpoint-GUID: lUlxBWV6hhAynIA0VCrWZWDXrW4zVFAe
X-Proofpoint-ORIG-GUID: lUlxBWV6hhAynIA0VCrWZWDXrW4zVFAe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDAzNSBTYWx0ZWRfX4FlLYOHCFv+g
 cK7Ya0UyRIbuFJynqtPKJarP112T2t4wQI03uvktA24lxUeVm0se5UdAWGTYngUu8xcD+qAPhWk
 gGms/uCeFwygytmx/ALDPiNFI0CRizPgWzMo3bzEYt3Zk6qd/S/fk1tHyJKOZdStQTRDaCsZQ63
 LFu9dubP2pff0Mc0pMUc0Ywya6rD+QNdZasUIHEW8JAOqXvFlidIN3F6ROulu0eRX2+ioywkZe8
 Pq+PRufyAbblKB5bajo1D1TZNtjrLSU88iKNB/L6Wt+0qRAnXYJ2doxdvlJLOIEXVLxnCVwzOK/
 VseEOaVESkRGNRGU/Pm/YLTh3xGeSTI0TDkwgVFt5E3dge72IqayhgB8l5xUbPP6iU4drdechE8
 RS9p4uYXiB0HnoVxkW/gY87hrsZDQmLPWK0fAZJOC+EKmIck7gDv54VT6fBOcCaQdmRhYVd8
X-Authority-Analysis: v=2.4 cv=Od+YDgTY c=1 sm=1 tr=0 ts=6811b34b cx=c_pps
 a=UtaLnOzkojfj4BVWksq/2g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=8rWy6zfcAAAA:8 a=NEAV23lmAAAA:8 a=MXUZZd-3AAAA:8 a=wHEBUik0BYGhFII_EFgA:9
 a=QEXdDO2ut3YA:10 a=kFyrfeTs8c9TbURoBgMA:9 a=FQMAOZhh53RlfMlw:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OHvXegdpiI7XpiQBpVZC:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504300035
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

--------------VqkoAaUoyU6moMATSqURHrqH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm new to this project, and have no clue about the failure, could 
experts at this project provide

some help about the following failure?

+ sudo babeltrace 
/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21 


Error: at line 2819: token "time_t": syntax error, unexpected IDENTIFIER
Error: Error creating AST


Thanks

Changqing

On 4/30/25 10:44, 0-day Robot wrote:
> From:robot@bytheb.org
>
> Test-Label: github-robot: build
> Test-Status: FAILURE
> http://patchwork.dpdk.org/patch/153190/
>
> _github build: failed_
> Build URL:https://github.com/ovsrobot/dpdk/actions/runs/14744930390
> Build Logs:
> -----------------------Summary of failed steps-----------------------
> "ubuntu-22.04-clang-asan+doc+tests" failed at step Build and test
> "ubuntu-22.04-gcc-abi+debug+doc+examples+tests" failed at step Build and test
> ----------------------End summary of failed steps--------------------
>
> -------------------------------BEGIN LOGS----------------------------
> ####################################################################################
> #### [Begin job log] "ubuntu-22.04-clang-asan+doc+tests" at step Build and test
> ####################################################################################
>
> Full log written to /home/runner/work/dpdk/dpdk/build/meson-logs/testlog.txt
> + catch_coredump
> + ls /tmp/dpdk-core.*.*
> + return 0
> + check_traces
> + which babeltrace
> + sudo find /home/runner -name metadata
> + dirname /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46/metadata
> + sudo babeltrace /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46
> + dirname /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46/metadata
> + sudo babeltrace /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46
> [error] at line 2819: token "time_t": syntax error, unexpected IDENTIFIER
>
> [error] Error creating AST
> [warning] Unable to open trace metadata for path "/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46".
> [warning] [Context] Cannot open_trace of format ctf at path /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46.
> [warning] [Context] cannot open trace "/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46" from /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46 for reading.
> [error] Cannot open any trace for reading.
>
> [error] opening trace "/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46" for reading.
>
> [error] none of the specified trace paths could be opened.
>
> ##[error]Process completed with exit code 1.
> ####################################################################################
> #### [End job log] "ubuntu-22.04-clang-asan+doc+tests" at step Build and test
> ####################################################################################
>
>
>
>
> ####################################################################################
> #### [Begin job log] "ubuntu-22.04-gcc-abi+debug+doc+examples+tests" at step Build and test
> ####################################################################################
>
> Full log written to /home/runner/work/dpdk/dpdk/build/meson-logs/testlog.txt
> + catch_coredump
> + ls /tmp/dpdk-core.*.*
> + return 0
> + check_traces
> + which babeltrace
> + sudo find /home/runner -name metadata
> + dirname /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21/metadata
> + sudo babeltrace /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21
> + dirname /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21/metadata
> + sudo babeltrace /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21
> [error] at line 2819: token "time_t": syntax error, unexpected IDENTIFIER
>
> [error] Error creating AST
> [warning] Unable to open trace metadata for path "/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21".
> [warning] [Context] Cannot open_trace of format ctf at path /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21.
> [warning] [Context] cannot open trace "/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21" from /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21 for reading.
> [error] Cannot open any trace for reading.
>
> [error] opening trace "/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21" for reading.
>
> [error] none of the specified trace paths could be opened.
>
> ##[error]Process completed with exit code 1.
> ####################################################################################
> #### [End job log] "ubuntu-22.04-gcc-abi+debug+doc+examples+tests" at step Build and test
> ####################################################################################
> --------------------------------END LOGS-----------------------------
--------------VqkoAaUoyU6moMATSqURHrqH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#cceed0">
    <p>Hi, <br>
    </p>
    <p>I'm new to this project, and have no clue about the failure,&nbsp;
      could experts at this project provide</p>
    <p>some help about the following failure?&nbsp; <br>
    </p>
    <p><span class="CheckStep-line-content d-inline-block flex-auto ml-3 js-check-line-content"><span class="" style="">+ sudo babeltrace
/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21</span></span>
    </p>
    <div data-index="45204">
      <div class="js-check-step-line CheckStep-line d-flex log-line-error">
      </div>
    </div>
    <div data-index="45204">
      <div class="js-check-step-line CheckStep-line d-flex log-line-error">
        <span class="CheckStep-line-content d-inline-block flex-auto ml-3 js-check-line-content"><span class="text-bold color-fg-danger">Error: </span><span class="" style=""> at line 2819: token &quot;time_t&quot;: syntax
            error, unexpected IDENTIFIER
          </span></span> </div>
    </div>
    <div data-index="45205">
      <div class="js-check-step-line CheckStep-line d-flex log-line-undefined"> </div>
    </div>
    <div data-index="45205">
      <div class="js-check-step-line CheckStep-line d-flex log-line-undefined"> <span class="CheckStep-line-content d-inline-block flex-auto ml-3 js-check-line-content"><span class="" style="">
          </span></span> </div>
    </div>
    <div data-index="45206">
      <div class="js-check-step-line CheckStep-line d-flex log-line-error">
      </div>
    </div>
    <span class="CheckStep-line-content d-inline-block flex-auto ml-3 js-check-line-content"><span class="text-bold color-fg-danger">Error: </span><span class="" style=""> Error creating AST</span></span>
    <p><br>
    </p>
    <p>Thanks</p>
    <p>Changqing<br>
    </p>
    <div class="moz-cite-prefix">On 4/30/25 10:44, 0-day Robot wrote:<span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite" cite="mid:20250430024403.2690306-1-robot@bytheb.org">
      <pre class="moz-quote-pre" wrap="">From: <a class="moz-txt-link-abbreviated" href="mailto:robot@bytheb.org">robot@bytheb.org</a>

Test-Label: github-robot: build
Test-Status: FAILURE
<a class="moz-txt-link-freetext" href="http://patchwork.dpdk.org/patch/153190/">http://patchwork.dpdk.org/patch/153190/</a>

_github build: failed_
Build URL: <a class="moz-txt-link-freetext" href="https://github.com/ovsrobot/dpdk/actions/runs/14744930390">https://github.com/ovsrobot/dpdk/actions/runs/14744930390</a>
Build Logs:
-----------------------Summary of failed steps-----------------------
&quot;ubuntu-22.04-clang-asan+doc+tests&quot; failed at step Build and test
&quot;ubuntu-22.04-gcc-abi+debug+doc+examples+tests&quot; failed at step Build and test
----------------------End summary of failed steps--------------------

-------------------------------BEGIN LOGS----------------------------
####################################################################################
#### [Begin job log] &quot;ubuntu-22.04-clang-asan+doc+tests&quot; at step Build and test
####################################################################################

Full log written to /home/runner/work/dpdk/dpdk/build/meson-logs/testlog.txt
+ catch_coredump
+ ls /tmp/dpdk-core.*.*
+ return 0
+ check_traces
+ which babeltrace
+ sudo find /home/runner -name metadata
+ dirname /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46/metadata
+ sudo babeltrace /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46
+ dirname /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46/metadata
+ sudo babeltrace /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46
[error] at line 2819: token &quot;time_t&quot;: syntax error, unexpected IDENTIFIER

[error] Error creating AST
[warning] Unable to open trace metadata for path &quot;/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46&quot;.
[warning] [Context] Cannot open_trace of format ctf at path /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46.
[warning] [Context] cannot open trace &quot;/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46&quot; from /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46 for reading.
[error] Cannot open any trace for reading.

[error] opening trace &quot;/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-20-46&quot; for reading.

[error] none of the specified trace paths could be opened.

##[error]Process completed with exit code 1.
####################################################################################
#### [End job log] &quot;ubuntu-22.04-clang-asan+doc+tests&quot; at step Build and test
####################################################################################




####################################################################################
#### [Begin job log] &quot;ubuntu-22.04-gcc-abi+debug+doc+examples+tests&quot; at step Build and test
####################################################################################

Full log written to /home/runner/work/dpdk/dpdk/build/meson-logs/testlog.txt
+ catch_coredump
+ ls /tmp/dpdk-core.*.*
+ return 0
+ check_traces
+ which babeltrace
+ sudo find /home/runner -name metadata
+ dirname /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21/metadata
+ sudo babeltrace /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21
+ dirname /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21/metadata
+ sudo babeltrace /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21
[error] at line 2819: token &quot;time_t&quot;: syntax error, unexpected IDENTIFIER

[error] Error creating AST
[warning] Unable to open trace metadata for path &quot;/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21&quot;.
[warning] [Context] Cannot open_trace of format ctf at path /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21.
[warning] [Context] cannot open trace &quot;/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21&quot; from /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21 for reading.
[error] Cannot open any trace for reading.

[error] opening trace &quot;/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21&quot; for reading.

[error] none of the specified trace paths could be opened.

##[error]Process completed with exit code 1.
####################################################################################
#### [End job log] &quot;ubuntu-22.04-gcc-abi+debug+doc+examples+tests&quot; at step Build and test
####################################################################################
--------------------------------END LOGS-----------------------------
</pre>
    </blockquote>
  </body>
</html>

--------------VqkoAaUoyU6moMATSqURHrqH--
