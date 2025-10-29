Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75FBCCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 05:02:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7C45402A6;
	Wed, 29 Oct 2025 06:02:41 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3363040288;
 Wed, 29 Oct 2025 06:02:40 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59T3tMPS2777904; Tue, 28 Oct 2025 22:02:38 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023090.outbound.protection.outlook.com
 [40.93.201.90])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a3audg49e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 22:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNsj5Pg3ktURCplB5Zp8Xqz98MGxJf/FQwGKu6jvOG2cOZdur3CVhHiRLX9VR6ZvWgRXawdvW4T/0v5JrrQ2KtrqEzSO/LWMJtbXbuaWfFrlqWKHZgyRZ+c08eomeg5ByeyBSruR0DiJ5saPr1yPUKSGBXi93hGlQK8j0pmk0AA0A5zpmoNn8WH62Um2AlnpzlECrJZmSd8mBpk/ASwGIPk5Kv2H0E5KuVvg6WK40L5yq2jTC3XjWM0OeTGLXNfTTAvWctQUhX4g+vhlNhOuZ0A+P5ynZIgbLsxbJlK0wKitmWGavYktoakgIsgHUBY4tafrmfXU0cLEK0fQjR0Qfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AZ4kKGr0qk3d/R6GPs6BZwghN0SAQt8MX6yfef3pvk=;
 b=fiskgg2SHw3iWcELf7ER6E3pPYAA0h04ZZwUn1ECbtCq1K5ozkc5eEfN/AR2xMFV8QRrR1bU0ROfMjtPCyroqrzkkTh09xitltfNyRm7/XEIlQh9jMDzxwwk46cJrWJEfeFudb5T5Ukj5QvXvXACPBJUKRMec/tBNPWtY5/X+v4nVzPl+Kb+CNvbzFJMoKFg+bf79vWyjbb6XnMa/ExIjs6SPnlo6xri8MPbw7d9cmXwho9gLmUU2s7bMUIgxgUy3URpTop4oplVFSKeV6GoHNNB0EV1+Us57Qes0/cUHylNq/khm2t3UhtssyMZ9kLWPbfckSS1Ur2nE1j4olsefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AZ4kKGr0qk3d/R6GPs6BZwghN0SAQt8MX6yfef3pvk=;
 b=HT63d8v7/EFx3P9iy5jMYTFNu91kgNQmiXUDODRAbUFFCd+giFaFfvJms3Njsr6EvVN+BQ5f0TqkxcgeWKL7eO6fzBPkiwCXHE/0Z5SWxMKtIn0E3VZcUoTSfRgdZYkHV9vM2Hc3zVHhLll9XqwTe2/E3t0s/qaoDmsReA9OEt4=
Received: from SJ4PPF0C545507B.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f09) by BL1PPFD4E9E814A.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::dc6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 05:02:32 +0000
Received: from SJ4PPF0C545507B.namprd18.prod.outlook.com
 ([fe80::43d3:4b32:5537:8c25]) by SJ4PPF0C545507B.namprd18.prod.outlook.com
 ([fe80::43d3:4b32:5537:8c25%4]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 05:02:32 +0000
From: Amit Prakash Shukla <amitprakashs@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Jerin Jacob <jerinj@marvell.com>, Sunil
 Kumar Kori <skori@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>,
 =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, Ferruh Yigit
 <ferruh.yigit@amd.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [dpdk-dev] [PATCH v1 3/3] app/test: fix issues with clang 21.1.4
Thread-Topic: [dpdk-dev] [PATCH v1 3/3] app/test: fix issues with clang 21.1.4
Thread-Index: AQHcSC+fk/XG3asEh0m746mwi4BHuLTYkdEw
Date: Wed, 29 Oct 2025 05:02:31 +0000
Message-ID: <SJ4PPF0C545507BE7817CC0ABC0BEDDFEA0C8FAA@SJ4PPF0C545507B.namprd18.prod.outlook.com>
References: <20251028172324.3149379-1-jerinj@marvell.com>
 <20251028172324.3149379-3-jerinj@marvell.com>
In-Reply-To: <20251028172324.3149379-3-jerinj@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPF0C545507B:EE_|BL1PPFD4E9E814A:EE_
x-ms-office365-filtering-correlation-id: bca35ba9-623c-40a3-2dfa-08de16a85dff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?naaReUeEztcamwO6EOd8XGBLQ2MxpJiEl26697h+cRLI1dYM1BgbQzdDmc?=
 =?iso-8859-1?Q?MiZhV467tdpAi04wxSCUdoGjyu6VLtSY386DJi9fsyBOabtKewIamkYmhl?=
 =?iso-8859-1?Q?SREMDc1I/pDz6hg35YI17gPEBDQjM/HBUKorD6GAcPI+1/2cunDv9RUkDv?=
 =?iso-8859-1?Q?Cy7tTZyDGjy7GwjmcQFQqC0LvWdZ11YFwl11K5x//0rrNZwaNetb5L44OF?=
 =?iso-8859-1?Q?69Tgs7AxijV9R8e46tTDaO1zYXh+U1KZ6HzR4+KYyrLdz2aHR/mi26r4gy?=
 =?iso-8859-1?Q?QX16ANAbBshw88xbSw16dPvvTaDvIlOn9zt7rItNPvw34lT0Awre+rpPAg?=
 =?iso-8859-1?Q?l5R7fz6LAY51bgaOPr5P+NAXfnVTY6K06Wx2IcpVsz3378lUfzaPm6Nj01?=
 =?iso-8859-1?Q?32KUrKFW9rSzHLju5i2lwONDgxd0s9go2e6MzeJM+NUdMinsmuFT7wTL5y?=
 =?iso-8859-1?Q?cGaV5yDki814e3CRqYH2MmqGbqekntSQliIHlIq5xeTzhS9n4FOZ6ng+G0?=
 =?iso-8859-1?Q?4jlAGl/8gl7obQyX53S7mA6En8idxsd2+zAPrWIRxjm5rq/0t21kw3Acjy?=
 =?iso-8859-1?Q?dsn+POgBfP8eWufG7UaG1NeFJMYGqpAdhy/i4BLIEVUTWarmpyP3QMAkVv?=
 =?iso-8859-1?Q?hpIsGPa0qK0FeoR6qTyOMXyfdCGso4xLBYSX07W+R42aEIE35igScFkimy?=
 =?iso-8859-1?Q?VTrE11kNoWKE8UYtw3OnceWtTddtuJYs/+25LOqWspqA+oSKLoVayE69cW?=
 =?iso-8859-1?Q?LYMyNkeE3nrKoCORpGGKXMIHQzyHz0sZFVvhw26KCVnhT7WwrXMgvrYK8H?=
 =?iso-8859-1?Q?4Isz1BiUXRtVoJZMEF7GvkNJSs3XMdY9Fc/QmH5k2ItcAftoVo71Nl+UQI?=
 =?iso-8859-1?Q?elLNB9gOaGTuIOlDACC3QQMdKK8BHzDVfOUg27QbyMWtIguR/b9Nd8wLr+?=
 =?iso-8859-1?Q?Vabe0jgqWwSKrd8dwG6ErO/0hFiT2oA6aVBJTq86EiuVd+6rMZdLtwckZx?=
 =?iso-8859-1?Q?0iKAo4gshZaB/jPFBA6+y2lN0d1T6KoGJhPKJtV1yVpZgbF+MfcVtACQ55?=
 =?iso-8859-1?Q?wY8Sh6QiPZ1SVP19XPwBm4JxTswnFoaClC9GvURw91i5OgB+bMnqOAwCdX?=
 =?iso-8859-1?Q?SHfsvzU1gq80NeZuQzNgCZDjtQqXHyshxKDGlQjrrbD2KvtG+deGFRZADR?=
 =?iso-8859-1?Q?JD2XDgZj5BxeVBIY90x3FPrtOCqwm72ehABRvPujUAtNFLJ+RjepCX/YZN?=
 =?iso-8859-1?Q?ri0MrNbTIJa7QnCQBrmFAOHJq6RsABsL982bFkgX4vcPUagMLL2fNOKd55?=
 =?iso-8859-1?Q?GCFOg+ws25C26Gz//aO755V4uE6ZSFH4JZSEBxqqUc3U23qCQ2HqvDKJmY?=
 =?iso-8859-1?Q?eRdbDICLG64h98E/KrXK2leksFqQXTU5noKAxPqQUCygmdcPs7RKfndwJV?=
 =?iso-8859-1?Q?+75ZCx6rJs4j9efVV+KetW4TNzGGtNkTLhcmJWWiQ8+Kyp5FjF0vWiWX50?=
 =?iso-8859-1?Q?7oJIZAshEYGZydzkNy+7R6quzDGGpHb0x63z7Uj/qy41304OeNV5hh6Zyy?=
 =?iso-8859-1?Q?rl6tvwM42e4GNhRZDq2ddXblEHXq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPF0C545507B.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5pQEkk0HQiAgUUx9/IIEY2L33ikpFtUtU0GgRXWpgTlhR1Yhi+RF4VGlAu?=
 =?iso-8859-1?Q?iZdntofFqNo9wCJ/Os+5tTGpb0I+FGwzdLkdHAnFgfNj1/i1nzdn9CEJSI?=
 =?iso-8859-1?Q?CEnB+LZSum+DPCfGWEhSJXhIpaQw0WWEH2PHiPd/yYTLdVg9p3Tdk2Rpwu?=
 =?iso-8859-1?Q?XSgSJ5ZPil4VaTFSOIT4QqqqwRFxYzGM3n1rxW0akbH10rkuRse4dUGZ75?=
 =?iso-8859-1?Q?jXYvOqMmrLwjtPXd7OaLY9GPvqBweDk19U1KiAflq8BvV5zb93M9oxJa56?=
 =?iso-8859-1?Q?6wUI3yezZo+hVYvRorvaP2bUFWT/btYRhYOp7/SAaUTMo61BgkBly8bX5N?=
 =?iso-8859-1?Q?LOHp+w8JEoHLHfny84vikdVeGDyTzvgQG1VkHkYBypI9cnCLEEECZ00tLZ?=
 =?iso-8859-1?Q?7JP8HLSSDQ4Pkh1/340l4cH4wlH+urYthJLlsUjs5uEXMpVV0+LzKqwBCt?=
 =?iso-8859-1?Q?1VJRLxE+b1zn55VMjMH4XfCWqY8mSf6psouIOKtGEjuxbkZpDuRWJQWYMR?=
 =?iso-8859-1?Q?ZPymp2/elKVNABaT5DLUankZ7+n2FvjFdVV1ZZHl+huefJ4hSP9r9CFtmT?=
 =?iso-8859-1?Q?EL5ll2RkUjFMUbOVknLMnSxMxoUBxuHWxkaI1Q5a7UrRgCPaThLzwr6l17?=
 =?iso-8859-1?Q?MagC7aLKbBW74LIz+/DWSyPa9LxMlSFAYTz9+NwPKRbn8c7kXtA6mYqiIs?=
 =?iso-8859-1?Q?0nDBbPPOszf7tzAhrsqWnx4b1xo8sVm3hMW2Fl33wrd0kqZkkHDuWm9jxn?=
 =?iso-8859-1?Q?HWu83FWDbAAN0/hryfTMXjQwuQpWGoHW+nl+TNNKtalBYsA9qRywlyRlPc?=
 =?iso-8859-1?Q?xb4wTgoUiZfc1AF+AqD1LFwX7ipgDIps/f6FMs/6Zutl40EtL1oDbqQwtL?=
 =?iso-8859-1?Q?Xw64vGyjDp7XdRXPHG/UJTQLdOhtfPz37l7u39tOkHEV3Gdq/9O7D4hlz1?=
 =?iso-8859-1?Q?HOE1D07tRJW8yuFpwOjSjCGZ2M4rqyJiQEXUztjV6fhJA1c90QT1zxFBmP?=
 =?iso-8859-1?Q?EnV71PluJRYS0GxIXOmjEXS/wW1dLkmF1dkOR1eM5hw4xg/64iBc9AHcUu?=
 =?iso-8859-1?Q?tlXAWNXek1Ko+saiXmtve+bnZA2h0tJP3tKzF4miT8Rh5Ud7Qx37+GO739?=
 =?iso-8859-1?Q?6Vv7yJFViaE5z4wxvnENYEF6sQq0o7UkaL7Cwhu6I+bjeL8SeYVWysRTiL?=
 =?iso-8859-1?Q?XNdz7vG2Nz0GOr8Q87qnCqZzNyVCY1eXfXflQTP1l/nvB/nIxOF+238W1b?=
 =?iso-8859-1?Q?W125v1JRIKmy/CU8C2TbOwrfPlZxqafphlXyM1Mc6vcohX6NAozh3LJjkW?=
 =?iso-8859-1?Q?JM/Ul+fIMqNaCNIhfBH8I96tWHDI5O4svIL+2w+DSMMVbQxv7GFy/mutxd?=
 =?iso-8859-1?Q?Ykd23Js9t6rGk44TvlaMwssbjA7MZd2Taq/z1rNEe/+3RmYRIVvI1U1paN?=
 =?iso-8859-1?Q?Hqi+9WPTQ8V2IYHBls/a4dSenuV+FmhAGNSDwinF4g6c784QDCcTIDN7JA?=
 =?iso-8859-1?Q?KtWMR0Hcw2yI6o3BuLduvdQtptGYhMANYHR0q4D5Qx0fQw0Dz/GVfvD0jh?=
 =?iso-8859-1?Q?RmHuq2OiLj8j5OxgvlgNWU3HvotArVCjBU7I8PODLqejVp6V+Lcl/MHUV3?=
 =?iso-8859-1?Q?QcczzASdowS64dwQLTNfXDozKzTOwvwAbI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPF0C545507B.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca35ba9-623c-40a3-2dfa-08de16a85dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 05:02:32.0157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ORbt7qgV2i0A42mXyDYbIrt7OuVSQJ/b6XUmwLNiWu0ere2VxDkJBCevcULxW1QxkTDdnDvfeE35RzGrEosoqEUhOhDdR5O1vd/T+AdaVAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPFD4E9E814A
X-Authority-Analysis: v=2.4 cv=fuLRpV4f c=1 sm=1 tr=0 ts=69019fed cx=c_pps
 a=krMX4SE5d8na1K7/klQVLg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=n02bokGJAAAA:8 a=zd2uoN0lAAAA:8 a=8rWy6zfcAAAA:8
 a=bt5KbKNvAAAA:8 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=th3br9itqZiNshXGOZcA:9
 a=wPNLvfGTeEIA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=rszdq1ld3peujIA30KyE:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: lqeu9-cuPDbNw7fdRbXBY_mTKFiZYxTd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAzNiBTYWx0ZWRfX8NwOPUHqqWyR
 ECwAFYnzX/bnun5FICgGuVrPNBHXi094pwo6eGF0K/RjECLu5DUWzZx05eh58C4c0rYXzhBgQts
 OTvtOFTVJIradmIQELEpWp3sVJUJ1CVfvWA+zrZMChWfLpjP2liIjJ0B2mHv2sF0AWG3QZltKqQ
 0whfDyi4fuim4nHt8CBfNyHAVB3vN5KDLmesGIANqj7oaUiPKpAlJPqjSsqwcZGn443s8hXamOk
 5sDxWIVNaICIom8Bs7VzTBRKve/q+F4kWXZUvG7E17IbI3YlJTJZvQ09Qc2OucZcE17dNpoqkNV
 8dgxmwip5YD1jLifft6sM9bTUWF2Zm4CVfxlH+9L6qV7p9ZmvNAC6HyI+cDca/JqIEQVjtIXI1g
 xX02bLlTO8Tk2dvv1tpCs7d6x2r1LQ==
X-Proofpoint-ORIG-GUID: lqeu9-cuPDbNw7fdRbXBY_mTKFiZYxTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_02,2025-10-22_01,2025-03-28_01
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

Acked-by: Amit Prakash Shukla <amitprakashs@marvell.com>

Thanks

> -----Original Message-----
> From: jerinj@marvell.com <jerinj@marvell.com>
> Sent: Tuesday, October 28, 2025 10:53 PM
> To: Amit Prakash Shukla <amitprakashs@marvell.com>; Jerin Jacob
> <jerinj@marvell.com>; Sunil Kumar Kori <skori@marvell.com>; Ankur Dwivedi
> <adwivedi@marvell.com>; Morten Br=F8rup <mb@smartsharesystems.com>;
> Ferruh Yigit <ferruh.yigit@amd.com>
> Cc: dev@dpdk.org; thomas@monjalon.net; bruce.richardson@intel.com;
> david.marchand@redhat.com; stable@dpdk.org
> Subject: [dpdk-dev] [PATCH v1 3/3] app/test: fix issues with clang 21.1.4
>=20
> From: Jerin Jacob <jerinj@marvell.com>
>=20
> Fix the following errors seen with clang 21.1.4
>=20
> app/test/test_event_dma_adapter.c:532:32: error: variable 'event' is
> uninitialized when passed as a const pointer argument here [-Werror,-
> Wuninitialized-const-pointer]
>=20
> app/test/test_trace.c:201:29: error: variable 'tmp' is uninitialized when=
 passed
> as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
>=20
> Fixes: 4925e15a1614 ("trace: add trace point emit for blob")
> Fixes: a276e7c8fbb3 ("test/event: add DMA adapter auto-test")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Jerin Jacob <jerinj@marvell.com>
> ---
>  app/test/test_event_dma_adapter.c | 2 ++
>  app/test/test_trace.c             | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/app/test/test_event_dma_adapter.c
> b/app/test/test_event_dma_adapter.c
> index 7f72a4e81d..4df5991285 100644
> --- a/app/test/test_event_dma_adapter.c
> +++ b/app/test/test_event_dma_adapter.c
> @@ -144,6 +144,7 @@ test_dma_adapter_params(void)
>  	TEST_ASSERT_SUCCESS(err, "Failed to get adapter capabilities\n");
>=20
>  	if (cap &
> RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND) {
> +		event.queue_id =3D 0;
>  		err =3D rte_event_dma_adapter_vchan_add(TEST_ADAPTER_ID,
> TEST_DMA_DEV_ID,
>=20
> TEST_DMA_VCHAN_ID, &event);
>  	} else
> @@ -528,6 +529,7 @@ test_dma_adapter_vchan_add_del(void)
>  	TEST_ASSERT_SUCCESS(ret, "Failed to get adapter capabilities\n");
>=20
>  	if (cap &
> RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND) {
> +		event.queue_id =3D 0;
>  		ret =3D rte_event_dma_adapter_vchan_add(TEST_ADAPTER_ID,
> TEST_DMA_DEV_ID,
>=20
> TEST_DMA_VCHAN_ID, &event);
>  	} else
> diff --git a/app/test/test_trace.c b/app/test/test_trace.c index
> 8ea1443044..52b5ba5cbb 100644
> --- a/app/test/test_trace.c
> +++ b/app/test/test_trace.c
> @@ -179,7 +179,7 @@ static int
>  test_generic_trace_points(void)
>  {
>  	uint8_t arr[RTE_TRACE_BLOB_LEN_MAX];
> -	int tmp;
> +	int tmp =3D 0;
>  	int i;
>=20
>  	for (i =3D 0; i < RTE_TRACE_BLOB_LEN_MAX; i++)
> --
> 2.51.2

