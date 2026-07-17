Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598A6C44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:35:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C55C40E1C;
	Fri, 17 Jul 2026 11:35:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 03C4C40E0B
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:35:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784280924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CvbvYM1fmBLXt4aQk5JqFWVfO7EXxbnClVjdDmWrSjQ=;
 b=dlRz6CFy18ijV6UDEiW8wLoSozn6xmzHTb9UD3YZkVXlA+BVMABlCZ8UHFsI7rV6o7yen2
 qHy7HouBZkBIfe3gHxsxzsHlVkc8A35i7UU0y6YrYJfj1YoP4+yPCPfMx2Vig+6alKfrJZ
 enDqXG/qAY03LGsI4xvpcly3yY3zVu0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-ArTnOgI1OyKFdf7I-TaZpw-1; Fri, 17 Jul 2026 05:35:22 -0400
X-MC-Unique: ArTnOgI1OyKFdf7I-TaZpw-1
X-Mimecast-MFC-AGG-ID: ArTnOgI1OyKFdf7I-TaZpw_1784280921
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aeb711dff7so4602934e87.3
 for <dev@dpdk.org>; Fri, 17 Jul 2026 02:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784280921; x=1784885721;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CvbvYM1fmBLXt4aQk5JqFWVfO7EXxbnClVjdDmWrSjQ=;
 b=aBOjEOswA6yEaQpmS1gs0tMqdQp0x5uH4miit4M7GIvn2LzTPOjtYQSPB8DC7NmJYd
 QDLRbxJHVPQvFqwphXPE04TstkIyxpFirdSBsCE8JxUhypUVTW98nyGkVN5fRnQ93tXl
 xZCm7mvTQkxveyuIkkj9Str2EsML3lU8g0jSvmcHUPjSPo2F5tXuzgfb3q0jb3av1KMP
 Aca4Jvi9nqbZ9eBVaLeNVf3J9lg4CeT1zJAR36Yc59mu3/DAhDAdNzmUmXeW3FgHY7hU
 1tteT2Zwzrb6towwWzInaZ4MJAGZZfSYFdKF/vyw7M6JTeextfNB64piuVTwlK2b9o3i
 OQ2g==
X-Gm-Message-State: AOJu0YwTRSsaIuUATPyJ3zhd4xXbeXUDXRNkw8vc/QmmI7tSKmP7WO9R
 G2q+IjL+WWsWv9YWn1uyHwK42g5p/jvKElodKwK64POFgTGm6fTptw+lTM2wM2EW8GsCbgbVAiT
 sUS2hLg6ubiG0CD1s3PYEq3uL7bhvpdG5ZZyh6DQ2uNSRUtTab8/tl6CXOMR1eIdAQgxAlHuUys
 uk7F4pdcXpIPxnyIHCnPyUUuEjMRg=
X-Gm-Gg: AfdE7cl3x8YeHeCJIpTRngoI0iKek4LllUApO4e+LTnzHkNkf/3zLMRZCpDeyoq1eba
 eNwOyV783uHSdfXAcOWjO1frs8CGBmBChwzu0We3o1Ha8kZ2qvXUArlLQ38giMLyVBTsjtRWp7O
 x1rw8Qyl1qKeSphrNPBnK3XL9koB2jgOHbnh6EHom3trDt6b3hljMs1Ac6v9L7ODVCLbKWmX+lc
 HivRR/IZOfvkbCo3K0k9yidjilbJX/ZErKlGL1UXs/a7tkj
X-Received: by 2002:a05:6512:800b:10b0:5b0:1eed:f707 with SMTP id
 2adb3069b0e04-5b28f87d8c1mr321790e87.23.1784280920735; 
 Fri, 17 Jul 2026 02:35:20 -0700 (PDT)
X-Received: by 2002:a05:6512:800b:10b0:5b0:1eed:f707 with SMTP id
 2adb3069b0e04-5b28f87d8c1mr321781e87.23.1784280920154; Fri, 17 Jul 2026
 02:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260717093006.229370-1-david.marchand@redhat.com>
In-Reply-To: <20260717093006.229370-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 17 Jul 2026 11:35:08 +0200
X-Gm-Features: AUfX_mwcWyf53v-0qQwGiIQQIarFALN_odHytPboel3sL0Wn-rggq4p2TufkMyI
Message-ID: <CAJFAV8yS7WNYSuuJV3s=a5FutXkg0+3W+VJ4xvXOXrsfHd18WA@mail.gmail.com>
Subject: Re: [PATCH 00/10] Limit usage of internal API in tests
To: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GtDzYDPpqe-hlrNitGvAM7TvOvRaYTov2R9-o8eLRbY_1784280921
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 17 Jul 2026 at 11:30, David Marchand <david.marchand@redhat.com> wrote:
>
> This series is aimed at 26.11.
>
> We had a few bug reports related to internal (and experimental) symbols
> issues during 26.07 development.
> See for example https://bugs.dpdk.org/show_bug.cgi?id=1957 or more
> recently https://bugs.dpdk.org/show_bug.cgi?id=1967.
>
> To catch such issues earlier in the CI, this series proposes to run
> the unit tests through meson with the ABI reference unit test binary
> against the current ABI libraries and drivers.

I could have called test-null.sh for checking testpmd too.
For a next revision if any.

>
> For this to work, some unit tests must be skipped (since meson may
> invoke the ABI reference code with tests that were unknown at the time).
>
> A few unit tests were directly dereferencing internal structures and are
> reworked so they use public APIs.
>
> Additionally, unit tests were allowed to use any internal API which has
> hidden a few issues (like a public API backed by internal symbols in the
> hash library).
> So disable the global ALLLOW_INTERNAL_API and move it to code explicitly
> requiring internal API, with the hope it will push us to have better API.
>
> The last patch contains a hack for now, where the cached ABI reference
> is force regenerated with a branch of mine where I backported the
> fixes of this series.


-- 
David Marchand

