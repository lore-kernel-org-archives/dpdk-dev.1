Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA140C55174
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 00:29:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B306E402AC;
	Thu,  6 Aug 2026 02:29:47 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11020107.outbound.protection.outlook.com [52.101.46.107])
 by mails.dpdk.org (Postfix) with ESMTP id 1F9EA4027E;
 Thu,  6 Aug 2026 02:29:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAp2GT/bsY4AJPS51VJaOXIkIhQML8JTb6lvIyX+rrOzkwiKU2XrWfj5X3XJPg8DvGkT18O+auj+YlAHI70g8EFIldZOt09XaV4rGxVF8JRKBaYj2w7SmXY7C+X8qHkS7C98Iswy+4H18SlGx9SxWSEKuRNuzXwLQEoN8dDoL1mf+EslFvlP5P5yLxWq8jdPkk1PZdKhrJZy/azWVPc4Zvy7gQ8dhv+ENN9WhsdfScJFRhup+zixB//GqIX4y+nlbw8fHK12jY0BabsM8JWD8aOQhtp5wOxdUCWMFKqop5JB9LoRmDxFJQHZO8W8ff/ud4SEYZcobMqNI3gc/fYamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/XhoOFIv0e9EuEXkvrRT+WmInnPhKGZ67huJYmgsw4=;
 b=O8M5I9GudKC5pWttlPBZl7TFW2jksWLwVjl/3LTns6448DDMUbMsplSMlYkk4u52NRXjjx91acw7M2vcDl+W4RSsXqqjZUJC0upzhvZPn97BEIpoLuPXPJe6W4vQjmG9Ig5dI5LR6/PzgWcAQnzvf1h8b1DKo5AFRUDNIn1aI52I6xn/CKKECXQVmNHZYhVfu8LyMAVLQ17ckM9RxGMd8EjbXh3UUtF0a+kX3rgQRJaQEROtOdTjMeTE1yRhubzSnMKEYyQ4GAO1qSY3pJLsWN8aUrNxjw5jUFTsm2t9XIYA4Xnjtlx7uPPGmSEJ+UaqMeBTy4Ib7EHqtwoINnzX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/XhoOFIv0e9EuEXkvrRT+WmInnPhKGZ67huJYmgsw4=;
 b=X8lHZclRLTU8M0bijYP+nv54qw50WLQ8u+kCctHyW+CbPwDss8nLbcQBuH+S8f9+mT6DfyfN0IchUHpUHC6KqYHLKL/gCciEa/fE6UeAm3xfNoa8/HTzDsx3qRtTf4HVCUzA2ee1pqddEUXL8r2aiVOFL+jk3DnY0W+JCo2kU4k=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5894.namprd21.prod.outlook.com (2603:10b6:806:496::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.4; Thu, 6 Aug 2026
 00:29:41 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.005; Thu, 6 Aug 2026
 00:29:41 +0000
From: Long Li <longli@microsoft.com>
To: Rita Ruvinsky <rita.ruvinsky@weka.io>, "dev@dpdk.org" <dev@dpdk.org>
CC: Wei Hu <weh@microsoft.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH 1/2] net/mana: fix MR length truncation for
 chunks over 4GB
Thread-Topic: [EXTERNAL] [PATCH 1/2] net/mana: fix MR length truncation for
 chunks over 4GB
Thread-Index: AQHdJPFJPtH3Ml/Lg0yY4SIOzffcwLaQK1iQ
Date: Thu, 6 Aug 2026 00:29:41 +0000
Message-ID: <SA1PR21MB6683D2879C7D5061930AEBF8CED22@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260805154407.1965063-1-rita.ruvinsky@weka.io>
In-Reply-To: <20260805154407.1965063-1-rita.ruvinsky@weka.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=66c6f604-3b3e-45c1-86f0-f9654a67d007;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-06T00:29:17Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5894:EE_
x-ms-office365-filtering-correlation-id: 18e854b7-8c22-48e5-ff45-08def351ce3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|10067099003|7146999003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: /f7vNFuov3sDK+CaP/0ml90/IYpvHusaQwYJg59PMni406Ul4HhR4btF6myh/s2xYUxlR7/1geQ+m49h+3T+lHVmMzNlJsZSx1yIVimvlg/3O3U+ZyLQzq6NdFI4joHdbUNaS0EB4UpYW3Sa8bDlOBAn4P4p4j44TuONEK7/pJYNdr67ySbxLrHvFlQHpXM7o1eWIchoOvBkTELJnFEd5kO5a2Gc+078SDfNqugnnD/OO0625zb5l7i9eY/Kin+NHCm0ox1d3dNcQNyDA15LwFJoa/vj8LzBSX82giGxhPOplNJAiKWTmaZwut7N0hFAfW/keNW1s6VzkgGDkN5nZoEOr+YETL0DUJRxWdnuy8aQboHo3Q9EC/Zde/cB0JodjdB5A8JKYyanHhimNlxECq3/7oIw/nnt59JLcPbPotZYvKcJ22rWxwEpxZavPzONvNEFPXN7QFjBjJLnYuxqzrIFjMmzFnb8UvhJ/yV8e5kNKdBCjSZEc82FacoyOdd6HlGO/VvCZlLLyDoqVw9XhTGVAagYbMgOmcb1rpaq9ILXkbDQgcxbQJJARaNMWGCLJldcP5X8/gKlYEUHYexV14yzFs3BBFBBpgy/KIy5XkezycXIQ4r7pQGyy/teSdSzoaz8L8b6oYfNk2zeHH1GuDflUu9Jzz4M48kyr/9F3V9+PrA4j9zQPzI7vt8t2R0pdFBwPo9j0ZUbZF1fpiO999aS1pHGaPwoIWDge1U1owM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(7146999003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?utYmrR0JezjHOQsv0PhCh6ln2XOdzKHaX+8h//J2ySBGMAuwL2Q2NIgMzmU1?=
 =?us-ascii?Q?GmKWRMjg3lpnS+mWxV0Rnrt0wVZTSTlOp3LA8D/T1/I6ayVGuMnFTH69F2bK?=
 =?us-ascii?Q?AQqQF6uA7rHApt/BxRuyw+Wj3ce2PVwxu4h9dd7bISEnKswATHaW3vm+xB1C?=
 =?us-ascii?Q?lsI4kpVifFWkQQZ7XcmZPvEA7YbYBIlIjSCjDCRYxzImY5Gcbz2P+RN8/MCI?=
 =?us-ascii?Q?b/P4SQnjPKA2ONuQX1f4nQ+uMqy6/o9jJf2nKhC5tJjq4ib2hBf0SKGcZfD7?=
 =?us-ascii?Q?S4cTjfwh2h82iXxwu+ruLlnfRVnV2X/KK0Nq11WZ4dKjHO4E6bJ+pq0y9OWo?=
 =?us-ascii?Q?tP7D1iqjLnJuyDqMTGnxYpz1i1N0zLvkCW1fiys9Bo1XpYbOi1JyfVm15Nik?=
 =?us-ascii?Q?kCQGjQMYq8brP0hyY4kUhE8RiXkTlp2QFQDR3LY8hooiYc5fdzlTaFg5DTRA?=
 =?us-ascii?Q?gwT18f3dM4lJ54fMvh7w1xZFICotCvXAU1h4a8oMZG/0AWa0r3Cixdp0I/4f?=
 =?us-ascii?Q?fV3luW+tYpP7dJlQgSl8ONh47+PiA6SX3+5iRSCxZhR2YhQKajhMIEC8Bnfa?=
 =?us-ascii?Q?U7DRQsXauwdsBPkmVzDhi6OUaZHzVGgCZ7p1xhNpz9VFQn9Lpw2r1mwAGdjt?=
 =?us-ascii?Q?d92IIk8ZH+VdQfF3KcaMlzPZeOqwTRac6l69OdkVXj/0sYyEpp87uo3VBHX4?=
 =?us-ascii?Q?2uMujOvhBj1dBAtF69L4rVcjpxJkM6n+nq06oS35o/z/gTsAXj3qyCjenClm?=
 =?us-ascii?Q?wwbBA2ZU/eejM/mzpCQCiLhXgpFMZb5xhXmC5zbEcuf96hU5tWRou0bUY0GJ?=
 =?us-ascii?Q?MOxtdEbVPkhI53Qc9F1Qx08C7v+z+2VF3qh6X0S6IOcYU8cDd/5OISEdPB8h?=
 =?us-ascii?Q?zpe8lCD7DIoKxhsXj3wWsFoozaE8fZ01zKw1vH7gq3WQrLq6AZjKldREvxFe?=
 =?us-ascii?Q?wrtF3EvIxdtAHZJHvYnTiyTiFg9oNdeX6MadjBFKOkayq7nzirtfs1m/pNAd?=
 =?us-ascii?Q?ybQ/KhsTZKBl1q3Wy7AJW+2MPJeV10jmbAelDWuXiqg5QiujTPQYrPpvXK9p?=
 =?us-ascii?Q?iBCZI+CizrVXXTRK8CAlgBv+yPt4kxsuOIYSYl1PKrN2lZY56NDoaqyzmxGT?=
 =?us-ascii?Q?uYa/WF78VNpVLXVsJrVJzt7wSGPihy1fpcos5g3wksJieiC+1r3ARcCU7/e1?=
 =?us-ascii?Q?52xj9ZmB3NayjIp2IVWuzZJxs1+F/IKgwctBxLdwYp1tqbPUS1+PEEOepMSf?=
 =?us-ascii?Q?DU3f/yEqfcl7YtwD/37+mUlwhcRKrTU8JV3YVD16O9jOeNXN0HSaUPV2+/3i?=
 =?us-ascii?Q?44sdMwNUDM0d8gL2QuC1qEyvqreV7pE9mbgrNNb2hXqEDiU4xPi4R34goc2J?=
 =?us-ascii?Q?N5EHMjiMVw48LLeznS+ilA8UVeOhfaU0jd1O0xJLCookNOrg7s3hNnY1IKfV?=
 =?us-ascii?Q?HtAenMwrdOGJwvzLb0rAqgPOR60cQNLqyaGHeqU3nkYi7dmmKTxacTS/RcXk?=
 =?us-ascii?Q?dgctHT71OlSwB1F2CJvkdmCvU9Xn91EtnbOH7QqxNMRx0H1coSuOHH3K34Tl?=
 =?us-ascii?Q?rIcDo6p3jGYY+GiVytVNEOW7PrORbGJIxrh5a0nqE3g/WehzSS8QqrhnZ/0C?=
 =?us-ascii?Q?7AKoOxHhC6dZDSwSent4MfpcJmPcHDeEJEKxpGbTWYKZcaIs5ALPa8uJ5c90?=
 =?us-ascii?Q?UOYt4sLDiQYPpd62FfRD/z6M79Ywvna6n9QKbdDDIdemve+a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e854b7-8c22-48e5-ff45-08def351ce3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 00:29:41.0827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9GnwiWABLu3wKjbXT2mksvVpjSSkcJUUIqRJ+1YRIowIGS2OGpGrwUbQ8tZmnREhB8FBhudw1ytO3n8nqyHpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5894
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

> mana_range.len is a uint32_t, so a mempool chunk of 4GB or more truncates
> modulo 2^32 -- exactly 4GB becomes 0, 15GB becomes 3GB.
>=20
> The guard against priv->max_mr_size cannot catch this because it compares
> the already-truncated value, and the device advertises max_mr_size as
> UINT64_MAX. ibv_reg_mr() then fails with EINVAL on a zero length, or sile=
ntly
> registers a region far shorter than the pool, so lookups for buffers past=
 that
> boundary never find an MR and no Rx WQE can be posted.
>=20
> Widen the length to uint64_t through the MR path, including the multi-pro=
cess
> request that forwards it to the primary process.
>=20
> Fixes: 0f5db3c68ba7 ("net/mana: implement memory registration")
> Cc: stable@dpdk.org
> Signed-off-by: Rita Ruvinsky <rita.ruvinsky@weka.io>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/net/mana/mana.h |  4 ++--
>  drivers/net/mana/mp.c   |  4 ++--
>  drivers/net/mana/mr.c   | 11 ++++++-----
>  3 files changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/mana/mana.h b/drivers/net/mana/mana.h index
> 7d94840dc4..552865ff9d 100644
> --- a/drivers/net/mana/mana.h
> +++ b/drivers/net/mana/mana.h
> @@ -553,7 +553,7 @@ struct mana_mp_param {
>=20
>         /* MANA_MP_REQ_CREATE_MR */
>         uintptr_t addr;
> -       uint32_t len;
> +       uint64_t len;
>  };
>=20
>  #define MANA_MP_NAME   "net_mana_mp"
> @@ -562,7 +562,7 @@ int mana_mp_init_secondary(void);  void
> mana_mp_uninit_primary(void);  void mana_mp_uninit_secondary(void);  int
> mana_mp_req_verbs_cmd_fd(struct rte_eth_dev *dev); -int
> mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr, uint32_t le=
n);
> +int mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr,
> +uint64_t len);
>=20
>  void mana_mp_req_on_rxtx(struct rte_eth_dev *dev, enum
> mana_mp_req_type type);
>=20
> diff --git a/drivers/net/mana/mp.c b/drivers/net/mana/mp.c index
> 5467d385ce..5cc29de3a1 100644
> --- a/drivers/net/mana/mp.c
> +++ b/drivers/net/mana/mp.c
> @@ -17,7 +17,7 @@ extern struct mana_shared_data *mana_shared_data;
>   * Process MR request from secondary process.
>   */
>  static int
> -mana_mp_mr_create(struct mana_priv *priv, uintptr_t addr, uint32_t len)
> +mana_mp_mr_create(struct mana_priv *priv, uintptr_t addr, uint64_t len)
>  {
>         struct ibv_mr *ibv_mr;
>         int ret;
> @@ -257,7 +257,7 @@ mana_mp_req_verbs_cmd_fd(struct rte_eth_dev *dev)
>   * Request the primary process to register a MR.
>   */
>  int
> -mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr, uint32_t l=
en)
> +mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr, uint64_t
> +len)
>  {
>         struct rte_mp_msg mp_req =3D {0};
>         struct rte_mp_msg *mp_res;
> diff --git a/drivers/net/mana/mr.c b/drivers/net/mana/mr.c index
> c4045141bc..7405755df8 100644
> --- a/drivers/net/mana/mr.c
> +++ b/drivers/net/mana/mr.c
> @@ -13,7 +13,8 @@
>  struct mana_range {
>         uintptr_t       start;
>         uintptr_t       end;
> -       uint32_t        len;
> +       /* 64-bit: a mempool chunk can be 4GB or more, which overflows
> uint32_t. */
> +       uint64_t        len;
>  };
>=20
>  void
> @@ -47,13 +48,13 @@ mana_new_pmd_mr(struct mana_mr_btree
> *local_tree, struct mana_priv *priv,
>=20
>         for (i =3D 0; i < pool->nb_mem_chunks; i++) {
>                 if (ranges[i].len > priv->max_mr_size) {
> -                       DP_LOG(ERR, "memory chunk size %u exceeding max M=
R",
> +                       DP_LOG(ERR, "memory chunk size %" PRIu64 "
> + exceeding max MR",
>                                ranges[i].len);
>                         return -ENOMEM;
>                 }
>=20
>                 DP_LOG(DEBUG,
> -                      "registering memory chunk start 0x%" PRIxPTR " len=
 %u",
> +                      "registering memory chunk start 0x%" PRIxPTR "
> + len %" PRIu64,
>                        ranges[i].start, ranges[i].len);
>=20
>                 if (rte_eal_process_type() =3D=3D RTE_PROC_SECONDARY) { @=
@ -62,7
> +63,7 @@ mana_new_pmd_mr(struct mana_mr_btree *local_tree, struct
> mana_priv *priv,
>                                                     ranges[i].len);
>                         if (ret) {
>                                 DP_LOG(ERR,
> -                                      "MR failed start 0x%" PRIxPTR " le=
n %u",
> +                                      "MR failed start 0x%" PRIxPTR "
> + len %" PRIu64,
>                                        ranges[i].start, ranges[i].len);
>                                 return ret;
>                         }
> @@ -98,7 +99,7 @@ mana_new_pmd_mr(struct mana_mr_btree *local_tree,
> struct mana_priv *priv,
>                                 return ret;
>                         }
>                 } else {
> -                       DP_LOG(ERR, "MR failed at 0x%" PRIxPTR " len %u",
> +                       DP_LOG(ERR, "MR failed at 0x%" PRIxPTR " len %"
> + PRIu64,
>                                ranges[i].start, ranges[i].len);
>                         return -errno;
>                 }
> --
> 2.43.0

