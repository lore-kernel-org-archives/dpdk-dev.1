Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7D2CCFA13
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 02:10:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74E544026D;
	Tue, 11 Nov 2025 03:10:44 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 8A2324026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 03:10:42 +0100 (CET)
X-QQ-mid: zesmtpgz3t1762827036tb8ea124c
X-QQ-Originating-IP: Ja7r3QTKD1jiBVGGh5fNcSUVpOIuRs5LvtittX8sqAs=
Received: from w-MS-7E16.trustnetic.com ( [125.120.180.10])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 11 Nov 2025 10:10:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12659123216012917558
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH] doc: update txgbe device arguments
Date: Tue, 11 Nov 2025 10:10:30 +0800
Message-ID: <2C5EFCCEEBEF9094+20251111021031.59350-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NBplAH1p/X/dcQPeegZ5TER+G/TlLEQAlgBsWMdRy9i6PjWAqfhvGZAm
 7fu1liWv2ZeVoZU7dg0SQeUXlOTU1mIGqqXUS720iVXALP+rIfOFpU9mKcbfgFDgBrwUbNJ
 Fbr0xLD9Ezz/7lc5BPg0aRh4AOpEt+3g5vV8eDWw8oEJS/TBLWJFpE3xMEXN4qBWp9/RNpM
 Ol5a9C/4Q1hB7fOdzxyRHH8mwcWcn8fDScVniNVRk4ZIZaJnls99ZB6Bp5SDdWDutXKD/SM
 xO6bxC+Sfwq+m0fGGtRrjVv4Fkx/avSdHkzy55VtK/4O5WDZePhgrX7RFqkHVMfyVYlNHFw
 W0uypSalB1w0+rwFXn/Ni76KJwtzPsiaX1zgSQrF+pWsYAdhxrjYmdbeyuY/ctQjVgxnQdI
 lXvi/i7OW7JHv3kZPmyAASARFqnWyLLToTg67Uc6ABer5mh36Ii7MxR8VhTkHMox06FX6do
 SQ3c547Igt77jIG9Y3TpKXrZw+89O3byNEISaVpXqo+XZfupF3PJcUgBDh8ozgFXxJM8od3
 pzCSU+2c4TugyM9sKNfCEXgI+StectTLf5ZbkPxHwEJ7tEtWD0k/3YurZuUZuJUUIRsG9ZS
 v0znITcUHWPDXJ7S/DEfQymuvANXHsdJDy0YuEU+nY90aiR94LOdPYjlCmAVj8UIipY5cJh
 HZyqWU/HHP5s1NZu9vBZ6JCBqpHDvIK+jrhh2ENDvQ1ftg1gHhGlRUDDr9fHPIbubdYAR3j
 7UiKGb1SANjQdhVBRvSBcxUuABEHsOxeUqnL0eTg0cRx6sjqKr8HRk1MKc30xSrhg27M1u0
 O9URaT1KacUFCk83v/RBaNFXJoUzzvNjS7zI5F2dEVwXiAzTsMydpZWayi0c8TkakODYUTH
 rD5AKmnCEupCe9s42waVUqz7UIrQN4B5hBX/l6PwbRmYCJ/vGNNnxX/Rq1waqZQb5tvyvjK
 WrvHO+9trrWedJDNxVTw1yIOdkzYH3MwaYqtsi4nukLkijHAYIZJAIRUG1KP0uuwz4JKYbf
 AH/bdQi8xd3XkoaDRFYeevvnvAEy7InApcQjjHCyGWaG0KEEDS7m4KUbHnhhv/uR3WwmS1Y
 w==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
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

Add new device arguments "pkt-filter-size" and "pkt-filter-drop-queue"
in txgbe driver.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 doc/guides/nics/txgbe.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index 953a43b139..ffd1e35085 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -147,6 +147,16 @@ Please note that following ``devargs`` are only set for backplane NICs.
   PHY parameter used for user debugging. Setting other values to
   take effect requires setting the ``ffe_set``.
 
+- ``pkt-filter-size`` (default **0**)
+
+  Memory allocation for the flow director filter.
+  Default 0 for 64K mode, set 1 for 128K mode, set 2 for 256K mode.
+
+ ``pkt-filter-drop-queue`` (default **127**)
+
+  The drop queue number for packets that match the drop rule in flow
+  director. Valid values are from 0 to 127.
+
 Please note that following ``devargs`` are only set for Amber-Lite NICs.
 
 - ``tx_headwb`` (default **1**)
-- 
2.48.1

