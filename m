Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667D0CD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 14:26:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5E4140672;
	Wed, 10 Jun 2026 16:26:46 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id DE59040269;
 Wed, 10 Jun 2026 16:26:44 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5B42B14000E0;
 Wed, 10 Jun 2026 10:26:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Wed, 10 Jun 2026 10:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781101604;
 x=1781188004; bh=jTvFb8CDW+grEgwAixE8rhc1QP+iyLCjO+rTKkFwatg=; b=
 ZREM4QeJlc3gl+6qZ1F2D8mPV/3Tp6wyVmxPinXaezLYTND4kN3E2yPhJnxhfb0Z
 /PqOvXIiFapKtmd+L/DVi8z4DrIYmb6atfglA1S4QDB4sGl76pCKvzFlctsIeFiN
 NWL1ZoBn5AYDz4l3yKSnrbppNePg4zFZnB0RvR86+JZyvUedlF2gTdCDOrtbPtJg
 nsIEqTUoUYLi71BJZR5+Zo+rCSnPEZCyvL1ESIYKSbwSHiI5fV0EAEO4Htu9oSIL
 g8Sr7vlcMIfVmBtFi5F/lY5dSaihZBNSUex7tXLAPkNw/wEkclBeCzYL6pSwd2Di
 s34IcNC/hIHwNwyDJkzd2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781101604; x=
 1781188004; bh=jTvFb8CDW+grEgwAixE8rhc1QP+iyLCjO+rTKkFwatg=; b=L
 WfNeNXTap1f/omdo9bzzba6rIgsj87n6TS5WzrRLg9uwJFyXduaKZbozqaQcQm88
 jj60xBjypBbbJzDqNH50CX/7bqe7WMC3vtTID4h3GbIgXh+AzvGhXyOsAfRsdB9y
 Tn2CJNQGZBT6cJNAiqGt+WPvwiLt1XwjgZn3RMYUOSwvIwQiRomfeql0hAKXcZnP
 6eextcFk4iBp5TjCDd//CGasxRi+gcvf69YcQBQlL5Ukjx2ZVILrxV/02e3fqdzd
 zVHI60nKiVXTUaIOZgw7O5dVHEGyjgofThKDFMVsrNXCHQemwUVEn++lcUZYqPId
 pSI06rQgMVmEQXGb+39NQ==
X-ME-Sender: <xms:JHQpanmm8hz6bLfbmoyAZsMpYBosKedrnqQVx03zGY2qdZg1J7ef9w>
 <xme:JHQpavKCBViSBZDtwW-2WJXwmxVg4Hl0Ac3971glyUXRi8p5M35RpnqBI7YflCw18
 S5Kv2bpoRUmIXsp-NKTB7NWRT20bfigQCt_HgwNz_Xhzq8FjJ-2>
X-ME-Received: <xmr:JHQpaszfqtwSAkyVR4Li4zsi81mlJlKJHStyLVEkwfy-0nCWRbWlw6_3CTgkBWx4PZ-dg2xp7s1ivRhHtxYMEXw4cA>
X-ME-Proxy-Cause: dmFkZTFGIvGZ2oxvFBUS8t0qBSz5ijWKfwlYfp2Mji4v2W5Vj38Z0DP7rhns6jHCTwyUo5
 ScvTMr3U5GtnXy+oKTpWz0F7yJI8Ce+rT4giO18D3PG8nSnL/wdbjqZYJSYiUoD+Z3Sh3j
 euSeF/VMKvci2HLZMK/LJB2/L8p47ps7Sw7dAPcaTiSy7zOTzu5i8fLDJDBqZvuKOEVR+p
 m0kN6TaRL5SbTd+gzxWTxo8yMI93lYieMc1QxthhgqdR9GnVft9Z7kfOEGmxBiq6gwSbaU
 cM4RV7d0M5kloVn5ZsPhUPxJcueAL0RsZHRpy7LdLkTawRMy7SPoK6t+4lCuZ/kzWFzIQD
 IfDq0NuDWBONWoKLXVXaOWDjq9KGmsxRW49ZYOzZfUE9zTFkx0r2wKuYPNm7xCdG55erfI
 /LDtaRz35eA0pXnn5GcjoDRPJ2ybvEj0/vho9KzV82XxSpoZmPMM0ygK3Rn2/UHwOGrt+T
 7ijzKOLy99ocTYZTPjmZJ5wqF4c7DgImhlxfACTSmX//gLFNWxJ+zWctSMopsyxefkzXLB
 w4VdNp+Iq+CwOEILW6eOF8hAklePoxBX+P87M2zU4N/o0AT4ZsFsFD3XUc+S8s50G3i2s0
 Zup/gd02XWtRRTeBP4nMHV9dbVu6XiN9u6Uew6othwiAQ84+GBEF9U/ezCCA
X-ME-Proxy: <xmx:JHQpanuJtGN6aZYgIOtWf5fHzZd9lQGYHfpbFqygiwZOhoYSjUyM_w>
 <xmx:JHQparsTRUM8MPsjOh06FSFTdcywBZz0cAQkRz0O9-n2MbK_jZY--Q>
 <xmx:JHQpakPsUfddmUhe3NsTlVrcp00Si53nEo3s4CeDxS70Q20eNJZfVQ>
 <xmx:JHQpah1GSzoYkUb_qhQZC5iJ0_QWXHknw-KBp90acqAZK9ZI12sbaA>
 <xmx:JHQpapUV57lIGOrZc-OmhbR5M-KOGGzvzikG6e49aJ0qYFZIYv3ztaG6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:26:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] fib6: fix error code propagation on next hop update
Date: Wed, 10 Jun 2026 16:26:42 +0200
Message-ID: <zMvDYXUtRzaLaq21742X0A@monjalon.net>
In-Reply-To: <20260605164757.927661-1-vladimir.medvedkin@intel.com>
References: <20260605164757.927661-1-vladimir.medvedkin@intel.com>
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

05/06/2026 18:47, Vladimir Medvedkin:
> When updating the next hop of an existing prefix, trie_modify() ignored
> the return value of modify_dp() and always returned 0.  An out-of-range
> next hop is rejected by modify_dp() with -EINVAL but was reported to
> the caller as success. Return the actual result.
> 
> Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
> Cc: stable@dpdk.org
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Applied, thanks.


