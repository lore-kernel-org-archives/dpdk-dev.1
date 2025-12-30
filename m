Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A226BEE4992
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 18:58:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F0094060A;
	Tue, 30 Dec 2025 19:58:46 +0100 (CET)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id B9E3940430
 for <dev@dpdk.org>; Tue, 30 Dec 2025 19:58:44 +0100 (CET)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-64b7b737eddso12804345a12.1
 for <dev@dpdk.org>; Tue, 30 Dec 2025 10:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767121124;
 x=1767725924; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xFDGIABKehAqUGpvyqmRaLuugurynesvxqL+XBLOsw=;
 b=hpuYROHF/jzuuenGRJtyi9hqeEgTY8zPMblNc7oeZXVplmUzsEUs/6krsUulUtverS
 y72TW32K0aUtskLi0hCrpcgneuAs2aGMCQWzI+ojPcExISXFihPyhaP2h0UoT/dueyfd
 SA6RG6rvfoHJZTDPupTCOtw9bz5VIfQuxI6RxgCp9M4taTqPx4k2kti2UpudZf9aPYyE
 1eEp3wl7rQ0O0VPmvQecjPtUDNhjC6xT+J5k7d2Ct722imAO+BwoRKzvXupRS5Q0yM9e
 1MHRvl1PIxOqgBRJvkfOwW1LRnuapCr1+KcW2ShYoGZCCbcUalyj7KI/L+aZr4WEO+0R
 L8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767121124; x=1767725924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4xFDGIABKehAqUGpvyqmRaLuugurynesvxqL+XBLOsw=;
 b=cAlUCJAegTwWb0ZOTi9DqXxj+1pFaxiGaSQaii98cR7iaYXAwXPBM8VR0hMApi66+4
 3RoRmQazi3tThsGOh6KB8AdJ8gp3qYK9hUSfDKM0p4oAGhxyaoVf1xq6s1XKnd7mgAIu
 4aPYllDtq/+momIwu7JeTJnh84FImbLOGwbm0qR+N1d1KAfPLNIq5FmEXxNU7T9874SF
 44r8ikMOv5cBCd6CGdODmkNqNaOfrUEhn42EAkLkbeD8626QXq68DPwOKTsee3SBeRHu
 C1J+sZAE2CLDnc2LNNgM6vg46Nlhny2mYl9u/iiu3DrJue38UUgL2c4Ny2xBZH8POnqw
 +jIw==
X-Gm-Message-State: AOJu0YwVRBoLqDShtpRWL4/eOBvcQuuT+sf9DBVlK6Z2OqfyDvQaNEyQ
 M1t0ePWqzvSK/kqUIZuGOt+Q9n5DQgV1epcTXBxoM/wYxSHStgHgDSjDXaGZRRBBpv57RPu37ay
 vdLYt46s=
X-Gm-Gg: AY/fxX73+lDnn54KUJPZLalLK28VUUa+ZyEY/rNWlQTBxFkUtjiH8IBFTIdOYu99OWi
 t6O/6UMEDJ+7aSaIY0r/ZhFGPr//qv0WNiXw/Hep3rLHjFHHghAC3yT+1gcrBrRaQGJZthg3V5q
 xIg1dHLs9iW/QaO2jB3WBvH1d4tI7OTJEaporNWobrFwxGA0UmryieoAssyaxLknJVPua7ftVeS
 E+Vgvb2OX2OILvwDw+ooaAXNYDCVMnO5OxuRJvh2cPGnPgfSJHOdePyiYmUalXRjlM+M/1eW7/7
 CW6B0exold1kRQ/CsOKaA16Dp6BoqXolrS7q4iizozdIKQerEwsjrysq0hcWJrivBJ69C+Ozdg5
 uYmJr6gnKrjMKPyUk3yoZ987xchpbB1uRpKXHR8MQhDTUhqfLMK1ThH3A98OYMdf8MOipCGlYSw
 7U8Dt7KfaPhkF2d23Gdx+ngeOEcI4MiBcTObTa5VChxslwf8zdLA==
X-Google-Smtp-Source: AGHT+IGTvZkwK5w9Dg3TOFsQzL6Fn+A9Vlo25qi+tEQN13120atW0gqxjucEJzix6/IdL5aTEtwYsg==
X-Received: by 2002:a17:907:3fa7:b0:b2a:10a3:7113 with SMTP id
 a640c23a62f3a-b8036f637e5mr3261740866b.29.1767121124185; 
 Tue, 30 Dec 2025 10:58:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de0de1sm3745449366b.40.2025.12.30.10.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 10:58:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 1/7] pcapng: use alloca instead of fixed buffer
Date: Tue, 30 Dec 2025 10:55:09 -0800
Message-ID: <20251230185837.301163-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230185837.301163-1-stephen@networkplumber.org>
References: <20251228184300.541639-1-stephen@networkplumber.org>
 <20251230185837.301163-1-stephen@networkplumber.org>
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

This is an API that accepts strings as options, and user could
potentially ask for very large string as comment.
The dynamic way to fix is to use alloca() to allocate the buffer
used to hold options.

Bugzilla ID: 1820

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 21bc94cea1..3067033e89 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -34,9 +34,6 @@
 /* conversion from DPDK speed to PCAPNG */
 #define PCAPNG_MBPS_SPEED 1000000ull
 
-/* upper bound for section, stats and interface blocks (in uint32_t) */
-#define PCAPNG_BLKSIZ	(2048 / sizeof(uint32_t))
-
 /* Format of the capture file handle */
 struct rte_pcapng {
 	int  outfd;		/* output file */
@@ -145,7 +142,7 @@ pcapng_section_block(rte_pcapng_t *self,
 {
 	struct pcapng_section_header *hdr;
 	struct pcapng_option *opt;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
 	uint32_t len;
 
 	len = sizeof(*hdr);
@@ -162,7 +159,8 @@ pcapng_section_block(rte_pcapng_t *self,
 	len += pcapng_optlen(0);
 	len += sizeof(uint32_t);
 
-	if (len > sizeof(buf))
+	buf = alloca(len);
+	if (buf == NULL)
 		return -1;
 
 	hdr = (struct pcapng_section_header *)buf;
@@ -214,7 +212,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	struct pcapng_option *opt;
 	const uint8_t tsresol = 9;	/* nanosecond resolution */
 	uint32_t len;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
 	char ifname_buf[IF_NAMESIZE];
 	char ifhw[256];
 	uint64_t speed = 0;
@@ -268,7 +266,8 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	len += pcapng_optlen(0);
 	len += sizeof(uint32_t);
 
-	if (len > sizeof(buf))
+	buf = alloca(len);
+	if (buf == NULL)
 		return -1;
 
 	hdr = (struct pcapng_interface_block *)buf;
@@ -333,7 +332,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	uint64_t start_time = self->offset_ns;
 	uint64_t sample_time;
 	uint32_t optlen, len;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -EINVAL);
 
@@ -353,7 +352,9 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 		optlen += pcapng_optlen(0);
 
 	len = sizeof(*hdr) + optlen + sizeof(uint32_t);
-	if (len > sizeof(buf))
+
+	buf = alloca(len);
+	if (buf == NULL)
 		return -1;
 
 	hdr = (struct pcapng_statistics *)buf;
-- 
2.51.0

