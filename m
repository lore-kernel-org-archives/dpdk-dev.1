Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E0FFCC9CC
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 06:17:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51225406FF;
	Tue, 10 Mar 2026 07:17:22 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id EF8E44014F;
 Tue, 10 Mar 2026 07:17:20 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A4Bqll462246; Mon, 9 Mar 2026 23:17:20 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022085.outbound.protection.outlook.com [40.107.209.85])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ctc28g6h7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 23:17:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdhw7TJWT8ZypuSLUDabi+lz4GZtGPncpCH5/EMFuT5tSRwwi+K71zNwW+60IMBGyjekFvDgEap0IyxgcanjwBkOGym8o6kJGy+62VvE95IWG+UkSO5pQZGFK1l9deWEsiCmo4nn9bN5z5cRrYk5SAC/neBsU6M141e1q4VlIPgoJJVYNafkoo+3cZHqEqqyz9zzEEbPgaCjCRUtJ4w2m+VK1k+fF2v11hok0ho56h9GDW3IIJlwjMpbX+qFmAHyMtSNI/SKPa4cmXhqOX+3ocz+RGFYl09VntJdL7Y98Mq6RkIWwOX0uVMZT7wzuCkKvoS029awC+LWv328GtjPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYSe8tGukfPTG/uQpFbfSVP+ZqpuMWde27fQANZlcec=;
 b=U607fVXCmH9ftHQ3cZp2tmrpzUKuoaXjbNSeNtBHYmrR2Y88pr0mUqy+ATPruNSlc/HxO3B6VdcpiNIRdN/isrlbhCCW9OxRvlBu0vkKOSaNipHZ4LRjulPsaKf3w2lZRy+b9e8c/coYEhrXL/1d0K9J0jV3J7rT6wOX3XHu04+qpzKTilK9kqPDRupij1dhHZqbDlnEp1RS29zTZAh4wXC1pybswZ/UmZbs/b0QWTQIqWeG7I5KttEjNXq/K9wtjhJYApvu1V1hueBOO/3A4cRGA5frkbuycG9iLSCgpBzETazBoALK/Fnxo6I37ZJmqkbM5GaXg/47bAiRUENA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYSe8tGukfPTG/uQpFbfSVP+ZqpuMWde27fQANZlcec=;
 b=Q2DxDuKKxAoMabeUkwGW8yVTmD8iHaa/fVCqJ8dsI8Bw5DZgWZSFAsmmxFzHEDkuPNeBKZoWg7UR2raICoLD/0JeRDJ+VgqSV6Ort/dCNWmR/bKXMFWitwa+x1gIH1edjdZJ2xLP4LstYllBsrwYUWa/wqafZAvTrHcA07Edj08=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DS4PR18MB927549.namprd18.prod.outlook.com (2603:10b6:8:329::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.25; Tue, 10 Mar 2026 06:17:17 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 06:17:17 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Kai Ji <kai.ji@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [dpdk-dev v2] doc: update Multi-buffer library version
 for DPDK
Thread-Topic: [EXTERNAL] [dpdk-dev v2] doc: update Multi-buffer library
 version for DPDK
Thread-Index: AQHcrWfoPBqPwNEdgk6e1UZZptMK+rWnT5Hg
Date: Tue, 10 Mar 2026 06:17:17 +0000
Message-ID: <CO6PR18MB4484BB9BBF4D24CAACC01C0ED846A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260302164742.2230427-1-kai.ji@intel.com>
 <20260306125059.2451999-1-kai.ji@intel.com>
In-Reply-To: <20260306125059.2451999-1-kai.ji@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DS4PR18MB927549:EE_
x-ms-office365-filtering-correlation-id: f3e9d0db-c7fd-4ae2-f09d-08de7e6cadec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: ymRLnqjy+0qvyMwc0HALsCzK0XxD3lpbrZXoT/KBh/q9LhrIT+26QLTCzgNhb43BPrlZJ5BMbUa/ptkeUWznCBWkWJw3K6O6oGc538BPXgEssA/avb3LQgAr7TeHGQZJd3ykpb3/6u3Z2J7AGzxOPVndwamlYGS01OW7CxD+XfpN5ehyKPji3hUGh0cJPNFJF9MsTPTv8IisR37X9b4uzl3/MpY3oBf8RH9eJV46z/iz+tE+z3fkj6jf01Y2YIVTvxFF5jp43biK2jhRif9MyCd1cMwVdKH/1bTkj9eS4+Ucaa1Q4Mdjwuv3TC4l11s8RrZJ79UaI3FWmF7bDxrlRnyqSnB9gA8TCM7n59PxQhqt6t/2KRpXcYQfjUPqhoO3C29YMmysSx8gD5nE6bm63ZbOB+ca0szHlTlUdKdlzftCpEiRRMqNmw+HfIVHI4WE5nbMiPp4BeEy9/m1CPXnK9dElkNWcc4BnPLFaGTJ0hGcEzHqzXEOYK3nGeN775QIiG4nXLYsQZTJQFKSCyGkpPG/hENn/dOcInSRkXFkS1isctX+CEQYtwpxm3L3BIrG/mm5bVCv/3EQMLqjqozvZrw5QLCSRIA6a0ZX/Pg+VryVUZ0GMIHpKHn7v1V1b8MiJJwhnyHRJNU1pvGYWe5uTRYvg32sLVKL1Q5J7jJ/AFsj37eUhl3wQoDTIjesCHq/gQ6pAmN8tbR9X2qf1Pc5z4oRE0N++OzPpBGVly6PolLmINIErRgOYFSifTIsfbJqoCX+EO1+Zy9xNOoebel7FncQY28DF0VyhQ1X2WS8XCw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEhyM1pMcXN3Y29SaXU0c0VIWk1wRjkvNGE2VVhuTjFXVTg5QVhDRzI4eEhQ?=
 =?utf-8?B?NWltUGd0WGVMMngzOEpQMXVrZ0dnaHU2UVdEUUlMdldLdnhETitwOUV3UHF4?=
 =?utf-8?B?TG1DYVFyb3VBMkh3K1BhYkFtYWFhcTNqWVJlQWZHbzR5MnpvS29HcW1DRmRW?=
 =?utf-8?B?M0N4dXE5WCtFMFRkU1NUOTgrUjZ1L1RWMFMyejZhekJSVEtHWGtXWUUzRnFj?=
 =?utf-8?B?SVZFNld2ZndvQ0VMT1l2QmxwRUtPamR1NjVaZFlLcHJhT1RJNnZMQ0hGRHp5?=
 =?utf-8?B?cDgrZG1MNHc3Q0ZiSEE2WWJKc1RHNXo3QklPNDcyZllYMVhSMXNvTnhWZDRP?=
 =?utf-8?B?R0cyNncvRmh4SlRMK0NzS2crWG9MaDY0MlUvR0RJODh4eGI5MkVROU0yeVY2?=
 =?utf-8?B?Tzk2a0cvaTY2aUZkSHNjKzZqeHRhT1pmb0pkNjNzWTk0b3JBNE50NEZwTVFC?=
 =?utf-8?B?L1ZGVmo3WXhBRTU5QVBIWlVtNnk1QnhRQmhGRC95NEgzNUJLU2FqQ3dCT2RO?=
 =?utf-8?B?UHhxTktxZDFvbkM2a25Cbm9BSS9UaE1IZVBTMTJQVEFwckZjbG5jYVRNRkZS?=
 =?utf-8?B?UHhHWFBjbXRSUTIvbUtvMzMzWE5wVVlwQVhDMzV3aWZRQitvUVYvcjM1SnJZ?=
 =?utf-8?B?Q0h1aGJIMk1tdnlVRkxtVXY4SS9XaGR5ZC80cWZyUnJrZmZwMTNUWU4rVzJK?=
 =?utf-8?B?M0ZFdlNjTXAxWnpMWEVNNkt5S0dRMDIxcVZoNlBQUldoL25mU0tYVlJyZHBs?=
 =?utf-8?B?M1ZVY2dPcGtELzBTcVY2WDJTd3ZnQ2FFdS84T0lUQWN0ZC9VZGpZS01DUTZr?=
 =?utf-8?B?eWNVR3hGQmFXdEZlSnNkQmdENkJaK2ZYa2ZaYzFFZ3VpQTErVFlmSVczd0tm?=
 =?utf-8?B?TnU0cG1ONktYV25IWEpoNW55c3VRTlRENU1oOUUxUUFuMlVvNm1WRXZzQnRP?=
 =?utf-8?B?VlBDT2tqQlFweEpmK2NaYWprWndVcnkzbVJOS1FxTW11TW1SNXY2YUl0ZzlU?=
 =?utf-8?B?WEo4YlJkM3hVLzIzejFEZUprRmFiTWVadEZhK1RYUm1BSTFSenVud0x6dDc3?=
 =?utf-8?B?N3BkbGNVN09MQnhhUjE1Ty9QTnYyTDNGajNRaWV5MDVRbi90TzIrSU1sQXdE?=
 =?utf-8?B?c3BGZDFVS3BqdjFvZjZManAzeWo2ZUozNUtzWDZiRGRTakkzQnE3RkxMVlB5?=
 =?utf-8?B?NUVFSTNaZloxQXpPSmp1MXUzOE1VWXUzWE1HeDI4NmxMWDlDdkN3SDQwbGZY?=
 =?utf-8?B?WTNRYnpXMXJhTlFqUWNOR2NHbmc0OUZYQjR2aUgxOUkyUzltRUxVMjZycUta?=
 =?utf-8?B?djBRa1RFajlyU0Zmc2NVRVFMdUJHdnUwNmtHN0NKb2RQbkVJRElONjRISVNJ?=
 =?utf-8?B?Vlc1VVk2WEJHMmxFUkxDdE9kL2dKNGdsVUZVamc4dWRJL081Q3ZiQ0FOVUFw?=
 =?utf-8?B?SEJ4bFkrQ1ZMS0pueitUbGVLT2Q2QkxZanpZWWJUeUtkaDZ0a0JlT1RJNTFo?=
 =?utf-8?B?djBJeGFiMUNvWTYvKzRKM0N1L1MxZXVUN1JvYVpGOUNOdVJMeFVIOGVDQlhL?=
 =?utf-8?B?bHFwbXJqR3lPbmUrRmFYaC8wM1VzUDZnSDZGaWQxNHdTOGptenM1WmlDRVFV?=
 =?utf-8?B?dFdlSGd2VGFTQVV2ckh4Q092UUhURlhjMnQ2VjRrWSsxbUJsaFVqM3RoQUd2?=
 =?utf-8?B?UTZnV3lwdElrUm9WZXhESVZYdXFzS01mL0I0MWE2aVB1bXpubmgrUVJjVE9r?=
 =?utf-8?B?OVdjdEpiS2k5QWIyeTlDS1l0ZGpqUDFRWmF0blJ1QVlhMm01UEpOOUU4SEEz?=
 =?utf-8?B?cERPait5cWRMWlBQaGxEcU9oaFVsUU9zQnY0RFJucGlZUlp6QStnalFLMVhI?=
 =?utf-8?B?WVJPcHlOTC94S3RwT2hRZnVOeVp0RWFtS0ZPNHNSNDVrM3FVOGlOdjRHOXU0?=
 =?utf-8?B?ajJPdWFKWTN6OHBMUkQyZDRWM005Yys4MXprSkJOc0xPaVNlaEZ0VlpxRHdn?=
 =?utf-8?B?a0tWaHE4KzRFMG5PditNL1NDRXc2bVcvalRRYmF0R01oQS8zZFBDaGh5Qk5j?=
 =?utf-8?B?RHBRTDgyUCtsYy8yTHpQaGVsTmRMREF5V2hINlJRTXAwR3JxMlllWXFDK3Ja?=
 =?utf-8?B?cEEwajVXY0FwSGQzTmJPYlJUS3I1WW9OaThFUzl4V0YwODBRR1FhTDlIcDZC?=
 =?utf-8?B?T2F6TE9GUE95VWhOZElRNTRNNXFKQTg3Z0dYVjIxekEzVTZYbEJKQXdXYlNj?=
 =?utf-8?B?dlNtSnBscXJiQUUzblRsTHBVSE5GNnEwYUU4V2o2T0hCZUJ5dS8veTFWMTBJ?=
 =?utf-8?Q?00xdQC2KPr1dd03rN+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kqMVE8TyjflgY4iA7iGIUMU+H91LVOisGWpdd/8w49rIJDxeO1LbwOUEPr/M+cKltuKQUP4J+RNgYPW7rkZxv9+EDWD9XTu1vMeayQBR+sUHJl8U7bWEsrFsIJrHPnCttF69I9dDNEq9h6BDM2JU75Kve5pSCpzu5UwZO6i8sWyH7+twmu569gPHedjRfwC2vPAOPA5MRQqmDEmBx46gKL0nevVo6C4v5Ow2mU0jtKIN/ZcXuFurBMalYphu8sifZkdIHQC8LQ5qgMH3tVjlgWn46XGDABlZEH5e2thbao5Q15iQphkacz7/SCaW6RAJBcKYGbcJSat9xX46RRJyIQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e9d0db-c7fd-4ae2-f09d-08de7e6cadec
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 06:17:17.2602 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ns0VmKjphqgswItam9KWHLzT8OjUzxZT3WKREeMONIvV7R0SNZHwp1GivCPqy9mrjKMmoVe26j0xMyjQQWfYMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR18MB927549
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA1MCBTYWx0ZWRfX4jYiyWeRgH37
 bPU4gN/nPAyTuHW93c4ms0zOUi+8n4xs75CphreWeGGYPfo9NVo2nr5IFMXjC4njzMTbaq49ZrW
 frnofy7kartvSLlyN5XwS/2q0yhddhkW54YzmfFgetMvLtVdwj3Q+cXoEoH1cD8zCpXxc/2a23r
 lakpvCdtx9hXu6DWQQXgtJNqFt9TEI0suDwJF7RKV5TTyzbdhSkow/X9i21LG5BBuAxKm7u/sGI
 UBGfd2AtLZPTYsKqRkVoiAe04c/B2MIoo0ff33/Iqfs3pNie/HG6Zmklt9CsNXgG2kIimJOJcZn
 63dZsE7zrlC6wf7cQBUH4lRXlWH6oqr4341gRLJ/43wDNyO39zS8ECeyjVQUrPyXuvvPGL1nHbx
 T+hWNVYIpkAdbIvLfGmnLAMDvYceFS6UlvDGfWAARGOK7rMuWtpHdRIzxtF455GwBEWWQIXKRBO
 /Lkd0SOuPqkjLk30+uw==
X-Proofpoint-ORIG-GUID: MMOoi7WhIGIl_OGPk2Yk4kXu8cxhyt0e
X-Proofpoint-GUID: MMOoi7WhIGIl_OGPk2Yk4kXu8cxhyt0e
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=69afb770 cx=c_pps
 a=eu4xXFuXQ3Ojp8lTxhUiOw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=QyXUC8HyAAAA:8
 a=B58UZ0aZRqPeVUleCBMA:9 a=QEXdDO2ut3YA:10 a=XqwKkIuMdFcA:10
 a=0lgtpPvCYYIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
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

PiBVcGRhdGUgdGhlIHN1cHBvcnRlZCBJbnRlbCBNdWx0aS1idWZmZXIgbGlicmFyeSB2ZXJzaW9u
IGZvcg0KPiBEUERLIDI0LjExKyBpbiB0aGUgY3J5cHRvZGV2IGd1aWRlcyBmb3IgYWVzbmlfbWIs
IGFlc25pX2djbSwNCj4gY2hhY2hhMjBfcG9seTEzMDUsIHNub3czZyBhbmQgenVjLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogS2FpIEppIDxrYWkuamlAaW50ZWwuY29tPg0KPiAtLS0NCkFwcGxpZWQg
dG8gZHBkay1uZXh0LWNyeXB0bw0K
