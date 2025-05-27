Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AD9C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 15:10:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BED66402A0;
	Tue, 27 May 2025 17:10:54 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4B02A4028D
 for <dev@dpdk.org>; Tue, 27 May 2025 17:10:53 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R6Xofw025061
 for <dev@dpdk.org>; Tue, 27 May 2025 08:10:52 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w8800xef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 08:10:52 -0700 (PDT)
Received: from m0431384.ppops.net (m0431384.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54RF9QsI014683
 for <dev@dpdk.org>; Tue, 27 May 2025 08:10:51 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2099.outbound.protection.outlook.com [40.107.220.99])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w8800xee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 08:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxsXygpHxI7Gy4djR8kHhWlUo5fObUceL6WDYc1ktrm6XMezJ1i8waCESGtxwRwMy21rrc9uHKfA9qBj2ziIjgRIWPFbXiqleKxA+B8yh7usUltdSXZOzQQpffEwg4ZdeGpUgr2WnqKSQUjIh+rn5+nXAt7WpJJIcLK6XgnVSEpvT3NOYV0ilw79AXEoNmMJUHTvBeJ9XwhGogdh67mP6yCQH/so/0TuScEUOO6pn0ECVOkqNJHuwnrVgmstm6QGD+l8erjpohzegP/l6+vjeZsCEmIdjs1XRU6TQ4Wwx5PoE8eSNIv/tJukuu9KKjJdU0L7BTon/MpzSdOdzgUfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE7Uj7s0PpV4Yh3bh4z5ZpieE5aFj6XMPFmdzaqjqs0=;
 b=kf6N5cwr/gvRz3KKh+wpczoAK41byU/SMF9+plawz0u6I2qXsgGnFCK5A98zsORZEl/lUblP5aO0647P7Pfw4MbPaUAsndHky6/XyVRFUlU2EwHZXrzZQ7Hq6ixYifVaYS3s51AMDYTckb01t3gE2DEj+RKmpTabVA2TfW6I9iyQGSFuTDZZuUrrGsl0OnwQ0ydHXFBoAPGdh+1yusKb9AuLR27xiXdczv/IumJU98/0O05nJ+w2Fl9MWg3CXhmDoTQBd/T/hy1rDBQxkBAmVkKZX/ZIssT6jcDAnFwrBNnXItLGxtYHkjAa8H2dIctzkTKwyvJLe834HuFt/bP0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE7Uj7s0PpV4Yh3bh4z5ZpieE5aFj6XMPFmdzaqjqs0=;
 b=XT2xyHDIgefJwVhRgfIyg29d21GFSicozBRJsnzmkVbI7WZgKaUBl9tdaFpwn5PKBG+EQXqrSxJ7OOolG4OOHa9APyHEHfzZw0kj8PseBm9WxFKTtaEWYkbTK+U4qjmF3KCkrRp5win07tsl8rO8uAw7fwQ5qBNaDLDLl/PYYHk=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SN7PR18MB3934.namprd18.prod.outlook.com (2603:10b6:806:101::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 15:10:49 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 15:10:48 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Hanxiao Li <li.hanxiao@zte.com.cn>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v6 0/9] crypto/zsda: add zsda cryptodev driver
Thread-Topic: [EXTERNAL] [PATCH v6 0/9] crypto/zsda: add zsda cryptodev driver
Thread-Index: AQHbyvzWe6lknozoBEOz2bHTmeN9jbPmnM7Q
Date: Tue, 27 May 2025 15:10:48 +0000
Message-ID: <CO6PR18MB448461CE47F88189BFD48BFDD864A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250522064616.2267636-2-li.hanxiao@zte.com.cn>
 <20250522093037.2274245-1-li.hanxiao@zte.com.cn>
In-Reply-To: <20250522093037.2274245-1-li.hanxiao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SN7PR18MB3934:EE_
x-ms-office365-filtering-correlation-id: c821a53e-e7c1-4054-568f-08dd9d30a9b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q3M2d2dTc0tFU0VZRk1taktKelN1M0lRenJIWkF5dEpDWktMT3k1NEE0eXdo?=
 =?utf-8?B?L2NrSURwNVNqR3ZKRWpuWXRYdUgxZE16ZFQvdlFkQUNXbFFGTTRuRUNlQnMv?=
 =?utf-8?B?UHVzZWhiTjdkRUFSK0xZbkZIMmxJMFM4cTYzQ3E1TGxQQkpZamZwNVlXT1Mw?=
 =?utf-8?B?bnFjTkNqOFFwZktXWjRldjVHRGRaSUpkYUJ5Z2RzbDRXTzVMdkY2dGYvTkVt?=
 =?utf-8?B?eXZHZ0hSRUpQVVN0T0xBck9kRzFTYnpGNDJySGVHaE5Ld3lVRG9WV29YTWZH?=
 =?utf-8?B?czlzbXFNaU9VVVZBdFBxaWpwdzd1SVNzRTk1WHZiVjFsSzVSYmZvWTVmTGxK?=
 =?utf-8?B?OTNDMllEUDZrRVJ6WmdSTEZXUXZ4WW5ZSmc0TFhpdlRNR1JtS2hUNVoyVlZH?=
 =?utf-8?B?NC8rSmZsemVXRFhCbWdzWUs2bDh3bnkvRk92QTAvd3djZEw0a01RRXZ5TFFR?=
 =?utf-8?B?Q3ExMUJKVTNsL3lNSFAwc0NwVCtvcXFYc3FpT04xUDk2RVFmb2NlbERrTDYr?=
 =?utf-8?B?THppZjZPYjJxSjdhcy9reGhkYjBiZkFyclhDQUNDckEwT042ZVBBaUVsMEYy?=
 =?utf-8?B?cmNXWVVyQkNUZ3hINjM5TGVXdlpPQWNFeXFrby81czNaTyt5KzRpay9uMWZy?=
 =?utf-8?B?VFJtOHQvbUJOdE1OZXFCRlJ1ZjBqWjU0SG96T3R5SGtMb2tQR00xUnNmaHgv?=
 =?utf-8?B?dVdBbGNQRGFEbDlIWWk1cmdhYTZyUFg0UkF0MHRFTlRkMHNacEZ2UllzdExx?=
 =?utf-8?B?aDkwWmcvRVg5azI4YStxeExQa2ZTQmFGZlJoZEV2M3NoalRTVzU0NWwxN0JZ?=
 =?utf-8?B?eG14c2lnVytYbkg1N05XUm5kZm02aDUyWS93ZHltN1V6T1dObTdhQXhoMUVz?=
 =?utf-8?B?RGpvMnA2bDJGMVpWbEVQUjU4eU1Rc2dmZFc2R3VvRlFuRGdrVzJ4VDIwUnJG?=
 =?utf-8?B?SmZraFkyajYyMTJ6RGhIQ1l6TS92WGcvUlRHQ3FCWlI5UU1GQlBJNXZnQ3Uy?=
 =?utf-8?B?RlpEQnRPRFkrQXQyZEtZSmdiSW1LczRZOGl1SG5PT1h0ZXZHRG5ORmtHQlAz?=
 =?utf-8?B?Z0pFN3lJRnl1N0tZaExuaUROS2czcXYyNXNTYWNXcksxVTFpR2JOS1RCQjVq?=
 =?utf-8?B?UHVNUGYwVVZnbGl3cTlYcUw4WDBESHY3bEVqa21JSDdaendEMEJhSldxbFNZ?=
 =?utf-8?B?V0h0RzMrNXErNTFMQWpyK3YyeDNMN0lmdzUxQWpSWnNIWEN4eWxYbXVPb2p2?=
 =?utf-8?B?YmlGSE4rMXVZZzFkaWM4TW42L0hLODV6bW1jdXRPNmxubGZLUWhURU9ISXM2?=
 =?utf-8?B?Y2gzVEZWMW1KZzB1cVhWT1dFN3JJVktoWU9LTjI5OTZ1VVBnbmc2ZFJIZDQ5?=
 =?utf-8?B?OXZtdHo2VDZ3V25SbEE3S1QzeFNGZ0tWWE11L081NDJ4dzBSTW9hWUJ0dnds?=
 =?utf-8?B?WHR0bFZLTDI3YUdIa2VWbGNYa3lrSERxdjIrMlJ3TmdaYkFMQkROWlFWYjZp?=
 =?utf-8?B?clhBdVgwSUFyYlo1cjNLdE5Hc3pRbm9xemNoVDJ0RE43TXRIcDNkWFhWT3hW?=
 =?utf-8?B?VkNaTmNDbDlVNk9XQitpUHovRE1qbVZnY1dQdHNpdlAvSkkxRHEyUWliaklP?=
 =?utf-8?B?elRjK2lxRHVldkxOS2Mvc1YzRUYyYWRaTmpwaisydHV4MkdLVVFVV0wzeWM2?=
 =?utf-8?B?OEtoelNpU2l4WDJGZjRaTVFJS2Fma3ZWUFJyY2VOd3FxOGJSVDRKbEhycWtR?=
 =?utf-8?B?YXgyWHY4MlA1K1F2Y1VnMnAyYTJyb0dHRWpzVng5QndNTCt6Q1dHdVJPN1JT?=
 =?utf-8?B?Vzg1RVN1ejJFUHdVTURVcm95cjg5d3BmQm1jRVliKy9wcG55VnN1Wk9DRWZI?=
 =?utf-8?B?NkxwZG80SDBOYmNtc0hCdzkxTnl6aEdIeGc5Nk1EeksrNDR6Mm5qNHlzYXk5?=
 =?utf-8?B?NFVtSGRNdldQMkVUZGs0REdaK0pxei91ME5NVW1wVldQRm0zRnYvL3gzUTdU?=
 =?utf-8?B?aEZDU09YZVl3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUFGWnYxRFdIOGtNb1pmWVFmcGo3Tnk4RlJlZktVVFVaZW1DcUlNaWJzUHpm?=
 =?utf-8?B?b2FhQnZoUjEvK3hRSTZNUEF2cEgxYkhKdXplRjI2TTRmTithdUVsbFByTVFF?=
 =?utf-8?B?d25NdGtMM1IzcUROdjNuQmpUL3VsQi9JOVBqUlhGOHZxeWY5S0I4Wmt3Z2Zk?=
 =?utf-8?B?Q3Fhbk1NRUN3MTJQQW41MXlrZ0xJMFBtc0hvZmoycFQ1YzZzSWQrNHdVOWE2?=
 =?utf-8?B?RmJSejNlVmdhSUJKbU1SdzFlaTFwSFFMWGxnRUdUdUJPOXhxQy9BTWE0YTMw?=
 =?utf-8?B?OWMxZkxlNzlaZVNaditmMUJLNENUTW1Ia21FK0ZWRDNXVFB5Qks5UmU1TjU3?=
 =?utf-8?B?T1J4QjFiakJCMlRsQUxSZ1hPSDNEdHZDUVovQmNQZWNvellPNWdjZFQ5dkwr?=
 =?utf-8?B?QVlMSDNlZ0ZMcnFWcWxVU3B2WDAwN1JLV25NQ3RhK0VydlNVL0phUjRjVGw0?=
 =?utf-8?B?VEhCVnNvTmdNUFo2YVRZaU5HUy9wWEJyb1A4aWZzbWQzbWU0SnhOemNTdGpp?=
 =?utf-8?B?MnZvcXNLSzVFUGplYjJrcEZGK3VQTHpKR1ZFdXFsSllQYlNnSG5YaytVbVdJ?=
 =?utf-8?B?bitVMzdFeFltalRyaXlMM3ZGVkw4elR5ZGdQT2NtV0YvSGdUSjhOSEpsdkZk?=
 =?utf-8?B?dmdDVnNZTUtVWHczRnJYRldxRVJQcWZXTXZld0lDRkVuc0RDdmdQanBPbU1D?=
 =?utf-8?B?a3ZBclZqa082TWZrdEdseFZxTkJ1MEJ4M3d2RTc3aHFPVk1QejlpUTRCaFdE?=
 =?utf-8?B?R00zekNQSFJ2QlhuMFhxQXBtM1pEVWJRdHlPM0xmd1dxam9XT3BRN1FOQTJp?=
 =?utf-8?B?S2x5SnVpcENwN3VlUHFwejFUM0dyb2VWdDF4VWdFQllCeXhQL0g5eTN1eWxU?=
 =?utf-8?B?OU56NXBsQ2JIOEtMcFlMYzhHUklsL1pEcGc0TXNCOTZWNEVLbnI2dHlRcGJY?=
 =?utf-8?B?T1NSc2N5M3RnNFVqN0hzdTByN1pRV2cvZVgxT1VQZmVXM3ltWGtTd2dSdmN6?=
 =?utf-8?B?TnBEVnAxYU1VeHV3d1BSM25UcUhyeXFBWmFhWmtDR09LVzdZQ0JxQUJXeWk5?=
 =?utf-8?B?cWJjTTg2L1B4VlZDamRHOWNUejQ1cHdFVVVJK2tiVFczYkwwdjRTbG1EMWNM?=
 =?utf-8?B?VmVUclBHZm5JenFjc1pIUXpxdm03VldudUp1aXJKWndaM1hta1dNelZxbjBq?=
 =?utf-8?B?bmtkOHoySzdlSEVCN04xYkZyM254NTFDbTF0UGZ4UWtFajU2Ymk2YlRvbUw1?=
 =?utf-8?B?SkFuUmpnU3AxUEpWeisrKytvK2doUlF6OXpLQ21pWWYvK2tZWXZaVnQzUGdm?=
 =?utf-8?B?dklDbHU1WmdlcVZUL1dndTYzQmY2VXVMbzlyVXVRdkV4bFNLNTJLNkd4WG93?=
 =?utf-8?B?MFlRcFRjMWtFckF3MzkyS0ZDM1JZVUVFMWdsd2t3SlJmaFVnYVppRGRxdkpL?=
 =?utf-8?B?MmJIdG93SnRwRVd4RkJBSHhKcllmQnNhd3FiODJsdTRmOGtFbll6NnpnS1R1?=
 =?utf-8?B?Nm0yS21wek9Ub1FwTG0yb2FhSDBRSlpoS3pZTEluemo0YjdJT3pvMTY1KzBj?=
 =?utf-8?B?Qzg3MkFQTldicVV1NG9raUVhSE95U05ncTFGd3lTcXBEdFFoUXlqRzA4dkdZ?=
 =?utf-8?B?VkNETSt4WS9oRXdHNzN5L1lwYzJ4eTduclZXL3V5bFpwU2dqWEpVanNVVW1G?=
 =?utf-8?B?M29WVldlSHdZZGQzS1VLSjJMK1YxUVdDVWpJQVhoZ3gvYVVzUENaYzdhcFpC?=
 =?utf-8?B?YUVpMGlkeVBqTCttVnczQ0xiSDFFWEdsYmtXMWUxMG5INi95R3BacXBSTDlP?=
 =?utf-8?B?T0tCVTNPN2dQaUoyVUJmTEJqU0RlMDhabHdtNkoxSUdJV0d1bk5hd2M4QVZF?=
 =?utf-8?B?M2pqV2J0T3RMU0gxRm1TbWw1N2xPSTgxcHFNYXpldUhlNDBpdS9Ea2FVT0h4?=
 =?utf-8?B?UmNvQWMxR2E5U3g4TGZxMVpwY3RjVTg5MjNSWTR0ZXdGYUtBeDd2WFhVWkhT?=
 =?utf-8?B?L0V4b3hJbEY5aTNGbGFlTDkwSEc2QldST1p3cW9KSm9OWTNDVGgwR2xnSkFG?=
 =?utf-8?B?VmdmSVV2LytoOTg3ZGxNdU9lTE84YWV4akNrSG9hQTJYS2Z3dWtyYjhVYjJI?=
 =?utf-8?Q?Gi1y+VvFh5Les7VyygwTZZoDn?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c821a53e-e7c1-4054-568f-08dd9d30a9b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 15:10:48.7581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tc0GbulB7z9nP3ZcGhn2ieXHTkYG9XCQBHAj5T0L3RseyExwdW1DyxZTh8IxuoM6gaDbEz90FemGabmKVHLxJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3934
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEyNSBTYWx0ZWRfXzfZIOF2Yo2GU
 ckN1DEzmVIV0nbKsFMT04VdwJd9qkYEOz5F71o3ALR0HG4kUJ20otlFAVJyzYZuA6OiS3Tg3wli
 pcbE+ppTxiqc4UDD/AncHkwxjzbUsz7duJOrg0VTl/9P6Z1sRjAeH9Qeij/UfdWAG8CH663oMwk
 dus+NQneEiUpRPtJclt1OdSLrJn6w7UEB5Q1grF0JxB3RoX6PZi20rVJ09a+8hLRhUDSh1d0BtC
 Q59p5mwyZbmGQ85aop/fAEm6+ONBFbAy+oBMHrYsKayFTK98sIlBR+ehthE3KuU+9p2i7yIQjyw
 CLLTO65Hb4RiE57g6jWVeL8MYtjEICOI28YFUV4GILpgIQGGHM3fY5HU+BWjdNBxMDIVb6h63bE
 MM4GouDwNVTj9S7QcuuRon1vnIWEsmcCZp8G3cgXYIm20IoTqxIBuCEd8FzRz2Rfrx0Iw4bd
X-Authority-Analysis: v=2.4 cv=LZ086ifi c=1 sm=1 tr=0 ts=6835d5fc cx=c_pps
 a=TjEtcBNk5QtzPaPmdoRRgA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=gKQ5baWLiDN_bR8OuUYA:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: WC6Cw2Wduqajig3ax4hK_LcLzeYfbTRn
X-Proofpoint-GUID: SxD1recnInriNmhaBrHnZsPpZMIm4rUf
X-Proofpoint-Banner-Trigger: inbound
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"
X-Proofpoint-Banner-Convert: 7bit mime entity
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_07,2025-05-27_01,2025-03-28_01
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

<!DOCTYPE html>
<!-- BaNnErBlUrFlE-BoDy-start -->
<!-- Preheader Text : BEGIN -->
<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;height:0px;max-height:0p=
x;opacity:0;overflow:hidden;">
&gt; &gt; v6: &gt; - Modify the code according to the advise &gt; &gt; &gt;=
 v5: &gt; - Modify the code according to the advise &gt; &gt; v4: &gt; - ch=
ange some "sym" to "crypto". &gt; &gt; v3: &gt; - Modify the code according=
 to the advise &gt;</div>
<!-- Preheader Text : END -->

<!-- Email Banner : BEGIN -->
<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0=
;overflow:hidden;">ZjQcmQRYFpfptBannerStart</div>

<!--[if ((ie)|(mso))]>
  <table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" width=3D"100%" st=
yle=3D"padding: 16px 0px 16px 0px; direction: ltr" lang=3D"en"><tr><td>
    <table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" style=3D"paddin=
g: 0px 10px 5px 6px; width: 100%; border-radius:4px; border-top:4px solid #=
8d8c8c;background-color:#D2D0D0;"><tr><td valign=3D"top">
      <table align=3D"left" border=3D"0" cellspacing=3D"0" cellpadding=3D"0=
" style=3D"padding: 4px 8px 4px 8px">
	<tr><td style=3D"color:#000000; font-family: 'Arial', sans-serif; font-wei=
ght:bold; font-size:14px; direction: ltr">
	  Prioritize security for external emails:
	</td></tr>
	<tr><td style=3D"color:#000000; font-weight:normal; font-family: 'Arial', =
sans-serif; font-size:12px; direction: ltr">
          Confirm sender and content safety before clicking links or openin=
g attachments
	</td></tr>

      </table>
      <![if ie]><br clear=3D"all"><![endif]>
      <table align=3D"right" border=3D"0" cellspacing=3D"0" cellpadding=3D"=
0" style=3D"padding: 4px 0px 4px 0px"><tr>
	<td style=3D"direction: ltr">&nbsp;&nbsp;<a target=3D"_blank" href=3D"http=
s://us-phishalarm-ewt.proofpoint.com/EWT/v1/CRVmXkqW!ui3X-h-YrjX7-6H8OVxa7h=
vAChKe8V3gn4yG53zILiDs0Oh22EAfXbVu4-hWbbLfnHVyqJRyMKZcwi6bgtA_jQd1CmrC3qPzw=
sm_-VZpas-PUCsPM3wP0ytRzvScOodr08a97Vo$" style=3D"mso-padding-alt: 7.5px; p=
adding: 7.5px; border-radius: 2px; border: 1.5px solid #666666; "><strong s=
tyle=3D"font-weight: normal; color: #000000; text-decoration: none; font-fa=
mily: 'Arial', sans-serif; font-size:14px; line-height: 40px; ">&nbsp;&nbsp=
;Report&nbsp;Suspicious&nbsp;&nbsp;</strong></a>&nbsp;&nbsp;&zwnj; </td>
      </tr></table>
    </td></tr></table>
  </td></tr></table>
<![endif]-->

<![if !((ie)|(mso))]>
  <div dir=3D"ltr" lang=3D"en" id=3D"pfptBannergseu1ny" style=3D"all: rever=
t !important; display:block !important; text-align: left !important; margin=
:16px 0px 16px 0px !important; padding:8px 16px 8px 16px !important; border=
-radius: 4px !important; min-width: 200px !important; background-color: #D2=
D0D0 !important; background-color: #D2D0D0; border-top: 4px solid #8d8c8c !=
important; border-top: 4px solid #8d8c8c;">
    <div id=3D"pfptBannergseu1ny" style=3D"all: unset !important; float:lef=
t !important; display:block !important; margin: 0px 0px 1px 0px !important;=
 max-width: 600px !important;">
      <div id=3D"pfptBannergseu1ny" style=3D"all: unset !important; display=
:block !important; visibility: visible !important; background-color: #D2D0D=
0 !important; color:#000000 !important; color:#000000; font-family: 'Arial'=
, sans-serif !important; font-family: 'Arial', sans-serif; font-weight:bold=
 !important; font-weight:bold; font-size:14px !important; line-height:18px =
!important; line-height:18px">
	Prioritize security for external emails:
      </div>
      <div id=3D"pfptBannergseu1ny" style=3D"all: unset !important; display=
:block !important; visibility: visible !important; background-color: #D2D0D=
0 !important; color:#000000 !important; color:#000000; font-weight:normal; =
font-family: 'Arial', sans-serif !important; font-family: 'Arial', sans-ser=
if; font-size:12px !important; line-height:18px !important; line-height:18p=
x; margin-top:2px !important;">
Confirm sender and content safety before clicking links or opening attachme=
nts
      </div>

    </div>
    <div id=3D"pfptBannergseu1ny" style=3D"all: unset !important; float: ri=
ght !important; display: block !important; display: block; margin: 0px 0px =
0px 16px !important; text-align: right !important; width: fit-content !impo=
rtant;">
<a id=3D"pfptBannergseu1ny" href=3D"https://us-phishalarm-ewt.proofpoint.co=
m/EWT/v1/CRVmXkqW!ui3X-h-YrjX7-6H8OVxa7hvAChKe8V3gn4yG53zILiDs0Oh22EAfXbVu4=
-hWbbLfnHVyqJRyMKZcwi6bgtA_jQd1CmrC3qPzwsm_-VZpas-PUCsPM3wP0ytRzvScOodr08a9=
7Vo$"
    style=3D"all: unset !important; display: inline-block !important; text-=
decoration: none">
    <div class=3D"pfptPrimaryButtongseu1ny" style=3D"display: inline-block =
!important; display: inline-block; visibility: visible !important; opacity:=
 1 !important; color: #000000 !important; color: #000000; font-family: 'Ari=
al', sans-serif !important; font-family: 'Arial', sans-serif; font-size: 14=
px !important; font-weight: normal !important; text-decoration: none !impor=
tant; border-radius: 2px !important; padding: 7.5px 16px !important; margin=
: 3px 0 3px 16px !important; white-space: nowrap !important; width: fit-con=
tent !important;
	border: 1px solid #666666">
	Report&nbsp;Suspicious
    </div>
</a>
    </div>
    <div style=3D"clear: both !important; display: block !important; visibi=
lity: hidden !important; line-height: 0 !important; font-size: 0.01px !impo=
rtant; height: 0px">&nbsp;</div>
  </div>
<![endif]>

<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0=
;overflow:hidden;">ZjQcmQRYFpfptBannerEnd</div>
<!-- Email Banner : END -->

<!-- BaNnErBlUrFlE-BoDy-end -->
<html>
<head><!-- BaNnErBlUrFlE-HeAdEr-start -->
<style>
  #pfptBannergseu1ny { all: revert !important; display: block !important;=20
    visibility: visible !important; opacity: 1 !important;=20
    background-color: #D2D0D0 !important;=20
    max-width: none !important; max-height: none !important }
  .pfptPrimaryButtongseu1ny:hover, .pfptPrimaryButtongseu1ny:focus {
    background-color: #afaeae !important; }
  .pfptPrimaryButtongseu1ny:active {
    background-color: #8d8c8c !important; }
</style>

<!-- BaNnErBlUrFlE-HeAdEr-end -->
</head><body><pre style=3D"font-family: sans-serif; font-size: 100%; white-=
space: pre-wrap; word-wrap: break-word">&gt;=20
&gt; v6:
&gt; - Modify the code according to the advise
&gt;=20
&gt;=20
&gt; v5:
&gt; - Modify the code according to the advise
&gt;=20
&gt; v4:
&gt; - change some "sym" to "crypto".
&gt;=20
&gt; v3:
&gt; - Modify the code according to the advise
&gt;=20
&gt; v2:
&gt; - Modify the errors about cryptodevs/zsda.rst.
&gt; - Modify the errors about author.
&gt;=20
&gt; v1:
&gt; - Add zsda cryptodev driver.
&gt;=20
&gt;=20
&gt; Hanxiao Li (9):
&gt;   crypto/zsda: add skeleton
&gt;   crypto/zsda: add device operations
&gt;   crypto/zsda: add statistics
&gt;   crypto/zsda: add queue pair configuration
&gt;   crypto/zsda: add session configuration
&gt;   crypto/zsda: add enqueue datapath
&gt;   crypto/zsda: add dequeue datapath
&gt;   crypto/zsda: add capabilities
&gt;   app/test: add zsda cryptodev test
&gt;=20
&gt;  MAINTAINERS                                   |   6 +
&gt;  app/test/test_cryptodev.c                     |   7 +
&gt;  app/test/test_cryptodev.h                     |   1 +
&gt;  doc/guides/cryptodevs/features/zsda.ini       |  51 ++
&gt;  doc/guides/cryptodevs/index.rst               |   1 +
&gt;  doc/guides/cryptodevs/zsda.rst                |  58 ++
&gt;  doc/guides/rel_notes/release_25_07.rst        |   8 +
&gt;  drivers/common/zsda/meson.build               |  12 +-
&gt;  drivers/common/zsda/zsda_device.c             |  14 +-
&gt;  drivers/common/zsda/zsda_device.h             |  10 +
&gt;  drivers/common/zsda/zsda_qp.c                 |   9 +
&gt;  drivers/common/zsda/zsda_qp_common.h          |   5 +-
&gt;  drivers/crypto/zsda/zsda_crypto.c             | 272 ++++++++++
&gt;  drivers/crypto/zsda/zsda_crypto.h             |  47 ++
&gt;  .../crypto/zsda/zsda_crypto_capabilities.h    | 111 ++++
&gt;  drivers/crypto/zsda/zsda_crypto_pmd.c         | 364 +++++++++++++
&gt;  drivers/crypto/zsda/zsda_crypto_pmd.h         |  49 ++
&gt;  drivers/crypto/zsda/zsda_crypto_session.c     | 498 ++++++++++++++++++
&gt;  drivers/crypto/zsda/zsda_crypto_session.h     |  78 +++
&gt;  19 files changed, 1598 insertions(+), 3 deletions(-)
&gt;  create mode 100644 doc/guides/cryptodevs/features/zsda.ini
&gt;  create mode 100644 doc/guides/cryptodevs/zsda.rst
&gt;  create mode 100644 drivers/crypto/zsda/zsda_crypto.c
&gt;  create mode 100644 drivers/crypto/zsda/zsda_crypto.h
&gt;  create mode 100644 drivers/crypto/zsda/zsda_crypto_capabilities.h
&gt;  create mode 100644 drivers/crypto/zsda/zsda_crypto_pmd.c
&gt;  create mode 100644 drivers/crypto/zsda/zsda_crypto_pmd.h
&gt;  create mode 100644 drivers/crypto/zsda/zsda_crypto_session.c
&gt;  create mode 100644 drivers/crypto/zsda/zsda_crypto_session.h
&gt;=20
Series Acked-by: Akhil Goyal &lt;gakhil@marvell.com&gt;
Applied to dpdk-next-crypto
Thanks.

Please submit compress cleanup patch rebased over TOT.

</pre></body></html>
