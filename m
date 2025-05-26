Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA3C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 21:14:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20AFD40653;
	Mon, 26 May 2025 23:14:07 +0200 (CEST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42]) by mails.dpdk.org (Postfix) with ESMTP id 794FD402B5
 for <dev@dpdk.org>; Mon, 26 May 2025 23:14:06 +0200 (CEST)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-ad5740dd20eso404979866b.0
 for <dev@dpdk.org>; Mon, 26 May 2025 14:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748294046;
 x=1748898846; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=92oh9o4h+FMe52u2IgQCQPoGnbx7/4V+JJyZXAmbikA=;
 b=SqD63SG+JUmzSAPFjQqjri4nbXIgxhX3AmsU+3gQrY67aVrU3xQxcJKo9S5at6Cde1
 WNlccTaQnbifbSr/2A4pe0mNq2BBimXyYcdwMF52vxgxyUabW51tYyiun4IaDvu0um5H
 DhCCDxQGZuF0+wSbAyridj9kbCq0opYM9LhqrarvgfZk8wKzemmhh+hNGPUs8YYcVhH5
 Of7g2s+LFNcSRWMxGwuc+hmtYcNweB86VfnMQMpDSACoO+fPzMTbFQTfxTOHLwiDijN6
 6gk9kCGL3pH9/4vdzWOSEAGNQuu9cbiOXcwtfmb7HYqCTsUVsHL73FP3y8WAUP4l6EtN
 PMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748294046; x=1748898846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=92oh9o4h+FMe52u2IgQCQPoGnbx7/4V+JJyZXAmbikA=;
 b=HdkTWLXJCOvUHbK2ryeuSfepwTvHRVeCkBdsBEMfIa/O6fp22+amSA5UBJJjwd+1xi
 o45er+Bey8u5wYadYhdgTyUwY190JBljjBWSIRYFGANPUSYOR7qI4dwYVZ60PGWOog1M
 PyiA4nd2MbfswLXlMSenm7jWFmW88Kr9NymVZ+laIZ8MDLNNuwwTLYp6w5zJEmbGOLr8
 iiCk+jMeQCxDqa9RaeY8XUcIxHxue2O+/Bt7sbkqi7kOfP7jk1/FV5Fr0+Xs3u9qwLlq
 aq3t51QstbSTOeNI52yzHem3jBCi1TTZDs8sP0iOPP2k+gIk4OccuNw4NIf6X33vl6aE
 tlrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL6MhE3j5IhAm7rOmIV4CPRFSniJxQHj/QSYidzyc1exE0xHRjd4Zb4n5Sa8QreihpbmY=@dpdk.org
X-Gm-Message-State: AOJu0YyONcqLAU+7OT8OaZrl4OZPDcLEWIQkASU7Px5fv6Uqv6LpUey4
 FzWyZtkCystezsmmvBFgqSgdMzkrZ2EZJUMqZjdcVobBIXBHerMwmaxTealbbfmqadZ8GML19sJ
 Y1Ia9uh0=
X-Gm-Gg: ASbGnculW/JhAFCvDgPHGsTP+qniuNbFLdE0fT3hWS6x9/tu7fyXqRXnFJmDSFVqfwm
 wX7UW9yP+fR2Ol5W2P5YQDxva1kwDJ+bwUgOvTU6QnnqYpLODK9iq3upopNnP24HoFiwRi8q80W
 QimeD8GQ0s52G11mA6nVpOCK99pKbMAmLGElplN2ZdivH1pwZrGnW6Ub01Omrjgyn7lVvqDPjmY
 D7lAFhcJOLossg9EyBiVfr6YL6W8RY2OgNvkls2L6Pt2UVgH+c2e2UtRx6mIg+wgkTxJgL+cmZs
 nfOTV5E7JGiHntY/DF94uPLxAKslCQaEtZrc23x7JRyafa//ABYvEf7oTGlDBlxD7MsUTC+oex4
 gd5ajSTwR3vAvYIKmedSBMSWszfez
X-Google-Smtp-Source: AGHT+IFAGe3xazn8//hoSwRa+Hvucf0iGhCYXLYNnibOmPPzwnmsxZzXVKykfj4XZpIIABeJecnshQ==
X-Received: by 2002:a17:906:f587:b0:ad5:6d1a:6fa4 with SMTP id
 a640c23a62f3a-ad85b22bbfdmr903195666b.44.1748294046042; 
 Mon, 26 May 2025 14:14:06 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d43840esm1724960466b.87.2025.05.26.14.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 14:14:05 -0700 (PDT)
Date: Mon, 26 May 2025 14:14:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gongming Chen <chengongming1900@outlook.com>
Cc: maxime.coquelin@redhat.com, chenbox@nvidia.com, dev@dpdk.org, Gongming
 Chen <chengm11@chinatelecom.cn>, stable@dpdk.org
Subject: Re: [PATCH v4] vhost: fix crash caused by accessing a freed vsocket
Message-ID: <20250526141400.552bd764@hermes.local>
In-Reply-To: <TYAP286MB06491A9489C631C9D6EEA2FFD8DA2@TYAP286MB0649.JPNP286.PROD.OUTLOOK.COM>
References: <TYAP286MB06494783C3973058BF499642D83D2@TYAP286MB0649.JPNP286.PROD.OUTLOOK.COM>
 <TYAP286MB06491A9489C631C9D6EEA2FFD8DA2@TYAP286MB0649.JPNP286.PROD.OUTLOOK.COM>
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

On Mon,  8 Jul 2024 12:41:03 +0800
Gongming Chen <chengongming1900@outlook.com> wrote:

> diff --git a/lib/vhost/vhost_thread.c b/lib/vhost/vhost_thread.c
> new file mode 100644
> index 0000000000..f3ff182976
> --- /dev/null
> +++ b/lib/vhost/vhost_thread.c
> @@ -0,0 +1,33 @@
> +#include <rte_rwlock.h>
> +
> +#include "vhost_thread.h"
> +
> +static rte_rwlock_t vhost_thread_lock = RTE_RWLOCK_INITIALIZER;
> +
> +void
> +vhost_thread_read_lock(void)
> +	__rte_no_thread_safety_analysis
> +{
> +	rte_rwlock_read_lock(&vhost_thread_lock);
> +}
> +
> +void
> +vhost_thread_read_unlock(void)
> +	__rte_no_thread_safety_analysis
> +{
> +	rte_rwlock_read_unlock(&vhost_thread_lock);
> +}
> +
> +void
> +vhost_thread_write_lock(void)
> +	__rte_no_thread_safety_analysis
> +{
> +	rte_rwlock_write_lock(&vhost_thread_lock);
> +}
> +
> +void
> +vhost_thread_write_unlock(void)
> +	__rte_no_thread_safety_analysis
> +{
> +	rte_rwlock_write_unlock(&vhost_thread_lock);
> +}

Looking at the back catalog and spotted this.

What is the reason for moving all the vhost_thread locks into a file?
Also turning off thread safety is a bad idea.
And mixing DPDK locks with pthread mutex is not wise either.

This is not going to be critical path so why not use a pthread_mutex?
