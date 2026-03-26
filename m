Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8329A10AB819
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 20:04:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E45A40297;
	Thu, 26 Mar 2026 21:04:50 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1]) by mails.dpdk.org (Postfix) with ESMTP id 8853E40274
 for <dev@dpdk.org>; Thu, 26 Mar 2026 21:04:48 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62Q7m8S93422231; Thu, 26 Mar 2026 20:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Q8gD2S
 ZRb8dP1cI/z3FO2USfIgnjEu6kbJEYIIrVNWY=; b=ZUWCDwRjUpUqvd73Q7E+9v
 woGnDnfqVZEXaEASzbWUZSrJsIdnOMSl623yDtTx181GWKRPA25xP4RYUIHuXMlD
 2WVc9S/w8FKfqDsVj8jTr2NwJhwC7mje2S5OoLCygLKrUXjKUTcNEIvbYOoA1P4U
 Yt76Oi4yrUYuQN4YvjQLjqfB4IQP+h1SRotEmiwKZGhldLaMlejcYIqOVaXKCbqV
 iF5pJe2iPGW4lUBT5RZgopHf931rSB+lmd+yZZv+5+8+8DMLAGk+2jEyGEb+CBUI
 x51Vb6jlmCL0JpbuljS30SNEwjT6KMJ853/sy5PDZumeP8sFPv9DIkZr59kEPcOg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa718m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 20:04:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QJHloY031687;
 Thu, 26 Mar 2026 20:04:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nt4n74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 20:04:46 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62QK4jTA32047778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2026 20:04:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D337B58066;
 Thu, 26 Mar 2026 20:04:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8C715804B;
 Thu, 26 Mar 2026 20:04:45 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.ibm.com (unknown
 [9.24.10.250]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Mar 2026 20:04:45 +0000 (GMT)
Message-ID: <b22fa9c189c35e47ff187d94ea1cbfe6345a9ff6.camel@linux.ibm.com>
Subject: Re: DPDK release candidate 26.03-rc2
From: Riley Fletcher <rileyf@linux.ibm.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Date: Thu, 26 Mar 2026 15:04:45 -0500
In-Reply-To: <2739036.tIAgqjz4sF@thomas>
References: <2739036.tIAgqjz4sF@thomas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tHe81OddIc6nlCjyepke2iOEDO7F0F5H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE0MiBTYWx0ZWRfX/WKPWKZiI1c7
 kv++1ZgnR0YFrdDv4o4uKzRYzbTJUohcXu7coirWiz5gVFGgIeOtP5FcstdAOp5SQ2LXLNw6e3Q
 IWdWWJEKs46wPhKYCmCXfMefDkqlOMA+1TaqOUS/DCMbspB5zbfC2TOvwfkwA7BYIk2IOVUeKo2
 TYGCQ75vMqV3GoPOOVxP4fsa68MD0dFZCFb/IHvXMObN7h2VejldxNg1Pr1K/o/TFp7yCHmrChj
 Hpf8arfbS73FfdSImx34IGRFPSFx7rg19HMLlC+L7LbH5Zmiy64jMFN9gEulcHt2fS85m+IBD3k
 IVWlorh75wlC6Nd6KzTagMqSISHDRe1OKVEBw/WEy5lUbGWcQHJoQkif+jAmC3ks8svnbOAgT21
 ZnCXkvDDSv0TzWVf41JowfXGmOhABiUGpmgq1rlj4oXlCpKLCk/d4LK+hBMduEuiqVX4GIZt2IR
 4Hly5bnnAFNvmQS+/1A==
X-Proofpoint-GUID: tHe81OddIc6nlCjyepke2iOEDO7F0F5H
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c5915f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=8rWy6zfcAAAA:8
 a=BM12gX2uUI6iyhg_oEsA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260142
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
DPDK v26.03-rc2

* Build CI on Fedora 40, 41, 42 and 43 container images for ppc64le
* Basic PF on Mellanox: No issues found
* Performance: TestPMD single core tests on ConnectX-7 25GbE
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

On Tue, 2026-03-17 at 18:16 +0100, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=3Dv26.03-rc2
>=20
> There are 230 new patches in this snapshot.
>=20
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_26_03.html
>=20
> There are many fixes and new drivers features.
>=20
> Please test and report issues on bugs.dpdk.org.
>=20
> Patches to improve tooling, examples and documentation are welcome.
>=20
> We are very short in time, so -rc3 must be released on next Tuesday,
> March 24th. Then the release should be closed a week later.
>=20
> Thank you everyone
>=20
