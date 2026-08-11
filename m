Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB43C5AD7B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 03:57:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5303B402AB;
	Tue, 11 Aug 2026 05:57:57 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 32C4640272
 for <dev@dpdk.org>; Tue, 11 Aug 2026 05:57:56 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c9eefcf9175so2260286a12.3
 for <dev@dpdk.org>; Mon, 10 Aug 2026 20:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786420675;
 x=1787025475; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rQamTJdZnco4E7YZvk60oEojW0zLBQIkaAu8gOWtZag=;
 b=qjH7dQKc5SP4xqvYboC93T4fYQZrSh6ko+tEa7CJ/ITp4lH5zL5sRdYGGOqGa7GXA2
 Vx/GXmUJgZYAjyFT9Fyc6Hul3OrdzSvDNoObbqGxGmr4GeOqi1+tSy9ljOH+fOyzUsno
 //CcGP5S80a9NOHEF/jNIEAx6eRnxe3N6XuGcx0I0OXqsbKuEg5Mc25nl3yOoLKPnXZA
 eyoiCIjUfQ3IZtSRGKqEHuxtrVCA/a8HeN6ZhAK13zj6H2aXrCOhIGr/cKwjf48eJuC/
 QODk2JIgVtbKpWztGI6JcNOFql/YOAnUAy+4SyPc0vfPKAjVg6ptCXQsjx2P4J0hb25P
 bvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786420675; x=1787025475;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rQamTJdZnco4E7YZvk60oEojW0zLBQIkaAu8gOWtZag=;
 b=JxpeyRuX2m/fGLeqjsIwb6IJVMNFVyiJJz1m2+MngtVKczRxu5uAp6WaMJ+wfMxK0Y
 ONz6OfItusuOXUs7j8qtj9E+JAjCJja/kfiReK9yddfmPwwCjNILb/IZU3zDq17cV6bh
 2cVZCEC0KWHVfjIsnZAZc9iN2IlpNnph/Pnb/Ee7hQo0DYU3FzSmOSVJPAp7/ITRAk0s
 roQptSNCZV+wVyaNE/7kzWg+i7KVmyKtD+P4IyEoZZ54Df5YpJY+itdX4wVisgQzWzFv
 /iyhiI4sPd89p7n75jwpx0kL+x0b9/Cd2/i28kCnS5R+9g4thHEGPtJtPE4yhH6AmK9W
 tnGw==
X-Gm-Message-State: AOJu0YwOdbKW4XsrofMv8wPMlMBeschinb7dTY0lacBVbe+XnLJeU1Tb
 4zzJLN703mmbI1C7IzfW6rZnejFowOQGVW/RxcXV5YTWlrA5eu8CFb+LNOtCzOoeQIE=
X-Gm-Gg: AR+sD115d9o3M9l2Iyuz+gpTPSePHitgSR9pWIM3gqGq4mFdE4EB7MBa3A5YnECuGQc
 ciQ7G3FgenlmZsQc4izyx/Tsmr1Rig4RdU9azdQeuVq6SpRg0CkCmoXJ/mRQjTOfSXCrXgBmFLH
 +9NGxisEGGNH2dUkNpDDbg4bPe9R24Y5M+2grSZxNtZ7bNwsE7d90w4uSY1xfhvFDeIOMeoxu3M
 E2uSwUyU6w0KKovrbfsKqDOv/Bz+P/rGwJEsyaJTu8ztYgWHL/9lmiJk6yH0Pv84fErFMOOW73K
 mxyxZ6DYFOO649fWi5P4lig/dy31IdKepafTJFMWRIefSDbzck5UL4lH2eHLjXFYmWPpIgRA6r9
 ftpRofa3gANZecRnYAal8w1lMf14W4KVKz79oxmvBx8sgBcO4f0W7RTaBy5sFzwMiY5M53vVfls
 gcaP5LruiJPTzSxFi8DfSi6YapB4w7p5PRcWpZK3BIejJTE3Spx+MDvQ3xeC+7zdqixoqOpZAkR
 rI1v0FvqhVQi5z6F4ekxgCHtMP59Q==
X-Received: by 2002:a05:6a21:3992:b0:3c0:b4f8:bbfb with SMTP id
 adf61e73a8af0-3cc2ba30dc6mr854420637.22.1786420674950; 
 Mon, 10 Aug 2026 20:57:54 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bebde308sm49759325eec.20.2026.08.10.20.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 20:57:54 -0700 (PDT)
Date: Mon, 10 Aug 2026 20:57:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rita Ruvinsky <rita.ruvinsky@weka.io>
Cc: dev@dpdk.org, longli@microsoft.com, weh@microsoft.com, stable@dpdk.org
Subject: Re: [PATCH v2 1/2] net/mana: fix MR length truncation for chunks
 over 4GB
Message-ID: <20260810205752.185c69ab@phoenix.local>
In-Reply-To: <20260806172640.2456451-1-rita.ruvinsky@weka.io>
References: <20260806172640.2456451-1-rita.ruvinsky@weka.io>
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

On Thu,  6 Aug 2026 20:26:39 +0300
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
> Reviewed-by: Long Li <longli@microsoft.com>
> ---

Both patches are queued into net-next.
Added you to the .mailmap file.
