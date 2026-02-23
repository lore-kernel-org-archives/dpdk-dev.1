Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D8AEEC2A5
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 22:32:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE5C2402EF;
	Mon, 23 Feb 2026 23:32:56 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11022117.outbound.protection.outlook.com
 [40.107.200.117])
 by mails.dpdk.org (Postfix) with ESMTP id 688524025D;
 Mon, 23 Feb 2026 23:32:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuLxnzWkxpj+F6VZpOMUMNMg/fsO9T+s24hc8nXvxy/S++WUMg0u9FRBu2XtpJg1wbYWR3iEPF3EEnoyvEoJQ/BuDLYJH1gwjmI9ce5OcSm06cce43EPjnn0C3MwJXe6R0j3WXrypH7/LEsSFZj/GAa6sp/iv72u08jY0/HcsUN7mWYWM8hmM/KfozV39uy0k4GfEd/arKAVNJZfs43baF6/Grv1hhUQO/lyo6HapsuzFwMaronXl4BJB7vWL78ge7AXHiIFBk5xJuynZZVpDhI8BP2ZsJe3ZGWBmHdZ1dqjCuwarX6YLY0pQgss0jgo8jIxHtcLgeyBpOKWPPyrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znWdTrwHl/F7SKtxuvb6Vzs0WK020CajoAWDcJ2SzgY=;
 b=WNTkaXQ8nJpyYJ9itiprkSmZZ0WBZuvTEYmwBe8KDFOIgAJ7DgO3A6qnzW4EuORK/s/NhXBa4sYo4IV2obDplYlBZpUvXXq+TFai0DYK0o1ACYBmwOnmekpVmP+s/moRLDPsvp2R8qyixoitD5Y4Knxf4dzx3MGKKFqgOfldX9u3ulUct2vKw0d3pD9Vd7aQaRFtZuVjLVBIfcvW9fAe7y6IIjnuAxj3qdAH90E1ka2DBY19YyvzjtgnGCefKMTDqW6HrQsViHazmtbeA0Xh4NZy4vCd+LsM0kWn7pCTR/B7SDRIwiZJky9GqZ7Xe5YjyuIzScDxEP3Y8L45bhnJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znWdTrwHl/F7SKtxuvb6Vzs0WK020CajoAWDcJ2SzgY=;
 b=BFOgNweyiYJsFSQfxem9xoXwS/qtUvm1aHOgwKQOVo6lzRfugrlSpR1ib8GeE/zrhSRhOLxwnBFQsuN4rSibMEReBZAPp95mmMDLI/qcVRz2n5V/iJ30u2K0GhqqptjR9tNicMRHFLuuQJoKdHyctVZMPOAsJg+bFX7xLE/ps/I=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS2PR21MB4894.namprd21.prod.outlook.com (2603:10b6:8:2b5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.10; Mon, 23 Feb
 2026 22:32:52 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%5]) with mapi id 15.20.9654.007; Mon, 23 Feb 2026
 22:32:52 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 "longli@linux.microsoft.com" <longli@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>,
 "stable@dpdk.org" <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 3/8] net/netvsc: add multi-process VF
 device removal support
Thread-Topic: [EXTERNAL] Re: [PATCH v2 3/8] net/netvsc: add multi-process VF
 device removal support
Thread-Index: AQHcotwwc2YyluoYtEqkp6flzrjaTrWQkqGAgABQNSA=
Date: Mon, 23 Feb 2026 22:32:52 +0000
Message-ID: <DS3PR21MB5735244A8284E6A58F4617B8CE77A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260221024540.659098-1-longli@linux.microsoft.com>
 <20260221024540.659098-3-longli@linux.microsoft.com>
 <20260223094519.5764d5fd@phoenix.local>
In-Reply-To: <20260223094519.5764d5fd@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a3d5177b-3ae4-4cf3-93c0-f5b91c163d85;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-23T22:32:22Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS2PR21MB4894:EE_
x-ms-office365-filtering-correlation-id: 99ec4a18-d55b-4753-24df-08de732b7b61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aGRPSEhxUmlmTnN6aHlkcDN4Y3l6QkFZeHlUY2tINU1sdVUwdC9JclU1ZStw?=
 =?utf-8?B?NzFjemJDanF1Qkl4U1d2eGpnTnNtK0V3Y3BCd1F6Z2daUlJsQUw4Nm5nNkZT?=
 =?utf-8?B?YzJjbTMxWDNlN29vdmdIRm54YjBtSWxVMlZaaWRkSEJGTW5Ta1dnZVhVTkJx?=
 =?utf-8?B?bFE0MitxZldFVnR5OXNjb1FHb2phcVFET3JIaVFXWnppb0tYaTEyQWdVWVpS?=
 =?utf-8?B?ZVRHcUx6VzU2UEp1Y0gxekU0d3ZPQ0h1SWthempBNC80T1prSXpwVXdyVk1a?=
 =?utf-8?B?cFpTU05pWUxISGhmbmFrT2JRTXhIV1B3Z0hsVGxxZit2UDRib2h5d1A0eVA2?=
 =?utf-8?B?UDNvYnN1TVBDcFNOOXEvZ1pTL0hua3laNUhHcnZ5Yy9SU084Nmg4UG02bVc5?=
 =?utf-8?B?ckFnV0tudDFCQ2VSWGJaN1ZsL21qQU03MWR3clMzVzBZZ1ZlVkRKd3VqZ1hI?=
 =?utf-8?B?a1F0YXFuSWk2eTJMUndFKzk4UWVBc3pyRnRjRW5WTUU1cmw5RVNXeUduSkRU?=
 =?utf-8?B?cjNqWWhxUnhFamxPZ0hEQXRha3pYd0RnWGZ2YjJxZG1ieHZxd05ib0ZoNmU1?=
 =?utf-8?B?WTBYZXhLUVlVcWErVmkwRkxpRk5rWUFuZFNpaHBnRkJvb3FaVkFxRTQvY1pB?=
 =?utf-8?B?eFFLZGtFNU1Hd2NaK29aV3FUTGtTcXhQcElvWXBEZ1plRG9QNTYxdy9qZmJJ?=
 =?utf-8?B?TUtqZ0I4U0txZm9tUXNjanBtclB3dWJqMFFWZE1XaTZreVNVckx1WUVsMW5l?=
 =?utf-8?B?Q21WUy9xSUtVNVpHb083c0ZZMzZ0bnpreHVjYzJJS0JXWmZPY3lLNm1JUnhT?=
 =?utf-8?B?YTZSNWdRcklXeW00M3lrdW53dUNNb2I4M1ZmYTR0WmNmbWVBZGNETncxRnBw?=
 =?utf-8?B?RjFlOWF6L0xuOTRmTklPU29pOEJ2Wml2dTlWbkZFdmJKcWw2Wjc0RFhIQnVm?=
 =?utf-8?B?SmVWS1RUMGsrRk1XODJWTHdPT1N6SC9obDcvT3BrQ0RQSXJ4aWhPRkRqZ2FQ?=
 =?utf-8?B?d3NwRUM3bEFwUnpvWGVzTGRqTlcwdDBHWVlKeXNUQzFYTWRXSXhJZmpMQ2Rv?=
 =?utf-8?B?ZHRxZDl0SmN2SDBNaWRyUnhuSU5YcFJucmNVNkpVTm45ZExkakFES004ZjdX?=
 =?utf-8?B?dzBYTVQ4aDZkTU9GZjhuN3B2STRxQ1oyU240dDNWRUtFcS9lSUU0dVkxUnU3?=
 =?utf-8?B?aldvUzRMU3ZQMG5tdU5FbTc2N01OdmNUc2xpcE9FRGozNU4vT1BYUDhBVHRn?=
 =?utf-8?B?QU9ZU1JIRFB5UjNPWjEweCt4YTlsT2VldzF3amZNY3JZRUcxMm5wN3h2bVVI?=
 =?utf-8?B?eHg3WlgybTN0M0d5U1JRQi9rSlViNVhUWGpBeHgvRVdaSmFZamlwcHIxUjhq?=
 =?utf-8?B?YkdSVEh5OUtSYTJSeWZ4eGlKZjltNTVZSHVMcDlOT2JISEFNU1ErM3k3cVFF?=
 =?utf-8?B?TlluM2k2NUZXeDF1ME04UVE5VFpqaFMwN1ZOTU1pSDNOK3R1WTZ1d1hsclJD?=
 =?utf-8?B?Y1NEL1piYVoyUnRVZXdaTjdnTjlLZkt0ZzVpZUI4ZmFYdzB3QVRUYm90MnlU?=
 =?utf-8?B?TUZtZUJvVG5FWFpxeWRHamRNMW1sRnZrK1pWV2crSW1tbndoVE5YdStKRlBm?=
 =?utf-8?B?aUZZSjVkRWloa2xrL0trMHZyWmdLU0U0Y0ppS092V0E0VzFxK2hMWUZKWTRY?=
 =?utf-8?B?c0NIeHNsK092dW1tYkcyZVUxTnA2K1N0YnR4NWNlMmhrblRCdnNhZWIvZXJR?=
 =?utf-8?B?UGphSnRkZzJBTmp0bi9hV3g2dnN2by9qQTdPVE1rTXhKdy92VThZZ1FxVGxH?=
 =?utf-8?B?ME1WTXYwbHBySlFyT2NrNkNQdU0rMWFHdjc3akJoSlRrdDBGbE12cXJQeC9I?=
 =?utf-8?B?K2x3amhubk44WU9acmtQODRPQjU4QmwybjlVeDBiZW5ZcFRMcnN3K1lWbXFn?=
 =?utf-8?B?VG43ME80MkxqODd6Q29ha0NNbFJUMDliMnNaYkNDRzZTbTlkbEFKdGpxL0ZH?=
 =?utf-8?B?Rmh6N2wrUEFNR1c0ZWFWbG8rRnlkQjE0RWxPNUpsR01lazVGQlJZR09iVkNw?=
 =?utf-8?B?SVBIeWZTWlc3T1h5a0tkZjJndmVKMkduRDQrMktJQ3doakl1cUxzd1lzcTdo?=
 =?utf-8?B?czN5ZHJVeWw1QkVENVBoRFRBK2RxQ3E5K0s5VXZ3T09ZSEEzNndLTkNPK01r?=
 =?utf-8?Q?yxUm46Hx6zuxQdn1bsFemmk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjRtdDd3RTNEUFZyandXTUMwMmc0SitHUzkvWDVyeisxZWFkcXNkamdrbGI0?=
 =?utf-8?B?SmlheWVCVjVzNnEvQXZoVDVkS3UvYk5UeEZQZHFoMFpGRXFMRmZ6TVhXbElL?=
 =?utf-8?B?TVd4dWRUSFVzUm40U2E1dytmajJqeXU2ZjEwd3RlS1ZTUkNkeERXRjhENU9t?=
 =?utf-8?B?MGN4Q0JlOCtXZ2FGMXlDVXN3d2g5RHNpaERHeS8ybFpHbUlxNk1UK1poS2Ev?=
 =?utf-8?B?aXc2eFc4aUV5ZmdmN2JxLy9kekRPM1dGTW90U0N5OUVtNjJJZHg1eUs0NWxp?=
 =?utf-8?B?OWc2dHZrQ1lwdGhqbzVqc1U1QnBYTC9WYVVyVGRWcmFOQzhLbVRhTnlQbnlZ?=
 =?utf-8?B?ZmZ1RDl2WE1YNU5aZFlTM1g5VjAyNHUvdkhkVXJoTHBEZnJ0Tzdxa3J4RERE?=
 =?utf-8?B?QXpwVXk5TVpyNzBqVFVKdzN1U09PR1I3aHFiTVZDaHdnRmdFWlJhYnJSbEhY?=
 =?utf-8?B?c3M2U3ArSGo2eEZSV3d6Z1RMWTY3UUU4VldBR0t5RFRQYjQ3a2Q0Y09aK3Bv?=
 =?utf-8?B?UzU5SzlucFVOalEzRys3Y2tzYzRRODcxdGgydWUySk5PN1FoUVFTUDNiZlpa?=
 =?utf-8?B?Y2xpanc2TWJCaWhYblp1aDZlODdoY0dNRmlZdWFZL3hYZzN0Rm1UUFdKRU9Q?=
 =?utf-8?B?ZmNUTWtLMGVmVWJNcE51bDhjTHF4cy91aHFrNTNQdDZmMGloMDN5V05hMnhq?=
 =?utf-8?B?Z1hEMmN3UWV6WkI4c2NRZ3JDZkdMMEprbG1DV000elI5d0JsNEc2Z2JOQlFK?=
 =?utf-8?B?UnIyaTEvZWQzRWQxM2JqS28wcllpUEoyc0NUS2RNNG9KbXRWSHZxWExJd2do?=
 =?utf-8?B?MDBxc3pQTU1US1JpaldBMmpsSXFHWUV4TnVPOFpYU2JOWGFPcTl4WHMvUjFx?=
 =?utf-8?B?Z21FL2ZwZDFxcE1acWxCZXBUbVhlbmJKdFRDa1kwU3cvR0k0c3kwU3pjT2NO?=
 =?utf-8?B?S2dJVll4TDE1ZzhFM2VqbjZFY0oySHJtTUtQZXRYR05Ma2xmY2dQSU1XNUtl?=
 =?utf-8?B?c2xOYW9LcXJlOEdWMElCTnBxSDJ6cU96WGI0dE5IT1pXWUJKYTlpTVpSa05X?=
 =?utf-8?B?TitUdUhTdGlHVS94OTl0UzRBK2VoWEI5WGhHcHF1cHV4YWdyeWJ3czhDTEdq?=
 =?utf-8?B?R2lKSXl0d3NGQjgvc0VrMVpIbmVDRTMxQmc3d3ZHNEFRSmtpOUFuSkdIT2Nv?=
 =?utf-8?B?L1M3L1lXUWcyd1NNbWJaM3pUcVZ1OW9nSVo2cklBd002aE1mTDhNUmlRN2FJ?=
 =?utf-8?B?K1pVTEhLL2QrN1NKcVBCbktyWWp4SXNqbWVYeWdtQ0JsS0F2K24vakJBd0Jw?=
 =?utf-8?B?UkUrNkI0YjBZT2ZabWZRQjE3MmQ2aWF6d0ZkQW95TWh4K29aTlVCM3ZEcnlN?=
 =?utf-8?B?ckJhQVpQbXJ3NmhTYXMyQlR6Z0JLa1dydXRwUEovRnR3OE41bit0amhsSTEr?=
 =?utf-8?B?YSs2UmcrVUZRMzBaV2JkUkcwQjRpZDFiMmZRSnVHdWdxMEVtRzhQVzhrTExK?=
 =?utf-8?B?dDhZS0RxVHlSTGhSNzdFdEZJbnN3bldKZzljYUgzQ0RjQUZSTU5EVzBwNFZO?=
 =?utf-8?B?RDhYTFlBZjMrb1VlVGZkcFRjSW1sd0pvTVdLWFozWU5zTTUzNzBJdnZqdzZr?=
 =?utf-8?B?cDRUcFEwVVkxampRclJaQ2JSbktZTXNDOCt0M1FXZ05Jc2h2UzExanhjUmY5?=
 =?utf-8?B?Uzk1SGRnSlF3RUJHTFBuUHV0cEVnNmdSL21ubk51Q1VnNmFibXhPek53Vm0r?=
 =?utf-8?B?WWtWQXBFQkdib3lyKzRSV3l4QkxZL0c4eHcyamxFeUVJcVNQTlZRdDJVdi9B?=
 =?utf-8?B?ZFp2R2dZc2hKSldIblhab2tsbTYrY2NPQVFuWnQrWTViRmFRYXVzNC9Mbno0?=
 =?utf-8?B?MHZDd1g5RVFPdlAzQkt0aE4wMVZmSlgvaXB2cFpIbEU5VUd3Z2UzanVDdk1W?=
 =?utf-8?B?bnJ4eEFqV21HdytHTWVrdkEzWEtaZ2lYcG8vdjVKQVpUd1RONlhkdnVwS1l5?=
 =?utf-8?B?SW1DWjAxaDVObE4xT2c4dzVuVnVlMm5keXQxUzRzREV0L0VwbERGRFhXM1Bt?=
 =?utf-8?B?U25kSzNSdGk3Tk5jWTZmZGpQc0txMDlYa0dVNTRja2J5SGFVdU5RcitOZXpB?=
 =?utf-8?B?TkhuV0RyeFl3enBjV0E1Wk85eWNNdkM5Sm5kYndTZWZKRzdqL1B0czZwRUNk?=
 =?utf-8?B?bkloVTcvdDVTVGloRnNHUmwvWUtraHQ4eXZoN29URktoOHNIMlFzaTFXcm40?=
 =?utf-8?B?SnNETk9EMlBDeFl0UHYwMVIxU3p6NmlSYm1mYytlTCtDTHM5MjhGUzdaM1Yv?=
 =?utf-8?Q?lspIz9/JV3/4fbLwLi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ec4a18-d55b-4753-24df-08de732b7b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 22:32:52.3754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRJ8ms8vB1mwMOyPgUOuo2t/AcMXFK3L1tUkTvPpn7k1CCNuF2V0u5xWbQTrLexpv6eAoQ1Y0OOakl3MCNT2/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB4894
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

PiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjIgMy84XSBuZXQvbmV0dnNjOiBhZGQg
bXVsdGktcHJvY2VzcyBWRiBkZXZpY2UNCj4gcmVtb3ZhbCBzdXBwb3J0DQo+IA0KPiBPbiBGcmks
IDIwIEZlYiAyMDI2IDE4OjQ1OjIyIC0wODAwDQo+IGxvbmdsaUBsaW51eC5taWNyb3NvZnQuY29t
IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4g
Pg0KPiA+IFdoZW4gYSBWRiBkZXZpY2UgaXMgaG90LXJlbW92ZWQgYnkgdGhlIHByaW1hcnkgcHJv
Y2Vzcywgc2Vjb25kYXJ5DQo+ID4gcHJvY2Vzc2VzIG11c3QgYmUgbm90aWZpZWQgdG8gcmVsZWFz
ZSB0aGVpciByZWZlcmVuY2VzIHRvIHRoZSBWRiBwb3J0Lg0KPiA+IFdpdGhvdXQgdGhpcywgc2Vj
b25kYXJ5IHByb2Nlc3NlcyByZXRhaW4gc3RhbGUgcG9ydCByZWZlcmVuY2VzIGxlYWRpbmcNCj4g
PiB0byBjcmFzaGVzIG9yIHVuZGVmaW5lZCBiZWhhdmlvciB3aGVuIGFjY2Vzc2luZyB0aGUgcmVt
b3ZlZCBkZXZpY2UuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgbXVsdGktcHJvY2VzcyBjb21t
dW5pY2F0aW9uIGluZnJhc3RydWN0dXJlIHRvDQo+ID4gY29vcmRpbmF0ZSBWRiByZW1vdmFsIGFj
cm9zcyBhbGwgcHJvY2Vzc2VzOg0KPiA+DQo+ID4gLSBTaGFyZWQgbWVtb3J5IChuZXR2c2Nfc2hh
cmVkX2RhdGEpIHRvIHRyYWNrIHNlY29uZGFyeSBwcm9jZXNzIGNvdW50DQo+ID4gLSBNdWx0aS1w
cm9jZXNzIG1lc3NhZ2UgaGFuZGxlcnMgKE5FVFZTQ19NUF9SRVFfVkZfUkVNT1ZFKSB0byBub3Rp
ZnkNCj4gPiAgIHNlY29uZGFyaWVzIHdoZW4gcHJpbWFyeSByZW1vdmVzIGEgVkYgZGV2aWNlDQo+
ID4gLSBTZWNvbmRhcnkgaGFuZGxlciBjYWxscyBydGVfZXRoX2Rldl9yZWxlYXNlX3BvcnQoKSB0
byBjbGVhbmx5IHJlbGVhc2UNCj4gPiAgIHRoZSBWRiBwb3J0IGluIGl0cyBvd24gcHJvY2VzcyBz
cGFjZQ0KPiA+IC0gUHJpbWFyeSB3YWl0cyBmb3IgYWxsIHNlY29uZGFyaWVzIHRvIGFja25vd2xl
ZGdlIHJlbW92YWwgYmVmb3JlDQo+ID4gICBwcm9jZWVkaW5nDQo+ID4NCj4gPiBUaGUgaW1wbGVt
ZW50YXRpb24gdXNlcyBydGVfbXBfcmVxdWVzdF9zeW5jKCkgdG8gZW5zdXJlIGFsbCBzZWNvbmRh
cnkNCj4gPiBwcm9jZXNzZXMgcmVzcG9uZCB3aXRoaW4gTkVUVlNDX01QX1JFUV9USU1FT1VUX1NF
QyAoNSBzZWNvbmRzKSBiZWZvcmUNCj4gPiB0aGUgcHJpbWFyeSBjb21wbGV0ZXMgdGhlIFZGIHJl
bW92YWwgc2VxdWVuY2UuDQo+ID4NCj4gPiBGaXhlczogN2ZjNGMwOTk3YjA0ICgibmV0L25ldHZz
YzogZml4IGhvdCBhZGRpbmcgbXVsdGlwbGUgVkYgUENJDQo+ID4gZGV2aWNlcyIpDQo+ID4gQ2M6
IHN0YWJsZUBkcGRrLm9yZw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTG9uZyBMaSA8bG9uZ2xp
QG1pY3Jvc29mdC5jb20+DQo+IA0KPiBBSSByZXZpZXcgZmVlZGJhY2s6DQo+IA0KPiAqKlBhdGNo
IDMgKG5ldC9uZXR2c2M6IGFkZCBtdWx0aS1wcm9jZXNzIFZGIGRldmljZSByZW1vdmFsIHN1cHBv
cnQpKiog4oCUIGFkZHMNCj4gTVAgaW5mcmFzdHJ1Y3R1cmUgdG8gY29vcmRpbmF0ZSBWRiByZW1v
dmFsIGFjcm9zcyBwcm9jZXNzZXMuDQo+IA0KPiAqKlRocmVlIGNvbmNlcm5zOioqDQo+IA0KPiAx
LiAqKlJhY2Ugd2luZG93IG9uIGBzZWNvbmRhcnlfY250YCBkdXJpbmcgcHJvYmUgKH41MCUgY29u
ZmlkZW5jZSkuKiogVGhlDQo+IHNlY29uZGFyeSBpbmNyZW1lbnRzIGBzZWNvbmRhcnlfY250YCAq
YWZ0ZXIqIGBydGVfZXRoX2Rldl9wcm9iaW5nX2ZpbmlzaCgpYCwNCj4gYnV0IGBuZXR2c2NfaW5p
dF9vbmNlKClgIGFuZCBkZXZpY2Ugc2V0dXAgaGFwcGVuIGJlZm9yZSB0aGF0LiBBIHByaW1hcnkN
Cj4gcmVtb3ZpbmcgYSBWRiBkdXJpbmcgdGhpcyB3aW5kb3cgc2VlcyBgc2Vjb25kYXJ5X2NudCA9
PSAwYCwgc2tpcHMNCj4gYHJ0ZV9tcF9yZXF1ZXN0X3N5bmMoKWAsIGFuZCB0aGUgc2Vjb25kYXJ5
IG5ldmVyIGdldHMgbm90aWZpZWQg4oCUIGxlYXZpbmcgaXQgd2l0aA0KPiBhIHN0YWxlIFZGIHBv
cnQgcmVmZXJlbmNlLg0KPiANCj4gMi4gKipNaXNsZWFkaW5nICJWRiBpcyBhbHJlYWR5IGxvY2tl
ZCBieSBwcmltYXJ5IiBjb21tZW50LioqIEluDQo+IGBuZXR2c2Nfc2Vjb25kYXJ5X2hhbmRsZV9k
ZXZpY2VfcmVtb3ZlKClgLCB0aGUgY29kZSByZWFkcyBgaHYtPnZmX2N0eC52Zl9wb3J0YA0KPiBm
cm9tIHNoYXJlZCBtZW1vcnkgd2l0aCBhIGNvbW1lbnQgc2F5aW5nIHRoZSBwcmltYXJ5J3MgbG9j
ayBwcm90ZWN0cyBpdC4gQnV0DQo+IGBydGVfcndsb2NrX3RgIGlzIHByb2Nlc3MtbG9jYWwg4oCU
IGl0IGRvZXNuJ3Qgd29yayBjcm9zcy1wcm9jZXNzLiBUaGUgYWN0dWFsDQo+IHN5bmNocm9uaXph
dGlvbiBjb21lcyBmcm9tIHRoZSBNUCBtZXNzYWdlIGV4Y2hhbmdlIGl0c2VsZiAodGhlIHByaW1h
cnkgc2VuZHMNCj4gdGhlIG1lc3NhZ2UgYWZ0ZXIgc2V0dGluZyBzdGF0ZSwgdGhlIHNlY29uZGFy
eSBoYW5kbGVzIGl0IGFmdGVyIHJlY2VpdmluZykuIFRoZQ0KPiBjb21tZW50IHNob3VsZCByZWZs
ZWN0IHRoYXQuDQo+IA0KPiAzLiAqKmBuZXR2c2NfaW5pdF9vbmNlKClgIG5vdCBwcm90ZWN0ZWQg
YnkgdGhlIHNwaW5sb2NrLioqIEl0J3MgY2FsbGVkIGZyb20NCj4gYGV0aF9obl9wcm9iZSgpYCB3
aXRob3V0IGBuZXR2c2Nfc2hhcmVkX2RhdGFfbG9ja2AsIHdoaWxlDQo+IGBuZXR2c2NfdW5pbml0
X29uY2UoKWAgaXMgY2FsbGVkICppbnNpZGUqIHRoZSBsb2NrLiBJZiB0d28gbmV0dnNjIGRldmlj
ZXMgcHJvYmUNCj4gY29uY3VycmVudGx5IGluIHRoZSBzYW1lIHByb2Nlc3MsIHRoZSBgaW5pdF9k
b25lYCBmbGFnIGNoZWNrIGNvdWxkIHJhY2UuIExvdyByaXNrDQo+IHNpbmNlIERQREsgcHJvYmUg
aXMgdHlwaWNhbGx5IHNpbmdsZS10aHJlYWRlZCwgYnV0IGluY29uc2lzdGVudCB3aXRoIHRoZSB1
bmluaXQNCj4gcGF0aC4NCj4gDQo+ICoqTWlub3Igc3R5bGUgbm90ZXM6KiogYE1aX05FVFZTQ19T
SEFSRURfREFUQWAgdXNlcyBtYWNyby1zdHlsZSBuYW1pbmcNCj4gYnV0IGlzIGEgYGNvbnN0IGNo
YXIgKmAgdmFyaWFibGUg4oCUIGNvdWxkIGJlIGEgYCNkZWZpbmVgIGZvciBjb25zaXN0ZW5jeSB3
aXRoDQo+IGBORVRWU0NfTVBfTkFNRWAuIFRoZSBzdHViIGBuZXR2c2NfbXBfcHJpbWFyeV9oYW5k
bGUoKWAgdGhhdCBhbHdheXMNCj4gcmV0dXJucyAwIGlzIGJlbmlnbiBidXQgY291bGQgbWFzayBm
dXR1cmUgcHJvdG9jb2wgZXJyb3JzLg0KPiANCj4gKipPdmVyYWxsOioqIFNvdW5kIGluZnJhc3Ry
dWN0dXJlLCBzdWl0YWJsZSBmb3IgbWVyZ2luZyB3aXRoIHRoZSBjb21tZW50IGZpeCBhbmQNCj4g
YXdhcmVuZXNzIG9mIHRoZSBwcm9iZS10aW1lIHJhY2Ugd2luZG93Lg0KDQpJJ20gc2VuZGluZyB2
MyBhZGRyZXNzaW5nIHRob3NlIGNvbW1lbnRzLg0KDQpUaGFua3MsDQpMb25nDQo=
