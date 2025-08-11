Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49749C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:19:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94B494067B;
	Mon, 11 Aug 2025 12:19:44 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
 by mails.dpdk.org (Postfix) with ESMTP id 14CB8400D5;
 Mon, 11 Aug 2025 12:19:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eStsVfJ29wxZlK3Gka2XO22lp3tZ+7xJ1H15UtKF2DvT4UwcISBdb+5eR+38S1q08dUv5rAeHEIODp/07b+MS+zeeUuQ1PvPnzOyEm7wUuBPnJ9J1/LULpIKpIfg8nl5hQzCKPLujhfQYJyrDdFfQBM1JR9axIqaMKBOfX01GnfO+aKJpfho0Xm4etaNXB07QrhQ/U9RhGHQmoddS9X0sDALt68pISpGj59c8rKpM9mv11pb9XiGLPypiZhCtnScQy/z2tm/P/T4Tp+ry59u+LCooehpKVUmTKM+ZDhxCQ3F9wSyImzNMtZSVMGXOoaApedO1awBJnL4UxqwiIEp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yTK5+0LCfzQrUK6sCxngmk61qpC7dRUzDNdH2xwJVU=;
 b=eTWd+ywDfa5w6MnRBaOFgTXwjivMs9nxUE8TuiIvoqArGwJLC1PN3ONyvL5evtnpi29rSuT8ZrR4jyoctvZior4NAiC5cStQGv0wKowoD7SG1JqIA4zO4JKMiCCnCYMas/tE6dENsTqINt34CZGPgIK2MLBNR+DfpDPXIP4pdAG+IjB/D5o8+kgwYtxqQ74Qg0oGaG2C8lnCZh3BP4CjoRY2XHu1YGxN2hkX7lzTNycbftww89xdTrBJlTysrTUE8XncI84KALqfa9udmw5O9YK3MZ7bfBpg2C9/twEEnjOiDh4z5n4IvN3RBBd00VP1dggVds6Ta64C3agMAUTSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yTK5+0LCfzQrUK6sCxngmk61qpC7dRUzDNdH2xwJVU=;
 b=WQHZiPsNEtbBOEtE/6XBRd4KZF/N836C2feNlSxJgThSq+yVtW3DI9bHbSmKwuxFZJK3ZuimPGgREo/DY2bHlQ87vQskNBP+PG+monfki8L+jMMhX+8JbTqqp6KInYcXLJY2SFc3eaFeMABN+KbSER+uUW0/wrNfVwMPiH//0VU=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 10:19:40 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%2]) with mapi id 15.20.9009.013; Mon, 11 Aug 2025
 10:19:40 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Khadem Ullah
 <14pwcse1224@uetpeshawar.edu.pk>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] [PATCH v4] lib/ethdev: fix segfault in secondary process
 by validating dev_private pointer
Thread-Topic: [PATCH] [PATCH v4] lib/ethdev: fix segfault in secondary process
 by validating dev_private pointer
Thread-Index: AQHb/WN0TIA+slWBmUK4+lP+hWGsxrRIFzMAgACFKoCAAQnyAIAAfnsAgA4OFcCAAMWJAIAEXvCA
Date: Mon, 11 Aug 2025 10:19:40 +0000
Message-ID: <PH7PR12MB8596785BCD76C0436A1F34898228A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250729143420.0fd7b627@hermes.local>
 <20250730050702.74381-1-14pwcse1224@uetpeshawar.edu.pk>
 <PH7PR12MB8596FA05DD99084208A31E50822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808083204.0174ac6b@hermes.local>
In-Reply-To: <20250808083204.0174ac6b@hermes.local>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-Mentions: 14pwcse1224@uetpeshawar.edu.pk
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-11T10:17:11.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|PH7PR12MB5688:EE_
x-ms-office365-filtering-correlation-id: c878b394-4cc0-4b0e-2bbe-08ddd8c09552
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BJ1RPtmsHzxwSxSBTiYFcvumkR6uGpz9Q3jlI6R7rkH++p70l9wuPAf8jNgM?=
 =?us-ascii?Q?Vd+OAl9ObziK0pKrtTsGr4/8F4BHCP+NjXHe/0sqlSVyXhO41BYXJCSey24x?=
 =?us-ascii?Q?IZKUlQQj1u6DuwuOCsQorC997mVW0gUwnm7DJpLl9w7xtASKXg9GL0NvJ/ZQ?=
 =?us-ascii?Q?/KYhB3gd2DH2cAfKlxC60n0xfTVADvB93OFtzUJepsXHcPkTB0D2quhWIsCv?=
 =?us-ascii?Q?jgr5yzfTmAxh7P5vpe6p9B5i388OuqpXpes76mF3ocWh1Gug8bH+VpLqIi80?=
 =?us-ascii?Q?x2Ks5J1G9ZKy7bN9FlCGI5s/oXPPqWMm5jLBxhfZuiTJMsJfWIB1czyCGAWL?=
 =?us-ascii?Q?OkyCU/oaDqNINmPdMlyxQB/7R0n/uXmKIs6nBIbjTprA0E2yqe5XYI0NfQFM?=
 =?us-ascii?Q?RecsnGAfXzu1gyQD0BIdn9hXgoLOep0BewWHFlBUwQKfG9od6QhNmpNV6l3e?=
 =?us-ascii?Q?3jg7fP9oMQRSMGIY8mju4sha0nLvP51g35ZM5Xm3TQIsYbvDJFX1gn+ymnLx?=
 =?us-ascii?Q?EIqepVFE7fdNGYWHbcTelAVvPJD/wl30i7EI60xp4qmemonHSJL+wnWVcGLc?=
 =?us-ascii?Q?nNf65OffMrWwYOdFwgyneVT14SsRoPF8I0HJFP9DxUBubPHK9xxGOhziwqee?=
 =?us-ascii?Q?fl5rI9tmVAxNzy8iy/4KDj/+nxQPySOysTJaMr/7mVlFUoADJg7d6iXLjA3E?=
 =?us-ascii?Q?iNuV69Q6gvLxSLE5PxJ/lNXrMgatAn2e7cE+A7FpyYUZW1i+UuicnjTKVmbP?=
 =?us-ascii?Q?Itun0KsU+A8VOM/XaDsfxqoUCmUXxdNQaQy+BhngYEtmmJOl45GfYgcjzfUh?=
 =?us-ascii?Q?VjxZVM3MNoI6/YANjs1uczmhNQCWhZ8ds2JgjF+NvWJP3Mr5o99IlKjZqJqJ?=
 =?us-ascii?Q?w8m5bKa94cIILkBjFL+zlXQJVaKTDEQqjR5+Yn4xCdq9AM3Zyv66mDN3LU0b?=
 =?us-ascii?Q?TzDGI2msTYQQeT5ZzDIi/28ixZ2gfI0YyuvF+YsdUlo+AqktVxbKO9uXDI4E?=
 =?us-ascii?Q?+bFr+GvmHOOs6648DcSyUepdxI+EfLAjySjD1fCaO0WWLITCHuYdRBWGDJva?=
 =?us-ascii?Q?n38UKxxzJnBjuqX7Q9rQX8n7MLouvOfy9THnHVhCrmhXJ7wysJKG2IHMgKrd?=
 =?us-ascii?Q?4QA/5/m8kNGobMedqKNHBYKO++F8Cwg+pg+sOmycy/tJ/PMG1v4WQL6XoC3A?=
 =?us-ascii?Q?9uu+/4uqgn8rzb5Hrkg04MAHDoOZ1e+SW0Et9dg58liaCQQ8b5KbDEsPQ1oO?=
 =?us-ascii?Q?NRLk9r9xrn5QkucJkGEPgeRydq9mPPbklOtKjyJHsewBgvPEKrNL8IEObsaZ?=
 =?us-ascii?Q?foeQnfRefOmbqVsZ2ZLRcXUu1RTEYNLvkbjECGt9fWdI3i6HrpXKKkHt/BFd?=
 =?us-ascii?Q?RrijLNKtyJF5S2trf3SPHhGOCXoK8iuslPa5u+MRzP7S/QW0mSAaRJheMyWL?=
 =?us-ascii?Q?ehlUVAOIntvrHcYfPCVK9BWrOj5V3qEaSpFqIqZLpF7OjaGV3l1X9JRgjR9b?=
 =?us-ascii?Q?va3APFNDoUHNUoY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZOk3Xd0VGj1THrg11VxRKdRhCqM/wlGEsNsl057fT/yuQ+8H3IXZieDGjlXL?=
 =?us-ascii?Q?rjMFK5tMYFPg3vjSaArzeKhvvySsan+Grr+zs8lGwvT5DS0fVSq27Zx0X+a3?=
 =?us-ascii?Q?1gTYRVj0lD4noiup87if2kYx3Cuao7OoHcKPuRd5GmOR1wAUUdsrpukRJZf9?=
 =?us-ascii?Q?LCYJeXgH3lgKbOsUdZZk9yGFLs+2U26JIno5Tjy0t6mtIeRzyTh+Fua+/UHS?=
 =?us-ascii?Q?hGm8ymyCJ8Ew54cgP4BKXQX4V4fEQDEcez1Hm1/49n86qBfNhsR07dJENDSo?=
 =?us-ascii?Q?rutGJ7k/wutq9H0nwbiR+4u2QZ/V9L/Dfh0G5v2VhO9rOmSszADFAeivRg6G?=
 =?us-ascii?Q?ENYHnbiMNnZcLhRn2gzfEVfn5HsfNhvGcp6Us+VU1P9V9WRFuoSbt+jQrl+j?=
 =?us-ascii?Q?QQHctOR6f5DkT39KyQNaQvx7e0zd2qyfHTBUzA1P6n6PIikqeF4o4dNQMyxY?=
 =?us-ascii?Q?N0a8bF0xLgKIHiN28lAtLpfNWF/LgbiCM5fXmm1Kfi8a+kGhBekjZ0xJl9qX?=
 =?us-ascii?Q?JkMi0+9xLRHGHVqHMJ1N3rIOyTEr70SMDp+mkUOALpHjZ2+nY5u4ESr1oGnv?=
 =?us-ascii?Q?kFD00iWithhltgKIOXHG5760rloGLcSlVIOArYOWisKgv4YGL9FZJk/ocuJ0?=
 =?us-ascii?Q?AXEWD/jZiFi89DFlPvhcbdZ0N9HGYxpXZQNAnwIFJ4sSZ2aJKW82VpmdpDKL?=
 =?us-ascii?Q?fJ4djLo9nYx8XMNx6jAcxjYJiNdnGT+eaSov3txccn0+j/roP0ehuMf7kfLY?=
 =?us-ascii?Q?KMns7vz4vARmgQuCwdjfmrVg+bqAPxnZ3GBHmrVR+jD9wednTz50nY3CqUq7?=
 =?us-ascii?Q?r5ZMbqHTX/O0ltsJVbl5QJB4GngNuBfy+IAeAfDb8xZNq4ZUhPp3rOxpIAuh?=
 =?us-ascii?Q?S62nmHVXERQxUfp0izDxROvBidVxfjpIPIrRITf2eYmVWNay8p/YI8jXVL4P?=
 =?us-ascii?Q?pOuvwYh2K1Nulhz35yEKtUJDovyTjxdvZoJPYk5F8uu4AWiqX9p2XDKQ0iil?=
 =?us-ascii?Q?UBKCIhS3p1N7W/08To0A9dqZ6gy/jVvCCBeKh1Iwu3HN5XPDe7tLXahqiHv+?=
 =?us-ascii?Q?ZR77FHIotkWjlA/A/f/sADC5mibPyTCSbM+ZwgDc1wt3kBz3qtT/ZwmYwQRQ?=
 =?us-ascii?Q?aa7c1kqW0uXSAOOmtznBa/OgBvdH0LgsUP9PF4zO734XUnBWBr7jDFoN8N3l?=
 =?us-ascii?Q?JZDWAvWoFmc40Ym/uJ18WE7sGbeliCiN/0qKFnz51b9gNHFz41ZvjtH13QoA?=
 =?us-ascii?Q?zVV2tyeU96uvqlAk4eFMneMLtMozVxfyvaWhm4WC5h945AgzmM0wSNx2D/Rj?=
 =?us-ascii?Q?7a3hCLAgt0BdKL/tTWWk9ZmBa6jZRE75s93GUFm2FEpNUdd3W5OOcii9wWrj?=
 =?us-ascii?Q?SnQGRQsEpJL9R2xPNXNXVoR9nXdwfpIkEKdNJICxmqQNLsl/2+TE/+hoM3RL?=
 =?us-ascii?Q?MCD39eu6Z02fY1IwiiXaCdj0WqvPkd252XE7qmTRYJNfqWc9XwtSe4p5d86m?=
 =?us-ascii?Q?syxqhcVMtlLa1LFpquKFOWv3025j01+SNQjC7cneGTHvYgjeRhYHFA6WWRIQ?=
 =?us-ascii?Q?9zvfHo5qe6ae/R2Klzk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c878b394-4cc0-4b0e-2bbe-08ddd8c09552
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 10:19:40.6119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3PKR/vy00mkNSXfzPA/MKHBxPjsp243cV7JfjsFMnyvpktIUyR/ErKlbSbjTL7KLqut53PkK0DtsEXOS7BCLEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
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

[Public]

Snipped

> > Since somehow the email are split it is difficult to see the indexing
> >
> > >
> > > Caution: This message originated from an External Source. Use proper
> > > caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > Hi Stephen,
> > >
> > > Many thanks for diving deeper into the issue and sharing the insights=
.
> > >
> > > I agree. given that the primary tears down all the devices on exit,
> > > the secondary is left with dangling pointers and inconsistent state.
> >
> > Secondary if PMD should not be attempting to cleanup (especially for et=
hdev_ptr
> shared from primary) I agree to that.
> > But should not be covered in library or PMD. While cleanup for other
> > needs to be done properly
> >
> >  Without a mechanism to notify or synchronize that teardown,
> >
> > You already have health check added in the code for identify if primay =
is still alive
> or not..
> > There used to be MP thread spawned which actually piggy back the
> > communication. Is this broken? Can you please point to git
>
> There is no easy way to handle the case where primary crashes; leaving
> secondary process with pointers to dead data.

Thank you for sharing, but as shared the other threads (this topic has 3), =
the reason for the patch is because once the primary is dead it causes seco=
ndary to crash (segment fault).

As shared in earlier email at least till 22.11 LTS and 23.03 (as it was my =
last testing with multi-process) I did not encounter these.

@Khadem Ullah can you please share which version of DPDK you are noticing t=
his failure?
