Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA9BC71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 09:49:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 711DF40292;
	Mon, 16 Jun 2025 11:49:11 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 441054027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 11:49:10 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G0Q72K019729;
 Mon, 16 Jun 2025 02:49:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
 WTEaR+QnnBZrnobeZYo6bl1bWtk9Kxwf28pgmLj8o8=; b=WNExi1940FhOeM1dX
 DUMCTwZ8pQ5DpcvyDLqVS4gT3mZ94tuyrNVWuSzs7CGXQ6G0CPF0l8xjHGYHb8Jl
 EyBwmvpK7XHc+uvh6AGluPDCrp9Orwn7q3c58qvdLZ8LvceRQAR8TdhTvugq6Onp
 z3o70Fc8QEnXLdxgqS7hZ3xKFLi7LRVLKT4xDDWF3lWOGO5EqUqpvqvxEuPEJaD/
 Sy3+QWRtEPieF+SrblQmDSgahWDTk3pvweDqWTyULqzNx7Nx3BqWRo0KFIBF9Szz
 sUTaMtl1nfpI8OyJlSLk4bvbeiBV//fl6W1iyo7r2iKV/CJ3biJu/C/2eeOB4puS
 l5qBA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47a7w70xps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 02:49:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Jun 2025 02:49:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Jun 2025 02:49:07 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 85BE85E6875;
 Mon, 16 Jun 2025 02:49:04 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <thomas@monjalon.net>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <roretzla@linux.microsoft.com>,
 <skori@marvell.com>, <tduszynski@marvell.com>
Subject: Re: [PATCH 6/6] trace: add PMU
Date: Mon, 16 Jun 2025 11:49:03 +0200
Message-ID: <20250616094903.3236231-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <21436140.jiFIW2sfyF@thomas>
References: <21436140.jiFIW2sfyF@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BIyzrEQG c=1 sm=1 tr=0 ts=684fe894 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=ceaQQ3d119qUQWZtUc0A:9 a=0lgtpPvCYYIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA2MiBTYWx0ZWRfX7MYv1R5tzMpk
 tg+6Cj2V56n7jTZ38YA1d8iR380UkiGs9NNr0W9IWmQy/v4uXh9cExZMmiSAltQ9rjlzBVAgG0X
 D18iZx7JDao9QdpW87U/fFhEbr9YZgslPkTl19GLSgUjzuJQgIz9I/hr5xGUS0nuxylJXGLVtVl
 f6Hjzq85y0dY1mKT9dcZCvsxYRcCaREqv34z57szMRs3oNfFxGSkvgj+JRpVHKj8kCKVvcfjOEy
 HGjVMjDz9ZuurTn6WlXUtFBWWy3daHw8Z8My/HTXQUG/S4V5ZJvFsSWXy+qVyjaFYrxnPfRJ5aL
 krXgNmdFmmCjrGkFU7xvN4y/NQrinMZU0bKv4z9yIig0WFvrHQ6t5PMrLRGGWxgoGDQRnJxhlM/
 0olFsW1EcSCRCPsE55nGEd52Tbv5QZGZC+PQ4GhVqz60IL/Ywvan3xG4b4B03ae2NEGGu8B0
X-Proofpoint-ORIG-GUID: -cmZO-Gk4hXREIQGl75neqNMkmwWgW6t
X-Proofpoint-GUID: -cmZO-Gk4hXREIQGl75neqNMkmwWgW6t
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
>> @@ -86,6 +86,7 @@ always_enable = [
>>          'ring',
>>          'stack',
>>          'telemetry',
>> +        'pmu',
>>  ]
>
>This list is alphabetically sorted.

Right, missed that.

>
>What is the justification for always enabling PMU lib?
>Is it a good idea to always enable an experimental library?

Well, since on Linux eal depends on pmu, disabling pmu ends up disabling
eal, which breaks minimal build.

As for the second question - no. I think ideally lib should remain
optional. However, since trace is part of eal, that indirectly forces
pmu to be built.

Alternatively, I guess we could make the library explicitly optional by
extra meson option. But given that there are already options for
controlling libraries that approach is not perfect either.
