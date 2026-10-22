Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455E5606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bDquChkX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3731A4027D;
	Fri, 23 Oct 2026 00:03:03 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1]) by mails.dpdk.org (Postfix) with ESMTP id 90A5440264
 for <dev@dpdk.org>; Fri, 23 Oct 2026 00:03:01 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIE0Xr747065; Thu, 22 Oct 2026 22:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=lNnnO5Mft3om/1s6vfdsXEedbixVIEqY5vGD96hd0
 nA=; b=bDquChkXnJUzNK8ZfwJazowj187jYd3DXabhmjL4RXXNTyBKdu+cJND+j
 zaasvlsmw/OPOc8ViCNmc2GyCa0F220w1DGvbtTOSBc5b5ZwBWdQz14QpCKnMEH7
 d+bRx5mVqDaRkhALr0odaNhlAlI76VZFc8bN3l7kxlyIREJIttNsKDw8dI1GtU7i
 kN1DVJKVQM3pO6L5fAC2X2/4fsKOqpL0vJMH0dyxxBw02FxfY4WrI2TcNr8Ok/hl
 WAlaBi7+pIdPxJw1rXQibIz6mzGOcsZbF+jn14NIyw5zKQ2Zm9iuowke0cIa/Ihw
 DX52GUcQXtVhY3x3YaAknnI1Qw0YA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw591u23-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2026 22:02:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MM2eoD823840; Thu, 22 Oct 2026 22:02:55 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfkg21wvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2026 22:02:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69MM2sx326804852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2026 22:02:55 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C740858056;
 Thu, 22 Oct 2026 22:02:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71EC45803F;
 Thu, 22 Oct 2026 22:02:54 +0000 (GMT)
Received: from ltcrain65-lp7.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Oct 2026 22:02:54 +0000 (GMT)
From: Riley Fletcher <rileyf@linux.ibm.com>
To: probb@iol.unh.edu, luca.vizzarro@arm.com
Cc: dev@dpdk.org, Riley Fletcher <rileyf@linux.ibm.com>
Subject: [PATCH] dts: update cryptography dependency to avoid test discovery
 failure on ppc
Date: Thu, 22 Oct 2026 18:04:00 -0400
Message-ID: <20261022220400.398135-1-rileyf@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GFhBupy_p33Jlg7H9xD63CLnjtdecdKJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfXxxfjqfcVpFi4
 ZdMyks5XvBPNqXRyCCe8AW5LB2CBrR1IMjbtN1++q+PtDDB6F/fkPyITVUe78Esfg6N/4Sgqpzl
 deYVZgO82OWxKQyq2Z4UX92q2dapGl0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfX/5qDqdjQmbW8
 SSzorL0lfQsNn5axS2Pm7mJNJNixDwsxIAmvfz9Ml6vu8H6MT7wAJzvR2GA2xOaS2BGl8ubzjYh
 AtXWqc2uYQEc9vTiodn9hRWSdKGgloBcciiA7IXmGgZ9MX3GiafnB9HCkbZlN+tkrPunx1mfW22
 G0q9S1LJdBSZ1Sv61CVPwJEDcFj47JEumi2hHzbQlyBfsrXDUlw7/zlLkV6FnjiWsQ5cUG/Mb2/
 5TygiqGfcqVMWsPrY7gWYCkcZFTEXJZtT8bLRDzTXCDUglM9s04VLuiB3FfT23Wkj9j7sGndgoY
 e7goVtOCrP938ybz7qoaMSIUg4JsErpXNFl62Plm458anRMGeYB73fYyqvQRFaoAzqdTZ43AKYF
 rzY2fFvogn/TC1JRQrX2wkC9Pr7b0DFgclKNLT3GzNR3c72K8h1SxczjYye7QR3gMdBRKCgxwK2
 nWhSvtbrUJodDwrt4EA==
X-Proofpoint-ORIG-GUID: GFhBupy_p33Jlg7H9xD63CLnjtdecdKJ
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6ada8810 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=yqFE0Fts74EKati2zKcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220086
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On ppc64le, Poetry installs cryptography 44.0.0 from source because no prebuilt wheel is available. This resulting wheel includes a top-level "tests" package.

DTS discovers test suites via importing the "tests" package. Since DTS tests are a namespace package, the cryptography regular package shadows and supercedes DTS tests.

As a result, AVAILABLE_TEST_SUITES is empty and DTS fails to load any configuration:

test_suites.0
    Assertion failed, hello_world is not a valid test suite module name.

Updating cryptography resolves this conflict.

It should be noted the 44.0.0 wheel was tested on x86 and no top-level tests regular package was found. It is recreatable on ppc64le, so it appears this issue arises from the ppc64le build process in particular.

If this proposed change is problematic for any reason, further investigation can be done into which particular crytography version resolves this as opposed to most recent 55.0.2.

Signed-off-by: Riley Fletcher <rileyf@linux.ibm.com>
---
 dts/poetry.lock | 293 ++++++++++++++++++++++++++++--------------------
 1 file changed, 169 insertions(+), 124 deletions(-)

diff --git a/dts/poetry.lock b/dts/poetry.lock
index eda7cc2fec..814a1759e1 100644
--- a/dts/poetry.lock
+++ b/dts/poetry.lock
@@ -1,4 +1,4 @@
-# This file is automatically @generated by Poetry 2.3.2 and should not be changed by hand.
+# This file is automatically @generated by Poetry 2.5.1 and should not be changed by hand.
 
 [[package]]
 name = "aenum"
@@ -109,134 +109,193 @@ typecheck = ["mypy"]
 
 [[package]]
 name = "cffi"
-version = "1.17.1"
+version = "2.1.1"
 description = "Foreign Function Interface for Python calling C code."
 optional = false
-python-versions = ">=3.8"
+python-versions = ">=3.10"
 groups = ["main", "dev"]
 files = [
-    {file = "cffi-1.17.1-cp310-cp310-macosx_10_9_x86_64.whl", hash = "sha256:df8b1c11f177bc2313ec4b2d46baec87a5f3e71fc8b45dab2ee7cae86d9aba14"},
-    {file = "cffi-1.17.1-cp310-cp310-macosx_11_0_arm64.whl", hash = "sha256:8f2cdc858323644ab277e9bb925ad72ae0e67f69e804f4898c070998d50b1a67"},
-    {file = "cffi-1.17.1-cp310-cp310-manylinux_2_12_i686.manylinux2010_i686.manylinux_2_17_i686.manylinux2014_i686.whl", hash = "sha256:edae79245293e15384b51f88b00613ba9f7198016a5948b5dddf4917d4d26382"},
-    {file = "cffi-1.17.1-cp310-cp310-manylinux_2_17_aarch64.manylinux2014_aarch64.whl", hash = "sha256:45398b671ac6d70e67da8e4224a065cec6a93541bb7aebe1b198a61b58c7b702"},
-    {file = "cffi-1.17.1-cp310-cp310-manylinux_2_17_ppc64le.manylinux2014_ppc64le.whl", hash = "sha256:ad9413ccdeda48c5afdae7e4fa2192157e991ff761e7ab8fdd8926f40b160cc3"},
-    {file = "cffi-1.17.1-cp310-cp310-manylinux_2_17_s390x.manylinux2014_s390x.whl", hash = "sha256:5da5719280082ac6bd9aa7becb3938dc9f9cbd57fac7d2871717b1feb0902ab6"},
-    {file = "cffi-1.17.1-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl", hash = "sha256:2bb1a08b8008b281856e5971307cc386a8e9c5b625ac297e853d36da6efe9c17"},
-    {file = "cffi-1.17.1-cp310-cp310-musllinux_1_1_aarch64.whl", hash = "sha256:045d61c734659cc045141be4bae381a41d89b741f795af1dd018bfb532fd0df8"},
-    {file = "cffi-1.17.1-cp310-cp310-musllinux_1_1_i686.whl", hash = "sha256:6883e737d7d9e4899a8a695e00ec36bd4e5e4f18fabe0aca0efe0a4b44cdb13e"},
-    {file = "cffi-1.17.1-cp310-cp310-musllinux_1_1_x86_64.whl", hash = "sha256:6b8b4a92e1c65048ff98cfe1f735ef8f1ceb72e3d5f0c25fdb12087a23da22be"},
-    {file = "cffi-1.17.1-cp310-cp310-win32.whl", hash = "sha256:c9c3d058ebabb74db66e431095118094d06abf53284d9c81f27300d0e0d8bc7c"},
-    {file = "cffi-1.17.1-cp310-cp310-win_amd64.whl", hash = "sha256:0f048dcf80db46f0098ccac01132761580d28e28bc0f78ae0d58048063317e15"},
-    {file = "cffi-1.17.1-cp311-cp311-macosx_10_9_x86_64.whl", hash = "sha256:a45e3c6913c5b87b3ff120dcdc03f6131fa0065027d0ed7ee6190736a74cd401"},
-    {file = "cffi-1.17.1-cp311-cp311-macosx_11_0_arm64.whl", hash = "sha256:30c5e0cb5ae493c04c8b42916e52ca38079f1b235c2f8ae5f4527b963c401caf"},
-    {file = "cffi-1.17.1-cp311-cp311-manylinux_2_12_i686.manylinux2010_i686.manylinux_2_17_i686.manylinux2014_i686.whl", hash = "sha256:f75c7ab1f9e4aca5414ed4d8e5c0e303a34f4421f8a0d47a4d019ceff0ab6af4"},
-    {file = "cffi-1.17.1-cp311-cp311-manylinux_2_17_aarch64.manylinux2014_aarch64.whl", hash = "sha256:a1ed2dd2972641495a3ec98445e09766f077aee98a1c896dcb4ad0d303628e41"},
-    {file = "cffi-1.17.1-cp311-cp311-manylinux_2_17_ppc64le.manylinux2014_ppc64le.whl", hash = "sha256:46bf43160c1a35f7ec506d254e5c890f3c03648a4dbac12d624e4490a7046cd1"},
-    {file = "cffi-1.17.1-cp311-cp311-manylinux_2_17_s390x.manylinux2014_s390x.whl", hash = "sha256:a24ed04c8ffd54b0729c07cee15a81d964e6fee0e3d4d342a27b020d22959dc6"},
-    {file = "cffi-1.17.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl", hash = "sha256:610faea79c43e44c71e1ec53a554553fa22321b65fae24889706c0a84d4ad86d"},
-    {file = "cffi-1.17.1-cp311-cp311-musllinux_1_1_aarch64.whl", hash = "sha256:a9b15d491f3ad5d692e11f6b71f7857e7835eb677955c00cc0aefcd0669adaf6"},
-    {file = "cffi-1.17.1-cp311-cp311-musllinux_1_1_i686.whl", hash = "sha256:de2ea4b5833625383e464549fec1bc395c1bdeeb5f25c4a3a82b5a8c756ec22f"},
-    {file = "cffi-1.17.1-cp311-cp311-musllinux_1_1_x86_64.whl", hash = "sha256:fc48c783f9c87e60831201f2cce7f3b2e4846bf4d8728eabe54d60700b318a0b"},
-    {file = "cffi-1.17.1-cp311-cp311-win32.whl", hash = "sha256:85a950a4ac9c359340d5963966e3e0a94a676bd6245a4b55bc43949eee26a655"},
-    {file = "cffi-1.17.1-cp311-cp311-win_amd64.whl", hash = "sha256:caaf0640ef5f5517f49bc275eca1406b0ffa6aa184892812030f04c2abf589a0"},
-    {file = "cffi-1.17.1-cp312-cp312-macosx_10_9_x86_64.whl", hash = "sha256:805b4371bf7197c329fcb3ead37e710d1bca9da5d583f5073b799d5c5bd1eee4"},
-    {file = "cffi-1.17.1-cp312-cp312-macosx_11_0_arm64.whl", hash = "sha256:733e99bc2df47476e3848417c5a4540522f234dfd4ef3ab7fafdf555b082ec0c"},
-    {file = "cffi-1.17.1-cp312-cp312-manylinux_2_12_i686.manylinux2010_i686.manylinux_2_17_i686.manylinux2014_i686.whl", hash = "sha256:1257bdabf294dceb59f5e70c64a3e2f462c30c7ad68092d01bbbfb1c16b1ba36"},
-    {file = "cffi-1.17.1-cp312-cp312-manylinux_2_17_aarch64.manylinux2014_aarch64.whl", hash = "sha256:da95af8214998d77a98cc14e3a3bd00aa191526343078b530ceb0bd710fb48a5"},
-    {file = "cffi-1.17.1-cp312-cp312-manylinux_2_17_ppc64le.manylinux2014_ppc64le.whl", hash = "sha256:d63afe322132c194cf832bfec0dc69a99fb9bb6bbd550f161a49e9e855cc78ff"},
-    {file = "cffi-1.17.1-cp312-cp312-manylinux_2_17_s390x.manylinux2014_s390x.whl", hash = "sha256:f79fc4fc25f1c8698ff97788206bb3c2598949bfe0fef03d299eb1b5356ada99"},
-    {file = "cffi-1.17.1-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl", hash = "sha256:b62ce867176a75d03a665bad002af8e6d54644fad99a3c70905c543130e39d93"},
-    {file = "cffi-1.17.1-cp312-cp312-musllinux_1_1_aarch64.whl", hash = "sha256:386c8bf53c502fff58903061338ce4f4950cbdcb23e2902d86c0f722b786bbe3"},
-    {file = "cffi-1.17.1-cp312-cp312-musllinux_1_1_x86_64.whl", hash = "sha256:4ceb10419a9adf4460ea14cfd6bc43d08701f0835e979bf821052f1805850fe8"},
-    {file = "cffi-1.17.1-cp312-cp312-win32.whl", hash = "sha256:a08d7e755f8ed21095a310a693525137cfe756ce62d066e53f502a83dc550f65"},
-    {file = "cffi-1.17.1-cp312-cp312-win_amd64.whl", hash = "sha256:51392eae71afec0d0c8fb1a53b204dbb3bcabcb3c9b807eedf3e1e6ccf2de903"},
-    {file = "cffi-1.17.1-cp313-cp313-macosx_10_13_x86_64.whl", hash = "sha256:f3a2b4222ce6b60e2e8b337bb9596923045681d71e5a082783484d845390938e"},
-    {file = "cffi-1.17.1-cp313-cp313-macosx_11_0_arm64.whl", hash = "sha256:0984a4925a435b1da406122d4d7968dd861c1385afe3b45ba82b750f229811e2"},
-    {file = "cffi-1.17.1-cp313-cp313-manylinux_2_12_i686.manylinux2010_i686.manylinux_2_17_i686.manylinux2014_i686.whl", hash = "sha256:d01b12eeeb4427d3110de311e1774046ad344f5b1a7403101878976ecd7a10f3"},
-    {file = "cffi-1.17.1-cp313-cp313-manylinux_2_17_aarch64.manylinux2014_aarch64.whl", hash = "sha256:706510fe141c86a69c8ddc029c7910003a17353970cff3b904ff0686a5927683"},
-    {file = "cffi-1.17.1-cp313-cp313-manylinux_2_17_ppc64le.manylinux2014_ppc64le.whl", hash = "sha256:de55b766c7aa2e2a3092c51e0483d700341182f08e67c63630d5b6f200bb28e5"},
-    {file = "cffi-1.17.1-cp313-cp313-manylinux_2_17_s390x.manylinux2014_s390x.whl", hash = "sha256:c59d6e989d07460165cc5ad3c61f9fd8f1b4796eacbd81cee78957842b834af4"},
-    {file = "cffi-1.17.1-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl", hash = "sha256:dd398dbc6773384a17fe0d3e7eeb8d1a21c2200473ee6806bb5e6a8e62bb73dd"},
-    {file = "cffi-1.17.1-cp313-cp313-musllinux_1_1_aarch64.whl", hash = "sha256:3edc8d958eb099c634dace3c7e16560ae474aa3803a5df240542b305d14e14ed"},
-    {file = "cffi-1.17.1-cp313-cp313-musllinux_1_1_x86_64.whl", hash = "sha256:72e72408cad3d5419375fc87d289076ee319835bdfa2caad331e377589aebba9"},
-    {file = "cffi-1.17.1-cp313-cp313-win32.whl", hash = "sha256:e03eab0a8677fa80d646b5ddece1cbeaf556c313dcfac435ba11f107ba117b5d"},
-    {file = "cffi-1.17.1-cp313-cp313-win_amd64.whl", hash = "sha256:f6a16c31041f09ead72d69f583767292f750d24913dadacf5756b966aacb3f1a"},
-    {file = "cffi-1.17.1-cp38-cp38-macosx_10_9_x86_64.whl", hash = "sha256:636062ea65bd0195bc012fea9321aca499c0504409f413dc88af450b57ffd03b"},
-    {file = "cffi-1.17.1-cp38-cp38-manylinux_2_12_i686.manylinux2010_i686.manylinux_2_17_i686.manylinux2014_i686.whl", hash = "sha256:c7eac2ef9b63c79431bc4b25f1cd649d7f061a28808cbc6c47b534bd789ef964"},
-    {file = "cffi-1.17.1-cp38-cp38-manylinux_2_17_aarch64.manylinux2014_aarch64.whl", hash = "sha256:e221cf152cff04059d011ee126477f0d9588303eb57e88923578ace7baad17f9"},
-    {file = "cffi-1.17.1-cp38-cp38-manylinux_2_17_ppc64le.manylinux2014_ppc64le.whl", hash = "sha256:31000ec67d4221a71bd3f67df918b1f88f676f1c3b535a7eb473255fdc0b83fc"},
-    {file = "cffi-1.17.1-cp38-cp38-manylinux_2_17_s390x.manylinux2014_s390x.whl", hash = "sha256:6f17be4345073b0a7b8ea599688f692ac3ef23ce28e5df79c04de519dbc4912c"},
-    {file = "cffi-1.17.1-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl", hash = "sha256:0e2b1fac190ae3ebfe37b979cc1ce69c81f4e4fe5746bb401dca63a9062cdaf1"},
-    {file = "cffi-1.17.1-cp38-cp38-win32.whl", hash = "sha256:7596d6620d3fa590f677e9ee430df2958d2d6d6de2feeae5b20e82c00b76fbf8"},
-    {file = "cffi-1.17.1-cp38-cp38-win_amd64.whl", hash = "sha256:78122be759c3f8a014ce010908ae03364d00a1f81ab5c7f4a7a5120607ea56e1"},
-    {file = "cffi-1.17.1-cp39-cp39-macosx_10_9_x86_64.whl", hash = "sha256:b2ab587605f4ba0bf81dc0cb08a41bd1c0a5906bd59243d56bad7668a6fc6c16"},
-    {file = "cffi-1.17.1-cp39-cp39-macosx_11_0_arm64.whl", hash = "sha256:28b16024becceed8c6dfbc75629e27788d8a3f9030691a1dbf9821a128b22c36"},
-    {file = "cffi-1.17.1-cp39-cp39-manylinux_2_12_i686.manylinux2010_i686.manylinux_2_17_i686.manylinux2014_i686.whl", hash = "sha256:1d599671f396c4723d016dbddb72fe8e0397082b0a77a4fab8028923bec050e8"},
-    {file = "cffi-1.17.1-cp39-cp39-manylinux_2_17_aarch64.manylinux2014_aarch64.whl", hash = "sha256:ca74b8dbe6e8e8263c0ffd60277de77dcee6c837a3d0881d8c1ead7268c9e576"},
-    {file = "cffi-1.17.1-cp39-cp39-manylinux_2_17_ppc64le.manylinux2014_ppc64le.whl", hash = "sha256:f7f5baafcc48261359e14bcd6d9bff6d4b28d9103847c9e136694cb0501aef87"},
-    {file = "cffi-1.17.1-cp39-cp39-manylinux_2_17_s390x.manylinux2014_s390x.whl", hash = "sha256:98e3969bcff97cae1b2def8ba499ea3d6f31ddfdb7635374834cf89a1a08ecf0"},
-    {file = "cffi-1.17.1-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl", hash = "sha256:cdf5ce3acdfd1661132f2a9c19cac174758dc2352bfe37d98aa7512c6b7178b3"},
-    {file = "cffi-1.17.1-cp39-cp39-musllinux_1_1_aarch64.whl", hash = "sha256:9755e4345d1ec879e3849e62222a18c7174d65a6a92d5b346b1863912168b595"},
-    {file = "cffi-1.17.1-cp39-cp39-musllinux_1_1_i686.whl", hash = "sha256:f1e22e8c4419538cb197e4dd60acc919d7696e5ef98ee4da4e01d3f8cfa4cc5a"},
-    {file = "cffi-1.17.1-cp39-cp39-musllinux_1_1_x86_64.whl", hash = "sha256:c03e868a0b3bc35839ba98e74211ed2b05d2119be4e8a0f224fba9384f1fe02e"},
-    {file = "cffi-1.17.1-cp39-cp39-win32.whl", hash = "sha256:e31ae45bc2e29f6b2abd0de1cc3b9d5205aa847cafaecb8af1476a609a2f6eb7"},
-    {file = "cffi-1.17.1-cp39-cp39-win_amd64.whl", hash = "sha256:d016c76bdd850f3c626af19b0542c9677ba156e4ee4fccfdd7848803533ef662"},
-    {file = "cffi-1.17.1.tar.gz", hash = "sha256:1c39c6016c32bc48dd54561950ebd6836e1670f2ae46128f67cf49e789c52824"},
+    {file = "cffi-2.1.1-cp310-cp310-macosx_10_15_x86_64.whl", hash = "sha256:baed1e86cc735622097354b9d1281406caf42ff42a886d29faa8e8d1630333be"},
+    {file = "cffi-2.1.1-cp310-cp310-macosx_11_0_arm64.whl", hash = "sha256:ca82be1a1d406ecfe1d25dc16cb33488e5a16bf4438c9fb590484ea29d92478b"},
+    {file = "cffi-2.1.1-cp310-cp310-manylinux1_i686.manylinux2014_i686.manylinux_2_17_i686.manylinux_2_5_i686.whl", hash = "sha256:42e2f76b9455f5a9a844f770bf3e200ed3da0e15f5df3db9c31fe80b04b3d004"},
+    {file = "cffi-2.1.1-cp310-cp310-manylinux2014_aarch64.manylinux_2_17_aarch64.whl", hash = "sha256:5a59cc1c4442bc3d5c703bf720b51138d0bfc173618807c9ee2490a7541dd3d9"},
+    {file = "cffi-2.1.1-cp310-cp310-manylinux2014_ppc64le.manylinux_2_17_ppc64le.whl", hash = "sha256:9f8d177621de5cb38ee3e731eda45d421db093ec0739f46a5594babda7987a98"},
+    {file = "cffi-2.1.1-cp310-cp310-manylinux2014_s390x.manylinux_2_17_s390x.whl", hash = "sha256:75f80557d1389eddbd0de2681f6a390a0c5338c31ddaa821381c203fc3fd50d9"},
+    {file = "cffi-2.1.1-cp310-cp310-manylinux2014_x86_64.manylinux_2_17_x86_64.whl", hash = "sha256:194cffa889098ced9976c3fc6340305e43f6303657d298da55366907c05c22d6"},
+    {file = "cffi-2.1.1-cp310-cp310-musllinux_1_2_aarch64.whl", hash = "sha256:5bb4e7ea95dcd6a014a6fef62e62467d67d8e582326443f3d68e71d6320a9fcf"},
+    {file = "cffi-2.1.1-cp310-cp310-musllinux_1_2_i686.whl", hash = "sha256:3d22a20b1fb1632cc72c22f95f7b0d2961c3e1c235f245ba4c606c4771035659"},
+    {file = "cffi-2.1.1-cp310-cp310-musllinux_1_2_x86_64.whl", hash = "sha256:1dea0e4d7d4f11f619fe8c1d76caf49e24405b4b5743c0e3be16a500ecd930c9"},
+    {file = "cffi-2.1.1-cp310-cp310-win32.whl", hash = "sha256:7ce713ace7c0e4520535b42b77eaa742c16dab813978064913e5a3cf82973b41"},
+    {file = "cffi-2.1.1-cp310-cp310-win_amd64.whl", hash = "sha256:a48d62ab9d6f4f98c983223a547af44be6ca3691074c31cecced6facd3ba2dc1"},
+    {file = "cffi-2.1.1-cp311-cp311-macosx_10_15_x86_64.whl", hash = "sha256:c8d2c9fd1f2d16f780d15127abb050d13d1a76c03a4bd87d7e4980e45e511e12"},
+    {file = "cffi-2.1.1-cp311-cp311-macosx_11_0_arm64.whl", hash = "sha256:398aff33cee2767e3e781d2554c54bd0dff386bb437581e0d8011fde1a942ec1"},
+    {file = "cffi-2.1.1-cp311-cp311-manylinux1_i686.manylinux2014_i686.manylinux_2_17_i686.manylinux_2_5_i686.whl", hash = "sha256:154852545011f779917b11c78db2358d095da62a9a172b78ad0a583ee5adc0d0"},
+    {file = "cffi-2.1.1-cp311-cp311-manylinux2014_aarch64.manylinux_2_17_aarch64.whl", hash = "sha256:3311ed60d36f83378794e1009ac6258bafbf81f7888b4caa7b35a521e3f95813"},
+    {file = "cffi-2.1.1-cp311-cp311-manylinux2014_ppc64le.manylinux_2_17_ppc64le.whl", hash = "sha256:6e192623c49c94421616a5778fba35cf0d5a8d000650c1967ef4448ee5cdd990"},
+    {file = "cffi-2.1.1-cp311-cp311-manylinux2014_s390x.manylinux_2_17_s390x.whl", hash = "sha256:a6e721d4b0e45d5b65e87534470e67b18dcd092c83f68fba09f152b9cbc061af"},
+    {file = "cffi-2.1.1-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.whl", hash = "sha256:34e261f78cb6ceaaa36f42f2613f4380d94d9c759a9c73c769ee6e0247364632"},
+    {file = "cffi-2.1.1-cp311-cp311-musllinux_1_2_aarch64.whl", hash = "sha256:7225e4514edb64eb6740324353e0da0711954fd8d7da4576755b1c6e09b697cd"},
+    {file = "cffi-2.1.1-cp311-cp311-musllinux_1_2_i686.whl", hash = "sha256:df913725b79db7bcf03448f36b7bf8815363417d5b58deecf9305e3e30f0f21a"},
+    {file = "cffi-2.1.1-cp311-cp311-musllinux_1_2_x86_64.whl", hash = "sha256:f5cfbc5fe74540d335175b656c725d74d90e3730c626d92575eea35029d9afaa"},
+    {file = "cffi-2.1.1-cp311-cp311-win32.whl", hash = "sha256:f8ec5e643a9a937f64e1999eb9f75d072263751912dc5cd06d3c85f8f44be7c3"},
+    {file = "cffi-2.1.1-cp311-cp311-win_amd64.whl", hash = "sha256:42f6930c31dc7f50732c9ae793c2786c7b6b044195967bbdde40bb9be81c4cc0"},
+    {file = "cffi-2.1.1-cp311-cp311-win_arm64.whl", hash = "sha256:c7659f22557c5a0bc4855cd635f55edec690cc008a40768527762cb9fb263455"},
+    {file = "cffi-2.1.1-cp312-cp312-macosx_10_15_x86_64.whl", hash = "sha256:c8c69575568085ba0b1b10c0249d779a214aea6f6522e949a0fc9fb0fcb449d0"},
+    {file = "cffi-2.1.1-cp312-cp312-macosx_11_0_arm64.whl", hash = "sha256:f81b3b8f3d4e343550fa4baa0e479bba9f2d29ce9c2e9b51d1ce1718d7442fcf"},
+    {file = "cffi-2.1.1-cp312-cp312-manylinux1_i686.manylinux2014_i686.manylinux_2_17_i686.manylinux_2_5_i686.whl", hash = "sha256:811bd1e21d32de12efca32393a0ab3f5133b54fce9bd44b8bd77ab07da14bf6a"},
+    {file = "cffi-2.1.1-cp312-cp312-manylinux2014_aarch64.manylinux_2_17_aarch64.whl", hash = "sha256:68e62fe11f30d5ca8289242866f0a5291402d8529ca2178ab8afc5c9694ae890"},
+    {file = "cffi-2.1.1-cp312-cp312-manylinux2014_ppc64le.manylinux_2_17_ppc64le.whl", hash = "sha256:4a7c934f7360e8cd64fe9efadcbd10c7c6364f531e432b9a4bf5ccbc9e0e8b50"},
+    {file = "cffi-2.1.1-cp312-cp312-manylinux2014_s390x.manylinux_2_17_s390x.whl", hash = "sha256:3143d81e29e1e20a9ce10901ec369012947876596f75a222235965f2b7ae832e"},
+    {file = "cffi-2.1.1-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.whl", hash = "sha256:c1453022f490d2459a11819d83ad1d586e9ff65a12ac3e705ffebd46d3685dcf"},
+    {file = "cffi-2.1.1-cp312-cp312-musllinux_1_2_aarch64.whl", hash = "sha256:208f941bb9d18e768138677f0a6d2ce01f590df56043dda1df1535ac57c88517"},
+    {file = "cffi-2.1.1-cp312-cp312-musllinux_1_2_x86_64.whl", hash = "sha256:210019b6c7cf07f081b4c54635c8cf744377001350e29cc0f81c4377b4797735"},
+    {file = "cffi-2.1.1-cp312-cp312-win32.whl", hash = "sha256:046bfc24911b37851ee1b51aab8bffe713d89c68c6a057b09484ce9fd5f69b4e"},
+    {file = "cffi-2.1.1-cp312-cp312-win_amd64.whl", hash = "sha256:f53e442b08449d42821fa4a4fba000095af9f62742a500f978a9f557ec44339a"},
+    {file = "cffi-2.1.1-cp312-cp312-win_arm64.whl", hash = "sha256:7bde5e4cc5c10140859842b9d383af292b22639a4dffb725314baf45968cef80"},
+    {file = "cffi-2.1.1-cp313-cp313-ios_13_0_arm64_iphoneos.whl", hash = "sha256:b5bdfd1c873d4e093aabc0ca84c4ca6dbc4f752afb5c86f146d9742580c9da2e"},
+    {file = "cffi-2.1.1-cp313-cp313-ios_13_0_arm64_iphonesimulator.whl", hash = "sha256:31348097ff5bbe827ccc41795d4dd099d9f0625e7def00ee653c137a490c2a6c"},
+    {file = "cffi-2.1.1-cp313-cp313-macosx_10_15_x86_64.whl", hash = "sha256:9d2055050ea716bd38b7f7f1579c275386646b4894c155a3e2f3cd62ed41b7c6"},
+    {file = "cffi-2.1.1-cp313-cp313-macosx_11_0_arm64.whl", hash = "sha256:19ee6127ee34de7d83ce3d371ebc5ed91addbdcc39f9ab15ce4eb35a4e534971"},
+    {file = "cffi-2.1.1-cp313-cp313-manylinux1_i686.manylinux2014_i686.manylinux_2_17_i686.manylinux_2_5_i686.whl", hash = "sha256:6a8dddef476fab96d066d578fc88526767b836ab5ab21754e1d5bf3879c31c7c"},
+    {file = "cffi-2.1.1-cp313-cp313-manylinux2014_aarch64.manylinux_2_17_aarch64.whl", hash = "sha256:f16c709686a78c727bbbf059f92b0bf41c6fc60deec706d2dc19f529175a6125"},
+    {file = "cffi-2.1.1-cp313-cp313-manylinux2014_ppc64le.manylinux_2_17_ppc64le.whl", hash = "sha256:fcd22650c908d7b7da162bbfaab594a1227a15d1643a98c68b122ac642fa2264"},
+    {file = "cffi-2.1.1-cp313-cp313-manylinux2014_s390x.manylinux_2_17_s390x.whl", hash = "sha256:aa9511c62d14da7aacc9b4bf51f3f697a621e83b2d6919008243c3aad168eea3"},
+    {file = "cffi-2.1.1-cp313-cp313-manylinux2014_x86_64.manylinux_2_17_x86_64.whl", hash = "sha256:a931079504ecc49efed7744c476a5c343a92fabf66dec2db95edb1b2fdc770e2"},
+    {file = "cffi-2.1.1-cp313-cp313-musllinux_1_2_aarch64.whl", hash = "sha256:a2d7755bef5a12ed488f4ef1f1b69ee9191d7396083b755a5d2295f6edb4768b"},
+    {file = "cffi-2.1.1-cp313-cp313-musllinux_1_2_x86_64.whl", hash = "sha256:e0bcb7e0f677f543555d2adff3bf19c05f66cdb4796e5ff602442ab2fe3c4ef7"},
+    {file = "cffi-2.1.1-cp313-cp313-win32.whl", hash = "sha256:334644fbac4eff73d985a17a91226df55d0f394160c4cfb880e084c8f7161cac"},
+    {file = "cffi-2.1.1-cp313-cp313-win_amd64.whl", hash = "sha256:1aa5645c30469b09530c4ebca77ebf8f17618293c58f8549cb1a543a50236e7d"},
+    {file = "cffi-2.1.1-cp313-cp313-win_arm64.whl", hash = "sha256:63bbfd5ded17c4840ac07cd8f1c21ba9d9708141f840b324f422f41b207e3973"},
+    {file = "cffi-2.1.1-cp314-cp314-ios_13_0_arm64_iphoneos.whl", hash = "sha256:7dbb61fe3a7699468030f71bbe5f8a0e326a151daa91beb11a6fc1f980c55e1c"},
+    {file = "cffi-2.1.1-cp314-cp314-ios_13_0_arm64_iphonesimulator.whl", hash = "sha256:f24fb43132a4c6b4cb4eb029492919b2db645be6808d738f244fd146c03c32cb"},
+    {file = "cffi-2.1.1-cp314-cp314-macosx_10_15_x86_64.whl", hash = "sha256:d28630f5854ab07ab1fd4aba756de52326c82e6be15d414b12793f1975048b54"},
+    {file = "cffi-2.1.1-cp314-cp314-macosx_11_0_arm64.whl", hash = "sha256:661c298b4821edebead0c91edd2b00374d67ad7c5a1f7a91d4442633b79d6a72"},
+    {file = "cffi-2.1.1-cp314-cp314-manylinux2014_aarch64.manylinux_2_17_aarch64.whl", hash = "sha256:58acb8ab8e295e6c5ea12f888cbb13cf21511ef2a3303a23f4325c29d17fe5c1"},
+    {file = "cffi-2.1.1-cp314-cp314-manylinux2014_ppc64le.manylinux_2_17_ppc64le.whl", hash = "sha256:456a61fa52d579ebf9df2e9552ead5129855dbaff6c1e5a9b1bc408809bdc062"},
+    {file = "cffi-2.1.1-cp314-cp314-manylinux2014_s390x.manylinux_2_17_s390x.whl", hash = "sha256:a4f00aa42f75d6e4595e8866e748cc1705adc0cddfeb2ca86d0d03993d63ba03"},
+    {file = "cffi-2.1.1-cp314-cp314-manylinux2014_x86_64.manylinux_2_17_x86_64.whl", hash = "sha256:b0431303acaea1089ad4b3e9ce4e6518193def1118d4073ca848635ee4ea2e96"},
+    {file = "cffi-2.1.1-cp314-cp314-musllinux_1_2_aarch64.whl", hash = "sha256:64faea20f4e2613363a1a9b9c7dd73058f3ecd00133a511e72ad7c511658f527"},
+    {file = "cffi-2.1.1-cp314-cp314-musllinux_1_2_x86_64.whl", hash = "sha256:5c58fe613dc5e5336357eff555824a314d8e43282600435c8d1cb6a7a2fedd13"},
+    {file = "cffi-2.1.1-cp314-cp314-win32.whl", hash = "sha256:1a18a57b58cfb21fc28d72e876acf10eaed67a1ed96226f92af4df681d571c4c"},
+    {file = "cffi-2.1.1-cp314-cp314-win_amd64.whl", hash = "sha256:3222ba5d678f80a030e6afbcc33dc1ae5cb45facabb61cee2c7016b8432fde48"},
+    {file = "cffi-2.1.1-cp314-cp314-win_arm64.whl", hash = "sha256:ab36d55f9ed2d067327667c2fea18dda018eb628dd6347aa01dda6cf1f5d3836"},
+    {file = "cffi-2.1.1-cp314-cp314t-macosx_10_15_x86_64.whl", hash = "sha256:7750c6449dff7864bb9bb27ddfb0267756189201a3afc911d82b3caacd70dfc3"},
+    {file = "cffi-2.1.1-cp314-cp314t-macosx_11_0_arm64.whl", hash = "sha256:0beceaabe56af686895136a2de78db54ecd8e4046b236b8fd6d6cb61389e9bf2"},
+    {file = "cffi-2.1.1-cp314-cp314t-manylinux2014_aarch64.manylinux_2_17_aarch64.whl", hash = "sha256:49cbc70e6542d4ccccb936558d1064a8012541e78f821f955cff24e357776c94"},
+    {file = "cffi-2.1.1-cp314-cp314t-manylinux2014_ppc64le.manylinux_2_17_ppc64le.whl", hash = "sha256:e2d65b31f36619cda3999b78b2aa9632e76b78448e7a56fc4240824200e7c4fc"},
+    {file = "cffi-2.1.1-cp314-cp314t-manylinux2014_s390x.manylinux_2_17_s390x.whl", hash = "sha256:28907ab9bfb6aa13184cfc17c6b8e1023c5ab6fd7076d8c20a35e59fe04f8f29"},
+    {file = "cffi-2.1.1-cp314-cp314t-manylinux2014_x86_64.manylinux_2_17_x86_64.whl", hash = "sha256:51b31d1c98274844cfd7838ce00bfc27c7423a4dc00fc0772fc3331c2cc90676"},
+    {file = "cffi-2.1.1-cp314-cp314t-musllinux_1_2_aarch64.whl", hash = "sha256:5e7cecbaadb83884793e05828cee59b210b24583b9c7425d0ba6a754fe22eb4e"},
+    {file = "cffi-2.1.1-cp314-cp314t-musllinux_1_2_x86_64.whl", hash = "sha256:25792eac27877609e7bb06d42ff88278a6624fff2ba9bbb523c09616b117e80f"},
+    {file = "cffi-2.1.1-cp314-cp314t-win32.whl", hash = "sha256:8ef53b2de9bcb9197d31854256575d59dbac0cba72ac627bb291ef5eceb74be4"},
+    {file = "cffi-2.1.1-cp314-cp314t-win_amd64.whl", hash = "sha256:616f097f2fe415bc92a247f02e11f634e1f9e9a83d327e3c915c15089c87869e"},
+    {file = "cffi-2.1.1-cp314-cp314t-win_arm64.whl", hash = "sha256:ad2c86c495b899d862ea0f4b42891b8713a3bd45dd4105c7fd51c2a72f39f3a5"},
+    {file = "cffi-2.1.1-cp315-cp315-ios_13_0_arm64_iphoneos.whl", hash = "sha256:dddad92b554513a31f272570678ba307fb9f618f05e3d4a5eacafff9eae03e1d"},
+    {file = "cffi-2.1.1-cp315-cp315-ios_13_0_arm64_iphonesimulator.whl", hash = "sha256:da0e573f9f97159390c89d9f1a9e41908b66d408cc5b58d08cf3847d844c531b"},
+    {file = "cffi-2.1.1-cp315-cp315-macosx_10_15_x86_64.whl", hash = "sha256:fb92203a88b3d3053034db775110081c49d28be6551923805e039924093761e4"},
+    {file = "cffi-2.1.1-cp315-cp315-macosx_11_0_arm64.whl", hash = "sha256:2ae64be792b8966f2c69538199728b290e34726562896df1e5dc8ffd8d8188e8"},
+    {file = "cffi-2.1.1-cp315-cp315-manylinux2014_aarch64.manylinux_2_17_aarch64.whl", hash = "sha256:507a24c282e0f42f8ed737cf048572cbf580468da5555764a8331735e9c736b6"},
+    {file = "cffi-2.1.1-cp315-cp315-manylinux2014_ppc64le.manylinux_2_17_ppc64le.whl", hash = "sha256:246fa40ce8645a614ff682e0b70f37134e460eaf93a775e0cbe3cca585a67a80"},
+    {file = "cffi-2.1.1-cp315-cp315-manylinux2014_s390x.manylinux_2_17_s390x.whl", hash = "sha256:471cee653ae88de62096552e6d24ccb4a5adb8c8c9f10b5054d0122c15bf2779"},
+    {file = "cffi-2.1.1-cp315-cp315-manylinux2014_x86_64.manylinux_2_17_x86_64.whl", hash = "sha256:aeae0e330c9f6acd681f647d46cefd30c29f93e3392882e792e82080c9691399"},
+    {file = "cffi-2.1.1-cp315-cp315-musllinux_1_2_aarch64.whl", hash = "sha256:42a494cee34437f05546455144f2b5d9ac09b1face62bcfce597d2e521066688"},
+    {file = "cffi-2.1.1-cp315-cp315-musllinux_1_2_x86_64.whl", hash = "sha256:cc572dace3f60ef98d7b12ff411d20f5362feb31a0439eab0085bbfd349982d7"},
+    {file = "cffi-2.1.1-cp315-cp315-win32.whl", hash = "sha256:4f42141fc14250de6dde5ee7ea4432be017252d91f19c5ad043c084cea629cac"},
+    {file = "cffi-2.1.1-cp315-cp315-win_amd64.whl", hash = "sha256:e6e8cff14d6fb0be70a09c0bdc58096f501952d04624ebf867e0e56da2df8960"},
+    {file = "cffi-2.1.1-cp315-cp315-win_arm64.whl", hash = "sha256:27350daa11d4f10c540e6e89dada4c54feb7256ad03e9a4dc075ebad7ba360d1"},
+    {file = "cffi-2.1.1-cp315-cp315t-macosx_10_15_x86_64.whl", hash = "sha256:c26608d2222fb1e94487e4a387d85f13eb55d5ed725cb25a0c589ac4ee60e7bc"},
+    {file = "cffi-2.1.1-cp315-cp315t-macosx_11_0_arm64.whl", hash = "sha256:4be96343e422f2dfcd12ab5c9f5aebe03f82f737c6bffeca6830b3875cb44aab"},
+    {file = "cffi-2.1.1-cp315-cp315t-manylinux2014_aarch64.manylinux_2_17_aarch64.whl", hash = "sha256:937c0052c05a31ca1daf18de3158eed4dbfcb9cc107adbea227728d647be701e"},
+    {file = "cffi-2.1.1-cp315-cp315t-manylinux2014_ppc64le.manylinux_2_17_ppc64le.whl", hash = "sha256:df423d40ee8654634421812bc3b196da3f9bd7d32929da813f8394c4348a5358"},
+    {file = "cffi-2.1.1-cp315-cp315t-manylinux2014_s390x.manylinux_2_17_s390x.whl", hash = "sha256:a730a083190634c65cca36ba5f489531576ebd79bcd5c8e172130f6453127231"},
+    {file = "cffi-2.1.1-cp315-cp315t-manylinux2014_x86_64.manylinux_2_17_x86_64.whl", hash = "sha256:363e05fa78e15116c3c32c210ee36884fd6b9afa6d440e47112c3bd511d64cb6"},
+    {file = "cffi-2.1.1-cp315-cp315t-musllinux_1_2_aarch64.whl", hash = "sha256:770de9db11e84213beec501cfcaa013b019820ca881e03344dea5844f7876d94"},
+    {file = "cffi-2.1.1-cp315-cp315t-musllinux_1_2_x86_64.whl", hash = "sha256:7da0c5eff80f0197f3b3d1232ec5a682a9325f4ae9016a78f5f5ca35f9ced1f5"},
+    {file = "cffi-2.1.1-cp315-cp315t-win32.whl", hash = "sha256:06c72bb76605a4b0cd0aad6930b69d4baf7dd5d806cfc409b824191099700e66"},
+    {file = "cffi-2.1.1-cp315-cp315t-win_amd64.whl", hash = "sha256:d9c275eaacd24aa73f94ffd6de08fc3f932424d8b6c376f4bed7cde376fe7bc3"},
+    {file = "cffi-2.1.1-cp315-cp315t-win_arm64.whl", hash = "sha256:d18e5ac0f2f03f4f518d3e23db0f0cad7faa1da8620e9c09461d443bbf6e6692"},
+    {file = "cffi-2.1.1.tar.gz", hash = "sha256:dd31f52ea1086513bb9df30f8fcee9b8918323ae067a3d5b78bc826a000712be"},
 ]
 markers = {dev = "platform_python_implementation != \"PyPy\""}
 
 [package.dependencies]
-pycparser = "*"
+pycparser = {version = "*", markers = "implementation_name != \"PyPy\""}
 
 [[package]]
 name = "cryptography"
-version = "44.0.0"
+version = "50.0.2"
 description = "cryptography is a package which provides cryptographic recipes and primitives to Python developers."
 optional = false
-python-versions = "!=3.9.0,!=3.9.1,>=3.7"
+python-versions = "!=3.9.0,!=3.9.1,>=3.9"
 groups = ["main", "dev"]
 files = [
-    {file = "cryptography-44.0.0-cp37-abi3-macosx_10_9_universal2.whl", hash = "sha256:84111ad4ff3f6253820e6d3e58be2cc2a00adb29335d4cacb5ab4d4d34f2a123"},
-    {file = "cryptography-44.0.0-cp37-abi3-manylinux_2_17_aarch64.manylinux2014_aarch64.whl", hash = "sha256:b15492a11f9e1b62ba9d73c210e2416724633167de94607ec6069ef724fad092"},
-    {file = "cryptography-44.0.0-cp37-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl", hash = "sha256:831c3c4d0774e488fdc83a1923b49b9957d33287de923d58ebd3cec47a0ae43f"},
-    {file = "cryptography-44.0.0-cp37-abi3-manylinux_2_28_aarch64.whl", hash = "sha256:761817a3377ef15ac23cd7834715081791d4ec77f9297ee694ca1ee9c2c7e5eb"},
-    {file = "cryptography-44.0.0-cp37-abi3-manylinux_2_28_x86_64.whl", hash = "sha256:3c672a53c0fb4725a29c303be906d3c1fa99c32f58abe008a82705f9ee96f40b"},
-    {file = "cryptography-44.0.0-cp37-abi3-manylinux_2_34_aarch64.whl", hash = "sha256:4ac4c9f37eba52cb6fbeaf5b59c152ea976726b865bd4cf87883a7e7006cc543"},
-    {file = "cryptography-44.0.0-cp37-abi3-musllinux_1_2_aarch64.whl", hash = "sha256:ed3534eb1090483c96178fcb0f8893719d96d5274dfde98aa6add34614e97c8e"},
-    {file = "cryptography-44.0.0-cp37-abi3-musllinux_1_2_x86_64.whl", hash = "sha256:f3f6fdfa89ee2d9d496e2c087cebef9d4fcbb0ad63c40e821b39f74bf48d9c5e"},
-    {file = "cryptography-44.0.0-cp37-abi3-win32.whl", hash = "sha256:eb33480f1bad5b78233b0ad3e1b0be21e8ef1da745d8d2aecbb20671658b9053"},
-    {file = "cryptography-44.0.0-cp37-abi3-win_amd64.whl", hash = "sha256:abc998e0c0eee3c8a1904221d3f67dcfa76422b23620173e28c11d3e626c21bd"},
-    {file = "cryptography-44.0.0-cp39-abi3-macosx_10_9_universal2.whl", hash = "sha256:660cb7312a08bc38be15b696462fa7cc7cd85c3ed9c576e81f4dc4d8b2b31591"},
-    {file = "cryptography-44.0.0-cp39-abi3-manylinux_2_17_aarch64.manylinux2014_aarch64.whl", hash = "sha256:1923cb251c04be85eec9fda837661c67c1049063305d6be5721643c22dd4e2b7"},
-    {file = "cryptography-44.0.0-cp39-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl", hash = "sha256:404fdc66ee5f83a1388be54300ae978b2efd538018de18556dde92575e05defc"},
-    {file = "cryptography-44.0.0-cp39-abi3-manylinux_2_28_aarch64.whl", hash = "sha256:c5eb858beed7835e5ad1faba59e865109f3e52b3783b9ac21e7e47dc5554e289"},
-    {file = "cryptography-44.0.0-cp39-abi3-manylinux_2_28_x86_64.whl", hash = "sha256:f53c2c87e0fb4b0c00fa9571082a057e37690a8f12233306161c8f4b819960b7"},
-    {file = "cryptography-44.0.0-cp39-abi3-manylinux_2_34_aarch64.whl", hash = "sha256:9e6fc8a08e116fb7c7dd1f040074c9d7b51d74a8ea40d4df2fc7aa08b76b9e6c"},
-    {file = "cryptography-44.0.0-cp39-abi3-musllinux_1_2_aarch64.whl", hash = "sha256:d2436114e46b36d00f8b72ff57e598978b37399d2786fd39793c36c6d5cb1c64"},
-    {file = "cryptography-44.0.0-cp39-abi3-musllinux_1_2_x86_64.whl", hash = "sha256:a01956ddfa0a6790d594f5b34fc1bfa6098aca434696a03cfdbe469b8ed79285"},
-    {file = "cryptography-44.0.0-cp39-abi3-win32.whl", hash = "sha256:eca27345e1214d1b9f9490d200f9db5a874479be914199194e746c893788d417"},
-    {file = "cryptography-44.0.0-cp39-abi3-win_amd64.whl", hash = "sha256:708ee5f1bafe76d041b53a4f95eb28cdeb8d18da17e597d46d7833ee59b97ede"},
-    {file = "cryptography-44.0.0-pp310-pypy310_pp73-macosx_10_9_x86_64.whl", hash = "sha256:37d76e6863da3774cd9db5b409a9ecfd2c71c981c38788d3fcfaf177f447b731"},
-    {file = "cryptography-44.0.0-pp310-pypy310_pp73-manylinux_2_28_aarch64.whl", hash = "sha256:f677e1268c4e23420c3acade68fac427fffcb8d19d7df95ed7ad17cdef8404f4"},
-    {file = "cryptography-44.0.0-pp310-pypy310_pp73-manylinux_2_28_x86_64.whl", hash = "sha256:f5e7cb1e5e56ca0933b4873c0220a78b773b24d40d186b6738080b73d3d0a756"},
-    {file = "cryptography-44.0.0-pp310-pypy310_pp73-manylinux_2_34_aarch64.whl", hash = "sha256:8b3e6eae66cf54701ee7d9c83c30ac0a1e3fa17be486033000f2a73a12ab507c"},
-    {file = "cryptography-44.0.0-pp310-pypy310_pp73-manylinux_2_34_x86_64.whl", hash = "sha256:be4ce505894d15d5c5037167ffb7f0ae90b7be6f2a98f9a5c3442395501c32fa"},
-    {file = "cryptography-44.0.0-pp310-pypy310_pp73-win_amd64.whl", hash = "sha256:62901fb618f74d7d81bf408c8719e9ec14d863086efe4185afd07c352aee1d2c"},
-    {file = "cryptography-44.0.0.tar.gz", hash = "sha256:cd4e834f340b4293430701e772ec543b0fbe6c2dea510a5286fe0acabe153a02"},
+    {file = "cryptography-50.0.2-cp311-abi3-macosx_11_0_arm64.whl", hash = "sha256:fa8f5efb344d6908a1ce62f4a24e2e5780f825d6f53f5f50ec5ffacac72936cb"},
+    {file = "cryptography-50.0.2-cp311-abi3-manylinux2014_aarch64.manylinux_2_17_aarch64.whl", hash = "sha256:79def8d059362e7831389ed3be0ecdf58a89386e1271e35dd9f5af84e81bffd0"},
+    {file = "cryptography-50.0.2-cp311-abi3-manylinux2014_x86_64.manylinux_2_17_x86_64.whl", hash = "sha256:630ebfea3bf689d075f82316324ff7433dc447fe6bc1bfc76524b74b4a9567d2"},
+    {file = "cryptography-50.0.2-cp311-abi3-manylinux_2_28_aarch64.whl", hash = "sha256:f9f6143a8c75945eb960d9eb98905a441394abfa24afaae239d514ffb2586480"},
+    {file = "cryptography-50.0.2-cp311-abi3-manylinux_2_28_ppc64le.whl", hash = "sha256:a582ab2ae1d34f67112cadc86702774c9ea4374df6bca6afe672817203c99134"},
+    {file = "cryptography-50.0.2-cp311-abi3-manylinux_2_28_x86_64.whl", hash = "sha256:4061c0079120205fb760c58acab6443e217307dcf05e3702cf970e0689972856"},
+    {file = "cryptography-50.0.2-cp311-abi3-manylinux_2_31_armv7l.whl", hash = "sha256:ac9ed99d81760c62fe89d5f0815cdfa1ba9a35141cf30f1c2d044f04b4803d2e"},
+    {file = "cryptography-50.0.2-cp311-abi3-manylinux_2_34_aarch64.whl", hash = "sha256:87e9ce85beb6b328ba370cc6e6aea483c92617b4c95b1d33a49297eb662bfb04"},
+    {file = "cryptography-50.0.2-cp311-abi3-manylinux_2_34_ppc64le.whl", hash = "sha256:f265528741e048bce55c3463ed721fb0aa45a5888d8add8cfeccb3035451bbdc"},
+    {file = "cryptography-50.0.2-cp311-abi3-manylinux_2_34_x86_64.whl", hash = "sha256:9dab55f57c74c3cad24c323bacbbd04be4705ba6eb0d92e920b1fc4837ed5079"},
+    {file = "cryptography-50.0.2-cp311-abi3-musllinux_1_2_aarch64.whl", hash = "sha256:25784ce8b9621c90c643efb9e1e2162ab3b0224cae446ad5e70e7fcb1ce18b51"},
+    {file = "cryptography-50.0.2-cp311-abi3-musllinux_1_2_x86_64.whl", hash = "sha256:85d0d9a31b9098e98534226d5686b47264b95e62ce459dc2e62fdfc809f9fe93"},
+    {file = "cryptography-50.0.2-cp311-abi3-win_amd64.whl", hash = "sha256:7afa5a6602a9f29af1f3a2965f831bae7c9d5d597b7cbb716d41ab3b7d89879c"},
+    {file = "cryptography-50.0.2-cp314-cp314t-macosx_11_0_arm64.whl", hash = "sha256:f785f6161f202ab04d8ca194158968798e480ca058943907972da5f12e2881e8"},
+    {file = "cryptography-50.0.2-cp314-cp314t-manylinux2014_aarch64.manylinux_2_17_aarch64.whl", hash = "sha256:0ecbc5652bdb6fc9eaf89a7d196e20941adfe812f43bc4ca05d9150496821047"},
+    {file = "cryptography-50.0.2-cp314-cp314t-manylinux2014_x86_64.manylinux_2_17_x86_64.whl", hash = "sha256:ab50ee449bf968271e820086f10a33d101dd060370abc10bcd22279be2656539"},
+    {file = "cryptography-50.0.2-cp314-cp314t-manylinux_2_28_aarch64.whl", hash = "sha256:a9f7355e6fab51f6c369b86fb7571cffa05edee2c2121e0380a37fb9ac1cd5c1"},
+    {file = "cryptography-50.0.2-cp314-cp314t-manylinux_2_28_ppc64le.whl", hash = "sha256:94e5e9f108ee10471288214d3d233fbfbb492840a8457eb85178d643ddeb32c7"},
+    {file = "cryptography-50.0.2-cp314-cp314t-manylinux_2_28_x86_64.whl", hash = "sha256:241449bf940a5d27309bd317e6f9a2af6932113818bb2b8f5c59ddc7ef16da18"},
+    {file = "cryptography-50.0.2-cp314-cp314t-manylinux_2_31_armv7l.whl", hash = "sha256:d8947001be83df1394050758ce0e745dd74fb134eef0a4b5124208dfc3a68c37"},
+    {file = "cryptography-50.0.2-cp314-cp314t-manylinux_2_34_aarch64.whl", hash = "sha256:4a20ce1e5cb4284a86692fdcba7cb8754185c6b2e5c56fcef3751cf451d3cdc2"},
+    {file = "cryptography-50.0.2-cp314-cp314t-manylinux_2_34_ppc64le.whl", hash = "sha256:84f964e537f916e2cc85199e5a88742e964939b575ac8598b3f9d6cc416cdaf1"},
+    {file = "cryptography-50.0.2-cp314-cp314t-manylinux_2_34_x86_64.whl", hash = "sha256:828d49b0ff5a0e3975865571c5d91dbbdd0d38d8289b249a163e9425413a5e05"},
+    {file = "cryptography-50.0.2-cp314-cp314t-musllinux_1_2_aarch64.whl", hash = "sha256:deb9fde5c60e437ee4821bc9bc39ff31b42135c27e1dc61ef0a629389c1de62e"},
+    {file = "cryptography-50.0.2-cp314-cp314t-musllinux_1_2_x86_64.whl", hash = "sha256:8c71ba2cd31fc93748c38e1b613200ff1c2665cbfd5341fe3a61cfde35a1430e"},
+    {file = "cryptography-50.0.2-cp314-cp314t-win_amd64.whl", hash = "sha256:78198641e5be9521beea5aa782bb551a58068d10e6eb04c9c680c1b69f2e7d45"},
+    {file = "cryptography-50.0.2-cp315-abi3.abi3t-macosx_11_0_arm64.whl", hash = "sha256:edc3342adf8f697fc5f59c887a304356f147b397809440ed64e2fa6af2f50f37"},
+    {file = "cryptography-50.0.2-cp315-abi3.abi3t-manylinux2014_aarch64.manylinux_2_17_aarch64.whl", hash = "sha256:d370b8d1dfcdf7130178137f6fbee6140774a1acc6cacefc4b42643ec11d0a3a"},
+    {file = "cryptography-50.0.2-cp315-abi3.abi3t-manylinux2014_x86_64.manylinux_2_17_x86_64.whl", hash = "sha256:f2f9bd7f90c64fe89253f0a2c05e3c4856072660429ce8831b4235bf29403a67"},
+    {file = "cryptography-50.0.2-cp315-abi3.abi3t-manylinux_2_28_aarch64.whl", hash = "sha256:e275096ea1e60cc595cda2836fd4a6c725d1125108b868be17f53684d164e2cc"},
+    {file = "cryptography-50.0.2-cp315-abi3.abi3t-manylinux_2_28_ppc64le.whl", hash = "sha256:b13478603dcd0a2479ff8e87e2c19a7d525734686fe3c49542472293a204212d"},
+    {file = "cryptography-50.0.2-cp315-abi3.abi3t-manylinux_2_28_x86_64.whl", hash = "sha256:58a0c478eeca76fe5e07993c5a0703def34a6dc6a0cda4f5564639b33112ffe7"},
+    {file = "cryptography-50.0.2-cp315-abi3.abi3t-manylinux_2_31_armv7l.whl", hash = "sha256:d38cdff612d06fa6a32840d5e1b1f7a27cee4a349aa9085d94a67789d6bfd408"},
+    {file = "cryptography-50.0.2-cp315-abi3.abi3t-manylinux_2_34_aarch64.whl", hash = "sha256:fdd28f912fccfec1846a94e2e1e8f9b0012f557f0c46fe4f3eb0d7a87afcf90b"},
+    {file = "cryptography-50.0.2-cp315-abi3.abi3t-manylinux_2_34_ppc64le.whl", hash = "sha256:cbc8738fd8526d80f35cb3a40d41f41a2e7030bb3b18b09a6778ef63d291c2fd"},
+    {file = "cryptography-50.0.2-cp315-abi3.abi3t-manylinux_2_34_x86_64.whl", hash = "sha256:e105ab60406787da31fccc883fc0f733af1efd78f0136a4599692c4083a73d0c"},
+    {file = "cryptography-50.0.2-cp315-abi3.abi3t-musllinux_1_2_aarch64.whl", hash = "sha256:6f8700550aa1474a91e5dc07049c46f98b423b5b1ddd0483e0b51362eeeaf5be"},
+    {file = "cryptography-50.0.2-cp315-abi3.abi3t-musllinux_1_2_x86_64.whl", hash = "sha256:c71be1cbfa5cd9a41ee452acf1eccd82b2c05950358b106ec8ceb83411d1a020"},
+    {file = "cryptography-50.0.2-cp315-abi3.abi3t-win_amd64.whl", hash = "sha256:c423ab384a46c4dff7217b2ea5ba2e11cffdeab6441acd04cf65a369caf0366c"},
+    {file = "cryptography-50.0.2-cp39-abi3-macosx_11_0_arm64.whl", hash = "sha256:0ec5f09541743261e66e291b4a0cbf0fb2997aeaab6d9e9c740b9dba1b58d1c2"},
+    {file = "cryptography-50.0.2-cp39-abi3-manylinux2014_aarch64.manylinux_2_17_aarch64.whl", hash = "sha256:c5e67125c7dca78d199ec4e116aa93dbb83494808ecbb8211a2cb09b1bf41dbd"},
+    {file = "cryptography-50.0.2-cp39-abi3-manylinux2014_x86_64.manylinux_2_17_x86_64.whl", hash = "sha256:ee247f5c245c9a2fe7c8e2214e295918838e44e00a45a6718451e4004219e767"},
+    {file = "cryptography-50.0.2-cp39-abi3-manylinux_2_28_aarch64.whl", hash = "sha256:dfe9763530994147d9af1def057a5b9658b00e8f8fe8743d144d1e0911c2e454"},
+    {file = "cryptography-50.0.2-cp39-abi3-manylinux_2_28_ppc64le.whl", hash = "sha256:58ddb5a8e3179d12f19e4ea34d2d32e9d63a4baa142c875c1eb59f41b7243acd"},
+    {file = "cryptography-50.0.2-cp39-abi3-manylinux_2_28_x86_64.whl", hash = "sha256:f21e8a22c8605750c7af886bab299a363721264061b4ac0a30efb73cfd58efc5"},
+    {file = "cryptography-50.0.2-cp39-abi3-manylinux_2_31_armv7l.whl", hash = "sha256:9c8402a82ea0dc4ceeab793db05f0fafa8ca139ca34fcde5df0f596103c74107"},
+    {file = "cryptography-50.0.2-cp39-abi3-manylinux_2_34_aarch64.whl", hash = "sha256:0ddc924c04591c2811ca024d62ecad4f7f6f08af8939c211438f48a16bd23602"},
+    {file = "cryptography-50.0.2-cp39-abi3-manylinux_2_34_ppc64le.whl", hash = "sha256:a6557e5f38e065ca9fbdaf7cfc7435ecb1d113aa81a022d1b51921ee7432e227"},
+    {file = "cryptography-50.0.2-cp39-abi3-manylinux_2_34_x86_64.whl", hash = "sha256:1981f1db4630889b9ef7803fadef12b056f428cb6b85c27ba57b774793b6093c"},
+    {file = "cryptography-50.0.2-cp39-abi3-musllinux_1_2_aarch64.whl", hash = "sha256:7a8701d6b584d76e909e3d305b7d126b41439876a5aaf76cddc67fc230eafa2e"},
+    {file = "cryptography-50.0.2-cp39-abi3-musllinux_1_2_x86_64.whl", hash = "sha256:ce47f66801c20ec6c6632453bb5960fe38939e9306970b48b3a5a26de7745d94"},
+    {file = "cryptography-50.0.2-cp39-abi3-win_amd64.whl", hash = "sha256:4e81d95e5bafc2d6e34e4bed780e53e4d5b9a2f928573428aa4d35fbec1eb0de"},
+    {file = "cryptography-50.0.2-pp311-pypy311_pp73-manylinux_2_28_aarch64.whl", hash = "sha256:92e665960f25fcdc73725b9cec7a3824f279ba97a98653afe9ffac2e43668f67"},
+    {file = "cryptography-50.0.2-pp311-pypy311_pp73-manylinux_2_28_x86_64.whl", hash = "sha256:eef4c2f3423810b3070ab391f85436d2f8bbfcb286ac15cbc73190b3563b1f1a"},
+    {file = "cryptography-50.0.2-pp311-pypy311_pp73-manylinux_2_34_aarch64.whl", hash = "sha256:7c6d0330c472d96f6a6afe24d80dfdf15176c33096f0a4397ae4c60f3dd3be48"},
+    {file = "cryptography-50.0.2-pp311-pypy311_pp73-manylinux_2_34_x86_64.whl", hash = "sha256:1ba34f04897fcdaa73f74145c25f3ec146fbd56593853e88adc2e811303c5f42"},
+    {file = "cryptography-50.0.2-pp311-pypy311_pp80-macosx_11_0_arm64.whl", hash = "sha256:3dc4fd8058cea1644971207d530e1a03a184a805ffc8ebdddf0599d78a331b81"},
+    {file = "cryptography-50.0.2-pp311-pypy311_pp80-win_amd64.whl", hash = "sha256:7b75de3c8b3be1cdb1052747c929440c3eea46c1bc2cb8a6e3a48388e9b7b452"},
+    {file = "cryptography-50.0.2.tar.gz", hash = "sha256:7b46165bb56eb4704e2eaaf86f3c940d19154535d9b0ca7d6d590b04060e00d5"},
 ]
 
 [package.dependencies]
-cffi = {version = ">=1.12", markers = "platform_python_implementation != \"PyPy\""}
+cffi = {version = ">=2.0.0", markers = "platform_python_implementation != \"PyPy\""}
+typing-extensions = {version = ">=4.13.2", markers = "python_full_version < \"3.11.0\""}
 
 [package.extras]
-docs = ["sphinx (>=5.3.0)", "sphinx-rtd-theme (>=3.0.0) ; python_version >= \"3.8\""]
-docstest = ["pyenchant (>=3)", "readme-renderer (>=30.0)", "sphinxcontrib-spelling (>=7.3.1)"]
-nox = ["nox (>=2024.4.15)", "nox[uv] (>=2024.3.2) ; python_version >= \"3.8\""]
-pep8test = ["check-sdist ; python_version >= \"3.8\"", "click (>=8.0.1)", "mypy (>=1.4)", "ruff (>=0.3.6)"]
-sdist = ["build (>=1.0.0)"]
 ssh = ["bcrypt (>=3.1.5)"]
-test = ["certifi (>=2024)", "cryptography-vectors (==44.0.0)", "pretend (>=0.7)", "pytest (>=7.4.0)", "pytest-benchmark (>=4.0)", "pytest-cov (>=2.10.1)", "pytest-xdist (>=3.5.0)"]
-test-randomorder = ["pytest-randomly"]
 
 [[package]]
 name = "decorator"
@@ -536,7 +595,7 @@ files = [
     {file = "pycparser-2.22-py3-none-any.whl", hash = "sha256:c3702b6d3dd8c7abc1afa565d7e63d53a1d0bd86cdc24edd75470f4de499cfcc"},
     {file = "pycparser-2.22.tar.gz", hash = "sha256:491c8be9c040f5390f5bf44a5b07752bd07f56edf992381b05c701439eec10f6"},
 ]
-markers = {dev = "platform_python_implementation != \"PyPy\""}
+markers = {main = "implementation_name != \"PyPy\"", dev = "platform_python_implementation != \"PyPy\" and implementation_name != \"PyPy\""}
 
 [[package]]
 name = "pydantic"
@@ -670,7 +729,7 @@ files = [
 ]
 
 [package.dependencies]
-typing-extensions = ">=4.6.0,<4.7.0 || >4.7.0"
+typing-extensions = ">=4.6.0,!=4.7.0"
 
 [[package]]
 name = "pynacl"
@@ -901,19 +960,6 @@ files = [
     {file = "types_pyyaml-6.0.12.20260518.tar.gz", hash = "sha256:d917f83fb38462550338c1297faedd860b3ec83912b96b1e3d73255f7473e466"},
 ]
 
-[[package]]
-name = "typing-extensions"
-version = "4.12.2"
-description = "Backported and Experimental Type Hints for Python 3.8+"
-optional = false
-python-versions = ">=3.8"
-groups = ["main", "dev"]
-markers = "python_version < \"3.15\""
-files = [
-    {file = "typing_extensions-4.12.2-py3-none-any.whl", hash = "sha256:04e5ca0351e0f3f85c6853954072df659d0d13fac324d0072316b67d7794700d"},
-    {file = "typing_extensions-4.12.2.tar.gz", hash = "sha256:1a7ead55c7e559dd4dee8856e3a88b41225abfe1ce8df57b7c13915fe121ffb8"},
-]
-
 [[package]]
 name = "typing-extensions"
 version = "4.15.0"
@@ -921,7 +967,6 @@ description = "Backported and Experimental Type Hints for Python 3.9+"
 optional = false
 python-versions = ">=3.9"
 groups = ["main", "dev"]
-markers = "python_version >= \"3.15\""
 files = [
     {file = "typing_extensions-4.15.0-py3-none-any.whl", hash = "sha256:f0fa19c6845758ab08074a0cfa8b7aecb71c999ca73d62883bc25cc018c4e548"},
     {file = "typing_extensions-4.15.0.tar.gz", hash = "sha256:0cea48d173cc12fa28ecabc3b837ea3cf6f38c6d1136f85cbaaf598984861466"},
-- 
2.52.0

