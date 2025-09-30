Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7A8CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 12:30:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16EC740673;
	Tue, 30 Sep 2025 14:30:37 +0200 (CEST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50]) by mails.dpdk.org (Postfix) with ESMTP id F3CCD400EF
 for <dev@dpdk.org>; Tue, 30 Sep 2025 14:30:35 +0200 (CEST)
Received: by mail-vs1-f50.google.com with SMTP id
 ada2fe7eead31-59dff155dc6so3725920137.3
 for <dev@dpdk.org>; Tue, 30 Sep 2025 05:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1759235435;
 x=1759840235; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f9FGm5YZqK2ePHR88fPAlU4OpIuTbuiBT/9KX0a+j9U=;
 b=17GuyMr1AWm5H6zSuBFHCWm5MBm/KoN4uiDu3Jqis7/ASOlo+lAlgxIzkDKgR7hbtw
 mhU1SE/Ef/rdUtkmbRDvCLGwLF5eY5aGFfMIBKC7ErTMCjBYrcihJKniI5i/gFaq6rsg
 QsF5XUTVXqikJQGXBbjb8id07XHTWlb8K0hin3pExQ83NijdG5J8LZdSK4BGBeyEY/jp
 UFWi+ys792ouZGNSpXc5dxqir2vfFNHKbZTHfl40JUqmXkIEA4SGtcnD8JuTuLB8yTxu
 RCiRW7apEkoP93AZzzFb+OYThZ29mmVoJ3htaTJx5iVZK7726i/4O6durSlHZ7LAik/q
 6+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759235435; x=1759840235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f9FGm5YZqK2ePHR88fPAlU4OpIuTbuiBT/9KX0a+j9U=;
 b=qGsefponKrNHwVUwYcseYOzLD39mMjPvxdv8+os2VjUqElX/n3JSnpiNi0A8lPrP4n
 dDpcRmwJXoszHloFOYr3F8Pkjh+0P89yTilJaDarLRK5lFc4/eVQ4vkkHY+n7UHU/n6l
 mGmRKrnvJs3hdXLmotmSQPYHLJqgmLkrnoGQbdps6s+MzFHfa1Be0gjshPyfoH/RgWxe
 4bt5+LqkM68KDmDYYa3Puu7RybMuENKaiJ6TODtv9TrAhtX4UQnHJj0mscCAdQmEGevL
 JHwYXwwWzcRBihPMz8f4ArQay6KCKx+kkhGQNvztRq5alZ6F/J9PGRBfjxa5jgJurDys
 A9AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUANxFrTIv51yJtfZf/lB7RMhTFXF7zPaBSgPV/t4xuO0VDKvtLNYcBVu+vmplXlpTFIvA=@dpdk.org
X-Gm-Message-State: AOJu0YxBdO6ZR44SZfIWnMSUDNzrNcEZiki5qsUBBFSLvna0bwY1vQBk
 DMPI6TIOnBjVFUrZSAOTsXZv4nlQzcdc2gjTEnNFC1oROIoz/4ZhdR7LTd/+ZyQGU+OdKnX6LzS
 +hV8AWceQ31L/HAiaHmife3vT0KtJWn9UvA29uCeSmQ==
X-Gm-Gg: ASbGncu7ZX7Rsdp0ak+lVDLgjqjfcngzwTU9dV65culuCM9xB4xZBwtq9oOeqSAmc8e
 GYo9FXxW/U3phAfZh7PjDUm2UzDSG5ieCcmsOBcSQXoC6SM6P/v3l2oE2dVRK+48SpTZZOfZcY3
 g4SwRssiw56ktjMmq2xl30wepotOJ2PAtbAXlqvnm3XZ2LS18AaJ318adUB/Gt5bC8bQKq152hd
 +sMQP8XCIJ/IpycKH8yIupUCkuR1yycipZ8USjgIfXUzCRk1s3kU04MVeyB7Iyki4IZ+K9nvk9t
X-Google-Smtp-Source: AGHT+IGaVevRl7wj9q67VpbDXiLaAmyUGiWEECu+JCZV+IKcVJWlu0SMz+vZIS5B0GXEurpvuhF0MrScr0rL7vH+Q7g=
X-Received: by 2002:a05:6102:510d:b0:529:fc9e:84a0 with SMTP id
 ada2fe7eead31-5acd36bc5d5mr7509110137.32.1759235434937; Tue, 30 Sep 2025
 05:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250929143039.547207-1-ciara.loftus@intel.com>
 <aNudwFx7CPH3vWot@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNudwFx7CPH3vWot@bricha3-mobl1.ger.corp.intel.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 30 Sep 2025 05:30:22 -0700
X-Gm-Features: AS18NWATeA2vGRvwHz8ZUt_RpA8MDQjMwzfhd-HOFcD0NBIqevvSjHGYrYdhKaw
Message-ID: <CAOaVG14zU7xw_osq7j58UGCCx_=b3y0n4p8-gbvoDuV2dStMvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/iavf: support VF initiated resets
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Ciara Loftus <ciara.loftus@intel.com>, dev <dev@dpdk.org>, 
 Timothy Miskell <timothy.miskell@intel.com>,
 dpdk-techboard <techboard@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000002d0e37064003eb36"
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

--0000000000002d0e37064003eb36
Content-Type: text/plain; charset="UTF-8"

Like the idea of a flag argument to reset function.

On Tue, Sep 30, 2025, 02:07 Bruce Richardson <bruce.richardson@intel.com>
wrote:

> On Mon, Sep 29, 2025 at 02:30:38PM +0000, Ciara Loftus wrote:
> > Introduce a function that allows a VF to request the PF to reset itself.
> > This is useful for example when the application detects that one of the
> > queues have hung or any event where a reset is required and the PF is
> > unlikely to trigger it.
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > Signed-off-by: Timothy Miskell <timothy.miskell@intel.com>
> > ---
> >  drivers/net/intel/iavf/iavf.h         |  2 ++
> >  drivers/net/intel/iavf/iavf_ethdev.c  |  5 ++++
> >  drivers/net/intel/iavf/iavf_vchnl.c   | 29 +++++++++++++++++++++++
> >  drivers/net/intel/iavf/meson.build    |  1 +
> >  drivers/net/intel/iavf/rte_pmd_iavf.c | 33 +++++++++++++++++++++++++++
> >  drivers/net/intel/iavf/rte_pmd_iavf.h | 11 +++++++++
> >  6 files changed, 81 insertions(+)
> >  create mode 100644 drivers/net/intel/iavf/rte_pmd_iavf.c
> >
> > diff --git a/drivers/net/intel/iavf/iavf.h
> b/drivers/net/intel/iavf/iavf.h
> > index 435902fbc2..6e7aec1bb1 100644
> > --- a/drivers/net/intel/iavf/iavf.h
> > +++ b/drivers/net/intel/iavf/iavf.h
> > @@ -565,4 +565,6 @@ void iavf_dev_watchdog_enable(struct iavf_adapter
> *adapter);
> >  void iavf_dev_watchdog_disable(struct iavf_adapter *adapter);
> >  void iavf_handle_hw_reset(struct rte_eth_dev *dev);
> >  void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
> > +bool is_iavf_supported(struct rte_eth_dev *dev);
> > +int iavf_request_reset(struct rte_eth_dev *dev);
> >  #endif /* _IAVF_ETHDEV_H_ */
>
> In general, I'm not a huge fan of adding driver-specific functions and I
> feel like this should fit under the existing reset APIs in some way. That
> should avoid the need to update (or such a big update) to testpmd, for
> example.
> Some thoughts here:
>
> 1. we could add a devarg to the driver to adjust whether reset does a
>    "softer" reset of the VF just resetting itself, or a "hard" reset where
> the
>    PF does a fuller reset of the VF.
> 2. rather than a devarg, would do use a driver-specific function to adjust
>    this behaviour. The difference here would be that the driver-specific
>    function would be an init-time one rather than runtime, so the runtime
> of
>    the app, like testpmd, would be generic.
> 3. the most generic solution would be to add an additional parameter to the
>    reset() function itself to specify a hard or soft reset. This would mean
>    updating all drivers to handle the new parameter (shouldn't be hard,
> since
>    it would be __rte_unused in all cases by default). This also opens up
>    the possibility of other drivers - especially VFs - using it in the same
>    way. We could actually document that the "hard" option "may be used by
> VF
>    drivers to request a full reset of the VF by the PF".
>
> CC'ing techboard to get some wider opinions here, especially thoughts on
> option #3.
>
> /Bruce
>

--0000000000002d0e37064003eb36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Like the idea of a flag argument to reset function.</div>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Sep 30, 2025, 02:07 Bruce Richardson &lt;<a href=3D=
"mailto:bruce.richardson@intel.com">bruce.richardson@intel.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">On Mon, Sep 29, 2025 at 02:30:38=
PM +0000, Ciara Loftus wrote:<br>
&gt; Introduce a function that allows a VF to request the PF to reset itsel=
f.<br>
&gt; This is useful for example when the application detects that one of th=
e<br>
&gt; queues have hung or any event where a reset is required and the PF is<=
br>
&gt; unlikely to trigger it.<br>
&gt; <br>
&gt; Signed-off-by: Ciara Loftus &lt;<a href=3D"mailto:ciara.loftus@intel.c=
om" target=3D"_blank" rel=3D"noreferrer">ciara.loftus@intel.com</a>&gt;<br>
&gt; Signed-off-by: Timothy Miskell &lt;<a href=3D"mailto:timothy.miskell@i=
ntel.com" target=3D"_blank" rel=3D"noreferrer">timothy.miskell@intel.com</a=
>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/net/intel/iavf/iavf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 ++<br>
&gt;=C2=A0 drivers/net/intel/iavf/iavf_ethdev.c=C2=A0 |=C2=A0 5 ++++<br>
&gt;=C2=A0 drivers/net/intel/iavf/iavf_vchnl.c=C2=A0 =C2=A0| 29 +++++++++++=
++++++++++++<br>
&gt;=C2=A0 drivers/net/intel/iavf/meson.build=C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 drivers/net/intel/iavf/rte_pmd_iavf.c | 33 +++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 drivers/net/intel/iavf/rte_pmd_iavf.h | 11 +++++++++<br>
&gt;=C2=A0 6 files changed, 81 insertions(+)<br>
&gt;=C2=A0 create mode 100644 drivers/net/intel/iavf/rte_pmd_iavf.c<br>
&gt; <br>
&gt; diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/ia=
vf.h<br>
&gt; index 435902fbc2..6e7aec1bb1 100644<br>
&gt; --- a/drivers/net/intel/iavf/iavf.h<br>
&gt; +++ b/drivers/net/intel/iavf/iavf.h<br>
&gt; @@ -565,4 +565,6 @@ void iavf_dev_watchdog_enable(struct iavf_adapter =
*adapter);<br>
&gt;=C2=A0 void iavf_dev_watchdog_disable(struct iavf_adapter *adapter);<br=
>
&gt;=C2=A0 void iavf_handle_hw_reset(struct rte_eth_dev *dev);<br>
&gt;=C2=A0 void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_ch=
ange);<br>
&gt; +bool is_iavf_supported(struct rte_eth_dev *dev);<br>
&gt; +int iavf_request_reset(struct rte_eth_dev *dev);<br>
&gt;=C2=A0 #endif /* _IAVF_ETHDEV_H_ */<br>
<br>
In general, I&#39;m not a huge fan of adding driver-specific functions and =
I<br>
feel like this should fit under the existing reset APIs in some way. That<b=
r>
should avoid the need to update (or such a big update) to testpmd, for exam=
ple.<br>
Some thoughts here:<br>
<br>
1. we could add a devarg to the driver to adjust whether reset does a<br>
=C2=A0 =C2=A0&quot;softer&quot; reset of the VF just resetting itself, or a=
 &quot;hard&quot; reset where the<br>
=C2=A0 =C2=A0PF does a fuller reset of the VF.<br>
2. rather than a devarg, would do use a driver-specific function to adjust<=
br>
=C2=A0 =C2=A0this behaviour. The difference here would be that the driver-s=
pecific<br>
=C2=A0 =C2=A0function would be an init-time one rather than runtime, so the=
 runtime of<br>
=C2=A0 =C2=A0the app, like testpmd, would be generic.<br>
3. the most generic solution would be to add an additional parameter to the=
<br>
=C2=A0 =C2=A0reset() function itself to specify a hard or soft reset. This =
would mean<br>
=C2=A0 =C2=A0updating all drivers to handle the new parameter (shouldn&#39;=
t be hard, since<br>
=C2=A0 =C2=A0it would be __rte_unused in all cases by default). This also o=
pens up<br>
=C2=A0 =C2=A0the possibility of other drivers - especially VFs - using it i=
n the same<br>
=C2=A0 =C2=A0way. We could actually document that the &quot;hard&quot; opti=
on &quot;may be used by VF<br>
=C2=A0 =C2=A0drivers to request a full reset of the VF by the PF&quot;.<br>
<br>
CC&#39;ing techboard to get some wider opinions here, especially thoughts o=
n<br>
option #3.<br>
<br>
/Bruce<br>
</blockquote></div>

--0000000000002d0e37064003eb36--
