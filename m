Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FB8CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 15:57:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CED24065B;
	Wed,  3 Jun 2026 17:57:44 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 39870402CC;
 Wed,  3 Jun 2026 17:57:43 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id D6C841D00123;
 Wed,  3 Jun 2026 11:57:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 03 Jun 2026 11:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780502261;
 x=1780588661; bh=YUWGfTf2MeWVMboUbDPqD1tidJHPsgYvLs89y1Bhmyk=; b=
 fk6BnBPHjZ8hrJopSI1jvV+YKuatv30WQWwBuIshqCHIrVc4W05qgG1ja4gp0ByF
 YsiuH05UiNMBTCj0F6byfyABgOViwkwBxcWsO6awhZd9/f2tZTlq8OzTgG452466
 YYSvg3siv+AikDTgsYTta2y+I9mHqUDvpzgXsmDaUhn1GBFW5x6ZzL50PJtCyFwJ
 GVs3HATQuPvM5XaGmh7GFhb6VjPeSlCMYRTfFVgO2gJkbjk7XCFgokSX8mWrMnFm
 Ygs6puuLHF4hWomzhJ/silAHMntrj0v3/IPvX0vIvZ+1sePZ2EUDcKBrNveL5Tua
 bgyHSOPsTBR9WO3V1rcDmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780502261; x=
 1780588661; bh=YUWGfTf2MeWVMboUbDPqD1tidJHPsgYvLs89y1Bhmyk=; b=h
 +hLIpNYuwUptf2QrAsDjLPAoORu1ygVb+PqXN3bYUG9S2sGjaGLvHxhSyj0uCeBH
 +nnQ1XeoiZMjUffw7d9NXvR7Pdpgpyd/ekWlgZZROtOj5ftthPTdqA8/9eVhTu5m
 XNqLrWBVzbdw5RMdh+8zbW5tw5z6aQe0GiG/aOsxF4ociNbFH+PV/wvwg25CUvyR
 N5Vq7lwT0e+P/uoRj8xeaMxH86cRIKRFaBkWZDFs0gXNFSbRAkrDTk6ntnv52dGG
 fN0kJ/8OpadAs2PdgnuiUlQqZjtf2lmhj3oKHagReXULGheaz4PtwnO79GF9k9++
 N5r1ljtQgPb0fBEM6Z/Vg==
X-ME-Sender: <xms:9U4gan_yAeSBMPzMqrovz__HB4gvMyk6r4r2kqUd4eGkze_M_OeDVw>
 <xme:9U4gasqzwodDCUKKa8MZoM4KsyxDXrAgUPaVhvothJDJFhyJxyG61O731EzLM3prw
 oEfD3nokcqqU4KVUv5U7g6xfcI-HHRPtXkhq4sSVxt0-Oz645V-mRo>
X-ME-Received: <xmr:9U4gaglR3_uAjx_cd8idCjbNbRv5i1NO-Hk_-kJHtrrII49v-FgCdO8KULRQ8HnAtOJFymdW-dXLOWDCB3aK0XeAEw>
X-ME-Proxy-Cause: dmFkZTFlZJniYOPEGHh/v2+uLT+lAPveaKBKnsyGyFZ6naO6rgeyiEkjdbMOEDyEaaj3YJ
 r8aAWDKoQu8gAwQyEsnSqoHsYT6ACaa11P3FeaFuVdmkdd3wZDA8DaGm0NrAJ0Bl3IOe5H
 ecJZ4ZUxnz8RtKeYvfxfvaKaNdZZTTS0UY5TBJOSqcl0UlwlHeRTTdCGVyTvb9bABk1sVz
 M5urBvWc7A3dTERyBHw9iXeeDX/6KUNlcNHsGeCNIF4XVgMsXZD9RUHanmCTTKvvGmZgL6
 OtXXIBZQ2we4V2vGb0XPMHe23bPBmnTikrUwzAxo5FozWmVYO87dB+CtamZSFsAO6HpaHO
 yJShpCmyw9Ny4Jti4yiOF3kzFHmbcoAXhyQ/Z8LogvHvGaT97PdueddCuWrv87n+Q4SRK3
 BVET91hxegwrixHIVZZw5B6A+1JasRNLqzI3Ih9zLwzT6rIo3W+EqBRLqU8tLgsnqZAAuN
 Q17NY4EZimHR5BNFidz3wAs8gYM2VsXfEtYO/3Y5+WsyBPvo9VzETntPwm7Zo2LYhKWB+t
 FkaZ4Qqpx4F0Oaygbgzi1U7dyUWe8dC6pUVT/l3hr7YTEH4n+gxatPFCqoxWmaZY6gRe+j
 Ue/Fi4LCAiC7r/XnEXDZrYGsbIZW1kIcG5Zci6qYayqwHKYrAMsweifUrUig
X-ME-Proxy: <xmx:9U4gajjYoFqHDf04ZUVN-tLUNWIsvA_HAgG-tG8-SiwqRe3DrLwKoA>
 <xmx:9U4gaoe6IUVC5OHYVyvvBAriMsxjolEMaGjSUbi1lvjGzx2a7Wauiw>
 <xmx:9U4gajglU6diR9eqAZTQZYex1JqF4-f9N5oG_WglH99bpk8f6gLEUA>
 <xmx:9U4gagz47DcdKLDppOm0mKpfu_wNOHAkLVIE_e0-meJ2oFxhEf2_Sw>
 <xmx:9U4garWoaQ4-QoIvbb9lX0KmjObW0ZO_kJEDx-472xTol7gCHHS0Mg-Z>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 11:57:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Michal Sieron <michal.sieron@nokia.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v2] eal: fix data race in hugepage prefault
Date: Wed, 03 Jun 2026 17:57:39 +0200
Message-ID: <5yQuIQaoRLG07ymdJxBS4w@monjalon.net>
In-Reply-To: <20260601160019.116067-1-stephen@networkplumber.org>
References: <20260520170812.759638-1-stephen@networkplumber.org>
 <20260601160019.116067-1-stephen@networkplumber.org>
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

01/06/2026 18:00, Stephen Hemminger:
> The prefault step in alloc_seg() reads a value from the hugepage and
> writes it back unchanged to force the kernel to commit the backing
> page. The read and write were not atomic, which races with concurrent
> access to the same physical page from a secondary process attaching
> to the hugetlbfs-backed mapping during rte_eal_init().
> 
> Replace the non-atomic load+store with a single atomic fetch-or of
> zero. This touches the page with an atomic read-modify-write without
> changing its contents, eliminating the race while preserving the
> original intent of forcing a write fault.
> 
> Fixes: 0f1631be24bd ("mem: fix page fault trigger")
> Cc: stable@dpdk.org
> 
> Reported-by: Michal Sieron <michal.sieron@nokia.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.



