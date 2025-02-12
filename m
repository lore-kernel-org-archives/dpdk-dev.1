Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF98C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 13:43:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61AEB41157;
	Wed, 12 Feb 2025 14:43:47 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 1CE634114B
 for <dev@dpdk.org>; Wed, 12 Feb 2025 14:43:46 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 6F7A913800F5;
 Wed, 12 Feb 2025 08:43:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 12 Feb 2025 08:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739367825;
 x=1739454225; bh=09yru2OIPMzwyt+eRDYD2DEVydJJ8kzkmRrEsxjo0DM=; b=
 g4Z/sYcREcEVtWoA7l2iWSbt2iebV49JeRE2VKThOOPwbWy6wfBjcM9jQJOWO1/K
 cd6+EgauGln9GrS5oH1sA+jUp+mJx4L2qjirAbcbzTURvCZd/BjfrbxKF2Ua6czf
 pk8HV+5euZ5pwGQfQRuTf/Qi9l9cT/NjgEsOjijqhQosg1yiBqNsZA2TUYzXqFwi
 y8HAWffAG9U4cOKi2r2RSXNc9BJFu2iwksEnLiwbPGOeQGk43VLR0mG4y4uCfok1
 PkQFGjxEyYT6eSgaIoV1PWsuL8vrMZDUi4bwJcSXkS1MIiXHHAXDW050StoxANw4
 bN1IvjSLbUg9sX7J06688Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739367825; x=
 1739454225; bh=09yru2OIPMzwyt+eRDYD2DEVydJJ8kzkmRrEsxjo0DM=; b=X
 DtpMbTfSPDJcPs9DMQbzG8A/IauHM5d5YWJYivUaIfjBloNV+m9jcuN0AVLWYVKA
 ivNNyZ9E1X/BFRZNSu65+rkJ8l02yQDghnbgP5hyrDsD+fAhU712GUA2a8jU9eS4
 ovGeHVKdIZAHJQUzGodWd9D7rYwlePPdI9rnKhA3HHr/1WdXzl1LNRChrYSLLyGm
 e8wuAjYW9F234ZC+MijcTVa1uGSD/eFGqI1uGbk5oU9EXDcEzbwiZSCfM60vmmbd
 KARAzw5NCHueH3q1D5FN3gUAnkehwK8nOltLXoFVF7Dh0/8IBBl+xpYofpxwEp0N
 iqgcLoIZ431bw8GMObs+w==
X-ME-Sender: <xms:kKWsZ0zqGxge5_IsCM-tz1fxQPyfkDrQNo6HHlbm5hItCvN09TFr2g>
 <xme:kKWsZ4QmaYadh-obyVjJfuuCC5r-dFHTD_IXNYcRFn0G1Lj9rcwSLZPVLx0SfcDRr
 o6JCXgw4zSBfqiqmQ>
X-ME-Received: <xmr:kKWsZ2VWcKT8n6Ey59ApBYf-ZHdo_WwX0XgRXFZ10-R43XL5wS1ZvsKNCcTOuFRVG2Aw9gosaCpur8hmBol6j9ygLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedtfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepiihhrg
 hnghdrhihonhhgvdehseiithgvrdgtohhmrdgtnhdprhgtphhtthhopeguvghvseguphgu
 khdrohhrghdprhgtphhtthhopeifrghnghdrhihonhhgudelseiithgvrdgtohhmrdgtnh
 dprhgtphhtthhopehlihdrmhhinhdutdesiihtvgdrtghomhdrtghnpdhrtghpthhtohep
 rhgrnhdrmhhinhhgseiithgvrdgtohhmrdgtnhdprhgtphhtthhopehsthgvphhhvghnse
 hnvghtfihorhhkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:kKWsZyjzcnG8lwYD9ZW0ngUQpy7AK-63Vluu7LJFmlZME2PGX406Tg>
 <xmx:kKWsZ2A8i6n6TxE7rFd1eKpBPXqTbbUdx1ybkLdTtMn7SvDyZPpN7A>
 <xmx:kKWsZzKR7bE9uyvPJ9KDJNOMl0tYoUO_TE0xuS667iJIKZ_ZdbwoOg>
 <xmx:kKWsZ9BPT9vnEfyW2ZiRJF6xgglQr4xR7l92cJfCjlBk5s8xSmFj1Q>
 <xmx:kaWsZ416yKy3DxBZOCwy9F4jFRLUawZPE5h-mZMXSvuqOmYUMiEnKw6N>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 08:43:43 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Yong Zhang <zhang.yong25@zte.com.cn>
Cc: dev@dpdk.org, wang.yong19@zte.com.cn, li.min10@zte.com.cn,
 ran.ming@zte.com.cn, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: raw/gdtc: use standard macros to optimize code style
Date: Wed, 12 Feb 2025 14:43:42 +0100
Message-ID: <6258312.2l3rmUXbR5@thomas>
In-Reply-To: <20241210123728.5e33f467@hermes.local>
References: <20241210021219.773622-1-zhang.yong25@zte.com.cn>
 <20241210123728.5e33f467@hermes.local>
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

10/12/2024 21:37, Stephen Hemminger:
> On Tue, 10 Dec 2024 10:11:30 +0800
> Yong Zhang <zhang.yong25@zte.com.cn> wrote:
> 
> > Use RTE_BIT to optimize non-standard macro definitions
> > 
> > Signed-off-by: Yong Zhang <zhang.yong25@zte.com.cn>
> > ---
> 
> Code will end up the same, but it is easier to read.
> 
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.



