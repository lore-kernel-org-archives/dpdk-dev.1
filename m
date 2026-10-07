Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCB8CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 15:30:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F2AA40608;
	Wed,  7 Oct 2026 17:30:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 06C3840265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 17:30:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791387009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0zwLA6PSj4leokS6NSt69hPhLR2aLxZfvIvH9chxYQ=;
 b=QPRWsyDutEyCX3Lt8+ACIaaSoPqFgMu8HBpD/Q0sYVD1n516QqzDAQY6OZl9ATWd9lS7ps
 SV2o5i6TI30SETFh6N+W+48SkbGXTiAl0Tfyc7dokQvSIxPC5EBXMKvWgo4W2UvSYshfjk
 tZM1H5faP/e4t3GSpFKyez2oasalSXo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-7Mc0INX3OpqfqaxFWgy-ZQ-1; Wed, 07 Oct 2026 11:30:07 -0400
X-MC-Unique: 7Mc0INX3OpqfqaxFWgy-ZQ-1
X-Mimecast-MFC-AGG-ID: 7Mc0INX3OpqfqaxFWgy-ZQ_1791387006
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5baf6f208f6so2394514e87.3
 for <dev@dpdk.org>; Wed, 07 Oct 2026 08:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791387005; x=1791991805;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g0zwLA6PSj4leokS6NSt69hPhLR2aLxZfvIvH9chxYQ=;
 b=ueo0ROVORyxRyfYH9oeS0qTZOpr7L+meNMAlvRH0qpWciiM5bfaba2sVk9T8CuK+/Q
 LHy/CijVg3ptsevX0AX2lTjffw+9GjxNNsDBNwsHM9ZTVocPXYioEhepIy9pl/qSoeKx
 ICT5+FXDPVKSBxEUFKpewBS/HUF8cYGtdNMQWk8Rjt1uuEwEYZp2ZBJVLwvahnxQDpdH
 BeYUIwqQf60efpVur9jrnqR/7mStr0Tf0+4RKHwtWHuhP1Cte8SwGJ4yRJSfZpWGd8fv
 gwSo9V63WqZrgf07laLWNmoi0og++Om6RssjImy35kB5Mgae6cml4Svcwz7sT1A0MsHO
 D8Xg==
X-Gm-Message-State: AFq9FYLO3NXPvz+VoqSe0gKdR89yf5RSIIatXx6nHPUtG1h9LiCnERym
 9atyZzLFR81Ivrgfr8KSi0Gh1UMMjpBfAyjwg+NdLXmfAYuY/YVJtIWLWl+Ou9L5abhv1R0rvar
 KoA77li3BU48Q+dNLKE1lJyxaB0yFQFsCFwjfERONoXf9gMs2fRtZrciZbDQpzvuLe94PPO19Hm
 MQVypeA/9IvRWbGlIs6DRTQxFAeHA=
X-Gm-Gg: AYBFou1jbnFJuLxrfCcPy9zpIhotF5GSMHJGcJe0qaygQ5QZONEpsN4yT5c1JI320qg
 ntxxZGikhCV+TW8Cv4XpZFo5a3sIqwG/XVdkNduItFD9fvGfiHKZiQno8ozdD7kUNRc5spwh759
 vVUJ9x5s4lRuVbmUFNvysSpyViDpdAB3cY5qyCiHAmPb9vjh/Q3+d9+qUR/6JnPH2KmEroKK9H0
 Hk5Q988Qg7m/Tr5A9+PtZwsVdja6O/8HDCruEuEG/x3PH8i
X-Received: by 2002:a05:6512:b20:b0:5b8:f202:7749 with SMTP id
 2adb3069b0e04-5bcd0745e4bmr945188e87.59.1791387005226; 
 Wed, 07 Oct 2026 08:30:05 -0700 (PDT)
X-Received: by 2002:a05:6512:b20:b0:5b8:f202:7749 with SMTP id
 2adb3069b0e04-5bcd0745e4bmr945176e87.59.1791387004668; Wed, 07 Oct 2026
 08:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 7 Oct 2026 17:29:52 +0200
X-Gm-Features: AclHuK-i0jjJ6EePWbuAIw1_OTaqi7bpR6w5z0S61a7Nb4E1BPmIysnwd73BEYo
Message-ID: <CAJFAV8zKezcPtYq7qgOP5yM8PGrdwJfRX7k8YKBgM=WeVHPtmw@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] remove rte_smp_XX barrier
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pkrRTV2pA2xSFoMK2B6WPMLT6K1oCklCSiA_llUaUL4_1791387006
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

On Sun, 20 Sept 2026 at 20:14, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> This patch series completes the removal of rte_smp_XX barrier
> functions that was announced over five years ago (20.05).
>
> In the process several cases of race conditions were found
> and fixed. See patches 3, 4, and 17. These are marked with Fixes:
> tags and Cc: stable.
>
> Most of this is mechanical with AI assistance, so strongly
> encourage maintainers to take a good look.
>
> Functional and build run on x86 and ARM native.
> Should have no functional change, but as previous cleanups of
> atomic have shown performance might be impacted by compiler bugs.
>
> The lock-free stack patch measured faster than the generic version
> it replaces, up to 63% on a 32-core x86 box; the numbers are in
> that patch's commit message.
>
> The RFC removed the barrier test outright.
> Konstantin pointed out it still covers the custom x86 seq_cst fence,
> so patch 19 now keeps the Peterson lock test and rewrites it around
> rte_atomic_thread_fence(rte_memory_order_seq_cst) instead.
> Need some careful patch series ordering to keep this all bisect
> clean.
>
>
> v2 - address review feedback

I see comments on patch 1.
There are two conflicts after merging the rte_atomicXX cleanup (those
look simple).

The last 3 patches are a single topic.


-- 
David Marchand

