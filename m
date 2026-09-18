Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247F6C982D7
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 18:14:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98D2D40285;
	Fri, 18 Sep 2026 20:14:43 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 277DD4026A
 for <dev@dpdk.org>; Fri, 18 Sep 2026 20:14:42 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2db710396ffso17230785ad.1
 for <dev@dpdk.org>; Fri, 18 Sep 2026 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789755281; x=1790360081; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZPB2n198URodHnKSOaenzGav/yX8LILl4Y5dsvUQUCs=;
 b=ZxnsEIcRjlFTZfqenJzxYj7U0JdIsSB7RPuuoDDsOnOp33XwLGlFBdpsK6rb0X+py8
 EPK3wdkQSFxINRhhEfUg0c+0ApB7UO/sc1fdwuXkBEpC7IgGfccxKS7kMkG7Wr5k39U6
 dgaExgFLUj2t0P62Dpm6InpQvArArxwCUpz1JcmHvAJwWZ/IWe0XfMRvGzz2nbT7tmal
 8+h0gAKvTdNp8JURWFEDKojpuSTFLzW4ou32fVaiW2ZNDUYB5jpHOC1ESVvN4v1eIl4N
 9m46utkyfn/yt+lHW0Lo0nCty9RRSQ5IdkfPwXGcyvBaWQ8HZQ95AY3DS3U1uqjAgc2v
 pEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789755281; x=1790360081;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZPB2n198URodHnKSOaenzGav/yX8LILl4Y5dsvUQUCs=;
 b=syHKQ68ZdfXdSYeHTB4HKbjRasvW5jKYQdtpGvYfh1KE89R5WVx2k6iZM2Z3FV24dh
 nzRnoz1xE3Bm40Qw27UbQlEz8AmjNyqrtaLYuxZYBJKn2y27xuRWMRBgxENI7nFts8rw
 V5LGBvlnP3N24PMZleXvaQ7lHvnGF7yiXKDdXzigjI5KulIxKeon1DZUt3UY/fQg18+k
 PaC9hCk4+33GQE5zcy2EuQ9AJQHc5Vk2zQGLHxCjx0+Jr448Ns2QnDgKvjsZtxzdO6Jn
 MAVGeIhzyp35ipnQVpuollkqKr7Ut4vEzpfDVr/gNM9PYbkoo7uk/t25QhT1cG38C3pe
 LiYQ==
X-Gm-Message-State: AFuF++kvlTBY3xSjmxP3ctFT/DQ+6/9DudRuTPsoCeoZ2uMCVenUEWUX
 pD7j737GHCBIAQhmhIV7UBkMmrt/5vrqHJyG4BD75F2Rv3qtWa0YqyQ/AKF1hsEg
X-Gm-Gg: AYBFou0CDCInT9mnjkXAJjjezSKLDUZPCB+ii0Fn2BtNVr5BFMmjLVm6rSvRDCXeQN/
 PwbuHebEzG0eMk/xEeaswuoThNMu6hAK1O32oa74s/ZPxG8uFkupR0dS/DesduujGFOtMfMpgEE
 /vKt1HCD3WRAFIJYXaYmlOLxGgutKTbXg81ysm7yTH5NHZGkvfBfkqE/7Qa0ONuzxUjtwfLyEti
 WR8OlR3FAFKgt02aamjT08WX+IKYLqIqQJpKZQsLqtKYxMS0KOKD2d+yaA3vizN8JyurJKWxW0L
 ozIulhsATncS9LkvNrxKXoo7O83W1h4jAhmrvpslcTBtmUH8baxz8joEr9khpqCchcNVnW08MV5
 +9YM5BXZfU0FZ5uZJU25hecogaC8oPWmAjwExH9C3hdgQQVtAk4sIdg5W19yBuiJ6yfivH0/YHC
 GMECPD2QM76tvtenZkA6Hjh34imAwUSzPjqpjvDGbLJctRZThszH7eIJQ+Tr95iBJTLUA8UqLNL
 T0NhJFwXabrTCD6Og==
X-Received: by 2002:a17:90b:498c:b0:39e:5481:54e with SMTP id
 98e67ed59e1d1-39e54810a5bmr5260757a91.19.1789755280734; 
 Fri, 18 Sep 2026 11:14:40 -0700 (PDT)
Received: from [192.168.1.112] (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3314313esm364421eec.14.2026.09.18.11.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 11:14:40 -0700 (PDT)
Message-ID: <01aed930-d821-49d2-ab57-82fbfe68ad5c@gmail.com>
Date: Sat, 19 Sep 2026 02:14:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] net/txgbe: fix flow create errors
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
References: <20260916131106.105667-1-zhtfdev@gmail.com>
 <20260917153242.29315-1-zhtfdev@gmail.com>
 <20260918090640.5e576e89@phoenix.local>
Content-Language: en-US
From: Zhang Tengfei <zhtfdev@gmail.com>
In-Reply-To: <20260918090640.5e576e89@phoenix.local>
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

Thanks for the review.

Moving the b_spec check above the allocation is better. I will send a v4
with that change.

The VF status-to-errno conversion will be a separate patch.

Out of curiosity, which AI review tool did you use? Mine did not flag
these Infos.

Thanks

On 9/19/26 00:06, Stephen Hemminger wrote:
> On Thu, 17 Sep 2026 23:32:39 +0800
> Zhang Tengfei <zhtfdev@gmail.com> wrote:
>
>> v3:
>> - reject mask-only FDIR before programming the global mask
>> - log flex offset mismatch
>> - no code change in 1/3 and 2/3
>>
>> v2:
>> - split L2 tunnel add-failure goto out into its own patch
>> - allocate FDIR object before installing the global mask
>> - add Fixes tag for the VF FDIR path
>> - set -EINVAL on remaining FDIR goto out paths with bad ret
>> - use struct assignment instead of rte_memcpy for filter copies
>>
>> 1/3 fix L2 tunnel error on flow create
>> 2/3 fix leak of filters on flow create
>> 3/3 fix FDIR error handling on flow create
>>
>> Zhang Tengfei (3):
>>    net/txgbe: fix L2 tunnel error on flow create
>>    net/txgbe: fix leak of filters on flow create
>>    net/txgbe: fix FDIR error handling on flow create
>>
>>   drivers/net/txgbe/txgbe_flow.c | 266 +++++++++++++++++----------------
>>   1 file changed, 140 insertions(+), 126 deletions(-)
>>
> I applied this to next-net.
>
> AI review had some Info level observations, if you want to send
> a new version, I will replace the one in next-net.
>
> Review: [PATCH v3 0/3] net/txgbe: flow create fixes
> Author: Zhang Tengfei <zhtfdev@gmail.com>
>
> Applies to main, each of the three commits builds with -Dwerror=true.
> Fixes tags resolve; both referenced commits are in released versions,
> so Cc: stable is right.
>
> Patches 1 and 2 are unchanged from v2 apart from commit message
> wording. The v2 warning is addressed: mask-only FDIR rules are now
> rejected before the global input mask is programmed, so a failed
> create no longer leaves mask_added set. With that check in place the
> b_spec block is unconditional, which reads better than the old
> nesting. The memcmp and flex offset paths now set -EINVAL, and the
> flex mismatch has a log message.
>
>
> Patch 3/3: net/txgbe: fix FDIR error handling on flow create
>
> Info: the b_spec check sits after the rte_zmalloc(), so it allocates
>    and immediately frees on the reject path. Moving it above the
>    allocation drops the rte_free() and one level of churn:
>
> 	if (!fdir_rule.b_spec) {
> 		ret = -EINVAL;
> 		goto out;
> 	}
>
> 	fdir_rule_ptr = rte_zmalloc(...);
>
> Info: the VF path still reaches "out" with a base driver status code.
>    txgbevf_fdir_filter_program() propagates TXGBE_ERR_FEATURE_NOT_
>    SUPPORTED (-292) and TXGBE_ERR_NOSUPP from txgbevf_set_fdir(), so
>    rte_flow_error_set(error, -ret) gets 292, not an errno. The PF
>    paths checked out: txgbe_fdir_set_input_mask() and
>    txgbe_fdir_filter_program() return -ENOTSUP, -EINVAL, -ENOMEM or
>    -ETIMEDOUT. Converting the VF codes is a separate patch.
>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
