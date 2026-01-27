Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB880D2F033
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 14:07:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 210BD40E27;
	Tue, 27 Jan 2026 15:07:30 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id C176840E0C
 for <dev@dpdk.org>; Tue, 27 Jan 2026 15:07:28 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so50969645e9.2
 for <dev@dpdk.org>; Tue, 27 Jan 2026 06:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769522848;
 x=1770127648; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6n5wlY+EF2dUITdzqqJFyGBW61ykjU7T3iJNPdOadRI=;
 b=VmL8zupdFctyxHY29u2scqokTQXHCZfA65y6Oq1GWue0ZMzjfkr3UIIWUcTvrrFedb
 ZVJI2RJ72KbauBO0tRZU4+VwLUD6Mr6RCeCT2kEQ1PCs7aAuya0KBDYEwRLt6sd1wAOJ
 FufNUdFRESqGxsTLD5Tf0EEfym8fkrUpWdnfYf82bFGg1zZU9WSqZAnboHGs0qsHcp7k
 zJDPCdeLK2+bObCLoo7ToGmsorBFSx+zeeAFE/1fiQeWCCFyhNcOPqlFd3jqpCT8qRVK
 NX0j+JZnIiW+xGWfDuizFrJNEq871L4PFLCbwIQlaHSv75txRSQKqAx6CC0eHRWnM3Jv
 PgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769522848; x=1770127648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6n5wlY+EF2dUITdzqqJFyGBW61ykjU7T3iJNPdOadRI=;
 b=W9Y6AWn3zgG1D/XjpgSLa4xdLWYiGp0E2hV396lZBeV6oXH3r2rWNIoQHAwQUHdwRC
 0oiOB+Osv0li0MIrulfOSB5bQYgXfPY06PYv2ACeeKyzO30FbJ1H0+h1o8LTnI5Oup3x
 4vXZNBiX1AeESrx4qEf7vmaahIjDHl+dFhULyeIgmfAL3faXWLkt/mlSTF/1x2MDYF62
 tvqytPccc0vylsyn+2gIA249YZisxgfmLY+qIW7iBpDN5TnfEtqbP57kt0u81osrbqtO
 lwjmD589q3gldpeKcCjSM1QWqCMwQGXTzhvUZAeJSXZZTOZIaiJ5uOAdFQp5PLSr5AV2
 a7gQ==
X-Gm-Message-State: AOJu0Yxl3EMm4cnvhK7DiaQ9qf/DYUyJj6v4f8sjiXYvEhXzVLxCfBB5
 lc620/IvlxbKVVM+syAP5Jv4zxiA6OPdwYjLteCfu6f4erNg+9RqpkENBAxfki0o1p0=
X-Gm-Gg: AZuq6aILJahcm5hyXLvdXK0xpvz3bzvYcPoi1PXCRIi8NNIJYXkRlsJ+E5y8ps2dQvK
 PGgC0DfAW1y4Syg0QhLFsahW+BhfFgNdFpd+AwRL69zs74PUuCyu1lHserb9TTHoJv+z3LNhSqA
 mECQnFrAiQSUCavSIP7U12PG2eaLG4H5VTrRQX6dntchrcAd0bFgaFscmtURehjyLngZXjFc83e
 QnKRmNmLuG8NPM1HLX8dqDzAWYxFwBHza+t66/C1CeKZxVbIlobLxBF6BrPCACTOt3Jq6IyTkVo
 xyBUeeWEPusbclBu5A6hUTlrmvJWm+mN2yGp6gkJ0t0oIoTpClffsgEN7HzBLNSIm/TkBOFpgcZ
 /W4zGXPaEx1JGJCulGEJr+zR6jwPe7wbjuaApW3uZcr1Ke1Iw81TWhawik7p5bSliNcVgcbO9T5
 q3FOUf0QVfOi2wAclpY4MPvO2ZH//+dc0LiwCQ253YqYbo3MvRIj+K
X-Received: by 2002:a05:600c:e40b:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-4806a5bef0fmr17893515e9.36.1769522848134; 
 Tue, 27 Jan 2026 06:07:28 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806b8f45d2sm7326075e9.4.2026.01.27.06.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 06:07:27 -0800 (PST)
Date: Tue, 27 Jan 2026 06:07:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com, bruce.richardson@intel.com,
 mattias.ronnblom@ericsson.com, stable@dpdk.org
Subject: Re: [PATCH v16 1/2] eal: remove alloc_size from rte_lcore_var_alloc
Message-ID: <20260127060721.65d7dc96@phoenix.local>
In-Reply-To: <20260127052900.68045-2-scott.k.mitch1@gmail.com>
References: <20260127020246.53057-1-scott.k.mitch1@gmail.com>
 <20260127052900.68045-1-scott.k.mitch1@gmail.com>
 <20260127052900.68045-2-scott.k.mitch1@gmail.com>
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

On Mon, 26 Jan 2026 21:28:59 -0800
scott.k.mitch1@gmail.com wrote:

> From: Scott Mitchell <scott.k.mitch1@gmail.com>
> 
> The __rte_alloc_size(1) attribute on rte_lcore_var_alloc() is
> semantically incorrect and causes false positives with FORTIFY_SOURCE
> runtime checks.
> 
> The attribute tells the compiler that the function returns a pointer
> to 'size' bytes of usable memory. However, rte_lcore_var_alloc()
> actually returns a handle to a per-lcore variable scheme. The
> allocator internally allocates 'size' bytes per lcore
> (size * RTE_MAX_LCORE total), partitioned into per-lcore sections.
> The handle points to lcore 0's copy, and accessed via
> RTE_LCORE_VAR_LCORE(lcore_id, handle) which computes:
> handle + (lcore_id * RTE_MAX_LCORE_VAR). Access is expected
> beyond 'size' bytes beyond the returned pointer when 'lcore_id != 0'
> but FORTIFY_SOURCE may terminate the program due to out of bounds
> access.
> 
> This can be observed on CI with gcc 13.3.0 in lcore_var_autotest with
> '*** buffer overflow detected ***: terminated' if pointer provenance
> is preserved (e.g. if offsets avoid casting to uintptr_t).
> 
> Fixes: 5bce9bed67ad ("eal: add static per-lcore memory allocation facility")
> Cc: mattias.ronnblom@ericsson.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
