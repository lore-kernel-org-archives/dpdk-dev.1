Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ABFD2502D
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 19:07:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D0FC4028F;
	Sun, 11 Jan 2026 20:07:49 +0100 (CET)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id EC9154013F
 for <dev@dpdk.org>; Sun, 11 Jan 2026 20:07:47 +0100 (CET)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-64c893f3a94so7424881a12.0
 for <dev@dpdk.org>; Sun, 11 Jan 2026 11:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768158467;
 x=1768763267; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6Dm5fUnQec2R47DK6DoF75wz2bANr/MR8hrzrdIjQ8=;
 b=j0ZVOzzhzG3FKOmTVQK8BWCI+cbtFR5iZWwyq3GjStIX9EQGdpN2V1l/61A4YAXpTe
 PFjk/R9eKieZC59i1y02oK0si8w5HEd7n26lmnaKZGmZQ8rRg7KT4XVVTDGFSio4LYww
 gCdbwWdCc4Cafnr+NqxLbOYv1J38h2RyFbaanVvYLlGN04JrDkZJmqm/yk3X5ycmttxQ
 WFyf+RJKLsqfMaev4P8fjZ8ovE2YpXT2rTPSFDjRfsubQakPJLnGL86t843BVHxjUDz2
 Rxy4LreuxHiCcCkXTVSkWeE0lmIGiN4JJ9nMrbLTrAyBTmjRlZ2rwpoDM8ZITkwQeE8n
 nqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768158467; x=1768763267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d6Dm5fUnQec2R47DK6DoF75wz2bANr/MR8hrzrdIjQ8=;
 b=ZiygZ6kWGJ4ujnD8QcYluPZg0P2MeeQ993UUiXZYsoZMtHUynbZO71EV7KFGLpMeCc
 utvdNWigFfxiA5+tZRsWK/YMYinWA4H5nf+ocXbUlDqwYQmVpXTwav3pQ6i1NXc1bx6b
 BPHfjc4GpILXFM+Yz8/BuuVnhB0HGeuxA41aMs0M6C1qGBJr0MMBszAhKk1BTs2SRw5d
 Txso30pJOzaEgBMj7hotXwGZFCdnEbBrNW05ugDDJO7iLAAFz0liFkXMJjxAxGaJrsSy
 z4285pcY16KFZHGyha4PaZ1t0dcZSyQh2tPjrY7fgh2SJP3zCImnheyACsR2oYPWAy0T
 ROBA==
X-Gm-Message-State: AOJu0YwE+3nnaZzFSbBOYnwm1fcROhbw3W/E4jWa7LKid7cXCAVqQhvE
 YLh7BOc9LGRo/iDzPafRi2lxTF2Inzl620QzgU8SoP21e3jKWE4gwW/F8G19Myw4EnYglDIMvhg
 jLLIW
X-Gm-Gg: AY/fxX7P3xQe2JQG3E9yAo9JaFBVs07O7aELWWiFr2mrmf9Cme2a6CkEV5H7jmPx14G
 mg4APgc/B16JQIosdCEVhZS433EqXXBjPKbd6q1RFDEstRVFOh+QB/9VQSo/wxAUJ+xfCGnuxYN
 Wv8S7kGjbaQj37uaNZrKYJa7GJKBeqlw6kNlZ9+75yMyJXq6+NLpAyTMlhBuw0Vf6Euw/0lvlGJ
 BGEtyWCPDp/PnlIaunrRE8luTwC/0akdR1MCaCp+aaIzB4JN3f0TW/chheZzxKn3XFf45cG0qNd
 qSnktuvhQYlj1hP5zT9+gQC5hPyIP+h+6lqh9B42od0i12hZX6i6rHYw0nxxcU4teajWB0d+rDj
 eKDfo9NkDQxG9Y20r1/w41UuwbGZJwzySbGWWXh05epK15ioIQzuJaeoJYTpu0ohwrymxrlH4X5
 fjUrAWO5KVumDwkv2zyJz0Y23c0WFpBkvkGSe5MtxAwLSeRALQVvJQ
X-Google-Smtp-Source: AGHT+IH0pmd+oZR9RsXyWwg7MGkgJJpCmWLiAX19yHgyFaovgsjWMxF38EKD0Jhs4CpCNjoN1iuQSg==
X-Received: by 2002:a17:907:980a:b0:b87:19ae:eb36 with SMTP id
 a640c23a62f3a-b8719aeebb9mr114292766b.7.1768158467133; 
 Sun, 11 Jan 2026 11:07:47 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a563f0esm1762975266b.60.2026.01.11.11.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 11:07:46 -0800 (PST)
Date: Sun, 11 Jan 2026 11:07:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com
Subject: Re: [PATCH v3 v3 1/2] eal: RTE_PTR_ADD/SUB char* for compiler
 optimizations
Message-ID: <20260111110741.03cca1e4@phoenix.local>
In-Reply-To: <20260111160059.293-2-scott.k.mitch1@gmail.com>
References: <20260111160059.293-1-scott.k.mitch1@gmail.com>
 <20260111160059.293-2-scott.k.mitch1@gmail.com>
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

On Sun, 11 Jan 2026 11:00:58 -0500
scott.k.mitch1@gmail.com wrote:

> +#define RTE_PTR_ADD(ptr, x) \
> +	(__extension__ ({ \
> +		/* Diagnostics suppressed for internal macro operations only. \
> +		 * Compiler type-checks all _Generic branches even when unselected, \
> +		 * triggering warnings with no external impact. */ \
> +		__rte_diagnostic_push \
> +		__rte_diagnostic_ignored_wcast_qual \
> +		/* Uses uintptr_t arithmetic for integer types (API compatibility), \
> +		 * and char* arithmetic for pointer types (enables optimization). */ \
> +		__auto_type _ptr_result = _Generic((ptr), \

NAK
No ignoring cast qualifiers. Is this just to preserve const?

DPDK does not guarantee API compatibility across versions, only ABI.

Why not clarify the code by using inline?

static inline void *__rte_ptr_offset(void *ptr, long delta)
{
	return (char *)ptr + delta;
}

#define RTE_PTR_ADD(ptr, x) __rte_ptr_offset(ptr, (long)(x))
#define RTE_PTR_SUB(ptr, x) __rte_ptr_offset(ptr, -(long)(x))

What about RTE_PTR_SUB() and RTE_PTR_DIFF()?


