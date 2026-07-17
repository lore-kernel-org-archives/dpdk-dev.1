Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19ECC44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:35:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3F2940E24;
	Fri, 17 Jul 2026 11:35:03 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id C5C6840E0B;
 Fri, 17 Jul 2026 11:35:01 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 596DAEC00D1;
 Fri, 17 Jul 2026 05:35:01 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
 by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 05:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784280901;
 x=1784367301; bh=U1956PIC7MsSLKrBzWkieSW4nLeyjEq7m/JWZcEyx1s=; b=
 ctq6HzpehlZ7QbFI3S9SLAgLYZhsZ3yaztTOeFGkzikJsj1jTVbZC68NcbKiem6k
 42mB/+JeoFviqFjute32plYT5sFqUqZYeZf2MV8SqrrewK+IE+q+DpqMYvTQ7cSH
 bpeFTkEixq4IICHSeEuLuHjbXMJi+Ac0xIK5GyWe5/YrN67AmkWNSX4pPrYonMwI
 Tr+no87so+8gSYeUeJ8FkBAfn/LL6QYLc/Z/flz0JTBlhZDnvyp9q584jzVShjIf
 WxUXUDTKhcjJgKOISTTcN5uzd761qW6rXbUzC50tLudwd2Y6fqjf0LNj+O87xsP5
 kcFLC0fIDCIWhbI+HZq/dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784280901; x=
 1784367301; bh=U1956PIC7MsSLKrBzWkieSW4nLeyjEq7m/JWZcEyx1s=; b=O
 QxKkzHcuDHTOUdId4m3rMwCjUgsGuLF1GNB2SjwJoWxeIBUAvNNGA4CyilVTuRfk
 u3ZZBHRphT2O0Qk1vncvCieM1ctdbLgGZN6XiNBmGH+AUExGcm9ysXop12jJHN9T
 Yb3HDHxxO5SUAd35gHPB5zthgVmU98lG05/JLQE3AjZfKGKnrepoAt9TLiS12R3R
 Coc2yPHPAliibLMwbdcyyS+UdbGiVJ5DBRpzxgPotljUMO3ELOO70VOI3SBfjOes
 A/IYnOcFeSMz6qWwplukLuhvgHZepwDYyQO3WawXEPTUe/eZL+a0UChIJsWtSlyF
 onP0DnUKJjuk8qMv6ahEg==
X-ME-Sender: <xms:RfdZauqAhbtgH_erVXGM8T_qdy-yEeeVRhnPhLKEUP0jW0laWiNrfg>
 <xme:RfdZanfz8Gh5z5oIMC7OhGnfTwk6uroKu7TKjakNSNwPJGEpNr-5woLrkSLp6p8Je
 4kPejMLKMmyk1ROZlnwbu4hapzNej7M7e-cAh48geV114qIwl7p>
X-ME-Proxy-Cause: dmFkZTE1pvhUIsKhviU29XNOebQI2BPgF8hR1nbaLCM6cRu1pWn6lgx5obRCYNT+j5lTde
 KrvYRo1WBEK+khFd/xu6r9E4cATfcAy0cHnfdXBXn9c8JGYzD1wzLV1ffPPvSXjeVxP+bv
 p3EiBsdtBOLC5wMUgTimUi4wet19hIjDTUdJyhcFVwFNDJSunuAvQabt8iJeFB+TdFR/89
 CeGbPTBW0OM6qeYtX3AxhKvRaAjGzKhNlQ3EXOjVzPA1DuNzDiTSAebI8KiOqDdLJ1Vszv
 IbpGusNadD4VNc7IOi4pXMw4JVXoxNo6VAq2q8QzmF4Y0tEZbLA9P0MKlqvk52nYv8Gvgj
 0+gPk5WVN3mg1FZOYTvnCWFJaLP3XvcIySwJA6+e0dehHaY09jpMrQduEfEO7YGg37DxYp
 M6x5nnYcSEXB/kPhTLG/brVdpy1In2AIXCU3FezzBcDOH6Hs0xjWW8ctUwNB5U7IlrGgsU
 Wcmc0O4WvM4/zF5o7/WQysNXXsAziyNFWPixjyVS0r9Xo18pv49L+r2ysGrYyGTyEw637D
 djssJWVfj+bbrGbOqqGKXVd4qO8eKhQY6gYXLCfAV7e2EinCCKnDoe93FiBNtI+rxfdWDV
 fe+eFlr+Sq8D8IhjJBZlTNl2T5emcrfeQ8D1Wqh2ozMpKrTJqbh5lxgEImPQ
X-ME-Proxy: <xmx:RfdZaj7gxKZYjOcsc2hUz5Qzs3xnY5dyDBhWnQei5Z6MCiWZ3WgBqQ>
 <xmx:RfdZapr96MZ9vdKLVIhN0iO_t2SLwhLEKo-wB8rjmJItOu5YM52DCw>
 <xmx:RfdZaml1NOp173R0N8WsbxHoEBdorQdAr8tQWTQkUzrkFk-yY3JzOA>
 <xmx:RfdZalPKpjIoMzpdu2YM1L3JY54_Z1UM4JOpy64vvu1NsQMDnC2a6Q>
 <xmx:RfdZaqnSQhMqrAQZZh3fJJ3iLHWbHHksyhVk3oLDpP10J5_Gfc-2LZCO>
Feedback-ID: i47234305:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 00D1D2400098; Fri, 17 Jul 2026 05:35:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Fri, 17 Jul 2026 11:34:40 +0200
From: "Thomas Monjalon" <thomas@monjalon.net>
To: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 dev@dpdk.org, "Jerin Jacob Kollanukkaran" <jerinj@marvell.com>
Cc: hofors@lysator.liu.se, "Luka Jankovic" <luka.jankovic@ericsson.com>,
 stable@dpdk.org
Message-Id: <9491ee40-aa15-42b4-9b99-e47f29df217c@app.fastmail.com>
In-Reply-To: <20241211141303.132448-1-mattias.ronnblom@ericsson.com>
References: <20241211141303.132448-1-mattias.ronnblom@ericsson.com>
Subject: Re: [PATCH] test/dispatcher: transfer impl_opaque field
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> The dispatcher tests failed to transfer the impl_opaque rte_event
> field between the dequeued and enqueued event, in violation with the
> Eventdev API contract.
>
> Fixes: ecca8a0be606 ("lib: introduce dispatcher library")
> Cc: stable@dpdk.org
>
> Signed-off-by: Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com>

Applied, thanks.

(better late than never)
