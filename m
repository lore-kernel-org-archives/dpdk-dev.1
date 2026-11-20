Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C752606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.a=rsa-sha256 header.s=mail202505 header.b=WfMg9ElP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB76A40653;
	Fri, 20 Nov 2026 11:13:21 +0100 (CET)
Received: from mx15.kaspersky-labs.com (mx15.kaspersky-labs.com
 [46.165.235.169])
 by mails.dpdk.org (Postfix) with ESMTPS id E489A40284;
 Fri, 20 Nov 2026 07:00:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1795154457;
 bh=ZeVpQHT+mj9J/z1bzoYV7zYROvcz97BTLTUwtEl4yS8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=WfMg9ElPldBB6+ppG+7BfgWTz1/AqRcpFfj7qfyWuNhbbrk2JYTiQEI+7oqpinQYu
 GEjepg758IWc3yPrikoyiXAjg2k9UO22yDfqtaghiZikXERXOLJzKOI42wp1by6tBY
 SDiUWGBVDq+9epFupj1+4QY80EzpzVPOHiHHMu8TglrLaRCcnuSfYjU+SDsOGYEnOz
 /Ehr1hSyzN1k7IQiQBo+CCg7bJSfxllr1aChW6lqfkVJTw4u1WdKPBfH2S0QLuANJY
 3Ksv9XqaGEpPFCN0QxXzI6f/aSyV8Zj9pEAwc+HpBisbZfaGhSKWDTJtkMI2R0T0zk
 vOqupBmRo7TZw==
Received: from relay15.kaspersky-labs.com (localhost [127.0.0.1])
 by relay15.kaspersky-labs.com (Postfix) with ESMTP id 57B55A8373;
 Fri, 20 Nov 2026 09:00:57 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub15.kaspersky-labs.com (Postfix) with ESMTPS id B483FA8377;
 Fri, 20 Nov 2026 09:00:56 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 09:00:55 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <cristian.dumitrescu@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>,
 Alexander Chesnokov<Alexander.Chesnokov@kaspersky.com>,
 <stephen@networkplumber.org>
Subject: [PATCH 1/2] sched: fix byte clock computation for extreme port rates
Date: Fri, 20 Nov 2026 09:00:43 +0300
Message-ID: <20261120060044.3252671-2-Alexander.Chesnokov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120060044.3252671-1-Alexander.Chesnokov@kaspersky.com>
References: <20261120060044.3252671-1-Alexander.Chesnokov@kaspersky.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/20/2026 05:54:05
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 207674 [Nov 20 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.27
X-KSE-AntiSpam-Info: Envelope from: Alexander.Chesnokov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 135 0.3.135
 58dcfca10e9e4d27990d8f7387f1467d65061802
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: chesnokov.avp.ru:7.1.1,5.0.1; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; kaspersky.com:7.1.1,5.0.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions_lk}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/20/2026 05:56:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/20/2026 3:47:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.1.0.9599,
 bases: 2026/11/20 03:41:00 #28939126
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
X-Mailman-Approved-At: Fri, 20 Nov 2026 11:13:15 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>

rte_sched_port_config() computes the port byte clock as

    cycles_per_byte = (rte_get_tsc_hz() << RTE_SCHED_TIME_SHIFT)
        / params->rate;

and passes the result to rte_reciprocal_value(). The parameter
check rejects rate == 0 only. For rate above
rte_get_tsc_hz() << RTE_SCHED_TIME_SHIFT the division yields 0
and rte_reciprocal_value() divides by zero in turn: with d == 0,
rte_fls_u32(d - 1) returns 32 and the following m /= d faults,
crashing the application with SIGFPE. For rate below
rte_get_tsc_hz() >> (32 - RTE_SCHED_TIME_SHIFT) the quotient
exceeds UINT32_MAX and is silently truncated when stored in the
uint32_t cycles_per_byte, corrupting the byte clock.

The byte clock cannot represent rates outside that range, so
configurations within it behave exactly as before.

Move the computation to a helper shared by the parameter check
and the port configuration, and reject configurations whose byte
clock value is zero or does not fit in 32 bits, so that
rte_sched_port_config() and rte_sched_port_get_memory_footprint()
fail cleanly instead of crashing or mis-scheduling.

Fixes: 03d00293ca76 ("sched: eliminate floating point in calculating byte clock")
Cc: stable@dpdk.org

Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
---

Cc: stephen@networkplumber.org

 lib/sched/rte_sched.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/sched/rte_sched.c b/lib/sched/rte_sched.c
index daa31e8b99..ef88df124e 100644
--- a/lib/sched/rte_sched.c
+++ b/lib/sched/rte_sched.c
@@ -436,10 +436,17 @@ subport_profile_check(struct rte_sched_subport_profile_params *params,
 	return 0;
 }
 
+static uint64_t
+rte_sched_port_cycles_per_byte(uint64_t rate)
+{
+	return (rte_get_tsc_hz() << RTE_SCHED_TIME_SHIFT) / rate;
+}
+
 static int
 rte_sched_port_check_params(struct rte_sched_port_params *params)
 {
 	uint32_t i;
+	uint64_t cycles_per_byte;
 
 	if (params == NULL) {
 		SCHED_LOG(ERR,
@@ -461,6 +468,15 @@ rte_sched_port_check_params(struct rte_sched_port_params *params)
 		return -EINVAL;
 	}
 
+	cycles_per_byte = rte_sched_port_cycles_per_byte(params->rate);
+	/* rate: the byte clock value must be non-zero and fit in 32 bits */
+	if (cycles_per_byte == 0 ||
+	    cycles_per_byte > UINT32_MAX) {
+		SCHED_LOG(ERR,
+			"%s: Incorrect value for rate", __func__);
+		return -EINVAL;
+	}
+
 	/* mtu */
 	if (params->mtu == 0) {
 		SCHED_LOG(ERR,
@@ -1006,8 +1022,7 @@ rte_sched_port_config(struct rte_sched_port_params *params)
 	/* Subport profile table */
 	rte_sched_port_config_subport_profile_table(port, params, port->rate);
 
-	cycles_per_byte = (rte_get_tsc_hz() << RTE_SCHED_TIME_SHIFT)
-		/ params->rate;
+	cycles_per_byte = rte_sched_port_cycles_per_byte(params->rate);
 	port->inv_cycles_per_byte = rte_reciprocal_value(cycles_per_byte);
 	port->cycles_per_byte = cycles_per_byte;
 
-- 
2.43.0

