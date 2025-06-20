Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB885C7115C
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 20:46:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3C3A4065D;
	Fri, 20 Jun 2025 22:46:56 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5]) by mails.dpdk.org (Postfix) with ESMTP id 3A93F40267
 for <dev@dpdk.org>; Fri, 20 Jun 2025 22:46:55 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KJ81uJ028424;
 Fri, 20 Jun 2025 20:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DVQcxf
 yM3+jlErm8O/CPtVdYGY/qpRZYF03eHWkJdrk=; b=WjvXY/7TNod7o2cmadKOa9
 W9kdhhwP0SfhpR2BSRe0wiSQoMHli9CXXYFwjbp1u/YBNVApbm2YgfXKqVNvec/G
 jugfCY2dVaJhmgfXhA7/HYjKQdFCdsDctXASRiEx2gKgSsWBDDfLP1xdkTVfZj54
 XbN7WUh8kRGR+W8kRV6KNLXV9DLVttmojz3iueF43s9lCtZCVHEEnbBDEl0nHtCf
 LOpcdj4vghnaaJ32pzpvNBvcIDxJSCcV+xOJgFMH7yCsRhQUvThRroZSwOto093W
 u67e5cYa4xbHLWaOzk2qt2g8zJIq/B/Y91e9s0yzKz7CsHZQjhAlhTXVG8YTFF0w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r2n5gf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 20:46:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55KKWeF5021628;
 Fri, 20 Jun 2025 20:46:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47cahwgwbg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 20:46:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55KKkr8s18743828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Jun 2025 20:46:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 034A258056;
 Fri, 20 Jun 2025 20:46:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9EDF5803F;
 Fri, 20 Jun 2025 20:46:52 +0000 (GMT)
Received: from [9.61.251.132] (unknown [9.61.251.132])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Jun 2025 20:46:52 +0000 (GMT)
Message-ID: <b437f3be-c2df-4f24-835b-5c5f28e44ad2@linux.ibm.com>
Date: Fri, 20 Jun 2025 15:46:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: release candidate 25.07-rc1
To: Thomas Monjalon <thomas@monjalon.net>, dpdk-dev <dev@dpdk.org>
References: <5554581.qSoW2BAyJ8@thomas>
Content-Language: en-US
From: Thinh Tran <thinhtr@linux.ibm.com>
In-Reply-To: <5554581.qSoW2BAyJ8@thomas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _Q1CGiLjeofiKvBwcxamAwiHWcTj_eQl
X-Proofpoint-ORIG-GUID: _Q1CGiLjeofiKvBwcxamAwiHWcTj_eQl
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=6855c8be cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=8rWy6zfcAAAA:8 a=T-I4Skbq5JKMQ5GKcoYA:9
 a=QEXdDO2ut3YA:10 a=mSWg1tzGF_8A:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDE0NCBTYWx0ZWRfXyTX5tTITj0bC
 BQoV9/9dH1wF6GT5A9sVJFZZR66InuVhp9jj0U8t7KxIQZnB3RPuQTqGAV5m9Ech9MUulEil3nL
 +cHcFfu5wZuZ+MldIAXFGEeK0SLm5Ivt5Xt07ldQ6HORlTB+w9PgOaG6tuIdP5Icm/9wgpx0DNW
 cQDSSE/PKBUFaEjB5rHEZSYpROPJ3tasnyaG8msV4YfzJV3oJLNWljKizrWgnC7Jkz3j9wyBSFl
 18zZoKrwKipB09e9UkxpvDwzYoPjfjRnYpBhBjZsKxtyyk/pB7i4vaSaV38dig/CAa0OBPCjevE
 EDHJKbfOLR0Zc2gOgGEduR/dNqBJAIi6JzrrXahRNRu69IImaoVMJXc8uSOncQKmiw6SBL7RwzB
 i4fBezoUfEmtkmXonewaDDbIjJOTDClbircdEdn7dc/959b3MdQEd6rWmixnqknc6NYa7iHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_08,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200144
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
DPDK v25.07-rc1-8-gdbeb8ae8d0


* Basic PF on Mellanox: No issue found
* Performance: not tested.
* OS:- RHEL 9.5  kernel: 5.14.0-503.11.1.el9_5.ppc64le
         with gcc version 11.5.0 20240719 (Red Hat 11.5.0-2)

Systems tested:
  - LPARs on IBM Power10 CHRP IBM,9105-22A
     NICs:
     -  Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
     - firmware version: 16.35.4030
     - OFED 25.04-0.6.1

Regards,
Thinh Tran


On 6/11/2025 8:56 PM, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=v25.07-rc1
> 
> There are 542 new patches in this snapshot.
> 
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_25_07.html
> 
> Highlights of 25.07-rc1:
> 	- Mucse RNP driver
> 	- ZTE Storage Data Accelerator (ZSDA) crypto driver
> 	- Performance Monitoring Unit (PMU) library
> 	- mempool optimization
> 	- zeroing of sensitive memory
> 	- RSS type for RoCE v2
> 	- graph feature arc and nodes for FIB
> 	- eventdev vector adapter
> 	- argparse enhanced
> 	- more libraries enabled with Windows MSVC
> 	- export symbols with macros instead of .map file
> 
> Please test and report issues on bugs.dpdk.org.
> 
> DPDK 25.07-rc2 is expected in two weeks.
> 
> Thank you everyone
> 
> 

