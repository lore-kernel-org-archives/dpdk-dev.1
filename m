Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6A3CAC597
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 07:31:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C70D740288;
	Thu, 18 Sep 2025 09:31:47 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 666494027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 09:31:46 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id DA6E7EC0192;
 Thu, 18 Sep 2025 03:31:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 18 Sep 2025 03:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1758180705; x=1758267105; bh=7GrT6E1koKEz1eSuMhZDh
 buE8OI7PqyA3aDWKZCQ/IQ=; b=oYxBpg528oT+29okMe8anlajcPv6+RGUChGQF
 4LEVP4cLMTz1liImeZ8x4KzD++sOM4QjpmmHFprG72uVoW/JwPXb1fEQtgxnwyma
 /wuivbSFVMSFcRz8bPSb1WBPdY5qL0BIT7VLMb/6YH02zWAa9Ez+wZ0bYUF8HZv3
 l/5+LU0D2HbLyu71jwVzvQs+6awEFrYXKOodxFZ6EgELTzqCFjq6LElm+OybmWZx
 mxrE6mHjICXow4hTRCKqMEaeSnChr2TmYDRwLQS33WHB+B4mMhKaOi1+dn9QkWKV
 9/zK4qnFgKUL1j0vta9670PGAh5jtXZJXVyM1xIFw/htXRVDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1758180705; x=1758267105; bh=7GrT6E1koKEz1eSuMhZDhbuE8OI7PqyA3aD
 WKZCQ/IQ=; b=OMMKiskRTXAudBR1Ow2JQZxmX9tlaF0liqyfV9SLHIEb3waeEH6
 YsFEb5+WNon33SuGjIP6j0I1cDdcHActxuskI0mX48FH6l5oAW1EnRQ1NiwmBYCN
 yqbN/elnn5KDgE7CEY9HPbmzkMGrlyO+oQio/x2c5BR3Q64hql570JvE5/l073Ev
 ao10LulqLFy7Ue1/4we9KhFtzP8A69MmZI9pPqJ82gPQ4t6AI3AQ7/gVOLHC+XfT
 nejwPrhp57LA0f4xkMQzT+52mE9TYllITYfvrsWi5ttpjVCWCHSBJ51nhOhrnfl9
 MXCoVDwKg9YdFsYQQIgQOKnH++2Y6WuR1BA==
X-ME-Sender: <xms:YbXLaC2P3DMLDpFMr9N2pCMrghLlOAsbSHx9nkLwjq4ahP4wI9kOsw>
 <xme:YbXLaKVtBlCAJvxKhLm-LDmboCRX89RR17rp60ovRTzs84sc3akSVIcKuJ0PGrDl_
 Rv5u0Yzj-vgF6DfWA>
X-ME-Received: <xmr:YbXLaMmM7tu_NN99imI-CMJ4pDx5QU_-VXR-YXoWTUQO5U0jCzhZBu7BtH120sIQVdl_Lndyi71m_fSkc6UstvauycxWylc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheejgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
 enucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhj
 rghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeevveefveeiiefhtedukeegkeelie
 egffeukeevudetueffieduveetiedukeefleenucevlhhushhtvghrufhiiigvpedtnecu
 rfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpd
 hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghv
 seguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesih
 hnthgvlhdrtghomh
X-ME-Proxy: <xmx:YbXLaMB9o0IJjs0ri7RaxLV81lgTIIKDi4AjTIzG7sHAWFLJve6wHg>
 <xmx:YbXLaMdTcdf5pMqmBxlwf3lkicdk3m_FEviSq8a9I6vmIDc2v5BXgA>
 <xmx:YbXLaHLzv0OtA86_jTS4dNR3oELr9pNbEQD5lkQmUMuObj0-2BNkWw>
 <xmx:YbXLaPf-IjT0TVyCIUuGin6hSWjST5aQ-M71-YkjLZxK6-UymkZdbg>
 <xmx:YbXLaOWuGTBRPW1KKVQvxCtWsC722qF3_1gFjr4Rvy3DGczAEJ0hX6IS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 03:31:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH 0/3] lib: fix AVX2 checks and macro exposure
Date: Thu, 18 Sep 2025 09:28:02 +0200
Message-ID: <20250918073135.1273767-1-thomas@monjalon.net>
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

These are fixes for AVX2 in efd and member libraries.
While at it, I've hidden a macro which was wrongly exported in the API
without having a correct prefix.

Thomas Monjalon (3):
  efd: fix AVX2 support
  member: remove AVX2 build-time checks
  member: hide internal macro

 lib/efd/rte_efd.c           |  3 ++-
 lib/efd/rte_efd_x86.h       | 10 ----------
 lib/member/member.h         |  9 +++++++++
 lib/member/rte_member.h     |  9 ---------
 lib/member/rte_member_ht.c  | 14 +++++++-------
 lib/member/rte_member_x86.h |  3 ---
 6 files changed, 18 insertions(+), 30 deletions(-)

-- 
2.51.0

