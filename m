Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E16C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 20:06:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95CA4402AB;
	Mon, 10 Feb 2025 21:06:34 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 4374F402A1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 21:06:33 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2f9b9c0088fso7623418a91.0
 for <dev@dpdk.org>; Mon, 10 Feb 2025 12:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739217992;
 x=1739822792; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iu9VYTfmYaHY6rRRFCagl7gQjdyUIcUhjpF/XtvriF0=;
 b=vPxp6G2xocAWEmPlSfonuyavXh+21QiCZasJUEhMtEgsk2fwnEKHkSgAWavzgVAYgW
 CxdUstfvhsWm0gl9f+agUvDBS8HLQtQssPO34KWiua53hRv2xGCsoJlIqCODelZGgBrN
 0hnZY20mICfB+OsYNE0jUbktvh7zWDnLPWa2QgpyCd3MMXfiCrivVKglKrPuWW4+E9ui
 AYOyhum5jYPndDnH7x6JiU/i7P0nrFQHvUGdTUwwlzHGJnk1Blo5gvdqimpiej8gnDcA
 wGKEvgUHIXA6nqf06vVKtAUu3u6h1RtE9SiKPxcvfZW0QrteFHBE+14MxIT12sTii7GV
 EfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739217992; x=1739822792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iu9VYTfmYaHY6rRRFCagl7gQjdyUIcUhjpF/XtvriF0=;
 b=pzQNNPat3e2u6prKvFWpe51NpUwpyw43lbo91VE+QLoDFQpgdZ6pHnFxNvExc9x5mp
 tHMpsXdJ7XCTM6xjBnSWXjFaTf85zn0eA3ClY65zxIRrRGfC0oqkJOPzLmG/Diq6vMNZ
 Qua8t0Y86A3Mn/dKjPBlnYpqrvtYcnT6KKZQreZCCavo+6cN5YCFeEEOJOPV2NyiRBY2
 clqrQ0c7X2Y9PHpZimCgUc4KliVAgEdB6qCnw356yVClh3lDMx6Ch8ZEVwRMrVgJpPn7
 CvcUWK0+1s/o2GO/399IHg/mi9cV/rwwqHNjmQ0eaREHKeQCegq+Yy+7KcbHG+g6ZdZU
 5WRw==
X-Gm-Message-State: AOJu0YwgUKFYHJZAP5GA35z3Y0qSLhegNknAlQjlCKJ2N0Gnvst6dP20
 zBD0afzMXnOffY/RQT+fvPwOSi8UarrM81h9JLPxDujVBFEVIFYwNjZ0ub7wGFY=
X-Gm-Gg: ASbGnctQT3njk/NbHXMbanSzCe+nB4F2SOtQMOvPmeITYiq2iRcmvvZeRNU97JwqP+8
 Eu7JsPKE/fR3fGumSIj75UL4VRWDSqkTFu+bfhn62jTmd/rO0n60utuSrlZ4kr77BAi8Joe+YNT
 gBdbTSz4VrHTLr7V3awaqtQf1kQOb8tyLOJjhBtvm5xZcToWBOkukm7jYN3YPiQ7F+NrI14Kku3
 J0YN9Ejs9C/9K85YX9Se3FNtztE0X2QnxWnBl07c1to2ftpb24fvzfs2VGWT7nFj7g60Bbyn0Ow
 zX6dHOWWR5ehISSaWeYKj+DCJrHWCB694Vf88Yvso6KUMiU6hfLoupymoWOhgsd+zfZ7
X-Google-Smtp-Source: AGHT+IGNHfNIpN/ZyblKtxlWDxcKn2I4XFMmqrISD3NoMofF5y2DbcGfnj+WaMf5iEX56lV+wMv92A==
X-Received: by 2002:a17:90a:3948:b0:2fa:9c9:20a3 with SMTP id
 98e67ed59e1d1-2faa041cc2emr1146174a91.0.1739217992161; 
 Mon, 10 Feb 2025 12:06:32 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee31sm8972126a91.34.2025.02.10.12.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:06:31 -0800 (PST)
Date: Mon, 10 Feb 2025 12:06:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Hai <haijie1@huawei.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <ferruh.yigit@amd.com>,
 <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <huangdengdui@huawei.com>
Subject: Re: [PATCH 0/2] net/hns3: bugfix on hns3
Message-ID: <20250210120629.7e02aaee@hermes.local>
In-Reply-To: <20250210030113.1154709-1-haijie1@huawei.com>
References: <20250210030113.1154709-1-haijie1@huawei.com>
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

On Mon, 10 Feb 2025 11:01:11 +0800
Jie Hai <haijie1@huawei.com> wrote:

> Fix some possible failure on hns3 driver.
> 
> Dengdui Huang (2):
>   net/hns3: fix possible copper port initialize fail
>   net/hns3: fix possible reset timeout
> 
>  drivers/net/hns3/hns3_cmd.c    | 18 ++++++++++++------
>  drivers/net/hns3/hns3_cmd.h    |  4 ++--
>  drivers/net/hns3/hns3_ethdev.c | 29 ++++++++++++++++++++++++++++-
>  3 files changed, 42 insertions(+), 9 deletions(-)

Added to next-net
