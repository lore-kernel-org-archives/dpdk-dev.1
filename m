Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBC0CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Nov 2025 03:01:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A58D402D3;
	Sat,  1 Nov 2025 04:01:35 +0100 (CET)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50]) by mails.dpdk.org (Postfix) with ESMTP id BCBEE4021F
 for <dev@dpdk.org>; Sat,  1 Nov 2025 04:01:33 +0100 (CET)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-afcb7ae6ed0so596923666b.3
 for <dev@dpdk.org>; Fri, 31 Oct 2025 20:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761966093; x=1762570893; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fIe/3gUCb8luk+Np9fkmVXbdjnN3UYDtFNb9ZXNjgKQ=;
 b=Jj+c5rKylAgbmqZNhbwKLm8taog22CcR1FxPK2FhZ4bCs+O/nwP/GfxvnnrfAVW8Nq
 bXudvKzcRg/hFXlPEB7dKMRkDKm25tJF4rOA/Q/LpJnz+pzzSLqcDSR1YEpKgX2EiySo
 iRzgVRRqm4MfXFhfpS2UWBvBvqYM2vRDe0wh9cIBd5HJ0GbWYixP1J4YZmanWVpw3lUZ
 OH/5ZOnqChO8fNeaW2RyGdXfFS4AuQKqoD3EnQL1RTPC2dLnxWSMS//OjUVcHuLizVIW
 sJzcIn6CU5bf0vTk3VUK3jPnM0GMtGml2FdySiBY+n+8pt2nS0QWjlxiAJoDN6TJrzyW
 VLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761966093; x=1762570893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fIe/3gUCb8luk+Np9fkmVXbdjnN3UYDtFNb9ZXNjgKQ=;
 b=MwXadQaspLbgGTPw3dpDCe+b+IgIKVLbflljznx2Zbns8nqEne6jKeoTHTx/86IVlf
 AT6a1FmDGmecK2p1TLsBhTf5YLyyLP07lA0coKiWnfbh3GCIwp73rP3NSQFL9iSkgq4a
 WQU8WCVjxuHREllh2MZkidyQghrVy6EW1Pypzu6F8kHRPRoPthWQHIq4jsbRKvK2B2q+
 HELd5hnP34aJDvvW9c5zLo8tu+BmFQZsBMJHIO/E8R54RIuC68rk0Vv8HT3ZsVt5VwMH
 DNy/P61VLHy2oDgbzHoPii72AH6zhNoL0xYO3fGoToHlkxthvRS5eHFkR+pQBuBQX1kB
 QEeg==
X-Gm-Message-State: AOJu0Yz9lDBTUKWPw5w10Dsu2oRybgi7OdzU+ZHZy6aJbXvcHogY3wOb
 iFfUFUSjkCEohi/BBJh591tqtHlZ+ukDBPnXMRxRoU62vhfJo1QS3fFAT5bk/fXxkrH0e1i2Dhx
 3ofV43irHKM6np/5RUFNxpznRHKLTAdnTlQ==
X-Gm-Gg: ASbGncu6rXUCYjDvJEdcc+5mWHP9IzOmWlWrD1LsnsaFBin6aw9c7W0TKNZGRBMOftm
 emgYLJbCgk2JAzmryR3zyZ7rvwyNQBcjhWlzDiUPS/bT0ntsjtk2mQeRCpOAfQYFZvxHECcxjjX
 g52dgs1+ph0FeimF7m3MY+Fuj5XnYFNvv3HsC9d88Pa7/sChgVGS0o6ydozl+HmNyeSLoUrT4kD
 +LLdbRIIyvRYMnV9OQXJ75sWznpMDPY950Kbp+Rmi4KSkf4MK8NjRDmpLh2W/ZCWotfS/8KOaK9
 dYrWE0PcBuxJIUus
X-Google-Smtp-Source: AGHT+IGohKCkUpCXKuCqdkzHToKGsqAoBAmyxMZxWTGvK/YmKdj6v+SVFs09nDbAwQKpPuWSwxwWvxBH/ljqtpRfvII=
X-Received: by 2002:a17:906:c10c:b0:b4a:e11a:195b with SMTP id
 a640c23a62f3a-b707062f00bmr557298066b.44.1761966093021; Fri, 31 Oct 2025
 20:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251022155651.9818-1-amiyaranjan.mohakud@gmail.com>
 <20251023083019.18792-1-amiyaranjan.mohakud@gmail.com>
 <8e750656-787c-4dce-8cbe-241e7929d2a0@broadcom.com>
In-Reply-To: <8e750656-787c-4dce-8cbe-241e7929d2a0@broadcom.com>
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Date: Sat, 1 Nov 2025 08:31:21 +0530
X-Gm-Features: AWmQ_bnGH9dqaG5nsOKTduSOSfMIgayii6PcAV9yq-WmMSbY8p58_0ZvrA46xtQ
Message-ID: <CAL+mCpMB4aZuqkX_zzDea9uyUf1qQp-5JdoeEPxWnfk=u8XqRQ@mail.gmail.com>
Subject: Re: [PATCH v3] net/vmxnet3: disable RSS for single queue
 configuration for ESX8.0+ versions
To: Jochen Behrens <jochen.behrens@broadcom.com>
Cc: dev@dpdk.org, stable@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000014b5d906427fb3ac"
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

--00000000000014b5d906427fb3ac
Content-Type: text/plain; charset="UTF-8"

Thanks Jochen.
I see that the state is "Awaiting Upstream".  Will it be changed to
"Accepted" post upstream or Is it already accepted ?

Thanks
Amiya


On Fri, 24 Oct 2025 at 06:06, Jochen Behrens <jochen.behrens@broadcom.com>
wrote:

> Acked-by: Jochen Behrens <jochen.behrens@broadcom.com>
>
> On 10/23/25 01:30, Amiya Ranjan Mohakud wrote:
> > It fixes the issue of v4 RSS configuration failure in
> > vmxnet3_v4_rss_configure() while writing to BAR register. It's very
> > specific to single queue configuration.
> >
> > https://mails.dpdk.org/archives/users/2025-April/008236.html
> >
> > Bugzilla ID:1789
> > Fixes: 52ec00fd1474e8 ("net/vmxnet3: fix RSS setting on v4")
> > Cc: stable@dpdk.org
> >
> > v2:
> >   - Fixed typo in commit message
> > v3:
> >   - Checking if RSS is already enabled
> >
> > Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
> > ---
> >   drivers/net/vmxnet3/vmxnet3_ethdev.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c
> b/drivers/net/vmxnet3/vmxnet3_ethdev.c
> > index f4cdb1bb31..a0306af86c 100644
> > --- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
> > +++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
> > @@ -534,6 +534,13 @@ vmxnet3_dev_configure(struct rte_eth_dev *dev)
> >
> >       PMD_INIT_FUNC_TRACE();
> >
> > +     /* Disabling RSS for single queue pair */
> > +     if (dev->data->nb_rx_queues == 1 &&
> > +         dev->data->dev_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_RSS) {
> > +             dev->data->dev_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
> > +             PMD_INIT_LOG(ERR, "WARN: Disabling RSS for single Rx
> queue");
> > +     }
> > +
> >       if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
> >               dev->data->dev_conf.rxmode.offloads |=
> RTE_ETH_RX_OFFLOAD_RSS_HASH;
> >
>
>

--00000000000014b5d906427fb3ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div style=3D"font-family:trebuchet ms,sans-serif;col=
or:rgb(103,78,167)" class=3D"gmail_default">Thanks Jochen.</div><div style=
=3D"font-family:trebuchet ms,sans-serif;color:rgb(103,78,167)" class=3D"gma=
il_default">I see that the state is &quot;Awaiting Upstream&quot;.=C2=A0 Wi=
ll it be changed=C2=A0to=C2=A0 &quot;Accepted&quot; post upstream or Is=C2=
=A0it already accepted ?</div><br clear=3D"all"></div><div><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr"><div><span style=3D"font-family:verdana,sans-serif">Thanks</span></div>=
<div><span style=3D"font-family:verdana,sans-serif">Amiya</span><br></div><=
/div></div></div><br></div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 24 Oct 2025 at 06:06, Jo=
chen Behrens &lt;<a href=3D"mailto:jochen.behrens@broadcom.com">jochen.behr=
ens@broadcom.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Acked-by: Jochen Behrens &lt;<a href=3D"mailto:jochen.behre=
ns@broadcom.com" target=3D"_blank">jochen.behrens@broadcom.com</a>&gt;<br>
<br>
On 10/23/25 01:30, Amiya Ranjan Mohakud wrote:<br>
&gt; It fixes the issue of v4 RSS configuration failure in<br>
&gt; vmxnet3_v4_rss_configure() while writing to BAR register. It&#39;s ver=
y<br>
&gt; specific to single queue configuration.<br>
&gt; <br>
&gt; <a href=3D"https://mails.dpdk.org/archives/users/2025-April/008236.htm=
l" rel=3D"noreferrer" target=3D"_blank">https://mails.dpdk.org/archives/use=
rs/2025-April/008236.html</a><br>
&gt; <br>
&gt; Bugzilla ID:1789<br>
&gt; Fixes: 52ec00fd1474e8 (&quot;net/vmxnet3: fix RSS setting on v4&quot;)=
<br>
&gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.o=
rg</a><br>
&gt; <br>
&gt; v2:<br>
&gt;=C2=A0 =C2=A0- Fixed typo in commit message<br>
&gt; v3:<br>
&gt;=C2=A0 =C2=A0- Checking if RSS is already enabled<br>
&gt; <br>
&gt; Signed-off-by: Amiya Ranjan Mohakud &lt;<a href=3D"mailto:amiyaranjan.=
mohakud@gmail.com" target=3D"_blank">amiyaranjan.mohakud@gmail.com</a>&gt;<=
br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/net/vmxnet3/vmxnet3_ethdev.c | 7 +++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 7 insertions(+)<br>
&gt; <br>
&gt; diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet=
3/vmxnet3_ethdev.c<br>
&gt; index f4cdb1bb31..a0306af86c 100644<br>
&gt; --- a/drivers/net/vmxnet3/vmxnet3_ethdev.c<br>
&gt; +++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c<br>
&gt; @@ -534,6 +534,13 @@ vmxnet3_dev_configure(struct rte_eth_dev *dev)<br=
>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_INIT_FUNC_TRACE();<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Disabling RSS for single queue pair */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (dev-&gt;data-&gt;nb_rx_queues =3D=3D 1 &amp;&=
amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;data-&gt;dev_conf.rxmode.mq=
_mode =3D=3D RTE_ETH_MQ_RX_RSS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;data-&gt;dev_=
conf.rxmode.mq_mode =3D RTE_ETH_MQ_RX_NONE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_INIT_LOG(ERR, &qu=
ot;WARN: Disabling RSS for single Rx queue&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev-&gt;data-&gt;dev_conf.rxmode.mq_mode=
 &amp; RTE_ETH_MQ_RX_RSS_FLAG)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;data-&gt=
;dev_conf.rxmode.offloads |=3D RTE_ETH_RX_OFFLOAD_RSS_HASH;<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div>

--00000000000014b5d906427fb3ac--
