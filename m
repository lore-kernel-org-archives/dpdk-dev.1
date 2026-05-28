Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0CFCD5BD5
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 18:09:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E9594021F;
	Thu, 28 May 2026 20:09:09 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 9FFE34003C
 for <dev@dpdk.org>; Thu, 28 May 2026 20:09:08 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 1945CEC01D0;
 Thu, 28 May 2026 14:09:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 28 May 2026 14:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779991748;
 x=1780078148; bh=tkDKuAbJj/OpaTomCW622tJpy0Met22DdxrLGCuAXBU=; b=
 Fz94+aFwvBWMzdzS8zI0INbmeSD2PUso7b7zg6XzzCSZCbiIG1IozDvRoIYCa/8s
 rThQBgZmiQHkmrGdLrnLQbRBFJMU0seGjH82uNBqMk3sm616sIjbiDOYrHRtBNiw
 3fiq9v9Cig/ahf0jqiDo2Fybe3IMw7Iy/corozq8R8s0Mkm1zsz++7Pz9fRCPyGu
 8MhqU+47fDlwRvka+T4n6VZT39oDoTPvajHJQRmPMkbNnPXgQxNU3/oB02LjRLT1
 vW8pK92UTqAZ5KFXEFlkpYITvaW8+JOwuNVKSM1+y9JM/dOwOU2NST0iig2zuJGO
 gfW0xWfYVlBWl7Q6JZogxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779991748; x=
 1780078148; bh=tkDKuAbJj/OpaTomCW622tJpy0Met22DdxrLGCuAXBU=; b=M
 okT3AG609doU6iHzf/UNeAb/79q0H16LejOBu0hR4y5M0wsa6Qg41bJS9Kh5Uxvl
 tAn21RadvUN7I0rCDF6JV7P2RxjwVU+Om72d2T762bS3PnUvvDciwKcqCkZTgBSP
 Oy0gUjCxEYvo+JZh7I7hmGbUd0ysUGijq5aifTQOJ2sAKBQZZw5Jvw+jZECgri9e
 ahx+C6Scp+JOzAWXUMdNgIWsCKJty8IRB9bu6Xv3N0BB4TwmiVM5MH6LtdVhFpw5
 M89bp6LE5pVxofx+nba70U8ia39b2iwXv9coE1AOe/Jwkw8Av/Jy+SxZ+E78Abs4
 b2g8fC1G+hjQrZ3ogKqaQ==
X-ME-Sender: <xms:w4QYajsAubsBtoILCxIAkYGB4_kKZEtkajHMPxL6UlW8yPabs9BgQw>
 <xme:w4QYagwICUZ4oYN2DWqXnnORSUY81ec5nDhXE0G108aDmvKRXU39yiT85pNqvwbxV
 _ny55m2YgKoKPfTA5aizQ4Q19i0zoSHpBaA0XG9GUT9Xf7ScMda>
X-ME-Received: <xmr:w4QYapg-ItE3vAJDdSXpQOaKcPxPLm7UcWI18AQ9xMfuAKyb7SmNjhNvyLxT0rMybQ-b5rEVpKAtpizavZ7SKYrYWQ>
X-ME-Proxy-Cause: dmFkZTGiOPV2v0rPV4fP/C8/B44sg4lwzPotZKG4gdbhU+clNTLdQUv/SIP8Z2b42VrNfN
 Y+qASdoh992XW1qT2WzQ8Hpt81Ip7JHxUZ0BIlTmACHmD0YPi1z88+NH37T6dFxOaQjYTM
 eteuCQb2wX3bmIOZrQbCSt6hZMTv2PNr9Pd77YNmUCq/pophWPijwjFRNNz2Q9fsbQEPAW
 w5p961ajOZHWrZYWeQwWDAX6sSWWXKOjxN9vOVnatApBdubpViwAKYrJ+Be61YTZsDasZO
 nlMIG1blpL8ltLGVgbxAzX9Kkm1/rp6d18aWymon1Yk9Qy3K1KMogPAa2YDIxGuJfygMF6
 62DFgO6WvLjn3HhcPAbQjf+APbUxhLZmTvHKIn5D++M80Ymb5C6g0QhvFFr54hdbYN64HR
 7dqiMnWYk+1Pw1ORCHkAlz21aACkgVaJ89XniQUfZoL1aunnkn0ahEex/CTeg5On34NUBb
 XKpJpzMQ6uC7F2d3XS/5cebz1I/1Jm4/BPKmR3dfPFQnJhdpVSpjWHpS5Dm+WAVYhwvkQq
 zxNqq42Dg7em1eX2xLBSVrLva0tzRmzJzjgm8LOY1Fx+F+dEMyLMU50XK3+2dIrXDtDbeq
 yK/o7CIKV93Rao5LYmnPXMF25PFZagLUaQ+qmrw4+PpvIslYLYL0WVkbSJpA
X-ME-Proxy: <xmx:w4QYakDWhCy65YIhxZbCeYwYh58QuQTf1QQmPk9h9635dm81dl5ZyA>
 <xmx:w4QYamuvVYQO0zTXlFlz0TAJ03eXsAFyrC_ENP0slf_i37HLoL_ICg>
 <xmx:w4QYapYblPyb-G41PNy_UvW4dP_DpBBR0q8pMAgzf12gWRNbJGGttg>
 <xmx:w4QYapUA5wcUkY72YN7d8waobD4wE06h5ZgUT-Iluax9HqLYnVAgjg>
 <xmx:xIQYapPEj80GjBspwEO5SLNWFhPG68XM3BbKwb9aavHJWJaQhC1Nz2jr>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 14:09:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v15 0/6] Add AI code review tools and AGENTS
Date: Thu, 28 May 2026 20:09:04 +0200
Message-ID: <73CXsChyTf-1C9EaTnoFLw@monjalon.net>
In-Reply-To: <20260521224550.927338-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260521224550.927338-1-stephen@networkplumber.org>
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

22/05/2026 00:44, Stephen Hemminger:
> Add guidelines and tooling for AI-assisted code review of DPDK
> patches.
> 
> AGENTS.md provides a two-tier review framework: correctness bugs
> (resource leaks, use-after-free, race conditions) are reported at
> >=50% confidence; style issues require >80% with false positive
> suppression. Mechanical checks handled by checkpatches.sh are
> excluded to avoid redundant findings.
> 
> The analyze-patch.py and review-doc.py scripts support multiple AI
> providers (Anthropic, OpenAI, xAI, Google) with mbox splitting,
> prompt caching, direct SMTP sending, and token usage tracking with
> optional cost estimation.
> 
> v15 - reflow AGENTS per doc guidelines
>     - reduce redundancy in AGENTS (i.e don't overlap other tools)
>     - move scripts to devtools/ai
>     - move common code from scripts to one file
>     - incorporate AI and human reviews

Applied with minor adjustments, thanks.

Note: as discussed together, I've renamed analyze-patch.py
to review-patch.py for consistency.

Let's see how the community use and improve this new tooling.


