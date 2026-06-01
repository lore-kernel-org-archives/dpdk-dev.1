Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA1ACD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 21:06:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7DEB402EB;
	Mon,  1 Jun 2026 23:06:05 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 025DB40150
 for <dev@dpdk.org>; Mon,  1 Jun 2026 23:06:03 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304d0ac5e3cso6195961eec.0
 for <dev@dpdk.org>; Mon, 01 Jun 2026 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780347963;
 x=1780952763; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cD07dvK6bjbishgoVqlU94iGlqm3HsT48sxVj48O2e0=;
 b=qOOCINRoFQtUSdXlHUYlJOMIHze4LiMpXViitn3cn0Z5cxyVTOvOCv43ZHNhN8YEkL
 2EJWrEAK0doxCDHjG2Zx7zE9nD9ov+WVnIfOxirefDkByswMUe0t72jCmHhxHIBrT46r
 jMPAzq0L69TfXufDHKapJHBrd9X3wcF0ky3sMxTKzdH624TOAqRNuhFeimqeUQ5WF5yW
 D/6LGGjrXKFoftZ1mcZfeKuiCd/LnRx3EDhMt5WFMcFOT2z3VUuj3iiEXNwDQTnn8bBe
 0bj7svdHLD5/jWJJizn79YnaCLrnFogZgJCwenlOGisESgkQ0RrwpraJDDxSd6F+UQXu
 XHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780347963; x=1780952763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cD07dvK6bjbishgoVqlU94iGlqm3HsT48sxVj48O2e0=;
 b=oaSwnZ57KC7GJtvuIVvmk4+heIo3NP++t1/ecmTTBr3v7IUCb+VPdA0OuZNjd5MHVV
 wws+GcxKQxzRFeuGY1Qdy4GRoHQrUxDXajgMR931gzwfn/1/lK+q1CwEwzwHxOE+sM9V
 9u1DDM/leRs50EMdoElv0quw6Mv6kpHlwR8uOivInnYFBbQWgIec0La6itJhDBJ7ZLFU
 gYwXDQVaXjOcxXBryeRgd3u4nmnaiVQc9gU0sxQxKkw7KwOAdtPvZ6znZtMML2/CVYzR
 3CxVzFQtPdjpfTpTvcGLNjITQ4y0Xg2GlU300/1Y3n+XsRmcXF+qXX9RoPyzmjZv88fJ
 OFfQ==
X-Gm-Message-State: AOJu0Yw9qwJrSnUZ15q2Xnl26Y+Cgx0+cJ7qyv30dg+Z68Q1xryGqhBB
 v9CBdlt/CgbbhvMKX/8yUTQEGvI2RxOTMcZMRMK5rbbAjUTORMCgphE7RLKb0arWVJQ=
X-Gm-Gg: Acq92OEWCcWByd968aUJDQsFeOXjoap7SPlwIP547R0vGdpTWBHCdXng2pI5q8DGmxb
 kUpbe5V7cnk/T8rgLLKjZGQRzWTfxCSzhZZvCM5z2xTfXjT07zi6MPq8OaB/OLRLgLeXTOkai5R
 NNzV35sNNhHfkfJQenvJdqK3WkXhM39rt6DTH3o2ai3WpWiMct1bBKIalWbPwwtX35oD0HroFqO
 TpsjA2LcKRICgRm2fZxenYP0QA/EOM8ALaWFuRGckvA6G8budEpP8hL483fon5tXTLVHWR/shVD
 2c24Ic31en8IOUK2BxjZcLrAdx5Wd1j5vAlY9lnelxnUbj7AEzT8EDpEqpFsr/+pLtw7RYTNPem
 ttVDiD+PXB8JJHlbxqmKJUdN1snEgDHHJF3rtCQ0MSrrMiee/UQr70Q9b1s2ELLI1UGZeYImLHC
 0fvrcjHQ5cThKuPPDGsAUEvtL1P+F5IddzMO5NTsGihf4qN+xN3BEE6gleyKIUzRFLOfE9JqPYE
 otlnAvCijJa8A==
X-Received: by 2002:a05:7301:fa06:b0:2f4:3a9c:818c with SMTP id
 5a478bee46e88-304fa75a308mr6157376eec.29.1780347962619; 
 Mon, 01 Jun 2026 14:06:02 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c3121sm9998904eec.5.2026.06.01.14.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 14:06:02 -0700 (PDT)
Date: Mon, 1 Jun 2026 14:05:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v4 03/27] ring: unify memory model on C11, remove atomic32
Message-ID: <20260601140559.2abce514@phoenix.local>
In-Reply-To: <b8523a4e0ee34e8b9194935574e86f7c@huawei.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
 <20260526232542.620966-4-stephen@networkplumber.org>
 <b8523a4e0ee34e8b9194935574e86f7c@huawei.com>
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

On Mon, 1 Jun 2026 18:18:18 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > +	/* check that we have enough room in ring */
> > +	if (unlikely(n > *entries))
> > +		n = (behavior == RTE_RING_QUEUE_FIXED) ? 0 : *entries;
> > +
> > +	if (n > 0) {
> > +		*new_head = *old_head + n;
> > +		d->head = *new_head;  
> 
> There is a bit of inconsistency with the 'load' operation above:
> If we use atomic_load(&d->head. ...) then it would be better to use
> atomic_store(&d->head,..., order_relaxed) here.

This is single thread case, so not sure atomic_store is needed.
The old code didn't do it.

There is a little confusion in the ST path.
It is used in two different context SP and SC.

For move_head, it is SC that matters and consumer moves the head;
BUT if using multiple produces MP the tail is also examined to
determine space.
