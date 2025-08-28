Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DC1C8303F
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 09:42:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B99B402DC;
	Thu, 28 Aug 2025 11:42:31 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id DA7814025A
 for <dev@dpdk.org>; Thu, 28 Aug 2025 11:42:29 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RNVKs2011234;
 Thu, 28 Aug 2025 02:42:28 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2126.outbound.protection.outlook.com [40.107.244.126])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48tbs0989b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 02:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxE+oBWewHh0Edk1xc1IueWnhCUpQsp9QdG1Qat21c5rTXue2lkWO9wrc5vl5aHzJ4Vrj/xqm5ixRu65HHJ4xa4Kyeh7I1903MBuv4KZIpOxyJUDb06QrAr0X1zsrdeJFBOpGc/p81y+nu0d8gx7WRzeDrk/f66NPMOvW5IBOHFzUGVIpn7ashSdqQfYL5u0uWXm7wbKCKjF1VHLlhBiurO9cedoMNrLR9NaOQKmpWPYRv13PDy7F7EDzRgqIMN/6dvHub9Mva7NH3Yg4ecAsBieQEa+PQoqfES5NWuY+FMJokMDQe1WMslaacD2xWMzAWlHas7VI7iU3xCSdchv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXJ07n7VDRL9CYnTbxBLFE9zkUIGDTA0a/cd3Fd7Jt0=;
 b=OPO9kk/CkAzJxzGotw4RSj42ByBpVRpECmQETxJclRaFNRDU2zcxbmv9Wi2NYHma386DxOlp7dpYamtb7NqtktPJWrdtPhkIjMQJksOfwvycEZRz1UK/wJstY23JWzfrBJPB+4E8RJXoH0StMVGSpjaPkIuSnkoyppZNieyTVMDR5Bg9KC1ECj1uAehWpGGmQeyz+RIdoA5tWTZeLY5yX3sD/aJqJrGqVvzBu9MAZzGABVZvJN5xKKW3379l8mhm1B2+sqk34qDNPVKLmt+oRDwYTb0BVvciLIfHO6yjsc/zaxfwCwSNC7Pjz/3fo2ib8utpjpzj0QrZ5p8SniFmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXJ07n7VDRL9CYnTbxBLFE9zkUIGDTA0a/cd3Fd7Jt0=;
 b=e53uSn2FVLlF1uTCRMkeFi5QZMauAVuTOjijLEK4NNpbbTxQdSn1NxJTqyT0LaOwaPOXlzZvqUhUrMHJNDjSoCMoNMaFVyG65Bb4sPIdFh7JIkHmFJxuP2ywjKCvy7M6ZCFnByf19/YQALDMdZrbUFjQ6EKaLEdN4A0BxUFZPQI=
Received: from CO1PR18MB4714.namprd18.prod.outlook.com (2603:10b6:303:e9::18)
 by PH3PPF0FE498FA6.namprd18.prod.outlook.com (2603:10b6:518:1::c87)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 09:42:22 +0000
Received: from CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06]) by CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06%4]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 09:42:22 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: Emma Finn <emma.finn@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "kai.ji@intel.com" <kai.ji@intel.com>
Subject: RE: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling pointer
 for SHA test
Thread-Topic: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling
 pointer for SHA test
Thread-Index: AQHcF/4n1AirPyIQZ0eW5+X0CURUuLR3zazw
Date: Thu, 28 Aug 2025 09:42:22 +0000
Message-ID: <CO1PR18MB471416C114E8D59E97EEBE2FCB3BA@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <20250828092822.2791101-1-emma.finn@intel.com>
In-Reply-To: <20250828092822.2791101-1-emma.finn@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4714:EE_|PH3PPF0FE498FA6:EE_
x-ms-office365-filtering-correlation-id: cc8ecb93-6a56-482e-1d50-08dde6173039
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Nk1rVmJtT083L2FFa2FhWUJKUDZIUU5VNlV6YzZuL2RaTFBXVmJSaCtsVytu?=
 =?utf-8?B?VER3M0VvbzJrYTJhYlZyWmU5NTJnY1c2UzBBeDZyM0RpYStmd3hYN2hOZVFL?=
 =?utf-8?B?WHg0WXRaT3o4amdJaFhhTmVqNWI3TUNBMWt6UU1YNUJaejYyc2RPeVpYSzVu?=
 =?utf-8?B?UEx5WWdkU2ZSNlMrZnVqMitBaUhwaHZMYjVrcExFTmpVZXROOGNQdytwQ3BY?=
 =?utf-8?B?cTNZZ2V5aU8zdGNmNE82L04rTHVwcCtVRmtIVUtWVEhJWW9YVm9DK1ZKTGxG?=
 =?utf-8?B?dlNrb3ZEcHBBWDBHbzJyV2p6ZFh5TW0zQlAzbEVOUXNwK3NOYXpXcDFwQ3M3?=
 =?utf-8?B?SUFaMGVYdHVqamZURnpkRWNKdlhQbmJlMjZvTUExbFFCOGhPNzY0SjRIVmRm?=
 =?utf-8?B?U0toQ2lGckxhWkhyRlZlQVZzSGFuYU9MOGhPeUxxVFVnWlg1WktrNmZPdUx1?=
 =?utf-8?B?dlFRN2J2R2xqc2FZcUNqR0laZHExek9SMnV4WHR2WGUwbEJaMW1uRnMzemxt?=
 =?utf-8?B?dlBFZUZlbzhralZRblRSNkZ1cW9YRTY3eVBNNnk3QUp1eWFTeDVhR29iaHcy?=
 =?utf-8?B?amVDeEcwblZjNE1DajhmcjgzcEZaVVowdyt3VSsxYitSQTd0TVZtMGVETGFZ?=
 =?utf-8?B?SG1oY0ZwUlIxV2hmUEZZMEk5d1NodmpzbXo2a3RKMFRWNlFjbzRqQSswVjk4?=
 =?utf-8?B?NllQczVGZ2dpelNWaXRIYVZwQnN1dTZwbW1GS3E1ZERpdEtMbmlFZUV0K0p4?=
 =?utf-8?B?anRUZmlzUm92dWprRjdsNVVwblRzMUo0cDJFbGNlNkRaR1NMQmpTNnBVQ0wv?=
 =?utf-8?B?YkZzMXJ3NlFKYjRDV2NlQUQ2N0U1SWRHck5McEFLNnFkbmYxNHJtbGl2TEhE?=
 =?utf-8?B?TXFhV1BIbXlqTnhsLzFaMUJWLzFOOTdTbStYSWFoN3VoVTRSM201Y01paWZy?=
 =?utf-8?B?TUtuSFdvc3NOa1JMVXVvVUZ0Q2RINVhRRkcwZmpvejZMYytrTlpaVXpITG9x?=
 =?utf-8?B?Mi95cnU2WW96ckFuMzg5bnVnVnZ5Nkk5Y2VHUEZyV21KKzNxdnUrYm9kejVN?=
 =?utf-8?B?YmUzSHRuMUd4OHpyMk5SNlhSdk5MM1lkRFMrdkdUMlRmeWQzZk1aeFg5dTNo?=
 =?utf-8?B?a0RSdWFXeTBNUVJFUFZwMDdZNmh2NHBwQzlEZFBGczVIREpKQlV1emIzOVFM?=
 =?utf-8?B?QVVaM3ZEdHlaZ2FjQXpTYVF3ZHhqcm5kSjMvSVprTEtSekxOMCtQMVBBSmNp?=
 =?utf-8?B?c1AzNFhqY1pwU3RVb3J4TmRmWjRhcCt3ZGhMSlN0SGxqR0l3Y1ZpZ0txcnNZ?=
 =?utf-8?B?Tm5DWUxoZzQ3MUhFQndQUUJpaExQTGYraWpHVERJZFZ0NmlxdlZndmx5WlBk?=
 =?utf-8?B?Q1FjTWt0Um5qenhNV2RtZkQ5em13WUV4QXBsRzRSUC9LYVExSEVSckM1SXQw?=
 =?utf-8?B?N1dROHZoS214eEMyTzZIWDkxZUZpNDFGWVRuL25SUTV3WlU4Ny9pR01PaFRj?=
 =?utf-8?B?WEF3ZFVWQmpLWG0wa1g0T3JhcUhQeUZoWVhaMWpLSnBZWEJ5RHpZb1NLa092?=
 =?utf-8?B?UE1Tak5yWmJBYi9qbTBKeFhHMUowa1pMcHc1ZGJwSHVGODc2N1B5cUtnUEs4?=
 =?utf-8?B?c3dzUFl0ZC9iRzdiQkxoRCs5dW9tNjNuR0pUcFdtemd5UGVPeWF2STNGQTJM?=
 =?utf-8?B?Zy9mSzFmaEJSVm1WVS8xYjYwL3lFMEcwb05obmN0ZmpmV05aYnM5V2pHVytH?=
 =?utf-8?B?NVUxMEpWNUhFQW10VURtYkpuc1NsaEVnV0xzM3cvMVNrSWhPWTVqU1JQOVh6?=
 =?utf-8?B?emRXcktBNHVITytCLzlKdTdCRUppRWVsaGcrTlE2dGwwTkFvVTJnRCs2NjNw?=
 =?utf-8?B?cnBWZjl0NUR6TE4vbm9waXlOaUVTZjI2OWI2YTBTU3hhSDNOYzV3Uks3Uy9a?=
 =?utf-8?B?cEVJczN1M2hHZVVIMVVSYSszcDlzaXROMVR6RUlGaXorU29aaVpsMHZ0aHhh?=
 =?utf-8?B?emdNMU02cDF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4714.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGJ6NGl3Qjg0LzNrRTk2VUsxUEJIV21kZi9VTHl6OFN5QXk4M1k1d1hob0Vp?=
 =?utf-8?B?MmI4SW9VWUNpNjlENVgzQVZzNGF1YzM4RXFCVjRLamhxMm42aHppdHNaVTQw?=
 =?utf-8?B?TVhqUVZSdFhIMFdnWC93UUo1UHNSK2xQT1UwWTUySm5LVENSbkFxNk1Tb0d5?=
 =?utf-8?B?c2ZDblBaQVV6N29TVjh0cm5BOGZVS0dPVFloYW5GS01aWW85R3UvMXprby9L?=
 =?utf-8?B?a3NzR2c0ZVJLc1dUNEx1U25wM1BWWnRmaXRSSkliaU1lU1JpK0tWbnhsU2Jj?=
 =?utf-8?B?bHZTdGJaTDVZcURkcGFxNFJvb1h6RXZ3eE1yeXp2bnNtOElPZVhrU2RCaGQy?=
 =?utf-8?B?enFMYlZ0YVE3cEFMYlFMT3lMV0t2RkxpN2hla3QybGZ4Qjcxb2NvQ1R4WVJk?=
 =?utf-8?B?U1FIZGtPeDBaQnA3ZjVDM1lWeXdwU2NPWHFIYks2MGMwTEVYK29DYUpONTlu?=
 =?utf-8?B?a0RYV1Y3K2I5VlI2UHJpMUVSeG85OXJRRjlLbG9JOXRPVEQwaGlWLzN4cG9O?=
 =?utf-8?B?UUwxSmpicWNhSDJPYmxmTFMyK3dCbG9jL0NwOVcxUUd4R3JIdU5MTlRwdWZr?=
 =?utf-8?B?WmNlQnRlaHdKMGF2ckx6ejQwNWlXVUpHN0wwR3NhVVdOSWp6WEJaNXlPaWRN?=
 =?utf-8?B?NkU0YVRXWkh5VWI4OENGRG9UcGNDa0lCNHRxclNqZURFaFo3c3IyYXJQVU5r?=
 =?utf-8?B?VTcyMFRNbzgvWWJ4LzQ4MlljeHYyY0FzWE1RZVJTTFBld0M0R0Z3d1JxSkY0?=
 =?utf-8?B?NkNURFlDbGxHL3JTZzhvNlBLUWVEMWVROUpPMldHRG5ya0IrMERZejl2M2Y0?=
 =?utf-8?B?UVJVRmJvWVdkVDBRei95UVN4LzFZUk1XNWJnbDJ4WmZlKzJCNkl6YjdNU2xB?=
 =?utf-8?B?cmIrTW5pVjVxODhVL0Nqb3I3aGN0Y0dKbW1wV3FLWkdJRDFITW52Y3hXMnVW?=
 =?utf-8?B?ZEdEejhGWFBxUHI4c1AvelByUnB1dUpxdkZTMEl4a1BiZTJ4UnpUd1lNK0tX?=
 =?utf-8?B?MkdHVWd6SzdUM0lPaFVySUk5SlpqVWNicTl6NC9VTm1LbEI2U0xFamFlYzJB?=
 =?utf-8?B?c3ZTOTEvWVdLcDVZMmNYNHhvTkU1QXlCeEx3WW5TWjdoWU1qRkl0ZGx6UHBq?=
 =?utf-8?B?b1F1MHdhTzIvOVBKalQ4cW9mWTUvSDZDUDZ4WUVaWmNzaFJuem9vMDdNam5x?=
 =?utf-8?B?bUxKaDZJYnhnUlJDKzB4dytsY2FXZ3BlelBoQTFCQXppenJaWmhvT0lqVDBU?=
 =?utf-8?B?RVk0bUIvWXVXRHJwSEU2cDQyRDJpdHVIVjlmYjNuTUViYUE2MGJPZWFVRkdY?=
 =?utf-8?B?a3ZNbDNOYjRMMmNkTlowSU1zajVueFlNR1phUTlTOGVDSklQOWZ5QXNCR2hr?=
 =?utf-8?B?S3d6QUozVVRwVGpWS0hLU2trNHdWWlVMMmdJci9IelVVa09zNjl5TWwzNFJR?=
 =?utf-8?B?Z2gvaVVDSENNYVRJZzllLzJZTCtMNzRJaUMrZGFEcDVhS1VocHBXdTJzZTM3?=
 =?utf-8?B?MVY3QkM3aTc5L0l1eFhTZ1d1MDB1TXJja01vYXZvaGFDTHYxMWhBc1BzWUtY?=
 =?utf-8?B?QURxZzdHWGNjd3djYkU2dXlIaDR3T0ttWFl3ZE13TDZGbjhNVE9xeXZVYkdO?=
 =?utf-8?B?RTJINGovQzlKUEYvMGVyTkJoMFNwazhwL0UwU250VDRrZmFITFVmVmZrbnp5?=
 =?utf-8?B?UkZEWGQzeTRKL0xDdk9RRWZjcGhiQlFONXM4SXd4OExtaFptZWk0UFhJei8r?=
 =?utf-8?B?bzJYclMzMjE3T3o5dDg2R3BjMHBOOGcrSnFsYUM1OThLc3FHUGR3YjRRbkd5?=
 =?utf-8?B?SzJYVlR2N2U1T1ZtdjRQSjRzeHpMWHc3bmNQRVliQUwyK2M4U21GaGdHa1Fz?=
 =?utf-8?B?MXZyRjF2djBtTC9xOTc3dFNON29XTTVTV2NxWW5EcThnbXBMQTdRSzArTkkw?=
 =?utf-8?B?RDFkUExGYjVKMlBWRlREOEFSNS9Vemg0VU5JZDk4cng0UWorclI4L2h0ZmZ2?=
 =?utf-8?B?ZmRBUDI0ZjNRTjJBM3NOR2ljRUMxNXprcjRyMlhMWk1hMWZ4bGFnK3JHVmYz?=
 =?utf-8?B?M2hUK1FhSG1IY3NUYWZkelZGa2htejZkSVdWdlBFdWF2cFFsR0lxQW1OOVd3?=
 =?utf-8?Q?u3pOJ/EaU2Hfgo4rDpZo1iEbL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4714.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8ecb93-6a56-482e-1d50-08dde6173039
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 09:42:22.4029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zk++Mqaz6zZFk0/i6x+O6enSBiRcygjo4JPQmviyiZOA6D7oS9LViGcg3jGQ84WBOrilPixkN78r0RIEXvQ0Nl8PYtZoiM+Tmrr6RaiYqBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF0FE498FA6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDIwMCBTYWx0ZWRfXwxpTK5RtvUbL
 aNRhSj0EPdFwQXP5WWu1Ntz8CGzc0EFTjhRZ9XYm1AEAFOhrxO/NTX7Lr4xD1BfvNoapYdAFEiv
 Qqu0KKI2PeegDdIAzrgjv6sWischRLt7QArSrzh8PYMqR7XPgzkNsvhAH7/cB5fC9vWhXh17H7w
 14Mj75f+jom7stkftnuLJSsElEP+hOo+pZqrru3Cy6e0OqPAYNgkmqpo0MO8srLb22+DxwB6Yyo
 6HWEms2HButyciSoycBPRFeL5jVA3aE+sf/DvflcywjAjb7IKR2edZjN6epXyYfjmYsiTQ6Q8Sz
 LeA1P3uSclaqCVNygh7OUL44n7eKnPF1VKsMgm8+Fv5e0yP6zMadg70bupPk+Ft90c/+alg9VAU
 MLSGI9nz
X-Proofpoint-ORIG-GUID: aZdz4t1smbobXNo5D3M6tZz6WogzJLIi
X-Proofpoint-GUID: aZdz4t1smbobXNo5D3M6tZz6WogzJLIi
X-Authority-Analysis: v=2.4 cv=WPR/XmsR c=1 sm=1 tr=0 ts=68b02484 cx=c_pps
 a=FYY9SBf2j/lNOz6iml8+BQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=-AAbraWEqlQA:10
 a=QyXUC8HyAAAA:8 a=iA0xerbi89_VzZHHn2oA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
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

PiBTZXQgdmVjdG9yIHBvaW50ZXIgdG8gTlVMTCBhZnRlciBmcmVlIHRvIGF2b2lkIGNhbGxpbmcg
cnRlX2ZyZWUoKSBvbiB0aGUgc2FtZQ0KPiBwb2ludGVyIHR3aWNlIGluIHNvbWUgY2FzZXMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbW1hIEZpbm4gPGVtbWEuZmlubkBpbnRlbC5jb20+DQo+IC0t
LQ0KPiAgZXhhbXBsZXMvZmlwc192YWxpZGF0aW9uL21haW4uYyB8IDIgKy0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2V4YW1wbGVzL2ZpcHNfdmFsaWRhdGlvbi9tYWluLmMgYi9leGFtcGxlcy9maXBzX3ZhbGlkYXRp
b24vbWFpbi5jDQo+IGluZGV4IGYyMTgyNmU5ZDcuLjYwZWU5ZjhkZDQgMTAwNjQ0DQo+IC0tLSBh
L2V4YW1wbGVzL2ZpcHNfdmFsaWRhdGlvbi9tYWluLmMNCj4gKysrIGIvZXhhbXBsZXMvZmlwc192
YWxpZGF0aW9uL21haW4uYw0KPiBAQCAtMjYxMiw3ICsyNjEyLDcgQEAgZmlwc19tY3Rfc2hhX3Rl
c3Qodm9pZCkNCj4gIAkJcnRlX2ZyZWUobWRbaV0udmFsKTsNCj4gDQo+ICAJcnRlX2ZyZWUodmVj
LnB0LnZhbCk7DQo+IC0NCj4gKwl2ZWMucHQudmFsID0gTlVMTDsNCg0KU2FtZSBjb3VsZCBiZSB0
aGUgY2FzZSBmb3IgZmlwc19tY3Rfc2hha2VfdGVzdCBhbHNvLg0KDQpUaGFua3MsDQpHb3dyaXNo
YW5rYXINCj4gIAlydGVfZnJlZSh2YWwudmFsKTsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gLS0N
Cj4gMi4zNC4xDQoNCg==
