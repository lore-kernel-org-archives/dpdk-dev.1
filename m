Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36806CA9ECC
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 20:24:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 826AF40279;
	Sun, 11 Oct 2026 22:24:10 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 7F88D4026D
 for <dev@dpdk.org>; Sun, 11 Oct 2026 22:24:08 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so671634f8f.0
 for <dev@dpdk.org>; Sun, 11 Oct 2026 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791750248; x=1792355048; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mouiKBQnlSaKkziZ21FW2V14k4GDqmAyEixaCPBMcnM=;
 b=VUpKOF6J7mJbCVBpVIHJ437pGQCXUXUubMov4g3q45X6wrg68ub+UIaz6REcuJ5ka5
 Y1nnhC+Jm1rt5XgupVpOHsElG9BbiEvFPyb7S3y4ja7C9+SjQP0dUzj7ZvSVdluPpBA1
 G6R8KFp3GJxwiPCB3NGP1oaRSlTSQvf7Cnch54fXGLYzGwS+FsT0wRGzeyVy5A1Gsu0G
 lLDoKagIaorQ6hZsAuYDe8j9D5+5N/l4La4KkPH1MvK0EsN9KwoQOJhNsXWNb+Cp0QNW
 KV5d6MU750GAu2xvBY7sYoMjx8I9wiWX8fl08fOKQZKONKjYVAgDnKnPH2ZWLz1aIq+q
 AJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791750248; x=1792355048;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mouiKBQnlSaKkziZ21FW2V14k4GDqmAyEixaCPBMcnM=;
 b=bEwWfiR6KRxYcfPOTHyLYEr5V8kDYNKT8ET+6LlXEeCBZMjuMZ2mdfNPl3ETq2c2Cn
 7cUAyqXuRCT/n6jK3tKBDDC0R6HLZ9MxZkR/6NcUBjftdpZakDBKl6wASBhnglqesdz7
 vXN/2Ey0nAWj0NAv+RGD3zBT6WUF1hsalvOb57ixrVTDpgG9L0vBq9njqggc15Lhhtqp
 TZoj4O0cAwKSY2B11F1Cg9QvEIGxS89VXzfcI14SmvfqOPm2Hu0AcIot4UGLsNjTZxBk
 avuBExEf2kShPSD2aHQ9gLM9MNCysmm3d98iTz2POIt4O1AYR8CXVZ0Kdalkx6Egezzk
 4hew==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlXOKwtM/HXIybhciCJ1xx0YtMfvzD/4vGQbbQHXs/VHOxPRclfh7ma+xQ8EIG2sJFQ2A=@dpdk.org
X-Gm-Message-State: AFq9FYIpV1QKerCnkZNMXWija8qUT+WEfcycquYbdSVx8es6EOPAlojv
 LcRR4dHOuw42/vrdO531/qlqFnYC7T7hp8Gn5lf+k33pEoIx/dL1pqZF
X-Gm-Gg: AYBFou00A38YkLn3Tn2+BpjQ5EsznWnOkdfsolSQTFdCZ3Ff8cWV8ZB4Lx+aOGU2lIo
 M+E3GkyW86fukgFL33XmjPKHUZ0YK8CcKgr+7L5VEVniHypGw0DoGjj70GWAlZHsP0t3CbhCeuh
 7CGb5tc1TyUhnyG22fLf8Z7tUatpy9/C9BCusUjunB5+FWFrL8JuDM8DBCA016brX8mm76aRwnn
 pwWH8hQct6TKUrMEqXQ7AdLVIpu5hFciOiXIFYW44VFUw/6cpnVyHNKJeQB9un0ofVDVVVCpK4S
 FM1TIB8EKX4WPc5lJ9VTSFRny7KrqaX2wgyApg3tT8NzTsHSZx2fPlG1jfiHVKIKyolNvoQrn76
 UWRL5mBzGgmLMq3gX5HUBNJGy2lMzvZL/LxaJwM/5YFZk9/DBLKEIkFoBTt7kep55hL7SXXAb9y
 +VG49YGi6U/kEqjYWryxwQEt28ST0paywPMwTMH+7/cUuVuSGqw/uRcVwtfbVBH2SX2ag=
X-Received: by 2002:a05:6000:2993:10b0:48c:7306:18e9 with SMTP id
 ffacd0b85a97d-48dbaced35amr9857858f8f.43.1791750247927; 
 Sun, 11 Oct 2026 13:24:07 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.48.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dba033a0fsm13849092f8f.14.2026.10.11.13.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 13:24:07 -0700 (PDT)
Message-ID: <cd1c3118-4424-4072-acc8-4c042865b3c5@gmail.com>
Date: Sun, 11 Oct 2026 21:24:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] bpf: use relaxed stores for callback inuse tracking
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261011182158.124246-9-qm2k21@gmail.com>
 <20261011125256.753e35bd@phoenix.local>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20261011125256.753e35bd@phoenix.local>
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

> Already covered by smb_mb conversion patch.
Will credit you in v2, but these patches are not exactly 
interchangeable. In fact, I was hoping to make your work of removing 
dependence on deprecated symbols easier here, since there there seem to 
be multiple diverging opinions about the scope and the best way forward.
> If you want, can just make that into one patch which does
> the conversion to bool and gets rid of smp_mb.
Not sure how they are related, especially since this one seems to be 
trivial and safe, while the bool one is potentially tricky.
