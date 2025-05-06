Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38049C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 16:40:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0FD140261;
	Tue,  6 May 2025 18:40:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 22FF94025D
 for <dev@dpdk.org>; Tue,  6 May 2025 18:40:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746549632; x=1778085632;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=X2KlqvDfiJYZ/uejBsd7KV8tGjMb4GpBJ9k87Jxw43E=;
 b=DsfMTSk2KFvyDOtxWjvkes2AlvqiFglZQkl/px80KQYKfkIrNwFfxLXu
 L2ZgUDQ9O0tYsBOctNwZad2WGsyo1KM4aE7JYg9xBXonQALXa2IQFKk2W
 sycZdr7Q0hMlZrgNYq5/vkMj7Z6ih+UnGcTYtatfqhQA1tUSZVw89IKrp
 VE/K+P8x51457d51TJa/rMiXOkDrp2UvGizOiT8xLyX1/DTZXaFiG/LiJ
 P6H60wEqh0tpXe6LqxaP+XmlL2gCvugCVgoGKThK70xOMGwQMdtAVY8C3
 5pHoTkIVSpSi0aL4UNZqmo/QTwHucJ7Fa4rZukUbxuhkCaxPemO8AA+5z g==;
X-CSE-ConnectionGUID: aUeeHcQbSZiUxyRjvGY0JA==
X-CSE-MsgGUID: fNwMOTL+RBa25ZUKMG88zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="70736941"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="70736941"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 09:40:31 -0700
X-CSE-ConnectionGUID: jDH/BoDgQZaVjLApcKRknQ==
X-CSE-MsgGUID: AqY2zLaPRuqHowLscEJ9Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="140787174"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 09:40:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 09:40:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 09:40:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 09:40:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIXcaHsYNnN22I3kC0Yk+8lFcd5tthJGH0uU4DbJrXQHqmFNP6OfxrMI1lcLQGNcahmcNP2XHH02D70XgP39uS7l36kcmMy1AWSiF9aaz/weKgSnb1ADVHuBgZ04e5tJ9Y1CILbFpxG/VsRZ1Yg4ln+9yCzL7qDwQFmlQXFWX3ItCeqi7F2NGBij8RfB+G9RfnTRnob47I59U8DCZhQaWrjXHi0I4lyWQ04AITcfY9r6MBEjNJKKXBhaCYWN31WHbXcNde8MjoFZUFSbTvtbSTG4QetDKwpArtzUAMqXe1vLYQV+cp2Q1SFSEn8PGDQ3EmHjBf4oHLJkuaZQyCbF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elgldQOT9k5hgNr08UjwXnrcpccm9RcoAds8rLhGabQ=;
 b=PHx0S79LFdHJvNVG2ANbTFVL8gxQiVviEIARLJhiCpIykACDsjXGWzxTScsDcXWkGj7XK0BC6NoMrBojMrWmYPunpFbTOWqXZySPApWYJr4lJWVaDVIlYl8iisRQGe7iykCS/2f9lGHdhGyHnQpI5DWDDQz9Ppknk0p7USkaEg5BNs8qbZNqxTg8slEWYtc+A7hGk8NOd5LD0XWtLvyrF/Zc6fElW1LYuUFiwIa5GSeT1ZKL5fwPnTpOMW0e2qZLAfNlMfmDkhKinJBKD4/61zJKbZvRPsu4VNIPALzbSG8FEJxXOM+IMS7+kYU1mdMhPJpIp+wdCRassRDtxYI5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12)
 by SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 16:39:41 +0000
Received: from PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4]) by PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4%6]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 16:39:41 +0000
From: "Van Haaren, Harry" <harry.van.haaren@intel.com>
To: Owen Hilyard <Owen.Hilyard@unh.edu>, "Etelson, Gregory"
 <getelson@nvidia.com>, "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Topic: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Index: AQHbr6r3ow4K3xJ6vUu8VgAr7QGxzrOoNgYAgAEJ8vWAAwUpAIAGmn3LgAULbgCABLEMgIAA3kCAgAHmrICAAAsp6YAB0fOAgASR+2M=
Date: Tue, 6 May 2025 16:39:41 +0000
Message-ID: <PH8PR11MB6803AD18258A79734D9ABD79D789A@PH8PR11MB6803.namprd11.prod.outlook.com>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
 <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
 <PH8PR11MB6803458E6348B4D167C47C91D7BF2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <IA1PR12MB63308A2F69036E3ACCC605D0A5B92@IA1PR12MB6330.namprd12.prod.outlook.com>
 <PH8PR11MB680363E200616CBB39DDDCB6D7852@PH8PR11MB6803.namprd11.prod.outlook.com>
 <c5387a8c-b560-3fde-3453-c2478d8e6969@nvidia.com>
 <IA1PR12MB6330872DB96BB9D83EF7EFF2A5832@IA1PR12MB6330.namprd12.prod.outlook.com>
 <aBMmUZ2RDSXQOHXg@bricha3-mobl1.ger.corp.intel.com>
 <a1161f7d-1a55-6200-7440-d615d5a41a6c@nvidia.com>
 <PH8PR11MB6803B2CD0BF276C6164C3D97D78D2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <DM8P223MB038323681A4BEA771CF92A6D8D8D2@DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM>
In-Reply-To: <DM8P223MB038323681A4BEA771CF92A6D8D8D2@DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6803:EE_|SJ1PR11MB6297:EE_
x-ms-office365-filtering-correlation-id: a51488c0-3b83-4f5a-52e1-08dd8cbc995d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?q3Dc/WA8knjA1zK7rJErjN9lHKuEiB4/1gqoLwbYoQZEdSRbLrQX53BrcE?=
 =?iso-8859-1?Q?Bpdsmg9o85e+fyCnfqrkfVMd02HKsPNYpj5HiwOa2taVuW7ZzyJ7RcEUOW?=
 =?iso-8859-1?Q?b9CifM48URXU1I6UC56chAbzPYrkXytQwnQZVXpEkKn+DXFO5THxPpfoic?=
 =?iso-8859-1?Q?PVocsX2zydj5QuPjGkNcNNZBZgHzWrOA70omFSYIucsnnA87xw7NFHeY1X?=
 =?iso-8859-1?Q?VloSdlRsAmKQAvxFtV/Smzs5SZgnv0gmhBzbb+93uy9IzwsV9070krP8VN?=
 =?iso-8859-1?Q?x4cQJYF79q+ofBpY1tHbRN1upd7G06gXXu+I/05saNITjWWJod0rH9u4Xb?=
 =?iso-8859-1?Q?CWROZCCrttxhHSsU+Qe7ujmA44KptM8kWWh69mz8aTlo7jTaV4Mp9X756O?=
 =?iso-8859-1?Q?mn8NuhAKbYhRpfUAkQUOrAcNMVOCUKQ6tzKg9fjCAjjoGsV7ctsgERDWda?=
 =?iso-8859-1?Q?3RNzhprs6eqzpUY4TLwcpaEGb+tRUFzoWo99xQByN31wq4bnXlDx6sK76w?=
 =?iso-8859-1?Q?cLbgXp3XJtb+Y35ClpseAebALdSwmASsW1B12aX/gU+raypKChqXI7XWDJ?=
 =?iso-8859-1?Q?4kn8Po0GmgalSCO+5N7mEQYmfEHQLVsi8BY0l7g0kDntD1PEuv3+J6i3vF?=
 =?iso-8859-1?Q?i3VTS+u4MdFo+X7NNRiCeG1HN5QaURhKfaq5TXvg91suHDp6rRZ9MfaTHN?=
 =?iso-8859-1?Q?kDZTeXTmsxpsVDF6VfcJ3nzHGftH8ei6Z0HQVcT3odT6FssXhZX2MKm8d+?=
 =?iso-8859-1?Q?K4kYxh4wT0uey2fGTGyxJWt3Z1gyEpaHPZyoIJMUJWdOsNjrL0YwmYDUzC?=
 =?iso-8859-1?Q?fPOfI0nGJecCa1zKrrXuJRWuHLDvQVH1v4cC+QIafA7A3AvMQPeqMboKgo?=
 =?iso-8859-1?Q?PZyeKXhT/MUlcxmMw/o56ykfLVoWfNMMXvUj/57rrknS2MpH8D7wW4bYnZ?=
 =?iso-8859-1?Q?KA+wEQ8k3EqQ+kij7SyPA6P6VkdfL6u1Kw6hIkIvCz4ihK+UqhGZqyfNjC?=
 =?iso-8859-1?Q?IJiUSLtxt/7mXRSBG2BO1j7UFlWWT48fw54W19iF70MAh5TNc16jj+YXJV?=
 =?iso-8859-1?Q?3PaaEinslyyTpY6RdGztmMKAHboEnolw/nifCkBwOPO5KZYhmEf2UGPyMR?=
 =?iso-8859-1?Q?xGyV+0oYNuqDx6KLLNd2Wix0t5cud09ZTKW+dXIYrFFmJWpvIKgjuVEDjV?=
 =?iso-8859-1?Q?ioZ0GsRY1MZNBxcEMQcMS/9bSA6btwU3G1II+s83yLcyIompruWJ8zjin0?=
 =?iso-8859-1?Q?JqtXJHpbw7ioiBrR2AzfmEsSvpjr9V6SpXDw9JLJdC9VFUQ45oeDCZl3Qj?=
 =?iso-8859-1?Q?MYMAX1Kzj3ktoOFXHKW2DCte5d7vl8zTFDEQmH8XY754KuRnn0oAW3pVbu?=
 =?iso-8859-1?Q?q+41Ue9RLwVeTTsciYCGU1uCx+tJqpS5t1rMnnTbJRSogXZXLWCGA4XMqo?=
 =?iso-8859-1?Q?0H88hi1Chog9qXsx8rd8MZpRuq/SfiCo9BvsXhc2t43bkpn4Aigg4JCCUj?=
 =?iso-8859-1?Q?tMJozoB3jkvDYnlypdPor2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6803.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0FeemSWgq01n/xL+b8gg9mRH2b8Yz2JJRCYE6w9gva7yaVhQWjkRhZD9//?=
 =?iso-8859-1?Q?uKJLCSCDpS/H5rpvLkmgLso8Qfvd44Js4kyaim8lSKJf5/ifWpeS2F0cDI?=
 =?iso-8859-1?Q?t8j/rvZxA6WZINpxziqwULyw/05NswoDLo4/LecC+tJUSUuF/O7A2Jkk8e?=
 =?iso-8859-1?Q?RHCYQhwH1eyi1Q3ZiLC59ERyVpjR0K0YjwulKNQIi40v8gAuuMTcwaj8VF?=
 =?iso-8859-1?Q?fnhEL5Pnl4YUFJh5mTEyjjwz2aZnM5x2OxmjbjQ3Eldqb8XNuPakzzKR09?=
 =?iso-8859-1?Q?0HVAALdGbNTUZfJOr71gP/2mKg7JXTDMeCuLtiejNH6slDUuZ1TLbjfIg9?=
 =?iso-8859-1?Q?ksMHsdKLqPxGGGdcbXodRUv3htkX/gG7uMiaVNX06fa2S/ITtOl+iFt3xr?=
 =?iso-8859-1?Q?HjKc0qpFddfxmvaoGVgpaPlq0pA9AE7Voys9tgP4pWIGV1ngIK43IK/w/Z?=
 =?iso-8859-1?Q?tL1XsfMGoyvjczH+yPnNKWJrUPc6LWg3dsxCTf3fDl6MAbmebAEbrPBCR7?=
 =?iso-8859-1?Q?GzY1sM+56BA44Jp8QZOBu8/nUxHIlFC4lEn94KouDrWE8jtIWw2AMqBEZb?=
 =?iso-8859-1?Q?Psg18kZqOfVjcDo/O2I5dEmAmCu3n7fIgVcnM5n3lhamnP1T6s50bCEPLo?=
 =?iso-8859-1?Q?E+ZyR8WT3IjJi+KPeNbZtdpCXWO/3+MK5PLsJFZagO+zrYqCAjJQ9IBaQf?=
 =?iso-8859-1?Q?rheRp+WPDW6vwsW6P/h0rmizjm2B+UWB+eEEdVqgPKhE39h7OA8GWgpv4d?=
 =?iso-8859-1?Q?lwRc+g8ZdrjO80xNcGQ+QypjQ0RLGUSBSYk+GxvZUko09NEnsBdwb6Zq00?=
 =?iso-8859-1?Q?r3MeFrLcCdscd81wwQLrIKBssmKwTkcwf0mkEcr9R6EPnmIzruAfJT6Ewe?=
 =?iso-8859-1?Q?ooW0xscSRa8vaiulJyE6l2/iXMMi+IpH1/a+7mOrR8iN8z8M4OuX3FQYT3?=
 =?iso-8859-1?Q?63AJ9waYU3wC6vyVkV+jLkmxhgt3XlmeSG0y9Cp6kHwvkNWNa1I/AV9KQI?=
 =?iso-8859-1?Q?tgqzLMYRuRaNUS8ALtLOzFiSK7MxUtc2thtfwcdVeooM9opF2KXXnaw9Xt?=
 =?iso-8859-1?Q?NHFi48j5buFoTYttampQCxbbl9roSt4ZAyrSDu6siXn1XdsLNNqrV6TVcA?=
 =?iso-8859-1?Q?oFcVtRIjoq2v9FGpyOIvBHn0C+xF9bcw6KWT63bJa4QYfZktu1iL/W06iT?=
 =?iso-8859-1?Q?8rKBXjJoOMAh0ZstLQB3hRrE0lzs45T0o4t3vkBcTTmImGBAjoFom6F6wW?=
 =?iso-8859-1?Q?fo+JO7SYd1pL2iZvtCT7vrzBgtbLE70f0fPP/zG04m8BRCWlkLihl98zFW?=
 =?iso-8859-1?Q?UnSp7HQQgkUJ3uYWLMGaA0Eyuik2TR4RD4e19FDVholy43tCT6QJLacwua?=
 =?iso-8859-1?Q?ZcNBvs1TOxwhUhqGSSABQqDqcTwHHpmf53fv1QdMeGsMA1p1gPykAgd1e8?=
 =?iso-8859-1?Q?+elSTDNsOCMpki0IbISVgja+0gYm+fZCwMITMCIHwjMqIVrB9Z1KYs3QD/?=
 =?iso-8859-1?Q?bAy+kfT9DDlN+9PEuF5wxi2L0NxNolamcEE8pBnIETRo8olLDPAB6Tetcl?=
 =?iso-8859-1?Q?vnSqm3JK8GTU1pnvNbL0UivhEQYDiQKLNVdjdEx8fF8fqaXbxUyEteWeGG?=
 =?iso-8859-1?Q?AUH2HoFT9nrQ2IcqDaCR3/VSAid2kS9FG6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6803.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51488c0-3b83-4f5a-52e1-08dd8cbc995d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 16:39:41.1203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IY/SOtmGxCqZ2PNVQK8pksuPWsCXAnSUatohsUa/JA0jmaQqFFeJxRh5RihLO5KcuSTNvUBteDzDL6Na0qIAyVidSGs7Ffrtv9kCdbrZnbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6297
X-OriginatorOrg: intel.com
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

> From: Owen Hilyard=0A=
> Sent: Saturday, May 03, 2025 6:13 PM=0A=
> To: Van Haaren, Harry; Etelson, Gregory; Richardson, Bruce=0A=
> Cc: dev@dpdk.org=0A=
> Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq=
=0A=
>=0A=
> From: Van Haaren, Harry <harry.van.haaren@intel.com>=0A=
> Sent: Friday, May 2, 2025 9:58 AM=0A=
> To: Etelson, Gregory <getelson@nvidia.com>; Richardson, Bruce <bruce.rich=
ardson@intel.com>=0A=
> Cc: dev@dpdk.org <dev@dpdk.org>; Owen Hilyard <owen.hilyard@unh.edu>=0A=
> Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq=
=0A=
> =A0=0A=
> > From: Etelson, Gregory=0A=
> > Sent: Friday, May 02, 2025 1:46 PM=0A=
> > To: Richardson, Bruce=0A=
> > Cc: Gregory Etelson; Van Haaren, Harry; dev@dpdk.org; owen.hilyard@unh.=
edu=0A=
> > Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and R=
xq=0A=
> >=0A=
> > Hello Bruce,=0A=
>=0A=
> Hi All,=0A=
> Hi All,=0A=
=0A=
Hi All!=0A=
=0A=
Great to see passionate & detailed replies & input!=0A=
=0A=
Please folks - lets try remember to send plain-text emails, and use =A0> =
=A0to indent each reply.=0A=
Its hard to identify what I wrote (1) compared to Owen's replies (2) in the=
 archives otherwise.=0A=
(Adding some "Harry wrote" and "Owen wrote" annotations to try help future =
readability.)=0A=
=0A=
1) https://inbox.dpdk.org/dev/PH8PR11MB6803B2CD0BF276C6164C3D97D78D2@PH8PR1=
1MB6803.namprd11.prod.outlook.com/=0A=
2) https://inbox.dpdk.org/dev/DM8P223MB038323681A4BEA771CF92A6D8D8D2@DM8P22=
3MB0383.NAMP223.PROD.OUTLOOK.COM/=0A=
=0A=
=0A=
Maybe it will help to split the conversation into two threads, with one foc=
ussing on=0A=
"DPDK used through Safe Rust abstractions", and the other on "future cool u=
se-cases".=0A=
=0A=
Perhaps I jumped a bit too far ahead mentioning async runtimes, and while I=
 like the enthusiasm for=0A=
designing "cool new stuff", it is probably better to be realistic around wh=
at will get "done": my bad.=0A=
=0A=
I'll reply to the "DPDK via Safe Rust" topics below, and start a new thread=
 (with same folks on CC)=0A=
for "future cool use-cases" when I've had a chance to clean up a little dem=
o to showcase them.=0A=
=0A=
=0A=
> > > Thanks for sharing. However, IMHO using EAL for thread management in =
rust=0A=
> > > is the wrong interface to expose.=0A=
> >=0A=
> > EAL is a singleton object in DPDK architecture.=0A=
> > I see it as a hub for other resources.=0A=
=0A=
Harry Wrote:=0A=
> Yep, i tend to agree here; EAL is central to the rest of DPDK working cor=
rectly.=0A=
> And given EALs implementation is heavily relying on global static variabl=
es, it is=0A=
> certainly a "singleton" instance, yes.=0A=
=0A=
Owen wrote:=0A=
> I think a singleton one way to implement this, but then you lose some of =
the RAII/automatic resource management behavior. It would, however, make so=
me APIs inherently unsafe or very unergonomic unless we were to force rte_e=
al_cleanup to be run via atexit(3) or the platform equivalent and forbid th=
e user from running it themselves. For a lot of Rust runtimes similar to th=
e EAL (tokio, glommio, etc), once you spawn a runtime it's around until pro=
cess exit. The other option is to have a handle which represents the state =
of the EAL on the Rust side and runs rte_eal_init on creation and rte_eal_c=
leanup on destruction. There are two ways we can make that safe. First, ref=
erence counting, once the handles are created, they can be passed around ea=
sily, and the last one runs rte_eal_cleanup when it gets dropped. =A0This a=
voids having tons of complicated lifetimes and I think that, everywhere tha=
t it shouldn't affect fast path performance, we should use refcounting.=0A=
=0A=
Agreed, refcounts for EAL "singleton" concept yes. For the record, the init=
ial patch actually returns a=0A=
"dpdk" object from dpdk::Eal::init(), and Drop impl has a // TODO rte_eal_c=
leanup(), so well aligned on approach here.=0A=
https://patches.dpdk.org/project/dpdk/patch/20250418132324.4085336-1-harry.=
van.haaren@intel.com/=0A=
=0A=
Owen wrote:=0A=
> The other option is to use lifetimes. This is doable, but is going to for=
ce people who are more likely to primarily be C or C++ developers to dive d=
eep into Rust's type system if they want to build abstractions over it. If =
we add async into the mix, as many people are going to want to do, it's goi=
ng to become much, much harder. As a result, I'd advocate for only using it=
 for data path components where refcounting isn't an option.=0A=
=0A=
+1 to not using lifetimes here, it is not the right solution for this EAL /=
 singleton type problem.=0A=
=0A=
=0A=
Gregory wrote:=0A=
> > Following that idea, the EAL structure can be divided to hold the=0A=
> > "original" resources inherited from librte_eal and new resources=0A=
> > introduced in Rust EAL.=0A=
=0A=
Harry wrote:=0A=
> Here we can look from different perspectives. Should "Rust EAL" even exis=
t?=0A=
> If so, why? The DPDK C APIs were designed in baremetal/linux days, where=
=0A=
> certain "best-practices" didn't exist yet, and Rust language was pre 1.0 =
release.=0A=
>=0A=
> Of course, certain parts of Rust API must depend on EAL being initialized=
.=0A=
> There is a logical flow to DPDK initialization, these must be kept for co=
rrect functionality.=0A=
>=0A=
> I guess I'm saying, perhaps we can do better than mirroring the concept o=
f=0A=
> "DPDK EAL in C" in to "DPDK EAL in Rust".=0A=
=0A=
Owen wrote:=0A=
> I think that there will need to be some kind of runtime exposed by the li=
brary. A lot of the existing EAL abstractions may need to be reworked, espe=
cially those dealing with memory, but I think a lot of things can be layere=
d on top of the C API. However, I think many of the invariants in the EAL c=
ould be enforced at compile time for free, which may mean the creation of a=
 lot of "unchecked" function variants which skip over null checks and other=
 validation.=0A=
=0A=
Agree that most (if not all?) things can be layered on top of the C API. Le=
ts leave the "unchecked" function variants discussion until we have code to=
 discuss, its hard to know right now because we don't have an implementatio=
n to talk about.=0A=
=0A=
Owen wrote:=0A=
> As was mentioned before, it may also make sense for some abstractions in =
the C EAL to be lifted to compile time. I've spent a lot of time thinking a=
bout how to use something like Rust's traits for "it just works" capabiliti=
es where you can declare what features you want (ex: scatter/gather) and it=
 will either be done in hardware or fall back to software, since you were g=
oing to need to do it anyway. This might lead to parameterizing a lot of us=
er code on the devices they expect to interact with and then having some "d=
yn EthDev" as a fallback, which should be roughly equivalent to what we hav=
e now. I can explain that in more detail if there's interest.=0A=
=0A=
This goes into the "cool new stuff" category in my head: I agree these conc=
epts are possible,=0A=
but i feel we must prioritize the "DPDK via Safe Rust" and achieve that fir=
st. We cannot put the=0A=
cherry on the cake, if the cake is still under construction :)=0A=
=0A=
(Techie note, the description is for a "polyfill" of specific functionality=
. This is often done via=0A=
stacking or layering operations that all provide the same trait in Rust. Th=
is is very nice, as one=0A=
can provide a specific implementation of a functionality, and compose it wi=
th other functionalities.=0A=
For examples look at how the "tower" crate: "a library of modular and reusa=
ble components for building robust networking clients and servers"=0A=
=0A=
To be very clear - cool techie stuff, but we need to get the basics in plac=
e first, before looking at dyn Ethdev type concepts.=0A=
=0A=
=0A=
Harry/Gregory/Bruce wrote (in order of indentation):=0A=
> > > Instead, I believe we should be=0A=
> > > encouraging native rust thread management, and not exposing any DPDK=
=0A=
> > > threading APIs except those necessary to have rust threads work with =
DPDK,=0A=
> > > i.e. with an lcore ID. Many years ago when DPDK started, and in the C=
=0A=
> > > world, having DPDK as a runtime environment made sense, but times hav=
e=0A=
> > > changed and for Rust, there is a whole ecosystem out there already th=
at we=0A=
> > > need to "play nice with", so having Rust (not DPDK) do all thread=0A=
> > > management is the way to go (again IMHO).=0A=
> > >=0A=
> >=0A=
> > I'm not sure what exposed DPDK API you refer to.=0A=
>=0A=
> I think that's the point :) Perhaps the Rust application should decide ho=
w/when to=0A=
> create threads, and how to schedule & pin them. Not the "DPDK crate for R=
ust".=0A=
> To give a more concrete examples, lets look at Tokio (or Monoio, or Glomm=
io, or .. )=0A=
> which are prominent players in the Rust ecosystem, particularly for netwo=
rking workloads=0A=
> where request/response patterns are well served by the "async" programmin=
g model (e.g HTTP server).=0A=
=0A=
Owen wrote:=0A=
> Rust doesn't really care about threads that much. Yes, it has std::thread=
 as a pthread equivalent, but on Linux those literally call pthread. Enforc=
ing the correctness of the Send and Sync traits (responsible for helping en=
force thread safety) in APIs is left to library authors. I've used Rust wit=
h EAL threads and it's fine, although a slightly nicer API for launching ba=
sed on a closure (which is a function pointer and a struct with the capture=
d inputs) would be nice. In Rust, I'd say that async and threads are orthog=
onal concepts, except where runtimes force them to mix. Async is a way to w=
rite a state machine or (with some more abstraction) an execution graph, an=
d Rust the language doesn't care whether a library decides to run some depe=
ndencies in parallel. What I think Rust is more likely to want is thread pe=
r core and then running either a single async runtime over all of them or a=
n async runtime per core.=0A=
=0A=
The key point above is "except where runtimes force them to mix". The DPDK =
rxq concept (struct Rxq in the code linked above) is !Send.=0A=
As a result, it cannot be moved between threads. That allows per-lcore conc=
epts to be used for performance.=0A=
=0A=
The point I was trying to make is that we (the DPDK safe rust wrapper API) =
should not be prescriptive in how it is used.=0A=
In other words: we should allow the user to decide how to spawn/manage/run =
threads.=0A=
=0A=
We must encode the DPDK requirements of e.g. "Rxq concept" with !Send, !Syn=
c marker traits.=0A=
Then the Rust compiler will at compile-time ensure the users code is correc=
t.=0A=
=0A=
I don't believe that I can identify all use-cases, so we cannot design requ=
irements around statements like "I think X is more likely than Y".=0A=
=0A=
=0A=
Harry wrote:=0A=
> Lets focus on Tokio first: it is an "async runtime" (two links for future=
 readers)=0A=
> =A0 =A0 <snip>=0A=
> So an async runtime can run "async" Rust functions (called Futures, or Ta=
sks when run independently..)=0A=
> There are lots of words/concepts, but I'll focus only on the thread creat=
ion/control aspect, given the DPDK EAL lcore context.=0A=
>=0A=
> Tokio is a work-stealing scheduler. It spawns "worker" threads, and then =
gives these "tasks"=0A=
> to various worker cores (similar to how Golang does its work-stealing sch=
eduling). Some=0A=
> DPDK crate users might like this type of workflow, where e.g. RXQ polling=
 is a task, and the=0A=
> "tokio runtime" figures out which worker to run it on. "Spawning" a task =
causes the "Future"=0A=
> to start executing. (technical Rust note: notice the "Send" bound on Futu=
re: https://docs.rs/tokio/latest/tokio/task/fn.spawn.html )=0A=
> The work stealing aspect of Tokio has also led to some issues in the Rust=
 ecosystem. What it effectively means is that every "await" is a place wher=
e you might get moved to another thread. This means that it would be unsoun=
d to, for example, have a queue handle on devices without MT-safe queues un=
less we want to put a mutex on top of all of the device queues. I personall=
y think this is a lot of the source of people thinking that Rust async is h=
ard, because Tokio forces you to be thread safe at really weird places in y=
our code and has issues like not being able to hold a mutex over an await p=
oint.=0A=
>=0A=
> Other users might prefer the "thread-per-core" and CPU pinning approach (=
like DPDK itself would do).=0A=
> nit: Tokio also spawns a thread per core, it just freely moves tasks betw=
een cores. It doesn't pin because it's designed to interoperate with the no=
rmal kernel scheduler more nicely. I think that not needing pinned cores is=
 nice, but we want the ability to pin for performance reasons, especially o=
n NUMA/NUCA systems (NUCA =3D Non-Uniform Cache Architecture, almost every =
AMD EPYC above 8 cores, higher core count Intel Xeons for 3 generations, et=
c).=0A=
> Monoio and Glommio both serve these use cases (but in slightly different =
ways!). They both spawn threads and do CPU pinning.=0A=
> Monoio and Glommio say "tasks will always remain on the local thread". In=
 Rust techie terms: "Futures are !Send and !Sync"=0A=
> =A0 =A0 https://docs.rs/monoio/latest/monoio/fn.spawn.html=0A=
> =A0 =A0 https://docs.rs/glommio/latest/glommio/fn.spawn_local.html=0A=
=0A=
Owen wrote:=0A=
> There is also another option, one which would eliminate "service cores". =
We provide both a work stealing pool of tasks that have to deal with being =
yanked between cores/EAL threads at any time, but aren't data plane tasks, =
and then a different API for spawning tasks onto the local thread/core for =
data plane tasks (ex: something to manage a particular HTTP connection). Th=
is might make writing the runtime harder, but it should provide the best of=
 both worlds provided we can build in a feature (Rust provides a way to "if=
def out" code via features) to disable one or the other if someone doesn't =
want the overhead.=0A=
=0A=
Hah, yeah.. (as maintainer of service cores!) I'm aware that the "async Rus=
t" cooperative scheduling is very similar.=0A=
That said, the problem service-cores set out to solve is a very different o=
ne to how "async Rust" came about.=0A=
The implementations, ergonomics, and the language its written in are differ=
ent too... so they're different beasts!=0A=
=0A=
We don't want to start writing "dpdk-async-runtime". The goal is not to dup=
licate everything, we must integrate with existing.=0A=
I will try provide some examples of integrating DPDK with other Rust networ=
king projects, to prove that it can be done, and is useful.=0A=
=0A=
=0A=
Harry wrote:=0A=
> So there are at least 3 different async runtimes (and I haven't even talk=
ed about async-std, smol, embassy, ...) which=0A=
> all have different use-cases, and methods of running "tasks" on threads. =
These runtimes exist, and are widely used,=0A=
> and applications make use of their thread-scheduling capabilities.=0A=
>=0A=
> So "async runtimes" do thread creation (and optionally CPU pinning) for t=
he user.=0A=
> Other libraries like "Rayon" are thread-pool managers, those also have va=
rious CPU thread-create/pinning capabilities.=0A=
> If DPDK *also* wants to do thread creation/management and CPU-thread-to-c=
ore pinning for the user, that creates tension.=0A=
> The other problem is that most of these async runtimes have IO very tight=
ly integrated into them. A large portion of Tokio had to be forked and rewr=
itten for io_uring support, and DPDK is a rather stark departure from what =
they were all designed for. I know that both Tokio and Glommio have "start =
a new async runtime on this thread" functions, and I think that Tokio has a=
n "add this thread to a multithreaded runtime" somewhere.=0A=
>=0A=
> I think the main thing that DPDK would need to be concerned about is that=
 many of these runtimes use thread locals, and I'm not sure if that would b=
e transparently handled by the EAL thread runtime since I've always used th=
read per core and then used the Rust runtime to multiplex between tasks ins=
tead of spawning more EAL threads.=0A=
>=0A=
> Rayon should probably be thought of in a similar vein to OpenMP, since it=
's mainly designed for batch processing. Unless someone is doing some fairl=
y heavy computation (the kind where "do we want a GPU to accelerate this?" =
becomes a question) inside of their DPDK application, I'm having trouble th=
inking of a use case that would want both DPDK and Rayon.=0A=
>=0A=
> > Bruce wrote: "so having Rust (not DPDK) do all thread management is the=
 way to go (again IMHO)."=0A=
>=0A=
> I think I agree here, in order to make the Rust DPDK crate usable from th=
e Rust ecosystem,=0A=
> it must align itself with the existing Rust networking ecosystem.=0A=
>=0A=
> That means, the DPDK Rust crate should not FORCE the usage of lcore pinni=
ngs and mappings.=0A=
> Allowing a Rust application to decide how to best handle threading (via R=
ayon, Tokio, Monoio, etc)=0A=
> will allow much more "native" or "ergonomic" integration of DPDK into Rus=
t applications.=0A=
=0A=
Owen wrote:=0A=
> I'm not sure that using DPDK from Rust will be possible without either se=
rious performance sacrifices or rewrites of a lot of the networking librari=
es. Tokio continues to mimic the BSD sockets API for IO, even with the io_u=
ring version, as does glommio. The idea of the "recv" giving you a buffer w=
ithout you passing one in isn't really used outside of some lower-level io_=
uring crates. At a bare minimum, even if DPDK managed to offer an API that =
works exactly the same ways as io_uring or epoll, we would still need to go=
 to all of the async runtimes and get them to plumb DPDK support in or appr=
ove someone from the DPDK community maintaining support. If we don't offer =
that API, then we either need rewrites inside of the async runtimes or for =
individual libraries to provide DPDK support, which is going to be even mor=
e difficult.=0A=
=0A=
Regarding traits used for IO, correct many are focussed on "recv" giving yo=
u a buffer, but not all. Look at Monoio, specifically the *Rent APIs:=0A=
https://docs.rs/monoio/latest/monoio/io/index.html#traits=0A=
=0A=
=0A=
Owen wrote:=0A=
> I agree that forcing lcore pinnings and mappings isn't good, but I think =
that DPDK is well within its rights to build its own async runtime which ex=
poses a standard API. For one thing, the first thing Rust users will ask fo=
r is a TCP stack, which the community has been discussing and debating for =
a long time. I think we should figure out whether the goal is to allow DPDK=
 applications to be written in Rust, or to allow generic Rust applications =
to use DPDK. The former means that the audience would likely be Rust-fluent=
 people who would have used DPDK regardless, and are fine dealing with memp=
ools, mbufs, the eal, and ethdev configuration. The latter is a much larger=
 audience who is likely going to be less tolerant of dpdk-rs exposing the t=
rue complexity of using DPDK. Yes, Rust can help make the abstractions bett=
er, but there's an amount of inherent complexity in "Your NIC can handle IP=
Sec for you and can also direct all IPv6 traffic to one core" that I don't =
think we can remove.=0A=
=0A=
Ok, we're getting very far into future/conceptual design here.=0A=
For me, DPDK having its own async runtime and its own DPDK TCP stack is NOT=
 the goal.=0A=
We should try to integrate DPDK with existing software environments - not r=
ewrite the world.=0A=
=0A=
=0A=
=0A=
Owen wrote:=0A=
> I personally think that making an API for DPDK applications to be written=
 in Rust, and then steadily adding abstractions on top of that until we arr=
ive at something that someone who has never looked at a TCP header can use =
without too much confusion. That was part of the goal of the Iris project I=
 pitched (and then had to go finish another project so the design is still =
WIP). I think that a move to DPDK is going to be as radical of a change as =
a move to io_uring, however, DPDK is fast enough that I think it may be pos=
sible to convince people to do a rewrite once we arrive at that high level =
API.=0A=
=0A=
I haven't heard of the Iris project you mentioned, is there something concr=
ete to learn from, or is it too WIP to apply?=0A=
=0A=
=0A=
Owen wrote:=0A=
> "Swap out your sockets and rework the functions that do network IO for a =
5x performance increase" is a very, very attractive offer, but for us to ge=
t there I think we need to have DPDK's full potential available in Rust, an=
d then build as many zero-overhead (zero cost or you couldn't write it bett=
er yourself) abstractions as we can on top. I want to avoid a situation whe=
re we build up to the high-level APIs as fast as we can and then end up in =
a situation where you have "Easy Mode" and then "C DPDK written in Rust" as=
 your two options.=0A=
=0A=
My perspective is that we're carefully designing "Safe Rust" APIs, and will=
 have "DPDKs full potential" as a result.=0A=
I'm not sure where the "easy mode" comment applies. But lets focus on code =
- and making concrete progress - over theoretical discussions.=0A=
=0A=
I'll keep my input more consise in future, and try get more patches on list=
 for review.=0A=
=0A=
=0A=
> > Regards,=0A=
> > Gregory=0A=
>=0A=
> Apologies for the long-form, "wall of text" email, but I hope it captures=
 the nuance of threading and=0A=
> async runtimes, which I believe in the long term will be very nice to cap=
ture "async offload" use-cases=0A=
> for DPDK. To put it another way, lookaside processing can be hidden behin=
d async functions & runtimes,=0A=
> if we design the APIs right: and that would be really cool for making asy=
nc-offload code easy to write correctly!=0A=
>=0A=
> Regards, -Harry=0A=
>=0A=
> Sorry for my own walls of text. As a consequence of working on Iris I've =
spent a lot of time thinking about how to make DPDK easier to use while kee=
ping the performance intact, and I was already thinking in Rust since it pr=
ovides one of the better options for these kinds of abstractions (the other=
 option I see is Mojo, which isn't ready yet). I want to see DPDK become mo=
re accessible, but the performance and access to hardware is one of the mai=
n things that make DPDK special, so I don't want to compromise that. I defi=
nitely agree that we need to force DPDK's existing APIs to justify themselv=
es in the face of the new capabilities of Rust, but I think that starting f=
rom "How are Rust applications written today?" is a mistake.=0A=
>=0A=
> Regards,=0A=
> Owen=0A=
=0A=
Generally agree, but just this line stood out to me:=0A=
=A0> Owen wrote:   I think that starting from "How are Rust applications wr=
itten today?" is a mistake.=0A=
=0A=
We have to understand how applications are written today, in order to under=
stand what it would take to move them to a DPDK backend.=0A=
In C, consuming DPDK is hard, as applications expect TCP via sockets, and D=
PDK provides mbuf*s: that's a large mismatch. (Yes I'm aware of various DPD=
K-aware TCP stacks etc.)=0A=
=0A=
In Rust, applications expect a "let tcp_port =3D TcpListener::bind()", and =
then to "tcp_port.accept()" incoming requests.=0A=
Those requirements can be met by: std::net::TcpListener, tokio::net::TcpLis=
tener, and in future, some DPDK (SmolTCP?) based TcpListener.=0A=
- https://doc.rust-lang.org/std/net/struct.TcpListener.html=0A=
- https://docs.rs/tokio/latest/tokio/net/struct.TcpListener.html=0A=
=0A=
The ability to move between abstractions is much easier in Rust. As a resul=
t, providing "normal looking APIs" is IMO the best way forward.=0A=
=0A=
Regards, and thanks for the input & discussion. -Harry=
