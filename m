Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5D6CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:24:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FD1040276;
	Tue, 29 Sep 2026 09:24:05 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 104274013F;
 Tue, 29 Sep 2026 09:24:04 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 674E91400091;
 Tue, 29 Sep 2026 03:24:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 29 Sep 2026 03:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790666643;
 x=1790753043; bh=4r5lrD+KW3yVN+lFJAEsDkmZHlRSMvq4a2a2kLt3iNQ=; b=
 qRF/q4fq/EColcnO9dW3AyWLYr1yRMino/sG7QuiOuwZxfedQecn0R5svRO3VIwR
 L3ddxL2HQQYUft/YtV1yNeMqbTTvNk4v5vwpnxPrnOQzZeZ2QpdSoY3VkNWv5PCN
 I+rroDyG1jI43nvOSsN7Ow/IAPBqN3t8vJNIlOUuoX1kmrdlhD+wbUEKRCjVdlJ/
 VFO3gD3dreLHCgxIvSbxzESqKfobspPUeLrfEcHTrSEMT7CCMCV8MuBqQ9Tqv5gd
 i1pQ9fRo49QR0G+8JJpcIP3ZxIDoZn5kFZLfdab5LILIGLqqgrONLviPdXIfPyJQ
 gh5Qcj7SmmO+IkQyPmXxJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790666643; x=
 1790753043; bh=4r5lrD+KW3yVN+lFJAEsDkmZHlRSMvq4a2a2kLt3iNQ=; b=b
 i9Enr2qgUx/Q7f3Zy/YuGzPZh6lnVWEY270fwoYJzeRDlBOR3cLLO1if4wqXv6pu
 02NFdTZ6N8tZwnSK82X4WmK24qYVS7W9IAmeYO0sdPuyWEQ4ClxyQFyLjGjJshxr
 lT4KR43BHf7X3oHXkjhkhrNnN5eD49r/2xAUOHmSra/SBziz9FAu9WuzKH02G0Q2
 lyaA9PfDZX7SV0iHz2wM6bQD6T5lOlu5ifRbwI8QQZFuWl8RHq92w4Rc9UPiy2QN
 9GGaJPAuFrQVuL3H4t0FTSA0021gq6U5lKRv8VCMs6XHJ+k2x32rEdLH0Q7Q/bEo
 NKxa31GzokbhCmA3ftyjg==
X-ME-Sender: <xms:kme7asFgeRUmH6SGlrqxV7MA7PHZmfbCXObWCeibg9QG5iNX0p8zpA>
 <xme:kme7alcZGczOy4xeu5CHlUfkzFEoXChZCZrzgXQdVNsjuxarvoLLE0GwxL1ThHKut
 GwvMZ6nI7oOYsj6LZeJ-daXk1sY8Dazx4PFeLXkYt6Ilo3hrb7wKw0>
X-ME-Received: <xmr:kme7auH9eq8heDaGqFY4bQs6MpnGCpNtB_hIiGSPst48eqp4aNZFDCW0DJqJn_EUqC-KjmvRF6H25fZnNP8q2zI>
X-ME-Proxy-Cause: dmFkZTFp9i5N5e3uXwHseFCRUiW9B+YvMPeo8ygR88CZOnVps2JOAAlUVLiHSr67RMwXcX
 gduy9Aj1mcr6ISIa9lRptzZDoKVge5lqapSs4SWlCN9x+wX/bxu/X+9TmufufUO0zRPd6N
 emqpMwWNhLLuIdF/9joHXVVaoN5ddHOCi490329SXNTFVfDwL7BMs8+0GpXCjhdryUPYeW
 EE4rzaan2Q96gZRS4D0UW6TzANlQUXw5C0XVR6I1f3D+zaAvk9wWiKA/k83hPcAgcrr9qS
 T9JgumQ1kGEN6vEMjmFVzyXcZu7AKxpeyWHGnPXTYimVdluGyVfiVMh0nVKMhXbgZ/xIV3
 +QiLfaek1Ts+3UpFF9VV9z0FTGJ6iNW7dPsOmnKa1o3ooMgCHOgHN1M+OuMHi9DbSpucwX
 R1KK25EfRwpp/1dbUQBPGSrQ9anhgzodPcY9KtfrIWbS6jncPZVlUaNXCdG1Xe158JwHPn
 bMa7YVi1/lcrZ1qQhelCQtwQF4615SwShXOVXU1HS7xTOE4/C+do3fcpLWwVpcAgtiOX4h
 0h9c7VbsHMk3DIqs4C4UdCDs3bVo+PElFAcUz5qP/WWdqaEil/nC0KXzCUaC2QVhMW/1Ly
 QwlP7AUl5UN/1i5Oc98LL+K20T4Sjel2wx43B9Hr2VNiX/7seeIbZ7mfIDSw
X-ME-Proxy: <xmx:kme7amX_EMQRgHVWNErOnG3onGnwlBLqL1MlvHr_CutaEAQBGJMSZg>
 <xmx:kme7atKJtzW0p8EM_GjoaTCF_N6alFdsN-mvf5B4B5fiUgGBId2HCQ>
 <xmx:kme7am9osMeT6qUT2gnjEjPQVxEjj2eNFdTkKCQekd_OrhXxmmZmCg>
 <xmx:kme7agJnhblVm7zAQjcQoDmHGJ7PNopCrMpN-lxGC0yh_xSjUuSaTA>
 <xmx:k2e7amBmpCraSM0hPReZ9Uj6jvdAWDB-F8BHk_uVv_UtPKYKDU5CkgiC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 03:24:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, stable@dpdk.org
Subject: Re: [PATCH v2] eal: fix C++ builds when stdatomics is set
Date: Tue, 29 Sep 2026 09:23:58 +0200
Message-ID: <a5GjADT1SeiSQyFkuYrYMQ@monjalon.net>
In-Reply-To: <20260925124958.44356-1-bruce.richardson@intel.com>
References: <20260924141246.4037433-1-bruce.richardson@intel.com>
 <20260925124958.44356-1-bruce.richardson@intel.com>
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

25/09/2026 14:49, Bruce Richardson:
> When the DPDK build is configured to use stdatomics rather than compiler
> builtin atomics, the C++ chkincs builds were failing
>=20
> In file included from buildtools/chkincs/staging/generic/rte_atomic.h:18,
>                  from /home/morten/upstreaming/dpdk-stack-std/lib/eal/x86=
/include/rte_atomic.h:12,
>                  from buildtools/chkincs/chkincs-cpp.p/rte_atomic.cpp:1:
> buildtools/chkincs/staging/rte_stdatomic.h:30:9: error: =E2=80=98memory_o=
rder=E2=80=99 does not name a type
>    30 | typedef memory_order rte_memory_order;
>       |         ^~~~~~~~~~~~
>=20
> The cause is differences in atomics in C (C11) and C++ (e.g. C++17 as
> supported by current GCC). As explained by AI analysis:
>=20
>    _Atomic(T) is a C11 feature. In C++ mode, GCC 15 does not support it
>    as a type specifier, and <stdatomic.h> in C++17 doesn't expose
>    memory_order in the global namespace (that's only in C++23). DPDK
>    headers also use _Atomic in anonymous unions and under extern "C",
>    which are incompatible with C++'s std::atomic<T> mapping.
>=20
> To fix this in a resilient manner we need to go from two blocks in
> rte_atomic.h to three. We have the existing non-standard/builtin
> atomics path, but the standard atomic path now needs to be split into C
> compatible and C++ compatible blocks. This fixes the build issues with
> C++ while keeping existing C builds unchanged.
>=20
> Bugzilla ID: 1985
> Fixes: 5c381a3587d1 ("eal: provide stdatomic API")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



