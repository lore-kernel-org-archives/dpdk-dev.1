Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D0AC44501
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Jul 2026 15:44:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 746CC40289;
	Tue, 14 Jul 2026 17:44:17 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5]) by mails.dpdk.org (Postfix) with ESMTP id B2C114026E
 for <dev@dpdk.org>; Tue, 14 Jul 2026 17:44:15 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEfiDf1528151; Tue, 14 Jul 2026 15:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BEWQlf
 OkoeLJjTHuIX6elapunEzMFNtnT+xpPkQWVlQ=; b=XY0BZYX9lpPl2mLZzt4eCc
 JoiJC6HqL0+9Pi7o1i7RGtM1ZaQoKnf7Kgz5b6c7jQrctpbaehevgTZBpDok4hsq
 eYTCTKuL3OAACskag0bgMTCiCZIgmgV++TCJB8dkyqsPg+vtoesctJfMhJ5uu7v3
 YOrtV4ch2hPD6YuK1HOEoFyOIuHjKS20inmk6AITm2XNaLvnpfyoe2ekj56A2Cly
 7J8QP6duxEqlP2tLQnHLPyTbRNW6CpvGr25WsWC5kVxpTTaXipWnb4EpEdxp3eRF
 UE/ieELJlFkzezgpFzHvzJfC7ylLU9hpQQtW08KR/lOFbl0TVA3a7ej7XihAxVkg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a6g7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 15:44:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EFYeSQ013867;
 Tue, 14 Jul 2026 15:44:14 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw3n52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 15:44:14 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EFiDkB29819554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 15:44:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EC6658059;
 Tue, 14 Jul 2026 15:44:13 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A0B758043;
 Tue, 14 Jul 2026 15:44:13 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.ibm.com (unknown
 [9.16.50.223]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 15:44:13 +0000 (GMT)
Message-ID: <e0cd84465c1d1d8ed169c29f1a492f41645f79ee.camel@linux.ibm.com>
Subject: Re: DPDK release candidate 26.07-rc2
From: Riley Fletcher <rileyf@linux.ibm.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Date: Tue, 14 Jul 2026 10:44:13 -0500
In-Reply-To: <CP3kiV_jTf67aEg8Usilhg@monjalon.net>
References: <CP3kiV_jTf67aEg8Usilhg@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2MyBTYWx0ZWRfXyKArbzBUaoKZ
 P8W75592K53y1w8bH5+RaaXpKlVJQwm5bd3yhligqmTBNJf8Tmi/9xos+1Q3FUihjU9VTzinsMP
 8SU5WsIPPvMnSrWOPp7wrPe+ag12CTo=
X-Proofpoint-GUID: xVw9pkbfPQ4nqGbWuVHP-OOWpZLejoua
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2MyBTYWx0ZWRfXzJb+Eq6YysRX
 C8CwtfM7pWyMrSuBiug6gP0W5kAUtuUIK26ELqXGNXWlgovGXYW+w+S8T2adrEXa8956409Fw5f
 MI5XN0bagy+oni2gvpiJuiIrCh9J66EkY9ar8jIJg8EdC2VPMZFtbHBA41TzE5msZJNh+U/W5oX
 JvR+HeQYVRXql4XU79UswGRQ5Ro7z5hf/JzmCQGczj2rWs/jFYnRavcsSgQczqhebKN8XyaHov1
 RRAC1yxnq/D4pGufOjQzaFhrRNdKws3QR+Zj/I7cRMK+rKX7qH5eik0Z86oZyD3H2/MZFDg16N1
 xPc5cXrMMEWswgQc20dn6xyd697rXUATl+Omz66kTlGwEPdTMaycy447daHUCgpYTKwZYdZDg+H
 Ul8s+Q5ihRmomWYSGXYLk8/xLJH+fR3EwEtCdz/C0VQrUy6I4dPBeZJwGxnLxevDbMt91sGB7dB
 He9fEpfoI5yzCb3gjow==
X-Proofpoint-ORIG-GUID: xVw9pkbfPQ4nqGbWuVHP-OOWpZLejoua
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a56594e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=8rWy6zfcAAAA:8
 a=o0H6PxKc5kZCS8mi02EA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140163
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
DPDK v26.07-rc2

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

On Fri, 2026-07-03 at 04:58 +0200, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=3Dv26.07-rc2
>=20
> There are 289 new patches in this snapshot.
>=20
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_26_07.html
>=20
> There are many fixes and new drivers features.
>=20
> Please test and report issues on bugs.dpdk.org.
>=20
> Patches to improve tooling, examples and documentation are welcome.
>=20
> Thank you everyone
>=20
