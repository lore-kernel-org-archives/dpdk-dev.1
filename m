Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73575FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:59:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB52C40693;
	Wed, 29 Apr 2026 11:58:29 +0200 (CEST)
Received: from mx1.wirefilter.com (mx1.wirefilter.com [82.147.223.86])
 by mails.dpdk.org (Postfix) with ESMTP id B24A640285;
 Tue, 28 Apr 2026 09:05:00 +0200 (CEST)
Received: from egw.wirefilter.com (localhost.localdomain [127.0.0.1])
 by mx1.wirefilter.com (Proxmox) with ESMTP id 3A496C171F;
 Tue, 28 Apr 2026 10:05:00 +0300 (+03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wirefilter.com;
 h=cc:cc:content-type:content-type:date:from:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to; s=default; bh=ntQNRlao2mPYk+1Z+7bux7cKbc9P+5B78QmY5TPu5qc=; b=
 XcGs8Rpbw/p/N5n/miVBNsvMJ2Pj63agvOYRvMh9ch/nosh62PMMhlyQuW+j6uDH
 gHefu2kSHMRIXTXffpf2okPkDsWZ4u9WwQiVqD5U0xe3RLtkwxj6EOYsFdRAQxwh
 7dNeyDMuF385Mbwv7Bwjw6Cg5ZAxp1R6+hFvIlvu8A3ZOhpyLdJvRrNpzAZ89UUe
 PHKVfg0hzap4+Jp2sENcy9ZZvF05kEkVpNDsKC5QYPAdawcJQlYyHNfjYwTTMa4g
 AD58q5uE6dxNgvC8GJ7b0ZmKrGKDE45W2xRJIphPo7cbAW7ivQQbWlPUg4bDgy+C
 D9cYdqq5AvHjpE5yVzVLPg==
Date: Tue, 28 Apr 2026 10:05:00 +0300 (AST)
From: Abdulrahman Alshawi <ashawi@wirefilter.com>
To: dev <dev@dpdk.org>
Cc: bharat <bharat@chelsio.com>, stable <stable@dpdk.org>, 
 vipinpv85 <vipinpv85@gmail.com>
Message-ID: <430997417.15909938.1777359900023.JavaMail.zimbra@wirefilter.com>
In-Reply-To: <1991720957.15868387.1777308056746.JavaMail.zimbra@wirefilter.com>
References: <2136264989.15868282.1777307418083.JavaMail.zimbra@wirefilter.com>
 <1991720957.15868387.1777308056746.JavaMail.zimbra@wirefilter.com>
Subject: Re: [PATCH 1/2] net/cxgbe: fix Rx handling for packed responses
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="=_bd862c0c-6a2d-4a7e-909a-8c87184f07ef"
X-Originating-IP: [10.1.1.3]
X-Mailer: Zimbra 10.1.16_GA_4850 (ZimbraModernWebClient - GC147
 (Mac)/10.1.16_GA_4850)
Thread-Topic: net/cxgbe: fix Rx handling for packed responses
Thread-Index: vibgbhNHf0ETdtVkwLuwbZrWfuFjrQpAUFJekIjF01Q=
X-Mailman-Approved-At: Wed, 29 Apr 2026 11:58:18 +0200
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

--=_bd862c0c-6a2d-4a7e-909a-8c87184f07ef
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=20

Adding Vipin Varghese

=20
=20
=C2=A0=20
=20
=20
=20

-----Original Message-----

From: Abdulrahman <ashawi@wirefilter.com>
To: dev <dev@dpdk.org>
Cc: bharat <bharat@chelsio.com>; stable <stable@dpdk.org>
Date: Monday, 27 April 2026 7:40 PM +03
Subject: [PATCH 1/2] net/cxgbe: fix Rx handling for packed responses

=20
 The Rx path assumes every SGE response starts a new Free List buffer: =C2=
=A0 =C2=A0 =C2=A0 BUG_ON(!(len & F_RSPD_NEWBUF)); =C2=A0 That is not always=
 true. On T5/T6, small packets can be packed into the same FL buffer. Only =
the first response for that buffer has NEWBUF set; later responses can refe=
r to the same buffer with a different payload offset. =C2=A0 The current PM=
D consumes one FL buffer per response. When packed responses are delivered,=
 the FL consumer state goes out of sync with the hardware and the affected =
ingress queue stops making progress. From user space this shows up as: =C2=
=A0 =C2=A0 - rx_bgN_dropped_packets increasing at line rate =C2=A0 - q_ipac=
kets for the affected queue staying at 0 =C2=A0 - imissed increasing =C2=A0=
 - no recovery until the port is restarted =C2=A0 Fix this by tracking pack=
ed-buffer alignment and copying packet payload from the current FL buffer a=
t q->offset, only freeing the FL buffer once it has actually been consumed.=
 =C2=A0 This patch: =C2=A0 - adds sge::fl_align from the ingress pad/pack s=
ettings =C2=A0 - introduces cxgbe_copy_rx_pkt() to copy from packed FL buff=
ers =C2=A0 - advances q->offset by len rounded up to fl_align =C2=A0 - free=
s an FL buffer only after full consumption =C2=A0 - drains the previous buf=
fer when a later response arrives with NEWBUF =C2=A0 Reproduce (T62100-LP-C=
R, FW 2.1.19.0 / TP 0.1.23.2): =C2=A0 =C2=A0 dpdk-testpmd -l 1-9 -a 0000:18=
:00.4 -- \ =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --rxq=3D32 --txq=
=3D32 --nb-cores=3D8 --forward-mode=3Drxonly -i =C2=A0 =C2=A0 testpmd> port=
 stop all =C2=A0 testpmd> flow flush 0 =C2=A0 testpmd> flow create 0 ingres=
s pattern eth \ =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / vlan tci spec 0 =
tci mask 0x0007 \ =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / end actions qu=
eue index 5 / end =C2=A0 testpmd> port start all =C2=A0 testpmd> start =C2=
=A0 Without this patch, rx_qN_packets stays at 0 while rx_bgN_dropped_packe=
ts rises at line rate. With the patch, rx_qN_packets tracks received traffi=
c and rx_bgN_dropped_packets stays at 0. =C2=A0 Signed-off-by: Abdulrahman =
Alshawi <ashawi@wirefilter.com> --- =C2=A0drivers/net/cxgbe/base/adapter.h =
| =C2=A0 1 + =C2=A0drivers/net/cxgbe/sge.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 122 ++++++++++++++++++++++++------- =C2=A02 files changed, 98 inserti=
ons(+), 25 deletions(-) =C2=A0 diff --git a/drivers/net/cxgbe/base/adapter.=
h b/drivers/net/cxgbe/base/adapter.h index 207f3ecb88..e67cf22950 100644 --=
- a/drivers/net/cxgbe/base/adapter.h +++ b/drivers/net/cxgbe/base/adapter.h=
 @@ -280,6 +280,7 @@ struct sge { =C2=A0 =C2=A0 u16 max_ethqsets; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* # of available Ethernet queue sets */ =C2=A0=
 =C2=A0 u32 stat_len; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* l=
ength of status page at ring end */ =C2=A0 =C2=A0 u32 pktshift; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* padding between CPL & packet data=
 */ + =C2=A0 u32 fl_align; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /* packed Rx packet alignment */ =C2=A0 =C2=A0 =C2=A0 /* response queue in=
terrupt parameters */ =C2=A0 =C2=A0 u16 timer_val[SGE_NTIMERS]; diff --git =
a/drivers/net/cxgbe/sge.c b/drivers/net/cxgbe/sge.c index e9d45f24c4..7cf5c=
70775 100644 --- a/drivers/net/cxgbe/sge.c +++ b/drivers/net/cxgbe/sge.c @@=
 -1492,6 +1492,90 @@ static inline void cxgbe_fill_mbuf_info(struct adapter=
 *adap, =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 RTE_MBUF_F_RX_L4_CKSUM_BAD); =C2=A0} =C2=A0 +static int cxgbe_copy_rx_p=
kt(struct sge_rspq *q, struct sge_eth_rxq *rxq, + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 u32 len, struct rte_mbuf **out) +{ + =C2=A0 struct=
 sge *s =3D &q->adapter->sge; + =C2=A0 struct rte_mbuf *pkt; + =C2=A0 char =
*dst; + =C2=A0 u32 copied =3D 0; + =C2=A0 u32 remaining =3D len; + + =C2=A0=
 pkt =3D rte_pktmbuf_alloc(q->mb_pool); + =C2=A0 if (unlikely(!pkt)) { + =
=C2=A0 =C2=A0 =C2=A0 rxq->rspq.eth_dev->data->rx_mbuf_alloc_failed++; + =C2=
=A0 =C2=A0 =C2=A0 rxq->stats.rx_drops++; + =C2=A0 =C2=A0 =C2=A0 return -ENO=
MEM; + =C2=A0 } + + =C2=A0 dst =3D rte_pktmbuf_append(pkt, len); + =C2=A0 i=
f (unlikely(!dst)) { + =C2=A0 =C2=A0 =C2=A0 rte_pktmbuf_free(pkt); + =C2=A0=
 =C2=A0 =C2=A0 rxq->stats.rx_drops++; + =C2=A0 =C2=A0 =C2=A0 return -ENOMEM=
; + =C2=A0 } + + =C2=A0 while (remaining) { + =C2=A0 =C2=A0 =C2=A0 const st=
ruct rx_sw_desc *rsd =3D &rxq->fl.sdesc[rxq->fl.cidx]; + =C2=A0 =C2=A0 =C2=
=A0 struct rte_mbuf *src =3D rsd->buf; + =C2=A0 =C2=A0 =C2=A0 u32 bufsz =3D=
 get_buf_size(q->adapter, rsd); + =C2=A0 =C2=A0 =C2=A0 u32 copy_len; + + =
=C2=A0 =C2=A0 =C2=A0 if (unlikely(!src || q->offset < 0 || + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (u32)q->offset >=3D bufsz)) { + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_pktmbuf_free(pkt); + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 rxq->stats.rx_drops++; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn -EINVAL; + =C2=A0 =C2=A0 =C2=A0 } + + =C2=A0 =C2=A0 =C2=A0 copy_len =
=3D RTE_MIN(bufsz - (u32)q->offset, remaining); + =C2=A0 =C2=A0 =C2=A0 rte_=
memcpy(dst + copied, + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_pktmbu=
f_mtod_offset(src, const void *, q->offset), + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 copy_len); + + =C2=A0 =C2=A0 =C2=A0 copied +=3D copy_len; + =
=C2=A0 =C2=A0 =C2=A0 remaining -=3D copy_len; + =C2=A0 =C2=A0 =C2=A0 q->off=
set +=3D copy_len; + + =C2=A0 =C2=A0 =C2=A0 if (remaining) { + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 free_rx_bufs(&rxq->fl, 1); + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 q->offset =3D 0; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continu=
e; + =C2=A0 =C2=A0 =C2=A0 } + + =C2=A0 =C2=A0 =C2=A0 q->offset =3D RTE_ALIG=
N_CEIL(q->offset, s->fl_align); + =C2=A0 =C2=A0 =C2=A0 if ((u32)q->offset >=
=3D bufsz) { + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free_rx_bufs(&rxq->fl, 1)=
; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q->offset =3D 0; + =C2=A0 =C2=A0 =C2=
=A0 } + =C2=A0 } + + =C2=A0 *out =3D pkt; + =C2=A0 return 0; +} + +static u=
nsigned int cxgbe_fl_pkt_align(struct adapter *adap) +{ + =C2=A0 u32 sge_co=
ntrol =3D t4_read_reg(adap, A_SGE_CONTROL); + =C2=A0 unsigned int ingpad_sh=
ift, ingpad, fl_align; + + =C2=A0 ingpad_shift =3D CHELSIO_CHIP_VERSION(ada=
p->params.chip) <=3D CHELSIO_T5 ? + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 X_INGPADBOUNDARY_SHIFT : X_T6_INGPADBOUNDARY_SHIFT; + =C2=A0 ingpad =3D=
 1U << (G_INGPADBOUNDARY(sge_control) + ingpad_shift); + =C2=A0 fl_align =
=3D ingpad; + + =C2=A0 if (!is_t4(adap->params.chip)) { + =C2=A0 =C2=A0 =C2=
=A0 u32 sge_control2 =3D t4_read_reg(adap, A_SGE_CONTROL2); + =C2=A0 =C2=A0=
 =C2=A0 unsigned int ingpack =3D G_INGPACKBOUNDARY(sge_control2); + + =C2=
=A0 =C2=A0 =C2=A0 ingpack =3D ingpack =3D=3D X_INGPACKBOUNDARY_16B ? +=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 16 : 1U << (ingpack + X_INGPACKBOUND=
ARY_SHIFT); + =C2=A0 =C2=A0 =C2=A0 fl_align =3D RTE_MAX(ingpad, ingpack); +=
 =C2=A0 } + + =C2=A0 return fl_align ? fl_align : RTE_CACHE_LINE_SIZE; +} +=
 =C2=A0/** =C2=A0 * process_responses - process responses from an SGE respo=
nse queue =C2=A0 * @q: the ingress queue to process @@ -1535,14 +1619,12 @@=
 static int process_responses(struct sge_rspq *q, int budget, =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stat_pidx =3D ntohs(q->stat->pidx); =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stat_pidx_diff =3D P_IDXDIFF(q, stat_pidx);=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (stat_pidx_diff && budget_=
left) { - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct rx_=
sw_desc *rsd =3D - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &rxq->fl.sdesc[rxq->fl.cidx]; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 const struct rss_header *rss_hdr =3D =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (const void *)q->cur_desc=
; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct cpl_=
rx_pkt *cpl =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (const void *)&q->cur_desc[1]; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct rte_mbuf *pkt, *npkt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 u32 len, bufsz; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct rte_mbuf *pkt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u32 len; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 rc =3D (const struct rsp_ctrl *) =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((const char *)q->cur_desc + @@ =
-1553,28 +1635,16 @@ static int process_responses(struct sge_rspq *q, int b=
udget, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l=
en =3D ntohl(rc->pldbuflen_qid); - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 BUG_ON(!(len & F_RSPD_NEWBUF)); - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 pkt =3D rsd->buf; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 npkt =3D pkt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 len =3D G_RSPD_LEN(len); - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pkt->pkt_len =3D len; - - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* Chain mbufs into len if necessary */ - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 while (len) { - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mbuf *new_pkt =3D rsd->buf; - - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bufsz =3D min(g=
et_buf_size(q->adapter, - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsd), len); - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new_pkt->data_l=
en =3D bufsz; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 unmap_rx_buf(&rxq->fl); - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 len -=3D bufsz; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 npkt->next =3D new_pkt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 npkt =3D new_pkt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt->nb_segs++; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsd =3D &rxq->fl.sd=
esc[rxq->fl.cidx]; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (l=
en & F_RSPD_NEWBUF) { + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (q->offset > 0) { + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free_rx_bufs(&rxq->fl, 1); + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q->of=
fset =3D 0; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 } =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 npkt->next =3D NULL; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt->nb_segs--; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D G_RSPD_LEN(len); + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D cxgbe_copy_rx_pkt(q, rxq, len, &=
pkt); + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(ret))=
 + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cxgbe_fill_m=
buf_info(q->adapter, cpl, pkt); =C2=A0 @@ -2379,6 +2449,7 @@ int t4_sge_ini=
t(struct adapter *adap) =C2=A0 =C2=A0 sge_control =3D t4_read_reg(adap, A_S=
GE_CONTROL); =C2=A0 =C2=A0 s->pktshift =3D G_PKTSHIFT(sge_control); =C2=A0 =
=C2=A0 s->stat_len =3D (sge_control & F_EGRSTATUSPAGESIZE) ? 128 : 64; + =
=C2=A0 s->fl_align =3D cxgbe_fl_pkt_align(adap); =C2=A0 =C2=A0 ret =3D t4_s=
ge_init_soft(adap); =C2=A0 =C2=A0 if (ret < 0) { =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_err(adap, "%s: t4_sge_init_soft failed, error %d\n", @@ -2516,6 +25=
87,7 @@ int t4vf_sge_init(struct adapter *adap) =C2=A0 =C2=A0 s->stat_len =
=3D ((sge_control & F_EGRSTATUSPAGESIZE) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ? 128 : 64); =C2=A0 =C2=A0 s->pktshift =3D G_PKTSHIFT(sge_control);=
 + =C2=A0 s->fl_align =3D RTE_CACHE_LINE_SIZE; =C2=A0 =C2=A0 =C2=A0 /* =C2=
=A0 =C2=A0 * A FL with <=3D fl_starve_thres buffers is starving and a perio=
dic --=C2=A0 2.39.5    =20

--=_bd862c0c-6a2d-4a7e-909a-8c87184f07ef
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><body><div style="font-size: 11pt; font-family: arial, helvetica, sans-serif; direction: null; color: #000000;" data-attr="forced_root_block_attrs">
<div><br>Adding Vipin Varghese<br><br></div>
<div id="signature-content-no-signature" data-marker="__SIG_PRE__"></div>
<div>&nbsp;</div>
<div>

<div id="OLK_SRC_BODY_SECTION">
<div id="OLK_SRC_BODY_SECTION">
<blockquote style="margin: 0 0 0 .8em; border-left: 1px #ccc solid; padding-left: 1em;"><hr id="MESSAGE_DATA_MARKER"><strong>From: </strong>Abdulrahman &lt;ashawi@wirefilter.com&gt;<br><strong>To: </strong>dev &lt;dev@dpdk.org&gt;<br><strong>Cc: </strong>bharat &lt;bharat@chelsio.com&gt;; stable &lt;stable@dpdk.org&gt;<br><strong>Date: </strong>Monday, 27 April 2026 7:40 PM +03<br><strong>Subject: </strong>[PATCH 1/2] net/cxgbe: fix Rx handling for packed responses<br><br>
<div style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif; color: #000000;">
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">The Rx path assumes every SGE response starts a new Free List buffer:</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; BUG_ON(!(len &amp; F_RSPD_NEWBUF));</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">That is not always true. On T5/T6, small packets can be packed into the</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">same FL buffer. Only the first response for that buffer has NEWBUF set;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">later responses can refer to the same buffer with a different payload</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">offset.</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">The current PMD consumes one FL buffer per response. When packed</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">responses are delivered, the FL consumer state goes out of sync with the</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">hardware and the affected ingress queue stops making progress. From user</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">space this shows up as:</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; - rx_bgN_dropped_packets increasing at line rate</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; - q_ipackets for the affected queue staying at 0</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; - imissed increasing</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; - no recovery until the port is restarted</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">Fix this by tracking packed-buffer alignment and copying packet payload</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">from the current FL buffer at q-&gt;offset, only freeing the FL buffer once</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">it has actually been consumed.</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">This patch:</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; - adds sge::fl_align from the ingress pad/pack settings</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; - introduces cxgbe_copy_rx_pkt() to copy from packed FL buffers</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; - advances q-&gt;offset by len rounded up to fl_align</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; - frees an FL buffer only after full consumption</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; - drains the previous buffer when a later response arrives with NEWBUF</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">Reproduce (T62100-LP-CR, FW 2.1.19.0 / TP 0.1.23.2):</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; dpdk-testpmd -l 1-9 -a 0000:18:00.4 -- \</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; --rxq=32 --txq=32 --nb-cores=8 --forward-mode=rxonly -i</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; testpmd&gt; port stop all</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; testpmd&gt; flow flush 0</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; testpmd&gt; flow create 0 ingress pattern eth \</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; / vlan tci spec 0 tci mask 0x0007 \</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; / end actions queue index 5 / end</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; testpmd&gt; port start all</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; testpmd&gt; start</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">Without this patch, rx_qN_packets stays at 0 while</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">rx_bgN_dropped_packets rises at line rate. With the patch,</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">rx_qN_packets tracks received traffic and rx_bgN_dropped_packets</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">stays at 0.</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">Signed-off-by: Abdulrahman Alshawi &lt;ashawi@wirefilter.com&gt;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">---</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;drivers/net/cxgbe/base/adapter.h | &nbsp; 1 +</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;drivers/net/cxgbe/sge.c&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | 122 ++++++++++++++++++++++++-------</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;2 files changed, 98 insertions(+), 25 deletions(-)</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">diff --git a/drivers/net/cxgbe/base/adapter.h b/drivers/net/cxgbe/base/adapter.h</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">index 207f3ecb88..e67cf22950 100644</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">--- a/drivers/net/cxgbe/base/adapter.h</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+++ b/drivers/net/cxgbe/base/adapter.h</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">@@ -280,6 +280,7 @@ struct sge {</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; u16 max_ethqsets; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* # of available Ethernet queue sets */</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; u32 stat_len; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* length of status page at ring end */</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; u32 pktshift; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* padding between CPL &amp; packet data */</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; u32 fl_align; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* packed Rx packet alignment */</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; /* response queue interrupt parameters */</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; u16 timer_val[SGE_NTIMERS];</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">diff --git a/drivers/net/cxgbe/sge.c b/drivers/net/cxgbe/sge.c</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">index e9d45f24c4..7cf5c70775 100644</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">--- a/drivers/net/cxgbe/sge.c</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+++ b/drivers/net/cxgbe/sge.c</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">@@ -1492,6 +1492,90 @@ static inline void cxgbe_fill_mbuf_info(struct adapter *adap,</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RTE_MBUF_F_RX_L4_CKSUM_BAD);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;}</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+static int cxgbe_copy_rx_pkt(struct sge_rspq *q, struct sge_eth_rxq *rxq,</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; u32 len, struct rte_mbuf **out)</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+{</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; struct sge *s = &amp;q-&gt;adapter-&gt;sge;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; struct rte_mbuf *pkt;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; char *dst;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; u32 copied = 0;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; u32 remaining = len;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; pkt = rte_pktmbuf_alloc(q-&gt;mb_pool);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; if (unlikely(!pkt)) {</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; rxq-&gt;rspq.eth_dev-&gt;data-&gt;rx_mbuf_alloc_failed++;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; rxq-&gt;stats.rx_drops++;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; return -ENOMEM;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; }</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; dst = rte_pktmbuf_append(pkt, len);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; if (unlikely(!dst)) {</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; rte_pktmbuf_free(pkt);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; rxq-&gt;stats.rx_drops++;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; return -ENOMEM;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; }</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; while (remaining) {</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; const struct rx_sw_desc *rsd = &amp;rxq-&gt;fl.sdesc[rxq-&gt;fl.cidx];</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; struct rte_mbuf *src = rsd-&gt;buf;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; u32 bufsz = get_buf_size(q-&gt;adapter, rsd);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; u32 copy_len;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; if (unlikely(!src || q-&gt;offset &lt; 0 ||</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (u32)q-&gt;offset &gt;= bufsz)) {</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rte_pktmbuf_free(pkt);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rxq-&gt;stats.rx_drops++;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EINVAL;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; }</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; copy_len = RTE_MIN(bufsz - (u32)q-&gt;offset, remaining);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; rte_memcpy(dst + copied,</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rte_pktmbuf_mtod_offset(src, const void *, q-&gt;offset),</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; copy_len);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; copied += copy_len;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; remaining -= copy_len;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; q-&gt;offset += copy_len;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; if (remaining) {</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; free_rx_bufs(&amp;rxq-&gt;fl, 1);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; q-&gt;offset = 0;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; continue;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; }</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; q-&gt;offset = RTE_ALIGN_CEIL(q-&gt;offset, s-&gt;fl_align);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; if ((u32)q-&gt;offset &gt;= bufsz) {</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; free_rx_bufs(&amp;rxq-&gt;fl, 1);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; q-&gt;offset = 0;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; }</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; }</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; *out = pkt;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; return 0;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+}</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+static unsigned int cxgbe_fl_pkt_align(struct adapter *adap)</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+{</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; u32 sge_control = t4_read_reg(adap, A_SGE_CONTROL);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; unsigned int ingpad_shift, ingpad, fl_align;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; ingpad_shift = CHELSIO_CHIP_VERSION(adap-&gt;params.chip) &lt;= CHELSIO_T5 ?</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; X_INGPADBOUNDARY_SHIFT : X_T6_INGPADBOUNDARY_SHIFT;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; ingpad = 1U &lt;&lt; (G_INGPADBOUNDARY(sge_control) + ingpad_shift);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; fl_align = ingpad;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; if (!is_t4(adap-&gt;params.chip)) {</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; u32 sge_control2 = t4_read_reg(adap, A_SGE_CONTROL2);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; unsigned int ingpack = G_INGPACKBOUNDARY(sge_control2);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; ingpack = ingpack == X_INGPACKBOUNDARY_16B ?</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 16 : 1U &lt;&lt; (ingpack + X_INGPACKBOUNDARY_SHIFT);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; fl_align = RTE_MAX(ingpad, ingpack);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; }</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; return fl_align ? fl_align : RTE_CACHE_LINE_SIZE;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+}</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;/**</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; * process_responses - process responses from an SGE response queue</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; * @q: the ingress queue to process</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">@@ -1535,14 +1619,12 @@ static int process_responses(struct sge_rspq *q, int budget,</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; stat_pidx = ntohs(q-&gt;stat-&gt;pidx);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; stat_pidx_diff = P_IDXDIFF(q, stat_pidx);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; while (stat_pidx_diff &amp;&amp; budget_left) {</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; const struct rx_sw_desc *rsd =</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &amp;rxq-&gt;fl.sdesc[rxq-&gt;fl.cidx];</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; const struct rss_header *rss_hdr =</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (const void *)q-&gt;cur_desc;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; const struct cpl_rx_pkt *cpl =</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (const void *)&amp;q-&gt;cur_desc[1];</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct rte_mbuf *pkt, *npkt;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; u32 len, bufsz;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct rte_mbuf *pkt;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; u32 len;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rc = (const struct rsp_ctrl *)</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((const char *)q-&gt;cur_desc +</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">@@ -1553,28 +1635,16 @@ static int process_responses(struct sge_rspq *q, int budget,</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; len = ntohl(rc-&gt;pldbuflen_qid);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BUG_ON(!(len &amp; F_RSPD_NEWBUF));</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pkt = rsd-&gt;buf;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; npkt = pkt;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; len = G_RSPD_LEN(len);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pkt-&gt;pkt_len = len;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">-</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* Chain mbufs into len if necessary */</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; while (len) {</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct rte_mbuf *new_pkt = rsd-&gt;buf;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">-</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; bufsz = min(get_buf_size(q-&gt;adapter,</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rsd), len);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; new_pkt-&gt;data_len = bufsz;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unmap_rx_buf(&amp;rxq-&gt;fl);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; len -= bufsz;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; npkt-&gt;next = new_pkt;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; npkt = new_pkt;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pkt-&gt;nb_segs++;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rsd = &amp;rxq-&gt;fl.sdesc[rxq-&gt;fl.cidx];</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (len &amp; F_RSPD_NEWBUF) {</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (q-&gt;offset &gt; 0) {</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; free_rx_bufs(&amp;rxq-&gt;fl, 1);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; q-&gt;offset = 0;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; npkt-&gt;next = NULL;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pkt-&gt;nb_segs--;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; len = G_RSPD_LEN(len);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret = cxgbe_copy_rx_pkt(q, rxq, len, &amp;pkt);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (unlikely(ret))</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; cxgbe_fill_mbuf_info(q-&gt;adapter, cpl, pkt);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">@@ -2379,6 +2449,7 @@ int t4_sge_init(struct adapter *adap)</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; sge_control = t4_read_reg(adap, A_SGE_CONTROL);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; s-&gt;pktshift = G_PKTSHIFT(sge_control);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; s-&gt;stat_len = (sge_control &amp; F_EGRSTATUSPAGESIZE) ? 128 : 64;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; s-&gt;fl_align = cxgbe_fl_pkt_align(adap);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; ret = t4_sge_init_soft(adap);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; if (ret &lt; 0) {</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; dev_err(adap, "%s: t4_sge_init_soft failed, error %d\n",</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">@@ -2516,6 +2587,7 @@ int t4vf_sge_init(struct adapter *adap)</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; s-&gt;stat_len = ((sge_control &amp; F_EGRSTATUSPAGESIZE)</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ? 128 : 64);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; s-&gt;pktshift = G_PKTSHIFT(sge_control);</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+ &nbsp; s-&gt;fl_align = RTE_CACHE_LINE_SIZE;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-height: 15px;"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; /*</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&nbsp; &nbsp; * A FL with &lt;= fl_starve_thres buffers is starving and a periodic</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">--&nbsp;</span></p>
<p style="margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span style="font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">2.39.5</span></p>
</div>
</blockquote>
</div>
</div></div>
</div></body></html>
--=_bd862c0c-6a2d-4a7e-909a-8c87184f07ef--

