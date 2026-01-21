Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560BCC44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:33:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42CC242DA3;
	Wed, 21 Jan 2026 18:33:15 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 924D640261
 for <dev@dpdk.org>; Wed, 21 Jan 2026 18:33:13 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47ee807a4c5so970945e9.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 09:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769016793;
 x=1769621593; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5KULQiHZwpPS/C8ipIVa4zUg6z3GlRLvJQUgMmQ7zSc=;
 b=MO9JSQkJl+QdQ9G3m3xLDfUgB7rw+tjF2CO4JwW76g3RnfyfpPvViilwDEvNaGjVEq
 GHcmaDgpRiNyFAEkK9ndA0rA0pce7dXwxrViSyu75J1i5wPkD6ypEvdnxyYo0skMG3NX
 ZqOVdZ++b+mdpmIYavQnUFc5S51RVQYMRTbF4vo+RbFgbyno25xPvE+KFJqRltzDvf67
 5T9O7GRJL9x/03SEimKBQfCc8Q5y9YmorRQP1GBqx/CvcVj3MFM3zgCMN6r8on1wQrMx
 +mFzmGoNqwyGcm8q7G5EkJlQS/Pbne0dpf2EEoSaY1NZdZOlKEauoeh4PfGeoP/3Wiqb
 oPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769016793; x=1769621593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5KULQiHZwpPS/C8ipIVa4zUg6z3GlRLvJQUgMmQ7zSc=;
 b=v/D3VmJOZksgYutrdhJslpHlhAocGioaOXBOjUHTHxeSqQwMpqG+quml0/ooS440bw
 tXWdLV5nag3CmVvPa44YSm3LBKZIpXcmVqVzeh6dKlVAeYtmmGF5dGL2Xj9aeZ7WwPAI
 GsDJRm+REc6tmJ2Loft4zIaHmTlEmeO4hJAc0YXD1/Hvt67Kh9ufCCNcES24DVIbhq8H
 0ASLk9xeYIMTjYRdNL2y4gWYlCr3G4ADrINHE33FCyC6tcFDJH1E2eyga4ynRhd/TsFz
 hcevfTSvBtRuLG6/qfkIE39LBWmQpiZQV4z/9q7S4Iy+JCxbTfPYTgwOd9RTc4mnJmiF
 9AfA==
X-Gm-Message-State: AOJu0YzIf3G95IJP0dhMyi4DVQu5USL4BBKAj2aIO89hOW9Is/MO0L95
 wdNZse9PmOM5dfD4WXLetOR/l9eFlXo51dnVhyO58HvRMrnjAE4mRx72qZ7ml2vJcxI=
X-Gm-Gg: AZuq6aKcTlg0pGwysm/5DsAzrYSNX21RV3tnWcWVFLYiAq3dL5HUjzGYl1J5UYz2tbN
 ZGdnkynumaoilEc/KyZPZ2Md/XwW6ZRhfeVkfB8QC3Q7i9b5JcjkfSDuXoLZA5E4VC2ReviPzNX
 h7WezhVLh3rGYNSGw51pgkQfjyd04DPbYN/HRcr5ppST5s4eutsZVjfq+CQ8hSedM8X8RhWO88M
 IiQnHZr/8xEdGi3mERUzBz3mrH8GPE1RgPC2K4GeLdnjdczxMeM5tTsJ3KLWiUqCbqSJ5lFujoz
 O4oOifpq/9/mq8bXCXgomgsqSQ+/SdQiAYh1/JPfmB7I5+m/awVPGhKUWh4yoZSr563FB43Acj/
 ENeqS7TK6be1xS6s2x4L3nJUj3iPs8pmi3tMJR+LLiC6/eHQkYq0r3vM67rAqOrGZyXjAfxSHlF
 CYVZcre5CzckHBwplIBgFWbVkklDrpPMKb6GkZ2kzC8z0S4zhPlXeL
X-Received: by 2002:a05:600c:e41a:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-48024b8a77bmr234867045e9.31.1769016792999; 
 Wed, 21 Jan 2026 09:33:12 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48046fba46dsm4783255e9.0.2026.01.21.09.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:33:12 -0800 (PST)
Date: Wed, 21 Jan 2026 09:33:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 3/6] net/nfb: update timestamp calculation to
 meaningful value
Message-ID: <20260121093307.299c84f0@phoenix.local>
In-Reply-To: <20260121170120.268553-4-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260121170120.268553-1-spinler@cesnet.cz>
 <20260121170120.268553-4-spinler@cesnet.cz>
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

On Wed, 21 Jan 2026 18:01:17 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> The resulting timestamp wasn't monotonically increasing value.
> 
> Now the timestamp is value in nanoseconds (Unix epoch).
> 
> Unfortunately there's currently no safe mechanism in nfb-framework
> to get ticks from hardware to implement read_clock function.
> 
> Signed-off-by: Martin Spinler <spinler@cesnet.cz>
> ---
>  doc/guides/nics/nfb.rst  |  6 ++----
>  drivers/net/nfb/nfb_rx.h | 13 +++++++------
>  2 files changed, 9 insertions(+), 10 deletions(-)

The patch is ok as far as it goes.

But the best practice in DPDK for drivers doing timestamps is for
the driver to only put a timestamp on if timestamp offload flag
was set when configuring that device. For the case of multiple devices
that means that one device may have timestamp and other not.

Also any driver that supports receive timestamp must provide
a read_clock operation. Otherwise the application has no way of knowing
what units the timestamp is in. I added that to the AI review
script so new drivers will get rejected with out it.

I suspect that in this drivers case it is only used in systems where:
 - only single instance of device is possible
 - your application is just assuming a common unit like nanosecond.
