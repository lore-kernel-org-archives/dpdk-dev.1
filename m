Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F2CC19776
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 14:00:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D91C340E32;
	Fri, 28 Feb 2025 15:00:02 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8446940609;
 Fri, 28 Feb 2025 15:00:01 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SB1ass023846;
 Fri, 28 Feb 2025 06:00:00 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 452tyjtakm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 06:00:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmX0IJW8sfVWPXx281wNci39Sizw/y7lDy6nfuF5+wicHf+/sUaXQPdHzfjwbZT3D+b9MoEwd/2VbzQD36s/uL6EnQNgh1FUdXtNVjT94Qh45srXbkUFFQu+gpLTMIRcHA938VmW0SQYgimbpY4XXIkMPMHdxe5JYo6BwH+D9eLsQcDwfiV5V8z4blzjuMLCxAtXw5wsiuSkFc4/GBj4j2lLjeodtGkoOE8kCuGLa4Q1qe8Rs+4ogj66MQMhKO56BEGJfrrGUP4nTeKmCpb5i7WH1ILwmA/sNLMLvpq3+IuL65zoyk2FFgZT9fvMNSgwl2CMMyCQbDr/V4ERZ5pneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hE6ItQQ1IzOMZSEOZVCdM7fvIGSsNQCAu3IktpQeHvA=;
 b=xCtCtj9ZwQc43DRdoyVNX2vWpuIUedDy//c79Xj/BUR4ER8mhzcKC763ZNsPSq//0cCGqZ3eVZePHoXzGjA0UfhxFYShMXqxqKLfaGbF26ouUga2QaPPXI8p6b93F4CLxFmzaP92B2VTDh2L/xSQ/bQw02nIZwHGW+gMQ309bqcOA8GxfPXGIr0TreMVJ7204slp71LqjQs5N3qU/EQDcdiqyCtgx2TXY0qKQfcSrE8rfVJEGiH35nW8ntlzc7px7NRbmvsV9mAGRdtRRQF1Fif+oP2yIjTz4RZ1p+0LvdxIn9gAecnZgj+aOzEsTSn8wZ9JCC37oWMHhvihOJviOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE6ItQQ1IzOMZSEOZVCdM7fvIGSsNQCAu3IktpQeHvA=;
 b=rAfyOHMAeh1Bd5js74+fXOOiJJgewwcvEGu+364hGnciMUNxjzJCe2dswdpORoRkoVbJWg7zVGWknQzuVE/27z2UwdSYCxFc7Q4gnMYfaGNMdVM72M2+KNtohZO7laZmVbu2P+nqAfm+v7C81RFR0JMK1YaO7u1M3Ke2gNQvARQ=
Received: from CO1PR18MB4714.namprd18.prod.outlook.com (2603:10b6:303:e9::18)
 by SA6PR18MB6152.namprd18.prod.outlook.com (2603:10b6:806:413::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 13:59:58 +0000
Received: from CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06]) by CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 13:59:57 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, David Marchand
 <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Jay Zhou <jianjay.zhou@huawei.com>, Anoob Joseph
 <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [EXTERNAL] Re: [v6 1/5] vhost: skip crypto op fetch before vring
 init
Thread-Topic: [EXTERNAL] Re: [v6 1/5] vhost: skip crypto op fetch before vring
 init
Thread-Index: AQHbiH6FA1dexCVgyUmrLiQ9SxTU/LNa32UAgAAA7wCAAD+IoIAASj/ggAD/9oCAAA6GAIAARt/A
Date: Fri, 28 Feb 2025 13:59:57 +0000
Message-ID: <CO1PR18MB4714F4177DFF356821A12395CBCC2@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <cover.1740594750.git.gmuthukrishn@marvell.com>
 <0784f44b63f6161ac8716644acfea979704eca39.1740594750.git.gmuthukrishn@marvell.com>
 <81fac570-cdd7-45f7-b209-ce999d5c3d0e@redhat.com>
 <de649087-3686-4372-a1ac-d9a05961b6c0@redhat.com>
 <BY3PR18MB47054AE703CEB9AA6812A7C9CBCD2@BY3PR18MB4705.namprd18.prod.outlook.com>
 <BY3PR18MB470536F2A1329EE6732E332CCBCD2@BY3PR18MB4705.namprd18.prod.outlook.com>
 <CAJFAV8zDrLGrjk2F5EXqzGJUytQdnFnv5b1y5xr01TfYj0dRLA@mail.gmail.com>
 <4407830e-f739-439e-8962-c1fcd80ade69@redhat.com>
In-Reply-To: <4407830e-f739-439e-8962-c1fcd80ade69@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4714:EE_|SA6PR18MB6152:EE_
x-ms-office365-filtering-correlation-id: ac1aa416-2b1e-431c-123a-08dd58002f4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b01KTzQxSmkxMkNaRTlRcTZZVGEvVmRTV1VPRmNRSlFvd2NZemlqN3YrNVp6?=
 =?utf-8?B?dWRBUTYxajVMUVhTbnJtSWJ0b3cvTmRXM0NpZVlCVnVSKzd2Y00zVTV3QXlG?=
 =?utf-8?B?aVlCZTZlVWQ0eG8wQlZzZTZQeUl3SXp1dXJlb3Bkc2o0WXNwR2VoTFhQQlFj?=
 =?utf-8?B?amZFZndZU2lFcGVJZXNYT2VTbnoxN3RQOXRVajhVWmdncHFaWEJ3MC9yU1NI?=
 =?utf-8?B?VWtQTkYrdnB0VHpEbEtjVktneEJpYUxmdEFGQVdpMTM2NnBVVDhIT2FXMXpQ?=
 =?utf-8?B?N0tXUExEaFdoUkp2MUtDSXhjZTRoMTZ2WjZhYmRQeFg0ZzRUMmExNUQrMVNQ?=
 =?utf-8?B?UjJlSTdVRnE0R0xUTzBPZnByZDJBSTQwWHcySWdsOXVsMnRQWXIxek8wWlBi?=
 =?utf-8?B?UUhPNlllU0VSY09rdXZKekVCQ3NNYmhlMUdrTWFIdUowbGJZMXpKbC9vWmMx?=
 =?utf-8?B?djBQUGxKUEhkNVZlL2JXbmYrMzhnOUoxUHN4bUJib3B4eDZCTDgxRElOS0Fa?=
 =?utf-8?B?OWtETWxXeVBxQUxOQkZPMlllSnhKVXcrK1JQSkdWbHk0cDFwYzlFRXh2L3g1?=
 =?utf-8?B?bGw5WVRUTW92NjhONzZsOHBNZzNvb1UxMlBBNDZKMjNBSUFXOGpNWDcralpp?=
 =?utf-8?B?OVpsZTFxOXJBVVNUZlAyWnE3REFJbER1aTc0SEVabno4cnlCQm9kZzdtYUw3?=
 =?utf-8?B?R2wwVlozdUZtZytlOTBsMU1meDhEcUFJeENVVGdXZFNBUDZ2c3Nxdmlmd2N2?=
 =?utf-8?B?SkRTelFiTUdvM0I3QnlYZFc0RUh6K2JvdHovUmRZTmNFSGJFU2o4QkUvQmNx?=
 =?utf-8?B?T2FvYmZBQ1lSVnlrMDZYOVVQbGVxcEx5ODJpYlp3dDVZcUtjSU1PeGFNbVdr?=
 =?utf-8?B?NDZjSWczL0JOUCtsZGMzbkFHMzdEOEV1UUN6em9OMnh6emt4VUpkS1N2ZFVi?=
 =?utf-8?B?Mzd4WHFCZnBvMTBMZ0NzMWZsNk9wbjNBYmt6bFkyOUNES3BhOG4rdStKOWNW?=
 =?utf-8?B?M0NvOVh6bTNHejUvNUlnZlVqSHBYemtBemphNGMrQmJjMUR6cnpRekJaMWh3?=
 =?utf-8?B?Umw5NDNYbEpWZCtOWU5CM091ODZnN2lOcU55aDg1VUhiem1jVXZhZE5TWFlq?=
 =?utf-8?B?OTZKM1pIeFpFM2xCclF0ZzVvYnRuekoxNlBRV0JrcW5rSTBDYXhrSVhHdlVx?=
 =?utf-8?B?eElqak83Mm9jU3pqYldydGNHTXlpODdITUVGaUdyL1VCMnJyNnpoamdWYXVy?=
 =?utf-8?B?QjlYeGM0R1Q4VmF2Qk56ZUhmNWxSTTJMNUVXMmM0NENWYWtTQklkTnBlbDhq?=
 =?utf-8?B?Yy9FVG9EVWlRRkkwTmp2RmJrWjdkMlh1dXZxcGViSG42dUpxeExTZkx1Z0Jl?=
 =?utf-8?B?YVJobTE5dmN5azBERE9Qck4vSlRpRDNLY21HTVh4Yjdxa0pUSWhaV1RlNXFY?=
 =?utf-8?B?eWhPRyt6VkpZVXgwWTU5NEErNDNSN2pPSzZ4NFhrVHJLV0tkVlc1YmtOMTlU?=
 =?utf-8?B?RzQzWFBWc1dCWitjV0Jkcmwrd1JzVGEzQ2h1WGN4UFdTNWlocW5PcTBMaXZ1?=
 =?utf-8?B?QXUzUEZIWUovYXIxOHJiODFRZnQ4NXFzRm1LZGpiTFFVaXRpdVd6bHl0dTlN?=
 =?utf-8?B?cElRYW5oZUJVeDIzMlV0cHUvcUlSWHg3TnFjZUJUcmI2OUJ5SUNrd3lUa2RJ?=
 =?utf-8?B?UEV2dkM2bEF4TWtWK2NxSGxEV0VpRVoyT3Y3OXROUk9DTnFzbGdURG1KTWE3?=
 =?utf-8?B?TXFaWXduNVZ0dGYwZ2dFYnVYUVp4Z0Fva2ptd0kxSVdxSERIdnh3ZGZPdktD?=
 =?utf-8?B?bnkxT2dERVBDT1JMNmxFNWNLUUVvV3VKeTlBWU14aWpxZlVhWmRQanJiNlRQ?=
 =?utf-8?B?SktURk5FSjM5Qk9ZSW5iSnRjS0xGcCtTNHF3RXN4d2hLM2phSjA0M21QSHpp?=
 =?utf-8?Q?oTQtgNdoAaE3+UTP5Kakkxc7itjOOdyT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4714.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXBiK1JucFhnOXJtWmoweW5iUDMxNVdNOVBjbFlBLy9HdzQxeEtZLy9ZellE?=
 =?utf-8?B?Vy84Y0l6V0cxWWk5UWlMd0hHbVlKdExicUJ3MzhwK2dIa0k2OUFYWmtsS2hh?=
 =?utf-8?B?bkVDQ2pXWUNYazRzSTlVMlF6cFFGdUVOaVZuZkVOZHBza1BTZk5wRW5JbXpl?=
 =?utf-8?B?NTJXUHl2YlRFYkdEMzhsYkdGVDNycmJQMXB6d2NyMldseUZnbnpJb2FjRDkr?=
 =?utf-8?B?K3BmZ0lKOEZPRU56OHpHMnVhWXp1TkdUVEdCRlZaYkxxdWFjWklZMHpEcytH?=
 =?utf-8?B?cjB1aUZiVnpIRGRnb0NyQ3N4eVpaUmpWYXlmdWk1djd6dzg5WFcvNGFBQS9K?=
 =?utf-8?B?c2tWTXZ4akNOb2g2cE1mc0hFN3lyMG1MNnluYTdDTFFrWXJMZ2F5RkxuQkVV?=
 =?utf-8?B?emJNM1kwN2FEZmxPMjduMVluUmRwZmRMUkFWV2VJbjNTNWdlcGREdkZyYkwv?=
 =?utf-8?B?WkFVZVJtKzZvOEQ1Y1lKR0cvTElKU3lnR2hqUWJodURnc1JKZm96aC9JNEVt?=
 =?utf-8?B?UUp5cmRwVGIxQjNDNkJYUkFqdU45LzR0SUFyQXhNekt1N2kyRmJtSmFiM0dG?=
 =?utf-8?B?ZTBGcVpmMCtVOUlORkM0bEpzZmhocEh4cFRXaklQTHJIVUtsRXB2WEhlYk5Z?=
 =?utf-8?B?UzFZZXorQlhWM2hGNm9mRXhzdFZQTXFKQ0NRMDF1TFVUNU9ydU1TV0VyQktj?=
 =?utf-8?B?djkxRkw1b2RXRlBCSDVxbUY0NGZHRGd0S0t4SU1UbWlVNVhSeEF0emkrSWda?=
 =?utf-8?B?Z2hLaFRWWjNvd0dGSkdDZUdmbGpPSkVHUEYwMnEyVm92SVdneDdsV0xrdm5B?=
 =?utf-8?B?cEVlaGtEL1NHMUo3elN0VnhJTTNyaWc2d0RPdk9ZZnprWUY5elVBc0xVd2Iw?=
 =?utf-8?B?dWdVbFBUaWxEODlOR0VVVElsQkpsUmdETjFjMkd1b1N3bWFESDRXUTRRblNI?=
 =?utf-8?B?a1kxK3JJa2RGcHdKWlpUZU5DNE5CaHEvdkJ5TXgyelJqOEZpU0RUUVFXZC9s?=
 =?utf-8?B?TGlnOEc2dVhwSEpES0FvYVdQYTFlR0lmT3JFZUQxT1NGUEtNWXJHYVk1dHli?=
 =?utf-8?B?SUlhZkNjREQySVJMWnFRK0NCUW9IVzN5S0NGSi9KVFFzZmpSYUpBWXY0dS9w?=
 =?utf-8?B?MU1zR0RQMHdrZXVOZlA1M0dxZ0paVEVkOGRGOXhPOE5RTDlMS3hmd3M0YjRa?=
 =?utf-8?B?OHRyKy9pY0xDbmJpb1RPbkhPUG9GRllCY2IwbXRkbUlQb1dlRmh0ZVNRbVJ4?=
 =?utf-8?B?ZWlNMmVTYkpVSlg0RmliYjRlYzN1S2Q2Vmwyb3R6UXFiNENWdFJSMVdsOW1Y?=
 =?utf-8?B?a3BMc1VWbEZHS0JHbHNpUmE1TVliTFoyZWw1emx6WjRQUVh4R1JvNlRoSzV5?=
 =?utf-8?B?TkxPbGtqNUIzY2Nxb2NpY1NXS3BBRVIvZnpiTVMwc24yVE11Wk16NTN4UUpD?=
 =?utf-8?B?TEdxVzZocEgvU3hUREI4VFp3MW5JaElSaXdPbGt2dnlMcy9QcWF3UHFpelZy?=
 =?utf-8?B?LzhxS3FvRGpkZzEvV3djb3VlNTlTWEx3c3ZINmh6RlNrVUR0RlVrUXQvMVpn?=
 =?utf-8?B?QXZkVVRMLzUxRGZTUm5rS0xvN0RWWnM2VjV1bFZMTUZseHhLOVpuT2RXaUpZ?=
 =?utf-8?B?SWMwR25LTFAveTdCMmJuYzNlZ0wxNHlFZWZMdE1ramp0WCt1bE1LU3czY0Jk?=
 =?utf-8?B?aTBJYURnTmMxVDV5VkxhR0E5OVUzTzVkemptc0VZTk1GNVpHUS9FOFdOSjlJ?=
 =?utf-8?B?TEU2RG01QzFsbjhibzVNd1BpZUpQdmIxMnF2YXd4N042UUs4Skk2V2Y2RUF0?=
 =?utf-8?B?Nytmb0hLQlNwNFdmQlZkK0hYTnl1b3Q0RFhGTzJXaFRHRHRHeU12REp4Y0ZV?=
 =?utf-8?B?K3QxUzFZdDVMNHY3TlZKNHlucFJwNmxLWjZPK1FWckFQM0xWb2NEWnFVK2NS?=
 =?utf-8?B?dy9GU3R0MnNWb1NvM2w5WnNMc1I3Z1FpdmFteDFkckU2c00xcjZkK2tpWWY5?=
 =?utf-8?B?RUMwWVRkMlVNeVM5WFN6TVRPeEZseEpCYUZ2K0ZPSmVpUXJXcE1RQ2ppQUM4?=
 =?utf-8?B?QjRkSlhEOFhKWlFVaXo4czNNQVFvTXMvb0tLdU4xT2dzOVhMaklpMnY5ejEr?=
 =?utf-8?Q?ZQ6yfSx5AqPaf9IU80PRMc/Hg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4714.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1aa416-2b1e-431c-123a-08dd58002f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 13:59:57.2937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9PuqHuLypadon5WXixqSJYbAy0+iUfJh3jta7fcNL6STAkokCQa3EXvuAFEuImI8B0rYIOz2ooFnKyB2fIsc9UyF/6bAQEV6ACjxJKYbV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6152
X-Proofpoint-ORIG-GUID: kiH_KWZa0a3CJUOqIWaZdumltzlb-OF4
X-Authority-Analysis: v=2.4 cv=UIYnHDfy c=1 sm=1 tr=0 ts=67c1c160 cx=c_pps
 a=1OKfMEbEQU8cdntNuaz5dg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10 a=uF3N5PdDgOe4pX8Ljq0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kiH_KWZa0a3CJUOqIWaZdumltzlb-OF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_03,2025-02-27_01,2024-11-22_01
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

SGkgTWF4aW1lLA0KDQo+IA0KPiBCZWZvcmUgeW91ciBzZXJpZXMgYXJyaXZlZCwgd2Ugd2VyZSB3
b25kZXJpbmcgaWYgd2Ugc2hvdWxkIG5vdCBkZXByZWNhdGUgVmhvc3QNCj4gY3J5cHRvIGFzIGl0
IHdhcyBub3QgcmVhbGx5IG1haW50YWluZWQgYW5kIHdlIGhhZCBubyBpZGVudGlmaWVkIHVzZXIu
DQo+IA0KPiBTaW5jZSBpdCBzZWVtcyB5b3UgYXJlIGdvaW5nIHRvIHVzZSBpdCwgd2hpY2ggaXMg
Z3JlYXQsIHdvdWxkIHlvdSBjb21taXQgdG8gbWFrZQ0KPiB0aGUgbmVjZXNzYXJ5IGNoYW5nZXMg
dG8gbWFrZSBpdCByZWxpYWJsZT8gSWYgeWVzLCBJIHdvdWxkIGFncmVlIHRvIHRha2UgeW91ciB2
OCBhcw0KPiBpcyBmb3IgdjI1LjAzIGlmIHByb3BlciByZXdvcmsgaXMgZG9uZSBmb3IgdjI1LjA3
LCB3b3VsZCB0aGF0IHdvcmsgZm9yIHlvdT8NCj4gDQpJIGhhdmUgc2VudCB2OSB0byBpbmNsdWRl
IG9uZSBhZGRpdGlvbmFsIHBhdGNoIHRvIGZpeCB2aG9zdF9jcnlwdG9fcHJvY2Vzc19vbmVfcmVx
KCkNCnRocmVhZCBzYWZldHkgYXR0cmlidXRlLiBQbGVhc2UgY29uc2lkZXIgaXQuDQoNClllcywg
aWYgYW55IG90aGVyIGNoYW5nZXMgYXJlIHJlcXVpcmVkLCB3ZSBjYW4gYXNzaXN0IGdvaW5nIGZv
cndhcmQuIFdlIGFsc28gYmVsaWV2ZQ0KdGhpcyBzb2Z0d2FyZSBiYWNrZW5kIG5lZWRzIHRvIGJl
IHJlbGlhYmxlIGFuZCBoZW5jZSBjYW4gaGVscCB0ZXN0IHJlcXVpcmVkIHZpcnRpbw0KZnVuY3Rp
b25hbGl0aWVzLg0KDQpUaGFua3MsDQpHb3dyaXNoYW5rYXINCg0KUmVnYXJkcywNCkdvd3Jpc2hh
bmthcg0KDQo+IE1heGltZQ0KDQo=
