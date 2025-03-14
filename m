Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90420C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 19:26:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5A9B40263;
	Fri, 14 Mar 2025 20:26:21 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5]) by mails.dpdk.org (Postfix) with ESMTP id F05F8400D6
 for <dev@dpdk.org>; Fri, 14 Mar 2025 20:26:19 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EGeDs2032481;
 Fri, 14 Mar 2025 19:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KNKBvt
 1sYedDy5vyUvDP7asjBMf+UoKTKJhj/K2UyNo=; b=lht8OAJI/xdHe1KwCgE8gN
 3t91yjHtq3h0/zaEwDi6DhukoiSr2gnSiPyMaBT5m+Ye/GQfcYGn9yY62OrMm5fN
 v8SucF6duc9QeF3KH8SEvnpwllrN4CDWiWzPqaQsZ3uKxhZKlHT/AVuqj8M1OroX
 Gxo0S2oRxZp1/S6JeGOYZq6/NJVsK6+1kDFxtsMj7+C6K7x844Lb4A5vzLd4OUjI
 wBL3Tfon95DxLiLqmxBei0S1JRiRi+66G4vFd+TihVyxJsyJKHA3T4Hg9YKGo3/1
 lpgby6YVvtFPemS1yugZ6vax658kXqtdzxbxYQnEdXVotWEwuJ0/+Kgcfqaf3pYA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpwp6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Mar 2025 19:26:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52EGkIhY003127;
 Fri, 14 Mar 2025 19:26:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atsu0gfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Mar 2025 19:26:18 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52EJQHO357868566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 19:26:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43FC658057;
 Fri, 14 Mar 2025 19:26:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15F9858059;
 Fri, 14 Mar 2025 19:26:17 +0000 (GMT)
Received: from [9.61.243.3] (unknown [9.61.243.3])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Mar 2025 19:26:17 +0000 (GMT)
Message-ID: <9ecc5c6d-9472-41c9-884f-3d352fc93c49@linux.ibm.com>
Date: Fri, 14 Mar 2025 14:26:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: release candidate 25.03-rc2
To: Thomas Monjalon <thomas@monjalon.net>, dpdk-dev <dev@dpdk.org>
References: <4098448.yKrmzQ4Hd0@thomas>
Content-Language: en-US
From: Thinh Tran <thinhtr@linux.ibm.com>
In-Reply-To: <4098448.yKrmzQ4Hd0@thomas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7m0AadyX_oi4g---sUrCPjWNbGpSH_gq
X-Proofpoint-ORIG-GUID: 7m0AadyX_oi4g---sUrCPjWNbGpSH_gq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_07,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140148
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
DPDK v25.03-rc2


* Build CI on Fedora 39,40 and 41 container images for ppc64le
* Basic PF on Mellanox: No issue found
* Performance: not tested.
* OS:- RHEL 9.4  kernel: 5.14.0-427.13.1.el9_4.ppc64le
         with gcc version  11.4.1 20231218 (Red Hat 11.4.1-3)
      - RHEL 9.2  kernel: 5.14.0-284.52.1.el9_2.ppc64le
         with gcc version 11.3.1 20221121 (Red Hat 11.3.1-4) (GCC)

      - SLES 15-SP5 ppc64le kernel: 5.14.21-150500.55.44-default
        with gcc version 12.3.0 (SUSE Linux)

Systems tested:
  - LPARs on IBM Power10 CHRP IBM,9105-22A
     NICs:
     -  Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
     - firmware version: 16.35.4030
     - OFED 25.01-0.6.0

Regards,
Thinh Tran


On 3/6/2025 11:42 AM, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=v25.03-rc2
> 
> There are 251 new patches in this snapshot.
> 
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_25_03.html
> 
> Most significant changes are in multiple drivers.
> 
> Please test and report new issues on https://bugs.dpdk.org
> 
> DPDK 25.03-rc3 is expected in one week.
> As it is a small release, we may try to close this cycle in advance.
> 
> Thank you everyone
> 
> 

