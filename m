Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B92D46BF0
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:48:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 804634026F;
	Thu, 29 Jan 2026 02:48:52 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 446D44026A
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:48:51 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso3610245e9.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651331;
 x=1770256131; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=435p4qC3ac8LqO3Vehkow12VbTOoCdK8x/fyfKdqxJ0=;
 b=IyoAkuE7GkT7vnExoF9Khgo3co1+acQQgtWYl+mMGtXiVjJJ4B22iq098//RUAT49r
 323dwwsS/oBlWzL1EJBBYF/KmLcLFGrv5wv6AS8p86X4hkPdqvdcbHXNqsIu52jyvIvc
 gKNOQYy7Q0U/cRlOWnyHu1Sit+47tIib3VAGrI0//tEFYqap0G8I0Zuc5s7gSgZ3Pe7r
 fUJjpw1lMttWSzoGcPxjSf8DbdKf9KTsnrzRf/1XAH2BHgJqoIWvIckeSf5MFB9N2tU+
 Lvy6NPPeFa6pSCvnXuPmaWgAd6ijKIj9aa9JpzYHtUboff6b62eCXgUneS/CEvIAnpby
 +AbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651331; x=1770256131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=435p4qC3ac8LqO3Vehkow12VbTOoCdK8x/fyfKdqxJ0=;
 b=qbnBiy/ut0s4w3O1vLT+jHUEtm77CQ6zDXXb4ByeCLfwkeD6kQQW3ll7erWalrUJ9L
 /4BKSJYNcWNmAjGTOrHKNy9dACXZd1nVJCzeGIJXpFzSZgFAD+DNoR0DtLSIPQHddRY6
 97bDB3tRIF/j/zZbEsmGzd6twa1x+gn7/PTSeravLf+lUY97xN6YvF5Yt6UWVElGP/tQ
 /4bSqYI37YhfP/nFJViBnVvPVndME99rnaCD/JliV/g+ut0L2lAjZIhMt0vMARHhJENK
 7t7UxLWq56JSCLZBvfpylB+DwDDUaRhiekyIzJQ9xk/bfwKgkyr2n20VLy3d0OKsPj81
 y67Q==
X-Gm-Message-State: AOJu0Yx4zMvkft5KLJX+80+11Y6aHufuLsWRU/c7CyjK9mtkafcAtdtf
 pw8bIwQU38yXANjLTvlYCWXJ8LZlFzoIKBdN/qshb0GZ6kQEw950ZvEFWbVaYU1ljYpvOkgn4iu
 rMdmf
X-Gm-Gg: AZuq6aLpMy7FIHRrU6vTqiinmZ3kv32AiscvWFoC9m3WkdZ73EK/OSoBzqbwEqHG0gB
 YbfT3XCNCbQmE+6DbhiNQqIM+AW2mLZbar03+uHguHxD9m6WzDCw67WjRX/ARN1811AE5qoNQU7
 3wI6TlD492ydhgOz1EwfHmQZ8RmW10wtIInl4P2XLJ7c1E4IKgB05Fx6Eu7wnwGycb2yeh8xwAn
 5IV46OR8pW6cIt3OrSj1YTR3ZaPqjX5Yqo018eiDW+ySyXHCwes7+ErpnvwUp1bThnOajeqz7QY
 oOgSvv2GGZbe8CAMma9e41e7hNkXvb1NEJWQ6viIs9Yujw2ccCOGMA96iukQ+OKUhEhx6Ct/Zxo
 A4oaWWoJct/lplEqGBYXi2IWMGkbTxJ0GQdD16xLweYSlEj3Fmr0bxQ+t79ph7idrL281ElSxA+
 elkDOQpHqvbcvTswseAjLF3k6fY0naFgwvAZ8/C/qvrbW+JPQU5n7D
X-Received: by 2002:a05:600c:1e85:b0:480:4d76:daf0 with SMTP id
 5b1f17b1804b1-48069c967f4mr81005075e9.37.1769651330787; 
 Wed, 28 Jan 2026 17:48:50 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c4f3edsm159762875e9.15.2026.01.28.17.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:48:50 -0800 (PST)
Date: Wed, 28 Jan 2026 17:48:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cliff Burdick <cburdick@nvidia.com>
Cc: <dev@dpdk.org>, <anatoly.burakov@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>
Subject: Re: [PATCH 1/2] eal: support dmabuf
Message-ID: <20260128174845.1e947be7@phoenix.local>
In-Reply-To: <20260127174429.1504288-2-cburdick@nvidia.com>
References: <20260127174429.1504288-1-cburdick@nvidia.com>
 <20260127174429.1504288-2-cburdick@nvidia.com>
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

On Tue, 27 Jan 2026 17:44:08 +0000
Cliff Burdick <cburdick@nvidia.com> wrote:

> +		int fd;          /**< dmabuf fd, -1 if not dmabuf backed */
> +		uint64_t offset; /**< offset within dmabuf */
> +	} dmabuf_info[RTE_MAX_MEMSEG_LISTS] = {
> +	[0 ... RTE_MAX_MEMSEG_LISTS - 1] = { .fd = -1, .offset = 0 }
> +};
> +

Range initializer are a GCC extension not available in MSVC.
