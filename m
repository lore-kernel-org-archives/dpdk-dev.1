Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1F0C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 16:13:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5515F40B94;
	Wed,  9 Jul 2025 18:13:44 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 19F284028C
 for <dev@dpdk.org>; Wed,  9 Jul 2025 18:13:43 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b3bad2f99f5so144077a12.1
 for <dev@dpdk.org>; Wed, 09 Jul 2025 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752077622;
 x=1752682422; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9BSpAQasDg3xbgEXgO0rnBAk3tww6kZc1j/376j0l4=;
 b=Aj8FXQwAvbdn7aZ9oE/dbD6vAebaBXTNM/QtNhOHgF2+qLanltX5UOSaY/744DuXq4
 T4xyCzdjAwe1m9PKPa9vH+XFnff0/TI3wogHD3AULtDKozP4yABvUYpMHm5tVYFRlLK1
 hcrUJE6NGFmGScC97g6NNu0m00vAE65SukSPku9X2GVGfqV4uavapmYrbAoYryfIarN0
 Z0NPkeZvZaFY9YjxbkQ4Op7EB8B0v3FA/WfBaYqSkVy5G4Ey4w2kRgN52Dnfmqlwaf+M
 n6HBmsNHXCk5eFLHldU1WHSMPqU1ukJ/cZKvTdwyzsYVTDCGRIHDolOkT/N1JmE/0hyZ
 V/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752077622; x=1752682422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9BSpAQasDg3xbgEXgO0rnBAk3tww6kZc1j/376j0l4=;
 b=VA0n+4Qi/Lx+3PyNs2OAI4wOuqhwtm0FJsrIoWnmVZlU0HuasnIxvA5p/QI0r3RMsW
 nLvuSwslVagFo1S3SqxdPmXqNTDs80/mBuK8CaIsiuDIlr42R9uZrRFH0SzO2uwl+LLy
 c8cPU2qy1SdBj9ItGovaUaq44tJvQ5gX57ZnfNz09aEStqMSKy0gmFjFtG4mwp2/l3FF
 VkQmRu5icvXVb9m20mXrM0/LcEm584DOr94vrfwUDJKeKv1DjRQcFSCEnAPOh70Tpw5L
 cxvHMMp3bb9tw20rtqXmi4HECETzqY474rSa+QNVRgg8CsTc2V58iuNZ7SxX4wblzUGE
 fSeA==
X-Gm-Message-State: AOJu0YzBEit5hRdqw/s+1MBM30N6ABcZVR8KxQ3oEJAiP0PogRE6poi9
 sKf4rMg3E06PiYlevIrYqRwnRelYUq1/wlMXQLEFOY1rfoget11IvFfKHexpejiXTpjEIUEZS88
 fNa85
X-Gm-Gg: ASbGncv1LHAGIqBHb0xQVQyiVzH7NLKYRiHeiZei51IRHeRxjEdrd6dJ/fQBRw18ooB
 UJ+7IxIcbWgu8bgyivlr8oDNYFxM+GzJs0TCTeWI+Z0iGaXx8DDO+Kzhek4m8qNMUglYFqrwTzQ
 Mqw1dIoyAvIJqzAeq/DL+aRKAg6eL34tWLi0a7w7i/jr4iprgaOPMxCXOWMeZ0kXXpeoBW57NGE
 2GCxsvt+C56dySFLeMwur4KtIAKzR0S9mHI3m9FM3OWt+5tQHXpZKoLloG0E6DksTFn/4EVinhb
 m9xV+tY57x+IFNMazOqSLxXzHfxJJX+BW6StpbCxJvCEk7XAaBUi+WUKZSP6X55BNfp6WSidg1X
 tBf+XuE80/KYqFpSjTDiV1toXPmyfZIvcEMRfK8A=
X-Google-Smtp-Source: AGHT+IEriurZt72NsvgjKt5cMmYKk6PoR+NVjwiXwycLbk8LeQDmFW1yseen1xhJIWWqn0sSNJaVOQ==
X-Received: by 2002:a17:902:d4c3:b0:234:1e11:95a3 with SMTP id
 d9443c01a7336-23de2fc72f0mr605745ad.13.1752077621992; 
 Wed, 09 Jul 2025 09:13:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8457b2d9sm139625285ad.161.2025.07.09.09.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 09:13:41 -0700 (PDT)
Date: Wed, 9 Jul 2025 09:09:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 04/14] net/sxe: add link, flow ctrl, mac ops, mtu ops
 function
Message-ID: <20250709090930.10bb8130@hermes.local>
In-Reply-To: <20250709084315.9940-4-liujie5@linkdatatechnology.com>
References: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
 <20250709084315.9940-1-liujie5@linkdatatechnology.com>
 <20250709084315.9940-4-liujie5@linkdatatechnology.com>
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

On Wed,  9 Jul 2025 04:43:04 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +	RTE_ATOMIC(bool)link_thread_running;
> +	RTE_ATOMIC(bool)is_stopping;

Despite what checkpatch says, need space here:
	RTE_ATOMIC(bool) is_stopping;

> +	rte_thread_t link_thread_tid;
> +	rte_atomic32_t link_thread_running;

Don't use old rte atomics, instead use RTE_ATOMIC() consistently

> +	rte_atomic32_t is_stopping;
> +	pthread_t link_thread_tid;

Two struct elements with same name, how does that work?

> +	bool is_stopped;
