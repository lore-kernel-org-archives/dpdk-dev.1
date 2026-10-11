Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EC7CA9ECF
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 19:48:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1EA340279;
	Sun, 11 Oct 2026 21:48:37 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 623384026D
 for <dev@dpdk.org>; Sun, 11 Oct 2026 21:48:36 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cc4b62d118aso709329a12.2
 for <dev@dpdk.org>; Sun, 11 Oct 2026 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791748115;
 x=1792352915; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8WuAtaY3sDOkyO10SYvZgeYTxe+2yDvXi1+9ispdkBY=;
 b=nYr7yyrQWjjX1j5pjxIqO6QFaYwJQVYjtO/EIwzfVtaEUxWRQag089vFoDYlbKZsAe
 ZqNOrUe+5qrSeKgEcB+uwhabM3LHl7OFylzzQDwYrdjvatUzu7ap6gd7gNU1UxHUMv6L
 p9xZODOfmXDBqycZcwb/+opZjczoiHljcSsw8Q0vwor4EFnaKVfUypA0DeN51OV7n6Q7
 fc1w5SgpjQL3ogcaC2x+1cDY79vLWWII9MPaqO6n7Nrm1mXgvBPR9TAkmRQQsT4Qcvm3
 7yr9gKe2nHk8v6rndlqOUvknvUnmJWERaN6MA94v+Ics8c90iQGbOrWbwMEyrp0g5X0G
 56nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791748115; x=1792352915;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8WuAtaY3sDOkyO10SYvZgeYTxe+2yDvXi1+9ispdkBY=;
 b=Dw2dFjxKoc571RIbM1hmToQVaFq18/8Dr4SgqlZhQR/64l0G5uhCDC4Qas19fNAVg+
 IDw81vE5RF0EA6ucFT5wTueST05ldsluogY1s14xNmBi9F1hi5Zp7EVU8yp2QEW7+lxq
 +ysEjoqeOne4A+pHZWc5B4yqy7oTV5kDtj62hSDJF/Ukoe8sMk5TAMYFuukLC1ne4xoc
 pqKxKpozMx/GwXgMBcOyU8xqGQpzEJvZn2HTQVh+7oZQobTYROXPH/2EHu0cuZDgkv4d
 l6lv7KNOd/W/wjAeNKUlzFPoAX8zUgfo0/SZ9TnPK/+MMmjzjLfxB6xfvpgeURxVatHI
 cOrg==
X-Forwarded-Encrypted: i=1;
 AKwUvByWbWvCgW0Yju6DKq3/ubT0+kaQVpv5sXtGPr37qetkSoJohVHhLHjqbYVK121UuGU9Jwg=@dpdk.org
X-Gm-Message-State: AFq9FYItI7vm+NH6WstmbBkKi1TcQkyTYKqAWENtt1O2lim/tPjn2blo
 pLQAbzMUSKfUdlmhCZyJTsWavebVCjGws9ktOi6p+iFGH/91lbBOvMT81KYH62Dghsw=
X-Gm-Gg: AYBFou1DgwdPVo/djBt1h0O/bkLve6efVrdGAT0qn07PWkVWMFyJsFK4BUXsTkTwyC3
 c4zE7aPh7+6SGrNyMreC2Vt/gGvGrM9luifHSZqnnCGs9SRegcRrFOj+ud749EvzPB3/yQ/awjD
 4JPgBBGbdhb5i+BpCmyrkenLhYrrRxxK+qISqUAIGgnBX1/VjdkE3Gr8b/JQdkAaBgfphPZPUGc
 nd1FSojYeXiO5W6NyoyMpdASqmalAc7p2HdxmFkkgS81sQOwaH7vSRs8MPR6wzbwo0TYw6STSIL
 ZYtDFVoGzapBZUi9wJ246OHf7qiM831d/eP+Rnm2pbAyMvMYhQriASvrrV0jJzg/SkL8sQBQwmV
 PkEdQhtJzNgk7gp9FQleG0KnVrNKBBGqEaF4vhw8CLLq1U+OyvLFuIEDsUAHh7RpJxOczVJGPRS
 tOisOmJmze7wS1LHj5uC4gsT7Ix9itgKDkjkH0qbWoys/bjow8J03uKrywHRLWNb2sdwUA56l3b
 p0SgH4m8KEDDM3JwM/ErSPlFynVSKsiRWVvVlLohk8P/decwX4=
X-Received: by 2002:a17:90b:3a48:b0:3a4:b418:94ce with SMTP id
 98e67ed59e1d1-3ab3a2fe510mr6401571a91.1.1791748115225; 
 Sun, 11 Oct 2026 12:48:35 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37817414sm13916151a91.2.2026.10.11.12.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 12:48:34 -0700 (PDT)
Date: Sun, 11 Oct 2026 12:48:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH 4/9] bpf: add callback flag to skip multi-thread check
Message-ID: <20261011124832.74d0d174@phoenix.local>
In-Reply-To: <20261011182158.124246-5-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261011182158.124246-5-qm2k21@gmail.com>
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

On Sun, 11 Oct 2026 18:21:52 +0000
Marat Khalili <qm2k21@gmail.com> wrote:

> Add RTE_BPF_ETH_F_SKIP_MT_CHECK flag allowing callers to bypass the
> suitability check when installing BPF packet callbacks.
> 
> This allows overriding rejections in cases where the port or queue is
> configured with multi-thread capabilities (such as MT_LOCKFREE),
> but the application guarantees that only one dataplane thread
> accesses the queue at a time.
> 
> Update the unit test to verify that callback installation succeeds
> when this flag is specified.
> 
> Signed-off-by: Marat Khalili <qm2k21@gmail.com>
> ---

Rather than introduce another flag, I would rather the application
do the right thing. It can just not set the offload flag.
