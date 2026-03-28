Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FE610D1489
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Mar 2026 23:53:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8642402DB;
	Sun, 29 Mar 2026 00:53:41 +0100 (CET)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 51C2E4021F
 for <dev@dpdk.org>; Sun, 29 Mar 2026 00:53:40 +0100 (CET)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-829a9d08644so1736139b3a.1
 for <dev@dpdk.org>; Sat, 28 Mar 2026 16:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774742019;
 x=1775346819; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NF9fdYeyKglANgNU6cRO5TKr75T8m0T09evP9w54MM=;
 b=zn8X/bVWL9vuYij97/bLelvwIz0qFlVbYUQm7n8WhjuydiVfVxxlcrYCIo19kK0tc/
 awbBvSzVUgHXfxYG3pCX2CgbZSVABFfRUlGBZFo6booqxOV6YGC+/JXIdOmuRV1znVaS
 VkE1nqIFyTUu47sgqbqnREwk7L0jCLBiGlKEdLe1h7SMBcN8s9jADxenK3GHQouytGBu
 KgYU8B3KbDq7oNtUTAMaTZgSCYzYBXFS1c/sBLM6Q95x6bKSksJjbiai86FXx0wGNUhm
 8IVJjxMsBgenI6LxX0tVi5wnmPQjvMS6aSI1kmDs4s7IqJdThA2KQtOg7q7IGtLvWnQz
 XUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774742019; x=1775346819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0NF9fdYeyKglANgNU6cRO5TKr75T8m0T09evP9w54MM=;
 b=dQ3mxeeWXsKkBlG6PaxHGLWOowAN69SNSydL8dYlixASX4y7PkUnveSIpbTgePUQO7
 zS+G2uwMtSNKPNDBfZao23nf2TAHPGXTj8YECFsHoOoW4cQKxZq8KOMwbU21bdGCyQQg
 WVV5lYHetUsjCYX9tbgk9nnb3vNdYzAT9Z0TOBqHUe0/lWeEZE2W5as2gp2n9do80jHG
 SFwhkQXaXikOiys2lXSf/Sd/1zUVaovsOnJ4gMcXRXjFN4AS6IQcwxB9Xq/yGas8zMB/
 o09DUYKfv0BCEtC5WNCHQBT7KZtQJovg/y64eOyHtGlPHFswB21+9epPXFvWx1jQmhVe
 f8MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHqCQAr7kQoeUcNOKNfrb11ye3s5kw4OgN7qQUZ2pq3UubBOK1kINCD4v7jz7qh44uClU=@dpdk.org
X-Gm-Message-State: AOJu0Yw9eo3c26+Vaoang3/DXdQbTqG2zOeEqPSImg0AR9c2CThT7j72
 kR9uQ8zPFO5tyWpbY4oOaOSQlorpWs2CbPCD6IZbm+jfgGorN7gAVONNmdqhAZhWZIw=
X-Gm-Gg: ATEYQzxSo6r5ADDgs6xT0wut9TGrOfM52BmmcNbNpg4sM4cUtNiwedfG8Ug3U6igq/M
 7B/Ude2Ao0KyaNe8hniNNO532MoKywvflMwEsntiQwQqqrfG8h2yxNiWMwqBdLxxnh6ezAfBjRC
 LF1qlYvduVNaafMHJYLqvepDIdUv1/w99OPKnPehqKSOd1o/JzKLyL8CKqmvMfgQXnlw+Bz1XmS
 XlDdlYYxBqtzawmoBRBdWjS+wsEXXxgvuwh1iRv9stWs3Ynd/JnUC1546EKWInWPdA8GOKRlDWY
 y/RmdIDgWmsgkEhWDIQPABivtkujFOxKBIWdoZ4yh2vA9QKVXw/KzDZuQNm+DfN/WNvTJQSNkrE
 XcmOJdnJIZNpZz+1Zlo083ua3+1vdGN8Ti51ePRIdhxGNPnxXTRkiFVwCFCINKFXolC11SwuXmJ
 Ai8CtCP3ZsRz00lzcg0zZLSViPQtXDNb9/Z+U=
X-Received: by 2002:a05:6a20:6a23:b0:398:7853:70ea with SMTP id
 adf61e73a8af0-39c878393edmr8007394637.15.1774742019169; 
 Sat, 28 Mar 2026 16:53:39 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c769179e31asm2538072a12.17.2026.03.28.16.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 16:53:38 -0700 (PDT)
Date: Sat, 28 Mar 2026 16:53:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: madhukar.mythri@gmail.com
Cc: longli@microsoft.com, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2] net/netvsc: fix race condition in RNDIS command
 execution
Message-ID: <20260328165331.571e1d85@phoenix.local>
In-Reply-To: <20260113101820.60611-1-madhukar.mythri@gmail.com>
References: <20260113101820.60611-1-madhukar.mythri@gmail.com>
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

On Tue, 13 Jan 2026 15:48:20 +0530
madhukar.mythri@gmail.com wrote:

> From: Madhuker Mythri <madhukar.mythri@gmail.com>
> 
> When multiple threads issue RNDIS command requests (such as device
> info queries and link status checks) simultaneously, command failures
> can occur due to concurrent access to shared resources in the RNDIS
> execution path.
> 
> Add a spinlock to serialize RNDIS command execution and prevent
> data corruption.
> 
> Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Madhuker Mythri <madhukar.mythri@gmail.com>
> ---

As Long (and AI review) observed this patch needs more work.
There are two issues:

1. The introduced spin lock only protects query, it does not protect
around cases where a query races with some thing else calling rndis_set.
Lock should go inside hn_rndis_execute().

2. The lock is held while spinning, and it could take several
seconds to complete, holding spinlock that long burns CPU and any
other thread trying to do operation would queue up and block.

Maybe a pthread_mutex (which sleeps) or use trylock in the
query path and return EBUSY?
