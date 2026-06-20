Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5515CD98F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 19:22:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E66A84025A;
	Sat, 20 Jun 2026 21:22:09 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 925E840151
 for <dev@dpdk.org>; Sat, 20 Jun 2026 21:22:07 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65KJIAYI1347512; Sat, 20 Jun 2026 12:22:03 -0700
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023083.outbound.protection.outlook.com
 [40.107.201.83])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ew8yfkg02-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 20 Jun 2026 12:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHverFADnWyp2grXEmpmQyNyL634qVsQFSh9GDQbJHGO08eZzyc+trTjR60yLDL0oqKcCdQQ2sffe2yGKJBRuKAg3TltHncbvF1lnx7f1sojIvxoJX0HlCfDjij8sCbj22kZpTqB+QuoOWu0Dnov8TVvLywAINTO4mssY5e7yZy6vtQxaSNVqnbRX78OoutnSBCMsCnlvkJSvNpkPHm7k9x8EK899GKsKhC7uYiok4o7HG/Ds+iGoF0RYD+hAdt5TxloCL2nhXgAu/IoT/tQ62DbGPQrp1jxOblZj5/8g26lwqorpzBz3volRiW+SNwMywYO4SpRBAVLzoblxDRGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGZK8pZ6uUfuM6TMgWZHh3cINnnFTa7kZyhJMQtfIb4=;
 b=qlK+fqPV2nB34OEatMK87kzHjuwAfPBesM4bcnvTkYvf7CmlYlU947KxrliHXlDhG1KNi9Y3MR5M88WoNRA8iVebMsq8YQVuZcvXQ1rkhO/Km5MCR/RuCtYTJg3Xi6Dm4sODVskloubYJWlcyKRBs+svLSF0m2XmlPyE6UXBAcljWx9yqhaK+mdWjCRrkvZ5+JUVV+jodh3NtZ+nxha/Yrn+tSwcpuk4WTBMaTkgQWgi5k8o1H4ZtrrZVX/ce9rZviNZbVmw1TzYGeuG7DuGMmVlDsqNZWujnGNiDfVx4Pn8aoDsebw8Din2QmfS/U/t6XQ4e89+r6MhS1o1L5u7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGZK8pZ6uUfuM6TMgWZHh3cINnnFTa7kZyhJMQtfIb4=;
 b=pHNfnU5uJkHmzmD9v1KTzmWEK16MbcQCfo5pwfmGTPLI81pj58xdYwhXUN9MbbGU2fzCOZUU+p1+4D/sRC62PEo1lX8tdZVcWK/SRiZ9i6GfVdXj5djdbyoNnuxSbUf3uG5UQ5cC83w7o5RT5/NiYrs22YsWCya0OxVQnR+Sc7E=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW3PR18MB3641.namprd18.prod.outlook.com (2603:10b6:303:2e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.18; Sat, 20 Jun 2026 19:22:01 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 19:22:01 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>, "Nicolau, Radu"
 <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "paul.elliott@arm.com" <paul.elliott@arm.com>,
 "Shebu.VargheseKuriakose@arm.com" <Shebu.VargheseKuriakose@arm.com>,
 "Kantecki, Tomasz" <tomasz.kantecki@intel.com>, "Islam.Ragimov@arm.com"
 <Islam.Ragimov@arm.com>, "Gowtham.SureshKumar@arm.com"
 <Gowtham.SureshKumar@arm.com>, "Finn, Emma" <emma.finn@intel.com>, "Cornu,
 Marcel D" <marcel.d.cornu@intel.com>, "Mcnamara, John"
 <john.mcnamara@intel.com>, "Jonathan.Wright@arm.com"
 <Jonathan.Wright@arm.com>,
 "Dhruv.Tripathi@arm.com" <Dhruv.Tripathi@arm.com>,
 "wathsala.vithanage@arm.com" <wathsala.vithanage@arm.com>, Thomas Monjalon
 <thomas@monjalon.net>, Fan Zhang <fanzhang.oss@gmail.com>, "Ji, Kai"
 <kai.ji@intel.com>
Subject: RE: [PATCH 1/2] crypto/ipsec_mb: remove chacha-poly and kasumi drivers
Thread-Topic: [PATCH 1/2] crypto/ipsec_mb: remove chacha-poly and kasumi
 drivers
Thread-Index: AQHc/ws0jieoUe67hUSD144Tib7/YrZH1fLQ
Date: Sat, 20 Jun 2026 19:22:00 +0000
Message-ID: <CO6PR18MB4484136E074BFA7F58D62401D8E12@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260603092736.664428-1-radu.nicolau@intel.com>
 <BL1PR11MB552766F74EA3CD53AA04AFBF84E32@BL1PR11MB5527.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB552766F74EA3CD53AA04AFBF84E32@BL1PR11MB5527.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW3PR18MB3641:EE_
x-ms-office365-filtering-correlation-id: 4283a744-44f3-4f40-2096-08decf01342d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|11063799006|4143699003|56012099006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: 6ZVyCLJ5UFuYBe+XsJR0CkZwMLirwDZNKsTetNZoKZmg+p1L4ePTG1nIgLLGGAxs0l1cb0jYHX53UuyHuEKX1Is7Bkr5Rs017xLntH+0XZPc7/RQRnUsinCQq2iBnx7iuMhKGFhlN959ZgVgAarMR5YJFcFRMNvtkIU3xuBg1eascSQ692JYtCN416cp1ENTRix/OzNwB2rU7Sx9vbdZ77OMrUa9Pcf8sqedmhUJd5iYOo2Ew9tuCbQPWnytLrnXLOOMrQvBQATCqTGFg7ZlW19hkPrWqYf3Uaqpz8/RBa+eYI7XJT8VWLWshGHBxlQ18gopU0PXhYhQdTvYQz6/wAxEDmMhYWQLiJw92x6Wh7wrKWl7OFZNqvruK32jiMF58Nqoz2QDNjIDvsfiKNERyVHTqdeMRo8By+Tu5VV01ab5Z3t0qvQGxSthl/v6Ya9FNrWxjKpJD6xQQu4Cs8akKEkFITm2Qc5vIaBvz2yZ6UixjAvZvkFuSsLFYKwTbOYJ+2LUODe5Q6zQIhtL0nyqvxKQnTYFh0f2HYWxDxLdQKAPqcxfdxY5hqwnMZTZZZ1dyhCcci80z+sV6DqWp3mB5VUNlpnervmNpT35Paur4fFWkOCBeWW3EM3tdcnkqzZ1FaP5fpqoi4YTpGACPJjFVA3BHQzb5gmxO+2UOt1h7mWk+3mzFZRdOOwuYQio3hDWVhG1DbplwRIdycnUaEVYUhQjdwELgVlXVRmCpgbBE6w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkhCTkJMT1VtSm1YQnJRMDlSR0x6dE1Xa3lkdHJIUXJqc3c3dFBtU0ZZSWtU?=
 =?utf-8?B?dlJXMEc4WW0yRmtSU0JmVnQ3ekF6V25Rc0ZJUytqNCtOUStSMTRlMzFTNEdu?=
 =?utf-8?B?YTg2RkZDNlhiV1dFcU91QUtNRmM2S0I4Qml6cUVFRVFuNUNEV3RZREJ1Y2Vw?=
 =?utf-8?B?eTliOSt1ek93b2krdVJQS01rQzR3OUxCUGx4S2hxV0hJT2V3S2JYRVRjUTNI?=
 =?utf-8?B?UXgvZXM0bGI1dy9pYWdiT0JEQUszOXM2Nm9iRVM2RmZKeCtRTmVPdXhKd3NN?=
 =?utf-8?B?blVJSzlPa0FkVE9wdjJNdHhUd1orcmdBcGRpS29xVkxCOWM3enRXaXliQTZZ?=
 =?utf-8?B?MWovUHFJQklxWEg1MUhCaVV3eUNQMkJFNDdDV0R1Y0NyYXo4RlNJWXhqUzhu?=
 =?utf-8?B?dzVqT3BtSnlMMmgvNmxRVmNVMWNGbEdEc2taYmxwUEU4NEFxdzJvb3FVcDVn?=
 =?utf-8?B?VlRYdThIQUlZV3oxNFpha2svclhCVk56VEZ3bGxkVkppS2xkWk91TmozbUFD?=
 =?utf-8?B?ZG8vcmRPckk4bmF2Z3R5aDRlWlpYUi9hOWd3c05DMXNVd3orczVtYWtQWEI5?=
 =?utf-8?B?NXB2bjdraVFNaEYyYmpEVmtKeHc5WmJ3dlBxWCtzdUIxRG4xRmV3TEQzOEM4?=
 =?utf-8?B?Q3B4RERpd29RMHpxMk9DWHhyanM3YVExVmxabmJzNG5yQXRJVXgraHVoKzFh?=
 =?utf-8?B?YitMd0haYTR5Qm1nZ2NndTJrbHIvblpIY1hTOUtzTGI1dlVka3lTNnMwZFp3?=
 =?utf-8?B?VEdtSGN5UGlFdVg0MFl4aFF6ZUtLb081SitTM0lBUnJyMDBZWTZvcEIxWGRa?=
 =?utf-8?B?QnNWVXNwd2hDdlVLSUtwN2VIOGhnckIvTFNWSHMySFgxTjMyQjFWS1BBRXdK?=
 =?utf-8?B?V1hZWndHaDhlbGFFYVl3QzF6aXZ3d0MrNUtRKzF2QzVyTnhXZCsyVHlvdW9l?=
 =?utf-8?B?aGwzYnRwQU0xcVpRbjIzRmVkdjJyNHVVY3EvMjdGWDFWR2dzTU9FOUlpOHZi?=
 =?utf-8?B?VzRqVEREWGxLc08rN0pKcTB4aHJ2YU90R0ZyZENqS0FBSFdXYTVGdVZiellL?=
 =?utf-8?B?eC84S0IycFZjTGJ0YUR3T01TN0cveWlVTEVJcXBLMjVqWmFOT2JUVFhPWnpV?=
 =?utf-8?B?WWZTclJFdWVLNWhpVHdjMjh0S0Y1YjlQR0gwRFV1dk9PekJya2lKNW5hdGJQ?=
 =?utf-8?B?aVdjOTY1ODBwYVlSbVFiOURUbXNxMjdieElZQzZzdlBYdWlBU1ZKSUkvTjNR?=
 =?utf-8?B?blhUVHE0elltQ0JPTGtSMGVlczQ4cE9seEsyWW5hRHptcWpCdCtmT1VqcHdR?=
 =?utf-8?B?Y1F1ZDM4UTJWcUxkNm5DeFZaUlQ2RStRYVRGS3Y4L2JmSkdBU0tMYU01ZUZE?=
 =?utf-8?B?THg4QW1ySlNVT3l1U1dtb2VNNkREaTVJakx0enRGMnh2clBVZ2kvUDA3OStX?=
 =?utf-8?B?Zm0vdnRyMkxVa1d0amdneW5idERoQ0NnOUZtVVgvWFRkZlNaekxUT1ZMNnFz?=
 =?utf-8?B?MG1UR3VEZDVLZDk3d0xqYnpEZ0JLRlJTc01OZFg5ci9TbVdiL0dBN0xkQ1dR?=
 =?utf-8?B?a1daTldSWVJGWjh3emsxRVNEUHRyRU9lc1grYUUwTHNnOVpYcktvTTZRQmxw?=
 =?utf-8?B?Yi9JNTZuZlNIMktlWWdSa3pVb3J0K3poeVpJaEQ5QXljOUtnZFRjZ2pxQmhs?=
 =?utf-8?B?Y3UzQWFMWXhOT091UHBybkJqUTd5RkoxOGQ1OXMzUTQvbUZqWTQxT05LNmt1?=
 =?utf-8?B?MjdYQzg1MDBkVUkwbEdHT1g4bTdxTFZ2VTg1K0dXNGY0NU52K0o1bWEvU2lM?=
 =?utf-8?B?bXY1dEZXTjFpQW1HTmZRM1F1RDNUcm55NmZXU093R2RINWZoSWcwWHFpc3lY?=
 =?utf-8?B?NjNVYWZmTWw3Y0VBQUZKM3ZwWXBBWVNQS2hHVzBQU1FGL2xEUUdRbjlqNXRn?=
 =?utf-8?B?RnE4M0JYRTZ1RlFlOXhGaGJINFhNaTRTanJuUWJnbkNjbGwwaWFXaytzZ0Fu?=
 =?utf-8?B?cVpPQkY4bW8xTkpaNUQ5UC9PUC9tZ2ZEbkRIVWJ4YXdCNkhIb3pjaU1oUUxl?=
 =?utf-8?B?VEZFVkRNdXpkQnE1ZXVrSkFkeCtVTWN0WElyWkRmdTJPVXNVdmRkT3RvQjZQ?=
 =?utf-8?B?ZEVVZ0Q0Wk9maGRneWhNc2RqemxnWU9aN083eVFnTEluNWhlLzhxN1Mva2h4?=
 =?utf-8?B?ZEFVVHNMT3ZPYlBVYVRGbUcxYTM3NFhiSGJOUm11eklKNHR0dEhlcWt5L0w4?=
 =?utf-8?B?UFgwNG9tZTNiSU5HMitERHN2U1VMbVA1RVhpWUlRRnBKM0NhQnJ5cWM5anBo?=
 =?utf-8?Q?RdlN70Tob3cogsh5gy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eu/00sqW9RvjhA1lq3WNqbmeP5y9L0JC5oI9l+fBRxmSTgHclBXvbHas934NLXMkGleM4gB2gerwCIPYRVVUGSlFAUO8pO5HO7TNJ9+RVHjhiSY8FGpFUr5DMXeYkFLpq/87IsK7/GC5V3Jg7qEySAi9pIzqMP6z90OlrZWpE8S28LSMTJurTkrV1aCM0nxeycht6+5LnC4Y+fHUp0LshaIehlh9PCic8I4PP5vZGqXH9OKFbXbQ/45Cwj2LCVTy0iOvmsc4JHNXQ0AsRR4wBTrMr/T78YO3dC13UHcf/52wrnJm3wZZaKFwN2fX52k+OBQMY+Xn0yEbCHy+Vhb9Bw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4283a744-44f3-4f40-2096-08decf01342d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2026 19:22:01.0044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kkjI+ourU6+lsfKBW8nKwPPJS5eKhisEhiFpf6EdwANpM6gQUgmD1f6bOTgx8Wy2kBtdltOt2PY1Uc1N3ECnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3641
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDE5NiBTYWx0ZWRfX3By99SCa/J7/
 FPDlafmEiPJNCd4cZHIVXPJPuN3dwv84yq2z73QDiizfCrG1KdvM3UecbOgMOjz8butiut+R6kU
 QJeVbyL24vAEHnRchk0iY5Vp5k40Xs0=
X-Proofpoint-GUID: sm6qYPQEE3U8g6tb20tITZ3fUSqQHJ0O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDE5NiBTYWx0ZWRfXxKcA47UalaXu
 8Nr2EfhAJhO2Q0gT70n88pmzeqLWIyXXpDP31r3v7U/WtHSpVGkLU0E4j1saL1gyIkfSLp1IfNJ
 WtQOb9Wzgg6GfgIYa4Gy54MuuHfEbJnyT4C6v9OeMnRwc+xbb2/6kevAOyvuGj6Sdl0iY3r0XNJ
 XpZoQ5L2U+MwMb8aTLlmkab9uCoGWMOfkJGl3Sn/TOnzRwQ0rFvPugfoJSQEaLrQtb2KdL0TcRm
 xg2paClUT2djAkqRSgEeS0bLiGcpfcQIb557itEbqZxKYkLu1CCe9AU3ZR5t8ElYlR3z9hfaHK8
 KGP6bfOIzxMSSgO6GXGHBEexbXP89gkHs4tAUes3AKRZUKOVXjHiujHPKMkxzJdBAEz4fAsiu33
 I8iSLMetWzl6NGqWoU7jRVyB6fY4z7NUAxwRJgN/fS9eevBiTSb6geHUkSnVb1BsDXgPxTw3j7+
 HmSb5gn0PLfbTE+ILHw==
X-Proofpoint-ORIG-GUID: sm6qYPQEE3U8g6tb20tITZ3fUSqQHJ0O
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a36e85b cx=c_pps
 a=+R+biVznOuC0gx6e1UCQpA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=QyXUC8HyAAAA:8
 a=8rWy6zfcAAAA:8 a=7CQSdrXTAAAA:8 a=M5GUcnROAAAA:8 a=bt5KbKNvAAAA:8
 a=pGLkceISAAAA:8 a=8sUFiZJwQIRsS81TctwA:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_03,2026-06-18_03,2025-10-01_01
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

PiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IE5pY29sYXUsIFJh
ZHUgPHJhZHUubmljb2xhdUBpbnRlbC5jb20+DQo+ID4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDMs
IDIwMjYgMTA6MjggQU0NCj4gPiBUbzogZGV2QGRwZGsub3JnDQo+ID4gQ2M6IHBhdWwuZWxsaW90
dEBhcm0uY29tOyBTaGVidS5WYXJnaGVzZUt1cmlha29zZUBhcm0uY29tOyBLYW50ZWNraSwNCj4g
PiBUb21hc3ogPHRvbWFzei5rYW50ZWNraUBpbnRlbC5jb20+OyBJc2xhbS5SYWdpbW92QGFybS5j
b207DQo+ID4gR293dGhhbS5TdXJlc2hLdW1hckBhcm0uY29tOyBGaW5uLCBFbW1hIDxlbW1hLmZp
bm5AaW50ZWwuY29tPjsNCj4gPiBDb3JudSwgTWFyY2VsIEQgPG1hcmNlbC5kLmNvcm51QGludGVs
LmNvbT47IGdha2hpbEBtYXJ2ZWxsLmNvbTsNCj4gPiBNY25hbWFyYSwgSm9obiA8am9obi5tY25h
bWFyYUBpbnRlbC5jb20+OyBKb25hdGhhbi5XcmlnaHRAYXJtLmNvbTsNCj4gPiBEaHJ1di5Ucmlw
YXRoaUBhcm0uY29tOyB3YXRoc2FsYS52aXRoYW5hZ2VAYXJtLmNvbTsgTmljb2xhdSwgUmFkdQ0K
PiA+IDxyYWR1Lm5pY29sYXVAaW50ZWwuY29tPjsgVGhvbWFzIE1vbmphbG9uIDx0aG9tYXNAbW9u
amFsb24ubmV0PjsNCj4gPiBGYW4gWmhhbmcgPGZhbnpoYW5nLm9zc0BnbWFpbC5jb20+OyBKaSwg
S2FpIDxrYWkuamlAaW50ZWwuY29tPjsgRGUgTGFyYQ0KPiA+IEd1YXJjaCwgUGFibG8gPHBhYmxv
LmRlLmxhcmEuZ3VhcmNoQGludGVsLmNvbT4NCj4gPiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBjcnlw
dG8vaXBzZWNfbWI6IHJlbW92ZSBjaGFjaGEtcG9seSBhbmQga2FzdW1pDQo+ID4gZHJpdmVycw0K
PiA+DQo+ID4gVGhlIENoYWNoYTIwLXBvbHkxMzA1IGFuZCBLQVNVTUkgZHJpdmVycyB3ZXJlIGp1
c3Qgd3JhcHBlcnMgYXJvdW5kDQo+ID4gdGhlIG1haW4gQUVTTklfTUIgZHJpdmVyLCBoZW5jZSBy
ZWR1bmRhbnQgYW5kIHJlbW92ZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSYWR1IE5pY29s
YXUgPHJhZHUubmljb2xhdUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+IEFja2VkLWJ5OiBQYWJsbyBk
ZSBMYXJhIDxwYWJsby5kZS5sYXJhLmd1YXJjaEBpbnRlbC5jb20+DQoNClNlcmllcyBBcHBsaWVk
IHRvIGRwZGstbmV4dC1jcnlwdG8NCg0K
