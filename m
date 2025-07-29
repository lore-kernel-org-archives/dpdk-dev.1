Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A23C87FCA
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 22:10:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A34D7402BD;
	Wed, 30 Jul 2025 00:10:09 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id B8CBA402A7
 for <dev@dpdk.org>; Wed, 30 Jul 2025 00:10:08 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3b78a034f17so2033392f8f.2
 for <dev@dpdk.org>; Tue, 29 Jul 2025 15:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753827008;
 x=1754431808; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SGovavtUYdchQ9ahqFxxJ1pTRBYtluAy1l7n6jBGJA=;
 b=ifzG5hPgd7T0NE7tQIwS1lXiO0CcAMcPhHYy8eGGf64JdHXNXX6hDWeo0gZkezbamM
 kgLHKRVsFUCb/3vuLpXyqVOa86t8Vka/9sgiy0oqMiNiDpufsEWueUH5qnsvhwTC8cCd
 at2QhEdeaZY9s2RyHjqezUqmrjiH+i78j8QcqMWVmI7d7gZ4QTUM0ML70FCJx0zWxqwx
 nrwjwQJtcfVaXVIfky09RN4JKzPGOvmb0MbBRjYoyNsxuosJz5C13XAvoBrm7dfbqHGv
 ErSvSyNDsb9xxcDEhM5fxianNyw7eIcuw6IlLvqf5neR0bMu/FGDUsAp/P5R3BYy6fvC
 xMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753827008; x=1754431808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9SGovavtUYdchQ9ahqFxxJ1pTRBYtluAy1l7n6jBGJA=;
 b=w4e8Md1Av8ByQJqxmEQpb5N4q6Uzp2yFJgmhUhPrFYmoFAZGMS/pQvyNuj1M4Iz9gM
 rJpMh8DcWRFOYiNM4vUhmkbGHK/JKsLaQhl4vRKQ8N/i0q9Sb7sU1ioFIDBu3q5K0bV3
 M2lqXev3hJUE2k5VmI8T/7053n3eTnXBLv4BbVpr+fSdM2gqUWRzpvIFVTDn/lsQcPLp
 O3DMo/tCV3k0p9MJ6ghP4FcxsxnhkvdO0kn32I7vIGTdCEx5pRpFceUPxOZkf5tZ01tz
 EfjW7Cu8rLOw9ZKMZVR50vK3YJvyKNb1cXsuaNyA0xiXKqlrJENlxKwaK6mNxJ0t5pSx
 tNJQ==
X-Gm-Message-State: AOJu0YzDSL9/6p8lA+URvaPw+Q2csHcQKaVi7qQ1dM4OYCgi6gI+qWdT
 GZxIN3NrQDyn+UvYg1VBEWJZVqrW4vVusFdAGt5XIbqI02WEx4YZorrXVDywAIo8guk=
X-Gm-Gg: ASbGncsYHkLYzZvwuGyiJyOWm1PktbDAeeOW073rtF/tExAgqocOXIP2/WF0ZZ/3vc1
 Ha1hrKTTQTcx75/GwJ9eyZ9mUkCnfrIEKLvyM6UN44Ec+YDO7lMofNh4FpFGkCfW+4GmH3eZW2F
 5nKARgK7jl5eJWOCf3gqIkurhDQ0sEOnNyJCiuy1AkDRBXoTjaLNm2tQ5uUBm2k4Ek+zG8z6ZTC
 SggHTakM15/Ak4bzIZZV9IgTc5g1Z86yARgi2cByotWVns6jX6e1wT7nNmmUn3BMXaC6eRgOESG
 svZ79vrOsngtDG2BaPNRAiTDS9oyJtYltrifwegsSW0aqzgQqcUhAKdX95b4UYTsXmhO05nnh8x
 YWIyB7DjoWuA90KE5nKAl+YR8UB6MgKI8UuyBUREL+4Amdk2OcufBU78+GN4fD5C50pS52XjzHX
 s=
X-Google-Smtp-Source: AGHT+IG9lLBBevgvM988rbFPPZkQ+AXgG4X8victv0iRHTs1Du7RFEqKil7ikIXJlI6E7Bt9wNW+Gw==
X-Received: by 2002:a05:6000:4310:b0:3b7:8914:cd95 with SMTP id
 ffacd0b85a97d-3b794fc2b55mr931262f8f.7.1753827008241; 
 Tue, 29 Jul 2025 15:10:08 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45895377748sm2544105e9.9.2025.07.29.15.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 15:10:08 -0700 (PDT)
Date: Tue, 29 Jul 2025 15:10:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shivaji Kant <shivajikant@google.com>
Cc: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan
 <mtahhan@redhat.com>
Subject: Re: [PATCH v4] net/af_xdp: enable AF_XDP program attachment mode
Message-ID: <20250729151003.0d046d67@hermes.local>
In-Reply-To: <20250729161747.894377-1-shivajikant@google.com>
References: <20250729100845.819452-1-shivajikant@google.com>
 <20250729161747.894377-1-shivajikant@google.com>
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

On Tue, 29 Jul 2025 16:17:47 +0000
Shivaji Kant <shivajikant@google.com> wrote:

> diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
> index 5f65850a27..9858ac24b2 100644
> --- a/drivers/net/af_xdp/rte_eth_af_xdp.c
> +++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
> @@ -169,6 +169,7 @@ struct pmd_internals {
>  	int queue_cnt;
>  	int max_queue_cnt;
>  	int configured_queue_cnt;
> +	uint mode_flag;
>  	bool shared_umem;
>  	char prog_path[PATH_MAX];
>  	bool custom_prog_configured;

Don't use the typedef uint, it is not what DPDK usually uses.
In types.h these are under "Old compatibility names for C types."

Better to use uint32_t which matches the __u32 arg for bpf_xdp_attach prototype.

I would also prefer that drivers avoid using int for things like
queue count because it can lead to overflow bugs. But that is a different problem.

The pmd_internals could also use some reordering to eliminate padding
and put hot elements in same cache.
