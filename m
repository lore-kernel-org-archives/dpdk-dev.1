Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F262CE7B08
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 13:04:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43717402C8;
	Fri, 14 Nov 2025 14:04:39 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6DA5140151;
 Fri, 14 Nov 2025 14:04:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwGTzgGtud4uXIl0HFUSK8BbIlnIZ3g2lv/s4UUDEYXMsWhoXIkrIFgXASGf0O8TRgzr2hDLTD9gv/lna6YMayTCwPhK/FWUHgYlDNqPVSjzL12TXSC3PUcWLWoX5PHuywcZG7NbAHxuqBCiH0inaZbRVP09cB+fOYfAQnkvd1saq/W17Cwjt+5ayuyMIZpIarkwQDVZT1csJhAA3OG+E9jCQmgHoEgZasMYPhPM+uC7u7IbFfyw0zxnQD7VnHmKgTgkhbtoi2kUpex8e6kdNkT68UHxL1lPV4gG0PxHZeDQZag6GdaOQ/fh8o0pIGckp8eE3fjxpyzY+w3hrrZTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzE2d16obt7KIXd3o4Idngtvwb8eH4LEDZBpRWjGFV8=;
 b=Gh5ZIOa3I60zcPab3t47QEsWNDzy1jIdcb8HEOV55f4gYw+8bo7JKGzczFR4k7EtZdw2Y837LD69Txpwm9rgsIISI4JbRnzh6y3Y1o6HwkLD/nAtUSVL2fZbZvfXw5DGgOifzg5UhfkTt0Q0f+M+aolmuSJL0+mIs/nRdomlI/zeHUwJRRi0YeNkDIwuBosJEBjhOJnRajQF9CxDjG6JknRS0XJ5mh+L+OTKgoJaZhBo7RkZ4UIKlNfYFcypQEeb2F2eBbSGDVa6h7g6CcSIJ6uEZ8xJZQ6oJYDPFXCDymcE2rOU7tVGURt676JDz9mbA6PeoeUeSk/xnrW1GE42Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzE2d16obt7KIXd3o4Idngtvwb8eH4LEDZBpRWjGFV8=;
 b=CNNMij91LFllODz+yeC7PCD+/3jPhcGQgoRfbB8Aaqdk+EA8H6dKFxEO83l8dGlXWdA9ZTYK4sSo+r3VS68nKejCUhShshEH8S5GPNFeEeKKZ0zAX8DWjjwgJ9vHMZw7S4CmNYKtnvdDgjZFxE2OUmQGz4ffw9Mshg7cff3JgEFB9GoUJDmY/GQd8I4T2gQ2aCrOjs/q/D96X3k447gUgFTWyoeo1hRpVlDi7R1AzytYQyfZER+NLYVsMobv30tKrGaQEZa0RnJy6fU9mnliJDSjYc/pfS3UB48OQrxFcTboQ41Ilq9QjALWk4fnPuRy4sAw4YB6X4c7oXSsy9KXtA==
Received: from MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.15; Fri, 14 Nov 2025 13:04:33 +0000
Received: from MN6PR12MB8567.namprd12.prod.outlook.com
 ([fe80::9bde:b697:6d6d:ee04]) by MN6PR12MB8567.namprd12.prod.outlook.com
 ([fe80::9bde:b697:6d6d:ee04%3]) with mapi id 15.20.9320.018; Fri, 14 Nov 2025
 13:04:33 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2] net/mlx5: fix spurious CPU wakeups caused by invalid
 CQE
Thread-Topic: [PATCH v2] net/mlx5: fix spurious CPU wakeups caused by invalid
 CQE
Thread-Index: AQHcUr0M7jcb4+xK2keHHFTFXjJENbTyKNNA
Date: Fri, 14 Nov 2025 13:04:33 +0000
Message-ID: <MN6PR12MB856718271C670BAB59DDD477DFCAA@MN6PR12MB8567.namprd12.prod.outlook.com>
References: <20251015133957.4094235-1-sivaprasad.tummala@amd.com>
 <20251111034057.3177641-1-sivaprasad.tummala@amd.com>
In-Reply-To: <20251111034057.3177641-1-sivaprasad.tummala@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR12MB8567:EE_|DM3PR12MB9416:EE_
x-ms-office365-filtering-correlation-id: 8d7907a9-8b1b-4d52-ff8a-08de237e5b11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aHZEZFB0QUJxK0QyeGJrY0V5bFFwMkNxR3dHY0RwM0xtYUIrZFVsdmI2OXBQ?=
 =?utf-8?B?cThML2dpUjFwdzRsaE9nTCt4cWw5bGc4K216SFJBTlp0alZuRktlcnpycEJI?=
 =?utf-8?B?b3V6SGkxcUFJTkdyYjlPNnoyMkFYcHgvbDIyQ2g5ckkveThEaFhIL1BhakVM?=
 =?utf-8?B?T0gwVGhiRllnRWxpdVdhdUMvOWExdEhuNkdqQzRoL3h1MDBIajA4ZlJ6bDQv?=
 =?utf-8?B?cDBwbEd1V1BMVnFvZGdFQVVxSU1Qb0VKdW00VlF0N3YweUpnSllHRjlBdFFN?=
 =?utf-8?B?OWZyemZuRGhRS2E3UmJVcGV0b2srcGxEOHVJL09ENktYMU9HUUVFTzVNbTE5?=
 =?utf-8?B?N2JGVFRmYXduZDhtaFN5bzNJalNOdzdFOWRXNHVXOTNxbVo2djlLTHdOeGo1?=
 =?utf-8?B?cysyajBDMitTVGlFN2FUOXZJQm9qUEtaT0tMa3lwMmQrai9YVFRxYS95ajZV?=
 =?utf-8?B?NjVQQyszL0lOYjcvaGtpVGxubEl3dm9WcGFBNG1CSEM2MGJYMmlpU3pMR3ha?=
 =?utf-8?B?d2YxQlNoRFlPVTlSNzhqWEJRR0VSWUFoNUlJWUdidEU2a1hYditsWlBic2JN?=
 =?utf-8?B?anRXVm5majNpdHZnNitYYWowSFdUNExFQW4ybmEvYkhZaTZtUHdKUHREVGdv?=
 =?utf-8?B?aytRc1FkMEorcHNQZU8veFU0eE9ReG1TMElHR2RaaG9xMkZ6VUlYak9wSlgr?=
 =?utf-8?B?NzNHam5JSkFpWFNLNnYyb2VmQkFEVnAydkRwRGdicjYvOEJmMDduTG5yVWp5?=
 =?utf-8?B?MVROOGFLTXZJSVRQbGxiczBucUUvVHBheEkybVVFR1BOY1RzcFp4Z29FUTZL?=
 =?utf-8?B?TUdrdXVXbGp2dExpM0pMemozcGkwL1pDVXhPeFd1cE5DSHJ5a2F5Rml4MUR6?=
 =?utf-8?B?OVBIVDUxQmJ4bkJYTHpsSTExdXFSdmlkOGNObmZPYjU2eTZiN2ZacjBOdUpO?=
 =?utf-8?B?c2RDVGp4a3NXT3lZOWdTdVV1NzQ2THJpc2svaVZ0UGFoV0g4WWNaWjFaWFJV?=
 =?utf-8?B?dDc5NFI3V0ZpN3dWYmE3VjRPYUlqVHNNNU5vcXlJTjkwdDZJWWhpWGs1cmlI?=
 =?utf-8?B?MTJrcGQySGoyNFREbGNGMGk1VFZ6MHJGSE1kbmdUWGhVcFFLRkptTUJUYVNG?=
 =?utf-8?B?dFBsU2xNekdDUDEyd2dSOVFrak1rNllxVS9vMkNXeTUzS1RSZE90SlBvWmYr?=
 =?utf-8?B?YkRQTmg0SGkrbEVEanhSajBSNWNyYm1iVDVEQk84V1lVck9lWWgrbzFNUkxD?=
 =?utf-8?B?am1NTlJDSmhTV0QzWlJmOEF3dTRTNzBubTlXbi9TVE1Da0F0cnVpQlBudm9O?=
 =?utf-8?B?R2RmL3dLTXRiSzBsWGVzSzNnS25xb2VWZHpFZ0lndnp4Ykxra0k5Z1c0cysv?=
 =?utf-8?B?SXFHcm1ieDVNMVVTL3dMMC9ONmVScm5FT1cvZUMrWVFUUlFmY3htNUFWQUht?=
 =?utf-8?B?bDVacVZuOVc3RVA1OE5kRk54enVZaHRHS1AvRzF3a21RTmRPU2M4a2lzM1lV?=
 =?utf-8?B?b3dlc0prSnNCVHRPektLU0tzSVNBNFFwRTh5K0R1THhhSlE4YkNuVjF2TlBm?=
 =?utf-8?B?Q0pUamZpQUhpVUFwSi9LY2plcGEvT2dYd0xiYnlHZDhsNlNvaVVTdDVmajJ6?=
 =?utf-8?B?cFdKZlQ0TVorNmdRSHI3THpBRDhGcTNCaFcweEVmVFpRZTlSOVBWMUo5OHNn?=
 =?utf-8?B?dHdjdktiRytPTUZFVmMvMHZ5U0JZVnMyV3hNVlFjRFM1NVk5ZVgxYnBaaUpI?=
 =?utf-8?B?WTAyZkJlUExjVzRhdDQ3MXMvZ0hTVHhyc0lneFQvdWtMOG90MUtaODlTdUpk?=
 =?utf-8?B?L1YxZUlKNmFBN2N5MG90UytkTTkzV2N5a1B1ejU5MnFXN2pGcGppUGI1Nnpx?=
 =?utf-8?B?Skpza2hzYUV2QXZvQUhqaUdzSk9KOUgrZjZSMmJOQk13WHFsaDNMZVh5VWg3?=
 =?utf-8?B?aXgwWUw0ZFliKzQ4bEJvck0xT3J5ZjVsVjIrZS9LTXpiSmdJRHBBK01zcHR1?=
 =?utf-8?B?dSt2WEIyMUZLUEZWSVo2SWVzcTdqQk5DRUhaTVVjcWY0VEUwZjNhbEJNb2h0?=
 =?utf-8?Q?lFtTY0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR12MB8567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnFleTRKd0xUeWVITkFaVkNEbHFzNytiVDBaZDB2bmdGL21GR2Urek1ZN0N5?=
 =?utf-8?B?MGo3ZWNHS2d1OGJqTVdRQU1XY213WVJEOURjMGJHSEZHcTRlMnNwVW9nUG5M?=
 =?utf-8?B?Z05vSUU4RjlkaXYvc0t1aStXQndjSUxlWkNFSzVGdTZsSllMZVArNVkxbTZr?=
 =?utf-8?B?aFlGRnV6ckdmQm82dXNRbDJyT0pYMWNmbEo5K21MTUhidnFZQWRQN0JWWXJW?=
 =?utf-8?B?WTE2Q0pMR01XUlRGZHRFWjhFb3poWlc3TXFWYjlIRm95cE1qRVpYcmE2ZDU3?=
 =?utf-8?B?eUtMd3RyZXF0Qm9oY1VVc0ZBNWI5QithOEcxaStYUDBQRnpkY2srNWpXVmlZ?=
 =?utf-8?B?aEthc1RKL0xwL2JPTTMycVZiVjlzS254d0FCWXlUbXVjNmkrVE5qd0JHTTha?=
 =?utf-8?B?UnYyeVo2aHROczRudHRyZUkyZE5mWmFDY1U1cXZwKzkzN0ZUNE1GWllTMEJS?=
 =?utf-8?B?K1NvdDFNK3lNTXBNcStMNngrNnp6OTVzM3A0Uk9STXdDMnA2VGJ2TkljWU4r?=
 =?utf-8?B?dlpPMXBFQkcvYzVRTGlScGxJMXVRWmZocUtOR1graWZiT202aW91OFJuNGd2?=
 =?utf-8?B?S0RVZG80ZEJuT2dBT043NzRzblUxTi9BYjlOaTcvYTA4cDVwWnlzc3ZtY2dC?=
 =?utf-8?B?QkliZC9aN1NyejZBdFFqZVdsYnp0WjB4ZVpLY0IxQXFXbWN1Q1Q3UUkveGRa?=
 =?utf-8?B?YkwwY3M0amlHUS9rbEUwOURNcGNzVy9XdGdyMStkRFBESHhCUHh4ZnlkN1hI?=
 =?utf-8?B?Z1U1a08vdktGbDdtZjBZTGFuQlBmVCs4ODM5MEQyaGw3T2oxdVNRWEFrZmJE?=
 =?utf-8?B?RS90VXdWbXo5U3pxcTk5NWVqbmFMc21RMGlEVHZBanAyVEY5Sm1sZmtHdUtY?=
 =?utf-8?B?RWJuUmNCYytOZUNsTmFOSmc3VFBXZnUrUWFTaGJQemZLeXdKQVdUVHEzckUw?=
 =?utf-8?B?ZTdLNnFHZVZEYkNFRU9IREJqb0E1Mmg3aktRZ1VuVU82R2JxOExHM2g2cmJD?=
 =?utf-8?B?M2ZYNjlUc3BwT0dUUW0rd2NCQUh4NXJZZldlWE1xODdBL0tzMG1Md3p0bzdY?=
 =?utf-8?B?Rys1anBVSXF1cEd3U0psb2lUa1UwVU9UQkRtbGJMVXJQQ1RlME1NTmpEakdv?=
 =?utf-8?B?VzdnOGNRckZHbnZ1TlVuRERTK0xLWnJPRWJHVnlvTjhHM2Q4Nkx3WHo1eDBO?=
 =?utf-8?B?cWRlNE5tWWdnODdYU1JZSy9FU09VMWNFajNkOVM3S2VHL0tIeWhLR0I5ZElm?=
 =?utf-8?B?VEdQMHgxUmMxSWM3djFiN3JhSGFVRXM3cUVTVFhVU2oxVXlNVUdST0NFSDBw?=
 =?utf-8?B?QWVwMjdlNEh4bE5ETi9HL3NMcDEwT1o1TzFWNjk5aEZ3c2IzRE1sVzN1aGYw?=
 =?utf-8?B?cE84czgwdUZ2Rk9CRFFqV0h1KzdjdmIrS3EzaHFYNmtaVGJrTmpxNVozUjg0?=
 =?utf-8?B?VkhZY2Y1NHV3R0JJRlVXaU4vUVZVZ3JRYzY2aWRpRlBlVmJNSnRZcG1KNW1k?=
 =?utf-8?B?TVh3bVZvTlFMaThGVjVPSWZCWVdxSmx5dkxTMnM1eHBNbXVjVm4yOEROZjNQ?=
 =?utf-8?B?ME5pWGZFNDRZNlBTTlV2WmJEOEJ1L3BLcXp2ZWJ6R0I3MXREZ0t0RmE3NkNE?=
 =?utf-8?B?aWF0cisvOHZPUEt0STNWcXlNZWxxZ0VrY1RBQjVOSngvc0pvSk5ha1Z2Q2R0?=
 =?utf-8?B?WGVVQTk0ekcwWVlHaElXL1pFRHVTY1NmVGZxdnhObytqdlNDNmRkazErMmNJ?=
 =?utf-8?B?Y1J6NEZHZExzaUdpVFMzR3ZVbGV6UytMWE02S25abkVscWNkWEJaYy96TGRK?=
 =?utf-8?B?S0xGNlZUWWtHOURQekFMSUpiaW5Na3UyK1BHcUZvNGdxZ0RmcTRYN0FBcmlK?=
 =?utf-8?B?M0FHTmQ1Nk1IK0ZuT2xoUi9ZZWVJTEhWejNoRlFSWWFGSzB0M212dXhBVU1I?=
 =?utf-8?B?eGtHa1AveE8vQyt1OEFJZWJzTjJqUnFldzQreWtMSlBPbFhPZlF2UDRhcnBS?=
 =?utf-8?B?UHlrQ2FkSC9seWQ0a0JwaHduNFAzU20vNFdTUmNmTTNCSTRid0l3OGJHRERL?=
 =?utf-8?B?SHZnS3ozNTdrbjlnODY1Yi9wMHFiekpsUmZlR3R4MFlPb2hiYS9WcDh0dGk4?=
 =?utf-8?Q?WGk1a1W4CkHXefv7pGF6pC2ng?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR12MB8567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7907a9-8b1b-4d52-ff8a-08de237e5b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 13:04:33.3589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IW8ENXbA5OzkrEpMQEri/evSOZ3RdfhHJUTL8otMvfRg1CSG5v0bd/cVEm8SECUP9VhQMC5dEn4abR2NqeuxhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaXZhcHJhc2FkIFR1bW1hbGEg
PHNpdmFwcmFzYWQudHVtbWFsYUBhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAx
MSwgMjAyNSA1OjQxIEFNDQo+IFRvOiBEYXJpdXN6IFNvc25vd3NraSA8ZHNvc25vd3NraUBudmlk
aWEuY29tPjsgU2xhdmEgT3ZzaWllbmtvDQo+IDx2aWFjaGVzbGF2b0BudmlkaWEuY29tPjsgQmlu
ZyBaaGFvIDxiaW5nekBudmlkaWEuY29tPjsgT3JpIEthbQ0KPiA8b3Jpa2FAbnZpZGlhLmNvbT47
IFN1YW5taW5nIE1vdSA8c3Vhbm1pbmdtQG52aWRpYS5jb20+OyBNYXRhbiBBenJhZA0KPiA8bWF0
YW5AbnZpZGlhLmNvbT47IEFsZXhhbmRlciBLb3p5cmV2IDxha296eXJldkBudmlkaWEuY29tPg0K
PiBDYzogZGV2QGRwZGsub3JnOyBzdGFibGVAZHBkay5vcmcNCj4gU3ViamVjdDogW1BBVENIIHYy
XSBuZXQvbWx4NTogZml4IHNwdXJpb3VzIENQVSB3YWtldXBzIGNhdXNlZCBieSBpbnZhbGlkIENR
RQ0KPiANCj4gUHJldmlvdXNseSwgdGhlIFBNRCB1c2VkIGEgY29tbW9uIG1vbml0b3IgY2FsbGJh
Y2sgdG8gZGV0ZXJtaW5lIENRRQ0KPiBvd25lcnNoaXAgZm9yIHBvd2VyLWF3YXJlIHBvbGxpbmcu
IEhvd2V2ZXIsIHdoZW4gYSBDUUUgY29udGFpbmVkIGFuIGludmFsaWQNCj4gb3Bjb2RlKE1MWDVf
Q1FFX0lOVkFMSUQpLCBvd25lcnNoaXAgYml0IHdhcyBub3QgcmVsaWFibGUuDQo+IEFzIGEgcmVz
dWx0LCB0aGUgbW9uaXRvciBjb25kaXRpb24gY291bGQgZmFsc2VseSBpbmRpY2F0ZSBDUUUgYXZh
aWxhYmlsaXR5IGFuZA0KPiBjYXVzZSB0aGUgQ1BVIHRvIHdha2UgdXAgdW5uZWNlc3NhcmlseSBk
dXJpbmcgbG93IHRyYWZmaWMgcGVyaW9kcy4NCj4gDQo+IFRoaXMgcmVzdWx0ZWQgaW4gc3B1cmlv
dXMgd2FrZXVwcyBpbiBtb25pdG9yLXdhaXQgbW9kZSBhbmQgcmVkdWNlZCB0aGUNCj4gZXhwZWN0
ZWQgcG93ZXIgc2F2aW5ncywgYXMgY29yZXMgZXhpdGVkIHRoZSBzbGVlcCBzdGF0ZSBldmVuIHdo
ZW4gbm8gdmFsaWQgQ1FFcw0KPiB3ZXJlIGF2YWlsYWJsZS4NCj4gDQo+IFRoaXMgcGF0Y2ggaW50
cm9kdWNlcyBhIGRlZGljYXRlZCBjYWxsYmFjayB0aGF0IHNraXBzIGludmFsaWQgQ1FFcyBhbmQg
b3B0aW1pemVzDQo+IHBvd2VyIGVmZmljaWVuY3kgYnkgcHJldmVudGluZyBmYWxzZSB3YWtldXBz
IGNhdXNlZCBieSBoYXJkd2FyZS1vd25lZCBvcg0KPiBpbnZhbGlkIGVudHJpZXMuDQo+IA0KPiBG
aXhlczogYThmMGRmNmJmOThkICgibmV0L21seDU6IHN1cHBvcnQgcG93ZXIgbW9uaXRvcmluZyIp
DQo+IENjOiBha296eXJldkBudmlkaWEuY29tDQo+IENjOiBzdGFibGVAZHBkay5vcmcNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFNpdmFwcmFzYWQgVHVtbWFsYSA8c2l2YXByYXNhZC50dW1tYWxhQGFt
ZC5jb20+DQo+IA0KPiB2MjoNCj4gIC0gVXBkYXRlZCBDUUUgb3Bjb2RlIGNoZWNrIGxvZ2ljIOKA
lCByZXBsYWNlZCBYT1Igd2l0aCBjb21wYXJpc29uDQo+ICAtIFJlbmFtZWQgdmFyaWFibGUgbWF0
Y2ggdG8gc3dfb3duZWQgZm9yIGNsYXJpdHkNCj4gIC0gVXBkYXRlZCBDUUUgb3duZXJzaGlwIGNo
ZWNrIG9yZGVyDQo+IC0tLQ0KQWNrZWQtYnk6IFZpYWNoZXNsYXYgT3ZzaWllbmtvIDx2aWFjaGVz
bGF2b0BudmlkaWEuY29tPg0KDQoNCj4gIGRyaXZlcnMvbmV0L21seDUvbWx4NV9yeC5jIHwgMTcg
KysrKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvbWx4NS9tbHg1X3J4
LmMgYi9kcml2ZXJzL25ldC9tbHg1L21seDVfcnguYyBpbmRleA0KPiA0MjBhMDMwNjhkLi5hYzY2
M2E5NzhlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9tbHg1L21seDVfcnguYw0KPiArKysg
Yi9kcml2ZXJzL25ldC9tbHg1L21seDVfcnguYw0KPiBAQCAtMjk1LDYgKzI5NSwyMCBAQCBtbHg1
X21vbml0b3JfY2FsbGJhY2soY29uc3QgdWludDY0X3QgdmFsdWUsDQo+ICAJcmV0dXJuICh2YWx1
ZSAmIG0pID09IHYgPyAtMSA6IDA7DQo+ICB9DQo+IA0KPiArc3RhdGljIGludA0KPiArbWx4NV9t
b25pdG9yX2NxZV9vd25fY2FsbGJhY2soY29uc3QgdWludDY0X3QgdmFsdWUsDQo+ICsJCWNvbnN0
IHVpbnQ2NF90IG9wYXF1ZVtSVEVfUE9XRVJfTU9OSVRPUl9PUEFRVUVfU1pdKQ0KPiArew0KPiAr
CWNvbnN0IHVpbnQ2NF90IG0gPSBvcGFxdWVbQ0xCX01TS19JRFhdOw0KPiArCWNvbnN0IHVpbnQ2
NF90IHYgPSBvcGFxdWVbQ0xCX1ZBTF9JRFhdOw0KPiArCWNvbnN0IHVpbnQ2NF90IHN3X293bmVk
ID0gKCh2YWx1ZSAmIG0pID09IHYpOw0KPiArCWNvbnN0IHVpbnQ2NF90IG9wY29kZSA9IE1MWDVf
Q1FFX09QQ09ERSh2YWx1ZSk7DQo+ICsJY29uc3QgdWludDY0X3QgdmFsaWRfb3AgPSAob3Bjb2Rl
ICE9IE1MWDVfQ1FFX0lOVkFMSUQpOw0KPiArDQo+ICsJLyogb3duZXJzaGlwIGJpdCBpcyBub3Qg
dmFsaWQgZm9yIGludmFsaWQgb3Bjb2RlOyBDUUUgaXMgSFcgb3duZWQgKi8NCj4gKwlyZXR1cm4g
LSh2YWxpZF9vcCAmIHN3X293bmVkKTsNCj4gK30NCj4gKw0KPiAgaW50IG1seDVfZ2V0X21vbml0
b3JfYWRkcih2b2lkICpyeF9xdWV1ZSwgc3RydWN0IHJ0ZV9wb3dlcl9tb25pdG9yX2NvbmQNCj4g
KnBtYykgIHsNCj4gIAlzdHJ1Y3QgbWx4NV9yeHFfZGF0YSAqcnhxID0gcnhfcXVldWU7DQo+IEBA
IC0zMTIsMTIgKzMyNiwxMyBAQCBpbnQgbWx4NV9nZXRfbW9uaXRvcl9hZGRyKHZvaWQgKnJ4X3F1
ZXVlLCBzdHJ1Y3QNCj4gcnRlX3Bvd2VyX21vbml0b3JfY29uZCAqcG1jKQ0KPiAgCQlwbWMtPmFk
ZHIgPSAmY3FlLT52YWxpZGl0eV9pdGVyYXRpb25fY291bnQ7DQo+ICAJCXBtYy0+b3BhcXVlW0NM
Ql9WQUxfSURYXSA9IHZpYzsNCj4gIAkJcG1jLT5vcGFxdWVbQ0xCX01TS19JRFhdID0gTUxYNV9D
UUVfVklDX0lOSVQ7DQo+ICsJCXBtYy0+Zm4gPSBtbHg1X21vbml0b3JfY2FsbGJhY2s7DQo+ICAJ
fSBlbHNlIHsNCj4gIAkJcG1jLT5hZGRyID0gJmNxZS0+b3Bfb3duOw0KPiAgCQlwbWMtPm9wYXF1
ZVtDTEJfVkFMX0lEWF0gPSAhIWlkeDsNCj4gIAkJcG1jLT5vcGFxdWVbQ0xCX01TS19JRFhdID0g
TUxYNV9DUUVfT1dORVJfTUFTSzsNCj4gKwkJcG1jLT5mbiA9IG1seDVfbW9uaXRvcl9jcWVfb3du
X2NhbGxiYWNrOw0KPiAgCX0NCj4gLQlwbWMtPmZuID0gbWx4NV9tb25pdG9yX2NhbGxiYWNrOw0K
PiAgCXBtYy0+c2l6ZSA9IHNpemVvZih1aW50OF90KTsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4g
LS0NCj4gMi40My4wDQoNCg==
