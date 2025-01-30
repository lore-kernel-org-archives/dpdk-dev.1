Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDA9C0218A
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jan 2025 23:06:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B3B740DCE;
	Fri, 31 Jan 2025 00:06:57 +0100 (CET)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com
 [209.85.166.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3F81A40281
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:56 +0100 (CET)
Received: by mail-il1-f169.google.com with SMTP id
 e9e14a558f8ab-3a8160382d4so3556635ab.0
 for <dev@dpdk.org>; Thu, 30 Jan 2025 15:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738278415; x=1738883215; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8zLqPUFFZ0m3gxRqlfSBKr8QTLct2PwroMLnfwDKRv8=;
 b=isbeY4CK7PB7snC5gcsAumhhUl2BDAeEbtMfpahIZ0wl8zIFPUwxYlCJb0MnmdHTs3
 MyReJL1GVorUnv1YnNS5MNJ65jHxrHj+2Z9lH+eiDx55cZptBli7ru/FDF9Kx7DLQkXY
 6y0iky1lKORlii7P/7WpH0fHp0f/0ND0dylXM5W0YTcr4GL0UaKFtEecWYUwDkL9ZLbh
 TIhXouAO7tUOasHycpAXqlY/Ex5MObmiFovIGY+Kvlh8T1Cn0fnwyD/jxU7OogiLpmSf
 PJs018MA12uWPLJQkYDKHilIyM6K+s8zipNO7UFrSnQS827Zn3rWy1/T8oumju5jasJ6
 UlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738278415; x=1738883215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8zLqPUFFZ0m3gxRqlfSBKr8QTLct2PwroMLnfwDKRv8=;
 b=KBgUwZwYVgs2N6rUHwGDaim7hM6SeUlcovmOKRG1u0XZD6DTEatgajAXIC35nywzai
 NCyLBtw6myTt6nF9bRR1Je50Iz1/A9uxO5C7eSXr/tjFqk9gGTNZXe1CCmYVPlXRP49C
 c+xMv2g4PoPOvIJbBl8LtQej1Q3NWJDQ/HV498bqLqGQ23lNLYlrA3sMsVjTEEvEqjyx
 WKTpdUXX7loRThpf48zVap/PfXDEFVeY3Pl6Jp/42jxXPdWhtgZCoNwVctI31HojzKCu
 WiF1z/1KONmOpFRYPptjPYL059+O519KAOnqsg+TM25NjuP1Bp/zFbd0lndrjgTFNtRC
 HQFg==
X-Gm-Message-State: AOJu0Yy3eg6nopNg0h68SFjUtBGtT90xOxs6ZvNJC2sxdX1nrcsPj6y0
 YCZ3S9xiB/Ufr0LO0SLbneHUVU/Y+YdrOHMiAzMWy6FpGjEYtM+Ms95Mb874KzEExaJMM+kt0sp
 0er7La4U+k8A6Ewjog4hcE72ce9zSToJGzsWeew==
X-Gm-Gg: ASbGncuioRF56wLbJLmA+oaEq9ThlEg6afjVa509vwgxI2EfWpY3gaVsoa00KnfKBQk
 j0ULjPB/T1TzsfAcy4BtuBigh6q0rsjcN/3y02txDo6nqwBT7Leczm7zecBUy2xEqEy4CcXPw2x
 d1m8PGMrGbrpYQbpuYA09pNnA3ZkGJ
X-Google-Smtp-Source: AGHT+IH1ugkUZ1pmcLZ2lPw/sveWPu+I7qB2rlCVcg2YNdMjWJKWdLrWIebJGV5tl9JZUkTBdpxJpQwxZo7sMElzc6s=
X-Received: by 2002:a05:6e02:12c8:b0:3ce:7d8f:3d75 with SMTP id
 e9e14a558f8ab-3cffe37c153mr82812245ab.1.1738278415378; Thu, 30 Jan 2025
 15:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250128231152.249497-1-ariel.otilibili@6wind.com>
 <20250128231152.249497-3-ariel.otilibili@6wind.com>
 <f067b5ea-ade9-4b2d-8a66-9f8446138bb5@redhat.com>
In-Reply-To: <f067b5ea-ade9-4b2d-8a66-9f8446138bb5@redhat.com>
From: Ariel Otilibili <ariel.otilibili@6wind.com>
Date: Fri, 31 Jan 2025 00:06:44 +0100
X-Gm-Features: AWEUYZm2AXBWXaCIaYEvmR6NzR5U6i3oEwb5H0RT6PFofbnWNx7xERnmRrInwIQ
Message-ID: <CAF1zDgbFkCA9vT=m_cBLM_zHQDL_GVQAceRCMxX+ATOE_7-RpA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] net/af_xdp: Refactor af_xdp_tx_zc()
To: Maryam Tahhan <mtahhan@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Ciara Loftus <ciara.loftus@intel.com>
Content-Type: multipart/alternative; boundary="0000000000007847f0062cf47baf"
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

--0000000000007847f0062cf47baf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Maryam,

On Wed, Jan 29, 2025 at 6:58=E2=80=AFPM Maryam Tahhan <mtahhan@redhat.com> =
wrote:

> > +static struct rte_mbuf *
> > +maybe_kick_tx(struct pkt_tx_queue *txq, uint32_t *idx_tx, struct
> rte_mbuf *mbuf)
> > +{
> > +     struct rte_mbuf *ret =3D mbuf;
> > +
> > +     if (!xsk_ring_prod__reserve(&txq->tx, 1, idx_tx)) {
> > +             kick_tx(txq, &txq->pair->cq);
> > +             if (!xsk_ring_prod__reserve(&txq->tx, 1, idx_tx))
> > +                     ret =3D NULL;
> > +     }
> > +
> > +     return ret;
> > +}
>
>
> [MT] I don't see why we are passing in mbuf here?
>
 My aim was to use the output of maybe_kick_tx() for the if statement on
local_buf: the true leg would copy mbuf into local_mbuf, and the false
would create a fresh local_mbuf

> > +static void
> > +maybe_cpy_pkt(bool is_mbuf_equal, struct xsk_umem_info *umem,
> > +           uint64_t addr_plus_offset, struct rte_mbuf *mbuf,
> > +           struct xdp_desc *desc)
> > +{
> > +     void *pkt;
> > +
> > +     if(is_mbuf_equal)
> > +             goto out;
> > +
> > +     pkt =3D xsk_umem__get_data(umem->buffer, addr_plus_offset);
> > +     rte_memcpy(pkt, rte_pktmbuf_mtod(mbuf, void *), desc->len);
> > +     rte_pktmbuf_free(mbuf);
> > +
> > +out:
> > +     return;
> > +}
>
>
> [MT] does this really need to be an inline function? it wasn't common
> code between the blocks?
>
In order for the next statements to just fall through till the exit. The
loop would have read as such:

1. Some boiler plate to check if mbuf is equal to umem; and the creation of
local_mbuf accordingly
2. If local_mbuf is null, goto exit.
3. Else, update addr, offset, and description

> Firstly thank you for your efforts to clean up the code. I believe a
> simpler cleanup approach would better balance readability +
> maintainability. This approach would focus on eliminating the repeated
> code in both branches of the conditional block. For me the main
> repetition between the branches is the code that reserves and fills the
> descriptor info, Please find an example below...
>
Thanks to you, I do appreciate your honest feedback. From what I
understand, you would like to take the filling of addr, offset, and desc
off from af_xdp_tx_zc(), but keep its core logic.

I wanted the boiler plate to be into separate functions, so one could read
through the subsequent statements. So we could avoid the cascade of if
statements.

>
> Note: The following is all untested code (don't even know if it
> compiles) it's just to give an idea around the cleanup I had in mind:
>
The code did compile on the go, that was pretty neat. I cleared out few
warnings, and pushed out a new version
https://inbox.dpdk.org/dev/20250130221853.789366-3-ariel.otilibili@6wind.co=
m/

>
> Please let me know your thoughts, and I=E2=80=99d be happy to discuss fur=
ther
>
> I improved on the snippets your proposal. It has fewer lines, so fewer
changes.

What matters to me, is that the series be merged.

Have a good day,
Ariel

--0000000000007847f0062cf47baf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello Maryam,<br></div><br><div class=3D"=
gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Wed, Jan 29, 2025 at 6:58=E2=80=AFPM Maryam Tahhan &lt;<a href=3D"mailto:m=
tahhan@redhat.com">mtahhan@redhat.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
&gt; +static struct rte_mbuf *<br>
&gt; +maybe_kick_tx(struct pkt_tx_queue *txq, uint32_t *idx_tx, struct rte_=
mbuf *mbuf)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rte_mbuf *ret =3D mbuf;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!xsk_ring_prod__reserve(&amp;txq-&gt;tx, 1, i=
dx_tx)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kick_tx(txq, &amp;txq=
-&gt;pair-&gt;cq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!xsk_ring_prod__r=
eserve(&amp;txq-&gt;tx, 1, idx_tx))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
<br>
<br>
[MT] I don&#39;t see why we are passing in mbuf here?<br></blockquote><div>=
=C2=A0My aim was to use the output of maybe_kick_tx() for the if statement =
on local_buf: the true leg would copy mbuf into local_mbuf, and the false w=
ould create a fresh local_mbuf<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">

&gt; +static void<br>
&gt; +maybe_cpy_pkt(bool is_mbuf_equal, struct xsk_umem_info *umem,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t addr_plus_offset, s=
truct rte_mbuf *mbuf,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct xdp_desc *desc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void *pkt;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if(is_mbuf_equal)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pkt =3D xsk_umem__get_data(umem-&gt;buffer, addr_=
plus_offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rte_memcpy(pkt, rte_pktmbuf_mtod(mbuf, void *), d=
esc-&gt;len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rte_pktmbuf_free(mbuf);<br>
&gt; +<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +}<br>
<br>
<br>
[MT] does this really need to be an inline function? it wasn&#39;t common <=
br>
code between the blocks?<br></blockquote><div>In order for the next stateme=
nts to just fall through till the exit. The loop would have read as such:</=
div><div><br></div><div>1. Some boiler plate to check if mbuf is equal to u=
mem; and the creation of local_mbuf accordingly<br></div><div>2. If local_m=
buf is null, goto exit.</div><div>3. Else, update addr, offset, and descrip=
tion</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">


Firstly thank you for your efforts to clean up the code. I believe a <br>
simpler cleanup approach would better balance readability + <br>
maintainability. This approach would focus on eliminating the repeated <br>
code in both branches of the conditional block. For me the main <br>
repetition between the branches is the code that reserves and fills the <br=
>
descriptor info, Please find an example below...<br></blockquote><div>Thank=
s to you, I do appreciate your honest feedback. From what I understand, you=
 would like to take the filling of addr, offset, and desc off from af_xdp_t=
x_zc(), but keep its core logic.</div><div><br></div><div>I wanted the boil=
er plate to be into separate functions, so one could read through the subse=
quent statements. So we could avoid the cascade of if statements.<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Note: The following is all untested code (don&#39;t even know if it <br>
compiles) it&#39;s just to give an idea around the cleanup I had in mind:<b=
r></blockquote><div>The code did compile on the go, that was pretty neat. I=
 cleared out few warnings, and pushed out a new version <br></div><div><a h=
ref=3D"https://inbox.dpdk.org/dev/20250130221853.789366-3-ariel.otilibili@6=
wind.com/">https://inbox.dpdk.org/dev/20250130221853.789366-3-ariel.otilibi=
li@6wind.com/</a></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Please let me know your thoughts, and I=E2=80=99d be happy to discuss furth=
er<br>
<br></blockquote><div>I improved on the snippets your proposal. It has fewe=
r lines, so fewer changes.</div><div><br></div><div>What matters to me, is =
that the series be merged.</div><div><br></div><div>Have a good day,</div><=
div>Ariel<br></div></div></div>

--0000000000007847f0062cf47baf--
