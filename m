Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CB5FCC9C4
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 05:54:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71DEB402B8;
	Tue, 10 Mar 2026 06:54:31 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4FBF64014F;
 Tue, 10 Mar 2026 06:54:30 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A3WJ491936569; Mon, 9 Mar 2026 22:54:29 -0700
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021137.outbound.protection.outlook.com [52.101.57.137])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cs5ncchh9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 22:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHP6RPp1WM6kzqnQlaWdpLXlb0IpDYKfOAPqq34lelZRRS49/STupw2c6x+SwAiV4uZB0KnpmR1HMTRr3W79qy/BLxcPt6QGbPy1Zc8iwila/W9do4N5SKbzRCS9BZRVYGnsEpZ+C2kxNoEk/vBjEk3jIuMchwHWnsgqvoRHrThKIdeEK+RkrLscLLez/J1igeyLrNy3KgEF5n3v+i6FZ0P/RzX++w64yW4ekLc5XgfoL46ZTppxwS5Ln7SnVHPSHZ+6CBDc5ozf7rELYuJ0ojtA8O5cxBNpGSw69of+3e5kj4VeYVcbQTisuCg8CTbFrRSFXkT7I70xvcjGwAcX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWzaNb+hPnxJrQsewm/ZWCzxyXQ5A1Skgrt5V52JYuk=;
 b=mTZ4RT5wXnBh/dM+hIX/T8uMf8fysZPFfsGGqPLbvZw/qReiWLu4uH+4nGnCka6n/XOcTEOdCi6tya1qUB7Cc+cIIJvLpAP35cFV05YPKLHEqxWlBzVLTTXvtXC8JFVo8EyNvhu8a71naK4FdWmc3d8+Oy5Hl66USAM2hSeHAkzOJ0zlXI2HL/4WOiCw6tqbMShZI+fx8hyCiw3PpW1roxAk3tqvm92Fna2pCiqyEqyssmSsgeELaFhxFDwt9kWb92ULzNaMfWCHrr2PWhy1bZv/1EfnweEItxQcmUPLxGSPWr/hbmjEhLKzpD6q7RKr1SuN9jnrN5P0LEV7Z7lfnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWzaNb+hPnxJrQsewm/ZWCzxyXQ5A1Skgrt5V52JYuk=;
 b=mZD3KsCZ5zPAAI3heZFR5xhMHioY9gUhCMlajIJqCPP+j5QqRWyO9flzb6EgfK8S/8Jvs1f/tWIKLaxBviPRoohfpM1ux4+zjtMAJy+ttMdjBSQtpWVrt3jA/RjicvjUX7a6uJxp/G3WoHWoGTTmfTATlsATQ4m5sIXHOPr6Ymg=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA1PR18MB4759.namprd18.prod.outlook.com (2603:10b6:806:1da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Tue, 10 Mar
 2026 05:54:26 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 05:54:26 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Piotr Krzewinski <krzewinskip@gmail.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, Piotr Krzewinski
 <piotr.krzewinski@ericsson.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, dpdk stable <stable@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH] cryptodev: fix memory corruption in
 secondary process
Thread-Topic: [EXTERNAL] Re: [PATCH] cryptodev: fix memory corruption in
 secondary process
Thread-Index: AQHcpy+mBpl/Y70p7EeEcDrYLiXnKLWWLkuAgBEnw9A=
Date: Tue, 10 Mar 2026 05:54:26 +0000
Message-ID: <CO6PR18MB44842B3B21465D52709DA866D846A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260226135727.4171394-1-piotr.krzewinski@ericsson.com>
 <431e978a-1763-43b0-a2c9-d285edbbfec8@intel.com>
 <da7ab2ee-2a37-4536-92f2-5981840b7b81@gmail.com>
In-Reply-To: <da7ab2ee-2a37-4536-92f2-5981840b7b81@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA1PR18MB4759:EE_
x-ms-office365-filtering-correlation-id: 2415774b-266f-440e-98f5-08de7e697cff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: JC8eZhoY7lLimh52suCEBEjXRy+OGktskRHvnG93toCGC9axvBy8H8QsND04ZbVjCMlWZ4MuE0L06peIUWNkihd8kc67RpRCyPXNWPUm6VUVbZqKoB8+ir1ThSvmKFYsPECGearSapHDP7e0WbaHc1eHGE5zxw+2sC26Uxkzk3yC8PykPZLb0CebF6vNCuaxqhuhhip0/WPgBOAYHYAusck6iQW+Wb1XKk8e3/8A4OsqtQwAWwkUgea+v8PNQa7I6OY/ng1hBqCz3bHIJKIwDceQvYmB128mdINAeP6IETirghHPxYHjEckKlIG+MLC/VQ+EBgyKNpl1kOE0neIo5zIvoQqJ8Cq7OLZhu2BHqD712UqGMMkstCItRy1Mtng0HID6AMvEIWbl2L9JCcNSz9/dqPsX/9fZqRi0o9airDwVEMs+Rw7Kds2FBieJqH1GYSEvJUpP8uLJ+K5D/hba+7fmwZpID5IQ6HcpwVJgHi5yCxoTrAr5GaTlvu0FrCacvRYpLfYgwZgFv2bU715zKmRXCbiXNomECFeroccImLJKmvZVKSSSC84XdP1dsj5c754rPrwixaaIV2mF+quHsi6+DO9IsTf/KuWWutLsTC7HaD98qPcJxN60nWkVtLfalgXeQexit7+n27GFEJkcFRcXn4wNGjRJfnbGe8f/0tjKF6U7iEwHuueWeYmPp3Zj5yzsG9k3aeoWhHc1jh+XYvX/0Q72isa1H8MaWOoi52nZuuoqYiyoUhwwgCV5+aolr5WvZZbQxK2iT+vXz1xRQSqpryVHQh0KKq1PvrxBptI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG81eFM5cEdZek04aldsSm9mVTQ4elpMcE5uWVhXa0FURWQ4YjNNczdnRHRv?=
 =?utf-8?B?L0tPQ0o0QlJIMFlxbUxDMjd0Mi9kQmVBamU2bTRCd0MvUUx1K2pQZlpId00w?=
 =?utf-8?B?TDVJVnlBMzF4OHZ4ZWl3THVxaC90Q2N4SEpraTdXVXZPaWp6S2g3V0RPakU1?=
 =?utf-8?B?bCtzTDhmR0Q3MVF0NlNXMXp6TGpqNWNrOWo5cEZTZmdMYm5NS1RiTGp6TjV5?=
 =?utf-8?B?bTBkNTM1ekE5WGdCeVE5UnNzcVZQZk1uSjJ3anVSVXBtOFZ5Y3ZoaUFNR05B?=
 =?utf-8?B?ZUN6REc0dEM2Rm45eVVKU08rMklYQzgyTEhYMUIxc2lpcmhRNmxiZzM4UkZS?=
 =?utf-8?B?UGxBSFNCZVh4aytsaVNUaHRMaFdVMkFxTEtCenAyM2JNL3JXdzE4bEtrTUtx?=
 =?utf-8?B?emNRWW9FTC9Gb3lkdFN2aXBRdUtpdHVmMHp3emJ1S2FLUklQdmZ6NGpWVHZG?=
 =?utf-8?B?Y1doY1U3bVhjME84dVpWTVFSRUo0N2picG5zSnlncHVjRnE4dGx2VjFKSG5M?=
 =?utf-8?B?cCtXT1dNWjhINmswdk1lU2xCTkoycDhtckY3SVFyUDQzNTgrbHl6aHp1cjYx?=
 =?utf-8?B?Ym53eTkrNkJEL1NkQ2JRdU0xcTZ0U1FlSERRRFBLR1h3QTJxeUt0WldGYUpW?=
 =?utf-8?B?WmVhQWNwek1CUEMrKzdUazJuc3hJNEVmaW0vd3IrcTZXTnp3YmhhQU8wUmZH?=
 =?utf-8?B?SUFLL3MySVNUWWVob1FJQ25oVzh2L0h1VTkvZkdNT00vTUtISmp6TTNHSThB?=
 =?utf-8?B?R1NLOWdBSTBZa0pJZHJmSnVDcXRLQkd0WjZUNGlpV2RURFNKWEpLUk1IcmVO?=
 =?utf-8?B?TGF3d3dIalB5MXBTYWFCNTBsd1NpWlR6TlA0c2x0dEZRYUpPdnArOTd5ZENH?=
 =?utf-8?B?VkpYbFR0K2NPcGI3VUMyRnZ5bUVOOFFtclczdU10aXBUOHFBMmpwOWNrQXV0?=
 =?utf-8?B?TUFVQzFRY0U4cUtMdzAvRU8xT2w3NFordW1ERFA1djRsdVJpb0YvZVcxT1BG?=
 =?utf-8?B?TnhSaHRUSTRqNWJuc2FLWWkyZ0N1dEh1MitiUVRiRkFkYlpwWnhkbitpYXNa?=
 =?utf-8?B?Ym1kdWx5QkFNNWJFWlhCc3NneW03UjQ1MzR0TllLMUZuRlR1WnRBWlNVQ0pn?=
 =?utf-8?B?MzNkdzJtTmxUQ2FseUdRNFJ3VVhJOEtseXpPRkpZSEprRDJJSWpRbWJTNWk3?=
 =?utf-8?B?ZGlDbDVhNmtoSS83Z2FYOWpjWE5RaEUyU3h1N3lrUVN5MlJuaWZYNzBrQzlE?=
 =?utf-8?B?OGhaUktjN2k5dkFsajArNXJRVjJzVDlsL3J6Rm1oZUd0VzhTMkJvdmlaSUxK?=
 =?utf-8?B?eUZobmdpTHlreFovR2ZmN0pBTjlmR2FPQ2xjd0J6VjBTY1ZRdkpORXg5eVRZ?=
 =?utf-8?B?SEErNGFEd0pvK3RsblRUajZCcEN3Y0NSQXJDQjRaN1dkUzYzOTR0UTBBZEJy?=
 =?utf-8?B?Q0FjUGtDck4rWm05K2lSODNCV1N5QW02VmlwbWxqYUhEWGZlZkFkS1owMmpp?=
 =?utf-8?B?dnBZb2x1ZGtuUURrM2xOUnlhVGx2RThrcUh1YmRyd1FqcTJmSTkwdXBLR1Q0?=
 =?utf-8?B?NGlDMmxOczFKWjFQNEZtS21jLzFZLzlKcUxPV1kzYVYvS29zeUk5ZzIrbGxj?=
 =?utf-8?B?TTY4N0pma0ZpNm9tUGpsWS80ai9XdlYzK0E4ZHBxVS9td2R4S1o4c254WU83?=
 =?utf-8?B?cFpBVHJremJEYUF2K2svUXJVd1liQmZwbE1nWjV2RFN5MzA1RVBlU1FKeGNR?=
 =?utf-8?B?R1pVK2ZnQ2hiQ29VTkFtZ3d2UHEvamZaNHA3S1BXZGNna3pBUmcvSUJSRFBQ?=
 =?utf-8?B?NEN1VWo3TVBRL0k1QUZrdkVvNE9hMUtZdVozcmpjSlJ3SGhpeFpMY0E0R3o0?=
 =?utf-8?B?WXVPeHhSWFYvd2xEZzZ6eGpySnNLZk9hOVpMUEFxQ2xzVXhzRTFsZ3R4eUJ4?=
 =?utf-8?B?eitLcS9ncTluVkdHUmZSL1dHZmxKS0F2NlN5U25RZHhIYUpCL0Zad1Bzcnl3?=
 =?utf-8?B?aysybTNxWDdHTEdQcUZXYzBuWWVVdUR2U20zUUJvdHFYZi9FMXh5MXQwbHVD?=
 =?utf-8?B?dlA5bm5MbzA0MmNyNThIeitaTEswVDlRMkdsZFdDaDgveXFKTXIvWEoySmkr?=
 =?utf-8?B?U3RHazhnaW9EL2QySEY1SGZzYlZxTlRnTG9lNVByVnFwSG82REE0ditHU0xT?=
 =?utf-8?B?WkxPaFJGbmE3b1V1NnlBZ0FobzZjakJpZ0dOYU5sSmlidUNJdUxtc3QwcUpv?=
 =?utf-8?B?NFZhWGxTa05XVnNPeGV1VGZqOEJVNHpoZ2o0SWovS0VLWHlmcUdMeW9EdUVL?=
 =?utf-8?Q?r0oNddjEooFz+deBmG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TSOXVUin1raXt68/3zb67mBRnjEaM4Fg/xTYyZ9lXThN6nrsZl+0nR0vskQaX6NdN0P/xqYVrHGueL/z4OIOEIjZkqNr5zwMmle4U+pr/YoThubIkfzI+91x9/3QeVAWhSYHPdOyew1Zn2DuLNOviomfLlgepNurmjA5x59WPSdmYzA5d6ddn3lHDolLIJ6zLKsGD3Lrs4zpHQSuPmNzXCjIOh1sFK57BQuQaGviAq7wr9rcoWZjVN8Cp4N8uY7EPI2SMlTK1Xhtlt2XCJseI+BgbaeQa01Ulq/W7rY69vTUeR1QWM7Fb6NGkOUWRJX6+BSU1IdlUsCVVUAtRMbJYw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2415774b-266f-440e-98f5-08de7e697cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 05:54:26.6700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDR1MQbAPy3W3re3n3TezYLBz4ECya9IY3f/cHvccPQFADzuX99JA5TVje5R9B9ixuKBHjzSuhVMaV2Yoz+YzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4759
X-Proofpoint-ORIG-GUID: T0JXEsfOYCQu67rXQj0cH3mzC02KblUE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA0NyBTYWx0ZWRfX8b+odDQELhUM
 y9nPWLYu5OF18Dd3MvpLwaCUTicbCWZciF5W4sot3F2NytJpOF2YwbUS5P9i8VBVoEYdHm5421n
 UKK07HknP5wSPv1Uyn7ou80x9pT7SOeoKtNZg4SzecKsa7SC1yABt8huH5BR1zkqX2/aVsVijPs
 oMRDmAzW8Z2NF+DI4r2aWkBmCVFLF14QLBVYdWMf94WU/v+R6wWfce9ZKOVMmFD2lRDtHdBdvbK
 tZjzm9Ezjzmk3/BuuWxd0+09c8tqIiBibk2Ygh42VWThFwPGBiOxV7EXxuK4wces0NKCeE5my17
 EFWm1W1olPwO7CxR56GGzwzuq1/C6O0E269jyJSh5UH+ZdbB8VW38z7+EhVVR/uJNToBPaGoKKx
 RspEmIgZjRsYRfZkQMsHyDh+DIaItQquWvIX3ku/zXVRoS5S5CChLvgqa/DNJHioBgx/NhfdoGq
 HkoRieG3YFApNJQkaRg==
X-Authority-Analysis: v=2.4 cv=V8twEOni c=1 sm=1 tr=0 ts=69afb215 cx=c_pps
 a=+c5u2l4ygy6ZxIQc3IwhHA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=0FD05c-RAAAA:8
 a=QyXUC8HyAAAA:8 a=8rWy6zfcAAAA:8 a=Gah0uZdMJeDdzEZOL9oA:9 a=QEXdDO2ut3YA:10
 a=l1rpMCqCXRGZwUSuRcM3:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: T0JXEsfOYCQu67rXQj0cH3mzC02KblUE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
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

PiBPbiAyLzI2LzIwMjYgMzo1MyBQTSwgQnVyYWtvdiwgQW5hdG9seSB3cm90ZToNCj4gPiBPbiAy
LzI2LzIwMjYgMjo1NyBQTSwgUGlvdHIgS3J6ZXdpbnNraSB3cm90ZToNCj4gPj4gV2hlbiBzZWNv
bmRhcnkgcHJvY2VzcyBydW5zIHdpdGggLS1uby1wY2ksIGl0IHNraXBzIGhhcmR3YXJlIGRldmlj
ZQ0KPiA+PiBwcm9iaW5nLCBjYXVzaW5nIGRpZmZlcmVudCBjcnlwdG9kZXYgZGV2X2lkIGFzc2ln
bm1lbnRzIHRoYW4gaW4gcHJpbWFyeS4NCj4gPj4gU2luY2UgbWVtem9uZSBsb29rdXAgaXMgYmFz
ZWQgb24gZGV2X2lkLCBpdCBsZWFkcyB0byBzZWNvbmRhcnkNCj4gPj4gYXR0YWNoaW5nIHRvIHdy
b25nIG1lbXpvbmUgYW5kIGNvcnJ1cHRpbmcgcHJpbWFyeSdzIGRldmljZQ0KPiA+PiBkYXRhIHN0
cnVjdHVyZXMuDQo+ID4NCj4gPiBUaGlzIHByb2JhYmx5IHdvdWxkIGJlIHRoZSBjYXNlIGV2ZW4g
aWYgeW91IGRpZG4ndCB1c2UgYC0tbm8tcGNpYCBidXQgaW5zdGVhZA0KPiB3ZXJlIHVzaW5nIGJs
b2NrLWxpc3RzL2FsbG93LWxpc3RzIHRvIG9ubHkgcHJvYmUgZGlmZmVyZW50IGRldmljZXMgaW4g
c2Vjb25kYXJ5DQo+IHByb2Nlc3Nlcz8gTWF5YmUgdGhlIHByb2JsZW0gaXMgbW9yZSBnZW5lcmFs
IHRoYW4gdGhhdC4NCj4gPg0KPiBNb3N0IHByb2JhYmx5IHllcywgSSBmb2N1c2VkIG9uIC0tbm8t
cGNpIGFzIGl0IGlzIHdoZXJlIGl0IGhpdCBtZS4NCj4gQ3VycmVudCBtZW16b25lIG5hbWluZyBz
Y2hlbWUgZm9yY2VzIGFsbCBhcHBsaWNhdGlvbnMgdG8gaGF2ZSBzYW1lIGRldl9pZA0KPiBhc3Np
Z25tZW50IHNvIGFueSBjaGFuZ2VzIGluIHRoZSBsaXN0IGluIHNlY29uZGFyeSB3b3VsZCBiZSBh
IHByb2JsZW0uDQo+IEFub3RoZXIgc29sdXRpb24gY291bGQgYmUgdG8gc3RvcmUgdGhlIGNyeXB0
b2RldiBkYXRhIGZvciBhbGwgZGV2aWNlcyBpbiBzaW5nbGUNCj4gbWVtem9uZSwgc2ltaWxhciB0
byBldGhkZXYgInJ0ZV9ldGhfZGV2X2RhdGEiLiBCdXQgaXQgc2VlbWVkIG1vcmUgY29tcGxleA0K
PiBhbmQgaGFkIG90aGVyIGRyYXdiYWNrcy4NCj4gPj4NCj4gPj4gRml4IGJ5IG1ha2luZyBzZWNv
bmRhcnkgcHJvY2VzcyBzZWFyY2ggZm9yIGRldmljZXMgYnkgbmFtZSBpbiBleGlzdGluZw0KPiA+
PiBtZW16b25lcyBpbnN0ZWFkIG9mIHVzaW5nIGxvY2FsIGRldl9pZCBhbGxvY2F0aW9uLg0KPiA+
Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBQaW90ciBLcnpld2luc2tpIDxwaW90ci5rcnpld2luc2tp
QGVyaWNzc29uLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgbGliL2NyeXB0b2Rldi9ydGVfY3J5cHRv
ZGV2LmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+
PiBkaWZmIC0tZ2l0IGEvbGliL2NyeXB0b2Rldi9ydGVfY3J5cHRvZGV2LmMgYi9saWIvY3J5cHRv
ZGV2L3J0ZV9jcnlwdG9kZXYuYw0KPiA+PiBpbmRleCA3YmRkYjE1NGMyLi41MDA3MTkzNWMyIDEw
MDY0NA0KPiA+PiAtLS0gYS9saWIvY3J5cHRvZGV2L3J0ZV9jcnlwdG9kZXYuYw0KPiA+PiArKysg
Yi9saWIvY3J5cHRvZGV2L3J0ZV9jcnlwdG9kZXYuYw0KPiA+PiBAQCAtMTE3Nyw2ICsxMTc3LDI3
IEBAIHJ0ZV9jcnlwdG9kZXZfZmluZF9mcmVlX2RldmljZV9pbmRleCh2b2lkKQ0KPiA+PiAgICAg
ICByZXR1cm4gUlRFX0NSWVBUT19NQVhfREVWUzsNCj4gPj4gICB9DQo+ID4+ICAgK3N0YXRpYyB1
aW50OF90DQo+ID4+ICtydGVfY3J5cHRvZGV2X2ZpbmRfZGV2aWNlX2J5X25hbWUoY29uc3QgY2hh
ciAqbmFtZSkNCj4gPj4gK3sNCj4gPj4gKyAgICBjaGFyIG16X25hbWVbUlRFX01FTVpPTkVfTkFN
RVNJWkVdOw0KPiA+PiArICAgIGNvbnN0IHN0cnVjdCBydGVfbWVtem9uZSAqbXo7DQo+ID4+ICsg
ICAgc3RydWN0IHJ0ZV9jcnlwdG9kZXZfZGF0YSAqZGF0YTsNCj4gPj4gKyAgICB1aW50OF90IGRl
dl9pZDsNCj4gPj4gKw0KPiA+PiArICAgIGZvciAoZGV2X2lkID0gMDsgZGV2X2lkIDwgUlRFX0NS
WVBUT19NQVhfREVWUzsgZGV2X2lkKyspIHsNCj4gPj4gKyAgICAgICAgc25wcmludGYobXpfbmFt
ZSwgc2l6ZW9mKG16X25hbWUpLCAicnRlX2NyeXB0b2Rldl9kYXRhXyV1IiwgZGV2X2lkKTsNCj4g
Pj4gKyAgICAgICAgbXogPSBydGVfbWVtem9uZV9sb29rdXAobXpfbmFtZSk7DQo+ID4+ICsgICAg
ICAgIGlmIChteiA9PSBOVUxMKQ0KPiA+PiArICAgICAgICAgICAgY29udGludWU7DQo+ID4+ICsN
Cj4gPj4gKyAgICAgICAgZGF0YSA9IG16LT5hZGRyOw0KPiA+PiArICAgICAgICBpZiAoc3RybmNt
cChkYXRhLT5uYW1lLCBuYW1lLCBSVEVfQ1JZUFRPREVWX05BTUVfTUFYX0xFTikgPT0NCj4gMCkN
Cj4gPj4gKyAgICAgICAgICAgIHJldHVybiBkZXZfaWQ7DQo+ID4+ICsgICAgfQ0KPiA+PiArICAg
IHJldHVybiBSVEVfQ1JZUFRPX01BWF9ERVZTOw0KPiA+PiArfQ0KPiA+DQo+ID4gTml0cGlja2lu
ZywgYnV0IHdoeSBub3QgcmV0dXJuIGBpbnRgIGFuZCAtMT8gUmV0dXJuaW5nIFJURV9DUllQVE9f
TUFYX0RFVlMNCj4gc2VlbXMgbGlrZSBhbiBvZGQgY2hvaWNlIGhlcmUuIFlvdSBjYW4gYWx3YXlz
IGNhc3QgdGhlIHZhbGlkIHZhbHVlIHRvIHVpbnQ4X3QgYXQNCj4gdGhlIGNhbGxlci4NCj4gQWxp
Z25lZCB3aXRoIHJ0ZV9jcnlwdG9kZXZfZ2V0X2Rldl9pZCBhbmQNCj4gcnRlX2NyeXB0b2Rldl9m
aW5kX2RldmljZV9ieV9uYW1lLg0KPiBCb3RoIGFyZSByZXR1cm5pbmcgUlRFX0NSWVBUT19NQVhf
REVWUyB3aGVuIHRoZSBkZXZpY2Ugb3IgZnJlZSBpbmRleCBpcyBub3QNCj4gZm91bmQgKHRob3Vn
aCB0aGUgZmlyc3Qgb25lIGFsc28gaGFzIC0xIGFzIGFuIGVycm9yIGNvbmRpdGlvbiBpbiBzb21l
IGNhc2VzKS4NCj4gPg0KPiA+IFRoYXQgc2FpZCwNCj4gPg0KPiA+IEFja2VkLWJ5OiBBbmF0b2x5
IEJ1cmFrb3YgPGFuYXRvbHkuYnVyYWtvdkBpbnRlbC5jb20+DQpBcHBsaWVkIHRvIGRwZGstbmV4
dC1jcnlwdG8NClRoYW5rcy4NCiAgICBGaXhlczogZDExYjBmMzBkZjg4ICgiY3J5cHRvZGV2OiBp
bnRyb2R1Y2UgQVBJIGFuZCBmcmFtZXdvcmsgZm9yIGNyeXB0byBkZXZpY2VzIikNCiAgICBDYzog
c3RhYmxlQGRwZGsub3JnDQo=
