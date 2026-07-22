Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFC7C44539
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 10:10:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C5BE40274;
	Wed, 22 Jul 2026 12:10:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 16E33400EF
 for <dev@dpdk.org>; Wed, 22 Jul 2026 12:10:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784715042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J1VS573HoU0XpOOB3QVPkV69SvbzsghoACz87xqnFOk=;
 b=gWauz2/DIq+c2RJwxqaqdbWXtmaHFOxTqfKGtUD7egUSO9L9p9mExgwkxuDzWrSYtuxztd
 SVbcnYmIEmYwc6QNs8qszpz7rC1mQl6gtfFSVrDnOgQMPBLT2fUz+NSOE8KlJ7l5dIJWYG
 9lLt42ZeO6rIDQ39dxaRzIi7OhRsCoY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-JTjBC8-kMWu9vE4ROPV0XQ-1; Wed, 22 Jul 2026 06:10:40 -0400
X-MC-Unique: JTjBC8-kMWu9vE4ROPV0XQ-1
X-Mimecast-MFC-AGG-ID: JTjBC8-kMWu9vE4ROPV0XQ_1784715039
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5aeb72bda2aso6746289e87.2
 for <dev@dpdk.org>; Wed, 22 Jul 2026 03:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784715039; x=1785319839;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=J1VS573HoU0XpOOB3QVPkV69SvbzsghoACz87xqnFOk=;
 b=l105dj9QawqSIwOrxazCf3qBxcfaC3eL4wEbdFittzJiM3Z3XBmPzfQAXFFb6h8llk
 skiQCMOquAGKMQ6EWhqj+5aGMegoTdcHO/Jg4RGOMpHFuJZDKNHIcSPAH1HXZZK2pNO6
 nnAjEY9BgHBhiZfdXAljFQNgVUquXDGfjVIHtNszGvcADpdQzop3XAsSoV52hNn4unjy
 pZFsXfvkDvJw8TZIiZIqFMfAwVZ0uDD5UYpFnrO7ki5xNAE8RQnpoWuWEnrmp/+Si9LD
 59OxRuEj8t8O7DfU/BlVgOXL4o6wHFcUhtVm9LxhF+byE31QJAZZEVRigC2+FfeaSo7/
 1tXA==
X-Gm-Message-State: AOJu0Yxna4qo2Yyn5RKMPE1CiljQVZfEc3+F5dbOzqN0G5Lrgk/gWMBI
 ejdLM+kVS+I9QkaQRqb+UqCi41JuwHmnAzuNQgPUv9mLNVJRVYY/fmBAqeOS85QzWx8nkUtVKBk
 wDQZCHw8YjYjl77PiQ6aS9rE342c/trp3RLWd/ucCqWDWxpUmcsLjh3RpKsoL8DR2iKyBB+z28K
 bpTrE1QRXS0wcbKwRp4P4=
X-Gm-Gg: AR+sD11cEN8Ye9a3igYqC2trQQr+4EwXrqZVASfROUsR/UN4+BjFzQOZzNmBSlzgqAj
 rfRvM4LtFqfgF/tsnHYunq9/UZRxICBVUd03bRFaQ/1eaEGBOj4C4ztKWPNNqyoUm5mGzdgBEri
 oSfGyWPhXnAdt4OKsj4RQgRVXWLYkG/d/aNmLvL/up7Dv/AHRHiWjEW+AV3gMk/6zPflQbqr35K
 8XvbkB/qg3gBdYBxU+QY+WvNnlrNTHHPiSVYpuiUjkZjs9K
X-Received: by 2002:a05:6512:b93:b0:5b0:22a6:6b13 with SMTP id
 2adb3069b0e04-5b28f6eb581mr5425229e87.0.1784715038832; 
 Wed, 22 Jul 2026 03:10:38 -0700 (PDT)
X-Received: by 2002:a05:6512:b93:b0:5b0:22a6:6b13 with SMTP id
 2adb3069b0e04-5b28f6eb581mr5425217e87.0.1784715038310; Wed, 22 Jul 2026
 03:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260721130814.2950332-1-ciara.loftus@intel.com>
In-Reply-To: <20260721130814.2950332-1-ciara.loftus@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 22 Jul 2026 12:10:26 +0200
X-Gm-Features: AUfX_myakRVCnH-fUkJB1pn3NUPlGG2hKB_58QOxpws8r-mC9cS_6SC0JH09qxk
Message-ID: <CAJFAV8y4HTMugLHKUaynEQ7qxqkAY+F6RZG-yUQb6ODLtM4FNw@mail.gmail.com>
Subject: Re: [RFC 0/2] iavf post-reset state restoration updates
To: Ciara Loftus <ciara.loftus@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 37QxjWur_-61e5kne85mdC6J5cRXyUgUGw-MaTGgUs0_1784715039
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 21 Jul 2026 at 15:09, Ciara Loftus <ciara.loftus@intel.com> wrote:
>
> A deprecation notice [1] has been submitted for the iavf auto_reconfig devarg.
>
> The first patch removes the devarg, restoring promiscuous and all-multicast
> modes unconditionally after a VF reset. The second patch limits this
> restoration to VF reset only, avoiding unnecessary work on dev_start.
>
> [1] https://mails.dpdk.org/archives/dev/2026-July/341822.html
>
> Ciara Loftus (2):
>   net/iavf: remove auto reconfig devarg
>   net/iavf: restore promiscuous mode only after VF reset
>
>  doc/guides/nics/intel_vf.rst           |  5 ---
>  doc/guides/rel_notes/release_26_07.rst |  5 +++
>  drivers/net/intel/iavf/iavf.h          |  1 -
>  drivers/net/intel/iavf/iavf_ethdev.c   | 62 +++++++++++++++++---------
>  4 files changed, 45 insertions(+), 28 deletions(-)

This lgtm on the principle.
This will conflict with my series that touches mac restoration, but it
should be trivial to resolve.

I'll try to find some time to test this, more likely after the summer period.


-- 
David Marchand

