Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE226606EEB4
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=doDyHFQL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E0A7402E3;
	Mon,  2 Nov 2026 16:59:04 +0100 (CET)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 395AE4028D
 for <dev@dpdk.org>; Mon,  2 Nov 2026 16:59:03 +0100 (CET)
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-7c3b6e8225dso2216189137.2
 for <dev@dpdk.org>; Mon, 02 Nov 2026 07:59:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793635142; cv=none;
 d=google.com; s=arc-20260327;
 b=qQlijJwkEV96baEbRYR1Ctlw6zpv5XU5ZNGomxwsZUqLDE6oXFFbArZUxhk7+G1O1l
 4lCW1370/I4fri9/k0uXvsaV/E1GRqbU5mY++S7LbuLgjFjgPCONIZ4LiXHbmL1mqX3g
 RA0YgMY7YuyVDMOSf0hVySdE4gV0stXgfUTQ3l5bCj27QdL8/g4q+hNbuBPOJ2lr0zLG
 jUsRFwoqBXFJZ6cio68/9CFL5dBIlzocg3iWS7S8eh5fIaJPm0rsui1a+/anGGuQ+vAr
 MqoJ8Qt5s1xqGBv1Nw0A30tscyTCw+5LcoIyIm2DsMBDJxLY9PMT7isAIpbku5YhMgs9
 ZwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uU9zs4N20Ye2yDdpYZG9iM+WV3BsE5dFa/Vtepc19Hc=;
 fh=RPOcZv55AfBHaPBLcqc8RPRDLQNOuWyXeQsDe3XupRw=;
 b=ROUpS8lB7yPq8wL0Nz15Oil07Y02QUalZugm4R44DOUEQPpAhyOiVBexkSBFeWl+vm
 dDMPHDQqe6mfv4GSn6/N6tVLkbmQOc+CzM8O3IrdF9joVGGNXUH+Zd6rsq2uvJJjViSF
 WBUAWSCMXT8U+5d1zUMQOBj5Pmne0Ipqx1rnErRRGUsk1jTpz7XGWZoaeCJ7+OVPC8yv
 rtYiGCgxLLXqWkkGF0rJNfpbT1r8SQwfOvfeRYo+wz96WIm5ZaYKN5IZl3UuRbNOqDHj
 at/pUAun1ggDvyqdw6wmc1k24d+hRso0MaediOzxFMs4cjCYG8wfhYdVC/XEFT9tp9X3
 luIQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793635142;
 x=1794239942; darn=dpdk.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uU9zs4N20Ye2yDdpYZG9iM+WV3BsE5dFa/Vtepc19Hc=;
 b=doDyHFQL68/CHxM94aqWeR1OuRjrWzYZkCoVwihsgFI+TluF/1UnEfEoy9qDoD4kJG
 Um9AeaKJ+bX8abvCPzoDdLFPKA5TCtRItCAmXYOcEN1CY1psWfpbhVOQt+TAXFg0qpPv
 6IMMvqZ9fw1MtED+ndwoK7Q5LxqzsnyU0DCA8UY7kx6GmTk81KqhnxhQv5VWR7htJYS0
 BF1zYhn6j771s5iWs2CHjUWd2OwJNd0AgGNAyZp9Bf8IgWRe8eGek6pVf85Ss0j4WXwu
 g4NzR0lUD4yRp4cLHSqAwhJ7RzcHen2/MCdc3GUZRy+hrrd5gBkeLxxeKTF5AuvT/1If
 2QVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793635142; x=1794239942;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uU9zs4N20Ye2yDdpYZG9iM+WV3BsE5dFa/Vtepc19Hc=;
 b=ODmYej3+RMtlonJL+dhrUaB5KpVHZKRGx0vvBVr9KE3RiWkLeDXC+0Y0dp47A2Y0OC
 hYDP7ViUinOt482YKaft0MUsnn54ubycNe6XlOKxFeBV5R/udUN6RelKDjIS08dtRtc8
 DZc6Gh2alOsuZldYBE4ezwPtMlNZEV3TtD7v3PJvj6GlGNPmom8Ym+7ASI0OnpY/i8Ca
 ipPrsQTFn/8IW1QBhCjsrrf3QHA9xOYPp7oiAUr8EsBz9EhldRu+fe4vk0l3mrRbDpBU
 /E8ltT9EjUZS09gabPcv/12pUFI93RnpU7Mq7yG+5NgV0WfqusY9XRnNMsqnvK4UAJm9
 ZVGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPNYCK7lJsmmX3RFN4GaL9vr7FwsXP30g5ApvKEPdtiFV5HMjBpgWd0izoztjoorZLccc=@dpdk.org
X-Gm-Message-State: APuU4Z/MQuKt9Pa2nZ3Avx1pRN/21n31Q1VECGEWH7bX1wrzz/7gQmkB
 /woattKdjQDJ9AI546nO37JofFJCSeJtCCec63vybRDIz+7i2VaqDWHoIL2j6OBIy9aK82JSOw/
 OwwJlgncWpwJPViVxsp0TZ3dK3NhDFstpBL9Trmkv9g==
X-Gm-Gg: AYBFou2MajB8mIILsN5SjDXBNR33Og/WLlODauERWvwQUf/ycu8S0uwDr6fCG+vy9LT
 SkWktbmoaFNqWaSbZyEVN1/+JWUeJZ3C1akBEvCrfX+2qOzP/IRBncUHqpd5cJsAFGxDbueMoBm
 kBp+Mps9aokeoYTWt9WrI2UZR7k3x2Hu37BB0mgW8rQM8CVGWzBI1QD0TDNGfgn78i5hWI8kXnC
 rM4VP7eRigAAkCSuo0CK8B70scu4obrjuxom13Cw4JxyDcJWiLo+dw3CC/VGX/uGyHNLjV19yUa
 lnS99vPismQN8kRZ2hcLdys22EXcSSyfKyT8U4ye+LY3YNDok9vBiSjnI0eUnqXFTnno+UPHVlZ
 plSPEX3VcS2y+7WME5gt5alBZzsPBHVmor4XsOVrzU99PxNh9y8CWGii9PA==
X-Received: by 2002:a05:6102:15a2:b0:7cc:776:6c5c with SMTP id
 ada2fe7eead31-7d07261533cmr4406166137.7.1793635141827; Mon, 02 Nov 2026
 07:59:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260914173700.2795983-1-stephen@networkplumber.org>
 <aqlYsYvgFaYTPcKT@bricha3-mobl1.ger.corp.intel.com>
 <tR3-FNBgRxOW6UbyTMi5jA@monjalon.net>
In-Reply-To: <tR3-FNBgRxOW6UbyTMi5jA@monjalon.net>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 2 Nov 2026 16:58:50 +0100
X-Gm-Features: AclHuK_o2YPKvuG_wPoLMcm1VKS_LIAtmrhdIeu1ev7nGwoUzoQfXVDZ8seGW5g
Message-ID: <CAOaVG14kRvQjQLANeGU_mJMc0Lz74i8XEuC7_qdNcMw6gM6dyA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] consolidate sysfs access
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev <dev@dpdk.org>, 
 David Marchand <david.marchand@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007c50f8065f4d39bb"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000007c50f8065f4d39bb
Content-Type: text/plain; charset="UTF-8"

There were just so many other patches for 26.11 and didn't want to rebase
this one of mine

On Mon, Nov 2, 2026, 15:49 Thomas Monjalon <thomas@monjalon.net> wrote:

> > > Stephen Hemminger (9):
> > >   eal: add common sysfs value routines
> > >   dma/idxd: use common sysfs routines
> > >   common/ionic: use common sysfs routines
> > >   bus/vmbus: use common sysfs routines
> > >   power: use common sysfs routines
> > >   drivers/bus: remove duplicate sysfs string helpers
> > >   common/mlx5: use common sysfs routines
> > >   net/mlx5: use common sysfs routines
> > >   net/mana: use common sysfs routines
> > >
> > Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>
> >
> > I double-checked this v3 again (as with v2) by running the unit tests
> > against a device using idxd driver which reads parameters from sysfs. No
> > issues seen.
>
> Why is it marked as rejected in patchwork?
>
>
>
>

--0000000000007c50f8065f4d39bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">There were just so many other patches for 26.11 and didn&=
#39;t want to rebase this one of mine</div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 2, 2=
026, 15:49 Thomas Monjalon &lt;<a href=3D"mailto:thomas@monjalon.net">thoma=
s@monjalon.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">&gt; &gt; Stephen Hemminger (9):<br>
&gt; &gt;=C2=A0 =C2=A0eal: add common sysfs value routines<br>
&gt; &gt;=C2=A0 =C2=A0dma/idxd: use common sysfs routines<br>
&gt; &gt;=C2=A0 =C2=A0common/ionic: use common sysfs routines<br>
&gt; &gt;=C2=A0 =C2=A0bus/vmbus: use common sysfs routines<br>
&gt; &gt;=C2=A0 =C2=A0power: use common sysfs routines<br>
&gt; &gt;=C2=A0 =C2=A0drivers/bus: remove duplicate sysfs string helpers<br=
>
&gt; &gt;=C2=A0 =C2=A0common/mlx5: use common sysfs routines<br>
&gt; &gt;=C2=A0 =C2=A0net/mlx5: use common sysfs routines<br>
&gt; &gt;=C2=A0 =C2=A0net/mana: use common sysfs routines<br>
&gt; &gt; <br>
&gt; Series-acked-by: Bruce Richardson &lt;<a href=3D"mailto:bruce.richards=
on@intel.com" target=3D"_blank" rel=3D"noreferrer">bruce.richardson@intel.c=
om</a>&gt;<br>
&gt; <br>
&gt; I double-checked this v3 again (as with v2) by running the unit tests<=
br>
&gt; against a device using idxd driver which reads parameters from sysfs. =
No<br>
&gt; issues seen.<br>
<br>
Why is it marked as rejected in patchwork?<br>
<br>
<br>
<br>
</blockquote></div>

--0000000000007c50f8065f4d39bb--
