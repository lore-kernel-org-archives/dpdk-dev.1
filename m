Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0D7FA1FDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 18:35:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E04840647;
	Wed, 22 Apr 2026 20:35:52 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by mails.dpdk.org (Postfix) with ESMTP id 4327A402B5;
 Wed, 22 Apr 2026 20:35:51 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MGMFPH3107426; Wed, 22 Apr 2026 18:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=qM8ey30hyYmmyzrqncxH4O6OpP2vEBygBM6d1sTSL
 DQ=; b=S85dK9xppRnZJFZFpOLNOJQZXBSZP+S2JHXv5JdJMhxkpGYM+ANqqNqaQ
 SCKnAQ4dMh3QWP6IgdIDz8sMh4jpzOIL6NsiocTUHTzQ1prosqggc4xwKPwl4tWS
 5M1jwgTjoGkFEnKIxklSTOr2a2VnY4O0SK+lS7QFdDQDNfWGOGgfmYemrR2xqq84
 wC1+CumU+kZDx98AxWJA6QyFmlDANoQcFR2zqpsKL9wQs2h/vBsL/cZtwH499YPJ
 iDunf3wKwdFlCBTwxoXdBbtCcpuGN6trhqH8CNC4RUokbDU8tZ7n2VbnJTrDAjex
 h0HJc53LyS4ExzxizILyFYmEATQqw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6cqmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 18:35:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MIZIDM020346;
 Wed, 22 Apr 2026 18:35:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxuf2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 18:35:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63MIZkHh31589094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Apr 2026 18:35:46 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3371558053;
 Wed, 22 Apr 2026 18:35:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBFEA58043;
 Wed, 22 Apr 2026 18:35:45 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.atx-us.ibm.com (unknown
 [9.16.58.171]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Apr 2026 18:35:45 +0000 (GMT)
From: Riley Fletcher <rileyf@linux.ibm.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, patrickrobb1997@gmail.com, Luca.Vizzarro@arm.com,
 Riley Fletcher <rileyf@linux.ibm.com>
Subject: [PATCH v2] dts: fix port info getter when port is not found
Date: Wed, 22 Apr 2026 13:35:24 -0500
Message-ID: <20260422183524.2012369-1-rileyf@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3NyBTYWx0ZWRfX5SsVc63fdY8G
 G8hTnL/VAzsDpaXMPTigPFe7bhC7pYe/+y5eAK4e6/8rWJrYSSxfMB1fmuav+8zAJg+fnQWeYMO
 /Xl8ES08rMnR/s4vISvbLFI24mfCW7wnUHo2+cd+v9OZBZaxHNEh6uuAzT9HMpar7qjtEDCDTrA
 WDtrbjgWQbgzsXEK1AA/DTmKGgIcdvw5xM8Ur7ZZPEw1EZn+RyOV38ZclJiC3X+pS5ycaIi/f1W
 k6AaKGTPz/P1xulhDGJgBLm5A3/0eXJjCAlZ5iTnpls50B+0NQnIhCKD2J6fUH3CuXJnj2lzx1e
 v3WZJdCc/96KdxNbxbOa6RwGD8T7ph/ACewr1KWPWojoa7zFSXMO1PqumCvz+l0kWtyaioF5xV1
 /WWwt7A49hrZqFcSlXNkFPQlEe18AYnI/tRn+Uz1Ka53VTs7NsOQ4oGDO+7w3+j6XR7ulypocQC
 el900/cZjf6uHEed5oQ==
X-Proofpoint-ORIG-GUID: TYCwKqoh0ebUtKcNYajX-JfB6-UWNFWW
X-Proofpoint-GUID: Oz2jfc2Vq8IqU-nREGkvfw_g8dK7nOxu
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69e91504 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=8rWy6zfcAAAA:8 a=VnNF1IyMAAAA:8
 a=Pi44RHbeux0Oy0Td5_UA:9 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220177
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

In DTS, when providing an nonexisting PCI address, a ConfigurationError
should be thrown. Instead, because the next() is not given a default
None, it instead hits a StopIteration error, which is harder to debug.

Fixes: 0a210d88c36 ("dts: improve port model")
Cc: stable@dpdk.org
Signed-off-by: Riley Fletcher <rileyf@linux.ibm.com>
---
 dts/framework/testbed_model/linux_session.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index ee943462c2..3de92b549e 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -168,7 +168,7 @@ def get_port_info(self, pci_address: str) -> PortInfo:
             ConfigurationError: If the port could not be found.
         """
         bus_info = f"pci@{pci_address}"
-        port = next(port for port in self._lshw_net_info if port.get("businfo") == bus_info)
+        port = next((port for port in self._lshw_net_info if port.get("businfo") == bus_info), None)
         if port is None:
             raise ConfigurationError(f"Port {pci_address} could not be found on the node.")
 
-- 
2.53.0

