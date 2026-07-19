Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA6FC44512
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Jul 2026 09:42:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C37540297;
	Sun, 19 Jul 2026 11:42:52 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 1AF0B40276
 for <dev@dpdk.org>; Sun, 19 Jul 2026 11:42:51 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id A95851D0002F;
 Sun, 19 Jul 2026 05:42:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sun, 19 Jul 2026 05:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784454169;
 x=1784540569; bh=ev2g1Nli/6VcdufYKLsSlCcsinffJ8pn4E2wKMnK1Is=; b=
 EdWWkMHdr1wpTlt7kh/pZVJ/Eg6fiHeozuGVmX0ML5JqpfUTjkPUccJyOMUvbEqK
 Own6iKueg5CxSf1S5RuWAixx2wbWaYIxIw0zn2LZRRZcMrhDdBshu8qT/TgYnAOE
 6KmZbobMY6A7bXO/g1ic4MOfAJhrLPbu7/Rn9XVbB5rl5XP9gBQWkqAyTujS5vqH
 ue0OvxHSwae0Ozl4dGo+zoqt4T+oEvcoJtrcel5ZaaBShg4iIjfzZDCzm/a1peK7
 o6tZJWqrVGhLm5E1WQmeITvpm+BHsuPFqx5zhXzGP1SERwD9EHCls8r+21Yu4pA1
 u4aNYTl3FjEq7OJPZsP99g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784454169; x=
 1784540569; bh=ev2g1Nli/6VcdufYKLsSlCcsinffJ8pn4E2wKMnK1Is=; b=B
 82h+M1zsCEm83tPhYgHh5Q1V5ijivzdaPgbFzkEMjCB/f4tvpEkzK3sCapQ1Fu1H
 i9ArlvohDNfBXgOG0ajBRQ0cce73f4WuA3ANR2rv+N6ak2XPw1pJeVT3oojkojpa
 7sgEw19QreOS3pjM9jBnwzZRC4qSo8tpuWERBlzL68NuOM41YPG5ygh5ehFgGhID
 xhxKk0Nbvpy8zN0R3b56AmbWCpW5GVMJIPYo5eYIYhY9mtpwUXkR1KzV4FCJcIex
 65bcMQTLxiI7WA+inFtXXtTTaqpbQJXNBjo9BKYBodEiufyajFqA8RIh2XJtqVEk
 Qp8drCOJgHL/MfCe9uBSA==
X-ME-Sender: <xms:GZxcamkZxI2q_UKeTa3iZazAxxejnDAjAik6QCQEMgUGRh75xeYuhA>
 <xme:GZxcaqIUysc72pwmn3RTZl_P_9qeHJF1zdc1Vok1Jx3NJ_ROUM_JVR0SUTn-d5S0d
 Py91Pw1BzG9N7o90GU24PhL2rUd7IZsq966SFDMLAz5NpDAWJ7A>
X-ME-Received: <xmr:GZxcanZe6y8CUupJvIUDBqLv666y-2o0REhWHsdlvHz2GIYs-mkroWzV0C83EV1OX0RAKuVJmezYtLRtVg>
X-ME-Proxy-Cause: dmFkZTEK4o14tRfMOdEfwmdc8m+ezr66r9Kg3QNidUclvzsiMPhbI3GNoN9Z5ReCyHa14j
 flfUw/vmEC5SdygL67LHonp27c1y6Mgw/Gl/I0hTs4ZUTqb9cissM6cKDLQ2bpVLNHPUr9
 Tg4XXkhe5+uHIUoPzNNuka2Uxm1vDFmc9CROEQFSdToAsi7mz2CtLr4hAs+kAbqtdHu5a9
 B1+uDnw/gQH1delBm1P6CVmj76zVTPLoJxACBXZ6FrPmANesfJ1vJuY50gqFbEnx10EKG1
 FeJmbYKlcG/G2EYrI2+OfDcCAwV2TToAMCd4YgqpUqR+9xhdlhn4LzPlkbPg+7dhd4wiNf
 MZhXMyopP41SBi0tYV+ebRsUGAlg1a3DVIDZBSR6JorUHyzx5Wzt2I4Iv9Nv0dzafOTZC7
 0uYG6qOgXTtt5OSI7HwII0XSmA5V/6qPZQGVv4xHCf/hGoZUIIzdB5mv7f9VQcxBHV3MUc
 XQ7t48TYp+7QKmo8O2IHAI2qVwmm2HkpuwTYfjVOlYT0OXEgUS9V1bhYXCf8rR5l/gWcvN
 kFRRS3lHGHu84/5iHu/YO3DwpFS0ZRF+DJBMDn10U37oWBKTrX0Wyva11bc4xJpG4D2ysk
 w4l0EPqdju6J5SdPUoDmx7JUwHvG2cSSou7vM3yUfoxCWsHIOWupI99UweEA
X-ME-Proxy: <xmx:GZxcasbbcB_Yob4pCvAXmnzfDqH1k0PznSoKekGLHnjJMsuTR5FTfQ>
 <xmx:GZxcanltUkvlPv-IOrLPP7aGolZLISItEfnnW-FIp1BhPM6aTs1U6g>
 <xmx:GZxcaoyb2SGfwgMhH8nVa-dq--ddyP5zwyrJmiTGOA50QY8ol6jrNA>
 <xmx:GZxcalOAPaJVYLg_m0RFBM57NhHCKBGcgyxVS6fKSmVGCNiH9fzavw>
 <xmx:GZxcarFMHfq3laif076SrDGyvBSr0GpvmzI94PTRm60s-JxpuslKgCEX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 05:42:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] maintainers: fix app/test attributions
Date: Sun, 19 Jul 2026 11:42:46 +0200
Message-ID: <KvGFF4luQkG5ERfnxWy4mQ@monjalon.net>
In-Reply-To: <20260429162913.272259-1-stephen@networkplumber.org>
References: <20260429162913.272259-1-stephen@networkplumber.org>
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

29/04/2026 18:29, Stephen Hemminger:
> Two app/test entries were attributed to the wrong section:
> 
> * test_event_ring.c exercises rte_event_ring
>   not the standalone app/test-eventdev/  binary.
>   Move it from "Eventdev test application" to "Eventdev API"
>   alongside test_eventdev.c, matching how test_event_eth_*_adapter.c and
>   test_event_*_adapter.c are grouped with their corresponding
>   lib/eventdev/*adapter* sub-libraries.
> 
> * The "test_*hash*" glob in the Hashes section unintentionally matched
>   three crypto hash test vector headers which belong only
>   to the Crypto API section. Replace with the two narrower globs
>   "test_hash*" and "test_thash*" which together cover every legitimate
>   hash test source (test_hash*.c and test_thash*.c) without leaking into
>   cryptodev.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied with fix lines, thanks.



