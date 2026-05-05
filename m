Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AF7CD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 16:05:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FEBA40664;
	Tue,  5 May 2026 18:05:16 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
 by mails.dpdk.org (Postfix) with ESMTP id 0BAA64027F;
 Tue,  5 May 2026 18:05:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrxzKgk6piXDnoFj1KiFFH0mJKWKzxyjyGWta0XxkBUroBVoBh56+IFy7vqJoVsyWch3CUh4J6anZMVVPimrdPiRrx4FNA/PY5Wo9TpxDuTHf8Wtmyn6ymISWXVxryq3S6/MNRH+vvYET2feCI/XiF/oFgCY2TSo5e1D9Jbi0q5+HRAu1MA4YN/PGoXhHnIdGmKrzYSd3cs0wWK/WwZ6gR3GGLvNvS0i3iZmHHzwS1isWKjIy9NvTwVuiZQ9ScolZr4FyjfoqZO3Wd4Ko0ueCT4YeeWlXnVBwSK5CmfZVvoHmVTiJH3s1xv2ab99W6+PMQ1gkksNtBhJXzv6NdMt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OliAmV3FdYufXup3rGMyYg/pyxTh0YDhP8Ga+ZcaejE=;
 b=SPueCW+T4O5HNiHgg/fGqNylIwscVAiiIJP7PM8H2qL+as7gVulS9OlbP56KlSzRgr0NjaZQ0xrLAzQAzeOxfYdXIOvtc0k5nUkIPcZX8lqSPwhpk223FKx3vYQQjFFM334DATwuUJ8hg2hr01Td5GSz20gwXKtiH2SMMX+qzQOmAPB9ZX/6yw+YJV7Sk93IDYEn75WJY3zfCd+p7lrmca7zI5WyZ3Ys9z86sVH7wP3QlzjXPneUhH56aSucjNknsIakHKFh1xo/T7ucz9+WI6Pt4XMsc5ZIoESmMmu+hKWwfevmfageBi9WYgi72BA4WkGRVRAUChuwM8ly+h7RHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OliAmV3FdYufXup3rGMyYg/pyxTh0YDhP8Ga+ZcaejE=;
 b=UdNLiWMcTKmiji1rwiR0LX64G41h7rqRdDAcEA2VTJAhlssbHPdwgDox7r7ydjtmav73Hpu7M7LwIkIa/qBjPdpNXEFbyPi8yMqrp4MejUSkXPJ7A8nvMfgnmjgRFqD0owguKhRQpciQ+wSUflTAxcX/xkBwg650kKEjAKzp/8ZT14VA5mBrAq7I+InJZ5vjM1h7vloHNDTj7eseg/yehfmVtCa+aijQFM/YgRUk/2Y3Y7utnpS/zTRefy1dEhwdisMSITSZsVo885JSgYyoj9Rp/5sxX0SiewOFZID4s5keD9TmkZDQjwS2Kq8h/IE6XWXUyB75+csjHewW6Nq8Sw==
Received: from IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 by SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:05:07 +0000
Received: from IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::b2c3:ee20:6aeb:7f6e]) by IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::b2c3:ee20:6aeb:7f6e%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:05:07 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: Ali Alnubani <alialnu@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, "benjamin.walker@intel.com"
 <benjamin.walker@intel.com>, David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 "qian.q.xu@intel.com" <qian.q.xu@intel.com>, Raslan Darawsheh
 <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 "yuan.peng@intel.com" <yuan.peng@intel.com>, "zhaoyan.chen@intel.com"
 <zhaoyan.chen@intel.com>
Subject: RE: 23.11.7 patches review and test
Thread-Topic: 23.11.7 patches review and test
Thread-Index: AQHc0VqZIgFPFkllCEidwxNFPHjfIbX2YKOAgAlOVtA=
Date: Tue, 5 May 2026 16:05:07 +0000
Message-ID: <IA0PR12MB8422A5805C019DD913FDF5B2BF3E2@IA0PR12MB8422.namprd12.prod.outlook.com>
References: <20260421064637.2506152-1-shperetz@nvidia.com>
 <c7db1005-ef22-4e54-a09d-474d6cee77b6@nvidia.com>
In-Reply-To: <c7db1005-ef22-4e54-a09d-474d6cee77b6@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8422:EE_|SJ0PR12MB5635:EE_
x-ms-office365-filtering-correlation-id: fa5a7f19-60ee-4dfc-e736-08deaac013a4
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: i1lQgotpzVxgZR9R0OwAhY68ewesgFkEqruqIJTCq8z06MXZCxrZn8R+7VZ93wTknQ1vfOoFh+sRmKfFxfij59ROYpU7Pce5Hwx3OXC+BtW1g0aIkK/xbSixxuGt5DYPXg6tE7EIC05Ns2VJBtL7o3mwLkb0P8XuhM5c3w13nktxOMCsixcKIXzeMfLxi6aDTDDl6B9ZxO1maPEmroyvSokAWQB55Pb4h3kPM4UkiQjaqBsGgJiyc17Om3BQuJREVYM5G4KBwh2EZhZo4/7Rui0NYTWUMFJOyeCwJ6jrZprjh6cYEPjjlUjzOjL6ItCs8Af6XrJ5/HHxXMQcisJK1Rxqdm+aXHRnbJpqcNZt8Lq9guRPqWCpB1EkJVomXkYFq0ExqmCHtCAZGiPBjKbh0IO5n1yFTELaoYFLErJMW99o+WbTtnUqF1QgmSx/oGLUxJI3OniJ5mfHR8BWojtv/LIeKcrYlNwSAr61gTYvSHAJNRQCf3mbZCi7zKCthehuTX2ZkOw+rjH+RSahEWchB8EAITnuFXwJi5fzNV2+KBjyLgca5HQB1w2PpbKNAEEW40w1WfzGpnbkFmwGNn5MNtqNc5/uw1dKzhq425ULXoXekLyLkrAUiglIKVmVar+ClwHhnvHudWMlwFPEoz6UpbLaZ2KTnHWkbVOs0mwKSU2ataw0dKhJzwF7CYqZFhvfNFBPoLm1GszMBHmlq9Y4PpxRzr+mSqpKK2XpcFHLJC2YIABOKxlt50xN2MSq30Mx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8422.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFRqTlZmZVhvSml5SDlzbm4yV0ZPd1dKd0xaZnYzVlRqTWlJQ01JdWVrYVhU?=
 =?utf-8?B?TkJ3S3kzbnpNRmtJblBIeTNVRGIzcHV0RHBlb2VuMDliYWRMQWROODNBdDJQ?=
 =?utf-8?B?NmVYbDdYWUsycmlxRXNrZUVmNkFUT0pNamJpQW5hRWk5bDBWME9KR1o1TUdZ?=
 =?utf-8?B?MUlqTVhVTjdhZjFqUC9qQ0YybDQ5Y2lzd0lkQXM5M0hpYlR5YmxobkoxYUNQ?=
 =?utf-8?B?aVBSc3J1Q2lRb1JhTERMb2M0VnlQZ1hqd0JwSS8rak5HYlpPZ1VIVVpHSUpC?=
 =?utf-8?B?dXc2bU1PV29DaG5rU2F5NEJZTFN4YmgwRUE2L2l1UnJwa2c4aVYrVGFzWjlT?=
 =?utf-8?B?Y3BnaTZvSDFjeTNnRFdJZlU3OVoxV0ttS3o3WUYzc1pMRURqdU5wdjBHMHVR?=
 =?utf-8?B?a2dUQ2xPeDZJVnRad3ZZb3VGemd4OEJnUVJhUHZoTm9tdmk5M3F5QzNhVVNP?=
 =?utf-8?B?M3R2T2dqRVJmSW4vQmxzNjIzdEJhdkU2ZmFGWENTVW5qR1pqN1VyUGJ6bllF?=
 =?utf-8?B?VlR6ZEJ1V0tuKzlkZXV1QklkMFlyU1k4UzdZSkJrUXdScmlkVDg0WlVJbEZu?=
 =?utf-8?B?NmFZaVpjUk9IbTFwaUNpMk1naE5BcWwvdUFjVDFKN01kb3hOMzBEa1FvWkNP?=
 =?utf-8?B?V2Y4TkpOc1dleGpiVHRMVjNSVXpUZDRLZnBJQnloZHdDdWtXakc3SzVqUDF5?=
 =?utf-8?B?Q2xNTURXVUFXOGU2WFhoTVlSZll2M2J1YUlKeGg3RXZ3U0NmWisxUkVQU242?=
 =?utf-8?B?OVYxZUw0Rkx1RnFGMzlPRjBOcHdKYXd1eGZLR2F4Y0RCV2NFdjJwUHBvMW9y?=
 =?utf-8?B?VndHQ2NGNWk4VHdtM3p0QjFKSGVzL21wUy92WHhZWHhSa0FkVi8rdTRYTUlF?=
 =?utf-8?B?bHJGb0ZXbHlDRzB1b1BoZERIM24zblp3TDc3WVU3MGhyNENITWdySVZ5Z2Za?=
 =?utf-8?B?a25SZzlvUHJWdk5HeFVsQkxmTEk1MUZKTXJ4MEVNVDRYUEpEN3ZianRDeFpK?=
 =?utf-8?B?R3BtNlJrdXdQWXJwYjkrN0xkdG4waCtpZG1WTUxYNnBjUjZ4TisxbWhTamo0?=
 =?utf-8?B?RE8rd2czWjdldldiWU45TEtVOWM4Qll2VVp1QWxCTS9mbUxtemRIOXVRYUYy?=
 =?utf-8?B?ck1YQzJTR2lFYllPU3oxTGxaSUFhV0ZGUGp4MmtDaG5uUzNoT0VsdmVrUjJX?=
 =?utf-8?B?TitZTFhWWWcyM3Y5MWZhVDdRSHpTUVhIbFZrM29nOWFMRlJwN1FQa0tzN3J0?=
 =?utf-8?B?TW5aVEtyTEpoa1NnSjd4RDNVaTUwMkVPREdyaWxSbnNOWnRSMWsvdHZ5djRY?=
 =?utf-8?B?Z2J5QWRRQi9QUWlrNHNSTlExVDZvcHlUQkRWcjBUMEl2bDF6clBmSStVV2pa?=
 =?utf-8?B?YmtHVUJtbUhaRkcwUjYxb2lNV3dZKzFWSFlESnFGaWI5Q1IxcXBJZUlaZkdk?=
 =?utf-8?B?UzNRdGRwYkc3aDZTdEtTYkhpbnVyamhWZ2dmVm41L2RmSW9SNzIwSndCbnFk?=
 =?utf-8?B?dGFGbXRHRGNCZ2ZNTm1LODZOZDJoUVNQVVVGLzNmQ0JKV2JQOEkyKytFdnEr?=
 =?utf-8?B?UGlpVE9kcmcxRnJBTmFsZUVGaStQeDFYMURZTWtocTZHK0x2RDhrQ1FFa1Zq?=
 =?utf-8?B?VHIxZzNVWnNncGZTNDU3QVNrOE5uTFhNcXNVN0RRZGdpb25WQ2tCYjNmQ0Mv?=
 =?utf-8?B?S2RtdHpvbi9qankveHlzeG5Vcm9oclBpKy96R205bzJ1WHBZczlWUTNhQjRM?=
 =?utf-8?B?cW9qaXpHYUo0aU40a3ZsV2VheVlBOUM5eW5oWGFUcUlnc1ltU1JGc21ScUtu?=
 =?utf-8?B?Z0NSSG5oSDZ2QzhpUGsrR2RKSndiTE9WNUhRTlBKZkswRlRwbXJ5MjFuSzZE?=
 =?utf-8?B?Q2JCRjZOVXkwd2NmQmY3WUlsM2hPYU9Va1hMRklTTjBrZmhTejViTjU5aGw4?=
 =?utf-8?B?OUtPbUwzU2w1SXBHa2hKYmNNdnY2K0htdWVqMFdhbW1CK2FDaTJJenNGVXBB?=
 =?utf-8?B?MlRmV0VwdmgyanRyOXM0Y3NMYVBiYTdqNk02V3lQdW1EUEt0WEM0R3ZJd0oz?=
 =?utf-8?B?YXlxb2RuejhvNld2ZWIweU9oQnJDNlZFbEN4UExxalpwdVNERFJFelpROEx6?=
 =?utf-8?B?Zy9wWWVoWmI4bGw4NWYrS3FRc2cxOUh2QTNFZEFXOWhMVE94YzVEcVF3WXVq?=
 =?utf-8?B?aVlLbXJZWjdFVUVsdnRtdUJLOC9KWWVLVWRodnYrNVBPWnEwNzRwM3p1NmNQ?=
 =?utf-8?B?YUxBcjFXU1hJMEJCck5mVFdhaHltRjBSWlIyUHhkd21raWxtN0YvTERaK05k?=
 =?utf-8?B?RVB0enBYcnpRTzFSYTREZ1B3aXE5a3lpOExhOTlYZGpBNGp6MlBBWEJYcU9D?=
 =?utf-8?Q?1iZ3wH7m/BLIGxzhxVH6pG1wkecpUY15UggRe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8422.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5a7f19-60ee-4dfc-e736-08deaac013a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 16:05:07.3138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /W7fANbH5UT1jBILCQaUZcH49qsbJWB+IRm4HHKBiuvANQPQdRtkh44CaZAbjZsVcORK6KaXDA5gySCQ9Df62A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpIEFsbnViYW5pIDxh
bGlhbG51QG52aWRpYS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgMjkgQXByaWwgMjAyNiAyMDo1
OA0KPiBUbzogU2hhbmkgUGVyZXR6IDxzaHBlcmV0ekBudmlkaWEuY29tPjsgc3RhYmxlQGRwZGsu
b3JnDQo+IENjOiBkZXZAZHBkay5vcmc7IEFiaGlzaGVrIE1hcmF0aGUgPEFiaGlzaGVrLk1hcmF0
aGVAbWljcm9zb2Z0LmNvbT47DQo+IGJlbmphbWluLndhbGtlckBpbnRlbC5jb207IERhdmlkIENo
cmlzdGVuc2VuIDxkcmNAbGludXgudm5ldC5pYm0uY29tPjsNCj4gSGVtYW50IEFncmF3YWwgPGhl
bWFudC5hZ3Jhd2FsQG54cC5jb20+OyBJYW4gU3Rva2VzDQo+IDxpYW4uc3Rva2VzQGludGVsLmNv
bT47IEplcmluIEphY29iIDxqZXJpbmpAbWFydmVsbC5jb20+OyBKb2huIE1jTmFtYXJhDQo+IDxq
b2huLm1jbmFtYXJhQGludGVsLmNvbT47IEp1LUh5b3VuZyBMZWUgPGp1aGxlZUBtaWNyb3NvZnQu
Y29tPjsgS2V2aW4NCj4gVHJheW5vciA8a3RyYXlub3JAcmVkaGF0LmNvbT47IEx1Y2EgQm9jY2Fz
c2kgPGJsdWNhQGRlYmlhbi5vcmc+OyBQZWkgWmhhbmcNCj4gPHBlemhhbmdAcmVkaGF0LmNvbT47
IHFpYW4ucS54dUBpbnRlbC5jb207IFJhc2xhbiBEYXJhd3NoZWgNCj4gPHJhc2xhbmRAbnZpZGlh
LmNvbT47IE5CVS1Db250YWN0LVRob21hcyBNb25qYWxvbiAoRVhURVJOQUwpDQo+IDx0aG9tYXNA
bW9uamFsb24ubmV0PjsgWWFuZ2hhbmcgTGl1IDx5YW5naGxpdUByZWRoYXQuY29tPjsNCj4geXVh
bi5wZW5nQGludGVsLmNvbTsgemhhb3lhbi5jaGVuQGludGVsLmNvbQ0KPiBTdWJqZWN0OiBSZTog
MjMuMTEuNyBwYXRjaGVzIHJldmlldyBhbmQgdGVzdA0KPiANCj4gT24gNC8yMS8yNiA5OjQ2IEFN
LCBTaGFuaSBQZXJldHogd3JvdGU6DQo+IA0KPiA+IEhpIGFsbCwNCj4gPg0KPiA+IEhlcmUgaXMg
YSBsaXN0IG9mIHBhdGNoZXMgdGFyZ2V0ZWQgZm9yIHN0YWJsZSByZWxlYXNlIDIzLjExLjcuDQo+
ID4NCj4gPiBUaGUgcGxhbm5lZCBkYXRlIGZvciB0aGUgZmluYWwgcmVsZWFzZSBpcyAzMCBBcHJp
bCAyMDI2Lg0KPiA+DQo+ID4gUGxlYXNlIGhlbHAgd2l0aCB0ZXN0aW5nIGFuZCB2YWxpZGF0aW9u
IG9mIHlvdXIgdXNlIGNhc2VzIGFuZCByZXBvcnQNCj4gPiBhbnkgaXNzdWVzL3Jlc3VsdHMgd2l0
aCByZXBseS1hbGwgdG8gdGhpcyBtYWlsLiBGb3IgdGhlIGZpbmFsIHJlbGVhc2UNCj4gPiB0aGUg
Zml4ZXMgYW5kIHJlcG9ydGVkIHZhbGlkYXRpb25zIHdpbGwgYmUgYWRkZWQgdG8gdGhlIHJlbGVh
c2Ugbm90ZXMuDQo+ID4NCj4gPiBBIHJlbGVhc2UgY2FuZGlkYXRlIHRhcmJhbGwgY2FuIGJlIGZv
dW5kIGF0Og0KPiA+DQo+ID4gICAgICBodHRwczovL2RwZGsub3JnL2Jyb3dzZS9kcGRrLXN0YWJs
ZS90YWcvP2lkPXYyMy4xMS43LXJjMQ0KPiA+DQo+ID4gVGhlc2UgcGF0Y2hlcyBhcmUgbG9jYXRl
ZCBhdCBicmFuY2ggMjMuMTEgb2YgZHBkay1zdGFibGUgcmVwbzoNCj4gPiAgICAgIGh0dHBzOi8v
ZHBkay5vcmcvYnJvd3NlL2RwZGstc3RhYmxlLw0KPiA+DQo+ID4gVGhhbmtzLg0KPiA+DQo+ID4g
U2hhbmkNCj4gPg0KPiA+IC0tLQ0KPiBIZWxsbywNCj4gDQo+IFdlIHJhbiB0aGUgZm9sbG93aW5n
IGZ1bmN0aW9uYWwgdGVzdHMgd2l0aCBOdmlkaWEgaGFyZHdhcmUgb24gdjIzLjExLjctcmMxOg0K
PiAtIEJhc2ljIGZ1bmN0aW9uYWxpdHk6DQo+ICDCoCBTZW5kIGFuZCByZWNlaXZlIG11bHRpcGxl
IHR5cGVzIG9mIHRyYWZmaWMuDQo+IC0gdGVzdHBtZCB4c3RhdHMgY291bnRlciB0ZXN0Lg0KPiAt
IHRlc3RwbWQgdGltZXN0YW1wIHRlc3QuDQo+IC0gQ2hhbmdpbmcvY2hlY2tpbmcgbGluayBzdGF0
dXMgdGhyb3VnaCB0ZXN0cG1kLg0KPiAtIHJ0ZV9mbG93IHRlc3RzIChTZWUgaHR0cHM6Ly9kb2Mu
ZHBkay5vcmcvZ3VpZGVzL25pY3MvbWx4NS5odG1sIGZvciBzdXBwb3J0ZWQNCj4gZmVhdHVyZXMp
DQo+IC0gUlNTIHRlc3RzLg0KPiAtIFZMQU4gZmlsdGVyaW5nLCBzdHJpcHBpbmcsIGFuZCBpbnNl
cnRpb24gdGVzdHMuDQo+IC0gQ2hlY2tzdW0gYW5kIFRTTyB0ZXN0cy4NCj4gLSBwdHlwZSB0ZXN0
cy4NCj4gLSBsaW5rX3N0YXR1c19pbnRlcnJ1cHQgZXhhbXBsZSBhcHBsaWNhdGlvbiB0ZXN0cy4N
Cj4gLSBsM2Z3ZC1wb3dlciBleGFtcGxlIGFwcGxpY2F0aW9uIHRlc3RzLg0KPiAtIE11bHRpLXBy
b2Nlc3MgZXhhbXBsZSBhcHBsaWNhdGlvbnMgdGVzdHMuDQo+IC0gSGFyZHdhcmUgTFJPIHRlc3Rz
Lg0KPiAtIEJ1ZmZlciBTcGxpdCB0ZXN0cy4NCj4gLSBUeCBzY2hlZHVsaW5nIHRlc3RzLg0KPiAN
Cj4gVGVzdGluZyBlbnZpcm9ubWVudHM6DQo+IC0gTklDOiBDb25uZWN0WC02IER4IC8gT1M6IFVi
dW50dSAyMi4wNCAvIERyaXZlcjoNCj4gTUxOWF9PRkVEX0xJTlVYLTIzLjEwLTYuMS42LjEgLyBG
aXJtd2FyZTogMjIuMzkuNTEyNA0KPiAtIE5JQzogQ29ubmVjdFgtNyAvIE9TOiBVYnVudHUgMjIu
MDQgLyBEcml2ZXI6DQo+IE1MTlhfT0ZFRF9MSU5VWC0yMy4xMC02LjEuNi4xIC8gRmlybXdhcmU6
IDI4LjM5LjUxMjQNCj4gLSBEUFU6IEJsdWVGaWVsZC0yIC8gRE9DQSBTVyB2ZXJzaW9uOiAyLjUu
NSAvIEZpcm13YXJlOiAyNC4zOS41MTI0DQo+IA0KPiBXZSBkb24ndCBzZWUgbmV3IGlzc3VlcyBj
YXVzZWQgYnkgdGhlIGNoYW5nZXMgaW4gdGhpcyByZWxlYXNlLg0KPiANCj4gVGhhbmtzLA0KPiBB
bGkNCg0KVGhhbmtzIEFsaSENCg==
