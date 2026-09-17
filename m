Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB89C982CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 00:30:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52AE7400D5;
	Thu, 17 Sep 2026 02:30:38 +0200 (CEST)
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by mails.dpdk.org (Postfix) with ESMTP id BD5604003C
 for <dev@dpdk.org>; Thu, 17 Sep 2026 02:30:36 +0200 (CEST)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-398cb5615deso253069a91.3
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789605036;
 x=1790209836; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8N0EHDwoP3HJXLYI891LMbJFcjZ+nZtT8iPSp0peUjs=;
 b=C3kXALguaGUwB9bQ1x5MWkITB6L3D9Fzb9jnWqkZGLewMKEJRbr37fuOz+emaI58hA
 XLEchOoodWtdEQAR/w/KgJpb0pxdC+n2MYaFlDIISxoQZvZael9R7QFMZcHLU1F3ToeO
 qlGDq6MSsqge/T+INNupIiX+PV+0Cpxc9wnFtmnMKTAdh4p56I3p16vh5UxPET4PO/U/
 BQttiaFarA/IcDlEG6jCiey9J8z3afWf7myDgddFHD/OA2huK9PEDz/qVSs/YkAieG7l
 4XWqLlq6JMEDj6vMzDWL3HIAiI8hwtaRHD76bV/xQwyf3KLRPJmDZDTK/acWEaX2s9Mn
 5CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789605036; x=1790209836;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8N0EHDwoP3HJXLYI891LMbJFcjZ+nZtT8iPSp0peUjs=;
 b=O6XPQPlmqpKiUAZY3B2JdBYk5K4UJ/BnAw05ReeUA31vdIZt+4BUeVmHZHAPPTS1Re
 5wMHbH3NYZ1sCSBlO3JYuOI1qaNYc7rtBqqr6lELzAtTXOWVaFf7MZ+N3F20rbK+5yyf
 s2esNPf+a5hAmyZ8+m1H+qzCn4eorCbLmKxSvS1dwoukfAd0JjL5AQpcHeda8JXVyW6b
 bCFPBbKKbyYllkB0EmaUh3wh6lbibOBAhko0XzzSepXmO0DE30tWEajVDHsoSRSGrChl
 57Sl3LYdPyN20QLWiGn3aIuLAlXO9a3rKu5pyZlbUYsa9M6tDpjFZlBVk9lrrDfKCcd0
 /cZg==
X-Gm-Message-State: AFuF++mCYq+P7EV2PBqEIp8fFfexnsJ0YsAXLtyNYhg3xuBvUns787S6
 KUT0399PaV68Y2OiC5LhpQayoyEeFoUnTcKSxC0I6p9DJxUS+hn3Z1dw3nS8lMFJvk4=
X-Gm-Gg: AYBFou34Qvi2vPanV+wzzF2PqViXfAztc5s1Qj/743Bat9+HNrHohbuSCAKKyn2v1Yn
 yawRznGSyTijLqkPTNxjxic7O/kpzqn/gAvH4Ixgoe8g7v2+8+KaLpt/mghSKoB1Wrz7+wdnZgV
 LMEK9m93VX5DweqaAi2H8B8KAKKDu4Huqt9Ys1xiLv+jcZ4BiTh8o4ZLcj+SRuvkujKGY59heS6
 Ti334WIZq0F7QtqNj27DQOrAE3xOuQy2sax9wRpBqkPdtPF10Jn7qH/tZ+UkZeGe+NgWGp6VWzY
 VWwM337/A7zKY8NDQtGUpITwI+v2ntvA/u34WvMwUhYHD6cgrq1m3tymG+yLvnyZhqdB0Zcx2AA
 f8ORutqfMoolQtQaIQlUdrxF3nPioxR7+4SghFxQbKBe08rLhP45plX+0Cc0+PWkXiBUsoQKLHn
 xyPnftu93KdLjARo6nddXubTzvA3Q3Czuazj5ZA7TD6SwvxGDgUQ9FpRM+FBEUla+rtq6QKJC67
 p2y6RDiybVE2zY9I4ZXIhoXrzS+Vxu9pYg6zlu4
X-Received: by 2002:a17:90b:254a:b0:39b:ac66:bbc with SMTP id
 98e67ed59e1d1-39e1e2ee271mr10673619a91.7.1789605035712; 
 Wed, 16 Sep 2026 17:30:35 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e360a6c8asm1953126a91.13.2026.09.16.17.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 17:30:35 -0700 (PDT)
Date: Wed, 16 Sep 2026 17:30:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 03/19] net/intel/common: add utility functions
Message-ID: <20260916173029.462e7fc2@phoenix.local>
In-Reply-To: <6f960051c1dbc0c9361ceec0d7a060398131f559.1789560945.git.anatoly.burakov@intel.com>
References: <cover.1789560943.git.anatoly.burakov@intel.com>
 <6f960051c1dbc0c9361ceec0d7a060398131f559.1789560945.git.anatoly.burakov@intel.com>
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

On Wed, 16 Sep 2026 13:18:09 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> +/*
> + * Simplistic reference counter. Not thread-safe, not atomic.
> + */
> +struct ci_refcount {
> +	uint32_t count;
> +};
> +
> +/**
> + * Take a reference. Returns true if this is the first reference.
> + *
> + * @param ref
> + *   Reference count to acquire.
> + * @return
> + *   true if this is the first reference, false otherwise.
> + */
> +static inline bool
> +ci_refcount_acquire(struct ci_refcount *ref)
> +{
> +#ifdef CI_DEBUG
> +	if (ref->count == UINT32_MAX)
> +		rte_panic("ci_refcount overflow\n");
> +#endif
> +	return ref->count++ == 0;
> +}
> +

Would it help if EAL has a generic refcount?
I would make the refcount overflow/underflow still fatal, should never happen.
