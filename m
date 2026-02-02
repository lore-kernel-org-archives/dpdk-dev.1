Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B516E7DF0F
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 17:47:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E5CA4027D;
	Mon,  2 Feb 2026 18:47:41 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 543E34026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 18:47:39 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so40455475e9.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 09:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770054459;
 x=1770659259; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYijcTzDpHfZ9MbpFcZDKJGQq/gF22uBTvNLfvaCxNs=;
 b=aIU5bVXVoedzNQcWuoHhiWc6ZsggwXiw8wYH/eRQoBJ6ZJGxbdIG8t7sz+CkbKBFGr
 QBrqvjd9CZLRr6vbD7UdiUSxjm8HVwZ7BpXFMHI0R6YXX/SS8vLIZ0TCXupY4euUsGdt
 dGHuRz6pDXj8VjwnFgGO83bSwIv1HgzX1zgRQpdXuixxHXFAg/AT56G97MuDITpMjO6R
 jsJayGTcWE/M/2iUV3rhJdevbBgpmM30OAHmknhAUnR5/KLdtOXXsgSLb29Z2rJKq1DI
 zprZho+Y+t19UQ60ySQnKBPaXNjmNFTnz9KY30eFKzunduQvIGU7psHc9Zs1pM9HZT7K
 IdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054459; x=1770659259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XYijcTzDpHfZ9MbpFcZDKJGQq/gF22uBTvNLfvaCxNs=;
 b=v+kTDlJ64zKCjcHO8vWQHqsoVW0vYVNhxKtwXKNtuQoOqHzPRLecx/w2L37vT4Naem
 m2U7SmnTxJ5cwuIaD5W8lZMadEpVAFYbhLp/DN1pYChDdZ5r96A/+cr4uxtrCsjfVlkb
 6iGXsXdzEgRSwG/ID6zvKVHCy0LwGP9+MyOT2+NaGRK+CKL+Y1evVM0AeRLtKvfkOVDd
 gu60/swUg5Cdfp/NgEbQvbKS7OwbXFpZv6zo3WgIIBANw/DgzQIF7Z/4rdIw7PAOyNJ6
 vQ6GGaVP5rJbLJhzjYp+7kuj9kAcBLGiYS51qMTD5HOgO8d7v4UmLhrSpUFzOZXDnyP4
 8eTA==
X-Gm-Message-State: AOJu0Yw4bmpF+WwgSMEFV2JgvWY/GxVSxg3z04pxqsCdAd82/wRoDwqD
 SokzQwowFFxTz7FIQOdCtHZFp1cLPZTU/QIujE1vUhBzUCRAsgTJywLE5rnDMEYyGAE=
X-Gm-Gg: AZuq6aKva36QfO7lq8OvLqYaVLdVw7tayXMkQYKCS9nxj0+i8UzHNzXPkEg9vU974yt
 VQsRLBkf13PC1cjIOsuTqC9iiHOUFO/pHAN82rVG35Xg3oEF2i6fQJ/gs8XrXKUFnGzWlTMse5l
 +vHnyOjxAXPgzGFhRnUFVFGPRCr23JafejkFhAY5X5A2254rHR+7lDNwXPtukcCpHc4TuC0NUrd
 b6BTFt5hbSfL7DAAfCRkk3c+4p+AHmGB08t7ec+6eQzbHAAi8P2dSHTtUX6In9EZbzh821uCo+B
 ifemwVRIJc8lyXmZermlwKw/eh46a7TcA7nD/Z81a/J3Mhnynl9oW53Szd4TrCiZBzhcWXMYEr/
 IYpVdmBguhB5DOCLBd+0mODuzV0SMCPgfQG/T5PxZOycJPRpv4W1FAysUTbYeU8Bt9YWXk83Af6
 /7Lyw24HdM401mL6rAjSNx1E417vJ18TdefycnWOnjBQk/wpOhsuOG
X-Received: by 2002:a05:600c:4591:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-482db4477a4mr159814895e9.7.1770054458837; 
 Mon, 02 Feb 2026 09:47:38 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48305129321sm4186505e9.4.2026.02.02.09.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:47:38 -0800 (PST)
Date: Mon, 2 Feb 2026 09:47:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v3 1/6] net/nfb: use constant values for max Rx/Tx
 queues count
Message-ID: <20260202094733.144a4e73@phoenix.local>
In-Reply-To: <20260116152057.1456380-2-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260116152057.1456380-1-spinler@cesnet.cz>
 <20260116152057.1456380-2-spinler@cesnet.cz>
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

On Fri, 16 Jan 2026 16:20:52 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> The nb_xx_queues values in the dev->data structure can be modified
> dynamically by some apps. Use runtime-constant values from hardware
> directly for max_rx_queues/max_tx_queues.
> 
> Fixes: 6435f9a0ac22 ("net/nfb: add new netcope driver")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Martin Spinler <spinler@cesnet.cz>
> ---

This patch does not apply cleanly to main or next-net branch.
Please rebase.
