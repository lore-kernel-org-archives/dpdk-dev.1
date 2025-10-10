Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62924CCD185
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 13:31:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C12740658;
	Fri, 10 Oct 2025 15:31:55 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id B0D61402A0
 for <dev@dpdk.org>; Fri, 10 Oct 2025 15:31:53 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-46faa5b0372so13262075e9.1
 for <dev@dpdk.org>; Fri, 10 Oct 2025 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1760103113; x=1760707913; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1jFNMl3EiHh3OHGbLqPvQzj/KoFJSHoGwbakPJAlYkw=;
 b=UrqpDUPwH9qUcCB8eA23lN/hJilFkceodbmIu9Tb0qlaPHwRRuGfLEwYB8R19h/Ybe
 cQs4ivkky697foJziDuHoMAZS6DDaPrP0lSTTC1PvALIRSUwRYJ41IUzLjWPYHSTdIJw
 4xr+SumTouo3ZurDp+C+68tn9H86w6IwWIKavfkFXulCb/AvoFocjb7T0f5z3thV2DWM
 YOl0ZbNB/8gMoWO46QavGSow5dP5GrgD/eb/V0cJK3FskrW/JBvYGUs/sw3CxhFZpgTL
 3iIZG8+rYgl3i5WQ+X5Te7KDJYcBFYE9wG+7vBW1Qtr++98II7C+MEv8WEXFpEFuRHHv
 DQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760103113; x=1760707913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1jFNMl3EiHh3OHGbLqPvQzj/KoFJSHoGwbakPJAlYkw=;
 b=T4Rpo9CIFokOejgR6zRKEVDfbySlI/y5+9i/5XoqQoiHF1LdVkOEjvuGtexSlg3k16
 GPIT9gkgO5eI/qIV+bjeMYcHlLLZ5Nn8A8sW3hNCcLZad2+mVeK6r3sc1jAb89lx53Xw
 hNa4ZZLZRt8aVOFqyuhsri7Erxez+rs+KMbidG9zjnMyNghqOVTJd6la5qeqHqRL/kgi
 LA6AeKccsJuiuxTg2+NwCgC8NZS0vEPAWNPafgytz6r2V0krNDtrnDUYlE+1gR/LBYcU
 a8ClmJiqdO8Vzeih6MM45cV93NClRhRQWekom9Vrg/73CP9zsQNQyl4k9dIgXeE+2AzY
 fH3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxypU958ZJV7kyR3c10KG+yaGyx8iGRsFuPM/K7Lde34s+HVWYm5skhOvUYJulR9tBEII=@dpdk.org
X-Gm-Message-State: AOJu0YwoGbVousF6t0q7VJ69QJO2J4PC70zJoI+9/P3F//ycqiNhY4/m
 2OdsRxMsDWVYtxP5zSpQ1SNX+kfVhWMz9syl7F+zwsutmhNcfBSlcGoWlTcvsNWJ4Q==
X-Gm-Gg: ASbGncsUxHc8jj6S49fJE5p4kRWhDnhpXEGACVm21ebtH/ELZtRBUHBJdh2wKx6dqp4
 P8W82S1ntvQW8OhtdKDwiWHp1GNHpXt2PK2zNJz8qS75dax+IO/4TSt9vtDY7OT58F7UyMvDa/J
 upuiBoqJgGXf9+k1yOVzusQ1TI9h9/GS8XF+VsN3XIllNnLt1AXD0rvZh8Bi4pthsp4Vwbdasog
 2tEOlZzEFKYYdWYtfwW+wo1Tpousgkqjq5lM+c6Xq7lvcBZFcOEhJCXLPKG0cyrXaWtoDl2kxFL
 gYpcKpus0OrnKsQv3pNnIUScJpU0OdpMBJM/ak1jfyblCyemDHyvkddBJ6sAeHibvXbSAj3VRVz
 OAoFx1EasktW8aFjSXKlJtffWE28C8gErtKMHwoeAt9im/8W0sRC5pU3Z
X-Google-Smtp-Source: AGHT+IEdyZq+H9bVxCJuNZLQR7FA0394aeDMAgHRExq9OrXqMbIbJz5LDmOAAp/QY3ydMsn5INZGJw==
X-Received: by 2002:a05:600c:4752:b0:46e:3dad:31ea with SMTP id
 5b1f17b1804b1-46fa9af8fb0mr85233375e9.17.1760103113180; 
 Fri, 10 Oct 2025 06:31:53 -0700 (PDT)
Received: from [10.17.1.39] ([185.13.181.2]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482ba41sm48625585e9.4.2025.10.10.06.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 06:31:52 -0700 (PDT)
Message-ID: <f2050e39-4fb2-44cb-bbf6-e0fca99ab9cd@6wind.com>
Date: Fri, 10 Oct 2025 15:31:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/e1000: fix crash when built with GCC 13
To: Ciara Loftus <ciara.loftus@intel.com>, dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org
References: <20251010125848.965340-1-ciara.loftus@intel.com>
Content-Language: en-US
From: Thierry Herbelot <thierry.herbelot@6wind.com>
In-Reply-To: <20251010125848.965340-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/10/25 14:58, Ciara Loftus wrote:
> The e1000 PMD crashes during initialisation in a Ubuntu 24.04 VM when
> compiled with gcc-13 with -O3 optimisations. This patch introduces a
> compiler barrier after the register read that was causing the issue.
> 
> Bugzilla ID: 1691
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

Tested-by: Thierry Herbelot <thierry.herbelot@6wind.com>

The patch fixes the crash at startup.

	Thanks

	Thierry

> ---
>   drivers/net/intel/e1000/base/e1000_mac.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
> index 2fa97d12a9..41aae86ffe 100644
> --- a/drivers/net/intel/e1000/base/e1000_mac.c
> +++ b/drivers/net/intel/e1000/base/e1000_mac.c
> @@ -1842,6 +1842,7 @@ s32 e1000_id_led_init_generic(struct e1000_hw *hw)
>   		return ret_val;
>   
>   	mac->ledctl_default = E1000_READ_REG(hw, E1000_LEDCTL);
> +	rte_compiler_barrier();
>   	mac->ledctl_mode1 = mac->ledctl_default;
>   	mac->ledctl_mode2 = mac->ledctl_default;
>   

-- 
Thierry Herbelot
