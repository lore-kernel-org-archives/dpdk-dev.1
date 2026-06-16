Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434ABCD98D2
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 07:58:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BF7F402DB;
	Tue, 16 Jun 2026 09:58:04 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4B45640289
 for <dev@dpdk.org>; Tue, 16 Jun 2026 09:58:03 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G65xvs1992644; Tue, 16 Jun 2026 00:57:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
 7DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=aIAmmhxL4q3HPEVG9
 b1rGbsJEDfATXp+6h+vkjNppP0u3ppjGkbCyJaww+ac3OR6X26SUzWX0Mk+vxqwr
 l6JNYEcwG6QcCTqkRypzZQcTDt9OtU9tu1c4WtKyfwvJ89kdepXWYM4gXB277u1I
 bC5N/xZzD2k+OoFdUmuDt4oUFrxqb7l1MGZm299maUVQiXOnJjgwCaVC8ERYCwyQ
 MhMQaloKqGYglDH3CNXprriuDWpuaCyYec5FMBxxlxWzMowdvoPth7eALWha7ihS
 nSFB4/kDeDcPlvvUX3bmq/Rnd5Lw4mZQxo4nhG5RYaph0NkXg9AFbdZBW2dRvWH+
 u/ymw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4etu38hrn8-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 00:57:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 00:57:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 00:57:53 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id D2EAF3F7099;
 Tue, 16 Jun 2026 00:57:49 -0700 (PDT)
From: <kirankumark@marvell.com>
To: <rjarry@redhat.com>
CC: <cfontain@redhat.com>, <david.marchand@redhat.com>, <dev@dpdk.org>,
 <jerinj@marvell.com>, <kirankumark@marvell.com>,
 <konstantin.ananyev@huawei.com>, <maxime@leroys.fr>,
 <ndabilpuram@marvell.com>, <vladimir.medvedkin@intel.com>,
 <yanzhirun_163@163.com>
Subject: Re: [PATCH dpdk v2 2/2] graph: replace circular buffer with
 priority-based bitmap
Date: Tue, 16 Jun 2026 13:27:48 +0530
Message-ID: <20260616075748.2354181-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <DJAAFGOSALXB.3BJ91NA2ES267@redhat.com>
References: <DJAAFGOSALXB.3BJ91NA2ES267@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: p8pVBd7eZyxFR10w3sgqaMS-DG-iNJKG
X-Proofpoint-ORIG-GUID: p8pVBd7eZyxFR10w3sgqaMS-DG-iNJKG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA3OSBTYWx0ZWRfX+YhLwcAye73t
 PA1pDn/HZCNINV9WbW5FVVBbo9jWwCuf6WKcbwmLoF7iPhjdoADibDzbb3LbbZTUTt0oCOTM+ez
 6ahlxAa9eyApxyNJfqZ5CAUx1rDRjXg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA3OSBTYWx0ZWRfX2ddna2ZaxOxh
 4XcDp5KdsgoVv2qAJIv80bVi4L57KywaTVwx6wjr+GB1dXZvv/30NeJrh7l2y/CFNbL/RZu5/qY
 14sJnI86p8HH8S9dbrFTj9S+/U7MOkYsXz2isMv1OGTnn4IlShDouw0w4cdvR8L6rnFQ1UgiTN2
 VQQhbDBCapZHvrCpoatqQNxDs0m14fqP0QFFBjnO9x+wfGRf6gJ8NJrLvNf3hSaD/wz9uNFPqlz
 tg5tkeSA9UPxbFx/If/YmLqMGHGxJH1jxDZKi4jDrdS//q1kYknUfpWpRz+O+HMLVE6dTGIkMrq
 17755IsRKa/r4d3z8cjnXMN3ULw6GpT0NBa4cCCb+OFVHmUecNcG4fcFk+d7mMvGvGFMv+tO87R
 HXEvxk28Bxtge47O9XmeNg/1nuFUQ/8TYL/8GYe+9WpLg2YdDSSpwdIuMvJONH7jl/5McLdgAe3
 TIHqQDUojvRE8BRZhZw==
X-Authority-Analysis: v=2.4 cv=SeXHsPRu c=1 sm=1 tr=0 ts=6a310203 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=tclcd6dtLQvEqt9_mmAA:9
X-Proofpoint-Virus-Version: 
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

