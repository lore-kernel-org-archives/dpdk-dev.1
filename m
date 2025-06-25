Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B85C7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 13:42:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 344D1402E0;
	Wed, 25 Jun 2025 15:42:19 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 5BB58402B9
 for <dev@dpdk.org>; Wed, 25 Jun 2025 15:42:18 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E627F1400073;
 Wed, 25 Jun 2025 09:42:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 25 Jun 2025 09:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1750858937; x=1750945337; bh=5/V/DT2rvTO6MG25SGDJE
 /SfWT9UsxyV1UiWr82Qe+M=; b=x08yZcWgH5V+SCghtUzkTVARnvTme+mw7vob/
 cuNHpAkmAxeYzHeU9rfKUljP2B/Mj0gmUzjHQLaaB3hakWatSYx9fNO1m47Mge5w
 AzOJh5mKAnLiKtmKBKblrbnm5710eB51pAMx5LWotZDVUEOv4WSiJ6rk4i52y7Ux
 +3SkB5Sb6ZW1Kcfdn3553USe7O6FF3ZRGNz1GqPPcZQFl6tegNIjEGqATuwRYa5m
 r1V1Jds/iVwTwWJOOcoRkxbe4iaDM/Zv/Gz/YJyTHloGfsmovwyl/NCJr6vJ8HYO
 2Qml7jr78q7rtuSLkfiZnOqlMVnnfpDOjEB4sTBzrYlfyAV7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1750858937; x=1750945337; bh=5/V/DT2rvTO6MG25SGDJE/SfWT9UsxyV1Ui
 Wr82Qe+M=; b=KoWOrM760lFoiio5uh8h8JQOW4pbnI383EG0xBLRIBBDJkCt9PJ
 F8CV5pWAz3MEQDEMyQVMnEl0sVY5deOQ1rmzXRaVnaWmZxc+hVjFOShSh31gkfMT
 VyPmP31S6lD/pMr4c/C2QSn4LEYbM7BKP+gdMhJCUG6gvTpBj3T+o3tREIpxS+PS
 xoAubs8qSr4dixXkTN1ALp8TXoGh6eV3OhYOxZaBeMzOSi4xi5kapNxgJpn/ZSYp
 d4ihTBVxuR0ivycgHDZx5qWhkZp8QTNCh7J5of25skqFsnQsOQ3+LrkUivbXvOuf
 DMz3U7BwhO/4KPcLkBnikQbR5c77HUFv0jQ==
X-ME-Sender: <xms:ufxbaLS4JBNWDtMzUZSTqhv2h4iEHO9Q3rnks9G29Mb3dUQqtzH6lA>
 <xme:ufxbaMx4esoYNf0vy66NVBe4nTr35sjxZKoA_J62gGojMUuFkbBa0kxI7Xhkc55nx
 kNPUmjTwt46H9HRnQ>
X-ME-Received: <xmr:ufxbaA0PHXpqfkTSvPEFoWlxJA-xdUZREOhPRLIj7eT09HGb1opFAZh_WuTQQF_OXjoEtkmgleipRbIA7_wuHGtw8C0EgE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdelvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepveevfeevieeihfetudekgeekleeigeffueekveduteeuffeiudevteeiudek
 feelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoh
 epfhgvrhhruhhhrdihihhgihhtsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvgif
 rdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruh
X-ME-Proxy: <xmx:ufxbaLCCxIR9yBCDSyFngRBN02bjSmDysT4jtnZfxWfdrmI-aqwaIg>
 <xmx:ufxbaEiJmWucRUac4vJE1os6-ajGAH9ijvqc5nA0Y4ucEfRiJYRgNw>
 <xmx:ufxbaPq__EAchFEBHJ_WuJvit65Dh7GCYnZ0DvxyKkFzewcL2yfRgw>
 <xmx:ufxbaPjqLfktmZ-Bd8nd3ID4gPvgDZr-24Py5XL5Cd96l3hspKD-AA>
 <xmx:ufxbaJVJ1VvKa-Aio0Q4qc1dEq6Nks2N1kYqgDwLRS0sdI1BEgLHFHzk>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 09:42:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH] ethdev: sync ethtool link modes with Linux 6.15
Date: Wed, 25 Jun 2025 15:42:02 +0200
Message-ID: <20250625134202.3193570-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
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

Update ethtool link modes with new ones added in Linux 6.15.
These values won't change as they are part of the Linux uAPI.
Note: extracting them avoids to depend on a kernel version.

The parsing command is updated to generate padding
accordingly to the alignments in the DPDK source file.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/ethdev/ethdev_linux_ethtool.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/ethdev/ethdev_linux_ethtool.c b/lib/ethdev/ethdev_linux_ethtool.c
index ec42d3054a..f508cdba6c 100644
--- a/lib/ethdev/ethdev_linux_ethtool.c
+++ b/lib/ethdev/ethdev_linux_ethtool.c
@@ -17,8 +17,9 @@
  *
  * The array below is built from bit definitions with this shell command:
  *   sed -rn 's;.*(ETHTOOL_LINK_MODE_)([0-9]+)([0-9a-zA-Z_]*).*= *([0-9]*).*;'\
- *           '[\4] = \2, /\* \1\2\3 *\/;p' /usr/include/linux/ethtool.h |
- *   awk '/_Half_/{$3=$3+1","}1'
+ *           '[\4] \2 \1\2\3;p' /usr/include/linux/ethtool.h |
+ *   awk '/_Half_/{$2=$2+1}1' |
+ *   awk '{printf "\t%5s = %7s, /\* %s *\/\n", $1, $2, $3}'
  */
 static const uint32_t link_modes[] = {
 	  [0] =      11, /* ETHTOOL_LINK_MODE_10baseT_Half_BIT */
@@ -110,6 +111,25 @@ static const uint32_t link_modes[] = {
 	 [99] =      10, /* ETHTOOL_LINK_MODE_10baseT1S_Full_BIT */
 	[100] =      11, /* ETHTOOL_LINK_MODE_10baseT1S_Half_BIT */
 	[101] =      11, /* ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT */
+	[102] =      10, /* ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT */
+	[103] =  200000, /* ETHTOOL_LINK_MODE_200000baseCR_Full_BIT */
+	[104] =  200000, /* ETHTOOL_LINK_MODE_200000baseKR_Full_BIT */
+	[105] =  200000, /* ETHTOOL_LINK_MODE_200000baseDR_Full_BIT */
+	[106] =  200000, /* ETHTOOL_LINK_MODE_200000baseDR_2_Full_BIT */
+	[107] =  200000, /* ETHTOOL_LINK_MODE_200000baseSR_Full_BIT */
+	[108] =  200000, /* ETHTOOL_LINK_MODE_200000baseVR_Full_BIT */
+	[109] =  400000, /* ETHTOOL_LINK_MODE_400000baseCR2_Full_BIT */
+	[110] =  400000, /* ETHTOOL_LINK_MODE_400000baseKR2_Full_BIT */
+	[111] =  400000, /* ETHTOOL_LINK_MODE_400000baseDR2_Full_BIT */
+	[112] =  400000, /* ETHTOOL_LINK_MODE_400000baseDR2_2_Full_BIT */
+	[113] =  400000, /* ETHTOOL_LINK_MODE_400000baseSR2_Full_BIT */
+	[114] =  400000, /* ETHTOOL_LINK_MODE_400000baseVR2_Full_BIT */
+	[115] =  800000, /* ETHTOOL_LINK_MODE_800000baseCR4_Full_BIT */
+	[116] =  800000, /* ETHTOOL_LINK_MODE_800000baseKR4_Full_BIT */
+	[117] =  800000, /* ETHTOOL_LINK_MODE_800000baseDR4_Full_BIT */
+	[118] =  800000, /* ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT */
+	[119] =  800000, /* ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT */
+	[120] =  800000, /* ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT */
 };
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_link_speed_ethtool)
-- 
2.47.1

