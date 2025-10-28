Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D2CCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 13:37:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33F554028D;
	Tue, 28 Oct 2025 14:37:14 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 7005D4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 14:37:12 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-290b48e09a7so72539175ad.0
 for <dev@dpdk.org>; Tue, 28 Oct 2025 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761658631;
 x=1762263431; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lw49NLOIz6qNq0JKMv+n1+V1EWV4EhESMwkCZN8tD3E=;
 b=pTIRCcUICx94JgPLjw9wO4DK+tBJBgvz7rZPUf8Ri2UFRZ8BVKf4qmTKG0/qZy+5/5
 b4hObKhiFIeC1OTBZbLA19nj4zptHipZB5ENeHp4PGQ5RdSojGMw2angApHUFxgth1+c
 V5rtD4mNM0hIaSLLyHMRF2GEEG9ZRvXarwyRu/HiOwECCS3JNr5XHNyEhhDgKZTqGi9C
 5DoYBpA52PjmJCOow/FUFzodbw4VbEVqKT8wYxochfPYJ2ZqQ9mXGyDGKLp8J8YQ0b0f
 fVek8PkN82JT813ZP9baCbnzyCTVncxEKAC/+WKPczxMSip0u5XsbhYrlo6OfIgjzpXS
 sc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761658631; x=1762263431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lw49NLOIz6qNq0JKMv+n1+V1EWV4EhESMwkCZN8tD3E=;
 b=h0o0+Q2KPe5jpJX6ldiClP7QXza7/QSf83lBNpZzOSw1663OqzrfALqju9zgvPO9ph
 7/xFsLembHvRP4EDPcpQJWrt21KNjb5d5RkRMLCcFZMcnIIDyBHyohogEbAHNvGHHauF
 Jqs3DBsc3yFIJfUJjoGk55bavhYvRW2fxftqn7IYkM5Bs2yO2zzkCSbv2EP4qus2pOaD
 r+p0dgPGDt3Ly6o/u5cVm5Jzn9W7lydA+pC5dKnojj6Pger9JumXH6ApUeWP2VuFIzjA
 yeqBcdyqp51ONMOGKNHWzrQwUOEDgQqN0KagHgaFuMra2PHsGK4Uy3TB322vhE8cgBQs
 s3iA==
X-Gm-Message-State: AOJu0YzLn/EiwjZGF4YlQ4ha9FaiY3sZrJ+GtCWB4DZ3LVwh8ExyYk/g
 c91sL/thXo3TRRvUu6i+D+GJnRB3TTQWAWuov9DtYRcDE2AkYbOVZzQsXW+J/AOMkJM=
X-Gm-Gg: ASbGncuvQkW5En32cS7nldrgQS9gyknl+gqzYu7A+bwE+dRZtYWCAvvJQf/CgU4GT+4
 eXPHneDMCdHwTKdCJqn2z2m3+6tnofihH4Fkck5AoBooqWj/8d6nSk2zzJC+GptFwHL7Bx7+h0w
 lYTxKR+8mslyRBO2zyc3NEAMk8qRz7abRRjEJFuJCzhq0S5Utrelmx6H9Fk9yny0nt9N7Wo/Nwz
 EwO4YTdXWtPB6pdMLuDpAi4QLwNtZH4WueadCRQJeCo3WMGmPhKlUmLXXmkNmfWXDsuQ0kgAJB3
 cXzIw90S6UkCj519snM5O1OQsiygWiCnQDPU/k8pFw0LBnUf/8p6NPE3jAROMe1hFtMA/g1slkm
 d0csmrSGKxxd3t1BuY1zNmuV3SOXIhF5C2aq3tS3o6SJ39I9bjdeRdiUNymvt01H7gGtIHCVgC+
 wKfGJ+HTRx8O2Jvk0gSNS5/31cTbdOXKOFlDYPOTyS89p6
X-Google-Smtp-Source: AGHT+IGobk7XHhI1QU5+wKhm7R2PT734b4x6uJeoYYS++8nKxqHSqglLDJWYejqg4HRhOXKXxcI9MQ==
X-Received: by 2002:a17:902:d50c:b0:294:9699:74f6 with SMTP id
 d9443c01a7336-294cb51ae0amr53254455ad.43.1761658631244; 
 Tue, 28 Oct 2025 06:37:11 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d4287bsm120452155ad.80.2025.10.28.06.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 06:37:11 -0700 (PDT)
Date: Tue, 28 Oct 2025 06:37:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Howard Wang <howard_wang@realsil.com.cn>
Cc: <dev@dpdk.org>, <pro_nic_dpdk@realtek.com>
Subject: Re: [PATCH v1 3/3] net/r8169: fix issues reported by Coverity
Message-ID: <20251028063709.2bc69e84@phoenix>
In-Reply-To: <20251028084716.369128-4-howard_wang@realsil.com.cn>
References: <20251028084716.369128-1-howard_wang@realsil.com.cn>
 <20251028084716.369128-4-howard_wang@realsil.com.cn>
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

On Tue, 28 Oct 2025 16:47:16 +0800
Howard Wang <howard_wang@realsil.com.cn> wrote:

> Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
> ---

Please add references to the Coverity ID's so that the bugs will
get closed there.
