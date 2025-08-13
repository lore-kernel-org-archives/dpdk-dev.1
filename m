Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150F2C87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 15:23:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F99140ED4;
	Wed, 13 Aug 2025 17:23:49 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 7083A40657
 for <dev@dpdk.org>; Wed, 13 Aug 2025 17:23:47 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3b7961cf660so5501110f8f.1
 for <dev@dpdk.org>; Wed, 13 Aug 2025 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755098627;
 x=1755703427; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8MhnNnrk6wQm4gltm/KsIcWKEnjb1aT9oAjaK2Bf1MI=;
 b=fwkY7kQXiknZoOg0rBWEFBFOZQbAOP+ZfM0iV1vVfREclyN9WDvRz++te2ixthLy0H
 1u4uIOv/ZVOwkislc6auBnjC9WRx8YA/YhDfkmFRCFjcuRa5yin/fOa7bhQxupQhGEls
 YOJkP0CVnAwZC+tc966YCzN06bIt8ADQVcjkcLJALgbdv8EWUX5WZKOxNrJCKmssTHqi
 2WXheU+kv17sGLVjjz59iNOGg2DMMdeo646I/2O2I5aQhuNg4bgpdPiu8+oex8iv1QXd
 cW4QG27N8+fakFxEH1ITTRb1+osONTo0M8KzFYPFZUqHxORvWkeCTueKLNk9ZHkG5z/x
 UdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755098627; x=1755703427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8MhnNnrk6wQm4gltm/KsIcWKEnjb1aT9oAjaK2Bf1MI=;
 b=QYPYCFLhdPefWhl2EUAtkG9+DtfvdWAt2zNvrSrUABShQBeKz/00FlLhKxVZQSBocA
 YhNYOa0GpryMpYvVeJm6NRrqUxb3zfJJwcBEh1C//Cvvly7OOVqwWKlogF0ufaWAW8wT
 okjlKrlXiR/iMc1paTgyPKuML9Chptwxvh0D9sPxrq3abFb8L4stw3pFzYGLnKYLRRZd
 e2xUNIR+iQsop8qPERba4jFl7T0aukwlExlrQ0isGB1K2oAuRgUbYNQfOPjWr69qduLS
 Q6qSXoo0GC9G6+WqhdB++hSotLoqeNHqp8L1LD0NHRJQQgTUshlfR8RcQpEIf36LQWps
 rBWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPR4Mb4lVXQ8ukJfR6QUhPAPzbWOQzujQ/uAXZHpmtQToYB9HfMzmuPxGOckhCTJsvn0U=@dpdk.org
X-Gm-Message-State: AOJu0Yx0tbQcVQqjNv5snrEh4ZHbOr8EjlnzptiR/oyne9auugw4p8rC
 vo3esotOvOWDwKusrmrWJf0lY9dOSUri+5DwOWgVwdSavwIuPvqte/Pse79gCQYdqqI=
X-Gm-Gg: ASbGnctOMIpiYBwowIG9cRZrKcHqd1M1Z+8fcU1EYP/Knqh3nrQvD8xhRqt1VsmzBtC
 8KPRTPgKxhlhg+bqTEUfMSjrSzpfBUOce/sttDOgzDGDqH6X8Mq1uvd+4sx5ibpP+r2FBcldeYP
 +0A82NrJ+1im1X6dGJDQoYs9WWcrKFX0Vf5F12TrS/5zwm5y2Aw7kQI/GuGeJAw++7xgKU2l67K
 2j6Ma00hn6esCswBQV2hGcEQFo33/PYOaovR8hXslWu5HbSSiGy80U2Qv4BR+P5GYRrL5fZV+dw
 NU0s/w8PW2ErdF3i6+gHEe4qALeXNs09xNaIGH8Da9Lm8PwX12zaps+zkW/b/lYMT8r0uz/1nP9
 pBwzbb/m6/u+6oOsk5e12U4pCHP2oPM1EKjF/y9SZPi+VlDPkoITrTUs94dxmcUO1JVoAIrIwO2
 I=
X-Google-Smtp-Source: AGHT+IFJlMD3F69RXHiAl8p5t4h+VhmQEBYVDjqCzMv6/aaDsu6dQ6YbZUuvjXmnjDZmbQbWo2C7eQ==
X-Received: by 2002:a05:6000:2087:b0:3ab:27f9:e51 with SMTP id
 ffacd0b85a97d-3b917e88a08mr2833511f8f.31.1755098627021; 
 Wed, 13 Aug 2025 08:23:47 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0683045sm39507653f8f.41.2025.08.13.08.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 08:23:46 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:23:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, Bing Zhao <bingz@nvidia.com>,
 "Ori Kam" <orika@nvidia.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] app/testpmd: fix conntrack action query
Message-ID: <20250813082342.5086ab1e@hermes.local>
In-Reply-To: <20250812094323.712559-1-dsosnowski@nvidia.com>
References: <20250812094323.712559-1-dsosnowski@nvidia.com>
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

On Tue, 12 Aug 2025 11:43:23 +0200
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> RTE_FLOW_ACTION_TYPE_CONNTRACK handling was missing in a switch case
> which filtered action types which have action query support in testpmd.
> This prevented the conntrack query to succeed.
> 
> Fixes: 4d07cbefe3ba ("app/testpmd: add commands for conntrack")
> Cc: bingz@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
> ---

Applied to next-net
