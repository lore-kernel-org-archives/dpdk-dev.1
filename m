Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627B7CD37AC
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 09:39:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64910402F1;
	Sun, 17 May 2026 11:39:05 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id C639740278
 for <dev@dpdk.org>; Sun, 17 May 2026 11:39:03 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 464C07A007F;
 Sun, 17 May 2026 05:39:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Sun, 17 May 2026 05:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779010743;
 x=1779097143; bh=jAdHjwC6Wr7gn7VDbbUqSyWhv5QP7APzyXHnnfp5SPs=; b=
 rbblYF0FlUQsk3MJUb8cIjtZxt42a35of9KJ/cg5/kg3V+rnJSjnA0MwgyCvYR8p
 7wyzocQOAhFz+UREdTJ4bt72kl8YacBnsXJv1JZz1HBDC0PgZKUPoNzf3nd89S54
 cYLyYFLR50XFrJcJABkWOYplXDi7rLN1uxO75GJCs/5EVNAgfdvGkz0rean4vve5
 7hhSwjnzOptdsZxcoZLSU5xD1IPFOkoD5Uz+upZrXnFzDF0YNWbmy/GUQR84CAz+
 SgjtN6B1J+j4/akxc8Zz60V1dZIN36jwzryJoTP3rfuOYS4JigsgwZrLLr9XfCYP
 HIQ9EufTeQmP21KzOnGmww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779010743; x=
 1779097143; bh=jAdHjwC6Wr7gn7VDbbUqSyWhv5QP7APzyXHnnfp5SPs=; b=m
 71Gb01dG94RG7VnzzGzXi1x4Tq3yOyC5h3ZizKxWRJF8b/l/Fv0jV6aSo1zuS3PL
 ldrEaYZRp4GrTeWy2nsmB4EvfvJgIEG0vBa7jgW6kepTmXAsrkN90l1Pc4m30ydX
 49RC0IV73kdoAuK42hP7+TWCj+mOXmTPvJhA7FlN/z9euaBT/JuStJVEnQ+lwB5C
 qE8y+etyr1IO6cmnq4/ZhDjVMxpy117z0c2qKDTU58/C+jhGNECcgt4+bkTHlzcv
 k5WY3OrrP81yOWaPtKN014cJoB7FQr/FdSbll7K1BLGLrahR4Vr7cIOHSBOJ05sg
 HzJB8jYCwrIoTHoXHjJCQ==
X-ME-Sender: <xms:t4wJap7TorsXfSygeY9fYtyHHVjkNvU9mvkAnr93hdLJ0un9vPJHQQ>
 <xme:t4wJakscPCHm_VNCZqwWJc3ycFHkbMvwhM5kXxfdjM8-KNMuwKKUOs6z1tIsOWpEG
 Mf63SxNMbXZOwZpKNKoI9r0NfUHhYMD45wFdJ-qmc6KBxr5BvkfEr8>
X-ME-Received: <xmr:t4wJaq6jaPQ0HV3CcBL6n_qLKxuxlgSC-WrUz3rKmqX1tP-6LU2wD4exaYR91PfBlokaUtCIaZZ8cL1NlhzWRd-SNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeehieegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeifrghnghdrjhhunhhlohhnghduseiith
 gvrdgtohhmrdgtnhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhm
 sggvrhdrohhrghdprhgtphhtthhopehrrghnrdhmihhnghesiihtvgdrtghomhdrtghnpd
 hrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:t4wJavVSmiqLvLJW22uXjq2x5cxT_3CKLEfBGJcpqxhobHaL07a7jg>
 <xmx:t4wJas-DBEKNhuEA_m3mphChbfi60IuMIZhYYykufDU6L8_L4ZnFlw>
 <xmx:t4wJarn_WEqjQL7VXHybFr5JQ7h2L2vKyHycKtWdHrrrbXxFsSo5rw>
 <xmx:t4wJaqWqQ23287he1uJnvuCtFHyh7da2xFRdph03UV36x-4Tr7G9Ng>
 <xmx:t4wJao_HXAf9AHp4y1ZRM7SNbgx2zZb6GjrqSSCe4AE41TBkM2CgbP9X>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 May 2026 05:39:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: stephen@networkplumber.org, ran.ming@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v1 1/2] net/zxdh: add supported zxdh support nics
Date: Sun, 17 May 2026 11:39:01 +0200
Message-ID: <UJODx65PQSyhfbuj43Jw2g@monjalon.net>
In-Reply-To: <20260514015650.3500578-1-wang.junlong1@zte.com.cn>
References: <20260514015650.3500578-1-wang.junlong1@zte.com.cn>
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

14/05/2026 03:56, Junlong Wang:
> update zxdh nics doc.rst, add zxdh support nics.
> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>

Series applies with fixes mentioned in the mail thread.


