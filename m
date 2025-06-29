Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C99FC7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 16:37:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B6E140288;
	Sun, 29 Jun 2025 18:37:38 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 995BE4025D
 for <dev@dpdk.org>; Sun, 29 Jun 2025 18:37:36 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B06E97A006C;
 Sun, 29 Jun 2025 12:37:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Sun, 29 Jun 2025 12:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751215055;
 x=1751301455; bh=ZzDafF88cjhajBYPWyI6c4wQ8+CEtwIJeLcA+B3E9Pc=; b=
 MQgnPIQ9Q0bHV4mlTY1UKhD6G8W/BVuAwdfMH850iR6bFIpptTiSLGaafkYkqVRl
 Ix44zTNAdKQ3jVzjRqDjhFCu+OyMzjNmlk4CY21wpuy+YPwPJXO34dH26NV0QEzy
 2Rq9WuyivHp4vJZ5fCjoAw1g+YrJS+MLtYOCP4i5G4ENCAIPJ2f3D1iQuBPz5Drq
 OhBoka8cZCXWE770aJ1fWpluXCGKj8+1mdYTuGdA0VViJOcfnxHy223Vphwmov6W
 OuXgP6tdMfP0DBJx1tyvKJ1bxbgyCHIYVkjiUDmfGqdfzLuaBdpKpwTb0mZQkun/
 wEJYNm84Kcs3BCL8yzMOhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751215055; x=
 1751301455; bh=ZzDafF88cjhajBYPWyI6c4wQ8+CEtwIJeLcA+B3E9Pc=; b=V
 RLsRevMSOKENlBWV1QC6OqUKbiXaKAbyZMHIF4SL/LjYqgT4wXUNgvx5dJwa0P4H
 hnWKl6DovRdqBQBomO6ClkJ2Tb8K2Y8uZKJFNTLIFnix2jhgNCjuxLpKKPvLHxs1
 jBzf6d43BrfU26MtsX55YVKOIUV6dt1YUIDrZwlS3agFrKNpxTVdlgaPvvDKDn69
 G9iSLdM/QPxutOqIQnW0q5tJ4Ucnwud4XpbvUi6c5gTOhVNoVhQhS42GUjUd3jc6
 HK0FXMc2t1+sZcC9oWnEUXVIwnVsz2JBct9SJzRyI23btrPKRs3VVwfWBkLBhydn
 M61KjoKMIzGEXhYeJ2foQ==
X-ME-Sender: <xms:zmthaOvuJD3hBgKtxJCDhNdIyRrG3_1XTp5a81wZtreS-DArgJYp8w>
 <xme:zmthaDf4-ole3sq2K3cx6FvkQgV-ZhF8kvBrAgnycMkqfYTIsJz9PPU9keYOemPzp
 2hpa3zWhMYAVOBd0w>
X-ME-Received: <xmr:zmthaJxx8bZu4mXjcc5T1r-51Cy0rBXyINe16LJAAomloBbKqUljCdxsYdyffbFlNibPys4MMikE0D02Jm9U7SCRQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelfedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluh
 hmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehfvghrrhhuhhdrhihighhithesrghmugdrtghomhdprhgtphhtthhopegrnhgurhgvfi
 drrhihsggthhgvnhhkohesohhkthgvthhlrggsshdrrhhu
X-ME-Proxy: <xmx:zmthaJPzkhnNN0zocpJfkVo5bpLBAELEvbgzmlrvgtlb894MUJXJug>
 <xmx:zmthaO-LLyzC6MsKXNxlD7UBYmdJHjt9Eu--bcEO3V7zKxojkqQ_DQ>
 <xmx:zmthaBXrMUtriIscjix0LNNbTvumtr9sSqqzocqPQB6x6fZhMu7giA>
 <xmx:zmthaHeHbz3_LLXRs6bXJcdc5Zb8nwkgJekJaMEgdD_ztrKmbHg9jA>
 <xmx:z2thaBRIYwh9A0mU8SQCzS4Xunw9XWtHh6F2l6P8xm2NdRExJJjj5Dle>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Jun 2025 12:37:33 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] ethdev: sync ethtool link modes with Linux 6.15
Date: Sun, 29 Jun 2025 18:37:31 +0200
Message-ID: <11997994.uMvqGB8zbg@thomas>
In-Reply-To: <3888072.ucjEoNaZvj@thomas>
References: <20250625134202.3193570-1-thomas@monjalon.net>
 <20250626072651.79d51099@hermes.local> <3888072.ucjEoNaZvj@thomas>
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

26/06/2025 17:13, Thomas Monjalon:
> 26/06/2025 16:26, Stephen Hemminger:
> > On Wed, 25 Jun 2025 15:42:02 +0200
> > Thomas Monjalon <thomas@monjalon.net> wrote:
> > 
> > > diff --git a/lib/ethdev/ethdev_linux_ethtool.c b/lib/ethdev/ethdev_linux_ethtool.c
> > > index ec42d3054a..f508cdba6c 100644
> > > --- a/lib/ethdev/ethdev_linux_ethtool.c
> > > +++ b/lib/ethdev/ethdev_linux_ethtool.c
> > > @@ -17,8 +17,9 @@
> > >   *
> > >   * The array below is built from bit definitions with this shell command:
> > >   *   sed -rn 's;.*(ETHTOOL_LINK_MODE_)([0-9]+)([0-9a-zA-Z_]*).*= *([0-9]*).*;'\
> > > - *           '[\4] = \2, /\* \1\2\3 *\/;p' /usr/include/linux/ethtool.h |
> > > - *   awk '/_Half_/{$3=$3+1","}1'
> > > + *           '[\4] \2 \1\2\3;p' /usr/include/linux/ethtool.h |
> > > + *   awk '/_Half_/{$2=$2+1}1' |
> > > + *   awk '{printf "\t%5s = %7s, /\* %s *\/\n", $1, $2, $3}'
> > >   */
> > 
> > The commands in the comment never worked verbatim.
> 
> It works on my machine.
> 
> > $  sed -rn 's;.*(ETHTOOL_LINK_MODE_)([0-9]+)([0-9a-zA-Z_]*).*= *([0-9]*).*;'\
> >            '[\4] \2 \1\2\3;p' /usr/include/linux/ethtool.h |
> >    awk '/_Half_/{$2=$2+1}1' |
> >    awk '{printf "\t%5s = %7s, /\* %s *\/\n", $1, $2, $3}'
> > 
> > > > > sed: -e expression #1, char 63: unterminated `s' command
> > awk: cmd. line:1: warning: escape sequence `\*' treated as plain `*'
> > awk: cmd. line:1: warning: escape sequence `\/' treated as plain `/'
> 
> The backslashes were added to help the syntax highlighting.
> But I can remove them.

Unfortunately we cannot remove the backslashes,
otherwise compilation of the comment is failing.


