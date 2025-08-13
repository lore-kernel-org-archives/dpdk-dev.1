Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF74ECA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 15:20:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F29540ED0;
	Wed, 13 Aug 2025 17:20:49 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 559DA40657
 for <dev@dpdk.org>; Wed, 13 Aug 2025 17:20:47 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3b916fda762so555916f8f.0
 for <dev@dpdk.org>; Wed, 13 Aug 2025 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755098447;
 x=1755703247; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c3NT1y2lDvQzPiWh2wdyyliN2ACcacLLipaQLZy5Fyc=;
 b=NpFr0i33kU9CXrGR2RhD2jgB/7oeMPyfuo1VYPVmmZGXuTTD2NKF4JPieZB+NqlEJu
 Zyb9IKhYNjj8aSqqQuXWM/ASatXXLTHOCLPO0fRgkpQlQ5TGF0n6XIYAI4pJTIF0LhUn
 0sE5lTFXZAkY95AX7ELpkVspG+QOTV2ZhClXNkrRRH2vsiLknJ73UlRBWnwaB3+DVTNI
 xa7PfLZsDMN8l3I6k7mpBStUVUN5ZiLBManNHeqIl++EBEZm9K8f2RxR/RX9vyeefvRU
 uSSiY23nLuHBItnnsqEm8XgDWuJtIjKoMTKTEHl0Z8shFtsL2y2v/SoNpRV0fydusfcY
 hFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755098447; x=1755703247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c3NT1y2lDvQzPiWh2wdyyliN2ACcacLLipaQLZy5Fyc=;
 b=ZNS44NweHbH9zvR9MzmJD+nk3AVgcJ9LCrAhQIsDOMIQGJPF+GGxmHIttbIXYOK/Es
 bdbwwbvVanDEXP6LBwKBzMIam4nH13x1uyi52/no1X4OfpUt/uYN7i6ZxOJ/02lOqOLm
 LfSSXp+iNoab7r2ylQQOPYfe14+O3FkHgfOS/EsTddNiaRNkFW6wihOUDwOEnZubb3W4
 7jUcmGGRS1ESXZFKweR7h42rZaNH2tNPZDxU3guwB+8pno4xRtZ56qXYN6Mbwv6+Dz4B
 y7aIdImTL2FqIPqqrN+0wepvwV4dEv1SZ4BjXr3HpYKC0ca/YlgE5p3e0znB7uMY+Wo2
 qZFg==
X-Gm-Message-State: AOJu0YwSqCynSRA/hzIEN3fY6nTPFYekj58VQ+vHajGW6X4ndeYBaaHh
 AOP5UzbO3rkj9oisH5/X7Rixjb5mql24hndrxz+MhCLL4Yv8RGQNe0hRtW/oIo0zTwI=
X-Gm-Gg: ASbGnct2XTqjNoiYuhePbGt55aQX5ghLkGI7TGfPytjEYZhYuUudVKJggKhBo8ZS0bn
 DpFEtLJV9GCoCupLQc0CNm3IyfJaVEjTeOnymCuI0KVqG1kkBTm407lV8fPRYdQ6RfwOFw2zX82
 fkMOX8fBKn43u0+pL8sMuK4oGPEda6l+UQVM2KPuKh/4S5P87zgO2NTkzYYjVq3/bco3yTovf6r
 N8o2KGouhaE5gyhdCD6OLbTZt44I3cTE0jwYH3kZcVTG6ngBw0cSZ8CpEvksusfpcvSu+kK/eDW
 1u+d+efljwnzWAmyumw/mBC8c/F10eQAFeDeQ8cYrFvlPTSLzFoHn3scAbhbgrn7kmTylv+B7nN
 AYs04opKa4XEknAoXWsvANWWwx69uwBtPazxJIeySAnDDsFHEs6LFhteCIpEcqNRhXXeWQpxaWC
 Q=
X-Google-Smtp-Source: AGHT+IGDx+3boo1e9ZcarICcW0J+VzF5UfNez+DpAn4ImNPPAt65G0HPczGftPYJHcKk1tnVFBUpYA==
X-Received: by 2002:a05:6000:228a:b0:3b7:8071:f902 with SMTP id
 ffacd0b85a97d-3b918cbb682mr2478447f8f.13.1755098446846; 
 Wed, 13 Aug 2025 08:20:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4530a8sm47828291f8f.38.2025.08.13.08.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 08:20:46 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:20:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Andy
 Moreton <andy.moreton@amd.com>, Pieter Jansen Van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>, stable@dpdk.org
Subject: Re: [PATCH 1/1] common/sfc_efx/base: revise legacy port controls on
 Medford4
Message-ID: <20250813082041.3edfc0fa@hermes.local>
In-Reply-To: <20250813123636.16363-1-ivan.malov@arknetworks.am>
References: <20250813123636.16363-1-ivan.malov@arknetworks.am>
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

On Wed, 13 Aug 2025 16:36:36 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> Theoretically, adaptor firmware may not support new netport API. Currently,
> efx_np_supported() assumes Medford4 always supports the API, however, this
> can be improved in the future by checking some capability bit during probe.
> 
> If efx_np_supported() returns B_FALSE, then one should not invoke Medford4
> PHY and MAC methods that are inherently dependent on new netport API. Pick
> EF10-generic PHY and MAC methods in this case to maintain legacy behaviour.
> 
> Fixes: 8dac31d073af ("common/sfc_efx/base: introduce Medford4 stub for MAC methods")
> Fixes: d65a7129c413 ("common/sfc_efx/base: introduce Medford4 stub for PHY methods")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> Reviewed-by: Andy Moreton <andy.moreton@amd.com>
> ---

Applied to next-net
