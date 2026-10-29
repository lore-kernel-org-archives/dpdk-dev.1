Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C377606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fXF4C4Og
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6685040664;
	Thu, 29 Oct 2026 20:43:33 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTPS id 81DE040151
 for <dev@dpdk.org>; Thu, 29 Oct 2026 20:43:30 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2e9d1114320so19876435ad.3
 for <dev@dpdk.org>; Thu, 29 Oct 2026 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793303009;
 x=1793907809; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2E1L25WwgqXQRjlQNnPaDAJHzfGbi0cEVSwrRssNeTY=;
 b=fXF4C4OgLUUClKNfyiRSm1BE/86Q0lssGrOEd1FWExv/bjw+/RbySVVFiJ4CZWoyMA
 XAHLj0N1lbzgDzIw0+/c3UimVhEbbkLDhnqzYSTVDahC0d+2Tgi/F0Lp29UdFqVaqIyO
 MtcVYKE3HFE64ghPA0dRtEGWuvjZPHuniFMxox1H1vvo7Es0NS8pQosG4ckV/+tKlHrn
 e13FTFr/+NFlaAMrWBfKDiVi7eiNyQTQuVX58lXYMmkFFh6L199O8zqwxzxTH97cil+Y
 a7rBdKORwb3AmGwZQB8X4O1FiyWZDdLEtIkrnwszbMMmHnRt6rtfZPYymzadhBxXh3jo
 3H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793303009; x=1793907809;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2E1L25WwgqXQRjlQNnPaDAJHzfGbi0cEVSwrRssNeTY=;
 b=ZdB4fQCxTlE1PyYqLu6Vshz4UTu6ED508dDujqOrSf9QbP2F8vqWwNcsIpzgQq1GSL
 XIQvirQuKP/aeiT9xGjmTf3T9fHhW/asIFdoFp4wDM77NW0Mt9X9EOh2NsE+yekI7VSV
 Gckli/J7vgGqgA0REbo5NoF0cbTokB80wrPdJnxyqmHlFXEzEd08aKckGcd6uvSw4FzM
 95M2XeHI0hd/3yZtSJPqJgdQfrZLkdPSZpT4WACdWv0Ye3zKfW59wu5SGyDzAj0XuxWR
 8QOkPnKSYPb6V0CRO6yrpUVnk4EmiOqpudAdQs7seCUvQF6aoi2bpuFn2slL1EIr37wv
 tSJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwo3K2I9pxRudRlrIV9hSzkJUwS2tHkzCKyT87VcdRwf7AARCslY3znaZNg3IcepuZKahA=@dpdk.org
X-Gm-Message-State: AFq9FYKxtwZsQ5gcCdYYJ1QIXP70FxZAMqI42s+IyKmbENaTnpEMaWUU
 bT9UfPtd1suSOKg+O8opA2jnOVg+FcTcupNvGQ2zdwoYitw8a1IBFaVC9l5pr/RSpm8=
X-Gm-Gg: AYBFou21T/5Ia361+eLJb/rX0fpGB5kVH+64mmbVMcxsgkOGBN4iKVguYZIsxVvcuyu
 YUOI9jr7U0o1k6s4ATWqToLtboAgk9MNpuTPQPwRpaT8UkEJNTZ2+uI3XkqGSQUlnJ/bQZY8O1P
 zLzjvMfBxk5bDSwFW3fojD4wGcDdk/O+oVRsOdZXdeup49kS7qVY8g9HKoWZNmnBIko/rYm2VyX
 1ZnwWnm+eYu17uholzZP9VnCKaXfmYLnM49ssyvNYVAMMm7VyEi8sxRS7Zj9hAYhJ5kJdIGvX5o
 Mh4IbvZaX6G2+F3GN+Z+XPYNDLcPCQvPVdkLfqlonCfjGJbDBma+rouUNnXk2qOTRteobhenlR8
 aMBG1pRnefyXQiZ4cbl3OGG83dpLoTt0obJkBSzqzeW5yZ+AhWJH7Vna6TZqP7fa5hvLMza0ue7
 wu55VK0/xu/Z4T3BE/sO0E74U748GGfX5MmyvC44QZuquPGW572ZgZQ2O/MG/2cGQPHjL5Wb/Rq
 xdGXrCtN9l++1QXbGFkTnscgf/GEQTB7paN3TByMzF/42VuAFlUxunib27N2jg3QQFLEUNXfcmc
 5E8LUhJf50fs1ylX3susP4uJkrGnjqjAib/fClDgu/qJQZcxS/yDYdSEZBl0joNYnu+ez40T
X-Received: by 2002:a17:903:1a0f:b0:2e9:6788:9369 with SMTP id
 d9443c01a7336-2eb364cbac0mr3803915ad.34.1793303008593; 
 Thu, 29 Oct 2026 12:43:28 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb3695fcfbsm404265ad.66.2026.10.29.12.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:43:27 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:43:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chen Zhao <ch3nzhao@gmail.com>
Cc: weh@microsoft.com, thomas@monjalon.net, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2] net/netvsc: fix event buffer leak on realloc failure
Message-ID: <20261029124325.2ed8837b@phoenix.local>
In-Reply-To: <20261029165452.966911-1-ch3nzhao@gmail.com>
References: <20261025014634.3295418-1-ch3nzhao@gmail.com>
 <20261029165452.966911-1-ch3nzhao@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 16:54:52 +0000
Chen Zhao <ch3nzhao@gmail.com> wrote:

> rte_realloc() failure overwrites event_buf and leaks the old allocation.
> Use a temporary pointer and update event_buf and event_sz only on success,
> preserving the existing buffer and size on failure.
> 
> Fixes: 1f2766b7ee02 ("net/netvsc: resize event buffer as needed")
> Cc: stable@dpdk.org
> Signed-off-by: Chen Zhao <ch3nzhao@gmail.com>
> ---

Updated the version in next-net.

Note, this is a real corner case. If rte_realloc() failed the application
is going to be failing anyway. It means malloc pool (ie hugepages) exhausted.
