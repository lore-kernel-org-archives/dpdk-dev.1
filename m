Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CD7D29C40
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 16:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A41E40299;
	Mon, 19 Jan 2026 17:37:09 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id 15A8940297
 for <dev@dpdk.org>; Mon, 19 Jan 2026 17:37:07 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b876c0d5318so610085466b.0
 for <dev@dpdk.org>; Mon, 19 Jan 2026 08:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768840626;
 x=1769445426; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1CfTRqNwxoVN6JVP/N5Ys49XBtIsVldMVtj2oYC+hY=;
 b=svVCigym0UFj90L0mFxlZn2wnAZyb3vIaw1D43shubh3Gv48hvWXO7Nm9BbJBi2xqG
 RvLru+GJDa3d8k1mBNgQHxMDIspiiBBAHXjF0FuTWgFRpOH+7RVQ5XQjgHrvEWLAc1le
 8NSDYX/MVJYJtu8mFvwAowOlXTqWXPQkdigWOwjqfOytYASuxIt5amRBxpHrVPaBCoR+
 VbXFQdQBJuwts9nCmd7bh7iDk6TDrNDdEOVlgJLzMubj08IRoPyHTIle5+ZNl5cP7CgE
 woC1lUw0c41y3rCj6qR235lRWEqExImT2+lsQ03s4ped4pquOw0Z0w39Cpu0c/Y6iItW
 WHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768840626; x=1769445426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F1CfTRqNwxoVN6JVP/N5Ys49XBtIsVldMVtj2oYC+hY=;
 b=gr7fJzzMNO/8qz1cB8GMOthLsblVJ0U2ZbFWDILRLvgVFJlpHZM+KI/Ar7JZsYdQs1
 tOdcxM3b9ZYiv1bfMlE11IxEiLZCUas736V/uoHm4ujnCso022XbpA6w/F+L+aZfOLwR
 6sMQIr/2iYHZl/kd2k+XwqOq8euQmQnM76tYOGPOPr9K776JZEjJl85QWLR00Putg7PC
 clV0LF8iA5lzPyHlMsUwSflbiuhdludJStIgTEp6Vn0Eg+59IcJImydNW61KHzfo6ioJ
 DDKXjD13xCQlyz8GSgovZLEUXph1XUAzcDm6ZRD162YFe00FH7eWCaeEV0bVdzzibZ+U
 hv3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCViFL+mQKytDXz8BVGgGFrbniywTqF/MEo38+TGBpRbr3WG15mo3oeGUY/VazMWL1HomQ4=@dpdk.org
X-Gm-Message-State: AOJu0Yw9DR4+czH5BFXU9dC3jDjafwPD5eRI3JLzeQwZR0EC7XA3JuMb
 6e3sGyU8MOwAdLtahAYKSClH9pzOKM7WX4WgDrXr6NvsaWweDERKJLufQFoRJl3RDEk=
X-Gm-Gg: AY/fxX5efOOYqTg/nd4+av9BroGQAaD/8NXVsXVeD0uxbgWPOtAWAf4y+LdYALG83Si
 HwaDGcmLBixsp3OwqSDXKPNBDSd3kTuij9jN0sTRncFe8/lDV4sBzEI6m86vxaBrRxywhkYlx7z
 qdsrmuj9l3LyNL+nEJ1bXyhje/EEqnSY6UMbd9CFd3rxqry/fImpc3jjV9MfjohiqVY3L30xBU8
 i21qxCr0rLak82EY8c12hK0FbEZQr02SFOMWOHe54+N7BYT3dHCHT7AyuDX317m82xE/tM1FL06
 /kDbIDZ/efv1YvWmI2fJq2fRNUG/z8iujLYhjesv4mfvx3IX8sqmzMy0uuJ1967qMC/2de4M84C
 CRw5PEYE2GS11+uFrd/DwZMEX6AZgLPpvMLbAi2IfWsP/zRl4UZ6jL8lCbgVhuiQgio4OmcPIo0
 m4LNdyYwAz+8Kwi0+lsRDJalX17mcf3UNNIRxBWQHV3GK4fGyukGQb
X-Received: by 2002:a17:907:3e10:b0:b87:d09c:1825 with SMTP id
 a640c23a62f3a-b87d09c1ab0mr383533666b.13.1768840626390; 
 Mon, 19 Jan 2026 08:37:06 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fb980sm1203778066b.49.2026.01.19.08.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 08:37:06 -0800 (PST)
Date: Mon, 19 Jan 2026 08:37:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Etelson, Gregory" <getelson@nvidia.com>
Cc: fengchengwen <fengchengwen@huawei.com>, andrew.rybchenko@oktetlabs.ru,
 dev@dpdk.org, mkashani@nvidia.com, thomas@monjalon.net,
 viacheslavo@nvidia.com, matan@nvidia.com
Subject: Re: [RFC PATCH v3] ethdev: support selective Rx data
Message-ID: <20260119083700.541fabfc@phoenix.local>
In-Reply-To: <03a55b2d-2957-c8ab-3c3e-dc9d207fc273@nvidia.com>
References: <20260104131301.196350-1-getelson@nvidia.com>
 <20260106154554.40556-1-getelson@nvidia.com>
 <12514141-a489-4995-a8a7-e6d0fc28f841@huawei.com>
 <03a55b2d-2957-c8ab-3c3e-dc9d207fc273@nvidia.com>
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

On Mon, 19 Jan 2026 13:23:02 +0200 (IST)
"Etelson, Gregory" <getelson@nvidia.com> wrote:

> Hello,
> 
> >> In some cases application does not need to receive entire packet
> >> from port hardware.  
> >
> > Which scenarios need to be used?  
> 
> A typical use case for the selective Rx data read can be the SAMPLE flow action.
> In that scenario, Rx queue that receives sampled packet copy can be configured 
> to deliver to application partial packet data.
> 
> > What is the behavior when
> > LRO(TCP packet aggregation is performed by hardware) is enabled?
> >  
> 
> The selective Rx data read is applied to MBUF layout that will be delivered to 
> an application.
> That functionality comes after all HW Rx offloads.


What is the intended behavior in the selective case. Is there any mechanism for
application to see original length?
