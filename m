Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8524DC44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 05:01:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44E7E402B5;
	Tue, 21 Jul 2026 07:01:28 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5]) by mails.dpdk.org (Postfix) with ESMTP id 4262C40289
 for <dev@dpdk.org>; Tue, 21 Jul 2026 07:01:26 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KNDBLd3460108; Tue, 21 Jul 2026 05:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ibDtOU
 8FJ3fVeCnNRAH35zpUqoK/dLunLT4Xfju7W5I=; b=I+bT/GCfwdfJHqUf55JHyn
 ewWI336JwwVwVH1avDuajWsg0WD0Ef3TTngIS22CxJOfa+rS9BCM3J53ugDPD60n
 +TRXTJit4Kqx+iI4i504amXVY57U+YsCDXzyqVXwRM0Kv1EzquCrGf3NQNMlWfhz
 DCgdjqn8AhR0DiIq6bAhwZH3/bQVsccOCTiVzcLgUobttnPxaStKOX1YnmZ5Lr7y
 4nNPIG6BEeeKtzjfXWMSK7A9rrC81/Ugl/oOqZm9rSL8Mjg9GoWM0QNqC6slCDg3
 YJC0dBk2Uv/wTgvSl1yObjtHYvIgyINDLHUdhqczoS+Fa5x8JJtaD46KuJLGAaiA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g2htx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:01:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L4YsGV029523;
 Tue, 21 Jul 2026 05:01:24 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq0yc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:01:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66L51NbD15270604
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jul 2026 05:01:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FDF65805E;
 Tue, 21 Jul 2026 05:01:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4ECF258054;
 Tue, 21 Jul 2026 05:01:23 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.ibm.com (unknown
 [9.61.182.70]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Jul 2026 05:01:23 +0000 (GMT)
Message-ID: <057d70e5fafe99c9e8b70f6aa55f088a14b2eb25.camel@linux.ibm.com>
Subject: Re: DPDK release candidate 26.07-rc4
From: Riley Fletcher <rileyf@linux.ibm.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Date: Tue, 21 Jul 2026 00:01:23 -0500
In-Reply-To: <kvNGsDZ2SLOK2WFaq05qOA@monjalon.net>
References: <kvNGsDZ2SLOK2WFaq05qOA@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA0NSBTYWx0ZWRfX1Ywj0wroquM9
 gRxs6E8ikD2nWYRn7z3XAlwDVcVOUWUHClxkbt7t57UI4/QmzTR3zckw4zr37SdjWEUPMXDnrNv
 qfOF5oqek2TaIpWOyMkJMiPTnGNAQkC20zJmbEjbq9XbUYzDjH17TbNoNjCgUjNbdSJm3zQWY0X
 uc9Qqvp4KezdtD7NIAxTVUKiW0fz4JBGvuYgJbWQF89VtmxkusagclQPQQy4rrcAo/6vj3/2Q8b
 8lwQVQg75IoEbIFlG/yS9JHqu/8JRyARqUFhWqrpFclhcSpyJhZLnL9p6LxnIMZULHIHG/2bRgD
 MoMZ4V+fOh8JjYezScc+Uz8sK6yp3xtpDr+Rxc0LwW3GlQNUHVol9wzgnmyUuiU8yPuyy+nbQT7
 jjQiDdZlK10/dmB37cFRgPyqsXg0Z4NTjD5rUOVxm0KC85j97DwUEG6A9C4UEYb3xWIUoClKehz
 gixy6FrtfXMLSKVjWQA==
X-Proofpoint-GUID: -uzO6dID1jrvgEVRko3wS4jL9MeuF40Y
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5efd25 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=8rWy6zfcAAAA:8
 a=o0H6PxKc5kZCS8mi02EA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA0NSBTYWx0ZWRfX0kE4BiFFQkZi
 eUXoV5goZacVn3c39lkgeROWw9bzi2O0DK4AQk6JoQHy+Mw+CDlMEhFx48fFMZ4vz7f67HKMjfr
 7dQJKayP/EJRmHmcqHJXN9kmCXeJVTE=
X-Proofpoint-ORIG-GUID: -uzO6dID1jrvgEVRko3wS4jL9MeuF40Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210045
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
DPDK v26.07-rc4

* Build CI on Fedora 40, 41, 42 and 43 container images for ppc64le
* Basic PF on Mellanox: No issues found
* Performance: TestPMD throughput single core tests
* OS:- RHEL 10.2  kernel: 6.12.0-211.7.3.el10_2.ppc64le
         with gcc version 14.3.1 20251022 (Red Hat 14.3.1-4)

Systems tested:
  - LPARs on IBM Power11 CHRP IBM, 9105-22A
     NICs:
     - Mellanox Technologies MT4129 Family [ConnectX-7 100 GbE 2-Port]
     - Firmware Version: 28.48.1000 (MT_0000000834)
     - OFED 26.04-0.8.6

Regards,

Riley Fletcher

On Sun, 2026-07-19 at 11:53 +0200, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=3Dv26.07-rc4
>=20
> There are 48 new patches in this snapshot.
>=20
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_26_07.html
>=20
> Please test and report issues on bugs.dpdk.org.
>=20
> You may share some release validation results
> by replying to this message at dev@dpdk.org
> and by adding tested hardware in the release notes.
>=20
> Only release notes changes are expected at this stage.
> There are some deprecation notices pending for review.
>=20
> This release cycle should be closed in few days.
>=20
> Thank you everyone
>=20
