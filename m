Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629AFE63F22
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 00:47:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AE6B40296;
	Mon, 16 Feb 2026 01:47:38 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id DBE6B40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 01:47:36 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso28624925e9.1
 for <dev@dpdk.org>; Sun, 15 Feb 2026 16:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771202856;
 x=1771807656; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1PcS3h6V57beVWaMSlYCL7WxJrVOgnqgPpLlt0qKCUc=;
 b=qcf1GTeGGVyxcnaBAWhH7waOMRwvj3h32KV8MEp9evBdLwCX8/oR4VSB+frvdyMjTz
 xej7SeQwPwvzaDD/XN+y+P4x4mdJdfozatcIMvYF8qDD+7E+3bHZP3uNKY6O7oW72JPL
 XPMGMV0V1H1bekubnVvswBkGLELtw7QG5L0vSQBmTqKD/IqDAYhDxGMJ7w9Bg78nks3t
 oy3QUxM3IY+dYpwjUeOL2sYCR1awmgm+DUS8KG5CUjIArNYfmzRQtZOfgFCBuEcW84IL
 F/2aXaafT0wzGo9+Zl6olp8eD40QBP869NL6gbLbJtLqEVQfnj15vtd956KaGMQ8eWOZ
 qdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771202856; x=1771807656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1PcS3h6V57beVWaMSlYCL7WxJrVOgnqgPpLlt0qKCUc=;
 b=Dx7FzjNqcma/e0zPx/ZppsJaaPq86kPi2P97gn6G5dFfeSq9Vnl2pQtPVAbqQAsEMv
 CItIDephi0blUFozJvR0t9vQZ6/3ByG6BvlF/iS+cRn1wXfkesNvr/kVHLwaGZkWLowy
 xLuT6sJTQJOjtdopmyNQS/nZJj7YmyQz7JTeOU0v7AsTTRN9J7300xeFh7BbR8CS6tmQ
 WFXQg2ZXnS5bZHwEle2Ih41DIKqTxhm8ovKP6LM+iI0ExSo8G0f4XI7x4U10grGAGE+U
 ZLCQH/fq+QL4R9HV0rCX/6UqrSPGKPacGfc/w2bbBXaD1nGwo/4cn2OffetJrW8DGEJE
 1hag==
X-Gm-Message-State: AOJu0YzZRK/Er8fDLSaP9CenrZXhzJu8TmqnMU5ih/CiXMXtQ15IaEt6
 7hN7nDMRPDolTjuo5VH2GQH7q5K41t844VDskXCwgnU8iTICm+py8DyDneTZKTUYtsQO0kzEdEa
 AWyHND3glyA==
X-Gm-Gg: AZuq6aIToVezOCmdxetdgZ+boKFF5njvi0W1R5qbd5wWInZWLjLMaqA2DtOGq4dFdTn
 VSdLGD+B57fdc76fMDaPL3R0la6lNHjG/Nv9AAFYfR0T031SAS/036LswrzTFOn0keusatg8fGy
 1wfLriz8ILRy1e+NS2/p2+JXO2oAsgSmWGryiKoPJweOvW22BoOP2bYq0EpZj+JkMtpVU2CBSiY
 hLmJMa7HAeT1QlrsyE8+M3LszE+GdOkBIR6igJ0ot+d/oolWpFAz+TATYs/fCCFEKtA51XdMGvr
 lZx+84FIxkE2AXzVXDTlR8uPggYS7WRe3ISn2bI/k+Q0HetFoqHCpApGpOpKaPkX9EWJ+kro4Oi
 O02tMO9dD2aHV9thEiwWmQq9TM7qCvYotlr+ZfcBK4glPH+vVf1oo3NlvQ8VYHoe4rzVrh88wG1
 xNPYBNF/F1PRjBQgug2yD7dER+HxijNxcAIpH0Ot5uubbasoiBQhcTnYeHRDmY0fK5
X-Received: by 2002:a05:600c:1f8d:b0:47e:e87b:af8 with SMTP id
 5b1f17b1804b1-48373a5ba01mr161425465e9.21.1771202856184; 
 Sun, 15 Feb 2026 16:47:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a78c89sm225585585e9.5.2026.02.15.16.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 16:47:35 -0800 (PST)
Date: Sun, 15 Feb 2026 16:47:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH 03/10] net/tap: clarify TUN/TAP flag assignment
Message-ID: <20260215164730.0f36bdf4@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6571C@smartserver.smartshare.dk>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260215195348.557945-4-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F6571C@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sun, 15 Feb 2026 22:45:53 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> >=20
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  drivers/net/tap/rte_eth_tap.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/tap/rte_eth_tap.c
> > b/drivers/net/tap/rte_eth_tap.c
> > index aa236cf967..31c8c185e9 100644
> > --- a/drivers/net/tap/rte_eth_tap.c
> > +++ b/drivers/net/tap/rte_eth_tap.c
> > @@ -154,8 +154,11 @@ tun_alloc(struct pmd_internals *pmd, int
> > is_keepalive, int persistent)
> >  	 * Do not set IFF_NO_PI as packet information header will be
> > needed
> >  	 * to check if a received packet has been truncated.
> >  	 */
> > -	ifr.ifr_flags =3D (pmd->type =3D=3D ETH_TUNTAP_TYPE_TAP) ?
> > -		IFF_TAP : IFF_TUN | IFF_POINTOPOINT; =20
>=20
> For unconditional assignment, I prefer ternary expression over if/else.
> If you want to improve readability instead of relying on operator precede=
nce, suggest:
>=20
> 	ifr.ifr_flags =3D (pmd->type =3D=3D ETH_TUNTAP_TYPE_TAP) ?
> 			IFF_TAP : (IFF_TUN | IFF_POINTOPOINT);


I was pre-conditioned by MS style guide lines that always called out
excessive use of ternary as confusing
