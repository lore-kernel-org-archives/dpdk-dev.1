Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8703CC54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 15:21:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B4664060F;
	Thu, 22 May 2025 17:21:14 +0200 (CEST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id 0A04B402E5
 for <dev@dpdk.org>; Thu, 22 May 2025 17:21:13 +0200 (CEST)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-601c5cd15ecso7567436a12.2
 for <dev@dpdk.org>; Thu, 22 May 2025 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747927272;
 x=1748532072; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmk2seHDKaM5104SJADb9IWd4cprTmy1iMCFD/j+ie8=;
 b=W1KNRmOMiVHv+nomReG3iPFo7jnaYsISmwSFbf8ShG6HYTphEKxtcLTp94lKxPqSbK
 nEYE+DG1orpp6XaMwGUeBVdgQhYw6tjjQCfOWkGQkpHWB5KI/74YeukiqP1zOos7ZovU
 x0uhnh72Pz9MtQACAEt4QbbQGgKV9+JAyHZdyVHYnP2g+Y05k0MGRbMLFz9UBZt6+OFa
 UrrUN/kAnpGzlrG0M/KcQsV6KEzB2/0PkdcNmdYIwUa3aHsPekhcHd25QGV9r5CsBpzE
 jtecUWmea2RmvNgIpttRZfyxVDw5jAlHYMoRoDGndUbz3DYiKwtOybBgUWaeDGszZ+uJ
 ABGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747927272; x=1748532072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmk2seHDKaM5104SJADb9IWd4cprTmy1iMCFD/j+ie8=;
 b=kA3nUr03XIPIdEK/8w1xIGd3MqFuKsTYHpR8R2o9ahzz7hAOBP5XYbQcrIF3DzJrIZ
 g38YrKm84TLjvq2rxHzHtPR2zzKLK/huXYuU9NMYVR0adCZHpGgWc87o73Kgml9oTnrw
 zOh/PFU1dsRxG7DiDO2b/NFYBqBG/3Ln6jTO73s5MyVdH30J9q4KqtkGDjU9V6+ilw1q
 kL2mETCJbg97PsmrFIjNSRaKAfAcSj5f11kRKI5p6q+Ifzp8bTQubXlZyV99CldtCtix
 EqIIbPrnxj+tVt1zVQBW4zmTm6Usne4M7caG+2YkA911AKOV91DFFWws2/MQEn82AwxM
 7M9g==
X-Gm-Message-State: AOJu0Yz/qbHc4itwWyZGB5td14oaj3VX2E23KjWTWH3XF7HkZLPBzPcg
 qqIQPSE6LHL4JMUuzhl5OsI7ysEnf8NcUxHzj920ZQDDcIkyIqzgbHOjpy07XmLcU5w=
X-Gm-Gg: ASbGncu+8ZIswzhDcxzUtb47g4vGq9is7txsykC6GuJw3xP1orjCt8gbVqVHCEXtWO0
 +BVRbbsxrCZMgBpfa7krj41oOd8SFPW6yOffIRdskqdcVyFTRsaclJtBnXk8TjWwtr+hW58B5cA
 w9sSeg24xSihqKX7VXu97mb1j1rZnTMG/fIG8+bk6ggpYg3FPu5pU7r/nHeYFH5El+iW4MMSC9u
 5X85Zu2g8w3q7C0EI/9XMpFCHes3UPN9MZhBgT05EugMeBRVtGub5hHpJ4JMS+E5Z92gpF9A+h6
 jurSCQoaQwFyhzin4mtFdaLxs/MyBpQXNUSkNkHDK0YoPruEZ2+7c3bP/l3l6un60J6Gt2xb2ZZ
 GI4i+NZsUZNDBzMgvVUAYsc2goI0R
X-Google-Smtp-Source: AGHT+IHXx+HxUmOO7MLi2FPzi4I2sB/BzEz+1pV3tysTSUwCkNxuzm6ZGINF0V+4m99UXkAeTxeeNA==
X-Received: by 2002:a05:6402:35c7:b0:602:1d01:286e with SMTP id
 4fb4d7f45d1cf-6021d012d89mr8881376a12.6.1747927271881; 
 Thu, 22 May 2025 08:21:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-601e657a0b1sm6631024a12.45.2025.05.22.08.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 08:21:11 -0700 (PDT)
Date: Thu, 22 May 2025 08:21:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: farooq basha <farooq.juturu@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [dpdk-dev] Regarding HQOS with run-to-completion Model
Message-ID: <20250522082105.2aa03935@hermes.local>
In-Reply-To: <CA+xuiv0gKOp=Ukd=Nd-b=CV3YvA8P+HpR3PiH4h+9Dus9-vK1g@mail.gmail.com>
References: <CA+xuiv2jL934JR_QyLC1M5A+5dGPzw5L0=4RoS98eRjueA+9-g@mail.gmail.com>
 <20250521071845.50d6f9e1@hermes.local>
 <CA+xuiv0gKOp=Ukd=Nd-b=CV3YvA8P+HpR3PiH4h+9Dus9-vK1g@mail.gmail.com>
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

On Thu, 22 May 2025 08:15:14 +0530
farooq basha <farooq.juturu@gmail.com> wrote:

> Thanks Stephen for addressing my queries , and it is helpful.
> 
>     One more follow up question on the same ,   Can DPDK HQOS be customized
> based on Use case ?
> 
>     For example: Hqos config for one of the use cases ,  *One Port , One
> Subport , 16 Pipes & Each Pipe with only one TC*.
>                          16 pipe config was allowed but changing the 13TCs
> to 1TC is not allowed per Pipe.
> 
>     Can I still use 13 TCs but use the QueueSize as 0, Can that impact
> performance ?
> 

No. Current qos sched code has hard coded assumptions on number of pipes etc.
I think it is modeled after some carrier standard and is not generally
that useful.
