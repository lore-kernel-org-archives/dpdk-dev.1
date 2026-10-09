Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43750CA601F
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 19:34:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8626402DD;
	Fri,  9 Oct 2026 21:34:43 +0200 (CEST)
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net
 [51.250.60.160]) by mails.dpdk.org (Postfix) with ESMTP id C80014026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 21:34:41 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:2224:0:640:a699:0])
 by forward100d.mail.yandex.net (postfix) with ESMTPS id C76F0C7C7E;
 Fri, 09 Oct 2026 22:34:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id VYV8GXad4Sw0-Mj5teS5d; 
 Fri, 09 Oct 2026 22:34:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791574479; bh=6Oyx994Lk4XLAIBy5o+6Tl8coNqicH+3734Yxkvy+90=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=TmJTAQnrgN72LHvtrMBMD9yHuUVwlDc0G8phCZICw6phAO+TRqrRffg0UAP6GhpNY
 FBHREV0QmUtRLoMA2axsu5r79doewdVM9eVTNEbO1Tjf47dV0lhE8OZSFiKlVdwamr
 sSuclfIRpJNcLkblNys3hOvINrhYNvSuTG6zt1K4=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: stephen@networkplumber.org
Subject: [PATCH 1/2] ethdev: decode newer SFF compliance codes
Date: Fri,  9 Oct 2026 21:34:26 +0200
Message-ID: <835d139c746faff456f14755b7af7395b713bd70.1791574390.git.roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
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

Decode the compliance codes added by SFF-8472 Rev 12.5a and
SFF-8636 Rev 2.12, as ethtool does since commits 057c4fd and
75d6232:

- SFF-8472 byte 10: Fibre Channel 1600 and 3200 MBytes/s.
- SFF-8636 byte 133: SAS 24.0G, and SAS 12.0G which was defined
  but not reported.
- SFF-8636 byte 138: Fibre Channel 3200 MBytes/s.

Also decode the SFF-8472 Fibre Channel Speed 2 byte 62 (64GFC),
which byte 10 bit 1 refers to. ethtool does not decode it.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
Checked against the SFF-8472 Rev 12.5a (Table 5-3) and SFF-8636
Rev 2.12 (Table 6-17) specifications. Based on next-net/for-main.

 lib/ethdev/sff_8079.c | 7 +++++++
 lib/ethdev/sff_8636.c | 6 ++++++
 lib/ethdev/sff_8636.h | 2 ++
 3 files changed, 15 insertions(+)

diff --git a/lib/ethdev/sff_8079.c b/lib/ethdev/sff_8079.c
index 9632a26af3..5ca13eb368 100644
--- a/lib/ethdev/sff_8079.c
+++ b/lib/ethdev/sff_8079.c
@@ -173,10 +173,17 @@ static void sff_8079_show_transceiver(const uint8_t *data, struct sff_output *d)
 		sff_output_field(d, name, "FC: 1200 MBytes/sec");
 	if (data[10] & (1 << 6))
 		sff_output_field(d, name, "FC: 800 MBytes/sec");
+	if (data[10] & (1 << 5))
+		sff_output_field(d, name, "FC: 1600 MBytes/sec");
 	if (data[10] & (1 << 4))
 		sff_output_field(d, name, "FC: 400 MBytes/sec");
+	if (data[10] & (1 << 3))
+		sff_output_field(d, name, "FC: 3200 MBytes/sec");
 	if (data[10] & (1 << 2))
 		sff_output_field(d, name, "FC: 200 MBytes/sec");
+	/* bit 1 refers to the Fibre Channel Speed 2 byte */
+	if ((data[10] & (1 << 1)) && (data[62] & (1 << 0)))
+		sff_output_field(d, name, "FC: 64GFC");
 	if (data[10] & (1 << 0))
 		sff_output_field(d, name, "FC: 100 MBytes/sec");
 
diff --git a/lib/ethdev/sff_8636.c b/lib/ethdev/sff_8636.c
index ad36927540..5e77f1b855 100644
--- a/lib/ethdev/sff_8636.c
+++ b/lib/ethdev/sff_8636.c
@@ -364,6 +364,10 @@ static void sff_8636_show_transceiver(const uint8_t *data, struct sff_output *d)
 		sff_output_field(d, name, "SONET: OC-48, short reach");
 
 	/* SAS/SATA Compliance Codes */
+	if (data[SFF_8636_SAS_COMP_OFFSET] & SFF_8636_SAS_24G)
+		sff_output_field(d, name, "SAS 24.0G");
+	if (data[SFF_8636_SAS_COMP_OFFSET] & SFF_8636_SAS_12G)
+		sff_output_field(d, name, "SAS 12.0G");
 	if (data[SFF_8636_SAS_COMP_OFFSET] & SFF_8636_SAS_6G)
 		sff_output_field(d, name, "SAS 6.0G");
 	if (data[SFF_8636_SAS_COMP_OFFSET] & SFF_8636_SAS_3G)
@@ -432,6 +436,8 @@ static void sff_8636_show_transceiver(const uint8_t *data, struct sff_output *d)
 		sff_output_field(d, name, "FC: 1600 MBytes/sec");
 	if (data[SFF_8636_FC_SPEED_OFFSET] & SFF_8636_FC_SPEED_400_MBPS)
 		sff_output_field(d, name, "FC: 400 MBytes/sec");
+	if (data[SFF_8636_FC_SPEED_OFFSET] & SFF_8636_FC_SPEED_3200_MBPS)
+		sff_output_field(d, name, "FC: 3200 MBytes/sec");
 	if (data[SFF_8636_FC_SPEED_OFFSET] & SFF_8636_FC_SPEED_200_MBPS)
 		sff_output_field(d, name, "FC: 200 MBytes/sec");
 	if (data[SFF_8636_FC_SPEED_OFFSET] & SFF_8636_FC_SPEED_100_MBPS)
diff --git a/lib/ethdev/sff_8636.h b/lib/ethdev/sff_8636.h
index d2a923a7c0..9b15636c0c 100644
--- a/lib/ethdev/sff_8636.h
+++ b/lib/ethdev/sff_8636.h
@@ -294,6 +294,7 @@
 
 /* SAS/SATA Complaince Codes - 133 */
 #define	SFF_8636_SAS_COMP_OFFSET		0x85
+#define	SFF_8636_SAS_24G			RTE_BIT32(7)
 #define	SFF_8636_SAS_12G			RTE_BIT32(6)
 #define	SFF_8636_SAS_6G				RTE_BIT32(5)
 #define	SFF_8636_SAS_3G				RTE_BIT32(4)
@@ -346,6 +347,7 @@
 #define	SFF_8636_FC_SPEED_800_MBPS		RTE_BIT32(6)
 #define	SFF_8636_FC_SPEED_1600_MBPS		RTE_BIT32(5)
 #define	SFF_8636_FC_SPEED_400_MBPS		RTE_BIT32(4)
+#define	SFF_8636_FC_SPEED_3200_MBPS		RTE_BIT32(3)
 #define	SFF_8636_FC_SPEED_200_MBPS		RTE_BIT32(2)
 #define	SFF_8636_FC_SPEED_100_MBPS		RTE_BIT32(0)
 
-- 
2.47.3

