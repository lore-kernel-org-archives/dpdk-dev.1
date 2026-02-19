Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A142C531D1
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 21:22:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5029F402C6;
	Thu, 19 Feb 2026 22:22:37 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11022111.outbound.protection.outlook.com [40.107.209.111])
 by mails.dpdk.org (Postfix) with ESMTP id EB072402AC;
 Thu, 19 Feb 2026 22:22:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIy50g1rC5d1Q3PUzBiKjTTStqTB2E5gcm3N4RDXEWWOiXxtpphE7irBJAzv6whHKOuddWFVXwzn6SH08UTPdBNrHxjpYI13JwD2PeIBFKeFTiox40p8l/vswtA8NOkO9J+pTaB2R/u4c2QwW9IPWdNlaAMeYrCwMIx9WD4xtT9LF7mQ8f96l2A5whAhEtGbLmN/jUkYy04Uvh3seXaZokhvyy9/4pa8CxVWoOAMIsEHWKfVz4TLGhjVIWL70AlkT+XXY8SkMVyI2OfIwisVrjW+yYcWnjQFaiewWD/9oErJtU/kexYUaT3qLFLAx45nxwWgq9tyn/+0TkH446mk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnpvQKicoDbKKO4jWT0aqIfADzs++Dj/0TXsEXNGUk0=;
 b=Y2d3t8uaWRqvh6ItOPMLaiPyACCnyemLhgJlkH+lTJixHFn139Xd/j1yhsS/okmhWsbQgmMIzQZuirYuBVq2LXeYY5yF8UAMsJQY2QRKhPHmD9WKJIob2UZM0nK7TbQZ2yFhTrTWfAe7tHwP1I8NOloiDz9uz0jeWLIBUUd3kgHvxnxNymvphXPWOwhFn1HTg2QQPi4h0rQiC09IUr+veTqRX6E2lYIjjg/HRfSFBSIDMb4pBXNdvuUQzo0wwJpZHy8pZMDRYrBsw99o1w/qr4ud4bHKPMKivTy9E+Xi5FYwX7qhh7r1BT5hIunAKb0T1vKFqEh+rP57uyUSUGYcaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnpvQKicoDbKKO4jWT0aqIfADzs++Dj/0TXsEXNGUk0=;
 b=MsUDy3JHcNTZuJLSKgDnVK6lnx4o+xwo8NVYXS4l8lUIQggXXk/88hsh7oafjmtoPyHTTdvhi3BCPz96QIziRVoFDEYmMmqgwsiIol6W03VdRUpVbdKsXETCMSh8wzBnPdL0fdFd5Wrw2u9WIDlKmThLKNfzmhSBRJzWFQMHHvI=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DM4PR21MB3056.namprd21.prod.outlook.com (2603:10b6:8:5c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.15; Thu, 19 Feb 2026 21:22:32 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%4]) with mapi id 15.20.9654.000; Thu, 19 Feb 2026
 21:22:32 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Wei Hu <weh@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>
Subject: RE: [EXTERNAL] [RFT] net/netvsc: fix txd leak on chimney buffer alloc
 failure
Thread-Topic: [EXTERNAL] [RFT] net/netvsc: fix txd leak on chimney buffer
 alloc failure
Thread-Index: AQHcoUFYdAzkSJWCwEuotozQoFVJMrWKiQNw
Date: Thu, 19 Feb 2026 21:22:32 +0000
Message-ID: <DS3PR21MB573518CAA38381AB5FCC2117CE6BA@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260219014444.175203-1-stephen@networkplumber.org>
In-Reply-To: <20260219014444.175203-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=52c926ba-bb47-4940-ba43-8cd13c755ed5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-19T21:21:50Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DM4PR21MB3056:EE_
x-ms-office365-filtering-correlation-id: 9bf434da-0f8f-4fef-e36d-08de6ffcfea2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?v95ocCkQOf9w8rOSWwP2160nHEWDCYQMtq6sDilu/HL/OHkHEcYoC4tA2b2A?=
 =?us-ascii?Q?q+KR+rX2gX8R6E4fiwsQGNe+E8U64u9aTjF8C9CbS7JqXNFrIKgb3AwEitAS?=
 =?us-ascii?Q?y0XJFExqLwLekJ90Ravel3nJvo9ceG6COa4HY3F+VN3PFA6E62LlLA/6oDEa?=
 =?us-ascii?Q?ks56KbggHzct47zjO2n5mQEzvR5WXiFrbB97TSyhhiqqg/SLxZKap6FVmgm3?=
 =?us-ascii?Q?Ff/HrvG7ssu2Pbqir6GIYjoeNYhIniYNa0FGdAmYFKL79OYSU3MGQ0q/GQ2x?=
 =?us-ascii?Q?dPpRlrSTT4WRh8mKNvR2TG3ocyanCJbwKaf1HLZcDj0Q6HsJg7snd1EMbU34?=
 =?us-ascii?Q?S/w8sbzibw2oi6HIT7HXSTFNu6WaDfd5mIWYGlzpi/sVsp6wjuedeogER2d5?=
 =?us-ascii?Q?NBMKf9/wrCN5Q8zp2z5EpknnWIfmxz67naxepuAe0xjm+gU3UCTnwy5ytU9j?=
 =?us-ascii?Q?AgGpOEEKQqfZN9pNlmYjZoAVYo7cKFlxJ2F8TfAlbD5rirvleFkUU1uWhjG5?=
 =?us-ascii?Q?Wqldt5elmfsn/hWdfCsOC0BiTD77tnguL9T/3+cQZtHySh0VkwTmxYMKvqUU?=
 =?us-ascii?Q?D9iprH2IDp5DsBmivs8oqWjhs9OYdhsfs+MC6fLDKHxEJk9CGkj5r2x6tfrg?=
 =?us-ascii?Q?pWBtp4eMoqnP64PIMPIKJLJZrH8kZU9TzOr/dx36KJwnL1Jab+7KeuRFyH1a?=
 =?us-ascii?Q?gOiKCwws5BSXIQ37roD1opgr6NPhz5ttNKR9E+WVSfVcwat8wRbcngvGf8y3?=
 =?us-ascii?Q?4nwN1IPFx+2d54W/FgI1QjOKOWg+ZNmR5w/85iA2qDmuBTEaPiACrh32L5jQ?=
 =?us-ascii?Q?pVkLctznWmxPPteSYPoOazepgqZmaQPQbjbHfO7dYj/oemjbZ00zA7GIUrve?=
 =?us-ascii?Q?QLcCtsJ4tdlwNg0ZkYgAP0qsThk3UcGWhq66jOcuKrldOleljgfd3l8NWgxn?=
 =?us-ascii?Q?zbs+kqhNYjcKfFo+hUCY+T1R1F8bNXeHB1kzW4VfZhehsDFd4O1TPTuwoWJf?=
 =?us-ascii?Q?JI3HLCRrg22HV+iUA/z6HAXohp1pq7EfX+tmaYe3FDuL4wepk5ZZjejtg/e3?=
 =?us-ascii?Q?+YA447kYI4isiy9iGUVz3wx1sb3jmbftnayd+rNg6zIHZc+x9ePMBsjaPSKd?=
 =?us-ascii?Q?W2hGM93JfNEi2p5Jmu/dbD7k24qfX/j9qDyxDsHy2w2XaYda+M9sB3hAmIo/?=
 =?us-ascii?Q?zzI/J5DGfi92C4JyCM9nFAwRr5L1oQZq1lJiVBFteG9acbbbQiwqMA5DtBIx?=
 =?us-ascii?Q?FRpp7GplLKMEeMnoX+AMYHy22xMfq5RPNfV0vA1e6P+k/h3fOFJkpFt1EFtE?=
 =?us-ascii?Q?jUbQsn0qLiaXJ+w9cHMp/4SOP4PQIfixBksjEOO7uRbUL0y+UXKamOoDid5T?=
 =?us-ascii?Q?eGZWvdHvPeA252XchC+77T3mAcYTp3MDPn3iFyzVB2bws3NNkdIcQGkVreEK?=
 =?us-ascii?Q?Lc8fbJj4SNnfNKwuGr68tOc2UIuflVc5/BO2ErPSyiAxwIMM/VudEXBZxWc5?=
 =?us-ascii?Q?7o39Y1jomvKS6YcYETGyiOKSE/Sf1P6WOpXM9ZvX8hO6tNYJs0zJJrOJHDuD?=
 =?us-ascii?Q?4kiTtrPQjUYDLEM56Q9E4BO1ABxI9rc6UOgtMBL/fWDS1MgNu7MfqmsEg+1O?=
 =?us-ascii?Q?gKDkBQXEZVyMvaPajltZZfQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S7wFJEKPeWsny2b4qhSmgDI5Xsjm73QDrjoxW3FuiCGqS9yDy+RWbgmexvJ2?=
 =?us-ascii?Q?jzdKfv36IGJrd6A3J8RXg4K8ymElHLcBxiRLob4htXaaUchrwTmQq5g+bSIk?=
 =?us-ascii?Q?l6t8XGvDR7e9Ki/JScqXjyYkx9iShwQJlmAx3Bl5NZDorWqXzZNHGdMKUtIP?=
 =?us-ascii?Q?iGIPX4QLH95S+moDjm1pRMDGqTItB2E8K6A94QSrqxcTNN2VB4uvbno2VfBp?=
 =?us-ascii?Q?6/9UHzj9pslwNi4BqE573hXc06eZ6JfxCyi9gP0C0ubhsyJa2wv33CR2wJC1?=
 =?us-ascii?Q?avfOTtXJU36R8eyvlLzOC66zWJEahAxCENocddr4+bTtCodjeu6PGkNoUFZo?=
 =?us-ascii?Q?0yExvyfJx8vSErpX8PYcel4tDM8IwwxDnmASoQ5BWi4ouSkOlpfEN8ZOeYBb?=
 =?us-ascii?Q?Ni4vd0KYXaJMa0F4K1xXMntQeaJllQthHz1yky4RJ2g+zG+qHvSZni0DMN2X?=
 =?us-ascii?Q?7CEhGioDxvqgsQgHcu+yZrvi0ZWccQmaMMpgFNCvBR/QTCrD/pqCPrJIaz2o?=
 =?us-ascii?Q?+vVlx00Xgl6Ia/AGIcRQ9vMMLIIIvKv9gB2WUuMt/wMXvoszp8KbLqyl5+o3?=
 =?us-ascii?Q?BwHPSpS0xeKmsNNEWAMCXUoWZJF7iwyGvux2eIpkyRDuNBP6PJspe0bQ2JX3?=
 =?us-ascii?Q?M8LGKzrxHRBZu0Ef1oSx6RKCeBtErNvaslfCpkD7H/kG5e9+AuX7xFzHefR7?=
 =?us-ascii?Q?0h0kvw2SVcmHGBoizBRSFEECkba0T3QSQSyt2p+09I+HgDF6m6L7JR1FMCUW?=
 =?us-ascii?Q?0eESxbSGjNfJKFN41cMcf+198npiq4StheKtZ0c9ODD+ScQJaSt77suqNQcd?=
 =?us-ascii?Q?D536VUXpmupdtBU+x2AbZaH1Zd4hzMxaM2ZRa2MzWfEBVKeQ9ej1DgdnyLL6?=
 =?us-ascii?Q?gYqdBsgemLue8tb7aOKxAFTF+cz1CY4AKeScrXDFx1l0RN+lWB2W5fqb4awK?=
 =?us-ascii?Q?8dtXT8hwqRTqE3kHpqYnqecH9iw+TYSFsbRkzM0IQW0G3shkhkek86Zt88mI?=
 =?us-ascii?Q?48J1gYouItKaWadrfJYkTpM5/ewXKKN1gnDdog/9HXlHSBB8nd/Cs+JVCUgy?=
 =?us-ascii?Q?lqGQXYz4rq3pNHbOD5fBxgtwBlVAFoJ+ZyO7xCYMeYJKe7qet5H3dZyL3wj3?=
 =?us-ascii?Q?5jzIKzBkPKHzjoFT0yzrqqdZVm2oB1RXCnsPpgidDz6VrqUpvEz2nfeyyv0e?=
 =?us-ascii?Q?qF0RswoNMEjtebXiAbc+MrpCiIH5T4gvSBZWL+1KUKD2d353tP6g5pfZ3efA?=
 =?us-ascii?Q?WPKn5qGXQ5MqGOZnS9ruTeHTbRodmw56TXapm3wIGwSXfvF9NY/sqHRccG4G?=
 =?us-ascii?Q?H9AggIDu1llEOzt6wdpH2SWnl3Rhesh+kZ8AWpbD3xfJvZPFzMxD86lTh2UF?=
 =?us-ascii?Q?xEgbiGV3Je+ui2w3+nl/b+JoCbNvxzp5Vg7YTMl87ZqacBsWr33HMZwR1IX5?=
 =?us-ascii?Q?J172tHwz8dwWU4JiF/i+xrPJRPvnycMZpzL39kOEYL+ObDHQY4PhT+508oW8?=
 =?us-ascii?Q?l8i7dJYdHr5gjqyy2qrFGe3/aLdIs8zM+Kl+oGIq8/WSav4mlzzgFDG3wb+m?=
 =?us-ascii?Q?l7Z/tBbUA4c4YUtuI2vZ9CTHE+wP06ZxJblMwxYtqlut5S8wCu0ZkcKO5khF?=
 =?us-ascii?Q?7clq3JA+OLk0o18hU8LzDPhpBNTMvs1Ijy5Afm6zv2OSvDSOrfOpW0kcP6tc?=
 =?us-ascii?Q?NHWos9wfATSw0SP4dHVwvbiELx7B2h0G5Vl8YgEompAPBtaX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf434da-0f8f-4fef-e36d-08de6ffcfea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2026 21:22:32.7578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6kHgw3Gz61i49SWde43b3qxaF6ABeS1SRpKbAF5beAWcpPCNEDs4GE/KUI5MuZlBZr7lLk09ESHta2ywdEsaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3056
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

Thank you.

It seems we need to handle two additional early exits from the loop when hn=
_flush_txagg(), something like this?

diff --git a/drivers/net/netvsc/hn_rxtx.c b/drivers/net/netvsc/hn_rxtx.c
   index 72dab26ede..example 100644
   --- a/drivers/net/netvsc/hn_rxtx.c
   +++ b/drivers/net/netvsc/hn_rxtx.c
   @@ -1589,8 +1589,10 @@ hn_xmit_pkts(void *ptxq, struct rte_mbuf **tx_pkt=
s, uint16_t nb_pkts)
                        if (txq->agg_pktleft =3D=3D 0 ||
                            RTE_ALIGN(pkt_size, txq->agg_align) > txq->agg_=
szleft) {
   -                            if (hn_flush_txagg(txq, &need_sig))
   +                            if (hn_flush_txagg(txq, &need_sig)) {
   +                                    hn_txd_put(txq, txd);
                                        goto fail;
   +                            }
                        }


                        pkt =3D hn_try_txagg(hv, txq, txd, pkt_size);
   -                    if (unlikely(!pkt))
   +                    if (unlikely(!pkt)) {
   +                            hn_txd_put(txq, txd);
                                break;
   +                    }

                        hn_encap(pkt, queue_id, m);
   @@ -1611,8 +1615,10 @@ hn_xmit_pkts(void *ptxq, struct rte_mbuf **tx_pkt=
s, uint16_t nb_pkts)
                } else {
                        /* Send any outstanding packets in buffer */
   -                    if (txq->agg_txd && hn_flush_txagg(txq, &need_sig))
   +                    if (txq->agg_txd && hn_flush_txagg(txq, &need_sig))=
 {
   +                            hn_txd_put(txq, txd);
                                goto fail;
   +                    }

                        pkt =3D txd->rndis_pkt;


> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday, February 18, 2026 5:45 PM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org;
> Long Li <longli@microsoft.com>; Wei Hu <weh@microsoft.com>; Haiyang
> Zhang <haiyangz@microsoft.com>
> Subject: [EXTERNAL] [RFT] net/netvsc: fix txd leak on chimney buffer allo=
c
> failure
>=20
> Audit of tx_pkt_burst() code path in drivers found this related bug.
>=20
> When hn_try_txagg() fails because hn_chim_alloc() cannot allocate a chimn=
ey
> buffer slot, it returns NULL without freeing the txd descriptor that was =
obtained
> earlier from the txd pool. The caller then breaks out of the transmit loo=
p
> without returning the txd either.
>=20
> Each occurrence leaks one txd descriptor. Under sustained chimney buffer
> pressure this eventually exhausts the txd pool and blocks all transmit on=
 the
> queue.
>=20
> Add hn_txd_put() before the break to return the txd to the pool.
>=20
> Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/netvsc/hn_rxtx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/netvsc/hn_rxtx.c b/drivers/net/netvsc/hn_rxtx.c =
index
> 72dab26ede..3fc54e76b9 100644
> --- a/drivers/net/netvsc/hn_rxtx.c
> +++ b/drivers/net/netvsc/hn_rxtx.c
> @@ -1595,8 +1595,10 @@ hn_xmit_pkts(void *ptxq, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>=20
>=20
>  			pkt =3D hn_try_txagg(hv, txq, txd, pkt_size);
> -			if (unlikely(!pkt))
> +			if (unlikely(!pkt)) {
> +				hn_txd_put(txq, txd);
>  				break;
> +			}
>=20
>  			hn_encap(pkt, queue_id, m);
>  			hn_append_to_chim(txq, pkt, m);
> --
> 2.51.0

