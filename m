Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE50CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 19:45:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A572C40609;
	Fri, 15 May 2026 21:45:11 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11020076.outbound.protection.outlook.com [52.101.46.76])
 by mails.dpdk.org (Postfix) with ESMTP id A760D402C1;
 Fri, 15 May 2026 21:45:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luBhkmOIX5Fp1VzHojpM9W9sTnzGpNvUiwR3f/dk4eCHGk4RsgA1AIjfSxU1ElAljRMBKx2OeVCWEYJbpGanVJxbj5F1ozwdBwZZGmWdUFG1B0VAAQ3Sx71rOs4y0nOLdGKEA/LBmkWrQCodToJ+lDG+emQYtw7DkwjzNiB+XcKYyEHw0VQIMFo9WN/sdbULjncyKyjCq7pwWEZfBNMCEd9YghB9uhdai1yjWsVtdOwrUS7c2KBFdkQLTl0x7usJUXbXD3HcIyPHJ+mCuS8amabD3kh/wDOuAqY+Aab9btJP3Egq10JYvaSLRUwQICj1dg9sKeRDepamb+yrOe6G1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHBLymM9JDWjx+g6CVfxp9yJSG/RER5aw6UvsS6Zd3U=;
 b=gu62k9HVDYoSM6m0npqqg1bElXmM1GJU2IMCN2oozDIErvOY/cZwE6cb3tDSbh9XpuG0I6ZdPEezMtfRHlkAVJJ+vDXI9G/4zuoLoYMx3PRzwzow6yCq5GD+KBcuNzYu18tvGYjAxsgO+NICiw3Nh1DhwqP0S+SdIfX7hpFVWGHuDTj1h5PVKoGoOLR1sWLEYFI2bkcq0WS0J+tdzmHNelXlvRPmGMsfVzRZac4YzkGm9JDT5E2MiGwKxEzsvHGcMaDB0QldtyEiRZdjNsF/J40r+b8G9eexiiiGrKA5ghTCttQCFwfvb2E32tA/Nc7oCtvt6IpZQeVzUFQFlQz8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHBLymM9JDWjx+g6CVfxp9yJSG/RER5aw6UvsS6Zd3U=;
 b=Yd84LR6J5BTrhgAg5RtZpROpq8Q4HIazFysIzovmXbAKkzcCtA5Z3JHD0U2fZvrYLS6eOwmXwvxzJ+qyiKEIEnUJlh8J0A1zlh6hEtg8QCrlPpuXMB8jkb5tB5MRxmvr/nLOjB7TlJB5knDTA9QUe5PihqydZTrrXgZ6PO2ZD2A=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB2034.namprd21.prod.outlook.com (2603:10b6:806:1b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.9; Fri, 15 May 2026
 19:45:07 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%6]) with mapi id 15.20.9891.008; Fri, 15 May 2026
 19:45:07 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/7] net/netvsc: retry VF hotplug
 indefinitely until PCI device disappears
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/7] net/netvsc: retry VF hotplug
 indefinitely until PCI device disappears
Thread-Index: AQHc3PzY4RQlJtvBzU62DKqLAlYo4LYB3lwAgA2uNgA=
Date: Fri, 15 May 2026 19:45:07 +0000
Message-ID: <SA1PR21MB66832CC9C7CB7CF2A34437B0CE042@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260506020529.281654-1-longli@microsoft.com>
 <20260506194948.2508fa6b@phoenix.local>
In-Reply-To: <20260506194948.2508fa6b@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dd0e8c2d-3f1e-4156-a825-959670cbd48f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-15T19:44:42Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB2034:EE_
x-ms-office365-filtering-correlation-id: 9281f12c-d87f-42c0-f085-08deb2ba7780
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|4143699003|11063799003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: ZY/4s0Q0ZzX4NliyqUBFiPVc4p2q/DCW7lo17RU6pgeD4sqsK/9DuZBlkqQIOZvx4gA+U+2FGPZnPzEORvIgejYUbLipX3MU695Y8kImbrEVFzrlqutlwLRZYbODA7mbozJknr4kqLi0/mUDoUEuh+E6bSDDHfbAAmrcrz/xDvtssi8uFzmODFsb0xiQL5GpaJGPzzvKfWBdc80N29rNTdFEDQN2gG+4Y2OLb/8vHavGym6q2CNsATlEu2LwDLmndtLBNzb/ryCBRSTs5gOJAcCOKhBXor7nfO3f2+ImKsB2BdR2iYwCZMpybrAm2L9iF/2twjAcpZTUi0RFv0Su38soXVhxp8wSCoBliHyIlX4LGCFT1ba9oKM02rpA9t6UrxWKcQSjg21zUOZCf3boEGDwlg0rvHIbF5vu/TvqtrYmyTSEjtfKDI3NCaZia1dtuWT3O0QGUtKPkWJ2QoGEnxCO/RDq+lcC35lk/VX17ozLcxk7p8L6QGd893qM1MmDgYV49cVwQA8PHx6iThLl2PjvkMFLC1ry5J83HknKZC6x7CgQZpW/OctOwcK/y9BOZr6kdUKgWO8YWzFLaic3IcsIWuORMwrhF+/8JobiheUKZBSHEWcyPI07AWAFTDaGq8ROtOFVqJ82LV6/vGd1aCpCPFoAzlO3Noq9D0+uVq7EFqbTU+2lN0c26Ya8j1jF8dggJS54EsJSGJBz1MEkWEFbAqBunh7lfs4UdSzXoV7urtSmUBybSLORpUgyxzAW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(4143699003)(11063799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUh6Q25CMDlwWWR2bFNRQlZsWUlwdjViblpyeHFYSDYvUGNJRjZ3RXhDMVly?=
 =?utf-8?B?UWFDLzkvaGpLRGtGTHBBZjdkdHJ2MDhyenVaa0NoOTY5Znc4UjBiMExSUnZN?=
 =?utf-8?B?MTUzbGJkQTRtaEYrOXc4ZTQ3b0pvbUtuWUIza29KTU5rWXVNWXBpNXlJbTAw?=
 =?utf-8?B?VGttdEtGckNiM1BpTldsb1p3eTNJd0JDd0FrT2FPS1N0SXMwQmdGMXQvWHZS?=
 =?utf-8?B?NzhBWjhLN0IyV0VDUSsrS0hKNXFmZ09Vd1ZUTDVicEsxTGdJM1ZVWkowNDA1?=
 =?utf-8?B?R2ZYa01Ta0x4K3NVZnBabXJUOStPdDV2WTlmN0RSbllKbS9WSDdVdFRSYUNH?=
 =?utf-8?B?N3d3Snc0RzVNZXIrdFVjVXFFdEhEUnFhRlMrVnFOTFZtVkhvbnhxWklDMEIz?=
 =?utf-8?B?YlByandwUzBpQlUzSnRBRkVDQVBZd0Z5VTIyeTN2NkNQeUlCTktWV3hSWXNo?=
 =?utf-8?B?ZklobGVZRitvOW5OeGtIT3RTYVBGRW13WDJPT2dkSXp5b052ZVYyK3VDRStC?=
 =?utf-8?B?aVROVVlWT0lEK3JXdVdLZ0s0VmhnRy9Xdm1uT1ptZTkreUhJak9CQWIwb09O?=
 =?utf-8?B?Wkdid0JlVlBicUcxWndOcHZiWGlKRGtXYmU5UWFja1BrMHF5QVNmenJuSDR1?=
 =?utf-8?B?M2NKZnNnZ1VYZTk1Sm9hdEdmZUFqODdDaVZ5UnFCNkFXTGV4RTF3RDlnaFgw?=
 =?utf-8?B?ZFp1ekdSWVkrMFZQakZBQ05oTHpDc1RxRmFWOTN5cFJ5dlBRSUovRjczRzNL?=
 =?utf-8?B?SU91cFRkKzFlbWhWcU81TXYrMGQvM1ZoSkVCc1J5SmVGS1I3czBTYjE3Mkxp?=
 =?utf-8?B?VDB5ZGp2U2dLdEhxcnpiV1Rhcm5weUVYOWdOTW1Cc0Q3YUROR2RiNGwzQUR2?=
 =?utf-8?B?NHBtOGhSVnhUcDloNEJOcmNTZ1dJZGtRNWZ6NmdjcjRqNFlweTdqZTFKODEz?=
 =?utf-8?B?aUo0SnE1VkhMSzBvbmlrbXFrMDNnc2UydTV4WnFKMDhlQXlZNmFpR0RmRUo3?=
 =?utf-8?B?SzV5Q3d2dERENWE2VDJ4eVNKcEtDdGE4N0pJeERsSFBuNnFlOFhYUXB3VlRh?=
 =?utf-8?B?c3VXYmhtTU1EakxxMlVpMVNkc003amFPWlRYeTFxbGtyd2RtTElQWnovR3Nz?=
 =?utf-8?B?cy9SWmZnYkJIYUoyVU1YWjI2YmJNaWVEQ3NQeXZQQmJWTWZXRmRSYWFKMnRP?=
 =?utf-8?B?Yit3bFZpdkZqZ3NObWgzTUlxMXF4ZGpkaUxWa3l0RmFiM0duZlRUK044cUhL?=
 =?utf-8?B?ZXNmaTBEdWl6UjIvRGdrU3FEd2ZTcmpDdndnSEhYUGFaZlNaYkxWcjJ4aGhC?=
 =?utf-8?B?bzdCaXIvNDZMQkRQcTdOS0JoNm5mcThSZzAvWUVEdVp1V1ZnU0g4MHVkVkkw?=
 =?utf-8?B?Vmluc3NvMEZoTy9KSFlXOUQyckdubkJtR2hET1FYLy95SXdkeDhheGRBcmlt?=
 =?utf-8?B?Yi9LV2ZVOWE0Wm9EWFRPbExjLzNTZHhNTUx6Vk03MEo3eFVGY0tuZDM0K1FP?=
 =?utf-8?B?ZXM0SStzeWUwSkFWU2R1MEc2ZVpneW0rY2dkYlNnV2piWU5UelhBZnA0K3ZB?=
 =?utf-8?B?QTlaS0l4cCt6VEpMTU9wcU1ld0xwczQrdXFydk14S1Zhb3ArTlMyNXl1cmcz?=
 =?utf-8?B?MU5jZWlqbjJkSmZUUHlMUys5V3I4WU9HdjhOM0dkVElKL3QvVUZHbE9WblQ2?=
 =?utf-8?B?bUFvTFMvU1FNWjlvZ1ZtbmkwRkp6WGdaY0IvMmJQeitHNDdqMFZmUzhqVWdD?=
 =?utf-8?B?bjZTRDBKV0YyM3BJeXljV0RQY1dvWlpTd2phSjN4TUFJVzQ0SVZacjlxa0tM?=
 =?utf-8?B?dEdRUWYyRGI4SHlXK1kxTXl4VVNrVDZRU3lHUjhCRnEwTHo3Z3I0MEFBa3lm?=
 =?utf-8?B?OGRoM3NzbkdtMHdJY0RwemRNdGRHYTNwRGc0VzZpbnNGSHljZmJjRk1NejVU?=
 =?utf-8?B?WkhxN01GaHlHcFNQcGl6MnlmMVFNNW1oTEd1WXQ5WDRycFgvcWdja1NlZmR0?=
 =?utf-8?B?WkFyL2hFZVZrMmxaWEhaVmc3NytYczU3d0VUbjFXS3dZZTFNdVo0alpDUFcw?=
 =?utf-8?B?Z0VBZTlQOHNFZzR6Zld4d1I2RWhvaWUzL0txQ1dOdFp0K0RTSElveHhrVzB3?=
 =?utf-8?B?OHlERjV3TGtURFY1NHQvcFZ4WFZYVWltVDJtNkhFMnROeFBBR2JSanJFUjZw?=
 =?utf-8?B?TjRTLzczcXVGaUQvbExwWDdubkhSbzRCb3gxRFhIOC9UMVhoU09MRlg2Vm5u?=
 =?utf-8?B?U1A2UkdLUEF0aTFNTU9hcThLWHpKNU9YWmRoVzNYOFoyd3lNQWNTWjZZOUIr?=
 =?utf-8?Q?BQ1gC4iqeVoBR38v35?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9281f12c-d87f-42c0-f085-08deb2ba7780
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 19:45:07.1667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CF0sAv7OiKwbxgcIKLBieEpl7/4nMomJZg+fFRxq+QNGIfQBHqnzO5RFk5H4kPKH6ADafFiH6apnDCXeHiG4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2034
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBIZW1taW5n
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSA2
LCAyMDI2IDc6NTAgUE0NCj4gVG86IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KPiBD
YzogZGV2QGRwZGsub3JnOyBXZWkgSHUgPHdlaEBtaWNyb3NvZnQuY29tPjsgc3RhYmxlQGRwZGsu
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2MiAxLzddIG5ldC9uZXR2c2M6
IHJldHJ5IFZGIGhvdHBsdWcgaW5kZWZpbml0ZWx5DQo+IHVudGlsIFBDSSBkZXZpY2UgZGlzYXBw
ZWFycw0KPiANCj4gT24gVHVlLCAgNSBNYXkgMjAyNiAxOTowNToyMiAtMDcwMA0KPiBMb25nIExp
IDxsb25nbGlAbWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+IA0KPiA+IEFmdGVyIFBDSSByZXNjYW4g
b24gQXp1cmUsIHRoZSBNQU5BIGtlcm5lbCBkcml2ZXIgY2FuIHRha2Ugb3ZlciAxMDANCj4gPiBz
ZWNvbmRzIHRvIHByb2JlIGFuZCBjcmVhdGUgdGhlIC9zeXMvYnVzL3BjaS9kZXZpY2VzLzxkZXY+
L25ldCBkaXJlY3RvcnkuDQo+ID4gVGhlIHByZXZpb3VzIGZpeGVkIHJldHJ5IGxpbWl0IChORVRW
U0NfTUFYX0hPVEFERF9SRVRSWT0xMCwgfjEyDQo+ID4gc2Vjb25kcykgd2FzIGluc3VmZmljaWVu
dCwgY2F1c2luZyBWRiByZS1hdHRhY2ggdG8gZmFpbCB3aXRoICdGYWlsZWQNCj4gPiB0byBwYXJz
ZSBQQ0kgZGV2aWNlJyBvbiBzeXN0ZW1zIHdpdGggc2xvdyBNQU5BIGRyaXZlciBpbml0aWFsaXph
dGlvbi4NCj4gPg0KPiA+IFJlcGxhY2UgdGhlIGZpeGVkIHJldHJ5IGxpbWl0IHdpdGggYW4gaW5k
ZWZpbml0ZSByZXRyeSB0aGF0IG9ubHkgZ2l2ZXMNCj4gPiB1cCB3aGVuIHRoZSBQQ0kgZGV2aWNl
IGl0c2VsZiBkaXNhcHBlYXJzIGZyb20gc3lzZnMuIFRoaXMgaXMgc2FmZSBiZWNhdXNlOg0KPiA+
DQo+ID4gLSBUaGUgcmV0cnkgdXNlcyBydGVfZWFsX2FsYXJtIGNhbGxiYWNrcyB3aGljaCBhcmUg
c2VyaWFsaXplZCBvbiB0aGUgRUFMDQo+ID4gICBpbnRlcnJ1cHQgdGhyZWFkLCBwcmV2ZW50aW5n
IHJhY2VzIHdpdGggVkYgcmVtb3ZlIG9yIGRldmljZSBjbG9zZSBwYXRocy4NCj4gPiAtIERldmlj
ZSBjbG9zZSAoZXRoX2huX2Rldl91bmluaXQpIGV4cGxpY2l0bHkgY2FuY2VscyBhbGwgcGVuZGlu
ZyBob3RwbHVnDQo+ID4gICBhbGFybXMgdmlhIHJ0ZV9lYWxfYWxhcm1fY2FuY2VsIGFuZCBmcmVl
cyB0aGUgY29udGV4dC4NCj4gPiAtIElmIHRoZSBQQ0kgZGV2aWNlIGlzIHJlbW92ZWQgd2hpbGUg
cmV0cnlpbmcsIGFjY2VzcygpIGRldGVjdHMgdGhlDQo+ID4gICBtaXNzaW5nIHN5c2ZzIHBhdGgg
YW5kIHN0b3BzIGltbWVkaWF0ZWx5Lg0KPiA+DQo+ID4gQSBwZXJpb2RpYyBOT1RJQ0UgbG9nIGV2
ZXJ5IDMwIHJldHJpZXMgKH4zMHMpIHByb3ZpZGVzIHZpc2liaWxpdHkgaW50bw0KPiA+IGxvbmcg
d2FpdHMgd2l0aG91dCBmbG9vZGluZyB0aGUgbG9nIGF0IERFQlVHIGxldmVsLg0KPiA+DQo+ID4g
Rml4ZXM6IGEyYTIzYTc5NGIzYSAoIm5ldC9uZXR2c2M6IHN1cHBvcnQgVkYgZGV2aWNlIGhvdCBh
ZGQvcmVtb3ZlIikNCj4gPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+ID4gU2lnbmVkLW9mZi1ieTog
TG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+IEJldHRlciBidXQgc3Rp
bGwgc2VlaW5nIEFJIHJldmlldyB3YXJuaW5ncy4NCg0KSSBoYXZlIHNlbnQgdjMuDQoNClRoYW5r
cywNCkxvbmcNCg0KPiANCj4gUmV2aWV3ZWQgdGhlIHYyIDctcGF0Y2ggc2VyaWVzIGFnYWluc3Qg
dXBzdHJlYW0gZHJpdmVycy9uZXQvbmV0dnNjLy4gUGF0Y2hlcyAxLA0KPiAyLCAzLCBhbmQgNSBh
cmUgY2xlYW4uIEZpbmRpbmdzIG9uIHRoZSByZXN0Og0KPiBQYXRjaCA0IOKAlCB0aGUgbmV3ICJy
ZXRyeSBsb29wIGV4aXRpbmciIE5PVElDRSBmaXJlcyBvbiBldmVyeSB0ZXJtaW5hdGlvbg0KPiBp
bmNsdWRpbmcgdGhlIHN1Y2Nlc3MgcGF0aCwgcHJvZHVjaW5nIGEgbm9pc2UgYWxlcnQgb24gZXZl
cnkgc3VjY2Vzc2Z1bCBWRiByZS0NCj4gYXR0YWNoLg0KPiBQYXRjaCA2IOKAlCB0d28gd2Fybmlu
Z3M6IChhKSByZWFjaGluZyBkaXJlY3RseSBpbnRvIHZmX2Rldi0+ZGV2X29wcy0+c3RhdHNfZ2V0
DQo+IHdvcmtzIG9ubHkgYmVjYXVzZSBldGhfc3RhdHNfcXN0YXRzX2dldCgpIGFscmVhZHkgbWVt
c2V0IHRoZSBidWZmZXJzIGJlZm9yZQ0KPiBpbnZva2luZyBuZXR2c2MncyBjYWxsYmFjaywgYW4g
dW5kb2N1bWVudGVkIGRlcGVuZGVuY3kgb24gdGhlIGNhbGxlcjsgKGIpIHRoZQ0KPiBlbHNlIGZh
bGxiYWNrIHRvIHJ0ZV9ldGhfc3RhdHNfZ2V0KCkgaXMgZGVhZCBjb2RlIOKAlCBpdCByZXR1cm5z
IC1FTk9UU1VQIGZvciB0aGUNCj4gc2FtZSByZWFzb24gYXMgdGhlIGRpcmVjdCBjYWxsLg0KPiBQ
YXRjaCA3IOKAlCB0aGUgcmVjb3ZlcmluZyBhbmQgcmVjb3Zlcnlfc3VjY2VzcyBjYWxsYmFja3Mg
YWNxdWlyZSB2Zl9sb2NrIGRpcmVjdGx5DQo+IGZyb20gZXZlbnQtY2FsbGJhY2sgY29udGV4dCwg
ZGVwYXJ0aW5nIGZyb20gdGhlIGV4aXN0aW5nIElOVFJfUk1WIHBhdHRlcm4gdGhhdA0KPiBkZWZl
cnMgd29yayB2aWEgcnRlX2VhbF9hbGFybV9zZXQgcHJlY2lzZWx5IHRvIGF2b2lkIGNyb3NzLWRy
aXZlciBsb2NrLW9yZGVyDQo+IGFzc3VtcHRpb25zLiBUaGUgdW5sb2NrZWQgdmZfYXR0YWNoZWQg
cmVhZCBpbiByZWNvdmVyeV9mYWlsZWQgaXMgYSBiZW5pZ24gcmFjZQ0KPiB0aGF0IGNhbiBiZSBz
aW1wbGlmaWVkIGJ5IGRyb3BwaW5nIHRoZSBndWFyZC4NCg==
