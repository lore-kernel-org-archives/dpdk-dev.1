Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BBFE91291
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 08:45:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 191794026D;
	Thu,  5 Feb 2026 09:45:19 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
 by mails.dpdk.org (Postfix) with ESMTP id 2E37C40264
 for <dev@dpdk.org>; Thu,  5 Feb 2026 09:45:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfZWKbbwITw/MLWv6tCsHfA5qhdPVCosgiFYpYGckHVPfOlsuZyVEcoLEuC7aut/ksltRucrSgkDTItQDWv1Bol1aWfJrfShfnsSiSh/etww2ObGLVPXXN87kOKw/sIg9aXT9LipDGkmnagAzrXfYOn1Yxx2yHdzmic4CkU28SOqM0eEXH3reVn+GBEYQR3/dYD1MMylYApe+G1tjbNoL2Ovc5BNUSFNro1UZBxcoeGpsoI5HUWvcUecP8zMUGLYNGTtw7pYAOdK8BT/1uxEW2g/OJ/Xox7ouhqfvg8nL/IjnMFWBaTogLQ8SXNuyFOknwMPnoftCGhg57bbvE7Tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB3q0Prmh/sS9eHqfg3AgRoC156RAuP9M28hhD0Pjck=;
 b=UbER/KUBBfoidQsddwtgVow5RsWFhkwt9+x49t7ooYrQHmddDhcZaJn+3xKRcBJuCpF8nXbyejwg5I/Hnjxrjg/OK610JZ8KitBaemVBl9JqPDP+A0GOmBAAyVyF/zfNKRxvlg21VhRgSyxx5f7s4URz3rFzx6BCK87CGnoXg57xvuEzHwQjzvH9WSeT+rgaw0hOeIBcukhmuIi2inEUrvDRxaHIYTU2HAyerThZXOdF6aXejnw++HQR3IPV8cNe+gEw8ZpguR6uqrwhBF/wX13qCzh6QZ5oLOyQE9+T28CUeo+Wj8v6O2HXz/gAjkDU/Ga/rK31WCQ4cBzJrSp9UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB3q0Prmh/sS9eHqfg3AgRoC156RAuP9M28hhD0Pjck=;
 b=WGA7OCE1RVc0pZ6E47IxQPNSk+kGe6SibH+2vs2ctXvFkr/JLZuxBgymFwCihsewroeNggM2r4nmGogWUDi5AqzZrPx3klxbUJ8HihTnt0ZCvbhUy+sZA0JylZgJpkMLO/2LGUjhEW++uqZqB+8/zBzq2jpBTq3Jtir8QIXOMPatTeAYncNVzaGQ7DSay6SfmupKjWtn18kPVQFHvA3r7ujDYR9nedXMuO3qngRwya4u2Dqr6yEZi0FZzLscI0HoquaXoY+qcSAHA2opLJ3osODJeVm0RFy9NIRVhu+2GZXcn8aiI1YQ3EP8fyYseLq9laq5cVOhlrMTQAMqepnUyw==
Received: from IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:45:14 +0000
Received: from IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::3d3c:bcd3:d413:7f7b]) by IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::3d3c:bcd3:d413:7f7b%3]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 08:45:14 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Slava Ovsiienko <viacheslavo@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Raslan Darawsheh <rasland@nvidia.com>, Ori Kam <orika@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan
 Azrad <matan@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>
Subject: RE: [PATCH 1/2] lib/ethdev: support inline calculating masked item
 value
Thread-Topic: [PATCH 1/2] lib/ethdev: support inline calculating masked item
 value
Thread-Index: AQHcV5d2f5lwV3ChikmVEqm/sRDM67T3HwiAgH0obUA=
Date: Thu, 5 Feb 2026 08:45:14 +0000
Message-ID: <IA4PR12MB976320B7558FED4FCEB80A1ED099A@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20251117075407.9632-1-bingz@nvidia.com>
 <20251117092503.59952ea6@phoenix>
In-Reply-To: <20251117092503.59952ea6@phoenix>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9763:EE_|DS7PR12MB5840:EE_
x-ms-office365-filtering-correlation-id: ca48d4c9-0ff8-4928-bc4f-08de6492e17b
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?kM0D3Pk2Xpv8kjD0gPUwrKFxz6wpjITDSFYpAExsAM6gLBkyYSYbO8B2J2uE?=
 =?us-ascii?Q?udaw1ehzuiOzhYHqKIJd7ZDbHHrybfyu73dxpTbo/+0IvP73X3iIlf6AqFAD?=
 =?us-ascii?Q?TYfXUPHjGzGX/Q1yH9joO2qlBX9HPcO+dwCyd4RCsIZbUpb2GulHWuXnfbOv?=
 =?us-ascii?Q?ihaj8ZkyQbCL6bGK8C3Fp+MR41FEuuNr0IM/pZlOFDhtCcLkkM8j60i4Tf12?=
 =?us-ascii?Q?Bc8V8WOpz2vGgHlNaZ6eVTQ0rq8UnnvYiIuGesyWfUboGpvsmQApRR3VpuNI?=
 =?us-ascii?Q?2MVFu3/9Vz6IWh7NKwRXEa7vCluog4Ci/sb4DKQlfUPLO4TlkAjZYlZTUaDk?=
 =?us-ascii?Q?+PFQIQVw15yA5Xjz1Mjh6wS2mrP0gvZn4QYc4vU2pnxLyYr5QQZdN7YrXfwG?=
 =?us-ascii?Q?sI2k5W6G9X4YVmqDu8RfKZj2g+NdtwfX1iq5ybYB1KOzYOIUcFGj9WEoA660?=
 =?us-ascii?Q?TwzdOukRA+9KAgfVK4E8tz49F9KZkKjw7rMv5XyMzojet9DeeHlBxS0id759?=
 =?us-ascii?Q?jGUd8cmzj/tjxxTR1DYHtlmRviR7+S1IugGPDEMYJ2PHhugkvOykMhO/vioK?=
 =?us-ascii?Q?T1+KMMDgIcCQJ8lhYuINMOdPUA0TxovW0CDYSouZXlUFUKha7ybo9vXouIF/?=
 =?us-ascii?Q?bDTSBUfqfkNWizsRp9/zLjYDVquT+Ollww/kLysBlTC62vhrsmGQf2ef5iP/?=
 =?us-ascii?Q?6nO4vuTl3wmRcBJHv+IIgEbxeQwswCZJTDv4Z4rZKrEJV3lOi+Fa/RoZrzL2?=
 =?us-ascii?Q?PnTgiJRre1Bsrct7IcEhkQeumW0VLa8w2CH0tP7d+XgEf1DdH9PPpFhZV5Zw?=
 =?us-ascii?Q?1VRhpBnDCrYQJjxzvhUjMLWfPSWyuwmetkdxkf52W124Q70OK0LejMAYYj6v?=
 =?us-ascii?Q?Cxqtze6EBTodTc1Vv73CKiUJrZrcPWhm7E5Xt1hgL+FuYeWylNr8JAZcyyRn?=
 =?us-ascii?Q?/mXYuyQRx83MaOJGiWLZuEPy6bxOFNP/8GUfFwFcIiwk7od2U0qU/J4qyPeR?=
 =?us-ascii?Q?r7+Tx94XBRVuYYI4j2luKdlcJwHW4AgI/Nj2wANg+210Pevqrhx4KsF9RGeY?=
 =?us-ascii?Q?kIjWB2RfHjaz5iwlxKSKOs+45PcEtRRmAr9a2JEWveoEYNkdKPo4h5Z2UCWp?=
 =?us-ascii?Q?4J4DSCqHpJ6LlnAp5kwCFX0TfhCPY4s+oKtuSOmyhke+pAHSywtcc33skMc7?=
 =?us-ascii?Q?84L22u5kYR230u+I0tv0XWsfsbJ09Rfr0IN5MjtocCpYi/DYLKtLsTDuodaA?=
 =?us-ascii?Q?QCOIj/Z99vYlM95pFZ+MJuGn56Nd+3ojxv0FcMwIIrt16buq41B/QXR2l9gv?=
 =?us-ascii?Q?jDW6qA8iwqg46aqZeBIHlaNmoJrpabrRP5RdGoUANYvFRIa5zhKV500r/q1x?=
 =?us-ascii?Q?0Se37EPhid+awy46DSr3eZqkJhav/UxkA7gWh1nIejBHC4AqEi/Ibc3f8WH3?=
 =?us-ascii?Q?/4qV3xCXzWm2KH2/s69ecr/YSGIKQQMmUroED5rUZ4GdU1WmYAC5vrqtpAoF?=
 =?us-ascii?Q?4lpvbGZJbuxe8QLTuy6w0hpWM/CvX/qTyTW5HLbTfaSpw6CZDo/jJrfzmH6F?=
 =?us-ascii?Q?YswGSP6CO5rl60dBB79CZjC2Nn92eRDwfVzawdhgo7NAVBQzEEI3Bu9jQ9mV?=
 =?us-ascii?Q?wqipyKhl1ne7znwtjER9buU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3NDKg2W3Nc0YYl24Zrgd3mGTevaBqetfv5BR3x3tRBVYlNytT69PFOY+qtjm?=
 =?us-ascii?Q?kdZdkhw+EKcocvWLcJv8asK7INcX/NiIz46+Za+JDPcGDb1bjzHmoUoALUm+?=
 =?us-ascii?Q?ENRPw6odKrdTdkR0flTQKGrItNr/tnjw1buoh+q+cTUj8OSWXielSucQNWMJ?=
 =?us-ascii?Q?ecIMLCtQWcVHp6h2o3b7gfLsExQlxku+XE8UZGYelqtD3lSGohfOkKQHXivt?=
 =?us-ascii?Q?Xacjg1VcNHZQlpu/mJQMjWnjx5zF6wMiPDLmusd4cJgR5Ln6Ans7QM325qCe?=
 =?us-ascii?Q?b+p3hbKrHxGIdPYP78/YFAdaP7wUlUBRNgVF2Y8y9wz3ZYQWIpeVHwQuK7GG?=
 =?us-ascii?Q?aNYBo5X0zwgi6v+yuEoy+YBEaFxxNhphfy1p1KWPXts36N4cfbH0QdWbfcMk?=
 =?us-ascii?Q?MrEgshfxX+Thg1DR6QQdkDCw9lTPKnv/Kob7cymFd+r2IQkdGorSNcJE/lUF?=
 =?us-ascii?Q?DnaCL74TogEBlHSjyyPSDSh1L7n52LTKhWXp2yeqx9tIGg63FB/6kd40StCW?=
 =?us-ascii?Q?Xko+LFleCO7JS5DYRlWFQTTqWewnfxQRZpTYNFBfxwbvZMwZnIctai6CJHA3?=
 =?us-ascii?Q?Qre4MK/NNIWmRcxJD21ji36aGzHX3gWsRwAh6+Wbfi+78heIGSpA1ocbOAXX?=
 =?us-ascii?Q?njz73cBRtWJ1qcO/IBncEfiYK7+JAfNqQ5AhcgxwPSbkMCZzAZYAxCDlNnm6?=
 =?us-ascii?Q?nnG9Zun//a3iePtUDkmTV699cdvGy7LG8LghoiKnUmbcg7MHLDe+6QoUe0HS?=
 =?us-ascii?Q?7lGyLaS+IgIcLUIwJGUdi/t85NFJXcyekLWobZ4yZYt58VRAIjVAvop7cIRQ?=
 =?us-ascii?Q?FCaHzg0xC686KqvThG8gY3dMQP30Y0hRKe+eGCgGoClBZOYwKyhQbk0RrcjM?=
 =?us-ascii?Q?8GKAejlPO0/74rN3noc/5C3dg4H0gViJyFkbYPZRvmyhEMLjvq8sQm/DJAg/?=
 =?us-ascii?Q?+nkNdxTnif6flZD2xyQHzdtGY2yc3ARHVUl96udn4RSxmvwAqFr6JFKim8Hq?=
 =?us-ascii?Q?EEFz/zX7m1vMMhSWQG8/mqu8IRO5dMRblhTOcgGnSazCAMR0dihKR8xPRqnX?=
 =?us-ascii?Q?29FWoGVvXIXrp8jcAVdChsmXjflI2yn7BBg8X8CUXcVZet3To767Fe6na5+i?=
 =?us-ascii?Q?SJrHaKky1c/jS8qkJ2ReOG8vy33MK1XcBaPqefigMCQ9TzxQbicl1kwXFSyi?=
 =?us-ascii?Q?gzxJ13OKA8Y8GRrD8Bx+aQjZg/XTBQ9yn31EQTJQaODtuETLFI36ilEr9Tui?=
 =?us-ascii?Q?7E8vqvjG8PEoA2Yd9VebXhR6Yj21VkV0BgnKPDKqOp/nBaiwaq+Xh0MnWUP7?=
 =?us-ascii?Q?j4PH8wHWw+CiEoJAfSdSk8es8peWzEHsElZWG3xvuWTz8YGJvstaQYIsp94w?=
 =?us-ascii?Q?iaX8BQm+tVOmChi1wDMKN5UFQnccLh3o1d6kzfS9rVNAcWoDy4adAOecZYAu?=
 =?us-ascii?Q?Ia5qRZ3cSyj4MKFMQG9uzxG5s4tg5xyzWHcmmFE+2ULFnxJcgur1aM5gK2y5?=
 =?us-ascii?Q?Qr+H26Gon3SG/vuxPNg39YqbvP0DjkYtgHdJaQhvUPHZSKOVk5BPjbTNtHHb?=
 =?us-ascii?Q?v/HVWHbIV5V0hXzKAoNiHOdGkAVKjXRyFwWGG7q+laXtmdaMk4dtwywCD5FN?=
 =?us-ascii?Q?T/cj4gPwwbOQpiEo8AiIDBxsSq/Ucic9LllRkV0ya0bkPgwBdadyhuUYV/Eg?=
 =?us-ascii?Q?Oju6A4K8ghywiJtGaMGtIwx6ExGnEh1ABRSNylSBHwzsT4R8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca48d4c9-0ff8-4928-bc4f-08de6492e17b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 08:45:14.3663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rj9kn+2pM4QGUUYVGlWLd0QMQFsUWHP3EDR7YWOksQTEFwh95Zbx7HzGHNNocI2BTdQyMw0yBfaDl20glxenUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
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

Hi Stephen,

Thanks for the comments. What do you mean by missing release notes? Should =
I add some description of the new conversion type? It will not break the cu=
rrent usage of any user.
So do you mean I should let the user know that they can do the inline calcu=
lation with the new API?

Thanks

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday, November 18, 2025 1:25 AM
> To: Bing Zhao <bingz@nvidia.com>
> Cc: Slava Ovsiienko <viacheslavo@nvidia.com>; dev@dpdk.org; Raslan
> Darawsheh <rasland@nvidia.com>; Ori Kam <orika@nvidia.com>; Dariusz
> Sosnowski <dsosnowski@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>;
> Matan Azrad <matan@nvidia.com>; NBU-Contact-Thomas Monjalon (EXTERNAL)
> <thomas@monjalon.net>
> Subject: Re: [PATCH 1/2] lib/ethdev: support inline calculating masked
> item value
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, 17 Nov 2025 09:54:07 +0200
> Bing Zhao <bingz@nvidia.com> wrote:
>=20
> > diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c index
> > fe8f43caff..b94f0e304d 100644
> > --- a/lib/ethdev/rte_flow.c
> > +++ b/lib/ethdev/rte_flow.c
> > @@ -831,6 +831,8 @@ rte_flow_conv_action_conf(void *buf, const size_t
> size,
> >   *   RTE_FLOW_ITEM_TYPE_END is encountered.
> >   * @param[out] error
> >   *   Perform verbose error reporting if not NULL.
> > + * @param[in] with_mask
> > + *   If true, @p src mask will be applied to spec and last.
> >   *
> >   * @return
> >   *   A positive value representing the number of bytes needed to store
>=20
> Sorry, this patch is submitted too late to make it into 25.11 release.
> Missing any release note.
>=20
> This would be a good example of where to use API versioning in a later
> release.
