Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B679ECCFA02
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Nov 2025 15:56:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64E8540261;
	Sun,  2 Nov 2025 16:56:47 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id D14C64021F
 for <dev@dpdk.org>; Sun,  2 Nov 2025 16:56:44 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3FFF61400295;
 Sun,  2 Nov 2025 10:56:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Sun, 02 Nov 2025 10:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1762099004; x=1762185404; bh=CO0NyuyynX6MpUeo+QjtL
 AoXbSNa0zb3pBKUCJG7psc=; b=gY989fpycbRQy/LLOMxGywFi7Z8YBLAd2dmIL
 Hm4aWsQ7BsVXYhRa5YVq0CQn3quURHBp1f+8pMXb2B+T+diPc+J33pJN9IDDi4Gz
 ioEyp1B/xt7jnaLtxHaaCBjh89JJ7AQXO9u/sCPGgSMjtcB64C/YkI64PNTFGP22
 cJqLKr/ZXFpR0QwkvOhgm0U+QIt04K9cv9hKwyd7m0kSnGjJANJZts501KiOeu0E
 /6q/pfCaYW2xHCJRWJUE61rUKfd7tgRlOARGuBMow5+PZ6z9/5f/Bon6QGxvfKa7
 Cl4/UNJlbp1yCEdz+DP94XTgHlz6IsGKeQKcGhzmlauLnjvkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1762099004; x=1762185404; bh=CO0NyuyynX6MpUeo+QjtLAoXbSNa0zb3pBK
 UCJG7psc=; b=uThZPHxkQP93bQuPYcrlcvLpbaGnsc7UKLXoxf/eegXIrR5itSp
 p5qY50WEl2guAom2/bbsaxphH/rZb4x+6jD6jAA24zBPz1dZ0VJxKVM3OwnT42fy
 lma1e2Xtlp51oT/Dj977EJdKeSPFsZyEFPzt4ryGK74R5t3t3i7fepwSAERJTsr4
 qSKFcEuR86YZnYTDFIHAzUMrr9tFOKr7nA1MY3hSOVriJW+Y7qXD9GrqRcCP4CJt
 EGHqeIUfUXMV7gkqQnld2i6JqC4+/QYqf+rzFiAHCgFEH3F9+4G4UxNPXn83LE4e
 ygMCUnzgXuGbJ0DwToxNj2KSnBh44qq7Xiw==
X-ME-Sender: <xms:O38HaaGp86Z40-SarcxekxdSvI_3N6LVf3a_PAIz-wGwjDnNFwvixg>
 <xme:O38HaRNxL3HbzISp9DOg_043jVKb9s-4R7gFVnzFNGCukVMzfBzzBnKsjU_eVlDnC
 FxGF2MSrUZmRGpzekMPtcPDBuxhfyc9_8TdTR1hueTXQmU7-sYYpe0>
X-ME-Received: <xmr:O38HafMD_5Ccdcx4m_PRrSrececdktaSuE8f3Ms7sfT5r1sWyiCjfesblX4jIYg1g26haGrSE3JQbmVg3UvykbTLjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeehieejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttd
 enucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhj
 rghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpedvledvudehvdduudevuedvveehge
 duleegiefgjeehudehtddtgeduffejiefhgfenucevlhhushhtvghrufhiiigvpedtnecu
 rfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpd
 hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghv
 seguphgukhdrohhrgh
X-ME-Proxy: <xmx:O38HaQ4Vxd58bsMRIBQWCdJHHO4L6wR6V7192wJJicZMu0wI7JWDqA>
 <xmx:O38HaT723vMHlg5PMN7Ae0QHX0HgQoyXH3zT2vui3pNPP0kPdXEayA>
 <xmx:O38HaY0NyFS4K7h7b79kg8eiTZHjD1Tm871cyWoh1QiBO3Aj3fmwbw>
 <xmx:O38HaXVoezoubJ5VCir_fdxBLr7HDFMYbN5Qj2Azx4nPL3IgRfmp2w>
 <xmx:PH8HaTHcNR8MJPZimViFtP3BlsRERIx52Od8nmBnoIfd5C5AUsCkl_jH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Sun, 2 Nov 2025 10:56:43 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH 0/5] mlx5: remove useless constants
Date: Sun,  2 Nov 2025 16:52:59 +0100
Message-ID: <20251102155617.4001783-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
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

This is a cleanup of #define constants which are not used.
Some unused constants are kept if they are part of a bitmap,
or can serve as HW documentation.

Thomas Monjalon (5):
  vdpa/mlx5: remove unused constant
  crypto/mlx5: remove unused constants
  regex/mlx5: remove useless constants
  common/mlx5: remove useless constants
  net/mlx5: remove useless constants

 drivers/common/mlx5/linux/mlx5_nl.c         |  2 --
 drivers/common/mlx5/mlx5_common.h           |  3 ---
 drivers/common/mlx5/windows/mlx5_win_defs.h |  2 --
 drivers/crypto/mlx5/mlx5_crypto.c           |  2 --
 drivers/net/mlx5/hws/mlx5dr_definer.c       |  2 --
 drivers/net/mlx5/mlx5.c                     |  3 ---
 drivers/net/mlx5/mlx5.h                     |  3 ---
 drivers/net/mlx5/mlx5_defs.h                |  6 ------
 drivers/net/mlx5/mlx5_flow.h                | 17 -----------------
 drivers/net/mlx5/mlx5_rxtx_vec.h            |  7 -------
 drivers/net/mlx5/mlx5_utils.h               |  3 ---
 drivers/net/mlx5/windows/mlx5_os.h          |  2 --
 drivers/regex/mlx5/mlx5_regex_fastpath.c    |  1 -
 drivers/regex/mlx5/mlx5_rxp.c               |  2 --
 drivers/regex/mlx5/mlx5_rxp.h               | 20 --------------------
 drivers/vdpa/mlx5/mlx5_vdpa.h               |  1 -
 16 files changed, 76 deletions(-)

-- 
2.51.0

