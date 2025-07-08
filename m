Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1540BC8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 13:32:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 430FA40677;
	Tue,  8 Jul 2025 15:32:21 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1]) by mails.dpdk.org (Postfix) with ESMTP id 30408402A0
 for <dev@dpdk.org>; Tue,  8 Jul 2025 15:32:19 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5686Ug8p005980;
 Tue, 8 Jul 2025 13:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AmnHBQ
 z2XIvraBUJHIz9DIKhsDZp2MBxm5LYDpEcimc=; b=THh5DCuESTP94qXhjesKDP
 AaNXXCDHceEiuVWiyaslcEaLoQMGiuysbBkReNHQ76201sq/wNLZ2naNYcQcOUpy
 VXLg7eAM5M/Oh2MqodInF7akMrq0Ug9mSOPxrvgmqX2n2wSWoQeghCmTVkdMTjU5
 HLnwi8DUxQPxVhH1UVdgbga/M9/InZiJsu5cwXWr6KZ6n9KwRFATqlBgFRQDL7sD
 ga051N2wtKupFoDJwL1FdtzKtIOgKSK6WfOI5CA04cu5zGtXZ3DHI/v8N4wTMUFV
 30p6YA3EHLV8rm17ns0NQOfRS1gO3uzLCNwGW6bYJ2C7sMTt4p/a1OiaDt/su5ig
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk405xg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Jul 2025 13:32:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 568C2fdo013583;
 Tue, 8 Jul 2025 13:32:17 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkktw0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Jul 2025 13:32:17 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 568DWA9b18940530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Jul 2025 13:32:10 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52D1958070;
 Tue,  8 Jul 2025 13:32:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A6325806F;
 Tue,  8 Jul 2025 13:32:16 +0000 (GMT)
Received: from [9.24.3.46] (unknown [9.24.3.46])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Jul 2025 13:32:16 +0000 (GMT)
Message-ID: <80adee52-2cca-4dfc-81f7-c4e2a525e445@linux.ibm.com>
Date: Tue, 8 Jul 2025 08:32:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: release candidate 25.07-rc2
To: Thomas Monjalon <thomas@monjalon.net>, dpdk-dev <dev@dpdk.org>
References: <4829359.Nya5fj1elA@thomas>
Content-Language: en-US
From: Thinh Tran <thinhtr@linux.ibm.com>
In-Reply-To: <4829359.Nya5fj1elA@thomas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDExMSBTYWx0ZWRfXypKZkaFDiGJa
 yz9pBPxWkEb28v59u2F55LG1QYyhQua7kAhSQ7qdM8q4GLfXjJjmNu1+i4X0kKWqqwjFTHkUJTK
 UrbUuYs/YcSqf2Mpm1j3XptNIMY5fappsnHdCMNUP3lFPoOzyUBFAsEkvY5l3uVYBmTNh1r6qhy
 1+iatLT8f0lAjePjXVEsQHMZlPk4+aIZyMiL5MlIC7sOWOybSIxjr65gvpIeqVwvcR+YWNBLaNJ
 Mns7hsui30zZ19CJGGLiNk1Hf1AE68BMEJd4ELQUWfH3vB/e55glceTvEpbO2fdXHCn4rnOJyc5
 62+gOWUyulA3nmqv7iphWi9BYfyktU37uvVeBDCVqrb9cD5fFF8V+eSbyptt6rCA3r9zRtFzOm5
 tqBrI2cmsDWykjkvt2tYDwvbMZbGIWGxYjq1FsXMSx3QKJZscIAO3bCy/nxyqUzwmnZdEqH+
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686d1de2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=8rWy6zfcAAAA:8 a=T-I4Skbq5JKMQ5GKcoYA:9
 a=QEXdDO2ut3YA:10 a=mSWg1tzGF_8A:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: P5l_t97O4JRJAa-ZKLKFSqzBzspvZ0B7
X-Proofpoint-GUID: P5l_t97O4JRJAa-ZKLKFSqzBzspvZ0B7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080111
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

IBM - Power Systems Testing
DPDK v25.07-rc2


* Build CI on Fedora 40, 41 and 42 container images for ppc64le
* Basic PF on Mellanox: No issue found
* Performance: not tested.
* OS:- RHEL 9.4  kernel: 5.14.0-427.40.1.el9_4.ppc64le
         with gcc version  11.4.1 20231218 (Red Hat 11.4.1-3)

Systems tested:
  - LPARs on IBM Power10 CHRP IBM,9105-22A
     NICs:
     -  Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
     - firmware version: 16.35.2000
     - OFED 25.04-0.6.1

Regards,
Thinh Tran


On 6/29/2025 5:30 PM, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=v25.07-rc2
> 
> There are 141 new patches in this snapshot.
> 
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_25_07.html
> 
> Most significant changes are in multiple drivers.
> 
> Please test and report issues on https://bugs.dpdk.org
> 
> DPDK 25.07-rc3 is expected in one week,
> with a focus on fixes, tests, examples and doc.
> 
> Thank you everyone
> 
> 

