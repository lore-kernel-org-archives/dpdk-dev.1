Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17403C282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 16:06:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E28D402D0;
	Mon, 17 Mar 2025 17:06:03 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by mails.dpdk.org (Postfix) with ESMTP id 5AFEE4028B
 for <dev@dpdk.org>; Mon, 17 Mar 2025 17:06:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FS1bFW0gNUMEtgINtPF6qBl26v/yjIoYYn5ugbmADNwp3nBJx2dFAxJSaZDHNNYx6fSQGDnmi6ttuArFjUrp5BeH5X5+flefObOYKJqi3hG7U6ZdqIILqsjkr4mQtm71S6FW8dv9w9TjFtHLM7nleByuVZ+bzEDPZWBKT0IzQu6rRVmmborr4nB3rzxIpdwiSMdi7zSqU6d/UbI+wFDZswlRZaHsuTLeNXEHBuXoAQ2ybkmDBI3k5j/ASLOlZsa8TJ8pnxD4lr/4v+/SjOGw62+qE9slFrxlqMvUYkQJMLud2s/yP7+XSUAOeu0YaEM1k9xtxnvO39LJ6wgQm3HOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFyXR90Jh4MSIX4BkFbWtVTl14nTBX9yjpaJUaFYOp0=;
 b=uqyqxaxtVKlx7HZD6JkQMhvkRSyuvWHw7Rz+1lxQWnxpgbGLf1Bf/h9wnWGeMByLprAbFH4g0gWse4OvWWRUywW7C3GEC305pSz2MozX9rJCXm2HoC0DFfOjny7Oj1Zd5OHtrW5Bi6xVLrIVlw8Rngjlg0rc6PVjYm5Yd1Ih4DMh1MjZKj2lMOxVKFPw61wfesW1huUn/5IQd86TvNye6XCrhHio0gjvEyXrTvK50tlup6zcPNjT6XtglR9u7s7UwmQQznhrFozs4Ls1cbxSz2GYuw8OO+aseQKHS/l7oWE1DSuKpPxIZDgCTvIBEFctpZrXU/zQwvjlExE9kmC+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFyXR90Jh4MSIX4BkFbWtVTl14nTBX9yjpaJUaFYOp0=;
 b=KrAfia5MZD9ZFfafcveQN0vvf5gTASDYRKGxRft8qDzrlhEiH9gDQfATMmioK1ftoxQsdhnxuhi/TQsC85nWU7KTxeM/hd8uPY1+umRD/DKwETrrVewGceHNxp+AVAjG3D4pznr7MYUGRpMdzy5uMmFNifHX1/EL01euHe61n+HrXikP6UAXEMBAKfvSOAM35GQJnZxxIiO4lplsgbmyzV30m4QWZF38tdxXmAXIQr7vsWPYfmmn8zgOym2Wx7iEE0/MOVoxsUMMM2cquprIcC4wUQzxHnlx/WBlm6AV8ZWOqgPb2s0Ke0XEC1tbPekSpFeprewpUcDFBg+k8GDtbw==
Received: from SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 16:05:59 +0000
Received: from SN7PR12MB6909.namprd12.prod.outlook.com
 ([fe80::716f:b388:7768:7525]) by SN7PR12MB6909.namprd12.prod.outlook.com
 ([fe80::716f:b388:7768:7525%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 16:05:59 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Yang Ming <ming.1.yang@nokia-sbell.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [External] Re: [PATCH 2/2] net/mlx5: improve log file path
Thread-Topic: [External] Re: [PATCH 2/2] net/mlx5: improve log file path
Thread-Index: AQHbTUDtWlY/UYCZrEKFHLEb+FG5y7NjAP8ggAn+oQCAAlP2AIAIuiDg
Date: Mon, 17 Mar 2025 16:05:59 +0000
Message-ID: <SN7PR12MB6909C36BA0735332C81624EAD0DF2@SN7PR12MB6909.namprd12.prod.outlook.com>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20241213092444.2987-2-ming.1.yang@nokia-sbell.com>
 <SN7PR12MB69096FB0FD4930E9CE8A8F80D0C82@SN7PR12MB6909.namprd12.prod.outlook.com>
 <20250310075948.56109517@hermes.local>
 <b415f31f-2816-4689-9294-fd385880ba9c@nokia-sbell.com>
In-Reply-To: <b415f31f-2816-4689-9294-fd385880ba9c@nokia-sbell.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6909:EE_|SJ2PR12MB8832:EE_
x-ms-office365-filtering-correlation-id: 90a013e7-367e-41d3-c152-08dd656d9b86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UzZndElMZnNwS0FMaFlTZEtoR1lBQksxN2FNMnFjOWpIbFJrRnk3ZFZQQVNT?=
 =?utf-8?B?RzB0TU9xbHA1WGdod1AwWGdVTG9qUlRFL1E2VHV1MGhmNUU5bklqTXJCaElJ?=
 =?utf-8?B?WVdLZTF5S3lCUko2WjNFMVpibS9CK1JwdzNNY28vdGJ3YVlTQ1RiSjY5eS8r?=
 =?utf-8?B?UmRMTnpRTFBJbGRtTERUN05Wa0VDNytrbGpkYlpOVUtjM21JWlJETmk0T2pk?=
 =?utf-8?B?dUcxVDdVU3U1NmxJNjI2NlRKSHpmOHZOYWcxL29sRWpJSTMvaXVUN3JVbEYz?=
 =?utf-8?B?VzY0M0FVcENDejVUSG5XYkNyL0ZKeXl6VURWdzJ6QjFSbFZQS1lLVWpGcUsr?=
 =?utf-8?B?ZnkybnlsTlB0MUdsRHdZVmxBVlVpcW5jb0dacU1YZGF0aStpYWxXdmZWQzRE?=
 =?utf-8?B?aVNZWFMwL2RkeXVXN3NUQlpqMlhRTlVtcGVlblplODlOSVhpTDhidUpwVDZ3?=
 =?utf-8?B?TG43MmdGNW53SUZickdvQWhFVHVOK01nUC9iZlFxMUw0MWVlL0tBYml1UTdS?=
 =?utf-8?B?Q3ZGbXNHZXJ4MnJoZVdKaDFLQ0dSZ2k3cHRvanRQa0hMYVZobFNKT0dJbTJB?=
 =?utf-8?B?QzVsZTlHVVo3Z042UGRacHZveHVmczdEMnVVS29CREIzOUh2MFp4dEZ4dWhu?=
 =?utf-8?B?VHBiUTVxNjRiMTZicVMvSUkyUmF6cmpEMDRxVmZmNUZEbVJpU3dXdEI2N25s?=
 =?utf-8?B?SFRVdC9TbTJ5QlBhbW1GQndXWjBkdGhXeWs0K0tHcjBJdzRyM0Fad2piaXox?=
 =?utf-8?B?NmQ3cWtYWSt2V1ZuNW01UWpmem1YUGREYkdWem12MS85VWlwQXZ4WVZ3cW5x?=
 =?utf-8?B?NmhFQXZvbGlpbTNTRXFHWXR5VHFCeGJ5OWcrREROcTVjSVJDNjMxOHVjTENZ?=
 =?utf-8?B?aXZvUXFKTUNwS0liYlQwRmFERmNibW5MNHVMUlVFSllDaXd4TEYvWFpUNFVS?=
 =?utf-8?B?dldzN3cyTmJ5TWtzQlBIWDh0dTNiYURGQ0J6OWhSd1dEOHhaejF6bHhTVGgv?=
 =?utf-8?B?a3ZURktzQTVicTJWc3pFTnpHVXEyTm1jQlZUV1FqZS9KU0hRMnVUcEtCSyt3?=
 =?utf-8?B?RisyblplSzl4V3poTjVQQjZGdEg2V0txWTJBVHZKZlRzTmVxNzh5NUdzYkJW?=
 =?utf-8?B?V3doWmlBSFVTdm1aSXZzR0hkRFJ0Qnk3WjgrUmxvQTFheFFHbStlQUpoZ2Fs?=
 =?utf-8?B?ekJTS1RXcjdvTDVnakNxVzNIN3BxUGJxTlRSY1VYK05IRHlTclNZZ2s2LzI0?=
 =?utf-8?B?WDBHNHdNKzRQeE1MZFdJd1F5aVBtbkYxZWw3a1hzZCttd1lpQ3lMcjZzVWhG?=
 =?utf-8?B?eVZrQm8rN2RLOW50Z3BVMmtYZHNnSlpjaHhtT1VIZUpxVkZEK21CWGJldHE0?=
 =?utf-8?B?Y0l0dXc2VDVHaUg2cWVKdWZJaHlOU2Fnb1I3Y2hYcXlBRlJ4ekxyS21PSE0x?=
 =?utf-8?B?SGEvQTB4d1BocXJ1Z1NVNUcxTHJYZnJocjU5N3Y5T3BIMWJWaGZld1ZMRkZM?=
 =?utf-8?B?MS9lWm9HZ0RXRnluZ0lpV1hBdVZqSUlEWFFrUUo3SnRpNzFoT1Z3dm9UOHF4?=
 =?utf-8?B?VlNoUzNhMUJZZ05qVFlKVXZTc0JQVlVPM1U5VWFmTzNiVVdJWVM4bGNpRVZu?=
 =?utf-8?B?SW1vYnd6clNrTEI5bjdWVGgrSXJ1eXdyYkdTTWFzM3dTM1U2WlJGSDdoUTlB?=
 =?utf-8?B?bnIwTmloZ1oxeVlobFVPRHJvSTRGbVZELzEvRXluYXhITG1Qbkpsc0kraEVs?=
 =?utf-8?B?VERsSU1BZlpObS9BTWZBTlE3Snk1UCtUV2pTM2UyVUpFM2VXZ2RRZzVpWHJX?=
 =?utf-8?B?UzNDK2Nhei9CSXNXTmp3YThMUEZFMnV4ZW9DT3kwNENHNUdtNUc4ZVVPczVI?=
 =?utf-8?B?Y3R3VnhLbGZ4NjBWWGtSSWk1L1YrVWtFQkszM1hETDgzbDFjMVNidVhBVnYy?=
 =?utf-8?Q?EwGIXEghhoUiwHVqfFG5Hq5coCfGX+gt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6909.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTdLd1JwRzhoKzBWQlYxa05ibmdrZW5VazdqSWRhQXYzMGJWOVEyTDZWY2ds?=
 =?utf-8?B?Y0xzL09EUzV5eVpnVEE1c1l1dTR6UlhHeUZJOEhKejVZYk9nRHl2WFdJUHBz?=
 =?utf-8?B?Z3dtRFBQMmVOZU9zQUl5TlhUS0dPaGJoVXhDUmQ2d2RRWFZkNnRZVnRiYW5y?=
 =?utf-8?B?eTVmOWhLbUFSazN0SU0rbXNSR2cxVzF3Szk3Sm5GbHRkZTFSd0dxV2kxM2FV?=
 =?utf-8?B?Mk5Cc2xIbld5QWowTFA2TlJmTXNWSVRWZzdHN2VaMUtBYW4zRFRnWUxpS2JM?=
 =?utf-8?B?aWRQbWxqQkdtV1FHSDBlM042SmVMQ0lNS0oxUDN6OVRMc28ybWxabDI3ZXpt?=
 =?utf-8?B?amdxQUszc1VpbUdOTlowWGZVcE1ORDJPVDJ3T0ZvcjFqOStBQ0d5d1ZRVEV1?=
 =?utf-8?B?NnUyMTZqWHMvbzgrYlUzV1duT2tCTEcxRk1FWGliVGswZ3B0VzRnclFib215?=
 =?utf-8?B?R1REUjRxWXRBbHZXY0M5ZmplOU4rWkNwdE1HQ3dWbG1mZkE5QjloMnErL3g0?=
 =?utf-8?B?Q05lU2Z3ZnMrV3FPS0JNaEJQQlIwdDZ1bEpKSUF4OTdaNmV6NFFSYVJ0OW1m?=
 =?utf-8?B?QUoxaFYxMDMrMndTR0RoVjI5VFVsdFVEVkEzVFJIZUFKRDlFVVg0bU9jNng0?=
 =?utf-8?B?ZU40c2E5UVV1Z2t6NUhWaWQrM3U5UFFROERJcmJBbjM3Y3dwU3FCT2VYNGlq?=
 =?utf-8?B?L3NEYVVZN1pzdzRiRjMyL1Ixdnh5N0hYMU9BVFp5Y1h4MldWeWY3aDc0ZTJw?=
 =?utf-8?B?MHpGMXJ2Mk9lMXV1MHUwUkJGeEplbm1TV25FanFFQ1pUOW40Z3Z6RkhqVWIw?=
 =?utf-8?B?czFpTGR1S256M2hhbkxyUEFHeE9icFJCcWJ6NndSOXR5V0JwT00rUmxGY2t3?=
 =?utf-8?B?azI5anVrTUpTNUg4bStUL2pvS1lSRkhXRkEwVk1wQkkwL3B0VHNjOFJGT0RU?=
 =?utf-8?B?TXllQlRBWno5NmFrTHV2eW53SzZ1RTR1aEJ3aVJEN0VmTnExVDlzY3M0U0d1?=
 =?utf-8?B?TkFCY1BVdDhteFgxeVEvWmdoa3Zra3hMdUliNUhJbndzYWU5MnlxcG5QWmdn?=
 =?utf-8?B?TlBpODdtZW5LOGxVL2Rtb2Nndi8xVk9Ec1pXWmxTSkxHMzZCVnBUeHJxRkVK?=
 =?utf-8?B?NWtPYThrUkg3a2c0a09rUEMxQ2x4WVUwSnFyemVvOGNRYU52b3NSNUt4bHhQ?=
 =?utf-8?B?cTd3aHZOdkVlWkxha2Y2L3VBeHZwc3pOQ0U1RVBmRXFUc0lRNTI0N1JXSVFC?=
 =?utf-8?B?VDZuSlRKTzM4d2xGdGRyeEZxSE1pb0dYNnFYVjZjWW5pRUtDRmhwZFZNZ0pM?=
 =?utf-8?B?L1N6RnFyTG9wRnlTSkVOd2ptWTJVbklua0Q1OEswRi9JczVKRnhweW40MXM1?=
 =?utf-8?B?YXBSTkl2RXh4T2J0Wkl3ZElSRWVrc050OEo4bElBMzRIZE1YaE0yaVB0VS9v?=
 =?utf-8?B?cXVPdmJMd09DNVRVbUNqNGVCblFZRVNNSThpQmtFa2VVbzlvYUlqTDhGS2Nx?=
 =?utf-8?B?U3c2dTZSU1Y3RmpQOXlaRTVsemIwcEtaSWtIaEJGazJ1Mk1FV2V6MjlQekJ1?=
 =?utf-8?B?OHZiMTlKVTdQTkhJNW5mWHlkamtEMGVpeWlBMUxRQTcvWGhQb1hWWnJlbHNw?=
 =?utf-8?B?dXFxOXhPWFB5cmtpYkYxb3pRdFphYnpYL2pKZHUyVU40aFVDU2MxVm5SaW9R?=
 =?utf-8?B?eENkSThVUjdwOUdYS0xoQkZnQldHdksyUTNqL2lyRjZvUGhTZjJGTEJVL3Jl?=
 =?utf-8?B?TDhhWmUvWmZ3ckNVMHlCMUFnVnU1WThXUlE5Kys3d1Avdkd1K2ZHTUFUckRS?=
 =?utf-8?B?Ym5sdkwvalUxOVFRQ1VMNEhxZTE4VXo0M3dnRUczKzJEa0FzZzh6L0JEOHI3?=
 =?utf-8?B?ZmlaWWpCRXowV2p4UFlPc0l4RXUxaFg4Skg1UVU2TU1TbWpqT3IxOVlZOVdk?=
 =?utf-8?B?RWpxZ3JidUdWOVFNTUZ0OFNzNERONjVEdEp6ZDFvU0JPWkt0dFltR3EycTMz?=
 =?utf-8?B?V3Y2SkJlUzU3SEdFYWJXUHVISnR6czBBazRUVVBlLzJrY1VoTzlmaW9SbHVv?=
 =?utf-8?B?R2lOSDhJcnltVFU5dWVOTVNzWGVVYjhWaStSN3N2NDVCR1dpMzhsM1Flbjky?=
 =?utf-8?Q?65B8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a013e7-367e-41d3-c152-08dd656d9b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 16:05:59.1193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xs2p6fw3qX3/FItBBhrt63dZhyJI47ktizwyNr9W2TH+3yeG9FnsppR+xJ+Oea9oMm7M0OiDGdckXQY6DO39AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832
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

SGkgTWluZyAmIFN0ZXBoZW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogWWFuZyBNaW5nIDxtaW5nLjEueWFuZ0Bub2tpYS1zYmVsbC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgTWFyY2ggMTIsIDIwMjUgMTA6MzMgQU0NCj4gVG86IFN0ZXBoZW4gSGVtbWluZ2VyIDxz
dGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz47IEJpbmcgWmhhbw0KPiA8YmluZ3pAbnZpZGlhLmNv
bT4NCj4gQ2M6IERhcml1c3ogU29zbm93c2tpIDxkc29zbm93c2tpQG52aWRpYS5jb20+OyBTbGF2
YSBPdnNpaWVua28NCj4gPHZpYWNoZXNsYXZvQG52aWRpYS5jb20+OyBPcmkgS2FtIDxvcmlrYUBu
dmlkaWEuY29tPjsgU3Vhbm1pbmcgTW91DQo+IDxzdWFubWluZ21AbnZpZGlhLmNvbT47IE1hdGFu
IEF6cmFkIDxtYXRhbkBudmlkaWEuY29tPjsgZGV2QGRwZGsub3JnDQo+IFN1YmplY3Q6IFJlOiBb
RXh0ZXJuYWxdIFJlOiBbUEFUQ0ggMi8yXSBuZXQvbWx4NTogaW1wcm92ZSBsb2cgZmlsZSBwYXRo
DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRh
Y2htZW50cw0KPiANCj4gDQo+IE9uIDIwMjUvMy8xMCAyMjo1OSwgU3RlcGhlbiBIZW1taW5nZXIg
d3JvdGU6DQo+ID4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJl
IHZlcnkgY2FyZWZ1bCB3aGVuIGNsaWNraW5nDQo+IGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVu
dHMuIFNlZSBodHRwOi8vbm9rLml0L25zYiBmb3IgYWRkaXRpb25hbA0KPiBpbmZvcm1hdGlvbi4N
Cj4gPg0KPiA+IE9uIFR1ZSwgNCBNYXIgMjAyNSAwNjoyMzowNiArMDAwMA0KPiA+IEJpbmcgWmhh
byA8YmluZ3pAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4NCj4gPj4gSGkgTWluZywNCj4gPj4NCj4g
Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+PiBGcm9tOiBZYW5nIE1pbmcgPG1p
bmcuMS55YW5nQG5va2lhLXNiZWxsLmNvbT4NCj4gPj4+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIg
MTMsIDIwMjQgNToyNSBQTQ0KPiA+Pj4gVG86IERhcml1c3ogU29zbm93c2tpIDxkc29zbm93c2tp
QG52aWRpYS5jb20+OyBTbGF2YSBPdnNpaWVua28NCj4gPj4+IDx2aWFjaGVzbGF2b0BudmlkaWEu
Y29tPjsgQmluZyBaaGFvIDxiaW5nekBudmlkaWEuY29tPjsgT3JpIEthbQ0KPiA+Pj4gPG9yaWth
QG52aWRpYS5jb20+OyBTdWFubWluZyBNb3UgPHN1YW5taW5nbUBudmlkaWEuY29tPjsgTWF0YW4g
QXpyYWQNCj4gPj4+IDxtYXRhbkBudmlkaWEuY29tPg0KPiA+Pj4gQ2M6IGRldkBkcGRrLm9yZzsg
WWFuZyBNaW5nIDxtaW5nLjEueWFuZ0Bub2tpYS1zYmVsbC5jb20+DQo+ID4+PiBTdWJqZWN0OiBb
UEFUQ0ggMi8yXSBuZXQvbWx4NTogaW1wcm92ZSBsb2cgZmlsZSBwYXRoDQo+ID4+Pg0KPiA+Pj4g
RXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMN
Cj4gPj4+DQo+ID4+Pg0KPiA+Pj4gMS4gL3Zhci9sb2cgaXMgaGFyZCBjb2RlIHdoaWNoIGlzIG5v
dCBhIGdvb2QgY29kaW5nIHN0eWxlLg0KPiA+Pj4gMi4gL3Zhci9sb2cgbWF5IGJlIG5vdCBhbGxv
d2VkIHRvIGJlIHdyaXR0ZW4gdmlhIGNvbnRhaW5lcidzDQo+ID4+PiByZWFkLW9ubHkgbW9kZS4N
Cj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIE1pbmcgPG1pbmcuMS55YW5nQG5va2lh
LXNiZWxsLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICBkcml2ZXJzL25ldC9tbHg1L21seDVfcnh0
eC5jIHwgMyArKy0NCj4gPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9tbHg1L21s
eDVfcnh0eC5jDQo+ID4+PiBiL2RyaXZlcnMvbmV0L21seDUvbWx4NV9yeHR4LmMgaW5kZXggZWFk
YWRjZGZmYi4uYTBkYTczYzljMyAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvbmV0L21seDUv
bWx4NV9yeHR4LmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvbmV0L21seDUvbWx4NV9yeHR4LmMNCj4g
Pj4+IEBAIC0xMiw2ICsxMiw3IEBADQo+ID4+PiAgICNpbmNsdWRlIDxydGVfcHJlZmV0Y2guaD4N
Cj4gPj4+ICAgI2luY2x1ZGUgPHJ0ZV9jb21tb24uaD4NCj4gPj4+ICAgI2luY2x1ZGUgPHJ0ZV9i
cmFuY2hfcHJlZGljdGlvbi5oPg0KPiA+Pj4gKyNpbmNsdWRlIDxydGVfZWFsLmg+DQo+ID4+PiAg
ICNpbmNsdWRlIDxydGVfZXRoZXIuaD4NCj4gPj4+ICAgI2luY2x1ZGUgPHJ0ZV9jeWNsZXMuaD4N
Cj4gPj4+ICAgI2luY2x1ZGUgPHJ0ZV9mbG93Lmg+DQo+ID4+PiBAQCAtMzExLDcgKzMxMiw3IEBA
IG1seDVfc2V0X3N3cF90eXBlc190YWJsZSh2b2lkKQ0KPiA+Pj4gICAgICAgICAgfQ0KPiA+Pj4g
ICB9DQo+ID4+Pg0KPiA+Pj4gLSNkZWZpbmUgTUxYNV9TWVNURU1fTE9HX0RJUiAiL3Zhci9sb2ci
DQo+ID4+PiArI2RlZmluZSBNTFg1X1NZU1RFTV9MT0dfRElSIHJ0ZV9lYWxfZ2V0X3J1bnRpbWVf
ZGlyKCkNCj4gPj4gSSBhZ3JlZSB0aGF0IHVzaW5nIHRoZSBmaXhlZCBQQVRIIGlzIG5vdCBhIGdv
b2QgcHJhY3RpY2UuIENhbiB5b3UNCj4gZW5zdXJlIHRoYXQgdGhlIHJ1bnRpbWUgRElSIGlzIHdp
dGggUlcrIHBlcm1pc3Npb25zPw0KPiA+IERyaXZlcnMgZG9pbmcgYW55IGtpbmQgb2YgY3VzdG9t
IGxvZ2dpbmcgaXMgYmFkIHByYWN0aWNlLg0KPiA+IFRoaXMgc2hvdWxkIGJlIGhhbmRsZWQgYnkg
RUFMIGxvZ2dpbmcsIG5vdCBwcml2YXRlIGZwcmludGYncw0KPiA+DQo+ID4NCj4gPg0KPiBIaSBT
dGVwaGVuLA0KPiANCj4gWWVzLCBJIGNvbXBsZXRlbHkgYWdyZWUgd2l0aCB5b3UuIFRoZSBEUERL
IGRyaXZlciBzaG91bGQgdXRpbGl6ZSBFQUwNCj4gbG9nZ2luZyBpbnN0ZWFkIG9mIGZwcmludGYu
IFdlIGhhdmUgcmVjZW50bHkgYWRkcmVzc2VkIGFuIGlzc3VlIHdoZXJlIERQREsNCj4gd2FzIGFw
cGxpZWQgaW4gYSBjb250YWluZXIgd2l0aCBhIHJlYWQtb25seSBmaWxlIHN5c3RlbSBtb2RlLiBJ
biB0aGlzDQo+IG1vZGUsIHRoZSAvdmFyL2xvZyBkaXJlY3RvcnkgaXMgcmVhZC1vbmx5LiBIb3dl
dmVyLCB3aGVuIERQREsgaXMgcnVubmluZywNCj4gdGhlIGRpcmVjdG9yeSBzcGVjaWZpZWQgYnkg
cnRlX2VhbF9nZXRfcnVudGltZV9kaXIoKSBtdXN0IGJlIGNvbmZpZ3VyZWQNCj4gd2l0aCByZWFk
LXdyaXRlIHBlcm1pc3Npb25zLiBUaGVyZWZvcmUsIHdlIGhhdmUgbWFkZSB0aGlzIG1pbm9yDQo+
IGltcHJvdmVtZW50Lg0KPiANCj4gUGxlYXNlIG5vdGUgdGhhdCB3ZSBhcmUgbm90IHRoZSBkZXZl
bG9wZXJzIG9mIHRoZSBNZWxsYW5veCBDWDQvQ1g1IE5JQywNCj4gbm9yIGFyZSB3ZSBhZmZpbGlh
dGVkIHdpdGggdGhlIG1hbnVmYWN0dXJlciBvZiB0aGVzZSBOSUNzLiBBcyBzdWNoLCB3ZSBhcmUN
Cj4gdW5hYmxlIHRvIG1ha2UgdGhlIGltcHJvdmVtZW50cyB5b3UgZGVzY3JpYmVkLg0KPiANCg0K
SSB0ZW5kIHRvIGRpc2FncmVlIHdpdGggc3VjaCBjb21tZW50cy4gU3VjaCBkdW1wIHdpbGwgYmUg
Z2VuZXJhdGVkIHdoZW4gc29tZSBlcnJvciBoYXBwZW5zLiBXZSB3YW50IHRvIHNhdmUgdGhlIGlu
Zm9ybWF0aW9uIGludG8gc29tZSBmaWxlIGZvciBvZmZsaW5lIGFuYWx5c2lzLiBJIGNoZWNrZWQg
dGhlIGNvZGUsIGN1cnJlbnQgUlRFX0xPRyByb3V0aW5lcyBkbyBub3QgaGF2ZSBhIHZhcmlhbnQg
dGhhdCBzdXBwb3J0cyBzcGVjaWZpZWQgb3V0cHV0IHN0cmVhbSBidXQgbm90IG9ubHkgc3Rkb3V0
L3N0ZGVyci9zeXNsb2cuIE9ubHkgZ2xvYmFsIFBBVEggY2FuIGJlIHVzZWQuIChjb3JyZWN0IG1l
IGlmIEkgbWlzc2VkIHNvbWV0aGluZykgSWYgdGhlcmUgaXMgYW4gQVBJIGNhbiBzcGVjaWZ5IHRo
ZSBvdXRwdXQgc3RyZWFtIGluc3RlYWQgb2YgdGhlIGdsb2JhbCBzZXQgb25lLCB0aGF0IHNob3Vs
ZCBzYXRpc2Z5IHRoZSBuZWVkcy4NCg0KU2F2aW5nIGl0IGludG8gc29tZSBmaWxlIGlzIGEgbXVz
dC4gRm9yIGV4YW1wbGUsIGlmIHRoZSBjdXN0b21lciBpcyB1c2luZyBhIG1vbml0b3Igd2l0aCBW
R0EgZGlzcGxheSBpbnRlcmZhY2UgY29ubmVjdGVkIHRvIHRoZSBzZXJ2ZXIgZGlyZWN0bHkgb3Ig
YSBCTUMgc2ltdWxhdGVkIGNvbnNvbGUgdGVybWluYWwsIHNvbWV0aW1lcyB0aGUgcHJldmlvdXMg
cHJpbnRzIHdpbGwgYmUgZmx1c2hlZCBvdXQgb2YgYnVmZmVyIG9mIHRoZSBzY3JlZW4gaWYgdGhl
cmUgYXJlIGEgbG90IG9mIGxvZ3MgdG8gYmUgcHJpbnRlZC4gVGhlcmUgaXMgZXZlbiBubyBzY3Jv
bGwgdXAvZG93biBjYW4gYmUgdXNlZCBsaWtlIHZpYSBTU0ggdnRlcm0uDQoNCkFmdGVyIHNvbWUg
aW50ZXJuYWwgZGlzY3Vzc2lvbiB3aXRoIG91ciBleHBlcnRzLCB3ZSB0aG91Z2h0IGl0IHdvdWxk
IGJlIGJldHRlciBub3Qgb25seSB0byBjaGFuZ2UgdGhlIFBBVEggYmxpbmRseS4NCkJ1dCB3ZSBj
YW4gZmlyc3RseSBjaGVjay90cnkgdG8gd3JpdGUgdG8gdGhlIGRlZmF1bHQgZml4ZWQgUEFUSCBh
cyB0b2RheS4gSWYgZmFpbGVkIGR1ZSB0byBubyBwZXJtaXNzaW9uL25vIHNwYWNlLCB0aGVuIHRy
eWluZyB0aGUgZmFsbGJhY2sgd2F5IHRvIHVzZSB0aGUgcnVudGltZV9kaXIoKSBpbnN0ZWFkLiBB
bmQgdGhlbiBub3RpZnkgdGhlIHVzZXIgd2l0aCBhIExPRyB0aGF0IHRoZSBmaWxlIGlzIHNhdmVk
IGludG8gW1BBVEggeHh4eF0uIFdEWVQ/DQoNCj4gQnJzLA0KPiBZYW5nIE1pbmcNCg==
