Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4223CCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:11:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97A1640663;
	Fri, 24 Oct 2025 19:11:30 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 544724065B
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:29 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-79ef9d1805fso2619784b3a.1
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761325888;
 x=1761930688; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+E3SBicyLAlkNJsMna5uncvIBfB4M+/7P7y03iRAcl0=;
 b=vD+BArurJz6QUor4JO5RarmbwPzzn4iL6jyg4e3H2bFbDJAII5/GEEOStb8uzuqNo4
 rzcJY05uFZn2Xo1zobvz8wriM7Gz7QOYJ16EuFV06fnJdtKoLF6hhaaMAyxf93E8elO3
 Z9+PmV+SRpaTqSBkUtKGDMFev62zzndBIQP4ofQqUUIgX4oS42tD3k85is62T7EI6BzI
 fAXrydUV8vkSKsJpgEp1QuSzyEPGOFh3g/fFFKAZfDvxoInN+5PSss7oKgGQeVnYdsFp
 T3W9Lnu/PYpR+Khw0Bnz2NyTio2uvuTNnRPiaX0Of8TESRWLATzWsB0Py0O6s30BzvCo
 Wj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761325888; x=1761930688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+E3SBicyLAlkNJsMna5uncvIBfB4M+/7P7y03iRAcl0=;
 b=C5kbLyP6m9rS0wEOZbJqbTBCHAeI5x3um9fzNiabhzL/dWEH5Cc1MPS6pPgQ6cSjJX
 yqcAAgjYA1npQVbIRrrnYhakTOtYrHN00BpOYNe0Ztf/1axUr8skP4Lm5MZcqy3M6+4d
 +bRIAyEdE5Or6BuRuMtRUX9dlaL722ufW1HF4TY+BF2l0htnOo46KUyROpXHWj3Z1FSK
 hpHLYxvMFP9fP6iocoyDvp+f1m9wI+z/itaHxg8HWm0xS5dIvE4chwZ/88KoBwt3fdQZ
 llXArYhUfc7sy3WCF6tgcquAaKTJ3l3dlpP4lk/MAi+SJJur/XsbVFm/HPkk3NMUj7AY
 hGYA==
X-Gm-Message-State: AOJu0YxL7sn3/QO/f+aMHGsW6UxVVw36F8ltzUPChxo6DQTKRenq2Tf/
 yLRfB/OHKovI9jQsCELN1R/1ew5T9XwvJgnjZHBMUES0mZ3g449ilohV0AAcTDQkSX8=
X-Gm-Gg: ASbGnctXfSt9WBLWAgmG9SH8tdkg+7nIdjxk6IHACNn7jj/PJdz2r5zNM3dE2rQ5Gvi
 Y7ofDXxTlAccjEhbPHF28ixqdl3hoKHxx0wdAhh92BiTUY5jKW3jkdv9a0PMlidzc3Ib3DDK51Q
 n3YleOmdnVfEK0ZxqYbkE2R7YQny5Be3tHFmPN3gup6j/uuwKbmDbP8SxBhkcZkLdqKEpFn/VVq
 3Xe4qWkacs6aIgcqMuINeId4KyB5e/VK9ygd1Hh713TaDYF/F0qJuEsxA0KacGJ8abYywXdPRDH
 EPH0aEVz1bC09+Sy57cUxuiL2MISF7zy4xvOWJRAp195rx4ruI8nebqvMhm5hGCIiPmwuw2yfzq
 sbBpzitkTl5zVgNA+TJZoAGxyPGIjLWur9/Tdv25ElXAUdcbsIXY4FZw/hn9MbOprumw2H4ArAL
 Ddq1BOVhqJHAG1INrcEdgMQY7LLewTW2jXkw==
X-Google-Smtp-Source: AGHT+IHNT4Cif0f3OTw8vTKVlJu+IZSafEE0TmTjCIZYwSQO+CnEygi2gI0mobsIcWabStdNxmx+ZA==
X-Received: by 2002:a05:6a00:cc9:b0:781:171c:54e3 with SMTP id
 d2e1a72fcca58-7a274b85d2bmr7155142b3a.2.1761325888475; 
 Fri, 24 Oct 2025 10:11:28 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a27d583970sm4669776b3a.51.2025.10.24.10.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:11:28 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:03:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 13/13] net/sxe: add virtual function
Message-ID: <20251024100358.65e20a61@phoenix>
In-Reply-To: <20250728090517.1811244-13-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-13-liujie5@linkdatatechnology.com>
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

On Mon, 28 Jul 2025 17:05:17 +0800
liujie5@linkdatatechnology.com wrote:

> +#ifdef ETH_DEV_OPS_MONITOR
> +	.get_monitor_addr	 = sxe_monitor_addr_get,
> +#endif
> +#ifdef ETH_DEV_OPS_HAS_DESC_RELATE
> +	.rx_descriptor_status = sxevf_rx_descriptor_status,
> +	.tx_descriptor_status = sxevf_tx_descriptor_status,
> +#ifdef ETH_DEV_RX_DESC_DONE
> +	.rx_descriptor_done   = sxevf_rx_descriptor_done,
> +#endif
> +#endif
> +};
> +

Please don't add so many #ifdef.
The new driver is going to only be for the current version of the
DPDK, we don't want to keep all the ETH_DEV_OPS_XXX ifdef's.
