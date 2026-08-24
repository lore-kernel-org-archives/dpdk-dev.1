Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C71BC61DB6
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 17:02:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9980340685;
	Mon, 24 Aug 2026 19:02:46 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 0BE42400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 19:02:45 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-84faf0fa17eso3775151b3a.2
 for <dev@dpdk.org>; Mon, 24 Aug 2026 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787590964;
 x=1788195764; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TgLj4Q4Z4WLB8hq4JyOEdb6r/AGUkg1mvUWE8nX1iJY=;
 b=e/EM+ns99B2p+IeNI5t0Cmm5vWM9nst2yBD/cjuw2Kkqhlw5Um+eo1xlJr1bJA0j4I
 wanFrPXMm7oAj+Ek3F+Dlg39wQXwCMsCdgbBzwqBxO0A217+v7Lbptoa9RxiAWD2hzyc
 80QhqNxbkvikbw2fwK4PAvE/KAKNwX4MQN/XvrsJ6ntb9LhmQy68MH3LHD1gDLFbu/H9
 68KyAorKoWuSKhaQaiFuQyfHSp/Qkd0wck2VNMgZQUzKZilv+vGo8hR0xonrs8+tRHqn
 SD/u1sNgEUyjXbe2IbzrGw5YO8zPZX1p4tndetTBo6z4J3jUUtAzO9nsNWTKAIjkQWhJ
 svKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787590964; x=1788195764;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TgLj4Q4Z4WLB8hq4JyOEdb6r/AGUkg1mvUWE8nX1iJY=;
 b=L3AWHlLuvGkd/+/jyRT7+eixO8CKAfS2pNo6wb+6T9BYVk4o4PlPUNvyEvfMn9lu4I
 DJaRFIqbuI7E12LBcXlC037NGSH/ePZ0C/tbroX9eVVFeBWNZPUiwM86IeMCJVOYLuFn
 r3VJOYzMeAzdVcLb2eSXTjDmoqgSnfl3YeJDrw7432lfxw/ZIivjbmVgH5EZIcqqF/a4
 KS3Ld33wNjFWqykyCB6tjO0V83OsxNFsplTibmZnUTniorfVmNKbSkopzJEsZIh6NgFF
 YOgp60DOLn5CW+U5wd/0rNyO0aMbOzoYtWBCZqRPMP9VP+E9PryDUav09JO3a6nhtwWT
 AM0Q==
X-Gm-Message-State: AFuF++m0KxM1I/1mdrT/FCRcUZpeqHlxwRo6AHU+QopR15TkwzVZMN03
 tkTdu0n9dH83LfhxEcNeIMPBCH1hrheD7uIDdSq3z/c7GfyS7ATkAQg61eQ6ijlmy/4=
X-Gm-Gg: AR+sD11UyAyYNOnjPB/hdp9a06liAXZR5AA9GoVmagYCgFEoVAeMXipC7nVzAbwriNa
 +bkaTKe7jD/OyJRqVxXwnNir+/IHmox6Mtfz8vJM9mwT97pw6NrtUjNID3ECxYsbaH/iqkCPuid
 RKcrOEiG/gnvUmoeS4yWorqRVh/MKTVkwefDdlnm+TYbhHsSIQr6hTZp/taXYryZCJyMJ954MoK
 CnPBg2Neht7cN/xRy696RSKBnOUu4mtaOOnV7IS9IpQvfqxPvhI8tvTR3yOwGotf45foh+ebgw6
 ksfW8yyxTMWFXIabMtBK2DNXNh6AjTI6X4ybShxjg0mJBw7RIxmKkAa5Q9DSNBgBqNIXvkNRopm
 Zmu2D5kKooLEJUCO2IMixeX8SERtaiCfJRtSZGoTSle+HzHB9vmwxqEKh0VhHRe0f5SYIrMMFSv
 gruYpbEucECLP2NBf2bkSoBiQ2BvxUz6P/LcIs2L2NtkoYob7nMyUQmI95YNaH2e7FcXik3uR/l
 TVtDAHObxiyeQPPS/fXHzxMB9/zbh6DUxuMraoF
X-Received: by 2002:a05:6a00:2e98:b0:84f:b01d:3693 with SMTP id
 d2e1a72fcca58-8520be923f2mr31817631b3a.15.1787590964175; 
 Mon, 24 Aug 2026 10:02:44 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520eed50d7sm2123231b3a.7.2026.08.24.10.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 10:02:43 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:02:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v4 0/2] net/sfc: fix and extend secondary process support
Message-ID: <20260824100233.706ae071@phoenix.local>
In-Reply-To: <20260824163033.31893-1-ivan.malov@arknetworks.am>
References: <20260820130314.12251-1-ivan.malov@arknetworks.am>
 <20260824163033.31893-1-ivan.malov@arknetworks.am>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 24 Aug 2026 20:30:31 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> The series addresses two secondary process deficiencies.
> 
> Patch 1 adds a missing shared adapter pointer assignment to
> the secondary process init path, preventing a NULL pointer
> dereference at device close time.
> 
> Patch 2 pre-populates a primary-process device info cache
> to satisfy the 'dev_infos_get' requirement now imposed by
> the 'test-pmd' application on secondary processes.

Applied to next-net
