Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025AF6072208
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qUi3tDX8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBECF402E3;
	Mon,  2 Nov 2026 17:26:37 +0100 (CET)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50])
 by mails.dpdk.org (Postfix) with ESMTPS id 079B14028D
 for <dev@dpdk.org>; Mon,  2 Nov 2026 17:26:35 +0100 (CET)
Received: by mail-vs1-f50.google.com with SMTP id
 ada2fe7eead31-7cb6dc850c7so736120137.0
 for <dev@dpdk.org>; Mon, 02 Nov 2026 08:26:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793636794; cv=none;
 d=google.com; s=arc-20260327;
 b=jm47L+GZ42+LLtrK/jkSgagaiFxjK6fbgbj9Tlxw0B2uD9V/skYGkWZkObXoKAILQJ
 vjsaBP1kGKxgwJHq6enwDp+5e0DbmwRP+DtZ6hyph6fW4Usy4X7gqcx1VIxDT9eiYdut
 Rh21Wrw3BoOsbewOu6KxiljtXJSB5g4wIWgHrXpsING64GHF/XAZpXVhCYU3MSc5X7o/
 cKu8N8FE+FFIUvs9l/eE61DcDraj7HMVNQvjnmIGgJTbYo3S2iPooTb7igyH33GT1tcF
 ABvJ693onen477Snft2+Qbsc4OwyL1JUisbnd+On4aI4eCK1BGYmCE7AjithBfxcHJxM
 5icw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UJdtZeDzyD74l5RyxzOseiEAaGngpZKjTVyBHkE4nuU=;
 fh=nH8RhrhNzfSaQKhsN8myeyQ6TL8yGGUAJGHYwHec1e8=;
 b=Bxrv+7/WsrDCUocANLzoyZP84vct+RgUw9DXAFCDd6+//ThOfPr5Say+4LWKIMsZkv
 3YeqvBPgnhQVzN/ygNwNi96IJ5qETeGsDRn2IFsgYqd2+np/AY5WCYtaQgbo60gPGyFh
 QcKLIVX4LE2xTonuF18tkxGUZNGadj05U2PviSx3X6J1EkQxaz3GBnPOzVnXBQJIWdCm
 f06WzjmBsWTbn/0xixmrvAmglG37cbbxRnv2TabX/I9fQBmAa/DeqIyCVpuwXj0rPp/r
 hT3esai0BPdPMjXwVp8ljQ+cKbLLGt/JzLeD48jNjtqS5t4p+jF9HOpRa7Xn+U3DdIQ3
 KloQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793636794;
 x=1794241594; darn=dpdk.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UJdtZeDzyD74l5RyxzOseiEAaGngpZKjTVyBHkE4nuU=;
 b=qUi3tDX8sHRfReyisYinbFJmK4411VlA15rj/BqZDgZfrtsXU2jIwANJfWix1oM+7K
 P5u2AGfe85TYYa8W8FgrHU13MElqRdTufNo5PRjPDKtLKYABEtdDlBYjCnJF+GQv2KPa
 z1NjqI3Mi9fFgONyukjltbvb7wDCVsTOfqZTDSLk5ZtydGiJy6obqReUkjqEYAeQtD4Y
 nNfL9OuaHXrIg5OZQ+ZyDZyzmj2LXCgDgwNWqzYGUIslnLYFWYJ+E9vdOHQEjDwXC6Rq
 hTkIYw7ddDLCCAVsgiqS6jYp0fhHKWIBvjCDhkCs213wt2dynWpF/9lyKJm/WwKIZHbc
 infw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793636794; x=1794241594;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UJdtZeDzyD74l5RyxzOseiEAaGngpZKjTVyBHkE4nuU=;
 b=04Ub7fErY9bOBJUoAdpQ8jDSzNaZqWGSucN9NheEwWMr7MxLHUf74GS1Nah3sjo2bX
 fyfK55NhT9QAG0vgDtcPHRSuGKxfC0d2PaSkdtd6A/y+h4zZr0PWPbh+7TryygRnn41X
 I1F3uuaGpTJMuPK5yJkryAzgLP29xgyEL5SMLsRxc/DmM+TOyqB8pkZ0XGJvooZHZt72
 kEx/JXY34FKF5x9kQAJxCa8LTV2tBBxzsKYbr9MpDXbSM6nw1i6ExlyL2nvwbnY4Zq7B
 LPxazThHTLPKuwF0M6e6zOcyGm+3TpK/Dp883kCTGSuV4skYI/EjFNn9TC5lO8G9Mu7Y
 IG+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz56Kke8yYyGdZAaEFKjo9UbWDKFhsvqYw6aKoT+UpmqcsmK5/mYh3Nfv1jp2Jg6JhN8lg=@dpdk.org
X-Gm-Message-State: APuU4Z9a8pMKVlvmWrnAdlFddPuxbBf+jbn0RuZyTJBczlVh6ZkIgYpH
 LgUvOySoYfBh5kYN+Gje89NsciRJlWx/kRqCa9FHq1Ebis7AeKYh4aFJCtPix3yLr2LKbOlAffh
 c8LzPYHWWJ81ewkdsmW8VZu7WTDIs5gBwmTcNgCehgg==
X-Gm-Gg: AYBFou1KHHAUxLqj6Kz1zGCtjMvFseAdr8R0yw/eCtDOG1oEJ5bZ1IkMwFoSMxPrZnz
 wDlJOribpZDHLRsgm1SJrwirkyNOuhJdmbijPMBwVCa30xKpuwdjvSF89gI6o4vCt+MyVPnHTez
 kLnaFfxICC7H7QPHa0xGXHgi4x7Igs/51YLiark9f6sEacgtl4DSD2T+qC7sWdpgKBuQ0wBJ9uC
 m/8H8VTBPRwGO/QF+lieTXEYN1QwpYmWg09/PRZM5H/o7lRDvRoxyjM6TL8mT4UpY0Gc8WG/XAV
 mNYn0yoTYgDC5pTz6WhrZ7Sg0QJh3jg5la+xVjY89ekbb3ugbcStiKbZ2J2OHLOSpoOn2756vuG
 zVJYAKiwH+Z8zw+einjWqRn+GJodEDU2deHav
X-Received: by 2002:a05:6102:5809:b0:7ae:c2ca:8e1 with SMTP id
 ada2fe7eead31-7d0725528ccmr4103754137.11.1793636793868; Mon, 02 Nov 2026
 08:26:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030132616.2066712-1-bruce.richardson@intel.com>
 <IA4PR11MB927804496D3ED9C0A512C97F8E6A2@IA4PR11MB9278.namprd11.prod.outlook.com>
 <auiuHAy8DjGUbaXm@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <auiuHAy8DjGUbaXm@bricha3-mobl1.ger.corp.intel.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 2 Nov 2026 17:26:24 +0100
X-Gm-Features: AclHuK8f3oejGc4UwqsdQLitLctJn8yhUiB4tYX5zWa5KyXdK2x5a3j7sihKbzc
Message-ID: <CAOaVG15Ft8dr43T+NOoiLLQOa+4HNsg+SJmAJj08+uZUPzq70A@mail.gmail.com>
Subject: Re: [PATCH] net/ice: add explicit control of link auto-negotiation
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: "Loftus, Ciara" <ciara.loftus@intel.com>, dev <dev@dpdk.org>, 
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Type: multipart/alternative; boundary="000000000000f476e8065f4d9b7b"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000f476e8065f4d9b7b
Content-Type: text/plain; charset="UTF-8"

why is auto negotiation disable a devarg rather than extending relevant
part of ethdev? my opinion is every time a devarg like this gets added it
means the ethdev abstraction is the real issue

On Mon, Nov 2, 2026, 16:37 Bruce Richardson <bruce.richardson@intel.com>
wrote:

> On Mon, Nov 02, 2026 at 10:55:43AM +0000, Loftus, Ciara wrote:
> > > Subject: [PATCH] net/ice: add explicit control of link auto-negotiation
> > >
> > > When selecting a fixed speed of the link, whether or not
> > > autonegotiation (e.g. AN Clause 37, etc.), needs to be enabled depends
> > > on the peer link. While commit 3dc2933866d9 ("net/ice: disable link
> > > negotiation for fixed speed selection") would allow link setup when the
> > > remote side also has a fixed link without AN37 auto-negotiation, it
> > > causes the link to flap up and down when e.g. two ports are connected
> > > back to back and only one is set to a fixed speed.
> > >
> > > Support both scenarios of auto-negotiation supported or unsupported on
> > > the remote end by adding an explicit driver option for disabling
> > > auto-negotiation when a fixed speed is selected. If no fixed speed
> > > setting, then new option does nothing.
> > >
> > > Fixes: 3dc2933866d9 ("net/ice: disable link negotiation for fixed speed
> > > selection")
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >  doc/guides/nics/ice.rst                | 10 ++++++++++
> > >  doc/guides/rel_notes/release_26_11.rst |  2 ++
> > >  drivers/net/intel/ice/ice_ethdev.c     | 12 +++++++++++-
> > >  drivers/net/intel/ice/ice_ethdev.h     |  1 +
> > >  4 files changed, 24 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> > > index ca3a94655b..af36341c9a 100644
> > > --- a/doc/guides/nics/ice.rst
> > > +++ b/doc/guides/nics/ice.rst
> > > @@ -107,6 +107,16 @@ Configuration
> > >  Runtime Configuration
> > >  ~~~~~~~~~~~~~~~~~~~~~
> > >
> > > +``auto_neg_disable`` (default ``0``)
> > > +   Control hardware link negotiation when a fixed speed is requested
> with
> > > ``RTE_ETH_LINK_SPEED_FIXED``.
> > > +   By default, the firmware's negotiation settings are preserved,
> > > +   allowing a fixed-speed link to use negotiation such as Clause 37
> when
> > > required by its peer.
> > > +   Set ``auto_neg_disable=1`` to disable Clause 28, Clause 37 and
> Clause 73
> > > negotiation.
> > > +   This option has no effect when automatic speed selection is
> requested.
> > > +   For example::
> > > +
> > > +      -a 80:00.0,auto_neg_disable=1
> > > +
> >
> > The approach looks good to me.
> > Something my AI review flagged was the setting of "link.link_autoneg"
> > in ice_link_update() - your patch doesn't update that setting, and it's
> still
> > just based off the dev_conf.link_speeds value, and doesn't take into
> account
> > the value of the devarg (unlike ice_apply_link_speed() which accounts for
> > both). Perhaps it's not necessary, just something to check.
> > Once that is addressed or ruled out:
> >
> > Acked-by: Ciara Loftus <ciara.loftus@intel.com>
>
> Yes, good catch. That is fixed in v2, but I've dropped your ack as some of
> the logic has been moved to a subfunction to avoid copy-pasting too much.
>

--000000000000f476e8065f4d9b7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">why is auto negotiation disable a devarg rather than exte=
nding relevant part of ethdev? my opinion is every time a devarg like this =
gets added it means the ethdev abstraction is the real issue=C2=A0</div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">On Mon, Nov 2, 2026, 16:37 Bruce Richardson &lt;<a href=3D"mai=
lto:bruce.richardson@intel.com">bruce.richardson@intel.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">On Mon, Nov 02, 2026 at 10:55:43AM +=
0000, Loftus, Ciara wrote:<br>
&gt; &gt; Subject: [PATCH] net/ice: add explicit control of link auto-negot=
iation<br>
&gt; &gt; <br>
&gt; &gt; When selecting a fixed speed of the link, whether or not<br>
&gt; &gt; autonegotiation (e.g. AN Clause 37, etc.), needs to be enabled de=
pends<br>
&gt; &gt; on the peer link. While commit 3dc2933866d9 (&quot;net/ice: disab=
le link<br>
&gt; &gt; negotiation for fixed speed selection&quot;) would allow link set=
up when the<br>
&gt; &gt; remote side also has a fixed link without AN37 auto-negotiation, =
it<br>
&gt; &gt; causes the link to flap up and down when e.g. two ports are conne=
cted<br>
&gt; &gt; back to back and only one is set to a fixed speed.<br>
&gt; &gt; <br>
&gt; &gt; Support both scenarios of auto-negotiation supported or unsupport=
ed on<br>
&gt; &gt; the remote end by adding an explicit driver option for disabling<=
br>
&gt; &gt; auto-negotiation when a fixed speed is selected. If no fixed spee=
d<br>
&gt; &gt; setting, then new option does nothing.<br>
&gt; &gt; <br>
&gt; &gt; Fixes: 3dc2933866d9 (&quot;net/ice: disable link negotiation for =
fixed speed<br>
&gt; &gt; selection&quot;)<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Bruce Richardson &lt;<a href=3D"mailto:bruce.richa=
rdson@intel.com" target=3D"_blank" rel=3D"noreferrer">bruce.richardson@inte=
l.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 doc/guides/nics/ice.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 10 ++++++++++<br>
&gt; &gt;=C2=A0 doc/guides/rel_notes/release_26_11.rst |=C2=A0 2 ++<br>
&gt; &gt;=C2=A0 drivers/net/intel/ice/ice_ethdev.c=C2=A0 =C2=A0 =C2=A0| 12 =
+++++++++++-<br>
&gt; &gt;=C2=A0 drivers/net/intel/ice/ice_ethdev.h=C2=A0 =C2=A0 =C2=A0|=C2=
=A0 1 +<br>
&gt; &gt;=C2=A0 4 files changed, 24 insertions(+), 1 deletion(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst<br=
>
&gt; &gt; index ca3a94655b..af36341c9a 100644<br>
&gt; &gt; --- a/doc/guides/nics/ice.rst<br>
&gt; &gt; +++ b/doc/guides/nics/ice.rst<br>
&gt; &gt; @@ -107,6 +107,16 @@ Configuration<br>
&gt; &gt;=C2=A0 Runtime Configuration<br>
&gt; &gt;=C2=A0 ~~~~~~~~~~~~~~~~~~~~~<br>
&gt; &gt; <br>
&gt; &gt; +``auto_neg_disable`` (default ``0``)<br>
&gt; &gt; +=C2=A0 =C2=A0Control hardware link negotiation when a fixed spee=
d is requested with<br>
&gt; &gt; ``RTE_ETH_LINK_SPEED_FIXED``.<br>
&gt; &gt; +=C2=A0 =C2=A0By default, the firmware&#39;s negotiation settings=
 are preserved,<br>
&gt; &gt; +=C2=A0 =C2=A0allowing a fixed-speed link to use negotiation such=
 as Clause 37 when<br>
&gt; &gt; required by its peer.<br>
&gt; &gt; +=C2=A0 =C2=A0Set ``auto_neg_disable=3D1`` to disable Clause 28, =
Clause 37 and Clause 73<br>
&gt; &gt; negotiation.<br>
&gt; &gt; +=C2=A0 =C2=A0This option has no effect when automatic speed sele=
ction is requested.<br>
&gt; &gt; +=C2=A0 =C2=A0For example::<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 -a 80:00.0,auto_neg_disable=3D1<br>
&gt; &gt; +<br>
&gt; <br>
&gt; The approach looks good to me.<br>
&gt; Something my AI review flagged was the setting of &quot;link.link_auto=
neg&quot;<br>
&gt; in ice_link_update() - your patch doesn&#39;t update that setting, and=
 it&#39;s still<br>
&gt; just based off the dev_conf.link_speeds value, and doesn&#39;t take in=
to account<br>
&gt; the value of the devarg (unlike ice_apply_link_speed() which accounts =
for<br>
&gt; both). Perhaps it&#39;s not necessary, just something to check.<br>
&gt; Once that is addressed or ruled out:<br>
&gt; <br>
&gt; Acked-by: Ciara Loftus &lt;<a href=3D"mailto:ciara.loftus@intel.com" t=
arget=3D"_blank" rel=3D"noreferrer">ciara.loftus@intel.com</a>&gt;<br>
<br>
Yes, good catch. That is fixed in v2, but I&#39;ve dropped your ack as some=
 of<br>
the logic has been moved to a subfunction to avoid copy-pasting too much.<b=
r>
</blockquote></div>

--000000000000f476e8065f4d9b7b--
