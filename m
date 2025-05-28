Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F98C5AE59
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 08:14:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99572402A8;
	Wed, 28 May 2025 10:14:40 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mails.dpdk.org (Postfix) with ESMTP id 82AD440279
 for <dev@dpdk.org>; Wed, 28 May 2025 10:14:38 +0200 (CEST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5CQIu029367;
 Wed, 28 May 2025 08:14:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46u3b13uyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 May 2025 08:14:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWojj/a0kqYeyy/1++W5UJTZnqWg4tN8+UHy+a64klfcmrsW7TZ2onhqHSX707QcwXF4VfsURqSVXd4Eda/IycwdIGty3UKAsVfeVl7xJxkWJ5KYsAMKagA5/i+QUy3RT5zcQyjFXWvonqMH2Vxw9GzCGPGu3uprYfeta58NaRdKtBEYxmSATQXYApSxr3q3VY/oZ09qTfrgtuD2W8SDn9dFrnF7QykfFdZjEeeOKV5r6OYmoLYQrYnW255p2OCPM5vS1kLTijhK2+bdCfhtroqLPWkQ/qs/GRCu8d+eJN/OkriRBLbBHxRLv9bxk/EsqQR++xAUgg5ErR45NxqHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SowJCWVhxBx4Yp2yGR3EsLPpiq1mZxr/PbhXwwTOrrE=;
 b=sClxGmFvZrsDRRq6KbRHxTSjmwuGgVthLAE1G14B3BognYI1Ex4WuUJN5YdwYcfvMKd83rwvyNpmRt3k19UmgnqLasW9K2sD0cIn3caLHq1+NGbY3bDgudZaClSAbd3k7c9dEJ1txwSZwL0dRTMtW5Zlh7XcvYxfO/hRSw8owjxFH/x+zedVsCEmn0owuNsMoPuMshaij95YxGRLiJO5awvXhDY6UPmpSGNgFLyXZMZy95fpHstfhPKT3oR2GdCDLTcn59yoIlFwx2Ua6lfeu2/4JbQhy/FK1IOaui1MRTVgLQ9OER5tHuP3iKTADkAMtGu6sCLMO1nDSueFXZyvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by PH7PR11MB8057.namprd11.prod.outlook.com (2603:10b6:510:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 08:14:33 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%3]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 08:14:33 +0000
Content-Type: multipart/alternative;
 boundary="------------6w3NPD4uxv6qSzfcjifGUaR9"
Message-ID: <936dd1eb-07a0-466d-bc25-48ba98def59b@windriver.com>
Date: Wed, 28 May 2025 16:14:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: |FAILURE| pw153190 [PATCH V3] Add new tracepoint
 function for type time_t
To: Sunil Kumar Kori <skori@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 David Marchand <david.marchand@redhat.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "dev@dpdk.org" <dev@dpdk.org>
References: <20250430013431.2056969-1-changqing.li@windriver.com>
 <20250430024403.2690306-1-robot@bytheb.org>
 <d498a836-e6eb-43b8-9ea3-bdb98ae4aaf8@windriver.com>
 <CAJFAV8zk=gzCagoU7c4=dsXcEFnLjiqrWxwTWANa-U77Uj=Taw@mail.gmail.com>
 <e6ca8bfc-06dc-4844-9b2d-f44436050165@windriver.com>
 <BY3PR18MB47853116D8C07076A91BAC3CC88BA@BY3PR18MB4785.namprd18.prod.outlook.com>
 <CO6PR18MB3860EF5F3CA54B85A0E73CCCB467A@CO6PR18MB3860.namprd18.prod.outlook.com>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <CO6PR18MB3860EF5F3CA54B85A0E73CCCB467A@CO6PR18MB3860.namprd18.prod.outlook.com>
X-ClientProxiedBy: TYWP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::13) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|PH7PR11MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed973e0-9627-44d1-fae7-08dd9dbfad9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkFlaEh1YmYva1d4SFpBSlV4d09ZcmhyaGYwK29xenhRVGFPMjBLc2RnUnNT?=
 =?utf-8?B?NFU5dTVMTUxBbDlGR1hkaEhyY0xYdllyMHJxRlFOU21EVFB2Z3l0b3lyVDhW?=
 =?utf-8?B?UmR5THhaOUtNR3RrZ1RNODZVa3c0RUx1YzlBR1BQdWJYSkN2OVZQRFpma3gx?=
 =?utf-8?B?Z1VCSVBOMEIvbllINVlpbXVVMmxQRHlJOTdPR3ZWSTk1UG4yTGY0UUdYK2p5?=
 =?utf-8?B?NVJhcDZ5ZXN5WU93cnlJSkxhdHV3VGtXdkZwNkQrQzJWcWFJSUVHWWtsQ2VL?=
 =?utf-8?B?NzNKZ1JJTmFSUzUwdHZRV0JQZ0lERlptVmhkV1VLb1VRbldMZE1MYytvVGFE?=
 =?utf-8?B?MW9sazBzZU1DOTNkTXpxa2M1M29sRTJzLzJqd0wzSm1QOFBWSmZIbWYrRFVG?=
 =?utf-8?B?V09ZYUpkVlFKZ1h2akZyVHowdjBpaE8vdlk4VGNiOVBsZTRyTHpwZFM2VmdH?=
 =?utf-8?B?UlhyN2tXeVRhSWowdDVMcU8yRFJJNC9Wc1B3dkd5K2tyUFJWaUxscC9FdS81?=
 =?utf-8?B?Y0NWQU96SW5mK1BGLzJsTlJwcVlqanJOY3VzbXBtUlpCQk9xYXVJZ05jQkp3?=
 =?utf-8?B?SDJpaWk5TTM5clpvQzA5SElFSHRiaE4yUjFMZ0swT0VtTlY1MDFoVXFGZFJF?=
 =?utf-8?B?QkZ5aGhTeGNNd3RScHU0ODlmeGZNZmQvMjFMUlplQmhJSUJMMlp4S0lRb1ZP?=
 =?utf-8?B?N1NBMXlJOFRrS2llZmhlQlZ6U2RDSW1Tc0h6MnFIcHdwU0MvR21aVi9TZW9i?=
 =?utf-8?B?NUYxd0ZTV1p5TDZidGlXSHV1a3RhRnpGbDk4K3lkbWNFVFBneDROamdqR1NI?=
 =?utf-8?B?QVhKQTI4T2pLaVg3TmlyT3Z4VUJMQXR4VXlPcWp2NDBTY2kxUWd4VzhCL3dk?=
 =?utf-8?B?M1hiZFYxOUF3QlZkSEhobnFFbjFUWU4yUmE5RDd3NTZSSURXZE9GcERibExW?=
 =?utf-8?B?RlkwZ093bkdOU2ovNHB3eWRaM2xaUWNTd1I1N1BjajBiMXhoS1VLdWNGUnYw?=
 =?utf-8?B?dklaNVFsaHA3NjlsQUlPZksveEg3TkYxNytWOXdrZHIwelBidU5tNkdmVFVQ?=
 =?utf-8?B?SisxSW5NdmVYbk9vb2NqQzJRTW5vWTBYTndjZm9LN1Z1Z2ZMbkwxbDVyc3Z5?=
 =?utf-8?B?RmEvSXduSnVXejVKMlZ5ZmYyc2VFNHEvUWZkQVlKejU2ajBJMXUzSXM5akJv?=
 =?utf-8?B?STg2eFo4Q29XenFGeWRwcEdKK2NhUWJrbDNZSzMxV1hSL3BUQTBxV3RWK3py?=
 =?utf-8?B?ejdLVVQ2RVFsZUxiblFndkxpbGl5bVhYcFo1MVFZTEFCSFpxVlh5TU10MkRy?=
 =?utf-8?B?bHU5K2YydG03cGRnSnE2ZjB3bktMTnhGZUg4RjNHbDBIMHVLS1EyQ3lOek9Y?=
 =?utf-8?B?WURlTk9ZSTlpYkhYNGpTdkJFWFp1amxXZklrM3NXbUdONDdCYlczakR5a3pK?=
 =?utf-8?B?aG9zNHhZajRlbzRzdU5ldHUrbEFzR1k2YlE0Ykk3QmpnSVdLQWgyRm1QUjE0?=
 =?utf-8?B?cS9lR09udjFnT0g5M2FrOUx0ZExTRUdNQlAvRXEyaVBmaEJ6QW5KcG52YUNi?=
 =?utf-8?B?blZLcExhb1FPRnhHVkFCbGpDMHJ1dmE2K3UvVjZvTnhtZjNUdHlTRm82ZTlr?=
 =?utf-8?B?dVhvd0tVUkhyN29ReEtNWGxERHpRZHlTc1RWVWEydXcvR3ZrRXVRVERZYzR6?=
 =?utf-8?B?OWlVTy9HUVQ5ZTB6VjRFM0tjSDBDWW9qKzY5NXRCaWlpZk5QNmIzbit5OWRQ?=
 =?utf-8?B?cDdTLzQ2SlBCQ3BRZDgvYll3UndtbjJrZk5QbGNCblVreE5BWEE4TWswMWFN?=
 =?utf-8?B?T2pvQWkyckpkMmR1RkxWUTExS05BK3dESDcyKzdOYStkNEFVeU1VSlpwM0pU?=
 =?utf-8?Q?n5PzAPeopjF4M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU5JMnE2S0RGanc2L3pGY3ZMcEwzcnNOTFlGRzJXeUtoUWgzUXJHRXpHbWFv?=
 =?utf-8?B?TmEreFkzVGRpYUJxRDhDNkF1THJxSFFSNUhtcnNHbDkzQ0JhVzkwLytHTmU1?=
 =?utf-8?B?c0NiN1UvcEx5ZmJ3ekdBbWpkaEowQ3UzOGt0bEhCOTlKbTFNK2ZpeXZ6Qmht?=
 =?utf-8?B?Wmx5QUM2TU1LWFR5VW5uYi9NeHQxMEloT0daYm5lekt0ZmY1aWJCNlMycEtk?=
 =?utf-8?B?a2JUTXJOUC9nck5YVDUyM1krQ2VHVWZOZVZxUDY5WTVteTZRZnBtSmsza2lp?=
 =?utf-8?B?S0trRytnbFM3Y0VvUkZYVHhiRWpEMks5Vy9MMW03ZlYxaTV4L1BXZkE5Zjg0?=
 =?utf-8?B?akRTeGw5NU05OEcxbVJUVkVBUzQwSTZiZmF3UXhZaTRaVnBSNWlTMThvRGhI?=
 =?utf-8?B?MGY3SEdNTnVLSmVFQm52eWw3OXhpTUdKVThWaFVHNFNQQm9xL29JQXJzQlBJ?=
 =?utf-8?B?anFrYWNXMUYydW5mZ3c1YnQ5S2t0Z0p1dHZsWS9EclhBTlo3aWFPbytsVE9M?=
 =?utf-8?B?NEdqbHlOMnpRbkZTOGozME93dnpyZFJxQjlieUtkTWF4MmdLNGdOOFhPTkEy?=
 =?utf-8?B?VmlLQ3hGK0srSnl1b1o5aFIzZ2FsSFZjdlJESTdSYlNQcFpxTVV6b2NIeVlY?=
 =?utf-8?B?S283TWdUeTZSM2c5ek0xWmRrZzJMaUJ3b2FtSTRsWXRJTmlOL1NKT3o1bnRM?=
 =?utf-8?B?N3JHUFJJMDIwV0tOUmtuc2tqQVVQdERnVHJMREMxQWtIOVRHZ0d4ZTVyM0l0?=
 =?utf-8?B?ZUY3cVdqbkVpYmlOYjYyTVJJQ1g3N2paWU12Y2Npajd4M3J0M09wczUzeUs5?=
 =?utf-8?B?M2phYjZBZzAxZXZlWVRJSHF1Zlh0QmFKU3BXSy91WGZ6Nk85dmh6Zk55UDlV?=
 =?utf-8?B?aGNSN0x3NExNNWQ4MWljVWVzN1NpTThLZi81RVJzMWVkR1djcjJabzJDYXZa?=
 =?utf-8?B?eHV0OVEyMDhOMXVMSFFjSFdidllSc2Y0SFNVeHkzQ0lkZTE4bVYxL2wrTEhm?=
 =?utf-8?B?MnlqMXh6eGliMEtidmRCcGFmVlFXeENqUTZZOXpCSjc2Y29ieGxFMnlZZmtZ?=
 =?utf-8?B?K3B6K1hkN3lZdlhqemUvRk9FRTEzOGpQTGNsK2VwQU9BSTlWM0JOQktnbmMv?=
 =?utf-8?B?NzhZRFJ3b0VyWkdiMXZTbW9FMGl6MzZ2NzljQkwxV3J2Ynh1VkZCVnJEdThG?=
 =?utf-8?B?ekVYUHEzWnVMeTdmdHlPT2VDYVhWUnZxYXRXTU5iYXZKVThWUmxvd0MyT3Aw?=
 =?utf-8?B?dWRRcnppaTJoeG8yVnAxOENPU3ZOUVRoZ3ZuSTA2T0JhVUJuZU9TbnRMUmpT?=
 =?utf-8?B?WldKY2lVbVdZUTRTVG8wdGYwN3RuZEVGRmlRdFNxNjE2T3F2dkZnNXZaekl3?=
 =?utf-8?B?V01ZeHA4VWpYZUFBRVc0QkVrZFBPbnFQellxUDNCNHhwdWdaY1ZETXprVmZB?=
 =?utf-8?B?MXYycWowV0tLbFpKTjBmWENUWEN3L1MzYTdpODBHWk5NOW93VmljYUUvNlow?=
 =?utf-8?B?ZFFSRS80WFM1YzBTUzBYTG15NVBHYWJidEI5WjdXZTlKMkJUWkptS0EvRlNx?=
 =?utf-8?B?eksxN1RCY21sWHdEVW1sR3p6L2d4VVRWZ0NxcXg2UE9YMExSSkQ2NXd2NWdy?=
 =?utf-8?B?emhaQkxKMlg1OENydmJhNjAzWHBsNkc5RVhvVS9ub3puRkI3a254NjM5aW12?=
 =?utf-8?B?V3JWdXlSQ2V6WlpoL3doYlVNSnY5MExsZ04zWjNZV1hkY0VzaG5PTWEzc3J3?=
 =?utf-8?B?WC90djQvVXNuY1FHWnJtSnNQSVhYRCtkbHZESTBrVXFDa1k0b2FSTmxybGdH?=
 =?utf-8?B?am04M2hHUjdyVVQxajB4U2E3d1lnalpYNTY5dFNad1lQMVZVSk11RVIyNEpW?=
 =?utf-8?B?anpubkUwMkhhRlpCWWxkd0VHbVB3VG11VS90cGNxb1dwdE9mMllSc2s4WXQ5?=
 =?utf-8?B?ZlczRXpCSld6RTd0TjFRc1hzdTBnM2ZOOWN0VUJyQkprcWxUS1B2bDFVcU1q?=
 =?utf-8?B?bWlLeVljTnlNME9uZ281SzBHUHNYd0E2STBoTENlT2dlV1VyMzUwSjJWWEx4?=
 =?utf-8?B?c2F2T3h1QmJVRVlHVjhLRmZtWk1SUUxLTmZTR0k4WkcxTFVBS1BrVVhGdkVv?=
 =?utf-8?B?blc4TW55WWE1dnZjSWdGcm5IeVlWY3ZOZ0YxREN2YU5DMklUN1lqck5UTGk4?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed973e0-9627-44d1-fae7-08dd9dbfad9d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 08:14:33.5849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GB9ulzff666q6L2tEG1OojV9GsgIzGPZ+VsJhlELJvsy0RGKEF6B3jv4CcjkLcOFTUBQ+ZUlIp6jf7qVq3rIMHxJ57+wEBpcJuxqPJULznY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8057
X-Proofpoint-ORIG-GUID: mmDhDMpYmvTwhbkweS_zKth0Urn9nc69
X-Authority-Analysis: v=2.4 cv=VpYjA/2n c=1 sm=1 tr=0 ts=6836c5ed cx=c_pps
 a=oaECux/IpvrMHCGJ/4fOwA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=8rWy6zfcAAAA:8 a=t7CeM3EgAAAA:8
 a=DnJVbuqOAAAA:8 a=M5GUcnROAAAA:8 a=20KFwNOVAAAA:8 a=bt5KbKNvAAAA:8
 a=jZVsG21pAAAA:8 a=Km1mC_mTxVzJyDX35h8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=UqCG9HQmAAAA:8
 a=wvPkM9v7g1_ikmSEda4A:9 a=qq0DJVrMLB0x-356:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=YjdVzJdQTyZRADMV7wFX:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=Sz6ghim2xQgRqd81wKBx:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=a-zEBD5cKgE7DNtTSb7C:22
 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-GUID: mmDhDMpYmvTwhbkweS_zKth0Urn9nc69
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA3MCBTYWx0ZWRfX26afFWeg9cKB
 j+IHqGiDpkB3Mzuz1hHIqJg4U6IcbadlR09KFhzV4jgy6GcoBm7PSC+o1uPvuLsnUYBxeYF0IE/
 iTHunG3629ofEca4qNJhYtzBK63v/uWHnKo79PNepNAW/RD/ViUQIMmsLTxT16fVi+OH+BeNGoi
 /1bjnT8Hhf5dTl3ywFhNFFUAql3wLg/dEiKGKfmObtEe2iuJuYvwrd/jxhYDU/HX08jnE0VhnCi
 j8I6PokRyRUZ8h1yMrwj6xM/JhTeiBa39fDiJrYkwEf5Ka9/lh2ISvrSTW1fQdW+vc+v7NiDaOi
 a3/kRlnxMkfhEJ991AwRBv9D8uz2WyQtB+vArSisaExeL2ASaCe9H+SGxqAyqsg5rcwzp4S7fan
 EN7wYbgIE1TIYgOfSxpBtjURCfquTNFj19iv72PL7TYSwSCcjYjKbw7AYr+K17cDusBxoGSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_04,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505280070
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

--------------6w3NPD4uxv6qSzfcjifGUaR9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Just kindly remind, with the help of  Jerin's comment,  I had just send 
a V4 version yesterday.

Here is the patch link:

https://patches.dpdk.org/project/dpdk/patch/20250527120404.2027529-1-changqing.li@windriver.com/

Regards

Sandy

On 5/28/25 16:06, Sunil Kumar Kori wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> Please mark this version as superseded as new version is available.
>
> Thanks
> Sunil Kumar Kori
>
>> -----Original Message-----
>> From: Jerin Jacob<jerinj@marvell.com>
>> Sent: Thursday, May 8, 2025 7:24 PM
>> To: Changqing Li<changqing.li@windriver.com>; David Marchand
>> <david.marchand@redhat.com>; Sunil Kumar Kori<skori@marvell.com>;
>> thomas@monjalon.net; Stephen Hemminger<stephen@networkplumber.org>
>> Cc:dev@dpdk.org
>> Subject: RE: [EXTERNAL] Re: |FAILURE| pw153190 [PATCH V3] Add new tracepoint
>> function for type time_t
>>
>>>              I'm new to this project, and have no clue about the failure, could
>>> experts at this project provide
>>>
>>>              some help about the following failure?
>>>
>>>              + sudo babeltrace
>>> /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02
>>> -
>>> 25-21
>>>
>>>              Error: at line 2819: token "time_t": syntax error, unexpected
>>> IDENTIFIER
>>>              Error: Error creating AST
>>>
>>>
>>>      I think this time_t type you added is not described in CTF.
>>>      Have a look at 2114521cff91 ("trace: fix size_t field emitter").
>>>
>>>      Copying the trace framework maintainers who will have a better idea.
>>
>>
>> time_t is not defined in CTF spec. See
>> https://diamon.org/ctf/v1.8.3/#specification.
>> You can create new type using typealias with integer or structure as backend
>> type. See meta_data_type_emit() in DPDK code base where we created new
>> types.
>>
--------------6w3NPD4uxv6qSzfcjifGUaR9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#cceed0">
    <p>Hi, <br>
    </p>
    <p>Just kindly remind, with the help of&nbsp; Jerin's comment,&nbsp; I had
      just send a V4 version yesterday.</p>
    <p>Here is the patch link:</p>
    <p><a class="moz-txt-link-freetext" href="https://patches.dpdk.org/project/dpdk/patch/20250527120404.2027529-1-changqing.li@windriver.com/">https://patches.dpdk.org/project/dpdk/patch/20250527120404.2027529-1-changqing.li@windriver.com/</a></p>
    <p>Regards</p>
    <p>Sandy<br>
    </p>
    <p></p>
    <div class="moz-cite-prefix">On 5/28/25 16:06, Sunil Kumar Kori
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CO6PR18MB3860EF5F3CA54B85A0E73CCCB467A@CO6PR18MB3860.namprd18.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and know the content is safe.

Please mark this version as superseded as new version is available.

Thanks
Sunil Kumar Kori

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: Jerin Jacob <a class="moz-txt-link-rfc2396E" href="mailto:jerinj@marvell.com">&lt;jerinj@marvell.com&gt;</a>
Sent: Thursday, May 8, 2025 7:24 PM
To: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com">&lt;changqing.li@windriver.com&gt;</a>; David Marchand
<a class="moz-txt-link-rfc2396E" href="mailto:david.marchand@redhat.com">&lt;david.marchand@redhat.com&gt;</a>; Sunil Kumar Kori <a class="moz-txt-link-rfc2396E" href="mailto:skori@marvell.com">&lt;skori@marvell.com&gt;</a>;
<a class="moz-txt-link-abbreviated" href="mailto:thomas@monjalon.net">thomas@monjalon.net</a>; Stephen Hemminger <a class="moz-txt-link-rfc2396E" href="mailto:stephen@networkplumber.org">&lt;stephen@networkplumber.org&gt;</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:dev@dpdk.org">dev@dpdk.org</a>
Subject: RE: [EXTERNAL] Re: |FAILURE| pw153190 [PATCH V3] Add new tracepoint
function for type time_t

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">            I'm new to this project, and have no clue about the failure, could
experts at this project provide

            some help about the following failure?

            + sudo babeltrace
/home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02
-
25-21

            Error: at line 2819: token &quot;time_t&quot;: syntax error, unexpected
IDENTIFIER
            Error: Error creating AST


    I think this time_t type you added is not described in CTF.
    Have a look at 2114521cff91 (&quot;trace: fix size_t field emitter&quot;).

    Copying the trace framework maintainers who will have a better idea.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">


time_t is not defined in CTF spec. See
<a class="moz-txt-link-freetext" href="https://diamon.org/ctf/v1.8.3/#specification">https://diamon.org/ctf/v1.8.3/#specification</a>.
You can create new type using typealias with integer or structure as backend
type. See meta_data_type_emit() in DPDK code base where we created new
types.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------6w3NPD4uxv6qSzfcjifGUaR9--
