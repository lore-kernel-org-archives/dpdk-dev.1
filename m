Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3666EEE645E
	for <dpdk-dev@archiver.kernel.org>; Wed, 31 Dec 2025 19:15:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EABBC402BD;
	Wed, 31 Dec 2025 20:15:35 +0100 (CET)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50]) by mails.dpdk.org (Postfix) with ESMTP id 5FF54402A0
 for <dev@dpdk.org>; Wed, 31 Dec 2025 20:15:34 +0100 (CET)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b7ffbf4284dso1453928666b.3
 for <dev@dpdk.org>; Wed, 31 Dec 2025 11:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767208534;
 x=1767813334; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r1DhagAVODbLVzK0myv05OOv5MQ+5Fpop2O9BDtvKmU=;
 b=RcGtS4CV4u63traHMOaMk77Npp85jr+Lzlsih5eGW9HBS5SeuRvKGbceOqPZoulSo1
 rzDvWFkcVLpU5jjV8E7MEUwHmJgzqucWGTg7rNHhi/Og97RTOKsby1gaMmCGsAbo9Aoo
 PfpT7e7W5Jgbo+tKiIJ9xqNqmIus1JzB7vzHrqDcT6FP8LKbhdb+2qB4iWVm+AtSR6Yy
 N2rlKniiCXBnMGMxJzaLcJ5pWdNjFFQbJOabj9HUuKXL8GQf5KWbA8KodeaC2DIaQspl
 lNrJLHSAxrT34NDL8AckgIpP4JW0pY6XT3eB2ZdhDx0wEq/fYMmcdyh/B0/tfymh3PQi
 KEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767208534; x=1767813334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r1DhagAVODbLVzK0myv05OOv5MQ+5Fpop2O9BDtvKmU=;
 b=YlvP4SQxwXQEgtIZUZDy7/kLhkR1q5BBSj8bwq+FGs5fljeNrNQk66xURK8dHo5nZz
 wPkYX0VJb2+Ar8krLXxz1j8ae0YwNueyXA09Ywcosr/h3H33iPZ252TlSLfHS4KDnFDf
 aR6UoR9HWUfu9rLQnhycL8Yk9jg7LsVDeYbR1aBOY+E+Xw1KSr9qagaZLR6/Fgnx/mII
 Gd/9O6lN85R+iFdJhIzUCthu7pDIRdmB4SKh+tzJGDbZbBThmzflpSO48JDzwq6ydpE4
 BnFrNPAkz2HWyI0cXE46DHM7hZ54NRlNf6CISUejhLiEA0FYQHSxkeI1b0tr3OFtprLY
 CWvw==
X-Gm-Message-State: AOJu0YzxHxG4y1QSBOJhvCK8gT45SuyLe6DFyHbW4vbfAuUuVCo0v0Xx
 MkCPHEgAQNzwQsCrkVt1IpcI4MAWi5UXb+Xh30pL+QxiEZ2l1eLHkD2okcUGQeABd20OgGVNuS4
 CQGlMyzM=
X-Gm-Gg: AY/fxX4DJirQ4JNpAmFzo5pytK0Pu13ZXtU9t3qKemqHwUZQcO5NpwJA82N5QrzxCe6
 1BS+23s+UNhwVXy7ZcUBI0QmYIvzI+mo26rP7QfhG+I2GNsT5PCZ1ZymJliyMWKOe+W3QKHusIi
 7tLgiBBtjOYcen6nlv/qIPdXNy2GDWGM5OOtlx3ioa82FqOXM3fi21utd3W0Smpv9/lDPzJqTgV
 fexOT49nl3xohf2bcVZ8V4CoPpkLqnTKkObjm+pKlZJMKu+ukABtpkYbFvEcGN0+ClO7ALpMdSE
 zt3l7Q1tud5ScujwdKtnbdnILm19RQBAv66iUJXZOaNf9pHmHnVh2ZCnijKSfypvHoGhwo6n83j
 p4o8th8JXMCOth4nFOnTVp7GUTHIjKRj6UoiGEmjCp+qE0LnDOxnIKWA6FedAf6p3xOnsZ8iRIX
 aHEyXA2dd2dS9F98jiSvsZzZoHwXkvAAgVMlL2QS0DTH8pd1cu4Dxy
X-Google-Smtp-Source: AGHT+IGOj+chl34zJqRODVq6d0Pe4SCKUtukyWYRkvUai58J8rDJVW+UfCY6slt5f+GFNZnZophb1w==
X-Received: by 2002:a17:907:1c93:b0:b83:1341:18ce with SMTP id
 a640c23a62f3a-b8313411aabmr2091249166b.13.1767208533876; 
 Wed, 31 Dec 2025 11:15:33 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037ddffc7sm4042624366b.43.2025.12.31.11.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 11:15:33 -0800 (PST)
Date: Wed, 31 Dec 2025 11:15:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 1/5] net/zxdh: add support for modifying queue depth
Message-ID: <20251231111529.790c7d99@phoenix.local>
In-Reply-To: <20251220061521.289722-2-wang.junlong1@zte.com.cn>
References: <20251220061521.289722-1-wang.junlong1@zte.com.cn>
 <20251220061521.289722-2-wang.junlong1@zte.com.cn>
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

On Sat, 20 Dec 2025 14:15:17 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

>  
> +static unsigned int
> +log2above(unsigned int v)
> +{
> +	unsigned int l;
> +	unsigned int r;
> +
> +	for (l = 0, r = 0; (v >> 1); ++l, v >>= 1)
> +		r |= (v & 1);
> +	return l + r;
> +}
> +

It is only used during initalization so performance is not a big issue,
but this could could be optimized by using the compiler builtins.

static uint32_t
log2above(uint32_t v)
{
	if (v <= 1)
		return 0;
	return 32 - __rte_clz32(v - 1);
}

Will merge as is.
