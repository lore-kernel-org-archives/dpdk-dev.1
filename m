Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4060ECCFA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 04:22:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B0FF402B6;
	Tue,  4 Nov 2025 05:22:17 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id E2A18402B1
 for <dev@dpdk.org>; Tue,  4 Nov 2025 05:22:15 +0100 (CET)
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3LduEO018653
 for <dev@dpdk.org>; Mon, 3 Nov 2025 23:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=23KgZNFBEtsZbBCOh+sj6l3
 nzDZdvljbksUyajrOwHA=; b=lHSD3ovnfYNbxCox76PcKyxSFkwwGDAe6EwKVZl
 D5rLUXpjokv4nlnoC8pbkFXhFAXtxQmDg1dA/ltQM+VV5PXRYB3vlHOiF+5c5zts
 jW2W+B60AE1Tb25ayVzT0InsKx5ZESSUjpqHMdqIsmxOIsxarsDAFvLhSCco5E50
 9lQu6uHmfNYhrsIgVORBWFcwq4MKTtiLOyk+C6ZpaVi4Bvl2ojBZPFahwifsQ63j
 SBdWyxsX9keMCGb7Oi7e8zGvpv27Z1XxX+vx8zvMAer2039/IxikskJ2UxLKlCoF
 /wZL9BacBG/T/TBRnSiLV5NG6lVp1N7BkdmmsgNGQqXugmg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4a5d93axn2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 03 Nov 2025 23:22:14 -0500 (EST)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A42pQHk002832
 for <dev@dpdk.org>; Mon, 3 Nov 2025 23:22:13 -0500
Received: from esapsmtpat09.us.dell.com (esapsmtpat09.us.dell.com
 [143.166.211.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4a78dh96xr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Mon, 03 Nov 2025 23:22:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762230133; x=1793766133;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=23KgZNFBEtsZbBCOh+sj6l3nzDZdvljbksUyajrOwHA=;
 b=Y89LWPDaufhG7cnzkjtAgej4e8l2Kx3fU4BYeor5djPauLNqv2XTpK8r
 y6w8z97HlwaBQsfEN7krv+cZ2eIb4AZou/qzPw+MqNShNUsFre/Dc1pJs
 HJWjPb6iBWT9M8GS6RkHUrti4r4v9hn6uB2yukTyh8FDCi+p96MTS66fF
 5l8ww/qBwZ/4ZDuSrOMIYE8RaGFv1Tb7ZEOvi5JWvoXnMAX2UbwiCCD20
 1fZpU3XRJaVwXmkqeoxBH85uUuXbHEuO348zEKo/ulG5PI39x/Dwl3XF+
 1gpM378QSGQ/GRFPLaAAE+nb2r3G+RE+GHJGNYICXG/TszlIELsGoHoPA g==;
X-CSE-ConnectionGUID: xZMs/GqQQ8ODBx/BftY1Vg==
X-CSE-MsgGUID: kpk5f5jgTa6SepD1VWid9A==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 04:22:13 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Nov 2025 22:23:02 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Nov 2025 22:22:12 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Mon, 3 Nov 2025 22:22:11 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v3 0/5] Support add/remove memory region & get-max-slots
Date: Tue, 4 Nov 2025 04:21:36 +0000
Message-ID: <20251104042142.2787631-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511040016
X-Proofpoint-ORIG-GUID: -Y8liCzNyVU8r3T8t-bjVCR03F_7L85c
X-Proofpoint-GUID: -Y8liCzNyVU8r3T8t-bjVCR03F_7L85c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDA1NiBTYWx0ZWRfX8DEiA/XSp1HN
 X5d/dkez/6uuIwWdF5f+N9Q/E7Pa+JMcbFt09Jxkei4g915RFjcZ6rhEJl3HYHMBViQPzXHGQ/x
 Njqt0D+kGEvmscrys+RkcvafKzXxvS985DA/4XKSUrdeIvQI9L2eE0Cmeiofei9c2w2SDV6kbpt
 p9nRg/cHc2dSy8R/1GJBfheTXgGNzwr7QXO9BICu/HJzAfQPS+vuWcZA8Mru+B+Zs2ISnxVmmZP
 0wloKalMWEM5xMe4yVU3EISzC4Adz+EoObW+aExdU0gaVtNxrtaOsfmMaosjx4IZtnlWg1F7eD0
 QIaDHvDA8rS7P8Aw1653360fafPko0E/ELeeYhHgVJiqHn91j9wXWTMCUEomgFL87G9ntJWE1Ox
 NOttJyoIaX/Im21z7/QfUb25a+RMlg==
X-Authority-Analysis: v=2.4 cv=J/WnLQnS c=1 sm=1 tr=0 ts=69097f76 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=Vd41IKOgs+CGE2+bDnhSdQ==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=4lcfC4FaXlkJtg1E69wA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010056
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

This patchset incorporates support for adding and removal of memory
regions, getting max memory slots and other changes to vhost-user messages.
These messages are sent from vhost-user front-end (qemu or libblkio) to a
vhost-user back-end (dpdk, spdk). Supporting functions corresponding to
these message functions have been implemented in the interest of writing
optimized code. Older functions pasrt of vhost-user back-end have also been
optimized using these newly defined support functions. This implementation
has been extensively tested by doing Read/Write I/O from multiple instances
of fio + libblkio (front-end) talking to spdk/dpdk (back-end) based drives. 
Also tested with qemu front-end talking to dpdk + testpmd (back-end) performing
add/removal of memory regions. The last patch also includes increasing
the number of memory regions from 8 to 128. This has been also
extensively tested using the above test approaches.

Pravin M Bathija (5):
  vhost: add user to mailmap and define to vhost hdr
  vhost_user: header defines for add/rem mem region
  vhost_user: Function defs for add/rem mem regions
  vhost_user: support function defines for back-end
  vhost_user: Increase number of memory regions

 .mailmap               |   1 +
 lib/vhost/rte_vhost.h  |   4 +
 lib/vhost/vhost_user.c | 333 +++++++++++++++++++++++++++++++++++------
 lib/vhost/vhost_user.h |  12 +-
 4 files changed, 305 insertions(+), 45 deletions(-)

-- 
2.43.0

