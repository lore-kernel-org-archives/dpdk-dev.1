Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FE6E9A026
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 17:43:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D59440261;
	Tue, 17 Feb 2026 18:43:19 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 890E6400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 18:43:18 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 222B11400053;
 Tue, 17 Feb 2026 12:43:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 17 Feb 2026 12:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1771350198;
 x=1771436598; bh=UN/HZ/Un+vT4mki4yh0muptOnjwyDfpZDwLtAYfSPhc=; b=
 ZaR6x10ErPSrUKhQkpAAVHAXsdWL5eSDDHWLcyWebvF9NGGZffNzmKO0/Ob9B78h
 82yFVjkN6QyZHOPTjbuk3MMlVbBt2QOJoJGGvLozTuKKOkMyUB6NVRO7iNJpi+zR
 0l69DPg+ME6KHKUw4BqDSjaOYDTAyIOcx+PJ8nAIMv7k2YYfEKSVm5H/6K+TzdY2
 1qc2EnKdVoneMpbV/vAjJ4Yz/cSfokQbu3dL1YTqYg7cGmIa+/5JVctUAxAVP9Rj
 hT4r9d9x7+tDTQr8kz2rqJIbH2cSO+CYbCXI3rVB0JE5Y6GK1Ar+NaOZWj6qiGi6
 xOSe8HJC7+/TlgdcSaiASg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771350198; x=
 1771436598; bh=UN/HZ/Un+vT4mki4yh0muptOnjwyDfpZDwLtAYfSPhc=; b=j
 k6vV+VTrNe/WY6SeE8jDX1BKchI+ZBIFSsPrNtdHBxRRo81EGvPGCCA41il9Qp92
 GLF5Js+1A+fJ1uL75ARJqYz4AxLaJMfTlWH41XSZ+vza6zYrzCJu+I+yzyVVXk7F
 v6WXdMkTXAyZMxO953Zw2GS11fzKphZa8o220OcN7jvncRTw9lmTvuWZsCWdmVds
 UCtkN7D9ahLSjs8dE5p6ZPhyKbMfnBJEXMAXFOLZH6x6zAgD6Hcc6rHLCaLgmn6c
 efRfLEhiIhSRAAgbnK+W/ZEem9fTrKosBirbCFw3utn8AeEm+CE6vjuh4kMeVJYN
 IFPSA1uVQZlil2t8CB0fA==
X-ME-Sender: <xms:taiUaRkvftZnweSSEe-jlvv_GLlVzBWYNulimEWvD9mZf7o5fyv-EQ>
 <xme:taiUaSbjyX4o_846rPjPrdapVrO3taxPQv-eEJALUWLYtEr-zO_S7w3Im3L_vpAiu
 67OwognD8XsMifRyrUzmdAHsihATRT7-Lx6ltE2rje2hQj5S8_XKg>
X-ME-Received: <xmr:taiUaRNjY82_q0h0cS6BE7tccy35ZJGryR7TXABEE_TkQHcNOdVEJBYslN_l_-K5MOiDGdhur_nWy4odFeeY260Rdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtfeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedujedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkh
 hplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghp
 thhtohepfegthhgrshefsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhumhhinhdvle
 eshhhurgifvghirdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhhtihhnrdgrnhgrnhih
 vghvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehtohhmrghsiidrkhgrnhhtvggtkh
 hisehinhhtvghlrdgtohhmpdhrtghpthhtohepshhkohhrihesmhgrrhhvvghllhdrtgho
 mhdprhgtphhtthhopehpsghhrghgrghvrghtuhhlrgesmhgrrhhvvghllhdrtghomhdprh
 gtphhtthhopehgrghkhhhilhesmhgrrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:taiUaSd_Xm2wpOZfbcY33u_gGVeAtJ7lf5Eh5RH7xV4eEyauFqqE0g>
 <xmx:taiUaXFJafduInshtCFDwbyHdYK_fliqYXzluheYq-VvQ769Wp6-yQ>
 <xmx:taiUadsWYnNAutScUEdbF259at2svZMBQOWyTybfy7Tpy-DcgmVj8g>
 <xmx:taiUaRq7Lw2ppOiBGtdUjZn-n8FpmjQAWSOvTiWx_-V077IqnFVdRQ>
 <xmx:tqiUaTTSNKvW6m3sJTo5xlivMWkIsRwQ6aIschMGc8rhuJqi_sNU73C8>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 12:43:15 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Tomasz Kantecki <tomasz.kantecki@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, Akhil Goyal <gakhil@marvell.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: Re: [PATCH 4/4] examples: remove unnecessary include
Date: Tue, 17 Feb 2026 18:43:14 +0100
Message-ID: <14407087.lIgitqOTu8@thomas>
In-Reply-To: <20260121170540.785735-5-stephen@networkplumber.org>
References: <20260121170540.785735-1-stephen@networkplumber.org>
 <20260121170540.785735-5-stephen@networkplumber.org>
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

21/01/2026 18:04, Stephen Hemminger:
> --- a/examples/l2fwd-cat/cat.c
> +++ b/examples/l2fwd-cat/cat.c
> @@ -12,7 +12,6 @@
>  #include <stdio.h>
>  
>  #include <rte_common.h>
> -#include <rte_memcpy.h>

It breaks the build.
I add this:

--- a/examples/l2fwd-cat/cat.c
+++ b/examples/l2fwd-cat/cat.c
@@ -10,6 +10,7 @@
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
+#include <stdlib.h>



