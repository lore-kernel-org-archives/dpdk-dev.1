Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D746BFD45F9
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 22:36:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A17E40279;
	Wed, 25 Feb 2026 23:36:21 +0100 (CET)
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
 by mails.dpdk.org (Postfix) with ESMTP id 61B66400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 23:36:20 +0100 (CET)
Received: by mail-dl1-f65.google.com with SMTP id
 a92af1059eb24-126ea4e9694so501105c88.1
 for <dev@dpdk.org>; Wed, 25 Feb 2026 14:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772058979;
 x=1772663779; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1toKF3/U9tMm9f0gIBEnZyPenpWU6pOm1dA7rihFY64=;
 b=htiIWTqq7mPXaADPgcevBKPCyTqAzctJiBQwspbymZVzQUZ5XDczVsVBFpdwekEhLH
 vvmAnNTSF+oPZRK8/0lCmUHwXI7j3qk1Mx8SL73XFIIHl7kab1qXVXQ+iDwIWIezMR/w
 SVsqjJRZU1qOpdSpSytvYX0jjszHvMfYvkarkyWAoWW6vbbiNPe3lDv6Jv/wJ4pupGfR
 dk5QDMKqcyeWJ5Ri5Natcv2Z4x2cLrVv/AsALfxAHMW4hjbJcTRN8hizG9g0nH9YhlP3
 jc3QX0DBE3ahtGHj2owRS6Iv+ESURgvX0OT5SYxLeQMxALOaKnZOZyFrOYC0zVYLd8Yz
 4hQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772058979; x=1772663779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1toKF3/U9tMm9f0gIBEnZyPenpWU6pOm1dA7rihFY64=;
 b=DTQI+ufkqiJ3eNMJz1k5xIRFU17iMybBfkOXVbg8OiXsqM+s5KWD2grlshKTZSfxft
 jEyt4JMeq4UQXDg2PYOoCAZOndvE28A7IEgw9toG1cXNVa6UdNrjuLjD4yLqim9w5Gs/
 uEyvAPkZgSpZsM5G86MZ1FJtw/Q0Yff+otlKYHPAf+mCd6jAL1rYl8y59fD3tBgDyaYe
 WNTJN+0pK3ZQLfh7TFg7xZ7Tr8W7xTy3b5BWStf8j6VzCRq07pHRga8rnrbjQBcDcIph
 E7S63QlhEPLZ6QIXNm6BkoAamTIghlRYmAx5XpIEOVHPSwfYedxjdYydJIEmJbJAszmh
 J4zQ==
X-Gm-Message-State: AOJu0YxOsU39+4TzhiIR8k83ctPyivSs+JWy2W04UcoCmz7NigLocp1D
 9mD9Vo2AofXyoMueRRCU+dezG5+ZEVFk0vsK0gBPgTeAS9ABYp8ACVONZvBVIyvmJmg=
X-Gm-Gg: ATEYQzwxluT56ZSGgvdbs6/zL4SnpzBQiDWwnkLURrQLhdRHsyWU183TLmhPbDdUs+Z
 I+TAoI0jDBmp2ccMZqu0qTisQukOlM1GFkN2LUPWrSVd7U7NtVfnVwFaE1vfsrVHCARt/JUIiKr
 jFtHVYJSSFk+x0LhdlTsRJtfuAGLLfYx0bvDAQMh66DZaq6iWn6xq48qQzPu5sZkPn28a7ukP+p
 0jLzrAAJWEdqcHYjg7tbcslFXKFzQalZKQykk/DX6x2Avv9txtTjbgayZwroI9c5RYNCPs9/J5R
 nmD5C+Uvgoog4e0fqiLCkpWswRawEoxC2It60XpkCr8q2qZrNvOZDgfLyM0FxN70LVDgn1HPUI3
 u1zhcjg6W1h6KLD2buOl8xQ7iabbcMNiWQfY/DPdeHda4bUfmzfmuDjqV0PwJuIwcY+qL0vZAqb
 Vs0SJAwq1S1q0lx4yOFL7+mnaethlOZKk8sGLfPBAxSZYuopZUhN8LSENnzBop3qSa
X-Received: by 2002:a05:7022:b8d:b0:127:33e0:ea44 with SMTP id
 a92af1059eb24-1276ad1b5e8mr8546270c88.29.1772058979236; 
 Wed, 25 Feb 2026 14:36:19 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f48c77sm367557eec.26.2026.02.25.14.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:36:19 -0800 (PST)
Date: Wed, 25 Feb 2026 14:36:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linux.microsoft.com
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, stable@dpdk.org, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Long Li <longli@microsoft.com>
Subject: Re: [PATCH v3 0/7] fix multi-process VF hotplug
Message-ID: <20260225143616.581a8aeb@phoenix.local>
In-Reply-To: <20260225020246.890306-1-longli@linux.microsoft.com>
References: <20260225020246.890306-1-longli@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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


This patch is generally in good shape. Using the AGENTS.md and AI review
did see some things that should be addressed. As always take look
at AI review with a skeptical mind; some of this it being overly
picky...

 A few findings from review:

Patch 1/7 (netvsc race conditions):

    netvsc_hotplug_retry: hn_vf_add() return value ignored. The newly
added call at line 675 doesn't check the return. A failed VF attach
during hotplug retry would be completely silent =E2=80=94 at minimum log the
error. hn_vf_add_unlocked: goto detach after -EEXIST tears down the
original attachment. When hn_vf_attach() returns -EEXIST (already
attached) and a subsequent configure/start step fails, hn_vf_detach()
unregisters the callback and clears vf_attached/vf_port from the
original successful attachment. This leaves the VF port with an owner
but netvsc thinking it's detached. Consider skipping hn_vf_detach()
when the attach was an -EEXIST rather than a fresh attach. Version
notes (v2/v3 changelog) are above the --- line and will be included in
the permanent commit message. Move them below ---.

Patch 2/7 (multi-process VF removal):

    eth_hn_remove: MP infrastructure torn down before device cleanup.
The counter decrement and netvsc_uninit_once() (which frees the shared
memzone and unregisters MP handlers) happen before the device is
closed. If a pending hn_remove_delayed alarm fires after the memzone is
freed, netvsc_mp_req_vf() dereferences netvsc_shared_data (freed
memory) when checking secondary_cnt. Suggest moving the counter
decrement and uninit to after device close/release. Secondary init
failure leaves netvsc_shared_data dangling. If
netvsc_mp_init_secondary() fails, netvsc_shared_data still points to
the memzone but init_done is false. Consider clearing it on failure.
Same version-notes-above---- issue as patch 1.

Patch 3/7 (mana PD leak):

    PD deallocation order. ib_parent_pd is freed before ib_pd. If
there's a parent/child dependency (as the naming suggests),
deallocating the parent first will fail with EBUSY. Consider reversing
the order: dealloc ib_pd first, then ib_parent_pd. Same version-notes
issue.


Patches 5-7/7 (fp_ops in secondary):

These look correct and well-placed (before the existing rte_mb()).

Minor note: the plain (non-atomic) pointer stores to rte_eth_fp_ops
fields could theoretically tear on ARM if a polling thread reads
simultaneously. This is consistent with the existing burst function
pointer pattern so not a regression, but worth keeping in mind.

Overall the series is in good shape. Items 2 and 4 are the most
important to address.
