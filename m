Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B99CC6B38
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 23:43:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DD76400EF;
	Fri, 16 Oct 2026 01:42:59 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 7883B40041
 for <dev@dpdk.org>; Fri, 16 Oct 2026 01:42:57 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id C02A51D00071
 for <dev@dpdk.org>; Thu, 15 Oct 2026 19:42:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Thu, 15 Oct 2026 19:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792107776;
 x=1792194176; bh=134hZf1/7eJuyT+CG8B3uPI7zo3cSoW9wIIWvL+ph+I=; b=
 BMFdsnBFkcC+K8PD1zIOVq70ep7+Z8MZXkMT5fOscSJedkBsEJDDLDwVnE2KgzcS
 hAQ0yFAMJmJYsGRhkh8PdQidtzlnopFgL5gP1bHT0D2Cqx9Hk7Ipl9HYqljPkY6S
 pUqDQicyIiD7QfE/1B6qzFvMOq2yDbze/U6d5HNx3tgO12SLjFwgznRsobZcmATP
 Wih+cEdeuwMNB0pWL9bQPlEjwDWGeSuDpVEPWTPjkSZMcMU2jkr3ced+sUumI7uq
 PC+i2Q2UwrzbleS4rNAEsIHuYOSB1inW4RJcsWOCAqbccJet090MSWj4v8xDo7ma
 QUuMvKmUgLflhUcmJaXehQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792107776; x=
 1792194176; bh=134hZf1/7eJuyT+CG8B3uPI7zo3cSoW9wIIWvL+ph+I=; b=a
 RJ1VLbwJSNiSghajUdTNTV1SGWXghZykb7C7XSOAF7JVGQa6WE9K+c3yy+dsTRbH
 muRnq2YqGCjxF/0c5VNnh1Y/7SwPLmbXgTROd+3VjsGIKvAEEtTwcxO+6OIquUzD
 puJRvPO/6AY1BqkrPP/ArtDzL6MHIwWQRRi0CW7PRR2SiP8MuixqRNn8ZI51AoYw
 QpMlqS6ijAyryzzIZkmhPTwLS79k2hhjMhbu8TtH0bXVk4zKSO1KaFQUC+9rfcGF
 rzqYzL8s7bb+J043tLkLEfhxDZABHtbDuPbn07dbRtPbjOi5Hebe5635Ol8nQIqb
 uzCWvWufP03i2BQYkcs0w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792107776; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:AWxgV+dpCrXY25TcdOFUpI20US7VpRSrop6mjS07ihkskB6
 Rh5Z3RFXMxar7jTYZtiXp6Y+YGNmdG6+RsnwcGMBDu4768llg5Qz0hxsMa7v71Lv
 kOpP/OOFvcL1Rtrasxq1w/ZVmBht0qvWXMpAv7mzZTfX/QBgSd1sbpQomGcZDSSe
 hDpmfrPGI49XG6NjzAnux4E80zliyan7i8IjcXfKDCvPLCZ+xrnty3KSp/O8ev/e
 k3PGrtnSAq2oBk7jkjGihWoua77NxsNsVm/k5l0umRLwCtX91Oy4kudHZRDAulJ0
 gpi10gr5oR5zbcsFnAZL4IH3MV7sGUiKSMLLlDA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:paR2J83ebQIRAeBuT5o/6yo1WJfG9P0hA5BlZ/unoHw=:EZX7Gvbp59JEWN9TWA5gR6QeIon5URyguy404bjGVdI=;
X-ME-Sender: <xms:_2TRapCSugx1tUEF7Lb0wqkYMG_e7lq5SET20lry4ICrb5hpfxJh8w>
 <xme:_2TRai8VdFbMywtD0ivgdnJJQHWBwtx1cJeHlhto5Q8YvqOAwx_4TNcbM31GLq-TR
 atca8eC7-SmxqE_mU0PDW0p9DkfiCNffDxKiAkElMZxjcM2zCW12YM>
X-ME-Received: <xmr:_2TRaoFStOsHiPEVS-wsj4wz66wXBotzRbj2povvSW7eykHbKIBowZrsS195-c0x-K01H4kzxbnTI1vQoZVzDgk>
X-ME-Proxy-Cause: dmFkZTGGCSN4dWUP9Ll2Wkd4v5LgdlV4P0mkQ6m4CiobrzCW5KPDlU8S+PXlwZUpa+xT7P
 U7PapXAeq1QveR4SP1wb1AUoRITyGl7hIFJk+vFG1Su+xK1FudY1RbYWBC6J4cMdlXERzF
 SNtDW/oWzj2eE0b+0bhR5J4Ufu5SLq3lPLfq0TOhHcLXqhl3I+BZUI4oVjUL+QBD2/Imz+
 U6eOplw4ysDKoi8yEEyZGbRl4XQr9lO6Usgam9fcLExvNDcgK+r3/cEUHnNuW1bCOeQytQ
 5OZWLTf4m2v+3rs7hzMHvTCANq7MN3xUcOsOU+CNfejjdoZZg4/uKzL02myfQZzuLagMkg
 ow+Iyl2dwNmRYOsvoxs8NWRoPMKBIjjVawrhKi1yUKRr4GwRUSDVhwvVA9GRejrGg3TWms
 vzWO0XqpWnqmva7Jxx2QRO6WZ4jT/Dyh49ihAfhIGXGSv3pwJo0NMYM3mj6iqvjrtej539
 1T3wWbxKq8ABou5A7MAe03A/EwIx80BpUBPYJBFiTChyqoBH02Q9nyHPa6ylIo5yk6IBMn
 MLYUoaSv+uVANHchFC+FSfhbmeYu1JAxDxXrSHVa8fO9hZWLbyx5W8hB23ARpM5A3nEBrJ
 PQsitNCbXvIgxqQLqbKZdWtzdzY/ggRS8gm1my9VBf4NtfhyAd2/SidOsx4g
X-ME-Proxy: <xmx:_2TRaoPt_2Wk_OQtva8ttRPzv_FvPdFt3lUryx7euvfV4k55CngvyQ>
 <xmx:_2TRaqdlMo-LKacziU9JfC5nSbtT5YxFCZavOm73SrqGJZiWM_6PEA>
 <xmx:_2TRalt8Xk39a3N0bVYAVE7M85rEzcKkNUSnIWRUxEkWVlu_eniw-w>
 <xmx:_2TRarlx7pezlbtmPz6TFSR8L4xd23RbiGXKvGuGwf7Nv_s1e6y_3g>
 <xmx:AGXRagsXtyyQtJ5F2TawbaUvifhRSirEB_9TrYK5y5s_B-czG4bfaJCB>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 19:42:54 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <qm2k21@gmail.com>, Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v4 7/7] app/validate-bpf: add BPF validation application
Date: Fri, 16 Oct 2026 01:42:52 +0200
Message-ID: <d9SQxPwySmi2JPzs0FolZw@monjalon.net>
In-Reply-To: <T5P7ebNzTTqVuRXvg1A0FQ@monjalon.net>
References: <20260915192626.48125-1-marat.khalili@huawei.com>
 <20260917143539.46951-8-qm2k21@gmail.com>
 <T5P7ebNzTTqVuRXvg1A0FQ@monjalon.net>
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

16/10/2026 01:33, Thomas Monjalon:
> 17/09/2026 16:35, Marat Khalili:
> > Add a new DPDK application, dpdk-validate-bpf, for pre-validating eBPF
> > programs for compatibility with the lib/bpf execution context.
> 
> Now that registers are private to the library,
> this application cannot compile.

No sorry, just need to include the private header.


