Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E42CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 18:12:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F08140277;
	Fri, 26 Sep 2025 20:12:40 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 86D8740262
 for <dev@dpdk.org>; Fri, 26 Sep 2025 20:12:38 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-86278558d6fso66396285a.1
 for <dev@dpdk.org>; Fri, 26 Sep 2025 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758910358;
 x=1759515158; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VfkFXbalWsvLPofd5XQ2pRNFNUPH3PS9ccEKvcyEkGw=;
 b=cuo+My+jBE7V8PdGgPRexunmHMo+tM2sb++Ie84v9jy375QSAtCfZ6nbFoL0pIdj60
 +J+uTbimGmy8aNDMNjwFKobO7OahTcC+7oSwoeS02u7Psz3ak9p8hxQhRZhNs2A5YUvB
 EeOra8QGgLr3zB7lyIh6ptwC5WOPhavIRgDAFtA8BqzxtFgxbcNGPmx7uExJBRHaBTH9
 27UjPlPzjLIVLrSJU4BBO+9Mb891RAJHXHQUd7avWc6CmBR8zk7HT0U+s4q+BQuVno8C
 JxQi0Jceq/9Ex/T4XSuHuPGBPoHkmb962157Sil/Rd28GpvKl3AWgPo6C5q6RKRdQwLQ
 xrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758910358; x=1759515158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VfkFXbalWsvLPofd5XQ2pRNFNUPH3PS9ccEKvcyEkGw=;
 b=P5UlEpS4vgaJrl3w/zzvqtkJja+sIEyd4csDdFvLiSg21aJWmHqd665v4PwHiRQi8z
 DGE6JLGOg4L/XKvOhXxOxifrUHuFfENFD6jyZ20SR8H8Bql/CjG9U5uKXRpZ+reVeP+c
 7nIDiW2qtdnOfxAs0OD3WSoEop8S6EWQhqn+rZaKfx4R2lcp07lff/Zaj9ZuXC8XNYI/
 fq/ScGD7fHWIWujrELd1I96JbzTgW0KEWDsEAAZgLZQDXwQNzLCt+Nl6nsUbHcO6KnGx
 DRBd7Da5c2M+hZ52xLhh/eI4LchQLWR7Yj2cDjmqnVlqrjpStpxoPeScn3L1uX4QIrq3
 k+qA==
X-Gm-Message-State: AOJu0YywEapVqOLQcuZAtnYzwQjrVQsA48pR0BrSwWIe7g1vpzZ8I3yy
 Gn0q749RwNDEyESQTT6PRhZGs3SAGjBdPUvXyc/61YUscTr2XPw22uYSSEIQTZDvAVyfFX4gyU+
 W7Sx5vlo=
X-Gm-Gg: ASbGnct50D4uyu2YsYuUhQp6+v5azpO0/JkUKEuOasGnn3E9y2wSP8UqmEZFzmWiBQU
 MIA4asGYq6rRrQELEFifv/Psgq2+EeOoyGMHJ5MJk04zPz7CKXHf2+8KUAM1MDw0bJYOPpMh5Ka
 TwaaHcolCFKpXRFRr12535FdGoymoSHM2sgK9Tsb8Pc6s2xH6ZSJGe1joWkUll1TnGgU9PK9qsP
 XaC8+0wcovpn/N3EftTFDUKRTNHCDS3LVqb+LPi8w/iaDsnlsUQHGfI0utlisXWycEGwmX+nd8C
 3yURXxAQ9I0C3qNNeu+ylVai1eB8ZlnCS0ByBi5qyTMg0CSlCmb5UVew9f8eMnMt1HcDmgTXacW
 602e6uO645JRqCAU4flr917Ulc7TcAnWcQZRHqZovzxk60SAH4lqKrCNWsmjLnWRVJwLBOuss5Y
 E=
X-Google-Smtp-Source: AGHT+IHMiWhhBRFWLYWjwLUaPM4udS0yCXVyctJIJsGirzllYNKSTy08uNKkZdjOI8ovJPxW5zIp5Q==
X-Received: by 2002:a05:620a:480c:b0:80f:1ef6:6510 with SMTP id
 af79cd13be357-85ae97a5cfdmr1045924985a.81.1758910357765; 
 Fri, 26 Sep 2025 11:12:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c28a89bd4sm320816685a.19.2025.09.26.11.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:12:37 -0700 (PDT)
Date: Fri, 26 Sep 2025 11:12:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org, gakhil@marvell.com, konstantin.ananyev@huawei.com,
 bruce.richardson@intel.com, thomas@monjalon.net
Subject: Re: [dpdk-dev v3 1/2] eal: Add rte_consttime_memneq() to prevent
 timing attacks memcmp.
Message-ID: <20250926111233.4c0b983a@hermes.local>
In-Reply-To: <20250926160209.56496-1-kai.ji@intel.com>
References: <20250926154905.54416-1-kai.ji@intel.com>
 <20250926160209.56496-1-kai.ji@intel.com>
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

On Fri, 26 Sep 2025 16:02:08 +0000
Kai Ji <kai.ji@intel.com> wrote:

> +/**
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
> +static inline bool
> +rte_consttime_memneq(const void *a, const void *b, size_t n)

prefer FreeBSD naming i.e memeq instead of memneq
