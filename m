Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2528BCAC5A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 12:36:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 837E34065F;
	Thu, 18 Sep 2025 14:36:26 +0200 (CEST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id 26C7F40288
 for <dev@dpdk.org>; Thu, 18 Sep 2025 14:36:25 +0200 (CEST)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b2400dcc55eso7289266b.0
 for <dev@dpdk.org>; Thu, 18 Sep 2025 05:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758198985; x=1758803785; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fEELsLufYCXPZnmpxh2qditXbYoZOmCvwOR1IEkTGWc=;
 b=PlYwt1GKY7BJBHPz7iSzqs/ObhcExRPoWK3QF88Jz/8IVj2tvAgEKCUKs45QYAnt9f
 BFxHB+uIGV0iRG6MhxaemWSFaMEwJeNRTezFEgfUxClUerDU7kjvxdVsKQ4ndMlrJ1iV
 xLq4Den/kRcGcXOzRahKs2Qdkdb/Yz/yIcXOzIz4YggLwHWFBLxGe49VrdQgS7ilIHX3
 mgoqe8TmLYJ7hHvLL0pzIeb3yeB8gDFG8zaDaqrlnq1lfBICD4RX8EybJmoOeeDOV3iM
 O9sitKXeRJ4uuTNwUR59zGZUqMH30TQ6MVC94zrX3aZ92xnFdpOtqv4x48Fv1sxrVBfJ
 6o5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758198985; x=1758803785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fEELsLufYCXPZnmpxh2qditXbYoZOmCvwOR1IEkTGWc=;
 b=V8w5TOxOenmBTALTAcDlnVq7XmqVckAb0XyQfTm7YQmKo1aIeGgPlba6a3SYyDgQbE
 JW7Nu+Ukg5LA3FlAeG4HGLTqGRbcUDQAGqwH4p3WdDeEUqhhx+9fgyv8Sj42fLB6zHPJ
 0vrilM+O447jbJrsgjaaRigVx88MkX7XxJd/vdwAKTg5+H8pERXlBAb9TsG4zsypI5Qc
 qL7nxgXXAFjxoRgnplY6Ec8/IY+Ag4zk5+X3ITQYVEPQ89CFYqajkQ4KwODqFtLwVkv9
 L6cUbKbscUDZOvICP6512HuJYDel7QRtj1BCXX6wgamBIU1mBwkCrMZkKrUsSjV8qpRv
 +cHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk2OVQA6GD7w2YqcNnOAha0lclQBrh8Eocs0YqlCc4WPl2UmkR9voO9cFvhWmScp9am90=@dpdk.org
X-Gm-Message-State: AOJu0YzAgaFpePazwDxw0PTAWnCW6tFHNbwuxjaRw3cqQ4kfsXjaSnaZ
 BhPqPwGIHqZTCnsRNruZ/UMaAgxV+1oWvAGG259gyfCu0b9rzLv4g6NcuWbBEcIsYlsRXs/ay6D
 jmCwZhwVEV+pMUvUPQ8NrCVF++fB7+o4=
X-Gm-Gg: ASbGncvpFDmEn6f/6+OgBGF6mFH6k+zIeOg4ntF4n97fhM6RL8ScC36rxTtalucqP1Y
 loNMve5E+IzKpDoZxAxSJ5/6vgnwtttCZcGmr/+gBcUr0ffiXQrXQ1inesfEeMdm2A1BwAg5+O/
 79tQdgg9/jFDR8E89Di6xB7GUihb6UT8Xui40gSxGycWek7MI71raNPKAakWd+o/d6wSA5kfqGt
 tjJ3l6X0QP0rQlLLneQZ7D2
X-Google-Smtp-Source: AGHT+IHY0JdZFJHgxo2dmDSCqVDiQQjaUK/8+0VY+xYb8hnAEq/oHtJ5up0Q4CLYNZ5lhoIVCj0uldmzA2zSsY3DSLc=
X-Received: by 2002:a17:906:d555:b0:b04:1457:99 with SMTP id
 a640c23a62f3a-b1bb2261be5mr593545766b.14.1758198984472; Thu, 18 Sep 2025
 05:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250902104451.81876-1-tathagat.dpdk@gmail.com>
In-Reply-To: <20250902104451.81876-1-tathagat.dpdk@gmail.com>
From: kumaraparameshwaran rathinavel <kumaraparamesh92@gmail.com>
Date: Thu, 18 Sep 2025 18:06:11 +0530
X-Gm-Features: AS18NWB_92qAVGxtvs-_bdF3VGcpPEpGvmf1KvEWBa87Z3R9Sg7UMHq4mUN6ojs
Message-ID: <CANxNyatw+4568dh6Spf2TpXzPvesV01rJKiBvH6GyKMnGMBkQA@mail.gmail.com>
Subject: Re: [PATCH] gro: fix payload corruption in coalescing packets
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>, 
 kumaraparameshwaran rathinavel <kumaraparamesh92@gmail.com>
Cc: hujiayu.hu@foxmail.com, dev@dpdk.org, stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000e9ff22063f12991d"
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

--000000000000e9ff22063f12991d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed by : @kumaraparameshwaran rathinavel <kumaraparamesh92@gmail.com>

On Tue, Sep 2, 2025 at 4:14=E2=80=AFPM Tathagat Priyadarshi <tathagat.dpdk@=
gmail.com>
wrote:

> In the current implementation when cmp is larger than 0,
> the new packet is appended to the original packet. However
> the code is operating on the trailing packet to update the tcp flags
> which ends up corrupting the payload of the trailing packets.
>
> Fixes: 547f29435769 ("gro: fix reordering of packets")
> Cc: stable@dpdk.org
>
> Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
> ---
>  lib/gro/gro_tcp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/gro/gro_tcp.h b/lib/gro/gro_tcp.h
> index e9be7b95d1..43383e47e0 100644
> --- a/lib/gro/gro_tcp.h
> +++ b/lib/gro/gro_tcp.h
> @@ -133,7 +133,7 @@ merge_two_tcp_packets(struct gro_tcp_item *item,
>         pkt_head->nb_segs +=3D pkt_tail->nb_segs;
>         pkt_head->pkt_len +=3D pkt_tail->pkt_len;
>         if (tcp_flags !=3D RTE_TCP_ACK_FLAG) {
> -               tcp_hdr =3D rte_pktmbuf_mtod_offset(pkt, struct rte_tcp_h=
dr
> *,
> +               tcp_hdr =3D rte_pktmbuf_mtod_offset(pkt_head, struct
> rte_tcp_hdr *,
>                                                 l2_offset +
> pkt_head->l2_len + pkt_head->l3_len);
>                 tcp_hdr->tcp_flags |=3D tcp_flags;
>         }
> --
> 2.34.1
>
>

--000000000000e9ff22063f12991d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed by :=C2=A0<a class=3D"gmail_plusreply" id=3D"plus=
ReplyChip-5" href=3D"mailto:kumaraparamesh92@gmail.com" tabindex=3D"-1">@ku=
maraparameshwaran rathinavel</a>=C2=A0</div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 2, =
2025 at 4:14=E2=80=AFPM Tathagat Priyadarshi &lt;<a href=3D"mailto:tathagat=
.dpdk@gmail.com">tathagat.dpdk@gmail.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">In the current implementation when =
cmp is larger than 0,<br>
the new packet is appended to the original packet. However<br>
the code is operating on the trailing packet to update the tcp flags<br>
which ends up corrupting the payload of the trailing packets.<br>
<br>
Fixes: 547f29435769 (&quot;gro: fix reordering of packets&quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Tathagat Priyadarshi &lt;<a href=3D"mailto:tathagat.dpdk@gma=
il.com" target=3D"_blank">tathagat.dpdk@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/gro/gro_tcp.h | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/lib/gro/gro_tcp.h b/lib/gro/gro_tcp.h<br>
index e9be7b95d1..43383e47e0 100644<br>
--- a/lib/gro/gro_tcp.h<br>
+++ b/lib/gro/gro_tcp.h<br>
@@ -133,7 +133,7 @@ merge_two_tcp_packets(struct gro_tcp_item *item,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt_head-&gt;nb_segs +=3D pkt_tail-&gt;nb_segs;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt_head-&gt;pkt_len +=3D pkt_tail-&gt;pkt_len;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tcp_flags !=3D RTE_TCP_ACK_FLAG) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcp_hdr =3D rte_pkt=
mbuf_mtod_offset(pkt, struct rte_tcp_hdr *,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcp_hdr =3D rte_pkt=
mbuf_mtod_offset(pkt_head, struct rte_tcp_hdr *,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 l2_offset + pkt_head-&gt;l2_len + pkt_head-&gt;l3_len)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcp_hdr-&gt;tcp_fla=
gs |=3D tcp_flags;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000e9ff22063f12991d--
