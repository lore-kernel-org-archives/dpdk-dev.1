Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37286C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 16:59:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22B5642792;
	Wed, 19 Feb 2025 17:59:57 +0100 (CET)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mails.dpdk.org (Postfix) with ESMTP id 5440B4028B;
 Wed, 19 Feb 2025 17:59:55 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YyjLt1QMXzpk5c;
 Thu, 20 Feb 2025 01:00:22 +0800 (CST)
Received: from kwepemf500005.china.huawei.com (unknown [7.202.181.243])
 by mail.maildlp.com (Postfix) with ESMTPS id 07F0D1A0188;
 Thu, 20 Feb 2025 00:59:47 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 kwepemf500005.china.huawei.com (7.202.181.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 00:59:46 +0800
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 19 Feb 2025 17:59:44 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>, "david.hunt@intel.com"
 <david.hunt@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, "jerinj@marvell.com" <jerinj@marvell.com>,
 "radu.nicolau@intel.com" <radu.nicolau@intel.com>, "gakhil@marvell.com"
 <gakhil@marvell.com>, "cristian.dumitrescu@intel.com"
 <cristian.dumitrescu@intel.com>, "ferruh.yigit@amd.com"
 <ferruh.yigit@amd.com>, "mb@smartsharesystems.com" <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, haijie <haijie1@huawei.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] examples/l3fwd: adjust Tx burst size based on Rx burst
Thread-Topic: [PATCH] examples/l3fwd: adjust Tx burst size based on Rx burst
Thread-Index: AQHbfQpEp4T1nazsxkasKNel/XBYVLNO5Lqg
Date: Wed, 19 Feb 2025 16:59:43 +0000
Message-ID: <b225e77281864d098ec3da1fd76a69c7@huawei.com>
References: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
In-Reply-To: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.73]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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



> Previously, the TX burst size was fixed at 256, leading to performance
> degradation in certain scenarios.
>=20
> This patch introduces logic to set the TX burst size to match the
> configured RX burst size (--burst option, default 32, max 512)
> for better efficiency.
>=20
> Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set Rx burst size")
> Cc: haijie1@huawei.com
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> ---
>  examples/l3fwd/l3fwd.h        |  6 +++---
>  examples/l3fwd/l3fwd_common.h | 11 +++++++----
>  examples/l3fwd/main.c         |  2 ++
>  3 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
> index 0cce3406ee..9d7c73504b 100644
> --- a/examples/l3fwd/l3fwd.h
> +++ b/examples/l3fwd/l3fwd.h
> @@ -35,7 +35,7 @@
>  /*
>   * Try to avoid TX buffering if we have at least MAX_TX_BURST packets to=
 send.
>   */
> -#define	MAX_TX_BURST	  (MAX_PKT_BURST / 2)
> +#define	MAX_TX_BURST	  (DEFAULT_PKT_BURST / 2)
>=20
>  #define NB_SOCKETS        8
>=20
> @@ -152,8 +152,8 @@ send_single_packet(struct lcore_conf *qconf,
>  	len++;
>=20
>  	/* enough pkts to be sent */
> -	if (unlikely(len =3D=3D MAX_PKT_BURST)) {
> -		send_burst(qconf, MAX_PKT_BURST, port);
> +	if (unlikely(len =3D=3D nb_pkt_per_burst)) {
> +		send_burst(qconf, nb_pkt_per_burst, port);
>  		len =3D 0;
>  	}
>=20
> diff --git a/examples/l3fwd/l3fwd_common.h b/examples/l3fwd/l3fwd_common.=
h
> index d94e5f1357..6cb7de5144 100644
> --- a/examples/l3fwd/l3fwd_common.h
> +++ b/examples/l3fwd/l3fwd_common.h
> @@ -25,6 +25,9 @@
>   */
>  #define SENDM_PORT_OVERHEAD(x) (x)
>=20
> +extern uint32_t nb_pkt_per_burst;
> +extern uint32_t max_tx_burst;
> +
>  /*
>   * From http://www.rfc-editor.org/rfc/rfc1812.txt section 5.2.2:
>   * - The IP version number must be 4.
> @@ -71,7 +74,7 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t port,=
 struct rte_mbuf *m[],
>  	 * If TX buffer for that queue is empty, and we have enough packets,
>  	 * then send them straightway.
>  	 */
> -	if (num >=3D MAX_TX_BURST && len =3D=3D 0) {
> +	if (num >=3D max_tx_burst && len =3D=3D 0) {
>  		n =3D rte_eth_tx_burst(port, qconf->tx_queue_id[port], m, num);
>  		if (unlikely(n < num)) {
>  			do {
> @@ -86,7 +89,7 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t port,=
 struct rte_mbuf *m[],
>  	 */
>=20
>  	n =3D len + num;
> -	n =3D (n > MAX_PKT_BURST) ? MAX_PKT_BURST - len : num;
> +	n =3D (n > nb_pkt_per_burst) ? nb_pkt_per_burst - len : num;
>=20
>  	j =3D 0;
>  	switch (n % FWDSTEP) {
> @@ -112,9 +115,9 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t por=
t, struct rte_mbuf *m[],
>  	len +=3D n;
>=20
>  	/* enough pkts to be sent */
> -	if (unlikely(len =3D=3D MAX_PKT_BURST)) {
> +	if (unlikely(len =3D=3D nb_pkt_per_burst)) {
>=20
> -		send_burst(qconf, MAX_PKT_BURST, port);
> +		send_burst(qconf, nb_pkt_per_burst, port);
>=20
>  		/* copy rest of the packets into the TX buffer. */
>  		len =3D num - n;
> diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
> index 994b7dd8e5..4cabd05be2 100644
> --- a/examples/l3fwd/main.c
> +++ b/examples/l3fwd/main.c
> @@ -59,6 +59,7 @@ uint16_t nb_rxd =3D RX_DESC_DEFAULT;
>  uint16_t nb_txd =3D TX_DESC_DEFAULT;
>  uint32_t nb_pkt_per_burst =3D DEFAULT_PKT_BURST;
>  uint32_t mb_mempool_cache_size =3D MEMPOOL_CACHE_SIZE;
> +uint32_t max_tx_burst =3D MAX_TX_BURST;
>=20
>  /**< Ports set in promiscuous mode off by default. */
>  static int promiscuous_on;
> @@ -733,6 +734,7 @@ parse_pkt_burst(const char *optarg)
>  		return;
>  	}
>  	nb_pkt_per_burst =3D burst_size;
> +	max_tx_burst =3D burst_size / 2;

Might be a bit better then to completely remove MAX_TX_BURST,
and just always set:
max_tx_burst =3D nb_pkt_per_burst / 2;

>  	RTE_LOG(INFO, L3FWD, "Using PMD-provided burst value %d\n", burst_size)=
;
>  }
>=20
> --
> 2.34.1

