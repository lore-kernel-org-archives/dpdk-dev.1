Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74F4C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:38:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2316540283;
	Tue, 22 Jul 2025 19:38:29 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 915964003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:38:27 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-23c8a5053c2so55038865ad.1
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753205907;
 x=1753810707; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPblH1j/xZMXIegVUSLcKz2r8cP+fyII2ULvQCzQFds=;
 b=qRS7Vub6VK6ZtBtsqdc+M7+cytwTdecPd3tACtqwmJnQqAoOcUAhr7tz9Jf5bTXzLO
 seiIq9k+epOFaONSQ0uMurMrK+6cZD+UrkUcg5Gl9VIEYlmixbv5p23NB0sD8MS5JNAM
 Gc9xdGO5wlIHUJigIxcFtLygcPEKgi76RxYJHBEocB/sM989ZkUVUDmbO6biVlZIvmrN
 db5bIuosnLSTB9IzMIwpmPJPCBZhrhGSiQltc9eKFq1kgV2BZr2Csgju0tgSB+zdhdlo
 a7kkaFuRgq7plLHpr85pMXjLrYV0k6ZGN+pE6gPZdMpAT1BQ2SGuqKjutPli7Mg0HL4B
 jXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753205907; x=1753810707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZPblH1j/xZMXIegVUSLcKz2r8cP+fyII2ULvQCzQFds=;
 b=AYqxA/9BMZDiswELsBJxp7V+Oeq/phPz5DpkLdGNlVLV3WQBDTJ7B4iVZDvU6ujrZT
 Qm8Ty0BTS+3eQ+hY4G1hzAOM2GhPRRJI2kUzYnUIpt5Hp30qUlHGySaRw+snVA/Etut0
 /HSZA7pjnOwDem+NLJB2ck9zMUIpMlxpLuxDa5lBC1LmPV6OLw+p4ptOWDhvil1rqgcj
 9c8+bVYrP+lPfW4pfdos9f0MC1zazpss1eD8qAToXSoUIduh+gjgqqVErnRrnv8tzTUV
 bmPKVtfniehXWbL6kAZvKubQYCTIHFcpZvg7idMFxQM0CAzi/xvVheiuKWcQkb8ohmgC
 3dyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNPUctfxHp5FGXiP+fJqFrIqebfVj9AkEWp7xwOeFLGxpN/Xm07Q2/lJx0PZ0zO0Ubc04=@dpdk.org
X-Gm-Message-State: AOJu0YxYD681fC2IpVg+bEq5Wcy9phYN018hI6usG3UQdzPPKtTRNxol
 3Vk0SD9nKlL7qkrZrUBCgAF4CgUkzXN0LTWtOdF7KxlcYI65W63B7Jovp9wSiOJqTek=
X-Gm-Gg: ASbGnctubA2OLX1C96vlq9GZthiIqwmqKj37oHgu+9ixrKtevkvz9h0HB1Pa3bFjrfu
 MUApbSXoPNhY+W9kEZvnpBm7yjVLxy5u4RZ3XnpOGUJI6nVFowBFSBwbuQiP/23shIjYBNIFhEt
 qUfE8PvdGzZUQyhaRJbhpnqIWqRQnUldzF+pb533hcP8pkgPVohyHhja2ZulKHlRCvz0AQFTXBq
 lTRZAr+8IdlfOYZHwHggx7atwknHaOIzwhXBSqjGLtB0rxSSVi/Z2DtibFg50F1oUyrLTH3Vltk
 3Yzvxs4XKS08qau7iQXD9YMvFJoAxLKxZ66onjCs3aCHZ3lnrdcNbWOWzQ6jDmdtuXeHGtJT5SP
 izzC4fWGhM1lNtdwzhd35vLdOjFB15TzGAkhsAPyOrtIkIgid7Z+sKVvvEL47iC9zvQWkefYyYb
 o=
X-Google-Smtp-Source: AGHT+IHVI0LhuUO9PkP9rkvt05IIcjZCQ9M68ZRDYldKunm6wMe7VT3EaiTyl8cM09PTNcbr/cb7Cg==
X-Received: by 2002:a17:903:3c6c:b0:235:f51f:c9e4 with SMTP id
 d9443c01a7336-23e24f49430mr394729975ad.12.1753205906698; 
 Tue, 22 Jul 2025 10:38:26 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b60f096sm80071685ad.78.2025.07.22.10.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:38:26 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:38:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Bruce Richardson <bruce.richardson@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, dpdk stable
 <stable@dpdk.org>
Subject: Re: [PATCH] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
Message-ID: <20250722103824.7c9db0a0@hermes.local>
In-Reply-To: <CA++2-x4+3QE+EOCdUcX8go27Z0tqrb4Br1MADQEiu=q3GgRpPA@mail.gmail.com>
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250722063924.2f87f3f7@hermes.local>
 <CA++2-x7VPCtojdJ7+DXdK=ohAJtLu_3U8KPxHS9CNAqzMd1hoA@mail.gmail.com>
 <20250722084225.7a40e2bc@hermes.local>
 <CA++2-x6bMRbxne_JdtSkCjVmAPMsY4762xzDbqPhqq8K8695EQ@mail.gmail.com>
 <aH-4xyH45rElgVb0@bricha3-mobl1.ger.corp.intel.com>
 <CA++2-x4+3QE+EOCdUcX8go27Z0tqrb4Br1MADQEiu=q3GgRpPA@mail.gmail.com>
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

On Tue, 22 Jul 2025 22:04:32 +0500
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> Agree, but I think it's also a good practice to guard against known cases
> that are prone to crashes.


Right but DPDK chooses performance over API safety.
For example rx/tx burst doesn't check args.

The point is that as a library, if application is doing something wrong
returning error doesn't always help.
