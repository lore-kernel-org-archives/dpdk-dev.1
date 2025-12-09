Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7D5D3B981
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 17:05:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 654F640689;
	Tue,  9 Dec 2025 18:05:32 +0100 (CET)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 187414067D
 for <dev@dpdk.org>; Tue,  9 Dec 2025 18:05:31 +0100 (CET)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4eddfb8c7f5so57805951cf.1
 for <dev@dpdk.org>; Tue, 09 Dec 2025 09:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765299930; x=1765904730; darn=dpdk.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NMcKvpK0I4T4ARkfypOE1qCB8SXt2sf9l/z3R0gokPg=;
 b=TSA0zpO49GyiJJENM1hwk/loaN7/DIt+2+h0X0pWW25gqa+lsbgNrDDPJj12YO6+aN
 qCppdunOkOITOwtv8ysipqIwZ5ihkCNpm8gO294CevofLXO9cKNUEwkNKw/rTqKklJh4
 C8Wc+l0j35s4j1NrC7E+CT8xDp2ISMbYYrb45/URK16qLby/Nr8i9YfK2IuV3DTNL6KC
 CdkIaml66+FwVbFtUHRLlEjjD7m8FVAW6yS74BdSp50XZh5MizrS4L8r9cxCD+HhLw/1
 kOPTpNfUgBtY3zrE2aOG5hsbPizEZA9P3yIoPCtzSiwfK4CgFdnQXnt8ezFPfXycAWGM
 fiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765299930; x=1765904730;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NMcKvpK0I4T4ARkfypOE1qCB8SXt2sf9l/z3R0gokPg=;
 b=scEcKzDxzQQuWy7vYrTotuFUKwZCOEVjkwR1dbSm5WV+8HKRDV7t4gkXdx551FY6t4
 aeYRXWOR0KA9BT9gQUe+rU9hvmPPeBi0IQaaGmTbuYOotRQ1bi1RKWmLgbsUl5KsgSdu
 OUfaaDkIsz5qHTmwx/guUIl8tLwJnIAWwGtn6w7GNJLcBM6URfsLAcvHW1Q/tB5tkNz2
 PbGDtuBhHnIHW2WH3w2joKdvQNDvNUAAn0okYP0Xt06u39zNLJvqN7hj7G+OmT6GnxEh
 nJMh/gL6QXKd/O5reWo1OBUba7OP/g03duzKJM13I38vPhiJ/dENRUv1YUDK/88IP3bs
 vMfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdE3MOTIRW5KsqFctM9xAPmIzVqo0M/7cCDoVPD/6JhiVdgIgz+GzleHecikB5iAojAVk=@dpdk.org
X-Gm-Message-State: AOJu0YxmmCN/8K/a6PBgvFk2jNt635WkU/cQq1KWRZ4ND2rySG8yPb+Z
 Ycc3saUwxZJye+UFl/t+9+9/TwC19cS4GvrqUsk0xsJk3N1gsjeRoDsezcb24YYBU7Jo0TwdCxX
 3czanZpzlv9+8OAhx6Rea1EECanzzfGfmt83Z
X-Gm-Gg: ASbGncu9PMXAFIY79QJSgSlBO8aw5XLFK9D3DxSjszEfxlWu/KNWfhWV0bR/4aY7pjH
 VmHJN2b4BBar+TT00LQqpRU2vIPjdOR3e522FsfC3vWbjrZuqNyUO4tozMF0f7jU0ZKzLlcUdhc
 1NScJBsWVRPdzhCodxNSaPRzTFYqzR4MgJ8T8jQdxgAs1ScWAStEFyUhuBGUonqx/B/mpUWwLSu
 0R1x+cHKLS7v1Z6VNz+6VANZlkVl8xzIENeCmkq2sNm0RyS+qn7/UQsVHmZXtnlmnkSdQtv
X-Google-Smtp-Source: AGHT+IHKsIuh9/uv7cUDK5qIyCcj8MNx6u8c6ee6oW1xuEq2v80TN4L25GR1IvuJLVspANoEpcDOBB5MQ+f8YZ+tCKE=
X-Received: by 2002:a05:622a:908:b0:4ee:2508:3934 with SMTP id
 d75a77b69052e-4f03fef2c4amr205675341cf.67.1765299928556; Tue, 09 Dec 2025
 09:05:28 -0800 (PST)
MIME-Version: 1.0
References: <CAFLDJDprPRB8mjybypwuvHOEp+MfXjSK6W1YJD=Db2CURUhLNA@mail.gmail.com>
In-Reply-To: <CAFLDJDprPRB8mjybypwuvHOEp+MfXjSK6W1YJD=Db2CURUhLNA@mail.gmail.com>
From: narsimharaj pentam <pnarsimharaj@gmail.com>
Date: Tue, 9 Dec 2025 22:35:17 +0530
X-Gm-Features: AQt7F2oflhN4XHQdPjK4r5GmgFr6iKhhFl9eZRFKicSvGUtQ1r5YE4Q6OWcejdE
Message-ID: <CAFLDJDoVgNj9JjUbDEUP=gaXOMKS2jYiYVFFPULWOthfPqzwFg@mail.gmail.com>
Subject: Re: Indirect mbuf handling
To: users@dpdk.org, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000029e8bb064587eb4a"
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

--00000000000029e8bb064587eb4a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Added dev group.

On Tue, Dec 9, 2025 at 10:11=E2=80=AFPM narsimharaj pentam <pnarsimharaj@gm=
ail.com>
wrote:

> Hi
>
> I have a query related to ip fragmentation handling in DPDK.
>
> The DPDK application is trying to send a larger packet than the configure=
d
> MTU on the interface, before sending the packet to the  i40e PMD the pack=
et
> will
> undergo fragmentation . The DPDK library function
> *"rte_ipv4_fragment_packet"* is used for fragmentation. Function
> *rte_ipv4_fragment_packet* will create
> direct and indirect mbuf's  for a fragment , *the indirect buffers will
> have reference to the mbuf of the actual packet (zero copy).*
>
> The application will call function rte_eth_tx_burst to transmit fragments
> , which internally invokes *i40e_xmit_pkts *, the question here  is when
> should main application
> mbuf should be freed , can It be freed immediately  after i40e_xmit_pkts
> returns success, not sure because the mbuf's are queued up in software ri=
ng
> before actual transmit,
> I am worried about the fragments holding references to the main
> application buffer.
>
> Thanks.
>
> BR
> Narsimha
>

--00000000000029e8bb064587eb4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div>Added dev group.</div><br>=
<div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"=
gmail_attr">On Tue, Dec 9, 2025 at 10:11=E2=80=AFPM narsimharaj pentam &lt;=
<a href=3D"mailto:pnarsimharaj@gmail.com">pnarsimharaj@gmail.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D=
"ltr"><div>Hi=C2=A0</div><div><br></div><div>I have a query related to ip f=
ragmentation handling in=C2=A0DPDK.</div><div><br></div><div>The DPDK appli=
cation is trying to send a larger packet than the configured MTU on the int=
erface, before sending the packet to the =C2=A0i40e PMD the packet will</di=
v>undergo fragmentation . The DPDK library function <b>&quot;rte_ipv4_fragm=
ent_packet&quot;</b> is used for fragmentation. Function <b>rte_ipv4_fragme=
nt_packet</b> will create<br>direct and indirect mbuf&#39;s=C2=A0 for a fra=
gment , <b>the indirect buffers will have reference to the mbuf of the actu=
al packet (zero copy).</b><br><br>The application will call function rte_et=
h_tx_burst to transmit fragments , which internally invokes <b>i40e_xmit_pk=
ts </b>, the question here=C2=A0 is when should main application<br>mbuf sh=
ould be freed , can It be freed immediately=C2=A0 after i40e_xmit_pkts retu=
rns success, not sure because the mbuf&#39;s are queued up in software ring=
 before actual transmit,=C2=A0<div>I am worried about the fragments holding=
 references to the main application buffer.</div><div><br></div><div>Thanks=
.</div><div><br></div><div>BR</div><div>Narsimha</div></div>
</blockquote></div></div>

--00000000000029e8bb064587eb4a--
