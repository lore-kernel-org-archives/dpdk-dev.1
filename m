Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62148606A320
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Nov 2026 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=GfJPIYHd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB0BB40263;
	Sat, 21 Nov 2026 09:04:59 +0100 (CET)
Received: from lf-2-39.ptr.blmpb.com (lf-2-39.ptr.blmpb.com [101.36.218.39])
 by mails.dpdk.org (Postfix) with ESMTPS id 6D282400D7
 for <dev@dpdk.org>; Sat, 21 Nov 2026 09:04:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1795248290; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=SwtcFizQWD63nl0aoAx5/C3jJMw4rQ3Wa6xUOyOaFCM=;
 b=GfJPIYHdfvUbSQWm354lOINqeQLSxcCnZ7SrPah93x58gHgppyAc9d8aHYJJmbPfeLmBWW
 cIo6EKPReFYHmt8caj3VtCY5MgEFyVdSsi9EeczS/BzzMu7OMkad/uHl5nHXY5eE/J/9eV
 KjeMianWe05ZMbVuVOEkgLUv9hcAMgeLYk5JdMDV7iIkni7FFdf0t0vgFBQ0q0620OwEFL
 xGv3fRxFWHBLbFMDpDFnVfsLc8i884erM3qwPcFn5DBqkE0lVeLEc5jXalTYfib2ZSjFQD
 4daKum+EPycU8T6I+zUqHH39jOP3vXG4kA+fWyilTmJnwlJiyvyoW7l/av0tpw==
References: <1794914060.606144@yunsilicon.com>
 <1794914060.189871@yunsilicon.com> <PHN9AhH-TR23VM6YCYNEYw@monjalon.net>
Cc: <dev@dpdk.org>, <nana@yunsilicon.com>, <qianr@yunsilicon.com>, 
 <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>, <stable@dpdk.org>
Subject: Re: [PATCH v4 2/3] net/xsc: fix leak and missing null check
User-Agent: Mozilla Thunderbird
Received: from [127.0.0.1] ([114.92.245.110]) by smtp.feishu.cn with ESMTPS;
 Sat, 21 Nov 2026 16:04:47 +0800
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
To: "Thomas Monjalon" <thomas@monjalon.net>, 
 "Stephen Hemminger" <stephen@networkplumber.org>
From: "Renyong Wan" <wanry@yunsilicon.com>
Date: Sat, 21 Nov 2026 16:04:46 +0800
Message-Id: <cd058a44-77ab-4db6-9c15-fa38c6f73d8d@yunsilicon.com>
In-Reply-To: <PHN9AhH-TR23VM6YCYNEYw@monjalon.net>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26b0150a0+c5f897+dpdk.org+wanry@yunsilicon.com>
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

On 11/20/2026 6:36 PM, Thomas Monjalon wrote:
> 17/11/2026 12:14, Renyong Wan:
>> xsc_dev_init() leaks the structure when the dev_ops lookup fails. Free
>> it there: xsc_dev_uninit() cannot be used, as xsc_dev_close()
>> dereferences xdev->dev_ops.
>>
>> xsc_ethdev_tx_queue_setup() misses the NULL check on the
>> rte_malloc_socket() result. Return -ENOMEM, as the Rx path does.
>=20
> I don't see how fixes are related.
> It's probably better to have 2 commits.

Hi Thomas,

You are right, they are two different bugs in two different functions.
They ended up in one commit because the GCC analyzer reported them under
a single entry, written in the original report as:

 =C2=A046: xsc_dev_init() leaks a structure on the dev_ops failure path,
 =C2=A0=C2=A0 and the Tx queue allocation is dereferenced without a NULL ch=
eck.

So I fixed both where they were reported. They are independent though,
and each one carries its own Fixes tag.

If you prefer two commits, I will send a v5 with four patches, the code
would be identical. Please let me know.

Thanks,
Renyong Wan
