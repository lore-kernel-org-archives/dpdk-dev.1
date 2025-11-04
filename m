Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CCBCCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 11:53:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 921D44028C;
	Tue,  4 Nov 2025 12:53:19 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D59F940285
 for <dev@dpdk.org>; Tue,  4 Nov 2025 12:53:17 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A3NXDJK1519495; Tue, 4 Nov 2025 03:53:17 -0800
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023112.outbound.protection.outlook.com
 [40.93.196.112])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a765rssw5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Nov 2025 03:53:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdCz1+t4M8dKdUcaejEJ3zVJIgP6hzIbxOiNZ7AXpDEQCalXLEKLO7PkxcEMPVvAptkAcPsREoPN39svTv0gDnKJj9lZm60m90Exmv3oavWJ9RnQVVbjT3UFBtOgxBpdp6I3fPZ+UmZS0wQWeTpDBUp6ZPMpAU6580I//TvUn/p8kb7ez6Zyju+PLaFSKFBY3h08K5dOFYqSzai5sJSO8KPBz845ryyfsUN8NvlFpUk7DytmbST7M6n1DTA16p0cf/WmXSTvqCPIP9B6vevv+mY/i3SJTHwfchtXVCj4GRysTUl6CHaF6RjTausoGDAVHfU6Y4Mq3Q6KTr0HNfe3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7ShTtRN68bNJ/OgH7/cvijcDjoOSSnyXq6zxLiL3rA=;
 b=eELy3IEojcYZlGWiTXV1zQ3aEtgXY7ZI5LZOqf0CvDsba/x5Jnc1jcTTiFq87XmX2ASLhnd7yifhOdFTMjCC++xH+IRnrpmy796Hjuiyrj44DbzYFEPpO5IgpeKTuDxIpNCacxncKDpS+XT4FEXAWuR97bpnMoG5Fzny6NZUA32d0Lpn7llQ0mA6H/isBklR/6ERp9kDF69ZFRSIySsouD/fIk0iXa9sP1sHVRwjTbvY2hpEs58n8pK0bDw51JUZqzAWmerPut7g77+V0EeQCAjZreLRD6v+afPsbM8Fqz8YLZI1Yrzx1kZ874nEUy4gusH465UWZdo2lOB43+8YQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7ShTtRN68bNJ/OgH7/cvijcDjoOSSnyXq6zxLiL3rA=;
 b=rPZov2dP6RausIQxdwCpAHv7lnq0oJYsyiV8lcpVeeN92VTOa1w/WczoHxrxFf4D+fJV95vQK342nKk+RkL1l/QpXZz3dzeeHTvoEgga1cWDdBlK6hGWM6NJ0SQIrsaF/ul3csvr/psnxwe0fGF+byxgfEXk2APrCa4tGmlFDfg=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by SJ4PPFDD7D23EC9.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 11:53:12 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 11:53:12 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: "thomas@monjalon.net" <thomas@monjalon.net>
CC: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/1] dmadev: add domain_id field to
 access group join API
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/1] dmadev: add domain_id field to
 access group join API
Thread-Index: AQHcTUrynxF35tI7+ECxv3lyRnnSL7TiB4gAgABgSSA=
Date: Tue, 4 Nov 2025 11:53:11 +0000
Message-ID: <SJ4PPFEA6F74CA2B7003D5DB686710FC3F6A6C4A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20251103102946.2204883-1-vattunuru@marvell.com>
 <20251104052146.2308361-1-vattunuru@marvell.com>
 <793529f0-959b-4d72-a4de-5b06497a7c5e@huawei.com>
In-Reply-To: <793529f0-959b-4d72-a4de-5b06497a7c5e@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|SJ4PPFDD7D23EC9:EE_
x-ms-office365-filtering-correlation-id: 4ab31fca-f58a-4e4b-f20a-08de1b98bb1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?NGhQQ01EWGllbWFBOG5hNWh1VDhDTnhJRHZnZ0FtS0FaUWZXU2gxSmNzQ1Rm?=
 =?utf-8?B?VmhidmlOUWlDc3gzNFYyOUl1Yi9rWmdyYUFqWjdEMzYwN01OejFyYXdTQy9E?=
 =?utf-8?B?aGJOd2JSeFRGallKUThqTERXOFVESGhEeWFidGwyQzdERFl3T0ZvMjJYMUxF?=
 =?utf-8?B?VVFiM2xyTlhUaU5EbnArQ1V2dVY3QWtJeHRaVTB3Wk9BeVVvR3lWZE9LMnNl?=
 =?utf-8?B?TCtqTnprb1FIT2hYRytPc2gvN2lpcTdobW1CU3N5blphZ24yQ2kvNXp3VGFN?=
 =?utf-8?B?bmwrbzFvRDlRR2dPcVpUaW5FK3QyUUVIOWhPY2h1RDU5OCtnRElCS3htR2hl?=
 =?utf-8?B?TTBJK2dzV25rWTJWanM3eXdCMjF3MDhWOXRGbDlBUUdiNjM4aXpoOHhuYkd0?=
 =?utf-8?B?QzlJYTNLV1QrbzJib2t1ME5iU09mSFdEVXRORHJVMi9qdkx4OFBzdy9SbE5q?=
 =?utf-8?B?SFgxbkY5UEVGbnRTZTlXNk9RM0pNUkY5TGF1bnVEek92SUdPSmdhSFNNYmFk?=
 =?utf-8?B?TWRBeXQrT01EczdyZEF0RnIxaitWM054dW9NK2xXZW5kbVhudTdKbFdwVkVV?=
 =?utf-8?B?M0h2UXJHWDdqTTNxZTFqbXB6ZER0UEw4TWVhY1VBazNXcUthNWZIQWphY3R6?=
 =?utf-8?B?Um9DcG5PUlovTWlpVGtmcjVWTVJuZHQwcEtpN1NndDRhWjNxN3pJWDlLOWRR?=
 =?utf-8?B?S0ZSMi9QUlU2bkhVYjBNcWN3amZPTEQ0YjkwTGVQZHJsaFFSeXRBbTVHc2hE?=
 =?utf-8?B?UGJwSkZhS0hEOU44T1ZZK0VJMXkrWm5FbjFTMTFvUWNwNThqYmF5VThkcVVG?=
 =?utf-8?B?dlNqOFRBRU1KK29pUnNtK0tKMkw5KzBkalhGR0dOUmNjRHllSTlla3pFUzc3?=
 =?utf-8?B?ek5mZTQ4RytSai9zMHh5Z3VDWHZXSmQyRkg0bEd2YzF3UlJBM3phd1ZGZ2RP?=
 =?utf-8?B?OERmVFBPdXdOL09ERVBRVzByekNiL08wV2xrNXk3bmNpYzY4UHZ4aGxmRk1C?=
 =?utf-8?B?ampyVXhwRm9wcG1tYzZxbnJPRG1Va3RNVlBVZEhNbTdDd2hFbGwxa0NDM25R?=
 =?utf-8?B?UllBY3dGc1U0T09URlRvR3RscjVyeU5EQ2duU0dNdWlzOWZXSHdzMkt4S1BN?=
 =?utf-8?B?R1laUno0MU0vMFpNNjd1VTBSUituMTV6UU4vdWMwZVBsZ3BEOGh6cGNIVjVk?=
 =?utf-8?B?UlNWSnd3aFNjQld2OXBtS28xVlN3aDlFWnVNRE1NZFZ6QUd2SUpsTGhya0tr?=
 =?utf-8?B?eTI4b2M5bFdtZVdmaGI2Y2Mzdmx3Ykk5Y2MrallKQ1d1ZHZhRnBXNmU2cWtE?=
 =?utf-8?B?Y3NQMUN2OVpxdWdCbXcrTXgwc0NEMzBjUExPWDlGa0ZiTERqUjFrYVh0TzRN?=
 =?utf-8?B?dndCK2Q5d3N0RFlsSmRnRGVkemVVU3RLZXEwL3E0c3NFMEV3eUdaQzNWeUty?=
 =?utf-8?B?akZmSWN2c1R6Rjl2UG1UTDZGaEpuQUlFNzZ3QjdBQjFoTGh1c0xPZmgzelV2?=
 =?utf-8?B?Njh5RlNITXpRcWQzYmIwQW8rOGtoMzBQeWxTT1gyWllSTHF3K0NhRzRCd2Zo?=
 =?utf-8?B?TEpzMjFCeFc0cGN4YlBVdDZ5ejdPZ2hJWFhRQzhkenBKS1ZrL1EzT2kzeC9w?=
 =?utf-8?B?d0lHQklLaDc5OUVTV2dFLzFpNmhEWkdWV29ZQXRDNkFNQ1ltTTFNS2lLUUNo?=
 =?utf-8?B?MnNJVUtPUlVxS0JNRitJdVpzQ2dNNERocTZjZmtWUkJVLzh5QUJMYzYvcHNE?=
 =?utf-8?B?bFl4UDdwK0VZRnBBS1Z6eEY4eTRQNWc5SVpOdm53emtxdEM0cEhteVdEd2FW?=
 =?utf-8?B?bTlGNkVTM0lYUjlyRWFIM2ZzV1Vhbmowa3VIamNsS0hBclF6c0JaZEoxV21w?=
 =?utf-8?B?Z1h4NStQbzBSeDY3MkxtUnhSRWIxM0FXREI1cDhrOElMUlJzOVF6MzU2MDE2?=
 =?utf-8?B?aUdBWm10OTdNUkptaUdXZzRmZlZnbm5JZ0hzVC85UVpCcW5WcEJpS3padnBz?=
 =?utf-8?B?SGErdW8rRC9RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wjc0emNTcm1xcHJrWmFES1JhY1crWndRYVdYeTRCN0VKT2U0bVdiVFVKTGxw?=
 =?utf-8?B?cFFzbm53R04yZnZxb3hMcVVnN0ZjclMwTERwUEFJV0p3V1FNUGJhcHpHcWsz?=
 =?utf-8?B?d2JUTUxTZ01jc2JzQ0ROeEs3Kys0ZTNCMjhHM05Yd1dJa21WWWl1ZGZweHY0?=
 =?utf-8?B?L2M2OHpXN3B5NXhMSlhmOXoyL0ttUjBDcDB0dFV2QmE0U0JlNDJnOTdyUEVn?=
 =?utf-8?B?ckVFekVvcW5aeGlLejNiSy9SNGFBVlZ3aXdJS3JNd0RZMkRBdStOMXRLWGEz?=
 =?utf-8?B?RTRaR3pFRVJnY2hSK3pFd1oxMDBEZzQwc2U2WTU4a29ZZktnRU41Z2REWDJI?=
 =?utf-8?B?TE9wa1RQMFFBWkFFaU1FZUZBV3JJa3NDeWlqRStkUStIejd2Sm1XczZtMllJ?=
 =?utf-8?B?S3FnSXZkb2ZnNHNYWUE2a0hZSS9uTGNlNkJsVTcrOFZrcS8wbmdMOVUzYlFL?=
 =?utf-8?B?Y0hIdHFLNFVVTW82aFpnU1MvK2c3K0IzRUk5c25IbFpUeTRabTJiL050S2tU?=
 =?utf-8?B?eno0aU1yelhXWEhiYktqSENMSWhpbFZnTmlHNW1vY3VZdGxnR0piUk9STEZx?=
 =?utf-8?B?UmQzN1ZyWmFuMmhteUUva3UvWVFtTitXNUVOcElIc0lIVEpORjFOcG5UQ2lt?=
 =?utf-8?B?TFRKMGRPcDFYdE5JUWlObFp2Q093Ky9SZDQ1aE84MFJkTklIaXQ5WDcvTEtn?=
 =?utf-8?B?VlpJekxUMGpGTTFEUjVxSHl2c2NsS210MjczY2F4REs4UjBQRWV2Uk44Mkcv?=
 =?utf-8?B?YUttWGZOckxlVmtkSy9SQmVJQTJJMWRMUFMzTXFqOHFJNXZOQndYb3RZc3JJ?=
 =?utf-8?B?aVp2N1FzZjk4SGptQWtTeE1odDFQMTFMY0ViZlpxWDBxRFd5Ulk0OXQ5cnVK?=
 =?utf-8?B?Q2RMNjZpNFpwa2h5bnFmS2FwU2FsSGh6SkgzaW1NRE45WUUzbVQvem1yYXBs?=
 =?utf-8?B?S1hDQzFoUU9ObUtmQXUxS0V0RkowbUw1U0hPc1NiN2RsSXN0ZDJ5d09OODdC?=
 =?utf-8?B?UXFXVFdNTEtaeGNwRjEwR3JSYk9Zd3EvNVRpOUtYTlFBOVp4ZWFKNFhGSCtm?=
 =?utf-8?B?UmxLSm5pSi9kSi9UTmkvbVpvZkNVMUFaN0V3ZE9WYmVVZmMvc09zZnVjMThh?=
 =?utf-8?B?MlljaVB2ckl0czRiMDNRWk5heWYwVEVoQ0l4NGh6OFEvK3Y1b2tHbnAwbGNR?=
 =?utf-8?B?UEhZSmZVeEs2TVIxd0FQMVpsMVU3ZVZZL0J5TkU3Znpndzg3SGY1dVJrZ0xh?=
 =?utf-8?B?NVlqbnplam9hQjdvMXhhYzlxUU50SmJEbmp4TUhQQ2J0QUlnVjNUTTlPVW5I?=
 =?utf-8?B?bWt5WVJwcjQ1QW5pTVVaeDd1RDUyalZHYjFqaUZpMVUvN2g4c3B5M2s5M2pG?=
 =?utf-8?B?Uk9VQ0ZTWjNYaFBDaTM4NTMyR0hIc2pISGdwOHcrMVhhVmRocE5lcFk3Z0FB?=
 =?utf-8?B?eW9SYURLZDNuSlR3Rlg0OFk3eVF2YkdiYUdLcUZiUjEzUzUzZGh2ZjNuZXQ3?=
 =?utf-8?B?MmRZWVBRREpwOXNlQ1hxeG1rUEZvcE04K1N1TWdSeXFqTUNYNEVJdm5vNnhD?=
 =?utf-8?B?MDR5eWR5R0Z0VjBwQlJoMFpLdjBleGxucHZZWFptbzRjV2FUWWxIU1FPTWVs?=
 =?utf-8?B?VWIwRVMxbFhNNHRGb3JMbmpLY3dCZ0crZ1FOY2s4RDFnay9lbDRyWVJERHA5?=
 =?utf-8?B?MFVDUktoa1g0d0RLYStWVU8wM045MWN5MlBabC9uTi9pWmFwTXRGald1MXA1?=
 =?utf-8?B?SnJYTVRQZzV2OFFNQThFT2RSU3B5aExGa0RWRVd0bkxGeDhDVTJiVzNJdmtJ?=
 =?utf-8?B?MmhpYzBQdDg3WTNmcG1wb1k2bDFrWUVNa3ArR3hFbUx6VXBqMG5LVFRtRWhK?=
 =?utf-8?B?ZGxLYVhnRjB3MDR1anNoTmc2a09IVVo5UG85V095R1NWVDBza2JUY0JQVTla?=
 =?utf-8?B?NEIrQWJNMG9DdWpkdzV3bHh3WkJCSFVqN3FGbEluaVFJLzh0MHBZb1FTaW5j?=
 =?utf-8?B?U3lwODg1b0FpQThLcmZJV2ZJekt1SEdTcnR0RGplL2wxRjdpZ1htNDZRZUxE?=
 =?utf-8?B?RWJCdVZRZ0pCNFNpcFpSQ01ueHJEOXhWc21tZ2JGSkFTU3UxOGx2Ni8vaHMr?=
 =?utf-8?Q?Q/xQoPHO/SJJwDHRWmUShQ8GA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab31fca-f58a-4e4b-f20a-08de1b98bb1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 11:53:12.0981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2g8AdbJu6Bofc/YneTgN3x4yYzbmQcRe1LyjkjoGKOMF7h0yGq9cQdLxRC1Z1la1bG/kXa0bmaDpQnIJ1F/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFDD7D23EC9
X-Proofpoint-ORIG-GUID: 9SSIohby2MgKQUeTKoHe2hjBMh5inqj4
X-Proofpoint-GUID: 9SSIohby2MgKQUeTKoHe2hjBMh5inqj4
X-Authority-Analysis: v=2.4 cv=P4Q3RyAu c=1 sm=1 tr=0 ts=6909e92c cx=c_pps
 a=dWZueVx2hxoXd+HKFvf0WQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=bt5KbKNvAAAA:8
 a=RpNjiQI2AAAA:8 a=8DBoWsUVRxSZ2RgaTJYA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA5NyBTYWx0ZWRfXzq0czdm7gXzY
 e4h/p6UTuwlunkJhml4MZARyIt0v6ZxKDbbAXRLd4Fnn+GdY8FOKZAcn9gcUvXQAufZ+7MFE0So
 o+XR4cAG50pBlIV25zcFSG2Gwyxs5mMIO6UzI1Ki+FwLg5P6PFOfc2D5I5j6BRQdpTX6NHrtgjc
 syFSYBsFEsVx9hgfwhCyU1kQVCb2e4KLLK4Wy/si6ezNPvV+LO0bzBhTA2wj2ABqEvf8P3Ag4av
 fQnn/caRbEOUHT6otBG9O1i8voDbEwKvf7Opos1vFhMEGXuOPrKIZG2OKuRp9yIY1ubKNYpedCX
 Rg0HmGLO0iox/AGv5XDGNXPqE8Pa3R6P8HRJLKmfr5l+kKsqLcCjG/Gt2zBw9hHC0D0zDgy9b1M
 6jiCrgieXSP0LCG++QAUB2F3LAPo+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
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

SGkgVGhvbWFzLA0KDQpHZW50bGUgcGluZyBmb3IgbWVyZ2UuDQoNClJlZ2FyZHMNClZhbXNpDQo+
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBmZW5nY2hlbmd3ZW4gPGZlbmdjaGVu
Z3dlbkBodWF3ZWkuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDQsIDIwMjUgMTE6MzYg
QU0NCj5UbzogVmFtc2kgS3Jpc2huYSBBdHR1bnVydSA8dmF0dHVudXJ1QG1hcnZlbGwuY29tPjsg
ZGV2QGRwZGsub3JnDQo+Q2M6IHRob21hc0Btb25qYWxvbi5uZXQNCj5TdWJqZWN0OiBbRVhURVJO
QUxdIFJlOiBbUEFUQ0ggdjIgMS8xXSBkbWFkZXY6IGFkZCBkb21haW5faWQgZmllbGQgdG8NCj5h
Y2Nlc3MgZ3JvdXAgam9pbiBBUEkNCj4NCj5TaWduZWQtb2ZmLWJ5OiBDaGVuZ3dlbiBGZW5nIDxm
ZW5nY2hlbmd3ZW5A4oCKaHVhd2VpLuKAimNvbT4gT24NCj4xMS80LzIwMjUgMTrigIoyMSBQTSwg
VmFtc2kgS3Jpc2huYSB3cm90ZTogPiBGcm9tOiBWYW1zaSBBdHR1bnVydQ0KPjx2YXR0dW51cnVA
4oCKbWFydmVsbC7igIpjb20+ID4gPiBBZGQgZG9tYWluX2lkIGZpZWxkIHRvIGFjY2VzcyBncm91
cCBqb2luIEFQSSwNCj53aGljaCBpcyByZXF1aXJlZCA+IHRvIFpqUWNtUVJZRnBmcHRCYW5uZXJT
dGFydCBQcmlvcml0aXplIHNlY3VyaXR5IGZvcg0KPmV4dGVybmFsIGVtYWlsczoNCj5Db25maXJt
IHNlbmRlciBhbmQgY29udGVudCBzYWZldHkgYmVmb3JlIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5p
bmcNCj5hdHRhY2htZW50cyA8aHR0cHM6Ly91cy1waGlzaGFsYXJtLQ0KPmV3dC5wcm9vZnBvaW50
LmNvbS9FV1QvdjEvQ1JWbVhrcVchdGczWmROODBBalR3TkF3ZG1YeHdMYS0NCj5ldEMyQ1ZfbGJU
Qk5FQlA4aGY4VEJ4UGpRU3FxQ1JSSk9pSHl5YjEzcVRrWEVtNVR4emRpWnhpWEp1M3UtDQo+S2sx
eVFsNkY5SmVmbUlzJD4NCj5SZXBvcnQgU3VzcGljaW91cw0KPg0KPlpqUWNtUVJZRnBmcHRCYW5u
ZXJFbmQNCj5TaWduZWQtb2ZmLWJ5OiBDaGVuZ3dlbiBGZW5nIDxmZW5nY2hlbmd3ZW5AaHVhd2Vp
LmNvbT4NCj4NCj5PbiAxMS80LzIwMjUgMToyMSBQTSwgVmFtc2kgS3Jpc2huYSB3cm90ZToNCj4+
IEZyb206IFZhbXNpIEF0dHVudXJ1IDx2YXR0dW51cnVAbWFydmVsbC5jb20+DQo+Pg0KPj4gQWRk
IGRvbWFpbl9pZCBmaWVsZCB0byBhY2Nlc3MgZ3JvdXAgam9pbiBBUEksIHdoaWNoIGlzIHJlcXVp
cmVkIHRvDQo+PiByZXRyaWV2ZSBoYW5kbGVyIGluZm9ybWF0aW9uIGFzc29jaWF0ZWQgd2l0aCB0
aGUgc3BlY2lmaWVkIGRvbWFpbi4NCj4+IFRoaXMgZW5oYW5jZW1lbnQgZW5zdXJlcyB0aGF0IGRv
bWFpbi1zcGVjaWZpYyBjb250ZXh0IGlzIGF2YWlsYWJsZQ0KPj4gZHVyaW5nIGdyb3VwIGpvaW4g
b3BlcmF0aW9ucywgaW1wcm92aW5nIGZsZXhpYmlsaXR5IGFuZCB0cmFjZWFiaWxpdHkNCj4+IGlu
IG11bHRpLWRvbWFpbiBlbnZpcm9ubWVudHMuDQo+Pg0KPj4gUGF0Y2ggYWxpZ25zIHRoZSBwYXJh
bWV0ZXJzIG9mIGFjY2VzcyBncm91cCBjcmVhdGUgYW5kIGpvaW4gQVBJcyBmb3INCj4+IGNvbnNp
c3RlbmN5IGFuZCBjbGFyaXR5LCBhbHNvIHVwZGF0ZXMgdGhlIGRtYWRldi5yc3QgZmlsZSB3aXRo
DQo+PiBkZXRhaWxlZCBzdGVwcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWYW1zaSBBdHR1bnVy
dSA8dmF0dHVudXJ1QG1hcnZlbGwuY29tPg0KDQo=
