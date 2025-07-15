Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C83C83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 21:21:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA1A6402D4;
	Tue, 15 Jul 2025 23:21:28 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 292DD4026D
 for <dev@dpdk.org>; Tue, 15 Jul 2025 23:21:27 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b2c4e46a89fso5073184a12.2
 for <dev@dpdk.org>; Tue, 15 Jul 2025 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752614486; x=1753219286; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VnvqXV118VRwNSBAeGITZSnN+E6AY/4vDRxMhfPsquk=;
 b=MZrNJ1pmUVN4t4Og0aNAnBypRkVMJpnHh3P75KUpMX1MsRFIFHdydJxIbiHs/jnx5z
 3/kdW8qgq/48my7NkolC1dsy5BHVGzmm38XfDcs1gSi51JD0hHWIvbJNTFrVwKF7WCzV
 BaFIcmbeyfehnYdidho19bOHRkLXS1QcFRuZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752614486; x=1753219286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VnvqXV118VRwNSBAeGITZSnN+E6AY/4vDRxMhfPsquk=;
 b=irlTMBz9VP8K5e3p4WQupNXfww5eN69cBqY2u0ohcUErcogInTEtfN8q+010bk9ysW
 i9WTNaR3hVufNy0Y1mnIEBH/LkX+rcTPr18Wxkc0aqJpDLBxMBNjVes5oy0OLxIETz3N
 esiI5vd2I68VPemNEHcQjVir4bsonmJ/BiZBOaGnkBEESnUsogJKZRNNZzr0qNuu7P/V
 X4YYt0yFebDtKy4RAMq2+9R0pi2qjQ0jN1hvYwP7AYhj4V1L2pY7ykZ0U9899mBw4Bzx
 8HwH0LzuSGuufOp1P+Ze/XKOr7UDwrhoeCDDf2l+MZ7ytVZsqax/1w3rc791Raibn4K6
 AFHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrWlPTFFD0dcwYC2hag5m8FFMzgkCpbZSJG9WAb0UHQ39V764zcdAUW1JK9//Cwwp91Lk=@dpdk.org
X-Gm-Message-State: AOJu0YwmXTs+d9SQZGHSXLsYpWaHGagP57CJ3K5I4ghn3ryvRz8lgeIs
 PJZuMygsbixhQntVSN5z5ax9QyvruKQpJ2bVcjdYIxv6DopTakm6Zp8JsuYc4QHC85mO/OLa6pD
 o+0C9VYZ8q4LSLZUW9kBSMxCkukCqBWMrL6EaosAZZw==
X-Gm-Gg: ASbGncuSDmgWl3BJ6mr1wrbYz0ZuztBM08Lu7rbIpyCOJ+m9VteNT2MZcHFt5ahkn6J
 5rHMDQAAARrpTSnr5aJnJNzN0BMWkqSH9lIJ//hAAQThLxeFEbnkkHYJGgunprUzvwNr0X2wM4+
 9jmgSksrcPKj1urzYfhQteOFF1FErgbAnkInGD3MWJKf4nxdacxX53Ir5vgIczBScBR7g63yfyC
 J7Pb25WsJY76lwG1e0B
X-Google-Smtp-Source: AGHT+IGmAoKyBr2ilmX6SerQoqskxMQvN7y0nVQg84encsilCFmnasG6wy90eV1DMG3csVpP7cNJkeu+urKQLjbo1s8=
X-Received: by 2002:a17:90b:582f:b0:311:ff02:3fcb with SMTP id
 98e67ed59e1d1-31c9f447d33mr199384a91.28.1752614485752; Tue, 15 Jul 2025
 14:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
 <aHYHj9vtdXm8MgY_@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aHYHj9vtdXm8MgY_@bricha3-mobl1.ger.corp.intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 15 Jul 2025 17:15:34 -0400
X-Gm-Features: Ac12FXyDGQy15RhnndDroC2Z1VYNDwjlXQC2mh0yNBJlDn2RzayOuxUsC7XSy5o
Message-ID: <CAJvnSUBSZo8OAZ+_xjFm3=5FG2EBJ2UiF6KfkPb_iNz2_1aoyg@mail.gmail.com>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Dean Marx <dmarx@iol.unh.edu>, dev@dpdk.org, techboard@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000da18080639fe5b0a"
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

--000000000000da18080639fe5b0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 3:47=E2=80=AFAM Bruce Richardson <bruce.richardson@=
intel.com>
wrote:

>
>
> Thanks. Let me know how the testing otherwise goes. If only Intel NICs ar=
e
> supporting QinQ, then it can't be that widely used a feature yet, so we m=
ay
> be able to tweak things a bit if it diverges from what is expected.
>

Yeah, there seems to be fairly broad support for VLAN strip, but much less
for QinQ strip. So, we can verify "correct" VLAN stripping behavior given
the various packet profiles we discussed previously like double vlan,
vlan + qinq, single qinq etc.

For QinQ strip like Dean said, most PMDs dont support this currently, with
Intel PMDs being an exception among the NICs we have at UNH. We took a look
at the DPDK networking drivers support table which reflects this (see the
QinQ offload row). https://doc.dpdk.org/guides/nics/overview.html

So, it looks like there are a few (ZTE DXDH is an example) that are also
supporting QinQ Offload, but not many right now.



> I also wonder if the definition of expected behaviour is preventing other
> NICs from implementing the feature?
>
> Can you also check with VLAN stripping enabled? My biggest issue with the
> behaviour description of QinQ strip only removing outer tag is that it
> implies for QinQ traffoc that VLAN strip alone should strip inner tag
> without
> removing outer.


Sure, we can check this case. across the NICs at UNH. I have a sync
wth Dean tomorrow morning for this, at the end of which we'll share back to
you what we have.


> That doesn't make sense to me - and I'm not sure if NIC
> hardware supports such features of removing inner headers while leaving
> outer.
>
> /Bruce
>

--000000000000da18080639fe5b0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 15,=
 2025 at 3:47=E2=80=AFAM Bruce Richardson &lt;<a href=3D"mailto:bruce.richa=
rdson@intel.com">bruce.richardson@intel.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><br>
<br>
Thanks. Let me know how the testing otherwise goes. If only Intel NICs are<=
br>
supporting QinQ, then it can&#39;t be that widely used a feature yet, so we=
 may<br>
be able to tweak things a bit if it diverges from what is expected.<br></bl=
ockquote><div><br></div><div>Yeah, there seems to be fairly broad support f=
or VLAN strip, but much less for QinQ strip. So, we can verify &quot;correc=
t&quot; VLAN stripping behavior given the various packet profiles we discus=
sed previously like double vlan, vlan=C2=A0+ qinq, single qinq etc.</div><d=
iv><br></div><div>For QinQ strip like Dean said, most PMDs dont support thi=
s currently, with Intel PMDs being an exception among the=C2=A0NICs we=C2=
=A0have at UNH. We took a look at the DPDK networking drivers support table=
 which reflects this (see the QinQ offload row).=C2=A0<a href=3D"https://do=
c.dpdk.org/guides/nics/overview.html">https://doc.dpdk.org/guides/nics/over=
view.html</a></div><div><br></div><div>So, it looks like there are a few (Z=
TE DXDH is an example) that are also supporting QinQ Offload, but not many =
right now.</div><div><br></div><div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
I also wonder if the definition of expected behaviour is preventing other<b=
r>
NICs from implementing the feature?<br>
<br>
Can you also check with VLAN stripping enabled? My biggest issue with the<b=
r>
behaviour description of QinQ strip only removing outer tag is that it<br>
implies for QinQ traffoc that VLAN strip alone should strip inner tag witho=
ut<br>
removing outer. </blockquote><div><br></div><div>Sure, we can check this ca=
se. across the NICs at UNH. I have a sync wth=C2=A0Dean tomorrow morning fo=
r this, at the end of which we&#39;ll share back to you what we have.</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">That doe=
sn&#39;t make sense to me - and I&#39;m not sure if NIC<br>
hardware supports such features of removing inner headers while leaving<br>
outer.<br>
<br>
/Bruce<br>
</blockquote></div></div>

--000000000000da18080639fe5b0a--
