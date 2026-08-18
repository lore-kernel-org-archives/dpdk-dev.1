Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD530C5DF70
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 09:10:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C31094027C;
	Tue, 18 Aug 2026 11:10:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E002A40269
 for <dev@dpdk.org>; Tue, 18 Aug 2026 11:10:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787044239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqdjYLPO8UkDmL38sxliESWeCm7Kq8rnAW4/zPuTmpc=;
 b=YZnpjK1lYBEeQ5+A/ORnAuxPlUufpihDgfvkkysanFrS1iGiUviuXNiyUhrf+ZPAOzaJve
 PIGSM9a+qbUDsiQrmpY7cjsF9fv+k6kSPXGxLAtqFg22jRTjoD5E8dvzkVhwZTWhvupIdD
 boTQvzrOwt+1SXtyxfeSK5KoeZTWcWY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-Ifap1AikMky3CYhL0YnxGQ-1; Tue, 18 Aug 2026 05:10:33 -0400
X-MC-Unique: Ifap1AikMky3CYhL0YnxGQ-1
X-Mimecast-MFC-AGG-ID: Ifap1AikMky3CYhL0YnxGQ_1787044232
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b2b9c6d6e9so1858654e87.1
 for <dev@dpdk.org>; Tue, 18 Aug 2026 02:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787044232; x=1787649032;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qqdjYLPO8UkDmL38sxliESWeCm7Kq8rnAW4/zPuTmpc=;
 b=cv2nPWy590uSkVtPIrXzw/E+w/lqKSNqrh74r6yq5AJTHLGJ0GSSk3/hxEe+AjLfuR
 ar46LYfCAS1AjXajxnBhT1tGRDPA+TzFsUrVPUnI7VmJQgUumpmqirRg+Ip9s2MlspvX
 Ttfgrj12o82vfEpro6qikJvEOAZ24RkfyNhwvNBQIrd4Sfiyis8/BrmqevhtroJfneVo
 zNohrirbJ5JOX/pWk3C9uvqZzshGQz4QU4ol09A7+L9+izIAjihc8Sipkwcs6NBkk2ic
 FUiFwjSM/66kWfiRcGJDntIFWTn6NBehmD0H8lz97CyvIWT59kKW78YRiJt692wDaxvu
 aQVQ==
X-Gm-Message-State: AOJu0YxR0+gyMRM6ZW44j707V80vAFKCWdEh0zsWZGC3cQB4sGg0RSKs
 EZrWh5TidX8WAm+j1jTUXJlmucy+VWatOht14cdbeZ5CR4mz47rcMl04h1q5MQlv+cocQApdcoL
 KWqwAcMqhXwgnUzBcC/uyL18ZgPmSgDYarRJ7jdfUpjy8ESu7C904wT4AUamxxPqiOAmWY/nIwd
 901fsHGzFdR9wjBoEppLg=
X-Gm-Gg: AR+sD10hYeUt9QSEgZnOwjo4IlLxdrfrEuxwhXGO+voTsrlkvgJcDF8GE/RpnSLbidi
 lXojSfJWi+RK2FnwgPW6S4Z8QzhPQ6P+UmEOmf5YMZ6TPMHEzIXKciP8ActbyJQzF+ARb6xDw1T
 kzdpSZLctDt8ebaNjUYVFgd3zDhEST3i4RqD9dpea59MJtcGP2kDqbm6pf1KuCOuIniM3uTcH9O
 oB+joWj2vT8orCxQ4sNKdCSjllVYU+glMUJbArfcK4vE1EoZ8vXRfIX7MguuB7Jh15lYu4w22Jp
 K8cu01JWcab7fb7qemHEoD9lsCGOO4W35ZHcuJXiv7I=
X-Received: by 2002:a05:6512:8358:b0:5b2:a600:e496 with SMTP id
 2adb3069b0e04-5b45916c885mr3609644e87.24.1787044231691; 
 Tue, 18 Aug 2026 02:10:31 -0700 (PDT)
X-Received: by 2002:a05:6512:8358:b0:5b2:a600:e496 with SMTP id
 2adb3069b0e04-5b45916c885mr3609625e87.24.1787044231163; Tue, 18 Aug 2026
 02:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260723153111.3943368-1-david.marchand@redhat.com>
In-Reply-To: <20260723153111.3943368-1-david.marchand@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 18 Aug 2026 11:10:14 +0200
X-Gm-Features: AcwNN1VNf_ffuWpPl-SMMzn1_h7fQ9aFrhB9Bq3mxN5X_hkJAQLLtSa0Q8jiBeo
Message-ID: <CAO55cszjS0Y+Cf0F7j7crkMrRbzuQ=HFou2gN3Uor0mHhjjR-A@mail.gmail.com>
Subject: Re: [RFC 0/3] Drop vhost async (DMA-accelerated) datapath
To: David Marchand <david.marchand@redhat.com>, 
 "Richardson, Bruce" <bruce.richardson@intel.com>,
 DPDK Techboard <techboard@dpdk.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JZkNhQ-QjdxJdsAQkZCh62cNukPlGF75cjF7qinSzKg_1787044232
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

Hi David,

On Thu, Jul 23, 2026 at 5:31=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> The integration of this feature in OVS has been postponed following
> feedback how the current API forced the complexity on the application
> side. There is no contributor working on making those changes.
>
> The feature has no other identified opensource consumer.

I am not aware of any either.

> On the other hand, this feature has been left unattended for some years
> now while the "normal" datapath is actively maintained.
> It is highly likely the async datapath code, which never underwent a
> stabilisation phase, is riddled with bugs.
>
> Given the craziness around finding security bugs with AI,
> and since the vhost library is a good target, I propose to drop
> this feature and reduce the library attack surface.

This feature was introduced by Intel a while back, so their
acknowledgement that they have no ongoing work regarding
Vhost async would be welcome.

Adding Bruce for intel (feel free to add relevant people), and tehcboard in
case it requires a decision from it.

I favor dropping this feature.

Best regards,
Maxime

>
> --
> David Marchand
>
> David Marchand (3):
>   examples: stop using vhost async datapath
>   vhost: refuse async datapath
>   vhost: drop async datapath
>
>  doc/guides/prog_guide/vhost_lib.rst    |  151 +-
>  doc/guides/rel_notes/release_26_11.rst |   20 +
>  examples/vhost/Makefile                |    2 -
>  examples/vhost/main.c                  |  436 +---
>  examples/vhost/main.h                  |   21 +-
>  examples/vhost/meson.build             |    2 -
>  examples/vhost_crypto/Makefile         |    1 -
>  examples/vhost_crypto/main.c           |    3 +-
>  examples/vhost_crypto/meson.build      |    1 -
>  lib/vhost/meson.build                  |    3 +-
>  lib/vhost/rte_vhost.h                  |    2 +-
>  lib/vhost/rte_vhost_async.h            |  293 ---
>  lib/vhost/socket.c                     |   27 +-
>  lib/vhost/vhost.c                      |  434 ----
>  lib/vhost/vhost.h                      |  115 -
>  lib/vhost/vhost_user.c                 |  215 +-
>  lib/vhost/virtio_net.c                 | 3275 +++++-------------------
>  17 files changed, 708 insertions(+), 4293 deletions(-)
>  delete mode 100644 lib/vhost/rte_vhost_async.h
>
> --
> 2.54.0
>

