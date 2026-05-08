Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DECCD3445
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 15:08:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0169340150;
	Fri,  8 May 2026 17:08:06 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id 528A94013F
 for <dev@dpdk.org>; Fri,  8 May 2026 17:08:04 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-67c2b4809baso3919127a12.3
 for <dev@dpdk.org>; Fri, 08 May 2026 08:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778252884; cv=none;
 d=google.com; s=arc-20240605;
 b=B9EuJllAvOdo8p0ls4aJn7g81G/7M/ww9BRCfKlmTXBFKHxDTuH5qSxh1QfCaOoh9i
 7wnjZX3lK0mAN5MG6FCMbfNAgf+haKxbbJFoiyans3sS/vwWGn2d2X7nCBndscl+5eaW
 ZfaRz9HbAaRsIJpA64Y2xITAGvc+9Xk4u9Luj8cwFkVCMj+RLRVDhowGHRulKdBHszqn
 MBoohCBQraJXNriOG9mfKb19uBvFA1PrOKV3h0dX2oB06f/r7dk9PuJH2JToikPX1obi
 A8WSO1ep2xV3x3l190ogeXx4SQWAsE6fhBMDEToDr3TfGDiK8e63Dw35SrDqgc/IzXJe
 i/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yjFW0fUNx4Pl/aDhN+Eph97WdNDnuOA27pqdFi7gThU=;
 fh=iDMW63QzSVeLi7f173V0YDxZb7Iiu7E/PYKx4YLRLSg=;
 b=f3fMQOvbjjr2ZKC1cXU31jVb2uQMdB/km2OmGEMdA5YGs85MD6TNWMfmnfrCZYQHAc
 Kf/89O9xOFwUMFcd+B1Fc07qtFSTYTOx0IzDkhwsf9RLRtWJ6CCMMr5jSI6kX/ZLMgiW
 Zzcp9Mq5Dvz/C8RqX4pUXvP1UaD8k7q0T15mrnyklQh96VgeZlJ2Lfv9ccWAgvVvyzxU
 9exTRp/zIgAj2RCvwoG5oX/XhI5EUcvyCDfMdDooW3an4pYSuVD1s3qrpHyQzX5X8ZZx
 OYHQotFk+SqZNw8jcpwVm/6XQUw5abUjv+sXQZ0Ec1pAu0cW9o2lqMFNNPdQ8c5FqBCL
 yOWw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1778252884; x=1778857684; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yjFW0fUNx4Pl/aDhN+Eph97WdNDnuOA27pqdFi7gThU=;
 b=dDa4UpZ5BB6+1WazYW7WTCfKGqMDFfJbFPDyhX/oM39V3LzlIN3vlsgvCFXUzhCJ4Z
 lVgR4EgSDkuHalz3os36Zms7vQy2PafYi0Yfm/jJpxIJPBmL3QpymJiQOE+8x/9/5Y5N
 FA8WBgw0q9iFJMK4wEh3AaPK2GqS7/mlbRM0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778252884; x=1778857684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjFW0fUNx4Pl/aDhN+Eph97WdNDnuOA27pqdFi7gThU=;
 b=owe6hQRnYx77g76Jp8YBEgtjH2Hvv8hIu8uL9h2EHGlJGkAM6FTJXQg6ZpRwfmMbyA
 3FiPMwR/8/WvO0YaJQxmKQUikr2u8xmKsM+MEeAoBOVGYjqzzxLmK8jH5o9AGiLtByQC
 nSJjOp0QLh1At3+G6L+ytdHblm4F7O4/7K5Cw5J0IyZdRD3CgYG85y080Sm/zbGE24wT
 BCFI039Sg5GfkvZ8errhZ4SWC0bfHLn8v/f/wroFbJi6ggV2FeP8zCxGXF1TUcrzGPZU
 lYrtO4DkavWrfW0N5VbgSZ2zMq50cjqu4CjMx42KfbWJplcOwTAR5xTmM6YHrYg4Wqsi
 51lQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oikierDXjzYQbh8KbOMZa2HRZy5zVSL3V5b+99V2Q4BI1M8jOtj2kEfhaBs41bLWfALM=@dpdk.org
X-Gm-Message-State: AOJu0Yxh4Pt6ImcrkNGN7Q0Bkt0/1ueV1JnupyVdbHjzvMg3rF8VuuYt
 fxtU96PPGB5q8zEFFpPB+W9/aD8bS3u5ydj8wpuD3zmLKcNCin+E7ZKHKypiDeKcgI5vAdLgYmW
 tnioXnld4iHUFJJxyhmQNKhCNjITRQAUoml3pJ+DPRA==
X-Gm-Gg: Acq92OH6JBIgPO+6yZh86UAcRHzZj4LErc8HncTm+J+zp4RALWfw7np1pJbeh2dn+8k
 C0h7ORvPuo19ezljAO/JlNEuNwWRPVGaWAn+mnvg3i2DDCX0cJVgbgB7STHXf7th637fnkHRZlD
 qfbyckdHHQNiTJHrYUqmzGX+RNGM8N8gESFVc/XeiEZnrPOybQqCYRAMNDw4i8MYHT6shOpRF2q
 iIjwap5R70CFQuEDPPlwer3kFMPMHUUA7403qs2Vmj/Ix8AgEq7nWTufEJsME203ZiD/BSRMkfs
 rLHOzrIleKXSTkOmoSWQZnOPRvcuNqPc1YHgW9DnuxTQQ4AmrsA=
X-Received: by 2002:a05:6402:21d3:b0:671:a18b:32b8 with SMTP id
 4fb4d7f45d1cf-67d6201ec96mr6504916a12.0.1778252883659; Fri, 08 May 2026
 08:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260327180232.443820-1-abailey@iol.unh.edu>
In-Reply-To: <20260327180232.443820-1-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Fri, 8 May 2026 11:07:51 -0400
X-Gm-Features: AVHnY4L0E4T7pGd9_g5TlLLRXhFfAxE3fFWzBAXj9P4Ocahujk1_cmEkYYtqE30
Message-ID: <CABJ3N2V7EAu9Qyo7zQ=h9OrNRcCvkpuuYxoy4WT_m0j5Nir7WA@mail.gmail.com>
Subject: Re: [PATCH v1] dts: add ipgre test suite
To: luca.vizzarro@arm.com, probb@iol.unh.edu, dev@dpdk.org
Cc: dmarx@iol.unh.edu, knimoji@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000073a04006514fc3ec"
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

--00000000000073a04006514fc3ec
Content-Type: text/plain; charset="UTF-8"

Recheck-request: github-robot: build

--00000000000073a04006514fc3ec
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Recheck-request: github-robot: build</div>

--00000000000073a04006514fc3ec--
