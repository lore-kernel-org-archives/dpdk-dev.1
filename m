Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFF7C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 07:07:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E4A540288;
	Fri, 31 Jul 2026 09:07:35 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 6329A40280;
 Fri, 31 Jul 2026 09:07:33 +0200 (CEST)
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V4x7hF1836807; Fri, 31 Jul 2026 03:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=t
 tqWJ34Wyh4EZncH0TUV62e2zLJFIOdg2z4Eq3dF/FI=; b=ANlfLlXmEZ9S5EjYS
 Bi7kbTElE1DUl4j7jTP8iny5wXg7lpSIjGUCPcumYHm92FglyJeLn4bsIHJ4tLi9
 nJJQCJqVvehrjWLkSTXkjAhEB0NFDgkzofWGm3w18C7HcO/8nnBvKhB5ZG+SxUtd
 evHNqtoKOq24xbt5SptOmo4z8czX2v+Gf9dEEk6ON91tZuL85/B3T5Nn5nlaaRi3
 +bkJpaK8q7XObCo4+nSTDSH6pTmLcgCZ/4Z0ldv3vqnQP36ecViBKu9uMQuYtTKd
 cLEigAYtbqqkDHReoruq+gnh0nbbinZ+7iVcItGJ71Trh7BU570y4FyZC1IIiSZ2
 zkSwQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4fqnmhywb6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 31 Jul 2026 03:07:32 -0400 (EDT)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V5Hmo72870403; Fri, 31 Jul 2026 03:07:31 -0400
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4frbj7gh6y-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2026 03:07:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APbX7iMx6eXk3pY7tSJTpIWnhQKvMefiNfaTT8ehvWJHeUQO5tkOn0I9KtkM4kPht4rqfVafwrM+BvsyICZ3syPFDpgK3ERx9yBcDhnM4tRhPZgapW6o9eJKag69rnGd/dnTRUb7YrBZKmGSBjDpMahqw6u0icGFkn2p4novWJrN4JqTGBhImxNExz/Hs4lwyOl35LpvKp2NREDk5aPaMH40l+X2Ar+0o9Ncc6oyjiclzGaSJucUD7vnnOf8m9qkROhyBbDbo3zzrv+IHjjnXy9Tncfs4P7y/tpoVb+GNaAYPdjkh9PXHaW3rj/l7zJF7bNzBw789l40qwzuRDO2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttqWJ34Wyh4EZncH0TUV62e2zLJFIOdg2z4Eq3dF/FI=;
 b=u37ytUpUwoPqjZH6DMkrf3JIX//AK++Dx1SFJqg6wvKDHjqsOR3/2PCxNM03bJXfuqea4G3ZnLLET9rkl+WVs4gW1KS2jmm6latzQCqrFbiy2sJbKrg2Plsxl0BptETO1tcpR0gOAPWXWCbs8QzKx0VERL+qTIWh3/RO80lzHEOZxOEYRQekFUEhhWmfDHYZznB+lvDQOULc4QEL5/lOwwjAbZx2PWrDYNweXK29bXMkKQJt2sZsZNCtiqgLvhH0hO+/CIqd0bj7zSs+UDbHWpSetQmMev0YYA0EgaeKTXz6a8ovIWHnnqfI70iNh+A1TWLrCAgLy0H9Ecn/B8+vOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from IA0PPF659BD4C46.namprd19.prod.outlook.com
 (2603:10b6:20f:fc04::ca9) by SABPR19MB997549.namprd19.prod.outlook.com
 (2603:10b6:806:50b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:07:28 +0000
Received: from IA0PPF659BD4C46.namprd19.prod.outlook.com
 ([fe80::3375:a560:cdb5:4267]) by IA0PPF659BD4C46.namprd19.prod.outlook.com
 ([fe80::3375:a560:cdb5:4267%8]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 07:07:28 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: David Marchand <david.marchand@redhat.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "maxime.coquelin@redhat.com"
 <maxime.coquelin@redhat.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, "stable@dpdk.org" <stable@dpdk.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>
Subject: RE: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
Thread-Topic: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
Thread-Index: AQHdIJqmnf1/7bON30W14JW0Wc3J87aHKHoAgAAJu2A=
Date: Fri, 31 Jul 2026 07:07:28 +0000
Message-ID: <IA0PPF659BD4C466F2C7E46C7DF91081BF6F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
References: <20260731031355.3578236-1-pravin.bathija@dell.com>
 <20260731031355.3578236-2-pravin.bathija@dell.com>
 <CAJFAV8x137vqFU8bptTFhxjusYG1wYHxkvE46iMRif7+84_w9A@mail.gmail.com>
In-Reply-To: <CAJFAV8x137vqFU8bptTFhxjusYG1wYHxkvE46iMRif7+84_w9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-07-31T06:56:27.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF659BD4C46:EE_|SABPR19MB997549:EE_
x-ms-office365-filtering-correlation-id: fe4d1a07-0b13-4360-b6bd-08deeed261aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|786006|376014|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: zj3EMzFqj9YUbtJhSyiovVdZ6iqVemcSyL9a0rliiaDw+zlkGW+G+jq8f6ct4i5FIKmkU9xy6EZ0NI+lsAa0yjB5FsBPRHUrJpi1vEYUiVBuwT6LR2dP7LI7/KWr2ASG8tpcPz9KubxIHEGwpf1IVoD0pVht67FABPinIFLczZC7px7fVuBzNAP88Mky1314WAD4MmLPFMnXP2jvCgwuouHPOz2MkmNhH8pt3K1Xeem/JNipA9MqsIoc3lxj/+AWEFXNt87bxPMSK8pZSJg0nR3/GOrBBbciOwvpcSA9r+Du468xzoqTDrsdjGLNHAu6l0gpzG2FKnavUrxz1157df50IB9dESgKvwF5ngVZSbco1I6OLFzJdHAOqMK8YYlLNE6ba52xWr7y0hUrVbUo4dHNUSjbeyX5//e5pPkFAmOQ5HG3JvqpjOqiw2k585K1UF+/FNIB7ZoQPA9/VQYfwffMkyuN1LOH8NdqzfelgWgKrRr9AN5MmPt3tSLKHwjsq0URkmjPwcd/QbsCK07AvCKqYPBPgJQTpVpc3IlGxJkToYQNzZF+k1pY4B95bYl05AkoVVIKzDHehhTMUqZYW357WGNlHok93B4D21DBN2i5G9xlHbXbKYdKEoiqqk0BZo84peq+6KXy9kILcaoB8Ip5Xg6jfwpseBwDAMHEbLgfOGTY2GeDY4e3Z9JsiAE7q76+vciFbJ5yhUnr+fdJxTJCIDqqKVHO1V99A7JKnOU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PPF659BD4C46.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(786006)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?d1R6YVRIYm1nakRyWTBCcHJrOGxxN0EwV1k4cFIySkQxVWRMTlFMQ2tEM04v?=
 =?utf-7?B?MHdHRzZXbnUxUjd0dDE4Sjk1dlhuL0RWdzNqOGZpeFRrR1JWeTZEMkRLMy9h?=
 =?utf-7?B?M1FaMFhSL24xVDI2ZjUrLWFsNldkd2dMczBhY3QrLSstb0hkWGJtMXRVMHFP?=
 =?utf-7?B?UWpvRG9Tc0NlZlR3aVViSHFXODdNKy0rLTh0TE9kU2cyZ1lHTm1UREU2cHA4?=
 =?utf-7?B?NEVpdFRmdVpnbGlvamp3cGNjTlF3QUowKy15bGJlWXdvOGdVODIyTjBTMHNN?=
 =?utf-7?B?NUZvT0J1ejdyS0V4VHA4eVIrLVdzVnE1bEFhWW1UdVljZzBhd1l1aEUzMXNs?=
 =?utf-7?B?OGZsNENWakdFSE5VRVJxczhtY3U4LystQkQzalNySHJUaTVrRDVOZ0E3VXpx?=
 =?utf-7?B?aUhSdHRVbzNhSjlJYTNaZ2pmRTFKZE03R2E1Umh1ZWFpKy10RjhsWWx5MkZ2?=
 =?utf-7?B?VmdjYU1ER2JmalZzeWtJQ3dkZVY0ZHZRTmJtMjdpTG0xdzRERlRKeFl6a1R5?=
 =?utf-7?B?di9BVTZWem9MQkZTNUZFQVJqeUQrLUU2OEZBaEVZdGcxbFJMU085RUNPN1Jw?=
 =?utf-7?B?bDNzQUtPZm45RHFReTFwdXRTTlFTd2ZYZkNFa3dCazE5ZDBZTU9rUzk5UzdB?=
 =?utf-7?B?cGd3VistclRwalROM0ZhZGxEQ1BCWUVVb3NCTXo0MS9nOWZrYVZhdGdmVmIy?=
 =?utf-7?B?QXZxN3grLXg3aXZGT0dzRWRDRXZpVHJtTzZQUE9xUnJUMDYrLTNHUjZkbFcz?=
 =?utf-7?B?TFA5Y1FSQkhLalpPTFREQ3FrNkVzTEpiVy9yZmJIS084ZG84RUwrLTM5eTZE?=
 =?utf-7?B?cEpsaXplNkZrdllsY0crLVBYdExpcVVPZ01tT1hYNzQxSGtLcjY2L0d3TzFB?=
 =?utf-7?B?b1pQNEFlTVI5NXhxV3VyT0hLTGJjZFh6eC8rLXRLYzg2NGtVOUhHU2oybWhu?=
 =?utf-7?B?N01oV3piSkpNRVRTajNqLzRhaG5jNjJ2clBQNGxYYUdIbW0wL1JGZlo3Wkpo?=
 =?utf-7?B?NzhuUWlqeVVMMy9hZkNDZjNGRXVzdWJ2clVGZ1N1S2RHODZ2RnRlZUxHNXVI?=
 =?utf-7?B?eEJqSTJRcEtjT3VpWFcyQXQ2R1doZm1hWDRjaGJhZjNYMlE5bGRTYlZvWXhq?=
 =?utf-7?B?cTA5eFhqU0phd3VpaEd1OU0rLUZja0ExZnZINnhPblFBNFE1SGxHNkorLXhU?=
 =?utf-7?B?TTh0V2U2NmdsSnlxa214YjhBMnRJYkVFRlQ3SG8vWistMGpDRDBkNkw1Z1V3?=
 =?utf-7?B?ZFBsd00xV21BbEFFeDlBSzdUQjZiN2JZaXBBaDFNKy0yTlU1M3p1Znk5QmJ4?=
 =?utf-7?B?QmhHLzR3ZUlDUUx1Qm1ROHdIT01WZzlSb0syTlNrRlhoR29BQUQ1S3hPMEh1?=
 =?utf-7?B?NTVRODRwTlhzeTJ2S0s5REI3OTZ6dzZHZWMrLXlYV3pwd2pYT0YzNVRrWSst?=
 =?utf-7?B?SUtIVGd2VHZrbDdpZWRvUFMzbnQ2VWEyZEdEU2FBQUVzZW14TUlVTFJXUUta?=
 =?utf-7?B?T05QWEtUdXlUSDJ2eDRhbm4rLUFnKy11ZmdFRE1OeXBCcDZpaistekRoRFcv?=
 =?utf-7?B?cUlrODJsbERvOUlpWmtTOHFzQ2FvVEtUbzQ2QldhTkRIa1o4QUs2TDBPKy14?=
 =?utf-7?B?RjhnWTlHaURvb1NqQ0M3TWNUZzdZYmlNQnQ3YTZDdDBpL2pjNEV2MHd5Nm1t?=
 =?utf-7?B?Ky1VOHpRMi9KMGRObndId0Z6c3NMVVJKNk1TbE9yOXhqZTR1aXdLVWttSVpZ?=
 =?utf-7?B?Z3FjRXlTZHFCZ2tsSWZaaTZhbEtGTnNOUHUxMm81Y1YyLzJONWJ1WmNSck1M?=
 =?utf-7?B?RkxzWUVQWWpLVlZUbzNNWCstYjRucVIxUlFaTWM4dTdQeHN5d2t5SEc4VDQ4?=
 =?utf-7?B?dGx4Q2xWRTBBM3lRbFNuSWFNeEtjb2t0RFd3NmRQNUphV1VlZ0pmdkY0V3NI?=
 =?utf-7?B?blNzT1B3c3NITEh2cXZHNEJoMFhyKy1BUWNsb1duMmExQU9oWDNRWm9LUlJH?=
 =?utf-7?B?ZUdyNVV0MDNCZEFLQXhOOVZMVWhyV2U4RGdlSEdib2JzeDVsKy1qWnQrLWt4?=
 =?utf-7?B?bmxhOTlUWE84Zmo4UDVsQVV3M3pqODc4TGMxcm1KaUR6eUFseVlhQ2RSdlFK?=
 =?utf-7?B?bksrLXhEamVGKy1ycUtBUjVHQ0laSW95dW9ZOHZoc0lCUVpjUGk1dlF5T1Jj?=
 =?utf-7?B?MTNXNkdzc2tEUGtuVzhjU3UrLUJtRTZQci9YUTlENU9wcDQwVzZQOVRVOXVN?=
 =?utf-7?B?bjIrLWtpWWttc2dycnVxc0QwaWdjdXAxcllnSmtPQnk3enNXZ0JVZFNpKy1h?=
 =?utf-7?B?WEpaaWNxSFFucWRkb21jMzlVV2lrSTVPQSstTklmOTZ1OEtpRkJlRVcyWjg2?=
 =?utf-7?B?enhBKy1xWkVPSEV3Skdqc2RuOEZvcC80cDF2bFRWNGxnK0FEMEFQUS0=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JKlbU61gkWgFODRXU8DxvPXkH1zFeRfmzJ9afxwQZtk/BzMXokhP3K/dzddgmE3KDI4tYZCsdNOnvF0zhmjOT/wUjlwtRcrirId0rUMDvyuy2IL/AuUIz87/JnSha1CD7jSHPfDFV+pmdkyvlSDCUvxLvbGTRkQ4HVDPWrwPDoQF5dCr9suulXuJmVq0Si3ScM4SLhgyJpHmp7Xi43IL4LbNXijgxD9g4vJIWfkfjRDVwnjgsZIDudQZVK48CUhSvF8KdM1RTIXx4VyAASQP40MCtofS3+DEs3ujdBl+2KVv2i01iEZ1E/3b0sPqJOZNcJ38ka0zXnxaL/LcCwkt2A==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF659BD4C46.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4d1a07-0b13-4360-b6bd-08deeed261aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 07:07:28.2186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hU453l39LTOuyP14ZJcxNzjKPHqx922kjn4wPF7epx87po12Fc4dHkikB2seexyXsAA/Fv91yL3D4mT6g2w8qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR19MB997549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310048
X-Proofpoint-GUID: Ja7YcSxKlFWXgTGsNC6C0Lu0j4rnz_cV
X-Proofpoint-ORIG-GUID: Ja7YcSxKlFWXgTGsNC6C0Lu0j4rnz_cV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0OCBTYWx0ZWRfX6ql9jHFFcE5l
 gvtNueKraazhPqC/hsoUp42sFASazIN5ASzl+jmLMoXlO+K+S5jMM5AbJFtnMKA/mBd1gSFNulO
 xU9IlVFpU8MGvM8xqunGI252Hf/B7QQ=
X-Authority-Analysis: v=2.4 cv=BOGDalQG c=1 sm=1 tr=0 ts=6a6c49b4 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=sEWawkeXllE7TocFc0N_:22 a=20KFwNOVAAAA:8
 a=iLNU1ar6AAAA:8 a=jZVsG21pAAAA:8 a=8rWy6zfcAAAA:8 a=i0EeH86SAAAA:8
 a=bt5KbKNvAAAA:8 a=XlRjxQ70AAAA:8 a=LfxEVeEBAAAA:8 a=qgO09VQOAAAA:8
 a=eSb-bNSJAAAA:8 a=ytFMdNZ7AAAA:8 a=6-dRa9qSAAAA:8 a=rxYGZ8eK6g6ihpIWQxMA:9
 a=avxi3fN6y70A:10 a=gbU3OgOOxF9bX48Letew:22 a=3Sh2lD0sZASs_lUdrUhf:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22 a=1uMOUU2w0DxzEe95gQqD:22
 a=7k9nRlTqVbDGZ3p5_T00:22 a=r_vHcs92K7WWAI_28FKx:22 a=h7YW-pclpbZRD8svLbQ0:22
 a=oxySFUAvEW1-6AXleBSr:22 a=NZk92sZ4hQKp_Sw8PGvT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0OCBTYWx0ZWRfX3bW2JFpPmaJc
 3HkDGzw/mcqfkJ+tjgHcM03AmUbGk3YhQyAtb4vc37NXxhCd2ncXY3oZ0irYz8G0j/w4p0vuEKe
 64coSH4uIuZfspyB49aZtvA8ktUQnAQ0E6qutZPSLxsz+FHmJWd21hQfKYd1re+g4M6fT6RDxOg
 jYOCkKo+mwH8hBoCUsBjgU6n8JnmjE7dgFdA39N4Bf5m7OTKeD4R7fLPlxUZbFxJjfE84Zxiw/D
 zMu9+G9NuZS6bLXxo6zUCfpCbRiMRSqXikSX063OsPG+F6O1sbbo2Sdg8+G/IdlBIh8Oj9HW4cF
 g3AhtFK5ShevNFBiDf22m9xvDFMthWtSr0PCxhz9bJcw/OoRHZwA1wEZy8HbZo6+7Pg6lvKF9Ck
 BO88Lix0HNsI6g3DBWwi1GQyeaAj5rNqoZI50w6SgqorsaFCMISJaPK25Ssg5sC3aQ7Wvw0thI5
 J1OrSaCofCe36wpW9KQ==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310048
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




Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: David Marchand +ADw-david.marchand+AEA-redhat.com+AD4-
+AD4- Sent: Thursday, July 30, 2026 11:22 PM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- stephen+=
AEA-networkplumber.org
+AD4- Cc: dev+AEA-dpdk.org+ADs- maxime.coquelin+AEA-redhat.com+ADs-
+AD4- fengchengwen+AEA-huawei.com+ADs- stable+AEA-dpdk.org+ADs- thomas+AEA-=
monjalon.net
+AD4- Subject: Re: +AFs-PATCH v2 1/1+AF0- vhost: tolerate file descriptor i=
n REM+AF8-MEM+AF8-REG
+AD4- msg
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- On Fri, 31 Jul 2026 at 05:14, +ADw-pravin.bathija+AEA-dell.com+AD4- w=
rote:
+AD4- +AD4-
+AD4- +AD4- From: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.com+AD4-
+AD4- +AD4-
+AD4- +AD4- The vhost-user specification (vhost-user.rst) states that no fi=
le
+AD4- +AD4- descriptors SHOULD be passed with VHOST+AF8-USER+AF8-REM+AF8-ME=
M+AF8-REG.
+AD4- However, it
+AD4- +AD4- also says: +ACI-For compatibility with existing incorrect imple=
mentations,
+AD4- +AD4- the back-end MAY accept messages with one file descriptor.  If =
a file
+AD4- +AD4- descriptor is passed, the back-end MUST close it without using =
it
+AD4- +AD4- otherwise.+ACI-
+AD4- +AD4-
+AD4- +AD4- Some front-ends, notably libblkio, reuse the same message-build=
ing
+AD4- +AD4- helper for both ADD+AF8-MEM+AF8-REG and REM+AF8-MEM+AF8-REG and=
 unconditionally
+AD4- attach
+AD4- +AD4- the mapping fd.  The previous implementation rejected any REM+A=
F8-MEM+AF8-REG
+AD4- +AD4- carrying a file descriptor with the error:
+AD4- +AD4-
+AD4- +AD4-         expect 0 FDs for request VHOST+AF8-USER+AF8-REM+AF8-MEM=
+AF8-REG, received 1
+AD4- +AD4-
+AD4- +AD4- This broke teardown and memory region hot-swap with these front=
-ends.
+AD4- +AD4-
+AD4- +AD4- To reproduce, run any libblkio (v1.5.0) application using the
+AD4- +AD4- virtio-blk-vhost-user driver against a DPDK vhost back-end.  Th=
e
+AD4- +AD4- connection is dropped during cleanup or whenever a memory regio=
n is
+AD4- +AD4- unmapped and remapped.
+AD4-
+AD4- Is libblkio fixed now?
+AD4-
+AD4- I am not a fan of such compatibility fix, having to accept one buggy =
client...
+AD4-

Yes, the libblkio fix is ready and will be submitted upstream within a day =
or so.
It stops sending the fd with REM+AF8-MEM+AF8-REG.

That said, this DPDK fix stands on its own regardless of libblkio. The vhos=
t-user
specification explicitly anticipates this situation and requires back-ends =
to handle it:

+ACI-For compatibility with existing incorrect implementations, the back-en=
d MAY accept messages
with one file descriptor. If a file descriptor is passed, the back-end MUST=
 close it without
using it otherwise.+ACI-

While the immediate motivation was libblkio, the spec's compatibility claus=
e was written for
exactly this situation +IBQ- any front-end could make the same mistake. QEM=
U's libvhost-user
reference implementation already tolerates it (see vu+AF8-rem+AF8-mem+AF8-r=
eg).

The fix is 2 lines with no downside: accept the message, close the fd. Reje=
cting it drops the
connection entirely, which is a disproportionate response to a harmless ext=
ra fd.

+AD4- +AD4-
+AD4- +AD4- QEMU's libvhost-user reference back-end (vu+AF8-rem+AF8-mem+AF8=
-reg) already
+AD4- +AD4- tolerates zero or one fd in this message.  Align DPDK's behavio=
r with
+AD4- +AD4- both the specification's compatibility clause and the reference
+AD4- +AD4- implementation by accepting the message and closing any unexpec=
ted fd.
+AD4- +AD4-
+AD4- +AD4- Tested with:
+AD4- +AD4-  - QEMU VM bring-up with runtime add/remove memory regions via
+AD4- +AD4-    QEMU monitor
+AD4- +AD4-  - QEMU post-copy live migration between source and destination
+AD4- +AD4-  - SPDK vhost-blk with libblkio (fio libblkio engine, write +- =
md5
+AD4- +AD4-    verify)
+AD4- +AD4-  - libblkio alloc-mem-region and map-mem-region tests exercisin=
g
+AD4- +AD4-    ADD+AF8-MEM+AF8-REG / REM+AF8-MEM+AF8-REG / ADD+AF8-MEM+AF8-=
REG cycles against SPDK
+AD4- +AD4-    vhost-blk
+AD4- +AD4-
+AD4- +AD4- Fixes: 1d730eea6a42 (+ACI-vhost: add memory region handlers+ACI=
-)
+AD4- +AD4- Cc: stable+AEA-dpdk.org
+AD4- +AD4-
+AD4- +AD4- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.co=
m+AD4-
+AD4- +AD4- ---
+AD4- +AD4-  doc/guides/rel+AF8-notes/release+AF8-26+AF8-07.rst +AHw- 8 +-+=
-+-+-+-+-+-+-
+AD4- +AD4-  lib/vhost/vhost+AF8-user.c                 +AHw- 9 +-+-+-+-+-+=
-+-+--
+AD4- +AD4-  2 files changed, 16 insertions(+-), 1 deletion(-)
+AD4- +AD4-
+AD4- +AD4- diff --git a/doc/guides/rel+AF8-notes/release+AF8-26+AF8-07.rst
+AD4- +AD4- b/doc/guides/rel+AF8-notes/release+AF8-26+AF8-07.rst
+AD4- +AD4- index 3d18ba2dd0..86042bd5e3 100644
+AD4- +AD4- --- a/doc/guides/rel+AF8-notes/release+AF8-26+AF8-07.rst
+AD4- +AD4- +-+-+- b/doc/guides/rel+AF8-notes/release+AF8-26+AF8-07.rst
+AD4-
+AD4- We are working on 26.+ACo-11+ACo- ...
+AD4-
+AD4-
+AD4- +AD4- +AEAAQA- -85,6 +-85,14 +AEAAQA- New Features
+AD4- +AD4-    to support adding and removing memory regions without resett=
ing
+AD4- +AD4-    the whole guest memory map.
+AD4- +AD4-
+AD4- +AD4- +-+ACo- +ACoAKg-Fixed vhost REM+AF8-MEM+AF8-REG compatibility w=
ith front-ends sending
+AD4- +AD4- +-file descriptors.+ACoAKg-
+AD4- +AD4- +-
+AD4- +AD4- +-  The vhost-user +AGAAYA-REM+AF8-MEM+AF8-REG+AGAAYA- message =
handler now tolerates  an
+AD4- +AD4- +- unexpected file descriptor sent by the front-end,  closing i=
t
+AD4- +AD4- +- without use as permitted by the vhost-user specification.
+AD4- +AD4- +-  This fixes interoperability with front-ends such as libblki=
o  that
+AD4- +AD4- +- unconditionally attach a file descriptor to the message.
+AD4- +AD4- +-
+AD4-
+AD4- ... and regardless of the version this was put in, this is not a feat=
ure.
+AD4-
+AD4- We usually don't put Fixes: in RN.
+AD4- The AI bot nags too much.
+AD4-
+AD4-
+AD4- --
+AD4- David Marchand

