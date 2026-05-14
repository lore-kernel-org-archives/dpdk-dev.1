Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8930CD4F21
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 02:05:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF03C402AA;
	Thu, 14 May 2026 04:05:43 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 7D8364025E
 for <dev@dpdk.org>; Thu, 14 May 2026 04:05:41 +0200 (CEST)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E1U1a13539329; Wed, 13 May 2026 22:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=t
 nOIwt685/C1ros02TXppaurxir24jlf/YEtvPj6zaE=; b=N0bDvcsEfyARAtusl
 j65X03botksF2yLpxxjIHtzFANqDid2LROgXDQemZhoIdxojntJkHaJ+xwy2i0f+
 3FB7ZZpIR5R8tqFhLBYHlCd53taS0YJdtYCZbjd3Ebycp6K0y5BQWibfWVbLRqtq
 QfhGu6JhnwspgNfycMuMx8Kho1rVgUTmM1LYzmK/p96zZ7esi8C/T1m954gBgjtm
 QO/NvJVj9EQdaP85rzk9Wmz3RAkqNRj0jEfs0x5gYqJxOyGSaopfuPT6CcD9zZDG
 6YLnIBt0FqQ7R42AhZ2cJ0ovAtjgO53jgWKVLearqgxNdLctVurCNNFghTqpFkJU
 5qmGA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4e3nv0kubx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 13 May 2026 22:05:40 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E1Y3ir2077192; Wed, 13 May 2026 22:05:39 -0400
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e54ue096v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Wed, 13 May 2026 22:05:39 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTe7Jvy0DKigJZoBTfjc9/iTDHuLuljsyTcavPOA6pWpYpoF0av5jriHivDPNRdXQz4niBB7xwmGrV1Nby4zwDVFmr0DocC5ugyHM49bNlIe9qeQI7QgHKV2Od1VqkrRL20g1S1NzJGkkoBwpj9lyoW67SlxN+tA1YMIOCN5NjO3118eKEZJoezRwq2/659JdDS6vw3rWoQB6/yaPbLMuLppU+kSavt8xnkjLOQiX0C7xxNOtx4sATO0+y9bp7HYYXQOfpxcU2KjpDnak3nRyCeyyPig/oMwaT3Buot9Y6h9UvOFWMSsSeaLUCv5Da/zBfuOFV8Tr/pC5ZsE0O89gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnOIwt685/C1ros02TXppaurxir24jlf/YEtvPj6zaE=;
 b=M1A9haXxsDPgJi2XIvJRjwVaSFoATLtOp5K0tV7G0HZAI7QaewZeAWo9rzmKfaVIFILBGSGektVuotleRr2faMOQWhJT5O06jCTGE9lJUO8FmEamWh8ra5dAUDY7lZcg+w+NHx4iAq6lNPAFRehjGMibKOuO6XQDQde0yMvfydm1xcMBNgVnGNdIZXgq8kDgh2AZZ9ADYpGhVjvNtdRAHFNjxEeuuMk5jbg43ca+4WKmfrez/sAzPQhd47C1L6sp4d7RNE5TLuKmehl4ASn04II5QPfwqnqQNl/Q6GFZicejFHy45G21GT2s6o3843cgBAcQbisH+W/+UFt75WVm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB3564.namprd19.prod.outlook.com (2603:10b6:5:1dc::21)
 by LV3PR19MB8727.namprd19.prod.outlook.com (2603:10b6:408:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 02:05:36 +0000
Received: from DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb]) by DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb%4]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 02:05:36 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>
CC: "thomas@monjalon.net" <thomas@monjalon.net>
Subject: RE: [PATCH v12 2/5] vhost_user: header defines for add/rem mem region
Thread-Topic: [PATCH v12 2/5] vhost_user: header defines for add/rem mem region
Thread-Index: AQHc3Qm/7mLxaI7b4kmJRtq5ecdhOrYLRriAgAGK1KA=
Date: Thu, 14 May 2026 02:05:36 +0000
Message-ID: <DM6PR19MB35642E3B7E89F96D7DBAF851F5072@DM6PR19MB3564.namprd19.prod.outlook.com>
References: <20260506033733.972952-1-pravin.bathija@dell.com>
 <20260506033733.972952-3-pravin.bathija@dell.com>
 <ef49146b-429f-484a-83b9-0ab3de0a28f1@huawei.com>
In-Reply-To: <ef49146b-429f-484a-83b9-0ab3de0a28f1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-05-14T02:03:09.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB3564:EE_|LV3PR19MB8727:EE_
x-ms-office365-filtering-correlation-id: af580bde-80a5-4620-d78d-08deb15d4a1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|786006|376014|366016|1800799024|22082099003|18002099003|38070700021|11063799003|56012099003|4143699003;
x-microsoft-antispam-message-info: egYJI9DlRjLSAmhuX0V56R167iXE4AUzdNECpT3dz+xHLv+RkalXqCFfclSimuT0oYBcDPJZspFVMMpG/d156ff0vu2XJvJ+Xnc2Kmm4sg8CEOmzmEUIhKMnWj+AypFNyocPOd+QuubC5kK1JZR35l3fPCz8qU8dKVS7ujuPXVhgLDXEVdq7Z1VSiq/18cHvthcLjoj0AmC0cPVc9TQDsN+XLWzbGueLQDmYM2CiRYFdITeanhyUpG1Exjkgjt8ggYw2jvx7wlYvmpeUoxKGp6Hw7Amm6F9UmMOuTjdmsxH3xrsNuAbG6o1dYsuzDjBWxuAEGiIpv2shklifg6uD7DDGnyHK+QHtVKVRZx3HbhTnklsELEIFqDPdXOGvDkUn/fTEx7T++rf9MqH3GGHS3Qvg0QmCwb8tduyhhcTD6bEVt9p89RMROSxetjlRxAJVwJN6SZafzsYjpMAXzqUPjmO8hOTbssRjSykQeAixHv0EMSDM4Qlslz2QHAQqQh6RAPiS4x8EdtDj1fLP26qjtGukaLWGJKB+uQHPyyIowoiVC3EbjKZI2ojq50qEK+HwPe0c7xJOc34kY99JnYHISRPi9x3DrsoMPgBjbIrcaAx2Hjq01q7hyMLm998EBne46Y8dIb9zqBM35+z9ebVpgN4RC0l4KrPzDMhgvcB1U00Dfe8D/VKQUM0+4HPdKSJ3LZ8hjsheTIq0sqpbjL5oXlIw5z2qXkQTDVDms9W1uw3NCOEgeyyGLcxxJThwD/vW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB3564.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(376014)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(11063799003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjBvMHE0N3lKSnVqSW5ibFl6KzYwRHY4MWVHM2w5RzNCQXhQTkc3STUreHI4?=
 =?utf-8?B?SXNsWVNaMUdFcEQ1d0VXM3czWTd5VjVFV2NWSXhjUHViSFhiNDgrdG5qU1dU?=
 =?utf-8?B?UDJQQWROTVNjU1dnZ0tINmJEd2RyN1cxcHFrcm9iZERJa2k5U2pQU0lMQlVm?=
 =?utf-8?B?OUk5TTU2VndyQ1BtdEN1OHdaZXY0ZVNHL2NKbG1wQ09Ec3N3a09sY013OHJj?=
 =?utf-8?B?ZkIxd0ZuM2VEUmpPeVY0NitCRDN5ZVdoeEpRSjBEVUVaZmMvb2ZPbWgwOW5Z?=
 =?utf-8?B?N0lxbVpkWmM0ejQ2NFN4ZDdSRitBSUFONFVHNnpCa0ExbjVQaE05TmpaOE1R?=
 =?utf-8?B?Vm1saENuM3NZeEV1UVlzRzQxamlObG5WNGk4UHQ4bm1tcHFkT2hwelgrQXdq?=
 =?utf-8?B?LzVYczlDTWdoSGFOQkNydWxGY3VMMFozeldFamZPSHl2TVh0ZW5CdmI0RHJl?=
 =?utf-8?B?eVg0QW83TnpzMVIxaEkzU3ZqVXRTL2Z5R3BQZjVwa1ZYQWdYVEh1aWRlR2g0?=
 =?utf-8?B?cXdheWtWUEhnZkNSOENKc094K1JuMUxwbHYyWm5yVStPcmV6Tm1OZkxsZUtP?=
 =?utf-8?B?dStMdGRBYjErUGE3MEtpYmc3d0kzenpUbHROVnBDYi9URGNJdXh2VmZwRGRp?=
 =?utf-8?B?NzZNYWpiUTZpNi9EQWVHU2ZFRWpPVStrOHRoZDV0Ky91OFhjQUpmZndua0lD?=
 =?utf-8?B?NlNTYyt1K2hnZjU4UGRvODhhMXVpMUU3elRpazJkK0gyd0psNklVVmMyVlJt?=
 =?utf-8?B?N0NNVmJBdktxNTlGeHNrMG9nTzMxM0NpQzJhQ3NnQ0VXSTcvcjQ4dUVlVnlX?=
 =?utf-8?B?MVdONEdiSkxlck9uMWR5UUFxZWZJZDVsbVhOTHcwdXErWFp2NnBiaGk0R20r?=
 =?utf-8?B?WENDM1NnaWIxOTEvVGJoTkQyTW1jQXVvMGNhaHFwY05vQ1VESXlQaGhiczFw?=
 =?utf-8?B?WjFnTE9jSks0Rzdkc3UxblQrN094blBrTFhGNEU4cFhiR204L2xOOC8wVjhN?=
 =?utf-8?B?cUloMXRId3NHYkJqaWtQazZtRDdlQ0VzUzZVOHNxR3Ewb1lkWU51REt3YzdY?=
 =?utf-8?B?aTV4K2grN1lJSlBZTWdmeGtSeCtpU0EyM0F5Q3RDM3JGOHZ6eUh5Yk16ZVRv?=
 =?utf-8?B?aUNOb2JqdjZWdUgzWHk4b3grOHYvQlVITmM3RUpCVTAybWZ5UzBpb1UxZUU2?=
 =?utf-8?B?S0F0czgzQUhxQmpVTFlTQjc0RXRGVVV4RzVIOGlza1lFcVVjSDB5cXVyWnVi?=
 =?utf-8?B?cmFoTWlOcE1EcHcxRHp1eHFOUTRNdm5NL1BySDc4OHRaZ1J0T2ozR0Foaktn?=
 =?utf-8?B?R0h5YXpzMWo2YXczMXI4YUZmcUI5M2M3NVZoKzJLRy8zMnVSZWsrMmtWRTcr?=
 =?utf-8?B?ZFR1YUhmOWxNN3ZkMlhBeFcvRVpKcXgzdENBbWkwNUw4MTd1YVlTTWtJcG84?=
 =?utf-8?B?QkYxNWZqSTFPRkh5STVBSEFoNitNYkV4VnlVa2MwcFJrcHgrQk80ejd4c3RU?=
 =?utf-8?B?dEREdllaZEhEMTlCN1Q2VWNydHM3ZE9pcnpiYTFFTFlFUzZRTHBNZmtUR29L?=
 =?utf-8?B?TmQyUm9qUzljL1VqblRuQ2w0TXRZc05LWWczMElCanJiYTkrblpncmhLS1l2?=
 =?utf-8?B?Mm1POUVPSTFzeDlCZHVWZUswK1RYeS9ISGJVYkFZUVdwRXd2VTZ4SExNbUV0?=
 =?utf-8?B?ODdaN2l1TEJBSEFCSWFxam9UeEhYbks2TjBBY3JGTk4wYi9KamdGWXRFSXZm?=
 =?utf-8?B?TFc1MHFZTXowTHZLcmxabW1Dci90d0VMelNzVmE0L3lRZjhkcVRKcGRRSVBs?=
 =?utf-8?B?SHBkNVlkaTBMV1g5Rk00RmxFVFZpNXhtaCs1cW93Ymh2UjY4blVWTzhoeHpT?=
 =?utf-8?B?WDd3T2h0MGliLzZUNnZLQlBXNDFzRXRPakxDdmp1N2RGNzkyODE1cklObGY0?=
 =?utf-8?B?TEdrOUpLaVcyd1Q0bWIzNW80UVZlM0RIZkhFUGY2bEQ2VVBkN3VZYVJEbjBH?=
 =?utf-8?B?eC9YS0twVXREblBTejVWdDR4UWJXbjNBZGRLRnoxMTRRb0R4eStXWmNXeUFp?=
 =?utf-8?B?amtoWGlVRWlhVy9wU01SbzdBZ2drU1B1dFh0Y2sxaGNUU1dWMlRrS1BJZk1y?=
 =?utf-8?B?MDZVWGV4Z203S0xzdHVvb3YzY3V0NW82K0F2bnhwVGppc3VhdDV6YzkrdGI4?=
 =?utf-8?B?cXEzc0dWMEpDRHpNTG5Bb1Z5TUVIVm00U256cVJ0THc2S1duSjFTVUpwNjI1?=
 =?utf-8?B?OERDQ1ZudkMvSHRxV3JnbURMV1BjZVA1RVJOV0orYWlrL1lpRTJDbUtEUDE4?=
 =?utf-8?B?RUtYZFNsc3RrcUM2cXNXejk2Q0JiNnM4N0VIT05EWnNnNFpCZDAyQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q0iLVzX3MMnMAUX/Dlb0UgRY6To3X1Dav+th9BWPKxuzG3ELD1fNs1taIjfbpnLVRHZ25DFHHe+r5oCp9Vrzn2qXrvo6Sk6PNgqvIsQ9j5yl4HKSxqvaCxIOPOHuBNNBKE6tBobwFkZIxpQ0bCKFLf8CFlWs2zI5k6mT+WFZlqHuJ5wT1Czrp1VeQuIpJmTARPgU8HLH1wmraOP0dH8WLdTev3B8T3Rh5MyP3GuQg9ZcWRQgyfEitj6CNdFwr/n1rwkozXiXowb5z56FEAuZB0Oa0PPTElt7j+1YGry8/8zD/PjkAGUgT7+HiMn7KL51j6Yveu4s6YmuWtp8qwVpwA==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3564.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af580bde-80a5-4620-d78d-08deb15d4a1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 02:05:36.5972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYjBeWjZ/6rTGC17sW3j69OUKy2O6mVXIvE8gzLP/wTv+me6r+C9/P7oPuRP7M26nejVXZpRTQSKCZDRJemvWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140019
X-Proofpoint-ORIG-GUID: VmSYiQmD3QmuWEdGwhxj1OfjQ0lVhy_q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAxOSBTYWx0ZWRfX3dDiJoD61M0u
 aw7Jv6z1Kwx5AX3l0q43tJ1a1upuW87ejH6AyHC7EG6VOWjXgfOoWjb3A+Nw83owJcq9eGDZQnO
 l3W4wAN1k4pBqlWbO0z23hxTlsmc09Ds6PNQSrMwmQU/PVy2YpJqhxAIBmdvZ472C0diIluNic7
 /5ygGewZaK5shP9Mv8My373a8Fv4/Hz1SsSbN4hwe2nSo8kamlCe27K1asIgykvD/LnDuGDI6m2
 GSOHKBTeQDIPCLDCqxGZQv7P+yKKhpbwtfZWTjWUYBohx8m4GU/YCHZZr7LutvqpPG/3G5cAv3A
 EDZHrHi0v3GBZ/2iO+SaxNihvyp122bRIMGyvYADyOLHv5SuB2+79x0Y9dLfnixplBriZw9zEQb
 eVym7wcJjUgo+e+Opkq5kx44+s38pjGqnahK7AQPhp40xCKjf/kc1KvVzTmr11rKSDdcQSp6/pe
 d4fST56zpwLe8Uo5Ygw==
X-Proofpoint-GUID: VmSYiQmD3QmuWEdGwhxj1OfjQ0lVhy_q
X-Authority-Analysis: v=2.4 cv=A5xc+aWG c=1 sm=1 tr=0 ts=6a052df4 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=gLxAKuEMs0EQMVFiDJnH:22 a=i0EeH86SAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8
 a=jZVsG21pAAAA:8 a=20KFwNOVAAAA:8 a=bt5KbKNvAAAA:8 a=_NE3SiqiY3wjA-_56mwA:9
 a=QEXdDO2ut3YA:10 a=gbU3OgOOxF9bX48Letew:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=3Sh2lD0sZASs_lUdrUhf:22 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140019
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

SGkgRmVuZ2NoZW5nLA0KDQpSZXNwb25zZXMgaW5saW5lLiBJIGhhdmUgbWFkZSB0aGUgc3VnZ2Vz
dGVkIGNoYW5nZXMgYW5kIHN1Ym1pdHRlZCB2ZXJzaW9uIDEzIG9mIHRoZSBwYXRjaC1zZXQuIFBs
ZWFzZSByZXZpZXcuDQoNCg0KSW50ZXJuYWwgVXNlIC0gQ29uZmlkZW50aWFsDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGZlbmdjaGVuZ3dlbiA8ZmVuZ2NoZW5nd2VuQGh1
YXdlaS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAxMiwgMjAyNiA3OjMwIFBNDQo+IFRvOiBC
YXRoaWphLCBQcmF2aW4gPFByYXZpbi5CYXRoaWphQGRlbGwuY29tPjsgZGV2QGRwZGsub3JnOw0K
PiBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgbWF4aW1lLmNvcXVlbGluQHJlZGhhdC5jb20N
Cj4gQ2M6IHRob21hc0Btb25qYWxvbi5uZXQNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTIgMi81
XSB2aG9zdF91c2VyOiBoZWFkZXIgZGVmaW5lcyBmb3IgYWRkL3JlbSBtZW0NCj4gcmVnaW9uDQo+
DQo+DQo+IFtFWFRFUk5BTCBFTUFJTF0NCj4NCj4gT24gNS82LzIwMjYgMTE6MzcgQU0sIHByYXZp
bi5iYXRoaWphQGRlbGwuY29tIHdyb3RlOg0KPiA+IEZyb206IFByYXZpbiBNIEJhdGhpamEgPHBy
YXZpbi5iYXRoaWphQGRlbGwuY29tPg0KPiA+DQo+ID4gVGhlIGNoYW5nZXMgaW4gdGhpcyBmaWxl
IGNvdmVyIHRoZSBlbnVtIG1lc3NhZ2UgcmVxdWVzdHMgZm9yDQo+ID4gc3VwcG9ydGluZyBhZGQv
cmVtb3ZlIG1lbW9yeSByZWdpb25zLiBUaGUgZnJvbnQtZW5kIHZob3N0LXVzZXIgY2xpZW50DQo+
ID4gc2VuZHMgbWVzc2FnZXMgbGlrZSBnZXQgbWF4IG1lbW9yeSBzbG90cywgYWRkIG1lbW9yeSBy
ZWdpb24gYW5kIHJlbW92ZQ0KPiA+IG1lbW9yeSByZWdpb24gd2hpY2ggYXJlIGNvdmVyZWQgaW4g
dGhlc2UgY2hhbmdlcyB3aGljaCBhcmUgb24gdGhlDQo+ID4gdmhvc3QtdXNlciBiYWNrLWVuZC4g
VGhlIGNoYW5nZXMgYWxzbyBpbmNsdWRlIGRhdGEgc3RydWN0dXJlDQo+ID4gZGVmaW5pdGlvbiBv
ZiBtZW1vcnkgcmVnaW9uIHRvIGJlIGFkZGVkL3JlbW92ZWQuIFRoZSBkYXRhIHN0cnVjdHVyZQ0K
PiA+IFZob3N0VXNlck1zZyBoYXMgYmVlbiBjaGFuZ2VkIHRvIGluY2x1ZGUgdGhlIG1lbW9yeSBy
ZWdpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmF2aW4gTSBCYXRoaWphIDxwcmF2aW4u
YmF0aGlqYUBkZWxsLmNvbT4NCj4gPiAtLS0NCj4gPiAgbGliL3Zob3N0L3Zob3N0X3VzZXIuaCB8
IDkgKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9saWIvdmhvc3Qvdmhvc3RfdXNlci5oIGIvbGliL3Zob3N0L3Zob3N0
X3VzZXIuaCBpbmRleA0KPiA+IGVmNDg2NTQ1YmEuLmY4ZDkyMWY3ZjEgMTAwNjQ0DQo+ID4gLS0t
IGEvbGliL3Zob3N0L3Zob3N0X3VzZXIuaA0KPiA+ICsrKyBiL2xpYi92aG9zdC92aG9zdF91c2Vy
LmgNCj4gPiBAQCAtNjcsNiArNjcsOSBAQCB0eXBlZGVmIGVudW0gVmhvc3RVc2VyUmVxdWVzdCB7
DQo+ID4gICAgIFZIT1NUX1VTRVJfUE9TVENPUFlfRU5EID0gMzAsDQo+ID4gICAgIFZIT1NUX1VT
RVJfR0VUX0lORkxJR0hUX0ZEID0gMzEsDQo+ID4gICAgIFZIT1NUX1VTRVJfU0VUX0lORkxJR0hU
X0ZEID0gMzIsDQo+ID4gKyAgIFZIT1NUX1VTRVJfR0VUX01BWF9NRU1fU0xPVFMgPSAzNiwNCj4g
PiArICAgVkhPU1RfVVNFUl9BRERfTUVNX1JFRyA9IDM3LA0KPiA+ICsgICBWSE9TVF9VU0VSX1JF
TV9NRU1fUkVHID0gMzgsDQo+ID4gICAgIFZIT1NUX1VTRVJfU0VUX1NUQVRVUyA9IDM5LA0KPiA+
ICAgICBWSE9TVF9VU0VSX0dFVF9TVEFUVVMgPSA0MCwNCj4gPiAgfSBWaG9zdFVzZXJSZXF1ZXN0
Ow0KPiA+IEBAIC05MSw2ICs5NCwxMSBAQCB0eXBlZGVmIHN0cnVjdCBWaG9zdFVzZXJNZW1vcnkg
ew0KPiA+ICAgICBWaG9zdFVzZXJNZW1vcnlSZWdpb24NCj4gcmVnaW9uc1tWSE9TVF9NRU1PUllf
TUFYX05SRUdJT05TXTsNCj4gPiAgfSBWaG9zdFVzZXJNZW1vcnk7DQo+ID4NCj4gPiArdHlwZWRl
ZiBzdHJ1Y3QgVmhvc3RVc2VyU2luZ2xlTWVtUmVnIHsNCj4gPiArICAgdWludDY0X3QgcGFkZGlu
ZzsNCj4gPiArICAgVmhvc3RVc2VyTWVtb3J5UmVnaW9uIHJlZ2lvbjsNCj4gPiArfSBWaG9zdFVz
ZXJTaW5nbGVNZW1SZWc7DQo+DQo+IEhvdyBhYm91dCB0aGUgc2FtZSBhcyBxZW11IHZob3N0IGRl
ZmluZTogVmhvc3RVc2VyTWVtUmVnTXNnDQoNClN1cmUuIE1hZGUgdGhlIGNoYW5nZSBhcyBzdWdn
ZXN0ZWQuDQo+DQo+ID4gKw0KPiA+ICB0eXBlZGVmIHN0cnVjdCBWaG9zdFVzZXJMb2cgew0KPiA+
ICAgICB1aW50NjRfdCBtbWFwX3NpemU7DQo+ID4gICAgIHVpbnQ2NF90IG1tYXBfb2Zmc2V0Ow0K
PiA+IEBAIC0xODYsNiArMTk0LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgX19ydGVfcGFja2VkX2JlZ2lu
IFZob3N0VXNlck1zZyB7DQo+ID4gICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX3N0YXRl
IHN0YXRlOw0KPiA+ICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF92cmluZ19hZGRyIGFkZHI7DQo+
ID4gICAgICAgICAgICAgVmhvc3RVc2VyTWVtb3J5IG1lbW9yeTsNCj4gPiArICAgICAgICAgICBW
aG9zdFVzZXJTaW5nbGVNZW1SZWcgbWVtb3J5X3NpbmdsZTsNCj4NCj4gU3VnZ2VzdCB0aGUgc2Ft
ZSBhcyBxZW11IGRlZmluZTogVmhvc3RVc2VyTWVtUmVnTXNnIG1lbXJlZzsNCg0KU3VyZS4gTWFk
ZSB0aGUgY2hhbmdlIGFzIHN1Z2dlc3RlZC4NCg0KPg0KPiA+ICAgICAgICAgICAgIFZob3N0VXNl
ckxvZyAgICBsb2c7DQo+ID4gICAgICAgICAgICAgc3RydWN0IHZob3N0X2lvdGxiX21zZyBpb3Rs
YjsNCj4gPiAgICAgICAgICAgICBWaG9zdFVzZXJDcnlwdG9TZXNzaW9uUGFyYW0gY3J5cHRvX3Nl
c3Npb247DQo+DQo+IFdpdGggYWJvdmUgZml4DQo+IEFja2VkLWJ5OiBDaGVuZ3dlbiBGZW5nIDxm
ZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbT4NCg0K
