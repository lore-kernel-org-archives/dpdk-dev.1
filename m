Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2F6D46C01
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:51:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6F4F4026F;
	Thu, 29 Jan 2026 02:51:16 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 179604026A
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:51:15 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-480706554beso4310295e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651475;
 x=1770256275; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTIvseU0gEgxZZgoYKqhPvr51m8opdAk3zeVBWgNc2E=;
 b=Ha3fIZdXk1Bhi1MSWRmN8TvzO2xwjoFlZRSksDL6j+ERDro2KGTVyuLSHiJdAv39S3
 4f26G3uS/CT4XeFQUUXvnZ323Lv0KDs1hv8G9457zIBp8qzd1PJFUTrajY2MRKuTNxBZ
 kANJwF0A7Ji2UxamMnJSOzQVAjoaqrIG8ildDVjz9E1hqW6tPsgg2IxgzMgRR+r+EQeX
 IhZiNsFbRDZbWffL1c7OD+LR/2G6bHX3HD9n4EVkfim3mWVLLsTXeb0Gf2ZUBDj3OSAm
 rR6I/e/F7dvccrGeahY9c+gSfB5z4wSUFLUGQzRLfFz1FuJ9FMNbKXc3Vec6+7OuICFS
 8inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651475; x=1770256275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yTIvseU0gEgxZZgoYKqhPvr51m8opdAk3zeVBWgNc2E=;
 b=exFY/ayyeJrNw6HAlyUBuPYbYQmIvlSb+l9J4C5iPuCDS8iE2mtmzmF4Utu9KeabTn
 H/GZgh/RivMgoL2YhyyvQtgdEzjJu0hS/HmKjjYmYpVxND0vCl9VSU1n8zsq8MUQ9Sh7
 XMPZ+68hy4jOSd4q6f+0FPlCpxvKwbsuMgIyBUIv+lCEg+pBNDZ18lbX8VodRE6Zqzei
 Nvgd34ZZm39FAbzYVuMXH5CpSYVmuhOPKSEyt+BnGkPiSeoK9ix4Mgw7kt0hslh5ZvGN
 k89lPpYgVyVJDJB2DlfWyZCz/BvadCtnjAzKEsg0T1N3oi9EvajcdImkLWi+UGuZ14kc
 gHlQ==
X-Gm-Message-State: AOJu0YzH76+NdPKTRt/WWi3s5UD9hZZbADa0BOKQ+IuyWyC13knAYqye
 z2888tO8TaKXyFYCL1JVKNiIWNv7pm/AHDiaOomSdtQGQ5jW/7lDGqLr1UO1ws1OqJ4=
X-Gm-Gg: AZuq6aKT6tC/twCMWg8qBS2MMugMmCiBmbxYVJhqgstqsFPuU/0pJTG21C8pQ+9z0XE
 9wxiedZ18qqfCHrTisCJUPgpBdUcPN95bw4cf49u/ZBzeJOwUItq7WoGxDliUUIqxFY9pm7TNeQ
 KybMbToUyw6oXFRKw1tyxXzXn5OYsO+PaRIzbuJkWFFatTod0qqBqnMoUmaL9vLVqFmtGGxuNME
 upcTGKvyjIWzROHKEHjem87cUtZsesbkzrfci8CxZgUxWcwmxitTVp8HyT/rl0438MDWsofazWj
 /M+Tz68+9psFP/Fq2uAsI8duvtxcKM2uCOjoFYS66IquQyfwHHZaX58XVV+A1ZWq4n+X3Y2UyEf
 5VSjhp8aod1oNg39SZEPn9qZu/mE1m4+A0G0gB2vdowo+pF0q9J3/f/CB1KgpXhrPCCSNTOoPwq
 kzaY6MmN2ZanpkEgazU8AEsDgM7Pu047KZQNZEsSOxkTiDpjWcrEJP
X-Received: by 2002:a05:600c:3f0b:b0:47e:e20e:bbb2 with SMTP id
 5b1f17b1804b1-48069c0e198mr94220335e9.7.1769651474671; 
 Wed, 28 Jan 2026 17:51:14 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce564f9sm102075605e9.14.2026.01.28.17.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:51:13 -0800 (PST)
Date: Wed, 28 Jan 2026 17:51:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cliff Burdick <cburdick@nvidia.com>
Cc: <dev@dpdk.org>, <anatoly.burakov@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>
Subject: Re: [PATCH 1/2] eal: support dmabuf
Message-ID: <20260128175107.26fe3189@phoenix.local>
In-Reply-To: <20260127174429.1504288-2-cburdick@nvidia.com>
References: <20260127174429.1504288-1-cburdick@nvidia.com>
 <20260127174429.1504288-2-cburdick@nvidia.com>
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

On Tue, 27 Jan 2026 17:44:08 +0000
Cliff Burdick <cburdick@nvidia.com> wrote:

> +/**
> + * Get dma-buf file descriptor associated with a memseg list.
> + *
> + * @note This function does not perform any locking, and is only safe to call
> + *       from within memory-related callback functions.

Maybe warning instead of note.

> + *
> + * @param msl
> + *   A pointer to memseg list for which to get dma-buf fd.
> + *
> + * @return
> + *   Valid dma-buf file descriptor (>= 0) in case of success.
> + *   -1 if not dma-buf backed or in case of error, with ``rte_errno`` set to:
> + *     - EINVAL  - ``msl`` pointer was NULL or did not point to a valid memseg list
> + */
> +int
> +rte_memseg_list_get_dmabuf_fd_thread_unsafe(const struct rte_memseg_list *msl);

ENAMETOOLONG

At some point, you need to come up with a better naming convention.
