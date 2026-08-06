Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A871C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 07:56:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4293E40276;
	Thu,  6 Aug 2026 09:56:15 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012021.outbound.protection.outlook.com
 [40.107.200.21]) by mails.dpdk.org (Postfix) with ESMTP id 5B40040262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 09:56:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9Ec8fH+k28UtjxpDigly8zkdSBf/wEET4Znx4oWxYHrxwe6HnVAf7eWbW26W4KLMG7KqXduG/uAH3HMuWbevcljLg0VgNCuPn+jm7+LojRewig9w+tbXNIfgj/bB6kW91QbLcLIA1TRam3Dt5/5hcfI/8itLUXoz6bSpfIl8O8A0XqIc5b6kef0f0/Fmhgksd6RpRL/HITNymyblehnEEdndYfHtRTqJdCBZpIiyWkpw74kQ0QO29Ls0YmOA9zj+EFQChTBVXFUcTAWhVNudlY7rYrcVFdBRcZt1TjYY4IDHgTVv/vb1qVmevCXS94GH5Xgq5e+F/7Locj/ByzX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yx3Ojg9iMCWPuRXvOGIzbYbqBnGQueslziTbbmdSVI=;
 b=xmzobvqOnFef5VTqKwR4EGPDJB0RnvydqiqShfVXz01wDGnU3B2xdI+XTNU01esCPAYIoEmDTDBmiPVe03kgQ720cuXBPzAJL3BPfvyX9hAQ7Tk8wfjgBieVjomXYwLiY62kFc2yPd0B8NeIXyZdF9SxBC5daCi+vo6JC+9RpYPcV6hAs7qRxQ/ySWj9pOlIi3llgY5UIvAxleE3hJlviA2/4nC9rjNGOUfnUsnamhrp8LG1JWcADb4VlaZBYPdOulRUF2AHAWsh9u8ES2nVZchZOKXnfUP5iwaNeXK9L82GRqZ/+N+5ReOCo/mcWO9y3xNpwR8mw4KkBtn31t6D6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yx3Ojg9iMCWPuRXvOGIzbYbqBnGQueslziTbbmdSVI=;
 b=RrvHA0Hv+AKnCyyEcEbDGuPdBdXsbZiG9skN17JPNlgMosMA/bBuGKI26dBfWOGYG0fUQbQ+W2Eq1nqwRahcJ3XuCM1vbc4kzThFfFJoph40OaAxeudhEc/NjOqJCzkWyH0ndum+w14tDK43qpYbJIU5fG4nE84W1oncaf72tbQd3sdSvZwns3Jke2BLV2e28vFgYEtG7No04+whLeGjvrDGTs3xLHW6IDk6Dv4GDMxnjIksb1Dta3xI8NAk5N6302v3rUXDHfdfStuVOz1KXBrpUjVOgfzax2sBC9sQqyOhgRwgGc0MDZWR6es40ujYhWkx4XuIClqQ7eyvr7GCxA==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.20; Thu, 6 Aug 2026 07:56:09 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%5]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 07:56:09 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Xingui Yang <yangxingui@huawei.com>,
 "dmitry.kozliuk@gmail.com" <dmitry.kozliuk@gmail.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 "yangshuaisong@h-partners.com" <yangshuaisong@h-partners.com>,
 "lihuisong@huawei.com" <lihuisong@huawei.com>, "liuyonglong@huawei.com"
 <liuyonglong@huawei.com>, "kangfenglong@huawei.com" <kangfenglong@huawei.com>
Subject: RE: [PATCH] common/mlx5: fix high SMMU TLB miss with mempool alignment
Thread-Topic: [PATCH] common/mlx5: fix high SMMU TLB miss with mempool
 alignment
Thread-Index: AQHc+jsmG8Jt2a/HEUKhoLiTJ6CFwLaBKiyAgA/PFqA=
Date: Thu, 6 Aug 2026 07:56:09 +0000
Message-ID: <DM4PR12MB608738E64EC261C4CD6B9E19DFD22@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260612071434.2722918-1-yangxingui@huawei.com>
 <CAJFAV8xzvx8RtqpkG-KcRrbKGk+HPk0ms-=kFSLcDhO1KZkk-A@mail.gmail.com>
In-Reply-To: <CAJFAV8xzvx8RtqpkG-KcRrbKGk+HPk0ms-=kFSLcDhO1KZkk-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|MW3PR12MB4396:EE_
x-ms-office365-filtering-correlation-id: 0a84efe9-2ab2-4648-407b-08def3902d65
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: rO79EVRz+u6K8lhzSRexPgFQ6dAHRMJYfP31yr/H4B7jxpbt7hFKU0zh+bs873jMmdNFL3KgsB0kvnsrEgoJTEs69+bc/Ovjo8ji5j6+cAZjQghMR/bwvmav5bENtaNpw5jU4pw1zbcAcGbC8kLGv4Wr2zIczEegL+lecT91my22UA1dpYB3hQx3Zu1a9h1Uvhu9/GfRCmE3Eiw2Q89OKB4ruXP2p3GJ+qcy9RM7v3dGk+qvstMEl/8NjtedY/1i/+ocBIiZ8N4DIaFZpufOZ3dk0auLRyb/IbCN9FqhJ6WU8T6Lj+q6kGgBPOe4nphWZ1kjpdE23AZJt88/kwi0lgqN97aGJg9eItaBb667oQ2UuX4tbc8o78lrgYSoWnwx0QE11qvwTUImcKc9Tj1AgwlMARXi6EGFPnU6Ku9yryAdOvty0KxsEOsVqlnYtIGhHtg/w2TYMjTcfvHcDDrUqkyoJHoEWlteS29uNYQ+DJ77yCZGxANi9x/87vaa+p9GodGBK5we7o3KetEmq1nC4KiLdN+turw5oBQ5VHWRwaysN0bUP/WP4m8+vcuZLjLAj02qFFtqXLVO/QGMPWhk0xkW/46yvB1sedwY9xsdEmlHnMzhCx2idDnifP6OfsxZS1lsqfp2DBJQkpHyzbeRLyh2ZWKlSCSvRLScoiDJJfJ2O7e+WtrXX18mFXHzi2DSzc2fU9O/+NWeqJBnGjiYE2VsdN8V2H3dsmg8xtP3kXQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0NodzlVVW9NRGNWTlNseDNVc3J6bng4VDMzZW9PVnNDTDduSVNLQm1CaDZK?=
 =?utf-8?B?a2xUckt4UU53Vit1aHF5dEtodWsxSzNJVGJseXNpbXdyUlU5VnFSdytRUjlD?=
 =?utf-8?B?M2l4dDVTYm43bXp1V3FPTC90QStTanJQcjl3UGZWbFEzaTRhZCtuNFY3bGhU?=
 =?utf-8?B?bks1L3JidVgyeFNjeitiOTZJSHBQdW8yb0VaTko5MEU1VGYwYUpsWHZPeFVU?=
 =?utf-8?B?R29uSmVobEN6SWJEQUZlRm1YVmR4UWRkUllVQWRXOUF4ZVNxS1AxbkxoUElp?=
 =?utf-8?B?c3NNZlhMbFZzSFFRbEVpZVo4U2JnZzRvNFJuUEJadGFZd01TMDZUenZ6enpQ?=
 =?utf-8?B?UEIvaEJpY09sMFRqdkZOUmkzeGtvajluTjVoYTZZNm9YTU8rdnVDTVY4aldx?=
 =?utf-8?B?dEx2Q0NjV2NKNzAvOU1UYmZkUzE1Sml5eVAwU1hvdDl6YUxwRWIxTUNrb2Ur?=
 =?utf-8?B?NUxDbWppcnU3bXFoMVd4bU1GYnNzR1NQTDFvYThNaENSbDM4eDNMcC9malQr?=
 =?utf-8?B?TGxwY01FSmNkYkQzS01GdEkyaTNpVktERVFneG9aNk92amd0RjQ0WG9WNHN6?=
 =?utf-8?B?akxmTTduMUJ6RG1YUmwrMithNXdzeVB3Y3Z0eHpDRkRxaENrTDIxVi9FUUVm?=
 =?utf-8?B?dERGTG9idm1icVpMcG9lQ3BDb3VZYlkyRmhCWWVqcXgzNjkrTThWUUtmejAz?=
 =?utf-8?B?VTk4dTNnTGdIZHBpWWoxOGxWUWRHd1hJdUtOa2tCdHNNdW5wS0lFOVNjbUdj?=
 =?utf-8?B?Q3BkNkFHZ1N2bXp6K2VQSVFvRDVzK2lWRHRkNmdBckV0TGM3K202YnVaUjhl?=
 =?utf-8?B?UFRXUVI2UUhTLzVSUnFoSEQvbTltOGZZcHBGR201UnhiK0tVWHVVZjg3RHh3?=
 =?utf-8?B?YmhVbTNFVlFZdFJocmNudFdKK3l3KzFOTnR0SFViZTNZTG02TWFaUGZ0aFJ2?=
 =?utf-8?B?eE03ajV2M0lCb1FYenMwcXhEaGY5YzdWbXMvSUQyUHRmKzRwRmtHWDVidkYy?=
 =?utf-8?B?VTU3TEJ3SEcyV3Z4UG5xaVpEV1lnOGJ3S29xTTkvVFpPUTNQeksvZFU4VTFF?=
 =?utf-8?B?ZFZKcHZweGl2eTBPNDRJR2ZLNGVwMGxabTBWMFpEOUV3bGdyTTkrcE1DNW1Q?=
 =?utf-8?B?Rm9qZ2pKNnpaanNvQ2h2RHprSEM5NFo0MVhwaUFLSktHNVNhOGI5V01KaDJ3?=
 =?utf-8?B?em9QK1N0YStBOFJScHd2MWhyUk9pQmdwUXBpNUtOS2ZSVnhqVGpXT2hXV2Rl?=
 =?utf-8?B?R3BPRERXNHVrcmxUdzZ2UVR5M1FGOXY5TUZCandvVVU3eFpCY2NweTdPT3hK?=
 =?utf-8?B?RmFNQkx1bGI4K3V1Y3pkNWFEZEF1MWRWZDFMVTdUK3N0cW5mbGtidTRUenMr?=
 =?utf-8?B?YnBNVFJscVQyM09WaDAwZUw3RzI4c1NlbHQyNGx5cmI3N0pvZDRXRnF0ajZZ?=
 =?utf-8?B?VktWOUVqcWZmdkIvWUdqQVhwNVBtUzBOWnlTYjhoRy93K3FQOGNCR0RReFRq?=
 =?utf-8?B?VGwxU20vY3ZTMVN2ZWJhVjA4VTdldG5FelVnbXlnSHgxSzBGK3pXOGVka2RN?=
 =?utf-8?B?L21zR0lYeUpaNFhVSG9HM2oxZlFjcnpNWFpBVmNIOEMyWCs5M2tzbC9MY1dC?=
 =?utf-8?B?ODFxQ2MzN1BnUFo3V0hxQUErK0pUa3g4dm1pTmJ6L2ljUlkzbUMzbTZzNC8v?=
 =?utf-8?B?Z25zSjd0UUdDcnpPRlJuWjU1VlV4NEFBRERmdkk3cmxCWGs4TTdFdm9xZnU3?=
 =?utf-8?B?YXJlTEM0ZUIwN3YxMHhjelJRUGIvVGVQdUJnMmtCMHFVM21DTnFLUkNYL2xC?=
 =?utf-8?B?WGEvbTRlMU5NZ1RBNEhLdWgvR3NXTFY4WnB3ZWtKbTdPRm50VDB3VzVvV1du?=
 =?utf-8?B?cWYwZ0dCY1ljR3VKVHk1emZXeTFuNEFteUphZ3pVc2pmdnhBUXpsRFlhOGdN?=
 =?utf-8?B?M0pHczl3TmZLNFBWczFESjJqcDU4dHc1L2JDSUZ0TDFQckkzQTdISGxLRmFD?=
 =?utf-8?B?WHFJYUxhOVpoMG9ZVjBOTGpQVlpyaFAxaDRoaGVwSnlHVVNFbTNTMGcxVnJZ?=
 =?utf-8?B?OHRnOWtoRHVoZTlEaEh4akNsTlBIN21iYlY2ZVpzTVdQZEhha3FXc3RST1lZ?=
 =?utf-8?B?eXFmZG1keVZzeFBraWcrZUh5M3NRakxzUWVER0xsdm44YzBzR0loTXdTN2pT?=
 =?utf-8?B?Q2RGRjFWUTYvTnV1Ukd6a2U3VWlyUmNEbytoQ0xIcDloR0FETmFHclhIelJT?=
 =?utf-8?B?Z1Z2K1lTeDBFSmR1Z2ZrdEpKWTZTRzlUdFQ0c2FtOUpha2dlUFhML0QvK2tV?=
 =?utf-8?B?N3ZTT3dZbkdOME5rT3Q0eVM0cEhLblhJZm1YVEJ1dmp4OGpOQm12UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a84efe9-2ab2-4648-407b-08def3902d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 07:56:09.5278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U7pG/zyrwK8mqTDeyaLMylFKxUbEuNNsXrlYfnvr5Bk23SRk8LBU8tiKfzrM87nEkcxIliByCXsyvmkH+qX0YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
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

SGksDQoNCldoeSBkb2VzIGNyb3NzLU5VTUEgcGlubmluZyBjYXVzZSB0aGUgaHVnZSBwYWdlIHNp
emUgYWxpZ25tZW50Pw0KSXQgc2VlbXMgd2UgaGF2ZSBhIGJ1ZyBpbiB0aGUgY3VycmVudCBjb2Rl
IChhbmQgdGhlIHBhdGNoIGZpeGVzIGl0IHNvbWVob3cgKSAtDQp0aGUgbG9vcCAgIi8qIENoZWNr
IHRoYXQgYWxsIHJhbmdlcyBhcmUgb24gcGFnZXMgb2YgdGhlIHNhbWUgc2l6ZS4gKi8iDQpkb2Vz
IG5vdCBkZXBlbmQgb24gaXRlcmF0aW9uIHZhcmlhYmxlICJJIiBhbmQgYWx3YXlzIHJ1bnMgdGls
bCB0aGUgZW5kLg0KDQpUaGUgcGF0Y2ggbW9zdGx5IGxvb2tzIGdvb2QgdG8gbWUsIHRoZXJlIGFy
ZSBqdXN0IG15IDUgY2VudHMgdG8gaW1wcm92ZToNCg0KMS4NCj4gICAJbXNsID0gcnRlX21lbV92
aXJ0Mm1lbXNlZ19saXN0KCh2b2lkICopcmFuZ2VzWzBdLnN0YXJ0KTsNCldlIGNvdWxkIG1vdmUg
dGhpcyBpbnRvIHRoZSBjaGVja2luZyBsb29wIGluc2lkZSAocHJlZmVydGFibGUpLiBPciBzdGFy
dCB0aGUgbG9vcCBmcm9tIGk9MS4NCkp1c3QgdG8gaGF2ZSBydGVfbWVtX3ZpcnQybWVtc2VnX2xp
c3QoKSBjYWxsIGluIHNpbmdsZSBwb2ludC4NCj4gICAJaWYgKG1zbCAhPSBOVUxMKSB7DQo+IC0J
CXVpbnQ2NF90IGh1Z2VwYWdlX3N6ID0gMDsNCj4gKwkJaHVnZXBhZ2Vfc3ogPSBtc2wtPnBhZ2Vf
c3o7DQoNCjIuDQo+ICsJaWYgKHNhbWVfaHVnZXBhZ2Vfc3ogJiYgaHVnZXBhZ2Vfc3ogPiAwKSB7
DQo+ICsJCXVuc2lnbmVkIGludCBvcmlnX3Jhbmdlc19uID0gcmFuZ2VzX247DQpObyBzZW5zZSB0
byBydW4gdGhpcyBjb2RlIGlmIGh1Z2VwYWdlX3N6IGlzIGVxdWFsIHRvIHJ0ZV9tZW1fcGFnZV9z
aXplICgpLA0KYWxsIGFsaWdubWVudCBhbmQgcmFuZ2UgbWVyZ2luZyBpcyBkb25lIGJ5IG1seDVf
bWVtcG9vbF9nZXRfY2h1bmtzKCkuDQoNCjMuIEFsc28sIEkgd291bGQgYmUgY2FyZWZ1bCBhYm91
dCBleHRlcm5hbCBtZW1vcnkuIEFsbCByYW5nZXMgYXJlIGFscmVhZHkNCmFsaWduZWQgdG8gdGhl
IGNvcnJlY3QgcGFnZSBzaXplcywgc28gbGV0J3MgYWRkICJpZiAhaXNfZXh0bWVtIiBjaGVja2lu
Zy4NCg0KV2l0aCBiZXN0IHJlZ2FyZHMsDQpTbGF2YQ0K
