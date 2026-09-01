Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95936C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 10:25:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC1D24065A;
	Tue,  1 Sep 2026 12:25:47 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012049.outbound.protection.outlook.com [52.101.66.49])
 by mails.dpdk.org (Postfix) with ESMTP id E489F4064E
 for <dev@dpdk.org>; Tue,  1 Sep 2026 12:25:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoVV8my8m1Ys/udXsYLNbdboA4pA94WLlZ5a/XtjHRh1p4ccGc7LI9hvdOZF0bOYwm5OB1iwGePfprorbl7Uij7GTihBg5UU8mpz7kqYLlwAv3u+cinujbcmxO73fWZcHZyxBdmfZDS7ukBBLzkMYHLnEpoSJ1QojW/IOmIM9JD1cfEEmwye6eox7+tUSREJFNWZwZK6hGSj36PrusGr6EleqDnTxTRpW/O3Q+KG38/wZV7mmm+20S9AX+RoF2LDxgY06d2cFiWFTQZfBXiiYM8w5cmxOAswqelmLFbuH2hRmxsYS30Aa3AyaN9pQkYAZSZeOMwwMzLLQtydjAlBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9C5PqxzSANSRHoVNz7szSeRsU5xwdCG1iDagFf7IMDw=;
 b=NVcvQ4pnaGi5+g2WNW+uwsMZg+2X4AMqhXq4TvzsT21rF3sgen7nNjaWGtFlixCzsn2WeK8VNMyhzZr4LoL37LR7n4+v0fXXXcXnFX/3dnPCDASqdXQmNqfM0ru/lWiGV0FOFKFpZvs0/ybT7nbVgsY0kIIw/g20Y+UoVznY1C4+HNsvZuVlYxoa39HlpvczXXQKrhDfBxqWJgm6IVFyJ+CgO6K5EVkmulspSte+CophgsPTV/x15rJsL6mOkVMwt7lQqKyvg1yzf8xIK0ifgIu3acXp4o5yfX2Ig8ocXaaiig6ZpdPIqvCGQDGMFBkcNfUWKaELNhCKc2ZN1x+usg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C5PqxzSANSRHoVNz7szSeRsU5xwdCG1iDagFf7IMDw=;
 b=kqOgTyrizsBEMlBPHoUlczEzIK7yqhEMv5Oc/fo/BQpvQiRwTsUKoVd0csB60VaDb00z/EWpcVrZ/Hkh2qxtPndw+pYXeVr8s4LpkJNuOPbf0JT7SwOES0KgLJpUqGjT5PkiaeLuy22Hy43LKRomx1yrRevW/n1qf5pX6NXPwhauTU1vpRAa/urZdCJLP8oJSkghM00PEkg0RfCAn6xZxbqcJy7G434ZpQ+Sxaq2zd4TNqtWWJL+KNjEmIpSXbp4c9oRUV8JwLbtlDG2X+5FTt/Im38J3YY5F6bI9i1w7wmr8dgJPu8VlpvdUScKhbLz82bwbrQ3EuTnwWrGDGyBaA==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by GV1PR04MB9216.eurprd04.prod.outlook.com
 (2603:10a6:150:2b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 10:25:43 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 10:25:43 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v14 00/23] NXP DPAA driver enhancements and fixes
Thread-Topic: [PATCH v14 00/23] NXP DPAA driver enhancements and fixes
Thread-Index: AQHdMLI/lu35Y1r560G+imp3DSNqYLawnlgAgAj4s5w=
Date: Tue, 1 Sep 2026 10:25:43 +0000
Message-ID: <GV1PR04MB10750AFB21AF6EF7A5B84F49289A82@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260819105004.2272880-1-hemant.agrawal@nxp.com>
 <20260820144312.3922316-1-hemant.agrawal@nxp.com>
 <20260826102520.0a6a90f9@phoenix.local>
In-Reply-To: <20260826102520.0a6a90f9@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-01T10:25:43.055Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=1;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|GV1PR04MB9216:EE_
x-ms-office365-filtering-correlation-id: 7664b30f-4405-4cdb-257f-08df081360ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|1800799024|366016|38070700021|11063799006|56012099006|4143699003|10067099003|5023799004|6133799003|18002099003|22082099003|8096899003;
x-microsoft-antispam-message-info: +d2iUYsz0MUAl6GKODH63+AnIbLna+IbVK1bkF9kF1jcYJG/04Uu14PVhvAeYnbz61sOTnCPs2SRMdzmapjdDRNt1VGI+0D04ma7ZK61FM4bGrAKq/y7SlsZ8HTSn2Zyfy3mycoblMjAno44HjrggejPd3edHMgyMkDgbgVLsK9FauND8z+6NV2UiiTsM5vBR7mPFF6DCthtf1Q3/JdnSUBC+fe6hzefndJcdcGV1n3ZB7+o6mrAh9QfTFUTKkGCP4Ux2SYYftOdW34qConaAJvgWlsUammepO9jX7IU2tnm6LQnvQgswbmQkY5Hk2zOzXDDj5wNhbcTSiU7stjcMexbkln1Ptw97DIDavTifv0sbY387Y5ocSBSq2PBZYi/bvowBZ4LWPXoTjuhnUwxM3hfAqr7msESptOpvwI8vikl+n1wsNx1fST1n6oMk3s3dt69GYGP3/Dz7D9FeFyw+SjehB2L4njpilFnWed8i/M8hl/EF2RMDJL3t8mDYzonLB99mzq7hjHyoJoq9SS20u2ET8AgOIo8Z9l+dqDGyQC9vpNV2xJQ0eNCZkqxVRxtf8NXv16XgEqYuY4vJETRqZHNxflnldnjp71iH1rJZhs78fkDI16NmaSEQg1wjSt6CZWiNhuWdcQQocapY2NFS+wzGVoZ5V/UiqXzk1NtbvLh0btj9AqsKZSIL0lFS/EpTDZ5/IJIUR0SmEAAJMGxC4tceuaRtR0G2uD1Ur68PNI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(5023799004)(6133799003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qi4g22tlUy9i5R5J15zZHeu0M72i4ATxqTPd9QvpHVs2i8qHxEJRvi+B+c?=
 =?iso-8859-1?Q?yDyI/UAAgXVyrJaiRTWWCK6bvFQSj6yVFh3XAnjLeGdrKUf3UwBE9cy6J1?=
 =?iso-8859-1?Q?azp5yPUkqk6rDOeUKFBfRAOOflTDbtC/dtWCoEpP+UcizOADh+G46pM6ab?=
 =?iso-8859-1?Q?Ns3rGoa6uHlNvHYWLyYX5CaLBiqbMYk1pAtMY72bv4DDn1fukhM3mq5HwG?=
 =?iso-8859-1?Q?+VjRbeMqXldA3zaZBZAD4eLpoJ3gFJEPTF6iAW+hmdaMDo1iESmmaZRHOd?=
 =?iso-8859-1?Q?FWaM2qtpXr518nKbBB4foDhAKQl6iW+XMkxo4OV/G1vEDiFgTQtPVvruok?=
 =?iso-8859-1?Q?UHf20v6UbKM3IqXIoTeOK4i3KMHS7XgwfUGOP2iQ5T7tjpVyGTM4Igo+yT?=
 =?iso-8859-1?Q?G0jEoEvK16eD1LWQ83jEMK/Hww3fJsLjc3+/Q2vuaKVtLQ8SDkGe5iTuF/?=
 =?iso-8859-1?Q?G2PtFCO4Ex1KTG1D2VromiOI8lubqjNCCrFZllK2S18zWpqQabS4utR5zc?=
 =?iso-8859-1?Q?fOYRfZbjA0trVzFUOHs6g1gdB9vOtEnE2r61E7VtnhAJeAJgDEpmqaEbh8?=
 =?iso-8859-1?Q?X8JWBqa0hlkn84qYe5IBtA+TEgFVIF4jGfoj7HtX9c22yl6tLF1IQcG3o/?=
 =?iso-8859-1?Q?cwHD7UWPtrBvQr7J3kjsJ/FAEwFFltkGbS2gv4m/m9V4hnKwING9Vp0HwA?=
 =?iso-8859-1?Q?0zLdgoesSfFtl8Ey1aBFuJ98j/C4htjY4/hjkLdmsm5Hnzxtvz02y/kOO8?=
 =?iso-8859-1?Q?VO5Kg55YGGLfQAjCqr0p9On5bAJdurKASFCwqeUHGzix2ftVwiXg9DNd1O?=
 =?iso-8859-1?Q?FSwEBZNMZb5xGWvwnPHy7p1q0wbSrxQcMifwuQyOTTZJ3QezYJh9lF7YXu?=
 =?iso-8859-1?Q?vt2rJ9xY8WJNOQM1AxHenrlAZJwFD5RlZqEowJYTBxyIfW+540Ffw2G761?=
 =?iso-8859-1?Q?zTH2t+huBHBtgz6qilI0apRqd/cwuu7GMO0xJDfYAlE0L68BfrX+mG2U07?=
 =?iso-8859-1?Q?B8yFmgVtigtY7ZL0QwpMl4mtCKrOl1rIwXsN7xk5YeVfS3E+peSAdINpiY?=
 =?iso-8859-1?Q?vcvwitv/y6BDWPUQBIBSJdWnllQFYYFKP8+acP0NdEWHjF2stxps65Yu+K?=
 =?iso-8859-1?Q?Fiw+QI10cBngG/XPyAT8lL74JkYP4t0EB5OdjKUAfsp2o4m1W6xuDKtxw4?=
 =?iso-8859-1?Q?PleE6vmrLpO4C1jFUcH3AVoug8Jfagi93S8ywwgr2xoSrqST3FhPl59E7e?=
 =?iso-8859-1?Q?0p/ifOfvOefMQ35CbQTN6yTMoDFBI961PeeZymg/RdRS9S/KE1H/Ekpz5e?=
 =?iso-8859-1?Q?JmYXllRbQ2X2+HGtoEA2bDpXMsrlSHNNuZ8trGMlWe3JhBOC5N+jHtN4uJ?=
 =?iso-8859-1?Q?cqW5+h1sGTwWoDTgilDMe+v3pOTPLymHLa4zgY8T/GIiucjMxjnYh8m4u0?=
 =?iso-8859-1?Q?VPHXshGiZLr609BG5lfRcT6vadb5PdEphJzg3igfAPOrtyZWBODSOmS0E1?=
 =?iso-8859-1?Q?AHMzIfY+fJk8XSqx2mnlJG3HXEZ/84A98+rGACjsYnS4VnyEdPyA9TVBEW?=
 =?iso-8859-1?Q?RPKnRi9iayM/NGhVODZqGS6x98/Obnz/K5JephGfbj3hfRUN88rL4WQW0V?=
 =?iso-8859-1?Q?pYs5wksmLLCbORNKgq6F3/3YENQHoEOVUPtFJhHrUtOpMd0eeCrFQ2LdRk?=
 =?iso-8859-1?Q?brq0pRBjip580bjhArpW1O2hVIT4knCIQFIg2FIQt6meSMIyFDGRQSXjQv?=
 =?iso-8859-1?Q?PdIStfoX+C40rz33N2J5sIglm2PE8z8fVqiJdb8jJ5PY8U4J6DovDjraxd?=
 =?iso-8859-1?Q?7RQJkii0AQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_GV1PR04MB10750AFB21AF6EF7A5B84F49289A82GV1PR04MB10750eu_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7664b30f-4405-4cdb-257f-08df081360ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 10:25:43.4572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvfW8c54e5k40aUKyB1OF9zTP6c4Ak7Y39hv6izQu6rlPRPQ8GTcOq5K3/VDoimzGlxTcJhp5gycsN76idZqFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216
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

--_000_GV1PR04MB10750AFB21AF6EF7A5B84F49289A82GV1PR04MB10750eu_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On 26-08-2026 22:55, Stephen Hemminger wrote:

On Thu, 20 Aug 2026 20:12:49 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:



This series collects a set of fixes and enhancements for the NXP DPAA
bus, mempool, dma, crypto and net drivers targeting 26.11.

It includes memory-leak and resource-cleanup fixes on the device
remove/close paths, more robust frame queue and congestion-group
shutdown, secondary-process safety guards, BPID and cgrid lifecycle
handling, and several new features: offline (O/H) port device support,
enhanced virtual storage profile (VSP) port support, fmcless Rx queue
configuration via devargs, Rx/Tx taildrop threshold devargs, non
fmX-macY shared Ethernet naming, and DMA scatter-gather and
errata-workaround devargs. Documentation and release notes are updated
accordingly.

v14:
* Dropped the ORP queue create and destructor patch.


Still seeing some issues like double free and unitialized data showing
up on AI review.

Reviewed the v14 series applied on c1a46b9.  All 23 patches apply
cleanly with git am.

Resolved since v13
------------------

Thanks for taking the two structural items off the table:

  - The ORP patch is dropped, so the __rte_internal reachability
    question goes with it.
  - The dpaax enter-destructor patch is dropped, which resolves the
    latch-versus-rte_free() contradiction I raised against v13.

Also confirmed fixed in the applied tree:

  - U48_BY_HI16_LO32() now casts hi to uint64_t before the shift.
  - struct ip_pair_s and struct lgw_subnet_s are prefixed as
    dpa_ip_pair_s and dpa_lgw_subnet_s.
  - The release note for the DMA devargs now describes them as
    controlling existing behaviour ("instead of the default
    scatter-gather batching") rather than claiming SG was added.
  - The devargs section of doc/guides/nics/dpaa.rst is now a proper
    definition list.
  - The offline-port control fd is closed and reset to -1 in
    dpaa_ol_dev_close().

The three Fixes: tags (patches 01, 02, 03) all resolve to real
commits with matching subjects, use 12-character hashes, and carry
Cc: stable@dpdk.org.

Errors
------

Patch 21/23: drivers: add offline (O/H) port device support

  dpaa_ol_remove() double-frees the ethdev private data:

      dpaa_ol_dev_close(eth_dev);
      rte_free(eth_dev->data->dev_private);
      return rte_eth_dev_release_port(eth_dev);

  rte_eth_dev_release_port() already does
  rte_free(eth_dev->data->dev_private) in the primary process (see
  lib/ethdev/ethdev_driver.c), so the pointer is freed twice.  The
  driver does not NULL it in between.

  rte_dpaa_remove() in dpaa_ethdev.c gets this right -- it calls
  rte_eth_dev_release_port() and nothing else -- so the OL path is
  the outlier.  Dropping the rte_free() line is the whole fix.

  Related: unlike rte_dpaa_remove(), which patch 06 gave a
  RTE_PROC_PRIMARY guard, dpaa_ol_remove() has none.  In a secondary
  the explicit rte_free() would also be operating on memory the
  primary owns.


fixed

Patch 18/23: bus/dpaa: optimize DPAA multi-entry buffer pool operations

  bman_release_fast() writes uninitialized stack bytes into the BMan
  release ring.

      struct bm_buffer bm_bufs[FSL_BM_BURST_MAX];   /* no initializer */
      ...
      bm_bufs[0].be_desc.bpid =3D bpid;
      for (i =3D 0; i < num; i++)
              bm_buffer_set64_to_be(&bm_bufs[i], bufs[i]);

      r->bufs[0].opaque =3D bm_bufs[0].opaque;
      if (num > 1)
              memcpy(&r->bufs[1], &bm_bufs[1],
                      sizeof(struct bm_buffer) * (num - 1));

  bm_buffer_set64_to_be() only writes be_desc.hi and be_desc.lo.  Of
  the four fields in struct bm_hw_buf_desc:

      be_desc.rsv    never written for any entry
      be_desc.bpid   written for entry 0 only

  Entry 0 reaches the ring through the .opaque read, which picks up
  the uninitialized rsv byte.  Entries 1..num-1 are memcpy'd whole,
  so they carry both uninitialized rsv and uninitialized bpid.

  The function this replaces does not have the problem, because it
  masks the top 16 bits off explicitly:

      r->bufs[i].opaque =3D cpu_to_be64(bufs[i].opaque & MAX_U48);

  so this is a regression introduced by the rework, not a
  pre-existing issue.  BM_RCR_VERB_CMD_BPID_SINGLE means the garbage
  bpid on entries 1..n-1 is probably ignored by the hardware, but
  rsv is a reserved field and this is stack content being published
  to a device-visible ring on every mbuf free.

  Zeroing the array at declaration is the cheap fix; having
  bm_buffer_set64_to_be() clear .opaque before writing hi/lo would
  also work and keeps the cost on the entries actually used.


fixed

Warnings
--------

Patch 10/23: drivers: add BMI Tx statistics

  fmbm_tfrc, the Tx Frame Counter, is declared but never wired up.
  It is present in struct tx_bmi_regs, it is the register the Tx
  stat window is anchored on --

      #define FMAN_IF_BMI_TX_STAT_OFFSET_START \
              BMI_TX_REG_OFFSET(fmbm_tfrc)

  -- and it is mirrored into struct dpaa_if_tx_bmi_stats, but
  fman_if_bmi_stats_get_all() does not read it,
  fman_if_bmi_stats_reset() does not reset it, and it has no entry
  in dpaa_xstats_strings[].

  That omission is what the "- 1" in the static_assert is absorbing:

      static_assert(sizeof(struct dpaa_if_rx_bmi_stats)
                              / sizeof(uint32_t)
                      + sizeof(struct dpaa_if_tx_bmi_stats)
                              / sizeof(uint32_t) - 1
                      =3D=3D DPAA_BMI_XSTATS_COUNT, ...);

  8 + 5 - 1 =3D=3D 12.  The assert is a good idea, but as written it
  silently tolerates exactly one unexposed struct member, so it will
  not catch the next one.  Either expose fmbm_tfrc (it is the most
  useful of the four Tx counters) and drop the "- 1", or drop the
  member from the struct.  Carrying it in the struct while hiding it
  from the assert is the worst of the three.


fixed

Patch 20/23: net/dpaa: enhance VSP port support

  Two fields added by this patch are never read or written anywhere
  in the tree:

      struct dpaa_if_vsp {
              ...
              uint32_t max_size;      /* no users */
      };

      struct dpaa_if {
              ...
              uint8_t base_vsp;       /* no users */
      };

  bp_num and vsp_bp[] are used; these two are not.  Worth dropping
  until something needs them.


fixed


Patch 06/23: drivers: add process-type guards for secondary process

  The dma/dpaa guard fixes a real problem but leaves the secondary
  in a state that will still fault.

  Returning early from dpaa_qdma_init() does stop the secondary from
  re-running the mmap and re-allocating queue resources on top of
  the shared struct fsl_qdma, which is a genuine improvement.  But
  dpaa_qdma_probe() has already installed dev_ops and every
  fp_obj->* handler before calling init, and it goes on to set
  state =3D RTE_DMA_DEV_READY afterwards.

  fsl_qdma lives in the shared hugepage allocation, so the secondary
  sees the primary's values -- including reg_base, which comes from

      fsl_qdma->reg_base =3D mmap(NULL, regs_size, ...);

  a process-private mapping only valid in the primary.  So a
  secondary that calls rte_dma_copy() on the device gets a READY
  device whose MMIO pointers are not mapped in its address space.

  Either the secondary needs its own mapping kept in process-private
  storage, or probe should not advertise the device as READY for a
  secondary.

fixed


Patch 21/23: drivers: add offline (O/H) port device support

  check_fd() is double-checked locking on a non-atomic int:

      static int fd =3D -1;

      static int check_fd(void)
      {
              if (fd >=3D 0)              /* unsynchronized read */
                      return 0;
              ret =3D pthread_mutex_lock(&fd_init_lock);
              assert(!ret);
              if (fd < 0)
                      fd =3D open(ASK_PATH, O_RDWR);
              ret =3D pthread_mutex_unlock(&fd_init_lock);

  The fast-path read of fd races with the store under the lock.  Per
  the atomics section in AGENTS.md this wants
  rte_atomic_load_explicit(&fd, rte_memory_order_acquire) on the
  first check and rte_atomic_store_explicit(..., release) on the
  assignment, with fd declared as RTE_ATOMIC(int).


fixed

Info
----

Patch 15/23: net/dpaa: support Rx/Tx taildrop threshold devarg

  Carried over from v13 and still unanswered: now that
  drv_tx_taildrop exists, the DPAA_TX_TAILDROP_THRESHOLD getenv()
  fallback in dpaa_dev_init() is redundant.  It is pre-existing code
  so checkpatch will not flag it, but the patch touches that exact
  block, and the new RST documents only the devarg -- the env var is
  now an undocumented second way to set the same value.  Removing it
  here, or noting the deprecation in the release notes, would close
  it out.


we want to keep it for backward compatibility

Patch 18/23: bus/dpaa: optimize DPAA multi-entry buffer pool operations

  BIT_SIZE, MAX_U48, HI16_OF_U48 and LO32_OF_U48 are unprefixed in
  fsl_bman.h.  The header is not installed, so this is not an ABI
  concern, but bus/dpaa exports its include directory to net/dpaa,
  crypto/dpaa_sec, mempool/dpaa and dma/dpaa, and BIT_SIZE and
  MAX_U48 in particular are generic enough to collide there.  The
  #ifndef guard on BIT_SIZE suggests this already came up once.

Patch 21/23: drivers: add offline (O/H) port device support

  ask_get_channel_info() is declared uint32_t but returns -ENODEV
  and ioctl's -1:

      static uint32_t
      ask_get_channel_info(struct ask_ctrl_offline_channel *ch_info)

  It happens to work because the only caller assigns to an int and
  tests if (ret), but ask_set_fq_info() right below it is correctly
  static int.  Worth matching.

  DPA_ISC_IPV4_ADDR_TYPE and friends, and the struct tags
  dpa_ip_addr_s / dpa_ip_pair_s / dpa_lgw_subnet_s, are still
  outside the rte_ namespace in rte_pmd_dpaa_oldev.h, which is an
  installed header.  The DPDK_-prefixed macros in the same header
  are arguably worse -- DPDK_ reads as a framework namespace rather
  than a PMD one.  Not a blocker, but this is the header
  applications will include.

  check_fd() uses assert() from <assert.h>; RTE_ASSERT is the DPDK
  spelling and compiles out consistently with the rest of the tree.

Patch 10/23: drivers: add BMI Tx statistics

  The zero-fill fallbacks in fman_if_bmi_stats_get_all() use bare
  literals:

      while (i < 8)  value[i++] =3D 0;
      ...
      while (i < 12) value[i++] =3D 0;

  These have to stay in step with DPAA_BMI_XSTATS_COUNT on the
  consumer side, which is derived.  Deriving them the same way, or
  at least naming them, keeps the two ends from drifting.

fixed


Patch 06/23: drivers: add process-type guards for secondary process

  Commit message: "net/dpaa rivers" should be "drivers".

git log



NXP Confidential

--_000_GV1PR04MB10750AFB21AF6EF7A5B84F49289A82GV1PR04MB10750eu_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
On 26-08-2026 22:55, Stephen Hemminger wrote:<br>
</div>
<blockquote class=3D"elementToProof">
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">On Thu, 20 Aug 2026 20:1=
2:49 +0530=0A=
Hemant Agrawal &lt;hemant.agrawal@nxp.com&gt; wrote:=0A=
=0A=
</div></pre>
<blockquote class=3D"elementToProof">
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">This series collects a s=
et of fixes and enhancements for the NXP DPAA=0A=
bus, mempool, dma, crypto and net drivers targeting 26.11.=0A=
=0A=
It includes memory-leak and resource-cleanup fixes on the device=0A=
remove/close paths, more robust frame queue and congestion-group=0A=
shutdown, secondary-process safety guards, BPID and cgrid lifecycle=0A=
handling, and several new features: offline (O/H) port device support,=0A=
enhanced virtual storage profile (VSP) port support, fmcless Rx queue=0A=
configuration via devargs, Rx/Tx taildrop threshold devargs, non=0A=
fmX-macY shared Ethernet naming, and DMA scatter-gather and=0A=
errata-workaround devargs. Documentation and release notes are updated=0A=
accordingly.=0A=
=0A=
v14:=0A=
* Dropped the ORP queue create and destructor patch.=0A=
</div></pre>
</blockquote>
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">Still seeing some issues=
 like double free and unitialized data showing=0A=
up on AI review.=0A=
=0A=
Reviewed the v14 series applied on c1a46b9. &nbsp;All 23 patches apply=0A=
cleanly with git am.=0A=
=0A=
Resolved since v13=0A=
------------------=0A=
=0A=
Thanks for taking the two structural items off the table:=0A=
=0A=
 &nbsp;- The ORP patch is dropped, so the __rte_internal reachability=0A=
 &nbsp; &nbsp;question goes with it.=0A=
 &nbsp;- The dpaax enter-destructor patch is dropped, which resolves the=0A=
 &nbsp; &nbsp;latch-versus-rte_free() contradiction I raised against v13.=
=0A=
=0A=
Also confirmed fixed in the applied tree:=0A=
=0A=
 &nbsp;- U48_BY_HI16_LO32() now casts hi to uint64_t before the shift.=0A=
 &nbsp;- struct ip_pair_s and struct lgw_subnet_s are prefixed as=0A=
 &nbsp; &nbsp;dpa_ip_pair_s and dpa_lgw_subnet_s.=0A=
 &nbsp;- The release note for the DMA devargs now describes them as=0A=
 &nbsp; &nbsp;controlling existing behaviour (&quot;instead of the default=
=0A=
 &nbsp; &nbsp;scatter-gather batching&quot;) rather than claiming SG was ad=
ded.=0A=
 &nbsp;- The devargs section of doc/guides/nics/dpaa.rst is now a proper=0A=
 &nbsp; &nbsp;definition list.=0A=
 &nbsp;- The offline-port control fd is closed and reset to -1 in=0A=
 &nbsp; &nbsp;dpaa_ol_dev_close().=0A=
=0A=
The three Fixes: tags (patches 01, 02, 03) all resolve to real=0A=
commits with matching subjects, use 12-character hashes, and carry=0A=
Cc: stable@dpdk.org.=0A=
=0A=
Errors=0A=
------=0A=
=0A=
Patch 21/23: drivers: add offline (O/H) port device support=0A=
=0A=
 &nbsp;dpaa_ol_remove() double-frees the ethdev private data:=0A=
=0A=
 &nbsp; &nbsp; &nbsp;dpaa_ol_dev_close(eth_dev);=0A=
 &nbsp; &nbsp; &nbsp;rte_free(eth_dev-&gt;data-&gt;dev_private);=0A=
 &nbsp; &nbsp; &nbsp;return rte_eth_dev_release_port(eth_dev);=0A=
=0A=
 &nbsp;rte_eth_dev_release_port() already does=0A=
 &nbsp;rte_free(eth_dev-&gt;data-&gt;dev_private) in the primary process (s=
ee=0A=
 &nbsp;lib/ethdev/ethdev_driver.c), so the pointer is freed twice. &nbsp;Th=
e=0A=
 &nbsp;driver does not NULL it in between.=0A=
=0A=
 &nbsp;rte_dpaa_remove() in dpaa_ethdev.c gets this right -- it calls=0A=
 &nbsp;rte_eth_dev_release_port() and nothing else -- so the OL path is=0A=
 &nbsp;the outlier. &nbsp;Dropping the rte_free() line is the whole fix.=0A=
=0A=
 &nbsp;Related: unlike rte_dpaa_remove(), which patch 06 gave a=0A=
 &nbsp;RTE_PROC_PRIMARY guard, dpaa_ol_remove() has none. &nbsp;In a second=
ary=0A=
 &nbsp;the explicit rte_free() would also be operating on memory the=0A=
 &nbsp;primary owns.=0A=
</div></pre>
</blockquote>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
fixed </div>
<blockquote class=3D"elementToProof">
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">Patch 18/23: bus/dpaa: o=
ptimize DPAA multi-entry buffer pool operations=0A=
=0A=
 &nbsp;bman_release_fast() writes uninitialized stack bytes into the BMan=
=0A=
 &nbsp;release ring.=0A=
=0A=
 &nbsp; &nbsp; &nbsp;struct bm_buffer bm_bufs[FSL_BM_BURST_MAX]; &nbsp; /* =
no initializer */=0A=
 &nbsp; &nbsp; &nbsp;...=0A=
 &nbsp; &nbsp; &nbsp;bm_bufs[0].be_desc.bpid =3D bpid;=0A=
 &nbsp; &nbsp; &nbsp;for (i =3D 0; i &lt; num; i++)=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bm_buffer_set64_to_be(&amp=
;bm_bufs[i], bufs[i]);=0A=
=0A=
 &nbsp; &nbsp; &nbsp;r-&gt;bufs[0].opaque =3D bm_bufs[0].opaque;=0A=
 &nbsp; &nbsp; &nbsp;if (num &gt; 1)=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;memcpy(&amp;r-&gt;bufs[1],=
 &amp;bm_bufs[1],=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;sizeof(struct bm_buffer) * (num - 1));=0A=
=0A=
 &nbsp;bm_buffer_set64_to_be() only writes be_desc.hi and be_desc.lo. &nbsp=
;Of=0A=
 &nbsp;the four fields in struct bm_hw_buf_desc:=0A=
=0A=
 &nbsp; &nbsp; &nbsp;be_desc.rsv &nbsp; &nbsp;never written for any entry=
=0A=
 &nbsp; &nbsp; &nbsp;be_desc.bpid &nbsp; written for entry 0 only=0A=
=0A=
 &nbsp;Entry 0 reaches the ring through the .opaque read, which picks up=0A=
 &nbsp;the uninitialized rsv byte. &nbsp;Entries 1..num-1 are memcpy'd whol=
e,=0A=
 &nbsp;so they carry both uninitialized rsv and uninitialized bpid.=0A=
=0A=
 &nbsp;The function this replaces does not have the problem, because it=0A=
 &nbsp;masks the top 16 bits off explicitly:=0A=
=0A=
 &nbsp; &nbsp; &nbsp;r-&gt;bufs[i].opaque =3D cpu_to_be64(bufs[i].opaque &a=
mp; MAX_U48);=0A=
=0A=
 &nbsp;so this is a regression introduced by the rework, not a=0A=
 &nbsp;pre-existing issue. &nbsp;BM_RCR_VERB_CMD_BPID_SINGLE means the garb=
age=0A=
 &nbsp;bpid on entries 1..n-1 is probably ignored by the hardware, but=0A=
 &nbsp;rsv is a reserved field and this is stack content being published=0A=
 &nbsp;to a device-visible ring on every mbuf free.=0A=
=0A=
 &nbsp;Zeroing the array at declaration is the cheap fix; having=0A=
 &nbsp;bm_buffer_set64_to_be() clear .opaque before writing hi/lo would=0A=
 &nbsp;also work and keeps the cost on the entries actually used.=0A=
</div></pre>
</blockquote>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
fixed </div>
<blockquote class=3D"elementToProof">
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">Warnings=0A=
--------=0A=
=0A=
Patch 10/23: drivers: add BMI Tx statistics=0A=
=0A=
 &nbsp;fmbm_tfrc, the Tx Frame Counter, is declared but never wired up.=0A=
 &nbsp;It is present in struct tx_bmi_regs, it is the register the Tx=0A=
 &nbsp;stat window is anchored on --=0A=
=0A=
 &nbsp; &nbsp; &nbsp;#define FMAN_IF_BMI_TX_STAT_OFFSET_START \=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;BMI_TX_REG_OFFSET(fmbm_tfr=
c)=0A=
=0A=
 &nbsp;-- and it is mirrored into struct dpaa_if_tx_bmi_stats, but=0A=
 &nbsp;fman_if_bmi_stats_get_all() does not read it,=0A=
 &nbsp;fman_if_bmi_stats_reset() does not reset it, and it has no entry=0A=
 &nbsp;in dpaa_xstats_strings[].=0A=
=0A=
 &nbsp;That omission is what the &quot;- 1&quot; in the static_assert is ab=
sorbing:=0A=
=0A=
 &nbsp; &nbsp; &nbsp;static_assert(sizeof(struct dpaa_if_rx_bmi_stats)=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;/ sizeof(uint32_t)=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;+ sizeof(struct dpaa_if_tx_bmi_stats)=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;/ sizeof(uint32_t) - 1=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;=3D=3D DPAA_BMI_XSTATS_COUNT, ...);=0A=
=0A=
 &nbsp;8 + 5 - 1 =3D=3D 12. &nbsp;The assert is a good idea, but as written=
 it=0A=
 &nbsp;silently tolerates exactly one unexposed struct member, so it will=
=0A=
 &nbsp;not catch the next one. &nbsp;Either expose fmbm_tfrc (it is the mos=
t=0A=
 &nbsp;useful of the four Tx counters) and drop the &quot;- 1&quot;, or dro=
p the=0A=
 &nbsp;member from the struct. &nbsp;Carrying it in the struct while hiding=
 it=0A=
 &nbsp;from the assert is the worst of the three.=0A=
</div></pre>
</blockquote>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
fixed </div>
<blockquote class=3D"elementToProof">
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">Patch 20/23: net/dpaa: e=
nhance VSP port support=0A=
=0A=
 &nbsp;Two fields added by this patch are never read or written anywhere=0A=
 &nbsp;in the tree:=0A=
=0A=
 &nbsp; &nbsp; &nbsp;struct dpaa_if_vsp {=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;...=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;uint32_t max_size; &nbsp; =
&nbsp; &nbsp;/* no users */=0A=
 &nbsp; &nbsp; &nbsp;};=0A=
=0A=
 &nbsp; &nbsp; &nbsp;struct dpaa_if {=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;...=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;uint8_t base_vsp; &nbsp; &=
nbsp; &nbsp; /* no users */=0A=
 &nbsp; &nbsp; &nbsp;};=0A=
=0A=
 &nbsp;bp_num and vsp_bp[] are used; these two are not. &nbsp;Worth droppin=
g=0A=
 &nbsp;until something needs them.=0A=
</div></pre>
</blockquote>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
fixed</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<blockquote class=3D"elementToProof">
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">Patch 06/23: drivers: ad=
d process-type guards for secondary process=0A=
=0A=
 &nbsp;The dma/dpaa guard fixes a real problem but leaves the secondary=0A=
 &nbsp;in a state that will still fault.=0A=
=0A=
 &nbsp;Returning early from dpaa_qdma_init() does stop the secondary from=
=0A=
 &nbsp;re-running the mmap and re-allocating queue resources on top of=0A=
 &nbsp;the shared struct fsl_qdma, which is a genuine improvement. &nbsp;Bu=
t=0A=
 &nbsp;dpaa_qdma_probe() has already installed dev_ops and every=0A=
 &nbsp;fp_obj-&gt;* handler before calling init, and it goes on to set=0A=
 &nbsp;state =3D RTE_DMA_DEV_READY afterwards.=0A=
=0A=
 &nbsp;fsl_qdma lives in the shared hugepage allocation, so the secondary=
=0A=
 &nbsp;sees the primary's values -- including reg_base, which comes from=0A=
=0A=
 &nbsp; &nbsp; &nbsp;fsl_qdma-&gt;reg_base =3D mmap(NULL, regs_size, ...);=
=0A=
=0A=
 &nbsp;a process-private mapping only valid in the primary. &nbsp;So a=0A=
 &nbsp;secondary that calls rte_dma_copy() on the device gets a READY=0A=
 &nbsp;device whose MMIO pointers are not mapped in its address space.=0A=
=0A=
 &nbsp;Either the secondary needs its own mapping kept in process-private=
=0A=
 &nbsp;storage, or probe should not advertise the device as READY for a=0A=
 &nbsp;secondary.</div></pre>
</blockquote>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
fixed </div>
<blockquote class=3D"elementToProof">
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">=0A=
Patch 21/23: drivers: add offline (O/H) port device support=0A=
=0A=
 &nbsp;check_fd() is double-checked locking on a non-atomic int:=0A=
=0A=
 &nbsp; &nbsp; &nbsp;static int fd =3D -1;=0A=
=0A=
 &nbsp; &nbsp; &nbsp;static int check_fd(void)=0A=
 &nbsp; &nbsp; &nbsp;{=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (fd &gt;=3D 0) &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* unsynchronized read */=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;return 0;=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret =3D pthread_mutex_lock=
(&amp;fd_init_lock);=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;assert(!ret);=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (fd &lt; 0)=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;fd =3D open(ASK_PATH, O_RDWR);=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret =3D pthread_mutex_unlo=
ck(&amp;fd_init_lock);=0A=
=0A=
 &nbsp;The fast-path read of fd races with the store under the lock. &nbsp;=
Per=0A=
 &nbsp;the atomics section in AGENTS.md this wants=0A=
 &nbsp;rte_atomic_load_explicit(&amp;fd, rte_memory_order_acquire) on the=
=0A=
 &nbsp;first check and rte_atomic_store_explicit(..., release) on the=0A=
 &nbsp;assignment, with fd declared as RTE_ATOMIC(int).=0A=
</div></pre>
</blockquote>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
fixed </div>
<blockquote class=3D"elementToProof">
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">Info=0A=
----=0A=
=0A=
Patch 15/23: net/dpaa: support Rx/Tx taildrop threshold devarg=0A=
=0A=
 &nbsp;Carried over from v13 and still unanswered: now that=0A=
 &nbsp;drv_tx_taildrop exists, the DPAA_TX_TAILDROP_THRESHOLD getenv()=0A=
 &nbsp;fallback in dpaa_dev_init() is redundant. &nbsp;It is pre-existing c=
ode=0A=
 &nbsp;so checkpatch will not flag it, but the patch touches that exact=0A=
 &nbsp;block, and the new RST documents only the devarg -- the env var is=
=0A=
 &nbsp;now an undocumented second way to set the same value. &nbsp;Removing=
 it=0A=
 &nbsp;here, or noting the deprecation in the release notes, would close=0A=
 &nbsp;it out.=0A=
</div></pre>
</blockquote>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
we want to keep it for backward compatibility </div>
<blockquote class=3D"elementToProof">
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">Patch 18/23: bus/dpaa: o=
ptimize DPAA multi-entry buffer pool operations=0A=
=0A=
 &nbsp;BIT_SIZE, MAX_U48, HI16_OF_U48 and LO32_OF_U48 are unprefixed in=0A=
 &nbsp;fsl_bman.h. &nbsp;The header is not installed, so this is not an ABI=
=0A=
 &nbsp;concern, but bus/dpaa exports its include directory to net/dpaa,=0A=
 &nbsp;crypto/dpaa_sec, mempool/dpaa and dma/dpaa, and BIT_SIZE and=0A=
 &nbsp;MAX_U48 in particular are generic enough to collide there. &nbsp;The=
=0A=
 &nbsp;#ifndef guard on BIT_SIZE suggests this already came up once.=0A=
=0A=
Patch 21/23: drivers: add offline (O/H) port device support=0A=
=0A=
 &nbsp;ask_get_channel_info() is declared uint32_t but returns -ENODEV=0A=
 &nbsp;and ioctl's -1:=0A=
=0A=
 &nbsp; &nbsp; &nbsp;static uint32_t=0A=
 &nbsp; &nbsp; &nbsp;ask_get_channel_info(struct ask_ctrl_offline_channel *=
ch_info)=0A=
=0A=
 &nbsp;It happens to work because the only caller assigns to an int and=0A=
 &nbsp;tests if (ret), but ask_set_fq_info() right below it is correctly=0A=
 &nbsp;static int. &nbsp;Worth matching.=0A=
=0A=
 &nbsp;DPA_ISC_IPV4_ADDR_TYPE and friends, and the struct tags=0A=
 &nbsp;dpa_ip_addr_s / dpa_ip_pair_s / dpa_lgw_subnet_s, are still=0A=
 &nbsp;outside the rte_ namespace in rte_pmd_dpaa_oldev.h, which is an=0A=
 &nbsp;installed header. &nbsp;The DPDK_-prefixed macros in the same header=
=0A=
 &nbsp;are arguably worse -- DPDK_ reads as a framework namespace rather=0A=
 &nbsp;than a PMD one. &nbsp;Not a blocker, but this is the header=0A=
 &nbsp;applications will include.=0A=
=0A=
 &nbsp;check_fd() uses assert() from &lt;assert.h&gt;; RTE_ASSERT is the DP=
DK=0A=
 &nbsp;spelling and compiles out consistently with the rest of the tree.=0A=
=0A=
Patch 10/23: drivers: add BMI Tx statistics=0A=
=0A=
 &nbsp;The zero-fill fallbacks in fman_if_bmi_stats_get_all() use bare=0A=
 &nbsp;literals:=0A=
=0A=
 &nbsp; &nbsp; &nbsp;while (i &lt; 8) &nbsp;value[i++] =3D 0;=0A=
 &nbsp; &nbsp; &nbsp;...=0A=
 &nbsp; &nbsp; &nbsp;while (i &lt; 12) value[i++] =3D 0;=0A=
=0A=
 &nbsp;These have to stay in step with DPAA_BMI_XSTATS_COUNT on the=0A=
 &nbsp;consumer side, which is derived. &nbsp;Deriving them the same way, o=
r=0A=
 &nbsp;at least naming them, keeps the two ends from drifting.</div></pre>
</blockquote>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
fixed </div>
<blockquote class=3D"elementToProof">
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">=0A=
Patch 06/23: drivers: add process-type guards for secondary process=0A=
=0A=
 &nbsp;Commit message: &quot;net/dpaa rivers&quot; should be &quot;drivers&=
quot;.=0A=
=0A=
git log =0A=
</div></pre>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div><br>
<div style=3D"font-family: Calibri; text-align: center; color: rgb(0, 0, 0)=
; margin-left: 5pt; font-size: 10pt;">
NXP Confidential</div>
</div>
</body>
</html>

--_000_GV1PR04MB10750AFB21AF6EF7A5B84F49289A82GV1PR04MB10750eu_--
