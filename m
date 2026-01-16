Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A000C982E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 17:37:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7995F42E7F;
	Fri, 16 Jan 2026 18:37:10 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id DE06A4026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:37:09 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so17955055e9.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 09:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768585029;
 x=1769189829; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTybXhsXthKgQQHCzOao/tK29BNzSs29uQ1VrnpscxM=;
 b=A0OOnt7GX1kng2kZsCmthfAmRALPoLhJFGfdlnnyR+qXJsvQUjgk1fgNW4YJRX42AZ
 v9GIldcYj2ZQKEPU2sZQIbjwk/NrX020A5oMPqJpbeO27YMlXcoGjUOhDPWN5zM7EI+8
 95QXeK1ji7ZxE+oSym6z+6IpKJKMIdloh03FVFgpBJSiSnn7024rQgW7ni+mvKO15jbo
 SsJJRjxcklTGvRuzNc5/tPB3028nKjGhPOwl5P2rnIcH0hQdoxCx8wSc0j50EXinp5zB
 c2e60lsTvgyOjqyCfkdd4uLtKfIxsXTgehIDxkveUB1l40OHdI4k+DQLVU74j2lkQmaK
 XpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768585029; x=1769189829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZTybXhsXthKgQQHCzOao/tK29BNzSs29uQ1VrnpscxM=;
 b=iYpFVga1mWKMtnZ1qxo95md6zmyYUYMz6rNNVbEdsf21HrrF9eK75WVp0OP+ZWBOvc
 t9hOu6WSYjCT6HF0XF4ZufDJ3GkvBKck4T/XySsZqHt0CvBVPXh/oj9hR/s/2ZxMKOUM
 v+fl7vGJXinvdHtR3IVj9IpuJ0OUYn12BEdQH9ff0zKbOQT3LNbX4uWo34wjVKLCawWO
 3o2hEtYlMBVgFLQKZuF8zvoSHJg5wLV2Memw2MomORzGxYYMpa9PNWMQ6cjtJKCh/tI4
 WfblOdyH/giLYPdaijiQycp2rZJkoAsuSXSubs1csg/Et8D7BqKWXpR5rYLXXkj4iJxL
 1Y2g==
X-Gm-Message-State: AOJu0YwjP4REapQNi+l8e/sj8AFlcA/QJkmnqJ5fiH+3rPsxPLqGKuHC
 UjMm8ShW6qb7NIRnFTGiESxkPmdyyw4BY1AYdSpG4NjvB783CaIDIhnv3Km+fAGVwqQ=
X-Gm-Gg: AY/fxX7lWYO+oA0j6WBS4AF8RQbYEGMpdTqM9VkVjVqhRxE46F9a3qQh4KykPDXb56d
 8ni31iIfdcekbM8IZpsGmzyxu7QeDJsAz6A2wBC2QTu7mcslHjDuHjnMv8I1+MSFo0AnRoUcHOx
 wRgCrKPfAdUxlSys6GfaOeKGHEBWQi3BV4rX7ZdQJjoIoyGZoWQLRwpCbLFUbrSncDGqnOv8XqP
 AzcfZVdpjGYTJwtdNQmzBhBpUk7xEBrr+6/ZRYjVjYwyOg7RoX/uPy9LghPzpRZ1z9xUwntdpcb
 8NGCfAaJIDRtAZikylIRkJeo2nRKcJs8rlyLvbQ+s/7q0KRcHN/XoXpXdqe/T6YwNSgibuzYYul
 v9uEUZIiCuT94jYvSrwkAGnP1CtcbyppFgIjak6r2HFgyC99P4BjXaB4aJOuVU5ZMwonrfu9oUI
 en0lT7hYVshIyXCMTzeis1ekjSJ4IGejjWfZjRF+rBPHdZNbKIeips
X-Received: by 2002:a05:600c:6749:b0:47d:333d:99c with SMTP id
 5b1f17b1804b1-4801e68adc6mr40380875e9.18.1768585029523; 
 Fri, 16 Jan 2026 09:37:09 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8d90b3sm53578055e9.15.2026.01.16.09.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:37:09 -0800 (PST)
Date: Fri, 16 Jan 2026 09:37:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH 4/8] net/nfb: add device argument "port" to limit used
 ports
Message-ID: <20260116093705.1f90175f@phoenix.local>
In-Reply-To: <20260115151656.393106-5-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260115151656.393106-5-spinler@cesnet.cz>
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

On Thu, 15 Jan 2026 16:16:52 +0100
spinler@cesnet.cz wrote:

> +		if ((port_mask & (1ull << i)) == 0)
> +			continue;
> +

I meant RTE_BIT64() would be good.
