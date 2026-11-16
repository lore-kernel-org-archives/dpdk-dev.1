Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B097606A32A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qOXrAVAj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E37084026F;
	Mon, 16 Nov 2026 19:46:57 +0100 (CET)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 95FD340150
 for <dev@dpdk.org>; Mon, 16 Nov 2026 19:46:56 +0100 (CET)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8b67f25e6e1so2098244b3a.0
 for <dev@dpdk.org>; Mon, 16 Nov 2026 10:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794854815;
 x=1795459615; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9ko/SSo/3Zrt8gI2AjUeDnLNvMKz+H877bLkdKNDsIw=;
 b=qOXrAVAjknoNhSKNvkx+jvnFEqVj8qz9f1d92JlAKGEaO0o4a1sKtXRcC/j4RV9dGr
 UEqyKKa9dJklga2B5fgnYScuhnGooIaW439z03YbEEE4GPEiHPb2sfmPjyiM3FWUnuEc
 6NoxOZZGfJP36wY2Ji5YQbCMMaK9ls126FtGvTxlIGmbwNY1CGtkKWfZnCQre880cipA
 2t8UBmTqlOub9OxApLhrAeeQBNglQljqP4QwKRBkm97zd/SNKfemM5wLyDWN6BHw1ob7
 utYqg4jNjPjKW1Q64Oi9oUM5vj3YKz8vxmLjpNNNj9MrpELd5iGRSLD/RgPSaHvRHerq
 sjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854815; x=1795459615;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ko/SSo/3Zrt8gI2AjUeDnLNvMKz+H877bLkdKNDsIw=;
 b=THNeoGmUinTRAa6MhM0aNUrE2ZUnJ8OnW+xLP6vRJ7AEsmVgP/ie8/0rNmVzJqZIcA
 bRvVPGXlMUH+/4ruW5v/U4cczUZIC0zAN/GkN8eiuSyIqkhaOaOPHYe6uvbtboi/kT00
 MGVd98dSzZOEP1nunCHtCI5HZbks8meHTIiBY5RaYcVhegMYxRgi+kriMeQ3RhDRQhOV
 b/FVMaIxvZEoYsWRSqGy+VtYTxM34dNs+/8xvRzQvLiGzwwhnp0eCLTffE25J4abbDhH
 Mjbc8F/vWdGy6XLojmPBI7S5EYgzIdWd4E7HVNvIcSV52LYuvHOSUaskraW74/VEoqYn
 2fFQ==
X-Gm-Message-State: APuU4Z9C+iYr77Bgazmi5YzHnepaDdrrgsdX1ywiVkVuWxhN3KtxlsBq
 46Zyk118a3b2KAvyYXeHdiJ1ZlCsOlaoh3W3/ev0+cb8KO5DW/JAWacsLB3zdUoFZ7ObxpXwuZE
 jL+Jr3UA=
X-Gm-Gg: AYBFou0I3YqFLVoJun7fga+I95nTlfd98/OrZfMQoW/OBCvVgW4stcaolk8HwOOudVn
 JpvFXrvHp7CXEDXxGdymCtSMNC3RSbr6qBltXhzkGRox42OBRqCB3wc+ykeHnGDwC1qKORE6s2l
 uZvtNV1zikO5fY26VyARe7XwLo/I/FseP0+EbMvxC+sbzlcxGLdmb0D4tXuB1SWFS3sR4i6pLpo
 PHHhMAaPRx/KKrFB6Q6C01Gvh5O/ck37SsjYUxXfJgY3FyHVr0DQjpH1y6mw8WrLd4COfura5hp
 uR2mmWPK9bFjE3NC9dtjW3XTKO2Y/m4MmMBPUrl8gO1WsLj3ilsO+woe89tv+EhCRJoIIeBP64p
 0U5LGNBC8MvPi9lgGQMW/OV0tAyWIKwDHjQ4dwQqR0HkXpRtw3DfxQNQ0koHvI2a38m128KXYNa
 CQdiyrzB98iyfFE8LMQon+Zm59vSZyrti/YHF0QuIcEsxgDdg1qtrGvZUbF7OaZIjekeAcKJCm/
 cBfForMySmsjhHdotesnkxErcFxDfwPs6DVvFLm8SgmImgYpCQrhiyHsJrXnVI3gCmS7KPHpBER
 D7ALNCFiIUZmELur+U0M4EBfW6KiH9rrztVYb9I0HkXO/M88JD5/APtYOjcMlu5lYAPTnnFUXg=
 =
X-Received: by 2002:a05:6a00:148e:b0:89f:7a1b:2bf4 with SMTP id
 d2e1a72fcca58-8beb5ba8d80mr10726206b3a.16.1794854814810; 
 Mon, 16 Nov 2026 10:46:54 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8bed2b190cfsm4012177b3a.51.2026.11.16.10.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:46:54 -0800 (PST)
Date: Mon, 16 Nov 2026 10:46:52 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Renyong Wan" <wanry@yunsilicon.com>
Cc: <dev@dpdk.org>, <nana@yunsilicon.com>, <qianr@yunsilicon.com>,
 <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>
Subject: Re: [PATCH v2 0/3] net/xsc: fix issues reported by GCC analyzer
Message-ID: <20261116104652.6db701e4@phoenix.local>
In-Reply-To: <179481232343.1639.15317349483624427514@yunsilicon.com>
References: <179481232343.1639.15317349483624427514@yunsilicon.com>
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

On Mon, 16 Nov 2026 06:58:43 -0000
"Renyong Wan" <wanry@yunsilicon.com> wrote:

> v2 addresses the issues raised in the AI review of v1:
> - allocate the jumbo buffer once per device, fail the queue setup when
>   there is no IOVA, and free it on device close
> - fix the leak in xsc_dev_init() and the unchecked rte_malloc_socket()
> - rename the jumbo buffer fields, they held the opposite of what their
>   names say
> 
> Renyong Wan (3):
>   net/xsc: fix jumbo buffer allocation and leak
>   net/xsc: fix leak and missing null check
>   net/xsc: rename jumbo buffer fields
> 
>  drivers/net/xsc/xsc_dev.c    |  2 ++
>  drivers/net/xsc/xsc_dev.h    |  4 +--
>  drivers/net/xsc/xsc_ethdev.c |  6 ++++
>  drivers/net/xsc/xsc_rx.c     | 53 ++++++++++++++++++++----------------
>  4 files changed, 39 insertions(+), 26 deletions(-)

Still has one AI reported error.

Subject: Re: [PATCH v2 1/3] net/xsc: fix jumbo buffer allocation and leak

Series applies to main and each commit builds with -Dwerror=true.
The allocation rework in 1/3 and the rename in 3/3 look right.
Patches 2/3 and 3/3 have no findings.

[PATCH v2 1/3] net/xsc: fix jumbo buffer allocation and leak

Error: the leak is not fixed. xsc_dev_uninit() is only called from
the probe error path in xsc_ethdev_init(), where the jumbo buffer
can never have been allocated (rte_zmalloc'd xdev, port never
started). The normal remove path is xsc_ethdev_uninit(), which does
not call xsc_dev_uninit(); it frees xdev directly:

	ret |= xsc_ethdev_close(eth_dev);
	xsc_dev_pct_uninit(priv->xdev);
	rte_free(priv->xdev);

So the buffer still leaks on every device removal. Free it there as
well (with 3/3 applied, jumbo_buf):

	ret |= xsc_ethdev_close(eth_dev);
	xsc_dev_pct_uninit(priv->xdev);
	rte_free(priv->xdev->jumbo_buffer_pa);
	rte_free(priv->xdev);

Calling xsc_dev_uninit() from xsc_ethdev_uninit() instead would run
xsc_dev_close() a second time, so the direct free is the simpler
fix. Keeping the rte_free() in xsc_dev_uninit() is harmless.

Update the commit message accordingly; "free it in xsc_dev_uninit()"
describes the path that does not run on close or removal.
