Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355DBC282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 13:26:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 056474065F;
	Thu,  6 Mar 2025 14:26:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E60D140430
 for <dev@dpdk.org>; Thu,  6 Mar 2025 14:26:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741267590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3z90EC0/bJ8EIIe1VN0/R9IyvIxALAajKE6V4Smgbk0=;
 b=GVNgPQXj9n8oQfzJh52lx1knwEvOnk4h0U5iPrwGMPNk6qHHrPe+V3eyH2mspuHwqkNz4s
 AuDxo+LKeZWanpwD30KusAE8hcazkJUFNXqOvLdm/UZtEaEfpgszYP/35j6j69c5dX8Q8y
 2KhLX6v5ROfX0Tva6XmZpmXOCp40feA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-1NYWQSmSPBOft9p4nscBaQ-1; Thu, 06 Mar 2025 08:26:24 -0500
X-MC-Unique: 1NYWQSmSPBOft9p4nscBaQ-1
X-Mimecast-MFC-AGG-ID: 1NYWQSmSPBOft9p4nscBaQ_1741267583
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-30babe2708aso2435361fa.2
 for <dev@dpdk.org>; Thu, 06 Mar 2025 05:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741267583; x=1741872383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3z90EC0/bJ8EIIe1VN0/R9IyvIxALAajKE6V4Smgbk0=;
 b=R6OoJb/uEGGY4weBps0OG4gznlNwV2Q7Mb5K0RUruao4sZCFAAOdiOT69A5NZREObZ
 RYLmIaXRzS52VswWohchVMYEKhIzdPM0oNmG7CgnpCz9H/LNobJhA6IqfRRD4YCMs1B8
 2DrGG6EAk7//7HMt1hm2iZoV9HFT66m1mhlG8t0gmqsJ5GovSpw9QQa/lgbsCUjnrru5
 eNeeZ92WVJ/BmqkZFKwt99amhimU0yfW41KJNPrH6cLJ6CDR/1Q+Jd5434jt9iVDGBQm
 Ym99MIp2ESY+m+tSbMYrusRB8MhlYcOZYvZJzAnR5LAochrMgNYv1DHzrqaMG/KK/APx
 c8Mg==
X-Gm-Message-State: AOJu0YzPAl9DJWFY+CIKDoVkypp3XfAlwhDA89tRNeyfJu2ZHPhrYrzF
 92CS7SG6oz9nnrWqZ/JRFEdafzcoXziX8PsXbhWdDtcgyHlO8hY5JRoYyYcXbrELGdUN5wfCmBe
 ctcC6hNUJTymD79VmDf6I1CDU0G6tk37kgyfCWXlg1WO1z8aAFkTAY3TlYjjIv1LH3mdpZ92uog
 6hYck2uRxwixFVEu0=
X-Gm-Gg: ASbGnct4sO0ay+jjrSpQ7eLY4HyzvWe2cjYu+2s4xXAlbpt+H9pDPoiK4HQPQyn4T3c
 lNq7Fgek+3ois8P7xVpIg1yAAHK03K1Hbv/S38IaD0IGufiTvOlnOw87bmM+3XXGnuqdhw4/E0A
 Y=
X-Received: by 2002:a2e:96c3:0:b0:30b:be53:bdd4 with SMTP id
 38308e7fff4ca-30bd7a5844emr24874551fa.20.1741267582833; 
 Thu, 06 Mar 2025 05:26:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHU+TQWlxGpB/aS9CIapA+ebdQozbOsZUtUCOfW0H4hzLk99bbf5sg2ABySsvaTlj11/NpceS8zjjDaG2iAOUg=
X-Received: by 2002:a2e:96c3:0:b0:30b:be53:bdd4 with SMTP id
 38308e7fff4ca-30bd7a5844emr24874431fa.20.1741267582471; Thu, 06 Mar 2025
 05:26:22 -0800 (PST)
MIME-Version: 1.0
References: <1733848355-19048-1-git-send-email-andremue@linux.microsoft.com>
 <1738634318-12876-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1738634318-12876-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Mar 2025 14:26:10 +0100
X-Gm-Features: AQ5f1JqybD32fako6HaQRGbbevV9v_D2hnRyfPEJdpAxJHXHDnmejzjWXaVHXZM
Message-ID: <CAJFAV8xvwSc1EJKXD+VMxTxcUO+b0o_Qr_fx8rXk-DueMgyo8g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] enable build of lib/stack when using MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h5iohysmVVdPkqyTf8boHS_fCPoEj_nq104hwqYcfO0_1741267583
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

On Tue, Feb 4, 2025 at 2:58=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> MSVC does not support inline assembly, which is used by the
> implementation of rte_atomic128_cmp_exchange and is needed
> by the C11 flavor of lib/stack.
>
> A special implementation of rte_atomic128_cmp_exchange
> compatible with MSVC is added to rte_stack_lf_c11.h. It uses an
> intrinsic function when using MSVC, and inline assembly when other
> compilers are used.
>
> Existing atomic tests (which are not C11 compatible) are
> now skipped when using MSVC.
>
> v3:
>  * Isolated the additional implementation of rte_atomic128_cmp_exchange
>    to MSVC only.
>
> v2:
>  * Added MSVC compatible implementation of rte_atomic128_cmp_exchange
>  * Skipped non-C11 atomic tests when using MSVC
>
> Andre Muezerie (2):
>   test: disable non-C11 atomic tests for MSVC
>   stack: enable build with MSVC
>
>  app/test/test_atomic.c       |  2 ++
>  lib/stack/meson.build        |  6 ------
>  lib/stack/rte_stack_lf_c11.h | 27 +++++++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 6 deletions(-)

On the principle, the stack library should be reworked not to rely on
the legacy API.
But on the other hand, the stack library is the only consumer of this
legacy API, and the change is small.
So I decided to take this series for now.

We can revisit when there are more users of 128 bits atomics.

Series applied, thanks.


--=20
David Marchand

