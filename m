Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27156FEE4EE
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 17:56:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6423740DD8;
	Sat, 28 Feb 2026 18:56:16 +0100 (CET)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 3C01D40DD0
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:56:09 +0100 (CET)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-124a635476fso3717046c88.0
 for <dev@dpdk.org>; Sat, 28 Feb 2026 09:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772301368;
 x=1772906168; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1P0RRbMVeCQvabsE8mrBkQYkv6M81uLzDfvP9rW2zdU=;
 b=oLRxugh2psPv1HCQV6CttJCq8+kh2yFClUB0CsXReAdNHuPCfr6fmxzPKE+GUbPiEM
 lL94CrW5SAX2VotTs0x2dx1fRRCMsChSgsy/Pgq0LdFFeyxbYWZsQj5MKQYWtn0p2dTi
 qSHXP17MW0H7VbG7BYFbaE4dP/wJvfFMSdzvc/gpnaTpKFP27/6rCzN5iCBIaywpSYPL
 yFYLWek9Ti0mhXkao4nPQPiR6QK8oZmy4+GGkPtdMb3HNZQjFzngDpa6wAfE2eTBAonE
 F+ANRBqD5Q051xxEPMOZEKYFMIcvWn+5OvSml7UJGnY6DKmqn65ht/ChvT4mciwqtRkD
 pWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772301368; x=1772906168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1P0RRbMVeCQvabsE8mrBkQYkv6M81uLzDfvP9rW2zdU=;
 b=NXDGDl0o9A1+NwPeo4tqZV8aHwO+KFInwUiXJEQ9pcIXiKbi5xTCEdQdNVdlC4z7LA
 DN2cndVYfTGuK1mLLS1TGh4FpPvPu3GO5IjOvIalc9UnyTSdXRKE+FgIqOFROyFa/JsH
 v3HRkoj2pYcM5nNpLrqALcjlHtk6IjxCckPNZihfwB/sLYiaPipfTov8AeHuynnLpR/s
 XhvrWJOhYmlDTM4aOwRnik0xiKaA30MUF5ZRzRP1ilYENib3IJrStaeWWmEmAwsVd41o
 7ZVi4qHp5fMnxrF06Me/GJPWvtKqloxr74rIOTmEGSaj47PU0Vkxzo4vnJuDxJPkPgd2
 gJ9Q==
X-Gm-Message-State: AOJu0YztB5mCdXOO48XTBdXDsoevCD+lutUSMaGcn/KjgnJWZlQIT/p+
 O0cvD6ft2MLYCS7gLI/eUqMTfJ60KYM6+XEzzvlnKj3sRI9qeXk8E54WC29lN9bF6EGgm+9zw7e
 EUVus
X-Gm-Gg: ATEYQzyGw7abWn+LYZ26Gsf4BwA9Os+fiW2uTVHTQf4EPYEZDs7U+uy0LhmvmiHjwcr
 Ktw8rgcnRcjmx4x7qBeJf4lo0CVwzLvvtk1OKUCQpwahzQ8Y8TnnnL5xkOkI/IWFLq/sBMjwGSc
 91t0rjnvWiAKxvRG/NXnW2vH5icsEBLfFtJ/IobcKRDe5ciVSCYzI9VyWTRPrqEtwNkR1iju/cq
 NDNIAgpq/7E1tHEVwtuwFZoLsex38GfsPfNZY0vjrOv6/falxX12ih8GP3+YXpeFD7ro+pKyaD5
 1781UO5dLwydWsQHhY8Ec2gSCS0fKBcdeIoswj4aUz2dTAbTRs14itZuCQOyy8SwuJ93tT/MJhQ
 bra4pHWPGDamznCxCPCooL1fuMv1dUdxFFiIDbe+27vOUhB9odJQjG/YA1MPCelxD069GBaaXBx
 hyYj5ZOxC1i/WFkeueNa+SKTUf+spmpL2jcxQRgDoRbejxgaB+YAe/NyFW2lL13g==
X-Received: by 2002:a05:7022:6283:b0:124:9f67:6b6f with SMTP id
 a92af1059eb24-1278fbb1245mr2887384c88.20.1772301367994; 
 Sat, 28 Feb 2026 09:56:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdfb3f898asm824584eec.29.2026.02.28.09.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 09:56:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 5/5] test: add pcapng test for copy before open
Date: Sat, 28 Feb 2026 09:35:04 -0800
Message-ID: <20260228175601.585102-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228175601.585102-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260228175601.585102-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

If packets are copied before open is called, the timestamps
will be before the start of epoch. Add a test for this which
makes sure pcapng file is still valid.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 82 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 53b806833b..298bcbd31f 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -591,6 +591,87 @@ test_write_packets(void)
 	return -1;
 }
 
+static int
+test_write_before_open(void)
+{
+	char file_name[PATH_MAX] = "/tmp/pcapng_test_XXXXXX.pcapng";
+	struct dummy_mbuf mbfs;
+	struct rte_mbuf *clones[MAX_BURST];
+	rte_pcapng_t *pcapng = NULL;
+	int ret, tmp_fd, i;
+	unsigned int count = 8;
+	uint64_t now;
+	ssize_t len;
+
+	mbuf1_prepare(&mbfs);
+	mbuf1_resize(&mbfs, rte_rand_max(MAX_DATA_SIZE));
+
+	/* Copy packets BEFORE opening the pcapng file.
+	 * This exercises the negative TSC delta path in tsc_to_ns_epoch().
+	 */
+	for (i = 0; i < (int)count; i++) {
+		clones[i] = rte_pcapng_copy(port_id, 0, &mbfs.mb[0], mp,
+					    rte_pktmbuf_pkt_len(&mbfs.mb[0]),
+					    RTE_PCAPNG_DIRECTION_IN, NULL);
+		if (clones[i] == NULL) {
+			fprintf(stderr, "Cannot copy packet before open\n");
+			rte_pktmbuf_free_bulk(clones, i);
+			return -1;
+		}
+	}
+
+	/* Small delay so fdopen's tsc_base is measurably after the copies */
+	rte_delay_us_block(100);
+
+	now = current_timestamp();
+
+	tmp_fd = mkstemps(file_name, strlen(".pcapng"));
+	if (tmp_fd == -1) {
+		perror("mkstemps() failure");
+		rte_pktmbuf_free_bulk(clones, count);
+		return -1;
+	}
+
+	pcapng = rte_pcapng_fdopen(tmp_fd, NULL, NULL, "pcapng_preopen", NULL);
+	if (pcapng == NULL) {
+		fprintf(stderr, "rte_pcapng_fdopen failed\n");
+		close(tmp_fd);
+		rte_pktmbuf_free_bulk(clones, count);
+		return -1;
+	}
+
+	ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
+				       NULL, NULL, NULL);
+	if (ret < 0) {
+		fprintf(stderr, "can not add port %u\n", port_id);
+		goto fail;
+	}
+
+	/* Write the pre-captured packets — timestamps precede tsc_base */
+	len = rte_pcapng_write_packets(pcapng, clones, count);
+	rte_pktmbuf_free_bulk(clones, count);
+	if (len <= 0) {
+		fprintf(stderr, "Write of pre-open packets failed: %s\n",
+			rte_strerror(rte_errno));
+		goto fail;
+	}
+
+	rte_pcapng_close(pcapng);
+
+	/* Validate the file is parseable — timestamps should be
+	 * slightly before 'now' but still reasonable.
+	 */
+	ret = valid_pcapng_file(file_name, now - NS_PER_S, count);
+	if (ret == 0)
+		remove(file_name);
+
+	return ret;
+
+fail:
+	rte_pcapng_close(pcapng);
+	return -1;
+}
+
 static void
 test_cleanup(void)
 {
@@ -606,6 +687,7 @@ unit_test_suite test_pcapng_suite  = {
 	.unit_test_cases = {
 		TEST_CASE(test_add_interface),
 		TEST_CASE(test_write_packets),
+		TEST_CASE(test_write_before_open),
 		TEST_CASES_END()
 	}
 };
-- 
2.51.0

