Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4260AEEB56D
	for <dpdk-dev@archiver.kernel.org>; Wed, 31 Dec 2025 19:28:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B1E9402D6;
	Wed, 31 Dec 2025 20:28:17 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 51129402D4
 for <dev@dpdk.org>; Wed, 31 Dec 2025 20:28:16 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso88882765e9.3
 for <dev@dpdk.org>; Wed, 31 Dec 2025 11:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767209296;
 x=1767814096; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Wpe6T4tBkXbCIpsVFCtH3ewPiuuiBYiEmzy0QCOWOY=;
 b=Zg2FwbRBtWJtQwDGEah4rX7N3ORAtDvM0udMfxt3aB2VjOo5v3r/yB5V8G6VwZrSr0
 pVKbJ6cyfO4+9u+uCFad2Tm0MOYwlNEHnTVtpHl7bvHW8sBEUt1eqPJm8Y15Mu7VxAiI
 KokQYsqLCicT9LUuSLWPU+zCMYF1dIZsAw95oLtVPVYMR+kzKT4sDBY1LYT89t/VNgp5
 j5KsW83KZfaSxsmd/AJufJ4LLghSmzjYVDSDi1hj/mvms+BMe7ZYJwZM2gWlGRMu7aaf
 oCaEcC2GMFeY0XBEdP8skhAdR2cOMvEeNWnQP9Rpavz3JOBnfJM3h7esNrtcB9uodg7V
 rfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767209296; x=1767814096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Wpe6T4tBkXbCIpsVFCtH3ewPiuuiBYiEmzy0QCOWOY=;
 b=RgOFrCe5jkeBq/jf4lIRJnthpV/AjYFRwlaD3zmjX8pPjZLTXVGMlxEb1QhGuVKykx
 8jqVUgiCx1oYberQrDvmN5CCXEczhxGUyFktNRb3dF4awS6lxn1tw5ejt7/v+Ys9o+1k
 lEZOuGwJXChJwYl6VjL9BCE0wXPaQH11QhpVYv7DwdcWeZBQRfC8IvHM2Lrgvh3f4HxC
 kDW5SIWxyawn/Y6T6olHPFW0w5yBYBMwEQ6uWJnukK0HO40+blVxJ9VinMd+ZtNLsPlo
 4QAOsY0rsL8k+NBgYeSCBKBJYvCkGidCth5gKWHRf5Zm30KMfxPCsA14C+tZ6KKd1weA
 vYkQ==
X-Gm-Message-State: AOJu0YwF6VzJ7B4WNS69UGm6Q88f1Om9Znv01I/8T/5JJDbD6g3tpuDd
 lObS1KrcMAxaducVH5QCo6ApIPJaOrhYIvHIP71X6MPZpmUdfwbf62tty/x/EFuFPvA=
X-Gm-Gg: AY/fxX6P29bb6E0M7eL0kYrYSOlg/ElnZa9I4fmMjLiU2aMp+e1hCozQ1Ua/Obcw5pa
 Pfdn5qAxNgb5PGm3qZOtYGdfYsdj2zBpVr2/RQbWzPTFAWZIi6DTuksYY0gIHfELvbo733SU61I
 9tMKI8OOaKVQTP0WA0jVagXHPLjhyJ8Q1fgbR7+vMO9tpbXzisMyRsrzVutDsNn9BoIvsaDVcNw
 gapl9zZi/APPZmzdYk0Lfefrrx7NQQ9lVltAV8UpYSOQfidxzoZLuFmLg0HNuCwcdwnpkZiuk2P
 rS7PKKBrdm2JULvRUPal5bj1GYcKUxjhGWfO+9Ldg6oyuYL6xBHdyiFSQg4Pw+G4O89MK0VO0lD
 YliPpTZoQjs/o20p40YDw8wfEFWbcTYnuJKjyMqidzTv30p/9cxX1hLSLn/al1JxkyQvtOAb4mE
 KyDWSQj9v19zRa/gOR00/1fL3eV6VJhSoYXu/AHqsYMnJJ+DxCZ8gp
X-Google-Smtp-Source: AGHT+IEvG7N6qm0kYMPy1ft2/wLi+oBK9rztFI+i9GwdppWJB1DIArxUlM4ursPoifzS/tS8MoXlzw==
X-Received: by 2002:a05:600c:1991:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-47d195aa354mr487626425e9.32.1767209295858; 
 Wed, 31 Dec 2025 11:28:15 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d1936d220sm728037815e9.8.2025.12.31.11.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 11:28:15 -0800 (PST)
Date: Wed, 31 Dec 2025 11:13:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Andy
 Moreton <andy.moreton@amd.com>, Pieter Jansen Van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>
Subject: Re: [PATCH 0/9] net/sfc: SFN7xxx deprecation and Medford fixes
Message-ID: <20251231110534.0e16428f@phoenix.local>
In-Reply-To: <20251229213527.37907-1-ivan.malov@arknetworks.am>
References: <20251229213527.37907-1-ivan.malov@arknetworks.am>
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

On Tue, 30 Dec 2025 01:35:18 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> The series provides various fixes, primarily for Medford4 support.
> It also fixes a legacy flow control bug; due to hardware constraints
> in the fix, SFN7xxx NICs are now marked as deprecated.
> 
> Andy Moreton (1):
>   common/sfc_efx/base: count Rx TRUNC ERR as CRC errors on X4
> 
> Ivan Malov (8):
>   doc: remove support for AMD Solarflare SFN7xxx family boards
>   common/sfc_efx/base: fix flow control setting on legacy MCDI
>   common/sfc_efx/base: fix indication of requestable FEC flags
>   common/sfc_efx/base: define mask for pause mode capabilities
>   net/sfc: avoid speed reset when setting FEC in started state
>   net/sfc: rework the capability check that is done on FEC set
>   net/sfc: drop AUTO from FEC capabilities and fix the comment
>   net/sfc: fix reporting status of autonegotiation to the user
> 
>  doc/guides/nics/sfc_efx.rst            |  14 ---
>  doc/guides/rel_notes/release_26_03.rst |   4 +
>  drivers/common/sfc_efx/base/ef10_ev.c  |  41 +++++--
>  drivers/common/sfc_efx/base/ef10_mac.c |  35 ++++--
>  drivers/common/sfc_efx/base/ef10_nic.c |  57 +++++-----
>  drivers/common/sfc_efx/base/efx.h      |   1 +
>  drivers/common/sfc_efx/base/efx_np.c   |   2 +-
>  drivers/net/sfc/sfc.h                  |   2 +-
>  drivers/net/sfc/sfc_ethdev.c           | 141 +++++++++++++++----------
>  drivers/net/sfc/sfc_ev.c               |   7 +-
>  drivers/net/sfc/sfc_port.c             |   8 +-
>  drivers/net/sfc/sfc_repr.c             |   2 +-
>  12 files changed, 193 insertions(+), 121 deletions(-)
> 

Queued to next-net
