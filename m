Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB210CCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 16:55:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A673740693;
	Tue, 21 Oct 2025 18:55:31 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 23ED9402A1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 18:55:31 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2909448641eso944115ad.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761065730;
 x=1761670530; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzWIT6YVKO2etacqMBqyNFmXn2Qwke7lGM+mt3TN88E=;
 b=mRZnCUhJrqDCQ8qoxmkynckFYzkqW0bPwHHG2Y3UGSlcm/tFKttv0gIWEo8anVPQ5e
 lXgMx5Cs6yVRKRKe9zMnHhW9s9o+M/GM+yoOE7mZuCjYIam4wga9iSFeW8sIP+i6nY/D
 Nxm0MMr71DaFwoQrh9wbVaNBMPPdi2FptijMpngP3MiKZFcooyEU2hqb+CeyzJmr7Ehc
 psm8Rt6Wc7Xhxcj7Ucs8gLINUIvtlhtdXSoOhCe5JcKVgi9/VGGgHs3g+hWzgYMuRWJ6
 oUaGwWKAXN4zuKqNe7+YPer7IOCuowLYVU9aOmoQeD1XRNuXHXJAl4qhwTl1L8LmpCLe
 POxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761065730; x=1761670530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzWIT6YVKO2etacqMBqyNFmXn2Qwke7lGM+mt3TN88E=;
 b=weQ7Dt455rNkXgd/UxN/XUHlSxAs2/UBhuzISputiWiEB8FmabOWQfUnLhm7OLeb/k
 5xlxWiECBMgxOTGcmNyFIwKwrJVMr/2MTI1Vm2UvKiPyNdk2vMOfULafmyG/2iz/7jMy
 DVZOdDhF/1kfkXiYLwu+OmIC+GiFt6PQ8JQE97l8LhYe/pEX4IECtg4+15NWesGHkUxV
 iGP7TdFA73EyYSTPbKDd2R7oaE8yip0gSulACDgd9cXSj47Q64F84PIA7D0Q2lz7IS3T
 HJOWjfox3FlWRXMVquOwOyZpmFGyQx63LzLKkK275ACwaddm4b5hCiPq2Ob6YY0F1E2h
 EbLQ==
X-Gm-Message-State: AOJu0YxUpLPM2/UIoNDVOu1nog70t6H1JwKvHFUhC7yWRwa90O719j/q
 ZjFUG5eQ2/8272rxitqgWzei3fr6+grtGxYJANz2fCas2DfJy1wOFXo2tTNZwgRBIsVfkPnv7y4
 HWJ8zTeg=
X-Gm-Gg: ASbGncskIKITquZ1nie+3BMwtyafJP4vfKAFcOD2RXm31qoJbWlrlseqjfT2ZcdgB7S
 qac/n86BhdmzetJMlY/KHmS0LewkuUKK53QKvSd6gRCUUNPDrXZpTdWA8Tm/FbN7NdRBDrF6c0+
 V9oGLNcE1no1T+Xv5tV6A9uOtC1+4hSvoISQq/42+ImYw8meJUZf4cLOcLIGjZisODJaOlmb+bH
 xjo+FkjtZLGokmGPog86QQlC1QTMNMjwtcVW+K4pD2BUugnDpQWWSRJQErG7WNVtMbltiMiTGFo
 W2mTKDXnuu5RqwJ+cKcYMJqYflu9XP8coy1FnU45ptCvlbxG0/+IMBPzA8N7V7+MvNy1/vb8WiD
 GIcluKDVybYRSwnCzvPubUbOYPdmhbXQII/PBWXrq+JZ7+mONcC+tAuJHow30FJoE0zxTYgFeAX
 bfEbpDq+Ls/FlYOZxma9kIsGDB78D7EYnLQmlpLEa1/WkzuBjgcQ==
X-Google-Smtp-Source: AGHT+IGBuUymvB0kVKVYTDXtZxD4YpHHrsfBbxcLSg2u+dEMuy1UG9JgEvMyvwJT9aXsuGWHufyLFw==
X-Received: by 2002:a17:902:f707:b0:292:ffa2:776f with SMTP id
 d9443c01a7336-292ffa279b8mr5765085ad.14.1761065729936; 
 Tue, 21 Oct 2025 09:55:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebccf3sm114523135ad.1.2025.10.21.09.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:55:29 -0700 (PDT)
Date: Tue, 21 Oct 2025 09:55:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>
Subject: Re: [PATCH] net/enic: make local variable static
Message-ID: <20251021095527.14e721a3@phoenix.lan>
In-Reply-To: <20251015231106.876172-1-stephen@networkplumber.org>
References: <20251015231106.876172-1-stephen@networkplumber.org>
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

On Wed, 15 Oct 2025 16:11:06 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Avoid global variable name conflicts.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Queued to next-net
