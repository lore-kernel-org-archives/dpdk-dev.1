Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAE2C36000
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 15:58:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 641C740B9D;
	Fri, 21 Mar 2025 16:58:38 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 7CA6240276
 for <dev@dpdk.org>; Fri, 21 Mar 2025 16:58:36 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-225fbdfc17dso36054075ad.3
 for <dev@dpdk.org>; Fri, 21 Mar 2025 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742572715;
 x=1743177515; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fA9SEzqZ18cBF1gOVVYcB2w1j+3+dwjalmN/+//hupk=;
 b=DVd9YRJJXoelgNokX40tS+rIeLR35NOkEPa7AfvgG5z+ePHVR5s2tAoUGj404OeIx3
 yBKAlNpYHQhNEshqirJuiVc6E1VbUJTULiiHbMWiYbS5zAAzhTkNsQKmr1BIyrcuBKe7
 Ub9GPFatZcraskcm964ybvbIUWRIsDQO7ckHBxYA4CH2RB8BrBqPlPxrQ2PAedvQWX6P
 cd8JFx3MoASv9d+iZp7+5ZAVgXG3690LpbusIQ/LvYynDlihRKZt8e+IXR0lGny7I4+m
 Tgsg+1mdynQCQUiwLqDEcfrq3YvxjnvM2XnAXnA5GhkOwK+BgdISsYQQ2t9hBUqNR6+I
 gj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742572715; x=1743177515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fA9SEzqZ18cBF1gOVVYcB2w1j+3+dwjalmN/+//hupk=;
 b=D3uouvu7VOJBHCEFT5qqOvgIrVEH/N8jCuH9zfYbwdGylVT4ZAWkLK06pU+iRVuRTo
 LbtBhgVxYWsvR3K7c2olSREw7Itrb4LIas+WKsyBjrSlbSa0/Ds7qVzjyICDZgkkuUUn
 TBOptYTk6u7OodjCS/SdBGdbHQRYNLLZ+Yt/EDsz8V4TK/YL/z5VfmQLA7PbgIRdw/Qf
 be9T3bNabn376DDdMsWC5ZM/kb6lG4xRF07VrJC/txcutIyF0ZVR2qYgGSwoqblTGaPw
 GmFYr+7yxVU3sZrvkgI6u449ZkCbA7QccKEhJe7FwHd5bL6ZFTm8+a53/M8XecGdheuI
 e9UQ==
X-Gm-Message-State: AOJu0Yy5rYB1oqRMo9OP+579CeJw81TO0/AXHg3TvGfO4bCyTwUM8D15
 AdCTYORrClWdz1/JyVL9Wv8hGGYA4gncMwh1csWZi7LdB7MHlE8QqK4cCwL/Fvg=
X-Gm-Gg: ASbGnctrAz+wjfxHW6mke/FpA13J0HSBkztYRNfTzuk4MqdEZHO5tMWrQEhrk8X76v4
 /j7OqYd64LRLRuH+aJ7jLmBZiAN76neu0WUlzr++mYqa8Z5SLI7dtpkgI/SIp7+HgrWQ3ykxptX
 nNgPLsPZzndfx8nx36Bm+TzdcPRjfItnVXKWTQJ4LR6L5h+cRRydNdp++HyhWYGIq6DR4PrDAuw
 giqmEgL06qyozfb38IlOfho5gXhG+YgfrarwZz5gAzUESAJc3KQT1e9SR8FORcQErqQCTfy9Vgj
 zCtBLUpkTA6WPIt5J3jjv4+APLR4pMIFOfP+UwCx7NRMyMkqCkbaQHSk4wTV1wm1y4OumWgNQsj
 kzNsB1N4KFhBMPDWWEkbS7A==
X-Google-Smtp-Source: AGHT+IFYpadxr/gKvIxRxpio2AVOkyfUXxHWoiat4bNvDtUGbpXaqBuN7rbdXWwhbCY2e3rjQ1gYog==
X-Received: by 2002:a05:6a20:e196:b0:1f5:87ea:2a10 with SMTP id
 adf61e73a8af0-1fe42f08ecfmr6730344637.9.1742572715343; 
 Fri, 21 Mar 2025 08:58:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390618beafsm2087745b3a.161.2025.03.21.08.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 08:58:35 -0700 (PDT)
Date: Fri, 21 Mar 2025 08:58:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <honest.jiang@foxmail.com>, <fengchengwen@huawei.com>,
 <roretzla@linux.microsoft.com>, <lihuisong@huawei.com>,
 <haijie1@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH 2/2] app/dma-perf: fix infinite loop
Message-ID: <20250321085831.09215a83@hermes.local>
In-Reply-To: <20250321040316.104126-3-huangdengdui@huawei.com>
References: <20250321040316.104126-1-huangdengdui@huawei.com>
 <20250321040316.104126-3-huangdengdui@huawei.com>
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

On Fri, 21 Mar 2025 12:03:16 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> When a core that is not used by the rte is specified in the config
> for testing, the problem of infinite loop occurs. The root cause
> is that the program waits for the completion of the test task when
> the test worker fails to be started on the lcore. This patch fix it.
> 
> Fixes: 533d7e7f66f3 ("app/dma-perf: support config per device")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---
>  app/test-dma-perf/benchmark.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
> index 6d617ea200..351c1c966e 100644
> --- a/app/test-dma-perf/benchmark.c
> +++ b/app/test-dma-perf/benchmark.c
> @@ -751,7 +751,10 @@ mem_copy_benchmark(struct test_configure *cfg)
>  				goto out;
>  		}
>  
> -		rte_eal_remote_launch(get_work_function(cfg), (void *)(lcores[i]), lcore_id);
> +		if (rte_eal_remote_launch(get_work_function(cfg), (void *)(lcores[i]), lcore_id)) {
> +			printf("Error: Fail to start the test on lcore %d\n", lcore_id);

Convention is to log errors on stderr and lcore_id is unsigned not signed value.
