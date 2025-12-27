Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D4AE9271A
	for <dpdk-dev@archiver.kernel.org>; Sat, 27 Dec 2025 18:12:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8735A40297;
	Sat, 27 Dec 2025 19:12:27 +0100 (CET)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45]) by mails.dpdk.org (Postfix) with ESMTP id 2C97940267
 for <dev@dpdk.org>; Sat, 27 Dec 2025 19:12:26 +0100 (CET)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-64b921d9e67so11089417a12.3
 for <dev@dpdk.org>; Sat, 27 Dec 2025 10:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766859145;
 x=1767463945; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJcw04rOh8s1gHKvpj71icZCDtcgQnl4z/HEyeZK6Vk=;
 b=tBzkLwrunusTCAYTGM5IEfoE3WVAcSa6Fi4B04e2/xcHsxTkF9gVq56JHDSKJK61np
 sJd04dfstBYGJ6T9YVqEkw5Nda6hsl8tcKzFb4ThHXuVX4R+aID9INeLLBq3Fun4NGKX
 sBTx8ElDyj3/YDQZGegoVYxOi+JS5nAgDSLpx3rkg4G/UOy15XzkS9YsaH7cY/t2IfPe
 ZACoD16RrcEwtN+JbLLw0280Mr6SsN3oFbUrD6wNdecklawQlYtZ/VUbeFxHL8QaySob
 LHuwsHySmwU0iXjSUJYYfTgwpRF1Ygy7DThrGz45YKZliNSVX9F1ly9n9ypHO+0mtjh2
 I94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766859145; x=1767463945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GJcw04rOh8s1gHKvpj71icZCDtcgQnl4z/HEyeZK6Vk=;
 b=Tt+vlmFEDr8AW7i25Ml8PdMZgY2H1IUMdMgDu3ZiQ9i8c0PaXUgdv0Ah6GMGZd8Aol
 xgY73naUgysydHpsjN6GFU07d1xq26HItr5MWqKHzDppZb5mC2tgGfypwvW1ZXHE5tOj
 Ow8AqN4gBZoPZ/4wUJj2GJAlkh63m0pVVYv6Cx9K1JHwpteJqOApCZAzcA3M4HAOeFK9
 o/2V9wTCBv35tT8843Wz45LGlj3JjE4UKi7riof7yvSi2jXXhfQLxB0DfRT0JWQ1p7zZ
 votO8iyTPIqSBuFuYqRtz44LqGrFam4RrjfN9rXIM0O65x9iIvjl/DWSQvHtnWhctVX2
 0Cog==
X-Gm-Message-State: AOJu0YzXHwL4KpppA1thhtzn//m5wJzwMZGzgNF7ARmXdyWeDCRwG43j
 0P1t4LGVslMg0KnLzonKEJXw481Hb0fOM+TYJM8YGmqofybhaET2XcmhqrdAX3ddNRQ=
X-Gm-Gg: AY/fxX5ILxqas66clUM6UyKRGxttITTf5HnxF/BgnbU9TlNYP1WZ/NPHVAFTrZXnIQE
 nuM0+XYoOIBGYBeqg7V66a+2rTvQ9mIk4qPPzL63LHq/QKNqVXxf49lpUOT0rc6wNRcmU8cCDKn
 pgT8AU4l8qhG/YzYSHdtG6lPHAjMo4te0FFBZV9I47xgqXi6Rc9pLu0/b2Aq9dF2V4mGK7Mse4m
 5BK7SOODOGSUJCeM8et1MBfoliKOIAuOHYcSc2+97BM509pjufp3r2M+3XBudFFFtSb9DMSM3nX
 /gD+DaTpN8AX1Hxesqrwxaf4Pm92tNGupsvCU4YuGkucTs6ZXKEOgRk98K4f95OrfKEH2/fRm3i
 9CfPY/WOiSLfFSfjWWn9WWkq1oZpSR1ZsPfZdU78NLmF+NX0n6Sy8ntR1X2HebEw/cHNg7UfUzy
 uKwHMzXWpNG9zM/nffy27xbwxmmAVgXL8hffEBqtz+1fMHMVwCtndU
X-Google-Smtp-Source: AGHT+IH/vzjmcuB18cNYOH4k/lwyTV+A+Itmc8GCFheKTuNjyDwOLVgoiqtMxFJFUTyhWOfsm5+SLA==
X-Received: by 2002:a05:6402:b8e:b0:640:aae4:b84e with SMTP id
 4fb4d7f45d1cf-64b8e94a858mr19055014a12.13.1766859145290; 
 Sat, 27 Dec 2025 10:12:25 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b9ef904bcsm25918317a12.22.2025.12.27.10.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 10:12:24 -0800 (PST)
Date: Sat, 27 Dec 2025 10:12:17 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kumara Parameshwaran <kumaraparamesh92@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3] gro : improve GRO performance based on hash table
Message-ID: <20251227101217.43f0f215@phoenix.local>
In-Reply-To: <20251227174221.277640-1-kumaraparamesh92@gmail.com>
References: <20251116060634.262352-1-kumaraparamesh92@gmail.com>
 <20251227174221.277640-1-kumaraparamesh92@gmail.com>
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

On Sat, 27 Dec 2025 23:12:21 +0530
Kumara Parameshwaran <kumaraparamesh92@gmail.com> wrote:

> +static void fill_payload(char *payload, size_t len, uint8_t *ref)
> +{
> +	for (size_t i = 0; i < len; i++) {
> +		uint8_t val = rand() % 256;

This is a test, so security doesn't matter but DPDK has a better random number
generator than rand(). You could use rte_rand_max(UINT8_MAX) here.
