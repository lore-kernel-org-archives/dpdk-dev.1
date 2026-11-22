Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAFD606A32C
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=YFXnm7bv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02BEE402E8;
	Sun, 22 Nov 2026 15:20:47 +0100 (CET)
Received: from lf-2-34.ptr.blmpb.com (lf-2-34.ptr.blmpb.com [101.36.218.34])
 by mails.dpdk.org (Postfix) with ESMTPS id 4123C402CC
 for <dev@dpdk.org>; Sun, 22 Nov 2026 15:20:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1795357238; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+VVALhOnKyVnk0+F+cs9bypXGwcbHAH+A7bsUCq4swQ=;
 b=YFXnm7bv13zGYao2sx3SKIrIx85GhcDlKyVyQiSB+B7j3wG0bJCCFvfc2VqCE0phOHRQO5
 QHb6df0aGzmifXWrpEJBkPQKWopFN3c3NYPY4MCB0JOqNGgZOUpK8KT15EuIhwWqnJZE0J
 L41fdhM0RuasMcaytcSQb/w2jHRr7/Xv5S2FuftwORu+8u4B/9IT7A023TiWvV+sCUkEx+
 rwPWL06tGHvdQ2uWMKdMnrCQoPGAHM9Am5nGiBNV2WV1RP7LyUwfMl+CPcNJid6HxI8MFL
 GCvdQz+gDdb/gLHUWt+bVbhrtEVgpe70gESXbzmOu4QhQjy20EfQtoIkcCaDMQ==
X-Lms-Return-Path: <lba+26b02fa34+d2b465+dpdk.org+wanry@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Date: Sun, 22 Nov 2026 22:20:33 +0800
Subject: Re: [PATCH v4 2/3] net/xsc: fix leak and missing null check
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Received: from [127.0.0.1] ([114.92.245.110]) by smtp.feishu.cn with ESMTPS;
 Sun, 22 Nov 2026 22:20:35 +0800
In-Reply-To: <YSPAk0PzQzWZ902MEu49rA@monjalon.net>
References: <1794914060.606144@yunsilicon.com>
 <PHN9AhH-TR23VM6YCYNEYw@monjalon.net>
 <cd058a44-77ab-4db6-9c15-fa38c6f73d8d@yunsilicon.com>
 <YSPAk0PzQzWZ902MEu49rA@monjalon.net>
User-Agent: Mozilla Thunderbird
Cc: <dev@dpdk.org>, <nana@yunsilicon.com>, <qianr@yunsilicon.com>, 
 <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>, <stable@dpdk.org>
Message-Id: <7ff9cbde-3301-48d0-bbe1-0ff2f637cea7@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
To: "Thomas Monjalon" <thomas@monjalon.net>, 
 "Stephen Hemminger" <stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/22/2026 5:23 PM, Thomas Monjalon wrote:
> 21/11/2026 09:04, Renyong Wan:
>> On 11/20/2026 6:36 PM, Thomas Monjalon wrote:
>>> 17/11/2026 12:14, Renyong Wan:
>>>> xsc_dev_init() leaks the structure when the dev_ops lookup fails. Free
>>>> it there: xsc_dev_uninit() cannot be used, as xsc_dev_close()
>>>> dereferences xdev->dev_ops.
>>>>
>>>> xsc_ethdev_tx_queue_setup() misses the NULL check on the
>>>> rte_malloc_socket() result. Return -ENOMEM, as the Rx path does.
>>>
>>> I don't see how fixes are related.
>>> It's probably better to have 2 commits.
>>
>> Hi Thomas,
>>
>> You are right, they are two different bugs in two different functions.
>> They ended up in one commit because the GCC analyzer reported them under
>> a single entry, written in the original report as:
>>
>>    46: xsc_dev_init() leaks a structure on the dev_ops failure path,
>>      and the Tx queue allocation is dereferenced without a NULL check.
>>
>> So I fixed both where they were reported. They are independent though,
>> and each one carries its own Fixes tag.
>>
>> If you prefer two commits, I will send a v5 with four patches, the code
>> would be identical. Please let me know.
> 
> Yes please, better to split.

OK, I'll send a v5 with the four patches shortly.

Thanks,
Renyong Wan
