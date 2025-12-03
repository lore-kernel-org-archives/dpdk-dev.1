Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A450DD1268A
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Dec 2025 00:04:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30D44402E6;
	Wed,  3 Dec 2025 01:04:15 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 92F464021F
 for <dev@dpdk.org>; Wed,  3 Dec 2025 01:04:14 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so63208815e9.3
 for <dev@dpdk.org>; Tue, 02 Dec 2025 16:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764720254;
 x=1765325054; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiNkhn3+iB7FW4iN3tLCpR4yJWTMCRZYXfNwrJLkOiA=;
 b=o8SKSZetuV3vYmJ9nESxm7F2vklfuKm9Qyx/GbbW/hX3n9v74bAWVTPMYH4Hry10bT
 rFYySZbci3C14T7GD2ba4R4kA5UKviBtW6qtmEjg92KoIK7vQ4AH8pp5sBcbSLkZYtPU
 tqLo2cKsHs+O31dR2nMuusbWSB17kQjKXdo2zy0u/KXhTijfXMOL7l3tN/TQ7pRgP4jY
 CL4NRYv6yrGOqdNL2D9rxZjd8kST/hzLwLWTz+1o0KbUKsN4rE77iqkqfAQyi5jBHURL
 jAnuXqJfunbYEAmk/KDt5h3OfWY29MDfzh3FF9+C5fmBFEFtvyaweXzxlLZ9OdswpJQw
 gb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764720254; x=1765325054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BiNkhn3+iB7FW4iN3tLCpR4yJWTMCRZYXfNwrJLkOiA=;
 b=LJxzPrAaebN8Jz6lvFh23Sf7S7xr6sLMvl4Ty5f5AmGT8dlv/T2ZX907WkEIHgfA7h
 w9JXIi1lU7eE4ENUzZKtxXlb0nHKJOL56g8E3+uDEEmiOBfG4Eq8AyFNMohKH8RozwUL
 480aPPVYMi2sK8KRCHGqCM/1W9htgYvyoxNE5AE8Fu5HJWZyOBfkBF78PkV79uul7Zbj
 0Y0Jeq9bMo+w7LiLzaW3rgWKg1/wlO44rCC0NMERjetS7x4Vs+Zq7apHkFpf2vAOzY7q
 nK523oYrd0I6X+9YMsZSw7cPK/wHJi+xMoVtgv1IHNEiVTvpPMVJ/JHDevH358DVCoBZ
 jU6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvKM716ER/qy6tt6r0axjRfDQPALf7h8l2KBKdEQYgvxpQdfGsOt9PyuorFxkKoWNaaQ4=@dpdk.org
X-Gm-Message-State: AOJu0YyV/3bh/jG4rbvmRwKmon36JW25CLN0+lDzX8DAs+KDogzO6mOe
 seuLNFtAdG2sFC1ED0m1dNFQkXd+iSnKwCkZbKhBdbtqDzfCeGi4hDAFuzTiu1xKBnw=
X-Gm-Gg: ASbGncsS8JOo/7nKDhWwN+sYuh30QPoU4rXszg5dumUfZ66kTeMz2iybn07T03ZSxih
 1rJnu9N6OsbdOGQ5qPTaQu0DD6VkQew0YkzbNf8T3YMD3BZs8QU3vZclMv8LMjiwrjGDIeEZEim
 p5T1qVbDq2appO7Oum6h6NEYKUwDbJMN4iXy6DbRmsPTtixZwmhW9LsFSffBck3LhO498jB3oYA
 ElT/g6lQuLWzqdWm72lg9UWHpbPMRkMJxcOJnj3wbFhE4/OhrmPEO86611p9tBJOvoArl9MZtKi
 MU9hkw8/75dUEiAsubNrPN+eZr7zY+/mPXOYVacGG9vTqVOEj2+EPJWc8S/QU+jfF2GoWHpqYcg
 oEvS0Xre/UgSMcBCB/S+u5YQJH13yJ7X0easJB3Z2tfhzRA92iJLqgQqOU4+SiMrnJlT9RwTshL
 orjIgYmfXx/dqkpqtiUxBQNM/Ln+wnLeZcdmxBYDk5km1ZrUJFrdnS
X-Google-Smtp-Source: AGHT+IG9DQaojRiPwQzzbgQuN5hXLj6yqdUYG/bOpaoREsewRg/FgQ3lC0lxhTUldlncmYuMlk0+hg==
X-Received: by 2002:a05:600c:c48f:b0:477:b0b9:312a with SMTP id
 5b1f17b1804b1-4792aed9b18mr3227785e9.7.1764720253741; 
 Tue, 02 Dec 2025 16:04:13 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792b0329dbsm2693255e9.1.2025.12.02.16.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 16:04:12 -0800 (PST)
Date: Tue, 2 Dec 2025 16:04:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, Ori Kam <orika@nvidia.com>,
 <dev@dpdk.org>, Bing Zhao <bingz@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH] app/testpmd: fix flow queue job leaks
Message-ID: <20251202160406.2b166c90@phoenix.local>
In-Reply-To: <20251118104518.1714166-1-dsosnowski@nvidia.com>
References: <20251118104518.1714166-1-dsosnowski@nvidia.com>
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

On Tue, 18 Nov 2025 11:45:18 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> +	polled = 0;
> +	success = 0;
> +	while (expected_ops > 0) {
> +		/* Poisoning to make sure PMDs update it in case of error. */
> +		memset(&error, 0x55, sizeof(error));
> +		ret = rte_flow_pull(port_id, queue_id, res, expected_ops, &error);
> +		if (ret < 0) {
> +			port_flow_complain(&error);
> +			free(res);
> +			return ret;
> +		}
> +		if (ret == 0) {
> +			rte_delay_us_sleep(FLOW_QUEUE_FLUSH_SLEEP_US);
> +			continue;
> +		}

Infinite loops with sleep are bad. The poisoning seems unnecessary and not done
elsewhere. Sleeping for 10 us is just unlikely to help much.
