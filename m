Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC14C02192
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 02:09:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1E5B4068A;
	Thu,  6 Feb 2025 03:09:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4C92D402F1
 for <dev@dpdk.org>; Thu,  6 Feb 2025 03:09:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738807792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zXVLJMlhYbug+zGuyvJSWIvlFI444EdTQuZ6DEtian0=;
 b=YJme0/d/W/F85tErG0FplIMnCbxC9ZjOqARTbtJl8DKrZ99r1yM6KvLCgdbScp6UuhCYVH
 Iu7U/f9b8dbZo9jgBXHIX8YlZWH9GnGsYqQDiwN7A1iGXgg4H3LFzZN1l8jr58c56NwSTd
 cUb69v134AlfqOncWT0G6+9jlFq+wKQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-Xr8M1N-WPl2lijdohe1tLQ-1; Wed, 05 Feb 2025 21:09:49 -0500
X-MC-Unique: Xr8M1N-WPl2lijdohe1tLQ-1
X-Mimecast-MFC-AGG-ID: Xr8M1N-WPl2lijdohe1tLQ
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6f46fb73061so5477997b3.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 18:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738807789; x=1739412589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zXVLJMlhYbug+zGuyvJSWIvlFI444EdTQuZ6DEtian0=;
 b=pzP7ahI3Fuq+jUQPOrxDlrnji8HbsIdY0PwZQwI56EM7dFhUi0Wx0nuheTcNMnWfZz
 XkwECxRXoZ7vT1067bqSxzfXzw7J2TRuYKtaFrC+r4ooXCc/VQDpQA/vRbewAjc3uhbe
 IyzNIi/UB2bjEsO76Eeu48yNQq9SRb7npR8+K/4W1Ri5Kd9K2H+vb/57Jc0FUzLPhVRz
 ZbU/rH0BpodBchbbGL6jUf8USrmOkli+hqF8SI2m2USZB76+qR7CnZG5Sq9rgo3NRYKD
 n58lDTVSOBz9hLuk9n8u+rFciEfxuqFGvV0bUKEwKnmwpztTc3xufjDZusJJ9U4RlRXE
 l6iw==
X-Gm-Message-State: AOJu0Yw+7YiIqJdSJR58f6v3/IDYvl7KtvetcHAKbP9icdAwy7MGZiSW
 isxZtPrZdZbmuIRu+bR5Cf2rnCfNB6HaWs6lVux59qYbG6uVTal4xhsK3VqGULtYPXxhYAy/EiE
 SqFknuyX8ukkd5mPjNMB2cLlMKyPKL9gbFxwxdPR3dwH3GtkhTDEbL12I+ycklAeR66rEnurhI5
 6KF26l3pYRcR5EMu4=
X-Gm-Gg: ASbGnctDPB0nwlh7CMDtLBHh7HYeMBMH7/XsFfzjHXM42Q9pRAdK5+ZGViyNMXmc8Y1
 +tZfpjpKll0yZ46qmWXtdv/BIyednrmU9cebgSH48Ys82SovJbDB8C9H7n6zmTqAWP6hh44DE+V
 9xZAkRc0K9DDgoomy/BC2V
X-Received: by 2002:a05:690c:700f:b0:6f0:3f7:ab1e with SMTP id
 00721157ae682-6f99a68bbe3mr17059067b3.16.1738807789003; 
 Wed, 05 Feb 2025 18:09:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFB/KqLt7yp75BJ23KLQkzDNTo3ixtHEvQRt1bMq0piqoZy1FhbyLIk7Uea3+YwCTaVDlQc8t0kFIAVPUmoAkI=
X-Received: by 2002:a05:690c:700f:b0:6f0:3f7:ab1e with SMTP id
 00721157ae682-6f99a68bbe3mr17058887b3.16.1738807788700; Wed, 05 Feb 2025
 18:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250201100300.2194018-1-ariel.otilibili@6wind.com>
 <20250201100300.2194018-3-ariel.otilibili@6wind.com>
In-Reply-To: <20250201100300.2194018-3-ariel.otilibili@6wind.com>
From: Maryam Tahhan <mtahhan@redhat.com>
Date: Thu, 6 Feb 2025 02:08:16 +0000
X-Gm-Features: AWEUYZm7WZcGH61OLiBMzbe8KeB7FFMRwAMbZhYIeEqWziCvb_0c0xpzEHWShSs
Message-ID: <CAFdtZitaNGhC5Q10ATNa7xXX1JbuWob=YzrcWmq8LTz+qjiu4A@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Ciara Loftus <ciara.loftus@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -APbdiQ2Z5oDJ7mkVjtB39wDWgUL1KU4w52whLxLo9k_1738807789
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000941f0b062d6fbc5b"
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

--000000000000941f0b062d6fbc5b
Content-Type: text/plain; charset="UTF-8"

On Sat 1 Feb 2025, 10:03 Ariel Otilibili, <ariel.otilibili@6wind.com> wrote:

> Both legs of the loop share the same logic: the common parts are about
> reserving and filling both address and length into the description.
>
> This is moved into reserve_and_fill().
>
> Bugzilla ID: 1440
> Suggested-by: Maryam Tahhan <mtahhan@redhat.com>
> Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>
> ---
>  drivers/net/af_xdp/rte_eth_af_xdp.c | 62 ++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c
> b/drivers/net/af_xdp/rte_eth_af_xdp.c
> index 092bcb73aa0a..840a12dbf508 100644
> --- a/drivers/net/af_xdp/rte_eth_af_xdp.c
> +++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
> @@ -536,6 +536,31 @@ kick_tx(struct pkt_tx_queue *txq, struct
> xsk_ring_cons *cq)
>                 }
>  }
>
> +static inline struct xdp_desc *
> +reserve_and_fill(struct pkt_tx_queue *txq, struct rte_mbuf *mbuf,
> +                struct xsk_umem_info *umem)
> +{
> +       struct xdp_desc *desc = NULL;
> +       uint32_t *idx_tx = NULL;
>

Took me a while to spot this but this needs to be a uint32_t not a pointer
to uint32_t, because xsk_ring_prod__reserve() does not allocate memory for
idx_tx it just expects to dereference a pointer to a uint32_t to store the
index...

+       uint64_t addr, offset;
> +
> +       if (!xsk_ring_prod__reserve(&txq->tx, 1, idx_tx))
> +               goto out;
> +
> +       desc = xsk_ring_prod__tx_desc(&txq->tx, *idx_tx);
> +       desc->len = mbuf->pkt_len;
> +
> +       addr = (uint64_t)mbuf - (uint64_t)umem->buffer
> +               - umem->mb_pool->header_size;
> +       offset = rte_pktmbuf_mtod(mbuf, uint64_t) - (uint64_t)mbuf
> +               + umem->mb_pool->header_size;
> +       offset = offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
> +       desc->addr = addr | offset;
> +
> +out:
> +       return desc;
> +}
> +
> <snip>

--000000000000941f0b062d6fbc5b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sat 1 Feb 2025, 10:03 Ariel O=
tilibili, &lt;<a href=3D"mailto:ariel.otilibili@6wind.com">ariel.otilibili@=
6wind.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Both leg=
s of the loop share the same logic: the common parts are about<br>
reserving and filling both address and length into the description.<br>
<br>
This is moved into reserve_and_fill().<br>
<br>
Bugzilla ID: 1440<br>
Suggested-by: Maryam Tahhan &lt;<a href=3D"mailto:mtahhan@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">mtahhan@redhat.com</a>&gt;<br>
Signed-off-by: Ariel Otilibili &lt;<a href=3D"mailto:ariel.otilibili@6wind.=
com" target=3D"_blank" rel=3D"noreferrer">ariel.otilibili@6wind.com</a>&gt;=
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *idx_tx =3D NULL;<br></blockquote></di=
v></div><div dir=3D"auto"><br></div><div dir=3D"auto">Took me a while to sp=
ot this but this needs to be a uint32_t not a pointer to uint32_t, because =
xsk_ring_prod__reserve() does not allocate memory for idx_tx it just expect=
s to dereference a pointer to a uint32_t to store the index...</div><div di=
r=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quot=
e_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
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

--000000000000941f0b062d6fbc5b--

