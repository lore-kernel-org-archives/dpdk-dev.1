Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBFBF43683
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 09:55:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FD12402B0;
	Fri, 17 Apr 2026 11:55:35 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by mails.dpdk.org (Postfix) with ESMTP id 56DC9402A7
 for <dev@dpdk.org>; Fri, 17 Apr 2026 11:55:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxxVYMvWke4U5kmWOiDerYsHY66Bjatgvcl7YtBw1mLOVfcJAoq/oSjie/kWV8h7Y/guDEKXp2HdhbfiZbwcWo4P55pt5lasqq7QSqvgC63gnft99XsxhCLYxSC1G7wSqTrxZg9Nb869qJuNmVIDzrc8W8rADff1qiWiDr0+Kp1QYublT4XJuDhjNGRmt66hk/lv3QVHSM3hFpG2UsF7e9ecbbZdubBtn4gUL2pdI/crNSu4yUEXUPbR+0zhSRq42hnJggT/arvT5zJMAKyeVjtP33m/Rlhvz4r/eme9gHsY/V5DV3WpezVmh7mJW7E01QBos5/w2VFqZO+kYxYVFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwKHrYYXXGezJaFjZ2qesXgBKa28flWxsmpl6qCmvSA=;
 b=JZ5h9fbUkmA8FEnY6/CFtGvCwDuaxkiqI2YPiU/p6n49gZ0C+Ptpk0/csD41iRZZfRbMxbtzUU5YN31jHMzZaA0zz9xUCSJq8WN96W7maG7qkKxOP5/m0v14qc+OhRHUWS/0WZMK/HFRo4SU5u9TBI9lqM0tEoF1pTU0p45stpFJAYCBe7Y1Pa2W41xijR9q75TxSczqyfF4bUlReCTKxS8Dft7swD1MbdYlG0AoDb98eyIeDTy4Aj1aS27MFEtr9h25sIx5XYGYRFAYf5+JouvMM5RIwR7EgxTRpw6bmGm9WL3nnDEjH4MFCw67Brwz6db7Cq2I0McHoGVz9XQ6vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwKHrYYXXGezJaFjZ2qesXgBKa28flWxsmpl6qCmvSA=;
 b=p6122Pf0maHBNAWXgfAORAFmPqroqU7RgW4CsQAaucf4rWYW8erA8gUc3xnL1/Mbgk2PiSrNfefKBywcx3KVClWu/gV60BLBQ+f00ZofZlG9HMK30Sttdaj6RFSSo/OJEC9p8BRJpk40oidsMeP41IQ2HqYIJhEr0LamjPBGFP8=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 09:55:31 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 09:55:30 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: "giveback4fun@gmail.com" <giveback4fun@gmail.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>
CC: "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "wathsala.vithanage@arm.com" <wathsala.vithanage@arm.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "viktorin@cesnet.cz" <viktorin@cesnet.cz>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>
Subject: RE: [PATCH v5 v5 2/3] app: add topology aware test case
Thread-Topic: [PATCH v5 v5 2/3] app: add topology aware test case
Thread-Index: AQHczEan2CVlJsJLuUK0NGxNpAvD+bXhSnKwgABjhRCAAMo6AIAAQrUAgABMqnA=
Date: Fri, 17 Apr 2026 09:55:30 +0000
Message-ID: <PH7PR12MB859665B5A33CB07D7634443C82202@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <20260414193850.1696-1-vipin.varghese@amd.com>
 <20260414193850.1696-3-vipin.varghese@amd.com>
 <PH7PR12MB85969978BB6EB2C2E9034A8E82232@PH7PR12MB8596.namprd12.prod.outlook.com>
 <PH7PR12MB859644299B4823DD03A125DD82232@PH7PR12MB8596.namprd12.prod.outlook.com>
 <PH7PR12MB859698AFEFF656FD908A729882202@PH7PR12MB8596.namprd12.prod.outlook.com>
 <c0451147f1b2b7ba217c8e770e806e4a45f3e374.camel@gmail.com>
In-Reply-To: <c0451147f1b2b7ba217c8e770e806e4a45f3e374.camel@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-17T09:53:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|PH7PR12MB6934:EE_
x-ms-office365-filtering-correlation-id: d65a5e16-e703-442e-af1c-08de9c67760e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: qjWVCPQx4UPN80MVEJYz3AbfavZss9KNf0MG3xGPvfulX5ZN459MnvO1EBC0+jIPuMvxj/LFtC5YaqWs6wKzT5umQXzP9LvxKwmI+nW3rG/BJ/g+PQNBld2wHi3NMIJofM5DZTo6PBVqoMViZB0czGtgNpAX7xzuOKjqv57/kzkf2yTUv/pEJ7OaqPSyD/PsV6FaMFBVLmGARE8mBRU9qMGPewGlfDSrpVbCaYy5q5JZPUFxgH7WIN2TOoGxprOgipHb7eCdyXt/mV5rdiT4M9/AF7WNuyb/IsQEwibcglfkJb11t1/ck4JML3hAAEl8V7p1TLJNwm9OR7XaH9EJhvmd/wi7oW8ufyESytg2F+nLtRCdqJw8XzOP+Uvzv9yavHRwdYIROa2NJb6rVKyUzCgE3eZ/qI/nJxyajCkFiHrlIh6f6dbLLJ2EWQUvJ/3WfDov5EuzdVQcFcs4EYXklZZuDV0Eiq8QFNPvObxsBtvCptzA0O2wPvaGzxwr6JvFIKiIhRuDAPXB6R4lXDa5xLHXw6KDmlY2h7ozEqrsg2V0QVoz+xLVTvEiw32/fK8CZJ5dSLrQhfeskpOWhR7JdwRL5DToWhqd4glRgs4jH11o7Inb2+NMiTPebUoyp/5uOQY0asqxxSn+V5sKnzASi8We5XceW+Bn1GGhu3/MCqp+LeJpwFo1D7smdoPbKgAAV3YHgwEqFGVDa0STbuVVZMZfGuODZ321b2fB+PoH8An2zu4CkwcFiYDsTZ3T86NfmzLQ7PponYwJmv5CZnQUJz/X0+t4SA36XkLApc3yM/M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2hKUmE0aWFoamVCYk9jYjlXNXMvbzlKb0pnSGJLbE1LS3NjZmo4T1ZuMHFS?=
 =?utf-8?B?NTIvVUYxb2RiSThVY0dIZmV4Vk1VdkNIbGtqamhsSklJMnQ4TmQ3STNNSGdY?=
 =?utf-8?B?V1RvTE1PNFEzSHJ4dm5WSUx0L24rMUZZalloUVNEdVVmRGJlT0Y5M0FLa2U0?=
 =?utf-8?B?NnliOGFxRDdSa2RteFRXYWtSYzN3OFpjL0ViRTUvU01YTG5xd3A1cHdSSFRx?=
 =?utf-8?B?WTlKYXlDM0syODVHNXJWMHp4Yk83aGJtMDFIRzRRcmExSzk1NVdMYjFLVEps?=
 =?utf-8?B?N3ZkTVQ0U1F1dnVBV0J3c3IveEdRYzBJbDlDb3ZMdUEzaFpocFk5NURVSDZs?=
 =?utf-8?B?Q1ZNWk9GWG9pMlkwVkVSOWtaaWdtbHAwaCtOQkF6SkZHenFIdUl3MlorSlhG?=
 =?utf-8?B?TDB4cFdPZUhuQkJFdURQMkFJQXNmWjRwdFF0OFFuSVVhN09tRTNHWUlvUmto?=
 =?utf-8?B?dE9rNFhlK2tRK3JnQXBJTmZubkgzQlVPeGMvMXVZNTMyRGUxcHdlM0xWZGFw?=
 =?utf-8?B?d2RYbFVCNlgvVFpoVUg3aDRETGNtU3JvTFEzU3N3OG9UWFN6ZFBFTjVid1lM?=
 =?utf-8?B?d2U3NmdjcFVoWFg4TGpLWnM5MXI1SnlkSW40eFI3VXNyZDBHTldtaXFCZy9S?=
 =?utf-8?B?cWxCeGdYMzlxWmNBV1hDbWVIVmlnU1FxV1o3VjRaaTZTQnNudzFDSmpYQTho?=
 =?utf-8?B?cHV2Q0grY0ExRkFwWlFIN3RCUE4wb1hxclUvUFVoMW9xdXBBYSt4UE1MMEkw?=
 =?utf-8?B?NUlMMnZxVnczUCtJRVZOY0ljUXpmYXlhb1FlOFhrLzdNRHVzcGNrNmhwNWpY?=
 =?utf-8?B?d21XRCtTcGhNRDhqb1RDTkxuMlBORCtVa1ZKenNsdUxxVWMwckZSR1VYRldy?=
 =?utf-8?B?VTlISGhOZVBCdDVQQ0hLcUhNc2pNZUlNM0JJdnVxc2k1cXlGL3cyUndpRGph?=
 =?utf-8?B?TVNZdmlyd3BMeTNaNWZCcURGdGtUUndaSHB5b2phalIzUVVGeldzaXdvSVkw?=
 =?utf-8?B?RVFNTXltMkhHTHptNXhXUHp3dHowcldYZHFFdHNIanR1Y3RzOVMrdlB4K2Zq?=
 =?utf-8?B?QTN2a2JSY29DRVg4YXRmK1hSTCtDRGNtYUJnUGVEZ2hUcFBtZjdaN2tZcWc0?=
 =?utf-8?B?VWpHQWFuTnZtMHJ2c0NzYnZnb2R2WGxKL3diOGl1clMrR2tNQWlOL09jejRL?=
 =?utf-8?B?YXI3am5BY1Q4Tlh3bEZLMDNPeTdrbFRBVW0vTTdEaWVLSkRwSVk5VnYxSWtI?=
 =?utf-8?B?NmRWNjlueUtHdGs0Ni9TTVZWNjZTcW1GRStURG1mTHo2cU90aGtKYnpwMEMv?=
 =?utf-8?B?QXBFVFQvRGpSWC9hekVXMmxoQi9ReXM3SlBCUm9jR0VuSm5LbmxkWEJreVhK?=
 =?utf-8?B?aFhtMEhOVCt4aFJ4TlZqUlNkWmJSc2wzVUxrUm85aGJudUV3TVk5Q2Y3aGNr?=
 =?utf-8?B?ZEhBcXFIOEtZOUM2R3ZnYnZraG16Q3pBOUtLWTlIUjhNeFIrTTcybXhWY2w5?=
 =?utf-8?B?UTQ1MGN2R1VjWngyNmYyZG1Vb0UyWHh5bmFRWnZVQU9IZ0RQOFh4bk1tMUFO?=
 =?utf-8?B?VWlJS3FLN3hYZ2dPZkxkUExaUVp0eXcvREsyUWQ4MldwY0ZYRmI4R3Fxa2Fh?=
 =?utf-8?B?RWVWMi81RVhkYzBBK0JWV1p6UHNJR000VW54MEhiUzRzMk84ZGFIbDAzbVBU?=
 =?utf-8?B?UGc4d2kyZ1gvWlhMK2lVSC9KNzloRmVyTEdqdXJpTVljcktTdW1zc0orVE5t?=
 =?utf-8?B?dTNnSDFadzlnRWZ5Z0taTG9LaWZXNGRBYkJaRjZOUVp0Ti96TGhOSTkyOUdK?=
 =?utf-8?B?YzJ1QTk1R0JsTVV6WEZRSWVIWWpYREZRaXNxZ2hZZXdLM2lNTFhNNkdPaGxX?=
 =?utf-8?B?SzMzVDhzelAvL3M1RG8wY09HZ3g4VStTWWFRcGpsUzlzSzBNSDhOdUxTdnRs?=
 =?utf-8?B?ZFU3cTN2dUR4RWJHTHAxbngwOTBFd0hqMHpsdWk4a01tZitQUE9XUnlUdG5y?=
 =?utf-8?B?bWNoZ1lZVjNZQkxZRnd6VG9XU0ViVzRPaldhVXNaOWx3YThyMVFMTmNCY2Rl?=
 =?utf-8?B?N1pVaG0vRm5pZjJQR0xPWFJQNDhac2tuQXMwL1hwSzFRWW1YNGliVCtXSHND?=
 =?utf-8?B?Mm1lSWI3S2JKaXg3Sk1hV29JbkVhYUc5QUFEUnFYLzJoc3gxU0F5N3B0ME8w?=
 =?utf-8?B?d2NmWDREaEhSb3N4d04vYmNHYzcvT1pnbjZoT2F2QmpwMjEydHo0T3FuNUpI?=
 =?utf-8?B?ZFJ3TUhJQUJOUjhVZXhTcTNlUUVlOFhqZ295Qm9rSUJtQ3h5aXgxcVRPN3BR?=
 =?utf-8?Q?AcuxhCcKyqQZETe65C?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65a5e16-e703-442e-af1c-08de9c67760e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 09:55:30.8969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xw/d18KnArkmTbifaAdeJ9B2IMmSJPU9XZVYrJ4YJ9UAcP48KmIKiuvpEsmceAf5ZeSZ3wbHfId5CZASsHSF+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPHNuaXBwZWQ+DQoNCj4NCj4NCj4gSGkgVmlwaW4sDQo+DQo+IFBhcmRvbiBteSBpZ25vcmFu
Y2UuICBJIGFtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuIGJ5ICJjdXJyZW50
DQo+IGZ1bmN0aW9uIHRlc3QgZm9ybWF0Ii4NCj4NCj4gQ2FuIHlvdSBsZXQgbWUga25vdyB3aGVy
ZSBJIGNhbiByZWFkIGFib3V0IHRoZSBjdXJyZW50IGZ1bmN0aW9uIHRlc3QgZm9ybWF0ID8NCg0K
DQpJIHJlYWQgdGhlIHRlc3QgY29kZSBhbmQgdW5kZXJzdGFuZCBlYWNoIHRlc3QgY2FsbCBpcyBp
bmRpdmlkdWFsIHRlc3QgZnVuY3Rpb24gZnJvbSB0aGUgbWFpbiBmdW5jdGlvbi4NClRoZXJlIGRv
IG5vdCBoYXZlIGl0ZXJhdG9yIG9yIGhlbHBlciBmdW5jdGlvbiBzdXBwb3J0aW5nIGl0Lg0KDQpC
dXQgSSBzaGFyZWQgYWxyZWFkeSBteSBpbml0aWFsIGRlc2lnbiwgYW5kIHJlYXNvbiB3aHkgSSBk
aWQgbm90IHN1Ym1pdCBpdC4NCg0KSSBtZW50aW9uZWQgaW4gbXkgZW1haWwsIEkgY2FuIHN1Ym1p
dCB0aGUgc2FtZSBkZXNpZ24gZm9yIHlvdSBpbiB2Ni4NCg0KTGV0IG1lIGtub3cgaWYgeW91IGhh
dmUgYW55IHF1ZXN0aW9ucyBmb3IgdGhlIHNhbWU/DQoNCj4NCj4gVGhhbmtzDQo+DQo+IFN1ZGhl
ZW5kcmEgU2FtcGF0aA0K
