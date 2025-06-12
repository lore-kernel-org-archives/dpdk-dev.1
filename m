Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C35C61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:10:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A2844021F;
	Thu, 12 Jun 2025 13:10:04 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by mails.dpdk.org (Postfix) with ESMTP id 119424003C
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:10:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnfVeoj0fHAude1PXrZtSTBjLiqZw+rfyxbq1oQ2ASP4zhUKPNqGiQpU5gzz19eBPMYxCQbbj6b/Alh7Hn2BrE0mOJOznf1l4H5HuLB/8rhoftmCQ4j1oNw3M7qGiYVXh4IX2eg/RiSbNTXreRwDughicPleQLTZ+Zfyn9uiZLUqg5nFrtW6/RZxQ2zu178e1Amy+omqimX2B7EosKJVCLWnT8qs4QMQ3HdwSmWfmz9iqkSvxhVV4OglaEAPwuuGWH7Sxdndd/ItMIcTszuj2gc3A+7I835mulmsw4mO55sIxkgYH+Zrti4Sq3zWBvSuFVoEyUKSyTNFuPOI/1dXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wfXiTKdLl2Fo7br4FmiLuJIFRy3vpyDIg/ZIRFxdEs=;
 b=wSLF7HdHhcDQl+f5JHWfZg4wTCUS9RrcaEMjaTUk2Ab7T1ViwfOOdNoJeg90YuvPaiKazsUS1iGAR/s4mLZhdbWJDDczzBwnVF3SCvOUdBC+o+BrB5tLm6s5POv+zTO4glW4Kce9hDnbYEN1rF8oX1IztZ+JzZgyRUvZbOI3N8Dw+rSF8v0Tf0StSXbJsfAk1Q9fhGcWf+FlLEGoqU7C3FEcZRJThuJvJvLr4LjK4+cyHwVV5o8HTbFh0zXV1dxjJU01HGKf68CfwQuK3/QyxZGT/FxBSiwvFEITd0E+j3hXLo8RnUthB1JqmiTtorjUag0oDXvhWUm6D1QGccP89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wfXiTKdLl2Fo7br4FmiLuJIFRy3vpyDIg/ZIRFxdEs=;
 b=h3ny4o3cNpp5Tk8xMQfC07Uda9LfWCRZ9nhjZrVLf+dVm00WynGJBnGkWBLXDLIDBUO99uqW+K3gK/shZQ5bJU2aV3vSDq1B8iqQY/1SckTF2vOJhdVazCr+C8WlDeAK4HGdUh63p0Bgxe8wvW8HtKlGMTPJiSGrtsNP/fR4UEk=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 11:09:59 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 11:09:59 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v6 23/33] net/ixgbe: create common Rx queue structure
Thread-Topic: [PATCH v6 23/33] net/ixgbe: create common Rx queue structure
Thread-Index: AQHb2VTmZMiSMEasqUqHSVvcD6tQjLP/T2sAgAAEugCAAA3s0A==
Date: Thu, 12 Jun 2025 11:09:59 +0000
Message-ID: <PH7PR12MB859664D6540AD76C8A9E012C8274A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <cover.1749483381.git.anatoly.burakov@intel.com>
 <cover.1749483381.git.anatoly.burakov@intel.com>
 <67e447a725410d7ef1af5317e3c7e1ee487792c3.1749483382.git.anatoly.burakov@intel.com>
 <PH7PR12MB8596F835791ABF579E92C6B88274A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEqpkOa_oxW8pR3h@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aEqpkOa_oxW8pR3h@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-12T11:08:55.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|SN7PR12MB8791:EE_
x-ms-office365-filtering-correlation-id: a0ca8dc9-9546-4d81-2b4a-08dda9a1abee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XA8EZ5bMqg86EahuOZP8wmsO0XWdSDktK4nMae7x3zmyD4ImOCyltJHURY6P?=
 =?us-ascii?Q?HysGBTuWpUu+RjbI0zaZII8lsN1FMAQW3U5dTsHoGzoi+MjtFHf5uc5sK4Fk?=
 =?us-ascii?Q?E2OdHwuYswOa0CgVSzr/WnisnPn1xUDqNGnEHqC3xVdwhwSZkUo3zKBONH6H?=
 =?us-ascii?Q?kJQdA/8PTNXelPM34YrhehGXM1Fua69RoNnUpkHb02o/OKVr6FqzkWr/1f0N?=
 =?us-ascii?Q?8ZU+gcglx+mqybdGVnmITBG1spB6b5D8IQhXYOom/kwgJszVGGClAVS/SX6s?=
 =?us-ascii?Q?1p674DOufHWgPfCodli1FkxwX2oNQBbw4TA5H+eR5WgjmrNvnhCUZFOPDBbs?=
 =?us-ascii?Q?2NZHkXuzoyaMfQfymTEzAz70mdoBsBs3wRudursmldygwZQgOBOKPj0fjKdM?=
 =?us-ascii?Q?8rE3TouoW+mo79HHj9OixpYZm4bitZ2hibuAPyENr4Idyv4d2SiNZMgyvgSG?=
 =?us-ascii?Q?MzqzB/saNzZHLcZ0kzicYt17uPUyHjjkv90wgtsP17fXOX8EO27COrI9vaJp?=
 =?us-ascii?Q?gXU7xsSy+QbB71v45ixJX9KVGJe7ew+xMn02tbWeF4iEamByKB2n57fgpbP8?=
 =?us-ascii?Q?zQmNLxhtPPwPk2oa/Frtq+0Vdjm4YIPTo6qrMFhhU6fmxwBMk4B6E9qS4zhm?=
 =?us-ascii?Q?e8Nt3Tw/79/MI+gWbPXiZtcR91KD7bfmK3YKxOMS7+RBuMXy5sAVOYLSFGtf?=
 =?us-ascii?Q?kpIChOROrTIgsUZi/gYiahdCpPb+9Q0eHjOQW+ZEzdS+QiOD7Fwgvp6Zosxt?=
 =?us-ascii?Q?Ow6QrSwJNiQoBaTRS0zllI1kCYN/kvcSC3Ona2ceKXszJ1vBguN7jz48l4wY?=
 =?us-ascii?Q?+iONmwCe8MHZoq7oQ9ZuCHEnFEUSlBgs0IKO0138u4r44lVNbbNWMOBHP8he?=
 =?us-ascii?Q?GDU7YkVRj84qI9+jXor6zA3eD4y6SW7doljHPzLyR9aNlhcw+VJSdHCvMHgg?=
 =?us-ascii?Q?0Rs6wSEj2PRej+FjmPiSXmBzcLCuMqOtoWB4i2nWjxMQ0rMxAJgq//ITmwRW?=
 =?us-ascii?Q?Li7+0Kk3cns6wb7INW7XjhpiXLDhP5mvRWOEUXucadbxNp9cvsX9BvLEgN09?=
 =?us-ascii?Q?PrJqBsUKS2n05XtaLfo5caIr4/FuYqATlW+lOv2KXLNRwiPxcojnYWENoVT9?=
 =?us-ascii?Q?lSDRUviO1XQjlzQFSMeY5PZMYWvholrZ4SFF0FVIZ5sFAkTpdF/Mxi6zm63f?=
 =?us-ascii?Q?A6CbkRvRuVnbhOHaHMs9dL+7RFK3jKuPeeQTKTTwiwiBtH3l42hHtNvGIJjN?=
 =?us-ascii?Q?+XUXHi526FfdI1VAr+wEfmdScE3mMHEe8PjuiXclcCwCJmMApPFdMwkphTcx?=
 =?us-ascii?Q?ZcKUEhNsHXm5lI0X7YOI/wITaps1qq0trIkWK8Py2U7xC5NnV/p+I45UTRaa?=
 =?us-ascii?Q?fRMRV+tidlhGpFABNSLan7Z1P65cqhHNM/tP5sPTCZTF4+WLX8Fix9LKSOGH?=
 =?us-ascii?Q?u2brlE9ZMZI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?emhjcYeSrMkXCxS8T6o1JO6gTuNrfiAeBcO/p7KDBWStWQkbxoRxmv+lX7fn?=
 =?us-ascii?Q?bCoAzNfJJaFZcpQfDeiX948bGAuSYeAiLGLSgUYz1xb1fBhThdl0LyAb/UK2?=
 =?us-ascii?Q?PsG37zqwyfg2cngCxGME4B276ZBfEsRp8sDfj7nw8eNxdUor3wuwIG29rJ7W?=
 =?us-ascii?Q?zf3c9OxpTky5DXaJL4zUTa2b2NOVQ62HbidQTtG0St+GgEtqvTibnDOSMacX?=
 =?us-ascii?Q?B+x+M4tUetP7f+TU2MFUqotGfXAxkhDgxhucghWgN9/hR+ugPEM6QvjwWKo4?=
 =?us-ascii?Q?yEjjxeRYvGxYrMFkUpk+/zwZjZQ23kiwuQQfq07oau6oNnPKW8ogispgxtQy?=
 =?us-ascii?Q?b+/twR880fDeD9h6oeR9FVOobHMiZz7Tuk+Ic07KFCz4oLj7k1o4FgYik1XW?=
 =?us-ascii?Q?SazpMPxv1OaleXXYWN8yk1LDL4r3jMUrdTlWoBXxTVz2b6SDDUmv6RteAS0m?=
 =?us-ascii?Q?dwKM6UsulvCr1s4ckG18q1jND8DcEJDxvZDFGzaw95Ci8W7WsFKh4mOQ9tsz?=
 =?us-ascii?Q?GIpuaOmEi8ydFsvjI0ljyFs6oRFvzL0E6AmaoniEG3CfqF3fL/+jBduZUtWT?=
 =?us-ascii?Q?nyH0cnfGi0ceXKChYreQI3RraNt3ygfa4iqIWOtR/YVZgJEVOzQSd0R/MIK2?=
 =?us-ascii?Q?Szzy8ZzlCl7X1XTcho92ri4Y/k2OgZVVQpO8CUJCU1km8NBN+v6xU+VmuQ0B?=
 =?us-ascii?Q?pCxsvTPkWGrDncNMK0gee2WtNGAHZFIQ3lIz72oAU+1AXBrzq6qs0IroShUV?=
 =?us-ascii?Q?6ZymNY0ZA0nGLgBWpvObjFBJBl60BEJZZzK6oYakyeZMyRIkFy2UIw8yDcu/?=
 =?us-ascii?Q?8Y/lq2lPTZTRHV3f4AGuQFXCdtMl+aoOOdoTo4pAsTRhYUKakc1+Xokp6ZZE?=
 =?us-ascii?Q?URWcCEAPAJCLMIJb/RwWPBQpktmlg5hpM0Jt2X9z3T0cQnHUKQP7whBcm2jH?=
 =?us-ascii?Q?SAqCqcYvHxdQOPAM7ofp/X9fKN7jAtVAd0YcGb5g9fAD+7yLCtu8xfBQQbkP?=
 =?us-ascii?Q?b3qInhzXEcgGtGZWPexvRfBMfETlbXDRk68JiA0seNwduin1ayTwLRdUVKUv?=
 =?us-ascii?Q?BePEG+MR9QpQD6lldMal7GNEfloY1chiZPwAIMGQqcOkgtrWzIc3Irrj1OyF?=
 =?us-ascii?Q?1B1hOhPwD3q8oN3sjPhN++XYSDTEsSR0/DyEK2pwGLJEQLotPdt1/eVgucE2?=
 =?us-ascii?Q?LVVjzqMPeeMS/feUPNoXfzLNrmnhfn63L8mSfCX1VlQu+5WXT+7Qso0zGCeP?=
 =?us-ascii?Q?OHmik21o70AEe9cAmk4RW51A1JUChCcbOrx/0siUo+3aiBIBIjtKGyL3PC+K?=
 =?us-ascii?Q?xEKii1I7MPDkfqyfef03yG//5t18UjtkzeW0zLLrsa/E3l49GZsdhWy/deCF?=
 =?us-ascii?Q?oexI3dfuDyRQtxhDQtab0y5X2y2MMXuYBoqh2C1WweySRBQ2+uZGb0paE0tM?=
 =?us-ascii?Q?wgTuPeUcEEqQ8Kza8WjmJJ+jJ82V8ICbo1mCfTWusem9j1Ra2U/pQ9tp/jBt?=
 =?us-ascii?Q?LYYRcrGDca0iBfV71e2AUjPALuaRFCSlYBECBMi7rsDooufs3X3nWhIkTqid?=
 =?us-ascii?Q?7coZTTdHLhPL7Hhm59o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ca8dc9-9546-4d81-2b4a-08dda9a1abee
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 11:09:59.5729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f/9mfld4m2K/Tq6VnJ6ncOOi9l3cN5QDD5f0MnCKd6v4Fv4KrYITYgRO2iP1w+UiqO750QvWW98GEau1ThqMBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791
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

[Public]

> -----Original Message-----
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Thursday, June 12, 2025 3:49 PM
> To: Varghese, Vipin <Vipin.Varghese@amd.com>
> Cc: Anatoly Burakov <anatoly.burakov@intel.com>; dev@dpdk.org; Vladimir
> Medvedkin <vladimir.medvedkin@intel.com>
> Subject: Re: [PATCH v6 23/33] net/ixgbe: create common Rx queue structure
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Thu, Jun 12, 2025 at 10:12:23AM +0000, Varghese, Vipin wrote:
> > [Public]
> >
> > Hi Bruce & Anatoly,
> >
> > We are facing an issue while apply patch 23 individually or series.
> >
> > We get the following error for individual apply
> >
> > ```
> > $ git apply p23.patch --verbose
> > Checking patch drivers/net/intel/common/rx.h...
> > Checking patch drivers/net/intel/ixgbe/ixgbe_ethdev.c...
> > Checking patch drivers/net/intel/ixgbe/ixgbe_rxtx.c...
> > error: while searching for:
> >                 len +=3D IXGBE_RX_MAX_BURST;
> >
> >         rxq->sw_ring =3D rte_zmalloc_socket("rxq->sw_ring",
> >                                           sizeof(struct ixgbe_rx_entry)=
 * len,
> >                                           RTE_CACHE_LINE_SIZE, socket_i=
d);
> >         if (!rxq->sw_ring) {
> >                 ixgbe_rx_queue_release(rxq);
> >
> > error: patch failed: drivers/net/intel/ixgbe/ixgbe_rxtx.c:3309
> > error: drivers/net/intel/ixgbe/ixgbe_rxtx.c: patch does not apply
> > Checking patch drivers/net/intel/ixgbe/ixgbe_rxtx.h...
> > error: while searching for:
> > #define IXGBE_MAX_RING_DESC     8192
> >
> > #define IXGBE_TX_MAX_BURST            32
> > #define IXGBE_RX_MAX_BURST            32
> > #define IXGBE_TX_MAX_FREE_BUF_SZ      64
> >
> > #define IXGBE_VPMD_DESCS_PER_LOOP     4
> >
> > error: patch failed: drivers/net/intel/ixgbe/ixgbe_rxtx.h:32
> > error: drivers/net/intel/ixgbe/ixgbe_rxtx.h: patch does not apply
> > Checking patch drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c...
> > Checking patch drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h...
> > Checking patch drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c...
> > error: while searching for:
> >  * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
> > */ static inline uint16_t _recv_raw_pkts_vec(struct ixgbe_rx_queue
> > *rxq, struct rte_mbuf **rx_pkts,
> >                    uint16_t nb_pkts, uint8_t *split_packet) {
> >         volatile union ixgbe_adv_rx_desc *rxdp;
> >         struct ixgbe_rx_entry *sw_ring;
> >         uint16_t nb_pkts_recd;
> >         int pos;
> >         uint8x16_t shuf_msk =3D {
> >
> > error: patch failed: drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c:282
> > error: drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c: patch does not
> > apply Checking patch drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c...
> > error: while searching for:
> >  * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
> > */ static inline uint16_t _recv_raw_pkts_vec(struct ixgbe_rx_queue
> > *rxq, struct rte_mbuf **rx_pkts,
> >                 uint16_t nb_pkts, uint8_t *split_packet) {
> >         volatile union ixgbe_adv_rx_desc *rxdp;
> >         struct ixgbe_rx_entry *sw_ring;
> >         uint16_t nb_pkts_recd;
> > #ifdef RTE_LIB_SECURITY
> >         uint8_t use_ipsec =3D rxq->using_ipsec;
> >
> > error: patch failed: drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c:327
> > error: drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c: patch does not
> > apply ```
> >
> > And we get following error in series apply
> >
> > ```
> > $ git apply ../../Intel-PMD-drivers-Rx-cleanup.patch
> > error: patch failed:
> > drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c:173
> > error: drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c: patch does not
> > apply ```
> >
> > > -----Original Message-----
> > > From: Anatoly Burakov <anatoly.burakov@intel.com>
> > > Sent: Monday, June 9, 2025 9:07 PM
> > > To: dev@dpdk.org; Bruce Richardson <bruce.richardson@intel.com>;
> > > Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> > > Subject: [PATCH v6 23/33] net/ixgbe: create common Rx queue
> > > structure
> > >
> > > Caution: This message originated from an External Source. Use proper
> > > caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > In preparation for deduplication effort, generalize the Rx queue stru=
cture.
> > >
> > > The entire Rx queue structure is moved to common/rx.h, clarifying
> > > the comments where necessary, and separating common parts from ixgbe-
> specific parts.
> > >
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >
> > > Notes:
> > >     v5:
> > >     - Sort ixgbe-specific fields by size
> > >
> > >     v3 -> v4:
> > >     - Separate out some of the changes from this commit into previous=
 commits
> > >     - Rename CI_RX_BURST to CI_RX_MAX_BURST to match the driver
> > > naming convention
> > >
> > >  drivers/net/intel/common/rx.h                 |  67 ++++++++++-
> > >  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   8 +-
> > >  drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 108 +++++++++-------=
--
> > >  drivers/net/intel/ixgbe/ixgbe_rxtx.h          |  61 +---------
> > >  .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   |  12 +-
> > >  .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   |   5 +-
> > >  drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c |  14 +--
> > > drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  |  14 +--
> > >  8 files changed, 146 insertions(+), 143 deletions(-)
> > >
> > > diff --git a/drivers/net/intel/common/rx.h
> > > b/drivers/net/intel/common/rx.h index abb01ba5e7..b60ca24dfb 100644
> > > --- a/drivers/net/intel/common/rx.h
> > > +++ b/drivers/net/intel/common/rx.h
> > > @@ -10,14 +10,75 @@
> > >  #include <rte_mbuf.h>
> > >  #include <rte_ethdev.h>
> > >
> > > -#define CI_RX_BURST 32
> > > +#define CI_RX_MAX_BURST 32
> > > +
> > > +struct ci_rx_queue;
> > > +
> > > +struct ci_rx_entry {
> > > +       struct rte_mbuf *mbuf; /* mbuf associated with RX
> > > +descriptor. */ };
> > > +
> > > +struct ci_rx_entry_sc {
> > > +       struct rte_mbuf *fbuf; /* First segment of the fragmented
> > > +packet.*/ };
> > > +
> > > +/**
> > > + * Structure associated with each RX queue.
> > > + */
> > > +struct ci_rx_queue {
> > > +       struct rte_mempool  *mp; /**< mbuf pool to populate RX ring. =
*/
> > > +       union { /* RX ring virtual address */
> > > +               volatile union ixgbe_adv_rx_desc *ixgbe_rx_ring;
> > > +       };
> > > +       volatile uint8_t *qrx_tail;   /**< register address of tail *=
/
> > > +       struct ci_rx_entry *sw_ring; /**< address of RX software ring=
. */
> > > +       struct ci_rx_entry_sc *sw_sc_ring; /**< address of scattered
> > > +Rx software
> > > ring. */
> > > +       rte_iova_t rx_ring_phys_addr; /**< RX ring DMA address. */
> > > +       struct rte_mbuf *pkt_first_seg; /**< First segment of current=
 packet. */
> > > +       struct rte_mbuf *pkt_last_seg; /**< Last segment of current p=
acket. */
> > > +       /** hold packets to return to application */
> > > +       struct rte_mbuf *rx_stage[CI_RX_MAX_BURST * 2];
> > > +       uint16_t nb_rx_desc; /**< number of RX descriptors. */
> > > +       uint16_t rx_tail;  /**< current value of tail register. */
> > > +       uint16_t rx_nb_avail; /**< nr of staged pkts ready to ret to =
app */
> > > +       uint16_t nb_rx_hold; /**< number of held free RX desc. */
> > > +       uint16_t rx_next_avail; /**< idx of next staged pkt to ret to=
 app */
> > > +       uint16_t rx_free_thresh; /**< max free RX desc to hold. */
> > > +       uint16_t rx_free_trigger; /**< triggers rx buffer allocation =
*/
> > > +       uint16_t rxrearm_nb;     /**< number of remaining to be re-ar=
med */
> > > +       uint16_t rxrearm_start;  /**< the idx we start the re-arming =
from */
> > > +       uint16_t queue_id; /**< RX queue index. */
> > > +       uint16_t port_id;  /**< Device port identifier. */
> > > +       uint16_t reg_idx;  /**< RX queue register index. */
> > > +       uint8_t crc_len;  /**< 0 if CRC stripped, 4 otherwise. */
> > > +       bool rx_deferred_start; /**< queue is not started on dev star=
t. */
> > > +       bool vector_rx; /**< indicates that vector RX is in use */
> > > +       bool drop_en;  /**< if 1, drop packets if no descriptors are =
available. */
> > > +       uint64_t mbuf_initializer; /**< value to init mbufs */
> > > +       uint64_t offloads; /**< Rx offloads with RTE_ETH_RX_OFFLOAD_*=
 */
> > > +       /** need to alloc dummy mbuf, for wraparound when scanning hw=
 ring */
> > > +       struct rte_mbuf fake_mbuf;
> > > +       const struct rte_memzone *mz;
> > > +       union {
> > > +               struct { /* ixgbe specific values */
> > > +                       /** flags to set in mbuf when a vlan is detec=
ted. */
> > > +                       uint64_t vlan_flags;
> > > +                       /** Packet type mask for different NICs. */
> > > +                       uint16_t pkt_type_mask;
> > > +                       /** indicates that IPsec RX feature is in use=
 */
> > > +                       uint8_t using_ipsec;
> > > +                       /** UDP frames with a 0 checksum can be
> > > + marked as checksum
> > > errors. */
> > > +                       uint8_t rx_udp_csum_zero_err;
> > > +               };
> > > +       };
> > > +};
> > >
> > >  static inline uint16_t
> > >  ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs, uint16_t
> > > nb_bufs, uint8_t *split_flags,
> > >                 struct rte_mbuf **pkt_first_seg, struct rte_mbuf **pk=
t_last_seg,
> > >                 const uint8_t crc_len)  {
> > > -       struct rte_mbuf *pkts[CI_RX_BURST] =3D {0}; /*finished pkts*/
> > > +       struct rte_mbuf *pkts[CI_RX_MAX_BURST] =3D {0}; /*finished
> > > + pkts*/
> > >         struct rte_mbuf *start =3D *pkt_first_seg;
> > >         struct rte_mbuf *end =3D *pkt_last_seg;
> > >         unsigned int pkt_idx, buf_idx; @@ -97,7 +158,7 @@ static
> > > inline bool  ci_rxq_vec_capable(uint16_t nb_desc, uint16_t
> > > rx_free_thresh, uint64_t offloads)  {
> > >         if (!rte_is_power_of_2(nb_desc) ||
> > > -                       rx_free_thresh < CI_RX_BURST ||
> > > +                       rx_free_thresh < CI_RX_MAX_BURST ||
> > >                         (nb_desc % rx_free_thresh) !=3D 0)
> > >                 return false;
> > >
> > > diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> > > b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> > > index 928ac57a93..f8b99d4de5 100644
> > > --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> > > +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> > > @@ -2022,7 +2022,7 @@ ixgbe_vlan_hw_strip_bitmap_set(struct
> > > rte_eth_dev *dev, uint16_t queue, bool on)  {
> > >         struct ixgbe_hwstrip *hwstrip =3D
> > >                 IXGBE_DEV_PRIVATE_TO_HWSTRIP_BITMAP(dev->data-
> > > >dev_private);
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >
> > >         if (queue >=3D IXGBE_MAX_RX_QUEUE_NUM)
> > >                 return;
> > > @@ -2157,7 +2157,7 @@ ixgbe_vlan_hw_strip_config(struct rte_eth_dev
> *dev)
> > >         struct rte_eth_rxmode *rxmode =3D &dev->data->dev_conf.rxmode=
;
> > >         uint32_t ctrl;
> > >         uint16_t i;
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >         bool on;
> > >
> > >         PMD_INIT_FUNC_TRACE();
> > > @@ -2200,7 +2200,7 @@ ixgbe_config_vlan_strip_on_all_queues(struct
> > > rte_eth_dev *dev, int mask)  {
> > >         uint16_t i;
> > >         struct rte_eth_rxmode *rxmode;
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >
> > >         if (mask & RTE_ETH_VLAN_STRIP_MASK) {
> > >                 rxmode =3D &dev->data->dev_conf.rxmode; @@ -5782,7
> > > +5782,7 @@ ixgbevf_vlan_strip_queue_set(struct rte_eth_dev *dev,
> > > uint16_t queue, int on)  static int  ixgbevf_vlan_offload_config(stru=
ct rte_eth_dev
> *dev, int mask)  {
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >         uint16_t i;
> > >         int on =3D 0;
> > >
> > > diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> > > b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> > > index 5b2067bc0e..bbe665a6ff 100644
> > > --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> > > +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> > > @@ -1403,11 +1403,11 @@ int
> > >  ixgbe_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond=
 *pmc)
> {
> > >         volatile union ixgbe_adv_rx_desc *rxdp;
> > > -       struct ixgbe_rx_queue *rxq =3D rx_queue;
> > > +       struct ci_rx_queue *rxq =3D rx_queue;
> > >         uint16_t desc;
> > >
> > >         desc =3D rxq->rx_tail;
> > > -       rxdp =3D &rxq->rx_ring[desc];
> > > +       rxdp =3D &rxq->ixgbe_rx_ring[desc];
> > >         /* watch for changes in status bit */
> > >         pmc->addr =3D &rxdp->wb.upper.status_error;
> > >
> > > @@ -1547,10 +1547,10 @@ rx_desc_error_to_pkt_flags(uint32_t
> > > rx_status, uint16_t pkt_info,  #error "PMD IXGBE: LOOK_AHEAD must be =
8\n"
> > >  #endif
> > >  static inline int
> > > -ixgbe_rx_scan_hw_ring(struct ixgbe_rx_queue *rxq)
> > > +ixgbe_rx_scan_hw_ring(struct ci_rx_queue *rxq)
> > >  {
> > >         volatile union ixgbe_adv_rx_desc *rxdp;
> > > -       struct ixgbe_rx_entry *rxep;
> > > +       struct ci_rx_entry *rxep;
> > >         struct rte_mbuf *mb;
> > >         uint16_t pkt_len;
> > >         uint64_t pkt_flags;
> > > @@ -1562,7 +1562,7 @@ ixgbe_rx_scan_hw_ring(struct ixgbe_rx_queue
> *rxq)
> > >         uint64_t vlan_flags =3D rxq->vlan_flags;
> > >
> > >         /* get references to current descriptor and S/W ring entry */
> > > -       rxdp =3D &rxq->rx_ring[rxq->rx_tail];
> > > +       rxdp =3D &rxq->ixgbe_rx_ring[rxq->rx_tail];
> > >         rxep =3D &rxq->sw_ring[rxq->rx_tail];
> > >
> > >         status =3D rxdp->wb.upper.status_error; @@ -1647,10 +1647,10
> > > @@ ixgbe_rx_scan_hw_ring(struct ixgbe_rx_queue *rxq)  }
> > >
> > >  static inline int
> > > -ixgbe_rx_alloc_bufs(struct ixgbe_rx_queue *rxq, bool reset_mbuf)
> > > +ixgbe_rx_alloc_bufs(struct ci_rx_queue *rxq, bool reset_mbuf)
> > >  {
> > >         volatile union ixgbe_adv_rx_desc *rxdp;
> > > -       struct ixgbe_rx_entry *rxep;
> > > +       struct ci_rx_entry *rxep;
> > >         struct rte_mbuf *mb;
> > >         uint16_t alloc_idx;
> > >         __le64 dma_addr;
> > > @@ -1664,7 +1664,7 @@ ixgbe_rx_alloc_bufs(struct ixgbe_rx_queue
> > > *rxq, bool
> > > reset_mbuf)
> > >         if (unlikely(diag !=3D 0))
> > >                 return -ENOMEM;
> > >
> > > -       rxdp =3D &rxq->rx_ring[alloc_idx];
> > > +       rxdp =3D &rxq->ixgbe_rx_ring[alloc_idx];
> > >         for (i =3D 0; i < rxq->rx_free_thresh; ++i) {
> > >                 /* populate the static rte mbuf fields */
> > >                 mb =3D rxep[i].mbuf;
> > > @@ -1691,7 +1691,7 @@ ixgbe_rx_alloc_bufs(struct ixgbe_rx_queue
> > > *rxq, bool
> > > reset_mbuf)  }
> > >
> > >  static inline uint16_t
> > > -ixgbe_rx_fill_from_stage(struct ixgbe_rx_queue *rxq, struct
> > > rte_mbuf **rx_pkts,
> > > +ixgbe_rx_fill_from_stage(struct ci_rx_queue *rxq, struct rte_mbuf
> > > +**rx_pkts,
> > >                          uint16_t nb_pkts)  {
> > >         struct rte_mbuf **stage =3D
> > > &rxq->rx_stage[rxq->rx_next_avail];
> > > @@ -1715,7 +1715,7 @@ static inline uint16_t  rx_recv_pkts(void
> > > *rx_queue, struct rte_mbuf **rx_pkts,
> > >              uint16_t nb_pkts)
> > >  {
> > > -       struct ixgbe_rx_queue *rxq =3D (struct ixgbe_rx_queue *)rx_qu=
eue;
> > > +       struct ci_rx_queue *rxq =3D (struct ci_rx_queue *)rx_queue;
> > >         uint16_t nb_rx =3D 0;
> > >
> > >         /* Any previously recv'd pkts will be returned from the Rx
> > > stage */ @@ -
> > > 1804,11 +1804,11 @@ uint16_t  ixgbe_recv_pkts(void *rx_queue, struct
> > > rte_mbuf **rx_pkts,
> > >                 uint16_t nb_pkts)
> > >  {
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >         volatile union ixgbe_adv_rx_desc *rx_ring;
> > >         volatile union ixgbe_adv_rx_desc *rxdp;
> > > -       struct ixgbe_rx_entry *sw_ring;
> > > -       struct ixgbe_rx_entry *rxe;
> > > +       struct ci_rx_entry *sw_ring;
> > > +       struct ci_rx_entry *rxe;
> > >         struct rte_mbuf *rxm;
> > >         struct rte_mbuf *nmb;
> > >         union ixgbe_adv_rx_desc rxd; @@ -1826,7 +1826,7 @@
> > > ixgbe_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
> > >         nb_hold =3D 0;
> > >         rxq =3D rx_queue;
> > >         rx_id =3D rxq->rx_tail;
> > > -       rx_ring =3D rxq->rx_ring;
> > > +       rx_ring =3D rxq->ixgbe_rx_ring;
> > >         sw_ring =3D rxq->sw_ring;
> > >         vlan_flags =3D rxq->vlan_flags;
> > >         while (nb_rx < nb_pkts) {
> > > @@ -2031,7 +2031,7 @@ static inline void  ixgbe_fill_cluster_head_buf=
(
> > >         struct rte_mbuf *head,
> > >         union ixgbe_adv_rx_desc *desc,
> > > -       struct ixgbe_rx_queue *rxq,
> > > +       struct ci_rx_queue *rxq,
> > >         uint32_t staterr)
> > >  {
> > >         uint32_t pkt_info;
> > > @@ -2093,10 +2093,10 @@ static inline uint16_t
> > > ixgbe_recv_pkts_lro(void *rx_queue, struct rte_mbuf **rx_pkts, uint16=
_t
> nb_pkts,
> > >                     bool bulk_alloc)  {
> > > -       struct ixgbe_rx_queue *rxq =3D rx_queue;
> > > -       volatile union ixgbe_adv_rx_desc *rx_ring =3D rxq->rx_ring;
> > > -       struct ixgbe_rx_entry *sw_ring =3D rxq->sw_ring;
> > > -       struct ixgbe_scattered_rx_entry *sw_sc_ring =3D rxq->sw_sc_ri=
ng;
> > > +       struct ci_rx_queue *rxq =3D rx_queue;
> > > +       volatile union ixgbe_adv_rx_desc *rx_ring =3D rxq->ixgbe_rx_r=
ing;
> > > +       struct ci_rx_entry *sw_ring =3D rxq->sw_ring;
> > > +       struct ci_rx_entry_sc *sw_sc_ring =3D rxq->sw_sc_ring;
> > >         uint16_t rx_id =3D rxq->rx_tail;
> > >         uint16_t nb_rx =3D 0;
> > >         uint16_t nb_hold =3D rxq->nb_rx_hold; @@ -2104,10 +2104,10 @@
> > > ixgbe_recv_pkts_lro(void *rx_queue, struct rte_mbuf **rx_pkts,
> > > uint16_t nb_pkts,
> > >
> > >         while (nb_rx < nb_pkts) {
> > >                 bool eop;
> > > -               struct ixgbe_rx_entry *rxe;
> > > -               struct ixgbe_scattered_rx_entry *sc_entry;
> > > -               struct ixgbe_scattered_rx_entry *next_sc_entry =3D NU=
LL;
> > > -               struct ixgbe_rx_entry *next_rxe =3D NULL;
> > > +               struct ci_rx_entry *rxe;
> > > +               struct ci_rx_entry_sc *sc_entry;
> > > +               struct ci_rx_entry_sc *next_sc_entry =3D NULL;
> > > +               struct ci_rx_entry *next_rxe =3D NULL;
> > >                 struct rte_mbuf *first_seg;
> > >                 struct rte_mbuf *rxm;
> > >                 struct rte_mbuf *nmb =3D NULL; @@ -2949,7 +2949,7 @@
> > > ixgbe_free_sc_cluster(struct rte_mbuf *m)  }
> > >
> > >  static void __rte_cold
> > > -ixgbe_rx_queue_release_mbufs_non_vec(struct ixgbe_rx_queue *rxq)
> > > +ixgbe_rx_queue_release_mbufs_non_vec(struct ci_rx_queue *rxq)
> > >  {
> > >         unsigned i;
> > >
> > > @@ -2980,7 +2980,7 @@ ixgbe_rx_queue_release_mbufs_non_vec(struct
> > > ixgbe_rx_queue *rxq)  }
> > >
> > >  static void __rte_cold
> > > -ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
> > > +ixgbe_rx_queue_release_mbufs(struct ci_rx_queue *rxq)
> > >  {
> > >         if (rxq->vector_rx)
> > >                 ixgbe_rx_queue_release_mbufs_vec(rxq);
> > > @@ -2989,7 +2989,7 @@ ixgbe_rx_queue_release_mbufs(struct
> > > ixgbe_rx_queue
> > > *rxq)  }
> > >
> > >  static void __rte_cold
> > > -ixgbe_rx_queue_release(struct ixgbe_rx_queue *rxq)
> > > +ixgbe_rx_queue_release(struct ci_rx_queue *rxq)
> > >  {
> > >         if (rxq !=3D NULL) {
> > >                 ixgbe_rx_queue_release_mbufs(rxq);
> > > @@ -3015,7 +3015,7 @@ ixgbe_dev_rx_queue_release(struct rte_eth_dev
> > > *dev, uint16_t qid)
> > >   *           function must be used.
> > >   */
> > >  static inline int __rte_cold
> > > -check_rx_burst_bulk_alloc_preconditions(struct ixgbe_rx_queue *rxq)
> > > +check_rx_burst_bulk_alloc_preconditions(struct ci_rx_queue *rxq)
> > >  {
> > >         int ret =3D 0;
> > >
> > > @@ -3052,7 +3052,7 @@ check_rx_burst_bulk_alloc_preconditions(struct
> > > ixgbe_rx_queue *rxq)
> > >
> > >  /* Reset dynamic ixgbe_rx_queue fields back to defaults */  static
> > > void __rte_cold - ixgbe_reset_rx_queue(struct ixgbe_adapter
> > > *adapter, struct ixgbe_rx_queue *rxq)
> > > +ixgbe_reset_rx_queue(struct ixgbe_adapter *adapter, struct
> > > +ci_rx_queue
> > > +*rxq)
> > >  {
> > >         static const union ixgbe_adv_rx_desc zeroed_desc =3D {{0}};
> > >         unsigned i;
> > > @@ -3073,7 +3073,7 @@ ixgbe_reset_rx_queue(struct ixgbe_adapter
> > > *adapter, struct ixgbe_rx_queue *rxq)
> > >          * reads extra memory as zeros.
> > >          */
> > >         for (i =3D 0; i < len; i++) {
> > > -               rxq->rx_ring[i] =3D zeroed_desc;
> > > +               rxq->ixgbe_rx_ring[i] =3D zeroed_desc;
> > >         }
> > >
> > >         /*
> > > @@ -3185,7 +3185,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *de=
v,
> > >                          struct rte_mempool *mp)  {
> > >         const struct rte_memzone *rz;
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >         struct ixgbe_hw     *hw;
> > >         uint16_t len;
> > >         struct ixgbe_adapter *adapter =3D dev->data->dev_private; @@
> > > -3214,7
> > > +3214,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
> > >         }
> > >
> > >         /* First allocate the rx queue data structure */
> > > -       rxq =3D rte_zmalloc_socket("ethdev RX queue", sizeof(struct
> ixgbe_rx_queue),
> > > +       rxq =3D rte_zmalloc_socket("ethdev RX queue", sizeof(struct
> > > + ci_rx_queue),
> > >                                  RTE_CACHE_LINE_SIZE, socket_id);
> > >         if (rxq =3D=3D NULL)
> > >                 return -ENOMEM;
> > > @@ -3284,7 +3284,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *de=
v,
> > >                         IXGBE_PCI_REG_ADDR(hw,
> > > IXGBE_RDT(rxq->reg_idx));
> > >
> > >         rxq->rx_ring_phys_addr =3D rz->iova;
> > > -       rxq->rx_ring =3D (union ixgbe_adv_rx_desc *) rz->addr;
> > > +       rxq->ixgbe_rx_ring =3D (union ixgbe_adv_rx_desc *)rz->addr;
> > >
> > >         /*
> > >          * Certain constraints must be met in order to use the bulk
> > > buffer @@ -3309,7
> > > +3309,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
> > >                 len +=3D IXGBE_RX_MAX_BURST;
> > >
> > >         rxq->sw_ring =3D rte_zmalloc_socket("rxq->sw_ring",
> > > -                                         sizeof(struct ixgbe_rx_entr=
y) * len,
> > > +                                         sizeof(struct ci_rx_entry)
> > > + * len,
> > >                                           RTE_CACHE_LINE_SIZE, socket=
_id);
> > >         if (!rxq->sw_ring) {
> > >                 ixgbe_rx_queue_release(rxq); @@ -3326,7 +3326,7 @@
> > > ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
> > >          */
> > >         rxq->sw_sc_ring =3D
> > >                 rte_zmalloc_socket("rxq->sw_sc_ring",
> > > -                                  sizeof(struct ixgbe_scattered_rx_e=
ntry) * len,
> > > +                                  sizeof(struct ci_rx_entry_sc) *
> > > + len,
> > >                                    RTE_CACHE_LINE_SIZE, socket_id);
> > >         if (!rxq->sw_sc_ring) {
> > >                 ixgbe_rx_queue_release(rxq); @@ -3335,7 +3335,7 @@
> > > ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
> > >
> > >         PMD_INIT_LOG(DEBUG, "sw_ring=3D%p sw_sc_ring=3D%p hw_ring=3D%=
p "
> > >                             "dma_addr=3D0x%"PRIx64,
> > > -                    rxq->sw_ring, rxq->sw_sc_ring, rxq->rx_ring,
> > > +                    rxq->sw_ring, rxq->sw_sc_ring,
> > > + rxq->ixgbe_rx_ring,
> > >                      rxq->rx_ring_phys_addr);
> > >
> > >         if (!rte_is_power_of_2(nb_desc)) { @@ -3359,11 +3359,11 @@
> > > ixgbe_dev_rx_queue_count(void *rx_queue)  {  #define
> > > IXGBE_RXQ_SCAN_INTERVAL 4
> > >         volatile union ixgbe_adv_rx_desc *rxdp;
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >         uint32_t desc =3D 0;
> > >
> > >         rxq =3D rx_queue;
> > > -       rxdp =3D &(rxq->rx_ring[rxq->rx_tail]);
> > > +       rxdp =3D &rxq->ixgbe_rx_ring[rxq->rx_tail];
> > >
> > >         while ((desc < rxq->nb_rx_desc) &&
> > >                 (rxdp->wb.upper.status_error & @@ -3371,7 +3371,7 @@
> > > ixgbe_dev_rx_queue_count(void *rx_queue)
> > >                 desc +=3D IXGBE_RXQ_SCAN_INTERVAL;
> > >                 rxdp +=3D IXGBE_RXQ_SCAN_INTERVAL;
> > >                 if (rxq->rx_tail + desc >=3D rxq->nb_rx_desc)
> > > -                       rxdp =3D &(rxq->rx_ring[rxq->rx_tail +
> > > +                       rxdp =3D &(rxq->ixgbe_rx_ring[rxq->rx_tail +
> > >                                 desc - rxq->nb_rx_desc]);
> > >         }
> > >
> > > @@ -3381,7 +3381,7 @@ ixgbe_dev_rx_queue_count(void *rx_queue)  int
> > > ixgbe_dev_rx_descriptor_status(void *rx_queue, uint16_t offset)  {
> > > -       struct ixgbe_rx_queue *rxq =3D rx_queue;
> > > +       struct ci_rx_queue *rxq =3D rx_queue;
> > >         volatile uint32_t *status;
> > >         uint32_t nb_hold, desc;
> > >
> > > @@ -3399,7 +3399,7 @@ ixgbe_dev_rx_descriptor_status(void *rx_queue,
> > > uint16_t offset)
> > >         if (desc >=3D rxq->nb_rx_desc)
> > >                 desc -=3D rxq->nb_rx_desc;
> > >
> > > -       status =3D &rxq->rx_ring[desc].wb.upper.status_error;
> > > +       status =3D &rxq->ixgbe_rx_ring[desc].wb.upper.status_error;
> > >         if (*status & rte_cpu_to_le_32(IXGBE_RXDADV_STAT_DD))
> > >                 return RTE_ETH_RX_DESC_DONE;
> > >
> > > @@ -3482,7 +3482,7 @@ ixgbe_dev_clear_queues(struct rte_eth_dev *dev)
> > >         }
> > >
> > >         for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
> > > -               struct ixgbe_rx_queue *rxq =3D dev->data->rx_queues[i=
];
> > > +               struct ci_rx_queue *rxq =3D dev->data->rx_queues[i];
> > >
> > >                 if (rxq !=3D NULL) {
> > >                         ixgbe_rx_queue_release_mbufs(rxq);
> > > @@ -4644,9 +4644,9 @@ ixgbe_vmdq_tx_hw_configure(struct ixgbe_hw
> > > *hw)  }
> > >
> > >  static int __rte_cold
> > > -ixgbe_alloc_rx_queue_mbufs(struct ixgbe_rx_queue *rxq)
> > > +ixgbe_alloc_rx_queue_mbufs(struct ci_rx_queue *rxq)
> > >  {
> > > -       struct ixgbe_rx_entry *rxe =3D rxq->sw_ring;
> > > +       struct ci_rx_entry *rxe =3D rxq->sw_ring;
> > >         uint64_t dma_addr;
> > >         unsigned int i;
> > >
> > > @@ -4666,7 +4666,7 @@ ixgbe_alloc_rx_queue_mbufs(struct
> > > ixgbe_rx_queue
> > > *rxq)
> > >
> > >                 dma_addr =3D
> > >                         rte_cpu_to_le_64(rte_mbuf_data_iova_default(m=
buf));
> > > -               rxd =3D &rxq->rx_ring[i];
> > > +               rxd =3D &rxq->ixgbe_rx_ring[i];
> > >                 rxd->read.hdr_addr =3D 0;
> > >                 rxd->read.pkt_addr =3D dma_addr;
> > >                 rxe[i].mbuf =3D mbuf;
> > > @@ -5083,7 +5083,7 @@ ixgbe_set_rx_function(struct rte_eth_dev *dev)
> > >                 dev->rx_pkt_burst =3D=3D ixgbe_recv_pkts_vec);
> > >
> > >         for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
> > > -               struct ixgbe_rx_queue *rxq =3D dev->data->rx_queues[i=
];
> > > +               struct ci_rx_queue *rxq =3D dev->data->rx_queues[i];
> > >
> > >                 rxq->vector_rx =3D rx_using_sse;  #ifdef
> > > RTE_LIB_SECURITY @@ -
> > > 5161,7 +5161,7 @@ ixgbe_set_rsc(struct rte_eth_dev *dev)
> > >
> > >         /* Per-queue RSC configuration (chapter 4.6.7.2.2 of 82599 Sp=
ec) */
> > >         for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
> > > -               struct ixgbe_rx_queue *rxq =3D dev->data->rx_queues[i=
];
> > > +               struct ci_rx_queue *rxq =3D dev->data->rx_queues[i];
> > >                 uint32_t srrctl =3D
> > >                         IXGBE_READ_REG(hw, IXGBE_SRRCTL(rxq->reg_idx)=
);
> > >                 uint32_t rscctl =3D
> > > @@ -5237,7 +5237,7 @@ int __rte_cold  ixgbe_dev_rx_init(struct
> > > rte_eth_dev *dev)  {
> > >         struct ixgbe_hw     *hw;
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >         uint64_t bus_addr;
> > >         uint32_t rxctrl;
> > >         uint32_t fctrl;
> > > @@ -5533,7 +5533,7 @@ ixgbe_dev_rxtx_start(struct rte_eth_dev *dev)  =
{
> > >         struct ixgbe_hw     *hw;
> > >         struct ci_tx_queue *txq;
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >         uint32_t txdctl;
> > >         uint32_t dmatxctl;
> > >         uint32_t rxctrl;
> > > @@ -5620,7 +5620,7 @@ int __rte_cold
> > > ixgbe_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_i=
d)  {
> > >         struct ixgbe_hw     *hw;
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >         uint32_t rxdctl;
> > >         int poll_ms;
> > >
> > > @@ -5663,7 +5663,7 @@ ixgbe_dev_rx_queue_stop(struct rte_eth_dev
> > > *dev, uint16_t rx_queue_id)  {
> > >         struct ixgbe_hw     *hw;
> > >         struct ixgbe_adapter *adapter =3D dev->data->dev_private;
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >         uint32_t rxdctl;
> > >         int poll_ms;
> > >
> > > @@ -5797,7 +5797,7 @@ void
> > >  ixgbe_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
> > >         struct rte_eth_rxq_info *qinfo)  {
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >
> > >         rxq =3D dev->data->rx_queues[queue_id];
> > >
> > > @@ -5835,7 +5835,7 @@ void
> > >  ixgbe_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_i=
d,
> > >         struct rte_eth_recycle_rxq_info *recycle_rxq_info)  {
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >         struct ixgbe_adapter *adapter =3D dev->data->dev_private;
> > >
> > >         rxq =3D dev->data->rx_queues[queue_id]; @@ -5861,7 +5861,7 @@=
 int
> > > __rte_cold  ixgbevf_dev_rx_init(struct rte_eth_dev *dev)  {
> > >         struct ixgbe_hw     *hw;
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >         struct rte_eth_rxmode *rxmode =3D &dev->data->dev_conf.rxmode=
;
> > >         uint32_t frame_size =3D dev->data->mtu + IXGBE_ETH_OVERHEAD;
> > >         uint64_t bus_addr;
> > > @@ -6048,7 +6048,7 @@ ixgbevf_dev_rxtx_start(struct rte_eth_dev *dev)=
  {
> > >         struct ixgbe_hw     *hw;
> > >         struct ci_tx_queue *txq;
> > > -       struct ixgbe_rx_queue *rxq;
> > > +       struct ci_rx_queue *rxq;
> > >         uint32_t txdctl;
> > >         uint32_t rxdctl;
> > >         uint16_t i;
> > > diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> > > index 9047ee4763..aad7ee81ee 100644
> > > --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> > > +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> > > @@ -7,6 +7,7 @@
> > >
> > >  #include "ixgbe_type.h"
> > >
> > > +#include "../common/rx.h"
> > >  #include "../common/tx.h"
> > >
> > >  /*
> > > @@ -32,7 +33,7 @@
> > >  #define        IXGBE_MAX_RING_DESC     8192
> > >
> > >  #define IXGBE_TX_MAX_BURST            32
> > > -#define IXGBE_RX_MAX_BURST            32
> > > +#define IXGBE_RX_MAX_BURST            CI_RX_MAX_BURST
> > >  #define IXGBE_TX_MAX_FREE_BUF_SZ      64
> > >
> > >  #define IXGBE_VPMD_DESCS_PER_LOOP     4
> > > @@ -66,64 +67,6 @@
> > >  #define IXGBE_PACKET_TYPE_TN_MAX            0X100
> > >  #define IXGBE_PACKET_TYPE_SHIFT             0X04
> > >
> > > -/**
> > > - * Structure associated with each descriptor of the RX ring of a RX =
queue.
> > > - */
> > > -struct ixgbe_rx_entry {
> > > -       struct rte_mbuf *mbuf; /**< mbuf associated with RX descripto=
r. */
> > > -};
> > > -
> > > -struct ixgbe_scattered_rx_entry {
> > > -       struct rte_mbuf *fbuf; /**< First segment of the fragmented p=
acket. */
> > > -};
> > > -
> > > -/**
> > > - * Structure associated with each RX queue.
> > > - */
> > > -struct ixgbe_rx_queue {
> > > -       struct rte_mempool  *mp; /**< mbuf pool to populate RX ring. =
*/
> > > -       volatile union ixgbe_adv_rx_desc *rx_ring; /**< RX ring virtu=
al address. */
> > > -       uint64_t            rx_ring_phys_addr; /**< RX ring DMA addre=
ss. */
> > > -       volatile uint32_t   *qrx_tail; /**< RDT register address. */
> > > -       struct ixgbe_rx_entry *sw_ring; /**< address of RX software r=
ing. */
> > > -       struct ixgbe_scattered_rx_entry *sw_sc_ring; /**< address of =
scattered
> Rx
> > > software ring. */
> > > -       struct rte_mbuf *pkt_first_seg; /**< First segment of current=
 packet. */
> > > -       struct rte_mbuf *pkt_last_seg; /**< Last segment of current p=
acket. */
> > > -       uint64_t            mbuf_initializer; /**< value to init mbuf=
s */
> > > -       uint16_t            nb_rx_desc; /**< number of RX descriptors=
. */
> > > -       uint16_t            rx_tail;  /**< current value of RDT regis=
ter. */
> > > -       uint16_t            nb_rx_hold; /**< number of held free RX d=
esc. */
> > > -       uint16_t rx_nb_avail; /**< nr of staged pkts ready to ret to =
app */
> > > -       uint16_t rx_next_avail; /**< idx of next staged pkt to ret to=
 app */
> > > -       uint16_t rx_free_trigger; /**< triggers rx buffer allocation =
*/
> > > -       uint8_t            vector_rx;
> > > -       /**< indicates that vector RX is in use */
> > > -#ifdef RTE_LIB_SECURITY
> > > -       uint8_t            using_ipsec;
> > > -       /**< indicates that IPsec RX feature is in use */
> > > -#endif
> > > -       uint16_t            rxrearm_nb;     /**< number of remaining =
to be re-armed */
> > > -       uint16_t            rxrearm_start;  /**< the idx we start the=
 re-arming from */
> > > -       uint16_t            rx_free_thresh; /**< max free RX desc to =
hold. */
> > > -       uint16_t            queue_id; /**< RX queue index. */
> > > -       uint16_t            reg_idx;  /**< RX queue register index. *=
/
> > > -       uint16_t            pkt_type_mask;  /**< Packet type mask for=
 different NICs.
> */
> > > -       uint16_t            port_id;  /**< Device port identifier. */
> > > -       uint8_t             crc_len;  /**< 0 if CRC stripped, 4 other=
wise. */
> > > -       uint8_t             drop_en;  /**< If not 0, set SRRCTL.Drop_=
En. */
> > > -       uint8_t             rx_deferred_start; /**< not in global dev=
 start. */
> > > -       /** UDP frames with a 0 checksum can be marked as checksum er=
rors. */
> > > -       uint8_t             rx_udp_csum_zero_err;
> > > -       /** flags to set in mbuf when a vlan is detected. */
> > > -       uint64_t            vlan_flags;
> > > -       uint64_t            offloads; /**< Rx offloads with
> RTE_ETH_RX_OFFLOAD_* */
> > > -       /** need to alloc dummy mbuf, for wraparound when scanning hw=
 ring */
> > > -       struct rte_mbuf fake_mbuf;
> > > -       /** hold packets to return to application */
> > > -       struct rte_mbuf *rx_stage[IXGBE_RX_MAX_BURST * 2];
> > > -       const struct rte_memzone *mz;
> > > -};
> > > -
> > >  /**
> > >   * IXGBE CTX Constants
> > >   */
> > > diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
> > > b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
> > > index 707dc7f5f9..5f231b9012 100644
> > > --- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
> > > +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
> > > @@ -61,7 +61,7 @@ ixgbe_reset_tx_queue_vec(struct ci_tx_queue *txq)  =
}
> > >
> > >  void __rte_cold
> > > -ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq)
> > > +ixgbe_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
> > >  {
> > >         unsigned int i;
> > >
> > > @@ -90,7 +90,7 @@ ixgbe_rx_queue_release_mbufs_vec(struct
> ixgbe_rx_queue
> > > *rxq)  }
> > >
> > >  int __rte_cold
> > > -ixgbe_rxq_vec_setup(struct ixgbe_rx_queue *rxq)
> > > +ixgbe_rxq_vec_setup(struct ci_rx_queue *rxq)
> > >  {
> > >         rxq->mbuf_initializer =3D ci_rxq_mbuf_initializer(rxq->port_i=
d);
> > >         return 0;
> > > @@ -126,7 +126,7 @@ ixgbe_rx_vec_dev_conf_condition_check(struct
> > > rte_eth_dev *dev)
> > >                 return -1;
> > >
> > >         for (uint16_t i =3D 0; i < dev->data->nb_rx_queues; i++) {
> > > -               struct ixgbe_rx_queue *rxq =3D dev->data->rx_queues[i=
];
> > > +               struct ci_rx_queue *rxq =3D dev->data->rx_queues[i];
> > >                 if (!rxq)
> > >                         continue;
> > >                 if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free=
_thresh, rxq-
> > > >offloads)) @@ -173,15 +173,15 @@ ixgbe_xmit_pkts_vec(void *tx_queue,
> struct
> > > rte_mbuf **tx_pkts,  void  ixgbe_recycle_rx_descriptors_refill_vec(vo=
id
> *rx_queue,
> > > uint16_t nb_mbufs)  {
> > > -       struct ixgbe_rx_queue *rxq =3D rx_queue;
> > > -       struct ixgbe_rx_entry *rxep;
> > > +       struct ci_rx_queue *rxq =3D rx_queue;
> > > +       struct ci_rx_entry *rxep;
> > >         volatile union ixgbe_adv_rx_desc *rxdp;
> > >         uint16_t rx_id;
> > >         uint64_t paddr;
> > >         uint64_t dma_addr;
> > >         uint16_t i;
> > >
> > > -       rxdp =3D rxq->rx_ring + rxq->rxrearm_start;
> > > +       rxdp =3D rxq->ixgbe_rx_ring + rxq->rxrearm_start;
> > >         rxep =3D &rxq->sw_ring[rxq->rxrearm_start];
> > >
> > >         for (i =3D 0; i < nb_mbufs; i++) { diff --git
> > > a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
> > > b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
> > > index e05696f584..e54f532497 100644
> > > --- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
> > > +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
> > > @@ -12,9 +12,9 @@
> > >  #include "ixgbe_rxtx.h"
> > >
> > >  int ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev); =
-int
> > > ixgbe_rxq_vec_setup(struct ixgbe_rx_queue *rxq);
> > > +int ixgbe_rxq_vec_setup(struct ci_rx_queue *rxq);
> > >  int ixgbe_txq_vec_setup(struct ci_tx_queue *txq); -void
> > > ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq);
> > > +void ixgbe_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq);
> > >  void ixgbe_reset_tx_queue_vec(struct ci_tx_queue *txq);  void
> > > ixgbe_tx_free_swring_vec(struct ci_tx_queue *txq);  uint16_t
> > > ixgbe_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16=
_t
> nb_pkts);
> > > @@ -79,5 +79,4 @@ ixgbe_tx_free_bufs_vec(struct ci_tx_queue *txq)
> > >
> > >         return txq->tx_rs_thresh;
> > >  }
> > > -
> > >  #endif
> > > diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
> > > b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
> > > index 2d42b7b1c1..ce492f2ff1 100644
> > > --- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
> > > +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
> > > @@ -12,19 +12,19 @@
> > >  #include "ixgbe_rxtx_vec_common.h"
> > >
> > >  static inline void
> > > -ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
> > > +ixgbe_rxq_rearm(struct ci_rx_queue *rxq)
> > >  {
> > >         int i;
> > >         uint16_t rx_id;
> > >         volatile union ixgbe_adv_rx_desc *rxdp;
> > > -       struct ixgbe_rx_entry *rxep =3D &rxq->sw_ring[rxq->rxrearm_st=
art];
> > > +       struct ci_rx_entry *rxep =3D &rxq->sw_ring[rxq->rxrearm_start=
];
> > >         struct rte_mbuf *mb0, *mb1;
> > >         uint64x2_t dma_addr0, dma_addr1;
> > >         uint64x2_t zero =3D vdupq_n_u64(0);
> > >         uint64_t paddr;
> > >         uint8x8_t p;
> > >
> > > -       rxdp =3D rxq->rx_ring + rxq->rxrearm_start;
> > > +       rxdp =3D rxq->ixgbe_rx_ring + rxq->rxrearm_start;
> > >
> > >         /* Pull 'n' more MBUFs into the software ring */
> > >         if (unlikely(rte_mempool_get_bulk(rxq->mp,
> > > @@ -282,11 +282,11 @@ desc_to_ptype_v(uint64x2_t descs[4], uint16_t
> > > pkt_type_mask,
> > >   * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
> > >   */
> > >  static inline uint16_t
> > > -_recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_=
pkts,
> > > +_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkt=
s,
> > >                    uint16_t nb_pkts, uint8_t *split_packet)  {
> > >         volatile union ixgbe_adv_rx_desc *rxdp;
> > > -       struct ixgbe_rx_entry *sw_ring;
> > > +       struct ci_rx_entry *sw_ring;
> > >         uint16_t nb_pkts_recd;
> > >         int pos;
> > >         uint8x16_t shuf_msk =3D {
> > > @@ -309,7 +309,7 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq,
> struct
> > > rte_mbuf **rx_pkts,
> > >         /* Just the act of getting into the function from the applica=
tion is
> > >          * going to cost about 7 cycles
> > >          */
> > > -       rxdp =3D rxq->rx_ring + rxq->rx_tail;
> > > +       rxdp =3D rxq->ixgbe_rx_ring + rxq->rx_tail;
> > >
> > >         rte_prefetch_non_temporal(rxdp);
> > >
> > > @@ -488,7 +488,7 @@ static uint16_t
> > >  ixgbe_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_=
pkts,
> > >                                uint16_t nb_pkts)  {
> > > -       struct ixgbe_rx_queue *rxq =3D rx_queue;
> > > +       struct ci_rx_queue *rxq =3D rx_queue;
> > >         uint8_t split_flags[IXGBE_VPMD_RX_BURST] =3D {0};
> > >
> > >         /* get some new buffers */
> > > diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
> > > b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
> > > index f5bb7eb0bd..f977489b95 100644
> > > --- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
> > > +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
> > > @@ -13,12 +13,12 @@
> > >  #include <rte_vect.h>
> > >
> > >  static inline void
> > > -ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
> > > +ixgbe_rxq_rearm(struct ci_rx_queue *rxq)
> > >  {
> > >         int i;
> > >         uint16_t rx_id;
> > >         volatile union ixgbe_adv_rx_desc *rxdp;
> > > -       struct ixgbe_rx_entry *rxep =3D &rxq->sw_ring[rxq->rxrearm_st=
art];
> > > +       struct ci_rx_entry *rxep =3D &rxq->sw_ring[rxq->rxrearm_start=
];
> > >         struct rte_mbuf *mb0, *mb1;
> > >         __m128i hdr_room =3D _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
> > >                         RTE_PKTMBUF_HEADROOM); @@ -26,7 +26,7 @@
> > > ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
> > >
> > >         const __m128i hba_msk =3D _mm_set_epi64x(0, UINT64_MAX);
> > >
> > > -       rxdp =3D rxq->rx_ring + rxq->rxrearm_start;
> > > +       rxdp =3D rxq->ixgbe_rx_ring + rxq->rxrearm_start;
> > >
> > >         /* Pull 'n' more MBUFs into the software ring */
> > >         if (rte_mempool_get_bulk(rxq->mp, @@ -327,11 +327,11 @@
> > > desc_to_ptype_v(__m128i descs[4], uint16_t pkt_type_mask,
> > >   * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
> > >   */
> > >  static inline uint16_t
> > > -_recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_=
pkts,
> > > +_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkt=
s,
> > >                 uint16_t nb_pkts, uint8_t *split_packet)  {
> > >         volatile union ixgbe_adv_rx_desc *rxdp;
> > > -       struct ixgbe_rx_entry *sw_ring;
> > > +       struct ci_rx_entry *sw_ring;
> > >         uint16_t nb_pkts_recd;
> > >  #ifdef RTE_LIB_SECURITY
> > >         uint8_t use_ipsec =3D rxq->using_ipsec; @@ -377,7 +377,7 @@
> > > _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_p=
kts,
> > >         /* Just the act of getting into the function from the applica=
tion is
> > >          * going to cost about 7 cycles
> > >          */
> > > -       rxdp =3D rxq->rx_ring + rxq->rx_tail;
> > > +       rxdp =3D rxq->ixgbe_rx_ring + rxq->rx_tail;
> > >
> > >         rte_prefetch0(rxdp);
> > >
> > > @@ -609,7 +609,7 @@ static uint16_t
> > >  ixgbe_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_=
pkts,
> > >                                uint16_t nb_pkts)  {
> > > -       struct ixgbe_rx_queue *rxq =3D rx_queue;
> > > +       struct ci_rx_queue *rxq =3D rx_queue;
> > >         uint8_t split_flags[IXGBE_VPMD_RX_BURST] =3D {0};
> > >
> > >         /* get some new buffers */
> > > --
> > > 2.47.1
> >
> > Please note, we are using the following steps to validate the patch
> >
> > ```
> > 1. git clone https://dpdk.org/git/dpdk
> > 2. git chekout
> > 3. git apply <patch>
> > ```
> > Can you please suggest if we are missing something? We would like to te=
st the
> patch on E810
> >
>
> The patches should apply cleanly to next-net-intel tree rather than main
> tree - they applied for me without issue yesterday.
Aah I made the mistake, we can apply the patch to next-net branch. Go it.

>
> However, in testing them, I've found some issues with the patches, which =
we
> are now fixing, and doing additional performance tests. Therefore, I'd
> suggest waiting for the next version of the patchset before testing.

Ok, thanks will wait.

>
> Thanks for looking to test these too, though. Looking forward to getting
> feedback based on the results you see.

Sure will do
>
> /Bruce
