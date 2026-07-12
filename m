Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE229C43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Jul 2026 00:57:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9675402A7;
	Sun, 12 Jul 2026 02:57:00 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 54D844026F
 for <dev@dpdk.org>; Sun, 12 Jul 2026 02:56:59 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id CA6B0EC00AE;
 Sat, 11 Jul 2026 20:56:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sat, 11 Jul 2026 20:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783817818;
 x=1783904218; bh=u/KNdAIKkOQ1KiAshfR85uv6bU1IQ+v1YcxWIw0sdNY=; b=
 OmU6pU6Q/60y9uInnMU5cmMHUyIfYRLRP1A7g0jhcUwmNLqeAyCI4WsfsvlaUD62
 WpIUN8ikBnJoLfykOQuVUXngw8unZ6JJsNSulMtmT1P87I44yUDLZ2FpiVdefGvT
 8SdS7xEqzFqmPdddJeTympi+ER9c+u+FdB1yMnwCTLSdGh4J0hhplj8gMB2IX6kH
 yVpFp2mWWzV3Bhq2EMOI2Ejxg728jH5MdN5ePDwkxYijBqVbNsByy6RVGQaSREww
 t+p0AVG8J30sSx0kAGSPrLEMuj7H0eRhVivMjGbVyXPh/ByZf8IcU3CIfCv5bnAQ
 typ8pvILq6UWKxiz0JjOZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783817818; x=
 1783904218; bh=u/KNdAIKkOQ1KiAshfR85uv6bU1IQ+v1YcxWIw0sdNY=; b=a
 DFYeSRezg0g6eda9wmM6Z/P4CJqIWzwAePpkJtCCHHpKtTM/RaknLcNteMH2g1T/
 U+0Jl4N+gleaZrh/LnzWTfpcTNgDT7THB9GIkIS0NR55+kBWn6NZKUi2CUIh7mCK
 5fMm704VDrUBkaksv7CytHYA39wno2UnprZ71Jg1IIB4jwoHrXHvo9hbyOP/W8Ok
 5aMEpPv6Jz+byFrwLxMd2N6TTp+oz04/H6eCQAlQW9i4lUWSyocF89N/RrUeUoDZ
 ldZ+TAwq8lmm1r0lUq6uCq5rfEVPJ1TRVoSRxYEQCxJF1JCysqUejbNWgzweiMQM
 8Tb0xpgKYQS+WQhrjkqlg==
X-ME-Sender: <xms:WuZSaipgoS-E6rzfpDpLRDdfo-QBILPqADRjH8i1J7N3jSFuahYI-A>
 <xme:WuZSas-afhiPfDeC_HTwHk3NIcrCGCi_nVIjHavLrJEdNkFIjj5ghTg8l6b1HVkvX
 loGuDbPxTGunrB-Qmnwx4MV4GkkGfUzpNmNzThYU2iqh-S-qn6e_w>
X-ME-Received: <xmr:WuZSap_t0HRs0bwghc7zneha8vhvtrqK9ZK5moGsCwGoBtU3KhfVjzGBzzuspAlfLXmwZl6n2D-DEBpslrwN>
X-ME-Proxy-Cause: dmFkZTFGzDdjj53uacFsPI3CKhpxFLAXFMfVHl/TdKHXrqHOYY/PtDfTltVmBiXKSSyg54
 Bhkac1XRQtRQu+K9Wyy1BVGebtRP6HeUNI2paC+UDTvRk3cffKsIF+kxl00IY+AJ3uCd36
 l/RF2uQEwAgus3CfE2Nd8SDYE9Tp5j4luuvS/5SyqhzMs1mcYz6WZ+LxKgZNGm/KgESjqJ
 YNrwqMAnEJcg+/YjC7nrgUA3wb9nqUueNLPsIwSikNlCnwUv19Ur/mlQyhzMmmFj4NCSB6
 MJXdF1fyrJlCwqS6vPzuQ0fHBUg/rBGnRyYCkeUCg34Z+66VcJLerAPyy0AioWqUJVVEHm
 DxULfHTdxm4qHGK3m5iQTcVPDbus9cbtg3vdg9l1VMu8+n8ghB4JO8rulDqu+0Ri0kGs5Q
 WxYeJwSeEhjKLe+4B8p0dCIpVSs/mlMff8vQaYSwTw+QA7NLTyi1q00spNuWDPiaS0bcv8
 9uGL5/gf449sfeBATZV0uJI+4QDNH4Dl950Tgt1/zzZMIr4LHKB1zJM1RetQjqGHSToAb8
 57AThiMkVaXRaxTRzoLZd3LWh+CQrk/bLClcElsm/7v563ahImV3JR/LrDhtrWq/NkTrGJ
 iSDF/wxS6k7K1q0Y8t3CuJyMakzIh5Drs03j8/ehck+Ss5TVJ0HVaE8ssD8g
X-ME-Proxy: <xmx:WuZSajummTt8lNWQQGlTTojW8vxNZ8Ki3vKa4NUJHHgDL25NyTk9qg>
 <xmx:WuZSakq_cQisbe2KbKjI1RWwbZHf-VsjPXYUDk4VB0zL3OCxJNwQ7A>
 <xmx:WuZSaok3XXZk7uuZXJ5E_FJ1aZnfUWyX6sxc9tXA_pxkJlBXcGklOA>
 <xmx:WuZSagw5qA_9gPHz_ad5lyVdNrYBeepl7k3Csh2a-CIZ3MDgguCBPg>
 <xmx:WuZSagRiZu3Tk5G_xh2cEWtvKwOwAKOSwOys_MzDaDAvrccE8PqRpRiM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 20:56:57 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] usertools/dpdk-devbind: improve query performance on BSD
Date: Sun, 12 Jul 2026 02:56:55 +0200
Message-ID: <c7kT5GHNRLm-4ShQ5j061g@monjalon.net>
In-Reply-To: <20260629125929.2331943-1-bruce.richardson@intel.com>
References: <20260629125929.2331943-1-bruce.richardson@intel.com>
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

29/06/2026 14:59, Bruce Richardson:
> The time taken on FreeBSD to run the status command from dpdk-devbind
> was exceptionally long. When run on a real system with lots of
> devices, the original code took over 80 seconds in some cases to produce
> the output of "dpdk-devbind.py -s". (Time on BSD VMs is quicker as they
> tend not to have so many hardware devices, which is why this may not
> have been noticed before.)
> 
> Rework the processing to avoid doing so many subprocess calls to
> pciconf; use one call to get info on all devices rather than an
> individual call per-device. On the same HW as before, it now takes a
> fraction of a second, rather than >80 seconds.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



