Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52E7C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 14:15:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE3BC4060B;
	Tue, 15 Jul 2025 16:15:23 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1]) by mails.dpdk.org (Postfix) with ESMTP id 0766A40608
 for <dev@dpdk.org>; Tue, 15 Jul 2025 16:15:21 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9idTv019568;
 Tue, 15 Jul 2025 14:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eiXv1A
 jmmDIqtmeAD+HG7lPvK8hxlFbmLjB2m+mV6NQ=; b=tbnI6XM/p5tybqNc6xCXsV
 W2zvdAMt9toGp0HM8siXDZe94494wzf7hFapJqeiqU6cdmxltwxvj/DP52tZw/lu
 wenpbzfq9zZu7OE026UdfiOmlYxxJAMYG7OLoQhcCVMc+lfWrf/WEYE1+lpw9V66
 okMZXRUXknRrStGp0ldQ2cG6CwS8LZVztjY7gTrS7Wh5OX7q3OWf0w3fQg3COVY5
 xJO7J69BRsbeRT7iqka59FUlSHxNScH7VGH/tCYpE/FlkjDisRDnzP/xR+0Vihvo
 KjmD6JLWUUXl4qhPzDS1HGN7jf4hhC+CFKsjNjBQhSPEtMa67kljseTJCnRJZgkA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vdfmjh3r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 14:15:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56FD4jjO025987;
 Tue, 15 Jul 2025 14:15:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v31pjtep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 14:15:19 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56FEFILJ20841186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Jul 2025 14:15:18 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0377F58062;
 Tue, 15 Jul 2025 14:15:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD7FA58052;
 Tue, 15 Jul 2025 14:15:17 +0000 (GMT)
Received: from [9.24.3.46] (unknown [9.24.3.46])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Jul 2025 14:15:17 +0000 (GMT)
Message-ID: <086c9e27-466a-43b1-86e7-8dc4095512d0@linux.ibm.com>
Date: Tue, 15 Jul 2025 09:15:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DPDK release candidate 25.07-rc3
To: Thomas Monjalon <thomas@monjalon.net>, dpdk-dev <dev@dpdk.org>
References: <9991491.lyo4hBLbkK@thomas>
Content-Language: en-US
Cc: rileyf@linux.ibm.com
From: Thinh Tran <thinhtr@linux.ibm.com>
In-Reply-To: <9991491.lyo4hBLbkK@thomas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ip_X9piIoXlCKUHiyn1CgGWPEhu2dy0H
X-Authority-Analysis: v=2.4 cv=JOI7s9Kb c=1 sm=1 tr=0 ts=68766278 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=8rWy6zfcAAAA:8 a=T-I4Skbq5JKMQ5GKcoYA:9
 a=QEXdDO2ut3YA:10 a=mSWg1tzGF_8A:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: Ip_X9piIoXlCKUHiyn1CgGWPEhu2dy0H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEyNiBTYWx0ZWRfX1XjeL9p2GGcw
 r+zyvNauW8YlEVNy+ILxjHBrz2x+0AM8Ac/b6VMqg1DphGXMwKd4kQ57T9RX2qtPduoKdqxIsM4
 GNgZIbPOt6qX+7DPCQxfTJMx/GzmVeooiZRH+QD84/6r5ut7wT66Sc6Rms1+/BwTgMo6AsgpL6/
 dh7Idbrre7L+sKHzAqxbfLWWsyBmp0P7jEZtPD5o9hQHL9eepKs++ymNXSWAPFjH6K1MGPpHsMI
 oujgOiE0V6MSK4nrvnhOVIH7LpDLxXXZwEobs0ZFGfZGLSYT0LQpgJt0+KihtqY5IEFrUau6/vY
 CuJ0jC2zZ+ulz2VS6O52d3MNxXbGhN1zL/ikcsFYq0hBVQiqBij1oNn7Lz0MqQTqxIWUipFfa8h
 CDmOzoNvYkQSKgOwT9WIaU5eXCsSO1gVe8lb/1tPtwvRN6BvpAemwDBDh1clpg1lwG1fWQCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150126
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
DPDK v25.07-rc3


* Build CI on Fedora 40, 41 and 42 container images for ppc64le
* Basic PF on Mellanox: No issue found
* Performance: not tested.
* OS:- RHEL 9.4  kernel: 5.14.0-427.40.1.el9_4.ppc64le
              with gcc version  11.4.1 20231218 (Red Hat 11.4.1-3)
	 - SLES 15 SP6 6.4.0-150600.21-default
  	     with gcc version 13.2.1 20240206 (SUSE Linux)

Systems tested:
  - LPARs on IBM Power10 CHRP IBM,9105-22A
     NICs:
     -  Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
     - firmware version: 16.35.2000
     - OFED 25.04-0.6.1

Regards,
Thinh Tran

On 7/9/2025 4:26 PM, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=v25.07-rc3
> 
> There are 86 new patches in this snapshot.
> 
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_25_07.html
> 
> Please test and report new issues on https://bugs.dpdk.org
> 
> Only documentation changes are expected at this stage.
> 
> If no major blocker is discovered,
> this release cycle may be closed during the next week.
> 
> Thank you everyone
> 
> 

