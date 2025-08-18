Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7E1CA0EE9
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 08:11:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D173540267;
	Mon, 18 Aug 2025 10:11:50 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 56DF24013F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 10:11:49 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0CC87206AF;
 Mon, 18 Aug 2025 10:11:49 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RFC: Drop support for undersize packet mbufs
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 18 Aug 2025 10:11:46 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE42@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC: Drop support for undersize packet mbufs
Thread-Index: AdwQF72mTs2BiFweSQCxZYoBRDaIJg==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <stephen@networkplumber.org>, <andrew.rybchenko@oktetlabs.ru>
Cc: <dev@dpdk.org>
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

Why does the mbuf library support packet mbufs with smaller data room =
size than RTE_PKTMBUF_HEADROOM (e.g. [1]), when the Ethdev drivers (e.g. =
[2]) don't support it?

This goes all the way back to the first public release [3].

It seems crazy exotic, and should be removed for simplicity and a =
potential performance benefit.
What am I missing here?

Instead, the rte_pktmbuf_pool_create() functions should check that =
data_room_size >=3D RTE_PKTMBUF_HEADROOM.


[1]: =
https://elixir.bootlin.com/dpdk/v25.07/source/lib/mbuf/rte_mbuf.h#L941
static inline void rte_pktmbuf_reset_headroom(struct rte_mbuf *m)
{
	m->data_off =3D (uint16_t)RTE_MIN((uint16_t)RTE_PKTMBUF_HEADROOM,
					(uint16_t)m->buf_len);
}

[2]: =
https://elixir.bootlin.com/dpdk/v25.07/source/drivers/net/intel/i40e/i40e=
_rxtx.c#L609
mb->data_off =3D RTE_PKTMBUF_HEADROOM;

[3]: =
https://git.dpdk.org/dpdk/commit/lib/librte_mbuf?id=3Daf75078fece3615088e=
561357c1e97603e43a5fe
+static inline void rte_pktmbuf_reset(struct rte_mbuf *m)
+{
+	uint32_t buf_ofs;
+
+	m->pkt.next =3D NULL;
+	m->pkt.pkt_len =3D 0;
+	m->pkt.l2_len =3D 0;
+	m->pkt.l3_len =3D 0;
+	m->pkt.vlan_tci =3D 0;
+	m->pkt.nb_segs =3D 1;
+	m->pkt.in_port =3D 0xff;
+
+	m->ol_flags =3D 0;
+	buf_ofs =3D (RTE_PKTMBUF_HEADROOM <=3D m->buf_len) ?
+			RTE_PKTMBUF_HEADROOM : m->buf_len;
+	m->pkt.data =3D (char*) m->buf_addr + buf_ofs;
+
+	m->pkt.data_len =3D 0;
+	__rte_mbuf_sanity_check(m, RTE_MBUF_PKT, 1);
+}



Med venlig hilsen / Kind regards,
-Morten Br=F8rup

