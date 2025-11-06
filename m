Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D8FCCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 07:31:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21ADA40A7D;
	Thu,  6 Nov 2025 08:31:14 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by mails.dpdk.org (Postfix) with ESMTP id 498084013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 08:31:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/5M6snBnn/sl90Piklv5SaCHvqxlJkH/tZxxXoZBJKfVTu0RSlZUFqQExkEcknsM9UpAiJJ0vFBM7Oiu4OOiqjRo2AWxc4bSRbopvZoyKZKXyCYnb+n8C8jwITmR9m+vhVJamd3lXT1BMeDHP4J5Eg3hVQWKSAtWs+gUjdDp12IImusvL+JDIA0LuUp5NrbyTFc1Srwj7LkxweD68vi8wY1bx++hgviZBtHR1hHrC3DjFb3murPqmLdYV+OfhFZD630Ioj2vKTQOkqWEUxC/HEFOtS8OWSr0rIbSq2m+ACL1+x7Jx58nlQ66an3umhmXzlXpfr4f1lbO0I82D4vXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXrAqL07SuJG1uqHP99eC5KH3DvAqLO23lL2E4w05dE=;
 b=tEV75UGvEU+J2fYLtoY3A7RH6ITOrggfK/oLM1FVPj5nU7mC+1sDYLoEMwjBHrwB2tHwLwOqSigyYhsXfMpQOMnBadNfkyHiNS+q8LpS+tALaQNfK6K/yLG534kwcadvHNwwzzCn4AbzsnzV/msq7a4eYWI/VwFfrk1NqhioXhPlUs9Hx6rrPNU/yxp5zo1paB4xhXvZz7etliZXDLtDvV6ZnEv28UTetbdCZk2szPtPGYyrQRKS2bmRqWmGLdTKdoWOM609ca/xNwrPIX1fO0cYNuLgeOymmzOY82+pAxtixWXR7V1NA2O4GO22kP2kacdXqkSuv1SuGqZB6HglpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXrAqL07SuJG1uqHP99eC5KH3DvAqLO23lL2E4w05dE=;
 b=NWNnPlSEWXXt//V8HpY5zzLJfVYGkvxSg2T3peYZ3hnsNZrdvYGm7tAfAm/cGC4SKLVr6XVm5crlkhPj5m4pr9HmirGjqhZxzgtI14TatyjBD2l3XGOakZEN402d6PeAyix2u7uongEMAu8dTnxqS6zclqZF55j3qIbvrl4h4tLvNDXG95L64uqcwyrnJoG2mRPRXznDpzILtKsv+abjhtsq7RMy+gXEknT8IePdIc5QfY7X0WA290YLIoMP3fO26heDN+eYveDbMX/9vWKVZOsiYeykys1prS2S8Ok/EC6FgplnxV1vNi7Bp9A0TxfJqB1CZ800SNJljdarsiOX2w==
Received: from IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 07:31:03 +0000
Received: from IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7]) by IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7%2]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 07:31:03 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH] net/mlx5: remove representor matching devarg
Thread-Topic: [PATCH] net/mlx5: remove representor matching devarg
Thread-Index: AQHcR3kt9YVSoTCbJky+/H7+7h01ZrTlT5MQ
Date: Thu, 6 Nov 2025 07:31:03 +0000
Message-ID: <IA4PR12MB9763C7AE9DEB41CE9796334AD0C2A@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20251027193558.770297-1-dsosnowski@nvidia.com>
In-Reply-To: <20251027193558.770297-1-dsosnowski@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9763:EE_|CH3PR12MB8536:EE_
x-ms-office365-filtering-correlation-id: 175622bf-758e-4647-ac52-08de1d067108
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?HHQPxoDEXr/grDTMVFG0n0ezr7bCrLWkw45LGT+bzDTC5DwBzM9AdQ0g9FbQ?=
 =?us-ascii?Q?MvWKMsjB5hJYAKMBu4KeL7BM6qUOfbFrC3NXzBA85Xn6OyGiDQIV6bt+tw2z?=
 =?us-ascii?Q?zCb9gzoctN3HPFS3VAEjWObXjQPMQ9pxNO97MwUT292B0I8E1gs2hNMQDFMw?=
 =?us-ascii?Q?fEoJtycghxQdavdffTMNryHuCNOqRExphfePixVJCuxNm6d8ce6eRBTAVaRf?=
 =?us-ascii?Q?CHUdAckrEG91G0iPzeRklqPQqrzJsuaSPma287a8gTVUU7ZmI3t1nXgpqMI0?=
 =?us-ascii?Q?KXaEKqI/a5EaYn71OjqjqF6hv4YxMlIipnG2RHs7QahoD8UQjVUo0zKJvy+j?=
 =?us-ascii?Q?b/EAG3wz2EE+1otMjnpkD0zW5+ok+2LWYV0F1OXDLBTj5VXXu5h5pFqlQ7zp?=
 =?us-ascii?Q?ucqXzHacCJs2Rzf7M8svkMeaddxiDPiZBfG1U0YW1nizHVT7Xrlpt7fPmPCa?=
 =?us-ascii?Q?GgyM+eQDVI/T3Sn7fyjN7cwZ7DqK4TLa2JZYM6aTyhnVcPdjKXI3pGG9zOBi?=
 =?us-ascii?Q?x794u9APJS5qLfm4Hp+a8/Q/naLWjeIAJ6kZGnIQasRmCLLJY7Mgaw/sxWh+?=
 =?us-ascii?Q?YRxXpvbSNt/Q90XvgwisTb/n0/EduTLPQcD39ub1SUjVDOAs5JvFSbk1yySy?=
 =?us-ascii?Q?29oTlOzo6n1hgl/UB8Q+sdgJQC+YBbCmTLPhy2V2b5e+eaaFHv93SdtCkNkW?=
 =?us-ascii?Q?fyLpE0aPq2ATknSb3TpMcyOp2tR3vdNNpnVIixMIYwwtZrElB/N5GYPRbZn+?=
 =?us-ascii?Q?iDBDU0QBkOU3ZTBV9HTuOiMjU7kCiLL5yUyPnqzkWmm+K2HgmhF2VyZWbEeG?=
 =?us-ascii?Q?ak52Sbr8z/QGOyrXSG5szCUybBlKS61pLHN3QIPioNVTBEx8QEpUBLw/u3fa?=
 =?us-ascii?Q?DUwp+UnShYpEc4fZYmvKUpe1bFDP9QbJgm+uTuJzj2jZwOcn+rY7lBKdNuKi?=
 =?us-ascii?Q?qdycdSh2GHPiZX5q6zukng80Fmqb0N+DvpD1dI1zsGVFHRng6DzwI2D3MMna?=
 =?us-ascii?Q?3T6kQtTJt+uGDkBNnifNAJbNoMACJ2s0PEKJKucQgHAwMbi1PEt6DxrP8CQt?=
 =?us-ascii?Q?2WqAGdlm4dyGdecXAD2SGBAV72WITGXegEGzBkBIuY4PH1P2Ugo1pLesV8c0?=
 =?us-ascii?Q?zJJTuM7tff9uxy5wRabhpmqpC+TZGg3thb3Jt/4iflI2mWAMRFTdXI+D6rV+?=
 =?us-ascii?Q?lUavtsOMms0h6GuU0TYhI6Nkxzejt2HCjR96nBmUv3YRra3jcEISe/bK9Njt?=
 =?us-ascii?Q?ke0aWUTyu6HdatWMH7IZsmRZRtwuz9huewP0OJEZYZVAtsHNbJwIoMos4xPK?=
 =?us-ascii?Q?iONuXGxD/+6RpVQiiV6SY7tbslMLY4s3d++p1w3dqar2X5kexVez0dDmuxky?=
 =?us-ascii?Q?L4pAvF19v2WqwXpyIEFxXrVXXIOp3vacLoxfHfGG0f/riaKAHf40OjLpYIfE?=
 =?us-ascii?Q?AP2g2kgYDBe9tAMQbZWUlVkQTG1P7Jp13Dir9/j7d4Hdbpg1skPiA2u0RDlZ?=
 =?us-ascii?Q?MqJ8i3XCWXrNSx0/CGUQZlg+pk1neUq1Ii1S?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Q8s88B2GUHNTiT00+jM5tgPCiqOxwhzDlwNgXqafYTago68bs+4St45N0C6?=
 =?us-ascii?Q?3BVXl7e7FmGlxgumM/xDbSymFdF0zw6tmh4X9xC+aTYJ4UTcWDgTPxYgsp15?=
 =?us-ascii?Q?HCaS3C2estPwJHj3i7HHhSEfMU28cvdIxSnxGKJaYWiejb+bCErJ3Q6LdlUz?=
 =?us-ascii?Q?l1LDMZRtu76ho0m0tvuYxHXV2tnCOQIYvbRrDzlYgyMUJAqoW3tyVZTPpXW8?=
 =?us-ascii?Q?l4yvxZO2uL+YYIQN9OwWYtF/MP2SeJ+W7E5rdOLixGpBC5jmOWZJrsNFNLZk?=
 =?us-ascii?Q?kl6qDRA+bsiAYr+5ACRHzlbRc85Ul9M1j6IZMHpD2QQ6Nl36UUlc/6HlP9uH?=
 =?us-ascii?Q?yPhoSiolr1R4mjUkYxvhOoXLU5tN8b/LBmD6qf749R7UeVJjnAJuW4aUdkqr?=
 =?us-ascii?Q?L06Ts8IO+aqCCQc/ASaijg9MoLLd+12wV4vUDwIg6bZVPxhJBs5HcpGTPCH5?=
 =?us-ascii?Q?5F0MPuzNbcYwh+Tv3mkZ7+/SnphTjllv8lhLKeUoILIEGIBFoqsmgZSlu+Nq?=
 =?us-ascii?Q?WQVAu6+Aw4boViu0NKaPr9i/ol8Dsxdo4YdDJvPjHe/2nciGMFz3N45h34YB?=
 =?us-ascii?Q?LcbH0fx8m60ZLNpTlEAywsi94Tkrp/gGd3J1TfQa8bwifPsoNhfBCqP0rrwA?=
 =?us-ascii?Q?zdsPU1S9De2IGYVu7Ak5VaK69ogiwNUvrQD9pzlWzZ7uo8c5DK2nu5G4gjvP?=
 =?us-ascii?Q?hokgSf2aG3r4GfDx2PEIBpEFl1/qcN7+XtiMv5BaGGte+JVlXyU58HQVhOUq?=
 =?us-ascii?Q?N8a2lLwp3S49zTrDSYEDkSdjHYXncL4iMbNwxPJQUVTGnW5zdBrKSpSOa57L?=
 =?us-ascii?Q?eX12GfAJhKVeR0BB61LSRxr4u16UW6naUXJsl33xgrYAx8WhromW9cX3H3++?=
 =?us-ascii?Q?SnqaeSqvriVTjnTQcAJYWjn4nLC3PsdbAhb99MdWwq9Hz/cJTxkoo93jlA+t?=
 =?us-ascii?Q?3Tc/cg86X9M0zBB1fD2i7vPNdRZtJ6EduMtj1PPZuGJ2gmXf+xXh6H+wER0A?=
 =?us-ascii?Q?VOldZl6SfN5CaFBO0BDfEYagDAMKPMrwK+O9rnNiA/4Sj4WzEc0VDGinTvvS?=
 =?us-ascii?Q?6PiubeBa8yy4kuy2GkfbiVNI3C/BOqKyKgVqDBOdmz+9hE1dkyAdWhyrYQ9v?=
 =?us-ascii?Q?HqnpdR/ZVsu6oe83KlNlc7pSfTgn/hvZR7Iur9ioJV+KEpOApbBwV9Jk1SCC?=
 =?us-ascii?Q?DuK7ntdkrsvR6ojS7bTlcMqjDBpJvkFrVCz5IcFtlEetnZhEu15TYcqFebff?=
 =?us-ascii?Q?r8VtDpvsKgFq+YZiQTv8Nhl+/SKfqb8aXAL3uv9h5cG0+vFK18WY/OxLrT40?=
 =?us-ascii?Q?m2GTrvQhekbqWlioA6liE6C94N/TTYRUCvE3f9b51lisXdigdcYCBnuc1NQT?=
 =?us-ascii?Q?zE1OPsYUJJfA39vlIdSC86vEMb39Kf/jfMkScyMyplENUVOYV5atUtECcT2s?=
 =?us-ascii?Q?NpIfWHXloDAGYm7o1WCzRCl6LBhOq/85AmaEVEL13/7/IzHoGmrTc/7x7GO8?=
 =?us-ascii?Q?XP8YsGtj2NoJYwcMIyJQ6iqGRRug4XMgxEGDa5Ye/AravegB1Z3vXrNE0jN4?=
 =?us-ascii?Q?oxeUq6zTlaY0qMslV10=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175622bf-758e-4647-ac52-08de1d067108
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 07:31:03.6330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nm0qS1SZ27ueHOJCoy2Y5NTA2f/ClDRHwWjupe+U04JKOnZJcb1xJsmR6J5a43wls/nfnxAdpJCgv6wcEMc/nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
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

Hi,

> -----Original Message-----
> From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Sent: Tuesday, October 28, 2025 3:36 AM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; NBU-Contact-Thomas Monjalon (EXTERNAL)
> <thomas@monjalon.net>; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH] net/mlx5: remove representor matching devarg
>=20
> As announced in 25.07 release deprecation notice [1], this patch removes
> repr_matching_en device argument from mlx5 driver.
>=20
> Applications which disabled this option were able to receive traffic from
> any physical port/VF/SF on any representor.
> Specifically, in most cases, this was used to process all traffic on
> representor which is a transfer proxy port.
> Similar behavior in mlx5 PMD can be achieved without the use of additiona=
l
> device arguments, by using RTE_FLOW_ACTION_TYPE_RSS flow action in
> transfer flow rules.
>=20
> [1] https://doc.dpdk.org/guides-25.07/rel_notes/deprecation.html
>=20
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
>  doc/guides/nics/mlx5.rst               |  26 +--
>  doc/guides/rel_notes/deprecation.rst   |  11 -
>  doc/guides/rel_notes/release_25_11.rst |   8 +
>  drivers/net/mlx5/linux/mlx5_os.c       |  16 --
>  drivers/net/mlx5/mlx5.c                |  13 --
>  drivers/net/mlx5/mlx5.h                |   1 -
>  drivers/net/mlx5/mlx5_flow.c           |   5 +-
>  drivers/net/mlx5/mlx5_flow.h           |   4 -
>  drivers/net/mlx5/mlx5_flow_hw.c        | 266 +------------------------
>  drivers/net/mlx5/mlx5_trigger.c        |  20 +-
>  drivers/net/mlx5/mlx5_txq.c            |   3 +-
>  11 files changed, 19 insertions(+), 354 deletions(-)
>=20
> diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst index
> 20056f61d6..d248f5a6c3 100644
> --- a/doc/guides/nics/mlx5.rst
> +++ b/doc/guides/nics/mlx5.rst
> @@ -744,24 +744,6 @@ for an additional list of options shared with other
> mlx5 drivers.
>=20
>      <Primary_PCI_BDF>,representor=3Dpf[0,1]vf[0-2]
>=20
> -- ``repr_matching_en`` parameter [int]
> -
> -  - 0. If representor matching is disabled, then there will be no
> implicit
> -    item added. As a result, ingress flow rules will match traffic
> -    coming to any port, not only the port on which flow rule is created.
> -    Because of that, default flow rules for ingress traffic cannot be
> created
> -    and port starts in isolated mode by default. Port cannot be switched
> back
> -    to non-isolated mode.
> -
> -  - 1. If representor matching is enabled (default setting),
> -    then each ingress pattern template has an implicit REPRESENTED_PORT
> -    item added. Flow rules based on this pattern template will match
> -    the vport associated with port on which rule is created.
> -
> -  .. note::
> -
> -     This parameter is deprecated and will be removed in future releases=
.
> -
>  - ``max_dump_files_num`` parameter [int]
>=20
>    The maximum number of files per PMD entity that may be created for
> debug information.
> @@ -2342,7 +2324,6 @@ Runtime configuration
>=20
>  The behaviour of port representors is configured  with
> some :ref:`parameters <mlx5_representor_params>`.
> -The option ``repr_matching_en`` has an impact on flow steering.
>=20
>  Limitations
>  ^^^^^^^^^^^
> @@ -2352,9 +2333,6 @@ Limitations
>  #. A driver limitation for ``RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR``
> action
>     restricts the ``port_id`` configuration to only accept the value
> ``0xffff``,
>     indicating the E-Switch manager.
> -   If the ``repr_matching_en`` parameter is enabled, the traffic will be
> directed
> -   to the representor of the source virtual port (SF/VF), while if it is
> disabled,
> -   the traffic will be routed based on the steering rules in the ingress
> domain.
>=20
>  Examples
>  ^^^^^^^^
> @@ -3183,8 +3161,8 @@ Limitations
>=20
>  #. Only single item is supported per pattern template.
>=20
> -#. In switch mode, when ``repr_matching_en`` is enabled (default
> setting),
> -   matching ``RTE_FLOW_ITEM_TYPE_COMPARE`` is not supported for
> ``ingress`` rules.
> +#. In switch mode, ``RTE_FLOW_ITEM_TYPE_COMPARE`` flow item
> +   is not supported for ``ingress`` rules.
>     This is because an implicit ``RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT``
>     needs to be added to the matcher,
>     which conflicts with the single item limitation.
> diff --git a/doc/guides/rel_notes/deprecation.rst
> b/doc/guides/rel_notes/deprecation.rst
> index 1e60ac4e82..8653d6ca03 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -147,14 +147,3 @@ Deprecation Notices
>    This change will not result in any feature loss,
>    as the fallback scalar paths which have feature parity with SSE
>    will be used in the cases where the SSE paths would have been used.
> -
> -* net/mlx5: ``repr_matching_en`` device argument is deprecated
> -  and will be removed in DPDK 25.11 release.
> -  With disabled representor matching, behavior of Rx datapath in mlx5 PM=
D
> -  is incompatible with current DPDK representor model.
> -  Packets from any E-Switch port can arrive on any representor,
> -  depending only on created flow rules.
> -  Such working model should be exposed directly in DPDK ethdev API,
> -  without relying on flow API.
> -  Currently there is no alternative API
> -  providing the same functionality as with ``repr_matching_en`` set to 0=
.
> diff --git a/doc/guides/rel_notes/release_25_11.rst
> b/doc/guides/rel_notes/release_25_11.rst
> index c5ba335cfc..ce2d72a411 100644
> --- a/doc/guides/rel_notes/release_25_11.rst
> +++ b/doc/guides/rel_notes/release_25_11.rst
> @@ -197,6 +197,14 @@ Removed Items
>    the functions ``rte_tel_data_add_array_u64`` and
> ``rte_tel_data_add_dict_u64`` are removed.
>    They are replaced by ``rte_tel_data_add_array_uint`` and
> ``rte_tel_data_add_dict_uint`` respectively.
>=20
> +* net/mlx5: ``repr_matching_en`` device argument has been removed.
> +  Applications which disabled this option were able to receive traffic
> +  from any physical port/VF/SF on any representor.
> +  Specifically, in most cases, this was used to process all traffic on
> +representor
> +  which is a transfer proxy port.
> +  Similar behavior in mlx5 PMD can be achieved without the use of
> +additional device arguments,
> +  by using ``RTE_FLOW_ACTION_TYPE_RSS`` flow action in transfer flow
> rules.
> +
>=20
>  API Changes
>  -----------
> diff --git a/drivers/net/mlx5/linux/mlx5_os.c
> b/drivers/net/mlx5/linux/mlx5_os.c
> index 8d11b1ac3a..83d3051fb8 100644
> --- a/drivers/net/mlx5/linux/mlx5_os.c
> +++ b/drivers/net/mlx5/linux/mlx5_os.c
> @@ -1777,22 +1777,6 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
>  			err =3D EINVAL;
>  			goto error;
>  		}
> -		/*
> -		 * If representor matching is disabled, PMD cannot create
> default flow rules
> -		 * to receive traffic for all ports, since implicit source
> port match is not added.
> -		 * Isolated mode is forced.
> -		 */
> -		if (priv->sh->config.dv_esw_en && !priv->sh-
> >config.repr_matching) {
> -			err =3D mlx5_flow_isolate(eth_dev, 1, NULL);
> -			if (err < 0) {
> -				err =3D -err;
> -				goto error;
> -			}
> -			DRV_LOG(WARNING, "port %u ingress traffic is restricted
> to defined "
> -					 "flow rules (isolated mode) since
> representor "
> -					 "matching is disabled",
> -				eth_dev->data->port_id);
> -		}
>  		eth_dev->data->dev_flags |=3D RTE_ETH_DEV_FLOW_OPS_THREAD_SAFE;
>  		return eth_dev;
>  #else
> diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c index
> b018a4f0e2..0504fc2366 100644
> --- a/drivers/net/mlx5/mlx5.c
> +++ b/drivers/net/mlx5/mlx5.c
> @@ -182,9 +182,6 @@
>  /* HW steering counter's query interval. */  #define
> MLX5_HWS_CNT_CYCLE_TIME "svc_cycle_time"
>=20
> -/* Device parameter to control representor matching in ingress/egress
> flows with HWS. */ -#define MLX5_REPR_MATCHING_EN "repr_matching_en"
> -
>  /*
>   * Alignment of the Tx queue starting address,
>   * If not set, using separate umem and MR for each TxQ.
> @@ -1435,8 +1432,6 @@ mlx5_dev_args_check_handler(const char *key, const
> char *val, void *opaque)
>  		config->cnt_svc.service_core =3D tmp;
>  	} else if (strcmp(MLX5_HWS_CNT_CYCLE_TIME, key) =3D=3D 0) {
>  		config->cnt_svc.cycle_time =3D tmp;
> -	} else if (strcmp(MLX5_REPR_MATCHING_EN, key) =3D=3D 0) {
> -		config->repr_matching =3D !!tmp;
>  	} else if (strcmp(MLX5_TXQ_MEM_ALGN, key) =3D=3D 0) {
>  		config->txq_mem_algn =3D (uint32_t)tmp;
>  	}
> @@ -1477,7 +1472,6 @@ mlx5_shared_dev_ctx_args_config(struct
> mlx5_dev_ctx_shared *sh,
>  		MLX5_FDB_DEFAULT_RULE_EN,
>  		MLX5_HWS_CNT_SERVICE_CORE,
>  		MLX5_HWS_CNT_CYCLE_TIME,
> -		MLX5_REPR_MATCHING_EN,
>  		MLX5_TXQ_MEM_ALGN,
>  		NULL,
>  	};
> @@ -1500,7 +1494,6 @@ mlx5_shared_dev_ctx_args_config(struct
> mlx5_dev_ctx_shared *sh,
>  	config->fdb_def_rule =3D 1;
>  	config->cnt_svc.cycle_time =3D MLX5_CNT_SVC_CYCLE_TIME_DEFAULT;
>  	config->cnt_svc.service_core =3D rte_get_main_lcore();
> -	config->repr_matching =3D 1;
>  	config->txq_mem_algn =3D log2above(alignment);
>  	if (mkvlist !=3D NULL) {
>  		/* Process parameters. */
> @@ -1535,11 +1528,6 @@ mlx5_shared_dev_ctx_args_config(struct
> mlx5_dev_ctx_shared *sh,
>  			config->dv_xmeta_en);
>  		config->dv_xmeta_en =3D MLX5_XMETA_MODE_LEGACY;
>  	}
> -	if (config->dv_flow_en !=3D 2 && !config->repr_matching) {
> -		DRV_LOG(DEBUG, "Disabling representor matching is valid only "
> -			       "when HW Steering is enabled.");
> -		config->repr_matching =3D 1;
> -	}
>  	if (config->tx_pp && !sh->dev_cap.txpp_en) {
>  		DRV_LOG(ERR, "Packet pacing is not supported.");
>  		rte_errno =3D ENODEV;
> @@ -1594,7 +1582,6 @@ mlx5_shared_dev_ctx_args_config(struct
> mlx5_dev_ctx_shared *sh,
>  	DRV_LOG(DEBUG, "\"allow_duplicate_pattern\" is %u.",
>  		config->allow_duplicate_pattern);
>  	DRV_LOG(DEBUG, "\"fdb_def_rule_en\" is %u.", config->fdb_def_rule);
> -	DRV_LOG(DEBUG, "\"repr_matching_en\" is %u.", config-
> >repr_matching);
>  	DRV_LOG(DEBUG, "\"txq_mem_algn\" is %u.", config->txq_mem_algn);
>  	return 0;
>  }
> diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h index
> 07418b0922..44ceb76c08 100644
> --- a/drivers/net/mlx5/mlx5.h
> +++ b/drivers/net/mlx5/mlx5.h
> @@ -397,7 +397,6 @@ struct mlx5_sh_config {
>  	uint32_t lro_allowed:1; /* Whether LRO is allowed. */
>  	/* Allow/Prevent the duplicate rules pattern. */
>  	uint32_t fdb_def_rule:1; /* Create FDB default jump rule */
> -	uint32_t repr_matching:1; /* Enable implicit vport matching in HWS
> FDB. */
>  	uint32_t txq_mem_algn; /* logarithm value of the TxQ address
> alignment. */
>  	struct {
>  		uint16_t service_core;
> diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
> index 1de398982a..a612f1f7cf 100644
> --- a/drivers/net/mlx5/mlx5_flow.c
> +++ b/drivers/net/mlx5/mlx5_flow.c
> @@ -8793,10 +8793,7 @@ mlx5_flow_isolate(struct rte_eth_dev *dev,
>  				   "port must be stopped first");
>  		return -rte_errno;
>  	}
> -	if (!enable && !priv->sh->config.repr_matching)
> -		return rte_flow_error_set(error, ENOTSUP,
> RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> -					  "isolated mode cannot be disabled when "
> -					  "representor matching is disabled");
> +
>  	priv->isolated =3D !!enable;
>  	if (enable)
>  		dev->dev_ops =3D &mlx5_dev_ops_isolate; diff --git
> a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h index
> ff61706054..9bca014fc6 100644
> --- a/drivers/net/mlx5/mlx5_flow.h
> +++ b/drivers/net/mlx5/mlx5_flow.h
> @@ -3007,9 +3007,6 @@ struct mlx5_flow_hw_ctrl_fdb {
>  	struct rte_flow_pattern_template *port_items_tmpl;
>  	struct rte_flow_actions_template *jump_one_actions_tmpl;
>  	struct rte_flow_template_table *hw_esw_zero_tbl;
> -	struct rte_flow_pattern_template *tx_meta_items_tmpl;
> -	struct rte_flow_actions_template *tx_meta_actions_tmpl;
> -	struct rte_flow_template_table *hw_tx_meta_cpy_tbl;
>  	struct rte_flow_pattern_template *lacp_rx_items_tmpl;
>  	struct rte_flow_actions_template *lacp_rx_actions_tmpl;
>  	struct rte_flow_template_table *hw_lacp_rx_tbl; @@ -3582,7 +3579,6
> @@ int mlx5_flow_hw_esw_create_sq_miss_flow(struct rte_eth_dev *dev,  int
> mlx5_flow_hw_esw_destroy_sq_miss_flow(struct rte_eth_dev *dev,
>  					  uint32_t sqn);
>  int mlx5_flow_hw_esw_create_default_jump_flow(struct rte_eth_dev *dev); =
-
> int mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev
> *dev);  int mlx5_flow_hw_tx_repr_matching_flow(struct rte_eth_dev *dev,
> uint32_t sqn, bool external);  int mlx5_flow_hw_lacp_rx_flow(struct
> rte_eth_dev *dev);  int mlx5_flow_actions_validate(struct rte_eth_dev
> *dev, diff --git a/drivers/net/mlx5/mlx5_flow_hw.c
> b/drivers/net/mlx5/mlx5_flow_hw.c index 491a78a0de..f5f73b38cd 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -5305,7 +5305,7 @@ __translate_group(struct rte_eth_dev *dev,
>  						  "group index not supported");
>  		*table_group =3D group + 1;
>  	} else if (config->dv_esw_en &&
> -		   (config->repr_matching || config->dv_xmeta_en =3D=3D
> MLX5_XMETA_MODE_META32_HWS) &&
> +		   config->dv_xmeta_en =3D=3D MLX5_XMETA_MODE_META32_HWS &&
>  		   external &&
>  		   flow_attr->egress) {
>  		/*
> @@ -8549,7 +8549,7 @@ __flow_hw_pattern_validate(struct rte_eth_dev *dev,
>  			break;
>  		}
>  		case RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT:
> -			if (attr->ingress && priv->sh->config.repr_matching)
> +			if (attr->ingress)
>  				return rte_flow_error_set(error, EINVAL,
>  						  RTE_FLOW_ERROR_TYPE_ITEM, NULL,
>  						  "represented port item cannot be
> used"
> @@ -9024,14 +9024,12 @@ flow_hw_pattern_template_create(struct rte_eth_de=
v
> *dev,
>  		return NULL;
>  	orig_item_nb =3D rc;
>  	if (priv->sh->config.dv_esw_en &&
> -	    priv->sh->config.repr_matching &&
>  	    attr->ingress && !attr->egress && !attr->transfer) {
>  		copied_items =3D flow_hw_prepend_item(items, orig_item_nb,
> &port, error);
>  		if (!copied_items)
>  			return NULL;
>  		tmpl_items =3D copied_items;
>  	} else if (priv->sh->config.dv_esw_en &&
> -		   priv->sh->config.repr_matching &&
>  		   !attr->ingress && attr->egress && !attr->transfer) {
>  		if (item_flags & MLX5_FLOW_ITEM_SQ) {
>  			DRV_LOG(DEBUG, "Port %u omitting implicit REG_C_0 match
> for egress "
> @@ -9979,7 +9977,6 @@ flow_hw_setup_tx_repr_tagging(struct rte_eth_dev
> *dev, struct rte_flow_error *er
>  	};
>=20
>  	MLX5_ASSERT(priv->sh->config.dv_esw_en);
> -	MLX5_ASSERT(priv->sh->config.repr_matching);
>  	priv->hw_tx_repr_tagging_pt =3D
>  		flow_hw_create_tx_repr_sq_pattern_tmpl(dev, error);
>  	if (!priv->hw_tx_repr_tagging_pt)
> @@ -10158,46 +10155,6 @@ flow_hw_create_ctrl_port_pattern_template(struct
> rte_eth_dev *dev,
>  	return flow_hw_pattern_template_create(dev, &attr, items, error);  }
>=20
> -/*
> - * Creating a flow pattern template with all ETH packets matching.
> - * This template is used to set up a table for default Tx copy (Tx
> metadata
> - * to REG_C_1) flow rule usage.
> - *
> - * @param dev
> - *   Pointer to Ethernet device.
> - * @param error
> - *   Pointer to error structure.
> - *
> - * @return
> - *   Pointer to flow pattern template on success, NULL otherwise.
> - */
> -static struct rte_flow_pattern_template * -
> flow_hw_create_tx_default_mreg_copy_pattern_template(struct rte_eth_dev
> *dev,
> -						     struct rte_flow_error *error)
> -{
> -	struct rte_flow_pattern_template_attr tx_pa_attr =3D {
> -		.relaxed_matching =3D 0,
> -		.egress =3D 1,
> -	};
> -	struct rte_flow_item_eth promisc =3D {
> -		.hdr.dst_addr.addr_bytes =3D { 0x00, 0x00, 0x00, 0x00, 0x00,
> 0x00 },
> -		.hdr.src_addr.addr_bytes =3D { 0x00, 0x00, 0x00, 0x00, 0x00,
> 0x00 },
> -		.hdr.ether_type =3D 0,
> -	};
> -	struct rte_flow_item eth_all[] =3D {
> -		[0] =3D {
> -			.type =3D RTE_FLOW_ITEM_TYPE_ETH,
> -			.spec =3D &promisc,
> -			.mask =3D &promisc,
> -		},
> -		[1] =3D {
> -			.type =3D RTE_FLOW_ITEM_TYPE_END,
> -		},
> -	};
> -
> -	return flow_hw_pattern_template_create(dev, &tx_pa_attr, eth_all,
> error);
> -}
> -
>  /*
>   * Creating a flow pattern template with all LACP packets matching, only
> for NIC
>   * ingress domain.
> @@ -10419,90 +10376,6 @@ flow_hw_create_ctrl_port_actions_template(struct
> rte_eth_dev *dev,
>  	return flow_hw_actions_template_create(dev, &attr, actions_v,
> actions_m, error);  }
>=20
> -/*
> - * Creating an actions template to use header modify action for register
> - * copying. This template is used to set up a table for copy flow.
> - *
> - * @param dev
> - *   Pointer to Ethernet device.
> - * @param error
> - *   Pointer to error structure.
> - *
> - * @return
> - *   Pointer to flow actions template on success, NULL otherwise.
> - */
> -static struct rte_flow_actions_template * -
> flow_hw_create_tx_default_mreg_copy_actions_template(struct rte_eth_dev
> *dev,
> -						     struct rte_flow_error *error)
> -{
> -	struct rte_flow_actions_template_attr tx_act_attr =3D {
> -		.egress =3D 1,
> -	};
> -	const struct rte_flow_action_modify_field mreg_action =3D {
> -		.operation =3D RTE_FLOW_MODIFY_SET,
> -		.dst =3D {
> -			.field =3D (enum
> rte_flow_field_id)MLX5_RTE_FLOW_FIELD_META_REG,
> -			.tag_index =3D REG_C_1,
> -		},
> -		.src =3D {
> -			.field =3D (enum
> rte_flow_field_id)MLX5_RTE_FLOW_FIELD_META_REG,
> -			.tag_index =3D REG_A,
> -		},
> -		.width =3D 32,
> -	};
> -	const struct rte_flow_action_modify_field mreg_mask =3D {
> -		.operation =3D RTE_FLOW_MODIFY_SET,
> -		.dst =3D {
> -			.field =3D (enum
> rte_flow_field_id)MLX5_RTE_FLOW_FIELD_META_REG,
> -			.level =3D UINT8_MAX,
> -			.tag_index =3D UINT8_MAX,
> -			.offset =3D UINT32_MAX,
> -		},
> -		.src =3D {
> -			.field =3D (enum
> rte_flow_field_id)MLX5_RTE_FLOW_FIELD_META_REG,
> -			.level =3D UINT8_MAX,
> -			.tag_index =3D UINT8_MAX,
> -			.offset =3D UINT32_MAX,
> -		},
> -		.width =3D UINT32_MAX,
> -	};
> -	const struct rte_flow_action_jump jump_action =3D {
> -		.group =3D 1,
> -	};
> -	const struct rte_flow_action_jump jump_mask =3D {
> -		.group =3D UINT32_MAX,
> -	};
> -	const struct rte_flow_action actions[] =3D {
> -		[0] =3D {
> -			.type =3D RTE_FLOW_ACTION_TYPE_MODIFY_FIELD,
> -			.conf =3D &mreg_action,
> -		},
> -		[1] =3D {
> -			.type =3D RTE_FLOW_ACTION_TYPE_JUMP,
> -			.conf =3D &jump_action,
> -		},
> -		[2] =3D {
> -			.type =3D RTE_FLOW_ACTION_TYPE_END,
> -		},
> -	};
> -	const struct rte_flow_action masks[] =3D {
> -		[0] =3D {
> -			.type =3D RTE_FLOW_ACTION_TYPE_MODIFY_FIELD,
> -			.conf =3D &mreg_mask,
> -		},
> -		[1] =3D {
> -			.type =3D RTE_FLOW_ACTION_TYPE_JUMP,
> -			.conf =3D &jump_mask,
> -		},
> -		[2] =3D {
> -			.type =3D RTE_FLOW_ACTION_TYPE_END,
> -		},
> -	};
> -
> -	return flow_hw_actions_template_create(dev, &tx_act_attr, actions,
> -					       masks, error);
> -}
> -
>  /*
>   * Creating an actions template to use default miss to re-route packets
> to the
>   * kernel driver stack.
> @@ -10616,43 +10489,6 @@ flow_hw_create_ctrl_sq_miss_table(struct
> rte_eth_dev *dev,
>  	return flow_hw_table_create(dev, &cfg, &it, 1, &at, 1, error);  }
>=20
> -/*
> - * Creating the default Tx metadata copy table on NIC Tx group 0.
> - *
> - * @param dev
> - *   Pointer to Ethernet device.
> - * @param pt
> - *   Pointer to flow pattern template.
> - * @param at
> - *   Pointer to flow actions template.
> - * @param error
> - *   Pointer to error structure.
> - *
> - * @return
> - *   Pointer to flow table on success, NULL otherwise.
> - */
> -static struct rte_flow_template_table*
> -flow_hw_create_tx_default_mreg_copy_table(struct rte_eth_dev *dev,
> -					  struct rte_flow_pattern_template *pt,
> -					  struct rte_flow_actions_template *at,
> -					  struct rte_flow_error *error)
> -{
> -	struct rte_flow_template_table_attr tx_tbl_attr =3D {
> -		.flow_attr =3D {
> -			.group =3D 0, /* Root */
> -			.priority =3D MLX5_HW_LOWEST_PRIO_ROOT,
> -			.egress =3D 1,
> -		},
> -		.nb_flows =3D 1, /* One default flow rule for all. */
> -	};
> -	struct mlx5_flow_template_table_cfg tx_tbl_cfg =3D {
> -		.attr =3D tx_tbl_attr,
> -		.external =3D false,
> -	};
> -
> -	return flow_hw_table_create(dev, &tx_tbl_cfg, &pt, 1, &at, 1,
> error);
> -}
> -
>  /**
>   * Creates a control flow table used to transfer traffic
>   * from group 0 to group 1.
> @@ -10718,15 +10554,6 @@ flow_hw_cleanup_ctrl_fdb_tables(struct
> rte_eth_dev *dev)
>  	if (hw_ctrl_fdb->lacp_rx_items_tmpl)
>  		claim_zero(flow_hw_pattern_template_destroy(dev, hw_ctrl_fdb-
> >lacp_rx_items_tmpl,
>  			   NULL));
> -	/* Clean up templates used for default Tx metadata copy. */
> -	if (hw_ctrl_fdb->hw_tx_meta_cpy_tbl)
> -		claim_zero(flow_hw_table_destroy(dev, hw_ctrl_fdb-
> >hw_tx_meta_cpy_tbl, NULL));
> -	if (hw_ctrl_fdb->tx_meta_actions_tmpl)
> -		claim_zero(flow_hw_actions_template_destroy(dev, hw_ctrl_fdb-
> >tx_meta_actions_tmpl,
> -			   NULL));
> -	if (hw_ctrl_fdb->tx_meta_items_tmpl)
> -		claim_zero(flow_hw_pattern_template_destroy(dev, hw_ctrl_fdb-
> >tx_meta_items_tmpl,
> -			   NULL));
>  	/* Clean up templates used for default FDB jump rule. */
>  	if (hw_ctrl_fdb->hw_esw_zero_tbl)
>  		claim_zero(flow_hw_table_destroy(dev, hw_ctrl_fdb-
> >hw_esw_zero_tbl, NULL)); @@ -10813,8 +10640,6 @@
> flow_hw_create_ctrl_tables(struct rte_eth_dev *dev, struct rte_flow_error
> *error  {
>  	struct mlx5_priv *priv =3D dev->data->dev_private;
>  	struct mlx5_flow_hw_ctrl_fdb *hw_ctrl_fdb;
> -	uint32_t xmeta =3D priv->sh->config.dv_xmeta_en;
> -	uint32_t repr_matching =3D priv->sh->config.repr_matching;
>  	uint32_t fdb_def_rule =3D priv->sh->config.fdb_def_rule;
>=20
>  	MLX5_ASSERT(priv->hw_ctrl_fdb =3D=3D NULL); @@ -10900,32 +10725,6 @@
> flow_hw_create_ctrl_tables(struct rte_eth_dev *dev, struct rte_flow_error
> *error
>  			goto err;
>  		}
>  	}
> -	/* Create templates and table for default Tx metadata copy flow
> rule. */
> -	if (!repr_matching && xmeta =3D=3D MLX5_XMETA_MODE_META32_HWS) {
> -		hw_ctrl_fdb->tx_meta_items_tmpl =3D
> -
> 	flow_hw_create_tx_default_mreg_copy_pattern_template(dev, error);
> -		if (!hw_ctrl_fdb->tx_meta_items_tmpl) {
> -			DRV_LOG(ERR, "port %u failed to Tx metadata copy
> pattern"
> -				" template for control flows", dev->data-
> >port_id);
> -			goto err;
> -		}
> -		hw_ctrl_fdb->tx_meta_actions_tmpl =3D
> -
> 	flow_hw_create_tx_default_mreg_copy_actions_template(dev, error);
> -		if (!hw_ctrl_fdb->tx_meta_actions_tmpl) {
> -			DRV_LOG(ERR, "port %u failed to Tx metadata copy
> actions"
> -				" template for control flows", dev->data-
> >port_id);
> -			goto err;
> -		}
> -		hw_ctrl_fdb->hw_tx_meta_cpy_tbl =3D
> -			flow_hw_create_tx_default_mreg_copy_table
> -				(dev, hw_ctrl_fdb->tx_meta_items_tmpl,
> -				 hw_ctrl_fdb->tx_meta_actions_tmpl, error);
> -		if (!hw_ctrl_fdb->hw_tx_meta_cpy_tbl) {
> -			DRV_LOG(ERR, "port %u failed to create table for
> default"
> -				" Tx metadata copy flow rule", dev->data-
> >port_id);
> -			goto err;
> -		}
> -	}
>  	/* Create LACP default miss table. */
>  	if (!priv->sh->config.lacp_by_user && priv->pf_bond >=3D 0 && priv-
> >master) {
>  		hw_ctrl_fdb->lacp_rx_items_tmpl =3D
> @@ -12105,7 +11904,7 @@ __flow_hw_configure(struct rte_eth_dev *dev,
>  		if (!priv->hw_tag[i])
>  			goto err;
>  	}
> -	if (priv->sh->config.dv_esw_en && priv->sh->config.repr_matching) {
> +	if (priv->sh->config.dv_esw_en) {
>  		ret =3D flow_hw_setup_tx_repr_tagging(dev, error);
>  		if (ret)
>  			goto err;
> @@ -16003,63 +15802,6 @@ mlx5_flow_hw_esw_create_default_jump_flow(struct
> rte_eth_dev *dev)
>  					items, 0, actions, 0, &flow_info, false);  }
>=20
> -int
> -mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev *dev) -=
{
> -	struct mlx5_priv *priv =3D dev->data->dev_private;
> -	struct rte_flow_item_eth promisc =3D {
> -		.hdr.dst_addr.addr_bytes =3D { 0x00, 0x00, 0x00, 0x00, 0x00,
> 0x00 },
> -		.hdr.src_addr.addr_bytes =3D { 0x00, 0x00, 0x00, 0x00, 0x00,
> 0x00 },
> -		.hdr.ether_type =3D 0,
> -	};
> -	struct rte_flow_item eth_all[] =3D {
> -		[0] =3D {
> -			.type =3D RTE_FLOW_ITEM_TYPE_ETH,
> -			.spec =3D &promisc,
> -			.mask =3D &promisc,
> -		},
> -		[1] =3D {
> -			.type =3D RTE_FLOW_ITEM_TYPE_END,
> -		},
> -	};
> -	struct rte_flow_action_modify_field mreg_action =3D {
> -		.operation =3D RTE_FLOW_MODIFY_SET,
> -		.dst =3D {
> -			.field =3D (enum
> rte_flow_field_id)MLX5_RTE_FLOW_FIELD_META_REG,
> -			.tag_index =3D REG_C_1,
> -		},
> -		.src =3D {
> -			.field =3D (enum
> rte_flow_field_id)MLX5_RTE_FLOW_FIELD_META_REG,
> -			.tag_index =3D REG_A,
> -		},
> -		.width =3D 32,
> -	};
> -	struct rte_flow_action copy_reg_action[] =3D {
> -		[0] =3D {
> -			.type =3D RTE_FLOW_ACTION_TYPE_MODIFY_FIELD,
> -			.conf =3D &mreg_action,
> -		},
> -		[1] =3D {
> -			.type =3D RTE_FLOW_ACTION_TYPE_JUMP,
> -		},
> -		[2] =3D {
> -			.type =3D RTE_FLOW_ACTION_TYPE_END,
> -		},
> -	};
> -	struct mlx5_ctrl_flow_info flow_info =3D {
> -		.type =3D MLX5_CTRL_FLOW_TYPE_TX_META_COPY,
> -	};
> -
> -	MLX5_ASSERT(priv->master);
> -	if (!priv->dr_ctx ||
> -	    !priv->hw_ctrl_fdb ||
> -	    !priv->hw_ctrl_fdb->hw_tx_meta_cpy_tbl)
> -		return 0;
> -	return flow_hw_create_ctrl_flow(dev, dev,
> -					priv->hw_ctrl_fdb->hw_tx_meta_cpy_tbl,
> -					eth_all, 0, copy_reg_action, 0, &flow_info,
> false);
> -}
> -
>  int
>  mlx5_flow_hw_tx_repr_matching_flow(struct rte_eth_dev *dev, uint32_t sqn=
,
> bool external)  { @@ -16091,8 +15833,6 @@
> mlx5_flow_hw_tx_repr_matching_flow(struct rte_eth_dev *dev, uint32_t sqn,
> bool e
>  		.tx_repr_sq =3D sqn,
>  	};
>=20
> -	/* It is assumed that caller checked for representor matching. */
> -	MLX5_ASSERT(priv->sh->config.repr_matching);
>  	if (!priv->dr_ctx) {
>  		DRV_LOG(DEBUG, "Port %u must be configured for HWS, before
> creating "
>  			       "default egress flow rules. Omitting creation.",
> diff --git a/drivers/net/mlx5/mlx5_trigger.c
> b/drivers/net/mlx5/mlx5_trigger.c index 916ac03c16..343fb844ad 100644
> --- a/drivers/net/mlx5/mlx5_trigger.c
> +++ b/drivers/net/mlx5/mlx5_trigger.c
> @@ -1132,9 +1132,9 @@ mlx5_hw_representor_port_allowed_start(struct
> rte_eth_dev *dev)
>  		rte_errno =3D EAGAIN;
>  		return -rte_errno;
>  	}
> -	if (priv->sh->config.repr_matching && !priv->dr_ctx) {
> -		DRV_LOG(ERR, "Failed to start port %u: with representor
> matching enabled, port "
> -			     "must be configured for HWS", dev->data->port_id);
> +	if (priv->dr_ctx =3D=3D NULL) {
> +		DRV_LOG(ERR, "Failed to start port %u: port must be configured
> for HWS",
> +			dev->data->port_id);
>  		rte_errno =3D EINVAL;
>  		return -rte_errno;
>  	}
> @@ -1606,18 +1606,6 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
>  	unsigned int i;
>  	int ret;
>=20
> -	/*
> -	 * With extended metadata enabled, the Tx metadata copy is handled
> by default
> -	 * Tx tagging flow rules, so default Tx flow rule is not needed. It
> is only
> -	 * required when representor matching is disabled.
> -	 */
> -	if (config->dv_esw_en &&
> -	    !config->repr_matching &&
> -	    config->dv_xmeta_en =3D=3D MLX5_XMETA_MODE_META32_HWS &&
> -	    priv->master) {
> -		if (mlx5_flow_hw_create_tx_default_mreg_copy_flow(dev))
> -			goto error;
> -	}
>  	for (i =3D 0; i < priv->txqs_n; ++i) {
>  		struct mlx5_txq_ctrl *txq =3D mlx5_txq_get(dev, i);
>  		uint32_t queue;
> @@ -1633,7 +1621,7 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
>  				goto error;
>  			}
>  		}
> -		if (config->dv_esw_en && config->repr_matching) {
> +		if (config->dv_esw_en) {
>  			if (mlx5_flow_hw_tx_repr_matching_flow(dev, queue,
> false)) {
>  				mlx5_txq_release(dev, i);
>  				goto error;
> diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
> index b090d8274d..cd831f9728 100644
> --- a/drivers/net/mlx5/mlx5_txq.c
> +++ b/drivers/net/mlx5/mlx5_txq.c
> @@ -1453,8 +1453,7 @@ rte_pmd_mlx5_external_sq_enable(uint16_t port_id,
> uint32_t sq_num)
>  			sq_miss_created =3D true;
>  		}
>=20
> -		if (priv->sh->config.repr_matching &&
> -		    mlx5_flow_hw_tx_repr_matching_flow(dev, sq_num, true)) {
> +		if (mlx5_flow_hw_tx_repr_matching_flow(dev, sq_num, true)) {
>  			if (sq_miss_created)
>  				mlx5_flow_hw_esw_destroy_sq_miss_flow(dev,
> sq_num);
>  			return -rte_errno;
> --
> 2.39.5


Acked-by: Bing Zhao <bingz@nvidia.com>
