Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD8BCED24E
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 09:54:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAC54402DC;
	Tue, 18 Nov 2025 10:54:43 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
 by mails.dpdk.org (Postfix) with ESMTP id 3C0D1402D8;
 Tue, 18 Nov 2025 10:54:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+EkFtZ5yjpHJSkkbvbv6VXtCbn9bPwV9k7OXbVElU9ZhlRAtNuM/H3N171bU5Ts7JcWjVVQegRM9SlgRm4VrDVeWn5bdFlOH27zyP7IVbJ+r9yeEdZuJn6lfX0T2OfUQB5EyDmefWo/tsL0CebGAcSOG7CxrjOk6m9ZSt//f219597YNzrKlKYecc8zSWIphqojf1+SYjKcBKFeBNg9Heb+DtT83S5v6d5/bYazrm4kYwLMHDZvzThgVQV9lijq1Hjfa6vujswBxridnICpPoXZp5pY03wPqThea2eymvxfFoHdR61+ad53iATe10fj2WPsjaWlzlZ1Hn+9S/sCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJfLmQBLh2XbCBoA8X1iQZTapN8OiF1clBznhyZxXbc=;
 b=c/qWTEtH6NvmMYai53aWTdE23+TwEguHlJ/31FctB/mJ4Iam4zTYuFUb+W80FAWz+g+NSe0wkkXuFwHNgyXml04tG86ISZPYlDmDEIMX5yyJtVP4vqsV5aqe4Ao+c5EaJ0M5NN++mvdZvb99Vi/gQx3db9c+Nqq4Z9y/wR4HdgQppyJTFrnrjhNMAPCBC65PSp3saRZYcVmhiYA3RlPIAh+UwvUyLVxb7Xoa6YASlSOiZGTZzcjsc6ai8ZyDG64gIcjPe9LhiFVK6WmwjsgBZlsguvKt6lHoZEGIJFfAC/U5fbv54Skbi1ISI9EsWENQv9K7DGmaVT+ba8w+fUd9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJfLmQBLh2XbCBoA8X1iQZTapN8OiF1clBznhyZxXbc=;
 b=b8TqE5T5TySM2rB1dNt9Iwv4ca0WC/hELkXa4kqkZDjMVjWdYlPXn5dKNuHkjLewVUVds4nRFl03BhTiJAeqMIfrusQcIFDaCNdt4CuxIpoLdvINql/BYxwj4UJYExLTCO0+xjhkzSK261WlUpZXRTbbbYg9SMB8L+imBblnV1w=
Received: from DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20)
 by LV8PR12MB9691.namprd12.prod.outlook.com (2603:10b6:408:295::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 09:54:39 +0000
Received: from DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::2c56:65d9:9ce1:c415]) by DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::2c56:65d9:9ce1:c415%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 09:54:39 +0000
From: "Sebastian, Selwin" <Selwin.Sebastian@amd.com>
To: "Ande, Venkat Kumar" <VenkatKumar.Ande@amd.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2] net/axgbe: fix the build warning for GCC-16
Thread-Topic: [PATCH v2] net/axgbe: fix the build warning for GCC-16
Thread-Index: AQHcVLxvMBwMRzv9H0yI5vp0oSk0ZLT4OQFA
Date: Tue, 18 Nov 2025 09:54:39 +0000
Message-ID: <DM4PR12MB5055E8380CF0830CE015BA8F8DD6A@DM4PR12MB5055.namprd12.prod.outlook.com>
References: <20251113113055.371-1-VenkatKumar.Ande@amd.com>
 <20251113164109.522-1-VenkatKumar.Ande@amd.com>
In-Reply-To: <20251113164109.522-1-VenkatKumar.Ande@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-18T09:53:49.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5055:EE_|LV8PR12MB9691:EE_
x-ms-office365-filtering-correlation-id: 719d0e21-806d-4af2-961d-08de26887d89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?UTVGUk9XSkMwSEN6TVNRVitTZkNyQVdROThnMlZtOWhBRUFYeG5yMUhMeVU1?=
 =?utf-8?B?U3BMcDdwQmNZc09YT2UvdU1iTCt6dTRXbEtKQUxHVTdVc3QyTnBzUVBJNGF1?=
 =?utf-8?B?MG0wR0V0eE8vb0hZalNMVUM2S3pVdXlPUWk0T0tVWnY5cGN4SS9SNXFGdFl5?=
 =?utf-8?B?Q3h4YlJZbXVWZUwxYlVsRkFoc0pLSEJGakdFa3UvWlVIOUh5QnF5VHNyQ0dj?=
 =?utf-8?B?WjJLTEsxNWpNaXA0YzA1QnBvamZlVVgxSERBS1hGZXUyU24zV0dOb09NWGVL?=
 =?utf-8?B?M1Uxek5IYmNReTV6VmJGWUdscXVIL2hxdE1JaHNQS2tFZjNFRThiQkpDSEpz?=
 =?utf-8?B?Z3oxTHZsNzhxMXBzdE1XSUtidVdrWVVCK0pIT1BTWWY5a1RPdmR0bk9NYzJk?=
 =?utf-8?B?SThZU0dQRUpQMFl1cGw5MXdlTW5PMVJUUk1kVWFKaHEvelJ0NTBnaU5sbkNW?=
 =?utf-8?B?K0FIenJWZW11N3ZJTVJLSEg2WTM4RjEwdFJjcS80ZEVOUE91OGdlUFF6S2NC?=
 =?utf-8?B?bFBEcWlrLzhxdkdVdml4TWROYUt5VFgwUGxIK2ZTM1E0SjJvWWZzcGFOT1hG?=
 =?utf-8?B?aDMwVHFRL1RSSlUvbEREU3p5YkNLdERSb1p5N2VzZXc2TmJGVjFLS0o1WDB6?=
 =?utf-8?B?dDBGM2RxakQ1c01oc04yY0k2VnJEL0dTS0xRenBhVGRoV1BVYXFmZktFZWNB?=
 =?utf-8?B?TFN3Zkp4YlRjVDlkakt3Tyt3YzlFZ1ZrN0IxOXBnc1FWTEY4QTY5aXl0YW1r?=
 =?utf-8?B?VkdHN1lJcW04dW9rSGhCKysvQXhWdUJKSzZ6YVI5NE1xYWJLak52Uzg5Nk1a?=
 =?utf-8?B?VjFEWC81eU5za3krVlMxVXZQL0Y5YzZSaFNvKytoMXB5NjRxYTJLekxwVERK?=
 =?utf-8?B?bCtrV3Z0UVhxWWM4Y0xzdkpjQnAvUXoydVVyOXkvd0RNSGlUNE85ZW0ybEVZ?=
 =?utf-8?B?ZlVCallvbTNoRDRTMWtPanFTaExiY1dFM2l3RzlpRTBDSVU4T2E0UUpjMmtu?=
 =?utf-8?B?TUYvT3lPbmcxMzhwSmZmZjN2cmIwU0JXQ1ZudFFWMksrbWdST2g1THFMVU9Y?=
 =?utf-8?B?aXJ2VU92YmFmMDVEQUFvLzljYUx0ZGtSTmNUUmRwMnk3aHBEME9RZjd0Q1pt?=
 =?utf-8?B?cXBtVTBsckdqMTd1Mkgrd0pmeStBRW10aTJKSTgybGhPa2tLT3d1M0ExWHJL?=
 =?utf-8?B?OENEMWZGMEtyTUM3SFNlVkJlbXdjTyt1UXZOUzlWQUJ2S1VXS0VTM2tYSVJX?=
 =?utf-8?B?OGsvbFZ3NkxDM1pZV2hRTXhyMldEUE5vRW9kS0Y3YTdhZFRma1A3WEhyV1do?=
 =?utf-8?B?VzJpS3FVZFY5bWxwV0R1U0tpNFNlMUYzcjh4VVhUampQVnJXV3RYbUpkMjdM?=
 =?utf-8?B?R2lncDJySm1Xd09XclRpMU5QTjd5MTEvc3ovU2VmeUtlajhjOWoyc2p1WUdV?=
 =?utf-8?B?b1JrTWRRR0dMWW14TGt2UVRvcVNkY2dzR3VleXlsOGZoZW03UjFTem5PKzdF?=
 =?utf-8?B?OG9iYTZDZFFWdU1rd3Y2bU43SERaNk5DTlZQTHJXOG8wQVJ0N1FXVzAyMEQ4?=
 =?utf-8?B?YmxhMm1kSkdoWHBzZTZLdGxsOVpmM3R2U0hVcDFJV2tHbnVvWStURDE4NVM0?=
 =?utf-8?B?RkMyNnBZelFuQldNNFIwdVp3dXAvSmtiOGVVdXp5Y3VURUpsdjNnSlIrczhJ?=
 =?utf-8?B?RXArSStWS2VGVEtjMDcyTjl4WktqWTN4UnNuelhNbHJ0R1Y3SUdzSE8rdjJC?=
 =?utf-8?B?cUlUVUNXTmpVQ1hrOXdpUGN2L2kzUkFWTUtFTTJFTU9YUlZpVnErWktKMnJ6?=
 =?utf-8?B?aDBuWldsanRrN1F0NWVGbnBQZy83S2pNWjRTaEVtcXlLRUc5NVc4TkxITzFj?=
 =?utf-8?B?T3hpeElML3RJMUVGSklQdTdXdlRFSk1lSWQ4emlrUlc1b0JZS3E0TlVZYmRi?=
 =?utf-8?B?S2N2SktYbEVVNWRlWGY0WE1pNlFrUy9PSStubWxOaUt0YlVxSEVkdGJ2L1V4?=
 =?utf-8?B?K1lDUXdqZkZndTdiNVVyYU1LNnZTeGtWMW5NbnlKakVCOU8vYTZkY1g5YTNo?=
 =?utf-8?Q?fg8sDy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTJaRlQ0K2p5SHlGTDRwUHdmWXd5c3BkRWZHOWw3SDNmQkcvd2kvZUNEaGFv?=
 =?utf-8?B?a1FzOEJvVVVEdGdRN2xLekJMek1KWlBjTUxDL0E0Mkt5c1owQzNmaVJDQTR0?=
 =?utf-8?B?R2pQWXV2R09VMm9jTU1tVHUvNFp5ODdQQUZwcC9uWjFmRFZNOHM0QlUyTTdm?=
 =?utf-8?B?Syt2VUdYNXlDdHBQWGNmbjEyd0FxSkpUbXJFTGZod1p6bWJadWhONU4yS05h?=
 =?utf-8?B?aEoyUDdpc0t0MUlLcXY2M3gzekRIellsUjlVK2xiZm4xeFlnZ2NrSEhOZk5K?=
 =?utf-8?B?aXd5SkZEaTJLZmxZWGpad1RCZVYrR0JyRFoxWDE2K2ozd2kyejFFL3pseHFW?=
 =?utf-8?B?aW5YbzBQRnYvS0hPTndvVG4vdURnenozUC85OWFzdnI3TzBSRlZyd1h3WjQv?=
 =?utf-8?B?RXJFS2xvbGFyWUFXQnBWT0dsYk9lUW12c3lkOG1FM05ISGoyZEkyR1NQWi9t?=
 =?utf-8?B?UFE5bzl6WlJPT1lES3gvRzJlZmFQMFhjNzBCK0FqUkZUOEgvQ2d1YzFCcVFR?=
 =?utf-8?B?anRQWE1KZ2c1ZFlUa3Vid2NZaCtIMTdPaHBqRDNQTTBHU0ltak1hUkloSVhS?=
 =?utf-8?B?WngycndEUHdqREhUWFBwNTNXMU44MFFsWlBIbUtQVm9zaGRFakxxcHkyODhD?=
 =?utf-8?B?OXlaWDZkd1NuTlJwc2tlKzdDOVN4TVgwbTFNbzVEMFdFVWNOYWNMcWlWK2hy?=
 =?utf-8?B?emNMTmd6QS9OTTJVdW50czNvNXNTSmVzV1FuTDBMbmRJRFRacGEyQjNvSnJ2?=
 =?utf-8?B?NXRFVTRuUFI4eTBpNzd1clJldWtaTFZzQWsxYU1LcVp2cjB5ODd3RzZMdWpu?=
 =?utf-8?B?MzBsUVFsNVk2bkNrckwydnFNRVpjZ1hXekxpcGZFNmU3WVRReEU2ckNQR3oz?=
 =?utf-8?B?eDR0d3lYZE9CaEJzbkNiWWlsM3YydEJud3RZN3g3S0IyaHBkSjM1K2w0TUNp?=
 =?utf-8?B?SVVFNkwxcHFRZlQ1alVJL1RXNmlHVzZpN1ZSSzFSZXBkWWs5b0I1b01ZVHNB?=
 =?utf-8?B?cys1WXhSblJveHMzQ2FDTUM3Z0dSYnpEVGhSQ3Z2UXNMNXJHNlJWV1lpZnhR?=
 =?utf-8?B?dTlmbllEKzBmSFphOHBHUk5pRDQyaG5JWUQzS1NoelR0UjIzTDA3a0c0VDk0?=
 =?utf-8?B?Q2dGNnNtbmxhRWNUdkw1dGp4eUllMXlvZjg5N1lSL1p6NWxsRGx3b1FWdGhD?=
 =?utf-8?B?VytKZ0VhSXV2QUh3WjZ4MVJiaEJRQVVuVDBLRkpETHR5bFA0a0ZHZnA2N1Z5?=
 =?utf-8?B?bTdRSzBmamduMmZic3l4dDlMaEsvZ0IwUGw0T2F1VW9zVnJpVTZNNDJzb3BV?=
 =?utf-8?B?bkpzWDNETzFhMnhSVkxTUVFlOVR0T1k2ai9WZ2JJQ0oyTmlvNFhyQUhRSjlI?=
 =?utf-8?B?R2FnOUQ1eitMTDYrdXJ2V1Q4K2JDZXF0eHRkNHNnZ2ppSzNiV1JDRkkxUlBW?=
 =?utf-8?B?VEM0U1ZGVmVNNHhGV1pxMUl4S1ZNejd1ZjZ4SWxUbVhCOUVkSmZyTGdhTE5M?=
 =?utf-8?B?STdxSXQvNzZNSUo1bldjRDNhSHh3bnNudUs0clVZSlJyMGk5ODcvNkM4NGFC?=
 =?utf-8?B?Vzd6azV0YnJZTkM1Mjd6TndPZTc4dVBLR243OVk4blpLU0o2TTBEVWdZVmh2?=
 =?utf-8?B?MXY2ZVM2OGhmZGlwOHV0OXBqempRUWtkS0FGYlVPMTMyVWNvMlBtRVhIL0Ez?=
 =?utf-8?B?aWkwTCtNbDdRQWhwY1VCdUxXU2tBb1hlYmRwbTRLZnNsZTRBVDBJZS84NU5j?=
 =?utf-8?B?UUM1QWNaU0lEcGRvWHVoUUlheWdySzhIbisvaUh5dDFJd0RGbVVzMHlodWNG?=
 =?utf-8?B?Ump5eFVPVXlxUzdaejVpaW14UlpvRWhtNHhHZXJpMWEyQlBIRUlEU3JYcWhI?=
 =?utf-8?B?ayszQ3g5N3pSd0NXTmhXV1RWQmprMEwwRXdZb2JlZlQ1akZkdjFieC8rMGRz?=
 =?utf-8?B?aTJIQVY2TjEySWFWSjdFb2dFUlBmczNtRmovcVVQQVh2VmNBZ0UzTlNOeWlR?=
 =?utf-8?B?Tm0rUHhXUVlzaWV1YTZCTWtDR2pCN0JjVXZNOWlkcXpzbVRJa3RNT2dvM0c3?=
 =?utf-8?B?amxEUkQrcVBDamZxeUJoTWF0NzFYK1I3ZmdvckM0OE42bTZnNTFyVHJlSVYx?=
 =?utf-8?Q?v7X0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719d0e21-806d-4af2-961d-08de26887d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 09:54:39.6600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +kpNKVQqNhlAqk1//qn9XD9vH6n4uiC5asjPcdpioXt821AAyDmWOyCiOLf80++AxGBLXW0n9b11WkKb+rlw9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9691
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
Cg0KQWNrZWQtYnk6IFNlbHdpbiBTZWJhc3RpYW48c2Vsd2luLnNlYmFzdGlhbkBhbWQuY29tPg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQW5kZSwgVmVua2F0IEt1bWFyIDxW
ZW5rYXRLdW1hci5BbmRlQGFtZC5jb20+DQpTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTMsIDIw
MjUgMTA6MTEgUE0NClRvOiBkZXZAZHBkay5vcmcNCkNjOiBTZWJhc3RpYW4sIFNlbHdpbiA8U2Vs
d2luLlNlYmFzdGlhbkBhbWQuY29tPjsgQW5kZSwgVmVua2F0IEt1bWFyIDxWZW5rYXRLdW1hci5B
bmRlQGFtZC5jb20+OyBzdGFibGVAZHBkay5vcmcNClN1YmplY3Q6IFtQQVRDSCB2Ml0gbmV0L2F4
Z2JlOiBmaXggdGhlIGJ1aWxkIHdhcm5pbmcgZm9yIEdDQy0xNg0KDQpCdWlsZCB3YXJuaW5nIHJl
cG9ydGVkIGZvciBsb2NhbCB2YXJpYWJsZSBzZXQgYW5kIG5vdCB1c2VkIG9uIEdDQy0xNi4NCkZp
eCB0aGUgaXNzdWUgYnkgdXNpbmcgdGhlIHZhcmlhYmxlIGZvciBtaXNzZWQgcmVnaXN0ZXIgd3Jp
dGUgb3BlcmF0aW9uLg0KDQouLi9kcml2ZXJzL25ldC9heGdiZS9heGdiZV9ldGhkZXYuYzogSW4g
ZnVuY3Rpb24g4oCYYXhnYmVfdGltZXN5bmNfZGlzYWJsZeKAmToNCi4uL2RyaXZlcnMvbmV0L2F4
Z2JlL2F4Z2JlX2V0aGRldi5jOjE3NDQ6MjI6IHdhcm5pbmc6DQp2YXJpYWJsZSDigJhtYWNfdHNj
cuKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlPV0NCiAxNzQ0
IHwgICAgICAgICB1bnNpZ25lZCBpbnQgbWFjX3RzY3IgPSAwOw0KICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICBefn5+fn5+fg0KDQpCdWd6aWxsYSBJRDogMTgxOQ0KRml4ZXM6IGUwNDQ0OTQ4
OGZkYiAoIm5ldC9heGdiZTogc3VwcG9ydCBJRUVFIDE1ODggUFRQIikNCkNjOiBzdGFibGVAZHBk
ay5vcmcNCg0KU2lnbmVkLW9mZi1ieTogVmVua2F0IEt1bWFyIEFuZGUgPFZlbmthdEt1bWFyLkFu
ZGVAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbmV0L2F4Z2JlL2F4Z2JlX2V0aGRldi5jIHwgNiAr
KysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9heGdiZS9heGdiZV9ldGhkZXYuYyBiL2RyaXZlcnMvbmV0L2F4Z2JlL2F4Z2Jl
X2V0aGRldi5jDQppbmRleCAzMWQzNWZmMTgyLi5jZjNiMGQ5ZWY1IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9uZXQvYXhnYmUvYXhnYmVfZXRoZGV2LmMNCisrKyBiL2RyaXZlcnMvbmV0L2F4Z2JlL2F4
Z2JlX2V0aGRldi5jDQpAQCAtMTc0Miw2ICsxNzQyLDcgQEAgYXhnYmVfdGltZXN5bmNfZGlzYWJs
ZShzdHJ1Y3QgcnRlX2V0aF9kZXYgKmRldikgIHsNCiAgICAgICAgc3RydWN0IGF4Z2JlX3BvcnQg
KnBkYXRhID0gZGV2LT5kYXRhLT5kZXZfcHJpdmF0ZTsNCiAgICAgICAgdW5zaWduZWQgaW50IG1h
Y190c2NyID0gMDsNCisgICAgICAgdW5zaWduZWQgaW50IHZhbHVlID0gMDsNCg0KICAgICAgICAv
KmRpc2FibGUgdGltZXN0YW1wIGZvciBhbGwgcGt0cyovDQogICAgICAgIEFYR01BQ19TRVRfQklU
UyhtYWNfdHNjciwgTUFDX1RTQ1IsIFRTRU5BTEwsIDApOyBAQCAtMTc1MSw2ICsxNzUyLDExIEBA
IGF4Z2JlX3RpbWVzeW5jX2Rpc2FibGUoc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYpDQogICAgICAg
IEFYR01BQ19TRVRfQklUUyhtYWNfdHNjciwgTUFDX1RTQ1IsIFRTQ0ZVUERULCAwKTsNCiAgICAg
ICAgLypkaXNhYmxlIHRpbWUgc3RhbXAqLw0KICAgICAgICBBWEdNQUNfU0VUX0JJVFMobWFjX3Rz
Y3IsIE1BQ19UU0NSLCBUU0VOQSwgMCk7DQorDQorICAgICAgIHZhbHVlID0gQVhHTUFDX0lPUkVB
RChwZGF0YSwgTUFDX1RTQ1IpOw0KKyAgICAgICB2YWx1ZSB8PSBtYWNfdHNjcjsNCisgICAgICAg
QVhHTUFDX0lPV1JJVEUocGRhdGEsIE1BQ19UU0NSLCB2YWx1ZSk7DQorDQogICAgICAgIHJldHVy
biAwOw0KIH0NCg0KLS0NCjIuNDAuMS53aW5kb3dzLjENCg0K
