Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6800CCCF9EA
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 03:51:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8588340297;
	Thu, 30 Oct 2025 04:51:03 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5E9D64027A
 for <dev@dpdk.org>; Thu, 30 Oct 2025 04:51:01 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59U0jY1U4123666; Wed, 29 Oct 2025 20:50:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=6
 lGy4O6vHnhoKrm8+0Wbj34qrOwbRDdoVLW6ip0FIHw=; b=FPyFtdBf58QTRnBM6
 Km0muLMiF1QQGr3zLdMGoju6KKtGGVP3/x7J3zXkcYQklR0aS9wzFDBn6YJMuQlG
 fC7Bf4qDuMZFyHYLjPVmoa4V4P+nXQ99JDp/tMB1Oyh8KMamLGWanc9dkwMPlDKc
 /DzjzubGA95DNeVb4I2g+eI3CecFAKuqLKZSICoqZeL7O94SkklFl4UAj0u+MNFy
 Ci7lBMiUp520pe57Z0KRnpaeec1n8rjnSP+vC/belKmDum9QWBMLTBXjdEA0R0fa
 JkTA6PEkmLjB0u19TVt77uMv52oU3NMIrFN3lamNw+9VMOWtk1wXT1M2Sk4mbNXM
 ngz4A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a3nru2rrx-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 20:50:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Oct 2025 20:50:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Oct 2025 20:50:09 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 807375E6872;
 Wed, 29 Oct 2025 20:50:05 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: 
CC: <dev@dpdk.org>, <Ruifeng.Wang@arm.com>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <jerinj@marvell.com>,
 <konstantin.v.ananyev@yandex.ru>, <mattias.ronnblom@ericsson.com>,
 <mb@smartsharesystems.com>, <roretzla@linux.microsoft.com>,
 <stephen@networkplumber.org>, <thomas@monjalon.net>,
 <zhoumin@loongson.cn>, <wathsala.vithanage@arm.com>
Subject: [PATCH v11 0/9] lib/pmu: cleanups and trace integration
Date: Thu, 30 Oct 2025 04:50:04 +0100
Message-ID: <20251030035004.1756725-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024054830.933910-1-tduszynski@marvell.com>
References: <20251024054830.933910-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=XuH3+FF9 c=1 sm=1 tr=0 ts=6902e0a1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Hhvmi4Z6sOI57Jt3b-MA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAyOCBTYWx0ZWRfX38eoqSCkuW55
 LjbGDnWa0MyGMVEA85ypYYkzwznt7YOIk7k7+jX7mXerWpbTAzNRxhjdSTxabrZ0/ysLeBur4Wj
 kIXFotPEN0UHqpRhsXBe0M5ErTtGrUh8oeLVboRkNzsVB/qInHZnG9yUVmROMwdqXHmil+WzXOq
 Ssv3lU5aDtkFx8ELx/8A+E5wixertrMT22sVeBNJUbQ+Kzzzg6nOxwnmiVz+Pn8P65LT9ZkOw57
 JP478j7VKD7lzJJQrj9w4Rh6rQew/ei4pK8kPzgEzFuBX63uMz33X9vkQ8ClNnf/ODt5zTZZTY/
 3QTvGhpWmozMQ6Px4xpHBiPle9gIKPCK+CM1iAtfEsU+bI4piHeVK/F5EqbvMc3bXaaOps4Xdev
 hxnPYMgxTHfMxbf8BuDCTf6bP/bNaw==
X-Proofpoint-GUID: 1dXrewseaolq0i_ahQTLjwqdUPBh34pc
X-Proofpoint-ORIG-GUID: 1dXrewseaolq0i_ahQTLjwqdUPBh34pc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
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

Anything else required from your angle?
