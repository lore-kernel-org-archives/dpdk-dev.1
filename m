Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E694CF8809D
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 07:22:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19B6B402A3;
	Thu, 16 Apr 2026 09:22:20 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
 by mails.dpdk.org (Postfix) with ESMTP id 1189C4025D
 for <dev@dpdk.org>; Thu, 16 Apr 2026 09:22:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W14Gj1x1/2J3ytdXUKTcTlYK6lnt7CfSOa0mtpdxI+Az/BS/QMeAzccgzas90nfjQVI6kGncX/fHssngyOpgxMxbC9sdXlj4rz/BC+YiACycNnoX3oPTd6FXtAabP1M3HSsFD24pkReyND3rO+h9vsDZiqXUOafFAbUVW5LR79V5iLBjeMVMQDFNTCX/uN3RQE8JhDImYwCoRfVwvxtJAsWaZ/5SMi2nmwWUzXw4McOAy37AAYsZDYQoBNGtPG7fW82GXf3uYwhWZz2v/Y6ClGM7bIM0rrVcAbCLtckYyJhxZZYbpPJbZwZ0R69MsqL0nH3BoOgbhE/mFLR3N5+G4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NapdQ7B5HbDgRTuLcxFIrBllnnCfIyLRHQNywLXrlaY=;
 b=zDkTugRzdaMzwjSMIHAWQvL2zIdrW5AyKxR/L8tR1MzEQfsW6EtmqX5P+2KumAz7fKF26AtVOYWs4DBZDzCeomTmZ0RU2P97UIxbfMbPZAJKl2bnyb4JipDPTLQrNZtVlwL0Q8f3vgXP65rAOgyqX2JyahXeqZr5IL+U+SQv7OOiogLY4/9SK+k8+1+QYl3PrUavWkaM0DZdXVfKI8pmaAa9zY8Lb9guoy4ZMVMZgYjKIt3FDZYg9maHmytdEY36iSuhm0etGB/t+Zaz92Wsf6Qfa5b6H5Ic6yFnX5rH/YcDEdfS1xdiMASGwSRwpHFjfni76eG4/H4W4hsduBS5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NapdQ7B5HbDgRTuLcxFIrBllnnCfIyLRHQNywLXrlaY=;
 b=UNNP6t/YBWfdbFzxw/Fd5KGZJ7M+CHqa9uGFgWFi8nxNzGIGxYYa7+VHONUGnQL16OdTomYma6H1oJBrUpDZPqsew9ki/gIJqfBBoeLYu4+FFZO51gHSzaD0LydD5AwrlE3L4UM/d2KSrgv+W7z+Ve26aPkEKQAAGZbRbrngX0g=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 07:22:14 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1%4]) with mapi id 15.20.9769.014; Thu, 16 Apr 2026
 07:22:14 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>
CC: "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "wathsala.vithanage@arm.com" <wathsala.vithanage@arm.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "viktorin@cesnet.cz" <viktorin@cesnet.cz>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>
Subject: RE: [PATCH v5 v5 2/3] app: add topology aware test case
Thread-Topic: [PATCH v5 v5 2/3] app: add topology aware test case
Thread-Index: AQHczEan2CVlJsJLuUK0NGxNpAvD+bXhSnKw
Date: Thu, 16 Apr 2026 07:22:14 +0000
Message-ID: <PH7PR12MB85969978BB6EB2C2E9034A8E82232@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <20260414193850.1696-1-vipin.varghese@amd.com>
 <20260414193850.1696-3-vipin.varghese@amd.com>
In-Reply-To: <20260414193850.1696-3-vipin.varghese@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-16T07:20:27.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|PH0PR12MB7792:EE_
x-ms-office365-filtering-correlation-id: 7ac7ba86-b04a-4278-c6e7-08de9b88e211
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: BVH5LEdJjuD1FeoeFtvzbkkX5Ow+Dc1WtOtEPQEIiBrN++gi3m/N79A3LKWJdiRYjlJEeoSknTM7qUIEPjM6MKAUkZjYaCI3uHqeN2ww3/C5FtT8+0w4M7w8XuAPIIxkQXPkXFzFAi1TXDpHb4R9f6Wz3VJeyMhA6P6hrh761w4NZdzSYrRgfO7/3Zv+vQ/9aM83Aop1/Wv+b4TfH0lcSRDhrMXzEWQfvpO+okeisGZIdJvlhyD8woKPdbQfom0F4EWcazcelQCC4HQ4pfWqBlK2f7APn1ptRL0y7B0wBqTLtKTHOUeRMD6wseCQSdT92lubuTjTNSVIvL43InlRGNV15Inw/nb/v+SwcNQCJpLkuGE2lgsvDEGDp98p6n1O+ksZmN6wz33TPTQZdm5a2ZwYDNtZL73HzVwgNUGMD93BVZgGj4MnsSj9fnoaB0gmWVDyUxtvi8vHCVXdZSeKNQyoSLtSy92B2aHiHeuTSY5c0r3kI/1mFDCnqgoLCY9QaWC42HjLIWmxKWuniJ3KtVsXCBzEEkFtd2/2ZyfQEuzukrTxnQ3pLPloH66tF2SUcpNTl8fdfXRKNpJYUc6snu4rOn79kYzLt0F8xOuvMM4zzKu4ggYFH+a4Www9dCrbYutc4z6DiFoH0RkjTF9J0gTRid0wXv6NELPfrSIPBsPt3lZwarP2vCXBWkC6gUvFQJu8fMNlLo8gKIAirrdMDhx6FTWUncny8VfhBMXM7M7XSURNIoE0eBEhT/hbALstFStmL3rJWM7JQxp4ziyVobsGUlAoBFHXfSGOkLk1C3c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3ouy64zNIysY/NwpdFcyHB+5HuwzSVw4EDFhbZsyIYXgT2kTF83fARsznSmM?=
 =?us-ascii?Q?DF1XWnulbklJ8gtCqbGnl9MVF6BZogqF6nEb5xMxQ0h5USnqdYRvE4f1YzTT?=
 =?us-ascii?Q?i3aHyMI4GOGWWlWB25pdZO2JoXq5giqsA+R4ZnfhkTaG+UpGlO23kt/w5Eu8?=
 =?us-ascii?Q?ftgehK+7nSNYhi8Hq26HKB/8Hq9IdroKHbJOjB4dU5Ei44Adb5jhQ9LwEH7X?=
 =?us-ascii?Q?KNpvv3R9cgWqRilcQy64cL/7VEVObg0QtX8JK+zDm5HxcYqK3XaYw1YkOtwY?=
 =?us-ascii?Q?XNvX4OIBmC7qiTatqaIv+1kAsB6TyRsTzpzI7l7hNg4mnWLTPRFTLgsb5Oro?=
 =?us-ascii?Q?jeGywwr3IRQrgHJwm2o0L9hO3xND+W3/Qo4K/Op2YNN2+Kqxc/UR+SQg4eUQ?=
 =?us-ascii?Q?CrxwdNkcXicz63p/FI8pmGiOnoxtkmhRZ+u0trxso67MLabAKU5k83RmeY6H?=
 =?us-ascii?Q?BBbRUVvZSddrpsKD8Tcv9oVY4u2RWX4FBf/t1ozTWaA6MDpoZ8vlR3bLgTNi?=
 =?us-ascii?Q?rxRXBO29gM+whyJQXXSLDPUTSVaqEzN0F/Wz6y6o7EIQaSSuzNjOZ7KNYooq?=
 =?us-ascii?Q?+HgJ3lAtYrBIG/FrzdE3iY4QffMwAw3vs/IAxWljY0RRKhg4YjjEHZXQNIc1?=
 =?us-ascii?Q?HckHtsl/leokcpM0xaeJOJ7wZAWXOruVcVamifQdRxphUhwUeKMW/iWd7KGR?=
 =?us-ascii?Q?dV8mRFgURd58W8ZSYb0QvFhYAKKg6Na7Rb0MG5v0pHZCx/gFps7oRDlpXVss?=
 =?us-ascii?Q?uyC9I35G4ALss4gA26R44II9Qt6P5HNKpArNCsSLH5QYzr5WMWGUvpHuf/Zj?=
 =?us-ascii?Q?ljPH/Mik9cniT0WY0VZA+/g5smySejSTY+8XJZyjE370+CyqRT5hEBm79Ymc?=
 =?us-ascii?Q?zW5tgeSikLQ7FCnMS8bMsbqlrAYRxQ+N78CP8pd7bSFaL6MIEzzyKGKzZlN4?=
 =?us-ascii?Q?Zp6d7GWrYcI1xSTcZg9f03Bbsuwt4E8OY2348d97wa9AsB9CgHOVjkbFGJs+?=
 =?us-ascii?Q?SgM2Ar4sN5rG4WpY98JJ8OL3bInMugza0vgEXqjXShJbP/xJC4IdSmq+jhc4?=
 =?us-ascii?Q?p++uKfLdghyHFiDlKs3AnB8k5WX8KMtgNRfMR696OmInobmh+TYnhszVoMBI?=
 =?us-ascii?Q?Rf5FIIwJ7NljEA0VzTgWAUz7gdZy9BFHriplRXf6R0LnAo8iNGCIXzRXq+sr?=
 =?us-ascii?Q?FFALyyOU073M6UygoySi0ul7sny0EJCaigINR3YKoikGwqmGqnLhwdjUte0R?=
 =?us-ascii?Q?0HBLFPlWoJRi/KC42grXXaukiuBuy2ux2b1rYdPjjjArCRkUN53mgqz2axQa?=
 =?us-ascii?Q?1AblpmqNq8UVbEnLU07+igl7vJwq/+Ik1E9OcU5TXL79VFDAvKqh49kPJ9TG?=
 =?us-ascii?Q?oPgimMTm0Qcp5ysC5ajH7/FhI/Skx9a8IYDiMrsSf+vr+POSyQa2WHVcgqaP?=
 =?us-ascii?Q?S4V2kePrOVFjZZXfaltJgbb8024di0Bz7rQ3NAz1RElp3hLyK3oa3vk7bapv?=
 =?us-ascii?Q?T3q/LGZmtfE5hR7/CcwaACUTZyZQ8R6ffuNRmawRop5iLBCnmJviLovlAQ/s?=
 =?us-ascii?Q?ppxAgOWzCxkLNyfR+Ntb30zCPRL2lSJXr+U6a12dDdGz7lxiDNDZZW8NEAAQ?=
 =?us-ascii?Q?5PHAzAyAuW2dce9PeHK2q+dGwJNDdSpVMsZ/Xk7QpPazHEXW6siKkUHxv5XE?=
 =?us-ascii?Q?KTEIBTOv8Zhqfsj1La8HeTl2HrVe2XoRTou/vXa0UwDRAg13?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac7ba86-b04a-4278-c6e7-08de9b88e211
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 07:22:14.3418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RWpK2gSPSG1dYNHb9K8t2A8m8dT7xKUxMHNGOFb80a2I7WoTx5bKyE49QFuV9MhE1E5v8r1x5F6tqWuvlnO4AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
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

Snipped

>
>  #include "test.h"
> @@ -74,7 +77,7 @@ test_ring_print_test_string(unsigned int api_type, int =
esize,
>  static int
>  get_two_hyperthreads(struct lcore_pair *lcp)
>  {
> -       unsigned id1, id2;
> +       unsigned int id1, id2;
>         unsigned c1, c2, s1, s2;
>         RTE_LCORE_FOREACH(id1) {
>                 /* inner loop just re-reads all id's. We could skip the f=
irst few
> @@ -101,7 +104,7 @@ get_two_hyperthreads(struct lcore_pair *lcp)
>  static int
>  get_two_cores(struct lcore_pair *lcp)
>  {
> -       unsigned id1, id2;
> +       unsigned int id1, id2;
>         unsigned c1, c2, s1, s2;
>         RTE_LCORE_FOREACH(id1) {
>                 RTE_LCORE_FOREACH(id2) {
> @@ -125,7 +128,7 @@ get_two_cores(struct lcore_pair *lcp)
>  static int
>  get_two_sockets(struct lcore_pair *lcp)
>  {
> -       unsigned id1, id2;
> +       unsigned int id1, id2;
>         unsigned s1, s2;
>         RTE_LCORE_FOREACH(id1) {
>                 RTE_LCORE_FOREACH(id2) {
> @@ -143,6 +146,359 @@ get_two_sockets(struct lcore_pair *lcp)
>         return 1;
>  }
>
> +#ifdef RTE_LIBHWLOC_PROBE
> +static int
> +get_same_numa_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_NUMA) =3D=3D 0)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_NUMA) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if
> (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_NUMA, domain) <
> 2)
> +                       continue;
> +
> +               id1 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0,
> RTE_TOPO_DOMAIN_NUMA);
> +               id2 =3D rte_topo_get_nth_lcore_from_domain(domain, 1, 0,
> RTE_TOPO_DOMAIN_NUMA);
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +}
> +
> +static int
> +get_same_l4_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L4) =3D=3D 0)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L4) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L4,
> domain) < 2)
> +                       continue;
> +
> +               id1 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0,
> RTE_TOPO_DOMAIN_L4);
> +               id2 =3D rte_topo_get_nth_lcore_from_domain(domain, 1, 0,
> RTE_TOPO_DOMAIN_L4);
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +       return 0;
> +}
> +
> +static int
> +get_same_l3_domains(struct lcore_pair *lcp)
> +{      if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L3) =3D=3D 0)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L3) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L3,
> domain) < 2)
> +                       continue;
> +
> +               id1 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0,
> RTE_TOPO_DOMAIN_L3);
> +               id2 =3D rte_topo_get_nth_lcore_from_domain(domain, 1, 0,
> RTE_TOPO_DOMAIN_L3);
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +
> +}
> +
> +static int
> +get_same_l2_domains(struct lcore_pair *lcp)
> +{      if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L2) =3D=3D 0)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L2) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L2,
> domain) < 2)
> +                       continue;
> +
> +               id1 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0,
> RTE_TOPO_DOMAIN_L2);
> +               id2 =3D rte_topo_get_nth_lcore_from_domain(domain, 1, 0,
> RTE_TOPO_DOMAIN_L2);
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +
> +}
> +
> +static int
> +get_same_l1_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L1) =3D=3D 0)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L1) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L1,
> domain) < 2)
> +                       continue;
> +
> +               id1 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0,
> RTE_TOPO_DOMAIN_L1);
> +               id2 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0,
> RTE_TOPO_DOMAIN_L1);
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +
> +}
> +static int
> +get_two_numa_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_NUMA) < 2)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_NUMA) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if
> (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_NUMA, domain)
> =3D=3D 0)
> +                       continue;
> +
> +               if (id1 =3D=3D RTE_MAX_LCORE) {
> +                       id1 =3D rte_topo_get_nth_lcore_from_domain(domain=
,
> +                               0, 0, RTE_TOPO_DOMAIN_NUMA);
> +                       continue;
> +               }
> +               if (id2 =3D=3D RTE_MAX_LCORE) {
> +                       id2 =3D rte_topo_get_nth_lcore_from_domain(domain=
,
> +                               0, 0, RTE_TOPO_DOMAIN_NUMA);
> +                       continue;
> +               }
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +}
> +
> +static int
> +get_two_l4_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L4) < 2)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L4) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L4,
> domain) =3D=3D 0)
> +                       continue;
> +
> +               if (id1 =3D=3D RTE_MAX_LCORE) {
> +                       id1 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L4);
> +                       continue;
> +               }
> +               if (id2 =3D=3D RTE_MAX_LCORE) {
> +                       id2 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L4);
> +                       continue;
> +               }
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +       return 0;
> +}
> +
> +static int
> +get_two_l3_domains(struct lcore_pair *lcp)
> +{      if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L3) < 2)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L3) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L3,
> domain) =3D=3D 0)
> +                       continue;
> +
> +               if (id1 =3D=3D RTE_MAX_LCORE) {
> +                       id1 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L3);
> +                       continue;
> +               }
> +               if (id2 =3D=3D RTE_MAX_LCORE) {
> +                       id2 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L3);
> +                       continue;
> +               }
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +
> +}
> +
> +static int
> +get_two_l2_domains(struct lcore_pair *lcp)
> +{      if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L2) < 2)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L2) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L2,
> domain) =3D=3D 0)
> +                       continue;
> +
> +               if (id1 =3D=3D RTE_MAX_LCORE) {
> +                       id1 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L2);
> +                       continue;
> +               }
> +               if (id2 =3D=3D RTE_MAX_LCORE) {
> +                       id2 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L2);
> +                       continue;
> +               }
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +
> +}
> +
> +static int
> +get_two_l1_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L1) < 2)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L1) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L1,
> domain) =3D=3D 0)
> +                       continue;
> +
> +               if (id1 =3D=3D RTE_MAX_LCORE) {
> +                       id1 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L1);
> +                       continue;
> +               }
> +               if (id2 =3D=3D RTE_MAX_LCORE) {
> +                       id2 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L1);
> +                       continue;
> +               }
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +
> +}
> +#endif
> +
>  /* Get cycle counts for dequeuing from an empty ring. Should be 2 or 3 c=
ycles */
>  static void
>  test_empty_dequeue(struct rte_ring *r, const int esize,
> @@ -488,6 +844,60 @@ test_ring_perf_esize_run_on_two_cores(
>                 if (run_on_core_pair(&cores, param1, param2) < 0)
>                         return -1;
>         }
> +#ifdef RTE_LIBHWLOC_PROBE
> +       if (rte_lcore_count() > 2) {
> +               if (get_same_numa_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using same numa domain node=
s ###\n");
> +                       if (run_on_core_pair(&cores, param1, param2) < 0)
> +                               return -1;
> +               }
> +               if (get_same_l4_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using same l4 domain nodes =
###\n");
> +                       if (run_on_core_pair(&cores, param1, param2) < 0)
> +                               return -1;
> +               }
> +               if (get_same_l3_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using same l3 domain nodes =
###\n");
> +                       if (run_on_core_pair(&cores, param1, param2) < 0)
> +                               return -1;
> +               }
> +               if (get_same_l2_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using same l2 domain nodes =
###\n");
> +                       if (run_on_core_pair(&cores, param1, param2) < 0)
> +                               return -1;
> +               }
> +               if (get_same_l1_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using same l1 domain nodes =
###\n");
> +                       if (run_on_core_pair(&cores, param1, param2) < 0)
> +                               return -1;
> +               }
> +               if (get_two_numa_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using two numa domain nodes=
 ###\n");
> +                       if (run_on_core_pair(&cores, param1, param2) < 0)
> +                               return -1;
> +               }
> +               if (get_two_l4_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using two l4 domain nodes #=
##\n");
> +                       if (run_on_core_pair(&cores, param1, param2) < 0)
> +                               return -1;
> +               }
> +               if (get_two_l3_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using two l3 domain nodes #=
##\n");
> +                       if (run_on_core_pair(&cores, param1, param2) < 0)
> +                               return -1;
> +               }
> +               if (get_two_l2_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using two l2 domain nodes #=
##\n");
> +                       if (run_on_core_pair(&cores, param1, param2) < 0)
> +                               return -1;
> +               }
> +               if (get_two_l1_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using two l1 domain nodes #=
##\n");
> +                       if (run_on_core_pair(&cores, param1, param2) < 0)
> +                               return -1;
> +               }
> +       }
> +#endif
>         return 0;
>  }
>
> diff --git a/app/test/test_stack_perf.c b/app/test/test_stack_perf.c
> index 3f17a2606c..e5b038a3e8 100644
> --- a/app/test/test_stack_perf.c
> +++ b/app/test/test_stack_perf.c
> @@ -10,6 +10,9 @@
>  #include <rte_launch.h>
>  #include <rte_pause.h>
>  #include <rte_stack.h>
> +#ifdef RTE_LIBHWLOC_PROBE
> +#include <rte_topology.h>
> +#endif
>
>  #include "test.h"
>
> @@ -105,6 +108,367 @@ get_two_sockets(struct lcore_pair *lcp)
>         return 1;
>  }
>
> +#ifdef RTE_LIBHWLOC_PROBE
> +static int
> +get_same_numa_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_NUMA) =3D=3D 0)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_NUMA) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if
> (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_NUMA, domain) <
> 2)
> +                       continue;
> +
> +               id1 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0,
> RTE_TOPO_DOMAIN_NUMA);
> +               id2 =3D rte_topo_get_nth_lcore_from_domain(domain, 1, 0,
> RTE_TOPO_DOMAIN_NUMA);
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +}
> +
> +static int
> +get_same_l4_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L4) =3D=3D 0)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L4) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L4,
> domain) < 2)
> +                       continue;
> +
> +               id1 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0,
> RTE_TOPO_DOMAIN_L4);
> +               id2 =3D rte_topo_get_nth_lcore_from_domain(domain, 1, 0,
> RTE_TOPO_DOMAIN_L4);
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +}
> +
> +static int
> +get_same_l3_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L3) =3D=3D 0)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L3) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L3,
> domain) < 2)
> +                       continue;
> +
> +               id1 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0,
> RTE_TOPO_DOMAIN_L3);
> +               id2 =3D rte_topo_get_nth_lcore_from_domain(domain, 1, 0,
> RTE_TOPO_DOMAIN_L3);
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +}
> +
> +static int
> +get_same_l2_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L2) =3D=3D 0)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L2) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L2,
> domain) < 2)
> +                       continue;
> +
> +               id1 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0,
> RTE_TOPO_DOMAIN_L2);
> +               id2 =3D rte_topo_get_nth_lcore_from_domain(domain, 1, 0,
> RTE_TOPO_DOMAIN_L2);
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +}
> +
> +static int
> +get_same_l1_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L1) =3D=3D 0)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L1) {
> +               if (rte_topo_is_main_lcore_in_domain(domain,
> RTE_TOPO_DOMAIN_L1))
> +                       continue;
> +
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L1,
> domain) < 2)
> +                       continue;
> +
> +               id1 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0,
> RTE_TOPO_DOMAIN_L1);
> +               id2 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0,
> RTE_TOPO_DOMAIN_L1);
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +}
> +static int
> +get_two_numa_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_NUMA) < 2)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_NUMA) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if
> (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_NUMA, domain)
> =3D=3D 0)
> +                       continue;
> +
> +               if (id1 =3D=3D RTE_MAX_LCORE) {
> +                       id1 =3D rte_topo_get_nth_lcore_from_domain(domain=
,
> +                               0, 0, RTE_TOPO_DOMAIN_NUMA);
> +                       continue;
> +               }
> +
> +               if (id2 =3D=3D RTE_MAX_LCORE) {
> +                       id2 =3D rte_topo_get_nth_lcore_from_domain(domain=
,
> +                               0, 0, RTE_TOPO_DOMAIN_NUMA);
> +                       continue;
> +               }
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +}
> +
> +static int
> +get_two_l4_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L4) < 2)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L4) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L4,
> domain) =3D=3D 0)
> +                       continue;
> +
> +               if (id1 =3D=3D RTE_MAX_LCORE) {
> +                       id1 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L4);
> +                       continue;
> +               }
> +               if (id2 =3D=3D RTE_MAX_LCORE) {
> +                       id2 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L4);
> +                       continue;
> +               }
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +}
> +
> +static int
> +get_two_l3_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L3) < 2)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L3) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L3,
> domain) =3D=3D 0)
> +                       continue;
> +
> +               if (id1 =3D=3D RTE_MAX_LCORE) {
> +                       id1 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L3);
> +                       continue;
> +               }
> +
> +               if (id2 =3D=3D RTE_MAX_LCORE) {
> +                       id2 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L3);
> +                       continue;
> +               }
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +}
> +
> +static int
> +get_two_l2_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L2) < 2)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L2) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L2,
> domain) =3D=3D 0)
> +                       continue;
> +
> +               if (id1 =3D=3D RTE_MAX_LCORE) {
> +                       id1 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L2);
> +                       continue;
> +               }
> +
> +               if (id2 =3D=3D RTE_MAX_LCORE) {
> +                       id2 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L2);
> +                       continue;
> +               }
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +}
> +
> +static int
> +get_two_l1_domains(struct lcore_pair *lcp)
> +{
> +       if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L1) < 2)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L1) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_=
L1,
> domain) =3D=3D 0)
> +                       continue;
> +
> +               if (id1 =3D=3D RTE_MAX_LCORE) {
> +                       id1 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L1);
> +                       continue;
> +               }
> +
> +               if (id2 =3D=3D RTE_MAX_LCORE) {
> +                       id2 =3D rte_topo_get_nth_lcore_from_domain(domain=
, 0, 0,
> RTE_TOPO_DOMAIN_L1);
> +                       continue;
> +               }
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +}
> +#endif
> +
> +
>  /* Measure the cycle cost of popping an empty stack. */
>  static void
>  test_empty_pop(struct rte_stack *s)
> @@ -331,6 +695,51 @@ __test_stack_perf(uint32_t flags)
>                 run_on_core_pair(&cores, s, bulk_push_pop);
>         }
>
> +#ifdef RTE_LIBHWLOC_PROBE
> +       if (rte_lcore_count() > 2) {
> +               if (get_same_numa_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using same numa domain node=
s ###\n");
> +                       run_on_core_pair(&cores, s, bulk_push_pop);
> +               }
> +               if (get_same_l4_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using same l4 domain nodes =
###\n");
> +                       run_on_core_pair(&cores, s, bulk_push_pop);
> +               }
> +               if (get_same_l3_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using same l3 domain nodes =
###\n");
> +                       run_on_core_pair(&cores, s, bulk_push_pop);
> +               }
> +               if (get_same_l2_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using same l2 domain nodes =
###\n");
> +                       run_on_core_pair(&cores, s, bulk_push_pop);
> +               }
> +               if (get_same_l1_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using same l1 domain nodes =
###\n");
> +                       run_on_core_pair(&cores, s, bulk_push_pop);
> +               }
> +               if (get_two_numa_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using two numa domain nodes=
 ###\n");
> +                       run_on_core_pair(&cores, s, bulk_push_pop);
> +               }
> +               if (get_two_l4_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using two l4 domain nodes #=
##\n");
> +                       run_on_core_pair(&cores, s, bulk_push_pop);
> +               }
> +               if (get_two_l3_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using two l3 domain nodes #=
##\n");
> +                       run_on_core_pair(&cores, s, bulk_push_pop);
> +               }
> +               if (get_two_l2_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using two l2 domain nodes #=
##\n");
> +                       run_on_core_pair(&cores, s, bulk_push_pop);
> +               }
> +               if (get_two_l1_domains(&cores) =3D=3D 0) {
> +                       printf("\n### Testing using two l1 domain nodes #=
##\n");
> +                       run_on_core_pair(&cores, s, bulk_push_pop);
> +               }
> +       }
> +#endif
> +
>         printf("\n### Testing on all %u lcores ###\n", rte_lcore_count())=
;
>         run_on_n_cores(s, bulk_push_pop, rte_lcore_count());
>

<snipped>

Unable to find `Sudheendra Sampath` in dpdk mailing list and Slack. Can you=
 please connect with me email address or slack.
