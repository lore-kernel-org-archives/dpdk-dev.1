Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989BEC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 07:27:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B7C040289;
	Wed,  5 Feb 2025 08:27:18 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by mails.dpdk.org (Postfix) with ESMTP id B1B1A40270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 08:27:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2gUKSK5kGY9YRKBBZWu3imNgd90/pfE3f7uMelg6hSSEHrXQed9JowwXRkHG+xHO1JPGMw/EDG3RpFhtf21Ofpekb71hj7ybNTiMukrjSqj7aoy7/JlceXPYsempZU3h5N9r58+A3YYuZA7DJTjtjJHf1pLt9zHw4LA94QdasjFQfKdtRjD7Lr7LD+H7STPdTrV8oKyWbTktUJ/QO9L0SDlhuiK86CeoAKgv9cq3Y6bkanKlbV4oQj2jLr3vlrmXYAWz8719CoLSHZmGyxcsQPsLpC7kzWmWCwujDI5zvUGmjBt4KkmfrdRWRKo1drgfpc1lqQpGm9W/m2smLXkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMWk/kOHCj5s+USdSaEAQ/UxX/pn+JwFUAFxiPZt5jA=;
 b=JSdHvcGAkFIj2VzydrZcFpT8eYbaUkNAsAwL76MRGbZBOvUmUckIOJzVxtjVdYPvPxhqPIZcopw6rRo0coiuZfh3kx8mjI85Wgx9Og1kCpOaWU1mKGkcel3RZ83q2RV+dftT7BuzEa6YSvIiGMmMqThHqvB2gQPdu5I3T/YDujBWOjWksmFUTcMLJ1XarwfuxYL9gzocZY9vw4FusBGhDAN8fwvjUxdSIcXuBih9IoLbqM6MPThxn7VBinpHiwguOp8UWaiPrJ72GgRNN783a4fimZ0G41LHz33+Tl3Vd66tpgRx/mctBYMXIOQk1tDvdsMmea1stnMLZ9KdFmE5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMWk/kOHCj5s+USdSaEAQ/UxX/pn+JwFUAFxiPZt5jA=;
 b=QXYDwcIKGx02sMDEN6ZUBDtYyjQlLJpJBd+FOaZtvHa1bF7zE7KEWB3Cnb3qX6Jc30x+An3RprrbFCsMcFiV/eeDV1wWxuQmYFmx4tLZERh73xKVNwHrsc+WqXN40KN1E72AV20Re4iHv4gEGv0K+5H7/g5XmkqigMFxVAMtomQsXgkFSTPXnp9tsujLGfqxfKbw8uj+BSQlhnp4vx0nEV5EhELs90kEZoSDMVwQ25j0Alg8mDatoKGUbbtixnNIksu1T+yoVXqnYKOxcDk9QKMjjQKcoB1S6mGzjdr7Rdc7xvGBGSy2DVNp2wYR3R8rfhfpNToTWqlKj3DFmZzhlw==
Received: from MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 07:27:14 +0000
Received: from MN0PR12MB6103.namprd12.prod.outlook.com
 ([fe80::3c6c:6f63:917e:98d8]) by MN0PR12MB6103.namprd12.prod.outlook.com
 ([fe80::3c6c:6f63:917e:98d8%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 07:27:14 +0000
From: Chenbo Xia <chenbox@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: Maxime Coquelin <maxime.coquelin@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC 0/3] Vhost: fix FD entries cleanup
Thread-Topic: [RFC 0/3] Vhost: fix FD entries cleanup
Thread-Index: AQHbVhuD2TmdjYHFl0+X3WzF5AObBbM3YlwAgAEwIIA=
Date: Wed, 5 Feb 2025 07:27:14 +0000
Message-ID: <3EE665CF-8BD9-4F3E-8CF4-30F0A285A7CC@nvidia.com>
References: <20241224154958.146852-1-maxime.coquelin@redhat.com>
 <CAJFAV8zwCx+Xsa12TaLye3A9dSSSbt_T_-cc6Lc71oNyLv9=nw@mail.gmail.com>
In-Reply-To: <CAJFAV8zwCx+Xsa12TaLye3A9dSSSbt_T_-cc6Lc71oNyLv9=nw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6103:EE_|MN0PR12MB6056:EE_
x-ms-office365-filtering-correlation-id: 7f2a7ea4-6cd6-4ce3-21f8-08dd45b6832e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R25Lc1NhenRERHIyTG1GWmFqZUtsa0lLdFZBN29ETVdaU2hISklkT05TTXZO?=
 =?utf-8?B?SXZNR0NPVk9UbjhNSm15cmx4dUFWWWtrb29nTitJbVRkczNiRi9reFkrRmFF?=
 =?utf-8?B?c0dzdWFDTHNNaFpleTB0eUp1b1JoOEY1bjBjQnkzSm0wNFMrQTlxNzlQbHVG?=
 =?utf-8?B?OXgyTko0UzU5cnVqTXM1VXRLV090RkpncTk3UWpjN2hnSVpiSjB4MjNGUUt1?=
 =?utf-8?B?RXQrL3hHVkdrMFRBeHJQZ2o4UjhjQldDTFIyZzUyTEwvNWlMZiswMy9DVzBl?=
 =?utf-8?B?VlpZeDZENjc4djhZSTg5WUdNdEp3NFk2cFRkRUc5MVd0VnA4SWNJUm9OKzNL?=
 =?utf-8?B?Ri9RT2FuTUo3bDZlUkpSdFdDWmRhNFhHTWRFdndRWjZCWTRmK1NweWRUMjl5?=
 =?utf-8?B?czI4aTYvZ01GS1ZyUGZ4VWc1NEFJRk9oa1hxd1RHOHE2OW1WSkhyR0NvM0FE?=
 =?utf-8?B?NHE3U3lkQ1N0MFlscTN4b2RFZU1qeG1BWlA0TmZsdmRUaTVxR3RncDJyMmYv?=
 =?utf-8?B?U0p5KytJWmVlaXp3OG9ZMTFTMFgyRDFCNG9Ed2lFOTJCUENSVFQwUjQ5cTZx?=
 =?utf-8?B?TloyMG5iSEFuVTlPcnZobzFhU2l6Ukg4TjBLL1d2MmpRc3BaTWtQQXlEb2pl?=
 =?utf-8?B?SWpObHArUHNOME5wU0xoK3I3RXlleHlHQzFUd3VXc05pRll2UjhyZlQwYXZu?=
 =?utf-8?B?cDltQlNlUi9pcDNtVWlSZDlKRUVBU1d4YTNMVlZ2R1J3bkFMdDNaL1NMVUMx?=
 =?utf-8?B?UTVWS3JUZUtCKzJjSGVHd21hUHNEc01NZWk0dUZHRW1sbSs5RnErdVdzSVJD?=
 =?utf-8?B?WnI0aW1MNEFYeFpCdWEwWUpvM1J3ZzdjbVA0SlBnOTZCb0oxelpGZUYreG1D?=
 =?utf-8?B?QzZvdURJOXk4WXhKODhveEN3Vk9IM3NjMEtvUW1ETzM4WXdvOVFKQlJscEtO?=
 =?utf-8?B?UFJuV2haeWMwUCtvam1PUUhyRUlSbDRmYVVHejI1emYvby91alpLOHZYc1Bn?=
 =?utf-8?B?eUlrQ0Rtc1ZKaEprenZqZ0RHV3RjOG1qVDJCbHBpTDg1UGNiZ3ZIMGdCMlA4?=
 =?utf-8?B?Wnl6YUFsUTlWY3FTVG4xdjBFcWZ5QjA4bXZFQTJGbGxDSFRWa0JDbGVhaWtk?=
 =?utf-8?B?L2RJeEhiYVRneDFHV1AvSWppWHJ4TDdBOVNYUlRiWlN6NFBoWVY5Vi82WFpy?=
 =?utf-8?B?RGMzVG5PYzhiV0NxYkQrQmoxekczTFVoYVR5SXlFK2VTME0rUFEwRFhVZzFt?=
 =?utf-8?B?cWhuNFFhMG0vRmR6aFA5SEU2WDFJeDdFcER1NXlVSDk0L1FpaGNaWFhUamxs?=
 =?utf-8?B?RllnNTZ3eS9wSHlSTG9GcGJ3dGxCWm90WGdNMVp1aDhpanEwdjY2amdKMEVV?=
 =?utf-8?B?UmRYR1RUN01NbVlKUkFoeDVwckFURFc0cDBEYktZU2l0ZjZqWFFjWm1HSTFU?=
 =?utf-8?B?UDFidnlMWExDcjhjTlVVMWVHZ2p6b2dXVW13L2c1RkVEWm43enRPRGJRK000?=
 =?utf-8?B?ODlnbjlncUJvYktKUTF0aEZ3OGZ1OUMrdEZGTk1oOExHcDA4WTYxM2ZHRkJX?=
 =?utf-8?B?OUtwNU1pNTZ6bVZveXVSNkVMNWY0VmdLVEVZQmRKTUZvVFlTanJlTkNwOFdn?=
 =?utf-8?B?VGdmUDFmUWYzVmExaWdWSHNnanJoeng4ZkV5cG5IUi82d2VSTitPNWZzZlRr?=
 =?utf-8?B?eVlDTjIzK0VnaXBJVnZndjdhNitNMzRJcWVIYlFxZ2s2ZmN1TStKMHdtTUxi?=
 =?utf-8?B?eGVyZWt5d2F0c0hCR0E2QVVEYUVqZU12SmxRaGVSY0dUeTA3TDAyVDJsUUlY?=
 =?utf-8?B?NitqdGJUS2RHQ1V4MUt0STZUdml0eVF1T1VkUzFHUkRxVWZ4eDdnYnNqZmM2?=
 =?utf-8?B?NCthdnlxQ0NEZHdSVW5RN3M0MGRyN2hXdzg2Yk5GMkVTYnM0NCtUTlk3elEy?=
 =?utf-8?Q?/2i67sqmjLhwHL/TPabboexwx/Drn8fR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6103.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RS80eFlSZStQUXBndkdudXZVY0J1L0xJQnNGMVd4T0E5M0NLa0VSZmpWOU5Y?=
 =?utf-8?B?UkdTOVZoOG9pZzhqR3hoa05TUmJiYnJsZG9KSHBMOWpzZXlncHVLQTBjaXdX?=
 =?utf-8?B?WWM3Ylg1dEl6TU0yYXIrV2hNK1NlNkh6a3E0emlKRVdHeUdxQzV4K0J4bHhq?=
 =?utf-8?B?TjZ1eWNYNWh2NWg1cXRTZmdwZlVlYktIcExRYmdUQzRjZ0w1V1d0RjVEdjV0?=
 =?utf-8?B?RXNPaSthSCtpRkFSUWNFTnZrVktDdS94OFo3UFJoYWg1YzlraVYzWDdzSUJB?=
 =?utf-8?B?UVZkdnNCZ0REbXl4NThPbW5Xd3NSWmN5Ymt3dmFnQ3BQZzdjRExLZ2pML0V2?=
 =?utf-8?B?dWozR29Pc3ExeUpWNk5aajVGZzBOUjVUNElNemtxS0NYalFuOHJUbXdRc0VI?=
 =?utf-8?B?ZHVpdGcvVENPSFNJTTFCeU5GSHA2ek80cU50MlVqaXUvZkRTZDcxMDJxVENT?=
 =?utf-8?B?Z2xmVFRqVlpjbEVINnJreWtpUFJPOExOQjFSSEZJRkRaVytscDU5UmNzZU9s?=
 =?utf-8?B?TDBqQnJVUTNlZHFBMTByWlRjdGJ4OHliVFA1MndHVDkyNGw1VnlrTXprTG1h?=
 =?utf-8?B?d3dTRlZFTXZoNjA5aFJSNms3aU90bTdoWUc3a21ja2dlWFVlcXVnK3lmR0pD?=
 =?utf-8?B?bk5tRlNxOGlBMGh4TjB4NnZSbVNSMUVzS1JYNVRLSFp5Z1AvTTRUUndzaENr?=
 =?utf-8?B?Rkd5clF2Qng4U2VmbUUySDI5K3E2aG1FNVVIUWhKc1RKSTF6K0g1c3hiNHhh?=
 =?utf-8?B?d3p1L3ozVVNHYWpyQ0hlK0RNTWRzalpmcmJ0NTdFSFo2czhkYllYYXRPOXF1?=
 =?utf-8?B?c21seXk5eXo1TWQzWmZqdDBkOEptRnhmMzR3Y0g5MXcrTDZ4WUlUQTJ3WWli?=
 =?utf-8?B?a2hWZW1uOVN3dDZMSU12alo2eXFXV3B0MEhteHNqbVdEZjVXejZsZHlzWUZn?=
 =?utf-8?B?ZDF0NkZDV0NXZmxqR1lQeGZ1VTJvbzBFNWlLNE01UkgxQXBuYVRDZ29xUnNK?=
 =?utf-8?B?Y0h2MEJhNTZRZDMrdGlLQmk2Y3Z4OXpPMWZZNVluS2JMejJENHNLSlNCYjZl?=
 =?utf-8?B?Nzc3T2MxaHplQ0FsR2t1ZzFPckp5NGdLQmJ6L3pJYXFYTzlpRG44UVNnNTMz?=
 =?utf-8?B?cU93OXA3QlRMRFpBS0RoMHp1TGliZXRsWVBKemVralJiV29VRElSQkkzZHcr?=
 =?utf-8?B?ZyswUWtnWWh2WTZrNXBXRk5iRDhxaFdnTzZvdHF3VlBhWlFVSTFoaFhORllt?=
 =?utf-8?B?MW5mUmVDZGVzV2FsQndYVnkvQ1kwaTRLaFo0YUZ6U1Q3c1MweHRoUWlGMFQx?=
 =?utf-8?B?WjdXemh4OXFJNU9PVDZZQVA5bUVpK21mUjYzV2J3ZzN2VFdXUXhZRCticHBJ?=
 =?utf-8?B?MC9HWk5kZmtkVCtYNXlIajN0bSs1YnRoZVJjczhFeGJCMFVKaThBUHNDRGoz?=
 =?utf-8?B?MkZBb3F4aTVZM2JzaDNwbWNIY2NmSHRqNXprUTZ1OFVESUVuSTJwUUVjRUwx?=
 =?utf-8?B?aFdRZ1V2MDFJLzN2c0JLdmNhZkpuWHROWHQ5bTMvUGM2VThHamE3MDF4Y1Q1?=
 =?utf-8?B?TlQ2SnYrckVjbEpkTG1KakJTREVyakd1UE8zNE5aUFI4TWVGZ1FkdnBMS0s5?=
 =?utf-8?B?RWE3c29wcUlGVm1rV1VuNk5qUnlkOWlWUW4vc2tQSnpZejRoS1BjaTNLWkxQ?=
 =?utf-8?B?OEMwSS9oNEJDZmg1UUJUZzhPcjZxSkhaU0JzeDJvK2RUbDl6K2dyRGJPSndn?=
 =?utf-8?B?WFRmMGdJRllNRFU3Zko4QnJKaDRBdjhtZ25FM0k1Ky94dHNJNXJhTTdjbWVk?=
 =?utf-8?B?cmlFMDZkWUtjaVJQMzNoK3JQdzJqNTJEMzdwK1cwcHdoRmxLdi96Y2FTUjBL?=
 =?utf-8?B?MklSQ0dJR1ZCbWJHSWRMcy9Pd1RwTEM0OHdhVmZSK2ljL0JkbW9EODlSSkU3?=
 =?utf-8?B?blYvOG0ybndyM2pieE1nR1llbnpGRFB2OHJ6VkEzR2lmd2daWU5BUURLOHFM?=
 =?utf-8?B?ZkxMN0s4MlI4VEJ3YVFRdVNMUUxZbzZ3MEYzdzFsdVFDZ0JjSHovNGtUVnRL?=
 =?utf-8?B?ditPMk0xRTlMMS80djEra2FIYTJ1WjRCdklrazNzSnVYQ1I5bzhNZG5qdDZO?=
 =?utf-8?Q?WwtlRtlYnSLWgYmmIjjJurqzN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <036C3DAC9429DE4B8B6FDE30BE8FF364@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2a7ea4-6cd6-4ce3-21f8-08dd45b6832e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 07:27:14.3252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DOtE6Fp1BVGDrsh/I55jwBfAeIXhqKRw3kespfrPFMf9eYvN8makbCHEFee6ubISuGV7NFIM7OYAH4mywx7Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
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

SGkgRGF2aWQsDQoNCj4gT24gRmViIDQsIDIwMjUsIGF0IDIxOjE4LCBEYXZpZCBNYXJjaGFuZCA8
ZGF2aWQubWFyY2hhbmRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDog
VXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IEhlbGxv
IHZob3N0IG1haW50YWluZXJzLA0KPiANCj4gT24gVHVlLCBEZWMgMjQsIDIwMjQgYXQgNDo1MOKA
r1BNIE1heGltZSBDb3F1ZWxpbg0KPiA8bWF4aW1lLmNvcXVlbGluQHJlZGhhdC5jb20+IHdyb3Rl
Og0KPj4gDQo+PiBUaGUgdmhvc3QgRkQgbWFuYWdlciBwcm92aWRlcyBhIHdheSBmb3IgdGhlIHJl
YWQvd3JpdGUNCj4+IGNhbGxiYWNrcyB0byByZXF1ZXN0IHJlbW92YWwgb2YgdGhlaXIgYXNzb2Np
YXRlZCBGRCBmcm9tDQo+PiB0aGUgZXBvbGwgRkQgc2V0LiBQcm9ibGVtIGlzIHRoYXQgaXQgaXMg
bWlzc2luZyBhIGNsZWFudXANCj4+IGNhbGxiYWNrLCBzbyB0aGUgcmVhZC93cml0ZSBjYWxsYmFj
ayByZXF1ZXN0aW5nIHRoZSByZW1vdmFsDQo+PiBoYXZlIHRvIHBlcmZvcm0gY2xlYW51cHMgYmVm
b3JlIHRoZSBGRCBpcyByZW1vdmVkIGZyb20gdGhlDQo+PiBGRCBzZXQuIEl0IGluY2x1ZGVzIGNs
b3NpbmcgdGhlIEZEIGJlZm9yZSBpdCBpcyByZW1vdmVkDQo+PiBmcm9tIHRoZSBlcG9sbCBGRCBz
ZXQuDQo+PiANCj4+IFRoaXMgc2VyaWVzIGludHJvZHVjZXMgYSBuZXcgY2xlYW51cCBjYWxsYmFj
ayB3aGljaCwgaWYNCj4+IGltcGxlbWVudGVkLCBpcyBjbG9zZWQgcmlnaHQgYWZ0ZXIgdGhlIEZE
IGlzIHJlbW92ZWQgZnJvbQ0KPj4gRkQgc2V0Lg0KPj4gDQo+PiBNYXhpbWUgQ29xdWVsaW4gKDMp
Og0KPj4gIHZob3N0OiBhZGQgY2xlYW51cCBjYWxsYmFjayB0byBGRCBlbnRyaWVzDQo+PiAgdmhv
c3Q6IGZpeCB2aG9zdC11c2VyIHNvY2tldCBjbGVhbnVwIG9yZGVyDQo+PiAgdmhvc3Q6IGltcHJv
dmUgVkRVU0UgcmVjb25uZWN0IGhhbmRsZXIgY2xlYW51cA0KPj4gDQo+PiBsaWIvdmhvc3QvZmRf
bWFuLmMgfCAxNiArKysrKysrKysrKystLS0tDQo+PiBsaWIvdmhvc3QvZmRfbWFuLmggfCAgMyAr
Ky0NCj4+IGxpYi92aG9zdC9zb2NrZXQuYyB8IDQ2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+IGxpYi92aG9zdC92ZHVzZS5jICB8IDE2ICsrKysrKysr
KysrLS0tLS0NCj4+IDQgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRp
b25zKC0pDQo+IA0KPiBJIHRyaWVkIHRoaXMgc2VyaWVzLCBhbmQgaXQgZml4ZXMgdGhlIGVycm9y
IGxvZyBJIHJlcG9ydGVkLg0KPiANCj4gT24gdGhlIG90aGVyIGhhbmQsIEkgd29uZGVyIGlmIHdl
IGNvdWxkIGRvIHNvbWV0aGluZyBzaW1wbGVyLg0KPiANCj4gVGhlIGZkIGlzIG9ubHkgdXNlZCBi
eSB0aGUgcmVnaXN0ZXJlZCBoYW5kbGVycy4NCj4gSWYgYSBoYW5kbGVyIHJlcG9ydHMgdGhhdCBp
dCBkb2VzIG5vdCB3YW50IHRvIHdhdGNoIHRoaXMgZmQgYW55bW9yZSwNCj4gdGhlbiB0aGVyZSBp
cyBubyByZW1haW5pbmcgdXNlciBpbiB0aGUgdmhvc3QgbGlicmFyeSBmb3IgdGhpcyBmZC4NCj4g
DQo+IFNvIG15IHByb3Bvc2FsIHdvdWxkIGJlIHRvIHJlbmFtZSB0aGUgInJlbW92ZSIgZmxhZyBh
cyBhICJjbG9zZSIgZmxhZzoNCj4gDQo+IEBAIC0xMiw3ICsxMiw3IEBAIHN0cnVjdCBmZHNldDsN
Cj4gDQo+ICNkZWZpbmUgTUFYX0ZEUyAxMDI0DQo+IA0KPiAtdHlwZWRlZiB2b2lkICgqZmRfY2Ip
KGludCBmZCwgdm9pZCAqZGF0LCBpbnQgKnJlbW92ZSk7DQo+ICt0eXBlZGVmIHZvaWQgKCpmZF9j
YikoaW50IGZkLCB2b2lkICpkYXQsIGludCAqY2xvc2UpOw0KPiANCj4gc3RydWN0IGZkc2V0ICpm
ZHNldF9pbml0KGNvbnN0IGNoYXIgKm5hbWUpOw0KPiANCj4gQW5kIGRlZmVyIGNsb3NpbmcgdG8g
ZmRfbWFuLg0KPiBTb21ldGhpbmcgbGlrZToNCj4gDQo+IEBAIC0zNjcsOSArMzY3LDkgQEAgZmRz
ZXRfZXZlbnRfZGlzcGF0Y2godm9pZCAqYXJnKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgIHB0
aHJlYWRfbXV0ZXhfdW5sb2NrKCZwZmRzZXQtPmZkX211dGV4KTsNCj4gDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKHJjYiAmJiBldmVudHNbaV0uZXZlbnRzICYgKEVQT0xMSU4gfA0KPiBF
UE9MTEVSUiB8IEVQT0xMSFVQKSkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
Y2IoZmQsIGRhdCwgJnJlbW92ZTEpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJjYihmZCwgZGF0LCAmY2xvc2UxKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICBpZiAod2Ni
ICYmIGV2ZW50c1tpXS5ldmVudHMgJiAoRVBPTExPVVQgfA0KPiBFUE9MTEVSUiB8IEVQT0xMSFVQ
KSkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3Y2IoZmQsIGRhdCwgJnJlbW92
ZTIpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdjYihmZCwgZGF0LCAmY2xv
c2UyKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICBwZmRlbnRyeS0+YnVzeSA9IDA7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgLyoNCj4gICAgICAgICAgICAgICAgICAgICAgICAgKiBmZHNl
dF9kZWwgbmVlZHMgdG8gY2hlY2sgYnVzeSBmbGFnLg0KPiBAQCAtMzgxLDggKzM4MSwxMCBAQCBm
ZHNldF9ldmVudF9kaXNwYXRjaCh2b2lkICphcmcpDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICogZmRlbnRyeSBub3QgdG8gYmUgYnVzeSwgc28gd2UgY2FuJ3QgY2FsbA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAqIGZkc2V0X2RlbF9sb2NrZWQoKS4NCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgKi8NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJlbW92ZTEgfHwgcmVtb3Zl
MikNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGNsb3NlMSB8fCBjbG9zZTIpIHsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZkc2V0X2RlbChwZmRzZXQsIGZkKTsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9zZShmZCk7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgfQ0KPiANCj4gICAgICAgICAgICAgICAg
aWYgKHBmZHNldC0+ZGVzdHJveSkNCj4gDQo+IA0KPiBBbmQgdGhlIG9ubHkgdGhpbmcgdG8gbW92
ZSBvdXQgb2YgdGhlIHNvY2tldCBhbmQgdmR1c2UgaGFuZGxlcnMgaXMgdGhlDQo+IGNsb3NlKGZk
KSBjYWxsLg0KPiANCj4gTGlrZToNCj4gDQo+IEBAIC0zMDMsNyArMzAzLDcgQEAgdmhvc3RfdXNl
cl9zZXJ2ZXJfbmV3X2Nvbm5lY3Rpb24oaW50IGZkLCB2b2lkDQo+ICpkYXQsIGludCAqcmVtb3Zl
IF9fcnRlX3VudXNlZCkNCj4gfQ0KPiANCj4gc3RhdGljIHZvaWQNCj4gLXZob3N0X3VzZXJfcmVh
ZF9jYihpbnQgY29ubmZkLCB2b2lkICpkYXQsIGludCAqcmVtb3ZlKQ0KPiArdmhvc3RfdXNlcl9y
ZWFkX2NiKGludCBjb25uZmQsIHZvaWQgKmRhdCwgaW50ICpjbG9zZSkNCj4gew0KPiAgICAgICAg
c3RydWN0IHZob3N0X3VzZXJfY29ubmVjdGlvbiAqY29ubiA9IGRhdDsNCj4gICAgICAgIHN0cnVj
dCB2aG9zdF91c2VyX3NvY2tldCAqdnNvY2tldCA9IGNvbm4tPnZzb2NrZXQ7DQo+IEBAIC0zMTMs
OCArMzEzLDcgQEAgdmhvc3RfdXNlcl9yZWFkX2NiKGludCBjb25uZmQsIHZvaWQgKmRhdCwgaW50
ICpyZW1vdmUpDQo+ICAgICAgICBpZiAocmV0IDwgMCkgew0KPiAgICAgICAgICAgICAgICBzdHJ1
Y3QgdmlydGlvX25ldCAqZGV2ID0gZ2V0X2RldmljZShjb25uLT52aWQpOw0KPiANCj4gLSAgICAg
ICAgICAgICAgIGNsb3NlKGNvbm5mZCk7DQo+IC0gICAgICAgICAgICAgICAqcmVtb3ZlID0gMTsN
Cj4gKyAgICAgICAgICAgICAgICpjbG9zZSA9IDE7DQoNCkkgaGF2ZSBvbmUgY29uY2VybiBoZXJl
IGlzIGNvbXBhcmVkIHdpdGggdGhpcyBSRkMsIHRoZSBwcm9wb3NhbCBjaGFuZ2VkIHRoZSB0aW1p
bmcNCm9mIGNsb3NlIGNvbm5mZO+8jHdoaWNoIG1lYW5zIG9uIFFFTVUgc2lkZSwgY2xlYW5pbmcg
dXAgcmVzb3VyY2VzIHdpbGwgaGFwcGVuIGxhdGVyLg0KDQpDdXJyZW50bHkgSSBjYW7igJl0IHRo
aW5rIG9mIGlzc3VlcyBjb3VsZCBiZSBpbnRyb2R1Y2VkIGJ5IHRoaXMgY2hhbmdlIChtYXliZSB5
b3UgYW5kDQpNYXhpbWUgY291bGQgcmVtaW5kIG1lIG9mIHNvbWV0aGluZyA6KQ0KDQpCZXNpZGVz
IHRoaXMsIGRlZmluaXRlbHkgdGhpcyBwcm9wb3NhbCBpcyBjbGVhbmVyLg0KDQpUaGFua3MsDQpD
aGVuYm8gDQoNCj4gDQo+ICAgICAgICAgICAgICAgIGlmIChkZXYpDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgdmhvc3RfZGVzdHJveV9kZXZpY2Vfbm90aWZ5KGRldik7DQo+IA0KPiANCj4gTWF4
aW1lLCBDaGVuYm8sIG9waW5pb25zPw0KPiANCj4gDQo+IC0tDQo+IERhdmlkIE1hcmNoYW5kDQo+
IA0KDQo=
