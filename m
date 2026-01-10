Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA727D277CA
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 03:41:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ACF4402D5;
	Sat, 10 Jan 2026 04:41:52 +0100 (CET)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44]) by mails.dpdk.org (Postfix) with ESMTP id 8BB1A4021F
 for <dev@dpdk.org>; Sat, 10 Jan 2026 04:41:50 +0100 (CET)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-5efa4229bd2so635009137.0
 for <dev@dpdk.org>; Fri, 09 Jan 2026 19:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768016510; x=1768621310; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3m041KXcPV2IRoodo9nxvUfYpvp9PFTvTqwYl8bkzqY=;
 b=c5WdVVWRFbXlnf4NWkGKf476KBI3KVx2+ZxMPwawsZl0uhDZQ1kCbWGuYp8DCZAYt5
 cttyAikGfBB2h4xvHujXpn6X50TDG4ZhRilQLpnS0rcafgrv3GHE7teRfk+du7OcUfSL
 VIX1zPNMKEHOGODI2kHzCEpq4Lbe5uWAUl8+M3QYKtDPC0rbQVzC34x+AN6pJSIo0fqk
 bx1Z+rj6hFXCRotoQgqNYg4uTgzGuvr7HDYgCq6w6L9OttvC14roiO6aBQve1FAtoB2l
 mb3a4ak0gdVMx8jybSeED5azRDR7saMQEnA87+Eb3NPI1p7gWlt3Ubu1gIjuufazkL26
 v+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768016510; x=1768621310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3m041KXcPV2IRoodo9nxvUfYpvp9PFTvTqwYl8bkzqY=;
 b=qZicct3rcMKJbnXmjl2plbWh5BQh42+WVlkBy1LlQ5D9xn2ZWBkZNdBncaI/Fd9kXF
 H7tnVMZ3JpdMITG9It+RvGvweg1EtJLqTWtnaZrCCJY9F4uX+K6n7ElwlhOXdpt0ij/Z
 ZyFWkAFFNr31+hUzTmSdTH5ng4IHxb/Rpc14kgSlkgGxG1IjGs5KfFzaPYX66aQWWiO5
 bXZkt0JDtx+JZkd5QMDHw+3f+D2ZZa+BAbkCt/7D3qtVdNEfLUp+0TpoK9ymFHMUsKuF
 afj65vDdyMn6dSrI59KqfoWoVgWJ8OZ+60LzmR/L/TNKS3J7V+wtx5iyrajOQthSS3jc
 U6hg==
X-Gm-Message-State: AOJu0Yx7NhmBebQmyseFWHfGN5JLLdo2vkeGSUDI+Rvsry/JEIj1Obc4
 mFD5DOSizAegCGjcfCXXKcSxd7Zp1mSlHaJaA/zhW0i23r/oCYyMLRndfJhlH2FCPk+Gv32dL9s
 cBx27L0uTkbgz1YCHsotp4PNYbpxHr5nXWuWZ
X-Gm-Gg: AY/fxX602Gm9G0UPOcx9UbPc6/UIcOygBPe5JMOC+iFOIj4rAvqtSRMwF4sHr9h6p+a
 Qk6Ovkwf/HprDwO+HOaGwbV1lu4JhyxUTaVsO7xjEKcZTYED5y6WEACQGl8tN1DEGJqOodtBJdg
 fXRICPHOQLJwgGi1Pdc3EGi29WIasFu8jCWSITFqQMD6LJMs//Iy1IHj5OBLc4qqX00GUAjA4Ir
 0tWxbCNdoMCWQdlOHkOuYofNYnlB05asVMDw0aOIf4l7TZBiHJu3TOfji7MwYlBZQBm2b+Y55HY
 nhWNPDv8Kn+zAiU0X4ODEG1SBJ4=
X-Google-Smtp-Source: AGHT+IEEfAFt6m3rDBLBlQ4agfFrJ+pahvgMcG1T2wlopccyNIMAuesj6uyphCH0GphqarROE3+XT8qjIQBkAqUK5lQ=
X-Received: by 2002:a05:6102:548d:b0:5ef:7221:aa9b with SMTP id
 ada2fe7eead31-5ef7230f1aemr1560521137.18.1768016509655; Fri, 09 Jan 2026
 19:41:49 -0800 (PST)
MIME-Version: 1.0
References: <20260108230509.6541-1-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6563F@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6563F@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Fri, 9 Jan 2026 22:41:38 -0500
X-Gm-Features: AZwV_QjZYndQanRp5Jnph4u-3pF2pQP1ZVPYlyTTaNzReNMZYkqyft6lxhfgmZA
Message-ID: <CAFn2buB1o9nfJu+YZddVu30vhDr8rZDKv98zno5_8HzvxkGcrw@mail.gmail.com>
Subject: Re: [PATCH v11] net: optimize raw checksum computation
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
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

> Here are some more thoughts about loop unroll...
> In another mail [1], you are discussing manual loop unroll for rte_ipv4/i=
pv6_phdr_cksum().
> Perhaps the compiler already loop unrolls those.
> Check the assembler output for the existing code calling __rte_raw_cksum(=
).
> If the compiler doesn't loop unroll __rte_raw_cksum() for those two funct=
ions, maybe you can help it by modifying __rte_raw_cksum(); try replacing t=
he end pointer with an int counter, which will be compile time constant whe=
n called by rte_ipv4/ipv6_phdr_cksum().
>
> [1]: https://inbox.dpdk.org/dev/CAFn2buA5NzmzA0+t1_5auigvQTyT7Ne6RMVaPVU=
=3DsdC03nd2Lg@mail.gmail.com/
>
> PS: I do the following when optimizing inline functions: Add non-inline f=
unctions calling the inline functions, and then use "objdump -S" to look at=
 the generated code. E.g.:
>
> uint32_t review__rte_raw_cksum(const void *buf, size_t len, uint32_t sum)
> { return __rte_raw_cksum(buf, len, sum); }
>
> uint32_t review__rte_raw_cksum_len20(const void *buf, uint32_t sum)
> { return __rte_raw_cksum(buf, 20, sum); }
>
> uint32_t review__rte_raw_cksum_len8(const void *buf, uint32_t sum)
> { return __rte_raw_cksum(buf, 8, sum); }
>

https://godbolt.org/z/qr39hf76s
rte_ipv4_phdr_cksum and rte_ipv6_phdr_cksum are both fully unrolled
(-O2 or higher). Vectorization also happens (clang chooses
not to vectorize ipv4). yay compilers :)
