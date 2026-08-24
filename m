Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291ACC5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 23:18:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0FDD400D6;
	Tue, 25 Aug 2026 01:18:28 +0200 (CEST)
Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch
 [109.224.244.118])
 by mails.dpdk.org (Postfix) with ESMTP id 88E7E400D5
 for <dev@dpdk.org>; Tue, 25 Aug 2026 01:18:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcgov.dev;
 s=protonmail3; t=1787613506; x=1787872706;
 bh=l6oaEfm+bJ2+zwIzoYz2tGayvkFCaHAnL8gSYUbKjOs=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=HrOuw//0pmgBuHbqzMbqOeTrN2djEOg80aTs+6AjT4+EI97Z/8ACh2uRDY0tzHy4N
 9DhVU5Lstqxt2eeZsmoHjVQedObG86ljG/IGIrRQ+IGOwT9C42ZyCZSI2v5gMgiUC8
 pmkHyZOiN1S9EHdh7viDjz6dkaqiN9z2KNgTlyFg4eUgw7rkYWySz4Kpq2XFCxO9EY
 DswCCacIvP3eOi0sLUluDyPoqni1IA08YJZwEk1lFOeycQUrqAF2J9VveabbBLCVFT
 XXHErzGMl64KnXWNHXzrAXrmn/mYfiITytstI902SwA4QMVZBDnrutQaQr2IXtPVyQ
 AZhAuHokW8R0A==
Date: Mon, 24 Aug 2026 23:18:21 +0000
To: Aman Singh <aman.deep.singh@intel.com>
From: "Matthew G. McGovern" <matthew@mcgov.dev>
Cc: dev@dpdk.org
Subject: [PATCH] testpmd: allow --tx-ip definitions per-port
Message-ID: <20260824231805.256714-1-matthew@mcgov.dev>
Feedback-ID: 45755057:user:proton
X-Pm-Message-ID: 981307cb664c9fd9c5957bd0dbc457ad3716fa30
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Modifies --tx-ip flag to be of the form:

--tx-ip=3D[port_id:]src,dest

to allow setting the addresses for each port.

Signed-off-by: Matthew G. McGovern <matthew@mcgov.dev>
---
 app/test-pmd/parameters.c             | 57 +++++++++++++++++++++------
 app/test-pmd/testpmd.h                |  4 +-
 app/test-pmd/txonly.c                 | 31 +++++++++++----
 doc/guides/testpmd_app_ug/run_app.rst | 10 ++++-
 4 files changed, 80 insertions(+), 22 deletions(-)

diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 0032ea4e25..833b14eda4 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -504,7 +504,9 @@ usage(char* progname)
 =09printf("  --txonly-multi-flow: generate multiple flows in txonly mode\n=
");
 =09printf("  --txonly-nb-flows=3DN: number of flows per lcore in txonly"
 =09       " multi-flow mode (1-64, default 64)\n");
-=09printf("  --tx-ip=3Dsrc,dst: IP addresses in Tx-only mode\n");
+=09printf("  --tx-ip=3D[port:]src,dst: IP addresses in Tx-only mode.\n"
+=09       "    Without a port prefix the addresses apply to all ports.\n"
+=09       "    May be given several times to configure ports individually.=
\n");
 =09printf("  --tx-udp=3Dsrc[,dst]: UDP ports in Tx-only mode\n");
 =09printf("  --eth-link-speed: force link speed.\n");
 =09printf("  --rxq-share: enable Rx queue sharing per switch and Rx domain=
\n");
@@ -1039,26 +1041,59 @@ launch_args_parse(int argc, char** argv)
 =09=09=09break;
 =09=09}
 =09=09case TESTPMD_OPT_TX_IP_NUM: {
+=09=09=09uint32_t src_addr, dst_addr;
+=09=09=09unsigned long port_num;
+=09=09=09bool port_given =3D false;
+=09=09=09char *addrs =3D optarg;
 =09=09=09struct in_addr in;
-=09=09=09char *end;
+=09=09=09portid_t port_id =3D 0;
+=09=09=09char *sep, *end;
+
+=09=09=09/* Optional "PORT:" prefix selects a single Tx port. */
+=09=09=09sep =3D strchr(addrs, ':');
+=09=09=09if (sep !=3D NULL) {
+=09=09=09=09*sep =3D '\0';
+=09=09=09=09errno =3D 0;
+=09=09=09=09port_num =3D strtoul(addrs, &end, 0);
+=09=09=09=09if (errno !=3D 0 || end =3D=3D addrs ||
+=09=09=09=09=09=09*end !=3D '\0' ||
+=09=09=09=09=09=09port_num >=3D RTE_MAX_ETHPORTS)
+=09=09=09=09=09rte_exit(EXIT_FAILURE,
+=09=09=09=09=09=09"Invalid tx-ip port: %s\n",
+=09=09=09=09=09=09addrs);
+=09=09=09=09port_id =3D (portid_t)port_num;
+=09=09=09=09port_given =3D true;
+=09=09=09=09addrs =3D sep + 1;
+=09=09=09}
=20
-=09=09=09end =3D strchr(optarg, ',');
-=09=09=09if (end =3D=3D optarg || !end)
+=09=09=09end =3D strchr(addrs, ',');
+=09=09=09if (end =3D=3D addrs || end =3D=3D NULL)
 =09=09=09=09rte_exit(EXIT_FAILURE,
-=09=09=09=09=09"Invalid tx-ip: %s", optarg);
+=09=09=09=09=09"Invalid tx-ip: %s\n", addrs);
=20
-=09=09=09*end++ =3D 0;
-=09=09=09if (inet_pton(AF_INET, optarg, &in) =3D=3D 0)
+=09=09=09*end++ =3D '\0';
+=09=09=09if (inet_pton(AF_INET, addrs, &in) =3D=3D 0)
 =09=09=09=09rte_exit(EXIT_FAILURE,
 =09=09=09=09=09"Invalid source IP address: %s\n",
-=09=09=09=09=09optarg);
-=09=09=09tx_ip_src_addr =3D rte_be_to_cpu_32(in.s_addr);
+=09=09=09=09=09addrs);
+=09=09=09src_addr =3D rte_be_to_cpu_32(in.s_addr);
=20
 =09=09=09if (inet_pton(AF_INET, end, &in) =3D=3D 0)
 =09=09=09=09rte_exit(EXIT_FAILURE,
 =09=09=09=09=09"Invalid destination IP address: %s\n",
-=09=09=09=09=09optarg);
-=09=09=09tx_ip_dst_addr =3D rte_be_to_cpu_32(in.s_addr);
+=09=09=09=09=09end);
+=09=09=09dst_addr =3D rte_be_to_cpu_32(in.s_addr);
+
+=09=09=09if (port_given) {
+=09=09=09=09tx_ip_src_addr[port_id] =3D src_addr;
+=09=09=09=09tx_ip_dst_addr[port_id] =3D dst_addr;
+=09=09=09} else {
+=09=09=09=09/* No port given: apply to every port. */
+=09=09=09=09for (pid =3D 0; pid < RTE_MAX_ETHPORTS; pid++) {
+=09=09=09=09=09tx_ip_src_addr[pid] =3D src_addr;
+=09=09=09=09=09tx_ip_dst_addr[pid] =3D dst_addr;
+=09=09=09=09}
+=09=09=09}
 =09=09=09break;
 =09=09}
 =09=09case TESTPMD_OPT_TX_UDP_NUM: {
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 083171853c..71092dea9e 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -691,8 +691,8 @@ extern int8_t tx_wthresh;
 extern uint16_t tx_udp_src_port;
 extern uint16_t tx_udp_dst_port;
=20
-extern uint32_t tx_ip_src_addr;
-extern uint32_t tx_ip_dst_addr;
+extern uint32_t tx_ip_src_addr[RTE_MAX_ETHPORTS];
+extern uint32_t tx_ip_dst_addr[RTE_MAX_ETHPORTS];
=20
 extern struct fwd_config cur_fwd_config;
 extern struct fwd_engine *cur_fwd_eng;
diff --git a/app/test-pmd/txonly.c b/app/test-pmd/txonly.c
index a4acb85d29..da197720a9 100644
--- a/app/test-pmd/txonly.c
+++ b/app/test-pmd/txonly.c
@@ -50,12 +50,26 @@ uint16_t tx_udp_src_port =3D 9;
 uint16_t tx_udp_dst_port =3D 9;
=20
 /* use RFC5735 / RFC2544 reserved network test addresses */
-uint32_t tx_ip_src_addr =3D (198U << 24) | (18 << 16) | (0 << 8) | 1;
-uint32_t tx_ip_dst_addr =3D (198U << 24) | (18 << 16) | (0 << 8) | 2;
+#define TX_IP_SRC_ADDR_DEF ((198U << 24) | (18 << 16) | (0 << 8) | 1)
+#define TX_IP_DST_ADDR_DEF ((198U << 24) | (18 << 16) | (0 << 8) | 2)
+
+uint32_t tx_ip_src_addr[RTE_MAX_ETHPORTS];
+uint32_t tx_ip_dst_addr[RTE_MAX_ETHPORTS];
+
+RTE_INIT(tx_ip_addr_init)
+{
+=09portid_t pid;
+
+=09for (pid =3D 0; pid < RTE_MAX_ETHPORTS; pid++) {
+=09=09tx_ip_src_addr[pid] =3D TX_IP_SRC_ADDR_DEF;
+=09=09tx_ip_dst_addr[pid] =3D TX_IP_DST_ADDR_DEF;
+=09}
+}
=20
 #define IP_DEFTTL  64   /* from RFC 1340. */
=20
-static struct rte_ipv4_hdr pkt_ip_hdr; /**< IP header of transmitted packe=
ts. */
+/** IP header of transmitted packets, per Tx port. */
+static struct rte_ipv4_hdr pkt_ip_hdr[RTE_MAX_ETHPORTS];
 RTE_DEFINE_PER_LCORE(uint8_t, _src_port_var); /**< Source port variation *=
/
 static struct rte_udp_hdr pkt_udp_hdr; /**< UDP header of tx packets. */
=20
@@ -104,7 +118,8 @@ copy_buf_to_pkt(void* buf, unsigned len, struct rte_mbu=
f *pkt, unsigned offset)
 static void
 setup_pkt_udp_ip_headers(struct rte_ipv4_hdr *ip_hdr,
 =09=09=09 struct rte_udp_hdr *udp_hdr,
-=09=09=09 uint16_t pkt_data_len)
+=09=09=09 uint16_t pkt_data_len,
+=09=09=09 portid_t port_id)
 {
 =09uint16_t pkt_len;
=20
@@ -128,8 +143,8 @@ setup_pkt_udp_ip_headers(struct rte_ipv4_hdr *ip_hdr,
 =09ip_hdr->next_proto_id =3D IPPROTO_UDP;
 =09ip_hdr->packet_id =3D 0;
 =09ip_hdr->total_length   =3D RTE_CPU_TO_BE_16(pkt_len);
-=09ip_hdr->src_addr =3D rte_cpu_to_be_32(tx_ip_src_addr);
-=09ip_hdr->dst_addr =3D rte_cpu_to_be_32(tx_ip_dst_addr);
+=09ip_hdr->src_addr =3D rte_cpu_to_be_32(tx_ip_src_addr[port_id]);
+=09ip_hdr->dst_addr =3D rte_cpu_to_be_32(tx_ip_dst_addr[port_id]);
=20
 =09/*
 =09 * Compute IP header checksum.
@@ -208,7 +223,7 @@ pkt_burst_prepare(struct rte_mbuf *pkt, struct rte_memp=
ool *mbp,
 =09 * Copy headers in first packet segment(s).
 =09 */
 =09copy_buf_to_pkt(eth_hdr, sizeof(*eth_hdr), pkt, 0);
-=09copy_buf_to_pkt(&pkt_ip_hdr, sizeof(pkt_ip_hdr), pkt,
+=09copy_buf_to_pkt(&pkt_ip_hdr[fs->tx_port], sizeof(*pkt_ip_hdr), pkt,
 =09=09=09sizeof(struct rte_ether_hdr));
 =09copy_buf_to_pkt(&pkt_udp_hdr, sizeof(pkt_udp_hdr), pkt,
 =09=09=09sizeof(struct rte_ether_hdr) +
@@ -416,7 +431,7 @@ tx_only_begin(portid_t pi)
 =09=09return -EINVAL;
 =09}
=20
-=09setup_pkt_udp_ip_headers(&pkt_ip_hdr, &pkt_udp_hdr, pkt_data_len);
+=09setup_pkt_udp_ip_headers(&pkt_ip_hdr[pi], &pkt_udp_hdr, pkt_data_len, p=
i);
=20
 =09timestamp_enable =3D false;
 =09timestamp_mask =3D 0;
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app=
_ug/run_app.rst
index 52699efa78..bcfbf33f92 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -155,13 +155,21 @@ The command line options are:
     Set the MAC address ``XX:XX:XX:XX:XX:XX`` of the peer port N,
     where 0 <=3D N < ``RTE_MAX_ETHPORTS``.
=20
-*   ``--tx-ip=3DSRC,DST``
+*   ``--tx-ip=3D[N:]SRC,DST``
=20
     Set the source and destination IP address used when doing transmit onl=
y test.
     The defaults address values are source 198.18.0.1 and
     destination 198.18.0.2. These are special purpose addresses
     reserved for benchmarking (RFC 5735).
=20
+    Without the optional port prefix, the addresses apply to all ports.
+    With the prefix ``N:``, where 0 <=3D N < ``RTE_MAX_ETHPORTS``,
+    the addresses apply only to port N.
+    The option may be given several times to configure ports individually,
+    and later options override earlier ones::
+
+       --tx-ip=3D198.18.0.1,198.18.0.2 --tx-ip=3D1:10.1.0.3,10.1.0.4
+
 *   ``--tx-udp=3DSRC[,DST]``
=20
     Set the source and destination UDP port number for transmit test only =
test.
--=20
2.55.0


