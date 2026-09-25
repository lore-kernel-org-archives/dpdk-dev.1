Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD29CC9830E
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 10:04:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0566B40DD3;
	Fri, 25 Sep 2026 12:04:21 +0200 (CEST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by mails.dpdk.org (Postfix) with ESMTP id 72A5340BA6;
 Fri, 25 Sep 2026 12:04:19 +0200 (CEST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P3aj881989948; Fri, 25 Sep 2026 10:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=f3c8U
 k5I1evPdViZWwB80XOh6KBAIA+0MCmgT+OYX+o=; b=q3omPeWaYh3a/QGa47PS4
 UIVziw4CBzfBwoaUS1KFeTGS0xZQPrRcqju4/Jj9RqIwzVvI6KILjcIaRGp//d/y
 4bMk4oUm/f1Re3epknb4T25gl3gvOMZnTxwD0RUdnoJV3VJuorzsmVcxUtI54H+u
 BUyAMJvwErhCMDZ0/aOltdMDvuqxoBnzyqP6S4aGJW90zZPVGAceRWJKu+N0yWwk
 WTYRY7+FzEYcqapeHHCT21LPtPUzhtyXz6qOuxVZxih9gy3eb3/QfO0MmRsN7RqP
 yeetZXQCcqWRoOlXKmLQ15p/oNbNDUqo8o9+W0TFoXClMYJ8if9tttUeZoZ4qBw0
 g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk0xs44t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 10:04:18 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 68P9nqYj015591; Fri, 25 Sep 2026 10:04:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4guurmat6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 10:04:17 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PA4GYo013985;
 Fri, 25 Sep 2026 10:04:16 GMT
Received: from bansaiku-5cg5092xbr (dhcp-10-176-179-164.in.oracle.com
 [10.176.179.164])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4guurmat51-1; Fri, 25 Sep 2026 10:04:16 +0000 (GMT)
From: Banoth Saikumar <banoth.saikumar@oracle.com>
To: dsosnowski@nvidia.com
Cc: banoth.saikumar@oracle.com, bingz@nvidia.com, dev@dpdk.org,
 stable@dpdk.org, viacheslavo@nvidia.com
Subject: Re: [PATCH v2] net/mlx5: fall back to Verbs Tx allocation without DevX
Date: Fri, 25 Sep 2026 15:34:12 +0530
Message-ID: <20260925100412.736-1-banoth.saikumar@oracle.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20260630102311.1050-1-banoth.saikumar@oracle.com>
References: <20260630102311.1050-1-banoth.saikumar@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=426 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609250039
X-Authority-Analysis: v=2.4 cv=F/bC5ahN c=1 sm=1 tr=0 ts=6ab64722 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=xE48kiExVxkyVb-QTHAA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfXyU6umzVLIr8Y
 CCL+OMAWu0KeCRUirpzYH1RsCNIxR+0jTEDif7bvb7TewJ2NlTSZO5sQ5vttKj7utVjMPyzrMi2
 0KjJJl4tca9wgiPJVX+MlXsAgnr8uX4hH5VKfZZ0cYDeQSrLpcFa
X-Proofpoint-ORIG-GUID: Uz3RZwhh1DEpEUyCQBEpImJwjJQLPs-h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfX1gpMP4w5kshy
 aNLvy3ZsYcENVn1YjPW+HJDbdTRJBowFwNdv8D6PNzcBSYTMafNsgHwXNYlv8H2qF6W0JH3e7y7
 05RbfMTc+vXpr3XRXwJzFY/HimkqIMm7ycTjvGFDTURc8H083zKN5xibw5FTpU7HCfgi3dFj1lL
 /Iz1P/+Mtnt39XY/alEMqvf/y1hzF3wZmmSk0RUSGMuOJHXlwr89Ckv0lt+S6xoMEuvGu2jwKZj
 WDSjxnrSt6Gzuvxs1epzEfcQ+H7mGIWWtL3CWcyW23IWHP9Xj9IoH9XcNZ1wNnA8TZ7Z093vSMi
 ioE+rglAMC9KpKyGqme1K0GCnpDrkFWxeqhX8fkNo1BxM7qDkeOKuwknPYPNYqCHF5AH9xFWe5P
 y3k6jjgulQJTSz8J3pZ9nl50XCDPw0/F5w1kghjAz3e8pUixXiguFDkq29tQbzscaI/nKwjAJDQ
 4p4tMKPsq23bKVw5Bbg==
X-Proofpoint-GUID: Uz3RZwhh1DEpEUyCQBEpImJwjJQLPs-h
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

Hi Dariusz,

Thanks for the clarification.

Understood. You will reapply the original patch once the 
mlx5_devx_obj_ops_en() function is refactored.

Thanks,
Banoth Saikumar
