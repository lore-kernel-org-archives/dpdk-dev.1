Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49C9ECD9B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 22:17:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 290E34021F;
	Thu,  5 Feb 2026 23:17:36 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 961114021E
 for <dev@dpdk.org>; Thu,  5 Feb 2026 23:17:34 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso15240425e9.2
 for <dev@dpdk.org>; Thu, 05 Feb 2026 14:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770329854;
 x=1770934654; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1LV7jxV9uKMiaWan4z/YSuAq31PdS/5SjwDmgn+CE4Q=;
 b=yMyaN8bBOLIr70Rxo4Wv6wWdh23EPaDP+Fj7Umphy/kH5AyCh9GsB8KqvpVVj5z1T2
 Dwsm5PVzslk4+1Sre3KnsFmrblk7CUP7/UEUtkgXR0Y69mvojzwsQCvsscqBqWck8y6M
 aSOtoqoqH9qWibyBOo+ourxmOeRojQ0L/Y9VOx+4cDAVqHMrJSsM2Is4N2QtxVR25I03
 donfbTUmmfTPtPU1z8qiYj0J/IiH4fc6SbeCOmdx7Gs8IRRp9Z/VMb7CpPzvYjkdEDBH
 ZU8SlXVP/U87vTwpJn+O9ECJBA8kCejL5MZPFtUgrcPNrc1xpFqXhe9RETTBiNuuiohk
 Ua2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770329854; x=1770934654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1LV7jxV9uKMiaWan4z/YSuAq31PdS/5SjwDmgn+CE4Q=;
 b=QBZr5l6J6/NZTEhltPaJ1UxtDOjJdupNH8zDIIvIwGhshrlHidmlxBnjnfBKFdGaxe
 mxhqND/lEIQZJ+sz2SYjYJe7zordvy8CUyZ9AB3mG/npDBNMt7qMEoPY+HFMHmmYGVOK
 NhwvaYwNLDJnLdaym5dI9T9BV1fIkkCmRvvL1mlsRnmyrvd2ve6U1iGYBO6q7ImBPM+o
 pQ3HkhVrVu+M/UmmECUKWRMFGcjxT1SSaDGcx7qEwQrmDiRGPerCfMSX/QTwyJ5k7i5o
 /HX5egyh5vHSTghSq89+HPspSdqxLlNs2DaN3nvykkeU4aTgCtxZFbKBf2K3S/vJAds2
 PRmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrm6j6Pa91A7SDI0TXp82OiU+nGFTPYB8Zvn1dsRr8zsI6xanf5Iu70M7Tax8uGbgYfz0=@dpdk.org
X-Gm-Message-State: AOJu0Yxkml2IsxjIknmc5e6CLMomPzVynVI0QcybVA2437vjC5Vv8zoU
 rdnqg6min4A3OyoVa3vMata5GUN3SdvVH5rLzaP6Qr29+d4PmGGcDUi73DCLUFe0uP8=
X-Gm-Gg: AZuq6aJtn9cmX34qGWneoelLiBvJu+Mqr3r+U/xAKSGD3GX+U4oKk5AbIS/4YHlyKjF
 1vVHDuDtZzEbNShfdl1x2zi7rTF9ejlGmyt8Mvv1Gov3ydGB+L3cS/YCzVg1mwNwGn8nP1pAJS5
 azF5HD+nDaPqHH731GSx7rxERo4owqBqi0ueo9TsDLBwoGfN22q7OUPhhdYsXXNufQAJC9LvuEB
 xPcHtuTy6lsSQkV6QKiV/dbn+tZbJQUKZ0aXBidFrdi7H30EDzQnXW1QfIhh/tf5BBRXGR4ZZzC
 Lh9NDNyUft/Oy1c41lv5ZykRPBOeJ+tzf5314NMEMqZqZqCLFH9hVQaUzldrIw9hfyMy3rajFRv
 E+zPFffOOsN9fjj7c84GGgt72bdjyFoL5QDPEIm3Y07jzB/FHQn3iVNjIai3pk9QvTSN0MKwdrB
 TxnQYr5IB2f9MzFg1Pd+pkAWq2U0hDdeuxlUUwIYbt7LL7cvmn4nBB
X-Received: by 2002:a05:600c:1f16:b0:482:eec4:758 with SMTP id
 5b1f17b1804b1-4832021fe37mr12070825e9.26.1770329854004; 
 Thu, 05 Feb 2026 14:17:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436297460a5sm1241883f8f.32.2026.02.05.14.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 14:17:33 -0800 (PST)
Date: Thu, 5 Feb 2026 14:17:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, Ori Kam <orika@nvidia.com>,
 <dev@dpdk.org>, Bing Zhao <bingz@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH v4] app/testpmd: fix flow queue job leaks
Message-ID: <20260205141728.0622320b@phoenix.local>
In-Reply-To: <20260203093718.561443-1-dsosnowski@nvidia.com>
References: <20260112173648.1528180-1-dsosnowski@nvidia.com>
 <20260203093718.561443-1-dsosnowski@nvidia.com>
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

On Tue, 3 Feb 2026 10:37:18 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> Each enqueued async flow operation in testpmd has an associated
> queue_job struct. It is passed in user data and used to determine
> the type of operation when operation results are pulled on a given
> queue. This information informs the necessary additional handling
> (e.g., freeing flow struct or dumping the queried action state).
> 
> If async flow operations were enqueued and results were not pulled
> before quitting testpmd, these queue_job structs were leaked as reported
> by ASAN:
> 
> Direct leak of 88 byte(s) in 1 object(s) allocated from:
>     #0 0x7f7539084a37 in __interceptor_calloc
>         ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
>     #1 0x55a872c8e512 in port_queue_flow_create
>         (/download/dpdk/install/bin/dpdk-testpmd+0x4cd512)
>     #2 0x55a872c28414 in cmd_flow_cb
>         (/download/dpdk/install/bin/dpdk-testpmd+0x467414)
>     #3 0x55a8734fa6a3 in __cmdline_parse
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd396a3)
>     #4 0x55a8734f6130 in cmdline_valid_buffer
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd35130)
>     #5 0x55a873503b4f in rdline_char_in
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd42b4f)
>     #6 0x55a8734f62ba in cmdline_in
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd352ba)
>     #7 0x55a8734f65eb in cmdline_interact
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd355eb)
>     #8 0x55a872c19b8e in prompt
>         (/download/dpdk/install/bin/dpdk-testpmd+0x458b8e)
>     #9 0x55a872be425a in main
>         (/download/dpdk/install/bin/dpdk-testpmd+0x42325a)
>     #10 0x7f7538756d8f in __libc_start_call_main
>         ../sysdeps/nptl/libc_start_call_main.h:58
> 
> This patch addresses that by registering all queue_job structs, for a
> given queue, on a linked list. Whenever operation results are pulled
> and result is handled, queue_job struct will be removed from that list
> and freed.
> Before port is closed, during flow flush, testpmd will pull
> all of the expected results
> (based on the number of queue_job on the list).
> 
> Fixes: c9dc03840873 ("ethdev: add indirect action async query")
> Fixes: 99231e480b69 ("ethdev: add template table resize")
> Fixes: 77e7939acf1f ("app/testpmd: add flow rule update command")
> Fixes: 3e3edab530a1 ("ethdev: add flow quota")
> Fixes: 966eb55e9a00 ("ethdev: add queue-based API to report aged flow rules")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---

Queued to next-net
