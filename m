Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B175BCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 07:38:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9C9440E38;
	Thu,  2 Apr 2026 09:38:17 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 1D2B340E28
 for <dev@dpdk.org>; Thu,  2 Apr 2026 09:38:15 +0200 (CEST)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6320uWVY2983565 for <dev@dpdk.org>; Thu, 2 Apr 2026 03:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=Y
 i5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=; b=bNdGTqj8YZNUqKqOy
 CGf61NtF/k4orkNF7zYBZAmt04DC6GxxjMDt9hEbL+2I72HR2VIt5vODtw7tcBrO
 NNOsLHq9ftz35A7pr+seE1gni/qdmkLxB9wELhUMKN4mieNr1KL5Q6hfU8NLWGiz
 mvULp1ZLDu9rcNew/s6Z7GhKdKpVcSq7JwGGa2i7zfx1cyiJaddsefsMo2MzBUXv
 y7q2meLkSyKE3jktjsGkwVmXa4w11aZarKlgz/KGrX83q8fP9wlCo3idKMLzP4SQ
 HGI3cGtg+GBkWbZ7rd807tQ/NtLh/Jk8JQ94o5OEIAjGJnsczf9zqRZrs0HzR5xX
 5FFvg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4d6b0dfeuq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 03:38:15 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6327ITtG1929896 for <dev@dpdk.org>; Thu, 2 Apr 2026 03:38:14 -0400
Received: from esapsmtplv04.us.dell.com (esapsmtplv04.us.dell.com
 [143.166.203.152])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4d9j689gpr-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 03:38:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775115494; x=1806651494;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yi5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=;
 b=evdvBMnIDFfOInNnqhwNQ7vWHOFaEDDRXlDKj8ehlys3+78p538gPTCp
 +XiMijXZg5GwQwqvf3e3OYub2M2fdZWnK5r7fWU16u8wCoVs3YMf4Z9y/
 58HvDJQk/qNi+M30DphankuTqo6GRYMmZvXDd2Fqp0hkwXQRxGB4zchgW
 FJMZBb0e2zeUkS4Dl0PanTVlbJPs8Uzpraqra0o+b1EUGxJQV3bvbjV7n
 z0dZp2X5W3ZA58ZfYS64ySJXsuYrvDgY1lFc4knD3frzuiTURt8zzvZNk
 sPoRoOd6NHOl30Sc//j2BLOLkZBVJCFOrKtlU0/v0ixe9Gml7qHe50p+t g==;
X-CSE-ConnectionGUID: GEsj/JqpT8OOn/IvUxc+2w==
X-CSE-MsgGUID: jaFZcNz2RViED+Qvi7Zxow==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv04.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 07:38:14 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 02:39:15 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 02:38:12 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 2 Apr 2026 02:38:12 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH 5/5] vhost_user: enable configure memory slots
Date: Thu, 2 Apr 2026 07:38:03 +0000
Message-ID: <20260402073803.3068147-6-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402073803.3068147-1-pravin.bathija@dell.com>
References: <20260402073803.3068147-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2NiBTYWx0ZWRfXxoWX7PyspUlW
 RbdRKplZvD6rGOBegWGxAdZ5DTRQahKWvYQv/tXySgogJIYvntbE3qcf5MC5mduT2/Yk3cJg2vg
 xehknuWmwNNKkwEqe5xmuFJj0jlP/8Hu85x90fiL/82hYcjkxbgmuE8BFdPa3EpR/l3mogNzmuv
 aZChL3/MpdGJAJ1zpsoZMrNYsbo8dFL4BzYwOTEPjXkQohanhsjEg9Mb6ptUTLDbvYrUT9/fMce
 AZsLn25Z30oGK7KIRn7SvyjYIVUyC9AfiMfH6J/36NnvUyWn/cBXYtWDLcmG8NUQcuwRWMgi6b7
 1SB5U+sSIWjPvec8atCFXX+i1DQa4X88r35G74gvOqixANDE4acPT+l37s2N5q1j1TLUR3o5KDc
 rapsrLaW7RVcg+hVQ9un1iBe4WDu3J36kKEeQw75TAriMMjEutdHJ22n/yGf0as4sbyJHaMWt6a
 1gUnFtcmsaFhxz/V9aw==
X-Proofpoint-ORIG-GUID: g2hmEoShXHBpHPjwMhPfrqrMj9YAFog3
X-Proofpoint-GUID: g2hmEoShXHBpHPjwMhPfrqrMj9YAFog3
X-Authority-Analysis: v=2.4 cv=Kd3fcAYD c=1 sm=1 tr=0 ts=69ce1ce7 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=XtseytAk/c9oG0Kwoj6KRQ==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=PpEg0BoV_A2aca28hXd0:22 a=iLNU1ar6AAAA:8
 a=-L3Ti0Wm1PsFXVv1eAcA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020066
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

From: Pravin M Bathija <pravin.bathija@dell.com>

This patch enables configure memory slots in the header define
VHOST_USER_PROTOCOL_FEATURES.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
index f8d921f7f1..5a0e747b58 100644
--- a/lib/vhost/vhost_user.h
+++ b/lib/vhost/vhost_user.h
@@ -32,6 +32,7 @@
 					 (1ULL << VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT) | \
+					 (1ULL << VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_STATUS))
 
 typedef enum VhostUserRequest {
-- 
2.43.0

