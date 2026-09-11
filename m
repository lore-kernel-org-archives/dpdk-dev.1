Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1A9C88E4C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 10:01:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F74540269;
	Fri, 11 Sep 2026 12:01:09 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
 by mails.dpdk.org (Postfix) with ESMTP id E40D240264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 12:01:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=No1BVGGjRHFiuh11tJDctCDEM6y2IdSZfoo5oWXLULxmry8MENYDu4lwd4If8xc+0PbVmtprYv0fzXLj8PUg7+gt3g6SdaC/4n9gP2cYMN3Xrzqp1c3UrzLW+3eaMcqjkQrojimRHhVf3u573VDFFpKuYEu4BpFQ10MldyD5Gy9ozs2RU9/DaBlxQAZ6Ao+Gwsw22i7LRNM0CpaWdWGx6cljajwwNLzTObJWeg4XP8fCeX6kS/Oj2mOlb5yMwAyYmMNbX0dODnzZRg6+tXsSpMiYz0TgITlpfRzItmEDm9fYH4ana8iwrT3aKsRnuiPavM0mvxPDegJk3nilS99uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6+S1EnwCsxEGn5790GqEIakeAEZ1iwHACItZx4hh9c=;
 b=qkctmnFeawJyRlL/vRAkMvLik0yzWPMrKiJz6wADIFBOm+r2T45R3cUa8U9Uz5vOCF/pDqtuJ5PivqFfyf9JqRDtAK6BGVAACQQN/x0Rw5Sp2XfAu8BeTP4XOhp0nirNL7eFYuwk2x0pdyu3J2CSKs3TIjkKXYMCjsQT0/QrEiSPvUPMNuSRBiot4lmHFpQw77CBkc8dvcjyQDVGI2kEnJQaerPJYn4YKpUB0tq33aMx2/4yJhLhfcwRSCBmQHDIlk1Mh4KeYDtHJOID4cw1qhOJbXBAPmCWLLtcLVrNrWGpbb3xT4UgAsY1ujkLSrHR5fy6wo5FMSTptXwAH84ZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6+S1EnwCsxEGn5790GqEIakeAEZ1iwHACItZx4hh9c=;
 b=TXa5m2ZXzimzmIghrImBC9AqCGiHui4Y+kz1CnHl1cLMHwZqKF5yWTm3eB0885xK3YYGgOGqNOedVryX5XAVDwgaTlTZ/nvdEKOdYObWS8FKc3GAxEGa8svkHlb1XK7cL7znb6E/e/plMPTK+cRNyE5sJpfnFlixXPQAhVLwzJtADgDQYnQvPmEilk1On6Bf41NNVISXWpTgc+TLOulM4NpQ5xtccPi9qPD/oLt7fzwwG55MIoAKYNjyY34TUVKhOKU1ZgIYjKBX+mSpRILWGrLr0m8ze0fmHThfqchkfQtdYb0tU56nzhr+pVwowCUI/W6zq+JbJvx36YiwUowzXQ==
Received: from PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 10:01:01 +0000
Received: from PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033]) by PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 10:01:01 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "rjarry@redhat.com" <rjarry@redhat.com>,
 "cfontain@redhat.com" <cfontain@redhat.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: RE: [PATCH v6 5/5] net/mlx5: accept more unicast MAC addresses
Thread-Topic: [PATCH v6 5/5] net/mlx5: accept more unicast MAC addresses
Thread-Index: AQHdP3RmbYtmI/pu7ESi8f+eCja8cbbJGNIAgAAPmICAAAFgcA==
Date: Fri, 11 Sep 2026 10:01:01 +0000
Message-ID: <PH0PR12MB7077374483711D83EE514836A4BE2@PH0PR12MB7077.namprd12.prod.outlook.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260908092743.3439825-1-david.marchand@redhat.com>
 <20260908092743.3439825-5-david.marchand@redhat.com>
 <p2wa2mfhpzprrdekf4zc2lq5wcp3lit7vmqbidbkuklvanwjnh@jyzvzl5tpuwk>
 <CAJFAV8yeOj3pD5f2ZYWMjfbjPdQEu8onhA+cAGWxu3ZVf25yYg@mail.gmail.com>
In-Reply-To: <CAJFAV8yeOj3pD5f2ZYWMjfbjPdQEu8onhA+cAGWxu3ZVf25yYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7077:EE_|DS7PR12MB6333:EE_
x-ms-office365-filtering-correlation-id: 85f1fa86-1167-410a-c5af-08df0feb95e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: 4tPdoVpxK79gg9Z94T7dq41lzOu4aM9rSclM3725OffYDePyjjJqr1xGjEGR26fQ2FLnY2H5kZarnFK/FYOOZHS1XrvyJcg83hRQx/c63tAmQFtCixYS+75J0gw+uDpiTdS73ZDRPoOrtSIbWu2HNKR4aZ4ObSbEVFUJl/qcW54xEJngVcjmvtbbzCte8DP5D6+ImF6HSOjDX+OIDZf5wGZHZmSs7jg30PoZ9Sese8LTvMHMoZbMgcAW0CqC+gWOA4hTVB/750Ii051mF/ffzERwrEqix5Rp31orzjEpgH8ybW7Fe0KHq0NsBbV0xu2VXunHHbYQNTs83TqiibUxe9nDlyBYIVnZTD87sNo+hJ2ZSpMvnKS3sr4JGRDQsaAAcWvLzxGC7caKGLN1MTk8eEKsF0Rd3UHRnx3XwL7egPj1+YHn4aNpVp+PzwKhtWzanzrvHmZoofbCxEl4KviXOi2VULVEjFNldWl7TqO2UCL5lFfsGcRQqLNK+rdFOLJBmJx0vI0RO01X4t3hwHuOszoYUCfFinJUsfUsmyZVZ2Ox+Q+vo45n9zfAklOxDgQPK/cEX5DP2yMTgw+ydP2VOCb8HV6+5Qfhr7X6SYD/ocppe2sQ5/cDK5MfDZUKa5Xk91EYjizaG3wZrTp1glzK5YVh+CBzV5yPNytJCJQLruaKifuy9feUbRsb3ZLk6az+7tTHCWHSFdkKoVZMIPjSQG7V9QKPJbo7DimVbxXqSuY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7077.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGVzUDlFOVkyampBL3djR09pcHVUMkZlUkV6SmN6eG8rOTVDOE5iWDZ6enJB?=
 =?utf-8?B?eW1TM1djcVNNeGdLMnJQRDB2ZmZuWEp2MFBLWFBEWTJlQkhwYXhqU0RxUm5D?=
 =?utf-8?B?U3BWSEJMTmxEZGhjNVpva3B5Z0FkZzVwNjZXajQ4eHFkT0JBOGlCNmdxMVJt?=
 =?utf-8?B?bkFHNmhYeFJQZVg5b3MzcjBwZmg4NXI4SWdudVFzcVFiNURoV01aSXRSSVhP?=
 =?utf-8?B?U1FIUkFiNHdMS1hGbzJpVE9vSUQ0Mi9ZcktjdFdlcEoycVNaL3NucDg1YmJS?=
 =?utf-8?B?eUQ0ZjZvQkl5bGFSYmpPdVdacHB4dDJjSm8zY3RTOWs3Wms0QjQ2Z3JPNzMx?=
 =?utf-8?B?QkFmTFNPVHZvSjhHVzBSdm9WbUQyWGJJUGd1dnh6NVlxSmh6TzFHM09lZWhU?=
 =?utf-8?B?WUFmR3hGeGxOaThHNDIyd2VmRkxwa2JxQUdCeS9ldjNLYnRwNEo3K1o2ZjVm?=
 =?utf-8?B?TElOZStwSGIreHU3Wlhyb2FWNzk3cTk5ZE9Wdy9hb09KQkh1emJkaURDZjNX?=
 =?utf-8?B?dlU2TFdjSkp4c3JFakpxbHB3TjZXMnRtY2FSbGxHbndIWnp6OHZFUEx0WXN5?=
 =?utf-8?B?TSs4bGMzblF3SmxnMVBQeFhka1preHZzSDcxbkgvMnRsaFNKWWY2dkpDMnpH?=
 =?utf-8?B?SmYweFArUG9GME0vTFNITzY4QWNLU09sOW56T1pIMVMxSFhsSzVqbFpzUmJZ?=
 =?utf-8?B?QVNxYytuNU52VTNWWEg5R1JmNWhiNGJHbDFFVE15ZG1QT3ZENGVuUjRGd3hT?=
 =?utf-8?B?TkpoVEthYmNoUyt2N21BK1I0dWNhVmtUa05xREJUT3FxWHVnaG96eS9ERkoy?=
 =?utf-8?B?TDN3RzN2WEpzVjg5VFJyTVBteGFwRE5zYWhDVlRVZFRBMU5ERnBuV1pZUllh?=
 =?utf-8?B?ZHJWU2daQkNaWFU1Rzc2amlUR3FzOVNIeWR3SVF5VVVMRitzMzRLeWFNT2Zj?=
 =?utf-8?B?d2RHSTkxcWRNd1p3Q0FqNWJrbTNVVjRLeWE1S2NQUjZlSHlob3NTaEs1RkZr?=
 =?utf-8?B?UVJRN1RucGpycHJTV0ZnNm80SEZCZS9iSHJnNzljRlZJN1BrcjVCRXJTRDFU?=
 =?utf-8?B?b3YvNVVFYU12UjlndnVRWjFXZEJ2ZjdZVGtnM2dzaFdmUmV0Vzh6ZThPam1l?=
 =?utf-8?B?aTRtcFZkYmtOcGU2ZW1GMlFSbm1qYjdjeFVCRUpGbmVGdGJPUXQ1S2VTNUZT?=
 =?utf-8?B?a21YTUVPSjF1V01zNzg0M0ZhL0FyaGdiM3RwQ1llV1F2N1RyaXN6WGtsaGQw?=
 =?utf-8?B?M25xcW1aam5SWVhNdFE0KzJsYUY2Uk16TTlSRXFKZFRHRFZ2WTJ5ZTkxcGIr?=
 =?utf-8?B?MUkyL3ViRXRwcG9GdE1DY3N3endzZUI0Sm1mM3BNakZoT1FZbmozRkhHZXhq?=
 =?utf-8?B?WkZpcWlCNnJlUkNjenl3VEFkTUVaZmtaWkpXMFBIMTBZalRDcEp5YytSRWtF?=
 =?utf-8?B?WTBoMUJ6c0RPUmhlNlFyOGJkTEM2YnJMVjZGSTl1MnZtSzMrWGZjbGowakR5?=
 =?utf-8?B?RVlad3JTQTRjbC9yd28zTjd0QVBlWCtpNklEcERFNlBTdm0yMW85UUxheS9C?=
 =?utf-8?B?ZFc0L2E5d2Jqc2RjNVQ3eE5pa0JkQ09KWWZ5NE40dFkrSlA4SWVEL0JTSlQx?=
 =?utf-8?B?bXR0Q1BQdCtEZ0FuTmFGZEYwTFdlWS9aQmNIVFBNUVpBdFdIRFpnVDYzRkJJ?=
 =?utf-8?B?OG9Mb1p6ZU4ySmphbFYvbDd0NlZSNlQyRzlPRHZpYllMNEZoUHJnNWY1alpX?=
 =?utf-8?B?QU9QVmZUSCtCWFl3WFB4WHA3cUJiVVU5ajhUU2dheFRsSUoxelNhcEZXRmw0?=
 =?utf-8?B?WC95NFl2WTMwbzJOL0J6NVBBanlBWTQ4L1QvOXpZSGxDU0E1QkRFZnNsMitl?=
 =?utf-8?B?Rjlpb2lIN1JUM3FtcEVmcDJFVDFZN2ptU2doSFpUTmVuSVoyWkRueDMybSt5?=
 =?utf-8?B?dE5uY2REeVVKRmxJTlpJenYvOFhOYlFxMEZVZkxhdVZndmR2b2JyRS9TQ2lI?=
 =?utf-8?B?TjdNTUFLNUJsbDJDNUp3SE9saDI2VVZRRmx2R1p0eHVQemN6Z1ZBZ2Qwdm5z?=
 =?utf-8?B?dVlmc3dqendJRTROUk8wRFpCTFlUSFRTZEJIY2grRVRZKzdBRE0yWnoyYjk0?=
 =?utf-8?B?WXZyZnJOZGM4ZE0zcEVBQTcyeUNieWpGWVVWbHlnbnNtdlZLK3JJNG5TRXpI?=
 =?utf-8?B?WldxQzFBSHlpNFd1NWJYRVdJdU01dGJteGhuOUEzNFU4cTlFZFlHRWJBMEF4?=
 =?utf-8?B?OUxUbkFRMGJvUTZSTXpYQWtYZVkxZkY0NUkvSDVxRDIzb1FwZUk1TDFPUk9k?=
 =?utf-8?B?dmlGSnpObjVFWFZqY1cxREp1V3lqOGY4WU1JZWVBc1NLR0txNjJlUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7077.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f1fa86-1167-410a-c5af-08df0feb95e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 10:01:01.6313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WuRUWpCiRnHnW2B5Oyi/c5zYzgsWrx8V7+DDP+Lnq5SpqyaP/xfv6Sk2nU4GZDyhrGuX5KyAIpdUR7ZGMflQGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTWFyY2hhbmQg
PGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDEx
LCAyMDI2IDExOjU1IEFNDQo+IFRvOiBEYXJpdXN6IFNvc25vd3NraSA8ZHNvc25vd3NraUBudmlk
aWEuY29tPg0KPiBDYzogZGV2QGRwZGsub3JnOyByamFycnlAcmVkaGF0LmNvbTsgY2ZvbnRhaW5A
cmVkaGF0LmNvbTsgU2xhdmENCj4gT3ZzaWllbmtvIDx2aWFjaGVzbGF2b0BudmlkaWEuY29tPjsg
QmluZyBaaGFvIDxiaW5nekBudmlkaWEuY29tPjsgT3JpDQo+IEthbSA8b3Jpa2FAbnZpZGlhLmNv
bT47IFN1YW5taW5nIE1vdSA8c3Vhbm1pbmdtQG52aWRpYS5jb20+OyBNYXRhbg0KPiBBenJhZCA8
bWF0YW5AbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiA1LzVdIG5ldC9tbHg1
OiBhY2NlcHQgbW9yZSB1bmljYXN0IE1BQyBhZGRyZXNzZXMNCj4gDQo+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gSGVs
bG8gRGFyaXVzeiwNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJldmlldy4NCj4gDQo+IE9uIEZyaSwg
MTEgU2VwdCAyMDI2IGF0IDExOjAwLCBEYXJpdXN6IFNvc25vd3NraSA8ZHNvc25vd3NraUBudmlk
aWEuY29tPg0KPiB3cm90ZToNCj4gPiA+IEBAIC0xOTYzLDE3ICsxOTg5LDE1IEBAIG1seDVfZGV2
X3NwYXduKHN0cnVjdCBydGVfZGV2aWNlDQo+ICpkcGRrX2RldiwNCj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICBtbHg1X2ZsZXhfaXRlbV9wb3J0X2NsZWFudXAoZXRoX2Rldik7DQo+ID4gPiAg
ICAgICAgICAgICAgIG1seDVfZnJlZShwcml2LT5leHRfcnhxcyk7DQo+ID4gPiAgICAgICAgICAg
ICAgIG1seDVfZnJlZShwcml2LT5leHRfdHhxcyk7DQo+ID4gPiArICAgICAgICAgICAgIG1seDVf
ZnJlZShwcml2LT5tYWMpOw0KPiA+ID4gKyAgICAgICAgICAgICBldGhfZGV2LT5kYXRhLT5tYWNf
YWRkcnMgPSBOVUxMOw0KPiA+DQo+ID4gVGhpcyBjYW4gc2VnZmF1bHQgYmVjYXVzZSBldGhfZGV2
IGlzIGFsbG9jYXRlZCBsYXRlciB0aGFuIHByaXYuDQo+ID4gUHJldmlvdXMgdmVyc2lvbiBvZiB0
aGUgZXJyb3Igcm9sbGJhY2sgYWNjb3VudGVkIGZvciB0aGF0ICh3aGVyZQ0KPiA+IG1hY19hZGRy
cyB3YXMgcmVzZXQgb25seSBpZiBldGhfZGV2ICE9IE5VTEwpLg0KPiA+IFRoZSBzYW1lIGxvZ2lj
IGFwcGxpZXMgaW4gV2luZG93cyBjb2RlLg0KPiA+DQo+ID4gQ291bGQgeW91IHBsZWFzZSByZXZl
cnQgdGhhdD8NCj4gDQo+IFdlbGwsIHRoZSBjb2RlIGJlZm9yZSBsb29rZWQgZmlzaHkgdG8gbWUu
DQo+IFJlc2V0dGluZyBtYWNfYWRkcnMgaWYgKGV0aF9kZXYgIT0gTlVMTCkgb3V0c2lkZSBvZiB0
aGUgaWYgKHByaXYgIT0NCj4gTlVMTCkgYmxvY2sgc2VlbXMgaW5jb3JyZWN0Lg0KPiANCj4gDQo+
ID4gPiArICAgICAgICAgICAgIG1seDVfZnJlZShwcml2LT5tYWNfb3duKTsNCj4gPiA+ICAgICAg
ICAgICAgICAgbWx4NV9mcmVlKHByaXYpOw0KPiA+ID4gICAgICAgICAgICAgICBpZiAoZXRoX2Rl
diAhPSBOVUxMKQ0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIGV0aF9kZXYtPmRhdGEtPmRl
dl9wcml2YXRlID0gTlVMTDsNCj4gDQo+IEkgd291bGQgcmF0aGVyIHJlc2V0IG1hY19hZGRycyB0
byBOVUxMIGFsb25nIHRoZSBkZXZfcHJpdmF0ZSByZXNldCBpbiB0aGUgaWYNCj4gKGV0aF9kZXYg
IT0gTlVMTCkgYmxvY2sgcmlnaHQgYWZ0ZXIuDQo+IFRoZSBjb21tZW50IGFib3V0IG1hY19hZGRy
cyAoc2VlIGJlbG93KSBiZWluZyBpbiBkZXZfcHJpdmF0ZSBjYW4gYWxzbyBiZQ0KPiByZW1vdmVk
Lg0KPiANCj4gV0RZVD8NCg0KUmVzZXR0aW5nIGl0IGFsb25nIHdpdGggZGV2X3ByaXZhdGUgcmVz
ZXQgc291bmRzIGdvb2QgdG8gbWUuDQo=
