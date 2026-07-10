Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CC9C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 11:29:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0BC940611;
	Fri, 10 Jul 2026 13:29:21 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 33353400D5;
 Fri, 10 Jul 2026 13:29:20 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 99AE6EC009D;
 Fri, 10 Jul 2026 07:29:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Fri, 10 Jul 2026 07:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783682959;
 x=1783769359; bh=H6jf6kuBx0wJgvqnJiMEq/HzykNHnqFZTz5UXCfZme8=; b=
 Ej+3UoShuaByM6a+ROLZeadFpTT80WHLo3Ak0QHaGH103rRC53FBng5n2Zxf+UhF
 glixBp+2Sxd0Yl/N6Wqa27DPft7S9/4R8sTK/iZ89HoVV2gFfnU/Rqs0GLFqhkWA
 Eru3un5tiekbEa23dOXW800i24GTyD0ctZnpDWTy4+oCNR/XsL8Bb6Te2Nca+4fI
 o25NofWNLAapRicueEBRtR6ZCo/eGP0F7KatoUY6gp+ZnBq9vc/Rwqizpi2zmn7Y
 EpTqm7/C2gf4IGX/mT3CZ8kF8f4m/HNz09a1oeNk/17HM5gH9DVcqQvcaMWtbZfG
 nso+Bt113KBmnI2b/ZznBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783682959; x=
 1783769359; bh=H6jf6kuBx0wJgvqnJiMEq/HzykNHnqFZTz5UXCfZme8=; b=Q
 sV5LFfsAh4fNmt1m0uFXlZeSKVt6vDSShx5Q4hRDaZ/SMGdlngUq5C2QG8dV++kv
 xSz5PKae3Douqo/oH4S/rmko233Pj8XJWbrGhr4PEXerd+L3MDLGeie5Lz6ZDWUk
 uvWKh51I+PSDsx7Hy/Yr0sqI9h7f4KTdVDihLjcQDW0GGxM49WeS7Jh9R0XoWPz+
 XrM8QwPjDOv834F/AK2yR4cfsdEBrh3DmU7Zh2lu/0Q04eLUC3u8HZBvSgKHjIa8
 VX6zguldhJSbwDHhePGWyAPzswpU9dN0qjLC9xk5d0+2Oy797YtPEcVnF/5iVIdz
 EHKXP7M2+bCJVYM9YOX2g==
X-ME-Sender: <xms:jtdQaprBAOyzSdqIjVMnIY6S25HspZvgEFAE4ZAlAXTPiN6DIw8K7w>
 <xme:jtdQakkkNzQByr3JcF-G6H8Bj8w-8bk0z468rLkYc0383YwgSTCNLLqszCGgh1nVL
 mbv-B_5k8LSEFZSElqx_TEZf4OiRfu3wXzeUORuEH7JzmjsX4huug>
X-ME-Received: <xmr:jtdQahxRmd3LBJar1XSua6AC0GfJQg4akLgsSwKxMUNjiLastXK0WeBn1L7Wc5eHMnN3m5vS7MgFp_u_mCG8zD3WCQ>
X-ME-Proxy-Cause: dmFkZTEST5LD0ULtw/13XtMA8zk4O18vK7wnqSXHW8+xPsBGP1J3mYuD7jjyPoXeO7iWex
 fWtI1tkLdSOyvEwO9FCiYcbFE96lEP4Sp26FxSTddxcYT09pieiRKyP/a6/iDuByJew322
 xPGugS0deDo8/xY7IwifhcVtfuZrLmAtfRZdMzuybHhXmnhCM5vODdxHwYFhlXA63RuXeB
 9MGPwQi5Fwj+bb4FHbys+QkxstPTwGuJyOBJegZr/R/wZ1QXkfbBpzwsPy4qGkxWZL4Vkb
 VkTH7jjfcK97NajBt3K374vXBhJ2qt5OYxDVe4LpX1N1nGXTSSFubLa06LdDpie5aDnEWy
 Jwre46FR6LBmHg+X9yqF1xUdp8JOySWk95bCLQzUN46meeYvQwySHaupAb11AcJ8s7jiYj
 IRfMf0ksV2Z4n9yBgeVyw03u2EC7885N9p0LbzSNQvC9X/KAE9ZNa1Qtgf/405AvxEKT0d
 XSIyLRrDe2sPoxPoUR+uxjeCWd6rYfzLBB3a4i6cM6kg5uwshnVoELFsJfaJoRfWinR8Yc
 wl9cJwNYV4qrkKF/YtSue54IIdg2X3TdIQiCZKsok57ygpsdBtsQBDHnrdF/xQPjlNkBfB
 Am4Iwgq+k2xB/IWFKbD5gdBCFG8hS+he+8S1oHmGruvXVNck+xxysmvsCjNQ
X-ME-Proxy: <xmx:jtdQak_yZx4O6hSuoIJzu4-tRNWtKVla7rWqbRoaiNMvEHrk9hXxIw>
 <xmx:jtdQalKAjIGPIJrLBbA9mvxw2B8S2tXw0vK07gPJG2p2smh6gJ0TJw>
 <xmx:jtdQaqe-oa99Fsd1peJkg50O1f1Fs_mqn0UTPGww-8bq1wkkvQ95JA>
 <xmx:jtdQak8GkhOutyXBlVoZi7HD2XAsDGUjcreh5cPlbCGAtL6UynMSnQ>
 <xmx:j9dQakc4D2YiXEKn3Awpc1mSq3nLLaIIKtrpe6BhLrCnNcsc62V0H7WS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 07:29:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Alexey Simakov <bigalex934@gmail.com>
Cc: "John Daley (johndale)" <johndale@cisco.com>,
 "Nelson Escobar (neescoba)" <neescoba@cisco.com>, dev@dpdk.org,
 "stable@dpdk.org" <stable@dpdk.org>,
 "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
Subject: Re: [PATCH] net/enic: fix potential null dereference in flow mask
 check
Date: Fri, 10 Jul 2026 13:29:16 +0200
Message-ID: <Cxh0C6GpTsWgHsDiHRgwXg@monjalon.net>
In-Reply-To: <IA3PR11MB8987402CDECFACC6831119E7BFFE2@IA3PR11MB8987.namprd11.prod.outlook.com>
References: <20260707085831.40355-1-bigalex934@gmail.com>
 <IA3PR11MB8987402CDECFACC6831119E7BFFE2@IA3PR11MB8987.namprd11.prod.outlook.com>
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

> > The functions enic_copy_item_ipv4_v1(), enic_copy_item_udp_v1(), and
> > enic_copy_item_tcp_v1() each initialize a local 'mask' variable from
> > item->mask and substitute it with a hardcoded mask if NULL. However,
> > the subsequent mask_exact_match() call uses item->mask directly
> > instead of the local 'mask' variable, which will dereference NULL
> > when item->mask is NULL.
> > 
> > Use the local 'mask' variable (which has been validated and possibly
> > substituted) instead of item->mask.
> > 
> > Fixes: aa3d2ff82198 ("net/enic: flow API for Legacy NICs")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> > ---
> The enic patch looks like a valid fix.
> Acked-by: Hyong Youb Kim <hyonkim@cisco.com>

Applied, thanks.


