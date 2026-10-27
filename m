Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1953606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qyRnZ4x0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FA25400D7;
	Tue, 27 Oct 2026 16:39:55 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by mails.dpdk.org (Postfix) with ESMTPS id B356C400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 16:39:53 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69REE8ai1050341; Tue, 27 Oct 2026 15:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=foGnV5
 AAaTHMFlLRyXzAL5eK4X5/qBxx3soVdfDoFok=; b=qyRnZ4x07JUxOu6MKs8Gz7
 cx+cTW+//2HLGyJOG/ns2Z94YCOtGIl4O89sdSasP0Nxf1O5gY8P4nJ/ExMly+eS
 WPd3y63ULeZVFv0SacIyBGyYxoiJUWWsAq1RfbxIFGbmNCObMDeFM7zbFYutnEJ1
 qwPT0S+7SILGe9CJOgpGBDmVktf1InIeqAWBQbDEIUjyHppGCSkhxDjYoWadY15a
 3enm/Zwt4tvvPP96mwqVIP4jmyuCVxZ2dKf8OFbwOp/Y+Fc34g/4GdssGc8sSXwm
 oE9isqwdUE8qbRcPcBqDrF6f0CEss2MlFGb2l4iAk1dYpCEa8DAbXQhjZhzc6bnA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbt094a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 15:39:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoMOx098143; Tue, 27 Oct 2026 15:39:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjvh1rn12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 15:39:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69RFdoY730016046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2026 15:39:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E0BF58059;
 Tue, 27 Oct 2026 15:39:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B74558058;
 Tue, 27 Oct 2026 15:39:50 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.ibm.com (unknown
 [9.16.50.223]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2026 15:39:50 +0000 (GMT)
Message-ID: <4eae20d874bb4a6e347320cf8655eb2adbe755b1.camel@linux.ibm.com>
Subject: Re: DPDK release candidate 26.11-rc1
From: Riley Fletcher <rileyf@linux.ibm.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Date: Tue, 27 Oct 2026 10:39:49 -0500
In-Reply-To: <MhL9-e6MSdueACnSJljpbA@monjalon.net>
References: <MhL9-e6MSdueACnSJljpbA@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MCBTYWx0ZWRfXyV7PaCI8kHHr
 aBtiCmbxipnWXxr2LHplPzviXPZYJMRJ13iz+AI540VP/bN4n3AUwBXbEQ9Zt49F8fLec+hy2nw
 NxhBbzPbeF6/xiQydXRbLh7A0uxf5v/5B8y/6C/483uBIuzFfcWzIfG9Ad9+pca6d+w+H1k4Ro1
 CTJCTlKx/+pwzTNO5WKw9Q6dEUYM21T7NnCok3yiGkSoU9g4OUYAQNt69A5kegNhUn5FkF5IzCX
 +LFLyJoIMt08RNPhp9M4LgVbCqKHClJOQsYkUUIL0hdfqz0WfnFI0wCdWOCbDVcGl9VzNAKc+T7
 DcaiMNrmZZ2XONM5ry1ivzc9wbvM8BbyP5LcqHvDUGPLuqr+NAOYyWhKJble5bZ2LOI3s8X1Pgl
 Y1LS2pDfJsYrHBeMdbvJpaKIUpO5JVqgtMTDMljKMV0BbNPu0mOkLRpi7EZ2FzNlhuGnAMVEa6Y
 cqINOhquJgkm/xGdDQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MCBTYWx0ZWRfXyy1E/SjfBuri
 4PU5ws67/eHOgTFMOklnoi731MaifXnjehlavbnGgWfsygv46N+WcSQlEKAdms8/uDmaeqViKiQ
 /qWLu+7lgk5M8l2xw0nYsQ+neOQ+OW0=
X-Proofpoint-ORIG-GUID: aaQEUQBs0ci0AEBhUzf2CDx0do2TC4cP
X-Proofpoint-GUID: aaQEUQBs0ci0AEBhUzf2CDx0do2TC4cP
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae0c5c7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=8rWy6zfcAAAA:8
 a=o0H6PxKc5kZCS8mi02EA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270060
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

IBM - Power Systems Testing
DPDK v26.11-rc1

* Build CI on Fedora 40, 41, 42 and 43 container images for ppc64le
* Basic PF on Mellanox: No issues found
* Performance: TestPMD throughput single core tests
* OS:- RHEL 10.2  kernel: 6.12.0-211.64.1.el10_2.ppc64le
         with gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4)

Systems tested:
  - LPARs on IBM Power11 CHRP IBM, 9105-22A
     NICs:
     - Mellanox Technologies MT4129 Family [ConnectX-7 100 GbE 2-Port]
     - Firmware Version: 28.48.1000 (MT_0000000834)
     - OFED 26.07-0.7.7

Regards,

Riley Fletcher

On Fri, 2026-10-16 at 03:45 +0200, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=3Dv26.11-rc1
>=20
> There are 698 new patches in this snapshot.
>=20
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_26_11.html
>=20
> Highlights of 26.11-rc1:
> 	- pile stack-like container and mempool driver
> 	- interrupt FD leak detection
> 	- VFIO API made internal
> 	- VFIO character device
> 	- Device Tree matching in platform bus
> 	- module EEPROM decoding
> 	- flow graph parser for drivers
> 	- RSA capability parameters
> 	- AMD AE4DMA driver
> 	- NXP i.MX95 eDMA5 driver
> 	- baseband statistics per queue
> 	- auto-detection of uncore power driver
> 	- graph profiling
> 	- eBPF validation tool
> 	- removal of deprecated API
>=20
> Please test and report issues on bugs.dpdk.org.
>=20
> We'll try to release -rc2 before the end of the month.
> That leaves us less than 2 weeks to add more driver features.
> Adding library features after -rc1 would be an exception,
> but it's still possible.
>=20
> Note: Security updates for several LTS branches were released this
> week.
> To receive advance notice of future security releases, you can
> request
> to be added to security-prerelease@dpdk.org=C2=A0by emailing
> techboard@dpdk.org.
>=20
> Thank you everyone
>=20
