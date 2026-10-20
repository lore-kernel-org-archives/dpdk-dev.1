Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B317E606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DKyxf7Oz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08645402D3;
	Tue, 20 Oct 2026 13:50:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F0E5640144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 13:50:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792497033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfB/HvPJiTvFiXpFkFub5fBr81yOIvek/Z0dfwBWThw=;
 b=DKyxf7Oz/jq3eTx9zTKlrdT7xTQYHUgwmIzTg509KlbRV9j3fzvkmVdSIDvYkPIqMI3tNO
 V1/8UOXQnZLxp4tdLNEJcfSXJCKoCxiCGwGC0SNA27n4WazVEOUVYkJOcMTlro4ojIgDqY
 PmfIIP4KV6+qxALpQTifOaBWBgtV+OY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-9eHgy6yuNJe25vtdUvc8kA-1; Tue, 20 Oct 2026 11:50:30 +0000
X-MC-Unique: 9eHgy6yuNJe25vtdUvc8kA-1
X-Mimecast-MFC-AGG-ID: 9eHgy6yuNJe25vtdUvc8kA_1792497029
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a009f82bedso24343455e9.0
 for <dev@dpdk.org>; Tue, 20 Oct 2026 04:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792497029; x=1793101829;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qfB/HvPJiTvFiXpFkFub5fBr81yOIvek/Z0dfwBWThw=;
 b=FrOgUfI1FxDPkpVm6RYxk1i0DJr5+qltNlSpPJOPJ7+qVxP0iLRLC9Mwo8K6PIrqX2
 oeWxr+YWUw1SOE7RXJTo5L0kkFT36xjgN+DkEP76dLkKVmSDrB8EBwWp+bAtUtSTTlHo
 4pjPH209+JsmhWWt5BD84r/+K5cdFDuWPF2UOLJYsbEYpCTU+vs79KZjgohfOJn9E7fi
 Xe+tyFZMvnWUW65gYOKCGKS8f/YNdTHH1p/2ziT2YiwNYcj8xVSq+4iARtlEVyAmftWm
 d7yuh/w/OubXJhNHM8u/nsSlz4mSTTWHPE8YfJuJp5QSEPfDTGI/86beGwnzsKji+v86
 qe0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrubnzN9VPckbKUmVrhQk8Fj2Wd8UDViHr1Jgs8FAM8Nf4O/BuYIeVrhpNtGxpNp25iTc=@dpdk.org
X-Gm-Message-State: AFq9FYIMbbHxwtG3UuXqP+GNxYVs6AMKIubydtWXi8OiLtp5+C9YvGlH
 BouSj5b+xyq05G+E2WZEa9lIyPkVMT1Ql8JeJzMA7KefuCTzzWunyDdj2Faqy2vy38PsTv27zPW
 ALScXr74ZiFQ8AzbK7p1Nhd0bk2cPbfutSIWVkjMdYS+P
X-Gm-Gg: AYBFou3q0WlpyLrUSYKPZ8zg+W3+oFuFpsdzsCJe0api6EEVpGbC5XtcVAx6qWMKBZQ
 46wLvzoEVFdzIr6yrtb4GfkzZ2y+SKyxJTIPNNT5piQaWo6SSo8aEknBeury/LLFr88ssUFLrUf
 FXHxQiz7kGCATb0gpNTnWGr+4FyNCs7BN2bj7DI9akaQEHmr4b6cFoTyaaLCed1SlUYm2XH+qvF
 4PAZMZ2tyNiXiu4fP9YpG0Eekas+8g5sVZp+hAca7s3vFxbZvMPDHUQjWWcBvcNhAUvbfQqLalg
 DtENWvSpJ8Poj0CyxqEy8AIxZfr4xR9Ht22uByV87bjbGAekGbjIZ9aFKHl86dIvJbgM8ED/CKW
 Hp+xRgWKnJ9Dqegy0OFzAppmRl7gaL3XrUQPhKjrfrqt5dVGEAMFjGIfRjQ1txBzFnMYHC4P47a
 tV7H3+tg8NV42i6t8m8rXSBrTbPb+UgkcYw0zKi500UxNbFWyfWWsPc1G7Tga2wm4nAM4sFCEy3
 1nSQ8XKMTb7LRYyFDy5PjFdYA==
X-Received: by 2002:a05:600c:4f94:b0:4a1:a2c0:7b73 with SMTP id
 5b1f17b1804b1-4a1d76086damr215970065e9.30.1792497028981; 
 Tue, 20 Oct 2026 04:50:28 -0700 (PDT)
X-Received: by 2002:a05:600c:4f94:b0:4a1:a2c0:7b73 with SMTP id
 5b1f17b1804b1-4a1d76086damr215969625e9.30.1792497028604; 
 Tue, 20 Oct 2026 04:50:28 -0700 (PDT)
Received: from [10.50.0.132] (82-66-145-51.subs.proxad.net. [82.66.145.51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cc8e98sm71702655e9.9.2026.10.20.04.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 04:50:27 -0700 (PDT)
Message-ID: <5229e80f-6621-4e70-a181-4ee24832cb68@redhat.com>
Date: Tue, 20 Oct 2026 13:50:26 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost: make cryptodev support optional
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: gmuthukrishn@marvell.com, gakhil@marvell.com,
 Chenbo Xia <chenbox@nvidia.com>
References: <20261014163138.1639970-1-david.marchand@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20261014163138.1639970-1-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pgjAmgTrfjUAKn7lqBA3kOG8FpmoEljAFrp34bs0tww_1792497029
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 10/14/26 6:31 PM, David Marchand wrote:
> The vhost crypto part has seen CVEs in the past and is getting a lot of
> eyes those days.
>
> Contrary to the vhost async datapath code, the cryptodev code seems to
> have active contributors, so dropping this code does not seem a good
> thing.
>
> This change here allows to keep this support, yet disable it for
> uninterested parties.
>
> Signed-off-by: David Marchand<david.marchand@redhat.com>
> ---
>   lib/vhost/meson.build | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)

Applied to next-virtio/for-next-net.

Thanks,

Maxime

