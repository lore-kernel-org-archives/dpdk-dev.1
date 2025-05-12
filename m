Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C301C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 10:12:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67BE4402C9;
	Mon, 12 May 2025 12:12:51 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id A59944025D
 for <dev@dpdk.org>; Mon, 12 May 2025 12:12:49 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso4694219a12.2
 for <dev@dpdk.org>; Mon, 12 May 2025 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747044769; x=1747649569; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6ZVvsgyrpkkLEjUbuoaTyayp7fnzXlD7VYm5idvztY=;
 b=QNp5FjUDPswfpYPlNMYP0y6wPOmtuSsFCCO8iqaVKE9DSjcQjnB1v7Dsrpk9J/vysL
 G3zUbCnpTuS6JOriT/XfcJ+wj8EEcVyRRIki1CZjrlnpu201J9p5SFKOD3Remiyt68yR
 VojlVglhiejW6ixirylk3X7ssC+DF0JkMwTtG0oNlw8SqTTQHwTM/DEn0lzQM1x3Rm9n
 SoMl4jxjB7pCFIO+/tTFnR8lPgqrEYXVm+ALBvZA1k0Pxi6plJ7qhLpB+4MPDCYG+wam
 E9ddXMCvz5EoSCY6de9mr9mlvhgt3EbhJVcTiU01RS772UkLnoYt4sch8cmGX95bOr3w
 XG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747044769; x=1747649569;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+6ZVvsgyrpkkLEjUbuoaTyayp7fnzXlD7VYm5idvztY=;
 b=dNas1x28wXJ34ZPLrk2NRqPd/GCZRx79frR0+yLPrxfc89lmr/mJJMsP7C+0yPAS69
 sok+jVeBF6u95qMI49QvqL0I+9Atlom9keHmQ9ENjL542wUXbqn1DZnGmh2+hWR4kM0m
 NMQ4QBUyStFJLn364TmRxbK80IKw76Yng1cJnuIednqEWCa5MrGi6udHL/x1oNJywewJ
 EeA6VlxYthceC+x8oCYgx0kWsvKoyyrnxTcmNuH9y43j83AQ/0tNuMlVNMiWEk7tGb6a
 8NNT8a1fukx1t8ea7+RRXheZGtrjPhgQOeZdSzlrtWfbnSf8HqNO7IEkWsMTo1tBrP7o
 2ItA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+h1Q0eHDLyT7pG1aslD/AB2ZpOsHtTfQBesRANjLegL5ZHcmej0EHSZbv3ElB+HH8uPA=@dpdk.org
X-Gm-Message-State: AOJu0YyRDRHXPiLjViC03tlOiwN+Y4tFnj2f1b3ErQU1zwbMCQHO4Pqy
 dxIYxLQdIsLzHsQFn0wNeT4wbSS6FQ9nuwUMkap+pKpN1BV1cbHO
X-Gm-Gg: ASbGncuChp42uYCsfeiKXs43rgLAsnslWxkLXhatgEWhDpVkVFZ2SXDycGdAbhKgz9N
 tB8xi6QoM1wZ63pDm8n1KzFbT7ydKiZQ4yPwyLzSAcoLjModSucyWfbsnlbKn2J0Lx9VJ/aHard
 SKYnqvKKeiW2lJSrdiraHv4+wDZ7MjORY2jZlBxKGx9LY+P12dJhwEZOe8U7p5srAkaQvzVbB/r
 6noABukzaDMybdR1Ot2dMLeVPfuX26oeG0HkCE9xNi8VNKqkiTbjfnhCjAMxYESV51Ccxe70MGs
 QnL86YWd7roEngIetXdYdt2rsh6vuxHDYDjALzzmrpDOSO9sEDbTn4NFemwgbAPjzJvK8q+cRo6
 y
X-Google-Smtp-Source: AGHT+IFxdTJ1JIZYPc/lifqXXrT7qQiW4HKPEUvIveuzEUHoPbGlaDZOkH/hJW++uOErYpAa8VbHpw==
X-Received: by 2002:a17:902:e54f:b0:224:191d:8a79 with SMTP id
 d9443c01a7336-22fc8c7b6bbmr179891935ad.27.1747044768710; 
 Mon, 12 May 2025 03:12:48 -0700 (PDT)
Received: from [192.168.31.141] ([183.134.173.124])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544f9fsm60215605ad.31.2025.05.12.03.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 03:12:48 -0700 (PDT)
Message-ID: <0a6576b7-5981-4a7d-b33f-aae011b86a00@gmail.com>
Date: Mon, 12 May 2025 18:12:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net/mlx5: enhance log file path
To: Yang Ming <ming.1.yang@nokia-sbell.com>, dev@dpdk.org
Cc: bingz@nvidia.com, dsosnowski@nvidia.com, stephen@networkplumber.org,
 julien.meunier@nokia.com
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250321132750.4237-2-ming.1.yang@nokia-sbell.com>
 <59bb400d-5e49-4ecb-941e-2513894d6930@nokia-sbell.com>
From: Moses Young <mosesyyoung@gmail.com>
In-Reply-To: <59bb400d-5e49-4ecb-941e-2513894d6930@nokia-sbell.com>
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

> Hi Experts,
>
> is there any chance to review and accept this patch?
>
> Brs,
>
> Yang Ming
>
