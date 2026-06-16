Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8793ECD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 15:49:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97DD140289;
	Tue, 16 Jun 2026 17:48:59 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1]) by mails.dpdk.org (Postfix) with ESMTP id DD73940150
 for <dev@dpdk.org>; Tue, 16 Jun 2026 17:48:57 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GFmOvp1948300; Tue, 16 Jun 2026 15:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+XS/TY
 DzvLRr1+VsFWDLODVQTEU43SqqmadwJ2jLw0E=; b=diD9AOdpMFYdq9qjkNHPTY
 Ap29J1rNDhGqCRahTMWKaVaNkchTdPH8KAdzYmPBVjudhcz1NkRElyedK3cgZ2j7
 lHg1HfqZarKzV+m8q32bafu537pl4muQ8ZW7DU9u3pfzhq4jkhYLdD5WiZPULSZW
 y0bHtmCsCluj8ZfguPIXS8krKwPunVoOf4DY5VLtuBQkHmJLDchHm0JIHl+Rh5Xk
 V2EUIzHomXRdKV9f/SdJgW+OVM54fToHr34s6nkVVRJCQVe5ojLxwTyRhIUmhH2N
 7c0aq6zrOeNQww01lIKaWuURsMpnqCHx2ybECvkEl1F9zzsmUPHBrpg3maOKXUkg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm6m9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 15:48:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GFYagP032018;
 Tue, 16 Jun 2026 15:48:55 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7y3w3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 15:48:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65GFmNhf61604342
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2026 15:48:23 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C769558056;
 Tue, 16 Jun 2026 15:48:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A93E65803F;
 Tue, 16 Jun 2026 15:48:54 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.ibm.com (unknown
 [9.16.58.171]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jun 2026 15:48:54 +0000 (GMT)
Message-ID: <db81df752edfb548dd00ad2c5bb8dea726349c25.camel@linux.ibm.com>
Subject: Re: DPDK release candidate 26.07-rc1
From: Riley Fletcher <rileyf@linux.ibm.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Date: Tue, 16 Jun 2026 10:48:54 -0500
In-Reply-To: <EE7NFX47QzqKRvGYzs3QUA@monjalon.net>
References: <EE7NFX47QzqKRvGYzs3QUA@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE2MiBTYWx0ZWRfXxpT2LcVAiAI1
 pBQKWNBya/CTe2OTYbuQs0bGx7+lM1w0ajPxjUHkMV41ARV1RdgGhuFw9Zqah+YVI8FHrkbLiGY
 ERCbD0bCBnVfaeFaGHRS9TsNC5Ep3hU=
X-Proofpoint-GUID: eKdSuGTy27GA7zwAPPQSB4pa7UGCP8Y2
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a317068 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=8rWy6zfcAAAA:8
 a=o0H6PxKc5kZCS8mi02EA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE2MiBTYWx0ZWRfX+Ll5vXA5/gMJ
 H1rJhKlKwnpavoWxIaUwdBnvsx3hlW1SavW/QF6gKhnHFt0RcCZpkCQudtfTqUIwPDhHXS6qaer
 OqzZB5uP94I82C6dX8Evbpkmnx6KjjEPRIaTBEwvMXoAEhH3pOsujZRvtuWDJQcQXJfkXmIjR4Y
 UK2fGGNwCmbhlJLe566ODhWxYmKu+vF+9RJnuXx0k0fzKVW8aFk90N4Npv2mCtR53sFALAc3sVj
 yDnBAvjWdGUP9nii4Ldsu7P3kh+uMJa8rbJt0dwz2o6VxCXcwmtCPIyURzMR8iYLT10chh6G01Z
 +GAy/aajyweh26fQT6SarJLjDjQN0JoPRIL+SDqLH1AZPmPT+tjHnu3Sp6DQLCSvLX8WFphSnOR
 EYydH48IBx3pDPtpZ/2LTjLQVDWHgu4wgxU+FXfDZHK1pYbNIlqIfnnVMx1qZUUffuMHUORUTJR
 klFg9Gxe0LWd1oQY+mQ==
X-Proofpoint-ORIG-GUID: eKdSuGTy27GA7zwAPPQSB4pa7UGCP8Y2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160162
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
DPDK v26.07-rc1

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

On Thu, 2026-06-11 at 04:52 +0200, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=3Dv26.07-rc1
>=20
> There are 432 new patches in this snapshot.
>=20
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_26_07.html
>=20
> Highlights of 26.07-rc1:
> 	- option --pagesz-mem for per-page-size maximum
> 	- option --no-auto-probing for no device at init
> 	- less mempool cache misses in run-to-completion
> 	- peek style API for staged-ordered ring
> 	- RISC-V vector paths
> 	- PTP helpers and clock relay example
> 	- selective Rx API to save PCI bandwidth
> 	- vhost memory hotplug
> 	- pcap driver enhanced
> 	- LinkData sxe2 NIC driver
> 	- AI review helpers
>=20
> Important note:
> Pipelined applications, where ethdev Rx and Tx run on separate
> lcores,
> should adapt to the new algorithm by doubling their configured
> mempool
> cache size, to avoid doubling their mempool cache miss rate.
>=20
> Please test and report issues on bugs.dpdk.org.
>=20
> We plan to release -rc2 in 2 weeks.
>=20
> Thank you everyone
>=20
