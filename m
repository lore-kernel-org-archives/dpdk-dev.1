Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1C8C3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 09:49:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCDBD40671;
	Thu, 10 Apr 2025 11:48:59 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
 by mails.dpdk.org (Postfix) with ESMTP id 9375A402ED
 for <dev@dpdk.org>; Thu, 10 Apr 2025 11:48:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGoRvEG5cqEnt+Bh0XmWDvBZ/hrPuI/8/tCOEqytcAZE3iV/76rMuXueKr8EdmzlcajIjet8I2kWhV51mzIvV/9BvUMbMas6ehC0fUL32c4cABnACvrXCNLZO0VlBLJ7FQLSpo05VEFjFDWsKl9yKQAfKT96DWdrGGX/c2g0eYIOlD69ddEszmObvGiPULl0yUz9vb7gzDgX0tg807PA9w89U1gG8VO2hjlyjzeorp9fnr2yjcX4XxgRF+xc0OXxqxDeWS0ThpqQWSUV6bnidTu9WfcIR7n+LSWmGXbXaOfiDs8BYZ/BESFrUhvslOSNMI93CTqz0G6lvz5uBD0uKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTViptMhV3BoC6AlnrPboSAi5vsoBIug+/MfftUAFpw=;
 b=EEvzSp3rlwDnFyuR8Fr9nH6MO4Qk275c8P8pbzE7l5vuvxMVwTr7igtKutyVZ/+KvgxKoKiTPC8zaybjWKKfwav6HLFmwaK/j6Wwj+eF6MLoNkcvavk42aJnS8IHnRC4o0dnyZoaZmPCC5DfBoH7rDw2L9/uLc0BbKnEBVoEKnGre5xIKEyfuNO3KD3RSNfIhPqdXP7hmmXvmA0ARYLPYtxQJkc8CAn0MhiVDYYYLB+NtQdVB/e8ZLV8bFc/kxbnw4xbHEoLNuP9cgpnAIUpM0IAMWGX4+4EdnjFSaIhqI0OdirZ6xAWZgr4iVrqizjY1RrUQCqhHuKC2Otn2euCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTViptMhV3BoC6AlnrPboSAi5vsoBIug+/MfftUAFpw=;
 b=hKHMrk3cwd+mEAGfgcuio8y36y/u0sfjRlr4nLnPk9mHcZV5uPwDnfkvZ0oRc35x/p5jmrYsG/A3wi7XYIHVOdG/GmUAOf4DMN41+69z7oLAIC7ZdtFF8gZjPhgW1v+p6jz+lD7Kl2oZeU5e5HnVU169hv2JQmPM2H87a2n3QL8d1JkyqwlB0AuTScXsKsK/+JfvLIbX3XZulKOhuqlqRitUg/xypYHsHTckPvBFJCv2+sIFg0kM6xliXXhLrNk1prlqeA+5Nud/KeuaXTOaUUo2m+4iqaFj8+cPWGwSRFzM8GAlUXIzg6Xile+Ja79nupmd8m1QI29i0YZAoBlc/g==
Received: from PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 by SA3PR12MB8810.namprd12.prod.outlook.com (2603:10b6:806:31f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 09:48:56 +0000
Received: from PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::5cff:1844:4c17:a0e3]) by PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::5cff:1844:4c17:a0e3%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 09:48:56 +0000
From: Maayan Kashani <mkashani@nvidia.com>
To: Kamil Vojanec <vojanec@cesnet.cz>, "dev@dpdk.org" <dev@dpdk.org>
CC: Jan Viktorin <viktorin@cesnet.cz>
Subject: RE: ConnectX-7 performance anomaly
Thread-Topic: ConnectX-7 performance anomaly
Thread-Index: AQHbpItrnMIwJa0X9kWe3Xjt/M5uYLOcsazw
Date: Thu, 10 Apr 2025 09:48:56 +0000
Message-ID: <PH7PR12MB70183E112D4800F12ED89BFEB2B72@PH7PR12MB7018.namprd12.prod.outlook.com>
References: <f2317379-ee61-42b2-bee6-10efaa91e2ca@cesnet.cz>
In-Reply-To: <f2317379-ee61-42b2-bee6-10efaa91e2ca@cesnet.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7018:EE_|SA3PR12MB8810:EE_
x-ms-office365-filtering-correlation-id: 450b998e-7580-41c2-6994-08dd7814e917
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MlRnZDdIZ1owNkpwbmVPL0dCQlUvZmxDV0tETlpsMDcvM3AxNE44ZjVjcjZX?=
 =?utf-8?B?MG1wbnRwQ0NaazhXYnRSdll4ek84ZzZicTdGWGNKellYeklSbGJTNWxtNjZs?=
 =?utf-8?B?Qk9UUWdGdVZkOXUrc3RtMTduTFEvUU80NlNqN2JPazZYckNuSXhoOWV1bG1L?=
 =?utf-8?B?eFFEOUhLVVBJRHhJbTB2a3NocW4yK3JVdWxpNEVmTFNSTUYzdzVSRE5BNmlD?=
 =?utf-8?B?UlEzYzU2N3BkejdKL1NJWnhBUjJwMFlmQlE2ZFQydVd1WldjZGhOSTgycm4v?=
 =?utf-8?B?b3N2aFZabEhwamphd3NUUi9Jb09NRGlTb1phdFMyZXMvMlZoS1REZEJGd3c4?=
 =?utf-8?B?emJHdnMrdy8xU1dFbjhxakFoaUdnL2VXWXhvSHUyVmdEdkQ4TlY1K0NWVldL?=
 =?utf-8?B?d3ZQNTJQZXFDdkx5WnYzbzJkMmd4dGlFYzFac284MU9pdlp4Z2FaeDV5a3Bv?=
 =?utf-8?B?ZzhlbFRaZE0wbHp6WXZNOW1IV1ovWFJMUy9ZMk41aEVFc3p6K0p6bGF2TGxr?=
 =?utf-8?B?WlJVSFFjZ2xtTlBST1dNUjRWS3o0b1g5TXNqUVZYQlpORURYaG1jYzRBNFZn?=
 =?utf-8?B?Y0J3dWVEWExVYWpHTUZlVTQyVlFXK01pakdvbEV5dTNUckZLUlMyazlSVEE5?=
 =?utf-8?B?djU2SUxmcUZmaXp6ekpxWEpBWHREaDVOZ0dzQk1Cd1h0MFYyRUxFOG9lTzBS?=
 =?utf-8?B?Q1lxKytRekluNFlqTFBUUTkvQkNMK3VQRFhKaE0rRVg2aWdOZklLZ3ZkYkJ3?=
 =?utf-8?B?WlN2RHdqdmpHSWNsK1VSWk5kSGIzbHY2T2ZoWkUrVFJNTThXZGN3TnJuWVFx?=
 =?utf-8?B?OUNoQk0vMEdRL3hxQ256bS9uWlFHa0ZhNFVMWWlvRmlRVUNvQ2ExMGlkSWdT?=
 =?utf-8?B?M2ZXdVV1cjFTbUlxbFc1WnNTQkVPbGdySlprVlZQTk12MVc3dCtpdzZIQ2Zv?=
 =?utf-8?B?RlBaUXVleUpqZDd1UTRGZDcyMHpoOTB2Z20zQktvd0dRdHkrQUlEQTFUNkJX?=
 =?utf-8?B?MUZmWW5Mc29Ma05IcWxPQk1xOERTVk84WWNPNUFuV01DbU9DRTR4ZXVScTZZ?=
 =?utf-8?B?RXlldkEvNXo5bVZsZGlhR21seVJKQmdUaUFGZ3BSYnhYd2hXVkFqOW5oQmJp?=
 =?utf-8?B?VEN3aHlDaC9DNlc2bVYxTGU0K0dQUlFEZ0RnRmlzay9adE5oVXZuWlNueTZ5?=
 =?utf-8?B?di9DaHFWUExCQlYvdm5YdXJ4K0cxTnk0dlVncmpnYy9SUXpsaEw5ZklyRk1l?=
 =?utf-8?B?S2Nmc09kcXZ5Z1dMRUxDbjg0b0JVNEVYaEFWSzlEWUF5dXFXbUpabXVjNmRS?=
 =?utf-8?B?R0kxYkRyYlVoWkgvSFl5SVl1eDIvTTJSZFd4N1JJWFdoL21JTGoxeDdoMFZJ?=
 =?utf-8?B?Q1I4d2FLRUpkSERFd3Q2ZS8xSUJmZzVWMGFzVnRPZUlMbkx1SjJEYTNnZWk0?=
 =?utf-8?B?V3FJVjBraHVEV1JpbUU3aU1mNk1NdGVFTGU3a0ErcjFPZUpleGw1OUNGdjRt?=
 =?utf-8?B?Vi9WS0ZlTEZ5MnJnSUREK2ZPSWFxbURESHpxd29nTXA0NU1YdkZUdEZPcGQ4?=
 =?utf-8?B?TFR2dkZ0NW4xWHJZMlFMSGtiamlDbFoyeEQzaUd3SStxaUltZmIweHBsZkt1?=
 =?utf-8?B?ZjZVUnJSbUZvd1dTVFdFamltWEJIMkRXOFg0YkorMkxqeVY1MWtFRkJtNlll?=
 =?utf-8?B?TEcxcFN5WTI4d1pHcnZ3eFNCVEdrSUxGWWdBdm5kTTh1UDVvWU9scTV6Q2Ev?=
 =?utf-8?B?b0xEUlF5QTdsNDNZUXpoRHQya1JkVVIwaDVSeDNXM3NUY01zU1orK2FaQ3Rm?=
 =?utf-8?B?R1NIMFVHdTFGaVQyZHMwbjI4cnRQUUdkS2gzUFdiUW5BN2lhUEZYR3NidDBr?=
 =?utf-8?B?dlRzL3BiZVRYRjhMb091UVdLL3RMdHEzS1FDMVhad1hYT21qZEdjS1g2R0ZK?=
 =?utf-8?B?TUhnSUhYWFAxRkxhVWIvWklXWkhINlFLZ3VZSlJ3NzlWczBFZllDQmdSMnZ1?=
 =?utf-8?Q?mFLkjC5fPd0hYyjlCtPEFQE9NbCiWc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7018.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SC9zOE4zSU5oblhHbUpMSW5NbDJIUDRBVGIxK09RN2ppOEtGa3ljNFdDYTh3?=
 =?utf-8?B?RmZndVh1aU43ZHJHNmlBTTFHSjMwUkNpYUtiajczZ2FHSmhwM3BzQXpaMGNp?=
 =?utf-8?B?UXpNQWtZM3VTeWJacm8xQWZkOWMzVzNYL0tacG5PUnl4a0VmSVBVeUNnMUpL?=
 =?utf-8?B?RjFpa0x0cmhTVGNnaFRCb01hQ1Y4V2MzUXdSeXpEWjhvWThxbkpGbW9mNHB5?=
 =?utf-8?B?bTJrZDBkZ2hjOXcvTTlxZkVFcGZxT1MxeDMwOVQ2VWN3MjM5YW1RcGtPeU1a?=
 =?utf-8?B?TGIvMDVxQ0N3dHBtRHVkZEpSMUxlODFXdjJKdXNRbXlTZC9EZkxoQVc4YjV6?=
 =?utf-8?B?SzBVek1uUHhMUy9zWDg4RzYxWEpDS09MVDZudTRkU25NaC9sdWx6Z25wR1RS?=
 =?utf-8?B?TEZUQ0JNQVVaL0ExK3Zud2xUN1Q4L0duVzBTaGNUazJJSnd4S2tsSVpPUlVL?=
 =?utf-8?B?azYveUxadDNieGVmcVlnc3g3VlYwTm5PcjdZRHVQdlM3TEQxMEQ3QTlaWDhh?=
 =?utf-8?B?NlBjWlBjSG96MEdKYzFoMmZZTEtXR21kZWNNNW1OUkNmcDdWZjlBQ2xQTTVz?=
 =?utf-8?B?Wm93bVpkSzM1dHhLVEo0TGZUUnBBTGpZRGo0K1F3N0QzeXk4RmFFcXZvSFFI?=
 =?utf-8?B?YUxVQnhKdXNGbE41d0JkYmVvS3dMMktsYkZSbDVUYWNheHdON29jTk81NkE0?=
 =?utf-8?B?SDVLNFlvSDgwRXlacG9UaytlTWVYVitpb3BQSUNPd00wbTFJZHVBZUl4b2hE?=
 =?utf-8?B?di9LREUyRkdqRW5nbGhvTnVKeFBQbDVPQXhFSU5tSDdXNHFaVTlNa2c0ekgv?=
 =?utf-8?B?UDB0VWpxbUFENGdrRmIwR1VTdkkxRFZIZFhLN3RicnZrVHlENzAzV21pa1dK?=
 =?utf-8?B?OHg1aGdnbEYvYjNYM0U3L2F1ZGZmOVN0VjZiRDNGWTEvQlBGYnd0Ri9TTTZO?=
 =?utf-8?B?cjdGSmNRZDF6Um9ZSUpPak9rYXBZZEhKd2Q3SG9rc21oT29CS2JxMTVWSmwx?=
 =?utf-8?B?WGNMRkd5eE9VTjVGQlA0bTY0TTZ1aHoreVBlV3YvckNocmNQc3A0NjM5bk4v?=
 =?utf-8?B?R3d3MGFnNTFFYmFNdjJBdW9MN1lJWGpNZDlFQnlzdjVPM01lQ0YvU0VXRUtw?=
 =?utf-8?B?UE5GY3o1KzBEWmN3QkRaeWJSUHNpN0R1UTcxRmZ1ODA2U0dsY3JzVmhERkxW?=
 =?utf-8?B?dHNGT0pJR1dzNmluRkZWdm95L0p6Q2JzcGZGL3p2UHFKUkhtZm03czhJRnFz?=
 =?utf-8?B?WDRWTThWRzVqWHI4emhIOCtOWXM0eUtXMitFcEMyUEp5YkZSSzQrYUNEMDdl?=
 =?utf-8?B?Q2tYdi8wRU1FRzRtWk5KRktIYytTUCtRV1gxS3ZtTFZVYVhLU09mVFh1RC9H?=
 =?utf-8?B?eWgrMW5ITjVET0orRHVTNU9SSnZKaG9vd3EwR2xSa281TlRaS3phbmR0djFK?=
 =?utf-8?B?bUZkSnRSdXFTbmNQTWY1N2s0T3dWRlRDczRaZW9lb0p3R3hneElKYldONk4z?=
 =?utf-8?B?SXByNEJTMFR3QUg0Vkk5YVpmY2hhZWRMODlITFczb2pLaG9jdzdQckpMSS8w?=
 =?utf-8?B?SDByeUsxL3VYYnVtOGlSMUxzUXpPMStQckFQbFBTTXo4alhXdGZ1dDJua2cz?=
 =?utf-8?B?WGxBa09CRHNxZXlRcHFSM1R0VWpsWk5oOUp1aC9JSDlLSkxKNnJlVjhGZnhY?=
 =?utf-8?B?OTlHNFdFdmJ4Z0JzeFl4N0xHTXFzeXBzeWVZQ21ldG8yOTdzaWR1b0ZGK0NC?=
 =?utf-8?B?d1Vva1pxMDM2WG1ZNnp5NUgzVXR3WTVkU25Zd2xNMEw4cUNlUER2RUZ2UmlT?=
 =?utf-8?B?bjhnempnV3BPR3c4REFSTEM5VTlvNlVlOURWTTZ1cndiWU5uT0JZcGcyMUVO?=
 =?utf-8?B?ckVwSmwvMzR3MUhwSThSTHBjNWp4NjNiWFQ3cE1ncDFRdmxVZWRPWGpSQ1dk?=
 =?utf-8?B?cWtOdy9OK3hXMVhuU2c2STRSL21FaUZDb0l6YTBLSWxzYlNiNTc1Ujk4QSsz?=
 =?utf-8?B?b1RFcFZCUlBGRVVRSEhaakV6OXFpY3BZZmJmNGViNEY5cnZZTUtmQk1RaGNW?=
 =?utf-8?B?Q0RuOXBwMU83VUJWMC9NUXR5bWQvRnVqRDJXSC9WdmcwUUNUQmxCdzVMRFZY?=
 =?utf-8?Q?Zspm/XO2W8LyITJQO5uVGFig2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450b998e-7580-41c2-6994-08dd7814e917
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 09:48:56.1592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f/vEin4RKBepwBgHecoRhzqConIzcb+mmBTzFfb6hpTTcu5xBjRM0W6iJNF1/PbR8LoCLh8oXjJ8kmtEWm5pOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8810
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

SGksIEthbWlsLA0KVGhhbmtzIGZvciByZWFjaGluZyBvdXQuDQpBZnRlciBzaG9ydCBzeW5jIHdp
dGggb3VyIHBlcmZvcm1hbmNlIHRlYW0sDQpJIGNhbiB0ZWxsIHdlIGRpZCBub3Qgb2JzZXJ2ZSBz
dWNoIGFub21hbGl0eSBhbmQgaXQgDQpzZWVtcyB0byBiZSBzb21lIGxvY2FsIHNlcnZlciBpc3N1
ZS9jb25maWd1cmF0aW9ucy4NCg0KUmVnYXJkcywNCk1hYXlhbiBLYXNoYW5pDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2FtaWwgVm9qYW5lYyA8dm9qYW5lY0BjZXNu
ZXQuY3o+DQo+IFNlbnQ6IFRodXJzZGF5LCAzIEFwcmlsIDIwMjUgMTQ6MjgNCj4gVG86IGRldkBk
cGRrLm9yZw0KPiBDYzogSmFuIFZpa3RvcmluIDx2aWt0b3JpbkBjZXNuZXQuY3o+DQo+IFN1Ympl
Y3Q6IENvbm5lY3RYLTcgcGVyZm9ybWFuY2UgYW5vbWFseQ0KPiANCj4gSGVsbG8sDQo+IA0KPiB3
aGlsZSBiZW5jaG1hcmtpbmcgdGhlIE52aWRpYSBDb25uZWN0WC03IDQwMEdiZSBOSUMsIEkgZW5j
b3VudGVyZWQgc29tZQ0KPiBpbnRlcmVzdGluZyBiZWhhdmlvcjogd2hlbiBwcm9jZXNzaW5nIHNo
b3J0IHBhY2tldHMgKDcyIEIpLCB0aGUgbWF4aW11bQ0KPiBwYWNrZXQgcmF0ZSBJIGNhbiBhY2hp
ZXZlIGlzIDIzMCBNcHBzLiBIb3dldmVyLCB3aGVuIEkgaW5jcmVhc2UgdGhlDQo+IHBhY2tldCBz
aXplIHRvIDUxMiBCIGJyaWVmbHkgYW5kIHRoZW4gYnJpbmcgdGhlIHBhY2tldCBzaXplIGRvd24g
dG8gNzIgQg0KPiBhZ2FpbiwgdGhlIG1heGltdW0gdGhyb3VnaHB1dCBpcyBub3cgMjYwIE1wcHMg
YW5kIHNlZW1zIHRvIHN0YWJpbGl6ZSBhdA0KPiB0aGF0IHZhbHVlLiBBY2NvcmRpbmcgdG8gdGhl
IE52aWRpYSBwZXJmb3JtYW5jZSByZXBvcnQNCj4gKGh0dHBzOi8vZmFzdC5kcGRrLm9yZy9kb2Mv
cGVyZi9EUERLXzI0XzA3X05WSURJQV9OSUNfcGVyZm9ybWFuY2VfcmUNCj4gcG9ydC5wZGYpLA0K
PiB0aGUgbWF4aW11bSBhY2hpZXZhYmxlIHBhY2tldCByYXRlIG9mIENvbm5lY3RYLTcgTklDcyBp
cyAyNjYgTXBwcyBhbmQNCj4gdGhhdCBpcyB3aGF0IEkgYW0gdHJ5aW5nIHRvIHJlcHJvZHVjZS4g
SSBoYXZlIG9ic2VydmVkIHRoaXMgYmVoYXZpb3INCj4gd2l0aCBkcGRrLWwzZndkIGFzIHdlbGwg
YXMgd2l0aCBteSBvd24gRFBESyBhcHBsaWNhdGlvbi4NCj4gDQo+IE15IHNldHVwIGlzIGFzIGZv
bGxvd3M6DQo+IA0KPiBDUFU6IEFNRCBFUFlDIDk1NTRQIDY0LUNvcmUgUHJvY2Vzc29yDQo+IA0K
PiBBcHBsaWNhdGlvbiBjb21tYW5kbGluZToNCj4gDQo+IHN1ZG8gZHBka19leGFtcGxlX2wzZndk
IC1hMDAwMDowNTowMC4wIC1sMC0zMiAtLW1haW4tbGNvcmU9MzLCoCAtLSAtcDB4MQ0KPiAtLWNv
bmZpZw0KPiAiKDAsMCwwKSwoMCwxLDEpLCgwLDIsMiksKDAsMywzKSwoMCw0LDQpLCgwLDUsNSks
KDAsNiw2KSwoMCw3LDcpLCgwLDgsOCksKDAsOSw5KSwoMCwxDQo+IDAsMTApLCgwLDExLDExKSwo
MCwxMiwxMiksKDAsMTMsMTMpLCgwLDE0LDE0KSwoMCwxNSwxNSksKDAsMTYsMTYpLCgwLDE3LDE3
KSwoMCwxDQo+IDgsMTgpLCgwLDE5LDE5KSwoMCwyMCwyMCksKDAsMjEsMjEpLCgwLDIyLDIyKSwo
MCwyMywyMyksKDAsMjQsMjQpLCgwLDI1LDI1KSwoMCwyDQo+IDYsMjYpLCgwLDI3LDI3KSwoMCwy
OCwyOCksKDAsMjksMjkpLCgwLDMwLDMwKSwoMCwzMSwzMSkiDQo+IC0tZXRoLWRlc3Q9MCwwMDox
MDo5NDowMDowMDowMg0KPiANCj4gR2VuZXJhdG9yOiBTcGlyZW50IDQwMEcgZ2VuZXJhdG9yDQo+
IA0KPiBXb3VsZCBhbnlvbmUgYmUgYWJsZSB0byBzaGFyZSBzb21lIGluc2lnaHQgYXMgdG8gd2hh
dCBtaWdodCBiZSBoYXBwZW5pbmcNCj4gaGVyZT8NCj4gDQo+IEthbWlsIFZvamFuZWMNCj4gQ0VT
TkVUIHoucy5wLm8uDQoNCg==
