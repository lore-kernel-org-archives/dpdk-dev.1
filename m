Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBD9C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 11:55:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14AF5410DC;
	Thu, 10 Sep 2026 13:55:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 558344028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 13:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789041301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ieo02MMHwy9dYCbUL5d35y47y2L3hbdJu/86HEu1lMw=;
 b=CTLVby3Oy9hYoOLfUBs3KtGas4mg8exwscufPm1TC9bvOUv0EP2yzcdPSBL9rm4ewnV5Cj
 EwnhNgLovp5g2HjmstAx045R55X2YLnzE70cJNEAZEOdVaUaJ6+z+/JaeAbjqgOpykE4ju
 RToF6GYY5Vzar1pUQ+h4Nkkx/aUYmto=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-Ft5c-98vNFChXrpYYdak0w-1; Thu, 10 Sep 2026 07:55:00 -0400
X-MC-Unique: Ft5c-98vNFChXrpYYdak0w-1
X-Mimecast-MFC-AGG-ID: Ft5c-98vNFChXrpYYdak0w_1789041299
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-86a43fc3527so570246b3a.1
 for <dev@dpdk.org>; Thu, 10 Sep 2026 04:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789041299; x=1789646099;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ieo02MMHwy9dYCbUL5d35y47y2L3hbdJu/86HEu1lMw=;
 b=kRs4ipJDSuTVXhr3sN/+qvhJXnUehQjSoW6vLWnRgkeeLk0luJOwjRuQ08sQC+d9oh
 rlUEomzd+cCh5IuR2v26dHEp/I/gjEKwR/agzWUpORtUIGG0NcHsM7J1DIKEjy9otxqW
 A3g9KRw4fkpCbUD4SM61xLycSREuQfRLTX3H1yI65IyW27AcSMjtDAHAUDe5racZ3oWa
 Dnxv/7pKYWihZ9b7CnkNugfWIoPQw2tl2HYX4qf6ffY17XFojflP4c5vkq9+pa9XL6TJ
 GgsVzNNxmXf/ZiNbQqJK49iUk4yGO1dniuSHW2CpTq9F3ppFUADVdZ3ZGnenG/yUEga8
 YAhQ==
X-Gm-Message-State: AFuF++mZwyvidY09zv9jIC6zb7FrjG1s9FN+5K/ecrZ0Ax9hdHFBlzO9
 XSTHrDNMshORLCmo+T34qk6T3yG+t17FBkDFWVQ53/9s+sd7EP82+KcdjK//vnXcVDkDOjMRDhF
 mMr0L7kkz/JfpGH1M6M9zenHPgksLicwzXWQJur45i9FgLqAuesQkak6xnmRy3iQZHYDdcMpcwC
 2ndCASHSQ/PeUeYdPeaHE=
X-Gm-Gg: AYBFou2OmcjBs1I6hfwzdTkVMInO4But4RdKz3f647wV+HvKZY7TL33QCXgwpxgfKSX
 A6qgXXTPe1ey/2a6nnC28lO2bV0JPDXuaPc7L8+7M5r5qZqFPOsF+GeXAJuxxxr2poxFWu/pnMv
 7w5A0KH7n8iww5ODW82uV1ZnhGki5Rd+Qoq8xMvJoldyRwwZMCCryXZ8gpe+p6ftckOvfddzxG5
 Y+GtmepdvD/nQZAVZxJNbD4/AC95m7guA+VI7nzXZZ0NCCa
X-Received: by 2002:a05:6300:228c:b0:3bf:9bd9:cf60 with SMTP id
 adf61e73a8af0-3dad26bf607mr5051187637.6.1789041299368; 
 Thu, 10 Sep 2026 04:54:59 -0700 (PDT)
X-Received: by 2002:a05:6300:228c:b0:3bf:9bd9:cf60 with SMTP id
 adf61e73a8af0-3dad26bf607mr5051145637.6.1789041298952; Thu, 10 Sep 2026
 04:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <GV1PR04MB10750F000EEB3E024D8BB456C89C02@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <CAJFAV8x3r8diykpB1wAGO06C6Q=nyz46PpxYVF4DOrqD82ysEQ@mail.gmail.com>
 <GV1PR04MB10750F6665175D7DBA92489B289B12@GV1PR04MB10750.eurprd04.prod.outlook.com>
In-Reply-To: <GV1PR04MB10750F6665175D7DBA92489B289B12@GV1PR04MB10750.eurprd04.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 10 Sep 2026 13:54:45 +0200
X-Gm-Features: AcwNN1WlZERuXXpQXm39-VWQ6BNRZcpvaRpYtucSfzNw-0GyZ0fb_6AGz-id0Lk
Message-ID: <CAJFAV8woJfNqprvR5KqDVRFgxfT4VSz4ATW-kA7-SvD9gNCkMA@mail.gmail.com>
Subject: Re: [RFC 00/11] Device unplug and bus cleanup refactoring for NXP
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D4hRjOVWpqRYm5bMwESPuA26tK9PTd8EabpXrdWZ0x0_1789041299
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

Hello Hemant,

On Tue, 8 Sept 2026 at 16:20, Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
> On Thu, 23 Jul 2026 at 16:11, Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
> > >
> > > HI David,
> > >         Thanks for the work. We will test it soon.
> >
> > Any update?
>
> We just completed sanity and a few quick tests. This patch set is not causing any regression.

Thanks a lot for testing.
Stephen comments have spotted a number of issues, I'll post a v2 soon.


-- 
David Marchand

