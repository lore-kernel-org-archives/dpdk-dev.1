Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9318CCA465
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 21:07:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2617400EF;
	Thu, 15 Oct 2026 23:07:24 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 9EEA840041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:07:23 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id F0BD91D000D7
 for <dev@dpdk.org>; Thu, 15 Oct 2026 17:07:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Thu, 15 Oct 2026 17:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792098442;
 x=1792184842; bh=jr5ePEt629SnoePK/JlKQMHXEYuOYJcWNQMJp/r/zm0=; b=
 kWGSy+GOe6JjWHqEEVxZh65L6F6peZJVHtu6iMtpIzJ0/1GqWuNJyT8w0CyuuNBN
 wdvkoKkN8Xn7PB4f+JSjhyxCBRd7TSYu8+rRYl1v26o24jkWgKeRdbHa88yFQT7z
 SbdA4jjmkh4W7nDEiimVpRGMsaA5CdhNWpkHW2LSpCvbEo1vP2VN10TwxhxgNbXL
 0WlB0QIy09Pca1nB9PX9E49r0VZoEV0rMuGkTs2trjHsw6ECHnUUGAPKInEBbpJC
 ceAsyCV8wyPgySQYBL4XoN5CJ9HtFzVKVecq5G7o/0/fuM40sK7zlvAxzpTSCqln
 GvIV6T26l0Ti1K4R5T178Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792098442; x=
 1792184842; bh=jr5ePEt629SnoePK/JlKQMHXEYuOYJcWNQMJp/r/zm0=; b=I
 OHbtaU45ujIokv+AFOx2Rq+IB65iCVJa5UhxVgfAxf/gZCPGhwz0WM1z7B0pneVA
 U7lm5elAjS1P8UlBi0JkwQDe48eSo4DgKxeBpypNA3XRUabAKshtdMluskUBYaK1
 XZ1s4lGvuwKFReDza6uk+T8n6JKsGZEl9z7AYa2EYIDjSumPzzqFfaQ2qlpkbxFA
 FtBfvQgR3I4bI2LGdTVXt6YT4dJ2oV59JrCXSiSTNLopbpGLWe3uQu+uAAxbxJJE
 JNOkKEilBu01MYWBhw72YbimrpfSx474D+LUXUnnjc+OD2jkZ8gaJ95bxGIDbj+H
 qt3YLbxfYwnIS77wy+JnQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792098442; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:WS9WSAhduPMXFBB+Ckmk7HpYQeSRdH4iYGJ9kICJkVpiesk
 WyU2S6u6VXzsmEB5Orqng1/6xDVtDxcMxcKPUyZIJjBadavO37ztOVM71xZFWjyG
 URX2OxTlxgEl357s7mj4dxbhkLS0m+sKJzWN2Y12G2/xxxu/gy0vBTmEO4SLXn82
 MsqMX2lMqtn8Fn2TNWONgr37KxAkWzJ1tIU0f+tvam2ZgF5hVyBaVK/tHoz/oSiZ
 Anf/4QGjFRyxlwXDhtGcyyO1Tg3RvMX6IUS2zCm/hsNUoykKhNou5MD0ngBdmTZq
 awRESOF0xhTBpTh1SJa2tnFL1dPvbyWo+f/Jm/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:CS67WhLJQwojQzcvlyzXGsKs8eWs7dM0rkjxcPMVl48=:rMtVOhgNtkydH/ZXsAey7qst0hCMpMFIJsyOR5VkWcQ=;
X-ME-Sender: <xms:iUDRavDfvU5X-gXsZQb9i3QZvz1eFYhs7_cjXHU13Dq5L1tGYmZJJg>
 <xme:iUDRag9H4P1kEE6VjMfdt5P02DgkAChsEDpzodamViIg_k1VYbeIFB4zh5xUggGS2
 2kdZGEEp8xYrDtZYSJHuYc2fhbfcArby9wSPHmrqM7LVA10K42L3xn7>
X-ME-Received: <xmr:iUDRauHOFKSXxFBL317OJetDvZW6ZEOkHUNpqE-1ldq8Vr5OqZh0aAc_c_dqAYck68nKZzeMKe6CdAdPnjPSGWo>
X-ME-Proxy-Cause: dmFkZTGRHebdWHwvnFpZNyXocUvbAvT2UmVZGNXHJn6cZRtf6Sxd0cQ1shAvwWIynqoM+L
 1bzLzKDKFeF7TdNjNJ1gnhNLcGNQgNVj0hOpeYa7eXw+4kq3o7I7Suj7IRgU7qMxO/BkEE
 qFPDS7LiLmWSMuh4e1NikiUkm8UdkQ0QcOnkJiGWrWPWScPaKgd07ueUjm/k7OzMn3mC+f
 9noJnWkxBd4AcxAenAZk07O0zW0S2H3GtQIr2dK/luRTeWXrXHHS1IG941hETItICDzYA0
 nnyQAwJw30pf5vxut5eq0ZgAwDaacGuF9GY8djziPDr77b6Wf5/Nv3ZTVfL/Y6FWwJFMjN
 6RGEvPrGSEzFsj7gKP0osn2C+P/4oCJczmJ7TwE07Q7lTtRd0IC77tn5WSMfrGurxv7gL+
 dOLtgkkLPP+fUycx1UMwanLpIFuTJyxNZ1RR1ubWRJTAlqFshcmAQFIZv+UCHVx/HsLVLm
 Hv5q0eR+PCZ46Ecoa6wvZoPNAtcGsmM/n/0N3G7wV2Ih6G3WuUJRBv0QgX0JRBsOw1eP9v
 yo1JRbH13CiItidmZckr3sW183Ln2j+4RerFvObEeFITzJQoS1/VSg70HvsWHyqmmjkKoP
 Oxov4U8uyA2ePuUgpFpsShSq/qCKC5mlfkbIXLh4MwbPebNYa4MYqjGb29lg
X-ME-Proxy: <xmx:iUDRamMiU39S8DcikMbBUbPdDJ2hWezhcVayfnMx54zua-gAq5Q20A>
 <xmx:iUDRagcpoRfUcnknk6ivMsX_1vgYCvydBLN9BIlkZrg6HtEZPCH1xA>
 <xmx:iUDRajvsj0RmhPbGRq7hXnR-LnBTtQeD0Df_g_UF01pruFrdaqemHw>
 <xmx:iUDRahlU_qT-sXjBn2-CIz7H90NvwvpaNzqmCtegCQYS1j0HV3wuVQ>
 <xmx:ikDRajyu2ZfevXjXNBtLQUNRUlN6-7SA87Nafa87x4ZGfv_E4g9Q39pu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 17:07:20 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 "dev@dpdk.org" <dev@dpdk.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 1/1] test/bpf: remove redundant library guard
Date: Thu, 15 Oct 2026 23:07:18 +0200
Message-ID: <V-M0r-wdQAOoWIZy_1ucBg@monjalon.net>
In-Reply-To: <a4b3ff913c894845996b91a03c1cb88b@huawei.com>
References: <20260805090350.37661-1-marat.khalili@huawei.com>
 <40f46de2e8374938bb36eb428f45153f@huawei.com>
 <a4b3ff913c894845996b91a03c1cb88b@huawei.com>
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

> > The app/test/meson.build already adds 'bpf' as a dependency to test_bpf.c.
> > If the bpf library is disabled, the test source file is excluded from
> > the build entirely.
> > 
> > Therefore, the RTE_LIB_BPF guard is dead code and can be removed.
> > 
> > Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.


