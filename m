Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7C4C87FCB
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 08:32:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE63E4025D;
	Mon,  4 Aug 2025 10:32:48 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3D24A400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 10:32:47 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5746b3Ew031391;
 Mon, 4 Aug 2025 01:32:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 wzSaCxOfEOwqxE+r2KRife9n7A6eDfTSnA5yrxNI2o=; b=GwZ6REmIOCDz9pD87
 QVmDeBU3cIPp3uTQ6J74xJ474UfZ7I8QwGA4Q8DRTP0qD07fnKMlM7kMppMyc2K5
 v1pY/SiO1nK+8CpcSkvxskxabtiDRdggG3SCCmGtEQRck7adQgARJotk1BMf8Sr8
 hk4oQFwpABTs0dwIYfAOh1RWGnC9gXZ/zA1k95LyC/ZxR+uDC+CVWQTmV9eHFxG8
 Thz13PspaTujbfe7aAUPPXum+p3pfQtjziyqGqJ2ucOYX88URa1OxMT9iYETwdwJ
 rX33T9ZAjC0BkWnSaOB52wJOmhT9p6b9oltIdi7PXXCFGwFgmhj2e4auCg9Ocn1M
 dAQ5Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48aqrc8687-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Aug 2025 01:32:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 4 Aug 2025 01:32:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 4 Aug 2025 01:32:44 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 7F9885B6937;
 Mon,  4 Aug 2025 01:32:39 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <stephen@networkplumber.org>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <tduszynski@marvell.com>, <thomas@monjalon.net>,
 <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v10 06/10] lib/pmu: do not try enabling perf counter
 access on arm64
Date: Mon, 4 Aug 2025 10:32:38 +0200
Message-ID: <20250804083238.4051389-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801144926.07a4d97d@hermes.local>
References: <20250801144926.07a4d97d@hermes.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -ECTbKH73vpjCasWg4RmcvhK1i7645wT
X-Authority-Analysis: v=2.4 cv=beFrUPPB c=1 sm=1 tr=0 ts=6890702b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=QGMXXc-rntxkfDxxjKUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: -ECTbKH73vpjCasWg4RmcvhK1i7645wT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA0NSBTYWx0ZWRfX1gruTzWD/N8v
 NUbted0puv0jeF7/7piqjXSiG+4Jd7EVLarS7ftzkikDM2sc9SW7FxGDd9GW4wROAuL+amBks5u
 UQnn6Rjp4OHLvNoaLXdD4aW5yx5zLgZ1krilFniT0jpx4ehS9vntb1DYPU51tqen++KbnXmtR7g
 BerM0HP8lkCb8c3kkr0OAFdH1AVjgiMERBcXbX8dpscC73J3N5aE6BOjtg8paiUrtk9OQruV/di
 QEvqmSBFfWERmuqBFHtIPnXczBnX+iBd+ft0zFnzVupRTSQQDBQnlz86dzK+xaeD9/SIfKAen90
 DpqXRHHMYIVTP4cHCR3nflo7h8kcLOzpi4xrvAgP+e4/kHHp5ugCqT2Br2bFCQptUlHbsTAFtR0
 +LjrS9cdsQAAX4KYVTR50f7JBcRRY1ToQTOtxdstcxYvji3MomHtwnbZZIWT9yejhdCAPQQf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01
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

> On Fri, 1 Aug 2025 12:21:05 +0200
> Tomasz Duszynski <tduszynski@marvell.com> wrote:
>
> > /proc/sys/kernel/perf_user_access attribute allow user process to access
> > perf counters. Though in order to change it binary requires elevated
> > capabilities or must be run as root. If that's not the case counter
> > access remains disabled. Hence to avoid confusion log message that
> > that warns user about that.
> >
> > Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
> > ---
>
> What do Linux perf tools do in this case?

perf does not collect data directly reading pmu rigisters. It gets data by calling read() on
descriptor returned by perf_event_open().

This series on the other hand, is for allowing that direct through-register access to save on
cycles.

`perf test -v user` may be used to check if direct access can work.

On arm64 with perf_user_access=0:

$ perf test -v user
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
  4.2: User space counter reading of instructions                    : Skip (permissions)
  4.3: User space counter reading of cycles                          : Skip (permissions)

On arm64 with perf_user_access=1:

$ perf test -v user
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
  4.2: User space counter reading of instructions                    : Ok
  4.3: User space counter reading of cycles                          : Ok

On x86 there is no perf_user_access knob available so you achieve same functionality with
perf_event_paranoid.
