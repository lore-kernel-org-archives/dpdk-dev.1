Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE312C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 07:09:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16E2740667;
	Thu, 15 May 2025 09:09:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 063D2402C2
 for <dev@dpdk.org>; Thu, 15 May 2025 09:09:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747292977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcX6MQS3mN7UhzrEXJpGVulVPhnBIaX6hKy5ES7hT0Q=;
 b=C1e8UYJ3F7Kjref91Jm+zALX3XpNmYX2Kl/kgPJ69mYkxt+fem707Mq3eZSC53gveP65OL
 4+kMjkYAH55QfriaRaU2qBUFkuvLUrmqacq8muF/RackCkiHS+59g7irbe81bxJyieY8CV
 y9BNvDHZMJACvqfGNHxVsxmMP6XN3go=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-P4B9nMFHMESFl4WTzv_z4Q-1; Thu, 15 May 2025 03:09:36 -0400
X-MC-Unique: P4B9nMFHMESFl4WTzv_z4Q-1
X-Mimecast-MFC-AGG-ID: P4B9nMFHMESFl4WTzv_z4Q_1747292974
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-326cff18eb9so3297721fa.0
 for <dev@dpdk.org>; Thu, 15 May 2025 00:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747292974; x=1747897774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcX6MQS3mN7UhzrEXJpGVulVPhnBIaX6hKy5ES7hT0Q=;
 b=fGTN/FCEDouc5w0MjX+jmNIs7ZtCrW3anaMMm6qOvCcnG0lVdPp1ArMMJwtC7n2qIY
 1dhBAymMQYCu1krEXX2HDZa9pOMUCOAVYIYsh/bMga6VxCfAOvJZpYyTp5DqaDe1TQoA
 4HcbvnnG5OHWvMJGPDqUBUNqF6zzmcdtbeX0ityWwx2iK5/irZDLVL5Xw09U+b6UHfpS
 T30yPLQ1GknF3CktQVuN0hTfFDAEoeG2eFKm7D+mJVScR0PJ8jh5u9pJA5/FiRYE1Tp9
 YUPvSvKe4ENI9RSgvQgug4gMSMM35PDbHbL2or8c6Un8KIXnIpRBfUSkooxe6S0ImPGP
 8qmA==
X-Gm-Message-State: AOJu0Yya3dYD9ESUrU8uAnlr6CTdnGdSiaoctcMJjzc3Klvs/s45yTFe
 rrp6kjZihPFIRqUaHeN8W57LNlefUhmz5jJSrqJRp7mPAfFBEzRwkxEr31b+pp0SeohefrFSPGR
 W3eK1FjrE9i+PLf0NdjZdzzwP0KFBAc0HUDboWbmnzMVvaF/XX6pdWLdUXU25X/YnFVq6FYfzve
 P5MnvFYjE8ihlHsBEAYGRSkywbQN2ruQ==
X-Gm-Gg: ASbGncs2rUF9I0RmiohEs2KCdeuZMhmYb9cEHxShY0r+1fBdXL5WY7Ta48WWnLKeedU
 fxhXM5QpNPhAl+yz4LufmeHlFLklIawbtI1GgRjo0G/1FgBkuNefcwYeTS7HiRwXO+yk4Iwo=
X-Received: by 2002:a05:651c:541:b0:30d:b2a6:8e1b with SMTP id
 38308e7fff4ca-327f84f67e4mr7838611fa.13.1747292973983; 
 Thu, 15 May 2025 00:09:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELkazPW00OW1OMr+p+bqjY7NEp7bIIpkGPiNaWhrBi0t6uESqaCG3iwUPicngBngFhoFql3qDCB/5+R/UY7aM=
X-Received: by 2002:a05:651c:541:b0:30d:b2a6:8e1b with SMTP id
 38308e7fff4ca-327f84f67e4mr7838521fa.13.1747292973572; Thu, 15 May 2025
 00:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241009152417.4028297-1-bruce.richardson@intel.com>
 <20250513085956.1670288-1-bruce.richardson@intel.com>
In-Reply-To: <20250513085956.1670288-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 May 2025 09:09:22 +0200
X-Gm-Features: AX0GCFv6oXK1uBnYT30hx5fPdGY_S9TceX2yY9jStREMinu01XK73p1L7EDP7Ts
Message-ID: <CAJFAV8xccPZAvQrFX_dqhQ49ZQUEtTO3GoDPKLZpz05pyBL1nw@mail.gmail.com>
Subject: Re: [PATCH v2] build: automatically report minimum meson version
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Patrick Robb <probb@iol.unh.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Sie3N3F426QJSpZf7SmIVj4fZKwxzf-gTwfC2Z-Q4s_1747292974
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

On Tue, May 13, 2025 at 11:00=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Add a script to buildtools to report the minimum meson version given in
> our meson.build file. Then use this script in two ways:
>
> 1. in the .ci/linux-setup.sh script, use the auto-determined minimum
>    version to set up the CI, rather than hard-coding it.
> 2. in meson.build call the script to report the version. This serves as
>    a sanity check to ensure that any changes to meson.build file do not
>    break the script.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
> ---
> v2: rebased to latest main

This patch is reverting dbcd72f3fba0 ("ci: fix unit tests with Fedora 37").

There were some strange errors raised by UNH, though I don't see the
same python backtrace.
Let's try again:
Recheck-request: iol-unit-arm64-testing, iol-unit-amd64-testing


--=20
David Marchand

