Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904A5D3F098
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 16:59:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BE8B40395;
	Wed, 28 Jan 2026 17:59:36 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id AC2F04026F
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:59:34 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-432755545fcso71665f8f.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 08:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769619574;
 x=1770224374; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySueKAmxEjBDtAREdEMn+NlcEDCJuGgl6s/IdjZYDAQ=;
 b=KIrWgTqa+oKhi+x0XtTF2P87RSePzYwDzywydRHE78CpotMgdG+Yp4OKMiWBVLMr5B
 fHYX/yvMu/TUMUG1envCm4GRnmbb+Gi8CtDofOOpAdcT1aWMlsnsF863/2hD837QLZ/o
 94MvVQfgiqwKx2sWS5vvHJxYVxuGdh+fOr8HHFXv4fw2LANaGYyfueNlwEp0UP60KBwE
 AbtJ4zTG78Vxv6TPAi59DR+lwGNGmfoyJHne5eM74V9IEXrssjafnooBmKmweIwuF0/O
 5oGAHgzWZrrThdy2tO5bbuxCxbYjD/cMEfEdiQTWFwnf7sKr/pqfsF0FfLvkz+s028wJ
 sKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769619574; x=1770224374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ySueKAmxEjBDtAREdEMn+NlcEDCJuGgl6s/IdjZYDAQ=;
 b=OH6v2h3aXlPxwxs2qUZNRlbbjxwsFrQY7+wXnS/8gMN4gy4tFUwoll+o7hoCL6zgZl
 i/BVmmeIyrsSl2QxaibIw20KRaqIKQVlmwNqjtz8U4gTQvZgjJpMQyMO/oW14bepk3Qz
 JnV3nMZbSkPWAPSy+XS9XwsrrlRtWgrZMe7yqywKKkQPlJf2bfvYQUsbQBXyQq5Wgj8B
 Y0wvP04CUkuV5A3645BfH7WY782gYI+3Z/7xwsDRjTVMM+ZOCCL0UGdiWiKgp5CpHuUo
 8O3rMxGmhqktKd0sMMLEpZ8ewqHUd4kmqI1W83l4VxKMY/bouVMLlUEt3bMcGrs43lo8
 5VoQ==
X-Gm-Message-State: AOJu0Yzr6onkTcfwr0OljSAYp61hALrudQbR0TjYM9tH5CUkEcRh3z9k
 F8hxbRcoTa0kkiDRd+CPM6HcsMkquqKO0u8ewbJ8wREUDp+xnCkl+RkVP17MFWfbgAE=
X-Gm-Gg: AZuq6aJ0z34lC6eh3gan8OKxBUuW7dnApLdp82L/YyUMwfFjvO/4qDFYpCzgGxAn7pj
 3jqdr3QxIFiWbL53zzAoPa/1dKzhYgr+UuoF8+Q6F6fq5PYIGhPmMOr+hAF4zvUQPVyVzYcXgjq
 goFqpEK5pBnKzBA3ECkRrQMhIwOAOAnmEVz2I8oaWsXy9wCFwYVCRnsBrpjLcl0lPQ1bY9NQi0u
 Hr47v38QdOeoWW5cOZ+MQrKbd7GAyRJNuy3fb7qXbMJGFGpbmSZUsoYwvAp0+h6euouBvnyZIHW
 fhnIE8+t1UvKVIMNaqfbLx2CabfQAiaAewj42wVDq/zDnsZ2Ds+VKDJw9itThX0rRZTEbnJgXuI
 kpEZil1eQn7nHktDEMQNKpiKZBKFOasNOPZuwhuvPW4f6MAsXebAUXzk7dN62aNWXVggm+Ea1Su
 5ENePZfKb9LagBHoPm/4jDIGc6ifZG+Mn4Be07EVc2/pQYEibqp9c6
X-Received: by 2002:a5d:64e8:0:b0:435:9d70:f299 with SMTP id
 ffacd0b85a97d-435dd071cbbmr8091222f8f.22.1769619573759; 
 Wed, 28 Jan 2026 08:59:33 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10f82aesm8664804f8f.19.2026.01.28.08.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 08:59:33 -0800 (PST)
Date: Wed, 28 Jan 2026 08:59:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, linville@tuxdriver.com, stable@dpdk.org
Subject: Re: [PATCH v2 1/4] net/af_packet: fix thread safety and frame
 calculations
Message-ID: <20260128085928.671ce473@phoenix.local>
In-Reply-To: <20260128093607.62908-2-scott.k.mitch1@gmail.com>
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260128093607.62908-1-scott.k.mitch1@gmail.com>
 <20260128093607.62908-2-scott.k.mitch1@gmail.com>
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

On Wed, 28 Jan 2026 01:36:04 -0800
scott.k.mitch1@gmail.com wrote:

> +/**
> + * Read tp_status from packet mmap ring. Matches kernel's READ_ONCE() with smp_rmb()
> + * ordering in af_packet.c __packet_get_status.
> + */
> +static inline uint32_t
> +tpacket_read_status(const volatile void *tp_status)
> +{
> +	rte_smp_rmb();
> +	return *((const volatile unaligned_uint32_t *)tp_status);
> +}

Wouldn't rte_compiler_barrier() be better choice here.
You are really only trying to keep compiler from optimzing the access.

And tp_status is aligned in ring isn't it?
