Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F53E67A85
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 07:11:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 443D4402AB;
	Tue,  3 Mar 2026 08:11:26 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id EDBD440288
 for <dev@dpdk.org>; Tue,  3 Mar 2026 08:11:24 +0100 (CET)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 622JhIMc411260; Tue, 3 Mar 2026 02:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=i
 oLTjS2oYTeMezEBpPaLvfm8Pw5hixblr6tpmRKico0=; b=P/VFPgycWivma6w/4
 bfy1Vr+7PDZudHrEdMcpI+TdYP2uEJjyK0pxA9q4nPGdDKWMwBLgfVBxN/qIx+tD
 pLI6h5wdDAaEryupEAkBs95B1SjvXaNYEtISo7ac/SJZ8xhkyfO5a4l4k1JWqCm0
 uxBQ/y/HPmX24hdHydv6XsI12wcBp1eGQL8cc8jF7KdDQNyBw4nIISb4vLMA2H8E
 B4tcGVet/luKCppZwuso35oOF3DdVlYZ+v5jcEPInlTtSZc0mWAuTP7i+eE1Kt9P
 3IsCBBb8yy2mwuV5Wh1HDR7RHT//E8JZOJ+XhLMqn/16ZGLIw7NE3acjiYAuHdh0
 /bSOQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4ckvd9jhg3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 02:11:23 -0500 (EST)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6236ZgmR2858595; Tue, 3 Mar 2026 02:11:23 -0500
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4cnm7t4etj-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Tue, 03 Mar 2026 02:11:23 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHVRqW+u5meu0J2cpqjuk97xaZNcPIP0qMvvu3TtiTDl1/FITY5sLGvlEziW6Aj78cJy+wC1vYNWH8IFWpPMmRel86mn2Yixv3ObdkOSwgcEpHOtm4yaRc2m+wgvUkK6wzKUUSQRrJ2qs+SX3ULbYXfHrirbPtShlcGIKwa47oqfj53R6Q5MQ7VEQ67pvzoOIdKzqXgqCOCFUpLz3TqL/XPJaQvh2hpvrkBNKKfaYzCjkF57w2iS4nrgloUC2Jy3JNjvpUfQBcGKV+mpTVrIQ8l+MAtJdp1dJPfRBK+DI6fRu4q74JCEZ+cM/C3jgZKK7gOQ5k3OqmVp0+D42BHy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioLTjS2oYTeMezEBpPaLvfm8Pw5hixblr6tpmRKico0=;
 b=L1pTJ22aN+53YuLBv8ERqSBJKCIE+t4rU1GvNLrSTYFxv2QQmOkCO+Oz1G3XUzG+3Dz8ym+oVLe4DtHe6aC63L9+/i/Lyaje7hBpX6Xyfjd/wkQwU8PsK1rqEjRwGVB+ZSnF8SfGHf8lWPOsNWxx0nQoQrfbF1W38s8BJIppHQtTcE76vW9rsjsTKQHS/7V/XhFpeQV3g4Y+Eo9mpk5MRTP1LsTEPYkKjPb3+uiuwQATaFIZpP/9PF7lB0VCVSKcrmJQ4GR3Yd7LUIa4OMcgxrevY3tqLlQei+pQPi61qtjxfbML7NuRThWRlTDsDLDGGpK9bQ3ip2BV4tIDC7P2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB3564.namprd19.prod.outlook.com (2603:10b6:5:1dc::21)
 by IA1PR19MB8888.namprd19.prod.outlook.com (2603:10b6:208:59a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Tue, 3 Mar
 2026 07:11:17 +0000
Received: from DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb]) by DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 07:11:17 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>
Subject: RE: [PATCH v6 4/5] vhost_user: Function defs for add/rem mem regions
Thread-Topic: [PATCH v6 4/5] vhost_user: Function defs for add/rem mem regions
Thread-Index: AQHci3OTfavL55cpn0GxBxzt32qlHbVk5SyAgBh9shCAHz/FIA==
Date: Tue, 3 Mar 2026 07:11:16 +0000
Message-ID: <DM6PR19MB35649A4D0C34D34853EEC9E9F57FA@DM6PR19MB3564.namprd19.prod.outlook.com>
References: <20260122074906.127942-1-pravin.bathija@dell.com>
 <20260122074906.127942-5-pravin.bathija@dell.com>
 <CAO55csy0oikG_HxUeqnU7tMvg+mjCdXP3uEUq7vUNsx8DgBGNw@mail.gmail.com>
 <DM6PR19MB3564F2D3D5466B57EE018658F563A@DM6PR19MB3564.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB3564F2D3D5466B57EE018658F563A@DM6PR19MB3564.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-02-11T09:57:51.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB3564:EE_|IA1PR19MB8888:EE_
x-ms-office365-filtering-correlation-id: 2cdbbec4-d93a-4d2f-8b64-08de78f4100d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|786006|366016|38070700021; 
x-microsoft-antispam-message-info: Ofi0hVaUOL0JhOvTcPubskUu13RbeYzUWCsaFwISxFkpxr6uDhKGZRe4CZfnEmvHZFrl7cpGwJQEQBzhr/BH4p8wCZxqMqlIfIytmwLduWAw7s/ZJmPR3swieXdVTM4I6M5S/MOclP9j57obC1JS7ythi6fCGonPMkICuMJ4IFbsqr3bQgvrvs9nj0PmpAaN7TOIlBgimiPONpPJz/mUdfgPi6Ir5/2XqIzZ95zNAovuTgxA/YXvBZhgwY/fIsu9TNNYVFGg2vIKLys219KpcOwI/lSm2xHGgqgBwJJHGGP/CzoMdJNlQhKqQPt2HxLBQmlYANMk5wtq+qjdqSAwqhJyQk2Xg5tRq2hl9+v4qZFO9/itPrFcDZ3w15z3v5skW0rfHqwT3x5RC8SmMG/T4H9i8Xn69tD+5TsCm8heJjhjPOX6/LjHtnZ0DCgcplkhhhXfcBlg9K2D4CVnsKaOZYmFsa++XIffYODzjcF48p3yLfPktzvEz33z7awXrNHBAqYWbckbAAZwt07r8OI9ENkKc7R0/mrMVI+RgRn5nKarOA6yXwY8eG/1NlC97Q/KIVZcmlG347+WrfXMq0g9EJ8UXhRQV+EHwrlgZysJSaoi5m/IJDhyjByuZ7zFIop118bi57iv7S4e1KoCqQtsbnU5OFwdMznW7OfMNJBvjpNCcyGrH5gjbrjDl9PLrItOPFTFwXiGLrOqWQPd1KlrNwOQbaPXdT5usDbWwAbtaZeqvBca+KjMy7KJK1RXPRMHmrnDrzqmydwdbEPZFVk3Ghvh/QU/tvqQbEetMthvqr0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB3564.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(786006)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?QWRsMUthUFJsalBRakRGMHVmeG1VQWNUb2VBYVpkVDNpMjd3anQ5T1JoUVVD?=
 =?utf-7?B?WlVnNkxtM1NHQ1I2aVd2M0VqNTlqZ09MOU4yTHlwUWwvdjA4cjBHNTFRSzB2?=
 =?utf-7?B?WUUyRXRPL1JtQlFYSUJpcDMyNU1vMjVDdmd2Qk0wTFhocW1MZSstMVk5N0Yx?=
 =?utf-7?B?ZVpEeG93VmhYMS9pZWN6b29aY0Nvc3gwcC8yeGhwWmFNL3RnNFh0R2svY0lJ?=
 =?utf-7?B?aG9HS3MvT0VTTFZXTWxLQlZrZ0hja0V0SC95S3JsUEZvVlNXY1U5cVB0QzI4?=
 =?utf-7?B?MTJFT1FWQ2Nmb2NiYTNGRVRubFphR2lsSTF5TlNsYUNoY3BZYzVlTkxKTThM?=
 =?utf-7?B?akwzUXlrWGdZMmtKc25BUUhqZWlJTW5pWW5yUFBJTlZrTzhiKy1MTjlTaHJt?=
 =?utf-7?B?Mk5NeldLRjRscW9MeFpINVNQdndjUystczVud0N0akFqdjAwMkZIdWVOcjR5?=
 =?utf-7?B?TEYySWxGRVVNUDNsRWZ2U3hlS1o2OG5saXBkT3gwQUtib0Y2Zm5GbzU0MWlF?=
 =?utf-7?B?NTNZZFR3YnNTc3g4ZkFNWXZ2b2VSQjJOY3VuZzcrLWY4RFpuek1JL0ZLa2RX?=
 =?utf-7?B?V01ORzdHU0hCRFRlMWxpSXJZVzdXdUR5MFNLa3daaFpidUo1YVNCSlVVRmZn?=
 =?utf-7?B?UTVNU2RSVHpaSWtDM2hjTWhkcE0rLThvUnlPczRwckxISWoyVDF4Ky0ydVRj?=
 =?utf-7?B?TlFVNFMyOEdlS21kZXVieVFjSTZUbGw3RWFwTGl4MlRGT0s4SWwzdmhXOEpj?=
 =?utf-7?B?U2UvNkdVTXdUWUVFY3dGOHB0bTNvNnROY0IrLVlXVEc1N3gxQ0JiME01YThQ?=
 =?utf-7?B?ZEtobmpXWDlvWmxDNkRpblBoY2UxVWQ3bkhDTnlMVW1ydU55R2VadCstQ0lO?=
 =?utf-7?B?OENnRW9rVzJuUFB4TVh6cVd3SDJUeXlLS2x6S0pTcFBjQThlbFZ0T3lKbmNs?=
 =?utf-7?B?Vk5UUWk1OEswY2dwdXVQNFVSQ2pYWGVXZzJNVy9MSGFHbUhORlBCUVJNN3dT?=
 =?utf-7?B?bEJlcDN1R3VYaTQvUVcwc2JiOFd3L1YwMUsxcTQ5WkcydER3alZrUW5wd3Mz?=
 =?utf-7?B?TUJFKy1PRVBuNjhuaks4T3FUNWpPM0RVaDA1R0VKdkdWVDVQNXROQXlOaXRx?=
 =?utf-7?B?SFdkZjMwREVIUHZFNVVReFduclhsMEQyZHBMZ1ZCcFJWT24ySFFpaXUxVSst?=
 =?utf-7?B?b1RvKy1xOVlrRVlNNGpHWTA2ZjJvdzMvWksyT082VWloYldncGpEZGFXSTV6?=
 =?utf-7?B?ZzlmVU1XdXp4N0toUGRPNlIwOWpKbWtmRWh5VzlQZEplSHhvaktQaHV3eHFI?=
 =?utf-7?B?b2ZPalpsdFZTeVB6dEo1SXduMmpnbCstRkp0azJXdGFwYU85cUFTN2RqanN6?=
 =?utf-7?B?b0tiMEFjNW9nUHQvRjJUWUJhVUh2dG1VT0xySm9pMkhGNUlqbGR6anpHKy1M?=
 =?utf-7?B?UWVoY3JRSDFsdmlYcXVOYW5RaHlvNHFyemNaY3NUVTNuQ3J0VlQ3VzNjQVJF?=
 =?utf-7?B?SE9yQzZnQ25kYVNPcWtpWndlYmE0aWRxN1huMTl2Y1FDb3R0VTdJVGY2Y1A1?=
 =?utf-7?B?NFQwaWlJUE5adEpsNkZVUistSHlQMHRha0Naai8zMCstUzRBU2hJcmU0eUV2?=
 =?utf-7?B?anZ3VGtINW9sZlB1MEVIR295NmIybWwwd3NtYTAwZ1piWXl1MystMmJEVWU0?=
 =?utf-7?B?SlVFVWszVnJWb05DYmNvNnNXdUs0dFdyUHJhVzZpTVJsM1lpVUZDMHdEdmJH?=
 =?utf-7?B?aktmZ3BDazNBWDVEaHNsUDltQ25VN2NhN09aVERqSU1nUkFES29qVkxObTNI?=
 =?utf-7?B?WjVtZ3NTaHpsKy1SSWl1QXdHVjZJM3VSS1czTEhoRmFRRE9HMmFMdEN2anp2?=
 =?utf-7?B?YzFta0Z0UFBicmxacUtvbXRBYUlMWURnRFEwMmhQY1NhNGtkcVcwRENHRDUx?=
 =?utf-7?B?S2haTnNaa0llRC9mSXJyVVRPU3U4VWtQU25mNVFLcWtzbHhEa0FZOG9FVnNY?=
 =?utf-7?B?RystT1ZOaWhXSkYyaE9Xdkw3UERUYXFjanVDYWp5ZVM5WGJYUm1SUkRuSWNK?=
 =?utf-7?B?cGJsQm1kaU1xcGE3SmpHUktGbkRXNnRNU3l1UFl0MEhqZmFpUW5ncTArLVZU?=
 =?utf-7?B?OXZ6RTJrZGRBdzU4MjZaVnRjaWFGWko3UnJzMnVsMjdLa21DMnJxMFJSaUtZ?=
 =?utf-7?B?cUdIN0J6dElVKy0vbkY5U08wVnR2MGtqNUduRHRuTWE2b1B2RXl2cFlHVDdH?=
 =?utf-7?B?NHVCUWdtVkMyRUJzNHFFckViM25ZKy0vYzBBR0pIekRETGFyNnIrLVNhdUtp?=
 =?utf-7?B?bmxUM3FzWk5JdG5Zbi9UMzlWVW9ROFdtdk9YVDZ5d0c4Si9kc2lZR0M0VVho?=
 =?utf-7?B?b0tOSzgzdVpIY1I3YXFGOEErQUQwQVBRLQ==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3564.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdbbec4-d93a-4d2f-8b64-08de78f4100d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 07:11:16.9687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRWksMX5YGO9BbEiY2XHdr9dBqhv1V2pBqHaDh7wgzDdDbqLhjZdFjbi3/t8s4vyEHhMLq+/cEiws4QgFiXrVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB8888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030049
X-Proofpoint-GUID: Ha58KUhyGPuQawOOKYjAeftQIZ1NyxA_
X-Authority-Analysis: v=2.4 cv=IdqKmGqa c=1 sm=1 tr=0 ts=69a6899b cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=m3zZTHMLHbwB7Lmtoed2:22 a=20KFwNOVAAAA:8
 a=8rWy6zfcAAAA:8 a=i0EeH86SAAAA:8 a=iLNU1ar6AAAA:8 a=XlRjxQ70AAAA:8
 a=eSb-bNSJAAAA:8 a=ytFMdNZ7AAAA:8 a=LfxEVeEBAAAA:8 a=Lk1HmKH49trAB_5y6GUA:9
 a=avxi3fN6y70A:10 a=gbU3OgOOxF9bX48Letew:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=1uMOUU2w0DxzEe95gQqD:22 a=h7YW-pclpbZRD8svLbQ0:22 a=oxySFUAvEW1-6AXleBSr:22
 a=7k9nRlTqVbDGZ3p5_T00:22
X-Proofpoint-ORIG-GUID: Ha58KUhyGPuQawOOKYjAeftQIZ1NyxA_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA0OSBTYWx0ZWRfXyy2HSWZGVeJb
 PoNYZf4bWBundHyfRkbohn5RwjjkzD7EHR5fwjI9ElzVdBfsTu0hRfgMIfFw8uTA3uWwS5dHmqg
 8DIfOqI+8HpoG3T/JQ72nlylYahhttn+qdoqD8ErM5GNNJhJdbrF5mu/9cUg0EyAxsA1twt4OmW
 p89qUjYlg8vMDcLJCilGClvPyPpbimtG9ARXQC/BCvdjYf8oKa1eI2X4neZmrBwhIAa1UHwwk+f
 ckM0leGQWx7f03CNxYqshyrINUcuazCRIdjja1kyLZapeCd5noNO6SAUQqRX4ei2PVwV36gPI7i
 YPO+8A1qPwhBTOJJgk+2sRxZU1CDT0p6OiqfdnADW0+4Zb1wrC5C8xgD8WvAD9ziYPM4O73m+qb
 30zPzUJ4kSARAbUMVS/WAiiCQEv7qkxjaPDXx+Tk27nYJ5nAbX6vwLXSYU7GnhC0w/ELZYF6z9h
 mhEfKLaAQXj3FfWUZDA==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030049
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

Dear Maxime,

Any feedback on the latest patch v7 I submitted earlier ?

Thanks,
Pravin


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Bathija, Pravin
+AD4- Sent: Wednesday, February 11, 2026 2:20 AM
+AD4- To: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD4-
+AD4- Cc: dev+AEA-dpdk.org+ADs- fengchengwen+AEA-huawei.com
+AD4- Subject: RE: +AFs-PATCH v6 4/5+AF0- vhost+AF8-user: Function defs for=
 add/rem mem
+AD4- regions
+AD4-
+AD4- Dear Maxime,
+AD4-
+AD4- Answers inline.
+AD4-
+AD4- +AD4- -----Original Message-----
+AD4- +AD4- From: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD4-
+AD4- +AD4- Sent: Monday, January 26, 2026 11:58 AM
+AD4- +AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4-
+AD4- +AD4- Cc: dev+AEA-dpdk.org+ADs- fengchengwen+AEA-huawei.com
+AD4- +AD4- Subject: Re: +AFs-PATCH v6 4/5+AF0- vhost+AF8-user: Function de=
fs for add/rem mem
+AD4- +AD4- regions
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4-
+AD4- +AD4- On Thu, Jan 22, 2026 at 8:49+IC8-AM +ADw-pravin.bathija+AEA-del=
l.com+AD4- wrote:
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- From: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.com+A=
D4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- These changes cover the function definition for add/remov=
e memory
+AD4- +AD4- +AD4- region calls which are invoked on receiving vhost user me=
ssage from
+AD4- +AD4- +AD4- vhost user front-end (e.g. Qemu). In our case, in additio=
n to
+AD4- +AD4- +AD4- testing with qemu front-end, the testing has also been pe=
rformed
+AD4- +AD4- +AD4- with libblkio front-end and spdk/dpdk back-end. We did I/=
O using
+AD4- +AD4- +AD4- libblkio based device driver, to spdk based drives. There=
 are also
+AD4- +AD4- +AD4- changes for set+AF8-mem+AF8-table and new definition for =
get memory slots.
+AD4- +AD4- +AD4- Our changes optimize the set memory table call to use com=
mon support
+AD4- functions.
+AD4- +AD4- +AD4- Message get memory slots is how the vhost-user front-end =
queries the
+AD4- +AD4- +AD4- vhost-user back-end about the number of memory slots avai=
lable to be
+AD4- +AD4- +AD4- registered by the back-end. In addition support function =
to
+AD4- +AD4- +AD4- invalidate vring is also defined which is used in add/rem=
ove memory region
+AD4- functions.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija+AEA-d=
ell.com+AD4-
+AD4- +AD4- +AD4- ---
+AD4- +AD4- +AD4-  lib/vhost/vhost+AF8-user.c +AHw- 234
+AD4- +AD4- +AD4- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-+-+-+-------
+AD4- +AD4- +AD4-  1 file changed, 202 insertions(+-), 32 deletions(-)
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- diff --git a/lib/vhost/vhost+AF8-user.c b/lib/vhost/vhost=
+AF8-user.c index
+AD4- +AD4- +AD4- e2831b7625..1a2dcfbbca 100644
+AD4- +AD4- +AD4- --- a/lib/vhost/vhost+AF8-user.c
+AD4- +AD4- +AD4- +-+-+- b/lib/vhost/vhost+AF8-user.c
+AD4- +AD4- +AD4- +AEAAQA- -71,6 +-71,9 +AEAAQA-
+AD4- +AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-FEATUR=
ES,
+AD4- +AD4- +AD4- vhost+AF8-user+AF8-set+AF8-features, false, t
+AD4- +AD4- +AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-=
OWNER,
+AD4- +AD4- vhost+AF8-user+AF8-set+AF8-owner,
+AD4- +AD4- +AD4- false, true) +AFw-  VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+A=
F8-USER+AF8-RESET+AF8-OWNER,
+AD4- +AD4- +AD4- vhost+AF8-user+AF8-reset+AF8-owner, false, false) +AFw-
+AD4- +AD4- +AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-=
MEM+AF8-TABLE,
+AD4- +AD4- +AD4- vhost+AF8-user+AF8-set+AF8-mem+AF8-table, true, true) +AF=
w-
+AD4- +AD4- +AD4- +-VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-GET+AF=
8-MAX+AF8-MEM+AF8-SLOTS,
+AD4- +AD4- +AD4- +-vhost+AF8-user+AF8-get+AF8-max+AF8-mem+AF8-slots, false=
, false) +AFw-
+AD4- +AD4- +AD4- +-VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-ADD+AF=
8-MEM+AF8-REG,
+AD4- +AD4- vhost+AF8-user+AF8-add+AF8-mem+AF8-reg,
+AD4- +AD4- +AD4- +-true, true) +AFw- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+A=
F8-USER+AF8-REM+AF8-MEM+AF8-REG,
+AD4- +AD4- +AD4- +-vhost+AF8-user+AF8-rem+AF8-mem+AF8-reg, false, true) +A=
Fw-
+AD4- +AD4- +AD4-  VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8=
-LOG+AF8-BASE,
+AD4- +AD4- +AD4- vhost+AF8-user+AF8-set+AF8-log+AF8-base, true, true) +AFw=
-
+AD4- +AD4- +AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-=
LOG+AF8-FD,
+AD4- +AD4- vhost+AF8-user+AF8-set+AF8-log+AF8-fd,
+AD4- +AD4- +AD4- true, true) +AFw-
+AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-VRING+AF8-NU=
M,
+AD4- +AD4- vhost+AF8-user+AF8-set+AF8-vring+AF8-num, false, true) +AFw- +A=
EAAQA- -1520,7 +-1523,6 +AEAAQA-
+AD4- +AD4- vhost+AF8-user+AF8-set+AF8-mem+AF8-table(struct virtio+AF8-net =
+ACoAKg-pdev,
+AD4- +AD4- +AD4-         struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+AD=
s-
+AD4- +AD4- +AD4-         struct VhostUserMemory +ACo-memory +AD0- +ACY-ctx=
-+AD4-msg.payload.memory+ADs-
+AD4- +AD4- +AD4-         struct rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg+=
ADs-
+AD4- +AD4- +AD4- -       int numa+AF8-node +AD0- SOCKET+AF8-ID+AF8-ANY+ADs=
-
+AD4- +AD4- +AD4-         uint64+AF8-t mmap+AF8-offset+ADs-
+AD4- +AD4- +AD4-         uint32+AF8-t i+ADs-
+AD4- +AD4- +AD4-         bool async+AF8-notify +AD0- false+ADs-
+AD4- +AD4- +AD4- +AEAAQA- -1565,39 +-1567,13 +AEAAQA- vhost+AF8-user+AF8-s=
et+AF8-mem+AF8-table(struct virtio+AF8-net
+AD4- +AD4- +ACoAKg-pdev,
+AD4- +AD4- +AD4-                 if (dev-+AD4-features +ACY- (1ULL +ADwAPA=
- VIRTIO+AF8-F+AF8-IOMMU+AF8-PLATFORM))
+AD4- +AD4- +AD4-                         vhost+AF8-user+AF8-iotlb+AF8-flus=
h+AF8-all(dev)+ADs-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- -               free+AF8-mem+AF8-region(dev)+ADs-
+AD4- +AD4- +AD4- +-               free+AF8-all+AF8-mem+AF8-regions(dev)+AD=
s-
+AD4- +AD4- +AD4-                 rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4- +AD4-                 dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4- +AD4-         +AH0-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- -       /+ACo-
+AD4- +AD4- +AD4- -        +ACo- If VQ 0 has already been allocated, try to=
 allocate on the same
+AD4- +AD4- +AD4- -        +ACo- NUMA node. It can be reallocated later in =
numa+AF8-realloc().
+AD4- +AD4- +AD4- -        +ACo-/
+AD4- +AD4- +AD4- -       if (dev-+AD4-nr+AF8-vring +AD4- 0)
+AD4- +AD4- +AD4- -               numa+AF8-node +AD0- dev-+AD4-virtqueue+AF=
s-0+AF0--+AD4-numa+AF8-node+ADs-
+AD4- +AD4- +AD4- -
+AD4- +AD4- +AD4- -       dev-+AD4-nr+AF8-guest+AF8-pages +AD0- 0+ADs-
+AD4- +AD4- +AD4- -       if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +AHs-
+AD4- +AD4- +AD4- -               dev-+AD4-max+AF8-guest+AF8-pages +AD0- 8+=
ADs-
+AD4- +AD4- +AD4- -               dev-+AD4-guest+AF8-pages +AD0- rte+AF8-zm=
alloc+AF8-socket(NULL,
+AD4- +AD4- +AD4- -                                       dev-+AD4-max+AF8-=
guest+AF8-pages +ACo-
+AD4- +AD4- +AD4- -                                       sizeof(struct gue=
st+AF8-page),
+AD4- +AD4- +AD4- -                                       RTE+AF8-CACHE+AF8=
-LINE+AF8-SIZE,
+AD4- +AD4- +AD4- -                                       numa+AF8-node)+AD=
s-
+AD4- +AD4- +AD4- -               if (dev-+AD4-guest+AF8-pages +AD0APQ- NUL=
L) +AHs-
+AD4- +AD4- +AD4- -                       VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4=
-ifname, ERR,
+AD4- +AD4- +AD4- -                               +ACI-failed to allocate m=
emory for dev-+AD4-guest+AF8-pages+ACI-)+ADs-
+AD4- +AD4- +AD4- -                       goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +AD4- -               +AH0-
+AD4- +AD4- +AD4- -       +AH0-
+AD4- +AD4- +AD4- -
+AD4- +AD4- +AD4- -       dev-+AD4-mem +AD0- rte+AF8-zmalloc+AF8-socket(+AC=
I-vhost-mem-table+ACI-, sizeof(struct
+AD4- +AD4- rte+AF8-vhost+AF8-memory) +-
+AD4- +AD4- +AD4- -               sizeof(struct rte+AF8-vhost+AF8-mem+AF8-r=
egion) +ACo- memory-+AD4-nregions, 0,
+AD4- +AD4- numa+AF8-node)+ADs-
+AD4- +AD4- +AD4- -       if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4- +AD4- -               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname,=
 ERR, +ACI-failed to allocate
+AD4- memory
+AD4- +AD4- for dev-+AD4-mem+ACI-)+ADs-
+AD4- +AD4- +AD4- -               goto free+AF8-guest+AF8-pages+ADs-
+AD4- +AD4- +AD4- -       +AH0-
+AD4- +AD4- +AD4- +-       if (vhost+AF8-user+AF8-initialize+AF8-memory(pde=
v) +ADw- 0)
+AD4- +AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-         for (i +AD0- 0+ADs- i +ADw- memory-+AD4-nregions+=
ADs- i+-+-) +AHs-
+AD4- +AD4- +AD4-                 reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+=
AFs-i+AF0AOw- +AEAAQA- -1661,11 +-1637,167
+AD4- +AD4- +AD4- +AEAAQA- vhost+AF8-user+AF8-set+AF8-mem+AF8-table(struct =
virtio+AF8-net +ACoAKg-pdev,
+AD4- +AD4- +AD4-         return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-OK+AD=
s-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-  free+AF8-mem+AF8-table:
+AD4- +AD4- +AD4- -       free+AF8-mem+AF8-region(dev)+ADs-
+AD4- +AD4- +AD4- +-       free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4- +AD4-         rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4- +AD4-         dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4- +AD4- +-       rte+AF8-free(dev-+AD4-guest+AF8-pages)+ADs-
+AD4- +AD4- +AD4- +-       dev-+AD4-guest+AF8-pages +AD0- NULL+ADs-
+AD4- +AD4- +AD4- +-close+AF8-msg+AF8-fds:
+AD4- +AD4- +AD4- +-       close+AF8-msg+AF8-fds(ctx)+ADs-
+AD4- +AD4- +AD4- +-       return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-ERR+=
ADs- +AH0-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-static int
+AD4- +AD4- +AD4- +-vhost+AF8-user+AF8-get+AF8-max+AF8-mem+AF8-slots(struct=
 virtio+AF8-net +ACoAKg-pdev +AF8AXw-rte+AF8-unused,
+AD4- +AD4- +AD4- +-                       struct vhu+AF8-msg+AF8-context +=
ACo-ctx,
+AD4- +AD4- +AD4- +-                       int main+AF8-fd +AF8AXw-rte+AF8-=
unused) +AHs-
+AD4- +AD4- +AD4- +-       uint32+AF8-t max+AF8-mem+AF8-slots +AD0- VHOST+A=
F8-MEMORY+AF8-MAX+AF8-NREGIONS+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       ctx-+AD4-msg.payload.u64 +AD0- (uint64+AF8-t)max=
+AF8-mem+AF8-slots+ADs-
+AD4- +AD4- +AD4- +-       ctx-+AD4-msg.size +AD0- sizeof(ctx-+AD4-msg.payl=
oad.u64)+ADs-
+AD4- +AD4- +AD4- +-       ctx-+AD4-fd+AF8-num +AD0- 0+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-REPL=
Y+ADs- +AH0-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-static void
+AD4- +AD4- +AD4- +-dev+AF8-invalidate+AF8-vrings(struct virtio+AF8-net +AC=
o-dev) +AHs-
+AD4- +AD4- +AD4- +-       uint32+AF8-t i+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       for (i +AD0- 0+ADs- i +ADw- dev-+AD4-nr+AF8-vrin=
g+ADs- i+-+-) +AHs-
+AD4- +AD4- +AD4- +-               struct vhost+AF8-virtqueue +ACo-vq +AD0-=
 dev-+AD4-virtqueue+AFs-i+AF0AOw-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-               if (+ACE-vq)
+AD4- +AD4- +AD4- +-                       continue+ADs-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- -free+AF8-guest+AF8-pages:
+AD4- +AD4- +AD4- +-               if (vq-+AD4-desc +AHwAfA- vq-+AD4-avail =
+AHwAfA- vq-+AD4-used) +AHs-
+AD4- +AD4- +AD4- +-                       /+ACo- vhost+AF8-user+AF8-lock+A=
F8-all+AF8-queue+AF8-pairs locked all qps +ACo-/
+AD4- +AD4- +AD4- +-                       VHOST+AF8-USER+AF8-ASSERT+AF8-LO=
CK(dev, vq,
+AD4- +AD4- +AD4- +- VHOST+AF8-USER+AF8-ADD+AF8-MEM+AF8-REG)+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-                       /+ACo-
+AD4- +AD4- +AD4- +-                        +ACo- If the memory table got u=
pdated, the ring addresses
+AD4- +AD4- +AD4- +-                        +ACo- need to be translated aga=
in as virtual addresses have
+AD4- +AD4- +AD4- +-                        +ACo- changed.
+AD4- +AD4- +AD4- +-                        +ACo-/
+AD4- +AD4- +AD4- +-                       vring+AF8-invalidate(dev, vq)+AD=
s-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-                       translate+AF8-ring+AF8-addresses=
(+ACY-dev, +ACY-vq)+ADs-
+AD4- +AD4- +AD4- +-               +AH0-
+AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +-+AH0-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-static int
+AD4- +AD4- +AD4- +-vhost+AF8-user+AF8-add+AF8-mem+AF8-reg(struct virtio+AF=
8-net +ACoAKg-pdev,
+AD4- +AD4- +AD4- +-                       struct vhu+AF8-msg+AF8-context +=
ACo-ctx,
+AD4- +AD4- +AD4- +-                       int main+AF8-fd +AF8AXw-rte+AF8-=
unused)
+AD4- +AD4-
+AD4- +AD4- The parameter is marked as unused but is actually used.
+AD4-
+AD4- I have made the corrections in the amended patch-set I will submit fo=
llowing
+AD4- this e-mail.
+AD4-
+AD4- +AD4-
+AD4- +AD4- +AD4- +-+AHs-
+AD4- +AD4- +AD4- +-       uint32+AF8-t i+ADs-
+AD4- +AD4- +AD4- +-       struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+A=
Ds-
+AD4- +AD4- +AD4- +-       struct VhostUserMemoryRegion +ACo-region +AD0-
+AD4- +AD4- +AD4- +-+ACY-ctx-+AD4-msg.payload.memory+AF8-single.region+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       /+ACo- convert first region add to normal memory=
 table set +ACo-/
+AD4- +AD4- +AD4- +-       if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4- +AD4- +-               if (vhost+AF8-user+AF8-initialize+AF8-me=
mory(pdev) +ADw- 0)
+AD4- +AD4- +AD4- +-                       goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       /+ACo- make sure new region will fit +ACo-/
+AD4- +AD4- +AD4- +-       if (dev-+AD4-mem-+AD4-nregions +AD4APQ- VHOST+AF=
8-MEMORY+AF8-MAX+AF8-NREGIONS) +AHs-
+AD4- +AD4- +AD4- +-               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname=
, ERR, +ACI-too many memory
+AD4- +AD4- regions already (+ACU-u)+ACI-,
+AD4- +AD4- +AD4- +-                                                       =
                dev-+AD4-mem-+AD4-nregions)+ADs-
+AD4- +AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       /+ACo- make sure supplied memory fd present +ACo=
-/
+AD4- +AD4- +AD4- +-       if (ctx-+AD4-fd+AF8-num +ACEAPQ- 1) +AHs-
+AD4- +AD4- +AD4- +-               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname=
, ERR, +ACI-fd count makes
+AD4- +AD4- +AD4- +- no sense
+AD4- +AD4- (+ACU-u)+ACI-, ctx-+AD4-fd+AF8-num)+ADs-
+AD4- +AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       /+ACo- Make sure no overlap in guest virtual add=
ress space +ACo-/
+AD4- +AD4- +AD4- +-       if (dev-+AD4-mem +ACEAPQ- NULL +ACYAJg- dev-+AD4=
-mem-+AD4-nregions +AD4- 0) +AHs-
+AD4- +AD4- +AD4- +-               for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-ME=
MORY+AF8-MAX+AF8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4- +AD4- +-                       struct rte+AF8-vhost+AF8-mem+AF8=
-region +ACo-current+AF8-region
+AD4- +AD4- +AD4- +- +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-                       if (current+AF8-region-+AD4-mmap=
+AF8-size +AD0APQ- 0)
+AD4- +AD4- +AD4- +-                               continue+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-                       uint64+AF8-t current+AF8-region+=
AF8-guest+AF8-start +AD0-
+AD4- +AD4- +AD4- +- current+AF8-region-
+AD4- +AD4- +AD4-guest+AF8-user+AF8-addr+ADs-
+AD4- +AD4- +AD4- +-                       uint64+AF8-t current+AF8-region+=
AF8-guest+AF8-end +AD0-
+AD4- +AD4- current+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +AD4- +-                                                       =
        +- current+AF8-region-+AD4-mmap+AF8-size - 1+ADs-
+AD4- +AD4- +AD4- +-                       uint64+AF8-t proposed+AF8-region=
+AF8-guest+AF8-start +AD0-
+AD4- +AD4- +AD4- +- region-
+AD4- +AD4- +AD4-userspace+AF8-addr+ADs-
+AD4- +AD4- +AD4- +-                       uint64+AF8-t proposed+AF8-region=
+AF8-guest+AF8-end +AD0-
+AD4- +AD4- proposed+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +AD4- +-                                                       =
        +- region-+AD4-memory+AF8-size - 1+ADs-
+AD4- +AD4- +AD4- +-                       bool overlap +AD0- false+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-                       overlap +AD0- +ACE-((proposed+AF=
8-region+AF8-guest+AF8-end +ADw-
+AD4- +AD4- current+AF8-region+AF8-guest+AF8-start) +AHwAfA-
+AD4- +AD4- +AD4- +-                               (proposed+AF8-region+AF8=
-guest+AF8-start +AD4-
+AD4- +AD4- +AD4- +- current+AF8-region+AF8-guest+AF8-end))+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-                       if (overlap) +AHs-
+AD4- +AD4- +AD4- +-                               VHOST+AF8-CONFIG+AF8-LOG=
(dev-+AD4-ifname, ERR,
+AD4- +AD4- +AD4- +-                                       +ACI-requested m=
emory region
+AD4- +AD4- +AD4- +- overlaps with another
+AD4- +AD4- region+ACI-)+ADs-
+AD4- +AD4- +AD4- +-                               VHOST+AF8-CONFIG+AF8-LOG=
(dev-+AD4-ifname, ERR,
+AD4- +AD4- +AD4- +-                                       +ACIAXA-tRequest=
ed region address:0x+ACUAIg- PRIx64,
+AD4- +AD4- +AD4- +-                                       region-+AD4-user=
space+AF8-addr)+ADs-
+AD4- +AD4- +AD4- +-                               VHOST+AF8-CONFIG+AF8-LOG=
(dev-+AD4-ifname, ERR,
+AD4- +AD4- +AD4- +-                                       +ACIAXA-tRequest=
ed region size:0x+ACUAIg- PRIx64,
+AD4- +AD4- +AD4- +-                                       region-+AD4-memo=
ry+AF8-size)+ADs-
+AD4- +AD4- +AD4- +-                               VHOST+AF8-CONFIG+AF8-LOG=
(dev-+AD4-ifname, ERR,
+AD4- +AD4- +AD4- +-                                       +ACIAXA-tOverlap=
ping region address:0x+ACUAIg- PRIx64,
+AD4- +AD4- +AD4- +-                                       current+AF8-regi=
on-+AD4-guest+AF8-user+AF8-addr)+ADs-
+AD4- +AD4- +AD4- +-                               VHOST+AF8-CONFIG+AF8-LOG=
(dev-+AD4-ifname, ERR,
+AD4- +AD4- +AD4- +-                                       +ACIAXA-tOverlap=
ping region size:0x+ACUAIg- PRIx64,
+AD4- +AD4- +AD4- +-                                       current+AF8-regi=
on-+AD4-mmap+AF8-size)+ADs-
+AD4- +AD4- +AD4- +-                               goto close+AF8-msg+AF8-f=
ds+ADs-
+AD4- +AD4- +AD4- +-                       +AH0-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-               +AH0-
+AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       /+ACo- find a new region and set it like memory =
table set does +ACo-/
+AD4- +AD4- +AD4- +-       struct rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg=
 +AD0- NULL+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8=
-MAX+AF8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4- +AD4- +-               if (dev-+AD4-mem-+AD4-regions+AFs-i+AF0-=
.guest+AF8-user+AF8-addr +AD0APQ- 0) +AHs-
+AD4- +AD4- +AD4- +-                       reg +AD0- +ACY-dev-+AD4-mem-+AD4=
-regions+AFs-i+AF0AOw-
+AD4- +AD4- +AD4- +-                       break+ADs-
+AD4- +AD4- +AD4- +-               +AH0-
+AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +-       if (reg +AD0APQ- NULL) +AHs-
+AD4- +AD4- +AD4- +-               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname=
, ERR, +ACI-no free memory
+AD4- region+ACI-)+ADs-
+AD4- +AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       reg-+AD4-guest+AF8-phys+AF8-addr +AD0- region-+A=
D4-guest+AF8-phys+AF8-addr+ADs-
+AD4- +AD4- +AD4- +-       reg-+AD4-guest+AF8-user+AF8-addr +AD0- region-+A=
D4-userspace+AF8-addr+ADs-
+AD4- +AD4- +AD4- +-       reg-+AD4-size            +AD0- region-+AD4-memor=
y+AF8-size+ADs-
+AD4- +AD4- +AD4- +-       reg-+AD4-fd              +AD0- ctx-+AD4-fds+AFs-=
0+AF0AOw-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       if (vhost+AF8-user+AF8-mmap+AF8-region(dev, reg,=
 region-+AD4-mmap+AF8-offset) +ADw- 0) +AHs-
+AD4- +AD4- +AD4- +-               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname=
, ERR, +ACI-failed to mmap
+AD4- region+ACI-)+ADs-
+AD4- +AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       dev-+AD4-mem-+AD4-nregions+-+-+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       if (dev-+AD4-async+AF8-copy +ACYAJg- rte+AF8-vfi=
o+AF8-is+AF8-enabled(+ACI-vfio+ACI-))
+AD4- +AD4- +AD4- +-               async+AF8-dma+AF8-map+AF8-region(dev, re=
g, true)+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       if (vhost+AF8-user+AF8-postcopy+AF8-register(dev=
, main+AF8-fd, ctx) +ADw- 0)
+AD4- +AD4-
+AD4- +AD4- Post-copy live-migration is broken.
+AD4- +AD4- The assumes the vhost-user message is of type SET+AF8-MEM+AF8-T=
ABLE, and so
+AD4- +AD4- assumes ctx contains a VhostUserMemory payload.
+AD4- +AD4- But here ctx contains a VhostUserMemoryRegion payload.
+AD4- +AD4-
+AD4- +AD4- Given the complexity of the patch, it is worrying that such iss=
ues are
+AD4- +AD4- overlooked.
+AD4- +AD4- What other features could be broken?
+AD4-
+AD4- Although I tested this before I have again tested Post-copy live migr=
ation
+AD4- successfully with qemu using the following steps.
+AD4- - Ran dpdk-testpmd while enabling poctcopy migration as option.
+AD4- - Ran two instances of qemu, source and destination. Source was runni=
ng
+AD4- alpine linux while destination was started with option +ACI--incoming=
 defer+ACI-
+AD4- - I did an add memory region at the source VM which invoked
+AD4- vhost+AF8-postcopy+AF8-register function. After this I did the same a=
dd memory region
+AD4- for destination VM.
+AD4- - The +ACI-post+AF8-copy+AF8-register+ACI- debug messages which I add=
ed in this upcoming
+AD4- patch-set were correctly seen on the testpmd console.
+AD4- - Following this I turned on migrate capabilities on source and desti=
nation VMs
+AD4- at qemu prompt. For destination VM I also set the incoming migration =
to TCP
+AD4- port 4444.
+AD4- - Set the +ACI-migrate+ACI- destination to host 127.0.0.1 TCP port 44=
44 and invoked
+AD4- command +ACI-migrate+AF8-start+AF8-postcopy+ACI-
+AD4-
+AD4- After the above steps, the Alpine Linux VM memory pages were correctl=
y
+AD4- migrated to destination VM. I would be happy to share console logs of=
 the
+AD4- above test and step by step commands.
+AD4-
+AD4- Source code clarification: In the function vhost+AF8-user+AF8-add+AF8=
-mem+AF8-reg we
+AD4- provide the argument of a single region of type +ACI-VhostUserMemoryR=
egion+ACI- in
+AD4- the message payload. This single memory region is then converted to t=
ype
+AD4- rte+AF8-vhost+AF8-mem+AF8-region (variable reg line+ACM-1761) and the=
n added to the list of
+AD4- memory regions using the call vhost+AF8-user+AF8-mmap+AF8-region(line=
+ACM-1779). By the
+AD4- time, vhost+AF8-user+AF8-postcopy+AF8-register(line+ACM-1794) is call=
ed, the newl added region
+AD4- is part of the +ACI-dev+ACI- structure.
+AD4-
+AD4- +AD4-
+AD4- +AD4- +AD4- +-               goto free+AF8-mem+AF8-table+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       dev+AF8-invalidate+AF8-vrings(dev)+ADs-
+AD4- +AD4- +AD4- +-       dump+AF8-guest+AF8-pages(dev)+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-OK+A=
Ds-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-free+AF8-mem+AF8-table:
+AD4- +AD4- +AD4- +-       free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4- +AD4- +-       rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4- +AD4- +-       dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4- +AD4-         rte+AF8-free(dev-+AD4-guest+AF8-pages)+ADs-
+AD4- +AD4- +AD4-         dev-+AD4-guest+AF8-pages +AD0- NULL+ADs-
+AD4- +AD4- +AD4-  close+AF8-msg+AF8-fds:
+AD4- +AD4- +AD4- +AEAAQA- -1673,6 +-1805,44 +AEAAQA- vhost+AF8-user+AF8-se=
t+AF8-mem+AF8-table(struct virtio+AF8-net
+AD4- +AD4- +ACoAKg-pdev,
+AD4- +AD4- +AD4-         return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-ERR+A=
Ds-  +AH0-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +-static int
+AD4- +AD4- +AD4- +-vhost+AF8-user+AF8-rem+AF8-mem+AF8-reg(struct virtio+AF=
8-net +ACoAKg-pdev +AF8AXw-rte+AF8-unused,
+AD4- +AD4- +AD4- +-                       struct vhu+AF8-msg+AF8-context +=
ACo-ctx +AF8AXw-rte+AF8-unused,
+AD4- +AD4-
+AD4- +AD4- pdev and ctx are actually used.
+AD4-
+AD4- I have made the corrections in the amended patch-set I will submit fo=
llowing
+AD4- this e-mail.
+AD4-
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- +AD4- +-                       int main+AF8-fd +AF8AXw-rte+AF8-=
unused) +AHs-
+AD4- +AD4- +AD4- +-       uint32+AF8-t i+ADs-
+AD4- +AD4- +AD4- +-       struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+A=
Ds-
+AD4- +AD4- +AD4- +-       struct VhostUserMemoryRegion +ACo-region +AD0-
+AD4- +AD4- +AD4- +-+ACY-ctx-+AD4-msg.payload.memory+AF8-single.region+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       if (dev-+AD4-mem +ACEAPQ- NULL +ACYAJg- dev-+AD4=
-mem-+AD4-nregions +AD4- 0) +AHs-
+AD4- +AD4- +AD4- +-               for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-ME=
MORY+AF8-MAX+AF8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4- +AD4- +-                       struct rte+AF8-vhost+AF8-mem+AF8=
-region +ACo-current+AF8-region
+AD4- +AD4- +AD4- +- +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-                       if (current+AF8-region-+AD4-gues=
t+AF8-user+AF8-addr +AD0APQ- 0)
+AD4- +AD4- +AD4- +-                               continue+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-                       /+ACo-
+AD4- +AD4- +AD4- +-                        +ACo- According to the vhost-us=
er specification:
+AD4- +AD4- +AD4- +-                        +ACo- The memory region to be r=
emoved is
+AD4- +AD4- +AD4- +- identified by its guest
+AD4- +AD4- address,
+AD4- +AD4- +AD4- +-                        +ACo- user address and size. Th=
e mmap offset is ignored.
+AD4- +AD4- +AD4- +-                        +ACo-/
+AD4- +AD4- +AD4- +-                       if (region-+AD4-userspace+AF8-ad=
dr +AD0APQ- current+AF8-region-
+AD4- +AD4-guest+AF8-user+AF8-addr
+AD4- +AD4- +AD4- +-                               +ACYAJg- region-+AD4-gue=
st+AF8-phys+AF8-addr +AD0APQ-
+AD4- +AD4- +AD4- +- current+AF8-region-
+AD4- +AD4- +AD4-guest+AF8-phys+AF8-addr
+AD4- +AD4- +AD4- +-                               +ACYAJg- region-+AD4-mem=
ory+AF8-size +AD0APQ- current+AF8-region-+AD4-size) +AHs-
+AD4- +AD4- +AD4- +-                               if (dev-+AD4-async+AF8-c=
opy +ACYAJg- rte+AF8-vfio+AF8-is+AF8-enabled(+ACI-vfio+ACI-))
+AD4- +AD4- +AD4- +-                                       async+AF8-dma+AF=
8-map+AF8-region(dev, current+AF8-region, false)+ADs-
+AD4- +AD4- +AD4- +-                               dev+AF8-invalidate+AF8-v=
rings(dev)+ADs-
+AD4- +AD4- +AD4- +-                               free+AF8-mem+AF8-region(=
current+AF8-region)+ADs-
+AD4- +AD4- +AD4- +-                               dev-+AD4-mem-+AD4-nregio=
ns--+ADs-
+AD4- +AD4- +AD4- +-                               return RTE+AF8-VHOST+AF8=
-MSG+AF8-RESULT+AF8-OK+ADs-
+AD4- +AD4- +AD4- +-                       +AH0-
+AD4- +AD4- +AD4- +-               +AH0-
+AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +-       VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +=
ACI-failed to find region+ACI-)+ADs-
+AD4- +AD4- +AD4- +-       return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-ERR+=
ADs- +AH0-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4-  static bool
+AD4- +AD4- +AD4-  vq+AF8-is+AF8-ready(struct virtio+AF8-net +ACo-dev, stru=
ct vhost+AF8-virtqueue +ACo-vq)  +AHs-
+AD4- +AD4- +AD4- --
+AD4- +AD4- +AD4- 2.43.0
+AD4- +AD4- +AD4-

