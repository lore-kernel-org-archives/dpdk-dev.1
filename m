Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11CFCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:13:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BF534026A;
	Tue, 11 Nov 2025 12:13:07 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 29DDE40144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:13:04 +0100 (CET)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB824i7032672
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=4nYkprn2ju3q2MwhrnQllAP
 N+uBrGRV9DVhpFqFbFf0=; b=vs/xVVpvjsbeh8KkeGIDpnhXasNoNze0ih8ID+K
 QgkTmplWGwYwZSICTN0/bL8wxkPK5+tuyuT5ez5lkmvcHYqEVNdbEjf8MmVs6jwe
 7N/AgzrP8cz5FSMD+j6QieQYBPMFCpstOc3ZC2VmmoWfFwR4xqEIyq4isaAt8l7e
 FXwmbXSaIW2BVLnRk6zKkPbs3Qgdf3zds486dcSqJDV2OvF3nEJUibEAVW3+uXC3
 VXhex+iQGBiMlr2Gixj6kY7Na0ZD10PlKFmFVSL7BGPd2TlTMmSZ74TNPmTM5AcW
 QoJHLtyA6I9Pvf+pJxx7qae5632RNftKgpT4Q6Rwa2Q8XIA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa2rpkugs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:04 -0500 (EST)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB9axgX001429
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:03 -0500
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4ac2nw90nf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762859583; x=1794395583;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4nYkprn2ju3q2MwhrnQllAPN+uBrGRV9DVhpFqFbFf0=;
 b=HRrkXS64JUs80Hsz+6iyZr8aCB6Ras3xCs+DejfDDcE7Jaz1FrW/8/y6
 sFE2mQGvhEPhmfcW1XiN3PLX+yBMwJDJg413G+1psg7pyh1SEE545e/ei
 PHzBSSxWWHE2HynDZSI7RfrFfYomXzk7nXD/yO/zzeBiQRiwn1XT4ls+3
 U9uaS/p3kuZdKBcHuLiXyVPaiRNjMXYtKD5iZM2wUOyoMsi+k58Z8t11S
 dc+1iREei5lYcpOvHhCcVREqULJ/M7VBw8Y935YvrkURbKxZwZ5TpRi2B
 wKpjA1o5p59SLuOqgwzIULBDfZDABiEHC8wOyJ5UYEoJx45VceBNbMf58 Q==;
X-CSE-ConnectionGUID: Ge6PqzxFRxi7entoT6gT5Q==
X-CSE-MsgGUID: ALKh/79ERWuoDWZpynzndw==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:13:02 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:13:54 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:13:00 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:13:00 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 0/5] Support add/remove memory region & get-max-slots
Date: Tue, 11 Nov 2025 11:12:30 +0000
Message-ID: <20251111111235.2902146-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511110076
X-Proofpoint-ORIG-GUID: Nc5Hktu2FJhwydlGBclMOIkrzYLglh7G
X-Proofpoint-GUID: Nc5Hktu2FJhwydlGBclMOIkrzYLglh7G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3MCBTYWx0ZWRfXxcMC3NHTgcJE
 nyl3d4DydZM6jOjewP3n2Bfw9fmq4WXUAmFpEt2l0YmGITO4dr+uEZ8+BdaW5a0d2zlNnaqdqW0
 OMNhjANMdpUAUpz39A5CT+G16hI+5m88WQd8uuQC6EYVG7AclSC12ioUGgz7ded5JL33EnRe7wU
 DyzHUW07RqLb5gresLyJRXh3IzfORY4dNr5gWAk2jsvVOHACph8M3FkvfR0phLBzOiS+cUVmgdh
 aroT88dxXwytF1zuHUuaecqoQ2xolmj7ZTKm5gfz9WkDzx+YClVCU8AHp1i5eK8jrTlH4ayWT0a
 NXpOXWebMt/zWV2CDkLRi2NIXr7n8Y1PCyxBgC9gn7ZqO5+0WKot+3Xcf9KFt9LEEt9WPTq0LVA
 nUyV6lZj/BNhuAsUWBFNiSHf/osNBQ==
X-Authority-Analysis: v=2.4 cv=UqVu9uwB c=1 sm=1 tr=0 ts=69131a40 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YEBu6XFh4AR5ImKgwYwA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080070
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
regions, getting max memory slots and other changes to vhost-user
messages.  These messages are sent from vhost-user front-end (qemu
or libblkio) to a vhost-user back-end (dpdk, spdk). Support functions
for these message functions have been implemented in the interest of
writing optimized code. Older functions, part of vhost-user back-end
have also been optimized using these newly defined support functions.
This implementation has been extensively tested by doing Read/Write
I/O from multiple instances of fio + libblkio (front-end) talking to
spdk/dpdk (back-end) based drives.  Also tested with qemu front-end
talking to dpdk + testpmd (back-end) performing add/removal of memory
regions. The last patch also includes increasing the number of memory
regions from 8 to 128. This has been also extensively tested using the
above test approaches.

Pravin M Bathija (5):
  vhost: add user to mailmap and define to vhost hdr
  vhost_user: header defines for add/rem mem region
  vhost_user: support function defines for back-end
  vhost_user: Function defs for add/rem mem regions
  vhost_user: Increase number of memory regions

 .mailmap               |   1 +
 lib/vhost/rte_vhost.h  |   4 +
 lib/vhost/vhost_user.c | 399 ++++++++++++++++++++++++++++++++++++-----
 lib/vhost/vhost_user.h |  12 +-
 4 files changed, 373 insertions(+), 43 deletions(-)

-- 
2.43.0

