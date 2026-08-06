Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C56C56205
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:02:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C0944027E;
	Thu,  6 Aug 2026 19:02:41 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id EE8AC40262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:02:39 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso2477692a91.3
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786035759;
 x=1786640559; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L2AtGi2bCxhr9XqnGoLdgUOsJxvbVq8CYL2v/cyW5Zs=;
 b=cdTeTD3XTiisVv8dKIeBOqFhSyjQ6bLiSPqd0v08Dbdkw1d7NTn4uKKNTDhFW9oBZU
 xwx7Sstk8l8lOfM3K5X7E/rdlChoKMnFH96yBkbOr3yLtgTiffcWaTw9uD1o2d+15oK9
 7XrMb7kPUR3OcKKBHRfRX7WfJo+Y7sJbukeSdRgRfuV4VyWEpq5RzerDoq0Ji5onsZoe
 81lv4n1U0jWk9isb/21OjrzFp/H1lCY9uxVL1J5Q3y/7R7lQHByx9ahSTZEeDQm5ilAP
 VpJcLyfy/8Jt2dbKYj1COujM/dtMKvhBUVKXGYVy0tJ+l/lHLKFzoA2HhQ43936b9+NO
 RJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786035759; x=1786640559;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L2AtGi2bCxhr9XqnGoLdgUOsJxvbVq8CYL2v/cyW5Zs=;
 b=ckiriffmBAsgkDP7i9FTfaRgkWNhUIBPKvaUIEY+YsULVEKQNwFQNEah6hhheLF3Gs
 dSL99YF8w+qVUPcnjGPynHNCUIucAgnNB9/JFianHlt6XVGNZqzYKiUhRI/8/YuUJ/yb
 D/Mgqmdj/O89+L5HiyZnD4TcVspEZ9QxIX/s3QIZQvzR538j734kG9yZXyQS2jlDSVhw
 jjN0ieTSxnIpjjNCfKLjIzvtJLNuDg4+WxluZbnW0VDuJwhMyR5hYdrVI8uIAGSqEUv2
 gRs7VELj7iadkuwZe7rfhtJsdhGbeigAmmh9N3IMYaa/qZWKRDrd4eNP6jeLiUZTS6x7
 maug==
X-Gm-Message-State: AOJu0YzETM/M7Lprnz8vmGREtc4uajF2PGQl4yOkwIzVISxjUZEXLI9P
 mGrJN/5gFzTn3LWs8hu/WgRfVZGxNo5JXoiqqFWicaUhlwMJ38qeErnh/vbUJD5REDY=
X-Gm-Gg: AR+sD10uWsOyQsjxNmay47awUbHSu1cpkTnIc6YyVrqGCrnhq8Do1HGk4+6g0xRaIO9
 5lHKPH2yRkrvqnL6rZg+FDlDBrH0ulqyjGc1mqd8X9BIcHJc+rnJ6ZNieINnvPq7rPqPLccO9YA
 VWDMdYkXgcThD8s/8QMAMr0C7e1l2wbePtL5d22p3UWgG60BL2QvB0bxWPnzU3g/i9Ygw1WsD8T
 xD9G1FhKRkcxttdBNJAZvI4V8Ch4wxuYYp4PCuR7xnQchkCt2B8atBeFEAklMdQYsIBXuoZIrWs
 7f+VMgGV/J5r0RSXRaR+Ev90IJjaX8y8FhcjE9T+Jc3fEsrXXDyALWDtwcH5Ru4ymPqLUrzCnPR
 TXuaTk9+YwhPKv75vcyHI/voGkk86+AMMktv3890sC39ONzNS+5D2BXzcoUBQnMbwtwSiMgXdvK
 ZaLsNPz3qXpag5Im0SYcNY7rU/qyfwt0FEB0asu0Ph+0FaExEmrfstEOYgecNTJpjny4t6hDEUL
 5XI6HoCpaCk+ZCJUCmfCDoRijSYMA==
X-Received: by 2002:a17:90b:2245:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-3903c542a40mr13320681a91.2.1786035758889; 
 Thu, 06 Aug 2026 10:02:38 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315867bc341sm46145462eec.27.2026.08.06.10.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:02:38 -0700 (PDT)
Date: Thu, 6 Aug 2026 10:02:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rita Ruvinsky <rita.ruvinsky@weka.io>
Cc: dev@dpdk.org, longli@microsoft.com, weh@microsoft.com, stable@dpdk.org
Subject: Re: [PATCH 1/2] net/mana: fix MR length truncation for chunks over 4GB
Message-ID: <20260806100235.63041357@phoenix.local>
In-Reply-To: <20260805154407.1965063-1-rita.ruvinsky@weka.io>
References: <20260805154407.1965063-1-rita.ruvinsky@weka.io>
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

On Wed,  5 Aug 2026 18:44:06 +0300
Rita Ruvinsky <rita.ruvinsky@weka.io> wrote:

> mana_range.len is a uint32_t, so a mempool chunk of 4GB or more
> truncates modulo 2^32 -- exactly 4GB becomes 0, 15GB becomes 3GB.
> 
> The guard against priv->max_mr_size cannot catch this because it
> compares the already-truncated value, and the device advertises
> max_mr_size as UINT64_MAX. ibv_reg_mr() then fails with EINVAL on a
> zero length, or silently registers a region far shorter than the pool,
> so lookups for buffers past that boundary never find an MR and no Rx
> WQE can be posted.
> 
> Widen the length to uint64_t through the MR path, including the
> multi-process request that forwards it to the primary process.
> 
> Fixes: 0f5db3c68ba7 ("net/mana: implement memory registration")
> Cc: stable@dpdk.org
> Signed-off-by: Rita Ruvinsky <rita.ruvinsky@weka.io>
> ---

This patch series will not build on main branch.
It has merge conflicts with recent device reset code.
