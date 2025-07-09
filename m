Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A995C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 16:14:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ED24402A3;
	Wed,  9 Jul 2025 18:14:11 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 796AE402A3
 for <dev@dpdk.org>; Wed,  9 Jul 2025 18:14:10 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b170c99aa49so128504a12.1
 for <dev@dpdk.org>; Wed, 09 Jul 2025 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752077650;
 x=1752682450; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvx5uFisWwD46bu/V1sbWsweJg/WgxtZkHqAjcsQHss=;
 b=IjIQuh/srOyu2MjKTlRYfqGsPyVgcETKmlfRZCskBdcrucJY5hqIkN8zpp70YvG6z+
 3y+8gW5a/1UEpBnlAgT48PF71wM7toq2BXgNzQvlBsKXlmPpmHoghdYbLvJc9OfgLTwq
 kK1Jeb7RhuTpJBkHL0ZpptyswMjnQI6icUcxmelKQ/v8m0ZvIRHAhksGozlTMw8pTu0x
 b6rusafPtruFFDXVc9Nqm9axHvFUe1O68YO48G9zI8uONiAxgBNaArm9srFtHmhScVOv
 l8EIqnoYE9NGKxhZcUtgNEPnU6OmOJ0EK2/Em8zwWEE/BQqELeBuf0IkdlFmH2dsRCj+
 rqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752077650; x=1752682450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvx5uFisWwD46bu/V1sbWsweJg/WgxtZkHqAjcsQHss=;
 b=Vjj167MI61khAuphM1Vy/yktVhhBiDAKRByhrjK3jVAe+2s1KCfIQbA+q3xDdTophq
 ZyJKmnewScJ5HvRQxL/Hnwly+um8KqeBybCHuu9SDqIV/n8CLh/GpXMQEqq4z85p7sD0
 zvYIPrtg44GA69k2q+P7p/oVGQ0MBXqD5Qf9piQVq53xYSlwwrh9UMyZb5y7rz05aq2M
 HPixRHrRGvtgEzH/+WaQnDlAv5Vu+cBEXjtRgPjvjH4hEH9s0RW6WFHo+OXzadIS8LKa
 cTTNr+qv1vZ0Sey5WGowfLFXuqlkkLP9/GpTG/YFK2i3GI4uEiYn7qexz9HtbnzHck+q
 G98Q==
X-Gm-Message-State: AOJu0Yz0aYdCaeZz2/1nl4zW2/Q7mME8DKs22F8F6faTd8VhCS/S0iAo
 EytxOY8+j6cMVlo/a3JkDIduACQK9lcxW/Z7CGEDVCtX7ly4UxwjI/PrGuOtJv9NzpY=
X-Gm-Gg: ASbGncvGJ5oaNWVt5oop0MdXbLiTSau3HzbKiB+7s3JY2EJ5RaumoffYfSEylkZMGO6
 PVTHf8B7fWDxU8gf4eHzDHQvRyWT8ilZ/oSTRTj0xcHbfEEUzWDeK8uyaEGiHC/DLVleF9h48IH
 4feLgxXXmqaRzuWL8d79DuHaaVKzfgSKs7eV6CxHVqYcT1INRIGw9hLM5zCuz9fnO6kGmogIooN
 vOpyccR6wVK/KY0S0s64ghXA2Dte3Ib2t1HjFxRTfjBTQ7psVbUXhnf5gSLOb1v+ZLOPh45weYD
 wNLIMQIAfbZSlJP0QBzfyJpC8IXc0DTFU30PA3aNUExKZerUe12DR7VhVimb6XE9Wi8e+VaofQh
 rLMDkOn0UdS8Pw9xU4APGx6uK5teCFQYKDuDwlE0=
X-Google-Smtp-Source: AGHT+IEU1QT5r64Mkev9uGL/5qcRXRP35soj9IuVXdjTeq9HoAn7lOBKi3XX8eWwhpT6cUm0xrL+UA==
X-Received: by 2002:a17:90b:1643:b0:311:e8cc:425d with SMTP id
 98e67ed59e1d1-31c2fcff0e6mr4819372a91.10.1752077649482; 
 Wed, 09 Jul 2025 09:14:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c30061025sm2500084a91.11.2025.07.09.09.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 09:14:09 -0700 (PDT)
Date: Wed, 9 Jul 2025 09:14:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 14/14] net/sxe: add Solve compilation problems.
Message-ID: <20250709091407.2ab1daf7@hermes.local>
In-Reply-To: <20250709084315.9940-14-liujie5@linkdatatechnology.com>
References: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
 <20250709084315.9940-1-liujie5@linkdatatechnology.com>
 <20250709084315.9940-14-liujie5@linkdatatechnology.com>
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

On Wed,  9 Jul 2025 04:43:14 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> Add Fix compiling issues.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

Please integrate these into earlier patches.

Overall will not go further in review and build tests
until driver passes CI build tests.
