Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23094C87FD3
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 04:30:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71B3740655;
	Fri,  8 Aug 2025 06:30:23 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 564C940652
 for <dev@dpdk.org>; Fri,  8 Aug 2025 06:30:22 +0200 (CEST)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577JdIVW006753
 for <dev@dpdk.org>; Fri, 8 Aug 2025 00:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=O
 Oe+rj2wBbb7AUzCb0XYZ7Cdz9Vbdqns3fZpVoi8pDU=; b=qgEpFXuufN5Vz/6uX
 6At6tjdKZhOe1/rDtVYJEOFdQA5VJca5MYmzFqy287i93rqh2fqFORs8qTkIBbcq
 fCedEqhuteqxpGJ72JO8Oc6zLOTBcE7eD/RP1RjxWYUecYQ13QBKLfnYuJs9iUVM
 RzXjlLCZ3qazaKCiWGbZzak3T9K0WUv3zLM/nKFS9fD3xswwHYn1FW8dIKGuoB/6
 cPhgQ5LCLJ+PCCztz8dK/rqk+GxG/VvB8O4wWlPiNbcjOlzDzw30N3cQ+wii6xGA
 iIawD4wITQQ7oX0Tvm9e4ai7gsJ+AFUCwKfR6GeB5eQjYGYA4kza/rQSD6dxmXwh
 8zRgQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 48bpx3nu0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 08 Aug 2025 00:30:21 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5781gGTU039746
 for <dev@dpdk.org>; Fri, 8 Aug 2025 00:30:21 -0400
Received: from esapsmtplv07.us.dell.com (esapsmtplv07.us.dell.com
 [143.166.203.154])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 48d2rrvxfm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Fri, 08 Aug 2025 00:30:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1754627421; x=1786163421;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OOe+rj2wBbb7AUzCb0XYZ7Cdz9Vbdqns3fZpVoi8pDU=;
 b=Ddc+oMfwNolCcjZrzCbA0Z0UKahwnZ518ijf8gFj0yg8gbNWN8A3qrqk
 8FmlE27hxwr9tW9UK4Ndqv6cCkP/UJMTBYzMeFDBVetLN5nmcw8qeaOHk
 xX+LBVxZxlB+gQdZimIlvFSfsKbXr6nFs+EUm057re/nKfJ0moO6A1Jxz
 8ep/S2RMpyinQMcJLJLJ3BvAu933QAj6mUYxhk/RuADCwU+GxXuksr4z0
 j0H3Ji3y+O32ng/zR7pk8jBh3KoALb+QX4D8CO34MvnPP+J2yDz4laeCX
 AO1NkE2HmuvtU5IAcYP3P1Vgif4IaQiwomRAFQywfrhiNog8VygxpzyqR g==;
X-CSE-ConnectionGUID: MwAId6URTW6B1BCGtlSxPA==
X-CSE-MsgGUID: 1XVoYN/ETdi6EW1+dkPVxg==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv07.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 04:30:20 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 7 Aug 2025 23:31:19 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 7 Aug 2025 23:30:14 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 7 Aug 2025 23:30:14 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>,
 <boris.glimcher@dell.com>
Subject: [PATCH 1/3] mailmap: add user
Date: Fri, 8 Aug 2025 04:29:53 +0000
Message-ID: <20250808042955.2386083-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808042955.2386083-1-pravin.bathija@dell.com>
References: <20250808042955.2386083-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=572
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080034
X-Proofpoint-GUID: R4kLdj8EUTSMLViMne5yxpkne7AyCYKO
X-Authority-Analysis: v=2.4 cv=GbkXnRXL c=1 sm=1 tr=0 ts=68957d5d cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=FlBIjDbFArVVlnHZBJJA7g==:17
 a=2OwXVqhp2XgA:10 a=ke5jqHz-1hQA:10 a=pGLkceISAAAA:8 a=iLNU1ar6AAAA:8
 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=M5GUcnROAAAA:8 a=8AirrxEcAAAA:8
 a=ywhdLq5f-aV1tX3TMycA:9 a=hlJyneSgMmFPbskH-t2w:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: R4kLdj8EUTSMLViMne5yxpkne7AyCYKO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDAzNSBTYWx0ZWRfX9+5MFmK5Akr3
 UTd548ItgZVVUNsUmUjXnzfeJL9G/rAyM+aKdBIDwfPuMD7A0A49zT54zXUjpvxhT4mGVbX5TIf
 9R/8S3WGvPLpl9WNKj9V/SFbT+DNry3XamB0zwVnHe+knzCPEWeANp2LrLDVIKDgjVSjCzy+W15
 ANAgUV8lBlJh4DQhZoaD1nmNMcbAJRsuBse+cki9srnJjhxssIU8M17HIv72/IKqHjHFLH8wdJR
 ofIKwmqSWt8R7l/WyXGww2YiJZw1i/qnGc5CHFlMV2wBi2Z5qb+Rb28B6TSq/xseWsRmiKhd0L/
 su5B2NfEhJ9zVOZmIYiPuXUTMVhwwjqVMKoI8IrxJR/Q9vZa3v46OuhF0qqG3j1UuYLb0aGJW3x
 K6piX4GKpLiajb+IIGNmILTFs3g+bbiXCzl7H52MiVBeinpgxHY1melJ6u1FNPn4cfU6cnOx
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=616 lowpriorityscore=0 suspectscore=0
 priorityscore=1501
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080035
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

From: Pravin M Bathija <pravin.m.bathija.dev@gmail.com>

add new user to mailmap

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 34a99f93a1..6b24ee3a30 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1262,6 +1262,7 @@ Prathisna Padmasanan <prathisna.padmasanan@intel.com>
 Praveen Kaligineedi <pkaligineedi@google.com>
 Praveen Shetty <praveen.shetty@intel.com>
 Pravin Pathak <pravin.pathak.dev@gmail.com> <pravin.pathak@intel.com>
+Pravin M Bathija <pravin.bathija@dell.com> <pravin.m.bathija.dev@gmail.com>
 Prince Takkar <ptakkar@marvell.com>
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>
 Priyanka Jain <priyanka.jain@nxp.com>
-- 
2.43.0

