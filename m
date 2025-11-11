Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4D8CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 12:13:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B46C14026A;
	Tue, 11 Nov 2025 13:13:44 +0100 (CET)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id CCA4140144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 13:13:42 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 0405B1D0019E;
 Tue, 11 Nov 2025 07:13:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 07:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762863221;
 x=1762949621; bh=xfpkdWguaE7WFQYSaVR/Pw3Fz9HkjWup/xrqcWjQERc=; b=
 OLT50P8yJ92ZpLXzXWuRqzNyNcSJvWrFZmTFQWWtLOMVtOwKqWlghAupEblmRtXX
 dI3lhyqFWZsJnpXx6OCVc40wknJlMZSn3do3e12h9lccVdVGkBvcEoJgfhYEUZle
 yyA8aD7YMqA3IKuMmVQbkljiWh2bqGQI+HF4+1LDc9avWVbfERAPDq4/pC7m8oTY
 mcA823Zufem9+hQqp2Kh9P5Y/oiZsorWiISDt2jan9jE0gn7Lqb5MWEX4gfm7Rae
 3YCbAdd1han40Jp2c6ug1IqG2MDbZO+y4nMWCafElGTtHQHneoCDoC4Uy/oqDzTQ
 gReUeTUwMkBkwVMncl6M2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762863221; x=
 1762949621; bh=xfpkdWguaE7WFQYSaVR/Pw3Fz9HkjWup/xrqcWjQERc=; b=i
 w6QPneqRLLHQcntjwRIVP8n6CFC8H/hPlN9i7E0XZ7qzygeh/XEa84VisNv6mRHp
 oFjyladclhp8midVgcvhWCAxfxuPPPQJh4OG6u3LTmiAcVG6Pmuwjiosu6fBwF30
 Q3YXMkh+9JXq7TAxm+jDai/S7tPn1bx2oHG69ahUzqC42rP3eIHUwYjoWXi9Zw5B
 4pVEYTxpvcMw0tvs5g2meqTF1VhJdrmaYaAZaac0M6ItD12egHEpp84ZwSbOzi11
 CYBGbFIFpaEeYoPF3M8Rh1hKX/8tVigkb7VvQopybjiSsgWipaD02zJtGHXypKGe
 c/Ea0XNfi74kdER5sPEWg==
X-ME-Sender: <xms:dCgTaQ4tGLQH19tXRMKgGobqiELfVAl8hfmIC6s1lblXm24Gs7o0Xg>
 <xme:dCgTaWOuRbFZPl2r5O_m8OK89ExWSCblaMFyA_mCIUUs8D5v80DaNY7umeveavXaY
 STkwh4rEcDdtk8iD1m_QJRzSn7IEFtQ60-SjcPtuib3nSogRcwR-A>
X-ME-Received: <xmr:dCgTaenkMI7NxycACf0ER-4A6aQqeQ34dWIwcaapLvF1CWXZbpi_xlkion_hqa2F5ihrdl8Ol93rQ50330awuf_grg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduudeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehmrghrrghtrdhkhhgrlhhilhhisehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:dCgTadTEGD8q-xU7opiBuKkCLy5luvlIg97e02tvxNc9TOXudJFg6A>
 <xmx:dCgTaaBOUJ4Ji6D_JgGR6mX3eeCWRokRGoXKyQd6kcVIoHC8pCxRhA>
 <xmx:dCgTacS9H7O_SudfuQBHNuwDTYMlwaoZZNQB3XTA84R62zUn8TpW6Q>
 <xmx:dCgTaQpgExw6KQWWtYImOxPGluCk2uA6NxqdQtTcPmEUhAJfojhsrQ>
 <xmx:dSgTaSxbRB0XlKc7O3lUCE8EWHbcJCGiqjPud72lVxQcaOS4vBa70rgY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 07:13:39 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>
Subject: Re: [PATCH v5 0/5] BPF cleanup and tests
Date: Tue, 11 Nov 2025 13:13:37 +0100
Message-ID: <10669584.lRi8OiJO2u@thomas>
In-Reply-To: <20251109200854.45942-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251109200854.45942-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

09/11/2025 21:07, Stephen Hemminger:
> This is a series of fixes and tests for BPF functionality.
> The new tests for Tx and Rx filtering require the infrastructure
> to build a bpf program (clang) and the tool to convert object
> file to header (xxd). If missing the test will get skipped.
> 
> It is disappointing that there were no examples or tests when
> the code was submitted.
> 
> v5 - review feedback
>      make it clear that load test is mirroring previous test
>      and check the result. 
> 
> v4 - review feedback - use alloca instead of burst to remove dependency on VLA
> 
> v3 - do not depend on xxd -n flag which is not present on older versions
> 
> Stephen Hemminger (5):
>   bpf: add allocation annotations to functions
>   bpf: use bulk free on filtered packets
>   bpf: add a test for BPF ELF load
>   bpf: add test for Rx and Tx filtering
>   bpf: replace use of VLA

I have these warnings:
app/test/test_bpf.c: duplicated include: rte_bpf.h
app/test/test_bpf.c: duplicated include: rte_ether.h
app/test/test_bpf.c: duplicated include: rte_ip.h

Given some issues are reported by Marat with the test,
I apply the patches which do not add new testing for now.

Please send a new version of the test when all is resolved.


