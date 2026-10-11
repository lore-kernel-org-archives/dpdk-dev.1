Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09A5CA9ECC
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 20:17:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E68040279;
	Sun, 11 Oct 2026 22:17:56 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id D84614026D
 for <dev@dpdk.org>; Sun, 11 Oct 2026 22:17:53 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso1134931f8f.3
 for <dev@dpdk.org>; Sun, 11 Oct 2026 13:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791749873; x=1792354673; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rL2+Nkdgt2sj/JJrLVHSVNjOQ2md0GUvmNjwsumJIRU=;
 b=f90B9gfvABYNpv+Wps0S7Uxlwk0loSj/RZaok9eBfBPM4EmPnXDXpnoh29mYJzXFFk
 w/AE28Bn3Mo3segyJwjFzLdkxKCh4OPEvPXaZ7YkqxLVrxd2YfdjRsX+i2+M37IMbejl
 BcHHb9gFcr6HiwFso+jUwevpcmokln1HW4E9V/OvJups7e6QZBRxcyfuf/iukpkf7g9a
 /HWyF4rC5+lioQJ5AK2iPvU+4M3E6iu37EunDM9XvLImhPO3gmJheIzcFUDYDkUazX7/
 WZFXRtuS0ibfDyIZtQ5VPN1lbAzkuDYHgPXhJvwKt+VFqtu4mmrVB5QAnHK3yo0qjvn1
 DSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791749873; x=1792354673;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rL2+Nkdgt2sj/JJrLVHSVNjOQ2md0GUvmNjwsumJIRU=;
 b=GSCJvotl2sRxoU2m/TbO5ZwU2Wco7wp+t6JnYNaPByVVaJTCo/rkdksT0DjrvmYy6V
 kNtYAUdUyn7GVmtdb7LwakMwsZQn6Omv6Yx5/yzI+7+XbfWpcL9+zZfrQ05HNtHmcTtF
 Z0SBmfZGNTGInCQLeWZsvgV40Ja3A+gABZ+dwbzTRnyBX72P5b9nR/MYYo2hUqFPd6A1
 YrXLtjkSLquVu25kj4d1hEbOhhacITPDQWeVizfUwXW7JVw2JdfqqS2cF+NpXzPwX/cc
 ryG52sECOFlugLN8ABQff+Y7G5JQ0koU0Rk0c5jNSGTpRisVLghoYJ8PEdDEEv04tFzY
 w7cQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKZxzEoaygIEUr0HuS5QIClPggoTV4hBVJK8LWsjKv/gihzoc1Xk9qyt/Gyn40Gb7T86E=@dpdk.org
X-Gm-Message-State: AFq9FYKgrw58mRpNocw9OQMzb8l0GK4ND+3mHmTDhro/5c9sJk/OJ9AV
 3lVNdVYwU1CrqYq+n2jYbLr0e+xUgYkP5Xesm25E3fHHVE7B4EZLxVNG
X-Gm-Gg: AYBFou1wontMbzJ4OulB5p2NTdFXTe8kRzR8evUCbv2jnvTr0BmW5ocoBOx2MP1mvL1
 o8hBqSJgcIJYANstS1YS8ZhFUCP33jys22x1yriVFjeKn3/nlczawJkNDQRBT2ETxR/2YgnSKy7
 t4ftV8YPD7PNZA9/OVrI3MwsN/eC2u9Ms+ZVW1wwPbN5+/ipBf/bFhjHcAw9l5TTwqdTSlSw9ql
 s6ReW2Hl6Z+0Qc6QyXzE09soQeTFZOa/lFXJaUo3kBQehANDOqZKXzw9wcbqF33cFg+DhIdQ0q5
 34GsAgOBBmAEGh8y2CpxAZAuQ7taYpr/jyoXVfTSMMdQVKpxEJDT2V0S2JzAMZSGn/ux/zhBB3I
 WWCKEWgHQJYM3PkNEFUc3nEto4iLIhJh+e/IMnFYB99Muby5gcvpDdYI9J0Kh9XBgAsGPEzltL6
 4qdke6BnjFHAEeBiEvXTl2N7mDHuktuA7hyTYr/4dhi7N6RZgRJ9DtqH/BKmEndn+1Uryc25T/f
 52Haw==
X-Received: by 2002:a05:6000:1789:b0:48d:cbfb:d7b with SMTP id
 ffacd0b85a97d-48dcbfb0f48mr6109015f8f.5.1791749873181; 
 Sun, 11 Oct 2026 13:17:53 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.57.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db99b820asm16906351f8f.24.2026.10.11.13.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 13:17:52 -0700 (PDT)
Message-ID: <b809d42d-8ded-4119-ba8c-80006efa74d4@gmail.com>
Date: Sun, 11 Oct 2026 21:17:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] bpf: simplify callback inuse tracking to boolean flag
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261011182158.124246-7-qm2k21@gmail.com>
 <20261011125138.75606f1c@phoenix.local>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20261011125138.75606f1c@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

> If it is only on/off now make it a bool.

Changing it to bool may have performance impact on some architectures. 
Also, we'll have to make it int again when adding support for 
multi-threaded data planes.

You seem to be using this API more than me so I will leave the decision 
to you (and other reviewers), but please consider the points above first.

