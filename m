Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF96CC56204
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 14:53:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C67D4027B;
	Fri, 20 Feb 2026 15:53:46 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 2DA8E4026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 15:53:45 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 9117AEC04D7;
 Fri, 20 Feb 2026 09:53:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 20 Feb 2026 09:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1771599224; x=1771685624; bh=i++zZ+YJpUPQAflTu0/RV
 NZVbZXaqo3PhC8sUgVSUsw=; b=F2sN3HFxD4TQKn3Nvd+HfxS8O4qdZFnDdnBOW
 SWYMzUPV0F/UOOjvACKIXhfTqGlSpGjGih03o1jA+vxX7EVnkYqcqfhTNGH1z8QK
 1kQq8HJq6UjuKKNvBtG09SYeY1kHRkt9DS/esBOQ/yGkjw/sOAKTVqTa2AVgVo3d
 ttGP8vN/qIK8ibddlYJ/cpTcKvVMjc1du/kIw1FFnKWt0a/YdHW0f25oiQFMXFNq
 7R+yFLLL1wdiGHJ6/wsbUDLAssQWzOENewTTj3TedM7SzNIDjWEZUW1mkBdZ9KIT
 CqARXn/t+QuLc6SkPcgsJzGifb/zfGbyX5Z5WOsy82PUU24mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1771599224; x=1771685624; bh=i++zZ+YJpUPQAflTu0/RVNZVbZXaqo3PhC8
 sUgVSUsw=; b=aE1JhmV+IRhLzhdQv0QtbmnrFYvNI4hNsHqph1iDMDl/Xp2OMN+
 ThhmOsMMi0ku6Quh8m7TFoQo7eue4ZLn3r06b7DYYiu1lE/xXy0E2mVqDDAfrCPU
 6g6TYJi2MupEKKe8IWrfD5cAq2KlU8jViqrXdmk1LmT6gPl0/zyFXolrI2GFZWye
 ReYHh476alJtTUHPuSnGu01qIYhyHSfO5drnc8C4fRn1jTsCG/UxxBxrUCBEVLoV
 7p7tpApmYUiZaMZbKcI+B+GqLuf+6PPJs9uCtiR8lwn+TnzETaWuhI8RVTteeomJ
 njzEwxfFOAfVS0VtsqmF9SUU8NwNFyGrJKg==
X-ME-Sender: <xms:d3WYaTU4Yd3CFEgk0ePKMwYggyy5YyZbIogSQVPq0p8k6J2v8eU5sQ>
 <xme:d3WYad2QjmBJAcPDjG6nXv3nQpst3_koTMdT67tMQtlnZT6BASgTmwN7noMpV3I3U
 uL0tjBOJMEghYW82dNZqu-JyJGcfnx14XOOWYFem0qWS4jhKBhp4Q>
X-ME-Received: <xmr:d3WYaRoY2k-JezcuI2NFEOg8ZXbm6yQVyIiACIEvJCRIu5O2Nvuhrra5jnt-WpHCxS1BptizjM9O2CBe0Gvlj21eBbRensU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekjeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
 dtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhn
 jhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepveevfeevieeihfetudekgeekle
 eigeffueekveduteeuffeiudevteeiudekfeelnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvth
 dpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggv
 vhesughpughkrdhorhhgpdhrtghpthhtohepsgihrhhonhdrmhgrrhhohhhnsehinhhtvg
 hlrdgtohhmpdhrtghpthhtohepuggrvhhiugdrhhhunhhtsehinhhtvghlrdgtohhmpdhr
 tghpthhtoheplhgvvgdruggrlhihsehinhhtvghlrdgtohhmpdhrtghpthhtohepgihurg
 hniihihigrnhhgvdeshhhurgifvghirdgtohhmpdhrtghpthhtohepkhihohdrlhhiuhes
 nhgvsghulhgrqdhmrghtrhhigidrtghomhdprhgtphhtthhopehjrghvvghnpgiguhesrh
 gvrghlshhilhdrtghomhdrtghn
X-ME-Proxy: <xmx:d3WYaUUNK0S3WFgFFRuuVEYzEgKwzB4KdOwIupSO49Fvs9PvvJ8JkA>
 <xmx:d3WYacZ4kQ3RKcq3Dt34JsNMtMFkfH7Fn1V12fhr6jBFnBxABsVIdw>
 <xmx:d3WYaRewR9YJY14WBddZMqPx0rJeRYQghfjRrqtRcJVlx8_qHMXKcw>
 <xmx:d3WYaW3_yF9KNMN1EmvyuWmnpwExAXkNUb4LfzZepidU2nxoRMxwOQ>
 <xmx:eHWYaSDHyOS25aLm7AYMK52UHQzbNuZaC9hSZxPmKrm5qzKG2d6kOGLy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 09:53:42 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: byron.marohn@intel.com, david.hunt@intel.com, lee.daly@intel.com,
 xuanziyang2@huawei.com, kyo.liu@nebula-matrix.com, javen_xu@realsil.com.cn
Subject: [PATCH] maintainers: prune unreachable contacts
Date: Fri, 20 Feb 2026 15:53:26 +0100
Message-ID: <20260220145326.289338-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
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

Some email addresses are not responding to "RCPT TO".
Drop these maintainers as we cannot reach them.

Cc: byron.marohn@intel.com
Cc: david.hunt@intel.com
Cc: lee.daly@intel.com
Cc: xuanziyang2@huawei.com
Cc: kyo.liu@nebula-matrix.com
Cc: javen_xu@realsil.com.cn

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

---

This patch should confirm the email bounces.
If this is a mistake, please reply.
---
 MAINTAINERS | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b7a1e28c5a..2faf28f522 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -774,7 +774,6 @@ F: doc/guides/nics/hns3.rst
 F: doc/guides/nics/features/hns3.ini
 
 Huawei hinic
-M: Ziyang Xuan <xuanziyang2@huawei.com>
 M: Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
 F: drivers/net/hinic/
 F: doc/guides/nics/hinic.rst
@@ -1021,7 +1020,6 @@ F: doc/guides/nics/features/rnp.ini
 
 Nebulamatrix nbl
 M: Dimon Zhao <dimon.zhao@nebula-matrix.com>
-M: Kyo Liu <kyo.liu@nebula-matrix.com>
 M: Leon Yu <leon.yu@nebula-matrix.com>
 M: Sam Chen <sam.chen@nebula-matrix.com>
 F: drivers/net/nbl/
@@ -1032,7 +1030,6 @@ Realtek r8169
 M: Howard Wang <howard_wang@realsil.com.cn>
 M: Chunhao Lin <hau@realtek.com>
 M: Xing Wang <xing_wang@realsil.com.cn>
-M: Javen Xu <javen_xu@realsil.com.cn>
 F: drivers/net/r8169/
 F: doc/guides/nics/r8169.rst
 F: doc/guides/nics/features/r8169.ini
@@ -1331,7 +1328,6 @@ F: drivers/compress/qat/
 F: drivers/common/qat/
 
 ISA-L
-M: Lee Daly <lee.daly@intel.com>
 M: Pablo de Lara <pablo.de.lara.guarch@intel.com>
 F: drivers/compress/isal/
 F: doc/guides/compressdevs/isal.rst
@@ -1677,7 +1673,6 @@ F: doc/guides/prog_guide/pdcp_lib.rst
 F: app/test/test_pdcp*
 
 Distributor
-M: David Hunt <david.hunt@intel.com>
 F: lib/distributor/
 F: doc/guides/prog_guide/packet_distrib_lib.rst
 F: app/test/test_distributor*
@@ -1743,7 +1738,6 @@ F: app/test-acl/
 F: app/test/test_acl.*
 
 EFD
-M: Byron Marohn <byron.marohn@intel.com>
 M: Yipeng Wang <yipeng1.wang@intel.com>
 F: lib/efd/
 F: doc/guides/prog_guide/efd_lib.rst
@@ -1844,7 +1838,6 @@ F: doc/guides/prog_guide/ptr_compress_lib.rst
 
 Power management
 M: Anatoly Burakov <anatoly.burakov@intel.com>
-M: David Hunt <david.hunt@intel.com>
 M: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
 F: lib/power/
 F: doc/guides/prog_guide/power_man.rst
-- 
2.52.0

