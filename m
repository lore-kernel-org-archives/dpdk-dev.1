Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A64CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 04:26:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BFF540299;
	Wed, 24 Jun 2026 06:26:27 +0200 (CEST)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48]) by mails.dpdk.org (Postfix) with ESMTP id B5E5F40150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 06:26:25 +0200 (CEST)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-662ebb1329aso281408d50.2
 for <dev@dpdk.org>; Tue, 23 Jun 2026 21:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782275185;
 x=1782879985; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkTNWaJlEpdfTNbQHfdpKoGmit7yq9Rk0Jg6kafUq8E=;
 b=DJN6lrU6LGd7e3fUpGd1WVuOGr81xh58nSVnlXyxeaMTJACxKlqzH/Z8B910Wctl2n
 FF06iV5oQKk6AuSDK8LQT1jo87sarFVSIm/cD0824fqzB4HfPnUyW33w8ZMtos0/zL8z
 3rx1BPbNj3YXE8lJ0cNS6ZqAUcsO3o3a0i5luAinThIy0aZjg814AEzniG2poJq9VK+i
 iQvgsfXrPJ8Z0SatQUNIQr8NCEv3nbP0939GSXh1oWg/1RF/ffzH8gujcHKprmli2+f+
 nYiZbwn4agZxjQK3wDDTAtgDjlqCf23b7O08qPJOxFYBBwpSWtlV6AUygZ6hBeUFoMt+
 wapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782275185; x=1782879985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GkTNWaJlEpdfTNbQHfdpKoGmit7yq9Rk0Jg6kafUq8E=;
 b=DgjuF/9ILsmIibI/vXhrBet6IaOHh4z/YWyCg0GYWHK6J3Y+q2RiPJYoOjHw1OjYi4
 m6krYwyXVrPpASiXrRsX+7IlEWUrz0QBE9PMb/934XdVaEls6IWZgGVpopqEyGADmq8D
 vP8Sm+qlpZXjT3vPhAyJBFXvHbJTlaKUd148WI0t05oXyVM853aKJKOPESUeS4NnhleS
 /6oWxB5XjoWBFH0QBLwJW6eziIr1zRo0rVfp7RvRjjj8d0mRO/4EXst8wKkzDD/+ZSHY
 HC3iuJVIGr69NhfEx+25Y67mmn74HwnRuiY3seJ+k0B4Ga+Frd9+605z8tD84eLQakSy
 H6QQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkSfvLLSwuQWRaWTg2wr33LbK0PYXCH0ZZ6HX/y1Ij6Oox0ElQFSZoWEXRy7nlmnQm9Ds=@dpdk.org
X-Gm-Message-State: AOJu0Yy7JYD4HSDHTxRG2ypICZajTjxYNE7gA9iqKyM3M419gHr1gRe9
 CPeeazdSDsXl9BnJECYExW9mMaqRaHyvc5UfXVzFCIap6nat/IohJtE0RPEq9dGapWU=
X-Gm-Gg: AfdE7clkphVBhkgDIjAagrinmK3Ryjo1645Xaj8UYqgnpa89toR020PI/o0hSvus0Xt
 SaDlz7P9Oasuh/Dnr0fKNeed8EuVrEoygb4pJicD5bHdbeRh9ePqlVsw4I2b9OR1G8a1E1PFtMH
 Za5OBP4k3X97e8xmRhZeYzWtEm41Ryku3RrxUFgDWh05dVK8HXOaSt6EZ4QW/MLOTZvJ4p79cTA
 LaTEQ8nPtN134fJmlx7vgvZbBTk9BfJMAvLbuURe8C6kldzbUbUKfZn7CdoccuT3h+2btqm1xxn
 goylAUqMoN9hLuNllg3HifAivilsRBhf4irFvy7cUXa1pMEbRZU18x8D24BuvDcDnkF+GRnKtuX
 vJ9GexItiLooqYjGZ9UhNn74HWWTdsgjvdPJuq7uvbfkkYVRyZEUy0IJZHCftPWnHSSxVaVMrZQ
 uSAVmvKWAIVAnHNS43YovQp+pg6dd5MvR8x5YyfrIWRiYcQsvAY4HIyw==
X-Received: by 2002:a05:690e:1486:b0:663:271f:6d88 with SMTP id
 956f58d0204a3-6636e54b0c3mr1413072d50.49.1782275184947; 
 Tue, 23 Jun 2026 21:26:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66370e08037sm431888d50.11.2026.06.23.21.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 21:26:24 -0700 (PDT)
Date: Tue, 23 Jun 2026 21:26:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: [PATCH v2] examples/l3fwd: dynamic NUMA-aware alloc lcore_conf
Message-ID: <20260623212621.1027df00@phoenix.local>
In-Reply-To: <20260624032357.2153-1-fengchengwen@huawei.com>
References: <20260623032301.17570-1-fengchengwen@huawei.com>
 <20260624032357.2153-1-fengchengwen@huawei.com>
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

On Wed, 24 Jun 2026 11:23:57 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> -extern struct lcore_conf lcore_conf[RTE_MAX_LCORE];
> +extern struct lcore_conf *lcore_conf[RTE_MAX_LCORE];
>  

Since almost no systems have that many cores. Why not allocate it dynamically
based on rte_lcore_count at runtime?
