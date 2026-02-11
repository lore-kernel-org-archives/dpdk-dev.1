Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5F9EA3F27
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 10:26:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58A6240663;
	Wed, 11 Feb 2026 11:26:26 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4498D402B5
 for <dev@dpdk.org>; Wed, 11 Feb 2026 11:26:23 +0100 (CET)
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61B2wAoX196135 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=Y
 i5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=; b=U2raCg6REbs2sD9zv
 T2mUmUDG07x3oqNb/uT9w81qhMs1jED1bzH/tzBbse1iq6N7DREOIKwIgM/v1CmG
 g4mUqL4zqmmUq+Ao2wqawaRUPpy4jTfkDnp7T7VLAnEox3QP8mAciUOf9A6zjns+
 GmJ33CS8ydpfeZajqGexBoezcvGRC313G0etLIvla21KBAVuKCWLE3wS83Tl32/x
 uwyr+UOhrg7rNPnPEcfYoRdnrfuUDIZxL3Ojqsa2bvYOlG0wkqmYJLFaui2ejmxd
 Ni+eJnZMU0ntdkGSeVtA51t5/GvGgroxFw59XmKzT2nh9R7+cEroGJAx422REHF9
 tJkhQ==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4c61b3rgs8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:26:22 -0500 (EST)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61B7Tb4R3542981 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:26:21 -0500
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4c8ne61uvu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:26:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1770805582; x=1802341582;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yi5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=;
 b=Z4doOxW7wshhtnclhDAn8P3rvv6BybxMb6H+nQSniSlQjJdGkUqA30/Y
 XP0Nbu5RTZt3hqet3j19DcbQhAqqkWrUkmkSy+Ubngi32FxWm9PljiWEJ
 4V0f3q+jVco8SdA2gT8FlApORNgX+zXMUOtcIcqGhnszyKbaIZpUQXdZ/
 MWlqOYPXDPLU+609HiR2W0QxVbP/+f9umFxzg1HJ6+MV7HYcFzcmBau+O
 qocJxqOrN7Yd0OV3TxtinX7pKO+BWLgsVaISd5cZlgJXXvwAirhizyJh9
 W8gKOP3B3vW2mO8ilZZCyj4D2aFVBJTcRxhUgqwie6WaEFiiywSWKlEov A==;
X-CSE-ConnectionGUID: gmCGIS4dTLugrxhTl6K8Qw==
X-CSE-MsgGUID: NO9j1WgFRB21+w/uQ49p6Q==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:25:02 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 11 Feb 2026 04:25:29 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 11 Feb 2026 04:24:29 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Wed, 11 Feb 2026 04:24:29 -0600
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
Subject: [PATCH v7 5/5] vhost_user: enable configure memory slots
Date: Wed, 11 Feb 2026 10:24:33 +0000
Message-ID: <20260211102433.694516-6-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260211102433.694516-1-pravin.bathija@dell.com>
References: <20260211102433.694516-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA4NSBTYWx0ZWRfX2hbRvHkqYmvl
 3dvYsCiCbmY4OP52n6upUKpA7rzcXzkL7izFjOfJSqca7g7e0zF4frAlMfgtDRYeO7lAO/RTqqL
 Oc+Mkx4bJIeRSF+5MMOgY0c6zxk9NyNdJkHDqiqCsDHCIoMRCspwT8nYxX2vkYVUoOwh8fqVnuz
 LcMbIUjeM8B3GNV0F5ijXP+ZMARgClUAxOiJirBFcDksBEtgML5ONeoza+CMKw3OkWrQ5mJIY/W
 GeZWntmUHp/wMYRatlq8Gi1xMmBPNPVmdbFxMBGkZWLZhX9ST6C9KLENjUCbegu2UWbauZtz4BF
 qQ6y9Uom5/M6MHbCcdO5ADORPBYdBJzmPWOAL6vqIAXwo9BaLrTIGiZvHhRR9D1EHhPDvj6cKiC
 y/+1iCn9O0aOm+VBAjnC+uFO+wQdhFWl/ItR9gZzSdCUoueEKZ4ELcyquitfRR1I/FCh0sZzyFp
 19bm93ioVzTOQAWXOSQ==
X-Proofpoint-GUID: WQmyBzXZj5b8YGagNIfOFkKMDo333rie
X-Proofpoint-ORIG-GUID: WQmyBzXZj5b8YGagNIfOFkKMDo333rie
X-Authority-Analysis: v=2.4 cv=BffVE7t2 c=1 sm=1 tr=0 ts=698c594e cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=HzLeVaNsDn8A:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=iLNU1ar6AAAA:8
 a=-L3Ti0Wm1PsFXVv1eAcA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110085
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

