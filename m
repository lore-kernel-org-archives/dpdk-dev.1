Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884B5CAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 18:16:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EC5A4042F;
	Fri, 19 Sep 2025 20:16:27 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 0839B4028E
 for <dev@dpdk.org>; Fri, 19 Sep 2025 20:16:25 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 5421BEC012A;
 Fri, 19 Sep 2025 14:16:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 19 Sep 2025 14:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758305785;
 x=1758392185; bh=vb3aCVOiZTS/H9uiQfeJU9fG0jDHQ9wT63YGDGyrmww=; b=
 jLzQFxTU5Bn6bU/JVjMtLLJyTEf4Z09nzSmuGAOQrBOBPXwiJXBJYJRqSt7xANJj
 BLRMvhkMORp+FiyufbNIiJ57KAkqtEy+61E2mZzuGaYgyd7Ri23tmrAK+dVlnbVB
 BpkZlOjyRLjbr2Bz+9yGWiPVVXcVkY1CNCTQNRt4YIM5a3+upJcXcoiHmbtdESOR
 4oMKPhzIHJSPR3Ri63LITvdoq2CYIBlZK00sHhAHjcraFNWZNV5tZYCPVbDRMs3K
 syDPf7Yhkn+mHYP91CPr4uvNkbccdDei/AgklqQZ5ThiP35RLEMNxxhwJMVxm5/t
 XUmqDmWCu9UGNazlToyI6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758305785; x=
 1758392185; bh=vb3aCVOiZTS/H9uiQfeJU9fG0jDHQ9wT63YGDGyrmww=; b=m
 4+pOg9HhDKsANmNV9UCRUi938gx353e6uBtAr8nitd+jLNEd8p3MZInl+gdZKDS9
 gUyXUe7AfwqVMwaZ0wf9itBP0hr5bfZW6shDtF4K+qkbI5edJXEUFI2FRM2bpAnY
 Of3Fbo6tFjvHM2mVI/cZsTmJO+lspi3lYpLbqFs4cgGuYWqMdNX6gDJ7aOmrtsFa
 1dXg4zybDLbCCdfQlAsSWbvykBGSRPXsYRCAojb7m1CXAEsZR3UP1n66wruxnOSk
 EEX3PD8xpLRstE4SPiip3KJpOMB3Sa46FvoVObfP4aiXZNmxaewWAJlNvUgQYnPp
 vQgTXo7ckAM85ma1Wb/4Q==
X-ME-Sender: <xms:-J3NaIH1zCeypWz8nAr6mdAZqZjUkV6TTrxJ72tCOHwX9Snjv2qoEw>
 <xme:-J3NaM0A1erZvTio0Fl83WujyUQAnNunlIkt5BpYhWm-oEtPn6DHG_SPD3kDzPeKR
 BegYjFGh87K8TvClA>
X-ME-Received: <xmr:-J3NaImvBmThBFVJYIFRi4ZDGGGQixGGVRQMFdw5H-5UkmkrEgHE2EeeLWX4eITysXusoJ6-ABi2eF-p4LN6-pt9SQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegleeltdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhihuhgvtghhihesihhstggrshdrrg
 gtrdgtnhdprhgtphhtthhopehukhejsgesfhhogihmrghilhdrtghomhdprhgtphhtthho
 peguvghvseguphgukhdrohhrghdprhgtphhtthhopehsthgrnhhishhlrgifrdhkrghrug
 grtghhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughs
 ohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:-J3NaE-Q7228wVE0HEthOd7ERIl3bLG1tRozF0Mq0-Ns8no_KiS9cg>
 <xmx:-J3NaFrFd5nSOr_1b1jI8FAyij7Yqwuw6jEdYVVP7YpqMqbyJ9f8rw>
 <xmx:-J3NaFkrf0SAMWyJzYbQuntofjwlj-S5kNdviRXwXiiW3W8nEfHJaw>
 <xmx:-J3NaEislIZufxk2egkhXoL-NJwrZLedILueUrJC2gyBoLBZkuZpjA>
 <xmx:-Z3NaGrgC9P-zefGtjfSfMg-405XSxcpwPTCYmwL_ewVD_JTIVM5W-au>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 14:16:24 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>, uk7b@foxmail.com
Cc: dev@dpdk.org, Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 1/4] config/riscv: detect V extension
Date: Fri, 19 Sep 2025 20:16:22 +0200
Message-ID: <3159839.72vocr9iq0@thomas>
In-Reply-To: <tencent_FDE91C0DD66F18084FBD6A8F45C3D05AB106@qq.com>
References: <20250919163358.2887335-1-uk7b@foxmail.com>
 <tencent_FDE91C0DD66F18084FBD6A8F45C3D05AB106@qq.com>
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

19/09/2025 18:33, uk7b@foxmail.com:
> From: Sun Yuechi <sunyuechi@iscas.ac.cn>
> 
> This patch is derived from "config/riscv: detect presence of Zbc
> extension with modifications".
> 
> The RISC-V C api defines architecture extension test macros
> These let us detect whether the V extension is supported on the
> compiler and -march we're building with. The C api also defines V
> intrinsics we can use rather than inline assembly on newer versions of
> GCC (14.1.0+) and Clang (18.1.0+).
> 
> If the V extension and intrinsics are both present and we can detect
> the V extension at runtime, we define a flag, RTE_RISCV_FEATURE_V.
> 
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>

Series merged with style improvements, thanks.

Please could you add a cross file in config/riscv/ for rv64gcv
and use it in devtools/test-meson-builds.sh so we can test compiling
with the vector extension?

Another question about RISC-V maintenance in general,
what do you think about other pending patches for RISC-V?


