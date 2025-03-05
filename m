Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1797BC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 17:49:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7BA940275;
	Wed,  5 Mar 2025 18:49:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AD4884025F
 for <dev@dpdk.org>; Wed,  5 Mar 2025 18:49:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741196994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaEdk6/6MNErq7016asBbr+9CuECtTexnoJIfvvyQ1I=;
 b=iIkJXwM3gXpY5ru8/XdSNk52ME0a985/ztI8NavD8e20d+1JWmPJOWt3N0ruViPH/hJ7v3
 7wG9PKUPjl9ddMwJ+ZkMGQzSurkAJ6NU13/37oHrOQhztbetwpJ1n4G5jLnFMYcRyioJaN
 rBXwhwIKo9qIW+gDMXcGnTXwd0/Pazw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-mTHnBcNEMb6VOvi-YnQnHw-1; Wed, 05 Mar 2025 12:49:52 -0500
X-MC-Unique: mTHnBcNEMb6VOvi-YnQnHw-1
X-Mimecast-MFC-AGG-ID: mTHnBcNEMb6VOvi-YnQnHw_1741196991
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5495cf1a321so2099129e87.2
 for <dev@dpdk.org>; Wed, 05 Mar 2025 09:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741196991; x=1741801791;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eaEdk6/6MNErq7016asBbr+9CuECtTexnoJIfvvyQ1I=;
 b=vF/GiK/liGDqL1QB3ThRxF6c0QPTEd5f3mBV45GjijNLKRGNA6l9Hh3RQ7dt8tDDEg
 Hi6lq/LepsVhpM9N1FhaBOVCvxT5mpRXmp7JLCUTPDYPGgaLmPEBSoDMstrhDLSPQrGZ
 F3xb6EGqw1dF0qpASpqdX7DJlCXHG11f/zghICKMTUAYfyDN+F+6MeNbnmqejPY7vbl1
 lfqeF4wcNy/l5yGQS4kgScbDtnA/3M2vw9Rt8uJRrCZ6vpGZ7Ukwe7pJHa9o3ls7vtmH
 AL6vb1mexziIFfP2PkvHTTP+f4vDn4ai/ePnp5hTC4ESHph+eKk8GBJ4bZfQaIF15AYr
 RTcQ==
X-Gm-Message-State: AOJu0YyIkb8NWWPqJY4J7EbJ6JYyxjwzCs7aJWrVxFwt79CYqqJ9RYCi
 0GUXEHb5KcoTqYYs00AU5LMGOinAxvD59IrO5GakA7H3u2HyV2a8/j/L+bQz8HdqEt9njcxGCBP
 nZHwmOLfTWDzmPmTghAajlJSK7yzZOBgots4oz3s7eXR4xl+2DlJEwC2Xe3bC9QbzB1oGa3P9l8
 W2f1q4JLNAWojCZgepFuvBj9M=
X-Gm-Gg: ASbGncvsGdT6abwdfUFJ6bwWbLfPhRrWt8lZTgFUqa5S4A/wibxL63zcP9pyF7PaFQm
 8UC1ntpCAL3TQWUmjnKys7VcIWnHkP9bowNlCPWZpoYmKkVUCr4w2neLs8zxq2Szws3q7k6E6Jz
 o=
X-Received: by 2002:a05:6512:3b9e:b0:545:280e:4b7f with SMTP id
 2adb3069b0e04-5497d34bfe3mr1747771e87.27.1741196991027; 
 Wed, 05 Mar 2025 09:49:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmIvJEAz3QaHpjHKx/FSlYDxyze6pN/7WV191gKkAfw3heWiZCIF2rYiKOb9rzBEdDU/YHaecvG1OAaIVVQ5M=
X-Received: by 2002:a05:6512:3b9e:b0:545:280e:4b7f with SMTP id
 2adb3069b0e04-5497d34bfe3mr1747762e87.27.1741196990580; Wed, 05 Mar 2025
 09:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250304160633.385185-1-david.marchand@redhat.com>
In-Reply-To: <20250304160633.385185-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Mar 2025 18:49:39 +0100
X-Gm-Features: AQ5f1JpxD1pjMdXTb87KgUqaH8Az-WHZulyIfb9EtfIbR8dYSQcSJCk4ZEDGgbc
Message-ID: <CAJFAV8wkUBkMGWRYCT49f93D=pk3vyCxXym_7C1CiGZ3iShYyQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Trace point framework enhancement for dmadev
To: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TuvAxbPAPpPmHHgY_mzj33igZdnJe4b_eZ57wIem-5A_1741196991
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

On Tue, Mar 4, 2025 at 5:07=E2=80=AFPM David Marchand <david.marchand@redha=
t.com> wrote:
>
> dmadev trace points have been working around trace point framework
> limitations.
> One of this workaround blocks enabling dmadev on MSVC.
>
> Traces files were not checked in CI, so this series also adds a new
> check.
>
> --
> David Marchand
>
> Changes since v3:
> - dropped changes to CTF metadata,
> - added new helpers for dumping content of pointed at memory,
> - changed dmadev to avoid more changes in trace framework,
>
> Changes since v2:
> - added check of traces validity in GHA,
> - split patch 2 and fixed CTF metadata,
>
>
> David Marchand (5):
>   ci: check traces validity
>   dmadev: avoid copies in tracepoints
>   trace: support dereferencing pointers
>   trace: support expression for blob length
>   trace: fix undefined behavior in register
>
>  .ci/linux-build.sh                         | 10 ++++
>  .github/workflows/build.yml                |  2 +-
>  devtools/libabigail.abignore               |  5 ++
>  lib/dmadev/rte_dmadev.h                    | 29 +++++-----
>  lib/dmadev/rte_dmadev_trace.h              | 32 ++---------
>  lib/dmadev/rte_dmadev_trace_fp.h           | 26 ++-------
>  lib/eal/include/rte_trace_point.h          | 66 ++++++++++++++--------
>  lib/eal/include/rte_trace_point_register.h | 51 ++++++++++++++---
>  lib/ethdev/ethdev_trace.h                  | 27 +++------
>  9 files changed, 135 insertions(+), 113 deletions(-)

Series applied, thanks.


--=20
David Marchand

