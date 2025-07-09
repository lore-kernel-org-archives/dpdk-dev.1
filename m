Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BAAC83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 18:22:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39C1640A87;
	Wed,  9 Jul 2025 20:22:28 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id BA15940A7D;
 Wed,  9 Jul 2025 20:22:26 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5D23014002FD;
 Wed,  9 Jul 2025 14:22:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Wed, 09 Jul 2025 14:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752085346;
 x=1752171746; bh=kI5BDaxycc1zZgVRw18Fb9Cl0i40gDoN0LgRy/N2epk=; b=
 w1MtCG4Au7TfsVWuVE8YAoFXZr5aExPY4pMxWaR7bgF8GOrylfOpUtYf6ggVDA4V
 z6Vh7fVU83c1uWJBwUMDq4tlfUDhRiNf7mef0TaLG4kJz6Mop3ibqcZEGQ4e9JHQ
 bPRGJ817dBmXfYS8v3jw+TrhsFUtMXztDXHl2Ld/nMgsnQXSddmPdCnHimzu0jND
 iaZkH8FXFy5CEGvkss0UK3Yn1feykY1vxuLX2asHpHCkW0Cn9Ftr0joEcOlvy6Bo
 Y5g5K7lGpmEkTa1XP623Rcs596DKkL7bqf7Gp9YBXGVQABc0cwWfNowNrOocjhOX
 vEWDWahTIoAXDZq5s4AAlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752085346; x=
 1752171746; bh=kI5BDaxycc1zZgVRw18Fb9Cl0i40gDoN0LgRy/N2epk=; b=H
 y/TeJRUtWNuqwvjBlQMOwLFCgcCNjCn9xp8PgUahNv30u/recfSJ2PC0v54vpq3E
 4KP9M08vJ8oxOhBYy5SGt99b6nJ97mp1ByjE+e7kgfpW2W1TGd8PkmZWPM+1D0Et
 +NvKq32eiHs6DuJn2uD72Se82CuDbUY9hhwSuAWj66+K/YcOX6PdGf1I4VedZ9e/
 a/my25Dl/s+x4BkJCHAuW4So7TvracJSdEZmXQXpXMKo8t8HkZ43ISnXApMv6VHv
 TYRNqtWimHCKxNS8Qf+tL2nm/ujW1eI4pSZ0Ip6q4m4tUzVKhVo0F8fgwH3Rh19g
 9BgD999zfM8FZ2XfXcmHA==
X-ME-Sender: <xms:YbNuaMyxbVtXj7XaMFVdBgOMK5LfqAN-ZaZQDu3OarriEnOFKv5HlA>
 <xme:YbNuaHpyilncfluVoq8eJZQghEYpShjU9SxIqtXYXWzMJ00AtqbGQX0PEboQDlsEG
 Y-EFup8wjTqk1KAxw>
X-ME-Received: <xmr:YbNuaD5eEtYvHBorq0RjNwnhdjVGreoLyQABsoyaZLXjZaIXIq8kLnIKC-ncnHT7h0jM0574dg2P4sUIqSqEdf03bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkedvjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhfihgrlhhkohesmhgrrhhvvghllhdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehrrgguuhdr
 nhhitgholhgruhesihhnthgvlhdrtghomhdprhgtphhtthhopehgrghkhhhilhesmhgrrh
 hvvghllhdrtghomhdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomhdp
 rhgtphhtthhopehmrghsrghkrgiiuhdrrghsrghmrgesghhmrghilhdrtghomhdprhgtph
 htthhopehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:YbNuaGew6Tb6HxW7mfspYQoBrXyVoDgKtY759MkJ27HftHeT6__Jrw>
 <xmx:YbNuaA4UoNUTuai8dfLSdKhDYDdbVcMKU6gqIIjGQEkVuFh3awfyuQ>
 <xmx:YbNuaFvyya-ObYNLdSw7fSW_4IUJ-1T1IEjT99MGrCwDc0Ckq0S1xg>
 <xmx:YbNuaIhS6_A-9IVFNtZu8b4yFfBOL2Puo1HuCHKCEmqcvsSWVEpdgQ>
 <xmx:YrNuaB0WAaJfZB5BPPsNA2IIHTnRDNgTla4lq-9FlVwCoS2Gky0qyxC9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 14:22:24 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Volodymyr Fialko <vfialko@marvell.com>
Cc: dev@dpdk.org, Radu Nicolau <radu.nicolau@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, jerinj@marvell.com,
 masakazu.asama@gmail.com, stable@dpdk.org
Subject: Re: [PATCH] examples/ipsec-secgw: fix number of queue pairs
Date: Wed, 09 Jul 2025 20:22:23 +0200
Message-ID: <7466317.Zugxlq0yvN@thomas>
In-Reply-To: <20250709082325.771994-1-vfialko@marvell.com>
References: <20250709082325.771994-1-vfialko@marvell.com>
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

09/07/2025 10:23, Volodymyr Fialko:
> Fix a mismatch between the signature of the cryptodevs_init() function
> and the arguments passed to it during the call. This caused incorrect
> initialization of queue pairs in ipsec-secgw example.
> 
> Fixes: 253265f8fb97 ("examples/ipsec-secgw: reduce queues for event lookaside")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Volodymyr Fialko <vfialko@marvell.com>

Applied, thanks.



