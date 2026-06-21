Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EF1CD98F0
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 10:39:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E25C4028F;
	Sun, 21 Jun 2026 12:39:36 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 26C084028A
 for <dev@dpdk.org>; Sun, 21 Jun 2026 12:39:34 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7D90D1400068;
 Sun, 21 Jun 2026 06:39:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Sun, 21 Jun 2026 06:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1782038373;
 x=1782124773; bh=ajefyeZJZqfH6TtAqWrvmkZvjkmvqy0VH4Rz2Z3SBIQ=; b=
 Ge6sidcH9MEG2wOoKbvBcLSq7/qxzQ0OdqjMC8vAJH6R2R2Ss4Lj8D8Kwm4QF0YU
 fA5hYq777gc3YEt91pRaqaYdpvtEAKferR7VURo8LTre5nJOTZ9k4Y1jqU6GAEyl
 DeiKq9/9BKxOw7EsJbW9U0Jf2X7Vw65Ypc+ivZvELHaQi9WkWdoB6Y9ttnjDC82R
 CJwaShxivjSBX0XdAykt914i7Z+iDp7t/UuyMqXpm3M2vfy44e/XvuIjA+SNyOPG
 Dng6cbYX2nw6nYKNZg1VdzAdXJ54eIe8xz5JBzXg/M2Nusnk1N2aD1J2+jbEmeiW
 w+H9B2fWx6vtAeOAeXEN+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782038373; x=
 1782124773; bh=ajefyeZJZqfH6TtAqWrvmkZvjkmvqy0VH4Rz2Z3SBIQ=; b=g
 yAfje9NMNSei0QOqC8vfGJAXu7U+sQWk3qAHcB2bxbzOBKxhhenHZJbCZ+RHwxP/
 NLtWFj1Qj71DVLiH7FcSL6DZ4wmM38o9rIHhuQRFf/YjidhkVpiKj9VxGQcEmgO1
 mLL+TG2zv7PRmI3YdJkc2Y7e8xzf84RrnAsbiSqiv66I4J/niSKHTGA8tbEKNziz
 ttfRfNnU5kYScXK9kFLNSzu/Fq2/TLVCI8H/mffbG7FElJGRefLtzY7YjK7YzWKj
 Yh7QhCnkf+YkIi8lXCcNe1n89YExQEo8x7Ctb2LyyjStUnKJnkRVNEBqK9l9NKEE
 DoNg0i+JraaG7S6QLX3gA==
X-ME-Sender: <xms:ZL83aj6tLgYKqn3XYvKMDft8EF8RawA2_l1badKzB4DbpGCS2htKgA>
 <xme:ZL83ak51ZesCqX7lsws2N1Q7Db0vKqE1vy6FodGpP_mL247js1WkImnAQ3yk7dp3P
 Ejf-xUkNJJFZUKQBBSdYzoB0R48B9m_X0TEoDbV2BULGi0OeipAeQ>
X-ME-Received: <xmr:ZL83aspWQqww_OTjpjsjYDf6gSUoy7VNjUTvodyWytomYxq7GtSMKKuNc8G8dUZWXrKK9wKstp6tZKHv5MHUwqOdPQ>
X-ME-Proxy-Cause: dmFkZTGJQQIlBWoZDRr5jus5WY89LB/9o/T0ktiepoU+IngbEgRpk1HWyzTQxspH+VmizF
 o8d18Cg0Cn0FLDEpvvpEzp3dFpiZnzixo1oxDMwwTziup3ht4Y2Idg6YUdhZ/OtQls9MkQ
 grM6dVasxwvmwiIydov72eF1wOHLf2obVX404QDV90Z5JpO/9ZcqV7hZa5VN6+gXABlJ9D
 z4KHRYYAzxCVlCOIJc7paB9cUZ9mcUZxIRoIqmdYz61mWskHKeTnbOpA1Ls85I41yiZToP
 JQQChkB9/IQcgZZPJh8n7B5IPPPzYKFDqRUgG43s4vDiubLJFpXn4q9JoebVfhZjwS1LQ6
 e9TyIfbZU7VRo7Mgk2rgfrOjLEMyCOU+Qf60DbYDOxqTsFCpPG68YwZXz2EO8Nnb9qqzy2
 woAUuUV7DR0IIkDLPtei2LxoVWKy3Gybkmt34rtr2yZigkp9G3DBplnx5E7zMQQeen3hsd
 mXaGzkiMF+YUnSJE3gMDkYkAFob1SaCmWtT5gWOrh4tncXAvrC126DvfIYGNcCXuPzmXk0
 YUPm2bmSdKXeC/J1btn4/N496ZTXHHM5t/eHOs/h0VSAccDcjQ8M0qRj6r/alIsGqrqwb+
 9WClW+93pcg3xBcQbeQyCV2ZR1cPDTaAOa1HxdhfWZWjkyQR14FHZmgxjsRA
X-ME-Proxy: <xmx:ZL83alNQJFNbUzYrfhL6h3I_8Jm9HDiPw8kXeC2bZHgJnqYA2mtBvQ>
 <xmx:ZL83ak2aQpQiryAXRv8JcRaiFF1KhBbqX34QS09JLM04ZVV5lmsBzA>
 <xmx:ZL83akCWhQkmy5Vrz3MP9unAbjE_zU6a6qsHA-ICvut9sgr4rLMV0w>
 <xmx:ZL83ahKpXpc5Q_6YInKK92_lCUSIJmtgbqaA046kMHPHsUplbIfcpA>
 <xmx:Zb83ali1tA2z7lWzlGyvPr06a2omXnAJ9Kcp2M749Lc_Bk62s_mFsEil>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Jun 2026 06:39:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH] eal: revert prefix of lcore roles
Date: Sun, 21 Jun 2026 12:39:29 +0200
Message-ID: <6XWoHn0mRd2qYPJYIrIkiQ@monjalon.net>
In-Reply-To: <20260621101406.2776900-1-thomas@monjalon.net>
References: <20260621101406.2776900-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

21/06/2026 12:14, Thomas Monjalon:
> The CI is not ready to accept changing the prefix of an enum
> because some warnings are raised by old versions of abidiff.
> 
> Let's revert for now and take time to update the CI labs.
> 
> Fixes: c3640830470b ("eal: prefix lcore role values")
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Quickly applied to resolve CI results.



