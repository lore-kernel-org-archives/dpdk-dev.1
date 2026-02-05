Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28F8ECD993
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 17:41:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6709442670;
	Thu,  5 Feb 2026 18:41:18 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id A970D40684
 for <dev@dpdk.org>; Thu,  5 Feb 2026 18:41:16 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so18303925e9.0
 for <dev@dpdk.org>; Thu, 05 Feb 2026 09:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770313276;
 x=1770918076; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4xqSRAZuMg0GWj3UX0WbTGuIl5EQnBASAHEeUFkAYk=;
 b=SFBSoMvFK+L5ve/iXJPjK3AkU2YPp4/AVT3Mhc4Y/rQcYj4oWeQEe0Ma5oYE9AjKNQ
 0voyP5q0x6AK3bHqL/jsk4Sm54eTeWiiOZVbMoeRh4nrskN4NrH0pFmjNwyxv+v6c5cH
 Lk6a0fFu30gLifZzomGZ4OFvZzK23YtjRRT0MMJ+PiWinF4RTCuiTKfkS28JBl2HGpZz
 7IQONpB79T95SJF6ijqRv+87Dl0ABLm1m0wlkPrTWUBqcOjKHNJPZBwd2z+AjPpGIsKL
 fQ+JgsEYGpA+eOrSsWhKmg3ZNmb1by2PFKT2PD9SRkyjoiBPfp9kswsIKPJPzMrd4I/G
 dlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770313276; x=1770918076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N4xqSRAZuMg0GWj3UX0WbTGuIl5EQnBASAHEeUFkAYk=;
 b=WP0OFe9UpUXCmzBRWjuvx5V/vJhI+wo7WD/zOVNuIVRyOI4xvL1PZwZ4R380Wuq4c2
 KAS/0TCp2X6R6dGd9P3h1QZ1nj+GYrGuXBmEBvSMOTjIoWjwtzcSxDq2DHXvoTSm6VHJ
 LNMiGSLUZ6ZAfmJwXSEEB06vo2HC0An6ESJYpLP7IbmXNosVb/EbyZYxx0xBNNU/rqE0
 lAf6cAddCDC1wtJCwkE+lvU9jxZ9QbiGfWljSLGkLH5HLJ8ppZ8y27rHP9N2XFtlsJH3
 ZKMLzgApmH2t19VTk2q6fLxBYqefDH+/bpqdHPwh9DOQxtSBcDBoppAHUf2B9eOHuhC1
 KVJw==
X-Gm-Message-State: AOJu0YypFfSsUG0BpgqjeB1HPwXXROYjTRC8XZwJpd2zzKbRPTZ4lUIN
 tJ1aUrLZ7ZfXLSLsVHpLf1JmprY0ywYmfu6yHSaOApBQN67rs+Fmh6Pvdrvam0XovsQ=
X-Gm-Gg: AZuq6aJvGt2QdBTh7Ch1hs7P1FBcA3xW0AErfTbdA9NHzkUYsneUoQ5Oh0PysjbFKC1
 VLOeL2jjXhSuxiePiJiDi1MQnQGvUD+MSUIm3mD5RxMPOidaqOOfID8qc9JUXf1iXayvz9gd6ZA
 S5Em+K3eu2VndnJdsXnEkiyaL0+BTsHi9Zfur/7F+CXTiXRyUDzBYbrplUrnkAMNyJOxLe319pd
 xpC1p2draDAhpUFEqetAHy6D20P3NC25K+tPkpfkafgm0Ikzt3bJD0Xms5lT9erhrNeMhaCdE+I
 Pklot+BPpev6BzRjDBHOXtMibP0Qj0I4oP3weZUApB1OUj5UykTDAswhn/oEyace78A/IYplMYJ
 Dg3I5ePtt5ECuyWS0TLVnxKuAA5AzmkWkCiNpb1nt6WnhdmVhsSBYTEjzNheUckjSfTf9z55Zh2
 5hGhT+kzoCXYYHm733KWy6NBLxxAenX4Fb7tMhN9wOXQ4Ev/Rn8sWP9ZFZ3Q6GOAQ=
X-Received: by 2002:a05:600c:468d:b0:477:fcb:2256 with SMTP id
 5b1f17b1804b1-4832023126bmr2549345e9.17.1770313276092; 
 Thu, 05 Feb 2026 09:41:16 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805f25dsm16574522f8f.29.2026.02.05.09.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:41:15 -0800 (PST)
Date: Thu, 5 Feb 2026 09:41:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, techboard@dpdk.org, Bruce Richardson
 <bruce.richardson@intel.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, stable@dpdk.org
Subject: Re: [PATCH] ethdev: fix mbuf fast release requirements description
Message-ID: <20260205094109.07193182@phoenix.local>
In-Reply-To: <20260205092848.36435-1-mb@smartsharesystems.com>
References: <20260205092848.36435-1-mb@smartsharesystems.com>
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

On Thu,  5 Feb 2026 09:28:48 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> It was unclear if mbuf fast release could support segmented packets, or if
> mbuf fast release required non-segmented packets.
> This has now been investigated in detail, and it was concluded that
> segmented packets can be supported with mbuf fast release still achieving
> the enhanced performance.
> So the description of the mbuf fast release Tx offload flag was fixed.
>=20
> Furthermore, the general descriptions of the Rx and Tx offloads were
> improved, to reflect that they are not only for device capability
> reporting, but also for device and queue configuration purposes.
>=20
> NB: If a driver does not support segmented packets with mbuf fast release,
> it can check the multi segment send flag when selecting transmit function.
>=20
> Fixes: 55624173bacb ("mbuf: add raw free and alloc bulk functions")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---
> The other description improvements were taken from patch-155635 ("[v3,2/3]
> ethdev: Improve descriptions of RX and TX offloads").
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

I wonder if it would be good to point the AI documentation review
tool at the docbook comments in ethdev. There are some grammar
and clarity errors there.
