Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244B8C5518F
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 08:13:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BF27402BB;
	Tue,  4 Aug 2026 10:13:35 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id A34E4400D7
 for <dev@dpdk.org>; Tue,  4 Aug 2026 10:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831214;
 bh=teHS2dnqDNxXUkc9ZFCK9vTTdZsR6nyQt4ZqwoxHaCA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JRgZFZ4p4/OgKqGvVj+mH9zC/n37ePmTAt1HARzkx66SmMRAsSwZ0ijZS1xvkxIye
 AT4CC/v/QAYa6jbkmGT4Xpq9rp3AssRLBSfS4JwddhBvQJWrr5C/OO1YtgLt/pIYJJ
 H1EzRB+XXXFiSyZqYCzdoP2Dt6S4wAZNQmvsrepWz9n4hCbNV4zH9TflffTklbpQke
 rJmE1nOX+DiEbhRZiT2rOx9WuNpxqoK3z3OWq33SkVHpDCbt3bNY8kvmXUJPDVLpGr
 keXgMsxzS0v8EtNenBAx56w/TEXRar+AOFd/YLC4GKNbV1416BFQddE1WWur0xyNnG
 shM/YvaDrAeoA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 57A6CF196
 for <dev@dpdk.org>; Tue,  4 Aug 2026 10:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831214;
 bh=teHS2dnqDNxXUkc9ZFCK9vTTdZsR6nyQt4ZqwoxHaCA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JRgZFZ4p4/OgKqGvVj+mH9zC/n37ePmTAt1HARzkx66SmMRAsSwZ0ijZS1xvkxIye
 AT4CC/v/QAYa6jbkmGT4Xpq9rp3AssRLBSfS4JwddhBvQJWrr5C/OO1YtgLt/pIYJJ
 H1EzRB+XXXFiSyZqYCzdoP2Dt6S4wAZNQmvsrepWz9n4hCbNV4zH9TflffTklbpQke
 rJmE1nOX+DiEbhRZiT2rOx9WuNpxqoK3z3OWq33SkVHpDCbt3bNY8kvmXUJPDVLpGr
 keXgMsxzS0v8EtNenBAx56w/TEXRar+AOFd/YLC4GKNbV1416BFQddE1WWur0xyNnG
 shM/YvaDrAeoA==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 38658F066; Tue,  4 Aug 2026 10:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831207;
 bh=teHS2dnqDNxXUkc9ZFCK9vTTdZsR6nyQt4ZqwoxHaCA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GvYhEuLJ41xuaorI90s1Ucp/MkQjQfgbb6Ia0IzOK4lBQppm2x6vlZf+Q1H8uXK4d
 eGwvDLHUqHyFosE3j0QHJx/UICrznBYO8LVvco16z16mkwJ8s6o12O7J4mAc4G6kTE
 qTgld9eE/ImBpjEntZD7Iz5lpD98PeO7x8wFRdabPAtsVjGXOSXhu6367E+fmMFsPo
 y4z4+ILfCsJeWrerBGx/SbveixM+M718EQ9Y3CnKQRYqWgskc469Q0XXJkwN7MlSrV
 wxGbgPeR3o+uUzhxb2m5xCrq1HMR0gIPmsj9KJQilqtDHyaJqlNv9Do1Gc3aotNmdH
 UNOyyfld6+7FQ==
Received: from isengard.friendlyfire.se (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 13EB1F054;
 Tue,  4 Aug 2026 10:13:27 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: stephen@networkplumber.org, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, sriram.yagnaraman@ericsson.com
Cc: dev@dpdk.org, bingz@nvidia.com, rasland@nvidia.com,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [RFC 3/5] net: add missing eCPRI message field values
Date: Tue,  4 Aug 2026 10:13:17 +0200
Message-ID: <20260804081319.1869087-4-hofors@lysator.liu.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804081319.1869087-1-hofors@lysator.liu.se>
References: <20260804081319.1869087-1-hofors@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Mattias Rönnblom <mattias.ronnblom@ericsson.com>

Only the Event Type values of the Event Indication message (type #7)
were defined. Add the values of the other message types, per eCPRI V2.0
tables 5, 6, 8 and 9: Read/Write and Req/Resp of Remote Memory Access
(type #4), Action Type of One-Way Delay Measurement (type #5) and Reset
Code Op of Remote Reset (type #6).

The Action Type tells whether the TimeStamp and Compensation Value
fields carry time information, or are required to be zero.

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 lib/net/rte_ecpri.h | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/lib/net/rte_ecpri.h b/lib/net/rte_ecpri.h
index 6bacdbecc2..c147cb7b64 100644
--- a/lib/net/rte_ecpri.h
+++ b/lib/net/rte_ecpri.h
@@ -42,6 +42,55 @@
 #define RTE_ECPRI_MSG_TYPE_IWF_MAP	10
 #define RTE_ECPRI_MSG_TYPE_IWF_DCTRL	11
 
+/*
+ * Read/Write of Message Type #4: Remote Memory Access
+ * 0x0: Read
+ * 0x1: Write
+ * 0x2: Write_No_Resp
+ * 0x3...0xF: Reserved
+ */
+#define RTE_ECPRI_RM_ACC_RW_READ		0x0
+#define RTE_ECPRI_RM_ACC_RW_WRITE		0x1
+#define RTE_ECPRI_RM_ACC_RW_WRITE_NO_RSP	0x2
+
+/*
+ * Req/Resp of Message Type #4: Remote Memory Access
+ * 0x0: Request
+ * 0x1: Response
+ * 0x2: Failure
+ * 0x3...0xF: Reserved
+ */
+#define RTE_ECPRI_RM_ACC_RR_REQ			0x0
+#define RTE_ECPRI_RM_ACC_RR_RSP			0x1
+#define RTE_ECPRI_RM_ACC_RR_FAIL		0x2
+
+/*
+ * Action Type of Message Type #5: One-Way Delay Measurement
+ * 0x00: Request
+ * 0x01: Request with Follow_Up
+ * 0x02: Response
+ * 0x03: Remote Request
+ * 0x04: Remote Request with Follow_Up
+ * 0x05: Follow_Up
+ * 0x06...0xFF: Reserved
+ */
+#define RTE_ECPRI_DLY_MSR_ACT_REQ		0x00
+#define RTE_ECPRI_DLY_MSR_ACT_REQ_FUP		0x01
+#define RTE_ECPRI_DLY_MSR_ACT_RSP		0x02
+#define RTE_ECPRI_DLY_MSR_ACT_RMT_REQ		0x03
+#define RTE_ECPRI_DLY_MSR_ACT_RMT_REQ_FUP	0x04
+#define RTE_ECPRI_DLY_MSR_ACT_FUP		0x05
+
+/*
+ * Reset Code Op of Message Type #6: Remote Reset
+ * 0x00: Reserved
+ * 0x01: Remote reset request
+ * 0x02: Remote reset response
+ * 0x03...0xFF: Reserved
+ */
+#define RTE_ECPRI_RMT_RST_OP_REQ	0x01
+#define RTE_ECPRI_RMT_RST_OP_RSP	0x02
+
 /*
  * Event Type of Message Type #7: Event Indication
  * 0x00: Fault(s) Indication
-- 
2.43.0

