Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3F6C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 15:42:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30AD8402DB;
	Fri, 18 Jul 2025 17:42:31 +0200 (CEST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by mails.dpdk.org (Postfix) with ESMTP id 01F3F40144
 for <dev@dpdk.org>; Fri, 18 Jul 2025 17:42:29 +0200 (CEST)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-41b309ce799so1669544b6e.2
 for <dev@dpdk.org>; Fri, 18 Jul 2025 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752853349;
 x=1753458149; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vE5DvHNlYByciovnZ8YZoOQJPsVnGKQBK0X1pNBJiY=;
 b=rXebI8c6FVH0U+7EnsrvdicwnulmStGkoR9o/TRQZPw9aSz6biySGmMRZElJNEpk8Z
 p5X2ynL67+V0w/lPOpjMC39LNIpcUTKa3lNtfa4Q2qyWg6LwKjpUTQgKrybBgjMbDa3H
 ZFUWg/3LU1jAV/bCfQSzBBd4T9zHp+i7JfpRhMG1m54U5Y46L4LgFyzYnJaGsPWwL31r
 fj3sRIOASOcj0vK3oVp8Mf50fntvNKgSXGuxE9MbqhlB5cBKNQnp17kwSAPABdzr1CYn
 pJBohkp5pUTBSltnprO4ZkObR+Kjr2DbfKWqGDweUzvlXCIOIh6faZheOxoOgC6ex4TV
 GniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752853349; x=1753458149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5vE5DvHNlYByciovnZ8YZoOQJPsVnGKQBK0X1pNBJiY=;
 b=KAUBSsQixbOz7cM+zWXRnLOB5EVjy2GMF3LktyOoQTrpd8q5zP+wWu+PQDcQpt87Y4
 DETqyXa7eruJaJsAGkt3FF4y0//BdRf4606mWFtUwpdk+RNJBi+KC+ADrqlWXoniJMZR
 ntcYlMHW9XwRhXx1fc6zFpzzjj1kaod2kQugDhH4PaM4FZq6Tq4LqrGoyr1Zk20r3/ci
 XQTFHb7yu+X5w8E9dHHmsHg1EXPFne4Z5gIGALzZB8cTR5bZAdLR5HpBMq8tx55oXBBZ
 wLilJL7dYa8UtQgNm6TDbZW9oSOzjXqqqMHaKgfIMJGK0kaxRrB8CSD98K1/F2NRbuOS
 dlog==
X-Gm-Message-State: AOJu0YyIie5KjDVAncmsVYYOKCct2ST5UbC2AMb7n8D/gtDKO2Rwpmma
 SO+sL6UAeeA6BUaX5q5uM/YHe/zhsJnm63ZYW1it+x+/uRgM74jSuiTIlO0FLBuib1e7mmLC5v7
 TAJaT
X-Gm-Gg: ASbGnct47ei5wwOFEvzD/IEZbGu/hZaLh5+lobMr2oEAhd+cY5l0KldTOQBOtLHOunF
 HcZAN3HoN0qv43yNVm+a7Sxs4qZjP5HrJyA0OvmwfuBuK8S1BTRph3J1Q4JGSU7gtZ6vYHX/MIJ
 boFGmpo81f9OX50V78KGBhClFICYgxsiX4Yk78OMY0lu2j93G4/orMoF+KdpRwTJed8XFLF8PpV
 wMgCxhNaeUuWu3mv/hxomhdx9hi0W6Tln7DUhGvocxklUcfvJMkR7OgErQJaF2I0a+svbcz6crp
 pDJpYpmVXZM0CpDTJmeu0phDOy5Yye5BnZIQg6pU1Zu1kzWErCYUu9wW9mCJsNr7GfjYuRyHrUS
 52c6B8ABxJrO5lNByz/zKw3Wnj8qcWHoOMCycX9p746HBWfcw00M0kzw+EwRnonROtys8PfwsnH
 I=
X-Google-Smtp-Source: AGHT+IEa84wRqHwiLwe6YuCr2L9DKqRXINnNUDmOuAhcVrxVuYrsTZhC63lgFXVcZFldKe8ZsSqkkw==
X-Received: by 2002:a05:620a:2681:b0:7e0:9f9b:c1f9 with SMTP id
 af79cd13be357-7e343350e80mr1601341385a.3.1752853012230; 
 Fri, 18 Jul 2025 08:36:52 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356c72bf3sm101543485a.86.2025.07.18.08.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 08:36:51 -0700 (PDT)
Date: Fri, 18 Jul 2025 08:36:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/4] rework mlx5 guide
Message-ID: <20250718083648.57333c97@hermes.local>
In-Reply-To: <20250717220912.376503-1-thomas@monjalon.net>
References: <20250717220912.376503-1-thomas@monjalon.net>
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

On Fri, 18 Jul 2025 00:05:40 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> The main mlx5 doc (for net driver) is improved
> with better explanations, better organization, better readability,
> and will be a better skeleton for future detailed explanations.
> 
> Maayan Kashani (1):
>   doc: add testpmd command examples in mlx5 guide
> 
> Thomas Monjalon (3):
>   doc: simplify mlx5 devices lists
>   doc: add table styles for guides
>   doc: rework mlx5 guide per features
> 
>  doc/guides/custom.css                         |   42 +
>  doc/guides/nics/features/mlx5.ini             |    1 +
>  doc/guides/nics/mlx4.rst                      |    5 +-
>  doc/guides/nics/mlx5.rst                      | 4802 +++++++++++------
>  doc/guides/platform/mlx5.rst                  |   48 +-
>  doc/guides/prog_guide/ethdev/flow_offload.rst |    7 +-
>  doc/guides/sample_app_ug/flow_filtering.rst   |    2 +-
>  doc/guides/vdpadevs/mlx5.rst                  |   16 +-
>  8 files changed, 3334 insertions(+), 1589 deletions(-)
> 

Looks better, it would be good to look at the table of contents
(right column in html) to see if could be better in complex document
like this.

For example the Usage, dump flows, VF trusterd, etc all seem like
FAQ kind of answers and could go under one heading.

The section about statistics should also get headers reset
to the right level. The part about phy_ counters might be better
in limitations section. The Limitations should probably be at
a different section level, not stuck after live migration.

It would be good to explain a little more about "forked secondary
process". I think this is a general thing across all of DPDK
not MLX5 specific. Should this go in EAL?

The part about Rx/Tx tuning and Rx burst function might be better
together.



