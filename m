Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE995F53D65
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:30:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 321F44025E;
	Mon, 16 Mar 2026 16:30:44 +0100 (CET)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 90236400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 16:30:43 +0100 (CET)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2c0bb213b16so1103145eec.0
 for <dev@dpdk.org>; Mon, 16 Mar 2026 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773675043;
 x=1774279843; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0wGyf9Hz4ip/iCTaHZzCdS195W7QIEQnc4KenxqodU=;
 b=w9npHteI3bOU9ZL7+q5e9UfoC+wTKSJqKjZ97G7RMqFPki+h+NVpF757VhnTZXIsgy
 s2TvUllT9hJbN02LIR3rt2AO9GsZf5TRI0VOz8z8QC1HfhT5++tUkJPJx4kaLfAe5IzM
 g5rBJ3U0nJ4+2iE1kgT5aZxi4tdaOqjNy8BAwIxDx/KCA1JAN8OG5dKelYmWZq4+FoRg
 Q75cdd8SqUGpWl9I3fpRmq/YyWE5ADgKb9dF1rRVbRtlTbIWrfyA053gl4Cm1feZane+
 5BLQAz2CFol5oSptqQXJq8iynbcs/lwjVJ2QiZQIr7W86qAsMKO+i/LYo9hxkNrR5xDK
 l4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773675043; x=1774279843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h0wGyf9Hz4ip/iCTaHZzCdS195W7QIEQnc4KenxqodU=;
 b=kTW8JaA7sMh7l9lwNIo1UQFL7xnziEUcMxdW5LmClNDB6nqWqWuaFTJcedyIDX3X1h
 IvW4hFwSJo+4vBPruH4C+faPDRXrwk0+be79H2T25we6ezFBiNaMqPENpT3NpXfd8be9
 aqP+MBW8gHOSHcH5TGbgOfvK/WbM9s0Uq5ofLNVC/DFEQZgc8qBit1UzxZ0q5lLJoL4P
 Off2nng65/bTovl9fVVbqHdWZ0N9LxI70nUOkEUwVwQsiZS3h/ifixhlKRY+h8RScXzi
 TuPE4pC0oNcLUci8D1TR4PZs4+ZZgqeTrirjwd4cDV0lo8gEpPVc5xmFIcTgx5nzY8Hh
 AtVw==
X-Gm-Message-State: AOJu0Yw7SD0yoV3vKtf1jVWZCji9RZNtOqpRNRN5U89zC7+KGbZqaOBN
 RCC+qKII7AxM3+lvxobBPzYZahztS6xlnyxIb+8e/Rnh7doQO0EvZzP1tRma4pAMDSU=
X-Gm-Gg: ATEYQzzrrIv2A46cJ+GkESr+eT9/qL5kQmVsVjOXRTxsQlg233hADZRbXxSXngVB1WB
 uPVb7asZhJfOXZf+BLqoOMmcGTjODreYatdhvxih6W+s9NHbtmPWdEsCnQoC6KwBGnpVQMlJjZr
 yWT/AnekKid4CBPv4zylUatF+0Tng8tcuYJoYZT+u8odzeduzK4pFpaALu9Q3Ruc5aMBU4GqXqg
 fpeCWJ20EZTla0ptIvDibO5zM/wC1rYFYC8grqItxXAU4zuBe790Kn/tISDZbjX4bi9ygkjmRPP
 yZpd9kMNzcTg7ZTWI7m9fkkawS5h069296dvr7dAXkYmIOwKchjgafFzEo+uV3dJgtVVFIXnnk8
 CYDTWbO/ubHtMM73V1kRWbuDcjfIGzWGB8b9MztsOoYHBRYEOoBNl/MqS+YWA9ZPlt1L8WIW7bm
 6be+f/WkX/XO1xY+kjbv7On+ZPYShw3zJT8jp9lnIXyFjLdA==
X-Received: by 2002:a05:7301:1f17:b0:2c0:c63d:e02e with SMTP id
 5a478bee46e88-2c0c63de76amr1928375eec.3.1773675042542; 
 Mon, 16 Mar 2026 08:30:42 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab5706bdsm17664803eec.28.2026.03.16.08.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 08:30:42 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:30:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] fib: fix name of main TRIE instance memory region
Message-ID: <20260316083039.4d2adef2@phoenix.local>
In-Reply-To: <20260316130531.1671904-1-andrew.rybchenko@oktetlabs.ru>
References: <20260316130531.1671904-1-andrew.rybchenko@oktetlabs.ru>
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

On Mon, 16 Mar 2026 16:05:18 +0300
Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru> wrote:

> mem_name was built, but not used when memory is allocated.
> 
> Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
> Signed-off-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> ---

Ok but the name argument is only used for tracing.
It can just be NULL
