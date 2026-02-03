Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE713E87847
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 16:26:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1EB94029D;
	Tue,  3 Feb 2026 17:25:59 +0100 (CET)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by mails.dpdk.org (Postfix) with ESMTP id C75D14013F
 for <dev@dpdk.org>; Tue,  3 Feb 2026 17:25:57 +0100 (CET)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-5636784884eso1815015e0c.2
 for <dev@dpdk.org>; Tue, 03 Feb 2026 08:25:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770135957; cv=none;
 d=google.com; s=arc-20240605;
 b=UVqpJTggeyozfGLdqALoz++B9GpxOm/euXPjwPIU4MBOQ3jueZjNyjeRdYJfxUH4/c
 cWosavo80wyKlyEGbiJGgy8omuz724oYSM+VO28XMBvvyhN9TKRBg3B+dIazM0hfzGgV
 kDA266M92SBC8lTzN8MTwyvCafGM1AFT9CGGm3Ifv2wmG36sUgPpJ9BywoUR5KCYnSyH
 gJ3WDzBUq7qCxKIM8U5JMe7pPhclnmEgjIn9fMIThCNFPLwyNiD4R4rhZ640ACQqEfO/
 0pTglZnTQYC6ldgSEpzZW4TKia9JbhVp7kxwZBaWJcxGYn5rUAxjwvRkM8knM+6/zxDp
 mkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=chh1OpyDw0+cLct1YZcL1gGN6ofA3HkdMQjut+pfmug=;
 fh=yJXn0O5bmHk3V+Nt/ftQ0LS2md/MNWYVuxNrrg4JLcU=;
 b=PANE5SKc839s5j3yVXVwV8SPJSBMmbjdla9pwxyLFwcRUMqDDcdpHs8K9qAR9WdPNZ
 MrbKXQ08UeVn84dapgvH+WWJGTDt8X+9c8vld38TjBJx2LVyAhYJhHB8bErYac+T0t5L
 LocxoxciIkWb/gEKmpfztB5rl7kcQ6EKwjjBvBxRsPxQd/C0+S2u1PiJTlIbzVdMWv8j
 V8bzaWjS3+7191pTlLF8qykgWGSJDcI6TMb1pA5GvUKWv5gPNlhcU1PQDVOEDIS2yK3l
 fBvy5Kbw1KY9Gd6HsDdygBe+RA1bQdZ+bvDeF6NQaTRfN7rM0cCgCaxn2gY9gNgq8+AP
 ukMA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770135957; x=1770740757; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=chh1OpyDw0+cLct1YZcL1gGN6ofA3HkdMQjut+pfmug=;
 b=bHxk+Tn1bq+PkACE8oNp4i3l6YlnblNEhCsZSUOZcYEsIWpl5s7K2PMOsPYkrbJTmO
 x7inPux313E+LAacGdXQWCpoQZiu45iPd0TcLnS3LAEgie8v2PPQscdFVK5vtSPlb1ND
 tksCSrH7BZG+g6sQr8PAqM/UkKbj1RvxOcZIdp4aqYAFiUroV2lV3QcJREIQOX72QIlI
 6QYyLPwqwqyMtumq6BJT2cV1cqKl8tQJFJAUcpBIa4YYMss4LR7VGc1OFbHwmX9kIJ71
 pZQ15wV3a/93+5QmeWvwi1QcERSGcR83+pNYe6h8w2z8on/zVYj+dJaFfKY0vQyIorvT
 j5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770135957; x=1770740757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=chh1OpyDw0+cLct1YZcL1gGN6ofA3HkdMQjut+pfmug=;
 b=KGt0fmn6l3mqFE5KoLjGmwx9HL3kMZLVISL52Uusdt4jc83rF4A7g+NkSDkATHphcm
 rUL5OkblJYYySzu5JTf21wYifk8NRznXxcNvVOzlLxqnagw3EjCqHv+Dj1DwrIoOsNGK
 ZUos1PoKVrgWaYBg2WVURysPP54PDTafBuQoAznHk9J3XoAIeCpewtdRVlJSX2wjdrBp
 okJjn/gIw89iWGUyufsCbVpqwb41jRFwCWrKN+u1gQ4Eu0uNjBTBKO0WXMsC3h5r5t1A
 OScxUMNmKiqZoyvbyFOxX7FH881QCbUQfJ7100pATSFNsA5F4TlOhYsNKOoX7a/5xIgc
 CLEw==
X-Gm-Message-State: AOJu0YzpXX0u3M9tfmr1PL6LQ+OGXRSIRZoNZR5Srh4zj82y+vKIc2tE
 4ifBA6KVQ7l0BgTTPYuLRem+fZEpCWZjhnEcE1h8erlgE2DnwfknBbQJx30+ERikAbQY/c+jLEl
 z95LXLf01ks2fG32yCSbXuy0f0+ba6m0=
X-Gm-Gg: AZuq6aJeFVmedLZUydQRYU6G220weglF0GYTat3dSGReXfqa4MvOIpyA1zupE8bxvff
 fYPa1mC8g7LA/+84P0a5TnmKJ0U4k/e1hHYnwU2GtFmU50dBQZfsh2YDx6iIzzP3nAXT+bInqhv
 B9uLqukDFncEbN3R6h55nG+PHy2wFU9NSsNeprZ5rSA4JC+VEV8uja+LFCK6dNPxdw+7XckeeI3
 hrhL9F/bEQXS2uKY9MI3KET3P0fV6MS7pzsnHnBUrkKC2ViUVaeTNiXNj1fH1mijHEkUbN2aLlT
 fBzRazuF
X-Received: by 2002:a05:6122:1801:b0:55b:aab:95e8 with SMTP id
 71dfb90a1353d-566e80152f9mr56431e0c.9.1770135952061; Tue, 03 Feb 2026
 08:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20260127052900.68045-1-scott.k.mitch1@gmail.com>
 <20260202052442.92192-1-scott.k.mitch1@gmail.com>
 <20260202052442.92192-3-scott.k.mitch1@gmail.com>
 <CAJFAV8wayi8bsYXsUUb=HmMAcppxF1Brb=owY+4S3WQiGyGuFA@mail.gmail.com>
In-Reply-To: <CAJFAV8wayi8bsYXsUUb=HmMAcppxF1Brb=owY+4S3WQiGyGuFA@mail.gmail.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Tue, 3 Feb 2026 08:25:39 -0800
X-Gm-Features: AZwV_QjFGuNKNGZUJ5JfLhdv829-aPx-VAYmePL6XuULbsPTPoFcYhtAdzpi09U
Message-ID: <CAFn2buCGBExdf=57eOu7+DtpBvOfPQzQkbt24jDXZUmx7Wn+3w@mail.gmail.com>
Subject: Re: [PATCH v17 2/2] eal: RTE_PTR_ADD/SUB API improvements
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com, stephen@networkplumber.org, 
 bruce.richardson@intel.com
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

> Do we *need* a new file for testing new macros?
> So far, everything went to test_common.c.

I'll move into test_common.c. I'll keep independent tests that verify
pointer types natively (existing tests use uintptr_t).
