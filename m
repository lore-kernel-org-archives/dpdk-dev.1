Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3CEC77B7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 15:29:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4293E40DC9;
	Tue, 24 Jun 2025 17:29:48 +0200 (CEST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by mails.dpdk.org (Postfix) with ESMTP id D9A8A4026B;
 Tue, 24 Jun 2025 17:29:46 +0200 (CEST)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-adfb562266cso118313966b.0; 
 Tue, 24 Jun 2025 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750778986; x=1751383786; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9hjpVNXp8738iWbDBDb8Q6lpmpsu2vtiF9B0RHaqMuM=;
 b=NOgLywLME9uFSwCkuJKX8qJ2aNsYC84c+OV3mONUUqPeUWQYfVURlUYiQxm/BYfBIk
 QOW2G8Mnwl3EJT8sgk9PL9Z6x0IEWJX7ak2xEYh1/gXffmc734IyHVWryhwRnuWboxtT
 UbrMs6i5VBvmUCi0Q8YEWIfN2gsFlfO7z3JQTZlk5vvTQH9t3sHGuQ256RNVIDwVl8+J
 akgf5Jy7JgPoHoF4o7yantXWhXDaPYVyjsCdIj/XrxwaEzdZO2APRD9WAORiNomiqc62
 0TT1vZLv3T2gyMItmDJAMX+IzaW7M0ELXo2jKgziPap75wqB69zUFf4F5JX2Abbd1D0T
 XR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750778986; x=1751383786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9hjpVNXp8738iWbDBDb8Q6lpmpsu2vtiF9B0RHaqMuM=;
 b=UGcBffplHufmb80NMmqWRj3dN3nBoCdqjicm894HN5AYkxDa8lXYkPIzK6L9Bptz7/
 wDEiyMquasDzV+31K53f5BqJ/RuaKtQ+K0939t49cjcDq4Qxwq3TDMXJ7LyWWle12051
 gExWdl4H42G6KHJNAUwgJoKQAgCjbqPnDhoL/DZCSrsdl1PXDVbISrUNFHePr8Zae2YJ
 aOdhTjhAdTWwZGAizxzt+5wLeZwdS5S9lq/i3nPmkfiJmJzq+o2TMvDfoOWUJTauhueo
 A+0lvtqr3jHzU/0zXo7g0eux+AKQUKa+KN4dAXWTbEr583jWKilpAvqgjLQXi8punXKq
 RLLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb4GdA0OWhtk0pMxx9IzZTcMXs6XOKQY+XOLnuHe+XBOhEajfwpQXGgdTKMk9CB+aUs41EFts=@dpdk.org
X-Gm-Message-State: AOJu0YwxuAnBgqJdQFd+6vTfzUIxhBaPB/72aSkygL7Dz9xeQCgEzRgP
 X6HSUi3zVsMHtNVmfMjlezHqtd9ujmwo1voQexdqrMSUvAg24uCtC9jQNVEGLrAgB2RnhyF1fXn
 xvZR0keDHBLhesljrlHiki2/wBe+QnW2ZWbmPDWA=
X-Gm-Gg: ASbGncsCR3eDM2Bk2L9qaes9848wQF93589Zun1tNjIBZaffIzGZ0avnHB1MDl4KZJY
 8AxcEz1rO9HE7NZkd4tCWXItq33GVriUsSoJlcqswv+nV+dPCqSki1fxUNR3QJDNygwK+nmcdpp
 9N/16P/ENTxtcfcDQu1qn4TeyZ+/Vy1jxLfL8LlvBTfw==
X-Google-Smtp-Source: AGHT+IFNxwumEGPQi7WVGKn0fCPeUzEL5AALYs/nTybtn+1S0aEVxXXMtFzM9zWyJ8b5ZbnB6jewipBzq4AapRa3urE=
X-Received: by 2002:a17:906:6a2a:b0:ad8:9a3b:b274 with SMTP id
 a640c23a62f3a-ae057c70972mr1684441466b.52.1750778986153; Tue, 24 Jun 2025
 08:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250621015624.35284-1-amiyaranjan.mohakud@gmail.com>
 <20250623181136.48239-1-amiyaranjan.mohakud@gmail.com>
 <CAL+mCpOU+q542mGrA+aT+nO8Rs4dtAY==U2SbvYJFvVd1e4qCA@mail.gmail.com>
 <DM3PPF7D18F34A1A1141693EF5A3DDF8B588E78A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF7D18F34A1A1141693EF5A3DDF8B588E78A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Date: Tue, 24 Jun 2025 20:59:34 +0530
X-Gm-Features: AX0GCFuQDzGy7VzqWC1tetPyvPaZfe-oobX1LpgucFLC8QY98FLFH9NrvEaOcds
Message-ID: <CAL+mCpMZDed=QQ-RH0Y0GT095Cnyhz2rsvg8abKuM4_U13-eGw@mail.gmail.com>
Subject: Re: [PATCH v2] net/iavf: fix VLAN offload strip flag
To: "Loftus, Ciara" <ciara.loftus@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000008ccc6c063852ffe4"
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

--0000000000008ccc6c063852ffe4
Content-Type: text/plain; charset="UTF-8"

Thanks.

Just wanted to know  - what are the next steps of the review and approval
process?

There is a test suite "ci/intel-Testing" failing now with v2 which passed
in v1. ( We know for sure, there is absolutely no code change between v1
and v2 except the commit message). Is there a way to trigger the test suite
again?

Thanks
Amiya


On Tue, 24 Jun 2025 at 14:49, Loftus, Ciara <ciara.loftus@intel.com> wrote:

> > Subject: Re: [PATCH v2] net/iavf: fix VLAN offload strip flag
> >
> > Hi Ciara
> > Thanks for your effort in reproducing the issue and confirming that the
> patch
> > works. However, I have taken care of the indentation in the commit
> message
> > and sent out a v2 patch. Appreciate your review comments.
> >
> > >>>Perhaps we should make the disabling unconditional or even better
> make it
> > depend on if the stripping was enabled although I'm not sure if there's
> a way
> > to check for this.
> >
> > I understand and agree with your point of disabling vlan_strip after
> checking if
> > the stripping is enabled. But like you mentioned, I'm also not sure if
> there is
> > any way to know that.
> >
> > However, I think, the current check also does a good job by checking the
> > dev_conf parameter against RTE_ETH_RX_OFFLOAD_VLAN_STRIP and re-
> > disables the vlan_strip after every vlan_add operation.
>
> Thanks for the v2.
> I think this approach is fine for now, it matches what was already in
> place for VIRTCHNL_VF_OFFLOAD_VLAN(V1).
> A future improvement would be to find a way to determine if the stripping
> was re-enabled and only attempt to disable in that case.
>
> >
> >
> > Thanks
> > Amiya
> >
> >
> > On Mon, 23 Jun 2025 at 23:41, Amiya Ranjan Mohakud
> > <mailto:amiyaranjan.mohakud@gmail.com> wrote:
> > For i40e kernel drivers which support either vlan(v1) or vlan(v2)
> > VIRTCHNL OP,it will set strip on when setting filter on. But dpdk
> > side will not change strip flag. To be consistent with dpdk side,
> > explicitly disable strip again.
> >
> > Bugzilla ID:1725
> > Cc: mailto:stable@dpdk.org
> >
> > v2:
> > - Fixed indentation in commit message
> >
> > Signed-off-by: Amiya Ranjan Mohakud
> > <mailto:amiyaranjan.mohakud@gmail.com>
> > ---
> >  drivers/net/intel/iavf/iavf_ethdev.c | 48 +++++++++++++++++-----------
> >  1 file changed, 29 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> > b/drivers/net/intel/iavf/iavf_ethdev.c
> > index b3dacbef84..f93e7bf9ae 100644
> > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > @@ -1378,13 +1378,38 @@ iavf_dev_del_mac_addr(struct rte_eth_dev
> > *dev, uint32_t index)
> >         vf->mac_num--;
> >  }
> >
> > +static int
> > +iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)
> > +{
> > +       /* For i40e kernel drivers which supports both vlan(v1 & v2)
> VIRTCHNL
> > OP,
> > +        * it will set strip on when setting filter on but dpdk side
> will not
> > +        * change strip flag. To be consistent with dpdk side,
> explicitly disable
> > +        * strip again.
> > +        *
> > +        */
> > +       struct iavf_adapter *adapter =
> > +               IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> > +       struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
> > +       int err;
> > +
> > +       if (adapter->hw.mac.type == IAVF_MAC_XL710 ||
> > +           adapter->hw.mac.type == IAVF_MAC_VF ||
> > +           adapter->hw.mac.type == IAVF_MAC_X722_VF) {
> > +               if (on && !(dev_conf->rxmode.offloads &
> > RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
> > +                       err = iavf_disable_vlan_strip(adapter);
> > +                       if (err)
> > +                               return -EIO;
> > +               }
> > +       }
> > +       return 0;
> > +}
> > +
> >  static int
> >  iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int
> on)
> >  {
> >         struct iavf_adapter *adapter =
> >                 IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> >         struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
> > -       struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
> >         int err;
> >
> >         if (adapter->closed)
> > @@ -1394,7 +1419,8 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev,
> > uint16_t vlan_id, int on)
> >                 err = iavf_add_del_vlan_v2(adapter, vlan_id, on);
> >                 if (err)
> >                         return -EIO;
> > -               return 0;
> > +
> > +               return iavf_disable_vlan_strip_ex(dev, on);
> >         }
> >
> >         if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN))
> > @@ -1404,23 +1430,7 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev,
> > uint16_t vlan_id, int on)
> >         if (err)
> >                 return -EIO;
> >
> > -       /* For i40e kernel driver which only supports vlan(v1) VIRTCHNL
> OP,
> > -        * it will set strip on when setting filter on but dpdk side
> will not
> > -        * change strip flag. To be consistent with dpdk side, disable
> strip
> > -        * again.
> > -        *
> > -        * For i40e kernel driver which supports vlan v2, dpdk will
> invoke vlan v2
> > -        * related function, so it won't go through here.
> > -        */
> > -       if (adapter->hw.mac.type == IAVF_MAC_XL710 ||
> > -           adapter->hw.mac.type == IAVF_MAC_X722_VF) {
> > -               if (on && !(dev_conf->rxmode.offloads &
> > RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
> > -                       err = iavf_disable_vlan_strip(adapter);
> > -                       if (err)
> > -                               return -EIO;
> > -               }
> > -       }
> > -       return 0;
> > +       return iavf_disable_vlan_strip_ex(dev, on);
> >  }
> >
> >  static void
> > --
> > 2.39.5 (Apple Git-154)
>

--0000000000008ccc6c063852ffe4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div style=3D"font-family:verdana,sans-serif;color:rg=
b(103,78,167)" class=3D"gmail_default">Thanks.</div><div style=3D"font-fami=
ly:verdana,sans-serif;color:rgb(103,78,167)" class=3D"gmail_default"><br></=
div><div style=3D"font-family:verdana,sans-serif;color:rgb(103,78,167)" cla=
ss=3D"gmail_default">Just wanted to know=C2=A0 - what are the next steps of=
 the review and approval process?=C2=A0</div><div style=3D"font-family:verd=
ana,sans-serif;color:rgb(103,78,167)" class=3D"gmail_default"><br></div><di=
v style=3D"font-family:verdana,sans-serif;color:rgb(103,78,167)" class=3D"g=
mail_default">There is a test suite &quot;ci/intel-Testing&quot; failing no=
w with v2 which passed in v1. ( We know for sure, there is absolutely no co=
de change between v1 and v2 except the commit message). Is there a way to t=
rigger the test suite again?</div><br></div><div><div dir=3D"ltr" class=3D"=
gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><=
span style=3D"font-family:verdana,sans-serif">Thanks</span></div><div><span=
 style=3D"font-family:verdana,sans-serif">Amiya</span><br></div></div></div=
></div><br></div><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, 24 Jun 2025 at 14:49, Loftus, Ciar=
a &lt;<a href=3D"mailto:ciara.loftus@intel.com">ciara.loftus@intel.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; =
Subject: Re: [PATCH v2] net/iavf: fix VLAN offload strip flag<br>
&gt; <br>
&gt; Hi=C2=A0Ciara<br>
&gt; Thanks for your effort in reproducing the issue and confirming that th=
e patch<br>
&gt; works.=C2=A0However, I have taken care of the indentation in the commi=
t message<br>
&gt; and sent out a v2 patch.=C2=A0Appreciate your review=C2=A0comments.<br=
>
&gt; <br>
&gt; &gt;&gt;&gt;Perhaps we should make the disabling unconditional or even=
 better make it<br>
&gt; depend on if the stripping was enabled although I&#39;m not sure if th=
ere&#39;s a way<br>
&gt; to check for this.<br>
&gt; <br>
&gt; I understand and agree with your point of disabling vlan_strip after c=
hecking if<br>
&gt; the stripping is enabled. But like you mentioned, I&#39;m also not sur=
e if there is<br>
&gt; any way to know that.<br>
&gt; <br>
&gt; However, I think, the current check also does a good job by checking t=
he<br>
&gt; dev_conf parameter against=C2=A0RTE_ETH_RX_OFFLOAD_VLAN_STRIP and re-<=
br>
&gt; disables the vlan_strip after every vlan_add operation.<br>
<br>
Thanks for the v2.<br>
I think this approach is fine for now, it matches what was already in place=
 for VIRTCHNL_VF_OFFLOAD_VLAN(V1).<br>
A future improvement would be to find a way to determine if the stripping w=
as re-enabled and only attempt to disable in that case.<br>
<br>
&gt; <br>
&gt; <br>
&gt; Thanks<br>
&gt; Amiya<br>
&gt; <br>
&gt; <br>
&gt; On Mon, 23 Jun 2025 at 23:41, Amiya Ranjan Mohakud<br>
&gt; &lt;mailto:<a href=3D"mailto:amiyaranjan.mohakud@gmail.com" target=3D"=
_blank">amiyaranjan.mohakud@gmail.com</a>&gt; wrote:<br>
&gt; For i40e kernel drivers which support either vlan(v1) or vlan(v2)<br>
&gt; VIRTCHNL OP,it will set strip on when setting filter on. But dpdk<br>
&gt; side will not change strip flag. To be consistent with dpdk side,<br>
&gt; explicitly disable strip again.<br>
&gt; <br>
&gt; Bugzilla ID:1725<br>
&gt; Cc: mailto:<a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable=
@dpdk.org</a><br>
&gt; <br>
&gt; v2:<br>
&gt; - Fixed indentation in commit message<br>
&gt; <br>
&gt; Signed-off-by: Amiya Ranjan Mohakud<br>
&gt; &lt;mailto:<a href=3D"mailto:amiyaranjan.mohakud@gmail.com" target=3D"=
_blank">amiyaranjan.mohakud@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0drivers/net/intel/iavf/iavf_ethdev.c | 48 +++++++++++++++++-----=
------<br>
&gt; =C2=A01 file changed, 29 insertions(+), 19 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/net/intel/iavf/iavf_ethdev.c<br>
&gt; b/drivers/net/intel/iavf/iavf_ethdev.c<br>
&gt; index b3dacbef84..f93e7bf9ae 100644<br>
&gt; --- a/drivers/net/intel/iavf/iavf_ethdev.c<br>
&gt; +++ b/drivers/net/intel/iavf/iavf_ethdev.c<br>
&gt; @@ -1378,13 +1378,38 @@ iavf_dev_del_mac_addr(struct rte_eth_dev<br>
&gt; *dev, uint32_t index)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 vf-&gt;mac_num--;<br>
&gt; =C2=A0}<br>
&gt; <br>
&gt; +static int<br>
&gt; +iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* For i40e kernel drivers which supports =
both vlan(v1 &amp; v2) VIRTCHNL<br>
&gt; OP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * it will set strip on when setting filte=
r on but dpdk side will not<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * change strip flag. To be consistent wit=
h dpdk side, explicitly disable<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * strip again.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iavf_adapter *adapter =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IAVF_DEV_PRIVA=
TE_TO_ADAPTER(dev-&gt;data-&gt;dev_private);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_conf *dev_conf =3D &amp;dev=
-&gt;data-&gt;dev_conf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adapter-&gt;hw.mac.type =3D=3D IAVF_MA=
C_XL710 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adapter-&gt;hw.mac.type =3D=
=3D IAVF_MAC_VF ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adapter-&gt;hw.mac.type =3D=
=3D IAVF_MAC_X722_VF) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (on &amp;&a=
mp; !(dev_conf-&gt;rxmode.offloads &amp;<br>
&gt; RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0err =3D iavf_disable_vlan_strip(adapter);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (err)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; =C2=A0static int<br>
&gt; =C2=A0iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_=
id, int on)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iavf_adapter *adapter =3D<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IAVF_DEV_PRIVA=
TE_TO_ADAPTER(dev-&gt;data-&gt;dev_private);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iavf_info *vf =3D IAVF_DEV_PRIVATE_=
TO_VF(adapter);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_conf *dev_conf =3D &amp;dev=
-&gt;data-&gt;dev_conf;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int err;<br>
&gt; <br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adapter-&gt;closed)<br>
&gt; @@ -1394,7 +1419,8 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev=
,<br>
&gt; uint16_t vlan_id, int on)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D iavf_a=
dd_del_vlan_v2(adapter, vlan_id, on);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return -EIO;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return iavf_di=
sable_vlan_strip_ex(dev, on);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; <br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(vf-&gt;vf_res-&gt;vf_cap_flags &amp;=
 VIRTCHNL_VF_OFFLOAD_VLAN))<br>
&gt; @@ -1404,23 +1430,7 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *de=
v,<br>
&gt; uint16_t vlan_id, int on)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;<b=
r>
&gt; <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* For i40e kernel driver which only suppo=
rts vlan(v1) VIRTCHNL OP,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * it will set strip on when setting filte=
r on but dpdk side will not<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * change strip flag. To be consistent wit=
h dpdk side, disable strip<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * again.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * For i40e kernel driver which supports v=
lan v2, dpdk will invoke vlan v2<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * related function, so it won&#39;t go th=
rough here.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adapter-&gt;hw.mac.type =3D=3D IAVF_MA=
C_XL710 ||<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adapter-&gt;hw.mac.type =3D=
=3D IAVF_MAC_X722_VF) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (on &amp;&a=
mp; !(dev_conf-&gt;rxmode.offloads &amp;<br>
&gt; RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0err =3D iavf_disable_vlan_strip(adapter);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (err)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return iavf_disable_vlan_strip_ex(dev, on)=
;<br>
&gt; =C2=A0}<br>
&gt; <br>
&gt; =C2=A0static void<br>
&gt; --<br>
&gt; 2.39.5 (Apple Git-154)<br>
</blockquote></div>

--0000000000008ccc6c063852ffe4--
