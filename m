Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52B2C02198
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 02:39:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1579402D5;
	Fri,  7 Feb 2025 03:39:04 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by mails.dpdk.org (Postfix) with ESMTP id 07831402A7
 for <dev@dpdk.org>; Fri,  7 Feb 2025 03:39:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUqVIm5FjqRM/1psT+4XmlSqMIXZG8yWCPNTxMA5ZN0QXUV1VihPys1QMLQ9pBJRUCFIRs7pV6ggvLLnQz56W/QuwSCTaZRf5AnQEjKj0ZqtpXUcsaQ23g0hsX0hNq8TWUYcxUYUO6wrmHwPV4paMqtvP7gX2hjXy/SYofkGwb10k5PGs2yZ0nd8g9eHntvn89vxT2PEjC9Jcx6VvVzLctBWT2FTmCljavmUEWgiiNwUJHwL/09/xFimPqHvmJ8adeWpt4IdNnp7wCIgd7OI9sR593iY86EcU21pmb5eJcVcZeoYbwbc+aXq6Dlx2MiAYgoUY0r0kzszMdWmcCMl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnMTxTGgxmd4oYGgrcijdr1P/PMFU+tyAVAQ8OpWaAk=;
 b=Fef7kxP7kHOYLVhWhondIr3PtwDwXIyK0J+TNpkdNpJoT/hRdWbkXIu4XmgryciBXyiaemhcDzoMHsQU3l5uBsIFPyv8qneezs5GdkafWqEuwG4SvrzDCN2Hvgqwwg55utQ3YSulYb+BKHgU9KB4+RL6OsUw++IF33agSGmH/jr6rO+2/iHB/cS2/lDbcPmeym3k++cyZSX1dEsXOYlnuOvETnmfDLsIx47JmG3TtPvsCqh6uGP88x6f7yTuA51SPpI97kINKRcfgdNwzWtVySEjKQgGGRuDx1Qrq08/IzvLEIXuhFdutjB+X8tKHe+ntouEl/eBCYl/DyVt4xHXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnMTxTGgxmd4oYGgrcijdr1P/PMFU+tyAVAQ8OpWaAk=;
 b=TaJpvBBsFPEA6gXKogBr56Zqvr32kBha1a0ghKELavPgE7fc6t3fQSp9e6vijHrkzBbaUkFdrUeQ8h4zvuCFayiBJ8UfdKrAq8xzjAE2/+UxfL/yeJrS1/4t896MnKQYkV799PGFge88DzqyOQwjryvE4P+qaJ502vr/SVmVoTzraNiQJD6t1HlSWUhELdofRmPpFZxVPBqRrZzidNTW9PBn/GF5/9TIISoRgWcIn+QT2Q3Nw7mKZtBGXJUlIapxObe0uF4Vwbvt3ir9nCDvHVrxbEETlnVFD+ccpcrwO0Z1PvF7la4HU6EVTnzMFpYHE2IgyeGuGWoTaHCT42VVdg==
Received: from MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 02:39:00 +0000
Received: from MN0PR12MB6103.namprd12.prod.outlook.com
 ([fe80::3c6c:6f63:917e:98d8]) by MN0PR12MB6103.namprd12.prod.outlook.com
 ([fe80::3c6c:6f63:917e:98d8%4]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 02:38:59 +0000
From: Chenbo Xia <chenbox@nvidia.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>
Subject: Re: [PATCH] net/vhost: improve devargs documentation
Thread-Topic: [PATCH] net/vhost: improve devargs documentation
Thread-Index: AQHbUu+X0tvxBLvvpECmwADogz0TlrM7bPUA
Date: Fri, 7 Feb 2025 02:38:59 +0000
Message-ID: <F1DF3D95-CEC7-421E-AFC4-0AE2B5DAEE83@nvidia.com>
References: <20241220145802.3851767-1-maxime.coquelin@redhat.com>
In-Reply-To: <20241220145802.3851767-1-maxime.coquelin@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6103:EE_|SN7PR12MB7910:EE_
x-ms-office365-filtering-correlation-id: a7ca652b-7075-469d-fb2d-08dd47209388
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UWxwblFRWkxuSTFjVmMwZ1hvMVk4LzVVNXh0R3R5dlgvb0dNalpOM2JjcmRF?=
 =?utf-8?B?RFM3dHpDbXUwV2NZUXFiSjV5c2NLZGF0YWcwRi9VWkZiaS9aanRudWlFRmtn?=
 =?utf-8?B?Ti81aTVGV3B6QW14aWF4Vm5Yb0oxL1crY2xIblZ5ZjRLQ2ExVTFXcUFFOE0y?=
 =?utf-8?B?OWlRTXRPWWZvZkpDUklMblNxZDNQN05oSzNOdXEyeWx5bEJReFAwUmZBemtM?=
 =?utf-8?B?V0dRcmxnTDZNbVRNVjJibHRCNjJaajdWd3BwQ2praEh2dEd6MXllZUpaVWxN?=
 =?utf-8?B?ZHN2QnAwNGFKUytUL1g5VnlTMHV2WnJXTnkycGt4eUNBMlBxS1BwRmUzSFVO?=
 =?utf-8?B?NXNEcEZvREEzc3l4ZHJpZFZxQWZ5SURqQ05EaHhRdzM3L1I3U1dnSTFaWDN1?=
 =?utf-8?B?SzNScm1WMWZpRUxZWHZWL1VCMnNMcFB3RUxRR2gyRzdhV0wvQjRzL2VLUkRE?=
 =?utf-8?B?QVB4ZTJ5clo0OGpQbXNUa0E1QzNVdklrMU1hV3liZFZBYmRvYTNNb3JUUFg2?=
 =?utf-8?B?Q05xaWFVcTV4TlZnOXFjc3JqZ3Y5M1Z6dEFVbVEzTDFacTFXVjc2ZWlIUlZK?=
 =?utf-8?B?aDcyYTJPK3U4NGZudFh4aVVoclF1NlJFaWVGWk91MjFVYXJST0RyTXFXS1J2?=
 =?utf-8?B?MTlOQVIwSmE4UG4rT3kyN3pLMG5FMnJ5NllZK1h3QXR2UjZvMTFtTGNpd2VU?=
 =?utf-8?B?aGIxTHFuVzhOeUo2SmFSMnVjcDFpWHpUZFMvd3VHTXh6Sy9hUTlrL1p2R3Jm?=
 =?utf-8?B?R3JKbHNicy8ybW95UURQV1JLUisrb2wvVkNVWjNoZEpDQlRSTng2WjVUN21F?=
 =?utf-8?B?TmY3OUZXNW45TDdiV0RiTXp3T1NNYjVFQkxsT1ZSWjZxUldYYmcyQlN1OHc2?=
 =?utf-8?B?eEIrbnp4KzNVdUtaaDZrcXc4U2FBWHN3aERrWWFSZ2dNMW5wcGpsRExvT0U4?=
 =?utf-8?B?Z2JuYVB2MzRCemltNWxRTnJucFJadkpOZmROZVR3TStxTk9YUjRPYlFEbjdI?=
 =?utf-8?B?VjdqMDdDSktHeEk5N2JuQnpjSk1QcHVpdVFxR1lVbjZneDhkMVFjdnl2Nm1K?=
 =?utf-8?B?TzBNQ3JEaDZScmtObWVSbzc3dHVyWXMrSzR6QXhWMk1Obnk2RnVCRHNGc2ZW?=
 =?utf-8?B?L09RNE1WVTBSRUIrU1A0V1ovRTI5dFZWM0cwU3cwWXRVaThuRGVxWEZ5UWpD?=
 =?utf-8?B?WE5FZHhIQm9zTVRXaGFNeUh0aUZ2eHpwR2RlQlVUamxyT2plNjQ1UkFSV2pF?=
 =?utf-8?B?dGtBazJMMHdzQk5sQ0N3SW4rN0JmVlpNajREWDU2MTRDYUhkMFVtbGsrSlRD?=
 =?utf-8?B?UzNVS0FCOUxoK3VmWTBNYUNKeGI5eWFsUXA3c05QLzNWeDFueFJnLzJSajFw?=
 =?utf-8?B?dHQ1K3Q0SnArWUlEVVZvVHU3V0g1QzlxcncyTyt2Vk1sRVBWQitSSHJWOEph?=
 =?utf-8?B?c2RCU29UNjlxTnVNKzRUcW5DNk9mZ242N2VLRkhORGFYNUpKWURTWGhLK0lo?=
 =?utf-8?B?aHEwMVZTbmpYcUR3SHJTbmVPYVpoWTQ3RGxWZVpWNkxBK0NEWkYyc0E2RVRR?=
 =?utf-8?B?ajczeXdXNlBrem1UUDJ6VDR3Ulk5ZTBZVzRUL29WL3hSMlhvTlBVTGxSd2wy?=
 =?utf-8?B?UkxvNHdHOHozZ3ZOQkxrYWwrQ0dzbHBWbEszdUd1dVRPdXZ6dTJ0eDZqYjZ4?=
 =?utf-8?B?ZmE0MW8zYm1OKy83M3dTdkYyaDRrYkRjak5RbDdlTDhlSGs1NUFTNU9jSVVa?=
 =?utf-8?B?YlVHN1hJMUowTHh4bm5mc2NMU2R2bXBOVzBTcTJvQW1wOFZMaUtuSWF0dFJn?=
 =?utf-8?B?cHpkY0JmdHo4K2VmbTZZTXZSZ1ZiRnZBVXJlN1pEOE5iZjJweGNIZjNxb3h2?=
 =?utf-8?B?N2thZFR4VUpsMU5XbEJDWCtlUWdpZWppR3lNVFV5OElvMUJna3FuVW1EdFIr?=
 =?utf-8?Q?0CzpLE9/dRSwPrnAS41vjoZKtUF7/V2O?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6103.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q21DY1drZmNZMUdLMFdNeWp0eGt1OHduNXJlZk1YTEdub2VCeVJ1TTA4b2RF?=
 =?utf-8?B?VG1NOVZzSEVVQzd3NFY5S1dtcDVxQml6c1NFc0F0eVpWdy94a1g0NHYraXR3?=
 =?utf-8?B?cGNldnMzbWtnT2tEV3RWby8rMVVJWGxpa0NVdDRFS1NKOGxvTTh3SjJwL0ll?=
 =?utf-8?B?TGR1T1dseUttWVpZOGNLWnNoVU1hZkJnTTAyUTRyR3Z4MGpscUdtaUFtQ2Ju?=
 =?utf-8?B?djBKeDVwa082N1NaZnM0eFczUm83TXhLYWwxOUJFS0h6REUzeVF5d1dpcTNY?=
 =?utf-8?B?TXpWTllldWFDdmlhbmVIdlpRY2orTDh5QjBFTWhzSHdTM1o0cVdtZy9aVUNH?=
 =?utf-8?B?LzFoTGZOMjRyQjRsSlM3RXRZZFdvMUk2WGNSU2dQVDVjcUJDWWlMVCtXSzlS?=
 =?utf-8?B?MHZha0QzMktTT1hZMlM3K0k3S1BZNXlkVFovaXkvRThTTjBJVFVPQVdETysz?=
 =?utf-8?B?RUV1M2xWaEhIc3N4Tk41eGZnYzgwZHFBbStwUE1ZTWVwMisybXY0VXJXd01E?=
 =?utf-8?B?cnk1eHltcjZkeS92TTEyQjFYd3kwUlFpMXdrTXV4ZzBpY1JESFhPZzN6d0lo?=
 =?utf-8?B?YVZ1Tk44bCtwcGR2SFQ0QWRkcUtpSGJGcGlWUzRvYzRsSG04UFVHMTMxWGVk?=
 =?utf-8?B?ZTZrOUVFTTE5RXlrQkRZeHRQV2h0TmRXVXR3UnIzSFVMNmlkdlQrdVBURjhR?=
 =?utf-8?B?clFDS1dhSm5MaGYrZklYZW9obTEzWVlwU3JqS2ZGV3BpUWExMnJVRFlIRE0x?=
 =?utf-8?B?MWhaTmNZNUVLdGNwemJMNGpmYkh1c3VTQ1gyYmJGZkliRUZURTB1czFveks1?=
 =?utf-8?B?THJHcjJtZExKNVFheGNrUXd4Ny9ua05Ga3VpU1BsQ0d5MUZFNHl5NzhWMHZj?=
 =?utf-8?B?bGZqRHFNbzdqUE9xRE5USEpGWElnbTRpYksxd0x2K3JXSDVWRlJDUkJqRzdU?=
 =?utf-8?B?bEc0b1FDbTJyWlpzM1hyclN1WStTeEdWNWVXcXdSSmVvaEJoQ0x4ZTJTZ0JR?=
 =?utf-8?B?ZDJpM3FhaWRBZ0tjQmZEb20vRzdNM215WGxlQk1UaWFQLzc0dkxqZWZVRTNP?=
 =?utf-8?B?eDNEZC9nL3plSDNUVUVZYVhQQmxodXhCcXkvckFwck1IWG1DOVlzaGZEdmZK?=
 =?utf-8?B?bTNuYzIxdnN6citHMlJiV1lUenRtUUJBTG9UOWt4bU1oKzBJZGdQTTdkdU1C?=
 =?utf-8?B?M21wK0d2bDhqRUU3S1NlWlFMNnlIb1B4YmkxbTYvQVlUZVFyK2cwNnl4S1Jz?=
 =?utf-8?B?d3Bjc25wYW5PbUlza1B2bGVSejdBVHpZWDd4d0tVRXRRdFBQN3hiWkVIcSt5?=
 =?utf-8?B?a2FGMlVLbzFoeE83OWpNbktMYWlyOExtbFVMNDMyMkExeFZJbWN1SUVEamtE?=
 =?utf-8?B?MHJ2Mm1wbVpyNDdUU3cxcVcxU0piLzAxZTJFeXNxcDdmWmhPWmdaSi9YSjlS?=
 =?utf-8?B?SVAvcjZhRi9tV0VSZCs3U0RScFAvMmUxUnVhd2o5d0RnOGwyb1BrK3pSdWpT?=
 =?utf-8?B?ajBYa2VuUzBKU1FDRWNWdnBOaHU1cjZBekY1ekRyeit4eThDdE1JZTl4Q0xh?=
 =?utf-8?B?QzAzMlVVQi9iU2I2UzFRNUk1cHZBdG5HY0d4QSt0L1p0WFNkOGFXeVJFMjZH?=
 =?utf-8?B?MXFGWnBCSlVIZ3E5NjFHWW85VXFsN3YwNGNSN3p2SzdjZVZDdXVjMXMxdmU4?=
 =?utf-8?B?SEg5T1RHV044Vk1wOGV5MXdTc2JDV1dIUWE2ZTdMVzZyWDVYL00rcGJrL2Fr?=
 =?utf-8?B?ZXU4Z04ra3pxRDV3WVBqMDYydkNHb3IyWUlBVU9FQ2FvaFVKRGV3NHF2cHM4?=
 =?utf-8?B?cS95ei9wbzFyOVhzSkVQbVZIaTJoeE1hcFkwNnAzcU1NWlVtV1k1K2p0aUNP?=
 =?utf-8?B?cFpMNGp4QllpdTh6Qy9jWTgrUDNCbUMwZnRsMHJsLzQxanFKeWhqY3d5RzU0?=
 =?utf-8?B?TEVSbmtlQTJMK1pNaTYwaXQ2aEVUbXpOYlFVaVkrTWdISXpQYzFzSkM0dVZ0?=
 =?utf-8?B?NEo0eFFxNnlIS0NwVDVvSllrZXNkZXBrNnczSUNmTjE0MWVtNVlUbk9QRVBM?=
 =?utf-8?B?ekJwdnFWUXZWVm1mTEhLQ3Q5eisxclBmdjJTYTViZVZPMTg5RjVJbGY1RHhF?=
 =?utf-8?B?K3BMZmJ0eTlGSmJ4dUVWUEJ3eGdDZjdMbFkyb1krK3ltK3drRkg3YWNGZmdl?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63334F5186E89C4B90888C14EECBF219@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ca652b-7075-469d-fb2d-08dd47209388
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 02:38:59.6159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLkDPE7LKgkwUVsclup0gRPDk4DaLxFhs6sf1kmLslfDUFC6UIT+GVbsTfQ4ppHvGO6YCgeChmZPJXmM+/5ZyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
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

DQoNCj4gT24gRGVjIDIwLCAyMDI0LCBhdCAyMjo1OCwgTWF4aW1lIENvcXVlbGluIDxtYXhpbWUu
Y29xdWVsaW5AcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNh
dXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IFRoaXMgcGF0Y2gg
YWRkcyBtaXNzaW5nICdjbGllbnQnIGRldmFyZyBkb2N1bWVudGF0aW9uIGFuZA0KPiBpbXByb3Zl
IG90aGVyIGRldmFyZ3MuDQo+IA0KPiBCdWd6aWxsYSBJRDogMTYwMw0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWF4aW1lIENvcXVlbGluIDxtYXhpbWUuY29xdWVsaW5AcmVkaGF0LmNvbT4NCj4gLS0t
DQo+IGRvYy9ndWlkZXMvbmljcy92aG9zdC5yc3QgfCA5ICsrKysrKystLQ0KPiAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RvYy9ndWlkZXMvbmljcy92aG9zdC5yc3QgYi9kb2MvZ3VpZGVzL25pY3Mvdmhvc3QucnN0DQo+
IGluZGV4IDM5YzZmY2ZmNTguLjAwMTNkYzUyNmYgMTAwNjQ0DQo+IC0tLSBhL2RvYy9ndWlkZXMv
bmljcy92aG9zdC5yc3QNCj4gKysrIGIvZG9jL2d1aWRlcy9uaWNzL3Zob3N0LnJzdA0KPiBAQCAt
MzIsMTMgKzMyLDE4IEBAIFRoZSB1c2VyIGNhbiBzcGVjaWZ5IGJlbG93IGFyZ3VtZW50cyBpbiBg
LS12ZGV2YCBvcHRpb24uDQo+IA0KPiAjLiAgYGBpZmFjZWBgOg0KPiANCj4gLSAgICBJdCBpcyB1
c2VkIHRvIHNwZWNpZnkgYSBwYXRoIHRvIGNvbm5lY3QgdG8gYSBRRU1VIHZpcnRpby1uZXQgZGV2
aWNlLg0KPiArICAgIEl0IGlzIHVzZWQgdG8gc3BlY2lmeSBhIHBhdGggdG8gY29ubmVjdCB0byBh
IFZob3N0LXVzZXIgZnJvbnRlbmQgb3IgVkRVU0UgZGV2aWNlLg0KPiANCj4gIy4gIGBgcXVldWVz
YGA6DQo+IA0KPiAtICAgIEl0IGlzIHVzZWQgdG8gc3BlY2lmeSB0aGUgbnVtYmVyIG9mIHF1ZXVl
cyB2aXJ0aW8tbmV0IGRldmljZSBoYXMuDQo+ICsgICAgSXQgaXMgdXNlZCB0byBzcGVjaWZ5IHRo
ZSBudW1iZXIgb2YgcXVldWUgcGFpcnMgdmlydGlvLW5ldCBkZXZpY2UgaGFzLg0KPiAgICAgKERl
ZmF1bHQ6IDEpDQo+IA0KPiArIy4gIGBgY2xpZW50YGA6DQo+ICsNCj4gKyAgIEl0IGlzIHVzZWQg
dG8gc3BlY2lmeSB3aGV0aGVyIHRoZSBWaG9zdCBQTUQgYWN0cyBhcyBjbGllbnQgb3Igc2VydmVy
Lg0KPiArICAgKERlZmF1bHQ6IDAgKHNlcnZlcikpDQo+ICsNCj4gIy4gIGBgaW9tbXUtc3VwcG9y
dGBgOg0KPiANCj4gICAgIEl0IGlzIHVzZWQgdG8gZW5hYmxlIGlvbW11IHN1cHBvcnQgaW4gdmhv
c3QgbGlicmFyeS4NCj4g4oCUDQo+IDIuNDcuMA0KPiANCg0KUmV2aWV3ZWQtYnk6IENoZW5ibyBY
aWEgPGNoZW5ib3hAbnZpZGlhLmNvbT4NCg0K
