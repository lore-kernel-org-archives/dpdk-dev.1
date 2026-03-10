Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912DCEB1060
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 14:42:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1872402DC;
	Tue, 10 Mar 2026 15:42:03 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D6F06402BA
 for <dev@dpdk.org>; Tue, 10 Mar 2026 15:42:01 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A6XL0N919217; Tue, 10 Mar 2026 07:42:01 -0700
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023108.outbound.protection.outlook.com
 [40.93.196.108])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cte4t9ka1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 07:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHhbbDVTxYc3g04NM2zMH5EstSsuxVPlvAZ2+3gtrAQITeYSPt32KA5ul0PmrF/wFGK1y9ayz/t8hpOFXM7R5yXc7CNA/5AfS5r3ijqKSjIDe9aj3qHHNTJgzLrtpeBiw6oVTpOiuU/CuT/G5Z4i6HTKdWMssgg9Y/OVX8h9G/MXUDTgGw2RwqD2itYAwJU4awxF1wG5lWzxRGcvVY8mtLvh9nLJX3ciQcU+o5aHR0LmOWGG0/1uipqtnDKkWqJOwYmmyVdCycsaOv705FpbzUinZ+a4ZgieQ+ju1OqcAJiWGtoHHkZyXimvlY9GQx35jlFaAaQ5fSZfqu7e0m54dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2DBnnn2tVwxD57uPvA0hbhymrXw22dSI5VALNioQJ8=;
 b=vzKHa9rpYQwV0+zEm8ZvAKNUNXS+rBxi53YXxGH2wQ3wKISQnk5lHe/OmwxFjzHxqQ5Ie6TCxUF1aimh1Q24mTXhuuYPyLDo3D26abxZMX5QiYjgd7q+9vSeDKz5iJVdmJiZSWdOqofSFVW3f9NqrDeo1lLNDXNU6tnlrwhtC5S2OFJ2bvn+zksu9ib/kQfm7/diCIThTdyMvcm9J8CgXgD8w/CZ1ehQM0qQ/YKvkVmU1u00bbTES/p64QJgKreL69An2YQjN5cTq0MXNgNW8Qs9YUk2nM0lq3K8c+n0QY3NYO8f7pRaJ8t7C6/BlKo7BrEpmyb3K94DJMotkmLAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2DBnnn2tVwxD57uPvA0hbhymrXw22dSI5VALNioQJ8=;
 b=NGyB4sy6Q8BuzNE/vY9VIBd/kJy8L/843T6WaDzqnX06Q4zREgzakFlJNui3LTA2RWbgpzxv8Vqfx/Fe/Y55kXVJ956sqbyrncTT0IYerCVoqx7I/cBo67lVQaJCRr6OTpExfSt3S5E67O1ZI+rMF5fK0W69VTLQrWmP/o9ccvk=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DS5PR18MB927694.namprd18.prod.outlook.com (2603:10b6:8:340::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Tue, 10 Mar
 2026 14:41:59 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 14:41:59 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Emma Finn <emma.finn@intel.com>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [v4] crypto/openssl: Add support for SHA3 algorithms
Thread-Topic: [EXTERNAL] [v4] crypto/openssl: Add support for SHA3 algorithms
Thread-Index: AQHcsHd/Q1te5CaqxkuW12hOvrKzV7Wn1vXg
Date: Tue, 10 Mar 2026 14:41:58 +0000
Message-ID: <CO6PR18MB448463F7D7A2B368DA572EDDD846A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260211114735.2594969-1-emma.finn@intel.com>
 <20260310102010.1175294-1-emma.finn@intel.com>
In-Reply-To: <20260310102010.1175294-1-emma.finn@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DS5PR18MB927694:EE_
x-ms-office365-filtering-correlation-id: 93e42ffe-d491-4f7a-4b39-08de7eb32f4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7142099003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 3CQUATsdmKex6Vsu2wwWP0quAzvIdiDe0dcvbRcgnANYBg02QhdEaBAj1sW9XDckS4LPl827X7RT9Xjw+6vvpBIiTPYm6KOV7hk0PZOQYKzVYswz5vEh6C0WQycmEHZ91XvPpqpSEfAmBlfAotlRfnnYEYjmbyEbqAoa0nbxMTJddvg/Jddqa+clPszIk36xPTWjQvxQ0d42mutsUtmapWgPrV1MTYbUtpOcX/T+xBZCzivzfrHPgodXnyuL4atnKFHqzxRGBTdskS6s8exjPDvW+aqhPQURsV+L94ABGzIjH7l0qZlrjQq96hcccPsTu6qt+eap2FVEnVEJYp3aXRZxcYW2zLJNDVabg9qqI2xZGaxigCXAeivI10RWGFwkdG9VaG8VNr0N3694Et2fvr1E6i9Q6UYfAX+1h49aTUcUXVDEgCsyCW/K53l3j2TlxhxLXm5GVD/3r00P3+zSsnoxVLlhFcDDqeOd8SeLg9/bxRJBg+7tDFM7v1yElLnji2Z8u2gV1F1m8SVRA3e524LnUaP+q5Yk3rm6DJKxJIaZhmw8xwYK7aQrpiVOYIMYOYaOQzIK4To9sA6f4p0imTSRX4710Oq11l12OW43x36QSIVXiYuqhajTv6+JUVLYXdrZbnYJ993bM02Y/8jL4DgKZPu3kQs57K0Earxp+KieUoA+b2IMNinIYOEI6mZr6kcBSQd/9UBAl561sDnsCGy6xZVI7EtMCDLFors87UIqcqWEqy8CAG/UUj5U5cm8uxztJby+oYxiB4n2Jy6H1nfwxJBGGkotFOLVGu1YlAs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7142099003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHYwbU5qKzhZTTRuYndTOUw1RkVtakYvY3IxdFV6cFVYZXpzRnFGYzNOdDFQ?=
 =?utf-8?B?Q0VGZnB3b3hLbVpBaFVFWFhPSEhXdS8xUGRBK3dCWENXaS90Q25senZjcHlW?=
 =?utf-8?B?RDhGcnFENENJY1VxZ0tzQi9ObExqYUpNSDhQYlA3NW12WXdFdy9nOGQ1cDhU?=
 =?utf-8?B?cU1Td3lhVGFnd01TTEhBcGhHeTV1NjRTZC9wNmpDUEFvVks0WjVzbzZjOGpW?=
 =?utf-8?B?L205V2ZHOWtGbUVuTGxUN2FPYVNsRllERTgxRTZ3VlVVVDBwMis1WUZ4TDRQ?=
 =?utf-8?B?ZloycDFGOEhMZy9yTTFhNHp6TUx6VHBPeldXVk5XWU1nRE9BTWd0a3JhSFBk?=
 =?utf-8?B?WjFYVk1udlZxUDdCV3BUYUdkNUF4a0RuZHZvNnRzVmd4SDZ0cG1BYkQ1WDhC?=
 =?utf-8?B?Zm5RTmRUeEJHM2JwMDRoRzZyY29NZUpBczd2MkpkSDJ5THZta2NTVGFuNUhO?=
 =?utf-8?B?bGhzQ0pidC9FK21NdGU0ckZwMUZVT1JscHhkalFFWXpRcE1uRFlYN3ZmUnFu?=
 =?utf-8?B?Zy9weC9nWUdTMmFXbVBVWW82c0tLTFRMTGlIVmRDSGJTUm9XcCt1R0hZUzQv?=
 =?utf-8?B?dm9iOEFrTXlGQ2tNY0xDdHhjNWg3dDFERVZON0V0WG9qSy9TRUhDbWtVeUNr?=
 =?utf-8?B?MlVlQnpBS1BkSlE3WTk3cTlCVXVIcTNpMytXUWZWSHFrMW5CZ2xtc2c2N0FI?=
 =?utf-8?B?V0pLYkt5NjF6YjZvZjNvRm1hbGxuWENKUFYwdjBWQkY3c1R0OXRta0F1UHBy?=
 =?utf-8?B?VmRSZXhKRUUxNDlSd2JyaDBtbFh5YVpBWStCTllUbGh1NnUwWDZ2RmhKYzFN?=
 =?utf-8?B?TkNaUFNRczZnNmoxblYvajZWMDF6VHNWVjJMdVNHL0czbkFnWE4yNnJQUHgy?=
 =?utf-8?B?d0I2VDE4MTB0OVU5ZjZJZHE5SDRmQXNEdXZIK0NNS0JOMFo1WWtCN1hnYmZU?=
 =?utf-8?B?NGxMWXJ2eEV0YmNVZG0xQWpxc3JnK0pXc3dOU0VmK05YdUt3NWVpNUtodlZZ?=
 =?utf-8?B?bkMvL2hvdnMySzFyT3dWa2FIZG42eVBJaUNtb1VKY2VKV2N2T0NldmJvTVFl?=
 =?utf-8?B?YjZyZXIyTHZQVHl1ejF4aXBOVWtaRm54UHl3NGptNkZ6TFgxNHpKdlpuTzdT?=
 =?utf-8?B?WURwZ204NTFYWnhCSXhUQytxMFNVVDlzbzAvYVFrWVZRTy94QnRacTFFckls?=
 =?utf-8?B?RXltTUVxMDYxaFZRTW8yU016Q0VvQ3ZuNzNlWkdJakhOTkhvZytJVUdGcWJP?=
 =?utf-8?B?T3ViaEM5eXRNMVFIK1JicUtBNUwvZVJ5MXh5WjR1RVluN0d5c3VWa0ZCSmpP?=
 =?utf-8?B?anZnM283a0Q2NW9ZRlN3MlpKY256QzNYa1VoS3JvZ3NsbURYWDRLamZ2VUNi?=
 =?utf-8?B?STRPRnFmZXF5ejh6MG1ISTMyMGN2dUdseUt2SjVBa084WVVxVHBqN1AzV2pW?=
 =?utf-8?B?bk9UL0xRT2drWGp1ZVZGSlJSS3h4YTdLaWE5ZU1CMVBMcmh1WVp2MDdSdEZ6?=
 =?utf-8?B?SHd1SktUdTZRYVpmQVgwSWZzUWV6WFNON1A1dGRkMVhGNjQ4V0ZtdHh6RDM5?=
 =?utf-8?B?cjI2bm96SjJ2dkd5d09zTkpWbFRobUpva1RPVzlBVXZ2aWxmbldVU05LYmoz?=
 =?utf-8?B?cVduM3lGTFoxQkd6akVoOHZWQzY2YVdwOCtvclpKQVJhSGtLb0hkMEFqSkl5?=
 =?utf-8?B?SitkenhOMHgyQ3ExSU10Z2FJRm83VjJFOUtMalBCNTg0SHc4LzBwYW0reXF5?=
 =?utf-8?B?M3NlcVdqcGFwcEoxT1ZpVlR2L2hxOHRZaExZYnZ1NkN3ODRJYmpYQmZKdlkr?=
 =?utf-8?B?cXlXdU9nZGxxaEJDSlg5aHdNSTVaUUhvdXRSUnZoVEh6WnZ5ekJucHppSFZq?=
 =?utf-8?B?dFN1MDYydC9Wc3RZeEVFQ0NEazdGbk1hR0pONC96L2pUUXhPNnJCVlBDdUcz?=
 =?utf-8?B?bGV0Q3lKNWV0QkRkOEFJRFQ0VHd1Q2FkbXVlUkNXVWROWDFjT2ZCdC81RTNH?=
 =?utf-8?B?c0JkaTI4OFM4TUZMNTA5WTh2c1BWUWgwVUVLU0NyRURHaGlKNnFNMEVOTUtC?=
 =?utf-8?B?N01hQmorcWpGVVpFTHRjbkE4ZFA0OGdQMkNxVC9VMFpQL05OVlNZSk1NMy83?=
 =?utf-8?B?U3Z1b3JnaG5JYTBydDBYK1o3Y1BvMmRYRXhqRWZ3aWxZb20rd1QySFlWbWR3?=
 =?utf-8?B?MkdwWTBOOENwZXU3b3laOWgxNDZRU0ljaFVoTHM5Uk5NRmZVajJXa2gxRFEr?=
 =?utf-8?B?bEw0MnZUL1JjdVpjeG5IbTBYWGxCQURuQXgvTVphUE5BZkNwQm9qNnRZQW5W?=
 =?utf-8?Q?ypgj5ax66mYs6kpzRf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SeFMBbz0B+1zfe0HEFXNKSgwQkVByybWJFt1+A7cKZoQju7LrKYkO7ha2+Vp5dvKpRaAzcRRQtQ2eEe54wMbFpje+dgix4m3DvZW5zB+xboHx1rq3jYTkDlDe3hApVp4nanmB9IrhlIUd991S6cUL00MFOF5rexey6/rmZ7vX+1uOHhaieRfiH/1E9WKBu5h90uKPpSW8eYM/Uw/VooMUBPbLOIs7iA4ULJYidPOggWPBLjk9u3gpAg6qQSmRow65EBNmpMnRQAm+i359q2aX4MquAeWdDq8Ku1I7h/u1D+whR3PRmHC8EZ/+NPeLQhL4DcZcatN0cFLh49nuraOeQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e42ffe-d491-4f7a-4b39-08de7eb32f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 14:41:59.0609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APOFWTJEj33k07SE8KeX4X3TCDcSkywS1gXgFhf0QbB5HGBByC2mA89bA/If3/NMwklwFVQ69bNeEq9hprnYCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR18MB927694
X-Authority-Analysis: v=2.4 cv=YpMChoYX c=1 sm=1 tr=0 ts=69b02db9 cx=c_pps
 a=5+C5dWQ2lNXIGJ5Pv9T82A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=QyXUC8HyAAAA:8
 a=M5GUcnROAAAA:8 a=4eL7ltmmmdVhNdJkt24A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEyOCBTYWx0ZWRfXxPjIYO+Y9VFq
 tVB1QdCcKKoAPhJUQgtzP+1qjEhDFCjGan2pkjQwqTJktGcVc6Iv85rd+kAVhjh0HOtoBRfssPJ
 h6XMCil0oENwbOGFsRF020BR5P/WW68ErYqKAGQwIwpw9Pj7HqiDWS/z4ZtjXEGH0qXXb+ogMt5
 5cq/UlkUXkQ2xf750NVbG/Ioub15znXWnbgA3loxoR+3Lf/oX4SiwTkHMCkyWm4ysiX9ApsczUM
 syTNwhmoTr/juTnHut9ItdnJqd9xCbAbi4NbQmtqmm+q3bzvQQ3QPTk3TQZn7nEXyTpS2ygTx7T
 fcE2y2r4moYqzQt/vi97qrcKiwjiOCj4C3ooexs60HGo7eZ1+BAibp+Us/sljaMuEYDY63EjDqk
 DTANb/Ly4B3CcT3ne2NxjTKMkpy554Ccon7Dz36ejngoQXIy4y/3crOVqMxIsJv/WeNsC7CR66n
 yElmW0rEp+oZ4HxS1gQ==
X-Proofpoint-ORIG-GUID: O6dYLxm1iCxwfmSDz3yYCO3MGd4FGtYA
X-Proofpoint-GUID: O6dYLxm1iCxwfmSDz3yYCO3MGd4FGtYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
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

PiBBZGQgU0hBMy0yMjQsIFNIQTMtMjU2LCBTSEEzLTM4NCwgYW5kIFNIQTMtNTEyDQo+IHN1cHBv
cnQgdG8gdGhlIE9wZW5TU0wgUE1ELCBpbmNsdWRpbmcgYm90aCBoYXNoDQo+IGFuZCBITUFDIHZh
cmlhbnRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRW1tYSBGaW5uIDxlbW1hLmZpbm5AaW50ZWwu
Y29tPg0KPiAtLS0NCj4gdjI6DQo+ICogVXBkYXRlZCBkb2N1bWVudGF0aW9uDQo+IHYzOg0KPiAq
IHJlYmFzZQ0KPiB2NDoNCj4gKiByZWJhc2UNCj4gLS0tDQo+ICBkb2MvZ3VpZGVzL2NyeXB0b2Rl
dnMvZmVhdHVyZXMvb3BlbnNzbC5pbmkgICB8ICAgOCArDQo+ICBkb2MvZ3VpZGVzL2NyeXB0b2Rl
dnMvb3BlbnNzbC5yc3QgICAgICAgICAgICB8ICAgOCArDQo+ICBkb2MvZ3VpZGVzL3JlbF9ub3Rl
cy9yZWxlYXNlXzI2XzAzLnJzdCAgICAgICB8ICAgMiArDQo+ICBkcml2ZXJzL2NyeXB0by9vcGVu
c3NsL3J0ZV9vcGVuc3NsX3BtZC5jICAgICB8ICAzNiArKysrDQo+ICBkcml2ZXJzL2NyeXB0by9v
cGVuc3NsL3J0ZV9vcGVuc3NsX3BtZF9vcHMuYyB8IDE2OCArKysrKysrKysrKysrKysrKysrDQo+
ICA1IGZpbGVzIGNoYW5nZWQsIDIyMiBpbnNlcnRpb25zKCspDQpBY2tlZC1ieTogQWtoaWwgR295
YWwgPGdha2hpbEBtYXJ2ZWxsLmNvbT4NCkFwcGxpZWQgdG8gZHBkay1uZXh0LWNyeXB0bw0KVGhh
bmtzLg0K
