Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7778CC83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 14:27:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A695340E24;
	Wed, 23 Jul 2025 16:27:57 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id F3B6A40E15
 for <dev@dpdk.org>; Wed, 23 Jul 2025 16:27:56 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-704cb8b1314so41576606d6.3
 for <dev@dpdk.org>; Wed, 23 Jul 2025 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753280876;
 x=1753885676; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5j3D3DhSSHJqHrA12+BOjJ5Xvvd2QTtbnv/sWJuB8w=;
 b=R7J+jhLCTXd6ysNfSOj4YPuJ0lo84CPU1P9X3fIaSqD66PyvbsZnSXcq1eHvBHd1Au
 5JlwuCoThCkkuTRHDQrXVHEL+Ct+igC/4Hvno4X+iSTCYB/ELcL1HVC+Ss7nLU/5Y/QZ
 UNVlb4adSMP29yU+B/VP+G8NH0sU8jis5zviLtbUug8+MY86MP22L2vqWFT2Y2qbJLvy
 CjdnE8wOGgj6NNz1z6G7VZqreHd268GBUAE+vePfe3N+vp/B/xSVyXVdrJo0beBAFdCi
 FmEwd0UDM6F1bpRvKDnCcXby5WXTUaijEm5LpB/F1B0TzjZI2+32Bp7m/EczvO7rNsp2
 WuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753280876; x=1753885676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5j3D3DhSSHJqHrA12+BOjJ5Xvvd2QTtbnv/sWJuB8w=;
 b=FfdIw8/Ag5URf9yjviNZYVhiVD/A6CgTHm3iUsyJ45PAf5T7cKEMgBs6Q1meDHYRjW
 CLmRJ3DnAQ8zsBmkjCBIFGyja93tfhQqKxM5U6RuXpNJNBitvEYh3vnL5zAx8sC1tnb3
 GwdyaE+tfoyw82GqjGt7PFomKum0Xtef3Q+VaPPBvnja3EOyQwIBLF+nsXSRUoHE52zi
 yuHC4ccsSQaZ2RcqNREHjgl7Q3lVaiY5g38ecVjdpVGNxE2DFTzm8OEBed0laClJ6XgM
 qIn421VMeE3PBSuoxX2Cn6BSe8ExBGXUGdneezcjPUgCUjyyTtYZ7zlAiQTvw8lZPa1x
 Ng6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoABT7+jTPZcxK1SZMg3+4UyqXVwWhuuNqBkChKmSDQ9Ecbf/FXIsi/5hYbVlK38UiZBE=@dpdk.org
X-Gm-Message-State: AOJu0Yy+YA3gbDDFTk5uGHz8aOXxOjcA0rvLbZbR4Cm2UwmGNGf6bvSK
 jYmgFbss1jNvxyHAntRKJNH3RjpRVbZwPrAI6EbeXfX4YQPQp7xyaZV6V+b/9BVLYaw=
X-Gm-Gg: ASbGncslr7tRzZwvq/pAnfJCJf0u+icsUl6lMssj8gOM9tXx+mbXj0/gnOGd2vGmJUi
 E30M9fMyyBxdtffFvYlL+Du+EGp8F1hU9KEyy++T3wfy0IcoZJzEmqGIzXnReJRvLVYyGKjm2Zn
 VGoqO1FYTDVME6Nen8oPpFJmKf7C6VWqyCYfsHwJxVdAVnWjtV+63ZXczzlUYHkBKn7uXrCDpkG
 5iXUKCrOyWGkgUM1OANghisBgzLRg/ZsgbwUQIPLcrfeWj071IYid8HNtG7aXDHjWYi51iII5xc
 4xajO6x+xGZb5ujNDl8bVAefxN9tbsEGVKdQkzT0dPDhOVor1dfvtENGVMqDbwk/7OwZqta9exW
 Js8SLtxTz/Q+6D4D73JQn2CJrvX9Tw1y0odn9YrpXkTCpILlhvH7r4iH3I84vho7N4veCSGxkfR
 k=
X-Google-Smtp-Source: AGHT+IGqPNXxoMQ1xecDQcM+Co8oE6Qwabg865XsVAMJTp94wNusZlQSGYVZ70/n4ZoASpDYiaJC4w==
X-Received: by 2002:a05:6214:b62:b0:702:d83a:6695 with SMTP id
 6a1803df08f44-7070069b96dmr49750856d6.36.1753280876101; 
 Wed, 23 Jul 2025 07:27:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051ba6b710sm64518456d6.57.2025.07.23.07.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 07:27:55 -0700 (PDT)
Date: Wed, 23 Jul 2025 07:27:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <dev@dpdk.org>, <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <thomas@monjalon.net>
Subject: Re: [PATCH v9 1/8] lib/pmu: quiesce rte_pmu_read deprecation
 warning in chkincs
Message-ID: <20250723072752.7f6812e3@hermes.local>
In-Reply-To: <20250723044118.2962318-2-tduszynski@marvell.com>
References: <20250722120041.2718227-1-tduszynski@marvell.com>
 <20250723044118.2962318-1-tduszynski@marvell.com>
 <20250723044118.2962318-2-tduszynski@marvell.com>
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

On Wed, 23 Jul 2025 06:41:11 +0200
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
>  

Seems like a problem that could be fixed cleaner in chkincs?
