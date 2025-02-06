Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4BAC02196
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 06:39:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5683C4066D;
	Thu,  6 Feb 2025 07:39:18 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6C3F94026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 07:39:17 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51668p1T023823
 for <dev@dpdk.org>; Wed, 5 Feb 2025 22:39:16 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44mqj701nh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 05 Feb 2025 22:39:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD4dW28eP4cYJ76PiquaW0vOijixnC7G2R3Wu4VK4ZJKzi63dREBl6WCwfeM60pGj/D1yd+Uo0Bv5cB1FxUAIQfVXQgZbqGlUFZPtv4XScCpt38ByrHLwtB63lxBsGjOnMHMjYLVBeJMVi2jecX5z1Z/tdhrB5uFvTF8X3W+yurHMr461V+Wi3t2g5yXoIlX5cjA/Q3756n4Z8ax9zMKMZf+GM3gmdA+WdIjCyORoSgV9+BYQ+Fyz++SF3GSnd+3/9kliiKU43IO/i+nR+utbAeFDlKZSjP52euhxwMHR+Vs0CWjWcf3LkRIbkLuwfOoJihiirIs/aL+Utmn3DAdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0exVCWas47MlC0fzX2sU64BJvT2GsYpLKBxe4uy2bYM=;
 b=cUKgAfuW0zopulIEH5Va89QBzRuObn1D80fEoibAmPxfpw8w8tB9IJDiDDUpo1ZqJ5vozSkzibxIsmcbPA21+vFh1Bct8Ed1uyFqNAWt5cnO5nwGmu8fPs1+XCk2P846mu9q0h5+RIMdXFkQ08bDgbHbXJs3Bv2NrZyCb72BmLxu5RQjnl/RdwrEnDW4OtFpZ+Zo57H1Gn61BPEKKgVt3JHr/0TGWWHaS8IEelVG4sDzvMEglkOySIMEcSMfXZsBEcpzkycp8LQowkVa5pI22sgVRAu/ZPMBeYTrUGEZt8CuZ1v24xAA92nQuRVDzBOMHlM9Eqs+e8ep9YTjbFaHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0exVCWas47MlC0fzX2sU64BJvT2GsYpLKBxe4uy2bYM=;
 b=Y221OkJ3H0dSuaHlQHPQfEx6HdpvhNmEqkZ/flCvMq2xLe8Iueds6UbadVE8oypUFMB9RvljarPx7ee4CrB29NUhgMMOwMvYxGAMx1gBcqiNtjqRxiB+s1uq8VYanTU1HuB1thPhpaGn7Bn1jwgGxlnwky/+f2Ynu7QlEGiyLaY=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by PH7PR18MB5776.namprd18.prod.outlook.com (2603:10b6:510:309::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 06:39:14 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%4]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 06:39:13 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Satheesh Paul Antonysamy <psatheesh@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Satheesh Paul Antonysamy
 <psatheesh@marvell.com>
Subject: RE: [EXTERNAL] [dpdk-dev] [PATCH v5 1/2] common/cnxk: support NPC
 flow on cn20k
Thread-Topic: [EXTERNAL] [dpdk-dev] [PATCH v5 1/2] common/cnxk: support NPC
 flow on cn20k
Thread-Index: AQHbd5DWryWKBZyxXku+vKVmJP4Xq7M51F7Q
Date: Thu, 6 Feb 2025 06:39:13 +0000
Message-ID: <BY3PR18MB4785E73B0BC4FF6198C51DC3C8F62@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20241021040144.974453-1-psatheesh@marvell.com>
 <20250205054247.1214565-1-psatheesh@marvell.com>
In-Reply-To: <20250205054247.1214565-1-psatheesh@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|PH7PR18MB5776:EE_
x-ms-office365-filtering-correlation-id: ca6fd889-8666-4acf-5daa-08dd4678f89e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RGJVVlNWaTdQaS9XR0FMWUZ2SFNUa2w0ZGV6N2dLMFZvbS9CeUdQbFltMzcr?=
 =?utf-8?B?NFI3bldlOHByWk9OditVSnJkbkdidzdUYzFqUzF5NFBTNTYzWnhFeTdqNCsv?=
 =?utf-8?B?cWZzTjJYWkh0MjRtUlRiWHVqbHI4QXY3UXdXN1NsLzQ2czNVdHMwSXFKRWpI?=
 =?utf-8?B?L241ZEZZV0J4c1BZVHV1aWN5VnhscXJRSjFiWnFZbXQxc3B1R0hhT25PTFEw?=
 =?utf-8?B?U2dCcVhScHVFY3dwaTVlZjVtaTBNVUhTZmlOUE43QWV1TUtNbFJUdUhqQ0xa?=
 =?utf-8?B?ZVVXTnBBdW9KSEtyWVRJN01NK3lJZ2U1RURKaHFCaVNrbThmamtoM0E2N2ZK?=
 =?utf-8?B?NzgyYm5hZFpvZ21raFJoU011QnJyV3RSMm5jL2JYcDJYdEt0bVJ2MU1VUWI0?=
 =?utf-8?B?ZnNvTWRIKy9NdFNhQWI2K3FRQmQxWUFBeXljTjlVMVVVb0ptVFNFVURjdmNp?=
 =?utf-8?B?MWlEWjZWZ2xjWUlBUkFua1FJSHMxVit3UXdCcnBEek0wdkZ5OXJPUkVoQ3RX?=
 =?utf-8?B?c2JaSVZvbTZ4cXl3ZTVxaEg0Nm1IL1V5aVZvNWp1MFRYd0dzV2NLYkxseDlD?=
 =?utf-8?B?d0R6SFR2RWNoMEpJWHFwaXpHY2tKZnZKS1hZYkRUM1NUSEhibEx5RUZLY3Er?=
 =?utf-8?B?TlcrVU1WaGFRbXhPVHg1SU45L0NvNFdRYXZzcE41WTg5Z1ZHMTZ6ZUl6K0Ro?=
 =?utf-8?B?aFhsdmJzWEIrbFFXR3N0cXBBdUI1ZytJTGpBeDgrOUllcGJETkttNklBRlJ4?=
 =?utf-8?B?T0RMZVFJcjNFTXVQWjNEZWtIUEdSY1h1b29lQXl0RG9rT0xhTzNraSs2cXNX?=
 =?utf-8?B?T1RDMFFzWXMrTDVZdVlxQVhKcHNuZFp2cHM2QXZYQnc3MERLcmZHYnVnTXM0?=
 =?utf-8?B?cWdqWjU1MEZQRitQOUpMeGV1L2lxY2lpMFRDMy9Hc3JZSGtJckM1WEtYY3VN?=
 =?utf-8?B?ODdHUWJBREZ5NXZubkUyY2U4NVNGeENuYWVNQnA0a0Z3T0NlWnRpVlplWDB6?=
 =?utf-8?B?cGZlSk12WnFXZEY4OGxDd2dRMXh5Z2JpTjRxQ1gvb1JvSFZ1Q0pyT2l1RFpV?=
 =?utf-8?B?MkZ1TlAvM29JRlRoOUxZeHU1c09hUUE3MWRtUXVOMFdObUtmZ3d2UksxQWpy?=
 =?utf-8?B?RDBFTnNEV25yeGhSK0dxcHhldmNkRWs4MDVPazhyTE5hakxIR29hZ1ZUMERs?=
 =?utf-8?B?YlJQLzN4VmJvTlJ4a2tNbGZrdm1razQ0ZE5udDl3VDJJZVR5S0QzRnJqbE5S?=
 =?utf-8?B?emVYcW1SSTl1ajJQUnRjYTBwUG1MV2ZXdHJNdjV4a2ZaRDBtTEE4dTFSSVNG?=
 =?utf-8?B?bm1iYzBUY1F6M1BLLy9ZU2gxVm5EbVpPanJCT0YvS1VHTDlaRmhqSk9WeXFW?=
 =?utf-8?B?MkNJRXoxVy9wWElBZmI4TnV5NUdac3l4ZXRpc3Y5OTdzVU8xSGhGRldpNjFY?=
 =?utf-8?B?UUs3VUhIYmZUNERJMmtBVXVCQzVQeFY0UERONUpXUWV1R1hhTVRzbysvUEUw?=
 =?utf-8?B?RkV1QWRxNXZxcXZFTUc2V0UyU0twTUZoa2U3TUljZ0pVY01ZbTkxVmcwRnpG?=
 =?utf-8?B?RUhnLzUvL2FBU3FsQmxRK01CdE4zQXdiL3JTRTJzZWNCeDY0Rm1LVkFiY244?=
 =?utf-8?B?NGZoZy82WmFDSkFzRFdhM2pxd3hYREZWZjZYRXhpT290R1ZQTFRlVTZyRUx3?=
 =?utf-8?B?Z2ZoM1h0djB3Ti9mcmc4bitYcHJ3TWNrcno0Y3h3ZzNYZnVEOXFNMkN6SUN4?=
 =?utf-8?B?QVFQY1hLSy80RzBGak9wMDVXR3F0b09UajhNOFdXZzZqaStDWTFYTHFLWFF2?=
 =?utf-8?B?SWw0blZaOThBaldFOEdhNEdVVDNsQm9yRktyUWNTdVptelRLSEpLTXZxSDNQ?=
 =?utf-8?B?M1ZvWkdrdDF5QjBCSFBSRXcyV29sNnFTS3lhNkVuNnRYRkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?em1BMHo3NVpOTkNORTAxQUV3QnpIVzRtZ1JCRHlzRStmLzNaYVlkTmNnbXpT?=
 =?utf-8?B?ckUrNGNrTFZJSGZnNXVvdE9QbGtVUUcvZHppenNCdHd6Rkt5S0I5M28vcDBR?=
 =?utf-8?B?QU1RR0VGd2pQZE9WSWpGSEJTZWtrWjVoc3hnNVZkR0NUTkd6VFBMSytxUFAw?=
 =?utf-8?B?TWNNbzRRck9HQ0tRZlBJL1pQWllObjJORFlQSi84K3ZPRHFaNzU2UzBwMDdK?=
 =?utf-8?B?TkJnd1RGNE1Ea2o3b3dLc2hTbTBBUUdEUGVkMzFud1FqMElvNEtXWDRrNmVL?=
 =?utf-8?B?aitSejBxdldaeW1rbUplREJpZWo0ZG1FbmxxMjJEL0FKZTgwaFNRWXJ4dW1h?=
 =?utf-8?B?dXhwdjhmWEF0SkRodlRheVkwN3JTMVJuQ2ZXdVgxVjB4NVpNdHlYbkd0VUZY?=
 =?utf-8?B?N2Y4dkl1UjUvV1hncC9Mc0VBazVXZWNwbXQ1RVdyME5acW4vaUxEdWE4dndr?=
 =?utf-8?B?TitBYXhJL3BoZEdsOHNTOFJ1QndzMUZpOEFDZmViSWhJL1lFN0tXeE9mNFkv?=
 =?utf-8?B?MUpxVHh4OEZDR1JQVFk0NjJtUGhnaGhzbWp6QktJNjVNRmNyRjBIRVVRdXRJ?=
 =?utf-8?B?bjhMOE1jQ1lPOW94b0MzOXlSRWcyRXZhME1JbVk2WnNMRU9TejM0UXhpci9B?=
 =?utf-8?B?SGxBNWErc3JaNHZheURrTDNVT3pHKy9EUnBpYUdkaHhKL052Y0lMdFhrWG16?=
 =?utf-8?B?OHJNRGNWZEJUbExTeSt4MkNTUlhsY0F5RVUxbS9xUklTdEdVdDNhUG1FOEhG?=
 =?utf-8?B?anJhWnVCREFTb29od2poNTQ0QWV2VUVlRWhiRU9QRzVsYTZjT21JekpiM2c3?=
 =?utf-8?B?U1JUYStXbU9aOVJ5Y0UvZS96QmRVRUZ5VWVCTHVvNlZqUWpQREdsRlRWaEdW?=
 =?utf-8?B?dmdxYmVYZ0JMWE5nT09UNkl2UmdOWlZISDJzVUZBUUdDK2gwU2lFTDhsR3R3?=
 =?utf-8?B?czlPeVh4djJDdk5JaWFzSDdnNE5McTJnRWNaTkl6QjVyZFRKYjd1ZGNrK29i?=
 =?utf-8?B?Wkt3aWUwSUtwVDBCK3l0dmI2MU44TWVWZnh5SHR0MUkrRHpBVWlmZy9LK01t?=
 =?utf-8?B?dnk2V0d2UjZDRURFd1FhdmltcFl3UkxudU5rZzljSWpPSXhnZWs0ZThObk1L?=
 =?utf-8?B?V0JOR055ajVxMVBURGZZVzBqSXMvTGpZY1drcnNIYmo2UHAxdEFQQ2xEb1lk?=
 =?utf-8?B?NysrK3ZiOUJnSWxtQUtxUG4yb0VSMzZIeEMrOThrcWdNT3Z6VlNNK1g4Zy9Z?=
 =?utf-8?B?WXJBUTErdzc4OUx5cGRPOXJzRXgvTXhHRXNWTmhjeERlb1pDaTgvUmxPTkc3?=
 =?utf-8?B?eHBDSVFmR3RJbnNvRUpoRExweU5BaGR1MmVFMUlOY1VNVHA1WmYwYTdNK09N?=
 =?utf-8?B?c3laaDl5Rm94ZXFXNVl6Q0J0VmUwbEM0VXVGTzg5Y2l2QWhvbmZ5NTVGMVBa?=
 =?utf-8?B?Rmk0WUcyRDdWRXFyeG9GY3hjakIzbi85OUVUVyt5NG9LSFNpZ2ZtTG5iQlJv?=
 =?utf-8?B?azZyYnp5WjZPNUZyM1Q1anFXZm5DOStWR0Y1dThMR1JUd1ZQeUt4VTBkb2JL?=
 =?utf-8?B?dG15YlNUbzhUVlNJM0o5T0pwWjYxV3MvTGxoMzhUOE90VW5JU2o4bHpYQjdC?=
 =?utf-8?B?UHREeW9lZm1LVUJGRS95UWJ5WTk0TGU4WTV2VUVrL3RCRDlZUnd1M041STJx?=
 =?utf-8?B?aS8yY0hHTGRsakU2S3ZnbmY3NjhpWExYb0k4bzhIMmthM2MxYUVUajZwUlI3?=
 =?utf-8?B?QjVOL0ZQL0J5L0E4alhEZTdhd2NxTjNTVFRaUTdBdVlMM245dEV2Nm5DeldE?=
 =?utf-8?B?N1hBTUpZYnVkSjdiUThVK3VRZklubUlmVkZZYmZiM3ljSGkxU25uVGROWWtw?=
 =?utf-8?B?Tm1KbDhFb1c0MElZc1NpUHBmaUMrOXRXUUR2c2tMWDRBOGZGdHFyOFFrZGtU?=
 =?utf-8?B?cGJ1RzFDaE5Pek9rajhJZkdrLzN0MHRuOUN1ZEY2ZHVscDJkb09MNGVsdGV1?=
 =?utf-8?B?ekVrLzVqdnhmOHYyWVV6dVlDdXdwZlZwOUpjSWRLLzZ6OVZnVjZ3VFJwbCtx?=
 =?utf-8?B?VmVZb2pCa01Oa2I0ZjlSQjNBMUVVY2FhOHdIdnRmS1Fkemw4aWVTT0tSaVY0?=
 =?utf-8?Q?KN2c2ps1/PvUMnBsQ8IqItSuc?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6fd889-8666-4acf-5daa-08dd4678f89e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 06:39:13.7580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQVXfYCw4xIiW9+lK5lP1WZxO+Evyrw/WiG1qOzeZwrBmQBXgSlzQpHVQBOJONKOmroK7kW3k2bV5f3uis6UVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5776
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: eIli_FYuTUv8apn61RrZ4rrlT7e-5Vgk
X-Proofpoint-GUID: eIli_FYuTUv8apn61RrZ4rrlT7e-5Vgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01
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
> Sent: Wednesday, February 5, 2025 11:13 AM
> To: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>; Kiran Kumar
> Kokkilagadda <kirankumark@marvell.com>; Sunil Kumar Kori
> <skori@marvell.com>; Satha Koteswara Rao Kottidi
> <skoteshwar@marvell.com>; Harman Kalra <hkalra@marvell.com>
> Cc: dev@dpdk.org; Satheesh Paul Antonysamy <psatheesh@marvell.com>
> Subject: [EXTERNAL] [dpdk-dev] [PATCH v5 1/2] common/cnxk: support NPC
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


Series applied to dpdk-next-net-mrvl/for-main. Thanks
