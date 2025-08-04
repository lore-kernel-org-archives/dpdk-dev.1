Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037B5C87FCB
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 15:44:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C526840691;
	Mon,  4 Aug 2025 17:44:25 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id E300F4025D
 for <dev@dpdk.org>; Mon,  4 Aug 2025 17:44:24 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-459ddf83023so5434235e9.0
 for <dev@dpdk.org>; Mon, 04 Aug 2025 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754322264;
 x=1754927064; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qNECXithEUKeTm+UzMFUK4CDtQQixbTxNPzZ/VvrjzI=;
 b=pGcOwDr7zr9nRpJxlotoAbEdXATPSRSdgweQdAGLzTyUi2dDJJ6W1yXzGDYb23MyPe
 /rT64QKglXIWwkQCtJXWUXVKEpzUeXtCsUY0pEgoPcsLh26l7At5vMNp+3pDynFFezJN
 6wT88y0hajHMJLHyn+GRxmYHMzUgjXMikHxuopsVLMoUuYNY2Jn1Ds/tZssO8n7JCUHe
 KbnEJEA0n0tM6aOJ0ODFJZFrbr181ak1bGk4gkLa19tLslXsoUwxSYFjnm6uSAyhjITE
 VaGcA8ty5p/NIQG3a5DND2hHIfHsbQwF4H/hE3EuHhblMai7PL88/FrNvxVKBlCIgXvL
 0zPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754322264; x=1754927064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qNECXithEUKeTm+UzMFUK4CDtQQixbTxNPzZ/VvrjzI=;
 b=eiXOSZaXoXmNFXL6OV/vuIpKKskh5OJWHGv5iO4amkV3HICUPvrddnoJupX5mtj/vf
 3RiozMrgX2+SItLD3qqJohiQvNFJNLqavR56R3SpuYlmroXhZeqQ7kSUNFCbHO3ozHkd
 GtdV60eT8AeHY2Eo8feI4hm58UfKDyMFww1skMmAUry2erFQ/5ozT1wugvKYh+tHQHVn
 tLnTIOInrFjqsS6XedmEYVo2OXIH/hIVI3QXBmNOCLAFslLuWrXwSykK/AEomAJW15Pv
 TanLPrpRK1okXlYFrQl5C9pQjSDs316Hk+K8yOOnrtK1X1/GH2uV0dyTuWkMEWfOL5q7
 oWAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWlBautjqAHiPHfMjnFvAtNkP19aH7nh9uFwA4frTT3J9A+DMwFVgTA9NX5UCA+NzWMa8=@dpdk.org
X-Gm-Message-State: AOJu0YwZ0yq3iQXgbJv3NsOJzmA5ZRhFkLWmZoK7u0AYF5TTzqiQ7i5c
 1UkPA0cvxQ70ZRlUCHrdYg5Xfac+vktk5rAcn/3xLQ4ozm1kqJfOmwtf29a28wliM2s=
X-Gm-Gg: ASbGnctCIzmpdVrxEsnJ9/UQEGHt7IJkuwl2uMeBHSlXgJ/TzjpmEY63kwreh/FOOtA
 4E4v9D+u2P3XS+njJqjHcayGAGan0+bZhkifVFgk3xlP2SvyO0qmtDDcWpWtiBoeyqWV8FmJ17i
 ngL1cgstVj04iXeKcjTvBbsOk0QBdZ2QjJ5MfXWNT1iph1vGtTNangGkP3Vvm5NRO+fjlqPfDIy
 ZUxWkEHSVJr5KLG/guqowurq036Fh4LaDb2kFGAnblkM4s5aeQ1HSRndN6JnuK7FsZv1A8wA7vn
 0l4XUTNqb3/pSreOXcjhvnBnB+KW4E87MDUoHyKeB/2COBJaHn0djen/bVIbt0iVAfuS9aO8jKI
 dxd6m9JF1wY35PaPhbb7GWgduoJNzwbYA33QwLgbH4ItfEyf8F+SXQTIrvp270XKlBhhE8hIDJ/
 k=
X-Google-Smtp-Source: AGHT+IES9tOMhODrlzP0zrNqCamDBuqyrUD5twVgUb59lzi2Yg/zhxtCkucnYznZ2erABiopxkQHEQ==
X-Received: by 2002:a05:600c:3b23:b0:455:f6cd:8703 with SMTP id
 5b1f17b1804b1-458b6b5bee8mr102096935e9.31.1754322264290; 
 Mon, 04 Aug 2025 08:44:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459ded356b9sm21971215e9.12.2025.08.04.08.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:44:24 -0700 (PDT)
Date: Mon, 4 Aug 2025 08:44:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v7] app/testpmd: monitor state of primary process when
 using  secondary
Message-ID: <20250804084419.0ad9c527@hermes.local>
In-Reply-To: <20250804113322.53650-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250729063919.3554143-3-14pwcse1224@uetpeshawar.edu.pk>
 <20250804113322.53650-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Mon,  4 Aug 2025 07:33:22 -0400
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> In secondary processes, accessing device after primary has exited
> will cause crash.
> 
> This patch adds a mechanism in testpmd to monitor the primary process
> from the secondary process.
> When primary process exits it forces secondary to exit avoiding
> issues from cleanup logic.
> 
> Fixes: a550baf24af9 ('app/testpmd: support multi-process')
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Queued to next-net for 25.11.

Wonder if Windows plans to implement primary-secondary.
