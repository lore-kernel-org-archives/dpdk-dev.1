Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7E2C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 10:23:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE22542D26;
	Wed, 18 Jun 2025 12:23:27 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0E68F42D0B
 for <dev@dpdk.org>; Wed, 18 Jun 2025 12:23:25 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I8xmGZ025700;
 Wed, 18 Jun 2025 03:23:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 1v4IZxzFU2fsw760Cv2QALHxnwKZkemSVovJf7UWPc=; b=RP/Tkcbghrw2//1Y4
 gR/ScOyUhT4VeV+FfNoBIyWtuwFKruOf2WwXQ0i7VUJp3QzrCAjhygXMUyk2obQT
 4yGhvFQWK6KdhoT51jwAgI95a8mtuAecU7WWSi+k4cfdA13v6i2ewcb7L7K6XJGm
 EvGIjeR9Hh/pNY5OQOEJXDMnwlg93nqESuvcuzqXbcpiXKb2vgr33Jz+pXw0PScz
 /XbXunvGQGJ/t9VjSt+nYuHSmNNvmQsu5RaD2b4Ngk6WHvPJDwHCQTIvWDgX9ICH
 Us2ruRkA7SlOHhuIDKaJoJa3MC427t3f4KlytfFzMNkc07K7iEf7v8vr4bdbvcqR
 eeFJw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47bj4xs550-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 03:23:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Jun 2025 03:23:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Jun 2025 03:23:23 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 8E4DA3F7045;
 Wed, 18 Jun 2025 03:23:21 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <mb@smartsharesystems.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <tduszynski@marvell.com>, <thomas@monjalon.net>
Subject: RE: [PATCH v2 6/6] trace: add PMU
Date: Wed, 18 Jun 2025 12:23:20 +0200
Message-ID: <20250618102320.97107-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD08@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD08@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ULrdHDfy c=1 sm=1 tr=0 ts=6852939d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=8rWy6zfcAAAA:8 a=Iu4DN6-KYzHTt68a5WgA:9
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA4OCBTYWx0ZWRfX6JLPs0v20Ivr
 Dx843qhmk6z8E2K4BUzEmidFk/Qo0/klqdtd9h6x6iLdCvg8UQw4Lf9sscROym7CWcTSjfUNg9r
 aew4H2rhnCX3WybvTpw7zPgUTKLqpUrq3iNwQ6USaKQfS//+gkZgeUC7jwToKgkEouYy2PDBxUH
 QP3YIj8kTLsujPppFlKxuNhrXbot/U9IgJfdkpnGwUOUuA2w2pculUmD2XtLvCSENlODZiQDbZl
 jNN76KXU977Fij8Fl8e4vMw9PcdowS54JkjAJ7oYQUToshSWUqVP0vEUjtedBvWeHK992GMZkza
 OP46Z5b8ZWamws0MlUEMhdP6VSQfTtVQlj203zEU8vwrbh4mV6y5VzwevknfsqO3WBKriCZ7d/I
 L9nPQGDetvleB5972WGfmBsG10G35uUnuPW2khkh8R8WraRCmvJanIdmBxFfFDDK4f4McRaC
X-Proofpoint-GUID: JSuFGSGL8m_P0Df6vOpaPMnpdKMNhsH2
X-Proofpoint-ORIG-GUID: JSuFGSGL8m_P0Df6vOpaPMnpdKMNhsH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
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

>> diff --git a/lib/meson.build b/lib/meson.build
>> index 1934cb4a29..87b567f01b 100644
>> --- a/lib/meson.build
>> +++ b/lib/meson.build
>> @@ -13,7 +13,7 @@ libraries = [
>>          'kvargs', # eal depends on kvargs
>>          'argparse',
>>          'telemetry', # basic info querying
>> -        'pmu',
>> +        'pmu', # trace depends on pmu
>>          'eal', # everything depends on eal
>>          'ptr_compress',
>>          'ring',
>
>@Tomasz,
>
>Please re-read my v1 review feedback [1]:
>The PMU library should depend on the EAL, not the other way around!
>How else is the PMU library supposed to use EAL functions like rte_mem_page_size()?

Hi Morten,

Not addressing your comments wasn't intentional - just missed your reply prior to sending
v2.

Tracing is tightly tied to eal right now so adding anything "external" there brings in extra
deps. That's why I can't move pmu further down in the lib hierarchy - dpdk won't build if I do.

Once tracing is moved out into its own library, that kind of change should be possible.

>
>@Jerin or @Bruce, do any of you have some suggestions for how to achieve the proper dependency chain here?
>
>Worst case, we will have to move PMU into EAL. :-(
>
>[1]: https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35E9FCFA@smartserver.smartshare.dk/T/#u
>
>Besides that, good stuff. :-)
