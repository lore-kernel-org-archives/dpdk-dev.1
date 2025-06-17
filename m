Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D63C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 13:27:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81DD740E54;
	Tue, 17 Jun 2025 15:27:23 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 5C92E40E3E
 for <dev@dpdk.org>; Tue, 17 Jun 2025 15:27:22 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4a43972dcd7so73119181cf.3
 for <dev@dpdk.org>; Tue, 17 Jun 2025 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750166842;
 x=1750771642; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wx7f1+LYwhRvqvQWTdYX3yoBd714+JgJ4bJLrKSWKL8=;
 b=Cw0J8pl1e45tBWXuOHDe5V6tXW20TKVe69u7N30v/x4tlq/cxQ9Av2hX5pZMbLFJWC
 lGSxQWGGTM/K7yMLf2+6pUHT57yyF0qtG3UDCLA5mVx70aaiGcr20LlUB3aBInSovtOv
 3uYD7X4I+rUKjrDQLdmPc14j0HQFy+pGMS8Dw/GiOrARc7c8krVQzOcBSVKOgZwfhZ2i
 q9s4YUUFkuMJTYCETEfZMKRdWWGrwSxuLY9Np6vmF3KhiAfASERUOYmdSFGym/yIZ/j7
 722rwpdUDEtmfUiW8ZBd9H7uNZhhfm5/cJHkXU80NS/jzneiKwqaT1CjHVqZV3C3H978
 9kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750166842; x=1750771642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wx7f1+LYwhRvqvQWTdYX3yoBd714+JgJ4bJLrKSWKL8=;
 b=t/s7QEpUq1/rBD90KDrlvmT4gasuu4tFjY2TIuBtYyeb/FBSAqJrQzon5ujfDAjBEC
 ZFt38sTzT/uiVCAt1jmMMbrax5SL3oHk6oSvF2adXBPGLiCBltwIKIenj8e9AeMzoQyT
 c1qc2etRUp+bucLfNshp+O/V7FXIqX96o80Sp259qhTqM3z5pQjf3IDEzSO8SRimqWXT
 WZGFvIwq6p12A8XoZi3VugAYGDoKjV+RUJ6ahxNF1WzZnkpj77NB0QviUca1VQoBCK/y
 CfwkggzFqr5v+bLDOwCLp46OuD/iMsX5JhOlooZVu0ExPH70iHC6qMrjz3nguX3DsA4R
 usiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx4bAoG9RYFFZ+fyyXxL+QHW1mjB/xEDAKG3AF/rp8Df9CfiuS7hldCkBc2doDVfPfl00=@dpdk.org
X-Gm-Message-State: AOJu0YzPFU1yQ3ex60FvI4+12uBuBkpGwqXeWvp/qy57uax4nNkPYfw9
 w/UAKhjHLZh0WfIBUkDoLZwjfnNSu+GJ4T8bgKPxX/ZU2xmiRHu6Gca5rc8aX0Nkog8=
X-Gm-Gg: ASbGncuhZAkz7oHDSlpH23J5NYSKrQU6L26d1lxrSob4iMzptEPY0WxfOpLn/NRbQSX
 K6Ar4KR+xFzN0UW4cXNWfIQ+Z9L143E4HJL4smZo3wwNihqpWLmv45+54ywQ7xFMvWvwXql19LA
 sJwdRNzuVSqXoIU4fFi1v0/EkKaZwg8KQ3RSK+k41ZcCmBX16jZIvnKUL8m+WNQrQKZf3eY639l
 RIfWFJHdkxYCVu1YluGHbDlW0N1gwP72KYUsIbm9dLSWfZ0XjZNGsavAGVTZVvE5ZLDH0n3Xeoe
 7UQCSetqc6Cw5iHQkZsTc5igWtwapDKc9SU0ca/YHjQQA0KfRZEpQR3iKL4GwfWxTv+W+0LeefT
 apZdwOh9vdjtkpWal7nu+mLewD2gKBvpatEUhGUU=
X-Google-Smtp-Source: AGHT+IF2XFtcWh1pmoPoXWw/JTNI6g01Qic+E9VBVU456Yc8VKbcOI6W3NH08nS4kU1SZuBvdisbpA==
X-Received: by 2002:a05:622a:56:b0:4a3:d015:38be with SMTP id
 d75a77b69052e-4a73c5faf59mr195412621cf.25.1750166841623; 
 Tue, 17 Jun 2025 06:27:21 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a2be9cfsm60700811cf.5.2025.06.17.06.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 06:27:21 -0700 (PDT)
Date: Tue, 17 Jun 2025 06:27:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, <dev@dpdk.org>
Subject: Re: [PATCH 2/2] lib/graph: rte_malloc for cache-aligned structs
Message-ID: <20250617062716.17e6b86e@hermes.local>
In-Reply-To: <20250617105209.50526-2-marat.khalili@huawei.com>
References: <20250617105209.50526-1-marat.khalili@huawei.com>
 <20250617105209.50526-2-marat.khalili@huawei.com>
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

On Tue, 17 Jun 2025 11:52:08 +0100
Marat Khalili <marat.khalili@huawei.com> wrote:

> This was flagged by undefined behaviour sanitizer: struct
> rte_graph_cluster_stats is declared as `__rte_cache_aligned` but was
> allocated using stdlib realloc which caused misaligned allocation. More
> than one test needs to be executed in series in order to reproduce the
> problem using graph_autotest, e.g:
> 
>     app/dpdk-test --no-huge --no-pci -m128 graph_autotest graph_autotest
> 
> First sanitizer message  (similar ones follow):
> 
>     lib/graph/graph_stats.c:209:13: runtime error: member access within
>     misaligned address 0x606000008ea0 for type 'struct
>     rte_graph_cluster_stats', which requires 64 byte alignment
> 
> To fix the issue replace realloc calls with rte_malloc and rte_realloc
> specifying correct alignment, use rte_free to free the result.
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>

There is a way to get aligned memory,

       #include <stdlib.h>

       int posix_memalign(void **memptr, size_t alignment, size_t size);
       void *aligned_alloc(size_t alignment, size_t size);
  
