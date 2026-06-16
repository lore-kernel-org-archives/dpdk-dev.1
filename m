Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEA8CD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 08:11:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD9BF40298;
	Tue, 16 Jun 2026 10:11:56 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023143.outbound.protection.outlook.com
 [40.107.44.143]) by mails.dpdk.org (Postfix) with ESMTP id 8AD9640289
 for <dev@dpdk.org>; Tue, 16 Jun 2026 10:11:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7zdZNAgS2q1A3g/6HveOb3pICK7aOSuPEAypulNpF0r+HuOpwuSfOKGMg+bu15FsxiIEtGxEhXJ9M7xDiNw0tbq8T2ZD+u3ppsX2PNEClZ83Re0B7vHSkVyOLD3axI4OpA7U7ApL+yQIwOguE6EpRAJn39Qfxw0XwCA+kSd9QOaT2ir+BAyZ2BlKw3TBHg8YMBYfTeESrkJEP01SPy5ctuNoBowxD1tMsdVjlR3yefKQy0Tt2K0lgAJ1BLRk+uJzxU02lhUoQNgJI9IMGBUqa9Qmjz3DDdYGTlKkYp/mLrnJnHN/Ry+oxLR31aUlWtoWEZnZ1GEVsISMvKlUsn++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=8HtAwZNFIqrlNt5OiStGgL0sE+iGv3yDO4HP34riZpk=;
 b=pA2cEQqzW1djQay/voy+XYaXd3BwPgKa9XpL4zOIVmMcrD0qMMRxlhopMP5svhLHvaz81N9bfoDGWAjEhzEhPiEwjnKroIjW7GgNX2Iz5qxWIQlY6lrhSfY10vsu4SswTBnHB9/1JWdyBrscJ01GjGm28IVvuhckjSo/o9P+j71WbkRjR2fyVl0GVSWVtQA6LA5pq7+ja/fj9m2ADJz/xkKHGRyPRUTK2M21Pd5elTZ4StuNrGdoBnCARoLyh9R0btHIjf3e+FsDLiadiEhLTu+NDH0wU8EEVF1fYgxKpq51nE0EAtAVLo+oiqB4Ulh3Z1XlCXDc7R5J9sABU9pL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HtAwZNFIqrlNt5OiStGgL0sE+iGv3yDO4HP34riZpk=;
 b=Wle6a/7lzMttZVvoJM+9Ci33lGrRiHU6+UxQmplWBoys8qwmfAjeDj/0/t1S4jixQDuNH6rTLFmyuuNqPcD9U6jb5e0Rz1fGFEvIdhdxTRqnQVcAgsOOddOJOsgbsEHkLKaY3NBoE9n/TqwoNW37QOBqAAZG2xs8w7EJagbmuus=
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::5)
 by TY8P153MB2304.APCP153.PROD.OUTLOOK.COM (2603:1096:405:3ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.2; Tue, 16 Jun
 2026 08:11:51 +0000
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e]) by SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e%4]) with mapi id 15.21.0159.000; Tue, 16 Jun 2026
 08:11:51 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu
 <weh@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH v9 0/1] net/mana: add device reset support
Thread-Topic: [EXTERNAL] Re: [PATCH v9 0/1] net/mana: add device reset support
Thread-Index: AQHc+kPwd6xh7WS+10GRo80cdbrsLbY/+yIAgADflFA=
Date: Tue, 16 Jun 2026 08:11:50 +0000
Message-ID: <SE3P153MB184821AB647B3A559254FA8EBBE52@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20260612081723.27699-1-weh@linux.microsoft.com>
 <20260615115028.5fa705c3@phoenix.local>
In-Reply-To: <20260615115028.5fa705c3@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5ae02fb4-071e-4eb8-96bc-04bab98fc17c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-16T08:10:40Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3P153MB1848:EE_|TY8P153MB2304:EE_
x-ms-office365-filtering-correlation-id: 40f29e9c-6a6d-42d1-3943-08decb7eeb39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|42112799006|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: URu8DBb3xOky84/hkCfzkPuWoHdyF6LetyYaJLe+gK4eoygiK+ttDMSL0cwl6THoFPgFDwXe9iQh5GpnSufAtGXrOiHqiBqZKFo1XuL6eFm1Amgh7OmsemVgjSkoAR1UvCqeXf+d1PE7YuRJFbl5HGKoBuRtPaYhbiTQ99P7xchtjcoNBQ1pqRZObYm4b+1mNdMzzx2IA5eibS2K/dxtX3PtE6FQsWLTyXD5GNAcYgg464q//zoTc9tNuAGwTbpDff3bfwyh06LToYLCn75Hh2u8yjDzmVxIbmNfUiFP3M6uN27GQiwGmKrJz035nu7ivKVJQXIyv8hy0xCyF3MjiZkvog3BCj2EDTaiY9pf65RZL2gfAXvKYUu3dNhIovGeFJFmohMScOI82UspyUNK0rMYgXl12yj12jNH4iSi7mODSQT8lH6zeaFBVz+HgcBvWEagY1hYOpHIuUTGWJNGOWgVkgjB8BSgIaVo3ueLaXQ4+z7h5ZAqPO17Kyv7defQMNQeDOnMIuUbHB5ETJ8ZdQoVeeec/VyFNZqpMFB89KNzkxYQydpAQEX8rOZj4L18BqH/VWI8cJ0fNn1PREsWXh440kqV5MTVTgfsUKV9ay/Scw/+eQnNFFCcPjUVUxQbuJncvpVN3uQ7u1vtUrPN8IV54MM5viqlvnB7cuh0VzbxV3MmDRWleNewgScMgFvkG5R2n/9WY90gEGYq31lUYS5U/yMncZCbld6fFMrnpH37mrMzUqy0BVk6hIp1gekT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3P153MB1848.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(42112799006)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWlLQ2NJVFRJb2FsOUdGZER4WEhpYnlFamFUSW5wT2w1dFN6dFhvK3pReER1?=
 =?utf-8?B?UjROdFRYVkVWOE0rSmJPMEZxbTFKTUpybVlmelRMMXk0TTZBanFCYy9oTDNx?=
 =?utf-8?B?UVdHcEY5MW5VelNyWlc1Z3dDZEk4S2V2R2JhS20xUmVTQTVvMTZxQ1U5RjQw?=
 =?utf-8?B?SE9iRUdmU2VZcWZTbEFISDE2K2NkY2RJVExQTXNXRkJwWVBsbkQvKythY0I5?=
 =?utf-8?B?VkY3Qm03K2NFbDZPazhsV0lzTkV1QjN0QjBXa2Y2TU1UNlZlUGRXZWI4NU1G?=
 =?utf-8?B?N1htU3FXU0FNRnZDN0VkcTBrZmVCSlp3amhCZ1NXWkNQb3FocnJvN3hpQThS?=
 =?utf-8?B?SHhad1NFY2pzc0VwZlFmWlA5ZTVsY1J0MU1yMldwam00LzZtNXg2UXJLU3l6?=
 =?utf-8?B?UzVJSVAxeURnMGYzU3hsWXNZZTJVKzVGc3FpUFFkb1MzN1YzMWdndWJ3T2FT?=
 =?utf-8?B?NEhxY2hRN0FWa3dHSDZFR0ltWkRSeStIYXZiS3h5RFZ5bW1kb0hXWEF4ZHV0?=
 =?utf-8?B?SUhpTjF4MExQR2Fyd09hUGR0dlJ1c0xvVCthZ0J4Q2JqTXpaZkRvTnJmSXZM?=
 =?utf-8?B?ckpaK1AzcjN3TjJkbENOTkkvSVArMitNZ0Uva3RNdTFoQVp6TVNCNC8yNDY2?=
 =?utf-8?B?ZFdPT2Z2VTJBMkRRNmVyQ3pUQ2tvdklxRzNOZHNydmNSMndyVWZXeTRZZVhk?=
 =?utf-8?B?aFNlNFF3Z05YUGNPN0tVZEgvb0wrSDdMVnNDWXRiUXVjMHVNMWU0NmVjUCtq?=
 =?utf-8?B?TmhDQTFlL2lLNHZtYkZENFVKdmIvcHc0cTE5K1JRWFV5TmpOeVBOMlNPSzRF?=
 =?utf-8?B?U1hvbnFhSkIvay9uVFRaSGhSVkhoN21EVUl0VkZoTXdGUUxMbTQwUXlZajRF?=
 =?utf-8?B?YXpzSkREeTc2Nnp3T0hwbzc3anpKdThkL3h2VThhWTJXbEpiUUFDQVhxckUx?=
 =?utf-8?B?ZHA3Y2xtYXlRMjZhUlllOElUWVFra28zZHJRZWF5NS8yU2NtdVh5Ui85dVh6?=
 =?utf-8?B?WmRpQjRoU0RoNUpGZnFTVllzNDRvTE93aUw3TzNJa3I3MUdhYWRPaVRORnkv?=
 =?utf-8?B?S3phaFRJSndsMU81TUJrTWJSZGpBRGFSNE9DN0tqaXd6ZlNMMUsvVjcvZ0dx?=
 =?utf-8?B?cW55VjUreXkycFBNRUEvWmRSTjZHaklMWGpDdU9UWDVrR0R3NWdNbTVoMUNE?=
 =?utf-8?B?VFZtdnBkZ3krUkw5dk5taGxpRHpOWjM4ZUhFTmNJQnFhc2tNNDFWMnJ0VVEx?=
 =?utf-8?B?N3R0M3ZhV1lHYmJKek5hbE1yZnZSRnR6MFRySHJvN3VvdVlBdElNaU9SdXFG?=
 =?utf-8?B?TTRoZCsyd1UvelZtaStmdEpPSVY1dmZEM1FVYlVwb2RPZW9nV09WcFZvZ0tU?=
 =?utf-8?B?cE5wdi85Z296VTZRZW5qNDN5TWtpRUtwd0ROQXdmcnJlMitkc0hCd3RiSE41?=
 =?utf-8?B?azJ2NE1PUTRJampmbkxEeTlSTXBoQlBoSHRxVm5BRExpUW5yaUtaODlTc3JN?=
 =?utf-8?B?UUp5NS9LMk5VbHlpUHRTTmEyQlVQcnBJV0cwQU9pTXB5UU4weXVFU3U0TFBj?=
 =?utf-8?B?RG90YnRBZEdtYUVFYWFBYzh1QS94Mlcyd2Y4d08xZlJDOUdIbE56cWRvK2Fa?=
 =?utf-8?B?Q3lrY0xxMHRQNDJ6UWRlWkYycWFJcjZ3STRNWVlCaUMxWUpUam5MK1lteDBp?=
 =?utf-8?B?WDU3QWVrSmlPUHdJcVhzTWdTMDVKMTFqVUdVRFNNUnNmSElEbjNYQ05rRWNT?=
 =?utf-8?B?b3JHNTJWSGRSVDBhZVV0WWk3TkNOamtKZ0paWEZUYzFlK0tPWjRqWmVZM29q?=
 =?utf-8?B?UUhaYWR5NWRCTHp5U1Y1ZUhhR21pMGNKaUhPaDFTeFdRNkFVak44cWNyYlJ1?=
 =?utf-8?B?eGlVRGdoV0dvWXZ5ZGlwZSs3NVliUGdzZ081SW5Da0JKRllXUjVPMWhhQm1O?=
 =?utf-8?B?ODRRcTVoQVdhZ0RqUm16NlNIU3dnaWlpY2d4aElrMjZwMkpMdzYrb29wVSt0?=
 =?utf-8?B?anJnQW9aR00zUUtxYXhZRFc5MU03YzBYWjl1SjY0ZUtaR1krVzVEY2pCdUYw?=
 =?utf-8?B?anZzeFF0NnZFUko2Q2Q0bWErV1ROaFBkNDdNbGNOZ25QK1F3emN4dThVd2hm?=
 =?utf-8?B?eG9oMk9HTlNFSVE0YjFJUWs0ZmxHRzcwMmx3YkJtZXp3M1VsUm1FSWJaOTdk?=
 =?utf-8?B?TVhnWC9POXZyeGpNRWxrbGJVWk5jT0t4cVRrc2ZlOGxkTS92eXZSNHhTdjhG?=
 =?utf-8?B?T05td2dOQ05EV3JNVGNMc2o2TkVYZ3lmL05Xc2ltMU9qUVpMVkJUMFBEU0xi?=
 =?utf-8?Q?2ypHxLZdxxeRnbCpyd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f29e9c-6a6d-42d1-3943-08decb7eeb39
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 08:11:50.5701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d90gCojtWPze2/49/1hd2Z0ivxMUr9v175NMnzXV0ufFiaRdOP8wS720yKSWCQCfbXyz4+2TujbnO99iWnVULg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8P153MB2304
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8
c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMTYsIDIw
MjYgMjo1MCBBTQ0KPiBUbzogV2VpIEh1IDx3ZWhAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gQ2M6
IGRldkBkcGRrLm9yZzsgTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+OyBXZWkgSHUNCj4g
PHdlaEBtaWNyb3NvZnQuY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjkg
MC8xXSBuZXQvbWFuYTogYWRkIGRldmljZSByZXNldCBzdXBwb3J0DQo+IA0KPiANCj4gT25lIHNt
YWxsIHRoaW5nIGluIG1wLmM6IGluIHRoZSBSRVNFVF9FWElUIHNlY29uZGFyeSBoYW5kbGVyIHRo
ZSByZWNlaXZlZCBmZCBpcw0KPiBvbmx5IGNsb3NlZCBvbiB0aGUgYnJhbmNoIHRoYXQgbWFwcyBp
dC4gSWYgcHJvY19wcml2LT5kYl9wYWdlIGlzIGFscmVhZHkgbm9uLQ0KPiBOVUxMIHRoZSBmZCBm
cm9tIHRoZSBtZXNzYWdlIGlzIGxlYWtlZC4gQ2xvc2UgaXQgd2hlbmV2ZXIgbnVtX2ZkcyA+PSAx
LA0KPiBvdXRzaWRlIHRoZSBpZi9lbHNlLg0KPiAtLS0NCj4gSSBjYW4gbWVyZ2UgaXQgYXMgaXMs
IG9yIHlvdSBjYW4gc2VuZCBhIHJldmlzaW9uIHRvIGNsb3NlIHRoYXQgbWlub3IgbGVhay4NCg0K
SSB3aWxsIHNlbmQgYSByZXZpc2lvbiB0byBjbG9zZSB0aGlzIGxlYWsuIFRoYW5rcyBTdGVwaGVu
IQ0KDQpXZWkNCg==
