Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CD2C71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 10:53:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86B4B40616;
	Mon, 16 Jun 2025 12:53:30 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EC12040430
 for <dev@dpdk.org>; Mon, 16 Jun 2025 12:53:28 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GAdGCF008442;
 Mon, 16 Jun 2025 03:53:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
 L4tykhBXS1Ry8O5GHYk/nhWv+Yq44neR2DLARaH2ow=; b=PkuOybyNps/pYsrZ5
 yh8dk4T+j68POj3WrZ2Kxre3T+/iKwpmw2dQYHAjZhhA1ei6+qb6swW1nclsOmCa
 6lxFogm6h4lbDpxLAojto7dhn8pU5d22auQyA0ruWu+e0NH4smCeUJ4LkTrobC+g
 FdpGkPlKQEL6H606jOLblF88L7xVczcnfy95OBDOyeHwso8lx/SPtQCmZ0haVM1W
 tSbp/IwcwRTQQ4dxoJ9nc698kjhmTOtfv0eXT9xQdAhvRVFQOLW0xQlxQ8zjTGey
 7h1KaX7soelms5bW3pIKTGmuvVkIOVl/Z55wckyVVS5HJdDPKU+hDhOru1XtJ094
 jPdJA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47ahpb013t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 03:53:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Jun 2025 03:53:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Jun 2025 03:53:27 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 6F1235E6875;
 Mon, 16 Jun 2025 03:53:25 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <tduszynski@marvell.com>
Subject: Re: [PATCH 4/6] lib/pmu: use build system defined RTE_LIB_PMU macro
Date: Mon, 16 Jun 2025 12:53:24 +0200
Message-ID: <20250616105324.3249828-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5659935.eFTFzoEnKi@thomas>
References: <5659935.eFTFzoEnKi@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA2NyBTYWx0ZWRfX+izWF2wOAXsT
 BHctVlnOMXvBRRS6wW4KwXVWr/Xu28a5CfVYxvpqNImiBiFvO3Uclv1TxpP6qkEDQu9oTscR239
 S6vIg6/B4cXVuq+s8QI5THKEOqRbxki0yh24LEU0rsOYL+RbCk702U368U0iYviKmHZ0yycOoPO
 i0BgRT0ACxyJrWSLryiyIjjV8A5zjE9hfsTWjS0XlcwxF5HL11i13VSXoNylD/oz05sXLIVIwzQ
 ZHBEW0KlhHFaomK/Zkur6wIcfS2T0ITNC1nGfMbWnfDL5d79NFiPJSPzXl5UwY1VUNhCMNkgXEw
 hQtsb8XepmsFYzGiCqnu13qIWDbWS+SWEZnGfYuvLT3pDFmXhCR08t9QiFUHaSYYXriYRfFLGMm
 zdi6EmeF17cTxDFvPrJIVCsoSLZzJO/99n3+0DuSZQsd+375mK3ytHdGfC6Zh9bKPMFjaDdm
X-Authority-Analysis: v=2.4 cv=UcdRSLSN c=1 sm=1 tr=0 ts=684ff7a7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=EfJid7QcyGkaUtjXi6gA:9
X-Proofpoint-GUID: FQgvLjHqJ61eh2F26MabHJSE03fISqF9
X-Proofpoint-ORIG-GUID: FQgvLjHqJ61eh2F26MabHJSE03fISqF9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_04,2025-06-13_01,2025-03-28_01
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

>16/06/2025 08:53, Tomasz Duszynski:
>> RTE_LIB_PMU is defined by build system automatically if DPDK is build
>> for Linux. Otherwise it's missing.
>>
>> That said all cases where conditional compilation is required
>> can be handled without introducing other macros.
>
>You don't need to know if it is compiled for an unsupported arch?
>

No, if arch isn't supported reading whatever counter returns 0. On the other hand
if architecture does not require extra setup (eg., x86-64) all works
automatically because Linux has consistent API for each supported arch.

>What will happen when calling the unit test on RISC-V?

Test will be skipped because event is set to 'NULL' by default. Supported
architectures override it with valid name.
