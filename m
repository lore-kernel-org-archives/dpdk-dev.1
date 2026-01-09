Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77240D1A63C
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 15:00:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3AFA4028E;
	Fri,  9 Jan 2026 16:00:03 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 04D56400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 16:00:02 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id EA22320679;
 Fri,  9 Jan 2026 16:00:01 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 2/3] test: allow larger packet sizes
Date: Fri, 9 Jan 2026 16:00:00 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6563A@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260108204449.176087-3-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 2/3] test: allow larger packet sizes
Thread-Index: AdyA361IDJv8R+6AQ5GWVN8fVmRBdQAl/QPg
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260108204449.176087-1-stephen@networkplumber.org>
 <20260108204449.176087-3-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
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

>  generate_packet_burst(struct rte_mempool *mp, struct rte_mbuf
> **pkts_burst,
>  		struct rte_ether_hdr *eth_hdr, uint8_t vlan_enabled,
>  		void *ip_hdr, uint8_t ipv4, struct rte_udp_hdr *udp_hdr,
> -		int nb_pkt_per_burst, uint8_t pkt_len, uint8_t
> nb_pkt_segs);
> +		int nb_pkt_per_burst, uint16_t pkt_len, uint8_t
> nb_pkt_segs);

The pkt_len field in rte_mbuf is uint32_t.
You could upgrade the packet length here to uint32_t too, instead of =
upgrading to only uint16_t.

<feature creep>
While you are at it, the nb_segs field in rte_mbuf is uint16_t, you =
could also upgrade the number of segments to uint16_t.
</feature creep>

