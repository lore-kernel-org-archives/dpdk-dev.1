Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B8ED3C52D
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 11:42:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 857A34028F;
	Wed, 10 Dec 2025 12:42:08 +0100 (CET)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 049A840285
 for <dev@dpdk.org>; Wed, 10 Dec 2025 12:42:07 +0100 (CET)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8823dfa84c5so81502296d6.3
 for <dev@dpdk.org>; Wed, 10 Dec 2025 03:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765366927; x=1765971727; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XWI9f7EU0zQyDcKhNg2yvrVkbAkMoJEEH6H33ZcrREY=;
 b=EoyhRCI4MM4iVgvst7g1tMiU99V7b5uRQxbAYtl9dWiYwxC5OOoTdW1ujumE+03igB
 7dqjfBDmZ8FDwIfCVPr3PmxvdGAsi/Prqg7ddbwkhVLf+f/cvnAa4M0HWhjGaRyduqol
 49wD1uG6X746S7RJKIhGJJMCfeDK+afa1BaWRBD4pY2IhhOFllYhcbxJDxg9eG/2EoPc
 o+V62ge+VtmiQS8PYhSjhz7Y6AYIjXGwQl6AdW7330gqeD5yC7Uho6YRHIfVfAlFLyrX
 wa0Z9jay/FoILzaaiYl79aj//JtI/Xvqvs3+SyHR6EGWQlUtUwzvon/VlcFC7BdCCAQh
 2rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765366927; x=1765971727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWI9f7EU0zQyDcKhNg2yvrVkbAkMoJEEH6H33ZcrREY=;
 b=YMAj6Smx6M2xaFdUz9u+tGHDUtETfiot8sXQnXFdf8uzatrgKlrNIxmKJZb3GndrHc
 Qur+TeRZYFZxYcv0LZBSpHKRigcFQmhHT1aBNoepqyK7VZS+wKaWze2uLAzJLWFVWOyM
 U4Mb2JjnCCTbEvMmHeXSR+/kV/qwsS2wi3BWzTFD7l5eIPPe8ePs7mgoyKQjuIwa4wBw
 r+0w9AuelmNDZ+SyMYsV4x9VtM65XfbOQMx4XXpRDbCJ9Y6oHzesgleYU+v34J0rFWv2
 NboP6c0/7AD2BRtKvCNqPvzAW/zR1xyuTEE7b+CRoh+3sXoXhBEFPWmPotzBDvRZ97wo
 2BCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7BNIOBvL9/jolWKxaYRZ201OfxZkwIbZPe4YkH6YgTVS6NyR5o0aKkkcWY35qWS9MMrE=@dpdk.org
X-Gm-Message-State: AOJu0YzTpVjkSUQjxUb0dZwlytsH+9ihwH28A+fKfbw/hJYyElx2iPOp
 TpinsGn2eN0K4PXe7wTWARmJppnIFom+I/16e+amB5g2oBJQov+1E+OfjFWA1arwxzbgcfZVvrS
 7dUxkdy/JKdWhJSohyMsJwiFz9gG0rZGRa76Y
X-Gm-Gg: ASbGncvKdCn1Emzq2xxsgJojwnWavrBWB7OyoYqQxIaghx9CItTu4hDFS4/rEv/D0Rp
 xRtNeJYBTUeEv+soMFDvQ32JcLiNP7LaGnGhXVH/zuqXRVTn2tLNjB5uKs1lQ/ZuFtFDFH/du0e
 N6CX9Uo2YEeaUPme19nkhl1t7gfgItgy4KbB5rVFh9iUGen8nUfJ28njrDdiyVe8KmaE20wLYn4
 L4zATGmagf2GXTxzn9eJ2lGa5Xvvk2dzd6lEPGi6NEBhQeUovGTvgalLdEeB2dpxo355yDM
X-Google-Smtp-Source: AGHT+IE9ctFBGlSSEO9yjTwm1Ik1+8bE6pLeQ6U157tXEBYE//qZRTTLU0nQQDfnU6hXJZ+5c+mjQrcRr0dkAy988vk=
X-Received: by 2002:a05:622a:6207:b0:4ed:5f45:448a with SMTP id
 d75a77b69052e-4f1b1a43e23mr24427161cf.6.1765366927219; Wed, 10 Dec 2025
 03:42:07 -0800 (PST)
MIME-Version: 1.0
References: <CAFLDJDprPRB8mjybypwuvHOEp+MfXjSK6W1YJD=Db2CURUhLNA@mail.gmail.com>
 <CAFLDJDoVgNj9JjUbDEUP=gaXOMKS2jYiYVFFPULWOthfPqzwFg@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655D0@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655D0@smartserver.smartshare.dk>
From: narsimharaj pentam <pnarsimharaj@gmail.com>
Date: Wed, 10 Dec 2025 17:11:55 +0530
X-Gm-Features: AQt7F2qFwa8Fb3H_R8URabXXKla_cLq9KDhhgXpf2Dy9gzsF3rR_xMREII9NIbA
Message-ID: <CAFLDJDqCwM9RJNO0Pvu3MHPo3XD50hbbrrOXST3NbdHa8JwRBg@mail.gmail.com>
Subject: Re: Indirect mbuf handling
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: users@dpdk.org, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000098606506459784b9"
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

--00000000000098606506459784b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your response, got it.

BR
Narsimha

On Wed, Dec 10, 2025 at 3:14=E2=80=AFPM Morten Br=C3=B8rup <mb@smartsharesy=
stems.com>
wrote:

> > From: narsimharaj pentam [mailto:pnarsimharaj@gmail.com]
> > Sent: Tuesday, 9 December 2025 18.05
> >
> > Added dev group.
> >
> > On Tue, Dec 9, 2025 at 10:11=E2=80=AFPM narsimharaj pentam <
> pnarsimharaj@gmail.com> wrote:
> > Hi
> >
> > I have a query related to ip fragmentation handling in DPDK.
> >
> > The DPDK application is trying to send a larger packet than the
> configured MTU on the interface, before sending the packet to the  i40e P=
MD
> the packet will
> > undergo fragmentation . The DPDK library function
> "rte_ipv4_fragment_packet" is used for fragmentation. Function
> rte_ipv4_fragment_packet will create
> > direct and indirect mbuf's  for a fragment , the indirect buffers will
> have reference to the mbuf of the actual packet (zero copy).
> >
> > The application will call function rte_eth_tx_burst to transmit
> fragments , which internally invokes i40e_xmit_pkts , the question here  =
is
> when should main application
> > mbuf should be freed , can It be freed immediately  after i40e_xmit_pkt=
s
> returns success, not sure because the mbuf's are queued up in software ri=
ng
> before actual transmit,
> > I am worried about the fragments holding references to the main
> application buffer.
>
> The original packet can be freed immediately when then fragments have bee=
n
> created.
>
> This is what the fragmentation example does:
>
> https://elixir.bootlin.com/dpdk/v25.11/source/examples/ip_fragmentation/m=
ain.c#L289
>
> This is what happens:
> The original packet has a reference counter (which was incremented for
> each of the indirect mbufs referring to it), so freeing it at that point
> doesn't put it back in the pool.
> When the last of the indirect mbufs is freed (by the driver called by
> rte_eth_tx_burst()), the original packet's reference counter reaches zero=
,
> and then the original mbuf is put back in the pool.
>
> >
> > Thanks.
> >
> > BR
> > Narsimha
>
>

--00000000000098606506459784b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for your response, got it.</div><div><br></div=
>BR<div>Narsimha</div><div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 10, 2025 at 3:14=E2=
=80=AFPM Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb@smartsharesystems.com"=
>mb@smartsharesystems.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">&gt; From: narsimharaj pentam [mailto:<a href=3D"m=
ailto:pnarsimharaj@gmail.com" target=3D"_blank">pnarsimharaj@gmail.com</a>]=
 <br>
&gt; Sent: Tuesday, 9 December 2025 18.05<br>
&gt; <br>
&gt; Added dev group.<br>
&gt; <br>
&gt; On Tue, Dec 9, 2025 at 10:11=E2=80=AFPM narsimharaj pentam &lt;<a href=
=3D"mailto:pnarsimharaj@gmail.com" target=3D"_blank">pnarsimharaj@gmail.com=
</a>&gt; wrote:<br>
&gt; Hi <br>
&gt; <br>
&gt; I have a query related to ip fragmentation handling in DPDK.<br>
&gt; <br>
&gt; The DPDK application is trying to send a larger packet than the config=
ured MTU on the interface, before sending the packet to the=C2=A0 i40e PMD =
the packet will<br>
&gt; undergo fragmentation . The DPDK library function &quot;rte_ipv4_fragm=
ent_packet&quot; is used for fragmentation. Function rte_ipv4_fragment_pack=
et will create<br>
&gt; direct and indirect mbuf&#39;s=C2=A0 for a fragment , the indirect buf=
fers will have reference to the mbuf of the actual packet (zero copy).<br>
&gt; <br>
&gt; The application will call function rte_eth_tx_burst to transmit fragme=
nts , which internally invokes i40e_xmit_pkts , the question here=C2=A0 is =
when should main application<br>
&gt; mbuf should be freed , can It be freed immediately=C2=A0 after i40e_xm=
it_pkts returns success, not sure because the mbuf&#39;s are queued up in s=
oftware ring before actual transmit, <br>
&gt; I am worried about the fragments holding references to the main applic=
ation buffer.<br>
<br>
The original packet can be freed immediately when then fragments have been =
created.<br>
<br>
This is what the fragmentation example does:<br>
<a href=3D"https://elixir.bootlin.com/dpdk/v25.11/source/examples/ip_fragme=
ntation/main.c#L289" rel=3D"noreferrer" target=3D"_blank">https://elixir.bo=
otlin.com/dpdk/v25.11/source/examples/ip_fragmentation/main.c#L289</a><br>
<br>
This is what happens:<br>
The original packet has a reference counter (which was incremented for each=
 of the indirect mbufs referring to it), so freeing it at that point doesn&=
#39;t put it back in the pool.<br>
When the last of the indirect mbufs is freed (by the driver called by rte_e=
th_tx_burst()), the original packet&#39;s reference counter reaches zero, a=
nd then the original mbuf is put back in the pool.<br>
<br>
&gt; <br>
&gt; Thanks.<br>
&gt; <br>
&gt; BR<br>
&gt; Narsimha<br>
<br>
</blockquote></div></div></div>

--00000000000098606506459784b9--
