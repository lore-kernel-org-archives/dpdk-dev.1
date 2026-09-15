Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2A3C88E7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 15:48:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2D4D42DC3;
	Tue, 15 Sep 2026 17:48:56 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 2DDF1427AE
 for <dev@dpdk.org>; Tue, 15 Sep 2026 17:48:56 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4c3304833so2575398a12.3
 for <dev@dpdk.org>; Tue, 15 Sep 2026 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789487335; x=1790092135; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AeHNq9S713uluVgNLTDrh2Kgig8pSt5Z/1y55ZuJCks=;
 b=FizwYJ073IT+zMYNCFJjGvmzUsxnRpiiUlcxNj12nwEhs7SxAA76FC3sQczQTQZ3al
 ADWr+PQuTqpq4N9cczHTPO0UOrl5qVOpvSpqqguM+A5g5Y+Bo1XXvijiSu9fwYAhGyeq
 gW+QuzzWDMk8oarFYZUz2tQmfHAnZblt41n4b1wKoWbKplVEJg9JWqwqAsVJs5u7K+Jh
 1C6eofA+Bl76RZ+chzq62+X3fDr/KpvBZuMys6ub9d6U59hs3K+fQi4inIIo+J7t8lTe
 4fmrFvUdOGOXzMvKjQJxv9IqKU9VgqwNsOPxpn6JMOF/2BuiCHMLq198Cyzuv8skj4rO
 uJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789487335; x=1790092135;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AeHNq9S713uluVgNLTDrh2Kgig8pSt5Z/1y55ZuJCks=;
 b=JSuD5bLplKQ4RgCu6y5faqtW69czzjtZSWo1HgHRuVKC8mvFvYslWb2SSDVvJjf6gH
 YtKVzXrgpZdukaQ+ovEDsnkVFIrM0aZ1GzfKv1j5ONCHgMY3PvxSHT6iNS6eux0k9clF
 RahN3gCILvSWBSo8GaYrb4qOEzwPFtmPIMxhjiKed+6LqQDNdyYJ0tZ7rrjHAhe95Bhf
 fsH2kbkh6jwPKjyeSp9g/R1uTdRGhUapfLmRJkm0g8utm9DxJGchgCEEwHJ6cgdKdfq7
 F80AMvvhbReakmBq0EXeoAjhcfxwGHzB6ayITi8z/3iA7yEmpyqaWuGWF9BwqbZCi+2Z
 84fA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqr8svmwm9m4GrJFQWdMVyKwpum3CuwahkoxtRISeiZ+d9sCuCGqdIFQp3I4Qr90Hy4Bw=@dpdk.org
X-Gm-Message-State: AFuF++kvhqTU5qDG78LJlFrA79RgBNx6Ukqk8ZzqtjLGA1OfhVpgGRgE
 3d8mnq7giz2xx+V0yAXIPytKv+ntsBfQU5968vkgFiQLF8UUBnRbH9qzZFgKd7sg
X-Gm-Gg: AYBFou3Xsw82rtYRUFjwTAplC4bzq7KU81q7/3T8Ra1LF8UFtdcHaM1pAeOB6AsYrce
 XQm8+OJNPnml4rAbPNYqysBbqzNzSTkGEknyo3AdteF7Emp31ijQlgSIUjbGAMzbdFDmzGJXYz8
 EPRnma8x6I4itsLsbrwvYYIPrvKYvz7ChzDeRWD2uBaB1cUEZG9me+weaYHu5xFm2HOEMp9Mk64
 /WcUGpu9WwM9heum2ezdSjiJvwAHPT/ylQM/pidWmPhetOt384A30RPco3TjYxMMQiHKDAHJ6ap
 VIVdGdxUUgZYSva7SanzNQ47GH5MKB1Ywwzkv0pziEP6fsDLlKaBBWuk4NaEI0+bTx0JyzWxZqZ
 nPPK1N+N+SnRhRK+wq+aeUW3Q/r9ljsN/MqBlKSC7+nS/+G5ugYYqCx8Bahz2avcf4nKrICSD0i
 5XH62JpK1LDeZ63DLblphcBnhPywk+Bg9Qy7dGRfXoMrVheuXSyGat4OOnXh9WVL8v56fWpP4EP
 Z7l31CemlX/19sk
X-Received: by 2002:a17:90a:dfc7:b0:39d:f5ef:b1d5 with SMTP id
 98e67ed59e1d1-39df5efb222mr13283897a91.7.1789487335104; 
 Tue, 15 Sep 2026 08:48:55 -0700 (PDT)
Received: from [192.168.1.112] (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm5868750a91.9.2026.09.15.08.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 08:48:54 -0700 (PDT)
Message-ID: <696819ea-3f19-4538-a8ac-306227474a8f@gmail.com>
Date: Tue, 15 Sep 2026 23:48:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/txgbe: fix leak of filters on flow create
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang
 <zaiyuwang@trustnetic.com>, dev@dpdk.org, stable@dpdk.org
References: <20260915152436.67378-1-zhtfdev@gmail.com>
 <20260915083828.08bd23fa@phoenix.local>
Content-Language: en-US
From: Zhang Tengfei <zhtfdev@gmail.com>
In-Reply-To: <20260915083828.08bd23fa@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Item 6: the ixgbe counterpart is already on the list:
   [PATCH] net/ixgbe: fix leak of filters on flow create
https://patches.dpdk.org/project/dpdk/patch/20260914133836.14644-1-zhtfdev@gmail.com/

I will send a v2 for txgbe.

On 9/15/26 23:38, Stephen Hemminger wrote:
> On Tue, 15 Sep 2026 23:24:36 +0800
> Zhang Tengfei <zhtfdev@gmail.com> wrote:
>
>> txgbe_flow_create() programs ntuple, ethertype, SYN, FDIR, L2 tunnel and
>> RSS filters into hardware before allocating the software flow object.
>> If that allocation fails, create returns an error but leaves the
>> hardware filter installed. The application has no handle to destroy it.
>>
>> Allocate the software copy first, then program the hardware. On a
>> programming failure, free the copy. Set ENOMEM when allocation fails
>> so the error path does not report success.
>>
>> L2 tunnel add failures now return immediately instead of falling
>> through to RSS parsing, which cannot succeed for a VF/PF E-tag rule
>> and overwrote the original error.
>>
>> Fixes: 5c2352b9ece6 ("net/txgbe: support creating consistent filter")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
>> ---
> Patch looks good, I was going to merge but AI had a couple of small items
> that should be addressed first.
>
> Review: [PATCH] net/txgbe: fix leak of filters on flow create
> Patchwork: 169627
>
> Applied to main (f43632a) and built with -Dwerror=true, no warnings.
>
> The alloc-before-program reordering is the right fix. The add helpers
> (ntuple, ethertype, syn, l2 tunnel) do not modify their input, so
> copying the filter into the software object before programming is
> equivalent to the old copy-after.
>
> Warning
>
> 1. PF FDIR: mask_added not unwound on the new ENOMEM path.
>
>     The allocation now sits after the "A mask cannot be deleted" block.
>     When this rule is the first to set the mask, first_mask is TRUE and
>     fdir_info->mask_added has been set before rte_zmalloc() runs. On
>     allocation failure the code jumps to out without clearing
>     mask_added, unlike the program-failure path right below it.
>     A later rule with a different mask is then rejected with "only
>     support one global mask" even though no rule is using the mask.
>
>     Either move the fdir_rule_ptr allocation above the mask block
>     (free it on the mask error paths), or clear mask_added when
>     first_mask is set on allocation failure:
>
> 	if (fdir_rule_ptr == NULL) {
> 		PMD_DRV_LOG(ERR, "failed to allocate memory");
> 		if (first_mask)
> 			fdir_info->mask_added = FALSE;
> 		ret = -ENOMEM;
> 		goto out;
> 	}
>
>     Allocating first is cleaner.
>
> 2. Missing Fixes tag for the VF FDIR path.
>
>     The txgbevf_fdir_filter_program() branch was added later by:
>
>     Fixes: 7eef71080e ("net/txgbe: switch to FDIR on VF")
>
>     Add it (12-char hash) alongside the existing tag so stable
>     maintainers know the VF hunk only applies to 25.11 and later.
>
> Info
>
> 3. The commit message says ENOMEM is set "so the error path does not
>     report success". Other goto out paths in the same function still
>     reach rte_flow_error_set() with ret == 0: the flex_bytes_offset /
>     flex_relative mismatch, and the trailing goto out for an FDIR rule
>     without b_spec. The memcmp() mismatch path passes a positive ret,
>     so -ret is negative. Not introduced here, but either fix them in a
>     follow-up or narrow the wording.
>
> 4. The L2 tunnel early return is a separate behavior change (errno
>     reported to the caller changes from the RSS parse error to the
>     real add error). It is correct, but belongs in its own patch so
>     it can be backported or reverted independently.
>
> 5. Lines being moved anyway can drop rte_memcpy() for plain struct
>     assignment:
>
> 	ntuple_filter_ptr->filter_info = ntuple_filter;
>
>     Same for ethertype, syn, fdir and l2 tunnel.
>
> 6. drivers/net/intel/ixgbe/ixgbe_flow.c has the same program-then-
>     allocate pattern in ixgbe_flow_create(). txgbe was derived from it,
>     the same fix applies there.
