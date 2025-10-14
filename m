Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAB7CCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 07:05:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C88A4402A0;
	Tue, 14 Oct 2025 09:05:27 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 9245840288
 for <dev@dpdk.org>; Tue, 14 Oct 2025 09:05:25 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id D9E72EC00B8;
 Tue, 14 Oct 2025 03:05:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 14 Oct 2025 03:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760425524; x=
 1760511924; bh=jAf/vpOKQXnz2TDchaZT8OLt0wDDyaK6sNBsg4EnstY=; b=X
 APOXv7vyT8HlTtEehKE56rWGgYs9tjMNyQaFinE0jItkdcnsf4Ea2DTNK519JxX/
 z6hU3d93rzpGN2Sv/cVAVKl6dt+FPuieclBfaOsGD+O0hcM6KocD6GroFA6CcBtE
 ptePweAuUwMavGBtORLcb1cLfCyqOFGmSA92h1iJvWZcEFLMrB4ihQWVZochqtAx
 pJUjPnYEAnCj/6+qRn3kO0hOpoyUxo0tq+wCH8Hb/VI/THMB50DPc5sWnwMtRXmt
 3PqjxCxTEcTMbNBdtBLrj57I/3NSJvTK24D2qGTZKNFlifUSnCM9mh5XwXgfh/hb
 hBAs3IRaDn43aJJ2i30Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760425524; x=1760511924; bh=j
 Af/vpOKQXnz2TDchaZT8OLt0wDDyaK6sNBsg4EnstY=; b=Lpx24X13oke1uagc5
 mSDTEFaz24bkEMoqGBZGluLawI1f+i+bItkTPtuRlJUy84CwAEuksYT8iXxtKNMF
 qltA8EdGWYEoCXh7KCo+AuGvwdO5/8MFEusEMK++cpITmG2M3y1XUfxY88+wRQJg
 e4jSEAPB0Qy8OVXWyPpEpamnUSjUD0NRD41lC7LPk+Ch1oD7b1KRthGRPB35xKej
 Xq1LiIYhafX/wuXtUSyVYKryU1B3MDMa7NlUV82bPw1RrBEUF8TDFlubh2y6a2qg
 TjUi94Z1NN9f6mFohWZ85T+LGr+ePyNUy0dr5DQbAoyAgBmfBSlku+q1cmteirAP
 bBubA==
X-ME-Sender: <xms:NPbtaJRDvgR8f8N6pyQoRrDD4T6fQb2ghk8fz5bKc7Xdej26QyRCSA>
 <xme:NPbtaLsXJp6s4yo8-5rYw34jkSSOJAR4pwTncEhCF4pqnO9plPgzFsL_aJbEVG-J9
 xMiNPkf7fEgZ_X-KDMFVgAqzL7psUQ4MNtLBujpamDgcInQeDdqqg>
X-ME-Received: <xmr:NPbtaKZkJ_D0ctEZEjBsZvIMhckpu3bhQjLTCdAgvj1d7XiY_HWjjcTJhYGVqKF8Q-VA4YEU7_0AyPYMSOY9uPcrvOqM2jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudelkeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejhfdugeehvddtieejie
 egteeuudfgjeeukeeiledthfetveekhefhieelhfdtnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirg
 drtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdp
 rhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprh
 gtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphht
 thhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:NPbtaBFArFlCP5QXcTredT_Wbr5nqjQWxZ-hoG2rmxBSu9URnJxnGw>
 <xmx:NPbtaOznVQZVk9PN-SL1_-5xeHtpeyRrnAop5d7nX6dbXojmP-ykfA>
 <xmx:NPbtaDk3bzo7gFugdUU2kcO8Jinvco6ozN7eZXUxsSiJEO8Oridcnw>
 <xmx:NPbtaHmI-Yk4opsT4499bEf2c4IeY6cBXuYY3w0vo22DFS1QQKK1YQ>
 <xmx:NPbtaN8dvLwiwzZTAIEdBy7-O2yYtyTCQRzjXKPTolZq1J1Ih_VH1Jji>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 03:05:22 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v5 0/7] add mbuf debug capabilities
Date: Tue, 14 Oct 2025 08:58:28 +0200
Message-ID: <20251014070517.922137-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250616072910.113042-1-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
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

History is added to mbuf for debugging.

This series set some marks in mbuf allocation/freeing and ethdev Rx/Tx.
More marks could be added in other libraries.
Drivers could benefit a finer debugging by marking alloc/free calls,
in addition to marks already done in the mbuf library.
Even better, the application could add its own marks.

As part of this series, mbuf statistics can be dumped,
and a Python script will help to parse mbuf history.

---

v5 change:
- fix MSVC build in testpmd

v4 changes:
- fix/rewrite testpmd commands
- fix python script
- fix thread safety
- fix checks
- fix logs
- change config (no Meson option)
- add documentation

v3 changes:
- use atomic
- fix prefix
- add asserts
- reformat dump
- remove #ifdef clutter
- remove mlx5 patch

v2 changes:
- move to mbuf in dynamic field

v1:
- mempool feature

---

Shani Peretz (3):
  mbuf: record mbuf operations history
  ethdev: mark mbufs in burst functions
  usertools/mbuf: parse mbuf history dump

Thomas Monjalon (4):
  doc: explain debug options in mbuf guide
  mbuf: move header include for logs
  app/testpmd: use space separator in dump commands
  app/testpmd: add commands to dump mbuf history

 app/test-pmd/cmdline.c                      | 340 ++++++++++++++------
 config/rte_config.h                         |   1 +
 doc/guides/howto/debug_troubleshoot.rst     |   7 +
 doc/guides/prog_guide/mbuf_lib.rst          |  18 +-
 doc/guides/rel_notes/release_25_11.rst      |   7 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  33 +-
 lib/ethdev/rte_ethdev.h                     |  11 +
 lib/mbuf/mbuf_history.c                     | 227 +++++++++++++
 lib/mbuf/mbuf_log.h                         |   2 +
 lib/mbuf/meson.build                        |   2 +
 lib/mbuf/rte_mbuf.c                         |   7 +-
 lib/mbuf/rte_mbuf.h                         |  13 +-
 lib/mbuf/rte_mbuf_dyn.h                     |  18 ++
 lib/mbuf/rte_mbuf_history.h                 | 206 ++++++++++++
 usertools/dpdk-mbuf-history-parser.py       | 166 ++++++++++
 15 files changed, 950 insertions(+), 108 deletions(-)
 create mode 100644 lib/mbuf/mbuf_history.c
 create mode 100644 lib/mbuf/rte_mbuf_history.h
 create mode 100755 usertools/dpdk-mbuf-history-parser.py

-- 
2.51.0

