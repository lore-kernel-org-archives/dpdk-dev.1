Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A5DEFB7F9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 07:49:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2598E4042E;
	Tue, 24 Feb 2026 08:49:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6D78B4027F
 for <dev@dpdk.org>; Tue, 24 Feb 2026 08:49:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771919360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XH7I1ZykqIAoMdqSfC17eIZEtfn2BqIh0kloA0tDKYc=;
 b=aMvnVVE7CxjnRBIQqzrJqqHm2FpOM6UEAn852ykRxHz3GdDd+a0JZXaUmvv2Q8cq24V8Br
 igrrktCwtjWKRhddr81/DRiP52pj20sEexElcm9wUsfRE9SBxva+YQ83gH7jubFpyPsOck
 zGmL6RbsSaOVwuQ/zwp1MV0yHpc5nrw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-ZdSELFf_NB2TrBeiLEXuNQ-1; Tue, 24 Feb 2026 02:49:17 -0500
X-MC-Unique: ZdSELFf_NB2TrBeiLEXuNQ-1
X-Mimecast-MFC-AGG-ID: ZdSELFf_NB2TrBeiLEXuNQ_1771919356
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-386fc5cdd1fso19105601fa.2
 for <dev@dpdk.org>; Mon, 23 Feb 2026 23:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771919356; x=1772524156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XH7I1ZykqIAoMdqSfC17eIZEtfn2BqIh0kloA0tDKYc=;
 b=Umny6SD2a7Do/Avrgw1XXNhavsltHljZtSAZQ5LTlyIag6PYdj+as5Kz+nm1ZnXAKp
 I6n38vwyNAo39lrCxWlgFrDhkEunckhnGq4XoiAHXIhld5vV9zkxWOM5AwX6HXdyBzlA
 xLcDNYitQA264TcXJc4Rj5+bDAfAOEeLqZ5MtYoQJucili5CSE1lAIqX2+svPrb3uyYn
 XP4605CO2HGbAuitJ9Yy9UHHkSsyACaoYhHgUm6PpYY2Wc/8Xy/wVCEt4ziYas2Ne7/i
 3OresfGPwph262b/nxebtL4wQxz8SbnvHPZuNBE78OlOEx7vki42MnGbAKU4Qz7vbami
 wKWQ==
X-Gm-Message-State: AOJu0Yzb/PzGaPY7kCm07MM8yIM3LXixSAeeZJvwDZpSVqzOVd591Bln
 hBBwtztSh0z6N13kbrvt7lLyh9G/H9FxiYj6sYVvEyuZEvsKfWrT7A7YChD65PaXvB5WCMYDNv5
 UDDxwRQ4N7q6nMWId6f6ZJK3oe3wMmBlTTvJEvMMJe8T4/8/QIdBZFWvdV7RbnabRdUFVdo1+B6
 1FcFpd4+6vNjwcUEHOTug=
X-Gm-Gg: ATEYQzyJRGZdlYn4OzkjVXo+/RMdjt+GvW+1MOYysZTjy067XbaFYLHBS5ryfG54Zis
 RUBTCWqImK+7z0Wm0WUlQAAum52GmcFJYlQCPZUD2Xry5PloMpEcsbo5q/mRH+0yFPnj6HH0Z8W
 F5MZn+DV36aTzWVXejhI2c1AbCt0JQ4rCu3PVNbZQIieRaYSx81nWqM4Teg69cp4/mfBSfTtBJD
 skeJmcxEvqULB3wyp8VOvYjzKgw23ydC+c7h86zgCJiOs2y5gm9KV4yfzEmgw5MCzagwQ==
X-Received: by 2002:a05:651c:3042:b0:385:f170:e15e with SMTP id
 38308e7fff4ca-389a5e13fa5mr28913661fa.41.1771919356357; 
 Mon, 23 Feb 2026 23:49:16 -0800 (PST)
X-Received: by 2002:a05:651c:3042:b0:385:f170:e15e with SMTP id
 38308e7fff4ca-389a5e13fa5mr28913581fa.41.1771919355948; Mon, 23 Feb 2026
 23:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20260223155603.3651641-1-david.marchand@redhat.com>
In-Reply-To: <20260223155603.3651641-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 24 Feb 2026 08:49:04 +0100
X-Gm-Features: AaiRm53L65fmS9EbYTIbQ2hvWyHFEzajWv-pBK1G_D4R1A2ioc5WTPxQy2MDAcs
Message-ID: <CAJFAV8zPxNF8u+Hca20Auh_X50T3hst=kVi4q3fFGgVy1WvGmw@mail.gmail.com>
Subject: Re: [PATCH] test/eal: remove PCI probing for vdev tests
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, 
 Marat Khalili <marat.khalili@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SeLAOdqqTqwHX4F7iijsz84wRJJcM_e4QSFvdvHkVjQ_1771919356
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 23 Feb 2026 at 16:56, David Marchand <david.marchand@redhat.com> wrote:
>
> Similarly to commit f67f76e6bbfd ("test/eal: remove PCI probing for
> recursive calls"), let's disable PCI probing in vdev tests as it
> triggers false positive failures in GHA.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

