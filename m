Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A70C021AD
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 07:42:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D243B4014F;
	Thu, 20 Feb 2025 08:42:32 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by mails.dpdk.org (Postfix) with ESMTP id 6F42840041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7EhbxHrBn4e0Jv/3pzT5DF8zFMJfnec0szzeKYHUWHZpyD+6QKd4yJKHsed492LZ5AhySiQhWRWxdLfBcIlm3ZDR3jm76hOP/QOmKbuPDmL9ugJDM11vFyQqXsgGSyI7TE9XmlBm3Thzu7T/L9zKibOMG5Bjx+98unA8zZj2XVEBv8JPg2/0YwSLSFmavKrOhvvHuPL2BZwH4JEeY5bR9qNOHfH02qPDtdAAQB1ijL+u4v4XQpiJcv4/EjfrW0erbIXiwUbKaNx43wWM1DvQxQqEg970j5T9RQem1pYRnhUCKplZrcUB8MQVfjbhqHyn2zioCJgebiRoAVK5Y2GoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSgcjRlodzl8neNMGBzCwMZt4D0XGnbdjOmsC2IhiIQ=;
 b=hQZtnJoiwupYW4DKBDyFVHKrMsXIRmm8LX0jVK0XLOW1RlgjpnIGLgy8pUzdymb9d2BWSTJ36eJiEf6jUW9Tzl4P/gNdd2qla/GlhVqh80SdSawMdK+uSTzfYGOXCvsumr6FvsziUTYD7uVm3JJA3B3DCVGTrWPeViOiwjAMOB/GU+9OZh2Y1/QkPI5jGABSMpolFG6Qj6QVnP9o7HOlX8zqOypFjuqBSuqjBvYTINBZntOhDw97bHm6BgLtatpTj93cRQjXbnJXus7/cVdnlM5NFuxNgTnBt/+8WMBFTCToKVcWTa286Pa6exDYVCyZ/1qHB180iFGzu6oEzhQb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSgcjRlodzl8neNMGBzCwMZt4D0XGnbdjOmsC2IhiIQ=;
 b=rPxKjuIXCzqllatYNX+AMT3FjuKb/F+sbwpkpMXT32bUCVZ2hXQJRL6vk/NfCgAi96opk6Z8veL0D49cbmZh6FHjPebXBjvowGm66pLmn78qmGhu4pdA5S14HEKknSd4iLd3vcK2b+zl7PKlH7OEIMprZ5BWtC5MsMPGTa6X/lvoqjgato34ffpD1DgMRjSeqtzSHXY+9Q9W1vzf7/fMOnK1hYrqGFbtN6Uru8HYOe2a4nbcH79RlIOhXn3umiBzqi1w/L99mXPo8RQDl9IBqsddZYuWC9A+Vn3uO/WY37mS5hdSxz5jl54X9SsAkNa/UlPZWzSB1nBGEqZy32PDHA==
Received: from PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 07:42:28 +0000
Received: from PH0PR12MB5679.namprd12.prod.outlook.com
 ([fe80::53fa:ce15:8a0b:f0e6]) by PH0PR12MB5679.namprd12.prod.outlook.com
 ([fe80::53fa:ce15:8a0b:f0e6%7]) with mapi id 15.20.8445.013; Thu, 20 Feb 2025
 07:42:28 +0000
From: Ori Kam <orika@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Gregory Etelson <getelson@nvidia.com>, Maayan Kashani
 <mkashani@nvidia.com>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH v2] testpmd: support meter_mark init_color in indirect
 list configuration
Thread-Topic: [PATCH v2] testpmd: support meter_mark init_color in indirect
 list configuration
Thread-Index: AQHbgWB1TcLg0VcsY0ipa/09j3rEK7NP0r/Q
Date: Thu, 20 Feb 2025 07:42:28 +0000
Message-ID: <PH0PR12MB5679E5458D54F7A938F6705BD6C42@PH0PR12MB5679.namprd12.prod.outlook.com>
References: <20250216140420.216805-1-getelson@nvidia.com>
 <20250217172111.67655-1-getelson@nvidia.com>
In-Reply-To: <20250217172111.67655-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5679:EE_|PH7PR12MB8594:EE_
x-ms-office365-filtering-correlation-id: 458c2250-1ae3-4e74-0d7b-08dd51822044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NEdnbXZnRU9CWld1ZWRuU2xIbFgzb2Y3clZuNEpXa3BIU1I5S01yci96YS9H?=
 =?utf-8?B?aUVZQSswS1dwa1c3T2ZPdlk4U3lCemFUbmZpNENZdjZDVkdhMmJqS3dCNDhO?=
 =?utf-8?B?dm1SRDJ0THY2Qmtocy9XSzFOOHFvWDlaZmVVQ3dxY0tvNjVGVGM3TVBQMTBr?=
 =?utf-8?B?RTYwNWd1YlJjc3YvcjVpQk83enBOMzBuTUFQZG5yNS9aWStMeUovZ1crTGQ1?=
 =?utf-8?B?M0xZcUFnSkdxSUNLY1p2NkVsekM5V21XSm9RT00ycnBlRHEwbmRyM05EWEZ1?=
 =?utf-8?B?ZzRLd3BHaVcvdy9oQ3J1d2NKTUkrM0ZIV1ZGZDkrMUpScWNlbjdRSUQ5c2My?=
 =?utf-8?B?SlRxZVpBL0ZRcmpkd0RXcDJpM2FtNG5NQzlQekNuWWlOaFdZd3lycDlvTVRw?=
 =?utf-8?B?Vm5qa2c1TWV6WWtMNGNaMDF0SU10RHZXOHBtTk9JdnhHMmJNbkFHYWh2eFdm?=
 =?utf-8?B?c3NCRmoyUHliblo2WFVGZEQ2NW1ZV0xsdHhxbzRqM09QMk5sWlhvdElGQzhQ?=
 =?utf-8?B?UGRYMzZGa3pHUVRzQ21WMzUrcU92cERsZUM4UkZiYlNyQnAyV1lLNzI5eHJD?=
 =?utf-8?B?UThWWVk4T0MvdmRPMUs3SFQydmthZnRJeUVCaXZjeDVHOUdHMytaYjdiM0FE?=
 =?utf-8?B?UDlQNm5SY0x3Sit6aFVvNlVaNmJoRHYwRlR5MUVxS3lMYVhsdVZaVEIwdXNS?=
 =?utf-8?B?Yms1S3JabnEwbjVJL3pSR2ZHeUpYZ0ZRekdKNEJjakM5emFIM0N4UDNGUnA3?=
 =?utf-8?B?MzFHcUdRbHVWcUNWZ1NHcVFqZlEwRzBteEI4Q3RkTWRndUc0TW9BblZ0Vk9q?=
 =?utf-8?B?eW84THUrUW8vTnlwSTBJazIrb1dkOFpqYVlUR212NHBuOFFFZ0tUbU1teTZN?=
 =?utf-8?B?YjBXUkhRUGMwcmpQaVJkemZrNGxLeHBrUUZVdnNDMWdkMFVWcnZub01KMkVo?=
 =?utf-8?B?MVZySDJaLzZVMnBtQ0E2NmtwTVhZYTNkVzdUSzBkNEhaajdTWnNLbDVXaVlH?=
 =?utf-8?B?NGVTajB0RkpDbXRXa1JxWTRQbEdUdThDcG9ibFRnaXA2bW4rVjhmM0ludlRJ?=
 =?utf-8?B?SnlyVHdqTitOSWVVZWg4RXk5REdxNmRoV0sxVXJzUW5JOXhIenR1VkpsblZa?=
 =?utf-8?B?NnFRQnBEQkFSMnpEM3hBcWRPSS9idXp4K3V3b3lKUUJvLzFUMlNNWDZqeDZu?=
 =?utf-8?B?TlJ4czhtVGtSaThFc2NrdjJCdVFodnRZbktzQXVGc0xhRTR2MEZoT0UzTzF0?=
 =?utf-8?B?VHgxOExzM005RktsMEhsTy9FcjVuQUJsMFI2bC93NXByWWZKV3M2Y0NseW9p?=
 =?utf-8?B?ZXh2MVN3bUk1ZEpjNlU3MU9LM1o3aDhrRHkrdnBvZGErV1RGNjhKaWVpWGxR?=
 =?utf-8?B?L3h5Zm0vbmFEV3RWRkNYV1A4TTV2dkUyUXB0S2RXSkFTYWRKVUVQbk0wOVVR?=
 =?utf-8?B?cFVzTHhabHltY3M5aTJHZzB0K0NFVkhJN0lGcUFJeVNQVU00cThyWGFmSko5?=
 =?utf-8?B?ZHV4NkMxU0RyNmtkYllwTTR4NlZVcUo0RThMdVE0dlJEbEVGbG9ROS96MHlH?=
 =?utf-8?B?U3pyeHNIc2tzSkhHdmNWMUlKTWRFWE80eVZ3aENnVkloaVB0eG0rNWVYa2RP?=
 =?utf-8?B?S052aDBKTk90YkNGTG9YUHRqcDVnai9vWVZLbjIvK3JIcUN0cTg1M1BIZVJx?=
 =?utf-8?B?UUxnVStoQ05rQnRXUkFRZm9Ib21neXpDcHlFTUJmY2g0S0xhVWczOWFRcVN0?=
 =?utf-8?B?MFkyTUFJb0Exc1BqT1Rnd3lqR1ZLYUZqVTdUbmQ0OUhyWVFRdnJMSVA5cmpH?=
 =?utf-8?B?Zyt4c2hpYkRXYXFuMkxjUnBXY0JPVzI4cnVGelBCUVpHNVhGZTNQMmErWklj?=
 =?utf-8?B?am41T2RqOUNmQmJFYkhncnRRMmZXeUs4SEhRSWx5d0RybWoxUERqLzBzdG5O?=
 =?utf-8?Q?Q6UoKeMLzSMOHjnj2+CRN3VvzinUo/ur?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5679.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlhGYkRsajk3THVMOWtYNGxvWjE3MzIwYVVud1ovZGtlbXVnL3VWLzQ0STNr?=
 =?utf-8?B?VGYxZ0MrRHQrQThJWklXUHdUcHJtOVgvSkNQVjhkeU1KZEZiVDFoZmV3bUNP?=
 =?utf-8?B?b2RkL3NsbWpEek96NFU2MzJLSUtvaGlLdTVxcDhaRTVqc2VLL0RGb0grckZt?=
 =?utf-8?B?dTgwWldiM3YwTEV2TVBlVVNhRmJmQ3NjeDZsMzZUUzZnOHhVVkVZWlJ0ZVNq?=
 =?utf-8?B?TlZxY1JPK2l5UWd0aVI5TlNaVmZUeStjMlR6c0VIL0xKU3dGaGtLMUlnTHg2?=
 =?utf-8?B?SGpoUW1mcFp5N3RiemNnb1hQVi9Ia0VHek5YZDc2VHVCRFZyU1ErUVhGU0RG?=
 =?utf-8?B?ZjVxeHEwWXBhMW02dnpKTWp2bUNYNCtmOEZRSURDNHAwSndveWFRdW9yZjkw?=
 =?utf-8?B?dGpyQldxNVhEYnk0SkxZODZlWmo4MjZpMVU0Wmw3VHRuNnVqSlB4YTBCcTFy?=
 =?utf-8?B?SGlwMHl3VDROL0VtdThaQzFqMzhuTkkvSTVrYThpKzljVkxocktTWjh2ZlZ6?=
 =?utf-8?B?NFV5UlJCVFYvM2lZMHpjM3Npa09DKzNqTlMrNy9McWZmakd1YklGb3U3eThH?=
 =?utf-8?B?NU5IVzlkZVZNbUhQSDR3UGl0cmVub0xGMXhlWi91dy9oM0dqRFI2eVMvNUFI?=
 =?utf-8?B?MXJVbkpJNFJJRGpNcnZEZlpQNFV0b1lZQVFGQ2tLK2l2bFNIL1hGTko0MmJD?=
 =?utf-8?B?R1hUUzByRWZoS2U5Yis3c3g2K2lQeDgxakx5c21Qa3VBZFpzeGVpUnZOWDBY?=
 =?utf-8?B?WmVIdE5qQ0R2akRoYVJKVGphMFR6S21xR2ZUMVRKaG5YbDhiSzhwRlM2Wldy?=
 =?utf-8?B?RTJJdnd5SXdqZjQzRGlDK240NlpOb0cvYVkwRm9YdjFuM1RGc1JwRE1xQTJI?=
 =?utf-8?B?RFhabnRXend1Wkh3ZUNRcFROYlZSRmdxSUVmRWl0TEdUVC9wQkVyWjQvZ0wy?=
 =?utf-8?B?a2syY2g2eDk4Z0JyWEJUZ0Q0YUNJajVWRDN5eHhsMnI3dlZqdmFJVEo2cG9o?=
 =?utf-8?B?YTBUR0tVZDQwL1FrYzRuaEp6QlNjTVFRd0NnRWtNcDAyV1phbWhsR1pGTkkw?=
 =?utf-8?B?OVVLRmlQWFNEY203QVh3dUtEUk5iUmNac1FjVVF6U3B4cHFmRlBQUWIwNWVm?=
 =?utf-8?B?cmRWYnVOcEc2bnBtKy9jVUtoamw4c0FqbTRnMUZkY0psZDVKUnlBUVFEeGR2?=
 =?utf-8?B?VFUvaDdzNHVVZ3ZDQWROUEtFZlZ4NWFSSXJqbG5FNUpSZkJRTHc1aTRoMDFF?=
 =?utf-8?B?NkZ1cmVPSnNocG1uT2RlL3hkaG1OWWdjZlA2N3ZjdU53ZkRXQmhpK1BZdVZD?=
 =?utf-8?B?SkVtUTlLTTBQK29TR0FNVFVzaS9Kdi82OXkySzJKOVZQWUYveU9zR2pSb0g2?=
 =?utf-8?B?d0ZsQ29iUUI4a0dSanB1UlpwbHdtQ0gwTzIrWDdKUlY0akxuZ2ttakJVbkFT?=
 =?utf-8?B?MEVMQ1ZXekRNblFSbTluK0RRbTA1Vm5SdlgyclRzMEVWdmwxcERGTm90MHY5?=
 =?utf-8?B?TVUxdHVFVEtUSjhZd1dQUnUwQmJoNmdmMksvQlZmNXlXQVdFc3NpYzdGeHpC?=
 =?utf-8?B?ZWFVUUFyREhIZVQrQURSUlA5WEFvVnV3REtHcFlhVm81OXVaSXJSQ3B6MzI0?=
 =?utf-8?B?OTRDd3JnNGFmVEN2Z3JWY09LNmlmd2VGeDNnMUVhb3hFRnJPblZ4c1VHVGxY?=
 =?utf-8?B?MzdFZlByb0lsQXJQOW1XRTNxY0NkelErekZHTGs4WmtaYkZISFhVYmoxNXpF?=
 =?utf-8?B?QkdVTXVwb29YT2dTV3hsdXFDcXBTSm1OZ0RmOHBpdm1VVkdHQUtOVUNqQ2VT?=
 =?utf-8?B?YmJLUC9qL1lTUGVFYzJVU2hNaU8yWUd2NDJzZ2thUERtUGNZRVJvQU9pVHgr?=
 =?utf-8?B?bm9NcTdtakxwTW5RY1BoTTV5b0ZhYUcvYVgvU3Q0RGZrWVdaTnMvYkxES0pY?=
 =?utf-8?B?OFpham45RDhXTlFKK1V0S2xtTjdDV2NlSjRpOUpSTXRhQzJ6Wk5rZ2hqczZE?=
 =?utf-8?B?eXRIYi8ycDF0VGtqQ0V4azNHSGE1d3J0Y2FaV1dhZGh2N003eVBOdnQ1OXBZ?=
 =?utf-8?B?U1RJZWpwTERTTWVBaFl2ei90WGVkbC9GNEEvZ2c4MGI4d1ZjaXpjZ3B6bXBk?=
 =?utf-8?Q?FFLM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5679.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458c2250-1ae3-4e74-0d7b-08dd51822044
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 07:42:28.4543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C6vO952N7JIRlEBlJ2EPyvhTVVK+ppx+j5MmpYaCfTzz1Thu2SbPZARCdtRhEKg+kOEV4xlbf8dxPNrULhR2RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZ29yeSBFdGVsc29u
IDxnZXRlbHNvbkBudmlkaWEuY29tPg0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDE3LCAyMDI1
IDc6MjEgUE0NCj4gDQo+IEZsb3cgYWN0aW9ucyBwYXJhbWV0ZXJzIGluIGluZGlyZWN0IGFjdGlv
bnMgbGlzdCBhcmUgY3JlYXRlZCBhcw0KPiByZWFkLW9ubHkgYW5kIHNoYXJlZCBiZXR3ZWVuIGFs
bCBmbG93cyB0aGF0IHJlZmVyZW5jZSB0aGF0IGluZGlyZWN0DQo+IGxpc3QuDQo+IA0KPiBJZiBh
IGZsb3cgcnVsZSBuZWVkcyB0byBhcHBseSBydWxlIHNwZWNpZmljIGFjdGlvbnMgbGlzdCBwYXJh
bWV0ZXJzIGl0DQo+IGRvZXMgaXQgd2l0aCB0aGUgaW5kaXJlY3QgYWN0aW9ucyBsaXN0IGNvbmYg
cGFyYW1ldGVyLg0KPiANCj4gVGhlIHBhdGNoIGFsbG93cyBmbG93IHJ1bGUgdG8gc2V0IG1ldGVy
X21hcmsgaW5pdF9jb2xvciB2YWx1ZSB3aGVuDQo+IG1ldGVyX21hcmsgYWN0aW9uIHdhcyBjcmVh
dGVkIGluIGluZGlyZWN0IGFjdGlvbnMgbGlzdC4NCj4gDQo+IEV4YW1wbGU6DQo+IA0KPiAvLyBj
cmVhdGUgaW5kaXJlY3QgYWN0aW9ucyBsaXN0IHdpdGggbWV0ZXJfbWFyayBmbG93IGFjdGlvbjoN
Cj4gdGVzdHBtZD4gZmxvdyBpbmRpcmVjdF9hY3Rpb24gMCBjcmVhdGUgYWN0aW9uX2lkIDEwIGlu
Z3Jlc3MgXA0KPiAgIGxpc3QgYWN0aW9ucyBtZXRlcl9tYXJrIG10cl9wcm9maWxlIDIwIFwNCj4g
ICBtdHJfc3RhdGUgMSBtdHJfY29sb3JfbW9kZSAxIC8gZW5kDQo+IA0KPiAvLyBjcmVhdGUgYSBm
bG93IHNwZWNpZmljIG1ldGVyX21hcmsgaW5pdF9jb2xvciBjb25maWd1cmF0aW9uOg0KPiB0ZXN0
cG1kPiBmbG93IGluZGlyZWN0X2FjdGlvbiAwIGNyZWF0ZSBhY3Rpb25faWQgMTEgZmxvd19jb25m
IFwNCj4gICAgYWN0aW9ucyBtZXRlcl9tYXJrX2NvbmYgbXRyX3VwZGF0ZV9pbml0X2NvbG9yIHJl
ZCAvIGVuZA0KPiANCj4gLy8gcXVldWUgYSBmbG93IHJ1bGUgd2l0aCBpbmRpcmVjdCBhY3Rpb25z
IGxpc3QNCj4gLy8gYW5kIGZsb3cgc3BlY2lmaWMgY29uZmlndXJhdGlvbjoNCj4gdGVzdHBtZD4g
ZmxvdyBxdWV1ZSAwIGNyZWF0ZSAwIHRlbXBsYXRlX3RhYmxlIDEgcGF0dGVybl90ZW1wbGF0ZSAw
IFwNCj4gICAgYWN0aW9uc190ZW1wbGF0ZSAwIHBvc3Rwb25lIG5vIHBhdHRlcm4gZXRoIC8gaXB2
NCAvIHVkcCAvIGVuZCBcDQo+ICAgIGFjdGlvbnMgaW5kaXJlY3RfbGlzdCBoYW5kbGUgMTAgY29u
ZiAxMSAvIFwNCj4gICAganVtcCBncm91cCAxMCAvIGVuZA0KPiANCj4gU2lnbmVkLW9mZi1ieTog
R3JlZ29yeSBFdGVsc29uIDxnZXRlbHNvbkBudmlkaWEuY29tPg0KPiAtLS0NCj4gdjI6IEZpeCBj
b21taXQgbG9nLg0KPiAtLS0NCg0KQWNrZWQtYnk6IE9yaSBLYW0gPG9yaWthQG52aWRpYS5jb20+
DQpCZXN0LA0KT3JpDQo=
