Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B6DC87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:23:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42F344067B;
	Mon, 11 Aug 2025 12:23:45 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by mails.dpdk.org (Postfix) with ESMTP id C879D400D5;
 Mon, 11 Aug 2025 12:23:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGqv05rKPYGetoO57CFDL9KgjvGY49f9T3OwHbIT5IKILa4LXmBMy6l5wMu0Fb+ucCJ8yQ7DjDt/SBl/i2LPtzbYlSh9krk3Kv0lk6ZmbC3hvLiv29hbcjFHjD4+XdygnVSUUH9FtghWMWm8Y5VHWFq+8QUCUMfsIzPqdqv6cKPJVrjbjsIP+qW6dKCTBT6EBnMd6n9eHyYIo+KGVr4u+CIq6OjmheK8SJISnF1nAMB4w2IWFboZYdG9Z5yhkHR8IQFW7CSN/Eyd86FV+PhqP1XHzjTIkkU0oBjSQ6EdYhnlmVR8XZUzHMNAEB7ulxKra+MSF/Pv6XdAZjMOLRVwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLanA596fYaHHCk+Yep2iltCPryVwoxCXFn1gGpwvds=;
 b=b344RSYx0wGq9H8kfwXzsRjclgjSz1Hzm5dcXFAdQ8V3Q3HnLLNtvpxIwrYKk2cqCIZNSkCXbCZTTv4rSy6mfvKkL3NzS5dHqDChaU4NCxwQHEA7QKRPywXnhACPe3gSXjq7nDV3/unARPky2BUMvrSL/98fSPgEXnjbNs9R0VoiRUE8cvorr8zDxjRvG5MoUlly0oET/QWhROmb1BeQkh8NW2hTgVGfVfCnDVRCeN8lJnZ9T/k3km4baBhXItryhfPlI5K4PMVwz1d2/yv556ZNDMxqbxQTRrbLrg+Vzeic9aTK2PkEBFrGIFND4qK4e4E4b3O1EG3CUlQPqScikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLanA596fYaHHCk+Yep2iltCPryVwoxCXFn1gGpwvds=;
 b=y+NbRT5K+iRRQ8lDus3RYr6x0MjQIwQQHHUsWpWH6KcSImhGw1iS0Qywji8J1yWGJ8wALr8JHvJ5PTpUclYnuseV+l5rExup3okUgAMhDcFysQeDcfxFBa7b6nlcx+8oN227jb56Bs/BKK7gGIo8dLKkqxPmqOUi0Mo+zw0ABa8=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 10:23:41 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%2]) with mapi id 15.20.9009.013; Mon, 11 Aug 2025
 10:23:41 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Khadem Ullah
 <14pwcse1224@uetpeshawar.edu.pk>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] [PATCH v5] app/testpmd: fix segfault in secondary process
 by monitoring primary
Thread-Topic: [PATCH] [PATCH v5] app/testpmd: fix segfault in secondary
 process by monitoring primary
Thread-Index: AQHcAFOh0w4kQAEhk0S0elww42p95LRJpHsAgAB/NYCADgiKMIAA0wWAgARTD0A=
Date: Mon, 11 Aug 2025 10:23:41 +0000
Message-ID: <PH7PR12MB8596A4119DA21A976EE806008228A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250729144850.2392840f@hermes.local>
 <20250730052412.78178-1-14pwcse1224@uetpeshawar.edu.pk>
 <PH7PR12MB8596F632CAD6508EA7EAB843822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808091735.561e6cbb@hermes.local>
In-Reply-To: <20250808091735.561e6cbb@hermes.local>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-Mentions: 14pwcse1224@uetpeshawar.edu.pk
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-11T10:19:53.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|PH7PR12MB5688:EE_
x-ms-office365-filtering-correlation-id: 0c7d685f-5f7d-4b4b-0e0b-08ddd8c124c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ez+6R9qQdL0GEKVUe3dQqO6DwLNKqsjTmyWEMd+qXT7TVeWMdZrtpWIB4jNu?=
 =?us-ascii?Q?4BocVVthfR+fYH5ZBlYsimlQlzxXMjPYL4rR/fkULFhXGeiZ20WfCu4I1UWJ?=
 =?us-ascii?Q?7XaKLCwgwCbiqpyKMsKN0cxQRQFtpShJZwGhc2LNLQpd2yLrftSsrcHB8qFE?=
 =?us-ascii?Q?kqgkUXVzExvk0IxNpnCtwN55Lf6RKPJw0hjbsetAMJPyaIaVbL+11GaoqSCh?=
 =?us-ascii?Q?Lo/aCQ+6tswlddphzr6+e1RUQMFytFC1JxjQjYA1z6kEeRY3MBK+ZU6ZL+H5?=
 =?us-ascii?Q?NKHcl4IPwDuGH4KIH22cmrTwgKrnivaSyxSXVHHWAwYrBqsZNwYRIWmVKJsq?=
 =?us-ascii?Q?6fE8n/q5DEwQB76IkkEzCdhhu5IcPHtrgDTbpG1/DlO4HgLKDwRup4kvdjgD?=
 =?us-ascii?Q?RyMuvlkfj8U61cFGLhg0+mSkYdwlW0s7gGJqpAijPl3KedAZGVUkP8yB5NVT?=
 =?us-ascii?Q?p33tdo3Cor4u8pLCwqWc49UWHQiYsLjSfqbygesIpSieS3PPZSAbmUknTTRA?=
 =?us-ascii?Q?iBFTdV4ErDztiAFQ0kcd/3vL6CJKDJm65nS9xu4SPEdp/nakYtDylgq5qoKO?=
 =?us-ascii?Q?icHMV04RZkPi/TdjErd8vRUgrfcatt4pH/XJ+yPSfVhtPDRMZnmHubZzMoJE?=
 =?us-ascii?Q?bzB3J+TKr0kVsh7K9r9p3Yg6hbeCEvrhfZbxYfue0gwYpyBYMjca3MNg8vLG?=
 =?us-ascii?Q?J0IBLcjIAqCPI4qg+FnItiD4qjWE/BlU6iaVTCDqBwQj7fUgaMHaJ+7uR6io?=
 =?us-ascii?Q?LFkSnuIR/951O9hdux66QhsmZMqwxzo0uafauh1EqUofNTx6wvuVuYDLSmzQ?=
 =?us-ascii?Q?X5kLK6FpN0YO6Bxyn1/D8iohMyTdN0XT+txIXtIXbIwoM9UjmSshI5CkjNxG?=
 =?us-ascii?Q?oVI+PSyIneHJoPiUC7gtduGIYA90XStcOOW3/k/i7/9GGI0m60z42ONqt9yz?=
 =?us-ascii?Q?jRFZJfrBc7TSLqTu0Yk70nCTONjuWzEQANJ3qoGr7Txdw62kGVN0bZ8XIiDD?=
 =?us-ascii?Q?ca+M8mAoPQm7aQAHGajpoBTuQi2/wUswwnCedq+QhI1Ox0KyEuNLiMA7VOYO?=
 =?us-ascii?Q?vDXpC8K9/E5Q/F72kFu3Kma0XftiWlrF2UJQYco1StoYRoJz59/u0FsvMOR+?=
 =?us-ascii?Q?LqbOWHPrixuex/qFco1UigcCGCOAGieJ+sUpMJyPUzitLhfeHhFO5a6X/a3X?=
 =?us-ascii?Q?SUDWk/qp3QWLmptZZCpF2fR13/VO9+xRJi25lotPm13NzX6xBs4o1PUqyI33?=
 =?us-ascii?Q?56Z0VWUq95msP+h9VFwQ/QsP+Wo50M7spbyKQBRFIYWm3ekQKk0/yEnlSeDr?=
 =?us-ascii?Q?KgFpnIwS2/61Yfj/QJFH/PjPb58PETqyzedfhWldUVcVwlAS5Ynl7+M8rY7C?=
 =?us-ascii?Q?ZxYgA3EjakSBSdTKWQNRgdFsUCG8uGGd+C3ii0pGjoQ2sg83oz4hPav3Hq5U?=
 =?us-ascii?Q?tM1LJRCZjCV691es7zxeDnJeHoex2leCXgbQ7kagT9DyOV7JgKa9P7ivCFK9?=
 =?us-ascii?Q?bkGelzeyecYpB8A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?syCW7YKGj0FpBPkD4FX26hpVqgUAiKd6ANlyD/TPadaW32Eb04S8tHD9MP6J?=
 =?us-ascii?Q?qin93VXNVVd0WARd5byCeMnn3L41By4773wlULwf9YkqmzBb2uikHAtMvwVh?=
 =?us-ascii?Q?Lk/iiPoP19i8SfAUH6frkI6AWzxdcyY5i45zU/fjvFrEdJ3O0q8pXlXw23lq?=
 =?us-ascii?Q?KbRYKnZUayTDfAUPkHQIYNt5cdG4n+yHsCwAF6JeIwiKSbUtRDhJAnZmd+G7?=
 =?us-ascii?Q?b1jibGwhHUfp1pNXCJk+iZB/b8N++TWOxSo/CA8Qj9/fnFY6VfjW2otidkab?=
 =?us-ascii?Q?dFUZYuVBdvHUzKXxcyjTBnB1p8AmUQX559+vgGwOyVj8PLA5ahp+jy8nOTe7?=
 =?us-ascii?Q?j0CTNgWr2xNw4XCc1HByTQv/76UWzKO8qafm1+Ng9y3sZP/rLOrtNvSjWakM?=
 =?us-ascii?Q?jxs4CH9W4bbLZ612gdEq3HzPk5CXGIaWOJMvILLdV61/CYT2gtcCiQxG6vfU?=
 =?us-ascii?Q?31ionKyrrpJif17O+v9+bvDHSckV2BZP4/upEqLqplGPofhZLnVVONrIwmEn?=
 =?us-ascii?Q?MuQrf5/Z69bUH6VMQxwPGlPwJPBD3ob1ka7YJD5Lj9uUf0DXEsIMhdcNhkaT?=
 =?us-ascii?Q?RD7+icweHZ6HDe4xS7A1DSYo5qhEO0P+/0XoIPYRfqy0JU0y7584M1OHwDwI?=
 =?us-ascii?Q?Tjc4ZSXFoALks6SgRmvH7eH9IfOf5pl4ECP3uYqJ+RMQH3/WRVhfqdJ+OVQQ?=
 =?us-ascii?Q?CRngdvYhZ73tsnbMtGoyxN/489RZugyQQBFdYMWMgxweDfcQ7tj9tRZDLJOE?=
 =?us-ascii?Q?E8LC/UzBDN1CsSPGvlcyn12QwMHNSyr3nFBFgIGHOiNBAiCk8gZ049TTAkRA?=
 =?us-ascii?Q?xMgXvOluNCU+N1YNxM4XXenueSu9Wc2JVIWjTlYCoWG5vrQQ6SuMYiPFID63?=
 =?us-ascii?Q?GmYyPjZ08IqT5QIKdLZrECkpFrVzC+V7XV5r2x0qLLq5pbtJoJUm8CjNV26a?=
 =?us-ascii?Q?kcMv5txLnzPq+OtvduKES1+a+3qhiGQVhvCZrFQ1dCR2kkR87SESlCzZZDQO?=
 =?us-ascii?Q?zYMdeJQpV/okXig6gdHKHLdzSN+08G5X48ho6fvg8VcVkhZOdG0ALjO1Q3LD?=
 =?us-ascii?Q?6GcSZikN44srHnEMFxR8fYsdX5n4KbdnQ70y0bmnV494MOD/zjFMR0625zk3?=
 =?us-ascii?Q?C5V2RXwpgusRNnn+LV5SZpcmiVEprv8kxuIdL90Z4eM6EA9mi8OGPSvxY0JW?=
 =?us-ascii?Q?oy3EBWojNdfbOnq9wgFXOvIbJWyZEaiw1nPaRHCi3G+pGIbTUcvvDLwvuzVl?=
 =?us-ascii?Q?S2p3/OuUw7JH0RWHh3Zs0P8n6dRsr+DuNTQ6dAn9SnliCAwIePv3KJM5/8MO?=
 =?us-ascii?Q?5NjS4inSh/+JcQ/qJpPq4rWwViyJ5Ara20/7ug1QsM7ipyUnKWLIByXYqBx2?=
 =?us-ascii?Q?kB48lQe9cJzOz8VLjBycovxKYKR5jZihh1Xq/6TVoeQQIzN/MoHdkzWzW1E7?=
 =?us-ascii?Q?B31BmbsgsXeHlMvXhV8ddoC4TiRzAfCDG+6YKAvzDnio0buVpn7iWBYHeL6Y?=
 =?us-ascii?Q?cLJphbErUlDe7+pda5KIa1akkWPTeA1bmx+OjL7XwkSwMo+ADI162HAxb+ty?=
 =?us-ascii?Q?uRiF6LX2j3q5IfFgp5E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7d685f-5f7d-4b4b-0e0b-08ddd8c124c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 10:23:41.3503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: urvj6FmoFAhMA4sBEtY2nyxdIsKjNJyq3RYE7VzVg92kNkko6MFw5o57liHbxYEPckZsBJSf1HjobUWQeQNaUA==
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Stephen,

Snipped

> > Hi Khadem,
> >
> > Snipped
> >
> > >
> > >
> > > Hi Stephen,
> > >
> > > Many thanks for the fix and for the suggestion that the secondary
> > > should exit immediately without attempting any cleanups once it detec=
ts the
> primary has exited.
> >
> > Can you please explain why cleanup of secondary resources are not to be=
 done,
> If there is specific memory like external hugepage backed mempool none of=
 the
> callback will be called. Also releasing internal stack memory and heap of=
 secondary
> is not cleaned.

@Khadem Ullah can you please share if secondary application is not able all=
ocate external memory and run.
Can you please confirm running the same?

> >
> > Is there specific reason why you do not want to clean? If yes, can you =
please
> point to the right direction what is breaking?
>
> What happens is that both primary and secondary process have a list head =
that
> lists devices (like ethdev).  The ethdev's shared part lives in huge page=
s.
> When primary exits, it calls the cleanup which frees the list (local part=
) and the
> shared part.  When secondary calls cleanup, its local part now points to =
freed data
> in shared huge pages. That leads to all sorts of issues.
>
>
> There is no need for secondary to do any cleanup, all the local memory di=
sappears
> when process exits.

As shared in other email threads, the reason for the patch as far I followe=
d `at segfault of primary secondary crashes, @Khadem Ullah can you please s=
hare the details.`

>
> Also, there is no locking between primary and secondary process.


