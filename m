Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B53606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JFrMGQcf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D682940270;
	Tue, 20 Oct 2026 13:20:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3147E40144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 13:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792495198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1StECkAyOQ4HDakSVZo2j31/a3Xs8cU+Q3/zBCFg7Q=;
 b=JFrMGQcfPLMYseW9j64H+PJ1kM7H6+jH6hNOU3NbR4iiMhMWVP5YimQtazefp3+VQ2EuMO
 FZivfleKgu9Efd0ROzPjT5JerD68WIKNM1vuXn7XXuR7WmpFDx+gvva2FHbF8vBHspFEYQ
 TJgBCYhKGNUZkI92wHFMY9NlZB087Rk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-jrvKDgJvPwSHQIKvsZ41gw-1; Tue, 20 Oct 2026 11:19:57 +0000
X-MC-Unique: jrvKDgJvPwSHQIKvsZ41gw-1
X-Mimecast-MFC-AGG-ID: jrvKDgJvPwSHQIKvsZ41gw_1792495196
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1d7663a4dso29457015e9.2
 for <dev@dpdk.org>; Tue, 20 Oct 2026 04:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792495196; x=1793099996;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z1StECkAyOQ4HDakSVZo2j31/a3Xs8cU+Q3/zBCFg7Q=;
 b=aGJpPOCbRy8QYbDLJpPIiAGnfp93qhegje1jzfLkgq3nIlnX1tCDJN5iJxvWEgBCBi
 9YUDknBOSoR7xtca9XXhWnwlAF8eWvQ7vrmVXmiHHuiCcxYbeDu58L+aiX6JOc8DIj+G
 YbuotUZkhUNqomm96s4hbaymszJFqbSQM22aIv8uM09Wy+OaxckvZp9/I89QvSa9u3/s
 QRKKnylTFzvkuKIGt7y7bFd9AbpIrKuMTThf2pZq/mOPTH+Hg69sm6iSVP4QTc4qHN+e
 jsKifKwX5E3jJ0AC4k0pqA/H2Y41EfxT8s1753am/2SIDlBJ2RdwjMs9isIG6sVuySbp
 TRdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIKS8yvWjjm7dmUkcDTuAMNN1MBb0FFkA7mqh2aYZpRJktumH2BNIO/SPbZ1vo6i/VnxE=@dpdk.org
X-Gm-Message-State: AFq9FYI2BvaNj6O/uc0qzkb2+ht3E25kjIysTswUIWUFKm7vc+LWN0+e
 rWuXvw5z9ju8Hm7U423dp1SQb/TM0DmhBybto31JHrS6gQdSxnPaRFqHjK9NYviNhYa7IweGke2
 sOqtZBDZLCI6BTicdXAYbT8KAM7LLknBhylBXqksFtqLASHUmvLUC
X-Gm-Gg: AYBFou2AeHmH1pxeHhYcgMdCHybIapiQiYgn/vv/+F8ms8A+N+YpHzcatK5SHlY+Y7v
 +SLSwIUBVi8WQrWMBS92U4/LWSRqI5urqfVzTRr8w8Cqe9BHB5rEmEZ085gTEaoE01fLghUp+8g
 CBmErmCdkMU3mVSvYeXntdHo2RFD9HrT+JAab7Iv3vIDGHmdjkfhfxqRJh0qarRQwpOnxuK09TM
 3lfbmPzptHz3FNN9Ie4M4fz1zLtEELo89z+48ks7DSSsdNpy8l81ON4IcOcsSBsgTFT8zCx65lJ
 2GP6K6k/xHDXehe6NVkvMn17PVBBX04A/xXtpd8aA2S0kFWuSW2S1GtyIGQ1/8aQyknHO5bWsaT
 aWS8AAxOp21teDJCkC9v88+UyDFohHDQsw0vlr92jdHcXi5EReOhPH5jlaOF+P1NUkoAAx/85J8
 8jWsaZpQZB3L/rOxbqwUjwpYkyhIao4gn8f3akYe5juwDC4vB80/h+WHJ/dPZzxD9IkPv9Rr2lD
 hTVJWaFr6xvTnuQn7eqqalHGA==
X-Received: by 2002:a05:600c:8b28:b0:4a1:6c0c:ab93 with SMTP id
 5b1f17b1804b1-4a1d7634d5dmr226801415e9.28.1792495196360; 
 Tue, 20 Oct 2026 04:19:56 -0700 (PDT)
X-Received: by 2002:a05:600c:8b28:b0:4a1:6c0c:ab93 with SMTP id
 5b1f17b1804b1-4a1d7634d5dmr226801125e9.28.1792495195957; 
 Tue, 20 Oct 2026 04:19:55 -0700 (PDT)
Received: from [10.50.0.132] (82-66-145-51.subs.proxad.net. [82.66.145.51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cca26dc8sm248988205e9.3.2026.10.20.04.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 04:19:55 -0700 (PDT)
Message-ID: <0f07925b-7862-4eed-8239-a33495758fe9@redhat.com>
Date: Tue, 20 Oct 2026 13:19:54 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost: fix checksum offset check in Rx path
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org,
 Chenbo Xia <chenbox@nvidia.com>
Cc: stable@dpdk.org
References: <20261019135814.3146545-1-mb@smartsharesystems.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20261019135814.3146545-1-mb@smartsharesystems.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: klnqAVjAS9HtUp4aUdNH64ZgdilPfPLOUNb_KT4_xgM_1792495196
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


On 10/19/26 3:58 PM, Morten Brørup wrote:
> Writing the checksum in the packet needs room for 2 bytes, not 1 byte.
>
> Fixes: ca7036b4af3a ("vhost: fix offload flags in Rx path")
> Cc:stable@dpdk.org
>
> Signed-off-by: Morten Brørup<mb@smartsharesystems.com>
> ---
>   lib/vhost/virtio_net.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Applied to next-virtio/for-next-net.

Thanks,

Maxime


