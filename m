Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E807C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 12:52:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32D044029A;
	Thu,  6 Feb 2025 13:52:19 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4343B4026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 13:52:17 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516AA04m031292;
 Thu, 6 Feb 2025 04:52:16 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44mu2tr7f3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2025 04:52:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lanjV0bMsC9ZHtA4V5ZZ1C4pMCJnoQhgmRAOgAFK9H404FtlugAxLyUrnMejA2ME31mBdPCVgnGWYX6li1mbZ5VJ0ZjHVH1RetZdS+cSYdx6Z+SPfD7+ZU37KcZbb7951BcBZoasgN5pNQHecf5pOybhIvGZEu5rrNStVGqbHSvIQmLeFsDVLSBJ+IFI5mlyXOcUaDQQLugamR2H8qxgynNEnnIdWylcCydp8piBmCcodNQ6ycWfujs3Yi/pf34bjZ1qhdKezw9QFDMH45ffF3KO5FIa+eDwdo2reHS0+sO55f2VzHM9092RlIuIHPPvlecA8u1Mz8LJAcgReZ3LXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BivF/ziqceannkPM01qyVZBg1AOl2t8b3JA1cs8QrI=;
 b=PtcEhvQVko0LdgYEb877CM0I/PhWFitwMZQjGBUVWir/WEYyDoVls9P3Sn1BIa1xDQtsnQ284yG9gf9QYaT3xaw0rDVUyYHnbu+Rxl9yFOgcjgpzWePElgJnXtXqUt4uIMEt4kQxYukmLJeF/q37HwdAkaz4exGltiCkk4N3TiTLr3kZ87SdHpBtwZ23G1lpGXuXqa99IcL0OhTiaVSzGubFoIkdJY4JZmICoVHUuKf7ti/MtSd4Rh4Pw9hcsnDBQd44uy58ANd7/BdPG9KbiC+safvCXWX2ZyFrxZMbnDf5+GbP2u1Sr4julSj1mVokooHGYh4NhP+CPfkdPTr/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BivF/ziqceannkPM01qyVZBg1AOl2t8b3JA1cs8QrI=;
 b=GTdbGEHIbgsM3G6FrwI/arvWZnibrsmsYzts12t/s2D6DhgZP1WA9orK7RyBbPjErnBB0ZlpjmkdLmOsKwD2ELyxk9PtV0kRibA5supdLwxyYXA4oKnZBQj2EZbfac9Uw03Rsf3hgYWkJakopWhsnHwT4xxoWsIHmrl3Wj315+w=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CO6PR18MB4436.namprd18.prod.outlook.com (2603:10b6:303:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 12:51:57 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%7]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 12:51:56 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Brian Dooley <brian.dooley@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "kai.ji@intel.com" <kai.ji@intel.com>,
 "pablo.de.lara.guarch@intel.com" <pablo.de.lara.guarch@intel.com>
Subject: RE: [EXTERNAL] [PATCH v3 1/2] crypto/ipsec_mb: add SM4 GCM support
Thread-Topic: [EXTERNAL] [PATCH v3 1/2] crypto/ipsec_mb: add SM4 GCM support
Thread-Index: AQHbZd4PU3way4ky8EasQCQkDhDxsrM6X8IQ
Date: Thu, 6 Feb 2025 12:51:56 +0000
Message-ID: <CO6PR18MB4484208E289FDC8FA2C4B3A3D8F62@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20241213125850.2714328-1-brian.dooley@intel.com>
 <20250113171022.1649181-1-brian.dooley@intel.com>
In-Reply-To: <20250113171022.1649181-1-brian.dooley@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CO6PR18MB4436:EE_
x-ms-office365-filtering-correlation-id: 6ed2d4da-7be2-4e83-fa45-08dd46ad0a1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VExRYW5nV0dpMjlGd0s4UXhZL0s0NDFTNFdLdjIwd0I1emlndXg0R2xXeXJw?=
 =?utf-8?B?NU9LWmJZcDdMM3FwdlNYSFE1bWk1SU13R1FVSFBQNUp6T0RFL3FWNmVCS2Ex?=
 =?utf-8?B?TVR6WkdqQWxnZWVmSUQvalJIblFSMC9OclVMMVFudG1RM1NGaHlldFBWU3gx?=
 =?utf-8?B?VVNCd0FWR1JLbFdkWkhoNmFTcXpHUDhneXJtVUlXK2x4QXR3RXo0bTYrK01m?=
 =?utf-8?B?eGFxY1p2TWhzb1FwSDBDRlNQL2k5Q0U5Z21FdVY2ODRTcU5XWStXbjdVcVR2?=
 =?utf-8?B?Sy9wRXdKUFNyK3ErNWtGRFFjU2pBalhQMmtYbkROWjlxMHRZYzEvckNpcGJF?=
 =?utf-8?B?TDlaQ2tuSHhNdjJYUTRlMDB6YXdnY2NoOCtuRnFPeFpjQ1JsZHVHWDBZTmpn?=
 =?utf-8?B?WnE5aWpwblVWZExHNWR2dWJlTUk3TVpsbSsxWkRIMlFSSWVteklyejVVTjVy?=
 =?utf-8?B?VGZPNUt4cUw4Y2NrcGsyZ0lxb3hsU2sweFU4TlJMZm41cERZZ3RGOXJDMGR0?=
 =?utf-8?B?SXZaMjRmTWk2TDAwSDdzWXpXQXhVaUdyR2pIcHpCYkJrQU8wY3RYVWhLQUNz?=
 =?utf-8?B?MGhaeHJ3MFVTOEorMHdNZFdWME4xcEhpRDFQSDdMTG9zczlPU284VTZJaTBa?=
 =?utf-8?B?dzZTRHhWeDlqL3VXd3VXVi94eThUVTljMmt3aEUxbjdORnE4UmZWcWwxbDBW?=
 =?utf-8?B?THpIVk92MXgwKzFUeTVXT1lNakpBM2JWK2xaSXpKbUZjaER4SzJsR29XOUZa?=
 =?utf-8?B?SFRody9HTG1ZcEh6emFYZER3b05wT3NRV3VPVWFTOXNyM2cxeDdtc3ZjUTEr?=
 =?utf-8?B?S2Z4SlRrWnZybElWVTdhbGFKU2hhczlaSVdBVGkxUzVoZTZnblJJL3k1SlRT?=
 =?utf-8?B?R3RFckpicUZrcWEwWEFvUnN3VlUwVTR0V3ZvVmJUOXRHNDZnK25CYjFsUWRL?=
 =?utf-8?B?OXNMS24yYi9TMkRoeDgyZnpiY05RTTJ4SmxMZDZqWFFRcHVpL2FKSVZTaWlm?=
 =?utf-8?B?WkRKT3FHYWx6UzFLMVV0MWF2bHF3cmNkdmtBZ1FKblRMbjlTdGY0WXMrZjBa?=
 =?utf-8?B?SWt0ZWNxWHZzZUwwRTU2VXVPTVJreCtZcnhEWElxa1NIR2ZXQzlHanVVcjVU?=
 =?utf-8?B?ZUpmeEYwZWh6Z3VwODRwMFFrdHVmT1BuT2ZtbjdZdjIrM2hNYURFZW9Wc3lO?=
 =?utf-8?B?cHh5cGVSUlV2bmwrVWFpTGhqWnZ6ajFJUDdJZGFGR0I2bVdwcFV3RjByVGhv?=
 =?utf-8?B?b241NFJLQ1BtWTJna1VkbCsvU1BsMGNiTXc5ZmZSaHVRQ1F3ci9peVh6dW5E?=
 =?utf-8?B?aEpGeWEwcEtuVHk0R0NTL2s1YlhPeVo2SEFVei8vMS85cmVVL0FsV3FiYXc5?=
 =?utf-8?B?SXRSZkJtdlFQQVlBK01FN2RabFhqcE1UVTNYVm1VSW9ETlVFRUoybUd5VnRQ?=
 =?utf-8?B?WC9DQzVpRVNJSHN2WkhCQllGZ1Z2QkthdnVMMEQvT25YUEFGVW9jNEpBNDdU?=
 =?utf-8?B?M01SWXZ1UWRGZFcwL2hEU3YxYU5tb04vR1pTTFFWQ1VHdlR3anpjMDM4V1hG?=
 =?utf-8?B?U056WUpiVTVXblM5OGZ1dUl6VmQ3YkNYc01obmRDRlBteW5nWkFhOStVKzVP?=
 =?utf-8?B?Q3RIekJvbFJwVDRNVlMxUDhMQk9abXVnT3R5WkZIajl0OVo5UVl4SDJYNjZi?=
 =?utf-8?B?d0UrQWFhWjF4cUMyRWo2aDc2b1FMZSttbnc4ZlJ0amllUzBwRTRwclAwSDZu?=
 =?utf-8?B?elRuL1FXejB2UVp6NnRONndoakYyTllCVEhPZy9QQnk4TngvZDJKZytyUU0r?=
 =?utf-8?B?bHREYXdGWkwwY214RWJBM0FBb2pPRzkzT25XUktkQUd1Nnh1L1IxMWJYM21a?=
 =?utf-8?B?WFdlSGZaaVpvMFNCZzlncis4a2JyQkxaRWdhSjRFeUpXTC9kSVUxUWFkc3Ba?=
 =?utf-8?Q?XtvwTS3OFIckSStcidycn1iTtUNn4dz7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGVEMUVNSGt3ZUJTTzRXUW5zUUthU3VLeTlWbEYzT1VwSTdqWGR1dXc2RCtP?=
 =?utf-8?B?RWxQNlpKOGhVS3RySVUyUnl2L1RQUkFyRjFsOENiNER0dkx5TlJxaHYvN2tF?=
 =?utf-8?B?blVVVm1EY3lNQ2Q1b1ZIcVRIL283OFpnV1ZOdjd1SXRDbkVPd28wT0c4bXJI?=
 =?utf-8?B?TCtyWFQrQkZjVnN1K0NlMVpTRWxZOXR1LzZiTmhqbkcrSjQzNFhVTmo3aXdG?=
 =?utf-8?B?TzlTQnZSeDJ0OTRHaEY3ODlRWGIvWStHRU9leHBneHFUeDZiMmVJcFhYWXgy?=
 =?utf-8?B?VU1zVjlRWXZ1YTlxcm5OVnNHSEpFUnFialV4bmJtTjVTWkFJWkptQk1LVmw5?=
 =?utf-8?B?YWJ1ZWJTSk0wdFJSWU1qODdLaGRZejIxWmJDS2I2Q0wvNjR2TDFkcHBwdnZB?=
 =?utf-8?B?K0lqelNjQ0c3UEFXaUt0UlpxS05pemgyTSsrckE5S3NvOHVZQTdFNFY5RXdD?=
 =?utf-8?B?SzY1d0U4ZHZIQnpmdU1Uelk0SVoxWEtNMHo4bkNkOFA5b2loZGJ3L2JPWVV6?=
 =?utf-8?B?dGpQcXU5ZmtFb3UrM29yVHZGTXp5RDBnN3ZMNjllWWpHendLWEVaenJjSjZM?=
 =?utf-8?B?YUhwUVdkNVdsZ2NSUFEvOXE0a1JUNGltMDFod2U3Z3hnZzhhdzBXU1FETmxj?=
 =?utf-8?B?ODhtRFhkVmY3Q2x1dkNYck5wY0lWWi9rSnFsU2MxdmxLK2JOTTVNZkVMWEdV?=
 =?utf-8?B?R3V4enlLVTJEZmFoMGpDS1o5VVhZMVcvMjZSZ1c3U2lXT0JyNGl4U2dWWFhY?=
 =?utf-8?B?YTZzTW5VcUtGSjRHb21kZHQvNC92QU16aEYrajJvK01Uc3owQXNOQVYxY1cz?=
 =?utf-8?B?UytzNWNQRjFOTStFVTBzRGFKREhuWERHZFlKUmI1S2h5SFY0emdoQkZKSUlq?=
 =?utf-8?B?NGJ5dDFuODVhRjlCT0RqUTJsalh5RTJsdTJsR0NQVC9WTHliYlBzZm9DbnRp?=
 =?utf-8?B?bS9uN2J3Y0hkam9FL1hUaFpsTGREMzY3TitEL3VSd2orRGVrNWZYUXhZMGc1?=
 =?utf-8?B?bmp3OEw2SlZLeVFHU0hoSVJPZTlSRktnTnMzRXRDc05iUVZjTGhLaGNKS3Ir?=
 =?utf-8?B?NVZRbUJUMnErNmQ0UkFqVzRkZzhtUDRnWmh2VWxsa2FOTENGb2NmUDdWa3o5?=
 =?utf-8?B?Yy9CdytaWk5WVnpLMFU5VGM3VVRGSCtNMkJaaUxGeWxvN2NWYTUwOXA3STN3?=
 =?utf-8?B?K3Z4VnA1aXlHVk5QaUpnNkZPZFlSbnFXRVlab1B6OGcyelkxNldWWmhMYTRP?=
 =?utf-8?B?aG5TN0VBMk5COUhkVlU0bE91M0RvUUZUcHNhLzFoMWEwZWNrU24xaXcrSUJ3?=
 =?utf-8?B?MFpUN2x1Y1lvbmRFSUtleXFoNnFtM2pWN0RmVUxvMEZaS3ljaEtvTXp2TVBL?=
 =?utf-8?B?cTdmS2FYalcrenYwRXlXSXRyb0VUd0VoQUxPK2UwVVZkYWlwLzhEd2JPUE8r?=
 =?utf-8?B?ZWFvZ21HRkRLTHdiajRVcUtwcGpGT0E2ZkZEN0lmWmRtSGdwUkN5Z0laYVpz?=
 =?utf-8?B?bUJOSi9yZCs3aHVEUWcwQUx4RXdlNTI1SnY3N0M2VXlVT3cwajhFKzlTRzk1?=
 =?utf-8?B?WmlXMFhMclQrOFNyQStwcmJiSE9NRUZrYWtldDR3NnMvbHNPdXZTaVZQcUxQ?=
 =?utf-8?B?djYxbUs2NExlSURiRkREMjRHSmFZNEZseDBLeFZWcjF0VmU4VWhJMFZjUGFO?=
 =?utf-8?B?cWE2OVlraytSckpNem9Yc2dZeWh4R01rQnFQOGZuQ3dEYlNvdXVodHEwU2dY?=
 =?utf-8?B?UXoxaHlDVWpZTFB4eitJaWE4QjdwTlZlbmY2dW4zOEhiL0o3NCtHRVpxZUE2?=
 =?utf-8?B?SzRFTDVFblBxN21WRkZoNCsranJpNmRRUUlLSnJCZHZEc3dlVnNOeVVHcGJ3?=
 =?utf-8?B?bGgvci9HRGxTazBKWm1NU3Zob3hFa09EWUJxWm5WVHUwRjZ4bVRTc0NKTjV2?=
 =?utf-8?B?QmpJRmZtYWtwNlVQMXZzZFhqc0l1RWlPVjdIQmxHZW40WXFMN3JkV3JrUG1L?=
 =?utf-8?B?L3VxTFdoYkJjZGxvcVVCM2p5ODB4OVpyUFYxTmRQZlh0Y3AvNDM3a1VleGZH?=
 =?utf-8?B?eXFROHcwbWNHUVFyMTNUd0NjbFNRcDlENlBuRFF0WEN5YTE3Zm11V3JaZmZ3?=
 =?utf-8?Q?vwme6sEk3Scme3yS5h+RtcNOu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed2d4da-7be2-4e83-fa45-08dd46ad0a1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 12:51:56.8951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5ZRC43ElorD6Va1eSb/hk1ahmRVDrrtT4XaxQbBeNrS+V3PLiIa4uZe+aVQjujlxivk7Le989sZ7oxJZ8SJWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4436
X-Proofpoint-GUID: 9xkL3tP-uZMoGXJpE_uk79znInEDZ_-o
X-Proofpoint-ORIG-GUID: 9xkL3tP-uZMoGXJpE_uk79znInEDZ_-o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
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

SGkgQnJpYW4sDQoNCj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIFNNNCBHQ00gYWxnb3JpdGhtIHN1
cHBvcnQgdG8gdGhlIEFFU05JX01CIFBNRC4NCj4gU000IEdDTSBpcyBhdmFpbGFibGUgaW4gdGhl
IHYyLjAgcmVsZWFzZSBvZiBJbnRlbCBJUHNlYyBNQi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJy
aWFuIERvb2xleSA8YnJpYW4uZG9vbGV5QGludGVsLmNvbT4NCj4gLS0tDQo+IHYyOg0KPiAJQWRk
ZWQgYWFkIHRvIGNwdSBqb2IgcGFyYW1zDQo+IAlBZGRlZCBpcHNlYyBtYiB2ZXJzaW9uIGNoZWNr
cw0KPiB2MzoNCj4gCUZpeCBuYW1pbmcgZm9yIHBhdGNod29yaw0KPiAtLS0NCj4gIGRvYy9ndWlk
ZXMvY3J5cHRvZGV2cy9hZXNuaV9tYi5yc3QgICAgICAgICAgfCAgMSArDQo+ICBkb2MvZ3VpZGVz
L2NyeXB0b2RldnMvZmVhdHVyZXMvYWVzbmlfbWIuaW5pIHwgIDEgKw0KPiAgZG9jL2d1aWRlcy9j
cnlwdG9kZXZzL2ZlYXR1cmVzL2RlZmF1bHQuaW5pICB8ICAyICsNCj4gIGRvYy9ndWlkZXMvcmVs
X25vdGVzL3JlbGVhc2VfMjVfMDMucnN0ICAgICAgfCAgNCArKw0KPiAgZHJpdmVycy9jcnlwdG8v
aXBzZWNfbWIvcG1kX2Flc25pX21iLmMgICAgICB8IDU0ICsrKysrKysrKysrKysrKysrKysrLQ0K
PiAgZHJpdmVycy9jcnlwdG8vaXBzZWNfbWIvcG1kX2Flc25pX21iX3ByaXYuaCB8IDMwICsrKysr
KysrKysrKw0KDQoNCj4gIGxpYi9jcnlwdG9kZXYvcnRlX2NyeXB0b19zeW0uaCAgICAgICAgICAg
ICAgfCAgNCArLQ0KPiAgbGliL2NyeXB0b2Rldi9ydGVfY3J5cHRvZGV2LmMgICAgICAgICAgICAg
ICB8ICAzICstDQo+ICA4IGZpbGVzIGNoYW5nZWQsIDk1IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQpTcGxpdCB0aGUgY3J5cHRvZGV2IGNoYW5nZXMgaW4gYSBzZXBhcmF0ZSBwYXRjaCBh
bG9uZyB3aXRoIGRlZmF1bHQuaW5pICB1cGRhdGUuDQo=
