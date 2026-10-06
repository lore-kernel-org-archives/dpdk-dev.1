Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6CDCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 16:15:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A7F040290;
	Tue,  6 Oct 2026 18:15:56 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 7A6D44027B
 for <dev@dpdk.org>; Tue,  6 Oct 2026 18:15:54 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D01F07A01A0
 for <dev@dpdk.org>; Tue,  6 Oct 2026 12:15:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 06 Oct 2026 12:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791303353;
 x=1791389753; bh=LJDV5U/wF8BhBI3phV2zOpTuSTh7hDySnqCoyiM8KLw=; b=
 EOl8ex0Ha2ln5wV4Q5ChqmaIK078Tt+MZyH86vFv891r2ww9Ps9gbnYF15ufbswK
 AtZlNfxS8cTzSi/ZRpylvamoH0n/2TBbVmFxw1i4+ExM5kb95j4ie34yDnipJ+Ov
 /jKVfhu9YtrdJskXmmtUQ7w15HY5kXF4ypEDRFV5o/DfswtqCKmOk1Sc4Ap+0d9s
 4+KnJ+doX1l3Lj260MW2ZX94y1D1Ov1xNI707Ru6HHBdKn3r85rykK4aTWUHy435
 kfUJ4OwmE8xkkfVgLDCqhp5wfuipr0nI3EcZ+pfcsKs58WfwMHjcJGH84fZeYEhi
 NjEradiG4T8gUf/czg6IzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791303353; x=
 1791389753; bh=LJDV5U/wF8BhBI3phV2zOpTuSTh7hDySnqCoyiM8KLw=; b=D
 TPr7fxPhqg5mKtHM2WxaF/TD0S6Faj44LBHGFO08yOH+6ypnukQjqjgXLzac0Db+
 I9/ukMJqlOyieL3pyO+svg+p/sXRjf9/z3Jyp2N4GWI/tVoY/DGwT22FfRSXFn4J
 bFkW2yVVtq1JsoDwl5gCHZ+YwfS99MNgNReFNW1y1jVgsTAIgG/pwT3TLBQiURQ5
 lJKyyAhAg/ChW5l/6kcMXsfCZYty9Lcz/0Uy5ZDoxFXDee3b7q+A1nXvFUDRr7gI
 4HXwxLpSL/KNXQtzhJ2Yxg5yVeS7FAp+4rqGxaUt9clbks3BSs9S/3I8rMGplyNS
 XUZUsq6/FEdLcF+zudPJw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791303353; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:ga1Qn3WU0L0I+xBXRU/B8ccQ9IEpRLy9jF8KJJCBsLtj248
 +Amhc9pdG+GCq4edfy9uTFrTTkgpj5pQllpG2HRGbPV/7rq6qpCn9LpfOywTXwSj
 yFlgEa1tiu7CmKItXeIxQNFgBNtfLIZoOYokCZ3Yse3DFyEk0rcyzFk22Y+tWnNP
 383IE5Mp+WWSoQKrekAeVmBTfMFjM9+ExPd+uX8U9WD9OY2Rr1LWjtB8HTQ2uRMk
 jfXjQRdQ2D7OtbXPUALAtdD6OJUgaxeltOcqro7KSEBatROURVN5UNNO5HRBjzca
 7t7iwhu/aMsky7gItdgVbusSRLt3lNv0qyT2fvA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:sSYKHo+IyfvLGqYO335OjTavttfyxmvcr5EfUqT+Qxc=:wFw0c5Br+ciYu6NLnFvL3Bg3fz0HCAPVh4z9Z6pHkWA=;
X-ME-Sender: <xms:uB7Fajx3FQ8u_EtdkLWYYElqkFvYdqPZFL1kgm3zRdzG_CdqipysLA>
 <xme:uB7FavmXK0bct35f3gl2R4We_lkR-dB-eBX-2qxtgIq5NO0PcMHf5hM_EobJxpIDh
 YNicrQ9-RP7UNmV4XNtrTIrnzt5jUfEth8uKpy6i1dwJuINTGKa1uPz>
X-ME-Received: <xmr:uB7FascdOu6fvypGQCa8d2R5QAJm-IDaaDKHcycetKXSMajMYmjBUUiu7Dcivt6pQchrVd_GyqY2Iv0IEAE4tB4>
X-ME-Proxy-Cause: dmFkZTGPQ9ikdxFZLhiv7wm/JL3Ag7EAw5d6HMCNDL3Eoji46Szz8fOMMnJD0u3luwEzLD
 DsB/a1vCCJOUky+O9CH/z8gU0WOJKP++xMqxhAkXagL40ljwvPaR5NcCbdLHYFhipZe31l
 EupK0r4fK++/u+7gsKOlB3M7t1pNYdrOWnIV/sSFY8dYUY+sUgjt8f9Lf5Ku812AI2AULL
 FaL7mubbgpdEZ5zMJMaeQcjEWZJzP9ua0+fEfKbl+POV8TBzqEFGdv2+bNBaKPu5vW3+i8
 fnbu8pWvlKjtcuTeRKW+6Zh+FJusXY532vmqOZF5KT9HU+jp8RUNCpB1XjJLsXC/d1+nRo
 xbsiZa7jN43AO8kEpq+HyBGGvjGyANHnoZLmoha4rzeuldoSk5ynSkEcEyTpn1PZCWkmPf
 MlVnSwjJqq6gWCwIy906l3Mm+z85IAEHO9fiyAnhvVH5C8GzEPNRQ1b3+RxsJRKQpqbSrc
 EVnPEH8NxvSjhfQkMSWQGK/atMPKm52Fspo4eLpwfvMUh9djs+rPOdIgxblRUzJZfXK3Y/
 17Xht0OWuwySfHZtQyEdQreP90j0/5G3IeoX1BsJ/k/ofH0SwatFprW3dRo9fDMRjbtSnH
 liYyCNuETa6dxzUeKhHDCqRYFYysiG8qgXoF4Kzsr1uL7731qeW6jBea8hsQ
X-ME-Proxy: <xmx:uB7FalpvxVwI07fUd_lgELz3lnoy9lRruuaI6nOhXCp8zuNSyjJcxQ>
 <xmx:uB7Faq5Nkcnsn9RXbc6qsoqpBAytfvoknB6IihsvhNZyXh9Qsn2T0A>
 <xmx:uB7Farrq2scRB-oAZW2sReZF7LcLpIvRx4RkVHPyqAYs7uS-y3SjsQ>
 <xmx:uB7FasiI8uCMWSViCgLQ3BnOR-4fwAw9xyYEbSwbC-MHp8JdD33D2Q>
 <xmx:uR7Fas-sXWFZjrWVtde5XUFlU_BHodinESqT3m6P-p6NMJ1psL-Oozs_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 12:15:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/5] eal: RTE_PTR_ADD and fix unaligned types
Date: Tue, 06 Oct 2026 18:15:50 +0200
Message-ID: <w9-bK2QiQn2t3WicJK8b3Q@monjalon.net>
In-Reply-To: <20260907183239.629053-1-stephen@networkplumber.org>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
 <20260907183239.629053-1-stephen@networkplumber.org>
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

> Scott Mitchell (1):
>   eal: RTE_PTR_ADD/SUB API improvements
> 
> Stephen Hemminger (4):
>   test: fix jhash 32 bit key type
>   eal: make unaligned really unaligned
>   net/mlx5: drop unnecessary STRICT_ALIGN
>   arm: remove no longer used RTE_ARCH_STRICT_ALIGN

Applied, thanks.



