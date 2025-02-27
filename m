Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2353C19F32
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 21:20:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78D1440654;
	Thu, 27 Feb 2025 22:20:07 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5]) by mails.dpdk.org (Postfix) with ESMTP id 77A7A402D7
 for <dev@dpdk.org>; Thu, 27 Feb 2025 22:20:05 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGD02V017929;
 Thu, 27 Feb 2025 21:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=N93E34
 Ec+cPk1/LYdK/nqRm4CDdqIdbpcO+igc6kgc8=; b=M5rB951ZmE6CTtWUsOi8B8
 +DbNfMA49XBl39zvqwt5N6B5Qe7ICgHcPB9ryCk2kpesEn4/sWBhahLvHbg95mvi
 NIIUFrAH4NWP8UlntxBkLSrTBR3tUNRuHmZwvUaC+5yjY9vRXoNzX1+RmFnkUwuv
 +0P+5OEgsp+T7zrh0ZeFEwBU0vFW6wvwKsovK7kAMMOkTsPWnzk87c0+ZQDZT94X
 REVpM1BhTdUZJ7Ewq9ih8+1lZqpR7QhI/ULVcw/ciqfZ7EG1iI9p+Q5O+m5heatA
 i6X4ZIZzboQdmfovjPDHhQzR0PWUbDpIke/NMv00BaGi8n8y8ZKrUVXUm2mYV8JQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452krpc63m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 21:20:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51RINBHs012491;
 Thu, 27 Feb 2025 21:20:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9yu7q7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 21:20:03 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51RLK3KB22872710
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2025 21:20:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2662158065;
 Thu, 27 Feb 2025 21:20:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B55358052;
 Thu, 27 Feb 2025 21:20:03 +0000 (GMT)
Received: from [9.24.2.201] (unknown [9.24.2.201])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Feb 2025 21:20:02 +0000 (GMT)
Message-ID: <c7be6e2f-f9f7-4513-99ff-b9a353cf7d28@linux.ibm.com>
Date: Thu, 27 Feb 2025 15:20:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: release candidate 25.03-rc1
To: Thomas Monjalon <thomas@monjalon.net>, dpdk-dev <dev@dpdk.org>
References: <17054329.0ZKypZ73Fx@thomas>
Content-Language: en-US
From: Thinh Tran <thinhtr@linux.ibm.com>
In-Reply-To: <17054329.0ZKypZ73Fx@thomas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xyJibwX0M9OnmnXnJrGVLmR4_hvwsoFm
X-Proofpoint-GUID: xyJibwX0M9OnmnXnJrGVLmR4_hvwsoFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270156
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

IBM - Power Systems
DPDK v25.03-rc1

* Build CI on Fedora 38,39,40 and 41 container images for ppc64le
* Basic PF on Mellanox: No issue found
* Performance: not tested.
* OS: - RHEL 9.4  kernel: 5.14.0-427.40.1.el9_4.ppc64le
             with gcc version 11.4.1 20231218 (Red Hat 11.4.1-3) (GCC)
           - SLES15 SP5  kernel: 5.14.21-150500.55.49-default
             with gcc version 13.2.1 20230912 (SUSE Linux)
           - SLES 15-SP6 kernel: 6.4.0-150600.21-default
             with gcc version 13.2.1 20240206 (SUSE Linux)


Systems tested:
  - LPARs on IBM Power10 CHRP IBM,9105-22A
     NICs:
     - Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
     - firmware version: 16.35.4030
     - OFED-internal-25.01-0.6.0

Regards,
Thinh Tran

On 2/12/2025 10:49 AM, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=v25.03-rc1
> 
> There are 478 new patches in this snapshot.
> 
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_25_03.html
> 
> Highlights of 25.03-rc1:
> 	- Staged-Ordered ring (SORING)
> 	- mbuf raw bulk functions
> 	- some Intel drivers merged together
> 	- Yunsilicon xsc networking driver
> 	- ZTE Storage Data Accelerator (ZSDA) driver
> 	- Intel compiler icc support replaced by icx
> 	- more function annotations for analyzers
> 	- more MSVC compatibility
> 
> Please test and report issues on bugs.dpdk.org.
> 
> DPDK 25.03-rc2 is expected in more than two weeks (end of February).
> 
> Thank you everyone
> 
> 

