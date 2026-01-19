Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054A7CCF2F6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 12:43:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90E914029A;
	Mon, 19 Jan 2026 13:43:20 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 4308B40299
 for <dev@dpdk.org>; Mon, 19 Jan 2026 13:43:18 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvqqW1sJFzHnGk8;
 Mon, 19 Jan 2026 20:42:47 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id 134AB40563;
 Mon, 19 Jan 2026 20:43:17 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 19 Jan 2026 13:43:16 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 19 Jan 2026 13:43:16 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v4 05/11] net/pcap: use bool for flags
Thread-Topic: [PATCH v4 05/11] net/pcap: use bool for flags
Thread-Index: AQHch/zbETjmVDSnE0KVVp7M1dBY+rVZb+ww
Date: Mon, 19 Jan 2026 12:43:16 +0000
Message-ID: <33b7fb037a4c433781178b9b74185e26@huawei.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260117220030.273471-1-stephen@networkplumber.org>
 <20260117220030.273471-6-stephen@networkplumber.org>
In-Reply-To: <20260117220030.273471-6-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Saturday 17 January 2026 21:57
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Subject: [PATCH v4 05/11] net/pcap: use bool for flags
>=20
> Save some space by using bool for flag values.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/pcap/pcap_ethdev.c | 67 +++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethde=
v.c
> index 0c65a2dffc..62f073e214 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -5,6 +5,7 @@
>   */
>=20
>  #include <stdlib.h>
> +#include <stdbool.h>
>  #include <time.h>
>=20
>  #include <pcap.h>
> @@ -91,9 +92,9 @@ struct pmd_internals {
>  	char devargs[ETH_PCAP_ARG_MAXLEN];
>  	struct rte_ether_addr eth_addr;
>  	int if_index;
> -	int single_iface;
> -	int phy_mac;
> -	unsigned int infinite_rx;
> +	bool single_iface;
> +	bool phy_mac;
> +	bool infinite_rx;
>  };
>=20
>  struct pmd_process_private {
> @@ -103,25 +104,25 @@ struct pmd_process_private {
>  };
>=20
>  struct pmd_devargs {
> -	unsigned int num_of_queue;
> +	uint16_t num_of_queue;
> +	bool phy_mac;
>  	struct devargs_queue {
>  		pcap_dumper_t *dumper;
>  		pcap_t *pcap;
>  		const char *name;
>  		const char *type;
>  	} queue[RTE_PMD_PCAP_MAX_QUEUES];
> -	int phy_mac;
>  };
>=20
>  struct pmd_devargs_all {
>  	struct pmd_devargs rx_queues;
>  	struct pmd_devargs tx_queues;
> -	int single_iface;
> -	unsigned int is_tx_pcap;
> -	unsigned int is_tx_iface;
> -	unsigned int is_rx_pcap;
> -	unsigned int is_rx_iface;
> -	unsigned int infinite_rx;
> +	bool single_iface;
> +	bool is_tx_pcap;
> +	bool is_tx_iface;
> +	bool is_rx_pcap;
> +	bool is_rx_iface;
> +	bool infinite_rx;
>  };
>=20
>  static const char *valid_arguments[] =3D {
> @@ -871,7 +872,7 @@ eth_dev_close(struct rte_eth_dev *dev)
>  		}
>  	}
>=20
> -	if (internals->phy_mac =3D=3D 0)
> +	if (!internals->phy_mac)
>  		/* not dynamically allocated, must not be freed */
>  		dev->data->mac_addrs =3D NULL;
>=20
> @@ -1192,29 +1193,19 @@ open_tx_iface(const char *key, const char *value,=
 void *extra_args)
>  }
>=20
>  static int
> -select_phy_mac(const char *key __rte_unused, const char *value,
> -		void *extra_args)
> +process_bool_flag(const char *key, const char *value, void *extra_args)
>  {
> -	if (extra_args) {
> -		const int phy_mac =3D atoi(value);
> -		int *enable_phy_mac =3D extra_args;
> -
> -		if (phy_mac)
> -			*enable_phy_mac =3D 1;
> -	}
> -	return 0;
> -}
> -
> -static int
> -get_infinite_rx_arg(const char *key __rte_unused,
> -		const char *value, void *extra_args)
> -{
> -	if (extra_args) {
> -		const int infinite_rx =3D atoi(value);
> -		int *enable_infinite_rx =3D extra_args;
> -
> -		if (infinite_rx > 0)
> -			*enable_infinite_rx =3D 1;
> +	bool *flag =3D extra_args;
> +
> +	if (value =3D=3D NULL || *value =3D=3D '\0') {
> +		*flag =3D true; /* default with no additional argument */
> +	} else if (strcmp(value, "0") =3D=3D 0) {
> +		*flag =3D false;
> +	} else if (strcmp(value, "1") =3D=3D 0) {
> +		*flag =3D true;
> +	} else {
> +		PMD_LOG(ERR, "Invalid '%s' value '%s'", key, value);
> +		return -1;
>  	}
>  	return 0;
>  }
> @@ -1491,7 +1482,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
>  		dumpers.queue[0] =3D pcaps.queue[0];
>=20
>  		ret =3D rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
> -				&select_phy_mac, &pcaps.phy_mac);
> +					 &process_bool_flag, &pcaps.phy_mac);

Nit: there seems to be one unnecessary space and unnecessary=20
indentation change in the above and some other lines.

>  		if (ret < 0)
>  			goto free_kvlist;
>=20
> @@ -1530,9 +1521,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
>=20
>  		if (infinite_rx_arg_cnt =3D=3D 1) {
>  			ret =3D rte_kvargs_process(kvlist,
> -					ETH_PCAP_INFINITE_RX_ARG,
> -					&get_infinite_rx_arg,
> -					&devargs_all.infinite_rx);
> +						 ETH_PCAP_INFINITE_RX_ARG,
> +						 &process_bool_flag,
> +						 &devargs_all.infinite_rx);
>  			if (ret < 0)
>  				goto free_kvlist;
>  			PMD_LOG(INFO, "infinite_rx has been %s for %s",
> --
> 2.51.0

Regardless of spacing issues,

Acked-by: Marat Khalili <marat.khalili@huawei.com>
