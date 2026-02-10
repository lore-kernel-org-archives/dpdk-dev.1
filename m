Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9542CEB26F5
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 18:27:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C040B4064A;
	Tue, 10 Feb 2026 19:27:00 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B1B94402B0
 for <dev@dpdk.org>; Tue, 10 Feb 2026 19:26:59 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AHsMjh1274006; Tue, 10 Feb 2026 10:26:49 -0800
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021123.outbound.protection.outlook.com [40.107.208.123])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c89g1g2t3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 10:26:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz4oke3TBznxla3cP+1WiCd1/1vF5NRPgbotzx92V+t/wgfCRORgf1gkjGCyGhWkMWjPnR5CmBrD8RItGkVimcbLW1q7IOw7E5DIPBvcAcYIY7OlMIf5y7rh71dSnwSC+kokG8uxLr9pqzttTxq1uurC5e8txFms0VUTejICTSzGXO8H1LYqSeVBZWafFNIENFrD13DBuUhnxq61YQ8QLG8ulMfWoBmOl1r5C9yWltA7U4MBmnOQ/FoGfz+Au0oDWxlc/kZHUval/HzlSnQN8tBePYgHeE2oiVhNa5LH5lZLYiAqkqcBiZKymVybDpQSVUOk2zdRrg3ypXxAuIp+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieroLWvT7yXr/zmmNkYS1r2f50lYWCB+1rt+1ZdGmqY=;
 b=S8FY8VxpV11yOv7orjsC5sK/+yXG6GT0WGjrGCqR48nyDE7fiUdulXu1biZO+oHdUq3qMtEeYw0J2PbeQODZY7OEdVrO2OWbRplLnYKtndQJ54gM3kFbGbbf6ZTPdo+s6Le0VWjcGRa1XG3rLgS9mPLcImUj4Zjk2wt0O5Fawq+mRAemNrDvBqBPWxcyliTyaSxps4rN59/wGOlews77GycgAjn7nVXfTG9QWmKz3BzykAXcJoiXR6K6apB3EMjzYUYZBoHREKF/2etI1rQY9tc6OUvlVUOIWYtdzQIWccEq8sksA6btLxkuQkb2KVlsTplVD6VCY88Is20YxzP7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieroLWvT7yXr/zmmNkYS1r2f50lYWCB+1rt+1ZdGmqY=;
 b=fHqlllf4MwTwldjhZxdv99cQ2W5lThTJP3V0CyzlHVjyinYYgASzTSW2WcBtb6G31jnAIAaBb2Cl2yPV8VSSa/9fwwdCo+lBVDOQF5IpJOwfX5QHUesGqc1pW0UT17VZEOLPhP1fWG2S2NpEXR2ChIHPkZ6MwFGueRlN6E+Jiw0=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH0PR18MB4719.namprd18.prod.outlook.com (2603:10b6:510:cd::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8; Tue, 10 Feb 2026 18:26:46 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 18:26:45 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: replay: [EXTERNAL] [PATCH v2] examples/ipsec-secgw: add support
 for SM4-CBC cipher and SM3-HMAC auth
Thread-Topic: replay: [EXTERNAL] [PATCH v2] examples/ipsec-secgw: add support
 for SM4-CBC cipher and SM3-HMAC auth
Thread-Index: AdxZu+lWJrxO6e80T/GODq5olWLPABA/mI6w
Date: Tue, 10 Feb 2026 18:26:45 +0000
Message-ID: <CO6PR18MB4484FA0ABF28143E4CCA8CD0D862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <KL1PR0601MB5567E83EF75B49C68A58766E90D4A@KL1PR0601MB5567.apcprd06.prod.outlook.com>
In-Reply-To: <KL1PR0601MB5567E83EF75B49C68A58766E90D4A@KL1PR0601MB5567.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH0PR18MB4719:EE_
x-ms-office365-filtering-correlation-id: 057b2d90-1af1-4796-67e2-08de68d1f27e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?clVHVjZGZEZRMHZRMmpVOVBrcHBucWpPd1BGU0xnSWJCUHM1T3lkbDAzLzBM?=
 =?utf-8?B?dFZHSFY0K2dveWZYSWZsMHRVTTlTOEhsWnM3dmxhTENVb1hIa01kbUtwM2Jm?=
 =?utf-8?B?S2tBOVpVNTZMc1YwZCtWUHA2VWc3VFc2alBrWXU3Q1hGRW5KdExyT2xrazkv?=
 =?utf-8?B?R0g2a25oOCthNDlGWFNwdGl2a2RlN0NKSDJvdU5LbTlRWkJTRFhiQy9CQWZJ?=
 =?utf-8?B?dUhrbFpWNXJwbDVtaXpURkZtT3A4Zncxdi9mWnJDUjViSFVVeHNIMEdPb3Y5?=
 =?utf-8?B?M0h1eGdlbVpET3JkRlgyNUliWWxQWmhSZkxPVUs4Q1N4cm1OdTlzczJ3dmQ5?=
 =?utf-8?B?eStCMXdFbVZkWE5DaUdPYlFSaXMyZ3dzR1NoSFhZM056bkpNZEd2WGxxTlVu?=
 =?utf-8?B?Yi93OTZSNWRBRDJJZ21nUTRiQlpUdUc4NXJ5QWR2WmpNZnlEUlBGY01EbElt?=
 =?utf-8?B?U3h4TWwzL29GMUF3anpLQ1c2V3pIUVFneHdOdnZHclMrQnRSYnhkSVIwUXAx?=
 =?utf-8?B?ZDVsQXMrS1hXelJLemVRYS81S1hnNXdIcFNrZ29lMi95d2FPMkFCOTZ5a0Vx?=
 =?utf-8?B?cm1RZ3lNZFI4RmxWUDVlbmxPVUpTcnlmVUFMeERnRjlxdi9TRzcrSTRlak1N?=
 =?utf-8?B?OVNBUjdhVnZQODVFNjdqNmYvVnlpYUZCN2lLSkVCUW5VeFVQcWxJT0hiVGJy?=
 =?utf-8?B?d3VKS3BqV0dHUnZlcTZkdHZWR0k4eGNZVTNTZFJiU2NRWGgxbVZxSDllemV5?=
 =?utf-8?B?V0xObUxhVHI3WjhNSEpmU2FPZGFhM3pKK3pvSlIwTEtWTVN0eDhLWjVneWJY?=
 =?utf-8?B?ZHptRlZPL2Vlc1VRVVVHS2RuV1VRSWlOakRxSHpmNGZreVZXSzRVT0FNRjFo?=
 =?utf-8?B?TURaOFFNdEdrN0VpSERYd3l3QjZ2N1Z3YS8zSmNWMzYrNTUvVEtNSDlkOEM1?=
 =?utf-8?B?TlJyeE5tWDNrb25zS0lJeFl6eElkYmJncTBPMDVmclpiQUpIZ3o5NkxHN1Jo?=
 =?utf-8?B?bjJiL2szUVFpWW9lR3lHRnpjd1ZVcldTUjZJUUgwbzZoWDBFZ21KUVJWN3dN?=
 =?utf-8?B?em5vUnFoOTNJS05oeVVray8wVGdENjRrUHNFWElRWnduZFlNSHEyWjNqOVJq?=
 =?utf-8?B?U2FKKzJ2MDM1ZVlmM29ZU25kMWEwWkVqbHhpL3lUV2FaWDM0eHZZdG4zMGty?=
 =?utf-8?B?YUFWblZvT2oxWTBPUEpNYmVlNFNIV2Fwek9ENmFGS2FSQlFUS2pPNjh1ZWlF?=
 =?utf-8?B?K2hMeDJJcVVzazRIZVYzMG13RktlK1FvWEp0SDc3MmZLNnJLVHgzQ1lUa29K?=
 =?utf-8?B?ZWltcUhxQk10bVppMFZnQlZQYWE2eWpNbTZGVXl6dEorcWN2VnJsQWRYRnFn?=
 =?utf-8?B?SGhCWDlXZm9uczhyVGJNaFlRMHI1VlFwM1ZaUHdPb2xYeUtkdEhpUVltdlpU?=
 =?utf-8?B?RndIMUdNUG1QVjBsSjE0NUVSNGJnazlrUkhyZkVDV0NvTXZ0WDVFQ0JibXh1?=
 =?utf-8?B?UEN6bmk2RzJtR1RzQ3ZPOUN5YU16UmZ5cXoyKzZJSktBbkdyUDUxQ2V6aCsr?=
 =?utf-8?B?MU5udDJoTjJEeTlLVmR5dFN3cjF6S1VVaDk4SnZETFJBV29VaW9PUE42OERF?=
 =?utf-8?B?a2VRRjlpQjc4Szg2aGtKbHJ2Zi9Bb3dkZGJOMEdXYzI4amNkZ0o2KzlMWHVo?=
 =?utf-8?B?SWNtcnhscTN0TDJTVTN5c0F2R05yZmRFZlRnYWR1VTRxNHlVZk1mcWFmdEt2?=
 =?utf-8?B?cEZoZGc2MENXMmhCaUVWdlZCTVVXRTNLQy9IdmhZNnAySDVrL0twZkRsRFJt?=
 =?utf-8?B?S3FuRHBWYjBvcGt5cXJUcGRvRURsNzNKRG8ySjBQOXFZZm5NVDVidkhNS0dl?=
 =?utf-8?B?YmZMT00yMFJ0VnQ1ZmdLeTNveWdISEp6a20xZENyV0poektwMDEzQkhwN0Mx?=
 =?utf-8?B?aXR0c2xVYWRqYmgvQkIxdXRaUENIYi9IVzlXQXVVS2NVb01pZm8xNC9ZU1Zy?=
 =?utf-8?B?Q3ZJZ0hxeDd3VGZwQW90QS9XR24vdTYwQWNyMXVDUUNzRmNDZXJ4TStkRHRK?=
 =?utf-8?B?S1d6RGlEMXBJaVBqdmJ0TWU5VDFBRERodjZuRzdhZFMyY09YcVN0MzNFcC83?=
 =?utf-8?B?L0JKTkRUNVk2NnNKTDVIdzNtQXg4VGMySCt6bmhUZFcvenA2M3FLNnRCSkJa?=
 =?utf-8?Q?ps7K0vZ8W+7vQFVIXkg15HM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c251Y1IxTW1vYUpteUIzL1o1UjFGUUQ2bWphRFR0Zy9nc0xkQzd0cHNxMGRL?=
 =?utf-8?B?TFhMY2d1UUxJSmUrZkpocGVESHRQVmZHMXdhOWdibm5uaGhmZVkrZzMwSFc1?=
 =?utf-8?B?TG5pL2M5K0kzSzRMblNOUnAzeHFlUU5XSXZqV3pVYUFqNjg4Qm03N08xT202?=
 =?utf-8?B?TGd5QWlkWVBiREc0OU03QW5PekI4WkdEelc3R3NCTko2U1dGU05tNGRBc1Ew?=
 =?utf-8?B?cEF6TVVuUUk1cUg1cndIc3ZBYkw3TjQ2VXRrZTNwUU1PNUh6aHhuSklKQ1dO?=
 =?utf-8?B?eWxya3VEQXlBbzhzRVJYVkpQbk85ektYVURYK3JabUwxZWp2M3VkdlpLRktv?=
 =?utf-8?B?SUtHT3hOcU8yRnI5NUdPWEk2bVB6d2Y4L1RzanBSZnZqTGdXRGJHeDAxMVBu?=
 =?utf-8?B?TWJFSy9GUnRrUWN1WlRabjV3bWRtZUJ5YXUyMVFPSVNzNVYwQU93U2tZeHcw?=
 =?utf-8?B?Q2ZNekZLSFdqUEgya0ltb2dRdlJBQWRoSjE0bks0Z1BzVVo4czUzYTNnNjJl?=
 =?utf-8?B?ZVBiSlV5U2x4MzNUSEYydXhmWVh6RXhyNzNzcXEvaTNSS09JSXk4Q21BSHpF?=
 =?utf-8?B?SUxSWnRFUkkvWDczRTdJVWw0ejl0OUg4SW1jWndIenhlVFdya3kxWllRL1hR?=
 =?utf-8?B?QllncklEaHRGaVFEUVo1S1FCN0xUOS96VGNKNjVEd004OVZQU3NjN296cyty?=
 =?utf-8?B?Z1NMNm5FeG5sTklrTG5TRUVrUHkwM3JLWTd0Q0VFR0JjaWZHT0VMeHhNY3NJ?=
 =?utf-8?B?blBEOXkvbnZxK3A0MlJzbWhVWjNRbjEzVzM4OFpmeW1hZUZRNGNjZzNVcGtV?=
 =?utf-8?B?MGtTMHpQQy8wby9KbDF5elJRaXhJRG9rMkNheDREQUpqbE5kUGdxQ0tRbEw4?=
 =?utf-8?B?TnhhQ0RRMXcyY0srYmNjeXBqa0lZd1A4ZmtoMVladGNZTzdJS0VUSW1zNkpS?=
 =?utf-8?B?SjQvTkJhZHlJV3RqWmVTQ0ovY1hvOGxJVmRURmlLUy93cHRDeCt6R3htTm40?=
 =?utf-8?B?YlBES3AzbkY5OVQyZEFlYjlKZW5WYUppYjNaOU5xQ0tLczdraitEZGJQYTh3?=
 =?utf-8?B?bnhyWHRmVkxrZ2Z5amNZSjlTSHRPK09DOGtJK0wwTGpZckZtRzIydlI2OVVN?=
 =?utf-8?B?Z1lqUTBncmhab2RudTRNOThySmJHSmdtNHY0SVluVkdhVnhLVzdtQ2IvYlRu?=
 =?utf-8?B?MU1ZR05hZGs2MENWVThQdTBoSVd5Y0szVWNHVzJIZDVlanUrdFNnR1gxckJO?=
 =?utf-8?B?eHZWOHZPMWYyUHNvb1pkYTk0WHJYTm5zOHE2WVlNMTlFdGdoZ0hjdlB5cVRh?=
 =?utf-8?B?OVZJT1Z4WXpnUk1iVFc2RC85aDBnZ0JjTldyWUhvR1oyQ1pxV1hMWk9ST1JS?=
 =?utf-8?B?RkZualRyOElybnBnMzBoSkdRcmNzRzYycHd2RkM0YVNLRlR0cFYzclpKTjQz?=
 =?utf-8?B?Z3E4aVQ0LzZicGZud0MwL3ByMkVvTmlnNyt2RGhkNjdyRlR0bEt3SjBXWGRx?=
 =?utf-8?B?ODhWaEU2TCtRNzhSUUtZOWNCNEN4c1EyRXZTUFNwMTdjRVhveXpIblM0ckVu?=
 =?utf-8?B?dElMeDEzNUdzMzArVGU3dlJaUE5lcjdQUU01VTVCY01maUVzalcyYVNHRXFE?=
 =?utf-8?B?T3BuUTRtQlZySjBOY3RIcFdXQllhcnlaQm9uUHhEaEhqZHlQbnpCTzhZVGRr?=
 =?utf-8?B?aGlIR3lsOE9kQ1ZCWlFJdk5DbE5QSE5zbjdaNDRUU0NkM0tNV1Z0Z3pua0t4?=
 =?utf-8?B?MWd3Y0lvVzIwd0xaQUVGb21pS0NGZmJ4dmdQMmxJd3Vvbnkxd1RZa1h4Q1A4?=
 =?utf-8?B?UGgybllYd21KN0RIOWg2OExOSWd3a0lycGxRc0RGM0x2aHNNc0VoOFJRZ3VG?=
 =?utf-8?B?bEVUclpsYTUzQStRR052a2prUmdZWTZ3YndndmppN3A1U1RyN1Vvd2RqZVpY?=
 =?utf-8?B?SjVLbFpLZjc1Q0FTclpGU2l0V21rblFIQ3VJU2h3WVNqMi9aU1BXcG9VTVFs?=
 =?utf-8?B?TnNVMTYvMlU3a0xBZkZacVZRNTFOWGhRZS9SUjdVcGNvTUhjd2JoUHdtcUxJ?=
 =?utf-8?B?U2ZNMVhrNEQ4MWNEMzZ3NnowYjEvbU5UeWRaTnBuNml6RWtkS3Y4ckhUYU12?=
 =?utf-8?B?TzZsYU5wcnZWcklZQjBpNU1CNTJDbGl2cXBNYjZiYXBEcDRLMHo2dlhFaUVQ?=
 =?utf-8?B?ZTBaZG11MEZTQWRrc3lzWUlkbCs4RUxNaFVEdWt0dW9jbThRdGVQWW81aXMw?=
 =?utf-8?B?bHJFZE5Xd1VqYUZBSWFOTnhncGNkUTAvYi9nUE1qb3N2bDBtd3pTOUdmaFdG?=
 =?utf-8?Q?W8hDgDMfHqZuHmkdpi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057b2d90-1af1-4796-67e2-08de68d1f27e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 18:26:45.8942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3H+BhixUKNlzQrmgUD96l0Tt1Ji0tfBRLSrUEy+++tjEdn+e83jUkypPVHA1YrdIWwBsE0DkDIPoC1af4BOStA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4719
X-Authority-Analysis: v=2.4 cv=ELgLElZC c=1 sm=1 tr=0 ts=698b7868 cx=c_pps
 a=CxbFE7Xfbix2UyL9/Td2hg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8
 a=tv6MWxRdgYbq7qgGYhcA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE1MyBTYWx0ZWRfX0h5I2nAZDjsc
 +8Qc4RgndEu42YLwCr77rvNOqoz4s/vqdWYV0ZvuJLKfnBu90t4iUhI+mNzLnqhmQhgYyr967tY
 6zCz3ISiOnUPK6d9GcWh35sa2pc4QOQcBj/CSeEs4nTcujIQdRMdKhLIAVb0LoqvAiCysrnk2fH
 A9X0Y9uRslkIIBaoSt198FVthuO2hic69OqTT5GvxbCTq2ruJGqI5utaJU4a6Iog+3Krce7lMdv
 k2uB+EcqlNQW5kVMdig8JDhYi9FFALVt/evEV7d0hTbA7xRlb54cDB5G6S+hYhytHOU0zLTsJSv
 rc1qjyliI13qzRrz7eiCommQh/0/iBvTBhXvrV0l+h7B5mBPK+qFRsRQVE0P5xlkUB0vnoXgYIu
 QmiRBeo49Wre1PgW12mdIp+L8GBSVtfBqpAWWaKmibVMv0HJPezkgrryqnpgbCB32kDhvM0WtgJ
 BD8aByz0vPEVVN8rGkA==
X-Proofpoint-GUID: MI0DROxLOBQ3L8fLGy5R4FT9Wt7VFHXC
X-Proofpoint-ORIG-GUID: MI0DROxLOBQ3L8fLGy5R4FT9Wt7VFHXC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_02,2026-02-10_02,2025-10-01_01
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

PiBIaSBBa2hpbCwNCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBxdWVzdGlvbiBhYm91dCBQTUQg
c3VwcG9ydCBmb3IgdGhlIFNNNC1DQkMgYW5kIFNNMy1ITUFDDQo+IGNvbWJpbmF0aW9uLg0KPiBU
aGUgU000LUNCQyArIFNNMy1ITUFDIGFsZ29yaXRobSBjb21iaW5hdGlvbiBpcyBzdXBwb3J0ZWQg
YnkgdGhlIGZvbGxvd2luZw0KPiBQTURzIGluIERQREs6DQo+IDEuIFFBVCBQTUQgKEludGVsIFF1
aWNrQXNzaXN0IFRlY2hub2xvZ3kpDQo+ICAgIEhhcmR3YXJlIGFjY2VsZXJhdGVkIGNyeXB0byBv
cGVyYXRpb25zDQo+ICAgIEZ1bGwgc3VwcG9ydCBmb3IgYm90aCBTTTQtQ0JDIGFuZCBTTTMtSE1B
Qw0KPiAgICBSZWNvbW1lbmRlZCBmb3IgcHJvZHVjdGlvbiBlbnZpcm9ubWVudHMgd2l0aCBRQVQg
aGFyZHdhcmUNCj4gMi4gQUVTTkktTUIgUE1EIChJbnRlbCBNdWx0aS1CdWZmZXIgQ3J5cHRvKQ0K
PiAgICBDUFUtYmFzZWQgaW1wbGVtZW50YXRpb24gdXNpbmcgSW50ZWwgQUVTLU5JIGluc3RydWN0
aW9ucw0KPiAgICBTdXBwb3J0cyBib3RoIFNNNC1DQkMgYW5kIFNNMy1ITUFDIGFsZ29yaXRobXMN
Cj4gICAgU3VpdGFibGUgZm9yIEludGVsIENQVXMgd2l0aG91dCBkZWRpY2F0ZWQgY3J5cHRvIGhh
cmR3YXJlDQo+IDMuIENOMTBLL0NOMjBLIFBNRCAoTWFydmVsbCBPY3Rlb24pDQo+ICAgIEhhcmR3
YXJlIGFjY2VsZXJhdGVkIHN1cHBvcnQgZm9yIENoaW5lc2UgY3J5cHRvIGFsZ29yaXRobXMNCj4g
ICAgRnVsbCBTTTQtQ0JDIGFuZCBTTTMtSE1BQyBzdXBwb3J0DQo+IFRoZSBwYXRjaCBpbXBsZW1l
bnRhdGlvbiBpbiBleGFtcGxlcy9pcHNlYy1zZWNndyBhZGRzIHRoZSBhbGdvcml0aG0NCj4gZGVm
aW5pdGlvbnMgYW5kIHBhcnNpbmcgc3VwcG9ydCwgbWFraW5nIGl0IGNvbXBhdGlibGUgd2l0aCBh
bnkgUE1EIHRoYXQgc3VwcG9ydHMNCj4gdGhlc2UgYWxnb3JpdGhtcy4gVXNlcnMgY2FuIGNob29z
ZSB0byB1c2UgdGhlIGFwcHJvcHJpYXRlIFBNRCBiYXNlZCBvbiB0aGVpcg0KPiBoYXJkd2FyZSBh
dmFpbGFiaWxpdHk6DQo+ICAgICBGb3IgUUFUOiAtLXZkZXYgY3J5cHRvX3FhdA0KPiAgICAgRm9y
IEFFU05JLU1COiAtLXZkZXYgY3J5cHRvX2Flc25pX21iIChkZWZhdWx0IG9uIEludGVsIENQVXMp
DQo+ICAgICBGb3IgQ04xMEs6IFBsYXRmb3JtLXNwZWNpZmljIGRyaXZlcg0KPiBFeGFtcGxlIGNv
bmZpZ3VyYXRpb24gd2l0aCBRQVQgUE1EOg0KPiAuL2J1aWxkL2V4YW1wbGVzL2lwc2VjLXNlY2d3
IC1sIDAtMyAtbiA0IC0tdmRldiBjcnlwdG9fcWF0IC0tIC1wIDB4MyAtdSAweDEgLS0NCj4gY29u
ZmlnPSIoMCwwLHFhdF9kZXZpY2UwKSIgLWYgZXAwLmNmZw0KPiANCj4gU0EgY29uZmlndXJhdGlv
biBleGFtcGxlOg0KPiBzYSBvdXQgMzAgY2lwaGVyX2FsZ28gc200LWNiYyBjaXBoZXJfa2V5DQo+
IDAxOjIzOjQ1OjY3Ojg5OmFiOmNkOmVmOmZlOmRjOmJhOjk4Ojc2OjU0OjMyOjEwIGF1dGhfYWxn
byBzbTMtaG1hYyBhdXRoX2tleQ0KPiAwMToyMzo0NTo2Nzo4OTphYjpjZDplZjpmZTpkYzpiYTo5
ODo3Njo1NDozMjoxMDoxMToyMjozMzo0NCBtb2RlIGlwdjQtdHVubmVsDQo+IHNyYyAxNzIuMTYu
MS41IGRzdCAxNzIuMTYuMi41DQo+IA0KPiBUaGUgaW1wbGVtZW50YXRpb24gZm9sbG93cyB0aGUg
c2FtZSBwYXR0ZXJuIGFzIGV4aXN0aW5nIGFsZ29yaXRobXMgYW5kDQo+IGludGVncmF0ZXMgc2Vh
bWxlc3NseSB3aXRoIHRoZSBjdXJyZW50IElQc2VjIGZyYW1ld29yay4NCj4gDQpBY2tlZC1ieTog
QWtoaWwgR295YWwgPGdha2hpbEBtYXJ2ZWxsLmNvbT4gDQoNCkFwcGxpZWQgdG8gZHBkay1uZXh0
LWNyeXB0bw0K
