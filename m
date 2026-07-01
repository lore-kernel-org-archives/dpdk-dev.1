Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4C8C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 10:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B105402E0;
	Wed,  1 Jul 2026 12:09:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E067940278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 12:09:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782900562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QY+jeIeBljXM4bcGPgIjVh4a2H61lEMTJKpfALu8knE=;
 b=V1oBBlkoFmBqTYVPzzlxjhvP7rAjUxhg8w0c9/C/A7Bu7u8I1BtVXNUdUZN87FMKJ2KlJa
 ntS3HZwwg5VJ/BOxiMwWtG91pp7H7A79kW/BIDvBu9VlcdjXyWNoxVYMzBOqxlyqpvZPT1
 x9oIathF7IGt8VkQDCtYm45KX29h4MU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-GImE4LP5PLKtZ1scKteqqg-1; Wed, 01 Jul 2026 06:09:21 -0400
X-MC-Unique: GImE4LP5PLKtZ1scKteqqg-1
X-Mimecast-MFC-AGG-ID: GImE4LP5PLKtZ1scKteqqg_1782900560
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aeb55ce6adso351454e87.0
 for <dev@dpdk.org>; Wed, 01 Jul 2026 03:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782900560; x=1783505360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QY+jeIeBljXM4bcGPgIjVh4a2H61lEMTJKpfALu8knE=;
 b=EFTyIPHoMf2PxVHlKD7+8N3VRaDOPLSrgLjHZkBuy5/OxpD8n/nLEcRpCAWdy2Ys8E
 5BlqGh2HyGn7OlOQFHRbZbCxRLR0+Ad6Int9zjDQu3otrIdaYfYX6Nz/Ofgr9yOpH1VZ
 KediAmEYAeIj7IyAZf04Ffar/F0uFlf+5UYeDWO7xhI1BMcV7oLs7Z7F3ZZxMqBiHasG
 C0CmwgM6lmjv7mFSOKBeXrf+iIlYg0FRZxmOkHG+QohE2wsPRHVAC3TyEy4jNVKrtZAn
 4+2sMWkFJjZIU2jP9CQcifJDNGJNwwjllERbVAy98kqxH1bzqgQKJrxZuNPM6G7lMevd
 7aHw==
X-Gm-Message-State: AOJu0Yy9YC0hQzuAZDjWoaqTGCx2xHxhIfqbovFac1tL+DewNMbufuGq
 C31wreRhmbfyAeiiED446SYLZ/LKMFpw6OEEQ98jPIaEcV04SzjzJbhrRhpiGxG6dNbxVDrrltb
 j0PKt8le6YuaBZ31fE2vvHUew9MMYtSBELyUHBWgIlafvpDXxpDg6sE3ydV7y3ALNH1ZasxnYok
 uzeWwNJYi+55GsZ5m5hTY=
X-Gm-Gg: AfdE7ckN9HWbKoQGYWeD/de3e9g7/jA4HgqS43cWhQSGbuk0nCItaxUpYxPjWlty9hU
 C4u2OzzIOFvgu1B30a2uy90gaSUDUf3kI3QbFo55oIxKXvYhGyOZXfQypoZkUsoMkEQDfmbstuh
 Y3vkbcoBLvAOjqllHx4u+ElQTxAUaX8gfeumNN2boBQEi4UzxTb7xQjEwTv6AO8CY/+Afy0UAc1
 5J8vVUoQ4VkLaHzMymko/beap6ijSTWfBnpRqPB4FQkVTFTmJPa+ELHCRs=
X-Received: by 2002:a05:6512:1556:b0:5ae:bfa0:54f1 with SMTP id
 2adb3069b0e04-5aec743317amr196882e87.59.1782900559625; 
 Wed, 01 Jul 2026 03:09:19 -0700 (PDT)
X-Received: by 2002:a05:6512:1556:b0:5ae:bfa0:54f1 with SMTP id
 2adb3069b0e04-5aec743317amr196864e87.59.1782900559016; Wed, 01 Jul 2026
 03:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <740b39c5098b4d40cafb9881ad70865a3c889012.1773936429.git.anatoly.burakov@intel.com>
 <cover.1782469943.git.anatoly.burakov@intel.com>
In-Reply-To: <cover.1782469943.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 1 Jul 2026 12:09:05 +0200
X-Gm-Features: AVVi8CejJKMt5Ak1jlPNnSh0sSrMDRCPZEAcOU7tngpqfod-wC_UasA7NIRX2OI
Message-ID: <CAJFAV8zbxOxNZpC7bSDowmLGHrGEcrs+rJXNrMPy2kfUdbkuig@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] IPC fixes
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YmaCXEHZMhoGl0Mx0ZaXHXcG7O3XVR5D4PNsc7ghtrQ_1782900560
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

Hello Anatoly,

On Fri, 26 Jun 2026 at 12:34, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>
> Coverity has reported (issue ID 501503) a memory leak, but there
> actually were a few more problems with IPC than that. This patchset
> addresses said problems.
>
> 1. Using pointer as async request identity is unsafe
>
> Because asynchronous requests can fail at arbitrary points while
> having arbitrary number of requests or alarms already in flight,
> using pointer as request identity can create use-after-free risks.
> Patchset replaces this with using numeric request ID instead.
>
> 2. Alarm cancel can deadlock
>
> Async request handler may attempt to cancel the alarm, but an alarm
> might have already been in progress blocking on the same lock that
> is held by async request, leading to a deadlock. Patchset removes
> the alarm cancel call, and allows the alarm to fire. This is fine,
> because due to fix #1 the worst that can happen from calling stale
> alarm is a noop, as request ID would not be found.
>
> 3. Memory leaks
>
> There are a couple of memory leaks in failure paths. Patchset fixes
> those.
>
> 4. Zero-peer async request does not trigger alarm
>
> When async requests are performed but no peers exist, we created
> a dummy request and put it on the queue, but we never set the
> dummy alarm that is supposed to handle that request. Patchset adds
> the alarm set in dummy paths where none was present before.
>
> v7:
> - Moved request ID reservation till after allocation
> - Added build check for request ID size matching pointer size
> - Moved comment about minimum delay alarm from patch 4 to patch 6
>
> Note: AI review had a bunch of false positive "errors", all of them
> looked at and verified as such.
>
> v6:
>
> Moved pieces around, namely:
>
> 1) apply request ID refactor first as a standalone patch
> 2) fix the deadlock immediately after
> 3) fix memory leaks next
> 4) add missing callback as a final step
>
> Contents of the patchset remain the same.
>
> Anatoly Burakov (6):
>   eal: fix wrong log message in async IPC request
>   eal: use request ID instead of pointers
>   eal: avoid deadlock in async IPC alarm callback
>   eal: fix async IPC memory leaks on partial failure
>   eal: fix memory leak in async IPC secondary path
>   eal: fix async IPC callback not fired when no peers
>
>  lib/eal/common/eal_common_proc.c | 137 +++++++++++++++++++++++--------
>  1 file changed, 103 insertions(+), 34 deletions(-)

Series applied with my suggestion on patch 4, thanks for the fixes.


-- 
David Marchand

