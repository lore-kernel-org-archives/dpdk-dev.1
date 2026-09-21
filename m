Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004CCC982E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 08:36:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C347D40265;
	Mon, 21 Sep 2026 10:36:48 +0200 (CEST)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by mails.dpdk.org (Postfix) with ESMTP id D1F1C4025A
 for <dev@dpdk.org>; Mon, 21 Sep 2026 10:36:46 +0200 (CEST)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254fa663c1so308754866b.0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 01:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789979806; x=1790584606; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xlKPL/70eXexb37hcHp9u6pgaJMHwgKVa2gaM9YmP8A=;
 b=VQfhWS//TyaCL7bdD/Ie25fEYwQvhb1kT4VGN37kHjkDELY9m+gYWD1jYtD+AEUYU8
 6f99qlbJ1u+vf0vo+leH4iMknLJa5IBg83cxCwuce8xmdvNdm3LOuO7CQlyGPgi7No0N
 mwCU4aT4tUt9tnwzicJoQ9Y2qTZIvO2WTFnpvtKYmssfmc0yoIUtYZn88qPG6ikqN/9O
 ZG5TpxFrFDK95Q9cTzf8K5/Ld5l1z74pIm46Jt24DhzEmXuDDznhupeBlUTtpJ96V5lB
 xGuEsR2bTHoOQXZh14T+K96gysPh5DaK8EuT2ats97fqwKIsu+lg0AMGipWs1kFf4DAs
 O9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789979806; x=1790584606;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xlKPL/70eXexb37hcHp9u6pgaJMHwgKVa2gaM9YmP8A=;
 b=uiJkNH7Yb0RyeuCFmLeHldHafaty+uWq1eaoFrRsVW8rdYCfzd7jbBTEqFSH+fOJam
 gO3QIJZR9QYHwAVBAzv2Aa59A2amYgqkKWkhHrxufAOj2sjtsX0YZAwm5gbriuPhvMnr
 er0ZcCSK3s/tMOfp5CYRDeMXqV9SO+j+htqMNmGcmZvfBZwdYhKsX3uOT8yM/nav9Iw2
 bGBRXIBhHD2Zh7fTNkPlnT8ODOU33t4laPSxRNI796fUP7p5wNCAeGmG3IB/J1f2ZqFY
 AR1dDmb4nPI3gdUItWgiIErx+r4mBVl05XEEYT9scTL5+q1Gi832Lzd06l5YxBjv9uvl
 VEaA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQg3G+PMHNf0gTFbhO+vWvwm4ti8WKn8g11v4rnyQh1KzcH4SHHvVJq4M5R/QjJ5OUcp4=@dpdk.org
X-Gm-Message-State: AFuF++kzsw0ZQBrj0jIS9ZPEwtvetDls3puCGHNEJobpCborcQYQthAM
 MPNPNgEYrZhPAegKFiU7nwqN9HGvWsywmfdiK0g/OewqBmzYOjsCd2R3
X-Gm-Gg: AYBFou0Uh7pwEapPukXDYhaw/G0tjNPofBVHhaOQA0Z5Fh3H49ifsg36H+f4ZEuuKXI
 EEwv6gE1IAfMuMC5daYuBjWDkh/deQfdWx4usVKo2J/Xd/DFWuxZOi5JN0AlkVg9xhXbt4KEaL0
 H9W5ue+GF903en9z0RLazT5gaAd5HzEYWD10mZ1aFia86tbtwsWX83m4N67rqXsKDgInFORSUko
 N6+/s/nnKtaexgoEwX0HFKTDVYbOsPxHF0eDYCEPWstyhuFo182KYxCv3oKKix/A3XOVjhAMbCJ
 jxBUv5bd1wBbP3M29rv6nEZHjWeDFjoYKYBMoasFzcjy+Bq0O+Pn9800/MtIofrqUaZoOfN6wKf
 cL1yozZcfsa4qPcn0Ef5fFkJ2pL654YTg+BZz3tX4DhnxCQB8UGNvn5brO/Zm32MPCfFZ+QBf91
 Re/pkOUz1AfesXVLxpSv/iUFznheGcCkwUWBdvYeljBirvGxEgIAstxnXIOkyOe8Yu5hyssw==
X-Received: by 2002:a17:907:e153:b0:c2a:3473:67a4 with SMTP id
 a640c23a62f3a-c2a34736ed4mr311049666b.29.1789979806124; 
 Mon, 21 Sep 2026 01:36:46 -0700 (PDT)
Received: from [192.168.103.32] ([89.101.57.120])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a352381c2sm269186366b.7.2026.09.21.01.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 01:36:45 -0700 (PDT)
Message-ID: <c31498a8-fe6b-4855-9edd-31494c9b14ed@gmail.com>
Date: Mon, 21 Sep 2026 09:36:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/33] bpf: replace deprecated SMP barriers with C11
 fences
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
 <20260920181347.747210-2-stephen@networkplumber.org>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20260920181347.747210-2-stephen@networkplumber.org>
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

Thanks for doing this. I see that comments were expanded since v1, but 
the code stayed the same. Using both atomic operations _and_ memory 
barriers looks redundant and misleading, and the original got away with 
just memory barriers. In the reviews to v1 there were different opinions 
on which way to choose, just barriers (for the minimal change) or just 
atomics, but I think we need to choose at most one.

On 20/09/2026 19:09, Stephen Hemminger wrote:
> The use counter is a seqcount, not a reference count: odd means the
> datapath is inside the callback, even means it is not. The two
> barriers around it play different roles.
>
> In bpf_eth_cbi_inuse() the counter goes odd and the following loads
> of cb, bpf and jit must not be hoisted above that store. Ordering a
> store against later loads needs a full barrier, so rte_smp_mb()
> becomes a seq_cst thread fence.
This explanation probably belongs to the code, not commit message.
> In bpf_eth_cbi_unuse() the read barrier becomes an acquire fence.
> What must not happen there is the critical section loads sinking
> past the store that makes the counter even, which is load/store
> ordering, and that is what a standalone acquire fence provides.
> acq_rel would additionally order prior stores, but the read side
> only loads from the cbi and so has nothing to publish; it would
> only upgrade dmb ishld to dmb ish on the datapath for no benefit.

The last part is not very readable for uninitiated. Perhaps it's better 
not to mix C abstract machine language with ARM instructions when 
justifying the solution.

