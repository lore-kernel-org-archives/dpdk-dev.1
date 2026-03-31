Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B466E109B47A
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 14:39:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C17A6402D3;
	Tue, 31 Mar 2026 16:39:25 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1]) by mails.dpdk.org (Postfix) with ESMTP id 46FC0402C3
 for <dev@dpdk.org>; Tue, 31 Mar 2026 16:39:24 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62V29laO3535583; Tue, 31 Mar 2026 14:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sOmylo
 S/uY6VUzIldpzVjlzSSZ7fGDxZcKXnYeNpQ4U=; b=Y0hG+9Te/lKBBGBMrY4+hB
 wTEsRSRSUy4nZB5Y52mbF1sqMJgNxC61Pl2OETJgXhkupzT1bWTcKFDHIr6E6T72
 qeZvEb7QAlNKvO6drUPyotfdffei2QmS267a62J4KRzoHZAueMQuXc9qjFvhWxuy
 3hdF4GW0f32BFjwMT0cIo8GP/N5OAS3MR2Pgmz0pOa+r//iW+XSRh+Pj/CI4gKMb
 Dco+Hz+2jknzMu63OhMcAcG+mUz/H4PnHD/de8/XRckgZxsP7G6zE+0vFxw6QP4b
 h3iKXrMr3NPhO0oGh2kkG9mhEYmktjUN5wlEyy9eHJ2V0z/PWffAv+mgFhe8H6jQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnksnm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 14:39:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VC744i013897;
 Tue, 31 Mar 2026 14:39:22 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkhdre-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 14:39:22 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62VEdLqM27460100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2026 14:39:21 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97E6D58058;
 Tue, 31 Mar 2026 14:39:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C1475805B;
 Tue, 31 Mar 2026 14:39:21 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.ibm.com (unknown
 [9.24.10.250]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 31 Mar 2026 14:39:21 +0000 (GMT)
Message-ID: <6ef072f2871cb5d99e38ae635318a4924f8bb9c5.camel@linux.ibm.com>
Subject: Re: DPDK release candidate 26.03-rc3
From: Riley Fletcher <rileyf@linux.ibm.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Date: Tue, 31 Mar 2026 09:39:21 -0500
In-Reply-To: <4340093.KlZ2vcFHjT@thomas>
References: <4340093.KlZ2vcFHjT@thomas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WUqaf-6XXGuQ1bKn2Af_bBDypWBKMcSv
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cbdc9b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=8rWy6zfcAAAA:8
 a=o0H6PxKc5kZCS8mi02EA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEzOSBTYWx0ZWRfX8f6BcQq+IKo/
 mUUxN9C5/y0sp28uxLiHa54O53QmUHXU6pM3aU5L8MfXzcwO9ev5W7sbYzd3gpWNhYe8cHn4t1I
 WC540TygVNb+nwUxjKc/+X8mAs6Gua31Gph/LW8rkcdh5uTUKfltq54yg00mAnc3XnqdsxiM7P5
 1wecXyTzWMhU4X8zRAZ0uH4LQOS5va6+gUa9z9+uEmvYB08aZ+HnjXS3hTOfu8dcrBK6QUV6Vpx
 NGMxf9gZBPNctwHau37xyFjnsvwQILkgewBNwregK/Z9w7svQ/2ypE49E2nZH8f61IhrgZDqvVG
 M9DRDTC9zJWhdq2kCXwUkB3LGQ26Uh8Yef9flkNpMWZxmqW94vk26GeZNtn6yqlu97rz5SVzMyt
 NW/npLNMl8z6SoIbvDEQrXPw8koU0xUm/AP1j6ZNYpPJSFxQ4A0OiLaGy57xDV5ZYNZI53UoIU/
 XldXSLCGpzWUmP+qSVQ==
X-Proofpoint-ORIG-GUID: WUqaf-6XXGuQ1bKn2Af_bBDypWBKMcSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310139
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
DPDK v26.03-rc3

* Build CI on Fedora 40, 41, 42 and 43 container images for ppc64le
* Basic PF on Mellanox: No issues found
* Performance: TestPMD throughput single core tests
* OS:- RHEL 10.1  kernel: 6.12.0-124.39.1.el10_1.ppc64le
         with gcc version 14.2.1 20250110 (Red Hat 14.2.1-7)

Systems tested:
  - LPARs on IBM Power11 CHRP IBM, 9105-22A
     NICs:
     - Mellanox Technologies MT2910 Family [ConnectX-7 25 GbE 4-Port]
     - Mellanox Technologies MT4129 Family [ConnectX-7 100 GbE 2-Port]
     - Firmware Version: 28.47.1088
     - OFED 26.01-1.0.0

Regards,

Riley Fletcher

On Thu, 2026-03-26 at 01:14 +0100, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=3Dv26.03-rc3
>=20
> There are 65 new patches in this snapshot.
>=20
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_26_03.html
>=20
> Please test and report issues on https://bugs.dpdk.org
>=20
> You may share some release validation results
> by replying to this message at dev@dpdk.org
> and by adding tested hardware in the release notes.
>=20
> More tooling and documentation could be added before closing 26.03.
> The final release will happen in a few days, at the end of the month.
>=20
> Thank you everyone
>=20
