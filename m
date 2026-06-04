Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EA4CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 08:22:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEAED402B6;
	Thu,  4 Jun 2026 10:22:28 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id AAFD6402B6
 for <dev@dpdk.org>; Thu,  4 Jun 2026 10:22:27 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 213C41400070;
 Thu,  4 Jun 2026 04:22:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Thu, 04 Jun 2026 04:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780561347;
 x=1780647747; bh=Qomr1g9HnfyHD9ohhYG9oEDhf9y1g4CWoWOQq6KLJhA=; b=
 i+4w6uSdsw1KH0SvcWYTaI1gWR0x504SGiIGNU7FtYrf6x9qSFJyoZt2veI8dqzT
 /dQGCYtHDzY45DpaiZ/ukxCatWWR6M/Od6rtDDdvq0krxnWEXGVejD0qZwU79KRQ
 mgh5P4391XQ2s+vTQFKO8r0f1N4jkOUjmrRnCobHtLvuEytVJRejCIX68XezWktK
 Z2i+TOS63lpZgs//QEFUB4+xbEwyU+h+SnLxqzArM9uByT+I5J2WUOX1UUklhWRo
 KRt6sXkr6vh2BowMG/wQLpvFYMAwTMjf9j5eUddxvOw0OrwuucAuEAE7HDMmGLHB
 LQ+J50TZgPTaqYLJEizFiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780561347; x=
 1780647747; bh=Qomr1g9HnfyHD9ohhYG9oEDhf9y1g4CWoWOQq6KLJhA=; b=D
 IObFvd8aEtVOy5HZXMtxWf+ejanTjcJhrJrgVgCaOBd+zUkDuN435D8F6Nzc/yUh
 2KfGral95uDmg28xiwzlXaLiqOBjTBByoLPetPh0r+cExiUbdNk0fmHm54MkB5Uf
 lxBndjBR9M/UcBRvza71f28eU6dUXiKOAx+Hd2oMba91zzO+0Z4tpLBJyvIcMoSq
 Kw254sdHRiU5G0gpB4keS00SdTJAAHwkzC1QP+zEUn2LoUp5e/PVu1bueirKYIW8
 kx2WNJEUTL8zMXMGdHh8qkntGJ+2fyKMhrFm3nF/q4OVayMBLgkIRFVpoITpXVyo
 EIkU6BpPXpO20HHaHO//Q==
X-ME-Sender: <xms:wjUhaihgmHPrlTnBEckDyREr60-PGW7icalvzkGzaMMZcdJf0UVL_g>
 <xme:wjUhanXMvBCYuiYIDHgtYY832rxKWyZu9azQh3VIqPn31pOJvZF2A1NsoeCUDu77G
 bHxvEqUKsoTr0Pyyz8tkRNB5cUSpKBmQyx6ZxCuK2VNUs6tSKAM>
X-ME-Received: <xmr:wjUhapPehI25ND7cjk93tw5emYVPPB3aiBtCoObdRXJMWN2T59SACJmR5RTQFxRf9MfsXRD3tgRxOsKaZrmV-mCdMw>
X-ME-Proxy-Cause: dmFkZTF94VbOegBOaQmyOPFhGjFYddn63APTmhU/SiLPwWIA/tnr/LnHF9Zc7Fk/IajuyV
 N5qMXZPP3IhW0jmA6V3iAHNAJNsrHE0lCJmAEZyBRYOQnl585GFUEmDJgc2DsNZLtx66jF
 J1AoKV9gvYdQPFgd5voeUWUNS9u/4XJOR1HpYlrfm0dWF/vxr8fU4t0oq8ndfvI00T0Y/1
 MYF2yXTzcLnRtmdNNTr0uge39Gb3EhBoPJ258xxEJXFO873bcM3UdTd1bi4+6BlXmkU1qf
 cWtk/fZucvxRx0BEhKXRmDwq6Ioqzd8gTfcCbtEetFjehk2hUSXnQrJkwOebGabw1tQEsv
 wiH4+xc5IsQg1HDi71itOx/xCeBOIFh3fuuUU6K1mdNW9yPy2flpOYmowS2PE7xjPHKfFi
 uGiQBPcOlOjXj6XCBMjsxDP1n4e3tpKG85vUT4Kx5zMe7pidVEqrzbN+3LCMW1jCYwJYGx
 8jcxH0RbI0kPJaV/ZUI1hqZA72C4dcmJ9FGRxNTbTnfSByV91mMFPtUcFEfPJhYROswS5p
 rzcZC7rvYPU8KvXOAyIOI7KXKEdwZ+9wt1bjyJ+Eu9kO0HbaQsarumWz1BbG0NhQ2rrZUy
 AoLLfUlCs8jS5L629n1T6JrLbQIxfIhiffsVKk8cCGnMtpm26rT27hfeqeWA
X-ME-Proxy: <xmx:wjUhajbO4PzB3uws3gfPqWWp_BRwOwGaROXCkZ5iA5AlvfV_DjN9gw>
 <xmx:wjUhalpZQsf55kSuRFQ0qOBbObDUPRxbVbho4SMbu-j94t-p92RO3A>
 <xmx:wjUhavZqSce3mJoZZsg4drIEpFYRnvb3q7RXjpavaFy8uiDleBYDbA>
 <xmx:wjUhalQKhSkYJ64pHYETjIYwWohz8DNIbzgRjllGVP0Nm9wtr9XNsw>
 <xmx:wzUhanCTkd7xJDFUd4mDjrlOv7qrGrw3zAMRo8lfICHmr7sMwzeSv3Fl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 04:22:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 0/6] Make VA reservation limits configurable
Date: Thu, 04 Jun 2026 10:22:24 +0200
Message-ID: <dWdx4yAqSPCmK4B978Y2fw@monjalon.net>
In-Reply-To: <cover.1780071269.git.anatoly.burakov@intel.com>
References: <cover.1773225702.git.anatoly.burakov@intel.com>
 <cover.1780071269.git.anatoly.burakov@intel.com>
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

> Anatoly Burakov (6):
>   eal: reject non-numeric input in str to size
>   eal/memory: remove per-list segment and memory limits
>   eal/memory: allocate all VA space in one go
>   eal/memory: get rid of global VA space limits
>   eal/memory: store default segment limits in config
>   eal/memory: add page size VA limits EAL parameter

Thank you for the simplification and the new runtime option.

Applied with release notes added, thanks.


