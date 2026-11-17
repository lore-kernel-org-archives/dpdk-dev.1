Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9BA606A32C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gI+IgJdG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AAF2402BF;
	Tue, 17 Nov 2026 18:04:40 +0100 (CET)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTPS id 18158402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:04:39 +0100 (CET)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cdb2893531bso73846a12.1
 for <dev@dpdk.org>; Tue, 17 Nov 2026 09:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794935078;
 x=1795539878; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1bJJivcvbRh1Wxl7SnAosdA2t+8StDwcQMURvzb6/mE=;
 b=gI+IgJdGuk/7z4OHluBGqNMED4kwKCrf4f4CfSbhrkcFBvIN7zKplkTnPQ7aI0dSmP
 DesLzDYR601LaR/sM5IKvLCnECLYHOvE9Mvs/Ph+0RyVDRjmcDijyA/0d3BRrss3Njem
 egba6oV0aXYrWBrFfUJcVex3GL6Na8sFxdj86zk7AJhcLwziRY7gv6EfjK/9XMqXi1JX
 NwHGtX9jDc5xT7wLirZyjVrlfxgvOSjaY3+ZzAN0cdgEDvVxeuEz37eD3r1S6ZYfHPNe
 Spc3zHwvHqY/tWry1/LOwOH9qPgYi0gIeUdzymDr/ZMJDY60vV7EV4d10a8SMPAT0yD4
 dYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794935078; x=1795539878;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1bJJivcvbRh1Wxl7SnAosdA2t+8StDwcQMURvzb6/mE=;
 b=F3bQ2C8WSsuEnD31Wieiba3yZtn0GjWJ0enyFEjh9LvK3LXASFdP3nNXCZrqSlz3lU
 8NLltLJcM0CdT+ZozKHqE1O0Rq9lnCy5zUmkAOJPR2yzNUB5cgcOrOS8oQGnFk98k23D
 b8TXBYRPM+pX53o/x/Vve8+nzNrVZzaSyxIfrPsHmpRFuAuSoio/GIG86L7pVjJ3RRW8
 Mat8859yUYJ9wjszvRIQzX2gYKqhaBtRN3prTO7jm8w4rVCAtm2Y6ZdsekW73l/Xw0LO
 5nVU35QuHLORvYX0veiYt+JrjAwu1ffmCVU+epTfGeMsI3jMABW66+lSSnBrs22C+14s
 m+Nw==
X-Gm-Message-State: APuU4Z8ZJAjM0rPllJhjS8hV0LHiOKi0e++vFOLWcbqcZZW/VU2z1CZZ
 HC1NCf4SzfyS/nn2JYY230cWVwThVGHEdMQ7lnVs0qvAyqe3pPGjYPvBFshFSYo3VLJO3deF4Zk
 97AsSmcU=
X-Gm-Gg: AZFdTZc3CNVYK5Td9gTO4allIFeOSUaluNPGOB3oSoY7w74R9jJ3ktTkqQ1MGtBr3Gx
 Gal14Ih69qwQjfcy54ruVg2d8tDNoLZ+VY/kMv/vdY8FermJa85FpikqhIuPKAH68QdEsb9fIsZ
 j7Ef2mtaWKn/oH+pJIKi5Dxr+vPZXSKp6YWhpcCpBX3hnNjxk05mel9GSgS2pnOcgWxf/51GcN6
 DA2kx/ELN7hxDUAKcdAmVrX3sQSA+9wSPkdoTcJsk8WpYNLJNWI1VEcVx6B2GwPqvodCLSpwp/M
 RW1MsL3bEpcfBsCqQ6qKNKS2m7/ocs0BThuvP7eTeC4aPrNiOVk9YneRchfu3zd5r3DPqGOg2hH
 0uijPqt64IaEJXUm0yU9vudKPLL2uCLuHbqW838uyU+ARSBgkg4QwF2dD7X2gGChwzwDROngLTV
 A6czUf0k4+C+ef/ziaOEEtG7rThXgDXztm4eyDUiYS8zbZFWfvwv28SER9Atuk8UP9f6xCUBadW
 zXIxnrO5JiH4GhoUBWgyVEB0z8qATzCNwZcqO2c0S/KBYsred4Wm1PG7xzkATBd6WV3mKoRRx0M
 2HJCi3qno6gSKax8P9u0aVXsohHUMZ90YKHuaFhqNszWfFvCazDNc9yl5bVUIKDZG5+QvGSdWKC
 qxrhMeMSB2Y/0G5iths4=
X-Received: by 2002:a17:90b:55c7:b0:3b0:d0c5:c110 with SMTP id
 98e67ed59e1d1-3b3d07c6131mr45200a91.56.1794935078126; 
 Tue, 17 Nov 2026 09:04:38 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b39d73c9sm12130493a91.2.2026.11.17.09.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:04:37 -0800 (PST)
Date: Tue, 17 Nov 2026 09:04:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Renyong Wan" <wanry@yunsilicon.com>
Cc: <dev@dpdk.org>, <nana@yunsilicon.com>, <qianr@yunsilicon.com>,
 <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>
Subject: Re: [PATCH v4 0/3] net/xsc: fix issues reported by GCC analyzer
Message-ID: <20261117090432.5fe1115b@phoenix.local>
In-Reply-To: <1794914060.606144@yunsilicon.com>
References: <1794914060.606144@yunsilicon.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 19:14:20 +0800
"Renyong Wan" <wanry@yunsilicon.com> wrote:

> v4:
> - free the jumbo buffer only when the last representor stops the device, it
>   is shared by every port and their Rx queues still point at it
> 
> v3:
> - free the jumbo buffer in xsc_dev_close(), the device removal path does not
>   go through xsc_dev_uninit()
> - drop the redundant parentheses reported by checkpatch, no functional
>   change
> 
> v2:
> - address the AI review of v1: allocate the jumbo buffer once per device,
>   fail the queue setup when there is no IOVA, and free it on device close
> - fix the leak in xsc_dev_init() and the unchecked rte_malloc_socket()
> - rename the jumbo buffer fields, they held the opposite of what their
>   names say
> 
> Renyong Wan (3):
>   net/xsc: fix jumbo buffer allocation and leak
>   net/xsc: fix leak and missing null check
>   net/xsc: rename jumbo buffer fields
> 
>  drivers/net/xsc/xsc_dev.c    | 17 ++++++++++--
>  drivers/net/xsc/xsc_dev.h    |  4 +--
>  drivers/net/xsc/xsc_ethdev.c |  6 ++++
>  drivers/net/xsc/xsc_rx.c     | 53 ++++++++++++++++++++----------------
>  4 files changed, 51 insertions(+), 29 deletions(-)

Too late for 26.11 but added to next-net to be picked up in 27.03
