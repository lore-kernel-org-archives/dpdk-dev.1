Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA50CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 16:35:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4A964026F;
	Wed,  8 Oct 2025 18:35:11 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id B22EB40267
 for <dev@dpdk.org>; Wed,  8 Oct 2025 18:35:10 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2897522a1dfso147055ad.1
 for <dev@dpdk.org>; Wed, 08 Oct 2025 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759941310; x=1760546110; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PgMVNjai6c3hYoHke9+x3/7hlmCHJs/F6tsMj4OXDjg=;
 b=NTD0yctIdda0fcarFLztrBeA8Zvob5xmFcqY/arEOIcWxSZ98vf65JoNGtaiF+B6rV
 EARCvySdBPkyWVbqbPcpdH4XSw2C5hEcza9+dqoYzyrjqCPrPZQJ33Q7LIFjjOEFlN/8
 lyUKyaWKpOXocgYKYzHd94AXRWnPn4RdI92A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759941310; x=1760546110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PgMVNjai6c3hYoHke9+x3/7hlmCHJs/F6tsMj4OXDjg=;
 b=ZB2HUk0XKJSGIRgRASobSlg3tK8roFvSYVnOf+A2v4wXPH3fg11A+xMpn9JLLXwTRR
 bIhIlVGBq3t8i13ZmKuC2qD2aFFg/gABqKriJm7q4ton1AGf0yXTjqC++4ynU55dCzE9
 SWlozwXl6C2by9xQX/tft8uwtP+uhGt2mq105WouIUGNB879RypBRIiKzSQG09Ikm/1L
 pGG2FzPOlHhrDQhSyP5HZhMF9vlXH95Sk0TlRM0Ke0iP6PYyIA5qNv3uUqpReybApdMc
 p+Iy/fyuwfurZ4BxkTOLGL0hcFbku86lC+uy5nKIhVT6swgPfF1ePYLDkzlcoZ24OZ6d
 TLOQ==
X-Gm-Message-State: AOJu0YxYhUatzcCC2M3hj46lBNIXyYm6d5XHHbgwDDxlfDHcukbVcnkH
 91AOyrIn5wvdkMaz7GZo+43A/pl5TNTO0P695EWEHVZemXPicpzeDdG4dwm6ooruNGF+aR3iZUm
 KCMHEQ29M0QeoeESZuBXa4edpZbC3gFdbvvlhQoKvzA==
X-Gm-Gg: ASbGncvnbiCL/yn1i0V+OqrsQy9QgyOJM0BAh7BCgWRaxe9HeFQBZUFLqL4A/4BUP7x
 UNovuFOPmXum7rLc4yflt6nZqsyw5FwifyzTdPkrSHTgy0720lCiFBXydB9dBtCNTPgQkEBisyb
 96Z2vMOo80Ilwqmc4gQQm7fboTABZOz7YLDQvs3hESrXWxyN+F1ArTsEzO/a+oye+yrINKAVR1K
 v9u59p75hivum33oLrvyie535IaJe+CtplUsmqRQ8FzyHxKZj/WdcdYYOdUX+tX
X-Google-Smtp-Source: AGHT+IFGdlD4mLqMl3RUR2cDYGBDMZdjsMsdmrquB8QaFyqZrj0m4jR5hHi5LgdKcPJuSZeMJ2TjURZA5MwDdmhQ248=
X-Received: by 2002:a17:903:1b30:b0:27e:ef27:1e47 with SMTP id
 d9443c01a7336-290272b553fmr51443555ad.31.1759941309733; Wed, 08 Oct 2025
 09:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20251001231659.2297751-1-probb@iol.unh.edu>
 <20251001231659.2297751-2-probb@iol.unh.edu>
 <175992171905.88979.8170698746444654418.luca.vizzarro@arm.com>
In-Reply-To: <175992171905.88979.8170698746444654418.luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 8 Oct 2025 12:34:32 -0400
X-Gm-Features: AS18NWC1fNkiVqhhpG1wZeDntpEPPtlHEQxgODK1ryddT6VqZfUzrhZb1L--_EM
Message-ID: <CAJvnSUAz1CEoE6uPZUJg-cM5-7Ofi5GoLjsXCSwKtrPsRDSjMQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dts: rework traffic generator inheritance structure
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul.Szczepanek@arm.com, dmarx@iol.unh.edu, 
 abailey@iol.unh.edu, Nicholas Pratte <npratte@iol.unh.edu>
Content-Type: multipart/alternative; boundary="00000000000097b04c0640a84441"
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

--00000000000097b04c0640a84441
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 7:45=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.com=
> wrote:

> Hi Patrick,
>
> I am assuming the move of send_packets is because we can't send
> arbitrary packets with a perf generator. I believe this should be
> explained as it's not clear why the move and it feels counterintuitive
> at first.
>

Sort of. We can send arbitrary packets with a perf generator, but there is
a particular use case for send_packet (send a small number of arbitrary
packets) and this is just "better" done by a capturing packet generator
like Scapy since it is concerned with reliability. The performance traffic
generators have a different focus (send in high volume), so in my view it
makes sense to encourage people to use a capturing traffic generator when
they want to send a small amount of arbitrary packets. If you think this
idea is okay, yes I can update the commit message. Or, I can reverse the
decision altogether if you don't think my justification is sound.


>
> On Wed, Oct 01, 2025 at 07:16:57PM +0000, Patrick Robb wrote:
> > diff --git
> a/dts/framework/testbed_model/traffic_generator/performance_traffic_gener=
ator.py
> b/dts/framework/testbed_model/traffic_generator/performance_traffic_gener=
ator.py
> > new file mode 100644
> > index 0000000000..6b23faa1a5
>
> > +    def setup(self, topology: Topology) -> None:
> > +        """Overrides
> :meth:`.traffic_generator.TrafficGenerator.setup`."""
> > +        for port in self._tg_node.ports:
> > +            self._tg_node.main_session.configure_port_mtu(2000, port)
>
> should do:
>   port.configure_mtu(2000)
>

Thanks for starting a review. Do you have the hardware available to test
the patch as well? I am wondering whether my docs additions are sufficient
(I think they are, but a second opinion is always good). If you can't, I'll
ask Andrew to test it.

--00000000000097b04c0640a84441
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 8, =
2025 at 7:45=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@a=
rm.com">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Hi Patrick,<br>
<br>
I am assuming the move of send_packets is because we can&#39;t send<br>
arbitrary packets with a perf generator. I believe this should be<br>
explained as it&#39;s not clear why the move and it feels counterintuitive<=
br>
at first.<br></blockquote><div><br></div><div>Sort of. We can send arbitrar=
y packets with a perf generator, but there is a particular use case for sen=
d_packet (send a small number of arbitrary packets) and this is just &quot;=
better&quot; done by a capturing packet generator like Scapy since it is co=
ncerned with reliability. The performance traffic generators have a differe=
nt focus (send in high volume), so in my view=C2=A0it makes sense to encour=
age people to use a capturing traffic generator when they want to send a sm=
all amount of arbitrary packets. If you think this idea is okay, yes I can =
update the commit message. Or, I can reverse the decision altogether if you=
 don&#39;t think my justification is sound.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
On Wed, Oct 01, 2025 at 07:16:57PM +0000, Patrick Robb wrote:<br>
&gt; diff --git a/dts/framework/testbed_model/traffic_generator/performance=
_traffic_generator.py b/dts/framework/testbed_model/traffic_generator/perfo=
rmance_traffic_generator.py<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..6b23faa1a5<br><br>
&gt; +=C2=A0 =C2=A0 def setup(self, topology: Topology) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth:`.traff=
ic_generator.TrafficGenerator.setup`.&quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in self._tg_node.ports:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._tg_node.main_session.=
configure_port_mtu(2000, port)<br>
<br>
should do:<br>
=C2=A0 port.configure_mtu(2000)<br></blockquote><div><br></div><div>Thanks =
for starting a review. Do you have the hardware available to test the patch=
 as well? I am wondering whether my docs additions are sufficient (I think =
they are, but a second opinion is always good). If you can&#39;t, I&#39;ll =
ask Andrew to test it.</div></div></div>

--00000000000097b04c0640a84441--
