Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD36CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 15:16:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8726F402E7;
	Wed, 24 Jun 2026 17:16:15 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id A555540150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 17:16:14 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-13810b63a1aso2733760c88.1
 for <dev@dpdk.org>; Wed, 24 Jun 2026 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782314173;
 x=1782918973; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aw9W2lbjlBsH7VQ/ZMwdRpNevD0DOuQM5UGRBELi3ms=;
 b=dr03SLtLF6q65afab7ePFQlKIbxodbqgPvg3bNnZVQGOCJM7qXPRhwGon3BrRwJb5O
 udWIT9NP9FFedT0SyafrN/snILwlIEOhuTOhnvyL7KqVkVLuiGaSa+idwn8ycpxP9Qpj
 qGkDbIjKPzNPvbjh5o0lBiwP4ds2AYPF6jZlu1JmGw9JPnKXvUY+qbdRPQm+q34osCEx
 J9l7csmJlSE3rwdBQHay54ITlIlQi5mM+Ynh5+ogUSNy5E+W7afmfa+V3vbYohEYGsRc
 ujxs6V8XjdFzZYqvvhHPYFgyBqvIAkLsbU6JH8EVuKjjulMGhP8vsC6Pj/7PV8KZjmXb
 RFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782314173; x=1782918973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aw9W2lbjlBsH7VQ/ZMwdRpNevD0DOuQM5UGRBELi3ms=;
 b=I2MkCFTW0yHw2vRaUt1THnc5uoduPxbunuBFHH4CYlfVAVGWmgJKUFESKDcigr5ec4
 HcM3ILgOGYdUOy3Bc2mLtTrAZPKMI6cce3OUAt0Kpoyh3oStILj/RGrGbWTu5n/lkF9g
 NUafJZ1m6vEODbhSksYd3SkVAuBMxvGbNJYlxCUqYXZqJsn5+dNbchKxlRDhQt9czm0E
 HkX3gZgne8GHJs04eBzWzkqre/X6IQlD24lP6zWUZoz+BfyYZosYd5HJGz1Y6bu1W1Lf
 C9Bg0PJSAYrkaU4EidQAzcRyRj4W2LDrI92msSTxTyfx6jDkzom86nk8YvFXVK0bXL70
 5C9w==
X-Gm-Message-State: AOJu0YwSbG6o5ggm3vMWvyYM5BHeGO9RZCEMQf9cAeyPJA4sWtF7dKV/
 M5dI0xP3sA6i2hx5goypXICU3N43t6OMGF6SxnuCKMZFelfekiDJFFjUPc69VHD/bkM=
X-Gm-Gg: AfdE7cm3rwUwmtEYGXFwxyxLRyfANFH33nB77kIgiHFoGn1rjfeOZpx2yKRfRnb3bSF
 XykU1yCzlabqoKb/xFBvrjywK6v0J1XQ61Yiu//W92rIwRtkKUEc4BcyY5fDRGo9P1mr/vLPAVH
 JsRuwpYrbLkJuL04pHFBoPIiZfQgSz870x0APKITUSbt34+gEdZQ5yN2Qc9u6bhs913Z0git1TJ
 zeOAG+gNjPs3z13CIVHaVCrPN9xn1mO8zRyUeD/IAGrjL75sIEwaceLUc1y1SPapkarDyYgahDC
 yvHok09hYG0ZVRvzZeRc3dF21RO1R9io1pyNz5qUO2EFsOqS7ekFrvRGy93kEXedS5KNQyCp1GZ
 wHDBB38eIxNwJLRFVNTMcN8L5aNMUTLOlNlBdpLOV0beCOG1sLi1cfrIbzEWRGpNJvk1qv05Gj6
 il3SGWDUzPE1SFH2xB1aBLk5u1Uzu5niw9BURKxZKi8QMssAaw+HzV5LNPdWjOQT/A
X-Received: by 2002:a05:7300:8ca2:b0:306:f474:7389 with SMTP id
 5a478bee46e88-30c1dc28410mr14253679eec.25.1782314173221; 
 Wed, 24 Jun 2026 08:16:13 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52d669sm89474eec.11.2026.06.24.08.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 08:16:12 -0700 (PDT)
Date: Wed, 24 Jun 2026 08:16:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Samar Yadav <samaryadav5@gmail.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, chenbox@nvidia.com,
 tiwei.bie@intel.com, stable@dpdk.org
Subject: Re: [PATCH] net/virtio-user: fix eventfd sharing in secondary process
Message-ID: <20260624081610.780c4b0f@phoenix.local>
In-Reply-To: <20260624085741.2195573-1-samaryadav5@gmail.com>
References: <20260624085741.2195573-1-samaryadav5@gmail.com>
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

On Wed, 24 Jun 2026 08:57:41 +0000
Samar Yadav <samaryadav5@gmail.com> wrote:

> @@ -865,9 +913,15 @@ virtio_user_dev_uninit(struct virtio_user_dev *dev)
>  
>  	rte_mem_event_callback_unregister(VIRTIO_USER_MEM_EVENT_CLB_NAME, dev);
>  
> +	/*
> +	 * Serialize closing/freeing the kick/call fd arrays against the MP
> +	 * handler, which reads them under the same lock to share them with
> +	 * secondary processes.
> +	 */
> +	pthread_mutex_lock(&dev->mutex);
>  	virtio_user_dev_uninit_notify(dev);
> -
>  	virtio_user_free_vrings(dev);
> +	pthread_mutex_unlock(&dev->mutex);
>  
>  	free(dev->ifname);

Related bug. virtio_user is not initializing mutex as safe between
processes. See rte_thread_mutex_init_shared() vs pthread_mutex_init()
