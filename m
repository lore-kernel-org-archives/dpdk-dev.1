Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF452CF6C1D
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 09:48:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E56F140267;
	Wed,  7 Jan 2026 10:48:12 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 712784021E
 for <dev@dpdk.org>; Wed,  7 Jan 2026 10:48:11 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dmNWS247pzHnGk2;
 Wed,  7 Jan 2026 17:48:04 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id 389004056A;
 Wed,  7 Jan 2026 17:48:10 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 7 Jan 2026 10:48:09 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 7 Jan 2026 10:48:09 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 06/12] net/pcap: remove global variables
Thread-Topic: [PATCH 06/12] net/pcap: remove global variables
Thread-Index: AQHcfzsI48iFHYDZtUKqXhQ5YokDBbVGdtZA
Date: Wed, 7 Jan 2026 09:48:09 +0000
Message-ID: <1bbe78bde7a74ebd81d54a8a7a669374@huawei.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260106182823.192350-7-stephen@networkplumber.org>
In-Reply-To: <20260106182823.192350-7-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
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
> Sent: Tuesday 6 January 2026 18:27
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Subject: [PATCH 06/12] net/pcap: remove global variables
>=20
> Localize variables where possible.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/pcap/pcap_ethdev.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethde=
v.c
> index 905ca62bd4..1658685a28 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -39,11 +39,9 @@
>=20
>  #define RTE_PMD_PCAP_MAX_QUEUES 16
>=20
> -static char errbuf[PCAP_ERRBUF_SIZE];
>  static struct timespec start_time;
>  static uint64_t start_cycles;
>  static uint64_t hz;
> -static uint8_t iface_idx;
>=20
>  static uint64_t timestamp_rx_dynflag;
>  static int timestamp_dynfield_offset =3D -1;
> @@ -526,6 +524,8 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint=
16_t nb_pkts)
>  static inline int
>  open_iface_live(const char *iface, pcap_t **pcap)
>  {
> +	char errbuf[PCAP_ERRBUF_SIZE];
> +
>  	pcap_t *pc =3D pcap_create(iface, errbuf);
>  	if (pc =3D=3D NULL) {
>  		PMD_LOG(ERR, "Couldn't create %s: %s", iface, errbuf);
> @@ -621,6 +621,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_d=
umper_t **dumper)
>  static int
>  open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
>  {
> +	char errbuf[PCAP_ERRBUF_SIZE];
> +
>  	*pcap =3D pcap_open_offline_with_tstamp_precision(pcap_filename,
>  							PCAP_TSTAMP_PRECISION_NANO, errbuf);
>  	if (*pcap =3D=3D NULL) {
> @@ -1314,11 +1316,13 @@ pmd_init_internals(struct rte_vdev_device *vdev,
>  	 * - and point eth_dev structure to new eth_dev_data structure
>  	 */
>  	*internals =3D (*eth_dev)->data->dev_private;
> +
>  	/*
>  	 * Interface MAC =3D 02:70:63:61:70:<iface_idx>
>  	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
>  	 * where the middle 4 characters are converted to hex.
>  	 */
> +	static uint8_t iface_idx;
>  	(*internals)->eth_addr =3D (struct rte_ether_addr) {
>  		.addr_bytes =3D { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
>  	};
> --
> 2.51.0

Acked-by: Marat Khalili <marat.khalili@huawei.com>
