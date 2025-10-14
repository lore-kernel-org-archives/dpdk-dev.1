Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386CDCCD18D
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:41:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4620040668;
	Tue, 14 Oct 2025 14:40:59 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id B1DDA40665
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:40:57 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id D73191D0016C;
 Tue, 14 Oct 2025 08:40:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 14 Oct 2025 08:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760445656; x=
 1760532056; bh=OPCTkIemcIvX5KLzOpAqiVUD0gq930iqNCbK44namI4=; b=T
 AWseRmfya1EWPhxxzQh4RVa3BvzNvFAGgTX7yTzQnXvgcbwfzgOqMC58xGXUR98C
 ysQAaGR5Nq5RHHevirYwHXVH23RBnsAulpmIVPw97ER/lVMQq9KLNLGnAAetSfNG
 7FPwn4Z5TcLNyUjg9l17+NQlYPcN+l9DEGBac3DimDW/DK7vxwfKiga8jXZv6Oga
 lot4BP/zsF9wp+iLrnSzZ/izsl6UBqQSkVFT6VlIFhd/BVQuaJe7jK5gt0/SAIPj
 Mj5s/74EVKbg0m8dLEq+F1UbVs5RrPPgAZ6tgoz7oa1f9AXtaw8cyJGGdkDwtA2J
 M5uG1LkDGztcEm8nwnRWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760445656; x=1760532056; bh=O
 PCTkIemcIvX5KLzOpAqiVUD0gq930iqNCbK44namI4=; b=Ho1AJlxmtlM7IRZ18
 K2CmvSN2eWoRcsIObhTqSlTT0QzAoZITzLuQo/cy2pns0VObTKtI6IQNPn2t66MZ
 cGY+EG6XdLx2hEwtRTxh6JSopHeKvbi1B8S+TxmJq5SXaWtlB13BgbtIgrNwukkM
 hzGyWKRlPf5f5AVVGFtXetyi+p+/lNFapO1RAvFIp2KJoI9Gys+LZOM26Hve3Fx+
 FvM66GLVKAiyEgFiIUbDRiH4yTXwrhzxBx3jcqEJMlC/QLzsepZyqo9QjZJXMFzQ
 HH/ISD/UWzmsVk133F5U6iUmUgocWzE5oLhN6q1XvZtVqDiZQROaQ7sigYI5wuNh
 Q3Dhg==
X-ME-Sender: <xms:2ETuaKHKpX7faQKK7jRYBhbVahU0qzFSUi6LdXAkOzQk4mQRpcLWUQ>
 <xme:2ETuaERGDE_OauRXYjvXgU8RPrzeY4Hyq3rFlPicHzZCDO6Y7dIw_y3mqnxr_l43P
 eabu5WDF_CRksha4SqRrHIxbi8TvABD7XtakkPp8ajdMusQWiC1fQ>
X-ME-Received: <xmr:2ETuaPtKRMQIlAeD7h_do2iFJmB59cuubVR4mW67LHfLWT1FgC2wlcBhJ6GjYCBwSdW8aHqx2eZ3NU7RbUAEMBdzs8lAeBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtheeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:2ETuaEKwRq3ecNGPjUhF8CAoaUmnbLkjcMne3dBUyJcegYGDq_TXVA>
 <xmx:2ETuaMmyD0twy3GoVMZR7QDEniK6HFECQ7k29igDRG8-3yQ8dmlIcA>
 <xmx:2ETuaFIliRN1rAT7CPTDA7akeW0AORFfkVFyalbyVtkSSkt3SJm8gw>
 <xmx:2ETuaB5f-nIVIC8UsSd499hfC9OtSngWdLit_YsEFooM7MlmtQ2vUA>
 <xmx:2ETuaO7BVo3m_m3Af1wFII4rpRn5gXYXFCk5B2pSYw7cUk7UzklRg2kk>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 08:40:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v6 1/7] doc: explain debug options in mbuf guide
Date: Tue, 14 Oct 2025 14:33:34 +0200
Message-ID: <20251014124046.1032293-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014124046.1032293-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014124046.1032293-1-thomas@monjalon.net>
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

Mention RTE_LIBRTE_MBUF_DEBUG and RTE_ENABLE_ASSERT
which enable many debug checks in the mbuf library.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/prog_guide/mbuf_lib.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/mbuf_lib.rst b/doc/guides/prog_guide/mbuf_lib.rst
index 4ad2a21f3f..badc0f3501 100644
--- a/doc/guides/prog_guide/mbuf_lib.rst
+++ b/doc/guides/prog_guide/mbuf_lib.rst
@@ -266,8 +266,13 @@ can be found in several of the sample applications, for example, the IPv4 Multic
 Debug
 -----
 
-In debug mode, the functions of the mbuf library perform sanity checks before any operation (such as, buffer corruption,
-bad type, and so on).
+When ``RTE_LIBRTE_MBUF_DEBUG`` is enabled at compilation,
+some major mbuf operations (clone, copy, freeing)
+perform sanity checks (such as buffer corruption, bad type, and so on).
+
+When ``RTE_ENABLE_ASSERT`` is enabled,
+more basic checks are done in many functions.
+
 
 Use Cases
 ---------
-- 
2.51.0

