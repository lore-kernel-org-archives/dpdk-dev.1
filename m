Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AFAC88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 11:45:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92E684067D;
	Wed, 16 Sep 2026 13:45:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F3212402B0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 13:45:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789559119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fu5Gas4yu+fLPbHl29aj8wyNalEZLM51sONtfeWG7BU=;
 b=JbzxEL3qgM5N7go7OXnVd7BRDLBY/ibfZ54jhBTb3C10tx8JekUjNFG55z2NiPpPVzPFIW
 lGSoZsRj1lwF1Zad6mY05Dy0lKL+0nsqTTSQEjSRyzYimSF/iqyld/6+mp+rrU50xDFqHn
 9sKCarmFcEmR28q8iZ43tvClB4o89J0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-XD-vhrHDP2OAu1S1cBzwhA-1; Wed, 16 Sep 2026 07:45:18 -0400
X-MC-Unique: XD-vhrHDP2OAu1S1cBzwhA-1
X-Mimecast-MFC-AGG-ID: XD-vhrHDP2OAu1S1cBzwhA_1789559117
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a3546bd99fso28834101fa.2
 for <dev@dpdk.org>; Wed, 16 Sep 2026 04:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789559116; x=1790163916;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fu5Gas4yu+fLPbHl29aj8wyNalEZLM51sONtfeWG7BU=;
 b=tn6GjY1EFD7g4dWRpNRKgDMrOcSs4kqlbPqduPnapqxZ3Soq3sDZvGHVZ9qAXTGcmN
 dpxikU9iJrrIoWEBKbg0He9a5azTfxBZSwuf+xWt8PNQAXt161c+kElpW4OcVJ1Zxwjn
 OUzxOqO5EVyWhiiy+ZjKQiRcyrXrSMNB9oQ3fwIF9W55/tdNDYhnrDxxvY8Iy1Iwuueu
 5TCmYhsf4cSdYdkVevnuoHtZcfb5OUQvHLVIn3g3NDLnZij3iJfb6jOcUIA0KqEiAXzV
 J9L4UHvpIWoMCioRRBnVRR6/LYbOIRd5yV7bMFqO5F1zy6s1Ip8008HttN0JlwDh0qyK
 GoyA==
X-Gm-Message-State: AFuF++nc0msoXcSMuhKnnc8ml5x9Fyyd8UkZPX7Wey2UQHbHswyf5YMD
 UhBSiHJEaR+paa8RNAn4LNZpIyXmYkOpLmxsSbZwoaMPvDNUc/1yc6hn/f1pHmqcaK94S8DWE8q
 ouRg4uJOa4Gk3vjaxQxRuOZk1qioIu0Hm9bPNp5zYtkX2PSG5xbLjAEmpz8PH5nQOk7BpJtBwdd
 OEIRlZfPeEPj5mrGGHu0c=
X-Gm-Gg: AYBFou0k6i+/J3/9MQ/6CSf7TsYQHM+OjUAUB+7isMIKrlTb2tCnR7qYZXUT+c5r/TR
 a/RY/B0tRLCTkpgfWrXy4FbUbIU9tHVRzwQF5QeRZnX+2yWv512P8Gl2JP5/2R0rYbwuTT41wSg
 y/i8qE2BxOqXKajcYG/+agQLlwo9oQ6tIKIMc8E/a4E8FJSBhBYJVjXAuauGn6QmItz6i4NiYmY
 e0XCS52hhK5CR0DFi0fRZFpB1asFvdDxSOMsi5VIMyr+I6G
X-Received: by 2002:a05:651c:2213:b0:3a1:8510:cbab with SMTP id
 38308e7fff4ca-3a5dca2d444mr8205311fa.12.1789559116517; 
 Wed, 16 Sep 2026 04:45:16 -0700 (PDT)
X-Received: by 2002:a05:651c:2213:b0:3a1:8510:cbab with SMTP id
 38308e7fff4ca-3a5dca2d444mr8205191fa.12.1789559116072; Wed, 16 Sep 2026
 04:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260609043220.930405-1-syalavarthi@marvell.com>
 <aifFFS9gvRn9JYKg@bricha3-mobl1.ger.corp.intel.com>
 <aifKOnqQRhJ4z3nh@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aifKOnqQRhJ4z3nh@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 16 Sep 2026 13:45:04 +0200
X-Gm-Features: AcwNN1XSl5Uabw7B-sAC4-i8zvYp-6bC3GGmtoIhp7hxIaw3p43NlUxSifCh2nA
Message-ID: <CAJFAV8zjQi-9MHaiZdmZoK8wS10GtYA9taN3GN4sGgoMFrxquQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] buildtools: remove absolute paths from pc file
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GYd4Jan1kTl41FxmXcFiRivGl5ZSVdEkvB54G4rPGXA_1789559117
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

Hello Srikanth,

On Tue, 9 Jun 2026 at 10:09, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Tue, Jun 09, 2026 at 08:47:33AM +0100, Bruce Richardson wrote:
> > On Tue, Jun 09, 2026 at 10:02:20AM +0530, Srikanth Yalavarthi wrote:
> > > When linking with non-versioned libraries, absolute paths
> > > of the libraries are added to libdpdk.pc. This patch replaces
> > > the absolute path with correct linker flags, -l<libname>.
> > >
> >
> > Do we need to check if we need a "-L" flag for some of these paths that are
> > stripped?
> >
> > > https://github.com/mesonbuild/meson/issues/7766
> > >
> The bug report indicates that this issue only occurs for some libs which
> are missing an SONAME. Checking the .pc files generated on my own system, I
> don't see any libs listed with full paths. Out of interest, what libraries
> are causing problems? (Alternative question - how can we reproduce this
> issue to check the fix :-) )

I see no progress on this thread, can you reply to Bruce please?

Thanks.


-- 
David Marchand

