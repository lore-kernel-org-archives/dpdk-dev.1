Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7B36079AA9
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bFVm5c2/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A04DB402E3;
	Mon,  2 Nov 2026 16:50:25 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by mails.dpdk.org (Postfix) with ESMTPS id 1C76A4028D
 for <dev@dpdk.org>; Mon,  2 Nov 2026 16:50:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PY76GgV0Mwh+U6nSroJMgr29HGdKPDi3JLame0YwmMX66u37qEFtlfHlOC/iM0R7HRfrNYLkiOyDhBWE67NOuKs5wAAiGE0ZWg2TLkZ5u1T1LdJLu+56ODjPU9MSwn2dD/u3Tx28X7pmVOdF+LJ74l2FstUFi8I0G6FzwnktfR3Wi91y8490FZclxB3C2s0CrEUVhRf99IRiHz/7Gf9bCBXox5QEbZd6Z4Q2bu4VgP6ao+d43hULFdKLRSIF2RJyS0zDYYGuf2laW1JqdIFaKkKjf0G8M0LcEjAs27Z78ygLcjbkBZpTxxEVOg/nQ4FfE4V7bPJl1skBnrV0HTEYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBwim/V31CNwU4rklFIfQMUQAdzk8wmNzi5uumPsJTY=;
 b=ZzioNlUqNTK4y33tJkhrX/+IjuygWgi/DP5y7FeHbYlVehqw2GxfbFcgi2d3rOunBNQz2OyB/wbhVprg6Ze7iRsjS+qtIA+UDmtDL3HCkGtCdGbeHdIbZmeja6+oeidos/5g/V3dDkrboyEr3yCQHuqqrjiukklGbllj6Oe66V1VVOd9nymdeIBXrCd5+PrjegOntYQkpIGWDfh0Sn52G/tGfuUYce587ruQJAHwqoF2Xv+4AXG7Cp7eVchFgsZ1MM5gTCt7BXEz1Pg8zjqCW1MX07qY7hppvLgBK9llzc50Wp8YEcReXZ1peXVQOsKmYN3MrdXZT80n2mDCF3VxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBwim/V31CNwU4rklFIfQMUQAdzk8wmNzi5uumPsJTY=;
 b=bFVm5c2/yDvKWt2o+fDU2syXvhT8SnaMJEHyI4AeD1adq7BrpBwyBbHDSoiC/WS62B/tgeWwGKM1zquPMQEQt85v4O34SuNhWpWeFFwo+yLKDE6W+aMpRsZOLjeKBf25pN2bvHO4qTd7gE+JReCxnM4xkhb/HYJpC1imu+JkUj67Cp6ep7oiQ3T0IkDg0ZX4td7hWxjHUDhHXKPXknmK7KNn+v59unUq9EINhI3c8O+SYRoCaUlaXhp2j3U3jfyNmxbGhhAjheaUcO+FL3WCahzT6q0aJ/MV1lDlwx4IX95xdBnBpkn+DBbIy/96m26qyGuXqodOuJVVRBS420NxDg==
Received: from PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7)
 by LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 15:50:19 +0000
Received: from PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033]) by PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 15:50:18 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <tmonjalon@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 00/13] net/mlx5: support nested E-Switch
Thread-Topic: [PATCH 00/13] net/mlx5: support nested E-Switch
Thread-Index: AQHdZWb8av9NJCEGAU+OMq/mYYbFlLca+FTA
Date: Mon, 2 Nov 2026 15:50:18 +0000
Message-ID: <PH0PR12MB70774ADF38B71CAFFE296047A46A2@PH0PR12MB7077.namprd12.prod.outlook.com>
References: <20261026162709.1292958-1-dsosnowski@nvidia.com>
In-Reply-To: <20261026162709.1292958-1-dsosnowski@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7077:EE_|LV2PR12MB6013:EE_
x-ms-office365-filtering-correlation-id: 0f409b7e-7ac4-4fae-a59c-08df38f8fee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|56012099006|11063799006|261021135927099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info: veDIuTlU0WHF6kmBmH8K5cUdzwCHteR9nBNVfdDNZ+FZUp1/27k3JtFl9CmaNVf6uWBM6Ph313vfwTRvDSr91LXPaA0ejgXfOf13lw1PKbs+pb2e+neEak/70Uv0S1B3EOfh3VhVAkcRMwXDuBRbwpEyfPlKe6Mm12HNKnOrrJd4rFPPUIDnnL1zB+ZEswsgXe5aRV917OFtrCeessFBoU4sum7Ru4f1OzCGncdpHgsyZzS4pDKu43dQ20cWcUui+ZyQlzcdjb9uOpAZEe1WzzpUd1c6n7DFvTH+hqpTpuUBR4rQ9XPe54qm9D4Wm1poy5dT6jHVtT/1wP7DHljL+gEz1gR9jZ6vkybBJx/wGp1plluCSRWbMpk/npnJtgZ+Oh762Wbx8TsZ7Wt0jlI+4YyqzUWdgHkw23/f8kZLw1uIcO53uVwXfgAbcfOVBaYUpxcm0r9s/1HBGbxJQ/83bDWpJakdxhdqLHH56uzML+kcMRCFKP40EGjZ0TPeoLALA38C454F0NU/Mg3Xz+RgVRSF8OkdHbyS56dAMFaXutwaPo92VHlx0xlBFNPyKeQqTR+zbB+Q8pW4DIODi/jRiVIWCRCIM0NyAEPu1v8sudxtfYEsdk9rzDhe6RC2STaxVe65sQXamQvUAP6dANVimHUya5WgAWK09ztv/9ssH95k+VJwJFF8JMHiKhC7bpb/+zi5/kPYY5AUvAbZlYOzRMXPQqYRuF5YYqYogDrej+Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7077.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(11063799006)(261021135927099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jfN3zr9VyB2XdcoDcKAmVf3SgtjUQ2+GXNurNfn4i5TaGvZ3+x3WApBt0o/J?=
 =?us-ascii?Q?C+NUwiE/OMjNagBhrCTvi9c67p0MNVcO5HxSK8ktln5m+zEGgrKvmXBHpoLz?=
 =?us-ascii?Q?mafU/J1OJbNYcZYHg2Y5wKRILGWY942/tcUXHHdKXl60/UfcSlB2Q/AwyjI/?=
 =?us-ascii?Q?p/lXlFL77BOxsiVwSLoiXxSeFeKzJswJGgvFMEdd8JumV+ZQeyn41Ug5JshG?=
 =?us-ascii?Q?vcVhiTQmOaIWBd0kRzzi0UsEdNQS69Zu4fDS8Ot7C67qLfq1axvWcobfjo8t?=
 =?us-ascii?Q?KU7wiAb/U1zL6yv3G3g99pTzDc0sTXqlQTyf1/hdJJpm7Jze1lsInM4DG0MK?=
 =?us-ascii?Q?nH+qVwB01LXozsbp9CqYHRtW8AqKiqALKdplbLsqmMQxQPJOUbqXMJ9GgEQV?=
 =?us-ascii?Q?3h/kZNJG/xuejBHWTbVCRayXag6G8SPBB0qy36poU7rc2yolLYssCElc6qQs?=
 =?us-ascii?Q?BrZ1/82BH29+tRDg3ihKXhrGJ5IPYvVTGO2cosZL9rA5wrB/RxuaTXT+xSKe?=
 =?us-ascii?Q?um4S8gFJue7f2+Ns6GLJslgJvQCWE9shRs1cqPHyc3g/hKSpUR2znDjSLWeu?=
 =?us-ascii?Q?25p+faSQKkpi3UEpZa/MCldrl3CHHy8t6ahRE7+XQThhP+RsZAjEpsq46BHT?=
 =?us-ascii?Q?zgyEMfkG0xXSVBFvJpndYkuZLij1PKJR4Gox8Ndq73Atex5lVnPGD09TRplD?=
 =?us-ascii?Q?GO2Lp0g+d17p5zPJ0bL7MF01O+jgyXlyOAvu18+CZPmQmTedLPWH0fCeMak+?=
 =?us-ascii?Q?H3lGLvj86KCZT5+bhEoCSOSrr86ykApxi0vr+TzDY2Rgx5zt9F14cMy4nA8e?=
 =?us-ascii?Q?Xb6UL/nQi6S7rGMPKJCTXyz1tZYtlhoQRYP7EzNPEOqsyUfrIYOl3wKnJ9ch?=
 =?us-ascii?Q?AX/gfg0xsgdlC+keLGR5HXXhqXnbb8MgbXRmqjYjZx7WWUoP1hg9D3G2o4qf?=
 =?us-ascii?Q?Zz1WURidzva1uyAvQ9fhz/JAvOR6hoLZEI31YtvFRDb7w4KgfaDqq5MCA9ih?=
 =?us-ascii?Q?WzFRfceg3QfOxqyRe9nGKJ5yIGNzczpi6hUTT52UfWhV3tujjFxqBY5OgOJ5?=
 =?us-ascii?Q?XglTPMCuLFPca1TtYcZFp6Er7MkUqdIH9ELRjRnsiLtdyawXZuSFtyDsaSC8?=
 =?us-ascii?Q?ZnRQQJgMVhU1tEbhvQpCVITqeS+YBLuV/u5y3sozw4vgeTgn34u6/WhUzO8z?=
 =?us-ascii?Q?OuGzsKHWY8tp+7LsEvSSyC1L9qVUdPiS6V6GFC5g4ekFXjhXHB/x1ZcRm2KA?=
 =?us-ascii?Q?u3TLSD2m95c48U/yu4yrVgzg3W9O9Ff7Snq4Da/Z/lCjiRzJLIeHlJ8O2vTk?=
 =?us-ascii?Q?L87bHJfK1WBSiyNd/OxKETJc7VuHzoi2AWFZ/qlCBSwP7TfUwcqyGLEi9bX/?=
 =?us-ascii?Q?/CZS6Ezp5a39lNjod44DwOOBapLq2QpdD/46Ki3S6nE1dApI/IOk7w4ccTMj?=
 =?us-ascii?Q?PQln0RF1Efphba3kF5u4hofieZsAeSY7VpLvE7nrBUAkkN4EVgM9+XVJTNHh?=
 =?us-ascii?Q?L692Qwm6hzORCUwTw+c8KbIBv9m7WTTFsli7EF5Gicl1w8F9p5Qh622sBywG?=
 =?us-ascii?Q?S2WiP5rx5kL8tQyO7aR2ZVcd9FkV2VMygu6LvhE2vUV8PRn29T8ajO6RptN7?=
 =?us-ascii?Q?PD3/J29rFyj9t/VBbFkjH5z/yWnJy9R+Py1WnONxSYXYXfLTpW/xcOXXg01e?=
 =?us-ascii?Q?pkLT6WLI2Zes+/cf/QjJsU6yq0TftV13lDmnBtSuz/SPjmAG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7077.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f409b7e-7ac4-4fae-a59c-08df38f8fee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 15:50:18.8343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmGFEL8yglv5dA6MrCNYW8x46nfdkFavS0bl21sQHUqh3/diF4PZAyQC360xAGYiR5Cr2qNwmBMKxgRxDJufvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Sent: Monday, October 26, 2026 5:27 PM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org
> Subject: [PATCH 00/13] net/mlx5: support nested E-Switch
>=20
> NVIDIA NICs and DPUs have an embedded switch (E-Switch) to which all
> associated functions (PFs, VFs, SFs) and physical ports are connected thr=
ough
> virtual ports (vports).
> When E-Switch is in switchdev mode, it is exposed as a single IB device w=
ith
> multiple ports, owned by the PF (E-Switch manager).
> Uplink and each of the representor netdevs are bound to one of the IB dev=
ice
> ports.
> mlx5 PMD probes the PF device and spawns ethdev ports for the uplink and
> for representors selected through representor devargs.
> Type and location of each port in the E-Switch topology are derived from
> phys_port_name of the related netdev.
>=20
> Future FW and Linux kernel releases will introduce nested E-Switch.
> Nested E-Switch groups a set of VFs or SFs into a new E-Switch instance.
> Its architecture is similar to the regular E-Switch:
> there is a single IB device with multiple ports, owned by one of the grou=
ped
> functions, which serves as the E-Switch manager (transfer proxy) of the
> nested E-Switch.
> Remaining grouped functions are bound to other IB device ports and serve =
as
> representors.
>=20
> However, nested E-Switch differs from the regular one in ways which break
> assumptions made by mlx5 PMD:
>=20
> - Ports of nested E-Switch are netdevs of real VFs/SFs,
>   not representor netdevs created on the PF.
>   Each of these functions has its own PCI or auxiliary device,
>   but the IB device can be opened only through the device of E-Switch
> manager.
>   mlx5 PMD assumes a one-to-one relation between rte_device and mlx5
> common device,
>   and that all ethdev ports in a single E-Switch are spawned on the same
> rte_device.
> - These netdevs do not have phys_port_name.
>   Instead, they are related to devlink ports with VIRTUAL flavour.
>=20
> Goal of this patchset is to allow mlx5 PMD to probe ports of nested E-Swi=
tch.
> Each of the grouped VFs/SFs is probed using its own PCI or auxiliary devi=
ce,
> which mlx5 PMD associates with the IB device of the nested E-Switch.
> Representor devargs are not required for such ports and ethdev port name =
is
> the name of the probed device.
> Probing of ports not related to VIRTUAL devlink ports is unchanged.
> Other mlx5 class drivers (compress, crypto, regex, vdpa) still allow prob=
ing
> only through the IB device owner.
>=20
> - Patches 1-5 - Rework Netlink helpers in common/mlx5,
>   so that they can be used in common driver code, before any ethdev port =
is
> spawned.
>   IB port number and IB port to ifindex queries no longer require
>   the IB port to netdev cache, generic netdev query is separated from swi=
tch
> info query,
>   and parent device (bus and device name) of a netdev is queried.
>   Also adds a check whether given device is an auxiliary device.
> - Patch 6 - When mlx5 common device is created, gathers a list of associa=
ted
> devices.
>   For each IB device port, the parent device of related netdev is added t=
o the
> list.
> - Patch 7 - Uses associated devices list to find mlx5 common device for t=
he
> probed rte_device
>   and passes the probed rte_device to mlx5 class drivers.
>   Only class drivers which explicitly opt in can be probed
>   through a device other than the IB device owner.
> - Patches 8-9 - Add Netlink queries for the devlink port related to a net=
dev
>   (through IFLA_DEVLINK_PORT attribute, available since Linux 6.2)
>   and for flavour of that devlink port.
> - Patch 10 - Adds a common check whether given device is managed by any
> mlx5 driver.
> - Patch 11 - Adds MLX5_ETH_FOREACH_SIBLING macro, which iterates over
> mlx5 ethdev ports
>   sharing the same mlx5 common device. It replaces iteration over ports
>   sharing the same rte_device, which is no longer valid for nested E-Swit=
ch.
> - Patch 12 - Allows probing mlx5 networking driver through associated PCI
> devices (VFs).
>   Ports related to VIRTUAL devlink ports are recognized as nested E-Switc=
h
> ports:
>   port of IB device owner is the E-Switch manager, others are representor=
s.
>   Only the port related to the probed device is spawned.
> - Patch 13 - Allows probing mlx5 networking driver through associated
> auxiliary devices (SFs).
>   Auxiliary device with multiport IB device is treated as nested E-Switch=
 port.
>=20
> Dariusz Sosnowski (13):
>   common/mlx5: rework IB port number query
>   common/mlx5: allow ifindex query without cache
>   common/mlx5: separate netdev info from switch info
>   common/mlx5: query parent device over Netlink
>   common/mlx5: add check for auxiliary device
>   common/mlx5: gather associated devices
>   common/mlx5: always use EAL device for probing
>   common/mlx5: query devlink port for netdevs
>   common/mlx5: get devlink port by port index
>   common/mlx5: add check for managed device
>   net/mlx5: add sibling device iteration macro
>   net/mlx5: allow associated devices
>   net/mlx5: allow multiport auxiliary device probe
>=20
>  drivers/common/mlx5/linux/meson.build        |   6 +
>  drivers/common/mlx5/linux/mlx5_common_os.c   | 164 ++++++
>  drivers/common/mlx5/linux/mlx5_common_os.h   |   4 +
>  drivers/common/mlx5/linux/mlx5_nl.c          | 578 ++++++++++++++-----
>  drivers/common/mlx5/linux/mlx5_nl.h          |  67 ++-
>  drivers/common/mlx5/mlx5_common.c            | 108 +++-
>  drivers/common/mlx5/mlx5_common.h            |  54 ++
>  drivers/common/mlx5/windows/mlx5_common_os.c |  19 +
>  drivers/common/mlx5/windows/mlx5_common_os.h |   1 +
>  drivers/compress/mlx5/mlx5_compress.c        |   1 +
>  drivers/crypto/mlx5/mlx5_crypto.c            |   1 +
>  drivers/net/mlx5/linux/mlx5_ethdev_os.c      |  24 +-
>  drivers/net/mlx5/linux/mlx5_os.c             | 280 +++++++--
>  drivers/net/mlx5/linux/mlx5_os.h             |   2 +-
>  drivers/net/mlx5/mlx5.c                      |  81 ++-
>  drivers/net/mlx5/mlx5.h                      |   8 +
>  drivers/net/mlx5/mlx5_ethdev.c               |  40 +-
>  drivers/net/mlx5/mlx5_flow.c                 |  24 +-
>  drivers/net/mlx5/mlx5_mac.c                  |   8 +-
>  drivers/net/mlx5/mlx5_trigger.c              |  10 +-
>  drivers/net/mlx5/windows/mlx5_os.c           |  25 +-
>  drivers/regex/mlx5/mlx5_regex.c              |   1 +
>  drivers/vdpa/mlx5/mlx5_vdpa.c                |   1 +
>  23 files changed, 1221 insertions(+), 286 deletions(-)
>=20
> --
> 2.43.0

Relevant changes did not make it into v7.4 Linux kernel merge window and mo=
st probably will be picked up for v7.5.
This series will be resent for 27.03. I'll mark this series as deferred.
