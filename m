Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0F1CD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 16:20:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB3C8402AB;
	Tue,  2 Jun 2026 18:20:04 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id D5D09402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 18:20:02 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 05169EC01FE;
 Tue,  2 Jun 2026 12:20:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 12:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780417202;
 x=1780503602; bh=M8kqxoju9bdNuT5060kgJByPPlCm/Ia0sLYTdGtevEU=; b=
 A3ZF/1LM6kaUGrXqMOzzczQ+yViP7ejboD5EXqdtsnygKmDqggmXddHnbr0q4TQU
 aeIFbdh6y+SzJYVHNA9aH4Zq9wYIW9jAgbCPCV2cg55YtKMmV/7NjcnIqxuqR1/y
 p1qplocdSRxjFehm4HcnBVFrap4H+NAWBaGntq8PPS4fWMdlV8yKcZgMagcSCkhk
 dkXJ+QPJHClSD/NHDj38TxFGZi5j0gBH/mkwnc6vyuOKNDbiPSnb6kBV2oLETH+7
 8j6oZpGgHODhCCW9nYEOy2uUtUO3sxYfuhJ568bZB0ku436gDSn4IDSByYLfokv+
 OQzS68xZ5glYOcKU31UE3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780417202; x=
 1780503602; bh=M8kqxoju9bdNuT5060kgJByPPlCm/Ia0sLYTdGtevEU=; b=f
 GdGLdkLEB8dhd4mSyXAYgVzN21elOouvy1Q5yxweygipCiA9OkP20YWZZ5Kdkz59
 l8qYBt080oeM08saJuWabVMwwC7fwwGkopjWwqry5JIUNCsFm3/3QnrTPH2vLi2M
 pbCLj2ulB8IRG3gitn+Cvy2SSd2gbXtt670IG2+QddcpE5bx6mgbxfx4k38EhHnV
 1e9bSlH7uGYWSrIXD5DWOEMvi3lsLX6jRoJHyMN/ubt/YicU3v2cswklQ5vcK2VS
 9Hl51Iv3v/hmVV9Lb+w+9iC3TVWhbJZXoCYmPM5V3Y+lv7yJz3wV2wX24JoGJz06
 f1xZ7Dne5LCtR54rRSTwQ==
X-ME-Sender: <xms:sAIfagCJflS9MZcb7DQt3_GSF6cbSgnsic7lFkoEVf6I2tx2su8wLg>
 <xme:sAIfatdzJoR_HioLN8I2E85TgE8jU06uxQu2AvukkKCoSrCHYvdgQYYE-GvmilPC3
 aPHJK3k2lKEhgPdx95gEQJ4spWMiLqNufS9LbY8b_uaXZUB3UeqDr4>
X-ME-Received: <xmr:sAIfainzrhpn0WxivkCp-00RmMmBaqZai8y83FjhF3YRVW7Kxy5vTUDXhOZkgJn23RRd6TILFNBjuy9ttv-LCdVvLw>
X-ME-Proxy-Cause: dmFkZTFUjIeQf+swTnfvQmy6NSLNeHM6vabRNf2QBnyPyjS13+bpizx2xOPlYnIHebIkbW
 tYkfD7KZ3f2tSpKAFRsM5eJdKAq2vHW0F9KPkSOz6qC8wLCJCtd2YAx8sYxjadde3bUIAA
 LpFHIBi+vglK8u7m3Yo+wgpZzz1eBsLccrhBNdNZiOVIO/z6GGliVbBdvHyYYvPZFJjkUH
 oNePJlPLEqn0vxPgSEKsNj7M5V2dEzKMmMjvXz5UP2ob90jCvKFiqkAGNDojOONX20wZe+
 OBNh2f+3o1u3IB0sWfM+sdOBjnInPEiIPo58OgLopLsbqDG7L3K/be3iZ/o/YdAh/wThOE
 /Uuky5s5Pe4HRaIfimEsSVavc8cqBQx9yBwGh5ZePlpTJqe2j0BcJy6AibFjY4GajKcJl0
 mI8QsFzQyYsCtjDaEdzfeuteZR7mIeABVlekQVb4KE3WZy0pdAlSCMecNppFWP+W50WRYs
 eiyD706fACke5ktx9gYI4EnkPueFRs+C7u5SxE4U0aXUHTt1USoqs6Myi2GQdhSqSyPH3j
 UqTOOErr+9lJHtlNv5EM3O6Fr8zHP1YrJpVRrbW21o3dkwwzQ4+DDAZNEKV4uSOqV/lKJT
 6e3wHGi6nBJKF7ExF441aeFgZFMTesdu0NuIVGOtlg2SbEe9fYSr83ESAOSQ
X-ME-Proxy: <xmx:sAIfasFijkGoNFNq8wiDkVMpMKPUVjM2iWHPFKsmJTsqC_ikQODLig>
 <xmx:sAIfai5OiSkfw93_eFJ1I8P8mmIzzuWlEub0bmS_RSGtO_WZOTnoFg>
 <xmx:sAIfaskLy5ARlKZniSA6QohHfWfhPq4x589f05j8CLuTK1EIw6MHdg>
 <xmx:sAIfavpuC4YOT8qrG_7lTW4SdDnIXGE3lDqYB5eQ85u7UVnIj_vdwQ>
 <xmx:sgIfavclXDmA1qobLDbzsRagGoxXPaqW_PKG4O5f9w_y-k6zw8peX7vp>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 12:19:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org, Zijian <zijian.oerv@isrc.iscas.ac.cn>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?B?U3RhbmlzxYJhdw==?= Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v3] acl: add RISC-V vector extension implementation
Date: Tue, 02 Jun 2026 18:19:58 +0200
Message-ID: <1Vc04deCRtGsWU9Gd6fT9A@monjalon.net>
In-Reply-To: <20260201160957.1898027-1-sunyuechi@iscas.ac.cn>
References: <20260201160957.1898027-1-sunyuechi@iscas.ac.cn>
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

01/02/2026 17:09, Sun Yuechi:
> Implement ACL classify function for RISC-V architecture
> using RISC-V Vector Extension instruction set.
> 
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
> Signed-off-by: Zijian <zijian.oerv@isrc.iscas.ac.cn>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.



