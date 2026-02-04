Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77567EA7946
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 20:34:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BC8840B94;
	Wed,  4 Feb 2026 21:34:31 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id A103440B92
 for <dev@dpdk.org>; Wed,  4 Feb 2026 21:34:30 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-43621bf67ceso5278f8f.2
 for <dev@dpdk.org>; Wed, 04 Feb 2026 12:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770237270;
 x=1770842070; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hxw/mPPqBcuJVyuodRoAQ9nPwBOfKeUNxu/jpRCuis4=;
 b=CJ6TBfdcJ2u4C3BvIog8EEpPF1pO6i9GRG6LWe36bbVhokjYK/oMeahDdIOR5LkADj
 Tn23Zn6KrA8M5cJfrn/B7HHLeRwTXq+w2RIksYlPLl7W/Z/qXo1kY7YO5u174kH+p1hM
 SN6D0YG6u/QtsxFHBVnV9vhVX0iSYC7oLRpdpgF9rfpGvKkabs9rFeJcdY+MshYiaf5A
 awetUPdHHL8+npN5cUdMQwJHqeAlYAtwiU3ktmhq6lBXP8lNQgZEzfzkFzgyqi0zNzog
 5Q0KphDjUceNnT5S6IEASIezFXvAGowlzTHK/fOFR6kJ9OO+UL9dTBw/Xh+pqWa9dVzF
 e6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770237270; x=1770842070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hxw/mPPqBcuJVyuodRoAQ9nPwBOfKeUNxu/jpRCuis4=;
 b=DRZEvF2nky3xZ7pkdqI7Le0hZpoeajuNZYdUHH6WsoXwK7YRS/foljRLn9/x8OILtx
 wYa+vO8z+Sc2gzg+RAY+x9WL9xGpSZPW6cbCdp6rENRtUKvJfadvjGGNfZdBYvNF2s+0
 /W/dP+XezJ2dFXbwSjaO3qcELHW1y/29IUf3QkEN1hZSuowKkaGR7AtGMtuD9T8B0HyE
 wBgW+a8Nc7PXGPeLW7/EwHQeuNskxXCbV/5DuP5D6qWl81IO/FX/ufpHAPuCW8RNxpmw
 EL/L55nmPxNRDt5KCT+JYmU8wQhVff6mNYlkr2lcydqXczNuVvD0iDyNU63iJAvSbh9O
 zySA==
X-Gm-Message-State: AOJu0Yzeqr1iJNB1sufIQvUahso7g5cqgKG5gwd11Lyuxkkm4SiTdtYA
 hc0Y7iYN6RLdeaeRmVRAZMpFTHopjdatVFVI8UJ+15ig09qEkQqNg36dGThLGgGjMuA=
X-Gm-Gg: AZuq6aIu93WBial98GrsoT8ZHOGw6OaKAHjEWWYiwakRPfuCH66wYEA69i9BZjKOsTO
 a0cjpOzigJs7AiRXCFwWXToH86z6W3AHWN6GRWrpl3/GfnSE4JkHGYdYqYRlyO9GKGhCko2aQL/
 ILoL2pqx2jPZKpPZ72m67EsX2zoAsXFqaVPPM3i5PkwtI9jUPnPeYnbrKhHedh1aFai0yUc6CYw
 88Rw7eGBG7gMrGWZKLv6AmzN7uvZMRys1MStGSAtgPAYzgZptdlCSv5ICgdyT6bdhGLT2PC3gFn
 myL+rC8u/UncVNLMaS9lnHdft7bSoQzl1xk6v1Dz3gCi1VONdBEY3HfYXm3+IZ1ZDuqs/8C9dE1
 28c2WDDrOcDZ0ZwwFB0zLGZvf95/EZKMU7+904F96fDHy6ddHWS8Ue1/gcp501TVFQVZJ2gwNm/
 WkHjfQDO6/+ThJ94YzNlYFVMTdQXCmrImQR45TlcZJGhkkEAGSvKty
X-Received: by 2002:a05:6000:2909:b0:436:14d2:540c with SMTP id
 ffacd0b85a97d-43617e43139mr6342053f8f.25.1770237270077; 
 Wed, 04 Feb 2026 12:34:30 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436180659b8sm8296880f8f.43.2026.02.04.12.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 12:34:29 -0800 (PST)
Date: Wed, 4 Feb 2026 12:34:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yehor Malikov <malikovyehor@gmail.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, chenbox@nvidia.com, Yehor
 Malikov <Yehor.Malikov@solidigm.com>
Subject: Re: [PATCH v3] vhost: fix use-after-free in fdset during shutdown
Message-ID: <20260204123424.6ff763cc@phoenix.local>
In-Reply-To: <20260204185800.9299-1-malikovyehor@gmail.com>
References: <20260204184848.9104-1-Yehor.Malikov@solidigm.com>
 <20260204185800.9299-1-malikovyehor@gmail.com>
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

On Wed,  4 Feb 2026 19:58:00 +0100
Yehor Malikov <malikovyehor@gmail.com> wrote:

> +	/* Remove from global fdsets list */
> +	pthread_mutex_lock(&fdsets_mutex);
> +	for (i = 0; i < MAX_FDSETS; i++) {
> +		if (fdsets[i] == pfdset) {
> +			fdsets[i] = NULL;
> +			break;
> +		}
> +	}
> +	pthread_mutex_unlock(&fdsets_mutex);
> +
> +	/* Free the fdset */
> +	rte_free(pfdset);
> +}
> +

Calling mutex_lock in destructor seems it could be a problem.
Also, I would put in a destructor unless the init was called
by a constructor.
