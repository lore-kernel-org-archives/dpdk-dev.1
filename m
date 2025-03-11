Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7426C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 16:04:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0257C40653;
	Tue, 11 Mar 2025 17:04:50 +0100 (CET)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id CA5F04064E;
 Tue, 11 Mar 2025 17:04:48 +0100 (CET)
Received: from phl-compute-13.internal (phl-compute-13.phl.internal
 [10.202.2.53])
 by mailfout.stl.internal (Postfix) with ESMTP id 1218311401B7;
 Tue, 11 Mar 2025 12:04:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-13.internal (MEProxy); Tue, 11 Mar 2025 12:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741709087;
 x=1741795487; bh=Wb/TPeQd3DkSVqPLWUNtHuuPQS7Jxc5gICse0VGIJXs=; b=
 jF8lp65oG5rVitw/4lAm8SgKf4/kzq/Q+SYgLajLu6ZW0NoGW1TWQBs2QByNXpdE
 pDSMdYaMdud1snjTo/caPjNDFaOKxk27+mvOiv7aNGSgwCgbwgye7hgLGYDyemKq
 zDA1S7Ad5+q7279YZtjAOH4GTM6HjwDVv/ZCdwO9l4CCuhMbgMAK0wdmxP6ttHem
 e+Q5Du0aInthh3FWw0qMZDKaKazZkQXQxo1Fu/D9Z6TIDB9SznLNPtVw8ouvbS78
 u137rc7GH2qj0Xde0Km3cg7YexL4bT5tTf/CS+JDLFGgothkjOUuEkbSqttdotfo
 45Qh+WUo6RObGEm/tLXNUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741709087; x=
 1741795487; bh=Wb/TPeQd3DkSVqPLWUNtHuuPQS7Jxc5gICse0VGIJXs=; b=n
 PKSl2/Y8MDk5qq+/H+cHnm76ur7VlH7cF7kph9NAyzZYa2xEV3MehsJHdb+aXbxl
 +OR21cz8k9tG7s6CmAHQ9FIMkUvnVV/sO9Sp+OYbppruN+AjugmCYzoRnzPDbcvA
 Y7FTN02HccXkBRZXrq9m5wXwU4wW9Cf5j5vb2SwOxOaMZqwkJLYY30Wk27c91sXk
 lso8x/MmqxTp19iNlx1vG8znX8xwrf0u1G526/H7PbI7F6nAYmMPpR4/VSQHcQm+
 WQOCisOKZLGXN3WgaOg1krXZ1fg2EEp5bP/MQfFFCm9Uz6VoSWvMMYBLc1jpQMdB
 PzKw8HHofI7qiU/SDStRQ==
X-ME-Sender: <xms:H1_QZx8gh9P9IyvT_0ngF2umgZt1vWBrVCj2vn0RifKt-t8Tue-vRQ>
 <xme:H1_QZ1uj7j2J3URrhEpDud26fqHRIeWA_z9VzFqs-c5gz8-JvyC22McN5MFrqZgXm
 nF0cyq6wYuL0Q-pSg>
X-ME-Received: <xmr:H1_QZ_Cnoz5aGoOa6OWWBoEA6iJclL46gNKix_5Z-E7pqAVQj60TN0HrKNR06JZSMbsAh7w9UGmcIMYjtH2_9DyPkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvieeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkth
 hrrgihnhhorhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdho
 rhhgpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopehfvg
 hnghgthhgvnhhgfigvnheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:H1_QZ1eNs-oCh6lROJLiPH7iqdBN3Z5XBSX6himowmrk3uX2yET1Gg>
 <xmx:H1_QZ2Mc5zn-XSRqqfj3LZbfJ1aolmJx9kC7XhEbng6hSYInHyhoyA>
 <xmx:H1_QZ3mkEtFF2p9HuGhtbi8RpJJngOu-T8K797Ys3RJsNhZm0JakJw>
 <xmx:H1_QZwtP3sTBsjdAvnkhdUt-e_-ZrRktyJPJHqAzvTqbu0fSDSdVEw>
 <xmx:H1_QZzqUSAq2K97h1PjtnZXkrlt8PJLCl_kMo6pgwgb1HBg5A69-evIS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 12:04:46 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH] doc: fix year of final LTS release
Date: Tue, 11 Mar 2025 17:04:44 +0100
Message-ID: <3548747.QCnGb9OGeP@thomas>
In-Reply-To: <cae9e62c-6b32-42bf-8ba0-b241c5347581@huawei.com>
References: <20250310100807.17559-1-ktraynor@redhat.com>
 <cae9e62c-6b32-42bf-8ba0-b241c5347581@huawei.com>
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

10/03/2025 11:28, fengchengwen:
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> 
> On 2025/3/10 18:08, Kevin Traynor wrote:
> > LTS length was updated to 3 years, but a sentence saying
> > when the final release would be was not updated.
> > 
> > Fixes: 3c60ea7b289a ("doc: update LTS maintenance to 3 years")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Kevin Traynor <ktraynor@redhat.com>

Applied, thanks.



