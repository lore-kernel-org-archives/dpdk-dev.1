Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F300FCD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 20:25:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDEDE402EB;
	Mon,  1 Jun 2026 22:24:59 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 0C46940150
 for <dev@dpdk.org>; Mon,  1 Jun 2026 22:24:58 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 70C4F7A00F7;
 Mon,  1 Jun 2026 16:24:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Mon, 01 Jun 2026 16:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780345497;
 x=1780431897; bh=1yJFGlF3+mqQvMQIuVcg6f+tdOkKTfJK0hQUrYz+jyg=; b=
 s+4/lSiNig2HSIV9FSYRbQFD9j4g3ISWPfIZ81r50SN17ynyMhPtDHJBWlXxQDOT
 KCvT1JVI1WhwuOpWlA5UGj2nouySmJ88IjxpeCK8QQEMBW/CcfOSLDTo6IUcB9Zz
 sK5Dc9c46xvaTS6siJ87H9yvQYupSyTaf+ZVFv5EPI2Gbim3ZbmsD0lY5ZZYkUKP
 c/F2cPEFAYtm6ZJ3Temhb9pycFGgEg1rGyttzUd4RC17yVjBsqw6D2eysrPjVyAj
 VM3A66zyYW/2QecKMok5GCr7SyCbAQY1IobTv38OU5XlLZEzOjcrO1oHyF4Flaj3
 bhkmlwQglQh+gf/7iCjq4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780345497; x=
 1780431897; bh=1yJFGlF3+mqQvMQIuVcg6f+tdOkKTfJK0hQUrYz+jyg=; b=H
 zgE97ZjC6PRv1Hra/DzJ2VQz8Q3WcOmrglfF9EFgJhr4NTxIA78JDG8Wm3b7a8Wj
 7/SyAnT4gTo7o/pDpn9lIVRAAr2NWbfJSc7Oa08Vspe29t1YB36Sx+fDYB41O6PA
 QDr/9Lu3o0UkRzqq/1rS9mT1OP9YGsb4V1Oa45nKQR2DBStpYqvHcmaIYbMSzrj2
 HnGgTV7umrIbLS4htojq8xwAkI3agSYw2JbZCni0QZgZjkGn6T5Iq0Y8dPxUyPI7
 0UfM78vfzJbQ+1+XFTfifBE/mQBdY5s9IOED7lef2aR1c1JQFfRr3SoIDZ+Hmd3v
 EinmYYMNq+KfCEy5V0dvw==
X-ME-Sender: <xms:mOodaodaUfFdRmTMHq3gldRmWK_smun6ytudKPngPAl3ebm7mn-QvQ>
 <xme:mOodahOWm8A4wibEy62pVGQI594KZToqlmQZmHCWYjaYb3nVtTkXlpOU9cQ-655jJ
 -HknLWlgZY2AQUAhjhPkZaaU2qbTmkB5S0iGl3I5LlwZe9wuyL7BZE>
X-ME-Received: <xmr:mOodaugFggxEZHxspyXj9R0-WgRVZLNOaaCAax7E2JqMn0XlKYGz6OqckCuO0mKXR-uCkbMyajVOjFLWSs1y9FlMqA>
X-ME-Proxy-Cause: dmFkZTGH/jyy5pDcFz/MCDSsPiRnBX3TilBlAbgyyVZPvxxX42wp4Sa+Fy4UYeYXGoT7SI
 iv0xMPTLE3wkBJyuRH4Y0uf/zBwlUHGUiWBJqgCKlx52qwTGBbApg8zyOTNjnk86VugicB
 YF/2qRhjbEp0H0ETeO1XWcKfezjr8bRMr4RewPz11zmIDEU1oFkce6Y+YZsMoIDM5/31E/
 dGaO6Bg1yAFV4NgN7sGVONfDK6D/TxKTGfVOheOQohvf+UF8AHt7IHhoGbJyKs20NojBeO
 3Ee6rGChgkjhCVHvk1YVlIJYHvOsEHtknMjVK0bCKJrZSNtEZC9EOzFS2lZE2+kS2Ahmjw
 1yI+5qyjOxOwZ/+tIiscYH/m3OkiLwu8zIClif+sK/HIs/iDFFt3uuwGAIVW/iRx8kZ9fX
 wqBwXcP86JpYJAMVMID0Wu8WCK6I7Ig4/N0Tc59FDzD4slmtXRrT6EQjNg/KKk/hFaUoHV
 2NErgBPFeZO01POYYKNBfwyMw7JmiMU91ks/ak9hkE/u9MtmzP4ZCfwp0e6DWR5Q3ENb2j
 TSvWFBVzwqWIbQmzI4UciRpUVYBie+vbUwdLinIGc03qc6D04ZnJ5kVvr0Oce77GJfPaBq
 0kY4Bzyc1tVc2VMXeHgk902pr17TEKtfrJiMKjjpOZ24nDyJpF7QjOYRcu3w
X-ME-Proxy: <xmx:mOodas0Bq5-GORpLc9fyokJVgsfIarARHuQ3fYTekcD9RocyyEnKCg>
 <xmx:mOodaggoq7suNvwiOBPLv0ZcG4I19T1ffHBQfSxd3uXK5lf2m5eVHg>
 <xmx:mOodakeJzdObNykoqnJmwEkewu0zQb2IixrlTC8UcwUGfDZY8G697g>
 <xmx:mOodarlQOH84i5yxp6uqnqaLeAtp4AvGWLxz3qznHKVczV-JMwkmjw>
 <xmx:meodajwHeegWw-mEyCSfqW4MrB9aMjxT53OSQmpTIB8jjd_7nrgOrbla>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 16:24:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: sunyuechi@iscas.ac.cn, dangshiwei <1138222970gg@gmail.com>
Cc: dev@dpdk.org, stanislaw.kardach@gmail.com
Subject: Re: [PATCH v2] eal/riscv: add Z sub-extension detection via hwprobe
 syscall
Date: Mon, 01 Jun 2026 22:24:54 +0200
Message-ID: <sNysWPxOScOg-GwsJvuWUQ@monjalon.net>
In-Reply-To: <20260323041714.4386-1-1138222970gg@gmail.com>
References: <20260318144021.3308-1-1138222970gg@gmail.com>
 <20260323041714.4386-1-1138222970gg@gmail.com>
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

Hello,

We are waiting for a review of this patch.
The maintainer is Sun Yuechi.


23/03/2026 05:17, dangshiwei:
> The existing RISC-V rte_cpuflags implementation only detects
> single-letter ISA extensions (A, C, D, F, M, V, etc.) via
> AT_HWCAP. Z sub-extensions such as Zba, Zbb, Zbc, Zawrs and
> cryptography extensions (Zksed, Zksh, Zknd, Zkne) are not
> visible through AT_HWCAP and therefore cannot be used for
> runtime dispatch.
> 
> Linux 6.4 introduced the riscv_hwprobe syscall (NR 258) which
> exposes Z sub-extensions via the RISCV_HWPROBE_KEY_IMA_EXT_0
> key as a 64-bit bitmask. This patch adds support for querying
> Z sub-extensions through this interface.
> 
> Changes:
> - Add REG_HWPROBE_EXT0 source to cpu_register_t
> - Fix hwcap_registers_t type from uint32_t to uint64_t to
>   avoid truncation of AT_HWCAP on 64-bit platforms
> - Call riscv_hwprobe at EAL init via RTE_INIT and cache the
>   result; falls back silently on kernels older than 6.4
> - Add 56 new enum values for Z sub-extensions in rte_cpuflags.h
> - Extend cpuflags_autotest to cover all new flags
> 
> Signed-off-by: dangshiwei <1138222970gg@gmail.com>

Please could you separate you first and family names?

Thank you


