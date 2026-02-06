Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2469EE20B3
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 16:09:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EE8340276;
	Fri,  6 Feb 2026 17:09:25 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 039BC40156
 for <dev@dpdk.org>; Fri,  6 Feb 2026 17:09:23 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4806f9e61f9so14187995e9.1
 for <dev@dpdk.org>; Fri, 06 Feb 2026 08:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770394163;
 x=1770998963; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnI0wwHoKmtHoOOMRR4tgx/2mNSOoOgPg2g806+Eubw=;
 b=uGTLMiRP1Iak8z9EXrNrIlBo5bCXnaKkwju6Hg0IkUTRpjWc2X6DTjdbIFdkqw3zJo
 azMsLiPTt2NKSUI7xXhNjtneiMLhhcdpZ1LjwkHWEbeb08cpaT4+kPlJ4zblE4RovhJN
 Zs54V25KweJlROse3+NqQKfpUarN/Vwy7rGJZVqJIxmmHPInWmoxy+0LzK8+BsiTzNZ8
 3XdRCnYmA87avq/WMqJN2uJbw7KHrvi500H1ibhVo8hJng67g4oRZ7A+MW3VXA79nqRq
 UiQAG5Q9qAxmDU7A0ZYlfCawcrOLPc62Zf1G5Ze0pTopAWBAz6mtPeuivQ5fFeEP9Qp4
 Tlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770394163; x=1770998963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jnI0wwHoKmtHoOOMRR4tgx/2mNSOoOgPg2g806+Eubw=;
 b=fgUjXE17smv8XVKbQluVIwtasbSdnNesk9QczNj3oIxn4iKvnvq9dg4aYl0e/D7X/P
 QnvmqZmJ3D2tjPocxTIKqWZPbP2dtjPlwmk5Krzzrgs25dez3F9NDsoDlyFKwfFQDFEf
 FqpIZFAvIx+SPuEKpU/M4hY/1+IxEOEI//z0rCgk6D1UqRzcBAH4RJHijKiVoBdjQdTm
 lJkABCytwiRxzsKV4PCb8mJXioSqvHNkTLgjVoG6zniYb1mvH3V8JEv46QwQYAZk71ie
 90T0w/QM0w1jqUAH/KDh73QAaFUbUj4z0k7zif98fyKBA+0oTv+wearSGdoAgQnh9i0m
 TAqQ==
X-Gm-Message-State: AOJu0YweMYwfEaHI+9c7IsWQZgd6jOY5DZ0D21NorX7O38wVGh4+vxCu
 eRHWP5VE/23YvIQEtJSY0mFeuNKrn1mvh/+6xoF5CR8D+NkHO5oXhtEvsFWS3PWFL7k=
X-Gm-Gg: AZuq6aK/py4jT4HJTpcke5UhAMuNZlGAEVR3XeU1kTaj+2CgHxJIkyBOjOZX+PHNsTo
 or8tlAbUjv48ZOY818BQZ/beCI8ZH9zjIp19xdyHQxx0jmtsp+MOgWBnFBOdCXzHuGEPmX618Wg
 FHhWQVdCqoqDdppX9q4KqpE32tvcc3geDl2YyQX1J6/cjWVEUXZ2BKAR0J1snLxjGq4IMzWhcA9
 7rFVLOGodOGik7O/xDo5MMF+cv9qUOlKGNlnMGsYSZD07K6wYxdIs2Q4cs3Sb7qVanAbtQ3CLkZ
 F9r/3dOkk1xWTiggAiH87tzFjgvibca1E5LiMg+XazHyLuVeZT6X/kJWOLkz2WyPj+PXe1Vm29k
 eoezFXHB1nYZYfc/fac8OSyzAlaZhR9cRo3sl085npFC6yoFaSKwhil1lvly3sVhhicHEwKvKuZ
 3nT1RivqlrDbF61v2KrC7M37E5UpVr1TLqamKZT7ipqvbtJf2h3FrD
X-Received: by 2002:a05:600c:3b03:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-483201e3bcamr50017415e9.9.1770394162848; 
 Fri, 06 Feb 2026 08:09:22 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d7a924sm205932135e9.10.2026.02.06.08.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 08:09:22 -0800 (PST)
Date: Fri, 6 Feb 2026 08:09:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com, bruce.richardson@intel.com
Subject: Re: [PATCH v23] eal: RTE_PTR_ADD/SUB API improvements
Message-ID: <20260206080913.1d22360e@phoenix.local>
In-Reply-To: <20260206042814.24970-1-scott.k.mitch1@gmail.com>
References: <20260206010157.98321-1-scott.k.mitch1@gmail.com>
 <20260206042814.24970-1-scott.k.mitch1@gmail.com>
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

On Thu,  5 Feb 2026 20:28:14 -0800
scott.k.mitch1@gmail.com wrote:

> +static int
> +test_ptr_align_edge_cases(void)
> +{
> +/* Independent test parameters */
> +#define RTE_COMMON_TEST_PAGE_SIZE 4096
> +#define RTE_COMMON_TEST_CACHE_LINE_ALIGN RTE_CACHE_LINE_SIZE
> +/* Dependent: computed based on test requirements */
> +/* Must fit PAGE_SIZE alignment tests */
> +#define RTE_COMMON_TEST_EDGE_CASE_BUFFER_SIZE (2 * RTE_COMMON_TEST_PAGE_SIZE)
> +#define RTE_COMMON_TEST_DOUBLE_PAGE_SIZE (2 * RTE_COMMON_TEST_PAGE_SIZE)
> +/* Must be >= CACHE_LINE_ALIGN to prevent overflow in CEIL boundary test */
> +#define RTE_COMMON_TEST_BOUNDARY_TEST_OFFSET (2 * RTE_COMMON_TEST_CACHE_LINE_ALIGN)
> +

Code reads better if #define's are put outside the function.
#define's don't have scope
