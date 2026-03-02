Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98E0EB362C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 19:06:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6FED40A76;
	Mon,  2 Mar 2026 20:06:26 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 46A664028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 20:06:25 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 622IElvf1998263; Mon, 2 Mar 2026 11:06:24 -0800
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022098.outbound.protection.outlook.com [52.101.43.98])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cm0rmc933-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 11:06:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrG4MyfSy3QZW42UfFRCYoRr7epypENlQ4iDtk+sDWgD3jCkhuZF9bH2MzrkptgD41dGSBF7rdXQj7HD4ZVqjKLreOfHUo+eqHOxcQ2qV03uegaoWN6bNjhSDDqW3INQpC73GCecQwhwMjTKd1S8UoyzNWwdMmjzObDHkVsnbfgfOKUih7P0ELxhMS933dv++dl7llkhlnQ+yf9UDzl6FKYlQZTyublSt4fFG2tkmhustlY21KHhw+SjlHUmQRXlZU29i/lgzsMMZQIK+Miw+JPTHzvz99EvXfLIVDg0N3IsftfDU22w1P2JYocfzLnkBgECaJxKDM/1tyNez7VKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiZyEIz7J+ecIRxbhJrd/WHQFeYAQ5yHvw3O4X0ismc=;
 b=IV/HKOzQUelzUAB2rf3elX3zctg1NFwBKrlcxaCq7WgwW1nUN6glRdmbtWCeuWdqCzJMamjexLHf64nz8/nZuiA5S7Vvbyu3t6umqQbkQQ1ldIYDohrkdBM84QgOLWFcDi5RbciqZ/NN6liMLAkJxtpw9wdXBRjUB6tH2YN9pWO18P0nb1VEZN586wMBmVcesM8qWx5bczQiyPltKW2o92X5rghAbDP43H5TzHG7sZImMeuNjCMJGp3/ZHzH6W+ihqsxpDcGJsrYvd2jPA4Q5eaaSvsTO8zTuqBNGGblChJgthiqNVCBNLyb7DccagI5UX6Zlx/5iVSC5LF6b1BxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiZyEIz7J+ecIRxbhJrd/WHQFeYAQ5yHvw3O4X0ismc=;
 b=KQJk2IeHxHims0QBTBXnM1sVaJnOeZolTcSBTHKqQ9vYmCSwW9ygEdcvFkdYpHvjgtXnG5XgGa8Vs7NW/7zrstmMNEIxPvzReCecXj1J6CR2o1sQcDhV3J/SS5n8srZmvfBd1vMASxAljFlkKBwJ54qY/NrgX0QOQC4CysRhPM4=
Received: from PH7PR18MB5177.namprd18.prod.outlook.com (2603:10b6:510:156::9)
 by LV8PR18MB5560.namprd18.prod.outlook.com (2603:10b6:408:18b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.11; Mon, 2 Mar
 2026 19:06:20 +0000
Received: from PH7PR18MB5177.namprd18.prod.outlook.com
 ([fe80::2781:49f8:1d96:14d8]) by PH7PR18MB5177.namprd18.prod.outlook.com
 ([fe80::2781:49f8:1d96:14d8%6]) with mapi id 15.20.9678.014; Mon, 2 Mar 2026
 19:06:19 +0000
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 Kokkilagadda <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Satha Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
Subject: RE: [EXTERNAL] [PATCH v6 1/6] common/cnxk: replace variable length
 state array
Thread-Topic: [EXTERNAL] [PATCH v6 1/6] common/cnxk: replace variable length
 state array
Thread-Index: AQHclsj9HhCOBT8jq0C+MhYP/QE3U7WbwHFw
Date: Mon, 2 Mar 2026 19:06:19 +0000
Message-ID: <PH7PR18MB5177D9FC140A12E555D8B5FDA87EA@PH7PR18MB5177.namprd18.prod.outlook.com>
References: <20260120195418.466318-1-stephen@networkplumber.org>
 <20260205175750.653353-1-stephen@networkplumber.org>
 <20260205175750.653353-2-stephen@networkplumber.org>
In-Reply-To: <20260205175750.653353-2-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR18MB5177:EE_|LV8PR18MB5560:EE_
x-ms-office365-filtering-correlation-id: 9f755be0-2227-4d4a-2a13-08de788ec984
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: Ux4yAdzsc2uLxUmMnwg16Nocj21ECJqxVAD799BhXidpYk+bKG+nDuThCTz5iflJLUcc7gnRg/coyEkaLUqkbYVma8OLayVMqLfr8VGrrJM0T9t/aSedTalFBCOBSiXsshmmdu8mfEUU/9lx1StEssdDECR+ThFT53TR/xLiE0DKDaOY9tfXToEW0ccF/UxLrvliLolZ/tv8gqRAyKBJvHtrpRSv4l6/gQFlanZ3L5xaB4XZOyqhQV5v+WS4HmP5OAE8yd9SHSwIETbieseMZ6+vNj/LFyS4X+lXQlbzofncX+p3gQ4jA/sf2UbfxKM+cVjfkMRh2jI6IG8xteZzzFXT4SsS7ObLQvu8vP8aVlXagYhA6j6btkYrATLNQX469Eljc6/Gxr07hc+N198aMn43hjpEet9gcwwGrHPTP3mLffnTLjjCWSokoH9isJuc06gFNgazPYHyOM0yPilNo81SUhtupKeAYihgTLfZW9XqdLSFz1cgoghZm1N99NHYiognIO/8gAtPTbTtOkOGY5E/IqOdRV57LHldpeJD1/cwAbeZqTELKd0604Ww4zPzrEiQpOn+HOvXVKPt+jqo1y6bFRlwMDePz+dWdHm6GQx2B1wEL3i8uEPKqoIGhiBvRXOeS0pj/63Fu2lEMpUsY1qBKQIhf1hyOrpUfWiskC0YpUUTIFQrxAc5pCH1IUMDOVolqqONDVrDu/F+IAJAvrOl/Oq7VM4JBEbAGFB/0SvU0E+2ffNv2QkSty6TOVqMuGY5vJec9NigPhcHU0chiQRikjFRijnBM4aKzMWVT50=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR18MB5177.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnB3Znc5bnhWaGxoaERSclltVC9GQkk0QWV2WmZuU0ZnWUlTNWU2N3pWRDVS?=
 =?utf-8?B?VXAzL042RjNoNFJTeHMwSStFY3RISzJYZUlLZ3RvNFV0UXhGVnNyVlcwNkxY?=
 =?utf-8?B?NHhSV2s2QktBT2haTTJESnFnaHAzU0huSGlKWVpFOG1pSElHR1pNb0psTGFV?=
 =?utf-8?B?V3JJOVdtMjY4T1Z5L2tnZHJHRDRpb3BJQkxyZlVIUEZWRXBJbUlnUjcxQzNT?=
 =?utf-8?B?QVZsYzZLY2RmZlVyeXJpRWJneGlWcjI4M0hjZXpXbTkrWWJ2SC96S2FTRzA2?=
 =?utf-8?B?VjNnemhhWDVFK09VbHZidUtXd2N4dGs0c2tVVnQ5ejdpMHRkSXlmT0REbXdr?=
 =?utf-8?B?RDlkRmYycUdTaVE3RGRVZS80OW9KQU5Ba2pQa014NmViTTNGbFU1QzArWnJ3?=
 =?utf-8?B?L1BCR0tyNWpGUkgrUmdXKzRhS0xNOFBBaEhvbHBXeUtTYUswL0lJa1BPMEFw?=
 =?utf-8?B?cURjNWN6d1VzWWpDb1Q5YUJxd05uM0lXZnNtanc3UlhVZjhpQmNtYnoxZnhT?=
 =?utf-8?B?YytvdHdZMWlDM2swdWIvMXE5SkFZaEJBeFEzajJVQ2U0TFFSemhjNlBiTGZa?=
 =?utf-8?B?Y1B1bEZKeEtablZqK01nR1gzcHUvd2owUHhSOGJmRmFqYjJBSElualkvMTVZ?=
 =?utf-8?B?dEVYV0pXOEozcUlQdkRpK1p5NDl1YnVyNUhUL1MvYW0rNUJyT3AyZERkUmlu?=
 =?utf-8?B?ckprQ2tYT1ZQdFQyOWFJR21ZMXgveFhNeVVxSGJiTmhiWktMWEpBYmUzby9P?=
 =?utf-8?B?ZC9EWlhVRVVHZWt6TnNCbTdOQkFIaUEzWGZmT3FCS2VINzlWZ0gvdUpqdFBM?=
 =?utf-8?B?clpqL3dYUnhOa2VlMExvaWxKbml0ajRUTkI3aCs4aDFIS3Q1RGlMOVFtZlY4?=
 =?utf-8?B?S3lpNUNHRmpYYmJoZ2YrRk9BMGxHOEdJT3FDQ2lnbUhNYU5zMnpldzNxVGVR?=
 =?utf-8?B?VytRaVBFUnFlUVQyTWdVL1kxOGlaYVlmNHVYVGxKMGV0RHhCYkgrcHpUdEhw?=
 =?utf-8?B?bUpWUnM2MXQ0WGFVd0pSblhMcHpBN0hIa1gzZXRDUmFtQlliNW53Nll1UFc2?=
 =?utf-8?B?VjBoVlp6OGtVSXhEMzFDNUF1NE9kM1FqSHlqRlZjL0gxRkQ2c3BXczFNSndH?=
 =?utf-8?B?NUZOMmtxUmRUSUM2eTFSckJlWHM3UWJCQ2l6MWJqNW13eTNIaks4NGFtNFJ6?=
 =?utf-8?B?NEtSYXZpNkVFSVhCNVlJUzlmbEFRVmw3TUV0WmlMaExNazRRRWhkTkZRc3RO?=
 =?utf-8?B?NWJKRVNYZ3BlY1RTT1BiTVF1K3NBdXBzZlJnU0F6eU9rQ1dGVEtsTER4N2NO?=
 =?utf-8?B?em1mTDZoWnJiNUNIQVQrT0NXYjJqNlVlN08rSjhvSUFNNHlUTkkvK2p0WExM?=
 =?utf-8?B?K1h1WGNPeG9QRGYyNnBGMnBsSWttSHZmMmR6VXVzODh4Wk9OL29CUjV0Vjdm?=
 =?utf-8?B?enJqV3pIYnkyUWFvZ1h5R2tDblBIcXFqdWxwbmF1N0VEdXFKK1hZdDVRNm91?=
 =?utf-8?B?cStKV2diTE5EL1pXNGhOb0xyVDdyN1FQWUcrUk5tYkZqVkZkeG5YRGxGR3hS?=
 =?utf-8?B?N2hpK1VOYjJxZFhIWHdXNWhSRS9lcFprRTBGOHI1Vkxmc0prUWhlM0JLMzJm?=
 =?utf-8?B?UW9nb0owaEJ5R29TeHRJc1dOL3JnZmlRaFYrM1BKRmVJK2RsWjE5RGhJYnor?=
 =?utf-8?B?QS8zQlRkNGJDL1NOYVdEelhGd3hxRzg1VTgybTRZckNrTzJFVng0VmdvVVlV?=
 =?utf-8?B?Qm94TUhnOFZMTURDdVorOERjS2N5Yjdrd2p6dllOaG45TVZnc3BXUHNvVGpt?=
 =?utf-8?B?eFBEcWF6OUt0a1lkOFdUVlk5SkxjRFhOWTMyanZXdkE0Z05TelVHY0ZCUGJu?=
 =?utf-8?B?dnQxQmxVeWV5cy9KRVptYm1POTBjdkVNVDduMXF2K2JDeVRXWWlFaytZNFpm?=
 =?utf-8?B?VGZaNTF5ZTlodzJwSXZHOEhsbU1KWkJ6R2R0dGNMenh3VjFwb0hNWjZEK1J5?=
 =?utf-8?B?di9MWDVlT25ad1dFV3RqRzJyczZWNXhPZUFuc004T0xrTWVhbitsMTFmeFdW?=
 =?utf-8?B?NnFXcXg5WUNPMG9qNDN5ZTNiQ3Z1RSt2cGxLSVlGNWRtUlkrWlNjZGhnUklt?=
 =?utf-8?B?Y01ROWtrTU5EN3NpTjVHbUxtMisrY3NvL01YOVAzakJCVGVocmZETzE1dXV1?=
 =?utf-8?B?RG1saktSN0daSSszRkZmcnQ4Tm94NUk5ejdCVXorektSYTNpU054azVnYmpt?=
 =?utf-8?B?UzVlQWJkN3dSWEdZekpKTVQvSjJxUlppUGxaU1lOWW0zV1ROMlQzTzdXKzFp?=
 =?utf-8?B?dVl6SFRrbjZkWURBZmxXTGxlR2FZSmI0N1FUaDBQSGErc3VxSFV4QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR18MB5177.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f755be0-2227-4d4a-2a13-08de788ec984
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 19:06:19.3414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3q+lAwJmMj/k8TqoTXidOO5bvfJqefdFRqoirqIuOdWX6x3LODBu34rpJJmMSxJLtlw38WEHoQijnCQas/YFYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5560
X-Proofpoint-ORIG-GUID: XqYv8UyYCT2gy02LeOnA9MdGjIxvWDPc
X-Proofpoint-GUID: XqYv8UyYCT2gy02LeOnA9MdGjIxvWDPc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0OCBTYWx0ZWRfXz0W52Xy886sK
 ejQlPMx6GRFZpbvWAaYkqAH1DomYZedCp7K5rgQf1GjLqs5iLbRQtJuqytWnOlIWCheRK5iS8eN
 Yy5WUVYjRXjAG2G0MF0pgoUHxajuzA+FGxW4MXYbORcX0sbfq8ff4OaI38+tRz23+gd0O7Ni/yU
 H8Ktv64WnkYPcIC/1VGYaXmzLDdA3Bxcv/wNplEYNe2w79VIxxgRBg0L4trOsuOvtvc2DbPCyUU
 jMjGKtKwdsMo+PQmOcF1GRh4eVABrMCgYVS4uFXYbSYXljXaBaXDMO/zonZNv3mDi1RKYOCbVAh
 s2L1JiobBOb5bqEPAUwoZXEmdQiJ+sERWjYEWoIAD5WmdGUrLflW4cMuT+d4qwfxpfXPJxESblT
 zkBOVzwgFzXw2s/L+hol3HaUe+fFwnxyIOanOMtdH/stK7AWzjonCwnpZRCTTKOnCS8k4TuE2q2
 m2IkEB6nH2VrbZb8/Kg==
X-Authority-Analysis: v=2.4 cv=ZMzaWH7b c=1 sm=1 tr=0 ts=69a5dfb0 cx=c_pps
 a=52G9BLf6iDL1HAe0xuko4Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=jZVsG21pAAAA:8 a=8rWy6zfcAAAA:8 a=lZCFCEjjHnkVpiW32X0A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=3Sh2lD0sZASs_lUdrUhf:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_04,2026-03-02_01,2025-10-01_01
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

SGkgU3RlcGhlbiwNCg0KTWlub3Igbml0IGlubGluZS4gV2l0aCB0aGF0DQoNCkFja2VkLWJ5OiBU
ZWphc3JlZSBLb25kb2ogPGt0ZWphc3JlZUBtYXJ2ZWxsLmNvbT4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3Jr
cGx1bWJlci5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA1LCAyMDI2IDExOjI2IFBN
DQo+IFRvOiBkZXZAZHBkay5vcmcNCj4gQ2M6IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5l
dHdvcmtwbHVtYmVyLm9yZz47IE5pdGhpbiBLdW1hcg0KPiBEYWJpbHB1cmFtIDxuZGFiaWxwdXJh
bUBtYXJ2ZWxsLmNvbT47IEtpcmFuIEt1bWFyIEtva2tpbGFnYWRkYQ0KPiA8a2lyYW5rdW1hcmtA
bWFydmVsbC5jb20+OyBTdW5pbCBLdW1hciBLb3JpIDxza29yaUBtYXJ2ZWxsLmNvbT47IFNhdGhh
DQo+IEtvdGVzd2FyYSBSYW8gS290dGlkaSA8c2tvdGVzaHdhckBtYXJ2ZWxsLmNvbT47IEhhcm1h
biBLYWxyYQ0KPiA8aGthbHJhQG1hcnZlbGwuY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQ
QVRDSCB2NiAxLzZdIGNvbW1vbi9jbnhrOiByZXBsYWNlIHZhcmlhYmxlIGxlbmd0aA0KPiBzdGF0
ZSBhcnJheQ0KPiANCj4gVGhlIGNpcGhlciBmdW5jdGlvbiBpcyBhbHdheXMgY2FsbGVkIHdpdGgg
aW5fbGVuID0gMTYNCj4gYW5kIHRoZXJlIGlzIGFuIGV4aXN0aW5nIGRlZmluZSBmb3IgdGhhdC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtw
bHVtYmVyLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL2NvbW1vbi9jbnhrL3JvY19hZXMuYyB8IDMg
KystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jb21tb24vY254ay9yb2NfYWVzLmMgYi9kcml2ZXJz
L2NvbW1vbi9jbnhrL3JvY19hZXMuYw0KPiBpbmRleCBkODRmZWI1NDZhLi5iYWJmMTQ5Y2NmIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2NvbW1vbi9jbnhrL3JvY19hZXMuYw0KPiArKysgYi9kcml2
ZXJzL2NvbW1vbi9jbnhrL3JvY19hZXMuYw0KPiBAQCAtMTU3LDkgKzE1NywxMCBAQCBzdGF0aWMg
dm9pZA0KPiAgY2lwaGVyKHVpbnQ4X3QgKmluLCB1aW50OF90ICpvdXQsIHVpbnQzMl90ICprcywg
dWludDMyX3Qga2V5X3JvdW5kcywgdWludDhfdA0KPiBpbl9sZW4pDQo+ICB7DQo+ICAJdWludDhf
dCBkYXRhX3dvcmRfbGVuID0gaW5fbGVuIC8gc2l6ZW9mKHVpbnQzMl90KTsNCj4gLQl1aW50MzJf
dCBzdGF0ZVtkYXRhX3dvcmRfbGVuXTsNCj4gKwl1aW50MzJfdCBzdGF0ZVtBRVNfSEFTSF9LRVlf
TEVOIC8gc2l6ZW9mKHVpbnQzMl90KV07DQpbVGVqYXNyZWVdIFRoaXMgbGluZSBuZWVkcyB0byBi
ZSBtb3ZlZCB1cCB0byBtYWludGFpbiByZXZlcnNlIHhtYXMgdHJlZS4NCg0KPiAgCXVuc2lnbmVk
IGludCBpLCByb3VuZDsNCj4gDQo+ICsJUExUX0FTU0VSVChpbl9sZW4gPD0gQUVTX0hBU0hfS0VZ
X0xFTik7DQo+ICAJbWVtY3B5KHN0YXRlLCBpbiwgc2l6ZW9mKHN0YXRlKSk7DQo+IA0KPiAgCS8q
IEFkZFJvdW5kS2V5KHN0YXRlLCB3WzAsIE5iLTFdKSAvLyBTZWUgU2VjLiA1LjEuNCAqLw0KPiAt
LQ0KPiAyLjUxLjANCg0K
