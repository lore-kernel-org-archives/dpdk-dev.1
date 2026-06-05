Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E82CCD6E5D
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 11:32:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CDAD402BA;
	Fri,  5 Jun 2026 13:32:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 829FD4026A
 for <dev@dpdk.org>; Fri,  5 Jun 2026 13:32:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780659154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9fXhr/nqadpQWhfmhlLWn3H4Do21IwR1E/xeFA6PLeg=;
 b=YI+hJL7OSIclUYh5UOUBE8VHwzr4kJ4dDJ4Ghga3Y+FznYj80JOWZvApImmfhSNqol8CEl
 WyVFwxW2cg7LRuX7X6YOFKgjiK9VYo3lZg58y4ynqGOKehC9MT042EZ6NkRSzZ6WdPBxNq
 4S2dtqXwX+bBsUJ4VMk0KiJNh84AtSA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-lHep37nRMW63g247zCAcmw-1; Fri, 05 Jun 2026 07:32:30 -0400
X-MC-Unique: lHep37nRMW63g247zCAcmw-1
X-Mimecast-MFC-AGG-ID: lHep37nRMW63g247zCAcmw_1780659149
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aa68e50948so1090973e87.3
 for <dev@dpdk.org>; Fri, 05 Jun 2026 04:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780659149; x=1781263949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9fXhr/nqadpQWhfmhlLWn3H4Do21IwR1E/xeFA6PLeg=;
 b=NrgWKlqc2f6yKw9X1FZQCHiAAROo5o2o4d74FvWNYvLnrDgJV9HkFPsfLvY2KVX386
 z16EkGk0p5iKqpFwQ1HSHGT3BegZlsnj4dd28RsTv6UYpuCS+iiJk3xmqP4PMAvRTA/i
 h/N122Is9aPEYtUwjW4FpYryEG/1cUTLvy8jSNHQgEyIhLv/GUW2un5/pyiixa9bR27t
 7wXLPs+yPceyTV5xsLAAdnHvkI8zYkoVi26ytNjcC4+0//DVrD994rf7mz27pby26OG/
 AQgt0YY7aT9UI8EJ6aGlkmvxQkpRpT76ULexpkOzh+B0gQtCAXdBrfyOmWE9teaGI2/H
 KPDA==
X-Gm-Message-State: AOJu0Yw8taMERMe4Oc9Jy8e2sSHYPFAvBaHhzKJcYJsOGktMUfuYrEn3
 MsLcRFA5qUQrrPQt6TWQOgId2aS3AwlOLSN80yF+d4wLGK7454on76xl7aS5tAD2kkf+MxAKvjt
 NJweEHWa8hEXn4NIXBWtoBZ5XycXmEtWNEuoWy3GENCHoQbAljKqTwSN7JclGR9NyZt/l8fcqJK
 4XMJKJvWquTSkfX4otbE0=
X-Gm-Gg: Acq92OHOi785LVOYOJV6HMH1sZrMdFUsSabDjyy66Yd4Xs9+MNa8sjOsnE7Lf0F6BUl
 sqQZq5Z/Rpgk0DV2AkrENqUqFu2TSexGJ0R1ouOLj/zd9YcXBMTiEupnpec8jk2UbNcRreqoGrX
 +kCcW9TVwk5NwT/d4YzLkCzuyHmFxUdGq7ioRJCEAIfMHx1+m6jCzixfVxRT93Nj576KJW/s88u
 FbB4bxPU48CYawgWrWdopHQgqYavzaQmK8wDLTwDfROAIDowkIb/i3JvxvLrCNqYNC7aEtoANNS
X-Received: by 2002:a05:6512:3d12:b0:5aa:b6b:93c2 with SMTP id
 2adb3069b0e04-5aa87be01bfmr1103507e87.44.1780659148886; 
 Fri, 05 Jun 2026 04:32:28 -0700 (PDT)
X-Received: by 2002:a05:6512:3d12:b0:5aa:b6b:93c2 with SMTP id
 2adb3069b0e04-5aa87be01bfmr1103493e87.44.1780659148412; Fri, 05 Jun 2026
 04:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260604235723.1046607-1-pravin.bathija@dell.com>
 <20260604235723.1046607-5-pravin.bathija@dell.com>
In-Reply-To: <20260604235723.1046607-5-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 5 Jun 2026 13:32:12 +0200
X-Gm-Features: AVVi8CdpqhemXZ3ZE5YBs7eRHBxIuyF9Jx7zN86CAYuNvzyQpkLfGcrSSuFPbaM
Message-ID: <CAO55cswtbiK9Y=FdBHMpATjjKqRUNdNot51w=LHqYczt0fMEzQ@mail.gmail.com>
Subject: Re: [PATCH v15 4/5] vhost: add mem region add/remove handlers
To: pravin.bathija@dell.com
Cc: dev@dpdk.org, fengchengwen@huawei.com, stephen@networkplumber.org, 
 thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EStFECKwvjNbEGJJsmk4vvDQ3a8xV3qgDg0mQGkY8XY_1780659149
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

On Fri, Jun 5, 2026 at 1:58=E2=80=AFAM <pravin.bathija@dell.com> wrote:
>
> From: Pravin M Bathija <pravin.bathija@dell.com>
>
> Add support for VHOST_USER_ADD_MEM_REG, VHOST_USER_REM_MEM_REG and
> VHOST_USER_GET_MAX_MEM_SLOTS. Refactor memory initialization into
> common helper and add supporting functions for dynamic memory management.
>
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  lib/vhost/vhost_user.c | 253 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 253 insertions(+)
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

