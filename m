Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D78DC5AC82
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 10:58:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 664E440DDE;
	Mon, 10 Aug 2026 12:58:17 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011001.outbound.protection.outlook.com [40.107.130.1])
 by mails.dpdk.org (Postfix) with ESMTP id 2185740DD6
 for <dev@dpdk.org>; Mon, 10 Aug 2026 12:58:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRBrjvl+NPeCA0gJMKVb1cfJ63iYYvtO9vSf+FBWqvR3ibpUeiqm23snGqMPFvbF2I+x9yu9ORn6e/jM5ioQ+LJ0yUHzzckYpjeIictJsu62rNACZkUI1eeKKtWUEldGPbhSBvz5l0sQLDxiSuHk95tV7ubT7l4D1r8D0q8ZrKWih7PKiJyHoqzj/FChGaU4Iu+pFe6EqtGyowC6avwJxiAayCnrSnUnpasloOK7lwEYT+SJWC614lrTBg+DyO40vNCU2W+StUDCoSsIwdFj5zxro0XMfEtJx76C3PU+26YaDlSuMjKhocw6LiyLDq0RYseugmfV7sl5BJvUMyWYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HsvylHjyPuzfxHmACXzcKVgxIcfHlfPsL9lVQ6MQ8E=;
 b=yt43G5rjzNqeoqUHJWVGbtQUdrrPSUZnHqoha7aLV+cQ85rqjPeqLOSqASqjjQSS0OTT9//FeWPFlAsDJrlbZLHK+yjMe8DR+PE4zEIgE1NuugGJ0u0+7OSl3ONpIBqSRW/6ZGHUIMaAMdkcQiq/Frgi2C3nO9XzaaqEvYh/WRSw17hVqNOEabBZMvSkzXRg6WbZkYz2MFBlTnGTLjlHjTqbhuQbvdYvaqOadfjcmaA3tNN7A3mQlQRbtveowrzCt6dgbwxWMIGCULG7El56yyhWhZGpW9VSd6FRS5V6wmcRBISZ+NMifFvGXL8vW7TR3jpH7fKR09LjcJhtP/mTFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HsvylHjyPuzfxHmACXzcKVgxIcfHlfPsL9lVQ6MQ8E=;
 b=j6T/E5d5YtB++3VTdFGhGwY7yqo/Yl0LtjsT7Tu1PGOoaDbXn4a34rKVXlgqdTX64yzn1soPwziZsgBZZ5u99VKNnGwJhK5BYJr0Hv7eB9Dud8euqCUipiJDELh91mXx4U4/pEZA+qnawb3tIDcClOsfmW+XaGaYGvEBv3LhHRciixTO4wbrHcsv++omwRMYxiwHOnvo+Kg0U4XqcKnMt3MMqI+tj8Uvx5buXZVSiJ1H88jRXrsf8GrfRgggfAxUBnHxesfFSXFaerfK+ODgP09QZuunUOaMYXeJ21OFh4055PWu4J61Os2//YZUDnYwlGhT9TA2yNlGesdHcJpXTg==
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 (2603:10a6:20b:725::21) by GV1PR04MB10824.eurprd04.prod.outlook.com
 (2603:10a6:150:20c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:58:13 +0000
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf]) by AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 10:58:13 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: RE: [PATCH v4 00/14] net/enetc: add new features for ENETC4 on i.MX95
Thread-Topic: [PATCH v4 00/14] net/enetc: add new features for ENETC4 on i.MX95
Thread-Index: AQHdJl+aVNSDfY3cRECb5MFJZhBI7LaWN18AgADo4dA=
Date: Mon, 10 Aug 2026 10:58:13 +0000
Message-ID: <AMBPR04MB1228184B4EB17FB1F84CB224FE1DE2@AMBPR04MB12281.eurprd04.prod.outlook.com>
References: <20260807070241.1151161-1-g.singh@nxp.com>
 <20260807112623.1402493-1-g.singh@nxp.com>
 <20260809140008.2141eb88@phoenix.local>
In-Reply-To: <20260809140008.2141eb88@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB12281:EE_|GV1PR04MB10824:EE_
x-ms-office365-filtering-correlation-id: 03f8c3f3-9b79-4aba-fa03-08def6ce465f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006|5023799004|4143699003|38070700021|6133799003|3023799007;
x-microsoft-antispam-message-info: K2nz9UPBeU74GrCUs8yRyMQE0BCbRfimHmgpcr/pj0pu2cc4WyqwOClFYHOlzLlEKFuhsgLTjE85MnWanGOurdO0kpYOfClTPBeA8Ux0eV8An3cDfjUhfHicXLG/s6621h+ZrFnEMvJaoBbdCtVayImZuEnCAT3CMFtUQST1cLWKZaSvsYxtTZR7z0tIsCQVbqRnL/nFnHZPIq5BBNXYF9mDkEbt7EWC4QlCGrIEwtAnDzqALxGRgDPaDMmJTMDhtM9zCVJGKIEWLFcM5WrAggLQBCKRXOPdPnmKuHCci9pLdeiNv+Qg6YRoCuME+jTF24iKF7VqULuiaefXzCf0dfU9u476b+lPTTj2vTtAlQOZWXZ5HLXlkmTJBymF1FJcrapjXeMYwmWQu/9Fr5foJBuun5HvQGpHRtQt3gDpQLrAoRBERq1lNG+6hd44n4cyUlpAA8SnRoShDfiwkF55Q9fzlhOJEBqP/+VzjloRgmNvPIDIhAhq/XSyyQe3DzpLbtBVI16N3rjImTE1vv3zHIcV79GRqm9tI3Uh385RMXBe+y9a3SjwLzUF80UIr/QgiI9/qeX6a2fBJVU3n8b6nuQvBwYgkVSo2FPhvmTjnQB9vEKWGxjs4SBxiYXDbgk63wyZEu+6r2b4rMH5znPOtDfhzlr/wl6cEO5kJNDsEOV80BY5+1+ctcJx720EwWrJGJS4CSpX+94sb75JSyPPVL+j2pIeiW8n+b1Jmp7hH1Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12281.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(38070700021)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VRmJS4F1antdmKtPpDryKGWjUFZlpBvVQOKN6NAHL95WYPZ0sjXdAj58bqVE?=
 =?us-ascii?Q?20RJnkweuZmoWAgTKPvrjfs2tpfB2zQb3acbWZRfQkaoTE7QQWvMe4PV3L8T?=
 =?us-ascii?Q?Ekvx5Cm6/xUxP5M/kkFb9IrwUuSpd0ECcCV/iDW8YMf/GN/i6t8sQH7DjZ8Y?=
 =?us-ascii?Q?FpwFmmy0eFJrwgvN8sqQP2T2zvOmC3xPhvuIPE4dlBBzRXtk5Iu0cII3aMj+?=
 =?us-ascii?Q?MQBXX618OZO70ucZS+3rb40YLOV3R+Yfk1DkF+rqyTcQikIV+/vWHgdpI3DV?=
 =?us-ascii?Q?IiIAXcaviKskNLYKu6HI8KFdyAVOo686EeI9rlXP8TeCyluu6BQe6i79hAB3?=
 =?us-ascii?Q?14yH7ARk+XKzgYn5FTpw9T+NpKp/BdA/Sg/dtyDjo1nemOX0aAZNtT2fp5sg?=
 =?us-ascii?Q?fYgjqDTaPS2H0i29dg1P2N7ccYtVT0ZPJ3Lv6etZh7eFcJ67+GtAYQ/EWbbj?=
 =?us-ascii?Q?n5ic8QBe/KPBtHSJcgOJmHHBNHPnHmu3ez0dIGkcXEiMH/Xvn2T2/Uyp6gMC?=
 =?us-ascii?Q?dIJyETu/qFLjNBpaCRlLENyOjqt22yKIIyzR3xxa6qtKoiTF/YHtYRH4NxrN?=
 =?us-ascii?Q?E3hDQmgqd0vcdW0IpzYoSS/A4c9NyI8sUOZJu2MMe5TQ0/XoagXQwTNI+OHE?=
 =?us-ascii?Q?FfKQViuhSwxVJ2mA30NCgvJiY7hT5KQhgn3lf9/6IeG/0wZYb78Crc9FDrkp?=
 =?us-ascii?Q?f8233gDSCvxWlp5ATRVU4PLcoupXB5LiH0fFFVjAJyMocAHIm328Ehdc4ARU?=
 =?us-ascii?Q?TMDAIaqvMOgvrG8rEgDE7kKknJv4Wzl3nkAKF8mNfddzAN+sMLRW37DTRnvc?=
 =?us-ascii?Q?eG/MPCC7wjVb8O5y9NZ42q9i2MESUb9JJlfZpGeX00wOPhtEuHZodSMRt0kf?=
 =?us-ascii?Q?AFw1I8AycTAjqKbqSDysvDgd2fDrtCy2Fa25SInENjBr02X7SM8ZSBols2St?=
 =?us-ascii?Q?d7ej9AKqUuwun6Xpy7XsrXYYTEjg38cD8Bs/a0CLJoMaINk+ZbBpMqkG2Pu4?=
 =?us-ascii?Q?Kjq44UQgph2wkk6P8+x4Na9DWn29xLLnrivLq/BEwItXpSqSKNmINyR+uT+Q?=
 =?us-ascii?Q?KV47Ae7B4fP8rCMkmHwN87gNPR+sI8sg4SwnVob1CWp5UvVAl8kQjC+weCdV?=
 =?us-ascii?Q?rjn2hun8FAeoQE55MxaUjXh8B1tyNOaifEOMPgEUP7ij23dDmTKJsMXlLpaL?=
 =?us-ascii?Q?2R+GydWg/Xco8fwr0+YpwKPvkysbw1tfLFz8mWhL9PuA4XDKtC/Q8ll4tQl7?=
 =?us-ascii?Q?kHf49I6OqG1rGZr+/4BO0eY0ejlquA+uTR8PlJhuUusqBuj6E8ePwKBjTdc0?=
 =?us-ascii?Q?VSyIs0P3wZl+zNO9zlwMNOtOuFcIhj7IXGiVGoLJFnYRqApLOtPZXVPhBwfJ?=
 =?us-ascii?Q?s05bRG/5j5WsXJiiZGC9bA49oCcvjju9a0LJCYcwAmpuco74G0ia0CVWJyNk?=
 =?us-ascii?Q?USXiT5g4vXVJFeueWSMUE9D+mx3uEl1QmKGNdqOpjnZ54fizgxfjfEr3Queu?=
 =?us-ascii?Q?IllyXDQN18Xi5MD276hxGUDOkpchZykPbSUv2bvYeN+mD51d8p1LacLfM51L?=
 =?us-ascii?Q?m96bu3iA1mzTP0vkGmE/Uh44flbxGV4AY208/Kdz5r8iljmP1L6CD+9ZbeMc?=
 =?us-ascii?Q?4ygCar0wr7SM+kPnZ7UsAyGFvEqnrKOC6YNaim6K+UjN2IcriST1vYwSbX/m?=
 =?us-ascii?Q?42DFJIRVWgyByKPaVojiN/RwsH1vdnyKesrK9QubkMX4MlZn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12281.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f8c3f3-9b79-4aba-fa03-08def6ce465f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 10:58:13.6663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AcvyaiXurlwwkxzPU9zqhWlirNdckJTFFMnfFPMHqcSXEwssp4ihJQGsUCg3LPtF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10824
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

Hi

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, August 10, 2026 2:30 AM
> To: Gagandeep Singh <G.Singh@nxp.com>
> Cc: dev@dpdk.org; Hemant Agrawal <hemant.agrawal@nxp.com>
> Subject: Re: [PATCH v4 00/14] net/enetc: add new features for ENETC4 on i=
.MX95
>=20
> On Fri,  7 Aug 2026 16:56:09 +0530
> Gagandeep Singh <g.singh@nxp.com> wrote:
>=20
> > V4-changes:
> >  - fix doc build issue: WARNING: undefined label: pmd_build_and_test
> >
> > v3-changes:
> >  - fix doc build issue.
> >  - fix compilation issue on fedore:43-gcc-minsize
> >
> > V2-changes:
> >  - compilation fixes.
> >
> > V1-changes:
> > This series adds new PMD features to the ENETC4 driver targeting the
> > NXP i.MX95 NETC IP.
> >
> > The series covers:
> >
> >  - KEEP_CRC Rx offload: preserve the Ethernet FCS in the receive buffer=
.
> >  - TSO: TCP Segmentation Offload for the VF Tx path.
> >  - RSC/LRO: hardware Receive Segment Coalesce for PF and VF Rx paths.
> >  - Link speed code: extend the PF-to-VF mailbox field from 4-bit to
> >    8-bit to support speeds beyond 10G.
> >  - Firmware version: report the NETC IP version via fw_version_get.
> >  - Register dump: dump SI, port (PF) and BD ring registers.
> >  - Ring parameters: implement rxq_info_get / txq_info_get for the VF.
> >  - Link-up interrupt: refresh the cached link speed on each VF link-up
> >    interrupt so that link_update returns the current speed immediately.
> >  - Stats reset: software snapshot/delta approach for VF counter reset.
> >  - Per-queue Rx interrupt: MSI-X per-queue Rx interrupts for the VF,
> >    enabling interrupt-driven receive with l3fwd-power.
> >  - SI VLAN: hardware port VLAN insertion/removal for PF and VF.
> >  - VF link status bitmask: switch VF link status to bitmask encoding
> >    to align with the PF and newer kernel driver conventions.
> >  - TX PAUSE: VF sets Rx congestion mode when the PF signals TX PAUSE
> >    negotiated on the wire; adds Flow control =3D Y to enetc4.ini.
> >  - WRR Tx scheduler: per-ring WRR weights via enetc4_txq_wrr devarg.
> >
> > Gagandeep Singh (14):
> >   net/enetc: add KEEP_CRC offload support for ENETC4
> >   net/enetc: add TSO support for ENETC4 VF
> >   net/enetc: add RSC (hardware LRO) support for ENETC4
> >   net/enetc: extend link speed code field to 8-bit for PF-to-VF message
> >   net/enetc: support firmware version get for VF
> >   net/enetc: support registers dump
> >   net/enetc: support ethtool ring parameters
> >   net/enetc: refresh link speed on VF link-up interrupt
> >   net/enetc: support stats reset for VF
> >   net/enetc4: add per-queue Rx interrupt support for VF
> >   net/enetc4: add SI-based port VLAN insertion and removal
> >   net/enetc4: update VF link status to bitmask encoding
> >   net/enetc4: enable TX PAUSE via VF RX congestion mode
> >   net/enetc4: add WRR Tx scheduler devarg for VF rings
> >
> >  doc/guides/nics/enetc4.rst             |  77 +++
> >  doc/guides/nics/features/enetc4.ini    |   8 +
> >  doc/guides/rel_notes/release_26_11.rst |  19 +
> >  drivers/net/enetc/base/enetc4_hw.h     | 129 +++-
> >  drivers/net/enetc/base/enetc_hw.h      |   6 +
> >  drivers/net/enetc/enetc.h              | 135 ++++-
> >  drivers/net/enetc/enetc4_ethdev.c      | 402 +++++++++++--
> >  drivers/net/enetc/enetc4_vf.c          | 779 ++++++++++++++++++++++---
> >  drivers/net/enetc/enetc_rxtx.c         | 529 ++++++++++++++++-
> >  9 files changed, 1939 insertions(+), 145 deletions(-)
> >
>=20
> Still lots of issues, the biggest one is that not each patch builds; not =
bisectable.
>=20
> More extensive AI review.
>=20
> ENETC4 v4 series review - 14 patches
>=20
> No Reviewed-by.  The headline finding from the previous round is
> unchanged: 13 of the 14 commits fail to build.  Only the final commit is =
clean, so
> git bisect is broken across essentially the whole series.
>=20
> Build (applied on c1a46b9, gcc 13.3, -Dwerror=3Dtrue):
>=20
>   [1] 8a0a793 01/14 add KEEP_CRC offload support for ENETC4
>   [1] 63cae7e 02/14 add TSO support for ENETC4 VF
>   [1] b28e1a8 03/14 add RSC (hardware LRO) support
>       ... all fail ...
>   [1] e334f6c 13/14 enable TX PAUSE via VF RX congestion mode
>   [0] b5e71d6 14/14 add WRR Tx scheduler devarg for VF rings
>=20
> Three distinct causes, all introduced in patch 01.
>=20
>=20
> Patch 01
>=20
> Error: prev_seg used but never declared (fails commits 01-02).
>=20
>   enetc_rxtx.c:597:25: error: 'prev_seg' undeclared
>   enetc_rxtx.c:844:25: error: 'prev_seg' undeclared
>=20
> Patch 01 assigns prev_seg and passes it to enetc_rx_crc_trim() in both
> enetc_clean_rx_ring_nc() and enetc_clean_rx_ring_cacheable(), but the
> declaration hunk only changes first_seg/cur_seg to =3D NULL.  The *prev_s=
eg =3D
> NULL declaration does not arrive until patch 03.  Move it to patch 01.
>=20
> Error: duplicate offload arrays (fails commits 01-13).
>=20
>   enetc4_ethdev.c:110:17: error: redefinition of 'dev_rx_offloads_sup'
>   enetc4_ethdev.c:117:17: error: redefinition of 'dev_tx_offloads_sup'
>=20
> Patch 01 adds a second copy of both arrays at the top of enetc4_ethdev.c;=
 the
> pre-existing ones near line 97 are not deleted until patch 14.  The delet=
ion hunk
> belongs in patch 01.
>=20
> Error: duplicate rx_enable declaration (fails commits 01-13).
>=20
>   enetc4_ethdev.c:552:18: error: redeclaration of 'rx_enable' with no
>   linkage
>=20
> enetc4_rx_queue_setup() already declares uint32_t rx_enable upstream.
> Patch 01 adds a second one; the removal is in patch 14.
>=20
> This is the signature of building only the squashed series.  Please run
> devtools/test-meson-builds.sh, or at minimum a -Dwerror=3Dtrue build at e=
ach
> commit, before v5.
>=20
> Error: PF loses Scattered Rx and Multi-segment Tx.
>=20
> The old arrays deleted in patch 14 contained RTE_ETH_RX_OFFLOAD_SCATTER
> and RTE_ETH_TX_OFFLOAD_MULTI_SEGS.  The replacements added in patch 01
> do not.  Net result at the tip:
>=20
>   upstream                      after the series
>   RX: IPV4|UDP|TCP|SCATTER      RX: IPV4|UDP|TCP|KEEP_CRC|TCP_LRO
>   TX: IPV4|UDP|TCP|MULTI_SEGS   TX: IPV4|UDP|TCP|TCP_TSO|UDP_TSO
>=20
> Nothing in any commit message says this is intentional.  enetc4.ini still=
 declares
> "Scattered Rx =3D Y", and the new RSC path builds multi-segment clusters,=
 so the
> capability is still needed.  The VF arrays keep both - only the PF regres=
ses.
>=20
>=20
> Patch 02
>=20
> Error: mbuf leak in enetc_xmit_pkts_lso().
>=20
> Two validation paths drop a TSO frame with "start++; continue;":
>=20
>   - hdr_len >=3D pkt_len || hdr_len > data_len
>   - tso_segsz =3D=3D 0 || data_unit > ENETC4_LSO_MAX_DATA_UNIT ||
>     hdr_len + tso_segsz > ENETC4_LSO_MAX_FRAME
>=20
> Neither writes q_swbd[i].buffer_addr, and neither frees the mbuf, but bot=
h count
> the packet in the burst return value.  The application considers it trans=
mitted;
> enetc_clean_tx_ring() never sees it.
> Free-and-continue is the right shape here - add rte_pktmbuf_free(seg) bef=
ore
> each start++.
>=20
> Error: 16-bit byte swap on a uint8_t field.
>=20
> In the non-TSO path of the same function:
>=20
>   txbd->flags |=3D rte_cpu_to_le_16(ENETC4_TXBD_FLAGS_F);
>=20
> struct enetc_tx_bd.flags is uint8_t.  On big-endian this evaluates to
> 0x8000 and truncates to 0, so the frame-last flag is never set and Tx sta=
lls.
> Upstream and the LSO path in this very function both use plain "txbd->fla=
gs |=3D
> ENETC4_TXBD_FLAGS_F;".  Drop the conversion.
>=20
> Warning: ring doubling bypasses MAX_BD_COUNT.
>=20
> Both enetc4_alloc_txbdr() (LSO, patch 02) and enetc4_alloc_rxbdr() (RSC, =
patch
> 03) double nb_desc, but the nb_desc > MAX_BD_COUNT check runs before the
> doubling.  With MAX_BD_COUNT at 64000 the effective ring reaches 128000
> descriptors, and ENETC_RTBLENR_LEN(n) is just
> ((n) & ~0x7) with no upper clamp.  Validate the post-doubling count, or h=
alve the
> accepted nb_desc when LSO/RSC is on.
>=20
>=20
> Patch 04
>=20
> Warning: link speed decode has no upper bound.
>=20
>   link.link_speed =3D (reply_msg->status - ENETC_SPEED_5000) * 1000 + 500=
0;
>=20
> status is uint8_t and the default arm now catches everything from 8 to 25=
5, so a
> garbage or unrecognized code yields a fabricated speed (0xFF -> 253000 Mb=
ps)
> rather than RTE_ETH_SPEED_NUM_UNKNOWN.  Note also that 0xF, previously
> ENETC_SPEED_NOT_SUPPORTED, now decodes as 13000 Mbps in non-legacy
> mode.  Bound the result, or reject codes that do not map to a defined
> RTE_ETH_SPEED_NUM_* value.
>=20
> Warning: flipping the reply-status extraction from 4-bit to 8-bit by defa=
ult is a
> wire-protocol compatibility break.  Users on a PF kernel older than 6.18.=
37 must
> add vf_link_legacy=3D1 or link reporting breaks silently.  That deserves =
an explicit
> line in the release notes, not just "extended the field to 8-bit".
>=20
> Info: adds a second #include <rte_kvargs.h> immediately below the existin=
g one.
>=20
>=20
> Series-wide
>=20
> Warning: mailbox ops added to the no-VSI ops table.
>=20
> enetc4_vf_ops_no_vsi_m is selected when the user passes enetc4_vsi_disabl=
e,
> that is, explicitly asks for no VSI-PSI messaging.
> The series adds fw_version_get, mac_addr_set, mac_addr_add, promiscuous_*=
,
> allmulticast_*, vlan_filter_set, vlan_offload_set, vlan_pvid_set and stat=
s_reset to
> it.  Most of those reach
> enetc4_msg_vsi_send() directly or through a helper, so they will now atte=
mpt a
> transaction on the disabled mailbox and stall until vsi_timeout.  Previou=
sly ethdev
> returned -ENOTSUP immediately.  Only the genuinely register-local ops (ge=
t_reg,
> rxq_info_get, txq_info_get, and stats_reset if it stays direct-register) =
belong in that
> table.
>=20
> Warning: new devargs undocumented.
>=20
> vf_link_legacy (patch 04) and enetc4_txq_wrr (patch 14) are both in
> RTE_PMD_REGISTER_PARAM_STRING but absent from
> doc/guides/nics/enetc4.rst, which documents every pre-existing devarg.
> Same gap flagged in the previous round.
>=20
> Info: patch 01 adds two stray blank lines in enetc4_ethdev.c (one before
> enetc4_rx_queue_release, later removed in patch 03); patch 02 adds three =
more
> around enetc4_alloc_txbdr/enetc4_free_bdr and in struct enetc_bdr.
>=20
> Info: enetc_recv_pkts_rsc is assigned to dev->rx_pkt_burst from
> enetc4_rx_queue_setup(), which will silently override the nc=3D1 burst se=
lection
> made in dev_init.  Worth a guard or at least a comment on precedence.
>=20
> I stopped short of a full read of patches 05-14 since the build breakage =
has to be
> resolved first and several of these findings will shift hunks around.  I =
can go back
> through 05-14 in detail once there is a v5, or now if you would rather ha=
ve the
> complete list before the author respins.

V5 sent. I missed to mention V5-changes in the cover letter.
The changes are:
- Patch 1 Build fixes which includes:
    'prev_seg' undeclared fixed.
    redefinition of 'dev_rx_offloads_sup' fixed.
    Error: duplicate rx_enable declaration fixed.
   PF loses Scattered Rx and Multi-segment Tx
- mbuf leak in enetc_xmit_pkts_lso() fixed.
- fixed conversion on ENETC4_TXBD_FLAGS_F issue.
- fixed link speed decode has no upper bound.
- fixed mailbox ops added to the no-VSI ops table.
- new devargs documented.

Regards,
Gagan
