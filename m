Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE823606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D2GVBUZj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD7FB40270;
	Tue, 20 Oct 2026 13:20:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C892B40144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 13:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792495224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62f2ZN3kGrZCaIAnpSYrysAZJZuRfvyC5uKJxK57bEc=;
 b=D2GVBUZjFSeHKx1230LYb5iH3/7ybIVeMRad0ksgts++luX6Ie60xtPGSg9/T+6N4rH1mp
 DAd5GYPB/kMoyx6Dvpi2Bw34h05CxuorUM55uGtMApDsu04B9wceNfdmSoBHZ97bP2sFvh
 x2gVFr2Hv55N29t1AIrFppL6diZxg04=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-Oktpk-NbNUGJq6vPnrbWFA-1; Tue, 20 Oct 2026 11:20:22 +0000
X-MC-Unique: Oktpk-NbNUGJq6vPnrbWFA-1
X-Mimecast-MFC-AGG-ID: Oktpk-NbNUGJq6vPnrbWFA_1792495222
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1de9dac94so20385995e9.2
 for <dev@dpdk.org>; Tue, 20 Oct 2026 04:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792495221; x=1793100021;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=62f2ZN3kGrZCaIAnpSYrysAZJZuRfvyC5uKJxK57bEc=;
 b=H1h36QXjwYWwhnu5CbyU7KtL/onAdNTx/UfqKhnCrvLw/LpZkHZV5MBQeXBbff/iDB
 W+Vh9PTFVyL5HIAfpFWZZki5+IMsXe3n8b2sFfGAIeNjDfp2pTZoKoiy+SmnW8YPSXFd
 zJ8pRLnWT6WpU4kFRkhVjTIvWbw5+cD5+9mOv8TuQ2ExxPF0T/VyyLaG9jQSTpZE0lzo
 AchB78SnHMu6/zQLzjIS/X+1mm/SVc7dG8Rzhp5SEmJVBJwVNaJ6b3I4ta+NmnRGRS0h
 16IbinrOsT1T6VYR+DDs8Mys5/eCx6GEbq1S2F0AisSffCYxE4no/yVvo7A7ZjsgoK+k
 WolQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLG1fyW2FGI37MbKm+GTzQdCT7j6GLlNfKb/IolJ6vcmuDUmm8IRNvtTcLR3vdKURh8dM=@dpdk.org
X-Gm-Message-State: AFq9FYK06+QkQhNg8pMC8DEuhDLyg2qnLCVKCop7NZgXgT0rzRZY0NGQ
 tJLLBU41aIEkC9CqkHx/kTdm0dOOWaGm289OlO8gXnDEO8uNsTTy8bBJdPZnuAq0FUVCk52fKUD
 1VyOzMsszqMJa3JKrzqPlt13j10gO0E8F7n9V0TtcvQ9K
X-Gm-Gg: AYBFou1iUE2Lgr9szUUK7LVmOEMSo/+Wmn4F4LEPRT9reHkq5wzRmtci9QhDfcTbDRv
 XiLrqQ0aW7fyM/MHUmE7x+Z4pqTJvY/eddiX7KhGdGxQTCH7UdNzAJzHOXrlHKsoUzLqlt9D8/H
 btxGlpi+r+NHtxTq6iV4Rre+bwWjxiH/avzvvfXze+5Hr4DD/h9sAEXMit+esJ7OFmhCH0OBrYc
 sdnD8pYoo4TA+6DJAH27cCFFFTond80dLmgq18gaefhb6aJNuKjY1quWjQhKBSnSD2XvzsezTpq
 T6cEFuqVHuEPso/Lza1oRGVHbZ0KSUmo938WteWA2viqh/11xWdi+7SAgw8v6zW7+uSCQXLcPYA
 QJ/Pv0PD/gY+0yUbBCWFiHavIRai7XvgXMhCvwFzNJf8AEXKDYT0vS8he3fhwELusrmbh9WhPkl
 G69Z5izD5AAOuF/JDH2i1Pla8rN7xOJg2mP7YAUKgX66fNyA0uG0djB5F5De5ZN3SbbFIYPG5H8
 Bfikx+tEWQsR1pZMCxL3z/dUA==
X-Received: by 2002:a05:600c:a00d:b0:4a1:f736:79d1 with SMTP id
 5b1f17b1804b1-4a1f7367ac7mr26412425e9.16.1792495221557; 
 Tue, 20 Oct 2026 04:20:21 -0700 (PDT)
X-Received: by 2002:a05:600c:a00d:b0:4a1:f736:79d1 with SMTP id
 5b1f17b1804b1-4a1f7367ac7mr26412005e9.16.1792495221088; 
 Tue, 20 Oct 2026 04:20:21 -0700 (PDT)
Received: from [10.50.0.132] (82-66-145-51.subs.proxad.net. [82.66.145.51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cc8e98sm69739955e9.9.2026.10.20.04.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 04:20:20 -0700 (PDT)
Message-ID: <b15805ba-69ef-4b58-b685-266646a6cd1e@redhat.com>
Date: Tue, 20 Oct 2026 13:20:19 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/virtio: fix checksum offset check in Rx path
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org,
 Chenbo Xia <chenbox@nvidia.com>
Cc: stable@dpdk.org
References: <20261019135643.3146303-1-mb@smartsharesystems.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20261019135643.3146303-1-mb@smartsharesystems.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bDswjhRloQvUGC1n9qU247mFU0kz1cCVrkLf155d8K8_1792495222
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/19/26 3:56 PM, Morten Brørup wrote:
> Writing the checksum in the packet needs room for 2 bytes, not 1 byte.
>
> Fixes: 96cb6711939e ("net/virtio: support Rx checksum offload")
> Fixes: 0eaf7fc2fe8e ("net/virtio: separate AVX Rx/Tx")
> Cc:stable@dpdk.org
>
> Signed-off-by: Morten Brørup<mb@smartsharesystems.com>
> ---
>   drivers/net/virtio/virtio_rxtx.c        | 2 +-
>   drivers/net/virtio/virtio_rxtx_packed.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Applied to next-virtio/for-next-net.

Thanks,

Maxime

