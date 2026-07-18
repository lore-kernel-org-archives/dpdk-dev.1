Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB9DC4451B
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Jul 2026 20:23:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AABA14027A;
	Sat, 18 Jul 2026 22:23:04 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id A6C7040276
 for <dev@dpdk.org>; Sat, 18 Jul 2026 22:23:03 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 237941400042;
 Sat, 18 Jul 2026 16:23:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sat, 18 Jul 2026 16:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784406183;
 x=1784492583; bh=iMJJxBLp54EvWVCvGXfx7GtjeM9c24PHhIFjK18XQio=; b=
 dgPphehP6hv7Kvzpw5gNin/sp4Y3OIfHP/nrqazLrfu3u1Uex0QnTxeUyaKn8uTM
 eopO7DNLDKH9rTBFeK2kyWcRhplS1J/VdIwtQLHomW6cDemXY+Qdwjw0S0MI8SwP
 oRfhv8yDEc2tho15owEAHUKr/XvXPk/M2DcIPRqO8pFu3l5pjP/ettjbhiXWz++f
 sEA3wvnu5fa7n7BO/7a9t+XDueREkMQpj/F3wmFO28S9jHPA4kDvOIzFr8w/DYIY
 BqLHM0bvZaFdA3hTEPFDqclfL+dxR17eOIQrdDNbq50IH0WBRiTXayJrzFWX8cgJ
 SRZGpSoRVVkcX0Lf5gtH5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784406183; x=
 1784492583; bh=iMJJxBLp54EvWVCvGXfx7GtjeM9c24PHhIFjK18XQio=; b=c
 oVQ+mav4drBDZfPzBCz1JlC01wF3WVDfngYOLyQQgpLM5KYdpZolYZaE6IXPjY8w
 xVzBZ4kX/jXGSQLLzah0/FPpA/lFDF8Zx8b6Ab4YkUCKAAhWCuVmwbti8EhWhQkB
 sePmSfNAnO4eaeCqILx2B6dOfVuSsQ7lJ7XUYcFSm5h9b9MXxRPfARtD8Yx6wKWz
 FLPJbjXfq1vUUPyySupo1floZncROr/Q6cBeQ8fo3ej5OfA4hy6syT6KLt1rz8fE
 Zf9LwwaynDosxfHudYs0mD23Hht0QPG5/E475+4LnIhMiESoXSk2AW0g55i8Hp0V
 SK1caXChMiJ9e8bdAKE6g==
X-ME-Sender: <xms:puBbahy4E22aGkLMUIEmdvW9iIaCM-58uKnX1gdeL-WHOt8wa-taSQ>
 <xme:puBbatl4Sexk8Lx9hnqmsNXCH3PhwrYiOR0DgrbVg51Qo23mFVOGBOEHypUYcfrwK
 A3YGmqsYvHkvSXlxrGjs9aNctVTx4-A8cC_lgNc-SQ6emCjaYFp17I>
X-ME-Received: <xmr:puBbauFz5kK4DT9YvPUEzNQekxCTjOUTPeZOXg6wRfa2XEUXvANe-d3osdsgfHeiW7eRhi7yiOu2ioDDKg>
X-ME-Proxy-Cause: dmFkZTGZWZ4yMnZGEseyatMc5CHe3oEBU3B+jsTp+GFx535sgs1VPVY2PQW8g+ydm9XVke
 QIwWN6Y3vkn31PyWyVVqalh1iuy7/kuYkBL+hH3Zq1Re22ckOlMOuiWbWYq6+7/MXRJIvp
 Ta9t/fByVM+rWXwMwBeJ8A1siOARQj7K2D3ywxu2WMFM9MZMxcfwmBXSnsY3idQ0op/pP+
 wr+DTV627IfS0dfkPoc0nF5p4l7LzUd6OxuBL3sGoynnorLmTAJeh9LxOXZHmztbNKqM79
 l+Fsw3olOcSCApSW/vLAcdPlQa7QT+a21OeaTeXhwvmLhNJVUUQiY+tMTARCQX+RR8/vQR
 OhRMfmWWJ0hzZFltzpRUXhewYf3X2ctwZHZgx1k8ypa9S3Kx050NTydYbwpDgnr9UrC8gP
 NqeCua3nNT6p9PBSS71jMk9tTC/DTMALTuwJpvIgOmzHWNWj0cD0HTJdu3D/auWSlp4OnM
 sJw+eOVAIaVz6M9F+21pAUgOo3nFNz3aojFNpG8XkmPgLTi9ZqB6Wjq5n5jCS6bcssKJ6I
 2HJ+A5iWGci6xN+TUXUgnD6cYXoMCojS5xA0robzzJJlD9JwVNSjlTmYhu2BTCh80xLb4o
 rHDcqDYm1mh/Jc//PLPr1UKW698l9Xqs6X+2+W7a6HT8vEGJbDlx5RJMJTWA
X-ME-Proxy: <xmx:puBbalUcO1IR_1FKkMBTbltfhr1E6OXGY-MkPIYvwgNHizK9GCIZ-g>
 <xmx:puBbalxkRCddMweMbLpLWGwmDVpXmacqz1XDKVJWZNCsZiXpBiFPUA>
 <xmx:puBbajOs85706i7e1kmmbyckRgWVwPO8qb3eGn9hX1Ybw0AEPAySgg>
 <xmx:puBbam6hQH2ctUz4GGBeSgASNGIc11rwWfTfL7wXGXqfeBKEATTwwQ>
 <xmx:p-Bbatl8HJoAUIhVPrV00G65tCG2K1XgnpbFSeQd7SxJHduLHlyPcf2G>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jul 2026 16:23:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andrea Panattoni <apanatto@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: using container to build and run applications
Date: Sat, 18 Jul 2026 22:22:59 +0200
Message-ID: <57UMukEFRrWeWVgLle71uw@monjalon.net>
In-Reply-To: <20260603140421.3023794-1-apanatto@redhat.com>
References: <20260603140421.3023794-1-apanatto@redhat.com>
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

03/06/2026 16:04, Andrea Panattoni:
> Add explanation about how container runtimes like podman
> or docker can be used to build and run DPDK application.
> 
> Signed-off-by: Andrea Panattoni <apanatto@redhat.com>
[...]
> +.. _building_dpdk_in_container:

Adding a prefix linux_gsg_ to this label.

> +
> +Building Applications in a Container
> +------------------------------------

Actually it should be "Building DPDK in a Container"


> +Running Sample Application in a Container
> +-----------------------------------------

It should be "Running an Application in a Container" as testpmd is not a sample app.

Applied with adjustments, thanks.


