Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB644CD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 09:19:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0CBF402A2;
	Tue, 23 Jun 2026 11:19:21 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 6BBBC40269
 for <dev@dpdk.org>; Tue, 23 Jun 2026 11:19:20 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id CAA71EC0202;
 Tue, 23 Jun 2026 05:19:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 23 Jun 2026 05:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1782206359;
 x=1782292759; bh=RXkk8VAx34C3HeeJdjGVl91oamA5R4mSjZWkHzF5itg=; b=
 Rvrer62p/SMU27d1vR/NxjVb/Q4vzdD0NQLxJgsi+ofYW+58D4DuudB+eDgWh/l2
 h7BfI+G6bvD7l0Vjb9nzK+heBnDh5Kd3wHvyGTDinyfiITssP1AvxOJrdJeacko4
 8oeVnLq+O1koE9eNnvcxXe5DV8pq9uyKXHUEVSBGLIKKoWAb3hMibwPAxN5JE0yL
 XJYxMmwb8bmrb+I/PF44wqPZseyBC6Z5SXyCs2TdhJmXnZPrFcGesL4vWR6cHBDa
 dH3MajxHzj7S/OCF0+IKDSF0RPQm4ytCyh9R9OMycZf4kl/2cdrMLeGOl4h2wJvJ
 JraicoJxuVIBQdeiU3sjJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782206359; x=
 1782292759; bh=RXkk8VAx34C3HeeJdjGVl91oamA5R4mSjZWkHzF5itg=; b=A
 H223OStub5u500Mbie/kcZq/pg+IaFCe5p5jJ0hZobFTgFfqn1140MJwQBI0orvD
 xDP/nkWmG0pxyhgT6fVXIaGaU3Yu0fsBBlk7dJyrxTAQQLRnQvw4qImRwfks5EiG
 5/wGBA7Kb5khl0kwCtNu5LgUJYR0V/ejnDY9L1UVWTNetwBDd/eZscQ82r/nDSUt
 l1ttDgTDkbkRswSVmZfFiBRzIkVKuALw79rQJySFHHqAcyX2f/001dqNXUYtCqLC
 LQT9JfSTsKZCThpFvOqvKZFhcyBKrHqeRNEjWIoL0o9RK9SrrGQTRuDX/J3nMEqU
 U9q2eCFfg4JIiO34jD0EQ==
X-ME-Sender: <xms:lk86apmjJnYcAgWp6nxPkavSUzU2cs5ZjF05MwRE3zNrIR7JoW3ojQ>
 <xme:lk86agRsEdNyqEV5uAi5hk1e72eR2dyLTRhCVAbCQ1tWu9fz2jYmxfs5gON3yZJuz
 UdkUzKRR56d1eRCrnpz6kdMf2eN0M4gZOnssg5-C2uVwvYlHJQH9g>
X-ME-Received: <xmr:lk86ajKpERkmSyROOJLKVYdOF5-tD9Y-lK1JH6OuuP4ER_a1TBvuVP0EOclnK7sJ9nYa2Cf8FAy3Dkc2t7PpmPnRDA>
X-ME-Proxy-Cause: dmFkZTGb9MkrAmY+nIjHdRPTDHRcSlteO4W9/2lU19Er1d+sG/gVENgRAU6/iMLMPcnOB0
 y8inDu3hjjtyW7VonLEZMlH62+mhbgkV9mUCWVXn8PjmLdiojjr7NV1mvijDkQ4Camvs3t
 fKS15ZacKJe9LXwgpoglr9MFyVhzWDe9HiAfwKlkecSAI+zIIdiN6+9GWF8xOab1RgpR5g
 Zs0Srf6DP3QjDiSPCBvvht4a5PpvPmey9yldvOozjgCCvCEdWmgPWWRsmoOBh6DS1JB/81
 GHhsR0m1OrYxeZHpFPs/RjBI49MBpFPwLkAMEuUn0RKnsEHG43qi5eqhy4AcmxoypKhPDn
 RGjnL2WD835IQWCUdUVlQVTTM4WWj1Zmf0kc6CgC6QB+SRytKHzvaqTVJzGoOcgFQWM5ZS
 D9rT+aBFG3Q4GiWa99YuY6mVDp9SNeq1kDz4s3Pd0mNAMZmnfB3ZZ/JdGJ+MwEsYp8PgS4
 6E40UiugciBT70yP+wbelAaCaM7JZpEP9BIm8lGifQE6OMHGvuDtxa24/f2xkGYhOETFVE
 eXDmPP5dEMrQuGTFsu06wYqyQe62gUaOSYAEp8Yy8iSyY9Q572BFDutOo5u4tQi0Awpd8d
 N10BwAJVxn78YcePEaf5RRwFq+c4EgtsK1slXg/H4hkIu+JM5M3A2u04oC/w
X-ME-Proxy: <xmx:lk86auDczPvv4EiNmUGyE3gOXYnL4UrnC5Wb0jYz-RtPU3TGMSlULg>
 <xmx:lk86akDePcami-cqADqUTs9kZK_f-fKnAPnYncHiEJvCpvnBBcf9bA>
 <xmx:lk86aoBLpubtmLPDHWhh7wT6DVF74Y3QgG6lkNi66dm-6n5Xjwrjzg>
 <xmx:lk86anriuGtmPG_xkyTHAcYDFHqcY819GNWIkgK1CGTtFDYmhI5eJQ>
 <xmx:l086auZ16bAUqhPSgH-p3HM3QTkZ77Dgi3wLiUhAhBBDeBXfGPxPU3K7>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 05:19:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>, david.marchand@redhat.com
Subject: Re: [PATCH v6 00/11] bpf: introduce extensible load API
Date: Tue, 23 Jun 2026 11:19:15 +0200
Message-ID: <gTfrLmiGT7u60MQvaNOzmw@monjalon.net>
In-Reply-To: <20260617194425.12690-1-marat.khalili@huawei.com>
References: <20260612084219.38399-1-marat.khalili@huawei.com>
 <20260617194425.12690-1-marat.khalili@huawei.com>
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

> Marat Khalili (11):
>   bpf: make logging prefixes more consistent
>   bpf: introduce extensible load API
>   bpf: support up to 5 arguments
>   bpf: add cBPF origin to rte_bpf_load_ex
>   bpf: support rte_bpf_prm_ex with port callbacks
>   bpf: support loading ELF files from memory
>   test/bpf: test loading cBPF directly
>   test/bpf: test loading ELF file from memory
>   doc: add release notes for new extensible BPF API
>   doc: add load API to BPF programmer's guide
>   test/bpf: add tests for error handling contracts

RTE_EXPORT_EXPERIMENTAL_SYMBOL(, 26.11)
changed to
RTE_EXPORT_EXPERIMENTAL_SYMBOL(, 26.07)

Doc and tests split and squashed in relevant commits
to have atomic changes.

Applied


