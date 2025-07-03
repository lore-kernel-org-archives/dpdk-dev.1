Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A3EC83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 08:25:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4665C40287;
	Thu,  3 Jul 2025 10:25:34 +0200 (CEST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by mails.dpdk.org (Postfix) with ESMTP id D09B940285;
 Thu,  3 Jul 2025 10:25:32 +0200 (CEST)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-ad572ba1347so767302966b.1; 
 Thu, 03 Jul 2025 01:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751531132; x=1752135932; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qlO8enl8ViTtJU315DkD275CIlGoPo3FonNxW1QTPt8=;
 b=F9L4YEFHvmaWRwjjeY3VcvdYdB/YPmWPU1+FzsuPXQ/R/n/58ho9ouHxQ1KMx/ItS3
 oYGxuVMaZomhozTgz9X4h+RfwkeWHzNnZddIdZ7XmMdO+Q1togUpXCYu+a62mUvaxMKE
 TkuwZCijNdUHz6W6ulezlXHQcJMwIMTFzng62c8oegR9lKE/4AT7D+Yu2oAv0pTwoGCy
 5B720IsGK6ZhG+B75ONJFVERsiWZjZpZccPIEJ+syGuy6R3nZf/ZSJdPGkyHY19Uj7QL
 UBMXHgDSR7HV1qAKSmRGQfEX0GP7xYwoDsfVBds/mfR9eLaFuV+a9xe8a0xoFM9GW2f1
 QoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751531132; x=1752135932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qlO8enl8ViTtJU315DkD275CIlGoPo3FonNxW1QTPt8=;
 b=Svfzv5uINLzB04PB1YJ32RJsIpOmbFFSvu50DTZBhCbO+vVjbSVpB2Al89pPofwbrQ
 r3NupWK/Mxxv4jlA5caPXbXYBPU2amZ+dIH0pa+D986W+7b5V3UU/8v5lJxD/fUZ4GPC
 8Rymxf2tNfMMhBJPQFEXVW3z2DQbf5pkxKwfBdlQDB3IV2EIgEcNIsXlfYOuJOF1RBwM
 ICK7AXD7CsKhtkWB1yobEakAmrgJQzyQrfITKc0DI/j2NI+4bYIhxLMSgw3OHsWJJ05a
 Xwd1AGb7cpNjbOZz3yYDStb4MHDK6W0cv01DET+I9SH2sRRtZ6MyduLyKIzhMzUGdkic
 mX1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzzcyCVcC+xVi9T67KlXBPzyuf6Rg4gr7Zapjg2RnGSPLKxtNCYWRPzsuB94IPXArmQac=@dpdk.org
X-Gm-Message-State: AOJu0Yz/awD+ZugVSfVd/TnbZOLJFxAju0erxRP0zciZcsSob4THXRzJ
 xm6xV6Vw/uxyBYeHv74dkNd1XWvQ5FVRmBqA7sAARmqJ3x2U4OAG/ry+RyDXyiZgObHymbNwNRD
 L/jL6uR62crN5yk2yMV1pNaOxRKubUWA=
X-Gm-Gg: ASbGncvyDVI/C5A+47Ze8Ir+9nT+ZSlvKH2q/BhaEfQbnJdfY4jrTd30AGb/mifeMHu
 cDA2wXNaMqSNpqRViHomedWjBglXoVJqUzENiCkcotKHdpxTxWVhb7+COSNVbTw4zMerqIgFHtJ
 AmAk6WdI+/cT36AJZIiamPEipc3d5U24T6FWCU6Kgc6r/B9OiNz4iU
X-Google-Smtp-Source: AGHT+IEFLP98kJVquvUdVijLIODWg5KdTwIvy6wLJylBn/SNKl4spB4RJJ0FINGeQnnzNJTh89R1dIc+yli8UNj+9lQ=
X-Received: by 2002:a17:907:dab:b0:ae0:b847:438 with SMTP id
 a640c23a62f3a-ae3c2b97e72mr597502066b.21.1751531131866; Thu, 03 Jul 2025
 01:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250702182251.96427-1-amiyaranjan.mohakud@gmail.com>
 <20250702183856.99326-1-amiyaranjan.mohakud@gmail.com>
 <DM3PPF7D18F34A1E4C9969B1703BF0F09B18E43A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF7D18F34A1E4C9969B1703BF0F09B18E43A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Date: Thu, 3 Jul 2025 13:55:19 +0530
X-Gm-Features: Ac12FXxLcaBIvYx5Moq2hfkrS2m7HrAGP54vS2_zXo26z2JvBeFyzmeNCxLYGKQ
Message-ID: <CAL+mCpPA5c6yVg4OhSFH2a5ymp11b7go+SnqP-rgh4gYBCK2uw@mail.gmail.com>
Subject: Re: [PATCH v3] net/iavf: fix VLAN offload strip flag
To: "Loftus, Ciara" <ciara.loftus@intel.com>
Cc: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000ed92e00639021ef9"
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

--000000000000ed92e00639021ef9
Content-Type: text/plain; charset="UTF-8"

Sure Ciara. Thanks.

I will raise a fresh new patch for bug Id: 1735. That would be better.

Thanks
Amiya


On Thu, 3 Jul 2025 at 13:48, Loftus, Ciara <ciara.loftus@intel.com> wrote:

> > Subject: [PATCH v3] net/iavf: fix VLAN offload strip flag
> >
> > For i40e kernel drivers which support either vlan(v1) or vlan(v2)
> > VIRTCHNL OP,it will set strip on when setting filter on. But dpdk
> > side will not change strip flag. To be consistent with dpdk side,
> > explicitly disable strip again.
> >
> > Bugzilla ID:1725
> > Cc: stable@dpdk.org
> >
> > v3:
> > - Fixed the vlan(v2) scenario by calling appropriate api
> > - Addresses Bugzilla ID: 1735
> > v2:
> > - Fixed indentation in commit message
> >
> > Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
>
> Hi Amiya,
>
> Thanks for the patch.
> Since your first patch was already merged into the main branch, this patch
> is considered a new patch (v1).
> If you submit another revision, it should be labelled v2.
>
> Since it's a new patch, it needs a new commit message. Something like:
>
> net/iavf: fix VLAN strip disabling for v2 capability
>
> Ensure the correct virtchnl op is called for disabling vlan stripping by
> checking if the device supports either v1 or v2 vlan capability and
> choosing the op accordingly.
>
> You should include the below line in the commit message which indicates it
> is a fix for the first patch:
> Fixes: 3bfad066f9b4 ("net/iavf: fix VLAN strip setting after enabling
> filter")
>
> Thanks,
> Ciara
>
> > ---
> >  drivers/net/intel/iavf/iavf_ethdev.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> > b/drivers/net/intel/iavf/iavf_ethdev.c
> > index c33fdd9069..335a8126c4 100644
> > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > @@ -1388,6 +1388,7 @@ iavf_disable_vlan_strip_ex(struct rte_eth_dev
> > *dev, int on)
> >        */
> >       struct iavf_adapter *adapter =
> >               IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> > +     struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
> >       struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
> >       int err;
> >
> > @@ -1395,7 +1396,10 @@ iavf_disable_vlan_strip_ex(struct rte_eth_dev
> > *dev, int on)
> >           adapter->hw.mac.type == IAVF_MAC_VF ||
> >           adapter->hw.mac.type == IAVF_MAC_X722_VF) {
> >               if (on && !(dev_conf->rxmode.offloads &
> > RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
> > -                     err = iavf_disable_vlan_strip(adapter);
> > +                     if (vf->vf_res->vf_cap_flags &
> > VIRTCHNL_VF_OFFLOAD_VLAN_V2)
> > +                             err = iavf_config_vlan_strip_v2(adapter,
> false);
> > +                     else
> > +                             err = iavf_disable_vlan_strip(adapter);
> >                       if (err)
> >                               return -EIO;
> >               }
> > --
> > 2.39.5 (Apple Git-154)
>
>

--000000000000ed92e00639021ef9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div style=3D"font-family:verdana,sans-serif;color:rg=
b(103,78,167)" class=3D"gmail_default">Sure Ciara. Thanks.</div><div style=
=3D"font-family:verdana,sans-serif;color:rgb(103,78,167)" class=3D"gmail_de=
fault"><br></div><div style=3D"font-family:verdana,sans-serif;color:rgb(103=
,78,167)" class=3D"gmail_default">I will raise a fresh new patch for bug Id=
: 1735. That would be better.</div><br clear=3D"all"></div><div><div dir=3D=
"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><span style=3D"font-family:verdana,sans-serif">Thanks</span><=
/div><div><span style=3D"font-family:verdana,sans-serif">Amiya</span><br></=
div></div></div></div><br></div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 3 Jul 2025 at 13:48=
, Loftus, Ciara &lt;<a href=3D"mailto:ciara.loftus@intel.com">ciara.loftus@=
intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt; Subject: [PATCH v3] net/iavf: fix VLAN offload strip flag<b=
r>
&gt; <br>
&gt; For i40e kernel drivers which support either vlan(v1) or vlan(v2)<br>
&gt; VIRTCHNL OP,it will set strip on when setting filter on. But dpdk<br>
&gt; side will not change strip flag. To be consistent with dpdk side,<br>
&gt; explicitly disable strip again.<br>
&gt; <br>
&gt; Bugzilla ID:1725<br>
&gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.o=
rg</a><br>
&gt; <br>
&gt; v3:<br>
&gt; - Fixed the vlan(v2) scenario by calling appropriate api<br>
&gt; - Addresses Bugzilla ID: 1735<br>
&gt; v2:<br>
&gt; - Fixed indentation in commit message<br>
&gt; <br>
&gt; Signed-off-by: Amiya Ranjan Mohakud &lt;<a href=3D"mailto:amiyaranjan.=
mohakud@gmail.com" target=3D"_blank">amiyaranjan.mohakud@gmail.com</a>&gt;<=
br>
<br>
Hi Amiya,<br>
<br>
Thanks for the patch.<br>
Since your first patch was already merged into the main branch, this patch =
is considered a new patch (v1).<br>
If you submit another revision, it should be labelled v2.<br>
<br>
Since it&#39;s a new patch, it needs a new commit message. Something like:<=
br>
<br>
net/iavf: fix VLAN strip disabling for v2 capability<br>
<br>
Ensure the correct virtchnl op is called for disabling vlan stripping by ch=
ecking if the device supports either v1 or v2 vlan capability and choosing =
the op accordingly.<br>
<br>
You should include the below line in the commit message which indicates it =
is a fix for the first patch:<br>
Fixes: 3bfad066f9b4 (&quot;net/iavf: fix VLAN strip setting after enabling =
filter&quot;)<br>
<br>
Thanks,<br>
Ciara<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/net/intel/iavf/iavf_ethdev.c | 6 +++++-<br>
&gt;=C2=A0 1 file changed, 5 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/net/intel/iavf/iavf_ethdev.c<br>
&gt; b/drivers/net/intel/iavf/iavf_ethdev.c<br>
&gt; index c33fdd9069..335a8126c4 100644<br>
&gt; --- a/drivers/net/intel/iavf/iavf_ethdev.c<br>
&gt; +++ b/drivers/net/intel/iavf/iavf_ethdev.c<br>
&gt; @@ -1388,6 +1388,7 @@ iavf_disable_vlan_strip_ex(struct rte_eth_dev<br=
>
&gt; *dev, int on)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iavf_adapter *adapter =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IAVF_DEV_PRIVATE=
_TO_ADAPTER(dev-&gt;data-&gt;dev_private);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(a=
dapter);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_conf *dev_conf =3D &amp;dev-&=
gt;data-&gt;dev_conf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; <br>
&gt; @@ -1395,7 +1396,10 @@ iavf_disable_vlan_strip_ex(struct rte_eth_dev<b=
r>
&gt; *dev, int on)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adapter-&gt;hw.mac.type =3D=3D=
 IAVF_MAC_VF ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adapter-&gt;hw.mac.type =3D=3D=
 IAVF_MAC_X722_VF) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (on &amp;&amp=
; !(dev_conf-&gt;rxmode.offloads &amp;<br>
&gt; RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0err =3D iavf_disable_vlan_strip(adapter);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (vf-&gt;vf_res-&gt;vf_cap_flags &amp;<br>
&gt; VIRTCHNL_VF_OFFLOAD_VLAN_V2)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D iavf_config_vlan_strip_v2(adapte=
r, false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D iavf_disable_vlan_strip(adapter)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (err)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; --<br>
&gt; 2.39.5 (Apple Git-154)<br>
<br>
</blockquote></div>

--000000000000ed92e00639021ef9--
