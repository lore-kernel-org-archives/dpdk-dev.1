Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55560D35698
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 09:53:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AA1040274;
	Wed, 28 Jan 2026 10:53:47 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 5126B400D7;
 Wed, 28 Jan 2026 10:53:46 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id EFF7AEC0223;
 Wed, 28 Jan 2026 04:53:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 28 Jan 2026 04:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1769594025;
 x=1769680425; bh=y0AiyUyUWxd+oz+wl0mivS0ID+Dac4RgLBgKM4Mk8fA=; b=
 OOPasXhEoqAS8ow8DsIGBpPIXfQiKtCasGiO3M2rVcAABN4tF/d//K+A1HwM07ET
 +28z8w1/wF+j3jGQlgP1tWs3DtlxTydRgiATvi2NhElmjCPlcCGUYn56sqWg9qQu
 DRkcsyD4pZxwovgu2kXJ0GB2b3qGgIVAIvuRxumgxFH99bAn7APkRMmlnMUS3CTd
 wH02yT7Jw2NSwxjLu+Js2I3pmRFMlzVU3o3IpvfQPw/cf4151mnwQ5q6WeMLRvSx
 8ANGk0FG/xdWhP003L++FlMz5FGDkroThX/HKNIw3abci5rDZKUYwcchpwVUpi1K
 JUZZgaU9QVm7xnPMcd/cFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769594025; x=
 1769680425; bh=y0AiyUyUWxd+oz+wl0mivS0ID+Dac4RgLBgKM4Mk8fA=; b=u
 k+czGUKvetucgdwQhGTzamLsWLY7XQczYzPbDD96oDdNnbEL1sHifFyVKgWTskGA
 WCNnZTN9LNefWNx5F2txzthBj3ox3JSeHSZVSdpIB56tEThBgeoeWoa6LiLyFoAP
 sdaLfCr1D6SNS4Lj1Lrkf7IoCI35Aqf+lqSmYLFws35gW9PZiuB6rs3ZpvL+hWQR
 w5HqTAxQ6QRncbHjbt+XU8kL571gEFTRcoYiKWpHyWAx9kX+cT+ZYwA1UI4A1kaY
 aXXac9vPv3hxVLZK5160FXawErQZIfr30eYE2eExYNZPO30IsSf1fBPHb7qAF8iG
 OQkaX2gwzRQOUxKIQ0/vQ==
X-ME-Sender: <xms:qdx5aTx0o5l7On31DivG8hGjzoX7mUDJdM-MbTpPdrhqxB16QnlCsw>
 <xme:qdx5aWuz7MKub_gxATyErEbuHuMdLaxFi2RmXfCRJZijoFqGmms3WTMZdWle94tee
 wGbuOEGczAhCNZ-lZWBCHsoLbtCKo76lCM8C5ghHM_m5_-EeanRNcY>
X-ME-Received: <xmr:qdx5aQ2aiWDgoTu2KCowbMTUxVVjGTEHbKeqY2Ife_BXLqLyzZMf0BZ_VeP-ugW5opnHzj-JvtfZqzx_Feq_VQ064w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeftdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhpvghrvghtiiesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegu
 vghvseguphgukhdrohhrghdprhgtphhtthhopehrvghmhidrhhhorhhtohhnsehinhhtvg
 hlrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghr
 rdhorhhg
X-ME-Proxy: <xmx:qdx5aR8sJyA2y369RKbHEkKwBxo3uADBBebcaGpXh61MZQbeq5yWgg>
 <xmx:qdx5aRM2-BOW3lkpD8UDAkFpdC6eUAW4FCSgUY0lHzRM49UdTDAE9A>
 <xmx:qdx5aVdCaVpX-H6LZ0wNurm0JHi1VnF_aqvPDSjsWofapo4VFlaZ0A>
 <xmx:qdx5aQUmtd9dAs9IqWUBttkAumnj4RNrZ7unZD-xayIz-I-13fo4pw>
 <xmx:qdx5aVvL_VZE-9gTuhmTYSZLIIN2XKQ2mNgbleOa-bX2m37H8ofCYXdX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 04:53:44 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>
Cc: stable@dpdk.org, dev@dpdk.org, Remy Horton <remy.horton@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] examples/ethtool: fix buffer size for pkt pool name
Date: Wed, 28 Jan 2026 10:53:42 +0100
Message-ID: <2775255.q0ZmV6gNhb@thomas>
In-Reply-To: <20251222153114.24314d10@phoenix.local>
References: <20251203110157.51471-1-shperetz@nvidia.com>
 <20251222083858.1035980-1-shperetz@nvidia.com>
 <20251222153114.24314d10@phoenix.local>
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

23/12/2025 00:31, Stephen Hemminger:
> On Mon, 22 Dec 2025 10:38:58 +0200
> Shani Peretz <shperetz@nvidia.com> wrote:
> 
> > Use RTE_MEMPOOL_NAMESIZE for str_name buffer size instead of the
> > hardcoded value 16, which was insufficient as the format
> > string "pkt_pool%i" can produce up to 19 bytes (8 for "pkt_pool",
> > up to 10 for integer value, and 1 for null terminator).
> > 
> > Fixes: bda68ab9d1e7 ("examples/ethtool: add user-space ethtool sample application")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> 
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.



