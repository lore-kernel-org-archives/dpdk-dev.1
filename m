Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C0AE9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:27:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0362402C5;
	Wed, 18 Feb 2026 11:27:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 09D2B402A3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 11:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771410459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OcYEa6HvgsXDv3ht2FougzB3XTHzRqQKfd1wVl1LdOM=;
 b=GYKO+8aGmWcnu4vrQBlPeCMXzzAXYRdwyA/0+Kz8Ii4Jy6o5obm06C2WtAMI078InYHpW3
 tvB8rjbcJb4UwC0piCEM445MXCI9BW5AY79D6F2UL5aqS55akV9cmWnKUPCF7/C3KjBYfD
 28WIFGxeFaeQ81e6aNf7PYZLrwReK8U=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-C5wW-Vl1M3Oarz3ei8CGlQ-1; Wed, 18 Feb 2026 05:27:37 -0500
X-MC-Unique: C5wW-Vl1M3Oarz3ei8CGlQ-1
X-Mimecast-MFC-AGG-ID: C5wW-Vl1M3Oarz3ei8CGlQ_1771410456
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-59e16c11f49so3983386e87.0
 for <dev@dpdk.org>; Wed, 18 Feb 2026 02:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771410455; x=1772015255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OcYEa6HvgsXDv3ht2FougzB3XTHzRqQKfd1wVl1LdOM=;
 b=E2O6Y5jOoSbGjSSYnb9CYrfRdm5mG6bo4/pJ5vwEHiT8lah322D0McQfDtfKHPMMkE
 RSbl2l9wqe76Kwlte1syKQ+sGvvJepXemFYyC+AoTTNbM18zjxcQj7y+K8cwSYlf9x5y
 Xb71kvx+SHDyXIZVata6vm8HNu07qlRFFMqzPCmYLDccZCEfQ+iCN6G9GL+YFIMZx3z5
 26ZCN5CXjeWm2arVO/kmdkrZqnlFsZot3THq+aQButBejlg2KUZNahyxMsPq31D0LwEn
 nYB0tiwqMyCO+NafPnnDJytbzMWcqlaaiZNesHnJq0DxAo77AW3l2j51Md1JhQfxkr7X
 17KA==
X-Gm-Message-State: AOJu0Yz44jjBHBziEhb7VM0/2cmOaOnWfOkU9ND63dHT031vIDCW/ZSi
 SbTbKhSCGvRi+n8poS4VnasdWl4K/Mmb2NrtEdem6VkFDisg2f4Hmmd3vKR9tyTFvEctEDPQM8v
 IQQz/9LwGsVMh21EY3bvSutpccMFjOi8Ry2TB+9IlOxHFUEmz/DxOSdeLZRExS5nqXdidfnkL8r
 0FDSSOV3YNYjPiVoFk4Nk=
X-Gm-Gg: AZuq6aJM+tznlSbZOp7n/L0YcV+i9FVMNTMR4Ih8VCi0KnvAY9yoqZcpRi+AlMid6k6
 NNscF0EuYldj/4BbihGeVMi5kxOUNPZZmWKDzFd4mYjCVF6aoKa4+5K1Rgjb9Kl/+fetrrw+WEU
 q8KK7i2ZZNUbyKHNdIyI0gIWtjCrbL/rSSJc8VXevW8e1zuQbg0iiZ3M0wFislRk+N8Ustl+cB6
 PDOEtXo6mJab89vtPgLr+BZhempKQLwzyrYYq7rBv9KbfHZDE6TpVK4Mp26uoVzAJACSA==
X-Received: by 2002:a05:6512:2243:b0:59d:e018:563d with SMTP id
 2adb3069b0e04-59f6d37e537mr3486788e87.37.1771410455489; 
 Wed, 18 Feb 2026 02:27:35 -0800 (PST)
X-Received: by 2002:a05:6512:2243:b0:59d:e018:563d with SMTP id
 2adb3069b0e04-59f6d37e537mr3486771e87.37.1771410455046; Wed, 18 Feb 2026
 02:27:35 -0800 (PST)
MIME-Version: 1.0
References: <CAJFAV8yjTs8inmZqYyPrTubc_oaKfEi=nv_58HzyXf9f+pPg0Q@mail.gmail.com>
 <20260218090540.89215-1-malikovyehor@gmail.com>
In-Reply-To: <20260218090540.89215-1-malikovyehor@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 18 Feb 2026 11:27:22 +0100
X-Gm-Features: AaiRm50PB8tiRqHWr9UDU5qX15UxLuBQhcOrL2PlFrPPPtTljPpIG8ZL7Ja2xCA
Message-ID: <CAJFAV8wfwo1y67H5M=6hCk9ifyqMpqxEySUWu9u9KE3Niy3jcg@mail.gmail.com>
Subject: Re: [PATCH v12] vhost: fix use-after-free in fdset during shutdown
To: Yehor Malikov <malikovyehor@gmail.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, chenbox@nvidia.com, 
 stephen@networkplumber.org, Yehor Malikov <Yehor.Malikov@solidigm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _ZhR_iTqj7PWVZPupVyiBpBw68lwmZCI7Kz1T6BUy6o_1771410456
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

On Wed, 18 Feb 2026 at 10:05, Yehor Malikov <malikovyehor@gmail.com> wrote:
>
> From: Yehor Malikov <Yehor.Malikov@solidigm.com>
>
> The fdset_event_dispatch thread runs in a loop checking the destroy
> flag after each epoll_wait iteration. During process exit,
> rte_eal_cleanup() frees hugepage memory while the fdset thread is
> still running. Since the fdset structure was allocated with
> rte_zmalloc() (hugepage-backed), accessing it after rte_eal_cleanup()
> causes use-after-free.
>
> Switch fdset allocation from rte_zmalloc/rte_free to libc
> calloc/free. The fdset is a control-path structure that does not
> need hugepage memory. Using libc allocation ensures the fdset
> remains valid after rte_eal_cleanup() releases hugepages.
>
> Fixes: e68a6feaa3b3 ("vhost: improve fdset initialization")
Cc: stable@dpdk.org

>
> Signed-off-by: Yehor Malikov <Yehor.Malikov@solidigm.com>

Thanks for the fix.

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

