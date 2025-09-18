Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72A6CAC59F
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 09:10:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EA83402C5;
	Thu, 18 Sep 2025 11:10:49 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 0B7F940288
 for <dev@dpdk.org>; Thu, 18 Sep 2025 11:10:47 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 97BDAEC0352;
 Thu, 18 Sep 2025 05:10:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 18 Sep 2025 05:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1758186646; x=
 1758273046; bh=+uk7ospsqiv5fqGp3BbK9R/0h5Xv1mtb0cZcxr3/GOs=; b=P
 4wvfyXgfhAzVo8nBxbVzOSevmzAEQD3l+OZGKa0UO4KH3L1s+Y2180IxxrIu/5rt
 cjUNMS3bGIhpwGUJuXRg+NEYG2IccBvzzhr8Z7h1wRA3829Q/flvO7c2s6cUp1ji
 /RIif2Agd7nnIEHBjMycFFLPiaJZ88pQj4Tes02hpG57583MNRcjnvwa8GywZozC
 xyJIQsJysKMI/Lh7iu3Qp6pks+rRof+82+oQ/WW8Zvk+q5eZqXHDE1aY49QuLIMv
 1PPp5dJpR/8cCD9ME//SXBdl/c1msx5SIF6sk0ntvg6o77ZE7DzaeYUZvKXTa8dJ
 tFwZ/dmmi25Nc+b/2qnnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1758186646; x=1758273046; bh=+
 uk7ospsqiv5fqGp3BbK9R/0h5Xv1mtb0cZcxr3/GOs=; b=U6/fyNgcpb0EcHNDB
 fzEdqPV/D3PzDE0Gnt9Rr5In4xGDW10j3UD0a7vpE34fUrektMy2T5IwxZx74JtW
 G6wDrkW9xToZ2KEB7JaGeeafGHKu5C8ycu5/WkZ9ye64GHpH4Jz2n25L1jSVhuhB
 qTD9M3qqW5Np4f+RdpdgBhx2Pg/mPYFsVaDhYW48KJlUsUgWJWdr/HLxbQj+e1h7
 7ZWqgTgLgM0bMgW9BORiqEt+LMIP1//d53lnDM/E6Ufpo5eSZjcHXaTiKNgrmsKv
 7wFpSxD8Hq1qQwffPKmi/8VwAQqdNkdGeEJSgRCNphF9vunhtEVGXIlL5xtWAIoY
 1N6mw==
X-ME-Sender: <xms:lszLaFN77pPLzAAGVCpTcLxl9RGKU1wjFXTfuajr2DLM4-6lasnMlQ>
 <xme:lszLaNMd2vg_Lg_DM7PgdC0ofUfwgrc3Q0d8_-ohdGV0yRX5ImfSktazgd5uA6UDJ
 BCkDE5ZVNao5EUxvg>
X-ME-Received: <xmr:lszLaF_kwTzJ0GFXxUGo2ds6i3IRCXvHhHqqwY58dj_6fjIsIQudxkNOWyMZ5o1CwXO1BrarFj6adE6MnuWM755FPlGVQ8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheelfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
 dttdenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpedvjefhudeghedvtdeijeeige
 etuedugfejueekieeltdfhteevkeehhfeilefhtdenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
 vghvseguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:lszLaJ6MmC_12kF-bdRcHApw1NAGg4-glfgDwQkTBAG2lE57zqQrmQ>
 <xmx:lszLaE0czB9sDwk89f2hfP3T-yA2NsshbAcxXYa9QXPQr4OEkUwWXQ>
 <xmx:lszLaIC4F7JesScboCR0-qtC1EofSqsKt696qysaX_uS6_nCQhIVPg>
 <xmx:lszLaO15dNczdlv7DfZsfwJ0vaCvnbUIIzXlJA5BHwOhiZAHaueCZA>
 <xmx:lszLaLvk6bGYCblpUV_LYrynidChCRJNWq2c4ZXXCyWwF8VW5wZpLdte>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 05:10:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 0/4] lib: fix AVX2 checks and macro exposure
Date: Thu, 18 Sep 2025 11:08:06 +0200
Message-ID: <20250918091039.1368875-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918073135.1273767-1-thomas@monjalon.net>
References: <20250918073135.1273767-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

I've found the AVX2 function is not used in efd library.
Then I tried to make AVX2 compilation simpler in efd and member libraries.

While at it, I've hidden a macro which was wrongly exported in the API
without having a correct prefix.

Thomas Monjalon (4):
  efd: fix AVX2 support
  efd: remove AVX2 build-time check
  member: remove AVX2 build-time checks
  member: hide internal macro

 lib/efd/{rte_efd_x86.h => efd_avx2.c}         | 18 ++---
 lib/efd/meson.build                           |  1 +
 lib/efd/rte_efd.c                             |  3 +-
 lib/efd/rte_efd_x86.h                         | 54 +--------------
 lib/member/member.h                           |  9 +++
 .../{rte_member_x86.h => member_avx2.c}       | 23 ++-----
 lib/member/meson.build                        |  2 +-
 lib/member/rte_member.h                       |  9 ---
 lib/member/rte_member_ht.c                    | 14 ++--
 lib/member/rte_member_x86.h                   | 68 ++-----------------
 10 files changed, 39 insertions(+), 162 deletions(-)
 copy lib/efd/{rte_efd_x86.h => efd_avx2.c} (80%)
 copy lib/member/{rte_member_x86.h => member_avx2.c} (87%)

-- 
2.51.0

