Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8F8CD37B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 May 2026 21:16:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46E914042E;
	Sun, 10 May 2026 23:16:31 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id D543740270
 for <dev@dpdk.org>; Sun, 10 May 2026 23:16:29 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D943D7A003D;
 Sun, 10 May 2026 17:16:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Sun, 10 May 2026 17:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1778447788;
 x=1778534188; bh=pUKO8WSL6JSSAAqEL10pjj7CakmnQVtCMHmta30Jgww=; b=
 n8JNg0k8xMOClRj3LpoSnP528vUmzO032EeQON8n9ozNzFGuxpVNJd7M6YT6A4dN
 mAhU+W9v/Fe3e1fv1LF7wJEMNotZcrwV0iBuTkoNWL6mhTRVQSitWwVfEuSAwO0F
 Ik/fu5kLpJwWPa2jUXVwJYwf0SpapYWIFKiTfx0Fj3U6a28KhZhh/6xHa7tnjArO
 g7gC0NaZXgAYiWZ56fsY9WIywerjpHwjDZEsxG+66GO4ZxymHsQq8DchqgKOYp4+
 DrsBTvVtkD8zMMYkZHiZWjOA0OHSirBp9EcG8HDFWJVZst0urCw5fN+0lC+38HYF
 T+eXvxWi1rn6qJd0E6b5kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778447788; x=
 1778534188; bh=pUKO8WSL6JSSAAqEL10pjj7CakmnQVtCMHmta30Jgww=; b=C
 4v3i0sfxusdRzrUDLALbM6BAXmF9hrHDqNxTA6++I+6ro20AKQRo0B1UbsbyZLv6
 kbR5ZOKSMxvR1DRjyK/E92zWiOC8M1YY67+ej09gU0Y6J87vh99pb7ZbgGkNo5Ue
 UEAH0jnmDiRi8h/8siE1BtqYfDsrkUM45c3//9ZZOhxa7WtJvtH72EANCaqVT8VK
 eYev5NcW7Yr52wv//hYsIR4DSushJ1VkD2vmmsmySrClFwRGiP2lWO/mHVPd2+31
 CXT+WnaM5yAMDQGBu0/QwsR9wBMSek4vI/Em0Fl11nL4jSf6qehfGUDUOrM5kNpa
 a/jjS9WGK18Vew2B8fhwA==
X-ME-Sender: <xms:q_UAasgogXLEza_5MViNbwE_tHh77HV6ovi2W0DIB2dVlB5fnaB9QQ>
 <xme:q_UAascE1IXcqTClYFh2pvS5AEww1IQbNIgtY_6e6ZWL2FBgnXMVNQn5gBK0_on0L
 PwcIq4nvYrQUy2XwOXCyTWjX3X8XT_PRxmdE1sHUOAYFsQYlNUDNCg>
X-ME-Received: <xmr:q_UAahfbgqW5JreZe85vt8DexyJ8f-gAFl5YmxdS3uT48e3OfyEpyr253CaBf0myELOAvbrwTUf8ep85NEpRVO-UYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejudeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrnhhishhlrgifrdhkrghruggrtg
 hhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhihuhgvtghhihesihhstggrshdr
 rggtrdgtnhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:q_UAam92jN3AALvVkLc_8baKot-Xi0LUf_LZfuEH0r6fAoaMW3UqYw>
 <xmx:q_UAatmi62G8Y76nwiOn32vDOl7UKa7Swqc303Rxr9OXNEPsiEgnoA>
 <xmx:q_UAao_NQL7WCy2yfu-KcR-F3pEb_wyovKvoyBC0rh0lDuUpOKVj0A>
 <xmx:q_UAarkJ7SlL31oc-mw-ecmoiUBuIHCylsBcR4PwnwQsC8CvAQnN_Q>
 <xmx:rPUAakLargfou5ju6uGrNqfTBz9NvHX8BYt3-POrCzVk1i2TtYx8aZnG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 17:16:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 sunyuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH] maintainers: update RISC-V maintainer
Date: Sun, 10 May 2026 23:16:25 +0200
Message-ID: <UbOpVan0QPCGBILDuC9CyQ@monjalon.net>
In-Reply-To: <7c10b2b5-71e9-4ef7-be7e-02da5bda7aaf@iscas.ac.cn>
References: <20260401192401.6243-1-stanislaw.kardach@gmail.com>
 <7c10b2b5-71e9-4ef7-be7e-02da5bda7aaf@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

02/04/2026 06:08, sunyuechi:
> On 4/2/26 3:24 AM, Stanislaw Kardach wrote:
> > Change the RISC-V maintainer to Sun Yuechi and remove myself as
> > I'm unable to properly perform maintainer duties due to time
> > constraints.
> >
> > Signed-off-by: Stanislaw Kardach <stanislaw.kardach@gmail.com>
> > ---
> >   RISC-V
> > -M: Stanis=C5=82aw Kardach <stanislaw.kardach@gmail.com>
> > +M: Sun Yuechi <sunyuechi@iscas.ac.cn>
> Acked-by: Sun Yuechi <sunyuechi@iscas.ac.cn>

Applied, thanks.


