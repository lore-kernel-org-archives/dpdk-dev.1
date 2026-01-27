Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA5AD2FED2
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 930F640F1A;
	Tue, 27 Jan 2026 19:54:50 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 1DEAC40E21
 for <dev@dpdk.org>; Tue, 27 Jan 2026 19:54:49 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so22926095e9.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 10:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769540088;
 x=1770144888; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLZlyK/gShdwrYqHyqk0/S7shuTGyPXFliuJNFy96sU=;
 b=TRV0k/6x9JED0BKzh9/bnDenoptkALJ0+H7xCxDBES93ZPnv9AxPX9LA8+PRjZBpQk
 /pgzEzeibRlnJoZxZFelkBRCiyRDBkwG8ja3d55Ib5LsCgM+HnmZt10XozevK6WnRqNk
 muUowYklfWKLKGBj464FRaWLjt2NlxzumygQRxBM8CHvvGLDM4+RAANnMGt5y+nO7QFX
 8tYgmb3FvILLZjm2T/RKV88W0lA90SeQ0suDajGuH8z+jlprlgosRyVOfINOfzevEuS3
 zvSn3NFI2mPOtlILQL6IxCTfnzHh25x1ptaENDcAUmFnYPFVbe0prmOq8wXbd9bnwf/Y
 bnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769540088; x=1770144888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fLZlyK/gShdwrYqHyqk0/S7shuTGyPXFliuJNFy96sU=;
 b=Dmo6t5b9PY4Tvb5bHWLA3B++q/FBNZoZmSx+a4DzVr9mYTaOr9cwEgEecacffTWMCu
 mkokaVzIa4MIk+ULhtk0lV9NlB6qJqARWlaRHMYxMffFpBYRgOwUT2xvKbQ72RGjQOC3
 mfe2WpEQ84o1YMVn0VM+CqcX9ej7tqHOvyA24cd/fBXRV/MBKlLVwZWGiPc9pqAep2ip
 QNrzPEkwJi7Sfv3fV+30//cHZrJULcUaHSEbvZdUnv1aZHESH7uxKZVrijPAYHayLMc7
 A+kX+tZrfYbjaB1YYW88DecpItoLT659VszOmzcmothEeBhAylLUjWOc/fVTJ7de9rTx
 QygQ==
X-Gm-Message-State: AOJu0YxXoiELM3TLZxytJ8zpRTPwvABl+i0+7j5QpcZv2FMkkxz5bLVl
 FynoBACs4yipLVNKuQeobJ+/FIxHU7BAqCmWUvfvLqDvlAB9WXZve4yOf1rOuk+eV9Wi8WAAKBP
 DdP73
X-Gm-Gg: AZuq6aIZkrHemZxUG1kwIXhpJAX3IxmnXjuDHXaEiERXawANWf3FFJSB1FdC586oNW/
 N28hz4SuTEbnndsj0wYiMAizKQrjgFffwZtVAluEbi8xVbbwYUmcJ3N79Rx+yxuMMhI2lxlfUkX
 8G2Ar2bZwUTY2PbObL5XiigcZ/oE30gXkp90dc52Sk92FdOl9q1nMAnZOz4WLUsO4fNS2d5OWg2
 PJD9EbyP0jbGFk8j64FV8kgjX3QCM5g7RcqDX9c95UlIP4RTf6I+DraPSEBgODOOQe9sOdt/DtE
 1PmZFzKvdics9OLiNLjOKA4qLmy16aX7KQPr7h5fTEqzAd91SZLaba2Sa/4nYwhIBqWVw/tZL95
 jwiKHWyf+4toH4nvy9enpMjJuiFhms7zd3w3unefCAFtmjPCJ/VWHz3RTFpAxkBKTRItdcXMFx3
 KBaaLWyMWw2KEk4n1rVa5Qthjs/phdOROfTjINENB+yXmBD5FkBnqn
X-Received: by 2002:a05:600c:4507:b0:477:9dc1:b706 with SMTP id
 5b1f17b1804b1-48069c47cabmr32543715e9.19.1769540088441; 
 Tue, 27 Jan 2026 10:54:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c40e04sm76403625e9.13.2026.01.27.10.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:54:48 -0800 (PST)
Date: Tue, 27 Jan 2026 10:54:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 2/3] net/af_packet: RX/TX rte_memcpy, bulk free,
 prefetch
Message-ID: <20260127105440.267abdec@phoenix.local>
In-Reply-To: <20260127181355.98437-3-scott.k.mitch1@gmail.com>
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260127181355.98437-3-scott.k.mitch1@gmail.com>
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

On Tue, 27 Jan 2026 10:13:54 -0800
scott.k.mitch1@gmail.com wrote:

> From: Scott Mitchell <scott.k.mitch1@gmail.com>
> 
> - Add rte_prefetch0() to prefetch next frame/mbuf while processing
>   current packet, reducing cache miss latency

Makes sense, if you really want to dive deeper there are more
unrolled loops patterns possible; there was a multi-step unrolled
loop pattern that fd.io does. The reason is that the first pre-fetch
is usually useless and doesn't help but skipping ahead farther
helps.

> - Replace memcpy() with rte_memcpy() for optimized copy operations
There is no good reason that rte_memcpy() should be faster than memcpy().
There were some cases observed with virtio but my hunch is that this is
because the two routines are making different alignment assumptions.

> - Use rte_pktmbuf_free_bulk() in TX path instead of individual
>   rte_pktmbuf_free() calls for better batch efficiency
Makes sense.

> - Add unlikely() hints for error paths (oversized packets, VLAN
>   insertion failures, sendto errors) to optimize branch prediction
Also makes sense.

> - Remove unnecessary early nb_pkts == 0 when loop handles this
>   and app may never call with 0 frames.

Yes calling with nb_pkts == 0 on tx/rx burst only needs to work
does not need short circuit.

> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
