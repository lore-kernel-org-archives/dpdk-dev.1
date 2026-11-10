Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25063606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YZkeRcDw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26C764064C;
	Tue, 10 Nov 2026 18:39:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 1CCBA40281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 18:39:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794332349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hYDlRWnvE4kGdoep8h6gBHyb/5PHrD+9evxb24SDlLI=;
 b=YZkeRcDwm6xVWqxpzp+XiB4HlN+mc8Av8mAkpjdh0QUsxDd1hTikPPeYZ6jhSMwib5GxGt
 yPDWoVUbNXOdc9lFUxK14d8Xb0iCJNiYnaU8f4tub2mNzVuuFrfeW+lzOnAbJji38KSmgt
 kwlrfCUB+Qfb0mnKXdytimyffVuuzEc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-zeWVLHyQMs6hT8LBOQ-2cA-1; Tue, 10 Nov 2026 12:39:07 -0500
X-MC-Unique: zeWVLHyQMs6hT8LBOQ-2cA-1
X-Mimecast-MFC-AGG-ID: zeWVLHyQMs6hT8LBOQ-2cA_1794332346
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3adfa274bb5so14401911fa.0
 for <dev@dpdk.org>; Tue, 10 Nov 2026 09:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794332346; x=1794937146;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hYDlRWnvE4kGdoep8h6gBHyb/5PHrD+9evxb24SDlLI=;
 b=hyVDcCOY0aaeUY3dyRU19MV190GjWSk98UjCLiYQk7pVKsx1aPBMaTVjqxR0YbZUL/
 8+hj9PdBP3Q62UqvRB3sHhPpEJbsxN+e6LINvrc82kecOehP8YSYTDFbuOw2M//jy7H0
 y2vFLhUhGM9FqK3c/IvBllNFvNbOjzUr1KX5D9lkXuXuCyxJUrd0qz9HrA1T03gAA1di
 vIN/ik359bOaukhfSoWM0oGcZIfa8+UmOovFlzjHME5z1g410BQ0b7d1HnfjNRd2HKXj
 DOWE8AfdHOK61Lsi9xcRFYYjHBYPFSBEdSRbYBP05xNbYJN/s6VivrfDmmsdTIoI69vi
 E2Gw==
X-Gm-Message-State: APuU4Z/RStnf7/m1c7Qg5d5uwk6x/nyQ/CZHg/OrKBr5z+Y79XMrzG93
 lpYjSKziFp04xRnvd+xFo4Nrvnw9oEjncOxkebDWcR4NdTJmKQlrH+gPL2+h9OFo1PP02FC+EpB
 rdtmMyrR1LbBUVhNHEuAAUpBpfiKU4X8PS/O7PFVnXpP2GDOdDbBi2FbKUi16DbYhejVJfykMqT
 jFz8HystAwKxZf/vrRJrQ=
X-Gm-Gg: AYBFou2JGrWUl6A86/I1NwKYn0LCZJ02zQK2Cb8ZnOtk8Ix1PxhFoPEcRjh9ofiaXZG
 DRLDDyUEeM+rHO72Abmr27rIgh91sdsIOecBnZXv161aQNcqSR59VmD8Anu7O7xuMPMJLashHfH
 uvMQl0R1e/QtvJMlG8KtGOiQd9P8KbDJynwNfVxceZSjBEYRW39MF35Lr1OsS9fzDu93qT9BEmO
 n92fWvxGe+IDQ1/yVDkXdvjcu7CTt4WhR10dOLE6WOL8CJZ
X-Received: by 2002:a05:6512:3088:b0:5c1:4cd0:16d6 with SMTP id
 2adb3069b0e04-5c156ee3b91mr1017823e87.65.1794332345918; 
 Tue, 10 Nov 2026 09:39:05 -0800 (PST)
X-Received: by 2002:a05:6512:3088:b0:5c1:4cd0:16d6 with SMTP id
 2adb3069b0e04-5c156ee3b91mr1017809e87.65.1794332345402; Tue, 10 Nov 2026
 09:39:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103170500.1241751-1-thomas@monjalon.net>
 <20261104171044.2236004-1-thomas@monjalon.net>
In-Reply-To: <20261104171044.2236004-1-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 10 Nov 2026 18:38:54 +0100
X-Gm-Features: AclHuK83_MgN9bDRNjz_is8y5fNBGmTdMEta4uxBXEcW76ndcO3tv_HtkUxzdr4
Message-ID: <CAJFAV8zP1L_pmn9o+gN0ego=G75TkzYyfqFD79nLRHE+Jc_LZA@mail.gmail.com>
Subject: Re: [PATCH v2] ipc: fix multi-process disabling
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lpBmQvV1jukr4Nifp1QpqM_F3XlEu2hQZtqDFB44xhY_1794332346
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 18:11, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> IPC and hotplug operations checked --no-shconf incompatible option
> but ignored the multi-process status changed by rte_mp_disable().
> As a result, IPC was still attempted
> and hotplug devargs remained subject to the IPC message size limit
> even when secondary processes could no longer attach.
>
> Change the multi-process status when --no-shconf is used,
> also covering --in-memory,
> so it becomes enough to check this status only.
>
> Allow previously registered IPC actions to be unregistered
> after multi-process has been disabled.
>
> Fixes: 5c307ba2a5b1 ("eal: register non-EAL threads as lcores")
> Fixes: d2fd16c8b003 ("eal: add multiprocess disable API")
> Cc: stable@dpdk.org
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.

-- 
David Marchand

