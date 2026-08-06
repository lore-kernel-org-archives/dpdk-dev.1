Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865C4C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 00:32:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63EB1402AC;
	Thu,  6 Aug 2026 02:32:02 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11020135.outbound.protection.outlook.com
 [52.101.193.135])
 by mails.dpdk.org (Postfix) with ESMTP id 17D9E4027E;
 Thu,  6 Aug 2026 02:32:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pM4uJoH0MpcmCWi+1eqcicMDpfFHfhGfMqyGifeyRY6DGsbnUGC6gYAnEaksJ7rPZXwosGP+FCLjYHuuyRmqPBF7aT9fpegNrvRqoth+KLJ5YFqOmKGybDoeWajbENG8/VpXVPmAsy2dLr0ADd8J2C7HqPonM7Yg1aldfQOI0nQwjz0pvw3uQBkbrmWDgMzIzo64ZTTKDYp6RFCJgYoN2VjxyyKmBgeGh9LKJP9DTsbeD/UKRg8FbR6NcyhYvCrQcLyp0l2U0bBfh4+HMz8NE2A9oDrFc2hJWKFXgtJk6TA77nffiq+/rc5abQxbkYOLsXZ50jHN6nAvJhfFWbGkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egjcczY6DAUacpQluBXRreE1nXgqSChxTgCocNPi4Jw=;
 b=IFEJjIcU/7q7qW5jcVocJlXZ1+0v5bI7NLeVqDe5HJHo6f85VaCiN+rk7O+6whFvJpopkPKWRV/DCQ3MaNeDa1Lveg3eg3eq/iaV95NXuScgrifOsMaYsUx9JO9+VeBasYTMJJ+KUzVhParbFmNawU29aGZUgX/PAXJ+CGDJZdYr2xZ3gyyj5bQUkMtXmlBzovbrl0fLURtPwjotN0c0uTgA9QwwIfm4P/Cewyj0WFCyHA72kt5NDnyGQGnj5esdOC0ZXvNymNrz+vhEeYbSohnG/C4cA0N4TFSw0l3fGe1YrYnHUikdfc/I1Wjww/jaPd1FtshMoc2ZJ84fzYX52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egjcczY6DAUacpQluBXRreE1nXgqSChxTgCocNPi4Jw=;
 b=TXDIn/ARuZ6V3iTZYo3Tpdb1P97eO+KTvjj0U6Pj00pw/3g5ZutTsehsD1FP6OiI2EDbpCCUoCNp3gufjTSBMbZW/WhkiAV8LxRuX6RMe1uIK/lxz7uOaPD8vGSUGz/8PTl6624qg1O8eoho3L+PFbUtDzNI3LhWETkvkK0kPDY=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5894.namprd21.prod.outlook.com (2603:10b6:806:496::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.4; Thu, 6 Aug 2026
 00:31:57 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.005; Thu, 6 Aug 2026
 00:31:57 +0000
From: Long Li <longli@microsoft.com>
To: Rita Ruvinsky <rita.ruvinsky@weka.io>, "dev@dpdk.org" <dev@dpdk.org>
CC: Wei Hu <weh@microsoft.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH 2/2] net/mana: fix double free of mbuf on Rx
 WQE post failure
Thread-Topic: [EXTERNAL] [PATCH 2/2] net/mana: fix double free of mbuf on Rx
 WQE post failure
Thread-Index: AQHdJPFLdaNIgL1TxE6e6lIl9lpXq7aQK/+g
Date: Thu, 6 Aug 2026 00:31:57 +0000
Message-ID: <SA1PR21MB6683F7326CDBC7A36A660318CED22@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260805154407.1965063-1-rita.ruvinsky@weka.io>
 <20260805154407.1965063-2-rita.ruvinsky@weka.io>
In-Reply-To: <20260805154407.1965063-2-rita.ruvinsky@weka.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b0f790d0-19c5-45bb-b91a-6648e5cef9f6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-06T00:31:37Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5894:EE_
x-ms-office365-filtering-correlation-id: 0b28063c-35cb-4a59-3024-08def3521fa9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|4143699003|56012099006|11063799006|38070700021|10067099003|7146999003;
x-microsoft-antispam-message-info: veTJvK3pbPBYZQR3IXD4XdDuL5Tu6XBRTO0gB1FCY/zZnFe3n3mAddAA4jXn1+SY0ICTAgK5m6XiUxlDGlVeuj17llz3LCZs8SxGQgdL7unvblD7buyNdFXgFbgQ0+vDQ5JINVW+LV05gEI4dTPmfcFjJPMikh8XdxSz4whk9pykpGodVFBSQ17es3mE7AJWqjZzPq7PvqNq3wQGBgx7pEXeXtkKGWbiQVXjFbOm53c3WORujjYebG1olVID9VJ6rB0uc6FNooQw+z0oTc8ZCMRurxd+6p7joGLGvHffqJCZQdh/NyuUt468a2fiP4PvsM/rFeFvdW14cBnlVlIpYujhsMXJLSX1l1AJHaX5BbElgR3La/gW7Hrn8Vm5NQdJg4oZrGH6HVk9JGdXgaFmHyvmPwfWKO9WncvpOvT/BC+hR8raQGE12S88ZVYJEFTDF0c+b6vfQJ3jbsqyjnO1DgqzemSItnhtkYArTtQSMYyHa0r0YDHiXedJJTEU9cZ5IRrk3VL0H7pWhWWWnT3VzLCars+jh59XM0oiKRAnpf+BYO5+IeXQDjkblyKx4qxuI/xSnAdtb/yKjPkCwB+1wfp9JYSCI+DYNEINZKDiRxB82l1Luz0d8Uw4yeDJnIFCftPINNV+pLZ+wDMyqEzeyso++O4X+tq12iWWuuiy2TeQIaQhHAfgyi4LDXHVjw4kj7bWqZP7E5qZFR6rA/EI0RzTG7aPeqSnC/Nih87tBCE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(38070700021)(10067099003)(7146999003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0uvEeHr4c4B0QHjzLBjKeNKhpwL5Vvkd43v9h6C33idRsG9pq3/Zj4zNl937?=
 =?us-ascii?Q?PoHUn/Leb+omZrCwY42VL+18Sop/QUQ7lLrMXT+LUGDZJRWGrPMb5GeWevh4?=
 =?us-ascii?Q?6UGSog6pwzIJadV6xkcrnrPGKsMnF8J2cTokAAiPRz54Z5VIlbQmr7U/W+Yc?=
 =?us-ascii?Q?T6NeRxxGGCJ9/nUj1wUlOGnGCSEHX8jNaGEatuJkgG3wecpd4TuuZmuc7o+6?=
 =?us-ascii?Q?2tK2g1PH+4Kjwq5ehYZFEzGKRAxVRTf30KxpPSWV48xFIGcWaUg0nNwSKe/E?=
 =?us-ascii?Q?PQCHB6I3NdGUmZn6gnZ4pre25FLXB+0kAVDhDegBXyl3uZPH2bbz2kJmyPPl?=
 =?us-ascii?Q?Wkoa7RzUo8+6zvIiI6fw9u9BNAB6fsUqvFN9H258sGk9NpEUPigGhS4S3DaV?=
 =?us-ascii?Q?eZQmtLEwM/d0WVcoREM88ErCwUGvB0hf1PItVlORwe4bx1eV9jAUmrrzD/VM?=
 =?us-ascii?Q?W8+TBb5BAwFeCM8SkigxEEGQ5Na/MaiwrFJurniBvxZ8+ny8vbFYihiySo/h?=
 =?us-ascii?Q?ZulD98OsYkB/kTZekBDtXCJqeOFQmWn1J8ZO2FOAoig1S8aVAXk1VNv77I3h?=
 =?us-ascii?Q?eZBwQVqumNnZP33+/+QuryqkdANcFlQPNygc44jYju2S4B2663g68qgyP+Qz?=
 =?us-ascii?Q?Fs7wX5zb490dFqxi1iki1x+jWQonp4fOhrDF3heLSY3FcPl1u7mbUTS765rr?=
 =?us-ascii?Q?4/suMFMSFka42T45Wdii4LT+VHe0neWDuQ9qb5scCI+JY0qd8fWWh0bwsV6g?=
 =?us-ascii?Q?z1bjbjcXyyC02WOh8oI1nafOUFLANetLUysnW3o7XYxXoc4kHgOzgDkmQyJL?=
 =?us-ascii?Q?5zca1tYrf3qqVd99mMyJre5L0pi4Np34GMIi9JgewozIjTIeXQ/1cNfXAgcF?=
 =?us-ascii?Q?6FXgW290xOUlNrCtZR90EFmc0zNhJqag2EuER7ZiCRMQ7UHkXFYti1d1xPTt?=
 =?us-ascii?Q?bpntiw93nZ9Jo0a9UuroaiAvoUaFWaKAAGKxlVqv103ySAncsSOYlwr5542g?=
 =?us-ascii?Q?CTtqrColPujG+K+gyvbIqdG3W9J4n2I6vpUTjNtk85hD0fFKIdAm3aHtquhl?=
 =?us-ascii?Q?imVLLIksnzynLv+h3TSL9itjU8q0laS8Fv+HEgdDYMUCd5DRUQLJ4K7V/A4U?=
 =?us-ascii?Q?e986W3MFTQYYGOHnIi91+wS8mcyRBnQa5qzUSo7y3HagXSkCLfyHV7MmuOIz?=
 =?us-ascii?Q?1DzfWF8VzB4uD4hijgu66jNTnbAyhKcxG8xq2Rc2JLKYP1pwFWdAM7LTfcql?=
 =?us-ascii?Q?h4KR1n8RyLTT7NIDHURGQBji2m78GUfr3SSJxrbeyi9NPmhQR+6mnsqkyXIq?=
 =?us-ascii?Q?w/ld51S315+f8SAXw7TTZqtOMKSjxqVbEi7kuuyxjuruBVM8SB2IqT2bLM9o?=
 =?us-ascii?Q?v+OIggS8XuDiqXto2lQIwplP3w5SLYOSOsN7csiLfU9WoZ7xhaFnsLf6dlj+?=
 =?us-ascii?Q?xzuTZOn/Hd1q+vFs1KfCttAc8CBX99KVWcjO1CZhBAZsoLBU+2Be5GYIz1qQ?=
 =?us-ascii?Q?XCj1DemT9nfr7lW9S8cTWXcpxN96Wz1QVlAh1eR3f4NG+xIxfGDgValw0qZi?=
 =?us-ascii?Q?HctPgEwGmSgWuZUo/n65vRgHYMe1V3duEQOPvlEJz6yjfFmy98sPf4m0iiqL?=
 =?us-ascii?Q?WoKvxjYErHIFa7tQoPrn/jQp8srLqv8uktQ6zQ5YtQ6diN4YqE69hAtvbzSm?=
 =?us-ascii?Q?WWDZBy3ZPFazTjDAjo7hApkZ2qu7EbeDvg8rgygshpySBTY9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b28063c-35cb-4a59-3024-08def3521fa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 00:31:57.6827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ieexmWy8QFIO8DD1er2Ylev70kt4BRrfLxZSnBewodr8pj+xqsxid+CQmT3RPpj1l86P2phL4UP63GkHJeIySQ==
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


> mana_post_rx_wqe() frees the mbuf when mana_alloc_pmd_mr() fails, but the
> caller already frees the un-posted range starting at that same mbuf via
> rte_pktmbuf_free_bulk(&mbufs[i], batch_count - i), so the mbuf is returne=
d to
> the mempool twice and can be handed out to two consumers at once.
>=20
> The free was correct before the bulk allocation rework, when this functio=
n
> allocated the mbuf itself. Now that the caller owns it, leave the mbuf to=
 the
> caller on every error path.
>=20
> Fixes: eeb37809601b ("net/mana: use bulk mbuf allocation for Rx WQEs")
> Cc: stable@dpdk.org
> Signed-off-by: Rita Ruvinsky <rita.ruvinsky@weka.io>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/net/mana/rx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/mana/rx.c b/drivers/net/mana/rx.c index
> f196d43aee..2bca004dfa 100644
> --- a/drivers/net/mana/rx.c
> +++ b/drivers/net/mana/rx.c
> @@ -68,10 +68,10 @@ mana_post_rx_wqe(struct mana_rxq *rxq, struct
> rte_mbuf *mbuf)
>         int ret;
>         struct mana_mr_cache *mr;
>=20
> +       /* Don't free mbuf on error: the caller bulk-frees it from
> + &mbufs[i]. */
>         mr =3D mana_alloc_pmd_mr(&rxq->mr_btree, priv, mbuf);
>         if (!mr) {
>                 DP_LOG(ERR, "failed to register RX MR");
> -               rte_pktmbuf_free(mbuf);
>                 return -ENOMEM;
>         }
>=20
> --
> 2.43.0

