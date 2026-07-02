Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F49AC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 19:42:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24D99402D1;
	Thu,  2 Jul 2026 21:42:49 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 01A1B40041
 for <dev@dpdk.org>; Thu,  2 Jul 2026 21:42:47 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id 625CCEC00E7;
 Thu,  2 Jul 2026 15:42:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Thu, 02 Jul 2026 15:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783021367;
 x=1783107767; bh=PlHp27pLSozb6nXdG/CHvm7+mmpazZ6Is4Mtl+6PR+o=; b=
 iqjMQnEkej4j88Muwb49zvO3lLMVHIQacPAnnbRrIU84P6aIx5zq/ymCbE0QbF1H
 b2jd+oLLI9yv0iMTVcnqQH5IE6ROWCR1C6AzyVJC8zyQ9flJGDw412lVAhsMnVRs
 RJtalcZPYI5Zqq+hoobCo8wJDaAT2f16pvrmRFWN13i9yHxmDrnpN2WTa3fyDMOA
 FNe1grcRUEhQa/0kl6wpvHgtVO7mBaBYhLS93p7AANu1/hZbXwkowONqThb3gdMs
 aleKiNBo6qYhy4jEZWyduQ84XGHvFMobdHcma8VET3cix54l1sRKp4BnBn8wYLRU
 6esmYdhcw85O6DE1FvJafQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783021367; x=
 1783107767; bh=PlHp27pLSozb6nXdG/CHvm7+mmpazZ6Is4Mtl+6PR+o=; b=C
 WjjNptjD8H9mKHG7p6IezqsItf+kN7KD9gEsjrJkWBO8uv9RTh0gQrVLnnY8nWr9
 Y7Enec+uL/joFdlffWq0tYc5a8OhqUQTBpdq+RIsbj9E79s6jQGKPORAWx7VtKQo
 P30ZO36E4fPApIfQyKRf4fMVveuEtkIEAEUD57KT6IZNQymfnRA43akt4mmEmaDl
 h5Vib/DqTljxb21OKRmmD0gZ5HEtALD+nbEhzVDvVfP7C0ClQAkcd7g8b0pipI+7
 v5yXwUwXZHdhw/7xFDW51GPCGrwmHTwLdT/5cGDhCtm+uf1r71DuuhpN3zWYozAn
 tgPVCTy2+yhy9KYRE25fA==
X-ME-Sender: <xms:N79GavZnix44rvDB53xjp7d2rmA7t9G2RjQKxLkl5IpkfINBMEo8LA>
 <xme:N79Gaqs0NS11FHA9y96H8Nx7O0tFY6z69QlKOVOFVjdetNqBTZAwgMPuqEEl2gWMI
 7wjgpZQP-Dgxg-1qIz3PM0BtUKBBqQ0yDm52WQGNG4XCfdFDkHtOg>
X-ME-Received: <xmr:N79GaksYnPMOMbZrwX82Wq7avIcN72ZTZfFmWs8h_1VVp4YEIRSYikcG4cGjM0HAtjKPrGFyRAGkuDC0QHnpdSe98A>
X-ME-Proxy-Cause: dmFkZTGZRX09y9alTlcdLVvJW1ORLQMmFYnR94YwkmYUgiDoeV66dtlg7SDDyDLA5HCsX7
 rI4IaBlB8KELq1SKCYAs2sfYBmVP8yjnhBHLQtyfXwzKULWPccaS5PDINEyg8cIUYdUcVk
 Z3l/ab7ALIwReyNDjwCN1Co34MgLGF+fPFduP7HU10I3WIgTl3Gzxe53EBQpMgxs9m0Uw1
 ymqdKVK80+oJ2JcM0aYVufqkXa8NMzDoFgW4cVAE279OOCK+XLGvjxb+Iwk1f75hA40RAN
 Q474fCK2XOlQMGS0o96zrozSkT4yH+jfYKH4sbWX1Ymei9Mm3V/jH1xXujcO4h08DYlbOo
 FJTEJ5DzZbY8G8FFtO3j684aohWIj+jID/o6QDctv42bbvzxRnmkqbgixsgK+Z5cdmKxI3
 QyYNexj7MVOdbL8Coa0gOXr8hvZR31JZ25mV2BsYWrtQBHOUw+j8lnFfGUyBmtZd8xFSXu
 AoDGrM/H4i1wW7Y64+qL1ykMLncJA2OCL5nyHoNoespxJxplYApCJ4xyTHImMp0NWI1nlp
 uRfvfU7uyJAnp2u3i3K+3cI6xLsOKReLzzaxMo/o4A4OGtXXwOpliD8p4BtJuxidmgKx8z
 3PL67GP3pA26drZ4e/+/yhi8f/m/nrwSad1PkwcqhBu1+hNZENg0qOt9OW8Q
X-ME-Proxy: <xmx:N79GandZAT8UHLQNdzd32Klkr8Y-rlS1cW1vtzDibvAWjFt4XXQBRg>
 <xmx:N79Gatb38OmTp-bwoRA472gsjTQVNEeAnexTLj1RaHSlkDhDdeMiBw>
 <xmx:N79GaiUTZk9lP1T8afUqnKYTChKysZ6fjXphdaMfdCtQD4r5KTVRig>
 <xmx:N79GanjiiylxSSJ5Lvf6RImzm1j72JPsKJqMWQ5Mf7z9xYVJFSDLKA>
 <xmx:N79GajAZ4dVUCQjO_FOuvnhM8z323KKAVvjTqXv1NAVfA3wCLDPCeQRk>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 15:42:46 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Song Jiale <songx.jiale@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/2] fix Rx split in testpmd
Date: Thu, 02 Jul 2026 21:42:44 +0200
Message-ID: <wgvkTjqJRbSMmEOhPPRxzw@monjalon.net>
In-Reply-To: <20260624230656.2172633-1-thomas@monjalon.net>
References: <20260624230656.2172633-1-thomas@monjalon.net>
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

25/06/2026 01:03, Thomas Monjalon:
> Adding selective Rx in DPDK 26.07-rc1
> introduced a regression when configuring Rx split
> at runtime with mempools defined on start.
> 
> While fixing it, a test is added in DTS,
> and a refactoring in DTS is added as first patch
> to make the second change smaller.
> 
> Thomas Monjalon (2):
>   dts: simplify packet check in Rx split
>   app/testpmd: fix runtime config of Rx split

I was expecting a test from the bug reporter.

Applied



