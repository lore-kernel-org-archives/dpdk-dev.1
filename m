Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28510C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 17:56:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C76AD402BC;
	Thu,  6 Feb 2025 18:56:22 +0100 (CET)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com
 [209.85.166.169])
 by mails.dpdk.org (Postfix) with ESMTP id 701D84026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 18:56:21 +0100 (CET)
Received: by mail-il1-f169.google.com with SMTP id
 e9e14a558f8ab-3d04d767d3aso9770415ab.2
 for <dev@dpdk.org>; Thu, 06 Feb 2025 09:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738864580; x=1739469380; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UvxZxivncBueIxHdasICpkShHGNyF22oVr/HMCzx1tA=;
 b=IcQqsuo2rZ+0J9junuvNSvqIx4DZAke8NV8ttJeQalQ1qnHtpw4xJ3LlTONVjuHp19
 8U5LaXY/9exaWLMLnzIS6Do7Sl00sh2eD6mklcvOwgj+hrhJBRb01kEjATelA9qR2I44
 3oDvLPQz0GvrXddf6TWYIunfmUGmTf9w/wMjK7+kuvJ4+nd1CU/Vw3Sl/eStGAi6GrwK
 Kxba5/3kLZu56W29fiDO1Vg7NAtLD5rAQ0c5j18jjv+M668bZExLEoEy7z0G+HJXGaiu
 Y9eA9KOHfpb5aY4bYHLyuGd1QqDKbzPOnzXxXhRVXLvOgEufrAAvhtGg4atM+rySePS0
 MmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738864580; x=1739469380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UvxZxivncBueIxHdasICpkShHGNyF22oVr/HMCzx1tA=;
 b=kvtZFocaBKWHGydrgIwoGd7uI5SYLYGyywXpAhDhonzgJFXugt5KdDxYH4yiHtXd2E
 1EgdG2PA863RbMaDP2SlYk9vyR1/oZ9OCo676EjU2B1Mfg+ZDkzefWm5f5tSrho8byc3
 g4WjIwgAP7xWHXboWMYSfU9zPcXaUKXG/GniK5VJdM9JEOJYKFp40XquzHcmFXyT8my0
 8rAeLtknQZ/2qRKNBr3JO9cDRNUQBIG80IfWlB86NX9L1mspGAFk972QcKDLT9kn8CCn
 FwXbecWefwD6v4WdFSnm+YHYN4Z0VrIeTyNZnIj+zUXpIRkLFV4x40uDTul1w1uPqA6j
 mt8g==
X-Gm-Message-State: AOJu0YwEHOJtL1fu9zGSonG2nLzcn9/gk0PsaGpaJolF9lFwEwJqYitc
 G61n198pvRrs8YP26thQtw1jDB2U6IF9Oxw0xPDC/9c/ofzXnLXNsynzAa0P+kqfrAgAld//1T/
 ngzyk3Y2+Ks/TmWPrt8FJcY9tv5Erc4dHRBMOqg==
X-Gm-Gg: ASbGncuv59DxiRotrpuLNQoh3cP15HXZ/6PSF/URbVBIirZrRsw/tUEB4jdSK4FQ7C7
 l8uYrl1tA5fgau4AX6S1RNGe7q1v3wn06wQrp8jzco33+b0KZ76Nj6xaa3djQ4o2IBr0EVeOBOT
 avDtVayHxM3JiHV0cBdENEFTGmhLys
X-Google-Smtp-Source: AGHT+IFbSvFng7wdYqW2Pv0S1IKckoK7QWQKlgbZEoeOWh4fH2eSheTGCRa7pm/yxFEROi7/mlmybtpPDT2Suy8LQUY=
X-Received: by 2002:a05:6e02:12e8:b0:3d0:2477:83ec with SMTP id
 e9e14a558f8ab-3d04f917cbdmr58042865ab.14.1738864580652; Thu, 06 Feb 2025
 09:56:20 -0800 (PST)
MIME-Version: 1.0
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250201100300.2194018-1-ariel.otilibili@6wind.com>
 <20250201100300.2194018-3-ariel.otilibili@6wind.com>
 <CAFdtZitaNGhC5Q10ATNa7xXX1JbuWob=YzrcWmq8LTz+qjiu4A@mail.gmail.com>
In-Reply-To: <CAFdtZitaNGhC5Q10ATNa7xXX1JbuWob=YzrcWmq8LTz+qjiu4A@mail.gmail.com>
From: Ariel Otilibili <ariel.otilibili@6wind.com>
Date: Thu, 6 Feb 2025 18:56:09 +0100
X-Gm-Features: AWEUYZnMFyThafupN6QAceXOxoiGX4A3uXyKHhcqaUsGMmZyWpzs0agXv7SDyks
Message-ID: <CAF1zDgZgJZgWOeG=RAjicmGVt24PTtB9B0ukWH_RdE3ooeYPzA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Maryam Tahhan <mtahhan@redhat.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Ciara Loftus <ciara.loftus@intel.com>
Content-Type: multipart/alternative; boundary="000000000000a49359062d7cf567"
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

--000000000000a49359062d7cf567
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maryam,

On Thu, Feb 6, 2025 at 3:09=E2=80=AFAM Maryam Tahhan <mtahhan@redhat.com> w=
rote:

>
>
> On Sat 1 Feb 2025, 10:03 Ariel Otilibili, <ariel.otilibili@6wind.com>
> wrote:
>
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
>>
>
> Took me a while to spot this but this needs to be a uint32_t not a pointe=
r
> to uint32_t, because xsk_ring_prod__reserve() does not allocate memory fo=
r
> idx_tx it just expects to dereference a pointer to a uint32_t to store th=
e
> index...
>

Only now could I answer back; sorry the late response. And thanks for your
thorough investigation.

I didn't get the chance to use *testpmd;* which arguments did you pass?

I ran a scan-build while compiling, as well as a compilation with sanitized
flags. And I saw no error in af_xdp source files.

meson --wipe build -Db_sanitize=3Daddress
ninja -C build 2>&1 san_`date -Iseconds`.log
ninja -C build 2>&1 | tee --append san_`date -Iseconds`.log
ninja -C build scan-build 2>&1 | tee --append san_`date -Iseconds`.log

How did you spot the error?

>
> +       uint64_t addr, offset;
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
>> <snip>
>
>

--000000000000a49359062d7cf567
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Maryam,<br></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Th=
u, Feb 6, 2025 at 3:09=E2=80=AFAM Maryam Tahhan &lt;<a href=3D"mailto:mtahh=
an@redhat.com">mtahhan@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"auto"><div><br><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat 1 Feb 2025, 1=
0:03 Ariel Otilibili, &lt;<a href=3D"mailto:ariel.otilibili@6wind.com" targ=
et=3D"_blank">ariel.otilibili@6wind.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">diff --git a/drivers/net/af_xdp/rte_=
eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *idx_tx =3D NULL;<br></blockquote></di=
v></div><div dir=3D"auto"><br></div><div dir=3D"auto">Took me a while to sp=
ot this but this needs to be a uint32_t not a pointer to uint32_t, because =
xsk_ring_prod__reserve() does not allocate memory for idx_tx it just expect=
s to dereference a pointer to a uint32_t to store the index...</div></div><=
/blockquote><div><br></div><div>Only now could I answer back; sorry the lat=
e response.=C2=A0And thanks for your thorough investigation.</div><div><br>=
</div><div>I didn&#39;t get the chance to use <i>testpmd;</i> which argumen=
ts did you pass?<br></div><div><br></div><div>I ran a scan-build while comp=
iling, as well as a compilation with sanitized flags. And I saw no error in=
 af_xdp source files.</div><div><br></div><div>meson --wipe build -Db_sanit=
ize=3Daddress<br>ninja -C build 2&gt;&amp;1 san_`date -Iseconds`.log<br>nin=
ja -C build 2&gt;&amp;1 | tee --append san_`date -Iseconds`.log<br>ninja -C=
 build scan-build 2&gt;&amp;1 | tee --append san_`date -Iseconds`.log=C2=A0=
</div><div><br></div><div>How did you spot the error?</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div dir=3D"auto"><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
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
+<br>&lt;snip&gt;</blockquote></div></div></div>
</blockquote></div></div>

--000000000000a49359062d7cf567--
