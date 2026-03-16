Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B559F53D87
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 18:39:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 770614025E;
	Mon, 16 Mar 2026 19:39:42 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 2C554400D5;
 Mon, 16 Mar 2026 19:39:41 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 88F2A140025E;
 Mon, 16 Mar 2026 14:39:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 16 Mar 2026 14:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773686380;
 x=1773772780; bh=iBZWxlrt7kwUPEJVyrjNhDPMOnnDZVbP9nKJ1lGH2yE=; b=
 D4dnbVCCd9wVL3TGdBK1VmBDuHzEWyPzi6b0T72lqZ/2pXgg+cYjBnX4RabGoo20
 J3rF3qDhdMbrz5DwLgv76OyKyAJK2UM6gmTkNaTGumtN9X2LsJqo8boQFYtGixyq
 tnLmqC8kpjzQnBNcTH4GbuXA32VmGBWDzEBVX2moZAM40rg8/QgSJz0xTnIGEjJy
 LA2N7T0nf9yElmD7gBC3boqwGpDkGJrb2I+NErPWS9vcoiM0SfBrSl0U1r9EAWR1
 T+g0XROt8uBSNlpjC6wz++GV2BUE1rbHQMYVGnAyC2FSoOGRkzLR2AAjiUp9t7p+
 JBBurVancl3dRMSFO2lDYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773686380; x=
 1773772780; bh=iBZWxlrt7kwUPEJVyrjNhDPMOnnDZVbP9nKJ1lGH2yE=; b=V
 KtHfZjNAsLwXlEPD25HHSWN5aQ8hXWcb5aG3akqBgZjgOeaKruLPi90T4SwUaEUJ
 PMStkts8US7cLr67xgA1xa1Otaa4Vo2hhOuATPrdWYLcr4a21IJ1VcczGCAo0B6s
 MJWALU+jycyjMvpHSwLuBJ9BtA10RTwTh44gPF6M8GfC1PUkMzOMiCOJIcJok0tH
 7di9ek7zsDD2zbyM+/wmWTsM0c1w0y6Jqm1jrXhh2/Xhaf49iaz1rHqmptzrioxu
 ZQEogl/Fx5I8Gi9x/gi1B6OhtcVE7XPonrcJ1miwWn5iDWa2J26Yy5D873gcbRBW
 XErwhBz9/VYS9hrZhaGYA==
X-ME-Sender: <xms:bE64acC9pauLCgf7-DUUClHWAWFNz_GyCJXNDA4UdV8dTDG6jAYutQ>
 <xme:bE64aahIxEu0-s_tF9CEGxhyopdc8Qi9K0qnLA96h5JL59QqwWa_8aToSds2YzHEw
 NeyFiPTKebMJIvqTPidULMLgUMOY2aMInQiNM6Y7C4_bhfyL7eO5w>
X-ME-Received: <xmr:bE64aRwwfck8dFIPov4YXOvz6Zz7iGP1aYMKAr1TdOs2vNd8MCU8eJmP30ZvQ0NpMGvAXEtmAXmQNIad_tpGyff5TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleeluddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopehkthhrrgihnhhorhesrhgvughhrghtrdgt
 ohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtrggslh
 gvseguphgukhdrohhrghdprhgtphhtthhopehkihhshhhorhgvrdhprggumhgrnhgrsghh
 rgessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheprghjihhtrdhkhhgrphgrrhguvg
 essghrohgruggtohhmrdgtohhmpdhrtghpthhtohepshhhuhgrnhhglhhinhdrfigrnhhg
 segsrhhorggutghomhdrtghomhdprhgtphhtthhopehsrhhihhgrrhhshhgrrdgsrghsrg
 hvrghprghtnhgrsegsrhhorggutghomhdrtghomhdprhgtphhtthhopehpvghtvghrrdhs
 phhrvggruggsohhrohhughhhsegsrhhorggutghomhdrtghomh
X-ME-Proxy: <xmx:bE64aT2EChi2lZlELE_5FomkUYtsU2LA4EGV_Q4qqwNpljKoAMfUZA>
 <xmx:bE64ae_wogR_FboWtE-sX0qecVpYjSQ4_Ldd--GPX_gI5KygYjOk-g>
 <xmx:bE64aToFuMnCG63ff2qQqzH0rTP7aYqi95TY7czGlYchXffA5qbETg>
 <xmx:bE64aYSFBNeRyjOP03P3kBOhXQMz44C0RHyOSmycSABV0gXRl8v4kQ>
 <xmx:bE64aRO-LDNDWRmETRrvHC40WgvY4Z58BzRwarSMzc2RGV2D9dwbtpPB>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 14:39:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Kevin Traynor <ktraynor@redhat.com>, dev@dpdk.org, stable@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: Re: [PATCH 2/4] net/bnxt: fix uninitialized read
Date: Mon, 16 Mar 2026 19:39:36 +0100
Message-ID: <1921315.atdPhlSkOF@thomas>
In-Reply-To: <20260312095722.54ecf61d@phoenix.local>
References: <20260312103606.702617-1-ktraynor@redhat.com>
 <20260312103606.702617-3-ktraynor@redhat.com>
 <20260312095722.54ecf61d@phoenix.local>
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

12/03/2026 17:57, Stephen Hemminger:
> On Thu, 12 Mar 2026 10:36:04 +0000
> Kevin Traynor <ktraynor@redhat.com> wrote:
> 
> > batch_info->enabled is read in tfc_mpc_batch_start() before it is
> > initialized.
> > 
> > Initialize batch_info to avoid this.
> > 
> > Fixes: 67ad40007cd6 ("net/bnxt/tf_ulp: fix VFR cleanup and stats lockup")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> 
> This needs to go through next-net-brcm so will delegate it.

Please avoid breaking series, it makes tracking confusing.
The whole series can go in next-net.



