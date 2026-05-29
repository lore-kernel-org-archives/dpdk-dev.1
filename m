Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30D6CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 14:29:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C76F74021E;
	Fri, 29 May 2026 16:29:23 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18]) by mails.dpdk.org (Postfix) with ESMTP id 1C53B400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 16:29:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvUgsrLwgCLtsREN78QyWOHQS79XDAnHPrOz38iBjrAHu+BEtYOG2wDGYOp3y7BYXHhjSMEvx8vz3/AA5Aib2dJUOGSzng8oikJyoe4EHe+ujhhVzm8J4Uc1E932LWQ3fkhFxWC9gtHsfVJF01SnCyLGLc9T2qBrCgfL6tFP5qVhsFfvI08jbHMx0CzMg3xDI7Qpj+IJml+oBwbitZvQot36EwFX+U26YrUe1fiqjot9BUvUs0dfpHKz2vTNvI1Q0IbD9Ew5GV7DY0ZS1ZwC1tB2ZBCBfmybUsMdSFGi3d0+NJ/EfS3B8Goel7Cku9OrSItsbNAXwB/7MgATYyvDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9S5Gee7GEbYbUvpr0F2gyOeDR9ZxlWPqa05dDmEYLk=;
 b=l7aBxpxI/LwSQGtm5IhOGqBATvt8n7afnaM8upZWPYkN5Wn6+GYcZvUku9tal2Cb6/oRv5LZKmxtyhgmPKhBl1K3o1mKsobwEJLnIYZpcMOYqiVKKYjxA9x2WwIooS3fjEiF92eop55V6kKBssGzJigeoyWb7M+zTenihRbzkSN7w362XtvJnGg5/GbmJc5X4Q6UQMrmW0xOcFeMXu6p6JxhHDbvsvzFgsgyH8P6jy7SBQee6fU729dr9xvBN142p2u/U8soJ5OncpWf7p+j3vAezM1QMRojtlEUJR5KqQOzVZVXTYPaKYpcXCJtiUJ1/q3ohwfDNAhXuG/jIsTyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9S5Gee7GEbYbUvpr0F2gyOeDR9ZxlWPqa05dDmEYLk=;
 b=l1HtfH/ZxdZoQ+hIN4qNEmA60tl1KX/AwffXd7APUmOxKDoirv1SR2wvwIOc0fngQ33BmcBYoNSXbCrdUuMN2xGQHQ4ZLjeNWjRaMrGOLupDUJmEvHZMeirc6Ti5HgBv10DPnGW+bmZ8fVTAOv3LT0L2EZAovla35Tq0jMuYzpQ=
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.13; Fri, 29 May 2026 14:29:15 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::9441:ca06:5daf:ab56]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::9441:ca06:5daf:ab56%4]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 14:29:15 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Bruce
 Richardson <bruce.richardson@intel.com>, =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?=
 <hofors@lysator.liu.se>, "dev@dpdk.org" <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>, Yogaraj
 Baskaravel <yogaraj.baskaravel@ericsson.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: RE: [RFC v3 2/3] lib: add fastmem library
Thread-Topic: [RFC v3 2/3] lib: add fastmem library
Thread-Index: AQHc7f6g6z2rkNM78U2Gz4CwgnPilbYjJ/gAgABbP3CAAFQsUIABOzcw
Date: Fri, 29 May 2026 14:29:15 +0000
Message-ID: <DS0PR12MB6608B8FC500485D9A8BD743682162@DS0PR12MB6608.namprd12.prod.outlook.com>
References: <20260526085743.64396-4-hofors@lysator.liu.se>
 <20260527173042.93867-1-hofors@lysator.liu.se>
 <20260527173042.93867-3-hofors@lysator.liu.se>
 <98CBD80474FA8B44BF855DF32C47DC35F658AD@smartserver.smartshare.dk>
 <DS0PR12MB6608CB2B4897A5CB91D2D1C482092@DS0PR12MB6608.namprd12.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F658B3@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F658B3@smartserver.smartshare.dk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-29T14:29:08.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6608:EE_|DS7PR12MB6237:EE_
x-ms-office365-filtering-correlation-id: eba96912-905c-40f7-9b7c-08debd8ea950
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|6133799003|18002099003|4143699003|5023799004|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: IZ3Z9EL/mrnR6vJw+RZfcXXd5GO1tmFv8clL7zv5wHehfWz0OayF1fitbMB7tF9BOku2nnVCL1C35KD3DBKqd5XrdjsTro3IE3d/qw4lgwdVkeq3/pBFHmnqv2lvQbHqu/b7iOPskF4yHf75veFqpWYf+NOGLZf6JkJME2tQDXmu71gWx622ReUU83XREc5pQgLr8R6E2MwmfopfOWOQvvLIxXOqi464EWygl3ZjmExJs9zkIKfLWkcy3oIJMSdlyWmzooygs+Co5iiwuHyj8EzD8s+0nWnh4mPoZv2/DkJze2chuqUz0OfGrQPf0K/Co3tliK//gcgzzEB89UsIJyESrabmuMTbuOk4B4vAyVHe6lfZNWWAUgI4ze1jthbHrJ+e/VwN1f7PO/IDvrHS5bP0gJ2ibpIkipcurbJenicaNs2r7YJ6/3R4rYTdLUDzbXRItx/gs47PLTj1QVg0IgMlmzwsRPQKahUej/upBAJMkrJV7FMsiRCFX4PftTVqa6GkjNU0PLUWsHLQR30FDWobwS82THw1NZl/YCJPQd5CbjgknlUY3QYD2k8KeF61gEo4U6CQbebsCFg7Ig7UlMS8yZuoXXTMQ2kxpk01jQeYnhHpJgHW54A0raJ/sCvPSbMDwMezCKQK0TQw4skWtfWKf1wkfYLQ3gaJJp0gjojX1z6xra/dptI4PjGObYOXwOMzf+79/KY72B9p8fxFGzvKbbGm/4hV8qcJoF5eHNqFNigSI8EKTBstWyTd05bP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6608.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(6133799003)(18002099003)(4143699003)(5023799004)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmJnRUtMT2diL09wTUdXSnZvb1BYdTM0YS9YaW5qcWNDbG92WHdRM3dzT0dS?=
 =?utf-8?B?eEdRTVFWR1d6ZDMrSkM5L1h0dXFNVHEzVitwa3ZpcWFKTnhFVDJkRzBGYTA1?=
 =?utf-8?B?ZmRZdnhWTm84UjNTUlk5a0htL3o3dWxjZnpmc0VKeGloeThLU1FGOGNGbHVJ?=
 =?utf-8?B?U1gyRmtPT0ZWS1A5UWU5b2FGKytWRzlBcGZmNHJvQllRMWZHRE9iTVdhWEp5?=
 =?utf-8?B?SGh0T2FMRFJhNUN2RGVrNVM1VE4wbExpQjdhUUdWVFZOTURMN08zZk1wdmdV?=
 =?utf-8?B?S1psZ05BdFh3RjUzSkV2eXM4dTBGVFFGcnlqUWdTTjZwR2l1eHA3clJGWnJa?=
 =?utf-8?B?Yk9UclBuQ0JDWUNEVStjaUVGK2pqdzBxdGpxOWc5TEkrMjNoV2szS2RmdGd0?=
 =?utf-8?B?Rm9QY0JlV3pWQVN3WnZmdWQyMlNnclFObERPRjh0R0JUV2pmNy9RQzlrQy82?=
 =?utf-8?B?UTUrZTBnYkduTFZwdGhvYnk1bmszWWxZUFpxZVg3eU11aGs5bHM4MExZVG5V?=
 =?utf-8?B?Q1NqakJ1d2lCakoxMitxSmhlTmxGMWk0Y1VuckJMV3FQQk5QTFFCT1FLRHlX?=
 =?utf-8?B?eTQvWTZZTy9RRzBkR01KbVJhbmJGY1ZMMDJkNjBaVUU1SnQ4NDRhek82bmxK?=
 =?utf-8?B?NzRaaTNkM0txVGFzMEtBa2V4WXlQTG5xVHlDMUQ5VUlXWDZvSHQzOElLN2pw?=
 =?utf-8?B?ekJoaU5UMUxFazFpSDhVK1hxSnNScmxCOVlqTUVIQ1FjMHJvZlFVcDBkcDBU?=
 =?utf-8?B?MXM2SFA0Zjk4YjQ1ZXRBWFBPZVRMSEYrdkFKNTJnUEFnUTZ1dHFvTXhPc05W?=
 =?utf-8?B?UDJYSnRZWklmQ281SFBlVnBDZGNITHJGeHdHM2pnb25JNnoxS0ZsNEUyZ1FT?=
 =?utf-8?B?K1pEYTEyOUdnRTh4MXNDVzE5bWFqakI0aFpVMkhTaElRM0hML3VJM0JVWjdu?=
 =?utf-8?B?cFhsMm9ITmtLNVBmWWsvR2YxSXp6bU1MdXd3VEZsYVordHBqRmRid3RrelZJ?=
 =?utf-8?B?eE5BKzBRZkpYaEJ6Z084MmRrU2hFaGQxWERKMkVyWVBhR3NLZm9ZejVqL08x?=
 =?utf-8?B?RklDR0Iydy9naXY3ZmcyYnIzN2VEYWpFRVl5QUpzWEc3aDMwem9wTU5wSVZS?=
 =?utf-8?B?Q1ZGK1k5ZXJsUXpmeit0TnZUdVVzaTV6eFJsMm5wbHdRSU9vOTV1T3h1d010?=
 =?utf-8?B?N2tlWUkvdkdONkZYamExdHByRkI0S1BNVktuaUYxMG9XdGlMT1dtWnkwS0Rx?=
 =?utf-8?B?QVFMWStNd2NLbjlhbXdrOG4wbmdHdzk4TTdTWlhPei9TUmRpTUYzWk9oQk9w?=
 =?utf-8?B?cHJ6WWRqdTUzbjlXSldFRk12OWhnNHpoWDRvek9FdTJFcG1HeitRUXlEbU93?=
 =?utf-8?B?czhpRkIzTjcyYzFtSWx5a3hHWk1RVVhiUkpBOGlOZFI4Z1d6RnhaWjI2VHFk?=
 =?utf-8?B?eWw5Z0FPamI4Zi9laXJNR0RGMERMT3JHNjBQNW1IL2pvK3pjcUV6Z2FnT0hU?=
 =?utf-8?B?RkVrM05hU3E2ZjdvWUtiTDFsVE9ZMXd1b0hUYi9wVXBzeDVXeVI2cHFuYis1?=
 =?utf-8?B?a2lBT2xrbUw5bStYVTR5QTk4RlFGR1crL3k4cDBRZEFOUUZGNGYxNFpuNjg3?=
 =?utf-8?B?N2o1QnhJRGdocTBxL3hBQXpSdWkyOHZPbFpJU1BtNGNlZWtOVlY1ajRCVHda?=
 =?utf-8?B?dXRrNU5aSnhtK3lCaHZERWo4cWM2YkRlbTJNaW8vZVBXcVR1WHdmRko4cEUv?=
 =?utf-8?B?b0dKRTA1VjF0dWRRQWpTaHZJWFQwUkNhcEZlM0NabzJnaWl3RFdTYzJNVkow?=
 =?utf-8?B?L2NKdWN6clpaajNnRGRsWENFZkhDOGJZa0ZuS3lxTm8xc1pvR1cyRlZ6TW42?=
 =?utf-8?B?eHBSKytEM3cvL0NPL0p4ZXVsS0RkQXprMHRXWkhqUDQ3WnBGV1h4eURuVDhX?=
 =?utf-8?B?YjV3OUZuMVRXNWpUd0pucTU2dHJDalEzZ1VXck9ic3pHNUhWWkV4clFuSXkx?=
 =?utf-8?B?NUlEODBYamt6bFNyNlBtRnlXNDJQZk1ZdmhvUEV3eVBaM0orOWhjd3dmVTBo?=
 =?utf-8?B?WHZ2bEo0VVNBZG9YNVp1YVhGUlNvWGQzRGFlTnRSUCtWa09ZakptdXFHOHFi?=
 =?utf-8?B?WkdnM2YzaThIa2ZMc3NUWmw3MmV4cUFpYlhRN3hrNWRnL3RnN284dkVJallZ?=
 =?utf-8?B?bTZFU2cvYk5FaEFSTXNGQU1wSlZUTmgwTHF1MUpTTTJVbTBaVGlBUVcwT1pS?=
 =?utf-8?B?c0VDcnIrSTErMGU5TFBJK1Y5d1E3bDZiRXYweGhkR3JqSG5jM215bkMxczBu?=
 =?utf-8?Q?puuqcD/hRFoc81x8ra?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba96912-905c-40f7-9b7c-08debd8ea950
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 14:29:15.6689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ge3D+sAOAOQN9EjXn1HrEcPOyb7wgJmazsA5pAH9ncDru6cabdG/d3z0GDdCcih/pyx2UiWEPdknNSwcywNwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237
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

UHVibGljDQoNCjxzbmlwcGVkPg0KDQo+ID4gPg0KPiA+ID4gPiArLyoqDQo+ID4gPiA+ICsgKiBQ
cmUtcmVzZXJ2ZSBiYWNraW5nIG1lbW9yeS4NCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBFbnN1
cmVzIHRoYXQgYXQgbGVhc3QgQHAgc2l6ZSBieXRlcyBvZiBtZW16b25lLWJhY2tlZCBtZW1vcnkN
Cj4gPiBhcmUNCj4gPiA+ID4gKyAqIGF2YWlsYWJsZSB0byB0aGUgYWxsb2NhdG9yIG9uIEBwIHNv
Y2tldF9pZCwgcmVzZXJ2aW5nDQo+ID4gYWRkaXRpb25hbA0KPiA+ID4gPiArICogbWVtem9uZXMg
ZnJvbSBFQUwgYXMgbmVlZGVkIHRvIHJlYWNoIHRoYXQgdG90YWwuIFN1YnNlcXVlbnQNCj4gPiA+
ID4gKyAqIGFsbG9jYXRpb25zIHNlcnZlZCBmcm9tIHRoZSBwcmUtcmVzZXJ2ZWQgbWVtb3J5IGRv
IG5vdCBpbmN1cg0KPiA+ID4gPiArICogbWVtem9uZS1yZXNlcnZhdGlvbiBjb3N0Lg0KPiA+ID4g
PiArICoNCj4gPiA+ID4gKyAqIFRoZSByZXNlcnZhdGlvbiBpcyBjdW11bGF0aXZlOiByZXBlYXRl
ZCBjYWxscyB0bw0KPiA+ID4gPiArICogcnRlX2Zhc3RtZW1fcmVzZXJ2ZSgpIHdpdGggdGhlIHNh
bWUgQHAgc29ja2V0X2lkIGdyb3cgdGhlDQo+ID4gPiA+ICsgKiByZXNlcnZhdGlvbiBtb25vdG9u
aWNhbGx5LiBSZXNlcnZlZCBtZW1vcnkgaXMgbmV2ZXIgcmV0dXJuZWQNCj4gPiA+ID4gKyB0bw0K
PiA+ID4gPiArICogdGhlIHN5c3RlbSBkdXJpbmcgdGhlIGFsbG9jYXRvcidzIGxpZmV0aW1lLg0K
PiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIEEgdHlwaWNhbCB1c2UgaXMgdG8gY2FsbCBydGVfZmFz
dG1lbV9yZXNlcnZlKCkgb25jZSBhdA0KPiA+ID4gPiArICogYXBwbGljYXRpb24gc3RhcnR1cCwg
d2l0aCBhIHNpemUgY2hvc2VuIHRvIGNvdmVyIHRoZSBleHBlY3RlZA0KPiA+ID4gPiArICogc3Rl
YWR5LXN0YXRlIHdvcmtpbmcgc2V0LiBBbGxvY2F0aW9ucyBhbmQgZnJlZXMgZHVyaW5nDQo+ID4g
PiA+ICsgKiBzdGVhZHktc3RhdGUgb3BlcmF0aW9uIHRoZW4gYXZvaWQgbWVtem9uZSByZXNlcnZh
dGlvbnMNCj4gPiBlbnRpcmVseS4NCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBAcGFyYW0gc2l6
ZQ0KPiA+ID4gPiArICogIFRoZSBtaW5pbXVtIGFtb3VudCBvZiBiYWNraW5nIG1lbW9yeSwgaW4g
Ynl0ZXMsIHRvIG1ha2UNCj4gPiA+ID4gKyAqICBhdmFpbGFibGUgb24gQHAgc29ja2V0X2lkLiBU
aGUgYWxsb2NhdG9yIG1heSByZXNlcnZlIG1vcmUNCj4gPiA+ID4gKyB0aGFuDQo+ID4gPiA+ICsg
KiAgdGhlIHJlcXVlc3RlZCBhbW91bnQgZHVlIHRvIGludGVybmFsIHJvdW5kaW5nIChlLmcuLCB0
bw0KPiA+IG1lbXpvbmUNCj4gPiA+ID4gKyAqICBvciBibG9jayBncmFudWxhcml0eSkuDQo+ID4g
PiA+ICsgKg0KPiA+ID4gPiArICogQHBhcmFtIHNvY2tldF9pZA0KPiA+ID4gPiArICogIFRoZSBO
VU1BIHNvY2tldCBvbiB3aGljaCB0byByZXNlcnZlIG1lbW9yeSwgb3IgU09DS0VUX0lEX0FOWQ0K
PiA+ID4gPiArICogIHRvIGxlYXZlIHRoZSBjaG9pY2UgdG8gdGhlIGFsbG9jYXRvci4gV2l0aCBT
T0NLRVRfSURfQU5ZLCB0aGUNCj4gPiA+ID4gKyAqICBhbGxvY2F0b3Igc3RhcnRzIG9uIHRoZSBj
YWxsaW5nIGxjb3JlJ3Mgc29ja2V0IChvciB0aGUgZmlyc3QNCj4gPiA+ID4gKyAqICBjb25maWd1
cmVkIHNvY2tldCBpZiB0aGUgY2FsbGVyIGlzIG5vdCBib3VuZCB0byBvbmUpIGFuZA0KPiA+ID4g
PiArIGZhbGxzDQo+ID4gPiA+ICsgKiAgYmFjayB0byBvdGhlciBzb2NrZXRzIGlmIHRoZSBwcmVm
ZXJyZWQgc29ja2V0IGNhbm5vdCBzYXRpc2Z5DQo+ID4gPiA+ICsgKiAgdGhlIHJlc2VydmF0aW9u
Lg0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIEByZXR1cm4NCj4gPiA+ID4gKyAqICAtIDA6IFN1
Y2Nlc3MuDQo+ID4gPiA+ICsgKiAgLSAtRU5PTUVNOiBJbnN1ZmZpY2llbnQgaHVnZS1wYWdlIG1l
bW9yeSB0byBzYXRpc2Z5IHRoZQ0KPiA+IHJlcXVlc3QuDQo+ID4gPiA+ICsgKiAgLSAtRUlOVkFM
OiBJbnZhbGlkIEBwIHNvY2tldF9pZC4NCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiArX19ydGVfZXhw
ZXJpbWVudGFsDQo+ID4gPiA+ICtpbnQNCj4gPiA+ID4gK3J0ZV9mYXN0bWVtX3Jlc2VydmUoc2l6
ZV90IHNpemUsIGludCBzb2NrZXRfaWQpOw0KPiA+ID4NCj4gPiA+IEBCcnVjZSwNCj4gPiA+IEkg
dmFndWVseSByZWNhbGwgdGhhdCB3ZSBkaXNjdXNzZWQgc29tZXRoaW5nIGFib3V0IGJ1c3NlcyBh
bmQNCj4gPiA+IHNvY2tldHMNCj4gPiBhIGxvbmcgdGltZQ0KPiA+ID4gYWdvLCBidXQgSSBjYW5u
b3QgcmVtZW1iZXIgdGhlIGRldGFpbHMuDQo+ID4gPiBJcyBzb2NrZXRfaWQgdGhlIHJpZ2h0IHR5
cGUgKGFuZCBwYXJhbWV0ZXIgbmFtZSkgdG8gaWRlbnRpZnkgYQ0KPiA+ID4gbWVtb3J5DQo+ID4g
YnVzPw0KPiA+ID4NCj4gPiA+IEBWaXBpbiwNCj4gPiA+IFlvdSBoYXZlIGJlZW4gd29ya2luZyBv
biB0b3BvbG9neSBhd2FyZW5lc3MuIFNhbWUgcXVlc3Rpb24gdG8geW91Og0KPiA+ID4gSXMgc29j
a2V0X2lkIHRoZSByaWdodCB0eXBlIChhbmQgcGFyYW1ldGVyIG5hbWUpIHRvIGlkZW50aWZ5IGEN
Cj4gPiA+IG1lbW9yeQ0KPiA+IGJ1cz8NCj4gPg0KPiA+IFNob3J0IGFuc3dlcjogc29ja2V0X2lk
IGlzIG5vIGxvbmdlciBhIHByZWNpc2Ugb3Igc3VmZmljaWVudA0KPiA+IGFic3RyYWN0aW9uIHRv
IHJlcHJlc2VudCBhIG1lbW9yeSBidXMuDQo+ID4gQmFzZWQgb24gdGhlIHRvcG9sb2d5IHdvcmsg
d2l0aCBsaWJod2xvYywgd2XigJl2ZSBvYnNlcnZlZCB0aGUgZm9sbG93aW5nDQo+ID4gYWNyb3Nz
IEFtcGVyZSwgSW50ZWwsIGFuZCBBTUQgcGxhdGZvcm1zOg0KPiA+DQo+ID4gRmVhdHVyZXMgbGlr
ZSBTTkMgKFN1Yi1OVU1BIENsdXN0ZXJpbmcpIG9uIEludGVsIGFuZCBOUFMgKE5VTUEgUGVyDQo+
ID4gU29ja2V0KSBvbiBBTUQgY2hhbmdlIGhvdyBzb2NrZXRfaWQgbWFwcyB0byBoYXJkd2FyZS4N
Cj4gPiBJbiB0aGVzZSBtb2RlczoNCj4gPg0KPiA+IDEpIEEgc2luZ2xlIHBoeXNpY2FsIHNvY2tl
dCBjYW4gZXhwb3NlIG11bHRpcGxlIE5VTUEgZG9tYWlucy4NCj4gPiAyKVRoZXNlIE5VTUEgZG9t
YWlucyBhbGlnbiBtb3JlIGNsb3NlbHkgd2l0aCBtZW1vcnkgY29udHJvbGxlcg0KPiA+IGdyb3Vw
aW5ncyAoaS5lLiwgbWVtb3J5IGJ1c2VzKSByYXRoZXIgdGhhbiB0aGUgZnVsbCBzb2NrZXQuDQo+
ID4NCj4gPg0KPiA+IERlcGVuZGluZyBvbiB0aGUgYXJjaGl0ZWN0dXJlOg0KPiA+IGEpIE1lbW9y
eSBjb250cm9sbGVycyBtYXkgYmUgY29sbG9jYXRlZCB3aXRoIGNvbXB1dGUgY29yZXMgb3IgcGxh
Y2VkDQo+ID4gb24gc2VwYXJhdGUgdGlsZXMuDQo+ID4gYikgQXMgYSByZXN1bHQsIHNvY2tldF9p
ZCBjYW4gcmVwcmVzZW50IGRpZmZlcmVudCBzY29wZXMgKGZ1bGwgc29ja2V0DQo+ID4gdnMuIHN1
Yi1zb2NrZXQgZG9tYWlucyksIG1ha2luZyBpdCBpbmNvbnNpc3RlbnQuDQo+ID4NCj4gPg0KPiA+
DQo+ID4gSGVuY2UgcHJhY3RpY2FsbHk6IEluIHNvbWUgY29uZmlndXJhdGlvbnMsIHNvY2tldF9p
ZCDiiYggbWVtb3J5IGRvbWFpbi4NCj4gPiBJbiBvdGhlcnMsIGl0IGlzIGNvYXJzZXIgdGhhbiB0
aGUgYWN0dWFsIG1lbW9yeSBidXMgdG9wb2xvZ3kuDQo+ID4NCj4gPiBUbyBhZGRyZXNzIHRoaXMg
YW1iaWd1aXR5LCBpbiB0aGUgdG9wb2xvZ3kgcGF0Y2hlcyAodjUvdjYpLCB3ZSBhcmUNCj4gPiBt
b3ZpbmcgdG93YXJkIGNsZWFyZXIgc2VwYXJhdGlvbjoNCj4gPg0KPiA+IGEuIENhY2hlIGRvbWFp
bnMgKEwxL0wyL0wzL0w0KSBmb3IgY29tcHV0ZSBsb2NhbGl0eSBiLiBOVU1BIGRvbWFpbnMNCj4g
PiAobWVtb3J5ICsgSU8pIGFzIHRoZSB1bml0IGZvciBhbGxvY2F0aW9uIGxvY2FsaXR5DQo+ID4N
Cj4gPiBUaGlzIGRpcmVjdGlvbiBiZXR0ZXIgcmVmbGVjdHMgcmVhbCBoYXJkd2FyZSBhbmQgYXZv
aWRzIG92ZXJsb2FkaW5nDQo+ID4gc29ja2V0X2lkIHdpdGggbXVsdGlwbGUgbWVhbmluZ3MuDQo+
ID4NCj4gPiBIYXBweSB0byBhbGlnbiB0aGlzIHdpdGggdGhlIHRvcG9sb2d5IG1vZGVsIHdl4oCZ
cmUgaW50cm9kdWNpbmcgc28gdGhlDQo+ID4gYWJzdHJhY3Rpb24gcmVtYWlucyBjb25zaXN0ZW50
IGdvaW5nIGZvcndhcmQuDQo+ID4gVGhhbmtzLA0KPiA+IFZpcGluDQo+DQo+IFRoYW5rIHlvdSBm
b3IgdGhlIHF1aWNrIGFuZCBkZXRhaWxlZCByZXNwb25zZSwgVmlwaW4hDQo+DQo+IEkgaGF2ZW4n
dCBsb29rZWQgZGVlcGx5IGludG8gdGhlIHY1L3Y2IHRvcG9sb2d5IHBhdGNoZXMgeWV0IChpdCdz
IG9uIG15IFRPRE8gbGlzdCkuDQo+DQo+IFRoZSBydGVfZmFzdG1lbSBsaWJyYXJ5IGJ1aWxkcyBv
biB0b3Agb2YgdGhlIHJ0ZV9tZW16b25lIGxpYnJhcnkuDQo+DQo+IFNvLCBpZiB0aGUgcnRlX21l
bXpvbmUgbGlicmFyeSBpcyB1cGRhdGVkIHRvIHJlcGxhY2UgdGhlIG1lYW5pbmcgb2YgaXRzICJz
b2NrZXRfaWQiDQo+IHBhcmFtZXRlciB3aXRoIHNvbWUgTlVNQSBkb21haW4gaWRlbnRpZmllciAo
d2UgYmV0dGVyIHJlbmFtZSB0aGUgInNvY2tldF9pZCIgdG8gYQ0KPiBuZXcgbmFtZSAibnVtYV9k
b21haW5faWQiKSwgdGhlbiB0aGUgcnRlX2Zhc3RtZW0gbGlicmFyeSBjb3VsZCByZW1haW4NCj4g
dW5hZmZlY3RlZCwgYW5kIGl0cyAic29ja2V0X2lkIiBwYXJhbWV0ZXIgd291bGQgYmUgcGFzc2Vk
IG9uIGRpcmVjdGx5IHRvIHRoZQ0KPiBydGVfbWVtem9uZSBsaWJyYXJ5J3MgIm51bWFfZG9tYWlu
X2lkIj8NCg0KVmFsaWQgcG9pbnQsIEkgZmluaXNoaW5nIHRoZSBsYXN0IGNoYW5nZXMgZm9yIHY2
LiBXaWxsIGJlIHB1c2hpbmcgaXQgb3V0IGJ5IHdlZWtlbmQuDQorMSBjaGFuZ2luZyB0ZXJtaW5v
bG9neQ0KDQo+DQo+IFRoaXMgaXMgbXkgY29uY2x1c2lvbjogQXQgdGhpcyBwb2ludCwgcHJvcGVy
IHN1cHBvcnQgZm9yIGFsbG9jYXRpbmcgbWVtb3J5IGluIHNwZWNpZmljDQo+IE5VTUEgZG9tYWlu
cyBpcyBhbiBydGVfbWVtem9uZSBsaWJyYXJ5IGlzc3VlLCBhbmQgbm90aGluZyB0byB3b3JyeSBh
Ym91dCBmb3IgdGhlDQo+IHJ0ZV9mYXN0bWVtIGxpYnJhcnkgLSBpdCB3aWxsIGJlIGF1dG9tYXRp
Y2FsbHkgc3VwcG9ydGVkIGluIHJ0ZV9mYXN0bWVtIHdoZW4NCj4gc3VwcG9ydGVkIGJ5IHJ0ZV9t
ZW16b25lLg0KPg0KDQo=
