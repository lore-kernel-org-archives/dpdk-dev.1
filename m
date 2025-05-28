Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5967C3ABB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 08:06:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B50D1402A8;
	Wed, 28 May 2025 10:06:32 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DCA0040279
 for <dev@dpdk.org>; Wed, 28 May 2025 10:06:30 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5rFI3006365;
 Wed, 28 May 2025 01:06:29 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2122.outbound.protection.outlook.com [40.107.237.122])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46wu5agcmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 May 2025 01:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYwXGpulM8oM6EKJl3CI3FHDaslGH6T21wEk/C2S85FgNiXiruMU2Oqo0goNfcV6/6TstnJdqECLxn0+ZAVKr7P8rs4uU0V/giEfYBd8lcZsGSKn1Y3G8dsNcDEKu71dJ4nRP3CpOejgj4JwHwiwl1YxoLjAIl1wGXJWEolg8W+ghpD3pgtMJkfmCejN4vJauyOEbtq2sphHIdPDv0xhQgw0UeuJMzeU/Ahnb4Y7AyvxzeSq+qw5evYw9YRRwNs4TikX3gzXXrwuikAyiwM/gGZ7UprmRbCjBsAMs5dsTN9GFwTEWkdT6vSOLLCMzyIMv8bj8SZ1ph4tnjXsyil6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hm99btQ+z+NWommAoSBzKr+89LOtX1bWq2uVQjUvtis=;
 b=y1wG2PAkpQvWcgy7gNXs3dVxSYiAjRxaUYFu4ZML7VzjpjrKABmkIgP8QA9GCl5Cf0SyYZN4JD4F6XG+7Q0A7uE63UGno1dTgr+iq7DV5CY08Q5a0zrLXp0CuIMpGpfIHPmZvMDS2uGVI1i4+oYl1hpFDVDdWFmrB2PrlwUWAw4sw35vsjm0acBjwE7+XKCl4R+QMmZPniCKwXv6MQIaZ2TY+2UVOOiUri+Ct3LjuR4X0/OOtPsSKYvRWhO/iw2335YMEqqh2Eyrr79bQpa1pHYMRdjBfpHWmMTI0eUjIP+HOtB9gseA4Zhc7SX4EwVKaVD9ne1UI2J93nhj77yO9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hm99btQ+z+NWommAoSBzKr+89LOtX1bWq2uVQjUvtis=;
 b=b/dPX9IJAqeFG3Rp4z0rGDtIirkrUEhGfHEa2ZEUO5o/khebnHqSK5xTOEQzVIWAIiVDEH1nSuiNcVa7SZqS444idQVakkdPGUSarBvY6ILf6iQEEjNbphqOeikKKeZsOorqjSZv5GCQ+HGVxKYx0TiWjhgiG9BaQ+wF9o5Vy1U=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by BN9PR18MB4377.namprd18.prod.outlook.com (2603:10b6:408:102::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 08:06:27 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 08:06:27 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Changqing Li
 <changqing.li@windriver.com>, David Marchand <david.marchand@redhat.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: |FAILURE| pw153190 [PATCH V3] Add new tracepoint
 function for type time_t
Thread-Topic: [EXTERNAL] Re: |FAILURE| pw153190 [PATCH V3] Add new tracepoint
 function for type time_t
Thread-Index: AQHbuY+6qNjCu/UQZEKpimHSa/RCNrPEF+WAgAJicwCAAlO1gIAfDWtQ
Date: Wed, 28 May 2025 08:06:27 +0000
Message-ID: <CO6PR18MB3860EF5F3CA54B85A0E73CCCB467A@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250430013431.2056969-1-changqing.li@windriver.com>
 <20250430024403.2690306-1-robot@bytheb.org>
 <d498a836-e6eb-43b8-9ea3-bdb98ae4aaf8@windriver.com>
 <CAJFAV8zk=gzCagoU7c4=dsXcEFnLjiqrWxwTWANa-U77Uj=Taw@mail.gmail.com>
 <e6ca8bfc-06dc-4844-9b2d-f44436050165@windriver.com>
 <BY3PR18MB47853116D8C07076A91BAC3CC88BA@BY3PR18MB4785.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB47853116D8C07076A91BAC3CC88BA@BY3PR18MB4785.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|BN9PR18MB4377:EE_
x-ms-office365-filtering-correlation-id: 87be19ae-f99c-43dd-df7a-08dd9dbe8bf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UmFyTlBJYmhnbi9UeTZPMkRYa1hKMEdTR2VkQTc5TkVBbjNJQ2lPSTBRVWta?=
 =?utf-8?B?bllXVzdWclVYVTR6UTROOXBIbThpTS9oWmx0cmU2dmIyUjZ4TzVaQlp6TDcv?=
 =?utf-8?B?UC84VVlBQzJHbDZhTXRUMlQwUmxZRXExQVJ1dDN4R3ZqSVZGMWtMZnNtcUgx?=
 =?utf-8?B?NVdZZmlURlZSb1ptYUV2Nzh3SkIySVRxa0lIMHY4WUhTeDdJVmUzUVBvL0xF?=
 =?utf-8?B?SysvSVhaeHRwMHJ3RGNVKzQ4R21aMVZucVdtekgyRWpqVmFPRkhhNWtYTGZo?=
 =?utf-8?B?eTM1TjhBR3JJUS91NjhRYXYzU0kza2IrL3lRTFQwRDVqYTA5ZTRITmlZd2E5?=
 =?utf-8?B?NXV3S0J0VlRUcDg0TTRzOGlza2JndGh3MG4wQWdxVmNZS1M4M3MwKzdybnBx?=
 =?utf-8?B?Mi9pVG82YkgxYU1TVTlTSUFuRWlaT3praUU1a0Jqa3lqcFRuUFMyRlJuSDVG?=
 =?utf-8?B?b1ppNGUzKy9BVmVCUjk1M3NUODF6YnJKS3RRQklPejVyM0dnZDkrMDhrenRh?=
 =?utf-8?B?VjhPMWVFeFJ0TXJKTXVTQ1BnQnREWDJ4enZ3a2dET0dSZXpaUEZKNlJyeDF6?=
 =?utf-8?B?dDJhYlBvbWxDRVpWZytud3E0dThZcTNuUDJMSERNK2ZJaGgwb2JhZStyREE0?=
 =?utf-8?B?UnZzOFRDZUxac2lDcGhpeitiMXI1QkpvaHFaMFlYaGlkcURHTjI2N3BPMmFW?=
 =?utf-8?B?NFpCaG9IUWt0ZCtrR2pNOW1ia2ZXNTBuS2w1U3hGNHJMTkpoa0I3RUxmazcx?=
 =?utf-8?B?S00wZlh4c0ZNSzJpd3ZwQStYMzh2S1ZEeVVPdnJQUFVoT0dhQ2k2bUpEWkdO?=
 =?utf-8?B?STBsbjlMdkdRQUpEU3dCdCtGaWpTQ2U0TWhML1Nxckl6UHJvTjFERjZjeUo1?=
 =?utf-8?B?S3RoUDNJcWpja3JHWVJjVjF3cWdMamRwQ2pyOG9Hd0VMQ1ZCRk9zZmMwMWVQ?=
 =?utf-8?B?d0sycVl5QnB2aW5WVUl6QkplWmJ4ZDdqTVQ3ZWlUaUIxV0gvVXBPVDAvbnFm?=
 =?utf-8?B?bXlYbmJ0SnVsWGRzc0xXUy9rNlJobm01bjNoRFRjcHBhRVdKbUZTOXBxa2x2?=
 =?utf-8?B?ZjlIdy83NzdubmRTNWd5dVFJdTFnRWYxcDk5b2FudWxJMks3SmFEd0VUZGtk?=
 =?utf-8?B?T0ZFMVdWckd3NlVsMkJiZVd0UWsycDhqMFZFOEFoTzFYYjhqRzhHOGRadDJx?=
 =?utf-8?B?dGVHOU1lTmxPWWwvOHQ1cVVxaGNMajZhdmtaNHpNU29sN25uWkkvQndvem5W?=
 =?utf-8?B?emEzMDRzcUlaR1lMblZyb0VqdGNYQWx1SWZaeFIzUmtiVFlSaTBKdTh2K09t?=
 =?utf-8?B?T2xZQUZSakQrVHIwWE1iZ2RvTDNjWGNqTDAxakJnRFhZVUVDeG9LUVkrMzZD?=
 =?utf-8?B?eWp0UTVqL3NjVHpmQ0x6MmVZQlVzLy8xSU5rSjZ1bjBzU3hUZVR1bFZRMWRO?=
 =?utf-8?B?MVljTzg2MlpzU0FEM3B1VGhGeEtkVGpaS0gyTyt2VXBLeE9acE1pR2RXNW5v?=
 =?utf-8?B?L2UwMkI4WTBuWWVBZExsR05HWG9VZ05EcVpwZWROSmIydEhESDJuMDltL2xJ?=
 =?utf-8?B?VTh5ekhxZldPcVE3R05JSXNZbkw0ZFFQUVA0aTdNOE9QMGwzdzVxYWN3dERU?=
 =?utf-8?B?ajkzMkVHNmZPTnhnSDN0R2FmUmwzb0E1N1p4YUxrSDNOc3ZZSUxyei9QSDZm?=
 =?utf-8?B?OFV5WE5oZE9hRXlnMW9ETGlaNnFHdVlTYjhsS2Y5TVB3RmhrVlFpSlFsT2d3?=
 =?utf-8?B?YmFOYitCOEdWZzJ2SW1NOFhPa1diZzVoeWlaTVp6NUJ0a24wK29hTzFYZ1ZT?=
 =?utf-8?B?YXhETlEyWk1qa1lUK20vS282MHA0SlJ3VlFTdmoyTTVGUVR2OTZ1cnFMR2hn?=
 =?utf-8?B?b0VXUTg4N25kVnk1UkJlOER5aWxmMzVOSWRIaldOS2RHRndRZDVYQ0kvdCtk?=
 =?utf-8?Q?k6Z2EKJfgeo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmgzQnNPaFRaSmFNL0FKeUh2dlVDVVlFVTZVNWxnNTlqWkNrb01GS2ZjWEh2?=
 =?utf-8?B?WkNONUlsb004UDNLMkoxQ1RpalpzR2lWV1E5a2NRS0trNUtmV2NEZlhobmw4?=
 =?utf-8?B?YytWem1ScG5HUGRoNDFBNGU0dXQvWE0wRm40RTlCSkxjUFlyMndtMTF5WCtm?=
 =?utf-8?B?eXFxVzNzQkpSRkhqMU5UM1NVZkpTd1J0R3NBQkRsVFBCOU1jYmV3NU9YRitB?=
 =?utf-8?B?Q2wzbGdzanBsTXpCTjRzTXlmVTVlV29BQ2lHa0dtMm5sWFF0b3VRN2I1ZW5N?=
 =?utf-8?B?UlVwYzlTTU9saWZNV2xLRnhnQ3ZVQStLbDFKSFA0Z1NGbENQUGdkRG9ZSXgy?=
 =?utf-8?B?djhuRm9LcUVrYmNwZ2pGM3lwN1p0bDZzVG82b2Z6OXBkSVdlT0d1QzJmZWo1?=
 =?utf-8?B?RE93U3JxdW5pL2w1Y1M3cjdRTW90QnpQMGt0SCtVWnYraCt1eGRUYXNmSndT?=
 =?utf-8?B?Z2oxTjE2alZSeTlBbmFnbXlMeVRTa0l1VHFwNHpNSUdiTmUzcFlwVnF5d0JG?=
 =?utf-8?B?SDlwbEpRSW5rOEpvQjlRWlA1Sjd4UmtoUEFJbkt4WWpIczRaMDRNRFFHVlE3?=
 =?utf-8?B?YS8xbFhvakRvVWNiNk8zb2dEVUZGYkhQK0RoeDJWQXRKRzd2V3FzYlFaeGY2?=
 =?utf-8?B?QXBKbC83RWF3aytCOWFYakV5RFRNUFFNTFAyb3dvK2huVlpwemtZQWQ2VGQ5?=
 =?utf-8?B?N3p0aTI0REwxWkorUnBkUmxmdlJXYjk1dTQ0aFVOMUJvUWcwb1lRNXhBWkZ6?=
 =?utf-8?B?enh5a0E0T1pHTnZHUW95SHdQTzRNUFFSWG14aTlJTUpHZzBJcUtEMk5jTnhH?=
 =?utf-8?B?K1VpVjNaeE80Q0FxSDViN3NiSWVBLzkxd01FT1ZQei9oS2UrWlM3c3ozTVdQ?=
 =?utf-8?B?Z3JIazRTRGpPNjZaQVNLdFZ4M0hNVW9jU3JxbVhhNldab09hSmV3Tm40N3dS?=
 =?utf-8?B?OUFzMGt6bHNiK01uWDdmSnBDeWZQT21hQWlYK3MvK1lGSHpzZ0cvK2F5bVhD?=
 =?utf-8?B?dVk5azQ1eURvR0tZSE4vWGo4ZXhtMkVZZmtXNzN6N0k5ekExSzFTVTNpZUxk?=
 =?utf-8?B?d2RLMytINmMzZ1ZDTXhnUkdQOTBrSHFlelVKaVVLa1B5OEtnb3VhZUJicnl6?=
 =?utf-8?B?U2tjMnFwSS9lWnFHbysxZDY0VXZ2ZzBtUTAxaTZnQmg4TlZvWU10OVlydi8w?=
 =?utf-8?B?RDZSRWlrRE1OZTkyMXMzc0hCMHFjdUZrYnBBQXY4Und0WnFBeWdIZitaVW5i?=
 =?utf-8?B?Q0FOOEpWUEZvRThNWkEwd2pBTVIrbnhMZzdWbGlYcFhCY3VkUnh0Wlk3dFRJ?=
 =?utf-8?B?S1p3bHpCY0J2OTRFdEhkdCtRZ2o2UWNxV0Q3WHdXaks4dFg5OXpUVTFjRGJQ?=
 =?utf-8?B?eDNqS0ptRThkME12UWZERWJybGxhOEsrbFhvb3kxcFA2em92NGZtYy9RZmNW?=
 =?utf-8?B?SnVuTHZZYXE2dmhSVkQ2V2phbDhONGtJaE1GNnQ3bzNpSEcvMzZNcmVmaEpz?=
 =?utf-8?B?bzhIMEVxSWFTRVhrVlRlNlNUbjZra1Z6eFRFNklkSERDRFBjUk5ldWErZUdm?=
 =?utf-8?B?cUo4dWszKzNiY1RMT0NUeUxkdVhuYzkrbkJ1Y01YSkpGY0V1T1JOcXZHWFE1?=
 =?utf-8?B?NFh1VDUxdERodk9OTDFGWDJsZm1vbTVhZTgyYkRFRTlUdGo2azVXaFFwd3Ro?=
 =?utf-8?B?S0VVZHFBK29TKzQ3bUhHM2toK1BxU3MvRU9YcUhYYklCa3dIMmdDaVc0SVRC?=
 =?utf-8?B?SnNMZWt3aDFvZllmUHJJM1B0S0lwKzBlaVRMaHltaE9iWmN5b3hsOURGMEVZ?=
 =?utf-8?B?OG1CTmRXSVlmQm5MZS9wZWo1Qjl3MlMzSXZsRDdadGlweVJTQ25WQjlaa0ZL?=
 =?utf-8?B?Tkd0Wm1sWWs4YW5Mc0tZQlQzM3BMSzBYZFB5Q05wejMzQUxpVUF1cHQyQ3Rz?=
 =?utf-8?B?ZWtrSjRBVG9VTllhRS94dmplVHV2cCswUHZCeGZBRkNyT2JSUHZGZmlKbTRo?=
 =?utf-8?B?aHhuUnhYY1M4Q1cxbUpFWnlGdEw1NWo2Z2NhU3VMSzlHUzVhaUpWbXU0TTc3?=
 =?utf-8?B?WFhIY2FvWnVNSVVTWHloZTl2VEFWRGc1V1ZwWU83U2dYL0dsMm54SUNVRXh3?=
 =?utf-8?Q?2tCQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87be19ae-f99c-43dd-df7a-08dd9dbe8bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 08:06:27.3691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8NDPRJMJeiFkBleRxTgGwGtHwSSGnZr561CdEhZVCNSEcK5zO7MtLPBe9dHXPTmmVGkN/TslCSRL+dDC7PqZ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4377
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA2OSBTYWx0ZWRfX2Ni0IrtXghF+
 RwzMi5tNdm/vfrvRhRejthZBfuRleXSDFAFf0rXfvYfpQkdFGg4KcRBbwZKY+udLnUMoYrSAdZI
 LzOzaUv4LPKZ12ZgNN3TdF/plbJp+PvwEV9PAFO1ArFffXMIFqHLayL61PQsdYvny7YSR9KztQ0
 YS3EpfoyAStHt8HZLvVH3cp+Mx9v+klUM2tboKWx67dplBILRg2iBFJJ2aNEE/k2jidbOVmegcX
 T4+GcdEuRcPj4O0RGeX7Hkd4Cj92L9A2uvYlB259aLFVa0fZgsRlyFZNLn7J31qB/u7timMb1wo
 5uOPeH9o0aWtzTHMudqaEMY7oAsbgZN3bLItG1eE5YMXYjnJsMIfNbmLN70ZVhloO+QfTh0ValC
 vZ8DcLC9RQKBNrttVrO5YJHDWdTciw6f6WlmqP7Xn0rqGwPdjBzQ+VnV2AkD2MYzw7SXwZd4
X-Proofpoint-GUID: vE8rHXGukX2asr4-g-lXjifUpIM6XI9h
X-Proofpoint-ORIG-GUID: vE8rHXGukX2asr4-g-lXjifUpIM6XI9h
X-Authority-Analysis: v=2.4 cv=UahRSLSN c=1 sm=1 tr=0 ts=6836c405 cx=c_pps
 a=A3v3qn6PhMMR3Z1noSFPxA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=DnJVbuqOAAAA:8 a=M5GUcnROAAAA:8
 a=t7CeM3EgAAAA:8 a=20KFwNOVAAAA:8 a=bt5KbKNvAAAA:8 a=jZVsG21pAAAA:8
 a=8rWy6zfcAAAA:8 a=INpGfeKreMip3SjIDykA:9 a=QEXdDO2ut3YA:10
 a=Sz6ghim2xQgRqd81wKBx:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=a-zEBD5cKgE7DNtTSb7C:22 a=3Sh2lD0sZASs_lUdrUhf:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_04,2025-05-27_01,2025-03-28_01
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

UGxlYXNlIG1hcmsgdGhpcyB2ZXJzaW9uIGFzIHN1cGVyc2VkZWQgYXMgbmV3IHZlcnNpb24gaXMg
YXZhaWxhYmxlLiANCg0KVGhhbmtzDQpTdW5pbCBLdW1hciBLb3JpDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVyaW4gSmFjb2IgPGplcmluakBtYXJ2ZWxsLmNvbT4N
Cj4gU2VudDogVGh1cnNkYXksIE1heSA4LCAyMDI1IDc6MjQgUE0NCj4gVG86IENoYW5ncWluZyBM
aSA8Y2hhbmdxaW5nLmxpQHdpbmRyaXZlci5jb20+OyBEYXZpZCBNYXJjaGFuZA0KPiA8ZGF2aWQu
bWFyY2hhbmRAcmVkaGF0LmNvbT47IFN1bmlsIEt1bWFyIEtvcmkgPHNrb3JpQG1hcnZlbGwuY29t
PjsNCj4gdGhvbWFzQG1vbmphbG9uLm5ldDsgU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0
d29ya3BsdW1iZXIub3JnPg0KPiBDYzogZGV2QGRwZGsub3JnDQo+IFN1YmplY3Q6IFJFOiBbRVhU
RVJOQUxdIFJlOiB8RkFJTFVSRXwgcHcxNTMxOTAgW1BBVENIIFYzXSBBZGQgbmV3IHRyYWNlcG9p
bnQNCj4gZnVuY3Rpb24gZm9yIHR5cGUgdGltZV90DQo+IA0KPiA+IAkJSSdtIG5ldyB0byB0aGlz
IHByb2plY3QsIGFuZCBoYXZlIG5vIGNsdWUgYWJvdXQgdGhlIGZhaWx1cmUsIGNvdWxkDQo+ID4g
ZXhwZXJ0cyBhdCB0aGlzIHByb2plY3QgcHJvdmlkZQ0KPiA+DQo+ID4gCQlzb21lIGhlbHAgYWJv
dXQgdGhlIGZvbGxvd2luZyBmYWlsdXJlPw0KPiA+DQo+ID4gCQkrIHN1ZG8gYmFiZWx0cmFjZQ0K
PiA+IC9ob21lL3J1bm5lci93b3JrL2RwZGsvZHBkay9idWlsZC9hcHAvdGVzdC9zdWl0ZXMvcnRl
LTIwMjUtMDQtMzAtQU0tMDINCj4gPiAtDQo+ID4gMjUtMjENCj4gPg0KPiA+IAkJRXJyb3I6IGF0
IGxpbmUgMjgxOTogdG9rZW4gInRpbWVfdCI6IHN5bnRheCBlcnJvciwgdW5leHBlY3RlZA0KPiA+
IElERU5USUZJRVINCj4gPiAJCUVycm9yOiBFcnJvciBjcmVhdGluZyBBU1QNCj4gPg0KPiA+DQo+
ID4gCUkgdGhpbmsgdGhpcyB0aW1lX3QgdHlwZSB5b3UgYWRkZWQgaXMgbm90IGRlc2NyaWJlZCBp
biBDVEYuDQo+ID4gCUhhdmUgYSBsb29rIGF0IDIxMTQ1MjFjZmY5MSAoInRyYWNlOiBmaXggc2l6
ZV90IGZpZWxkIGVtaXR0ZXIiKS4NCj4gPg0KPiA+IAlDb3B5aW5nIHRoZSB0cmFjZSBmcmFtZXdv
cmsgbWFpbnRhaW5lcnMgd2hvIHdpbGwgaGF2ZSBhIGJldHRlciBpZGVhLg0KPiANCj4gDQo+IA0K
PiB0aW1lX3QgaXMgbm90IGRlZmluZWQgaW4gQ1RGIHNwZWMuIFNlZQ0KPiBodHRwczovL2RpYW1v
bi5vcmcvY3RmL3YxLjguMy8jc3BlY2lmaWNhdGlvbi4NCj4gWW91IGNhbiBjcmVhdGUgbmV3IHR5
cGUgdXNpbmcgdHlwZWFsaWFzIHdpdGggaW50ZWdlciBvciBzdHJ1Y3R1cmUgYXMgYmFja2VuZA0K
PiB0eXBlLiBTZWUgbWV0YV9kYXRhX3R5cGVfZW1pdCgpIGluIERQREsgY29kZSBiYXNlIHdoZXJl
IHdlIGNyZWF0ZWQgbmV3DQo+IHR5cGVzLg0KPiANCg0K
