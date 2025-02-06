Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF94C02199
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 18:06:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3F3340E78;
	Thu,  6 Feb 2025 19:06:16 +0100 (CET)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com
 [209.85.166.45]) by mails.dpdk.org (Postfix) with ESMTP id 2791A402BC
 for <dev@dpdk.org>; Thu,  6 Feb 2025 19:06:16 +0100 (CET)
Received: by mail-io1-f45.google.com with SMTP id
 ca18e2360f4ac-84a012f7232so65209539f.0
 for <dev@dpdk.org>; Thu, 06 Feb 2025 10:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738865175; x=1739469975; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VnAc4JIfpe+6u225vjWlyfqHfZ/VFZeCXXJLTodN+8I=;
 b=B0FgALyvfA3TE0Q0x9AUqptjQvXrdFfY6Fq8Fue6CYlzUHYcRKsijJGTODKn4pEXrP
 4q1JqGyEHPORYtbXIl3kPgZfQm+XKSFKzvQ7xntzd/LU438597v+mLhF65320dOyAG5W
 sQaRXepySOVs0Bgg56zIGl97s21uxc/WKcO3uonshHPatWPfTbwjrLtBQfO5pBZeiVkV
 qjRNjc4VsH7vOlpwZ0AhdRiHRJszJeZWoyfByreSbMjrvptGBTIzAlpwefz62biSJ2wX
 IPnkHWYB4wyLXENXu+OlvY//rSxGTfAa0qsnrF76c3+N3YRlnBty7mbKwGeUH4QBA3rU
 +I6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738865175; x=1739469975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VnAc4JIfpe+6u225vjWlyfqHfZ/VFZeCXXJLTodN+8I=;
 b=rOhzg2c3gitIgrdZb0vAaXGIOXb6fU0Zaj5hBKwHk+mJ4d4sHHONq0EXTbmxmse9nf
 oQ2aqWdshOuDWFKJ2BX5kUMb/Xj4sRpS/xK00tM1Y/+IAS49ydZMfXQuY2jtyOQHO9UV
 jkGnNNeCy0+8UdrC9+7xpRrKbRF/+cp1s+nvUKDHqGfImoATraSdBoIpuyl+9js/zreG
 euT/MdDELgknspeGKlUZX0ViAq+3DtwE0iAxrhlRubyECGG/VuEZDOaBFOtL3N3wBh9G
 qypMelhNm9k7HM1es1YXWNL3EjmGnRKlxMK8w7snJgjnRN4her70BS+dcZ87mG6qoO70
 FduA==
X-Gm-Message-State: AOJu0Yz/EBfZxySJ9t744R6y9NPREb30lzMnuB9qcA8LBCBdjeFxyGOU
 sqsk2CXMopVbE6dQ4cKD+5/bWJGun58rLDueIVaanZ4rkU0/vZvNphTuw0dietNZAXjjPZvuJSA
 wLBUVw3Zy8dBZefpelYKFdq5xm1EFFdMnNXwaHw==
X-Gm-Gg: ASbGnctPbcMS6Z32WN36Rnj4FOAMlhbm2n+P+vmdTZ0uVsMQrOQHAo3fikCq92wxdoo
 zC2ha4u7XjrIToN7nuNm0Wyf7AYQyDOOcnYDdxYMaoQ9AY55dls8e063HTe8o6LftkB18mWUMk6
 a6CMdV7jLAse7y9/bRmPCBrbFNxdFB
X-Google-Smtp-Source: AGHT+IHuLo1FcqEF0bVf9qibUC4n13M6Vul6r5I7NVi2B7xgJiL2WuNi5j7Goj1X56cRGSqlyzIseV3ge8ShTSKJa6Y=
X-Received: by 2002:a05:6e02:11ab:b0:3ce:34fb:fdac with SMTP id
 e9e14a558f8ab-3d05a5a8481mr29754755ab.5.1738865175303; Thu, 06 Feb 2025
 10:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250201100300.2194018-1-ariel.otilibili@6wind.com>
 <20250201100300.2194018-3-ariel.otilibili@6wind.com>
 <CAFdtZiu9t6tzw=cZgN+B22DiC7eYbMx7hxmBzVbx9Mfz3XwMVQ@mail.gmail.com>
In-Reply-To: <CAFdtZiu9t6tzw=cZgN+B22DiC7eYbMx7hxmBzVbx9Mfz3XwMVQ@mail.gmail.com>
From: Ariel Otilibili <ariel.otilibili@6wind.com>
Date: Thu, 6 Feb 2025 19:06:04 +0100
X-Gm-Features: AWEUYZlWLFzhT4gY33Pg27-RsBsNZ5Rr0P9cNXIt6N7WOr9rdNzmi370EwiGo2g
Message-ID: <CAF1zDgZ18Ov5ADzcFLgZoQB5RMVd8w=8-KpHQV6bGSe_QX44bg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Maryam Tahhan <mtahhan@redhat.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Ciara Loftus <ciara.loftus@intel.com>
Content-Type: multipart/alternative; boundary="0000000000001644b7062d7d19a1"
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

--0000000000001644b7062d7d19a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maryam,

On Thu, Feb 6, 2025 at 2:09=E2=80=AFAM Maryam Tahhan <mtahhan@redhat.com> w=
rote:

>
>
> On Sat 1 Feb 2025, 10:03 Ariel Otilibili, <ariel.otilibili@6wind.com>
> wrote:
>
>> Both legs of the loop share the same logic: the common parts are about
>> reserving and filling both address and length into the description.
>>
>> This is moved into reserve_and_fill().
>>
>> Bugzilla ID: 1440
>> Suggested-by: Maryam Tahhan <mtahhan@redhat.com>
>> Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>
>> ---
>>  drivers/net/af_xdp/rte_eth_af_xdp.c | 62 ++++++++++++++++-------------
>>  1 file changed, 34 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c
>> b/drivers/net/af_xdp/rte_eth_af_xdp.c
>> index 092bcb73aa0a..840a12dbf508 100644
>> --- a/drivers/net/af_xdp/rte_eth_af_xdp.c
>> +++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
>> @@ -536,6 +536,31 @@ kick_tx(struct pkt_tx_queue *txq, struct
>> xsk_ring_cons *cq)
>>                 }
>>  }
>>
>> +static inline struct xdp_desc *
>> +reserve_and_fill(struct pkt_tx_queue *txq, struct rte_mbuf *mbuf,
>> +                struct xsk_umem_info *umem)
>> +{
>> +       struct xdp_desc *desc =3D NULL;
>> +       uint32_t *idx_tx =3D NULL;
>> +       uint64_t addr, offset;
>> +
>> +       if (!xsk_ring_prod__reserve(&txq->tx, 1, idx_tx))
>> +               goto out;
>> +
>> +       desc =3D xsk_ring_prod__tx_desc(&txq->tx, *idx_tx);
>> +       desc->len =3D mbuf->pkt_len;
>> +
>> +       addr =3D (uint64_t)mbuf - (uint64_t)umem->buffer
>> +               - umem->mb_pool->header_size;
>> +       offset =3D rte_pktmbuf_mtod(mbuf, uint64_t) - (uint64_t)mbuf
>> +               + umem->mb_pool->header_size;
>> +       offset =3D offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
>> +       desc->addr =3D addr | offset;
>> +
>> +out:
>> +       return desc;
>> +}
>> +
>>  #if defined(XDP_UMEM_UNALIGNED_CHUNK_FLAG)
>>  static uint16_t
>>  af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>> @@ -545,10 +570,8 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs,
>> uint16_t nb_pkts)
>>         struct rte_mbuf *mbuf;
>>         unsigned long tx_bytes =3D 0;
>>         int i;
>> -       uint32_t idx_tx;
>>         uint16_t count =3D 0;
>>         struct xdp_desc *desc;
>> -       uint64_t addr, offset;
>>         struct xsk_ring_cons *cq =3D &txq->pair->cq;
>>         uint32_t free_thresh =3D cq->size >> 1;
>>
>> @@ -559,21 +582,12 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs,
>> uint16_t nb_pkts)
>>                 mbuf =3D bufs[i];
>>
>>                 if (mbuf->pool =3D=3D umem->mb_pool) {
>> -                       if (!xsk_ring_prod__reserve(&txq->tx, 1,
>> &idx_tx)) {
>> +                       if (!(desc =3D reserve_and_fill(txq, mbuf, umem)=
)) {
>>                                 kick_tx(txq, cq);
>> -                               if (!xsk_ring_prod__reserve(&txq->tx, 1,
>> -                                                           &idx_tx))
>> +                               if (!(desc =3D reserve_and_fill(txq, mbu=
f,
>> umem)))
>>                                         goto out;
>>                         }
>> -                       desc =3D xsk_ring_prod__tx_desc(&txq->tx, idx_tx=
);
>> -                       desc->len =3D mbuf->pkt_len;
>> -                       addr =3D (uint64_t)mbuf - (uint64_t)umem->buffer=
 -
>> -                                       umem->mb_pool->header_size;
>> -                       offset =3D rte_pktmbuf_mtod(mbuf, uint64_t) -
>> -                                       (uint64_t)mbuf +
>> -                                       umem->mb_pool->header_size;
>> -                       offset =3D offset << XSK_UNALIGNED_BUF_OFFSET_SH=
IFT;
>> -                       desc->addr =3D addr | offset;
>> +
>>                         tx_bytes +=3D desc->len;
>>                         count++;
>>                 } else {
>> @@ -584,26 +598,18 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs,
>> uint16_t nb_pkts)
>>                         if (local_mbuf =3D=3D NULL)
>>                                 goto out;
>>
>> -                       if (!xsk_ring_prod__reserve(&txq->tx, 1,
>> &idx_tx)) {
>> +                       if (!(desc =3D reserve_and_fill(txq, local_mbuf,
>> umem))) {
>>                                 rte_pktmbuf_free(local_mbuf);
>>                                 goto out;
>>                         }
>>
>> -                       desc =3D xsk_ring_prod__tx_desc(&txq->tx, idx_tx=
);
>> -                       desc->len =3D mbuf->pkt_len;
>> -
>>
>
> So I think i spotted one issue, you might need override desc->len after
> the call to the reserve_and_fill function so as it's not taken supposed t=
o
> be from local_mbuf here.
>

You are right; I will do that.

>
> -                       addr =3D (uint64_t)local_mbuf -
>> (uint64_t)umem->buffer -
>> -                                       umem->mb_pool->header_size;
>> -                       offset =3D rte_pktmbuf_mtod(local_mbuf, uint64_t=
) -
>> -                                       (uint64_t)local_mbuf +
>> -                                       umem->mb_pool->header_size;
>> -                       pkt =3D xsk_umem__get_data(umem->buffer, addr +
>> offset);
>> -                       offset =3D offset << XSK_UNALIGNED_BUF_OFFSET_SH=
IFT;
>> -                       desc->addr =3D addr | offset;
>> +                       pkt =3D xsk_umem__get_data(umem->buffer,
>> +                                                (desc->addr & ~0xFFF)
>> +                                                + (desc->addr & 0xFFF))=
;
>>
>
> Would prefer to move this pkt assignment to reserve_and_fill()
> What if we passed a void **ppkt to reserve_and_fill()  then kept the
> original logic just wrapped in a NULL check?
>

It would look neater, indeed.

>
>  if (ppkt) {
>       *ppkt =3D xsk_umem__get_data(umem->buffer, addr + offset);
>     }
>
>
> Before the offset and desc->addr
>     offset =3D offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
>     desc->addr =3D addr | offset;
>
> WDYT?
>

I will; thanks for the proposal.

For me to sum up which changes are needed:

* change desc->len to local_buf
* move pkt initialization into reserve_and_fill
*  change idx_tx from uint32_t* to uint32_t (
https://inbox.dpdk.org/dev/CAF1zDgZgJZgWOeG=3DRAjicmGVt24PTtB9B0ukWH_RdE3oo=
eYPzA@mail.gmail.com/
)

Thanks again,
Ariel

>
>                         rte_memcpy(pkt, rte_pktmbuf_mtod(mbuf, void *),
>> -                                       desc->len);
>> -                       tx_bytes +=3D desc->len;
>> +                                  desc->len);
>>                         rte_pktmbuf_free(mbuf);
>> +                       tx_bytes +=3D desc->len;
>>                         count++;
>>                 }
>>         }
>> --
>> 2.30.2
>>
>>

--0000000000001644b7062d7d19a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Maryam,<br></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Th=
u, Feb 6, 2025 at 2:09=E2=80=AFAM Maryam Tahhan &lt;<a href=3D"mailto:mtahh=
an@redhat.com">mtahhan@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"auto"><div><br><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat 1 Feb 2025, 1=
0:03 Ariel Otilibili, &lt;<a href=3D"mailto:ariel.otilibili@6wind.com" targ=
et=3D"_blank">ariel.otilibili@6wind.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Both legs of the loop share the same=
 logic: the common parts are about<br>
reserving and filling both address and length into the description.<br>
<br>
This is moved into reserve_and_fill().<br>
<br>
Bugzilla ID: 1440<br>
Suggested-by: Maryam Tahhan &lt;<a href=3D"mailto:mtahhan@redhat.com" rel=
=3D"noreferrer" target=3D"_blank">mtahhan@redhat.com</a>&gt;<br>
Signed-off-by: Ariel Otilibili &lt;<a href=3D"mailto:ariel.otilibili@6wind.=
com" rel=3D"noreferrer" target=3D"_blank">ariel.otilibili@6wind.com</a>&gt;=
<br>
---<br>
=C2=A0drivers/net/af_xdp/rte_eth_af_xdp.c | 62 ++++++++++++++++------------=
-<br>
=C2=A01 file changed, 34 insertions(+), 28 deletions(-)<br>
<br>
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_e=
th_af_xdp.c<br>
index 092bcb73aa0a..840a12dbf508 100644<br>
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c<br>
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c<br>
@@ -536,6 +536,31 @@ kick_tx(struct pkt_tx_queue *txq, struct xsk_ring_cons=
 *cq)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
+static inline struct xdp_desc *<br>
+reserve_and_fill(struct pkt_tx_queue *txq, struct rte_mbuf *mbuf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct xsk_umem_in=
fo *umem)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct xdp_desc *desc =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *idx_tx =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t addr, offset;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!xsk_ring_prod__reserve(&amp;txq-&gt;tx, 1,=
 idx_tx))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0desc =3D xsk_ring_prod__tx_desc(&amp;txq-&gt;tx=
, *idx_tx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0desc-&gt;len =3D mbuf-&gt;pkt_len;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D (uint64_t)mbuf - (uint64_t)umem-&gt;bu=
ffer<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- umem-&gt;mb_pool-=
&gt;header_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D rte_pktmbuf_mtod(mbuf, uint64_t) - (=
uint64_t)mbuf<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ umem-&gt;mb_pool-=
&gt;header_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D offset &lt;&lt; XSK_UNALIGNED_BUF_OF=
FSET_SHIFT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0desc-&gt;addr =3D addr | offset;<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return desc;<br>
+}<br>
+<br>
=C2=A0#if defined(XDP_UMEM_UNALIGNED_CHUNK_FLAG)<br>
=C2=A0static uint16_t<br>
=C2=A0af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)<b=
r>
@@ -545,10 +570,8 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint=
16_t nb_pkts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mbuf *mbuf;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long tx_bytes =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t idx_tx;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t count =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct xdp_desc *desc;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t addr, offset;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct xsk_ring_cons *cq =3D &amp;txq-&gt;pair-=
&gt;cq;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t free_thresh =3D cq-&gt;size &gt;&gt; 1=
;<br>
<br>
@@ -559,21 +582,12 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uin=
t16_t nb_pkts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mbuf =3D bufs[i];<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mbuf-&gt;pool =
=3D=3D umem-&gt;mb_pool) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!xsk_ring_prod__reserve(&amp;txq-&gt;tx, 1, &amp;idx_tx)) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!(desc =3D reserve_and_fill(txq, mbuf, umem))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kick_tx(txq, cq);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!xsk_ring_prod__reserve(&amp;txq-=
&gt;tx, 1,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;idx_tx))=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(desc =3D reserve_and_fill(txq, =
mbuf, umem)))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0desc =3D xsk_ring_prod__tx_desc(&amp;txq-&gt;tx, idx_tx);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0desc-&gt;len =3D mbuf-&gt;pkt_len;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0addr =3D (uint64_t)mbuf - (uint64_t)umem-&gt;buffer -<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0umem-&gt;=
mb_pool-&gt;header_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0offset =3D rte_pktmbuf_mtod(mbuf, uint64_t) -<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t=
)mbuf +<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0umem-&gt;=
mb_pool-&gt;header_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0offset =3D offset &lt;&lt; XSK_UNALIGNED_BUF_OFFSET_SHIFT;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0desc-&gt;addr =3D addr | offset;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tx_bytes +=3D desc-&gt;len;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 count++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
@@ -584,26 +598,18 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uin=
t16_t nb_pkts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (local_mbuf =3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!xsk_ring_prod__reserve(&amp;txq-&gt;tx, 1, &amp;idx_tx)) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!(desc =3D reserve_and_fill(txq, local_mbuf, umem))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_pktmbuf_free(local_mbuf);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0desc =3D xsk_ring_prod__tx_desc(&amp;txq-&gt;tx, idx_tx);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0desc-&gt;len =3D mbuf-&gt;pkt_len;<br>
-<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>So I think i spotted one issue, you might need override desc-&gt;len after=
 the call to the reserve_and_fill function so as it&#39;s not taken suppose=
d to be from local_mbuf here.</div></div></blockquote><div><br></div><div>Y=
ou are right; I will do that. <br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"auto"><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0addr =3D (uint64_t)local_mbuf - (uint64_t)umem-&gt;buffer -<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0umem-&gt;=
mb_pool-&gt;header_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0offset =3D rte_pktmbuf_mtod(local_mbuf, uint64_t) -<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t=
)local_mbuf +<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0umem-&gt;=
mb_pool-&gt;header_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pkt =3D xsk_umem__get_data(umem-&gt;buffer, addr + offset);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0offset =3D offset &lt;&lt; XSK_UNALIGNED_BUF_OFFSET_SHIFT;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0desc-&gt;addr =3D addr | offset;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pkt =3D xsk_umem__get_data(umem-&gt;buffer,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (desc-&gt;addr &amp; ~0xFFF)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 + (desc-&gt;addr &amp; 0xFFF));<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Would prefer to move th=
is pkt assignment to reserve_and_fill()</div><div dir=3D"auto">What if we p=
assed a void **ppkt to reserve_and_fill()=C2=A0 then kept the original logi=
c just wrapped in a NULL check?</div></div></blockquote><div><br></div><div=
>It would look neater, indeed. <br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><div dir=3D"auto"><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div dir=3D"auto">=C2=A0if (ppkt) {</div><div dir=3D"auto">=C2=A0 =C2=
=A0 =C2=A0 *ppkt =3D xsk_umem__get_data(umem-&gt;buffer, addr + offset);</d=
iv><div dir=3D"auto">=C2=A0 =C2=A0 }</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Before the offset and desc-&gt;add=
r=C2=A0</div><div dir=3D"auto">=C2=A0 =C2=A0 offset =3D offset &lt;&lt; XSK=
_UNALIGNED_BUF_OFFSET_SHIFT;</div><div dir=3D"auto">=C2=A0 =C2=A0 desc-&gt;=
addr =3D addr | offset;</div><div dir=3D"auto"><br></div></div><div dir=3D"=
auto">WDYT?=C2=A0</div></div></blockquote><div><br></div><div>I will; thank=
s for the proposal.</div><div><br></div><div>For me to sum up which changes=
 are needed:</div><div><br></div><div>* change desc-&gt;len to local_buf</d=
iv><div>* move pkt initialization into reserve_and_fill</div><div>*=C2=A0 c=
hange idx_tx from uint32_t* to=C2=A0uint32_t (<a href=3D"https://inbox.dpdk=
.org/dev/CAF1zDgZgJZgWOeG=3DRAjicmGVt24PTtB9B0ukWH_RdE3ooeYPzA@mail.gmail.c=
om/">https://inbox.dpdk.org/dev/CAF1zDgZgJZgWOeG=3DRAjicmGVt24PTtB9B0ukWH_R=
dE3ooeYPzA@mail.gmail.com/</a>)</div><div><br></div><div>Thanks again,</div=
><div>Ariel<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"auto"><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"g=
mail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rte_memcpy(pkt, rte_pktmbuf_mtod(mbuf, void *),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0desc-&gt;=
len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tx_bytes +=3D desc-&gt;len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc-&gt;len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rte_pktmbuf_free(mbuf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tx_bytes +=3D desc-&gt;len;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 count++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-- <br>
2.30.2<br>
<br>
</blockquote></div></div></div>
</blockquote></div></div>

--0000000000001644b7062d7d19a1--
