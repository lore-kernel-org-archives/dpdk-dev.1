Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55455C44539
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 13:56:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A88240270;
	Wed, 22 Jul 2026 15:56:30 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 0FE964014F
 for <dev@dpdk.org>; Wed, 22 Jul 2026 15:56:29 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 471B91D00109;
 Wed, 22 Jul 2026 09:56:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 22 Jul 2026 09:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784728588;
 x=1784814988; bh=5TLq2VRiCOOa6vEUEMLzls5AVJN30YqYQP1gBfRUYqs=; b=
 RPbhJEvvJYF68lE9vAZOhB6EnvnuYtExLSLrKKlAEyx+9mcb0FUdW5e9+iNGhJqp
 k2K1vaX3sPuQSzB7yVAxRVfQpk1aA27bXrLQ5ipT3s9k+GyYU3aySPDtsA24oMQ+
 IdXReuQaSTWRYqtApWm0KsKW75oKy+gklEBNcJMto1C4N3SsIn0vYpMvDp5ZKrRp
 dh/8ZNfg1YWs1Q7jum2ZxWCj3AEBcDuKpqkVp7Ne6iJqco8S2HGA80r9VqTEzHjA
 J9lQtZJq2tTr9Dh6YzLOGqVrQ3W76Vop/LIVt1kpeNr5cZvbWstL4mOmZPViIpgC
 +JXCgtNxIAcCSiRqhhXzSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784728588; x=
 1784814988; bh=5TLq2VRiCOOa6vEUEMLzls5AVJN30YqYQP1gBfRUYqs=; b=B
 pXXWSD/KCpMwxg/2V0t8OF6lQeiwB+Ld7h9/tAWOyDJUNPjwfZluGPZx69HZz+Qt
 SF234mJx9PZWLqXoQIRd+tZQB5v3lEjMcqfwV66+LJC5SyMfn7vtrswtIJt32FsO
 dal1I+lgH30T9RKgl4EyoFNeA5mhRJW4Qk5A7VX+JzQzR5Dsyp7qWVW5sh2vOPFM
 t9xr+djyxJ2MBCmngn9abLKoeGceMpD0ad90i3ohvyK7qT+1awhxuQ4kpnwd0cqn
 7DJkW17sSjf7o2lvs9FK4bVkurg2Mj4NZPkK/AgZI0Y/ZKuB6302QAKctkJbdG+O
 SI7NTiPbyCwqjb2PY6HDA==
X-ME-Sender: <xms:C8xgavwTcKOP58UzVXUMdxL7IpNUkZoWfXAGKo1cvVNul_HNfYqExw>
 <xme:C8xganZrjkdYlD1hAZOF81ovFsCqFWxHxVx_wRgEOD9qCoKJqzjDiZnhftd8mQcXz
 LMCIeYIfKepCCazo_Pa9eNWg9hQJKLA4tbk3G8awdBaQZUrSWfivA>
X-ME-Received: <xmr:C8xgahTPyj4uwRn4DXm5O4lTgcwyN2-H0_UDEGKom5lB-QhZEJJqF2fwWkzTf2Fk0DWD7RjYd8PCCy2rZprl6LV__w>
X-ME-Proxy-Cause: dmFkZTGs9nEUTnq1xWWtpsKcnrVepTfYnjiyEG147sUclPUHrrU3yyB1aUHPYNzP7h8+7y
 2cXS2vjvGVAJ+DWkNH5hgYe6MboRDVF7yWoxc8RQyfjPO8BBNe7gcX26VXkVrYDOhDYsf8
 qAr5krWeKyK4HuFV2qUOPH10T1AEqE9Qj3cX+meLZHNVrY+E2ZWBN/pbWDP2ooPrgZCkQB
 G8TsrKR2XScJAWrrwUeYaiH8wRmph/axB2L4TSlSR/xwNHNEIooCAknN3jS45gm8m32Tq5
 i6LzOBwMp5hiowVu/zaKuilD0dFOLMBGJEc46pHOO5F+Bqjr5MjQ+QwMxnvj4UxIXeB4ar
 bHbweet9yo+g2HBWULsOabHZe6L+AvqsdYhvdoR+5qr2hgREz8RxZZDvqMhOMqxo7kNDqY
 0h/gxO38GRjK8wnUnhU8HnP4N5hY4ilvrxN7qtG0ejWK1l/4ERFb8HfeO0UuZodsIbBDOO
 FrkYTQ20FxfSu5jQ5FXX776GIFjjyz1j438WRm2nVYX0YaWJGZqQHszZPHbqpaqzB9ehfm
 21R6PqwuQi/ZaUtiJyG3K3dp5RY3kk3TMs9lGmj8ZZzyVKTMnFMxkZ5EgmLj38LtWF+V4a
 6YP0Viigu8xW3uHUjm7w93c/81Gd883OI1+qmoNQMpiZ0sRMxfpUHlWb4EJA
X-ME-Proxy: <xmx:C8xgahzkBJTbmctap9hLrcySpDXKwQxpA1uJaLZvOTU3q2-HhrRMKQ>
 <xmx:C8xgar1VwGpFRHAfcpUURwTpU97FP2fPgaTO9orAwQg1I2LvXs7Ghg>
 <xmx:C8xgan5dSAphxfLMvqB1ksEKOcSSahNV7eDdRlDKDfZl26G-PgYIlQ>
 <xmx:C8xgamU4OIatpEkLSy1hh47buuB6RV79CZvlvF1n5JeZ3xIvMCk4LQ>
 <xmx:DMxgalgEKkBfeoTsjQGVLOXy3FtHIXAp8B0qSOQh_2FicnymeLT8Sfmg>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 09:56:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Yu Jiang <yux.jiang@intel.com>
Cc: bruce.richardson@intel.com, john.mcnamara@intel.com, dev@dpdk.org
Subject: Re: [PATCH V1] doc: add tested Intel platforms with Intel NICs
Date: Wed, 22 Jul 2026 15:56:24 +0200
Message-ID: <NlJNqF_gTQK3xOsKggr90g@monjalon.net>
In-Reply-To: <20260716070830.134401-1-yux.jiang@intel.com>
References: <20260716070830.134401-1-yux.jiang@intel.com>
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

16/07/2026 09:08, Yu Jiang:
> Add tested Intel platforms with Intel NICs to v26.07 release note.
> 
> Signed-off-by: Yu Jiang <yux.jiang@intel.com>

Applied, thanks.



