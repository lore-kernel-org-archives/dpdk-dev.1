Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39B5CA5FBA
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 04:36:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B34D141132;
	Wed, 21 Jan 2026 05:36:22 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 3F48B4026C
 for <dev@dpdk.org>; Wed, 21 Jan 2026 05:36:21 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso3888225e9.1
 for <dev@dpdk.org>; Tue, 20 Jan 2026 20:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768970181;
 x=1769574981; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVuE3Rt8t361kwFZe7vxe424ahJbozZx9Qmq7yCBU94=;
 b=v9RDGFlP5M9TKVRaIpKNPDQiUYdyvMuoAKEz0mp5PyNjwO3u5Gij2e5swhM2kqGS1s
 LyzOpFtIcy20t7rrgDMnw+9/+K0n44cK74jjeqtTaGcoGoCThki4zdCXwwf63jxaViKF
 pkd5PkZFFFJemBdaryOG4yAGLxZqcf9E6/1s7zljrVOpwvc9kFCKzZAeuNyItoy5J88F
 /KufAZiiB/ReSMjxe257qqh7O/tmbNgCGiXzQ50h1DMzsI0H0NTcEqHj4gMynNj1SBiP
 ik74xmxJV24DqUW3UNWKKsXb4KK2XxG/CmF1I8tpXyRnCmnQqyddpiwUUTNjUWa3V4WZ
 1Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768970181; x=1769574981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VVuE3Rt8t361kwFZe7vxe424ahJbozZx9Qmq7yCBU94=;
 b=ptF4CJaXUH+JC15S2T2d3ZxV7z0n9ynvlW5iOj9kIC7BwmvLrTUNY0MtA/QCG68XL8
 z+vUVV0YA+/8ZOJ/+FUj5mA/9Q1yKPdMOPv4ExCPtYGcP2sBc5pkkWcJe3gGplSAvA0h
 O79Cgh2ZyEL9oerFClCHnmi30+UGUrrla90gc/FoaGWu9bzILvfZt0KOvVK7lOeM0Usm
 svxYjHMzl6VEBEsEvm/oLE04M2rUQ9Yl2kdaY4u23XX9QUlSpfmr643295Cak8FbOfcC
 BhOyaWmG5cfa9ePTWtpGjxqPdvIYGAvT1fk3eWSnjfD7luFx3u5/PZzpMnZ1j7ZRNbLF
 PP0w==
X-Gm-Message-State: AOJu0Yz+HuropW4RudJ2UTVeWp5zZ0yr7K+cCYWQTmYBdIzW5ymWb8bR
 2wxnpofgBFJshdftzPMaI1GQqrJQha7faWsJtkffLQ3Ynkf3KoLlxRTewm7dM08AQI0=
X-Gm-Gg: AZuq6aJhRQfcviFcgjQkngj/PLywh8brw83koy5GOvJ66dYYF/fx6jfJKoz5nlWqpOH
 NVakDq2/37EZ1gbNyGzeB6skrjwjQKlDtKkDqAV1zvLtVQMWO0LCHVt9Ftfw1Xz+bU5yMVPmbfB
 Q8F1w7l3yAtdXEDpGxgU/RTje/X3wmQyI+E91+acdmgCqczeR8Sqy9pwmnOv1+u+OSl5a7YMxrQ
 Q7QQHXUwZNE7b/RPlTq9Kk1NkOqadAoS2jeWO//q6G7dLH0MKF11aStNIYwo0SBl9zGgpmngW+w
 CPeGkTjYjnL19oYfKcVJm46nUBm1Cqad8rm1a+5OJ0DKpmIkvmgL/hwkYFtdELRqruKeG4136eU
 trBcQEbRuJn/xlBKBwv2mbcTL1dpYI/0s33lGn7we1zSXeG51y26OjxQC/BO4xKGSHRNG0BbjBi
 57QSOn7Yac0O3J8uwOnPc1ms4k+hwIjCppSyd9xJ6oKSmYkBYNJRCzTs2aZLX+yIQ=
X-Received: by 2002:a05:600c:5593:b0:477:a71c:d200 with SMTP id
 5b1f17b1804b1-47f428f5e8fmr173334995e9.11.1768970180243; 
 Tue, 20 Jan 2026 20:36:20 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042bffa0bsm10001805e9.4.2026.01.20.20.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 20:36:20 -0800 (PST)
Date: Tue, 20 Jan 2026 20:36:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, stable@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon
 Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v3 1/1] net/nbl: fix issues reported by Coverity
Message-ID: <20260120203613.6f292ccf@phoenix.local>
In-Reply-To: <20260115032744.62449-2-dimon.zhao@nebula-matrix.com>
References: <20251030033619.3386064-1-dimon.zhao@nebula-matrix.com>
 <20260115032744.62449-1-dimon.zhao@nebula-matrix.com>
 <20260115032744.62449-2-dimon.zhao@nebula-matrix.com>
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

On Wed, 14 Jan 2026 19:27:44 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Address multiple issues reported by Coverity static analysis:
> 
> Check return values of ioctl() calls for NBL_DEV_USER_GET_BAR_SIZE
> and NBL_DEV_USER_CLEAR_EVENTFD. The original code tested the return
> value without capturing it from the ioctl call.
> 
> Move debug log statement after NULL pointer validation in
> nbl_dev_configure() to prevent dereference of adapter before the
> check.
> 
> Cast u16 operands to u64 before multiplication when calculating
> buffer sizes and offsets to prevent potential integer overflow.
> The num_txq_entries, num_rxq_entries, txq_buf_size, and rxq_buf_size
> fields are all u16 types, and their product could overflow before
> assignment to size_t or u64 destination variables.
> 
> Coverity issue: 490942
> Coverity issue: 490943
> Coverity issue: 490946
> Coverity issue: 490947
> Coverity issue: 490949
> Coverity issue: 490950
> Coverity issue: 490951
> Coverity issue: 490952
> Coverity issue: 490953
> Coverity issue: 490954
> Coverity issue: 490955
> Coverity issue: 490957
> Coverity issue: 490958
> Coverity issue: 490959
> Fixes: a1c5ffa13b2c ("net/nbl: add channel layer")
> Fixes: dc955cd24c8f ("net/nbl: add coexistence mode")
> Fixes: 93b38df5a2ec ("net/nbl: support basic configuration")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
>

Queued to next-net
