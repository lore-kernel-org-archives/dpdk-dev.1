Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62544C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 10:12:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13A6E4021F;
	Thu, 12 Jun 2025 12:12:28 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by mails.dpdk.org (Postfix) with ESMTP id 811454003C
 for <dev@dpdk.org>; Thu, 12 Jun 2025 12:12:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2iQ+gVtN3/V8qxyFCjKhET8FBjyUfXcn1RnKpb2usJ3nAVoBTNgu9gaTr9HYLqVFyVgZmvFiE4k/16ZiZNQ9oYqFLu/k5gYVrcrJSmhqZb1D318SgnSgGyOF3zs2b+gaBZx5i8OguIBSC42WV9qVZnVRxZY29UlnRUxxhvlJEDukOzeC+K8hKqRVHjOlrxTPkoH6F6UXwkF2zn3er8TJGLzBKnTTScJwUb07YLIr1xY306WbDhR8xrThxdRNZLyy1D2MnXzc64yaBsj0oG18HcMEXEcM5f0ff3JBfMxzuslyQp1y/+B5Tznk+f4yy9NzXc/oKc+tAUINrpngCeHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9GeMn8ZDraqd874MRX50fBma5kY+xLXk+XucO4ercM=;
 b=E0gOfnYPaLe1dxpO74CIXkWEmLD+puEy99kZNM2v48ftl/5qsUNuR5nxJa8fin06jSOwOGoJxItilxNRe9OEEOprrY0A5f+CYbHwWK1DJxuIYP4uwD43swYNfXpcsKaAy+343X7+V/s6CgOmwClqmenc4T28ixuvuDob9Rku0Vi7spp/hLUmf5i6faRzj7UD8MXotD66h1LMzIoJuwaLRubtwb7PNZfBz3SXGZkyr54UqYOHHv9/TALRbsWRVn4vzY4QXtne43/V/gwHtUbMxrH3ZhcczC18rYprxepI+OGDNdoCMmWw8eOLmHsM91XIsHdjsZxUKge/1Jtj/ODz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9GeMn8ZDraqd874MRX50fBma5kY+xLXk+XucO4ercM=;
 b=2PBtWpSfctqfWjRIWs7icc/+wA9uJGjQPqoeRti/78CJxJ2dp0rGwOf14K5yMFxlQqiaUw0ZMOYYng3HNSr80Cx3U4fTDNWGAFuILe5aFOLsyOnjkCNuZkoCfAXVlbhltTHpfOxU4q+5AhjdiubmnhdLqp166/c0RLn+Oj34Dz0=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 10:12:23 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 10:12:23 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, Vladimir
 Medvedkin <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v6 23/33] net/ixgbe: create common Rx queue structure
Thread-Topic: [PATCH v6 23/33] net/ixgbe: create common Rx queue structure
Thread-Index: AQHb2VTmZMiSMEasqUqHSVvcD6tQjLP/T2sA
Content-Class: 
Date: Thu, 12 Jun 2025 10:12:23 +0000
Message-ID: <PH7PR12MB8596F835791ABF579E92C6B88274A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <cover.1749483381.git.anatoly.burakov@intel.com>
 <cover.1749483381.git.anatoly.burakov@intel.com>
 <67e447a725410d7ef1af5317e3c7e1ee487792c3.1749483382.git.anatoly.burakov@intel.com>
In-Reply-To: <67e447a725410d7ef1af5317e3c7e1ee487792c3.1749483382.git.anatoly.burakov@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-12T10:02:18.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|DM6PR12MB4297:EE_
x-ms-office365-filtering-correlation-id: 908e7c59-e4f4-47b3-ac92-08dda9999fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vExj5D7UB9AqHKPoKnZYI5NtEwU4+JU+4DYSjJPWu2Vs35oTgl8uvIor0EEj?=
 =?us-ascii?Q?ZR2HjAjYmhn5g16Rc6bS9BW/+2/cWOoIg1gYMfohbii26ycWd+ozgTEFKA7O?=
 =?us-ascii?Q?u6cgxv3COfvM6AhO3YGWVuHsTQj54EgkJVFAnlFYkbuxFA2fH5cuKdmwjC4l?=
 =?us-ascii?Q?3SRXDsn5TvoK4knbuaQuY0KwIiYUDQAQAthTCcCN1Ah45oRNWkvtHNF12Fmc?=
 =?us-ascii?Q?vXTY/D0N6Hp72h3TlYw7UBnWlBiSci8IztLnDhOfdgfJjt4NNDmEopmysb9u?=
 =?us-ascii?Q?pJ087nRDRub0mGsGzH5d0L6BL7QCjRMHFAlC5y36rG/BESZ7w3JPfBZj6X7o?=
 =?us-ascii?Q?QDRFwRvuN83T4RGIkDe2h9KbHC7KuYKT0No1f+QThYNZHoLll6wnAsiLD3bH?=
 =?us-ascii?Q?D0Rw4MVvjliNanl974vlBALxFKC6c6NjG8rXn9A1hH6JGQ9Kqv+tKGF6cqJH?=
 =?us-ascii?Q?hDPVOFfZ+XXurjxTBsGf0CepiRbh5rxieknZ3O0FfjO836EfusveRuDNThEc?=
 =?us-ascii?Q?t//Q7LEQjNJ3ypLz768k7NZeRUzWtIbNeBqnXeN5IFab6+7BzQBkpBbiKpEk?=
 =?us-ascii?Q?I0FQRjcghUbQwrC56F397JhD0GFQkWjE2GnE0lkzG4yQ9P5J6CdTLtTjIg+t?=
 =?us-ascii?Q?VBcQAvUbCuEo/sIJ2/N3vbHDO/2n9Zexh81xqnOY8sK0FdjerLIuLi1WFST3?=
 =?us-ascii?Q?grI7nbbUQ+TNwpjniNw0I/uDwjmmIK1ADSM+3rZadl0FaqCSSX+s5t5gK97T?=
 =?us-ascii?Q?JEC2eSWLgPjdZZa4jjwihxxpsyZjyj1Q5vGyMsfYXxnsEQwjyUuZZXhS4G46?=
 =?us-ascii?Q?DbaptjLWoCfLw3UlRZOU+xIGL2P92DFhyJAZkdBP/8bpymdbNHv98gdT7XZD?=
 =?us-ascii?Q?JbFR7RNpnraf60PBxIIODCVpIPC0b02yvGZ9eXUMBqegTGqvcuGHmkQ46LAB?=
 =?us-ascii?Q?XRYVZZ90kRCqh6DuKQ3LrQ9q2cPjvn/nQ0BVEU3tD+xMdVLRFHoFsd9usaLr?=
 =?us-ascii?Q?bXmbPQOWFSypo4SI2E+hQIasMZZCn5Wp4hFBNC8vaw3J14PoRKVWirWozMvm?=
 =?us-ascii?Q?P0CT1XN2SGmqDOF1gdKnxWNWJwLGpzb6Aux/WU6ye5pEeY0yReYC0JqWH6KY?=
 =?us-ascii?Q?6Vd4V8ojXl+BSFI0RmIN6d0brTcdlZ/bzYcJT65nCTGFI20tln4wzGJDtD9P?=
 =?us-ascii?Q?LgAWYDdn2+1usgxZIT+W7ToDgQ+L9h/FCZ0O0OMcwaTWceAQJEzFLSlDgf+r?=
 =?us-ascii?Q?UAxL48nSpxT918X4fwpgSDPVew8RHF63EJPnl77AO+SUGqy3MLleIwyrRTui?=
 =?us-ascii?Q?8rcQkHRdXXFZMg1njKFpTRPbyhiZDAcGgCvDsAFZmnfzoSSQmfI6Ibj23w9p?=
 =?us-ascii?Q?w6WPhA+3gOKw8ihV80hXl/V0/paaCQ5l51hK3APJJl1LJBthEawcjZnROqRK?=
 =?us-ascii?Q?9+VSBPCOIzc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4TQs1d1vc/VXCzrktvjinDVqdLWrP/IFoqXPc3wlL/riuPtzUotl6JdJd3w4?=
 =?us-ascii?Q?I0VBPsDlUnB5ubL6WdT7bozxFqfp4otLGOs/8EjE1ZbiQnxB+iPkKPDts/ku?=
 =?us-ascii?Q?CsPQUDhDNNEj1fbqv6tYq057K82edWumt0woWCtcSxa3jk2kwuQ7tKkotYMI?=
 =?us-ascii?Q?yDFnpazLo3GUJMfXmnUrs9Jv+aupzjN5SU+FCYpvYtlQMfRuuRrdSA+qRUsa?=
 =?us-ascii?Q?YVkVHLerN+UC3nS+MHxWzUlLUVEgW42o/gc31FdF/XP9dvcqfden34uirhbd?=
 =?us-ascii?Q?b2wkHY0dupq7IBaiXUzG544Jv32EVrrFvSNi7hDigyjCxHP0/9rW6KrPdg+D?=
 =?us-ascii?Q?iMH7bvmf7oWMhPYsz/VJC1GN84FenaWcHFDW3qypgRWffhw/JNpkNU9Kf4A9?=
 =?us-ascii?Q?4aHevhC3XqUceShvXp/6f5L/ka8k3C5Cfkje7EyqhIUXT7W7NcOjZpUkdYIr?=
 =?us-ascii?Q?9CCmcC1nh9OHl4Dj/9kKgE6zdxdqGhmKaeG5asgZI2gCoGOYhynz6mDphT6t?=
 =?us-ascii?Q?5VddTlxB19d14qTZObtc/Au317VSAbY1YB/TY41kCXdv+KE3SmRwG5N3jSNP?=
 =?us-ascii?Q?Z4fwjQXuzQv7C2UhDNFtk1iOzLZKm7zYkTbduN3Si5NWCNi07ftlfpEeHvRt?=
 =?us-ascii?Q?NdgcQPcqHnxgwRCrACuXM1d68vBSay7lsvXEDjsoeiFoDEeDIugjS8UyEY1A?=
 =?us-ascii?Q?Zv9E61tXHaaHro2/bTXo0Ca3TrL5GQJ+iatqcEWV9OIu08ub9L0VzN6h83KP?=
 =?us-ascii?Q?ChKOaWRhPr+VuB1h4Xn4Joe751ECxYq6g3bndi79lXiwWn7akRXaGhnPTF1S?=
 =?us-ascii?Q?2NMegAT1yRXhxvD6rbIQRDGBaNuAiUXAU+827PUMMiwXON7gkA2b+10dvhgn?=
 =?us-ascii?Q?xDS998bBu3yc6L1PatZpWH1qUXsuptNLiJQC52LYP4P2iNAfYGRmV8vx1Gah?=
 =?us-ascii?Q?4RQqonVuAJ7kdqRZ3Q7enWMNtO2fdb07KQ28LreN+gFCyaCelBAWufSMO5rb?=
 =?us-ascii?Q?3IKF+dxpPfM71gtHD4BiLCjMW5hui/NtbauG34wTMoOmrsUA2TSu33aQItFb?=
 =?us-ascii?Q?wcenfD7ljsRM+aJMEfNbuAaeUvXAj0Ws9jKU+vwXpmsgHgwyfjRsX8J9Rx+f?=
 =?us-ascii?Q?2852AnNVpf+iSgjc9ntkBvxxvUPYtfxQQBz2fvia0sCs2Uumna/mncsGTNXl?=
 =?us-ascii?Q?NoVYYPMHPBddZVaBd9ohMqKtElhpee9H4dwNEkNgTY2gtHEFrJ4qmy0i4A3a?=
 =?us-ascii?Q?c7rZmdPv2htEX2PiZdqjM8P537KXJyYa7PH0EKjT2ao0fpDuvVJZQzzEs0jB?=
 =?us-ascii?Q?wygX+XhKXWIUvzjAW61wZrXMQFTY/t8qnXoWWYkP7P/B/l1C7oiaRXU5GkxP?=
 =?us-ascii?Q?elThzN71cilo17t8YhjVzkoYctW6YPDdXKMp6x7FmUcRVOJroH7tgBWM30sx?=
 =?us-ascii?Q?bFFY8DbHjYieCprJR/z9xRlHKfR71YQhT2mi/CSeXTaOzlg9DTV1Nbgm1OIf?=
 =?us-ascii?Q?5rMq5LWlgR3hgYOnPzhrscYuooFuwAwdTGB52nHszNCinfl5GrURPgRTQHyd?=
 =?us-ascii?Q?Rtg1LiLOvLBFx9BTtQM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908e7c59-e4f4-47b3-ac92-08dda9999fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 10:12:23.2828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7SI1wsqsOf8QgXZOm9jkYXMvxrDvtrxieVysilkb7ygEqsvy88nABo7xwIk+eh2aDPBZHt6SOFh8MxY9WeEDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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

Hi Bruce & Anatoly,

We are facing an issue while apply patch 23 individually or series.

We get the following error for individual apply

```
$ git apply p23.patch --verbose
Checking patch drivers/net/intel/common/rx.h...
Checking patch drivers/net/intel/ixgbe/ixgbe_ethdev.c...
Checking patch drivers/net/intel/ixgbe/ixgbe_rxtx.c...
error: while searching for:
                len +=3D IXGBE_RX_MAX_BURST;

        rxq->sw_ring =3D rte_zmalloc_socket("rxq->sw_ring",
                                          sizeof(struct ixgbe_rx_entry) * l=
en,
                                          RTE_CACHE_LINE_SIZE, socket_id);
        if (!rxq->sw_ring) {
                ixgbe_rx_queue_release(rxq);

error: patch failed: drivers/net/intel/ixgbe/ixgbe_rxtx.c:3309
error: drivers/net/intel/ixgbe/ixgbe_rxtx.c: patch does not apply
Checking patch drivers/net/intel/ixgbe/ixgbe_rxtx.h...
error: while searching for:
#define IXGBE_MAX_RING_DESC     8192

#define IXGBE_TX_MAX_BURST            32
#define IXGBE_RX_MAX_BURST            32
#define IXGBE_TX_MAX_FREE_BUF_SZ      64

#define IXGBE_VPMD_DESCS_PER_LOOP     4

error: patch failed: drivers/net/intel/ixgbe/ixgbe_rxtx.h:32
error: drivers/net/intel/ixgbe/ixgbe_rxtx.h: patch does not apply
Checking patch drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c...
Checking patch drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h...
Checking patch drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c...
error: while searching for:
 * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
 */
static inline uint16_t
_recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
                   uint16_t nb_pkts, uint8_t *split_packet)
{
        volatile union ixgbe_adv_rx_desc *rxdp;
        struct ixgbe_rx_entry *sw_ring;
        uint16_t nb_pkts_recd;
        int pos;
        uint8x16_t shuf_msk =3D {

error: patch failed: drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c:282
error: drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c: patch does not apply
Checking patch drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c...
error: while searching for:
 * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
 */
static inline uint16_t
_recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
                uint16_t nb_pkts, uint8_t *split_packet)
{
        volatile union ixgbe_adv_rx_desc *rxdp;
        struct ixgbe_rx_entry *sw_ring;
        uint16_t nb_pkts_recd;
#ifdef RTE_LIB_SECURITY
        uint8_t use_ipsec =3D rxq->using_ipsec;

error: patch failed: drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c:327
error: drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c: patch does not apply
```

And we get following error in series apply

```
$ git apply ../../Intel-PMD-drivers-Rx-cleanup.patch
error: patch failed: drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c:173
error: drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c: patch does not appl=
y
```

> -----Original Message-----
> From: Anatoly Burakov <anatoly.burakov@intel.com>
> Sent: Monday, June 9, 2025 9:07 PM
> To: dev@dpdk.org; Bruce Richardson <bruce.richardson@intel.com>; Vladimir
> Medvedkin <vladimir.medvedkin@intel.com>
> Subject: [PATCH v6 23/33] net/ixgbe: create common Rx queue structure
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> In preparation for deduplication effort, generalize the Rx queue structur=
e.
>
> The entire Rx queue structure is moved to common/rx.h, clarifying the com=
ments
> where necessary, and separating common parts from ixgbe-specific parts.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>
> Notes:
>     v5:
>     - Sort ixgbe-specific fields by size
>
>     v3 -> v4:
>     - Separate out some of the changes from this commit into previous com=
mits
>     - Rename CI_RX_BURST to CI_RX_MAX_BURST to match the driver naming
> convention
>
>  drivers/net/intel/common/rx.h                 |  67 ++++++++++-
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   8 +-
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 108 +++++++++---------
>  drivers/net/intel/ixgbe/ixgbe_rxtx.h          |  61 +---------
>  .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   |  12 +-
>  .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   |   5 +-
>  drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c |  14 +--
> drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  |  14 +--
>  8 files changed, 146 insertions(+), 143 deletions(-)
>
> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.=
h index
> abb01ba5e7..b60ca24dfb 100644
> --- a/drivers/net/intel/common/rx.h
> +++ b/drivers/net/intel/common/rx.h
> @@ -10,14 +10,75 @@
>  #include <rte_mbuf.h>
>  #include <rte_ethdev.h>
>
> -#define CI_RX_BURST 32
> +#define CI_RX_MAX_BURST 32
> +
> +struct ci_rx_queue;
> +
> +struct ci_rx_entry {
> +       struct rte_mbuf *mbuf; /* mbuf associated with RX descriptor. */
> +};
> +
> +struct ci_rx_entry_sc {
> +       struct rte_mbuf *fbuf; /* First segment of the fragmented
> +packet.*/ };
> +
> +/**
> + * Structure associated with each RX queue.
> + */
> +struct ci_rx_queue {
> +       struct rte_mempool  *mp; /**< mbuf pool to populate RX ring. */
> +       union { /* RX ring virtual address */
> +               volatile union ixgbe_adv_rx_desc *ixgbe_rx_ring;
> +       };
> +       volatile uint8_t *qrx_tail;   /**< register address of tail */
> +       struct ci_rx_entry *sw_ring; /**< address of RX software ring. */
> +       struct ci_rx_entry_sc *sw_sc_ring; /**< address of scattered Rx s=
oftware
> ring. */
> +       rte_iova_t rx_ring_phys_addr; /**< RX ring DMA address. */
> +       struct rte_mbuf *pkt_first_seg; /**< First segment of current pac=
ket. */
> +       struct rte_mbuf *pkt_last_seg; /**< Last segment of current packe=
t. */
> +       /** hold packets to return to application */
> +       struct rte_mbuf *rx_stage[CI_RX_MAX_BURST * 2];
> +       uint16_t nb_rx_desc; /**< number of RX descriptors. */
> +       uint16_t rx_tail;  /**< current value of tail register. */
> +       uint16_t rx_nb_avail; /**< nr of staged pkts ready to ret to app =
*/
> +       uint16_t nb_rx_hold; /**< number of held free RX desc. */
> +       uint16_t rx_next_avail; /**< idx of next staged pkt to ret to app=
 */
> +       uint16_t rx_free_thresh; /**< max free RX desc to hold. */
> +       uint16_t rx_free_trigger; /**< triggers rx buffer allocation */
> +       uint16_t rxrearm_nb;     /**< number of remaining to be re-armed =
*/
> +       uint16_t rxrearm_start;  /**< the idx we start the re-arming from=
 */
> +       uint16_t queue_id; /**< RX queue index. */
> +       uint16_t port_id;  /**< Device port identifier. */
> +       uint16_t reg_idx;  /**< RX queue register index. */
> +       uint8_t crc_len;  /**< 0 if CRC stripped, 4 otherwise. */
> +       bool rx_deferred_start; /**< queue is not started on dev start. *=
/
> +       bool vector_rx; /**< indicates that vector RX is in use */
> +       bool drop_en;  /**< if 1, drop packets if no descriptors are avai=
lable. */
> +       uint64_t mbuf_initializer; /**< value to init mbufs */
> +       uint64_t offloads; /**< Rx offloads with RTE_ETH_RX_OFFLOAD_* */
> +       /** need to alloc dummy mbuf, for wraparound when scanning hw rin=
g */
> +       struct rte_mbuf fake_mbuf;
> +       const struct rte_memzone *mz;
> +       union {
> +               struct { /* ixgbe specific values */
> +                       /** flags to set in mbuf when a vlan is detected.=
 */
> +                       uint64_t vlan_flags;
> +                       /** Packet type mask for different NICs. */
> +                       uint16_t pkt_type_mask;
> +                       /** indicates that IPsec RX feature is in use */
> +                       uint8_t using_ipsec;
> +                       /** UDP frames with a 0 checksum can be marked as=
 checksum
> errors. */
> +                       uint8_t rx_udp_csum_zero_err;
> +               };
> +       };
> +};
>
>  static inline uint16_t
>  ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs, uint16_t nb_bufs, ui=
nt8_t
> *split_flags,
>                 struct rte_mbuf **pkt_first_seg, struct rte_mbuf **pkt_la=
st_seg,
>                 const uint8_t crc_len)
>  {
> -       struct rte_mbuf *pkts[CI_RX_BURST] =3D {0}; /*finished pkts*/
> +       struct rte_mbuf *pkts[CI_RX_MAX_BURST] =3D {0}; /*finished pkts*/
>         struct rte_mbuf *start =3D *pkt_first_seg;
>         struct rte_mbuf *end =3D *pkt_last_seg;
>         unsigned int pkt_idx, buf_idx;
> @@ -97,7 +158,7 @@ static inline bool
>  ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh, uint64_t o=
ffloads)  {
>         if (!rte_is_power_of_2(nb_desc) ||
> -                       rx_free_thresh < CI_RX_BURST ||
> +                       rx_free_thresh < CI_RX_MAX_BURST ||
>                         (nb_desc % rx_free_thresh) !=3D 0)
>                 return false;
>
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index 928ac57a93..f8b99d4de5 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -2022,7 +2022,7 @@ ixgbe_vlan_hw_strip_bitmap_set(struct rte_eth_dev
> *dev, uint16_t queue, bool on)  {
>         struct ixgbe_hwstrip *hwstrip =3D
>                 IXGBE_DEV_PRIVATE_TO_HWSTRIP_BITMAP(dev->data-
> >dev_private);
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>
>         if (queue >=3D IXGBE_MAX_RX_QUEUE_NUM)
>                 return;
> @@ -2157,7 +2157,7 @@ ixgbe_vlan_hw_strip_config(struct rte_eth_dev *dev)
>         struct rte_eth_rxmode *rxmode =3D &dev->data->dev_conf.rxmode;
>         uint32_t ctrl;
>         uint16_t i;
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>         bool on;
>
>         PMD_INIT_FUNC_TRACE();
> @@ -2200,7 +2200,7 @@ ixgbe_config_vlan_strip_on_all_queues(struct
> rte_eth_dev *dev, int mask)  {
>         uint16_t i;
>         struct rte_eth_rxmode *rxmode;
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>
>         if (mask & RTE_ETH_VLAN_STRIP_MASK) {
>                 rxmode =3D &dev->data->dev_conf.rxmode; @@ -5782,7 +5782,=
7 @@
> ixgbevf_vlan_strip_queue_set(struct rte_eth_dev *dev, uint16_t queue, int=
 on)  static
> int  ixgbevf_vlan_offload_config(struct rte_eth_dev *dev, int mask)  {
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>         uint16_t i;
>         int on =3D 0;
>
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixg=
be/ixgbe_rxtx.c
> index 5b2067bc0e..bbe665a6ff 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> @@ -1403,11 +1403,11 @@ int
>  ixgbe_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pm=
c)  {
>         volatile union ixgbe_adv_rx_desc *rxdp;
> -       struct ixgbe_rx_queue *rxq =3D rx_queue;
> +       struct ci_rx_queue *rxq =3D rx_queue;
>         uint16_t desc;
>
>         desc =3D rxq->rx_tail;
> -       rxdp =3D &rxq->rx_ring[desc];
> +       rxdp =3D &rxq->ixgbe_rx_ring[desc];
>         /* watch for changes in status bit */
>         pmc->addr =3D &rxdp->wb.upper.status_error;
>
> @@ -1547,10 +1547,10 @@ rx_desc_error_to_pkt_flags(uint32_t rx_status,
> uint16_t pkt_info,  #error "PMD IXGBE: LOOK_AHEAD must be 8\n"
>  #endif
>  static inline int
> -ixgbe_rx_scan_hw_ring(struct ixgbe_rx_queue *rxq)
> +ixgbe_rx_scan_hw_ring(struct ci_rx_queue *rxq)
>  {
>         volatile union ixgbe_adv_rx_desc *rxdp;
> -       struct ixgbe_rx_entry *rxep;
> +       struct ci_rx_entry *rxep;
>         struct rte_mbuf *mb;
>         uint16_t pkt_len;
>         uint64_t pkt_flags;
> @@ -1562,7 +1562,7 @@ ixgbe_rx_scan_hw_ring(struct ixgbe_rx_queue *rxq)
>         uint64_t vlan_flags =3D rxq->vlan_flags;
>
>         /* get references to current descriptor and S/W ring entry */
> -       rxdp =3D &rxq->rx_ring[rxq->rx_tail];
> +       rxdp =3D &rxq->ixgbe_rx_ring[rxq->rx_tail];
>         rxep =3D &rxq->sw_ring[rxq->rx_tail];
>
>         status =3D rxdp->wb.upper.status_error; @@ -1647,10 +1647,10 @@
> ixgbe_rx_scan_hw_ring(struct ixgbe_rx_queue *rxq)  }
>
>  static inline int
> -ixgbe_rx_alloc_bufs(struct ixgbe_rx_queue *rxq, bool reset_mbuf)
> +ixgbe_rx_alloc_bufs(struct ci_rx_queue *rxq, bool reset_mbuf)
>  {
>         volatile union ixgbe_adv_rx_desc *rxdp;
> -       struct ixgbe_rx_entry *rxep;
> +       struct ci_rx_entry *rxep;
>         struct rte_mbuf *mb;
>         uint16_t alloc_idx;
>         __le64 dma_addr;
> @@ -1664,7 +1664,7 @@ ixgbe_rx_alloc_bufs(struct ixgbe_rx_queue *rxq, boo=
l
> reset_mbuf)
>         if (unlikely(diag !=3D 0))
>                 return -ENOMEM;
>
> -       rxdp =3D &rxq->rx_ring[alloc_idx];
> +       rxdp =3D &rxq->ixgbe_rx_ring[alloc_idx];
>         for (i =3D 0; i < rxq->rx_free_thresh; ++i) {
>                 /* populate the static rte mbuf fields */
>                 mb =3D rxep[i].mbuf;
> @@ -1691,7 +1691,7 @@ ixgbe_rx_alloc_bufs(struct ixgbe_rx_queue *rxq, boo=
l
> reset_mbuf)  }
>
>  static inline uint16_t
> -ixgbe_rx_fill_from_stage(struct ixgbe_rx_queue *rxq, struct rte_mbuf **r=
x_pkts,
> +ixgbe_rx_fill_from_stage(struct ci_rx_queue *rxq, struct rte_mbuf
> +**rx_pkts,
>                          uint16_t nb_pkts)  {
>         struct rte_mbuf **stage =3D &rxq->rx_stage[rxq->rx_next_avail];
> @@ -1715,7 +1715,7 @@ static inline uint16_t  rx_recv_pkts(void *rx_queue=
,
> struct rte_mbuf **rx_pkts,
>              uint16_t nb_pkts)
>  {
> -       struct ixgbe_rx_queue *rxq =3D (struct ixgbe_rx_queue *)rx_queue;
> +       struct ci_rx_queue *rxq =3D (struct ci_rx_queue *)rx_queue;
>         uint16_t nb_rx =3D 0;
>
>         /* Any previously recv'd pkts will be returned from the Rx stage =
*/ @@ -
> 1804,11 +1804,11 @@ uint16_t  ixgbe_recv_pkts(void *rx_queue, struct rte_=
mbuf
> **rx_pkts,
>                 uint16_t nb_pkts)
>  {
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>         volatile union ixgbe_adv_rx_desc *rx_ring;
>         volatile union ixgbe_adv_rx_desc *rxdp;
> -       struct ixgbe_rx_entry *sw_ring;
> -       struct ixgbe_rx_entry *rxe;
> +       struct ci_rx_entry *sw_ring;
> +       struct ci_rx_entry *rxe;
>         struct rte_mbuf *rxm;
>         struct rte_mbuf *nmb;
>         union ixgbe_adv_rx_desc rxd;
> @@ -1826,7 +1826,7 @@ ixgbe_recv_pkts(void *rx_queue, struct rte_mbuf
> **rx_pkts,
>         nb_hold =3D 0;
>         rxq =3D rx_queue;
>         rx_id =3D rxq->rx_tail;
> -       rx_ring =3D rxq->rx_ring;
> +       rx_ring =3D rxq->ixgbe_rx_ring;
>         sw_ring =3D rxq->sw_ring;
>         vlan_flags =3D rxq->vlan_flags;
>         while (nb_rx < nb_pkts) {
> @@ -2031,7 +2031,7 @@ static inline void  ixgbe_fill_cluster_head_buf(
>         struct rte_mbuf *head,
>         union ixgbe_adv_rx_desc *desc,
> -       struct ixgbe_rx_queue *rxq,
> +       struct ci_rx_queue *rxq,
>         uint32_t staterr)
>  {
>         uint32_t pkt_info;
> @@ -2093,10 +2093,10 @@ static inline uint16_t  ixgbe_recv_pkts_lro(void
> *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts,
>                     bool bulk_alloc)
>  {
> -       struct ixgbe_rx_queue *rxq =3D rx_queue;
> -       volatile union ixgbe_adv_rx_desc *rx_ring =3D rxq->rx_ring;
> -       struct ixgbe_rx_entry *sw_ring =3D rxq->sw_ring;
> -       struct ixgbe_scattered_rx_entry *sw_sc_ring =3D rxq->sw_sc_ring;
> +       struct ci_rx_queue *rxq =3D rx_queue;
> +       volatile union ixgbe_adv_rx_desc *rx_ring =3D rxq->ixgbe_rx_ring;
> +       struct ci_rx_entry *sw_ring =3D rxq->sw_ring;
> +       struct ci_rx_entry_sc *sw_sc_ring =3D rxq->sw_sc_ring;
>         uint16_t rx_id =3D rxq->rx_tail;
>         uint16_t nb_rx =3D 0;
>         uint16_t nb_hold =3D rxq->nb_rx_hold; @@ -2104,10 +2104,10 @@
> ixgbe_recv_pkts_lro(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t n=
b_pkts,
>
>         while (nb_rx < nb_pkts) {
>                 bool eop;
> -               struct ixgbe_rx_entry *rxe;
> -               struct ixgbe_scattered_rx_entry *sc_entry;
> -               struct ixgbe_scattered_rx_entry *next_sc_entry =3D NULL;
> -               struct ixgbe_rx_entry *next_rxe =3D NULL;
> +               struct ci_rx_entry *rxe;
> +               struct ci_rx_entry_sc *sc_entry;
> +               struct ci_rx_entry_sc *next_sc_entry =3D NULL;
> +               struct ci_rx_entry *next_rxe =3D NULL;
>                 struct rte_mbuf *first_seg;
>                 struct rte_mbuf *rxm;
>                 struct rte_mbuf *nmb =3D NULL; @@ -2949,7 +2949,7 @@
> ixgbe_free_sc_cluster(struct rte_mbuf *m)  }
>
>  static void __rte_cold
> -ixgbe_rx_queue_release_mbufs_non_vec(struct ixgbe_rx_queue *rxq)
> +ixgbe_rx_queue_release_mbufs_non_vec(struct ci_rx_queue *rxq)
>  {
>         unsigned i;
>
> @@ -2980,7 +2980,7 @@ ixgbe_rx_queue_release_mbufs_non_vec(struct
> ixgbe_rx_queue *rxq)  }
>
>  static void __rte_cold
> -ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
> +ixgbe_rx_queue_release_mbufs(struct ci_rx_queue *rxq)
>  {
>         if (rxq->vector_rx)
>                 ixgbe_rx_queue_release_mbufs_vec(rxq);
> @@ -2989,7 +2989,7 @@ ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue
> *rxq)  }
>
>  static void __rte_cold
> -ixgbe_rx_queue_release(struct ixgbe_rx_queue *rxq)
> +ixgbe_rx_queue_release(struct ci_rx_queue *rxq)
>  {
>         if (rxq !=3D NULL) {
>                 ixgbe_rx_queue_release_mbufs(rxq);
> @@ -3015,7 +3015,7 @@ ixgbe_dev_rx_queue_release(struct rte_eth_dev *dev,
> uint16_t qid)
>   *           function must be used.
>   */
>  static inline int __rte_cold
> -check_rx_burst_bulk_alloc_preconditions(struct ixgbe_rx_queue *rxq)
> +check_rx_burst_bulk_alloc_preconditions(struct ci_rx_queue *rxq)
>  {
>         int ret =3D 0;
>
> @@ -3052,7 +3052,7 @@ check_rx_burst_bulk_alloc_preconditions(struct
> ixgbe_rx_queue *rxq)
>
>  /* Reset dynamic ixgbe_rx_queue fields back to defaults */  static void =
__rte_cold -
> ixgbe_reset_rx_queue(struct ixgbe_adapter *adapter, struct ixgbe_rx_queue=
 *rxq)
> +ixgbe_reset_rx_queue(struct ixgbe_adapter *adapter, struct ci_rx_queue
> +*rxq)
>  {
>         static const union ixgbe_adv_rx_desc zeroed_desc =3D {{0}};
>         unsigned i;
> @@ -3073,7 +3073,7 @@ ixgbe_reset_rx_queue(struct ixgbe_adapter *adapter,
> struct ixgbe_rx_queue *rxq)
>          * reads extra memory as zeros.
>          */
>         for (i =3D 0; i < len; i++) {
> -               rxq->rx_ring[i] =3D zeroed_desc;
> +               rxq->ixgbe_rx_ring[i] =3D zeroed_desc;
>         }
>
>         /*
> @@ -3185,7 +3185,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
>                          struct rte_mempool *mp)  {
>         const struct rte_memzone *rz;
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>         struct ixgbe_hw     *hw;
>         uint16_t len;
>         struct ixgbe_adapter *adapter =3D dev->data->dev_private; @@ -321=
4,7
> +3214,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
>         }
>
>         /* First allocate the rx queue data structure */
> -       rxq =3D rte_zmalloc_socket("ethdev RX queue", sizeof(struct ixgbe=
_rx_queue),
> +       rxq =3D rte_zmalloc_socket("ethdev RX queue", sizeof(struct
> + ci_rx_queue),
>                                  RTE_CACHE_LINE_SIZE, socket_id);
>         if (rxq =3D=3D NULL)
>                 return -ENOMEM;
> @@ -3284,7 +3284,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
>                         IXGBE_PCI_REG_ADDR(hw, IXGBE_RDT(rxq->reg_idx));
>
>         rxq->rx_ring_phys_addr =3D rz->iova;
> -       rxq->rx_ring =3D (union ixgbe_adv_rx_desc *) rz->addr;
> +       rxq->ixgbe_rx_ring =3D (union ixgbe_adv_rx_desc *)rz->addr;
>
>         /*
>          * Certain constraints must be met in order to use the bulk buffe=
r @@ -3309,7
> +3309,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
>                 len +=3D IXGBE_RX_MAX_BURST;
>
>         rxq->sw_ring =3D rte_zmalloc_socket("rxq->sw_ring",
> -                                         sizeof(struct ixgbe_rx_entry) *=
 len,
> +                                         sizeof(struct ci_rx_entry) *
> + len,
>                                           RTE_CACHE_LINE_SIZE, socket_id)=
;
>         if (!rxq->sw_ring) {
>                 ixgbe_rx_queue_release(rxq); @@ -3326,7 +3326,7 @@
> ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
>          */
>         rxq->sw_sc_ring =3D
>                 rte_zmalloc_socket("rxq->sw_sc_ring",
> -                                  sizeof(struct ixgbe_scattered_rx_entry=
) * len,
> +                                  sizeof(struct ci_rx_entry_sc) * len,
>                                    RTE_CACHE_LINE_SIZE, socket_id);
>         if (!rxq->sw_sc_ring) {
>                 ixgbe_rx_queue_release(rxq); @@ -3335,7 +3335,7 @@
> ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
>
>         PMD_INIT_LOG(DEBUG, "sw_ring=3D%p sw_sc_ring=3D%p hw_ring=3D%p "
>                             "dma_addr=3D0x%"PRIx64,
> -                    rxq->sw_ring, rxq->sw_sc_ring, rxq->rx_ring,
> +                    rxq->sw_ring, rxq->sw_sc_ring, rxq->ixgbe_rx_ring,
>                      rxq->rx_ring_phys_addr);
>
>         if (!rte_is_power_of_2(nb_desc)) { @@ -3359,11 +3359,11 @@
> ixgbe_dev_rx_queue_count(void *rx_queue)  {  #define
> IXGBE_RXQ_SCAN_INTERVAL 4
>         volatile union ixgbe_adv_rx_desc *rxdp;
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>         uint32_t desc =3D 0;
>
>         rxq =3D rx_queue;
> -       rxdp =3D &(rxq->rx_ring[rxq->rx_tail]);
> +       rxdp =3D &rxq->ixgbe_rx_ring[rxq->rx_tail];
>
>         while ((desc < rxq->nb_rx_desc) &&
>                 (rxdp->wb.upper.status_error & @@ -3371,7 +3371,7 @@
> ixgbe_dev_rx_queue_count(void *rx_queue)
>                 desc +=3D IXGBE_RXQ_SCAN_INTERVAL;
>                 rxdp +=3D IXGBE_RXQ_SCAN_INTERVAL;
>                 if (rxq->rx_tail + desc >=3D rxq->nb_rx_desc)
> -                       rxdp =3D &(rxq->rx_ring[rxq->rx_tail +
> +                       rxdp =3D &(rxq->ixgbe_rx_ring[rxq->rx_tail +
>                                 desc - rxq->nb_rx_desc]);
>         }
>
> @@ -3381,7 +3381,7 @@ ixgbe_dev_rx_queue_count(void *rx_queue)  int
> ixgbe_dev_rx_descriptor_status(void *rx_queue, uint16_t offset)  {
> -       struct ixgbe_rx_queue *rxq =3D rx_queue;
> +       struct ci_rx_queue *rxq =3D rx_queue;
>         volatile uint32_t *status;
>         uint32_t nb_hold, desc;
>
> @@ -3399,7 +3399,7 @@ ixgbe_dev_rx_descriptor_status(void *rx_queue,
> uint16_t offset)
>         if (desc >=3D rxq->nb_rx_desc)
>                 desc -=3D rxq->nb_rx_desc;
>
> -       status =3D &rxq->rx_ring[desc].wb.upper.status_error;
> +       status =3D &rxq->ixgbe_rx_ring[desc].wb.upper.status_error;
>         if (*status & rte_cpu_to_le_32(IXGBE_RXDADV_STAT_DD))
>                 return RTE_ETH_RX_DESC_DONE;
>
> @@ -3482,7 +3482,7 @@ ixgbe_dev_clear_queues(struct rte_eth_dev *dev)
>         }
>
>         for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
> -               struct ixgbe_rx_queue *rxq =3D dev->data->rx_queues[i];
> +               struct ci_rx_queue *rxq =3D dev->data->rx_queues[i];
>
>                 if (rxq !=3D NULL) {
>                         ixgbe_rx_queue_release_mbufs(rxq);
> @@ -4644,9 +4644,9 @@ ixgbe_vmdq_tx_hw_configure(struct ixgbe_hw *hw)  }
>
>  static int __rte_cold
> -ixgbe_alloc_rx_queue_mbufs(struct ixgbe_rx_queue *rxq)
> +ixgbe_alloc_rx_queue_mbufs(struct ci_rx_queue *rxq)
>  {
> -       struct ixgbe_rx_entry *rxe =3D rxq->sw_ring;
> +       struct ci_rx_entry *rxe =3D rxq->sw_ring;
>         uint64_t dma_addr;
>         unsigned int i;
>
> @@ -4666,7 +4666,7 @@ ixgbe_alloc_rx_queue_mbufs(struct ixgbe_rx_queue
> *rxq)
>
>                 dma_addr =3D
>                         rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf)=
);
> -               rxd =3D &rxq->rx_ring[i];
> +               rxd =3D &rxq->ixgbe_rx_ring[i];
>                 rxd->read.hdr_addr =3D 0;
>                 rxd->read.pkt_addr =3D dma_addr;
>                 rxe[i].mbuf =3D mbuf;
> @@ -5083,7 +5083,7 @@ ixgbe_set_rx_function(struct rte_eth_dev *dev)
>                 dev->rx_pkt_burst =3D=3D ixgbe_recv_pkts_vec);
>
>         for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
> -               struct ixgbe_rx_queue *rxq =3D dev->data->rx_queues[i];
> +               struct ci_rx_queue *rxq =3D dev->data->rx_queues[i];
>
>                 rxq->vector_rx =3D rx_using_sse;  #ifdef RTE_LIB_SECURITY=
 @@ -
> 5161,7 +5161,7 @@ ixgbe_set_rsc(struct rte_eth_dev *dev)
>
>         /* Per-queue RSC configuration (chapter 4.6.7.2.2 of 82599 Spec) =
*/
>         for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
> -               struct ixgbe_rx_queue *rxq =3D dev->data->rx_queues[i];
> +               struct ci_rx_queue *rxq =3D dev->data->rx_queues[i];
>                 uint32_t srrctl =3D
>                         IXGBE_READ_REG(hw, IXGBE_SRRCTL(rxq->reg_idx));
>                 uint32_t rscctl =3D
> @@ -5237,7 +5237,7 @@ int __rte_cold
>  ixgbe_dev_rx_init(struct rte_eth_dev *dev)  {
>         struct ixgbe_hw     *hw;
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>         uint64_t bus_addr;
>         uint32_t rxctrl;
>         uint32_t fctrl;
> @@ -5533,7 +5533,7 @@ ixgbe_dev_rxtx_start(struct rte_eth_dev *dev)  {
>         struct ixgbe_hw     *hw;
>         struct ci_tx_queue *txq;
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>         uint32_t txdctl;
>         uint32_t dmatxctl;
>         uint32_t rxctrl;
> @@ -5620,7 +5620,7 @@ int __rte_cold
>  ixgbe_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id) =
 {
>         struct ixgbe_hw     *hw;
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>         uint32_t rxdctl;
>         int poll_ms;
>
> @@ -5663,7 +5663,7 @@ ixgbe_dev_rx_queue_stop(struct rte_eth_dev *dev,
> uint16_t rx_queue_id)  {
>         struct ixgbe_hw     *hw;
>         struct ixgbe_adapter *adapter =3D dev->data->dev_private;
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>         uint32_t rxdctl;
>         int poll_ms;
>
> @@ -5797,7 +5797,7 @@ void
>  ixgbe_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
>         struct rte_eth_rxq_info *qinfo)
>  {
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>
>         rxq =3D dev->data->rx_queues[queue_id];
>
> @@ -5835,7 +5835,7 @@ void
>  ixgbe_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
>         struct rte_eth_recycle_rxq_info *recycle_rxq_info)  {
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>         struct ixgbe_adapter *adapter =3D dev->data->dev_private;
>
>         rxq =3D dev->data->rx_queues[queue_id]; @@ -5861,7 +5861,7 @@ int
> __rte_cold  ixgbevf_dev_rx_init(struct rte_eth_dev *dev)  {
>         struct ixgbe_hw     *hw;
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>         struct rte_eth_rxmode *rxmode =3D &dev->data->dev_conf.rxmode;
>         uint32_t frame_size =3D dev->data->mtu + IXGBE_ETH_OVERHEAD;
>         uint64_t bus_addr;
> @@ -6048,7 +6048,7 @@ ixgbevf_dev_rxtx_start(struct rte_eth_dev *dev)  {
>         struct ixgbe_hw     *hw;
>         struct ci_tx_queue *txq;
> -       struct ixgbe_rx_queue *rxq;
> +       struct ci_rx_queue *rxq;
>         uint32_t txdctl;
>         uint32_t rxdctl;
>         uint16_t i;
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixg=
be/ixgbe_rxtx.h
> index 9047ee4763..aad7ee81ee 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> @@ -7,6 +7,7 @@
>
>  #include "ixgbe_type.h"
>
> +#include "../common/rx.h"
>  #include "../common/tx.h"
>
>  /*
> @@ -32,7 +33,7 @@
>  #define        IXGBE_MAX_RING_DESC     8192
>
>  #define IXGBE_TX_MAX_BURST            32
> -#define IXGBE_RX_MAX_BURST            32
> +#define IXGBE_RX_MAX_BURST            CI_RX_MAX_BURST
>  #define IXGBE_TX_MAX_FREE_BUF_SZ      64
>
>  #define IXGBE_VPMD_DESCS_PER_LOOP     4
> @@ -66,64 +67,6 @@
>  #define IXGBE_PACKET_TYPE_TN_MAX            0X100
>  #define IXGBE_PACKET_TYPE_SHIFT             0X04
>
> -/**
> - * Structure associated with each descriptor of the RX ring of a RX queu=
e.
> - */
> -struct ixgbe_rx_entry {
> -       struct rte_mbuf *mbuf; /**< mbuf associated with RX descriptor. *=
/
> -};
> -
> -struct ixgbe_scattered_rx_entry {
> -       struct rte_mbuf *fbuf; /**< First segment of the fragmented packe=
t. */
> -};
> -
> -/**
> - * Structure associated with each RX queue.
> - */
> -struct ixgbe_rx_queue {
> -       struct rte_mempool  *mp; /**< mbuf pool to populate RX ring. */
> -       volatile union ixgbe_adv_rx_desc *rx_ring; /**< RX ring virtual a=
ddress. */
> -       uint64_t            rx_ring_phys_addr; /**< RX ring DMA address. =
*/
> -       volatile uint32_t   *qrx_tail; /**< RDT register address. */
> -       struct ixgbe_rx_entry *sw_ring; /**< address of RX software ring.=
 */
> -       struct ixgbe_scattered_rx_entry *sw_sc_ring; /**< address of scat=
tered Rx
> software ring. */
> -       struct rte_mbuf *pkt_first_seg; /**< First segment of current pac=
ket. */
> -       struct rte_mbuf *pkt_last_seg; /**< Last segment of current packe=
t. */
> -       uint64_t            mbuf_initializer; /**< value to init mbufs */
> -       uint16_t            nb_rx_desc; /**< number of RX descriptors. */
> -       uint16_t            rx_tail;  /**< current value of RDT register.=
 */
> -       uint16_t            nb_rx_hold; /**< number of held free RX desc.=
 */
> -       uint16_t rx_nb_avail; /**< nr of staged pkts ready to ret to app =
*/
> -       uint16_t rx_next_avail; /**< idx of next staged pkt to ret to app=
 */
> -       uint16_t rx_free_trigger; /**< triggers rx buffer allocation */
> -       uint8_t            vector_rx;
> -       /**< indicates that vector RX is in use */
> -#ifdef RTE_LIB_SECURITY
> -       uint8_t            using_ipsec;
> -       /**< indicates that IPsec RX feature is in use */
> -#endif
> -       uint16_t            rxrearm_nb;     /**< number of remaining to b=
e re-armed */
> -       uint16_t            rxrearm_start;  /**< the idx we start the re-=
arming from */
> -       uint16_t            rx_free_thresh; /**< max free RX desc to hold=
. */
> -       uint16_t            queue_id; /**< RX queue index. */
> -       uint16_t            reg_idx;  /**< RX queue register index. */
> -       uint16_t            pkt_type_mask;  /**< Packet type mask for dif=
ferent NICs. */
> -       uint16_t            port_id;  /**< Device port identifier. */
> -       uint8_t             crc_len;  /**< 0 if CRC stripped, 4 otherwise=
. */
> -       uint8_t             drop_en;  /**< If not 0, set SRRCTL.Drop_En. =
*/
> -       uint8_t             rx_deferred_start; /**< not in global dev sta=
rt. */
> -       /** UDP frames with a 0 checksum can be marked as checksum errors=
. */
> -       uint8_t             rx_udp_csum_zero_err;
> -       /** flags to set in mbuf when a vlan is detected. */
> -       uint64_t            vlan_flags;
> -       uint64_t            offloads; /**< Rx offloads with RTE_ETH_RX_OF=
FLOAD_* */
> -       /** need to alloc dummy mbuf, for wraparound when scanning hw rin=
g */
> -       struct rte_mbuf fake_mbuf;
> -       /** hold packets to return to application */
> -       struct rte_mbuf *rx_stage[IXGBE_RX_MAX_BURST * 2];
> -       const struct rte_memzone *mz;
> -};
> -
>  /**
>   * IXGBE CTX Constants
>   */
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
> b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
> index 707dc7f5f9..5f231b9012 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
> @@ -61,7 +61,7 @@ ixgbe_reset_tx_queue_vec(struct ci_tx_queue *txq)  }
>
>  void __rte_cold
> -ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq)
> +ixgbe_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
>  {
>         unsigned int i;
>
> @@ -90,7 +90,7 @@ ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue
> *rxq)  }
>
>  int __rte_cold
> -ixgbe_rxq_vec_setup(struct ixgbe_rx_queue *rxq)
> +ixgbe_rxq_vec_setup(struct ci_rx_queue *rxq)
>  {
>         rxq->mbuf_initializer =3D ci_rxq_mbuf_initializer(rxq->port_id);
>         return 0;
> @@ -126,7 +126,7 @@ ixgbe_rx_vec_dev_conf_condition_check(struct
> rte_eth_dev *dev)
>                 return -1;
>
>         for (uint16_t i =3D 0; i < dev->data->nb_rx_queues; i++) {
> -               struct ixgbe_rx_queue *rxq =3D dev->data->rx_queues[i];
> +               struct ci_rx_queue *rxq =3D dev->data->rx_queues[i];
>                 if (!rxq)
>                         continue;
>                 if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thr=
esh, rxq-
> >offloads)) @@ -173,15 +173,15 @@ ixgbe_xmit_pkts_vec(void *tx_queue, str=
uct
> rte_mbuf **tx_pkts,  void  ixgbe_recycle_rx_descriptors_refill_vec(void *=
rx_queue,
> uint16_t nb_mbufs)  {
> -       struct ixgbe_rx_queue *rxq =3D rx_queue;
> -       struct ixgbe_rx_entry *rxep;
> +       struct ci_rx_queue *rxq =3D rx_queue;
> +       struct ci_rx_entry *rxep;
>         volatile union ixgbe_adv_rx_desc *rxdp;
>         uint16_t rx_id;
>         uint64_t paddr;
>         uint64_t dma_addr;
>         uint16_t i;
>
> -       rxdp =3D rxq->rx_ring + rxq->rxrearm_start;
> +       rxdp =3D rxq->ixgbe_rx_ring + rxq->rxrearm_start;
>         rxep =3D &rxq->sw_ring[rxq->rxrearm_start];
>
>         for (i =3D 0; i < nb_mbufs; i++) { diff --git
> a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
> b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
> index e05696f584..e54f532497 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
> @@ -12,9 +12,9 @@
>  #include "ixgbe_rxtx.h"
>
>  int ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev); -int
> ixgbe_rxq_vec_setup(struct ixgbe_rx_queue *rxq);
> +int ixgbe_rxq_vec_setup(struct ci_rx_queue *rxq);
>  int ixgbe_txq_vec_setup(struct ci_tx_queue *txq); -void
> ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq);
> +void ixgbe_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq);
>  void ixgbe_reset_tx_queue_vec(struct ci_tx_queue *txq);  void
> ixgbe_tx_free_swring_vec(struct ci_tx_queue *txq);  uint16_t
> ixgbe_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t n=
b_pkts);
> @@ -79,5 +79,4 @@ ixgbe_tx_free_bufs_vec(struct ci_tx_queue *txq)
>
>         return txq->tx_rs_thresh;
>  }
> -
>  #endif
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
> b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
> index 2d42b7b1c1..ce492f2ff1 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
> @@ -12,19 +12,19 @@
>  #include "ixgbe_rxtx_vec_common.h"
>
>  static inline void
> -ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
> +ixgbe_rxq_rearm(struct ci_rx_queue *rxq)
>  {
>         int i;
>         uint16_t rx_id;
>         volatile union ixgbe_adv_rx_desc *rxdp;
> -       struct ixgbe_rx_entry *rxep =3D &rxq->sw_ring[rxq->rxrearm_start]=
;
> +       struct ci_rx_entry *rxep =3D &rxq->sw_ring[rxq->rxrearm_start];
>         struct rte_mbuf *mb0, *mb1;
>         uint64x2_t dma_addr0, dma_addr1;
>         uint64x2_t zero =3D vdupq_n_u64(0);
>         uint64_t paddr;
>         uint8x8_t p;
>
> -       rxdp =3D rxq->rx_ring + rxq->rxrearm_start;
> +       rxdp =3D rxq->ixgbe_rx_ring + rxq->rxrearm_start;
>
>         /* Pull 'n' more MBUFs into the software ring */
>         if (unlikely(rte_mempool_get_bulk(rxq->mp,
> @@ -282,11 +282,11 @@ desc_to_ptype_v(uint64x2_t descs[4], uint16_t
> pkt_type_mask,
>   * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
>   */
>  static inline uint16_t
> -_recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts=
,
> +_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
>                    uint16_t nb_pkts, uint8_t *split_packet)  {
>         volatile union ixgbe_adv_rx_desc *rxdp;
> -       struct ixgbe_rx_entry *sw_ring;
> +       struct ci_rx_entry *sw_ring;
>         uint16_t nb_pkts_recd;
>         int pos;
>         uint8x16_t shuf_msk =3D {
> @@ -309,7 +309,7 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct
> rte_mbuf **rx_pkts,
>         /* Just the act of getting into the function from the application=
 is
>          * going to cost about 7 cycles
>          */
> -       rxdp =3D rxq->rx_ring + rxq->rx_tail;
> +       rxdp =3D rxq->ixgbe_rx_ring + rxq->rx_tail;
>
>         rte_prefetch_non_temporal(rxdp);
>
> @@ -488,7 +488,7 @@ static uint16_t
>  ixgbe_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts=
,
>                                uint16_t nb_pkts)  {
> -       struct ixgbe_rx_queue *rxq =3D rx_queue;
> +       struct ci_rx_queue *rxq =3D rx_queue;
>         uint8_t split_flags[IXGBE_VPMD_RX_BURST] =3D {0};
>
>         /* get some new buffers */
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
> b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
> index f5bb7eb0bd..f977489b95 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
> @@ -13,12 +13,12 @@
>  #include <rte_vect.h>
>
>  static inline void
> -ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
> +ixgbe_rxq_rearm(struct ci_rx_queue *rxq)
>  {
>         int i;
>         uint16_t rx_id;
>         volatile union ixgbe_adv_rx_desc *rxdp;
> -       struct ixgbe_rx_entry *rxep =3D &rxq->sw_ring[rxq->rxrearm_start]=
;
> +       struct ci_rx_entry *rxep =3D &rxq->sw_ring[rxq->rxrearm_start];
>         struct rte_mbuf *mb0, *mb1;
>         __m128i hdr_room =3D _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
>                         RTE_PKTMBUF_HEADROOM); @@ -26,7 +26,7 @@
> ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
>
>         const __m128i hba_msk =3D _mm_set_epi64x(0, UINT64_MAX);
>
> -       rxdp =3D rxq->rx_ring + rxq->rxrearm_start;
> +       rxdp =3D rxq->ixgbe_rx_ring + rxq->rxrearm_start;
>
>         /* Pull 'n' more MBUFs into the software ring */
>         if (rte_mempool_get_bulk(rxq->mp, @@ -327,11 +327,11 @@
> desc_to_ptype_v(__m128i descs[4], uint16_t pkt_type_mask,
>   * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
>   */
>  static inline uint16_t
> -_recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts=
,
> +_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
>                 uint16_t nb_pkts, uint8_t *split_packet)  {
>         volatile union ixgbe_adv_rx_desc *rxdp;
> -       struct ixgbe_rx_entry *sw_ring;
> +       struct ci_rx_entry *sw_ring;
>         uint16_t nb_pkts_recd;
>  #ifdef RTE_LIB_SECURITY
>         uint8_t use_ipsec =3D rxq->using_ipsec; @@ -377,7 +377,7 @@
> _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
>         /* Just the act of getting into the function from the application=
 is
>          * going to cost about 7 cycles
>          */
> -       rxdp =3D rxq->rx_ring + rxq->rx_tail;
> +       rxdp =3D rxq->ixgbe_rx_ring + rxq->rx_tail;
>
>         rte_prefetch0(rxdp);
>
> @@ -609,7 +609,7 @@ static uint16_t
>  ixgbe_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts=
,
>                                uint16_t nb_pkts)  {
> -       struct ixgbe_rx_queue *rxq =3D rx_queue;
> +       struct ci_rx_queue *rxq =3D rx_queue;
>         uint8_t split_flags[IXGBE_VPMD_RX_BURST] =3D {0};
>
>         /* get some new buffers */
> --
> 2.47.1

Please note, we are using the following steps to validate the patch

```
1. git clone https://dpdk.org/git/dpdk
2. git chekout
3. git apply <patch>
```
Can you please suggest if we are missing something? We would like to test t=
he patch on E810

