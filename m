Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A7FCA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:43:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0087640A7D;
	Sat, 10 Oct 2026 20:43:06 +0200 (CEST)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTP id D7103400D7
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:43:03 +0200 (CEST)
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d502])
 by forward500d.mail.yandex.net (postfix) with ESMTPS id 6325F84810;
 Sat, 10 Oct 2026 21:43:02 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:4c9f:0:640:5657:0])
 by forward502a.mail.yandex.net (postfix) with ESMTPS id 46F5880730;
 Sat, 10 Oct 2026 21:43:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id tgVL9mshaCg0-3d1K69jR; 
 Sat, 10 Oct 2026 21:43:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791657782; bh=N1qWUJQyOJg2aGONJjLKzy8gjZlcbR/CJ40JEkjqPCk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=K11g+4cJchNie9x8tE4gLZI6u/8Dzhra4Aq7Kmb1/vPsIeBukx2vdOgLj6BeyBQeQ
 /DxKk0EgZDl8TEvD6FdDC8T4wkJGLBr/LruxlUuRAU+nk2heWDgiONrGOs+Icmv+Iy
 OHDNl0kR3Vdse4FpAkjpt+q8AS8KU4CNABfGfyVI=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: stephen@networkplumber.org
Subject: [PATCH v2 1/2] ethdev: decode newer SFF compliance codes
Date: Sat, 10 Oct 2026 20:42:51 +0200
Message-ID: <ad3f2461bfd381b35d39988d18057be6a7427052.1791657558.git.roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <835d139c746faff456f14755b7af7395b713bd70.1791574390.git.roma55592@yandex.ru>
References: <835d139c746faff456f14755b7af7395b713bd70.1791574390.git.roma55592@yandex.ru>
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
SFF-8636 Rev 2.12, as ethtool does since its commits
057c4fdd85b5 ("sfpid: add support for newer SFF-8472 compliance codes")
and 75d62323302b ("qsfp: add support for newer SFF-8636 compliance codes"):

- SFF-8472 byte 10: Fibre Channel 1600 and 3200 MBytes/s.
- SFF-8636 byte 133: SAS 24.0G, and SAS 12.0G which was defined
  but not reported.
- SFF-8636 byte 138: Fibre Channel 3200 MBytes/s.

Also decode the SFF-8472 Fibre Channel Speed 2 byte 62, which byte 10
bit 1 refers to: 64GFC, reported as 6400 MBytes/s like the other
Fibre Channel speeds. ethtool does not decode it.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
v2:
- report 64GFC as "FC: 6400 MBytes/sec", like the other
  Fibre Channel speeds
- refer to the ethtool commits with 12 character hashes
  and their subjects
- 2/2: set one bit at a time in the tests and check that
  the other code of the same byte is absent

Checked against SFF-8472 Rev 12.5a (Table 5-3) and SFF-8636
Rev 2.12 (Table 6-17). Based on next-net/for-main.

 lib/ethdev/sff_8079.c | 7 +++++++
 lib/ethdev/sff_8636.c | 6 ++++++
 lib/ethdev/sff_8636.h | 2 ++
 3 files changed, 15 insertions(+)

diff --git a/lib/ethdev/sff_8079.c b/lib/ethdev/sff_8079.c
index 9632a26af3..c8db5c0975 100644
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
+		sff_output_field(d, name, "FC: 6400 MBytes/sec");
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

