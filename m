Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C92CA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 06:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8867940280;
	Thu,  4 Sep 2025 08:50:22 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11020127.outbound.protection.outlook.com [52.101.61.127])
 by mails.dpdk.org (Postfix) with ESMTP id A12C940281
 for <dev@dpdk.org>; Wed,  3 Sep 2025 17:09:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtyK+n+wKyirv2l7ltXPuEvjgyvPlOmSccH6eJO01viqrDuZwIpWosrsUmKy7uM/eh376k5pn8u5E8MCnUslQ8KXv+AfXlEb4nz3MbxZN86urU6Tf7hQvOY7/ebLki2fBiUgkJ4pdlf07LoIWXLGLwhh0ZoiVC3YSJjZ4qaPqiwo7wG4dMytsTGnnxcdrG/MJoDUWGlLsFvwMVtLyKkGWcD7lRumMbTMa+sT5bwfqepHolsXk4QFD0Z3xEknLCdBriAjPmdtx1SrEb4ixtJWMUXaNaube3a+AhIYxrcj+x4uek266dEbLk6KK/cKWkVccc7FFvfJqYbvEMx5hSZ6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpL8JvXielhHkDNZDYcHb6fG7xcq3CTVm/14+9rSifE=;
 b=oEj0eKA0kGOmGST0JgMK1am5hkqeoH73kmV2fxhnYnQbTYGmv50zkWwA+DjlKyZDK6Q1eL8+upPgFqlHktqdefh5wMSX3Zi6QfymmYadNFnaNS7s4dY52ohG1ABLaeojbITkzQh/2WpdTgfaOK2T819nBpdI/Be1WoMq9kFtu7XWKn7QEmm5YcHwK7JLPmTVCtc6zNgSvUdIEIetP+AI+dg5QYB6Afx2dHxwdNNKQVX6PPTku10IRiWez2gKJevInG7C7oBk6MIslTEtbqUfO0SMbGIqvqYzWfAu5+78g9Zr3mNrDAUKszBMIndakWssAFecu8xInW1+7jawo6ONeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpL8JvXielhHkDNZDYcHb6fG7xcq3CTVm/14+9rSifE=;
 b=gFjtn4ufTMl54G7iVqcmrdtO7UUCIpgxrpnJiPYupcpte4Na7t0QpHiPraN80QS0b3LmPdkJB3wPd/KZ8QU/ajAndKRfwGMMLZ0etD7C0F7crtYAZVzj26cnRgDq/qyMjtG/YE4SmJh5daxHRSk/ipDnAS7Frv3OfjrarCCkvm4=
Received: from IA4PR21MB5409.namprd21.prod.outlook.com (2603:10b6:208:55b::18)
 by MN0PR21MB3218.namprd21.prod.outlook.com (2603:10b6:208:37b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Wed, 3 Sep
 2025 15:09:45 +0000
Received: from IA4PR21MB5409.namprd21.prod.outlook.com
 ([fe80::6a5f:c2d0:7b1:f57]) by IA4PR21MB5409.namprd21.prod.outlook.com
 ([fe80::6a5f:c2d0:7b1:f57%4]) with mapi id 15.20.9094.011; Wed, 3 Sep 2025
 15:09:45 +0000
From: "Matthew McGovern (LINUX)" <Matthew.Mcgovern@microsoft.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH] examples/symmetric_mp: log/ignore
 promiscuous fail
Thread-Topic: [EXTERNAL] Re: [PATCH] examples/symmetric_mp: log/ignore
 promiscuous fail
Thread-Index: AQHbybY+tw1RB1Nt1ESQrZ6J+TFKcbQqKG+AgFgMS0A=
Date: Wed, 3 Sep 2025 15:09:44 +0000
Message-ID: <IA4PR21MB54098AB9BBC8C4CAEE51148B9001A@IA4PR21MB5409.namprd21.prod.outlook.com>
References: <1747766224-31511-1-git-send-email-mamcgove@microsoft.com>
 <8729787.zIJbB62Pao@thomas>
In-Reply-To: <8729787.zIJbB62Pao@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d01f6e42-22e1-4296-b540-e950b68ba48c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-03T15:04:42Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR21MB5409:EE_|MN0PR21MB3218:EE_
x-ms-office365-filtering-correlation-id: 1315073e-1c9a-4fea-9c2e-08ddeafbea99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Y3dxNXBjRjJmdXkveHBaNjV2R1VmQ3JydjBtK2VuVjlNd0RVVE9qM0JYY29u?=
 =?utf-8?B?UzBYcExYbnF6TkxOMVcrU2laa2g1U3VBbFJlZ1AxNUV6VVp1NmNTeDlFNGZn?=
 =?utf-8?B?aHhiaFM2RHMzZU05bklEWk5BSnI4ZS8xVGVxNm9Xa1Y1czFoVDN5SGUxelkv?=
 =?utf-8?B?elY3cEVVdWkxT1JnbGZMMzVsUVNneU42SmxSSHZHNFVLenlUUjRjYlVjelFK?=
 =?utf-8?B?d1E5eHVTVi9hZDBaaHhSdlhwL2Zxcjk1MXlKYks4eFpJcTlYWHd2NDhVazRk?=
 =?utf-8?B?N2owZ3BDL1NoSmRKZlBmUk4rVlphUktMTVJHandhOFZDRW1kZE00d0FXeHRD?=
 =?utf-8?B?dFlTUGR5b1hxU3VuSUF6U04xS3diM1V6RnFVR3VQZ2hPdkdLUk4zdXZldXFM?=
 =?utf-8?B?em9ocGh2K3p6VFpqaFhaZU90R053aXhWQzhKRG92bEY5ZHFEemRIczBJVHQz?=
 =?utf-8?B?cVVBUmV0VyszWVhETSt6a0R1bjc0Vzc3K3NEbDF0bEVGZ3Y0SWhsTXNCMmp2?=
 =?utf-8?B?SVVSaVM4L1pZUk85Q2E5M2NqY0ZybW9zWmJhUzdxdnNSbnhGUEtmY1pxcjJM?=
 =?utf-8?B?SU1wRUFtUFZtSEhYNW94WHljSzcxU3dLbnRsYUtOYmIyYklydEN5L2lDQW16?=
 =?utf-8?B?d2czRGd3V0Z3OGNPeTdqMzdoOVU2VkhRQmZqaXM2NWd2bnp4akwyQVZVOUhp?=
 =?utf-8?B?RXZnZGJZNUdHOEVOcUE0ZzZMa0pwbjJhbnlhcVJxM09qb0pvdmJEdkYwbm5N?=
 =?utf-8?B?NXdNVUdCZ2UwWUdwUVd3L2ZqTGNEeDNkUEJQdXpSaEtuRjVWbzljSWdGdmgx?=
 =?utf-8?B?cWlzU3pmYjB0bnVrUFJWcXBqQWVDVXowRWtxaHJ1VC9oU3l1M0t5ZUFsb1h2?=
 =?utf-8?B?Qi9lMkJraC9Rd1lFVW1Nb2VwclRnajlyZ2dyRmY3K2pPeVcrU0xZT0J6eGp5?=
 =?utf-8?B?Uk4vNitBNTFJSi9ONVZLMHpiNHJTN0lXakJjRzAwYlV3VEtZNzdybGlTaWVH?=
 =?utf-8?B?WEIxVzNWbXFwQmZpUEFzK2ZnSngrVWpCM1NyQW5BZGVmU0RsQWhSc0pnZnl3?=
 =?utf-8?B?dzZvdllDSDIvckxqakJ0alVuWU94VXVXV2pTRUFjZkozOG8rMjk2ZnNMVXB2?=
 =?utf-8?B?bDYrOTRyZmZWM3hiaUVPUXA0WlNDeFB4S2pIRkwzL1VicWd3QUZqYy9ockZT?=
 =?utf-8?B?VGtLbW13cC80UGVaWWVpL2pTZ2hnbFZzdEdoVEpnOVFUdjgwdExnQ0lKcmlt?=
 =?utf-8?B?NFRuMDdwalR4U01rT0pHUXBiQUg0S1RyMFJ1WjJCYlJTd2dlYVRkYVNnajdz?=
 =?utf-8?B?RUVHWXpHdXVSWG1hcTIvdDlhb2g2SVEza0N1UDlHcDlIemF5aFhBaGxvbGFl?=
 =?utf-8?B?ZVJnV3BrTWJQdzRNL2U1bjlBUG90QnNiSkZrYnI3Z21PbE5ZekE2ZzM2bEdj?=
 =?utf-8?B?V2UrRy9kSjlmU2hmYlpDcllrMnVoWDNjVEJIb0FqY0pkcm5vY054dnMrQkN0?=
 =?utf-8?B?NE12Wmt4eHk2b3BLYWs0TGRaTjNnK3JWQXpjdmlabTQ3MEYvaU9hYUhXd0t1?=
 =?utf-8?B?dmU0aERtTVhSYlpRNFBIVENaRzlUbUxWWitzSXFOSytyTkRtb01NTFVBd3Uy?=
 =?utf-8?B?VnFOYk9uZTBKaE15ZUNOcThuLzlJMHo2eDd2bmdzanlDY1ZRdytid3hnaExD?=
 =?utf-8?B?MVcyeDc3UDhkcEpTVlhib0EwdjdQVmRtTjc0S0hYaEYvc3hyMit6VDg0aWpp?=
 =?utf-8?B?czg1L1N1UUV0TTkrejgzTXNxQVN0NkxEMW8vZzJpZzl3MzdBU0Zvb3RYU3JE?=
 =?utf-8?B?ZW9EbWlXaVZjR1o2aDdaa1VuMWFXdVdobWJheGVLUWR3N0x4Z2tiTkRCdUNM?=
 =?utf-8?B?Y1VzTlhyYlM2WjB5WCtVMXNPQmkrRE5oVUlKOWtZbXFBN2NmU3Y2VjRsemh1?=
 =?utf-8?B?RkhkNkZqT2dyYXpFOGpJZG41OGlrd1lCckdVK2VyVUd6RGdsbXQyeDYrRGZB?=
 =?utf-8?B?bXFCK2Y4N1FBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR21MB5409.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SCtoYjNINnlhS0VhMGovbTBPN2o3VnJIUWx5TURSZ0VsUm5zdDg2S2g0Umo5?=
 =?utf-8?B?V3B3OFU4SUI3Q0ppb0syZ1Q3RGZGeFR5eGxIdk5wMXEvZWVnQlBpcWQ3Szk1?=
 =?utf-8?B?VEFEd1dhY0ZESFNJYUlKOWRvRnJtZXdWaXZqWkhLYjBXSldqRlg5VFJZTW9j?=
 =?utf-8?B?UVJ4YnlKWnB0dWNPZ0xIa3RRL1ppRkZVWUxnTmMzUXJGRnozRVQzUHlrQSt6?=
 =?utf-8?B?TEVxdDFnYW0rdFpMQVVrQkRtbTRNWXFXMTk4aG5RamNWWjZaU2crMUpTTUVB?=
 =?utf-8?B?Q0RTVGN5KzhKUVdpNG5WZlI1anZSK1V3KzRFMWl0MWRHaWtOLzBwRE45Q2p6?=
 =?utf-8?B?VDUvRkhBNkJ2eUlmNGJqMlRyaXdNT3BaZ1ZRREt0Rzl4K3ZadEZ6WmtwRjUw?=
 =?utf-8?B?Z0hVYVcvNEZNd050UDU0d2NlQWp0d0lPM25nM0tPc1NCY01ObDh1ejRuRUpN?=
 =?utf-8?B?VWJMSVUwa091aFFiN0xpR2hZMnJVVWZaK09nTHREREhhbytIckh6MzE2RWxp?=
 =?utf-8?B?ejYwV1U1ak9EZE1BVG5Mb2x0T0NUejVwdnNxRjkyRnNxZUpHRHpDWVNvcWxI?=
 =?utf-8?B?cmZSWENTN1V6VW1Pd2NCdTIvTFVEVVM3THNmWXAya3lhcDB0T2hORmd4emtS?=
 =?utf-8?B?djJJeWNzd1R6VFZSbW9WWDNtU2xVdDNSUUhHSTJMcFgzL2d4TXQzMTM4QTR0?=
 =?utf-8?B?MUt5K25lRFJ3U2R2SEY3VkNrRjV3Z2NQdktGNE4yY01KbllJT3NOOTF3czk0?=
 =?utf-8?B?cjZyd05ibFV0Mkp3aFcwREorT05aVithSWd0Z0NzUWl1WmNYdWI4WEVSMWhL?=
 =?utf-8?B?SERIc0M5U2FOUzBLc0thRHdqNFdDS3JmK2UzT2sxdDBOUkpFd2tJQytKaUpi?=
 =?utf-8?B?d1U5UGtveVV5UWE2aXMraFhha01GNmR3MGZhYXkzZndVekNvUFdsKzc4V2R2?=
 =?utf-8?B?aVY2MGk3dkZ0eGZFeDhrcTZzTkFhRnIwMi9RbTloNDJ4VmJ5WDd3Z3lYWjBG?=
 =?utf-8?B?ZjhBMlAzUWdjQlErQ3VHTlBrMzlLVVpLRFVXSVBCZXJ0ZEkveHRmRzh6Z1RT?=
 =?utf-8?B?cGtTQWp4RUFCcHB5MTQ5L1QrL0N4RW0xTndSaUgxSFNpRnNJQWZ0ek5KL2Ro?=
 =?utf-8?B?MmxwRVpnVkdkSHJwc0tDVTR4dmNPQUp1cnRJWGhLRnNEbTRqVC9uUXk5UEov?=
 =?utf-8?B?aVZiK3A3Z3RaV2hxaE93Z0E3c3JQQWM4RXVZSDhLSTJ1VjNCQ0trTk1Pa2Yw?=
 =?utf-8?B?dUl0TkVYS25nZnNNUzJvUVduSFNOT2QxeTMyeWVGQW1TcTJxUDJxaHR6bExr?=
 =?utf-8?B?ZGNKZzJWNU5YV2FabS9zR05ncmNRTy9VWHRUcFdFM0l0RVNWa1I3bFRiTkdm?=
 =?utf-8?B?aTlKZlVzQnlVTGdCcEtQYkFoN080R1pLc0diclJVRnI3UVZnUXpmcDh6WXZZ?=
 =?utf-8?B?Zy9hdUxoaVM1YlFPWVJTQlVYSFV0SGNkVlNQS3BKdXlOV3E2TGtGd3hSWGoy?=
 =?utf-8?B?RGlWSm9LSzlXNHVCVkZXclFPd2g0RVBxTFJOUUo0Z2hhMDZUajl0MFNHbjhD?=
 =?utf-8?B?T0FDOEtsK0hEVzhPRHRUeDcxZTBUSlUzODZwSW1tUmdmblRxQWtocjg5RndV?=
 =?utf-8?B?R1hJcStERXlIcGZSaTlvWUtVUmVMUFlvaVNBcFZpUmpNVGcvUzZxOXJRU2gx?=
 =?utf-8?B?elEvcGVXdVBtVlVBVVg3UGNtM1FSZmNUYW84RWsySlZvYzdwdWU1ZEFUdEpT?=
 =?utf-8?B?b3VVYlJaTWRsaDZCVlplTTQxRjVkT295WnFueEloRXhYWnhtTE1xUnZXR1cw?=
 =?utf-8?B?R2hoVHVpbXRHa1MzN3p4aTFpbmVzelNONENXTGo5WGR6djlIYU11aFRJa2ty?=
 =?utf-8?B?RnVONVJrMXBSUkFobFRHK01teVNDZGpnaUppamNBb0ZyU0JwRkJCWFNlbmdJ?=
 =?utf-8?B?RTRld3oybFJwTFp6ajNRUm4yYzdLSGlUaGc2VEJQU1RzQXI4WEI2K1M5R1Ar?=
 =?utf-8?B?T2YzOXJZRjY3OExMZSsrNnk0ME1xR0Vtc1JpZjlSVUJuYW1rY1lZcTUxNkNU?=
 =?utf-8?B?VWNROXBoNmlrRGJWaG51ZTdEMmVDZXE3bk5uMUdXMmZPU0pLcnAxclJaZUZU?=
 =?utf-8?B?Rm5VVTNHOWJYRjNtRTZCM3grVld5UjJHKzIxcWN4MjdIcUFSYndZYUhvcGtY?=
 =?utf-8?Q?7S+sPAWR+bUJYCM3d4+Xpx7ZyRttVT+xHNYgo/UtYD0Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR21MB5409.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1315073e-1c9a-4fea-9c2e-08ddeafbea99
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 15:09:44.9534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6HNSHUimmiERva+eNc0yOVvHiIQDlyJV3z/pGGrLqhQmmkNYaPjcrmj/PpaTcHrY0up0nXdJMq1EbXr7vftcjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3218
X-Mailman-Approved-At: Thu, 04 Sep 2025 08:50:21 +0200
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

Tm8gcmVhc29uIG90aGVyIHRoYW4gdG8ga2VlcCB0aGUgcGF0Y2ggc21hbGwuIEknbGwgYWRkIHNv
bWUgYWRkaXRpb25hbCBwYXRjaGVzIGZvciB0aGUgb3RoZXIgYXBwcy4gDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBUaG9tYXMgTW9uamFsb24gPHRob21hc0Btb25qYWxvbi5u
ZXQ+IA0KU2VudDogV2VkbmVzZGF5LCBKdWx5IDksIDIwMjUgNzozMCBBTQ0KVG86IE1hdHRoZXcg
TWNHb3Zlcm4gKExJTlVYKSA8TWF0dGhldy5NY2dvdmVybkBtaWNyb3NvZnQuY29tPg0KQ2M6IEFu
YXRvbHkgQnVyYWtvdiA8YW5hdG9seS5idXJha292QGludGVsLmNvbT47IGRldkBkcGRrLm9yZw0K
U3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIXSBleGFtcGxlcy9zeW1tZXRyaWNfbXA6IGxv
Zy9pZ25vcmUgcHJvbWlzY3VvdXMgZmFpbA0KDQoyMC8wNS8yMDI1IDIwOjM3LCBtYW1jZ292ZUBt
aWNyb3NvZnQuY29tOg0KPiBGcm9tOiBNYXR0aGV3IEcgTWNHb3Zlcm4gPG1hbWNnb3ZlQG1pY3Jv
c29mdC5jb20+DQo+IA0KPiBUaGUgZXhhbXBsZSBhcHBzIGhhdmUgYSBmZXcgZGlmZmVyZW50IGZh
aWx1cmUgbW9kZXMgd2hlbiBlbmFibGluZyBwcm9taXNjdW91cyBtb2RlOg0KPiANCj4gLSB0ZXN0
cG1kIHdpbGwgd2FybiBhYm91dCB0aGUgZmFpbHVyZSBhbmQgY29udGludWUuDQo+IA0KPiAtIGwz
ZndkIGhhcyBhIGZsYWcgJy1QJyB0byBleHBsaWNpdGx5IHJlcXVpcmUgcHJvbWlzY3VvdXMgbW9k
ZS4NCj4gDQo+IC0gc3ltbWV0cmljX21wIHdpbGwgZXhpdCB3aXRoIGFuIGVycm9yIGNvZGUNCj4g
DQo+IFRoaXMgcGF0Y2ggY2hhbmdlcyBzeW1tZXRyaWNfbXAgdG8gd2FybiBhbmQgY29udGludWUu
DQoNCldoeSBub3QgZG9pbmcgdGhlIHNhbWUgaW4gZXhhbXBsZXMvbXVsdGlfcHJvY2Vzcy9jbGll
bnRfc2VydmVyX21wL21wX3NlcnZlci8gPw0KV2hhdCBhYm91dCBvdGhlciBleGFtcGxlcz8NCg0K
DQo=
