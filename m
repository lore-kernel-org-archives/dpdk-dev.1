Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76739CFA446
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 21:48:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 294B140285;
	Thu, 20 Nov 2025 22:48:31 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1]) by mails.dpdk.org (Postfix) with ESMTP id 03C2740267
 for <dev@dpdk.org>; Thu, 20 Nov 2025 22:48:29 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKCu2YA029048;
 Thu, 20 Nov 2025 21:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HpI7ZK
 UuaRw9lwV5heOjAz66a1pkGa0dTXtvg4gNixk=; b=tOJtzw2J7BQkUOr/fFMMcv
 elJ0wOabt8W8adDnqctI9IhgYIOUZubCJBzu1JilKe6cX1TYkxT0qFcWIrJFpjsH
 CuCIHYHFGR0JnSZhcwNucFqzfDgodbIfy/8yCMzpCCd6T+3rWKjxlkko2stIZrM6
 ZoxH2KeLBzLHrQoL9vN9DBLDanLqMA/gAbT/KytENndjQAOhuJ9zZ2HqNRgdddv3
 Bv+L0QZS9qqeDU66dA+bJNW+JwJd7H4F1Sai+H6ITjxideabeBeHv/Ryge4dnQos
 fRwl92JdlB/ZBtjWAelaEtG5F0lJYkNY5u0lJmbGJSC/vQDp9wvBVeDxZRxN3GtQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1rvc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Nov 2025 21:48:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKKLfSQ022386;
 Thu, 20 Nov 2025 21:48:27 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4un8tq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Nov 2025 21:48:27 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AKLmQS124576604
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Nov 2025 21:48:27 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DF2158055;
 Thu, 20 Nov 2025 21:48:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44C325803F;
 Thu, 20 Nov 2025 21:48:26 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.ibm.com (unknown
 [9.61.17.251]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Nov 2025 21:48:26 +0000 (GMT)
Message-ID: <80e44945549c8d2cfe1695f4bc2fdb0b39488e81.camel@linux.ibm.com>
Subject: Re: DPDK release candidate 25.11-rc3
From: Riley Fletcher <rileyf@linux.ibm.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Date: Thu, 20 Nov 2025 15:48:25 -0600
In-Reply-To: <2831295.atdPhlSkOF@thomas>
References: <2831295.atdPhlSkOF@thomas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691f8cac cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8rWy6zfcAAAA:8 a=T-I4Skbq5JKMQ5GKcoYA:9 a=QEXdDO2ut3YA:10 a=vwQxE1H_xY0A:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: 55DMkKhrT1eo8o9e4q99ySocCzsFK2Ob
X-Proofpoint-ORIG-GUID: 55DMkKhrT1eo8o9e4q99ySocCzsFK2Ob
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX3NxFZWBJDtcL
 G2BHYqwN7kIvuCd4Nm4NJzZhiu/regxMiV1lT3mImHVrvijAGNkmLdPmEQ4eaiK/waKMvxfInk3
 1E0URjaCMm5gUO4cAmOFlIv6QeUseO9qSbRbgqblBSv1RlfAmxH5kUhSyFD+L8chG9ctyi2YW8Z
 A3MSmpIeVb9lKJgDnMeLN9Tn/evOI8Uc4hPTYe4zQ/gD9pCFmGPYtiUB05UnVrZEnDfY3pLfCXa
 +WKK9cry+V1ykSuFoWyK2GuaAz5aEvvUUwPhV8DZF/scCv31NWMOcMHnQCyk4SD0Y/QDx6qIEg3
 kMOv4gYB6JQ8SdCsXpN6Ywp2sQXEcE5TVVKeotLufqhshq2MKJJ+/+bQX+9vimhxMOef/dp0ZWP
 7QWI0sEn8TjF1IXvMriyYcNzNvwdtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_09,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032
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
DPDK v25.11-rc2 and v25.11-rc3


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

On Wed, 2025-11-19 at 05:50 +0100, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=3Dv25.11-rc3
>=20
> There are 98 new patches in this snapshot.
>=20
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_25_11.html
>=20
> Please test and report new issues on https://bugs.dpdk.org
>=20
> The next release candidate (-rc4) is planned for Monday 24.
> Patches and reviews for examples, tooling and documentation are
> welcome.
>=20
> Thank you everyone
>=20
