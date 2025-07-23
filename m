Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3826C83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 11:29:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 200EA402CC;
	Wed, 23 Jul 2025 13:29:18 +0200 (CEST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 1658E40264
 for <dev@dpdk.org>; Wed, 23 Jul 2025 13:29:16 +0200 (CEST)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-6fabe9446a0so55595066d6.2
 for <dev@dpdk.org>; Wed, 23 Jul 2025 04:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753270155;
 x=1753874955; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3nHtkL0L0iUZLJOvj1/O+XXPPlPshsp9c7Svd+AV0vA=;
 b=gzCywG5ORK03RXVLDDSxkADeLMLCnlj5u0/ygg90T90eMH+VkSCmZVeEM+HnNNAgHZ
 4hH5OZdrUCt9rbWFirKY139x1LWEu22GmwYykJRxJMQIYGhpFrz+dXukcHXU7AkpVI45
 SbjMB1BbTQrZmhQvd5ur6l3cbIf6rfS6CxPxEgiWjQ4DwdCUW2PDzuo9u2jYpo4xfOLN
 S9C7hUw9QaDCgy9hpc0H7HZt3dwb4YCZeR5V4xulx3V1jF1mWE+j/FTqr7QqonKfeIRq
 JYB9+ZfIaZgm4YYl2ygmOL5HHNpM5BbYRDbHa1It1IteqgarLi+LE+6Cijqh9fRK6f6i
 TD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753270155; x=1753874955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3nHtkL0L0iUZLJOvj1/O+XXPPlPshsp9c7Svd+AV0vA=;
 b=PcgyS+g3ByZB4OdpYunp7fHWa6iAauWa+kvrsQwaulhtfn7WhLjFXxZ/nlT6rAgP6B
 drIj6yewB5K5DYh6+hjP6La1/zRmH4CipK0NUhWVw6sK67aKTRfpO3ASQN2gw/kgQHDF
 S/Bbz1okCJOrDs9SVGYz71nxxnAe6DBVUFhpo8XRUgaSraQzrJzkh2hnnSyLE2zcuHkr
 wacbg/4gKAkqPAnCvPzyzuetWdfs4hthiCV0wUkIY+yQemUmdqBZJCuiWtXZYxFHuahY
 ynIO62MvzsUEtBzVndXtAcjzeMAIP8ltyqffn6NAN1rjq5wJP6otfltEFYAs6sb0n+PZ
 6NUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtLYdrsWs2OiFFpaeUguYTJExqwuPR6dDORNK1Dxw12OH/5N9nZM/X8Tuy6b5u9DyMYnA=@dpdk.org
X-Gm-Message-State: AOJu0YyXh+8zbN6fmGyCEnKnmb/r79CtuWMmY6fdzOdJC1mimCgnkH8c
 11kqe4lTk0Ue6Z5LGcWKjp65vCn2a6mrvpxaSPg2V7c0cXGyrcSN9vr7eLvKOIMvpB3dnPo1Sii
 pKgdGDAxQ/6p/LQTfN/vhDjVShC+F8aJT3r5rolAVVA==
X-Gm-Gg: ASbGnctZWLsBMg/VVFqpRyBtDqWfCa88uqYJ/02NexS1o1+OHnqrf3TI03OARK1gTCh
 ErO3hkrgJeIWxGUzlubazbCdqK1r5nwc3LigepXA+IiAarJYTmW1kVyxu3hK4OHwr/9D1gtJe5k
 HyuDGVZ4/gnVKUzwqBFnlirLIO6ESlzHbMCRWIxwoJKEUFd4Iy0iuVhKDRE9J0Xd5Acz3lt4jJj
 aL5zVEMCA==
X-Google-Smtp-Source: AGHT+IHH3prw9wrcgMeLzTDgojADpoxf9g0petfy+gK0ZVlJHHIfIu0bewsPpFOtDm1V97JbHXsWC5xcT/H+GMGc364=
X-Received: by 2002:a05:6214:1316:b0:6f5:3cae:920f with SMTP id
 6a1803df08f44-707006f70cfmr33935006d6.27.1753270155151; Wed, 23 Jul 2025
 04:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250721105819.2ci66fl7bzikwb22@ds-vm-debian.local>
 <b0c702cc-1213-d773-0ee0-804542a07e28@arknetworks.am>
 <3358342.oiGErgHkdL@thomas>
 <CA++2-x6o1QXgO=RiWk8vFcCRfs3ZCWc5G-yoebxCzPVzAZY9Gg@mail.gmail.com>
In-Reply-To: <CA++2-x6o1QXgO=RiWk8vFcCRfs3ZCWc5G-yoebxCzPVzAZY9Gg@mail.gmail.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Wed, 23 Jul 2025 16:29:03 +0500
X-Gm-Features: Ac12FXwQ1OXC3Pfw_ZnLX1wTz_It9sZ8EIXKsICupNzidDG1wCbUKCN0vDLOvLo
Message-ID: <CA++2-x5vmjQzUrSj_ihC5wQvicC=o8xJZSzazVGuGuRV=LG4Fg@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: fix crash when secondary queries dev info after
 primary exits
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Ivan Malov <ivan.malov@arknetworks.am>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org,
 rasland@nvidia.com, 
 dpdk stable <stable@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, 
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Content-Type: multipart/alternative; boundary="000000000000cb273f063a970495"
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

--000000000000cb273f063a970495
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch is a logical continuation of the commit:

```
commit 30410493759f ("drivers/net: check process type in close operation")
```

In that change, @Thomas Monjalon <thomas@monjalon.net>  introduced a
mechanism to prevent secondary processes from incorrectly releasing shared
resources during device close operations. That patch enforced process-type
checks in PMD close functions, ensuring only primary processes could manage
shared resources.

Furthermore, secondary application not only breaking on device closing,
it's also getting segfault when we do "show device info all" from secondary
after primary closes:

testpmd> show device info all

********************* Infos for device 0000:03:00.0 *********************
Bus name: pci
Bus information: vendor_id=3D15b3, device_id=3D101d
Driver name: mlx5_pci
Devargs:
Connect to socket: 0

Segmentation fault (core dumped)

This patch prevents these crashes and it seems that these fixes should be
in PMD along with the ethdev layer.


On Wed, Jul 23, 2025 at 12:30=E2=80=AFAM Khadem Ullah <
14pwcse1224@uetpeshawar.edu.pk> wrote:

> I think at least this should be followed either in PMD or in ethdev layer
> to avoid this specific crashes.
>
> On Mon, Jul 21, 2025, 17:00 Thomas Monjalon <thomas@monjalon.net> wrote:
>
>> 21/07/2025 13:46, Ivan Malov:
>> > On Mon, 21 Jul 2025, Dariusz Sosnowski wrote:
>> >
>> > > + mlx5 maintainers
>> > >
>> > > Thank you for the patch.
>> > >
>> > > Could you please include other PMD maintainers (or other maintainers=
,
>> depending on changed code)
>> > > in the future patches?
>> > > There is a script which automatically adds maintainers while sending
>> a patch.
>> > > It is described in:
>> https://doc.dpdk.org/guides/contributing/patches.html#sending-patches
>> > >
>> > > On Mon, Jul 21, 2025 at 03:38:51AM -0400, Khadem Ullah wrote:
>> > >> When the primary process exits, the shared mlx5 state becomes
>> > >> unavailable to secondary processes. If a secondary process attempts
>> > >> to query device information (e.g., via testpmd), a NULL dereference
>> > >> may occur due to missing shared data.
>> > >>
>> > >> This patch adds a check for shared context availability and fails
>> > >> gracefully while preventing a crash.
>> > >>
>> > >> Fixes: e60fbd5b24fc ("mlx5: add device configure/start/stop")
>> > >> Cc: stable@dpdk.org
>> > >>
>> > >> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
>> > >> ---
>> > >>  drivers/net/mlx5/mlx5_ethdev.c | 6 ++++++
>> > >>  1 file changed, 6 insertions(+)
>> > >>
>> > >> diff --git a/drivers/net/mlx5/mlx5_ethdev.c
>> b/drivers/net/mlx5/mlx5_ethdev.c
>> > >> index 68d1c1bfa7..1848f6536a 100644
>> > >> --- a/drivers/net/mlx5/mlx5_ethdev.c
>> > >> +++ b/drivers/net/mlx5/mlx5_ethdev.c
>> > >> @@ -368,6 +368,12 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev,
>> struct rte_eth_dev_info *info)
>> > >>     * Since we need one CQ per QP, the limit is the minimum number
>> > >>     * between the two values.
>> > >>     */
>> > >> +  if (priv =3D=3D NULL || priv->sh =3D=3D NULL) {
>> > >> +          DRV_LOG(ERR,
>> > >> +          "mlx5 shared data unavailable (primary process likely
>> exited)");
>> > >> +          rte_errno =3D ENODEV;
>> > >> +          return -rte_errno;
>> > >> +  }
>> > >
>> > > I don't think it's an issue on PMD level, but rather on
>> > > ethdev/multi-process handling level.
>> >
>> > I may be very wrong here, but can't the PMD use its internal 'shared'
>> state to
>> > somehow memorise the fact that a secondary process has attached, in
>> order to not
>> > let the primary process close in the first place (before the secondary
>> process
>> > detaches)? Or is this going to violate some established convention?
>>
>> It looks to be a good idea.
>>
>> > > When primary process closes the port, ethdev library zeroes and free=
s
>> > > device data shared between processes.
>> > > ethdev port data (rte_eth_dev) on secondary is not updated so it now
>> points to
>> > > invalid data. rte_eth_dev_info_get() is not the only API call
>> affected.
>> > >
>> > > If the primary process closes the port before exiting
>> > > (like testpmd does) and it exits before the secondary,
>> > > the any driver call seems invalid because of that use-after-free
>> behavior.
>> > >
>> > > @Thomas, @Andrew - Do you happen to know if doing anything on ethdev
>> ports
>> > > in secondary process after primary has gracefully exited is supporte=
d?
>>
>> No there is no statement about whether it is supported or not.
>> I think we should at least return an error instead of crashing.
>>
>>
>>

--=20
Engr. Khadem Ullah,
Software Engineer,
Dreambig Semiconductor Inc
https://dreambigsemi.com/

--000000000000cb273f063a970495
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This patch is a logical continuation of the commit:<br><br=
>```<br>commit 30410493759f (&quot;drivers/net: check process type in close=
 operation&quot;)<br>```<br><br>In that change,=C2=A0<a class=3D"gmail_plus=
reply" id=3D"plusReplyChip-1" href=3D"mailto:thomas@monjalon.net" tabindex=
=3D"-1">@Thomas Monjalon</a>=C2=A0 introduced a mechanism to prevent second=
ary processes from incorrectly releasing shared resources during device clo=
se operations. That patch enforced process-type checks in PMD close functio=
ns, ensuring only primary processes could manage shared resources.<br><br>F=
urthermore, secondary application not only breaking on device closing, it&#=
39;s also getting segfault when we do &quot;show device info all&quot; from=
 secondary after primary closes: <br><br>testpmd&gt; show device info all <=
br><br>********************* Infos for device 0000:03:00.0 ****************=
*****<br>Bus name: pci<br>Bus information: vendor_id=3D15b3, device_id=3D10=
1d<br>Driver name: mlx5_pci<br>Devargs: <br>Connect to socket: 0<br><br>Seg=
mentation fault (core dumped)<br><br>This patch prevents these crashes and =
it seems that these fixes should be in PMD along with the ethdev layer. =C2=
=A0<br><br></div><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 23, 2025 at 12:30=E2=80=AFAM K=
hadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpeshawar.edu.pk">14pwcse12=
24@uetpeshawar.edu.pk</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"auto">I think at least this should be foll=
owed either in PMD or in ethdev layer to avoid this specific crashes.=C2=A0=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Mon, Jul 21, 2025, 17:00 Thomas Monjalon &lt;<a href=3D"mailto:thomas@mo=
njalon.net" target=3D"_blank">thomas@monjalon.net</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">21/07/2025 13:46, Ivan Mal=
ov:<br>
&gt; On Mon, 21 Jul 2025, Dariusz Sosnowski wrote:<br>
&gt; <br>
&gt; &gt; + mlx5 maintainers<br>
&gt; &gt;<br>
&gt; &gt; Thank you for the patch.<br>
&gt; &gt;<br>
&gt; &gt; Could you please include other PMD maintainers (or other maintain=
ers, depending on changed code)<br>
&gt; &gt; in the future patches?<br>
&gt; &gt; There is a script which automatically adds maintainers while send=
ing a patch.<br>
&gt; &gt; It is described in: <a href=3D"https://doc.dpdk.org/guides/contri=
buting/patches.html#sending-patches" rel=3D"noreferrer noreferrer" target=
=3D"_blank">https://doc.dpdk.org/guides/contributing/patches.html#sending-p=
atches</a><br>
&gt; &gt;<br>
&gt; &gt; On Mon, Jul 21, 2025 at 03:38:51AM -0400, Khadem Ullah wrote:<br>
&gt; &gt;&gt; When the primary process exits, the shared mlx5 state becomes=
<br>
&gt; &gt;&gt; unavailable to secondary processes. If a secondary process at=
tempts<br>
&gt; &gt;&gt; to query device information (e.g., via testpmd), a NULL deref=
erence<br>
&gt; &gt;&gt; may occur due to missing shared data.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This patch adds a check for shared context availability and f=
ails<br>
&gt; &gt;&gt; gracefully while preventing a crash.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Fixes: e60fbd5b24fc (&quot;mlx5: add device configure/start/s=
top&quot;)<br>
&gt; &gt;&gt; Cc: <a href=3D"mailto:stable@dpdk.org" rel=3D"noreferrer" tar=
get=3D"_blank">stable@dpdk.org</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224=
@uetpeshawar.edu.pk" rel=3D"noreferrer" target=3D"_blank">14pwcse1224@uetpe=
shawar.edu.pk</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 drivers/net/mlx5/mlx5_ethdev.c | 6 ++++++<br>
&gt; &gt;&gt;=C2=A0 1 file changed, 6 insertions(+)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx=
5/mlx5_ethdev.c<br>
&gt; &gt;&gt; index 68d1c1bfa7..1848f6536a 100644<br>
&gt; &gt;&gt; --- a/drivers/net/mlx5/mlx5_ethdev.c<br>
&gt; &gt;&gt; +++ b/drivers/net/mlx5/mlx5_ethdev.c<br>
&gt; &gt;&gt; @@ -368,6 +368,12 @@ mlx5_dev_infos_get(struct rte_eth_dev *d=
ev, struct rte_eth_dev_info *info)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0* Since we need one CQ per QP, the limit i=
s the minimum number<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0* between the two values.<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt;&gt; +=C2=A0 if (priv =3D=3D NULL || priv-&gt;sh =3D=3D NULL) {<br=
>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRV_LOG(ERR,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;mlx5 shared data un=
available (primary process likely exited)&quot;);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_errno =3D ENODEV;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -rte_errno;<br>
&gt; &gt;&gt; +=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; I don&#39;t think it&#39;s an issue on PMD level, but rather on<b=
r>
&gt; &gt; ethdev/multi-process handling level.<br>
&gt; <br>
&gt; I may be very wrong here, but can&#39;t the PMD use its internal &#39;=
shared&#39; state to<br>
&gt; somehow memorise the fact that a secondary process has attached, in or=
der to not<br>
&gt; let the primary process close in the first place (before the secondary=
 process<br>
&gt; detaches)? Or is this going to violate some established convention?<br=
>
<br>
It looks to be a good idea.<br>
<br>
&gt; &gt; When primary process closes the port, ethdev library zeroes and f=
rees<br>
&gt; &gt; device data shared between processes.<br>
&gt; &gt; ethdev port data (rte_eth_dev) on secondary is not updated so it =
now points to<br>
&gt; &gt; invalid data. rte_eth_dev_info_get() is not the only API call aff=
ected.<br>
&gt; &gt;<br>
&gt; &gt; If the primary process closes the port before exiting<br>
&gt; &gt; (like testpmd does) and it exits before the secondary,<br>
&gt; &gt; the any driver call seems invalid because of that use-after-free =
behavior.<br>
&gt; &gt;<br>
&gt; &gt; @Thomas, @Andrew - Do you happen to know if doing anything on eth=
dev ports<br>
&gt; &gt; in secondary process after primary has gracefully exited is suppo=
rted?<br>
<br>
No there is no statement about whether it is supported or not.<br>
I think we should at least return an error instead of crashing.<br>
<br>
<br>
</blockquote></div>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div style=3D"font-family:Calibri,Aria=
l,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><span style=3D"colo=
r:rgb(12,100,192)">Engr. Khadem Ullah, </span><br></div><div style=3D"font-=
family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">=
<span style=3D"color:rgb(12,100,192)">Software Engineer, </span><br></div><=
span style=3D"color:rgb(12,100,192)">Dreambig Semiconductor Inc <br></span>=
</div><div dir=3D"ltr"><span style=3D"color:rgb(12,100,192)"><a href=3D"htt=
ps://dreambigsemi.com/" target=3D"_blank">https://dreambigsemi.com/</a><br>=
</span></div></div></div></div>

--000000000000cb273f063a970495--
