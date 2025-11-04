Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87B1CCFA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 04:25:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F5ED40651;
	Tue,  4 Nov 2025 05:25:49 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 64E03402E7
 for <dev@dpdk.org>; Tue,  4 Nov 2025 05:25:46 +0100 (CET)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3LtvnP008480;
 Mon, 3 Nov 2025 23:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=e
 cPfC3o/5VvroUWpLQj0NoqeP8rQW4EsD24pH9pNxaw=; b=mG0aBfhFOl1V0mnl/
 fAfiac6TvBACJoC9+sdBOPbImepSyJKVB/yWzO51OoI9dUZsYpZ7PM4A6dTo5sxG
 JKrpyBoRnxgOphrnwJwRXN6ivSL9kh2rAXxa+D/w+5TdE2vtwUyfszXhQytTkUfq
 ATsjnBGHu+Z7aOzrV84e9uYbQF3MAZpqHdMfrLHIHpGBq6IGGkajey0a6djo3odw
 YkHCryOIlAhGzLxp4c6iRBRIPRmR+KvzJh9BvYTEysBUWcMwFx7rzxGXag+OwTno
 HtPqoo20F0qPphUN4abF3q3CyZqHU73tSQtrUNFq5eAUIV1h1h+CXSavWg/wEK37
 kqoXw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4a5e7hjtyg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 23:25:45 -0500 (EST)
Received: from pps.filterd (m0371675.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A42pFB7007943;
 Mon, 3 Nov 2025 23:25:45 -0500
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4a5ydaqr1s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Nov 2025 23:25:44 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7bThzypfemtRsK5871bYeCkMjiFc2dmB+ciMkl1Z9H5JBlQBSebxHDinCgNKI091ZMCemPrV066Vg4jeZvA+SvSB2kE7PYBqbA+NgqtPkwhWHcY/yMep62zdbkzE56GBodHb8kjB8hfkTPqXxlkevcn8zB2HwTpTGO/Ci0F7EGicWAi5o2WqpI/0d7zfN+oIVvtdXwnAibsTg4mbv/Fh7wzvM6euIeKlpNhF/k5MFCJNYzCtZSsHtq7RRCYxBW0DXhbJHr9eqSP9lYBBWz0o4UH6INjatSeXvZcZmuDZSrlJc1OvJ4H2/nOQbk/djnqMuDTP/PlUeseUIEf3kOwWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecPfC3o/5VvroUWpLQj0NoqeP8rQW4EsD24pH9pNxaw=;
 b=OKAUxwjpz86P8y2LN/wtx/GvMsHun+JI1680n7zs+ZaefG1yFcf8zoRl5mlQ5n4MbJ7pTSz5jQVkrZHgu9COLvPPifDPEApgEGit9CXKldJCmLe6EaSsDkf14lk3BJFP3ohWQik/OL170yLiLyZZ4T9+3gDx2/om9vBUY3VaN0lodKJaElGldk6fooQznVG/LWd5NAXS2VYPzZGGsHyDleNixbSkSk4jhgaSp3OCBdYq2izhIJKVuJOXEE0VbivdBNPq/mlcG+zj8YI5anZCPMqEg7l6sg3YX74nZuOqdnb8Fu/ORpRrNT/vy/qaAgUpYG2Q+smFi4LeNT6LsOFSwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by PH7PR19MB7607.namprd19.prod.outlook.com (2603:10b6:510:26b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:25:42 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:25:41 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <mcoqueli@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pravin.m.bathija.dev@gmail.com"
 <pravin.m.bathija.dev@gmail.com>
Subject: RE: [PATCH v2 3/6] vhost: hdr file changes for add/remove mem regions
Thread-Topic: [PATCH v2 3/6] vhost: hdr file changes for add/remove mem regions
Thread-Index: AQHcODKwyjm/R2zWBUeVInwiAy00h7TC3IKAgB84iBA=
Date: Tue, 4 Nov 2025 04:25:41 +0000
Message-ID: <SJ0PR19MB460607597ED0B6A443FFAC2CF5C4A@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20251008090444.2689652-1-pravin.bathija@dell.com>
 <20251008090444.2689652-4-pravin.bathija@dell.com>
 <CAO55cswN99fw=OMjOuq_TKBTHNPHcMJEbgAqjsTEX-1FR8zYFA@mail.gmail.com>
In-Reply-To: <CAO55cswN99fw=OMjOuq_TKBTHNPHcMJEbgAqjsTEX-1FR8zYFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-11-04T04:23:06.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|PH7PR19MB7607:EE_
x-ms-office365-filtering-correlation-id: 7241a85d-0309-4bd0-4ab7-08de1b5a3719
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-7?B?QWo2VFNmbnllNjBBbk83UXlmSEJTOEVVMFlIYTI2bm55UkJhUHpzSjZGcist?=
 =?utf-7?B?bWxrKy1RSmNxeHUxSCstdmdUZ1FNOUVuZDA4V003OE5PZ1NBM2NpYlQ1NklP?=
 =?utf-7?B?OUc3WGd6b1g4Yld3bEJZS2QzOUdkQy9lQkpEQUNtZ3E3M0lNbXZuTlB0VmNj?=
 =?utf-7?B?ejlLbkFsbWluQVFFWDdsOUVKSXZwcmZtelMrLXNzKy1pN29SY3JCeXROMzY=?=
 =?utf-7?B?Ky1DNGdXZFJXczVRbVYzU256UjlpWXdJWHgybEZGOFVRbndHSmR4dFcyb0pn?=
 =?utf-7?B?ckIzVTVTemhBT2FTQm5Ya0FLUjJKdWN1SU9HKy1lY3AxdWtMaTN4OGMvOEpI?=
 =?utf-7?B?UEU4YlVRSEFwV1FBaFlNVUlWdHJ4N3hQb1k4Vk9tZUxXZTE2dXVIL1NEWXMx?=
 =?utf-7?B?UUtncWIrLXlkUDlQTVoyWkdnc1NkUFlUV3BWa1gvQUd0R3ZpV2NTTFZxaEFP?=
 =?utf-7?B?WjZPQmt0U1dlUHFrc0FDSGEyZ2VQNistNEUyNVF0YUNTVXpndystcklWVnVW?=
 =?utf-7?B?eUc1SnlMYjg4ZmQ2WHdZQTB4aUhFU3dLMDFFNS9RWFNhWllrVzRxM0NRMUww?=
 =?utf-7?B?VjJKUUFLRWxXV2dQVWpueWw4WEtTQzMwRy9iME1kc1FHa0ZkUE1WZFp2ZlhD?=
 =?utf-7?B?dVY4WjVLTkorLVhOY0pkcHltcm1PeVRCSVRCYVdsKy0vUkdrYUpXUGxRRlB2?=
 =?utf-7?B?M2V2THpHYjVKMG5MUUlmenZZdWtXU0JsVk0rLXRiMkIwcjNzUy8rLVU5c3lK?=
 =?utf-7?B?TXVVNjRuaHdoR0g5elQwMnF2ZzRFWVhwRC9KOVVWN3hDa1RDeVRVUDhSbllP?=
 =?utf-7?B?RzlpY1pJZTlxWHBPeFpMcEFBbXpHMkdCY3RkNExLaGlDSkNqanZPL0hTY0dq?=
 =?utf-7?B?b3pDSG1RNjNpckNLTUFFdjc1SjBBTm8yT3F3Q3F0bXc1WGc5end4dUlGLyst?=
 =?utf-7?B?UEI0QU8zNmhTTHFXN2lLT01HTVZmQ2F6ZU9MNzVzWlZDN3Q2RWRyeUF5YktO?=
 =?utf-7?B?ei9iMWd3RElkbkQ5YWIxYXBGa0pRQmVGZFhkV1FPR012OVl4eEpzR2kyaUdE?=
 =?utf-7?B?TXVSeExoNVN3ZDBSdGtJZ2pmekxQazNKdW4rLVlwRGE4bDZGY0I5eWhjVVh4?=
 =?utf-7?B?SmJrbjUvbFczYlByMmZhL2l0cjMzUG1ya2JVZ2lIa3pvZ2FYT25YZTNXdXJt?=
 =?utf-7?B?WUJtZHNoVnlFY0NNNkF1cERiUHV1QlZ1TUFrTWZWaUNTVWpMQXJTS2Z3NElp?=
 =?utf-7?B?VGh5Y2VVeXA1Tk1nLy9lSWhzRVAwNGI3YlMvbWwyMistKy1GMzgzTmdBR2FK?=
 =?utf-7?B?eHNzOUZRNDFnL2tnOSstdHBCQjRKemkvcFNiWGxlOW5ndU9aQldlR1JObWhK?=
 =?utf-7?B?OWk3MlZzWHhrbFhWSXpCQmdhKy1rbEVDbzYxTDI2TjlENU9ENzA1OFU5Ky1R?=
 =?utf-7?B?TXVuKy1VbGRnbHlxVFVaVkhnY1MzeDZ5QmUzYzdZTjI0dVlib3ZUNDExVFJo?=
 =?utf-7?B?UTZvSGJPRU52N0o0d0lmcFRsZ29SY3VPTkhIZ2JIZkh6dSstblZzeTFXYXdT?=
 =?utf-7?B?R1NwVUhCbWRvYS9JeWsyN1o4VktJdy9ialFTRGQ2aEUxQVRHY01PTzVlODFJ?=
 =?utf-7?B?Wm5YM0dNTnVWdU02SlNJOFk0c2MzZ2lvNjljRjNLVk1pMVA3bXZnL2pDU1M4?=
 =?utf-7?B?VzdXVm5Cdkg4M2xPeEF3SmdGYlk4RzUrLXhUQUtsenhxNzZWWTQwZG9xQko1?=
 =?utf-7?B?SERiOGVldC9jTVhjTjN1UlBkSE9ZR3V3R1hHSmZxUHQxVktDTGpwMHdMM212?=
 =?utf-7?B?MW9pSkZDa292ZTFiYUhsVVI5WXZFSnpvbHorLVlLWnp3S0c0Nk9ubzFmcmtF?=
 =?utf-7?B?dHE3dFQzcWF6ejVxTXZIM2tEamNCZnloS2hzWUJwVlVSS0RZY21SNlk5N2Zx?=
 =?utf-7?B?MUJmU2FTVDlka0VCM0pYbmErLWY1TTVXWDBib0VCb1JHcjBOSVhJWFk3bk0=?=
 =?utf-7?B?aCstdGd1b093TkhUTnl6ZCstYklQMVVmeUdiM0lRamx5YVQ0T0pWMklMZXY1?=
 =?utf-7?B?bmFkT1FQUUFZU1ZQbGxNYmM0SldRcjhmbXI0VG5PU1FBaFBm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?MTFkempnSm5YbDVRanZKZ3J5dXB3eGlRRkNiMWYxV3M1NkthdXlsYUpzOXF2?=
 =?utf-7?B?bXZRbWJiZzh0WTU1bm4zT2Z3OGxpT2V4Z1dEZk5rR0kvSHE2dC9QWG5wdGFz?=
 =?utf-7?B?bnZzWDFZb2FON0tVcTM5Rllud2dEd3lDMXNvb0pramR3L29EcWdVYWd5Qm85?=
 =?utf-7?B?eGptR0FZY1Q3c2ZEd1JBRHdhd0VOVHN6MnE2V2ZzY0lPN3VjZi96T2VGci81?=
 =?utf-7?B?a2JOS1h0OHVseWJiNTZYZTNYMTZGSzNzcDdVTVE4YjlzQW83SmgxT0hEbkxn?=
 =?utf-7?B?ZXFIQThsbWpSdmN5Mkc2Z1F1dDZkNjdyWDJDS3A0QXpxVE91NDVIdWt4VTZU?=
 =?utf-7?B?anhEbFBnTVlZZmI2SSstc1dlMUdzcG5MNFpNSnVkNlZjSistcWx4a0ZCdnZq?=
 =?utf-7?B?SjZTdnM5VzZzWGMwTkNWNVVvdE13Y21uN3p4NndFNkZvZlpYTlRYWkxGU1lK?=
 =?utf-7?B?NXpNWGg0cXl4ZUxNN1psRTR4YllXb2tDeHRyRC9iUDZLZVEwb01MYU9XWGpL?=
 =?utf-7?B?anBTZlliNTU3T0t2U1JNaHBsRGxJeHhDZ09EdDkxckpwdWlKZkdGV3ZtTXRu?=
 =?utf-7?B?N1JudmJkTEUrLTZZd3BjeXU3VEZyNzU2MnJDdk9uRWJZSlFyYkZqdkFiM28v?=
 =?utf-7?B?c3ZKTWowTXA4M2t6MUVYZ2RSM1dvanRpcXpRa0pOQTI3OEF2MXY4ZHBianQ1?=
 =?utf-7?B?REVENDJBcFZxQkFIUSstbSstWVQ5TExPNFlUUmtMZi9mSVJsRG1IRystTko=?=
 =?utf-7?B?QWdQKy1CWlM4MmkwQ2VuUS9pYmVlaEJSbzJpOFpOZWcrLUJ5bldYdVhOYW5K?=
 =?utf-7?B?eVZ1Nk13d0xlUnp4ZXFRMVpYL3IrLVRDQVdYM1ROcUNOdEdmQjQ0RmpBSUZB?=
 =?utf-7?B?bDlMZE8rLXBiandMeS9CUFJaUmFBL2MwaUxmb0hPOGZ5bWNWc1lKbkdoQlBK?=
 =?utf-7?B?Q0JkTDNwNW9UVnhheSstdnlWM0FoTVVJRm50cE9JaWNzbkMyT3Z1TC83WXda?=
 =?utf-7?B?WnFETzhlTC9UeGY5ejBEZXlSc1BYVjZERGNDRHVVYWgwMGpJUW1OTzExcDd0?=
 =?utf-7?B?dGpvWWFOM0lac0UzRExaVE9sVE4zN2hTVzhyMkdkY0d5aktUMVN6aXFxMFpq?=
 =?utf-7?B?U1djblJabXRzS295cjlKckFxUWVVOTNuSTdRM081NnJQUXB5SUdTUVZWL2dD?=
 =?utf-7?B?NXRiaU5SWURiNVZOSlRKV1hoNFVTKy04RXZvZTVLenNWdnFwMEdxcUkyQlBS?=
 =?utf-7?B?SHhVekdvZldPSE96Y3p0RkRVdlpTd2VHNVJjQVRBY0JLMVBTMDlxamFRNFB4?=
 =?utf-7?B?SkNtc2MrLVRWQ2FJN2hIOU9LRjZnY0xUTEpkTCstdXNYUVViem9Sb3FTWXpu?=
 =?utf-7?B?eVdITUttOWhJdDArLVRET25qMnlQR0thdUNvVlRDcXBUZTkrLVM3OUNkaSst?=
 =?utf-7?B?ZndkOGRyUUNTN0QzMXdweVF6aFpVWWxnUHlvOGwyY0xoTEpMbjNJUmN5WFBK?=
 =?utf-7?B?cFEwSkZYTmRQOFlLVk9aUTh3TEg2NzJVRlg0R3crLWlLV1FmNGdTbnFEU1U4?=
 =?utf-7?B?MlUvdVAzUktYNlFjREptdDBvbnhGU1ZxanV3SDdZS3dkcGIvRmY2dTVlYjhR?=
 =?utf-7?B?NlRqVDI3YTlVZEpFUUtsR2JlSWVybXVuKy1FM2dFOXFsaXB1dG9VRTQwOTlz?=
 =?utf-7?B?UlJVVzNnSFFITk5UZ1FuZDVhRjhuSTQ3REE4ZkpXZXk1anhwTTdwTk95N3pM?=
 =?utf-7?B?V3RpTkMzQUxrcDJJL1NMMTRPYzMwRHNxbE5TTWsvaXhJa2N4MFBhc05uQlZt?=
 =?utf-7?B?NmlmMHpLbTJwbzJRdlBUNDY4dFpKcjZTT2VGcXByOXYyZjBGblFGTG13VWdv?=
 =?utf-7?B?WkJUUFdVQ0xhaG9hb3F6NFRCaWJVTUhjd01hWm9IUW9uTG96ZXhHSTdiVzhk?=
 =?utf-7?B?VG1LbEtjUHlmcmxPbFo3cXFaUy9XY2ZkZVIzTWZVb1RadHlZNEszRjdSeTRx?=
 =?utf-7?B?ckpRS2czYllRQ2RUWGs4TmN6bHRKSGRGUXl6U1VxUzlUdisteGZXMDNHRlE4?=
 =?utf-7?B?THhKMVdiUDhVTVdMQk5yS3R1VERVN1JYRUZmbVRjTG1vcFp0cSstYnYxUGNx?=
 =?utf-7?B?aHNCQXE3SXY1aUd3RWk3TU1qam9HWmFQUUNLbFhJcFpYQWxrYTJxOW8vM04w?=
 =?utf-7?B?Tlc=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7241a85d-0309-4bd0-4ab7-08de1b5a3719
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:25:41.8478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxCLlt/X9h8Us/WRr9V3a0HKeHQSpdckw4yTARMtGKPnFoCs26I/fxt7tU/FnKv+HFb4YAgLoC4EvcPjZUKtJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511020029
X-Proofpoint-GUID: yMx9OfnHz0kvegNNoT13CbUBvE7p_rvh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDA2NiBTYWx0ZWRfX/XNoFhof7SiY
 Mj28lHNNVnZmADwGuWWb1J37hqziW79cJG0/P5MJqt7tAuqpKBWP0sdq/EUnh8PpTWA+3irYtXd
 HkyzKA50gPdxq4J2qlflZDXXvUKrZ2V9OfoaPTwo/89rgp1vmlkL5LZRxKBSpid9Df2w6bo4dZR
 YvzcwdHDtqx4I1AXWeFD4VMiuoriRY02OtHyCQ+4QVO/kJGSiRrwG//xkyhtFY+9f6V33ZG4fdl
 g3H20/33wHopPiBfWL1cy7cr77aKQ7SkkoL27Ve3mrS7XgBzxdMObT4nH6/4W2Be8w54Wge/EHQ
 82zcJwDJ01VJnO+NJ2c4b6f2YLTy6wJF0u20bbC6WCJKVXGL1xREH9+q1vSxmYntk5Pys99wJQB
 CN8efsFoMZ+Wi12fYKoplaYZ3AFgeQ==
X-Authority-Analysis: v=2.4 cv=WKtyn3sR c=1 sm=1 tr=0 ts=69098049 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8
 a=XlRjxQ70AAAA:8 a=LfxEVeEBAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8
 a=wmmDbB_4dZYEeyRjpwIA:9 a=avxi3fN6y70A:10 a=gbU3OgOOxF9bX48Letew:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=1uMOUU2w0DxzEe95gQqD:22 a=7k9nRlTqVbDGZ3p5_T00:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22
X-Proofpoint-ORIG-GUID: yMx9OfnHz0kvegNNoT13CbUBvE7p_rvh
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010066
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

Answers inline.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Maxime Coquelin +ADw-mcoqueli+AEA-redhat.com+AD4-
+AD4- Sent: Wednesday, October 15, 2025 12:37 AM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4-
+AD4- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.com
+AD4- Subject: Re: +AFs-PATCH v2 3/6+AF0- vhost: hdr file changes for add/r=
emove mem
+AD4- regions
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- On Wed, Oct 8, 2025 at 11:05+IC8-AM Pravin M Bathija +ADw-pravin.bath=
ija+AEA-dell.com+AD4-
+AD4- wrote:
+AD4- +AD4-
+AD4- +AD4- +ACo- add enums to vhost user request for add/remove
+AD4- +AD4-   memory region support
+AD4- +AD4- +ACo- data structure that defines single memory region
+AD4- +AD4- +ACo- increase max memory regions from 8 to 128
+AD4- +AD4- +ACo- 128 add/remove regions tested with qemu virtio with
+AD4- +AD4-   testpmd vhost.
+AD4-
+AD4- The commit message has to be full sentences, explaining the changes b=
ut more
+AD4- importantly the purpose of the patch.
+AD4-
+AD4- For the title, it should not contain variable names or abbreviations.
+AD4-
+AD4- This comment applies here and to other patches of the series.
+AD4-

I have made the changes as you suggested  in the latest patch-set I sent ov=
er.

+AD4- +AD4- Signed-off-By: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.co=
m+AD4-
+AD4- +AD4- ---
+AD4- +AD4-  lib/vhost/vhost+AF8-user.h +AHw- 12 +-+-+-+-+-+-+-+-+-+-+--
+AD4- +AD4-  1 file changed, 11 insertions(+-), 1 deletion(-)
+AD4- +AD4-
+AD4- +AD4- diff --git a/lib/vhost/vhost+AF8-user.h b/lib/vhost/vhost+AF8-u=
ser.h index
+AD4- +AD4- ef486545ba..c6ad5b76d6 100644
+AD4- +AD4- --- a/lib/vhost/vhost+AF8-user.h
+AD4- +AD4- +-+-+- b/lib/vhost/vhost+AF8-user.h
+AD4- +AD4- +AEAAQA- -11,7 +-11,7 +AEAAQA-
+AD4- +AD4-
+AD4- +AD4-  /+ACo- refer to hw/virtio/vhost-user.c +ACo-/
+AD4- +AD4-
+AD4- +AD4- -+ACM-define VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS 8
+AD4- +AD4- +-+ACM-define VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS 128
+AD4- +AD4-
+AD4- +AD4-  +ACM-define VHOST+AF8-USER+AF8-NET+AF8-SUPPORTED+AF8-FEATURES =
+AFw-
+AD4- +AD4-         (VIRTIO+AF8-NET+AF8-SUPPORTED+AF8-FEATURES +AHw- +AFw- =
+AEAAQA- -32,6 +-32,7 +AEAAQA-
+AD4- +AD4-                                          (1ULL +ADwAPA-
+AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-BACKEND+AF8-SEND+AF8-FD) +AHw- =
+AFw-
+AD4- +AD4-                                          (1ULL +ADwAPA-
+AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-HOST+AF8-NOTIFIER) +AHw- +AFw-
+AD4- +AD4-                                          (1ULL +ADwAPA-
+AD4- +AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-PAGEFAULT) +AHw- +AFw-
+AD4- +AD4- +-                                        (1ULL +ADwAPA-
+AD4- +AD4- +- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-CONFIGURE+AF8-MEM+AF8-=
SLOTS) +AHw- +AFw-
+AD4-
+AD4- It should only be enabled once the feature works, so likely as the la=
st patch of
+AD4- this series.
I have sent out the patch for increasing number of memory regions as last p=
atch in the patch-set as you suggest.

+AD4-
+AD4- +AD4-                                          (1ULL +ADwAPA-
+AD4- +AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-STATUS))
+AD4- +AD4-
+AD4- +AD4-  typedef enum VhostUserRequest +AHs-
+AD4- +AD4- +AEAAQA- -67,6 +-68,9 +AEAAQA- typedef enum VhostUserRequest +A=
Hs-
+AD4- +AD4-         VHOST+AF8-USER+AF8-POSTCOPY+AF8-END +AD0- 30,
+AD4- +AD4-         VHOST+AF8-USER+AF8-GET+AF8-INFLIGHT+AF8-FD +AD0- 31,
+AD4- +AD4-         VHOST+AF8-USER+AF8-SET+AF8-INFLIGHT+AF8-FD +AD0- 32,
+AD4- +AD4- +-       VHOST+AF8-USER+AF8-GET+AF8-MAX+AF8-MEM+AF8-SLOTS +AD0-=
 36,
+AD4- +AD4- +-       VHOST+AF8-USER+AF8-ADD+AF8-MEM+AF8-REG +AD0- 37,
+AD4- +AD4- +-       VHOST+AF8-USER+AF8-REM+AF8-MEM+AF8-REG +AD0- 38,
+AD4- +AD4-         VHOST+AF8-USER+AF8-SET+AF8-STATUS +AD0- 39,
+AD4- +AD4-         VHOST+AF8-USER+AF8-GET+AF8-STATUS +AD0- 40,
+AD4- +AD4-  +AH0- VhostUserRequest+ADs-
+AD4- +AD4- +AEAAQA- -91,6 +-95,11 +AEAAQA- typedef struct VhostUserMemory =
+AHs-
+AD4- +AD4-         VhostUserMemoryRegion regions+AFs-VHOST+AF8-MEMORY+AF8-=
MAX+AF8-NREGIONS+AF0AOw-
+AD4- +AD4-  +AH0- VhostUserMemory+ADs-
+AD4- +AD4-
+AD4- +AD4- +-typedef struct VhostUserSingleMemReg +AHs-
+AD4- +AD4- +-       uint64+AF8-t padding+ADs-
+AD4- +AD4- +-       VhostUserMemoryRegion region+ADs-
+AD4- +AD4- +-+AH0- VhostUserSingleMemReg+ADs-
+AD4- +AD4- +-
+AD4- +AD4-  typedef struct VhostUserLog +AHs-
+AD4- +AD4-         uint64+AF8-t mmap+AF8-size+ADs-
+AD4- +AD4-         uint64+AF8-t mmap+AF8-offset+ADs-
+AD4- +AD4- +AEAAQA- -186,6 +-195,7 +AEAAQA- typedef struct +AF8AXw-rte+AF8=
-packed+AF8-begin VhostUserMsg +AHs-
+AD4- +AD4-                 struct vhost+AF8-vring+AF8-state state+ADs-
+AD4- +AD4-                 struct vhost+AF8-vring+AF8-addr addr+ADs-
+AD4- +AD4-                 VhostUserMemory memory+ADs-
+AD4- +AD4- +-               VhostUserSingleMemReg memory+AF8-single+ADs-
+AD4- +AD4-                 VhostUserLog    log+ADs-
+AD4- +AD4-                 struct vhost+AF8-iotlb+AF8-msg iotlb+ADs-
+AD4- +AD4-                 VhostUserCryptoSessionParam crypto+AF8-session+=
ADs-
+AD4- +AD4- --
+AD4- +AD4- 2.43.0
+AD4- +AD4-

