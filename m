Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324F4ECD985
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 16:43:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E4AE40684;
	Thu,  5 Feb 2026 17:43:04 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id DA7E8402E6
 for <dev@dpdk.org>; Thu,  5 Feb 2026 17:43:01 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so10531925e9.3
 for <dev@dpdk.org>; Thu, 05 Feb 2026 08:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770309781;
 x=1770914581; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vy/neFS/tU5JdytZaowKlD99qJ5pHq8jx9ti/LlQKw4=;
 b=pa+7TuodbE9CHwK2UXnn/fFMAzrje2NTDjDOeAv4EczgIoamRpxvtxq2A505LIp5G6
 eEsy6I+bJBaQ+KREUzgiLzWFyZXYDS5HvTJktG6u4eiSYyNK9IpNo0GIde09TRG8+tVn
 EHps/wQ8ijrwdZLlia8wNLz82Iy1/Gjz1jYDGI3pB6oHRJx8I5WK+WS0OE3OnZXT1Ulj
 zH4IByVnNO963/CUHFeeq+OiGmVXIvEG1/xc2/Bet0ocbAE7TgPEsSajI66uH/udC+kC
 Ksm430ywGNqrrFt4RTFh3puAFrbugXnibuzlCWSWJg2o/YSeXuTlEGWwnqkiqQvTv6zH
 QgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770309781; x=1770914581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vy/neFS/tU5JdytZaowKlD99qJ5pHq8jx9ti/LlQKw4=;
 b=Xa18VLauhiqCzMaY/Vcw3q5TIJvKKqrcVuLgHPKM9dPZx0FNK50ZLIY04ep/JlgPB1
 oFgklAI2sU6JxHsuhbo9pCnfsr0Cs3xX4Qlwe0QTSC2wHD8diYLWXtRF5Dvdb9eudPxH
 Ley1LTRA6Xt0P6qFiKsai4S3ouZM+lMLBo+0SINz3UhRx8ULyqfuwQwRRQVZkFkABxI3
 u3WxMvSctsYwWBGXMKtFcF+1v+cVR24f8x230G28d8nnqhDNBMDM73gGinFE2KVSguG2
 HM6v/uJ3JfYiP4vVDOct2zJPwFaNEMMy1D7odXctlViT6HJoGxQukHadteOuRTO+F7yN
 THAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWIdd1DEhNOBDzN4UkSoBEG39hBE4u8F5dFnkPKGIUHKFBpgzBlOKyqUBcsEZ9bhcvhg0=@dpdk.org
X-Gm-Message-State: AOJu0YzmqxXBDzKHT5l5ib4Iztubwt8jHxEs4MouU3PK1qyXw4sbgZ0F
 8HEVtxbKOkA3zDQ7lXdO16CeLqyHtSe7M1WP4bo/u38PEwMElB3GeK4XA3ufjCYLylI=
X-Gm-Gg: AZuq6aKfDF5zSs9JdrNOzJz6NlMwE/xeE7MWK6hLw84pgLu9YQl9aHpdZSamczADceH
 UGur2R5Vde9Ei3b7HZxN7B89Txz2Idad6i3S5EHvAvXI4tcCaItkmkVQDme/WqNbGhYk2WPc94L
 jQ2+sUgYTxvG00Pm/jFnPQMw2tfjTYjO2URwLiVNtZgZqU1O+6RBuxBLzqNPySdGkrspZDHnqls
 ClmOnQtIvI0uTvHwnCsYnGZF7euL3Et9TUhpCYDnRfvgIQM5ygUOtxpjgV2IZG2qGtXF6ziZvKP
 43rSKTHv4r8UubxPjjbG/ATo53UH2n5luzdUtXtmf208mdV5VALS8/JsHkAwDmk4FDbC9PFfuHw
 2Y086bqhBwga0Hdsb+wOlqSZWsP88nn7V6n0u+vD+LHoGtd9kYaCk6qcxD3DdSJ7uJaow5Qrk9a
 MPrx0j9A+62CZ0iXc4jVBa6V/3giNoN0pC1Kcok5FlhdFc0pNqTOpV
X-Received: by 2002:a05:600c:c4ab:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-4830e9793c8mr101449395e9.22.1770309781183; 
 Thu, 05 Feb 2026 08:43:01 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d3e245sm63218695e9.8.2026.02.05.08.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 08:43:00 -0800 (PST)
Date: Thu, 5 Feb 2026 08:42:54 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bing Zhao <bingz@nvidia.com>
Cc: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: Re: [PATCH 1/2] lib/ethdev: support inline calculating masked item
 value
Message-ID: <20260205084254.29f823c9@phoenix.local>
In-Reply-To: <20251117075407.9632-1-bingz@nvidia.com>
References: <20251117075407.9632-1-bingz@nvidia.com>
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

On Mon, 17 Nov 2025 09:54:07 +0200
Bing Zhao <bingz@nvidia.com> wrote:

> In the asynchronous API definition and some drivers, the
> rte_flow_item spec value may not be calculated by the driver due to the
> reason of speed of light rule insertion rate and sometimes the input
> parameters will be copied and changed internally.
> 
> After copying, the spec and last will be protected by the keyword
> const and cannot be changed in the code itself. And also the driver
> needs some extra memory to do the calculation and extra conditions
> to understand the length of each item spec. This is not efficient.
> 
> To solve the issue and support usage of the following fix, a new OP
> was introduced to calculate the spec and last values after applying
> the mask inline.
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> ---

Looked at this patch again:
  1. No API/ABI breakage adding a single flow type is going
     to work great. rte_flow_conv_pattern is internal so changing is no problem.
  2. No need for release note for single flow change.

  3. Do need a test to cover the new code. I know rte_flow is way under tested
     right now. Maybe a chance to use AI to generate a unit test for rte_flow.
     This is important because it is a bug trap to add code that is not covered.
