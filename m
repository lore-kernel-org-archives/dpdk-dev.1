Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77D1CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 17:31:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D367640DD7;
	Thu, 13 Nov 2025 18:31:17 +0100 (CET)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46]) by mails.dpdk.org (Postfix) with ESMTP id 6A0EA40151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 18:31:16 +0100 (CET)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-3c9991e6ad1so589908fac.0
 for <dev@dpdk.org>; Thu, 13 Nov 2025 09:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763055075;
 x=1763659875; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WF/nnVAbuUYEWbvvVMFNPEV2wwUFYnf93JKdeETQBFY=;
 b=JPqzZlJr1XxaZUJDEC1HOhA2LKOB7TU0vA6LeySFWZKywcg5TSTAGFRFjGfFnKV6fO
 Q4or++9U7401fE+N2V72HYZabmE0WMhUrMkdxUz5V5MqlFuXFu7EITcgBppjjjCuPjVO
 KIjhf4+rcoFsybfDl3H17OTAhxxxo1rTXqfWoC0s8vo91su2uYIeeIwCJ3W0+MbJg6em
 4IeBpNJAmr+HLIBDtpngpvzqJrmrFF2dZ7QvByW+B6tJZN8pENhjTpZwfwNjqLMh1U0G
 eNclIe525u/1x7SMeKyYe5uquxjKxlHZOCMaCaUJPQ2uT7TiM9NJ46Rz601ciCQ2j+pZ
 6bDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763055075; x=1763659875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WF/nnVAbuUYEWbvvVMFNPEV2wwUFYnf93JKdeETQBFY=;
 b=jDBUlVh997CIFIwaWecFJPzTBLsjqyWkgvfdAACEf9OSk9IA1/OxlU8/90y5ToMviu
 3ojAPt41Q+xSqn/vpJFcfiZZLyfb+/BsHh0Wtf2UtQSnvmB834KQax+6dnUYQaczCd04
 e9L31o4J7gFiaSAoHyGrlD76fzofYS25lRV+wDDGhLWYQBqS++4skN9aJs5+yBfopbjP
 Z06ue5cVyE+dybsbXSO0+JjrlFrbtWaD5BqX6dOKMPJsRr11sR+HfbmfufZ2YzQ+MpWe
 3kPs2iS9wOO0lSEqoY2qRJ/NszV9S+V8GxxBACtaBOlXssPpIW0hCYUvyYO0hBWdClUx
 7iaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhsbAdgOyVFM+HoHmZfxsRwCaoJH+zGBOfe3YvxYjrzbDkEbJZHV25tC9y+qwFIa8dAPw=@dpdk.org
X-Gm-Message-State: AOJu0YyMOje1KqFcRXe/1Z+C19jYgtqTAEX/cuhqi4YEysv39KFfIKu0
 FmBJe7B317prK2uASJ6T02hw1eG13uk+5VcubnamFuN+G8sB5dPrvZhyj1z02/kHnuw=
X-Gm-Gg: ASbGncv5muA1pqC9i/oXDLIHYeoJRKIqlRTafFo9psY8cHv3rhkDTpdeDnKQzvxP9L1
 OIk95ansMxn1Yi3Cd1rOUD6MTnlmEaeDEG2F9tcPwbS/2gigVEe0Zbf1AvgjOC928zbvhsx3dDo
 TlXfoBzAPJYUIBBJgz5ssdr7H6g3Yqw7g35DVr3ZXOSBplEq3dYDttvbmR7aD0KbGbyEhxlTldc
 1yU9Q9UzKOwbnKZrBRtzpJCJFn9nL8MF8SXoi94ZxuHurwpRShEeTNJvBrMebhc2yhOVPhaP5yd
 zjmfINx75uIjtH8Oastca6nuwJEdqfiKpCvBoZyBG/cF6JX6HOE498IH404PPZ3TLS20Dt0DGuk
 zyqNd/LEkQCUx+TcFzIOAIQ7/EG7pE3FgWmwyaZ7jXIislEAN13JtKjv+5fec1XCiA2PxmNBJrv
 v4hQ889rVUmvuD+ePmq9j7BagmLtSdUSjfFBf1mKOlS49P
X-Google-Smtp-Source: AGHT+IFgrnUO+CAIyhpVqMB1HmKDF3V/GWaBI6F9u0Ne1u4EKZrPtHgdSyD62FgfdWBnYmplERBpGA==
X-Received: by 2002:a05:6870:a106:b0:3c9:77fb:dc3b with SMTP id
 586e51a60fabf-3e84c660560mr2280841fac.18.1763055075433; 
 Thu, 13 Nov 2025 09:31:15 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a3bce15sm1548756a34.23.2025.11.13.09.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 09:31:15 -0800 (PST)
Date: Thu, 13 Nov 2025 09:31:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohit Kumar Parjapat <mprajapat@marvell.com>
Cc: Reshma Pattan <reshma.pattan@intel.com>, <dev@dpdk.org>,
 <jerinj@marvell.com>, <hkalra@marvell.com>
Subject: Re: [PATCH] app/proc-info: allow overriding defaults options
Message-ID: <20251113093100.7c3aa473@phoenix>
In-Reply-To: <20251112130326.2674728-1-mprajapat@marvell.com>
References: <20251112130326.2674728-1-mprajapat@marvell.com>
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

On Wed, 12 Nov 2025 18:33:13 +0530
Mohit Kumar Parjapat <mprajapat@marvell.com> wrote:

>  
> +static void
> +check_user_args(int argc, char **argv, uint8_t *arg_bitmap)
> +{
> +	int i;
> +
> +	for (i = 1; i < argc; i++) {
> +		if (strncmp(argv[i], "-l", 2) == 0)
> +			*arg_bitmap |= ARG_C_FLAG;
> +		else if (strncmp(argv[i], "-n", 2) == 0)
> +			*arg_bitmap |= ARG_N_FLAG;
> +	}
> +}
> +

There is no reason for the -n flag in this application.
Purely cargo-cult coding.
