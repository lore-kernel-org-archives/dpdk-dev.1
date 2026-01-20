Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B5CD2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 08:59:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8EC140DD7;
	Tue, 20 Jan 2026 09:59:11 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by mails.dpdk.org (Postfix) with ESMTP id ECB3A4013F;
 Tue, 20 Jan 2026 09:59:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBspBEwbuNSKK1xNQJJmwtly8BujmW62mtE2NCU9KMoRirV2Y+m1dLOCNPMp6EbnIgmHN9+H+Q9E8A3BJcfaA+OyQgr7oHYNU4pmviMvHj4jeCPUXr1G+qj7f4ITkM307k1vB/nAx4TMzePbox0ZIV3xp4Rsw7JX6+qtVZXpuFyLyW7bDmf708ApakYPA/ZssOrEuZtcjetfDcRC3AuhI0c9AUFB68eVXTuy5Q43l2M1lkFYpFbbvWCn7CYpmseVnHOVMKK4FI0d5zazUHO6/ImVSyEz/cpcQosg+40NTo58r14vuJldOmVHB2RK8s0BsU7aPB+npgmT8MMW2rTLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouP3sF3OrR7LhmA6q66Z2iWUPwUO4Min9Jbt7Aq6zyA=;
 b=MRAVcCrs7zKhprhFelfuvnLhA092lhOKK+ap9C/E7jk5+bu9/fephLpi+k5XWoR46XF29623enNxm9ZAuUYhuMHGQ0cMTV2t1EGMtT/duq0uHNiyylCVsYDTo0hR/mPIFjaTwFW4X8vf5Nt/Xd5fkY81sJHSLNQblBk2s3jtTiDk7XKf3zKjal/5uujEht8bWYnuoMCdmVL3PrH+NQ1FzCghxmHovbTThZOgZ2uLhyTz+/c1pE/3o3TfqHS8YGtQc9cVAIqYJho3jMXPmBXXxs+VqyfNLSmaCQSI+nNUye3HetzP1ULXVyPciO7EeBaPJNA09LrvBWXLKS+Z4vYqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouP3sF3OrR7LhmA6q66Z2iWUPwUO4Min9Jbt7Aq6zyA=;
 b=VFVnvQsRfASTxGYCkDzR7aWMghilUGX5COSqZpMp3riEoVLemkGUj6fRU9v+TrF2pJUXTOhzIOvIOjec+gSXRl/cTwDYCZq75NLiHUuIIx7SzcvNG0F7KFcIyeAY7sSSq1hn5oA7qgbbByKyuuCh2OapKnVWL3AMr71kRdsqyYLjZY66/Oey8VHNd8r2mM4Uo6ATZI2GWry1+qDPHYkIQr3GrvVeIf56um6iDxHX2tQxfFGt6zX34muy9s7bNhcrtLU9fpFAUxfts66sUENpqZM7q5suxrb6LhvsrcqU1atNT+Q1mVnyYXqijB61RLd5vfnWfjQNm+7yJZw7WzrSww==
Received: from MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 08:59:05 +0000
Received: from MW4PR12MB7484.namprd12.prod.outlook.com
 ([fe80::ac9f:a033:789b:d45e]) by MW4PR12MB7484.namprd12.prod.outlook.com
 ([fe80::ac9f:a033:789b:d45e%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 08:59:05 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: "Xu, HailinX" <hailinx.xu@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>,
 "benjamin.walker@intel.com" <benjamin.walker@intel.com>, David Christensen
 <drc@linux.vnet.ibm.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes
 <ian.stokes@intel.com>, Jerin Jacob <jerinj@marvell.com>, "Mcnamara, John"
 <john.mcnamara@intel.com>, Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin
 Traynor <ktraynor@redhat.com>, Luca Boccassi <bluca@debian.org>, Pei Zhang
 <pezhang@redhat.com>, "qian.q.xu@intel.com" <qian.q.xu@intel.com>, Raslan
 Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 "yuan.peng@intel.com" <yuan.peng@intel.com>, "zhaoyan.chen@intel.com"
 <zhaoyan.chen@intel.com>
Subject: RE: 23.11.6 patches review and test
Thread-Topic: 23.11.6 patches review and test
Thread-Index: AQHcf7xqN9ktUqPFgkWmF92WSgQ86bVUp58AgAYgzsCAAAzDgIAAAGTA
Date: Tue, 20 Jan 2026 08:59:05 +0000
Message-ID: <MW4PR12MB7484FD3C23624132D72751E6BF89A@MW4PR12MB7484.namprd12.prod.outlook.com>
References: <20260107100017.158232-1-shperetz@nvidia.com>
 <IA3PR11MB9040224D2707117312E2DBE89F8DA@IA3PR11MB9040.namprd11.prod.outlook.com>
 <MW4PR12MB7484C0F98C8D0DDFC2822CBBBF89A@MW4PR12MB7484.namprd12.prod.outlook.com>
 <IA3PR11MB9040606C2B1305D219B7D7769F89A@IA3PR11MB9040.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9040606C2B1305D219B7D7769F89A@IA3PR11MB9040.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB7484:EE_|SN7PR12MB7954:EE_
x-ms-office365-filtering-correlation-id: 4a964c20-33a8-4813-8e72-08de58022a06
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UkpWTlBiZ0JVRzZuNnJHRERZazNpSFVXWmx0SjVWaG5WbVRTZmdjdzV0N2F5?=
 =?utf-8?B?ejJyVHRGbWxEQnh4aVE4S3ZqQ0FLUGlPSTJTMUU1eGs0OWlwVC92QW1QOUFT?=
 =?utf-8?B?UXFuM1BnbmtkdHRSMzJOajBOMGsxd1YwQ3Y0dkxmVXUwRkJaWEx6dzU5WTEz?=
 =?utf-8?B?SkFnREYxWm43QWh3Z3IxWE9sbWRoVWsySWMyYWE5Z2wreHJtQTFPNUFYSitD?=
 =?utf-8?B?cnV0M0xSYmx3ejQzc21VeitDMDBCSVpYT2dMVmlSV1JkdkdyVEZzZVZucG1I?=
 =?utf-8?B?aktOdnkrUlBKK3RzY2JpMjhGSkg1MStLNm95SzBMRytpc3dpVXcyWDJNTUVM?=
 =?utf-8?B?VlREVWxQL3FyQ2k5WXZqbTh3SEZBaEF4SklKZHFFeFB5UitscHFIZFREdFB3?=
 =?utf-8?B?T3BLcktXV2cvdEwzMG9Sd2ZibHZmK1NIcUJGL0J1ajh2UEw2aGYyc2FvbE0w?=
 =?utf-8?B?YVpWUE1HQUJxNWg4UUN3cnNwamEzZDdwdWhPcC9FT3NlTklXbUdZWkhHQVBa?=
 =?utf-8?B?L25wbTdzcmRGaVJ2c2M1TStlQ2FobnhqU2gyTmU4OUlBM0syQ2Z1bEVpbThr?=
 =?utf-8?B?TXV6OXloM09mTy8wL2l4OXBlN1NWTDVCV2M4TDlRM1VwdHk4bXErcnFnbklV?=
 =?utf-8?B?cU1FMmVnY05sVUFlYmNNWktTZ1VGVnF3R2thd2tWaXpLN25qYUFtMFdORnFR?=
 =?utf-8?B?aFRINU54QlNmaEJBdEF6VTBsL1NMdU9TWDNtRFlVR3RtU3RwQjlLWGVrYU1V?=
 =?utf-8?B?aDhnWStrZzdVTHBHOUJIS0E0aGJnVU5tQTVadjFKZTM3eHFXY3dSaVMwcFNo?=
 =?utf-8?B?V3h1MS9ENnFDZkpxKzJHS2k5bE9yNFhMZVBrajhqakhuYnNCNkNudjBvcXp3?=
 =?utf-8?B?WFNwK1hrRXlkak95ams0aWJCa05tYXZYekVhS1JYMllXVjhKeXVpK2I4WXc4?=
 =?utf-8?B?Q2hXT3U4OFkwNzBMTTZiUnMwaXNYc2IxYmVGZjJCcHYwYjF0RlpBSndLcURi?=
 =?utf-8?B?d1JmaW5lUVFUSlZFQnF0RmRRMlpURjV6NGtqeXBUNUYybnZGSWRIR0NhTFYr?=
 =?utf-8?B?VE1ZajVQVENNQWFXRnJVc0Yza0dIdFJBZTdHekdYU2JsTzFIMUh0aEZZeDJN?=
 =?utf-8?B?eE9XaXhjQzBRejVkU05CU3gzR0x0YnJqOEp2dWNLVWhGanBPWWJQS1ppRGxN?=
 =?utf-8?B?ekxNWmQzamFNaWxEaEZEUkRwdWhsbVA0SWZCTGlsWElJZFl3U25MY054cllz?=
 =?utf-8?B?OWR4MEhTSkdnK3gwY3BlNW5keklaaTBtN1NxSTAveUd5S3pWZXVHNVZMdWhz?=
 =?utf-8?B?TmRSdmJHalUwY3NaRUxGcFNyeGFNWVV5MU1DRWpVN1dyNEdyOFl3c1NDVFRH?=
 =?utf-8?B?czlieFNHbVp1ZXIwM3JpOTNjTHJXWnlNejhNSm5jOXJyTXZGZnBXKzFkeWdR?=
 =?utf-8?B?L21HUUwvNDg1MTh3TG5CTEJCdmpzUEt5TnhYQno5NllWWE5zRWp6ZmNFVzBQ?=
 =?utf-8?B?Ni9BSTFIQTR2eW9vdFhGdlZaSE9HSEFjdUJ1MUs0Wm9CZEo4WDN4d1NiQS9o?=
 =?utf-8?B?ckxhWS9lTXdqcStKWjdKREluS1NvanJUWnhXV1YwVzFYb0FSZ1JuSXdjd0tB?=
 =?utf-8?B?MDVEdGxzTHkyWk9CTFBVMVdFQzNuYTNCN0RQU0V1M3oyMmo4dXFjSnZ1NVRK?=
 =?utf-8?B?bEkyekh2Qk9qRG01RlE2TSs0M3FuUmFpcXBqL2pHMUpxd1I4RDE4S3pmcWJK?=
 =?utf-8?B?WmpQTlpKbnU3L2plZGsvdTlwZnlZKzFTc0ErVmt0S0cyM2xNZ3VwYitGRTND?=
 =?utf-8?B?QkRaZU9jRnFUSVV6KzFSQ1cwMlFXdkZLbVNmNklTRE5aMlVpVWZGS05UeVFr?=
 =?utf-8?B?UklZaEdTZEFYSERiYzVRVm9mVXc2dkU2T1hhNWZScWlxS1dIdTBoTGoya1Rk?=
 =?utf-8?B?MFBXeWJ5WFYyOXkxNldhd050dm9QRzNjUzRZNUJBbzUzZHlvaVZHSlJPb2ZN?=
 =?utf-8?B?V0UwZTR1NE5hRGxDdkNGY2RBY1NHa09jbmJ3QkljK3lCUmY2RlBMNEx4bHFy?=
 =?utf-8?B?YkFtYkhUemtYSlRBU3FLUWNsSmtqaTk4Z1l1VHcwWnQ1ZGxnalFnZVlpVExr?=
 =?utf-8?B?MERxc0JVbGM0Ynh3RFlaQkphaUlLTTNQOFBleFMyYlNFdVgzMWhiZTlUSmhU?=
 =?utf-8?Q?eKTOnUyvI98pYLNdpZXE2yU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB7484.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek5xSWRmN3NlVW03MmNJcndkK1J3b3c0MTM5dUU2ODlnSkJIMW5sNGZmZEQ0?=
 =?utf-8?B?NXJUN250UzJ3Vk5ybGR0c1V1Y0x1UjRaNFdRR0ZSQ25FR0w3WE84UGh4a09C?=
 =?utf-8?B?ZEZNWWk0TDZKUmdBYkJmTDMzRFFZREt3ZW5nRGswN1JlOWhIOGpKRUZOcHJa?=
 =?utf-8?B?SjNsbk5lV2VweWZUL0V6SExQOTRKU2tFMkZLVDgxVW5oOHUxeHFMMGRuUGNs?=
 =?utf-8?B?YUlWWnozZ09jZGc1VlhydnZzczdHakZXVmN2ZHNsV2RqbXpITUNZanZXL2Vh?=
 =?utf-8?B?NlltQldWdzMwNXBtRXQ3eWpWMVhmQkRmZVFFbkRrcTdrcjdYNkpkRFZNZWp6?=
 =?utf-8?B?UFlmeGZDbTJHeWE4b2padlcvdmlRRVNkSGpwZ3pTK1FJRE1DNWZES2RETW1F?=
 =?utf-8?B?Y2krMm5aanhUTDljWno5TytRdlZ6SGJ4OGQ5Vy9ack1yeUhpd2pHR2RnMW1P?=
 =?utf-8?B?bEJIbU9pNVdvcmRzZVRHNDN1bVFJbGlqWU9oZ0xEOGNkTGJsVVcwajFYVFlm?=
 =?utf-8?B?T1hiaU51MXNFS2RGUU9zM1AvN3dCV0tqeVlKZEZxSlBkclo1L0pobEpBWEVl?=
 =?utf-8?B?RzJuS1ZFVGdsQUtzaURNaWM0UUk3NjdNWEx3TFZ6Z1VQNEYvUTZnWVhLWnFF?=
 =?utf-8?B?OFBYUy8zbCtuNERCWFJBUFNUUVZqalN0SG51UGd5TjE4bU0vS3U4dkJ4UlRZ?=
 =?utf-8?B?SkxFYXNlcUZQYkh2WHVUcHlURWloeTc3OTRHek9LdmRsN1hoeExaQ0JUOWg5?=
 =?utf-8?B?QVhzTW9STnVldWpkeFo2cEdGcERaUzdvOWUwVmJGN2YvMmhPREtJMEtRdkhT?=
 =?utf-8?B?Z3puOFlDb1VwRytUNWd5YVAzMmNLSjllQ0dTNGxrSUpqWElCRVc3S3l6SDQy?=
 =?utf-8?B?dmt5dGt6UlhXMFZOWnhtT0ZhMlNlVlBGa3BJMWFINzFPZXA1QzBOMVFjSHhO?=
 =?utf-8?B?ZVNPUmxWOHV4QTcxbE9YZGFRK01vVzZrTkxuUSs3OHlTTkFrc3c2eHM5Z3hr?=
 =?utf-8?B?cm9ITWFCOXlLZGdDWTBjL1dXci9RMTNzOHRBYjg4YTE3c2hCekdhMkhEQTR1?=
 =?utf-8?B?TmtRNWpwWjV5ZUhjZjVvNkpsc1ZOcGRIZ3ppdFFjUkVPZzUwWWQ5WGkvWDc3?=
 =?utf-8?B?U01HT3JVRjkzeWMvSm1IWUJCb3lGYksyRHYzMmJFRFF3NlgxSTRsOVRJMXlw?=
 =?utf-8?B?TW5zUWxndisvVldVVUJ4RnhHZHRIV3VKdUdJL0RqcTEreUdIbHV6cHJGeGls?=
 =?utf-8?B?M2M1N0gvc0FxUGZSMXpUYWhvMUJXd3YrU2NmSTNZR3pRbHdDTDcwSloyK1Bj?=
 =?utf-8?B?Ujk0dVdRTmkrcWRTT2p0Rm81ZVlMcERRL0ZVd05ldGNmSkplclhKeGY2Ums3?=
 =?utf-8?B?WkFaTEYxRWFPc0ZnNDRiVmEyQUhPL3FoS2VWQmIzUWZSSkU1dU4vbW9sOFkx?=
 =?utf-8?B?VWdlazdwSW1vM1RFdjRVWlZuN3pNN2lKTHJON1IxQ2hKV25Ld1BDNDlHdXdM?=
 =?utf-8?B?OG1zRS9YcCtwcnpZdTFkWEsrYWNWeUY4T05BSzFSem1jOHRMZGlUWTFrMjFn?=
 =?utf-8?B?b1VpaW9LZ1VIWFk3UlNxVFUzZ2FET05tU3JUV2VuWXZyWTVSQm1IRTZCTUtX?=
 =?utf-8?B?cVRqQWozWko3c2dNRWFJWmNqUDFtblVCYktMN21TT3M0SUJHcmo4c3pYUS8x?=
 =?utf-8?B?QXRjS2hOTDVyQ1Z4WE5GeSthbVBwVU1kVVVlenlqYjFFWW9aajh5bFlsZlpu?=
 =?utf-8?B?bDd5VzNCUDYyZityNE5CUXVMSlN5Y0x0SGZDOEIzOXdPUmJsZGRPNHFQbkp3?=
 =?utf-8?B?T01VbUZlVHhDSFIxRFlPb00wSlk5RTFLMGJzNWdqN1krVFdqWDJ6UGxKWnQ2?=
 =?utf-8?B?VG1nY0tnN3FGWFRFWFlIUVUzR0NRNnRvVnFXY3pUeDhmVVNmL3V6eE5EVisr?=
 =?utf-8?B?cHExdmM5Sk5RYnNLWkQvb3QxRXZQVjVYY3RMSGRYVmxqSnBEb0tscWtxczVR?=
 =?utf-8?B?emlzRzJsSDZvNllua1MreWdBRFgrYXRrcnBRN2x0djVuTWoyUnpFekppRGFG?=
 =?utf-8?B?ZFJKc01WVmRHTHdiRUdPS0NEMDZCc0dscFFMNW5tcGRJdFlOQUZOb0hwS2pH?=
 =?utf-8?B?R21lWnMvRVVWQmZOTTJ1RC9hVXlJUkVTWlhrS25pMm1SZkhmZzZlczU5bUM3?=
 =?utf-8?B?dENxQ2s0UUxaUGk1TUtDZWdTV1c3MjhLVjVrbjRwcVJFTFpBS3pKT1BWQU1i?=
 =?utf-8?B?M0NEaytFazgzcFNDV3pTSS9lNmowTEcxUkJsZTJDMGFra0ZUTW9COWFTYTZG?=
 =?utf-8?Q?X+ZN2/qNZgVzHEImPk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a964c20-33a8-4813-8e72-08de58022a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 08:59:05.1195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cbdfvkm6BA0bVzAKEpDG7NVnY71K+a8BnUaPle29kUth5b8g76GKHVEDFP1SNHa9nH9Dr2zkk0VroH88UnXr2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWHUsIEhhaWxpblggPGhh
aWxpbngueHVAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCAyMCBKYW51YXJ5IDIwMjYgMTA6
NTQNCj4gVG86IFNoYW5pIFBlcmV0eiA8c2hwZXJldHpAbnZpZGlhLmNvbT47IHN0YWJsZUBkcGRr
Lm9yZw0KPiBDYzogZGV2QGRwZGsub3JnOyBBYmhpc2hlayBNYXJhdGhlIDxBYmhpc2hlay5NYXJh
dGhlQG1pY3Jvc29mdC5jb20+Ow0KPiBBbGkgQWxudWJhbmkgPGFsaWFsbnVAbnZpZGlhLmNvbT47
IGJlbmphbWluLndhbGtlckBpbnRlbC5jb207IERhdmlkDQo+IENocmlzdGVuc2VuIDxkcmNAbGlu
dXgudm5ldC5pYm0uY29tPjsgSGVtYW50IEFncmF3YWwNCj4gPGhlbWFudC5hZ3Jhd2FsQG54cC5j
b20+OyBJYW4gU3Rva2VzIDxpYW4uc3Rva2VzQGludGVsLmNvbT47IEplcmluIEphY29iDQo+IDxq
ZXJpbmpAbWFydmVsbC5jb20+OyBNY25hbWFyYSwgSm9obiA8am9obi5tY25hbWFyYUBpbnRlbC5j
b20+OyBKdS0NCj4gSHlvdW5nIExlZSA8anVobGVlQG1pY3Jvc29mdC5jb20+OyBLZXZpbiBUcmF5
bm9yIDxrdHJheW5vckByZWRoYXQuY29tPjsNCj4gTHVjYSBCb2NjYXNzaSA8Ymx1Y2FAZGViaWFu
Lm9yZz47IFBlaSBaaGFuZyA8cGV6aGFuZ0ByZWRoYXQuY29tPjsNCj4gcWlhbi5xLnh1QGludGVs
LmNvbTsgUmFzbGFuIERhcmF3c2hlaCA8cmFzbGFuZEBudmlkaWEuY29tPjsgTkJVLQ0KPiBDb250
YWN0LVRob21hcyBNb25qYWxvbiAoRVhURVJOQUwpIDx0aG9tYXNAbW9uamFsb24ubmV0PjsgWWFu
Z2hhbmcNCj4gTGl1IDx5YW5naGxpdUByZWRoYXQuY29tPjsgeXVhbi5wZW5nQGludGVsLmNvbTsg
emhhb3lhbi5jaGVuQGludGVsLmNvbQ0KPiBTdWJqZWN0OiBSRTogMjMuMTEuNiBwYXRjaGVzIHJl
dmlldyBhbmQgdGVzdA0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcg
bGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gRnJvbTogU2hhbmkgUGVyZXR6IDxzaHBlcmV0ekBudmlkaWEuY29tPg0KPiA+IFNl
bnQ6IFR1ZXNkYXksIEphbnVhcnkgMjAsIDIwMjYgNDoxMiBQTQ0KPiA+IFRvOiBYdSwgSGFpbGlu
WCA8aGFpbGlueC54dUBpbnRlbC5jb20+OyBzdGFibGVAZHBkay5vcmcNCj4gPiBDYzogZGV2QGRw
ZGsub3JnOyBBYmhpc2hlayBNYXJhdGhlDQo+IDxBYmhpc2hlay5NYXJhdGhlQG1pY3Jvc29mdC5j
b20+Ow0KPiA+IEFsaSBBbG51YmFuaSA8YWxpYWxudUBudmlkaWEuY29tPjsgYmVuamFtaW4ud2Fs
a2VyQGludGVsLmNvbTsgRGF2aWQNCj4gPiBDaHJpc3RlbnNlbiA8ZHJjQGxpbnV4LnZuZXQuaWJt
LmNvbT47IEhlbWFudCBBZ3Jhd2FsDQo+ID4gPGhlbWFudC5hZ3Jhd2FsQG54cC5jb20+OyBJYW4g
U3Rva2VzIDxpYW4uc3Rva2VzQGludGVsLmNvbT47IEplcmluDQo+ID4gSmFjb2IgPGplcmluakBt
YXJ2ZWxsLmNvbT47IE1jbmFtYXJhLCBKb2huDQo+IDxqb2huLm1jbmFtYXJhQGludGVsLmNvbT47
DQo+ID4gSnUtIEh5b3VuZyBMZWUgPGp1aGxlZUBtaWNyb3NvZnQuY29tPjsgS2V2aW4gVHJheW5v
cg0KPiA+IDxrdHJheW5vckByZWRoYXQuY29tPjsgTHVjYSBCb2NjYXNzaSA8Ymx1Y2FAZGViaWFu
Lm9yZz47IFBlaSBaaGFuZw0KPiA+IDxwZXpoYW5nQHJlZGhhdC5jb20+OyBxaWFuLnEueHVAaW50
ZWwuY29tOyBSYXNsYW4gRGFyYXdzaGVoDQo+ID4gPHJhc2xhbmRAbnZpZGlhLmNvbT47IE5CVS0g
Q29udGFjdC1UaG9tYXMgTW9uamFsb24gKEVYVEVSTkFMKQ0KPiA+IDx0aG9tYXNAbW9uamFsb24u
bmV0PjsgWWFuZ2hhbmcgTGl1IDx5YW5naGxpdUByZWRoYXQuY29tPjsNCj4gPiB5dWFuLnBlbmdA
aW50ZWwuY29tOyB6aGFveWFuLmNoZW5AaW50ZWwuY29tDQo+ID4gU3ViamVjdDogUkU6IDIzLjEx
LjYgcGF0Y2hlcyByZXZpZXcgYW5kIHRlc3QNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBYdSwgSGFpbGluWCA8aGFpbGlueC54dUBp
bnRlbC5jb20+DQo+ID4gPiBTZW50OiBGcmlkYXksIDE2IEphbnVhcnkgMjAyNiAxMjozMw0KPiA+
ID4gVG86IFNoYW5pIFBlcmV0eiA8c2hwZXJldHpAbnZpZGlhLmNvbT47IHN0YWJsZUBkcGRrLm9y
Zw0KPiA+ID4gQ2M6IGRldkBkcGRrLm9yZzsgQWJoaXNoZWsgTWFyYXRoZQ0KPiA+IDxBYmhpc2hl
ay5NYXJhdGhlQG1pY3Jvc29mdC5jb20+Ow0KPiA+ID4gQWxpIEFsbnViYW5pIDxhbGlhbG51QG52
aWRpYS5jb20+OyBiZW5qYW1pbi53YWxrZXJAaW50ZWwuY29tOyBEYXZpZA0KPiA+ID4gQ2hyaXN0
ZW5zZW4gPGRyY0BsaW51eC52bmV0LmlibS5jb20+OyBIZW1hbnQgQWdyYXdhbA0KPiA+ID4gPGhl
bWFudC5hZ3Jhd2FsQG54cC5jb20+OyBJYW4gU3Rva2VzIDxpYW4uc3Rva2VzQGludGVsLmNvbT47
IEplcmluDQo+ID4gPiBKYWNvYiA8amVyaW5qQG1hcnZlbGwuY29tPjsgTWNuYW1hcmEsIEpvaG4N
Cj4gPiA8am9obi5tY25hbWFyYUBpbnRlbC5jb20+Ow0KPiA+ID4gSnUtIEh5b3VuZyBMZWUgPGp1
aGxlZUBtaWNyb3NvZnQuY29tPjsgS2V2aW4gVHJheW5vcg0KPiA+ID4gPGt0cmF5bm9yQHJlZGhh
dC5jb20+OyBMdWNhIEJvY2Nhc3NpIDxibHVjYUBkZWJpYW4ub3JnPjsgUGVpIFpoYW5nDQo+ID4g
PiA8cGV6aGFuZ0ByZWRoYXQuY29tPjsgcWlhbi5xLnh1QGludGVsLmNvbTsgUmFzbGFuIERhcmF3
c2hlaA0KPiA+ID4gPHJhc2xhbmRAbnZpZGlhLmNvbT47IE5CVS0gQ29udGFjdC1UaG9tYXMgTW9u
amFsb24gKEVYVEVSTkFMKQ0KPiA+ID4gPHRob21hc0Btb25qYWxvbi5uZXQ+OyBZYW5naGFuZyBM
aXUgPHlhbmdobGl1QHJlZGhhdC5jb20+Ow0KPiA+ID4geXVhbi5wZW5nQGludGVsLmNvbTsgemhh
b3lhbi5jaGVuQGludGVsLmNvbQ0KPiA+ID4gU3ViamVjdDogUkU6IDIzLjExLjYgcGF0Y2hlcyBy
ZXZpZXcgYW5kIHRlc3QNCj4gPiA+DQo+ID4gPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24g
b3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiA+ID4NCj4gPiA+DQo+ID4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IFNoYW5pIFBlcmV0eiA8c2hwZXJl
dHpAbnZpZGlhLmNvbT4NCj4gPiA+ID4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDcsIDIwMjYg
NjowMCBQTQ0KPiA+ID4gPiBUbzogc3RhYmxlQGRwZGsub3JnDQo+ID4gPiA+IENjOiBkZXZAZHBk
ay5vcmc7IEFiaGlzaGVrIE1hcmF0aGUNCj4gPiA+IDxBYmhpc2hlay5NYXJhdGhlQG1pY3Jvc29m
dC5jb20+Ow0KPiA+ID4gPiBBbGkgQWxudWJhbmkgPGFsaWFsbnVAbnZpZGlhLmNvbT47IGJlbmph
bWluLndhbGtlckBpbnRlbC5jb207DQo+ID4gPiA+IERhdmlkIENocmlzdGVuc2VuIDxkcmNAbGlu
dXgudm5ldC5pYm0uY29tPjsgSGVtYW50IEFncmF3YWwNCj4gPiA+ID4gPGhlbWFudC5hZ3Jhd2Fs
QG54cC5jb20+OyBJYW4gU3Rva2VzIDxpYW4uc3Rva2VzQGludGVsLmNvbT47IEplcmluDQo+ID4g
PiA+IEphY29iIDxqZXJpbmpAbWFydmVsbC5jb20+OyBNY25hbWFyYSwgSm9obg0KPiA+ID4gPGpv
aG4ubWNuYW1hcmFAaW50ZWwuY29tPjsNCj4gPiA+ID4gSnUtIEh5b3VuZyBMZWUgPGp1aGxlZUBt
aWNyb3NvZnQuY29tPjsgS2V2aW4gVHJheW5vcg0KPiA+ID4gPiA8a3RyYXlub3JAcmVkaGF0LmNv
bT47IEx1Y2EgQm9jY2Fzc2kgPGJsdWNhQGRlYmlhbi5vcmc+OyBQZWkgWmhhbmcNCj4gPiA+ID4g
PHBlemhhbmdAcmVkaGF0LmNvbT47IHFpYW4ucS54dUBpbnRlbC5jb207IFJhc2xhbiBEYXJhd3No
ZWgNCj4gPiA+ID4gPHJhc2xhbmRAbnZpZGlhLmNvbT47IFRob21hcyBNb25qYWxvbiA8dGhvbWFz
QG1vbmphbG9uLm5ldD47DQo+ID4gPiBZYW5naGFuZw0KPiA+ID4gPiBMaXUgPHlhbmdobGl1QHJl
ZGhhdC5jb20+OyB5dWFuLnBlbmdAaW50ZWwuY29tOw0KPiA+ID4gemhhb3lhbi5jaGVuQGludGVs
LmNvbQ0KPiA+ID4gPiBTdWJqZWN0OiAyMy4xMS42IHBhdGNoZXMgcmV2aWV3IGFuZCB0ZXN0DQo+
ID4gPiA+DQo+ID4gPiA+IEhpIGFsbCwNCj4gPiA+ID4NCj4gPiA+ID4gSGVyZSBpcyBhIGxpc3Qg
b2YgcGF0Y2hlcyB0YXJnZXRlZCBmb3Igc3RhYmxlIHJlbGVhc2UgMjMuMTEuNi4NCj4gPiA+ID4N
Cj4gPiA+ID4gVGhlIHBsYW5uZWQgZGF0ZSBmb3IgdGhlIGZpbmFsIHJlbGVhc2UgaXMgSmFudWFy
eSAyMnRoLg0KPiA+ID4gPg0KPiA+ID4gPiBQbGVhc2UgaGVscCB3aXRoIHRlc3RpbmcgYW5kIHZh
bGlkYXRpb24gb2YgeW91ciB1c2UgY2FzZXMgYW5kDQo+ID4gPiA+IHJlcG9ydCBhbnkgaXNzdWVz
L3Jlc3VsdHMgd2l0aCByZXBseS1hbGwgdG8gdGhpcyBtYWlsLiBGb3IgdGhlDQo+ID4gPiA+IGZp
bmFsIHJlbGVhc2UgdGhlIGZpeGVzIGFuZCByZXBvcnRlZCB2YWxpZGF0aW9ucyB3aWxsIGJlIGFk
ZGVkIHRvDQo+ID4gPiA+IHRoZSByZWxlYXNlDQo+ID4gbm90ZXMuDQo+ID4gPiA+DQo+ID4gPiA+
IEEgcmVsZWFzZSBjYW5kaWRhdGUgdGFyYmFsbCBjYW4gYmUgZm91bmQgYXQ6DQo+ID4gPiA+DQo+
ID4gPiA+ICAgICBodHRwczovL2RwZGsub3JnL2Jyb3dzZS9kcGRrLXN0YWJsZS90YWcvP2lkPXYy
My4xMS42LXJjMQ0KPiA+ID4gPg0KPiA+ID4gPiBUaGVzZSBwYXRjaGVzIGFyZSBsb2NhdGVkIGF0
IGJyYW5jaCAyMy4xMSBvZiBkcGRrLXN0YWJsZSByZXBvOg0KPiA+ID4gPiAgICAgaHR0cHM6Ly9k
cGRrLm9yZy9icm93c2UvZHBkay1zdGFibGUvDQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rcy4NCj4g
PiA+ID4NCj4gPiA+ID4gU2hhbmkNCj4gPiA+ID4NCj4gPiA+ID4gLS0tDQo+ID4gPiBVcGRhdGUg
dGhlIHRlc3Qgc3RhdHVzIGZvciBJbnRlbCBwYXJ0LiBkcGRrMjMuMTEuNi1yYzEgYWxsDQo+ID4g
PiB2YWxpZGF0aW9uIHRlc3QNCj4gPiBkb25lLg0KPiA+ID4gZm91bmQgMSBuZXcgaXNzdWUuDQo+
ID4gPg0KPiA+ID4gdW5pdF90ZXN0c19jcnlwdG9kZXZfZnVuYy9jcnlwdG9kZXZfcWF0X3Jhd19h
cGlfYXV0b3Rlc3Q6IEFFUyBHQ00NCj4gPiA+IEF1dGhlbnRpY2F0ZWQgVGVzdCBTdWl0ZSB0ZXN0
IGZhaWxpbmcgIC0tIGhhcyBmaXggcGF0Y2ggZml4IHBhdGNoOg0KPiA+ID4gaHR0cHM6Ly9tYWls
cy5kcGRrLm9yZy9hcmNoaXZlcy9zdGFibGUvMjAyNi1KYW51YXJ5LzA1NTU0Ni5odG1sDQo+ID4g
Pg0KPiA+DQo+ID4gRml4IHdhcyBhZGRlZCB0byAyMy4xMSwgY291bGQgeW91IGNoZWNrIGlmIHlv
dXIgdGVzdHMgYXJlIHBhc3Npbmcgd2l0aA0KPiA+IHRoZSBuZXcgcGF0Y2g/IGh0dHBzOi8vZ2l0
aHViLmNvbS9EUERLL2RwZGstc3RhYmxlL3RyZWUvMjMuMTENCj4gPg0KPiBXZSBoYXZlIGNvbmR1
Y3RlZCB0aGUgbGF0ZXN0IGNvbW1pdCB0ZXN0IGFuZCB0aGUgaXNzdWUgaGFzIGJlZW4gcmVzb2x2
ZWQuDQo+IA0KDQpHcmVhdCB0aGFua3MgZm9yIHRoZSBxdWljayB0ZXN0aW5nIQ0KDQo+ID4gPiAq
IEJ1aWxkICYgQ0ZMQUcgY29tcGlsZTogY292ZXIgdGhlIGJ1aWxkIHRlc3Qgd2l0aCBsYXRlc3Qg
R0NDL0NsYW5nDQo+ID4gPiB2ZXJzaW9uIG9uIHRoZSBmb2xsb3dpbmcgT1MoYWxsIHBhc3NlZCkN
Cj4gPiA+ICAgLSBVYnVudHUyNS4wNC9VYnVudHUyNC4wNC4yDQo+ID4gPiAgIC0gUkhFTDkuNi9S
SEVMMTANCj4gPiA+ICAgLSBGZWRvcmE0Mg0KPiA+ID4gICAtIEZyZWVCU0QxNC4yDQo+ID4gPiAg
IC0gU1VTRTE1LjYNCj4gPiA+ICAgLSBPcGVuQW5vbGlzOC4xMA0KPiA+ID4gICAtIEF6dXJlTGlu
dXgzLjANCj4gPiA+DQo+ID4gPiAqIEZ1bmN0aW9uIHRlc3RzOiBmb3VuZCAxIG5ldyBpc3N1ZS4N
Cj4gPiA+ICAgLSBpNDBFLShYWFY3MTAsIFg3MjIpIFBGL1ZGOiB0ZXN0IHNjZW5hcmlvcyBpbmNs
dWRpbmcNCj4gPiA+IGJhc2ljL1JURV9GTE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtDQo+ID4g
PiBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4NCj4gPiA+ICAgLSBJWEdC
RS0oODI1OTkpIFBGL1ZGOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcNCj4gPiA+IGJhc2ljL1JU
RV9GTE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtDQo+ID4gPiBvZmZsb2FkL21hY19maWx0ZXIv
VkxBTi9WWExBTi9SU1MsIGV0Yy4NCj4gPiA+ICAgLSBJQ0UtKEU4MTAsIEUyMTAwKSBQRi9WRjog
dGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nDQo+ID4gPiBiYXNpYy9Td2l0Y2gvUGFja2FnZSBNYW5h
Z2VtZW50L0Zsb3cgRGlyZWN0b3IvQWR2YW5jZWQgVHgvQWR2YW5jZWQNCj4gPiA+IFJTUy9BQ0wv
RENGL0ZsZXhpYmxlIERlc2NyaXB0b3IsIGV0Yy4NCj4gPiA+ICAgLSBJUHNlYzogdGVzdCBzY2Vu
YXJpb3MgaW5jbHVkaW5nIGlwc2VjL2lwc2VjLWd3L2lwc2VjIGxpYnJhcnkNCj4gPiA+IGJhc2lj
IHRlc3QgLSBRQVQmU1cvRklCIGxpYnJhcnksIGV0Yy4NCj4gPiA+ICAgLSBWaXJ0aW86IGJvdGgg
ZnVuY3Rpb24gYW5kIHBlcmZvcm1hbmNlIHRlc3QgYXJlIGNvdmVyZWQuIFN1Y2ggYXMNCj4gPiA+
IFBWUC9WaXJ0aW9fbG9vcGJhY2svdmlydGlvLXVzZXIgbG9vcGJhY2svdmlydGlvLW5ldCBWTTJW
TSBwZXJmDQo+ID4gPiB0ZXN0aW5nL1ZNQVdBUkUgRVNYSSA4LjAsIGV0Yy4NCj4gPiA+ICAgLSBD
cnlwdG9kZXY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBDcnlwdG9kZXYgQVBJDQo+ID4gPiB0
ZXN0aW5nL0NvbXByZXNzRGV2IElTQS1ML1FBVC9aTElCIFBNRCBUZXN0aW5nL0ZJUFMsIGV0Yy4N
Cj4gPiA+ICAgLSBETEI6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBETEIyLjAgYW5kIERMQjIu
NQ0KPiA+ID4gICAtIE90aGVyOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgQUZfWERQLCBQb3dl
ciwgQ0JETUEsIERTQQ0KPiA+ID4NCj4gPiA+ICogUGVyZm9ybWFuY2UgdGVzdDogQWxsIHRlc3Qg
ZG9uZSBhbmQgcGFzc2VkDQo+ID4gPiAgIC0gVGhvdWdocHV0IFBlcmZvcm1hbmNlDQo+ID4gPiAg
IC0gQ3J5cHRvZGV2IExhdGVuY3kNCj4gPiA+ICAgLSBQRi9WRiBOSUMgc2luZ2xlIGNvcmUNCj4g
PiA+ICAgLSBYWFY3MTAvRTgxMCBOSUMgUGVyZm9ybWFuY2UNCj4gPiA+DQo+ID4gPg0KPiA+ID4g
UmVnYXJkcywNCj4gPiA+IFh1LCBIYWlsaW4NCj4gPg0KPiA+IFRoYXQncyBncmVhdCwgdGhhbmsg
eW91IQ0KPiANCj4gUmVnYXJkcywNCj4gWHUsIEhhaWxpbg0K
