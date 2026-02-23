Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F878EC110C
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 17:07:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 665FF4027D;
	Mon, 23 Feb 2026 18:07:52 +0100 (CET)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43]) by mails.dpdk.org (Postfix) with ESMTP id DD0DF4025E
 for <dev@dpdk.org>; Mon, 23 Feb 2026 18:07:50 +0100 (CET)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7d1872504cbso4099980a34.0
 for <dev@dpdk.org>; Mon, 23 Feb 2026 09:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771866470;
 x=1772471270; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsVP5AQSUPcskticzaxCa8gynIzWH4P6My+FasuoVk4=;
 b=xHxf7ryG9AVHkn6PXvOhyjqLLbA+laT0XupHXXmtJ5+vxxI2z65JNnVq0fGxK8OKFz
 mMHS9VAhW/It/haqRgY8O9DlRYZeyCVEyu/9DAzPPv08m87lCorT15GMPaQCxs4tHNry
 I/mD5QuNCMs2uUksDOekhb9o3/4MFuLlAXnVAmfIMm2KXn9YeDBsEkgu7IF+2OhnXM2u
 4n4npqNxem4U3XVWBnncJldaNYiawfewsvpB/kSS664cMC/qOznYgQDzcIlLe486SYhX
 5BE5afNNgBQjEdFmM7/fQHwjSmfC6dsFCXTEbMPAb9LEMG+v3JEPRv+RoxmGHLJ8zAxG
 tIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866470; x=1772471270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YsVP5AQSUPcskticzaxCa8gynIzWH4P6My+FasuoVk4=;
 b=QlgN8DXooPUgvwEVjOMTWR7M1SRhfBsSHFeMOuHGmklnIovGX3yiVyt/CBx3D9XX0d
 AOr67RA1PBtwCzQdieKG9RypB7PYtLl16qFS0Jie9+1DPhAlC8q8ffjsb5ZqjkT+ncBL
 kxyTofXieT+eGs9/5Y8EJT6kdo8F4rmgWHFbVSw9y/2fHrd6jXuANm3g2kjfapHggUfi
 1mxDtID/EOGw/kvnX3WpighkgTKfF0kzKOyEV/JrxLjS8sJik7hGqGPOHFi57v/B+3rv
 XgWM2tfXHp94g9s+ReH1PaW3JNSUWZKMmW8sZpdGgP9Jh7z4cnc75uNn/YMnzhLtr0/F
 hghw==
X-Gm-Message-State: AOJu0Yzj8zGV2LLHOLgQC/6IzqdZigNZyJU+3fuwTxZ9nZ5KA5uKm6ur
 JENrFEH7Fr9shxuUOLk+RL0c0pdllgVPFUSXV9SerFlZ9kt87eJ13iAkJP6vZknYTy8=
X-Gm-Gg: AZuq6aLkDeOzYuOWYLOINGoYAZQthn81/XPB6CAa0ErWmnhNOiRoqKBJ7GyulB0mSwt
 Z20tvV/zc3Wghz2XB+HSnAW15fPZIkntvcu98FabjCUjgqHkMK/hRq+tx0tBukdLlJlwrp9YyuZ
 epKeugMLs+3tWanVSTNyAN5UEWsjurSLt6L+EE2e1PUITiA1XvUvxxmWLL9Rsjcofe0Dyq3SXHv
 TyhJ8OvXjwo13sODdl4fVfyOPY3qZzMP4rphivzGomxYYbIw45SOnyTMuYb14fz3MJqEAmnhSs0
 RAYq7EV+dEjRpEwZcRQ58g6IwqEWXY2EsOZsJnA7o2qriUeBpttC7dVkoJmAWWqtKkUPN69iAv5
 fOxbI6bN6RYjUyXL3Bmal/vsW+dWxeC2bhz7AU7c7Kb/ayamFOdZGGTN/CCGBy1vHKz1iTy5ySw
 xn9Dvv0q5e5SAZFdnsrtBgfeKuXBqWnv7NURIDtTawea0XztYFBwwU8BkmbAfI1hbJ
X-Received: by 2002:a9d:63d9:0:b0:7d4:be1d:e9a9 with SMTP id
 46e09a7af769-7d5169e9cbamr5597497a34.6.1771866469860; 
 Mon, 23 Feb 2026 09:07:49 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d0725c4sm8250657a34.25.2026.02.23.09.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:07:49 -0800 (PST)
Date: Mon, 23 Feb 2026 09:07:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Harsh raj Singh <singhharshraj215@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] examples/l2fwd_acl: add ACL-based L2 forwarding example
Message-ID: <20260223090746.14d3bde3@phoenix.local>
In-Reply-To: <CAN33txETfmQEj8j=W4-nkUk1rAq0_JLhZuR4R-c3YCrDY90y6A@mail.gmail.com>
References: <CAN33txETfmQEj8j=W4-nkUk1rAq0_JLhZuR4R-c3YCrDY90y6A@mail.gmail.com>
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

On Sat, 21 Feb 2026 00:13:33 +0530
Harsh raj Singh <singhharshraj215@gmail.com> wrote:

> diff --git a/examples/l2fwd_acl/main.c b/examples/l2fwd_acl/main.c
> new file mode 100644
> index 0000000000..6e05145b33
> --- /dev/null
> +++ b/examples/l2fwd_acl/main.c
> @@ -0,0 +1,247 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * l

New files should have a copyright.
