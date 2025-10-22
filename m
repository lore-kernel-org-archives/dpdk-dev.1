Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9875BCCD1BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 16:28:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3758402BC;
	Wed, 22 Oct 2025 18:28:51 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 65B4840262
 for <dev@dpdk.org>; Wed, 22 Oct 2025 18:28:50 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-290d4d421f6so56828395ad.2
 for <dev@dpdk.org>; Wed, 22 Oct 2025 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761150529;
 x=1761755329; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALLKxeAc7C/Wr2JB6FrYrwyYFjIPER27YRC/BZuHeV0=;
 b=jVVRokBkHQCdfIXl0cv3/25xBzJMzZ4LH3ZR37CvLMaQ6F0ZUyQ8rCuFBG6XJCYZE+
 mkr0Hr4QY3Lo38TsJYuKgD9hN1lEIhOUcAoCHH06FuD6TlYLwLT67aLm7Pl1oYppKyV9
 sl8O0jzc13XxXDZhFs45RVEd01ZfZriaQ28sHr6eYVUfIxcCaDxGLMn5SsAW8EaMS4fJ
 eoKSYRv6VAFJMiZb+LXNe2vXEu4oZpxAfMfEZ9CkrZ1y/1uScqXr/A/hyP25oBzuSheF
 Fb+4Jwk4OdM3jKgj5nJUCtMWCOfL5tsS+6yQwX5egtvFukhAK2bDAlbzK4Bu5f0hWFAM
 QV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761150529; x=1761755329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALLKxeAc7C/Wr2JB6FrYrwyYFjIPER27YRC/BZuHeV0=;
 b=Nlk4w36Rc0END0FMyFOKQJ0HKG/GUG9TYC0ID8LkBIZHB8N+oVJz5+kxRpW+SWXHYs
 oZq2Up8Lo6TgXRSBFqTarZ5lpiJx2WMjYFh45efJJ41pKO78KccpcgBGEWudGWl8VIGk
 HoO/OKJJeQRLwep5cEmWlYcZ9yLJHXe6MTyaPkJ4hLgzJnHlD/AqTCepg2uUKxNLpuVk
 LYf5GomgGDh4r8mcr1Hfq8OeQNNhnzsJktaay3QAXaxpd+TmN5B6A0sGnfAtJzIN2zsO
 Gr4hTYWMuqj5yXjbkXraeVuOsQTFzsXWI2BKE6WFPiNGi4ocqiIpEed6QIeiclExRex+
 0HLQ==
X-Gm-Message-State: AOJu0YwxAu2nP8z+P6CuMko8GVxIL0AbKTj1gk8quUIi1fVTaM5hUgS/
 LufQmPWFjzvNwXFr/y870S3yJYIZyH9269+zc5hiE8LkSTkZN4Z/fkUUw3PegsZuYNE=
X-Gm-Gg: ASbGnctqrMw/sEKcvaoGmj3XZA0f47svUFOd0IL4AWAIIANDdGPcOoe6Dguf5hJ5mDV
 QmKhvY+zy2OYJ5UxZHlLvuIrKDHOsLS9ynS/Iq13liEDDppiae7rnA3XRKzmC3awuVncZjukGyf
 8aXa9NyYpaFLxCGY+giaU1evM8BiJUHApyLIykIYzlmHTiI9l5U12J8WSOz93/WzPPQXgaW5LgO
 G4MeFzKwuZA+qyEPuqzEjwnB49ahD26G29ETk7MpeUUh72ObZR1DCFKaYcZeW2j7XHJS/aE1gFw
 u3OUNTgrw8ospZWKiOLEzOlL+crMhvJhyJtxuKQUeT5BGlP6iQ8vY0AFvzwSdelOxuIKieKtK+q
 ZcNxK8t41HKxir3tF31aJCRGmMjp5LTY2ylD4Yz9PDSXittNsCy7/8IJA51xLnyI1ahW53Xo4rf
 a5jSyziQGVCb5B3QGXEGeNhxpyNuSv2ILnQXGp8+MrhUDxyAWQqxly1K9JL4Sn
X-Google-Smtp-Source: AGHT+IHR4jU3MLbsBspEuUZ/UPRYX/AYTobVobDgqDBo8RCBWzs4YBUxTlDYfmO0lerPbVqKOqm8eg==
X-Received: by 2002:a17:903:1a4c:b0:27e:ef09:4ab6 with SMTP id
 d9443c01a7336-290c99ad18bmr259630015ad.0.1761150529386; 
 Wed, 22 Oct 2025 09:28:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2930a24398fsm21347325ad.8.2025.10.22.09.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 09:28:49 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:28:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] net/vmxnet3: disable RSS for single queue configuration
 for ESX8.0+ versions
Message-ID: <20251022092846.00304658@phoenix.lan>
In-Reply-To: <20251022125844.6187-1-amiyaranjan.mohakud@gmail.com>
References: <20251022125844.6187-1-amiyaranjan.mohakud@gmail.com>
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

On Wed, 22 Oct 2025 18:28:44 +0530
Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com> wrote:

> This fixes the issue of v4 RSS configuration failure in vmxnet3_v4_rss_configure
> while writing to BAR register. It's very specific to single queue conifuguration.
> 
> Ref: https://mails.dpdk.org/archives/users/2025-April/008236.html
> 
> Bugzilla ID:1789
> Cc: stable@dpdk.org
> 
> Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
> ---

Queued to next-net with slightly modified commit message.
Could you identify a commit this fixes so that the LTS backport can know
which versions are impacted.
