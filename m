Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45F6CD98C7
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 22:36:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C87DF42E72;
	Thu, 11 Jun 2026 00:36:31 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 7D680402C9;
 Thu, 11 Jun 2026 00:36:30 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 08325EC012B;
 Wed, 10 Jun 2026 18:36:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 18:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781130990;
 x=1781217390; bh=jdJzNHwKPTelUcuRXS3uNGuqY6g8XVzEwFTJ+64jq+4=; b=
 BrwDt3f0FR02BnrdgaXhudKUbuW92NJLA7ZkptXrzGoJ11SUp30Niv0k6spcht3h
 XE5uu5GF7tMEHDg46G8W+ZRjRcXIAnAhN7+zVmYDaU8AYklGB7daf9tUoBkEVQwr
 2FaCFaq3aEAE5ixpJBoOBnUb0pXu+AdH9pxQFd6J7OokH1Y0V9Zh7k7gNZbdCxgf
 y5BnlDeD6odwO8sLACdhSID4E5EHkxngo8jbWHpH2Y4jTt8iCdwzyGpBZhP/2aaX
 jwUlnHt6gOXIs3Xri0hNgEelnGp2XTLJ34C1lggmvup8DR8nAlmU4PEIsex71aOD
 VZS+gl7z4VGfiNPiqr/c+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781130990; x=
 1781217390; bh=jdJzNHwKPTelUcuRXS3uNGuqY6g8XVzEwFTJ+64jq+4=; b=f
 MCoo5wZ5r2CMbXGUN7LB05e9GW58EzYFS/Iw9hwlY9UBYMtBbVNecSxtCBTO+FVI
 bMcGPJ7/eKGHMM5FSCqArpTZuiYawW9Ug3vj6KMZ6sIROIPeTgp1jvQGCEjHVgua
 MomCfAN4lcWqG/Ou9FRX7XjF3w0gAFc+0GFSlVhwRnqMFEhKTZUBsMcYK8RSSIbU
 M+AjyUx+5ovo74QJIy4V5H09aHbsZ1lZfUeqbWWgXfmU/8hniZceUKYDZIim/H3m
 rj/HZrlk9lUZz6jrHr90EZKevf6AZ5LJxt1EcMqQ9owpnLyd15rvjTY8MQAjPM/Y
 z1BNSP7Cb0T0w2kXHZNjQ==
X-ME-Sender: <xms:7eYpapVZ_xSqTJI2hZe6a0M1ZbZaZqS_HKCWul6RgwDWY2Q1YL4jvw>
 <xme:7eYpanhKynz7EzpsZqzrqC9UCtCyzF3Atm0MHXYLiHhO4UFBdwuIN0fXwA9OLajh8
 zZrZmLNXHY7WnpVL3hQYhR_IT_r5w5HpGba8Fqm_-6zptgjCpOyzg>
X-ME-Received: <xmr:7eYpanvGGo9FQ000vfCvL11k0EZ2sdDoGHM6tpYVcSeIYEOhlv9xh1AuaV8EmEAfnQvTRa7-FdG9OFskBBVJlWFL4g>
X-ME-Proxy-Cause: dmFkZTE6oB3x/SH/xz2WytF6VcpDyNbMcDboEvk3z5pA2HXL6ScqtNQXiDdVxyiv4FV1fc
 pwu1SPOAKQQCMr9gu9dSrcgfaTao2kZ9F8vnsxJKsFqDnRGLxQsBXSft7zxCKPge5iw050
 spobGruP8JJY3FCy4i5gnFtvjAXBy4mJzQUHHalJ6axz0zOrBz4v86rQGihhMKhRX+wfyo
 h5oVV4Ep3cpctv83I4aFoVOll8zrG/dkrpQoGPdvPJjUsl5Iub21HEhcVgoIIQMBTZsUi3
 PKYFfdaMwXQ+pVVuD+OqF04DGXGBlOWYtNeO2MCi+mTD9e4akXofaqx3kAsFoboAmBXvrf
 mhft0zFlyzwW1L1EPibAFKbKaHyNT5r1YujuA7zygQg59PX5Ao2x4EYsodAlZfN3pDNwdY
 kPVdKqvUrbHaN7gYnIMnk9ULKqVZrVCOAhOHCbax0HqHKKEYb9eSb413n37Fjy6WB8cE7p
 hnQWpaQsTdlIM+sEV0P7oVFXlnrjpvsTZ0XpjVm39MsKn6LkwVNq9Vh+m91l5FsIHVprIK
 AFXlMhKRMax6nI+EDjI1qLSzeQIRfCHw7fqjkY7RDsyPuAUut/jMUA+FVkmBifvOlxrqxQ
 IK403ZHDZ9g2FvPioLyGw9YrYku+oySPwlAQiAcR6uTSkjij/RVqzQs2ESgQ
X-ME-Proxy: <xmx:7eYpag5f4OjdV6eYczLoiVucEQ5ndTf9gd2MNMaTRsKuGoNqUJlqSw>
 <xmx:7eYparN8xGV8hosvnHmhA1Z67NuH-Ux0cLAa9bKNFNfd9GEs7SFB4w>
 <xmx:7eYpamu5K3LPAx5XYVJvr0U1km8Ku63zQyX50dRm68_Bx2SKQGe3gg>
 <xmx:7eYpamYzCC2qoUYqlwwLukThsvBSeKVBvvsc_sKwEzu83vun1Qr3Pg>
 <xmx:7uYpavJo6rI9lmus-K_4TDhVoD8d6ISrNCsp5cFW94IsRaTtdJslFDwq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 18:36:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Denis Sergeev <denserg.edu@gmail.com>
Cc: dev@dpdk.org, stable@dpdk.org, anatoly.burakov@intel.com,
 sivaprasad.tummala@amd.com, sdl.dpdk@linuxtesting.org
Subject: Re: [PATCH] power: fix off-by-one in uncore env bounds check
Date: Thu, 11 Jun 2026 00:36:27 +0200
Message-ID: <2LSIGtK3S4OJmAd08vzpEQ@monjalon.net>
In-Reply-To: <20260603042205.116191-1-denserg.edu@gmail.com>
References: <20260603042205.116191-1-denserg.edu@gmail.com>
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

03/06/2026 06:21, Denis Sergeev:
> The condition in rte_power_set_uncore_env() uses '<=' instead of '<'
> when comparing the env argument against the size of uncore_env_str[].
> Since RTE_DIM(uncore_env_str) equals 4 and valid indices are 0..3,
> a caller passing env=4 bypasses the guard and causes an out-of-bounds
> read of uncore_env_str[4] at two sites within the same block.
> 
> Fix by replacing '<=' with '<', consistent with the correct pattern
> already used in rte_power_uncore_init() in the same file.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: ac1edcb6621a ("power: refactor uncore power management API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>

Applied, thanks.


