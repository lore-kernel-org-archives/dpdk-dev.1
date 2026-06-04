Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B561CD6E6D
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 15:20:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68CAD402CC;
	Thu,  4 Jun 2026 17:20:16 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id F1B9E402B6
 for <dev@dpdk.org>; Thu,  4 Jun 2026 17:20:14 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1363e78746eso882143c88.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780586414;
 x=1781191214; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CW4rsb7xdCiNlVeBu8of/ebJ+Sho/g8vJwpgRpVo6wo=;
 b=evoui4c1+2b4oebrNoPd1AvVr96xIpSpPMAXF1D8PmOgDcXUDjQ2DSElRq3yDd3t6c
 NqA2aZSkRnjKVhoLftEk3q4qAOD99ekcACROtPYsVlNtW/pGEeh8o1JS9OdckPLXH4ro
 UoUXOlUmGYjZofwX86j6dj0O2y+t0Pku2Tn9Z3PNFBhNMuRUgnvAX1T9y4gBTLsF3+Tx
 UEQn/qFgCOqJ6CsIyuvJp8Q4e1KncfhEEKD6CKhbn8OaVhosDNLgYgxL6lUKJJ1SsIkN
 9lfeuvZmd8T9zISoPlnbs1G923MgZub8HVv9uFCPHc3nQc5tFaaZX9Z4iAYkrbNUr62y
 RRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780586414; x=1781191214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CW4rsb7xdCiNlVeBu8of/ebJ+Sho/g8vJwpgRpVo6wo=;
 b=ljm3HJ+cA8Q88vGObkux/5TCn0BlfGv8nKQEx+xwcmL/Juth5Y4CtMoX5+BlKJW311
 hBwmNHvKJJuFWPqF9TpnNb+ZcH0kIT+f+uTAxz80Z3J+Q46kc1btvw6+2sxeNRqjCU5V
 WPJ6DO/7njlswnZK8YYnBSSNQBWnXJMvnOyZFVvLJBf8gz9p36n39IVT57EKqevb0HWs
 Pp2PuJP3aVe11P1vFmbm4Oy6yFPb4encHEqvC6wAaf2mJ8zClLs7EC1D+khH4CDwzzE/
 b2/zB/ZM4/EdcD6e3E5JFaZuoM0OFDHcBERdd52l3sjCwkClEvzPxWVGpU/tRnDwlqCm
 tUcg==
X-Gm-Message-State: AOJu0YzWCSGW2coSAIi1+bX2VQx9t7mYota4jNcXu4b1Ee0s1UmNL/BE
 u4H7Ggywz4TX/LSkXV8krNsew9Z70AardgZCG4F4nQYmCnzStNpJk1AB9wiQV96kZo4=
X-Gm-Gg: Acq92OHDpNvD+SEcOv1L7PWlcH6e1RjhUGL9vmVdSuIc2V5yudX2bEazS96KnB4ECsL
 kXKELv4hgCMmoiD2W2OmfwRzm7CvhuqDe7xU7wuHiZ3/4wOlM52mMr4Fp8s8zbo6GnCsM0gw7iG
 ubhlFx6sdqu7X5Kkm0p4EiZChtIR8uNI33+sAubuiZB5RE/kqH6vD6HKmlte/F07Jra5jbfYJnb
 9nQl6VsaNVmoDMrr+X//JEgJ8rxk5i9xnPCT/mXi6XnN5goeEiONlSHmglQlQ89aOtFxSxxgjK3
 sC687T1k6CeHYBAa5rt9hxFcSISUb6WZul7LqnE/AHbsgxtt8J179pE73DfPyB73Hs0USK3wcTS
 GFgVL35zmqzKGTb2OkVV4YFUP5yaEKLIHf9/nj7y8nZrICaUczCMHdl8ZC5o+ub048HdTApg3Iw
 NsJ16NUwxTVZptGbZFZI1z7yybteudxQoBOEEbFPRqE8fUYFFjxuB/n4PjnW0mItxUzOaLM4pxb
 SV+rrhpnzgGSw==
X-Received: by 2002:a05:7022:459a:b0:137:e45d:7c3e with SMTP id
 a92af1059eb24-137f6c0ac16mr3167327c88.25.1780586413394; 
 Thu, 04 Jun 2026 08:20:13 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm4099106c88.14.2026.06.04.08.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:20:13 -0700 (PDT)
Date: Thu, 4 Jun 2026 08:20:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
Subject: Re: [PATCH 2/5] ring: use GCC builtin as alternative to rte_atomic32
Message-ID: <20260604082010.1fe8a27d@phoenix.local>
In-Reply-To: <d65ce1df239445e0bb795c852e075b1a@huawei.com>
References: <20260602171552.686349-1-stephen@networkplumber.org>
 <20260602171552.686349-3-stephen@networkplumber.org>
 <d65ce1df239445e0bb795c852e075b1a@huawei.com>
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

On Thu, 4 Jun 2026 15:11:25 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> >  /**
> >   * @internal This is a helper function that moves the producer/consumer head
> >   *    optimized for single threaded case
> > @@ -82,7 +81,7 @@ __rte_ring_headtail_move_head_st(struct rte_ring_headtail
> > *d,
> >  	/* Single producer: only this thread writes d->head,
> >  	 * so a relaxed load is sufficient.
> >  	 */
> > -	*old_head = rte_atomic_load_explicit(&d->head,
> > rte_memory_order_relaxed);
> > +	*old_head = rte_atomic_load_explicit(&d->head,
> > 	rte_memory_order_acquire);  
> 
> Not sure, why it had changed to 'acquire' here?
> Looks like just patch splitting mistake, no?

I should have kept it as relaxed for the first load.
