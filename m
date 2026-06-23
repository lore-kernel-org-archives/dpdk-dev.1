Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63787CDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 13:53:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6935E4065C;
	Tue, 23 Jun 2026 15:53:45 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id AFF4C402D5
 for <dev@dpdk.org>; Tue, 23 Jun 2026 15:53:44 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-30bbe98c3f0so10942145eec.0
 for <dev@dpdk.org>; Tue, 23 Jun 2026 06:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782222824;
 x=1782827624; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqJ/yPjUjwYhLBLkjBKxyByAbo0Ojy+7WTfihAzO5d0=;
 b=mLFYFdufRLJvYS0XZ+MldRXXvOiwCaF5iXbvlkr7adM8DsQeJawYlvKU0CXMjW56ym
 F+AA/N5P8Lhi5RyJi5kApLh31oOZ0UUD7F/7wJWA6FL0hpYz7zOFbm5jLGy1/S1SNSrd
 GI9IReT0ITEK6HaWZ3UoC6X4zKsjUCcZoavIvUF+eUBctpcLW/DdDctdIDnqL/7biL3r
 PxeXPE7tdlZRqlO4g2MAiQ2qkLHD+6uPPr074m/nDew594mgXV3+1MADwEGo1mgcPRsv
 lHfo8rBuYOX+ELMBTIjpjgb3A+Ooby30xBQpKCysQVd/9DMkOjSUD/hsqc2NeGbZUkuH
 w/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782222824; x=1782827624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mqJ/yPjUjwYhLBLkjBKxyByAbo0Ojy+7WTfihAzO5d0=;
 b=Nnva/7teH2tiPad518RKhu8Bj9cg85VtC33tHDI83OSZQMebw4o7vmi9M5DDqMj+Gt
 zzOZs+OR/kpAgPFldulVeVPRGrlBjF4FSgWm6sd0OHWoyVA5Nhspv6HdFK0OIOcQTBO/
 fnK6opRoxXV3HugaR1RL/lYe3h8AEmNCFmlBHu76G0chNEvfSZQTMhmU8V+aYZleDsgq
 D2NJXr8NRrTgk+CMBZAA4d9TMkw7PWQZVJO+siI3VVarLRnODzzeqlaDyIm2tsYsk8Ft
 s32jilZOub6/xrKiXMPC3qMLUanENU8yYa+2cfuVJEhduku5ea2okKuO0Ibbn9MlyUW3
 2VLg==
X-Gm-Message-State: AOJu0YxRav9hpFDz8HCW2lmmUJ7AOTvnUry6odpB0/mCVoXTaxK8oysd
 uedTIDOoysoKm1ylqi4/f/Q5KibJDmYxJUiAdlC4ynklzS15hUP6+shVFWduriZeVGU=
X-Gm-Gg: AfdE7clIVpfibZBA/iJF5zLM6NJh6obKoGAnMXdwHAcV43mQYbVWWlEoz3gZo6tmwYN
 UC8GBepp3Tn1XnbLXYw0YTXSLlDEmzuFkMtyQlOy0SDwK1CebRoEhN0rNOEG8bLj3Je+jJ20xJN
 cxU1aevtv/7ZquBIvtdQpj2B8u0kJbbteHKSKJQ733NB6TCmHRi9Khxq88Uq00R693h2R36LEXG
 6GZ43hl+HF468zyF0P34JCi0XKJM9LB+wXcyi+GU0z7u32Ze4Jl2xeI2wtUcs0EgGH4hLSjB2fi
 7eWnHMWIlbH47BL/wVIm7g3u9ekKvLkbGaDcHfcOrGCULyNPx94+TCW4z1KOGLmOgO+JJK+nhOF
 uRZqhoEyobXWzBEhi/gWs6v8rkLcs+XcsQWhojY8k3327LZ+C1+7jL5AwZO23gY6Wmo1VwY0rqf
 KyAvZSQB+ws+nQ5ZQ8hf75LZaYk8CVgC7rBmkcW9hTTvnYzdoOEDpclLhg4FIExNHI
X-Received: by 2002:a05:7300:cb82:b0:30a:e531:3141 with SMTP id
 5a478bee46e88-30c58b5e612mr2523139eec.17.1782222823544; 
 Tue, 23 Jun 2026 06:53:43 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c5af35cccsm4195493eec.30.2026.06.23.06.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:53:43 -0700 (PDT)
Date: Tue, 23 Jun 2026 06:53:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com, Marek Kasiewicz
 <marek.kasiewicz@intel.com>
Subject: Re: [PATCH v4] pcapng: add user-supplied timestamp support
Message-ID: <20260623065340.15e4f1a5@phoenix.local>
In-Reply-To: <20260623141302.486601-1-dawid.wesierski@intel.com>
References: <20260618143819.310046-1-dawid.wesierski@intel.com>
 <20260623141302.486601-1-dawid.wesierski@intel.com>
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

On Tue, 23 Jun 2026 10:10:11 -0400
Dawid Wesierski <dawid.wesierski@intel.com> wrote:

> +/*
> + * Compatibility wrapper: captures current TSC (converted at write time).
> + * Equivalent to rte_pcapng_copy_ts(..., 0).
> + */
> +RTE_EXPORT_SYMBOL(rte_pcapng_copy)
> +struct rte_mbuf *
> +rte_pcapng_copy(uint16_t port_id, uint32_t queue,
> +		const struct rte_mbuf *md,
> +		struct rte_mempool *mp,
> +		uint32_t length,
> +		enum rte_pcapng_direction direction,
> +		const char *comment)
> +{
> +	return rte_pcapng_copy_ts(port_id, queue, md, mp, length, direction,
> +				  comment, 0);
> +}
> +
> +/*
> + * Convert a TSC value to nanoseconds since the Unix epoch using the
> + * calibrated clock of the capture file. Uses the same pre-computed
> + * reciprocal multiplier as the internal write path (no integer division).
> + */
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pcapng_tsc_to_ns, 26.07)
> +uint64_t
> +rte_pcapng_tsc_to_ns(const rte_pcapng_t *self, uint64_t tsc)
> +{
> +	return tsc_to_ns_epoch(&self->clock, tsc);
> +}

Why not just use function versioning on rte_pcapng_copy() to add new parameter?

Also should add a coverage test app/test/test_pcapng.c
