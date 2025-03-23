Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CBDC28B30
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Mar 2025 12:35:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF1C04064A;
	Sun, 23 Mar 2025 13:35:36 +0100 (CET)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 1879C40277
 for <dev@dpdk.org>; Sun, 23 Mar 2025 13:35:35 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 5130B11400D9;
 Sun, 23 Mar 2025 08:35:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sun, 23 Mar 2025 08:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742733334;
 x=1742819734; bh=xmdnJdj298Zkr0z9frNvUN9vGiG02VSz45Sf1Lu5yGg=; b=
 rR45defnSa0bcRYkVU+11Ilxgt9l+ocGvv07LyCsjaBOeXWpBJ1xkRDRnRFMOZH0
 7SsHOnNxwMMGwsZPEh2xXzexvIxIKroz/tjST6yBJb9e5u9k2lAufGcMFY9QyJOH
 0oDq4ecagcxYgqZHmF9B2BBMor1KPPDt9AKkXCxZimLJ0x4ZTRwhY3GmczH3g/8X
 fYcuUvsDR2KF6KjCrc4swydaW5GsPXEJ04dh/kGgSdqq6lv4bD9QjQD3i520il+f
 CkxmjycYUmALVDfCKYq1NC9R+WcB+yG64Xad3xu+Pps8rvuxuVkm5VnQK6m4F9s5
 dQWrf5Urqb5XdVYicRlEFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742733334; x=
 1742819734; bh=xmdnJdj298Zkr0z9frNvUN9vGiG02VSz45Sf1Lu5yGg=; b=q
 XlWd0wyJ9LXr7iNGRIjDEvWPOkP8yJ3GghdWoG9tpxamlhcR3+f+LzrSMY0/73A/
 N/bimAz+4yXLJqPVDrRJNpUuja09yE5RRMR6mIUbF08torIRtcdATsN1cW0yatxj
 qta9Xpvjor/IYJXU8HRGbMfqZzwIX3f664HLf9cPJfEucRvWYL67+jsPS1naFcSF
 UddiWIQNYUDmvpNJGscW7+pdjBoX4qYeuTLXR98EIl6R/TtfKaVK3HD/PMPIjxxF
 HdWzhof4dO5bnv9fUEhNY+lyKP2iG3A4U32DLz+kK3MGN6vrQpylJyG4ILzRhcv3
 DSATlD/D9LdVW2B1jjUIg==
X-ME-Sender: <xms:FQDgZ7K2ur4Ts7aF4LuXq31_i-BLEO1GfqsaZ-4TQFGkoTu3In8a8g>
 <xme:FQDgZ_LRsQWXDpN7BqTTJ7aTpuNQWjrfdLXt2GChhomj8NPINWXnbkYk6eslxoFhf
 3lAJGHaz753pHO8sA>
X-ME-Received: <xmr:FQDgZzsozo2Z7esC0AzKME9z4hvbko12rF2l5op07V8mZNt4axe9sfYilOYHcpECbHElTr6-0NU9EpA1LYUB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheeikeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
 evufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhj
 rghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvg
 hrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfefkeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhoh
 hmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohephhgrihhlihhngidrgihusehinhhtvghlrdgtohhmpd
 hrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhi
 tghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrjhgvshhhrdhtrd
 hpuhhtthgrshifrghmhiesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhhnhdrmhgt
 nhgrmhgrrhgrsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:FgDgZ0aPMx4b5PmJeukclmvZscj9lIEWo5aJi8Dv1d6KMrb4VeqI7g>
 <xmx:FgDgZyapeDM5xOJqydmzMHhX7FjX0Ce8HNsQDi0g45G1oj8C93rLIw>
 <xmx:FgDgZ4DFRrZUHLNmSprUUeNBXLjh3J7oHH2vuyv6iHa4JcvRzrHNQg>
 <xmx:FgDgZwapMLZN66ftVnRW2vLO7Ay7792hkZohmJAQTbkhjBFZtT-2Ig>
 <xmx:FgDgZ5y9Lk2TrlVL9HIN1wBA6PvKuxPaVM-T56UpL1LlrBRlMgD6V1SX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 08:35:32 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: hailinx <hailinx.xu@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com,
 john.mcnamara@intel.com
Subject: Re: [PATCH v1] net/ice: updated latest recommended matching list
Date: Sun, 23 Mar 2025 13:35:28 +0100
Message-ID: <8488315.MhkbZ0Pkbq@thomas>
In-Reply-To: <20250321003622.988446-1-hailinx.xu@intel.com>
References: <20250321003622.988446-1-hailinx.xu@intel.com>
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

21/03/2025 01:36, hailinx:
> Signed-off-by: hailinx <hailinx.xu@intel.com>
> ---
> +   |    25.03  |     1.16.3    |      1.3.39     |  1.3.53   |    1.3.14    |    4.7    |

Applied, thanks.


