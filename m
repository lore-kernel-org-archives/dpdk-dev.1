Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743F0C7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 15:01:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AC924021F;
	Thu, 26 Jun 2025 17:01:24 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 872F040156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 17:01:22 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7d3cc0017fdso118284285a.3
 for <dev@dpdk.org>; Thu, 26 Jun 2025 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750950082;
 x=1751554882; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19HjYfJBaOhNAMDTceJ8g1sfUfTf3LrXkS0xyc9O2Bs=;
 b=W8ZO6wCEyg3scVkgPgEfPu4zOBqRGUUpC53nNu0l8EYPb4up8ufqVY1CRGNn1GMEbA
 q3il01Q5iPEJI9nmKbegL0Ug614DtGElRjlYXStgVqbbb2XNIO47YVbGNOxwRypd6NiB
 00wtC0sYHxyW/+V+3iLTbJQCTHOwwLv4wz9NpgXYmG6F2HW2gk/6iRkO8tCgLFMJpKMi
 OprAIgsq4Ory4mfPUwi7w32Em1j6E2sy4T5DEuQGjzM4/VrMMt19ztcmv8dcq0ZJv0U2
 KT9UuOOvmE+kirYYThjnpckP417qW4wWxWgrnF5fxWt3Qi4/Zh5DI3J5g+IhXNtF3ylo
 cryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750950082; x=1751554882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=19HjYfJBaOhNAMDTceJ8g1sfUfTf3LrXkS0xyc9O2Bs=;
 b=qxd0UfpE8jC4Dj4h4exel+KT3UQY4tiMa9pOn7cMTS5L/8m0W0D8iIzshJctFrQrPu
 Ht++9R36eHljHi6aHgEhAHttn0h8RwKer31GpuHGj/vY4utmigluZqWjvNyCQJsUFwMY
 EgDZXGeARkeVrRMcawZrEVhTOysfigVasfaFc2rXmDV/nUE+Bdz77wbIZ2lu6XhgBnj9
 GDCZI81cJR6KIYhFQDXXmBC2rVAe/DbBS4hfsQusE9vdxZu+YHyktqgIhTPeo3nm1+Z1
 bxoY7NOfd/UkuZu1Z02+oMDxmw/fphkTrYRxzYFy2HeVU2NyMvjIQl7ieLBw4KeEjGG0
 iKUQ==
X-Gm-Message-State: AOJu0YwOSdiCXA/G9SAF5uUB0TN7p+0dNeq02jtdj1Ek51FgrLzYb58O
 qfrVPzAb54kHPJRxKFLZvu9331Kkqvbd6fu+Df7wDlihP1eErc9IVcirIO6ZSnOlEj8=
X-Gm-Gg: ASbGncsqmiAgoQ6bmbsLR1NuopyKCB388/ij1bfx60p7nOxRW1cJprsl7AD0nQ4zIZB
 RNdxSjTY3jNLZGjg8ZsObaOU4uVjRh4j1rfsYeR5UL1mPtvEkwcpsAoE9w7e09MYWR0AnZmZB9r
 twbePGqcscRI/w5tpj/7Eg03UFwEIjrEMqrT/qPUnffds+TvljyQvMJMBeMFAVcSu99YswzHiUc
 Q78uQah/Efts8/JvkVQG2vlrzBlm43ZSOmTdtJYOkXvD1gAwq53EBuiKgutNXUvb+7kb5u+RQV3
 zipkLE08Fm1u/N6tJtBkD8wBONK3lpm1/WG86vHS5q/ZvEx7k0IKjEk8BeZf82z2kSrbHRo9FgA
 pbG0JjsN6Hqt1bFli6wiJMlxV8PgZOuQ95gjWFrwPNprkDXGPPQ==
X-Google-Smtp-Source: AGHT+IEiADTs3xQW9urREUByLeyrcmdV8ZL7UADjYFXPB2PRNJABbzvpNqp5KcsNTlLqxNGLBbwuVw==
X-Received: by 2002:a05:620a:2a15:b0:7d0:96e8:478d with SMTP id
 af79cd13be357-7d42977c947mr878194085a.39.1750950080827; 
 Thu, 26 Jun 2025 08:01:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44317c843sm11003685a.42.2025.06.26.08.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 08:01:20 -0700 (PDT)
Date: Thu, 26 Jun 2025 08:01:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, David Marchand
 <david.marchand@redhat.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH v3 1/2] latencystats: fix receive sample MP issues
Message-ID: <20250626080117.24bb3cc7@hermes.local>
In-Reply-To: <PH7PR12MB85960D943C91FE608DBA4C2F827BA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250613003547.39239-1-stephen@networkplumber.org>
 <20250617150252.814215-1-stephen@networkplumber.org>
 <20250617150252.814215-2-stephen@networkplumber.org>
 <PH7PR12MB85960D943C91FE608DBA4C2F827BA@PH7PR12MB8596.namprd12.prod.outlook.com>
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

On Wed, 25 Jun 2025 11:31:43 +0000
"Varghese, Vipin" <Vipin.Varghese@amd.com> wrote:

> Following are our understanding
> 
> 1. increase in multi-queue latency is attributed by spinlock.
> 2. the lower latency with patch for multi-queue is because the lowest of all queues are taken into account.
> 
> Question: will there be per queue min, max, avg stats be enhanced in future?
> 
> Tested-by: Thiyagarajan P <Thiyagarajan.P@amd.com>
> Reviewed-by: Vipin Varghese <Vipin.Varghese@amd.com>


It would make sense for the latencystats to be per-port/per-queue and avoid the
locking, but it would be a significant API change. If you actually use this
then would be good to make it better.
