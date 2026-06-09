Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E032CD8CAE
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 05:00:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3B42402AD;
	Tue,  9 Jun 2026 07:00:36 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9C55D400EF
 for <dev@dpdk.org>; Tue,  9 Jun 2026 07:00:34 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6594Ku2h026583 for <dev@dpdk.org>; Mon, 8 Jun 2026 22:00:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=JYvlmSxRmhbJxM+Mg363xgO
 +s3RUvd1QAsJXrvBUYEM=; b=BEluZ9NXvo9AYYrnOTSeawNZHo6+C285gVIrK5E
 HdOnCTG+nCW/DyLEDefFxEU7Panm9BjAo8PLINbYrKu8+k5shxkBPXG0Mrq6rj7g
 nW46BJIhflNKsuuhtf0/p8TWGGJmaLNq1Nn+DWyySAt+4gBn1RWJ5+58qq+xEMD7
 /y1K3Dih3OrOQKDGsFuS+QCsKas0ZUtLPJSNDadmBAdlW5T+B7xQShTHTRaB1Tj0
 my5Oc1GEuLSynKBz7PTqQvdbR4j1wcfnVCxUqlofCwtdWJIzOBbDxiXC2btPpKAL
 SW/XFO43HuFRhKk95EednFP2M/ba6NvXQyOwDWnHRIFMEMA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4epbqp832j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 08 Jun 2026 22:00:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 8 Jun 2026 22:00:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 8 Jun 2026 22:00:32 -0700
Received: from sj4r760o4u9.sclab.marvell.com (unknown [10.110.150.37])
 by maili.marvell.com (Postfix) with ESMTP id B30CB3F7057;
 Mon,  8 Jun 2026 22:00:32 -0700 (PDT)
From: Srikanth Yalavarthi <syalavarthi@marvell.com>
To: Srikanth Yalavarthi <syalavarthi@marvell.com>, Anup Prabhu
 <aprabhu@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <sshankarnara@marvell.com>,
 <ptakkar@marvell.com>
Subject: [PATCH 1/1] mldev: fix incorrect captions for model_ops
Date: Tue, 9 Jun 2026 10:30:20 +0530
Message-ID: <20260609050020.995268-1-syalavarthi@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA0MyBTYWx0ZWRfX5ezlwVsq3zUC
 2JVfnMCedIZEIQ/E55NLYUKDSoUNI+4pt8Cp2RpeHruxy2rVeeNG0SDt5xfkBp3K7djAkeyc+Cw
 N81+9qnAlLfDJq2B+rwauMTafxEnbVE8iQ2wiymEpv8eMYj3e/pTZkjRQJH+8SoyIkJWvryiaxs
 RDnd7dKptLqBZ6YOBvO+COBqOqMiec2uhnozGyZAdTy54aCqp+roAOQLZ3gUCzMKp6rjgFS7LeN
 anQjEZ8EPcVYj57Hlmik51+n/7OB/aHXOxDYdZ6BSn12SiePP4cax7GVRew0XaoVi8h3CxNJ48G
 nla6djoehhuhbQbZe12LuewgaOYKN67kTgrJEUE5zPMgnHiWMB3upNse5VBLvEWNrRoj3BADe/J
 jYyCHlI1e9tGaLJFtljxJnT/jSclkKX/NvgUgBDr2ZCtT0oxI5U93pD94cFxKm+KkK1CiWOQorG
 5kO25iM6b8WrJ9FrNpA==
X-Authority-Analysis: v=2.4 cv=Y6zIdBeN c=1 sm=1 tr=0 ts=6a279df1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VQ9ene8lAAAA:8 a=FP58Ms26AAAA:8 a=SSmOFEACAAAA:8
 a=M5GUcnROAAAA:8 a=hDWePBbWrKGjLJMAR7cA:9 a=5kMfGx23w8a0v5ansn-_:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 2EJhK4WMBoJlhlBDu1K-wVQ7JNIxPzX4
X-Proofpoint-ORIG-GUID: 2EJhK4WMBoJlhlBDu1K-wVQ7JNIxPzX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
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

Fixed incorrect captions in images depecting the
model_ops test flows.

Fixes: f6661e6d9a3a ("app/mldev: validate model operations")

Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>
---
 doc/guides/tools/img/mldev_model_ops_subtest_a.svg | 4 ++--
 doc/guides/tools/img/mldev_model_ops_subtest_b.svg | 4 ++--
 doc/guides/tools/img/mldev_model_ops_subtest_d.svg | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/guides/tools/img/mldev_model_ops_subtest_a.svg b/doc/guides/tools/img/mldev_model_ops_subtest_a.svg
index ed12cc5a05f..9b38300d1d7 100644
--- a/doc/guides/tools/img/mldev_model_ops_subtest_a.svg
+++ b/doc/guides/tools/img/mldev_model_ops_subtest_a.svg
@@ -10,7 +10,7 @@
    version="1.1"
    id="svg5"
    inkscape:version="1.2.1 (9c6d41e410, 2022-07-14)"
-   sodipodi:docname="mldev_model_ops_subtest_d.svg"
+   sodipodi:docname="mldev_model_ops_subtest_a.svg"
    xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
    xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
    xmlns="http://www.w3.org/2000/svg"
@@ -407,7 +407,7 @@
          id="tspan390"
          style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:Arial;-inkscape-font-specification:'Arial Bold';fill:#000000;stroke-width:0.5"
          x="-120.71075"
-         y="220.77164">mldev: model_ops / subtest D</tspan></text>
+         y="220.77164">mldev: model_ops / subtest A</tspan></text>
     <rect
        style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:0.448724;stroke-linecap:round;stroke-linejoin:round;stroke-dasharray:none;stroke-opacity:1;paint-order:stroke fill markers"
        id="rect2164"
diff --git a/doc/guides/tools/img/mldev_model_ops_subtest_b.svg b/doc/guides/tools/img/mldev_model_ops_subtest_b.svg
index 173a2c6c059..d692b2ee023 100644
--- a/doc/guides/tools/img/mldev_model_ops_subtest_b.svg
+++ b/doc/guides/tools/img/mldev_model_ops_subtest_b.svg
@@ -10,7 +10,7 @@
    version="1.1"
    id="svg5"
    inkscape:version="1.2.1 (9c6d41e410, 2022-07-14)"
-   sodipodi:docname="mldev_model_ops_subtest_a.svg"
+   sodipodi:docname="mldev_model_ops_subtest_b.svg"
    xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
    xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
    xmlns="http://www.w3.org/2000/svg"
@@ -410,7 +410,7 @@
          id="tspan390"
          style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:Arial;-inkscape-font-specification:'Arial Bold';fill:#000000;stroke-width:0.5"
          x="-119.78458"
-         y="220.32892">mldev: model_ops / subtest A</tspan></text>
+         y="220.32892">mldev: model_ops / subtest B</tspan></text>
     <rect
        style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:0.442854;stroke-linecap:round;stroke-linejoin:round;paint-order:stroke fill markers"
        id="rect3967"
diff --git a/doc/guides/tools/img/mldev_model_ops_subtest_d.svg b/doc/guides/tools/img/mldev_model_ops_subtest_d.svg
index 3e2b89ad256..bf64f2b8360 100644
--- a/doc/guides/tools/img/mldev_model_ops_subtest_d.svg
+++ b/doc/guides/tools/img/mldev_model_ops_subtest_d.svg
@@ -10,7 +10,7 @@
    version="1.1"
    id="svg5"
    inkscape:version="1.2.1 (9c6d41e410, 2022-07-14)"
-   sodipodi:docname="mldev_model_ops_subtest_b.svg"
+   sodipodi:docname="mldev_model_ops_subtest_d.svg"
    xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
    xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
    xmlns="http://www.w3.org/2000/svg"
@@ -411,7 +411,7 @@
          id="tspan390"
          style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:Arial;-inkscape-font-specification:'Arial Bold';fill:#000000;stroke-width:0.5"
          x="-122.00021"
-         y="222.26495">mldev: model_ops / subest B</tspan></text>
+         y="222.26495">mldev: model_ops / subtest D</tspan></text>
     <rect
        style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:0.462341;stroke-linecap:round;stroke-linejoin:round;paint-order:stroke fill markers"
        id="rect3475"
-- 
2.34.1

