Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4223FC02196
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 11:39:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 354F642798;
	Fri,  7 Feb 2025 12:39:25 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 28BBE40DFD
 for <dev@dpdk.org>; Fri,  7 Feb 2025 12:39:23 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517AkLD6011482;
 Fri, 7 Feb 2025 03:39:23 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44ngqeg2kc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Feb 2025 03:39:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpK6SorW8mD3IdX9wo9YT1oEIkHulKKj0EebweCoYGvmpYtD627AjCuQAPbMvOvhZp50cooct7+DBYUJu5nHO73O1WjHuaTHyb1kkD2LwQyp5luzgDg8G+o4mt34F83lUdfJ8KnbJq4qyz8eSpwtWcceqrC1odHsmIdcaHJKTFkGzpUv56lTcfOgA62ZrB+lhabrTBS9K+h9qXlhvRiQ5NxTPaVHBsQnW9xyhDWUOSpF2wfspkobPAs+jx2RiQGYTJGliRJ50pxcUJ0UFNBJeAp3fJHzJMzPhSpXA9O4kZF/LGj9cFQhH7kxM3Kub6JP/H8NFtjt5UZt8ayx0YFcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GafR1lMjkDQwiPYvy9qi5f+B2zlTpASxj7yOMIjEtbM=;
 b=jtuLX0juyVFfv/juO8zkWjYOePPCFXhWsVCBZ6nYz5MxAxWkynsbOHuRnyrC7RxcedFTWVtrnieqQN48oy3Z9DsjgXmClR9dWQQWAtDNzmOJ59xyvde5wdMjpJBIF2xeXikUC7eeiCpuz2+8NiS06ulhz0kjLBC7tjyQktGa7yseL5GvHqrODkbU5rFDIW5+H+Cf6mMIrmcl7A3SlNcia1GZAYsSfaG4OKCJxC+27h1Flx7KFyUXCpsyg8Vj5MrLMzfFug9e0k2xXVQkjdmKpefDhb6uyDqYeTPBM4+UZFBRz6D12xwK2dlluYLywtPrKnIJigcBN3F3A0epk8j+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GafR1lMjkDQwiPYvy9qi5f+B2zlTpASxj7yOMIjEtbM=;
 b=JOrUwX007OVEIsV2eZuDO9Ra8yvis+1gU5zIATn01tGwVxoP4JmIV7ORxgQqesub3KMxK0qaYNUNn57dXGklli7AasRtWyl6ITFHPfybJPEZRLE58Q0gfLX/6yeNFFBjuZFCONDly0BqgOsQoZoHRdO0d/XD97YScvB8UqEXhz8=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by MW4PR18MB5063.namprd18.prod.outlook.com (2603:10b6:303:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Fri, 7 Feb
 2025 11:39:19 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%6]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 11:39:19 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: David Marchand <david.marchand@redhat.com>, Jerin Jacob
 <jerinj@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Andre Muezerie <andremue@linux.microsoft.com>, Thomas Monjalon
 <thomas@monjalon.net>, Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 3/3] trace: fix undefined behavior in
 register
Thread-Topic: [EXTERNAL] Re: [PATCH v2 3/3] trace: fix undefined behavior in
 register
Thread-Index: AQHbeT1Dho/CKfquMEm+i570TykqybM7tx9A
Date: Fri, 7 Feb 2025 11:39:19 +0000
Message-ID: <CO6PR18MB386009DC96D52BF64C1FFFE6B4F12@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250130145849.82003-1-david.marchand@redhat.com>
 <20250130145849.82003-3-david.marchand@redhat.com>
 <CAJFAV8yvVXqnK0mwngjroV-HgtnBpfG50co-3cMgq3AsPLnzgQ@mail.gmail.com>
In-Reply-To: <CAJFAV8yvVXqnK0mwngjroV-HgtnBpfG50co-3cMgq3AsPLnzgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|MW4PR18MB5063:EE_
x-ms-office365-filtering-correlation-id: 4b666510-c71e-4a64-53b8-08dd476c0f3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TDdxQ0lBTzJKZnYvVytIZisxWVF6RWtKQ3NHT3BUUVV3NlJTS3hFZUVwR0FU?=
 =?utf-8?B?RTFBcVVsaWNpdlFOK3BBTXdZcVF4clZIYnlRS2tKY1pub0hjRlZDYkEzQi9s?=
 =?utf-8?B?RkV2eHI1U1RPOEM2cjJTcnZqNnUxRGhoNWFrd01DUTQrRVBZOGVPODhpRUFN?=
 =?utf-8?B?WDI0d0N3WmordDVqMXRXRjU0STl3V1hLVUZQNXhkaXVSdnQxaFYvN3Y5Sm5P?=
 =?utf-8?B?YUhrbGtaR2tLM29Fc0RJdnhQOFlKcG1GZ3VUNW9neXlVRFJSK1A0NEJCSFRR?=
 =?utf-8?B?VXZLc1JKOVY4WEcrMk9Id2xFVG9Rc1Nma1pYQklkOVBBd2wydERKUGtDdUJZ?=
 =?utf-8?B?c011YUVNRlJJTkg3cW54bXZGWkVRN21ZeHczeFB0WG02eWFpQXB6SlFZcVVU?=
 =?utf-8?B?NjhyQ0pHTFk3b0R5Q3hHajJrMXlBVDhsTXE5LzNtU1FRQlQ2K2FQem16WnZz?=
 =?utf-8?B?NHlZMVdyb2Z2M1NvWU5nNGNXSnRzTUNxUjM5Y25nS1ZWRWttdnZBUHIrZ1M0?=
 =?utf-8?B?SDdaZ1FBQWxCSENGWjBnT3hmcEl2SE1uOEdTR2FqZjIxM0tuWWdsM3ErNUsx?=
 =?utf-8?B?MUVnRmpJY0Q0UTR1Ty91UTZrYVJNVm80c1ZmcmExdEhTSjczc0hTTysxQ2xx?=
 =?utf-8?B?VVUrTDZKUTB0dzQxaFZQU2huTm1EZk1vWkluVXdXUkYxRkE1TEtPeWZ5MVpO?=
 =?utf-8?B?SVBzTUc0WTlqak5jNkRVRnRnTXNTTkh1TTlTalRvZG1WNFJKeEcvT2d6ZEpK?=
 =?utf-8?B?d3pQSDV1UGRHdmU3a3d5RmlrVlNGdEJDelZ2enIwSS8xQ0VxcDc1dkZRQzRU?=
 =?utf-8?B?SGp5aldsMWlXRG5KTVBKNWlwTWNOc3dtd1QyRUFQVTBKaW8rYy9IK1pFUTVT?=
 =?utf-8?B?WUN0TGV1NDF4VEErK1F1aVZwdFgrbm5wTUJEOENyZjJBcWFyNGRyOVVXd0hh?=
 =?utf-8?B?R1hyTFUwZStDZ2VUVnlzSHQrckhpbmFqVEdhY2pBMVkyNXdkeWsydnBuVDBj?=
 =?utf-8?B?OS9CTjE5dFVFYXNQeEZodzhiSStKZCtKb3hqVjRFNDdoSkRxU1ZpSVIxem4x?=
 =?utf-8?B?QjIzUkRQY3V4KzhrbTZzMUh2aEFCTXJVcjI3UnlwY0FtTGRRNjQ0YXNkRVEw?=
 =?utf-8?B?QkdVU3dZZkdkNThlcFZSQm9LZWZGaXprM1N2NzhoOTVsaGJjS2h2ZnhlRGNU?=
 =?utf-8?B?aklsOHFrUlJKaFdONEN5OEQ5c2tka21aY0o1N1NCSTNjblVOTkNEUkpWSFR0?=
 =?utf-8?B?VkxsSHA0UExLQWxqMGdRNjRNZUpwSm5sNTZ2clBjRjY5Yi9EWThZQjF5My9R?=
 =?utf-8?B?L1dpaHROSnpVYUNZN0UyeUVLdXl5QmRYU25NaUZjMEZra2ZibHViNlBhZ0x0?=
 =?utf-8?B?L2xQekVOTGVDQ2c5emJqbGtjVlVKU0hkdldBMkIwMWVpUFYvYklva2lzOU1m?=
 =?utf-8?B?cm5Ta3NWVVVUMkdwVFRhaStUNmltUTdoRkJGWHlxdkVML29NQi9YRE1vWVVN?=
 =?utf-8?B?VW9ES0NySk1FMXRvL0ZNMVY2N3MyUWlwRTN6U0g1OWxyem55d3VwN2pUYXNj?=
 =?utf-8?B?bTV2eFZSNG1zZTRiSUpLTmc4MlVBa3p0ZnJYL2pYQ0U3SnNsVnlPRG5POVZV?=
 =?utf-8?B?dmJkWDhxVDNabm5CZjkxL3NXSkZPVS9UaDRWUHQzc2RHQnZUMUMzWmJpOTNj?=
 =?utf-8?B?alVZa0l3OWxGL05heXRoUnhzWXVHK1N5b2hmUDUwdHF3VUJ0SnJ2bjdxbjAx?=
 =?utf-8?B?eUgraGhsU2Q2LzRSLzZRV3crWDNvRUlTL28zQWw2anNXOERuQUdNWG5ubmlu?=
 =?utf-8?B?aWN0eWRmREVLcXZlcHFKTjN3aFl1QUR6RnE2MzBnWTVwRHJFT0w5MEdQampl?=
 =?utf-8?B?eER6QlhJdkN3OGhVSDB5R2JUVWVkbDIrN29XZnJTV1AzUkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anFGd3FqZC94TTdsVTJLVUhvVENKdkVscUtHOWpBcGJsdzBIY2JqY1E5eGE0?=
 =?utf-8?B?R1VZQzBVREM3bkx6akpqK3pLOGpPdmJMYzlVaWtscXA5ejNxSUYxSW1WNnk3?=
 =?utf-8?B?dlh2M1NNRXN3SFo2OEdrWEZDZ1VKckpwbWRsanZqbVIzZEZPMzdHam44YUEv?=
 =?utf-8?B?eVRUL2JxeEJaQTAxVHNTZWtMM1VTa3JXSVBDa20rSTJERkhDVmJSZndybWVj?=
 =?utf-8?B?eFltM0Y4cFc3L0dGQStEdUZxOU5FSFVFNld4S01yNmRKTWR3YnZIcWgrd3Vo?=
 =?utf-8?B?dVBmcTdrb0cwb3V6ZTNlaGtCZFRLaFNzcTZMd2hBdy9EcERsakIvRlZ2R1hQ?=
 =?utf-8?B?MStzVDZRVmcvUXRxK1FLV0d2NkxUODlBUUpqRlprZHVjc010VmRadThibkx5?=
 =?utf-8?B?Q3hjWXJ5UlMxOXhQOHhoM1MwT2JmajhXU0VOemNKM1NrYktuZVAydnIvd0Fz?=
 =?utf-8?B?M05sVnVvUGVaN2duTUo1YTEreFpoWUdOUGljR1EwcjRTNXNodENXOWYxNlNq?=
 =?utf-8?B?UHZRempYMVhaSVJqL20rVmhiWHU2VUFyY0xHQXZGL203d3l4NU00dkRLSzg4?=
 =?utf-8?B?SkN0TlNEQmZIYjd2TWhZaWZjVGcxNUFldm9ZQUt0WjF4Uy9VYkJnK0dXTlF3?=
 =?utf-8?B?UzZOZEJJbmEzcjBERWwyd3E0SkRIVURFTVV5UTBJVVg4c1ozbDdHcVJwdVAr?=
 =?utf-8?B?Tjdoa0FWM0p3SFB5NkpkT3g5SzdSajlOOGczSUxGL3pOVzJKU0wwcE14bFpl?=
 =?utf-8?B?cG0rOFRGd0t5RWlTMlB2dVlOQWlndDduS3djVE9Qc2lrUUc2em1iOSttZkxZ?=
 =?utf-8?B?MzVydjRPekNhMEdYclR1SnA5VVppNUtFVUVCdzV3emorTTduQzAwM21Ob2hI?=
 =?utf-8?B?UlBtUmhpOGxodUFPdzE1ZTZWYmZjN0NCK1liOHB5QmxBVnJGY1hqWUJ2WGNO?=
 =?utf-8?B?QUxiaDBERkNOemJ4OVFUcy95cTExSTJJbXJPRjZkbmhheXpqUHZwY3kyREx4?=
 =?utf-8?B?TDdNTFpDQkFpenNTNzd5OFBRVm10RHZvSFk1T201THZ5enhOVU9VaUVIanl1?=
 =?utf-8?B?ZG5DWVZKMVMwdVRQWGVheWM0RjRETEd1b1ZnbE51blAwU3ZmdUw4Wm01UmFC?=
 =?utf-8?B?N2JMM3dOdDhVY0lsN1lWMm1WTitjR0t2UTFyN2wxT3hLTVlkN3RiMDJOc3Rw?=
 =?utf-8?B?NjY3cGt5UFZScnFMOHNoTGJpQ29hRnUwdVgzeFdGbnFra0Y3MGx1RDVjYTkx?=
 =?utf-8?B?V21Hc0txNnBIWUt4emxha3d1dGczUTdycVNHcEt5YjhOUW1OLzVhMXlzQXlz?=
 =?utf-8?B?cEpEOWxoUmFBem1jN3FPQlF5Zkk3QzVCRFVzS2JubngyV1lFU0RNeWhPT0Nw?=
 =?utf-8?B?WHFDdFlWY3dVZ0hoTng2dUhPS21mSlYxN1FIYnlsVTg1ekE5WGFBempCU05V?=
 =?utf-8?B?S2lqbmEyS3ZaZisxakZLN0Q1eW91bTRMWEUwdUdRWU1tOWxhNU9uamh3Mm81?=
 =?utf-8?B?R2cvUGNOVFh1cG1WT3JSeSthL1pCeWVkWG5hQ05PNVlnbVloUmVQTXlIeWVG?=
 =?utf-8?B?OWJRU1c1MHZHbHNuQ1p0QmlxUUlrclZRUzFiZDRUY2swalFYWG96cSsxb0JC?=
 =?utf-8?B?dHpHQTVLQXRoektNbzl3ZVlpY1VDakwzSFNoaWlkbFhiWFN2T29TMTR4c1hB?=
 =?utf-8?B?OVVQTVFWMEVXS0Z2KzNkVjk0Sy9rRTJTcHIzeGR3RlgwNmxWb0xtdUZoR3BC?=
 =?utf-8?B?VjhRTVV0TWZEeXZHdTU2VEYzeGtSV0VXSmNBYTQvVHhNT1dlbmMrNXZkT3k0?=
 =?utf-8?B?WlZ6Z2tkM3I4WFV1aXBlR21Ic0h6VzNBdUpoRjRTK1RlZjE5WkxHdDJmYWtR?=
 =?utf-8?B?SFhUN3d1Y21UYmJoWnFqTi9sTFJocHFGdkk0ZERUeWRBOG4zTlZLSGNNSVYy?=
 =?utf-8?B?YVRha0ZYOVNUdGpacmp6dXNSZVpsRTZiVUFUaHRoU0o3OVhQZXo3bHgrcXdY?=
 =?utf-8?B?MFlKY1pyTFB1OTNtdjZIWE9yWnhta3pFOGNvTTVia05GMFNPV213Qkh3RXZZ?=
 =?utf-8?B?U2VLZlMxL2h5RGlzRzRvMkJPd3pWbjI4RXpKSGp0NDJHTVJsYnVaT3hYRTR3?=
 =?utf-8?Q?EMBM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR18MB386009DC96D52BF64C1FFFE6B4F12CO6PR18MB3860namp_"
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b666510-c71e-4a64-53b8-08dd476c0f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 11:39:19.3581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LT158fPNP7V/kiIhpj/1N7NoJ5WW/1SiVwTh++8PhmylmqlHIjUPWsdWCuwVa3OWz83UQNSOSYXMMHYOg1sUbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5063
X-Proofpoint-ORIG-GUID: gk8XWhkvzy8chQKzk4SN6hHphBdLtzwa
X-Proofpoint-GUID: gk8XWhkvzy8chQKzk4SN6hHphBdLtzwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_05,2025-02-07_02,2024-11-22_01
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

--_000_CO6PR18MB386009DC96D52BF64C1FFFE6B4F12CO6PR18MB3860namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

I will look into this at earliest and provide feedback.

Thanks

From: David Marchand <david.marchand@redhat.com>
Sent: Friday, February 7, 2025 2:20 PM
To: Jerin Jacob <jerinj@marvell.com>; Sunil Kumar Kori <skori@marvell.com>
Cc: dev@dpdk.org; Chengwen Feng <fengchengwen@huawei.com>; Kevin Laatz <kev=
in.laatz@intel.com>; Bruce Richardson <bruce.richardson@intel.com>; Tyler R=
etzlaff <roretzla@linux.microsoft.com>; Andre Muezerie <andremue@linux.micr=
osoft.com>; Thomas Monjalon <thomas@monjalon.net>; Stephen Hemminger <steph=
en@networkplumber.org>
Subject: [EXTERNAL] Re: [PATCH v2 3/3] trace: fix undefined behavior in reg=
ister

Hello Jerin, Sunil, On Thu, Jan 30, 2025 at 3:=E2=80=8A59 PM David Marchand=
 <david.=E2=80=8Amarchand@=E2=80=8Aredhat.=E2=80=8Acom> wrote: > > Register=
ing a tracepoint handler was resulting so far in undefined > behavior at ru=
ntime. > > The RTE_TRACE_POINT_REGISTER()


Hello Jerin, Sunil,



On Thu, Jan 30, 2025 at 3:59=E2=80=AFPM David Marchand

<david.marchand@redhat.com<mailto:david.marchand@redhat.com>> wrote:

>

> Registering a tracepoint handler was resulting so far in undefined

> behavior at runtime.

>

> The RTE_TRACE_POINT_REGISTER() macro was casting the tracepoint handler

> (which expects arguments) to a void (*)(void).

> At runtime, calling this handler while registering resulted in

> reading the current stack with no relation to this function prototype.

>

> Instead, declare an additional inline _register() handler for each

> tracepoint and make sure that the emitting macros in

> rte_trace_point_register.h only work on arguments name and type.

>

> The original tracepoint handler prototype is adjusted by adding a

> __rte_unused for each argument (since emitting macros do nothing

> with them).

> This last part introduces an implementation limit of 15 arguments.

>

> With this change in place, the workaround in dmadev tracepoints can be

> removed.

>

> Signed-off-by: David Marchand <david.marchand@redhat.com<mailto:david.mar=
chand@redhat.com>>



Can I have your opinion and review on this patch?



Thanks.





--

David Marchand



--_000_CO6PR18MB386009DC96D52BF64C1FFFE6B4F12CO6PR18MB3860namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Mangal;
	panose-1:0 0 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi David,<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I will look into th=
is at earliest and provide feedback.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> David Marchand &lt;david.march=
and@redhat.com&gt;
<br>
<b>Sent:</b> Friday, February 7, 2025 2:20 PM<br>
<b>To:</b> Jerin Jacob &lt;jerinj@marvell.com&gt;; Sunil Kumar Kori &lt;sko=
ri@marvell.com&gt;<br>
<b>Cc:</b> dev@dpdk.org; Chengwen Feng &lt;fengchengwen@huawei.com&gt;; Kev=
in Laatz &lt;kevin.laatz@intel.com&gt;; Bruce Richardson &lt;bruce.richards=
on@intel.com&gt;; Tyler Retzlaff &lt;roretzla@linux.microsoft.com&gt;; Andr=
e Muezerie &lt;andremue@linux.microsoft.com&gt;; Thomas Monjalon
 &lt;thomas@monjalon.net&gt;; Stephen Hemminger &lt;stephen@networkplumber.=
org&gt;<br>
<b>Subject:</b> [EXTERNAL] Re: [PATCH v2 3/3] trace: fix undefined behavior=
 in register<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"mso-line-height-alt:.75pt"><span style=3D"f=
ont-size:1.0pt;color:white">Hello Jerin, Sunil, On Thu, Jan 30, 2025 at 3:<=
/span><span style=3D"font-size:1.0pt;font-family:&quot;Arial&quot;,sans-ser=
if;color:white">=E2=80=8A</span><span style=3D"font-size:1.0pt;color:white"=
>59
 PM David Marchand &lt;david.</span><span style=3D"font-size:1.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif;color:white">=E2=80=8A</span><span style=
=3D"font-size:1.0pt;color:white">marchand@</span><span style=3D"font-size:1=
.0pt;font-family:&quot;Arial&quot;,sans-serif;color:white">=E2=80=8A</span>=
<span style=3D"font-size:1.0pt;color:white">redhat.</span><span style=3D"fo=
nt-size:1.0pt;font-family:&quot;Arial&quot;,sans-serif;color:white">=E2=80=
=8A</span><span style=3D"font-size:1.0pt;color:white">com&gt;
 wrote: &gt; &gt; Registering a tracepoint handler was resulting so far in =
undefined &gt; behavior at runtime. &gt; &gt; The RTE_TRACE_POINT_REGISTER(=
)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"mso-line-height-alt:.75pt"><span style=3D"f=
ont-size:1.0pt;color:white"><o:p></o:p></span></p>
</div>
<div>
<pre style=3D"white-space:pre-wrap"><span style=3D"font-size:12.0pt;font-fa=
mily:&quot;Arial&quot;,sans-serif">Hello Jerin, Sunil,<o:p></o:p></span></p=
re>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">On Thu, Jan 30, 2025 at 3:59=E2=80=AFPM David Marchand<o:p></o:p></span=
></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&lt;<a href=3D"mailto:david.marchand@redhat.com">david.marchand@redhat.=
com</a>&gt; wrote:<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;<o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; Registering a tracepoint handler was resulting so far in undefined=
<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; behavior at runtime.<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;<o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; The RTE_TRACE_POINT_REGISTER() macro was casting the tracepoint ha=
ndler<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; (which expects arguments) to a void (*)(void).<o:p></o:p></span></=
pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; At runtime, calling this handler while registering resulted in<o:p=
></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; reading the current stack with no relation to this function protot=
ype.<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;<o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; Instead, declare an additional inline _register() handler for each=
<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; tracepoint and make sure that the emitting macros in<o:p></o:p></s=
pan></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; rte_trace_point_register.h only work on arguments name and type.<o=
:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;<o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; The original tracepoint handler prototype is adjusted by adding a<=
o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; __rte_unused for each argument (since emitting macros do nothing<o=
:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; with them).<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; This last part introduces an implementation limit of 15 arguments.=
<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;<o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; With this change in place, the workaround in dmadev tracepoints ca=
n be<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; removed.<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;<o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; Signed-off-by: David Marchand &lt;<a href=3D"mailto:david.marchand=
@redhat.com">david.marchand@redhat.com</a>&gt;<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">Can I have your opinion and review on this patch?<o:p></o:p></span></pr=
e>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">Thanks.<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">-- <o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">David Marchand<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
</div>
</div>
</div>
</body>
</html>

--_000_CO6PR18MB386009DC96D52BF64C1FFFE6B4F12CO6PR18MB3860namp_--
