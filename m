Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DC1C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 08:20:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F88440277;
	Fri, 28 Mar 2025 09:20:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B0BC140277
 for <dev@dpdk.org>; Fri, 28 Mar 2025 09:20:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743150034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lv6SbAQ/nXTdDonyk3oo1CA+sO/+CTB3OQsBJZXD9/M=;
 b=NUavgU5KtGidnalyEy671AmxyMmCXaUcTrKmPIwkCSesFQ009Dw6Jb4exWRyLbP+86eQMG
 USmJsLSS4i6/spVL2uptKgzXF+4545a9IbqHsfYEyCXXYc/OS/A/G9n/Ek2DaW3nyLPLfC
 R1mY3gV8FEFv6y66HTYTq70Q4hVKxDY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-in20z67APCa6ZUv_rEcC5Q-1; Fri, 28 Mar 2025 04:20:30 -0400
X-MC-Unique: in20z67APCa6ZUv_rEcC5Q-1
X-Mimecast-MFC-AGG-ID: in20z67APCa6ZUv_rEcC5Q_1743150028
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-54ac9c33f74so904663e87.1
 for <dev@dpdk.org>; Fri, 28 Mar 2025 01:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743150028; x=1743754828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lv6SbAQ/nXTdDonyk3oo1CA+sO/+CTB3OQsBJZXD9/M=;
 b=JDYoQ87drj+5Tcm7B5bZmNfM5WzigO8lZBXhF92LY3/Uu62eABnnSSi8I3hD78pHmh
 btYTFDzP4IU0PF6yS7oOksHcpbtSxMA7dTedJAobWOYBHh35xD7RrqsBSOeHGXsCC/ep
 4+DavveVCTU6ACv6gffjFzU5L95GxCfYaKCNe9tFH0KEaWNkdeVzsjoKoj31prL9zwXQ
 0cjuUVQictGWlaikglf7NvANSsPUHYOfu/a5tuSewQlq+YqyKiWgQzFuK9Z8H/4lhzLX
 nvZN9ub0/LsLGnpqF4Fq6l6E/R6YttYNWWwpuTfjj1Rc0KHfO0W9Fl4icvLv8ATNeOaK
 x/pQ==
X-Gm-Message-State: AOJu0YwZ6uHeUAX4+e0+6xDucsdWz4c5PD1xsXG+FoNLEZrxxRuu3Zrr
 ihRw5ON1bHOR/LOivmiNRC6xSB72i6cTxfKmFeaSS1Awh4Q4+SFWHJab5m3reK6cw5Z7+Kyor2x
 8nKhKnxO4RS9TNqfC9jdXirHksdYSr8Wn3LxeFWmjnXBUSyToUCBalOgJ6J32lZtB3FZ1EiujKC
 kqRT6VGV2FrKDa598=
X-Gm-Gg: ASbGncvT2LggUaqd01vmZp+rodX1jwI4T/HphnocNUJOehRdvr2IgLcRDpRrtPkkUIP
 zbkHFtOzKqrenM7CWUGQToaTMl6lQX+uWOvS7obHduNvPL8EvvMRCNKtTlgVFyKJpfRXvLIQUR4
 U=
X-Received: by 2002:a05:6512:5c2:b0:549:9606:adc0 with SMTP id
 2adb3069b0e04-54b0acfa2a1mr447276e87.25.1743150028387; 
 Fri, 28 Mar 2025 01:20:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtW+tUozX3YAJ9Q0yTMshMTGXvETpCLoVtwINYD7VcylTI6tpy9cLhDndw4+cy/MwPase8yfszLjyfiP0RXdY=
X-Received: by 2002:a05:6512:5c2:b0:549:9606:adc0 with SMTP id
 2adb3069b0e04-54b0acfa2a1mr447270e87.25.1743150027988; Fri, 28 Mar 2025
 01:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250327145202.2220153-1-bruce.richardson@intel.com>
 <20250327145202.2220153-6-bruce.richardson@intel.com>
In-Reply-To: <20250327145202.2220153-6-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 28 Mar 2025 09:20:16 +0100
X-Gm-Features: AQ5f1Jrp6IH07xg5mOmUKWmQY5cx82Mao0p2i2zRRdBJy3s33y2WyK9HAqgZz88
Message-ID: <CAJFAV8w8YT=2DVbxrXef=60AquicaU8xehG2fvdHye_9dMi98Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] net/ixgbe/base: fix lock checker errors
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iABdq2VBPPbEsDaQGCUJUejs9V5cIfw7UfVW9k6ef6Q_1743150028
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Mar 27, 2025 at 3:53=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> When building on FreeBSD, errors are reported in the base code by the
> lock checker (-Wthread-safety). For example:
>
> ../drivers/net/intel/ixgbe/base/ixgbe_osdep.c:42:1: error: mutex 'lock->m=
utex' is still held at the end of function [-Werror,-Wthread-safety-analysi=
s]
>    42 | }
>       | ^
>
> These errors are due to the checker not recognising the lock wrapper
> functions. We can avoid these errors by converting these functions into
> macros.
>
> Fixes: 30b19d1b5c43 ("net/ixgbe/base: add definitions for E610")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

This is the best solution, given that FreeBSD pthread is instrumented
with clang thread safety annotations.

As a sidenote, I don't see much value with the remaining
malloc/calloc/free wrappers in this osdep.c file.
I suspect this makes some other annotations non working.


--=20
David Marchand

