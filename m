Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C02109C04D
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 18:12:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33B1E406BC;
	Wed, 25 Mar 2026 19:12:09 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0]) by mails.dpdk.org (Postfix) with ESMTP id 11A58402CE
 for <dev@dpdk.org>; Wed, 25 Mar 2026 19:12:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGCekosZp2UQY8SIIDIU+ZUQWPfG2WTz9wUY/ZrJozBFgYkeea1iGZEwnYR9e/UeEd7sK/RF2sVmKjTbdQ2cuDN7Ygi7DEdrHsPjJ2SCGGVeGFuI2AxvnsIGCq3QWbLUKOGyQrTLFHgqCEZy45NYXX6Boz3LxRg9AOR+gmjtCoP4FkBn5rFJWc1Wu2W8zvScaWrsHvPiVnpJhXqVf0Q17l3GHJsJUXQeXjAMqco5Pn1fVXvzIR05xKKLgSXPA77Yt11wcIz5rHodQt9s5bPf7NOVx2sEGBvlJZ7VRVE5soCFQoVB5SerqEIN42Yw31kaYQSE6zVmfAREkBgHhjHRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlB/ez6EalyEjhpd4qnxNAif2OdUD+VugYRQVWXJklg=;
 b=tdSL7jJPTKUiH/YaSTTQ74NJm1RSgyDE/zBetTjXaMv1ypoCqVdf0s1FJDOIL7V9RSNzwE9AVzbMeXaEDfnsTa7Hxi/kBjqECXYd/EiC9Wie2y96s0RpdFBx1wLBn+k5d9k9lM1ll7N1/ymRDX2Zjt87dNkINybcsB1olm4EsIcIHzA5NP65Eqp3s004j3AAuo9hz4Tm77gBwtbvQpGwmkgmI5LxwctPZ0c+Hlc+v/F90fmM9oxeFLDpFR0bWbaKQ1xjPabgV4lVuZfBVDfdGvGGCy1iFJKmiGgZGVyaxoLLzZLAgwGKP9gPY/vHy1t08c/EuK50sHm0o5Mt6XRMRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlB/ez6EalyEjhpd4qnxNAif2OdUD+VugYRQVWXJklg=;
 b=eNBggv3xNkZtex66/SerVdkofOgkAGNwHog42vHL9aVar3Mm1VG22BmDTyxkLc37pfSy0UoSer2g/Xtq4FiMyOTakMw0o/Wwk98M284JEgV/F8gSCmHhGLXY2kA/KLzGFRu1XAVJpaydwnsxybOWg9kfG+P8NUwYtUZPtORG3HYr9izJFQPTEPjgmcmjLo+vkbcNsQUk5XYU6kgtktB1aXqLTh5Cg+/ZhFSuaV3QVKrVQ0k7bQDKxzGPMeicYxkpCivQs7ygWxOPMqidsDBWyqEPo6Rn7uwyV3mnQhcG5P/sl3X33I+i9kdNN9KeEvwy8FEIgF+kIAbbmNAf6iCtiw==
Received: from CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21)
 by CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 18:12:03 +0000
Received: from CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::1085:eeb0:9e9d:837]) by CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::1085:eeb0:9e9d:837%5]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 18:12:03 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Aman Singh <aman.deep.singh@intel.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>, Raslan
 Darawsheh <rasland@nvidia.com>, Adrian Schollmeyer
 <a.schollmeyer@syseleven.de>
Subject: RE: [PATCH v2 1/2] app/testpmd: assign share group dynamically
Thread-Topic: [PATCH v2 1/2] app/testpmd: assign share group dynamically
Thread-Index: AQHcu69bxSllauY0YUWSh+us4PH+PbW/d6QAgAAWsaA=
Date: Wed, 25 Mar 2026 18:12:02 +0000
Message-ID: <CH2PR12MB95419AD28C51E7C6A993869CA449A@CH2PR12MB9541.namprd12.prod.outlook.com>
References: <20260324123709.3471-1-dsosnowski@nvidia.com>
 <20260324165657.23945-1-dsosnowski@nvidia.com>
 <20260324165657.23945-2-dsosnowski@nvidia.com>
 <20260325095038.76ae5740@phoenix.local>
In-Reply-To: <20260325095038.76ae5740@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9541:EE_|CH8PR12MB9741:EE_
x-ms-office365-filtering-correlation-id: cf044192-129a-4bfc-406c-08de8a9a040d
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: vgu/yPJK9ckaZi7nNePepL9WeH9/01nrVDjHQT9Jh32Ot2cMe7HoTlFSlZiFqpcNCEFbDBmDPzO6UJN+9P1uYt15cT+/fwMVx8PJ76a1NM+51L8OvosuFbQUULqRQvN7jXxrLo6MtUcBgrkGlSXYZWwPXGPstvi7hLB5FFWy5vop3FkUWKvpHVrmivvoto1PMkutgRTCdgj9UumZNyNyfeol/zY9y7kmvXviMS3wFYg4qcT4NrqTNOYdZFhA/vL2/A4lJ5nJ569SliooUR3kM8Lx95Py2XGmd5o54gKiFwOqh7szghF7L11Huli18PbA8ei+ilsq/Pinh71ZvD99sdjuJDajJo3hebSph4WzcW+w1xOar3YzpEcfeJPUjsz+9biQhULrPnNN7+Zzek+ky9nnsk3dBMVNQl7MPnVQpaZJHUrzxXPrMyhn7mQp28MnKad6Dc919RzA8Nt1sAxi5vQF4pFx1v9WawLxNAFosGk/v34D9XSL7K/fsydX4g3t7IekJxEp3J0M+4rb+sj/2BYeb1uYSiejCCzg7UXgQ12Yumg1MwsI+5Ys4xHkv7prRR18bU5vssGecNL8ltVQrIKlYKVpaGLch1zxrTfl1AP1tFRHU9k6+Plag9hQfB2CQV07jKaMl7mTF8WkUnUZ+fOyP3gxPoq3wNDXVf7bwYwDpOIhWW8s1wm50Z8RlGdmU5I51KMNrmbav5kQBiQoWHi1OrBRlKNF5jQoTPm0uJGuYG+EQGpexFHDzkXrVx5imQWOsPx4VJG8Co8ER7+KcFEtp5D5b0cuL0dgSK6vWzY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9541.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hU+yeOg9azECoIZatjNGkBl1zO50iKcqFAaSP4doLEcTWYAorvRnX+a8gIuK?=
 =?us-ascii?Q?z9IK7MrEQXbcpVn431zdC4OGaoYWfqOJbMofcwJujQnTqsw6qRkYrp5jQ11+?=
 =?us-ascii?Q?mvmlGYtCtmKb124HxDK1NJb0N39+7OvjINAnou+JcZZzCKqyGEQ5pJEA1lNY?=
 =?us-ascii?Q?xM762ZwJIhJHWblrvBhlkbcdRlBct7UjZa5fWJcsY+m43Gzib1AOIKaR+m4h?=
 =?us-ascii?Q?jU/BuqslbnY9/6Gi7NwINyUTVKEgb1vCjeGSMU9QO4WRcppR3bq80dkpJfcd?=
 =?us-ascii?Q?G96DZaUB6KL+QlEU+ZBmPENeJHKL2ihtuyQ7AsBe7lD4ooY/QdpEa6Ba5OG8?=
 =?us-ascii?Q?XWgELAi4oVsy3cXavAad7wlPHTDP1/uJ/EALNPCFJrm2sc7tVkh/bpwJwMbP?=
 =?us-ascii?Q?PL/SZE+mHCBrLrvFJ0zZdWs0+frmkn3fsL0CvMX1CSFXUNr1yZXzjE1nHgEK?=
 =?us-ascii?Q?Dafvgnang2BUaD+7gJXUfaQvdE9PP/8hJDtqLihSagAYdy60NXGZuHpvQRMr?=
 =?us-ascii?Q?VWnCZYoHsfb4o/vrxeVdy9BE6oqrbc5FhCejI5LlATOUAlR3lMlJsNhUGYX6?=
 =?us-ascii?Q?zL6q01N5folqYRjE6lwAjVPsUh4m4FODDNzCeOGXsy7ijP8JxSIqedy7lUCj?=
 =?us-ascii?Q?bv8Qs6syfQ5aBH5UrButMAu2SPpq0u9wlmN5FgGbUUfghH96nGKvfZ8/6HA7?=
 =?us-ascii?Q?yWsBjINiuC7j+hpgZ1QcUzhnhhj8B3tSO24GxAiJoBqKiD6UYq/OpYIUgCGC?=
 =?us-ascii?Q?OD9hyprdE8dfCBdM5vjSieFqgmbj+mO7wlHYSOnyN2Gl/0fFEM/xrGP5Ht7a?=
 =?us-ascii?Q?lIm1B3KWNWtDQ3seMQz/FaxMdem9BMQI8+QvlUhtz8teXgtBX+Jn3DLHjQzs?=
 =?us-ascii?Q?XAkVykdcaMhuO+OiyPf3h3G9Tor+VzVufvLWGw5+adrdKTZYfk1wMa5IlA83?=
 =?us-ascii?Q?lrlRlcR9PTR9clMF92bPElEJU+UiGssn3WLFzxNOvdNjz8Sz5B2pOctdNgsB?=
 =?us-ascii?Q?/ylb6Ad5J77s8XU1z6b3fKL5OEmTiN1/nl3nCy/gCbpXyZr+C1TUQb7yBZVx?=
 =?us-ascii?Q?5duP9MuzE6d8ASz4XQuBvb9VThQCjQxBZaBtPX3GfK2Q08cc5jnGhMkF3ea6?=
 =?us-ascii?Q?tVrO44NRDsYVLv5Vb9GS4xQXV9gju/7nVfKwqz1SeZv3ToIM8ZqlF+SUBqxk?=
 =?us-ascii?Q?4iG7fKwgkVskUmNNgXSlZpKfGgx3kffj3U/6Zr25h8UpLhJr6RKoBito4PEe?=
 =?us-ascii?Q?0cURUtp251uVIYSyPrys0Z+5QV/ZkwEjbdoE3g4knQwAHOdvSl+emyongoSE?=
 =?us-ascii?Q?Q0anWSXDiRN2JKCh90ljJ4BTHLVU6IsL4CgFR1wLpu0q4fDkhzwUDGS9kMgV?=
 =?us-ascii?Q?UhQYTBM/FWCIYO2H2hcQwmf/+t4wLaQp3cJabSzD7dpdL0uBTAojARFjl31L?=
 =?us-ascii?Q?DYfzbPPmd5eSjIjjZjPpf5i6j5gdRkcXSb1b/Yt4lTTmZKjZG622PbUtZjN4?=
 =?us-ascii?Q?08V5tKmkZiYHN6v4gkyUrktBAwdCzzy7KgGVC5mhdIorIZUtwcXNN41gnSdd?=
 =?us-ascii?Q?qloDfosbtdbuTefkvlbLCfKAiSGZtd5RLvecZkAsjbSmKezVQ+o4X9kKl2fJ?=
 =?us-ascii?Q?sSLWEQ2VStFum3I+McQ0ImxtY+PLi58hiuojYJ6ZOH9IcQHpVVecEAcN5y7r?=
 =?us-ascii?Q?KAnFZKrTZCdkYUwE2QNtIgeCu8t5blRmJWgafqsM1ZRdj8+POUepyffVaza3?=
 =?us-ascii?Q?ZrxV/N3uQA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf044192-129a-4bfc-406c-08de8a9a040d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 18:12:02.9966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMEXpV7d/jyFFIF9Egtk5+RZ9GHTwhDMqmwPMBL43iHqBZqZOMOeWX2gpkQXH3hagNGuoc0z0xT3p1fr+WOZEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9741
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday, March 25, 2026 5:51 PM
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Cc: Aman Singh <aman.deep.singh@intel.com>; dev@dpdk.org; NBU-
> Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>; Raslan
> Darawsheh <rasland@nvidia.com>; Adrian Schollmeyer
> <a.schollmeyer@syseleven.de>
> Subject: Re: [PATCH v2 1/2] app/testpmd: assign share group dynamically
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, 24 Mar 2026 17:56:56 +0100
> Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
>=20
> > +     /*
> > +      * testpmd assigns all queues on a given port to single share gro=
up.
> > +      * There are RTE_MAX_ETHPORTS share group slots,
> > +      * so at least one should always be available.
> > +      */
> > +     RTE_ASSERT(first_free < RTE_DIM(share_group_slots));
> > +
>=20
> Since RTE_ASSERT is compiled away in normal builds, this is a noop.
> Please use a regular if statement and error handling.

Fixed in v3.

Best regards,
Dariusz Sosnowski
