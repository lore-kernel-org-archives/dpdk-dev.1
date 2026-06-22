Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6200CD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:36:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4F564064F;
	Mon, 22 Jun 2026 13:36:41 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
 by mails.dpdk.org (Postfix) with ESMTP id A2F1540150
 for <dev@dpdk.org>; Mon, 22 Jun 2026 13:36:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ini5jtJjIyJcE4IfVwdumtJqxYDpARZvB5Ab6k1vsB8CBWly14MYtgeCeMAxkxubA5+p99TcdypygBOb8kw5h2QpOomv6XNxkdhd+IauJ7GeudC+l/lo3msNIl9lvfUQimebOSw6bm7vhaie/MPZQ6sx2+r4/R/Zd+B8ITiOvDMuJajqKcXwy4iWOrZdAUqBXKmipoSdMPI/rEhfbJHQKsmwiM8lxsCUzsOS+LYWilTye1KEn2BQCr9i/0xW/DwzNezgi2RjM17CjYYpgz6EjMF7u4CQA5OWdtDpAaa8onsjYzxkDIOvn/eDajcNKrgX3bRCoCC71yIePN/WOJsfag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVXcViEM81SQf61bnAEEp+bV/9V9Kv0DBQ2Bqu5pdnA=;
 b=YG+Io2K7g1xVIduD4aX+DCxIjaeeXK0jnJOV5exbz3BBXrJIAI6GoOLMe95HECNTnJ9yibfZdr+vD2uU3hyyKaDT12ZuEn4LbgvvzNCmEywOWLk5IXJmlf/uS3Y5NAXonpt6wMJbkZmFbXlcirqhyTqEKwaSHQ73SaS4KR5Cx2og1YmdHQRFtlzbtDj8ySwHF3hNIUFpwrmk5BsYxZA4zw4mcaREV5vvfwK1zH4/e6gyFkggLUUonnsTTgLq60CXGGI60hFImUalpfmqa4W8Oy70y2WGcuDw4vhggx03w5l49djvIPEF1ihhH187+PN7jKuNJY09VU+ZYYlp0InzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVXcViEM81SQf61bnAEEp+bV/9V9Kv0DBQ2Bqu5pdnA=;
 b=fSqPc/jdhx/TunK68e1KefoKRlsDpo3VifsjLTujAgZwXyJifx86mjbMo1U1H0P1D9HryLd01g2uk/360/v9sdhX2Y60xadbbcKN6IRuro4KfhK4I3WpdVnZvwhFCRbIV4FRgemB8zdw5/K9J+zpteHwJdwEdIodBU4hC8UIUtGUUGKoBtLpuYoJDphEuQUScmBAcJbceO0gURlKtG62vmcd2KDwbGasLs/rfzC68eJW7zcL9y3NxJQZfkItGBD7wtiFbMGYrI1vtQEWrIfNIx7AVD6PgcUnYGkkjahXAUEE/wvM0DRpY9mJM7ta90YpEjXQGrf3uVgyDZIFkj5e3A==
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 (2603:10a6:20b:725::21) by PA2PR04MB10157.eurprd04.prod.outlook.com
 (2603:10a6:102:409::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 11:36:39 +0000
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf]) by AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf%6]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 11:36:38 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: RE: [PATCH 00/10] NXP ENETC driver related changes
Thread-Topic: [PATCH 00/10] NXP ENETC driver related changes
Thread-Index: AQHdABus72NDf3tJN0q95hwye9imz7ZGaSYAgAQNNFA=
Date: Mon, 22 Jun 2026 11:36:38 +0000
Message-ID: <AMBPR04MB122816887ABD8D77E44AAF547E1EF2@AMBPR04MB12281.eurprd04.prod.outlook.com>
References: <20260619184427.522518-1-g.singh@nxp.com>
 <20260619144336.1f9c46f2@phoenix.local>
In-Reply-To: <20260619144336.1f9c46f2@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB12281:EE_|PA2PR04MB10157:EE_
x-ms-office365-filtering-correlation-id: 581b5c77-c1f0-41e1-4520-08ded0528622
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|19092799006|56012099006|11063799006|4143699003|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: 1EWyYDVj4TnV8oMSCuc09LuzDUsAMlJdEXvYi5FXkzcRCGVVcZ+J8f77ckYfwZSNw+whaot3BGEajkoA2TNSgLLc9+UlpwOff1iQOUxq9pFPrJD569fm5Vdt9uDSmXszytdY4uq6eDZS/r5JeyS93JPBuR7Rw92gR4DP55b7Kk50YB3n9WjvzGmJB/FGNWjeeEt245N5lJjNo7Q9WWUVMPivZZcDVDU1m/bvJGe1xGLQFm84/q3/g9kU1DQl3c9YaLbmx2thRZ4ptveEHoq3NlFnDAfPd2SLZk0KsY0oRUW00Ad4Jh0YvLgfpysl8mJGPJmhBQ92QGQv0wG9vA7NhqNliPFTEk06s1+FcYHR7esPYeAqzPZ0/Mj5MFRLTuNAL9vrNjzXUVST4dzWiyCA3cG6sbzdtf1yVeRHDrrPVfelQ6FKArCSxLl4ASjNQmxSx4gsHKzMz//iO7oIPQ/oChgAxBVjDFHQVzFheguUWq8HqsICTicvyUcmlkmzuvi6aoP69Jp2vDYlvGwFpceIocWkavC23LcMg/AkfsjB36tWRB1gupXd2LV26dsR53+GIDG2oi+iYzdP+DUZZOTD9SwLrA+d0iXLqC/arg7rJjYHjx5q5M5pcDBl5m9qadBGVqmAWRYLURRcayrrfBYU/62imz2vxvPOpq6H8LbIlHcbf7j02gpIZ5zJZL+hgrfe3THCnxMhuzkOhMP+ycd5plABoaIjIn4XScc3sDGxITE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12281.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(19092799006)(56012099006)(11063799006)(4143699003)(6133799003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s0tJB2YBy5KFyLjhrR+W1AiImdqlQurJp5bPehQS3zV5TK84d28Y9IWPYSGR?=
 =?us-ascii?Q?XmYavKwDCqRhlFXA2vrvftTC8it/vJ1vt8ffj1II/F+JLzhFx2x4aZuZHEIv?=
 =?us-ascii?Q?Ci4IJZrjw303AVjrOZaLNEkQZtVVe3JgYrcV8XIhu1BaJtZ1ME19tk5tO2Sr?=
 =?us-ascii?Q?Ccxo28ns+0DFlhsjNx+SGjRFNvJodcAqPM8EkyRxwGfbeo3VqtZtY+fljaaM?=
 =?us-ascii?Q?EerDnbh8aCiCKWfggP/KzCRRpF27DjzAgDMMvV98grgF1vNomhF/ymlv7Mqq?=
 =?us-ascii?Q?OyuSs9HIjKOktvTKjh00iOHhBEecm806RcH+hO+5SD5FKtgxwgWY1+dXgAk+?=
 =?us-ascii?Q?o2mb8uzOFKjKvY/eaBauJSzgGhhYneO1qS0IHIZa8SZVrjlfHv1mZ07eewsI?=
 =?us-ascii?Q?aE31gxs6Ebc/HtMJZZyWD0UhEXh7ndZDPMzONbOyy6QRPGnmoIiU7GzHgPCi?=
 =?us-ascii?Q?lLtX2QW7cFrssYG5ViB+0VjMqKfAaWrWParrDIxHmeUOxbIYDKcX8cmF+gvW?=
 =?us-ascii?Q?3/24f+VG43xO0PjY5adPAOOmfltl0duYv+Eg+bJtZGWXIAE6LXncq0uRETPP?=
 =?us-ascii?Q?mUvQYhY2yS0hg129DE2iZ6QhyiGGBz64zx76vFGvkXrGPByGAkTzWKirvtcn?=
 =?us-ascii?Q?lM8jwe6GCeK9qGCRNBjoWGqZl/4t6NRsue1SWkC7Wj0Q76EP2i9z69QSDkBy?=
 =?us-ascii?Q?TeMOvl/qlWrxxBvwu5TrNdF9amIP5eZp3TZTiL5zexOBFFz6STbezdR3mLSk?=
 =?us-ascii?Q?FCCUmJWd/P3V3zv9tRNulTIlt1JVdtHo3N1KNYx8Z52cQttYgmKUkIjPQ61e?=
 =?us-ascii?Q?pe+ADY7/WGvwKkGeFcpqEeWFfNTYNQwCKO+tPsqfNHnniyl2DnRWqnRAcS8x?=
 =?us-ascii?Q?0eLfN8vu1oqyrzoALXDGoL4CYtwaX/Dym4jJzgFTFLCN7SWXrYPYWKbrsPV8?=
 =?us-ascii?Q?k099ACIIIiaEhDUybcgs94EbQUZvhuKCp28b7GuU974hZ5xcirMV73SROgac?=
 =?us-ascii?Q?2sNaKEe4Aw9gOi8g7Zb7y5vMTizfNjjS3H8VJJVvRCUjESrlBqj832qDLLls?=
 =?us-ascii?Q?tF6ojWjPzu5L6gJsNGY99aCZ7CZER0yMWha/CiLf1R+iwP7KIihvWzRZDDnK?=
 =?us-ascii?Q?dMGlqa0MIpl6Z2Gv/5tTY1tyiAnvERwFBVVBV0p/sLlwbMygzS462Asn8xCl?=
 =?us-ascii?Q?kQeR+ikTEnQg3MANnUmaLskCuuqzqm15YfzsOhVKkjw1LEQpyYYJHsaw+TRC?=
 =?us-ascii?Q?tm7Dyt06yh65Lb9vGxVXB85vVYPWkJoNxWeCgz8/Tro0s0zFTiR0Lr6fZmOh?=
 =?us-ascii?Q?cPB8MbGjQULrYBDjwvV9OM4aDMV6MMVzr3KUxVoRJgkc+kx2y8sDDfhR9uNw?=
 =?us-ascii?Q?gE8xHlo6fYvK7kqpxcN6vL3q79mH09Y9o83oOcwgrUi3DGGn3/2Nw/aJqlQl?=
 =?us-ascii?Q?bgvK2NBtt7gZl787ZBsiqhvu38h67KS+LNVARUlOWJRYt+V8kOpYgLS5MQQ/?=
 =?us-ascii?Q?TMnpNykYQ6XusFy+BlUuxDiM1zxB9TzAnWm6Z0OnY6VnlAjRrjZhKNUzBWTK?=
 =?us-ascii?Q?KFU3FwWWSwHsmXHw7TbM2hKmWACxMXE+1fMBvokVZhlCpcKFPEXG/WuzbLU+?=
 =?us-ascii?Q?QLOtfVRhS9rIzzSlw6na31E8davQupm5RGP2Xges5TRS6vf1z8HkJ1lUKR7J?=
 =?us-ascii?Q?fStpCIDt09AG04rqDy1olf5xxuLnGzgYUkij3ls/c8Ik5nTI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12281.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581b5c77-c1f0-41e1-4520-08ded0528622
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 11:36:38.9212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7bZcRZ3woyBR+/NELI+G/qu9Nm6j/fhpWCIxivT8EpeUpd7nr15Ew2OXcckkOLE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10157
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
> Sent: Saturday, June 20, 2026 3:14 AM
> To: Gagandeep Singh <G.Singh@nxp.com>
> Cc: dev@dpdk.org; Hemant Agrawal <hemant.agrawal@nxp.com>
> Subject: Re: [PATCH 00/10] NXP ENETC driver related changes
>=20
> On Sat, 20 Jun 2026 00:14:17 +0530
> Gagandeep Singh <g.singh@nxp.com> wrote:
>=20
> > ENETC driver related changes series
> >
> > Gagandeep Singh (8):
> >   net/enetc: fix TX BD structure
> >   net/enetc: fix TX BDs flag overwrite issue
> >   net/enetc: fix queue initialization
> >   net/enetc: support ESP packet type in packet parsing
> >   net/enetc: update random MAC generation code
> >   net/enetc: add option to disable VSI messaging
> >   net/enetc: add devargs to control VSI-PSI timeout and delay
> >   net/enetc4: add cacheable BD ring support with SW cache maintenance
> >
> > Vanshika Shukla (2):
> >   net/enetc: support scatter-gather
> >   net/enetc: set user configurable priority to TX rings
> >
> >  drivers/net/enetc/base/enetc_hw.h |  13 +-
> >  drivers/net/enetc/enetc.h         |  28 +-
> >  drivers/net/enetc/enetc4_ethdev.c | 123 +++++++--
> >  drivers/net/enetc/enetc4_vf.c     | 159 ++++++++++--
> >  drivers/net/enetc/enetc_ethdev.c  |  26 +-
> >  drivers/net/enetc/enetc_rxtx.c    | 411 ++++++++++++++++++++++++++----
> >  6 files changed, 649 insertions(+), 111 deletions(-)
> >
>=20
> The AI review shows some thing that need to be addressed before merging.
>=20
> [PATCH 04/10] net/enetc: support ESP packet type
>=20
> Info: enetc_supported_ptypes_get() adds RTE_PTYPE_TUNNEL_ESP and a traili=
ng
> RTE_PTYPE_UNKNOWN. *no_of_elements is RTE_DIM(ptypes), so the
> 0 entry is counted (not used as a sentinel). It is filtered out by the ma=
sk test in
> rte_eth_dev_get_supported_ptypes(), so harmless, but the
> RTE_PTYPE_UNKNOWN line is unnecessary and should be dropped.
>=20
>=20
> [PATCH 06/10] net/enetc: support scatter-gather
>=20
> Warning: scatter Rx reassembly state (first_seg/cur_seg) is held in local=
 variables
> and reset on every call. rx_frm_cnt only advances on the F bit, so work_l=
imit
> won't cut a frame, but the "!(bd_status & LSTATUS_R)" break can exit mid-=
frame
> if HW has written the leading segments of a multi-segment frame but not y=
et the
> segment carrying F. On the next call first_seg is NULL again, next_to_cle=
an has
> already advanced past the consumed leading segments, and those mbufs are
> leaked while the tail segments are mis-assembled as a new frame.
> Persist the partial chain across bursts in the ring (e.g.
> rx_ring->pkt_first_seg / pkt_last_seg) instead of locals. (Same pattern i=
s
> reproduced in enetc_clean_rx_ring_cacheable in patch 10.)
>=20
> Warning: enetc4 now advertises RTE_ETH_RX_OFFLOAD_SCATTER and
> RTE_ETH_TX_OFFLOAD_MULTI_SEGS (VF) but doc/guides/nics/features/
> enetc4.ini is not updated (Scattered Rx / Multi segment rows).
>=20
> Info: the VF dev_info now advertises L3/L4 RX checksum offload, but
> enetc_dev_rx_parse() unconditionally sets RTE_MBUF_F_RX_IP_CKSUM_GOOD |
> RTE_MBUF_F_RX_L4_CKSUM_GOOD and never reports *_BAD. With the offload
> now advertised, an application relying on it will never see a bad-checksu=
m
> indication.
>=20
> Info: dccivac(data + (data_len - 1)) / dcbf(data + (seg_len - 1)) underfl=
ow to data-1
> when the segment length is 0 (uint16_t promotes to int). The preceding lo=
op
> already covers the final cache line, so the extra op is redundant as well=
 as unsafe
> for len=3D=3D0.
>=20
>=20
> [PATCH 07/10] net/enetc: add option to disable VSI messaging
>=20
> Warning: new devarg "enetc4_vsi_disable" is registered but not documented=
 in
> doc/guides/nics/enetc.rst.
>=20
>=20
> [PATCH 08/10] net/enetc: add devargs to control VSI-PSI timeout/delay
>=20
> Warning: new devargs "enetc4_vsi_timeout" / "enetc4_vsi_delay" are not
> documented in doc/guides/nics/enetc.rst.
>=20
>=20
> [PATCH 09/10] net/enetc: set user configurable priority to TX rings
>=20
> Error: hw->txq_prior is allocated in parse_txq_prior() with
> rte_zmalloc() but never freed. It leaks on dev_close / re-probe. Free it =
in the
> close/uninit path (and note it is re-allocated every time the handler run=
s, so a
> repeated key would leak the prior allocation too).
>=20
> Warning: txq_prior is control-path, CPU-only data; rte_zmalloc() consumes
> hugepage memory unnecessarily. Use calloc()/malloc().
>=20
> Warning: the parsed value is OR'd straight into TBMR:
> 	tx_en |=3D priv->hw.txq_prior[tx_ring->index];
> with no mask. ENETC_TBMR_EN is BIT(31) and there is no TBMR priority mask
> defined. A user value with high bits set can corrupt unrelated TBMR contr=
ol bits.
> Mask the input to the valid TBMR priority field.
>=20
> Info: strdup(value) return is not checked; on failure strtok(input_str, "=
|") is called
> with a NULL first argument, which resumes from strtok's stale internal st=
ate
> rather than erroring.
>=20
> Warning: new devarg "enetc4_txq_prior" not documented in
> doc/guides/nics/enetc.rst.
>=20
>=20
> [PATCH 10/10] net/enetc4: add cacheable BD ring support with SW cache
>=20
> Warning: enetc4_dev_hw_init() switches rx_pkt_burst/tx_pkt_burst to the c=
ache-
> maintenance variants unconditionally for every enetc4 device (PF and VF).=
 The
> commit message scopes this to non-cache-coherent parts (i.MX95), but the =
code
> applies it everywhere, adding dcbf/dccivac cost on cache-coherent platfor=
ms that
> previously used the _nc fast path. Gate it on a devarg or coherency/platf=
orm
> check.
>=20
> Warning: the RX payload invalidation uses dccivac (dc civac =3D
> clean+invalidate). The comment justifies clean-then-invalidate for the
> BD ring (refill dcbf leaves BD lines clean), but payload buffers are not =
cleaned
> before being handed to HW. If a payload cache line is dirty (stale CPU da=
ta from a
> prior use of the mbuf), the clean phase writes it back over the HW-DMA'd =
data in
> DDR before invalidating -> silent RX corruption on a non-coherent part. P=
lease
> confirm payload lines can never be dirty here, or use invalidate-only.
>=20
> Info: struct enetc_bdr gains "uint64_t bd_base_p" but it is never referen=
ced
> anywhere. Remove the dead field.
>=20
> Info: the 64-bit BD fast copy
> 	__uint128_t *dst128 =3D (__uint128_t *)&rxbd_temp;
> 	*dst128 =3D *(const __uint128_t *)rxbd;
> takes the address of an 8-byte-aligned stack union (rxbd_temp) as __uint1=
28_t*.
> That is an under-aligned 128-bit access (UB); aarch64 tolerates it via ld=
p/stp but
> it is fragile. Force 16-byte alignment on rxbd_temp or copy as two u64.
>=20
>=20
> General (series-wide)
>=20
> Warning: no release notes. The series adds user-visible features (scatter=
-gather,
> cacheable BD ring support, four new devargs) with no entry in
> doc/guides/rel_notes/. New driver capabilities and devargs need release-n=
ote
> coverage.

I have sent the V2 series which includes most of the fixes. I have mentione=
d all the fixes in the cover-letter.

Thanks,
Gagan
