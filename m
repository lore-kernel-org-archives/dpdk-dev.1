Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89D4C87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 14:27:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B98C440657;
	Wed, 13 Aug 2025 16:27:45 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 3520E40265
 for <dev@dpdk.org>; Wed, 13 Aug 2025 16:27:44 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-3b8de193b60so3804579f8f.0
 for <dev@dpdk.org>; Wed, 13 Aug 2025 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755095264;
 x=1755700064; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+AIfYiIz3tDRGmZrQrK/JLrohOwh9ewd/ZRK73ChlQ=;
 b=fuTetyW76/3JkY+k41I+AMn+9WY7rPtR3ptQc1k9FmzbctyiXq32Be6acFiewp9ueb
 dQk3YVfo3Pu/fSOMOkwbOJ80TlzGcSp2WQE2gKLy0PCheC3XDXS2tpqoqJxlB+GKmviX
 dIa210dncft+6dQqz2eBMRp90KgGmqx6xxHaXq4NgKFlEgtMK7U+glwkv1vBlspmYL9m
 9Z4UhmF52S/csrg9Eb7TyGTBL4P/QGP3WQdFirkfm6AV3aqLhy8/RNIqGCgPQvrX1AKd
 yPpUTDR5s8/PXQowjXStM6eBCpV8ZRnsl9XaB9hBNhAN0nG+drYlr0VkGX6ldCcWCot1
 XYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755095264; x=1755700064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+AIfYiIz3tDRGmZrQrK/JLrohOwh9ewd/ZRK73ChlQ=;
 b=PbmTQLF7tN/MkB4xrEOSk4Uwujm5MNhD0T7M+VCcu/zCu3a6553VDOi74NOv6IRZnp
 iCt/N+hu2qhtm9D/02Ss5xnTbLpJpATz/ByHTtSpgRYac9YFCEHxdlnaFoHXbXQzYV8e
 cwbUY3Mw07DkSm5M+5GewPI0HyMoN6t0gBY0UUQvAAKAfiqsA9VS6HKqYB4pGNw4BPkZ
 6pdvkmHmV5xZracpMr5pxkiMLUqrQzOsc6HbycbENFudPbawUhtQjCmj6Ou7F9dd5gBs
 xZBtpjPu85H4fLJ3evziUgB3JYzWnRQWD+O3gL8XSIfL0UeQE3E3V2WiOdP+W82dXPO/
 anqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXONPluEMBi6LSfcjcEUzQVCVGVsLWHjeyM2FUWPYR87s9wuUY8Jsfq7NWSvJ+AtL2b9a0=@dpdk.org
X-Gm-Message-State: AOJu0YxCBVtfiZOz3jM4Ka38UwmqG6pOeY2M07TaMDbSxHVNskCztZ1Y
 gqIyaFG7rRvz9qP2PAhg4LsbQ2BNByQUf2PZTwqdrpY6QETCPpObJapCzNCGAohWRa0=
X-Gm-Gg: ASbGncvlmHVnnPE5Ud3OztnCZMXK9ccdSw0Ny5gBvzwe9k+aZzEGdwpHbde6kvNwO71
 oW/gnyyosFvTc0A+ZPl8+UvN+hRBINzMqBCiYmM55DjWz1/Hu83H5exHv6AywZpShJREs5Lhyh9
 3An5PtT2kUoVecNzhTT9cfd7c5Kv7f9PtgYPRJX2vUtiHDpLmwlEm21gjCn+VYllCfmKF49uiO7
 TzbLFNrwtp+2i90IEsKpcZOWYtNa0pJUWjLTx0CslA6nQIwlVmXE4IoxLUJDphIyHznf7459sD2
 qhxmqffrXv8rXFxwt2zSsbqTbAkIsVklRFTzWLtSknRHcMNtk+yLwIbHp9e5Qe0HVQETS9SylVS
 EZoT6AV51X82Xr/P71qnNjnbWOyJa4DccAja2Cqzg3jRBeYgJZUf+BvV+YUnhhm1XIccmkt88yw
 Q=
X-Google-Smtp-Source: AGHT+IGZp0KVy9IJkRF6q78C60BjvlKVgLSDpAwya+CmK2wC+eYA0r6JIZGtM9GdA2+VvzXEuS+MYQ==
X-Received: by 2002:a05:6000:178e:b0:3b7:9457:e16 with SMTP id
 ffacd0b85a97d-3b917d2df79mr2348401f8f.1.1755095263606; 
 Wed, 13 Aug 2025 07:27:43 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c48de68sm48226901f8f.67.2025.08.13.07.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 07:27:43 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:27:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, dev@dpdk.org, Kyo Liu
 <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen
 <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v4 15/16] net/nbl: add nbl device xstats and stats
Message-ID: <20250813072739.6b7f5c60@hermes.local>
In-Reply-To: <6a088ad9-2d80-88a0-81e8-d6fec073c0c8@arknetworks.am>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-16-dimon.zhao@nebula-matrix.com>
 <6a088ad9-2d80-88a0-81e8-d6fec073c0c8@arknetworks.am>
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

On Wed, 13 Aug 2025 15:48:29 +0400 (+04)
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> > +static int nbl_dev_update_hw_xstats(struct nbl_dev_mgt *dev_mgt, struct rte_eth_xstat *xstats,
> > +				    u16 hw_xstats_cnt, u16 *xstats_cnt)
> > +{
> > +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> > +	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
> > +	u64 *hw_stats;
> > +	int i;
> > +	u16 count = *xstats_cnt;
> > +
> > +	hw_stats = rte_zmalloc("nbl_xstats_cnt", hw_xstats_cnt * sizeof(u64), 0);  
> 
> Do you believe it's the best course of action, to allocate and free a bounce
> buffer on each invocation? This function is not strictly fast-path, but I'd say
> semi-fast. Some applications may want to invoke it pretty often.

Unless the buffer is shared with another process, better to use regular malloc
or alloca for this. Using rte_malloc() is slower, and requires use of huge pages
when not needed.
