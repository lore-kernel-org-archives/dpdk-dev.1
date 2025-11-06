Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78780CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 23:10:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 650744021F;
	Fri,  7 Nov 2025 00:10:00 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1]) by mails.dpdk.org (Postfix) with ESMTP id 52F924013F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 00:09:59 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6HRFiu023145;
 Thu, 6 Nov 2025 23:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1FU/OX
 CvQIIX6/fRWPz3VFLmRRylnhRAHOIHFKxPxkc=; b=ZS6dha5lI2NaRM2iVb8qw2
 AZxTeXnjKEOseC+x2a5Ohms2hjs1lOLsobJUBTmxNAOUzDDsi40m9pNYkMJ7a8qb
 iRKMYR6zJ1+KpVIpzwGSuoOKcEQmn0kC+8P0jYJYMOjCrF3RbCJoEBNgfXDM8UMm
 6PJVbZjcQjO2zw1pnSWhRYALh7WUlxzYKS7U8sRBoBgLiwyF1bU8KoDPG9h1qvL5
 h4lp4OEmesv0j+DdGzN+mqOHt5Ih6vSrROXJIi7qOGnr7+bnuBN80aXojWgIcDyw
 +LN8f+37q4YGfXDYhyiy0F31E5yjzTu/PaqcCCWdnUI+xOgpoUB/CTO9rrbr3sDw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xc9sh9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Nov 2025 23:09:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6M7XXR018667;
 Thu, 6 Nov 2025 23:09:57 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whnqx5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Nov 2025 23:09:57 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5A6N9uDQ30802464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Nov 2025 23:09:56 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DDE058065;
 Thu,  6 Nov 2025 23:09:56 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5264658056;
 Thu,  6 Nov 2025 23:09:56 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.ibm.com (unknown
 [9.24.10.250]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Nov 2025 23:09:56 +0000 (GMT)
Message-ID: <110ae6b9ad494456a4df46322f211eeb26baf7c0.camel@linux.ibm.com>
Subject: Re: DPDK release candidate 25.11-rc1
From: Riley Fletcher <rileyf@linux.ibm.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Date: Thu, 06 Nov 2025 17:09:56 -0600
In-Reply-To: <24022415.5W6oEpyPa8@thomas>
References: <24022415.5W6oEpyPa8@thomas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX3tPrYBkXnE6u
 cdRQsjrE/5j7+2m3eiGCOPBABZgQacn3f8S4I/VDYlP6I+NrgbA0r/Ps751lxgcAxuMDPYTMmya
 ENaOUxdExaK31IYjFBFmGQEiN59Ak2/eWPCR3uqBquwX+fOX9IAa0+CcmSc4/4FY6u1owFO2D2K
 Y7NhjUxJQ+cUdktvdnZg5+5dUIkrXN3HQ70ir9BD3hUYz7kC+9fuNY1NrMoGSEFcKaJy8EP2Yh8
 8X1sloBanZ+R7xx0xDSBupiHRa+Ozl9hlm7qLx+fI0/N100Gwin+WFmPnz5MSskdOC5mykfbjc4
 HBByyomSEgs6zd3BB+Z7bnYgiSLaRiDY/6wFg8JQwQIXOUcQa55ufSOtus8mLw2MNijD3fuM6sA
 1yVoaoTweKGB2NB46mogwP+TCXTs1g==
X-Proofpoint-GUID: mv0Zby9uxfF_MBF8hthFEH8wu3M2nFhl
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=690d2ac6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8rWy6zfcAAAA:8 a=T-I4Skbq5JKMQ5GKcoYA:9 a=QEXdDO2ut3YA:10 a=vwQxE1H_xY0A:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: mv0Zby9uxfF_MBF8hthFEH8wu3M2nFhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021
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
DPDK v25.11-rc1


* Build CI on Fedora 40, 41, 42 and 43 container images for ppc64le
* Basic PF on Mellanox: No issue found
* Performance: not tested.
* OS:- RHEL 10.0  kernel: 6.12.0-55.9.1.el10_0.ppc64le
         with gcc version 14.2.1 20250110 (Red Hat 14.2.1-7)

Systems tested:
  - LPARs on IBM Power10 CHRP IBM,9105-22A
     NICs:
     - Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
     - Firmware Version: 16.35.2000
     - OFED 25.07-0.9.7

Regards,

Riley Fletcher

On Fri, 2025-10-24 at 16:45 +0200, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=3Dv25.11-rc1
>=20
> There are 634 new patches in this snapshot.
>=20
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_25_11.html
>=20
> Highlights of 25.11-rc1:
> 	- EAL option to remap lcore IDs
> 	- inter-domain DMA
> 	- mbuf optimizations
> 	- mbuf tracking for debug
> 	- cryptodev PQC ML algorithms
> 	- ethdev link connector info
> 	- Huawei SPx hinic3 ethernet driver
> 	- Nebulamatrix nbl ethernet driver
> 	- NXP ENETC4 ethernet driver
> 	- Wangxun Amber-Lite txgbe ethernet driver
>=20
> Please test and report issues on bugs.dpdk.org.
>=20
> This -rc1 was supposed to be released 18 days ago,
> so we are late in the schedule, sorry about that.
> We should try to close -rc2 during the first week of November.
> It means we have less than 2 weeks remaining
> for adding new features in the drivers.
> Adding features in libraries after -rc1 would be an exception,
> but it is possible.
>=20
> Thank you everyone
>=20
