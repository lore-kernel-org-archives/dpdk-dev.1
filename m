Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFB7C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 21:47:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F45F402EF;
	Fri,  1 Aug 2025 23:47:11 +0200 (CEST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com
 [209.85.219.171])
 by mails.dpdk.org (Postfix) with ESMTP id 0F6294028F
 for <dev@dpdk.org>; Fri,  1 Aug 2025 23:47:09 +0200 (CEST)
Received: by mail-yb1-f171.google.com with SMTP id
 3f1490d57ef6-e8e0c6f1707so2057243276.0
 for <dev@dpdk.org>; Fri, 01 Aug 2025 14:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754084829;
 x=1754689629; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTj6iRKqHIe9jOYcmdVU970e1HIRSGTMDSv6v04DeCw=;
 b=TBzYro9IN1ZScfz0JEnJLnkWuyzn0yUU1mjs+smVyDhEQwNg10B62iF7Itm5AhvLGP
 g0QG05AxFaIRtw57YlnW7XD04JjZBSC90G3Cjbr39o2CjLi15vECjDPoB1NgmEPu3K3X
 m3JLm3d3MrmEDCsN7KvqFdub/fPSlbbBwbIxFWvm+1Lqozyn1+AhoIgalAPmcqSxWnvI
 KPtnRtC4cOX6ToYG3AHyXgq3MQkxdG3SMyje79ygn4BMQ0hm9BFvo3Ne1cMHrn2YfWDR
 mNpEFmGvuO+sU7HRU9N2w/hftdggv+lUKQCEyttIkVO4wA69Z74+EvRHoSCixWCxB4hz
 PQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754084829; x=1754689629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NTj6iRKqHIe9jOYcmdVU970e1HIRSGTMDSv6v04DeCw=;
 b=DBp/+5XMaL/zk8vBBrpZuLv+CTt9mxZzvcKC6ADyvSypoTFZvjZ08ekkE1uCu4/bTW
 UJt5OTHZdGGkwxyKCQqBMQZIKQkYxtnHkaqLzXg259HOG5wBdza4vFTqsVYmQhVznGlK
 Sz7cnVzsR/opKTJNUB5tmh+BA0Kqu6V2PHiQGVY8fDQVGgJ15Dmmksn1hBIaWvlBSz0O
 DpYmYPXLJaWKTSuF3VQRixarP8PfpmHe3emQjLOFNzPHiLFHAs/twvgTt1dwrhdZ7EEY
 GpCg2JmxD67mijbU1xYOi4AfH/IRBKQHfclDx4zpcJIF3Xbc72HPsPzQSUWYRDlcU4GR
 IkGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBGGaWk3QAJobvFqF1QvQ7Xp2155GY3ACzQ/i+M1JVhBTc9owgcanKB9mAUko8/3LVwEE=@dpdk.org
X-Gm-Message-State: AOJu0Yybqo/VPaK0lXqse9met0nmJ9sT+7lLV9f41nlgbrQBLePeDz7p
 HZikCP8jhRBhtbnktYDEl31RX5KtBGlgpvErG4WouaZYBFPkrTqgd3YQsSNE8zKA4vM=
X-Gm-Gg: ASbGncvYieP7qdS/KdSoGyxLhr5B4zvu7f1oNMgquLsCXKRbQz2LBjgOiNS7jJuf9Y6
 l9lJKJNkhnsKe97tplY6nRmF1G11IcL5E+xsO6j43+PDThMb0wfHWmYtIp20JyeWUn6XQ0BCUZv
 0E5P266kwRGw0TZHL0wX6yVM4V1fpQ5UfRmiLCGNwDEIYGGeAx/F7tgI5+d+XuXv2NL8i81P/s6
 wYSyVEqD9G7gk0BQlWo6NSL26mMMySa5Nvqh8+I/L0RBZZJANQVCOHCV+ppKkGE60E19w0mOZTW
 9BJEVXN62xv11wVnZhIjegwk2BFQWnHdY/cZRtekXLVtPOdVZ++UU8r181zEKlRTYst1NxHt/B+
 nb5iPp0flnkvJXslfIpgHXQMQHMKsNJ9DjdfBvVLn0UNIEo4ORD34knU/5rwRYb9TX9FOcJ2RCC
 w=
X-Google-Smtp-Source: AGHT+IFf5q2aloKNPSSP1BvLmE8rGYDGde60AR/7UlqB6Ku9GrMTxAT45zs/5WZHUUROU3+Q4vpmsA==
X-Received: by 2002:a05:6902:13cf:b0:e8d:f87f:2b18 with SMTP id
 3f1490d57ef6-e8fee08bf42mr1571055276.40.1754084829141; 
 Fri, 01 Aug 2025 14:47:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e8fe61e6544sm746537276.32.2025.08.01.14.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 14:47:08 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:47:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <dev@dpdk.org>, <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <thomas@monjalon.net>
Subject: Re: [PATCH v10 03/10] lib/pmu: quiesce rte_pmu_read deprecation
 warning in chkincs
Message-ID: <20250801144704.490d0433@hermes.local>
In-Reply-To: <20250801102109.3544901-4-tduszynski@marvell.com>
References: <20250723044118.2962318-1-tduszynski@marvell.com>
 <20250801102109.3544901-1-tduszynski@marvell.com>
 <20250801102109.3544901-4-tduszynski@marvell.com>
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

On Fri, 1 Aug 2025 12:21:02 +0200
Tomasz Duszynski <tduszynski@marvell.com> wrote:

> Add a dummy rte_pmu_read() definition for chkincs when
> ALLOW_EXPERIMENTAL_API is not defined to suppress warnings from
> use of experimental APIs in tracepoints.
> 
> Fixes: 960c43184c4d ("pmu: introduce library for reading PMU events")
> 
> Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
> ---
>  lib/pmu/rte_pmu.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
> index 57b634ecd8..84a5d522d1 100644
> --- a/lib/pmu/rte_pmu.h
> +++ b/lib/pmu/rte_pmu.h
> @@ -232,6 +232,10 @@ rte_pmu_read(unsigned int index)
>  
>  	return __rte_pmu_read_userpage(group->mmap_pages[index]);
>  }
> +/* quiesce warnings produced by chkincs */
> +#ifndef ALLOW_EXPERIMENTAL_API
> +#define rte_pmu_read(pc) ({ RTE_SET_USED(pc); 0; })
> +#endif

Seems like an awkward solution I would rather that fix chkincs
or restructure this.

The way you are doing it will cause the checks for use
of experimental API to not work.
