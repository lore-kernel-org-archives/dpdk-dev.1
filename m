Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A8FD1038B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 08:30:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BD4640DCB;
	Wed, 26 Nov 2025 09:30:02 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 518BC406BB
 for <dev@dpdk.org>; Wed, 26 Nov 2025 09:30:01 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 60D1E7A0194;
 Wed, 26 Nov 2025 03:30:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Wed, 26 Nov 2025 03:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1764145800;
 x=1764232200; bh=/eFh7g4UPZLqznFyWOThCrkQLvcN0zgGZaI/VAs+k+c=; b=
 r+zik5IWwEd+tWXJoY6svUVUXG6mZdJjDILDqrvAfbmE5VdXeuZobjsgaCyy+tBG
 Ho5lwANcgR92VJPhlvkKip4WEBUV78xQoFTE2I75xpmGSkt/uIQZrsWufMKzIvJy
 pNjFKyp3Lgwpf/tVgyobTcglrOY1Lum5aasz8aPJBjoChpqBQ9WS0/sLBBUB6JqH
 32V61iCGZy/ASzSQvaWbW5TcODQqGxqpROIjumHtoXR/4KQK9W0UyKj0gokoNPyR
 K2lJidfnVpYIXRrYabFw57ZhNQ9zDYjjCIe3bE6FSQQgbj7vB2pheIzBXwZmNpWD
 0N0ZITWs/qv17/YHxqtOQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764145800; x=
 1764232200; bh=/eFh7g4UPZLqznFyWOThCrkQLvcN0zgGZaI/VAs+k+c=; b=H
 v7mFahVsic2aZWMCGm0WMBv1mi/OZuaxSJVwuBMJ8VTG5KJdduLHWjvyP3XsiDZ6
 Vsdtvt+uzq6N7M38/MIj6ymqUZR1IKV+wMp9lid6jCSzWzg4IzE9JYEmxYN16h1y
 iAa+ILEHwBblBdXfCJAaBd7dR2eKtPllwh9GXbIKj+uzxjnCKsDhCKGuTIzWv+eD
 uWBoTFJHhGWusg4O8MdH2po1BIShUZrU8SDPUDjvzhEt+ostR/S5QijRxVPQbSpA
 z2BwYoia05fm67RlDBv7NftECDJU4SDvtRIri/G2OOX6KKwhx5jKR6W05ED1jXw0
 dxrV/HCWKcMRMnsCFm3Zg==
X-ME-Sender: <xms:h7omaUeAIxMTnLf7TXSbMbeFj6cdulUvsWGm-1w0F3VgKU4y_FxasQ>
 <xme:h7omaWXpYukG8KAIBN3uygrOInqJXHqnwV2FLyyfodggVi0Jj7JQTLOmCMT2MKJ0m
 qET0-KzbNZnjJaOCpCA_Nge7O71oPQ83uQF2Kc1cOMDzcKkezTVtFE>
X-ME-Received: <xmr:h7omadcnvWm8wAykl8Jn_VZm21x5ND4RFUFb3kRy1ClzzY3wKZfsRvX1mXYLuiJzTgX9u1iFxOCf9bcjfiV00_YwXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeefkeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopehjihgrfigvnhifuhesthhruhhsthhnvght
 ihgtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepii
 grihihuhifrghnghesthhruhhsthhnvghtihgtrdgtohhm
X-ME-Proxy: <xmx:h7omaSPht4Y21gwoGU34Gd1btstMfrx0xFOA2v_cnfp0tNMIJRJsrg>
 <xmx:h7omabhbvuTRFhuXetJGJQPLQtAoRqh2hI--ktLVgRhDJwAwHZATHQ>
 <xmx:h7omaV1rNGLB48uT_oAuo-VqkmrInub2NEY5dSHW2xv21oXHU0vKUA>
 <xmx:h7omaVh6xDWzGEmO_SGMvlpKeYj4Az5nSa-5TENvtw-A7XtpG4VUdQ>
 <xmx:iLomaa1Rn9ZqNJtzA5NBObqfVsrqs7PwGK1agBfHRE75ZigCY7fW0shu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 03:29:58 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: 'Stephen Hemminger' <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, zaiyuwang@trustnetic.com
Subject: Re: [PATCH] net/txgbe: fix the missing old mailbox interface calls
Date: Wed, 26 Nov 2025 09:29:56 +0100
Message-ID: <8941560.lvqk35OSZv@thomas>
In-Reply-To: <011a01dc5e9d$cf400cf0$6dc026d0$@trustnetic.com>
References: <A4E8D8476CBBC191+20251119085624.73210-1-jiawenwu@trustnetic.com>
 <001701dc5ce6$7757aba0$660702e0$@trustnetic.com>
 <011a01dc5e9d$cf400cf0$6dc026d0$@trustnetic.com>
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

26/11/2025 07:27, Jiawen Wu:
> Hi, this fix patch is crucial for the new merged feature in this release.
> 
> > -----Original Message-----
> > From: Jiawen Wu <jiawenwu@trustnetic.com>
> > Sent: Monday, November 24, 2025 10:03 AM
> > To: 'Stephen Hemminger' <stephen@networkplumber.org>
> > Cc: dev@dpdk.org; zaiyuwang@trustnetic.com
> > Subject: RE: [PATCH] net/txgbe: fix the missing old mailbox interface calls
> > 
> > On Thu, Nov 20, 2025 2:25 PM, Jiawen Wu wrote:
> > > On Thu, Nov 20, 2025 1:48 PM, Stephen Hemminger wrote:
> > > > On Wed, 19 Nov 2025 16:56:24 +0800
> > > > Jiawen Wu <jiawenwu@trustnetic.com> wrote:
> > > >
> > > > > @@ -28,6 +29,9 @@ void txgbe_init_ops_aml40(struct txgbe_hw *hw)
> > > > >  	mac->init_mac_link_ops = txgbe_init_mac_link_ops_aml40;
> > > > >  	mac->get_link_capabilities = txgbe_get_link_capabilities_aml40;
> > > > >  	mac->check_link = txgbe_check_mac_link_aml40;
> > > > > +
> > > > > +	/* MAILBOX */
> > > > > +	mbx->host_interface_command = txgbe_host_interface_command_aml;
> > > > >  }
> > > >
> > > > Maybe that comment means something to you, but it seems like something
> > > > the next maintainer would not know what it means. Could you explain it more?
> > >
> > > For different devices, the mailbox flow between software and firmware is
> > > different. There are several mailbox command in the txgbe driver, but only
> > > txgbe_hic_sr_read() was changed to use the new flow in commit
> > > 6a139ade82e7 ("net/txgbe: add new SW-FW mailbox interface"). Because
> > > this function invoke the txgbe_hic_unlocked() directly without SW-FW
> > > semaphore, I guess.
> > >
> > > It lead to other mailbox commands timeout for Amber-Lite devices, which
> > > is required to use the new flow. So this patch fills in the missing part.
> > >
> > > For the sake of code tidy, txgbe_hic_sr_read() should change to use the
> > > locked function txgbe_host_interface_command(), and this function could
> > > be change to pointer in struct txgbe_mbx_info for different devices.
> > 
> > Hi Stephen Hemminger,
> > 
> > Does this explanation is sufficient? Should I send v2 patch with these logs?

Yes you should send a v2 with a better comment in the code,
and maybe a longer explanation in the commit log.


