Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE5FEEB56D
	for <dpdk-dev@archiver.kernel.org>; Wed, 31 Dec 2025 19:28:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81E6D4064F;
	Wed, 31 Dec 2025 20:28:20 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id CB90C40648
 for <dev@dpdk.org>; Wed, 31 Dec 2025 20:28:19 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47a80d4a065so55402305e9.2
 for <dev@dpdk.org>; Wed, 31 Dec 2025 11:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767209299;
 x=1767814099; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2A5ar2YWEU7zDSa7SBwaaTF4/YqCs92tYAzHbRQ2Yxc=;
 b=vLXrw9mhXTcpffA5HDD/t0Mqeg22dhNgtdPbuXcbSZ0HaPlDhPanHF/0lPiKDdw4W7
 1ETrOWknGJNWQL6qbF6m9vMHXe6DPjE0Qgr5XlIXsLrMolkclWKidGkB8eoXEIEzSYTv
 oLPJO3tsDcTGIIB36P1yqHertA7GmLJP0VEecCuv5ockyxsmvATREAndAMmVKoAHmndm
 sAqk/3I2r4iCI/MTEeGA8MJlB8P/4vH6eszDN41Jpo5yft3HLrXXfRXLrX6tt+nVwV7k
 CHdxBHFMrg4ZMCVYLmsvdkLuWwUnKk05nN9ODMYVtUa/RmuRyp/2hvGJYLbJZxi1qJbY
 venw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767209299; x=1767814099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2A5ar2YWEU7zDSa7SBwaaTF4/YqCs92tYAzHbRQ2Yxc=;
 b=IJI9mUmR1rFTVUuAHyMuA2nIyQrFg/gPl5TiG3zsug/VHVyEeWPbkYQkG7nuzmVexI
 DkP7L++xpb3JHXUqEJ5bNw/IA6vOP15BECF2ufIWyX1N00gMtMjZlTc/mj+rkysgEEYv
 5Q7Ph1a+FCbl3KUA8aZWCm1rxiQwvJ57a0Nq2dadqACLHvVHB40WM+/fv6F1Tr+LEyp9
 5kJJ92oVvvQiPypqeQ5cFexUFAtXn9y+O8V/7+EesOG3Q88hJN5hCAu9KLA3lgrIjZxh
 4dtLrWiUQ5jM70phI9kL62w5U4jhrjHNXu5glJaaYNz3jGut8uq8DXRLsgXWvgbq5V5K
 q6Lg==
X-Gm-Message-State: AOJu0Yx9QEKO+dWNzAQsnlTFInYa2vUUke+3w/AbqXauOdjL1gZCAYYs
 l6dtiOzKTR5NeybvUuSWJeFzCcX9OXgED/Y6NpYH/ve/tVZEttSwQmVwHcnHZ9PCH6o=
X-Gm-Gg: AY/fxX6IyQAKrwQtH7wSeF47xpshzW1XV4hogpUE++YbY5XkfRNj0W1LqvnJp6OwUXr
 6/HriYNz8X8PBrktx3XdLGDaQ4voww8XfTmA0ecEbtzYaOt7c3APJj6eZQ5pqlhVDMkOJ3HqNBt
 jEVHAZ3zqVBSKoxfSlK+FL9n4hzkxMRf58enMrsMQv5vUsHYVqT+Gle296N31VaNpTr5dpzvQbU
 LNiK6xROF07Q3Ty2dldwdRhLcExDARsX46hHqvVzB292b6DczMbrxZuwKK9cj+1s2s5KtTOVX84
 k8GAYtict2t47z7jXX2M3eHAfvSfOaPti3RKnEO9mb74GiWoidfylcZsIN2QMwRXHjqH/H0E/MX
 cTMH2NHdkKCJUy9pz5RHXFoOaOZuZnNHvUrouYj/ZLxtBWGF4tCQnfheBptIPh77qShIBlaxNQv
 azjfyYClAyF1NGvwd8bU6aS7ZIZZfmpnd1r8khYK+0P7ga0MYbZhZr
X-Google-Smtp-Source: AGHT+IE8w2Px5TWiW8ssyvkl1M5e9658vqwMpsU14LAL8ZXb+5U0w0/LEB3S5e6kle4KwRjlNq6AEQ==
X-Received: by 2002:a05:600c:470a:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-47d1958a61fmr433248305e9.31.1767209299434; 
 Wed, 31 Dec 2025 11:28:19 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d1936d220sm728037815e9.8.2025.12.31.11.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 11:28:19 -0800 (PST)
Date: Wed, 31 Dec 2025 11:23:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 3/5] net/zxdh: add support set link speed get autoneg
 stats
Message-ID: <20251231112359.08d6ae70@phoenix.local>
In-Reply-To: <20251220061521.289722-4-wang.junlong1@zte.com.cn>
References: <20251220061521.289722-1-wang.junlong1@zte.com.cn>
 <20251220061521.289722-4-wang.junlong1@zte.com.cn>
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

On Sat, 20 Dec 2025 14:15:19 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.c b/drivers/net/zxdh/zxdh_ethdev_ops.c
> index cabf81107e..8fb315eeac 100644
> --- a/drivers/net/zxdh/zxdh_ethdev_ops.c
> +++ b/drivers/net/zxdh/zxdh_ethdev_ops.c
> @@ -307,7 +307,7 @@ zxdh_link_info_get(struct rte_eth_dev *dev, struct rte_eth_link *link)
>  		}
>  
>  		link->link_speed = ZXDH_GET(link_info_msg, link_msg_addr, speed);
> -		link->link_autoneg = ZXDH_GET(link_info_msg, link_msg_addr, autoneg);
> +		// link->link_autoneg = ZXDH_GET(link_info_msg, link_msg_addr, autoneg);

Do not use C++ style comments.
Do not comment out code, remove it.
