Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0773AC5AC7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 06:54:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 204E34064A;
	Fri,  7 Aug 2026 08:54:47 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
 by mails.dpdk.org (Postfix) with ESMTP id 922594060C
 for <dev@dpdk.org>; Fri,  7 Aug 2026 08:54:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JP30m4QGYnAvy3V7QHkfaYy8Upc7awrB0Tw6KBsBaNG/l91is0xxuxMX3d9hDgV17vMDd5lUIh1d+7Jk0zoA2KdQWOm+1BUqTGpkPInuU9dwyVg22vQ8R7MxrNi3Kn3jOzeEANdZ7BaFO1UXHHg95ulq+KB0eZaiKOrXOmHIBNPdpXsLnSoLKdjGrYPYdqt8mFb6OJl1rX7FJT3ttyMBiCJsIwFdvPGYOgRjvkZVYwSVhWxQ9H7o17qIIge9irYnugQyh4j+k1WesqDUd1niZsZybeuKtIIo9BfkEqHzska7UADwXTGEKLb7H1C8qp/pjawbD4qHAhE8Y6Vd7C9lZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfGEiGLpgQ/M3NYtoocZbwNZKasTyxz3Z4on6P/znXk=;
 b=PElZQXzZQh1OwDjzc/Yh44LBivPi3nFZc6j2t/1qMnUFHhSk282zqAm9YIN2vS/hPh8ntOMkD20mgSm7OMSkk0TB4xABbdLuJgwEEFf7ufpZaFTaDteCis5eCvlygWjjaKQhp6QWKrdbMQ8yz4BXh2z7GiR22rwRwobghI8DJx0dRwb2b/5k4T4Q0hzY0KiXXbZXRGawWUnSNX5rBTqWCpq7KAXVSZe5fcMZ83vptL3U2gh9STwcdcR54H+3K248kj0BJRfb5D4Y1SLf8xeISUvNerGuVZqFR+pfCoKtaOC0xAVMhNgddxPZqma4lt9fe7Ol2/HqEPjpMcpAwLhzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfGEiGLpgQ/M3NYtoocZbwNZKasTyxz3Z4on6P/znXk=;
 b=LjgxAOI9gRKnlDc+Nc5nnDUCn119ZbX8747qCr6f4b2HH1QOKZrn9p5p1Z2bNiOJ/F/YE2urh7r9MVqcoT95dftaRHJILpwho5t/esRz1Qf3iMpzKqM8cbnaRwwD0RxHaZirtyUmrYxFc6gurEBXMBXfrXt5WI1NkjeOFX1wn2ID0yNdPKFsq8bwzGllL3l+xh/vJnqJvNrCrtrq1QmUxyKuF1z08gHBNgUxCkHxd+XUBsgrDuc13vam2aJba+QQ8EomGIG58uMmwDwa0eNkRpq7ipkCHEP+Rn5NecrxVHFZnqOHDyOE2T31K0OWXEkpOFAebsY/JdN5m7IMGvMQ9A==
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 (2603:10a6:20b:725::21) by VI2PR04MB10834.eurprd04.prod.outlook.com
 (2603:10a6:800:275::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 06:54:43 +0000
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf]) by AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf%4]) with mapi id 15.21.0292.021; Fri, 7 Aug 2026
 06:54:43 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: RE: [PATCH 0/4] dma/imx_edma5: introduce NXP i.MX95 eDMA5 driver
Thread-Topic: [PATCH 0/4] dma/imx_edma5: introduce NXP i.MX95 eDMA5 driver
Thread-Index: AQHdJX+V2D52uUwMIkiJxI67lYv+XLaRQlGAgADDWLA=
Date: Fri, 7 Aug 2026 06:54:43 +0000
Message-ID: <AMBPR04MB122810C6D94972241F6784A80E1D12@AMBPR04MB12281.eurprd04.prod.outlook.com>
References: <20260806084245.561305-1-g.singh@nxp.com>
 <20260806101145.336c193f@phoenix.local>
In-Reply-To: <20260806101145.336c193f@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB12281:EE_|VI2PR04MB10834:EE_
x-ms-office365-filtering-correlation-id: e5e87749-a9d9-4e5f-0402-08def450c2b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|19092799006|1800799024|376014|11063799006|5023799004|56012099006|10067099003|6133799003|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: GiFQmI3lQBVrGdyQ2P8WiFWygz2AXJOl0y3Ls6Ttx2KusmAfy6tpm8X1M+i878I20qFQFTqaWTlEgz7Nw+Z/UVHDb8TSWbQClxgpgtSKRdLri3y9yXAXzNprrrC/JweIB6BVnwNmieeALvSMeBgcUcy6rRaSLAeHMymnW5rshXBZ/GT4vlcV1Qjf55MdIPDp9T9YwBqiSeKRNQldp/DK/mi0/KHEu1b3aOVy7XjaETTChxc3Po9/og+O1bc9+/leHZS9nS/Ugl3wjhu2exMfYALpgKXzPS5GVyhwqrv607Z4IDbtaySBQB/3X/dpuAi7ahrQGBbxBE4uUUInXLlY+BzMflx+OlKY+ZT4yee4t/VhNQphLDt1nyL/zcwL6xmajAwMzW/k5wQto+M9vi0Lnl8Cvv82MreW3OweOzLugewFQc/jehMkWyBDdJDkOTQXsV7OrD8qHz1KFXwFRJQP9Y4wR4lRnW/Awpxfx1HNje454np9oZZXuoF4/WBd2fNK86cLE9xN8MimF4V6R8zY9vPACzRE5i4QIS5IT+uhg3pjr92y5EhJ8lQ94b8tBJ4a8DoeM9Tga5qfhrRBIlD9IpsbbhIYbwGiGDD9WWmKfjLNVmA8WLSsYslAIlXsLqmjpGDdnhgMSZwx3ZwcDchMO5sr/bsKih715fN4CjEcYny1Wzy01SmILk5/hLszOimgeOBHoqTcdDCIY4sL4k9vwS9wqeVlakAXZZx9049jatw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12281.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(376014)(11063799006)(5023799004)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9bNW+p08Y4sb314Ps2ERlUZAdjELY9KFB4BhHJdnhJSOFVlTpa0sjQ87GhXh?=
 =?us-ascii?Q?d82LdtyhhWHM9MbgpNu5BXqBMvBRfUhOnqhL2A+f4jrZFpAusimWdztRg6u4?=
 =?us-ascii?Q?g/fLBRtm/EHC5Am37uMS1HIZaI/abADjxAhZh3wpAZ4NyAPO8wqRLLxxrEoI?=
 =?us-ascii?Q?Og5sJNLHHcUH/9p3s14IIAkwPi91xvzA0swA5Lwvn9wupGjvXdgOw1GBkTkm?=
 =?us-ascii?Q?Jo8v9idsd9EWXORxdtVL51Bs2udkB0Ww82y3j2B4Q03x0fTpxriFEIY5ESdR?=
 =?us-ascii?Q?IF5PLRCbi376YX94lHFX5Aj02CZedR8650DHCV4Q7xiwHCeDyXfGwPXtO7sy?=
 =?us-ascii?Q?HeiRtlU0MOOc0Jdmt1yGlSWD60zA6QZ4VWEDko0wZK+23y1ONtr0u6Ncacoz?=
 =?us-ascii?Q?iwCO/3RANB87tWmwWh1RunwtgKm1t+l3gnqTpPdZ1PF+CeTK2/f1QnguX5XA?=
 =?us-ascii?Q?frLBJtKz+0zVyxdn4BDT2e2eVhFQbMuuml/+u/U6VfV/unEUxInPDrkwc9Jo?=
 =?us-ascii?Q?2wbnyCP1yDb6XH/pvC9TMHMpv0CLg3aIEBvFrLYvKU445XHg5xvcscs5n+Cx?=
 =?us-ascii?Q?oZ9KHO0+2Bt5EcTlfv4bp/tLwF6cTb0eDi3beH38nmepJmiixQ0Row7t6ew+?=
 =?us-ascii?Q?CIyUpZVYrZg8dWkJpbOg/J9sKWCrakV3QUOTK4B/X9tn8cI7UiNDpaks9uhK?=
 =?us-ascii?Q?Y578UH3y1tYPRdVmggl4mHqXy5FUJMs9D8NMvZs+/8ouUkXpuD4zV5p/Mt1+?=
 =?us-ascii?Q?0EV+VHvDXReIyCFU722URDAvvq/RI93Zi4CKTO9yWT9K9xUZd+7LiKwaZUyf?=
 =?us-ascii?Q?OFHL0nW+BdAAwi45MZ9eI6MSu9rjZ0j9Q9Yd1GPlg6T8zz63X3saXFpkisfF?=
 =?us-ascii?Q?p3NzvC8El/OAWWS489mp0NxRq87Kp4ohR7YCGiMxnw1oas3jw+oxCniU0lBb?=
 =?us-ascii?Q?g3mBkhuZQJJuD47jQPrk4ZpuxhJmO0CJGEhHtqA9AGb5845uT3pMhLIyV0dU?=
 =?us-ascii?Q?BfUOHZVMqANTYoJoqw3OOO3fQn//BDTzi7hIKc4xcvYTucpfyb1rtilnnULH?=
 =?us-ascii?Q?g5pN4ubjVGOjYGLxbKeo7Gdt5vcDfEiccEPYaENdoqRYoqpk2TtXpOpUvut6?=
 =?us-ascii?Q?JsQFQzK4IZLiPokszDiwveqt9zBTfHufevqA7wp9gL+yU+uDs1lxC/DkdObJ?=
 =?us-ascii?Q?PF6bYft/GtqbISUwa3YSvR/bKPHCyvfXcrzp7IvHZpQmfBdlX6EvEg4t7K/O?=
 =?us-ascii?Q?BSEtD4JKa1hUl2icgmnB0q/n5wwiwo53dTEZJxUmkOKoSaZ2nMeSptoWByT5?=
 =?us-ascii?Q?KzSWtn2q+W3EKv9iiM25uCTp+QikSQbZiwJTekqPMGvA7rNUyzrBpKNZ8RjP?=
 =?us-ascii?Q?rB50GkmkGzuJKoEYOd1vgQiiA8sVz9fHVj+N8hRn3YgaHpnZTI30WszWDDwT?=
 =?us-ascii?Q?aPqZSQusZDSiFZ1i1jyjFvnEA6QUw8OmdOM9CQVuOwyPi6GmCb86G/NoNVyb?=
 =?us-ascii?Q?5pUDX7jYgwlr7LvcC+w4hkRW3JcVIoEkROPLj+j3zJ5P0NdTG0sI9PjLtM35?=
 =?us-ascii?Q?G7kak/m5FiM3TL+/tTigeV7JJxKR8BfASuCGOJEcX3KA44BMcFec8SED8JMb?=
 =?us-ascii?Q?+1x2zu+s1WiuhtFktcirD3sIAhLLlTpivbpzlsXLa9QT9y64cURHykE3tYWl?=
 =?us-ascii?Q?3/gRp+jJ5TuyQc55zydI130KthuD2qitxWw1fk0yP4zly8BX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12281.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e87749-a9d9-4e5f-0402-08def450c2b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 06:54:43.3514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lAkIFTZ4gLko8i42UhhXJalZJu7VCB/ij9DHilk7gWb5c9DAJ1Czx+gMKezaBrJQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10834
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, August 6, 2026 10:42 PM
> To: Gagandeep Singh <G.Singh@nxp.com>
> Cc: dev@dpdk.org; Hemant Agrawal <hemant.agrawal@nxp.com>
> Subject: Re: [PATCH 0/4] dma/imx_edma5: introduce NXP i.MX95 eDMA5 driver
>=20
> On Thu,  6 Aug 2026 14:12:41 +0530
> Gagandeep Singh <g.singh@nxp.com> wrote:
>=20
> > This patch series adds a new dmadev Poll-Mode Driver (PMD) for the NXP
> > i.MX95 eDMA5 (Enhanced DMA Type 5) controller.
> >
> > Key features supported by this driver:
> >   - Memory-to-memory copy (RTE_DMA_OP_TYPE_MEMCPY)
> >   - Scatter-gather memory copy (RTE_DMA_OP_TYPE_SG)
> >   - 64-bit TCD (Transfer Control Descriptor) format
> >   - Non-coherent DMA with explicit cache clean/invalidate
> >   - Per-channel statistics and register dump for debug
> >
> > Patch breakdown:
> >   [1/4] Skeleton: bus probe/remove, dmadev registration, MAINTAINERS,
> >         doc index, and release notes for 26.11.
> >   [2/4] Device configuration: vchan setup, TCD ring allocation,
> >         start/stop, and capability reporting.
> >   [3/4] Data path: enqueue (copy and sg), doorbell, completion poll.
> >   [4/4] Statistics and dump: per-channel counters and register dump.
> >
> > Tested on NXP i.MX95 EVK with vfio-platform.
> >
> > Gagandeep Singh (4):
> >   dma/imx_edma5: introduce eDMA5 dmadev skeleton
> >   dma/imx_edma5: add device configuration
> >   dma/imx_edma5: add data path
> >   dma/imx_edma5: add statistics and dump
> >
> >  MAINTAINERS                              |    5 +
> >  doc/guides/dmadevs/imx_edma5.rst         |   61 ++
> >  doc/guides/dmadevs/index.rst             |    1 +
> >  doc/guides/rel_notes/release_26_11.rst   |    6 +
> >  drivers/dma/imx_edma5/imx_edma5_dmadev.c | 1096
> > ++++++++++++++++++++++  drivers/dma/imx_edma5/imx_edma5_dmadev.h |
> 203 ++++
> >  drivers/dma/imx_edma5/imx_edma5_hw.h     |  158 ++++
> >  drivers/dma/imx_edma5/imx_edma5_logs.h   |   16 +
> >  drivers/dma/imx_edma5/meson.build        |   10 +
> >  drivers/dma/meson.build                  |    1 +
> >  10 files changed, 1557 insertions(+)
> >  create mode 100644 doc/guides/dmadevs/imx_edma5.rst  create mode
> > 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.c
> >  create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.h
> >  create mode 100644 drivers/dma/imx_edma5/imx_edma5_hw.h
> >  create mode 100644 drivers/dma/imx_edma5/imx_edma5_logs.h
> >  create mode 100644 drivers/dma/imx_edma5/meson.build
> >
>=20
> Always good to see more hardware support.
>=20
> Detailed AI review showed lots of problems:
>=20
> Patch 1/4 (skeleton):
>=20
> Error: The driver can never match a device through the upstream platform =
bus.
> platform_bus_match() compares (1) the kernel driver name against the DPDK
> driver name, (2) the kernel driver name against the alias, and (3) the sy=
sfs device
> name against the DPDK driver name. Devices are only scanned if bound to v=
fio-
> platform, so the kernel driver name is always "vfio-platform", and a DT d=
evice
> name like "42000000.dma-controller" never equals "dma_imx_edma5". No
> match path can succeed, so probe is unreachable.
> The cover letter says this was tested on i.MX95 EVK - presumably against =
a
> modified bus. The series needs an accompanying bus/platform change (e.g.
> match on of_node/compatible) or an explanation of the intended binding.
>=20
> Error: RTE_PMD_REGISTER_ALIAS(dma_imx_edma5, IMX_EDMA5_COMPAT)
> produces a broken alias. RTE_PMD_REGISTER_ALIAS stringifies its argument =
via
> RTE_STR, and IMX_EDMA5_COMPAT is already a string literal, so the alias
> becomes "\"fsl,imx95-edma5\"" with embedded quote characters (verified wi=
th
> cpp).

> It can never strcmp-equal anything. The macro takes an unquoted token, an=
d
> "fsl,imx95-edma5" cannot be expressed as one (comma splits macro args), s=
o the
> compatible string cannot be used as an alias at all - which feeds back in=
to the
> matching problem above.
>=20
> Warning: probe() does not verify the device's compatible string. If the b=
us
> matching is fixed, any allowlisted vfio-platform device would be claimed =
by this
> driver. Read of_node/compatible and check for "fsl,imx95-edma5"
> before touching registers.
>=20
> Patch 2/4 (device configuration):
>=20
> Warning: Internal contradiction on coherency. imx_edma5_reset_hw_chan()
> programs CH_MATTR to IMX_EDMA5_CH_MATTR_COHERENT with a comment
> saying the eDMA "snoops the CPU caches, matching the Linux fsl-edma drive=
r on
> a dma-coherent controller", while the cover letter, patch 3 commit messag=
e, and
> the data path all say the master is non-coherent and do full manual
> clean/invalidate. Both cannot be the intended design: if the interconnect=
 honors
> those attributes, the per-op cache maintenance and iova2virt lookups are =
pure
> overhead; if it does not, this comment is wrong. Pick one and make the co=
mments
> match the code.
>=20
> Patch 3/4 (data path):
>=20
> Error: RTE_DMA_OP_FLAG_SUBMIT does not submit previously enqueued jobs.
> The API defines the flag as issuing the doorbell "after enqueued jobs", i=
.e.
> equivalent to rte_dma_submit(). imx_edma5_copy()/copy_sg() with the flag =
run
> only the current job. Jobs enqueued earlier without the flag are skipped,=
 so they
> execute out of order relative to the flagged job, and if the application =
relies on the
> flag alone they never execute:
> imx_edma5_completed() stops at the unsubmitted job at tail and the applic=
ation
> waits forever. In the flag branch, run all pending jobs from tail through=
 this one
> (same walk as imx_edma5_submit()).
>=20
> Error: The arm64 cache maintenance helpers lack a DSB.
> imx_edma5_cache_clean() issues DC CVAC per line but never executes DSB;
> completion of cache maintenance to the PoC is only guaranteed after a DSB=
, and
> the DMB inside
> rte_write32() does not provide that. The device can be started before the=
 cleans
> reach memory and read stale source data; likewise the CPU can read the
> destination before the CIVAC loop in imx_edma5_cache_inval() has complete=
d.
> Add asm volatile("dsb sy" ::: "memory") at the end of both helpers (compa=
re Linux
> arch_sync_dma_for_device()).
>=20
> Error: 1 ms completion timeout with unbounded transfer length can corrupt
> memory. The API length is uint32_t and the driver imposes no maximum, but=
 the
> timeout comment assumes "the largest single-block copy ... completes in w=
ell
> under a millisecond". A large copy exceeds 1 ms, imx_edma5_wait_done() ti=
mes
> out, and imx_edma5_reset_hw_chan() does not actually cancel an active tra=
nsfer
> (it only writes CH_CSR.DONE; there is no MP_CSR.CX cancel in this driver)=
, so the
> next job reprograms the TCD while the channel is still ACTIVE and the abo=
rted
> transfer keeps writing to the old destination.
> Enforce a maximum length in copy()/copy_sg() and scale the timeout, or
> implement cancel via MP_CSR.CX on timeout.
>=20
> Error: TCD NBYTES is written with the full 32-bit length, but on
> eDMA3/4/5 the NBYTES register carries SMLOE/DMLOE in bits 31:30 when
> minor-loop offsets are supported, leaving a 30-bit count. A length with b=
it 30 or 31
> set silently enables minor-loop offset mode and truncates the count. (Con=
fidence
> moderate - please confirm against the i.MX95 RM.) A length cap per the pr=
evious
> item resolves this too.
>=20
> Warning: The data path is fully synchronous: enqueue (or submit) programs=
 the
> TCD, starts the channel, and busy-waits for DONE, so the CPU spins for th=
e
> duration of every copy and the offload gains nothing over memcpy. The har=
dware
> can run detached: program and START at submit time, poll CH_CSR.DONE in
> completed()/completed_status(), and only serialize when a second job need=
s the
> single register TCD. At minimum the limitation deserves a line in the dri=
ver doc.
>=20
> Warning: rte_mem_iova2virt() is called per operation (src and dst) in the=
 hot path;
> it walks the memseg lists and is expensive. In IOVA=3DVA mode the lookup =
is
> unnecessary. Also, when it returns NULL (e.g. external memory), cache
> maintenance is silently skipped, which corrupts data on the non-coherent =
path -
> reject such addresses or document the restriction.
>=20
> Info: The in-memory TCD64 pool is only used as a parameter store: fields =
are
> converted to LE at enqueue and read back with le_to_cpu in
> imx_edma5_run_job()/job_invalidate_dst(); no descriptor is ever fetched b=
y
> hardware, and the "must be cleaned from the CPU cache" comment in
> imx_edma5_hw.h is not (and need not be) honored. A plain array of src/dst=
/len
> triples would be simpler, or use E_SG hardware chaining.
>=20
> Patch 4/4 (statistics and dump):
>=20
> Info: The cover letter advertises "register dump for debug", but dev_dump=
 prints
> software state only (the commit message is accurate). Either dump
> CH_CSR/CH_ES/TCD registers or fix the cover letter wording.
>=20
> Series:
>=20
> Info: A few double blank lines (imx_edma5_dmadev.h:46, 69, 132;
> imx_edma5_hw.h:157) and a stray blank line before the closing brace of st=
ruct
> imx_edma5_dev; checkpatch will flag these.

Submitted the V2 series with the fixes. Also added a dependent patch in the=
 series.
