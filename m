Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761ABCD5BA4
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 13:32:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E67E40296;
	Tue, 19 May 2026 15:32:07 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id BAB4A40296
 for <dev@dpdk.org>; Tue, 19 May 2026 15:32:05 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso4003149eec.0
 for <dev@dpdk.org>; Tue, 19 May 2026 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779197525;
 x=1779802325; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfVPhOT3ck5UNjqiYz0dVZnGHJxJs1Jz2E20CYoOvQc=;
 b=jKzHZOAC3k1Syarw56t3MM6CwQ0k/wej6C0sLFmVKIjmgQEyqKDKFMmpcB48FpTC5U
 Vj6M7lT229ADFrfkN3rULe6JFi/nkBQ10d8p2IBnzOW2MA1ySTmHKYbOc9HP4dKFmDVE
 jaZfmPv3dAB2IOzL4rH7HosSVywWS1tPE998ZwBDLrfaGT9rmxhXIxM8HZf69k+Q27gg
 w2U5KHGuAFm4Uwu596gmCp6vKHpm8b1MZ+a78d78NdQ29xqMErpr78b41H6g6TaFnlbX
 ftqyMU5O922j6mX8NZijY1SdFCXdjnbdaJX4Nye1kqwEFdstZZ4GxRIMBfQgfj30ZAYy
 RXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197525; x=1779802325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pfVPhOT3ck5UNjqiYz0dVZnGHJxJs1Jz2E20CYoOvQc=;
 b=eQ6+1STDoMuIkhTnuzu6yM2hdhqOpQA04FnfeFng0UYDALvFuXm2/+p97q4rJLBVqG
 vikDhVZvZPxtCZ2mQypAQMN+jnR40VNB4scx1pqvXbuOvkvjFgRx6BCOFVDxnNMNbqF7
 MvcEXAKRwRQaq2L0asv5zjLUTpiKrQPh7InHSGbPvzvMCEOVG8u2+woT3FRwAyXg5CqI
 051JZmpHQ8BZfIHsm8dBHOAlfY2uiM0bOwSfKb/UkaPsnqWceHKLQO50uW0YK6c5JapU
 48u0fPD192tK0SyDHyEO8Vvr3Ru949K5DNwc8l4JXuvLcOGGo8JYr0GpfZU20MesTGJU
 e8AQ==
X-Gm-Message-State: AOJu0YxhPci3dv2+N4K9EOlUKBCVm9WPUxTuhLgVr5H18Ghi8ecge0To
 fvl+4J2apdy5/ZTUpjv7dacY9J/lbkUGlKU+weTSbL6DPFdxSGorTJqF0Ysdz1/wJhs=
X-Gm-Gg: Acq92OHhSXrvFIzUgyICkFHG71L162ajbjQrM93SHIj/ZTSV6JWnBTMw3uny8UqeWQ9
 VortDHaFdG+Y30WLMxVtD9BOeJEsxFFFiMsoYgbbTM9Wht5i9xuCQ3hz0XM1TrlkG6U0NOEjOrj
 d9FoDrtY6LsqH62lpcOBsvFy5GKzunPfF0j5OuqJWClwIMJ+yj1mgZw4XrBZoYMCBJ92v9aQA/6
 HEnei1598zPQkXyDj5tDlDmLOYA4UdkXH75ndIGeeJ6EY0Q6PZ4FMzHqLIsr4VPE7I6VozeFxNf
 rZZ5fNIJt7Akii+mF72BwkTODXfzyRE3OXSQE545w+FZdGt8GknR1ldTm06VY0sODQv08Kq4YhL
 RBh+G32tcgZCnDeGR/0axGaWOBD5pHWgkcD2YKc7O2wVsbCnLWgLyjja7i0GYbol7L75x5Bh3fN
 B23MCGybqRTcO8RWKp/jydbI9xqdd0MKS4Wp8=
X-Received: by 2002:a05:7301:4001:b0:2dd:6937:79b8 with SMTP id
 5a478bee46e88-3039812b459mr9055421eec.5.1779197524553; 
 Tue, 19 May 2026 06:32:04 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e3c0sm20667861eec.3.2026.05.19.06.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:32:04 -0700 (PDT)
Date: Tue, 19 May 2026 06:32:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>, Bruce
 Richardson <bruce.richardson@intel.com>, Robin Jarry <rjarry@redhat.com>,
 stable@dpdk.org
Subject: Re: [PATCH v3 1/3] spinlock: remove volatile qualifier
Message-ID: <20260519063200.66dabed6@phoenix.local>
In-Reply-To: <20260519103640.3986710-1-thomas@monjalon.net>
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260519103640.3986710-1-thomas@monjalon.net>
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

On Tue, 19 May 2026 12:34:14 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> When compiling with C++20 standard requirement (default in GCC 16),
> the increment and decrement of volatile variables are rejected:
> 
> rte_spinlock.h:241:14: error:
> 	'++' expression of 'volatile'-qualified type is deprecated
> rte_spinlock.h:252:21: error:
> 	'--' expression of 'volatile'-qualified type is deprecated
> rte_spinlock.h:278:14: error:
> 	'++' expression of 'volatile'-qualified type is deprecated
> 
> The count field of rte_spinlock_recursive_t
> does not need the volatile qualifier
> because it is only accessed by the thread holding the lock,
> which already provides the necessary memory ordering.
> 
> The user field can be accessed outside of the lock,
> so it must handled as a C11 atomic variable.
> The name is also changed from user to owner.
> It will break if an application is accessing this field directly,
> which should never happen.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed

Series-acked-by: Stephen Hemminger <stephen@networkplumber.org>
