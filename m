Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7489AC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 15:21:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D9BC40276;
	Tue,  1 Jul 2025 17:21:52 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id AEDFB40264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 17:21:50 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E65DB7A010D;
 Tue,  1 Jul 2025 11:21:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 01 Jul 2025 11:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751383309;
 x=1751469709; bh=YPgD++kGVsp2zCA5Gs49fh5Uoc7/9yJOvmv3Q7LidYw=; b=
 hFiQHKhAUPyeXp4ABtBX4CTD3KhSUZKGgPd1HYmqvN4eWFwr9b3vgn2TpRQTqBJd
 t3bs2XItUvSR4tzRXR2BuklPELQEmBeP4662cSteAr8nxmBY3UK1Gm8f507nmn34
 iMWtSmPZQPViEc+D6zWn2qy0SDway1S4NC4vbUlSr/eCqJ8kgX8gq3MZXiZoyJjG
 fNDwCx7oZ9kV5ucKjhh1ilzkZXYRfyq0cHAMzY5QINLNhYic0R7k1TzV4LGDSj+I
 2/kCl8ZTRPMWHPoPVn8vC9JXSUbvvIYDLe2oxL8UezgWzD8+PFKuWarvJOqBEwEu
 puU08qXkxpKthB3ob6eL5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751383309; x=
 1751469709; bh=YPgD++kGVsp2zCA5Gs49fh5Uoc7/9yJOvmv3Q7LidYw=; b=U
 0viHCXvxNsgz0U3MMXfGKnuR0JZT82M9DLeC4Lx+5apQl91IUVkg6cBZEq12fr8U
 m2eo0DseeFelDT8Fyfaas7E7mk6RHdY8NA8o1zI0h8+oiHONrRCF6Xh9xkhwf644
 rJhSMq1nRnlNfBYLKp0rZ5757tbyioKiaTWiYMvcfkXWRyKGbE2+yVknGam9US53
 9t94YlkJUIBWlzxWLAcWwOJT0dIQ4mCpZXEnHjiawvmslvajGYi1I9qnlQXgb4dW
 yK/gULpx5blY0Oa2dnCqinYu+KJpsO5Gn5UTuds3e2SkibIFjkX5aFv1yRVPROTL
 rEJHjIocrsKvnY/qEUHtw==
X-ME-Sender: <xms:Df1jaHqZHXub2QWwdIUUTHbuFzAwBZsDfOG5cOZy3InXlyNZ4VMSHw>
 <xme:Df1jaBoR7JPK8z7rUz9EhKkYWzeJbmv2RAdMkisJIo48ABh9OSsFrhIUCo8DXzZQJ
 gu2fN9WWdGaa-XINQ>
X-ME-Received: <xmr:Df1jaEP8OFoP_lNdVFckgFgsDLRDcSN2wHqyijeuqqfbozrjSzYBA9B7ByBlHaaZnwjPH3_F7Uah-60hM4JdfAaBNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeekjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepphgshhgrghgrvhgrthhulhgrsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepjh
 gvrhhinhhjsehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:Df1jaK4Gj4mXCl_yu8YLlLJ6tlVFrWpRIO1Mh9Lkaxjz9j3O-6SL2g>
 <xmx:Df1jaG7wkVpkiDiBQgAXyIqcYlF3QDDHpfl5IBhlMyPwsQtNerj7Ag>
 <xmx:Df1jaCjPdDhe2rb-Lw-kUAsaEM0zjpVf7P-0VyrJLyrILEG2_ibg7Q>
 <xmx:Df1jaI61VxdSolCV3XOi4lqrC148XjGF_AjwryqmZnUb08R1LByRCw>
 <xmx:Df1jaLa3qO2oAlKIEkIMX0RRbx5k2hFzlTKu66831m4xfGirXKWS296z>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 11:21:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: Re: [PATCH] test/event: disable vector adapter test
Date: Tue, 01 Jul 2025 17:21:46 +0200
Message-ID: <3868203.CLbsiaQdQ3@thomas>
In-Reply-To: <aGPmM4Upj39rmKvm@bricha3-mobl1.ger.corp.intel.com>
References: <20250701131524.2493132-1-thomas@monjalon.net>
 <aGPmM4Upj39rmKvm@bricha3-mobl1.ger.corp.intel.com>
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

01/07/2025 15:44, Bruce Richardson:
> On Tue, Jul 01, 2025 at 03:15:24PM +0200, Thomas Monjalon wrote:
> > This test triggers failures in the CI:
> > 
> > 	event_vector_adapter_autotest  FAIL
> > 	3.39s   (exit status 255 or signal 127 SIGinvalid)
> > 
> > Disable it until we have a fix.
> > 
> > Bugzilla ID: 1720
> > Fixes: 2eca0f4cd5da ("test/event: fix event vector adapter timeouts")
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Thanks for this. It will be good to have patchwork reports "clean" again.

Applied quickly to clean CI reports.




