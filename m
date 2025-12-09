Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30D7D1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 09:12:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFA7C40270;
	Tue,  9 Dec 2025 10:12:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A740F4025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 10:12:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765271567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLSJ1hKzwEG3icLTQTOmnsqj3u4yKS7gcNNvnQhP/oE=;
 b=atYY5ZjPRxR0qMKnb+r+3uzBypa4sEVxpACk00ZW3P70SfzBmh8T9xFwmD0akpUfDkZ43g
 HMZrX56Q3HnoDDWxUBfV1yDj0H8Z//jAdfo63krD2UJ2M3VSZr3z6zLgYk2OnQCsbaZgkr
 vDxmFQ2ieMwYbL7RwtlZAgvGiHvBv3w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-bDY-vZNVM-m59vZnMpKe3A-1; Tue, 09 Dec 2025 04:12:46 -0500
X-MC-Unique: bDY-vZNVM-m59vZnMpKe3A-1
X-Mimecast-MFC-AGG-ID: bDY-vZNVM-m59vZnMpKe3A_1765271565
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477a11d9e67so29714715e9.2
 for <dev@dpdk.org>; Tue, 09 Dec 2025 01:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765271565; x=1765876365;
 h=in-reply-to:references:user-agent:from:cc:subject:to:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OLSJ1hKzwEG3icLTQTOmnsqj3u4yKS7gcNNvnQhP/oE=;
 b=R7BLZuUkOnP0obmpR/uZ4CI7xLiP1rM90umfFd94aWIBBFkuOPJCZjpaUcB3oLd8lv
 O2IWHhVpHaf13Q6hbbrsqG1mG4UxdxbWDO8LB/zbdrKul9a6cUDgXsbBYqy/vy3eYZFp
 6Wn/UCgR1khkcG95sU+/mXzUMrzgb5O8lk8Ms5XnrtNzbz8zQ4zVzEduHHPwk+hA++Ap
 fJoDinpxFHTbMFxiwnV3WNXoHn7tYBYVckBV06extAsANhoQoEWI6rSiukPcwjP8MPnM
 GoYGwwtDAylFmncKoFEiMFi3FANexXixFvLExqtT7y84bYoqFvWN/ynOZ1r25Q5PiCZD
 FreQ==
X-Gm-Message-State: AOJu0YwrKHAs9cRTqsu0kYeW8CnkXQAF10lHw59y/YZytsDgS+q68mup
 GujuusopJ1t+GYOykKj+/Puf/aH/XjeiJuiPNrFI+G73RuIdCN0oiupA8MUBUhWKf3gPrpe7kDE
 yfF/Dq5YmPobqIYd86GhbHs03EFJnfmUl1F+REG9ZkhZg
X-Gm-Gg: ASbGncvY1/trC3Z1j+epclWH9WegDbF5SLtY0L1a0uN206u/Cch/H5t0nhAzIi/l6ZI
 fexah/yH0uKzuZ2CTQ3NAm+3l2VCWX7WbC0QNZTmoi/JG/s6K+Q9vPLED+OGkPBQo0OPkaltjAO
 KyhgNKFRZbSiCsIOyyDJgXj2I3EUGWX29LcIrlkU3uEkqQ0KY5r6EwdfiDEIbcFrKMdiKP/56c8
 9QakJpuI1CXE1Cm5MFj3aax1LaQLkS5T0Qwziyx/klK7dKkEyx+MNVNtFioYDzOIzirvxcc35kH
 JbBkaBKgPEBGFsGyt1+tYsNvm6ckJAuvNBlAHzQX63C7YEK17zXHgwoQ2Cd/5djgfQO+asxH/rC
 4bCw8Y6xQSUXtSd68Anfwmbtzp7QKEf1jgphCHJtB94zh40Dq+l4SOeh+GPz/vwk0nsA=
X-Received: by 2002:a05:600c:4fd6:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-47939e1e42fmr82710465e9.20.1765271564694; 
 Tue, 09 Dec 2025 01:12:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgMsnCfTKNbOARQyjqpLtyzota4phQC6U9n0GaJ0ztlFCk8/UvSGqS8K2tyYvSoqiQ0o8/Pw==
X-Received: by 2002:a05:600c:4fd6:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-47939e1e42fmr82710245e9.20.1765271564327; 
 Tue, 09 Dec 2025 01:12:44 -0800 (PST)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d696a4csm28728015e9.14.2025.12.09.01.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 01:12:43 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 09 Dec 2025 10:12:43 +0100
Message-Id: <DETKJKSUL9XG.1CTKW09I3UWSB@redhat.com>
To: "Jerin Jacob" <jerinjacobk@gmail.com>
Subject: Re: [PATCH dpdk 1/2] graph: always count objects and calls
Cc: <dev@dpdk.org>, "Jerin Jacob" <jerinj@marvell.com>, "Kiran Kumar K"
 <kirankumark@marvell.com>, "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Zhirun Yan" <yanzhirun_163@163.com>
From: "Robin Jarry" <rjarry@redhat.com>
User-Agent: aerc/0.21.0-39-ga8d4735cf219-dirty
References: <20251209085028.115203-4-rjarry@redhat.com>
 <20251209085028.115203-5-rjarry@redhat.com>
 <CALBAE1OMwTX=a5i56G_sPXicw=17ozvb4PBfak0ev2Ps3xwuGw@mail.gmail.com>
In-Reply-To: <CALBAE1OMwTX=a5i56G_sPXicw=17ozvb4PBfak0ev2Ps3xwuGw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q-GjuFWzvmWhR5T5tvRxJFY2vBwyc7tOKYTF4E58udU_1765271565
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Jerin Jacob, Dec 09, 2025 at 10:09:
> By default, RTE_LIBRTE_GRAPH_STATS is enabled in distro build. So why
> need such changes?

This makes sense with the next patch in fact.

The user (e.g. grout) may need to collect the number of processed
objects in order to make runtime decisions. But the cost of rdtsc() may
be too high and it may be a good thing to disable it unless trying to
benchmark/debug specific issues.

--=20
Robin

> Offer limited to residents of the contiguous United States.

