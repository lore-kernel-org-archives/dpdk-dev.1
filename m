Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081B6FD88CA
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 22:53:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B7F8402F2;
	Tue, 10 Mar 2026 23:53:44 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5]) by mails.dpdk.org (Postfix) with ESMTP id 2C226402DC
 for <dev@dpdk.org>; Tue, 10 Mar 2026 23:53:42 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AKfSWl1596414; Tue, 10 Mar 2026 22:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9gpIK9
 xpDov+S8gRsj3zbC70Xt+RDREAfnFwf4uP+7o=; b=GOe4Y2/k9rIjDVHgvmQ+Aj
 wJ7ZexKOi/w4/L9jRPyC92xqgIWFUt5Z20sr8uTKfC3CK9wDrsm7jYS9keiZmY/3
 GR2lx5U5DLBW208EVU8KU7CZgZS6D18l4RqnHOo6ayZMjPl5nUn1TO1jXcr+vpmP
 mrndt1wos4SZZFH+PUQNbg/ppcYXEo96lIBiagLjx07sfJHQkHKzacZWzOX0gchW
 jGM5xsmPLDqSo0E3SH5eUFLTGVl9bxKPa7N9HKSkm6ksX1M+nACBdjFzMRXYYgL/
 53i6MQx2Tcy6nFm0cw16W94rhn9vrtFeb/Fg7xRRn99wvWCQ3pgHdWDm422kd86Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvrcw5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 22:53:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AIueJC021164;
 Tue, 10 Mar 2026 22:53:40 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsu7rr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 22:53:40 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AMrdF627132616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 22:53:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6D855805D;
 Tue, 10 Mar 2026 22:53:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A8805805B;
 Tue, 10 Mar 2026 22:53:39 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.ibm.com (unknown
 [9.24.10.250]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 22:53:39 +0000 (GMT)
Message-ID: <fbb2a3f3dc2d504a414c16dcf4a8258f9a2fbbfb.camel@linux.ibm.com>
Subject: Re: DPDK release candidate 26.03-rc1
From: Riley Fletcher <rileyf@linux.ibm.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Date: Tue, 10 Mar 2026 17:53:39 -0500
In-Reply-To: <13563702.xXuK6brfV6@thomas>
References: <13563702.xXuK6brfV6@thomas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE5MiBTYWx0ZWRfXwOtSld/Fr6EX
 OpY0M9hCbsQvIAr0pmXE6ca8TbEWOFgLyLLedaLsxIO/LxpYluZ3p4rTy7L2OqMP5dEUW3q6mCs
 A7AoEOnDf7aGrQ72uyhVctdGFBkRg/hXFm3UgSnPqrCzEMx7vNApacZ7vSFMhV5/tLrqUDTvAOO
 ne2cMsqw8mOkydokXY2Ag7uSDL5J8y7gA61lPVH1yPNVZDhJUJ0csYDyMvG5LLkI8Cp85DDjzSj
 EnD1vqXDeOVNapNnP25gd5YftIt5OCm5dWvD910NqELQIhFgaVdOJU/29MLILPaEz8gAMuFW/Cr
 QleZ8afTMYySl8Pd0b6vOfA1FxA8rb+Z4zDtFF6LGQcI4dI58u/2ia5ps/GERiZYM4rLGCLcWmG
 IojfSreQVm98x0pMgs87x39qys5zrJLfiDMWFZfdnDA/flr4cXAEzyxOF9pa1Os3lTYGbbr6dbD
 Z7tTOP3U+UQ3NRlzT7g==
X-Proofpoint-GUID: 2uae0veJE6Oqu9g_JSp_NVQbAfikkcYg
X-Proofpoint-ORIG-GUID: 2uae0veJE6Oqu9g_JSp_NVQbAfikkcYg
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69b0a0f5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=8rWy6zfcAAAA:8
 a=6RNKHe5SAztSyEFc6eUA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100192
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
DPDK v26.03-rc1

* Build CI on Fedora 40, 41, 42 and 43 container images for ppc64le
* Basic PF on Mellanox: No issues found
* Performance: TestPMD single core tests on ConnectX-7, no issues found
* OS:- RHEL 10.1  kernel: 6.12.0-124.39.1.el10_1.ppc64le
         with gcc version 14.2.1 20250110 (Red Hat 14.2.1-7)

Systems tested:
  - LPARs on IBM Power10 CHRP IBM, 9105-22A
     NICs:
     - Mellanox Technologies MT2910 Family [ConnectX-7 25 GbE 4-Port]
     - Firmware Version: 28.47.1088
     - OFED 26.01-1.0.0

Regards,

Riley Fletcher

On Tue, 2026-02-17 at 23:30 +0100, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=3Dv26.03-rc1
>=20
> There are 356 new patches in this snapshot.
>=20
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_26_03.html
>=20
> Highlights of 26.03-rc1:
> 	- ACL custom memory allocation
> 	- cryptodev 256-bit NEA/NCA/NIA algorithms
> 	- OpenSSL AES-XTS and SHAKE algorithms
> 	- BPF atomic XCHG instruction
> 	- no more format overflow in libraries
> 	- no more variable shadowing
>=20
> Please test and report issues on bugs.dpdk.org.
>=20
> We plan to release -rc2 in 2 weeks.
>=20
> Thank you everyone
>=20
