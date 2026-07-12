Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01575C43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Jul 2026 19:33:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEAF0402A7;
	Sun, 12 Jul 2026 21:33:19 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 3A9C24013F
 for <dev@dpdk.org>; Sun, 12 Jul 2026 21:33:18 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 9BD63EC00F2;
 Sun, 12 Jul 2026 15:33:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sun, 12 Jul 2026 15:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783884797;
 x=1783971197; bh=bel6/iSBw+/j5R8jvJ+htF1Tho2wpNBSdsWUe1HymCk=; b=
 Uh88nugJX2cmX8PIk6lR0tUWF21S4bB78V1Oo+EyRQpFf1PtXsW5f56sjAiyqqfU
 jPFVlY3yBkMMfiKwgw9UaE8sl3jduDvpmHYWZix9LB9UYpFAMlglLJgl7fzrOMf6
 938xdOF0oC9mBO2sFjNjt8Qynob83AMCc3aSG92Ql+8aztVypsAjp9EvMZdiNre8
 a1R8K/0J8P+aC9tmQgb/Ji4+7cQSldNVWVhV16zp496XbNcel0CptdM/O4PZ1gZ0
 7gdivV5N5WLYpAchLJYXM5UiziZSkqpe5vYepie77U4uZtl9lIePPmxZLbym+z1P
 Z6yGEHiFTall8jHgr7ghdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783884797; x=
 1783971197; bh=bel6/iSBw+/j5R8jvJ+htF1Tho2wpNBSdsWUe1HymCk=; b=W
 MEhTgnxttDRvzxf6mIxOw3ZJQbHmbQ6jpHh1czoA2fOmczJteCcKLa39LUJvARxU
 XhWr54eXElF9oj9nZ3mB+Kq5bygtX6vdbB43D/ldo4bRoXPbnzDi5zSheVEwGy4U
 klYazcB7FkhAHqfa8HcNKYXX/U6P45I/ntMXy/OaTX4eOmBp38rLuWVAcD9PM9he
 DD9ctxATUl+4LDpcCYvbE5/iTe2/gj9rhMeKM9PJpvn91YIkn6cwEv9/3ebia92H
 DGeET0alUdPHEoANL3dEnaLrQHLwkn7dVRR69z+jBxiOh12Hd9E1rOssaQfftRbj
 I3Qc61ShPDAcN+MkwVJdA==
X-ME-Sender: <xms:_etTasHnpsL8rREeYRN5ZmgwfXemtcXIC6mEZJNa7wUI2u-KdbK8dA>
 <xme:_etTahoA35om3fG2voekN6ena0HqFzv-Nv9WmmI_BZ2Qqr37nqDktUQl4o417SxX5
 W2Rls0nf4BnvLuCqYUCBwXDuXNooDM1lTFPbkgfTB4v8GZ5GRtgJg>
X-ME-Received: <xmr:_etTao5wAf62m7erwGVAEivbCKgGMkoOfStcVasr3ewREi0QEmKAcucOMLIPLVdZwN713xB3hJdsJkoQbKXO5MY>
X-ME-Proxy-Cause: dmFkZTEBV4x4lE46gOGZiorxPrKFDakje4T1ZKOw654TxXDx1LQYd26S2xMZKqXzh4sBTb
 f1WtkPSdn/VaEYPgDFkt2aYQMHYAP9CaBXtgfnCjNhSyQMkq5p9YgX+Sv2GCX8TfAs6u33
 4vxnpFmSOG93BgTuOO2PzK8I3BnCs7AodLAU+fC9wHNV2Rek/xVps6zyON5y5SPVUQY8ct
 xheIcGFn6AG4njtBzeQlU1Nrw7B3qZBWuRWpS+Vhts9KUnVu6QBRtsdOpuVM0jTuXOdGTf
 uGMaH2I6RL5vqrL6Ip/wHkpBVfF6s0iPAzpMQqmK8sFa5p4lnn8ltqHNmcQBYmX4LBYPqa
 CrrXmHGdv2Z28dvBjh13yr+yX/ZGjExuCfkT3y/AsKnubNYDtehgrziQKAby5UD/eE8Syt
 obCB3OlIIR3764U3CxYonOXRZpKU+vvsfULQDY6sEHDZjXBWNrcw12W0BJvaHJ1C3tXZzn
 wf2Pk9iC1aoh7yLX3Hl2LKCnQhemohgrVmT3vh6ev0QdMbHp1saMH4DjXNGIHQhCNFgVen
 r2nAmMiZcncGCYNQLvilIVZWL4Y7Gi0yTdptMbE0o02/Mhl8vo4i3hlzzaOBW9icdSVUac
 RHJPyLLXmQb8RPi4QS2j+KzzpI1EGTMdhwyAdy69wfcYraDYW5e657Xa46/A
X-ME-Proxy: <xmx:_etTav4fODHNh3qBHuOjUpcgNY8En7qmNoBhMZRdm9AdgkIiygzzCQ>
 <xmx:_etTalHJFFh95bgaIGOAe5D-Ryz-3RJT5oQIZkY70ANDc57hfKdToQ>
 <xmx:_etTaoTGPiqGKekqirC8uH2gPc4538O1E4eVqvn-U3OKhB9ElwnG0g>
 <xmx:_etTauubi8Yh9HyKQPbdOj8cn6aeRjWcqi-Gkn_dmL-eLBtxIZZ7ag>
 <xmx:_etTaslr45CSdJEnK6zQUHdZtlY-8pww9o36kBK3xv57BD5xeYNHQE-I>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 15:33:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] doc, eal, devtools: discourage new __rte_always_inline
Date: Sun, 12 Jul 2026 21:33:12 +0200
Message-ID: <jyFKiKFaQcG1LcuH6c3k2A@monjalon.net>
In-Reply-To: <20260601172104.311909-1-stephen@networkplumber.org>
References: <20260527163734.599602-1-stephen@networkplumber.org>
 <20260601172104.311909-1-stephen@networkplumber.org>
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

01/06/2026 19:21, Stephen Hemminger:
> Modern compilers at -O2 make good inlining decisions for small
> static inline functions; forced inlining via __rte_always_inline
> should be reserved for cases where it is required for correctness
> or for documented measured performance reasons.
>=20
> Document the policy in the coding style guide and add a
> checkpatches.sh entry that flags when new uses of the attribute
> are introduced. Checkpatches is not an absolute blocker to
> acceptance, only an indicator that more review is needed.
>=20
> Add additional comments about use of __rte_always_inline,
> __rte_noinline, __rte_hot, and __rte_cold to the rte_common.h
> to aid developers.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.


