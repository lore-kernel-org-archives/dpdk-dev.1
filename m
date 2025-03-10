Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEC9C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 06:48:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0297F4021F;
	Mon, 10 Mar 2025 07:48:12 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by mails.dpdk.org (Postfix) with ESMTP id CB9CB40151
 for <dev@dpdk.org>; Mon, 10 Mar 2025 07:48:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrwTPp3F7ihjZSk++409WkHEqD+USt32PMP4GG8bzFCHbgkodwhogB9F5Y/KEIPeAdsu51XEKKnu/XekcOlSWRKs8qzHK3Dfdzble/LYZi3eYpDbYlXSny45XNQxtwtw0lMBZNDa9cdIHb/CNeXxWlAJYW7OC9j3PqSpq1luO6ABsMuIw+LXZNOg5ZkBZSW7d5o1FawSfibqA76TIvPG+amXREbQUTPz63FH6U2CBo6PXj8bpWVt2VAOq5iF67mvMlbHFBJOAhEOIJhm3NG5GlXIsZ/2BJ2r+jbl0PkwE5jusoO3XhTlJvOWmNskenktzdOi40kNNVtg4CLwNOCqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1t10s3PxfoX0up6/zVAeYU7/9NfuOTkwbiVRd7qfl8=;
 b=XSeaX+5ZjfuSoZReDKcub80iTFR7G+W90HomokMT/f3rkvg8uX4+fECaBL8JXA2mturg9jJka6NFr/O2goC2yqoshwl/A3FCvhLAqGacSi3WXekIsnYMUNSAHAjBEnjEjiYe5lFihgmwARjwhrYF5awyuqR4IS9N0JvNrAEmevxCy+1DD+9j1Qu8Crg00vGat4zN1nVgPcuNjsqmCFv5vb9EeG6KXnSzPVgIzKjWoFKwp293H0PlRNIkqUSWfFWwITfpLAEHFeBsDjjKQLW3GjNmDdXKWgKJAmSJpxLb4s6c+ZDWj6exudVFjMDatJg+QGy9wh8f8WvEGV2xDVH/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1t10s3PxfoX0up6/zVAeYU7/9NfuOTkwbiVRd7qfl8=;
 b=QBpxR2rItOwIc+nCVjDRlKlQ48Sq+0PtmAec/6ueuC+fwg8i0Yl3rWWQ7RKOO50gucr7qQG7qvez35sWMQC+W8kC4i2mmIVAAdJYFPC8UGiJXtb8Pvxf1MUN5yT2IROhGeXwltT0q6jTtR+GbBXfYS6uoEt7vCyUqpj3vtpY/Jk5UeBGnLuymWaTir4Cd65hlhXyqwKfdhjx/BGYJOZ9VFTiQ7VDrJxdGVcvKc/4shpRFgcEAQSo5Ryt29c5rwXSPlhcMeJjImcR5MG13dBk4B8mWo0TSDl9rgI1V/YWPeUaqAhmEkn4zJyLQYuwcGtFR7HZ2A/FXajhXhLVlmS3nw==
Received: from SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 06:48:07 +0000
Received: from SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784]) by SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784%4]) with mapi id 15.20.8511.017; Mon, 10 Mar 2025
 06:48:07 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "ferruh.yigit@amd.com"
 <ferruh.yigit@amd.com>, Ori Kam <orika@nvidia.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: RE: [PATCH] examples/flow_filtering: fix destination IP mask
Thread-Topic: [PATCH] examples/flow_filtering: fix destination IP mask
Thread-Index: AQHbZMbkDmLe+4TDkUy4ewpKhS1T9LNO+c2AgB1NB4A=
Date: Mon, 10 Mar 2025 06:48:07 +0000
Message-ID: <SA1PR12MB9491739955B431A33FB2EFC7BFD62@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20250112075200.5020-1-shperetz@nvidia.com>
 <24267002.EfDdHjke4D@thomas>
In-Reply-To: <24267002.EfDdHjke4D@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB9491:EE_|PH0PR12MB5631:EE_
x-ms-office365-filtering-correlation-id: 3ebea1f7-6648-46bf-4f0d-08dd5f9f83c8
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aXVoU3VxR3BBRjRjdm5XWFZHbXdPVXlSNzdPSTV5QlBqem1IMldpWXRnR3VU?=
 =?utf-8?B?aGZWdWtGUjZHVVRVa0hkcTV1MlpxNGZvN1dJcmNVNHhlOTVqNlhNSmFpSkVX?=
 =?utf-8?B?WW5GN2hXY3pjdUtGMzgzQW9mT2tkWXlZMVhqOWZpTnhFL3cyUWdyNzVQRHVr?=
 =?utf-8?B?aHRlbVM1Um1jZzZGZmU4UmJCTFR3YzIyVDU3VlMwcUQranZxR3BzYU0yV2lN?=
 =?utf-8?B?QnlteVRQVFlrWGEzWm5pa3o5UGlBRUhmTVBsa3YwMkhEVzNQV3FSK2FsUXl2?=
 =?utf-8?B?TUhsUUt1d21qeTMveVNzTkJ1MlYwSHk5dTFHWjZ1NDRlMUwvK3djYnI5aFo4?=
 =?utf-8?B?U0F4MHRsSkRrOGx2OURwN0x4YTVQU3pXRFhPVnJramZUWmNiVXVCQmZUNHNw?=
 =?utf-8?B?U2tqN0lhLzdzNHMrZm1sdU1HekZEQUJDbVZWUWVBL1orRHh1Q3k1MHgxTERu?=
 =?utf-8?B?V01OQXI3b25GdFJzUmhVQjRoWmxleE5mZlN4ZllWbFU1Zm95Y2RQYnFvd1dX?=
 =?utf-8?B?M0MxcU1od0pmaGxqQVJ4WlZ0Zk83QXBKRDRLZndSaW44RkhkY2djV2cxdXRy?=
 =?utf-8?B?Z2NvYTIxZjRYR3h3Qi83QW5IeGhZUE5qWG91eEVrZzVmZlRCRGdTY1orTFVO?=
 =?utf-8?B?bWZoNnBjYTkzS3A2dGdPZzZQS0lSUGdIbG1VV1ZWWFdKUEFZbGVtWXFDbmhP?=
 =?utf-8?B?ZDdITkVycDBzL3NseGdBWWFmL2gwR1A5cjVLMGdOOEY3OWdpZ3JtZWZvZ202?=
 =?utf-8?B?OWsxWXc1VWQ4THdtUi9GZDB5NlpkUUZ2bW1GWGcvMlFrdlNwWDI1K0txVTMx?=
 =?utf-8?B?MjFYT3kyTDFUM0FWTjZCV2xNMWRYZm5GL2VIalNhZ05MUjFaM2NiYkpQdG9Y?=
 =?utf-8?B?R3Z5WW03bG5NMno4ZWhyS2o4cWlUOGtNTUFvLythVVlpTmtGa2twNGVIaEow?=
 =?utf-8?B?YUpJcFdxck05YmtFbmFWRXBXR1g4ZjhocSs0anc5YUQ3YXBQN0h0QWpobHBu?=
 =?utf-8?B?Uks3MVNCTEdpbEo1Y3Z6UW1HdXJna0NBMjEvUUFtdWpQNyt3bGFhSnpGeUhQ?=
 =?utf-8?B?NHd3djZzc1pLVUYvNTFpbTRPeGhZTDZzczlhNjNWT3U0Ny9acWxNOWxUcGpi?=
 =?utf-8?B?c0J2T2w2VTJadnp4enI2ZlJNVlNNZ1EzeTNReEo5cnQxbkRaRFFaMUc3TkZs?=
 =?utf-8?B?VjdoZVlmbFFjT1QwSTlqWFUvUGJBbi9UTndlT1ZFT0UrOFEzcXlySnBZcWgx?=
 =?utf-8?B?VFNCeHNieDlMeVZhdTRtNzlUZ2toWVEyNS9yOUQ0c2NVTmZpSXJ2dFNDeDl0?=
 =?utf-8?B?ZjgreHp5aS94aUQ2ZWlLNlFpSGxkRkRNT3BWZ0kwMFJWMlYzdXhjYW85MmVo?=
 =?utf-8?B?REFOV3pVTDBqR055eW91cGpvTWVyZlh4Q01MaU1ocUJnOFR5dWxKTy9pQlJ4?=
 =?utf-8?B?Q0JadjRzaDlkNmwvdTNHT0k0ZXc5UjJrQUtkOXlTdWdZN2VuSnZUM2gwL01z?=
 =?utf-8?B?U2lwRVFSNDRvaDE5RFRzR3dOc0NqdjlsYTZ2QUc2NzJ6OWRNSmhNVnlxL1J0?=
 =?utf-8?B?M0JlV1VlTEozWC9za2JQZDliaytGWmQxT3pJSmJhS2JhYnU3TmVaT1NCNG5S?=
 =?utf-8?B?NTdicnJQMjl4d3RIMzhmcXl6WkJEeGQ0NDlHbCtjWEw1Tk82SG1aY09aZ01z?=
 =?utf-8?B?UkNvRFJTNXRzTzNuQXNob2pzbE5OWjBxWjF3bUJxWEpDZ2hVdWhuZFRKN2tT?=
 =?utf-8?B?TXpPYkxRQ2dNR3psQ05LQ0tLeU1SeS8vQzN5SkkzbVAyUnhYb1I2Y3FYTVpY?=
 =?utf-8?B?TTJEck1FZzluck9URDNEUmFpOVRFSXhoRkg2NUkvTk5aZnQvcEVSaWRzeldY?=
 =?utf-8?B?VURCQ3JiYlFDYVlPc1ExbStQdHo0TmlkUFJuM0Y3U2d0dDdnMGtRVFRzV3JN?=
 =?utf-8?Q?UfBvHb5z7TvZ+mhBDV1izogPgucOB12l?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB9491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlU3a0x5dDZkTWU0YmdCdHRvV1c1cnliQ0FGZDhIQkRkbUQ4YWNLL2g4K29F?=
 =?utf-8?B?WThyUmF4b2xaa1k3cWE5RlZGWTlWand2L296WkZvTm03dFVnd28ySG5vbVpm?=
 =?utf-8?B?eEkrY3NvOERENVRGNG9FeExlZkZTSXRVSVdTMEpEQ0JJRkRUNXJVOFRUR3FD?=
 =?utf-8?B?WDV0Z2pBT213SnMwUnMwYnhMOTRYTlZ5eFRZUEU3cE1ubnNzOFRsMWt3dEN1?=
 =?utf-8?B?TVFTREUyQ3BsbmJwc0xaTERGZzI2OWVLejIvU3U0Mmw4UWtTYlQ5bnNway8r?=
 =?utf-8?B?YUpPWGZKblIxa1RNbW56dW9WOWMwWDdSd2dKM05SZHhVOE9hYXZPMkdRODJz?=
 =?utf-8?B?WGcva2NkdlY1dDBrRGhJenN5ZlBRSDZ6UlNjbWtxRkJtMFVZR0pMSVJ2MHBR?=
 =?utf-8?B?THFIR0pFQmswL0lVVGhHRTVYRVovb0RhRDBLMmZFalc3RngwbmEyRksvT2s2?=
 =?utf-8?B?dXZ2ZkMzelk2L1IvMC9QUldqelZFazUyb1Z1eWZ0bnNDK0RGV1N6VnF5R0JM?=
 =?utf-8?B?eHpwS3k1N2VxQmk0MzdiL0pJS1NGVVZ6ZENzcWhTdnpXYUJoS0FqUDgycG00?=
 =?utf-8?B?UUtaM2Y2Z0VRelhSYldFZXFwVzFoS2s4UzBZTTdyRzdEK2s5NFpsbll3MzU2?=
 =?utf-8?B?VVRXRU5TSlB4WkZoNHFKMGUxYUFsQlJDakM4UzNqenpiTUh5TFJ1OVQxS2dn?=
 =?utf-8?B?OGREU0FnODdSWTF3UFhzRmZzMDdQVFo2RUg5RmxNdHhWRXVnZEF4Nm55TXZC?=
 =?utf-8?B?bVgyZUovZGFyanNwaE1GNk5Zc2w0MWVUWDZydVFDeGRkbzRoaWhUOGxYdE4x?=
 =?utf-8?B?cUpRMU8vTVRqU2ZQaTJ2ci9FemRYK3RtUGxZMkZ6NHBWRnp5Z0lkL1F0SWJl?=
 =?utf-8?B?VlovSWxtalYreXFvTDhXL0ZEOGM1ZWtUZTZrLzVyNTZQK0luakJuRkxIdFNX?=
 =?utf-8?B?WE1WZktwc3NJUHNLRURQSkVmd1JCZElvSzQ3M0k5Z255SkdGQWFVbjVSS3hZ?=
 =?utf-8?B?dXIyaHQwR1JBTkJ0aUlhUDkxRmJNb1oweGR4ellTSVFyeWJDVWdlSnBvMk5C?=
 =?utf-8?B?emsvRXYzbUxPN1drdnBYYmF4dkNhNWNKWm1XU296aDFNNHEvRG83M2k3ZEh3?=
 =?utf-8?B?YnhUWW14NE9GQno4c0dPVk5DSDQ1WXQ4YmRkWWNYL2hLeTdVaFpmcHR1MDV2?=
 =?utf-8?B?RWpKME9KK3lrVldOZE9ySVI4c1k1czJ2enVkTDZCd055b0JGMXJlVy9RbVQ0?=
 =?utf-8?B?UjJ4L21YOTFQczNROW1naXJLT0hOa2R1M2I0WVBENU1welM3N3I1elNQQjc2?=
 =?utf-8?B?alUzY2lBamlRSU1nNUZjQ2R1eEJETCtWZkoxTmhMRThrdGdLVnhUVVdFeXF1?=
 =?utf-8?B?NWo5eE9NYk5JdjFUMGFlelpHMXZSaks5VTlXU1NhN1hoaFZJdlBEOGtyM2sw?=
 =?utf-8?B?U2JDbGJ1NFoxNnIvQU00M25hb21vdTZMaWU3Y0RrRkVWQVB4Q29YZjdRNnJC?=
 =?utf-8?B?UjU3UlNKWTVMeDRHZGM3c1NpNytDdmRDZ3RocGRTL0YxVGswWHlGcUhmNWxn?=
 =?utf-8?B?L1ZtR1J4b0d0dkdxU3BmZCs4UzB0RzI2YU1QdjlqOFZMbytkNHUxTXBENy82?=
 =?utf-8?B?b2pWNVl5VUNFSElzbzd6Q3ZJNTRFdG1pR2VaU3NtSzlUV3RWUUVjd0ZjVGs4?=
 =?utf-8?B?Tlp0SkhwVXVza0crWHhPc0hIY3dqYWxiZUliWjZXM0huRHQ4Vyt3YVZmNHd4?=
 =?utf-8?B?RXFKYUIrSWhzK21VRjlMcmg0dkxnQTkxa1VTS25CaFdhWS96RXVFQ0puanJO?=
 =?utf-8?B?bzdMSnc3MHdWZ2NLaW52ajVXZStlOVhkd1I0eEFPVldsaEFuSERIeFJWd2c5?=
 =?utf-8?B?dGlaUHhJSktmWFRWMkttWkpnRVRzVXBJWkk4K2lKT2JSWnlwTGx4dThldkJR?=
 =?utf-8?B?emxZSXlZcm5FVW1EUzY0NVpYSHdKeUpxNC90cldSRzNxdmExL2dsQXoya1B3?=
 =?utf-8?B?anJEeWtwNXVia2ltOW1pd0tVUXlZcFJacmd2ZGQ5NGtWZUx4SGNBVWtBaXRi?=
 =?utf-8?B?MVREeTZXUFJYUW8wZEwrRnZLZmFTWnFmWXVzN0F5ODdpRVNVTU9oeTk2cE5H?=
 =?utf-8?Q?QX27hDdBOUYI2g7P9vuAwcc9M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebea1f7-6648-46bf-4f0d-08dd5f9f83c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 06:48:07.1429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhGfaiFtzKbO9SDFbqDjhe2HQk9yefUBHnSORMy2zAc/mOGFHvD3Gv9OSvBM3lqONdVumHRl6AY+pNkufVaE5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIE1vbmphbG9u
IDx0aG9tYXNAbW9uamFsb24ubmV0Pg0KPiBTZW50OiBXZWRuZXNkYXksIDE5IEZlYnJ1YXJ5IDIw
MjUgMTc6MjANCj4gVG86IFNoYW5pIFBlcmV0eiA8c2hwZXJldHpAbnZpZGlhLmNvbT4NCj4gQ2M6
IGRldkBkcGRrLm9yZzsgZmVycnVoLnlpZ2l0QGFtZC5jb207IE9yaSBLYW0gPG9yaWthQG52aWRp
YS5jb20+Ow0KPiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGV4YW1wbGVzL2Zsb3dfZmlsdGVyaW5nOiBmaXggZGVz
dGluYXRpb24gSVAgbWFzaw0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5p
bmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiAxMi8wMS8yMDI1IDA4OjUyLCBTaGFu
aSBQZXJldHo6DQo+ID4gVGhpcyBwYXRjaCBjb3JyZWN0cyB0aGUgZGVzdGluYXRpb24gSVAgYWRk
cmVzcyBtYXNrIHRvIHJlc3RvcmUgdGhlDQo+ID4gcHJldmlvdXMgaW1wbGVtZW50YXRpb24ncyBi
ZWhhdmlvci4NCj4gPg0KPiA+IEFsc28gaXQgZml4ZXMgYSBtaXN1c2Ugb2YgcnRlX2Zsb3dfaXRl
bV90Y3Agc3RydWN0Lg0KPiA+IFJlcGxhY2UgaXQgd2l0aCB0aGUgYXBwcm9wcmlhdGUgcnRlX2Zs
b3dfaXRlbV9pcHY0IHN0cnVjdCwgYXMgdGhlIGNvZGUNCj4gPiBpbiB0aGlzIGNvbnRleHQgZmls
dGVycyBpcHY0IHRyYWZmaWMuDQo+ID4NCj4gPiBGaXhlczogMTYxNThmMzQ5MDAwICgiZXhhbXBs
ZXMvZmxvd19maWx0ZXJpbmc6IGludHJvZHVjZSB1c2UgY2FzZXMNCj4gPiBzbmlwcGV0cyIpDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFuaSBQZXJldHogPHNocGVyZXR6QG52aWRpYS5jb20+
DQo+IFsuLi5dDQo+ID4gQEAgLTc3LDcgKzc3LDcgQEAgc25pcHBldF9pcHY0X2Zsb3dfY3JlYXRl
X2FjdGlvbnNfdGVtcGxhdGUodWludDE2X3QNCj4gcG9ydF9pZCwgc3RydWN0IHJ0ZV9mbG93X2Vy
cm8NCj4gPiAgICAgICB9Ow0KPiA+DQo+ID4gICAgICAgdGFjdGlvbnNbMF0udHlwZSA9IFJURV9G
TE9XX0FDVElPTl9UWVBFX1FVRVVFOw0KPiA+IC0gICAgIHRhY3Rpb25zWzBdLnR5cGUgPSBSVEVf
RkxPV19BQ1RJT05fVFlQRV9FTkQ7DQo+ID4gKyAgICAgdGFjdGlvbnNbMV0udHlwZSA9IFJURV9G
TE9XX0FDVElPTl9UWVBFX0VORDsNCj4gDQo+IEl0IGlzIGEgcmV2ZXJ0IG9mIHRoaXMgcmVjZW50
IGNvbW1pdDoNCj4gaHR0cHM6Ly9naXQuZHBkay5vcmcvZHBkay9jb21taXQvP2lkPTdkNzNmYTQ3
ZjQNCj4gDQo+IERvIHlvdSBjb25maXJtIHlvdSB3YW50IHRvIGtlZXAgUlRFX0ZMT1dfQUNUSU9O
X1RZUEVfUVVFVUUgaGVyZT8NCj4gDQoNClllcyB0byBiZSBjb25zaXN0ZW50IHdpdGggdGhlIG5v
bi10ZW1wbGF0ZSBBUEkuDQoNCg0K
