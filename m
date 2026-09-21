Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B99EC982E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 17:31:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49F9940E2B;
	Mon, 21 Sep 2026 19:31:22 +0200 (CEST)
Received: from mail-pj2-f21.google.com (mail-pj2-f21.google.com
 [74.125.227.149])
 by mails.dpdk.org (Postfix) with ESMTP id A42934067D
 for <dev@dpdk.org>; Mon, 21 Sep 2026 19:31:21 +0200 (CEST)
Received: by mail-pj2-f21.google.com with SMTP id
 d9443c01a7336-2d747f0b25dso35354485ad.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790011880;
 x=1790616680; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3hkHAX1ELonQrgeTQO21ojmwrduWkGubiFYVHgf9XEM=;
 b=kcTjQEhyytBlbyMhu1RBsm41+d3mjT1AWz/9Oa6Xj9suExoFQhP6wlVZ1Mvv9a3q0C
 pO8c3Y+6jxChcR0yGtkV/f6m5cGzYOCa/bFG0amRv6X7682rYPHSHo0JpxZNLIf+AvyS
 +c6WCkyEnSC1hNssYt0AZzj0ZpoPE4qotI7VvQDhkS7WxFmkfbQ1GGCU++JgGK30TTXK
 ayomcQ4FAEgtSQhBEtGys3NltwmyWNHnsnY6WuhvgcbfiaXC/QLZ1b2XFTXrPQBLS6Sw
 5CGoott2QflmtTmUApRxx3tbAkca6qzgu3d0CjXxR8WzcbBzuSmJTm2pi4GeJcm+WblF
 ptyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790011880; x=1790616680;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3hkHAX1ELonQrgeTQO21ojmwrduWkGubiFYVHgf9XEM=;
 b=cnrzphOmxE97J4JW9/U5tqpEssBCrZSa0SxxSMuNcDIfWThiE2iCopy8wbEgaLOeYr
 UZ/Uli2kdQDtj419hFh+qzeWhCQNWRkN3AxeUHiF15Y21X+3Q37T+djvKdUJchWNbAuV
 eiadYgMi99LPyQF3g5ZtScEW0CX5wCCZqVE4tD4v9kK7VPqsj8u6VoqLKrqoIlvH2NNW
 nLWKun1PBhp22cGWR9Aapn/5ZvbPPth5LDrKBhn7Uv4AYJWbzu20yhaPRRF21pWXDGnJ
 sGnEqyXKuUzi2GbiOlqg9Jzx7wPt/CnvZojXsvilEyPDOd3cOc4yNgwuklpFHux3w6Vg
 Debw==
X-Gm-Message-State: AFuF++lzqzRUdwAIA3EWUvDJvTkl3y131FxvdoVA2GQZZtCD5P4zTZ9n
 uAbnTmu3Cn4ecfOancKvgugElbNfxAloTwaIp8xlrUz1SPwqKANLl7Ccpm8Pciyv+KE=
X-Gm-Gg: AYBFou1yFBVh7iar1hGorAR9UQdXMIn2/BOIL6yc/HiL8qCaQyPl3KtklCYPbzTOtIH
 One7pdaun5kYxof8Q2HFKdhMAdzjAQeq2EdpXTct/Ex9y4E1DFRLSLOk6ZYuOcf8dx7BUVCeAUi
 8W0/LvXRT3AqaXdiT6lqX0K9MEkTISNevplrIWYHfk4ex05OW7PYpCAEMYuoC4fjgcWNLURUq0F
 6N7VNDH4GpLW8vUnCcarDp0XoCAqqqKdUrPsIwTUQRYgLwXIX1qfXU4thimMixnJYwYdvREGBX4
 wz9nJN9UX38GnFoEuQ8htzQvo5wzyJ7sgmr0rHjoVrOlxH8VI3H7IWUEGNpQpOQ7cu7l4J30VZ0
 dmkm7ZVpn/vrT4S41QFFgomMSRduP5WN3A1jHkZ8qPdviSFVN0r6IkSGe7bIObztalmSt0Ri2kT
 xWdde58sjPuxyh1B5U+tgTYrqq76c3a3rGXvVPUapkVUIPqh8ykadUXDb2iMnULw4sD1MrlqnKP
 Hzqx2rd/+ALx+IYTv7LGLOAgiLpIYU/W2ON+4kc
X-Received: by 2002:a17:902:f647:b0:2dd:b20b:76c8 with SMTP id
 d9443c01a7336-2ddb20b7f24mr169656515ad.16.1790011880421; 
 Mon, 21 Sep 2026 10:31:20 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddc17ba2c5sm37863345ad.49.2026.09.21.10.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 10:31:20 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:31:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] examples/rpcapd: demo version of packet capture daemon
Message-ID: <20260921103118.405e396c@phoenix.local>
In-Reply-To: <886c5070-d766-4119-971b-7470f71fc8c2@gmail.com>
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20260920190007.1128720-1-stephen@networkplumber.org>
 <2801d980-791c-4552-a9cd-4ad705ebb196@gmail.com>
 <20260921085859.5de77f91@phoenix.local>
 <886c5070-d766-4119-971b-7470f71fc8c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 21 Sep 2026 17:43:31 +0100
Marat Khalili <qm2k21@gmail.com> wrote:

> On 21/09/2026 16:58, Stephen Hemminger wrote:
> > On Mon, 21 Sep 2026 10:51:39 +0100
> > Marat Khalili <qm2k21@gmail.com> wrote:
> >  
> >>>    examples/rpcapd/meson.build            |   19 +
> >>>    examples/rpcapd/rpcap-protocol.h       |  127 +++  
> >> Could we just use one from libpcap?  
> > Could but since most distro's don't enable rpcapd the header
> > file is not exported. We could "vendor it".  
> Is it possible to use your new app without having a full version of 
> libpcap in the system (that would have this rpcap-protocol.h anyway)? In 
> "Client Setup" you mention that libpcap must be rebuilt with remote 
> support enabled, and at this moment our own abridged copy of 
> rpcap-protocol.h becomes redundant. Our copy allows building the 
> application in systems where rpcapd is missing or built without the 
> remote support, but then the build result cannot be used. Am I 
> misunderstanding something?

Read the docs, there are two issues:
 1. You need to rebuild libpcap since rpcap is a security problem,
    it is not enabled by default. Tcpdump et al will not support
    rpcap without rebuild.

 2. The rpcap-protocol.h file is not exported by libpcap and
    considered internal. The original is too damn messy to use
    in DPDK as a copy.

