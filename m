Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625D7C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:01:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A79C740E0C;
	Tue,  4 Feb 2025 16:00:59 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8492C40265
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:00:58 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514EEpPK007199
 for <dev@dpdk.org>; Tue, 4 Feb 2025 07:00:57 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44kmg4g2rp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 04 Feb 2025 07:00:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A67iImLjLB0Qwuziugn4PPNUX88tVxmDyR/XICt+OW8a+UlchadhU6TyDK/SvDm9AFkV9QNElQW3RyuGm7pFzL9Zl2iv2ify3PFzIdO7a6nVOd8ogcMVoYCKt4mk+QfGKMIngIH+TTnViZP4t59jLRep+ldueHHj/W3PN/vevM0f8UoGFI012+6RsTn2CYnH1q33WkpGTW+mGUAocd+iiwJLTOU3pm2XLDKOuMGq2xiXE7qs+Oibm7k+8QMLcUm/oHiQR2jhJR2zPg6D8UL6/Cy7H4L39peP3Qh4EJss8EJn6CezUv42Fi0CrHnTC7EoOdrTwA2TK9l6qOHNrjtrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxs8t7W6+tb6kVtpppfbHjy29TJrtICnRU5NPsi0s5Q=;
 b=B9Z5O5kNtKj4X/Ojna6S1LOBY8xYE4Ac2/ItUTgcVe3QD39oWTlMEq3LIjTwfWbvHcRAHOAY2OZCf3W71nG/wK/UmUBPtgZNAXvulPqa0RHbKmjQjkl4qBsyu7tCtXv86RFcJfR6zMplK7jLThMk6VWTd85UFJ6Ney0Agm5uT6Y2jSu1gwIuOG9kwNOzqwbFEoFBic9URJy30TV25IbOeNOpIEz8ATvWB76NrtVtP/Q0TZxkwdMkb5A54OC8YzEL/shj9jGzsJpuIoWXrr6zp0Zvte4VE+OXod03JKSdW0TO5MAb459r51LGQ1LFjEIJhlBSSSe70IF7rxqCW2Z+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxs8t7W6+tb6kVtpppfbHjy29TJrtICnRU5NPsi0s5Q=;
 b=qap7+X6bpzs2bfULywLSRRnZ0NFZNdAL25gVLWMmpdTLQbwgdWgSNVjqJ/nW6yTSHhR94m/KHWPKwhFrw6BPDMS2PQQ7cRDo7W6GMBNXrmJL/WHUo/QkHGTtvVrHpFqPGNaijtOoOPVPM9TQQeRF2GCBYBIA8oQpRJ/7C/K9NxM=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by CO1PR18MB4732.namprd18.prod.outlook.com (2603:10b6:303:eb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Tue, 4 Feb
 2025 15:00:53 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%4]) with mapi id 15.20.8398.018; Tue, 4 Feb 2025
 15:00:53 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Satheesh Paul Antonysamy <psatheesh@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Satheesh Paul Antonysamy
 <psatheesh@marvell.com>
Subject: RE: [EXTERNAL] [dpdk-dev] [PATCH v4 1/2] common/cnxk: support NPC
 flow on cn20k
Thread-Topic: [EXTERNAL] [dpdk-dev] [PATCH v4 1/2] common/cnxk: support NPC
 flow on cn20k
Thread-Index: AQHbbVsW1ZWvzBwyb0mHgq1az0C8zbM3UCDg
Date: Tue, 4 Feb 2025 15:00:53 +0000
Message-ID: <BY3PR18MB47852DF9E513C3EF192CBEDFC8F42@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20241021040144.974453-1-psatheesh@marvell.com>
 <20250123055247.3784086-1-psatheesh@marvell.com>
In-Reply-To: <20250123055247.3784086-1-psatheesh@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|CO1PR18MB4732:EE_
x-ms-office365-filtering-correlation-id: 37785d01-fff3-4874-f504-08dd452cb8d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?MXUrZ2MwcFNnNHhqREF2MzhKelliRTBuenBqUmFybU5KOTh5U0JHSFk1TnNy?=
 =?utf-8?B?aDg1OEdYSm1MeUlYOUgzSWFkZExYdUc2YzJpbHRHb0sxbmJ2K1VHWVdBaGVN?=
 =?utf-8?B?WTRVTzUvOTZLYjFVdXU4VTdDMXRUQVdoMEMvMGJIeTlGNEpEemNNWndqQ3ho?=
 =?utf-8?B?N1kzUUFFN1hzQkZiL0dKTUZ2NHZQdWNjcG91ZHdIUGZpVWE3SVVJVmlMM2lQ?=
 =?utf-8?B?U1pGeForMDcySGtzRXhrTG5UdkRqb1pCSWxlazk2b1lZV1VWZWk0dHEyQmw1?=
 =?utf-8?B?TVdycnFNNjJJRXpzMXhseWpNUVFVNFZiZ3RPY25PRnRPZVg5VjRFaU5MTURX?=
 =?utf-8?B?OGhrK0tZYVIvNWJ5eXNzczFUdjhob0F5NHo3RXBvNE53Unk0NjlhM3VFWTZ6?=
 =?utf-8?B?ZnBiRTRCdUU0c2hPdlphWEkzZjFObk5tY3BINWVXQUFpOElTWEFXWS9aZ0tp?=
 =?utf-8?B?ZTcrVUtjNnVIOXM5VmpyKzkzYTBpRXdVR29vYThXNFhjVHBBQnQyY1JBd1JP?=
 =?utf-8?B?NXFZVWhINHJ5eFVGWmVla0N5ak1yKzNGZ2hCUTJ3WUJkZ1ZiT3piOXdzVjFB?=
 =?utf-8?B?L3ZvUkdrdzhUbVZwZVhKOFlQOXlOcmhiV0JlYWttblArWFRlTENWQkVQREFI?=
 =?utf-8?B?YWhIbDloQlR3T3lsL2FCOE93bmJlOEZ6UUhoazJWOVdzMzJEM0hXNWFPbUZp?=
 =?utf-8?B?bXI0enp1U1c5bWsvMnc0VmxGZGxXRjQwMHhMTFBxTSt2S0ZLWjcyV1V4bTVj?=
 =?utf-8?B?MHpLOXFmc0c3ZE1ZYjgvZE85cEZuUTJ4UnBzKzQrUEJwOFNRL0tUT3RlQjBq?=
 =?utf-8?B?SjlpVjdKZ2JWbkhEa2lpMkprVTFZbHF1Qnd4bkN6cjUyK1B4QnBuWGdLb0ZO?=
 =?utf-8?B?b0h3djE2V1ptVXVWaFhBOHVwYW51RDZBK3dldHdCcnNjVmY5TCtwd3BQd0Jv?=
 =?utf-8?B?a3pqZ2o0QVNBeTlKWUpDSTZnSXFpczF6RU9JbGhsUGI2eXJjLzBDQWJsQ2ti?=
 =?utf-8?B?a3ZvaDcrUURpUEhqbEZjeWNYNEs0a2FTUFlyL2ozTjkrWWJ6NmcvdElMT2Vs?=
 =?utf-8?B?NEVHZVNna250YnNnV3BZSUF6ZVlURmFISkkyc3o3aE1oL0V1cDl6WTlQSEZj?=
 =?utf-8?B?VnZ4WnVodHZkT3VDc1VnbkhWYmpVcmNYU3lVei9pVENaNVo3dE94OUdJdW54?=
 =?utf-8?B?b2o0TFNZcy9vb1VzYnoxK0pLOHBEbG9Nek5hQjEwQkZmZ3BmQVFSeXU1YWVF?=
 =?utf-8?B?ekRjUjZUcEl6ektTR0MvSnUxcFBEa0tIZkwwSHBFL1hDRGNhd09ubU5iWE00?=
 =?utf-8?B?YUxzaHdHS0tXSGpMZ3NnaGVlMlFMWGk2THZLckFFeXgzQ0VKNnBOV29lNVgv?=
 =?utf-8?B?WERFZmN6aVJvemZPOThVbXlnNTlmcWtYQTdXUmtuUDIxdEZSVjhIQW5oc3gr?=
 =?utf-8?B?b1Y0dmFMejBVR3V6Y1FYWS9QeXpJazlRb0p0ald6ZHZTT2tpNFdjdUNhWlhn?=
 =?utf-8?B?WE9WcG5LdnBPMFpUNDZQNzIya1RPZTVKMnNrUXVSUE1sbldpQTZEYm5NNXlO?=
 =?utf-8?B?L00vQmJQMDU2SW50cFUzODV4aXBOYkhCTFUwaDdKbnRsZm9sREFFWTllUWd2?=
 =?utf-8?B?T0Q5c3QyeXNXSW83dVZyTmkrV1JwZjVvbkhHMTk1aGUwSEI0VXQ3RmJ1L1pB?=
 =?utf-8?B?T2xGSnQ2RWxidHh2TEJYcXhYdkxEQ2dDcCt5dUlKWGx5TTJNRTQ0Rk9iTUR5?=
 =?utf-8?B?SzVOb0pqTzkzN3dmQVEwcUZaMVpSc3BXK3VzWkpnZGNrRUdUU1JPYVBVN1Vw?=
 =?utf-8?B?N2YvZ2lwVEV4NnF5Z3VtV2UxdHZLcUt3OWQ0enF5SzJqSXBWanE4cUt0NFZ5?=
 =?utf-8?B?ZVRxK0V3TXhmbDdNV2JGQW9NdU51cHRPMGlTUVFCcStRckE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1NPT1FtbXNOdkMvaVJvUlp2S0M1U0MzOE16MngrNzVkL3NEck1NRVh3QktR?=
 =?utf-8?B?d21hRWlOTDlVb244L1A2WGgwWElPemp6RFBpQXhmcVZxMFZzVlNkdzVOZ3BP?=
 =?utf-8?B?S0xOTVhMcVlFTVhLY00vc1pDQWptUFBreitZKzNkZS9HVFErN3hLc2QzSXBR?=
 =?utf-8?B?dTNuWHR0SlJibXlJVnlPc01EN2wwU0FiSFFOYitUZEJkQTIva3VwNWJLTmht?=
 =?utf-8?B?bkoyanpPVHo0ekhkTU5MaTJSV1UzYS9TVk15VGFlT0FKRkVWSzlOZU9wc2lz?=
 =?utf-8?B?TlpEMUU0aEtlbzQrSXRWSkkyRU1hVFhFYVl5V3NvaXphY3JzclVJRUUzR0p6?=
 =?utf-8?B?VzFkelJaMEtDWGZzZWtwbDJMd3NZeU93RlFmV3R5NUx3clFjZmxud0V0TTlj?=
 =?utf-8?B?eHhTdTc1b2lmSzVBLzZmN2l0M1JWSEJCMWFNV0dkaEdJVzZzeElCTmxhUkYv?=
 =?utf-8?B?OFdYZFZSc2RGR0NWdXcyNWErNENyZ0VtRGdSMXpDYS83bllFd05sMThmbEM1?=
 =?utf-8?B?WERTZjMwQ09McEV4MlRPTWwwcHFHTlcrUmc4MHJtMFRKRDNxd0J6R05OaCtY?=
 =?utf-8?B?ZTMvSCtUbkw0T21welBXblhQcnVMWHVCR1I1TlM4VXd0c0VPUllLb1BiZDds?=
 =?utf-8?B?L1RFMFB2TitwM0ZOcGpyTTdoTkFsTzdPM00yREtOUHlxd1R2dFVmd3RHNTdD?=
 =?utf-8?B?dTdMWWRXNXo1eEl6UnJiMVF2dGlqMDFUSUVsc1NvakRUaXp5ZTlkcDhkck00?=
 =?utf-8?B?L1BqcmVOSDZ0N0JzMnkvV0I5RU1HT2tSWEN6cVBqd1EwUm11ZFFxUHY0QXpQ?=
 =?utf-8?B?eGpkNzFXaGhjZUVNUllnVDJ5YTJQQ1haZGRNcEQ1QVlPREhtblEzWGpRSDlG?=
 =?utf-8?B?VTJiOU96MGxkSmp2YWsxVnhXcmJBNCsrTnpuRkdJdEI1NVFEYWh4K2F3K1R0?=
 =?utf-8?B?M0JlUlpyYUY2S2xUNWNPY0tSVmRjZTdTT0g4UmhqK0NpMkl2d2hOZDAyVVQ4?=
 =?utf-8?B?NnlXZlNwTGxFTGdwMXAwVFF4MUtBcXU4SE5lallGY3h6R3NBSjV2R0w0dHJj?=
 =?utf-8?B?WHdXNnhyMWcrbndGRzZyRmlabzNGV0p0WnJJcDlGV016a2dnbjh4TUhtWXJQ?=
 =?utf-8?B?SkZ4Sk15RHg0NE1tcTNRMjB2K2N6dlh5aEN5bCtneHRtVDR5RVJuVkRYZG1H?=
 =?utf-8?B?QkJoVkpXNEw4dGVualdkRlVWclJJQjRzZ2Q0eVVLTEpGaU55Nm1iUW1vZ0dE?=
 =?utf-8?B?clViMG5sUTR4L0Jtd01mQWd6VElJUU5MUy9OVkZBYWthMnVMMHhQZUZFT1Q2?=
 =?utf-8?B?ckZnTUgvTEZUaURjY3dHdmdoS3pvUUxwK2JybDJFV3AzWTVqWXRPQUQ5eXpQ?=
 =?utf-8?B?ZFRKYTR5NDBueHU0YUYvb2xJNWJKaS9Pdm9xbTRqVmlhMjBxZHNsZEVoSnhC?=
 =?utf-8?B?VzRqOG9YUi9TVzdFdjNlV1gzRFZyNU9UZ2xxMTIzV2FsWmE2SnVJK1JSOTUw?=
 =?utf-8?B?YndYRWFEN1ZoQkZRcE1HdUNzWTFQeFo1NS9MSHFCMzhXWUhCOFV4aElKR0Nk?=
 =?utf-8?B?ZGhzcHFXZi95SHl2UWNPa0lDbWpxbzcxcEh2T3JGVkFpVUZZS2dmTmhRRm5l?=
 =?utf-8?B?Sm0zSGQyRXFEVk9WNHFFeDNEQUJKRWFndVJOeC96eWFpOC9Yamd2bDNOZjh1?=
 =?utf-8?B?TUR0akxWRzFUL0U3Ny9rWGE5enRPV1Z6WHcyekJHQmp2dHZHRENwT0MrNmhl?=
 =?utf-8?B?RDNkcTdNNnZmK0NPcUxnaWJFTVpFaXhOUzlLdUNpSVFyL054Kzc0VjU5RXBr?=
 =?utf-8?B?bVF6U3Q3MUM0N0RRT25ETWFiTzNzcHprbW85b3cvS0p0b3NCZmVsWDdUZWlP?=
 =?utf-8?B?c0tsbFMxN0thK2VWRHpLbjBFdEF1ZStXU2RNa0kxazR6c3kvNWJ6WDlYS3JX?=
 =?utf-8?B?cG83ckREUVpEZTRMMkUzeGlOdmJJZ0ZmT1h4RXIxS1A3RkNlT0tlbU4rK1l0?=
 =?utf-8?B?V0VvaUduVFB3WlY1bDFvaTFWYitvYWZ2YzVGUDNpbEVOTlJraXhRUkJCVG9D?=
 =?utf-8?B?MkNwR0thRlFBVmN5dkEwNG82eXgzRXA3SFkrcEJPaHNDSC9CWGFFSTRNK1Fz?=
 =?utf-8?Q?Gcz0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37785d01-fff3-4874-f504-08dd452cb8d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 15:00:53.8139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqlw45vNJ2kkolAWf+f9EftqUMLj2kIC/mvEDztjDeabE2QcZSqzHwyDZQm/X2OoTifcW+L0bnknR2IHFDwn4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4732
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: eQrfZZH_zF_ZTSM5W0RgqN9n73YIQT44
X-Proofpoint-ORIG-GUID: eQrfZZH_zF_ZTSM5W0RgqN9n73YIQT44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_07,2025-02-04_01,2024-11-22_01
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



> -----Original Message-----
> From: psatheesh@marvell.com <psatheesh@marvell.com>
> Sent: Thursday, January 23, 2025 11:23 AM
> To: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>; Kiran Kumar
> Kokkilagadda <kirankumark@marvell.com>; Sunil Kumar Kori
> <skori@marvell.com>; Satha Koteswara Rao Kottidi
> <skoteshwar@marvell.com>; Harman Kalra <hkalra@marvell.com>
> Cc: dev@dpdk.org; Satheesh Paul Antonysamy <psatheesh@marvell.com>
> Subject: [EXTERNAL] [dpdk-dev] [PATCH v4 1/2] common/cnxk: support NPC
> flow on cn20k
>=20
> From: Satheesh Paul <psatheesh@=E2=80=8Amarvell.=E2=80=8Acom> ROC changes=
 to support NPC
> flow on cn20k. Signed-off-by: Satheesh Paul <psatheesh@=E2=80=8Amarvell.=
=E2=80=8Acom>
> Reviewed-by: Kiran Kumar K <kirankumark@=E2=80=8Amarvell.=E2=80=8Acom> --=
- v2: * Fixed
> generic platform
>=20
> From: Satheesh Paul <psatheesh@marvell.com>
>=20
> ROC changes to support NPC flow on cn20k.
>=20
> Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
> Reviewed-by: Kiran Kumar K <kirankumark@marvell.com>
> ---
_LEN];
> +};
> +
> +struct npc_get_field_hash_info_req {
> +	struct mbox_msghdr hdr;
> +	uint8_t intf;

1)Looks like __io tag is missing
2)Please update the release note for this feature(rte_flow support for cn20=
k)

> +};
> +
>

