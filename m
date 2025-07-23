Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88630C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:35:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BB5040ED0;
	Wed, 23 Jul 2025 15:34:19 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 6706940E34
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:34:18 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-7070c45ce55so407026d6.0
 for <dev@dpdk.org>; Wed, 23 Jul 2025 06:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753277658;
 x=1753882458; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b0Uf5rxMLSIET9GLGr7yGPmnX2G4OYgh+xb0+BYbA04=;
 b=yERBo+wsL0lnmuKnbZgL6eS7asZgwr+piA+3csA/f/jti2PlakMsBU9OnelLGukccT
 ZIfOzqvmAkxyqMDJ/GUiohvvkTvMm4rNfPP2/kv0ng+P/qK/31IjHh6Y3kd+18L/kVWp
 qyJSwiZOaT5eLBPr/M3mjVhkLbqaRH/i1xEkzXDIAnULhuRDJjyGczdKkOFT7JISGcOI
 jLgONWadhWh4wG3iZFns/Hzi3gjmT/CSltWnH9XcHhsPMpDY3psMO5tenwh9QZBT/2b9
 b6ZonpoyRr/Tj8QcXxAZvrJA0oOwmq7k3KoRXhQkl01vmlyWcyPHRp9B0OH86up8s8Ag
 lftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753277658; x=1753882458;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b0Uf5rxMLSIET9GLGr7yGPmnX2G4OYgh+xb0+BYbA04=;
 b=fW82a6fgMpRufRB+cG6ENHAc47T7DBUGCK54jMk8v8CAaOyo0p2MMB+Q4VUUPiZ2Ka
 3bkW1l1AegymbmK+n41dty/WLTUqGbwQbaQ3ViUMUIVIJgHsBA8CU5YYijHMqkht0HKb
 59tqxIvW2IJnfZh8OQzz+L1KDEJrNFH89sZn3ED+EPc08MnNebiSSJkbo5MWkMA4GJSV
 NwiH7eLagbMlduggLLAQ7FJMflKIfs4SvaMh6oHWd3QhWa6r8SHPVlMkN/BJcZwxkgpN
 2DkQ72IlehOxCpGheavWY2RGXAAyjwLkIArKsA3vausGZWJBX5ccAdd1zzOzeSdcBwIK
 Dtew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUG/9gDCSGXVSl2wVw+FSYVrEMnhNWKwXrL4g2w8qAdLFgPdNAKWHIEQEvehVAcWTCJ6Q=@dpdk.org
X-Gm-Message-State: AOJu0YwS0ocX+/mdR17HEqg0uiGDsTTvioi23UFkAz8iXx0S0PgcERSa
 TrrfLHYyVagjJuIvc/QAoIrB8jEZq5LvO+KUTXFYVBAIHiaCIi6FnealjfFEsWtGK6s1mpoX9eu
 j8u0nFUaxPn0KPIL3OwUsioU/GNqu0udrerQ+uaGJkA==
X-Gm-Gg: ASbGncs1ZGj3MlB5MoTAAeqOxnRhDnmx0znB+JcPgLV0Ld9fIIW981wIL4pWV4M7mok
 xezFdjc+iay/2+av6imCKParUC3M7vycZw7yjGIIJ4j8L59tBp2573DlJkOzX0eOUQNVPXL5rDh
 eG0r6RwRWmx8e6rn6BTzssVUufEUNtj6NjcmJDJYs/OZ5/pFx1rblh9cTNKHqbX/nls/YfeG6Wd
 PrnHXXDlVrhuVaWcdW64UiqoYisKxGM35gTHUkVog==
X-Google-Smtp-Source: AGHT+IHAkv8uuiQMfK7kJy5nBUDgCz2cwT7/w6pynL3hRRBWX9G0De/aQYSzZYjNpy3Bxt2wGM0rNeFEGLIut74/0dU=
X-Received: by 2002:ad4:5aa8:0:b0:706:f3f9:8a52 with SMTP id
 6a1803df08f44-7070062e461mr33417166d6.29.1753277657651; Wed, 23 Jul 2025
 06:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250723045022.1580829-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250723131049.1703172-1-14pwcse1224@uetpeshawar.edu.pk>
 <0792a0e5-dbbf-f3bc-527b-2fe7d33e8822@arknetworks.am>
In-Reply-To: <0792a0e5-dbbf-f3bc-527b-2fe7d33e8822@arknetworks.am>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Wed, 23 Jul 2025 18:34:04 +0500
X-Gm-Features: Ac12FXz162K9WKiEe1tGLRn3yP1mmAZ-XnIr_G93vZ-uHcUB7WmYq6rfQbDUflo
Message-ID: <CA++2-x6bEQ+rjaddbyQLVTZTpy_4kUn12jmpXew9T=b0BjqSdA@mail.gmail.com>
Subject: Re: [PATCH] [PATCH v3] lib/ethdev: fix segfault in secondary process
 by validating dev_private pointer
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 dpdk stable <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000fa37ab063a98c33c"
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

--000000000000fa37ab063a98c33c
Content-Type: text/plain; charset="UTF-8"

Hi Ivan, agree. I think we can atleast currently guard all the known
crashes.

Sure, I will check the macro and get back to you.

Thank you!

On Wed, Jul 23, 2025, 18:19 Ivan Malov <ivan.malov@arknetworks.am> wrote:

> Hi Khadem,
>
> On Wed, 23 Jul 2025, Khadem Ullah wrote:
>
> > In secondary processes, directly accessing 'dev->data->dev_private' can
> > cause a segmentation fault if the primary process has exited or if the
> > shared memory is no longer accessible.
> >
> > Secondary application not only breaking on device closing,
> > but also getting segfault when we do "show device info all" from
> secondary
> > after primary closes.
> >
> > This patch adds safety checks while using rte_mem_virt2phy(), with an
> > unlikely() branch hint to minimize performance impact in the fast path.
> > This ensures 'dev_private' is still valid before accessing it.
> >
> > Fixes: bdad90d12ec8 ("ethdev: change device info get callback to return
> int")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> > ---
> > lib/ethdev/rte_ethdev.c | 15 ++++++++++++++-
> > 1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> > index dd7c00bc94..343e156a4f 100644
> > --- a/lib/ethdev/rte_ethdev.c
> > +++ b/lib/ethdev/rte_ethdev.c
> > @@ -4079,6 +4079,13 @@ rte_eth_dev_info_get(uint16_t port_id, struct
> rte_eth_dev_info *dev_info)
> >
> >       if (dev->dev_ops->dev_infos_get == NULL)
> >               return -ENOTSUP;
> > +     if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
> > +             unlikely(rte_mem_virt2phy(dev->data->dev_private) ==
> RTE_BAD_PHYS_ADDR)) {
> > +                     RTE_ETHDEV_LOG_LINE(ERR,
> > +                     "Secondary: dev_private not accessible (primary
> exited?)");
> > +                     rte_errno = ENODEV;
> > +                     return -rte_errno;
> > +     }
> >       diag = dev->dev_ops->dev_infos_get(dev, dev_info);
> >       if (diag != 0) {
> >               /* Cleanup already filled in device information */
> > @@ -4307,7 +4314,13 @@ rte_eth_macaddr_get(uint16_t port_id, struct
> rte_ether_addr *mac_addr)
> >                       port_id);
> >               return -EINVAL;
> >       }
> > -
> > +     if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
> > +             (dev->data->mac_addrs == NULL)) {
> > +                     RTE_ETHDEV_LOG_LINE(ERR,
> > +                     "Secondary: dev_private not accessible (primary
> exited?)");
> > +                     rte_errno = ENODEV;
> > +                     return -rte_errno;
> > +     }
> >       rte_ether_addr_copy(&dev->data->mac_addrs[0], mac_addr);
> >
> >       rte_eth_trace_macaddr_get(port_id, mac_addr);
>
> I see one more API has been augmented with the check. But community
> members may
> still argue this is not robust, as many other APIs will also fail. So,
> even if
> the task was to augment as many APIs as possible with the check, then the
> check
> would still be required to be factorised/generalised somehow. What do you
> think?
>
> Please also note that there are already macro invocations in many of these
> APIs,
> for example, RTE_ETH_VALID_PORTID_OR_ERR_RET. Could be convenient.
>
> Thank you.
>
> > --
> > 2.43.0
> >
> >
>

--000000000000fa37ab063a98c33c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Ivan, agree. I think we can atleast currently guard al=
l the known crashes.<div dir=3D"auto"><br></div><div dir=3D"auto">Sure, I w=
ill check the macro and get back=C2=A0to you.=C2=A0</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Thank you!</div></div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, J=
ul 23, 2025, 18:19 Ivan Malov &lt;<a href=3D"mailto:ivan.malov@arknetworks.=
am">ivan.malov@arknetworks.am</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">Hi Khadem,<br>
<br>
On Wed, 23 Jul 2025, Khadem Ullah wrote:<br>
<br>
&gt; In secondary processes, directly accessing &#39;dev-&gt;data-&gt;dev_p=
rivate&#39; can<br>
&gt; cause a segmentation fault if the primary process has exited or if the=
<br>
&gt; shared memory is no longer accessible.<br>
&gt;<br>
&gt; Secondary application not only breaking on device closing,<br>
&gt; but also getting segfault when we do &quot;show device info all&quot; =
from secondary<br>
&gt; after primary closes.<br>
&gt;<br>
&gt; This patch adds safety checks while using rte_mem_virt2phy(), with an<=
br>
&gt; unlikely() branch hint to minimize performance impact in the fast path=
.<br>
&gt; This ensures &#39;dev_private&#39; is still valid before accessing it.=
<br>
&gt;<br>
&gt; Fixes: bdad90d12ec8 (&quot;ethdev: change device info get callback to =
return int&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank" rel=3D"norefe=
rrer">stable@dpdk.org</a><br>
&gt;<br>
&gt; Signed-off-by: Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpesha=
war.edu.pk" target=3D"_blank" rel=3D"noreferrer">14pwcse1224@uetpeshawar.ed=
u.pk</a>&gt;<br>
&gt; ---<br>
&gt; lib/ethdev/rte_ethdev.c | 15 ++++++++++++++-<br>
&gt; 1 file changed, 14 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c<br>
&gt; index dd7c00bc94..343e156a4f 100644<br>
&gt; --- a/lib/ethdev/rte_ethdev.c<br>
&gt; +++ b/lib/ethdev/rte_ethdev.c<br>
&gt; @@ -4079,6 +4079,13 @@ rte_eth_dev_info_get(uint16_t port_id, struct r=
te_eth_dev_info *dev_info)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev-&gt;dev_ops-&gt;dev_infos_get =3D=3D=
 NULL)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTSUP;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (rte_eal_process_type() =3D=3D RTE_PROC_SECOND=
ARY &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unlikely(rte_mem_virt=
2phy(dev-&gt;data-&gt;dev_private) =3D=3D RTE_BAD_PHYS_ADDR)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0RTE_ETHDEV_LOG_LINE(ERR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;Secondary: dev_private not accessible (primary exited?)&quot;)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0rte_errno =3D ENODEV;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -rte_errno;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0diag =3D dev-&gt;dev_ops-&gt;dev_infos_get(d=
ev, dev_info);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (diag !=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Cleanup alrea=
dy filled in device information */<br>
&gt; @@ -4307,7 +4314,13 @@ rte_eth_macaddr_get(uint16_t port_id, struct rt=
e_ether_addr *mac_addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0port_id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (rte_eal_process_type() =3D=3D RTE_PROC_SECOND=
ARY &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(dev-&gt;data-&gt;mac=
_addrs =3D=3D NULL)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0RTE_ETHDEV_LOG_LINE(ERR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;Secondary: dev_private not accessible (primary exited?)&quot;)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0rte_errno =3D ENODEV;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -rte_errno;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_ether_addr_copy(&amp;dev-&gt;data-&gt;ma=
c_addrs[0], mac_addr);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eth_trace_macaddr_get(port_id, mac_addr)=
;<br>
<br>
I see one more API has been augmented with the check. But community members=
 may<br>
still argue this is not robust, as many other APIs will also fail. So, even=
 if<br>
the task was to augment as many APIs as possible with the check, then the c=
heck<br>
would still be required to be factorised/generalised somehow. What do you t=
hink?<br>
<br>
Please also note that there are already macro invocations in many of these =
APIs,<br>
for example, RTE_ETH_VALID_PORTID_OR_ERR_RET. Could be convenient.<br>
<br>
Thank you.<br>
<br>
&gt; -- <br>
&gt; 2.43.0<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--000000000000fa37ab063a98c33c--
