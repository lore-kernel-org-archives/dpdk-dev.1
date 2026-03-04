Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FD6D58E4D
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 07:27:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1199B40269;
	Wed,  4 Mar 2026 08:27:03 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1EAB140265
 for <dev@dpdk.org>; Wed,  4 Mar 2026 08:27:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtW9AFkjrRm3aXlMCHdQJ6yjnGGGJXInktG5xu7HLHw+5giR/YE3Je2JH/e47UCt7gm+LS6ozmtNIcQ2Vkg6uh36/ahYEvjAsJFIPl1KS2nKXbGlD75l8CWRBFYVlX9J8llJ5nAk/lhvhMIBvbCgklyhZ+0JFwhWaeSa0y0w8R0oVRznosBozI5mBeiYcNRzgShMFXEYHZDkK3XSP9Wpo0UTUwsndOn/7ZYOHs5Nvg7AjM1BW7jBlPOgTuVTmOKw9vubaSJOGJzQ+65v1Yg4ZKa20ZbWLS+NLluVzSr+Ja+/SY36tEKnIHlMyONFeIT2LclvCPLtky2n3aveM+SZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtB92AddUasJY5AvSyNQBJqrpQtZU/tfZ6D1GJWMWK0=;
 b=jIlTSfN/rfMnLY53OToEBsLfUxK9BX1s4KfGYtL1ayIMxGYe0RxypmEUcV0KlQViRQu0GceVWYkB7mdAhr9w3l0tz44qa2mgHTrelIP75XNn2HuMHrIjtiYlBDgDFfd5QbF6/7awxOyK8cmT2kEt8bSN6VbYu71Fv2JAlF0BFV/fkInaB3lWW7hELaJ1+sBWtKOXs1PTrjrq3eQy4dkNiHRupuFNWqf5BLW0J6ceqJ/27C6CQJlSXpaAd0AFyOok3ouDnaAA4BFQ+07J3+HEFYrdbzkp7DgRm0OhksfOwAeRO8pfXyq8RnPqi0i4b8tbOKDeua/6F164je7fOBNdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtB92AddUasJY5AvSyNQBJqrpQtZU/tfZ6D1GJWMWK0=;
 b=PwAdKvQdmBsULm4/PakTXJ0TvJJfOrZi0ScMNGYSdp/H360wRFaIZ1CIJ3/8W5+v5LwKX4myvcADvgcNuJ9Sxf0uiOMasLiJaXExd9FRrYv4kWXYrfUpneNqHxpPbBYI/AsZYYOv18FgIvZkGrL3MVXvhtlzDyzK4mEw2ebB2SiZxekrByzrbHWqdd9AdSaEeZHb9p5bZ0I+hU3HX+IQtZ+U1WavvbXMSvHjHorPSJpuygFUJOnwTqYQs3rsf0mvp9MPkKPAbRDCCUd0C7uJ6m8XrzI/GFTIR9QZXJdwhwdzkc7LSdlPB+AXJ0jV/VPfjer4SH0HgPobiMNSvNNfwg==
Received: from IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 07:26:58 +0000
Received: from IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::3d3c:bcd3:d413:7f7b]) by IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::3d3c:bcd3:d413:7f7b%3]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 07:26:57 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH 0/5] net/mlx5: add BlueField socket direct support
Thread-Topic: [PATCH 0/5] net/mlx5: add BlueField socket direct support
Thread-Index: AQHcqjin/PGcmm9Q1Ue9+noJOSlnQbWd+7kA
Date: Wed, 4 Mar 2026 07:26:57 +0000
Message-ID: <IA4PR12MB976381AA36EABE0C20DD5030D07CA@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20260302113443.16648-1-dsosnowski@nvidia.com>
In-Reply-To: <20260302113443.16648-1-dsosnowski@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9763:EE_|IA1PR12MB8077:EE_
x-ms-office365-filtering-correlation-id: ac427f98-b9cd-4a27-3020-08de79bf6b29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: sQkd8z7vxhODMM1IRJLeXeYjmAkmDt3r8NFQ70vXJJ33Op/yRKE+mxzsNYeCo1u/vWjkbBFk/4j0OaubchN9/kLDfxxhbA+hp7qk/TE0Id/3H1gI/IBNOmuy1OltL540Fprs6O5xaktR+d9gFxfg7exODYrC2ZdVxO00ejP72RjHRZIquP5NOP0PSzTgB/vgUr1XLjnI9T3PpMRd3yVsr7uyfoMYPo6EvzV5ngG3+Z7yossFTpfrqXMo1SZzWt6UogKb4lDwPV8q/svFVJOqqz6CEPPFaN8Xz78kYcJGXtD1zZ92qWqib4ZjhMGZkRYRleb8T0DTZAVc69z1LZcV5vDmsaAbs+zdKglrh79JCrqAk0hZMywVZ9vYN5Ajk21fbNqcv/sjxTtpzw5izMaLsJIjquDWhrBLOy7S2wxZplegeufdG6NTXyakqUExz3GhSz/9cFMsQ2I2oo48zv0oUgWb0Vz+pvhrifcpBNlhId9vp85t2crwiFW9TPDpYKbhlygInJYnnK/Lmg3JH2uVT5nGaXk71ceWQizKsJBrPX5YUlKzj+/DUPxnFnmVFvl9pX9YyJ6DpGfjQWAkHpunBgjIfDJ0Hu0rN68/Vqpy9j2ASMXXkGx0SBgdSaLoC3/NHY5seRjRenHP9fFMC4IjFLRbktFti5ec6CgkbegM4Xj0JOCyksrYi61kpTcXXKIMeNfqyAinrNMHhRKheIDyuEC02lgNIQW0YCd1A0S7jBqtP3Ohj5lGvogId+OaCK2W6RuZHtbtH8KBozFHU8u1Q/Tg227F45IKcHxzY656eNc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zY3oBRZXLfFZ7uK0ZGGJ/vGekoe0GZ9yUoAB0Wbwrt7DgIQ344UlASGPilvG?=
 =?us-ascii?Q?bDEo4xwR0ivL1kNHuA7/swmepzcWxwGKbPpVudqedWt+ovpbqX/QLYYtSWpX?=
 =?us-ascii?Q?FAi988ZBvQ+hqNgHkAtpfaDxf3L/l7zeChit+HRf2NJSQIlS5qWly4vzXvws?=
 =?us-ascii?Q?iZMQQU0dpNeQ7evpnXGWMWjDQ3GXwoBRfOiVuTNNFB3bVumKyEyTQhUbpHLw?=
 =?us-ascii?Q?7VehxEE95oFW1qiAQ7+Z5WSM3j0Pam3TJ66Iq72TRGARZ2bq4gGPJrH7NrRp?=
 =?us-ascii?Q?cM21/5IqBjPlqERVmb6LpuJeTghKk3xqYI5uVSH/QGZFGAsrJKMv4Q8FrzgV?=
 =?us-ascii?Q?FXOLtl8mO35fB2KUpmTggwsHgaezsg7hX1S5TNOiBOsZeQTLxI/LypfMA46r?=
 =?us-ascii?Q?O/CV9zX1m9zZGz5jKq7CnIUVkekTWLGmwOfMItWVQdDdm1JUXZP+BKoiZ+wV?=
 =?us-ascii?Q?kfRia+t48c8kjFKrt5VgmsmwVXp3R2vU5ALAOUNnNhJyZ+sx3cIMFuia3d0t?=
 =?us-ascii?Q?zrpl1A6Hca5LzOMQSncetoKuyD+cXw1LJ05YLbTqJkx1huB5EDq1QKvgbEL0?=
 =?us-ascii?Q?styfybmH0O2ca9/vMV3Rv8rEgIZyyrg7m0eMbNRUHDqUjI3259wMCrD9/O/o?=
 =?us-ascii?Q?Al9rFMWQO8j9edPt3hhMv8Z4HG3LC4wK67xd5YRCfnXZbKJ8CSkWZMowTYy/?=
 =?us-ascii?Q?i8kGh9u9mk//wpDAnrYViJumALLIRH4ckpDKSAXThGbLZQMhUtA6NYdPRk8j?=
 =?us-ascii?Q?1wHgATehV9szyC9m/IXiNmcgkKeeClefUb8f4g2w3hoLvwMzpti3EHZPWX7Z?=
 =?us-ascii?Q?EQaDFQQkv+kf7RmDUpz//e+15TOjkETAiBPNiLdFIt6AX4XXzTZx4PouCAsY?=
 =?us-ascii?Q?WtBsZsQjJWiGkw+q1G0MkvfKPB6wyFtH37nbs9oU5XcqjU4cx1JDFjavqpIB?=
 =?us-ascii?Q?XyVkZULOBpk4RRILv64Y9qlAf+oHzOQ+a9gBiXSF0ppAB1aH2DifZmAAn5In?=
 =?us-ascii?Q?ZVqw+olXYBOeii6giKUmJ7k3Ef3gQz/Sjsikunizo81CzjzfxKWwKKSwDZAz?=
 =?us-ascii?Q?cBaJplPd5TaSPQC0TKp16vBKiAC34pmqAEZGYubHgPfFUYOOB3b02tbCTtx1?=
 =?us-ascii?Q?hDCT0U4HwYNS1T9BkRuWldJlImX44w4PYibjDtxNg4Cef+lfDaDqlT+66+1Y?=
 =?us-ascii?Q?9B4BkgwmKGxc3W2cck+xPKJd5AO4TZIMSpFULPcdXd1D0qmQgZZ4LSGA2oSb?=
 =?us-ascii?Q?E7vEkza0A0VbT06dtGdXYHhv6c2vFJOVreZPgXPc9qAc4czSs+5aFHkt8zVt?=
 =?us-ascii?Q?g90gZsT+SPQKPv01UNtLv7fxf5dO8Hp/umYcQuMp40vwIDVdDcO2S3xe8G9T?=
 =?us-ascii?Q?BPEDMBtBbDZu/sH7d/OhBGC2DSY3GSadv/Sckxeawr78Fo6sNPOC0z3q0hne?=
 =?us-ascii?Q?LxfNR1nNxsQHq03V0cjt+SzwnxunSm67l/rjJ19scHdyNUyO6P1ErSRb74XJ?=
 =?us-ascii?Q?pckLMRaJnwIJcqc1GdKg/V+bHplJ1qHi7T65Vgph6eDc95f76BghlEG3Nq9R?=
 =?us-ascii?Q?OzyO6waLaKEwpsGPxdxDA5VLywgnpk86/VqoOsmByXWXQXnykwX/wj0/reaZ?=
 =?us-ascii?Q?QAgcX825So9YVLocGxT7phSKPqO/54q+PoqN1+g5ewnGK7bbD282HALQ5sgI?=
 =?us-ascii?Q?z2XqtADVVeXA443ZQ2C9vv9qiHqWdZikEN3hwlv9pkkQqyb/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac427f98-b9cd-4a27-3020-08de79bf6b29
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 07:26:57.6236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FC5XJxYbX10spoOGDXGCxsCVlqVv5WGD/Ub3Axht5jZDz9R51rJP+OG4nNXMkPZCbw+hB8QualuRXxt3zWu81A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077
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
> Sent: Monday, March 2, 2026 7:35 PM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH 0/5] net/mlx5: add BlueField socket direct support
>=20
> Goal of this patchset is to prepare probing logic in mlx5 networking PMD
> for support of BlueField DPUs with Socket Direct.
> In such use case, BlueField DPU will be connected through PCI to 2
> different CPUs on the host.
> Each host CPU sees 2 PFs.
> Each PF is connected to one of the physical ports.
>=20
>     +--------+               +--------+
>     |CPU 0   |               |CPU 1   |
>     |        |               |        |
>     |    pf0 |               |    pf0 |
>     |        |               |        |
>     |    pf1 |               |    pf1 |
>     |        |               |        |
>     +---+----+               +-+------+
>         |                      |
>         |                      |
>         |                      |
>         +----+           +-----+
>              |           |
>              |           |
>              |           |
>          +---+-----------+----+
>          |BF3 DPU             |
>          |                    |
>          | pf0hpf      pf1hpf |
>          |                    |
>          | pf2hpf      pf3hpf |
>          |                    |
>          |  p0          p1    |
>          +------+------+------+
>          | phy0 |      | phy1 |
>          +------+      +------+
>=20
>=20
> On BlueField DPU ARM Linux netdevs map to PFs/ports as follows:
>=20
> - p0 and p1 to physical ports 0 and 1 respectively,
> - pf0hpf and pf2hpf to CPU0 pf0 and CPU1 pf0 respectively,
> - pf1hpf and pf3hpf to CPU0 pf1 and CPU1 pf1 respectively.
>=20
> There are several possible ways to use such a setup:
>=20
> - Single E-Switch (embedded switch) per each CPU PF to
>   physical port connection.
> - Shared E-Switch for related CPU PFs:
>     - For example, both pf0hpf and pf2hpf are in the same E-Switch domain=
.
> - Multiport E-Switch.
>     - All host PFs and physical ports are in the same E-Switch domain.
>=20
> When a DPDK application would be run on BlueField ARM it should be
> possible for application to probe all the relevant representors
> (corresponding to available netdevs).
> Using testpmd syntax users will be able to do the following:
>=20
>     # Probe both physical ports
>     port attach 03:00.0,dv_flow_en=3D2,representor=3Dpf0-1
>=20
>     # Probe both host PF 0 from CPU 0
>     # (VF representor index -1 is special encoding for host PF)
>     port attach 03:00.0,dv_flow_en=3D2,representor=3Dpf0vf65535
>     # or with explicit controller index
>     port attach 03:00.0,dv_flow_en=3D2,representor=3Dc1pf0vf65535
>=20
>     # Probe both host PF 0 from CPU 1
>     port attach 03:00.0,dv_flow_en=3D2,representor=3Dpf2vf65535
>     # or with explicit controller index
>     port attach 03:00.0,dv_flow_en=3D2,representor=3Dc2pf2vf65535
>=20
> Patches overview:
>=20
> - Patch 1 and 2 - Fixes bond detection logic.
>   Previously mlx5 PMD relied on "bond" appearing in IB device name
>   which is not always the case. Moved to sysfs checks for bonding devices=
.
> - Patch 3 - Add calculation of number of physical ports and host PFs.
>   This information will be used to determine
>   how DPDK port name is generated, instead of relying on
>   specific setup type.
> - Patch 4 - Change "representor to IB port" matching logic to directly
>   compare ethdev devargs values to IB port info.
>   Added optional matching on controller index.
> - Patch 5 - Make DPDK port name generation dynamic and dependent on
>   types/number of ports, instead of specific setup type.
>   This allows more generic probing, independent of setup topology.
>=20
> Dariusz Sosnowski (5):
>   common/mlx5: fix bond check
>   net/mlx5: fix bond check
>   net/mlx5: calculate number of uplinks and host PFs
>   net/mlx5: compare representors explicitly
>   net/mlx5: build port name dynamically
>=20
>  drivers/common/mlx5/linux/mlx5_common_os.c |  86 ++++-
>  drivers/common/mlx5/linux/mlx5_common_os.h |   9 +
>  drivers/net/mlx5/linux/mlx5_os.c           | 356 ++++++++++++++-------
>  drivers/net/mlx5/mlx5.h                    |   2 +
>  4 files changed, 338 insertions(+), 115 deletions(-)
>=20
> --
> 2.47.3

Series Acked-by: Bing Zhao <bingz@nvidia.com>

