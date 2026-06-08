Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EC3CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 15:24:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3FBA40664;
	Mon,  8 Jun 2026 17:24:50 +0200 (CEST)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 36B16402DD
 for <dev@dpdk.org>; Mon,  8 Jun 2026 17:24:49 +0200 (CEST)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1363e78746eso4759762c88.1
 for <dev@dpdk.org>; Mon, 08 Jun 2026 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780932288;
 x=1781537088; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWHb9erEhuaWCzKqkL8LDkzhoQJjkY4adMHouwG5uy0=;
 b=PwRKhP66JHI/w1Si/cEbdjtn3QIJfc74uO8bmhtQU8ST3xsX38DJvKqYYi6S06PN7k
 1prjpvaxqGB6DU7XMINHg2/QZwYB2pq2XDBVWX/a3PUHKOWaR1V4eQ/YPZsYN7qmp3m5
 d34jaO2Bx6aGk2wmqX4ANbTq2UU4Q0n8XkjJtxAvfpa/hBt6EPM3TACMHstEZaHSMcZC
 dK1X7jM8svENdWuCg4niQuQj6RcIyiKHucvfOfBO+PSds/pkmiyAHRInjq7/3wppe7Rf
 NUbTWUewYUT+eKHVVGYkr7UNqFpps3SfBQMu99EiWzQ+Dfe6VXrV5N4qdLFzn/7k6/cU
 ohfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780932288; x=1781537088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QWHb9erEhuaWCzKqkL8LDkzhoQJjkY4adMHouwG5uy0=;
 b=FmnQf5doX+CMJ1KoYESqNJ7c/bWpjHsPnYbLqmMIzZSydLaQeYFMw/pgd75DRkgixX
 f13B5MyvGbSzo0XlkBnyG5tT3WjupRLxR7GjLqRps/y9ub8qGy2kUqxU9gTmXXSVSOlq
 wBaa90UjQb/J+jZkABIcjbqhzs89YB+N1PXz7Ibv7CErbJPiECjlmckHS/YgveWF27og
 WcUOCSY5M3T+rNI9L9sNcE2X64pWWmsIe6VQojJAp/PQpO3teLnCg9eI3zdMWH2ivjLG
 l+/0B7BqnHDEstl6VTKpoHxx1H9tyT53kutEJFB8imfAtKkzoWKEKH8iDowymacLWifT
 fkpA==
X-Gm-Message-State: AOJu0Yz+ASJChuBoDKbbOjbnB0VVJ2N8E2CVccboVngWagJ4dAnnahGb
 Reg2NecdrUwWpQ9hMrQ+gfOLaqXkxAC0yK8I5RR+E3uqjfNWDxponEUy7vjFpro8R6k=
X-Gm-Gg: Acq92OHQIX4ndr8QRD7yUWufPFg89p8B4jNBCS3fYBr05Q8jFXALbOOz/Z6Ah1h+Nw3
 OT6iZ3lLMSHtKxU4DWifaAG7bd+6GC5O7zXO1YZvOL0mt/2V1dbpPtp1u3HIVWXWYgXU4wWropG
 RByOjlfVYrr7UK6FS92qp0bnK2hltLP+oM7p1sQ/G7qQxl2lLCADzPyubQHGH8mSBJdhh/vjTMl
 UiMQuyXI5sP/JjfNicXgkD2O9UDy2YkPxFrVbwb95IY45Dd+9KhUFCnQx6yusRwU23elahhao2c
 2scBhRckl0bhsiXbaokZ6t9h9z5i5jHD66JCAbsBevS6V9wxymLUx9vh4rsBatnynX67jm9JK+3
 Bxxk5kqqjsWDXrklvJDLcUy+hAB05xuBJiCMYd4pvxuFVS04OPvufTR7ac3C7LgVb/idNtli+ci
 HybvfkmH/raZ7ayuaNV4ZwEI053DLKjLGIFdxz9orjWNxtSn3/wNMh7431O8fYlwcSb6bKZRkOQ
 s0=
X-Received: by 2002:a05:701b:4306:10b0:138:12fa:3794 with SMTP id
 a92af1059eb24-13812fa38e8mr3287264c88.26.1780932288068; 
 Mon, 08 Jun 2026 08:24:48 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-138173e5b47sm5471886c88.8.2026.06.08.08.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 08:24:47 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:24:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Sergeev <denserg.edu@gmail.com>
Cc: dev@dpdk.org, shepard.siegel@atomicrules.com, ed.czeck@atomicrules.com,
 john.miller@atomicrules.com, stable@dpdk.org, sdl.dpdk@linuxtesting.org
Subject: Re: [PATCH v2] net/ark: fix unsafe env variable in extension loading
Message-ID: <20260608082443.7fc29529@phoenix.local>
In-Reply-To: <20260603053313.119342-1-denserg.edu@gmail.com>
References: <20260603052604.118850-1-denserg.edu@gmail.com>
 <20260603053313.119342-1-denserg.edu@gmail.com>
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

On Wed,  3 Jun 2026 08:32:45 +0300
Denis Sergeev <denserg.edu@gmail.com> wrote:

> The ARK_EXT_PATH environment variable is passed to dlopen without
> verifying process privileges. In a setuid/setgid scenario, this
> could allow loading an arbitrary shared library with elevated
> privileges.
> 
> Add a check that effective user/group IDs match real IDs before
> trusting the environment variable, consistent with the same
> protection already present in the mlx5 driver.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 727b3fe292bc ("net/ark: integrate PMD")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>

Thanks for the report, but it makes no sense.
DPDK already load shared libraries via -d command line arg without
checking. And running DPDK application as setuid would be completely
unsafe. The startup is not hardened in anyway.

NAK

That said, it would be good if DPDK had some security documentation
about what the trust boundary is and what capabilities are needed.
