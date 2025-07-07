Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400E0C83F07
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 15:03:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 698B640287;
	Mon,  7 Jul 2025 17:03:20 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id D2B054025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 17:03:18 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-23602481460so32576415ad.0
 for <dev@dpdk.org>; Mon, 07 Jul 2025 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751900598;
 x=1752505398; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jswPaQwbA1aihtin3jiVNYjh2XMuj8my7hLaRDifeS0=;
 b=HbfXz39AKbbOJnUYc53ros38XXWPbezcfyUrk3i1AsNK4igSjaQAGez5rsQcKA84mH
 RstBx9QqIsACFcLuEV2xBHObN4UwKgy+pRWH3xoSD0QrwXEiVjWUS87CBAbWocmztJZO
 aNkfDgcKvKTea48rORgGMUTsRUAXtq6BNh3TXZz82iyJiUYyx4+zLu7NvUaY34l+72ds
 rv3ntRcHdqvTJkJrYTl1HqWEVU2xHDA/LNb3cLhllvvKvzxzwz1huPS8a8XJt+l53GYC
 +3flTtMLWKc5i9e8E36uhRe/b6jJXWMzZcXWZXLFr9yjgcvM7dHk6/RsCj/dCQHm6DJ+
 DX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751900598; x=1752505398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jswPaQwbA1aihtin3jiVNYjh2XMuj8my7hLaRDifeS0=;
 b=eW05kNDfyGj7E7JptKa66Ro6tR7BO66uU44o5puj5IQ6GwEPbBv0bIMv164tE37duT
 amaUpeETkPRLAQPBGtbb/onA9/PbN4WR+rGJgB9DsEyFFUC4kHcJenn5bSNjrbVyW7Vf
 HbEpCr3EDpFyGRvUQ0bCs5rmoA3s5xKTTPk5FJNkypV4KW4cZoLbxbkJzR+CN4349SAJ
 7w6VwP9F+avzRTSzMtJ/0qp0mOnH+9y/GqE0mVy5ub84VkkcAABUc0JI7WxpTBseaiHt
 0a08d6IeoP+D8Vw4ZxcQZD9ua5SFaKncQ+PFhHPd6pir01cDlsYqSPEBaV4FVnhWmIxx
 +lQA==
X-Gm-Message-State: AOJu0YxGIlBEbkbzTpB7/yUIJHSExMikfOoaivQFobnsW6v6AKr1+uuC
 Ksmf1PebwjUr+2VJYoAijrhcO59XMywG52EaOsvra35DJgoXZUie+d26h1kcywk0+brDaj4hJKH
 6zexz
X-Gm-Gg: ASbGnct0Ub65laJw8KxS5nDCUHo9EGMC25XwjEf8N1DKdDi/nd0h3gBUDMScZfssWoD
 1IKXxZXzMhXMUFIyzRc0BfL3cdSk2Eat/+RRl8BNONRNFBWM7YxgaJ9Lw7FuVtrQ3QIoxK2Nj6B
 K1bFwFp/soZvioLTwxdZbYlbmzvq1Xn4b8cafmVtRcLcC4YBPrJhUhUjxm4Gb76B/za9TeTL3mP
 YXLXNqx93POoK3F0fWSg0799oIr5K9XkKql7JVZ9t3GKBFS569GZ2vNV/wyv7RKmXopLHUGBSZz
 SYlDWbKU7FYVyavP2MvTu6JgkKBbsipnupt9RIHS09153zfE4rppPEL1gkEXPhjggizu1fPeYFq
 40pKpX9yw3i+PAQ5il590Bf/9t+MZWqOB+S24xds=
X-Google-Smtp-Source: AGHT+IGN6GMrGbH/skM11Cid6kM+FS9v3nDBypxA3KWo58yrB8Tm2oNzuVelXflFEzDRewU7Q9b8jw==
X-Received: by 2002:a17:902:d54e:b0:235:f632:a4d5 with SMTP id
 d9443c01a7336-23c90fb7034mr128574765ad.9.1751900597824; 
 Mon, 07 Jul 2025 08:03:17 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8455e720sm87588485ad.118.2025.07.07.08.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 08:03:17 -0700 (PDT)
Date: Mon, 7 Jul 2025 08:03:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 14/14] net/sxe: add Solve compilation problems.
Message-ID: <20250707080315.37cf5f6d@hermes.local>
In-Reply-To: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
References: <20250704025401.301617-1-liujie5@linkdatatechnology.com>
 <20250707115819.12826-1-liujie5@linkdatatechnology.com>
 <20250707115819.12826-14-liujie5@linkdatatechnology.com>
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

On Mon,  7 Jul 2025 07:58:19 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> Add Fix compiling issues.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>

Please integrate these into the individual patches.
Each patch in series must compile cleanly because at some later time
a developer will be needing to do "git bisect" and if one of these
patches is bad, the bisect step will fail to build.

