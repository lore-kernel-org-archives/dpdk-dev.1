Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDF9CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 13:38:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EC754025F;
	Mon,  1 Jun 2026 15:38:32 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 14A394025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 15:38:31 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 8D8071D00549;
 Mon,  1 Jun 2026 09:38:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 09:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780321109;
 x=1780407509; bh=VxklP+auMUezpHeZXJn5GV16kWO7cty7Im3cGAy/ic4=; b=
 B6x0Ft+G5CSaW4t6FO6T88tUnbcHkrkInLpQH0gQ/pdxavqPFYKyMGnabPVAwvff
 EvLbbXUfwStidTm9sQNGIwAlQurtRlBn5Q1zHWD6kvR6I0SIlUVb9gvi/U/C69Hg
 3/7JZ7jWJxlCi68O10Cbl42CuwF0jgGVgJQE1fp3/u8nxBLin+FVA+Dn0gUMF7wO
 3HEou3WjiIbDz24csnBvfnfilqk8ROY/G3OuD/17rwEDUkqvMU+o2FzYliSgDbfw
 f1rvTfyOfF/Lh6nfhtNyBbDKYCLiC5i7hNZoI79qRCciXDttK5wwcWtF16cHrkmT
 9+eV3cQeAda4iISXUcoIeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780321109; x=
 1780407509; bh=VxklP+auMUezpHeZXJn5GV16kWO7cty7Im3cGAy/ic4=; b=G
 OsllE9+Y9iyYeHTor9t0TVH2JhGFNpepb1JkJ4CmawcMVHRwwPjhmW8TyjRh9IJi
 ypI2hnQOQltae7ja90sZHSkJLnpVPZQIVDT1Plq0MoyZxxv6YjfsLwWPaDN+j6Pb
 Nh3GS2Wc6RobgLUqgb/8M9OtOy4zVSbKt42ikAWBop6xX6Kpi9sLuATZnGLzFuG7
 7NLUZXa4/OUjRrbSTRK+jF6CGJiWyK31hDgyeFqXywPSbJvZonAX+FJpKKoxMC1/
 umhthh4FxzeKNdDUO3/iNHNWgbHPeup5q18gRSARRkuW+rtqItxOPVuBLFCy7Ynk
 xPxTRn8qjTl9vkZBv0x2w==
X-ME-Sender: <xms:VIsdarhc7rHTSrr3zdFqJsoGQwOz42PM8lXStibLXNZlj_XkrpnocQ>
 <xme:VIsdaj6dT-rmrHCmWl4ibzgV3T2LS_rU71ehKpGNz1Oep8rRAAVEJyDrxJF6yYjKm
 gGkxg-wN3DYi8w6MVS6OlXa0EBuh6qIIVqGjEoAq3HvYoYsGXDl>
X-ME-Received: <xmr:VIsdaoHCHtSFpYEzExZA80qxwc8AuBJdoiq2kpJ1fDMheSBmVP2vMBO1i_k81V9TFeGpX0GMlP5XunmIXSNgjz_YIQ>
X-ME-Proxy-Cause: dmFkZTFjgyfD7Z+PYjFdGG3phZHdhzn/hwgcpKwsEU0GTTBLiSB5fIHIwsIsGab2UDVC5w
 7Ref57Ln7zhS5IWrCeNcViP3YcJx0i/gnpWiPlcqGv/ZTIYtNeNp2mKKMOcOoEyT8FxJKL
 T4+YKtbI0CZyexenu2l/1j5cnLv+N1a4uQ0Doo41IAUcbrXIZ5Umy3/+PmS9rL+V6sJ1A7
 b5J5S7Pv36L6D5OduXHHR4wELCutIKHYtylsiIOdLLV1E9kupm+WCW4UJkk9c2mjk1C8/F
 OHGfb5ekeV4zSnEUkpUi5lN7MVuK/Vs6TM2BvOKg05hUjy9fA4OHe8mPFUVfRpI4ljd3IP
 4rP4ToY2XFgYD6mmFC/yZECvuijBNFfMJcYqxkC5irfBVnc/97NGQ9oW8sDsBRUvuZVlO7
 oOlFWuRZNMHMNT7gw9611yZ9Qa+QIYazQZXA8I0JPDLJlR38+K7HuKKXv94tzhDtHDs+Jf
 9jQbKRBpEI+xO8+ZDXPwhhmvmAV1B4nEfxqiGYjJmb3VWgU7YluNP+Ybhq9hnkDJjSSnNU
 AWRWkl39hkiyrnWbtS7mbh9N+tVite1fFxomI1lB7TEFK/hC0tVYHPFw0vI1nTS7474oP1
 q3CS0sP09ocFHedtD4llRBFGaynY7d58N5KJKSejWr0ksntV/pTZoWY0stpg
X-ME-Proxy: <xmx:VIsdatIh9t1wFkSjZEve5Y5i3R45S5So8j_vCIzBH7SmktwzfgXtJw>
 <xmx:VIsdathLGLbanVD1s_cncHGcRpDqoSA-TH70qrG4y3TWDITcHUbTwg>
 <xmx:VIsdajmYSsrtWY5AUsGClD-E1unPHKVmRKhB4Y2rqT57QMqxpTVsHw>
 <xmx:VIsdasWcnC_IevhE9S8gw74uzWYmjzippQehfXEOq8kXzy511NjAhg>
 <xmx:VYsdahyUZwnTLS6PkIBo5_z8mRfHxXvHc1o4tVm7ykeVzvbjRbUG6aXU>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 09:38:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Vipin Varghese <vipin.varghese@amd.com>,
 Liangxing Wang <wangliangxing@hygon.cn>,
 Thiyagarajan P <Thiyagarajan.P@amd.com>,
 Bala Murali Krishna <Bala.MuraliKrishna@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v11] eal/x86: optimize memcpy of small sizes
Date: Mon, 01 Jun 2026 15:38:25 +0200
Message-ID: <JAYuDo5qT4OWJH9lfTRFKA@monjalon.net>
In-Reply-To: <20260521154214.1c171a74@phoenix.local>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260521185631.116046-1-mb@smartsharesystems.com>
 <20260521154214.1c171a74@phoenix.local>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

22/05/2026 00:42, Stephen Hemminger:
> On Thu, 21 May 2026 18:56:31 +0000
> Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
>=20
> > The implementation for copying up to 64 bytes does not depend on address
> > alignment with the size of the CPU's vector registers. Nonetheless, the
> > exact same code for copying up to 64 bytes was present in both the alig=
ned
> > copy function and all the CPU vector register size specific variants of
> > the unaligned copy functions.
> > With this patch, the implementation for copying up to 64 bytes was
> > consolidated into one instance, located in the common copy function,
> > before checking alignment requirements.
> > This provides three benefits:
> > 1. No copy-paste in the source code.
> > 2. A performance gain for copying up to 64 bytes, because the
> > address alignment check is avoided in this case.
> > 3. Reduced instruction memory footprint, because the compiler only
> > generates one instance of the function for copying up to 64 bytes, inst=
ead
> > of two instances (one in the unaligned copy function, and one in the
> > aligned copy function).
> >=20
> > Furthermore, __rte_restrict was added to source and destination address=
es.
> >=20
> > Also, the missing implementation of rte_mov48() was added.
> >=20
> > Until recently, some drivers required disabling stringop-overflow warni=
ngs
> > when using rte_memcpy().
> > For some strange reason, these warnings were disabled in the rte_memcpy
> > header file, instead of in the problematic drivers.
> > With series-38174 ("remove use of rte_memcpy from net/intel"), the
> > problematic drivers were updated to use memcpy() instead of rte_memcpy(=
),
> > so disabling these warnings is no longer required, and was removed.
> >=20
> > Regarding performance...
> > The memcpy performance test (cache-to-cache copy) shows:
> > Copying up to 15 bytes takes ca. 4.5 cycles, versus ca. 6.5 cycles befo=
re.
> > Copying 8 bytes takes 4 cycles, versus 7 cycles before.
> > Copying 16 bytes takes 2 cycles, versus 4 cycles before.
> > Copying 64 bytes takes 4 cycles, versus 7 cycles before.
> >=20
> > Depends-on: series-38174 ("remove use of rte_memcpy from net/intel")
> >=20
> > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
>=20
> Here is the full wordy all providers reviews.
[...]
> Summary across 4 provider(s): clean=3D0 warnings=3D1 errors=3D3 failed=3D0

What is the followup?
Do we target DPDK 26.07?


