Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A548F53D6F
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 16:08:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 891514025E;
	Mon, 16 Mar 2026 17:08:50 +0100 (CET)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id A1BF0400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 17:08:49 +0100 (CET)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-128e4d0cc48so5342056c88.1
 for <dev@dpdk.org>; Mon, 16 Mar 2026 09:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773677329;
 x=1774282129; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehoekHqeFdtgJ4FZzmwxOHCgaXH2PSZB1/DWxIR8+PQ=;
 b=YTgjLxgItmOvb1HQcIbfr3Pp/0y52hhd4iXqGYi2CJ5Ja98nYk07K2hHOz1PziSAVR
 BTpzkX8U9qH2Sk/Ai8cPUpNfNriLgtKgerxbBTDY19Ov58bh7rdKqyVnfw/pQSroXUZf
 uWC47gXs9K9/YToCWMsCswQBBCANY5KXMo2QwtMldlWUqUQ+4wSCybD9S6CA4e8z4dcR
 xF7V+9yYqO+E7u6rCRFdwJbrBI3OyH02TzRaOuBnmfNq52TcomrdsHu9Pmloo4FI5pxw
 TLHDFGcKpdEkG6zDKIVeMhGEFXlqCIArWV8ZM95i4BJtWUpiB7u0GEZRXLZQIPhYXPBj
 Z0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773677329; x=1774282129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ehoekHqeFdtgJ4FZzmwxOHCgaXH2PSZB1/DWxIR8+PQ=;
 b=iPswcJoKmt3XxF5s+Mg1UOcgjwLtCHXsIwzss1aKtu8gZCq68/b3/MSlYwMt1K5GlF
 KhdY0QxrIQ+C9JZkV20cJT5g4w2aTV8v1wEWrgPVPkWxz53QYDyD0ezeUFMbuCeM/f7K
 2QsvF/INBBNvPL49TP7LKFEDBes/jUr0+gzZ7tJBaCG6w0pXIK1VCwUlvie2ypA3rWNS
 zO85SK4H/zLmlfagK8ozRlhTZPyeT5b++kZHqsUUznhkaAp1bC2P7e8j9KfIIfOejtr2
 BalaWdlebXObiYWQ9H+LFe96/30nBeJaCXVGu/IQBuUQfXgp8qW5DUMR++yzkG2QzA1K
 p/5g==
X-Gm-Message-State: AOJu0Ywn/lO8k7WPIhQvRABeAjzFDNWnjR+0MoFZffyAYLiGlkt9OsXs
 YyqT7eK1qCfCx98XjDJWzaDxMiJGLZKJgSPV6/QG5pezMvOozP4PTBsNrxaeFQAkXZE=
X-Gm-Gg: ATEYQzzvyCzPgO8NwUISFQLZD7i632glTo0TruprLBS3v87Lb0T7ET633mn+mkBWlzB
 GdoUte+sCD54RJgk1CqJpcCoDUM7xKufcPPGpWIYdtY//cGC/U3I2RwaSly6+gWEirVRbeJx1rc
 gpD1Ugr1Q+jB5ZqWcuBjtglMx5a6BFuU0LuW1YkKsCTHQQyskBCefltWWvPPmTDEt5WOuRYKhhr
 kLLTVYPZ+ZX+RevrXO7UBrY23UWU0GyyDZe6Nu9x8yaK931mUJ7mEpdV7wfQ1qJpNDxifrI1G2M
 TezVJa/N2fK7+YSw8Lc7ObnEkybTikdyxwtAy9iZEDgG30p7dPo9jUmdO5dqaN7cCCKJkTJqkb4
 d00k56wG9jxVMTRad74yZVlGVGqjUMRTsTSvGFusKLlajNlPqc7B82OrrRHlXPNS5GRiWvaNO2M
 EO+wjUa6JfirYJVspJY8eWaWKDHxRaKIhxqoM=
X-Received: by 2002:a05:7022:1a84:b0:127:3214:c862 with SMTP id
 a92af1059eb24-128f3e5662amr6154641c88.40.1773677328452; 
 Mon, 16 Mar 2026 09:08:48 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128f639d1e4sm12065300c88.13.2026.03.16.09.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 09:08:48 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:08:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, <jgrajcia@cisco.com>, <ferruh.yigit@amd.com>,
 <stable@dpdk.org>, <mattias.ronnblom@ericsson.com>,
 <heng.wang@ericsson.com>, <ravi.kumar.chennaparapu@ericsson.com>
Subject: Re: [PATCH] net/memif: fix descriptor flags corruption in
 multi-segment TX
Message-ID: <20260316090845.158843db@phoenix.local>
In-Reply-To: <20260303110152.276344-1-sriram.yagnaraman@ericsson.com>
References: <20260303110152.276344-1-sriram.yagnaraman@ericsson.com>
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

On Tue, 3 Mar 2026 12:01:52 +0100
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> The memif TX path was using |= to set descriptor flags, which could
> leave stale flag bits from previous ring iterations. This caused
> descriptor corruption when the ring wrapped around, leading to
> malformed packet chains and RX failures.
> 
> Initialize d0->flags to 0 before setting MEMIF_DESC_FLAG_NEXT to
> ensure clean descriptor state on each transmission.
> 
> Fixes: 43b815d88188 ("net/memif: support zero-copy slave")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>

Looks good, the AI review spotted one thing.

Error: Asymmetric mbuf cleanup between the two Rx paths on truncation

In the first Rx path (fast path, around line 376), the truncation
handler frees mbuf_head and also frees the remaining pre-allocated
mbufs with rte_pktmbuf_free_bulk(mbufs + rx_pkts, MAX_PKT_BURST -
rx_pkts). 

In the second Rx path (slow path, around line 469), the
truncation handler frees mbuf_head but does NOT free the remaining
pre-allocated mbufs. If the slow path also pre-allocates mbufs into the
mbufs[] array, this is a resource leak. If the slow path does not
pre-allocate (i.e., allocates one mbuf at a time), then the asymmetry
is correct but should be verified against the full source. Without
seeing the full function, I cannot be 100% certain which case applies.
The existing mbuf == NULL failure path in the fast path (visible in the
context at line 163) also does the rte_pktmbuf_free_bulk cleanup, which
suggests the slow path may handle mbufs differently. Worth confirming
that the slow path does not leak pre-allocated mbufs on this new error
path.
