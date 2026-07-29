Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DF9C54F51
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 10:32:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B94534026D;
	Wed, 29 Jul 2026 12:32:42 +0200 (CEST)
Received: from mx0b-003cac02.pphosted.com (mx0b-003cac02.pphosted.com
 [205.220.181.234])
 by mails.dpdk.org (Postfix) with ESMTP id 459F140269;
 Wed, 29 Jul 2026 12:32:41 +0200 (CEST)
Received: from pps.filterd (m0314250.ppops.net [127.0.0.1])
 by mx0b-003cac02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T81MXt3354840; Wed, 29 Jul 2026 10:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=keysight-0815; bh=XrAZQAf0nwJXZXAAataSpVeUewgPae/
 jRcPoRyZU1+k=; b=u1K9fGepG41PNZfl+Fp22aBzax8j98+0QxrgaXqMViYZpCz
 ItR2Gsr4S1iovy4hd2hbrLFuvI72VU43OS+dMw0B7DADi6hhGsS7DlZxFPFs+wxP
 GMpgLumVyXlIFuUX0oTfSnpEl4YyxvZuSyHaJmTUWQCkAf66uCTs+DENoup6neSx
 4kXOlo+Qe3bsNHbAaYn5oaM5VqsMBbFNGz0T6KgO3NM5mjsUJpDPpUqfSDyYavAt
 aDsVRSuXlhNaolyaQK8Bq51LzYUoYdHPlwy+Y7ceNP++RDX7dfdLJKv2+5k609wc
 c2oHjSIC6Q9hMFFczq7dbxhC899rcvagqp66eEQ==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-003cac02.pphosted.com (PPS) with ESMTPS id 4fn9x5wpjw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
 Wed, 29 Jul 2026 10:32:40 +0000 (GMT)
Received: from ppserconnector3.cos.dmz.keysight.com ([192.25.5.34])
 by cmsmtp with ESMTPSA
 id p1ZkwPio2VWzXp1aawEyxT; Wed, 29 Jul 2026 10:32:40 +0000
X-Mailer: SER-9da617c0781f77b24d454c2ffca1e7acced358b813e950646219cc1f5ae32690
X-Cloudmark-MID: p1ZkwPio2VWzXp1aawEyxT
pfptstatus: 1568ac97-559f-432f-801f-22d134b402f7@pfpt
X-Proofpoint-CID: 3612b050-454b-3384-9099-49ecf78b7412
Received: from eda-dev1.buh.is.keysight.com ([10.38.132.129])
 by ppserconnector3.cos.dmz.keysight.com with ESMTP
 id p1aYw4OEwzt35p1aYw9Pij; Wed, 29 Jul 2026 10:32:40 +0000
ser_con_authuser: ??
From: Dragos Tarcatu <dragos.tarcatu@keysight.com>
To: dev@dpdk.org
Cc: skori@marvell.com, pbhagavatula@marvell.com, stable@dpdk.org,
 Dragos Tarcatu <dragos.tarcatu@keysight.com>
Subject: [PATCH] examples/l2fwd-event: fix memset of port statistics array
Date: Wed, 29 Jul 2026 10:32:36 +0000
Message-Id: <20260729103236.3878391-1-dragos.tarcatu@keysight.com>
X-Mailer: git-send-email 2.34.1
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

port_stats is declared as struct l2fwd_port_statistics[RTE_MAX_ETHPORTS],
but the memset passed sizeof(struct l2fwd_port_statistics) -- the size
of a single element -- leaving ports 1 through RTE_MAX_ETHPORTS-1 with
uninitialized stats. Use sizeof(rsrc->port_stats) to clear the whole
array regardless of RTE_MAX_ETHPORTS.

Surfaced as a -Wmemset-elt-size warning when building with
-Dmax_ethports=64 -Dexamples=all.

Fixes: 4ff457986f76 ("examples/l2fwd-event: add default poll mode routines")
Cc: stable@dpdk.org

Signed-off-by: Dragos Tarcatu <dragos.tarcatu@keysight.com>
---
 examples/l2fwd-event/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/examples/l2fwd-event/main.c b/examples/l2fwd-event/main.c
index 2d31d4c6ad..eff2bee503 100644
--- a/examples/l2fwd-event/main.c
+++ b/examples/l2fwd-event/main.c
@@ -696,8 +696,7 @@ main(int argc, char **argv)
 		l2fwd_poll_resource_setup(rsrc);
 
 	/* initialize port stats */
-	memset(&rsrc->port_stats, 0,
-					sizeof(struct l2fwd_port_statistics));
+	memset(rsrc->port_stats, 0, sizeof(rsrc->port_stats));
 
 	/* All settings are done. Now enable eth devices */
 	RTE_ETH_FOREACH_DEV(port_id) {
-- 
2.34.1

