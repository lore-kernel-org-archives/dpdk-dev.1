Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12924CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 16:32:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 434AE4064E;
	Mon, 29 Sep 2025 18:32:43 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 89788402EB
 for <dev@dpdk.org>; Mon, 29 Sep 2025 18:32:41 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-7957e2f6ba8so46922906d6.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1759163561;
 x=1759768361; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhEifHwuPy7KqMiJEobyFfKosv3tFBcaWfKVaD0PruA=;
 b=wjue8KsCHNvL2HzJmhpLMQ12xjP5vXS2ylKjY8Icgi0PdytfMbmgGWBIyDF6Go4pQD
 Kd5Dn/ujLjP38OE/uR0A9FpZwshbVeKN2ayK12kNhCsjIBWGJYqT8+4tDpkftHWfMfly
 VaFGfieNjIJgRSF/wjcSot1zmftwuep8lAs0lEbb97tmg7iqq4CFtS6ZyFESmyTqlHr3
 Fh0UZ+KZ+lksPcCFmFfm/blVoLqCEqsBNnLwSR4MZ9VUD0V/Rlr3+iW2AMB6hxSj6fty
 aLJ03yIA0CafliGSwk7PyFkTfa40h2kIUPX5bMJNFh/9IUakhCNOiknQx33jL2YNHSxT
 83oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759163561; x=1759768361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhEifHwuPy7KqMiJEobyFfKosv3tFBcaWfKVaD0PruA=;
 b=ZyhEQ1AbxKVjn4XNBh60eRWMwGJ4meoEey3lwr1NNbOcn0ujiAMAbqcy4iUBlOpKDZ
 CSRNrHyFxHxDROmlm9Zv5lFUQPIY7v5auWDYVNc8+WuGXTWyT3UoNs1MOELKbROqHWgO
 40jIjagoLtjTUXKeiq8+ytYASgLedyq5pwkrCYJoUiv6kU+bYYGIm7Rz5lRoKT6IGXWK
 WPXh+Kkkt9Jh5kZzyfN9hLNq6wUYoSdtUkfGgMyhwnDdcJ8DyLtU0HXMv9PvqNZYfMkr
 XkDsOGkg+zPutJvYvbVdf5Q9uKHEssuTM4/v4DGbEr0SvTKmOmsgZo1Ja5nACCFQVwk3
 VCZw==
X-Gm-Message-State: AOJu0YyF4mVISClJ4qin4VzToEJGhNy8V7t8VluDXOsTEpGo3IkzAc/J
 AHV7FlzFsGBFaPmpg7+sJn+Upju9da3delAZwJEfA4EzehOdDXyV5y5ow7UUWZv+irs=
X-Gm-Gg: ASbGnctgvnNdy5DSFNcmaB/efSpyBiQVJT7/moZjxKg+eSHs8op+NNXDkmhhnnZabCb
 u6/yjd8dHqUtaU9tkKOFGvRwnGrV6JBy60ubsQkOAUI45Y5SuNOqzEHKN8tUweBhIBQEqNG/IZn
 AEfjG58k3woKjCACeHeIFimBHVNQNOQnF5DM7nFmyq8rpcLdcbet5ggYvdjhPLQCaKuUEAbsFo4
 G+8jkUxoNPDX/MqGR2B3pM5l72SEOzFOoJ8lBy19Whh9Msu3F8q094K/Y533eK78EBqDyr2DarS
 p+cd2lW/haF4jS7MUyx3Emr2BfbwYEDJDxTi5+5bJQfz+yyqAFlQVhVZfrjgjuCYPzNbrhu+h5K
 V9MRRyvRc1yTOk2aq4LR+z3Yp6q8nfeKePYcfb4IkDPS8r/6I5t2/ZZpxD3SF/ZDFRDM535yEUR
 Q=
X-Google-Smtp-Source: AGHT+IFxRCb79Tc9E47vdZyBB9B+aFWUAQhdRSrg75GsHo5K8swd4YNvd1T/eE7VttwNQku827Vm7A==
X-Received: by 2002:a05:6214:268e:b0:823:f922:8f10 with SMTP id
 6a1803df08f44-823f9229040mr163536056d6.30.1759163560690; 
 Mon, 29 Sep 2025 09:32:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-80166781d27sm79646666d6.45.2025.09.29.09.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 09:32:40 -0700 (PDT)
Date: Mon, 29 Sep 2025 09:32:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org, gakhil@marvell.com, konstantin.ananyev@huawei.com,
 bruce.richardson@intel.com, thomas@monjalon.net, mb@smartsharesystems.com,
 stable@dpdk.org
Subject: Re: [dpdk-dev v4 1/2] eal: Add mem equal and non-equal to prevent
 timing attacks memcmp.
Message-ID: <20250929093236.37fe5460@hermes.local>
In-Reply-To: <20250929145049.153078-1-kai.ji@intel.com>
References: <20250926160209.56496-1-kai.ji@intel.com>
 <20250929145049.153078-1-kai.ji@intel.com>
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

On Mon, 29 Sep 2025 14:50:48 +0000
Kai Ji <kai.ji@intel.com> wrote:

> diff --git a/lib/eal/include/rte_memory.h b/lib/eal/include/rte_memory.h
> index dcc0e69cfe..bbdef8e939 100644
> --- a/lib/eal/include/rte_memory.h
> +++ b/lib/eal/include/rte_memory.h
> @@ -746,6 +746,74 @@ __rte_experimental
>  void
>  rte_memzero_explicit(void *dst, size_t sz);
>  
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Constant-time memory inequality comparison.
> + *
> + * This function compares two memory regions in constant time, making it
> + * resistant to timing side-channel attacks. The execution time depends only
> + * on the length parameter, not on the actual data values being compared.
> + *
> + * This is particularly important for cryptographic operations where timing
> + * differences could leak information about secret keys, passwords, or other
> + * sensitive data.
> + *
> + * @param a
> + *   Pointer to the first memory region to compare
> + * @param b
> + *   Pointer to the second memory region to compare
> + * @param n
> + *   Number of bytes to compare
> + * @return
> + *   false if the memory regions are identical, true if they differ
> + */
> +__rte_experimental
> +static inline bool
> +rte_memneq_consttime(const void *a, const void *b, size_t n)

NAK
Please change to match BSD equivalent function (ie not not equal)
