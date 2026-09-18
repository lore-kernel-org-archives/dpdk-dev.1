Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E058C982D9
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:33:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FF264027C;
	Fri, 18 Sep 2026 12:33:41 +0200 (CEST)
Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com
 [74.125.228.95]) by mails.dpdk.org (Postfix) with ESMTP id 20DD040276
 for <dev@dpdk.org>; Fri, 18 Sep 2026 12:33:39 +0200 (CEST)
Received: by mail-ed2-f31.google.com with SMTP id
 4fb4d7f45d1cf-6aa053900f5so936417a12.1
 for <dev@dpdk.org>; Fri, 18 Sep 2026 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789727619; x=1790332419; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WfNz4W9UETMaolROV805g/ay39P3mirrHzEnaHmPN78=;
 b=h6ezcYZ2Sby2tMxPGMCH4yn3cW6HbGQ2ta9pnhEK4zifR68z3ebuKd8009tC0X6vs4
 gksTwd5ocapEnvXwQjDqclWD3GH2cBN+0bFtrYNs8CGtGS3rsurGmxnLTBp/g9a+cSRr
 Zeomgw6LZ1ebopqYmPI/3t4w9yCdfy9FEaE7T/vJjUYTOpbWpMg9VzQCucE/Z4jBaLPe
 HBPyL0Jl4p1/EuZ4cWFrb/NhmfnKpl3FT4XUx8bUKpt1pt0VO4anRV0JkQxZbPLTpMEa
 HAmgkcNkOpYzsybv1ImKkhNC2Ka2si7uG+Dq5W9NY/qaNNcbtcl5a2wbWpvGCSELN80Y
 Wc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789727619; x=1790332419;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WfNz4W9UETMaolROV805g/ay39P3mirrHzEnaHmPN78=;
 b=KbnQ+/UnHW0yRBnXFjKbaIOJ9i3MIvO0rFO06ExfG+7D+Mce1u2hdCqA7Cy1FxD/ST
 w7MLhELeQEdDI+li/C6lgFSVrmYxmKORq5QGMPV3K9bJLZSI9OPsJm0kpxEVi4VG5x6e
 eqcYnLbUOYd1pwaNHvneGV9cx2XHEjx/5TzunPvv8LBap5VYvK1NNf6vKRM6X4sUD+uv
 9hIx8f0nKg9k4ym/U6fN68ZOhfDJMMSxJRjPVXC1Uegp7xogUsKTZbOz0ENtCcDbmPCm
 1/OwzdPZ3UZ2F9QAT7oXieYXnSGF+sRv6sr3zhk/Q3QWWMhaervSTz5/Svka2kxEQCbZ
 Z7vw==
X-Gm-Message-State: AFuF++n0Gx/kzNSck32W/ApwJwbB2kBxeeD6bvineMxdmmMiIY8ES/Lo
 TrcHmKtQW/YOTvN34ZsgdxG/0LRZOwvZQdD2/EfDnSzUTjCL1m15af/PLFOnMbZ0LXA=
X-Gm-Gg: AYBFou1BY93UZGrstTXKhLK2/Py5qwsJQjJZ2K5pgoSUzhDjYOjkFJiygoZFn/X9/wM
 tlETEEbieSY2vk4rDR/xj6LL6S8xYNJBst3vmCsx5+5B4Wl7GU2CM2tUuZdyXt5Y3sWhz5XKVZv
 6zBYyEE3iRvNNANiyfRHmdIuzZ+onNdH63cQoFfkQC2igzhkbqaOMh7IMZElLA+VLOAoOjRIkhd
 eJWt9uyemlY6rmwn3eQl43f3B7gPCSkxRQtGf5aR19na8uQ6w3mJipcyGaSElHzDDXd/VT4cP1C
 VOWGTG/S2JYcGMnGi8lRvP6HFHeOI4RdWfBMY0IpuNKqnt5p9xOucP5TkSbcE4ihR5qwAVcLM7l
 uiQDg6eGF/XVPYRFM8Ey5MiJMFDNY6uh5Of+0SrlXBN44DGqMQTh98ojrfKEZLo9uOe/ytyolaf
 A8p60AjAiuyd+l75BAOLsp3mBXyVea1hVix59vQ+/O+Nw45aty+DYd2uMg96L/OyDkp11SRg==
X-Received: by 2002:a05:6402:1d52:b0:6a9:98de:6d8d with SMTP id
 4fb4d7f45d1cf-6aa579a924dmr631458a12.45.1789727618558; 
 Fri, 18 Sep 2026 03:33:38 -0700 (PDT)
Received: from [192.168.103.32] ([89.101.57.120])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa59787ee6sm652171a12.29.2026.09.18.03.33.37
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 03:33:37 -0700 (PDT)
Message-ID: <197f091d-b8ca-4c76-ae72-adf5f719e10f@gmail.com>
Date: Fri, 18 Sep 2026 11:33:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] test/bpf: remove redundant library guard
To: dev@dpdk.org
References: <20260805090350.37661-1-marat.khalili@huawei.com>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20260805090350.37661-1-marat.khalili@huawei.com>
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

Recheck-request: loongarch-unit-testing, iol-intel-Performance


