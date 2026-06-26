Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C54C43327
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 15:04:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCE6B402E7;
	Fri, 26 Jun 2026 17:04:06 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 0E500402E2
 for <dev@dpdk.org>; Fri, 26 Jun 2026 17:04:04 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-30bf8b2bd20so2428151eec.0
 for <dev@dpdk.org>; Fri, 26 Jun 2026 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782486244;
 x=1783091044; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Yh5xV/GGuGVtjZ1uaniWzFtbM2vUKNBTKzo1jI3DnE=;
 b=H2o6MA1Eui6wsFC0BHAdsihQKymfZILaYVkBjjmxV/KbEfj1qGo7CbJh/IP141qS9u
 c7c8rX/+fAVIByv9wG4TUJRj+Zth1Eb0ABaKVpSsvhRnIgbIvalQXG+4uaMYhDLtWXom
 EZah5yMTA3cyqMDtWsTYQTY2dzmGdndNiGfIQbBkOvUAJTDfOg+QayHXLw0Ad3tVTXfL
 POOqAUdjL+6E2ZtdPw/BVmtoKCSGmn8FbDaPiwsrUSK2HSDwQUwcJS0JTVVG8zhrRNsS
 LM+2j0yzomRhMBjHAv9TZUxvwqt5I49KCMrUjWro8ufM9HKA4fgG39s+T02JjILdh8AX
 12PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782486244; x=1783091044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Yh5xV/GGuGVtjZ1uaniWzFtbM2vUKNBTKzo1jI3DnE=;
 b=gzvtOGIRZKkekvgYsDd5FhWOjOHUwuroVuvolt6pmqkz7979j9DgOj0HpJA/32dTEo
 1sqhbMa82UTX96w2fa+aB+xjHkgwoIMjcNzGHNTIldszQ5efXIDMsCUf/aOXl6vmOsp5
 FsT8IGF4iLb/wu7IHn/AoDHYr1kdwewKEtox5rJBSjYXeduKr2PoktUp6obJuvX21tgu
 tIfQt5zYMQjJJXdP3l++e5quHJTz9SOsLKSwdas88K5B/6QNnAt2ctrr+i24Sm2SNr5p
 e5VFtyUaqGwF8dxKlAWv7+ZsAO2w0r5FgUBeTxvkoIjuF8aXxn0kZTjqOORqaSpuH8QH
 d54Q==
X-Gm-Message-State: AOJu0YwF2OrZDFTDehVCUtxFbKLEuawDwnF00ZrpTTjSRFoMy48cQmIz
 qvs1o83umdgN9M9I66VvGtA1xe6r+VWno1K178FRXwf7y/zJ0+9Z8J5n81LDKrRczt8OUzgApKB
 uDILJ
X-Gm-Gg: AfdE7ckAKzdXloZMpjVj5Wvg/2EntX/DZNNvJX4mRCY9/7qtTgXjbpGR5L2H4gsNpfy
 nvKJ2v8S4rvldq4OT+1PpqoMIVMutL5EX/VafsVC6dKKKITGGyKJ6AhYPoouS0JRJY4yw0OFDDV
 ejencu0z1HMXZA9jk5kUoNWosaSpM8a33vdOQG5M98O5pchZzGCcQZhW47HjuPYLQOhg4uwVOVf
 gPpvYwMZgI6cXcXcgwuJ7GRpBNcuWeNPKIrhi/O/fsH3/YysOAv8CKa+SLGZgo9vTz93P5k4wb+
 fVpPeaf7SctEihzo970R6BgERJrnqgXNhH/J1FAYFg1KkN5ZscC013X5OcZuiQ8mlUHnggHxVeZ
 ZykZ46eXFukgBglwl6IvijKy1ZLjAEIPrBmRt5tWcSMhSg4JfZgJYfbGO064LZNx9LhJ7ckncFt
 c3FrM0d6vc5DvGjXOcG/7V2uWzXVuLMgRJzW9pcrdrzB9KCEtru3zwDg==
X-Received: by 2002:a05:7300:8621:b0:30c:ab97:d7ab with SMTP id
 5a478bee46e88-30cab97dc16mr430763eec.37.1782486243721; 
 Fri, 26 Jun 2026 08:04:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a75sm18359919eec.19.2026.06.26.08.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 08:04:03 -0700 (PDT)
Date: Fri, 26 Jun 2026 08:04:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, marek.kasiewicz@intel.com, thomas@monjalon.net,
 mb@smartsharesystems.com
Subject: Re: [v5] pcapng: add user-supplied timestamp support
Message-ID: <20260626080400.42180308@phoenix.local>
In-Reply-To: <20260626102213.776257-1-dawid.wesierski@intel.com>
References: <20260624215858.710217-1-dawid.wesierski@intel.com>
 <20260626102213.776257-1-dawid.wesierski@intel.com>
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

On Fri, 26 Jun 2026 06:22:04 -0400
Dawid Wesierski <dawid.wesierski@intel.com> wrote:

> Thanks again for the review,
> 
> For v6 I have added the input validation we ccheck if the timestamp
> PCAPNG_TSC_FLAG is not set on caller-provided input.
> 
> Regarding API versioning my concern is around source-level compatibility.
> Any application that calls rte_pcapng_copy() would need to be updated to
> pass the additional timestamp argument right?
> 
> Is breaking source-level compatibility for existing callers of
> rte_pcapng_copy() acceptable here?

DPDK does not guarantee API compatibility across releases; only ABI.
As long as there is a release note this is fine.
At this point, might have to wait for 26.11 release anyway.

Also, this is not an API that is commonly used by applications.
