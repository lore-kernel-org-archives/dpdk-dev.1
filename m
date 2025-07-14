Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160BAC83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 21:47:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD9E34021E;
	Mon, 14 Jul 2025 23:47:37 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 07E234013F
 for <dev@dpdk.org>; Mon, 14 Jul 2025 23:47:36 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b390d09e957so5076880a12.1
 for <dev@dpdk.org>; Mon, 14 Jul 2025 14:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752529655; x=1753134455; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0900GKe5YmErVXmOU3mfxyInBRHKyZ19zkMjkadu+Ug=;
 b=UYvmADueVKN0bCS6/JySKsEVApRF+x6bbkhdmS1Wj6eGBal+Wewx/x4tOgNMRMbnpZ
 sl1aYOl3nCVPI6BBR2WtayjI25lAdoGmI8DYQW3rYlOXJNrZy2JKW9tFxqiZY0XhRXvG
 Iap86Z7WNzYTD6f9Qgx+kHN/uW2081ujomk6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752529655; x=1753134455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0900GKe5YmErVXmOU3mfxyInBRHKyZ19zkMjkadu+Ug=;
 b=R89o7Xr6Wd8Tp2hCOdszpQFHmR51kSPQgi/Q1tpR7mNOs879PmhcHZBnGKS0Lkc16D
 ThAEaCAgCUQ7sdZ8WrfRwmPRKzuGPAlbHRCjc6I7ozjuc8iesmGFcgcMr7LHOajK2SNg
 s72d+B2mKxhFTNNWPnmKw5NeTGA+jsyQ0XmOEDZbzPlGqJolN4cbXKVPjwWMolCakv8A
 VvNGoJhAtS6PxvmsZ1XVhQiU7RRQvJR9lm9b+ZRGVq/JD7VGISKiOJmNpRlmhEfouwjO
 FErhWdbm7uxANPM3FM+UaEmtUUcqYuuajW/oKT9xjoJX023Qmh9LOTdOpsHgB4Db2XIp
 P+tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV83HO/RkD7t35LF73ZzFOQceBM3RSyrmamIvf3wVE7coPtq7jv1bRgyATLnyNUVzOdYSQ=@dpdk.org
X-Gm-Message-State: AOJu0YxvpGQlGOZbu/dDppXgzi93pqwtX3IzwFDtSsyXqOfIhAHcHhOj
 pih6scGCvorAEQBTsz0eV5mkuCD5ZuSPB0/+6dRrRXxDOl28O8niIVq0tOPoZPRE0GFuNJee1Tl
 FO+5WyeswDl/7MHDYdOhMei7FfUNqUyqzc63ZwsW6Jg==
X-Gm-Gg: ASbGncvdhvt7Q0TCW74VLXAj7bIECXv9rcyQ0KryPOjrgz6MoWPXP3+BZH3FhEbK0wb
 NezqVZ2fpLQvMI4vgTcLly12al8p6Wqj7XRowXvFNEvKliMTUJvWaJmVveDzsYkCYk0AahrpLvI
 3+3s4lIufDLu80Yj0BTDvuDnVjcBAngh0AXyHGyiXXxZxws19akjk+H/TpuDHhDukIKCHRLW6QG
 jpOW3GC24t6Qyfp9+G3/EdCBK9gNqkZ
X-Google-Smtp-Source: AGHT+IEDNTDGpKQblE3Wnz3sj4hMoCpXZTQsopAgFnLB+arKxnmj1eshO/BoZ9uVJGnmmh9ROYaHP6qyj2R5dMJ8trk=
X-Received: by 2002:a17:90b:4acf:b0:314:2a2e:9da9 with SMTP id
 98e67ed59e1d1-31c4f5922b7mr20212583a91.25.1752529654961; Mon, 14 Jul 2025
 14:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
In-Reply-To: <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 14 Jul 2025 17:41:45 -0400
X-Gm-Features: Ac12FXxwc6V-_fKpFvSM9rEqsJEs2yjvsFaOr0gUM4ezQj4wuftheXxO6pO011s
Message-ID: <CAJvnSUDD9EAknohiYXbD6SCDBgEBmghAXhcrmBqd0DCw3cKAkg@mail.gmail.com>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
To: Dean Marx <dmarx@iol.unh.edu>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 techboard@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000008af72f0639ea9b69"
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

--0000000000008af72f0639ea9b69
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 4:09=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> On Mon, Jul 14, 2025 at 9:30=E2=80=AFAM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The behaviour of VLAN tag stripping Rx offloads is unclear in DPDK, and
> > not very well documented. Even the documentation that does exist appear=
s
> > contradictory.
> >
> > For example, the doxygen docs for the mbuf flag
> > RTE_MBUF_F_RX_QINQ_STRIPPED says:
> >
> >   "If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPPE=
D
> >   is unset, only the outer VLAN is removed from packet data,..."
> >
> > but the docs for RTE_MBUF_F_RX_QINQ says:
> >
> >   "If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs
> >   headers have been stripped from mbuf data, ..."
> >
> > Without a good definition of what the correct behaviour is, it's not
> > possible to assess and ensure conformance across drivers. Update the
> > documentation for NIC features, ethdev and mbuf library to all report
> > the same information: that VLAN strip feature is stripping one flag, an=
d
> > QinQ strip feature is removing two.
>
> I'm working on testing QinQ/VLAN stripping features across PMDs, and
> so far I've found that our Intel devices are capable of QinQ
> stripping, while our Mellanox/Broadcom devices are not. When QinQ
> stripping is enabled on an Intel PMD, the test packet is received with
> its outer VLAN layer stripped, but the inner VLAN layer remains
> intact. Thus, the doxygen example is more accurate for what is
> currently supported. I'm also running some tests on VLAN stripping
> behavior, I'll update this thread with the results once these are
> finished.
>

Thanks for checking the test results on the Intel NICs. That's interesting
that the behavior (only outer tag stripped) differs from the description in
the patch. But, I guess this question will become irrelevant if QinQ strip
without VLAN strip will become disallowed at the ethdev layer. So problem
solved there I guess!

Otherwise, it sounds like there are basically 3 valid "strip" configs a
port can be set to.

1. No strip
2. VLAN Strip
3. VLAN Strip + QinQ strip

And then, as Morten points out, there are various packet profiles which we
can send through these 3 configurations for your testcases.

Single VLAN: Ether() / Dot1Q(vlan=3D100, type=3D0x8100) / IP(dst=3D"1.2.3.4=
") /
UDP(dport=3D1234, sport=3D4321)
Double VLAN: Ether() / Dot1Q(vlan=3D100, type=3D0x8100) / Dot1Q(vlan=3D200,
type=3D0x8100) / IP(dst=3D"1.2.3.4") / UDP(dport=3D1234, sport=3D4321)
Single 0x88a8 tag only: Ether() / Dot1Q(vlan=3D100,
type=3D0x88a8 / IP(dst=3D"1.2.3.4") / UDP(dport=3D1234, sport=3D4321)
Single VLAN + 1 0x88a8 tag: Ether() / Dot1Q(vlan=3D100, type=3D0x88a8)
/ Dot1Q(vlan=3D100, type=3D0x8100) / IP(dst=3D"1.2.3.4") / UDP(dport=3D1234=
,
sport=3D4321)

Dean I gotta run for now but tomorrow let's see if we can define the
expected behavior for the intersection of these various stripping option
and packet profiles and pseudo code out some testcases based on that.

--0000000000008af72f0639ea9b69
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 14,=
 2025 at 4:09=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu"=
>dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On Mon, Jul 14, 2025 at 9:30=E2=80=AFAM Bruce Richardson<=
br>
&lt;<a href=3D"mailto:bruce.richardson@intel.com" target=3D"_blank">bruce.r=
ichardson@intel.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The behaviour of VLAN tag stripping Rx offloads is unclear in DPDK, an=
d<br>
&gt; not very well documented. Even the documentation that does exist appea=
rs<br>
&gt; contradictory.<br>
&gt;<br>
&gt; For example, the doxygen docs for the mbuf flag<br>
&gt; RTE_MBUF_F_RX_QINQ_STRIPPED says:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0&quot;If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F=
_RX_VLAN_STRIPPED<br>
&gt;=C2=A0 =C2=A0is unset, only the outer VLAN is removed from packet data,=
...&quot;<br>
&gt;<br>
&gt; but the docs for RTE_MBUF_F_RX_QINQ says:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0&quot;If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also pres=
ent, both VLANs<br>
&gt;=C2=A0 =C2=A0headers have been stripped from mbuf data, ...&quot;<br>
&gt;<br>
&gt; Without a good definition of what the correct behaviour is, it&#39;s n=
ot<br>
&gt; possible to assess and ensure conformance across drivers. Update the<b=
r>
&gt; documentation for NIC features, ethdev and mbuf library to all report<=
br>
&gt; the same information: that VLAN strip feature is stripping one flag, a=
nd<br>
&gt; QinQ strip feature is removing two.<br>
<br>
I&#39;m working on testing QinQ/VLAN stripping features across PMDs, and<br=
>
so far I&#39;ve found that our Intel devices are capable of QinQ<br>
stripping, while our Mellanox/Broadcom devices are not. When QinQ<br>
stripping is enabled on an Intel PMD, the test packet is received with<br>
its outer VLAN layer stripped, but the inner VLAN layer remains<br>
intact. Thus, the doxygen example is more accurate for what is<br>
currently supported. I&#39;m also running some tests on VLAN stripping<br>
behavior, I&#39;ll update this thread with the results once these are<br>
finished.<br></blockquote><div><br></div><div>Thanks for checking the test =
results on the Intel NICs. That&#39;s interesting that the behavior (only o=
uter tag stripped) differs from the description in the patch. But, I guess =
this question will become irrelevant if QinQ strip without VLAN strip will =
become disallowed at the ethdev layer. So problem solved there I guess!</di=
v><div><br></div><div>Otherwise, it sounds like there are basically 3 valid=
 &quot;strip&quot; configs a port can be set to.=C2=A0</div><div><br></div>=
<div>1. No strip</div><div>2. VLAN Strip</div><div>3. VLAN Strip=C2=A0+ Qin=
Q strip</div><div><br></div><div>And then, as Morten points out, there are =
various packet profiles which we can send through these 3 configurations fo=
r your testcases.=C2=A0</div><div><br></div><div>Single VLAN: Ether() / Dot=
1Q(vlan=3D100, type=3D0x8100)=C2=A0/ IP(dst=3D&quot;1.2.3.4&quot;)=C2=A0/ U=
DP(dport=3D1234, sport=3D4321)</div><div>Double VLAN: Ether() / Dot1Q(vlan=
=3D100, type=3D0x8100)=C2=A0/ Dot1Q(vlan=3D200, type=3D0x8100)=C2=A0/ IP(ds=
t=3D&quot;1.2.3.4&quot;)=C2=A0/ UDP(dport=3D1234, sport=3D4321)</div><div>S=
ingle 0x88a8 tag only: Ether() / Dot1Q(vlan=3D100, type=3D0x88a8=C2=A0/=C2=
=A0IP(dst=3D&quot;1.2.3.4&quot;)=C2=A0/ UDP(dport=3D1234, sport=3D4321)</di=
v><div>Single VLAN=C2=A0+ 1 0x88a8 tag: Ether() / Dot1Q(vlan=3D100, type=3D=
0x88a8) /=C2=A0Dot1Q(vlan=3D100, type=3D0x8100) / IP(dst=3D&quot;1.2.3.4&qu=
ot;)=C2=A0/ UDP(dport=3D1234, sport=3D4321)</div><div><br></div><div>Dean I=
 gotta run for now but tomorrow let&#39;s see if we can define the expected=
 behavior for the intersection of these various stripping option and packet=
 profiles and pseudo code out some testcases based on that.</div><div><br><=
/div><div>=C2=A0</div></div></div>

--0000000000008af72f0639ea9b69--
