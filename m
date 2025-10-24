Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF11ECCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:11:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EFDA40608;
	Fri, 24 Oct 2025 19:11:26 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id D9331402E8
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:24 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7a265a02477so1815133b3a.2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761325884;
 x=1761930684; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCr6BORe+Hi8O16nM0LZl+DWPBBJAj/JzmLPJZ2mJeU=;
 b=g1jleOePdjYYYvFTWgwORo71qTqoTIj8vAI5QC42hhrGNZ77HOb+3WL3s4rLZ3TsXF
 mi9SfI3r06DOV5ib7Z+Aq/FikBdNOyyWDrNt1sM/cnW1BxfVq9uR30srY3ABvjXLY9yh
 f95wm4Ut8gs1ERlwOOs7tmmxx4B6dkA/Wj7h3Yv7U4A1IwQjR6rONH9njmzAtC+dVOWZ
 gM9GbYL8uOzRxlECQPL52Jnl+N//DZLkmTLPQEQgvMiNgyd+zG2inw2OvcFIrW1I0ZkC
 4jbmOOdwn26RWMQWS5W3oe+GqiNqdma1nd+kF9BRe3jQ/YlQlXbMWdpWUpAcDyyApQci
 7TXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761325884; x=1761930684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QCr6BORe+Hi8O16nM0LZl+DWPBBJAj/JzmLPJZ2mJeU=;
 b=fJzA+2G6s72Yaji+fMINj40/+ZrntGDpc+vB2PMJ43S3rIMM/ga62yhrdECzwTs7XD
 yJRNw+KB1jQCEqK6CrKX2eqeUMGvYzcial8YBKe65EsgzjrNQccTkYsFuh3hsLjf8aIj
 0FOQxbXdcsW9LHSlboMSjOjuzyKLdJ0Z1QoNLSxnVrln5MOswxaBt56WI5OSVUIl7ujS
 B1o0bkdERg7I436QQywtoYHvmASv+2AgOPbF7reKvYXQiVNYcC1VDa5/6KwZR3tqrxFh
 NmLqwv9H7KiBxQilrg1cNjIi8NnJa2rrHJbJy1S53ZWsweDY7x4jY0URhdVpvMdE8jEg
 Wx1Q==
X-Gm-Message-State: AOJu0Yz+k6MtPF4ebQAD8pIr8fJ9RLugdo296NxWy6j8bhMiyJtIrWjM
 gf0w2Kf7XgybcWXXMXmgSUDAHr5IHaUNqQrTyXDKsar8KYnCubaTuvTHVAdw1gtSjob+b4QhA2p
 SioXd
X-Gm-Gg: ASbGncsH9tUDt3DMCccluBqCvrTCQBUd58VLULAIroJ7RxT4Riytf+R3X//XNKu4T79
 oXYGgkBFUD85Wf7HDN+e99udUyoSBuZi5RCX27Ki/Kyb2/symD15E8ZqecwxngPkdU++XjqnOng
 nUIdtjI8ap/J8e4GAwGCg9BXV4JnDmHDK3pXLQBEpul9Zh+TKkhTHyUI6gTP/cNQzNZU8EMjgXh
 wj5YC3dQiWzTYIGu6yGV19n2EgqFdAWuGiuliUo3HSSke2T4ETBz9uZWdQIgoXlogGjEiPJzCp8
 jtyhjdEbBO/ku8hXQxNvg/3z9BMzbvc4mNZue2GG2cMlutu8R+J3HSplMmxWwL74To8ZQNmfSM4
 mRANzqHENeWaA3b8AWVLLfmH9gRbSxh8bQ8EAuhmPSFNJN+In08WTbLgQy2IV879pwX29IM5fcn
 B+orzVj0eKckTW8GohGAt/oZzi2wCvA/0PXea5M7rET92u
X-Google-Smtp-Source: AGHT+IEmWHz10pRBIFfJkuQ+0uU0UJ7WA2VEG1CuKlHTIZiPnS+bdu9ovmhU9FdwbH2UdJPzjkAUyA==
X-Received: by 2002:a05:6a00:1802:b0:7a2:6bd6:372e with SMTP id
 d2e1a72fcca58-7a286880c44mr3526897b3a.27.1761325883785; 
 Fri, 24 Oct 2025 10:11:23 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a27d583970sm4669776b3a.51.2025.10.24.10.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:11:23 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:05:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 10/13] net/sxe: add xstats function
Message-ID: <20251024100547.54a56ccd@phoenix>
In-Reply-To: <20250728090517.1811244-10-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-10-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 28 Jul 2025 17:05:14 +0800
liujie5@linkdatatechnology.com wrote:

> +#define SXE_XSTAT_SW_CNT  (sizeof(sxe_xstats_sw_field) / \
> +			  sizeof(sxe_xstats_sw_field[0]))
> +
> +#define SXE_XSTAT_MAC_CNT (sizeof(sxe_xstats_mac_field) / \
> +			  sizeof(sxe_xstats_mac_field[0]))
> +
> +#define SXE_XSTAT_FC_CNT (sizeof(sxe_xstats_fc_field) / \
> +			   sizeof(sxe_xstats_fc_field[0]))
> +

DPDK has RTE_DIM() macro for this
